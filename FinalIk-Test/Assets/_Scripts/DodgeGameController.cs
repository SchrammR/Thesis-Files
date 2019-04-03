using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


public class DodgeGameController : MonoBehaviour
{
    public int score = 0;
    public Text pointsText;
    public MeshCollider playerCollider;
    public BoxCollider hazardCollider;
    public bool gameIsStarted = false;
    public GameObject hazard;
    public float roomSizeX, roomSizeY, roomSizeZ;

    public int hazardCount = 0;

    void Start()
    {
        pointsText.text = "Punkte: " + score;
    }

    void Update()
    {
        if( gameIsStarted){
            pointsText.text = "Punkte: " + score;
            //in intervall random
            if(hazardCount < 3){
                createHazards(new Vector3(Random.Range(roomSizeX, -roomSizeX), Random.Range(0, roomSizeY/2), 0), new Vector3(1, 1, 16));
            }
        }
    }

    private void createHazards(Vector3 coordinates, Vector3 size){
        GameObject hazardInstance;
        hazardInstance = Instantiate(hazard, coordinates, Quaternion.identity);
        hazardInstance.transform.localScale = size;
        hazardCount++;
    }





    public void addPointsToScore(int points){
        this.score += points;
    }

    public void subtractPointsFromScore(int points){
        this.score -= points;
    }


}
