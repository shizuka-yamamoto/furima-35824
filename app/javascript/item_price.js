function pullDown() {
	const priceInput = document.getElementById("item-price");
	priceInput.addEventListener("input", () => {
   const inputValue = priceInput.value;
   const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = (Math.floor(inputValue * 0.1));
		const profitNum = document.getElementById("profit");
			const value_result = inputValue * 0.1;
			profitNum.innerHTML = (Math.floor(inputValue - value_result));
})}

window.addEventListener('load', pullDown)