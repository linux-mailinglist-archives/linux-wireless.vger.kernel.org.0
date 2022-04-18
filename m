Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7549D504D22
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Apr 2022 09:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbiDRHXH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Apr 2022 03:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbiDRHXG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Apr 2022 03:23:06 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2055.outbound.protection.outlook.com [40.107.115.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F5317A82
        for <linux-wireless@vger.kernel.org>; Mon, 18 Apr 2022 00:20:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbcCo11sYNktcvc8yldiGl9w6F7hawcH1XBTGLMN/hLCN88HfTBZ3bq9hXBAuj1cVLw0+q76YoKNLiuqTPtQaWfW8hd39+YzK5+OVOiY97n4snwNY64LBIqDWo6AXH1PREE/KIenh+54BhrkRdoERI/M9ve+NShYIYkYnEP42rwHvs65OjtRO+bSZYmXyZ0EklLsXct0duD4CDuQu5FUnMOG95ZqYV1l+t+GzrYGmZfhpLX4SzqpWPTA0SBvoDdHGdpNkDEFi8wtlLWD+l072rnJ4nmxQT3fJIlKYTNMG4Jbrm88jJrZQzVY3/Cc1f04fkmln0UognIwKTEXmUYDDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQcASqUeUFeXzuK5Y6LMtxE2qLN5IVr+tk4Yl0VJv8Q=;
 b=BTjQnNVRk5qaik7gvtfmmCfkuUWK7W91ePHOvnrCUf2y0Ozy1UbBQxibVXtcXn3X8wZy9+Yr+viurAaBgSst4yapRiiBW3SY4fbCktsnAwETvIzCIXwYGHXfXcwRs65cic4QefYgeZGwZScRzL59+e4ACv7Xm/mXi0iUyU940ljRftLxZtZsuCDlLOycyD8TnuP2FDFr1Nz/WlmT0mCROiPgPBOsQEMr3JgTnM6kzn70RIsdLBt4Rw27OTuucEROOE2UnQfXFr2kslsqY/xIXR1M5RHukXjSMr6xjWXArZdnbrEEYCOM18EY0apKWDbpok0OnYl3qhdENetZa4WhkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YT1PR01MB4363.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 07:20:23 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::788b:f975:24ac:69f]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::788b:f975:24ac:69f%6]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 07:20:23 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH 7/9] ath9k: add abstractions over ar9300 eeprom
Date:   Mon, 18 Apr 2022 00:13:11 -0700
Message-Id: <20220418071313.882179-8-wlooi@ucalgary.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418071313.882179-1-wlooi@ucalgary.ca>
References: <20220418071313.882179-1-wlooi@ucalgary.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SJ0PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::9) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c44aa48e-14f7-44c5-4aeb-08da210be748
X-MS-TrafficTypeDiagnostic: YT1PR01MB4363:EE_
X-Microsoft-Antispam-PRVS: <YT1PR01MB43636F9974D74906F05EBEFDB2F39@YT1PR01MB4363.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/5tfDIxTfvd507OWhawrQdJlKAlIbgc+T/NRmQeOHSMwcrDoWUA2NK9fi3ZMAW8q4CnXjR39jaDhzxzXdTP3UxaeiErAcZm+qpjpHRr9y8Un1agAO1Xsw9M/yJIffvXlRV3xPn5YeCSL3uLNl1GgCdV5N4xYbsZpDxOMMAGsutX3p3LYu7torNCZ5dqXP/Qg2Wd3Bi2jrdX6zmvsKHRe3MYhSrzZ5shH8519uRBHkNcmzF5OQ/7JpheUm2+KtVqn3hOkSsV2vd1CDbxyc71PmuDOha3V1jp9b5ZE2+joObDlTDKHpqZAPFhFghwSsqlXePY9O9RFypEW+yXr5dZF1LX6b0yWIf/KvQ/06FwoX+lidnijyMpZMR513yat+mnbJSbzGPaAwYmZYGnbtjtA2Wd+nmkgKLlo7jTKPZlRLDm3jOld+/tO7JMBdAFoxTJO9rEQCgRlu+0/Vzw0cucOO90CHCjVkOjHvRUatzdJrZurzknGdX0hRL3V695An0mm+lgB/s100kQTjU/8xGUYIJR1qwE5pZZbn/3xugT7WPi4IypjFJME2nHZS5/YepsgZGxkavd3/z2+528NaIq/tf+0FIjutS1DYF8JNSAuTpXOS5rjTmuySBf15hKlMtoIEWRadLLUq+BUXFVggdFw23RlL/yoEn7onc4u9e4o4T5/7gsOjB2wkdKu3G6U+ss+eqq33Mzro8CVpzJuZLtGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(86362001)(83380400001)(6666004)(6916009)(54906003)(66946007)(316002)(186003)(30864003)(26005)(786003)(38350700002)(6486002)(38100700002)(19627235002)(107886003)(2616005)(1076003)(4326008)(8676002)(66476007)(66556008)(508600001)(8936002)(6506007)(36756003)(52116002)(2906002)(6512007)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+XD+po/PUNAuXIL3kOroft2UKv5YY2B1quftNk/+pFQPgWGMHQT0O/64CgW2?=
 =?us-ascii?Q?RObBTnvZWTaE/YmMfPoBbmtWjM9nZMWyqPIUp2p65ePKd7qBVjN6LZeW3PkN?=
 =?us-ascii?Q?rxEp6ngqyi9n28Qg8qPBkTpjQOonBBXdzEYsgndmqh/aocpjXMezs0weVTfg?=
 =?us-ascii?Q?PUg2ON8XupadYFX0z5Sr7XDSox85s6Zk1K/PFq2m4mQQ1f95AeLEIqe9WWyf?=
 =?us-ascii?Q?uo8OvLq5MAlztQbrU9WlDW6pMw5Nikz7atEkIMvEAGaWL3ACTChP8ON26ER5?=
 =?us-ascii?Q?e1uRZddw2oGwNb6ID80OVNMjcvF4Gjikk/fJJPb66OGq3ZNe7ut/C2F763Qx?=
 =?us-ascii?Q?TpP5ty4VHyks0EjghJXRTrpXPgN3ZJZUqW9IoxfsHz2JOk0pjUfp+ptvb3hD?=
 =?us-ascii?Q?db0dBKGmXqNhv5OCR0dAeYc+fOMgno6rgDep6qU3s/+VMkWo0Dqz9xP/aNkh?=
 =?us-ascii?Q?Wo+d7dOd289tx+pq+/n6lRydLNJC779H3qIJnrYe5S/opMLb4OopPYqzMg3V?=
 =?us-ascii?Q?BmNNGBWL6wrXN0wvTfj+QdBlBYcFdqJLBaqDXAHo1gywdwpJNzz36EmvwGDp?=
 =?us-ascii?Q?MBFglFPzomAU6+ttqiBo+vpfMRTVaVlojmkIxUwEGFr7b6CCOrbGTl3n7oLM?=
 =?us-ascii?Q?RdK+90Mxa4uUnSnev8MpVGo4+UfELZxJPVwMWW0Oo7YVlmb7kiuPErbRWzS9?=
 =?us-ascii?Q?j0HdwDIdqtEGjCtOHQ1/WuGTmlbIx5cOKN69I7I6vS6yNbC/Wn974DVmI6DW?=
 =?us-ascii?Q?qtMi9fQy+X63rbfTvBeTowKCnnZOY3nmdfMg4bGHuY82NepyUT1uwLUwH8H5?=
 =?us-ascii?Q?svhziLeniEzG0TZGxLgZ+q0gTlCWApe+jBOlfCtTb0anF/X5IamL6Omzv2fW?=
 =?us-ascii?Q?0AfVvlbcotGKAEEp91TFamlCPtZHrcw303FudBEuB/q8J4xwaE5CKjjEFbtN?=
 =?us-ascii?Q?/mtZcSYEhNk+pdQfBo+n/kvJ9bzU165DtTQL9hS4JjXAIofrVqsw3oesyZc+?=
 =?us-ascii?Q?GKpqkXLJY75uVQKGAlyB42jebahXG9wBqGXq0bnyIEWlWL54AB3CCg3Kltwg?=
 =?us-ascii?Q?Xt5mny1W1/W0Se+VtGAwdsSZ+7LZ6L1vY/Ax7Asg+YsybqFb8y7KTyGQ5nSp?=
 =?us-ascii?Q?9Bcc0+AIFe11Vumue2U5XK1JFk/pqcgqnJ/v8iPm2kBPEPKvhwTRouBw7iPR?=
 =?us-ascii?Q?Njqkf11n/Q1noywf/lEQEAaZ6ueQortcGu7ayAt9io1Znb5Byx/dFurK5WBf?=
 =?us-ascii?Q?QAVZ4ybe9IvZa09ud4NxBRoKl9aDZJi1mprXT9cLvf5WboqELuNB3wUCrJrd?=
 =?us-ascii?Q?G9fMD2FQME1Ud5OdSBO4PwyKYPZOu2OpXhKdS/ShDOya23eYsqarSxLwcIjn?=
 =?us-ascii?Q?1UtQDL1Xe9JcHJ2zBZz7A32LtufAsR5xOG3pfQc/ZpIqPXEddGtpPDHzH1nV?=
 =?us-ascii?Q?fYT7t/GZ5JbrLCRhb3CriGTRv6P5Ybq6DLVU68f5665tv6w2hILaN525u8kR?=
 =?us-ascii?Q?8N794UE1KGPOJtOlSSatOKZrS1+eqZvVjlEiJaYgpqRbd89zmMBXgyYTJ1hZ?=
 =?us-ascii?Q?0BGGY6RFoz34mOx5SJ2i9y+yuCh8T5LSgbgUuZIYhjXdjsK2Rz9KzAwmCayH?=
 =?us-ascii?Q?3V55D3iarR5RuJ9Divf1icXFxTmiV0VeO+VzAu7buIMK6lZ4jJn/QUT/XLOU?=
 =?us-ascii?Q?7PSSPRyc41I907P1KDcQ8spMjE2ZrqpPydvsx4QJTEgsqiD0dtmD43gj96C+?=
 =?us-ascii?Q?YdilvXGF8Q=3D=3D?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: c44aa48e-14f7-44c5-4aeb-08da210be748
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 07:20:23.7009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sVzpMOrx3QJkoTx4+ACKCqqVgGDT2T0TOttyI5NqIrWOSnNt1yCtu7xBnByKdD3xz8Lz7rAaAUUYtI1vIe7ykg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB4363
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This will allow the code to handle both old and new AR9300 eeprom
formats.

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
 .../net/wireless/ath/ath9k/ar9003_eeprom.c    | 633 +++++++++++-------
 1 file changed, 409 insertions(+), 224 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
index 6257d74c6..03eeee767 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
@@ -2982,6 +2982,16 @@ static int ath9k_hw_ar9300_get_eeprom_rev(struct ath_hw *ah)
 	return 0;
 }
 
+static struct ar9300_base_eep_hdr *ar9003_base_header(struct ath_hw *ah)
+{
+	return &ah->eeprom.ar9300_eep.baseEepHeader;
+}
+
+static struct ar9300_BaseExtension_1 *ar9003_base_ext1(struct ath_hw *ah)
+{
+	return &ah->eeprom.ar9300_eep.base_ext1;
+}
+
 static struct ar9300_modal_eep_header *ar9003_modal_header(struct ath_hw *ah,
 							   bool is2ghz)
 {
@@ -2993,6 +3003,105 @@ static struct ar9300_modal_eep_header *ar9003_modal_header(struct ath_hw *ah,
 		return &eep->modalHeader5G;
 }
 
+static int8_t ar9003_ant_gain(struct ath_hw *ah, bool is2ghz)
+{
+	return ar9003_modal_header(ah, is2ghz)->antennaGain;
+}
+
+static u8 ar9003_cal_freq_pier(struct ath_hw *ah, int idx, bool is2ghz)
+{
+	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	return is2ghz ? eep->calFreqPier2G[idx] : eep->calFreqPier5G[idx];
+}
+
+static struct ar9300_cal_data_per_freq_op_loop *
+ar9003_cal_pier_data(struct ath_hw *ah, int chain, int idx, bool is2ghz)
+{
+	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	return is2ghz ? &eep->calPierData2G[chain][idx] :
+			      &eep->calPierData5G[chain][idx];
+}
+
+static u8 ar9003_cal_target_freqbin(struct ath_hw *ah, int idx, bool is2ghz)
+{
+	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	return is2ghz ? eep->calTarget_freqbin_2G[idx] :
+			      eep->calTarget_freqbin_5G[idx];
+}
+
+static u8 ar9003_cal_target_freqbin_cck(struct ath_hw *ah, int idx)
+{
+	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	return eep->calTarget_freqbin_Cck[idx];
+}
+
+static u8 ar9003_cal_target_freqbin_ht20(struct ath_hw *ah, int idx,
+					 bool is2ghz)
+{
+	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	return is2ghz ? eep->calTarget_freqbin_2GHT20[idx] :
+			      eep->calTarget_freqbin_5GHT20[idx];
+}
+
+static u8 ar9003_cal_target_freqbin_ht40(struct ath_hw *ah, int idx,
+					 bool is2ghz)
+{
+	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	return is2ghz ? eep->calTarget_freqbin_2GHT40[idx] :
+			      eep->calTarget_freqbin_5GHT40[idx];
+}
+
+static u8 ar9003_cal_target_power(struct ath_hw *ah, int idx, int rateIndex,
+				  bool is2ghz)
+{
+	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	return is2ghz ? eep->calTargetPower2G[idx].tPow2x[rateIndex] :
+			      eep->calTargetPower5G[idx].tPow2x[rateIndex];
+}
+
+static u8 ar9003_cal_target_power_cck(struct ath_hw *ah, int idx, int rateIndex)
+{
+	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	return eep->calTargetPowerCck[idx].tPow2x[rateIndex];
+}
+
+static u8 ar9003_cal_target_power_ht20(struct ath_hw *ah, int idx,
+				       int rateIndex, bool is2ghz)
+{
+	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	return is2ghz ? eep->calTargetPower2GHT20[idx].tPow2x[rateIndex] :
+			      eep->calTargetPower5GHT20[idx].tPow2x[rateIndex];
+}
+
+static u8 ar9003_cal_target_power_ht40(struct ath_hw *ah, int idx,
+				       int rateIndex, bool is2ghz)
+{
+	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	return is2ghz ? eep->calTargetPower2GHT40[idx].tPow2x[rateIndex] :
+			      eep->calTargetPower5GHT40[idx].tPow2x[rateIndex];
+}
+
+static u8 ar9003_ctl_freqbin(struct ath_hw *ah, int idx, int edge, bool is2ghz)
+{
+	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	return is2ghz ? eep->ctl_freqbin_2G[idx][edge] :
+			      eep->ctl_freqbin_5G[idx][edge];
+}
+
+static u8 ar9003_ctl_index(struct ath_hw *ah, int idx, bool is2ghz)
+{
+	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	return is2ghz ? eep->ctlIndex_2G[idx] : eep->ctlIndex_5G[idx];
+}
+
+static u8 ar9003_ctl_power_data(struct ath_hw *ah, int idx, int edge,
+				bool is2ghz)
+{
+	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	return is2ghz ? eep->ctlPowerData_2G[idx].ctlEdges[edge] :
+			      eep->ctlPowerData_5G[idx].ctlEdges[edge];
+}
+
 static u16 ar9003_hw_ant_ctrl_chain_get(struct ath_hw *ah, int chain,
 					bool is2ghz)
 {
@@ -3010,6 +3119,87 @@ u32 ar9003_hw_ant_ctrl_common_2_get(struct ath_hw *ah, bool is2ghz)
 	return le32_to_cpu(ar9003_modal_header(ah, is2ghz)->antCtrlCommon2);
 }
 
+static int8_t ar9003_noise_floor_thres(struct ath_hw *ah, int chain,
+				       bool is2ghz)
+{
+	return ar9003_modal_header(ah, is2ghz)->noiseFloorThreshCh[chain];
+}
+
+static int8_t ar9003_quick_drop(struct ath_hw *ah, bool is2ghz)
+{
+	return ar9003_modal_header(ah, is2ghz)->quick_drop;
+}
+
+static int8_t ar9003_temp_slope(struct ath_hw *ah, bool is2ghz)
+{
+	return ar9003_modal_header(ah, is2ghz)->tempSlope;
+}
+
+static int8_t ar9003_temp_slope_high(struct ath_hw *ah)
+{
+	return ah->eeprom.ar9300_eep.base_ext2.tempSlopeHigh;
+}
+
+static int8_t ar9003_temp_slope_low(struct ath_hw *ah)
+{
+	return ah->eeprom.ar9300_eep.base_ext2.tempSlopeLow;
+}
+
+static u8 ar9003_tx_end_to_xpa_off(struct ath_hw *ah, bool is2ghz)
+{
+	return ar9003_modal_header(ah, is2ghz)->txEndToXpaOff;
+}
+
+static u8 ar9003_tx_frame_to_xpa_on(struct ath_hw *ah, bool is2ghz)
+{
+	return ar9003_modal_header(ah, is2ghz)->txFrameToXpaOn;
+}
+
+static u8 ar9003_xatten1_db_high(struct ath_hw *ah, int chain)
+{
+	return ah->eeprom.ar9300_eep.base_ext2.xatten1DBHigh[chain];
+}
+
+static u8 ar9003_xatten1_db_low(struct ath_hw *ah, int chain)
+{
+	return ah->eeprom.ar9300_eep.base_ext2.xatten1DBLow[chain];
+}
+
+static u8 ar9003_xatten1_db_margin_high(struct ath_hw *ah, int chain)
+{
+	return ah->eeprom.ar9300_eep.base_ext2.xatten1MarginHigh[chain];
+}
+
+static u8 ar9003_xatten1_db_margin_low(struct ath_hw *ah, int chain)
+{
+	return ah->eeprom.ar9300_eep.base_ext2.xatten1MarginLow[chain];
+}
+
+static u8 ar9003_xatten1_db(struct ath_hw *ah, int chain, bool is2ghz)
+{
+	return ar9003_modal_header(ah, is2ghz)->xatten1DB[chain];
+}
+
+static u8 ar9003_xatten1_margin(struct ath_hw *ah, int chain, bool is2ghz)
+{
+	return ar9003_modal_header(ah, is2ghz)->xatten1Margin[chain];
+}
+
+static u8 ar9003_xlna_bias_strength(struct ath_hw *ah, bool is2ghz)
+{
+	return ar9003_modal_header(ah, is2ghz)->xlna_bias_strength;
+}
+
+static u8 ar9003_xpa_bias_lvl(struct ath_hw *ah, bool is2ghz)
+{
+	return ar9003_modal_header(ah, is2ghz)->xpaBiasLvl;
+}
+
+static u8 *ar9003_mac_addr(struct ath_hw *ah)
+{
+	return ah->eeprom.ar9300_eep.macAddr;
+}
+
 static u16 ar9003_switch_com_spdt_get(struct ath_hw *ah, bool is2ghz)
 {
 	return le16_to_cpu(ar9003_modal_header(ah, is2ghz)->switchcomspdt);
@@ -3018,16 +3208,17 @@ static u16 ar9003_switch_com_spdt_get(struct ath_hw *ah, bool is2ghz)
 static u32 ath9k_hw_ar9300_get_eeprom(struct ath_hw *ah,
 				      enum eeprom_param param)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	struct ar9300_base_eep_hdr *pBase = &eep->baseEepHeader;
+	struct ar9300_base_eep_hdr *pBase = ar9003_base_header(ah);
+	struct ar9300_BaseExtension_1 *base_ext1 = ar9003_base_ext1(ah);
+	u8 *mac_addr = ar9003_mac_addr(ah);
 
 	switch (param) {
 	case EEP_MAC_LSW:
-		return get_unaligned_be16(eep->macAddr);
+		return get_unaligned_be16(mac_addr);
 	case EEP_MAC_MID:
-		return get_unaligned_be16(eep->macAddr + 2);
+		return get_unaligned_be16(mac_addr + 2);
 	case EEP_MAC_MSW:
-		return get_unaligned_be16(eep->macAddr + 4);
+		return get_unaligned_be16(mac_addr + 4);
 	case EEP_REG_0:
 		return le16_to_cpu(pBase->regDmn[0]);
 	case EEP_OP_CAP:
@@ -3048,11 +3239,11 @@ static u32 ath9k_hw_ar9300_get_eeprom(struct ath_hw *ah,
 		if (AR_SREV_9565(ah))
 			return AR9300_EEP_ANTDIV_CONTROL_DEFAULT_VALUE;
 		else
-			return eep->base_ext1.ant_div_control;
+			return base_ext1->ant_div_control;
 	case EEP_ANTENNA_GAIN_5G:
-		return eep->modalHeader5G.antennaGain;
+		return ar9003_ant_gain(ah, /*is2ghz=*/false);
 	case EEP_ANTENNA_GAIN_2G:
-		return eep->modalHeader2G.antennaGain;
+		return ar9003_ant_gain(ah, /*is2ghz=*/true);
 	default:
 		return 0;
 	}
@@ -3444,40 +3635,79 @@ static bool ath9k_hw_ar9300_fill_eeprom(struct ath_hw *ah)
 }
 
 #if defined(CONFIG_ATH9K_DEBUGFS) || defined(CONFIG_ATH9K_HTC_DEBUGFS)
-static u32 ar9003_dump_modal_eeprom(char *buf, u32 len, u32 size,
-				    struct ar9300_modal_eep_header *modal_hdr)
+
+static int8_t ar9003_adc_desired_size(struct ath_hw *ah, bool is2ghz)
 {
-	PR_EEP("Chain0 Ant. Control", le16_to_cpu(modal_hdr->antCtrlChain[0]));
-	PR_EEP("Chain1 Ant. Control", le16_to_cpu(modal_hdr->antCtrlChain[1]));
-	PR_EEP("Chain2 Ant. Control", le16_to_cpu(modal_hdr->antCtrlChain[2]));
-	PR_EEP("Ant. Common Control", le32_to_cpu(modal_hdr->antCtrlCommon));
-	PR_EEP("Ant. Common Control2", le32_to_cpu(modal_hdr->antCtrlCommon2));
-	PR_EEP("Ant. Gain", modal_hdr->antennaGain);
-	PR_EEP("Switch Settle", modal_hdr->switchSettling);
-	PR_EEP("Chain0 xatten1DB", modal_hdr->xatten1DB[0]);
-	PR_EEP("Chain1 xatten1DB", modal_hdr->xatten1DB[1]);
-	PR_EEP("Chain2 xatten1DB", modal_hdr->xatten1DB[2]);
-	PR_EEP("Chain0 xatten1Margin", modal_hdr->xatten1Margin[0]);
-	PR_EEP("Chain1 xatten1Margin", modal_hdr->xatten1Margin[1]);
-	PR_EEP("Chain2 xatten1Margin", modal_hdr->xatten1Margin[2]);
-	PR_EEP("Temp Slope", modal_hdr->tempSlope);
-	PR_EEP("Volt Slope", modal_hdr->voltSlope);
-	PR_EEP("spur Channels0", modal_hdr->spurChans[0]);
-	PR_EEP("spur Channels1", modal_hdr->spurChans[1]);
-	PR_EEP("spur Channels2", modal_hdr->spurChans[2]);
-	PR_EEP("spur Channels3", modal_hdr->spurChans[3]);
-	PR_EEP("spur Channels4", modal_hdr->spurChans[4]);
-	PR_EEP("Chain0 NF Threshold", modal_hdr->noiseFloorThreshCh[0]);
-	PR_EEP("Chain1 NF Threshold", modal_hdr->noiseFloorThreshCh[1]);
-	PR_EEP("Chain2 NF Threshold", modal_hdr->noiseFloorThreshCh[2]);
-	PR_EEP("Quick Drop", modal_hdr->quick_drop);
-	PR_EEP("txEndToXpaOff", modal_hdr->txEndToXpaOff);
-	PR_EEP("xPA Bias Level", modal_hdr->xpaBiasLvl);
-	PR_EEP("txFrameToDataStart", modal_hdr->txFrameToDataStart);
-	PR_EEP("txFrameToPaOn", modal_hdr->txFrameToPaOn);
-	PR_EEP("txFrameToXpaOn", modal_hdr->txFrameToXpaOn);
-	PR_EEP("txClip", modal_hdr->txClip);
-	PR_EEP("ADC Desired size", modal_hdr->adcDesiredSize);
+	return ar9003_modal_header(ah, is2ghz)->adcDesiredSize;
+}
+
+static u8 ar9003_switch_settling(struct ath_hw *ah, bool is2ghz)
+{
+	return ar9003_modal_header(ah, is2ghz)->switchSettling;
+}
+
+static u8 ar9003_tx_clip(struct ath_hw *ah, bool is2ghz)
+{
+	return ar9003_modal_header(ah, is2ghz)->txClip;
+}
+
+static u8 ar9003_tx_frame_to_data_start(struct ath_hw *ah, bool is2ghz)
+{
+	return ar9003_modal_header(ah, is2ghz)->txFrameToDataStart;
+}
+
+static u8 ar9003_tx_frame_to_pa_on(struct ath_hw *ah, bool is2ghz)
+{
+	return ar9003_modal_header(ah, is2ghz)->txFrameToPaOn;
+}
+
+static int8_t ar9003_volt_slope(struct ath_hw *ah, bool is2ghz)
+{
+	return ar9003_modal_header(ah, is2ghz)->voltSlope;
+}
+
+static u32 ar9003_dump_modal_eeprom(struct ath_hw *ah, char *buf, u32 len,
+				    u32 size, bool is_2g)
+{
+	PR_EEP("Chain0 Ant. Control",
+	       ar9003_hw_ant_ctrl_chain_get(ah, 0, is_2g));
+	PR_EEP("Chain1 Ant. Control",
+	       ar9003_hw_ant_ctrl_chain_get(ah, 1, is_2g));
+	PR_EEP("Chain2 Ant. Control",
+	       ar9003_hw_ant_ctrl_chain_get(ah, 2, is_2g));
+	PR_EEP("Ant. Common Control", ar9003_hw_ant_ctrl_common_get(ah, is_2g));
+	PR_EEP("Ant. Common Control2",
+	       ar9003_hw_ant_ctrl_common_2_get(ah, is_2g));
+	PR_EEP("Ant. Gain", ar9003_ant_gain(ah, is_2g));
+	PR_EEP("Switch Settle", ar9003_switch_settling(ah, is_2g));
+	PR_EEP("Chain0 xatten1DB", ar9003_xatten1_db(ah, 0, is_2g));
+	PR_EEP("Chain1 xatten1DB", ar9003_xatten1_db(ah, 1, is_2g));
+	PR_EEP("Chain2 xatten1DB", ar9003_xatten1_db(ah, 2, is_2g));
+	PR_EEP("Chain0 xatten1Margin", ar9003_xatten1_margin(ah, 0, is_2g));
+	PR_EEP("Chain1 xatten1Margin", ar9003_xatten1_margin(ah, 1, is_2g));
+	PR_EEP("Chain2 xatten1Margin", ar9003_xatten1_margin(ah, 2, is_2g));
+	PR_EEP("Temp Slope", ar9003_temp_slope(ah, is_2g));
+	PR_EEP("Volt Slope", ar9003_volt_slope(ah, is_2g));
+	PR_EEP("spur Channels0", ar9003_get_spur_chan_ptr(ah, is_2g)[0]);
+	PR_EEP("spur Channels1", ar9003_get_spur_chan_ptr(ah, is_2g)[1]);
+	PR_EEP("spur Channels2", ar9003_get_spur_chan_ptr(ah, is_2g)[2]);
+	PR_EEP("spur Channels3", ar9003_get_spur_chan_ptr(ah, is_2g)[3]);
+	PR_EEP("spur Channels4", ar9003_get_spur_chan_ptr(ah, is_2g)[4]);
+	PR_EEP("Chain0 NF Threshold",
+	       ar9003_noise_floor_thres(ah, 0, is_2g));
+	PR_EEP("Chain1 NF Threshold",
+	       ar9003_noise_floor_thres(ah, 1, is_2g));
+	PR_EEP("Chain2 NF Threshold",
+	       ar9003_noise_floor_thres(ah, 2, is_2g));
+	PR_EEP("Quick Drop", ar9003_quick_drop(ah, is_2g));
+	PR_EEP("txEndToXpaOff", ar9003_tx_end_to_xpa_off(ah, is_2g));
+	PR_EEP("xPA Bias Level", ar9003_xpa_bias_lvl(ah, is_2g));
+	PR_EEP("txFrameToDataStart",
+	       ar9003_tx_frame_to_data_start(ah, is_2g));
+	PR_EEP("txFrameToPaOn", ar9003_tx_frame_to_pa_on(ah, is_2g));
+	PR_EEP("txFrameToXpaOn", ar9003_tx_frame_to_xpa_on(ah, is_2g));
+	PR_EEP("txClip", ar9003_tx_clip(ah, is_2g));
+	PR_EEP("ADC Desired size", ar9003_adc_desired_size(ah, is_2g));
 
 	return len;
 }
@@ -3485,15 +3715,12 @@ static u32 ar9003_dump_modal_eeprom(char *buf, u32 len, u32 size,
 static u32 ar9003_dump_cal_data(struct ath_hw *ah, char *buf, u32 len, u32 size,
 				bool is_2g)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	struct ar9300_base_eep_hdr *pBase;
+	struct ar9300_base_eep_hdr *pBase = ar9003_base_header(ah);
 	struct ar9300_cal_data_per_freq_op_loop *cal_pier;
 	int cal_pier_nr;
 	int freq;
 	int i, j;
 
-	pBase = &eep->baseEepHeader;
-
 	if (is_2g)
 		cal_pier_nr = AR9300_NUM_2G_CAL_PIERS;
 	else
@@ -3509,12 +3736,11 @@ static u32 ar9003_dump_cal_data(struct ath_hw *ah, char *buf, u32 len, u32 size,
 			"Freq\t ref\tvolt\ttemp\tnf_cal\tnf_pow\trx_temp\n");
 
 		for (j = 0; j < cal_pier_nr; j++) {
+			cal_pier = ar9003_cal_pier_data(ah, i, j, is_2g);
 			if (is_2g) {
-				cal_pier = &eep->calPierData2G[i][j];
-				freq = 2300 + eep->calFreqPier2G[j];
+				freq = 2300 + ar9003_cal_freq_pier(ah, j, is_2g);
 			} else {
-				cal_pier = &eep->calPierData5G[i][j];
-				freq = 4800 + eep->calFreqPier5G[j] * 5;
+				freq = 4800 + ar9003_cal_freq_pier(ah, j, is_2g) * 5;
 			}
 
 			len += scnprintf(buf + len, size - len,
@@ -3539,22 +3765,19 @@ static u32 ar9003_dump_cal_data(struct ath_hw *ah, char *buf, u32 len, u32 size,
 static u32 ath9k_hw_ar9003_dump_eeprom(struct ath_hw *ah, bool dump_base_hdr,
 				       u8 *buf, u32 len, u32 size)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	struct ar9300_base_eep_hdr *pBase;
+	struct ar9300_base_eep_hdr *pBase = ar9003_base_header(ah);
 
 	if (!dump_base_hdr) {
 		len += scnprintf(buf + len, size - len,
 				 "%20s :\n", "2GHz modal Header");
-		len = ar9003_dump_modal_eeprom(buf, len, size,
-						&eep->modalHeader2G);
+		len = ar9003_dump_modal_eeprom(ah, buf, len, size, true);
 
 		len += scnprintf(buf + len, size - len, "Calibration data\n");
 		len = ar9003_dump_cal_data(ah, buf, len, size, true);
 
 		len += scnprintf(buf + len, size - len,
 				 "%20s :\n", "5GHz modal Header");
-		len = ar9003_dump_modal_eeprom(buf, len, size,
-						&eep->modalHeader5G);
+		len = ar9003_dump_modal_eeprom(ah, buf, len, size, false);
 
 		len += scnprintf(buf + len, size - len, "Calibration data\n");
 		len = ar9003_dump_cal_data(ah, buf, len, size, false);
@@ -3562,9 +3785,7 @@ static u32 ath9k_hw_ar9003_dump_eeprom(struct ath_hw *ah, bool dump_base_hdr,
 		goto out;
 	}
 
-	pBase = &eep->baseEepHeader;
-
-	PR_EEP("EEPROM Version", ah->eeprom.ar9300_eep.eepromVersion);
+	PR_EEP("EEPROM Version", ath9k_hw_ar9300_get_eeprom_ver(ah));
 	PR_EEP("RegDomain1", le16_to_cpu(pBase->regDmn[0]));
 	PR_EEP("RegDomain2", le16_to_cpu(pBase->regDmn[1]));
 	PR_EEP("TX Mask", (pBase->txrxMask >> 4));
@@ -3608,7 +3829,7 @@ static u32 ath9k_hw_ar9003_dump_eeprom(struct ath_hw *ah, bool dump_base_hdr,
 	PR_EEP("SW Reg", le32_to_cpu(pBase->swreg));
 
 	len += scnprintf(buf + len, size - len, "%20s : %pM\n", "MacAddress",
-			 ah->eeprom.ar9300_eep.macAddr);
+			 ar9003_mac_addr(ah));
 out:
 	if (len > size)
 		len = size;
@@ -3625,7 +3846,7 @@ static u32 ath9k_hw_ar9003_dump_eeprom(struct ath_hw *ah, bool dump_base_hdr,
 
 static void ar9003_hw_xpa_bias_level_apply(struct ath_hw *ah, bool is2ghz)
 {
-	int bias = ar9003_modal_header(ah, is2ghz)->xpaBiasLvl;
+	int bias = ar9003_xpa_bias_lvl(ah, is2ghz);
 
 	if (AR_SREV_9485(ah) || AR_SREV_9330(ah) || AR_SREV_9340(ah) ||
 	    AR_SREV_9531(ah) || AR_SREV_9561(ah))
@@ -3798,8 +4019,7 @@ static void ar9003_hw_ant_ctrl_apply(struct ath_hw *ah, bool is2ghz)
 
 static void ar9003_hw_drive_strength_apply(struct ath_hw *ah)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	struct ar9300_base_eep_hdr *pBase = &eep->baseEepHeader;
+	struct ar9300_base_eep_hdr *pBase = ar9003_base_header(ah);
 	int drive_strength;
 	unsigned long reg;
 
@@ -3843,23 +4063,23 @@ static u16 ar9003_hw_atten_chain_get(struct ath_hw *ah, int chain,
 {
 	int f[3], t[3];
 	u16 value;
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	bool is2ghz = IS_CHAN_2GHZ(chan);
 
 	if (chain >= 0 && chain < 3) {
-		if (IS_CHAN_2GHZ(chan))
-			return eep->modalHeader2G.xatten1DB[chain];
-		else if (eep->base_ext2.xatten1DBLow[chain] != 0) {
-			t[0] = eep->base_ext2.xatten1DBLow[chain];
+		if (is2ghz)
+			return ar9003_xatten1_db(ah, chain, is2ghz);
+		else if (ar9003_xatten1_db_low(ah, chain) != 0) {
+			t[0] = ar9003_xatten1_db_low(ah, chain);
 			f[0] = 5180;
-			t[1] = eep->modalHeader5G.xatten1DB[chain];
+			t[1] = ar9003_xatten1_db(ah, chain, is2ghz);
 			f[1] = 5500;
-			t[2] = eep->base_ext2.xatten1DBHigh[chain];
+			t[2] = ar9003_xatten1_db_high(ah, chain);
 			f[2] = 5785;
 			value = ar9003_hw_power_interpolate((s32) chan->channel,
 							    f, t, 3);
 			return value;
 		} else
-			return eep->modalHeader5G.xatten1DB[chain];
+			return ar9003_xatten1_db(ah, chain, is2ghz);
 	}
 
 	return 0;
@@ -3871,23 +4091,23 @@ static u16 ar9003_hw_atten_chain_get_margin(struct ath_hw *ah, int chain,
 {
 	int f[3], t[3];
 	u16 value;
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	bool is2ghz = IS_CHAN_2GHZ(chan);
 
 	if (chain >= 0 && chain < 3) {
-		if (IS_CHAN_2GHZ(chan))
-			return eep->modalHeader2G.xatten1Margin[chain];
-		else if (eep->base_ext2.xatten1MarginLow[chain] != 0) {
-			t[0] = eep->base_ext2.xatten1MarginLow[chain];
+		if (is2ghz)
+			return ar9003_xatten1_margin(ah, chain, is2ghz);
+		else if (ar9003_xatten1_db_margin_low(ah, chain) != 0) {
+			t[0] = ar9003_xatten1_db_margin_low(ah, chain);
 			f[0] = 5180;
-			t[1] = eep->modalHeader5G.xatten1Margin[chain];
+			t[1] = ar9003_xatten1_margin(ah, chain, is2ghz);
 			f[1] = 5500;
-			t[2] = eep->base_ext2.xatten1MarginHigh[chain];
+			t[2] = ar9003_xatten1_db_margin_high(ah, chain);
 			f[2] = 5785;
 			value = ar9003_hw_power_interpolate((s32) chan->channel,
 							    f, t, 3);
 			return value;
 		} else
-			return eep->modalHeader5G.xatten1Margin[chain];
+			return ar9003_xatten1_margin(ah, chain, is2ghz);
 	}
 
 	return 0;
@@ -3955,8 +4175,7 @@ static bool is_pmu_set(struct ath_hw *ah, u32 pmu_reg, int pmu_set)
 
 void ar9003_hw_internal_regulator_apply(struct ath_hw *ah)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	struct ar9300_base_eep_hdr *pBase = &eep->baseEepHeader;
+	struct ar9300_base_eep_hdr *pBase = ar9003_base_header(ah);
 	u32 reg_val;
 
 	if (pBase->featureEnable & BIT(4)) {
@@ -4050,13 +4269,13 @@ void ar9003_hw_internal_regulator_apply(struct ath_hw *ah)
 
 static void ar9003_hw_apply_tuning_caps(struct ath_hw *ah)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	u8 tuning_caps_param = eep->baseEepHeader.params_for_tuning_caps[0];
+	struct ar9300_base_eep_hdr *pBase = ar9003_base_header(ah);
+	u8 tuning_caps_param = pBase->params_for_tuning_caps[0];
 
 	if (AR_SREV_9340(ah) || AR_SREV_9531(ah))
 		return;
 
-	if (eep->baseEepHeader.featureEnable & 0x40) {
+	if (pBase->featureEnable & 0x40) {
 		tuning_caps_param &= 0x7f;
 		REG_RMW_FIELD(ah, AR_CH0_XTAL, AR_CH0_XTAL_CAPINDAC,
 			      tuning_caps_param);
@@ -4067,21 +4286,22 @@ static void ar9003_hw_apply_tuning_caps(struct ath_hw *ah)
 
 static void ar9003_hw_quick_drop_apply(struct ath_hw *ah, u16 freq)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	struct ar9300_base_eep_hdr *pBase = &eep->baseEepHeader;
+	struct ar9300_base_eep_hdr *pBase = ar9003_base_header(ah);
+	struct ar9300_BaseExtension_1 *base_ext1 = ar9003_base_ext1(ah);
 	int quick_drop;
 	s32 t[3], f[3] = {5180, 5500, 5785};
+	bool is2ghz = freq < 4000;
 
 	if (!(pBase->miscConfiguration & BIT(4)))
 		return;
 
 	if (AR_SREV_9300(ah) || AR_SREV_9580(ah) || AR_SREV_9340(ah)) {
-		if (freq < 4000) {
-			quick_drop = eep->modalHeader2G.quick_drop;
+		if (is2ghz) {
+			quick_drop = ar9003_quick_drop(ah, is2ghz);
 		} else {
-			t[0] = eep->base_ext1.quick_drop_low;
-			t[1] = eep->modalHeader5G.quick_drop;
-			t[2] = eep->base_ext1.quick_drop_high;
+			t[0] = base_ext1->quick_drop_low;
+			t[1] = ar9003_quick_drop(ah, is2ghz);
+			t[2] = base_ext1->quick_drop_high;
 			quick_drop = ar9003_hw_power_interpolate(freq, f, t, 3);
 		}
 		REG_RMW_FIELD(ah, AR_PHY_AGC, AR_PHY_AGC_QUICK_DROP, quick_drop);
@@ -4092,7 +4312,7 @@ static void ar9003_hw_txend_to_xpa_off_apply(struct ath_hw *ah, bool is2ghz)
 {
 	u32 value;
 
-	value = ar9003_modal_header(ah, is2ghz)->txEndToXpaOff;
+	value = ar9003_tx_end_to_xpa_off(ah, is2ghz);
 
 	REG_RMW_FIELD(ah, AR_PHY_XPA_TIMING_CTL,
 		      AR_PHY_XPA_TIMING_CTL_TX_END_XPAB_OFF, value);
@@ -4102,10 +4322,10 @@ static void ar9003_hw_txend_to_xpa_off_apply(struct ath_hw *ah, bool is2ghz)
 
 static void ar9003_hw_xpa_timing_control_apply(struct ath_hw *ah, bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	struct ar9300_base_eep_hdr *pBase = ar9003_base_header(ah);
 	u8 xpa_ctl;
 
-	if (!(eep->baseEepHeader.featureEnable & 0x80))
+	if (!(pBase->featureEnable & 0x80))
 		return;
 
 	if (!AR_SREV_9300(ah) &&
@@ -4116,7 +4336,7 @@ static void ar9003_hw_xpa_timing_control_apply(struct ath_hw *ah, bool is2ghz)
 	    !AR_SREV_5502(ah))
 		return;
 
-	xpa_ctl = ar9003_modal_header(ah, is2ghz)->txFrameToXpaOn;
+	xpa_ctl = ar9003_tx_frame_to_xpa_on(ah, is2ghz);
 	if (is2ghz)
 		REG_RMW_FIELD(ah, AR_PHY_XPA_TIMING_CTL,
 			      AR_PHY_XPA_TIMING_CTL_FRAME_XPAB_ON, xpa_ctl);
@@ -4127,16 +4347,16 @@ static void ar9003_hw_xpa_timing_control_apply(struct ath_hw *ah, bool is2ghz)
 
 static void ar9003_hw_xlna_bias_strength_apply(struct ath_hw *ah, bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	struct ar9300_base_eep_hdr *pBase = ar9003_base_header(ah);
 	u8 bias;
 
-	if (!(eep->baseEepHeader.miscConfiguration & 0x40))
+	if (!(pBase->miscConfiguration & 0x40))
 		return;
 
 	if (!AR_SREV_9300(ah))
 		return;
 
-	bias = ar9003_modal_header(ah, is2ghz)->xlna_bias_strength;
+	bias = ar9003_xlna_bias_strength(ah, is2ghz);
 	REG_RMW_FIELD(ah, AR_PHY_65NM_CH0_RXTX4, AR_PHY_65NM_RXTX4_XLNA_BIAS,
 		      bias & 0x3);
 	bias >>= 2;
@@ -4149,8 +4369,7 @@ static void ar9003_hw_xlna_bias_strength_apply(struct ath_hw *ah, bool is2ghz)
 
 static int ar9003_hw_get_thermometer(struct ath_hw *ah)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	struct ar9300_base_eep_hdr *pBase = &eep->baseEepHeader;
+	struct ar9300_base_eep_hdr *pBase = ar9003_base_header(ah);
 	int thermometer =  (pBase->miscConfiguration >> 1) & 0x3;
 
 	return --thermometer;
@@ -4208,7 +4427,7 @@ static void ar9003_hw_thermo_cal_apply(struct ath_hw *ah)
 static void ar9003_hw_apply_minccapwr_thresh(struct ath_hw *ah,
 					     bool is2ghz)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	struct ar9300_BaseExtension_1 *base_ext1 = ar9003_base_ext1(ah);
 	const u_int32_t cca_ctrl[AR9300_MAX_CHAINS] = {
 		AR_PHY_CCA_CTRL_0,
 		AR_PHY_CCA_CTRL_1,
@@ -4218,10 +4437,10 @@ static void ar9003_hw_apply_minccapwr_thresh(struct ath_hw *ah,
 	u32 val;
 
 	if (is2ghz) {
-		if (!(eep->base_ext1.misc_enable & BIT(2)))
+		if (!(base_ext1->misc_enable & BIT(2)))
 			return;
 	} else {
-		if (!(eep->base_ext1.misc_enable & BIT(3)))
+		if (!(base_ext1->misc_enable & BIT(3)))
 			return;
 	}
 
@@ -4229,7 +4448,7 @@ static void ar9003_hw_apply_minccapwr_thresh(struct ath_hw *ah,
 		if (!(ah->caps.tx_chainmask & BIT(chain)))
 			continue;
 
-		val = ar9003_modal_header(ah, is2ghz)->noiseFloorThreshCh[chain];
+		val = ar9003_noise_floor_thres(ah, chain, is2ghz);
 		REG_RMW_FIELD(ah, cca_ctrl[chain],
 			      AR_PHY_EXT_CCA0_THRESH62_1, val);
 	}
@@ -4330,18 +4549,11 @@ static u8 ar9003_hw_eeprom_get_tgt_pwr(struct ath_hw *ah,
 	u16 numPiers, i;
 	s32 targetPowerArray[AR9300_NUM_5G_20_TARGET_POWERS];
 	s32 freqArray[AR9300_NUM_5G_20_TARGET_POWERS];
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	struct cal_tgt_pow_legacy *pEepromTargetPwr;
-	u8 *pFreqBin;
 
 	if (is2GHz) {
 		numPiers = AR9300_NUM_2G_20_TARGET_POWERS;
-		pEepromTargetPwr = eep->calTargetPower2G;
-		pFreqBin = eep->calTarget_freqbin_2G;
 	} else {
 		numPiers = AR9300_NUM_5G_20_TARGET_POWERS;
-		pEepromTargetPwr = eep->calTargetPower5G;
-		pFreqBin = eep->calTarget_freqbin_5G;
 	}
 
 	/*
@@ -4349,8 +4561,10 @@ static u8 ar9003_hw_eeprom_get_tgt_pwr(struct ath_hw *ah,
 	 * targetpower piers stored on eeprom
 	 */
 	for (i = 0; i < numPiers; i++) {
-		freqArray[i] = ath9k_hw_fbin2freq(pFreqBin[i], is2GHz);
-		targetPowerArray[i] = pEepromTargetPwr[i].tPow2x[rateIndex];
+		freqArray[i] = ath9k_hw_fbin2freq(
+			ar9003_cal_target_freqbin(ah, i, is2GHz), is2GHz);
+		targetPowerArray[i] =
+			ar9003_cal_target_power(ah, i, rateIndex, is2GHz);
 	}
 
 	/* interpolate to get target power for given frequency */
@@ -4366,18 +4580,11 @@ static u8 ar9003_hw_eeprom_get_ht20_tgt_pwr(struct ath_hw *ah,
 	u16 numPiers, i;
 	s32 targetPowerArray[AR9300_NUM_5G_20_TARGET_POWERS];
 	s32 freqArray[AR9300_NUM_5G_20_TARGET_POWERS];
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	struct cal_tgt_pow_ht *pEepromTargetPwr;
-	u8 *pFreqBin;
 
 	if (is2GHz) {
 		numPiers = AR9300_NUM_2G_20_TARGET_POWERS;
-		pEepromTargetPwr = eep->calTargetPower2GHT20;
-		pFreqBin = eep->calTarget_freqbin_2GHT20;
 	} else {
 		numPiers = AR9300_NUM_5G_20_TARGET_POWERS;
-		pEepromTargetPwr = eep->calTargetPower5GHT20;
-		pFreqBin = eep->calTarget_freqbin_5GHT20;
 	}
 
 	/*
@@ -4385,8 +4592,11 @@ static u8 ar9003_hw_eeprom_get_ht20_tgt_pwr(struct ath_hw *ah,
 	 * from targetpower piers stored on eeprom
 	 */
 	for (i = 0; i < numPiers; i++) {
-		freqArray[i] = ath9k_hw_fbin2freq(pFreqBin[i], is2GHz);
-		targetPowerArray[i] = pEepromTargetPwr[i].tPow2x[rateIndex];
+		freqArray[i] = ath9k_hw_fbin2freq(
+			ar9003_cal_target_freqbin_ht20(ah, i, is2GHz),
+			is2GHz);
+		targetPowerArray[i] = ar9003_cal_target_power_ht20(
+			ah, i, rateIndex, is2GHz);
 	}
 
 	/* interpolate to get target power for given frequency */
@@ -4402,18 +4612,11 @@ static u8 ar9003_hw_eeprom_get_ht40_tgt_pwr(struct ath_hw *ah,
 	u16 numPiers, i;
 	s32 targetPowerArray[AR9300_NUM_5G_40_TARGET_POWERS];
 	s32 freqArray[AR9300_NUM_5G_40_TARGET_POWERS];
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	struct cal_tgt_pow_ht *pEepromTargetPwr;
-	u8 *pFreqBin;
 
 	if (is2GHz) {
 		numPiers = AR9300_NUM_2G_40_TARGET_POWERS;
-		pEepromTargetPwr = eep->calTargetPower2GHT40;
-		pFreqBin = eep->calTarget_freqbin_2GHT40;
 	} else {
 		numPiers = AR9300_NUM_5G_40_TARGET_POWERS;
-		pEepromTargetPwr = eep->calTargetPower5GHT40;
-		pFreqBin = eep->calTarget_freqbin_5GHT40;
 	}
 
 	/*
@@ -4421,8 +4624,11 @@ static u8 ar9003_hw_eeprom_get_ht40_tgt_pwr(struct ath_hw *ah,
 	 * targetpower piers stored on eeprom
 	 */
 	for (i = 0; i < numPiers; i++) {
-		freqArray[i] = ath9k_hw_fbin2freq(pFreqBin[i], is2GHz);
-		targetPowerArray[i] = pEepromTargetPwr[i].tPow2x[rateIndex];
+		freqArray[i] = ath9k_hw_fbin2freq(
+			ar9003_cal_target_freqbin_ht40(ah, i, is2GHz),
+			is2GHz);
+		targetPowerArray[i] = ar9003_cal_target_power_ht40(
+			ah, i, rateIndex, is2GHz);
 	}
 
 	/* interpolate to get target power for given frequency */
@@ -4437,17 +4643,16 @@ static u8 ar9003_hw_eeprom_get_cck_tgt_pwr(struct ath_hw *ah,
 	u16 numPiers = AR9300_NUM_2G_CCK_TARGET_POWERS, i;
 	s32 targetPowerArray[AR9300_NUM_2G_CCK_TARGET_POWERS];
 	s32 freqArray[AR9300_NUM_2G_CCK_TARGET_POWERS];
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	struct cal_tgt_pow_legacy *pEepromTargetPwr = eep->calTargetPowerCck;
-	u8 *pFreqBin = eep->calTarget_freqbin_Cck;
 
 	/*
 	 * create array of channels and targetpower from
 	 * targetpower piers stored on eeprom
 	 */
 	for (i = 0; i < numPiers; i++) {
-		freqArray[i] = ath9k_hw_fbin2freq(pFreqBin[i], 1);
-		targetPowerArray[i] = pEepromTargetPwr[i].tPow2x[rateIndex];
+		freqArray[i] = ath9k_hw_fbin2freq(
+			ar9003_cal_target_freqbin_cck(ah, i), 1);
+		targetPowerArray[i] =
+			ar9003_cal_target_power_cck(ah, i, rateIndex);
 	}
 
 	/* interpolate to get target power for given frequency */
@@ -4759,9 +4964,8 @@ static int ar9003_hw_cal_pier_get(struct ath_hw *ah,
 				  int *ptemperature, int *pvoltage,
 				  int *pnf_cal, int *pnf_power)
 {
-	u8 *pCalPier;
+	u8 calPier;
 	struct ar9300_cal_data_per_freq_op_loop *pCalPierStruct;
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
 	struct ath_common *common = ath9k_hw_common(ah);
 
 	if (ichain >= AR9300_MAX_CHAINS) {
@@ -4778,9 +4982,8 @@ static int ar9003_hw_cal_pier_get(struct ath_hw *ah,
 				AR9300_NUM_2G_CAL_PIERS);
 			return -1;
 		}
-
-		pCalPier = &(eep->calFreqPier2G[ipier]);
-		pCalPierStruct = &(eep->calPierData2G[ichain][ipier]);
+		calPier = ar9003_cal_freq_pier(ah, ipier, is2ghz);
+		pCalPierStruct = ar9003_cal_pier_data(ah, ichain, ipier, is2ghz);
 	} else {
 		if (ipier >= AR9300_NUM_5G_CAL_PIERS) {
 			ath_dbg(common, EEPROM,
@@ -4788,11 +4991,11 @@ static int ar9003_hw_cal_pier_get(struct ath_hw *ah,
 				AR9300_NUM_5G_CAL_PIERS);
 			return -1;
 		}
-		pCalPier = &(eep->calFreqPier5G[ipier]);
-		pCalPierStruct = &(eep->calPierData5G[ichain][ipier]);
+		calPier = ar9003_cal_freq_pier(ah, ipier, is2ghz);
+		pCalPierStruct = ar9003_cal_pier_data(ah, ichain, ipier, is2ghz);
 	}
 
-	*pfrequency = ath9k_hw_fbin2freq(*pCalPier, is2ghz);
+	*pfrequency = ath9k_hw_fbin2freq(calPier, is2ghz);
 	*pcorrection = pCalPierStruct->refPower;
 	*ptemperature = pCalPierStruct->tempMeas;
 	*pvoltage = pCalPierStruct->voltMeas;
@@ -4810,7 +5013,12 @@ static void ar9003_hw_power_control_override(struct ath_hw *ah,
 					     int *voltage, int *temperature)
 {
 	int temp_slope = 0, temp_slope1 = 0, temp_slope2 = 0;
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	struct ar9300_base_eep_hdr *pBase = ar9003_base_header(ah);
+	struct ar9300_BaseExtension_1 *base_ext1 = ar9003_base_ext1(ah);
+	bool is2ghz = frequency < 4000;
+	int8_t eep_temp_slope = ar9003_temp_slope(ah, is2ghz);
+	int8_t eep_temp_slope_low = ar9003_temp_slope_low(ah);
+	int8_t eep_temp_slope_high = ar9003_temp_slope_high(ah);
 	int f[8], t[8], t1[3], t2[3], i;
 
 	REG_RMW(ah, AR_PHY_TPC_11_B0,
@@ -4842,23 +5050,23 @@ static void ar9003_hw_power_control_override(struct ath_hw *ah,
 	 * enable temperature compensation
 	 * Need to use register names
 	 */
-	if (frequency < 4000) {
-		temp_slope = eep->modalHeader2G.tempSlope;
+	if (is2ghz) {
+		temp_slope = eep_temp_slope;
 	} else {
 		if (AR_SREV_9550(ah)) {
-			t[0] = eep->base_ext1.tempslopextension[2];
-			t1[0] = eep->base_ext1.tempslopextension[3];
-			t2[0] = eep->base_ext1.tempslopextension[4];
+			t[0] = base_ext1->tempslopextension[2];
+			t1[0] = base_ext1->tempslopextension[3];
+			t2[0] = base_ext1->tempslopextension[4];
 			f[0] = 5180;
 
-			t[1] = eep->modalHeader5G.tempSlope;
-			t1[1] = eep->base_ext1.tempslopextension[0];
-			t2[1] = eep->base_ext1.tempslopextension[1];
+			t[1] = eep_temp_slope;
+			t1[1] = base_ext1->tempslopextension[0];
+			t2[1] = base_ext1->tempslopextension[1];
 			f[1] = 5500;
 
-			t[2] = eep->base_ext1.tempslopextension[5];
-			t1[2] = eep->base_ext1.tempslopextension[6];
-			t2[2] = eep->base_ext1.tempslopextension[7];
+			t[2] = base_ext1->tempslopextension[5];
+			t1[2] = base_ext1->tempslopextension[6];
+			t2[2] = base_ext1->tempslopextension[7];
 			f[2] = 5785;
 
 			temp_slope = ar9003_hw_power_interpolate(frequency,
@@ -4871,42 +5079,44 @@ static void ar9003_hw_power_control_override(struct ath_hw *ah,
 			goto tempslope;
 		}
 
-		if ((eep->baseEepHeader.miscConfiguration & 0x20) != 0) {
+		if ((pBase->miscConfiguration & 0x20) != 0) {
 			for (i = 0; i < 8; i++) {
-				t[i] = eep->base_ext1.tempslopextension[i];
-				f[i] = FBIN2FREQ(eep->calFreqPier5G[i], 0);
+				t[i] = base_ext1->tempslopextension[i];
+				f[i] = FBIN2FREQ(
+					ar9003_cal_freq_pier(ah, i, is2ghz),
+					0);
 			}
 			temp_slope = ar9003_hw_power_interpolate((s32) frequency,
 								 f, t, 8);
-		} else if (eep->base_ext2.tempSlopeLow != 0) {
-			t[0] = eep->base_ext2.tempSlopeLow;
+		} else if (eep_temp_slope_low != 0) {
+			t[0] = eep_temp_slope_low;
 			f[0] = 5180;
-			t[1] = eep->modalHeader5G.tempSlope;
+			t[1] = eep_temp_slope;
 			f[1] = 5500;
-			t[2] = eep->base_ext2.tempSlopeHigh;
+			t[2] = eep_temp_slope_high;
 			f[2] = 5785;
 			temp_slope = ar9003_hw_power_interpolate((s32) frequency,
 								 f, t, 3);
 		} else {
-			temp_slope = eep->modalHeader5G.tempSlope;
+			temp_slope = eep_temp_slope;
 		}
 	}
 
 tempslope:
 	if (AR_SREV_9550(ah) || AR_SREV_9531(ah) || AR_SREV_9561(ah) ||
 	    AR_SREV_5502(ah)) {
-		u8 txmask = (eep->baseEepHeader.txrxMask & 0xf0) >> 4;
+		u8 txmask = (pBase->txrxMask & 0xf0) >> 4;
 
 		/*
 		 * AR955x has tempSlope register for each chain.
 		 * Check whether temp_compensation feature is enabled or not.
 		 */
-		if (eep->baseEepHeader.featureEnable & 0x1) {
-			if (frequency < 4000) {
+		if (pBase->featureEnable & 0x1) {
+			if (is2ghz) {
 				if (txmask & BIT(0))
 					REG_RMW_FIELD(ah, AR_PHY_TPC_19,
 						      AR_PHY_TPC_19_ALPHA_THERM,
-						      eep->base_ext2.tempSlopeLow);
+						      eep_temp_slope_low);
 				if (txmask & BIT(1))
 					REG_RMW_FIELD(ah, AR_PHY_TPC_19_B1,
 						      AR_PHY_TPC_19_ALPHA_THERM,
@@ -4914,7 +5124,7 @@ static void ar9003_hw_power_control_override(struct ath_hw *ah,
 				if (txmask & BIT(2))
 					REG_RMW_FIELD(ah, AR_PHY_TPC_19_B2,
 						      AR_PHY_TPC_19_ALPHA_THERM,
-						      eep->base_ext2.tempSlopeHigh);
+						      eep_temp_slope_high);
 			} else {
 				if (txmask & BIT(0))
 					REG_RMW_FIELD(ah, AR_PHY_TPC_19,
@@ -5139,42 +5349,25 @@ static int ar9003_hw_calibration_apply(struct ath_hw *ah, int frequency)
 	return 0;
 }
 
-static u16 ar9003_hw_get_direct_edge_power(struct ar9300_eeprom *eep,
+static u16 ar9003_hw_get_direct_edge_power(struct ath_hw *ah,
 					   int idx,
 					   int edge,
 					   bool is2GHz)
 {
-	struct cal_ctl_data_2g *ctl_2g = eep->ctlPowerData_2G;
-	struct cal_ctl_data_5g *ctl_5g = eep->ctlPowerData_5G;
-
-	if (is2GHz)
-		return CTL_EDGE_TPOWER(ctl_2g[idx].ctlEdges[edge]);
-	else
-		return CTL_EDGE_TPOWER(ctl_5g[idx].ctlEdges[edge]);
+	return CTL_EDGE_TPOWER(ar9003_ctl_power_data(ah, idx, edge, is2GHz));
 }
 
-static u16 ar9003_hw_get_indirect_edge_power(struct ar9300_eeprom *eep,
+static u16 ar9003_hw_get_indirect_edge_power(struct ath_hw *ah,
 					     int idx,
 					     unsigned int edge,
 					     u16 freq,
 					     bool is2GHz)
 {
-	struct cal_ctl_data_2g *ctl_2g = eep->ctlPowerData_2G;
-	struct cal_ctl_data_5g *ctl_5g = eep->ctlPowerData_5G;
-
-	u8 *ctl_freqbin = is2GHz ?
-		&eep->ctl_freqbin_2G[idx][0] :
-		&eep->ctl_freqbin_5G[idx][0];
-
-	if (is2GHz) {
-		if (ath9k_hw_fbin2freq(ctl_freqbin[edge - 1], 1) < freq &&
-		    CTL_EDGE_FLAGS(ctl_2g[idx].ctlEdges[edge - 1]))
-			return CTL_EDGE_TPOWER(ctl_2g[idx].ctlEdges[edge - 1]);
-	} else {
-		if (ath9k_hw_fbin2freq(ctl_freqbin[edge - 1], 0) < freq &&
-		    CTL_EDGE_FLAGS(ctl_5g[idx].ctlEdges[edge - 1]))
-			return CTL_EDGE_TPOWER(ctl_5g[idx].ctlEdges[edge - 1]);
-	}
+	if (ath9k_hw_fbin2freq(ar9003_ctl_freqbin(ah, idx, edge - 1, is2GHz),
+			       is2GHz) < freq &&
+	    CTL_EDGE_FLAGS(ar9003_ctl_power_data(ah, idx, edge - 1, is2GHz)))
+		return CTL_EDGE_TPOWER(
+			ar9003_ctl_power_data(ah, idx, edge - 1, is2GHz));
 
 	return MAX_RATE_POWER;
 }
@@ -5182,37 +5375,36 @@ static u16 ar9003_hw_get_indirect_edge_power(struct ar9300_eeprom *eep,
 /*
  * Find the maximum conformance test limit for the given channel and CTL info
  */
-static u16 ar9003_hw_get_max_edge_power(struct ar9300_eeprom *eep,
+static u16 ar9003_hw_get_max_edge_power(struct ath_hw *ah,
 					u16 freq, int idx, bool is2GHz)
 {
 	u16 twiceMaxEdgePower = MAX_RATE_POWER;
-	u8 *ctl_freqbin = is2GHz ?
-		&eep->ctl_freqbin_2G[idx][0] :
-		&eep->ctl_freqbin_5G[idx][0];
 	u16 num_edges = is2GHz ?
 		AR9300_NUM_BAND_EDGES_2G : AR9300_NUM_BAND_EDGES_5G;
 	unsigned int edge;
 
 	/* Get the edge power */
 	for (edge = 0;
-	     (edge < num_edges) && (ctl_freqbin[edge] != AR5416_BCHAN_UNUSED);
+	     (edge < num_edges) &&
+	     (ar9003_ctl_freqbin(ah, idx, edge, is2GHz) != AR5416_BCHAN_UNUSED);
 	     edge++) {
 		/*
 		 * If there's an exact channel match or an inband flag set
 		 * on the lower channel use the given rdEdgePower
 		 */
-		if (freq == ath9k_hw_fbin2freq(ctl_freqbin[edge], is2GHz)) {
-			twiceMaxEdgePower =
-				ar9003_hw_get_direct_edge_power(eep, idx,
-								edge, is2GHz);
+		if (freq == ath9k_hw_fbin2freq(ar9003_ctl_freqbin(ah, idx, edge,
+								  is2GHz),
+					       is2GHz)) {
+			twiceMaxEdgePower = ar9003_hw_get_direct_edge_power(
+				ah, idx, edge, is2GHz);
 			break;
 		} else if ((edge > 0) &&
-			   (freq < ath9k_hw_fbin2freq(ctl_freqbin[edge],
-						      is2GHz))) {
-			twiceMaxEdgePower =
-				ar9003_hw_get_indirect_edge_power(eep, idx,
-								  edge, freq,
-								  is2GHz);
+			   (freq <
+			    ath9k_hw_fbin2freq(ar9003_ctl_freqbin(ah, idx, edge,
+								  is2GHz),
+					       is2GHz))) {
+			twiceMaxEdgePower = ar9003_hw_get_indirect_edge_power(
+				ah, idx, edge, freq, is2GHz);
 			/*
 			 * Leave loop - no more affecting edges possible in
 			 * this monotonic increasing list
@@ -5234,7 +5426,6 @@ static void ar9003_hw_set_power_per_rate_table(struct ath_hw *ah,
 					       u16 powerLimit)
 {
 	struct ath_common *common = ath9k_hw_common(ah);
-	struct ar9300_eeprom *pEepData = &ah->eeprom.ar9300_eep;
 	u16 twiceMaxEdgePower;
 	int i;
 	u16 scaledPower = 0, minCtlPower;
@@ -5249,7 +5440,6 @@ static void ar9003_hw_set_power_per_rate_table(struct ath_hw *ah,
 	const u16 *pCtlMode;
 	u16 ctlMode, freq;
 	struct chan_centers centers;
-	u8 *ctlIndex;
 	u8 ctlNum;
 	u16 twiceMinEdgePower;
 	bool is2ghz = IS_CHAN_2GHZ(chan);
@@ -5304,18 +5494,17 @@ static void ar9003_hw_set_power_per_rate_table(struct ath_hw *ah,
 
 		/* walk through each CTL index stored in EEPROM */
 		if (is2ghz) {
-			ctlIndex = pEepData->ctlIndex_2G;
 			ctlNum = AR9300_NUM_CTLS_2G;
 		} else {
-			ctlIndex = pEepData->ctlIndex_5G;
 			ctlNum = AR9300_NUM_CTLS_5G;
 		}
 
 		twiceMaxEdgePower = MAX_RATE_POWER;
-		for (i = 0; (i < ctlNum) && ctlIndex[i]; i++) {
+		for (i = 0; (i < ctlNum) && ar9003_ctl_index(ah, i, is2ghz);
+		     i++) {
 			ath_dbg(common, REGULATORY,
 				"LOOP-Ctlidx %d: cfgCtl 0x%2.2x pCtlMode 0x%2.2x ctlIndex 0x%2.2x chan %d\n",
-				i, cfgCtl, pCtlMode[ctlMode], ctlIndex[i],
+				i, cfgCtl, pCtlMode[ctlMode], ar9003_ctl_index(ah, i, is2ghz),
 				chan->channel);
 
 			/*
@@ -5325,13 +5514,13 @@ static void ar9003_hw_set_power_per_rate_table(struct ath_hw *ah,
 			 */
 			if ((((cfgCtl & ~CTL_MODE_M) |
 			       (pCtlMode[ctlMode] & CTL_MODE_M)) ==
-				ctlIndex[i]) ||
+				ar9003_ctl_index(ah, i, is2ghz)) ||
 			    (((cfgCtl & ~CTL_MODE_M) |
 			       (pCtlMode[ctlMode] & CTL_MODE_M)) ==
-			     ((ctlIndex[i] & CTL_MODE_M) |
+			     ((ar9003_ctl_index(ah, i, is2ghz) & CTL_MODE_M) |
 			       SD_NO_CTL))) {
 				twiceMinEdgePower =
-				  ar9003_hw_get_max_edge_power(pEepData,
+				  ar9003_hw_get_max_edge_power(ah,
 							       freq, i,
 							       is2ghz);
 
@@ -5569,16 +5758,12 @@ static u16 ath9k_hw_ar9300_get_spur_channel(struct ath_hw *ah,
 
 s32 ar9003_hw_get_tx_gain_idx(struct ath_hw *ah)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-
-	return (eep->baseEepHeader.txrxgain >> 4) & 0xf; /* bits 7:4 */
+	return (ar9003_base_header(ah)->txrxgain >> 4) & 0xf; /* bits 7:4 */
 }
 
 s32 ar9003_hw_get_rx_gain_idx(struct ath_hw *ah)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-
-	return (eep->baseEepHeader.txrxgain) & 0xf; /* bits 3:0 */
+	return (ar9003_base_header(ah)->txrxgain) & 0xf; /* bits 3:0 */
 }
 
 u8 *ar9003_get_spur_chan_ptr(struct ath_hw *ah, bool is2ghz)
@@ -5619,7 +5804,7 @@ unsigned int ar9003_get_paprd_scale_factor(struct ath_hw *ah,
 
 static u8 ar9003_get_eepmisc(struct ath_hw *ah)
 {
-	return ah->eeprom.ar9300_eep.baseEepHeader.opCapFlags.eepMisc;
+	return ar9003_base_header(ah)->opCapFlags.eepMisc;
 }
 
 const struct eeprom_ops eep_ar9300_ops = {
-- 
2.25.1

