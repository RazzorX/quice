unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, DB, DBCFile, MyDataModule,
  Menus, Registry, ShellAPI,
  CheckQuestThreadUnit, Buttons, About, xpman, ActnList, ExtActns, Mask, Grids, TextFieldEditorUnit,
  JvExComCtrls, JvListView, JvExMask, JvToolEdit, DBGrids, JvExDBGrids, JvDBGrid, JvComponentBase,
  JvUrlListGrabber, JvUrlGrabbers, JvExControls, JvLinkLabel, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, ZConnection, ZSqlProcessor, LocNPCFrame, ZAbstractConnection,
  System.Actions, System.UITypes, System.Types;

const
{$IFDEF CMANGOS}
  SCRIPT_TABLE_CREATURE_MOVEMENT = 'dbscripts_on_creature_movement';
  SCRIPT_TABLE_CREATURE_DEATH = 'dbscripts_on_creature_death';
  SCRIPT_TABLE_EVENT = 'dbscripts_on_event';
  SCRIPT_TABLE_GO = 'dbscripts_on_go_use';
  SCRIPT_TABLE_GO_TEMPLATE = 'dbscripts_on_go_template_use';
  SCRIPT_TABLE_GOSSIP = 'dbscripts_on_gossip';
  SCRIPT_TABLE_QUEST_END = 'dbscripts_on_quest_end';
  SCRIPT_TABLE_QUEST_START =  'dbscripts_on_quest_start';
  SCRIPT_TABLE_SPELL = 'dbscripts_on_spell';
  SCRIPT_TABLE_RELAY = 'dbscripts_on_relay';
  SCRIPT_TABLE_RND_TMPL = 'dbscript_random_templates';
  TABLE_DB_SCRIPT_STRING = 'dbscript_string';
{$ENDIF}

  SCRIPT_TAB_NO_QUEST = 8;
  SCRIPT_TAB_NO_CREATURE = 23;
  SCRIPT_TAB_NO_GAMEOBJECT = 5;
  SCRIPT_TAB_NO_ITEM = 11;
  SCRIPT_TAB_NO_OTHER = 5;
  SCRIPT_TAB_NO_CHARACTER = 3;
  SCRIPT_TAB_NO_DBSCRIPTS_ON = 12;
  
  TAB_NO_QUEST_MAIL_LOOT = 6;
  
  TAB_NO_NPC_CREATURE_TEMPLATE = 1;
  TAB_NO_NPC_CREATURE_LOCATION = 2;
  TAB_NO_NPC_CREATURE_MOVEMENT = 3;
  TAB_NO_NPC_CREATURE_MOVEMENT_TEMPLATE = 4;
  TAB_NO_NPC_CREATURE_MODEL_INFO = 5;
  TAB_NO_NPC_EQUIP_TEMPLATE = 6;
  TAB_NO_NPC_CREATURE_LOOT = 7;
  TAB_NO_NPC_PICKPOCKET_LOOT = 8;
  TAB_NO_NPC_SKIN_LOOT = 9;
  TAB_NO_NPC_VENDOR = 10;
  TAB_NO_NPC_TRAINER = 11;
  TAB_NO_NPC_CREATURE_TEMPLATE_ADDON = 12;
  TAB_NO_NPC_CREATURE_ADDON = 13;
  TAB_NO_NPC_GOSSIP = 14;
  TAB_NO_NPC_CREATURE_ONKILL_REP = 15;
  TAB_NO_NPC_INVOLVED_IN = 16;
  TAB_NO_NPC_CREATURE_AI_EVENT = 17;
  TAB_NO_NPC_LOCALES_TEXT = 18;
  TAB_NO_NPC_VENDOR_TEMPLATE = 19;
  TAB_NO_NPC_TRAINER_TEMPLATE = 20;
  TAB_NO_NPC_GOSSIP_MENU = 21;
  TAB_NO_NPC_CREATURE_TEMPLATE_SPELLS = 22;
  
  TAB_NO_DBSCRIPT_STRING = 0;
  TAB_NO_DBSCRIPT_QUEST_START = 1;
  TAB_NO_DBSCRIPT_QUEST_END = 2;
  TAB_NO_DBSCRIPT_CREATURE_MOVEMENT = 3;
  TAB_NO_DBSCRIPT_CREATURE_DEATH = 4;
  TAB_NO_DBSCRIPT_GO = 5;
  TAB_NO_DBSCRIPT_GO_TEMPLATE = 6;
  TAB_NO_DBSCRIPT_EVENT = 7;
  TAB_NO_DBSCRIPT_GOSSIP = 8;
  TAB_NO_DBSCRIPT_SPELL = 9;
  TAB_NO_DBSCRIPT_RELAY = 10;
  TAB_NO_DBSCRIPT_RND_TMPL = 11;

  WM_FREEQL = WM_USER + 1;

  PFX_QUEST_TEMPLATE = 'qt';
  PFX_CREATURE_TEMPLATE = 'ct';
  PFX_CREATURE_ONKILL_REPUTATION = 'ck';
  PFX_CREATURE = 'cl';
  PFX_CREATURE_ADDON = 'ca';
  PFX_CREATURE_TEMPLATE_ADDON = 'cd';
  PFX_CREATURE_TEMPLATE_SPELLS = 'cu';
  PFX_CREATURE_EQUIP_TEMPLATE = 'ce';
  PFX_CREATURE_MODEL_INFO = 'ci';
  PFX_CREATURE_MOVEMENT = 'cm';
  PFX_CREATURE_MOVEMENT_TEMPLATE = 'cmt';
  PFX_CREATURE_LOOT_TEMPLATE = 'co';
  PFX_CREATURE_EVENTAI = 'cn';
  PFX_CREATURE_GOSSIP_MENU = 'cgm';
  PFX_CREATURE_GOSSIP_MENU_OPTION = 'cgmo';
  PFX_PICKPOCKETING_LOOT_TEMPLATE = 'cp';
  PFX_SKINNING_LOOT_TEMPLATE = 'cs';
  PFX_NPC_VENDOR = 'cv';
  PFX_NPC_GOSSIP = 'cg';
  PFX_NPC_TEXT = 'cx';
  PFX_NPC_TRAINER = 'cr';
  PFX_GAMEOBJECT_TEMPLATE = 'gt';
  PFX_GAME_EVENT = 'ge';
  PFX_GAMEOBJECT = 'gl';
  PFX_GAMEOBJECT_LOOT_TEMPLATE = 'go';
  PFX_MAIL_LOOT_TEMPLATE = 'ml';
  PFX_ITEM_TEMPLATE = 'it';
  PFX_ITEM_LOOT_TEMPLATE = 'il';
  PFX_ITEM_ENCHANTMENT_TEMPLATE = 'ie';
  PFX_DISENCHANT_LOOT_TEMPLATE = 'id';
  PFX_PROSPECTING_LOOT_TEMPLATE = 'ip';
  PFX_MILLING_LOOT_TEMPLATE = 'im';
  PFX_REFERENCE_LOOT_TEMPLATE = 'ir';
  PFX_SPELL_LOOT_TEMPLATE = 'sl';
  PFX_PAGE_TEXT = 'pt';
  PFX_FISHING_LOOT_TEMPLATE = 'ot';
  PFX_CHARACTER = 'ht';
  PFX_CHARACTER_INVENTORY = 'hi';
  mob_eventai = 'EventAI';
  PFX_LOCALES_QUEST = 'lq';
  PFX_LOCALES_NPC_TEXT = 'lx';
  PFX_NPC_VENDOR_TEMPLATE = 'cvt';
  PFX_NPC_TRAINER_TEMPLATE = 'crt';
  PFX_CONDITIONS = 'con';
  PFX_DB_SCRIPT_STRING = 'dbs';
  PFX_DBSCRIPTS_ON_EVENT = 'doe';
  PFX_DBSCRIPTS_ON_GOSSIP = 'dog';
  PFX_DBSCRIPTS_ON_SPELL = 'dos';
  PFX_DBSCRIPTS_ON_RELAY = 'dor';
  PFX_DBSCRIPTS_ON_RND_TMPL = 'rt';
  PFX_DBSCRIPTS_ON_QUEST_START = 'ss';
  PFX_DBSCRIPTS_ON_QUEST_END = 'es';
  PFX_DBSCRIPTS_ON_CREATURE_MOVEMENT = 'cms';
  PFX_DBSCRIPTS_ON_CREATURE_DEATH = 'cds';
  PFX_DBSCRIPTS_ON_GO_USE = 'gb';
  PFX_DBSCRIPTS_ON_GO_TEMPLATE_USE = 'gtb';
  PFX_QUESTGIVER_GREETING = 'qg';
  PFX_LOC_QUESTGIVER_GREETING = 'lqg';
  PFX_TAXI_SHORTCUTS = 'ts';
  PFX_TRAINER_GREETING = 'tg';
  PFX_LOCALES_TRAINER_GREETING = 'ltg';

type
  TSyntaxStyle = (ssInsertDelete, ssReplace, ssUpdate);
  TParameter = (tpInteger, tpFloat, tpString, tpDate, tpTime, tpDateTime, tpCurrency, tpBinaryData, tpBool);
  TRootKey = (CurrentUser, LocalMachine);

  TDateTimeRepresent = (ttTime, ttDate, ttDateTime);

  TLabeledEdit = class(ExtCtrls.TLabeledEdit)
  published
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
  end;

  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    MyMangosConnection: TZConnection;
    MyLootQuery: TZQuery;
    MyQuery: TZQuery;
    MyQueryAll: TZQuery;
    MyTempQuery: TZQuery;
    nLine1: TMenuItem;
    nLine2: TMenuItem;
    nLine4: TMenuItem;
    nLine5: TMenuItem;
    nLine6: TMenuItem;
    nLine7: TMenuItem;
    nHelp: TMenuItem;
    nAbout: TMenuItem;
    nBrowseCreature: TMenuItem;
    nBrowseGO: TMenuItem;
    nBrowseSite: TMenuItem;
    nCheckQuest: TMenuItem;
    nColumns: TMenuItem;
    nDeleteCreature: TMenuItem;
    nDeleteGo: TMenuItem;
    nDeleteQuest: TMenuItem;
    nEditCreature: TMenuItem;
    nEditGO: TMenuItem;
    nExit: TMenuItem;
    nFile: TMenuItem;
    nLanguage: TMenuItem;
    nEditQuest: TMenuItem;
    nSettings: TMenuItem;
    nSite: TMenuItem;
    pmCreature: TPopupMenu;
    pmGO: TPopupMenu;
    pmQuest: TPopupMenu;
    pmBrowseSite: TPopupMenu;
    pmwowhead: TMenuItem;
    pmthottbot: TMenuItem;
    pmallakhazam: TMenuItem;
    pmItem: TPopupMenu;
    nEditItem: TMenuItem;
    N1: TMenuItem;
    nDeleteItem: TMenuItem;
    N2: TMenuItem;
    nBrowseItem: TMenuItem;
    nTools: TMenuItem;
    nRebuildSpellList: TMenuItem;
    DataSource: TDataSource;
    MySQLQuery: TZQuery;
    PageControl1: TPageControl;

    tsQuest: TTabSheet;
    pnQuestTop: TPanel;
    PageControl2: TPageControl;
    tsSearch: TTabSheet;
    pnSearch: TPanel;
    lbQuestGiverSearch: TLabel;
    lbQuestTakerSearch: TLabel;
    edQuestID: TLabeledEdit;
    edQuestTitle: TLabeledEdit;
    edQuestGiverSearch: TJvComboEdit;
    edQuestTakerSearch: TJvComboEdit;
    btSearch: TBitBtn;
    btClear: TBitBtn;
    gbSpecialFlags: TGroupBox;
    edQuestFlagsSearch: TJvComboEdit;
    rbExact: TRadioButton;
    rbContain: TRadioButton;
    gbZoneOrSortSearch: TGroupBox;
    edZoneOrSortSearch: TJvComboEdit;
    rbZoneSearch: TRadioButton;
    rbQuestSortSearch: TRadioButton;
    lvQuest: TJvListView;
    Panel2: TPanel;
    btEditQuest: TBitBtn;
    btNewQuest: TBitBtn;
    btDeleteQuest: TBitBtn;
    btBrowseSite: TBitBtn;
    btCheckQuest: TBitBtn;
    btCheckAll: TBitBtn;
    StatusBar: TStatusBar;
    tsQuestPart1: TTabSheet;
    gbqtKeys: TGroupBox;
    lbEntry: TLabel;
    lbPrevQuestId: TLabel;
    lbNextQuestId: TLabel;
    lbNextQuestInChain: TLabel;
    edqtEntry: TJvComboEdit;
    edqtPrevQuestId: TJvComboEdit;
    edqtNextQuestId: TJvComboEdit;
    edqtExclusiveGroup: TLabeledEdit;
    edqtNextQuestInChain: TJvComboEdit;
    gbQuestSorting: TGroupBox;
    gbFlags: TGroupBox;
    lbType: TLabel;
    lbQuestFlags: TLabel;
    edqtLimitTime: TLabeledEdit;
    edqtType: TJvComboEdit;
    edqtQuestFlags: TJvComboEdit;
    gbRequirementsBegin: TGroupBox;
    lbRequiredMinRepFaction: TLabel;
    edqtRequiredMinRepValue: TLabeledEdit;
    edqtRequiredMinRepFaction: TJvComboEdit;
    gbSource: TGroupBox;
    lbSrcItemId: TLabel;
    lbSrcSpell: TLabel;
    edqtsrcItemCount: TLabeledEdit;
    edqtSrcItemId: TJvComboEdit;
    edqtSrcSpell: TJvComboEdit;
    gbDescription: TGroupBox;
    lDetails: TLabel;
    lObjectives: TLabel;
    lOfferRewardText: TLabel;
    lRequestItemsText: TLabel;
    lEndText: TLabel;
    edqtTitle: TLabeledEdit;
    edqtDetails: TMemo;
    edqtObjectives: TMemo;
    edqtOfferRewardText: TMemo;
    edqtRequestItemsText: TMemo;
    edqtEndText: TMemo;
    edqtObjectiveText1: TLabeledEdit;
    edqtObjectiveText2: TLabeledEdit;
    edqtObjectiveText3: TLabeledEdit;
    edqtObjectiveText4: TLabeledEdit;
    tsQuestPart2: TTabSheet;
    gbRequirementsEnd: TGroupBox;
    lbReqItemId1: TLabel;
    lbReqSourceId1: TLabel;
    lbReqCreatureOrGOId1: TLabel;
    lbReqSpellCast1: TLabel;
    edqtReqItemCount1: TLabeledEdit;
    edqtReqItemCount2: TLabeledEdit;
    edqtReqItemCount4: TLabeledEdit;
    edqtReqCreatureOrGOCount4: TLabeledEdit;
    edqtReqCreatureOrGOCount3: TLabeledEdit;
    edqtReqCreatureOrGOCount2: TLabeledEdit;
    edqtReqCreatureOrGOCount1: TLabeledEdit;
    edqtReqSourceCount1: TLabeledEdit;
    edqtReqSourceCount2: TLabeledEdit;
    edqtReqSourceCount3: TLabeledEdit;
    edqtReqSourceCount4: TLabeledEdit;
    edqtReqItemId1: TJvComboEdit;
    edqtReqItemId2: TJvComboEdit;
    edqtReqItemId3: TJvComboEdit;
    edqtReqItemId4: TJvComboEdit;
    edqtReqSourceId1: TJvComboEdit;
    edqtReqSourceId2: TJvComboEdit;
    edqtReqSourceId3: TJvComboEdit;
    edqtReqSourceId4: TJvComboEdit;
    edqtReqCreatureOrGOId4: TJvComboEdit;
    edqtReqCreatureOrGOId3: TJvComboEdit;
    edqtReqCreatureOrGOId2: TJvComboEdit;
    edqtReqCreatureOrGOId1: TJvComboEdit;
    edqtReqSpellCast1: TJvComboEdit;
    edqtReqSpellCast2: TJvComboEdit;
    edqtReqSpellCast3: TJvComboEdit;
    edqtReqSpellCast4: TJvComboEdit;
    gbRewards: TGroupBox;
    lbRewChoiceItemId1: TLabel;
    lbRewItemId1: TLabel;
    lbRewRepFaction1: TLabel;
    lbRewSpell: TLabel;
    edqtRewChoiceItemCount1: TLabeledEdit;
    edqtRewChoiceItemCount2: TLabeledEdit;
    edqtRewChoiceItemCount3: TLabeledEdit;
    edqtRewChoiceItemCount4: TLabeledEdit;
    edqtRewChoiceItemCount5: TLabeledEdit;
    edqtRewChoiceItemCount6: TLabeledEdit;
    edqtRewItemCount1: TLabeledEdit;
    edqtRewItemCount2: TLabeledEdit;
    edqtRewItemCount3: TLabeledEdit;
    edqtRewItemCount4: TLabeledEdit;
    edqtRewRepValue1: TLabeledEdit;
    edqtRewRepValue2: TLabeledEdit;
    edqtRewOrReqMoney: TLabeledEdit;
    edqtRewMoneyMaxLevel: TLabeledEdit;
    edqtRewRepValue3: TLabeledEdit;
    edqtRewRepValue4: TLabeledEdit;
    edqtRewRepValue5: TLabeledEdit;
    edqtRewChoiceItemId1: TJvComboEdit;
    edqtRewItemId1: TJvComboEdit;
    edqtRewRepFaction1: TJvComboEdit;
    edqtRewSpell: TJvComboEdit;
    edqtRewChoiceItemId2: TJvComboEdit;
    edqtRewChoiceItemId3: TJvComboEdit;
    edqtRewChoiceItemId4: TJvComboEdit;
    edqtRewChoiceItemId5: TJvComboEdit;
    edqtRewChoiceItemId6: TJvComboEdit;
    edqtRewItemId2: TJvComboEdit;
    edqtRewItemId3: TJvComboEdit;
    edqtRewItemId4: TJvComboEdit;
    edqtRewRepFaction2: TJvComboEdit;
    edqtRewRepFaction3: TJvComboEdit;
    edqtRewRepFaction4: TJvComboEdit;
    edqtRewRepFaction5: TJvComboEdit;
    gbOther: TGroupBox;
    edqtIncompleteEmote: TJvComboEdit;
    edqtCompleteEmote: TJvComboEdit;
    edqtDetailsEmote1: TJvComboEdit;
    edqtDetailsEmote2: TJvComboEdit;
    edqtDetailsEmote3: TJvComboEdit;
    edqtDetailsEmote4: TJvComboEdit;
    edqtOfferRewardEmote1: TJvComboEdit;
    edqtOfferRewardEmote2: TJvComboEdit;
    edqtOfferRewardEmote3: TJvComboEdit;
    edqtOfferRewardEmote4: TJvComboEdit;
    gbAreatrigger: TGroupBox;
    lbAreatrigger: TLabel;
    edqtAreatrigger: TJvComboEdit;
    tsQuestGiver: TTabSheet;
    lbQuestGiverInfo: TLabel;
    lbLocationOrLoot: TLabel;
    lvqtGiverTemplate: TJvListView;
    lvqtGiverLocation: TJvListView;
    tsQuestTaker: TTabSheet;
    lbQuestTakerInfo: TLabel;
    lbQuestTakerLocation: TLabel;
    lvqtTakerTemplate: TJvListView;
    lvqtTakerLocation: TJvListView;
    tsScriptTab: TTabSheet;
    btCopyToClipboard: TButton;
    btExecuteScript: TButton;
    meqtLog: TMemo;
    meqtScript: TMemo;
    tsCreature: TTabSheet;
    PageControl3: TPageControl;
    tsSearchCreature: TTabSheet;
    Panel4: TPanel;
    edSearchCreatureEntry: TLabeledEdit;
    edSearchCreatureName: TLabeledEdit;
    btSearchCreature: TBitBtn;
    btClearSearchCreature: TBitBtn;
    edSearchCreatureSubName: TLabeledEdit;
    gbnpcflag: TGroupBox;
    edSearchCreaturenpcflag: TJvComboEdit;
    rbExactnpcflag: TRadioButton;
    rbContainnpcflag: TRadioButton;
    lvSearchCreature: TJvListView;
    Panel5: TPanel;
    btEditCreature: TBitBtn;
    btNewCreature: TBitBtn;
    btDeleteCreature: TBitBtn;
    btBrowseCreature: TBitBtn;
    StatusBarCreature: TStatusBar;
    tsEditCreature: TTabSheet;
    gbCreature: TGroupBox;
    lbctEntry: TLabel;
    edctEntry: TJvComboEdit;
    edctModelId1: TLabeledEdit;
    edctModelId3: TLabeledEdit;
    edctName: TLabeledEdit;
    edctSubName: TLabeledEdit;
    edctMinLevel: TLabeledEdit;
    edctMaxLevel: TLabeledEdit;
    edctMinLevelHealth: TLabeledEdit;
    edctMaxLevelHealth: TLabeledEdit;
    edctMinLevelMana: TLabeledEdit;
    edctMaxLevelMana: TLabeledEdit;
    edctMinLootGold: TLabeledEdit;
    edctMaxLootGold: TLabeledEdit;
    gbCreature2: TGroupBox;
    lbctfaction: TLabel;
    lbctnpcflag: TLabel;
    lbctrank: TLabel;
    lbctfamily: TLabel;
    lbcttype: TLabel;
    edctMeleeAttackPower: TLabeledEdit;
    edctMeleeBaseAttackTime: TLabeledEdit;
    edctRangedBaseAttackTime: TLabeledEdit;
    edctRangedAttackPower: TLabeledEdit;
    edctFaction: TJvComboEdit;
    edctNpcFlags: TJvComboEdit;
    edctRank: TJvComboEdit;
    edctFamily: TJvComboEdit;
    edctCreatureType: TJvComboEdit;
    edctMinMeleeDmg: TLabeledEdit;
    edctMaxMeleeDmg: TLabeledEdit;
    edctMinRangedDmg: TLabeledEdit;
    edctMaxRangedDmg: TLabeledEdit;
    gbLoot: TGroupBox;
    edctLootId: TLabeledEdit;
    edctPickpocketLootId: TLabeledEdit;
    edctSkinningLootId: TLabeledEdit;
    gbResistance: TGroupBox;
    edctResistanceHoly: TLabeledEdit;
    edctResistanceFire: TLabeledEdit;
    edctResistanceNature: TLabeledEdit;
    edctResistanceFrost: TLabeledEdit;
    edctResistanceShadow: TLabeledEdit;
    edctResistanceArcane: TLabeledEdit;
    gbctbehaviour: TGroupBox;
    edctAIName: TLabeledEdit;
    edctScriptName: TLabeledEdit;
    gbTrainer: TGroupBox;
    lbcttrainer_type: TLabel;
    lbcttrainer_spell: TLabel;
    lbctclass: TLabel;
    lbctrace: TLabel;
    edctTrainerType: TJvComboEdit;
    edctTrainerSpell: TJvComboEdit;
    edctTrainerClass: TJvComboEdit;
    edctTrainerRace: TJvComboEdit;
    gbArmorSpeed: TGroupBox;
    edctArmor: TLabeledEdit;
    edctSpeedWalk: TLabeledEdit;
    btScriptCreatureTemplate: TButton;
    tsCreatureLocation: TTabSheet;
    lvclCreatureLocation: TJvListView;
    edclposition_x: TLabeledEdit;
    edclposition_y: TLabeledEdit;
    edclposition_z: TLabeledEdit;
    edclorientation: TLabeledEdit;
    edclspawntimesecsmin: TLabeledEdit;
    edclspawndist: TLabeledEdit;
    edclcurrentwaypoint: TLabeledEdit;
    edclspawn_position_x: TLabeledEdit;
    edclspawn_position_y: TLabeledEdit;
    edclspawn_position_z: TLabeledEdit;
    edclcurhealth: TLabeledEdit;
    edclcurmana: TLabeledEdit;
    edclDeathState: TLabeledEdit;
    edclMovementType: TLabeledEdit;
    btScriptCreatureLocation: TButton;
    btScriptCreatureLocationCustomToAll: TButton;
    tsCreatureLoot: TTabSheet;
    lbcoitem: TLabel;
    btCreatureLootAdd: TSpeedButton;
    btCreatureLootUpd: TSpeedButton;
    btCreatureLootDel: TSpeedButton;
    lvcoCreatureLoot: TJvListView;
    edcoentry: TLabeledEdit;
    edcoChanceOrQuestChance: TLabeledEdit;
    edcogroupid: TLabeledEdit;
    edcomincountOrRef: TLabeledEdit;
    edcomaxcount: TLabeledEdit;
    edcoitem: TJvComboEdit;
    btScriptCreatureLoot: TButton;
    btFullScriptCreatureLoot: TButton;
    tsPickpocketLoot: TTabSheet;
    lbcpitem: TLabel;
    btPickpocketLootAdd: TSpeedButton;
    btPickpocketLootUpd: TSpeedButton;
    btPickpocketLootDel: TSpeedButton;
    lvcoPickpocketLoot: TJvListView;
    edcpentry: TLabeledEdit;
    edcpChanceOrQuestChance: TLabeledEdit;
    edcpgroupid: TLabeledEdit;
    edcpmincountOrRef: TLabeledEdit;
    edcpmaxcount: TLabeledEdit;
    edcpitem: TJvComboEdit;
    btScriptPickpocketLoot: TButton;
    btFullScriptPickpocketLoot: TButton;
    tsSkinLoot: TTabSheet;
    lbcsitem: TLabel;
    btSkinLootAdd: TSpeedButton;
    btSkinLootUpd: TSpeedButton;
    btSkinLootDel: TSpeedButton;
    lvcoSkinLoot: TJvListView;
    edcsentry: TLabeledEdit;
    edcsChanceOrQuestChance: TLabeledEdit;
    edcsgroupid: TLabeledEdit;
    edcsmincountOrRef: TLabeledEdit;
    edcsmaxcount: TLabeledEdit;
    edcsitem: TJvComboEdit;
    btScriptSkinLoot: TButton;
    btFullScriptSkinLoot: TButton;
    tsNPCVendor: TTabSheet;
    lbcvitem: TLabel;
    btVendorAdd: TSpeedButton;
    btVendorUpd: TSpeedButton;
    btVendorDel: TSpeedButton;
    lvcvNPCVendor: TJvListView;
    edcventry: TLabeledEdit;
    edcvitem: TJvComboEdit;
    edcvmaxcount: TLabeledEdit;
    edcvincrtime: TLabeledEdit;
    btScriptNPCVendor: TButton;
    btFullScriptVendor: TButton;
    tsNPCTrainer: TTabSheet;
    lbcrspell: TLabel;
    btTrainerAdd: TSpeedButton;
    btTrainerUpd: TSpeedButton;
    btTrainerDel: TSpeedButton;
    lbcrreqskill: TLabel;
    lvcrNPCTrainer: TJvListView;
    edcrentry: TLabeledEdit;
    edcrspell: TJvComboEdit;
    edcrspellcost: TLabeledEdit;
    btScriptNPCTrainer: TButton;
    edcrreqskillvalue: TLabeledEdit;
    edcrreqlevel: TLabeledEdit;
    btFullScriptTrainer: TButton;
    edcrreqskill: TJvComboEdit;
    tsCreatureScript: TTabSheet;
    mectScript: TMemo;
    mectLog: TMemo;
    btCopyToClipboardCreature: TButton;
    btExecuteCreatureScript: TButton;
    Panel3: TPanel;
    tsGameObject: TTabSheet;
    PageControl4: TPageControl;
    tsSearchGO: TTabSheet;
    Panel6: TPanel;
    lbSearchGOtype: TLabel;
    lbSearchGOfaction: TLabel;
    edSearchGOEntry: TLabeledEdit;
    edSearchGOName: TLabeledEdit;
    btSearchGO: TBitBtn;
    btClearSearchGO: TBitBtn;
    edSearchGOtype: TJvComboEdit;
    edSearchGOfaction: TJvComboEdit;
    lvSearchGO: TJvListView;
    Panel7: TPanel;
    btEditGO: TBitBtn;
    btNewGO: TBitBtn;
    btDeleteGO: TBitBtn;
    btBrowseGO: TBitBtn;
    StatusBarGO: TStatusBar;
    tsEditGO: TTabSheet;
    gbGO1: TGroupBox;
    lbgtentry: TLabel;
    lbgtfaction: TLabel;
    lbgttype: TLabel;
    edgtentry: TJvComboEdit;
    edgtname: TLabeledEdit;
    edgtdisplayId: TLabeledEdit;
    edgtsize: TLabeledEdit;
    edgtScriptName: TLabeledEdit;
    edgtfaction: TJvComboEdit;
    edgttype: TJvComboEdit;
    btScriptGOTemplate: TButton;
    gbGOsounds: TGroupBox;
    edgtdata0: TLabeledEdit;
    edgtdata1: TLabeledEdit;
    edgtdata2: TLabeledEdit;
    edgtdata3: TLabeledEdit;
    edgtdata4: TLabeledEdit;
    edgtdata5: TLabeledEdit;
    edgtdata6: TLabeledEdit;
    edgtdata7: TLabeledEdit;
    edgtdata8: TLabeledEdit;
    edgtdata9: TLabeledEdit;
    edgtdata10: TLabeledEdit;
    edgtdata12: TLabeledEdit;
    edgtdata13: TLabeledEdit;
    edgtdata14: TLabeledEdit;
    edgtdata15: TLabeledEdit;
    edgtdata16: TLabeledEdit;
    edgtdata17: TLabeledEdit;
    edgtdata18: TLabeledEdit;
    edgtdata19: TLabeledEdit;
    edgtdata11: TLabeledEdit;
    edgtdata20: TLabeledEdit;
    edgtdata21: TLabeledEdit;
    edgtdata22: TLabeledEdit;
    edgtdata23: TLabeledEdit;
    tsGOLoot: TTabSheet;
    lbgoitem: TLabel;
    btGOLootAdd: TSpeedButton;
    btGOLootUpd: TSpeedButton;
    btGOLootDel: TSpeedButton;
    btMailLootAdd: TSpeedButton;
    btMailLootUpd: TSpeedButton;
    btMailLootDel: TSpeedButton;
    lvgoGOLoot: TJvListView;
    lvmlMailLoot: TJvListView;
    edgoentry: TLabeledEdit;
    edgoChanceOrQuestChance: TLabeledEdit;
    edgogroupid: TLabeledEdit;
    edgomincountOrRef: TLabeledEdit;
    edgomaxcount: TLabeledEdit;
    edgoitem: TJvComboEdit;
    edmlentry: TLabeledEdit;
    edmlChanceOrQuestChance: TLabeledEdit;
    edmlgroupid: TLabeledEdit;
    edmlmincountOrRef: TLabeledEdit;
    edmlmaxcount: TLabeledEdit;
    edmlitem: TJvComboEdit;
    btScriptGOLoot: TButton;
    btFullScriptGOLoot: TButton;
    tsGOScript: TTabSheet;
    megoScript: TMemo;
    megoLog: TMemo;
    btCopyToClipboardGO: TButton;
    btExecuteGOScript: TButton;
    Panel8: TPanel;
    tsItem: TTabSheet;
    Panel9: TPanel;
    tsSearchItem: TTabSheet;
    Panel10: TPanel;
    lbSearchItemSubClass: TLabel;
    lbSearchItemClass: TLabel;
    lbSearchItemItemset: TLabel;
    lbSearchItemInventoryType: TLabel;
    lbSearchItemQuality: TLabel;
    edSearchItemEntry: TLabeledEdit;
    edSearchItemName: TLabeledEdit;
    btSearchItem: TBitBtn;
    btClearSearchItem: TBitBtn;
    edSearchItemClass: TJvComboEdit;
    edSearchItemSubclass: TJvComboEdit;
    edSearchItemItemset: TJvComboEdit;
    edSearchItemInventoryType: TJvComboEdit;
    edSearchItemQuality: TJvComboEdit;
    lvSearchItem: TJvListView;
    Panel11: TPanel;
    btEditItem: TBitBtn;
    btNewItem: TBitBtn;
    btDeleteItem: TBitBtn;
    btBrowseItem: TBitBtn;
    StatusBarItem: TStatusBar;
    tsItemTemplate: TTabSheet;
    lbitentry: TLabel;
    lbitQuality: TLabel;
    lbitInventoryType: TLabel;
    lbitclass: TLabel;
    lbitsubclass: TLabel;
    lbitFlags: TLabel;
    btScriptItem: TButton;
    editentry: TJvComboEdit;
    editname: TLabeledEdit;
    editdisplayid: TLabeledEdit;
    editBuyCount: TLabeledEdit;
    editBuyPrice: TLabeledEdit;
    editSellPrice: TLabeledEdit;
    editmaxcount: TLabeledEdit;
    editstackable: TLabeledEdit;
    editContainerSlots: TLabeledEdit;
    editdescription: TLabeledEdit;
    gbitspell: TGroupBox;
    lbitspellid: TLabel;
    editspellcharges_1: TLabeledEdit;
    editspellcooldown_1: TLabeledEdit;
    editspellcategory_1: TLabeledEdit;
    editspellcategorycooldown_1: TLabeledEdit;
    editspellcharges_2: TLabeledEdit;
    editspellcooldown_2: TLabeledEdit;
    editspellcategory_2: TLabeledEdit;
    editspellcategorycooldown_2: TLabeledEdit;
    editspellcharges_3: TLabeledEdit;
    editspellcooldown_3: TLabeledEdit;
    editspellcategory_3: TLabeledEdit;
    editspellcharges_4: TLabeledEdit;
    editspellcooldown_4: TLabeledEdit;
    editspellcategory_4: TLabeledEdit;
    editspellcategorycooldown_4: TLabeledEdit;
    editspellcharges_5: TLabeledEdit;
    editspellcooldown_5: TLabeledEdit;
    editspellcategory_5: TLabeledEdit;
    editspellcategorycooldown_5: TLabeledEdit;
    editspellcategorycooldown_3: TLabeledEdit;
    editspellid_1: TJvComboEdit;
    editspellid_2: TJvComboEdit;
    editspellid_3: TJvComboEdit;
    editspellid_4: TJvComboEdit;
    editspellid_5: TJvComboEdit;
    gbitstats: TGroupBox;
    lbitstat_type: TLabel;
    editstat_value1: TLabeledEdit;
    editstat_value2: TLabeledEdit;
    editstat_value3: TLabeledEdit;
    editstat_value4: TLabeledEdit;
    editstat_value5: TLabeledEdit;
    editstat_value6: TLabeledEdit;
    editstat_value7: TLabeledEdit;
    editstat_value8: TLabeledEdit;
    editstat_value9: TLabeledEdit;
    editstat_value10: TLabeledEdit;
    editstat_type1: TJvComboEdit;
    editstat_type2: TJvComboEdit;
    editstat_type3: TJvComboEdit;
    editstat_type4: TJvComboEdit;
    editstat_type5: TJvComboEdit;
    editstat_type6: TJvComboEdit;
    editstat_type7: TJvComboEdit;
    editstat_type8: TJvComboEdit;
    editstat_type9: TJvComboEdit;
    editstat_type10: TJvComboEdit;
    gbitsocket: TGroupBox;
    editsocketColor_1: TLabeledEdit;
    editsocketContent_1: TLabeledEdit;
    editsocketColor_2: TLabeledEdit;
    editsocketContent_2: TLabeledEdit;
    editsocketColor_3: TLabeledEdit;
    editsocketContent_3: TLabeledEdit;
    gbitRequirements: TGroupBox;
    lbitAllowableClass: TLabel;
    lbitAllowableRace: TLabel;
    lbitRequiredReputationFaction: TLabel;
    lbitRequiredReputationRank: TLabel;
    lbitrequiredspell: TLabel;
    lbitRequiredSkill: TLabel;
    editItemLevel: TLabeledEdit;
    editRequiredLevel: TLabeledEdit;
    editRequiredSkillRank: TLabeledEdit;
    editrequiredhonorrank: TLabeledEdit;
    editRequiredCityRank: TLabeledEdit;
    editRequiredDisenchantSkill: TLabeledEdit;
    editAllowableRace: TJvComboEdit;
    editAllowableClass: TJvComboEdit;
    editRequiredReputationFaction: TJvComboEdit;
    editRequiredReputationRank: TJvComboEdit;
    editrequiredspell: TJvComboEdit;
    editRequiredSkill: TJvComboEdit;
    gbitAmmo: TGroupBox;
    lbitbonding: TLabel;
    lbititemset: TLabel;
    editdelay: TLabeledEdit;
    editRangedModRange: TLabeledEdit;
    editMaxDurability: TLabeledEdit;
    editbonding: TJvComboEdit;
    edititemset: TJvComboEdit;
    gbitOther: TGroupBox;
    lbitLanguageID: TLabel;
    lbitPageMaterial: TLabel;
    lbitMaterial: TLabel;
    lbitBagFamily: TLabel;
    lbitsheath: TLabel;
    lbitPageText: TLabel;
    lbitMap: TLabel;
    editDisenchantID: TLabeledEdit;
    editstartquest: TLabeledEdit;
    editlockid: TLabeledEdit;
    editRandomSuffix: TLabeledEdit;
    editRandomProperty: TLabeledEdit;
    editTotemCategory: TLabeledEdit;
    editScriptName: TLabeledEdit;
    editLanguageID: TJvComboEdit;
    editPageMaterial: TJvComboEdit;
    editMaterial: TJvComboEdit;
    editsheath: TJvComboEdit;
    editBagFamily: TJvComboEdit;
    editunk0: TLabeledEdit;
    editPageText: TJvComboEdit;
    editMap: TJvComboEdit;
    editQuality: TJvComboEdit;
    editInventoryType: TJvComboEdit;
    editclass: TJvComboEdit;
    editsubclass: TJvComboEdit;
    editFlags: TJvComboEdit;
    tsItemLoot: TTabSheet;
    lbilitem: TLabel;
    btItemLootAdd: TSpeedButton;
    btItemLootUpd: TSpeedButton;
    btItemLootDel: TSpeedButton;
    lvitItemLoot: TJvListView;
    edilentry: TLabeledEdit;
    edilChanceOrQuestChance: TLabeledEdit;
    edilgroupid: TLabeledEdit;
    edilmincountOrRef: TLabeledEdit;
    edilmaxcount: TLabeledEdit;
    edilitem: TJvComboEdit;
    btScriptItemLoot: TButton;
    btFullScriptItemLoot: TButton;
    tsDisenchantLoot: TTabSheet;
    lbiditem: TLabel;
    btDisLootAdd: TSpeedButton;
    btDisLootUpd: TSpeedButton;
    btDisLootDel: TSpeedButton;
    lvitDisLoot: TJvListView;
    edidentry: TLabeledEdit;
    edidChanceOrQuestChance: TLabeledEdit;
    edidgroupid: TLabeledEdit;
    edidmincountOrRef: TLabeledEdit;
    edidmaxcount: TLabeledEdit;
    ediditem: TJvComboEdit;
    btScriptDisLoot: TButton;
    btFullScriptDisLoot: TButton;
    tsItemScript: TTabSheet;
    meitScript: TMemo;
    meitLog: TMemo;
    btCopyToClipboardItem: TButton;
    btExecuteItemScript: TButton;
    tsOther: TTabSheet;
    Panel12: TPanel;
    PageControl6: TPageControl;
    tsFishingLoot: TTabSheet;
    lbotitem: TLabel;
    btFishingLootAdd: TSpeedButton;
    btFishingLootUpd: TSpeedButton;
    btFishingLootDel: TSpeedButton;
    lbotentry: TLabel;
    lbotChoose: TLabel;
    lvotFishingLoot: TJvListView;
    edotChanceOrQuestChance: TLabeledEdit;
    edotgroupid: TLabeledEdit;
    edotmincountOrRef: TLabeledEdit;
    edotmaxcount: TLabeledEdit;
    edotitem: TJvComboEdit;
    btScriptFishingLoot: TButton;
    btFullScriptFishLoot: TButton;
    edotentry: TJvComboEdit;
    edotZone: TJvComboEdit;
    btGetLootForZone: TButton;
    tsPageText: TTabSheet;
    lvSearchPageText: TJvListView;
    GroupBox1: TGroupBox;
    btClearSearchPageText: TBitBtn;
    btSearchPageText: TBitBtn;
    edSearchPageTextNextPage: TLabeledEdit;
    edSearchPageTextText: TLabeledEdit;
    edSearchPageTextEntry: TLabeledEdit;
    Panel13: TPanel;
    lbptentry: TLabel;
    lbpttext: TLabel;
    lbptnext_page: TLabel;
    edptentry: TJvComboEdit;
    edptnext_page: TJvComboEdit;
    edpttext: TMemo;
    btScriptPageText: TButton;
    btScriptConditions: TButton;
    tsOtherScript: TTabSheet;
    meotScript: TMemo;
    meotLog: TMemo;
    btCopyToClipboardOther: TButton;
    btExecuteOtherScript: TButton;
    tsSQL: TTabSheet;
    Panel14: TPanel;
    PageControl7: TPageControl;
    tsSQL1: TTabSheet;
    Panel15: TPanel;
    btSQLOpen: TBitBtn;
    SQLEdit: TMemo;
    tsProspectingLoot: TTabSheet;
    lbipitem: TLabel;
    btProsLootAdd: TSpeedButton;
    btProsLootUpd: TSpeedButton;
    btProsLootDel: TSpeedButton;
    lvitProsLoot: TJvListView;
    edipentry: TLabeledEdit;
    edipChanceOrQuestChance: TLabeledEdit;
    edipgroupid: TLabeledEdit;
    edipmincountOrRef: TLabeledEdit;
    edipmaxcount: TLabeledEdit;
    edipitem: TJvComboEdit;
    btScriptProsLoot: TButton;
    btFullScriptProsLoot: TButton;
    tsStartScript: TTabSheet;
    tsCompleteScript: TTabSheet;
    lvssStartScript: TJvListView;
    edsscommand: TJvComboEdit;
    btssAdd: TSpeedButton;
    btssUpd: TSpeedButton;
    btssDel: TSpeedButton;
    edssdelay: TLabeledEdit;
    lbsscommand: TLabel;
    edssx: TLabeledEdit;
    edssy: TLabeledEdit;
    edssz: TLabeledEdit;
    edsso: TLabeledEdit;
    lvesEndScript: TJvListView;
    edescommand: TJvComboEdit;
    btesAdd: TSpeedButton;
    btesUpd: TSpeedButton;
    btesDel: TSpeedButton;
    edesdelay: TLabeledEdit;
    lbescommand: TLabel;
    edesx: TLabeledEdit;
    edesy: TLabeledEdit;
    edesz: TLabeledEdit;
    edeso: TLabeledEdit;
    tsEnchantment: TTabSheet;
    lvitEnchantment: TJvListView;
    edieentry: TLabeledEdit;
    ediechance: TLabeledEdit;
    btieShowScript: TButton;
    btieShowFullScript: TButton;
    btieEnchAdd: TSpeedButton;
    btieEnchUpd: TSpeedButton;
    btieEnchDel: TSpeedButton;
    edieench: TLabeledEdit;
    lbssStartScriptHint: TLabel;
    lbesCompleteScriptHint: TLabel;
    lbclCreatureLocationHint: TLabel;
    lbcoCreatureLootHint: TLabel;
    lbcoPickpocketLootHint: TLabel;
    lbcoSkinLootHint: TLabel;
    lbcvNPCVendorHint: TLabel;
    lbcvNPCTrainerHint: TLabel;
    tsGOLocation: TTabSheet;
    lvglGOLocation: TJvListView;
    edglguid: TLabeledEdit;
    edglid: TLabeledEdit;
    edglposition_x: TLabeledEdit;
    edglposition_y: TLabeledEdit;
    edglposition_z: TLabeledEdit;
    edglorientation: TLabeledEdit;
    btScriptGOLocation: TButton;
    edglrotation0: TLabeledEdit;
    edglrotation1: TLabeledEdit;
    edglrotation2: TLabeledEdit;
    edglrotation3: TLabeledEdit;
    edglspawntimesecsmin: TLabeledEdit;
    edglanimprogress: TLabeledEdit;
    edglstate: TLabeledEdit;
    lbglGOLocationHint: TLabel;
    lbgoGOLootHint: TLabel;
    lbitItemLootHint: TLabel;
    lbitDisLootHint: TLabel;
    lbitProsLootHint: TLabel;
    lbitItemEnchHint: TLabel;
    tsChars: TTabSheet;
    Panel1: TPanel;
    PageControl8: TPageControl;
    tsCharSearch: TTabSheet;
    Panel16: TPanel;
    edCharGuid: TLabeledEdit;
    edCharName: TLabeledEdit;
    btCharSearch: TBitBtn;
    btCharClear: TBitBtn;
    lvSearchChar: TJvListView;
    StatusBarChar: TStatusBar;
    edCharAccount: TLabeledEdit;
    CheckforUpdates1: TMenuItem;
    ActionList1: TActionList;
    BrowseURL1: TBrowseURL;
    nInternet: TMenuItem;
    rea: TTabSheet;
    edcaguid: TLabeledEdit;
    edcamount: TLabeledEdit;
    edcabytes1: TLabeledEdit;
    edcab2_0_sheath: TLabeledEdit;
    edcaemote: TJvComboEdit;
    edcaauras: TLabeledEdit;
    lbcaCreatureAddonHint: TLabel;
    btScriptCreatureAddon: TButton;
    editArmorDamageModifier: TLabeledEdit;
    tsItemLootedFrom: TTabSheet;
    lvitItemLootedFrom: TJvListView;
    nUninstall: TMenuItem;
    nPreferences: TMenuItem;
    tsGameEvents: TTabSheet;
    GroupBox2: TGroupBox;
    btClearSearchGameEvent: TBitBtn;
    btSearchGameEvent: TBitBtn;
    edSearchGameEventDesc: TLabeledEdit;
    edSearchGameEventEntry: TLabeledEdit;
    pnSelectedEventInfo: TPanel;
    edGameEventGOHint: TLabel;
    edGameEventCreatureHint: TLabel;
    lvGameEventCreature: TJvListView;
    lvGameEventGO: TJvListView;
    btgeCreatureGuidDel: TSpeedButton;
    btgeCreatureGuidAdd: TSpeedButton;
    edgeCreatureGuid: TJvComboEdit;
    btgeGOguidDel: TSpeedButton;
    btgeGOGuidAdd: TSpeedButton;
    edgeGOguid: TJvComboEdit;
    btScriptGameEvent: TButton;
    btgeCreatureGuidInv: TSpeedButton;
    btgeGOGuidInv: TSpeedButton;
    Panel17: TPanel;
    lvSearchGameEvent: TJvListView;
    Panel18: TPanel;
    btGameEventDel: TSpeedButton;
    btGameEventUpd: TSpeedButton;
    btGameEventAdd: TSpeedButton;
    edgedescription: TLabeledEdit;
    edgelength: TLabeledEdit;
    edgeoccurence: TLabeledEdit;
    edgeend_time: TLabeledEdit;
    edgestart_time: TLabeledEdit;
    edgeentry: TLabeledEdit;
    btFullScriptCreatureLocation: TButton;
    btFullScriptGOLocation: TButton;
    btAddQuestGiver: TSpeedButton;
    btDelQuestGiver: TSpeedButton;
    btAddQuestTaker: TSpeedButton;
    btDelQuestTaker: TSpeedButton;
    tsNPCgossip: TTabSheet;
    lbHintNPCGossip: TLabel;
    gbNPCgossip: TGroupBox;
    edcgnpc_guid: TLabeledEdit;
    btScriptNPCgossip: TButton;
    edcgtextid: TJvComboEdit;
    lbcgtextid: TLabel;
    gbNPCText: TGroupBox;
    btShowNPCtextScript: TButton;
    edcxID: TLabeledEdit;
    Panel19: TPanel;
    edqtRequiredMaxRepFaction: TJvComboEdit;
    edqtRequiredMaxRepValue: TLabeledEdit;
    lbRequiredMaxRepFaction: TLabel;
    UpDown2: TUpDown;
    UpDown1: TUpDown;
    edqtQuestLevel: TLabeledEdit;
    edqtMinLevel: TLabeledEdit;
    edqtRequiredSkillValue: TLabeledEdit;
    cbctRacialLeader: TCheckBox;
    edctDamageSchool: TLabeledEdit;
    nReconnect: TMenuItem;
    N3: TMenuItem;
    editspellppmRate_5: TLabeledEdit;
    editspellppmRate_4: TLabeledEdit;
    editspellppmRate_3: TLabeledEdit;
    editspellppmRate_2: TLabeledEdit;
    editspellppmRate_1: TLabeledEdit;
    tsCreatureUsed: TTabSheet;
    pcCreatureInfo: TPageControl;
    tsCreatureStarts: TTabSheet;
    tsCreatureEnds: TTabSheet;
    tsCreatureObjectiveOf: TTabSheet;
    lvCreatureStarts: TJvListView;
    lvCreatureEnds: TJvListView;
    lvCreatureObjectiveOf: TJvListView;
    Panel20: TPanel;
    tsGOInvolvedIn: TTabSheet;
    pcGameObjectInfo: TPageControl;
    tsGOStarts: TTabSheet;
    lvGameObjectStarts: TJvListView;
    tsGOEnds: TTabSheet;
    lvGameObjectEnds: TJvListView;
    tsGOObjectiveOf: TTabSheet;
    lvGameObjectObjectiveOf: TJvListView;
    Panel21: TPanel;
    tsItemInvolvedIn: TTabSheet;
    Panel22: TPanel;
    pcItemInfo: TPageControl;
    tsItemStarts: TTabSheet;
    lvItemStarts: TJvListView;
    tsItemObjectiveOf: TTabSheet;
    lvItemObjectiveOf: TJvListView;
    tsItemSourceFor: TTabSheet;
    lvItemSourceFor: TJvListView;
    tsItemProvidedFor: TTabSheet;
    tsItemRewardFrom: TTabSheet;
    lvItemProvidedFor: TJvListView;
    lvItemRewardFrom: TJvListView;
    tsCreatureMovement: TTabSheet;
    lvcmMovement: TJvListView;
    lbHintCreatureMovement: TLabel;
    btShowCreatureMovementScript: TButton;
    btFullCreatureMovementScript: TButton;
    btCreatureMvmntAdd: TSpeedButton;
    btCreatureMvmntUpd: TSpeedButton;
    btCreatureMvmntDel: TSpeedButton;
    edcmpoint: TLabeledEdit;
    edcmposition_x: TLabeledEdit;
    edcmposition_y: TLabeledEdit;
    edcmposition_z: TLabeledEdit;
    edcmwaittime: TLabeledEdit;
    edcmorientation: TLabeledEdit;
    lbqtDetailsEmote1: TLabel;
    lbqtIncompleteEmote: TLabel;
    lbqtCompleteEmote: TLabel;
    lbqtOfferRewardEmote1: TLabel;
    lbcaemote: TLabel;
    edctRegenerateStats: TLabeledEdit;
    tsCreatureModelInfo: TTabSheet;
    tsCreatureEquipTemplate: TTabSheet;
    Panel23: TPanel;
    btShowCreatureEquipmentScript: TButton;
    lvCreatureModelSearch: TJvListView;
    Panel24: TPanel;
    btCreatureModelSearch: TBitBtn;
    edCreatureModelSearch: TLabeledEdit;
    btShowCreatureModelInfoScript: TButton;
    edcibounding_radius: TLabeledEdit;
    edcicombat_reach: TLabeledEdit;
    edcigender: TLabeledEdit;
    edcimodelid_other_gender: TLabeledEdit;
    tsCreatureOnKillReputation: TTabSheet;
    edckRewOnKillRepValue1: TLabeledEdit;
    edckRewOnKillRepFaction1: TJvComboEdit;
    edckRewOnKillRepFaction2: TJvComboEdit;
    lbckRewOnKillRepFaction1: TLabel;
    lbckRewOnKillRepFaction2: TLabel;
    edckRewOnKillRepValue2: TLabeledEdit;
    edckMaxStanding1: TLabeledEdit;
    edckMaxStanding2: TLabeledEdit;
    cbckIsTeamAward1: TCheckBox;
    cbckIsTeamAward2: TCheckBox;
    cbckTeamDependent: TCheckBox;
    btScriptCreatureOnKillReputation: TButton;
    edckcreature_id: TLabeledEdit;
    editFoodType: TJvComboEdit;
    lbitFoodType: TLabel;
    tsCreatureTemplateAddon: TTabSheet;
    edcdentry: TLabeledEdit;
    btScriptCreatureTemplateAddon: TButton;
    btScriptCreatureTemplateSpells: TButton;
    edcdauras: TLabeledEdit;
    edcdbytes1: TLabeledEdit;
    edcdmount: TLabeledEdit;
    lbcdCreatureTemplateAddonHint: TLabel;
    edcdemote: TJvComboEdit;
    lbcdemote: TLabel;
    editGemProperties: TJvComboEdit;
    lbitGemProperties: TLabel;
    editsocketBonus: TJvComboEdit;
    lbitsocketBonus: TLabel;
    tsButtonScript: TTabSheet;
    lvgbGOScript: TJvListView;
    lvgtbGOTemplateScript: TJvListView;
    edgbo: TLabeledEdit;
    edgbz: TLabeledEdit;
    edgby: TLabeledEdit;
    edgbx: TLabeledEdit;
    edgbdelay: TLabeledEdit;
    edgbcommand: TJvComboEdit;
    lbhintGOButtonScript: TLabel;
    lbgbcommand: TLabel;
    btgbDel: TSpeedButton;
    btgbUpd: TSpeedButton;
    btgbAdd: TSpeedButton;
    btgbShowFullScript: TButton;
    btgtbShowFullScript: TButton;
    btBrowseQuestPopup: TBitBtn;
    btBrowseCreaturePopup: TBitBtn;
    btBrowseGOPopup: TBitBtn;
    btBrowseItemPopup: TBitBtn;
    editmaxMoneyLoot: TLabeledEdit;
    editminMoneyLoot: TLabeledEdit;
    edctModelId4: TLabeledEdit;
    edctModelId2: TLabeledEdit;
    edglmap: TJvComboEdit;
    lbglmap: TLabel;
    edclmap: TJvComboEdit;
    lbclmap: TLabel;
    tsCharacter: TTabSheet;
    edhtaccount: TLabeledEdit;
    edhtname: TLabeledEdit;
    edhtposition_x: TLabeledEdit;
    edhtposition_y: TLabeledEdit;
    edhtposition_z: TLabeledEdit;
    edhtorientation: TLabeledEdit;
    edhttotaltime: TLabeledEdit;
    edhtleveltime: TLabeledEdit;
    edhtlogout_time: TLabeledEdit;
    edhtrest_bonus: TLabeledEdit;
    edhtresettalents_cost: TLabeledEdit;
    edhtresettalents_time: TLabeledEdit;
    edhttrans_x: TLabeledEdit;
    edhttrans_y: TLabeledEdit;
    edhttrans_z: TLabeledEdit;
    edhttrans_o: TLabeledEdit;
    edhttransguid: TLabeledEdit;
    edhtstable_slots: TLabeledEdit;
    edhtat_login: TLabeledEdit;
    edhtpending_honor: TLabeledEdit;
    edhtlast_honor_date: TLabeledEdit;
    edhtlast_kill_date: TLabeledEdit;
    cbhtonline: TCheckBox;
    cbhtcinematic: TCheckBox;
    cbhtis_logout_resting: TCheckBox;
    cbhtat_login: TCheckBox;
    cbhtgmstate: TCheckBox;
    edhtdata: TJvComboEdit;
    lbhtdata: TLabel;
    edhtrace: TJvComboEdit;
    lbhtrace: TLabel;
    edhtclass: TJvComboEdit;
    lbhtclass: TLabel;
    edhtmap: TJvComboEdit;
    lbhtmap: TLabel;
    edhttaximask: TJvComboEdit;
    lbhttaximask: TLabel;
    edhtzone: TJvComboEdit;
    lbhtzone: TLabel;
    tsCharacterScript: TTabSheet;
    mehtScript: TMemo;
    mehtLog: TMemo;
    btCopyToClipboardChar: TButton;
    btExecuteScriptChar: TButton;
    btShowCharacterScript: TButton;
    lbhtguid: TLabel;
    edhtguid: TJvComboEdit;
    tsCharacterInventory: TTabSheet;
    btShowCharacterInventoryScript: TButton;
    btShowFULLCharacterInventoryScript: TButton;
    btCharInvDel: TSpeedButton;
    btCharInvUpd: TSpeedButton;
    btCharInvAdd: TSpeedButton;
    lvCharacterInventory: TJvListView;
    edhiguid: TLabeledEdit;
    edhiitem_template: TJvComboEdit;
    edhibag: TLabeledEdit;
    edhislot: TLabeledEdit;
    edhiitem: TLabeledEdit;
    lbhiitem_template: TLabel;
    edqtSpecialFlags: TJvComboEdit;
    lbqtSpecialFlags: TLabel;
    edqtRepObjectiveValue: TLabeledEdit;
    lbqtRepObjectiveFaction: TLabel;
    edqtRepObjectiveFaction: TJvComboEdit;
    editarea: TJvComboEdit;
    lbitarea: TLabel;
    JvDBGrid1: TJvDBGrid;
    JvHttpUrlGrabber: TJvHttpUrlGrabber;
    pmwowdb: TMenuItem;
    editspelltrigger_5: TJvComboEdit;
    editspelltrigger_4: TJvComboEdit;
    editspelltrigger_3: TJvComboEdit;
    editspelltrigger_2: TJvComboEdit;
    lbitspelltrigger: TLabel;
    editspelltrigger_1: TJvComboEdit;
    edctUnitFlags: TJvComboEdit;
    lbctunit_flags: TLabel;
    edctCreatureTypeFlags: TJvComboEdit;
    lbcttype_flags: TLabel;
    edctDynamicFlags: TJvComboEdit;
    lbctdynamicflags: TLabel;
    edgtflags: TJvComboEdit;
    lbgtflags: TLabel;
    lbctMovementType: TLabel;
    edctMovementType: TJvComboEdit;
    edctInhabitType: TJvComboEdit;
    lbctInhabitType: TLabel;
    tsCreatureEventAI: TTabSheet;
    Button1: TButton;
    Button2: TButton;
    lvcnEventAI: TJvListView;
    edcnid: TLabeledEdit;
    edcncreature_id: TLabeledEdit;
    edcnevent_type: TJvComboEdit;
    lbcnevent_type: TLabel;
    edcnevent_inverse_phase_mask: TJvComboEdit;
    lbcnevent_inverse_phase_mask: TLabel;
    edcnevent_param1: TJvComboEdit;
    lbcnevent_param1: TLabel;
    edcnevent_param2: TJvComboEdit;
    lbcnevent_param2: TLabel;
    edcnevent_param3: TJvComboEdit;
    lbcnevent_param3: TLabel;
    edcnaction1_param3: TJvComboEdit;
    lbcnaction1_param3: TLabel;
    lbcnaction1_param2: TLabel;
    edcnaction1_param2: TJvComboEdit;
    lbcnaction1_param1: TLabel;
    edcnaction1_param1: TJvComboEdit;
    lbcnaction1_type: TLabel;
    edcnaction1_type: TJvComboEdit;
    edcnaction2_param3: TJvComboEdit;
    lbcnaction2_param3: TLabel;
    edcnaction2_param2: TJvComboEdit;
    lbcnaction2_param2: TLabel;
    lbcnaction2_param1: TLabel;
    edcnaction2_param1: TJvComboEdit;
    edcnaction2_type: TJvComboEdit;
    lbcnaction2_type: TLabel;
    edcnaction3_param3: TJvComboEdit;
    lbcnaction3_param3: TLabel;
    edcnaction3_param2: TJvComboEdit;
    lbcnaction3_param2: TLabel;
    lbcnaction3_param1: TLabel;
    edcnaction3_param1: TJvComboEdit;
    edcnaction3_type: TJvComboEdit;
    lbcnaction3_type: TLabel;
    edcncomment: TLabeledEdit;
    linkEventAIInfo: TLabel;
    edctMechanicImmuneMask: TJvComboEdit;
    lbctmechanic_immune_mask: TLabel;
    ZSqlProcessor: TZSQLProcessor;
    nDBCDir: TMenuItem;
    Timer1: TTimer;
    edcnevent_chance: TLabeledEdit;
    edctIconName: TLabeledEdit;
    edgtcastBarCaption: TLabeledEdit;
    edSearchItemFlags: TJvComboEdit;
    lbSearchItemFlags: TLabel;
    edcvExtendedCost: TJvComboEdit;
    lbcvExtendedCost: TLabel;
    editDuration: TLabeledEdit;
    lbRewSpellCast: TLabel;
    edqtRewSpellCast: TJvComboEdit;
    edqtCharTitleId: TLabeledEdit;
    edcdmoveflags: TLabeledEdit;
    edcamoveflags: TLabeledEdit;
    edqtSuggestedPlayers: TLabeledEdit;
    edqtRequiredClasses: TJvComboEdit;
    edqtZoneOrSort: TJvComboEdit;
    rbqtQuestSort: TRadioButton;
    rbqtZoneID: TRadioButton;
    edqtRewMailDelaySecs: TLabeledEdit;
    edctDifficultyEntry1: TJvComboEdit;
    lbctdifficulty_entry_1: TLabel;
    lbcnevent_param4: TLabel;
    edcnevent_param4: TJvComboEdit;
    edqtRewHonorAddition: TLabeledEdit;
    edqtMethod: TLabeledEdit;
    pmruwowhead: TMenuItem;
    nEditCreatureAI: TMenuItem;
    N4: TMenuItem;
    btEventAIAdd: TSpeedButton;
    btEventAIUpd: TSpeedButton;
    btEventAIDel: TSpeedButton;
    tsLocalesQuest: TTabSheet;
    gbLocalesQuest: TGroupBox;
    edlqTitle: TLabeledEdit;
    edlqDetails: TMemo;
    l2Details: TLabel;
    edlqObjectives: TMemo;
    l2Objectives: TLabel;
    l2EndText: TLabel;
    edlqEndText: TMemo;
    edlqOfferRewardText: TMemo;
    edlqRequestItemsText: TMemo;
    l2RequestItemsText: TLabel;
    l2OfferRewardText: TLabel;
    edlqObjectiveText1: TLabeledEdit;
    edlqObjectiveText2: TLabeledEdit;
    edlqObjectiveText3: TLabeledEdit;
    edlqObjectiveText4: TLabeledEdit;
    btlqShowFullLocalesScript: TButton;
    editScalingStatDistribution: TLabeledEdit;
    editItemLimitCategory: TLabeledEdit;
    edqtPlayersSlain: TLabeledEdit;
    edqtBonusTalents: TLabeledEdit;
    tsMillingLoot: TTabSheet;
    lvitMillingLoot: TJvListView;
    edimitem: TJvComboEdit;
    edimentry: TLabeledEdit;
    lbimitem: TLabel;
    edimChanceOrQuestChance: TLabeledEdit;
    edimgroupid: TLabeledEdit;
    edimmincountOrRef: TLabeledEdit;
    edimmaxcount: TLabeledEdit;
    btMillingLootAdd: TSpeedButton;
    btMillingLootUpd: TSpeedButton;
    btMillingLootDel: TSpeedButton;
    btFullScriptMillingLoot: TButton;
    btScriptMillingLoot: TButton;
    edceequipentry1: TLabeledEdit;
    edceequipentry2: TLabeledEdit;
    edceequipentry3: TLabeledEdit;
    edclphaseMask: TLabeledEdit;
    edglphaseMask: TLabeledEdit;
    tsLocalesNPCText: TTabSheet;
    NPCTextLoc1: TNPCTextLoc;
    gbMultipliers: TGroupBox;
    edctHealthMultiplier: TLabeledEdit;
    edctPowerMultiplier: TLabeledEdit;
    edgeholiday: TLabeledEdit;
    edgtIconName: TLabeledEdit;
    edctUnitClass: TLabeledEdit;
    edqtDetailsEmoteDelay1: TLabeledEdit;
    edqtDetailsEmoteDelay2: TLabeledEdit;
    edqtDetailsEmoteDelay3: TLabeledEdit;
    edqtDetailsEmoteDelay4: TLabeledEdit;
    edqtOfferRewardEmoteDelay1: TLabeledEdit;
    edqtOfferRewardEmoteDelay2: TLabeledEdit;
    edqtOfferRewardEmoteDelay3: TLabeledEdit;
    edqtOfferRewardEmoteDelay4: TLabeledEdit;
    edctKillCredit1: TLabeledEdit;
    edctKillCredit2: TLabeledEdit;
    gbQuestItems: TGroupBox;
    edctQuestItem1: TLabeledEdit;
    edctQuestItem2: TLabeledEdit;
    edctQuestItem3: TLabeledEdit;
    edctQuestItem4: TLabeledEdit;
    edctMovementTemplateId: TLabeledEdit;
    editHolidayId: TLabeledEdit;
    edgtunk1: TLabeledEdit;
    edctQuestItem5: TLabeledEdit;
    edctQuestItem6: TLabeledEdit;
    gbGOQuestItems: TGroupBox;
    edgtquestItem1: TLabeledEdit;
    edgtquestItem2: TLabeledEdit;
    edgtquestItem3: TLabeledEdit;
    edgtquestItem4: TLabeledEdit;
    edgtquestItem5: TLabeledEdit;
    edgtquestItem6: TLabeledEdit;
    edqtReqItemId5: TJvComboEdit;
    edqtReqItemCount5: TLabeledEdit;
    edqtReqItemCount6: TLabeledEdit;
    edqtReqItemId6: TJvComboEdit;
    edSearchItemItemLevel: TLabeledEdit;
    edSearchGOdata0: TLabeledEdit;
    edSearchGOdata1: TLabeledEdit;
    tsReferenceLoot: TTabSheet;
    PageControl5: TPageControl;
    lvitReferenceLoot: TJvListView;
    ediritem: TJvComboEdit;
    lbiritem: TLabel;
    btReferenceLootAdd: TSpeedButton;
    btReferenceLootUpd: TSpeedButton;
    btReferenceLootDel: TSpeedButton;
    edirChanceOrQuestChance: TLabeledEdit;
    edirgroupid: TLabeledEdit;
    edirmincountOrRef: TLabeledEdit;
    edirmaxcount: TLabeledEdit;
    btScriptReferenceLoot: TButton;
    btFullScriptReferenceLoot: TButton;
    edirentry: TJvComboEdit;
    lbirentry: TLabel;
    edPrevQuestIdSearch: TLabeledEdit;
    edNextQuestIdSearch: TLabeledEdit;
    edSearchKillCredit1: TLabeledEdit;
    edSearchKillCredit2: TLabeledEdit;
    edSearchGOdata2: TLabeledEdit;
    edctDifficultyEntry2: TJvComboEdit;
    edctDifficultyEntry3: TJvComboEdit;
    lbctdifficulty_entry_2: TLabel;
    lbctdifficulty_entry_3: TLabel;
    edclspawnMask: TJvComboEdit;
    lbclspawnMask: TLabel;
    edglspawnMask: TJvComboEdit;
    lbglspawnMask: TLabel;
    edctGossipMenuId: TJvComboEdit;
    lbctgossip_menu_id: TLabel;
    edqtCompletedText: TLabeledEdit;
    edlqCompletedText: TLabeledEdit;
    edqtRewXPId: TLabeledEdit;
    edqtRewHonorMultiplier: TLabeledEdit;
    edqtRewRepValueId1: TLabeledEdit;
    edqtRewRepValueId2: TLabeledEdit;
    edqtRewRepValueId3: TLabeledEdit;
    edqtRewRepValueId4: TLabeledEdit;
    edqtRewRepValueId5: TLabeledEdit;
    editExtraFlags: TLabeledEdit;
    edctSpeedRun: TLabeledEdit;
    gbGOgolds: TGroupBox;
    edgtmaxgold: TLabeledEdit;
    edgtmingold: TLabeledEdit;
    edgbbuddy_entry: TLabeledEdit;
    edgbsearch_radius: TLabeledEdit;
    edssbuddy_entry: TLabeledEdit;
    edsssearch_radius: TLabeledEdit;
    edesbuddy_entry: TLabeledEdit;
    edessearch_radius: TLabeledEdit;
    tsCreatureMovementScript: TTabSheet;
    btcmsAdd: TSpeedButton;
    btcmsDel: TSpeedButton;
    btcmsShowFullScript: TButton;
    btcmsUpd: TSpeedButton;
    edcmscommand: TJvComboEdit;
    edcmsbuddy_entry: TLabeledEdit;
    edcmssearch_radius: TLabeledEdit;
    edcmsdelay: TLabeledEdit;
    edcmso: TLabeledEdit;
    edcmsx: TLabeledEdit;
    edcmsy: TLabeledEdit;
    edcmsz: TLabeledEdit;
    lbcmscommand: TLabel;
    lbcms: TLabel;
    lvcmsCreatureMovementScript: TJvListView;
    edcimodelid_alternative: TLabeledEdit;
    edcmscomments: TLabeledEdit;
    edgbcomments: TLabeledEdit;
    edsscomments: TLabeledEdit;
    edescomments: TLabeledEdit;
    edqtRequiredSkill: TJvComboEdit;
    edqtRequiredRaces: TJvComboEdit;
    lbRequiredRaces: TLabel;
    lbRequiredClasses: TLabel;
    lbRequiredSkill: TLabel;
    tsNPCVendorTemplate: TTabSheet;
    lbNpcVendorTemplateInfo: TLabel;
    btVendorTemplateDel: TSpeedButton;
    btVendorTemplateUpd: TSpeedButton;
    btVendorTemplateAdd: TSpeedButton;
    btFullScriptVendorTemplate: TButton;
    btScriptNPCVendorTemplate: TButton;
    edcvtExtendedCost: TJvComboEdit;
    edcvtincrtime: TLabeledEdit;
    edcvtmaxcount: TLabeledEdit;
    edcvtitem: TJvComboEdit;
    edcvtentry: TLabeledEdit;
    lvcvtNPCVendor: TJvListView;
    edctVendorTemplateId: TJvComboEdit;
    lbctvendor_id: TLabel;
    lbcvtitem: TLabel;
    lbcvtExtendedCost: TLabel;
    edcdb2_0_sheath: TLabeledEdit;
    edcdb2_1_pvp_state: TLabeledEdit;
    edcab2_1_pvp_state: TLabeledEdit;
    tsNPCTrainerTemplate: TTabSheet;
    lvcrtNPCTrainer: TJvListView;
    edcrtentry: TLabeledEdit;
    edcrtspell: TJvComboEdit;
    edcrtspellcost: TLabeledEdit;
    edcrtreqskill: TJvComboEdit;
    edcrtreqskillvalue: TLabeledEdit;
    edcrtreqlevel: TLabeledEdit;
    btScriptNPCTrainerTemplate: TButton;
    lbcrtreqskill: TLabel;
    btFullScriptTrainerTemplate: TButton;
    btTrainerTemplateAdd: TSpeedButton;
    btTrainerTemplateUpd: TSpeedButton;
    btTrainerTemplateDel: TSpeedButton;
    lbcvNPCTrainerTemplateHint: TLabel;
    lbcrtspell: TLabel;
    edctTrainerTemplateId: TJvComboEdit;
    lbcttrainer_id: TLabel;
    edctVehicleTemplateId: TLabeledEdit;
    edqtPortraitGiverName: TLabeledEdit;
    edqtPortraitGiverText: TLabeledEdit;
    edqtPortraitTurnInName: TLabeledEdit;
    edqtPortraitTurnInText: TLabeledEdit;
    edqtPortraitGiver: TJvComboEdit;
    lbqtPortraitGiver: TLabel;
    edqtPortraitTurnIn: TJvComboEdit;
    lbqtPortraitTurnIn: TLabel;
    edqtSoundAccept: TLabeledEdit;
    edqtSoundTurnIn: TLabeledEdit;
    edqtPointMapId: TJvComboEdit;
    edqtPointX: TLabeledEdit;
    edqtPointY: TLabeledEdit;
    edqtPointOpt: TLabeledEdit;
    lbqtPointMapId: TLabel;
    editstat_unk1_1: TLabeledEdit;
    editstat_unk1_2: TLabeledEdit;
    editstat_unk1_3: TLabeledEdit;
    editstat_unk1_4: TLabeledEdit;
    editstat_unk1_5: TLabeledEdit;
    editstat_unk1_6: TLabeledEdit;
    editstat_unk1_7: TLabeledEdit;
    editstat_unk1_8: TLabeledEdit;
    editstat_unk1_9: TLabeledEdit;
    editstat_unk1_10: TLabeledEdit;
    editstat_unk2_1: TLabeledEdit;
    editstat_unk2_2: TLabeledEdit;
    editstat_unk2_3: TLabeledEdit;
    editstat_unk2_4: TLabeledEdit;
    editstat_unk2_5: TLabeledEdit;
    editstat_unk2_6: TLabeledEdit;
    editstat_unk2_7: TLabeledEdit;
    editstat_unk2_8: TLabeledEdit;
    editstat_unk2_9: TLabeledEdit;
    editstat_unk2_10: TLabeledEdit;
    editStatScalingFactor: TLabeledEdit;
    editDamageType: TJvComboEdit;
    lbitDamageType: TLabel;
    editUnknown: TLabeledEdit;
    editUnknown1: TLabeledEdit;
    editUnknown2: TLabeledEdit;
    editUnknown400_1: TLabeledEdit;
    editUnknown400_2: TLabeledEdit;
    edctPetSpellDataId: TLabeledEdit;
    edctExtraFlags: TJvComboEdit;
    lbctflags_extra: TLabel;
    edgtdata24: TLabeledEdit;
    edgtdata25: TLabeledEdit;
    edgtdata26: TLabeledEdit;
    edgtdata27: TLabeledEdit;
    edgtdata28: TLabeledEdit;
    edgtdata29: TLabeledEdit;
    edgtdata30: TLabeledEdit;
    edgtdata31: TLabeledEdit;
    edqtReqItemCount3: TLabeledEdit;
    tsGossipMenu: TTabSheet;
    Panel25: TPanel;
    lbcgmscript_id: TLabel;
    lbedcgmtext_id: TLabel;
    edcgmtext_id: TJvComboEdit;
    edcgmscript_id: TJvComboEdit;
    btShowGossipMenuScript: TButton;
    edcgmentry: TJvComboEdit;
    lbcgmentry: TLabel;
    lvcgmOptions: TJvListView;
    btGossipMenuOptionAdd: TSpeedButton;
    btGossipMenuOptionUpd: TSpeedButton;
    btGossipMenuOptionDel: TSpeedButton;
    lbcgmocondition_id: TLabel;
    edcgmoid: TLabeledEdit;
    edcgmooption_text: TLabeledEdit;
    edcgmooption_id: TLabeledEdit;
    edcgmonpc_option_npcflag: TLabeledEdit;
    edcgmoaction_poi_id: TLabeledEdit;
    edcgmobox_coded: TLabeledEdit;
    edcgmobox_money: TLabeledEdit;
    edcgmobox_text: TLabeledEdit;
    btShowGossipMenuOptionsScript: TButton;
    lbGossipMenuOption: TLabel;
    edcgmooption_icon: TJvComboEdit;
    lbcgmooption_icon: TLabel;
    edcgmoaction_menu_id: TJvComboEdit;
    lbcgmoaction_menu_id: TLabel;
    gbitDamage: TGroupBox;
    lbitdmg_type: TLabel;
    editdmg_min1: TLabeledEdit;
    editdmg_max1: TLabeledEdit;
    editdmg_min2: TLabeledEdit;
    editdmg_max2: TLabeledEdit;
    editdmg_type1: TJvComboEdit;
    editdmg_type2: TJvComboEdit;
    gbitResistance: TGroupBox;
    editholy_res: TLabeledEdit;
    editfire_res: TLabeledEdit;
    editnature_res: TLabeledEdit;
    editfrost_res: TLabeledEdit;
    editshadow_res: TLabeledEdit;
    editarcane_res: TLabeledEdit;
    editammo_type: TLabeledEdit;
    editarmor: TLabeledEdit;
    editblock: TLabeledEdit;
    editScalingStatValue: TLabeledEdit;
    editStatsCount: TLabeledEdit;
    lbGossipMenuInfo: TLabel;
    edctDamageMultiplier: TLabeledEdit;
    edctExperienceMultiplier: TLabeledEdit;
    edctExpansion: TLabeledEdit;
    edctScale: TLabeledEdit;
    edctArmorMultiplier: TLabeledEdit;
    edctDamageVariance: TLabeledEdit;
    tsCreatureTemplateSpells: TTabSheet;
    lbcuCreatureTemplateSpells: TLabel;
    lbcuentry: TLabel;
    tsCreatureOnDeathScript: TTabSheet;
    lbcds: TLabel;
    edcdscommand: TJvComboEdit;
    lbcdscommand: TLabel;
    edcdsdelay: TLabeledEdit;
    btcdsAdd: TSpeedButton;
    btcdsDel: TSpeedButton;
    btcdsShowFullScript: TButton;
    btcdsUpd: TSpeedButton;
    edcdsbuddy_entry: TLabeledEdit;
    edcdscomments: TLabeledEdit;
    edcdso: TLabeledEdit;
    edcdssearch_radius: TLabeledEdit;
    edcdsx: TLabeledEdit;
    edcdsy: TLabeledEdit;
    edcdsz: TLabeledEdit;
    tsGOTemplateScript: TTabSheet;
    edgtbo: TLabeledEdit;
    edgtbz: TLabeledEdit;
    edgtby: TLabeledEdit;
    edgtbx: TLabeledEdit;
    edgtbdelay: TLabeledEdit;
    edgtbbuddy_entry: TLabeledEdit;
    edgtbsearch_radius: TLabeledEdit;
    edgtbcomments: TLabeledEdit;
    edgtbcommand: TJvComboEdit;
    lbhintGOTemplateScript: TLabel;
    lbgtbcommand: TLabel;
    btgtbDel: TSpeedButton;
    btgtbUpd: TSpeedButton;
    btgtbAdd: TSpeedButton;
    tsSpellLoot: TTabSheet;
    lvslSpellLoot: TJvListView;
    edslChanceOrQuestChance: TLabeledEdit;
    btScriptSpellLoot: TButton;
    edslitem: TJvComboEdit;
    edslgroupid: TLabeledEdit;
    btSpellLootAdd: TSpeedButton;
    btSpellLootUpd: TSpeedButton;
    btSpellLootDel: TSpeedButton;
    edslmincountOrRef: TLabeledEdit;
    edslmaxcount: TLabeledEdit;
    btFullScriptSpellLoot: TButton;
    edslentry: TLabeledEdit;
    lbslitem: TLabel;
    Conditions: TTabSheet;
    edconvalue2: TLabeledEdit;
    edconvalue1: TLabeledEdit;
    lbcontype: TLabel;
    edcontype: TJvComboEdit;
    lbconentry: TLabel;
    edconcondition_entry: TJvComboEdit;
    lbctEquipTemplateId: TLabel;
    edctEquipmentTemplateId: TJvComboEdit;
    edotcondition_id: TJvComboEdit;
    lbotcondition_id: TLabel;
    edgocondition_id: TJvComboEdit;
    lbgocondition_id: TLabel;
    edceentry: TJvComboEdit;
    lbceentry: TLabel;
    edilcondition_id: TJvComboEdit;
    lbilcondition_id: TLabel;
    edidcondition_id: TJvComboEdit;
    lbidcondition_id: TLabel;
    edipcondition_id: TJvComboEdit;
    lbipcondition_id: TLabel;
    edimcondition_id: TJvComboEdit;
    lbcondition_id: TLabel;
    edircondition_id: TJvComboEdit;
    lbircondition_id: TLabel;
    edslcondition_id: TJvComboEdit;
    lbslcondition_id: TLabel;
    edmlcondition_id: TJvComboEdit;
    lbmlcondition_id: TLabel;
    edqtRewMailTemplateId: TJvComboEdit;
    lbqtRewMailTemplateId: TLabel;
    edcgcondition_id: TJvComboEdit;
    lbcgcondition_id: TLabel;
    edcvtcondition_id: TJvComboEdit;
    lbcvtcondition_id: TLabel;
    edcocondition_id: TJvComboEdit;
    lbcocondition_id: TLabel;
    edcpcondition_id: TJvComboEdit;
    lbcpcondition_id: TLabel;
    edcscondition_id: TJvComboEdit;
    lbcscondition_id: TLabel;
    edcvcondition_id: TJvComboEdit;
    lbcvcondition_id: TLabel;
    edcgmcondition_id: TJvComboEdit;
    tsDBScript: TTabSheet;
    Panel26: TPanel;
    DBScriptString: TPageControl;
    tsString: TTabSheet;
    lbdbstype: TLabel;
    lbdbsentry: TLabel;
    eddbstype: TJvComboEdit;
    btDBScript: TButton;
    eddbsentry: TJvComboEdit;
    tsDBScriptsOn: TTabSheet;
    medbScript: TMemo;
    medbLog: TMemo;
    btCopyToClipDBScriptsOn: TButton;
    btExecuteDBScriptsOn: TButton;
    eddbsemote: TJvComboEdit;
    lbdbsemote: TLabel;
    lbdbslanguage: TLabel;
    eddbslanguage: TJvComboEdit;
    eddbssound: TJvComboEdit;
    lbdbssound: TLabel;
    eddbscontent_default: TMemo;
    lbdbscontent_default: TLabel;
    lbdbscontent_loc2: TLabel;
    eddbscontent_loc2: TMemo;
    eddbscontent_loc3: TMemo;
    lbdbscontent_loc3: TLabel;
    eddbscontent_loc1: TMemo;
    lbdbscontent_loc1: TLabel;
    lbdbscontent_loc8: TLabel;
    lbdbscomment: TLabel;
    lbdbscontent_loc7: TLabel;
    lbdbscontent_loc6: TLabel;
    lbdbscontent_loc5: TLabel;
    lbdbscontent_loc4: TLabel;
    eddbscomment: TMemo;
    eddbscontent_loc4: TMemo;
    eddbscontent_loc5: TMemo;
    eddbscontent_loc6: TMemo;
    eddbscontent_loc7: TMemo;
    eddbscontent_loc8: TMemo;
    tsEvent: TTabSheet;
    tsGossip: TTabSheet;
    tsSpell: TTabSheet;
    lbEventInfo: TLabel;
    lvdoeEventScript: TJvListView;
    eddoedelay: TLabeledEdit;
    lbdoecommand: TLabel;
    eddoecommand: TJvComboEdit;
    eddoex: TLabeledEdit;
    eddoey: TLabeledEdit;
    eddoebuddy_entry: TLabeledEdit;
    eddoez: TLabeledEdit;
    eddoeo: TLabeledEdit;
    eddoesearch_radius: TLabeledEdit;
    eddoecomments: TLabeledEdit;
    btFullEventScript: TButton;
    btdoeAdd: TSpeedButton;
    btdoeUpd: TSpeedButton;
    btdoeDel: TSpeedButton;
    lbGossipInfo: TLabel;
    lvdogGossipScript: TJvListView;
    eddogdelay: TLabeledEdit;
    lbdogcommand: TLabel;
    eddogcommand: TJvComboEdit;
    eddogx: TLabeledEdit;
    eddogy: TLabeledEdit;
    eddogbuddy_entry: TLabeledEdit;
    eddogz: TLabeledEdit;
    eddogo: TLabeledEdit;
    eddogsearch_radius: TLabeledEdit;
    eddogcomments: TLabeledEdit;
    btFullGossipScript: TButton;
    btdogAdd: TSpeedButton;
    btdogUpd: TSpeedButton;
    btdogDel: TSpeedButton;
    lbSpellInfo: TLabel;
    lvdosSpellScript: TJvListView;
    eddosdelay: TLabeledEdit;
    lbdoscommand: TLabel;
    eddoscommand: TJvComboEdit;
    eddosx: TLabeledEdit;
    eddosy: TLabeledEdit;
    eddosbuddy_entry: TLabeledEdit;
    eddosz: TLabeledEdit;
    eddoso: TLabeledEdit;
    eddossearch_radius: TLabeledEdit;
    eddoscomments: TLabeledEdit;
    btFullSpellScript: TButton;
    btdosAdd: TSpeedButton;
    btdosUpd: TSpeedButton;
    btdosDel: TSpeedButton;
    btesShowFullScript: TButton;
    btssShowFullScript: TButton;
    edssid: TJvComboEdit;
    lbssid: TLabel;
    edesid: TJvComboEdit;
    lbesid: TLabel;
    edcmsid: TJvComboEdit;
    lbcmsid: TLabel;
    edcmscript_id: TJvComboEdit;
    lbcmscript_id: TLabel;
    edclid: TJvComboEdit;
    lbclid: TLabel;
    edclguid: TJvComboEdit;
    lbclguid: TLabel;
    edcimodelid: TJvComboEdit;
    lbcimodelid: TLabel;
    edclmodelid: TJvComboEdit;
    lbclmodelid: TLabel;
    edclequipment_id: TJvComboEdit;
    lbclequipment_id: TLabel;
    lvcdsCreatureOnDeathScript: TJvListView;
    edcdsid: TJvComboEdit;
    lbcdsid: TLabel;
    edcgmoaction_script_id: TJvComboEdit;
    lbcgmoaction_script_id: TLabel;
    edgbid: TJvComboEdit;
    lbgbid: TLabel;
    edgtbid: TJvComboEdit;
    lbgtbid: TLabel;
    eddoeid: TJvComboEdit;
    lbdoeid: TLabel;
    eddogid: TJvComboEdit;
    lbdogid: TLabel;
    lbdosid: TLabel;
    edcgmomenu_id: TJvComboEdit;
    lbcgmomenu_id: TLabel;
    edcuspell2: TJvComboEdit;
    lbcuspell1: TLabel;
    edcuspell1: TJvComboEdit;
    lbcuspell2: TLabel;
    edcuspell3: TJvComboEdit;
    lbcuspell5: TLabel;
    edcuspell8: TJvComboEdit;
    lbcuspell8: TLabel;
    edcuspell5: TJvComboEdit;
    lbcuspell3: TLabel;
    edcuspell4: TJvComboEdit;
    lbcuspell6: TLabel;
    edcuspell7: TJvComboEdit;
    lbcuspell7: TLabel;
    edcuspell6: TJvComboEdit;
    lbcuspell4: TLabel;
    eddosid: TJvComboEdit;
    edcuentry: TJvComboEdit;
    edqtStartScript: TJvComboEdit;
    lbqtStartScript: TLabel;
    edqtCompleteScript: TJvComboEdit;
    lbqtCompleteScript: TLabel;
    tsCreatureMvmntTemplate: TTabSheet;
    lvcmtMovement: TJvListView;
    edcmtpoint: TLabeledEdit;
    edcmtposition_x: TLabeledEdit;
    edcmtorientation: TLabeledEdit;
    edcmtposition_y: TLabeledEdit;
    edcmtposition_z: TLabeledEdit;
    edcmtscript_id: TJvComboEdit;
    edcmtwaittime: TLabeledEdit;
    btCreatureMvmntTemplateAdd: TSpeedButton;
    btCreatureMvmntTemplateUpd: TSpeedButton;
    btCreatureMvmntTemplateDel: TSpeedButton;
    btFullCreatureMvmntTemplateScript: TButton;
    btShowCreatureMvmntTemplateScript: TButton;
    lbcmtscript_id: TLabel;
    edcmid: TJvComboEdit;
    lbcmid: TLabel;
    edcmtentry: TJvComboEdit;
    lbcmtentry: TLabel;
    edctSchoolImmuneMask: TJvComboEdit;
    lbctSchoolImmuneMask: TLabel;
    edgelinkedTo: TLabeledEdit;
    edqtRequiredCondition: TJvComboEdit;
    lbRequiredCondition: TLabel;
    edcrcondition_id: TJvComboEdit;
    lbcrcondition_id: TLabel;
    edcrtcondition_id: TJvComboEdit;
    lbcrtcondition_id: TLabel;
    edgtExtraFlags: TLabeledEdit;
    edgtCustomData1: TLabeledEdit;
    edcvcomments: TLabeledEdit;
    edcvtcomments: TLabeledEdit;
    edidcomments: TLabeledEdit;
    edotcomments: TLabeledEdit;
    edilcomments: TLabeledEdit;
    edipcomments: TLabeledEdit;
    edcscomments: TLabeledEdit;
    edcocomments: TLabeledEdit;
    edgocomments: TLabeledEdit;
    edircomments: TLabeledEdit;
    edssdatalong3: TLabeledEdit;
    edesdatalong3: TLabeledEdit;
    edcmsdatalong3: TLabeledEdit;
    edcdsdatalong3: TLabeledEdit;
    edgbdatalong3: TLabeledEdit;
    edgtbdatalong3: TLabeledEdit;
    eddoedatalong3: TLabeledEdit;
    eddogdatalong3: TLabeledEdit;
    eddosdatalong3: TLabeledEdit;
    edcmtpathId: TLabeledEdit;
    edclspawntimesecsmax: TLabeledEdit;
    edglspawntimesecsmax: TLabeledEdit;
    tsRelay: TTabSheet;
    lbRelayInfo: TLabel;
    lbdorcommand: TLabel;
    btdorAdd: TSpeedButton;
    btdorUpd: TSpeedButton;
    btdorDel: TSpeedButton;
    lbdorid: TLabel;
    lvdorRelayScript: TJvListView;
    eddordelay: TLabeledEdit;
    eddorcommand: TJvComboEdit;
    eddorx: TLabeledEdit;
    eddory: TLabeledEdit;
    eddorbuddy_entry: TLabeledEdit;
    eddorz: TLabeledEdit;
    eddoro: TLabeledEdit;
    eddorsearch_radius: TLabeledEdit;
    eddorcomments: TLabeledEdit;
    btFullRelayScript: TButton;
    eddorid: TJvComboEdit;
    eddordatalong3: TLabeledEdit;
    edssdataint: TLabeledEdit;
    edssdataint2: TLabeledEdit;
    edssdataint3: TLabeledEdit;
    edssdataint4: TLabeledEdit;
    edesdataint: TLabeledEdit;
    edesdataint2: TLabeledEdit;
    edesdataint3: TLabeledEdit;
    edesdataint4: TLabeledEdit;
    edcmsdataint: TLabeledEdit;
    edcmsdataint2: TLabeledEdit;
    edcmsdataint3: TLabeledEdit;
    edcmsdataint4: TLabeledEdit;
    edcdsdataint4: TLabeledEdit;
    edcdsdataint3: TLabeledEdit;
    edcdsdataint2: TLabeledEdit;
    edcdsdataint: TLabeledEdit;
    edgbdataint4: TLabeledEdit;
    edgbdataint3: TLabeledEdit;
    edgbdataint2: TLabeledEdit;
    edgbdataint: TLabeledEdit;
    edgtbdataint4: TLabeledEdit;
    edgtbdataint3: TLabeledEdit;
    edgtbdataint2: TLabeledEdit;
    edgtbdataint: TLabeledEdit;
    eddoedataint: TLabeledEdit;
    eddoedataint2: TLabeledEdit;
    eddoedataint3: TLabeledEdit;
    eddoedataint4: TLabeledEdit;
    eddogdataint: TLabeledEdit;
    eddogdataint2: TLabeledEdit;
    eddogdataint3: TLabeledEdit;
    eddogdataint4: TLabeledEdit;
    eddosdataint: TLabeledEdit;
    eddosdataint2: TLabeledEdit;
    eddosdataint3: TLabeledEdit;
    eddosdataint4: TLabeledEdit;
    eddordataint: TLabeledEdit;
    eddordataint2: TLabeledEdit;
    eddordataint3: TLabeledEdit;
    eddordataint4: TLabeledEdit;
    btssScript: TButton;
    btesScript: TButton;
    btcmsScript: TButton;
    btcdsScript: TButton;
    btgbScript: TButton;
    btgtbScript: TButton;
    btdoeScript: TButton;
    btdogScript: TButton;
    btdosScript: TButton;
    btdorScript: TButton;
    tsRandomTemplates: TTabSheet;
    lvrtRandomScript: TJvListView;
    edrtid: TJvComboEdit;
    lbrtid: TLabel;
    edrttarget_id: TJvComboEdit;
    lbrttarget_id: TLabel;
    edrtcomments: TLabeledEdit;
    edrttype: TLabeledEdit;
    edrtchance: TLabeledEdit;
    btrtAdd: TSpeedButton;
    btrtUpd: TSpeedButton;
    btrtDel: TSpeedButton;
    btrtScript: TButton;
    btrtFullScript: TButton;
    edconcomments: TLabeledEdit;
    edgeEventGroup: TLabeledEdit;
    edcpcomments: TLabeledEdit;
    edmlcomments: TLabeledEdit;
    tsGreetings: TTabSheet;
    edqgEmoteId: TJvComboEdit;
    lbqgEmoteId: TLabel;
    edqgEmoteDelay: TLabeledEdit;
    edqgType: TLabeledEdit;
    edqgText: TLabeledEdit;
    edlqgText: TLabeledEdit;
    edqgEntry: TLabeledEdit;
    gbDetection: TGroupBox;
    edctDetection: TLabeledEdit;
    edctCallForHelp: TLabeledEdit;
    edctPursuit: TLabeledEdit;
    edctTimeout: TLabeledEdit;
    edctLeash: TLabeledEdit;
    lbReqSpellCast2: TLabel;
    lbReqSpellCast3: TLabel;
    lbReqSpellCast4: TLabel;
    edciSpeedWalk: TLabeledEdit;
    edciSpeedRun: TLabeledEdit;
    tsTaxiShortcuts: TTabSheet;
    edtspathid: TJvComboEdit;
    edtstakeoff: TLabeledEdit;
    edtslanding: TLabeledEdit;
    edtscomments: TLabeledEdit;
    btScriptTaxi: TButton;
    lbtspathid: TLabel;
    edcmcomment: TLabeledEdit;
    edcmtcomment: TLabeledEdit;
    edqtRewMaxRepValue5: TLabeledEdit;
    edqtRewMaxRepValue4: TLabeledEdit;
    edqtRewMaxRepValue3: TLabeledEdit;
    edqtRewMaxRepValue2: TLabeledEdit;
    edqtRewMaxRepValue1: TLabeledEdit;
    edtgText: TLabeledEdit;
    edltgText: TLabeledEdit;
    btGreetingScript: TButton;
    editFlags2: TJvComboEdit;
    lbitFlags2: TLabel;
    edssdata_flags: TJvComboEdit;
    lbssdata_flags: TLabel;
    edesdata_flags: TJvComboEdit;
    lbesdata_flags: TLabel;
    edcmsdata_flags: TJvComboEdit;
    lbcmsdata_flags: TLabel;
    edcdsdata_flags: TJvComboEdit;
    lbcdsdata_flags: TLabel;
    edgbdata_flags: TJvComboEdit;
    lbgbdata_flags: TLabel;
    edgtbdata_flags: TJvComboEdit;
    lbgtbdata_flags: TLabel;
    eddoedata_flags: TJvComboEdit;
    lbdoedata_flags: TLabel;
    eddogdata_flags: TJvComboEdit;
    lbdogdata_flags: TLabel;
    eddosdata_flags: TJvComboEdit;
    lbdosdata_flags: TLabel;
    eddordata_flags: TJvComboEdit;
    lbdordata_flags: TLabel;
    edcnevent_flags: TJvComboEdit;
    lbcnevent_flags: TLabel;
    edssdatalong: TJvComboEdit;
    lbssdatalong: TLabel;
    edssdatalong2: TJvComboEdit;
    lbssdatalong2: TLabel;
    edesdatalong: TJvComboEdit;
    lbesdatalong: TLabel;
    lbesdatalong2: TLabel;
    edesdatalong2: TJvComboEdit;
    edcmsdatalong: TJvComboEdit;
    edcmsdatalong2: TJvComboEdit;
    lbcmsdatalong2: TLabel;
    lbcmsdatalong: TLabel;
    edcdsdatalong2: TJvComboEdit;
    edcdsdatalong: TJvComboEdit;
    lbcdsdatalong: TLabel;
    lbcdsdatalong2: TLabel;
    lbgbdatalong2: TLabel;
    lbgbdatalong: TLabel;
    edgbdatalong: TJvComboEdit;
    edgbdatalong2: TJvComboEdit;
    edgtbdatalong2: TJvComboEdit;
    edgtbdatalong: TJvComboEdit;
    lbgtbdatalong: TLabel;
    lbgtbdatalong2: TLabel;
    eddoedatalong2: TJvComboEdit;
    eddoedatalong: TJvComboEdit;
    lbdoedatalong: TLabel;
    lbdoedatalong2: TLabel;
    eddogdatalong2: TJvComboEdit;
    eddogdatalong: TJvComboEdit;
    lbdogdatalong: TLabel;
    lbdogdatalong2: TLabel;
    eddosdatalong2: TJvComboEdit;
    eddosdatalong: TJvComboEdit;
    lbdosdatalong: TLabel;
    lbdosdatalong2: TLabel;
    eddordatalong2: TJvComboEdit;
    eddordatalong: TJvComboEdit;
    lbdordatalong: TLabel;
    lbdordatalong2: TLabel;
    edcnevent_param5: TJvComboEdit;
    edcnevent_param6: TJvComboEdit;
    lbcnevent_param5: TLabel;
    lbcnevent_param6: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure btSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btAddQuestTakerClick(Sender: TObject);
    procedure lvQuestDblClick(Sender: TObject);
    procedure tsScriptTabShow(Sender: TObject);
    procedure btExecuteScriptClick(Sender: TObject);
    procedure btCopyToClipboardClick(Sender: TObject);
    procedure btTypeClick(Sender: TObject);
    procedure GetQuestFlags(Sender: TObject);
    procedure GetRaces(Sender: TObject);
    procedure GetSkill(Sender: TObject);
    procedure GetClasses(Sender: TObject);
    procedure btAreatriggerClick(Sender: TObject);
    procedure lvQuestChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure nExitClick(Sender: TObject);
    procedure nAboutClick(Sender: TObject);
    procedure btNewQuestClick(Sender: TObject);
    procedure btEditQuestClick(Sender: TObject);
    procedure btCheckQuestClick(Sender: TObject);
    procedure btCheckAllClick(Sender: TObject);
    procedure btQuestGiverSearchClick(Sender: TObject);
    procedure btQuestTakerSearchClick(Sender: TObject);
    procedure nSettingsClick(Sender: TObject);
    procedure btBrowseSiteClick(Sender: TObject);
    procedure btDeleteQuestClick(Sender: TObject);
    procedure edSearchChange(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure btClearSearchCreatureClick(Sender: TObject);
    procedure btSearchCreatureClick(Sender: TObject);
    procedure edSearchCreatureChange(Sender: TObject);
    procedure lvSearchCreatureDblClick(Sender: TObject);
    procedure lvSearchCreatureChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure btEditCreatureClick(Sender: TObject);
    procedure btDeleteCreatureClick(Sender: TObject);
    procedure btBrowseCreatureClick(Sender: TObject);
    procedure edctEntryButtonClick(Sender: TObject);
    procedure edcuentryButtonClick(Sender: TObject);
    procedure btExecuteCreatureScriptClick(Sender: TObject);
    procedure btCopyToClipboardCreatureClick(Sender: TObject);
    procedure tsCreatureScriptShow(Sender: TObject);
    procedure edctNpcFlagsButtonClick(Sender: TObject);
    procedure edctRankButtonClick(Sender: TObject);
    procedure edctFamilyButtonClick(Sender: TObject);
    procedure btNewCreatureClick(Sender: TObject);
    procedure edctTrainerTypeButtonClick(Sender: TObject);
    procedure GetRace(Sender: TObject);
    procedure GetClass(Sender: TObject);
    procedure edctCreatureTypeButtonClick(Sender: TObject);
    procedure btScriptCreatureClick(Sender: TObject);
    procedure edgtentryButtonClick(Sender: TObject);
    procedure btBrowseGOClick(Sender: TObject);
    procedure btClearSearchGOClick(Sender: TObject);
    procedure btCopyToClipboardGOClick(Sender: TObject);
    procedure btDeleteGOClick(Sender: TObject);
    procedure btEditGOClick(Sender: TObject);
    procedure btExecuteGOScriptClick(Sender: TObject);
    procedure btNewGOClick(Sender: TObject);
    procedure btScriptGOClick(Sender: TObject);
    procedure btSearchGOClick(Sender: TObject);
    procedure edSearchGOChange(Sender: TObject);
    procedure lvSearchGOChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvSearchGODblClick(Sender: TObject);
    procedure tsGOScriptShow(Sender: TObject);
    procedure tsGOShow(Sender: TObject);
    procedure edgttypeButtonClick(Sender: TObject);
    procedure edgttypeChange(Sender: TObject);

    procedure GetItem(Sender: TObject);
    procedure GetCurrency(Sender: TObject);
    procedure GetCreatureOrGO(Sender: TObject);
    procedure GetFaction(Sender: TObject);
    procedure GetEmote(Sender: TObject);
    procedure GetFactionTemplate(Sender: TObject);
    procedure GetSpell(Sender: TObject);
    procedure btLoadQuest(Sender: TObject);
    procedure lvgoGOLootSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvmlMailLootSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvglGOLocationSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvcoPickpocketLootSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvcoSkinLootSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);

    procedure lvcoCreatureLootSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvclCreatureLocationSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure pmSiteClick(Sender: TObject);
    procedure lvcvNPCVendorSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvcrNPCTrainerSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btCreatureLootAddClick(Sender: TObject);
    procedure btCreatureLootUpdClick(Sender: TObject);
    procedure btCreatureLootDelClick(Sender: TObject);
    procedure btFullScriptCreatureLootClick(Sender: TObject);
    procedure btPickpocketLootAddClick(Sender: TObject);
    procedure btPickpocketLootUpdClick(Sender: TObject);
    procedure btPickpocketLootDelClick(Sender: TObject);
    procedure btFullScriptPickpocketLootClick(Sender: TObject);
    procedure btSkinLootAddClick(Sender: TObject);
    procedure btSkinLootUpdClick(Sender: TObject);
    procedure btSkinLootDelClick(Sender: TObject);
    procedure btFullScriptSkinLootClick(Sender: TObject);
    procedure btGOLootAddClick(Sender: TObject);
    procedure btGOLootUpdClick(Sender: TObject);
    procedure btGOLootDelClick(Sender: TObject);
    procedure btMailLootAddClick(Sender: TObject);
    procedure btMailLootUpdClick(Sender: TObject);
    procedure btMailLootDelClick(Sender: TObject);
    procedure btFullScriptGOLootClick(Sender: TObject);
    procedure btFullScriptMailLootClick(Sender: TObject);
    procedure btGreetingScriptClick(Sender: TObject);
    procedure btVendorAddClick(Sender: TObject);
    procedure btVendorUpdClick(Sender: TObject);
    procedure btVendorDelClick(Sender: TObject);
    procedure btFullScriptVendorClick(Sender: TObject);
    procedure lvcvNPCVendorChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvcoSkinLootChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvcoPickpocketLootChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvcoCreatureLootChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvgoGOLootChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvmlMailLootChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure btTrainerAddClick(Sender: TObject);
    procedure btTrainerUpdClick(Sender: TObject);
    procedure btTrainerDelClick(Sender: TObject);
    procedure btFullScriptTrainerClick(Sender: TObject);
    procedure lvcrNPCTrainerChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure edSearchItemChange(Sender: TObject);
    procedure btClearSearchItemClick(Sender: TObject);
    procedure lvSearchItemChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure btNewItemClick(Sender: TObject);
    procedure btEditItemClick(Sender: TObject);
    procedure btDeleteItemClick(Sender: TObject);
    procedure btBrowseItemClick(Sender: TObject);
    procedure lvSearchItemDblClick(Sender: TObject);
    procedure btSearchItemClick(Sender: TObject);
    procedure btCopyToClipboardItemClick(Sender: TObject);
    procedure btExecuteItemScriptClick(Sender: TObject);
    procedure btScriptItemClick(Sender: TObject);
    procedure lvitItemLootChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvitItemLootSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btScriptItemLootClick(Sender: TObject);
    procedure btItemLootAddClick(Sender: TObject);
    procedure btItemLootUpdClick(Sender: TObject);
    procedure btItemLootDelClick(Sender: TObject);
    procedure btFullScriptItemLootClick(Sender: TObject);
    procedure editentryButtonClick(Sender: TObject);
    procedure lvitDisLootChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvitDisLootSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btDisLootAddClick(Sender: TObject);
    procedure btDisLootUpdClick(Sender: TObject);
    procedure btDisLootDelClick(Sender: TObject);
    procedure btFullScriptDisLootClick(Sender: TObject);
    procedure tsItemScriptShow(Sender: TObject);
    procedure editQualityButtonClick(Sender: TObject);
    procedure editInventoryTypeButtonClick(Sender: TObject);
    procedure editRequiredReputationRankButtonClick(Sender: TObject);
    procedure GetStatType(Sender: TObject);
    procedure GetDmgType(Sender: TObject);
    procedure editbondingButtonClick(Sender: TObject);
    procedure LangButtonClick(Sender: TObject);
    procedure editPageMaterialButtonClick(Sender: TObject);
    procedure editMaterialButtonClick(Sender: TObject);
    procedure editsheathButtonClick(Sender: TObject);
    procedure editBagFamilyButtonClick(Sender: TObject);
    procedure editclassButtonClick(Sender: TObject);
    procedure editsubclassButtonClick(Sender: TObject);
    procedure edititemsetButtonClick(Sender: TObject);
    procedure GetPage(Sender: TObject);
    procedure GetMap(Sender: TObject);
    procedure GetItemFlags(Sender: TObject);
    procedure GetItemFlags2(Sender: TObject);
    procedure nRebuildSpellListClick(Sender: TObject);
    procedure edotentryButtonClick(Sender: TObject);
    procedure btScriptFishingLootClick(Sender: TObject);
    procedure btFullScriptFishLootClick(Sender: TObject);
    procedure tsOtherScriptShow(Sender: TObject);
    procedure tsDBScriptsOnShow(Sender: TObject);
    procedure btCopyToClipboardOtherClick(Sender: TObject);
    procedure btExecuteOtherScriptClick(Sender: TObject);
    procedure btCopyToClipDBScriptsOnClick(Sender: TObject);
    procedure btExecuteDBScriptsOnClick(Sender: TObject);
    procedure lvotFishingLootSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvotFishingLootChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure btGetLootForZoneClick(Sender: TObject);
    procedure btFishingLootAddClick(Sender: TObject);
    procedure btFishingLootUpdClick(Sender: TObject);
    procedure btFishingLootDelClick(Sender: TObject);
    procedure edSearchItemSubclassButtonClick(Sender: TObject);
    procedure edqtZoneOrSortButtonClick(Sender: TObject);
    procedure edqtZoneOrSortChange(Sender: TObject);
    procedure edZoneOrSortSearchButtonClick(Sender: TObject);
    procedure btSearchPageTextClick(Sender: TObject);
    procedure lvSearchPageTextSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btScriptPageTextClick(Sender: TObject);
    procedure LoadPageText(Sender: TObject);
    procedure btScriptConditionsClick(Sender: TObject);
	procedure btScriptTaxiShortcutsClick(Sender: TObject);
    procedure btDBScriptsOnClick(Sender: TObject);
    procedure btssShowFullScriptOnClick(Sender: TObject);
    procedure btesShowFullScriptOnClick(Sender: TObject);
    procedure btcmsShowFullScriptOnClick(Sender: TObject);
    procedure btcdsShowFullScriptOnClick(Sender: TObject);
    procedure btgbShowFullScriptOnClick(Sender: TObject);
    procedure btgtbShowFullScriptOnClick(Sender: TObject);
    procedure btdoeShowFullScriptOnClick(Sender: TObject);
    procedure btdogShowFullScriptOnClick(Sender: TObject);
    procedure btdosShowFullScriptOnClick(Sender: TObject);
    procedure btdorShowFullScriptOnClick(Sender: TObject);
    procedure btrtFullScriptOnClick(Sender: TObject);
    procedure LoadConditions(Sender: TObject);
    procedure LoadTaxiShortcuts(Sender: TObject);
    procedure LoadDBScriptString(Sender: TObject);
    procedure LoadDBScripts(Sender: TObject; TableName: string; prefix: string);
    procedure LoadDBScriptsOnQuestStart(Sender: TObject);
    procedure LoadDBScriptsOnQuestEnd(Sender: TObject);
    procedure LoadDBScriptsOnCreatureMvmnt(Sender: TObject);
    procedure LoadDBScriptsOnCreatureDeath(Sender: TObject);
    procedure LoadDBScriptsOnGoUse(Sender: TObject);
    procedure LoadDBScriptsOnGoTemplateUse(Sender: TObject);
    procedure LoadDBScriptsOnEvent(Sender: TObject);
    procedure LoadDBScriptsOnGossip(Sender: TObject);
    procedure LoadDBScriptsOnSpell(Sender: TObject);
    procedure LoadDBScriptsOnRelay(Sender: TObject);
    procedure LoadDBScriptsOnRandomTemplates(Sender: TObject);
    procedure LoadCreatureModelInfo(Sender: TObject);
    procedure LoadGossipMenuOption(Sender: TObject);
    procedure btSQLOpenClick(Sender: TObject);
    procedure btScriptCreatureLocationCustomToAllClick(Sender: TObject);
    procedure btFullScriptProsLootClick(Sender: TObject);
    procedure btProsLootAddClick(Sender: TObject);
    procedure btProsLootUpdClick(Sender: TObject);
    procedure btProsLootDelClick(Sender: TObject);
    procedure lvitProsLootChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvitProsLootSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvssStartScriptChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvesEndScriptChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvssStartScriptSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvesEndScriptSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btssAddClick(Sender: TObject);
    procedure btssUpdClick(Sender: TObject);
    procedure btssDelClick(Sender: TObject);
    procedure btesAddClick(Sender: TObject);
    procedure btesUpdClick(Sender: TObject);
    procedure btesDelClick(Sender: TObject);
    procedure GetCommand(Sender: TObject);
    procedure GetDataFlags(Sender: TObject);
    procedure edcontypeChange(Sender: TObject);
    procedure edsscommandChange(Sender: TObject);
    procedure edescommandChange(Sender: TObject);
    procedure edcmscommandChange(Sender: TObject);
    procedure edcdscommandChange(Sender: TObject);
    procedure edgbcommandChange(Sender: TObject);
    procedure edgtbcommandChange(Sender: TObject);
    procedure eddoecommandChange(Sender: TObject);
    procedure eddogcommandChange(Sender: TObject);
    procedure eddoscommandChange(Sender: TObject);
    procedure eddorcommandChange(Sender: TObject);
    procedure lvitEnchantmentChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvitEnchantmentSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btieEnchAddClick(Sender: TObject);
    procedure btieEnchUpdClick(Sender: TObject);
    procedure btieEnchDelClick(Sender: TObject);
    procedure btieShowFullScriptClick(Sender: TObject);
    procedure btCharSearchClick(Sender: TObject);
    procedure btCharClearClick(Sender: TObject);
    procedure CheckforUpdates1Click(Sender: TObject);
    procedure SpeedButtonClick(Sender: TObject);
    procedure tsItemLootedFromShow(Sender: TObject);
    procedure lvitItemLootedFromDblClick(Sender: TObject);
    procedure nUninstallClick(Sender: TObject);
    procedure lvQuickListMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure lvQuickListClick(Sender: TObject);
    procedure lvQuickListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btSearchGameEventClick(Sender: TObject);
    procedure lvSearchGameEventSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btGameEventAddClick(Sender: TObject);
    procedure btGameEventUpdClick(Sender: TObject);
    procedure btGameEventDelClick(Sender: TObject);
    procedure lvSearchGameEventChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvGameEventCreatureChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvGameEventGOChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure btgeCreatureGuidAddClick(Sender: TObject);
    procedure btgeCreatureGuidDelClick(Sender: TObject);
    procedure lvGameEventCreatureSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvGameEventGOSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btgeCreatureGuidInvClick(Sender: TObject);
    procedure btgeGOGuidInvClick(Sender: TObject);
    procedure lvGameEventCreatureDblClick(Sender: TObject);
    procedure lvGameEventGODblClick(Sender: TObject);
    procedure edgeCreatureGuidButtonClick(Sender: TObject);
    procedure edgeGOguidButtonClick(Sender: TObject);
    procedure btgeGOGuidAddClick(Sender: TObject);
    procedure btgeGOguidDelClick(Sender: TObject);
    procedure btFullScriptCreatureLocationClick(Sender: TObject);
    procedure btFullScriptGOLocationClick(Sender: TObject);
    procedure lvqtGiverTemplateDblClick(Sender: TObject);
    procedure lvqtGiverTemplateSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvqtTakerTemplateSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvqtTakerTemplateDblClick(Sender: TObject);
    procedure btAddQuestGiverClick(Sender: TObject);
    procedure lvqtGiverTemplateChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvqtTakerTemplateChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure btDelQuestGiverClick(Sender: TObject);
    procedure btDelQuestTakerClick(Sender: TObject);
    procedure edcgtextidButtonClick(Sender: TObject);
    procedure btShowNPCtextScriptClick(Sender: TObject);
    procedure nReconnectClick(Sender: TObject);
    procedure tsCreatureUsedShow(Sender: TObject);
    procedure lvCreatureStartsEndsDblClick(Sender: TObject);
    procedure tsGOInvolvedInShow(Sender: TObject);
    procedure tsItemInvolvedInShow(Sender: TObject);
    procedure lvcoCreatureLootDblClick(Sender: TObject);
    procedure lvcmMovementChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure btCreatureMvmntAddClick(Sender: TObject);
    procedure btCreatureMvmntUpdClick(Sender: TObject);
    procedure btCreatureMvmntDelClick(Sender: TObject);
    procedure lvcmMovementSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btFullCreatureMovementScriptClick(Sender: TObject);
    procedure lvcmtMovementChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure btCreatureMvmntTemplateAddClick(Sender: TObject);
    procedure btCreatureMvmntTemplateUpdClick(Sender: TObject);
    procedure btCreatureMvmntTemplateDelClick(Sender: TObject);
    procedure lvcmtMovementSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btFullCreatureMvmntTemplateScriptClick(Sender: TObject);
    procedure tsCreatureEquipTemplateShow(Sender: TObject);
    procedure tsCreatureModelInfoShow(Sender: TObject);
    procedure btCreatureModelSearchClick(Sender: TObject);
    procedure lvCreatureModelSearchSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure tsCreatureOnKillReputationShow(Sender: TObject);
    procedure reaShow(Sender: TObject);
    procedure tsNPCgossipShow(Sender: TObject);
    procedure tsGOLootShow(Sender: TObject);
    procedure tsItemLootShow(Sender: TObject);
    procedure tsDisenchantLootShow(Sender: TObject);
    procedure tsProspectingLootShow(Sender: TObject);
    procedure tsEnchantmentShow(Sender: TObject);
    procedure editFoodTypeButtonClick(Sender: TObject);
    procedure tsCreatureTemplateAddonShow(Sender: TObject);
    procedure tsCreatureTemplateSpellsShow(Sender: TObject);
    procedure editGemPropertiesButtonClick(Sender: TObject);
    procedure editsocketBonusButtonClick(Sender: TObject);
    procedure lvgbGOScriptChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvgtbGOTemplateScriptChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvgbGOScriptSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvgtbGOTemplateScriptSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvdoeEventScriptChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvdoeEventScriptSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvdogGossipScriptChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvdogGossipScriptSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvdosSpellScriptChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvdosSpellScriptSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvdorRelayScriptChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvdorRelayScriptSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvrtRandomScriptChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvrtRandomScriptSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btgbAddClick(Sender: TObject);
    procedure btgbUpdClick(Sender: TObject);
    procedure btgbDelClick(Sender: TObject);
    procedure btgtbAddClick(Sender: TObject);
    procedure btgtbUpdClick(Sender: TObject);
    procedure btgtbDelClick(Sender: TObject);
    procedure btdoeAddClick(Sender: TObject);
    procedure btdoeUpdClick(Sender: TObject);
    procedure btdoeDelClick(Sender: TObject);
    procedure btdogAddClick(Sender: TObject);
    procedure btdogUpdClick(Sender: TObject);
    procedure btdogDelClick(Sender: TObject);
    procedure btdosAddClick(Sender: TObject);
    procedure btdosUpdClick(Sender: TObject);
    procedure btdosDelClick(Sender: TObject);
    procedure btdorAddClick(Sender: TObject);
    procedure btdorUpdClick(Sender: TObject);
    procedure btdorDelClick(Sender: TObject);
    procedure btrtAddClick(Sender: TObject);
    procedure btrtUpdClick(Sender: TObject);
    procedure btrtDelClick(Sender: TObject);
    procedure tsButtonScriptShow(Sender: TObject);
    procedure btBrowsePopupClick(Sender: TObject);
    procedure edcvExtendedCostButtonClick(Sender: TObject);
    procedure lvSearchCharDblClick(Sender: TObject);
    procedure btShowCharacterScriptClick(Sender: TObject);
    procedure tsCharacterScriptShow(Sender: TObject);
    procedure edhtguidButtonClick(Sender: TObject);
    procedure edconentryButtonClick(Sender: TObject);
    procedure edtspathidButtonClick(Sender: TObject);
    procedure eddbsentryButtonClick(Sender: TObject);
    procedure edssidButtonClick(Sender: TObject);
    procedure edesidButtonClick(Sender: TObject);
    procedure edcmsidButtonClick(Sender: TObject);
    procedure edcmidButtonClick(Sender: TObject);
    procedure edcmtentryButtonClick(Sender: TObject);
    procedure edcdsidButtonClick(Sender: TObject);
    procedure edgbidButtonClick(Sender: TObject);
    procedure edgtbidButtonClick(Sender: TObject);
    procedure eddoeidButtonClick(Sender: TObject);
    procedure eddogidButtonClick(Sender: TObject);
    procedure eddosidButtonClick(Sender: TObject);
    procedure eddoridButtonClick(Sender: TObject);
    procedure edrtidButtonClick(Sender: TObject);
    procedure edrttarget_idButtonClick(Sender: TObject);
    procedure edclguidButtonClick(Sender: TObject);
    procedure edclidButtonClick(Sender: TObject);
    procedure edcimodelidButtonClick(Sender: TObject);
    procedure edcgmomenu_idButtonClick(Sender: TObject);
    procedure btCopyToClipboardCharClick(Sender: TObject);
    procedure btExecuteScriptCharClick(Sender: TObject);
    procedure edhtdataButtonClick(Sender: TObject);
    procedure edhttaximaskButtonClick(Sender: TObject);
    procedure btShowFULLCharacterInventoryScriptClick(Sender: TObject);
    procedure lvCharacterInventoryChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvCharacterInventorySelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btCharInvAddClick(Sender: TObject);
    procedure btCharInvUpdClick(Sender: TObject);
    procedure btCharInvDelClick(Sender: TObject);
    procedure GetConditions(Sender: TObject);
    procedure GetTextType(Sender: TObject);
    procedure GetSpecialFlags(Sender: TObject);
    procedure GetArea(Sender: TObject);
    procedure GetSoundEntries(Sender: TObject);
    procedure JvHttpUrlGrabberError(Sender: TObject; ErrorMsg: string);
    procedure JvHttpUrlGrabberDoneStream(Sender: TObject; Stream: TStream; StreamSize: Integer; Url: string);
    procedure GetSpellTrigger(Sender: TObject);
    procedure GetUnitFlags(Sender: TObject);
    procedure GetFlagsExtra(Sender: TObject);
    procedure GetCreatureTypeFlags(Sender: TObject);
    procedure GetCreatureDynamicFlags(Sender: TObject);
    procedure GetGOFlags(Sender: TObject);
    procedure GetMovementType(Sender: TObject);
    procedure GetInhabitType(Sender: TObject);
    procedure lvcnEventAISelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure GetEventFlags(Sender: TObject);
    procedure GetCastFlags(Sender: TObject);
    procedure GetEventType(Sender: TObject);
    procedure GetActionType(Sender: TObject);
    procedure GetTargetType(Sender: TObject);
    procedure linkEventAIInfoClick(Sender: TObject);
    procedure GetMechanicImmuneMask(Sender: TObject);
    procedure GetSchoolImmuneMask(Sender: TObject);
    procedure lvSearchItemCustomDrawSubItem(Sender: TCustomListView; Item: TListItem; SubItem: Integer;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure edcnevent_typeChange(Sender: TObject);
    procedure edcnaction_typeChange(Sender: TObject; num: string);
    procedure edcnaction1_typeChange(Sender: TObject);
    procedure edcnaction2_typeChange(Sender: TObject);
    procedure edcnaction3_typeChange(Sender: TObject);
    procedure nEditCreatureAIClick(Sender: TObject);
    procedure btEventAIAddClick(Sender: TObject);
    procedure btEventAIUpdClick(Sender: TObject);
    procedure lvcnEventAIChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure btEventAIDelClick(Sender: TObject);
    procedure btlqShowFullLocalesScriptClick(Sender: TObject);
    procedure lvitMillingLootSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvitMillingLootChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure btMillingLootAddClick(Sender: TObject);
    procedure btMillingLootUpdClick(Sender: TObject);
    procedure btMillingLootDelClick(Sender: TObject);
    procedure tsMillingLootShow(Sender: TObject);
    procedure tsSpellLootShow(Sender: TObject);
    procedure btFullScriptMillingLootClick(Sender: TObject);
    procedure edctEquipmentTemplateIdDblClick(Sender: TObject);
    procedure edflagsChange(Sender: TObject);
    procedure btReferenceLootAddClick(Sender: TObject);
    procedure btReferenceLootUpdClick(Sender: TObject);
    procedure btReferenceLootDelClick(Sender: TObject);
    procedure lvitReferenceLootChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvitReferenceLootSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btFullScriptReferenceLootClick(Sender: TObject);
    procedure btSpellLootAddClick(Sender: TObject);
    procedure btSpellLootUpdClick(Sender: TObject);
    procedure btSpellLootDelClick(Sender: TObject);
    procedure lvslSpellLootChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvslSpellLootSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btFullScriptSpellLootClick(Sender: TObject);
    procedure edirentryButtonClick(Sender: TObject);
    procedure GetSpawnMask(Sender: TObject);
    procedure btcmsAddClick(Sender: TObject);
    procedure btcmsUpdClick(Sender: TObject);
    procedure btcmsDelClick(Sender: TObject);
    procedure btcdsAddClick(Sender: TObject);
    procedure btcdsUpdClick(Sender: TObject);
    procedure btcdsDelClick(Sender: TObject);
    procedure lvcmsCreatureMovementScriptChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvcmsCreatureMovementScriptSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvcdsCreatureOnDeathScriptChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvcdsCreatureOnDeathScriptSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvcvtNPCVendorSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btVendorTemplateAddClick(Sender: TObject);
    procedure btVendorTemplateUpdClick(Sender: TObject);
    procedure btVendorTemplateDelClick(Sender: TObject);
    procedure lvcvtNPCVendorChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure btFullScriptVendorTemplateClick(Sender: TObject);
    procedure edctVendorTemplateIdButtonClick(Sender: TObject);
    procedure btFullScriptTrainerTemplateClick(Sender: TObject);
    procedure lvcrtNPCTrainerChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvcrtNPCTrainerSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure edctTrainerTemplateIdButtonClick(Sender: TObject);
    procedure edctEquipTemplateIdButtonClick(Sender: TObject);
    procedure edqtRewMailTemplateIdButtonClick(Sender: TObject);
    procedure btTrainerTemplateAddClick(Sender: TObject);
    procedure btTrainerTemplateUpdClick(Sender: TObject);
    procedure btTrainerTemplateDelClick(Sender: TObject);
    procedure NPCTextLoc1btnpctextClick(Sender: TObject);
    procedure edctGossipMenuIdButtonClick(Sender: TObject);
    procedure edcgmentryButtonClick(Sender: TObject);
    procedure tsGossipMenuShow(Sender: TObject);
    procedure edcgmtext_idButtonClick(Sender: TObject);
    procedure btGossipMenuOptionDelClick(Sender: TObject);
    procedure lvcgmOptionsChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvcgmOptionsSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btGossipMenuOptionUpdClick(Sender: TObject);
    procedure btGossipMenuOptionAddClick(Sender: TObject);
    procedure btShowGossipMenuOptionsScriptClick(Sender: TObject);
    procedure GetOptionIcon(Sender: TObject);
    procedure edcgmoaction_menu_idButtonClick(Sender: TObject);
    procedure GetStandState(Sender: TObject);
    procedure GetFactionFlags(Sender: TObject);

  private
    { Private declarations }
    Spells: TList;
    GlobalFlag: Boolean;
    IsFirst: Boolean;
    Thread: TCheckQuestThread;
    ItemColors: array [0 .. 6] of Integer;
    edit: TJvComboEdit;
    lvQuickList: TListView;

    procedure GetValueFromSimpleList(Sender: TObject; TextId: Integer; Name: String; Sort: Boolean);
    procedure GetValueFromSimpleList2(Sender: TObject; TextId: Integer; Name: String; Sort: Boolean; id1: string);

    procedure SearchQuest();
    procedure LoadQuest(QuestID: Integer);
    procedure ChangeNamesOfComponents;
    procedure CompleteScript;
    procedure CompleteLocalesQuest;
    procedure CompleteMailLootScript;
    procedure CompleteGreetingScript;
    procedure ExecuteScript(script: string; memo: TMemo); overload;
    procedure LoadQuestGivers(QuestID: Integer);
    procedure LoadQuestTakers(QuestID: Integer);
    procedure LoadQuestLocales(QuestID: Integer);
    procedure LoadQuestMailLoot(edqtRewMailTemplateId: Integer);
    procedure LoadQuestGiverInfo(objtype: string; entry: string);
    procedure ClearQuestGiverGreeting;
    procedure LoadQuestGiverGreeting(objtype: string; entry: string);
    procedure LoadQuestTakerInfo(objtype: string; entry: string);
    procedure LoadQuestStartScript(Sender: TObject);
    procedure LoadQuestCompleteScript(Sender: TObject);
    procedure SetScriptEditFields(pfx: string; lvList: TJvListView);
	procedure SetRandomTemplatesScriptEditFields(pfx: string; lvList: TJvListView);
    procedure ClearFields(Where: TType);
    procedure SetDefaultFields(Where: TType);
    procedure ShowSettings(n: Integer);
    procedure SaveToReg;
    procedure LoadFromReg;
    procedure SetDBSpellList;

    { creatures }
    procedure SearchCreature;
    // procedure SearchCreatureEquipTemplate;
    procedure SearchCreatureModelInfo;

    procedure LoadCreature(entry: Integer);
    procedure LoadCreatureTemplateAddon(entry: Integer);
    procedure LoadCreatureTemplateSpells(entry: Integer);
    procedure LoadCreatureAddon(GUID: Integer);
    procedure LoadCreatureEquip(entry: Integer);
    procedure LoadCreatureMovement(GUID: Integer);
    procedure LoadCreatureMovementTemplate(Entry: Integer);
    procedure LoadCreatureOnKillReputation(id: string);
    procedure LoadNPCgossip(GUID: Integer);
    procedure LoadNPCText(TextId: string);
    procedure LoadCreatureLocation(GUID: Integer);
    procedure LoadCreatureLocationSearchID(ID: Integer);

    procedure SetCreatureModelEditFields(pfx: string; lvList: TJvListView);

    procedure CompleteCreatureScript;
    procedure CompleteCreatureLocationScript;
    procedure CompleteCreatureLootScript;
    procedure CompleteCreatureEquipTemplateScript;
    procedure CompleteCreatureModelInfoScript;
    procedure CompletePickpocketLootScript;
    procedure CompleteSkinLootScript;
    procedure CompleteNPCTrainerScript;
    procedure CompleteNPCVendorScript;
    procedure CompleteNPCVendorTemplateScript;
    procedure CompleteCreatureTemplateAddonScript;
    procedure CompleteCreatureTemplateSpellsScript;
    procedure CompleteCreatureEventAIScript;
    procedure CompleteCreatureAddonScript;
    procedure CompleteCreatureMovementScript;
    procedure CompleteCreatureMvmntTemplateScript;
    procedure CompleteCreatureOnKillReputationScript;
    procedure CompleteNPCgossipScript;
    procedure CompleteNPCtextScript;

    { gameobjects }
    procedure SearchGO;
    procedure LoadGO(entry: Integer);
    procedure LoadGOLocation(GUID: Integer);
    procedure CompleteGOLocationScript;
    procedure CompleteGOLootScript;
    procedure CompleteGOScript;

    { items }
    procedure SearchItem;
    procedure LoadItem(entry: Integer);
    procedure CompleteItemLootScript;
    procedure CompleteDisLootScript;
    procedure CompleteProsLootScript;
    procedure CompleteMillingLootScript;
    procedure CompleteReferenceLootScript;
    procedure CompleteSpellLootScript;
    procedure CompleteItemScript;
    procedure CompleteItemEnchScript;

    { chars }
    procedure LoadCharacter(GUID: Integer);
    procedure LoadCharacterInventory(GUID: Integer);
    procedure CompleteCharacterScript;
    procedure CompleteCharacterInventoryScript;

    { loot }
    procedure LootAdd(pfx: string; lvList: TJvListView);
    procedure LootUpd(pfx: string; lvList: TJvListView);
    procedure LootDel(lvList: TJvListView);
    procedure SetLootEditFields(pfx: string; lvList: TJvListView);
    procedure ShowFullLootScript(TableName: string; lvList: TJvListView; memo: TMemo; entry: string);

    { movement }
    procedure MvmntAdd(pfx: string; lvList: TJvListView);
    procedure MvmntUpd(pfx: string; lvList: TJvListView);
    procedure MvmntDel(lvList: TJvListView);
    procedure SetMvmntEditFields(pfx: string; lvList: TJvListView);

    procedure ScriptAdd(pfx: string; lvList: TJvListView);
    procedure ScriptDel(lvList: TJvListView);
    procedure ScriptUpd(pfx: string; lvList: TJvListView);
    procedure RandomTemplatesScriptAdd(pfx: string; lvList: TJvListView);
    procedure RandomTemplatesScriptUpd(pfx: string; lvList: TJvListView);

    procedure EnchAdd(pfx: string; lvList: TJvListView);
    procedure EnchDel(lvList: TJvListView);
    procedure EnchUpd(pfx: string; lvList: TJvListView);

    procedure SetEnchEditFields(pfx: string; lvList: TJvListView);
    procedure ShowFullEnchScript(TableName: string; lvList: TJvListView; memo: TMemo; entry: string);

    { Event AI }
    procedure SetEventAIEditFields(pfx: string; lvList: TJvListView);
    procedure EventAIAdd(pfx: string; lvList: TJvListView);
    procedure EventAIUpd(pfx: string; lvList: TJvListView);
    procedure EventAIDel(lvList: TJvListView);
    procedure ShowFullEventAiScript(TableName: string; lvList: TJvListView; memo: TMemo; entry: string);

    { other }
    function MakeSetForUpdate(MyTempQuery: TZQuery; pfx: string; IsLocale : boolean): string;
    function MakeUpdate(tn: string; pfx: string; IsLocale : boolean; KeyName: string; KeyValue: string): string;
    function MakeUpdate2(tn: string; pfx: string; IsLocale : boolean; KeyName1: string; KeyValue1: string; KeyName2: string; KeyValue2: string): string;
    function MakeUpdate3(tn: string; pfx: string; IsLocale : boolean; KeyName1: string; KeyValue1: string; KeyName2: string; KeyValue2: string; KeyName3: string; KeyValue3: string): string;
    procedure CompleteFishingLootScript;
    procedure SearchPageText;
    procedure SearchGameEvent;
    procedure CompletePageTextScript;
    procedure CompleteConditionsScript;
	procedure CompleteTaxiShortcutsScript;
    procedure CompleteDbScriptStringScript;
    procedure CompleteGameEventScript;
    procedure CompleteDbScripts(TableName: string; prefix: string; entry: string; delay: string; command: string);
    procedure CompleteDbScriptRandomTemplates(TableName: string; prefix: string; entry: string; entry_type: string; target_id: string);
    procedure CompleteDbScriptsOnQuestStartScript;
    procedure CompleteDbScriptsOnQuestEndScript;
    procedure CompleteDbScriptsOnCreatureDeathScript;
    procedure CompleteDbScriptsOnCreatureMvmntScript;
    procedure CompleteDbScriptsOnGoUseScript;
    procedure CompleteDbScriptsOnGoTemplateUseScript;
    procedure CompleteDbScriptsOnEventScript;
    procedure CompleteDbScriptsOnGossipScript;
    procedure CompleteDbScriptsOnSpellScript;
    procedure CompleteDbScriptsOnRelayScript;
    procedure CompleteDbScriptRandomTemplatesScript;

    procedure EditThis(objtype: string; entry: string);
    procedure CreateNPCTextFields;

    procedure SetGOdataHints(t: Integer);
    procedure SetGOdataNames(t: Integer);

    procedure LoadMyQueryToListView(Query: TZQuery; strQuery: string; ListView: TJvListView);
    procedure LoadQueryToListView(strQuery: string; ListView: TJvListView);
    procedure LoadCharQueryToListView(strQuery: string; ListView: TJvListView);

    procedure SetFieldsAndValues(Query: TZQuery; var Fields: string; var Values: string; TableName: string; pfx: string;
      Log: TMemo); overload;

    procedure SetFieldsAndValues(var Fields: string; var Values: string; TableName: string; pfx: string;
      Log: TMemo); overload;

    procedure FillFields(Query: TZQuery; pfx: string);

    procedure RebuildSpellList;
    procedure ChangeScriptCommand(command: Integer; pfx: string);
    procedure ChangeConditionType(condition_type: Integer; pfx: string);
    procedure SearchChar;

    procedure GetGuid(Sender: TObject; otype: string);

    procedure LoadCreaturesAndGOForGameEvent(entry: string);
    function FullScript(TableName, KeyName, KeyValue: string): string;
    procedure EditButtonClick(Sender: TObject);
    procedure LoadCreatureInvolvedIn(entry: string);
    procedure LoadGOInvolvedIn(entry: string);
    procedure LoadItemInvolvedIn(entry: string);
    function GetValueFromDBC(Name: string; id: Cardinal; idx_str: Integer = 1): string;
    function GetZoneOrSortAcronym(ZoneOrSort: Integer): string;
    function DBScriptsOnSQLScript(lvList: TJvListView; tn, id: string): string;
	function FullMvmntScript(lvList: TJvListView; tn: string; id: string): string;
	function FullMvmntTmplScript(lvList: TJvListView; tn: string; id: string): string;
    function RandomTemplatesSQLScript(lvList: TJvListView; tn, id: string): string;
    procedure GetSomeFlags(Sender: TObject; What: string);
    function GetActionParamHint(ActionType, ParamNo: Integer): string;
    procedure LoadGossipMenu(entry: Integer);
    procedure CompleteGossipMenuScript;
    procedure ClearCGMOptionsFields;
    procedure SetVisibleForMangosOnlyFields(IsVisible: Boolean);
    procedure SetVisibleForCMangosOnlyFields(IsVisible: Boolean);

  public
    SplashForm: TAboutBox;
    SyntaxStyle: TSyntaxStyle;

    CharDBName: string;
    RealmDBName: string;
    ScriptDBName: string;

    function Connect: Boolean;

    function IsNumber(S: string): Boolean;
    function IsSpellInBase(id: Integer): Boolean;
    procedure StopThread;
    procedure LoadLoot(var lvList: TJvListView; Key: string);
    function DollToSym(Text: string): string;
    function SymToDoll(Text: string): string;
    procedure EraseBackground(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure CheckForUpdates(flag: Boolean);
    function CurVer(): Integer;
    function CreateVer(Ver: Integer): string;
    procedure WMFreeQL(var Message: TMessage); message WM_FREEQL;

    procedure UpdateCaption;

    function GetDBVersion: string;

    procedure QLPrepare;

    procedure EditMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure EditMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
  end;

var
  MainForm: TMainForm;

implementation

uses StrUtils, Functions, WhoUnit, ItemUnit, CreatureOrGOUnit, ListUnit, CheckUnit, SpellsUnit, SettingsUnit,
  ItemPageUnit, GUIDUnit, CharacterDataUnit, TaxiMaskFormUnit, MeConnectForm, AreaTableUnit,
  UnitFlagsUnit, SoundEntriesUnit;

{$R *.dfm}

procedure TMainForm.FormActivate(Sender: TObject);
begin
  if not MyMangosConnection.Connected then
    Application.Terminate
  else
  begin
    if Assigned(CheckForm) and CheckForm.Visible then
    begin
      CheckForm.Show;
      Exit;
    end;
    if (PageControl1.ActivePageIndex = 0) and (PageControl2.ActivePageIndex = 0) then
      edQuestID.SetFocus;
  end;
end;

procedure TMainForm.btSearchClick(Sender: TObject);
begin
  SearchQuest();
  with lvQuest do
    if Items.Count > 0 then
    begin
      SetFocus;
      Selected := Items[0];
      btEditQuest.Default := true;
      btSearch.Default := false;
    end;
  StatusBar.Panels[0].Text := Format(dmMain.Text[79], [lvQuest.Items.Count]);
end;

procedure TMainForm.SearchQuest;
var
  i, PrevQuestId_, NextQuestId_: Integer;
  loc, id, QTilte, QueryStr, WhereStr, qgq, qtq, who, Key, t, ZoneOrSort, QuestFlags: string;
  Field: TField;
begin
  loc := LoadLocales();
  ShowHourGlassCursor;
  qgq := '';
  qtq := '';
  ZoneOrSort := '';
  if edQuestGiverSearch.Text <> '' then
  begin
    GetWhoAndKey(edQuestGiverSearch.Text, who, Key);
    if who = 'creature' then
      MyTempQuery.SQL.Text := Format('SELECT `quest` FROM `creature_questrelation` WHERE (`id`=%s)', [Key])
    else if who = 'gameobject' then
      MyTempQuery.SQL.Text := Format('SELECT `quest` FROM `gameobject_questrelation` WHERE (`id`=%s)', [Key])
    else if who = 'item' then
      MyTempQuery.SQL.Text := Format('SELECT `startquest` FROM `item_template` WHERE (`entry`=%s)', [Key]);

    if MyTempQuery.SQL.Text <> '' then
    begin
      MyTempQuery.Open;
      if MyTempQuery.Eof then
        Exit;
      while not MyTempQuery.Eof do
      begin
        if qgq = '' then
          qgq := Format('%d', [MyTempQuery.Fields[0].AsInteger])
        else
          qgq := Format('%s,%d', [qgq, MyTempQuery.Fields[0].AsInteger]);
        MyTempQuery.Next;
      end;
      MyTempQuery.Close;
    end;
  end;

  if edQuestTakerSearch.Text <> '' then
  begin
    GetWhoAndKey(edQuestTakerSearch.Text, who, Key);
    if who = 'creature' then
      MyTempQuery.SQL.Text := Format('SELECT `quest` FROM `creature_involvedrelation` WHERE (`id`=%s)', [Key])
    else if who = 'gameobject' then
      MyTempQuery.SQL.Text := Format('SELECT `quest` FROM `gameobject_involvedrelation` WHERE (`id`=%s)', [Key]);
    if MyTempQuery.SQL.Text <> '' then
    begin
      MyTempQuery.Open;
      if MyTempQuery.Eof then
        Exit;
      while not MyTempQuery.Eof do
      begin
        if qtq = '' then
          qtq := Format('%d', [MyTempQuery.Fields[0].AsInteger])
        else
          qtq := Format('%s,%d', [qtq, MyTempQuery.Fields[0].AsInteger]);
        MyTempQuery.Next;
      end;
      MyTempQuery.Close;
    end;
  end;

  id := edQuestID.Text;
  QTilte := edQuestTitle.Text;
  QTilte := StringReplace(QTilte, '''', '\''', [rfReplaceAll]);
  QTilte := StringReplace(QTilte, ' ', '%', [rfReplaceAll]);
  QTilte := '%' + QTilte + '%';
  QueryStr := '';
  WhereStr := '';
  if id <> '' then
  begin
    if pos('-', id) = 0 then
      WhereStr := Format('WHERE (qt.`entry` in (%s))', [id])
    else
      WhereStr := Format('WHERE (qt.`entry` >= %s) AND (qt.`entry` <= %s)',
        [MidStr(id, 1, pos('-', id) - 1), MidStr(id, pos('-', id) + 1, length(id))]);
  end;

  if QTilte <> '%%' then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND ((qt.`title` LIKE ''%s'') OR (lq.title' + loc + ' LIKE ''%1:s''))', [WhereStr, QTilte])
    else
      WhereStr := Format('WHERE ((qt.`title` LIKE ''%s'')OR (lq.title' + loc + ' LIKE ''%0:s''))', [QTilte]);
  end;

  if qgq <> '' then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND (qt.`entry` IN (%s))', [WhereStr, qgq])
    else
      WhereStr := Format('WHERE (qt.`entry` IN (%s))', [qgq]);
  end;

  if qtq <> '' then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND (qt.`entry` IN (%s))', [WhereStr, qtq])
    else
      WhereStr := Format('WHERE (qt.`entry` IN (%s))', [qtq]);
  end;

  ZoneOrSort := edZoneOrSortSearch.Text;
  QuestFlags := edQuestFlagsSearch.Text;

  if ZoneOrSort <> '' then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND (qt.`zoneorsort`=%s)', [WhereStr, ZoneOrSort])
    else
      WhereStr := Format('WHERE (qt.`zoneorsort`=%s)', [ZoneOrSort]);
  end;

  if QuestFlags <> '' then
  begin
    if rbExact.Checked then
    begin
      if WhereStr <> '' then
        WhereStr := Format('%s AND (qt.`QuestFlags`=%s)', [WhereStr, QuestFlags])
      else
        WhereStr := Format('WHERE (qt.`QuestFlags`=%s)', [QuestFlags]);
    end
    else
    begin
      if WhereStr <> '' then
        WhereStr := Format('%s AND (qt.`QuestFlags` & %1:s = %1:s)', [WhereStr, QuestFlags])
      else
        WhereStr := Format('WHERE (qt.`QuestFlags` & %0:s = %0:s)', [QuestFlags]);
    end;
  end;

  PrevQuestId_ := StrToIntDef(edPrevQuestIdSearch.Text, -1);
  if PrevQuestId_ <> -1 then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND (qt.`PrevQuestId`=%d)', [WhereStr, PrevQuestId_])
    else
      WhereStr := Format('WHERE (qt.`PrevQuestId`=%d)', [PrevQuestId_]);
  end;

  NextQuestId_ := StrToIntDef(edNextQuestIdSearch.Text, -1);
  if NextQuestId_ <> -1 then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND (qt.`NextQuestId`=%d)', [WhereStr, NextQuestId_])
    else
      WhereStr := Format('WHERE (qt.`NextQuestId`=%d)', [NextQuestId_]);
  end;

  if Trim(WhereStr) = '' then
    if MessageDlg(dmMain.Text[134], mtConfirmation, mbYesNoCancel, -1) <> mrYes then
      Exit;

  QueryStr := Format('SELECT * FROM quest_template qt LEFT OUTER JOIN locales_quest lq ON qt.entry=lq.entry %s',
    [WhereStr]);

  MyQuery.SQL.Text := QueryStr;
  lvQuest.Items.BeginUpdate;
  try
    MyQuery.Open;
    lvQuest.Clear;
    while not MyQuery.Eof do
    begin
      with lvQuest.Items.Add do
      begin
        for i := 0 to lvQuest.Columns.Count - 1 do
        begin
          Field := MyQuery.FindField(lvQuest.Columns[i].Caption);
          t := '';
          if Assigned(Field) then
          begin
            t := Field.AsString;
            if i = 0 then
              Caption := t;
          end;
          if i <> 0 then
            SubItems.Add(t);
        end;
        MyQuery.Next;
      end;
    end;
  finally
    lvQuest.Items.EndUpdate;
    MyQuery.Close;
  end;
end;

procedure TMainForm.SetVisibleForMangosOnlyFields(IsVisible: Boolean);
begin
  // quest
  edqtPortraitGiverName.Visible := IsVisible;
  edqtPortraitGiverText.Visible := IsVisible;
  edqtPortraitTurnInName.Visible := IsVisible;
  edqtPortraitTurnInText.Visible := IsVisible;
  edqtPortraitGiver.Visible := IsVisible;
  edqtPortraitTurnIn.Visible := IsVisible;
  lbqtPortraitGiver.Visible := IsVisible;
  lbqtPortraitTurnIn.Visible := IsVisible;

  edqtSoundAccept.Visible := IsVisible;
  edqtSoundTurnIn.Visible := IsVisible;

  // go
  edgtdata24.Visible := IsVisible;
  edgtdata25.Visible := IsVisible;
  edgtdata26.Visible := IsVisible;
  edgtdata27.Visible := IsVisible;
  edgtdata28.Visible := IsVisible;
  edgtdata29.Visible := IsVisible;
  edgtdata30.Visible := IsVisible;
  edgtdata31.Visible := IsVisible;

  // item
  editstat_unk1_1.Visible := IsVisible;
  editstat_unk1_2.Visible := IsVisible;
  editstat_unk1_3.Visible := IsVisible;
  editstat_unk1_4.Visible := IsVisible;
  editstat_unk1_5.Visible := IsVisible;
  editstat_unk1_6.Visible := IsVisible;
  editstat_unk1_7.Visible := IsVisible;
  editstat_unk1_8.Visible := IsVisible;
  editstat_unk1_9.Visible := IsVisible;
  editstat_unk1_10.Visible := IsVisible;

  editstat_unk2_1.Visible := IsVisible;
  editstat_unk2_2.Visible := IsVisible;
  editstat_unk2_3.Visible := IsVisible;
  editstat_unk2_4.Visible := IsVisible;
  editstat_unk2_5.Visible := IsVisible;
  editstat_unk2_6.Visible := IsVisible;
  editstat_unk2_7.Visible := IsVisible;
  editstat_unk2_8.Visible := IsVisible;
  editstat_unk2_9.Visible := IsVisible;
  editstat_unk2_10.Visible := IsVisible;
  editStatScalingFactor.Visible := IsVisible;

  editDamageType.Visible := IsVisible;
  lbitDamageType.Visible := IsVisible;
  editUnknown.Visible := IsVisible;
  editUnknown1.Visible := IsVisible;
  editUnknown2.Visible := IsVisible;
  editUnknown400_1.Visible := IsVisible;
  editUnknown400_2.Visible := IsVisible;
end;

procedure  TMainForm.SetVisibleForCMangosOnlyFields(IsVisible: Boolean);
begin
  gbitResistance.Visible := IsVisible;
  gbitDamage.Visible := IsVisible;
  editammo_type.Visible := IsVisible;
  editarmor.Visible := IsVisible;
  editblock.Visible := IsVisible;
  editScalingStatValue.Visible := IsVisible;
  editStatsCount.Visible := IsVisible;
end;

procedure TMainForm.FormCreate(Sender: TObject);
  procedure ApplyDBuf(form: TForm; bl: Boolean);
  var
    f: Integer;
  begin
    form.DoubleBuffered := bl;
    for f := 0 to form.ComponentCount - 1 do
    begin
      if form.Components[f] is TWinControl then
        TWinControl(form.Components[f]).DoubleBuffered := bl
    end
  end;

var
  i: Integer;
  IsCMangos: boolean;
begin

  IsCMangos := {$IFDEF CMANGOS}True{$ELSE}False{$ENDIF};
  SetVisibleForMangosOnlyFields(not IsCMangos);
  SetVisibleForCMangosOnlyFields(IsCMangos);

  FormatSettings.DecimalSeparator := '.';
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := true;
{$ENDIF}
  if not Connect then
    Exit;

  IsFirst := false;

  try
    if dmMain.IsAutoUpdates then
      CheckForUpdates(false);
  except
  end;

  Application.ProcessMessages;
  SetCursor(LoadCursor(0, IDC_WAIT));
  CreateNPCTextFields;
  NPCTextLoc1.CreateLocalesNPCTextFields;
  ChangeNamesOfComponents;
  LoadFromReg;
  Spells := TList.Create;
  SetDBSpellList;
  PageControl1.ActivePageIndex := 0;
  PageControl2.ActivePageIndex := 0;
  Application.HintPause := 200;
  Application.HintHidePause := 10000;

  tsNPCVendor.TabVisible := false;
  tsNPCTrainer.TabVisible := false;
  // tsCreatureEventAI.TabVisible := false;

  ItemColors[0] := $9D9D9D;
  ItemColors[1] := $000000;
  ItemColors[2] := $00FF1E;
  ItemColors[3] := $DD7000;
  ItemColors[4] := $EE35A3;
  ItemColors[5] := $0080FF;
  ItemColors[6] := $80CCE5;
  { translation stuff }
  dmMain.Translate.CreateDefaultTranslation(TForm(Self));
  dmMain.Translate.TranslateForm(TForm(Self));
  UpdateCaption;
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TPageControl then
      TPageControl(Components[i]).ActivePageIndex := 0;
    if (Components[i] is TLabeledEdit) and (pos('Count', TLabeledEdit(Components[i]).Name) > 0) then
    begin
      TLabeledEdit(Components[i]).OnMouseWheelDown := EditMouseWheelDown;
      TLabeledEdit(Components[i]).OnMouseWheelUp := EditMouseWheelUp;
    end;
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Spells.Free;
  MyMangosConnection.Disconnect;
  SaveToReg;
end;

procedure TMainForm.btAddQuestGiverClick(Sender: TObject);
var
  f: TWhoQuestForm;
begin
  f := TWhoQuestForm.Create(Self);
  try
    if Assigned(lvqtGiverTemplate.Selected) then
      f.Prepare(lvqtGiverTemplate.Selected.Caption + ',' + lvqtGiverTemplate.Selected.SubItems[0]);
    if f.ShowModal = mrOk then
    begin
      with lvqtGiverTemplate.Items.Add do
      begin
        Caption := f.rgTypeOfWho.Items[f.rgTypeOfWho.itemindex];
        SubItems.Add(f.lvWho.Selected.Caption);
      end;
    end;
  finally
    f.Free;
  end;
end;

procedure TMainForm.btAddQuestTakerClick(Sender: TObject);
var
  f: TWhoQuestForm;
begin
  f := TWhoQuestForm.Create(Self);
  try
    if Assigned(lvqtTakerTemplate.Selected) then
      f.Prepare(lvqtTakerTemplate.Selected.Caption + ',' + lvqtTakerTemplate.Selected.SubItems[0]);
    if f.ShowModal = mrOk then
    begin
      if f.rgTypeOfWho.itemindex = 2 then // item cannot be a quest taker now
        ShowMessage(dmMain.Text[1])
      else
        with lvqtTakerTemplate.Items.Add do
        begin
          Caption := f.rgTypeOfWho.Items[f.rgTypeOfWho.itemindex];
          SubItems.Add(f.lvWho.Selected.Caption);
        end;
    end;
  finally
    f.Free;
  end;
end;

procedure TMainForm.LoadQuest(QuestID: Integer);
begin
  ShowHourGlassCursor;
  ClearFields(ttQuest);
  // show tsQuest
  if QuestID < 1 then
    Exit;

  // load full description for quest
  MyQuery.SQL.Text := Format('SELECT * FROM `quest_template` WHERE `entry`=%d LIMIT 1', [QuestID]);
  MyQuery.Open;
  try
    if MyQuery.Eof then
      raise Exception.Create(Format(dmMain.Text[2], [QuestID])); // 'Error: Quest (%d) not found'
    edqtEntry.Text := IntToStr(QuestID);
    FillFields(MyQuery, PFX_QUEST_TEMPLATE);
    MyQuery.Close;

    MyQuery.SQL.Text := Format('SELECT * FROM `areatrigger_involvedrelation` WHERE `quest`=%d', [QuestID]);
    MyQuery.Open;
    if not MyQuery.Eof then
      edqtAreatrigger.Text := MyQuery.FieldByName('id').AsString
    else
      edqtAreatrigger.Clear;
    MyQuery.Close;

    LoadQuestGivers(QuestID);
    LoadQuestTakers(QuestID);
    LoadQuestLocales(QuestID);
    LoadQuestMailLoot(StrToInt(edqtRewMailTemplateId.Text));
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[3] + #10#13 + E.Message);
  end;
end;

procedure TMainForm.lvQuestDblClick(Sender: TObject);
begin
  if Assigned(lvQuest.Selected) then
  begin
    PageControl2.ActivePageIndex := 1;
    LoadQuest(StrToInt(lvQuest.Selected.Caption));
  end;
end;

procedure TMainForm.ChangeNamesOfComponents;
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if (Components[i] is TLabeledEdit) then
    begin
      if pos('edco', TLabeledEdit(Components[i]).EditLabel.Caption) = 1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := MidStr(Components[i].Name, 5, length(Components[i].Name) - 4);
      if pos('edce', TLabeledEdit(Components[i]).EditLabel.Caption) = 1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := MidStr(Components[i].Name, 5, length(Components[i].Name) - 4);
      if pos('edci', TLabeledEdit(Components[i]).EditLabel.Caption) = 1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := MidStr(Components[i].Name, 5, length(Components[i].Name) - 4);
      if pos('edcm', TLabeledEdit(Components[i]).EditLabel.Caption) = 1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := MidStr(Components[i].Name, 5, length(Components[i].Name) - 4);
      if pos('edit', TLabeledEdit(Components[i]).EditLabel.Caption) = 1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := MidStr(Components[i].Name, 5, length(Components[i].Name) - 4);
      if pos('edid', TLabeledEdit(Components[i]).EditLabel.Caption) = 1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := MidStr(Components[i].Name, 5, length(Components[i].Name) - 4);
      if pos('edip', TLabeledEdit(Components[i]).EditLabel.Caption) = 1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := MidStr(Components[i].Name, 5, length(Components[i].Name) - 4);
      if pos('edie', TLabeledEdit(Components[i]).EditLabel.Caption) = 1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := MidStr(Components[i].Name, 5, length(Components[i].Name) - 4);
      if pos('edil', TLabeledEdit(Components[i]).EditLabel.Caption) = 1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := MidStr(Components[i].Name, 5, length(Components[i].Name) - 4);
      if pos('edcp', TLabeledEdit(Components[i]).EditLabel.Caption) = 1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := MidStr(Components[i].Name, 5, length(Components[i].Name) - 4);
      if pos('edcs', TLabeledEdit(Components[i]).EditLabel.Caption) = 1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := MidStr(Components[i].Name, 5, length(Components[i].Name) - 4);
      if pos('edct', TLabeledEdit(Components[i]).EditLabel.Caption) = 1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := MidStr(Components[i].Name, 5, length(Components[i].Name) - 4);
      if pos('edcl', TLabeledEdit(Components[i]).EditLabel.Caption) = 1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := MidStr(Components[i].Name, 5, length(Components[i].Name) - 4);
      if pos('edgo', TLabeledEdit(Components[i]).EditLabel.Caption) = 1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := MidStr(Components[i].Name, 5, length(Components[i].Name) - 4);
      if pos('edgt', TLabeledEdit(Components[i]).EditLabel.Caption) = 1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := MidStr(Components[i].Name, 5, length(Components[i].Name) - 4);
      if pos('edgl', TLabeledEdit(Components[i]).EditLabel.Caption) = 1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := MidStr(Components[i].Name, 5, length(Components[i].Name) - 4);
      if pos('edqt', TLabeledEdit(Components[i]).EditLabel.Caption) = 1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := MidStr(Components[i].Name, 5, length(Components[i].Name) - 4);
      if pos('edht', TLabeledEdit(Components[i]).EditLabel.Caption) = 1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := MidStr(Components[i].Name, 5, length(Components[i].Name) - 4);
    end;
  end;
end;

function TMainForm.IsNumber(S: string): Boolean;
var
  f: double;
begin
  Result := TryStrToFloat(S, f);
end;

procedure TMainForm.tsScriptTabShow(Sender: TObject);
begin
  CompleteScript;
end;

procedure TMainForm.UpdateCaption;
begin
  Caption := Format('Quice - Connection: %s:%d / %s', [MyMangosConnection.HostName, MyMangosConnection.Port,
    GetDBVersion]);
  Application.Title := Caption;
end;

procedure TMainForm.WMFreeQL(var Message: TMessage);
begin
  if Assigned(lvQuickList) then
  begin
    lvQuickList.OnKeyDown := nil;
    lvQuickList.OnMouseMove := nil;
    lvQuickList.OnMouseLeave := nil;
    lvQuickList.OnClick := nil;
    lvQuickList.Free;
    lvQuickList := nil;
  end;
end;

function TMainForm.DBScriptsOnSQLScript(lvList: TJvListView; tn: string; id: string): string;
var
  i: Integer;
begin
  Result := '';
  if (StrToIntDef(id, 0) < 1) then
    Exit;
  if lvList.Items.Count > 0 then
  begin
    for i := 0 to lvList.Items.Count - 2 do
    begin
      Result := Result + Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s),'#13#10,
        [lvList.Items[i].Caption, lvList.Items[i].SubItems[0], lvList.Items[i].SubItems[1], lvList.Items[i].SubItems[2],
        lvList.Items[i].SubItems[3], lvList.Items[i].SubItems[4], lvList.Items[i].SubItems[5],
        lvList.Items[i].SubItems[6], lvList.Items[i].SubItems[7], lvList.Items[i].SubItems[8],
        lvList.Items[i].SubItems[9], lvList.Items[i].SubItems[10], lvList.Items[i].SubItems[11],
        lvList.Items[i].SubItems[12], lvList.Items[i].SubItems[13], lvList.Items[i].SubItems[14],
        lvList.Items[i].SubItems[15], QuotedStr(lvList.Items[i].SubItems[16])]);
    end;
    i := lvList.Items.Count - 1;
    Result := Result + Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s),'#13#10,
      [lvList.Items[i].Caption, lvList.Items[i].SubItems[0], lvList.Items[i].SubItems[1], lvList.Items[i].SubItems[2],
      lvList.Items[i].SubItems[3], lvList.Items[i].SubItems[4], lvList.Items[i].SubItems[5],
      lvList.Items[i].SubItems[6], lvList.Items[i].SubItems[7], lvList.Items[i].SubItems[8],
      lvList.Items[i].SubItems[9], lvList.Items[i].SubItems[10], lvList.Items[i].SubItems[11],
      lvList.Items[i].SubItems[12], lvList.Items[i].SubItems[13], lvList.Items[i].SubItems[14],
      lvList.Items[i].SubItems[15], QuotedStr(lvList.Items[i].SubItems[16])]);
  end;
  if Result <> '' then
  begin
    Result := Format('DELETE FROM `%0:s` WHERE `id`=%1:s;'#13#10 +
      'INSERT INTO `%0:s` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, ' +
      '`buddy_entry`, `search_radius`, `data_flags`,`dataint`,`dataint2`,`dataint3`,`dataint4`, `x`, `y`, `z`, `o`,`comments`) VALUES '#13#10'%2:s'#13#10,
      [tn, id, Result]);
  end
  else
    Result := Format('DELETE FROM `%s` WHERE `id`=%s;'#13#10, [tn, id]);
end;

function TMainForm.FullMvmntScript(lvList: TJvListView; tn: string; id: string): string;
var
  i: Integer;
begin
  Result := '';
  if lvList.Items.Count > 0 then
  begin
    for i := 0 to lvList.Items.Count - 2 do
    begin
      Result := Result + Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s),'#13#10,
        [lvList.Items[i].Caption, lvList.Items[i].SubItems[0], lvList.Items[i].SubItems[1], lvList.Items[i].SubItems[2],
        lvList.Items[i].SubItems[3], lvList.Items[i].SubItems[4], lvList.Items[i].SubItems[5],
        lvList.Items[i].SubItems[6], QuotedStr(lvList.Items[i].SubItems[7])]);
    end;
    i := lvList.Items.Count - 1;
    Result := Result + Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s),'#13#10,
      [lvList.Items[i].Caption, lvList.Items[i].SubItems[0], lvList.Items[i].SubItems[1], lvList.Items[i].SubItems[2],
      lvList.Items[i].SubItems[3], lvList.Items[i].SubItems[4], lvList.Items[i].SubItems[5],
      lvList.Items[i].SubItems[6], QuotedStr(lvList.Items[i].SubItems[7])]);
  end;
  if Result <> '' then
  begin
    Result := Format('DELETE FROM `%0:s` WHERE `id`=%1:s;'#13#10 +
      'INSERT INTO `%0:s` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, ' +
      '`waittime`, `script_id`, `comment`) VALUES '#13#10'%2:s'#13#10,
      [tn, id, Result]);
  end
  else
    Result := Format('DELETE FROM `%s` WHERE `id`=%s;', [tn, id]);
end;

function TMainForm.FullMvmntTmplScript(lvList: TJvListView; tn: string; id: string): string;
var
  i: Integer;
begin
  Result := '';
  if lvList.Items.Count > 0 then
  begin
    for i := 0 to lvList.Items.Count - 2 do
    begin
      Result := Result + Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s),'#13#10,
        [lvList.Items[i].Caption, lvList.Items[i].SubItems[0], lvList.Items[i].SubItems[1], lvList.Items[i].SubItems[2],
        lvList.Items[i].SubItems[3], lvList.Items[i].SubItems[4], lvList.Items[i].SubItems[5],
        lvList.Items[i].SubItems[6], lvList.Items[i].SubItems[7], QuotedStr(lvList.Items[i].SubItems[8])]);
    end;
    i := lvList.Items.Count - 1;
    Result := Result + Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s),'#13#10,
      [lvList.Items[i].Caption, lvList.Items[i].SubItems[0], lvList.Items[i].SubItems[1], lvList.Items[i].SubItems[2],
      lvList.Items[i].SubItems[3], lvList.Items[i].SubItems[4], lvList.Items[i].SubItems[5],
      lvList.Items[i].SubItems[6], lvList.Items[i].SubItems[7], QuotedStr(lvList.Items[i].SubItems[8])]);
  end;
  if Result <> '' then
  begin
    Result := Format('DELETE FROM `%0:s` WHERE `entry`=%1:s;'#13#10 +
      'INSERT INTO `%0:s` (`entry`, `pathId`, `point`, `position_x`, `position_y`, `position_z`, ' +
      '`orientation`, `waittime`, `script_id`,`comment`) VALUES '#13#10'%2:s'#13#10,
      [tn, id, Result]);
  end
  else
    Result := Format('DELETE FROM `%s` WHERE `entry`=%s;', [tn, id]);
end;

function TMainForm.RandomTemplatesSQLScript(lvList: TJvListView; tn: string; id: string): string;
var
  i: Integer;
begin
  Result := '';
  if lvList.Items.Count > 0 then
  begin
    for i := 0 to lvList.Items.Count - 2 do
    begin
      Result := Result + Format('(%s, %s, %s, %s, %s),'#13#10,
        [lvList.Items[i].Caption, lvList.Items[i].SubItems[0], lvList.Items[i].SubItems[1], lvList.Items[i].SubItems[2], QuotedStr(lvList.Items[i].SubItems[3])]);
    end;
    i := lvList.Items.Count - 1;
    Result := Result + Format('(%s, %s, %s, %s, %s),'#13#10,
        [lvList.Items[i].Caption, lvList.Items[i].SubItems[0], lvList.Items[i].SubItems[1], lvList.Items[i].SubItems[2], QuotedStr(lvList.Items[i].SubItems[3])]);
  end;
  if Result <> '' then
  begin
    Result := Format('DELETE FROM `%0:s` WHERE `id`=%1:s;'#13#10 +
      'INSERT INTO `%0:s` (`id`,`type`,`target_id`,`chance`,`comments`) VALUES '#13#10'%2:s'#13#10,
      [tn, id, Result]);
  end
  else
    Result := Format('DELETE FROM `%s` WHERE `id`=%s;', [tn, id]);
end;

procedure TMainForm.CompleteScript;
var
  s1, s2, s3, s4, s5, s6, script, quest, Fields, Values: string;
  who, id: string;
  i: Integer;
begin
  s4 := '';
  quest := edqtEntry.Text;
  if quest = '' then
    Exit;
  meqtLog.Clear;

  s1 := Format('DELETE FROM `creature_questrelation` WHERE `quest` = %0:s;'#13#10 +
    'DELETE FROM `gameobject_questrelation` WHERE `quest` = %0:s;'#13#10 +
    'UPDATE `item_template` SET `startquest`=0 WHERE `startquest` = %0:s;'#13#10, [quest]);
  s2 := Format('DELETE FROM `creature_involvedrelation` WHERE `quest` = %0:s;'#13#10 +
    'DELETE FROM `gameobject_involvedrelation` WHERE `quest` = %0:s;'#13#10, [quest]);

  if lvqtGiverTemplate.Items.Count = 0 then
    meqtLog.Lines.Add(dmMain.Text[4]) // 'Error: QuestGiver is not set'
  else
    for i := 0 to lvqtGiverTemplate.Items.Count - 1 do
    begin
      who := lvqtGiverTemplate.Items[i].Caption;
      id := lvqtGiverTemplate.Items[i].SubItems[0];

      if who = 'creature' then
        s1 := Format('%0:sINSERT INTO `creature_questrelation` (`id`, `quest`) VALUES (%1:s, %2:s);'#13#10 +
          'UPDATE `creature_template` SET `NpcFlags`=`NpcFlags`|2 WHERE `entry` = %1:s;'#13#10, [s1, id, quest])
      else if who = 'gameobject' then
        s1 := Format('%0:sINSERT INTO `gameobject_questrelation` (`id`, `quest`) VALUES (%1:s, %2:s);'#13#10,
          [s1, id, quest])
      else if who = 'item' then
        s1 := Format('%sUPDATE `item_template` SET `startquest`=%s WHERE `entry` = %s;'#13#10, [s1, quest, id])
    end;

  if lvqtTakerTemplate.Items.Count = 0 then
    meqtLog.Lines.Add(dmMain.Text[6]) // 'Error: QuestTaker is not set'
  else
    for i := 0 to lvqtTakerTemplate.Items.Count - 1 do
    begin
      who := lvqtTakerTemplate.Items[i].Caption;
      id := lvqtTakerTemplate.Items[i].SubItems[0];

      if who = 'creature' then
        s2 := Format('%0:sINSERT INTO `creature_involvedrelation` (`id`, `quest`) VALUES (%1:s, %2:s);'#13#10 +
          'UPDATE `creature_template` SET `NpcFlags`=`NpcFlags`|2 WHERE `entry` = %1:s;'#13#10, [s2, id, quest])
      else if who = 'gameobject' then
        s2 := Format('%0:sINSERT INTO `gameobject_involvedrelation` (`id`, `quest`) VALUES (%1:s, %2:s);'#13#10,
          [s2, id, quest])
    end;

  s5 := DBScriptsOnSQLScript(lvssStartScript, SCRIPT_TABLE_QUEST_START, edqtStartScript.Text);
  s6 := DBScriptsOnSQLScript(lvesEndScript, SCRIPT_TABLE_QUEST_END, edqtCompleteScript.Text);

  SetFieldsAndValues(Fields, Values, 'quest_template', PFX_QUEST_TEMPLATE, meqtLog);

  case SyntaxStyle of
    ssInsertDelete:
      s3 := Format('DELETE FROM `quest_template` WHERE `entry` = %s;'#13#10 +
        'INSERT INTO `quest_template` (%s) VALUES (%s);'#13#10, [quest, Fields, Values]);
    ssReplace:
      s3 := Format('REPLACE INTO `quest_template` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      s3 := MakeUpdate('quest_template', PFX_QUEST_TEMPLATE, false, 'entry', quest);
  end;

  if edqtAreatrigger.Text <> '' then
    s4 := Format('DELETE FROM `areatrigger_involvedrelation` WHERE `quest` = %1:s;'#13#10 +
      'INSERT INTO `areatrigger_involvedrelation` (`id`, `quest`) VALUES (%0:s, %1:s);'#13#10,
      [edqtAreatrigger.Text, quest]);
  script := s1 + s2 + s5 + s6 + s3 + s4;
  meqtScript.Text := script;
end;

procedure TMainForm.btExecuteScriptCharClick(Sender: TObject);
begin
  if MessageDlg(dmMain.Text[9], mtConfirmation, mbYesNoCancel, -1) = mrYes then
    ExecuteScript(mehtScript.Text, mehtLog);
end;

procedure TMainForm.btExecuteScriptClick(Sender: TObject);
begin
  // 'Are you sure to execute this script?'
  if MessageDlg(dmMain.Text[9], mtConfirmation, mbYesNoCancel, -1) = mrYes then
    ExecuteScript(meqtScript.Text, meqtLog);
end;

procedure TMainForm.btCopyToClipboardCharClick(Sender: TObject);
begin
  mehtScript.SelectAll;
  mehtScript.CopyToClipboard;
  mehtScript.SelStart := 0;
  mehtScript.SelLength := 0;
end;

procedure TMainForm.btCopyToClipboardClick(Sender: TObject);
begin
  meqtScript.SelectAll;
  meqtScript.CopyToClipboard;
  meqtScript.SelStart := 0;
  meqtScript.SelLength := 0;
end;

procedure TMainForm.btLoadQuest(Sender: TObject);
var
  KeyboardState: TKeyboardState;
  qid: Integer;
begin
  qid := abs(StrToIntDef(TJvComboEdit(Sender).Text, 0));
  if qid = 0 then
    Exit;
  GetKeyboardState(KeyboardState);
  if ssShift in KeyboardStateToShiftState(KeyboardState) then
    dmMain.BrowseSite(ttQuest, qid)
  else
    LoadQuest(qid);
end;

procedure TMainForm.btlqShowFullLocalesScriptClick(Sender: TObject);
begin
  PageControl2.ActivePageIndex := SCRIPT_TAB_NO_QUEST;
  meqtScript.Clear;
  // SetFieldsAndValues(MyQuery,Fields, Values, 'locales_quest', PFX_LOCALES_QUEST, meqtLog);
  // meqtScript.Lines.Add(MakeUpdate('locales_quest', PFX_LOCALES_QUEST, true, 'entry', edqtEntry.Text));
  CompleteLocalesQuest;
end;

procedure TMainForm.btFullScriptMailLootClick(Sender: TObject);
begin
  PageControl2.ActivePageIndex := SCRIPT_TAB_NO_QUEST;
  meqtScript.Clear;
  CompleteMailLootScript;
  ShowFullLootScript('mail_loot_template', lvmlMailLoot, meqtScript, edqtRewMailTemplateId.Text);
end;

procedure TMainForm.btGreetingScriptClick(Sender: TObject);
begin
  PageControl2.ActivePageIndex := SCRIPT_TAB_NO_QUEST;
  meqtScript.Clear;
  CompleteGreetingScript;
end;

procedure TMainForm.btMillingLootAddClick(Sender: TObject);
begin
  LootAdd('edim', lvitMillingLoot);
end;

procedure TMainForm.btMillingLootDelClick(Sender: TObject);
begin
  LootDel(lvitMillingLoot);
end;

procedure TMainForm.btMillingLootUpdClick(Sender: TObject);
begin
  LootUpd('edim', lvitMillingLoot);
end;

procedure TMainForm.GetItem(Sender: TObject);
var
  edEdit: TJvComboEdit;
  f: TItemForm;
begin
  if Sender is TJvComboEdit then
  begin
    edEdit := TJvComboEdit(Sender);
    f := TItemForm.Create(Self);
    try
      if (edEdit.Text <> '') and (edEdit.Text <> '0') then
        f.Prepare(edEdit.Text);
      if f.ShowModal = mrOk then
        edEdit.Text := f.lvItem.Selected.Caption;
    finally
      f.Free;
    end;
  end;
end;

procedure TMainForm.GetCurrency(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 16, 'CurrencyTypes', true);
end;

procedure TMainForm.GetCreatureOrGO(Sender: TObject);
var
  edEdit: TJvComboEdit;
  f: TCreatureOrGOForm;
begin
  if Sender is TJvComboEdit then
  begin
    edEdit := TJvComboEdit(Sender);
    f := TCreatureOrGOForm.Create(Self);
    try
      if (edEdit.Text <> '') and (edEdit.Text <> '0') then
        f.Prepare(edEdit.Text);
      if f.ShowModal = mrOk then
        edEdit.Text := f.lvCreatureOrGO.Selected.Caption;
    finally
      f.Free;
    end;
  end;
end;

procedure TMainForm.GetSpecialFlags(Sender: TObject);
begin
  GetSomeFlags(Sender, 'SpecialFlags');
end;

procedure TMainForm.edqtZoneOrSortButtonClick(Sender: TObject);
begin
  if rbqtZoneID.Checked then
    GetArea(Sender)
  else
    GetValueFromSimpleList(Sender, 11, 'QuestSort', false);
end;

procedure TMainForm.btTypeClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 13, 'QuestInfo', false);
end;

procedure TMainForm.GetFaction(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 14, 'Faction', true);
end;

procedure TMainForm.GetEmote(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 147, 'Emotes', false);
end;

procedure TMainForm.GetFactionTemplate(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 15, 'FactionTemplate', true);
end;

procedure TMainForm.GetGuid(Sender: TObject; otype: string);
var
  edEdit: TJvComboEdit;
  f: TGUIDForm;
begin
  if Sender is TJvComboEdit then
  begin
    edEdit := TJvComboEdit(Sender);
    f := TGUIDForm.CreateEx(Self, otype);
    try
      if (edEdit.Text <> '') and (edEdit.Text <> '0') then
        f.Prepare(edEdit.Text);
      if f.ShowModal = mrOk then
        edEdit.Text := f.GUID;
    finally
      f.Free;
    end;
  end;
end;

procedure TMainForm.GetSkill(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 16, 'SkillLine', true);
end;

procedure TMainForm.GetSpell(Sender: TObject);
begin
  if not(Sender is TJvComboEdit) then
    Exit;
  SpellsForm.Prepare(TJvComboEdit(Sender).Text);
  if SpellsForm.ShowModal = mrOk then
    TJvComboEdit(Sender).Text := SpellsForm.lvList.Selected.Caption;
end;

procedure TMainForm.GetRaces(Sender: TObject);
begin
  GetSomeFlags(Sender, 'Races');
end;

procedure TMainForm.GetClasses(Sender: TObject);
begin
  GetSomeFlags(Sender, 'Classes');
end;

procedure TMainForm.GetQuestFlags(Sender: TObject);
begin
  GetSomeFlags(Sender, 'QuestFlags');
end;

procedure TMainForm.LoadQuestGiverInfo(objtype: string; entry: string);
var
  SQLText: string;
begin
  if objtype = 'creature' then
  begin
    SQLText :=
      Format('SELECT `guid`, `id`, `map`, `position_x`,`position_y`,`position_z`,`orientation`,''creature'' as `table` FROM `creature` WHERE (`id`=%s)',
      [entry]);
    lbLocationOrLoot.Caption := dmMain.Text[17]; // 'Creature location'
  end
  else if objtype = 'gameobject' then
  begin
    SQLText :=
      Format('SELECT `guid`, `id`, `map`, `position_x`,`position_y`,`position_z`,`orientation`,''gameobject'' as `table` FROM `gameobject` WHERE (`id`=%s)',
      [entry]);
    lbLocationOrLoot.Caption := dmMain.Text[18]; // 'Gameobject location'
  end
  else if objtype = 'item' then
  begin
    SQLText := '';
    lbLocationOrLoot.Caption := dmMain.Text[19]; // 'Item Loot'
  end
  else
  begin
    lvqtGiverLocation.Clear;
    Exit;
  end;

  lvqtGiverLocation.Items.Clear();
  if SQLText = '' then
    LoadLoot(lvqtGiverLocation, entry)
  else
    LoadQueryToListView(SQLText, lvqtGiverLocation);
end;

procedure TMainForm.LoadQuestMailLoot(edqtRewMailTemplateId: Integer);
begin
  MyQuery.SQL.Text := Format('SELECT ml.* FROM `mail_loot_template` ml ' +
    'INNER JOIN `item_template` t ON t.entry = ml.item ' + 'WHERE ml.entry = %d', [edqtRewMailTemplateId]);
  MyQuery.Open;
  lvmlMailLoot.Items.Clear;
  while not MyQuery.Eof do
  begin
    with lvmlMailLoot.Items.Add do
    begin
      lvmlMailLoot.Columns[0].Caption := 'entry';
      Caption := MyQuery.Fields[0].AsString;
      lvmlMailLoot.Columns[1].Caption := 'item';
      SubItems.Add(MyQuery.Fields[1].AsString);
      lvmlMailLoot.Columns[2].Caption := 'ChanceOrQuestChance';
      SubItems.Add(MyQuery.Fields[2].AsString);
      lvmlMailLoot.Columns[3].Caption := 'groupid';
      SubItems.Add(MyQuery.Fields[3].AsString);
      lvmlMailLoot.Columns[4].Caption := 'mincountOrRef';
      SubItems.Add(MyQuery.Fields[4].AsString);
      lvmlMailLoot.Columns[5].Caption := 'maxcount';
      SubItems.Add(MyQuery.Fields[5].AsString);
      lvmlMailLoot.Columns[6].Caption := 'condition_id';
      SubItems.Add(MyQuery.Fields[6].AsString);
      lvmlMailLoot.Columns[7].Caption := 'comments';
      SubItems.Add(MyQuery.Fields[7].AsString);
    end;
    MyQuery.Next;
  end;
  MyQuery.Close;
end;

procedure TMainForm.LoadQuestLocales(QuestID: Integer);
var
  loc: string;
begin
  loc := LoadLocales();
  MyQuery.SQL.Text := Format('SELECT Title%0:s, Details%0:s, Objectives%0:s, OfferRewardText%0:s,' +
    'RequestItemsText%0:s, EndText%0:s, CompletedText%0:s,' +
    'ObjectiveText1%0:s, ObjectiveText2%0:s, ObjectiveText3%0:s, ObjectiveText4%0:s ' +
   'FROM locales_quest WHERE entry=%1:d LIMIT 1', [loc, QuestID]);
  MyQuery.Open;
  edlqTitle.EditLabel.Caption := 'Title' + loc;
  l2Details.Caption := 'Details' + loc;
  l2Objectives.Caption := 'Objectives' + loc;
  l2EndText.Caption := 'EndText' + loc;
  edlqCompletedText.EditLabel.Caption := 'CompletedText' + loc;
  l2OfferRewardText.Caption := 'OfferRewardText' + loc;
  l2RequestItemsText.Caption := 'RequestItemsText' + loc;
  edlqObjectiveText1.EditLabel.Caption := 'ObjectiveText1' + loc;
  edlqObjectiveText2.EditLabel.Caption := 'ObjectiveText2' + loc;
  edlqObjectiveText3.EditLabel.Caption := 'ObjectiveText3' + loc;
  edlqObjectiveText4.EditLabel.Caption := 'ObjectiveText4' + loc;

  if not MyQuery.Eof then
  begin
    edlqTitle.Text := MyQuery.Fields[0].AsString;
    edlqDetails.Text := MyQuery.Fields[1].AsString;
    edlqObjectives.Text := MyQuery.Fields[2].AsString;
    edlqOfferRewardText.Text := MyQuery.Fields[3].AsString;
    edlqRequestItemsText.Text := MyQuery.Fields[4].AsString;
    edlqEndText.Text := MyQuery.Fields[5].AsString;
    edlqCompletedText.Text := MyQuery.Fields[6].AsString;
    edlqObjectiveText1.Text := MyQuery.Fields[7].AsString;
    edlqObjectiveText2.Text := MyQuery.Fields[8].AsString;
    edlqObjectiveText3.Text := MyQuery.Fields[9].AsString;
    edlqObjectiveText4.Text := MyQuery.Fields[10].AsString;
    MyQuery.Next;
  end;
  MyQuery.Close;
end;

procedure TMainForm.LoadQuestGivers(QuestID: Integer);
begin
  // search for quest starter
  MyQuery.SQL.Text := Format('SELECT t.Entry, t.Name, t.NpcFlags FROM `creature_questrelation` q ' +
    'INNER JOIN `creature_template` t ON t.Entry = q.id ' + 'WHERE q.quest = %d', [QuestID]);
  MyQuery.Open;
  while not MyQuery.Eof do
  begin
    with lvqtGiverTemplate.Items.Add do
    begin
      Caption := 'creature';
      lvqtGiverTemplate.Columns[1].Caption := 'Entry';
      SubItems.Add(MyQuery.Fields[0].AsString);
      lvqtGiverTemplate.Columns[2].Caption := 'Name';
      SubItems.Add(MyQuery.Fields[1].AsString);
      lvqtGiverTemplate.Columns[3].Caption := 'NpcFlags';
      SubItems.Add(MyQuery.Fields[2].AsString);
    end;
    MyQuery.Next;
  end;
  MyQuery.Close;

  MyQuery.SQL.Text := Format('SELECT t.entry, t.name, t.`type` FROM `gameobject_questrelation` q ' +
    'INNER JOIN `gameobject_template` t ON t.entry = q.id ' + 'WHERE q.quest = %d', [QuestID]);
  MyQuery.Open;
  while not MyQuery.Eof do
  begin
    with lvqtGiverTemplate.Items.Add do
    begin
      Caption := 'gameobject';
      lvqtGiverTemplate.Columns[1].Caption := 'entry';
      SubItems.Add(MyQuery.Fields[0].AsString);
      lvqtGiverTemplate.Columns[2].Caption := 'name';
      SubItems.Add(MyQuery.Fields[1].AsString);
      lvqtGiverTemplate.Columns[3].Caption := 'GO type';
      SubItems.Add(MyQuery.Fields[2].AsString);
    end;
    MyQuery.Next;
  end;
  MyQuery.Close;

  MyQuery.SQL.Text := Format('SELECT entry, name, description FROM `item_template` ' + 'WHERE startquest = %d',
    [QuestID]);
  MyQuery.Open;
  while not MyQuery.Eof do
  begin
    with lvqtGiverTemplate.Items.Add do
    begin
      Caption := 'item';
      lvqtGiverTemplate.Columns[1].Caption := 'entry';
      SubItems.Add(MyQuery.Fields[0].AsString);
      lvqtGiverTemplate.Columns[2].Caption := 'name';
      SubItems.Add(MyQuery.Fields[1].AsString);
      lvqtGiverTemplate.Columns[3].Caption := 'description';
      SubItems.Add(MyQuery.Fields[2].AsString);
    end;
    MyQuery.Next;
  end;
  MyQuery.Close;

end;

procedure TMainForm.LoadQuestTakerInfo(objtype: string; entry: string);
var
  SQLText: string;
begin
  if objtype = 'creature' then
  begin
    SQLText :=
      Format('SELECT `guid`, `id`, `map`, `position_x`,`position_y`,`position_z`,`orientation`,''creature'' as `table` FROM `creature` WHERE (`id`=%s)',
      [entry]);
    lbQuestTakerLocation.Caption := dmMain.Text[17]; // 'Creature location'
  end
  else if objtype = 'gameobject' then
  begin
    SQLText :=
      Format('SELECT `guid`, `id`, `map`, `position_x`,`position_y`,`position_z`,`orientation`,''gameobject'' as `table` FROM `gameobject` WHERE (`id`=%s)',
      [entry]);
    lbQuestTakerLocation.Caption := dmMain.Text[18]; // 'Gameobject location'
  end
  else
  begin
    lvqtTakerLocation.Clear;
    Exit;
  end;
  LoadQueryToListView(SQLText, lvqtTakerLocation);
end;

procedure TMainForm.LoadQuestTakers(QuestID: Integer);
begin
  // search for quest starter
  MyQuery.SQL.Text := Format('SELECT t.Entry, t.Name, t.NpcFlags FROM `creature_involvedrelation` q ' +
    'INNER JOIN `creature_template` t ON t.Entry = q.id ' + 'WHERE q.quest = %d', [QuestID]);
  MyQuery.Open;
  while not MyQuery.Eof do
  begin
    with lvqtTakerTemplate.Items.Add do
    begin
      Caption := 'creature';
      lvqtTakerTemplate.Columns[1].Caption := 'Entry';
      SubItems.Add(MyQuery.Fields[0].AsString);
      lvqtTakerTemplate.Columns[2].Caption := 'Name';
      SubItems.Add(MyQuery.Fields[1].AsString);
      lvqtTakerTemplate.Columns[3].Caption := 'NpcFlags';
      SubItems.Add(MyQuery.Fields[2].AsString);
    end;
    MyQuery.Next;
  end;
  MyQuery.Close;

  MyQuery.SQL.Text := Format('SELECT t.entry, t.name, t.`type` FROM `gameobject_involvedrelation` q ' +
    'INNER JOIN `gameobject_template` t ON t.entry = q.id ' + 'WHERE q.quest = %d', [QuestID]);
  MyQuery.Open;
  while not MyQuery.Eof do
  begin
    with lvqtTakerTemplate.Items.Add do
    begin
      Caption := 'gameobject';
      lvqtTakerTemplate.Columns[1].Caption := 'entry';
      SubItems.Add(MyQuery.Fields[0].AsString);
      lvqtTakerTemplate.Columns[2].Caption := 'name';
      SubItems.Add(MyQuery.Fields[1].AsString);
      lvqtTakerTemplate.Columns[3].Caption := 'GO type';
      SubItems.Add(MyQuery.Fields[2].AsString);
    end;
    MyQuery.Next;
  end;
  MyQuery.Close;
end;

procedure TMainForm.btAreatriggerClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 155, 'AreaTrigger', false);
end;

procedure TMainForm.lvQuestChange(Sender: TObject; Item: TListItem; Change: TItemChange);
var
  flag: Boolean;
begin
  flag := Assigned(lvQuest.Selected);
  if flag then
    lvQuest.PopupMenu := pmQuest
  else
    lvQuest.PopupMenu := nil;
  btEditQuest.Enabled := flag;
  btDeleteQuest.Enabled := flag;
  btCheckQuest.Enabled := flag;
  btBrowseSite.Enabled := flag;
  btBrowseQuestPopup.Enabled := flag;
  btCheckAll.Enabled := flag;
end;

procedure TMainForm.nEditCreatureAIClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := 16;
  if Assigned(lvSearchCreature.Selected) then
    LoadCreature(StrToInt(lvSearchCreature.Selected.Caption));
end;

procedure TMainForm.nExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.NPCTextLoc1btnpctextClick(Sender: TObject);
begin
  NPCTextLoc1.btNPCTextClick(Sender);
end;

procedure TMainForm.nAboutClick(Sender: TObject);
var
  f: TAboutBox;
begin
  f := TAboutBox.MyCreate(Self);
  try
    f.dbversion := GetDBVersion;
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure TMainForm.btNewQuestClick(Sender: TObject);
begin
  lvQuest.Selected := nil;
  ClearFields(ttQuest);
  SetDefaultFields(ttQuest);
  PageControl2.ActivePageIndex := 1;
end;

procedure TMainForm.btEditQuestClick(Sender: TObject);
begin
  PageControl2.ActivePageIndex := 1;
  if Assigned(lvQuest.Selected) then
    LoadQuest(StrToInt(lvQuest.Selected.Caption));
end;

procedure TMainForm.btCheckQuestClick(Sender: TObject);
var
  id: Integer;
  qList: TList;
begin
  CheckForm.memo.Clear;
  CheckForm.btStop.Visible := true;
  if not Assigned(lvQuest.Selected) then
  begin
    ShowMessage(dmMain.Text[20]); // 'Nothing to check.'
    Exit;
  end;
  qList := TList.Create;
  id := StrToIntDef(lvQuest.Selected.Caption, 0);
  qList.Add(pointer(id));
  CheckForm.Show;
  CheckForm.pbCheckQuest.Position := 0;
  CheckForm.btStop.SetFocus;
  Thread := TCheckQuestThread.Create(MyMangosConnection, qList, false);
end;

procedure TMainForm.btCheckAllClick(Sender: TObject);
var
  i: Integer;
  qList: TList;
begin
  CheckForm.memo.Clear;
  CheckForm.btStop.Visible := true;
  if lvQuest.Items.Count = 0 then
  begin
    ShowMessage(dmMain.Text[21]); // 'List of found quests is empty. Nothing to check.'
    Exit;
  end;
  qList := TList.Create;
  for i := 0 to lvQuest.Items.Count - 1 do
    qList.Add(pointer(StrToInt(lvQuest.Items[i].Caption)));

  CheckForm.Show;
  CheckForm.pbCheckQuest.Position := 0;
  CheckForm.btStop.SetFocus;

  Thread := TCheckQuestThread.Create(MyMangosConnection, qList, false);
end;

procedure TMainForm.ClearFields(Where: TType);
var
  i: Integer;
  S: string;
begin
  S := '';
  case Where of
    ttQuest:
      S := 'q';
    ttNPC:
      S := 'c';
    ttObject:
      S := 'g';
    ttItem:
      S := 'i';
    ttChar:
      S := 'h';
  end;
  for i := 0 to ComponentCount - 1 do
  begin
    if S <> '' then
    begin
      if ((Components[i] is TLabeledEdit) or (Components[i] is TJvComboEdit) or (Components[i] is TMemo)) and
        ((pos('ed' + S + 't', Components[i].Name) = 1) or (pos('ed' + S + 'l', Components[i].Name) = 1) or
        (pos('ed' + S + 'o', Components[i].Name) = 1) or (pos('me' + S + 't', Components[i].Name) = 1) or
        (pos('me' + S + 'l', Components[i].Name) = 1) or (pos('me' + S + 'o', Components[i].Name) = 1)) then
        TCustomEdit(Components[i]).Clear;
      if (Components[i] is TJvListView) and ((pos('lv' + S + 'o', Components[i].Name) = 1) or
        (pos('lv' + S + 'l', Components[i].Name) = 1) or (pos('lv' + S + 't', Components[i].Name) = 1)) then
        TCustomListView(Components[i]).Clear;
    end;
    // additionaly crear npcvendor and npctrainer fields
    if S = 'c' then
    begin
      if ((Components[i] is TLabeledEdit) or (Components[i] is TJvComboEdit) or (Components[i] is TMemo)) and
        ((pos('ed' + S + 'v', Components[i].Name) = 1) or (pos('ed' + S + 'p', Components[i].Name) = 1) or
        (pos('ed' + S + 'a', Components[i].Name) = 1) or (pos('ed' + S + 'g', Components[i].Name) = 1) or
        (pos('ed' + S + 'x', Components[i].Name) = 1) or (pos('ed' + S + 'm', Components[i].Name) = 1) or
        (pos('ed' + S + 's', Components[i].Name) = 1) or (pos('ed' + S + 'r', Components[i].Name) = 1) or
        (pos('ed' + S + 'i', Components[i].Name) = 1) or (pos('ed' + S + 'e', Components[i].Name) = 1) or
        (pos('ed' + S + 'n', Components[i].Name) = 1)) then
        TCustomEdit(Components[i]).Clear;
      if (Components[i] is TJvListView) and ((pos('lv' + S + 'v', Components[i].Name) = 1) or
        (pos('lv' + S + 'r', Components[i].Name) = 1) or (pos('lv' + S + 'n', Components[i].Name) = 1) or
        (pos('lv' + S + 'm', Components[i].Name) = 1)) then
        TCustomListView(Components[i]).Clear;
    end;
    if S = 'i' then
    begin
      if ((Components[i] is TLabeledEdit) or (Components[i] is TJvComboEdit) or (Components[i] is TMemo)) and
        ((pos('ed' + S + 'l', Components[i].Name) = 1) or (pos('ed' + S + 'd', Components[i].Name) = 1) or
        (pos('ed' + S + 'p', Components[i].Name) = 1)) or (pos('ed' + S + 'e', Components[i].Name) = 1) then
        TCustomEdit(Components[i]).Clear;
      if (Components[i] is TJvListView) and ((pos('lv' + S + 'o', Components[i].Name) = 1) or
        (pos('lv' + S + 'l', Components[i].Name) = 1) or (pos('lv' + S + 't', Components[i].Name) = 1)) then
        TCustomListView(Components[i]).Clear;
    end;
    if S = 'h' then
    begin
      if ((Components[i] is TLabeledEdit) or (Components[i] is TJvComboEdit) or (Components[i] is TMemo)) and
        ((pos('ed' + S + 't', Components[i].Name) = 1) or (pos('ed' + S + 'd', Components[i].Name) = 1) or
        (pos('ed' + S + 'p', Components[i].Name) = 1)) or (pos('ed' + S + 'e', Components[i].Name) = 1) then
        TCustomEdit(Components[i]).Clear;
      if (Components[i] is TJvListView) and ((pos('lv' + S + 'o', Components[i].Name) = 1) or
        (pos('lv' + S + 'l', Components[i].Name) = 1) or (pos('lv' + S + 't', Components[i].Name) = 1)) then
        TCustomListView(Components[i]).Clear;
    end;
  end;
end;

procedure TMainForm.SetDefaultFields(Where: TType);
var
  i: Integer;
  S, tn: string;
  Ctrl: TComponent;
begin
  S := '';
  tn := '';
  case Where of
    ttQuest:
      begin
        S := 'edqt';
        tn := 'quest_template';
      end;

    ttNPC:
      begin
        S := 'edct';
        tn := 'creature_template';
      end;

    ttObject:
      begin
        S := 'edgt';
        tn := 'gameobject_template';
      end;

    ttItem:
      begin
        S := 'edit';
        tn := 'item_template';
      end;
  end;
  if tn <> '' then
  begin
    MyQuery.SQL.Text := 'replace into ' + tn + ' (entry) values (987654)';
    MyQuery.ExecSQL;
    try
      MyQuery.SQL.Text := 'select * from ' + tn + ' where entry = 987654';
      MyQuery.Open;
      for i := 0 to MyQuery.FieldCount - 1 do
      begin
        Ctrl := FindComponent(S + MyQuery.Fields[i].FieldName);
        if Assigned(Ctrl) and (Ctrl is TCustomEdit) then
          TCustomEdit(Ctrl).Text := MyQuery.Fields[i].AsString;
      end;
      MyQuery.Close;
    finally
      MyQuery.SQL.Text := 'delete from ' + tn + ' where entry = 987654';
      MyQuery.ExecSQL;
    end;
  end;
end;

procedure TMainForm.btQuestGiverSearchClick(Sender: TObject);
var
  f: TWhoQuestForm;
begin
  f := TWhoQuestForm.Create(Self);
  try
    if edQuestGiverSearch.Text <> '' then
      f.Prepare(edQuestGiverSearch.Text);
    if f.ShowModal = mrOk then
      edQuestGiverSearch.Text := Format('%s,%s', [f.rgTypeOfWho.Items[f.rgTypeOfWho.itemindex],
        f.lvWho.Selected.Caption]);
  finally
    f.Free;
  end;
end;

procedure TMainForm.btQuestTakerSearchClick(Sender: TObject);
var
  f: TWhoQuestForm;
begin
  f := TWhoQuestForm.Create(Self);
  try
    if edQuestTakerSearch.Text <> '' then
      f.Prepare(edQuestTakerSearch.Text);
    if f.ShowModal = mrOk then
    begin
      if f.rgTypeOfWho.itemindex = 2 then // item cannot be a quest taker now
        ShowMessage(dmMain.Text[1])
      else
        edQuestTakerSearch.Text := Format('%s,%s', [f.rgTypeOfWho.Items[f.rgTypeOfWho.itemindex],
          f.lvWho.Selected.Caption]);
    end;
  finally
    f.Free;
  end;
end;

procedure TMainForm.btReferenceLootAddClick(Sender: TObject);
begin
  LootAdd('edir', lvitReferenceLoot);
end;

procedure TMainForm.btReferenceLootDelClick(Sender: TObject);
begin
  LootDel(lvitReferenceLoot);
end;

procedure TMainForm.btReferenceLootUpdClick(Sender: TObject);
begin
  LootUpd('edir', lvitReferenceLoot);
end;

procedure TMainForm.btSpellLootAddClick(Sender: TObject);
begin
  LootAdd('edsl', lvslSpellLoot);
end;

procedure TMainForm.btSpellLootDelClick(Sender: TObject);
begin
  LootDel(lvslSpellLoot);
end;

procedure TMainForm.btSpellLootUpdClick(Sender: TObject);
begin
  LootUpd('edsl', lvslSpellLoot);
end;

procedure TMainForm.nSettingsClick(Sender: TObject);
begin
  ShowSettings(TMenuItem(Sender).Tag - 1);
  UpdateCaption;
end;

procedure TMainForm.ShowSettings(n: Integer);
var
  f: TSettingsForm;
  i: Integer;
begin
  f := TSettingsForm.Create(Self);
  try
    f.pcSettings.ActivePageIndex := n;
    if f.ShowModal = mrOk then
    begin
      lvQuest.Columns.Clear;
      for i := 0 to f.lvColumns.Items.Count - 1 do
      begin
        with lvQuest.Columns.Add do
        begin
          Caption := f.lvColumns.Items[i].Caption;
          Width := StrToInt(f.lvColumns.Items[i].SubItems[0]);
        end;
      end;
      lvQuest.Clear;
      SaveToReg;
      dmMain.Translate.LoadTranslations(dmMain.LanguageFile);
      dmMain.Translate.TranslateForm(TForm(Self));
    end;
  finally
    f.Free;
  end;
end;

procedure TMainForm.SpeedButtonClick(Sender: TObject);
var
  p: TPoint;
begin
  p := TSpeedButton(Sender).ClientToScreen(Point(TSpeedButton(Sender).Width, 0));
  TSpeedButton(Sender).PopupMenu.Popup(p.X, p.Y);
end;

procedure TMainForm.SaveToReg;
var
  i: Integer;
begin
  with TRegistry.Create do
    try
      RootKey := HKEY_CURRENT_USER;
      OpenKey('SOFTWARE\Indomit Software\Quice', true);
      WriteString('Language', dmMain.Language);
      WriteString('DBCDir', dmMain.DBCDir);
      WriteInteger('DBCLocale', dmMain.DBCLocale);
      WriteInteger('Locales', dmMain.Locales);
      case SyntaxStyle of
        ssInsertDelete:
          WriteInteger('SQLSyntaxStyle', 1);
        ssReplace:
          WriteInteger('SQLSyntaxStyle', 0);
        ssUpdate:
          WriteInteger('SQLSyntaxStyle', 2);
      end;

      OpenKey('QuestList', true);
      WriteInteger('ColumnCount', lvQuest.Columns.Count);
      for i := 0 to lvQuest.Columns.Count - 1 do
      begin
        WriteString(Format('N%d', [i]), lvQuest.Columns[i].Caption);
        WriteInteger(Format('W%d', [i]), lvQuest.Columns[i].Width);
      end;
      case dmMain.Site of
        sW:
          WriteInteger('Site', 0);
        sRW:
          WriteInteger('Site', 1);
        sT:
          WriteInteger('Site', 2);
        sA:
          WriteInteger('Site', 3);
      end;
    finally
      Free;
    end;
end;

procedure TMainForm.LoadFromReg;
var
  i, c: Integer;
begin
  with TRegistry.Create do
    try
      RootKey := HKEY_CURRENT_USER;
      if not OpenKey('SOFTWARE\Indomit Software\Quice', false) then
        Exit;
      try
        case ReadInteger('SQLSyntaxStyle') of
          0:
            SyntaxStyle := ssReplace;
          1:
            SyntaxStyle := ssInsertDelete;
          2:
            SyntaxStyle := ssUpdate;
        end;
      except
        SyntaxStyle := ssReplace;
      end;

      try
        dmMain.Locales := ReadInteger('Locales');
      except
        dmMain.Locales := 0;
        WriteInteger('Locales', dmMain.Locales);
      end;

      if not OpenKey('QuestList', false) then
        Exit;
      try
        c := ReadInteger('ColumnCount');
        lvQuest.Columns.Clear;
        for i := 0 to c - 1 do
        begin
          with lvQuest.Columns.Add do
          begin
            Caption := ReadString(Format('N%d', [i]));
            Width := ReadInteger(Format('W%d', [i]));
          end;
        end;
      except
      end;

      try
        c := ReadInteger('Site');
        case c of
          0:
            dmMain.Site := sW;
          1:
            dmMain.Site := sRW;
          2:
            dmMain.Site := sT;
          3:
            dmMain.Site := sA;
        end;
      except
        dmMain.Site := sW;
      end;
    finally
      Free;
    end;
end;

procedure TMainForm.SetCreatureModelEditFields(pfx: string; lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      TCustomEdit(FindComponent(pfx + 'modelid')).Text := Caption;
      TCustomEdit(FindComponent(pfx + 'bounding_radius')).Text := SubItems[0];
      TCustomEdit(FindComponent(pfx + 'combat_reach')).Text := SubItems[1];
      TCustomEdit(FindComponent(pfx + 'SpeedWalk')).Text := SubItems[2];
      TCustomEdit(FindComponent(pfx + 'SpeedRun')).Text := SubItems[3];
      TCustomEdit(FindComponent(pfx + 'gender')).Text := SubItems[4];
      TCustomEdit(FindComponent(pfx + 'modelid_other_gender')).Text := SubItems[5];
      TCustomEdit(FindComponent(pfx + 'modelid_alternative')).Text := SubItems[6];
    end;
  end;
end;

procedure TMainForm.SetDBSpellList;
var
  list: TStringList;
  i: Integer;
  UseSpellFileName: string;
begin
  ShowHourGlassCursor;
  UseSpellFileName := dmMain.ProgramDir + 'CSV\useSpells.csv';
  if FileExists(UseSpellFileName) then
  begin
    list := TStringList.Create;
    try
      list.LoadFromFile(UseSpellFileName);
      for i := 0 to list.Count - 1 do
        Spells.Add(pointer(StrToInt(list[i])));
    finally
      list.Free;
    end;
  end;
end;

function TMainForm.IsSpellInBase(id: Integer): Boolean;
var
  i: Integer;
begin
  Result := false;
  for i := 0 to Spells.Count - 1 do
  begin
    if Integer(Spells[i]) = id then
    begin
      Result := true;
      Exit;
    end;
  end;
end;

procedure TMainForm.edirentryButtonClick(Sender: TObject);
begin
  { ClearFields(ttItem);
    LoadQueryToListView(Format('SELECT rlt.*, i.`name` FROM `reference_loot_template`' +
    ' rlt LEFT OUTER JOIN `item_template` i ON i.`entry` = rlt.`item` WHERE (rlt.`entry`=%d)',
    [StrToIntDef(edirentry.Text, 0)]), lvitReferenceLoot);
  }
end;

procedure TMainForm.JvHttpUrlGrabberDoneStream(Sender: TObject; Stream: TStream; StreamSize: Integer; Url: string);
var
  list: TStringList;
  LastVer: Integer;
begin
  try
    list := TStringList.Create;
    try
      list.LoadFromStream(Stream);
{$IFDEF DEBUG}
      ShowMessage(list.Text);
{$ENDIF}
      if list.Count = 0 then
      begin
        if GlobalFlag then
          ShowMessage('Error: Updates not found.');
        IsFirst := false;
        Exit;
      end;

      LastVer := StrToIntDef(list[0], 0);

      if LastVer > CurVer() then
      begin
        if MessageDlg(Format(dmMain.Text[137], [CreateVer(LastVer)]), mtConfirmation, mbYesNoCancel, 0, mbYes)
          = mrYes then
        begin
          BrowseURL1.Url := 'http://quice.indomit.ru/?act=1';
          BrowseURL1.Execute;
        end;
      end
      else
      begin
        if GlobalFlag then
          ShowMessage(dmMain.Text[138]);
      end;
    finally
      list.Free;
    end;
  finally
    IsFirst := false;
  end;
end;

procedure TMainForm.JvHttpUrlGrabberError(Sender: TObject; ErrorMsg: string);
begin
  IsFirst := false;
  if GlobalFlag then
    ShowMessage(ErrorMsg);
end;

procedure TMainForm.nUninstallClick(Sender: TObject);
var
  S: string;
begin
  if MessageBox(Application.Handle, PChar(dmMain.Text[140]), 'Uninstall', MB_ICONQUESTION or MB_YESNOCANCEL) <>
    ID_YES then
    Exit;
  with TRegistry.Create do
    try
      RootKey := HKEY_CURRENT_USER;
      S := 'Software\' + SoftwareCompany + '\' + Trim(ProgramName) + '\';
      DeleteKey(S + 'lvSearchItem\Columns');
      DeleteKey(S + 'lvSearchItem\Sort');
      DeleteKey(S + 'lvSearchItem');
      DeleteKey(S + 'QuestList');
      DeleteKey(S + 'servers\localhost');
      DeleteKey(S + 'servers');
      DeleteKey(S);
    finally
      Free;
    end;
  S := dmMain.ProgramDir;
  DeleteFile(S + 'CSV\ActionType.csv');
  DeleteFile(S + 'CSV\AreaTable.csv');
  DeleteFile(S + 'CSV\class.csv');
  DeleteFile(S + 'CSV\Classes.csv');
  DeleteFile(S + 'CSV\CreatureDynamicFlags.csv');
  DeleteFile(S + 'CSV\CreatureFamily.csv');
  DeleteFile(S + 'CSV\CreatureFlags.csv');
  DeleteFile(S + 'CSV\CreatureInhabitType.csv');
  DeleteFile(S + 'CSV\CreatureMovementType.csv');
  DeleteFile(S + 'CSV\CreatureTypeFlags.csv');
  DeleteFile(S + 'CSV\CreatureType.csv');
  DeleteFile(S + 'CSV\Conditions.csv');
  DeleteFile(S + 'CSV\Emotes.csv');
  DeleteFile(S + 'CSV\EventType.csv');
  DeleteFile(S + 'CSV\Faction.csv');
  DeleteFile(S + 'CSV\FactionTemplate.csv');
  DeleteFile(S + 'CSV\FlagsExtra.csv');
  DeleteFile(S + 'CSV\GameObjectFlags.csv');
  DeleteFile(S + 'CSV\GameObjectType.csv');
  DeleteFile(S + 'CSV\GemProperties.csv');
  DeleteFile(S + 'CSV\ItemBagFamily.csv');
  DeleteFile(S + 'CSV\ItemBonding.csv');
  DeleteFile(S + 'CSV\ItemClass.csv');
  DeleteFile(S + 'CSV\ItemDmgType.csv');
  DeleteFile(S + 'CSV\ItemExtendedCost.csv');
  DeleteFile(S + 'CSV\ItemInventoryType.csv');
  DeleteFile(S + 'CSV\ItemFlags.csv');
  DeleteFile(S + 'CSV\ItemMaterial.csv');
  DeleteFile(S + 'CSV\ItemPageMaterial.csv');
  DeleteFile(S + 'CSV\ItemPetFood.csv');
  DeleteFile(S + 'CSV\ItemQuality.csv');
  DeleteFile(S + 'CSV\ItemRequiredReputationRank.csv');
  DeleteFile(S + 'CSV\ItemSet.csv');
  DeleteFile(S + 'CSV\ItemSheath.csv');
  DeleteFile(S + 'CSV\ItemStatType.csv');
  DeleteFile(S + 'CSV\ItemSubClass.csv');
  DeleteFile(S + 'CSV\Language.csv');
  DeleteFile(S + 'CSV\Map.csv');
  DeleteFile(S + 'CSV\Mechanic.csv');
  DeleteFile(S + 'CSV\NPCFlags.csv');
  DeleteFile(S + 'CSV\QuestFlags.csv');
  DeleteFile(S + 'CSV\QuestInfo.csv');
  DeleteFile(S + 'CSV\QuestSort.csv');
  DeleteFile(S + 'CSV\race.csv');
  DeleteFile(S + 'CSV\Races.csv');
  DeleteFile(S + 'CSV\Rank.csv');
  DeleteFile(S + 'CSV\ScriptCommand.csv');
  DeleteFile(S + 'CSV\SkillLine.csv');
  DeleteFile(S + 'CSV\SpawnMaskFlags.csv');
  DeleteFile(S + 'CSV\SpecialFlags.csv');
  DeleteFile(S + 'CSV\Spell.csv');
  DeleteFile(S + 'CSV\SpellTrigger.csv');
  DeleteFile(S + 'CSV\SpellItemEnchantment.csv');
  DeleteFile(S + 'CSV\TextType.csv');
  DeleteFile(S + 'CSV\trainer_type.csv');
  DeleteFile(S + 'CSV\useSpells.csv');
  RemoveDir(S + 'CSV');
  DeleteFile(S + 'LANG\Default.lng');
  DeleteFile(S + 'LANG\German.lng');
  DeleteFile(S + 'LANG\Russian.lng');
  DeleteFile(S + 'LANG\Czech.lng');
  RemoveDir(S + 'LANG');
  DeleteFile(S + 'Quice.sql');

  with TStringList.Create do
    try
      Add(':try');
      Add('del /Q Quice.exe');
      Add('if exist Quice.exe goto try');
      Add('del /Q uninstall.bat');
      SaveToFile(S + 'uninstall.bat');
    finally
      Free;
    end;
  S := S + 'uninstall.bat';
  WinExec(PAnsiChar(AnsiString(S)), SW_HIDE);
  Close;
end;

procedure TMainForm.btBrowseSiteClick(Sender: TObject);
begin
  if Assigned(lvQuest.Selected) then
    dmMain.BrowseSite(ttQuest, StrToInt(lvQuest.Selected.Caption));
end;

procedure TMainForm.StopThread;
begin
  if Assigned(Thread) then
  begin
    Thread.Terminate;
    Thread.WaitFor;
    Thread := nil;
  end;
end;

procedure TMainForm.btDeleteQuestClick(Sender: TObject);
begin
  PageControl2.ActivePageIndex := SCRIPT_TAB_NO_QUEST;
  meqtScript.Text := Format('DELETE FROM `quest_template` WHERE (`entry`=%0:s);'#13#10 +
    'DELETE FROM `creature_questrelation` WHERE (`quest`=%0:s);'#13#10 +
    'DELETE FROM `gameobject_questrelation` WHERE (`quest`=%0:s);'#13#10 +
    'DELETE FROM `creature_involvedrelation` WHERE (`quest`=%0:s);'#13#10 +
    'DELETE FROM `gameobject_involvedrelation` WHERE (`quest`=%0:s);'#13#10 +
    'DELETE FROM `areatrigger_involvedrelation` WHERE (`quest`=%0:s);'#13#10, [lvQuest.Selected.Caption]);
end;

procedure TMainForm.btDelQuestGiverClick(Sender: TObject);
begin
  if Assigned(lvqtGiverTemplate.Selected) then
    lvqtGiverTemplate.DeleteSelected;
end;

procedure TMainForm.btDelQuestTakerClick(Sender: TObject);
begin
  if Assigned(lvqtTakerTemplate.Selected) then
    lvqtTakerTemplate.DeleteSelected;
end;

procedure TMainForm.edSearchChange(Sender: TObject);
begin
  btEditQuest.Default := false;
  btSearch.Default := true;
end;

procedure TMainForm.btClearClick(Sender: TObject);
begin
  edgeholiday.Clear;
  edgelinkedTo.Clear;
  edgeEventGroup.Clear;
  edgestart_time.Clear;
  edgeend_time.Clear;
  edgedescription.Clear;
  edSearchGameEventEntry.Clear;
  edSearchGameEventDesc.Clear;
  edSearchPageTextEntry.Clear;
  edgeentry.Clear;
  edgelength.Clear;
  edgeoccurence.Clear;
  edSearchPageTextText.Clear;
  edSearchPageTextNextPage.Clear;
  edQuestID.Clear;
  edQuestTitle.Clear;
  edQuestGiverSearch.Clear;
  edQuestTakerSearch.Clear;
  edZoneOrSortSearch.Clear;
  edQuestFlagsSearch.Clear;
  lvQuest.Clear;
end;

{ ---------- Creature stuff -------------- }

procedure TMainForm.btClearSearchCreatureClick(Sender: TObject);
begin
  edSearchCreatureEntry.Clear;
  edSearchCreatureName.Clear;
  edSearchCreatureSubName.Clear;
  lvSearchCreature.Clear;
  edSearchCreaturenpcflag.Clear;
end;

procedure TMainForm.btSearchCreatureClick(Sender: TObject);
begin
  SearchCreature();
  with lvSearchCreature do
    if Items.Count > 0 then
    begin
      SetFocus;
      Selected := Items[0];
      btEditCreature.Default := true;
      btSearchCreature.Default := false;
    end;
  StatusBarCreature.Panels[0].Text := Format(dmMain.Text[80], [lvSearchCreature.Items.Count]);
end;

procedure TMainForm.SearchCreature;
var
  i, KillCredit1_, KillCredit2_: Integer;
  loc, id, CName, CSubName, QueryStr, WhereStr, t, npcflag: string;
  Field: TField;
begin
  loc := LoadLocales();
  ShowHourGlassCursor;
  lvSearchCreature.Columns[7].Caption := 'name' + loc;
  lvSearchCreature.Columns[8].Caption := 'subname' + loc;
  id := edSearchCreatureEntry.Text;
  CName := edSearchCreatureName.Text;
  CName := StringReplace(CName, '''', '\''', [rfReplaceAll]);
  CName := StringReplace(CName, ' ', '%', [rfReplaceAll]);
  CName := '%' + CName + '%';

  CSubName := edSearchCreatureSubName.Text;
  CSubName := StringReplace(CSubName, '''', '\''', [rfReplaceAll]);
  CSubName := StringReplace(CSubName, ' ', '%', [rfReplaceAll]);
  CSubName := '%' + CSubName + '%';

  QueryStr := '';
  WhereStr := '';
  if id <> '' then
  begin
    if pos('-', id) = 0 then
      WhereStr := Format('WHERE ((ct.`Entry` in (%s)) OR (ct.`DifficultyEntry1` in (%0:s)))', [id])
    else
      WhereStr :=
        Format('WHERE (((ct.`Entry` >= %s) AND (ct.`Entry` <= %0:s)) OR ct.`DifficultyEntry1` >= %0:s)',
        [id]);
  end;

  if CName <> '%%' then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND ((ct.`Name` LIKE ''%s'') OR (lc.`name' + loc + '` LIKE ''%1:s''))', [WhereStr, CName])
    else
      WhereStr := Format('WHERE ((ct.`Name` LIKE ''%s'') OR (lc.`name' + loc + '` LIKE ''%0:s''))', [CName]);
  end;

  if CSubName <> '%%' then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND ((ct.`SubName` LIKE ''%s'') OR (lc.`subname' + loc + '` LIKE ''%1:s''))',
        [WhereStr, CSubName])
    else
      WhereStr := Format('WHERE ((ct.`SubName` LIKE ''%s'') OR (lc.`subname' + loc + '` LIKE ''%0:s''))', [CSubName]);
  end;

  npcflag := edSearchCreaturenpcflag.Text;

  if npcflag <> '' then
  begin
    if rbExactnpcflag.Checked then
    begin
      if WhereStr <> '' then
        WhereStr := Format('%s AND (ct.`NpcFlags`=%s)', [WhereStr, npcflag])
      else
        WhereStr := Format('WHERE (ct.`NpcFlags`=%s)', [npcflag]);
    end
    else
    begin
      if WhereStr <> '' then
        WhereStr := Format('%s AND (ct.`NpcFlags` & %1:s = %1:s)', [WhereStr, npcflag])
      else
        WhereStr := Format('WHERE (ct.`NpcFlags` & %0:s = %0:s)', [npcflag]);
    end;
  end;

  KillCredit1_ := StrToIntDef(edSearchKillCredit1.Text, -1);
  if KillCredit1_ <> -1 then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND (ct.`KillCredit1` =  %d)', [WhereStr, KillCredit1_])
    else
      WhereStr := Format('WHERE (ct.`KillCredit1` = %d)', [KillCredit1_]);
  end;

  KillCredit2_ := StrToIntDef(edSearchKillCredit2.Text, -1);
  if KillCredit2_ <> -1 then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND (ct.`KillCredit2` =  %d)', [WhereStr, KillCredit2_])
    else
      WhereStr := Format('WHERE (ct.`KillCredit2` = %d)', [KillCredit2_]);
  end;

  if Trim(WhereStr) = '' then
    if MessageDlg(dmMain.Text[134], mtConfirmation, mbYesNoCancel, -1) <> mrYes then
      Exit;

  QueryStr :=
    Format('SELECT *,(SELECT count(guid) from `creature` where creature.id = ct.Entry) as `Count` FROM `creature_template` ct LEFT OUTER JOIN locales_creature lc ON ct.Entry=lc.entry %s',
    [WhereStr]);
  MyQuery.SQL.Text := QueryStr;
  lvSearchCreature.Items.BeginUpdate;
  try
    MyQuery.Open;
    lvSearchCreature.Clear;
    while not MyQuery.Eof do
    begin
      with lvSearchCreature.Items.Add do
      begin
        for i := 0 to lvSearchCreature.Columns.Count - 1 do
        begin
          Field := MyQuery.FindField(lvSearchCreature.Columns[i].Caption);
          t := '';
          if Assigned(Field) then
          begin
            t := Field.AsString;
            if i = 0 then
              Caption := t;
          end;
          if i <> 0 then
            SubItems.Add(t);
        end;
        MyQuery.Next;
      end;
    end;
  finally
    lvSearchCreature.Items.EndUpdate;
    MyQuery.Close;
  end;
end;

procedure TMainForm.SearchCreatureModelInfo;
var
  i: Integer;
  id, QueryStr, WhereStr, t: string;
  Field: TField;
begin
  ShowHourGlassCursor;

  id := edCreatureModelSearch.Text;

  QueryStr := '';
  WhereStr := '';
  if id <> '' then
  begin
    if pos('-', id) = 0 then
      WhereStr := Format('WHERE (`modelid` in (%s))', [id])
    else
      WhereStr := Format('WHERE (`modelid` >= %s) AND (`modelid` <= %s)',
        [MidStr(id, 1, pos('-', id) - 1), MidStr(id, pos('-', id) + 1, length(id))]);
  end;

  if Trim(WhereStr) = '' then
    if MessageDlg(dmMain.Text[134], mtConfirmation, mbYesNoCancel, -1) <> mrYes then
      Exit;

  QueryStr := Format('SELECT * FROM `creature_model_info` %s', [WhereStr]);
  MyQuery.SQL.Text := QueryStr;
  lvCreatureModelSearch.Items.BeginUpdate;
  try
    MyQuery.Open;
    lvCreatureModelSearch.Clear;
    while not MyQuery.Eof do
    begin
      with lvCreatureModelSearch.Items.Add do
      begin
        for i := 0 to lvCreatureModelSearch.Columns.Count - 1 do
        begin
          Field := MyQuery.FindField(lvCreatureModelSearch.Columns[i].Caption);
          t := '';
          if Assigned(Field) then
          begin
            t := Field.AsString;
            if i = 0 then
              Caption := t;
          end;
          if i <> 0 then
            SubItems.Add(t);
        end;
        MyQuery.Next;
      end;
    end;
  finally
    lvCreatureModelSearch.Items.EndUpdate;
    MyQuery.Close;
  end;
end;

procedure TMainForm.edSearchCreatureChange(Sender: TObject);
begin
  btEditCreature.Default := false;
  btSearchCreature.Default := true;
end;

procedure TMainForm.lvSearchCreatureDblClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := 1;
  if Assigned(lvSearchCreature.Selected) then
  begin
    LoadCreature(StrToInt(lvSearchCreature.Selected.Caption));
    CompleteCreatureScript;
  end;
end;

procedure TMainForm.lvSearchCharDblClick(Sender: TObject);
begin
  PageControl8.ActivePageIndex := 1;
  if Assigned(lvSearchChar.Selected) then
    LoadCharacter(StrToInt(lvSearchChar.Selected.Caption));
end;

procedure TMainForm.lvSearchCreatureChange(Sender: TObject; Item: TListItem; Change: TItemChange);
var
  flag: Boolean;
begin
  flag := Assigned(lvSearchCreature.Selected);
  if flag then
    lvSearchCreature.PopupMenu := pmCreature
  else
    lvSearchCreature.PopupMenu := nil;
  btEditCreature.Enabled := flag;
  btDeleteCreature.Enabled := flag;
  btBrowseCreature.Enabled := flag;
  nEditCreature.Enabled := flag;
  nDeleteCreature.Enabled := flag;
  nBrowseCreature.Enabled := flag;
  btBrowseCreaturePopup.Enabled := flag;
end;

procedure TMainForm.btEditCreatureClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := 1;
  if Assigned(lvSearchCreature.Selected) then
    LoadCreature(StrToInt(lvSearchCreature.Selected.Caption));
end;

procedure TMainForm.btDeleteCreatureClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
  mectScript.Text := Format('DELETE FROM `creature_template` WHERE (`entry`=%0:s);'#13#10,
    [lvSearchCreature.Selected.Caption]);
end;

procedure TMainForm.btBrowseCreatureClick(Sender: TObject);
begin
  if Assigned(lvSearchCreature.Selected) then
    dmMain.BrowseSite(ttNPC, StrToInt(lvSearchCreature.Selected.Caption));
end;

procedure TMainForm.LoadCharacter(GUID: Integer);
begin
  ShowHourGlassCursor;
  ClearFields(ttChar);
  if GUID < 1 then
    Exit;
  MyQuery.SQL.Text := Format('SELECT * FROM `' + CharDBName + '`.`characters` WHERE `guid`=%d LIMIT 1', [GUID]);
  MyQuery.Open;
  try
    if MyQuery.Eof then
      raise Exception.Create(Format(dmMain.Text[153], [GUID])); // 'Error: Char (guid = %d) not found'
    FillFields(MyQuery, PFX_CHARACTER);
    LoadCharacterInventory(GUID);
    MyQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[154] + #10#13 + E.Message);
  end;
end;

procedure TMainForm.LoadCharacterInventory(GUID: Integer);
begin
  LoadCharQueryToListView(Format('SELECT ci.*, i.name FROM `' + CharDBName + '`.`character_inventory` ci ' +
    'LEFT OUTER JOIN `item_template` i ON i.entry = ci.item_template ' +
    'WHERE ci.`guid` = %d ORDER BY ci.`bag`, ci.`slot` LIMIT 1', [GUID]), lvCharacterInventory);
end;

procedure TMainForm.LoadCharQueryToListView(strQuery: string; ListView: TJvListView);
begin
  LoadMyQueryToListView(MyTempQuery, strQuery, ListView);
end;

procedure TMainForm.LoadMyQueryToListView(Query: TZQuery; strQuery: string; ListView: TJvListView);
var
  i: Integer;
begin
  ListView.Items.BeginUpdate;
  try
    ListView.Clear;
    if Query.Active then
      Query.Close;
    Query.SQL.Text := strQuery;
    Query.Open;
    while not Query.Eof do
    begin
      for i := 0 to ListView.Columns.Count - 1 do
        ListView.Columns[i].Caption := '';
      for i := 0 to Query.FieldCount - 1 do
        ListView.Columns[i].Caption := Query.Fields[i].FieldName;
      with ListView.Items.Add do
      begin
        Caption := Query.Fields[0].AsString;
        for i := 1 to Query.FieldCount - 1 do
          SubItems.Add(Query.Fields[i].AsString);
      end;
      Query.Next;
    end;
    Query.Close;
  finally
    ListView.Items.EndUpdate;
  end;
end;

procedure TMainForm.LoadCreature(entry: Integer);
var
  i: Integer;
  isvendor, istrainer, isEventAI, isEquip, isGossipMenu: Boolean;
  npcflag: Integer;
  loc : string;
  ltg_entry : string;
begin
  loc := LoadLocales();
  ShowHourGlassCursor;
  ClearFields(ttNPC);
  if entry < 1 then
    Exit;
  // load full description for creature
  MyQuery.SQL.Text := Format('SELECT * FROM `creature_template` WHERE `entry`=%d LIMIT 1', [entry]);
  MyQuery.Open;
  try
    if MyQuery.Eof then
      raise Exception.Create(Format(dmMain.Text[81], [entry])); // 'Error: Creature (entry = %d) not found'
    edctEntry.Text := IntToStr(entry);
    FillFields(MyQuery, PFX_CREATURE_TEMPLATE);

    npcflag := MyQuery.FieldByName('NpcFlags').AsInteger;

    // is creature vendor?
    if npcflag and $80 = $80 then
      isvendor := true
    else
      isvendor := false;

    // is creature trainer?
    istrainer := npcflag and 16 = 16;

    // is eventAI ?
    isEventAI := MyQuery.FieldByName('AIName').AsString = mob_eventai;

    isEquip := MyQuery.FieldByName('EquipmentTemplateId').AsInteger <> 0;

    isGossipMenu := MyQuery.FieldByName('GossipMenuId').AsInteger <> 0;

    MyQuery.Close;

    LoadQueryToListView(Format('SELECT `guid`, `id`, `map`, `position_x`,' +
      ' `position_y`,`position_z`,`orientation` FROM `creature` WHERE (`id`=%d)', [entry]), lvclCreatureLocation);

    LoadQueryToListView(Format('SELECT clt.*, i.`name` FROM `creature_loot_template`' +
      ' clt LEFT OUTER JOIN `item_template` i ON i.`entry` = clt.`item`' + ' WHERE (clt.`entry`=%d)',
      [StrToIntDef(edctLootId.Text, 0)]), lvcoCreatureLoot);

    LoadQueryToListView(Format('SELECT plt.*, i.`name` FROM `pickpocketing_loot_template`' +
      ' plt LEFT OUTER JOIN `item_template` i ON i.`entry` = plt.`item`' + ' WHERE (plt.`entry`=%d)',
      [StrToIntDef(edctPickpocketLootId.Text, 0)]), lvcoPickpocketLoot);

    LoadQueryToListView(Format('SELECT slt.*, i.`name` FROM `skinning_loot_template`' +
      ' slt LEFT OUTER JOIN `item_template` i ON i.`entry` = slt.`item`' + ' WHERE (slt.`entry`=%d)',
      [StrToIntDef(edctSkinningLootId.Text, 0)]), lvcoSkinLoot);

    if isvendor then
    begin
      LoadQueryToListView(Format('SELECT v.* FROM `npc_vendor` v' +
        ' LEFT OUTER JOIN `item_template` i ON i.`entry` = v.`item` WHERE (v.`entry`=%d)', [entry]), lvcvNPCVendor);
    end;
    tsNPCVendor.TabVisible := isvendor;

    LoadQueryToListView(Format('SELECT vt.* FROM `npc_vendor_template` vt' +
      ' LEFT OUTER JOIN `item_template` i ON i.`entry` = vt.`item` WHERE (vt.`entry`=%d)',
      [StrToIntDef(edctVendorTemplateId.Text, 0)]), lvcvtNPCVendor);

    if isEquip then
      LoadCreatureEquip(StrToIntDef(edctEquipmentTemplateId.Text, 0));

    if isEventAI then
      LoadQueryToListView(Format('SELECT   `id`,  `creature_id` as `cid`,  `event_type` as `et`,  ' +
        '`event_inverse_phase_mask` as `epm`, `event_chance` as `ec`,  `event_flags` as `ef`,  ' +
        '`event_param1` as `ep1`,  `event_param2` as `ep2`,  `event_param3` as `ep3`, `event_param4` as `ep4`,  `event_param5` as `ep5`,  `event_param6` as `ep6`,  ' +
        '`action1_type` as `a1t`,  `action1_param1` as `a11`,  `action1_param2` as `a12`,  `action1_param3` as `a13`, '
        + '`action2_type` as `a2t`,  `action2_param1` as `a21`,  `action2_param2` as `a22`,  `action2_param3` as `a23`, '
        + '`action3_type` as `a3t`,  `action3_param1` as `a31`,  `action3_param2` as `a32`,  `action3_param3` as `a33`, '
        + '`comment` as `cmt` FROM `creature_ai_scripts` WHERE `creature_id`=%d', [entry]), lvcnEventAI);
    // tsCreatureEventAI.TabVisible := isEventAI;

    if istrainer then
    begin
      LoadQueryToListView(Format('SELECT `entry`, `spell`,' + ' `spellcost`, `reqskill`, `reqskillvalue`, `reqlevel`, `condition_id`' +
        ' FROM `npc_trainer` WHERE (`entry`=%d)', [entry]), lvcrNPCTrainer);
      // set spellnames in list view
      lvcrNPCTrainer.Columns[lvcrNPCTrainer.Columns.Count - 1].Caption := 'Spell Name';
      for i := 0 to lvcrNPCTrainer.Items.Count - 1 do
        lvcrNPCTrainer.Items[i].SubItems.Add
          (SpellsForm.GetSpellName(StrToIntDef(lvcrNPCTrainer.Items[i].SubItems[0], 0)));
      if MyTempQuery.Active then
        MyTempQuery.Close;
      MyTempQuery.SQL.Text := Format('SELECT tg.Text, ltg.Entry, ltg.Text%s FROM `trainer_greeting` tg' + 
        ' LEFT JOIN `locales_trainer_greeting` ltg ON tg.`Entry` = ltg.`Entry`' + 
        ' WHERE (tg.`Entry`=%d) LIMIT 1', [loc, entry]);
      MyTempQuery.Open;
      while not MyTempQuery.Eof do
      begin
        edtgText.Text := MyTempQuery.Fields[0].AsString;
		ltg_entry := MyTempQuery.Fields[1].AsString;
		if ltg_entry <> '' then
		begin
		  edltgText.Visible := true;
		  edltgText.EditLabel.Caption := MyTempQuery.Fields[2].FieldName;
          edltgText.Text := MyTempQuery.Fields[2].AsString;
		end
		else
		  edltgText.Visible := false;
        MyTempQuery.Next;
      end;
      MyTempQuery.Close;
    end;

    LoadQueryToListView(Format('SELECT `entry`, `spell`,' + ' `spellcost`, `reqskill`, `reqskillvalue`, `reqlevel`, `condition_id`' +
      ' FROM `npc_trainer_template` WHERE (`entry`=%d)', [entry]), lvcrtNPCTrainer);
    // set spellnames in list view
    lvcrtNPCTrainer.Columns[lvcrtNPCTrainer.Columns.Count - 1].Caption := 'Spell Name';
    for i := 0 to lvcrtNPCTrainer.Items.Count - 1 do
      lvcrtNPCTrainer.Items[i].SubItems.Add
        (SpellsForm.GetSpellName(StrToIntDef(lvcrtNPCTrainer.Items[i].SubItems[0], 0)));

    // load gossip_menu
    if isGossipMenu then
      LoadGossipMenu(StrToIntDef(edctGossipMenuId.Text, 0));

    tsNPCTrainer.TabVisible := istrainer;
    LoadCreatureTemplateAddon(entry);
    LoadCreatureTemplateSpells(entry);
    edclid.Text := IntToStr(entry);
    edcoentry.Text := edctLootId.Text;
    edcpentry.Text := edctPickpocketLootId.Text;
    edcsentry.Text := edctSkinningLootId.Text;
    edcventry.Text := IntToStr(entry);
    edcvtentry.Text := edctVendorTemplateId.Text;
    edcrtentry.Text := edctTrainerTemplateId.Text;
    edcrentry.Text := IntToStr(entry);
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[82] + #10#13 + E.Message);
  end;
end;

procedure TMainForm.CompleteCreatureScript;
var
  ctentry, Fields, Values: string;
begin
  mectLog.Clear;
  ctentry := edctEntry.Text;
  if ctentry = '' then
    Exit;
  SetFieldsAndValues(Fields, Values, 'creature_template', PFX_CREATURE_TEMPLATE, mectLog);
  case SyntaxStyle of
    ssInsertDelete:
      mectScript.Text := Format('DELETE FROM `creature_template` WHERE (`entry`=%s);'#13#10 +
        'INSERT INTO `creature_template` (%s) VALUES (%s);'#13#10, [ctentry, Fields, Values]);
    ssReplace:
      mectScript.Text := Format('REPLACE INTO `creature_template` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      mectScript.Text := MakeUpdate('creature_template', PFX_CREATURE_TEMPLATE, false, 'entry', ctentry);
  end;
end;

procedure TMainForm.CompleteCreatureTemplateAddonScript;
var
  entry, Fields, Values: string;
begin
  mectLog.Clear;
  entry := edcdentry.Text;
  if entry = '' then
    Exit;
  SetFieldsAndValues(Fields, Values, 'creature_template_addon', PFX_CREATURE_TEMPLATE_ADDON, mectLog);
  case SyntaxStyle of
    ssInsertDelete:
      mectScript.Text := Format('DELETE FROM `creature_template_addon` WHERE (`entry`=%s);'#13#10 +
      'INSERT INTO `creature_template_addon` (%s) VALUES (%s);'#13#10, [entry, Fields, Values]);
    ssReplace:
      mectScript.Text := Format('REPLACE INTO `creature_template_addon` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      mectScript.Text := MakeUpdate('creature_template_addon', PFX_CREATURE_TEMPLATE_ADDON, false, 'entry', entry);
  end;
end;

procedure TMainForm.CompleteCreatureTemplateSpellsScript;
var
  entry, Fields, Values: string;
begin
  mectLog.Clear;
  entry := edcuentry.Text;
  if entry = '' then
    Exit;
  SetFieldsAndValues(Fields, Values, 'creature_template_spells', PFX_CREATURE_TEMPLATE_SPELLS, mectLog);
  case SyntaxStyle of
    ssInsertDelete:
      mectScript.Text := Format('DELETE FROM `creature_template_spells` WHERE (`entry`=%s);'#13#10 +
        'INSERT INTO `creature_template_spells` (%s) VALUES (%s);'#13#10, [entry, Fields, Values]);
    ssReplace:
      mectScript.Text := Format('REPLACE INTO `creature_template_spells` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      mectScript.Text := MakeUpdate('creature_template_spells', PFX_CREATURE_TEMPLATE_SPELLS, false, 'entry', entry);
  end;
end;

procedure TMainForm.GetCreatureDynamicFlags(Sender: TObject);
begin
  GetSomeFlags(Sender, 'CreatureDynamicFlags');
end;

procedure TMainForm.edctEntryButtonClick(Sender: TObject);
var
  KeyboardState: TKeyboardState;
  id: Integer;
begin
  id := abs(StrToIntDef(TJvComboEdit(Sender).Text, 0));
  if id = 0 then
    Exit;
  GetKeyboardState(KeyboardState);
  if ssShift in KeyboardStateToShiftState(KeyboardState) then
    dmMain.BrowseSite(ttNPC, id)
  else
    LoadCreature(id);
end;

procedure TMainForm.edctEquipmentTemplateIdDblClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := 4;
  LoadCreatureEquip(StrToIntDef(edctEquipmentTemplateId.Text, 0));
end;

procedure TMainForm.btEventAIAddClick(Sender: TObject);
begin
  EventAIAdd('edcn', lvcnEventAI);
end;

procedure TMainForm.btEventAIDelClick(Sender: TObject);
begin
  EventAIDel(lvcnEventAI);
end;

procedure TMainForm.btEventAIUpdClick(Sender: TObject);
begin
  EventAIUpd('edcn', lvcnEventAI);
end;

procedure TMainForm.btExecuteCreatureScriptClick(Sender: TObject);
begin
  if MessageDlg(dmMain.Text[9], mtConfirmation, mbYesNoCancel, -1) = mrYes then
    ExecuteScript(mectScript.Text, mectLog);
end;

procedure TMainForm.btCopyToClipboardCreatureClick(Sender: TObject);
begin
  mectScript.SelectAll;
  mectScript.CopyToClipboard;
  mectScript.SelStart := 0;
  mectScript.SelLength := 0;
end;

procedure TMainForm.tsButtonScriptShow(Sender: TObject);
begin
  if edgbid.Text = '' then
    edgbid.Text := edgtentry.Text;
end;

procedure TMainForm.tsCharacterScriptShow(Sender: TObject);
begin
  case PageControl8.ActivePageIndex of
    1:
      CompleteCharacterScript;
    2:
      CompleteCharacterInventoryScript;
    { 3: CompleteDisLootScript;
      4: CompleteProsLootScript;
      5: CompleteItemEnchScript; }
  end;
end;

procedure TMainForm.reaShow(Sender: TObject);
begin
  if (edcaguid.Text = '') then
    edcaguid.Text := edclguid.Text;
  if (edcamount.Text = '') then
    edcamount.Text := '0';
  if (edcabytes1.Text = '') then
    edcabytes1.Text := '0';
  if (edcab2_0_sheath.Text = '') then
    edcab2_0_sheath.Text := '0';
  if (edcab2_1_pvp_state.Text = '') then
    edcab2_1_pvp_state.Text := '0';
  if (edcaemote.Text = '') then
    edcaemote.Text := '0';
  if (edcamoveflags.Text = '') then
    edcamoveflags.Text := '0';
  if (edcaauras.Text = '') then
    edcaauras.Text := '';
end;

procedure TMainForm.tsCreatureEquipTemplateShow(Sender: TObject);
var
  equipentry: Integer;
begin
  if (edceequipentry1.Text = '') then
    edceequipentry1.Text := '0';
  if (edceequipentry2.Text = '') then
    edceequipentry2.Text := '0';
  if (edceequipentry3.Text = '') then
    edceequipentry3.Text := '0';

  if Assigned(lvclCreatureLocation.Selected) and (StrToIntDef(edclequipment_id.Text, 0) <> 0) then
    equipentry := StrToIntDef(edclequipment_id.Text, 0)
  else
    equipentry := StrToIntDef(edctEquipmentTemplateId.Text, 0);
  if equipentry <> 0 then
  begin
    edceentry.Text := IntToStr(equipentry);
  end;
end;

procedure TMainForm.tsCreatureModelInfoShow(Sender: TObject);
var
  model: string;
begin
  model := '';
  if Assigned(lvclCreatureLocation.Selected) and (StrToIntDef(edclmodelid.Text, 0) <> 0) then
    model := edclmodelid.Text
  else
  begin
    if (edctModelId1.Text <> '') and (edctModelId1.Text <> '0') then
      model := edctModelId1.Text;
    if (edctModelId2.Text <> '') and (edctModelId2.Text <> '0') or (edctModelId3.Text <> '0') or
      (edctModelId4.Text <> '0') then
    begin
      if model <> '' then
        model := Format('%s,%s,%s,%s', [model, edctModelId2.Text, edctModelId3.Text, edctModelId4.Text])
      else
        model := edctModelId2.Text;
    end;
  end;
  if model <> '' then
  begin
    edCreatureModelSearch.Text := model;
    btCreatureModelSearch.Click;
  end;
end;

procedure TMainForm.tsCreatureOnKillReputationShow(Sender: TObject);
begin
  if Trim(edctEntry.Text) <> '' then
    LoadCreatureOnKillReputation(edctEntry.Text);
  edckcreature_id.Text := edctEntry.Text;
end;

procedure TMainForm.tsCreatureScriptShow(Sender: TObject);
begin
  case PageControl3.ActivePageIndex of
    TAB_NO_NPC_CREATURE_TEMPLATE:
      CompleteCreatureScript;
    TAB_NO_NPC_CREATURE_LOCATION:
      CompleteCreatureLocationScript;
    TAB_NO_NPC_CREATURE_MOVEMENT:
      CompleteCreatureMovementScript;
    TAB_NO_NPC_CREATURE_MOVEMENT_TEMPLATE:
      CompleteCreatureMvmntTemplateScript;
    TAB_NO_NPC_CREATURE_MODEL_INFO:
      CompleteCreatureModelInfoScript;
    TAB_NO_NPC_EQUIP_TEMPLATE:
      CompleteCreatureEquipTemplateScript;
    TAB_NO_NPC_CREATURE_LOOT:
      CompleteCreatureLootScript;
    TAB_NO_NPC_PICKPOCKET_LOOT:
      CompletePickpocketLootScript;
    TAB_NO_NPC_SKIN_LOOT:
      CompleteSkinLootScript;
    TAB_NO_NPC_VENDOR:
      CompleteNPCVendorScript;
    TAB_NO_NPC_TRAINER:
      CompleteNPCTrainerScript;
    TAB_NO_NPC_CREATURE_TEMPLATE_ADDON:
      CompleteCreatureTemplateAddonScript;
    TAB_NO_NPC_CREATURE_ADDON:
      CompleteCreatureAddonScript;
    TAB_NO_NPC_GOSSIP:
      begin
        mectScript.Clear;
        CompleteNPCgossipScript;
      end;
    TAB_NO_NPC_CREATURE_ONKILL_REP:
      CompleteCreatureOnKillReputationScript;
    TAB_NO_NPC_INVOLVED_IN: { involved in tab - do nothing }
      ;
    TAB_NO_NPC_CREATURE_AI_EVENT:
      CompleteCreatureEventAIScript;
    TAB_NO_NPC_VENDOR_TEMPLATE:
      CompleteNPCVendorTemplateScript;
    TAB_NO_NPC_GOSSIP_MENU:
      CompleteGossipMenuScript;
    TAB_NO_NPC_CREATURE_TEMPLATE_SPELLS:
      CompleteCreatureTemplateSpellsScript;
  end;
end;

procedure TMainForm.tsCreatureTemplateAddonShow(Sender: TObject);
begin
  if (edcdentry.Text = '') then
    edcdentry.Text := edctEntry.Text;
  if (edcdmount.Text = '') then
    edcdmount.Text := '0';
  if (edcdbytes1.Text = '') then
    edcdbytes1.Text := '0';
  if (edcdb2_0_sheath.Text = '') then
    edcdb2_0_sheath.Text := '0';
  if (edcdb2_1_pvp_state.Text = '') then
    edcdb2_1_pvp_state.Text := '0';
  if (edcdemote.Text = '') then
    edcdemote.Text := '0';
  if (edcdmoveflags.Text = '') then
    edcdmoveflags.Text := '0';
  if (edcdauras.Text = '') then
    edcdauras.Text := '';
end;

procedure TMainForm.tsCreatureTemplateSpellsShow(Sender: TObject);
begin
  if (edcuentry.Text = '') then
    edcuentry.Text := edctEntry.Text;
  if (edcuspell1.Text = '') then
    edcuspell1.Text := '0';
  if (edcuspell2.Text = '') then
    edcuspell2.Text := '0';
  if (edcuspell3.Text = '') then
    edcuspell3.Text := '0';
  if (edcuspell4.Text = '') then
    edcuspell4.Text := '0';
  if (edcuspell5.Text = '') then
    edcuspell5.Text := '0';
  if (edcuspell6.Text = '') then
    edcuspell6.Text := '0';
  if (edcuspell7.Text = '') then
    edcuspell7.Text := '0';
  if (edcuspell8.Text = '') then
    edcuspell8.Text := '0';
end;

procedure TMainForm.tsCreatureUsedShow(Sender: TObject);
begin
  LoadCreatureInvolvedIn(edctEntry.Text);
end;

procedure TMainForm.tsDisenchantLootShow(Sender: TObject);
begin
  if (edidentry.Text = '') then
    edidentry.Text := editDisenchantID.Text;
end;

procedure TMainForm.tsEnchantmentShow(Sender: TObject);
begin
  if (edieentry.Text = '') then
  begin
    if ((editRandomProperty.Text = '0') or (editRandomProperty.Text = '')) then
      edieentry.Text := editRandomSuffix.Text
    else
      edieentry.Text := editRandomProperty.Text;
  end;
end;

procedure TMainForm.LoadCreatureInvolvedIn(entry: string);
var
  a, b, temp: string;
begin
  if Trim(entry) = '' then
    Exit;
  // STARTS
  MyTempQuery.SQL.Text := Format('Select qt.* from creature_questrelation ci' +
    ' INNER JOIN quest_template qt ON ci.quest = qt.entry' + ' where ci.id = %s', [entry]);
  MyTempQuery.Open;
  lvCreatureStarts.Items.BeginUpdate;
  lvCreatureStarts.Items.Clear;
  while not MyTempQuery.Eof do
  begin
    with lvCreatureStarts.Items.Add do
    begin
      Caption := MyTempQuery.FieldByName('entry').AsString;
      SubItems.Add(MyTempQuery.FieldByName('title').AsString);
      SubItems.Add(MyTempQuery.FieldByName('QuestLevel').AsString);
      SubItems.Add(GetRaceAcronym(MyTempQuery.FieldByName('RequiredRaces').AsInteger));

      // Rewards
      a := '';
      b := '';
      if MyTempQuery.FieldByName('RewMoneyMaxLevel').AsInteger > 0 then
        a := MyTempQuery.FieldByName('RewMoneyMaxLevel').AsString + ' MML';
      if MyTempQuery.FieldByName('reworreqmoney').AsInteger > 0 then
        b := MyTempQuery.FieldByName('reworreqmoney').AsString + 'c';
      if (a <> '') and (b <> '') then
        temp := a + ' + ' + b
      else
        temp := a + b;
      SubItems.Add(temp);

      SubItems.Add(GetZoneOrSortAcronym(MyTempQuery.FieldByName('ZoneOrSort').AsInteger));
    end;
    MyTempQuery.Next;
  end;
  MyTempQuery.Close;
  lvCreatureStarts.Items.EndUpdate;

  // ENDS
  MyTempQuery.SQL.Text := Format('Select qt.* from creature_involvedrelation ci' +
    ' INNER JOIN quest_template qt ON ci.quest = qt.entry' + ' where ci.id = %s', [entry]);
  MyTempQuery.Open;
  lvCreatureEnds.Items.BeginUpdate;
  lvCreatureEnds.Items.Clear;
  while not MyTempQuery.Eof do
  begin
    with lvCreatureEnds.Items.Add do
    begin
      Caption := MyTempQuery.FieldByName('entry').AsString;
      SubItems.Add(MyTempQuery.FieldByName('title').AsString);
      SubItems.Add(MyTempQuery.FieldByName('QuestLevel').AsString);
      SubItems.Add(GetRaceAcronym(MyTempQuery.FieldByName('RequiredRaces').AsInteger));

      // Rewards
      a := '';
      b := '';
      if MyTempQuery.FieldByName('RewMoneyMaxLevel').AsInteger > 0 then
        a := MyTempQuery.FieldByName('RewMoneyMaxLevel').AsString + ' MML';
      if MyTempQuery.FieldByName('reworreqmoney').AsInteger > 0 then
        b := MyTempQuery.FieldByName('reworreqmoney').AsString + 'c';
      if (a <> '') and (b <> '') then
        temp := a + ' + ' + b
      else
        temp := a + b;
      SubItems.Add(temp);

      SubItems.Add(GetZoneOrSortAcronym(MyTempQuery.FieldByName('ZoneOrSort').AsInteger));
    end;
    MyTempQuery.Next;
  end;
  MyTempQuery.Close;
  lvCreatureEnds.Items.EndUpdate;

  // Objective of
  MyTempQuery.SQL.Text := Format('Select * from quest_template ' + ' where reqcreatureorgoid1 = %0:s OR' +
    ' reqcreatureorgoid2 = %0:s OR reqcreatureorgoid3 = %0:s OR' + ' reqcreatureorgoid4 = %0:s ', [entry]);
  MyTempQuery.Open;
  lvCreatureObjectiveOf.Items.BeginUpdate;
  lvCreatureObjectiveOf.Items.Clear;
  while not MyTempQuery.Eof do
  begin
    with lvCreatureObjectiveOf.Items.Add do
    begin
      Caption := MyTempQuery.FieldByName('entry').AsString;
      SubItems.Add(MyTempQuery.FieldByName('title').AsString);
      SubItems.Add(MyTempQuery.FieldByName('QuestLevel').AsString);
      SubItems.Add(GetRaceAcronym(MyTempQuery.FieldByName('RequiredRaces').AsInteger));

      // Rewards
      a := '';
      b := '';
      if MyTempQuery.FieldByName('RewMoneyMaxLevel').AsInteger > 0 then
        a := MyTempQuery.FieldByName('RewMoneyMaxLevel').AsString + ' MML';
      if MyTempQuery.FieldByName('reworreqmoney').AsInteger > 0 then
        b := MyTempQuery.FieldByName('reworreqmoney').AsString + 'c';
      if (a <> '') and (b <> '') then
        temp := a + ' + ' + b
      else
        temp := a + b;
      SubItems.Add(temp);

      SubItems.Add(GetZoneOrSortAcronym(MyTempQuery.FieldByName('ZoneOrSort').AsInteger));
    end;
    MyTempQuery.Next;
  end;
  MyTempQuery.Close;
  lvCreatureObjectiveOf.Items.EndUpdate;

  tsCreatureStarts.TabVisible := lvCreatureStarts.Items.Count <> 0;
  tsCreatureEnds.TabVisible := lvCreatureEnds.Items.Count <> 0;
  tsCreatureObjectiveOf.TabVisible := lvCreatureObjectiveOf.Items.Count <> 0;
end;

procedure TMainForm.LoadGOInvolvedIn(entry: string);
var
  a, b, temp: string;
begin
  if Trim(entry) = '' then
    Exit;

  // STARTS
  MyTempQuery.SQL.Text := Format('Select qt.* from gameobject_questrelation ci' +
    ' INNER JOIN quest_template qt ON ci.quest = qt.entry' + ' where ci.id = %s', [entry]);
  MyTempQuery.Open;
  lvGameObjectStarts.Items.BeginUpdate;
  lvGameObjectStarts.Items.Clear;
  while not MyTempQuery.Eof do
  begin
    with lvGameObjectStarts.Items.Add do
    begin
      Caption := MyTempQuery.FieldByName('entry').AsString;
      SubItems.Add(MyTempQuery.FieldByName('title').AsString);
      SubItems.Add(MyTempQuery.FieldByName('QuestLevel').AsString);
      SubItems.Add(GetRaceAcronym(MyTempQuery.FieldByName('RequiredRaces').AsInteger));

      // Rewards
      a := '';
      b := '';
      if MyTempQuery.FieldByName('RewMoneyMaxLevel').AsInteger > 0 then
        a := MyTempQuery.FieldByName('RewMoneyMaxLevel').AsString + ' MML';
      if MyTempQuery.FieldByName('reworreqmoney').AsInteger > 0 then
        b := MyTempQuery.FieldByName('reworreqmoney').AsString + 'c';
      if (a <> '') and (b <> '') then
        temp := a + ' + ' + b
      else
        temp := a + b;
      SubItems.Add(temp);

      SubItems.Add(GetZoneOrSortAcronym(MyTempQuery.FieldByName('ZoneOrSort').AsInteger));
    end;
    MyTempQuery.Next;
  end;
  MyTempQuery.Close;
  lvGameObjectStarts.Items.EndUpdate;

  // ENDS
  MyTempQuery.SQL.Text := Format('Select qt.* from gameobject_involvedrelation ci' +
    ' INNER JOIN quest_template qt ON ci.quest = qt.entry' + ' where ci.id = %s', [entry]);
  MyTempQuery.Open;
  lvGameObjectEnds.Items.BeginUpdate;
  lvGameObjectEnds.Items.Clear;
  while not MyTempQuery.Eof do
  begin
    with lvGameObjectEnds.Items.Add do
    begin
      Caption := MyTempQuery.FieldByName('entry').AsString;
      SubItems.Add(MyTempQuery.FieldByName('title').AsString);
      SubItems.Add(MyTempQuery.FieldByName('QuestLevel').AsString);
      SubItems.Add(GetRaceAcronym(MyTempQuery.FieldByName('RequiredRaces').AsInteger));

      // Rewards
      a := '';
      b := '';
      if MyTempQuery.FieldByName('RewMoneyMaxLevel').AsInteger > 0 then
        a := MyTempQuery.FieldByName('RewMoneyMaxLevel').AsString + ' MML';
      if MyTempQuery.FieldByName('reworreqmoney').AsInteger > 0 then
        b := MyTempQuery.FieldByName('reworreqmoney').AsString + 'c';
      if (a <> '') and (b <> '') then
        temp := a + ' + ' + b
      else
        temp := a + b;
      SubItems.Add(temp);

      SubItems.Add(GetZoneOrSortAcronym(MyTempQuery.FieldByName('ZoneOrSort').AsInteger));
    end;
    MyTempQuery.Next;
  end;
  MyTempQuery.Close;
  lvGameObjectEnds.Items.EndUpdate;

  // Objective of
  MyTempQuery.SQL.Text := Format('Select * from quest_template ' + ' where reqcreatureorgoid1 = -%0:s OR' +
    ' reqcreatureorgoid2 = -%0:s OR reqcreatureorgoid3 = -%0:s OR' + ' reqcreatureorgoid4 = -%0:s ', [entry]);
  MyTempQuery.Open;
  lvGameObjectObjectiveOf.Items.BeginUpdate;
  lvGameObjectObjectiveOf.Items.Clear;
  while not MyTempQuery.Eof do
  begin
    with lvGameObjectObjectiveOf.Items.Add do
    begin
      Caption := MyTempQuery.FieldByName('entry').AsString;
      SubItems.Add(MyTempQuery.FieldByName('title').AsString);
      SubItems.Add(MyTempQuery.FieldByName('QuestLevel').AsString);
      SubItems.Add(GetRaceAcronym(MyTempQuery.FieldByName('RequiredRaces').AsInteger));

      // Rewards
      a := '';
      b := '';
      if MyTempQuery.FieldByName('RewMoneyMaxLevel').AsInteger > 0 then
        a := MyTempQuery.FieldByName('RewMoneyMaxLevel').AsString + ' MML';
      if MyTempQuery.FieldByName('reworreqmoney').AsInteger > 0 then
        b := MyTempQuery.FieldByName('reworreqmoney').AsString + 'c';
      if (a <> '') and (b <> '') then
        temp := a + ' + ' + b
      else
        temp := a + b;
      SubItems.Add(temp);

      SubItems.Add(GetZoneOrSortAcronym(MyTempQuery.FieldByName('ZoneOrSort').AsInteger));
    end;
    MyTempQuery.Next;
  end;
  MyTempQuery.Close;
  lvGameObjectObjectiveOf.Items.EndUpdate;

  tsGOStarts.TabVisible := lvGameObjectStarts.Items.Count <> 0;
  tsGOEnds.TabVisible := lvGameObjectEnds.Items.Count <> 0;
  tsGOObjectiveOf.TabVisible := lvGameObjectObjectiveOf.Items.Count <> 0;
end;

procedure TMainForm.LoadItemInvolvedIn(entry: string);
var
  a, b, temp: string;
begin
  if Trim(entry) = '' then
    Exit;
  // STARTS
  MyTempQuery.SQL.Text := Format('Select qt.* from item_template it' +
    ' INNER JOIN quest_template qt ON it.startquest = qt.entry' + ' where it.entry = %s', [entry]);
  MyTempQuery.Open;
  lvItemStarts.Items.BeginUpdate;
  lvItemStarts.Items.Clear;
  while not MyTempQuery.Eof do
  begin
    with lvItemStarts.Items.Add do
    begin
      Caption := MyTempQuery.FieldByName('entry').AsString;
      SubItems.Add(MyTempQuery.FieldByName('title').AsString);
      SubItems.Add(MyTempQuery.FieldByName('QuestLevel').AsString);
      SubItems.Add(GetRaceAcronym(MyTempQuery.FieldByName('RequiredRaces').AsInteger));

      // Rewards
      a := '';
      b := '';
      if MyTempQuery.FieldByName('RewMoneyMaxLevel').AsInteger > 0 then
        a := MyTempQuery.FieldByName('RewMoneyMaxLevel').AsString + ' MML';
      if MyTempQuery.FieldByName('reworreqmoney').AsInteger > 0 then
        b := MyTempQuery.FieldByName('reworreqmoney').AsString + 'c';
      if (a <> '') and (b <> '') then
        temp := a + ' + ' + b
      else
        temp := a + b;
      SubItems.Add(temp);

      SubItems.Add(GetZoneOrSortAcronym(MyTempQuery.FieldByName('ZoneOrSort').AsInteger));
    end;
    MyTempQuery.Next;
  end;
  MyTempQuery.Close;
  lvItemStarts.Items.EndUpdate;

  // Objective of
  MyTempQuery.SQL.Text := Format('Select * from quest_template ' + ' where ReqItemId1 = %0:s OR' +
    ' ReqItemId2 = %0:s OR ReqItemId3 = %0:s OR' + ' ReqItemId4 = %0:s ', [entry]);
  MyTempQuery.Open;
  lvItemObjectiveOf.Items.BeginUpdate;
  lvItemObjectiveOf.Items.Clear;
  while not MyTempQuery.Eof do
  begin
    with lvItemObjectiveOf.Items.Add do
    begin
      Caption := MyTempQuery.FieldByName('entry').AsString;
      SubItems.Add(MyTempQuery.FieldByName('title').AsString);
      SubItems.Add(MyTempQuery.FieldByName('QuestLevel').AsString);
      SubItems.Add(GetRaceAcronym(MyTempQuery.FieldByName('RequiredRaces').AsInteger));

      // Rewards
      a := '';
      b := '';
      if MyTempQuery.FieldByName('RewMoneyMaxLevel').AsInteger > 0 then
        a := MyTempQuery.FieldByName('RewMoneyMaxLevel').AsString + ' MML';
      if MyTempQuery.FieldByName('reworreqmoney').AsInteger > 0 then
        b := MyTempQuery.FieldByName('reworreqmoney').AsString + 'c';
      if (a <> '') and (b <> '') then
        temp := a + ' + ' + b
      else
        temp := a + b;
      SubItems.Add(temp);

      SubItems.Add(GetZoneOrSortAcronym(MyTempQuery.FieldByName('ZoneOrSort').AsInteger));
    end;
    MyTempQuery.Next;
  end;
  MyTempQuery.Close;
  lvItemObjectiveOf.Items.EndUpdate;

  // Source for
  MyTempQuery.SQL.Text := Format('Select * from quest_template ' + ' where ReqSourceId1 = %0:s OR' +
    ' ReqSourceId2 = %0:s OR ReqSourceId3 = %0:s OR' + ' ReqSourceId4 = %0:s ', [entry]);
  MyTempQuery.Open;
  lvItemSourceFor.Items.BeginUpdate;
  lvItemSourceFor.Items.Clear;
  while not MyTempQuery.Eof do
  begin
    with lvItemSourceFor.Items.Add do
    begin
      Caption := MyTempQuery.FieldByName('entry').AsString;
      SubItems.Add(MyTempQuery.FieldByName('title').AsString);
      SubItems.Add(MyTempQuery.FieldByName('QuestLevel').AsString);
      SubItems.Add(GetRaceAcronym(MyTempQuery.FieldByName('RequiredRaces').AsInteger));

      // Rewards
      a := '';
      b := '';
      if MyTempQuery.FieldByName('RewMoneyMaxLevel').AsInteger > 0 then
        a := MyTempQuery.FieldByName('RewMoneyMaxLevel').AsString + ' MML';
      if MyTempQuery.FieldByName('reworreqmoney').AsInteger > 0 then
        b := MyTempQuery.FieldByName('reworreqmoney').AsString + 'c';
      if (a <> '') and (b <> '') then
        temp := a + ' + ' + b
      else
        temp := a + b;
      SubItems.Add(temp);

      SubItems.Add(GetZoneOrSortAcronym(MyTempQuery.FieldByName('ZoneOrSort').AsInteger));
    end;
    MyTempQuery.Next;
  end;
  MyTempQuery.Close;
  lvItemSourceFor.Items.EndUpdate;

  // Provided for
  MyTempQuery.SQL.Text := Format('Select * from quest_template ' + ' where srcitemid = %s ', [entry]);
  MyTempQuery.Open;
  lvItemProvidedFor.Items.BeginUpdate;
  lvItemProvidedFor.Items.Clear;
  while not MyTempQuery.Eof do
  begin
    with lvItemProvidedFor.Items.Add do
    begin
      Caption := MyTempQuery.FieldByName('entry').AsString;
      SubItems.Add(MyTempQuery.FieldByName('title').AsString);
      SubItems.Add(MyTempQuery.FieldByName('QuestLevel').AsString);
      SubItems.Add(GetRaceAcronym(MyTempQuery.FieldByName('RequiredRaces').AsInteger));

      // Rewards
      a := '';
      b := '';
      if MyTempQuery.FieldByName('RewMoneyMaxLevel').AsInteger > 0 then
        a := MyTempQuery.FieldByName('RewMoneyMaxLevel').AsString + ' MML';
      if MyTempQuery.FieldByName('reworreqmoney').AsInteger > 0 then
        b := MyTempQuery.FieldByName('reworreqmoney').AsString + 'c';
      if (a <> '') and (b <> '') then
        temp := a + ' + ' + b
      else
        temp := a + b;
      SubItems.Add(temp);

      SubItems.Add(GetZoneOrSortAcronym(MyTempQuery.FieldByName('ZoneOrSort').AsInteger));
    end;
    MyTempQuery.Next;
  end;
  MyTempQuery.Close;
  lvItemProvidedFor.Items.EndUpdate;

  // Reward from
  MyTempQuery.SQL.Text := Format('Select * from quest_template ' + ' where RewChoiceItemId1 = %0:s OR' +
    ' RewChoiceItemId2 = %0:s OR RewChoiceItemId3 = %0:s OR' + ' RewChoiceItemId4 = %0:s OR RewChoiceItemId5 = %0:s OR'
    + ' RewItemId2 = %0:s OR RewItemId3 = %0:s OR' + ' RewItemId4 = %0:s OR RewItemId1 = %0:s OR' +
    ' RewChoiceItemId6 = %0:s ', [entry]);
  MyTempQuery.Open;
  lvItemRewardFrom.Items.BeginUpdate;
  lvItemRewardFrom.Items.Clear;
  while not MyTempQuery.Eof do
  begin
    with lvItemRewardFrom.Items.Add do
    begin
      Caption := MyTempQuery.FieldByName('entry').AsString;
      SubItems.Add(MyTempQuery.FieldByName('title').AsString);
      SubItems.Add(MyTempQuery.FieldByName('QuestLevel').AsString);
      SubItems.Add(GetRaceAcronym(MyTempQuery.FieldByName('RequiredRaces').AsInteger));

      // Rewards
      a := '';
      b := '';
      if MyTempQuery.FieldByName('RewMoneyMaxLevel').AsInteger > 0 then
        a := MyTempQuery.FieldByName('RewMoneyMaxLevel').AsString + ' MML';
      if MyTempQuery.FieldByName('reworreqmoney').AsInteger > 0 then
        b := MyTempQuery.FieldByName('reworreqmoney').AsString + 'c';
      if (a <> '') and (b <> '') then
        temp := a + ' + ' + b
      else
        temp := a + b;
      SubItems.Add(temp);

      SubItems.Add(GetZoneOrSortAcronym(MyTempQuery.FieldByName('ZoneOrSort').AsInteger));
    end;
    MyTempQuery.Next;
  end;
  MyTempQuery.Close;
  lvItemRewardFrom.Items.EndUpdate;

  tsItemStarts.TabVisible := lvItemStarts.Items.Count <> 0;
  tsItemSourceFor.TabVisible := lvItemSourceFor.Items.Count <> 0;
  tsItemObjectiveOf.TabVisible := lvItemObjectiveOf.Items.Count <> 0;
  tsItemProvidedFor.TabVisible := lvItemProvidedFor.Items.Count <> 0;
  tsItemRewardFrom.TabVisible := lvItemRewardFrom.Items.Count <> 0;
end;

function TMainForm.GetZoneOrSortAcronym(ZoneOrSort: Integer): string;
begin
  Result := '';
  if ZoneOrSort > 0 then
    Result := GetValueFromDBC('AreaTable', ZoneOrSort, 11)
  else if ZoneOrSort < 0 then
    Result := GetValueFromDBC('QuestSort', -ZoneOrSort);
end;

procedure TMainForm.edctNpcFlagsButtonClick(Sender: TObject);
begin
  GetSomeFlags(Sender, 'NPCFlags');
end;

procedure TMainForm.edctRankButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 83, 'Rank', false);
end;

procedure TMainForm.edctFamilyButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 84, 'CreatureFamily', false);
end;

procedure TMainForm.edctGossipMenuIdButtonClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := TAB_NO_NPC_GOSSIP_MENU;
end;

procedure TMainForm.GetMechanicImmuneMask(Sender: TObject);
begin
  GetSomeFlags(Sender, 'Mechanic');
end;

procedure TMainForm.GetSchoolImmuneMask(Sender: TObject);
begin
  GetSomeFlags(Sender, 'School');
end;

procedure TMainForm.GetInhabitType(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 0, 'CreatureInhabitType', false);
end;

procedure TMainForm.GetMovementType(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 0, 'CreatureMovementType', false);
end;

procedure TMainForm.GetCreatureTypeFlags(Sender: TObject);
begin
  GetSomeFlags(Sender, 'CreatureTypeFlags');
end;

procedure TMainForm.GetSomeFlags(Sender: TObject; What: string);
var
  edEdit: TJvComboEdit;
  f: TUnitFlagsForm;
begin
  if Sender is TJvComboEdit then
  begin
    edEdit := TJvComboEdit(Sender);
    f := TUnitFlagsForm.Create(Self);
    try
      f.Load(What);
      if (edEdit.Text <> '') and (edEdit.Text <> '0') then
        f.Prepare(edEdit.Text);
      if f.ShowModal = mrOk then
        edEdit.Text := IntToStr(f.Flags);
    finally
      f.Free;
    end;
  end;
end;

procedure TMainForm.GetUnitFlags(Sender: TObject);
begin
  GetSomeFlags(Sender, 'CreatureFlags');
end;

procedure TMainForm.GetFlagsExtra(Sender: TObject);
begin
  GetSomeFlags(Sender, 'FlagsExtra');
end;

function TMainForm.GetValueFromDBC(Name: string; id: Cardinal; idx_str: Integer = 1): string;
var
  i: Integer;
  Dbc: TDBCFile;
  Fname: TFileName;
begin
  if Name = 'Spell' then
    Result := SpellsForm.GetSpellName(id)
  else
  begin
    Fname := WideFormat('%s\%s.dbc', [dmMain.DBCDir, Name]);
    if FileExists(Fname) then
    begin
      Dbc := TDBCFile.Create;
      try
        Dbc.Load(Fname);
        for i := 0 to Dbc.recordCount - 1 do
        begin
          Dbc.setRecord(i);
          if Dbc.getUInt(0) = id then
          begin
            Result := Dbc.getString(idx_str);
            break;
          end;
        end;
      finally
        Dbc.Free;
      end;
    end;
  end;
end;

procedure TMainForm.GetValueFromSimpleList(Sender: TObject; TextId: Integer; Name: String; Sort: Boolean);
var
  f: TListForm;
  i: Integer;
begin
  if Assigned(edit) and (edit.Name <> TJvComboEdit(Sender).Name) then
  begin
    lvQuickList.Free;
    lvQuickList := nil;
  end;

  f := TListForm.Create(Self);
  try
    SetList(f.lvList, Name, Sort);
    i := f.lvList.Items.Count;
    if (i > 0) and (i <= 15) then
    begin
      if not Assigned(lvQuickList) then
      begin
        lvQuickList := TListView.Create(Self);
        lvQuickList.Visible := false;
        lvQuickList.Parent := TJvComboEdit(Sender).Parent.Parent;
        lvQuickList.ViewStyle := TViewStyle(vsReport);
        lvQuickList.ShowColumnHeaders := false;
        lvQuickList.BorderStyle := bsSingle;
        lvQuickList.GridLines := true;
        lvQuickList.RowSelect := true;
        lvQuickList.ReadOnly := true;
        lvQuickList.HideSelection := false;
        lvQuickList.Font.Name := f.lvList.Font.Name;
        with lvQuickList.Columns.Add do
          Width := 30;
        with lvQuickList.Columns.Add do
          Width := 230;
        lvQuickList.Width := 281;
        SetList(lvQuickList, Name, Sort);
        edit := TJvComboEdit(Sender);
        QLPrepare;
        lvQuickList.Visible := true;
        lvQuickList.SetFocus;
      end
      else
      begin
        lvQuickList.Free;
        lvQuickList := nil;
      end;
    end
    else
    begin
      if TextId <> 0 then
        f.Caption := dmMain.Text[TextId]
      else
        f.Caption := Name;
      f.Prepare(TJvComboEdit(Sender).Text);
      if f.ShowModal = mrOk then
        TJvComboEdit(Sender).Text := f.lvList.Selected.Caption;
    end;
  finally
    f.Free;
  end;
end;

procedure TMainForm.GetValueFromSimpleList2(Sender: TObject; TextId: Integer; Name: String; Sort: Boolean; id1: string);
var
  f: TListForm;
  Text: string;
begin
  f := TListForm.Create(Self);
  f.Caption := dmMain.Text[TextId];
  try
    SetList(f.lvList, Name, id1, Sort);
    Text := TJvComboEdit(Sender).Text;
    if (Text <> '') then
      f.Prepare(Text);
    if f.ShowModal = mrOk then
      TJvComboEdit(Sender).Text := f.lvList.Selected.Caption;
  finally
    f.Free;
  end;
end;

procedure TMainForm.btNewCreatureClick(Sender: TObject);
begin
  lvSearchCreature.Selected := nil;
  ClearFields(ttNPC);
  SetDefaultFields(ttNPC);
  PageControl3.ActivePageIndex := 1;
end;

procedure TMainForm.edctEquipTemplateIdButtonClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := TAB_NO_NPC_EQUIP_TEMPLATE;
  LoadCreatureEquip(StrToIntDef(TCustomEdit(Sender).Text, 0));
end;

procedure TMainForm.edqtRewMailTemplateIdButtonClick(Sender: TObject);
begin
  PageControl2.ActivePageIndex := TAB_NO_QUEST_MAIL_LOOT;
end;

procedure TMainForm.edctTrainerTemplateIdButtonClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := TAB_NO_NPC_TRAINER_TEMPLATE;
end;

procedure TMainForm.edctTrainerTypeButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 141, 'trainer_type', false);
end;

procedure TMainForm.GetRace(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 142, 'ChrRaces', false);
end;

procedure TMainForm.edcgmentryButtonClick(Sender: TObject);
begin
  LoadGossipMenu(StrToIntDef(edcgmentry.Text, 0));
end;

procedure TMainForm.edcgmoaction_menu_idButtonClick(Sender: TObject);
begin
  if edcgmoaction_menu_id.Text <> '0' then
  begin
    edcgmentry.Text := edcgmoaction_menu_id.Text;
    edcgmentry.Button.Click;
  end;
end;

procedure TMainForm.GetOptionIcon(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 158, 'OptionIcon', false);
end;

procedure TMainForm.edcgmtext_idButtonClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := TAB_NO_NPC_GOSSIP;
  edcgtextid.Text := edcgmtext_id.Text;
  edcgtextid.Button.Click;
end;

procedure TMainForm.edcgtextidButtonClick(Sender: TObject);
begin
  LoadNPCText(TJvComboEdit(Sender).Text);
  NPCTextLoc1.LoadLocalesNPCText(TJvComboEdit(Sender).Text);
end;

procedure TMainForm.GetSpawnMask(Sender: TObject);
begin
  GetSomeFlags(Sender, 'SpawnMaskFlags');
end;

function TMainForm.GetActionParamHint(ActionType: Integer; ParamNo: Integer): string;
begin
  if (ActionType >= 1) and (ActionType <= 57) then
  begin
    case ActionType of
      1:
        begin
          Result := 'EventAI will randomize between the parameters, if they will exist.';

          case ParamNo of
            1:
              Result := 'The entry of the text that the NPC should use from eventai_texts table.';
            2:
              Result := 'The entry of the text that the NPC should use from eventai_texts table.';
            3:
              Result := 'The entry of the text that the NPC should use from eventai_texts table.';
          end;
        end;

      2:
        begin
          Result := 'Changes faction for creature.';

          case ParamNo of
            1:
              Result := 'FactionId from Faction.dbc OR 0.';
            2:
              Result := 'When Parameter 1 is not 0, flags can be used to restore default faction at certain events.';
            3:
              Result := 'Not Used';
          end;
        end;

      3:
        begin
          Result := 'Action change the model of creature.';
          case ParamNo of
            1:
              Result := 'Creature entry from creature_template.';
            2:
              Result := 'If parameter 1 is 0, then this modelId will be used';
            3:
              Result := 'Not Used';
          end;
        end;

      4:
        begin
          Result := 'When activated, the creature will play the specified sound. ';
          case ParamNo of
            1:
              Result := 'The sound ID to be played. Sound IDs are contained in the DBC files';
            2:
              Result := 'Not Used';
            3:
              Result := 'Not Used';
          end;
        end;

      5:
        begin
          Result := 'When activated, the creature will perform a visual emote. Unlike a text emote, a visual emote is one where the creature will actually move or perform a gesture. ';
          case ParamNo of
            1:
              Result := 'The emote ID that the creature should perform. Emote IDs are also contained in the DBC but they can be found in the mangos source as well';
            2:
              Result := 'Not Used';
            3:
              Result := 'Not Used';
          end;
        end;

      6, 7, 8:
        begin
          Result := 'Can be reused to create new action type';
          case ParamNo of
            1:
              Result := 'The text ID to the localized text entry that the creature should say as choice one.';
            2:
              Result := 'The text ID to the localized text entry that the creature should say as choice two.';
            3:
              Result := 'The text ID to the localized text entry that the creature should say as choice three.';
          end;
        end;

      9:
        begin
          Result := 'Similar to the ACTION_T_SOUND action, when this action is activated, it will choose at random a sound to play. This action needs all three parameters to be filled and it will pick a random entry from the three.';
          case ParamNo of
            1:
              Result := 'The Sound ID to be played as Random Choice.';
            2:
              Result := 'The Sound ID to be played as Random Choice.';
            3:
              Result := 'The Sound ID to be played as Random Choice.';
          end;
        end;

      10:
        begin
          Result := 'Similar to the ACTION_T_EMOTE action, when this action is activated, it will choose at random an emote ID to emote visually. This action needs all three parameters to be filled and it will pick a random entry from the three.';
          case ParamNo of
            1:
              Result := 'The Emote ID to be played as Random Choicee.';
            2:
              Result := 'The Emote ID to be played as Random Choice. ';
            3:
              Result := 'The Emote ID to be played as Random Choice. ';
          end;
        end;

      11:
        begin
          Result := 'When activated, the creature will cast a spell specified by a spell ID on a target specified by the target type. ';
          case ParamNo of
            1:
              Result := 'The spell ID to use for the cast. The value used in this field needs to be a valid spell ID.';
            2:
              Result := 'The target type defining who the creature should cast on.';
            3:
              Result := 'CastFlags.';
          end;
        end;

      12:
        begin
          Result := 'When activated, the creature will summon another creature at the same spot as itself that will attack the specified target. ';
          case ParamNo of
            1:
              Result := 'The creature template ID to be summoned. The value here needs to be a valid creature template ID. ';
            2:
              Result := 'The target type defining who the summoned creature will attack. NOTE: Using target type 0 will cause the summoned creature to not attack anyone. ';
            3:
              Result := 'The duration until the summoned creature should be unsummoned. The value in this field is in milliseconds or 0. If zero, then the creature will not be unsummoned until it leaves combat. ';
          end;
        end;
      13:
        begin
          Result := 'When activated, this action will modify the threat of a target in the creature`s threat list by the specified percent. ';
          case ParamNo of
            1:
              Result := 'Threat percent that should be modified. The value in this field can range from -100 to +100. If it is negative, threat will be taken away and if positive, threat will be added. ';
            2:
              Result := 'The target type defining on whom the threat change should occur.';
            3:
              Result := 'Not Used';
          end;
        end;

      14:
        begin
          Result := 'When activated, this action will modify the threat for everyone in the creature`s threat list by the specified percent. ';
          case ParamNo of
            1:
              Result := 'The percent that should be used in modifying everyone`s ' +
                'threat in the creature`s threat list. The value here can range from -100 to +100.' +
                'NOTE: Using -100 will cause the creature to reset everyone`s threat to 0 so that everyone has the same amount of threat. It does NOT make any changes as to who is in the threat list. ';
            2:
              Result := 'Not Used';
            3:
              Result := 'Not Used';
          end;
        end;

      15:
        begin
          Result := 'When activated, this action will satisfy the external ' +
            'completion requirement for the quest for the specified target defined by the target type.' +
            'This action can only be used with player targets so it must be ensured that the target type will point to a player. ';
          case ParamNo of
            1:
              Result := 'The quest template ID. The value here must be a valid quest template ID. Furthermore, the quest should have SpecialFlags | 2 as it would need to be completed by an external event which is the activation of this action. ';
            2:
              Result := 'The target type defining whom the quest should be completed for.';
            3:
              Result := 'RewardGroup - Used to decide if entire group should be rewarded (1 = entire group, 0 = single target)';
          end;
        end;

      16:
        begin
          Result := 'When activated, this action will call CastedCreatureOrGO() function for the player. It can be used to give quest credit for casting a spell on the creature. ';
          case ParamNo of
            1:
              Result := 'The Creature Template ID to be Summoned. The value here needs to be a valid Creature Template ID. ';
            2:
              Result := 'The spell ID to use to simulate the cast. The value used in this field needs to be a valid spell ID. ';
            3:
              Result := 'The target type defining whom the quest credit should be given to.';
          end;
        end;

      17:
        begin
          Result := 'When activated, this action can change the target`s unit field values. More information on the field value indeces can be found at character data. ';
          case ParamNo of
            1:
              Result := 'The index of the field number to be changed. Use character data for a list of indexes and what they control. Note that a creature shares the same indexes with a player except for the PLAYER_* ones. ';
            2:
              Result := 'The new value to be put in the field. ';
            3:
              Result := 'The target type defining for whom the unit field should be changed.';
          end;
        end;

      18:
        begin
          Result := 'When activated, this action changes the target`s flags by adding (turning on) more flags. For example, this action can make the creature unattackable/unselectable if the right flags are used. ';
          case ParamNo of
            1:
              Result := 'The flag(s) to be set. Multiple flags can be set by using bitwise-OR on them (adding them together). ';
            2:
              Result := 'The target type defining for whom the flags should be changed.';
            3:
              Result := 'Not Used';
          end;
        end;

      19:
        begin
          Result := 'When activated, this action changes the target`s flags by removing (turning off) flags. For example, this action can make the creature normal after it was unattackable/unselectable if the right flags are used. ';
          case ParamNo of
            1:
              Result := 'The flag(s) to be set. Multiple flags can be set by using bitwise-OR on them (adding them together). ';
            2:
              Result := 'The target type defining for whom the flags should be changed.';
            3:
              Result := 'Not Used';
          end;
        end;
      20:
        begin
          Result := 'This action controls whether or not the creature should stop or start the auto melee attack. ';
          case ParamNo of
            1:
              Result := 'If zero, then the creature will stop its melee attacks.' +
                'If non-zero, then the creature will either continue its melee ' +
                'attacks (the action would then have no effect) or it will start its melee attacks on the target with the top threat if its melee attacks were previously stopped. ';
            2:
              Result := 'Not Used';
            3:
              Result := 'Not Used';
          end;
        end;

      21:
        begin
          Result := 'This action controls whether or not the creature will always move towards its target. ';
          case ParamNo of
            1:
              Result := 'If zero, then the creature will stop its melee attacks.' +
                'If non-zero, then the creature will either continue its melee ' +
                'attacks (the action would then have no effect) or it will start its melee attacks on the target with the top threat if its melee attacks were previously stopped. ';
            2:
              Result := 'If non-zero, then stop melee combat state (if param1=0) or ' +
                'start melee combat state (if param1!=0) and creature in combat with selected target.';
            3:
              Result := 'Not Used';
          end;
        end;

      22:
        begin
          Result := 'When activated, this action sets the creature`s event to the specified value. ';
          case ParamNo of
            1:
              Result := 'The new phase to set the creature in. This number must be an integer between 0 and 31 inclusive. ';
            2:
              Result := 'Not Used';
            3:
              Result := 'Not Used';
          end;
        end;

      23:
        begin
          Result := 'When activated, this action will increase (or decrease) the current creature`s phase. ';
          case ParamNo of
            1:
              Result := 'The number of phases to increase or decrease. Use negative values to decrease the current phase. After increasing or decreasing the phase by this action, the current phase must not be lower than 0 or exceed 31. ';
            2:
              Result := 'Not Used';
            3:
              Result := 'Not Used';
          end;
        end;

      24:
        begin
          Result := 'When activated, the creature will immediately exit out of combat, clear its threat list, and move back to its spawn point. Basically, this action will reset the whole encounter. ';
          case ParamNo of
            1:
              Result := 'Not Used';
            2:
              Result := 'Not Used';
            3:
              Result := 'Not Used';
          end;
        end;

      25:
        begin
          Result := 'When activated, the creature will try to flee from combat. Currently this is done by it casting a fear-like spell on itself called "Run Away". ';
          case ParamNo of
            1:
              Result := 'Not Used';
            2:
              Result := 'Not Used';
            3:
              Result := 'Not Used';
          end;
        end;

      26:
        begin
          Result := 'This action does the same thing as the ACTION_T_QUEST_EVENT does but it does it for all players in the creature`s threat list. Note that if a player is not in its threat list for whatever reason, he/she won`t get the quest completed. ';
          case ParamNo of
            1:
              Result := 'The quest ID to finish for everyone. ';
            2:
              Result := 'If set to 1, it will complete the QuestId for all the players in the threat list. If set to 0, it will use the action invoker.';
            3:
              Result := 'Not Used';
          end;
        end;

      27:
        begin
          Result := 'This action does the same thing as the ACTION_T_CASTCREATUREGO does but it does it for all players in the creature`s threat list. Note that if a player is not in its threat list for whatever reason, he/she won`t receive the cast emulation. ';
          case ParamNo of
            1:
              Result := 'The quest template ID. ';
            2:
              Result := 'The spell ID used to simulate the cast. ';
            3:
              Result := 'Not Used';
          end;
        end;

      28:
        begin
          Result := 'This action will remove all auras from a specific spell from the target. ';
          case ParamNo of
            1:
              Result := 'The target type defining for whom the unit field should be changed. The value in this field needs to be a valid target type as specified in the reference tables below. ';
            2:
              Result := 'The spell ID whose auras will be removed.';
            3:
              Result := 'Not Used';
          end;
        end;

      29:
        begin
          Result := 'This action changes the movement type generator to ranged type using the specified values for angle and distance. Note that specifying zero angle and distance will make it just melee instead. ';
          case ParamNo of
            1:
              Result := 'The distance the mob should keep between it and its target. ';
            2:
              Result := 'The angle the mob should use. ';
            3:
              Result := 'Not Used';
          end;
        end;

      30:
        begin
          Result := 'Randomly sets the phase to one from the three parameter choices.';
          case ParamNo of
            1:
              Result := 'A possible random phase choice. ';
            2:
              Result := 'A possible random phase choice. ';
            3:
              Result := 'A possible random phase choice. ';
          end;
        end;

      31:
        begin
          Result := 'Randomly sets the phase between a range of phases controlled by the parameters. ';
          case ParamNo of
            1:
              Result := 'The minimum of the phase range. ';
            2:
              Result := 'The maximum of the phase range. The number here must be greater than the one in parameter 1. ';
            3:
              Result := 'Not Used';
          end;
        end;

      32:
        begin
          Result := 'Summons creature (param1) to attack target (param2) at location specified by creature_ai_summons (param3). ';
          case ParamNo of
            1:
              Result := 'The creature template ID to be summoned. The value here needs to be a valid creature template ID. ';
            2:
              Result := 'The target type defining who the summoned creature will attack. NOTE: Using target type 0 will cause the summoned creature to not attack anyone. ';
            3:
              Result := 'The summon ID from the eventai_summons table controlling the position (and spawntime) where the summoned mob should be spawned at. ';
          end;
        end;

      33:
        begin
          Result := 'When activated, this action will call KilledMonster() function for the player.' +
            'It can be used to give creature credit for killing a creature (note that it can be ANY creature including certain quest specific triggers). In general if the quest is set to be accompished on different creatures (e.g. "Credit" templates). ';
          case ParamNo of
            1:
              Result := 'The creature template ID. The value here must be a valid creature template ID. ';
            2:
              Result := 'The target type defining whom the quest kill count should be given to.';
            3:
              Result := 'Not Used';
          end;
        end;

      34:
        begin
          Result := 'Sets data for the instance. Note that this will only work when the creature is inside an instantiable zone that has a valid script (ScriptedInstance) assigned.';
          case ParamNo of
            1:
              Result := 'The field to change in the instance script. Again, this field needs to be a valid field that has been already defined in the instance`s script. ';
            2:
              Result := 'The value to put at that field index. The number here must be a valid 32 bit number.';
            3:
              Result := 'Not Used';
          end;
        end;

      35:
        begin
          Result := 'Sets GUID (64 bits) data for the instance based on the target. Note that this will only work when the creature is inside an instantiable zone that has a valid script (ScriptedInstance) assigned. ';
          case ParamNo of
            1:
              Result := 'The field to change in the instance script. Again, this field needs to be a valid field that has been already defined in the instance`s script. ';
            2:
              Result := 'The target type to use to get the GUID that will be stored at the field index. The value in this field needs to be a valid target type as specified in the reference tables below. ';
            3:
              Result := 'Not Used';
          end;
        end;

      36:
        begin
          Result := 'This function temporarily changes creature entry to new entry, display is changed, loot is changed, but AI is not changed. At respawn creature will be reverted to original entry. ';
          case ParamNo of
            1:
              Result := 'The creature template ID. The value here must be a valid creature template ID.';
            2:
              Result := 'Not Used';
            3:
              Result := 'Not Used';
          end;
        end;

      37:
        begin
          Result := 'Kills the creature ';
          case ParamNo of
            1:
              Result := 'Not Used';
            2:
              Result := 'Not Used';
            3:
              Result := 'Not Used';
          end;
        end;

      38:
        begin
          Result := 'Places all players within the instance into combat with the creature. Only works in combat and only works inside of instances.';
          case ParamNo of
            1:
              Result := 'Not Used';
            2:
              Result := 'Not Used';
            3:
              Result := 'Not Used';
          end;
        end;

      39:
        begin
          Result := 'Call any friendly creatures (if its not in combat/etc) in radius attack creature target.';
          case ParamNo of
            1:
              Result := 'All friendly (not only same faction) creatures will go to help';
            2:
              Result := 'Not Used';
            3:
              Result := 'Not Used';
          end;
        end;

      40:
        begin
          Result := 'Set Sheath State For NPC. Note: SHEATH_STATE_RANGED case work in combat state only if combat not start as melee commands.';
          case ParamNo of
            1:
              Result := 'Set Sheath State (0-Unarmed,1-Melee,2-Ranged)';
            2:
              Result := 'Not Used';
            3:
              Result := 'Not Used';
          end;
        end;

      41:
        begin
          Result := 'Despawns The NPC with optional delay time (Works In or Out of Combat)';
          case ParamNo of
            1:
              Result := 'Sets delay time until Despawn occurs after triggering the action. Time is in (ms)';
            2:
              Result := 'Not Used';
            3:
              Result := 'Not Used';
          end;
        end;

      42:
        begin
          Result := 'NOTE: To Cancel Invincible You Need To Set Script For Either 0% HP or 0 HP So Then NPC Can Be Killed Again';
          case ParamNo of
            1:
              Result := 'Minimum Health Level That NPC Can Reach (NPC Will Not Go Below This Value)';
            2:
              Result := 'Sets Format of Parameter 1 Value (0-Exact Value, 1-HP Percent)';
            3:
              Result := 'Not Used';
          end;
        end;

      43:
        begin
          Result := 'If (Param1) AND (Param2) are both 0, unmount';
          case ParamNo of
            1:
              Result := 'Set mount model from creature_template.entry';
            2:
              Result := 'Set mount model by explicit modelId';
            3:
              Result := 'Not Used';
          end;
        end;

      44:
        begin
          Result := 'Set chance of the text';
          case ParamNo of
            1:
              Result := 'Chance with which a text will be displayed (must be between 1 and 99)';
            2:
              Result := 'The entry of the text that the NPC should use from eventai_texts table. Optionally a entry from other tables can be used (such as custom_texts).';
            3:
              Result := 'Optional TextId can be defined in addition. The same apply to this as explained above, however eventAI will randomize between the two.';
          end;
        end;

      45:
        begin
          Result := 'Sender is EAI creature owner, Receiver is creatures found in radius, and Invoker is the one who triggered the event. Invoker can be specified regardless of Sender/Receiver and this enables relaying target.';
          case ParamNo of
            1:
              Result := 'What AIEvent to throw';
            2:
              Result := 'Throw the AIEvent to nearby friendly creatures within this range';
            3:
              Result := 'The thrown AIEvent uses selected target as Invoker';
          end;
        end;

      46:
        begin
          Result := 'This action sets which AIEvents a npc will throw automatically.';
          case ParamNo of
            1:
              Result := 'Which AIEvents to throw';
            2:
              Result := 'Not Used';
            3:
              Result := 'Not Used';
          end;
        end;

      47:
        begin
          Result := 'This action set stand state for the creature.';
          case ParamNo of
            1:
              Result := 'Stand state id to be used by the creature';
            2:
              Result := 'Not Used';
            3:
              Result := 'Not Used';
          end;
        end;

      48:
        begin
          Result := 'This action change movement type for the creature.';
          case ParamNo of
            1:
              Result := 'Movement type id to be used by the creature. Can be 0 = Idle, 1 = Random, 2 = Waypoint.';
            2:
              Result := 'Wander distance to be used in case the movement type is 1.';
            3:
              Result := 'Not Used';
          end;
        end;

      49:
        begin
          Result := 'This action manage dynamic movement of the creature.';
          case ParamNo of
            1:
              Result := 'Enable dynamic movement behavior. 1 = on / 0 = off.';
            2:
              Result := 'Not Used';
            3:
              Result := 'Not Used';
          end;
        end;

      50:
        begin
          Result := 'This action set the react state of the creature. Default behavior is Aggresive.';
          case ParamNo of
            1:
              Result := 'Define the react state of the creature. 0 = Passive, 1 = Defensive, 2 = Aggresive.';
            2:
              Result := 'Not Used';
            3:
              Result := 'Not Used';
          end;
        end;

      51:
        begin
          Result := 'This action manage waypoints of the creature.';
          case ParamNo of
            1:
              Result := 'Pause or unpause waypoints for creature. 0 - Unpause, 1 - Pause.';
            2:
              Result := 'Not Used';
            3:
              Result := 'Not Used';
          end;
        end;

      52:
        begin
          Result := 'Main purpose of this command is to research and find channeled spells (SpellType=3), which do not interrupt as a result of not having found an interrupt flag.';
          case ParamNo of
            1:
              Result := 'Interrupt spell in SpellType slot.';
            2:
              Result := 'Not Used';
            3:
              Result := 'Not Used';
          end;
        end;

      53:
        begin
          Result := 'Launches a dbscripts_on_relay (either static or random one) with selected target as source and creature as target';
          case ParamNo of
            1:
              Result := 'dbscripts_on_relay ID if > 0, if < 0 dbscript_random_template relay template';
            2:
              Result := 'Target which will determine the source of the script';
            3:
              Result := 'Not Used';
          end;
        end;

      54:
        begin
          Result := 'Says a text at given target, deprecates TEXT and CHANCED_TEXT actions, due to superior capabilities. Is a mirror of dbscripts capabilities. ' +
		  'The text IDs are checked against creature_ai_texts for both Parameter 1 and random template in Parameter 3 ' +
		  'NOTE: if Parameter 3 is set, it always takes precedence over Parameter 1, random template has a higher priority. (as such, only one of them needs to be set)';
          case ParamNo of
            1:
              Result := 'Text ID that the creature should say';
            2:
              Result := 'Target at which the creature will speak';
            3:
              Result := 'dbscript_random_template text template';
          end;
        end;

      55:
        begin
          Result := 'Attacks targeted creature. This has particular use when we want to attack specific target received through ACTION_T_THROW_AI_EVENT for example. Can also be used to attack summoner at spawn for example.';
          case ParamNo of
            1:
              Result := 'Target at which the creature will attack';
            2:
              Result := 'Not Used';
            3:
              Result := 'Not Used';
          end;
        end;

      56:
        begin
          Result := 'If a given entry (param1) is valid and found, despawns guardian with given entry. If parameter 1 is 0, despawns all guardians (which is the more common script action).';
          case ParamNo of
            1:
              Result := 'Entry ID of guardian to be despawned (can also be 0)';
            2:
              Result := 'Not Used';
            3:
              Result := 'Not Used';
          end;
        end;

      57:
        begin
          Result := 'Meant to enter a state which simulates Casters, be it normal mana casters or ranged bow/thrown attackers. ' + 
		  'Take note of: EFLAG_RANGED_MODE_ONLY, EFLAG_MELEE_MODE_ONLY, EFLAG_COMBAT_ACTION, CAST_MAIN_SPELL and CAST_DISTANCE_YOURSELF';
          case ParamNo of
            1:
              Result := 'Type of Ranged Mode';
            2:
              Result := 'Distance at which creature will chase during ranged mode';
            3:
              Result := 'Not Used';
          end;
        end;

      58:
        begin
          Result := 'Enables Walk (0 off, 1 on) or enables chase walk (2 off, 3 on).';
          case ParamNo of
            1:
              Result := 'Type of walking';
            2:
              Result := 'Not Used';
            3:
              Result := 'Not Used';
          end;
        end;

      59:
        begin
          Result := 'Sets facing, i.e. orientation to target, or resets it to last waypoint hit, or to respawn position.';
          case ParamNo of
            1:
              Result := 'Target type';
            2:
              Result := 'Reset boolean, 0 sets and 1 resets';
            3:
              Result := 'Not Used';
          end;
        end;

    end;
  end
  else
    Result := '';
end;

procedure TMainForm.edcnaction_typeChange(Sender: TObject; num: string);
begin
  TJvComboEdit(FindComponent('edcnaction'+ num + '_param1')).ShowButton := false;
  TJvComboEdit(FindComponent('edcnaction'+ num + '_param2')).ShowButton := false;
  TJvComboEdit(FindComponent('edcnaction'+ num + '_param3')).ShowButton := false;
  TJvComboEdit(FindComponent('edcnaction'+ num + '_param3')).OnButtonClick := GetTargetType;
  case StrToIntDef(TJvComboEdit(FindComponent('edcnaction'+ num + '_type')).Text, 1) of
	28, 55, 59:
      TJvComboEdit(FindComponent('edcnaction'+ num + '_param1')).ShowButton := true;
	11:
	begin
      TJvComboEdit(FindComponent('edcnaction'+ num + '_param2')).ShowButton := true;
      TJvComboEdit(FindComponent('edcnaction'+ num + '_param3')).ShowButton := true;
      TJvComboEdit(FindComponent('edcnaction'+ num + '_param3')).OnButtonClick := GetCastFlags;
	end;  
	12, 13, 15, 18, 19, 32, 33, 35, 54:
      TJvComboEdit(FindComponent('edcnaction'+ num + '_param2')).ShowButton := true;
	16, 17, 45, 53:
      TJvComboEdit(FindComponent('edcnaction'+ num + '_param3')).ShowButton := true;
  end;
  TJvComboEdit(FindComponent('edcnaction'+ num + '_type')).Hint := GetActionParamHint(StrToIntDef(TCustomEdit(FindComponent('edcnaction'+ num + '_type')).Text, 1), -1);
  TJvComboEdit(FindComponent('edcnaction'+ num + '_param1')).Hint := GetActionParamHint(StrToIntDef(TCustomEdit(FindComponent('edcnaction'+ num + '_type')).Text, -1), 1);
  TJvComboEdit(FindComponent('edcnaction'+ num + '_param2')).Hint := GetActionParamHint(StrToIntDef(TCustomEdit(FindComponent('edcnaction'+ num + '_type')).Text, -1), 2);
  TJvComboEdit(FindComponent('edcnaction'+ num + '_param3')).Hint := GetActionParamHint(StrToIntDef(TCustomEdit(FindComponent('edcnaction'+ num + '_type')).Text, -1), 3);
end;

procedure TMainForm.edcnaction1_typeChange(Sender: TObject);
begin
  edcnaction_typeChange(Sender, '1');
end;

procedure TMainForm.edcnaction2_typeChange(Sender: TObject);
begin
  edcnaction_typeChange(Sender, '2');
end;

procedure TMainForm.edcnaction3_typeChange(Sender: TObject);
begin
  edcnaction_typeChange(Sender, '3');
end;

procedure TMainForm.edcnevent_typeChange(Sender: TObject);
var
  S: array [1 .. 6] of string;
begin
  S[3] := 'RepeatMin';
  S[4] := 'RepeatMax';

  case StrToIntDef(edcnevent_type.Text, -1) of
    0, 1, 29:
      begin
        S[1] := 'InitialMin';
        S[2] := 'InitialMax';
      end;
    2, 12:
      begin
        S[1] := 'HPMax%';
        S[2] := 'HPMin%';
      end;
    3, 18:
      begin
        S[1] := 'ManaMax%';
        S[2] := 'ManaMin%';
      end;
    4, 7, 19, 20, 21:
      begin
        S[1] := 'n/a';
        S[2] := 'n/a';
        S[3] := 'n/a';
        S[4] := 'n/a';
      end;
    5:
      begin
        S[1] := 'RepeatMin';
        S[2] := 'RepeatMax';
        S[3] := 'PlayerOnly';
        S[4] := 'n/a';
      end;
	6:
	  begin
        S[1] := 'ConditionId';
        S[2] := 'n/a';
        S[3] := 'n/a';
        S[4] := 'n/a';
	  end;
    8, 34:
      begin
        S[1] := 'SpellID';
        S[2] := 'Schoolmask';
      end;
    9:
      begin
        S[1] := 'MinDist';
        S[2] := 'MaxDist';
      end;
    10:
      begin
        S[1] := 'NoHostile';
        S[2] := 'MaxRange';
        S[5] := 'PlayerOnly';
        S[6] := 'ConditionId';
      end;
	11:
	  begin
        S[1] := 'Condition';
        S[2] := 'CondValue1';
        S[3] := 'n/a';
        S[4] := 'n/a';
	  end;
    13:
      begin
        S[1] := 'RepeatMin';
        S[2] := 'RepeatMax';
        S[3] := 'n/a';
        S[4] := 'n/a';
      end;
    14:
      begin
        S[1] := 'HPDeficit';
        S[2] := 'Radius';
      end;
    15:
      begin
        S[1] := 'DispelType';
        S[2] := 'Radius';
      end;
    16:
      begin
        S[1] := 'SpellId';
        S[2] := 'Radius';
      end;
    17, 25, 26:
      begin
        S[1] := 'CreatureId';
        S[2] := 'RepeatMin';
        S[3] := 'RepeatMax';
        S[4] := 'n/a';
      end;
    22:
      begin
        S[1] := 'EmoteId';
        S[2] := 'ConditionId';
        S[3] := 'n/a';
        S[4] := 'n/a';
      end;
    23, 24, 27, 28:
      begin
        S[1] := 'SpellId';
        S[2] := 'AmmountInStack';
      end;
    30:
      begin
        S[1] := 'AIEventType';
        S[2] := 'Sender-Entry';
        S[3] := 'n/a';
        S[4] := 'n/a';
      end;
    31:
      begin
        S[1] := 'EnergyMax%';
        S[2] := 'EnergyMin%';
      end;
    32:
      begin
        S[1] := 'MinRange';
        S[2] := 'MaxRange';
      end;
    33:
      begin
        S[1] := 'BackOrFront';
        S[2] := 'unused';
      end;
  else
    begin
      S[1] := '';
      S[2] := '';
      S[3] := '';
      S[4] := '';
      S[5] := '';
      S[6] := '';
    end;
  end;
  edcnevent_param1.Hint := S[1];
  edcnevent_param2.Hint := S[2];
  edcnevent_param3.Hint := S[3];
  edcnevent_param4.Hint := S[4];
  edcnevent_param5.Hint := S[5];
  edcnevent_param6.Hint := S[6];
end;

procedure TMainForm.GetTargetType(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 0, 'TargetTypes', false);
end;

procedure TMainForm.GetActionType(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 0, 'ActionType', false);
end;

procedure TMainForm.GetEventType(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 0, 'EventType', false);
end;

procedure TMainForm.GetEventFlags(Sender: TObject);
begin
  GetSomeFlags(Sender, 'EventFlags');
end;

procedure TMainForm.GetCastFlags(Sender: TObject);
begin
  GetSomeFlags(Sender, 'CastFlags');
end;

procedure TMainForm.GetArea(Sender: TObject);
begin
  if not(Sender is TJvComboEdit) then
    Exit;
  AreaTableForm.Prepare(TJvComboEdit(Sender).Text);
  if AreaTableForm.ShowModal = mrOk then
    TJvComboEdit(Sender).Text := AreaTableForm.lvList.Selected.Caption;
end;

procedure TMainForm.GetSoundEntries(Sender: TObject);
begin
  if not(Sender is TJvComboEdit) then
    Exit;
  SoundEntriesForm.Prepare(TJvComboEdit(Sender).Text);
  if SoundEntriesForm.ShowModal = mrOk then
    TJvComboEdit(Sender).Text := SoundEntriesForm.lvList.Selected.Caption;
end;

procedure TMainForm.GetClass(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 143, 'ChrClasses', false);
end;

procedure TMainForm.edctCreatureTypeButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 85, 'CreatureType', false);
end;

procedure TMainForm.edctVendorTemplateIdButtonClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := TAB_NO_NPC_VENDOR_TEMPLATE;
end;

procedure TMainForm.lvcgmOptionsChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btGossipMenuOptionUpd.Enabled := Assigned(lvcgmOptions.Selected);
  btGossipMenuOptionDel.Enabled := Assigned(lvcgmOptions.Selected);
end;

procedure TMainForm.lvcgmOptionsSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
var
  i: integer;
  FieldName : string;
  Ctrl: TComponent;
begin
  if Selected then
  begin
    for i := 0 to TJvListView(Sender).Columns.Count - 1 do
    begin
      FieldName := TJvListView(Sender).Columns[i].Caption;
      Ctrl := FindComponent('ed'+ PFX_CREATURE_GOSSIP_MENU_OPTION + FieldName);
      if Assigned(Ctrl) and (Ctrl is TCustomEdit) then
      begin
        if i = 0 then
          TCustomEdit(Ctrl).Text := TJvListView(Sender).Selected.Caption
        else
          TCustomEdit(Ctrl).Text := TJvListView(Sender).Selected.SubItems[i-1];
      end;
    end;
  end;
end;

procedure TMainForm.ClearCGMOptionsFields();
var
  i: integer;
  FieldName : string;
  Ctrl: TComponent;
begin
  for i := 0 to lvcgmOptions.Columns.Count - 1 do
  begin
    FieldName := lvcgmOptions.Columns[i].Caption;
    Ctrl := FindComponent('ed'+ PFX_CREATURE_GOSSIP_MENU_OPTION + FieldName);
    if Assigned(Ctrl) and (Ctrl is TCustomEdit) then
    begin
      TCustomEdit(Ctrl).Text := '';
    end;
  end;
end;

procedure TMainForm.lvCharacterInventoryChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btCharInvUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btCharInvDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvCharacterInventorySelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    with Item do
    begin
      edhiguid.Text := Caption;
      edhibag.Text := SubItems[0];
      edhislot.Text := SubItems[1];
      edhiitem.Text := SubItems[2];
      edhiitem_template.Text := SubItems[3];
    end;
end;

procedure TMainForm.lvclCreatureLocationSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
  begin
    LoadCreatureLocation(StrToIntDef(Item.Caption, 0));
    LoadQueryToListView(Format('SELECT * FROM `creature_movement` WHERE (`id` = %d)', [StrToIntDef(Item.Caption, 0)]), lvcmMovement);
    LoadQueryToListView(Format('SELECT * FROM `creature_movement_template` WHERE (`entry` = %d)', [StrToIntDef(Item.SubItems[0], 0)]), lvcmtMovement);
    LoadCreatureAddon(StrToIntDef(Item.Caption, 0));
    LoadNPCgossip(StrToIntDef(Item.Caption, 0));
    edcgtextid.Button.Click;
  end;
end;

procedure TMainForm.edcmidButtonClick(Sender: TObject);
var id: integer;
begin
  PageControl3.ActivePageIndex := TAB_NO_NPC_CREATURE_MOVEMENT;
  id := StrToIntDef(TCustomEdit(Sender).Text, 0);
  LoadCreatureMovement(id);
  LoadQueryToListView(Format('SELECT * FROM `creature_movement` WHERE (`id` = %d)', [id]), lvcmMovement);
end;

procedure TMainForm.edcmtentryButtonClick(Sender: TObject);
var entry: integer;
begin
  PageControl3.ActivePageIndex := TAB_NO_NPC_CREATURE_MOVEMENT_TEMPLATE;
  entry := StrToIntDef(TCustomEdit(Sender).Text, 0);
  LoadCreatureMovementTemplate(entry);
  LoadQueryToListView(Format('SELECT * FROM `creature_movement_template` WHERE (`entry` = %d)', [entry]), lvcmtMovement);
end;

procedure TMainForm.lvcmMovementChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btCreatureMvmntUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btCreatureMvmntDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvcmMovementSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetMvmntEditFields('edcm', lvcmMovement);
end;

procedure TMainForm.lvcmtMovementChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btCreatureMvmntTemplateUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btCreatureMvmntTemplateDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvcmtMovementSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetMvmntEditFields('edcmt', lvcmtMovement);
end;

procedure TMainForm.lvcmsCreatureMovementScriptChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btcmsUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btcmsDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvcmsCreatureMovementScriptSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetScriptEditFields('edcms', lvcmsCreatureMovementScript);
end;

procedure TMainForm.lvcdsCreatureOnDeathScriptChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btcdsUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btcdsDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvcdsCreatureOnDeathScriptSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetScriptEditFields('edcds', lvcdsCreatureOnDeathScript);
end;

procedure TMainForm.lvcnEventAIChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btEventAIUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btEventAIDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvcnEventAISelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetEventAIEditFields('edcn', lvcnEventAI);
end;

procedure TMainForm.LoadCreatureLocation(GUID: Integer);
begin
  if GUID < 1 then
    Exit;
  MyQuery.SQL.Text := Format('SELECT * FROM `creature` WHERE (`guid`=%d) LIMIT 1', [GUID]);
  MyQuery.Open;
  try
    FillFields(MyQuery, PFX_CREATURE);
    MyQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[86] + #10#13 + E.Message);
  end;
end;

procedure TMainForm.LoadCreatureLocationSearchID(ID: Integer);
begin
  if ID < 1 then
    Exit;
  MyQuery.SQL.Text := Format('SELECT * FROM `creature` WHERE (`id`=%d)', [ID]);
  MyQuery.Open;
  try
    FillFields(MyQuery, PFX_CREATURE);
    MyQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[86] + #10#13 + E.Message);
  end;
end;

procedure TMainForm.LoadCreatureMovement(GUID: Integer);
begin
  if GUID < 1 then
    Exit;
  MyQuery.SQL.Text := Format('SELECT * FROM `creature_movement` WHERE (`id`=%d)', [GUID]);
  MyQuery.Open;
  try
    FillFields(MyQuery, PFX_CREATURE_MOVEMENT);
    MyQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[86] + #10#13 + E.Message);
  end;
end;

procedure TMainForm.LoadCreatureMovementTemplate(Entry: Integer);
begin
  if Entry < 1 then
    Exit;
  MyQuery.SQL.Text := Format('SELECT * FROM `creature_movement_template` WHERE (`entry`=%d)', [Entry]);
  MyQuery.Open;
  try
    FillFields(MyQuery, PFX_CREATURE_MOVEMENT_TEMPLATE);
    MyQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[86] + #10#13 + E.Message);
  end;
end;

procedure TMainForm.LoadCreatureOnKillReputation(id: string);
begin
  MyQuery.SQL.Text := Format('SELECT * FROM `creature_onkill_reputation` WHERE (`creature_id`=%s) LIMIT 1', [QuotedStr(id)]);
  MyQuery.Open;
  try
    FillFields(MyQuery, PFX_CREATURE_ONKILL_REPUTATION);
    MyQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[86] + #10#13 + E.Message);
  end;
end;

procedure TMainForm.LoadCreaturesAndGOForGameEvent(entry: string);
begin
  MyTempQuery.SQL.Text := Format('SELECT gec.guid, gec.event, ct.Entry, ct.Name FROM `game_event_creature` gec ' +
    'LEFT OUTER JOIN creature c on c.guid = gec.guid ' + 'LEFT OUTER JOIN creature_template ct on ct.Entry = c.id ' +
    'WHERE abs(`event`)=%s', [entry]);
  MyTempQuery.Open;
  lvGameEventCreature.Items.BeginUpdate;
  try
    lvGameEventCreature.Items.Clear;
    while not MyTempQuery.Eof do
    begin
      with lvGameEventCreature.Items.Add do
      begin
        Caption := MyTempQuery.Fields[0].AsString;
        SubItems.Add(MyTempQuery.Fields[1].AsString);
        SubItems.Add(MyTempQuery.Fields[2].AsString);
        SubItems.Add(MyTempQuery.Fields[3].AsString);
        MyTempQuery.Next;
      end;
    end;
  finally
    lvGameEventCreature.Items.EndUpdate;
  end;
  MyTempQuery.Close;

  MyTempQuery.SQL.Text := Format('SELECT gec.guid, gec.event, ct.entry, ct.name FROM `game_event_gameobject` gec ' +
    'LEFT OUTER JOIN gameobject c on c.guid = gec.guid ' + 'LEFT OUTER JOIN gameobject_template ct on ct.entry = c.id '
    + 'WHERE abs(`event`)=%s', [entry]);
  MyTempQuery.Open;
  lvGameEventGO.Items.BeginUpdate;
  try
    lvGameEventGO.Items.Clear;
    while not MyTempQuery.Eof do
    begin
      with lvGameEventGO.Items.Add do
      begin
        Caption := MyTempQuery.Fields[0].AsString;
        SubItems.Add(MyTempQuery.Fields[1].AsString);
        SubItems.Add(MyTempQuery.Fields[2].AsString);
        SubItems.Add(MyTempQuery.Fields[3].AsString);
        MyTempQuery.Next;
      end;
    end;
  finally
    lvGameEventGO.Items.EndUpdate;
  end;
  MyTempQuery.Close;
end;

procedure TMainForm.LoadCreatureTemplateAddon(entry: Integer);
begin
  if entry < 1 then
    Exit;
  MyQuery.SQL.Text := Format('SELECT * FROM `creature_template_addon` WHERE (`entry`=%d) LIMIT 1', [entry]);
  MyQuery.Open;
  try
    FillFields(MyQuery, PFX_CREATURE_TEMPLATE_ADDON);
    MyQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[149] + #10#13 + E.Message);
  end;
end;

procedure TMainForm.LoadCreatureTemplateSpells(entry: Integer);
begin
  if entry < 1 then
    Exit;
  MyQuery.SQL.Text := Format('SELECT * FROM `creature_template_spells` WHERE (`entry`=%d) LIMIT 1', [entry]);
  MyQuery.Open;
  try
    FillFields(MyQuery, PFX_CREATURE_TEMPLATE_SPELLS);
    MyQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[159] + #10#13 + E.Message);
  end;
end;

procedure TMainForm.LoadCreatureAddon(GUID: Integer);
begin
  if GUID < 1 then
    Exit;
  MyQuery.SQL.Text := Format('SELECT * FROM `creature_addon` WHERE (`guid`=%d) LIMIT 1', [GUID]);
  MyQuery.Open;
  try
    FillFields(MyQuery, PFX_CREATURE_ADDON);
    MyQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[139] + #10#13 + E.Message);
  end;
end;

procedure TMainForm.LoadCreatureEquip(entry: Integer);
begin
  if entry < 1 then
    Exit;
  MyQuery.SQL.Text := Format('SELECT * FROM `creature_equip_template` WHERE (`entry`=%d) LIMIT 1', [entry]);
  MyQuery.Open;
  try
    FillFields(MyQuery, PFX_CREATURE_EQUIP_TEMPLATE);
    MyQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[139] + #10#13 + E.Message);
  end;
end;

procedure TMainForm.LoadGossipMenu(entry: Integer);
begin
  if entry < 1 then
  begin
    lvcgmOptions.Items.Clear;
    Exit;
  end;
  MyQuery.SQL.Text := Format('SELECT * FROM `gossip_menu` WHERE (`entry`=%d)', [entry]);
  MyQuery.Open;
  try
    FillFields(MyQuery, PFX_CREATURE_GOSSIP_MENU);
    MyQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[139] + #10#13 + E.Message);
  end;

  LoadQueryToListView(Format('select * from gossip_menu_option where menu_id=%d', [entry]), lvcgmOptions);
  ClearCGMOptionsFields();
  if lvcgmOptions.Items.Count > 0  then lvcgmOptions.Items[0].Selected := true;

end;

procedure TMainForm.btScriptCreatureClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
end;

procedure TMainForm.GetConditions(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 156, 'Conditions', false);
end;

procedure TMainForm.GetTextType(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 163, 'TextType', false);
end;

procedure TMainForm.CompleteCharacterInventoryScript;
var
  GUID, Fields, Values: string;
begin
  mehtScript.Clear;
  GUID := edhiitem.Text;
  if Trim(GUID) = '' then
    Exit;
  SetFieldsAndValues(MyQuery, Fields, Values, '' + CharDBName + '`.`character_inventory', PFX_CHARACTER_INVENTORY, mehtLog);
  case SyntaxStyle of
    ssInsertDelete:
      mehtScript.Text := Format('DELETE FROM `' + CharDBName + '`.`character_inventory` WHERE (`item`=%s);'#13#10 +
      'INSERT INTO `' + CharDBName + '`.`character_inventory` (%s) VALUES (%s);'#13#10, [GUID, Fields, Values]);
    ssReplace:
      mehtScript.Text := Format('REPLACE INTO `' + CharDBName + '`.`character_inventory` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      mehtScript.Text := MakeUpdate('' + CharDBName + '`.`character_inventory', PFX_CHARACTER_INVENTORY, false, 'item', GUID);
  end;
end;

procedure TMainForm.CompleteCharacterScript;
var
  GUID, Fields, Values: string;
begin
  mehtLog.Clear;
  GUID := edhtguid.Text;
  if GUID = '' then
    Exit;
  SetFieldsAndValues(MyQuery, Fields, Values, '' + CharDBName + '`.`characters', PFX_CHARACTER, mehtLog);
  case SyntaxStyle of
    ssInsertDelete:
      mehtScript.Text := Format('DELETE FROM `' + CharDBName + '`.`characters` WHERE (`guid`=%s);'#13#10 +
        'INSERT INTO `' + CharDBName + '`.`characters` (%s) VALUES (%s);'#13#10, [GUID, Fields, Values]);
    ssReplace:
      mehtScript.Text := Format('REPLACE INTO `' + CharDBName + '`.`characters` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      mehtScript.Text := MakeUpdate('' + CharDBName + '`.`characters', PFX_CHARACTER, false, 'guid', GUID);
  end;
end;

procedure TMainForm.CompleteCreatureAddonScript;
var
  caguid, Fields, Values: string;
begin
  mectLog.Clear;
  caguid := edcaguid.Text;
  if caguid = '' then
    Exit;
  SetFieldsAndValues(Fields, Values, 'creature_addon', PFX_CREATURE_ADDON, mectLog);
  case SyntaxStyle of
    ssInsertDelete:
      mectScript.Text := Format('DELETE FROM `creature_addon` WHERE (`guid`=%s);'#13#10 +
      'INSERT INTO `creature_addon` (%s) VALUES (%s);'#13#10, [caguid, Fields, Values]);
    ssReplace:
      mectScript.Text := Format('REPLACE INTO `creature_addon` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      mectScript.Text := MakeUpdate('creature_addon', PFX_CREATURE_ADDON, false, 'guid', caguid);
  end;
end;

procedure TMainForm.CompleteCreatureEquipTemplateScript;
var
  caguid, Fields, Values: string;
begin
  mectLog.Clear;
  caguid := edceentry.Text;
  if caguid = '' then
    Exit;
  SetFieldsAndValues(Fields, Values, 'creature_equip_template', PFX_CREATURE_EQUIP_TEMPLATE, mectLog);
  case SyntaxStyle of
    ssInsertDelete:
      mectScript.Text := Format('DELETE FROM `creature_equip_template` WHERE (`entry`=%s);'#13#10 +
      'INSERT INTO `creature_equip_template` (%s) VALUES (%s);'#13#10, [caguid, Fields, Values]);
    ssReplace:
      mectScript.Text := Format('REPLACE INTO `creature_equip_template` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      mectScript.Text := MakeUpdate('creature_equip_template', PFX_CREATURE_EQUIP_TEMPLATE, false, 'entry', caguid);
  end;
end;

procedure TMainForm.CompleteGossipMenuScript;
var
  entry, Fields, Values: string;
begin
  mectLog.Clear;
  entry := edcgmentry.Text;
  if entry = '' then
    Exit;
  SetFieldsAndValues(Fields, Values, 'gossip_menu', PFX_CREATURE_GOSSIP_MENU, mectLog);
  case SyntaxStyle of
    ssInsertDelete:
      mectScript.Text := Format('DELETE FROM `gossip_menu` WHERE (`entry`=%s);'#13#10 +
      'INSERT INTO `gossip_menu` (%s) VALUES (%s);'#13#10, [entry, Fields, Values]);
    ssReplace:
      mectScript.Text := Format('REPLACE INTO `gossip_menu` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      mectScript.Text := MakeUpdate('gossip_menu', PFX_CREATURE_GOSSIP_MENU, false, 'entry', entry);
  end;
end;

procedure TMainForm.CompleteLocalesQuest;
var
  lqentry: string;
begin
  meqtLog.Clear;
  lqentry := edqtEntry.Text;
  if lqentry = '' then
    Exit;
  meqtScript.Text := MakeUpdate('locales_quest', PFX_LOCALES_QUEST, true, 'entry', lqentry);
end;

procedure TMainForm.CompleteCreatureEventAIScript;
var
  id, Fields, Values: string;
begin
  mectLog.Clear;
  id := edcnid.Text;
  if id = '' then
    Exit;
  SetFieldsAndValues(MyQuery, Fields, Values, 'creature_ai_scripts', PFX_CREATURE_EVENTAI, mectLog);
  case SyntaxStyle of
    ssInsertDelete:
      mectScript.Text := Format('DELETE FROM `creature_ai_scripts` WHERE (`id`=%s);'#13#10 +
        'INSERT INTO `creature_ai_scripts` (%s) VALUES (%s);'#13#10, [id, Fields, Values]);
    ssReplace:
      mectScript.Text := Format('REPLACE INTO `creature_ai_scripts` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      mectScript.Text := MakeUpdate('creature_ai_scripts', PFX_CREATURE_EVENTAI, false, 'id', id);
  end;
end;

procedure TMainForm.CompleteCreatureModelInfoScript;
var
  caguid, Fields, Values: string;
begin
  mectLog.Clear;
  caguid := edcimodelid.Text;
  if caguid = '' then
    Exit;
  SetFieldsAndValues(Fields, Values, 'creature_model_info', PFX_CREATURE_MODEL_INFO, mectLog);
  case SyntaxStyle of
    ssInsertDelete:
      mectScript.Text := Format('DELETE FROM `creature_model_info` WHERE (`modelid`=%s);'#13#10 +
    'INSERT INTO `creature_model_info` (%s) VALUES (%s);'#13#10, [caguid, Fields, Values]);
    ssReplace:
      mectScript.Text := Format('REPLACE INTO `creature_model_info` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      mectScript.Text := MakeUpdate('creature_model_info', PFX_CREATURE_MODEL_INFO, false, 'modelid', caguid);
  end;
end;

procedure TMainForm.CompleteCreatureMovementScript;
var
  id, point, Fields, Values: string;
begin
  mectLog.Clear;
  id := Trim(edcmid.Text);
  point := Trim(edcmpoint.Text);
  if (id = '') or (point = '') then
    Exit;
  SetFieldsAndValues(Fields, Values, 'creature_movement', PFX_CREATURE_MOVEMENT, mectLog);
  case SyntaxStyle of
    ssInsertDelete:
      mectScript.Text := Format('DELETE FROM `creature_movement` WHERE (`id`=%s) AND (`point`=%s);'#13#10 +
    'INSERT INTO `creature_movement` (%s) VALUES (%s);'#13#10, [id, point, Fields, Values]);
    ssReplace:
      mectScript.Text := Format('REPLACE INTO `creature_movement` (%s) VALUES (%s);'#13#10, [Fields, Values]);
	ssUpdate:
      mectScript.Text := MakeUpdate2('creature_movement', PFX_CREATURE_MOVEMENT, false, 'id', id, 'point', point);
  end;
end;

procedure TMainForm.CompleteCreatureMvmntTemplateScript;
var
  entry, pathId, point, Fields, Values: string;
begin
  mectLog.Clear;
  entry := Trim(edcmtentry.Text);
  pathid := Trim(edcmtpathId.Text);
  point := Trim(edcmtpoint.Text);
  if (entry = '') or (pathid = '') or (point = '') then
    Exit;
  SetFieldsAndValues(Fields, Values, 'creature_movement_template', PFX_CREATURE_MOVEMENT_TEMPLATE, mectLog);
  case SyntaxStyle of
    ssInsertDelete:
      mectScript.Text := Format('DELETE FROM `creature_movement_template` WHERE (`entry`=%s) AND (`pathId`=%s) AND (`point`=%s);'#13#10 +
      'INSERT INTO `creature_movement_template` (%s) VALUES (%s);'#13#10, [entry, pathid, point, Fields, Values]);
    ssReplace:
      mectScript.Text := Format('REPLACE INTO `creature_movement_template` (%s) VALUES (%s);'#13#10, [Fields, Values]);
	ssUpdate:
      mectScript.Text := MakeUpdate3('creature_movement_template', PFX_CREATURE_MOVEMENT_TEMPLATE, false, 'entry', entry, 'pathId', pathid, 'point', point);
  end;
end;

procedure TMainForm.CompleteCreatureOnKillReputationScript;
var
  entry, Fields, Values: string;
begin
  mectLog.Clear;
  entry := Trim(edctEntry.Text);
  if entry = '' then
    Exit;
  SetFieldsAndValues(Fields, Values, 'creature_onkill_reputation', PFX_CREATURE_ONKILL_REPUTATION, mectLog);
  case SyntaxStyle of
    ssInsertDelete:
      mectScript.Text := Format('DELETE FROM `creature_onkill_reputation` WHERE (`creature_id`=%s);'#13#10 +
        'INSERT INTO `creature_onkill_reputation` (%s) VALUES (%s);'#13#10, [entry, Fields, Values]);
    ssReplace:
      mectScript.Text := Format('REPLACE INTO `creature_onkill_reputation` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      mectScript.Text := MakeUpdate('creature_onkill_reputation', PFX_CREATURE_ONKILL_REPUTATION, false, 'creature_id', entry);
  end;
end;

procedure TMainForm.CompleteCreatureLocationScript;
var
  clguid, Fields, Values: string;
begin
  mectLog.Clear;
  clguid := edclguid.Text;
  if clguid = '' then
    Exit;
  SetFieldsAndValues(Fields, Values, 'creature', PFX_CREATURE, mectLog);
  case SyntaxStyle of
    ssInsertDelete:
      mectScript.Text := Format('DELETE FROM `creature` WHERE (`guid`=%s);'#13#10 +
        'INSERT INTO `creature` (%s) VALUES (%s);'#13#10, [clguid, Fields, Values]);
    ssReplace:
      mectScript.Text := Format('REPLACE INTO `creature` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      mectScript.Text := MakeUpdate('creature', PFX_CREATURE, false, 'guid', clguid);
  end;
end;

procedure TMainForm.CompleteCreatureLootScript;
var
  coentry, coitem, Fields, Values: string;
begin
  mectLog.Clear;
  coentry := edcoentry.Text;
  coitem := edcoitem.Text;
  if (coentry = '') or (coitem = '') then
    Exit;
  SetFieldsAndValues(Fields, Values, 'creature_loot_template', PFX_CREATURE_LOOT_TEMPLATE, mectLog);
  case SyntaxStyle of
    ssInsertDelete:
      mectScript.Text := Format('DELETE FROM `creature_loot_template` WHERE (`entry`=%s) AND (`item`=%s);'#13#10 +
      'INSERT INTO `creature_loot_template` (%s) VALUES (%s);'#13#10, [coentry, coitem, Fields, Values]);
    ssReplace:
      mectScript.Text := Format('REPLACE INTO `creature_loot_template` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      mectScript.Text := MakeUpdate2('creature_loot_template', PFX_CREATURE_LOOT_TEMPLATE, false, 'entry', coentry, 'item', coitem);
  end;
end;

procedure TMainForm.CompletePickpocketLootScript;
var
  cpentry, cpitem, Fields, Values: string;
begin
  mectLog.Clear;
  cpentry := edcpentry.Text;
  cpitem := edcpitem.Text;
  if (cpentry = '') or (cpitem = '') then
    Exit;
  SetFieldsAndValues(Fields, Values, 'pickpocketing_loot_template', PFX_PICKPOCKETING_LOOT_TEMPLATE, mectLog);
  case SyntaxStyle of
    ssInsertDelete:
      mectScript.Text := Format('DELETE FROM `pickpocketing_loot_template` WHERE (`entry`=%s) AND (`item`=%s);'#13#10 +
      'INSERT INTO `pickpocketing_loot_template` (%s) VALUES (%s);'#13#10, [cpentry, cpitem, Fields, Values]);
    ssReplace:
      mectScript.Text := Format('REPLACE INTO `pickpocketing_loot_template` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      mectScript.Text := MakeUpdate2('pickpocketing_loot_template', PFX_PICKPOCKETING_LOOT_TEMPLATE, false, 'entry', cpentry, 'item', cpitem);
  end;
end;

procedure TMainForm.CompleteSkinLootScript;
var
  csentry, csitem, Fields, Values: string;
begin
  mectLog.Clear;
  csentry := edcsentry.Text;
  csitem := edcsitem.Text;
  if (csentry = '') or (csitem = '') then
    Exit;
  SetFieldsAndValues(Fields, Values, 'skinning_loot_template', PFX_SKINNING_LOOT_TEMPLATE, mectLog);
  case SyntaxStyle of
    ssInsertDelete:
      mectScript.Text := Format('DELETE FROM `skinning_loot_template` WHERE (`entry`=%s) AND (`item`=%s);'#13#10 +
      'INSERT INTO `skinning_loot_template` (%s) VALUES (%s);'#13#10, [csentry, csitem, Fields, Values]);
    ssReplace:
      mectScript.Text := Format('REPLACE INTO `skinning_loot_template` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      mectScript.Text := MakeUpdate2('skinning_loot_template', PFX_SKINNING_LOOT_TEMPLATE, false, 'entry', csentry, 'item', csitem);
  end;
end;

function TMainForm.Connect: Boolean;
var
  f: TMeConnectForm;
begin
  f := TMeConnectForm.Create(Self);
  try
    if f.ShowModal = mrOk then
      Result := true
    else
    begin
      Result := false;
      if not MyMangosConnection.Connected then
        Application.Terminate;
    end;
  finally
    f.Free;
  end;
end;

procedure TMainForm.CreateNPCTextFields;
var
  i, j, L: Integer;
  ed: TCustomEdit;
begin
  for i := 0 to 7 do
  begin
    L := 8;
    for j := 0 to 9 do
    begin
      case j of
        0, 1, 2:
          ed := TJvComboEdit.Create(Self);
      else
        ed := TLabeledEdit.Create(Self);
      end;
      ed.Parent := gbNPCText;
      case j of
        0:
          ed.Name := Format('edcxtext%d_0', [i]);
        1:
          ed.Name := Format('edcxtext%d_1', [i]);
        2:
          ed.Name := Format('edcxlang%d', [i]);
        3:
          ed.Name := Format('edcxprob%d', [i]);
      else
        ed.Name := Format('edcxem%d_%d', [i, j - 4]);
      end;

      case j of
        0:
          ed.Width := 220;
        1:
          ed.Width := 220;
      else
        ed.Width := 38;
      end;

      if ed is TLabeledEdit then
      begin
        TLabeledEdit(ed).EditLabel.Caption := MidStr(ed.Name, 5, 10);
      end
      else if ed is TJvComboEdit then
      begin
        with TLabel.Create(Self) do
        begin
          Parent := gbNPCText;
          case j of
            0:
              Name := Format('lbcxtext%d_0', [i]);
            1:
              Name := Format('lbcxtext%d_1', [i]);
            2:
              Name := Format('lbcxlang%d', [i]);
            3:
              Name := Format('lbcxprob%d', [i]);
          else
            Name := Format('lbcxem%d_%d', [i, j - 4]);
          end;
          Left := L;
          Top := 32 - 16 + i * (ed.Height + 24);
          Caption := MidStr(Name, 5, 10);
        end;
        TJvComboEdit(ed).Button.Glyph := edqtZoneOrSort.Button.Glyph;
        case j of
          0, 1:
            TJvComboEdit(ed).OnButtonClick := EditButtonClick;
          2:
            TJvComboEdit(ed).OnButtonClick := LangButtonClick;
        end;
      end;

      ed.Text := '';
      ed.Top := 32 + i * (ed.Height + 24);
      ed.Left := L;
      L := L + ed.Width + 8;
    end;
  end;
end;

function TMainForm.CreateVer(Ver: Integer): string;
var
  a, b, c: Integer;
begin
  a := Ver div 10000;
  b := (Ver - a * 10000) div 100;
  c := Ver - a * 10000 - b * 100;
  Result := Format('%d.%d.%d', [a, b, c]);
end;

function TMainForm.CurVer: Integer;
var
  Major, Minor, Release, Build: Word;
begin
  if GetFileVersion(Application.ExeName, Major, Minor, Release, Build) then
    Result := Major * 10000 + Minor * 100 + Release
  else
    Result := 0;
end;

procedure TMainForm.lvGameEventCreatureChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btgeCreatureGuidDel.Enabled := Assigned(TJvListView(Sender).Selected);
  btgeCreatureGuidInv.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvGameEventCreatureDblClick(Sender: TObject);
begin
  if Assigned(lvGameEventCreature.Selected) then
  begin
    edctEntry.Text := lvGameEventCreature.Selected.SubItems[1];
    edctEntry.Button.Click;
    PageControl1.ActivePageIndex := 1;
    PageControl3.ActivePageIndex := 1;
  end;
end;

procedure TMainForm.lvGameEventCreatureSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    edgeCreatureGuid.Text := Item.Caption;
end;

procedure TMainForm.lvGameEventGOChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btgeGOguidDel.Enabled := Assigned(TJvListView(Sender).Selected);
  btgeGOGuidInv.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvGameEventGODblClick(Sender: TObject);
begin
  if Assigned(lvGameEventGO.Selected) then
  begin
    edgtentry.Text := lvGameEventGO.Selected.SubItems[1];
    edgtentry.Button.Click;
    PageControl1.ActivePageIndex := 2;
    PageControl4.ActivePageIndex := 1;
  end;
end;

procedure TMainForm.lvGameEventGOSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    edgeGOguid.Text := Item.Caption;
end;

procedure TMainForm.CompleteNPCVendorScript;
var
  cventry, cvitem, Fields, Values: string;
begin
  mectLog.Clear;
  cventry := edcventry.Text;
  cvitem := edcvitem.Text;
  if (cventry = '') or (cvitem = '') then
    Exit;
  SetFieldsAndValues(Fields, Values, 'npc_vendor', PFX_NPC_VENDOR, mectLog);
  case SyntaxStyle of
    ssInsertDelete:
      mectScript.Text := Format('DELETE FROM `npc_vendor` WHERE (`entry`=%s) AND (`item`=%s);'#13#10 +
    'INSERT INTO `npc_vendor` (%s) VALUES (%s);'#13#10, [cventry, cvitem, Fields, Values]);
    ssReplace:
      mectScript.Text := Format('REPLACE INTO `npc_vendor` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      mectScript.Text := MakeUpdate2('npc_vendor', PFX_NPC_VENDOR, false, 'entry', cventry, 'item', cvitem);
  end;
end;

procedure TMainForm.CompleteNPCVendorTemplateScript;
var
  cvtentry, cvtitem, Fields, Values: string;
begin
  mectLog.Clear;
  cvtentry := edcvtentry.Text;
  cvtitem := edcvtitem.Text;
  if (cvtentry = '') or (cvtitem = '') then
    Exit;
  SetFieldsAndValues(Fields, Values, 'npc_vendor_template', PFX_NPC_VENDOR_TEMPLATE, mectLog);
  case SyntaxStyle of
    ssInsertDelete:
      mectScript.Text := Format('DELETE FROM `npc_vendor_template` WHERE (`entry`=%s) AND (`item`=%s);'#13#10 +
      'INSERT INTO `npc_vendor_template` (%s) VALUES (%s);'#13#10, [cvtentry, cvtitem, Fields, Values]);
    ssReplace:
      mectScript.Text := Format('REPLACE INTO `npc_vendor_template` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      mectScript.Text := MakeUpdate2('npc_vendor_template', PFX_NPC_VENDOR_TEMPLATE, false, 'entry', cvtentry, 'item', cvtitem);
  end;
end;

procedure TMainForm.CompleteNPCgossipScript;
var
  GUID, Fields, Values: string;
begin
  mectLog.Clear;
  // id   := edcgid.Text;
  GUID := edcgnpc_guid.Text;
  if (GUID = '') then
    Exit;
  SetFieldsAndValues(Fields, Values, 'npc_gossip', PFX_NPC_GOSSIP, mectLog);

  Values := StringReplace(Values, '''''', 'NULL', [rfReplaceAll]);

  case SyntaxStyle of
    ssInsertDelete:
      mectScript.Text := Format('DELETE FROM `npc_gossip` WHERE (`npc_guid`=%s);'#13#10 +
      'INSERT INTO `npc_gossip` (%s) VALUES (%s);'#13#10, [GUID, Fields, Values]);
    ssReplace:
      mectScript.Text := Format('REPLACE INTO `npc_gossip` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      mectScript.Text := MakeUpdate('npc_gossip', PFX_NPC_GOSSIP, false, 'npc_guid', GUID);
  end;
end;

procedure TMainForm.CompleteNPCtextScript;
var
  id, Fields, Values: string;
begin
  mectLog.Clear;
  id := edcgtextid.Text;
  if Trim(id) = '' then
    Exit;
  SetFieldsAndValues(Fields, Values, 'npc_text', PFX_NPC_TEXT, mectLog);
  case SyntaxStyle of
    ssInsertDelete:
      mectScript.Text := Format('DELETE FROM `npc_text` WHERE (`ID`=%s);'#13#10 +
      'INSERT INTO `npc_text` (%s) VALUES (%s);'#13#10, [id, Fields, Values]);
    ssReplace:
      mectScript.Text := Format('REPLACE INTO `npc_text` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      mectScript.Text := MakeUpdate('npc_text', PFX_NPC_TEXT, false, 'ID', id);
  end;
end;

procedure TMainForm.CompleteNPCTrainerScript;
var
  crentry, crspell, Fields, Values: string;
begin
  mectLog.Clear;
  crentry := edcrentry.Text;
  crspell := edcrspell.Text;
  if (crentry = '') or (crspell = '') then
    Exit;
  SetFieldsAndValues(Fields, Values, 'npc_trainer', PFX_NPC_TRAINER, mectLog);
  case SyntaxStyle of
    ssInsertDelete:
      mectScript.Text := Format('DELETE FROM `npc_trainer` WHERE (`entry`=%s) AND (`spell`=%s);'#13#10 +
      'INSERT INTO `npc_trainer` (%s) VALUES (%s);'#13#10, [crentry, crspell, Fields, Values]);
    ssReplace:
      mectScript.Text := Format('REPLACE INTO `npc_trainer` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      mectScript.Text := MakeUpdate2('npc_trainer', PFX_NPC_TRAINER, false, 'entry', crentry, 'spell', crspell);
  end;
  mectScript.Lines.Add(MakeUpdate('trainer_greeting', PFX_TRAINER_GREETING, false, 'Entry', crentry));
  if edltgText.Visible then
    mectScript.Lines.Add(MakeUpdate('locales_trainer_greeting', PFX_LOCALES_TRAINER_GREETING, true, 'Entry', crentry));
end;

procedure TMainForm.lvcoCreatureLootSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetLootEditFields('edco', lvcoCreatureLoot);
end;

procedure TMainForm.lvcoPickpocketLootSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetLootEditFields('edcp', lvcoPickpocketLoot);
end;

procedure TMainForm.lvcoSkinLootSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetLootEditFields('edcs', lvcoSkinLoot);
end;

procedure TMainForm.lvCreatureModelSearchSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetCreatureModelEditFields('edci', lvCreatureModelSearch);
end;

procedure TMainForm.lvCreatureStartsEndsDblClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  PageControl2.ActivePageIndex := 1;
  if Assigned(TJvListView(Sender).Selected) then
    LoadQuest(StrToInt(TJvListView(Sender).Selected.Caption));
end;

{ --------  GAMEOBJECT stuff ----------- }

procedure TMainForm.btClearSearchGOClick(Sender: TObject);
begin
  edSearchGOEntry.Clear;
  edSearchGOName.Clear;
  edSearchGOtype.Clear;
  edSearchGOfaction.Clear;
  lvSearchGO.Clear;
end;

procedure TMainForm.btSearchGameEventClick(Sender: TObject);
begin
  SearchGameEvent();
  with lvSearchGameEvent do
    if Items.Count > 0 then
    begin
      SetFocus;
      Selected := Items[0];
    end;
end;

procedure TMainForm.btSearchGOClick(Sender: TObject);
begin
  SearchGO();
  with lvSearchGO do
    if Items.Count > 0 then
    begin
      SetFocus;
      Selected := Items[0];
      btEditGO.Default := true;
      btSearchGO.Default := false;
    end;
  StatusBarGO.Panels[0].Text := Format(dmMain.Text[87], [lvSearchGO.Items.Count]);
end;

procedure TMainForm.SearchGameEvent;
var
  i: Integer;
  id, Name, QueryStr, WhereStr, t: string;
  Field: TField;
begin
  id := edSearchGameEventEntry.Text;
  Name := edSearchGameEventDesc.Text;
  Name := StringReplace(Name, '''', '\''', [rfReplaceAll]);
  Name := StringReplace(Name, ' ', '%', [rfReplaceAll]);
  Name := '%' + Name + '%';

  QueryStr := '';
  WhereStr := '';
  if id <> '' then
  begin
    if pos('-', id) = 0 then
      WhereStr := Format('WHERE (`entry` in (%s))', [id])
    else
      WhereStr := Format('WHERE (`entry` >= %s) AND (`entry` <= %s)',
        [MidStr(id, 1, pos('-', id) - 1), MidStr(id, pos('-', id) + 1, length(id))]);
  end;

  if Name <> '%%' then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND (`description` LIKE ''%s'')', [WhereStr, Name])
    else
      WhereStr := Format('WHERE (`description` LIKE ''%s'')', [Name]);
  end;

  { if Trim(WhereStr)='' then
    if MessageDlg(dmMain.Text[134], mtConfirmation, mbYesNoCancel, -1)<>mrYes then Exit;
  }
  QueryStr := Format('SELECT * FROM `game_event` %s', [WhereStr]);

  MyQuery.SQL.Text := QueryStr;
  lvSearchGameEvent.Items.BeginUpdate;
  lvSearchGameEvent.Items.Clear;
  try
    MyQuery.Open;
    while not MyQuery.Eof do
    begin
      with lvSearchGameEvent.Items.Add do
      begin
        for i := 0 to lvSearchGameEvent.Columns.Count - 1 do
        begin
          Field := MyQuery.FindField(lvSearchGameEvent.Columns[i].Caption);
          t := '';
          if Assigned(Field) then
          begin
            if (Field.DataType = ftDateTime) or (Field.DataType = ftTime) or (Field.DataType = ftDate) then
            begin
              try
                t := FormatDateTime('yyyy-mm-dd hh:mm:ss', Field.AsDateTime);
              except
                t := '1970-01-01 00:00:00';
              end;
              if t = '1899-12-30 00:00:00' then
                t := '1970-01-01 00:00:00';

            end
            else
              t := Field.AsString;
            if i = 0 then
              Caption := t;
          end;
          if i <> 0 then
            SubItems.Add(t);
        end;
        MyQuery.Next;
      end;
    end;
  finally
    lvSearchGameEvent.Items.EndUpdate;
    MyQuery.Close;
  end;
end;

procedure TMainForm.SearchGO;
var
  i, type_, faction, data0_, data1_, data2_: Integer;
  loc, id, CName, QueryStr, WhereStr, t: string;
  Field: TField;
begin
  loc := LoadLocales();
  ShowHourGlassCursor;
  id := edSearchGOEntry.Text;
  lvSearchGO.Columns[5].Caption := 'name' + loc;
  lvSearchGO.Columns[6].Caption := 'castbarcaption' + loc;
  CName := edSearchGOName.Text;
  CName := StringReplace(CName, '''', '\''', [rfReplaceAll]);
  CName := StringReplace(CName, ' ', '%', [rfReplaceAll]);
  CName := '%' + CName + '%';

  QueryStr := '';
  WhereStr := '';
  if id <> '' then
  begin
    if pos('-', id) = 0 then
      WhereStr := Format('WHERE (gt.`entry` in (%s))', [id])
    else
      WhereStr := Format('WHERE (gt.`entry` >= %s) AND (qt.`entry` <= %s)',
        [MidStr(id, 1, pos('-', id) - 1), MidStr(id, pos('-', id) + 1, length(id))]);
  end;

  if CName <> '%%' then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND ((gt.`name` LIKE ''%s'') OR (lg.`name' + loc + '` LIKE ''%1:s''))', [WhereStr, CName])
    else
      WhereStr := Format('WHERE ((gt.`name` LIKE ''%s'') OR (lg.`name' + loc + '` LIKE ''%0:s''))', [CName]);
  end;

  type_ := StrToIntDef(edSearchGOtype.Text, -1);
  if type_ <> -1 then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND (gt.`type` = %d)', [WhereStr, type_])
    else
      WhereStr := Format('WHERE (gt.`type` = %d)', [type_]);
  end;

  faction := StrToIntDef(edSearchGOfaction.Text, -1);
  if faction <> -1 then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND (gt.`faction` = %d)', [WhereStr, faction])
    else
      WhereStr := Format('WHERE (gt.`faction` = %d)', [faction]);
  end;

  data0_ := StrToIntDef(edSearchGOdata0.Text, -1);
  if data0_ <> -1 then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND (gt.`data0` = %d)', [WhereStr, data0_])
    else
      WhereStr := Format('WHERE (gt.`data0` = %d)', [data0_]);
  end;

  data1_ := StrToIntDef(edSearchGOdata1.Text, -1);
  if data1_ <> -1 then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND (gt.`data1` = %d)', [WhereStr, data1_])
    else
      WhereStr := Format('WHERE (gt.`data1` = %d)', [data1_]);
  end;

  data2_ := StrToIntDef(edSearchGOdata2.Text, -1);
  if data2_ <> -1 then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND (gt.`data2` = %d)', [WhereStr, data2_])
    else
      WhereStr := Format('WHERE (gt.`data2` = %d)', [data2_]);
  end;

  if Trim(WhereStr) = '' then
    if MessageDlg(dmMain.Text[134], mtConfirmation, mbYesNoCancel, -1) <> mrYes then
      Exit;

  QueryStr :=
    Format('SELECT *, (SELECT count(guid) from `gameobject` where gameobject.id = gt.entry) as `Count` FROM `gameobject_template` gt LEFT OUTER JOIN `locales_gameobject` lg ON gt.entry=lg.entry %s',
    [WhereStr]);

  MyQuery.SQL.Text := QueryStr;
  lvSearchGO.Items.BeginUpdate;
  try
    MyQuery.Open;
    lvSearchGO.Clear;
    while not MyQuery.Eof do
    begin
      with lvSearchGO.Items.Add do
      begin
        for i := 0 to lvSearchGO.Columns.Count - 1 do
        begin
          Field := MyQuery.FindField(lvSearchGO.Columns[i].Caption);
          t := '';
          if Assigned(Field) then
          begin
            t := Field.AsString;
            if i = 0 then
              Caption := t;
          end;
          if i <> 0 then
            SubItems.Add(t);
        end;
        MyQuery.Next;
      end;
    end;
  finally
    lvSearchGO.Items.EndUpdate;
    MyQuery.Close;
  end;
end;

procedure TMainForm.edSearchGOChange(Sender: TObject);
begin
  btEditGO.Default := false;
  btSearchGO.Default := true;
end;

procedure TMainForm.lvSearchGODblClick(Sender: TObject);
begin
  PageControl4.ActivePageIndex := 1;
  if Assigned(lvSearchGO.Selected) then
  begin
    LoadGO(StrToInt(lvSearchGO.Selected.Caption));
    CompleteGOScript;
  end;
end;

procedure TMainForm.lvSearchGameEventChange(Sender: TObject; Item: TListItem; Change: TItemChange);
var
  f: Boolean;
begin
  f := Assigned(TJvListView(Sender).Selected);
  btGameEventUpd.Enabled := f;
  btGameEventDel.Enabled := f;
  pnSelectedEventInfo.Enabled := f;
  btgeCreatureGuidAdd.Enabled := f;
  btgeGOGuidAdd.Enabled := f;
  btScriptGameEvent.Enabled := f;
  lvGameEventCreature.Enabled := f;
  lvGameEventGO.Enabled := f;
  edgeCreatureGuid.Enabled := f;
  edgeGOguid.Enabled := f;
end;

procedure TMainForm.lvSearchGameEventSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
  begin
    edgeentry.Text := Item.Caption;
    edgestart_time.Text := Item.SubItems[0];
    edgeend_time.Text := Item.SubItems[1];
    edgeoccurence.Text := Item.SubItems[2];
    edgelength.Text := Item.SubItems[3];
    edgeholiday.Text := Item.SubItems[4];
    edgelinkedTo.Text := Item.SubItems[5];
    edgeEventGroup.Text := Item.SubItems[6];
    edgedescription.Text := Item.SubItems[7];
    LoadCreaturesAndGOForGameEvent(Item.Caption);
  end
  else
  begin
    lvGameEventCreature.Clear;
    lvGameEventGO.Clear;
    edgeCreatureGuid.Clear;
    edgeGOguid.Clear;
  end;
end;

procedure TMainForm.lvSearchGOChange(Sender: TObject; Item: TListItem; Change: TItemChange);
var
  flag: Boolean;
begin
  flag := Assigned(lvSearchGO.Selected);
  if flag then
    lvSearchGO.PopupMenu := pmGO
  else
    lvSearchGO.PopupMenu := nil;
  btEditGO.Enabled := flag;
  btDeleteGO.Enabled := flag;
  btBrowseGO.Enabled := flag;
  btBrowseGOPopup.Enabled := flag;
  nEditGO.Enabled := flag;
  nDeleteGo.Enabled := flag;
  nBrowseGO.Enabled := flag;
end;

procedure TMainForm.btEditGOClick(Sender: TObject);
begin
  PageControl4.ActivePageIndex := 1;
  if Assigned(lvSearchGO.Selected) then
    LoadGO(StrToInt(lvSearchGO.Selected.Caption));
end;

procedure TMainForm.btDeleteGOClick(Sender: TObject);
begin
  PageControl4.ActivePageIndex := SCRIPT_TAB_NO_GAMEOBJECT;
  megoScript.Text := Format('DELETE FROM `gameobject_template` WHERE (`entry`=%0:s);'#13#10,
    [lvSearchGO.Selected.Caption]);
end;

procedure TMainForm.btBrowseGOClick(Sender: TObject);
begin
  if Assigned(lvSearchGO.Selected) then
    dmMain.BrowseSite(ttObject, StrToInt(lvSearchGO.Selected.Caption));
end;

procedure TMainForm.LoadGO(entry: Integer);
var
  t: Integer;
begin
  ShowHourGlassCursor;
  ClearFields(ttObject);
  if entry < 1 then
    Exit;
  // load full description for GO
  MyQuery.SQL.Text := Format('SELECT * FROM `gameobject_template` WHERE `entry`=%d LIMIT 1', [entry]);
  MyQuery.Open;
  try
    if MyQuery.Eof then
      raise Exception.Create(Format(dmMain.Text[88], [entry])); // 'Error: GO (entry = %d) not found'
    edgtentry.Text := IntToStr(entry);
    FillFields(MyQuery, PFX_GAMEOBJECT_TEMPLATE);
    t := MyQuery.FieldByName('type').AsInteger;
    MyQuery.Close;
    SetGOdataHints(t);
    SetGOdataNames(t);

    LoadQueryToListView(Format('SELECT `guid`, `id`, `map`, `position_x`,' +
      '`position_y`,`position_z`,`orientation` FROM `gameobject` WHERE (`id`=%d)', [entry]), lvglGOLocation);
    LoadQueryToListView(Format('SELECT glt.*, i.name FROM `gameobject_loot_template` glt ' +
      'LEFT OUTER JOIN `item_template` i ON i.`entry` = glt.`item`  WHERE (glt.`entry`=%d)',
      [StrToIntDef(edgtdata1.Text, 0)]), lvgoGOLoot);
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[89] + #10#13 + E.Message);
  end;
end;

procedure TMainForm.CompleteGOScript;
var
  gtentry, Fields, Values: string;
begin
  megoLog.Clear;
  gtentry := edgtentry.Text;
  if gtentry = '' then
    Exit;
  SetFieldsAndValues(Fields, Values, 'gameobject_template', PFX_GAMEOBJECT_TEMPLATE, megoLog);
  case SyntaxStyle of
    ssInsertDelete:
      megoScript.Text := Format('DELETE FROM `gameobject_template` WHERE (`entry`=%s);'#13#10 +
        'INSERT INTO `gameobject_template` (%s) VALUES (%s);'#13#10, [gtentry, Fields, Values]);
    ssReplace:
      megoScript.Text := Format('REPLACE INTO `gameobject_template` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      megoScript.Text := MakeUpdate('gameobject_template', PFX_GAMEOBJECT_TEMPLATE, false, 'entry', gtentry);
  end;
end;

procedure TMainForm.edgeCreatureGuidButtonClick(Sender: TObject);
begin
  GetGuid(Sender, 'creature');
end;

procedure TMainForm.edgeGOguidButtonClick(Sender: TObject);
begin
  GetGuid(Sender, 'gameobject');
end;

procedure TMainForm.edgtentryButtonClick(Sender: TObject);
var
  KeyboardState: TKeyboardState;
  id: Integer;
begin
  id := abs(StrToIntDef(TJvComboEdit(Sender).Text, 0));
  if id = 0 then
    Exit;
  GetKeyboardState(KeyboardState);
  if ssShift in KeyboardStateToShiftState(KeyboardState) then
    dmMain.BrowseSite(ttObject, id)
  else
    LoadGO(id);
end;

procedure TMainForm.edflagsChange(Sender: TObject);
var
  h: string;
  flag: int64;
  edit: TJvComboEdit;
begin
  edit := TJvComboEdit(Sender);
  if TryStrToInt64(edit.Text, flag) then
  begin
    h := IntToHex(flag, 8);
    edit.Hint := Format('0x%s 0x%s', [MidStr(h, 1, 4), MidStr(h, 5, 4)]);
  end
  else
    edit.Hint := '';
end;

procedure TMainForm.GetGOFlags(Sender: TObject);
begin
  GetSomeFlags(Sender, 'GameObjectFlags');
end;

procedure TMainForm.tsGOShow(Sender: TObject);
begin
  PageControl4.ActivePageIndex := 0;
end;

procedure TMainForm.tsGossipMenuShow(Sender: TObject);
begin
  edcgmentry.Text := edctGossipMenuId.Text;
  edcgmentry.Button.Click;
end;

procedure TMainForm.btExecuteGOScriptClick(Sender: TObject);
begin
  if MessageDlg(dmMain.Text[9], mtConfirmation, mbYesNoCancel, -1) = mrYes then
    ExecuteScript(megoScript.Text, megoLog);
end;

procedure TMainForm.btCopyToClipboardGOClick(Sender: TObject);
begin
  megoScript.SelectAll;
  megoScript.CopyToClipboard;
  megoScript.SelStart := 0;
  megoScript.SelLength := 0;
end;

procedure TMainForm.tsGOInvolvedInShow(Sender: TObject);
begin
  LoadGOInvolvedIn(edgtentry.Text);
end;

procedure TMainForm.tsGOLootShow(Sender: TObject);
begin
  if (edgoentry.Text = '') then
    edgoentry.Text := edgtdata1.Text;
end;

procedure TMainForm.tsGOScriptShow(Sender: TObject);
begin
  case PageControl4.ActivePageIndex of
    1:
      CompleteGOScript;
    2:
      CompleteGOLocationScript;
    3:
      CompleteGOLootScript;
  end;
end;

procedure TMainForm.btNewGOClick(Sender: TObject);
begin
  lvSearchGO.Selected := nil;
  ClearFields(ttObject);
  SetDefaultFields(ttObject);
  PageControl4.ActivePageIndex := 1;
end;

procedure TMainForm.lvgbGOScriptChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btgbUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btgbDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvgtbGOTemplateScriptChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btgtbUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btgtbDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvgbGOScriptSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetScriptEditFields('edgb', lvgbGOScript);
end;

procedure TMainForm.lvgtbGOTemplateScriptSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetScriptEditFields('edgtb', lvgtbGOTemplateScript);
end;

procedure TMainForm.lvglGOLocationSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    LoadGOLocation(StrToIntDef(Item.Caption, 0));
end;

procedure TMainForm.lvdoeEventScriptChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btdoeUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btdoeDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvdoeEventScriptSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetScriptEditFields('eddoe', lvdoeEventScript);
end;

procedure TMainForm.lvdogGossipScriptChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btdogUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btdogDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvdogGossipScriptSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetScriptEditFields('eddog', lvdogGossipScript);
end;

procedure TMainForm.lvdosSpellScriptChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btdosUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btdosDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvdosSpellScriptSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetScriptEditFields('eddos', lvdosSpellScript);
end;

procedure TMainForm.lvdorRelayScriptChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btdorUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btdorDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvdorRelayScriptSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetScriptEditFields('eddor', lvdorRelayScript);
end;

procedure TMainForm.lvrtRandomScriptChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btrtUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btrtDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvrtRandomScriptSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetRandomTemplatesScriptEditFields('edrt', lvrtRandomScript);
end;

procedure TMainForm.LoadGOLocation(GUID: Integer);
begin
  if GUID < 1 then
    Exit;
  MyQuery.SQL.Text := Format('SELECT * FROM `gameobject` WHERE (`guid`=%d) LIMIT 1', [GUID]);
  MyQuery.Open;
  try
    FillFields(MyQuery, PFX_GAMEOBJECT);
    MyQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[90] + #10#13 + E.Message);
  end;
end;

procedure TMainForm.btScriptGOClick(Sender: TObject);
begin
  PageControl4.ActivePageIndex := SCRIPT_TAB_NO_GAMEOBJECT;
end;

procedure TMainForm.CompleteGameEventScript;
var
  entry, Fields, Values, s1, s2, s3, tmp: string;
  i: Integer;
begin
  if not Assigned(lvSearchGameEvent.Selected) then
    Exit;

  meotLog.Clear;
  entry := edgeentry.Text;
  if (entry = '') then
    Exit;
  SetFieldsAndValues(Fields, Values, 'game_event', PFX_GAME_EVENT, meotLog);
  case SyntaxStyle of
    ssInsertDelete:
      s1 := Format('DELETE FROM `game_event` WHERE (`entry`=%s);'#13#10 +
        'INSERT INTO `game_event` (%s) VALUES (%s);'#13#10, [entry, Fields, Values]);
    ssReplace:
      s1 := Format('REPLACE INTO `game_event` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      s1 := MakeUpdate('game_event', PFX_GAME_EVENT, false, 'entry', entry);
  end;

  s2 := Format('DELETE FROM `game_event_creature` WHERE abs(`event`) = %s;'#13#10, [entry]);
  s3 := Format('DELETE FROM `game_event_gameobject` WHERE abs(`event`) = %s;'#13#10, [entry]);

  if lvGameEventCreature.Items.Count > 0 then
  begin
    s2 := Format('%sINSERT INTO `game_event_creature` (`guid`, `event`) VALUES'#13#10, [s2]);
    for i := 0 to lvGameEventCreature.Items.Count - 1 do
    begin
      tmp := Format('(%s,%s)', [lvGameEventCreature.Items[i].Caption, lvGameEventCreature.Items[i].SubItems[0]]);
      if i <> lvGameEventCreature.Items.Count - 1 then
        tmp := tmp + ','#13#10
      else
        tmp := tmp + ';'#13#10;
      s2 := s2 + tmp;
    end;
  end;

  if lvGameEventGO.Items.Count > 0 then
  begin
    s3 := Format('%sINSERT INTO `game_event_gameobject` (`guid`, `event`) VALUES'#13#10, [s3]);
    for i := 0 to lvGameEventGO.Items.Count - 1 do
    begin
      tmp := Format('(%s,%s)', [lvGameEventGO.Items[i].Caption, lvGameEventGO.Items[i].SubItems[0]]);
      if i <> lvGameEventGO.Items.Count - 1 then
        tmp := tmp + ','#13#10
      else
        tmp := tmp + ';'#13#10;
      s3 := s3 + tmp;
    end;
  end;

  meotScript.Text := s1 + s2 + s3;
end;

procedure TMainForm.CompleteGOLocationScript;
var
  glguid, Fields, Values: string;
begin
  megoLog.Clear;
  glguid := edglguid.Text;
  if glguid = '' then
    Exit;
  SetFieldsAndValues(Fields, Values, 'gameobject', PFX_GAMEOBJECT, megoLog);
  case SyntaxStyle of
    ssInsertDelete:
      megoScript.Text := Format('DELETE FROM `gameobject` WHERE (`guid`=%s);'#13#10 +
        'INSERT INTO `gameobject` (%s) VALUES (%s);'#13#10, [glguid, Fields, Values]);
    ssReplace:
      megoScript.Text := Format('REPLACE INTO `gameobject` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      megoScript.Text := MakeUpdate('gameobject', PFX_GAMEOBJECT, false, 'guid', glguid);
  end;
end;

procedure TMainForm.CompleteGOLootScript;
var
  goentry, goitem, Fields, Values: string;
begin
  megoLog.Clear;
  goentry := edgoentry.Text;
  goitem := edgoitem.Text;
  if (goentry = '') or (goitem = '') then
    Exit;
  SetFieldsAndValues(Fields, Values, 'gameobject_loot_template', PFX_GAMEOBJECT_LOOT_TEMPLATE, megoLog);
  case SyntaxStyle of
    ssInsertDelete:
      megoScript.Text := Format('DELETE FROM `gameobject_loot_template` WHERE (`entry`=%s) AND (`item`=%s);'#13#10 +
      'INSERT INTO `gameobject_loot_template` (%s) VALUES (%s);'#13#10, [goentry, goitem, Fields, Values]);
    ssReplace:
      megoScript.Text := Format('REPLACE INTO `gameobject_loot_template` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      megoScript.Text := MakeUpdate2('gameobject_loot_template', PFX_GAMEOBJECT_LOOT_TEMPLATE, false, 'entry', goentry, 'item', goitem);
  end;
end;

procedure TMainForm.CompleteMailLootScript;
var
  mlentry, mlitem, Fields, Values: string;
begin
  meqtLog.Clear;
  mlentry := edmlentry.Text;
  mlitem := edmlitem.Text;
  if (mlentry = '') or (mlitem = '') then
    Exit;
  SetFieldsAndValues(Fields, Values, 'mail_loot_template', PFX_MAIL_LOOT_TEMPLATE, meqtLog);
  case SyntaxStyle of
    ssInsertDelete:
      meqtScript.Text := Format('DELETE FROM `mail_loot_template` WHERE (`entry`=%s) AND (`item`=%s);'#13#10 +
      'INSERT INTO `mail_loot_template` (%s) VALUES (%s);'#13#10, [mlentry, mlitem, Fields, Values]);
    ssReplace:
      meqtScript.Text := Format('REPLACE INTO `mail_loot_template` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      meqtScript.Text := MakeUpdate2('mail_loot_template', PFX_MAIL_LOOT_TEMPLATE, false, 'entry', mlentry, 'item', mlitem);
  end;
end;

procedure TMainForm.CompleteGreetingScript;
var
  entry, gr_type, Fields, Values: string;
begin
  entry := edqgEntry.Text;
  gr_type := edqgType.Text;
  if (entry = '') or (gr_type = '') then
    Exit;
  SetFieldsAndValues(Fields, Values, 'questgiver_greeting', PFX_QUESTGIVER_GREETING, meqtLog);
  case SyntaxStyle of
    ssInsertDelete:
      meqtScript.Text := Format('DELETE FROM `questgiver_greeting` WHERE (`Entry`=%s) AND (`Type`=%s);'#13#10 +
      'INSERT INTO `questgiver_greeting` (%s) VALUES (%s);'#13#10, [entry, gr_type, Fields, Values]);
    ssReplace:
      meqtScript.Text := Format('REPLACE INTO `questgiver_greeting` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      meqtScript.Text := MakeUpdate2('questgiver_greeting', PFX_QUESTGIVER_GREETING, false, 'Entry', entry, 'Type', gr_type);
  end;
  if edlqgText.Visible then
    meqtScript.Lines.Add(MakeUpdate2('locales_questgiver_greeting', PFX_LOC_QUESTGIVER_GREETING, true, 'Entry', entry, 'Type', gr_type));
end;

procedure TMainForm.lvgoGOLootSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetLootEditFields('edgo', lvgoGOLoot);
end;

procedure TMainForm.lvmlMailLootSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetLootEditFields('edml', lvmlMailLoot);
end;

procedure TMainForm.edgttypeButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 93, 'GameObjectType', false);
end;

procedure TMainForm.SetGOdataHints(t: Integer);
begin
  edgtdata0.Hint := dmMain.Text[94] + ' (data0)';
  edgtdata1.Hint := dmMain.Text[94] + ' (data1)';
  edgtdata2.Hint := dmMain.Text[94] + ' (data2)';
  edgtdata3.Hint := dmMain.Text[94] + ' (data3)';
  edgtdata4.Hint := dmMain.Text[94] + ' (data4)';
  edgtdata5.Hint := dmMain.Text[94] + ' (data5)';
  edgtdata6.Hint := dmMain.Text[94] + ' (data6)';
  edgtdata7.Hint := dmMain.Text[94] + ' (data7)';
  edgtdata8.Hint := dmMain.Text[94] + ' (data8)';
  edgtdata9.Hint := dmMain.Text[94] + ' (data9)';
  edgtdata10.Hint := dmMain.Text[94] + ' (data10)';
  edgtdata11.Hint := dmMain.Text[94] + ' (data11)';
  edgtdata12.Hint := dmMain.Text[94] + ' (data12)';
  edgtdata13.Hint := dmMain.Text[94] + ' (data13)';
  edgtdata14.Hint := dmMain.Text[94] + ' (data14)';
  edgtdata15.Hint := dmMain.Text[94] + ' (data15)';
  edgtdata16.Hint := dmMain.Text[94] + ' (data16)';
  edgtdata17.Hint := dmMain.Text[94] + ' (data17)';
  edgtdata18.Hint := dmMain.Text[94] + ' (data18)';
  edgtdata19.Hint := dmMain.Text[94] + ' (data19)';
  edgtdata20.Hint := dmMain.Text[94] + ' (data20)';
  edgtdata21.Hint := dmMain.Text[94] + ' (data21)';
  edgtdata22.Hint := dmMain.Text[94] + ' (data22)';
  edgtdata23.Hint := dmMain.Text[94] + ' (data23)';
  case t of
    0:
      begin
        edgtdata0.Hint := dmMain.Text[95] + ' (data0)';
        edgtdata1.Hint := dmMain.Text[96] + ' (data1)';
        edgtdata3.Hint := dmMain.Text[97] + ' (data3)';
      end;
    1:
      begin
        edgtdata0.Hint := dmMain.Text[95] + ' (data0)';
        edgtdata1.Hint := dmMain.Text[96] + ' (data1)';
        edgtdata3.Hint := dmMain.Text[98] + ' (data3)';
        edgtdata4.Hint := dmMain.Text[97] + ' (data4)';
        edgtdata5.Hint := dmMain.Text[97] + ' (data5)';
        edgtdata6.Hint := dmMain.Text[99] + ' (data6)';
        edgtdata7.Hint := dmMain.Text[99] + ' (data7)';
        edgtdata8.Hint := dmMain.Text[97] + ' (data8)';
      end;
    2:
      begin
        edgtdata0.Hint := dmMain.Text[96] + ' (data0)';
        edgtdata1.Hint := dmMain.Text[100] + ' (data1)';
        edgtdata2.Hint := dmMain.Text[172] + ' (data2)';
        edgtdata3.Hint := dmMain.Text[173] + ' (data3)';
        edgtdata4.Hint := dmMain.Text[174] + ' (data4)';
        edgtdata5.Hint := dmMain.Text[97] + ' (data5)';
        edgtdata6.Hint := dmMain.Text[99] + ' (data6)';
        edgtdata7.Hint := dmMain.Text[97] + ' (data7)';
        edgtdata8.Hint := dmMain.Text[97] + ' (data8)';
        edgtdata9.Hint := dmMain.Text[97] + ' (data9)';
      end;
    3:
      begin
        edgtdata0.Hint := dmMain.Text[96] + ' (data0)';
        edgtdata1.Hint := dmMain.Text[101] + ' (data1)';
        edgtdata2.Hint := dmMain.Text[102] + ' (data2)';
        edgtdata3.Hint := dmMain.Text[95] + ' (data3)';
        edgtdata4.Hint := dmMain.Text[103] + ' (data4)';
        edgtdata5.Hint := dmMain.Text[104] + ' (data5)';
        edgtdata6.Hint := dmMain.Text[100] + ' (data6)';
        edgtdata7.Hint := dmMain.Text[98] + ' (data7)';
        edgtdata8.Hint := dmMain.Text[105] + ' (data8)';
        edgtdata9.Hint := dmMain.Text[175] + ' (data9)';
        edgtdata10.Hint := dmMain.Text[97] + ' (data10)';
        edgtdata11.Hint := dmMain.Text[97] + ' (data11)';
        edgtdata12.Hint := dmMain.Text[97] + ' (data12)';
        edgtdata13.Hint := dmMain.Text[97] + ' (data13)';
        edgtdata14.Hint := dmMain.Text[100] + ' (data14)';
        edgtdata15.Hint := dmMain.Text[97] + ' (data15)';
      end;
    5:
      begin
        edgtdata0.Hint := dmMain.Text[97] + ' (data0)';
        edgtdata1.Hint := dmMain.Text[97] + ' (data1)';
        edgtdata2.Hint := dmMain.Text[176] + ' (data2)';
        edgtdata3.Hint := dmMain.Text[97] + ' (data3)';
        edgtdata4.Hint := dmMain.Text[97] + ' (data4)';
        edgtdata5.Hint := dmMain.Text[177] + ' (data5)';
      end;
    6:
      begin
        edgtdata0.Hint := dmMain.Text[96] + ' (data0)';
        edgtdata1.Hint := dmMain.Text[178] + ' (data1)';
        edgtdata3.Hint := dmMain.Text[107] + ' (data3)';
        edgtdata4.Hint := dmMain.Text[95] + ' ?' + ' (data4)';
        edgtdata5.Hint := dmMain.Text[102] + ' (data5)';
        edgtdata7.Hint := dmMain.Text[102] + ' (data7)';
        edgtdata8.Hint := dmMain.Text[176] + ' (data8)';
        edgtdata9.Hint := dmMain.Text[97] + ' (data9)';
        edgtdata10.Hint := dmMain.Text[97] + ' (data10)';
        edgtdata11.Hint := dmMain.Text[97] + ' (data11)';
        edgtdata12.Hint := dmMain.Text[100] + ' (data12)';
      end;
    7:
      begin
        edgtdata0.Hint := dmMain.Text[179] + ' (data0)';
      end;
    8:
      begin
        edgtdata0.Hint := dmMain.Text[113] + ' (data0)';
        edgtdata2.Hint := dmMain.Text[98] + ' (data2)';
      end;
    9:
      begin
        edgtdata0.Hint := dmMain.Text[114] + ' (data0)';
        edgtdata1.Hint := dmMain.Text[180] + ' (data1)';
        edgtdata2.Hint := dmMain.Text[115] + ' (data2)';
      end;
    10:
      begin
        edgtdata0.Hint := dmMain.Text[96] + ' (data0)';
        edgtdata1.Hint := dmMain.Text[177] + ' (data1)';
        edgtdata2.Hint := dmMain.Text[181] + ' (data2)';
        edgtdata5.Hint := dmMain.Text[182] + ' (data5)';
        edgtdata6.Hint := dmMain.Text[102] + ' (data6)';
        edgtdata7.Hint := dmMain.Text[114] + ' (data7)';
        edgtdata8.Hint := dmMain.Text[180] + ' (data8)';
        edgtdata9.Hint := dmMain.Text[115] + ' (data9)';
        edgtdata10.Hint := dmMain.Text[107] + ' (data10)';
        edgtdata11.Hint := dmMain.Text[97] + ' (data11)';
        edgtdata12.Hint := dmMain.Text[98] + ' (data12)';
        edgtdata13.Hint := dmMain.Text[97] + ' (data13)';
        edgtdata14.Hint := dmMain.Text[100] + ' (data14)';
        edgtdata15.Hint := dmMain.Text[100] + ' (data15)';
        edgtdata16.Hint := dmMain.Text[97] + ' (data16)';
        edgtdata19.Hint := dmMain.Text[173] + ' (data19)';
      end;
	13:
	  begin
	    edgtdata0.Hint := dmMain.Text[96] + ' (data0)';
        edgtdata1.Hint := dmMain.Text[183] + ' (data1)';
	  end;
	15:
	  begin
	    edgtdata0.Hint := dmMain.Text[184] + ' (data0)';
      end;
    18:
      begin
        edgtdata1.Hint := dmMain.Text[107] + ' (data1)';
        edgtdata2.Hint := dmMain.Text[107] + ' (data2)';
        edgtdata3.Hint := dmMain.Text[97] + ' (data3)';
        edgtdata4.Hint := dmMain.Text[107] + ' (data4)';
        edgtdata5.Hint := dmMain.Text[97] + ' (data5)';
        edgtdata6.Hint := dmMain.Text[97] + ' (data6)';
      end;
    22:
      begin
        edgtdata0.Hint := dmMain.Text[107] + ' (data0)';
        edgtdata2.Hint := dmMain.Text[185] + ' (data2)';
      end;
    23:
      begin
        edgtdata2.Hint := dmMain.Text[186] + ' (data2)';
      end;
    24:
      begin
        edgtdata0.Hint := dmMain.Text[96] + ' (data0)';
        edgtdata1.Hint := dmMain.Text[107] + ' (data1)';
        edgtdata2.Hint := dmMain.Text[106] + ' (data2)';
        edgtdata3.Hint := dmMain.Text[107] + ' (data3)';
        edgtdata4.Hint := dmMain.Text[107] + ' (data4)';
        edgtdata5.Hint := dmMain.Text[97] + ' (data5)';
        edgtdata7.Hint := dmMain.Text[97] + ' (data7)';
      end;
    25:
      begin
        edgtdata0.Hint := dmMain.Text[106] + ' (data0)';
        edgtdata1.Hint := dmMain.Text[101] + ' (data1)';
        edgtdata4.Hint := dmMain.Text[96] + ' (data4)';
      end;
    26:
      begin
        edgtdata0.Hint := dmMain.Text[96] + ' (data0)';
        edgtdata1.Hint := dmMain.Text[111] + ' (data1)';
        edgtdata2.Hint := dmMain.Text[107] + ' (data2)';
        edgtdata3.Hint := dmMain.Text[97] + ' (data3)';
      end;
	29:
      begin
        edgtdata0.Hint := dmMain.Text[106] + ' (data0)';
        edgtdata1.Hint := dmMain.Text[187] + ' (data1)';
        edgtdata4.Hint := dmMain.Text[111] + ' (data4)';
        edgtdata5.Hint := dmMain.Text[111] + ' (data5)';
        edgtdata6.Hint := dmMain.Text[111] + ' (data6)';
        edgtdata7.Hint := dmMain.Text[111] + ' (data7)';
        edgtdata8.Hint := dmMain.Text[111] + ' (data8)';
        edgtdata9.Hint := dmMain.Text[111] + ' (data9)';
        edgtdata10.Hint := dmMain.Text[111] + ' (data10)';
        edgtdata11.Hint := dmMain.Text[111] + ' (data11)';
        edgtdata16.Hint := dmMain.Text[102] + ' (data16)';
        edgtdata17.Hint := dmMain.Text[102] + ' (data17)';
        edgtdata18.Hint := dmMain.Text[97] + ' (data18)';
      end;
	30:
      begin
        edgtdata0.Hint := dmMain.Text[97] + ' (data0)';
        edgtdata1.Hint := dmMain.Text[106] + ' (data1)';
        edgtdata2.Hint := dmMain.Text[107] + ' (data2)';
        edgtdata3.Hint := dmMain.Text[100] + ' (data3)';
        edgtdata4.Hint := dmMain.Text[107] + ' (data4)';
        edgtdata5.Hint := dmMain.Text[100] + ' (data5)';
      end;
    31:
      begin
        edgtdata0.Hint := dmMain.Text[188] + ' (data0)';
        edgtdata1.Hint := dmMain.Text[189] + ' (data1)';
      end;
  end;
end;

procedure TMainForm.edgttypeChange(Sender: TObject);
begin
  SetGOdataHints(StrToIntDef(edgttype.Text, 0));
  SetGOdataNames(StrToIntDef(edgttype.Text, 0));
end;

procedure TMainForm.edhtdataButtonClick(Sender: TObject);
var
  f: TCharacterDataForm;
begin
  if Trim(TCustomEdit(Sender).Text) = '' then
    Exit;

  f := TCharacterDataForm.Create(Self);
  try
    f.Data := TCustomEdit(Sender).Text;
    if f.ShowModal = mrOk then
    begin
      TCustomEdit(Sender).Text := f.Data;
    end;
  finally
    f.Free;
  end;
end;

procedure TMainForm.edhtguidButtonClick(Sender: TObject);
begin
  LoadCharacter(StrToIntDef(TCustomEdit(Sender).Text, 0));
end;

procedure TMainForm.edhttaximaskButtonClick(Sender: TObject);
var
  f: TTaxiMaskForm;
begin
  if Trim(TCustomEdit(Sender).Text) = '' then
    Exit;

  f := TTaxiMaskForm.Create(Self);
  try
    f.Data := TCustomEdit(Sender).Text;
    if f.ShowModal = mrOk then
    begin
      TCustomEdit(Sender).Text := f.Data;
    end;
  finally
    f.Free;
  end;
end;

procedure TMainForm.SetFieldsAndValues(Query: TZQuery; var Fields: string; var Values: string; TableName: string;
  pfx: string; Log: TMemo);
var
  FieldName, tmp: string;
  c: TComponent;
  i: Integer;
  FieldFound: Boolean;
begin
  Query.SQL.Text := Format('SELECT * FROM `%s` LIMIT 1', [TableName]);
  Query.Open;
  for i := 0 to Query.Fields.Count - 1 do
  begin
    FieldName := Query.Fields[i].FieldName;
    FieldFound := true;
    c := FindComponent('ed' + pfx + FieldName);
    if Assigned(c) and (c is TCustomEdit) then
    begin
      tmp := SymToDoll(TCustomEdit(c).Text);
      tmp := StringReplace(tmp, '''', '\''', [rfReplaceAll]);

      // if tmp is not number
      if not IsNumber(tmp) then
      begin
        if Values = '' then
          Values := Format('''%s''', [tmp])
        else
          Values := Format('%s, ''%s''', [Values, tmp]);
      end
      else
      begin
        if Values = '' then
          Values := Format('%s', [tmp])
        else
          Values := Format('%s, %s', [Values, tmp]);
      end
    end
    else
    begin
      c := FindComponent('cb' + pfx + FieldName);
      if Assigned(c) and (c is TCheckBox) then
      begin
        if TCheckBox(c).Checked then
          tmp := '1'
        else
          tmp := '0';
        if Values = '' then
          Values := Format('%s', [tmp])
        else
          Values := Format('%s, %s', [Values, tmp]);
      end
      else
      begin
        Log.Lines.Add(Format(dmMain.Text[8], [FieldName]));
        // 'Warning: There is no one component assigned to field `%s`. It will assigned to default value if it has one.'
        FieldFound := false;
      end;
    end;
    if FieldFound then
    begin
      if Fields = '' then
        Fields := Format('`%s`', [FieldName])
      else
        Fields := Format('%s, `%s`', [Fields, FieldName]);
    end;
  end;
  Query.Close;
end;

procedure TMainForm.FillFields(Query: TZQuery; pfx: string);
var
  i, j: Integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if (Components[i] is TCustomEdit) then
      for j := 0 to Query.Fields.Count - 1 do
        if LowerCase(Components[i].Name) = 'ed' + pfx + LowerCase(Query.Fields[j].FieldName) then
        begin
          if pfx = PFX_NPC_TEXT then
            TCustomEdit(Components[i]).Text := Query.Fields[j].AsString
          else
            TCustomEdit(Components[i]).Text := DollToSym(Query.Fields[j].AsString);
        end;
    if Components[i] is TCheckBox then
      for j := 0 to Query.Fields.Count - 1 do
        if LowerCase(Components[i].Name) = 'cb' + pfx + LowerCase(Query.Fields[j].FieldName) then
          TCheckBox(Components[i]).Checked := (Query.Fields[j].AsInteger <> 0);
  end;
end;

procedure TMainForm.LoadQueryToListView(strQuery: string; ListView: TJvListView);
begin
  LoadMyQueryToListView(MyQuery, strQuery, ListView);
end;

procedure TMainForm.LoadLoot(var lvList: TJvListView; Key: string);
var
  i, LastColumn: Integer;
  id: string;
  table: string;
  S: string;

  procedure QueryResult_AddToList;
  var
    i: Integer;
  begin
    MyQuery.Open;
    while not MyQuery.Eof do
    begin
      for i := 0 to MyQuery.FieldCount - 1 do
        lvList.Columns[i].Caption := MyQuery.Fields[i].FieldName;
      with lvList.Items.Add do
      begin
        Caption := MyQuery.Fields[0].AsString;
        for i := 1 to MyQuery.FieldCount - 1 do
          SubItems.Add(MyQuery.Fields[i].AsString);
      end;
      MyQuery.Next;
    end;
    MyQuery.Close;
  end;

begin
  lvList.Items.BeginUpdate;
  lvList.SortType := stNone;
  try
    lvList.Clear;
    // load creature loot
    MyQuery.SQL.Text := Format('SELECT *, ' +
      '''creature_loot_template'' as `table` ' + 'FROM `creature_loot_template` WHERE (`item`=%s)', [Key]);
    QueryResult_AddToList;

    // load gameobject loot
    MyQuery.SQL.Text := Format('SELECT *, ' +
      '''gameobject_loot_template'' as `table` ' + 'FROM `gameobject_loot_template` WHERE (`item`=%s)', [Key]);
    QueryResult_AddToList;

    // load item loot
    MyQuery.SQL.Text := Format('SELECT *,  ' +
      '''item_loot_template'' as `table` ' + 'FROM `item_loot_template` WHERE (`item`=%s)', [Key]);
    QueryResult_AddToList;

    // load pickpocketing loot
    MyQuery.SQL.Text := Format('SELECT *,  ' +
      '''pickpocketing_loot_template'' as `table` ' + 'FROM `pickpocketing_loot_template` WHERE (`item`=%s)', [Key]);
    QueryResult_AddToList;

    // load skinning loot
    MyQuery.SQL.Text := Format('SELECT *,  ' +
      '''skinning_loot_template'' as `table` ' + 'FROM `skinning_loot_template` WHERE (`item`=%s)', [Key]);
    QueryResult_AddToList;

    // load enchanting loot
    MyQuery.SQL.Text := Format('SELECT *,  ' +
      '''disenchant_loot_template'' as `table` ' + 'FROM `disenchant_loot_template` WHERE (`item`=%s)', [Key]);
    QueryResult_AddToList;

    // load fishing loot
    MyQuery.SQL.Text := Format('SELECT *,  ' +
      '''fishing_loot_template'' as `table` ' + 'FROM `fishing_loot_template` WHERE (`item`=%s)', [Key]);
    QueryResult_AddToList;

    // load prospecting loot
    MyQuery.SQL.Text := Format('SELECT *,  ' +
      '''prospecting_loot_template'' as `table` ' + 'FROM `prospecting_loot_template` WHERE (`item`=%s)', [Key]);
    QueryResult_AddToList;

    // load milling loot
    MyQuery.SQL.Text := Format('SELECT *,  ' +
      '''milling_loot_template'' as `table` ' + 'FROM `milling_loot_template` WHERE (`item`=%s)', [Key]);
    QueryResult_AddToList;

    // load reference loot
    MyQuery.SQL.Text := Format('SELECT *,  ' +
      '''reference_loot_template'' as `table` ' + 'FROM `reference_loot_template` WHERE (`item`=%s)', [Key]);
    QueryResult_AddToList;

    // load mail loot
    MyQuery.SQL.Text := Format('SELECT *,  ' +
      '''mail_loot_template'' as `table` ' + 'FROM `mail_loot_template` WHERE (`item`=%s)', [Key]);
    QueryResult_AddToList;

    // load spell loot
    MyQuery.SQL.Text := Format('SELECT *,  ' +
      '''spell_loot_template'' as `table` ' + 'FROM `spell_loot_template` WHERE (`item`=%s)', [Key]);
    QueryResult_AddToList;

    // load npc_vendor
    MyQuery.SQL.Text := Format('SELECT `entry`, `item`,  '''' as `ChanceOrQuestChance`, ' +
      ''''' as `groupid`, '''' as `mincountOrRef`, `maxcount`, ' +
      '`condition_id`, `comments`, ''npc_vendor'' as `table` '
      + 'FROM `npc_vendor` WHERE (`item`=%s)', [Key]);
    QueryResult_AddToList;
  finally
    lvList.Items.EndUpdate;
  end;

  LastColumn := 9;

  if lvList.Items.Count = 0 then
    Exit;
  lvList.Columns[LastColumn].Caption := 'name';
  lvList.Columns[LastColumn].Width := 150;
  lvList.Columns[LastColumn-1].Width := 150;
  for i := 0 to lvList.Items.Count - 1 do
  begin
    id := lvList.Items[i].Caption;
    table := lvList.Items[i].SubItems[LastColumn-2];
    MyQuery.SQL.Text := '';
    if table = 'creature_loot_template' then
      MyQuery.SQL.Text := Format('SELECT `Name` FROM `creature_template` WHERE `LootId` = %s', [id]);
    if table = 'item_loot_template' then
      MyQuery.SQL.Text := Format('SELECT `name` FROM `item_template` WHERE `entry` = %s LIMIT 1', [id]);
    if table = 'prospecting_loot_template' then
      MyQuery.SQL.Text := Format('SELECT `name` FROM `item_template` WHERE `entry` = %s LIMIT 1', [id]);
    if table = 'milling_loot_template' then
      MyQuery.SQL.Text := Format('SELECT `name` FROM `item_template` WHERE `entry` = %s LIMIT 1', [id]);
    if table = 'disenchant_loot_template' then
      MyQuery.SQL.Text := Format('SELECT `name` FROM `item_template` WHERE `DisenchantID` = %s', [id]);
    if table = 'spell_loot_template' then
      MyQuery.SQL.Text := Format('SELECT `name` FROM `item_template` WHERE `entry` = %s LIMIT 1', [id]);
    if table = 'npc_vendor' then
      MyQuery.SQL.Text := Format('SELECT `Name` FROM `creature_template` WHERE `Entry` = %s LIMIT 1', [id]);
    if table = 'gameobject_loot_template' then
      MyQuery.SQL.Text := Format('SELECT `name` FROM `gameobject_template` WHERE `data1` = %s', [id]);
    if table = 'mail_loot_template' then
      MyQuery.SQL.Text := Format('SELECT `Title` FROM `quest_template` WHERE `RewMailTemplateId` = %s', [id]);
    if table = 'pickpocketing_loot_template' then
      MyQuery.SQL.Text := Format('SELECT `Name` FROM `creature_template` WHERE `PickpocketLootId` = %s', [id]);
    if table = 'skinning_loot_template' then
      MyQuery.SQL.Text := Format('SELECT `Name` FROM `creature_template` WHERE `SkinningLootId` = %s', [id]);
    if (MyQuery.SQL.Text <> '') then
    begin
      MyQuery.Open;
      S := '';
      while not MyQuery.Eof do
      begin
        S := Format('%s, %s', [MyQuery.Fields[0].AsString, S]);
        MyQuery.Next;
      end;
      S := MidStr(S, 1, length(S) - 2);
      lvList.Items[i].SubItems.Add(S);
      MyQuery.Close;
      Application.ProcessMessages;
    end;
  end;
  lvList.SortType := stBoth;
end;

procedure TMainForm.LoadNPCgossip(GUID: Integer);
begin
  if GUID < 1 then
    Exit;
  MyQuery.SQL.Text := Format('SELECT * FROM `npc_gossip` WHERE (`npc_guid` = %d) LIMIT 1', [GUID]);
  MyQuery.Open;
  try
    FillFields(MyQuery, PFX_NPC_GOSSIP);
    MyQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[144] + #10#13 + E.Message);
  end;
end;

procedure TMainForm.LoadNPCText(TextId: string);
begin
  if Trim(TextId) = '' then
    TextId := '-1';
  MyQuery.SQL.Text := Format('SELECT * FROM `npc_text` WHERE (`ID` = %s) LIMIT 1', [TextId]);
  MyQuery.Open;
  try
    FillFields(MyQuery, PFX_NPC_TEXT);
    MyQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[145] + #10#13 + E.Message);
  end;
end;

procedure TMainForm.pmSiteClick(Sender: TObject);
var
  lvList: TJvListView;
  par: TType;
begin
  lvList := lvQuest;
  par := ttQuest;
  if TBitBtn(TPopupMenu(TMenuItem(Sender).GetParentComponent).PopupComponent).Name = 'btBrowseCreaturePopup' then
  begin
    lvList := lvSearchCreature;
    par := ttNPC;
  end;
  if TBitBtn(TPopupMenu(TMenuItem(Sender).GetParentComponent).PopupComponent).Name = 'btBrowseQuestPopup' then
  begin
    lvList := lvQuest;
    par := ttQuest;
  end;
  if TBitBtn(TPopupMenu(TMenuItem(Sender).GetParentComponent).PopupComponent).Name = 'btBrowseGOPopup' then
  begin
    lvList := lvSearchGO;
    par := ttObject;
  end;
  if TBitBtn(TPopupMenu(TMenuItem(Sender).GetParentComponent).PopupComponent).Name = 'btBrowseItemPopup' then
  begin
    lvList := lvSearchItem;
    par := ttItem;
  end;
  if Assigned(lvList) and Assigned(lvList.Selected) then
  begin
    if TMenuItem(Sender).Name = 'pmwowhead' then
      dmMain.wowhead(par, StrToInt(lvList.Selected.Caption));
    if TMenuItem(Sender).Name = 'pmruwowhead' then
      dmMain.ruwowhead(par, StrToInt(lvList.Selected.Caption));
    if TMenuItem(Sender).Name = 'pmallakhazam' then
      dmMain.allakhazam(par, StrToInt(lvList.Selected.Caption));
    if TMenuItem(Sender).Name = 'pmthottbot' then
      dmMain.thottbot(par, StrToInt(lvList.Selected.Caption));
    if TMenuItem(Sender).Name = 'pmwowdb' then
      dmMain.wowdb(par, StrToInt(lvList.Selected.Caption));
  end;
end;

procedure TMainForm.QLPrepare;
var
  i, cnt: Integer;
  p: TPoint;
begin
  cnt := lvQuickList.Items.Count;

  if Trim(edit.Text) <> '' then
  begin
    for i := 0 to cnt - 1 do
    begin
      if lvQuickList.Items[i].Caption = edit.Text then
      begin
        lvQuickList.Selected := lvQuickList.Items[i];
        lvQuickList.Selected.MakeVisible(false);
        break;
      end;
    end;
  end;

  lvQuickList.OnMouseMove := lvQuickListMouseMove;
  lvQuickList.OnClick := lvQuickListClick;
  lvQuickList.OnKeyDown := lvQuickListKeyDown;

  lvQuickList.Height := 16 * cnt + 12;
  p := edit.ClientToScreen(Point(0, edit.Height));
  p := lvQuickList.ScreenToClient(p);
  lvQuickList.Left := p.X;
  lvQuickList.Top := p.Y + 1;
  if lvQuickList.Top + lvQuickList.Height > lvQuickList.Parent.Height then
    lvQuickList.Top := p.Y - lvQuickList.Height - edit.Height - 1;
end;

procedure TMainForm.lvcvNPCVendorSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
  begin
    with TJvListView(Sender).Selected do
    begin
      edcventry.Text := Caption;
      edcvitem.Text := SubItems[0];
      edcvmaxcount.Text := SubItems[1];
      edcvincrtime.Text := SubItems[2];
      edcvExtendedCost.Text := SubItems[3];
      edcvcondition_id.Text := SubItems[4];
      edcvcomments.Text := SubItems[5];
    end;
  end;
end;

procedure TMainForm.lvcvtNPCVendorChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btVendorTemplateUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btVendorTemplateDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvcvtNPCVendorSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
  begin
    with TJvListView(Sender).Selected do
    begin
      edcvtentry.Text := Caption;
      edcvtitem.Text := SubItems[0];
      edcvtmaxcount.Text := SubItems[1];
      edcvtincrtime.Text := SubItems[2];
      edcvtExtendedCost.Text := SubItems[3];
      edcvtcondition_id.Text := SubItems[4];
      edcvtcomments.Text := SubItems[5];
    end;
  end;
end;

procedure TMainForm.lvcrNPCTrainerSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
  begin
    with TJvListView(Sender).Selected do
    begin
      edcrentry.Text := Caption;
      edcrspell.Text := SubItems[0];
      edcrspellcost.Text := SubItems[1];
      edcrreqskill.Text := SubItems[2];
      edcrreqskillvalue.Text := SubItems[3];
      edcrreqlevel.Text := SubItems[4];
      edcrcondition_id.Text := SubItems[5];
    end;
  end;
end;

procedure TMainForm.lvcrtNPCTrainerChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btTrainerTemplateUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btTrainerTemplateDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvcrtNPCTrainerSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
  begin
    with TJvListView(Sender).Selected do
    begin
      edcrtentry.Text := Caption;
      edcrtspell.Text := SubItems[0];
      edcrtspellcost.Text := SubItems[1];
      edcrtreqskill.Text := SubItems[2];
      edcrtreqskillvalue.Text := SubItems[3];
      edcrtreqlevel.Text := SubItems[4];
      edcrtcondition_id.Text := SubItems[5];
    end;
  end;
end;

function TMainForm.MakeUpdate(tn: string; pfx: string; IsLocale : boolean; KeyName: string; KeyValue: string): string;
begin
  MyTempQuery.SQL.Text := Format('SELECT * FROM `%s` WHERE `%s` = %s', [tn, KeyName, KeyValue]);
  Result := MakeSetForUpdate(MyTempQuery, pfx, IsLocale);
  if Result <> '' then
      Result := Format('UPDATE `%s` %s WHERE `%s` = %s;', [tn, Result, KeyName, KeyValue])
end;

function TMainForm.MakeUpdate2(tn: string; pfx: string; IsLocale : boolean; KeyName1: string; KeyValue1: string; KeyName2: string; KeyValue2: string): string;
begin
  MyTempQuery.SQL.Text := Format('SELECT * FROM `%s` WHERE `%s` = %s AND `%s` = %s', [tn, KeyName1, KeyValue1, KeyName2, KeyValue2]);
  Result := MakeSetForUpdate(MyTempQuery, pfx, IsLocale);
  if Result <> '' then
      Result := Format('UPDATE `%s` %s WHERE `%s` = %s AND `%s` = %s;', [tn, Result, KeyName1, KeyValue1, KeyName2, KeyValue2])
end;

function TMainForm.MakeUpdate3(tn: string; pfx: string; IsLocale : boolean; KeyName1: string; KeyValue1: string; KeyName2: string; KeyValue2: string; KeyName3: string; KeyValue3: string): string;
begin
  MyTempQuery.SQL.Text := Format('SELECT * FROM `%s` WHERE `%s` = %s AND `%s` = %s AND `%s` = %s', [tn, KeyName1, KeyValue1, KeyName2, KeyValue2, KeyName3, KeyValue3]);
  Result := MakeSetForUpdate(MyTempQuery, pfx, IsLocale);
  if Result <> '' then
      Result := Format('UPDATE `%s` %s WHERE `%s` = %s AND `%s` = %s AND `%s` = %s;', [tn, Result, KeyName1, KeyValue1, KeyName2, KeyValue2, KeyName3, KeyValue3])
end;

function TMainForm.MakeSetForUpdate(MyTempQuery: TZQuery; pfx: string; IsLocale : boolean): string;
var
  i: Integer;
  FieldName, ValueFromBase, ValueFromEdit, loc, FN: string;
  c: TComponent;
begin
  if IsLocale then
    loc := LoadLocales()
  else
    loc := '';
  Result := '';
  MyTempQuery.Open;
  if not MyTempQuery.Eof then
  begin
    for i := 0 to MyTempQuery.Fields.Count - 1 do
    begin
      FieldName := MyTempQuery.Fields[i].FieldName;
      ValueFromBase := MyTempQuery.Fields[i].AsString;
      FN := StringReplace(FieldName, loc, '', [rfReplaceAll]);
      c := FindComponent('ed' + pfx + FN);
      if Assigned(c) and (c is TCustomEdit) then
      begin
        ValueFromEdit := SymToDoll(TCustomEdit(c).Text);
        if ValueFromEdit <> ValueFromBase then
        begin
          if not IsNumber(ValueFromEdit) then
            ValueFromEdit := QuotedStr(ValueFromEdit);
          if Result = '' then
            Result := Format('SET `%s` = %s', [FieldName, ValueFromEdit])
          else
            Result := Format('%s, `%s` = %s', [Result, FieldName, ValueFromEdit]);
        end;
      end
      else
      begin
        c := FindComponent('cb' + pfx + FN);
        if Assigned(c) and (c is TCheckBox) then
        begin
          if TCheckBox(c).Checked then
            ValueFromEdit := '1'
          else
            ValueFromEdit := '0';
          if ValueFromEdit <> ValueFromBase then
          begin
            if Result = '' then
              Result := Format('SET `%s` = %s', [FieldName, ValueFromEdit])
            else
              Result := Format('%s, `%s` = %s', [Result, FieldName, ValueFromEdit]);
          end;
        end;
      end;
    end;
  end;
  MyTempQuery.Close;
end;

procedure TMainForm.MvmntAdd(pfx: string; lvList: TJvListView);
begin
  with lvList.Items.Add do
  begin
    if (pfx = 'edcm') then
      Caption := TCustomEdit(FindComponent(pfx + 'id')).Text
    else if (pfx = 'edcmt') then
	begin
      Caption := TCustomEdit(FindComponent(pfx + 'entry')).Text;
      SubItems.Add(TCustomEdit(FindComponent(pfx + 'pathId')).Text);
	end;
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'point')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'position_x')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'position_y')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'position_z')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'orientation')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'waittime')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'script_id')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'comment')).Text);
  end;
end;

procedure TMainForm.MvmntUpd(pfx: string; lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      if (pfx = 'edcm') then
	  begin
        Caption := TCustomEdit(FindComponent(pfx + 'id')).Text;
        SubItems[0] := TCustomEdit(FindComponent(pfx + 'point')).Text;
        SubItems[1] := TCustomEdit(FindComponent(pfx + 'position_x')).Text;
        SubItems[2] := TCustomEdit(FindComponent(pfx + 'position_y')).Text;
        SubItems[3] := TCustomEdit(FindComponent(pfx + 'position_z')).Text;
        SubItems[4] := TCustomEdit(FindComponent(pfx + 'orientation')).Text;
        SubItems[5] := TCustomEdit(FindComponent(pfx + 'waittime')).Text;
        SubItems[6] := TCustomEdit(FindComponent(pfx + 'script_id')).Text;
        SubItems[7] := TCustomEdit(FindComponent(pfx + 'comment')).Text;
      end
      else if (pfx = 'edcmt') then
	  begin
        Caption := TCustomEdit(FindComponent(pfx + 'entry')).Text;
        SubItems[0] := TCustomEdit(FindComponent(pfx + 'pathId')).Text;
        SubItems[1] := TCustomEdit(FindComponent(pfx + 'point')).Text;
        SubItems[2] := TCustomEdit(FindComponent(pfx + 'position_x')).Text;
        SubItems[3] := TCustomEdit(FindComponent(pfx + 'position_y')).Text;
        SubItems[4] := TCustomEdit(FindComponent(pfx + 'position_z')).Text;
        SubItems[5] := TCustomEdit(FindComponent(pfx + 'orientation')).Text;
        SubItems[6] := TCustomEdit(FindComponent(pfx + 'waittime')).Text;
        SubItems[7] := TCustomEdit(FindComponent(pfx + 'script_id')).Text;
        SubItems[8] := TCustomEdit(FindComponent(pfx + 'comment')).Text;
	  end;
    end;
  end;
end;

procedure TMainForm.MvmntDel(lvList: TJvListView);
begin
  LootDel(lvList);
end;

procedure TMainForm.EventAIAdd(pfx: string; lvList: TJvListView);
begin
  with lvList.Items.Add do
  begin
    Caption := TCustomEdit(FindComponent(pfx + 'id')).Text;
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'creature_id')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_type')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_inverse_phase_mask')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_chance')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_flags')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_param1')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_param2')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_param3')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_param4')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_param5')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_param6')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action1_type')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action1_param1')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action1_param2')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action1_param3')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action2_type')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action2_param1')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action2_param2')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action2_param3')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action3_type')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action3_param1')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action3_param2')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action3_param3')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'comment')).Text);
  end;
end;

procedure TMainForm.EventAIUpd(pfx: string; lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      Caption := TCustomEdit(FindComponent(pfx + 'id')).Text;
      SubItems[0] := TCustomEdit(FindComponent(pfx + 'creature_id')).Text;
      SubItems[1] := TCustomEdit(FindComponent(pfx + 'event_type')).Text;
      SubItems[2] := TCustomEdit(FindComponent(pfx + 'event_inverse_phase_mask')).Text;
      SubItems[3] := TCustomEdit(FindComponent(pfx + 'event_chance')).Text;
      SubItems[4] := TCustomEdit(FindComponent(pfx + 'event_flags')).Text;
      SubItems[5] := TCustomEdit(FindComponent(pfx + 'event_param1')).Text;
      SubItems[6] := TCustomEdit(FindComponent(pfx + 'event_param2')).Text;
      SubItems[7] := TCustomEdit(FindComponent(pfx + 'event_param3')).Text;
      SubItems[8] := TCustomEdit(FindComponent(pfx + 'event_param4')).Text;
      SubItems[9] := TCustomEdit(FindComponent(pfx + 'event_param5')).Text;
      SubItems[10] := TCustomEdit(FindComponent(pfx + 'event_param6')).Text;
      SubItems[11] := TCustomEdit(FindComponent(pfx + 'action1_type')).Text;
      SubItems[12] := TCustomEdit(FindComponent(pfx + 'action1_param1')).Text;
      SubItems[13] := TCustomEdit(FindComponent(pfx + 'action1_param2')).Text;
      SubItems[14] := TCustomEdit(FindComponent(pfx + 'action1_param3')).Text;
      SubItems[15] := TCustomEdit(FindComponent(pfx + 'action2_type')).Text;
      SubItems[16] := TCustomEdit(FindComponent(pfx + 'action2_param1')).Text;
      SubItems[17] := TCustomEdit(FindComponent(pfx + 'action2_param2')).Text;
      SubItems[18] := TCustomEdit(FindComponent(pfx + 'action2_param3')).Text;
      SubItems[19] := TCustomEdit(FindComponent(pfx + 'action3_type')).Text;
      SubItems[20] := TCustomEdit(FindComponent(pfx + 'action3_param1')).Text;
      SubItems[21] := TCustomEdit(FindComponent(pfx + 'action3_param2')).Text;
      SubItems[22] := TCustomEdit(FindComponent(pfx + 'action3_param3')).Text;
      SubItems[23] := TCustomEdit(FindComponent(pfx + 'comment')).Text;
    end;
  end;
end;

procedure TMainForm.EventAIDel(lvList: TJvListView);
begin
  LootDel(lvList);
end;

procedure TMainForm.btCreatureLootAddClick(Sender: TObject);
begin
  LootAdd('edco', lvcoCreatureLoot);
end;

procedure TMainForm.btCreatureLootUpdClick(Sender: TObject);
begin
  LootUpd('edco', lvcoCreatureLoot);
end;

procedure TMainForm.btCreatureModelSearchClick(Sender: TObject);
begin
  SearchCreatureModelInfo();
  with lvCreatureModelSearch do
    if Items.Count > 0 then
    begin
      SetFocus;
      Selected := Items[0];
    end;
end;

procedure TMainForm.btCreatureMvmntAddClick(Sender: TObject);
begin
  if (StrToIntDef(edcmid.Text, 0) < 1) then
    Exit;
  if (StrToIntDef(edcmpoint.Text, 0) < 1) then
    edcmpoint.Text := '1';
  if (StrToIntDef(edcmpoint.Text, 0) = 1) then
  begin
    edcmposition_x.Text := edclposition_x.Text;
    edcmposition_y.Text := edclposition_y.Text;
    edcmposition_z.Text := edclposition_z.Text;
    edcmorientation.Text := edclorientation.Text;
  end;
  if (edcmwaittime.Text = '') then
    edcmwaittime.Text := '0';
  if (edcmscript_id.Text = '') then
    edcmscript_id.Text := '0';
  MvmntAdd('edcm', lvcmMovement);
end;

procedure TMainForm.btCreatureMvmntDelClick(Sender: TObject);
begin
  MvmntDel(lvcmMovement);
end;

procedure TMainForm.btCreatureMvmntUpdClick(Sender: TObject);
begin
  MvmntUpd('edcm', lvcmMovement);
end;

procedure TMainForm.btCreatureMvmntTemplateAddClick(Sender: TObject);
begin
  if (StrToIntDef(edcmtentry.Text, 0) < 1) then
    Exit;
  if (StrToIntDef(edcmtpathId.Text, 0) < 0) then
    Exit;
  if (StrToIntDef(edcmtpoint.Text, 0) < 1) then
    edcmtpoint.Text := '1';
  if (StrToIntDef(edcmtpoint.Text, 0) = 1) then
  begin
    edcmtposition_x.Text := edclposition_x.Text;
    edcmtposition_y.Text := edclposition_y.Text;
    edcmtposition_z.Text := edclposition_z.Text;
    edcmtorientation.Text := edclorientation.Text;
  end;
  if (edcmtwaittime.Text = '') then
    edcmtwaittime.Text := '0';
  if (edcmtscript_id.Text = '') then
    edcmtscript_id.Text := '0';
  MvmntAdd('edcmt', lvcmtMovement);
end;

procedure TMainForm.btCreatureMvmntTemplateDelClick(Sender: TObject);
begin
  MvmntDel(lvcmtMovement);
end;

procedure TMainForm.btCreatureMvmntTemplateUpdClick(Sender: TObject);
begin
  MvmntUpd('edcmt', lvcmtMovement);
end;

procedure TMainForm.btCreatureLootDelClick(Sender: TObject);
begin
  LootDel(lvcoCreatureLoot);
end;

procedure TMainForm.LootAdd(pfx: string; lvList: TJvListView);
begin
  with lvList.Items.Add do
  begin
    Caption := TCustomEdit(FindComponent(pfx + 'entry')).Text;
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'item')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'ChanceOrQuestChance')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'groupid')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'mincountOrRef')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'maxcount')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'condition_id')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'comments')).Text);
  end;
end;

procedure TMainForm.LootUpd(pfx: string; lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      Caption := TCustomEdit(FindComponent(pfx + 'entry')).Text;
      SubItems[0] := TCustomEdit(FindComponent(pfx + 'item')).Text;
      SubItems[1] := TCustomEdit(FindComponent(pfx + 'ChanceOrQuestChance')).Text;
      SubItems[2] := TCustomEdit(FindComponent(pfx + 'groupid')).Text;
      SubItems[3] := TCustomEdit(FindComponent(pfx + 'mincountOrRef')).Text;
      SubItems[4] := TCustomEdit(FindComponent(pfx + 'maxcount')).Text;
      SubItems[5] := TCustomEdit(FindComponent(pfx + 'condition_id')).Text;
      SubItems[6] := TCustomEdit(FindComponent(pfx + 'comments')).Text;
    end;
  end;
end;

procedure TMainForm.LootDel(lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
    lvList.DeleteSelected;
end;

procedure TMainForm.SetLootEditFields(pfx: string; lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      TCustomEdit(FindComponent(pfx + 'entry')).Text := Caption;
      TCustomEdit(FindComponent(pfx + 'item')).Text := SubItems[0];
      TCustomEdit(FindComponent(pfx + 'ChanceOrQuestChance')).Text := SubItems[1];
      TCustomEdit(FindComponent(pfx + 'groupid')).Text := SubItems[2];
      TCustomEdit(FindComponent(pfx + 'mincountOrRef')).Text := SubItems[3];
      TCustomEdit(FindComponent(pfx + 'maxcount')).Text := SubItems[4];
      TCustomEdit(FindComponent(pfx + 'condition_id')).Text := SubItems[5];
      TCustomEdit(FindComponent(pfx + 'comments')).Text := SubItems[6];
    end;
  end;
end;

procedure TMainForm.SetMvmntEditFields(pfx: string; lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      if (pfx = 'edcm') then
	  begin
        TCustomEdit(FindComponent(pfx + 'id')).Text := Caption;
        TCustomEdit(FindComponent(pfx + 'point')).Text := SubItems[0];
        TCustomEdit(FindComponent(pfx + 'position_x')).Text := SubItems[1];
        TCustomEdit(FindComponent(pfx + 'position_y')).Text := SubItems[2];
        TCustomEdit(FindComponent(pfx + 'position_z')).Text := SubItems[3];
        TCustomEdit(FindComponent(pfx + 'orientation')).Text := SubItems[4];
        TCustomEdit(FindComponent(pfx + 'waittime')).Text := SubItems[5];
        TCustomEdit(FindComponent(pfx + 'script_id')).Text := SubItems[6];
        TCustomEdit(FindComponent(pfx + 'comment')).Text := SubItems[7];
      end
      else if (pfx = 'edcmt') then
	  begin
        TCustomEdit(FindComponent(pfx + 'entry')).Text := Caption;
        TCustomEdit(FindComponent(pfx + 'pathId')).Text := SubItems[0];
        TCustomEdit(FindComponent(pfx + 'point')).Text := SubItems[1];
        TCustomEdit(FindComponent(pfx + 'position_x')).Text := SubItems[2];
        TCustomEdit(FindComponent(pfx + 'position_y')).Text := SubItems[3];
        TCustomEdit(FindComponent(pfx + 'position_z')).Text := SubItems[4];
        TCustomEdit(FindComponent(pfx + 'orientation')).Text := SubItems[5];
        TCustomEdit(FindComponent(pfx + 'waittime')).Text := SubItems[6];
        TCustomEdit(FindComponent(pfx + 'script_id')).Text := SubItems[7];
        TCustomEdit(FindComponent(pfx + 'comment')).Text := SubItems[8];
	  end;
    end;
  end;
end;

procedure TMainForm.SetEventAIEditFields(pfx: string; lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      TCustomEdit(FindComponent(pfx + 'id')).Text := Caption;
      TCustomEdit(FindComponent(pfx + 'creature_id')).Text := SubItems[0];
      TCustomEdit(FindComponent(pfx + 'event_type')).Text := SubItems[1];
      TCustomEdit(FindComponent(pfx + 'event_inverse_phase_mask')).Text := SubItems[2];
      TCustomEdit(FindComponent(pfx + 'event_chance')).Text := SubItems[3];
      TCustomEdit(FindComponent(pfx + 'event_flags')).Text := SubItems[4];
      TCustomEdit(FindComponent(pfx + 'event_param1')).Text := SubItems[5];
      TCustomEdit(FindComponent(pfx + 'event_param2')).Text := SubItems[6];
      TCustomEdit(FindComponent(pfx + 'event_param3')).Text := SubItems[7];
      TCustomEdit(FindComponent(pfx + 'event_param4')).Text := SubItems[8];
      TCustomEdit(FindComponent(pfx + 'event_param5')).Text := SubItems[9];
      TCustomEdit(FindComponent(pfx + 'event_param6')).Text := SubItems[10];
      TCustomEdit(FindComponent(pfx + 'action1_type')).Text := SubItems[11];
      TCustomEdit(FindComponent(pfx + 'action1_param1')).Text := SubItems[12];
      TCustomEdit(FindComponent(pfx + 'action1_param2')).Text := SubItems[13];
      TCustomEdit(FindComponent(pfx + 'action1_param3')).Text := SubItems[14];
      TCustomEdit(FindComponent(pfx + 'action2_type')).Text := SubItems[15];
      TCustomEdit(FindComponent(pfx + 'action2_param1')).Text := SubItems[16];
      TCustomEdit(FindComponent(pfx + 'action2_param2')).Text := SubItems[17];
      TCustomEdit(FindComponent(pfx + 'action2_param3')).Text := SubItems[18];
      TCustomEdit(FindComponent(pfx + 'action3_type')).Text := SubItems[19];
      TCustomEdit(FindComponent(pfx + 'action3_param1')).Text := SubItems[20];
      TCustomEdit(FindComponent(pfx + 'action3_param2')).Text := SubItems[21];
      TCustomEdit(FindComponent(pfx + 'action3_param3')).Text := SubItems[22];
      TCustomEdit(FindComponent(pfx + 'comment')).Text := SubItems[23];
    end;
  end;
end;

procedure TMainForm.btFullScriptCreatureLocationClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
  mectScript.Text := FullScript('creature', 'id', edctEntry.Text);
end;

function TMainForm.FullScript(TableName, KeyName, KeyValue: string): string;
var
  i: Integer;
  s1, s2, s3, s4: string;
begin
  if Trim(KeyValue) = '' then
    Exit;

  s1 := Format('DELETE FROM `%s` WHERE `%s`=%s;'#13#10, [TableName, KeyName, KeyValue]);
  MyQuery.SQL.Text := Format('SELECT * FROM `%s` WHERE `%s`=%s', [TableName, KeyName, KeyValue]);
  MyQuery.Open;
  if not MyQuery.Eof then
  begin
    s2 := Format('`%s`', [MyQuery.Fields[0].FieldName]);
    for i := 1 to MyQuery.FieldCount - 1 do
      s2 := Format('%s,`%s`', [s2, MyQuery.Fields[i].FieldName]);

    s4 := '';
    while not MyQuery.Eof do
    begin
      s3 := Format('%s', [MyQuery.Fields[0].AsString]);
      for i := 1 to MyQuery.FieldCount - 1 do
      begin
        if IsNumber(MyQuery.Fields[i].AsString) then
          s3 := Format('%s, %s', [s3, MyQuery.Fields[i].AsString])
        else
          s3 := Format('%s, ''%s''', [s3, MyQuery.Fields[i].AsString]);
      end;
      MyQuery.Next;
      if MyQuery.Eof then
        s4 := Format('%s(%s);'#13#10, [s4, s3])
      else
        s4 := Format('%s(%s),'#13#10, [s4, s3]);
    end;
  end;
  MyQuery.Close;
  Result := Format('%sINSERT INTO `%s` (%s) VALUES'#13#10'%s', [s1, TableName, s2, s4]);
end;

procedure TMainForm.btFullScriptCreatureLootClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
  ShowFullLootScript('creature_loot_template', lvcoCreatureLoot, mectScript, edctLootId.Text);
end;

procedure TMainForm.ShowFullLootScript(TableName: string; lvList: TJvListView; memo: TMemo; entry: string);
var
  i: Integer;
  Values: string;
begin
  memo.Clear;
  Values := '';
  if lvList.Items.Count <> 0 then
  begin
    for i := 0 to lvList.Items.Count - 2 do
    begin
      Values := Values + Format('(%s, %s, %s, %s, %s, %s, %s),'#13#10,
        [lvList.Items[i].Caption, lvList.Items[i].SubItems[0], lvList.Items[i].SubItems[1], lvList.Items[i].SubItems[2],
        lvList.Items[i].SubItems[3], lvList.Items[i].SubItems[4], lvList.Items[i].SubItems[5]]);
    end;
    i := lvList.Items.Count - 1;
    Values := Values + Format('(%s, %s, %s, %s, %s, %s, %s);',
      [lvList.Items[i].Caption, lvList.Items[i].SubItems[0], lvList.Items[i].SubItems[1], lvList.Items[i].SubItems[2],
      lvList.Items[i].SubItems[3], lvList.Items[i].SubItems[4], lvList.Items[i].SubItems[5]]);
  end;
  if Values <> '' then
  begin
    memo.Text := Format('DELETE FROM `%0:s` WHERE (`entry`=%1:s);'#13#10 + 'INSERT INTO `%0:s` VALUES '#13#10'%2:s',
      [TableName, entry, Values]);
  end
  else
    memo.Text := Format('DELETE FROM `%s` WHERE (`entry`=%s);', [TableName, entry]);
end;

procedure TMainForm.ShowFullEventAiScript(TableName: string; lvList: TJvListView; memo: TMemo; entry: string);
var
  i: Integer;
  Values: string;
begin
  memo.Clear;
  Values := '';
  if lvList.Items.Count <> 0 then
  begin
    for i := 0 to lvList.Items.Count - 2 do
    begin
      Values := Values +
        Format('( %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, ' + '''' +
        '%s' + '''' + '),'#13#10, [lvList.Items[i].Caption, lvList.Items[i].SubItems[0], lvList.Items[i].SubItems[1],
        lvList.Items[i].SubItems[2], lvList.Items[i].SubItems[3], lvList.Items[i].SubItems[4],
        lvList.Items[i].SubItems[5], lvList.Items[i].SubItems[6], lvList.Items[i].SubItems[7],
        lvList.Items[i].SubItems[8], lvList.Items[i].SubItems[9], lvList.Items[i].SubItems[10],
        lvList.Items[i].SubItems[11], lvList.Items[i].SubItems[12], lvList.Items[i].SubItems[13],
        lvList.Items[i].SubItems[14], lvList.Items[i].SubItems[15], lvList.Items[i].SubItems[16],
        lvList.Items[i].SubItems[17], lvList.Items[i].SubItems[18], lvList.Items[i].SubItems[19],
        lvList.Items[i].SubItems[20], lvList.Items[i].SubItems[21]]);
    end;
    i := lvList.Items.Count - 1;
    Values := Values +
      Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, ' + '''' + '%s' +
      '''' + ');', [lvList.Items[i].Caption, lvList.Items[i].SubItems[0], lvList.Items[i].SubItems[1],
      lvList.Items[i].SubItems[2], lvList.Items[i].SubItems[3], lvList.Items[i].SubItems[4],
      lvList.Items[i].SubItems[5], lvList.Items[i].SubItems[6], lvList.Items[i].SubItems[7],
      lvList.Items[i].SubItems[8], lvList.Items[i].SubItems[9], lvList.Items[i].SubItems[10],
      lvList.Items[i].SubItems[11], lvList.Items[i].SubItems[12], lvList.Items[i].SubItems[13],
      lvList.Items[i].SubItems[14], lvList.Items[i].SubItems[15], lvList.Items[i].SubItems[16],
      lvList.Items[i].SubItems[17], lvList.Items[i].SubItems[18], lvList.Items[i].SubItems[19],
      lvList.Items[i].SubItems[20], lvList.Items[i].SubItems[21]]);
  end;
  if Values <> '' then
  begin
    memo.Text := Format('DELETE FROM `%0:s` WHERE (`creature_id`=%1:s);'#13#10 +
      'INSERT INTO `%0:s` VALUES '#13#10'%2:s', [TableName, entry, Values]);
  end
  else
    memo.Text := Format('DELETE FROM `%s` WHERE (`creature_id`=%s);', [TableName, entry]);
end;

procedure TMainForm.btPickpocketLootAddClick(Sender: TObject);
begin
  LootAdd('edcp', lvcoPickpocketLoot);
end;

procedure TMainForm.btPickpocketLootUpdClick(Sender: TObject);
begin
  LootUpd('edcp', lvcoPickpocketLoot);
end;

procedure TMainForm.btPickpocketLootDelClick(Sender: TObject);
begin
  LootDel(lvcoPickpocketLoot);
end;

procedure TMainForm.btFullScriptPickpocketLootClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
  ShowFullLootScript('pickpocketing_loot_template', lvcoPickpocketLoot, mectScript, edctPickpocketLootId.Text);
end;

procedure TMainForm.btSkinLootAddClick(Sender: TObject);
begin
  LootAdd('edcs', lvcoSkinLoot);
end;

procedure TMainForm.btSkinLootUpdClick(Sender: TObject);
begin
  LootUpd('edcs', lvcoSkinLoot);
end;

procedure TMainForm.btSkinLootDelClick(Sender: TObject);
begin
  LootDel(lvcoSkinLoot);
end;

procedure TMainForm.btFullScriptSkinLootClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
  ShowFullLootScript('skinning_loot_template', lvcoSkinLoot, mectScript, edctSkinningLootId.Text);
end;

procedure TMainForm.btGOLootAddClick(Sender: TObject);
begin
  LootAdd('edgo', lvgoGOLoot);
end;

procedure TMainForm.btGOLootUpdClick(Sender: TObject);
begin
  LootUpd('edgo', lvgoGOLoot);
end;

procedure TMainForm.btMailLootAddClick(Sender: TObject);
begin
  LootAdd('edml', lvmlMailLoot);
end;

procedure TMainForm.btMailLootUpdClick(Sender: TObject);
begin
  LootUpd('edml', lvmlMailLoot);
end;

procedure TMainForm.btGossipMenuOptionAddClick(Sender: TObject);
var
  i: integer;
  FieldName : string;
  Ctrl: TComponent;
begin
  with lvcgmOptions.Items.Add do
  begin
    for i := 0 to lvcgmOptions.Columns.Count - 1 do
    begin
      FieldName := lvcgmOptions.Columns[i].Caption;
      Ctrl := FindComponent('ed'+ PFX_CREATURE_GOSSIP_MENU_OPTION + FieldName);
      if Assigned(Ctrl) and (Ctrl is TCustomEdit) then
      begin
        if i = 0 then
          Caption := TCustomEdit(Ctrl).Text
        else
          SubItems.Add(TCustomEdit(Ctrl).Text);
      end
      else
        SubItems.Add('');
    end;
  end;
end;

procedure TMainForm.btGossipMenuOptionDelClick(Sender: TObject);
begin
  if Assigned(lvcgmOptions.Selected) then
    lvcgmOptions.DeleteSelected;
end;

procedure TMainForm.btGossipMenuOptionUpdClick(Sender: TObject);
var
  i: integer;
  FieldName : string;
  Ctrl: TComponent;
begin
  for i := 0 to lvcgmOptions.Columns.Count - 1 do
  begin
    FieldName := lvcgmOptions.Columns[i].Caption;
    Ctrl := FindComponent('ed'+ PFX_CREATURE_GOSSIP_MENU_OPTION + FieldName);
    if Assigned(Ctrl) and (Ctrl is TCustomEdit) then
    begin
      if i = 0 then
        lvcgmOptions.Selected.Caption := TCustomEdit(Ctrl).Text
      else
        lvcgmOptions.Selected.SubItems[i-1] := TCustomEdit(Ctrl).Text;
    end;
  end;
end;

procedure TMainForm.btGOLootDelClick(Sender: TObject);
begin
  LootDel(lvgoGOLoot);
end;

procedure TMainForm.btMailLootDelClick(Sender: TObject);
begin
  LootDel(lvmlMailLoot);
end;

procedure TMainForm.btFullScriptGOLootClick(Sender: TObject);
begin
  PageControl4.ActivePageIndex := SCRIPT_TAB_NO_GAMEOBJECT;
  ShowFullLootScript('gameobject_loot_template', lvgoGOLoot, megoScript, edgtdata1.Text);
end;

procedure TMainForm.btVendorAddClick(Sender: TObject);
begin
  with lvcvNPCVendor.Items.Add do
  begin
    Caption := edcventry.Text;
    SubItems.Add(edcvitem.Text);
    SubItems.Add(edcvmaxcount.Text);
    SubItems.Add(edcvincrtime.Text);
    SubItems.Add(edcvExtendedCost.Text);
    SubItems.Add(edcvcondition_id.Text);
    SubItems.Add(edcvcomments.Text);
  end;
end;

procedure TMainForm.btVendorUpdClick(Sender: TObject);
begin
  if Assigned(lvcvNPCVendor.Selected) then
  begin
    with lvcvNPCVendor.Selected do
    begin
      Caption := edcventry.Text;
      SubItems[0] := edcvitem.Text;
      SubItems[1] := edcvmaxcount.Text;
      SubItems[2] := edcvincrtime.Text;
      SubItems[3] := edcvExtendedCost.Text;
      SubItems[4] := edcvcondition_id.Text;
      SubItems[5] := edcvcomments.Text;
    end;
  end;
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
  ShowFullEventAiScript('creature_ai_scripts', lvcnEventAI, mectScript, edctEntry.Text);
end;

procedure TMainForm.btFullScriptReferenceLootClick(Sender: TObject);
begin
  PageControl5.ActivePageIndex := SCRIPT_TAB_NO_ITEM;
  ShowFullLootScript('reference_loot_template', lvitReferenceLoot, meitScript, edirentry.Text);
end;

procedure TMainForm.btFullScriptSpellLootClick(Sender: TObject);
begin
  PageControl5.ActivePageIndex := SCRIPT_TAB_NO_ITEM;
  ShowFullLootScript('spell_loot_template', lvslSpellLoot, meitScript, edslentry.Text);
end;

procedure TMainForm.btShowCharacterScriptClick(Sender: TObject);
begin
  PageControl8.ActivePageIndex := SCRIPT_TAB_NO_CHARACTER;
end;

procedure TMainForm.btShowFULLCharacterInventoryScriptClick(Sender: TObject);
begin
  PageControl8.ActivePageIndex := SCRIPT_TAB_NO_CHARACTER;
  // ShowFullLootScript('item_loot_template', lvitItemLoot, meitScript, editentry.Text);
end;

procedure TMainForm.btShowGossipMenuOptionsScriptClick(Sender: TObject);
var
  i: Integer;
  menu_id, Values: string;
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
  menu_id := edcgmentry.Text;
  mectScript.Clear;
  Values := '';
  if lvcgmOptions.Items.Count <> 0 then
  begin
    for i := 0 to lvcgmOptions.Items.Count - 2 do
    begin
      Values := Values +
        Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s),'#13#10, [
        lvcgmOptions.Items[i].Caption, lvcgmOptions.Items[i].SubItems[0], lvcgmOptions.Items[i].SubItems[1],
        QuotedStr(lvcgmOptions.Items[i].SubItems[2]), lvcgmOptions.Items[i].SubItems[3], lvcgmOptions.Items[i].SubItems[4],
        lvcgmOptions.Items[i].SubItems[5], lvcgmOptions.Items[i].SubItems[6], lvcgmOptions.Items[i].SubItems[7],
        lvcgmOptions.Items[i].SubItems[8], lvcgmOptions.Items[i].SubItems[9], QuotedStr(lvcgmOptions.Items[i].SubItems[10]),
        lvcgmOptions.Items[i].SubItems[11], lvcgmOptions.Items[i].SubItems[12], lvcgmOptions.Items[i].SubItems[13],
        lvcgmOptions.Items[i].SubItems[14], lvcgmOptions.Items[i].SubItems[15], lvcgmOptions.Items[i].SubItems[16],
        lvcgmOptions.Items[i].SubItems[17], lvcgmOptions.Items[i].SubItems[18], lvcgmOptions.Items[i].SubItems[19],
        lvcgmOptions.Items[i].SubItems[20]]);
  end;
    i := lvcgmOptions.Items.Count - 1;
      Values := Values +
        Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);'#13#10, [
        lvcgmOptions.Items[i].Caption, lvcgmOptions.Items[i].SubItems[0], lvcgmOptions.Items[i].SubItems[1],
        QuotedStr(lvcgmOptions.Items[i].SubItems[2]), lvcgmOptions.Items[i].SubItems[3], lvcgmOptions.Items[i].SubItems[4],
        lvcgmOptions.Items[i].SubItems[5], lvcgmOptions.Items[i].SubItems[6], lvcgmOptions.Items[i].SubItems[7],
        lvcgmOptions.Items[i].SubItems[8], lvcgmOptions.Items[i].SubItems[9], QuotedStr(lvcgmOptions.Items[i].SubItems[10]),
        lvcgmOptions.Items[i].SubItems[11], lvcgmOptions.Items[i].SubItems[12], lvcgmOptions.Items[i].SubItems[13],
        lvcgmOptions.Items[i].SubItems[14], lvcgmOptions.Items[i].SubItems[15], lvcgmOptions.Items[i].SubItems[16],
        lvcgmOptions.Items[i].SubItems[17], lvcgmOptions.Items[i].SubItems[18], lvcgmOptions.Items[i].SubItems[19],
        lvcgmOptions.Items[i].SubItems[20]]);
  end;
  if Values <> '' then
  begin
    mectScript.Text := Format('DELETE FROM `gossip_menu_option` WHERE (`menu_id`=%s);'#13#10 +
      'INSERT INTO `gossip_menu_option` (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, '+
      'action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text, '+
      'cond_1, cond_1_val_1, cond_1_val_2, cond_2, cond_2_val_1, cond_2_val_2, cond_3, cond_3_val_1, cond_3_val_2, '+
      'condition_id) VALUES '#13#10'%s',
      [menu_id, Values])
  end
  else
    mectScript.Text := Format('DELETE FROM `gossip_menu_option` WHERE (`menu_id`=%s);', [menu_id]);
end;

procedure TMainForm.btFullCreatureMovementScriptClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
  mectScript.Text := FullMvmntScript(lvcmMovement, 'creature_movement', edcmid.Text);
end;

procedure TMainForm.btFullCreatureMvmntTemplateScriptClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
  mectScript.Text := FullMvmntTmplScript(lvcmtMovement, 'creature_movement_template', edcmtentry.Text);
end;

procedure TMainForm.btFullScriptGOLocationClick(Sender: TObject);
begin
  PageControl4.ActivePageIndex := SCRIPT_TAB_NO_GAMEOBJECT;
  megoScript.Text := FullScript('gameobject', 'id', edgtentry.Text);
end;

procedure TMainForm.btVendorDelClick(Sender: TObject);
begin
  if Assigned(lvcvNPCVendor.Selected) then
    lvcvNPCVendor.DeleteSelected;
end;

procedure TMainForm.btVendorTemplateAddClick(Sender: TObject);
begin
  with lvcvtNPCVendor.Items.Add do
  begin
    Caption := edcvtentry.Text;
    SubItems.Add(edcvtitem.Text);
    SubItems.Add(edcvtmaxcount.Text);
    SubItems.Add(edcvtincrtime.Text);
    SubItems.Add(edcvtExtendedCost.Text);
    SubItems.Add(edcvtcondition_id.Text);
    SubItems.Add(edcvtcomments.Text);
  end;
end;

procedure TMainForm.btVendorTemplateDelClick(Sender: TObject);
begin
  if Assigned(lvcvtNPCVendor.Selected) then
    lvcvtNPCVendor.DeleteSelected;
end;

procedure TMainForm.btVendorTemplateUpdClick(Sender: TObject);
begin
  if Assigned(lvcvtNPCVendor.Selected) then
  begin
    with lvcvtNPCVendor.Selected do
    begin
      Caption := edcvtentry.Text;
      SubItems[0] := edcvtitem.Text;
      SubItems[1] := edcvtmaxcount.Text;
      SubItems[2] := edcvtincrtime.Text;
      SubItems[3] := edcvtExtendedCost.Text;
      SubItems[4] := edcvtcondition_id.Text;
      SubItems[5] := edcvtcomments.Text;
    end;
  end;
end;

procedure TMainForm.btFullScriptVendorClick(Sender: TObject);
var
  i: Integer;
  entry, Values: string;
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
  entry := edctEntry.Text;
  mectScript.Clear;
  Values := '';
  if lvcvNPCVendor.Items.Count <> 0 then
  begin
    for i := 0 to lvcvNPCVendor.Items.Count - 2 do
    begin
      Values := Values + Format('(%s, %s, %s, %s, %s, %s, %s),'#13#10, [lvcvNPCVendor.Items[i].Caption,
        lvcvNPCVendor.Items[i].SubItems[0], lvcvNPCVendor.Items[i].SubItems[1], lvcvNPCVendor.Items[i].SubItems[2],
        lvcvNPCVendor.Items[i].SubItems[3], lvcvNPCVendor.Items[i].SubItems[4], lvcvNPCVendor.Items[i].SubItems[5]]);
    end;
    i := lvcvNPCVendor.Items.Count - 1;
    Values := Values + Format('(%s, %s, %s, %s, %s, %s, %s);', [lvcvNPCVendor.Items[i].Caption,
      lvcvNPCVendor.Items[i].SubItems[0], lvcvNPCVendor.Items[i].SubItems[1], lvcvNPCVendor.Items[i].SubItems[2],
      lvcvNPCVendor.Items[i].SubItems[3], lvcvNPCVendor.Items[i].SubItems[4], lvcvNPCVendor.Items[i].SubItems[5]]);
  end;
  if Values <> '' then
  begin
    mectScript.Text := Format('DELETE FROM `npc_vendor` WHERE (`entry`=%s);'#13#10 +
      'INSERT INTO `npc_vendor` (entry, item, maxcount, incrtime, ExtendedCost, condition_id, comments) VALUES '#13#10'%s', [entry, Values])
  end
  else
    mectScript.Text := Format('DELETE FROM `npc_vendor` WHERE (`entry`=%s);', [entry]);
end;

procedure TMainForm.btFullScriptVendorTemplateClick(Sender: TObject);
var
  i: Integer;
  entry, Values: string;
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
  entry := edctVendorTemplateId.Text;
  mectScript.Clear;
  Values := '';
  if lvcvtNPCVendor.Items.Count <> 0 then
  begin
    for i := 0 to lvcvtNPCVendor.Items.Count - 2 do
    begin
      Values := Values + Format('(%s, %s, %s, %s, %s, %s, %s),'#13#10, [lvcvtNPCVendor.Items[i].Caption,
        lvcvtNPCVendor.Items[i].SubItems[0], lvcvtNPCVendor.Items[i].SubItems[1], lvcvtNPCVendor.Items[i].SubItems[2],
        lvcvtNPCVendor.Items[i].SubItems[3], lvcvtNPCVendor.Items[i].SubItems[4], lvcvtNPCVendor.Items[i].SubItems[5]]);
    end;
    i := lvcvtNPCVendor.Items.Count - 1;
    Values := Values + Format('(%s, %s, %s, %s, %s, %s, %s);', [lvcvtNPCVendor.Items[i].Caption,
      lvcvtNPCVendor.Items[i].SubItems[0], lvcvtNPCVendor.Items[i].SubItems[1], lvcvtNPCVendor.Items[i].SubItems[2],
      lvcvtNPCVendor.Items[i].SubItems[3], lvcvtNPCVendor.Items[i].SubItems[4], lvcvtNPCVendor.Items[i].SubItems[5]]);
  end;
  if Values <> '' then
  begin
    mectScript.Text := Format('DELETE FROM `npc_vendor_template` WHERE (`entry`=%s);'#13#10 +
      'INSERT INTO `npc_vendor_template` (entry, item, maxcount, incrtime, ExtendedCost, condition_id, comments) VALUES '#13#10'%s',
      [entry, Values])
  end
  else
    mectScript.Text := Format('DELETE FROM `npc_vendor_template` WHERE (`entry`=%s);', [entry]);
end;

procedure TMainForm.lvcvNPCVendorChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btVendorUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btVendorDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvcoSkinLootChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btSkinLootUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btSkinLootDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvcoPickpocketLootChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btPickpocketLootUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btPickpocketLootDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvcoCreatureLootChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btCreatureLootUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btCreatureLootDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvcoCreatureLootDblClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 3;
  PageControl5.ActivePageIndex := 1;
  LoadItem(StrToIntDef(TJvListView(Sender).Selected.SubItems[0], 0));
end;

procedure TMainForm.lvgoGOLootChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btGOLootUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btGOLootDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvmlMailLootChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btMailLootUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btMailLootDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.btTrainerAddClick(Sender: TObject);
begin
  with lvcrNPCTrainer.Items.Add do
  begin
    Caption := edcrentry.Text;
    SubItems.Add(edcrspell.Text);
    SubItems.Add(edcrspellcost.Text);
    SubItems.Add(edcrreqskill.Text);
    SubItems.Add(edcrreqskillvalue.Text);
    SubItems.Add(edcrreqlevel.Text);
    SubItems.Add(edcrcondition_id.Text);
  end;
end;

procedure TMainForm.btTrainerUpdClick(Sender: TObject);
begin
  if Assigned(lvcrNPCTrainer.Selected) then
  begin
    with lvcrNPCTrainer.Selected do
    begin
      Caption := edcrentry.Text;
      SubItems[0] := edcrspell.Text;
      SubItems[1] := edcrspellcost.Text;
      SubItems[2] := edcrreqskill.Text;
      SubItems[3] := edcrreqskillvalue.Text;
      SubItems[4] := edcrreqlevel.Text;
      SubItems[5] := edcrcondition_id.Text;
    end;
  end;
end;

procedure TMainForm.btTrainerDelClick(Sender: TObject);
begin
  if Assigned(lvcrNPCTrainer.Selected) then
    lvcrNPCTrainer.DeleteSelected;
end;

procedure TMainForm.btTrainerTemplateAddClick(Sender: TObject);
begin
  with lvcrtNPCTrainer.Items.Add do
  begin
    Caption := edcrtentry.Text;
    SubItems.Add(edcrtspell.Text);
    SubItems.Add(edcrtspellcost.Text);
    SubItems.Add(edcrtreqskill.Text);
    SubItems.Add(edcrtreqskillvalue.Text);
    SubItems.Add(edcrtreqlevel.Text);
    SubItems.Add(edcrtcondition_id.Text);
  end;
end;

procedure TMainForm.btTrainerTemplateDelClick(Sender: TObject);
begin
  if Assigned(lvcrtNPCTrainer.Selected) then
    lvcrtNPCTrainer.DeleteSelected;
end;

procedure TMainForm.btTrainerTemplateUpdClick(Sender: TObject);
begin
  if Assigned(lvcrtNPCTrainer.Selected) then
  begin
    with lvcrtNPCTrainer.Selected do
    begin
      Caption := edcrtentry.Text;
      SubItems[0] := edcrtspell.Text;
      SubItems[1] := edcrtspellcost.Text;
      SubItems[2] := edcrtreqskill.Text;
      SubItems[3] := edcrtreqskillvalue.Text;
      SubItems[4] := edcrtreqlevel.Text;
      SubItems[4] := edcrtcondition_id.Text;
    end;
  end;
end;

procedure TMainForm.btFullScriptTrainerClick(Sender: TObject);
var
  i: Integer;
  entry, Values: string;
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
  entry := edctEntry.Text;
  mectScript.Clear;
  Values := '';
  if lvcrNPCTrainer.Items.Count <> 0 then
  begin
    for i := 0 to lvcrNPCTrainer.Items.Count - 2 do
    begin
      Values := Values + Format('(%s, %s, %s, %s, %s, %s, %s),'#13#10, [lvcrNPCTrainer.Items[i].Caption,
        lvcrNPCTrainer.Items[i].SubItems[0], lvcrNPCTrainer.Items[i].SubItems[1], lvcrNPCTrainer.Items[i].SubItems[2],
        lvcrNPCTrainer.Items[i].SubItems[3], lvcrNPCTrainer.Items[i].SubItems[4], lvcrNPCTrainer.Items[i].SubItems[5]]);
    end;
    i := lvcrNPCTrainer.Items.Count - 1;
    Values := Values + Format('(%s, %s, %s, %s, %s, %s, %s);', [lvcrNPCTrainer.Items[i].Caption,
      lvcrNPCTrainer.Items[i].SubItems[0], lvcrNPCTrainer.Items[i].SubItems[1], lvcrNPCTrainer.Items[i].SubItems[2],
      lvcrNPCTrainer.Items[i].SubItems[3], lvcrNPCTrainer.Items[i].SubItems[4], lvcrNPCTrainer.Items[i].SubItems[5]]);
  end;
  if Values <> '' then
  begin
    mectScript.Text := Format('DELETE FROM `npc_trainer` WHERE (`entry`=%s);'#13#10 +
      'INSERT INTO `npc_trainer` (entry, spell, spellcost, reqskill, reqskillvalue, reqlevel, condition_id) VALUES '#13#10'%s',
      [entry, Values])
  end
  else
    mectScript.Text := Format('DELETE FROM `npc_trainer` WHERE (`entry`=%s);', [entry]);
end;

procedure TMainForm.btFullScriptTrainerTemplateClick(Sender: TObject);
var
  i: Integer;
  entry, Values: string;
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
  entry := edcrtentry.Text;
  mectScript.Clear;
  Values := '';
  if lvcrtNPCTrainer.Items.Count <> 0 then
  begin
    for i := 0 to lvcrtNPCTrainer.Items.Count - 2 do
    begin
      Values := Values + Format('(%s, %s, %s, %s, %s, %s, %s),'#13#10, [lvcrtNPCTrainer.Items[i].Caption,
        lvcrtNPCTrainer.Items[i].SubItems[0], lvcrtNPCTrainer.Items[i].SubItems[1],
        lvcrtNPCTrainer.Items[i].SubItems[2], lvcrtNPCTrainer.Items[i].SubItems[3],
        lvcrtNPCTrainer.Items[i].SubItems[4], lvcrtNPCTrainer.Items[i].SubItems[5]]);
    end;
    i := lvcrtNPCTrainer.Items.Count - 1;
    Values := Values + Format('(%s, %s, %s, %s, %s, %s, %s);', [lvcrtNPCTrainer.Items[i].Caption,
      lvcrtNPCTrainer.Items[i].SubItems[0], lvcrtNPCTrainer.Items[i].SubItems[1], lvcrtNPCTrainer.Items[i].SubItems[2],
      lvcrtNPCTrainer.Items[i].SubItems[3], lvcrtNPCTrainer.Items[i].SubItems[4], lvcrtNPCTrainer.Items[i].SubItems[5]]);
  end;
  if Values <> '' then
  begin
    mectScript.Text := Format('DELETE FROM `npc_trainer_template` WHERE (`entry`=%s);'#13#10 +
      'INSERT INTO `npc_trainer_template` (entry, spell, spellcost, reqskill, reqskillvalue, reqlevel, condition_id) VALUES '#13#10'%s',
      [entry, Values])
  end
  else
    mectScript.Text := Format('DELETE FROM `npc_trainer_template` WHERE (`entry`=%s);', [entry]);
end;

procedure TMainForm.lvcrNPCTrainerChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btTrainerUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btTrainerDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.edSearchItemChange(Sender: TObject);
begin
  btEditItem.Default := false;
  btSearchItem.Default := true;
end;

procedure TMainForm.btClearSearchItemClick(Sender: TObject);
begin
  edSearchItemEntry.Clear;
  edSearchItemName.Clear;
  edSearchItemClass.Clear;
  edSearchItemSubclass.Clear;
  edSearchItemItemset.Clear;
  edSearchItemInventoryType.Clear;
  edSearchItemQuality.Clear;
  edSearchItemFlags.Clear;
  edSearchItemItemLevel.Clear;
  lvSearchItem.Clear;
end;

procedure TMainForm.btcmsAddClick(Sender: TObject);
begin
  ScriptAdd('edcms', lvcmsCreatureMovementScript);
end;

procedure TMainForm.btcdsAddClick(Sender: TObject);
begin
  ScriptAdd('edcds', lvcdsCreatureOnDeathScript);
end;

procedure TMainForm.btcmsDelClick(Sender: TObject);
begin
  ScriptDel(lvcmsCreatureMovementScript);
end;

procedure TMainForm.btcdsDelClick(Sender: TObject);
begin
  ScriptDel(lvcdsCreatureOnDeathScript);
end;

procedure TMainForm.btcmsUpdClick(Sender: TObject);
begin
  ScriptUpd('edcms', lvcmsCreatureMovementScript);
end;

procedure TMainForm.btcdsUpdClick(Sender: TObject);
begin
  ScriptUpd('edcds', lvcdsCreatureOnDeathScript);
end;

procedure TMainForm.lvSearchItemChange(Sender: TObject; Item: TListItem; Change: TItemChange);
var
  flag: Boolean;
begin
  flag := Assigned(lvSearchItem.Selected);
  if flag then
    lvSearchItem.PopupMenu := pmItem
  else
    lvSearchItem.PopupMenu := nil;
  btEditItem.Enabled := flag;
  btDeleteItem.Enabled := flag;
  btBrowseItem.Enabled := flag;
  btBrowseItemPopup.Enabled := flag;
  nEditItem.Enabled := flag;
  nDeleteItem.Enabled := flag;
  nBrowseItem.Enabled := flag;
end;

procedure TMainForm.lvSearchItemCustomDrawSubItem(Sender: TCustomListView; Item: TListItem; SubItem: Integer;
  State: TCustomDrawState; var DefaultDraw: Boolean);
var
  sText: string;
  n: Integer;
  ACanvas: TCanvas;
  ARect: TRect;
  i: Integer;
begin
  { TCustomDrawState = set of (cdsSelected, cdsGrayed, cdsDisabled, cdsChecked,
    cdsFocused, cdsDefault, cdsHot, cdsMarked, cdsIndeterminate);
  }
  DefaultDraw := true;
  ACanvas := TCustomListView(Sender).Canvas;
  ARect := Item.DisplayRect(drBounds);

  if SubItem = 0 then // caption
  begin
    sText := Item.Caption;
    n := 4;
  end
  else
  begin
    sText := Item.SubItems[SubItem - 1];
    n := 8;
  end;

  ARect := Item.DisplayRect(drBounds);
  ARect.Right := ARect.Left;
  for i := 0 to SubItem do
    ARect.Right := ARect.Right + TCustomListView(Sender).Column[i].Width;
  ARect.Left := ARect.Right - TCustomListView(Sender).Column[SubItem].Width;

  if (cdsFocused in State) then
  begin
    DefaultDraw := false;
    ACanvas.Brush.Color := clNavy;
    ACanvas.Font.Color := $00FFFFFF;
    ACanvas.Font.Style := [fsBold];
    ACanvas.FrameRect(ARect);
    ACanvas.TextRect(ARect, ARect.Left + n, ARect.Top, sText);
  end
  else
  begin
    DefaultDraw := false;
    ACanvas.Brush.Color := clWhite;
    ACanvas.Font.Color := ItemColors[Integer(Item.Data)];
    ACanvas.Font.Style := [fsBold];
    ACanvas.TextRect(ARect, ARect.Left + n, ARect.Top, sText);
  end;
end;

procedure TMainForm.btNewItemClick(Sender: TObject);
begin
  lvSearchItem.Selected := nil;
  ClearFields(ttItem);
  SetDefaultFields(ttItem);
  PageControl5.ActivePageIndex := 1;
end;

procedure TMainForm.btEditItemClick(Sender: TObject);
begin
  PageControl5.ActivePageIndex := 1;
  if Assigned(lvSearchItem.Selected) then
    LoadItem(StrToInt(lvSearchItem.Selected.Caption));
end;

procedure TMainForm.btDeleteItemClick(Sender: TObject);
begin
  PageControl5.ActivePageIndex := SCRIPT_TAB_NO_ITEM;
  meitScript.Text := Format('DELETE FROM `item_template` WHERE (`entry`=%s);'#13#10, [lvSearchItem.Selected.Caption]);
end;

procedure TMainForm.btBrowseItemClick(Sender: TObject);
begin
  if Assigned(lvSearchItem.Selected) then
    dmMain.BrowseSite(ttItem, StrToInt(lvSearchItem.Selected.Caption));
end;

procedure TMainForm.btBrowsePopupClick(Sender: TObject);
var
  pt: TPoint;
begin
  pt.X := TButton(Sender).Width;
  pt.Y := 0;
  pt := TButton(Sender).ClientToScreen(pt);
  TButton(Sender).PopupMenu.PopupComponent := TButton(Sender);
  TButton(Sender).PopupMenu.Popup(pt.X, pt.Y);
end;

procedure TMainForm.lvSearchItemDblClick(Sender: TObject);
begin
  PageControl5.ActivePageIndex := 1;
  if Assigned(lvSearchItem.Selected) then
  begin
    LoadItem(StrToInt(lvSearchItem.Selected.Caption));
    CompleteItemScript;
  end;
end;

procedure TMainForm.btSearchItemClick(Sender: TObject);
begin
  SearchItem();
  with lvSearchItem do
    if Items.Count > 0 then
    begin
      SetFocus;
      Selected := Items[0];
      btEditItem.Default := true;
      btSearchItem.Default := false;
    end;
  StatusBarItem.Panels[0].Text := Format(dmMain.Text[116], [lvSearchItem.Items.Count]);
end;

procedure TMainForm.CompleteItemLootScript;
var
  entry, Item, Fields, Values: string;
begin
  meitLog.Clear;
  entry := edilentry.Text;
  Item := edilitem.Text;
  if (entry = '') or (Item = '') then
    Exit;
  SetFieldsAndValues(Fields, Values, 'item_loot_template', PFX_ITEM_LOOT_TEMPLATE, meitLog);
  case SyntaxStyle of
    ssInsertDelete:
      meitScript.Text := Format('DELETE FROM `item_loot_template` WHERE (`entry`=%s) AND (`item`=%s);'#13#10 +
      'INSERT INTO `item_loot_template` (%s) VALUES (%s);'#13#10, [entry, Item, Fields, Values]);
    ssReplace:
      meitScript.Text := Format('REPLACE INTO `item_loot_template` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      meitScript.Text := MakeUpdate2('item_loot_template', PFX_ITEM_LOOT_TEMPLATE, false, 'entry', entry, 'item', Item);
  end;
end;

procedure TMainForm.CompleteDisLootScript;
var
  entry, Item, Fields, Values: string;
begin
  meitLog.Clear;
  entry := edidentry.Text;
  Item := ediditem.Text;
  if (entry = '') or (Item = '') then
    Exit;
  SetFieldsAndValues(Fields, Values, 'disenchant_loot_template', PFX_DISENCHANT_LOOT_TEMPLATE, meitLog);
  case SyntaxStyle of
    ssInsertDelete:
      meitScript.Text := Format('DELETE FROM `disenchant_loot_template` WHERE (`entry`=%s) AND (`item`=%s);'#13#10 +
      'INSERT INTO `disenchant_loot_template` (%s) VALUES (%s);'#13#10, [entry, Item, Fields, Values]);
    ssReplace:
      meitScript.Text := Format('REPLACE INTO `disenchant_loot_template` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      meitScript.Text := MakeUpdate2('disenchant_loot_template', PFX_DISENCHANT_LOOT_TEMPLATE, false, 'entry', entry, 'item', Item);
  end;
end;

procedure TMainForm.CompleteProsLootScript;
var
  entry, Item, Fields, Values: string;
begin
  meitLog.Clear;
  entry := edipentry.Text;
  Item := edipitem.Text;
  if (entry = '') or (Item = '') then
    Exit;
  SetFieldsAndValues(Fields, Values, 'prospecting_loot_template', PFX_PROSPECTING_LOOT_TEMPLATE, meitLog);
  case SyntaxStyle of
    ssInsertDelete:
      meitScript.Text := Format('DELETE FROM `prospecting_loot_template` WHERE (`entry`=%s) AND (`item`=%s);'#13#10 +
      'INSERT INTO `prospecting_loot_template` (%s) VALUES (%s);'#13#10, [entry, Item, Fields, Values]);
    ssReplace:
      meitScript.Text := Format('REPLACE INTO `prospecting_loot_template` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      meitScript.Text := MakeUpdate2('prospecting_loot_template', PFX_PROSPECTING_LOOT_TEMPLATE, false, 'entry', entry, 'item', Item);
  end;
end;

procedure TMainForm.CompleteMillingLootScript;
var
  entry, Item, Fields, Values: string;
begin
  meitLog.Clear;
  entry := edimentry.Text;
  Item := edimitem.Text;
  if (entry = '') or (Item = '') then
    Exit;
  SetFieldsAndValues(Fields, Values, 'milling_loot_template', PFX_MILLING_LOOT_TEMPLATE, meitLog);
  case SyntaxStyle of
    ssInsertDelete:
      meitScript.Text := Format('DELETE FROM `milling_loot_template` WHERE (`entry`=%s) AND (`item`=%s);'#13#10 +
      'INSERT INTO `milling_loot_template` (%s) VALUES (%s);'#13#10, [entry, Item, Fields, Values]);
    ssReplace:
      meitScript.Text := Format('REPLACE INTO `milling_loot_template` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      meitScript.Text := MakeUpdate2('milling_loot_template', PFX_MILLING_LOOT_TEMPLATE, false, 'entry', entry, 'item', Item);
  end;
end;

procedure TMainForm.CompleteReferenceLootScript;
var
  entry, Item, Fields, Values: string;
begin
  meitLog.Clear;
  entry := edirentry.Text;
  Item := ediritem.Text;
  if (entry = '') or (Item = '') then
    Exit;
  SetFieldsAndValues(Fields, Values, 'reference_loot_template', PFX_REFERENCE_LOOT_TEMPLATE, meitLog);
  case SyntaxStyle of
    ssInsertDelete:
      meitScript.Text := Format('DELETE FROM `reference_loot_template` WHERE (`entry`=%s) AND (`item`=%s);'#13#10 +
      'INSERT INTO `reference_loot_template` (%s) VALUES (%s);'#13#10, [entry, Item, Fields, Values]);
    ssReplace:
      meitScript.Text := Format('REPLACE INTO `reference_loot_template` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      meitScript.Text := MakeUpdate2('reference_loot_template', PFX_REFERENCE_LOOT_TEMPLATE, false, 'entry', entry, 'item', Item);
  end;
end;

procedure TMainForm.CompleteSpellLootScript;
var
  entry, Item, Fields, Values: string;
begin
  meitLog.Clear;
  entry := edslentry.Text;
  Item := edslitem.Text;
  if (entry = '') or (Item = '') then
    Exit;
  SetFieldsAndValues(Fields, Values, 'spell_loot_template', PFX_SPELL_LOOT_TEMPLATE, meitLog);
  case SyntaxStyle of
    ssInsertDelete:
      meitScript.Text := Format('DELETE FROM `spell_loot_template` WHERE (`entry`=%s) AND (`item`=%s);'#13#10 +
      'INSERT INTO `spell_loot_template` (%s) VALUES (%s);'#13#10, [entry, Item, Fields, Values]);
    ssReplace:
      meitScript.Text := Format('REPLACE INTO `spell_loot_template` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      meitScript.Text := MakeUpdate2('spell_loot_template', PFX_SPELL_LOOT_TEMPLATE, false, 'entry', entry, 'item', Item);
  end;
end;

procedure TMainForm.CompleteItemScript;
var
  entry, Fields, Values: string;
begin
  meitLog.Clear;
  entry := editentry.Text;
  if entry = '' then
    Exit;
  SetFieldsAndValues(Fields, Values, 'item_template', PFX_ITEM_TEMPLATE, meitLog);
  case SyntaxStyle of
    ssInsertDelete:
      meitScript.Text := Format('DELETE FROM `item_template` WHERE (`entry`=%s);'#13#10 +
        'INSERT INTO `item_template` (%s) VALUES (%s);'#13#10, [entry, Fields, Values]);
    ssReplace:
      meitScript.Text := Format('REPLACE INTO `item_template` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      meitScript.Text := MakeUpdate('item_template', PFX_ITEM_TEMPLATE, false, 'entry', entry)
  end;
end;

procedure TMainForm.LoadItem(entry: Integer);
begin
  ShowHourGlassCursor;
  ClearFields(ttItem);
  if entry < 1 then
    Exit;
  // load full description for item
  MyQuery.SQL.Text := Format('SELECT * FROM `item_template` WHERE `entry`=%d LIMIT 1', [entry]);
  MyQuery.Open;
  try
    if MyQuery.Eof then
      raise Exception.Create(Format(dmMain.Text[117], [entry])); // 'Error: item (entry = %d) not found'
    editentry.Text := IntToStr(entry);
    FillFields(MyQuery, PFX_ITEM_TEMPLATE);
    MyQuery.Close;

    LoadQueryToListView(Format('SELECT ilt.*, i.`name` FROM `item_loot_template`' +
      ' ilt LEFT OUTER JOIN `item_template` i ON i.`entry` = ilt.`item`' + ' WHERE (ilt.`entry`=%d)',
      [StrToIntDef(editentry.Text, 0)]), lvitItemLoot);

    LoadQueryToListView(Format('SELECT dlt.*, i.`name` FROM `disenchant_loot_template`' +
      ' dlt LEFT OUTER JOIN `item_template` i ON i.`entry` = dlt.`item`' + ' WHERE (dlt.`entry`=%d)',
      [StrToIntDef(editDisenchantID.Text, 0)]), lvitDisLoot);

    LoadQueryToListView(Format('SELECT plt.*, i.`name` FROM `prospecting_loot_template`' +
      ' plt LEFT OUTER JOIN `item_template` i ON i.`entry` = plt.`item`' + ' WHERE (plt.`entry`=%d)',
      [StrToIntDef(editentry.Text, 0)]), lvitProsLoot);

    LoadQueryToListView(Format('SELECT mlt.*, i.`name` FROM `milling_loot_template`' +
      ' mlt LEFT OUTER JOIN `item_template` i ON i.`entry` = mlt.`item`' + ' WHERE (mlt.`entry`=%d)',
      [StrToIntDef(editentry.Text, 0)]), lvitMillingLoot);

    LoadQueryToListView(Format('SELECT slt.*, i.`name` FROM `spell_loot_template`' +
      ' slt LEFT OUTER JOIN `item_template` i ON i.`entry` = slt.`item`' + ' WHERE (slt.`item`=%d)',
      [StrToIntDef(editentry.Text, 0)]), lvslSpellLoot);

    LoadQueryToListView(Format('SELECT mlt.*, i.`name` FROM `mail_loot_template`' +
      ' mlt LEFT OUTER JOIN `item_template` i ON i.`entry` = mlt.`item`' + ' WHERE (mlt.`entry`=%d)',
      [StrToIntDef(edmlentry.Text, 0)]), lvmlMailLoot);

    LoadQueryToListView(Format('SELECT rlt.*, i.`name` FROM `reference_loot_template`' +
      ' rlt LEFT OUTER JOIN `item_template` i ON i.`entry` = rlt.`entry`' + ' WHERE (rlt.`item`=%d)',
      [StrToIntDef(editentry.Text, 0)]), lvitReferenceLoot);

    if editRandomProperty.Text <> '0' then
      LoadQueryToListView(Format('SELECT * FROM `item_enchantment_template`' + ' WHERE (`entry`=%d)',
        [StrToIntDef(editRandomProperty.Text, 0)]), lvitEnchantment)
    else if editRandomSuffix.Text <> '0' then
      LoadQueryToListView(Format('SELECT * FROM `item_enchantment_template`' + ' WHERE (`entry`=%d)',
        [StrToIntDef(editRandomSuffix.Text, 0)]), lvitEnchantment);

  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[118] + #10#13 + E.Message);
  end;
end;

procedure TMainForm.SearchItem;
var
  i: Integer;
  loc, id, Name, QueryStr, WhereStr, t: string;
  class_, subclass, InventoryType, itemset, Quality_, Flags, ItemLevel_: Integer;
  Field: TField;
begin
  loc := LoadLocales();
  ShowHourGlassCursor;
  id := edSearchItemEntry.Text;
  lvSearchItem.Columns[8].Caption := 'name' + loc;
  Name := edSearchItemName.Text;
  Name := StringReplace(Name, '''', '\''', [rfReplaceAll]);
  Name := StringReplace(Name, ' ', '%', [rfReplaceAll]);
  Name := '%' + Name + '%';

  QueryStr := '';
  WhereStr := '';
  if id <> '' then
  begin
    if pos('-', id) = 0 then
      WhereStr := Format('WHERE (it.`entry` in (%s))', [id])
    else
      WhereStr := Format('WHERE (it.`entry` >= %s) AND (it.`entry` <= %s)',
        [MidStr(id, 1, pos('-', id) - 1), MidStr(id, pos('-', id) + 1, length(id))]);
  end;

  if Name <> '%%' then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND ((it.`name` LIKE ''%s'') OR (li.`name' + loc + '` LIKE ''%1:s'')', [WhereStr, Name])
    else
      WhereStr := Format('WHERE (it.`name` LIKE ''%s'') OR (li.`name' + loc + '` LIKE ''%0:s'')', [Name]);
  end;

  class_ := StrToIntDef(edSearchItemClass.Text, -1);
  if class_ <> -1 then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND (it.`class` = %d)', [WhereStr, class_])
    else
      WhereStr := Format('WHERE (it.`class` = %d)', [class_]);
  end;

  subclass := StrToIntDef(edSearchItemSubclass.Text, -1);
  if subclass <> -1 then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND (it.`subclass` = %d)', [WhereStr, subclass])
    else
      WhereStr := Format('WHERE (it.`subclass` = %d)', [subclass]);
  end;

  InventoryType := StrToIntDef(edSearchItemInventoryType.Text, -1);
  if InventoryType <> -1 then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND (it.`InventoryType` = %d)', [WhereStr, InventoryType])
    else
      WhereStr := Format('WHERE (it.`InventoryType` = %d)', [InventoryType]);
  end;

  itemset := StrToIntDef(edSearchItemItemset.Text, -1);
  if itemset <> -1 then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND (it.`itemset` = %d)', [WhereStr, itemset])
    else
      WhereStr := Format('WHERE (it.`itemset` = %d)', [itemset]);
  end;

  Quality_ := StrToIntDef(edSearchItemQuality.Text, -1);
  if Quality_ <> -1 then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND (it.`Quality` = %d)', [WhereStr, Quality_])
    else
      WhereStr := Format('WHERE (it.`Quality` = %d)', [Quality_]);
  end;

  Flags := StrToIntDef(edSearchItemFlags.Text, -1);
  if Flags <> -1 then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND (it.`Flags` & %d <> 0)', [WhereStr, Flags])
    else
      WhereStr := Format('WHERE (it.`Flags` & %d <> 0 )', [Flags]);
  end;

  ItemLevel_ := StrToIntDef(edSearchItemItemLevel.Text, -1);
  if ItemLevel_ <> -1 then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND (it.`ItemLevel` =  %d)', [WhereStr, ItemLevel_])
    else
      WhereStr := Format('WHERE (it.`ItemLevel` = %d)', [ItemLevel_]);
  end;

  if Trim(WhereStr) = '' then
    if MessageDlg(dmMain.Text[134], mtConfirmation, mbYesNoCancel, -1) <> mrYes then
      Exit;

  QueryStr := Format('SELECT * FROM `item_template` it LEFT OUTER JOIN locales_item li ON it.entry=li.entry %s',
    [WhereStr]);

  MyQuery.SQL.Text := QueryStr;
  lvSearchItem.Items.BeginUpdate;
  try
    MyQuery.Open;
    lvSearchItem.Clear;
    while not MyQuery.Eof do
    begin
      with lvSearchItem.Items.Add do
      begin
        Data := pointer(MyQuery.FieldByName('Quality').AsInteger);
        for i := 0 to lvSearchItem.Columns.Count - 1 do
        begin
          Field := MyQuery.FindField(lvSearchItem.Columns[i].Caption);
          t := '';
          if Assigned(Field) then
          begin
            t := Field.AsString;
            if i = 0 then
              Caption := t;
          end;
          if i <> 0 then
            SubItems.Add(t);
        end;
        MyQuery.Next;
      end;
    end;
  finally
    lvSearchItem.Items.EndUpdate;
    MyQuery.Close;
  end;
end;

procedure TMainForm.btCopyToClipboardItemClick(Sender: TObject);
begin
  meitScript.SelectAll;
  meitScript.CopyToClipboard;
  meitScript.SelStart := 0;
  meitScript.SelLength := 0;
end;

procedure TMainForm.btExecuteItemScriptClick(Sender: TObject);
begin
  if MessageDlg(dmMain.Text[9], mtConfirmation, mbYesNoCancel, -1) = mrYes then
    ExecuteScript(meitScript.Text, meitLog);
end;

procedure TMainForm.btScriptItemClick(Sender: TObject);
begin
  PageControl5.ActivePageIndex := SCRIPT_TAB_NO_ITEM;
end;

procedure TMainForm.lvitItemLootChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btItemLootUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btItemLootDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvitItemLootedFromDblClick(Sender: TObject);
var
  id: string;
  table, QueryStr: string;
  lvList: TJvListView;
  i: Integer;
  t: string;
  Field: TField;
begin
  if not Assigned(TJvListView(Sender).Selected) then
    Exit;
  id := lvitItemLootedFrom.Selected.Caption;
  table := lvitItemLootedFrom.Selected.SubItems[6];
  lvList := nil;
  QueryStr := '';

  if table = 'creature_loot_template' then
  begin
    QueryStr := Format('SELECT * FROM `creature_template` WHERE `LootId` = %s', [id]);
    lvList := lvSearchCreature;
    PageControl1.ActivePageIndex := 1;
  end;
  if table = 'pickpocketing_loot_template' then
  begin
    QueryStr := Format('SELECT * FROM `creature_template` WHERE `PickpocketLootId` = %s', [id]);
    lvList := lvSearchCreature;
    PageControl1.ActivePageIndex := 1;
  end;
  if table = 'skinning_loot_template' then
  begin
    QueryStr := Format('SELECT * FROM `creature_template` WHERE `SkinningLootId` = %s', [id]);
    lvList := lvSearchCreature;
    PageControl1.ActivePageIndex := 1;
  end;
  if table = 'npc_vendor' then
  begin
    QueryStr := Format('SELECT * FROM `creature_template` WHERE `Entry` = %s LIMIT 1', [id]);
    lvList := lvSearchCreature;
    PageControl1.ActivePageIndex := 1;
  end;

  if table = 'item_loot_template' then
  begin
    QueryStr := Format('SELECT * FROM `item_template` WHERE `entry` = %s LIMIT 1', [id]);
    lvList := lvSearchItem;
    PageControl5.ActivePageIndex := 0;
  end;
  if table = 'prospecting_loot_template' then
  begin
    QueryStr := Format('SELECT * FROM `item_template` WHERE `entry` = %s LIMIT 1', [id]);
    lvList := lvSearchItem;
    PageControl5.ActivePageIndex := 0;
  end;
  if table = 'disenchant_loot_template' then
  begin
    QueryStr := Format('SELECT * FROM `item_template` WHERE `DisenchantID` = %s', [id]);
    lvList := lvSearchItem;
    PageControl5.ActivePageIndex := 0;
  end;

  if table = 'gameobject_loot_template' then
  begin
    QueryStr := Format('SELECT * FROM `gameobject_template` WHERE `data1` = %s', [id]);
    lvList := lvSearchGO;
    PageControl1.ActivePageIndex := 2;
  end;
  if table = 'mail_loot_template' then
  begin
    QueryStr := Format('SELECT * FROM `quest_template` WHERE `RewMailTemplateId` = %s', [id]);
    lvList := lvQuest;
    PageControl1.ActivePageIndex := 0;
  end;

  if (QueryStr <> '') and Assigned(lvList) then
  begin
    MyQuery.SQL.Text := QueryStr;
    lvList.Items.BeginUpdate;
    try
      MyQuery.Open;
      lvList.Clear;
      while not MyQuery.Eof do
      begin
        with lvList.Items.Add do
        begin
          for i := 0 to lvList.Columns.Count - 1 do
          begin
            Field := MyQuery.FindField(lvList.Columns[i].Caption);
            t := '';
            if Assigned(Field) then
            begin
              t := Field.AsString;
              if i = 0 then
                Caption := t;
            end;
            if i <> 0 then
              SubItems.Add(t);
          end;
          MyQuery.Next;
        end;
      end;
    finally
      lvList.Items.EndUpdate;
      MyQuery.Close;
    end;
  end;

  if table = 'fishing_loot_template' then
  begin
    edotZone.Text := id;
    btGetLootForZone.Click;
    PageControl1.ActivePageIndex := 4;
  end;
end;

procedure TMainForm.lvitItemLootSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetLootEditFields('edil', lvitItemLoot);
end;

procedure TMainForm.lvitMillingLootChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btMillingLootUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btMillingLootDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvitMillingLootSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetLootEditFields('edim', lvitMillingLoot);
end;

procedure TMainForm.btScriptItemLootClick(Sender: TObject);
begin
  PageControl5.ActivePageIndex := SCRIPT_TAB_NO_ITEM;
end;

procedure TMainForm.btItemLootAddClick(Sender: TObject);
begin
  LootAdd('edil', lvitItemLoot);
end;

procedure TMainForm.btItemLootUpdClick(Sender: TObject);
begin
  LootUpd('edil', lvitItemLoot);
end;

procedure TMainForm.btItemLootDelClick(Sender: TObject);
begin
  LootDel(lvitItemLoot);
end;

procedure TMainForm.btFullScriptItemLootClick(Sender: TObject);
begin
  PageControl5.ActivePageIndex := SCRIPT_TAB_NO_ITEM;
  ShowFullLootScript('item_loot_template', lvitItemLoot, meitScript, editentry.Text);
end;

procedure TMainForm.btFullScriptMillingLootClick(Sender: TObject);
begin
  PageControl5.ActivePageIndex := SCRIPT_TAB_NO_ITEM;
  ShowFullLootScript('milling_loot_template', lvitMillingLoot, meitScript, editentry.Text);
end;

procedure TMainForm.editentryButtonClick(Sender: TObject);
var
  KeyboardState: TKeyboardState;
  id: Integer;
begin
  id := abs(StrToIntDef(TJvComboEdit(Sender).Text, 0));
  if id = 0 then
    Exit;
  GetKeyboardState(KeyboardState);
  if ssShift in KeyboardStateToShiftState(KeyboardState) then
    dmMain.BrowseSite(ttItem, id)
  else
    LoadItem(id);
end;

procedure TMainForm.edcvExtendedCostButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 152, 'ItemExtendedCost', false);
end;

procedure TMainForm.lvitDisLootChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btDisLootUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btDisLootDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvitDisLootSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetLootEditFields('edid', lvitDisLoot);
end;

procedure TMainForm.btDisLootAddClick(Sender: TObject);
begin
  LootAdd('edid', lvitDisLoot);
end;

procedure TMainForm.btDisLootUpdClick(Sender: TObject);
begin
  LootUpd('edid', lvitDisLoot);
end;

procedure TMainForm.btDisLootDelClick(Sender: TObject);
begin
  LootDel(lvitDisLoot);
end;

procedure TMainForm.btFullScriptDisLootClick(Sender: TObject);
begin
  PageControl5.ActivePageIndex := SCRIPT_TAB_NO_ITEM;
  ShowFullLootScript('disenchant_loot_template', lvitDisLoot, meitScript, editDisenchantID.Text);
end;

procedure TMainForm.tsItemInvolvedInShow(Sender: TObject);
begin
  LoadItemInvolvedIn(editentry.Text);
end;

procedure TMainForm.tsItemLootedFromShow(Sender: TObject);
begin
  if (lvitItemLootedFrom.Items.Count = 0) and (Trim(editentry.Text) <> '') then
    LoadLoot(lvitItemLootedFrom, editentry.Text);
end;

procedure TMainForm.tsItemLootShow(Sender: TObject);
begin
  if (edilentry.Text = '') then
    edilentry.Text := editentry.Text;
end;

procedure TMainForm.tsItemScriptShow(Sender: TObject);
begin
  case PageControl5.ActivePageIndex of
    1:
      CompleteItemScript;
    2:
      CompleteItemLootScript;
    3:
      CompleteDisLootScript;
    4:
      CompleteProsLootScript;
    5:
      CompleteMillingLootScript;
    6:
      CompleteReferenceLootScript;
    7:
      CompleteSpellLootScript;
    10:
      CompleteItemEnchScript;
  end;
end;

procedure TMainForm.tsMillingLootShow(Sender: TObject);
begin
  if (edipentry.Text = '') then
    edipentry.Text := editentry.Text;
end;

procedure TMainForm.tsSpellLootShow(Sender: TObject);
begin
  if (edslitem.Text = '') then
    edslitem.Text := editentry.Text;
end;

procedure TMainForm.tsNPCgossipShow(Sender: TObject);
begin
  if (edcgnpc_guid.Text = '') then
    edcgnpc_guid.Text := edclguid.Text;
  // if (edcgid.Text='') then edcgid.Text := '0';
end;

procedure TMainForm.editQualityButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 119, 'ItemQuality', false);
end;

procedure TMainForm.editInventoryTypeButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 120, 'ItemInventoryType', false);
end;

procedure TMainForm.editRequiredReputationRankButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 121, 'ItemRequiredReputationRank', false);
end;

procedure TMainForm.GetStatType(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 122, 'ItemStatType', false);
end;

function TMainForm.GetDBVersion: string;
begin
  Result := '';
  MyTempQuery.SQL.Text := 'SELECT * FROM `db_version`';
  try
    MyTempQuery.Open;
    if not MyTempQuery.Eof then
      Result := MyTempQuery.Fields[0].AsString;
  finally
    MyTempQuery.Close;
  end;
end;

procedure TMainForm.GetDmgType(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 123, 'ItemDmgType', false);
end;

procedure TMainForm.editbondingButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 124, 'ItemBonding', false);
end;

procedure TMainForm.EditButtonClick(Sender: TObject);
var
  f: TTextFieldEditorForm;
begin
  f := TTextFieldEditorForm.Create(Self);
  try
    f.memo.Text := DollToSym(TCustomEdit(Sender).Text);
    if f.ShowModal = mrOk then
      TCustomEdit(Sender).Text := SymToDoll(f.memo.Text);
  finally
    f.Free;
  end;
end;

procedure TMainForm.LangButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 125, 'Languages', false);
end;

procedure TMainForm.linkEventAIInfoClick(Sender: TObject);
begin
  BrowseURL1.Url := 'http://wiki.udbforums.org/index.php/Event_AI';
  BrowseURL1.Execute;
end;

procedure TMainForm.editPageMaterialButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 126, 'PageTextMaterial', false);
end;

procedure TMainForm.editMaterialButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 127, 'ItemMaterial', false);
end;

procedure TMainForm.EditMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var
  X: Integer;
begin
  Handled := true;
  if TryStrToInt(TCustomEdit(Sender).Text, X) then
    TCustomEdit(Sender).Text := IntToStr(X - 1);
end;

procedure TMainForm.EditMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var
  X: Integer;
begin
  Handled := true;
  if TryStrToInt(TLabeledEdit(Sender).Text, X) then
    TLabeledEdit(Sender).Text := IntToStr(X + 1);
end;

procedure TMainForm.editsheathButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 128, 'ItemSheath', false);
end;

procedure TMainForm.editsocketBonusButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 151, 'SpellItemEnchantment', true);
end;

procedure TMainForm.GetSpellTrigger(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 129, 'SpellTrigger', false);
end;

procedure TMainForm.editBagFamilyButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 129, 'ItemBagFamily', false);
end;

procedure TMainForm.editclassButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 130, 'ItemClass', false);
end;

procedure TMainForm.editsubclassButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList2(Sender, 131, 'ItemSubClass', false, editclass.Text);
end;

procedure TMainForm.EditThis(objtype, entry: string);
begin
  if objtype = 'creature' then
  begin
    PageControl1.ActivePageIndex := 1;
    PageControl3.ActivePageIndex := 1;
    edctEntry.Text := entry;
    edctEntry.Button.Click;
  end;
  if objtype = 'gameobject' then
  begin
    PageControl1.ActivePageIndex := 2;
    PageControl4.ActivePageIndex := 1;
    edgtentry.Text := entry;
    edgtentry.Button.Click;
  end;
  if objtype = 'item' then
  begin
    PageControl1.ActivePageIndex := 3;
    PageControl5.ActivePageIndex := 1;
    editentry.Text := entry;
    editentry.Button.Click;
  end;
end;

procedure TMainForm.edititemsetButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 132, 'ItemSet', true);
end;

procedure TMainForm.GetPage(Sender: TObject);
var
  edEdit: TJvComboEdit;
  f: TItemPageForm;
begin
  if Sender is TJvComboEdit then
  begin
    edEdit := TJvComboEdit(Sender);
    f := TItemPageForm.Create(Self);
    try
      if (edEdit.Text <> '') and (edEdit.Text <> '0') then
        f.Prepare(edEdit.Text);
      if f.ShowModal = mrOk then
        edEdit.Text := f.lvPageItem.Selected.Caption;
    finally
      f.Free;
    end;
  end;
end;

procedure TMainForm.GetMap(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 133, 'Map', true);
end;

procedure TMainForm.GetItemFlags(Sender: TObject);
begin
  GetSomeFlags(Sender, 'ItemFlags');
end;

procedure TMainForm.GetItemFlags2(Sender: TObject);
begin
  GetSomeFlags(Sender, 'ItemFlags2');
end;

procedure TMainForm.editFoodTypeButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 148, 'ItemPetFood', false);
end;

procedure TMainForm.editGemPropertiesButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 150, 'GemProperties', true);
end;

procedure TMainForm.nRebuildSpellListClick(Sender: TObject);
begin
  RebuildSpellList;
end;

procedure TMainForm.nReconnectClick(Sender: TObject);
begin
  Connect;
  UpdateCaption;
end;

procedure TMainForm.RebuildSpellList;
var
  list: TStringList;
begin
  ShowHourGlassCursor;
  MyTempQuery.SQL.Text := 'SELECT `SrcSpell` FROM `quest_template` WHERE `SrcSpell`<>0 ' + 'UNION ' +
    'SELECT `ReqSpellCast1` FROM `quest_template` WHERE `ReqSpellCast1`<>0 ' + 'UNION ' +
    'SELECT `ReqSpellCast2` FROM `quest_template` WHERE `ReqSpellCast2`<>0 ' + 'UNION ' +
    'SELECT `ReqSpellCast3` FROM `quest_template` WHERE `ReqSpellCast3`<>0 ' + 'UNION ' +
    'SELECT `ReqSpellCast4` FROM `quest_template` WHERE `ReqSpellCast4`<>0 ' + 'UNION ' +
    'SELECT `spell1` FROM `creature_template_spells` WHERE `spell1`<>0 ' + 'UNION ' +
    'SELECT `spell2` FROM `creature_template_spells` WHERE `spell2`<>0 ' + 'UNION ' +
    'SELECT `spell3` FROM `creature_template_spells` WHERE `spell3`<>0 ' + 'UNION ' +
    'SELECT `spell4` FROM `creature_template_spells` WHERE `spell4`<>0 ' + 'UNION ' +
    'SELECT `spell5` FROM `creature_template_spells` WHERE `spell5`<>0 ' + 'UNION ' +
    'SELECT `spell6` FROM `creature_template_spells` WHERE `spell6`<>0 ' + 'UNION ' +
    'SELECT `spell7` FROM `creature_template_spells` WHERE `spell7`<>0 ' + 'UNION ' +
    'SELECT `spell8` FROM `creature_template_spells` WHERE `spell8`<>0 ' + 'UNION ' +
    'SELECT `TrainerSpell` FROM `creature_template` WHERE `TrainerSpell`<>0 ' + 'UNION ' +
    'SELECT `spell` FROM `npc_trainer` WHERE `spell`<>0 ' + 'UNION ' +
    'SELECT `requiredspell` FROM `item_template` WHERE `requiredspell`<>0 ' + 'UNION ' +
    'SELECT `spellid_1` FROM `item_template` WHERE `spellid_1`<>0 ' + 'UNION ' +
    'SELECT `spellid_2` FROM `item_template` WHERE `spellid_2`<>0 ' + 'UNION ' +
    'SELECT `spellid_3` FROM `item_template` WHERE `spellid_3`<>0 ' + 'UNION ' +
    'SELECT `spellid_4` FROM `item_template` WHERE `spellid_4`<>0 ' + 'UNION ' +
    'SELECT `spellid_5` FROM `item_template` WHERE `spellid_5`<>0 ' + 'UNION ' +
    'SELECT `RewSpellCast` FROM `quest_template` WHERE `RewSpellCast`<>0 ' + 'UNION ' +
    'SELECT `RewSpell` FROM `quest_template` WHERE `RewSpell`<>0 ';
  MyTempQuery.Open;
  list := TStringList.Create;
  try
    list.BeginUpdate;
    while not MyTempQuery.Eof do
    begin
      list.Add(MyTempQuery.Fields[0].AsString);
      MyTempQuery.Next;
    end;
    MyTempQuery.Close;
  finally
    list.SaveToFile(dmMain.ProgramDir + 'CSV\useSpells.csv');
    list.Free;
    ShowMessage('Spell List Rebuilded Successfully');
  end;
end;

procedure TMainForm.edotentryButtonClick(Sender: TObject);
var
  id: string;
begin
  GetArea(Sender);
  id := TJvComboEdit(Sender).Text;
  if id <> '' then
    LoadQueryToListView(Format('SELECT flt.*, i.`name` FROM `fishing_loot_template`' +
      ' flt LEFT OUTER JOIN `item_template` i ON i.`entry` = flt.`item`' + ' WHERE (flt.`entry`=%s)', [id]),
      lvotFishingLoot);
end;

procedure TMainForm.btScriptFishingLootClick(Sender: TObject);
begin
  PageControl6.ActivePageIndex := SCRIPT_TAB_NO_OTHER;
end;

procedure TMainForm.btFullScriptFishLootClick(Sender: TObject);
begin
  PageControl6.ActivePageIndex := SCRIPT_TAB_NO_OTHER;
  ShowFullLootScript('fishing_loot_template', lvotFishingLoot, meotScript, edotentry.Text);
end;

procedure TMainForm.tsOtherScriptShow(Sender: TObject);
begin
  case PageControl6.ActivePageIndex of
    0:
      CompleteFishingLootScript;
    1:
      CompletePageTextScript;
    2:
      CompleteGameEventScript;
    3:
      CompleteConditionsScript;
    4:
      CompleteTaxiShortcutsScript;
  end;
end;

procedure TMainForm.btScriptConditionsClick(Sender: TObject);
begin
  PageControl6.ActivePageIndex := SCRIPT_TAB_NO_OTHER;
end;

procedure TMainForm.btScriptTaxiShortcutsClick(Sender: TObject);
begin
  PageControl6.ActivePageIndex := SCRIPT_TAB_NO_OTHER;
end;

procedure TMainForm.CompleteConditionsScript;
var
  entry, Fields, Values: string;
begin
  meotLog.Clear;
  entry := edconcondition_entry.Text;
  if (entry = '') then
    Exit;
  SetFieldsAndValues(Fields, Values, 'conditions', PFX_CONDITIONS, meotLog);
  case SyntaxStyle of
    ssInsertDelete:
      meotScript.Text := Format('DELETE FROM `conditions` WHERE (`condition_entry`=%s);'#13#10 +
        'INSERT INTO `conditions` (%s) VALUES (%s);'#13#10, [entry, Fields, Values]);
    ssReplace:
      meotScript.Text := Format('REPLACE INTO `conditions` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      meotScript.Text := MakeUpdate('conditions', PFX_CONDITIONS, false, 'condition_entry', entry);
  end;
end;

procedure TMainForm.CompleteTaxiShortcutsScript;
var
  entry, Fields, Values: string;
begin
  meotLog.Clear;
  entry := edtspathid.Text;
  if (entry = '') then
    Exit;
  SetFieldsAndValues(Fields, Values, 'taxi_shortcuts', PFX_TAXI_SHORTCUTS, meotLog);
  case SyntaxStyle of
    ssInsertDelete:
      meotScript.Text := Format('DELETE FROM `taxi_shortcuts` WHERE (`pathid`=%s);'#13#10 +
        'INSERT INTO `taxi_shortcuts` (%s) VALUES (%s);'#13#10, [entry, Fields, Values]);
    ssReplace:
      meotScript.Text := Format('REPLACE INTO `taxi_shortcuts` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      meotScript.Text := MakeUpdate('taxi_shortcuts', PFX_TAXI_SHORTCUTS, false, 'pathid', entry);
  end;
end;

procedure TMainForm.LoadConditions(Sender: TObject);
var
  entry: string;
begin
  entry := TCustomEdit(Sender).Text;
  if (StrToIntDef(entry, 0) < 1) then
    Exit;
  MyTempQuery.SQL.Text := Format('SELECT * FROM `conditions` WHERE `condition_entry`=%s LIMIT 1', [entry]);
  MyTempQuery.Open;
  try
    if MyTempQuery.Eof then
      raise Exception.Create(Format(dmMain.Text[161], [StrToInt(entry)])); // 'Error: Condition (condition_entry = %d) not found'
    FillFields(MyTempQuery, PFX_CONDITIONS);
    MyTempQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[162] + #10#13 + E.Message);
  end;
end;

procedure TMainForm.LoadTaxiShortcuts(Sender: TObject);
var
  entry: string;
begin
  entry := TCustomEdit(Sender).Text;
  if (StrToIntDef(entry, 0) < 1) then
    Exit;
  MyTempQuery.SQL.Text := Format('SELECT * FROM `taxi_shortcuts` WHERE `pathid`=%s LIMIT 1', [entry]);
  MyTempQuery.Open;
  try
    if MyTempQuery.Eof then
      raise Exception.Create(Format(dmMain.Text[192], [StrToInt(entry)])); // 'Error: Taxi Shortcuts (pathid = %d) not found'
    FillFields(MyTempQuery, PFX_TAXI_SHORTCUTS);
    MyTempQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[193] + #10#13 + E.Message);
  end;
end;

procedure TMainForm.ClearQuestGiverGreeting;
begin
  tsGreetings.TabVisible := false;
  edqgEntry.Clear;
  edqgType.Clear;
  edqgEmoteId.Clear;
  edqgEmoteDelay.Clear;
  edqgText.Clear;
  edlqgText.Clear;
end;

procedure TMainForm.LoadQuestGiverGreeting(objtype: string; entry: string);
var
  loc_Entry, loc: string;
begin
  ClearQuestGiverGreeting;
  loc := LoadLocales();
  if (StrToIntDef(entry, 0) < 1) then
    Exit;
  if objtype = 'creature' then
    MyTempQuery.SQL.Text := Format('SELECT lqg.Entry as loc_entry, lqg.Text%0:s, qg.* FROM `questgiver_greeting` qg LEFT JOIN `locales_questgiver_greeting` lqg ON lqg.`Entry` = qg.`Entry` AND lqg.`Type` = qg.`Type` WHERE qg.`Entry`=%1:s AND qg.`Type`=0 LIMIT 1', [loc, entry])
  else if objtype = 'gameobject' then
    MyTempQuery.SQL.Text := Format('SELECT lqg.Entry as loc_entry, lqg.Text%0:s, qg.* FROM `questgiver_greeting` qg LEFT JOIN `locales_questgiver_greeting` lqg ON lqg.`Entry` = qg.`Entry` AND lqg.`Type` = qg.`Type` WHERE qg.`Entry`=%1:s AND qg.`Type`=1 LIMIT 1', [loc, entry])
  else
	Exit;
  MyTempQuery.Open;
  if MyTempQuery.IsEmpty then
  begin
    MyTempQuery.Close;
    Exit;
  end;
  tsGreetings.TabVisible := true;
  loc_Entry := MyTempQuery.Fields[0].AsString;
  if (StrToIntDef(loc_Entry, 0) > 0) then
  begin
    edlqgText.Visible := true;
    edlqgText.EditLabel.Caption := MyTempQuery.Fields[1].FieldName;
    edlqgText.Text := MyTempQuery.Fields[1].AsString;
  end
  else
    edlqgText.Visible := false;
  FillFields(MyTempQuery, PFX_QUESTGIVER_GREETING);
  MyTempQuery.Close;
end;

procedure TMainForm.edconentryButtonClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 4;
  PageControl6.ActivePageIndex := 3;
  LoadConditions(TCustomEdit(Sender));
end;

procedure TMainForm.edtspathidButtonClick(Sender: TObject);
begin
  LoadTaxiShortcuts(TCustomEdit(Sender));
end;

procedure TMainForm.edcontypeChange(Sender: TObject);
begin
  ChangeConditionType(StrToIntDef(TJvComboEdit(Sender).Text, 0), 'con');
end;

procedure TMainForm.tsDBScriptsOnShow(Sender: TObject);
begin
  case DBScriptString.ActivePageIndex of
    0:
      CompleteDbScriptStringScript;
    1:
      CompleteDbScriptsOnQuestStartScript;
    2:
      CompleteDbScriptsOnQuestEndScript;
    3:
      CompleteDbScriptsOnCreatureMvmntScript;
    4:
      CompleteDbScriptsOnCreatureDeathScript;
    5:
      CompleteDbScriptsOnGoUseScript;
    6:
      CompleteDbScriptsOnGoTemplateUseScript;
    7:
      CompleteDbScriptsOnEventScript;
    8:
      CompleteDbScriptsOnGossipScript;
    9:
      CompleteDbScriptsOnSpellScript;
    10:
      CompleteDbScriptsOnRelayScript;
    11:
      CompleteDbScriptRandomTemplatesScript;
  end;
end;

procedure TMainForm.btDBScriptsOnClick(Sender: TObject);
begin
  DBScriptString.ActivePageIndex := SCRIPT_TAB_NO_DBSCRIPTS_ON;
end;

procedure TMainForm.btssShowFullScriptOnClick(Sender: TObject);
begin
  medbScript.Clear;
  DBScriptString.ActivePageIndex := SCRIPT_TAB_NO_DBSCRIPTS_ON;
  medbScript.Text := DBScriptsOnSQLScript(lvssStartScript, SCRIPT_TABLE_QUEST_START, edssid.Text);
end;

procedure TMainForm.btesShowFullScriptOnClick(Sender: TObject);
begin
  medbScript.Clear;
  DBScriptString.ActivePageIndex := SCRIPT_TAB_NO_DBSCRIPTS_ON;
  medbScript.Text := DBScriptsOnSQLScript(lvesEndScript, SCRIPT_TABLE_QUEST_END, edesid.Text);
end;

procedure TMainForm.btcmsShowFullScriptOnClick(Sender: TObject);
begin
  medbScript.Clear;
  DBScriptString.ActivePageIndex := SCRIPT_TAB_NO_DBSCRIPTS_ON;
  medbScript.Text := DBScriptsOnSQLScript(lvcmsCreatureMovementScript, SCRIPT_TABLE_CREATURE_MOVEMENT, edcmsid.Text);
end;

procedure TMainForm.btcdsShowFullScriptOnClick(Sender: TObject);
begin
  medbScript.Clear;
  DBScriptString.ActivePageIndex := SCRIPT_TAB_NO_DBSCRIPTS_ON;
  medbScript.Text := DBScriptsOnSQLScript(lvcdsCreatureOnDeathScript, SCRIPT_TABLE_CREATURE_DEATH, edcdsid.Text);
end;

procedure TMainForm.btgbShowFullScriptOnClick(Sender: TObject);
begin
  medbScript.Clear;
  DBScriptString.ActivePageIndex := SCRIPT_TAB_NO_DBSCRIPTS_ON;
  medbScript.Text := DBScriptsOnSQLScript(lvgbGOScript, SCRIPT_TABLE_GO, edgbid.Text);
end;

procedure TMainForm.btgtbShowFullScriptOnClick(Sender: TObject);
begin
  medbScript.Clear;
  DBScriptString.ActivePageIndex := SCRIPT_TAB_NO_DBSCRIPTS_ON;
  medbScript.Text := DBScriptsOnSQLScript(lvgtbGOTemplateScript, SCRIPT_TABLE_GO_TEMPLATE, edgtbid.Text);
end;

procedure TMainForm.btdoeShowFullScriptOnClick(Sender: TObject);
begin
  medbScript.Clear;
  DBScriptString.ActivePageIndex := SCRIPT_TAB_NO_DBSCRIPTS_ON;
  medbScript.Text := DBScriptsOnSQLScript(lvdoeEventScript, SCRIPT_TABLE_EVENT, eddoeid.Text);
end;

procedure TMainForm.btdogShowFullScriptOnClick(Sender: TObject);
begin
  medbScript.Clear;
  DBScriptString.ActivePageIndex := SCRIPT_TAB_NO_DBSCRIPTS_ON;
  medbScript.Text := DBScriptsOnSQLScript(lvdogGossipScript, SCRIPT_TABLE_GOSSIP, eddogid.Text);
end;

procedure TMainForm.btdosShowFullScriptOnClick(Sender: TObject);
begin
  medbScript.Clear;
  DBScriptString.ActivePageIndex := SCRIPT_TAB_NO_DBSCRIPTS_ON;
  medbScript.Text := DBScriptsOnSQLScript(lvdosSpellScript, SCRIPT_TABLE_SPELL, eddosid.Text);
end;

procedure TMainForm.btdorShowFullScriptOnClick(Sender: TObject);
begin
  medbScript.Clear;
  DBScriptString.ActivePageIndex := SCRIPT_TAB_NO_DBSCRIPTS_ON;
  medbScript.Text := DBScriptsOnSQLScript(lvdorRelayScript, SCRIPT_TABLE_RELAY, eddorid.Text);
end;

procedure TMainForm.btrtFullScriptOnClick(Sender: TObject);
begin
  medbScript.Clear;
  DBScriptString.ActivePageIndex := SCRIPT_TAB_NO_DBSCRIPTS_ON;
  medbScript.Text := RandomTemplatesSQLScript(lvrtRandomScript, SCRIPT_TABLE_RND_TMPL, edrtid.Text);
end;

procedure TMainForm.CompleteDbScriptStringScript;
var
  entry, Fields, Values: string;
begin
  medbLog.Clear;
  entry := eddbsentry.Text;
  if (StrToIntDef(entry, 0) < 1) then
    Exit;
  SetFieldsAndValues(Fields, Values, TABLE_DB_SCRIPT_STRING, PFX_DB_SCRIPT_STRING, medbLog);
  case SyntaxStyle of
    ssInsertDelete:
      medbScript.Text := Format('DELETE FROM `%0:s` WHERE (`entry`=%s);'#13#10 +
        'INSERT INTO `%0:s` (%s) VALUES (%s);'#13#10, [TABLE_DB_SCRIPT_STRING, entry, Fields, Values]);
    ssReplace:
      medbScript.Text := Format('REPLACE INTO `%s` (%s) VALUES (%s);'#13#10, [TABLE_DB_SCRIPT_STRING, Fields, Values]);
    ssUpdate:
      medbScript.Text := MakeUpdate(TABLE_DB_SCRIPT_STRING, PFX_DB_SCRIPT_STRING, false, 'entry', entry);
  end;
end;

procedure TMainForm.CompleteDbScripts(TableName: string; prefix: string; entry: string; delay: string; command: string);
var
  Fields, Values: string;
begin
  medbLog.Clear;
  if (StrToIntDef(entry, 0) < 1) then
    Exit;
  SetFieldsAndValues(Fields, Values, TableName, prefix, medbLog);
  case SyntaxStyle of
    ssInsertDelete:
      medbScript.Text := Format('DELETE FROM `%0:s` WHERE (`id`=%1:s) AND (`delay`=%2:s) AND (`command`=%3:s);'#13#10 +
      'INSERT INTO `%0:s` (%4:s) VALUES (%5:s);'#13#10, [TableName, entry, delay, command, Fields, Values]);
    ssReplace:
      medbScript.Text := Format('REPLACE INTO `%s` (%s) VALUES (%s);'#13#10, [TableName, Fields, Values]);
    ssUpdate:
      medbScript.Text := MakeUpdate3(TableName, prefix, false, 'id', entry, 'delay', delay, 'command', command);
  end;
end;

procedure TMainForm.CompleteDbScriptRandomTemplates(TableName: string; prefix: string; entry: string; entry_type: string; target_id: string);
var
  Fields, Values: string;
begin
  medbLog.Clear;
  if (StrToIntDef(entry, 0) < 1) then
    Exit;
  SetFieldsAndValues(Fields, Values, TableName, prefix, medbLog);
  case SyntaxStyle of
    ssInsertDelete:
      medbScript.Text := Format('DELETE FROM `%0:s` WHERE (`id`=%1:s) AND (`type`=%2:s) AND (`target_id`=%3:s);'#13#10 +
      'INSERT INTO `%0:s` (%4:s) VALUES (%5:s);'#13#10, [TableName, entry, entry_type, target_id, Fields, Values]);
    ssReplace:
      medbScript.Text := Format('REPLACE INTO `%s` (%s) VALUES (%s);'#13#10, [TableName, Fields, Values]);
    ssUpdate:
      medbScript.Text := MakeUpdate3(TableName, prefix, false, 'id', entry, 'type', entry_type, 'target_id', target_id);
  end;
end;

procedure TMainForm.CompleteDbScriptsOnQuestStartScript;
begin
  CompleteDbScripts(SCRIPT_TABLE_QUEST_START, PFX_DBSCRIPTS_ON_QUEST_START, edssid.Text, edssdelay.Text, edsscommand.Text);
end;

procedure TMainForm.CompleteDbScriptsOnQuestEndScript;
begin
  CompleteDbScripts(SCRIPT_TABLE_QUEST_END, PFX_DBSCRIPTS_ON_QUEST_END, edesid.Text, edesdelay.Text, edescommand.Text);
end;

procedure TMainForm.CompleteDbScriptsOnCreatureMvmntScript;
begin
  CompleteDbScripts(SCRIPT_TABLE_CREATURE_MOVEMENT, PFX_DBSCRIPTS_ON_CREATURE_MOVEMENT, edcmsid.Text, edcmsdelay.Text, edcmscommand.Text);
end;

procedure TMainForm.CompleteDbScriptsOnCreatureDeathScript;
begin
  CompleteDbScripts(SCRIPT_TABLE_CREATURE_DEATH, PFX_DBSCRIPTS_ON_CREATURE_DEATH, edcdsid.Text, edcdsdelay.Text, edcdscommand.Text);
end;

procedure TMainForm.CompleteDbScriptsOnGoUseScript;
begin
  CompleteDbScripts(SCRIPT_TABLE_GO, PFX_DBSCRIPTS_ON_GO_USE, edgbid.Text, edgbdelay.Text, edgbcommand.Text);
end;

procedure TMainForm.CompleteDbScriptsOnGoTemplateUseScript;
begin
  CompleteDbScripts(SCRIPT_TABLE_GO_TEMPLATE, PFX_DBSCRIPTS_ON_GO_TEMPLATE_USE, edgtbid.Text, edgtbdelay.Text, edgtbcommand.Text);
end;

procedure TMainForm.CompleteDbScriptsOnEventScript;
begin  
  CompleteDbScripts(SCRIPT_TABLE_EVENT, PFX_DBSCRIPTS_ON_EVENT, eddoeid.Text, eddoedelay.Text, eddoecommand.Text);
end;

procedure TMainForm.CompleteDbScriptsOnGossipScript;
begin
  CompleteDbScripts(SCRIPT_TABLE_GOSSIP, PFX_DBSCRIPTS_ON_GOSSIP, eddogid.Text, eddogdelay.Text, eddogcommand.Text);
end;

procedure TMainForm.CompleteDbScriptsOnSpellScript;
begin
  CompleteDbScripts(SCRIPT_TABLE_SPELL, PFX_DBSCRIPTS_ON_SPELL, eddosid.Text, eddosdelay.Text, eddoscommand.Text);
end;

procedure TMainForm.CompleteDbScriptsOnRelayScript;
begin
  CompleteDbScripts(SCRIPT_TABLE_RELAY, PFX_DBSCRIPTS_ON_RELAY, eddorid.Text, eddordelay.Text, eddorcommand.Text);
end;

procedure TMainForm.CompleteDbScriptRandomTemplatesScript;
begin
  CompleteDbScriptRandomTemplates(SCRIPT_TABLE_RND_TMPL, PFX_DBSCRIPTS_ON_RND_TMPL, edrtid.Text, edrttype.Text, edrttarget_id.Text);
end;

procedure TMainForm.btCopyToClipDBScriptsOnClick(Sender: TObject);
begin
  meotScript.SelectAll;
  meotScript.CopyToClipboard;
  meotScript.SelStart := 0;
  meotScript.SelLength := 0;
end;

procedure TMainForm.btExecuteDBScriptsOnClick(Sender: TObject);
begin
  if MessageDlg(dmMain.Text[9], mtConfirmation, mbYesNoCancel, -1) = mrYes then
    ExecuteScript(medbScript.Text, medbLog);
end;

procedure TMainForm.LoadDBScriptString(Sender: TObject);
var
  entry: string;
begin
  entry := TCustomEdit(Sender).Text;
  if (StrToIntDef(entry, 0) < 1) then
    Exit;
  MyTempQuery.SQL.Text := Format('SELECT * FROM `%s` WHERE `entry`=%s LIMIT 1', [TABLE_DB_SCRIPT_STRING, entry]);
  MyTempQuery.Open;
  try
    if MyTempQuery.Eof then
      raise Exception.Create(Format(dmMain.Text[164], [StrToInt(entry)])); // 'Error: dbscript_string (entry = %d) not found'
    FillFields(MyTempQuery, PFX_DB_SCRIPT_STRING);
    MyTempQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[165] + #10#13 + E.Message);
  end;
end;

procedure TMainForm.eddbsentryButtonClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 6;
  DBScriptString.ActivePageIndex := TAB_NO_DBSCRIPT_STRING;
  LoadDBScriptString(TCustomEdit(Sender));
end;

procedure TMainForm.LoadDBScripts(Sender: TObject; TableName: string; prefix: string);
var
  entry: string;
begin
  entry := TCustomEdit(Sender).Text;
  if (StrToIntDef(entry, 0) < 1) then
    Exit;
  MyTempQuery.SQL.Text := Format('SELECT * FROM `%s` WHERE `id`=%s', [TableName, entry]);
  MyTempQuery.Open;
  try
    if MyTempQuery.Eof then
      raise Exception.Create(Format(dmMain.Text[166], [TableName, StrToInt(entry)])); // 'Error: %s (id = %d) not found'
    FillFields(MyTempQuery, prefix);
    MyTempQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(Format(dmMain.Text[167], [TableName]) + #10#13 + E.Message);
  end;
end;

procedure TMainForm.LoadDBScriptsOnQuestStart(Sender: TObject);
begin
  LoadDBScripts(Sender, SCRIPT_TABLE_QUEST_START, PFX_DBSCRIPTS_ON_QUEST_START);
end;

procedure TMainForm.edssidButtonClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 6;
  DBScriptString.ActivePageIndex := TAB_NO_DBSCRIPT_QUEST_START;
  LoadDBScriptsOnQuestStart(TCustomEdit(Sender));
  LoadQuestStartScript(TCustomEdit(Sender));
end;

procedure TMainForm.LoadDBScriptsOnQuestEnd(Sender: TObject);
begin
  LoadDBScripts(Sender, SCRIPT_TABLE_QUEST_END, PFX_DBSCRIPTS_ON_QUEST_END);
end;

procedure TMainForm.edesidButtonClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 6;
  DBScriptString.ActivePageIndex := TAB_NO_DBSCRIPT_QUEST_END;
  LoadDBScriptsOnQuestEnd(TCustomEdit(Sender));
  LoadQuestCompleteScript(TCustomEdit(Sender));
end;

procedure TMainForm.LoadDBScriptsOnCreatureMvmnt(Sender: TObject);
begin
  LoadDBScripts(Sender, SCRIPT_TABLE_CREATURE_MOVEMENT, PFX_DBSCRIPTS_ON_CREATURE_MOVEMENT);
end;

procedure TMainForm.edcmsidButtonClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 6;
  DBScriptString.ActivePageIndex := TAB_NO_DBSCRIPT_CREATURE_MOVEMENT;
  LoadDBScriptsOnCreatureMvmnt(TCustomEdit(Sender));
  LoadQueryToListView(Format('SELECT * FROM `%s` WHERE (`id`=%d)',
      [SCRIPT_TABLE_CREATURE_MOVEMENT, StrToIntDef(TCustomEdit(Sender).Text, 0)]), lvcmsCreatureMovementScript);
end;

procedure TMainForm.LoadDBScriptsOnCreatureDeath(Sender: TObject);
begin
  LoadDBScripts(Sender, SCRIPT_TABLE_CREATURE_DEATH, PFX_DBSCRIPTS_ON_CREATURE_DEATH);
end;

procedure TMainForm.edcdsidButtonClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 6;
  DBScriptString.ActivePageIndex := TAB_NO_DBSCRIPT_CREATURE_DEATH;
  LoadDBScriptsOnCreatureDeath(TCustomEdit(Sender));
  LoadQueryToListView(Format('SELECT * FROM `%s` WHERE (`id`=%d)',
      [SCRIPT_TABLE_CREATURE_DEATH, StrToIntDef(TCustomEdit(Sender).Text, 0)]), lvcdsCreatureOnDeathScript);
end;

procedure TMainForm.LoadDBScriptsOnGoUse(Sender: TObject);
begin
  LoadDBScripts(Sender, SCRIPT_TABLE_GO, PFX_DBSCRIPTS_ON_GO_USE);
end;

procedure TMainForm.edgbidButtonClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 6;
  DBScriptString.ActivePageIndex := TAB_NO_DBSCRIPT_GO;
  LoadDBScriptsOnGoUse(TCustomEdit(Sender));
  LoadQueryToListView(Format('SELECT * FROM `%s` WHERE (`id`=%d)',
      [SCRIPT_TABLE_GO, StrToIntDef(TCustomEdit(Sender).Text, 0)]), lvgbGOScript);
end;

procedure TMainForm.LoadDBScriptsOnGoTemplateUse(Sender: TObject);
begin
  LoadDBScripts(Sender, SCRIPT_TABLE_GO_TEMPLATE, PFX_DBSCRIPTS_ON_GO_TEMPLATE_USE);
end;

procedure TMainForm.edgtbidButtonClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 6;
  DBScriptString.ActivePageIndex := TAB_NO_DBSCRIPT_GO_TEMPLATE;
  LoadDBScriptsOnGoTemplateUse(TCustomEdit(Sender));
  LoadQueryToListView(Format('SELECT * FROM `%s` WHERE (`id`=%d)',
      [SCRIPT_TABLE_GO_TEMPLATE, StrToIntDef(TCustomEdit(Sender).Text, 0)]), lvgtbGOTemplateScript);
end;

procedure TMainForm.LoadDBScriptsOnEvent(Sender: TObject);
begin
  LoadDBScripts(Sender, SCRIPT_TABLE_EVENT, PFX_DBSCRIPTS_ON_EVENT);
end;

procedure TMainForm.eddoeidButtonClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 6;
  DBScriptString.ActivePageIndex := TAB_NO_DBSCRIPT_EVENT;
  LoadDBScriptsOnEvent(TCustomEdit(Sender));
  LoadQueryToListView(Format('SELECT * FROM `%s` WHERE (`id`=%d)',
      [SCRIPT_TABLE_EVENT, StrToIntDef(TCustomEdit(Sender).Text, 0)]), lvdoeEventScript);
end;

procedure TMainForm.LoadDBScriptsOnGossip(Sender: TObject);
begin
  LoadDBScripts(Sender, SCRIPT_TABLE_GOSSIP, PFX_DBSCRIPTS_ON_GOSSIP);
end;

procedure TMainForm.eddogidButtonClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 6;
  DBScriptString.ActivePageIndex := TAB_NO_DBSCRIPT_GOSSIP;
  LoadDBScriptsOnGossip(TCustomEdit(Sender));
  LoadQueryToListView(Format('SELECT * FROM `%s` WHERE (`id`=%d)',
      [SCRIPT_TABLE_GOSSIP, StrToIntDef(TCustomEdit(Sender).Text, 0)]), lvdogGossipScript);
end;

procedure TMainForm.LoadDBScriptsOnSpell(Sender: TObject);
begin
  LoadDBScripts(Sender, SCRIPT_TABLE_SPELL, PFX_DBSCRIPTS_ON_SPELL);
end;

procedure TMainForm.eddosidButtonClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 6;
  DBScriptString.ActivePageIndex := TAB_NO_DBSCRIPT_SPELL;
  LoadDBScriptsOnSpell(TCustomEdit(Sender));
  LoadQueryToListView(Format('SELECT * FROM `%s` WHERE (`id`=%d)',
      [SCRIPT_TABLE_SPELL, StrToIntDef(TCustomEdit(Sender).Text, 0)]), lvdosSpellScript);
end;

procedure TMainForm.LoadDBScriptsOnRelay(Sender: TObject);
begin
  LoadDBScripts(Sender, SCRIPT_TABLE_RELAY, PFX_DBSCRIPTS_ON_RELAY);
end;

procedure TMainForm.eddoridButtonClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 6;
  DBScriptString.ActivePageIndex := TAB_NO_DBSCRIPT_RELAY;
  LoadDBScriptsOnRelay(TCustomEdit(Sender));
  LoadQueryToListView(Format('SELECT * FROM `%s` WHERE (`id`=%d)',
      [SCRIPT_TABLE_RELAY, StrToIntDef(TCustomEdit(Sender).Text, 0)]), lvdorRelayScript);
end;

procedure TMainForm.LoadDBScriptsOnRandomTemplates(Sender: TObject);
begin
  LoadDBScripts(Sender, SCRIPT_TABLE_RND_TMPL, PFX_DBSCRIPTS_ON_RND_TMPL);
end;

procedure TMainForm.edrtidButtonClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 6;
  DBScriptString.ActivePageIndex := TAB_NO_DBSCRIPT_RND_TMPL;
  LoadDBScriptsOnRandomTemplates(TCustomEdit(Sender));
  LoadQueryToListView(Format('SELECT * FROM `%s` WHERE (`id`=%d)',
      [SCRIPT_TABLE_RND_TMPL, StrToIntDef(TCustomEdit(Sender).Text, 0)]), lvrtRandomScript);
end;

procedure TMainForm.edrttarget_idButtonClick(Sender: TObject);
begin
  if (StrToIntDef(edrttype.Text, 0) = 0) then
  begin
	if (StrToIntDef(edrttarget_id.Text, 0) > 0) then
	  eddbsentryButtonClick(TCustomEdit(Sender));
    //else
	  //edcatentryButtonClick(TCustomEdit(Sender));
  end
  else if (StrToIntDef(edrttype.Text, 0) = 1) then
    eddoridButtonClick(TCustomEdit(Sender));
end;

procedure TMainForm.edclguidButtonClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 1;
  PageControl3.ActivePageIndex := TAB_NO_NPC_CREATURE_LOCATION;
  LoadCreatureLocation(StrToIntDef(TCustomEdit(Sender).Text, 0));
  LoadQueryToListView(Format('SELECT guid, id, map, position_x, position_y, position_z, orientation FROM `creature` WHERE (`guid`=%d) LIMIT 1',
      [StrToIntDef(TCustomEdit(Sender).Text, 0)]), lvclCreatureLocation);
end;

procedure TMainForm.edclidButtonClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 1;
  PageControl3.ActivePageIndex := TAB_NO_NPC_CREATURE_LOCATION;
  LoadCreatureLocationSearchID(StrToIntDef(TCustomEdit(Sender).Text, 0));
  LoadQueryToListView(Format('SELECT guid, id, map, position_x, position_y, position_z, orientation FROM `creature` WHERE (`id`=%d)',
      [StrToIntDef(TCustomEdit(Sender).Text, 0)]), lvclCreatureLocation);
end;

procedure TMainForm.LoadCreatureModelInfo(Sender: TObject);
var
  entry: string;
begin
  entry := TCustomEdit(Sender).Text;
  if (StrToIntDef(entry, 0) < 1) then
    Exit;
  MyTempQuery.SQL.Text := Format('SELECT * FROM `creature_model_info` WHERE `modelid`=%s LIMIT 1', [entry]);
  MyTempQuery.Open;
  try
    if MyTempQuery.Eof then
      raise Exception.Create(Format(dmMain.Text[168], [StrToInt(entry)])); // 'Error: creature_model_info (id = %d) not found'
    FillFields(MyTempQuery, PFX_CREATURE_MODEL_INFO);
    MyTempQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[169] + #10#13 + E.Message);
  end;
end;

procedure TMainForm.edcimodelidButtonClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 1;
  PageControl3.ActivePageIndex := TAB_NO_NPC_CREATURE_MODEL_INFO;
  LoadCreatureModelInfo(TCustomEdit(Sender));
  LoadQueryToListView(Format('SELECT * FROM `creature_model_info` WHERE (`modelid`=%d) LIMIT 1',
      [StrToIntDef(TCustomEdit(Sender).Text, 0)]), lvCreatureModelSearch);
end;

procedure TMainForm.LoadGossipMenuOption(Sender: TObject);
var
  entry: string;
begin
  entry := TCustomEdit(Sender).Text;
  if (StrToIntDef(entry, 0) < 1) then
    Exit;
  MyTempQuery.SQL.Text := Format('SELECT * FROM `gossip_menu_option` WHERE `menu_id`=%s', [entry]);
  MyTempQuery.Open;
  try
    if MyTempQuery.Eof then
      raise Exception.Create(Format(dmMain.Text[170], [StrToInt(entry)])); // 'Error: gossip_menu_option (id = %d) not found'
    FillFields(MyTempQuery, PFX_CREATURE_GOSSIP_MENU_OPTION);
    MyTempQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[171] + #10#13 + E.Message);
  end;
end;

procedure TMainForm.edcgmomenu_idButtonClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 1;
  PageControl3.ActivePageIndex := TAB_NO_NPC_GOSSIP_MENU;
  LoadGossipMenuOption(TCustomEdit(Sender));
  LoadQueryToListView(Format('SELECT * FROM `gossip_menu_option` WHERE (`menu_id`=%d)',
      [StrToIntDef(TCustomEdit(Sender).Text, 0)]), lvcgmOptions);
end;

procedure TMainForm.edcuentryButtonClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 1;
  PageControl3.ActivePageIndex := 21;
  LoadCreatureTemplateSpells(StrToIntDef(TCustomEdit(Sender).Text, 0));
end;

procedure TMainForm.tsProspectingLootShow(Sender: TObject);
begin
  if (edipentry.Text = '') then
    edipentry.Text := editentry.Text;
end;

procedure TMainForm.CompleteFishingLootScript;
var
  entry, Item, Fields, Values: string;
begin
  meotLog.Clear;
  entry := edotentry.Text;
  Item := edotitem.Text;
  if (entry = '') or (Item = '') then
    Exit;
  SetFieldsAndValues(Fields, Values, 'fishing_loot_template', PFX_FISHING_LOOT_TEMPLATE, meotLog);
  case SyntaxStyle of
    ssInsertDelete:
      meotScript.Text := Format('DELETE FROM `fishing_loot_template` WHERE (`entry`=%s) AND (`item`=%s);'#13#10 +
      'INSERT INTO `fishing_loot_template` (%s) VALUES (%s);'#13#10, [entry, Item, Fields, Values]);
    ssReplace:
      meotScript.Text := Format('REPLACE INTO `fishing_loot_template` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      meotScript.Text := MakeUpdate2('fishing_loot_template', PFX_FISHING_LOOT_TEMPLATE, false, 'entry', entry, 'item', Item);
  end;
end;

procedure TMainForm.btCopyToClipboardOtherClick(Sender: TObject);
begin
  meotScript.SelectAll;
  meotScript.CopyToClipboard;
  meotScript.SelStart := 0;
  meotScript.SelLength := 0;
end;

procedure TMainForm.btExecuteOtherScriptClick(Sender: TObject);
begin
  if MessageDlg(dmMain.Text[9], mtConfirmation, mbYesNoCancel, -1) = mrYes then
    ExecuteScript(meotScript.Text, meotLog);
end;

procedure TMainForm.lvotFishingLootSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetLootEditFields('edot', lvotFishingLoot);
end;

procedure TMainForm.lvotFishingLootChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btFishingLootUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btFishingLootDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.btGameEventAddClick(Sender: TObject);
begin
  with lvSearchGameEvent.Items.Add do
  begin
    Caption := edgeentry.Text;
    SubItems.Add(edgestart_time.Text);
    SubItems.Add(edgeend_time.Text);
    SubItems.Add(edgeoccurence.Text);
    SubItems.Add(edgelength.Text);
    SubItems.Add(edgeholiday.Text);
    SubItems.Add(edgelinkedTo.Text);
    SubItems.Add(edgeEventGroup.Text);
    SubItems.Add(edgedescription.Text);
    Selected := true;
    MakeVisible(false);
  end;
end;

procedure TMainForm.btGameEventDelClick(Sender: TObject);
begin
  if Assigned(lvSearchGameEvent.Selected) then
  begin
    meotScript.Text := Format('DELETE FROM `game_event` WHERE `entry` = %0:s;'#13#10 +
      'DELETE FROM `game_event` WHERE `linkedTo` = %0:s;'#13#10 +
      'DELETE FROM `game_event_creature` WHERE abs(`event`) = %0:s;'#13#10 +
      'DELETE FROM `game_event_gameobject` WHERE abs(`event`) = %0:s;'#13#10, [lvSearchGameEvent.Selected.Caption]);
    lvSearchGameEvent.DeleteSelected;
  end;
end;

procedure TMainForm.btGameEventUpdClick(Sender: TObject);
begin
  if Assigned(lvSearchGameEvent.Selected) then
  begin
    with lvSearchGameEvent.Selected do
    begin
      Caption := edgeentry.Text;
      SubItems[0] := edgestart_time.Text;
      SubItems[1] := edgeend_time.Text;
      SubItems[2] := edgeoccurence.Text;
      SubItems[3] := edgelength.Text;
      SubItems[4] := edgeholiday.Text;
      SubItems[5] := edgelinkedTo.Text;
      SubItems[6] := edgeEventGroup.Text;
      SubItems[7] := edgedescription.Text;
    end;
  end;
end;

procedure TMainForm.btgbAddClick(Sender: TObject);
begin
  ScriptAdd('edgb', lvgbGOScript);
end;

procedure TMainForm.btgbDelClick(Sender: TObject);
begin
  ScriptDel(lvgbGOScript);
end;

procedure TMainForm.btgbUpdClick(Sender: TObject);
begin
  ScriptUpd('edgb', lvgbGOScript);
end;

procedure TMainForm.btgtbAddClick(Sender: TObject);
begin
  ScriptAdd('edgtb', lvgtbGOTemplateScript);
end;

procedure TMainForm.btgtbDelClick(Sender: TObject);
begin
  ScriptDel(lvgtbGOTemplateScript);
end;

procedure TMainForm.btgtbUpdClick(Sender: TObject);
begin
  ScriptUpd('edgtb', lvgtbGOTemplateScript);
end;

procedure TMainForm.btdoeAddClick(Sender: TObject);
begin
  ScriptAdd('eddoe', lvdoeEventScript);
end;

procedure TMainForm.btdoeDelClick(Sender: TObject);
begin
  ScriptDel(lvdoeEventScript);
end;

procedure TMainForm.btdoeUpdClick(Sender: TObject);
begin
  ScriptUpd('eddoe', lvdoeEventScript);
end;

procedure TMainForm.btdogAddClick(Sender: TObject);
begin
  ScriptAdd('eddog', lvdogGossipScript);
end;

procedure TMainForm.btdogDelClick(Sender: TObject);
begin
  ScriptDel(lvdogGossipScript);
end;

procedure TMainForm.btdogUpdClick(Sender: TObject);
begin
  ScriptUpd('eddog', lvdogGossipScript);
end;

procedure TMainForm.btdosAddClick(Sender: TObject);
begin
  ScriptAdd('eddos', lvdosSpellScript);
end;

procedure TMainForm.btdosDelClick(Sender: TObject);
begin
  ScriptDel(lvdosSpellScript);
end;

procedure TMainForm.btdosUpdClick(Sender: TObject);
begin
  ScriptUpd('eddos', lvdosSpellScript);
end;

procedure TMainForm.btdorAddClick(Sender: TObject);
begin
  ScriptAdd('eddor', lvdorRelayScript);
end;

procedure TMainForm.btdorDelClick(Sender: TObject);
begin
  ScriptDel(lvdorRelayScript);
end;

procedure TMainForm.btdorUpdClick(Sender: TObject);
begin
  ScriptUpd('eddor', lvdorRelayScript);
end;

procedure TMainForm.btrtAddClick(Sender: TObject);
begin
  RandomTemplatesScriptAdd('edrt', lvrtRandomScript);
end;

procedure TMainForm.btrtDelClick(Sender: TObject);
begin
  ScriptDel(lvrtRandomScript);
end;

procedure TMainForm.btrtUpdClick(Sender: TObject);
begin
  RandomTemplatesScriptUpd('edrt', lvrtRandomScript);
end;

procedure TMainForm.btgeCreatureGuidAddClick(Sender: TObject);
begin
  if Trim(edgeCreatureGuid.Text) <> '' then
  begin
    with lvGameEventCreature.Items.Add do
    begin
      Caption := edgeCreatureGuid.Text;
      SubItems.Add(edgeentry.Text);
    end;
  end;
end;

procedure TMainForm.btgeCreatureGuidDelClick(Sender: TObject);
begin
  if Assigned(lvGameEventCreature.Selected) then
    lvGameEventCreature.DeleteSelected;
end;

procedure TMainForm.btgeCreatureGuidInvClick(Sender: TObject);
begin
  if Assigned(lvGameEventCreature.Selected) then
    lvGameEventCreature.Selected.SubItems[0] := IntToStr(-StrToInt(lvGameEventCreature.Selected.SubItems[0]));
end;

procedure TMainForm.btgeGOGuidAddClick(Sender: TObject);
begin
  if Trim(edgeGOguid.Text) <> '' then
  begin
    with lvGameEventGO.Items.Add do
    begin
      Caption := edgeGOguid.Text;
      SubItems.Add(edgeentry.Text);
    end;
  end;
end;

procedure TMainForm.btgeGOguidDelClick(Sender: TObject);
begin
  if Assigned(lvGameEventGO.Selected) then
    lvGameEventGO.DeleteSelected;
end;

procedure TMainForm.btgeGOGuidInvClick(Sender: TObject);
begin
  if Assigned(lvGameEventGO.Selected) then
    lvGameEventGO.Selected.SubItems[0] := IntToStr(-StrToInt(lvGameEventGO.Selected.SubItems[0]));
end;

procedure TMainForm.btGetLootForZoneClick(Sender: TObject);
var
  id: string;
begin
  id := edotZone.Text;
  if id <> '' then
    LoadQueryToListView(Format('SELECT flt.*, i.`name` FROM `fishing_loot_template`' +
      ' flt LEFT OUTER JOIN `item_template` i ON i.`entry` = flt.`item`' + ' WHERE (flt.`entry`=%s)', [id]),
      lvotFishingLoot);
end;

procedure TMainForm.btFishingLootAddClick(Sender: TObject);
begin
  LootAdd('edot', lvotFishingLoot);
end;

procedure TMainForm.btFishingLootUpdClick(Sender: TObject);
begin
  LootUpd('edot', lvotFishingLoot);
end;

procedure TMainForm.btFishingLootDelClick(Sender: TObject);
begin
  LootDel(lvotFishingLoot);
end;

procedure TMainForm.edSearchItemSubclassButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList2(Sender, 131, 'ItemSubClass', false, edSearchItemClass.Text);
end;

procedure TMainForm.edqtZoneOrSortChange(Sender: TObject);
begin
  if StrToIntDef(edqtZoneOrSort.Text, 0) >= 0 then
    rbqtZoneID.Checked := true
  else
    rbqtQuestSort.Checked := true;
end;

procedure TMainForm.edZoneOrSortSearchButtonClick(Sender: TObject);
begin
  if rbZoneSearch.Checked then
    GetArea(Sender)
  else
    GetValueFromSimpleList(Sender, 11, 'QuestSort', false);
end;

procedure TMainForm.btSearchPageTextClick(Sender: TObject);
begin
  SearchPageText();
  with lvSearchPageText do
    if Items.Count > 0 then
    begin
      SetFocus;
      Selected := Items[0];
    end;
end;

procedure TMainForm.btShowNPCtextScriptClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
  CompleteNPCtextScript;
end;

procedure TMainForm.lvSearchPageTextSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
  begin
    edptentry.Text := Item.Caption;
    edpttext.Text := DollToSym(Item.SubItems[0]);
    edptnext_page.Text := Item.SubItems[1];
  end;
end;

procedure TMainForm.btScriptPageTextClick(Sender: TObject);
begin
  PageControl6.ActivePageIndex := SCRIPT_TAB_NO_OTHER;
end;

procedure TMainForm.CompletePageTextScript;
var
  entry, Fields, Values: string;
begin
  meotLog.Clear;
  entry := edptentry.Text;
  if (entry = '') then
    Exit;
  SetFieldsAndValues(Fields, Values, 'page_text', PFX_PAGE_TEXT, meotLog);
  case SyntaxStyle of
    ssInsertDelete:
      meotScript.Text := Format('DELETE FROM `page_text` WHERE (`entry`=%s);'#13#10 +
        'INSERT INTO `page_text` (%s) VALUES (%s);'#13#10, [entry, Fields, Values]);
    ssReplace:
      meotScript.Text := Format('REPLACE INTO `page_text` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      meotScript.Text := MakeUpdate('page_text', PFX_PAGE_TEXT, false, 'entry', entry);
  end;
end;

procedure TMainForm.SearchPageText;
var
  i: Integer;
  id, Name, QueryStr, WhereStr, t: string;
  next_page: Integer;
  Field: TField;
begin
  id := edSearchPageTextEntry.Text;
  Name := edSearchPageTextText.Text;
  Name := StringReplace(Name, '''', '\''', [rfReplaceAll]);
  Name := StringReplace(Name, ' ', '%', [rfReplaceAll]);
  Name := '%' + Name + '%';

  QueryStr := '';
  WhereStr := '';
  if id <> '' then
  begin
    if pos('-', id) = 0 then
      WhereStr := Format('WHERE (`entry` in (%s))', [id])
    else
      WhereStr := Format('WHERE (`entry` >= %s) AND (`entry` <= %s)',
        [MidStr(id, 1, pos('-', id) - 1), MidStr(id, pos('-', id) + 1, length(id))]);
  end;

  if Name <> '%%' then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND (`text` LIKE ''%s'')', [WhereStr, Name])
    else
      WhereStr := Format('WHERE (`text` LIKE ''%s'')', [Name]);
  end;

  next_page := StrToIntDef(edSearchPageTextNextPage.Text, -1);
  if next_page <> -1 then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND (`next_page` = %d)', [WhereStr, next_page])
    else
      WhereStr := Format('WHERE (`next_page` = %d)', [next_page]);
  end;

  if Trim(WhereStr) = '' then
    if MessageDlg(dmMain.Text[134], mtConfirmation, mbYesNoCancel, -1) <> mrYes then
      Exit;

  QueryStr := Format('SELECT * FROM `page_text` %s', [WhereStr]);

  MyQuery.SQL.Text := QueryStr;
  lvSearchPageText.Items.BeginUpdate;
  try
    MyQuery.Open;
    lvSearchPageText.Clear;
    while not MyQuery.Eof do
    begin
      with lvSearchPageText.Items.Add do
      begin
        for i := 0 to lvSearchPageText.Columns.Count - 1 do
        begin
          Field := MyQuery.FindField(lvSearchPageText.Columns[i].Caption);
          t := '';
          if Assigned(Field) then
          begin
            t := Field.AsString;
            if i = 0 then
              Caption := t;
          end;
          if i <> 0 then
            SubItems.Add(t);
        end;
        MyQuery.Next;
      end;
    end;
  finally
    lvSearchPageText.Items.EndUpdate;
    MyQuery.Close;
  end;
end;

procedure TMainForm.LoadPageText(Sender: TObject);
var
  entry: string;
begin
  entry := TCustomEdit(Sender).Text;
  MyTempQuery.SQL.Text := Format('SELECT * FROM `page_text` WHERE `entry`=%s LIMIT 1', [entry]);
  MyTempQuery.Open;
  if not MyTempQuery.Eof then
    FillFields(MyTempQuery, PFX_PAGE_TEXT);
  MyTempQuery.Close;
end;

function TMainForm.DollToSym(Text: string): string;
begin
  Result := StringReplace(Text, '$B', #13#10, [rfReplaceAll]);
end;

function TMainForm.SymToDoll(Text: string): string;
begin
  Result := StringReplace(Text, #13#10, '$B', [rfReplaceAll]);
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  if MyMangosConnection.Connected then
    MyMangosConnection.Ping;
end;

procedure TMainForm.btSQLOpenClick(Sender: TObject);
begin
  MySQLQuery.Close;
  MySQLQuery.SQL.Text := SQLEdit.Text;
  MySQLQuery.Open;
end;

procedure TMainForm.btScriptCreatureLocationCustomToAllClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
end;

procedure TMainForm.SetGOdataNames(t: Integer);
begin
  case t of
    0:
      begin
        edgtdata0.EditLabel.Caption := 'startOpen';
        edgtdata1.EditLabel.Caption := 'lockId';
        edgtdata2.EditLabel.Caption := 'autoCloseTime';
        edgtdata3.EditLabel.Caption := 'noDamageImmune';
        edgtdata4.EditLabel.Caption := 'openTextID';
        edgtdata5.EditLabel.Caption := 'closeTextID';
        edgtdata6.EditLabel.Caption := 'ignoredByPathing';
      end;
    1:
      begin
        edgtdata0.EditLabel.Caption := 'startOpen';
        edgtdata1.EditLabel.Caption := 'lockId';
        edgtdata2.EditLabel.Caption := 'autoCloseTime';
        edgtdata3.EditLabel.Caption := 'linkedTrap';
        edgtdata4.EditLabel.Caption := 'noDamageImmune';
        edgtdata5.EditLabel.Caption := 'large';
        edgtdata6.EditLabel.Caption := 'openTextID';
        edgtdata7.EditLabel.Caption := 'closeTextID';
        edgtdata8.EditLabel.Caption := 'losOK';
      end;
    2:
      begin
        edgtdata0.EditLabel.Caption := 'lockId';
        edgtdata1.EditLabel.Caption := 'questList';
        edgtdata2.EditLabel.Caption := 'pageMaterial';
        edgtdata3.EditLabel.Caption := 'gossipID';
        edgtdata4.EditLabel.Caption := 'customAnim';
        edgtdata5.EditLabel.Caption := 'noDamageImmune';
        edgtdata6.EditLabel.Caption := 'openTextID';
        edgtdata7.EditLabel.Caption := 'losOK';
        edgtdata8.EditLabel.Caption := 'allowMounted';
        edgtdata9.EditLabel.Caption := 'large';
      end;
    3:
      begin
        edgtdata0.EditLabel.Caption := 'lockId';
        edgtdata1.EditLabel.Caption := 'lootId';
        edgtdata2.EditLabel.Caption := 'chestRestockTime';
        edgtdata3.EditLabel.Caption := 'consumable';
        edgtdata4.EditLabel.Caption := 'minSuccessOpens';
        edgtdata5.EditLabel.Caption := 'maxSuccessOpens';
        edgtdata6.EditLabel.Caption := 'eventId';
        edgtdata7.EditLabel.Caption := 'linkedTrapId';
        edgtdata8.EditLabel.Caption := 'questID';
        edgtdata9.EditLabel.Caption := 'level';
        edgtdata10.EditLabel.Caption := 'losOK';
        edgtdata11.EditLabel.Caption := 'leaveLoot';
        edgtdata12.EditLabel.Caption := 'notInCombat';
        edgtdata13.EditLabel.Caption := 'logLoot';
        edgtdata14.EditLabel.Caption := 'openTextID';
        edgtdata15.EditLabel.Caption := 'groupLootRules';
        edgtdata16.EditLabel.Caption := 'floatingTooltip';
      end;
    4:
      begin
      end;
    5:
      begin
        edgtdata0.EditLabel.Caption := 'floatingTooltip';
        edgtdata1.EditLabel.Caption := 'highlight';
        edgtdata2.EditLabel.Caption := 'serverOnly';
        edgtdata3.EditLabel.Caption := 'large';
        edgtdata4.EditLabel.Caption := 'floatOnWater';
        edgtdata5.EditLabel.Caption := 'questID';
      end;
    6:
      begin
        edgtdata0.EditLabel.Caption := 'lockId';
        edgtdata1.EditLabel.Caption := 'level';
        edgtdata2.EditLabel.Caption := 'radius';
        edgtdata3.EditLabel.Caption := 'spellId';
        edgtdata4.EditLabel.Caption := 'charges';
        edgtdata5.EditLabel.Caption := 'cooldown';
        edgtdata6.EditLabel.Caption := 'autoCloseTime';
        edgtdata7.EditLabel.Caption := 'startDelay';
        edgtdata8.EditLabel.Caption := 'serverOnly';
        edgtdata9.EditLabel.Caption := 'stealthed';
        edgtdata10.EditLabel.Caption := 'large';
        edgtdata11.EditLabel.Caption := 'stealthAffected';
        edgtdata12.EditLabel.Caption := 'openTextID';
        edgtdata13.EditLabel.Caption := 'closeTextID';
        edgtdata14.EditLabel.Caption := 'ignoreTotems';
      end;
    7:
      begin
        edgtdata0.EditLabel.Caption := 'slots';
        edgtdata1.EditLabel.Caption := 'height';
        edgtdata2.EditLabel.Caption := 'onlyCreatorUse';
        edgtdata3.EditLabel.Caption := 'triggeredEvent';
      end;
    8:
      begin
        edgtdata0.EditLabel.Caption := 'focusID';
        edgtdata1.EditLabel.Caption := 'dist';
        edgtdata2.EditLabel.Caption := 'linkedTrapId';
        edgtdata3.EditLabel.Caption := 'serverOnly';
        edgtdata4.EditLabel.Caption := 'questID';
        edgtdata5.EditLabel.Caption := 'large';
        edgtdata6.EditLabel.Caption := 'floatingTooltip';
      end;
    9:
      begin
        edgtdata0.EditLabel.Caption := 'pageID';
        edgtdata1.EditLabel.Caption := 'language';
        edgtdata2.EditLabel.Caption := 'pageMaterial';
        edgtdata3.EditLabel.Caption := 'allowMounted';
      end;
    10:
      begin
        edgtdata0.EditLabel.Caption := 'lockId';
        edgtdata1.EditLabel.Caption := 'questID';
        edgtdata2.EditLabel.Caption := 'eventID';
        edgtdata3.EditLabel.Caption := 'autoCloseTime';
        edgtdata4.EditLabel.Caption := 'customAnim';
        edgtdata5.EditLabel.Caption := 'consumable';
        edgtdata6.EditLabel.Caption := 'cooldown';
        edgtdata7.EditLabel.Caption := 'pageID';
        edgtdata8.EditLabel.Caption := 'language';
        edgtdata9.EditLabel.Caption := 'pageMaterial';
        edgtdata10.EditLabel.Caption := 'spellId';
        edgtdata11.EditLabel.Caption := 'noDamageImmune';
        edgtdata12.EditLabel.Caption := 'linkedTrapId';
        edgtdata13.EditLabel.Caption := 'large';
        edgtdata14.EditLabel.Caption := 'openTextID';
        edgtdata15.EditLabel.Caption := 'closeTextID';
        edgtdata16.EditLabel.Caption := 'losOK';
        edgtdata17.EditLabel.Caption := 'allowMounted';
        edgtdata18.EditLabel.Caption := 'floatingTooltip';
        edgtdata19.EditLabel.Caption := 'gossipID';
        edgtdata20.EditLabel.Caption := 'WorldStateSetsState';
      end;
    11:
      begin
        edgtdata0.EditLabel.Caption := 'pause';
        edgtdata1.EditLabel.Caption := 'startOpen';
        edgtdata2.EditLabel.Caption := 'autoCloseTime';
        edgtdata3.EditLabel.Caption := 'pause1EventID';
        edgtdata4.EditLabel.Caption := 'pause2EventID';
      end;
    12:
      begin
        edgtdata0.EditLabel.Caption := 'lockId';
        edgtdata1.EditLabel.Caption := 'radius';
        edgtdata2.EditLabel.Caption := 'damageMin';
        edgtdata3.EditLabel.Caption := 'damageMax';
        edgtdata4.EditLabel.Caption := 'damageSchool';
        edgtdata5.EditLabel.Caption := 'autoCloseTime';
        edgtdata6.EditLabel.Caption := 'openTextID';
        edgtdata7.EditLabel.Caption := 'closeTextID';
      end;
    13:
      begin
        edgtdata0.EditLabel.Caption := 'lockId';
        edgtdata1.EditLabel.Caption := 'camera';
        edgtdata2.EditLabel.Caption := 'eventID';
        edgtdata3.EditLabel.Caption := 'openTextID';
      end;
    14:
      begin
      end;
    15:
      begin
        edgtdata0.EditLabel.Caption := 'taxiPathID';
        edgtdata1.EditLabel.Caption := 'moveSpeed';
        edgtdata2.EditLabel.Caption := 'accelRate';
        edgtdata3.EditLabel.Caption := 'startEventID';
        edgtdata4.EditLabel.Caption := 'stopEventID';
        edgtdata5.EditLabel.Caption := 'transportPhysics';
        edgtdata6.EditLabel.Caption := 'mapID';
        edgtdata7.EditLabel.Caption := 'worldState1';
      end;
    16:
      begin
      end;
    17:
      begin
      end;
    18:
      begin
        edgtdata0.EditLabel.Caption := 'reqParticipants';
        edgtdata1.EditLabel.Caption := 'spellId';
        edgtdata2.EditLabel.Caption := 'animSpell';
        edgtdata3.EditLabel.Caption := 'ritualPersistent';
        edgtdata4.EditLabel.Caption := 'casterTargetSpell';
        edgtdata5.EditLabel.Caption := 'casterTargetSpellTargets';
        edgtdata6.EditLabel.Caption := 'castersGrouped';
        edgtdata7.EditLabel.Caption := 'ritualNoTargetCheck';
      end;
    19:
      begin
      end;
    20:
      begin
      end;
    21:
      begin
        edgtdata0.EditLabel.Caption := 'creatureID';
        edgtdata1.EditLabel.Caption := 'charges';
      end;

    22:
      begin
        edgtdata0.EditLabel.Caption := 'spellId';
        edgtdata1.EditLabel.Caption := 'charges';
        edgtdata2.EditLabel.Caption := 'partyOnly';
        edgtdata3.EditLabel.Caption := 'allowMounted';
        edgtdata4.EditLabel.Caption := 'large';
      end;

    23:
      begin
        edgtdata0.EditLabel.Caption := 'minLevel';
        edgtdata1.EditLabel.Caption := 'maxLevel';
        edgtdata2.EditLabel.Caption := 'areaID';
      end;
    24:
      begin
        edgtdata0.EditLabel.Caption := 'lockId';
        edgtdata1.EditLabel.Caption := 'pickupSpell';
        edgtdata2.EditLabel.Caption := 'radius';
        edgtdata3.EditLabel.Caption := 'returnAura';
        edgtdata4.EditLabel.Caption := 'returnSpell';
        edgtdata5.EditLabel.Caption := 'noDamageImmune';
        edgtdata6.EditLabel.Caption := 'openTextID';
        edgtdata7.EditLabel.Caption := 'losOK';
      end;
    25:
      begin
        edgtdata0.EditLabel.Caption := 'radius';
        edgtdata1.EditLabel.Caption := 'lootId';
        edgtdata2.EditLabel.Caption := 'minSuccessOpens';
        edgtdata3.EditLabel.Caption := 'maxSuccessOpens';
        edgtdata4.EditLabel.Caption := 'lockId';
      end;
    26:
      begin
        edgtdata0.EditLabel.Caption := 'lockId';
        edgtdata1.EditLabel.Caption := 'eventID';
        edgtdata2.EditLabel.Caption := 'pickupSpell';
        edgtdata3.EditLabel.Caption := 'noDamageImmune';
        edgtdata4.EditLabel.Caption := 'openTextID';
      end;
    27:
      begin
        edgtdata0.EditLabel.Caption := 'gameType';
      end;
    28:
      begin
      end;
    29:
      begin
        edgtdata0.EditLabel.Caption := 'radius';
        edgtdata1.EditLabel.Caption := 'spell';
        edgtdata2.EditLabel.Caption := 'worldState1';
        edgtdata3.EditLabel.Caption := 'worldstate2';
        edgtdata4.EditLabel.Caption := 'winEventID1';
        edgtdata5.EditLabel.Caption := 'winEventID2';
        edgtdata6.EditLabel.Caption := 'contestedEventID1';
        edgtdata7.EditLabel.Caption := 'contestedEventID2';
        edgtdata8.EditLabel.Caption := 'progressEventID1';
        edgtdata9.EditLabel.Caption := 'progressEventID2';
        edgtdata10.EditLabel.Caption := 'neutralEventID1';
        edgtdata11.EditLabel.Caption := 'neutralEventID2';
        edgtdata12.EditLabel.Caption := 'neutralPercent';
        edgtdata13.EditLabel.Caption := 'worldstate3';
        edgtdata14.EditLabel.Caption := 'minSuperiority';
        edgtdata15.EditLabel.Caption := 'maxSuperiority';
        edgtdata16.EditLabel.Caption := 'minTime';
        edgtdata17.EditLabel.Caption := 'maxTime';
        edgtdata18.EditLabel.Caption := 'large';
        edgtdata19.EditLabel.Caption := 'highlight';
        edgtdata20.EditLabel.Caption := 'startingValue';
        edgtdata21.EditLabel.Caption := 'unidirectional';
      end;
    30:
      begin
        edgtdata0.EditLabel.Caption := 'startOpen';
        edgtdata1.EditLabel.Caption := 'radius';
        edgtdata2.EditLabel.Caption := 'auraID1';
        edgtdata3.EditLabel.Caption := 'conditionID1';
        edgtdata4.EditLabel.Caption := 'auraID2';
        edgtdata5.EditLabel.Caption := 'conditionID2';
        edgtdata6.EditLabel.Caption := 'serverOnly';
      end;
    31:
      begin
        edgtdata0.EditLabel.Caption := 'mapID';
        edgtdata1.EditLabel.Caption := 'difficulty';
      end;
	32:
	  begin
        edgtdata0.EditLabel.Caption := 'chairheight';
        edgtdata1.EditLabel.Caption := 'heightOffset';
	  end;
	33:
	  begin
        edgtdata0.EditLabel.Caption := 'intactNumHits';
        edgtdata1.EditLabel.Caption := 'creditProxyCreature';
        edgtdata2.EditLabel.Caption := 'empty1';
        edgtdata3.EditLabel.Caption := 'intactEvent';
        edgtdata4.EditLabel.Caption := 'empty2';
        edgtdata5.EditLabel.Caption := 'damagedNumHits';
        edgtdata6.EditLabel.Caption := 'empty3';
        edgtdata7.EditLabel.Caption := 'empty4';
        edgtdata8.EditLabel.Caption := 'empty5';
        edgtdata9.EditLabel.Caption := 'damagedEvent';
        edgtdata10.EditLabel.Caption := 'empty6';
        edgtdata11.EditLabel.Caption := 'empty7';
        edgtdata12.EditLabel.Caption := 'empty8';
        edgtdata13.EditLabel.Caption := 'empty9';
        edgtdata14.EditLabel.Caption := 'destroyedEvent';
        edgtdata15.EditLabel.Caption := 'empty10';
        edgtdata16.EditLabel.Caption := 'debuildingTimeSecs';
        edgtdata17.EditLabel.Caption := 'empty11';
        edgtdata18.EditLabel.Caption := 'destructibleData';
        edgtdata19.EditLabel.Caption := 'rebuildingEvent';
        edgtdata20.EditLabel.Caption := 'empty12';
        edgtdata21.EditLabel.Caption := 'empty13';
        edgtdata22.EditLabel.Caption := 'damageEvent';
        edgtdata23.EditLabel.Caption := 'empty14';
	  end;
	34:
	  begin
	  end;
	35:
	  begin
        edgtdata0.EditLabel.Caption := 'whenToPause';
        edgtdata1.EditLabel.Caption := 'startOpen';
        edgtdata2.EditLabel.Caption := 'autoClose';
	  end;
  end;
end;

procedure TMainForm.btFullScriptProsLootClick(Sender: TObject);
begin
  PageControl5.ActivePageIndex := SCRIPT_TAB_NO_ITEM;
  ShowFullLootScript('prospecting_loot_template', lvitProsLoot, meitScript, editentry.Text);
end;

procedure TMainForm.btProsLootAddClick(Sender: TObject);
begin
  LootAdd('edip', lvitProsLoot);
end;

procedure TMainForm.btProsLootUpdClick(Sender: TObject);
begin
  LootUpd('edip', lvitProsLoot);
end;

procedure TMainForm.btProsLootDelClick(Sender: TObject);
begin
  LootDel(lvitProsLoot);
end;

procedure TMainForm.lvitProsLootChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btProsLootUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btProsLootDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvitProsLootSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetLootEditFields('edip', lvitProsLoot);
end;

procedure TMainForm.lvitReferenceLootChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btReferenceLootUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btReferenceLootDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvitReferenceLootSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetLootEditFields('edir', lvitReferenceLoot);
end;

procedure TMainForm.lvslSpellLootChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btSpellLootUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btSpellLootDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvslSpellLootSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetLootEditFields('edsl', lvslSpellLoot);
end;

procedure TMainForm.lvQuickListClick(Sender: TObject);
begin
  edit.Text := lvQuickList.Selected.Caption;
  PostMessage(MainForm.Handle, WM_FREEQL, 0, 0);
end;

procedure TMainForm.lvQuickListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_escape then
    PostMessage(MainForm.Handle, WM_FREEQL, 0, 0);
end;

procedure TMainForm.lvQuickListMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  lvQuickList.Selected := TListItem(lvQuickList.GetItemAt(X, Y));
end;

procedure TMainForm.LoadQuestCompleteScript(Sender: TObject);
var
  id: integer;
begin
  id := StrToIntDef(TCustomEdit(Sender).Text, 0);
  if (id < 1) then
    Exit;
  LoadQueryToListView(Format('SELECT * FROM `%s` WHERE (`id`=%d)', [SCRIPT_TABLE_QUEST_END, id]), lvesEndScript);
end;

procedure TMainForm.LoadQuestStartScript(Sender: TObject);
var
  id: integer;
begin
  id := StrToIntDef(TCustomEdit(Sender).Text, 0);
  if (id < 1) then
    Exit;
  LoadQueryToListView(Format('SELECT * FROM `%s` WHERE (`id`=%d)', [SCRIPT_TABLE_QUEST_START, id]), lvssStartScript);
end;

procedure TMainForm.lvssStartScriptChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btssUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btssDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvesEndScriptChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btesUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btesDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvssStartScriptSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetScriptEditFields('edss', lvssStartScript);
end;

procedure TMainForm.lvqtTakerTemplateChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btDelQuestTaker.Enabled := Assigned(lvqtTakerTemplate.Selected);
end;

procedure TMainForm.lvqtTakerTemplateDblClick(Sender: TObject);
begin
  if Assigned(lvqtTakerTemplate.Selected) then
    EditThis(lvqtTakerTemplate.Selected.Caption, lvqtTakerTemplate.Selected.SubItems[0]);
end;

procedure TMainForm.lvqtTakerTemplateSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    LoadQuestTakerInfo(Item.Caption, Item.SubItems[0]);
end;

procedure TMainForm.lvesEndScriptSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetScriptEditFields('edes', lvesEndScript);
end;

procedure TMainForm.lvqtGiverTemplateChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btDelQuestGiver.Enabled := Assigned(lvqtGiverTemplate.Selected);
end;

procedure TMainForm.lvqtGiverTemplateDblClick(Sender: TObject);
begin
  if Assigned(lvqtGiverTemplate.Selected) then
    EditThis(lvqtGiverTemplate.Selected.Caption, lvqtGiverTemplate.Selected.SubItems[0]);
end;

procedure TMainForm.lvqtGiverTemplateSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
  begin
    LoadQuestGiverInfo(Item.Caption, Item.SubItems[0]);
    LoadQuestGiverGreeting(Item.Caption, Item.SubItems[0]);
  end;
end;

procedure TMainForm.SetScriptEditFields(pfx: string; lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      TCustomEdit(FindComponent(pfx + 'id')).Text := Caption;
      TCustomEdit(FindComponent(pfx + 'delay')).Text := SubItems[0];
      TCustomEdit(FindComponent(pfx + 'command')).Text := SubItems[1];
      TCustomEdit(FindComponent(pfx + 'datalong')).Text := SubItems[2];
      TCustomEdit(FindComponent(pfx + 'datalong2')).Text := SubItems[3];
      TCustomEdit(FindComponent(pfx + 'datalong3')).Text := SubItems[4];
      TCustomEdit(FindComponent(pfx + 'buddy_entry')).Text := SubItems[5];
      TCustomEdit(FindComponent(pfx + 'search_radius')).Text := SubItems[6];
      TCustomEdit(FindComponent(pfx + 'data_flags')).Text := SubItems[7];
      TCustomEdit(FindComponent(pfx + 'dataint')).Text := SubItems[8];
      TCustomEdit(FindComponent(pfx + 'dataint2')).Text := SubItems[9];
      TCustomEdit(FindComponent(pfx + 'dataint3')).Text := SubItems[10];
      TCustomEdit(FindComponent(pfx + 'dataint4')).Text := SubItems[11];
      TCustomEdit(FindComponent(pfx + 'x')).Text := SubItems[12];
      TCustomEdit(FindComponent(pfx + 'y')).Text := SubItems[13];
      TCustomEdit(FindComponent(pfx + 'z')).Text := SubItems[14];
      TCustomEdit(FindComponent(pfx + 'o')).Text := SubItems[15];
      TCustomEdit(FindComponent(pfx + 'comments')).Text := SubItems[16];
    end;
  end;
end;

procedure TMainForm.ScriptAdd(pfx: string; lvList: TJvListView);
begin
  with lvList.Items.Add do
  begin
    Caption := TCustomEdit(FindComponent(pfx + 'id')).Text;
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'delay')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'command')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'datalong')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'datalong2')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'datalong3')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'buddy_entry')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'search_radius')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'data_flags')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'dataint')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'dataint2')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'dataint3')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'dataint4')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'x')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'y')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'z')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'o')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'comments')).Text);
  end;
end;

procedure TMainForm.ScriptUpd(pfx: string; lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      Caption := TCustomEdit(FindComponent(pfx + 'id')).Text;
      SubItems[0] := TCustomEdit(FindComponent(pfx + 'delay')).Text;
      SubItems[1] := TCustomEdit(FindComponent(pfx + 'command')).Text;
      SubItems[2] := TCustomEdit(FindComponent(pfx + 'datalong')).Text;
      SubItems[3] := TCustomEdit(FindComponent(pfx + 'datalong2')).Text;
      SubItems[4] := TCustomEdit(FindComponent(pfx + 'datalong3')).Text;
      SubItems[5] := TCustomEdit(FindComponent(pfx + 'buddy_entry')).Text;
      SubItems[6] := TCustomEdit(FindComponent(pfx + 'search_radius')).Text;
      SubItems[7] := TCustomEdit(FindComponent(pfx + 'data_flags')).Text;
      SubItems[8] := TCustomEdit(FindComponent(pfx + 'dataint')).Text;
      SubItems[9] := TCustomEdit(FindComponent(pfx + 'dataint2')).Text;
      SubItems[10] := TCustomEdit(FindComponent(pfx + 'dataint3')).Text;
      SubItems[11] := TCustomEdit(FindComponent(pfx + 'dataint4')).Text;
      SubItems[12] := TCustomEdit(FindComponent(pfx + 'x')).Text;
      SubItems[13] := TCustomEdit(FindComponent(pfx + 'y')).Text;
      SubItems[14] := TCustomEdit(FindComponent(pfx + 'z')).Text;
      SubItems[15] := TCustomEdit(FindComponent(pfx + 'o')).Text;
      SubItems[16] := TCustomEdit(FindComponent(pfx + 'comments')).Text;
    end;
  end;
end;

procedure TMainForm.ScriptDel(lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
    lvList.DeleteSelected;
end;

procedure TMainForm.SetRandomTemplatesScriptEditFields(pfx: string; lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      TCustomEdit(FindComponent(pfx + 'id')).Text := Caption;
      TCustomEdit(FindComponent(pfx + 'type')).Text := SubItems[0];
      TCustomEdit(FindComponent(pfx + 'target_id')).Text := SubItems[1];
      TCustomEdit(FindComponent(pfx + 'chance')).Text := SubItems[2];
      TCustomEdit(FindComponent(pfx + 'comments')).Text := SubItems[3];
    end;
  end;
end;

procedure TMainForm.RandomTemplatesScriptAdd(pfx: string; lvList: TJvListView);
begin
  with lvList.Items.Add do
  begin
    Caption := TCustomEdit(FindComponent(pfx + 'id')).Text;
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'type')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'target_id')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'chance')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'comments')).Text);
  end;
end;

procedure TMainForm.RandomTemplatesScriptUpd(pfx: string; lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      Caption := TCustomEdit(FindComponent(pfx + 'id')).Text;
      SubItems[0] := TCustomEdit(FindComponent(pfx + 'type')).Text;
      SubItems[1] := TCustomEdit(FindComponent(pfx + 'target_id')).Text;
      SubItems[2] := TCustomEdit(FindComponent(pfx + 'chance')).Text;
      SubItems[3] := TCustomEdit(FindComponent(pfx + 'comments')).Text;
    end;
  end;
end;

procedure TMainForm.btssAddClick(Sender: TObject);
begin
  ScriptAdd('edss', lvssStartScript);
end;

procedure TMainForm.btssUpdClick(Sender: TObject);
begin
  ScriptUpd('edss', lvssStartScript);
end;

procedure TMainForm.btssDelClick(Sender: TObject);
begin
  ScriptDel(lvssStartScript);
end;

procedure TMainForm.btesAddClick(Sender: TObject);
begin
  ScriptAdd('edes', lvesEndScript);
end;

procedure TMainForm.btesUpdClick(Sender: TObject);
begin
  ScriptUpd('edes', lvesEndScript);
end;

procedure TMainForm.btesDelClick(Sender: TObject);
begin
  ScriptDel(lvesEndScript);
end;

procedure TMainForm.GetDataFlags(Sender: TObject);
begin
  GetSomeFlags(Sender, 'DataFlags');
end;

procedure TMainForm.GetCommand(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 135, 'ScriptCommand', false);
end;

procedure TMainForm.edsscommandChange(Sender: TObject);
begin
  ChangeScriptCommand(StrToIntDef(TJvComboEdit(Sender).Text, 0), 'ss');
end;

procedure TMainForm.edescommandChange(Sender: TObject);
begin
  ChangeScriptCommand(StrToIntDef(TJvComboEdit(Sender).Text, 0), 'es');
end;

procedure TMainForm.edcmscommandChange(Sender: TObject);
begin
  ChangeScriptCommand(StrToIntDef(TJvComboEdit(Sender).Text, 0), 'cms');
end;

procedure TMainForm.edcdscommandChange(Sender: TObject);
begin
  ChangeScriptCommand(StrToIntDef(TJvComboEdit(Sender).Text, 0), 'cds');
end;

procedure TMainForm.edgbcommandChange(Sender: TObject);
begin
  ChangeScriptCommand(StrToIntDef(TJvComboEdit(Sender).Text, 0), 'gb');
end;

procedure TMainForm.edgtbcommandChange(Sender: TObject);
begin
  ChangeScriptCommand(StrToIntDef(TJvComboEdit(Sender).Text, 0), 'gtb');
end;

procedure TMainForm.eddoecommandChange(Sender: TObject);
begin
  ChangeScriptCommand(StrToIntDef(TJvComboEdit(Sender).Text, 0), 'doe');
end;

procedure TMainForm.eddogcommandChange(Sender: TObject);
begin
  ChangeScriptCommand(StrToIntDef(TJvComboEdit(Sender).Text, 0), 'dog');
end;

procedure TMainForm.eddoscommandChange(Sender: TObject);
begin
  ChangeScriptCommand(StrToIntDef(TJvComboEdit(Sender).Text, 0), 'dos');
end;

procedure TMainForm.eddorcommandChange(Sender: TObject);
begin
  ChangeScriptCommand(StrToIntDef(TJvComboEdit(Sender).Text, 0), 'dor');
end;

procedure TMainForm.ChangeScriptCommand(command: Integer; pfx: string);
begin
  TJvComboEdit(FindComponent('ed' + pfx + 'buddy_entry')).Hint := 'field contains target ID (creature_template.entry / gameobject_template.entry)';
  TJvComboEdit(FindComponent('ed' + pfx + 'search_radius')).Hint := 'the radius in which the target (specified in the buddy_entry) will be searched';
  TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := '';
  TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).ShowButton := false;
  TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).Hint := '';
  TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).ShowButton := false;
  TJvComboEdit(FindComponent('ed' + pfx + 'datalong3')).Hint := '';
  TJvComboEdit(FindComponent('ed' + pfx + 'dataint')).Hint := '';
  TJvComboEdit(FindComponent('ed' + pfx + 'dataint2')).Hint := '';
  TJvComboEdit(FindComponent('ed' + pfx + 'dataint3')).Hint := '';
  TJvComboEdit(FindComponent('ed' + pfx + 'dataint4')).Hint := '';
  TJvComboEdit(FindComponent('ed' + pfx + 'x')).Hint := '';
  TJvComboEdit(FindComponent('ed' + pfx + 'y')).Hint := '';
  TJvComboEdit(FindComponent('ed' + pfx + 'z')).Hint := '';
  TJvComboEdit(FindComponent('ed' + pfx + 'o')).Hint := '';
  case command of
    0:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'dbscript_random_templates.id';
        TJvComboEdit(FindComponent('ed' + pfx + 'dataint')).Hint := 'text to say';
        TJvComboEdit(FindComponent('ed' + pfx + 'dataint2')).Hint := 'optional for random selected texts';
        TJvComboEdit(FindComponent('ed' + pfx + 'dataint3')).Hint := 'optional for random selected texts';
        TJvComboEdit(FindComponent('ed' + pfx + 'dataint4')).Hint := 'optional for random selected texts';
      end;
    1:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'emote id from dbc';
        TJvComboEdit(FindComponent('ed' + pfx + 'dataint')).Hint := 'optional for random selected emotes';
        TJvComboEdit(FindComponent('ed' + pfx + 'dataint2')).Hint := 'optional for random selected emotes';
        TJvComboEdit(FindComponent('ed' + pfx + 'dataint3')).Hint := 'optional for random selected emotes';
        TJvComboEdit(FindComponent('ed' + pfx + 'dataint4')).Hint := 'optional for random selected emotes';
      end;
    2:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'field index';
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).Hint := 'value to set';
      end;
    3:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).Hint := 'travel_speed*100 (use 0 for creature default movement)';
        TJvComboEdit(FindComponent('ed' + pfx + 'x')).Hint := 'destination coord x';
        TJvComboEdit(FindComponent('ed' + pfx + 'y')).Hint := 'destination coord y';
        TJvComboEdit(FindComponent('ed' + pfx + 'z')).Hint := 'destination coord z';
        TJvComboEdit(FindComponent('ed' + pfx + 'o')).Hint := 'orientation';
      end;
    4:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'field index';
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).Hint := 'BitMask';
      end;
    5:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'field index';
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).Hint := 'BitMask';
      end;
    6:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'map id from dbc';
        TJvComboEdit(FindComponent('ed' + pfx + 'x')).Hint := 'destination coord x';
        TJvComboEdit(FindComponent('ed' + pfx + 'y')).Hint := 'destination coord y';
        TJvComboEdit(FindComponent('ed' + pfx + 'z')).Hint := 'destination coord z';
        TJvComboEdit(FindComponent('ed' + pfx + 'o')).Hint := 'orientation';
      end;
    7:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'quest_template.entry';
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).Hint := 'Distance between NPC/object and player';
      end;
    8:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'quest_template.ReqCreatureOrGOId (or 0 for target-entry)';
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).Hint := 'bool (0=personal credit, 1=group credit)';
      end;
    9, 11, 12:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'gameobject.guid (if 0 then set GO id in buddy_entry)';
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).Hint := 'Time in seconds';
      end;
    10:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'creature_template.entry to summon';
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).Hint := 'lifetime of creature (in ms)';
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong3')).Hint := 'creature_movement_template.pathId';
        TJvComboEdit(FindComponent('ed' + pfx + 'dataint')).Hint := '(bool) setRun; 0 = off (default), 1 = on';
        TJvComboEdit(FindComponent('ed' + pfx + 'dataint2')).Hint := 'factionId - if 0 is set, faction is from DB entry';
        TJvComboEdit(FindComponent('ed' + pfx + 'dataint3')).Hint := 'modelId - if 0 is set, model is from DB entry';
        TJvComboEdit(FindComponent('ed' + pfx + 'x')).Hint := 'coord x';
        TJvComboEdit(FindComponent('ed' + pfx + 'y')).Hint := 'coord y';
        TJvComboEdit(FindComponent('ed' + pfx + 'z')).Hint := 'coord z';
        TJvComboEdit(FindComponent('ed' + pfx + 'o')).Hint := 'orientation';
      end;
    14:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'spellid from dbc';
      end;
    15:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'spellid from dbc';
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).Hint := 'castFlags';
        TJvComboEdit(FindComponent('ed' + pfx + 'dataint')).Hint := 'optional for random selected spell';
        TJvComboEdit(FindComponent('ed' + pfx + 'dataint2')).Hint := 'optional for random selected spell';
        TJvComboEdit(FindComponent('ed' + pfx + 'dataint3')).Hint := 'optional for random selected spell';
        TJvComboEdit(FindComponent('ed' + pfx + 'dataint4')).Hint := 'optional for random selected spell';
      end;
    16:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'sound_id from dbc';
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).Hint := 'bitmask: 0/1=target-player, 0/2=with distance dependent, 0/4=map wide, 0/8=zone wide';
      end;
    17:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'item_template.entry';
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).Hint := 'Amount';
      end;
    18:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'Despawn delay in ms';
      end;
    19:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'movie id from dbc';
      end;
    20:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'MovementType (0:idle, 1:random or 2:waypoint)';
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).Hint := 'wander-distance/pathId';
      end;
    21, 25:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'bool 0=off, 1=on';
      end;
    22:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'factionId';
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).Hint := 'faction_flags';
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).ShowButton := true;
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).OnButtonClick := GetFactionFlags;
      end;
    23, 24:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'creature entry/modelid';
      end;
    27:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := '1=lock, 2=unlock, 4=set not-interactable, 8=set interactable';
      end;
    28:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'stand state';
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).ShowButton := true;
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).OnButtonClick := GetStandState;
      end;
    29:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'NPCFlags';
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).Hint := '0x00=toggle, 0x01=add, 0x02=remove';
      end;
    30:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'taxi path id (source or target must be player)';
      end;
	31:
	  begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'search for npc entry if provided';
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).Hint := 'search distance';
        TJvComboEdit(FindComponent('ed' + pfx + 'dataint')).Hint := 'diff to change a waittime of current Waypoint Movement';
	  end;
    32:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := '0: unpause waypoint 1: pause waypoint';
      end;
    33:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'bool (0=off, 1=on)';
      end;
    34:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'condition_id';
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).Hint := 'if != 0 then quest_id of quest that will be failed for player`s group if the script is terminated';
      end;
    35:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'AIEventType';
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).Hint := 'radius. If radius isn`t provided and the target is a creature, then send AIEvent to target';
      end;
    36:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := '!= 0 Reset TargetGuid, Reset orientation';
      end;
    37:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'if = 0: Move resSource towards resTarget' + 'if != 0: Move resSource to a random point between datalong2..datalong around resTarget.';
        TJvComboEdit(FindComponent('ed' + pfx + 'o')).Hint := 'if != 0: Obtain a random point around resTarget in direction of orientation';
      end;
	38:
	  begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'Send mailTemplateId from resSource (if provided) to player resTarget';
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).Hint := 'AlternativeSenderEntry. Use as sender-Entry';
        TJvComboEdit(FindComponent('ed' + pfx + 'dataint')).Hint := 'Delay (>= 0) in Seconds';
	  end;
    39:
      begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'bool 0=off, 1=on';
      end;
	42:
	  begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'resetDefault: bool 0=false, 1=true';
        TJvComboEdit(FindComponent('ed' + pfx + 'dataint')).Hint := 'main hand slot';
        TJvComboEdit(FindComponent('ed' + pfx + 'dataint2')).Hint := 'ranged slot';
	  end;
	44:
	  begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'new creature entry. Must be different than the current one';
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).Hint := 'faction for which the entry is updated. 0 = Alliance, 1 = Horde';
	  end;
	45:
	  begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'dbscripts_on_relay id';
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).Hint := 'dbscript_random_templates id';
	  end;
	46:
	  begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'spell id from dbc';
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong2')).Hint := 'CastFlags';
        TJvComboEdit(FindComponent('ed' + pfx + 'dataint')).Hint := 'define the &bp for the spell';
        TJvComboEdit(FindComponent('ed' + pfx + 'dataint2')).Hint := 'define the &bp for the spell.';
        TJvComboEdit(FindComponent('ed' + pfx + 'dataint3')).Hint := 'define the &bp for the spell.';
	  end;
	47:
	  begin
        TJvComboEdit(FindComponent('ed' + pfx + 'datalong')).Hint := 'SpellType';
	  end;
  end;
end;

procedure TMainForm.GetStandState(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 0, 'StandState', false);
end;

procedure TMainForm.GetFactionFlags(Sender: TObject);
begin
  GetSomeFlags(Sender, 'FactionFlags');
end;

procedure TMainForm.ChangeConditionType(condition_type: Integer; pfx: string);
begin
  case condition_type of
    -3:
      begin
	    edconvalue1.EditLabel.Caption := 'condition_entry';
        edconvalue2.EditLabel.Caption := 'value2';
        TJvComboEdit(FindComponent('ed' + pfx + 'value2')).Hint := 'always 0';
      end;
    -2:
      begin
	    edconvalue1.EditLabel.Caption := 'condition_entry';
	    edconvalue2.EditLabel.Caption := 'condition_entry';
      end;
    -1:
      begin
	    edconvalue1.EditLabel.Caption := 'condition_entry';
	    edconvalue2.EditLabel.Caption := 'condition_entry';
      end;
    0:
      begin
	    edconvalue1.EditLabel.Caption := 'value1';
        TJvComboEdit(FindComponent('ed' + pfx + 'value1')).Hint := 'always 0';
        edconvalue2.EditLabel.Caption := 'value2';
        TJvComboEdit(FindComponent('ed' + pfx + 'value2')).Hint := 'always 0';
      end;
    1,11,32:
      begin
	    edconvalue1.EditLabel.Caption := 'spell_id';
        TJvComboEdit(FindComponent('ed' + pfx + 'value1')).Hint := 'Spell.dbc';
	    edconvalue2.EditLabel.Caption := 'effindex';
        TJvComboEdit(FindComponent('ed' + pfx + 'value2')).Hint := '0, 1, 2';
      end;
    2,16,23,24:
      begin
	    edconvalue1.EditLabel.Caption := 'item_id';
        TJvComboEdit(FindComponent('ed' + pfx + 'value1')).Hint := 'item_template.entry';
	    edconvalue2.EditLabel.Caption := 'count';
        TJvComboEdit(FindComponent('ed' + pfx + 'value2')).Hint := 'required number of items';
      end;
    3:
      begin
	    edconvalue1.EditLabel.Caption := 'item_id';
        TJvComboEdit(FindComponent('ed' + pfx + 'value1')).Hint := 'item_template.entry';
        edconvalue2.EditLabel.Caption := 'value2';
        TJvComboEdit(FindComponent('ed' + pfx + 'value2')).Hint := 'always 0';
      end;
    4:
      begin
	    edconvalue1.EditLabel.Caption := 'area_id';
        TJvComboEdit(FindComponent('ed' + pfx + 'value1')).Hint := 'AreaTable.dbc';
        edconvalue2.EditLabel.Caption := 'value2';
        TJvComboEdit(FindComponent('ed' + pfx + 'value2')).Hint := '0: in (sub)area'#13#10 + '1: not in (sub)area';
      end;
    5:
      begin
	    edconvalue1.EditLabel.Caption := 'faction_id';
        TJvComboEdit(FindComponent('ed' + pfx + 'value1')).Hint := 'Faction.dbc';
	    edconvalue2.EditLabel.Caption := 'min_rank';
        TJvComboEdit(FindComponent('ed' + pfx + 'value2')).Hint := '0-7';
      end;
    6:
      begin
	    edconvalue1.EditLabel.Caption := 'player_team';
        TJvComboEdit(FindComponent('ed' + pfx + 'value1')).Hint := '469 - Alliance, 67 - Horde';
        edconvalue2.EditLabel.Caption := 'value2';
        TJvComboEdit(FindComponent('ed' + pfx + 'value2')).Hint := 'always 0';
      end;
    7,29:
      begin
	    edconvalue1.EditLabel.Caption := 'skill_id';
        TJvComboEdit(FindComponent('ed' + pfx + 'value1')).Hint := 'SkillLine.dbc';
	    edconvalue2.EditLabel.Caption := 'skill_value';
        TJvComboEdit(FindComponent('ed' + pfx + 'value2')).Hint := '1-400';
      end;
    8,19,22:
      begin
	    edconvalue1.EditLabel.Caption := 'quest_id';
        TJvComboEdit(FindComponent('ed' + pfx + 'value1')).Hint := 'quest_template.entry';
        edconvalue2.EditLabel.Caption := 'value2';
        TJvComboEdit(FindComponent('ed' + pfx + 'value2')).Hint := 'always 0';
      end;
    9:
      begin
	    edconvalue1.EditLabel.Caption := 'quest_id';
        TJvComboEdit(FindComponent('ed' + pfx + 'value1')).Hint := 'quest_template.entry';
        edconvalue2.EditLabel.Caption := 'value2';
        TJvComboEdit(FindComponent('ed' + pfx + 'value2')).Hint := '0 any state'#13#10 + '1 if quest incomplete'#13#10 + '2 if quest completed';
      end;
    12,25:
      begin
	    edconvalue1.EditLabel.Caption := 'event_id';
        TJvComboEdit(FindComponent('ed' + pfx + 'value1')).Hint := 'game_event.entry';
        edconvalue2.EditLabel.Caption := 'value2';
        TJvComboEdit(FindComponent('ed' + pfx + 'value2')).Hint := 'always 0';
      end;
    13:
      begin
	    edconvalue1.EditLabel.Caption := 'area_flag';
        edconvalue2.EditLabel.Caption := 'area_flag_not';
      end;
    14:
      begin
	    edconvalue1.EditLabel.Caption := 'race_mask';
        edconvalue2.EditLabel.Caption := 'class_mask';
      end;
    15:
      begin
	    edconvalue1.EditLabel.Caption := 'player_level';
        edconvalue2.EditLabel.Caption := 'value2';
        TJvComboEdit(FindComponent('ed' + pfx + 'value2')).Hint := '0: equal to'#13#10 + '1: equal or higher than'#13#10 + '2: equal or less than';
      end;
    17:
      begin
	    edconvalue1.EditLabel.Caption := 'spell_id';
        TJvComboEdit(FindComponent('ed' + pfx + 'value1')).Hint := 'Spell.dbc';
        edconvalue2.EditLabel.Caption := 'value2';
        TJvComboEdit(FindComponent('ed' + pfx + 'value2')).Hint := '0: has spell'#13#10 + '1: has not spell';
      end;
    18:
      begin
	    edconvalue1.EditLabel.Caption := 'instance_condition_id';
        edconvalue2.EditLabel.Caption := 'value2';
        TJvComboEdit(FindComponent('ed' + pfx + 'value2')).Hint := 'always 0';
      end;
    20,21:
      begin
	    edconvalue1.EditLabel.Caption := 'achievement_id';
        TJvComboEdit(FindComponent('ed' + pfx + 'value1')).Hint := 'Achievement.dbc';
        edconvalue2.EditLabel.Caption := 'value2';
        TJvComboEdit(FindComponent('ed' + pfx + 'value2')).Hint := '0: has achievement'#13#10 + '1: has not achievement';
      end;
    26,27:
      begin
	    edconvalue1.EditLabel.Caption := 'holiday_id';
        TJvComboEdit(FindComponent('ed' + pfx + 'value1')).Hint := 'Holidays.dbc';
        edconvalue2.EditLabel.Caption := 'value2';
        TJvComboEdit(FindComponent('ed' + pfx + 'value2')).Hint := 'always 0';
      end;
    28:
      begin
	    edconvalue1.EditLabel.Caption := 'spell_id';
        TJvComboEdit(FindComponent('ed' + pfx + 'value1')).Hint := 'Spell.dbc';
		if edconvalue2.Text <> '0' then
          edconvalue2.EditLabel.Caption := 'item_id'
		else
		  edconvalue2.EditLabel.Caption := 'value2';
      end;
    30:
      begin
	    edconvalue1.EditLabel.Caption := 'faction_id';
        TJvComboEdit(FindComponent('ed' + pfx + 'value1')).Hint := 'Faction.dbc';
	    edconvalue2.EditLabel.Caption := 'max_rank';
        TJvComboEdit(FindComponent('ed' + pfx + 'value2')).Hint := '0-7';
      end;
    31:
      begin
	    edconvalue1.EditLabel.Caption := 'encounter_id';
        TJvComboEdit(FindComponent('ed' + pfx + 'value1')).Hint := 'DungeonEncounter.dbc';
	    edconvalue2.EditLabel.Caption := 'encounter_id2';
        TJvComboEdit(FindComponent('ed' + pfx + 'value2')).Hint := 'DungeonEncounter.dbc';
      end;
    33:
      begin
	    edconvalue1.EditLabel.Caption := 'waypoint_id';
        TJvComboEdit(FindComponent('ed' + pfx + 'value1')).Hint := 'creature_movement.point or creature_movement_template.point';
        edconvalue2.EditLabel.Caption := 'value2';
	    TJvComboEdit(FindComponent('ed' + pfx + 'value2')).Hint := '0 = exact'#13#10 + '1: wp <= waypointId'#13#10 + '2: wp > waypointId';
      end;
    34:
      begin
	    edconvalue1.EditLabel.Caption := 'xp';
        TJvComboEdit(FindComponent('ed' + pfx + 'value1')).Hint := '0: XP off, 1: XP on';
        edconvalue2.EditLabel.Caption := 'value2';
        TJvComboEdit(FindComponent('ed' + pfx + 'value2')).Hint := 'always 0';
      end;
    35:
      begin
	    edconvalue1.EditLabel.Caption := 'gender';
        TJvComboEdit(FindComponent('ed' + pfx + 'value1')).Hint := '0=male'#13#10 + '1=female'#13#10 + '2=none';
        edconvalue2.EditLabel.Caption := 'value2';
        TJvComboEdit(FindComponent('ed' + pfx + 'value2')).Hint := 'always 0';
      end;
    36:
      begin
	    edconvalue1.EditLabel.Caption := 'value1';
	    TJvComboEdit(FindComponent('ed' + pfx + 'value1')).Hint := '0=player dead'#13#10 +
          '1=player is dead (with group dead)'#13#10 +
          '2=player in instance are dead'#13#10 +
          '3=creature is dead';
        edconvalue2.EditLabel.Caption := 'value2';
        TJvComboEdit(FindComponent('ed' + pfx + 'value2')).Hint := 'if != 0 only consider players'#13#10 + 'in range of this value';
      end;
    37:
      begin
	    edconvalue1.EditLabel.Caption := 'creature_id';
        edconvalue2.EditLabel.Caption := 'range';
      end;
    38:
      begin
	    edconvalue1.EditLabel.Caption := 'zone_id';
        TJvComboEdit(FindComponent('ed' + pfx + 'value1')).Hint := 'AreaTable.dbc';
        edconvalue2.EditLabel.Caption := 'value2';
        TJvComboEdit(FindComponent('ed' + pfx + 'value2')).Hint := '0: Alliance, 1: Horde';
      end;
    39:
      begin
	    edconvalue1.EditLabel.Caption := 'creature_id';
        edconvalue2.EditLabel.Caption := 'count';
      end;
    else
	  begin
	    edconvalue1.EditLabel.Caption := 'value1';
        edconvalue2.EditLabel.Caption := 'value2';
	  end;
  end;
end;

procedure TMainForm.CheckforUpdates1Click(Sender: TObject);
begin
  CheckForUpdates(true);
end;

procedure TMainForm.lvitEnchantmentChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btieEnchUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btieEnchDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvitEnchantmentSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetEnchEditFields('edie', lvitEnchantment);
end;

procedure TMainForm.btieEnchAddClick(Sender: TObject);
begin
  EnchAdd('edie', lvitEnchantment);
end;

procedure TMainForm.btieEnchUpdClick(Sender: TObject);
begin
  EnchUpd('edie', lvitEnchantment);
end;

procedure TMainForm.btieEnchDelClick(Sender: TObject);
begin
  EnchDel(lvitEnchantment);
end;

procedure TMainForm.btieShowFullScriptClick(Sender: TObject);
var
  id: string;
begin
  PageControl5.ActivePageIndex := SCRIPT_TAB_NO_ITEM;

  if editRandomProperty.Text <> '0' then
    id := editRandomProperty.Text
  else
    id := editRandomSuffix.Text;
  ShowFullEnchScript('item_enchantment_template', lvitEnchantment, meitScript, id);
end;

procedure TMainForm.EnchAdd(pfx: string; lvList: TJvListView);
begin
  with lvList.Items.Add do
  begin
    Caption := TCustomEdit(FindComponent(pfx + 'entry')).Text;
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'ench')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'chance')).Text);
  end;
end;

procedure TMainForm.EnchUpd(pfx: string; lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      Caption := TCustomEdit(FindComponent(pfx + 'entry')).Text;
      SubItems[0] := TCustomEdit(FindComponent(pfx + 'ench')).Text;
      SubItems[1] := TCustomEdit(FindComponent(pfx + 'chance')).Text;
    end;
  end;
end;

procedure TMainForm.EraseBackground(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TMainForm.ExecuteScript(script: string; memo: TMemo);
var
  Major, Minor, Release, Build: Word;
var
  Log: TStringList;
  FN: string;
begin
  ShowHourGlassCursor;
  ZSqlProcessor.script.Text := script;
  try
    ZSqlProcessor.Connection.StartTransaction;
    ZSqlProcessor.Execute;
    ZSqlProcessor.Connection.Commit;
  except
    on E: Exception do
    begin
      ZSqlProcessor.Connection.Rollback;
      memo.Text := E.Message;
      Exit;
    end;
  end;
  memo.Text := dmMain.Text[10]; // 'Script executed successfully.'
  Log := TStringList.Create;
  try
    if GetFileVersion(Application.ExeName, Major, Minor, Release, Build) then
      FN := Format('%sLog_%d_%d_%d.sql', [dmMain.ProgramDir, Major, Minor, Release])
    else
      FN := Format('%sLog_unknown_version.sql', [dmMain.ProgramDir]);
    if FileExists(FN) then
      Log.LoadFromFile(FN);
    Log.Add('-- ' + DateTimeToStr(Now));
    Log.Add(script);
    Log.SaveToFile(FN);
  finally
    Log.Free;
  end;
end;

procedure TMainForm.EnchDel(lvList: TJvListView);
begin
  LootDel(lvList);
end;

procedure TMainForm.SetEnchEditFields(pfx: string; lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      TCustomEdit(FindComponent(pfx + 'entry')).Text := Caption;
      TCustomEdit(FindComponent(pfx + 'ench')).Text := SubItems[0];
      TCustomEdit(FindComponent(pfx + 'chance')).Text := SubItems[1];
    end;
  end;
end;

procedure TMainForm.SetFieldsAndValues(var Fields, Values: string; TableName, pfx: string; Log: TMemo);
begin
  SetFieldsAndValues(MyQuery, Fields, Values, TableName, pfx, Log);
end;

procedure TMainForm.ShowFullEnchScript(TableName: string; lvList: TJvListView; memo: TMemo; entry: string);
var
  i: Integer;
  Values: string;
begin
  memo.Clear;
  Values := '';
  if lvList.Items.Count <> 0 then
  begin
    for i := 0 to lvList.Items.Count - 2 do
    begin
      Values := Values + Format('(%s, %s, %s),'#13#10, [lvList.Items[i].Caption, lvList.Items[i].SubItems[0],
        lvList.Items[i].SubItems[1]]);
    end;
    i := lvList.Items.Count - 1;
    Values := Values + Format('(%s, %s, %s);', [lvList.Items[i].Caption, lvList.Items[i].SubItems[0],
      lvList.Items[i].SubItems[1]]);
  end;
  if Values <> '' then
  begin
    memo.Text := Format('DELETE FROM `%0:s` WHERE (`entry`=%1:s);'#13#10 +
      'INSERT INTO `%0:s` (entry, ench, chance) VALUES '#13#10'%2:s', [TableName, entry, Values]);
  end
  else
    memo.Text := Format('DELETE FROM `%s` WHERE (`entry`=%s);', [TableName, entry]);
end;

procedure TMainForm.CompleteItemEnchScript;
var
  entry, ench, Fields, Values: string;
begin
  meitLog.Clear;
  entry := edieentry.Text;
  ench := edieench.Text;
  if (entry = '') or (ench = '') then
    Exit;
  SetFieldsAndValues(Fields, Values, 'item_enchantment_template', PFX_ITEM_ENCHANTMENT_TEMPLATE, meitLog);
  case SyntaxStyle of
    ssInsertDelete:
      meitScript.Text := Format('DELETE FROM `item_enchantment_template` WHERE (`entry`=%s) AND (`ench`=%s);'#13#10 +
      'INSERT INTO `item_enchantment_template` (%s) VALUES (%s);'#13#10, [entry, ench, Fields, Values]);
    ssReplace:
      meitScript.Text := Format('REPLACE INTO `item_enchantment_template` (%s) VALUES (%s);'#13#10, [Fields, Values]);
    ssUpdate:
      meitScript.Text := MakeUpdate2('item_enchantment_template', PFX_ITEM_ENCHANTMENT_TEMPLATE, false, 'entry', entry, 'ench', ench);
  end;
end;

// Characters

procedure TMainForm.btCharSearchClick(Sender: TObject);
begin
  SearchChar();
  with lvSearchChar do
    if Items.Count > 0 then
    begin
      SetFocus;
      Selected := Items[0];
    end;
  StatusBarChar.Panels[0].Text := Format(dmMain.Text[136], [lvSearchChar.Items.Count]);
end;

procedure TMainForm.SearchChar();
var
  i: Integer;
  GUID, name, account, QueryStr, WhereStr, t: string;
  Field: TField;
begin

  account := edCharAccount.Text;
  GUID := edCharGuid.Text;
  name := edCharName.Text;
  name := StringReplace(name, '''', '\''', [rfReplaceAll]);
  name := StringReplace(name, ' ', '%', [rfReplaceAll]);
  name := '%' + name + '%';
  QueryStr := '';
  WhereStr := '';
  if GUID <> '' then
  begin
    if pos('-', GUID) = 0 then
      WhereStr := Format('WHERE (`guid` in (%s))', [GUID])
    else
      WhereStr := Format('WHERE (`guid` >= %s) AND (`guid` <= %s)', [MidStr(GUID, 1, pos('-', GUID) - 1),
        MidStr(GUID, pos('-', GUID) + 1, length(GUID))]);
  end;

  if account <> '' then
  begin
    if pos('-', account) = 0 then
      WhereStr := Format('WHERE (`account` in (%s))', [account])
    else
      WhereStr := Format('WHERE (`account` >= %s) AND (`account` <= %s)', [MidStr(account, 1, pos('-', account) - 1),
        MidStr(account, pos('-', account) + 1, length(account))]);
  end;

  if name <> '%%' then
  begin
    if WhereStr <> '' then
      WhereStr := Format('%s AND (`name` LIKE ''%s'')', [WhereStr, name])
    else
      WhereStr := Format('WHERE (`name` LIKE ''%s'')', [name]);
  end;

  if Trim(WhereStr) = '' then
    if MessageDlg(dmMain.Text[134], mtConfirmation, mbYesNoCancel, -1) <> mrYes then
      Exit;

  QueryStr := Format('SELECT * FROM `' + CharDBName + '`.`characters` %s', [WhereStr]);

  MyQuery.SQL.Text := QueryStr;
  lvSearchChar.Items.BeginUpdate;
  try
    MyQuery.Open;
    lvSearchChar.Clear;
    while not MyQuery.Eof do
    begin
      with lvSearchChar.Items.Add do
      begin
        for i := 0 to lvSearchChar.Columns.Count - 1 do
        begin
          Field := MyQuery.FindField(lvSearchChar.Columns[i].Caption);
          t := '';
          if Assigned(Field) then
          begin
            t := Field.AsString;
            if i = 0 then
              Caption := t;
          end;

          // if Field.FieldName = 'race' then
          // t := GetRaceAcronym(strtointdef(t,0))
          // else if Field.FieldName = 'class' then
          // t := GetClassAcronym(strtointdef(t,0));

          if i <> 0 then
            SubItems.Add(t);
        end;
        MyQuery.Next;
      end;
    end;
  finally
    lvSearchChar.Items.EndUpdate;
    MyQuery.Close;
  end;
end;

procedure TMainForm.btCharClearClick(Sender: TObject);
begin
  edCharGuid.Clear;
  edCharName.Clear;
  edCharAccount.Clear;
  lvSearchChar.Clear;
end;

procedure TMainForm.btCharInvAddClick(Sender: TObject);
begin
  with lvCharacterInventory.Items.Add do
  begin
    Caption := edhiguid.Text;
    SubItems.Add(edhibag.Text);
    SubItems.Add(edhislot.Text);
    SubItems.Add(edhiitem.Text);
    SubItems.Add(edhiitem_template.Text);
  end;
end;

procedure TMainForm.btCharInvDelClick(Sender: TObject);
begin
  if Assigned(lvCharacterInventory.Selected) then
    lvCharacterInventory.DeleteSelected;
end;

procedure TMainForm.btCharInvUpdClick(Sender: TObject);
begin
  if Assigned(lvCharacterInventory.Selected) then
  begin
    with lvCharacterInventory.Selected do
    begin
      Caption := edhiguid.Text;
      SubItems[0] := edhibag.Text;
      SubItems[1] := edhislot.Text;
      SubItems[2] := edhiitem.Text;
      SubItems[3] := edhiitem_template.Text;
    end;
  end;
end;

procedure TMainForm.CheckForUpdates(flag: Boolean);
begin
{$IFDEF CRAKER}
  Exit;
{$ENDIF}
  if IsFirst then
  begin
    if flag then
      ShowMessage('Check For Updates currently in process!');
    Exit;
  end;
  GlobalFlag := flag;
  SetCursor(LoadCursor(0, IDC_WAIT));

  if Trim(dmMain.ProxyServer) <> '' then
  begin
    JvHttpUrlGrabber.ProxyAddresses := Format('http=http://%s', [dmMain.ProxyServer]);
    if Trim(dmMain.ProxyPort) <> '' then
      JvHttpUrlGrabber.ProxyAddresses := Format('%s:%s', [JvHttpUrlGrabber.ProxyAddresses, dmMain.ProxyPort]);
  end;
  JvHttpUrlGrabber.ProxyUserName := dmMain.ProxyUser;
  JvHttpUrlGrabber.ProxyPassword := dmMain.ProxyPass;
  JvHttpUrlGrabber.Url := 'https://github.com/Ravie/quice/releases';
  try
    IsFirst := true;
    JvHttpUrlGrabber.Start;
  except
    IsFirst := false;
  end;
end;

end.
