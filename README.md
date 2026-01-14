# ClientVCL

## Overview

**ClientVCL** is a Windows desktop application built with **Delphi VCL**, designed to act as a client for a RESTful backend service.

The project focuses on demonstrating how a traditional VCL application can interact with modern backend APIs, following clear separation of concerns and using contemporary Delphi practices where applicable.

This is a technical and educational project, not a production-ready application.

---

## Purpose

The main goals of this project are:

- To demonstrate a Delphi VCL client consuming REST APIs
- To show basic client-side organization and responsibilities
- To complement the backend project (**ServerHorse**) within a cohesive portfolio

---

## Key Features

- Windows desktop application using **VCL**
- Consumption of REST endpoints
- Clear distinction between:
  - UI layer
  - Service / API access layer
  - Domain or data structures
- Simple and readable implementation focused on clarity

---

## Architecture (High-Level)

The application follows a straightforward layered approach:

- **UI Layer**
  - Forms and visual components
  - User interaction and input handling

- **Service / API Layer**
  - REST client configuration
  - HTTP requests and responses
  - Basic serialization and deserialization

- **Domain / DTOs**
  - Data structures representing backend entities

This structure keeps the UI decoupled from the API communication logic.

---

## Technologies Used

- Delphi (RAD Studio – modern versions)
- VCL framework
- Delphi REST Client Library
- Windows platform

---

## Project Structure (Simplified)

ClientVCL/
├── ClientVCL.dpr
├── ClientVCL.dproj
├── MainForm.pas
├── MainForm.dfm
├── Services/
│ └── ApiClient.pas
├── Models/
│ └── *.pas
└── README.md


> Folder names may evolve as the project grows.

---

## Requirements

- Windows
- Embarcadero Delphi (RAD Studio) — modern version recommended
- VCL framework
- Backend service available (see **ServerHorse**)

---

## How to Run

1. Open `ClientVCL.dproj` in Delphi
2. Ensure the backend service is running
3. Configure the API base URL if required
4. Build and run the application
5. Use the UI to trigger API requests

---

## Scope and Limitations

- The UI is intentionally simple
- Error handling is minimal and focused on demonstration
- Authentication and advanced state management are out of scope
- Not intended for production use

---

## Related Projects

This repository is part of a Delphi portfolio composed of multiple independent projects:

- **HelloModernDelphi** – Modern Delphi language feature examples
- **ServerHorse** – REST backend service built with Delphi and Horse

Projects are maintained as separate repositories and connected via a portfolio aggregator.

---

## License

This project is provided for educational and demonstration purposes.
