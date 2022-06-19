Scriptname BuildingBudgetExtender_Unlimited extends Quest

Event OnInit()
    ; It is required to register "WorkshopMenu" for OnMenuOpenCloseEvent to work
    RegisterForMenuOpenCloseEvent("WorkshopMenu")
    Debug.Notification("[BuildingBudgetExtender] Version 3.1 initiated!")
EndEvent

Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
    if (asMenuName == "WorkshopMenu")
        if (abOpening)
            ; Get the workshop reference from the player's current location
            WorkshopScript workshop = WorkshopParent.CurrentWorkshop.GetRef() as WorkshopScript

            ; Get the required ActorValues
            ActorValue WorkshopMaxTriangles = WorkshopParent.WorkshopMaxTriangles
            ActorValue WorkshopMaxDraws = WorkshopParent.WorkshopMaxDraws

            ; Get the current maximum triangles and draws from the workshop
            float curMaxTris  = workshop.getValue(WorkshopMaxTriangles)
            float curMaxDraws = workshop.getValue(WorkshopMaxDraws)

            ; Value to be set as maximum triangles and draws
            float Value = -1.0 ; *Value

            ; Check whether the current max triangles or draws values differ from *Value
            if (curMaxTris != Value || curMaxDraws != Value)
                workshop.StartWorkshop(false) ; Close workshop before changes

                ; Make the changes to the current workshop
                workshop.SetValue(WorkshopMaxDraws, Value)
                workshop.SetValue(WorkshopMaxTriangles, Value)

                workshop.StartWorkshop(true) ; Open workshop after changes

                ; Display message notifying the player of the changes
                Debug.Notification("[BuildingBudgetExtender] Settlement budget is now unlimited!")
            endif
        endif
    endif
endEvent

WorkshopParentScript Property WorkshopParent Auto Const mandatory