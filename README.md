# 🧠 MindVault AI – Semantic Knowledge Retrieval System

> “Never forget what you’ve learned.”  
> An AI-powered personal memory engine that lets you **search your thoughts, notes, and files using natural language**. Built for **students, professionals, and researchers** who want to retain knowledge and boost productivity.
> 

<img width="850" height="356" alt="Image" src="https://github.com/user-attachments/assets/8f8384ca-aefc-4cbc-88ca-8262efe9a7d2" />


---

## 🚀 Features

✅ **Semantic Search** – Ask “What did I learn about Kubernetes last week?” and get relevant snippets from your own data  
✅ **LLM Integration** – Uses OpenAI embeddings + LangChain for smart semantic memory retrieval  
✅ **Data Privacy First** – All data stays **local**, no cloud sync, full user control  
✅ **Interactive Dashboards** – Built with Streamlit to show learning trends, behavior clusters, and content insights  
✅ **OCR Support** – Upload images or PDFs; we extract and index the content  
✅ **FastAPI Interface** – Optional lightweight API for real-time querying and integrations

---

## 📊 Architecture Overview

<img width="850" height="420" alt="Image" src="https://github.com/user-attachments/assets/2418b3f9-3f06-438e-9acf-6c8b96ca2881" />

- **Frontend**: Streamlit dashboards for interaction and visualization  
- **Backend**: Python + FastAPI with NLP/embeddings pipeline  
- **Database**: ChromaDB for vector storage & retrieval  
- **Data Pipeline**: OCR → Preprocessing → Embeddings → Index → Semantic Search

---

## 🔧 Tech Stack

| Component        | Tools Used                                                                 |
|------------------|----------------------------------------------------------------------------|
| **Programming**  | Python, Pandas, NumPy, LangChain                                           |
| **NLP**          | OpenAI Embeddings, Sentence Transformers, Keyword Extraction              |
| **Vector DB**    | ChromaDB                                                                  |
| **Search**       | LangChain, Semantic Query Matching                                        |
| **Dashboards**   | Streamlit, Plotly                                                         |
| **APIs**         | FastAPI                                                                   |
| **OCR**          | Tesseract, Pytesseract                                                    |
| **Versioning**   | Git, GitHub                                                               |

---

## 🧪 Use Cases

- 👨‍💻 Developers recalling past solutions from docs/emails
- 📚 Students organizing notes into searchable knowledge
- 🧠 Productivity geeks turning scattered info into searchable memory
- 🧾 Analysts querying meeting notes, reports, and financial docs semantically

---

## 🏗️ Project Structure

```

MindVault-AI/
├── README.md
├── LICENSE
├── requirements.txt
├── setup.py            # If packaging as a Python package
├── data/
│   ├── raw/            # Unprocessed user notes, PDFs, emails etc (sample or dummy data)
│   └── processed/      # Cleaned and vectorized data
├── notebooks/          # Jupyter notebooks for prototyping and experiments
├── src/
│   ├── data_processing/
│   │   ├── __init__.py
│   │   ├── ocr.py       # OCR code for extracting text
│   │   ├── embeddings.py # Code for generating vector embeddings
│   │   └── preprocessing.py
│   ├── semantic_search/
│   │   ├── __init__.py
│   │   ├── search.py    # Core semantic search functionality
│   │   └── langchain_utils.py
│   ├── api/
│   │   ├── __init__.py
│   │   └── fastapi_app.py  # FastAPI app for serving queries
│   └── visualization/
│       ├── __init__.py
│       └── dashboard.py  # Streamlit dashboards
├── tests/               # Unit tests
│   ├── __init__.py
│   └── test_search.py
└── docs/                # Project documentation and design notes


```

---

## 💼 Business Impact

> **Why this matters:**  
>  Knowledge workers spend 20–30% of their week searching for previously seen content. MindVault AI minimizes this cognitive load, enabling better knowledge retention, faster recall, and productivity gains.

---

## 🔍 Sample Query Examples

```

> What did I learn about anomaly detection last month?
> Show me notes related to "churn prediction"
> Summarize PDF about AWS Redshift architecture

````

---

## 🛠️ Setup Instructions

```bash
# 1. Clone the repository
git clone https://github.com/yourname/MindVault-AI.git
cd MindVault-AI

# 2. Create virtual environment
python -m venv .venv
source .venv/bin/activate  # or .venv\Scripts\activate on Windows

# 3. Install dependencies
pip install -r requirements.txt

# 4. Launch the Streamlit app
streamlit run src/visualization/dashboard.py
````

---

## 📌 TODOs (Ongoing Dev)

* [ ] Add user authentication
* [ ] Real-time document ingestion (e.g., auto-index new files)
* [ ] Integration with Notion / OneNote / Google Drive (optional)
* [ ] Mobile-first responsive layout

---

## 📫 Contact & Credits

Created by [**Rahul Ambaragonda**](https://www.linkedin.com/in/rahulambaragonda)
Contributions welcome — feel free to raise an issue or PR.

---

## 🔒 Disclaimer

MindVault AI is a personal memory assistant. Your data stays on your machine unless explicitly shared.

---



