function pullDown() {
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById('add-tax-price');
  const profit = document.getElementById('profit');

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    addTaxDom.innerHTML = inputValue / 10
    profit.innerHTML = inputValue - addTaxDom.innerHTML
  })

}


window.addEventListener('load', pullDown)




