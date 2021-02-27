USE soapbox;

-- user: table
CREATE TABLE `user`
(
    `ID`                   bigint(20) NOT NULL AUTO_INCREMENT,
    `EMAIL`                varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `PASSWORD`             varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  DEFAULT NULL,
    `premium`              bit(1)     NOT NULL                                           DEFAULT b'0',
    `isAdmin`              bit(1)                                                        DEFAULT NULL,
    `HWID`                 varchar(255) COLLATE utf8mb4_unicode_ci                       DEFAULT NULL,
    `IP_ADDRESS`           varchar(255) COLLATE utf8mb4_unicode_ci                       DEFAULT NULL,
    `created`              datetime                                                      DEFAULT NULL,
    `lastLogin`            datetime                                                      DEFAULT NULL,
    `gameHardwareHash`     varchar(255) COLLATE utf8mb4_unicode_ci                       DEFAULT NULL,
    `isLocked`             bit(1)                                                        DEFAULT NULL,
    `selectedPersonaIndex` int(11)                                                       DEFAULT '0',
    PRIMARY KEY (`ID`),
    UNIQUE KEY `USER_email_index` (`EMAIL`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- persona: table
CREATE TABLE `persona`
(
    `ID`                     bigint(20) NOT NULL AUTO_INCREMENT,
    `boost`                  double     NOT NULL,
    `cash`                   double     NOT NULL,
    `curCarIndex`            int(11)    NOT NULL,
    `iconIndex`              int(11)    NOT NULL,
    `level`                  int(11)    NOT NULL,
    `motto`                  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `name`                   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `percentToLevel`         float      NOT NULL,
    `rating`                 double     NOT NULL,
    `rep`                    double     NOT NULL,
    `repAtCurrentLevel`      int(11)    NOT NULL,
    `score`                  int(11)    NOT NULL,
    `USERID`                 bigint(20)                                                    DEFAULT NULL,
    `created`                datetime                                                      DEFAULT NULL,
    `badges`                 varchar(2048) COLLATE utf8mb4_unicode_ci                      DEFAULT NULL,
    `first_login`            datetime                                                      DEFAULT NULL,
    `last_login`             datetime                                                      DEFAULT NULL,
    `numCarSlots`            int(11)    NOT NULL                                           DEFAULT '250',
    PRIMARY KEY (`ID`),
    UNIQUE KEY `PERSONA_name_index` (`name`),
    KEY `FK_PERSONA_USER_USERID` (`USERID`),
    CONSTRAINT `FK_PERSONA_USER_USERID` FOREIGN KEY (`USERID`) REFERENCES `user` (`ID`) ON DELETE CASCADE
) ENGINE = InnoDB
  AUTO_INCREMENT = 100
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
-- badge_definition: table
CREATE TABLE `badge_definition`
(
    `ID`          bigint(20) NOT NULL AUTO_INCREMENT,
    `background`  varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `border`      varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `icon`        varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `name`        varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`ID`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 101
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- achievement: table
CREATE TABLE `achievement`
(
    `ID`                        bigint(20) NOT NULL AUTO_INCREMENT,
    `auto_update`               bit(1)                                                                                      DEFAULT NULL,
    `category`                  varchar(255) COLLATE utf8mb4_unicode_ci                                                     DEFAULT NULL,
    `name`                      varchar(255) COLLATE utf8mb4_unicode_ci                                                     DEFAULT NULL,
    `progress_text`             varchar(255) COLLATE utf8mb4_unicode_ci                                                     DEFAULT NULL,
    `should_overwrite_progress` bit(1)                                                                                      DEFAULT b'0',
    `stat_conversion`           enum ('None','FromMetersToDistance','FromMillisecondsToMinutes') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `update_trigger`            text COLLATE utf8mb4_unicode_ci,
    `update_value`              text COLLATE utf8mb4_unicode_ci,
    `visible`                   bit(1)                                                                                      DEFAULT NULL,
    `badge_definition_id`       bigint(20) NOT NULL,
    PRIMARY KEY (`ID`),
    UNIQUE KEY `UK_ACHIEVEMENT_badge_definition_id` (`badge_definition_id`),
    KEY `ACHIEVEMENT_category_index` (`category`),
    CONSTRAINT `FK_ACHIEVEMENT_BADGE_DEFINITION_badge_definition_id` FOREIGN KEY (`badge_definition_id`) REFERENCES `badge_definition` (`ID`) ON DELETE CASCADE
) ENGINE = InnoDB
  AUTO_INCREMENT = 69
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: ACHIEVEMENT_category_index (index)

-- achievement_rank: table
CREATE TABLE `achievement_rank`
(
    `ID`                  bigint(20) NOT NULL AUTO_INCREMENT,
    `points`              int(11)                                 DEFAULT NULL,
    `rank`                int(11)                                 DEFAULT NULL,
    `rarity`              float                                   DEFAULT NULL,
    `reward_description`  varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `reward_type`         varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `reward_visual_style` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `threshold_value`     int(11)                                 DEFAULT NULL,
    `achievement_id`      bigint(20) NOT NULL,
    PRIMARY KEY (`ID`),
    KEY `FK_ACHIEVEMENT_RANK_ACHIEVEMENT_achievement_id` (`achievement_id`),
    CONSTRAINT `FK_ACHIEVEMENT_RANK_ACHIEVEMENT_achievement_id` FOREIGN KEY (`achievement_id`) REFERENCES `achievement` (`ID`) ON DELETE CASCADE
) ENGINE = InnoDB
  AUTO_INCREMENT = 342
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: FK_ACHIEVEMENT_RANK_ACHIEVEMENT_achievement_id (index)

-- achievement_reward: table
CREATE TABLE `achievement_reward`
(
    `ID`                          bigint(20)                      NOT NULL AUTO_INCREMENT,
    `internal_reward_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `reward_description`          varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `rewardScript`                text COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`ID`),
    KEY `ACHIEVEMENT_REWARD_internal_reward_description_index` (`internal_reward_description`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 208
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: ACHIEVEMENT_REWARD_internal_reward_description_index (index)

-- ban: table
CREATE TABLE `ban`
(
    `id`           bigint(20) NOT NULL AUTO_INCREMENT,
    `data`         varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `ends_at`      datetime                                DEFAULT NULL,
    `reason`       varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `type`         varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `user_id`      bigint(20)                              DEFAULT NULL,
    `started`      datetime                                DEFAULT NULL,
    `banned_by_id` bigint(20)                              DEFAULT NULL,
    `active`       tinyint(1)                              DEFAULT '1',
    PRIMARY KEY (`id`),
    KEY `BAN_endsAt_index` (`ends_at`),
    KEY `BAN_existence_index` (`user_id`, `ends_at`),
    KEY `FK_BAN_PERSONA_banned_by_id` (`banned_by_id`),
    CONSTRAINT `FK_BAN_PERSONA_banned_by_id` FOREIGN KEY (`banned_by_id`) REFERENCES `persona` (`ID`) ON DELETE CASCADE,
    CONSTRAINT `FK_BAN_USER_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`ID`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: BAN_endsAt_index (index)

-- No native definition for element: BAN_existence_index (index)

-- No native definition for element: FK_BAN_PERSONA_banned_by_id (index)

-- car: table
CREATE TABLE `car`
(
    `id`                 bigint(20)                              NOT NULL AUTO_INCREMENT,
    `durability`         int(11)                                 NOT NULL,
    `expirationDate`     datetime                                                      DEFAULT NULL,
    `heat`               float                                   NOT NULL,
    `ownershipType`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `personaId`          bigint(20)                              NOT NULL,
    `baseCar`            int(11)                                 NOT NULL,
    `carClassHash`       int(11)                                 NOT NULL,
    `isPreset`           bit(1)                                  NOT NULL,
    `level`              int(11)                                 NOT NULL,
    `name`               varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `physicsProfileHash` int(11)                                 NOT NULL,
    `rating`             int(11)                                 NOT NULL,
    `resalePrice`        float                                   NOT NULL,
    `rideHeightDrop`     float                                   NOT NULL,
    `skillModSlotCount`  int(11)                                 NOT NULL,
    `version`            int(11)                                 NOT NULL,
    PRIMARY KEY (`id`),
    KEY `FK_CAR_PERSONA_personaId` (`personaId`),
    KEY `IDX_CAR_expirationDate` (`expirationDate`),
    KEY `IDX_CAR_ownershipType` (`ownershipType`),
    CONSTRAINT `FK_CAR_PERSONA_personaId` FOREIGN KEY (`personaId`) REFERENCES `persona` (`ID`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: IDX_CAR_expirationDate (index)

-- No native definition for element: IDX_CAR_ownershipType (index)

-- No native definition for element: FK_CAR_PERSONA_personaId (index)

-- car_classes: table
CREATE TABLE `car_classes`
(
    `store_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `full_name`  varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `manufactor` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `model`      varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `ts_stock`   int(11)                                                       DEFAULT NULL,
    `ts_var1`    int(11)                                                       DEFAULT NULL,
    `ts_var2`    int(11)                                                       DEFAULT NULL,
    `ts_var3`    int(11)                                                       DEFAULT NULL,
    `ac_stock`   int(11)                                                       DEFAULT NULL,
    `ac_var1`    int(11)                                                       DEFAULT NULL,
    `ac_var2`    int(11)                                                       DEFAULT NULL,
    `ac_var3`    int(11)                                                       DEFAULT NULL,
    `ha_stock`   int(11)                                                       DEFAULT NULL,
    `ha_var1`    int(11)                                                       DEFAULT NULL,
    `ha_var2`    int(11)                                                       DEFAULT NULL,
    `ha_var3`    int(11)                                                       DEFAULT NULL,
    `hash`       int(11)                                                       DEFAULT NULL,
    `product_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`store_name`),
    UNIQUE KEY `store_name_index` (`store_name`),
    KEY `hash_index` (`hash`),
    KEY `store_name_key` (`store_name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: store_name_key (index)

-- No native definition for element: hash_index (index)

-- card_pack: table
CREATE TABLE `card_pack`
(
    `ID`             bigint(20) NOT NULL AUTO_INCREMENT,
    `entitlementTag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`ID`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 109
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- card_pack_item: table
CREATE TABLE `card_pack_item`
(
    `ID`                bigint(20)                      NOT NULL AUTO_INCREMENT,
    `script`            text COLLATE utf8mb4_unicode_ci NOT NULL,
    `cardPackEntity_ID` bigint(20)                      NOT NULL,
    PRIMARY KEY (`ID`),
    KEY `FK_CARD_PACK_ITEM_CARD_PACK_cardPackEntity_ID` (`cardPackEntity_ID`),
    CONSTRAINT `FK_CARD_PACK_ITEM_CARD_PACK_cardPackEntity_ID` FOREIGN KEY (`cardPackEntity_ID`) REFERENCES `card_pack` (`ID`) ON DELETE CASCADE
) ENGINE = InnoDB
  AUTO_INCREMENT = 536
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: FK_CARD_PACK_ITEM_CARD_PACK_cardPackEntity_ID (index)

-- category: table
CREATE TABLE `category`
(
    `idcategory`           bigint(20) NOT NULL AUTO_INCREMENT,
    `catalogVersion`       varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `categories`           varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `displayName`          varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `filterType`           int(11)                                 DEFAULT NULL,
    `icon`                 varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `id`                   bigint(20)                              DEFAULT NULL,
    `longDescription`      varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `name`                 varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `priority`             smallint(6)                             DEFAULT NULL,
    `shortDescription`     varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `showInNavigationPane` bit(1)                                  DEFAULT NULL,
    `showPromoPage`        bit(1)                                  DEFAULT NULL,
    `webIcon`              varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`idcategory`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 55
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- chat_announcement: table
CREATE TABLE `chat_announcement`
(
    `id`                   int(11) NOT NULL AUTO_INCREMENT,
    `announcementInterval` int(11)                                 DEFAULT NULL,
    `announcementMessage`  varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `channelMask`          varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- chat_room: table
CREATE TABLE `chat_room`
(
    `ID`        bigint(20) NOT NULL AUTO_INCREMENT,
    `amount`    int(11)                                                       DEFAULT NULL,
    `longName`  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `shortName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`ID`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;



-- reward_table: table
CREATE TABLE `reward_table`
(
    `ID`   bigint(20) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`ID`),
    UNIQUE KEY `REWARD_TABLE_name_index` (`name`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 2209
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- event_reward: table
CREATE TABLE `event_reward`
(
    `ID`                         varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `baseRepReward`              int(11)                                 NOT NULL DEFAULT '0',
    `levelRepRewardMultiplier`   float                                   NOT NULL DEFAULT '0',
    `finalRepRewardMultiplier`   float                                   NOT NULL DEFAULT '0',
    `perfectStartRepMultiplier`  float                                   NOT NULL DEFAULT '0',
    `topSpeedRepMultiplier`      float                                   NOT NULL DEFAULT '0',
    `rank1RepMultiplier`         float                                   NOT NULL DEFAULT '0',
    `rank2RepMultiplier`         float                                   NOT NULL DEFAULT '0',
    `rank3RepMultiplier`         float                                   NOT NULL DEFAULT '0',
    `rank4RepMultiplier`         float                                   NOT NULL DEFAULT '0',
    `rank5RepMultiplier`         float                                   NOT NULL DEFAULT '0',
    `rank6RepMultiplier`         float                                   NOT NULL DEFAULT '0',
    `rank7RepMultiplier`         float                                   NOT NULL DEFAULT '0',
    `rank8RepMultiplier`         float                                   NOT NULL DEFAULT '0',
    `baseCashReward`             int(11)                                 NOT NULL DEFAULT '0',
    `levelCashRewardMultiplier`  float                                   NOT NULL DEFAULT '0',
    `finalCashRewardMultiplier`  float                                   NOT NULL DEFAULT '0',
    `perfectStartCashMultiplier` float                                   NOT NULL DEFAULT '0',
    `topSpeedCashMultiplier`     float                                   NOT NULL DEFAULT '0',
    `rank1CashMultiplier`        float                                   NOT NULL DEFAULT '0',
    `rank2CashMultiplier`        float                                   NOT NULL DEFAULT '0',
    `rank3CashMultiplier`        float                                   NOT NULL DEFAULT '0',
    `rank4CashMultiplier`        float                                   NOT NULL DEFAULT '0',
    `rank5CashMultiplier`        float                                   NOT NULL DEFAULT '0',
    `rank6CashMultiplier`        float                                   NOT NULL DEFAULT '0',
    `rank7CashMultiplier`        float                                   NOT NULL DEFAULT '0',
    `rank8CashMultiplier`        float                                   NOT NULL DEFAULT '0',
    `minTopSpeedTrigger`         float                                   NOT NULL DEFAULT '0',
    `rewardTable_rank1_id`       bigint(20)                                       DEFAULT NULL,
    `rewardTable_rank2_id`       bigint(20)                                       DEFAULT NULL,
    `rewardTable_rank3_id`       bigint(20)                                       DEFAULT NULL,
    `rewardTable_rank4_id`       bigint(20)                                       DEFAULT NULL,
    `rewardTable_rank5_id`       bigint(20)                                       DEFAULT NULL,
    `rewardTable_rank6_id`       bigint(20)                                       DEFAULT NULL,
    `rewardTable_rank7_id`       bigint(20)                                       DEFAULT NULL,
    `rewardTable_rank8_id`       bigint(20)                                       DEFAULT NULL,
    PRIMARY KEY (`ID`),
    KEY `FK_EVENT_REWARD_RANK1TABLE_ID` (`rewardTable_rank1_id`),
    KEY `FK_EVENT_REWARD_RANK2TABLE_ID` (`rewardTable_rank2_id`),
    KEY `FK_EVENT_REWARD_RANK3TABLE_ID` (`rewardTable_rank3_id`),
    KEY `FK_EVENT_REWARD_RANK4TABLE_ID` (`rewardTable_rank4_id`),
    KEY `FK_EVENT_REWARD_RANK5TABLE_ID` (`rewardTable_rank5_id`),
    KEY `FK_EVENT_REWARD_RANK6TABLE_ID` (`rewardTable_rank6_id`),
    KEY `FK_EVENT_REWARD_RANK7TABLE_ID` (`rewardTable_rank7_id`),
    KEY `FK_EVENT_REWARD_RANK8TABLE_ID` (`rewardTable_rank8_id`),
    CONSTRAINT `FK_EVENT_REWARD_RANK1TABLE_ID` FOREIGN KEY (`rewardTable_rank1_id`) REFERENCES `reward_table` (`ID`),
    CONSTRAINT `FK_EVENT_REWARD_RANK2TABLE_ID` FOREIGN KEY (`rewardTable_rank2_id`) REFERENCES `reward_table` (`ID`),
    CONSTRAINT `FK_EVENT_REWARD_RANK3TABLE_ID` FOREIGN KEY (`rewardTable_rank3_id`) REFERENCES `reward_table` (`ID`),
    CONSTRAINT `FK_EVENT_REWARD_RANK4TABLE_ID` FOREIGN KEY (`rewardTable_rank4_id`) REFERENCES `reward_table` (`ID`),
    CONSTRAINT `FK_EVENT_REWARD_RANK5TABLE_ID` FOREIGN KEY (`rewardTable_rank5_id`) REFERENCES `reward_table` (`ID`),
    CONSTRAINT `FK_EVENT_REWARD_RANK6TABLE_ID` FOREIGN KEY (`rewardTable_rank6_id`) REFERENCES `reward_table` (`ID`),
    CONSTRAINT `FK_EVENT_REWARD_RANK7TABLE_ID` FOREIGN KEY (`rewardTable_rank7_id`) REFERENCES `reward_table` (`ID`),
    CONSTRAINT `FK_EVENT_REWARD_RANK8TABLE_ID` FOREIGN KEY (`rewardTable_rank8_id`) REFERENCES `reward_table` (`ID`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- event: table
CREATE TABLE `event`
(
    `ID`                            int(11)                                 NOT NULL AUTO_INCREMENT,
    `eventModeId`                   int(11)                                 NOT NULL,
    `isEnabled`                     bit(1)                                                        DEFAULT b'1',
    `isLocked`                      bit(1)                                                        DEFAULT b'0',
    `rewardsTimeLimit`              bigint(20)                              NOT NULL              DEFAULT '0',
    `maxCarClassRating`             int(11)                                 NOT NULL,
    `maxLevel`                      int(11)                                 NOT NULL,
    `maxPlayers`                    int(11)                                 NOT NULL,
    `minCarClassRating`             int(11)                                 NOT NULL,
    `minLevel`                      int(11)                                 NOT NULL,
    `name`                          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `carClassHash`                  int(11)                                 NOT NULL,
    `trackLength`                   float                                   NOT NULL,
    `isRotationEnabled`             bit(1)                                                        DEFAULT b'0',
    `dnfTimerTime`                  int(11)                                                       DEFAULT '60000',
    `lobbyCountdownTime`            int(11)                                                       DEFAULT '60000',
    `legitTime`                     bigint(20)                                                    DEFAULT '0',
    `isDnfEnabled`                  bit(1)                                                        DEFAULT b'1',
    `isRaceAgainEnabled`            bit(1)                                                        DEFAULT b'1',
    `singleplayer_reward_config_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `multiplayer_reward_config_id`  varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `private_reward_config_id`      varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`ID`),
    KEY `EVENT_availability_index` (`isEnabled`, `minLevel`, `maxLevel` DESC),
    KEY `test_index` (`ID`, `name`),
    KEY `FK_EVENT_SINGLEPLAYER_REWARD_CONFIG_ID` (`singleplayer_reward_config_id`),
    KEY `FK_EVENT_MULTIPLAYER_REWARD_CONFIG_ID` (`multiplayer_reward_config_id`),
    KEY `FK_EVENT_PRIVATE_REWARD_CONFIG_ID` (`private_reward_config_id`),
    CONSTRAINT `FK_EVENT_MULTIPLAYER_REWARD_CONFIG_ID` FOREIGN KEY (`multiplayer_reward_config_id`) REFERENCES `event_reward` (`ID`),
    CONSTRAINT `FK_EVENT_PRIVATE_REWARD_CONFIG_ID` FOREIGN KEY (`private_reward_config_id`) REFERENCES `event_reward` (`ID`),
    CONSTRAINT `FK_EVENT_SINGLEPLAYER_REWARD_CONFIG_ID` FOREIGN KEY (`singleplayer_reward_config_id`) REFERENCES `event_reward` (`ID`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 536
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: test_index (index)

-- No native definition for element: EVENT_availability_index (index)

-- No native definition for element: FK_EVENT_SINGLEPLAYER_REWARD_CONFIG_ID (index)

-- No native definition for element: FK_EVENT_MULTIPLAYER_REWARD_CONFIG_ID (index)

-- No native definition for element: FK_EVENT_PRIVATE_REWARD_CONFIG_ID (index)

-- lobby: table
CREATE TABLE `lobby`
(
    `ID`                 bigint(20) NOT NULL AUTO_INCREMENT,
    `isPrivate`          bit(1)     DEFAULT NULL,
    `lobbyDateTimeStart` datetime   DEFAULT NULL,
    `personaId`          bigint(20) DEFAULT NULL,
    `EVENTID`            int(11)    DEFAULT NULL,
    `startedTime`        datetime   DEFAULT NULL,
    PRIMARY KEY (`ID`),
    KEY `LOBBY_startedTime_index` (`startedTime`),
    KEY `FK_LOBBY_EVENT_EVENTID` (`EVENTID`),
    CONSTRAINT `FK_LOBBY_EVENT_EVENTID` FOREIGN KEY (`EVENTID`) REFERENCES `event` (`ID`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;


-- event_session: table
CREATE TABLE `event_session`
(
    `ID`          bigint(20) NOT NULL AUTO_INCREMENT,
    `EVENTID`     int(11)    DEFAULT NULL,
    `ENDED`       bigint(20) DEFAULT NULL,
    `STARTED`     bigint(20) DEFAULT NULL,
    `LOBBYID`     bigint(20) DEFAULT NULL,
    `NEXTLOBBYID` bigint(20) DEFAULT NULL,
    PRIMARY KEY (`ID`),
    KEY `FK_EVENT_SESSION_EVENT_EVENTID` (`EVENTID`),
    KEY `FK_EVENT_SESSION_LOBBY_LOBBYID` (`LOBBYID`),
    KEY `FK_EVENT_SESSION_LOBBY_NEXTLOBBYID` (`NEXTLOBBYID`),
    CONSTRAINT `FK_EVENT_SESSION_EVENT_EVENTID` FOREIGN KEY (`EVENTID`) REFERENCES `event` (`ID`) ON DELETE CASCADE,
    CONSTRAINT `FK_EVENT_SESSION_LOBBY_LOBBYID` FOREIGN KEY (`LOBBYID`) REFERENCES `lobby` (`ID`) ON DELETE CASCADE,
    CONSTRAINT `FK_EVENT_SESSION_LOBBY_NEXTLOBBYID` FOREIGN KEY (`NEXTLOBBYID`) REFERENCES `lobby` (`ID`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- event_data: table
CREATE TABLE `event_data`
(
    `ID`                                   bigint(20) NOT NULL AUTO_INCREMENT,
    `alternateEventDurationInMilliseconds` bigint(20) NOT NULL,
    `bestLapDurationInMilliseconds`        bigint(20) NOT NULL,
    `bustedCount`                          int(11)    NOT NULL,
    `carId`                                bigint(20) NOT NULL,
    `copsDeployed`                         int(11)    NOT NULL,
    `copsDisabled`                         int(11)    NOT NULL,
    `copsRammed`                           int(11)    NOT NULL,
    `costToState`                          int(11)    NOT NULL,
    `distanceToFinish`                     float      NOT NULL,
    `eventDurationInMilliseconds`          bigint(20) NOT NULL,
    `eventModeId`                          int(11)    NOT NULL,
    `eventSessionId`                       bigint(20) DEFAULT NULL,
    `finishReason`                         int(11)    NOT NULL,
    `fractionCompleted`                    float      NOT NULL,
    `hacksDetected`                        bigint(20) NOT NULL,
    `heat`                                 float      NOT NULL,
    `infractions`                          int(11)    NOT NULL,
    `longestJumpDurationInMilliseconds`    bigint(20) NOT NULL,
    `numberOfCollisions`                   int(11)    NOT NULL,
    `perfectStart`                         int(11)    NOT NULL,
    `personaId`                            bigint(20) DEFAULT NULL,
    `rank`                                 int(11)    NOT NULL,
    `roadBlocksDodged`                     int(11)    NOT NULL,
    `spikeStripsDodged`                    int(11)    NOT NULL,
    `sumOfJumpsDurationInMilliseconds`     bigint(20) NOT NULL,
    `topSpeed`                             float      NOT NULL,
    `EVENTID`                              int(11)    DEFAULT NULL,
    `isLegit`                              bit(1)     DEFAULT b'0',
    `serverTimeInMilliseconds`             bigint(20) DEFAULT NULL,
    `serverTimeStarted`                    bigint(20) DEFAULT NULL,
    `serverTimeEnded`                      bigint(20) DEFAULT NULL,
    `carClassHash`                         int(11)    DEFAULT NULL,
    `carRating`                            int(11)    DEFAULT NULL,
    `global_rank`                          int(11)    DEFAULT NULL,
    PRIMARY KEY (`ID`),
    UNIQUE KEY `esi_personaId` (`eventSessionId`, `personaId`),
    KEY `EVENT_DATA_persona_id_index` (`personaId`),
    KEY `car_id_index` (`carId`),
    KEY `finishreason_index` (`finishReason`),
    KEY `FK_EVENT_DATA_EVENT_EVENTID` (`EVENTID`),
    CONSTRAINT `FK_EVENT_DATA_EVENT_EVENTID` FOREIGN KEY (`EVENTID`) REFERENCES `event` (`ID`) ON DELETE CASCADE,
    CONSTRAINT `FK_EVENT_DATA_EVENT_SESSION_eventSessionId` FOREIGN KEY (`eventSessionId`) REFERENCES `event_session` (`ID`) ON DELETE CASCADE,
    CONSTRAINT `FK_EVENT_DATA_PERSONA_personaId` FOREIGN KEY (`personaId`) REFERENCES `persona` (`ID`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: car_id_index (index)

-- No native definition for element: finishreason_index (index)

-- No native definition for element: EVENT_DATA_persona_id_index (index)

-- No native definition for element: FK_EVENT_DATA_EVENT_EVENTID (index)

-- No native definition for element: FK_EVENT_REWARD_RANK1TABLE_ID (index)

-- No native definition for element: FK_EVENT_REWARD_RANK2TABLE_ID (index)

-- No native definition for element: FK_EVENT_REWARD_RANK3TABLE_ID (index)

-- No native definition for element: FK_EVENT_REWARD_RANK4TABLE_ID (index)

-- No native definition for element: FK_EVENT_REWARD_RANK5TABLE_ID (index)

-- No native definition for element: FK_EVENT_REWARD_RANK6TABLE_ID (index)

-- No native definition for element: FK_EVENT_REWARD_RANK7TABLE_ID (index)

-- No native definition for element: FK_EVENT_REWARD_RANK8TABLE_ID (index)


-- No native definition for element: FK_EVENT_SESSION_EVENT_EVENTID (index)

-- No native definition for element: FK_EVENT_SESSION_LOBBY_LOBBYID (index)

-- No native definition for element: FK_EVENT_SESSION_LOBBY_NEXTLOBBYID (index)


-- No native definition for element: FK_GIFT_CODE_PRODUCT_product_id (index)

-- hardware_info: table
CREATE TABLE `hardware_info`
(
    `ID`           bigint(20) NOT NULL AUTO_INCREMENT,
    `banned`       bit(1)     NOT NULL,
    `hardwareHash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `hardwareInfo` longtext COLLATE utf8mb4_unicode_ci,
    `userId`       bigint(20)                              DEFAULT NULL,
    PRIMARY KEY (`ID`),
    KEY `HARDWARE_INFO_hardwareHash_index` (`hardwareHash`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: HARDWARE_INFO_hardwareHash_index (index)

-- inventory: table
CREATE TABLE `inventory`
(
    `id`                            bigint(20) NOT NULL AUTO_INCREMENT,
    `performancePartsCapacity`      int(11)    DEFAULT NULL,
    `performancePartsUsedSlotCount` int(11)    DEFAULT NULL,
    `skillModPartsCapacity`         int(11)    DEFAULT NULL,
    `skillModPartsUsedSlotCount`    int(11)    DEFAULT NULL,
    `visualPartsCapacity`           int(11)    DEFAULT NULL,
    `visualPartsUsedSlotCount`      int(11)    DEFAULT NULL,
    `personaId`                     bigint(20) DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `FK_INVENTORY_PERSONA_personaId` (`personaId`),
    CONSTRAINT `FK_INVENTORY_PERSONA_personaId` FOREIGN KEY (`personaId`) REFERENCES `persona` (`ID`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: FK_INVENTORY_PERSONA_personaId (index)


-- No native definition for element: INVENTORY_ITEM_expirationDate_index (index)

-- No native definition for element: FK_INVENTORY_ITEM_INVENTORY_inventoryEntity_id (index)

-- No native definition for element: FK_INVENTORY_ITEM_PRODUCT_productId (index)

-- invite_ticket: table
CREATE TABLE `invite_ticket`
(
    `ID`           bigint(20) NOT NULL AUTO_INCREMENT,
    `DISCORD_NAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `TICKET`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `USERID`       bigint(20)                                                    DEFAULT NULL,
    PRIMARY KEY (`ID`),
    KEY `INVITE_TICKET_TICKET_index` (`TICKET`),
    KEY `FK_INVITE_TICKET_USER_USERID` (`USERID`),
    CONSTRAINT `FK_INVITE_TICKET_USER_USERID` FOREIGN KEY (`USERID`) REFERENCES `user` (`ID`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: INVITE_TICKET_TICKET_index (index)

-- No native definition for element: FK_INVITE_TICKET_USER_USERID (index)

-- level_rep: table
CREATE TABLE `level_rep`
(
    `level`    bigint(20) NOT NULL AUTO_INCREMENT,
    `expPoint` bigint(20) DEFAULT NULL,
    PRIMARY KEY (`level`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 61
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: FK_LOBBY_EVENT_EVENTID (index)

-- No native definition for element: LOBBY_startedTime_index (index)

-- lobby_entrant: table
CREATE TABLE `lobby_entrant`
(
    `id`        bigint(20) NOT NULL AUTO_INCREMENT,
    `gridIndex` int(11)    NOT NULL,
    `LOBBYID`   bigint(20) DEFAULT NULL,
    `PERSONAID` bigint(20) DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `FK_LOBBY_ENTRANT_LOBBY_LOBBYID` (`LOBBYID`),
    KEY `FK_LOBBY_ENTRANT_PERSONA_PERSONAID` (`PERSONAID`),
    CONSTRAINT `FK_LOBBY_ENTRANT_LOBBY_LOBBYID` FOREIGN KEY (`LOBBYID`) REFERENCES `lobby` (`ID`) ON DELETE CASCADE,
    CONSTRAINT `FK_LOBBY_ENTRANT_PERSONA_PERSONAID` FOREIGN KEY (`PERSONAID`) REFERENCES `persona` (`ID`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: FK_LOBBY_ENTRANT_LOBBY_LOBBYID (index)

-- No native definition for element: FK_LOBBY_ENTRANT_PERSONA_PERSONAID (index)

-- login_announcement: table
CREATE TABLE `login_announcement`
(
    `id`       int(11)                                 NOT NULL AUTO_INCREMENT,
    `imageUrl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `target`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `type`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `context`  varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL              DEFAULT 'NotApplicable',
    `language` varchar(255) COLLATE utf8mb4_unicode_ci                       DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- news_article: table
CREATE TABLE `news_article`
(
    `id`                    bigint(20) NOT NULL AUTO_INCREMENT,
    `filters`               varchar(255) COLLATE utf8mb4_unicode_ci  DEFAULT NULL,
    `iconType`              int(11)                                  DEFAULT NULL,
    `longHALId`             varchar(255) COLLATE utf8mb4_unicode_ci  DEFAULT NULL,
    `parameters`            varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `shortHALId`            varchar(255) COLLATE utf8mb4_unicode_ci  DEFAULT NULL,
    `sticky`                int(11)                                  DEFAULT NULL,
    `timestamp`             timestamp  NOT NULL                      DEFAULT CURRENT_TIMESTAMP,
    `type`                  varchar(255) COLLATE utf8mb4_unicode_ci  DEFAULT NULL,
    `persona_id`            bigint(20)                               DEFAULT NULL,
    `referenced_persona_id` bigint(20)                               DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `FK_NEWS_ARTICLE_PERSONA_referenced_persona_id` (`referenced_persona_id`),
    KEY `FK_NEWS_ARTICLE_PERSONA_persona_id` (`persona_id`),
    CONSTRAINT `FK_NEWS_ARTICLE_PERSONA_persona_id` FOREIGN KEY (`persona_id`) REFERENCES `persona` (`ID`) ON DELETE CASCADE,
    CONSTRAINT `FK_NEWS_ARTICLE_PERSONA_referenced_persona_id` FOREIGN KEY (`referenced_persona_id`) REFERENCES `persona` (`ID`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: FK_NEWS_ARTICLE_PERSONA_persona_id (index)

-- No native definition for element: FK_NEWS_ARTICLE_PERSONA_referenced_persona_id (index)

-- online_users: table
CREATE TABLE `online_users`
(
    `ID`                 int(11)    NOT NULL,
    `numberOfOnline`     bigint(20) NOT NULL,
    `numberOfRegistered` bigint(20) NOT NULL,
    PRIMARY KEY (`ID`),
    UNIQUE KEY `ONLINE_USERS_id_index` (`ID` DESC)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- paint: table
CREATE TABLE `paint`
(
    `id`         bigint(20) NOT NULL AUTO_INCREMENT,
    `paintGroup` int(11) DEFAULT NULL,
    `hue`        int(11)    NOT NULL,
    `sat`        int(11)    NOT NULL,
    `slot`       int(11)    NOT NULL,
    `paintVar`   int(11) DEFAULT NULL,
    `carId`      bigint(20) NOT NULL,
    PRIMARY KEY (`id`),
    KEY `FK_PAINT_CAR_carId` (`carId`),
    CONSTRAINT `FK_PAINT_CAR_carId` FOREIGN KEY (`carId`) REFERENCES `car` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: FK_PAINT_CAR_carId (index)

-- parameter: table
CREATE TABLE `parameter`
(
    `name`  varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`name`),
    UNIQUE KEY `PARAMETER_name_index` (`name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- performancepart: table
CREATE TABLE `performancepart`
(
    `id`                        bigint(20) NOT NULL AUTO_INCREMENT,
    `performancePartAttribHash` int(11)    NOT NULL,
    `carId`                     bigint(20) NOT NULL,
    PRIMARY KEY (`id`),
    KEY `FK_PERFORMANCEPART_CAR_carId` (`carId`),
    CONSTRAINT `FK_PERFORMANCEPART_CAR_carId` FOREIGN KEY (`carId`) REFERENCES `car` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: FK_PERFORMANCEPART_CAR_carId (index)


-- No native definition for element: FK_PERSONA_USER_USERID (index)

-- persona_achievement: table
CREATE TABLE `persona_achievement`
(
    `ID`             bigint(20) NOT NULL AUTO_INCREMENT,
    `can_progress`   bit(1)     DEFAULT NULL,
    `current_value`  bigint(20) DEFAULT NULL,
    `achievement_id` bigint(20) NOT NULL,
    `persona_id`     bigint(20) NOT NULL,
    PRIMARY KEY (`ID`),
    KEY `persona_ach_index` (`persona_id`, `achievement_id`),
    KEY `FK_PERSONA_ACHIEVEMENT_ACHIEVEMENT_achievement_id` (`achievement_id`),
    CONSTRAINT `FK_PERSONA_ACHIEVEMENT_ACHIEVEMENT_achievement_id` FOREIGN KEY (`achievement_id`) REFERENCES `achievement` (`ID`) ON DELETE CASCADE,
    CONSTRAINT `FK_PERSONA_ACHIEVEMENT_PERSONA_persona_id` FOREIGN KEY (`persona_id`) REFERENCES `persona` (`ID`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: FK_PERSONA_ACHIEVEMENT_ACHIEVEMENT_achievement_id (index)

-- No native definition for element: persona_ach_index (index)

-- persona_achievement_rank: table
CREATE TABLE `persona_achievement_rank`
(
    `ID`                     bigint(20) NOT NULL AUTO_INCREMENT,
    `achieved_on`            datetime                                                                            DEFAULT NULL,
    `state`                  enum ('Locked','InProgress','Completed','RewardWaiting') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `achievement_rank_id`    bigint(20) NOT NULL,
    `persona_achievement_id` bigint(20) NOT NULL,
    PRIMARY KEY (`ID`),
    KEY `FK_PERSONA_ACHIEVEMENT_RANK_PERSONA_ACHIEVEMENT_id` (`persona_achievement_id`),
    KEY `FK_PERSONA_ACHIEVEMENT_RANK_ACHIEVEMENT_RANK_id` (`achievement_rank_id`),
    CONSTRAINT `FK_PERSONA_ACHIEVEMENT_RANK_ACHIEVEMENT_RANK_id` FOREIGN KEY (`achievement_rank_id`) REFERENCES `achievement_rank` (`ID`) ON DELETE CASCADE,
    CONSTRAINT `FK_PERSONA_ACHIEVEMENT_RANK_PERSONA_ACHIEVEMENT_id` FOREIGN KEY (`persona_achievement_id`) REFERENCES `persona_achievement` (`ID`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: FK_PERSONA_ACHIEVEMENT_RANK_ACHIEVEMENT_RANK_id (index)

-- No native definition for element: FK_PERSONA_ACHIEVEMENT_RANK_PERSONA_ACHIEVEMENT_id (index)

-- persona_badge: table
CREATE TABLE `persona_badge`
(
    `ID`                  bigint(20) NOT NULL AUTO_INCREMENT,
    `slot`                int(11) DEFAULT NULL,
    `badge_definition_id` bigint(20) NOT NULL,
    `persona_id`          bigint(20) NOT NULL,
    PRIMARY KEY (`ID`),
    KEY `FK_PERSONA_BADGE_BADGE_DEFINITION_badge_definition_id` (`badge_definition_id`),
    KEY `FK_PERSONA_BADGE_PERSONA_persona_id` (`persona_id`),
    CONSTRAINT `FK_PERSONA_BADGE_BADGE_DEFINITION_badge_definition_id` FOREIGN KEY (`badge_definition_id`) REFERENCES `badge_definition` (`ID`) ON DELETE CASCADE,
    CONSTRAINT `FK_PERSONA_BADGE_PERSONA_persona_id` FOREIGN KEY (`persona_id`) REFERENCES `persona` (`ID`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: FK_PERSONA_BADGE_BADGE_DEFINITION_badge_definition_id (index)

-- No native definition for element: FK_PERSONA_BADGE_PERSONA_persona_id (index)


-- No native definition for element: FK_PERSONA_GIFT_GIFT_CODE_code (index)

-- product: table
CREATE TABLE `product`
(
    `id`              bigint(20)                              NOT NULL AUTO_INCREMENT,
    `accel`           int(11)                                          DEFAULT NULL,
    `brand`           varchar(255) COLLATE utf8mb4_unicode_ci          DEFAULT NULL,
    `categoryId`      varchar(255) COLLATE utf8mb4_unicode_ci          DEFAULT NULL,
    `categoryName`    varchar(255) COLLATE utf8mb4_unicode_ci          DEFAULT NULL,
    `currency`        varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `description`     varchar(255) COLLATE utf8mb4_unicode_ci          DEFAULT NULL,
    `dropWeight`      double                                           DEFAULT NULL,
    `durationMinute`  int(11)                                 NOT NULL,
    `enabled`         bit(1)                                  NOT NULL,
    `entitlementTag`  varchar(255) COLLATE utf8mb4_unicode_ci          DEFAULT NULL,
    `handling`        int(11)                                          DEFAULT NULL,
    `hash`            int(11)                                          DEFAULT NULL,
    `icon`            varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `isDropable`      bit(1)                                  NOT NULL,
    `level`           int(11)                                 NOT NULL,
    `longDescription` varchar(255) COLLATE utf8mb4_unicode_ci          DEFAULT NULL,
    `minLevel`        int(11)                                 NOT NULL,
    `premium`         bit(1)                                  NOT NULL,
    `price`           float                                   NOT NULL,
    `priority`        int(11)                                 NOT NULL,
    `productId`       varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `productTitle`    varchar(255) COLLATE utf8mb4_unicode_ci          DEFAULT NULL,
    `productType`     varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `rarity`          int(11)                                          DEFAULT NULL,
    `resalePrice`     float                                   NOT NULL,
    `secondaryIcon`   varchar(255) COLLATE utf8mb4_unicode_ci          DEFAULT NULL,
    `skillValue`      float                                            DEFAULT NULL,
    `subType`         varchar(255) COLLATE utf8mb4_unicode_ci          DEFAULT NULL,
    `topSpeed`        int(11)                                          DEFAULT NULL,
    `useCount`        int(11)                                 NOT NULL,
    `visualStyle`     varchar(255) COLLATE utf8mb4_unicode_ci          DEFAULT NULL,
    `webIcon`         varchar(255) COLLATE utf8mb4_unicode_ci          DEFAULT NULL,
    `webLocation`     varchar(255) COLLATE utf8mb4_unicode_ci          DEFAULT NULL,
    `parentProductId` bigint(20)                                       DEFAULT NULL,
    `bundleItems`     mediumtext COLLATE utf8mb4_unicode_ci,
    `rewardTitle`     varchar(255) COLLATE utf8mb4_unicode_ci          DEFAULT NULL,
    `isGift`          tinyint(1)                              NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`),
    UNIQUE KEY `UK_PRODUCT_productId` (`productId`),
    KEY `PRODUCT_availability_index` (`categoryName`, `productType`, `enabled`, `minLevel`, `premium`),
    KEY `PRODUCT_entitlementTag_index` (`entitlementTag`),
    KEY `PRODUCT_hash_index` (`hash`),
    KEY `parent_prod_id_index` (`parentProductId`),
    KEY `prod_id_index` (`productId`),
    CONSTRAINT `FK_PRODUCT_PRODUCT_parentProductId` FOREIGN KEY (`parentProductId`) REFERENCES `product` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- inventory_item: table
CREATE TABLE `inventory_item`
(
    `id`                 bigint(20)                              NOT NULL AUTO_INCREMENT,
    `expirationDate`     datetime DEFAULT NULL,
    `remainingUseCount`  int(11)  DEFAULT NULL,
    `resellPrice`        int(11)  DEFAULT NULL,
    `status`             varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `inventoryEntity_id` bigint(20)                              NOT NULL,
    `productId`          varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    KEY `INVENTORY_ITEM_expirationDate_index` (`expirationDate`),
    KEY `FK_INVENTORY_ITEM_PRODUCT_productId` (`productId`),
    KEY `FK_INVENTORY_ITEM_INVENTORY_inventoryEntity_id` (`inventoryEntity_id`),
    CONSTRAINT `FK_INVENTORY_ITEM_INVENTORY_inventoryEntity_id` FOREIGN KEY (`inventoryEntity_id`) REFERENCES `inventory` (`id`) ON DELETE CASCADE,
    CONSTRAINT `FK_INVENTORY_ITEM_PRODUCT_productId` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- gift_code: table
CREATE TABLE `gift_code`
(
    `code`       varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `name`       varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `product_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `use_count`  int(11) DEFAULT '1',
    `beginTime`  timestamp                               NOT NULL,
    `endTime`    timestamp                               NOT NULL,
    PRIMARY KEY (`code`),
    KEY `FK_GIFT_CODE_PRODUCT_product_id` (`product_id`),
    CONSTRAINT `FK_GIFT_CODE_PRODUCT_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`productId`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
 
-- persona_gift: table
CREATE TABLE `persona_gift`
(
    `id`         bigint(20)                              NOT NULL AUTO_INCREMENT,
    `persona_id` bigint(20)                              NOT NULL,
    `code`       varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `use_count`  int(11)                                 NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `UK_PERSONA_ID_CODE` (`persona_id`, `code`),
    KEY `FK_PERSONA_GIFT_GIFT_CODE_code` (`code`),
    CONSTRAINT `FK_PERSONA_GIFT_GIFT_CODE_code` FOREIGN KEY (`code`) REFERENCES `gift_code` (`code`) ON DELETE CASCADE,
    CONSTRAINT `FK_PERSONA_GIFT_PERSONA_persona_id` FOREIGN KEY (`persona_id`) REFERENCES `persona` (`ID`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
-- basketdefinition: table
CREATE TABLE `basketdefinition`
(
    `productId`     varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `ownedCarTrans` longtext COLLATE utf8mb4_unicode_ci,
    PRIMARY KEY (`productId`),
    UNIQUE KEY `BASKETDEFINITION_productId_uindex` (`productId`),
    CONSTRAINT `FK_BASKETDEFINITION_PRODUCT_productId` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
-- amplifiers: table
CREATE TABLE `amplifiers`
(
    `id`             bigint(20)                              NOT NULL AUTO_INCREMENT,
    `ampType`        varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `cashMultiplier` float                                   DEFAULT NULL,
    `repMultiplier`  float                                   DEFAULT NULL,
    `product_id`     varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `UK_AMPLIFIERS_product_id` (`product_id`),
    CONSTRAINT `FK_AMPLIFIERS_PRODUCT_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`productId`) ON DELETE CASCADE
) ENGINE = InnoDB
  AUTO_INCREMENT = 9
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: PRODUCT_availability_index (index)

-- No native definition for element: PRODUCT_entitlementTag_index (index)

-- No native definition for element: PRODUCT_hash_index (index)

-- No native definition for element: prod_id_index (index)

-- No native definition for element: parent_prod_id_index (index)

-- promo_code: table
CREATE TABLE `promo_code`
(
    `id`        bigint(20) NOT NULL AUTO_INCREMENT,
    `isUsed`    bit(1)                                  DEFAULT NULL,
    `promoCode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `USERID`    bigint(20)                              DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `FK_PROMO_CODE_USER_USERID` (`USERID`),
    CONSTRAINT `FK_PROMO_CODE_USER_USERID` FOREIGN KEY (`USERID`) REFERENCES `user` (`ID`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: FK_PROMO_CODE_USER_USERID (index)

-- recovery_password: table
CREATE TABLE `recovery_password`
(
    `id`             bigint(20) NOT NULL AUTO_INCREMENT,
    `expirationDate` datetime                                                      DEFAULT NULL,
    `isClose`        bit(1)                                                        DEFAULT NULL,
    `randomKey`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `userId`         bigint(20)                                                    DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- report: table
CREATE TABLE `report`
(
    `id`              bigint(20) NOT NULL AUTO_INCREMENT,
    `abuserPersonaId` bigint(20)                              DEFAULT NULL,
    `chatMinutes`     int(11)                                 DEFAULT NULL,
    `customCarID`     int(11)                                 DEFAULT NULL,
    `description`     varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `hacksdetected`   bigint(20)                              DEFAULT NULL,
    `personaId`       bigint(20)                              DEFAULT NULL,
    `petitionType`    int(11)                                 DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- reward_table_item: table
CREATE TABLE `reward_table_item`
(
    `ID`                   bigint(20)                      NOT NULL AUTO_INCREMENT,
    `dropWeight`           double DEFAULT NULL,
    `script`               text COLLATE utf8mb4_unicode_ci NOT NULL,
    `rewardTableEntity_ID` bigint(20)                      NOT NULL,
    PRIMARY KEY (`ID`),
    KEY `FK_REWARD_TABLE_ITEM_REWARD_TABLE_rewardTableEntity_ID` (`rewardTableEntity_ID`),
    CONSTRAINT `FK_REWARD_TABLE_ITEM_REWARD_TABLE_rewardTableEntity_ID` FOREIGN KEY (`rewardTableEntity_ID`) REFERENCES `reward_table` (`ID`) ON DELETE CASCADE
) ENGINE = InnoDB
  AUTO_INCREMENT = 22086
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: FK_REWARD_TABLE_ITEM_REWARD_TABLE_rewardTableEntity_ID (index)

-- skillmodpart: table
CREATE TABLE `skillmodpart`
(
    `id`                     bigint(20) NOT NULL AUTO_INCREMENT,
    `isFixed`                bit(1)     NOT NULL,
    `skillModPartAttribHash` int(11)    NOT NULL,
    `carId`                  bigint(20) NOT NULL,
    PRIMARY KEY (`id`),
    KEY `FK_SKILLMODPART_CAR_carId` (`carId`),
    CONSTRAINT `FK_SKILLMODPART_CAR_carId` FOREIGN KEY (`carId`) REFERENCES `car` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: FK_SKILLMODPART_CAR_carId (index)

-- social_relationship: table
CREATE TABLE `social_relationship`
(
    `ID`              bigint(20) NOT NULL AUTO_INCREMENT,
    `remotePersonaId` bigint(20) DEFAULT NULL,
    `status`          bigint(20) DEFAULT NULL,
    `fromUserId`      bigint(20) DEFAULT NULL,
    `userId`          bigint(20) DEFAULT NULL,
    PRIMARY KEY (`ID`),
    KEY `FK_SOCIAL_RELATIONSHIP_USER_fromUserId` (`fromUserId`),
    KEY `FK_SOCIAL_RELATIONSHIP_USER_userId` (`userId`),
    KEY `FK_SOCIAL_RELATIONSHIP_PERSONA_remotePersonaId` (`remotePersonaId`),
    CONSTRAINT `FK_SOCIAL_RELATIONSHIP_PERSONA_remotePersonaId` FOREIGN KEY (`remotePersonaId`) REFERENCES `persona` (`ID`) ON DELETE CASCADE,
    CONSTRAINT `FK_SOCIAL_RELATIONSHIP_USER_fromUserId` FOREIGN KEY (`fromUserId`) REFERENCES `user` (`ID`) ON DELETE CASCADE,
    CONSTRAINT `FK_SOCIAL_RELATIONSHIP_USER_userId` FOREIGN KEY (`userId`) REFERENCES `user` (`ID`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: FK_SOCIAL_RELATIONSHIP_PERSONA_remotePersonaId (index)

-- No native definition for element: FK_SOCIAL_RELATIONSHIP_USER_fromUserId (index)

-- No native definition for element: FK_SOCIAL_RELATIONSHIP_USER_userId (index)

-- treasure_hunt: table
CREATE TABLE `treasure_hunt`
(
    `personaId`      bigint(20) NOT NULL,
    `coinsCollected` int(11) DEFAULT NULL,
    `isStreakBroken` bit(1)  DEFAULT NULL,
    `numCoins`       int(11) DEFAULT NULL,
    `seed`           int(11) DEFAULT NULL,
    `streak`         int(11) DEFAULT NULL,
    `thDate`         date    DEFAULT NULL,
    `isCompleted`    bit(1)     NOT NULL,
    PRIMARY KEY (`personaId`),
    CONSTRAINT `FK_TREASURE_HUNT_PERSONA_personaId` FOREIGN KEY (`personaId`) REFERENCES `persona` (`ID`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- treasure_hunt_config: table
CREATE TABLE `treasure_hunt_config`
(
    `ID`              bigint(20) NOT NULL AUTO_INCREMENT,
    `base_cash`       float      DEFAULT NULL,
    `base_rep`        float      DEFAULT NULL,
    `cash_multiplier` float      DEFAULT NULL,
    `rep_multiplier`  float      DEFAULT NULL,
    `streak`          int(11)    DEFAULT NULL,
    `reward_table_id` bigint(20) DEFAULT NULL,
    PRIMARY KEY (`ID`),
    KEY `FK_TREASURE_HUNT_CONFIG_REWARD_TABLE_reward_table_id` (`reward_table_id`),
    CONSTRAINT `FK_TREASURE_HUNT_CONFIG_REWARD_TABLE_reward_table_id` FOREIGN KEY (`reward_table_id`) REFERENCES `reward_table` (`ID`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: FK_TREASURE_HUNT_CONFIG_REWARD_TABLE_reward_table_id (index)

-- used_powerup: table
CREATE TABLE `used_powerup`
(
    `id`             bigint(20) NOT NULL AUTO_INCREMENT,
    `personaId`      bigint(20) NOT NULL,
    `eventSessionId` bigint(20)      DEFAULT NULL,
    `powerupHash`    int(11)    NOT NULL,
    `recorded_at`    timestamp  NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `hash_index` (`powerupHash`),
    KEY `FK_USED_POWERUP_EVENT_SESSION_eventSessionId` (`eventSessionId`),
    KEY `FK_USED_POWERUP_PERSONA_personaId` (`personaId`),
    CONSTRAINT `FK_USED_POWERUP_EVENT_SESSION_eventSessionId` FOREIGN KEY (`eventSessionId`) REFERENCES `event_session` (`ID`) ON DELETE CASCADE,
    CONSTRAINT `FK_USED_POWERUP_PERSONA_personaId` FOREIGN KEY (`personaId`) REFERENCES `persona` (`ID`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: FK_USED_POWERUP_PERSONA_personaId (index)

-- No native definition for element: FK_USED_POWERUP_EVENT_SESSION_eventSessionId (index)

-- No native definition for element: hash_index (index)



-- vinyl: table
CREATE TABLE `vinyl`
(
    `id`     bigint(20) NOT NULL AUTO_INCREMENT,
    `hash`   int(11)    NOT NULL,
    `hue1`   int(11)    NOT NULL,
    `hue2`   int(11)    NOT NULL,
    `hue3`   int(11)    NOT NULL,
    `hue4`   int(11)    NOT NULL,
    `layer`  int(11)    NOT NULL,
    `mir`    bit(1)     NOT NULL,
    `rot`    int(11)    NOT NULL,
    `sat1`   int(11)    NOT NULL,
    `sat2`   int(11)    NOT NULL,
    `sat3`   int(11)    NOT NULL,
    `sat4`   int(11)    NOT NULL,
    `scalex` int(11)    NOT NULL,
    `scaley` int(11)    NOT NULL,
    `shear`  int(11)    NOT NULL,
    `tranx`  int(11)    NOT NULL,
    `trany`  int(11)    NOT NULL,
    `var1`   int(11)    NOT NULL,
    `var2`   int(11)    NOT NULL,
    `var3`   int(11)    NOT NULL,
    `var4`   int(11)    NOT NULL,
    `carId`  bigint(20) NOT NULL,
    PRIMARY KEY (`id`),
    KEY `FK_VINYL_CAR_carId` (`carId`),
    CONSTRAINT `FK_VINYL_CAR_carId` FOREIGN KEY (`carId`) REFERENCES `car` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: FK_VINYL_CAR_carId (index)

-- vinylproduct: table
CREATE TABLE `vinylproduct`
(
    `id`               bigint(20) NOT NULL AUTO_INCREMENT,
    `bundleItems`      varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `categoryId`       varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `categoryName`     varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `currency`         varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `description`      varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `durationMinute`   int(11)    NOT NULL,
    `enabled`          bit(1)     NOT NULL,
    `entitlementTag`   varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `hash`             int(11)                                 DEFAULT NULL,
    `icon`             varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `level`            int(11)    NOT NULL,
    `longDescription`  varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `minLevel`         int(11)    NOT NULL,
    `premium`          bit(1)     NOT NULL,
    `price`            float      NOT NULL,
    `priority`         int(11)    NOT NULL,
    `productId`        varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `productTitle`     varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `productType`      varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `secondaryIcon`    varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `useCount`         int(11)    NOT NULL,
    `visualStyle`      varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `webIcon`          varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `webLocation`      varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `parentCategoryId` bigint(20)                              DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `FK_VINYLPRODUCT_CATEGORY` (`parentCategoryId`),
    CONSTRAINT `FK_VINYLPRODUCT_CATEGORY` FOREIGN KEY (`parentCategoryId`) REFERENCES `category` (`idcategory`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 3396
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: FK_VINYLPRODUCT_CATEGORY (index)

-- virtualitem: table
CREATE TABLE `virtualitem`
(
    `itemName`         varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `brand`            varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `hash`             int(11)                                 DEFAULT NULL,
    `icon`             varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `longdescription`  varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `rarity`           int(11)                                 DEFAULT NULL,
    `resellprice`      int(11)                                 DEFAULT NULL,
    `shortdescription` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `subType`          varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `tier`             int(11)                                 DEFAULT NULL,
    `title`            varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `type`             varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `warnondelete`     bit(1)                                  DEFAULT NULL,
    PRIMARY KEY (`itemName`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- visualpart: table
CREATE TABLE `visualpart`
(
    `id`       bigint(20) NOT NULL AUTO_INCREMENT,
    `partHash` int(11)    NOT NULL,
    `slotHash` int(11)    NOT NULL,
    `carId`    bigint(20) NOT NULL,
    PRIMARY KEY (`id`),
    KEY `FK_VISUALPART_CAR_carId` (`carId`),
    CONSTRAINT `FK_VISUALPART_CAR_carId` FOREIGN KEY (`carId`) REFERENCES `car` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- No native definition for element: FK_VISUALPART_CAR_carId (index)

