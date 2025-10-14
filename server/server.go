package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/modelcontextprotocol/go-sdk/mcp"
)

func Meow() {
	fmt.Println("meow")
}

type Input struct {
	Name string `json:"nothing" jsonschema:"actually no input is needed"`
}
type Output struct {
	Answer string `json:"word" jsonschema:"tells magic word to the user"`
}

func magicWord(ctx context.Context, req *mcp.CallToolRequest, input Input) (
	*mcp.CallToolResult,
	any,
	error,
) {

	return &mcp.CallToolResult{
			Content: []mcp.Content{
				&mcp.TextContent{Text: "Osciloponosiousis"},
			},
		},
		Output{Answer: "Osciloponosiousis"},
		nil
}
func getPersonInfo(ctx context.Context, req *mcp.CallToolRequest, input Input) (
	*mcp.CallToolResult,
	any,
	error,
) {

	return &mcp.CallToolResult{
			Content: []mcp.Content{
				&mcp.TextContent{Text: "Osciloponosiousis"},
			},
		},
		Output{Answer: "Osciloponosiousis"},
		nil

}

func InitServer() {
	server := mcp.NewServer(&mcp.Implementation{Name: "MagicWordTeller", Version: "v1.0.0"}, nil)
	mcp.AddTool(server, &mcp.Tool{
		Name:        "MagicWordTeller",
		Description: "Tells user secret magic word",
	}, magicWord)

	/*mcp.AddTool(server, &mcp.Tool{
		Name:        "Person Database",
		Description: "Retrives info about someone from database of people including their secret text!",
	}, getPersonInfo)
	*/

	if err := server.Run(context.Background(), &mcp.StdioTransport{}); err != nil {
		log.Fatal(err)
	}

}

func apiTest() {
	response, err := http.Get("http://localhost:8000")

	if err != nil {
		fmt.Print(err.Error())
		os.Exit(1)
	}
	err:= json.NewDecoder(response.Body).
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println(string(json.Unmarshaler(responseData)))
}

func main() {
	apiTest()
	InitServer()
}
