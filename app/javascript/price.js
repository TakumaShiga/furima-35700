function price () {
  const itemPrice = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const itemProfit = document.getElementById("profit");
  itemPrice.addEventListener('input', (e)=> {
    const inputValue = itemPrice.value;
    addTaxPrice.innerHTML =  Math.floor(`${inputValue * 0.1}`)
    itemProfit.innerHTML = `${inputValue - addTaxPrice.innerHTML}`   
    e.preventDefault();
  }); 
};
window.addEventListener('load', price);