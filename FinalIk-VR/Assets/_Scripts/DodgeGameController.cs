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
    private GameObject[] hazardInstances;
    private Vector3[] targets ;
    private Random random = new Random();

    public int hazardCount = 0;
    public int maxHazardCount = 5;
    private int hazardsMoving = 0;

    public float hazardInterval = 3f;
    public float hazardSpeed = 2f;

    private int hazardsFinishedMoving = 0;

    void Start()
    {
        pointsText.text = "Punkte: " + score;
        hazardInstances = new GameObject[maxHazardCount];
        targets = new Vector3[maxHazardCount];
        createHazards();
    }

    void Update()
    {
        if(gameIsStarted)
        {
            pointsText.text = "Punkte: " + score;
            moveHazards();
        }
    }

    private void createHazards()
    {
        //in random direction 1lefttop, 2backtop, 3righttop, 4lefthalfbottom
        for (int i = 0; i < maxHazardCount; i++)
        {
            spawnBoxHazard(Random.Range(1, 6));
        }
    }

    private void spawnBoxHazard(int direction)
    {
        Vector3 position = new Vector3(0, 0, 0);
        Vector3 scale = new Vector3(0, 0, 0);
        Vector3 target = new Vector3(0, 0, 0);
        //left
        if (direction == 1)
        {
            position = new Vector3(-5, 2, 0);
            scale = new Vector3(1, 1, 6);
            target = new Vector3(5, 2, 0);
        }
        if (direction == 2)
        {
            position = new Vector3(0, 2, -5);
            scale = new Vector3(5, 1, 1);
            target = new Vector3(0, 2, 5);
        }
        if (direction == 3)
        {
            position = new Vector3(5, 2, 0);
            scale = new Vector3(1, 1, 6);
            target = new Vector3(-5, 2, 0);
        }
        if (direction == 4)
        {
            position = new Vector3(-5, 0, Random.Range(-4, 4));
            scale = new Vector3(1, 1, Random.Range(1, 3));
            target = new Vector3(5, 0, Random.Range(-4, 4));
        }
        if (direction == 5)
        {
            position = new Vector3(Random.Range(-4, 4), 0, -5);
            scale = new Vector3(1, 1, Random.Range(1, 3));
            target = new Vector3(Random.Range(-4, 4), 0, 5);
        }
        if (direction == 6)
        {
            position = new Vector3(5, 0, Random.Range(-4, 4));
            scale = new Vector3(1, 1, Random.Range(1, 3));
            target = new Vector3(-5, 0, Random.Range(-4, 4));
        }
        hazardInstances[hazardCount] = Instantiate(hazard, position, Quaternion.identity);
        hazardInstances[hazardCount].transform.localScale = scale;
        targets[hazardCount] = target;
        hazardCount++;
    }

    private void moveHazards()
    {
        float step = hazardSpeed * Time.deltaTime;

        for (int i= hazardsFinishedMoving; i < hazardsMoving; i++)
        {
            if(i < hazardInstances.Length && hazardInstances[i] != null)
            {
                hazardInstances[i].transform.position = Vector3.MoveTowards(hazardInstances[i].transform.position, targets[i], step);
                if(hazardInstances[i].transform.position == targets[i])
                {
                    hazardInstances[i].SetActive(false);
                    hazardsFinishedMoving++;
                }
            }
        }
    }

    private void moveHazard()
    {
        hazardsMoving++;
        Debug.Log(hazardsMoving);
    }

    public void startGame()
    {
        CancelInvoke();
        InvokeRepeating("moveHazard", 1, hazardInterval);
        gameIsStarted = true;
    }

    public void addPointsToScore(int points){
        this.score += points;
    }

    public void subtractPointsFromScore(int points){
        this.score -= points;
    }


}
