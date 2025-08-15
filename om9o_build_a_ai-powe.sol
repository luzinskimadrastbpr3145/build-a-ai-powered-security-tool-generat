pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract AIpoweredSecurityToolGenerator {
    using SafeMath for uint256;

    struct SecurityTool {
        string toolName;
        address creator;
        uint256 creationDate;
        string[] threatPatterns;
        uint256 trustScore;
    }

    SecurityTool[] public securityTools;

    // Mapping of threat patterns to their respective trust scores
    mapping(string => uint256) public threatPatternTrustScores;

    // Event emitted when a new security tool is generated
    event NewSecurityTool(address indexed creator, string toolName, uint256 creationDate);

    // Function to generate a new AI-powered security tool
    function generateSecurityTool(string[] memory _threatPatterns) public {
        // Calculate trust score based on threat patterns
        uint256 trustScore = 0;
        for (uint256 i = 0; i < _threatPatterns.length; i++) {
            trustScore = trustScore.add(threatPatternTrustScores[_threatPatterns[i]]);
        }

        // Create a new security tool
        securityTools.push(SecurityTool(
            "AI-powered Security Tool " + toString(securityTools.length),
            msg.sender,
            block.timestamp,
            _threatPatterns,
            trustScore
        ));

        // Emit event
        emit NewSecurityTool(msg.sender, "AI-powered Security Tool " + toString(securityTools.length), block.timestamp);
    }

    // Function to update trust score of a threat pattern
    function updateThreatPatternTrustScore(string memory _threatPattern, uint256 _trustScore) public {
        threatPatternTrustScores[_threatPattern] = _trustScore;
    }

    // Test case: Generate a new security tool with two threat patterns
    function testGenerateSecurityTool() public {
        generateSecurityTool(["Phishing", "Malware"]);
    }
}