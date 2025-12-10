
#set heading(numbering: "1.")

#show link: set text(fill: blue, weight: 700)
#show link: underline

Development of an MCP Server for an Existing Application with Available API

= Technical abstract
My project takes a deep dive into the machine context protocol, it's implementation, ecosystem and it's future. First I the intro

= Dummy abstract

= Introduction
Large language models have been the movingstone of society for the past 5 years. Their introduction brought us many advantages but for a very long time they had one fault and that is the use of third party tools. Presented solutions have not been the best for one reason or other till the Machine Context Protocol was introduced in November of 2024. Machine context protocol is a new field which is evolving quickly because of it's potential. It's way of adding llm the ability to interact with tools is unique from approaches used till now and it's simplicity has been the driving force behind it's popularity. The protocol itself being developed a year ago makes it an exciting new topic for both ai enthusiasts as well technical people in all fields. My project takes a deeper look into the protocols usage with heavy focus on server side. Task I aim to accomplish with this project is to explain how an api project may take advatage of this protocol and what it can gain. Discussed in later will be not only implemntation but also newest project mcp gateway and projects interacting with this protocol such as x402. My aim will be to change an existing application Adversea from a paid api service to an application able to respond to mcp calls but also use all of it's best features such as already mentioned mcp gateway. As there are many paid services on the internet many of which could benefit from the machine context protocol I will aim to present everything in a reproducible manner so that anyone may use this as guide to enhance their own free or paid tools.


= Problem definition
Problem this project aims to resolve put simply is correct mcp and it's correct usage in enhancing api application. Options which the Machine Context Protocol allows are vast and considerable amount of research needs to be done before starting implementation of this new protocol. After a year of it's existence only now we are getting finished versions of mcp sdk's but also projects such as mcp gateway have multiple implemntations each warrying in many aspects from authentication to how kubernetes support. Application which I am tasked with altering is no simple weather app accessible to everyone. It is a system with authentication where one may buy credits and for these credits they can then buy api tool usage. One big problem in mcp is that there is very little support for authentication. It is a problem which became apparent quite early on and because of this mcp gateway has been made as a solution. Concept Mcp gateway put simply is a reverse proxy which gives mcp server ability to keep sessions and users authenticated with 0auth. Implemenations of this concept are many but most notable are from Docker, IBM and Microsoft. Each has it's own strengths and weaknesses and my project demands in depth analysis to decide which of the available implementations is optimal for this tool. Problem of mcp implementation also includes tool selections. Simple things such as programming language choice become during developement crucial decision not only for reasons such as language knowledge but also support of needed tools. One new usecase I intend to implement is x402 usage directly trough mcp client. 
