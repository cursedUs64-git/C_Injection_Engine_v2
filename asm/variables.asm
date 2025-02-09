.ifndef _VARIABLES_ASM_
.definelabel _VARIABLES_ASM_, 1

.definelabel gVblankHandler1, 0x8032d560
.definelabel gVblankHandler2, 0x8032d564
.definelabel gActiveSPTask, 0x8032d568
.definelabel sCurrentAudioSPTask, 0x8032d56c
.definelabel sCurrentDisplaySPTask, 0x8032d570
.definelabel sNextAudioSPTask, 0x8032d574
.definelabel sNextDisplaySPTask, 0x8032d578
.definelabel sAudioEnabled, 0x8032d57c
.definelabel gNumVblanks, 0x8032d580
.definelabel gResetTimer, 0x8032d584
.definelabel gNmiResetBarsTimer, 0x8032d588
.definelabel gDebugLevelSelect, 0x8032d58c
.definelabel D_8032C650, 0x8032d590
.definelabel gShowProfiler, 0x8032d594
.definelabel gShowDebugText, 0x8032d598
 
.definelabel gGlobalTimer, 0x8032d5d4
.definelabel sRenderedFramebuffer, 0x8032d5d8
.definelabel sRenderingFramebuffer, 0x8032d5dc
.definelabel gGoddardVblankCallback, 0x8032d5e0
.definelabel gPlayer1Controller, 0x8032d5e4
.definelabel gPlayer2Controller, 0x8032d5e8
.definelabel gPlayer3Controller, 0x8032d5ec
.definelabel gCurrDemoInput, 0x8032d5f0
.definelabel gDemoInputListID, 0x8032d5f4
.definelabel gRecordedDemoInput, 0x8032d5f8
 
.definelabel credits01, 0x8032d6d0
.definelabel credits02, 0x8032d6d8
.definelabel credits03, 0x8032d6e4
.definelabel credits04, 0x8032d6f0
.definelabel credits05, 0x8032d700
.definelabel credits06, 0x8032d710
.definelabel credits07, 0x8032d71c
.definelabel credits08, 0x8032d728
.definelabel credits09, 0x8032d738
.definelabel credits10, 0x8032d740
.definelabel credits11, 0x8032d750
.definelabel credits12, 0x8032d75c
.definelabel credits13, 0x8032d764
.definelabel credits14, 0x8032d774
.definelabel credits15, 0x8032d77c
.definelabel credits16, 0x8032d788
.definelabel credits17, 0x8032d79c
.definelabel credits18, 0x8032d7ac
.definelabel credits19, 0x8032d7bc
.definelabel credits20, 0x8032d7c4
.definelabel sCreditsSequence, 0x8032d7cc
.definelabel gMarioState, 0x8032d93c
.definelabel unused1, 0x8032d940
.definelabel sWarpCheckpointActive, 0x8032d944
 
.definelabel sTerrainSounds, 0x8032daa0
.definelabel sSquishScaleOverTime, 0x8032dacc
.definelabel sCapFlickerFrames, 0x8032dae0
 
.definelabel gWaterSurfacePseudoFloor, 0x8032daf8
 
.definelabel sJumpLandAction, 0x8032dc50
.definelabel sFreefallLandAction, 0x8032dc68
.definelabel sSideFlipLandAction, 0x8032dc80
.definelabel sHoldJumpLandAction, 0x8032dc98
.definelabel sHoldFreefallLandAction, 0x8032dcb0
.definelabel sLongJumpLandAction, 0x8032dcc8
.definelabel sDoubleJumpLandAction, 0x8032dce0
.definelabel sTripleJumpLandAction, 0x8032dcf8
.definelabel sBackflipLandAction, 0x8032dd10
 
.definelabel sPunchingForwardVelocities, 0x8032dd40
 
.definelabel gLastCompletedCourseNum, 0x8032dd80
.definelabel gLastCompletedStarNum, 0x8032dd84
.definelabel sUnusedGotGlobalCoinHiScore, 0x8032dd88
.definelabel gGotFileCoinHiScore, 0x8032dd8c
.definelabel gCurrCourseStarFlags, 0x8032dd90
.definelabel gSpecialTripleJump, 0x8032dd94
.definelabel gLevelToCourseNumTable, 0x8032dd98
 
.definelabel gMarioSpawnInfo, 0x8032ddc0
.definelabel gLoadedGraphNodes, 0x8032ddc4
.definelabel gAreas, 0x8032ddc8
.definelabel gCurrentArea, 0x8032ddcc
.definelabel gCurrCreditsEntry, 0x8032ddd0
.definelabel D_8032CE74, 0x8032ddd4
.definelabel D_8032CE78, 0x8032ddd8
.definelabel gWarpTransDelay, 0x8032dddc
.definelabel gFBSetColor, 0x8032dde0
.definelabel gWarpTransFBSetColor, 0x8032dde4
.definelabel gWarpTransRed, 0x8032dde8
.definelabel gWarpTransGreen, 0x8032ddec
.definelabel gWarpTransBlue, 0x8032ddf0
.definelabel gCurrSaveFileNum, 0x8032ddf4
.definelabel gCurrLevelNum, 0x8032ddf8
.definelabel sWarpBhvSpawnTable, 0x8032ddfc
.definelabel sSpawnTypeFromWarpBhv, 0x8032de4c
.definelabel D_8032CF00, 0x8032de60
 
.definelabel renderModeTable_1Cycle, 0x8032de70
.definelabel renderModeTable_2Cycle, 0x8032deb0
.definelabel gCurGraphNodeRoot, 0x8032def0
.definelabel gCurGraphNodeMasterList, 0x8032def4
.definelabel gCurGraphNodeCamFrustum, 0x8032def8
.definelabel gCurGraphNodeCamera, 0x8032defc
.definelabel gCurGraphNodeObject, 0x8032df00
.definelabel gCurGraphNodeHeldObject, 0x8032df04
.definelabel gAreaUpdateCounter, 0x8032df08
 
.definelabel gProfilerMode, 0x8032df10
.definelabel gCurrentFrameIndex1, 0x8032df14
.definelabel gCurrentFrameIndex2, 0x8032df18
 
.definelabel unused8032CFC0, 0x8032df20
.definelabel gCutsceneFocus, 0x8032df24
.definelabel unused8032CFC8, 0x8032df28
.definelabel unused8032CFCC, 0x8032df2c
.definelabel gSecondCameraFocus, 0x8032df30
.definelabel sYawSpeed, 0x8032df34
.definelabel gCurrLevelArea, 0x8032df38
.definelabel gPrevLevel, 0x8032df3c
.definelabel unused8032CFE0, 0x8032df40
.definelabel unused8032CFE4, 0x8032df44
.definelabel unused8032CFE8, 0x8032df48
.definelabel gCameraZoomDist, 0x8032df4c
.definelabel sObjectCutscene, 0x8032df50
.definelabel gRecentCutscene, 0x8032df54
.definelabel sFramesSinceCutsceneEnded, 0x8032df58
.definelabel sCutsceneDialogResponse, 0x8032df5c
.definelabel sMarioCamState, 0x8032df60
.definelabel sLuigiCamState, 0x8032df64
.definelabel unused8032D008, 0x8032df68
.definelabel sFixedModeBasePosition, 0x8032df6c
.definelabel sUnusedModeBasePosition_2, 0x8032df78
.definelabel sUnusedModeBasePosition_3, 0x8032df84
.definelabel sUnusedModeBasePosition_4, 0x8032df90
.definelabel sUnusedModeBasePosition_5, 0x8032df9c
.definelabel sModeTransitions, 0x8032dfa8
.definelabel unused8032D0A8, 0x8032e008
.definelabel unused8032D0B0, 0x8032e010
.definelabel sDanceCutsceneTable, 0x8032e018
.definelabel unusedDanceInfo1, 0x8032e024
.definelabel unusedDanceType, 0x8032e038
.definelabel unusedDanceInfo2, 0x8032e03c
.definelabel sBBHLibraryParTrackPath, 0x8032e050
.definelabel sCamSL, 0x8032e098
.definelabel sCamTHI, 0x8032e0e0
.definelabel sCamHMC, 0x8032e128
.definelabel sCamSSL, 0x8032e1d0
.definelabel sCamRR, 0x8032e248
.definelabel sCamBOB, 0x8032e2f0
.definelabel sCamCotMC, 0x8032e338
.definelabel sCamCCM, 0x8032e368
.definelabel sCamCastle, 0x8032e3b0
.definelabel sCamBBH, 0x8032e6f8
.definelabel sCameraTriggers, 0x8032ecb0
.definelabel sIntroStartToPipePosition, 0x8032ed50
.definelabel sIntroStartToPipeFocus, 0x8032ee08
.definelabel sIntroPipeToDialogPosition, 0x8032eec0
.definelabel sIntroPipeToDialogFocus, 0x8032ef30
.definelabel sEndingFlyToWindowPos, 0x8032efa0
.definelabel sEndingFlyToWindowFocus, 0x8032eff0
.definelabel sEndingPeachDescentCamPos, 0x8032f048
.definelabel sEndingMarioToPeachPos, 0x8032f0e8
.definelabel sEndingMarioToPeachFocus, 0x8032f130
.definelabel sEndingLookUpAtCastle, 0x8032f178
.definelabel sEndingLookAtSkyFocus, 0x8032f1b8
.definelabel gIntroLakituStartToPipeFocus, 0x8032f214
.definelabel gIntroLakituStartToPipeOffsetFromCamera, 0x8032f32c
.definelabel gEndWavingPos, 0x8032f444
.definelabel gEndWavingFocus, 0x8032f48c
.definelabel sCutsceneEnding, 0x8032f4d4
.definelabel sCutsceneGrandStar, 0x8032f534
.definelabel sCutsceneUnused, 0x8032f544
.definelabel sCutsceneDoorWarp, 0x8032f554
.definelabel sCutsceneEndWaving, 0x8032f564
.definelabel sCutsceneCredits, 0x8032f56c
.definelabel sCutsceneDoorPull, 0x8032f574
.definelabel sCutsceneDoorPush, 0x8032f59c
.definelabel sCutsceneDoorPullMode, 0x8032f5c4
.definelabel sCutsceneDoorPushMode, 0x8032f5dc
.definelabel sCutsceneEnterCannon, 0x8032f5f4
.definelabel sCutsceneStarSpawn, 0x8032f60c
.definelabel sCutsceneRedCoinStarSpawn, 0x8032f624
.definelabel sCutsceneEnterPainting, 0x8032f634
.definelabel sCutsceneDeathExit, 0x8032f63c
.definelabel sCutsceneExitPaintingSuccess, 0x8032f64c
.definelabel sCutsceneUnusedExit, 0x8032f65c
.definelabel sCutsceneIntroPeach, 0x8032f674
.definelabel sCutscenePrepareCannon, 0x8032f69c
.definelabel sCutsceneExitWaterfall, 0x8032f6ac
.definelabel sCutsceneFallToCastleGrounds, 0x8032f6bc
.definelabel sCutsceneEnterPyramidTop, 0x8032f6cc
.definelabel sCutscenePyramidTopExplode, 0x8032f6dc
.definelabel sCutsceneStandingDeath, 0x8032f6f4
.definelabel sCutsceneEnterPool, 0x8032f6fc
.definelabel sCutsceneDeathStomach, 0x8032f70c
.definelabel sCutsceneDeathOnBack, 0x8032f714
.definelabel sCutsceneQuicksandDeath, 0x8032f71c
.definelabel sCutsceneWaterDeath, 0x8032f724
.definelabel sCutsceneSuffocation, 0x8032f72c
.definelabel sCutsceneEnterBowserArena, 0x8032f734
.definelabel sCutsceneDanceDefaultRotate, 0x8032f74c
.definelabel sCutsceneDanceFlyAway, 0x8032f754
.definelabel sCutsceneDanceCloseup, 0x8032f75c
.definelabel sCutsceneKeyDance, 0x8032f764
.definelabel sCutsceneCapSwitchPress, 0x8032f76c
.definelabel sCutsceneSlidingDoorsOpen, 0x8032f774
.definelabel sCutsceneUnlockKeyDoor, 0x8032f784
.definelabel sCutsceneExitBowserSuccess, 0x8032f794
.definelabel sCutsceneExitBowserDeath, 0x8032f7a4
.definelabel sCutsceneExitSpecialSuccess, 0x8032f7b4
.definelabel sCutsceneNonPaintingDeath, 0x8032f7c4
.definelabel sCutsceneDialog, 0x8032f7d4
.definelabel sCutsceneReadMessage, 0x8032f7ec
.definelabel sDanceCutsceneIndexTable, 0x8032f804
.definelabel sZoomOutAreaMasks, 0x8032f870
.definelabel sBobCreditsSplinePositions, 0x8032f884
.definelabel sBobCreditsSplineFocus, 0x8032f8ac
.definelabel sWfCreditsSplinePositions, 0x8032f8d4
.definelabel sWfCreditsSplineFocus, 0x8032f8fc
.definelabel sJrbCreditsSplinePositions, 0x8032f924
.definelabel sJrbCreditsSplineFocus, 0x8032f94c
.definelabel sCcmSlideCreditsSplinePositions, 0x8032f974
.definelabel sCcmSlideCreditsSplineFocus, 0x8032f99c
.definelabel sBbhCreditsSplinePositions, 0x8032f9c4
.definelabel sBbhCreditsSplineFocus, 0x8032f9e4
.definelabel sHmcCreditsSplinePositions, 0x8032fa04
.definelabel sHmcCreditsSplineFocus, 0x8032fa2c
.definelabel sThiWigglerCreditsSplinePositions, 0x8032fa54
.definelabel sThiWigglerCreditsSplineFocus, 0x8032fa6c
.definelabel sVolcanoCreditsSplinePositions, 0x8032fa84
.definelabel sVolcanoCreditsSplineFocus, 0x8032fab4
.definelabel sSslCreditsSplinePositions, 0x8032fae4
.definelabel sSslCreditsSplineFocus, 0x8032fb14
.definelabel sDddCreditsSplinePositions, 0x8032fb44
.definelabel sDddCreditsSplineFocus, 0x8032fb7c
.definelabel sSlCreditsSplinePositions, 0x8032fbb4
.definelabel sSlCreditsSplineFocus, 0x8032fbd4
.definelabel sWdwCreditsSplinePositions, 0x8032fbf4
.definelabel sWdwCreditsSplineFocus, 0x8032fc14
.definelabel sTtmCreditsSplinePositions, 0x8032fc34
.definelabel sTtmCreditsSplineFocus, 0x8032fc64
.definelabel sThiHugeCreditsSplinePositions, 0x8032fc94
.definelabel sThiHugeCreditsSplineFocus, 0x8032fccc
.definelabel sTtcCreditsSplinePositions, 0x8032fd04
.definelabel sTtcCreditsSplineFocus, 0x8032fd24
.definelabel sRrCreditsSplinePositions, 0x8032fd44
.definelabel sRrCreditsSplineFocus, 0x8032fd64
.definelabel sSaCreditsSplinePositions, 0x8032fd84
.definelabel sSaCreditsSplineFocus, 0x8032fdac
.definelabel sCotmcCreditsSplinePositions, 0x8032fdd4
.definelabel sCotmcCreditsSplineFocus, 0x8032fdfc
.definelabel sDddSubCreditsSplinePositions, 0x8032fe24
.definelabel sDddSubCreditsSplineFocus, 0x8032fe4c
.definelabel sCcmOutsideCreditsSplinePositions, 0x8032fe74
.definelabel sCcmOutsideCreditsSplineFocus, 0x8032fe94
 
.definelabel sObjectListUpdateOrder, 0x8032fec0
.definelabel sParticleTypes, 0x8032fecc
 
.definelabel sMrIParticleActions, 0x8033006c
.definelabel sMrIActions, 0x80330074
.definelabel sMrIHitbox, 0x80330084
.definelabel sCapSwitchText, 0x803300a8
.definelabel sCapSwitchActions, 0x803300ac
.definelabel sKingBobombActions, 0x803300bc
.definelabel sKingBobombSoundStates, 0x803300e0
.definelabel sOpenedCannonActions, 0x80330140
.definelabel sUnusedChuckyaData, 0x8033015c
.definelabel sChuckyaActions, 0x80330198
.definelabel sWFRotatingPlatformData, 0x803301a8
.definelabel sKoopaShellUnderwaterHitbox, 0x803301c0
.definelabel sSparkleSpawnStarHitbox, 0x803301e4
.definelabel sYellowCoinHitbox, 0x803301f4
.definelabel sCoinArrowPositions, 0x80330204
.definelabel sCoinInsideBooActions, 0x80330224
.definelabel sGrindelThwompActions, 0x80330298
.definelabel sTumblingBridgeParams, 0x803302ac
.definelabel sTumblingBridgeActions, 0x803302dc
.definelabel sElevatorActions, 0x80330318
.definelabel sUkikiCageActions, 0x80330370
.definelabel sBowserShockwaveHitPoints, 0x80330380
.definelabel sSpindriftHitbox, 0x80330390
.definelabel sMetalBoxHitbox, 0x803303a0
.definelabel sBreakableBoxHitbox, 0x803303b0
.definelabel D_8032F460, 0x803303c0
.definelabel sHeaveHoActions, 0x803303e8
.definelabel sJumpingBoxHitbox, 0x803303f8
.definelabel sJumpingBoxActions, 0x80330408
.definelabel sBowserKeyHitbox, 0x8033042c
.definelabel sBulletBillActions, 0x8033043c
.definelabel sBowserTailAnchorActions, 0x80330450
.definelabel sBowserDebugActions, 0x8033045c
.definelabel sBowserVelYAir, 0x8033046c
.definelabel sBowserFVelAir, 0x80330470
.definelabel sBowserDanceStepNoises, 0x80330474
.definelabel sBowserDefeatedDialogText, 0x80330478
.definelabel sBowsertiltPlatformData, 0x80330480
.definelabel sBowserActions, 0x803304c8
.definelabel sBowserSoundStates, 0x80330518
.definelabel sBowserRainbowLight, 0x803305f0
.definelabel sBowserHealth, 0x803305f4
.definelabel sBowserFallingPlatform, 0x803305f8
.definelabel sFallingBowserPlatformActions, 0x8033067c
.definelabel sGrowingBowserFlameHitbox, 0x80330688
.definelabel sBowserFlameHitbox, 0x80330698
.definelabel sFlameFloatingYLimit, 0x803306a8
.definelabel D_8032F754, 0x803306b4
.definelabel sUkikiSoundStates, 0x80330738
.definelabel sUkikiActions, 0x803307a0
.definelabel D_8032F860, 0x803307c0
.definelabel D_8032F894, 0x803307f4
.definelabel D_8032F8C8, 0x80330828
.definelabel sRotatingCwFireBarsActions, 0x80330830
.definelabel sKoopaShellHitbox, 0x80330840
.definelabel D_8032F8F0, 0x80330850
.definelabel D_8032F924, 0x80330884
.definelabel D_8032F948, 0x803308a8
.definelabel D_8032F96C, 0x803308cc
.definelabel sToxBoxActions, 0x803308d8
.definelabel TablePiranhaPlantActions, 0x80330900
.definelabel sBowserPuzzlePieceActions, 0x80330b1c
.definelabel sTuxiesMotherActions, 0x80330b38
.definelabel sSmallPenguinActions, 0x80330b44
.definelabel sBirdChirpChirpActions, 0x80330b74
.definelabel sCheepCheepActions, 0x80330b84
.definelabel sExclamationBoxHitbox, 0x80330b90
.definelabel sExclamationBoxContents, 0x80330ba0
.definelabel sExclamationBoxActions, 0x80330c20
.definelabel sSkullSlidingBoxHitbox, 0x80330c38
.definelabel gOpenableGrills, 0x80330c48
.definelabel sTweesterHitbox, 0x80330c58
.definelabel sTweesterActions, 0x80330c68
.definelabel sScuttlebugHitbox, 0x80330cd4
.definelabel sWhompActions, 0x80330ce4
.definelabel sWaterSplashDropletParams, 0x80330d0c
.definelabel gShallowWaterSplashDropletParams, 0x80330d30
.definelabel sWaterDropletFishParams, 0x80330d54
.definelabel gShallowWaterWaveDropletParams, 0x80330d78
.definelabel sStrongWindParticleHitbox, 0x80330d9c
.definelabel sSLWalkingPenguinErraticSteps, 0x80330dac
 
.definelabel D_8032FEC0, 0x80330e20
.definelabel unused_8032FEC4, 0x80330e24
.definelabel gMarioPlatform, 0x80330e34
 
.definelabel sDebugEffectStringInfo, 0x80330e40
.definelabel sDebugEnemyStringInfo, 0x80330e64
.definelabel sDebugInfoDPadMask, 0x80330e88
.definelabel sDebugInfoDPadUpdID, 0x80330e8c
.definelabel sDebugLvSelectCheckFlag, 0x80330e90
.definelabel sDebugPage, 0x80330e94
.definelabel sNoExtraDebug, 0x80330e98
.definelabel sDebugStringArrPrinted, 0x80330e9c
.definelabel sDebugSysCursor, 0x80330ea0
.definelabel sDebugInfoButtonSeqID, 0x80330ea4
.definelabel sDebugInfoButtonSeq, 0x80330ea8
 
.definelabel sTransitionColorFadeCount, 0x80330ec0
.definelabel sTransitionTextureFadeCount, 0x80330ec4
.definelabel sTextureTransitionID, 0x80330ec8
 
.definelabel rectangles, 0x80330ee0
 
.definelabel sSkyboxTextures, 0x80330f00
.definelabel sSkyboxColors, 0x80330f28
 
.definelabel gMovtexCounter, 0x80330f30
.definelabel gMovtexCounterPrev, 0x80330f34
.definelabel gMovtexVtxColor, 0x80330f38
.definelabel gPaintingMarioYEntry, 0x80330f3c
.definelabel gWdwWaterLevelSet, 0x80330f40
.definelabel gMovtexIdToTexture, 0x80330f44
.definelabel gMovtexNonColored, 0x80330f64
.definelabel gMovtexColored, 0x803311a4
.definelabel gMovtexColored2, 0x8033127c
 
.definelabel sHmcPaintings, 0x80331300
.definelabel sInsideCastlePaintings, 0x80331308
.definelabel sTtmPaintings, 0x80331344
.definelabel sPaintingGroups, 0x8033134c
.definelabel gPaintingUpdateCounter, 0x80331358
.definelabel gLastPaintingUpdateCounter, 0x8033135c
 
.definelabel sTextLabelsCount, 0x80331360
 
.definelabel gDialogCharWidths, 0x80331370
.definelabel gDialogBoxState, 0x80331470
.definelabel gDialogBoxOpenTimer, 0x80331474
.definelabel gDialogBoxScale, 0x80331478
.definelabel gDialogScrollOffsetY, 0x8033147c
.definelabel gDialogBoxType, 0x80331480
.definelabel gDialogID, 0x80331484
.definelabel gLastDialogPageStrPos, 0x80331488
.definelabel gDialogTextPos, 0x8033148c
.definelabel gDialogLineNum, 0x80331490
.definelabel gLastDialogResponse, 0x80331494
.definelabel gMenuHoldKeyIndex, 0x80331498
.definelabel gMenuHoldKeyTimer, 0x8033149c
.definelabel gDialogResponse, 0x803314a0
.definelabel gHudSymCoin, 0x803314b0
.definelabel gHudSymX, 0x803314b4
.definelabel gMenuMode, 0x803314f8
.definelabel gEndCutsceneStrEn0, 0x803314fc
.definelabel gEndCutsceneStrEn1, 0x80331504
.definelabel gEndCutsceneStrEn2, 0x80331538
.definelabel gEndCutsceneStrEn3, 0x80331558
.definelabel gEndCutsceneStrEn4, 0x8033156c
.definelabel gEndCutsceneStrEn5, 0x80331598
.definelabel gEndCutsceneStrEn6, 0x803315ac
.definelabel gEndCutsceneStrEn7, 0x803315cc
.definelabel gEndCutsceneStrEn8, 0x803315dc
.definelabel gEndCutsceneStringsEn, 0x803315e4
.definelabel gCutsceneMsgFade, 0x8033160c
.definelabel gCutsceneMsgIndex, 0x80331610
.definelabel gCutsceneMsgDuration, 0x80331614
.definelabel gCutsceneMsgTimer, 0x80331618
.definelabel gDialogCameraAngleIndex, 0x8033161c
.definelabel gDialogCourseActNum, 0x80331620
.definelabel gCourseCompleteCoinsEqual, 0x803316c8
.definelabel gCourseDoneMenuTimer, 0x803316cc
.definelabel gCourseCompleteCoins, 0x803316d0
.definelabel gHudFlash, 0x803316d4
 
.definelabel gEnvFxMode, 0x80331750
.definelabel D_80330644, 0x80331754
.definelabel gSnowTempVtx, 0x80331758
.definelabel gSnowFlakeVertex1, 0x80331788
.definelabel gSnowFlakeVertex2, 0x80331790
.definelabel gSnowFlakeVertex3, 0x80331798
 
.definelabel D_80330690, 0x803317a0
.definelabel D_80330694, 0x803317a4
.definelabel gBubbleTempVtx, 0x803317a8
 
.definelabel MacroObjectPresets, 0x803317e0
 
.definelabel sPowerMeterVisibleTimer, 0x803325fc
 
.definelabel sPrevCheckMarioRoom, 0x80332614
.definelabel sYoshiDead, 0x80332618
.definelabel sDebugSequenceTracker, 0x8033261c
.definelabel sDebugTimer, 0x80332620
.definelabel sBreakableBoxSmallHitbox, 0x803327a8
 
.definelabel sMrBlizzardHitbox, 0x80332b00
.definelabel sMrBlizzardSnowballHitbox, 0x80332b24
.definelabel D_80331A54, 0x80332b64
.definelabel D_80331ACC, 0x80332bdc
.definelabel sRecoveryHeartHitbox, 0x80332bf0
.definelabel sUnagiHitbox, 0x80332c00
.definelabel sHauntedChairHitbox, 0x80332c10
.definelabel sFlyingBookendHitbox, 0x80332c30
.definelabel D_80331B30, 0x80332c40
.definelabel sBookSwitchHitbox, 0x80332c4c
.definelabel sFirePiranhaPlantHitbox, 0x80332c5c
.definelabel D_80331B5C, 0x80332c6c
.definelabel sPiranhaPlantFireHitbox, 0x80332c74
.definelabel sSnufitHitbox, 0x80332c84
.definelabel sSnufitBulletHitbox, 0x80332c94
.definelabel sEyerokHitbox, 0x80332ca4
.definelabel D_80331BA4, 0x80332cb4
.definelabel coffinRelativePos, 0x80332d10
.definelabel sClamShellHitbox, 0x80332d28
.definelabel sSkeeterHitbox, 0x80332d38
.definelabel D_80331C38, 0x80332d48
 
.definelabel gAudioErrorFlags, 0x80332e50
.definelabel sGameLoopTicked, 0x80332e54
.definelabel sDialogSpeaker, 0x80332e58
.definelabel sDialogSpeakerVoice, 0x80332f04
.definelabel sNumProcessedSoundRequests, 0x80332f40
.definelabel sSoundRequestCount, 0x80332f44
.definelabel sDynBbh, 0x80332f48
.definelabel sDynDdd, 0x80332f54
.definelabel sDynJrb, 0x80332f6c
.definelabel sDynWdw, 0x80332f88
.definelabel sDynHmc, 0x80332f98
.definelabel sDynUnk38, 0x80332fa8
.definelabel sDynNone, 0x80332fb8
.definelabel sCurrentMusicDynamic, 0x80332fbc
.definelabel sBackgroundMusicForDynamics, 0x80332fc0
.definelabel sLevelDynamics, 0x80332fc4
.definelabel sMusicDynamics, 0x80333060
.definelabel sLevelAreaReverbs, 0x803330c0
.definelabel sLevelAcousticReaches, 0x80333138
.definelabel sBackgroundMusicDefaultVolume, 0x80333188
.definelabel sCurrentBackgroundMusicSeqId, 0x803331ac
.definelabel sMusicDynamicDelay, 0x803331b0
.definelabel sSoundBankUsedListBack, 0x803331b4
.definelabel sSoundBankFreeListFront, 0x803331c0
.definelabel sNumSoundsInBank, 0x803331cc
.definelabel sMaxChannelsForSoundBank, 0x803331d8
.definelabel sNumSoundsPerBank, 0x803331e4
.definelabel gGlobalSoundSource, 0x803331f0
.definelabel sUnusedSoundArgs, 0x803331fc
.definelabel sSoundBankDisabled, 0x80333208
.definelabel D_80332108, 0x80333218
.definelabel sHasStartedFadeOut, 0x8033321c
.definelabel sSoundBanksThatLowerBackgroundMusic, 0x80333220
.definelabel sUnused80332114, 0x80333224
.definelabel sUnused80332118, 0x80333228
.definelabel sBackgroundMusicMaxTargetVolume, 0x8033322c
.definelabel D_80332120, 0x80333230
.definelabel D_80332124, 0x80333234
.definelabel sBackgroundMusicQueueSize, 0x80333238
.definelabel sUnused8033323C, 0x8033323c
 
.definelabel gAudioSessionPresets, 0x803332a0
.definelabel gAudioCosineTable, 0x80333498
.definelabel gPitchBendFrequencyScale, 0x80333598
.definelabel gNoteFrequencies, 0x80333994
.definelabel gDefaultShortNoteVelocityTable, 0x80333b94
.definelabel gDefaultShortNoteDurationTable, 0x80333ba4
.definelabel gVibratoCurve, 0x80333bb4
.definelabel gDefaultEnvelope, 0x80333bc4
.definelabel sSineWave, 0x80333bd0
.definelabel sSquareWave, 0x80333c50
.definelabel sTriangleWave, 0x80333cd0
.definelabel sSawtoothWave, 0x80333d50
.definelabel gWaveSamples, 0x80333dd0
.definelabel gHeadsetPanQuantization, 0x80333de0
.definelabel gHeadsetPanVolume, 0x80333df4
.definelabel gStereoPanVolume, 0x80333ff4
.definelabel gDefaultPanVolume, 0x803341f4
.definelabel gVolRampingLhs136, 0x803343f4
.definelabel gVolRampingRhs136, 0x803345f4
.definelabel gVolRampingLhs144, 0x803347f4
.definelabel gVolRampingRhs144, 0x803349f4
.definelabel gVolRampingLhs128, 0x80334bf4
.definelabel gVolRampingRhs128, 0x80334df4
.definelabel gTatumsPerBeat, 0x80334ff4
.definelabel gUnusedCount80333EE8, 0x80334ff8
.definelabel gAudioHeapSize, 0x80334ffc
.definelabel gAudioInitPoolSize, 0x80335000
.definelabel gAudioLoadLock, 0x80335004
.definelabel sUnused8033EF8, 0x80335008
 
.definelabel osViModeTable, 0x80335010
 
.definelabel viMgrMainArgs, 0x803358d0
 
.definelabel __osPiDevMgr, 0x803358f0
 
.definelabel osClockRate, 0x80335910
.definelabel D_80334808, 0x80335918
 
.definelabel _osContInitialized, 0x80335920
 
.definelabel D_80334820, 0x80335930
 
.definelabel __osTimerList, 0x80335940
 
.definelabel _spaces, 0x80335950
.definelabel _zeroes, 0x80335974
 
.definelabel D_80334890, 0x803359a0
.definelabel D_80334894, 0x803359a4
.definelabel D_80334898, 0x803359a8
.definelabel D_8033489C, 0x803359ac
.definelabel D_803348A0, 0x803359b0
.definelabel D_803348A4, 0x803359b4
 
.definelabel sViContexts, 0x803359c0
.definelabel __osViCurr, 0x80335a20
.definelabel __osViNext, 0x80335a24
.definelabel sTvType, 0x80335a28
.definelabel osViClock, 0x80335a2c
 
.definelabel D_80334920, 0x80335a30
.definelabel D_80334934, 0x80335a44
.definelabel D_80334938, 0x80335a48
 
.definelabel gOsPiAccessQueueCreated, 0x80335a50
 
.definelabel gOsSiAccessQueueCreated, 0x80335a60
 
.definelabel D_80334990, 0x80335aa0
.definelabel D_803349E0, 0x80335af0
 
.definelabel D_80334A30, 0x80335b40
.definelabel D_80334A34, 0x80335b44
.definelabel D_80334A38, 0x80335b48
 
.definelabel D_80334A40, 0x80335b50
.definelabel D_80334A44, 0x80335b54
 
.definelabel length_str, 0x80339880
.definelabel flags_str, 0x80339884
.definelabel flags_arr, 0x8033988c
 
.definelabel D_80338610, 0x80339980
.definelabel jtbl_80338630, 0x803399a0
 
.definelabel NAN, 0x803399d0
 
.definelabel D_80338670, 0x803399e0
 
.definelabel D_803386D0, 0x80339a40
 
.definelabel D_80339210, 0x8033a580
.definelabel gIdleThread, 0x8033a730
.definelabel gMainThread, 0x8033a8e0
.definelabel gGameLoopThread, 0x8033aa90
.definelabel gSoundThread, 0x8033ac40
.definelabel gPIMesgQueue, 0x8033adf0
.definelabel gIntrMesgQueue, 0x8033ae08
.definelabel gSPTaskMesgQueue, 0x8033ae20
.definelabel gDmaMesgBuf, 0x8033ae38
.definelabel gPIMesgBuf, 0x8033ae40
.definelabel gSIEventMesgBuf, 0x8033aec0
.definelabel gIntrMesgBuf, 0x8033aec8
.definelabel gUnknownMesgBuf, 0x8033af08
.definelabel gDmaIoMesg, 0x8033af48
.definelabel gMainReceivedMesg, 0x8033af5c
.definelabel gDmaMesgQueue, 0x8033af60
.definelabel gSIEventMesgQueue, 0x8033af78
 
.definelabel gControllers, 0x8033af90
.definelabel gControllerStatuses, 0x8033afe8
.definelabel gControllerPads, 0x8033aff8
.definelabel gGameVblankQueue, 0x8033b010
.definelabel gGfxVblankQueue, 0x8033b028
.definelabel gGameMesgBuf, 0x8033b040
.definelabel gGfxMesgBuf, 0x8033b044
.definelabel gGameVblankHandler, 0x8033b048
.definelabel gPhysicalFramebuffers, 0x8033b050
.definelabel gPhysicalZBuffer, 0x8033b05c
.definelabel gMarioAnimsMemAlloc, 0x8033b060
.definelabel gDemoInputsMemAlloc, 0x8033b064
.definelabel gGfxSPTask, 0x8033b068
.definelabel gDisplayListHead, 0x8033b06c
.definelabel gGfxPoolEnd, 0x8033b070
.definelabel gGfxPool, 0x8033b074
.definelabel gControllerBits, 0x8033b078
.definelabel gEepromProbe, 0x8033b079
.definelabel gMarioAnimsBuf, 0x8033b080
.definelabel gDemoInputsBuf, 0x8033b090
 
.definelabel gMarioStates, 0x8033b170
.definelabel sCurrPlayMode, 0x8033b238
.definelabel D_80339ECA, 0x8033b23a
.definelabel sTransitionTimer, 0x8033b23c
.definelabel sTransitionUpdate, 0x8033b240
.definelabel unused2, 0x8033b244
.definelabel sWarpDest, 0x8033b248
.definelabel D_80339EE0, 0x8033b250
.definelabel sDelayedWarpOp, 0x8033b252
.definelabel sDelayedWarpTimer, 0x8033b254
.definelabel sSourceWarpNodeId, 0x8033b256
.definelabel sDelayedWarpArg, 0x8033b258
.definelabel unused3, 0x8033b25c
.definelabel sTimerRunning, 0x8033b25e
.definelabel gHudDisplay, 0x8033b260
.definelabel gNeverEnteredCastle, 0x8033b26e
 
.definelabel sDelayInvincTimer, 0x8033b270
.definelabel sInvulnerable, 0x8033b272
 
.definelabel unused80339F10, 0x8033b280
.definelabel unused80339F1C, 0x8033b288
 
 
.definelabel sFloorAlignMatrix, 0x8033b2c0
 
.definelabel gMirrorMario, 0x8033b350
.definelabel gBodyStates, 0x8033b3b0
 
.definelabel sSegmentTable, 0x8033b400
.definelabel sPoolFreeSpace, 0x8033b480
.definelabel sPoolStart, 0x8033b484
.definelabel sPoolEnd, 0x8033b488
.definelabel sPoolListHeadL, 0x8033b48c
.definelabel sPoolListHeadR, 0x8033b490
.definelabel gEffectsMemoryPool, 0x8033b494
 
.definelabel gWarpCheckpoint, 0x8033b4a0
.definelabel gMainMenuDataModified, 0x8033b4a5
.definelabel gSaveFileModified, 0x8033b4a6
 
.definelabel gPlayerSpawnInfos, 0x8033b4b0
.definelabel D_8033A160, 0x8033b4d0
.definelabel gAreaData, 0x8033b8d0
.definelabel gWarpTransition, 0x8033bab0
.definelabel gCurrCourseNum, 0x8033bac6
.definelabel gCurrActNum, 0x8033bac8
.definelabel gCurrAreaIndex, 0x8033baca
.definelabel gSavedCourseNum, 0x8033bacc
.definelabel gMenuOptSelectIndex, 0x8033bace
.definelabel gSaveOptSelectIndex, 0x8033bad0
 
.definelabel gMatStackIndex, 0x8033bae0
.definelabel gMatStack, 0x8033bae8
.definelabel gMatStackFixed, 0x8033c2e8
.definelabel gGeoTempState, 0x8033c368
.definelabel gCurrAnimType, 0x8033c378
.definelabel gCurrAnimEnabled, 0x8033c379
.definelabel gCurrAnimFrame, 0x8033c37a
.definelabel gCurrAnimTranslationMultiplier, 0x8033c37c
.definelabel gCurrAnimAttribute, 0x8033c380
.definelabel gCurrAnimData, 0x8033c384
.definelabel gDisplayListHeap, 0x8033c388
 
.definelabel gProfilerFrameData, 0x8033c390
 
.definelabel gPlayerCameraState, 0x8033c520
.definelabel sOldPosition, 0x8033c568
.definelabel sOldFocus, 0x8033c578
.definelabel sPlayer2FocusOffset, 0x8033c588
.definelabel sCreditsPlayer2Pitch, 0x8033c594
.definelabel sCreditsPlayer2Yaw, 0x8033c596
.definelabel sFramesPaused, 0x8033c598
.definelabel sFOVState, 0x8033c5a0
.definelabel sModeTransition, 0x8033c5c0
.definelabel sMarioGeometry, 0x8033c5e8
.definelabel unusedFreeRoamWallYaw, 0x8033c61c
.definelabel sAvoidYawVel, 0x8033c61e
.definelabel sCameraYawAfterDoorCutscene, 0x8033c620
.definelabel unusedSplinePitch, 0x8033c622
.definelabel unusedSplineYaw, 0x8033c624
.definelabel sHandheldShakeSpline, 0x8033c628
.definelabel sHandheldShakeMag, 0x8033c668
.definelabel sHandheldShakeTimer, 0x8033c66c
.definelabel sHandheldShakeInc, 0x8033c670
.definelabel sHandheldShakePitch, 0x8033c674
.definelabel sHandheldShakeYaw, 0x8033c676
.definelabel sHandheldShakeRoll, 0x8033c678
.definelabel unused8033B30C, 0x8033c67c
.definelabel unused8033B310, 0x8033c680
.definelabel sSelectionFlags, 0x8033c684
.definelabel unused8033B316, 0x8033c686
.definelabel s2ndRotateFlags, 0x8033c688
.definelabel unused8033B31A, 0x8033c68a
.definelabel sCameraSoundFlags, 0x8033c68c
.definelabel sCButtonsPressed, 0x8033c68e
.definelabel sCutsceneDialogID, 0x8033c690
.definelabel gLakituState, 0x8033c698
.definelabel unused8033B3E8, 0x8033c758
.definelabel sAreaYaw, 0x8033c75a
.definelabel sAreaYawChange, 0x8033c75c
.definelabel sLakituDist, 0x8033c75e
.definelabel sLakituPitch, 0x8033c760
.definelabel sZoomAmount, 0x8033c764
.definelabel sCSideButtonYaw, 0x8033c768
.definelabel sBehindMarioSoundTimer, 0x8033c76a
.definelabel sZeroZoomDist, 0x8033c76c
.definelabel sCUpCameraPitch, 0x8033c770
.definelabel sModeOffsetYaw, 0x8033c772
.definelabel sSpiralStairsYawOffset, 0x8033c774
.definelabel s8DirModeBaseYaw, 0x8033c776
.definelabel s8DirModeYawOffset, 0x8033c778
.definelabel sPanDistance, 0x8033c77c
.definelabel sCannonYOffset, 0x8033c780
.definelabel sModeInfo, 0x8033c788
.definelabel sCastleEntranceOffset, 0x8033c7d0
.definelabel sParTrackIndex, 0x8033c7dc
.definelabel sParTrackPath, 0x8033c7e0
.definelabel sParTrackTransOff, 0x8033c7e8
.definelabel sCameraStoreCUp, 0x8033c808
.definelabel sCameraStoreCutscene, 0x8033c828
.definelabel gCameraMovementFlags, 0x8033c848
.definelabel sStatusFlags, 0x8033c84a
.definelabel sCurCreditsSplinePos, 0x8033c850
.definelabel sCurCreditsSplineFocus, 0x8033c950
.definelabel sCutsceneSplineSegment, 0x8033ca50
.definelabel sCutsceneSplineSegmentProgress, 0x8033ca54
.definelabel unused8033B6E8, 0x8033ca58
.definelabel sCutsceneShot, 0x8033ca5a
.definelabel gCutsceneTimer, 0x8033ca5c
.definelabel sCutsceneVars, 0x8033ca60
.definelabel gObjCutsceneDone, 0x8033cbc8
.definelabel gCutsceneObjSpawn, 0x8033cbcc
.definelabel gCamera, 0x8033cbd0
 
.definelabel gObjectListArray, 0x8033cbe0
.definelabel gDebugInfoFlags, 0x8033d260
.definelabel gNumFindFloorMisses, 0x8033d264
.definelabel unused_8033BEF8, 0x8033d268
.definelabel gUnknownWallCount, 0x8033d26c
.definelabel gObjectCounter, 0x8033d270
.definelabel gNumCalls, 0x8033d274
.definelabel gDebugInfo, 0x8033d280
.definelabel gDebugInfoOverwrite, 0x8033d380
.definelabel gTimeStopState, 0x8033d480
.definelabel gObjectPool, 0x8033d488
.definelabel gMacroObjectDefaultParent, 0x80360e88
.definelabel gObjectLists, 0x803610e8
.definelabel gFreeObjectList, 0x803610f0
.definelabel gMarioObject, 0x80361158
.definelabel gLuigiObject, 0x8036115c
.definelabel gCurrentObject, 0x80361160
.definelabel gCurBhvCommand, 0x80361164
.definelabel gPrevFrameObjectCount, 0x80361168
.definelabel gSurfaceNodesAllocated, 0x8036116c
.definelabel gSurfacesAllocated, 0x80361170
.definelabel gNumStaticSurfaceNodes, 0x80361174
.definelabel gNumStaticSurfaces, 0x80361178
.definelabel gObjectMemoryPool, 0x8036117c
.definelabel gCheckingSurfaceCollisionsForCamera, 0x80361180
.definelabel gFindFloorIncludeSurfaceIntangible, 0x80361182
.definelabel gEnvironmentRegions, 0x80361184
.definelabel gEnvironmentLevels, 0x80361188
.definelabel gDoorAdjacentRooms, 0x803611d8
.definelabel gMarioCurrentRoom, 0x80361250
.definelabel D_8035FEE2, 0x80361252
.definelabel D_8035FEE4, 0x80361254
.definelabel gTHIWaterDrained, 0x80361256
.definelabel gTTCSpeedSetting, 0x80361258
.definelabel gMarioShotFromCannon, 0x8036125a
.definelabel gCCMEnteredSlide, 0x8036125c
.definelabel gNumRoomedObjectsInMarioRoom, 0x8036125e
.definelabel gNumRoomedObjectsNotInMarioRoom, 0x80361260
.definelabel gWDWWaterLevelChanging, 0x80361262
.definelabel gMarioOnMerryGoRound, 0x80361264
 
.definelabel gDebugPrintState1, 0x80361290
.definelabel gDebugPrintState2, 0x803612a0
 
.definelabel sMarioOnFlyingCarpet, 0x803612b0
.definelabel sSurfaceTypeBelowShadow, 0x803612b2
.definelabel gShadowAboveWaterOrLava, 0x803612b4
.definelabel gMarioOnIceOrCarpet, 0x803612b5
 
.definelabel sSkyBoxInfo, 0x803612c0
 
.definelabel gMovetexLastTextureId, 0x803612e0
 
.definelabel gFlyingCarpetState, 0x803612f0
 
.definelabel gPaintingMarioFloorType, 0x80361300
.definelabel gPaintingMarioXPos, 0x80361304
.definelabel gPaintingMarioYPos, 0x80361308
.definelabel gPaintingMarioZPos, 0x8036130c
.definelabel gPaintingMesh, 0x80361310
.definelabel gPaintingTriNorms, 0x80361314
.definelabel gRipplingPainting, 0x80361318
.definelabel gDddPaintingStatus, 0x8036131c
 
.definelabel sTextLabels, 0x80361320
 
.definelabel gDialogColorFadeTimer, 0x803613f0
.definelabel gLastDialogLineNum, 0x803613f2
.definelabel gDialogVariable, 0x803613f4
.definelabel gDialogTextAlpha, 0x803613f8
.definelabel gCutsceneMsgXOffset, 0x803613fa
.definelabel gCutsceneMsgYOffset, 0x803613fc
.definelabel gRedCoinsCollected, 0x803613fe
 
.definelabel gEnvFxBuffer, 0x80361400
.definelabel gSnowCylinderLastPos, 0x80361408
.definelabel gSnowParticleCount, 0x80361414
.definelabel gSnowParticleMaxCount, 0x80361416
 
.definelabel gEnvFxBubbleConfig, 0x80361420
 
.definelabel sNumActiveFirePiranhaPlants, 0x80361460
.definelabel sNumKilledFirePiranhaPlants, 0x80361464
.definelabel sObjSavedPosX, 0x80361468
.definelabel sObjSavedPosY, 0x8036146c
.definelabel sObjSavedPosZ, 0x80361470
.definelabel sMontyMoleHoleList, 0x80361474
.definelabel sMontyMoleKillStreak, 0x80361478
.definelabel sMontyMoleLastKilledPosX, 0x8036147c
.definelabel sMontyMoleLastKilledPosY, 0x80361480
.definelabel sMontyMoleLastKilledPosZ, 0x80361484
.definelabel sMasterTreadmill, 0x80361488
 
.definelabel gCurrAiBuffer, 0x80361490
.definelabel sSoundRequests, 0x80361498
.definelabel D_80360928, 0x80361c98
.definelabel sUsedChannelsForSoundBank, 0x80361f98
.definelabel sCurrentSound, 0x80361fa8
.definelabel sSoundBanks, 0x80361fb8
.definelabel sSoundMovingSpeed, 0x80364b78
.definelabel sBackgroundMusicTargetVolume, 0x80364b82
.definelabel sBackgroundMusicQueue, 0x80364b88
 
.definelabel __osEventStateTab, 0x80364ba0
 
.definelabel D_803638B0, 0x80364c20
 
.definelabel piMgrThread, 0x80365e70
.definelabel piMgrStack, 0x80366020
.definelabel __osPiMesgQueue, 0x80367020
.definelabel piMgrMesgBuff, 0x80367038
 
.definelabel D_80365CD0, 0x80367040
 
.definelabel _osContCmdBuf, 0x80367050
.definelabel _osContPifCtrl, 0x8036708c
 
.definelabel _osLastSentSiCmd, 0x80367090
.definelabel _osContNumControllers, 0x80367091
.definelabel D_80365D28, 0x80367098
.definelabel _osContMesgQueue, 0x803670b8
.definelabel _osContMesgBuff, 0x803670d0
 
.definelabel __osBaseTimer, 0x803670f0
.definelabel __osCurrentTime, 0x80367110
.definelabel __osBaseCounter, 0x80367118
.definelabel __osViIntrCount, 0x8036711c
.definelabel __osTimerCounter, 0x80367120
 
.definelabel osPiMesgBuff, 0x80367130
.definelabel gOsPiMessageQueue, 0x80367138
 
.definelabel osSiMesgBuff, 0x80367150
.definelabel gOsSiMessageQueue, 0x80367158
 
.definelabel D_80365E00, 0x80367170
.definelabel D_80365E3C, 0x803671ac
 
.definelabel D_80365E40, 0x803671b0
 
.definelabel gInterruptedThread, 0x803672b0

.definelabel gPauseScreenMode, 0x8033bace

.endif // _VARIABLES_ASM_
