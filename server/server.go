package main

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"

	"github.com/modelcontextprotocol/go-sdk/mcp"
)

type Input struct {
	NumberPlate string `json:"numberplate" jsonschema:"needs a numberplate from the user"`
}
type CarNumberPlate struct {
	NumberPlate string `json:"numberplate"`
}

type Output struct {
	Answer string `json:"word" jsonschema:"tells magic word to the user"`
}

func getPersonInfo(ctx context.Context, req *mcp.CallToolRequest, input Input) (
	*mcp.CallToolResult,
	any,
	error,
) {
	result := apiTest(input)
	return &mcp.CallToolResult{
			Content: []mcp.Content{
				&mcp.TextContent{Text: string(result)},
			},
		},
		Output{Answer: "Osciloponosiousis"},
		nil

}

func InitServer() {
	server := mcp.NewServer(&mcp.Implementation{Name: "Card database", Version: "v1.0.0"}, nil)
	//mcp.AddTool(server, &mcp.Tool{
	//	Name:        "MagicWordTeller",
	//	Description: "Tells user secret magic word",
	//}, magicWord)

	mcp.AddTool(server, &mcp.Tool{
		Name:        "Car Database",
		Description: "Retrives name and phone number of someone",
	}, getPersonInfo)

	if err := server.Run(context.Background(), &mcp.StdioTransport{}); err != nil {
		log.Fatal(err)
	}

}
func apiTest(input Input) []byte {
	url := "http://localhost:8000/api/carPage"
	car := CarNumberPlate{
		NumberPlate: input.NumberPlate,
	}

	jsonData, err := json.Marshal(car)
	if err != nil {
		log.Fatal(err)
		return nil
	}
	resp, err := http.Post(url, "application/json", bytes.NewReader(jsonData))
	if err != nil {
		log.Fatal(err)
		return []byte("Something went wrong")
	} else {
		defer resp.Body.Close()
		body, err := io.ReadAll(resp.Body)
		if err != nil {
			log.Fatal(err)
			return nil
		}
		var data []map[string]any
		if err := json.Unmarshal(body, &data); err != nil {
			return nil
		}
		pretty, _ := json.MarshalIndent(data, "", "  ")
		fmt.Println(pretty)
		return pretty

	}
}

func main() {
	testInput := Input{NumberPlate: "Sk132Sk"}
	apiTest(testInput)
	//InitServer()
}
