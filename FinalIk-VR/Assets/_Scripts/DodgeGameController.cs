using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


public class DodgeGameController : MonoBehaviour
{
    public int score = 0;
    public Text pointsText;
    public SphereCollider playerCollider;
    public BoxCollider hazardCollider;
    public bool gameIsStarted = false;
    public GameObject hazard;
    public float roomSizeX, roomSizeY, roomSizeZ;
    private GameObject hazardInstance;


    public int hazardCount = 0;
    void Start()
    {
        pointsText.text = "Punkte: " + score;
    }

    void Update()
    {
        if(gameIsStarted)
        {
            pointsText.text = "Punkte: " + score;
            //in intervall random
            createHazards(new Vector3(Random.Range(roomSizeX, -roomSizeX), Random.Range(0, roomSizeY/2), 0), new Vector3(1, 1, 16));
        }
    }

    private void createHazards(Vector3 coordinates, Vector3 size){
        spawnBoxHazard();
    }

    private void spawnBoxHazard()
    {
        if (hazardCount < 1)
        {
            hazardInstance = Instantiate(hazard, new Vector3(5, 2, 0), Quaternion.identity);
            hazardInstance.transform.localScale = new Vector3(1, 1, 6);
            hazardCount++;
        }
        // Move our position a step closer to the target.
        float step = 1 * Time.deltaTime; // calculate distance to move
        hazardInstance.transform.position = Vector3.MoveTowards(hazardInstance.transform.position, new Vector3(-5, 2, 0), step);
    }



    public void addPointsToScore(int points){
        this.score += points;
    }

    public void subtractPointsFromScore(int points){
        this.score -= points;
    }


}
