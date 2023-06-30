Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D967430FC
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jun 2023 01:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjF2XRG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 19:17:06 -0400
Received: from mail-yqbcan01on2054.outbound.protection.outlook.com ([40.107.116.54]:58502
        "EHLO CAN01-YQB-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231361AbjF2XQ7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 19:16:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VY31u4r9mIuHjs6t1mxAKUet3Qw56WatRPxx8rPbd1Jy0C5yOJYimkbBXnaQNfqlBRbzDTAVuahftf7Xs97aKKu8FGImdoKAO4rgypTvza/DyZlQbTVMSCEcIRyge1u73Ft+ynh4OBuWvuXxmsE1cxOAMKNbHOOT02IU5021jHC8QO46HCmMP3XXFVS2tlbKB6G7MdMVKf27P9PHGO4RyvLlMD494mKy3+0Yw0+6zh20Zu4lOBP08GJRlHdwfWzrXC6OtbG076K4d1o+8qvUMCSDhUgc9wnAkt1oIqDGYdIf0D6fl+noO30bnW4UVPl76v6cSOOZNDKbeak0DB98Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gozsn6ap8pDJ3cB85GwvxXhpYY/aa38h/cU7qKMsWZ8=;
 b=FZtIeU/khjoo+9I+arQO3Md22JINabubhFHBh3y+O+XGMjhZzPaGvy3nLj7pnzMPdC+1lOHXT9cH63JR9Gnh7e8JaJbyFSdmiCj5WQpEpkaF807jXpplRbp6hunkGONQ8KRjeXAnelovE7hRcVC+f0KZ/HddGWIAk9MRhhuAtDYeQ7k9JKU6GhXxPtg8ETQhk/SyxFzid/DHYJVw2YWDsBS+Y29+lI1whCqB9GFKdApOSW3QwG4b9jxp1nItSMV7jUnscr/hibg6NHQExA2a3zi5t1lHfVTcT8xtf5xkt6YshgPwb03AFMN9UMi64EeB5vlGzx4RSlVUKFU6G1n4Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:16::19)
 by YT1PR01MB8473.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 23:16:55 +0000
Received: from YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::684c:a6dd:94c8:78bc]) by YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::684c:a6dd:94c8:78bc%4]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 23:16:55 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [PATCH v3 11/11] wifi: ath9k: add QCN550x eeprom
Date:   Thu, 29 Jun 2023 16:16:25 -0700
Message-Id: <20230629231625.951744-12-wlooi@ucalgary.ca>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629231625.951744-1-wlooi@ucalgary.ca>
References: <20230629231625.951744-1-wlooi@ucalgary.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: BY3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::7) To YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:16::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YTBPR01MB3310:EE_|YT1PR01MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b8d4d89-3393-4189-6fed-08db78f6ed8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eWXwOWSuLTKb6KDFm/0uZyR7EMC9XsmCxIdZnkDfaLsCjNj+LNrqdFFApQOEFIhRPC07UHH79hPv7hSfHNp3AiTq0rWd9cJ+aDT6Dtz26pzIYS4U0s7cdwWw+29TCDShd5MK7vJ+xGJvu+zVMK8azw/jGjSd0v63MC+tOPxUuNEIGXVjorWPFB365Q42S2IFRxU97cSHjAXBpHJn66CQcPR8XvOgWhB75seTodyyddYvbyLdr8DxiJFUbUJl0+LpMMD+pFAOTOpkdlmCq+UauCQ3QF2yZjVeR55wsIpoBpW6eQC2tA362RGaMZkPVxt+QK4InAbLqZtT8Ct8a9NKWyUVgz/CTOhgnYszFAbNFK5AwDYViuXKsFtdbvBknk1wEXxzM4Vkw7k4Sp2Caldl1qAHlbRF/oM7Rsvyid5yv4TjdvpZ+OF7ntbVK5iX79IxGj6f5LGDd1I9zDbn0RyqMcg432MtP2mqzf1UrARj8Pr/8TvXTUkRtHjKMftLR2n1Cf9+4bBuUiF5jI280dbxFSzrMnqwAFso/+G9fVAuXeRwkIqIeMRyWkhMwxFlJjNI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199021)(26005)(4326008)(66556008)(66946007)(786003)(316002)(66476007)(8936002)(36756003)(6916009)(478600001)(8676002)(5660300002)(30864003)(2906002)(1076003)(86362001)(19627235002)(41300700001)(6486002)(2616005)(83380400001)(6506007)(6512007)(186003)(38100700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jv0MXhkmu/LvpYu5ZFn6+K6t7cPjczxWulr/hd7ZJehUip3WY0/1Edf0o25h?=
 =?us-ascii?Q?d6+CDMS697D2wTgN1exmhojYpEYbJ8OSfEBd10xSNgy6leIP79YDrqxUY3AE?=
 =?us-ascii?Q?00up27xvHZm6oSU3iMz1ycuZsv5QqVlgdR+MIKzo4ZNMKuExPYbduVRvEnts?=
 =?us-ascii?Q?EvZKTr7S+bn25OHSFrObBDJa1HUddhPgLE6MdTPD8ApHxcKmxuH3r5trEJYZ?=
 =?us-ascii?Q?NlOI0zeSuY4GjY1kOZIw97W0L64avuy2lROxrUpgGtWYEmInHyxTlSLbUBLB?=
 =?us-ascii?Q?Lvjn4qMGeyhSxMEOxitAJD6eKxyF9xg32c3Po+f9z7lyQs6FJ25KhQgNJN4j?=
 =?us-ascii?Q?BqDRWp+zT857KuRMpRi+bDj84dpyfMy3kKfJIIM3jJmf75AEqXyBoHDxeHGt?=
 =?us-ascii?Q?+9mCEp4R7qtUf+4hy2tIVgF87Bh31CEptcJYDssw9WtwQOONl/l03ET7+mEb?=
 =?us-ascii?Q?/zfB4oNMeVQYLUis7Q6DB6OZxrquVHWShje1ZtiX4dm77w3fZgDdv0JcRF3e?=
 =?us-ascii?Q?a/Kfio5mx3+WfbXOQK3dPq97Q0B5vudSj+hb2MWJlP8AKjoaMUUZtsUegx59?=
 =?us-ascii?Q?9drFBDxrs9BFDtm9LynYW5nVomkT3a+N4epJWbKL45IAts59aRzaGKO0y4kr?=
 =?us-ascii?Q?OE7WeYthxsD3rr0hkRAYLI14HuvNLB/7MGzXxU3I2M1N2n9LQL72HUW6pTwx?=
 =?us-ascii?Q?TjpkuTZ35PEHC+ul3Q5UhfxI762D+pDjFCWYJqIx7Wq8s9Sm84zkWhoajRhr?=
 =?us-ascii?Q?2gRI9BmgPmlNEBo4tRQC2P/N9sCX9+tGqqeUMG/b676FtVgvqWJyB2aEjqvT?=
 =?us-ascii?Q?OMscfWhs6lotWrRbTugmOjtxsOL9IhZOkHC+8+S+H+8x8vOaVF4in/YlIApf?=
 =?us-ascii?Q?/JuVqlrlmAQOK4KAFAgtxxxRcwdFVd7j87XGt32tOGThrPpqcoGC0uYJLilX?=
 =?us-ascii?Q?tMyVcXp972DgRpbmjN6eF521W3qG0DAyyo1dKp52tSCp9KqYyShdajpYpwbS?=
 =?us-ascii?Q?gPCOUuKqEdedZDlNnnzrdrqiE19N04U+dO5Bgs9oLGzmjBxWFeEi6bGTd/gU?=
 =?us-ascii?Q?F48vlo4fZPqUx0OkLbW4ZqSBD0TpSLoctrMCDPrFHSUSGdemflUv8clAbzPP?=
 =?us-ascii?Q?dxHRjvIV96V4ODHWk395slys6mglY9OWxHRS4gp6EDqWnMeNVxQ+FrKfzuIP?=
 =?us-ascii?Q?iJ6Eos1wSZUUVgyAUsPp09RdWIgvcawhOJLdKlPQ8j54oVrKElo68U0OBucK?=
 =?us-ascii?Q?Kp0HuWsLjXxioNEuxtt5Op3Bre8yHmWFB/6P4MgIztXaNnEcDerZodv6iys3?=
 =?us-ascii?Q?g6KBPayJWzQflkAFgPviVQ2MXGvV+MOlhcHh+6Ezu+RP69b37kVmT+YPmtDe?=
 =?us-ascii?Q?G2qZ7es1rAOETf49cDFHDw/IveKlraCj6M6IR//jnL9B9JCJ20ImYHQcVma7?=
 =?us-ascii?Q?HwQCOVjKRdExzRp8tg/xK6Nc8yS9BlBXFdXUdK9Gi7F7FbbwhOOPv5GaV3w7?=
 =?us-ascii?Q?M92HdYSdRwe9KegH/4EuRlHr+qCL3x0civVtL/GW45i09anrBEZaYT58O0nU?=
 =?us-ascii?Q?v59DaVU6lLxqX9Nr3gBtBC2CQ3TnDBgy27LFP+So?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8d4d89-3393-4189-6fed-08db78f6ed8d
X-MS-Exchange-CrossTenant-AuthSource: YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 23:16:54.6766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3wxyEPCcewcpeuDJlhZBNHOmfcC7fJisQbosZ1vGYvqm3pB0uR+VhybfK+nE3X+4v7n0gK2N3YpvjuEFuYSfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8473
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This adds support for the 4-chain eeprom used by QCN550x.

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
 .../net/wireless/ath/ath9k/ar9003_eeprom.c    | 294 +++++++++++++-----
 .../net/wireless/ath/ath9k/ar9003_eeprom.h    | 112 +++++++
 drivers/net/wireless/ath/ath9k/hw.h           |   1 +
 3 files changed, 337 insertions(+), 70 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
index 669506884b..f28ebc9953 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
@@ -2984,12 +2984,14 @@ static int ath9k_hw_ar9300_get_eeprom_rev(struct ath_hw *ah)
 
 static struct ar9300_base_eep_hdr *ar9003_base_header(struct ath_hw *ah)
 {
-	return &ah->eeprom.ar9300_eep.baseEepHeader;
+	return AR_SREV_5502(ah) ? &ah->eeprom.qcn5502.baseEepHeader :
+				  &ah->eeprom.ar9300_eep.baseEepHeader;
 }
 
 static struct ar9300_BaseExtension_1 *ar9003_base_ext1(struct ath_hw *ah)
 {
-	return &ah->eeprom.ar9300_eep.base_ext1;
+	return AR_SREV_5502(ah) ? &ah->eeprom.qcn5502.base_ext1 :
+				  &ah->eeprom.ar9300_eep.base_ext1;
 }
 
 static struct ar9300_modal_eep_header *ar9003_modal_header(struct ath_hw *ah,
@@ -3003,206 +3005,338 @@ static struct ar9300_modal_eep_header *ar9003_modal_header(struct ath_hw *ah,
 		return &eep->modalHeader5G;
 }
 
+static struct qcn5502_modal_eep_header *qcn5502_modal_header(struct ath_hw *ah,
+							     bool is2ghz)
+{
+	struct qcn5502_eeprom *eep = &ah->eeprom.qcn5502;
+
+	if (is2ghz)
+		return &eep->modalHeader2G;
+	else
+		return &eep->modalHeader5G;
+}
+
 static int8_t ar9003_ant_gain(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->antennaGain;
+	return AR_SREV_5502(ah) ?
+		       qcn5502_modal_header(ah, is2ghz)->antennaGain :
+		       ar9003_modal_header(ah, is2ghz)->antennaGain;
 }
 
 static u8 ar9003_cal_freq_pier(struct ath_hw *ah, int idx, bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	return is2ghz ? eep->calFreqPier2G[idx] : eep->calFreqPier5G[idx];
+	if (AR_SREV_5502(ah)) {
+		struct qcn5502_eeprom *eep = &ah->eeprom.qcn5502;
+		return is2ghz ? eep->calFreqPier2G[idx] :
+				eep->calFreqPier5G[idx];
+	} else {
+		struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+		return is2ghz ? eep->calFreqPier2G[idx] :
+				eep->calFreqPier5G[idx];
+	}
 }
 
 static struct ar9300_cal_data_per_freq_op_loop *
 ar9003_cal_pier_data(struct ath_hw *ah, int chain, int idx, bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	return is2ghz ? &eep->calPierData2G[chain][idx] :
-			      &eep->calPierData5G[chain][idx];
+	if (AR_SREV_5502(ah)) {
+		struct qcn5502_eeprom *eep = &ah->eeprom.qcn5502;
+		return is2ghz ? &eep->calPierData2G[chain][idx] :
+				&eep->calPierData5G[chain][idx];
+	} else {
+		struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+		return is2ghz ? &eep->calPierData2G[chain][idx] :
+				&eep->calPierData5G[chain][idx];
+	}
 }
 
 static u8 ar9003_cal_target_freqbin(struct ath_hw *ah, int idx, bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	return is2ghz ? eep->calTarget_freqbin_2G[idx] :
-			      eep->calTarget_freqbin_5G[idx];
+	if (AR_SREV_5502(ah)) {
+		struct qcn5502_eeprom *eep = &ah->eeprom.qcn5502;
+		return is2ghz ? eep->calTarget_freqbin_2G[idx] :
+				eep->calTarget_freqbin_5G[idx];
+	} else {
+		struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+		return is2ghz ? eep->calTarget_freqbin_2G[idx] :
+				eep->calTarget_freqbin_5G[idx];
+	}
 }
 
 static u8 ar9003_cal_target_freqbin_cck(struct ath_hw *ah, int idx)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	return eep->calTarget_freqbin_Cck[idx];
+	if (AR_SREV_5502(ah)) {
+		struct qcn5502_eeprom *eep = &ah->eeprom.qcn5502;
+		return eep->calTarget_freqbin_Cck[idx];
+	} else {
+		struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+		return eep->calTarget_freqbin_Cck[idx];
+	}
 }
 
 static u8 ar9003_cal_target_freqbin_ht20(struct ath_hw *ah, int idx,
 					 bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	return is2ghz ? eep->calTarget_freqbin_2GHT20[idx] :
-			      eep->calTarget_freqbin_5GHT20[idx];
+	if (AR_SREV_5502(ah)) {
+		struct qcn5502_eeprom *eep = &ah->eeprom.qcn5502;
+		return is2ghz ? eep->calTarget_freqbin_2GHT20[idx] :
+				eep->calTarget_freqbin_5GHT20[idx];
+	} else {
+		struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+		return is2ghz ? eep->calTarget_freqbin_2GHT20[idx] :
+				eep->calTarget_freqbin_5GHT20[idx];
+	}
 }
 
 static u8 ar9003_cal_target_freqbin_ht40(struct ath_hw *ah, int idx,
 					 bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	return is2ghz ? eep->calTarget_freqbin_2GHT40[idx] :
-			      eep->calTarget_freqbin_5GHT40[idx];
+	if (AR_SREV_5502(ah)) {
+		struct qcn5502_eeprom *eep = &ah->eeprom.qcn5502;
+		return is2ghz ? eep->calTarget_freqbin_2GHT40[idx] :
+				eep->calTarget_freqbin_5GHT40[idx];
+	} else {
+		struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+		return is2ghz ? eep->calTarget_freqbin_2GHT40[idx] :
+				eep->calTarget_freqbin_5GHT40[idx];
+	}
 }
 
 static u8 ar9003_cal_target_power(struct ath_hw *ah, int idx, int rateIndex,
 				  bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	return is2ghz ? eep->calTargetPower2G[idx].tPow2x[rateIndex] :
-			      eep->calTargetPower5G[idx].tPow2x[rateIndex];
+	if (AR_SREV_5502(ah)) {
+		struct qcn5502_eeprom *eep = &ah->eeprom.qcn5502;
+		return is2ghz ? eep->calTargetPower2G[idx].tPow2x[rateIndex] :
+				eep->calTargetPower5G[idx].tPow2x[rateIndex];
+	} else {
+		struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+		return is2ghz ? eep->calTargetPower2G[idx].tPow2x[rateIndex] :
+				eep->calTargetPower5G[idx].tPow2x[rateIndex];
+	}
 }
 
 static u8 ar9003_cal_target_power_cck(struct ath_hw *ah, int idx, int rateIndex)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	return eep->calTargetPowerCck[idx].tPow2x[rateIndex];
+	if (AR_SREV_5502(ah)) {
+		struct qcn5502_eeprom *eep = &ah->eeprom.qcn5502;
+		return eep->calTargetPowerCck[idx].tPow2x[rateIndex];
+	} else {
+		struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+		return eep->calTargetPowerCck[idx].tPow2x[rateIndex];
+	}
 }
 
 static u8 ar9003_cal_target_power_ht20(struct ath_hw *ah, int idx,
 				       int rateIndex, bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	return is2ghz ? eep->calTargetPower2GHT20[idx].tPow2x[rateIndex] :
-			      eep->calTargetPower5GHT20[idx].tPow2x[rateIndex];
+	if (AR_SREV_5502(ah)) {
+		struct qcn5502_eeprom *eep = &ah->eeprom.qcn5502;
+		return is2ghz ?
+			       eep->calTargetPower2GHT20[idx].tPow2x[rateIndex] :
+			       eep->calTargetPower5GHT20[idx].tPow2x[rateIndex];
+	} else {
+		struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+		return is2ghz ?
+			       eep->calTargetPower2GHT20[idx].tPow2x[rateIndex] :
+			       eep->calTargetPower5GHT20[idx].tPow2x[rateIndex];
+	}
 }
 
 static u8 ar9003_cal_target_power_ht40(struct ath_hw *ah, int idx,
 				       int rateIndex, bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	return is2ghz ? eep->calTargetPower2GHT40[idx].tPow2x[rateIndex] :
-			      eep->calTargetPower5GHT40[idx].tPow2x[rateIndex];
+	if (AR_SREV_5502(ah)) {
+		struct qcn5502_eeprom *eep = &ah->eeprom.qcn5502;
+		return is2ghz ?
+			       eep->calTargetPower2GHT40[idx].tPow2x[rateIndex] :
+			       eep->calTargetPower5GHT40[idx].tPow2x[rateIndex];
+	} else {
+		struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+		return is2ghz ?
+			       eep->calTargetPower2GHT40[idx].tPow2x[rateIndex] :
+			       eep->calTargetPower5GHT40[idx].tPow2x[rateIndex];
+	}
 }
 
 static u8 ar9003_ctl_freqbin(struct ath_hw *ah, int idx, int edge, bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	return is2ghz ? eep->ctl_freqbin_2G[idx][edge] :
-			      eep->ctl_freqbin_5G[idx][edge];
+	if (AR_SREV_5502(ah)) {
+		struct qcn5502_eeprom *eep = &ah->eeprom.qcn5502;
+		return is2ghz ? eep->ctl_freqbin_2G[idx][edge] :
+				eep->ctl_freqbin_5G[idx][edge];
+	} else {
+		struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+		return is2ghz ? eep->ctl_freqbin_2G[idx][edge] :
+				eep->ctl_freqbin_5G[idx][edge];
+	}
 }
 
 static u8 ar9003_ctl_index(struct ath_hw *ah, int idx, bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	return is2ghz ? eep->ctlIndex_2G[idx] : eep->ctlIndex_5G[idx];
+	if (AR_SREV_5502(ah)) {
+		struct qcn5502_eeprom *eep = &ah->eeprom.qcn5502;
+		return is2ghz ? eep->ctlIndex_2G[idx] : eep->ctlIndex_5G[idx];
+	} else {
+		struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+		return is2ghz ? eep->ctlIndex_2G[idx] : eep->ctlIndex_5G[idx];
+	}
 }
 
 static u8 ar9003_ctl_power_data(struct ath_hw *ah, int idx, int edge,
 				bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	return is2ghz ? eep->ctlPowerData_2G[idx].ctlEdges[edge] :
-			      eep->ctlPowerData_5G[idx].ctlEdges[edge];
+	if (AR_SREV_5502(ah)) {
+		struct qcn5502_eeprom *eep = &ah->eeprom.qcn5502;
+		return is2ghz ? eep->ctlPowerData_2G[idx].ctlEdges[edge] :
+				eep->ctlPowerData_5G[idx].ctlEdges[edge];
+	} else {
+		struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+		return is2ghz ? eep->ctlPowerData_2G[idx].ctlEdges[edge] :
+				eep->ctlPowerData_5G[idx].ctlEdges[edge];
+	}
 }
 
 static u16 ar9003_hw_ant_ctrl_chain_get(struct ath_hw *ah, int chain,
 					bool is2ghz)
 {
-	__le16 val = ar9003_modal_header(ah, is2ghz)->antCtrlChain[chain];
+	__le16 val =
+		AR_SREV_5502(ah) ?
+			qcn5502_modal_header(ah, is2ghz)->antCtrlChain[chain] :
+			ar9003_modal_header(ah, is2ghz)->antCtrlChain[chain];
 	return le16_to_cpu(val);
 }
 
 u32 ar9003_hw_ant_ctrl_common_get(struct ath_hw *ah, bool is2ghz)
 {
-	return le32_to_cpu(ar9003_modal_header(ah, is2ghz)->antCtrlCommon);
+	__le32 val = AR_SREV_5502(ah) ?
+			     qcn5502_modal_header(ah, is2ghz)->antCtrlCommon :
+			     ar9003_modal_header(ah, is2ghz)->antCtrlCommon;
+	return le32_to_cpu(val);
 }
 
 u32 ar9003_hw_ant_ctrl_common_2_get(struct ath_hw *ah, bool is2ghz)
 {
-	return le32_to_cpu(ar9003_modal_header(ah, is2ghz)->antCtrlCommon2);
+	__le32 val = AR_SREV_5502(ah) ?
+			     qcn5502_modal_header(ah, is2ghz)->antCtrlCommon2 :
+			     ar9003_modal_header(ah, is2ghz)->antCtrlCommon2;
+	return le32_to_cpu(val);
 }
 
 static int8_t ar9003_noise_floor_thres(struct ath_hw *ah, int chain,
 				       bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->noiseFloorThreshCh[chain];
+	return AR_SREV_5502(ah) ? qcn5502_modal_header(ah, is2ghz)
+					  ->noiseFloorThreshCh[chain] :
+				  ar9003_modal_header(ah, is2ghz)
+					  ->noiseFloorThreshCh[chain];
 }
 
 static int8_t ar9003_quick_drop(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->quick_drop;
+	return AR_SREV_5502(ah) ? qcn5502_modal_header(ah, is2ghz)->quick_drop :
+				  ar9003_modal_header(ah, is2ghz)->quick_drop;
 }
 
 static int8_t ar9003_temp_slope(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->tempSlope;
+	return AR_SREV_5502(ah) ? qcn5502_modal_header(ah, is2ghz)->tempSlope :
+				  ar9003_modal_header(ah, is2ghz)->tempSlope;
 }
 
 static int8_t ar9003_temp_slope_high(struct ath_hw *ah)
 {
-	return ah->eeprom.ar9300_eep.base_ext2.tempSlopeHigh;
+	return AR_SREV_5502(ah) ? ah->eeprom.qcn5502.base_ext2.tempSlopeHigh :
+				  ah->eeprom.ar9300_eep.base_ext2.tempSlopeHigh;
 }
 
 static int8_t ar9003_temp_slope_low(struct ath_hw *ah)
 {
-	return ah->eeprom.ar9300_eep.base_ext2.tempSlopeLow;
+	return AR_SREV_5502(ah) ? ah->eeprom.qcn5502.base_ext2.tempSlopeLow :
+				  ah->eeprom.ar9300_eep.base_ext2.tempSlopeLow;
 }
 
 static u8 ar9003_tx_end_to_xpa_off(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->txEndToXpaOff;
+	return AR_SREV_5502(ah) ?
+		       qcn5502_modal_header(ah, is2ghz)->txEndToXpaOff :
+		       ar9003_modal_header(ah, is2ghz)->txEndToXpaOff;
 }
 
 static u8 ar9003_tx_frame_to_xpa_on(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->txFrameToXpaOn;
+	return AR_SREV_5502(ah) ?
+		       qcn5502_modal_header(ah, is2ghz)->txFrameToXpaOn :
+		       ar9003_modal_header(ah, is2ghz)->txFrameToXpaOn;
 }
 
 static u8 ar9003_xatten1_db_high(struct ath_hw *ah, int chain)
 {
-	return ah->eeprom.ar9300_eep.base_ext2.xatten1DBHigh[chain];
+	return AR_SREV_5502(ah) ?
+		       ah->eeprom.qcn5502.base_ext2.xatten1DBHigh[chain] :
+		       ah->eeprom.ar9300_eep.base_ext2.xatten1DBHigh[chain];
 }
 
 static u8 ar9003_xatten1_db_low(struct ath_hw *ah, int chain)
 {
-	return ah->eeprom.ar9300_eep.base_ext2.xatten1DBLow[chain];
+	return AR_SREV_5502(ah) ?
+		       ah->eeprom.qcn5502.base_ext2.xatten1DBLow[chain] :
+		       ah->eeprom.ar9300_eep.base_ext2.xatten1DBLow[chain];
 }
 
 static u8 ar9003_xatten1_db_margin_high(struct ath_hw *ah, int chain)
 {
-	return ah->eeprom.ar9300_eep.base_ext2.xatten1MarginHigh[chain];
+	return AR_SREV_5502(ah) ?
+		       ah->eeprom.qcn5502.base_ext2.xatten1MarginHigh[chain] :
+		       ah->eeprom.ar9300_eep.base_ext2.xatten1MarginHigh[chain];
 }
 
 static u8 ar9003_xatten1_db_margin_low(struct ath_hw *ah, int chain)
 {
-	return ah->eeprom.ar9300_eep.base_ext2.xatten1MarginLow[chain];
+	return AR_SREV_5502(ah) ?
+		       ah->eeprom.qcn5502.base_ext2.xatten1MarginLow[chain] :
+		       ah->eeprom.ar9300_eep.base_ext2.xatten1MarginLow[chain];
 }
 
 static u8 ar9003_xatten1_db(struct ath_hw *ah, int chain, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->xatten1DB[chain];
+	return AR_SREV_5502(ah) ?
+		       qcn5502_modal_header(ah, is2ghz)->xatten1DB[chain] :
+		       ar9003_modal_header(ah, is2ghz)->xatten1DB[chain];
 }
 
 static u8 ar9003_xatten1_margin(struct ath_hw *ah, int chain, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->xatten1Margin[chain];
+	return AR_SREV_5502(ah) ?
+		       qcn5502_modal_header(ah, is2ghz)->xatten1Margin[chain] :
+		       ar9003_modal_header(ah, is2ghz)->xatten1Margin[chain];
 }
 
 static u8 ar9003_xlna_bias_strength(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->xlna_bias_strength;
+	return AR_SREV_5502(ah) ?
+		       qcn5502_modal_header(ah, is2ghz)->xlna_bias_strength :
+		       ar9003_modal_header(ah, is2ghz)->xlna_bias_strength;
 }
 
 static u8 ar9003_xpa_bias_lvl(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->xpaBiasLvl;
+	return AR_SREV_5502(ah) ? qcn5502_modal_header(ah, is2ghz)->xpaBiasLvl :
+				  ar9003_modal_header(ah, is2ghz)->xpaBiasLvl;
 }
 
 static u8 *ar9003_mac_addr(struct ath_hw *ah)
 {
-	return ah->eeprom.ar9300_eep.macAddr;
+	return AR_SREV_5502(ah) ? ah->eeprom.qcn5502.macAddr :
+				  ah->eeprom.ar9300_eep.macAddr;
 }
 
 static u16 ar9003_switch_com_spdt_get(struct ath_hw *ah, bool is2ghz)
 {
-	return le16_to_cpu(ar9003_modal_header(ah, is2ghz)->switchcomspdt);
+	__le16 val = AR_SREV_5502(ah) ?
+			     qcn5502_modal_header(ah, is2ghz)->switchcomspdt :
+			     ar9003_modal_header(ah, is2ghz)->switchcomspdt;
+	return le16_to_cpu(val);
 }
 
 static u32 ath9k_hw_ar9300_get_eeprom(struct ath_hw *ah,
@@ -3614,10 +3748,11 @@ static int ar9300_eeprom_restore_internal(struct ath_hw *ah,
  */
 static bool ath9k_hw_ar9300_fill_eeprom(struct ath_hw *ah)
 {
-	u8 *mptr = (u8 *) &ah->eeprom.ar9300_eep;
+	u8 *mptr = (u8 *)&ah->eeprom;
+	int mdata_size = AR_SREV_5502(ah) ? sizeof(struct qcn5502_eeprom) :
+					    sizeof(struct ar9300_eeprom);
 
-	if (ar9300_eeprom_restore_internal(ah, mptr,
-			sizeof(struct ar9300_eeprom)) < 0)
+	if (ar9300_eeprom_restore_internal(ah, mptr, mdata_size) < 0)
 		return false;
 
 	return true;
@@ -3627,32 +3762,42 @@ static bool ath9k_hw_ar9300_fill_eeprom(struct ath_hw *ah)
 
 static int8_t ar9003_adc_desired_size(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->adcDesiredSize;
+	return AR_SREV_5502(ah) ?
+		       qcn5502_modal_header(ah, is2ghz)->adcDesiredSize :
+		       ar9003_modal_header(ah, is2ghz)->adcDesiredSize;
 }
 
 static u8 ar9003_switch_settling(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->switchSettling;
+	return AR_SREV_5502(ah) ?
+		       qcn5502_modal_header(ah, is2ghz)->switchSettling :
+		       ar9003_modal_header(ah, is2ghz)->switchSettling;
 }
 
 static u8 ar9003_tx_clip(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->txClip;
+	return AR_SREV_5502(ah) ? qcn5502_modal_header(ah, is2ghz)->txClip :
+				  ar9003_modal_header(ah, is2ghz)->txClip;
 }
 
 static u8 ar9003_tx_frame_to_data_start(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->txFrameToDataStart;
+	return AR_SREV_5502(ah) ?
+		       qcn5502_modal_header(ah, is2ghz)->txFrameToDataStart :
+		       ar9003_modal_header(ah, is2ghz)->txFrameToDataStart;
 }
 
 static u8 ar9003_tx_frame_to_pa_on(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->txFrameToPaOn;
+	return AR_SREV_5502(ah) ?
+		       qcn5502_modal_header(ah, is2ghz)->txFrameToPaOn :
+		       ar9003_modal_header(ah, is2ghz)->txFrameToPaOn;
 }
 
 static int8_t ar9003_volt_slope(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->voltSlope;
+	return AR_SREV_5502(ah) ? qcn5502_modal_header(ah, is2ghz)->voltSlope :
+				  ar9003_modal_header(ah, is2ghz)->voltSlope;
 }
 
 static u32 ar9003_dump_modal_eeprom(struct ath_hw *ah, char *buf, u32 len,
@@ -5769,17 +5914,26 @@ s32 ar9003_hw_get_rx_gain_idx(struct ath_hw *ah)
 
 u8 *ar9003_get_spur_chan_ptr(struct ath_hw *ah, bool is2ghz)
 {
-	return ar9003_modal_header(ah, is2ghz)->spurChans;
+	return AR_SREV_5502(ah) ? qcn5502_modal_header(ah, is2ghz)->spurChans :
+				  ar9003_modal_header(ah, is2ghz)->spurChans;
 }
 
 u32 ar9003_get_paprd_rate_mask_ht20(struct ath_hw *ah, bool is2ghz)
 {
-	return le32_to_cpu(ar9003_modal_header(ah, is2ghz)->papdRateMaskHt20);
+	__le32 val =
+		AR_SREV_5502(ah) ?
+			qcn5502_modal_header(ah, is2ghz)->papdRateMaskHt20 :
+			ar9003_modal_header(ah, is2ghz)->papdRateMaskHt20;
+	return le32_to_cpu(val);
 }
 
 u32 ar9003_get_paprd_rate_mask_ht40(struct ath_hw *ah, bool is2ghz)
 {
-	return le32_to_cpu(ar9003_modal_header(ah, is2ghz)->papdRateMaskHt40);
+	__le32 val =
+		AR_SREV_5502(ah) ?
+			qcn5502_modal_header(ah, is2ghz)->papdRateMaskHt40 :
+			ar9003_modal_header(ah, is2ghz)->papdRateMaskHt40;
+	return le32_to_cpu(val);
 }
 
 unsigned int ar9003_get_paprd_scale_factor(struct ath_hw *ah,
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.h b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.h
index b91ef1250b..dad67eefba 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.h
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.h
@@ -42,6 +42,7 @@
 #define AR9300_CUSTOMER_DATA_SIZE    20
 
 #define AR9300_MAX_CHAINS            3
+#define QCN5502_MAX_CHAINS           4
 #define AR9300_ANT_16S               25
 #define AR9300_FUTURE_MODAL_SZ       6
 
@@ -252,6 +253,51 @@ struct ar9300_modal_eep_header {
 	u8 futureModal[7];
 } __packed;
 
+struct qcn5502_modal_eep_header {
+	/* 4 idle, t1, t2, b (4 bits per setting) */
+	__le32 antCtrlCommon;
+	/* 4 ra1l1, ra2l1, ra1l2, ra2l2, ra12 */
+	__le32 antCtrlCommon2;
+	/* 6 idle, t, r, rx1, rx12, b (2 bits each) */
+	__le16 antCtrlChain[QCN5502_MAX_CHAINS];
+	/* 3 xatten1_db for AR9280 (0xa20c/b20c 5:0) */
+	u8 xatten1DB[QCN5502_MAX_CHAINS];
+	/* 3  xatten1_margin for merlin (0xa20c/b20c 16:12 */
+	u8 xatten1Margin[QCN5502_MAX_CHAINS];
+	int8_t tempSlope;
+	int8_t voltSlope;
+	/* spur channels in usual fbin coding format */
+	u8 spurChans[AR_EEPROM_MODAL_SPURS];
+	/* 3  Check if the register is per chain */
+	int8_t noiseFloorThreshCh[QCN5502_MAX_CHAINS];
+	u8 reserved[13];
+	int8_t quick_drop;
+	u8 xpaBiasLvl;
+	u8 txFrameToDataStart;
+	u8 txFrameToPaOn;
+	u8 txClip;
+	int8_t antennaGain;
+	u8 switchSettling;
+	int8_t adcDesiredSize;
+	u8 txEndToXpaOff;
+	u8 txEndToRxOn;
+	u8 txFrameToXpaOn;
+	u8 thresh62;
+	__le32 papdRateMaskHt20;
+	__le32 papdRateMask4ssHt20;
+	__le32 papdRateMaskHt40;
+	__le32 papdRateMask4ssHt40;
+	__le16 switchcomspdt;
+	u8 xlna_bias_strength;
+	u8 rf_gain_cap;
+	u8 tx_gain_cap;
+	u8 futureModal[1];
+	int8_t xtal_ppm_target;
+	int8_t xtal_ppm_tolerance;
+	int8_t temp_slope_high_3;
+	int8_t eep_iqmask;
+} __packed;
+
 struct ar9300_cal_data_per_freq_op_loop {
 	int8_t refPower;
 	/* pdadc voltage at power measurement */
@@ -274,6 +320,10 @@ struct cal_tgt_pow_ht {
 	u8 tPow2x[14];
 } __packed;
 
+struct qcn5502_cal_tgt_pow_ht {
+	u8 tPow2x[18];
+} __packed;
+
 struct cal_ctl_data_2g {
 	u8 ctlEdges[AR9300_NUM_BAND_EDGES_2G];
 } __packed;
@@ -309,6 +359,15 @@ struct ar9300_BaseExtension_2 {
 	u8   xatten1MarginHigh[AR9300_MAX_CHAINS];
 } __packed;
 
+struct qcn5502_BaseExtension_2 {
+	int8_t    tempSlopeLow;
+	int8_t    tempSlopeHigh;
+	u8   xatten1DBLow[QCN5502_MAX_CHAINS];
+	u8   xatten1MarginLow[QCN5502_MAX_CHAINS];
+	u8   xatten1DBHigh[QCN5502_MAX_CHAINS];
+	u8   xatten1MarginHigh[QCN5502_MAX_CHAINS];
+} __packed;
+
 struct ar9300_eeprom {
 	u8 eepromVersion;
 	u8 templateVersion;
@@ -356,6 +415,59 @@ struct ar9300_eeprom {
 	struct cal_ctl_data_5g ctlPowerData_5G[AR9300_NUM_CTLS_5G];
 } __packed;
 
+static_assert(sizeof(struct ar9300_eeprom) == 0x440);
+
+struct qcn5502_eeprom {
+	u8 eepromVersion;
+	u8 templateVersion;
+	u8 macAddr[6];
+	u8 custData[AR9300_CUSTOMER_DATA_SIZE];
+
+	struct ar9300_base_eep_hdr baseEepHeader;
+
+	struct qcn5502_modal_eep_header modalHeader2G;
+	struct ar9300_BaseExtension_1 base_ext1;
+	u8 calFreqPier2G[AR9300_NUM_2G_CAL_PIERS];
+	struct ar9300_cal_data_per_freq_op_loop
+	 calPierData2G[QCN5502_MAX_CHAINS][AR9300_NUM_2G_CAL_PIERS];
+	u8 calTarget_freqbin_Cck[AR9300_NUM_2G_CCK_TARGET_POWERS];
+	u8 calTarget_freqbin_2G[AR9300_NUM_2G_20_TARGET_POWERS];
+	u8 calTarget_freqbin_2GHT20[AR9300_NUM_2G_20_TARGET_POWERS];
+	u8 calTarget_freqbin_2GHT40[AR9300_NUM_2G_40_TARGET_POWERS];
+	struct cal_tgt_pow_legacy
+	 calTargetPowerCck[AR9300_NUM_2G_CCK_TARGET_POWERS];
+	struct cal_tgt_pow_legacy
+	 calTargetPower2G[AR9300_NUM_2G_20_TARGET_POWERS];
+	struct qcn5502_cal_tgt_pow_ht
+	 calTargetPower2GHT20[AR9300_NUM_2G_20_TARGET_POWERS];
+	struct qcn5502_cal_tgt_pow_ht
+	 calTargetPower2GHT40[AR9300_NUM_2G_40_TARGET_POWERS];
+	u8 ctlIndex_2G[AR9300_NUM_CTLS_2G];
+	u8 ctl_freqbin_2G[AR9300_NUM_CTLS_2G][AR9300_NUM_BAND_EDGES_2G];
+	struct cal_ctl_data_2g ctlPowerData_2G[AR9300_NUM_CTLS_2G];
+	struct qcn5502_modal_eep_header modalHeader5G;
+	struct qcn5502_BaseExtension_2 base_ext2;
+	u8 calFreqPier5G[AR9300_NUM_5G_CAL_PIERS];
+	struct ar9300_cal_data_per_freq_op_loop
+	 calPierData5G[QCN5502_MAX_CHAINS][AR9300_NUM_5G_CAL_PIERS];
+	u8 calTarget_freqbin_5G[AR9300_NUM_5G_20_TARGET_POWERS];
+	u8 calTarget_freqbin_5GHT20[AR9300_NUM_5G_20_TARGET_POWERS];
+	u8 calTarget_freqbin_5GHT40[AR9300_NUM_5G_40_TARGET_POWERS];
+	struct cal_tgt_pow_legacy
+	 calTargetPower5G[AR9300_NUM_5G_20_TARGET_POWERS];
+	struct qcn5502_cal_tgt_pow_ht
+	 calTargetPower5GHT20[AR9300_NUM_5G_20_TARGET_POWERS];
+	struct qcn5502_cal_tgt_pow_ht
+	 calTargetPower5GHT40[AR9300_NUM_5G_40_TARGET_POWERS];
+	u8 ctlIndex_5G[AR9300_NUM_CTLS_5G];
+	u8 ctl_freqbin_5G[AR9300_NUM_CTLS_5G][AR9300_NUM_BAND_EDGES_5G];
+	struct cal_ctl_data_5g ctlPowerData_5G[AR9300_NUM_CTLS_5G];
+
+	u8 unknown[68];
+} __packed;
+
+static_assert(sizeof(struct qcn5502_eeprom) == 0x540);
+
 s32 ar9003_hw_get_tx_gain_idx(struct ath_hw *ah);
 s32 ar9003_hw_get_rx_gain_idx(struct ath_hw *ah);
 u32 ar9003_hw_ant_ctrl_common_get(struct ath_hw *ah, bool is2ghz);
diff --git a/drivers/net/wireless/ath/ath9k/hw.h b/drivers/net/wireless/ath/ath9k/hw.h
index 2349d0e93c..20ece9eb9a 100644
--- a/drivers/net/wireless/ath/ath9k/hw.h
+++ b/drivers/net/wireless/ath/ath9k/hw.h
@@ -790,6 +790,7 @@ struct ath_hw {
 		struct ar5416_eeprom_4k map4k;
 		struct ar9287_eeprom map9287;
 		struct ar9300_eeprom ar9300_eep;
+		struct qcn5502_eeprom qcn5502;
 	} eeprom;
 	const struct eeprom_ops *eep_ops;
 
-- 
2.34.1

