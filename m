Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1406D7B5EDB
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 03:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbjJCBzZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Oct 2023 21:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238986AbjJCBzZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Oct 2023 21:55:25 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63FAC9
        for <linux-wireless@vger.kernel.org>; Mon,  2 Oct 2023 18:55:20 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3931tCnF51334560, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3931tCnF51334560
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Oct 2023 09:55:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 3 Oct 2023 09:55:12 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 3 Oct 2023
 09:55:11 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/7] wifi: rtw89: debug: txpwr table supports Wi-Fi 7 chips
Date:   Tue, 3 Oct 2023 09:54:46 +0800
Message-ID: <20231003015446.14658-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231003015446.14658-1-pkshih@realtek.com>
References: <20231003015446.14658-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

We add TX power table format for Wi-Fi 7 chips. Since Wi-Fi 7 tables are
larger, in order to reuse some chunks, we extend code to process nested
entries. Now, dbgfs txpwr_table can work with Wi-Fi 7 chips.

An output example of dbgfs txpwr_table on Wi-Fi 7 chips is shown below.
...
[TX power byrate]
	<< BW20 >>
CCK       	-  1M      2M      5.5M   11M  	|  20,  20,  20,  20,	dBm
LEGACY    	-  6M      9M      12M    18M  	|  18,  18,  18,  18,	dBm
LEGACY    	-  24M     36M     48M    54M  	|  18,  18,  17,  16,	dBm
EHT       	-  MCS14   MCS15 		|   0,   0,		dBm
DLRU_EHT  	-  MCS14   MCS15 		|   0,  18,		dBm
MCS_1SS       	-  MCS0    MCS1    MCS2   MCS3 	|  18,  18,  18,  18,	dBm
MCS_1SS       	-  MCS4    MCS5    MCS6   MCS7 	|  18,  17,  16,  15,	dBm
MCS_1SS       	-  MCS8    MCS9    MCS10  MCS11	|  14,  13,  12,  11,	dBm
MCS_1SS       	-  MCS12   MCS13 		|  10,   9,		dBm
HEDCM_1SS     	-  MCS0    MCS1    MCS3   MCS4 	|  18,  18,  18,  18,	dBm
DLRU_MCS_1SS  	-  MCS0    MCS1    MCS2   MCS3 	|  18,  18,  18,  18,	dBm
DLRU_MCS_1SS  	-  MCS4    MCS5    MCS6   MCS7 	|  18,  17,  16,  15,	dBm
DLRU_MCS_1SS  	-  MCS8    MCS9    MCS10  MCS11	|  14,  13,  12,  11,	dBm
DLRU_MCS_1SS  	-  MCS12   MCS13 		|  10,   9,		dBm
DLRU_HEDCM_1SS	-  MCS0    MCS1    MCS3   MCS4 	|  18,  18,  18,  18,	dBm
MCS_2SS       	-  MCS0    MCS1    MCS2   MCS3 	|  18,  18,  18,  18,	dBm
...
[TX power limit]
	<< 1TX >>
CCK_20M    	-  NON_BF  BF	|   0,   0,		dBm
CCK_40M    	-  NON_BF  BF	|   0,   0,		dBm
OFDM       	-  NON_BF  BF	|  18,   0,		dBm
MCS_20M_0  	-  NON_BF  BF	|  18,   0,		dBm
MCS_20M_1  	-  NON_BF  BF	|   0,   0,		dBm
...

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 212 ++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/reg.h   |   3 +
 2 files changed, 210 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index afdcc596c4a6..6990d3679bc0 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -367,7 +367,11 @@ static int rtw89_debug_priv_rf_reg_dump_get(struct seq_file *m, void *v)
 }
 
 struct txpwr_ent {
-	const char *txt;
+	bool nested;
+	union {
+		const char *txt;
+		const struct txpwr_ent *ptr;
+	};
 	u8 len;
 };
 
@@ -379,6 +383,12 @@ struct txpwr_map {
 	u32 addr_to_1ss;
 };
 
+#define __GEN_TXPWR_ENT_NESTED(_e) \
+	{ .nested = true, .ptr = __txpwr_ent_##_e, \
+	  .len = ARRAY_SIZE(__txpwr_ent_##_e) }
+
+#define __GEN_TXPWR_ENT0(_t) { .len = 0, .txt = _t }
+
 #define __GEN_TXPWR_ENT2(_t, _e0, _e1) \
 	{ .len = 2, .txt = _t "\t-  " _e0 "  " _e1 }
 
@@ -501,14 +511,196 @@ static const struct txpwr_map __txpwr_map_lmt_ru_ax = {
 	.addr_to_1ss = R_AX_PWR_RU_LMT_1SS_MAX,
 };
 
-static u8 __print_txpwr_ent(struct seq_file *m, const struct txpwr_ent *ent,
-			    const s8 *buf, const u8 cur)
+static const struct txpwr_ent __txpwr_ent_byr_mcs_be[] = {
+	__GEN_TXPWR_ENT4("MCS_1SS       ", "MCS0  ", "MCS1  ", "MCS2 ", "MCS3 "),
+	__GEN_TXPWR_ENT4("MCS_1SS       ", "MCS4  ", "MCS5  ", "MCS6 ", "MCS7 "),
+	__GEN_TXPWR_ENT4("MCS_1SS       ", "MCS8  ", "MCS9  ", "MCS10", "MCS11"),
+	__GEN_TXPWR_ENT2("MCS_1SS       ", "MCS12 ", "MCS13 \t"),
+	__GEN_TXPWR_ENT4("HEDCM_1SS     ", "MCS0  ", "MCS1  ", "MCS3 ", "MCS4 "),
+	__GEN_TXPWR_ENT4("DLRU_MCS_1SS  ", "MCS0  ", "MCS1  ", "MCS2 ", "MCS3 "),
+	__GEN_TXPWR_ENT4("DLRU_MCS_1SS  ", "MCS4  ", "MCS5  ", "MCS6 ", "MCS7 "),
+	__GEN_TXPWR_ENT4("DLRU_MCS_1SS  ", "MCS8  ", "MCS9  ", "MCS10", "MCS11"),
+	__GEN_TXPWR_ENT2("DLRU_MCS_1SS  ", "MCS12 ", "MCS13 \t"),
+	__GEN_TXPWR_ENT4("DLRU_HEDCM_1SS", "MCS0  ", "MCS1  ", "MCS3 ", "MCS4 "),
+	__GEN_TXPWR_ENT4("MCS_2SS       ", "MCS0  ", "MCS1  ", "MCS2 ", "MCS3 "),
+	__GEN_TXPWR_ENT4("MCS_2SS       ", "MCS4  ", "MCS5  ", "MCS6 ", "MCS7 "),
+	__GEN_TXPWR_ENT4("MCS_2SS       ", "MCS8  ", "MCS9  ", "MCS10", "MCS11"),
+	__GEN_TXPWR_ENT2("MCS_2SS       ", "MCS12 ", "MCS13 \t"),
+	__GEN_TXPWR_ENT4("HEDCM_2SS     ", "MCS0  ", "MCS1  ", "MCS3 ", "MCS4 "),
+	__GEN_TXPWR_ENT4("DLRU_MCS_2SS  ", "MCS0  ", "MCS1  ", "MCS2 ", "MCS3 "),
+	__GEN_TXPWR_ENT4("DLRU_MCS_2SS  ", "MCS4  ", "MCS5  ", "MCS6 ", "MCS7 "),
+	__GEN_TXPWR_ENT4("DLRU_MCS_2SS  ", "MCS8  ", "MCS9  ", "MCS10", "MCS11"),
+	__GEN_TXPWR_ENT2("DLRU_MCS_2SS  ", "MCS12 ", "MCS13 \t"),
+	__GEN_TXPWR_ENT4("DLRU_HEDCM_2SS", "MCS0  ", "MCS1  ", "MCS3 ", "MCS4 "),
+};
+
+static const struct txpwr_ent __txpwr_ent_byr_be[] = {
+	__GEN_TXPWR_ENT0("BW20"),
+	__GEN_TXPWR_ENT4("CCK       ", "1M    ", "2M    ", "5.5M ", "11M  "),
+	__GEN_TXPWR_ENT4("LEGACY    ", "6M    ", "9M    ", "12M  ", "18M  "),
+	__GEN_TXPWR_ENT4("LEGACY    ", "24M   ", "36M   ", "48M  ", "54M  "),
+	__GEN_TXPWR_ENT2("EHT       ", "MCS14 ", "MCS15 \t"),
+	__GEN_TXPWR_ENT2("DLRU_EHT  ", "MCS14 ", "MCS15 \t"),
+	__GEN_TXPWR_ENT_NESTED(byr_mcs_be),
+
+	__GEN_TXPWR_ENT0("BW40"),
+	__GEN_TXPWR_ENT4("CCK       ", "1M    ", "2M    ", "5.5M ", "11M  "),
+	__GEN_TXPWR_ENT4("LEGACY    ", "6M    ", "9M    ", "12M  ", "18M  "),
+	__GEN_TXPWR_ENT4("LEGACY    ", "24M   ", "36M   ", "48M  ", "54M  "),
+	__GEN_TXPWR_ENT2("EHT       ", "MCS14 ", "MCS15 \t"),
+	__GEN_TXPWR_ENT2("DLRU_EHT  ", "MCS14 ", "MCS15 \t"),
+	__GEN_TXPWR_ENT_NESTED(byr_mcs_be),
+
+	/* there is no CCK section after BW80 */
+	__GEN_TXPWR_ENT0("BW80"),
+	__GEN_TXPWR_ENT4("LEGACY    ", "6M    ", "9M    ", "12M  ", "18M  "),
+	__GEN_TXPWR_ENT4("LEGACY    ", "24M   ", "36M   ", "48M  ", "54M  "),
+	__GEN_TXPWR_ENT2("EHT       ", "MCS14 ", "MCS15 \t"),
+	__GEN_TXPWR_ENT2("DLRU_EHT  ", "MCS14 ", "MCS15 \t"),
+	__GEN_TXPWR_ENT_NESTED(byr_mcs_be),
+
+	__GEN_TXPWR_ENT0("BW160"),
+	__GEN_TXPWR_ENT4("LEGACY    ", "6M    ", "9M    ", "12M  ", "18M  "),
+	__GEN_TXPWR_ENT4("LEGACY    ", "24M   ", "36M   ", "48M  ", "54M  "),
+	__GEN_TXPWR_ENT2("EHT       ", "MCS14 ", "MCS15 \t"),
+	__GEN_TXPWR_ENT2("DLRU_EHT  ", "MCS14 ", "MCS15 \t"),
+	__GEN_TXPWR_ENT_NESTED(byr_mcs_be),
+
+	__GEN_TXPWR_ENT0("BW320"),
+	__GEN_TXPWR_ENT4("LEGACY    ", "6M    ", "9M    ", "12M  ", "18M  "),
+	__GEN_TXPWR_ENT4("LEGACY    ", "24M   ", "36M   ", "48M  ", "54M  "),
+	__GEN_TXPWR_ENT2("EHT       ", "MCS14 ", "MCS15 \t"),
+	__GEN_TXPWR_ENT2("DLRU_EHT  ", "MCS14 ", "MCS15 \t"),
+	__GEN_TXPWR_ENT_NESTED(byr_mcs_be),
+};
+
+static const struct txpwr_map __txpwr_map_byr_be = {
+	.ent = __txpwr_ent_byr_be,
+	.size = ARRAY_SIZE(__txpwr_ent_byr_be),
+	.addr_from = R_BE_PWR_BY_RATE,
+	.addr_to = R_BE_PWR_BY_RATE_MAX,
+	.addr_to_1ss = 0, /* not support */
+};
+
+static const struct txpwr_ent __txpwr_ent_lmt_mcs_be[] = {
+	__GEN_TXPWR_ENT2("MCS_20M_0  ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_20M_1  ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_20M_2  ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_20M_3  ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_20M_4  ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_20M_5  ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_20M_6  ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_20M_7  ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_20M_8  ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_20M_9  ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_20M_10 ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_20M_11 ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_20M_12 ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_20M_13 ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_20M_14 ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_20M_15 ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_40M_0  ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_40M_1  ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_40M_2  ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_40M_3  ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_40M_4  ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_40M_5  ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_40M_6  ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_40M_7  ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_80M_0  ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_80M_1  ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_80M_2  ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_80M_3  ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_160M_0 ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_160M_1 ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_320M   ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_40M_0p5", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_40M_2p5", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_40M_4p5", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("MCS_40M_6p5", "NON_BF", "BF"),
+};
+
+static const struct txpwr_ent __txpwr_ent_lmt_be[] = {
+	__GEN_TXPWR_ENT0("1TX"),
+	__GEN_TXPWR_ENT2("CCK_20M    ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("CCK_40M    ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("OFDM       ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT_NESTED(lmt_mcs_be),
+
+	__GEN_TXPWR_ENT0("2TX"),
+	__GEN_TXPWR_ENT2("CCK_20M    ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("CCK_40M    ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT2("OFDM       ", "NON_BF", "BF"),
+	__GEN_TXPWR_ENT_NESTED(lmt_mcs_be),
+};
+
+static const struct txpwr_map __txpwr_map_lmt_be = {
+	.ent = __txpwr_ent_lmt_be,
+	.size = ARRAY_SIZE(__txpwr_ent_lmt_be),
+	.addr_from = R_BE_PWR_LMT,
+	.addr_to = R_BE_PWR_LMT_MAX,
+	.addr_to_1ss = 0, /* not support */
+};
+
+static const struct txpwr_ent __txpwr_ent_lmt_ru_indexes_be[] = {
+	__GEN_TXPWR_ENT8("RU26    ", "IDX_0 ", "IDX_1 ", "IDX_2 ", "IDX_3 ",
+			 "IDX_4 ", "IDX_5 ", "IDX_6 ", "IDX_7 "),
+	__GEN_TXPWR_ENT8("RU26    ", "IDX_8 ", "IDX_9 ", "IDX_10", "IDX_11",
+			 "IDX_12", "IDX_13", "IDX_14", "IDX_15"),
+	__GEN_TXPWR_ENT8("RU52    ", "IDX_0 ", "IDX_1 ", "IDX_2 ", "IDX_3 ",
+			 "IDX_4 ", "IDX_5 ", "IDX_6 ", "IDX_7 "),
+	__GEN_TXPWR_ENT8("RU52    ", "IDX_8 ", "IDX_9 ", "IDX_10", "IDX_11",
+			 "IDX_12", "IDX_13", "IDX_14", "IDX_15"),
+	__GEN_TXPWR_ENT8("RU106   ", "IDX_0 ", "IDX_1 ", "IDX_2 ", "IDX_3 ",
+			 "IDX_4 ", "IDX_5 ", "IDX_6 ", "IDX_7 "),
+	__GEN_TXPWR_ENT8("RU106   ", "IDX_8 ", "IDX_9 ", "IDX_10", "IDX_11",
+			 "IDX_12", "IDX_13", "IDX_14", "IDX_15"),
+	__GEN_TXPWR_ENT8("RU52_26 ", "IDX_0 ", "IDX_1 ", "IDX_2 ", "IDX_3 ",
+			 "IDX_4 ", "IDX_5 ", "IDX_6 ", "IDX_7 "),
+	__GEN_TXPWR_ENT8("RU52_26 ", "IDX_8 ", "IDX_9 ", "IDX_10", "IDX_11",
+			 "IDX_12", "IDX_13", "IDX_14", "IDX_15"),
+	__GEN_TXPWR_ENT8("RU106_26", "IDX_0 ", "IDX_1 ", "IDX_2 ", "IDX_3 ",
+			 "IDX_4 ", "IDX_5 ", "IDX_6 ", "IDX_7 "),
+	__GEN_TXPWR_ENT8("RU106_26", "IDX_8 ", "IDX_9 ", "IDX_10", "IDX_11",
+			 "IDX_12", "IDX_13", "IDX_14", "IDX_15"),
+};
+
+static const struct txpwr_ent __txpwr_ent_lmt_ru_be[] = {
+	__GEN_TXPWR_ENT0("1TX"),
+	__GEN_TXPWR_ENT_NESTED(lmt_ru_indexes_be),
+
+	__GEN_TXPWR_ENT0("2TX"),
+	__GEN_TXPWR_ENT_NESTED(lmt_ru_indexes_be),
+};
+
+static const struct txpwr_map __txpwr_map_lmt_ru_be = {
+	.ent = __txpwr_ent_lmt_ru_be,
+	.size = ARRAY_SIZE(__txpwr_ent_lmt_ru_be),
+	.addr_from = R_BE_PWR_RU_LMT,
+	.addr_to = R_BE_PWR_RU_LMT_MAX,
+	.addr_to_1ss = 0, /* not support */
+};
+
+static unsigned int
+__print_txpwr_ent(struct seq_file *m, const struct txpwr_ent *ent,
+		  const s8 *buf, const unsigned int cur)
 {
+	unsigned int cnt, i;
 	char *fmt;
 
+	if (ent->nested) {
+		for (cnt = 0, i = 0; i < ent->len; i++)
+			cnt += __print_txpwr_ent(m, ent->ptr + i, buf,
+						 cur + cnt);
+		return cnt;
+	}
+
 	switch (ent->len) {
+	case 0:
+		seq_printf(m, "\t<< %s >>\n", ent->txt);
+		return 0;
 	case 2:
-		fmt = "%s\t| %3d, %3d,\tdBm\n";
+		fmt = "%s\t| %3d, %3d,\t\tdBm\n";
 		seq_printf(m, fmt, ent->txt, buf[cur], buf[cur + 1]);
 		return 2;
 	case 4:
@@ -532,10 +724,10 @@ static int __print_txpwr_map(struct seq_file *m, struct rtw89_dev *rtwdev,
 {
 	u8 fct = rtwdev->chip->txpwr_factor_mac;
 	u8 path_num = rtwdev->chip->rf_path_num;
+	unsigned int cur, i;
 	u32 max_valid_addr;
 	u32 val, addr;
 	s8 *buf, tmp;
-	u8 cur, i;
 	int ret;
 
 	buf = vzalloc(map->addr_to - map->addr_from + 4);
@@ -547,6 +739,9 @@ static int __print_txpwr_map(struct seq_file *m, struct rtw89_dev *rtwdev,
 	else
 		max_valid_addr = map->addr_to;
 
+	if (max_valid_addr == 0)
+		return -EOPNOTSUPP;
+
 	for (addr = map->addr_from; addr <= max_valid_addr; addr += 4) {
 		ret = rtw89_mac_txpwr_read32(rtwdev, RTW89_PHY_0, addr, &val);
 		if (ret)
@@ -612,8 +807,15 @@ static const struct dbgfs_txpwr_table dbgfs_txpwr_table_ax = {
 	.lmt_ru = &__txpwr_map_lmt_ru_ax,
 };
 
+static const struct dbgfs_txpwr_table dbgfs_txpwr_table_be = {
+	.byr = &__txpwr_map_byr_be,
+	.lmt = &__txpwr_map_lmt_be,
+	.lmt_ru = &__txpwr_map_lmt_ru_be,
+};
+
 static const struct dbgfs_txpwr_table *dbgfs_txpwr_tables[RTW89_CHIP_GEN_NUM] = {
 	[RTW89_CHIP_AX] = &dbgfs_txpwr_table_ax,
+	[RTW89_CHIP_BE] = &dbgfs_txpwr_table_be,
 };
 
 static int rtw89_debug_priv_txpwr_table_get(struct seq_file *m, void *v)
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 27444801996f..2494c919bdce 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3939,8 +3939,11 @@
 
 #define R_BE_PWR_RATE_OFST_CTRL 0x11A30
 #define R_BE_PWR_BY_RATE 0x11E00
+#define R_BE_PWR_BY_RATE_MAX 0x11FA8
 #define R_BE_PWR_LMT 0x11FAC
+#define R_BE_PWR_LMT_MAX 0x12040
 #define R_BE_PWR_RU_LMT 0x12048
+#define R_BE_PWR_RU_LMT_MAX 0x120E4
 
 #define CMAC1_START_ADDR_BE 0x14000
 #define CMAC1_END_ADDR_BE 0x17FFF
-- 
2.25.1

