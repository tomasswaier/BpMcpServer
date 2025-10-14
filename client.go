package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strings"

	"os/exec"

	"github.com/modelcontextprotocol/go-sdk/mcp"
)

type OllamaRequest struct {
	Model  string `json:"model"`
	Prompt string `json:"prompt"`
	Stream bool   `json:"stream"`
	Tools  []Tool `json:"tools,omitempty"`
}

type Tool struct {
	Type     string       `json:"type"`
	Function ToolFunction `json:"function"`
}

type ToolFunction struct {
	Name        string                 `json:"name"`
	Description string                 `json:"description"`
	Parameters  map[string]interface{} `json:"parameters"`
}

type OllamaResponse struct {
	Response string `json:"response"`
	Done     bool   `json:"done"`
}

func main() {
	// Connect to your MCP server
	ctx := context.Background()
	client := mcp.NewClient(&mcp.Implementation{Name: "mcp-bridge", Version: "v1.0.0"}, nil)

	transport := &mcp.CommandTransport{Command: exec.Command("server/server")}
	session, err := client.Connect(ctx, transport, nil)
	if err != nil {
		log.Fatal(err)
	}
	defer session.Close()

	// Get available tools from MCP server
	toolsResult, err := session.ListTools(ctx)
	if err != nil {
		log.Fatal(err)
	}

	// Convert MCP tools to Ollama tools format
	var ollamaTools []Tool
	for _, tool := range toolsResult.Tools {
		ollamaTools = append(ollamaTools, Tool{
			Type: "function",
			Function: ToolFunction{
				Name:        tool.Name,
				Description: tool.Description,
				Parameters:  tool.InputSchema,
			},
		})
	}

	// Send prompt to Ollama with tools
	ollamaReq := OllamaRequest{
		Model:  "gemma2:2b", // or any model you have
		Prompt: "Please use the MagicWordTeller tool to get a magic word and then tell me what it is.",
		Stream: false,
		Tools:  ollamaTools,
	}

	jsonData, _ := json.Marshal(ollamaReq)

	clientHTTP := &http.Client{}
	resp, err := clientHTTP.Post("http://localhost:11434/api/generate", "application/json", strings.NewReader(string(jsonData)))
	if err != nil {
		log.Fatalf("Failed to call Ollama: %v", err)
	}
	defer resp.Body.Close()

	var ollamaResp OllamaResponse
	if err := json.NewDecoder(resp.Body).Decode(&ollamaResp); err != nil {
		log.Fatalf("Failed to decode Ollama response: %v", err)
	}

	fmt.Printf("Ollama response: %s\n", ollamaResp.Response)
}
