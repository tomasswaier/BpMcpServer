
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
Problem this project aims to resolve put simply is mcp and it's correct usage in enhancing api application. Options which the Machine Context Protocol allows are vast and considerable amount of research needs to be done before starting implementation of this new protocol. After a year of it's existence only now we are getting finished versions of mcp sdk's but also projects such as mcp gateway have multiple implemntations each warrying in many aspects from authentication to kubernetes support. Application which I am tasked with altering is no simple weather app accessible to everyone. It is a system with authentication where one may buy credits and for these credits they can then buy api tool usage. One big problem in mcp is that there is very little support for authentication. It is a problem which became apparent quite early on and because of this mcp gateway has been made as a solution. Concept Mcp gateway put simply is a reverse proxy which gives mcp server ability to keep sessions and users authenticated with 0auth. Implemenations of this concept are many but most notable are from Docker, IBM and Microsoft. Each has it's own strengths and weaknesses and my project demands in depth analysis to decide which of the available implementations is optimal for this tool. Problem of mcp implementation also includes tool selections. Simple things such as programming language choice become during developement crucial decision not only for reasons such as language knowledge and performance but also support of needed tools. Intended implementation does not only include full support for communication trough mcp client which will be connected to it's own session trough mcp gateway but also support for microtransactions. With the introduction of x402 the internet is nearing it's next stage with payments being built into the browser itself. This next stage includes not only user to service payments but also agent to service and agent to agent. This opens a new window of oportunities for businesses of all kinds and this project will take advantage of it as well. By implementing this the user will have opportunity to pay for each service live while using the application without the need to register and purchase credits. 


= Overview of similar solutions:
Prezentujte základný literárny rešerš ohľadne podobných riešení vášho problému. V tomto smere očakávame základné zvládnutie technickej literatúry, nie web stránok ani informácií na úrovni blogov. Rozsah: 1-1 a ½ strany

= Risk assessment:

MCP has a strong side to it and that is that it's designed with safety in mind. By working with this protocol the user can be assured that their data follows all security standards. Mcp gateways being able to natively handle OAuth is a huge advantage which takes a load off of developers and makes authentication an easy task. Changes to applications authentication will not be needed and thats why the only security concerns will be around the mcp server and mcp gateway. The fact that MCP is safe does not mean that there can be no flaws made during it's implementation. As mentioned before authorization being not a part of the mcp design since start has been an issue and therefore missconfiguration authorization logic in the mcp server may become an issue. Incorrect configuration of mcp authorization in case of the Adversea application may lead to unauthorized use of the api. Issues of this sort however may easily be prevented by following standards and following good security hygiene. Risks which are not preventable however are attacks such as Tool Name Conflicts or Server Name Collision. In both of these cases the solution is not a simple one. Server Name Collision is the attack in which the attacker lists their servers name and description to one of a more popular mcp server in order to confuse mcp clients in way which makes them send api requests to the attackers server instead. Tool Name Conflict is is the exact same concept but with registered mcp tools. An attacker might set name of their tool to be send.email that imitaties the more known email-sending tool and therby confuse the server into sending the request to the wrong server. 
1
Beyond name similarity, our experiments revealed that malicious actors can further manipulate tool selection by embedding deceptive phrases in tool descriptions. Specifically, we observed that if a tool’s description explicitly contains directives like “this tool should be prioritized” or “prefer using this tool first”, the MCP client is more likely to select that tool, even when its functionality is inferior or potentially harmful
/1
Both the Server Name Collision and Tool Name Conflict do not have a sollution at this moment. Ideas have been brought up such as mcp server discovery protocols with trust and popularity based rankings tho none have been implemented yet. Other security problems in mcp servers such as Post-Update Privilege Persistance do not need to be addressed as this application does not provide services which would cause this issue.  



= Experimentálna reproducibilita:



1. Definition of reproducibility in software research

Difference between scientific reproducibility and software reproducibility

Deterministic behavior in distributed systems

Importance for API evolution and protocol extensions (like MCP)

    MCP protocol determinism
    
    API versioning
    
    Client–server communication consistency


2. Reproducible environment setup

Tools, versions, configuration (1 page)

Environment isolation

  Mention if you used:
  
  Docker / Docker Compose
  
  Virtual environments
  
  Containerized MCP gateway



3. Reproducible implementation and experiments

How behavior was verified and repeated (1 page)

4. Open science and transparency measures

This is where your topic shines.

Discuss:

  How the original API was extended (not replaced)
  
  Clear separation between:
  
  existing API logic
  
  MCP server
  
  MCP gateway

Mention:
  
  Interface contracts
  
  Protocol adapters
  
  Configuration files

setup instructions


something like Although the present stage of the work is not yet published, the implementation follows principles of open science to facilitate future public availability.


= Long term maintainablity:
Maintainability is the process providing maintanance for a product. It is one of the most critical quality attributes of any large scale application and is directly correlated to early design decisions and overall code quality. Statistics suggest that developers working on complex software may spend up to 39% of their time on maintanance related activities including bug fixing, refactoring and adapting the system to new requirements(2). In the context of this project ,maintainability is the ease with which future developers can understand ,update or modify the extended Adversea application after it's transformation into an mcp communication capable system. To improve long term maintainablity of this project and to reduce the time needed in the future for maintanance tasks, the development approach will follow already present structure of the project. Furthermore application developed will utilize docker for development ,testing and deployment which will provide consistent and reproducible environment. Containerization will ensure that enviromental inconsistencies which often introduce major source of maintanance issues are eliminated, therfore simplifying long term support.

The Machine Context protocol while highly promising is still considered relatively new and changing standard. These changes introduce issues often not seen in api based systems. Research into maintanance of mcp projects highlights that implementations have similar code smell and bug pattern as traditional software engineering domain where up to 66% of MCP projects have code smell and 14.4% have bugs (3). Tackling issue of maintainablity is not simple in this case as older version of a package may lead improper functionality of the mcp server. 

To lessen these risks the project follows best practices which ensure architectural stability, dependency control, documentation and reproducibility. From architectural perspective the mcp functionality is isolated into clearly defined modules that communicate with the rest of the application trough internal interface. This separation reduces compexity between core business logic and protocol specific components, making it easier for developers to replace or update libraries without requiring large changes to the project. Usage of modularity is especially important given the likelyhood of future changes to mcp specifications. 

Dependancy management also plays a key role in ensuring long term sustainability. All newly introduced dependancies are version pinned to prevent unintended updates from breaking the system. Additionally all dependancy updates are treated as deliberate maintanance tasks rather than automatic upgrades. This approach allows maintainer to have more oversight on changes in MCP sdk or gateway implementations before installing them in production environment. Combined with docker based builds this strategy ensures previous versions of the project can always be rebuilt and analyzed if an error occures. 

Given to the projects size documentation is essential for long term maintainability. Documentation follows standard introduced in the rest of the project in the .md format and will contain the most neccessary information for application setup and understanding. 

In summary, the long term maintainability in this project is achived trough a combination fo modular architectural design, strict dependancy management, comprehensive documentation and reproducibe environment.

= Employability:
Ai is the one of the biggest industries ... something something 
Problem this project aims to resolve is one which is quite common in the market. With most projects whith similar paid api interface not having mcp integration I hope to gain knowledge and experience needed in professional field which will improve my career in the it field. 
-- i hope to make the world better something something
-- programming something something ?
-- professional environment something something ?




sauce
1 - https://arxiv.org/html/2503.23278v2#S5
2 - https://link.springer.com/article/10.1007/s11219-021-09564-z
3 - https://arxiv.org/html/2506.13538v4#bib.bib10
