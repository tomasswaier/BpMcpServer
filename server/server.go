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

type CarNumberPlate struct {
	NumberPlate string
}

type ApiResponse struct {
	NumberPlate string
	Name        string
	Phone       string
}

type Output struct {
	Name        string `json:"name" jsonschema:"Person who currently uses car with that numberplate"`
	PhoneNumber string `json:"phone" jsonschema:"Phone number of person with that numberplate"`
}

func getPersonInfo(ctx context.Context, req *mcp.CallToolRequest, input CarNumberPlate) (
	*mcp.CallToolResult,
	any,
	error,
) {
	result, err := apiTest(input)
	if err != nil {
		return &mcp.CallToolResult{}, nil, err
	}
	output := Output{Name: result.Name, PhoneNumber: result.Phone}

	return &mcp.CallToolResult{
		Content: []mcp.Content{
			&mcp.TextContent{Text: fmt.Sprintf("Name: %s, Phone: %s", result.Name, result.Phone)},
		},
	}, output, nil

}

func InitServer() {
	server := mcp.NewServer(&mcp.Implementation{Name: "Car database server"}, nil)
	mcp.AddTool(server, &mcp.Tool{
		Name:        "search_by_numberplate",
		Description: "Retrives name and phone number of owner of a car if you have their numberplate",
	}, getPersonInfo)

	if err := server.Run(context.Background(), &mcp.StdioTransport{}); err != nil {
		log.Println(err)
	}
}
func apiTest(input CarNumberPlate) (ApiResponse, error) {
	url := "http://localhost:8000/api/carPage"
	car := CarNumberPlate{
		NumberPlate: input.NumberPlate,
	}

	jsonData, err := json.Marshal(car)
	if err != nil {
		log.Println(err)
		return ApiResponse{}, err
	}
	resp, err := http.Post(url, "application/json", bytes.NewReader(jsonData))
	if err != nil {
		log.Println(err)
		return ApiResponse{}, err
	} else {
		defer resp.Body.Close()
		body, err := io.ReadAll(resp.Body)
		if err != nil {
			log.Println(err)
			return ApiResponse{}, err
		}
		var data ApiResponse
		if err := json.Unmarshal(body, &data); err != nil {
			return ApiResponse{}, err
		}
		return data, nil

	}
}

func main() {
	//testInput := CarNumberPlate{NumberPlate: "Sk132Sk"}
	//fmt.Println(apiTest(testInput))
	InitServer()
}
