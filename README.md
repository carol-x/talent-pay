# talent-pay
Reputation based talent hiring 1-stop shop 

Features: 

- view the decentralized info of the talents
- enter a contract through periodic payroll, private payment, and multi-coin payment

Integrations: 

- composeDB by Ceramic
- payroll contract by Scroll
- private bob stablecoin payment by zkBob
- token swaps by 0xLab

Deployed contracts: 
- Scroll Alpha Testnet: [0x339eE4F2bCc881F491293584e07273adb5B8c681](https://blockscout.scroll.io/address/0x339eE4F2bCc881F491293584e07273adb5B8c681)
- Metis Goerli: [0xB9BeE4189f0C02926eE2D546309131A75F9f469d](https://goerli.explorer.metisdevops.link/address/0xB9BeE4189f0C02926eE2D546309131A75F9f469d/transactions#address-tabs)
- Polygon privacy token: [0x45d88b3E872B0fc7864861fdB83f083C852C41f6](https://polygonscan.com/address/0x45d88b3E872B0fc7864861fdB83f083C852C41f6)
- Deprecated github repo due to memory corruption: [talent-pay-deprecated](https://github.com/carol-x/talent-pay-deprecated)

Explanation: 

Talent Pay offers builders a place to showcase their work and earn new commissions. We use a fully decentralized graph database from ComposeDB to link the background credential of the builders through their past involvements and commissions. Commissioners can use the talent space with the reputation information to pick their best talent. Talent Pay creates a decentralized space for the builders and commissioners to settle development demand and supply.

As a one-stop shop, Talent Pay includes comprehensive payroll support for the commissions. There are 2 options that builders may choose: pre-defined payment flow, or private one-time payments. The pre-defined payment flow allows commissioners to deposit the full amount in the builder-specific smart contract on L2s (Scroll and Metis) and specify the total periods. Builders choose the time interval that suite their financial needs. As the project continues, the builders receive periodic payment. For the second option, Talent Pay offers privacy through zkBob for both the commissioner and the builder when they agree on a project and its payment, so they may settle without the knowledge of third party. We believe that privacy is the most important part of on-chain lifestyle support, so we include zk solutions for the transactions.

Talent Pay also includes an in-app swap widget to facilitate easy swaps to suit token requirements. Builders may specify payment tokens, and the privacy option needs privacy tokens like the bob stablecoins. The swap is an important part of the one-stop shop for the payroll and talent management. We gladly have 0x labs supporting the API for the swaps.

Test it out and let's find talent and pay in a better way!
