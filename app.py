from logging import PlaceHolder
from requests import get
from bs4 import BeautifulSoup as bs
from sys import exit

brand_page_link = input("Page link: ")
brand = input("Brand: ")

proxy = {"http": "http://141.95.122.232"}

sample_product_data = {
    "ID": "PLACEHOLDER",
    "Type": "simple",
    "SKU": "PLACEHOLDER",
    "Name": "PLACEHOLDER",
    "Published": 1,
    "Is featured": 0,
    "Visibility in catalog": "visible",
    "Short description": "",
    "Description": "",
    "Date sale price starts": "",
    "Date sale price ends": "",
    "Tax statux": "taxable",
    "Tax class": "",
    "In stock?": 1,
    "Stock": "",
    "Sales price": "PLACEHOLDER",
    "Regular price": "PLACEHOLDER",
    "Categories": "Parapharmacie, Marques > " + brand,
    "Tags": "",
    "Images": "PLACEHOLDER"
}

try:
    brand_page = get(brand_page_link)
except:
    print("ERROR: Invalid link.")
    exit()
    
brand_page_html = bs(brand_page.text, "html.parser")

brand_page_pagination = brand_page_html.find("div", class_="pagination")
brand_num_of_pages = int(brand_page_pagination.find_all("a", class_="pagination-link")[-1].find("span", class_="").text)

for i in range(1, brand_num_of_pages + 1):
    page = get(brand_page_link + f"?p={i}")
    page_html = bs(page.text, "html.parser")
    
    product_as = page_html.find_all("a", class_="absolute-link product-link")
    
    product_links = []
    for a in product_as:
        product_links.append(a["href"])
        
    for link in product_links:
        product_page = get(link)
        product_page_html = bs(product_page.text, "html.parser")
        
        print(product_page_html.prettify())
        
        product_name = product_page_html.find("div", class_="product-summary-title")
        print(product_name)
