const contractAddress = "CONTRACT_ADDRESS"; // Replace with the actual contract address
const abi = [...]; // Replace with the actual ABI

const web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545")); // Replace with the actual Ganache URL
const votingContract = new web3.eth.Contract(abi, contractAddress);

async function vote() {
    const option = document.getElementById("option").value;
    if (option.length === 0) {
        alert("Option cannot be empty");
        return;
    }

    try {
        const accounts = await web3.eth.getAccounts();
        await votingContract.methods.vote(option).send({ from: accounts[0] });
        alert("Vote submitted successfully!");
        updateResults();
    } catch (error) {
        console.error("Error submitting vote:", error);
        alert("Error submitting vote. Check the console for details.");
    }
}

async function updateResults() {
    const resultContainer = document.getElementById("result-container");
    resultContainer.innerHTML = "";

    // Fetch and display vote results
    const options = ["Option1", "Option2", "Option3"]; // Replace with your actual voting options
    for (const option of options) {
        const count = await votingContract.methods.getVoteCount(option).call();
        const resultElement = document.createElement("div");
        resultElement.innerHTML = `<strong>${option}:</strong> ${count} votes`;
        resultContainer.appendChild(resultElement);
    }
}

// Initial update of vote results
updateResults();
