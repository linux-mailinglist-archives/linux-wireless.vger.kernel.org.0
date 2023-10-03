Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF7C7B5EDA
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 03:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbjJCBzZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Oct 2023 21:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238975AbjJCBzX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Oct 2023 21:55:23 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC818C4
        for <linux-wireless@vger.kernel.org>; Mon,  2 Oct 2023 18:55:19 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3931tCdK51334477, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3931tCdK51334477
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Oct 2023 09:55:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 3 Oct 2023 09:55:11 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 3 Oct 2023
 09:55:10 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/7] wifi: rtw89: debug: show txpwr table according to chip gen
Date:   Tue, 3 Oct 2023 09:54:45 +0800
Message-ID: <20231003015446.14658-7-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Since current TX power stuffs are for ax chips, add a suffix `_ax` to
them. Then, when requested to show txpwr table, select table according
to chip generation first.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 60 +++++++++++++++-------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index d162e64f6064..afdcc596c4a6 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -390,7 +390,7 @@ struct txpwr_map {
 	  _e0 "  " _e1 "  " _e2 "  " _e3 "  " \
 	  _e4 "  " _e5 "  " _e6 "  " _e7 }
 
-static const struct txpwr_ent __txpwr_ent_byr[] = {
+static const struct txpwr_ent __txpwr_ent_byr_ax[] = {
 	__GEN_TXPWR_ENT4("CCK       ", "1M   ", "2M   ", "5.5M ", "11M  "),
 	__GEN_TXPWR_ENT4("LEGACY    ", "6M   ", "9M   ", "12M  ", "18M  "),
 	__GEN_TXPWR_ENT4("LEGACY    ", "24M  ", "36M  ", "48M  ", "54M  "),
@@ -406,18 +406,18 @@ static const struct txpwr_ent __txpwr_ent_byr[] = {
 	__GEN_TXPWR_ENT4("HEDCM_2NSS", "MCS0 ", "MCS1 ", "MCS3 ", "MCS4 "),
 };
 
-static_assert((ARRAY_SIZE(__txpwr_ent_byr) * 4) ==
+static_assert((ARRAY_SIZE(__txpwr_ent_byr_ax) * 4) ==
 	(R_AX_PWR_BY_RATE_MAX - R_AX_PWR_BY_RATE + 4));
 
-static const struct txpwr_map __txpwr_map_byr = {
-	.ent = __txpwr_ent_byr,
-	.size = ARRAY_SIZE(__txpwr_ent_byr),
+static const struct txpwr_map __txpwr_map_byr_ax = {
+	.ent = __txpwr_ent_byr_ax,
+	.size = ARRAY_SIZE(__txpwr_ent_byr_ax),
 	.addr_from = R_AX_PWR_BY_RATE,
 	.addr_to = R_AX_PWR_BY_RATE_MAX,
 	.addr_to_1ss = R_AX_PWR_BY_RATE_1SS_MAX,
 };
 
-static const struct txpwr_ent __txpwr_ent_lmt[] = {
+static const struct txpwr_ent __txpwr_ent_lmt_ax[] = {
 	/* 1TX */
 	__GEN_TXPWR_ENT2("CCK_1TX_20M    ", "NON_BF", "BF"),
 	__GEN_TXPWR_ENT2("CCK_1TX_40M    ", "NON_BF", "BF"),
@@ -462,18 +462,18 @@ static const struct txpwr_ent __txpwr_ent_lmt[] = {
 	__GEN_TXPWR_ENT2("MCS_2TX_40M_2p5", "NON_BF", "BF"),
 };
 
-static_assert((ARRAY_SIZE(__txpwr_ent_lmt) * 2) ==
+static_assert((ARRAY_SIZE(__txpwr_ent_lmt_ax) * 2) ==
 	(R_AX_PWR_LMT_MAX - R_AX_PWR_LMT + 4));
 
-static const struct txpwr_map __txpwr_map_lmt = {
-	.ent = __txpwr_ent_lmt,
-	.size = ARRAY_SIZE(__txpwr_ent_lmt),
+static const struct txpwr_map __txpwr_map_lmt_ax = {
+	.ent = __txpwr_ent_lmt_ax,
+	.size = ARRAY_SIZE(__txpwr_ent_lmt_ax),
 	.addr_from = R_AX_PWR_LMT,
 	.addr_to = R_AX_PWR_LMT_MAX,
 	.addr_to_1ss = R_AX_PWR_LMT_1SS_MAX,
 };
 
-static const struct txpwr_ent __txpwr_ent_lmt_ru[] = {
+static const struct txpwr_ent __txpwr_ent_lmt_ru_ax[] = {
 	/* 1TX */
 	__GEN_TXPWR_ENT8("1TX", "RU26__0", "RU26__1", "RU26__2", "RU26__3",
 			 "RU26__4", "RU26__5", "RU26__6", "RU26__7"),
@@ -490,12 +490,12 @@ static const struct txpwr_ent __txpwr_ent_lmt_ru[] = {
 			 "RU106_4", "RU106_5", "RU106_6", "RU106_7"),
 };
 
-static_assert((ARRAY_SIZE(__txpwr_ent_lmt_ru) * 8) ==
+static_assert((ARRAY_SIZE(__txpwr_ent_lmt_ru_ax) * 8) ==
 	(R_AX_PWR_RU_LMT_MAX - R_AX_PWR_RU_LMT + 4));
 
-static const struct txpwr_map __txpwr_map_lmt_ru = {
-	.ent = __txpwr_ent_lmt_ru,
-	.size = ARRAY_SIZE(__txpwr_ent_lmt_ru),
+static const struct txpwr_map __txpwr_map_lmt_ru_ax = {
+	.ent = __txpwr_ent_lmt_ru_ax,
+	.size = ARRAY_SIZE(__txpwr_ent_lmt_ru_ax),
 	.addr_from = R_AX_PWR_RU_LMT,
 	.addr_to = R_AX_PWR_RU_LMT_MAX,
 	.addr_to_1ss = R_AX_PWR_RU_LMT_1SS_MAX,
@@ -600,10 +600,28 @@ static void __print_regd(struct seq_file *m, struct rtw89_dev *rtwdev,
 
 #undef case_REGD
 
+struct dbgfs_txpwr_table {
+	const struct txpwr_map *byr;
+	const struct txpwr_map *lmt;
+	const struct txpwr_map *lmt_ru;
+};
+
+static const struct dbgfs_txpwr_table dbgfs_txpwr_table_ax = {
+	.byr = &__txpwr_map_byr_ax,
+	.lmt = &__txpwr_map_lmt_ax,
+	.lmt_ru = &__txpwr_map_lmt_ru_ax,
+};
+
+static const struct dbgfs_txpwr_table *dbgfs_txpwr_tables[RTW89_CHIP_GEN_NUM] = {
+	[RTW89_CHIP_AX] = &dbgfs_txpwr_table_ax,
+};
+
 static int rtw89_debug_priv_txpwr_table_get(struct seq_file *m, void *v)
 {
 	struct rtw89_debugfs_priv *debugfs_priv = m->private;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	enum rtw89_chip_gen chip_gen = rtwdev->chip->chip_gen;
+	const struct dbgfs_txpwr_table *tbl;
 	const struct rtw89_chan *chan;
 	int ret = 0;
 
@@ -620,18 +638,24 @@ static int rtw89_debug_priv_txpwr_table_get(struct seq_file *m, void *v)
 	seq_puts(m, "[TAS]\n");
 	rtw89_print_tas(m, rtwdev);
 
+	tbl = dbgfs_txpwr_tables[chip_gen];
+	if (!tbl) {
+		ret = -EOPNOTSUPP;
+		goto err;
+	}
+
 	seq_puts(m, "\n[TX power byrate]\n");
-	ret = __print_txpwr_map(m, rtwdev, &__txpwr_map_byr);
+	ret = __print_txpwr_map(m, rtwdev, tbl->byr);
 	if (ret)
 		goto err;
 
 	seq_puts(m, "\n[TX power limit]\n");
-	ret = __print_txpwr_map(m, rtwdev, &__txpwr_map_lmt);
+	ret = __print_txpwr_map(m, rtwdev, tbl->lmt);
 	if (ret)
 		goto err;
 
 	seq_puts(m, "\n[TX power limit_ru]\n");
-	ret = __print_txpwr_map(m, rtwdev, &__txpwr_map_lmt_ru);
+	ret = __print_txpwr_map(m, rtwdev, tbl->lmt_ru);
 	if (ret)
 		goto err;
 
-- 
2.25.1

