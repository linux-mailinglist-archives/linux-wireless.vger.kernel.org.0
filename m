Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A4D582080
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jul 2022 08:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiG0GxP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jul 2022 02:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiG0GxO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jul 2022 02:53:14 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89C4FFD
        for <linux-wireless@vger.kernel.org>; Tue, 26 Jul 2022 23:53:10 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 26R6qmm37001927, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 26R6qmm37001927
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 27 Jul 2022 14:52:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 14:52:55 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Wed, 27 Jul
 2022 14:52:54 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] rtw88: access chip_info by const pointer
Date:   Wed, 27 Jul 2022 14:52:32 +0800
Message-ID: <20220727065232.28510-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/27/2022 06:38:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzcvMjcgpFekyCAwMToxNDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since chip_info has became const table, we must access them via const
pointer to avoid invalid writing.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
Dependency of this patch is "rtw88: use const pointer of chip_info and fix hw_scan misbehavior".
---
 drivers/net/wireless/realtek/rtw88/bf.c       |  2 +-
 drivers/net/wireless/realtek/rtw88/coex.c     | 88 +++++++++----------
 drivers/net/wireless/realtek/rtw88/coex.h     | 14 +--
 drivers/net/wireless/realtek/rtw88/efuse.c    |  4 +-
 drivers/net/wireless/realtek/rtw88/fw.c       | 20 ++---
 drivers/net/wireless/realtek/rtw88/mac.c      | 18 ++--
 drivers/net/wireless/realtek/rtw88/mac80211.c |  4 +-
 drivers/net/wireless/realtek/rtw88/main.c     | 28 +++---
 drivers/net/wireless/realtek/rtw88/main.h     |  2 +-
 drivers/net/wireless/realtek/rtw88/pci.c      | 20 ++---
 drivers/net/wireless/realtek/rtw88/phy.c      | 44 +++++-----
 drivers/net/wireless/realtek/rtw88/phy.h      |  2 +-
 drivers/net/wireless/realtek/rtw88/tx.c       |  8 +-
 drivers/net/wireless/realtek/rtw88/util.c     |  4 +-
 14 files changed, 129 insertions(+), 129 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/bf.c b/drivers/net/wireless/realtek/rtw88/bf.c
index 76c7f3257dd36..038a30b170eff 100644
--- a/drivers/net/wireless/realtek/rtw88/bf.c
+++ b/drivers/net/wireless/realtek/rtw88/bf.c
@@ -30,11 +30,11 @@ void rtw_bf_disassoc(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 void rtw_bf_assoc(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 		  struct ieee80211_bss_conf *bss_conf)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct ieee80211_hw *hw = rtwdev->hw;
 	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
 	struct rtw_bfee *bfee = &rtwvif->bfee;
 	struct rtw_bf_info *bfinfo = &rtwdev->bf_info;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	struct ieee80211_sta *sta;
 	struct ieee80211_sta_vht_cap *vht_cap;
 	struct ieee80211_sta_vht_cap *ic_vht_cap;
diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index cac053f485c3b..6276ad6242991 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -13,7 +13,7 @@
 static u8 rtw_coex_next_rssi_state(struct rtw_dev *rtwdev, u8 pre_state,
 				   u8 rssi, u8 rssi_thresh)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	u8 tol = chip->rssi_tolerance;
 	u8 next_state;
 
@@ -36,7 +36,7 @@ static u8 rtw_coex_next_rssi_state(struct rtw_dev *rtwdev, u8 pre_state,
 static void rtw_coex_limited_tx(struct rtw_dev *rtwdev,
 				bool tx_limit_en, bool ampdu_limit_en)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	u8 num_of_active_port = 1;
@@ -365,7 +365,7 @@ static void rtw_coex_set_wl_pri_mask(struct rtw_dev *rtwdev, u8 bitmap,
 
 void rtw_coex_write_scbd(struct rtw_dev *rtwdev, u16 bitpos, bool set)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	u16 val = 0x2;
@@ -400,7 +400,7 @@ EXPORT_SYMBOL(rtw_coex_write_scbd);
 
 static u16 rtw_coex_read_scbd(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 
 	if (!chip->scbd_support)
 		return 0;
@@ -410,7 +410,7 @@ static u16 rtw_coex_read_scbd(struct rtw_dev *rtwdev)
 
 static void rtw_coex_check_rfk(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_coex_rfe *coex_rfe = &coex->rfe;
@@ -489,7 +489,7 @@ static void rtw_coex_monitor_bt_ctr(struct rtw_dev *rtwdev)
 
 static void rtw_coex_monitor_bt_enable(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_coex_dm *coex_dm = &coex->dm;
@@ -524,10 +524,10 @@ static void rtw_coex_monitor_bt_enable(struct rtw_dev *rtwdev)
 
 static void rtw_coex_update_wl_link_info(struct rtw_dev *rtwdev, u8 reason)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_coex_dm *coex_dm = &coex->dm;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_traffic_stats *stats = &rtwdev->stats;
 	bool is_5G = false;
 	bool wl_busy = false;
@@ -706,10 +706,10 @@ static const char *rtw_coex_get_bt_status_string(u8 bt_status)
 
 static void rtw_coex_update_bt_link_info(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_coex_dm *coex_dm = &coex->dm;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 i;
 	u8 rssi_state;
 	u8 rssi_step;
@@ -806,7 +806,7 @@ static void rtw_coex_update_bt_link_info(struct rtw_dev *rtwdev)
 
 static void rtw_coex_update_wl_ch_info(struct rtw_dev *rtwdev, u8 type)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	struct rtw_coex_dm *coex_dm = &rtwdev->coex.dm;
 	struct rtw_coex_stat *coex_stat = &rtwdev->coex.stat;
@@ -933,7 +933,7 @@ EXPORT_SYMBOL(rtw_coex_write_indirect_reg);
 
 static void rtw_coex_coex_ctrl_owner(struct rtw_dev *rtwdev, bool wifi_control)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	const struct rtw_hw_reg *btg_reg = chip->btg_reg;
 
 	if (wifi_control) {
@@ -981,7 +981,7 @@ static void rtw_coex_mimo_ps(struct rtw_dev *rtwdev, bool force, bool state)
 static void rtw_btc_wltoggle_table_a(struct rtw_dev *rtwdev, bool force,
 				     u8 table_case)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	u8 h2c_para[6] = {0};
 	u32 table_wl = 0x5a5a5a5a;
@@ -1065,9 +1065,9 @@ static void rtw_coex_set_table(struct rtw_dev *rtwdev, bool force, u32 table0,
 
 static void rtw_coex_table(struct rtw_dev *rtwdev, bool force, u8 type)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_dm *coex_dm = &coex->dm;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 
@@ -1135,9 +1135,9 @@ static void rtw_coex_power_save_state(struct rtw_dev *rtwdev, u8 ps_type,
 static void rtw_coex_set_tdma(struct rtw_dev *rtwdev, u8 byte1, u8 byte2,
 			      u8 byte3, u8 byte4, u8 byte5)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_dm *coex_dm = &coex->dm;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	u8 ps_type = COEX_PS_WIFI_NATIVE;
 	bool ap_enable = false;
@@ -1193,10 +1193,10 @@ static void rtw_coex_set_tdma(struct rtw_dev *rtwdev, u8 byte1, u8 byte2,
 
 static void rtw_coex_tdma(struct rtw_dev *rtwdev, bool force, u32 tcase)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_dm *coex_dm = &coex->dm;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	u8 n, type;
 	bool turn_on;
@@ -1526,8 +1526,8 @@ static u8 rtw_coex_algorithm(struct rtw_dev *rtwdev)
 
 static void rtw_coex_action_coex_all_off(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
@@ -1549,11 +1549,11 @@ static void rtw_coex_action_coex_all_off(struct rtw_dev *rtwdev)
 
 static void rtw_coex_action_freerun(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_coex_dm *coex_dm = &coex->dm;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 level = 0;
 	bool bt_afh_loss = true;
 
@@ -1594,8 +1594,8 @@ static void rtw_coex_action_freerun(struct rtw_dev *rtwdev)
 
 static void rtw_coex_action_rf4ce(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
@@ -1619,8 +1619,8 @@ static void rtw_coex_action_rf4ce(struct rtw_dev *rtwdev)
 
 static void rtw_coex_action_bt_whql_test(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
@@ -1644,10 +1644,10 @@ static void rtw_coex_action_bt_whql_test(struct rtw_dev *rtwdev)
 
 static void rtw_coex_action_bt_relink(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 	u32 slot_type = 0;
 
@@ -1684,11 +1684,11 @@ static void rtw_coex_action_bt_relink(struct rtw_dev *rtwdev)
 
 static void rtw_coex_action_bt_idle(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_coex_dm *coex_dm = &coex->dm;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex_rfe *coex_rfe = &coex->rfe;
 	u8 table_case = 0xff, tdma_case = 0xff;
 
@@ -1753,10 +1753,10 @@ static void rtw_coex_action_bt_idle(struct rtw_dev *rtwdev)
 
 static void rtw_coex_action_bt_inquiry(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	bool wl_hi_pri = false;
 	u8 table_case, tdma_case;
 	u32 slot_type = 0;
@@ -1853,11 +1853,11 @@ static void rtw_coex_action_bt_inquiry(struct rtw_dev *rtwdev)
 
 static void rtw_coex_action_bt_game_hid(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	struct rtw_coex_dm *coex_dm = &coex->dm;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
@@ -1901,10 +1901,10 @@ static void rtw_coex_action_bt_game_hid(struct rtw_dev *rtwdev)
 
 static void rtw_coex_action_bt_hfp(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
@@ -1932,10 +1932,10 @@ static void rtw_coex_action_bt_hfp(struct rtw_dev *rtwdev)
 
 static void rtw_coex_action_bt_hid(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 	u32 slot_type = 0;
 	bool bt_multi_link_remain = false, is_toggle_table = false;
@@ -2015,11 +2015,11 @@ static void rtw_coex_action_bt_hid(struct rtw_dev *rtwdev)
 
 static void rtw_coex_action_bt_a2dp(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_coex_dm *coex_dm = &coex->dm;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 	u32 slot_type = 0;
 
@@ -2057,10 +2057,10 @@ static void rtw_coex_action_bt_a2dp(struct rtw_dev *rtwdev)
 
 static void rtw_coex_action_bt_a2dpsink(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 	bool ap_enable = false;
 
@@ -2096,10 +2096,10 @@ static void rtw_coex_action_bt_a2dpsink(struct rtw_dev *rtwdev)
 
 static void rtw_coex_action_bt_pan(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
@@ -2133,11 +2133,11 @@ static void rtw_coex_action_bt_pan(struct rtw_dev *rtwdev)
 
 static void rtw_coex_action_bt_a2dp_hid(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_coex_dm *coex_dm = &coex->dm;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case, interval = 0;
 	u32 slot_type = 0;
 	bool is_toggle_table = false;
@@ -2190,10 +2190,10 @@ static void rtw_coex_action_bt_a2dp_hid(struct rtw_dev *rtwdev)
 
 static void rtw_coex_action_bt_a2dp_pan(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 	bool wl_cpt_test = false, bt_cpt_test = false;
 
@@ -2247,10 +2247,10 @@ static void rtw_coex_action_bt_a2dp_pan(struct rtw_dev *rtwdev)
 
 static void rtw_coex_action_bt_pan_hid(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
@@ -2282,10 +2282,10 @@ static void rtw_coex_action_bt_pan_hid(struct rtw_dev *rtwdev)
 
 static void rtw_coex_action_bt_a2dp_pan_hid(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
@@ -2316,9 +2316,9 @@ static void rtw_coex_action_bt_a2dp_pan_hid(struct rtw_dev *rtwdev)
 
 static void rtw_coex_action_wl_under5g(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	u8 table_case, tdma_case;
 
@@ -2348,8 +2348,8 @@ static void rtw_coex_action_wl_under5g(struct rtw_dev *rtwdev)
 
 static void rtw_coex_action_wl_only(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
@@ -2372,9 +2372,9 @@ static void rtw_coex_action_wl_only(struct rtw_dev *rtwdev)
 
 static void rtw_coex_action_wl_native_lps(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	u8 table_case, tdma_case;
 
@@ -2411,10 +2411,10 @@ static void rtw_coex_action_wl_native_lps(struct rtw_dev *rtwdev)
 
 static void rtw_coex_action_wl_linkscan(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 	u32 slot_type = 0;
 
@@ -2451,8 +2451,8 @@ static void rtw_coex_action_wl_linkscan(struct rtw_dev *rtwdev)
 
 static void rtw_coex_action_wl_not_connected(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
@@ -2528,8 +2528,8 @@ static void rtw_coex_action_wl_connected(struct rtw_dev *rtwdev)
 
 static void rtw_coex_run_coex(struct rtw_dev *rtwdev, u8 reason)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex_dm *coex_dm = &coex->dm;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	bool rf4ce_en = false;
@@ -3002,9 +3002,9 @@ void rtw_coex_media_status_notify(struct rtw_dev *rtwdev, u8 type)
 
 void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex_dm *coex_dm = &coex->dm;
 	u32 bt_relink_time;
 	u8 i, rsp_source = 0, type;
@@ -3270,8 +3270,8 @@ static const u8 coex_bt_hidinfo_xb[] = {0x58, 0x62, 0x6f};
 
 void rtw_coex_bt_hid_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_coex_hid *hidinfo;
 	struct rtw_coex_hid_info_a *hida;
@@ -3360,8 +3360,8 @@ void rtw_coex_bt_hid_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 
 void rtw_coex_query_bt_hid_list(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_coex_hid *hidinfo;
 	u8 i, handle;
@@ -3582,7 +3582,7 @@ static const char *rtw_coex_get_reason_string(u8 reason)
 static u8 rtw_coex_get_table_index(struct rtw_dev *rtwdev, u32 wl_reg_6c0,
 				   u32 wl_reg_6c4)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	u8 ans = 0xFF;
 	u8 n, i;
@@ -3618,8 +3618,8 @@ static u8 rtw_coex_get_table_index(struct rtw_dev *rtwdev, u32 wl_reg_6c0,
 
 static u8 rtw_coex_get_tdma_index(struct rtw_dev *rtwdev, u8 *tdma_para)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 ans = 0xFF;
 	u8 n, i, j;
 	u8 load_cur_tab_val;
@@ -3736,7 +3736,7 @@ static int rtw_coex_val_info(struct rtw_dev *rtwdev,
 
 static void rtw_coex_set_coexinfo_hw(struct rtw_dev *rtwdev, struct seq_file *m)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	const struct rtw_reg_domain *reg;
 	char addr_info[INFO_SIZE];
 	int n_addr = 0;
@@ -3910,7 +3910,7 @@ static const char *rtw_coex_get_wl_coex_mode(u8 coex_wl_link_mode)
 
 void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
diff --git a/drivers/net/wireless/realtek/rtw88/coex.h b/drivers/net/wireless/realtek/rtw88/coex.h
index 07fa7aa34d4ba..57cf29da9ea4e 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.h
+++ b/drivers/net/wireless/realtek/rtw88/coex.h
@@ -327,7 +327,7 @@ struct coex_rf_para {
 
 static inline void rtw_coex_set_init(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 
 	chip->ops->coex_set_init(rtwdev);
 }
@@ -335,7 +335,7 @@ static inline void rtw_coex_set_init(struct rtw_dev *rtwdev)
 static inline
 void rtw_coex_set_ant_switch(struct rtw_dev *rtwdev, u8 ctrl_type, u8 pos_type)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 
 	if (!chip->ops->coex_set_ant_switch)
 		return;
@@ -345,28 +345,28 @@ void rtw_coex_set_ant_switch(struct rtw_dev *rtwdev, u8 ctrl_type, u8 pos_type)
 
 static inline void rtw_coex_set_gnt_fix(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 
 	chip->ops->coex_set_gnt_fix(rtwdev);
 }
 
 static inline void rtw_coex_set_gnt_debug(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 
 	chip->ops->coex_set_gnt_debug(rtwdev);
 }
 
 static inline  void rtw_coex_set_rfe_type(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 
 	chip->ops->coex_set_rfe_type(rtwdev);
 }
 
 static inline void rtw_coex_set_wl_tx_power(struct rtw_dev *rtwdev, u8 wl_pwr)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 
 	chip->ops->coex_set_wl_tx_power(rtwdev, wl_pwr);
 }
@@ -374,7 +374,7 @@ static inline void rtw_coex_set_wl_tx_power(struct rtw_dev *rtwdev, u8 wl_pwr)
 static inline
 void rtw_coex_set_wl_rx_gain(struct rtw_dev *rtwdev, bool low_gain)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 
 	chip->ops->coex_set_wl_rx_gain(rtwdev, low_gain);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/efuse.c b/drivers/net/wireless/realtek/rtw88/efuse.c
index c266c84ef2337..b85075cd68d0a 100644
--- a/drivers/net/wireless/realtek/rtw88/efuse.c
+++ b/drivers/net/wireless/realtek/rtw88/efuse.c
@@ -86,7 +86,7 @@ static int rtw_dump_logical_efuse_map(struct rtw_dev *rtwdev, u8 *phy_map,
 
 static int rtw_dump_physical_efuse_map(struct rtw_dev *rtwdev, u8 *map)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	u32 size = rtwdev->efuse.physical_size;
 	u32 efuse_ctl;
 	u32 addr;
@@ -145,7 +145,7 @@ EXPORT_SYMBOL(rtw_read8_physical_efuse);
 
 int rtw_parse_efuse_map(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	u32 phy_size = efuse->physical_size;
 	u32 log_size = efuse->logical_size;
diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 5ad94022437ba..c08220ae65fe1 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -904,7 +904,7 @@ void rtw_send_rsvd_page_h2c(struct rtw_dev *rtwdev)
 static struct sk_buff *rtw_nlo_info_get(struct ieee80211_hw *hw)
 {
 	struct rtw_dev *rtwdev = hw->priv;
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_pno_request *pno_req = &rtwdev->wow.pno_req;
 	struct rtw_nlo_info_hdr *nlo_hdr;
 	struct cfg80211_ssid *ssid;
@@ -959,7 +959,7 @@ static struct sk_buff *rtw_nlo_info_get(struct ieee80211_hw *hw)
 static struct sk_buff *rtw_cs_channel_info_get(struct ieee80211_hw *hw)
 {
 	struct rtw_dev *rtwdev = hw->priv;
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_pno_request *pno_req = &rtwdev->wow.pno_req;
 	struct ieee80211_channel *channels = pno_req->channels;
 	struct sk_buff *skb;
@@ -993,7 +993,7 @@ static struct sk_buff *rtw_cs_channel_info_get(struct ieee80211_hw *hw)
 static struct sk_buff *rtw_lps_pg_dpk_get(struct ieee80211_hw *hw)
 {
 	struct rtw_dev *rtwdev = hw->priv;
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_dpk_info *dpk_info = &rtwdev->dm_info.dpk_info;
 	struct rtw_lps_pg_dpk_hdr *dpk_hdr;
 	struct sk_buff *skb;
@@ -1018,7 +1018,7 @@ static struct sk_buff *rtw_lps_pg_dpk_get(struct ieee80211_hw *hw)
 static struct sk_buff *rtw_lps_pg_info_get(struct ieee80211_hw *hw)
 {
 	struct rtw_dev *rtwdev = hw->priv;
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_lps_conf *conf = &rtwdev->lps_conf;
 	struct rtw_lps_pg_info_hdr *pg_info_hdr;
 	struct rtw_wow_param *rtw_wow = &rtwdev->wow;
@@ -1122,7 +1122,7 @@ static void rtw_fill_rsvd_page_desc(struct rtw_dev *rtwdev, struct sk_buff *skb,
 				    enum rtw_rsvd_packet_type type)
 {
 	struct rtw_tx_pkt_info pkt_info = {0};
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	u8 *pkt_desc;
 
 	rtw_tx_rsvd_page_pkt_info_update(rtwdev, &pkt_info, skb, type);
@@ -1433,7 +1433,7 @@ static int  __rtw_build_rsvd_page_from_vifs(struct rtw_dev *rtwdev)
 static u8 *rtw_build_rsvd_page(struct rtw_dev *rtwdev, u32 *size)
 {
 	struct ieee80211_hw *hw = rtwdev->hw;
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct sk_buff *iter;
 	struct rtw_rsvd_page *rsvd_pkt;
 	u32 page = 0;
@@ -1647,7 +1647,7 @@ static void rtw_fw_read_fifo_page(struct rtw_dev *rtwdev, u32 offset, u32 size,
 static void rtw_fw_read_fifo(struct rtw_dev *rtwdev, enum rtw_fw_fifo_sel sel,
 			     u32 offset, u32 size, u32 *buf)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	u32 start_pg, residue;
 
 	if (sel >= RTW_FW_FIFO_MAX) {
@@ -1706,7 +1706,7 @@ int rtw_fw_dump_fifo(struct rtw_dev *rtwdev, u8 fifo_sel, u32 addr, u32 size,
 static void __rtw_fw_update_pkt(struct rtw_dev *rtwdev, u8 pkt_id, u16 size,
 				u8 location)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
 	u16 total_size = H2C_PKT_HDR_SIZE + H2C_PKT_UPDATE_PKT_LEN;
 
@@ -1818,8 +1818,8 @@ static int rtw_append_probe_req_ie(struct rtw_dev *rtwdev, struct sk_buff *skb,
 				   struct sk_buff_head *list, u8 *bands,
 				   struct rtw_vif *rtwvif)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct ieee80211_scan_ies *ies = rtwvif->scan_ies;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	struct sk_buff *new;
 	u8 idx;
 
@@ -1841,7 +1841,7 @@ static int rtw_append_probe_req_ie(struct rtw_dev *rtwdev, struct sk_buff *skb,
 static int _rtw_hw_scan_update_probe_req(struct rtw_dev *rtwdev, u8 num_probes,
 					 struct sk_buff_head *probe_req_list)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct sk_buff *skb, *tmp;
 	u8 page_offset = 1, *buf, page_size = chip->page_size;
 	u16 pg_addr = rtwdev->fifo.rsvd_h2c_info_addr, loc;
diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index caf2603da2d65..52076e89d59a3 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -243,7 +243,7 @@ static int rtw_pwr_seq_parser(struct rtw_dev *rtwdev,
 
 static int rtw_mac_power_switch(struct rtw_dev *rtwdev, bool pwr_on)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	const struct rtw_pwr_seq_cmd **pwr_seq;
 	u8 rpwm;
 	bool cur_pwr;
@@ -587,7 +587,7 @@ static int
 download_firmware_to_mem(struct rtw_dev *rtwdev, const u8 *data,
 			 u32 src, u32 dst, u32 size)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	u32 desc_size = chip->tx_pkt_desc_sz;
 	u8 first_part;
 	u32 mem_offset;
@@ -934,7 +934,7 @@ static u32 get_priority_queues(struct rtw_dev *rtwdev, u32 queues)
 static void __rtw_mac_flush_prio_queue(struct rtw_dev *rtwdev,
 				       u32 prio_queue, bool drop)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	const struct rtw_prioq_addr *addr;
 	bool wsize;
 	u16 avail_page, rsvd_page;
@@ -996,7 +996,7 @@ void rtw_mac_flush_queues(struct rtw_dev *rtwdev, u32 queues, bool drop)
 
 static int txdma_queue_mapping(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	const struct rtw_rqpn *rqpn = NULL;
 	u16 txdma_pq_map = 0;
 
@@ -1037,8 +1037,8 @@ static int txdma_queue_mapping(struct rtw_dev *rtwdev)
 
 static int set_trx_fifo_info(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_fifo_conf *fifo = &rtwdev->fifo;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	u16 cur_pg_addr;
 	u8 csi_buf_pg_num = chip->csi_buf_pg_num;
 
@@ -1092,8 +1092,8 @@ static int __priority_queue_cfg(struct rtw_dev *rtwdev,
 				const struct rtw_page_table *pg_tbl,
 				u16 pubq_num)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_fifo_conf *fifo = &rtwdev->fifo;
-	struct rtw_chip_info *chip = rtwdev->chip;
 
 	rtw_write16(rtwdev, REG_FIFOPAGE_INFO_1, pg_tbl->hq_num);
 	rtw_write16(rtwdev, REG_FIFOPAGE_INFO_2, pg_tbl->lq_num);
@@ -1123,8 +1123,8 @@ static int __priority_queue_cfg_legacy(struct rtw_dev *rtwdev,
 				       const struct rtw_page_table *pg_tbl,
 				       u16 pubq_num)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_fifo_conf *fifo = &rtwdev->fifo;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	u32 val32;
 
 	val32 = BIT_RQPN_NE(pg_tbl->nq_num, pg_tbl->exq_num);
@@ -1149,8 +1149,8 @@ static int __priority_queue_cfg_legacy(struct rtw_dev *rtwdev,
 
 static int priority_queue_cfg(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_fifo_conf *fifo = &rtwdev->fifo;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	const struct rtw_page_table *pg_tbl = NULL;
 	u16 pubq_num;
 	int ret;
@@ -1277,7 +1277,7 @@ static int rtw_drv_info_cfg(struct rtw_dev *rtwdev)
 
 int rtw_mac_init(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	int ret;
 
 	ret = rtw_init_trx_cfg(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index a582758b76c42..b6af199ae5e11 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -437,7 +437,7 @@ static int rtw_ops_start_ap(struct ieee80211_hw *hw,
 			    struct ieee80211_bss_conf *link_conf)
 {
 	struct rtw_dev *rtwdev = hw->priv;
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 
 	mutex_lock(&rtwdev->mutex);
 	chip->ops->phy_calibration(rtwdev);
@@ -755,7 +755,7 @@ static int rtw_ops_set_antenna(struct ieee80211_hw *hw,
 			       u32 rx_antenna)
 {
 	struct rtw_dev *rtwdev = hw->priv;
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	int ret;
 
 	if (!chip->ops->set_antenna)
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 7e4c63cc3fff8..48e0323569f64 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -353,7 +353,7 @@ struct rtw_fwcd_hdr {
 
 static int rtw_fwcd_prep(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_fwcd_desc *desc = &rtwdev->fw.fwcd_desc;
 	const struct rtw_fwcd_segs *segs = chip->fwcd_segs;
 	u32 prep_size = chip->fw_rxff_size + sizeof(struct rtw_fwcd_hdr);
@@ -756,9 +756,9 @@ void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 
 void rtw_set_channel(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct ieee80211_hw *hw = rtwdev->hw;
 	struct rtw_hal *hal = &rtwdev->hal;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_channel_params ch_param;
 	u8 center_chan, bandwidth, primary_chan_idx;
 	u8 i;
@@ -821,7 +821,7 @@ void rtw_set_channel(struct rtw_dev *rtwdev)
 
 void rtw_chip_prepare_tx(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 
 	if (rtwdev->need_rfk) {
 		rtwdev->need_rfk = false;
@@ -890,8 +890,8 @@ static u8 hw_bw_cap_to_bitamp(u8 bw_cap)
 
 static void rtw_hw_config_rf_ant_num(struct rtw_dev *rtwdev, u8 hw_ant_num)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_hal *hal = &rtwdev->hal;
-	struct rtw_chip_info *chip = rtwdev->chip;
 
 	if (hw_ant_num == EFUSE_HW_CAP_IGNORE ||
 	    hw_ant_num >= hal->rf_path_num)
@@ -1240,7 +1240,7 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
 
 static int rtw_wait_firmware_completion(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_fw_state *fw;
 
 	fw = &rtwdev->fw;
@@ -1261,7 +1261,7 @@ static int rtw_wait_firmware_completion(struct rtw_dev *rtwdev)
 static enum rtw_lps_deep_mode rtw_update_lps_deep_mode(struct rtw_dev *rtwdev,
 						       struct rtw_fw_state *fw)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 
 	if (rtw_disable_lps_deep_mode || !chip->lps_deep_mode_supported ||
 	    !fw->feature)
@@ -1280,7 +1280,7 @@ static enum rtw_lps_deep_mode rtw_update_lps_deep_mode(struct rtw_dev *rtwdev,
 
 static int rtw_power_on(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_fw_state *fw = &rtwdev->fw;
 	bool wifi_only;
 	int ret;
@@ -1469,8 +1469,8 @@ void rtw_core_stop(struct rtw_dev *rtwdev)
 static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
 			    struct ieee80211_sta_ht_cap *ht_cap)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_chip_info *chip = rtwdev->chip;
 
 	ht_cap->ht_supported = true;
 	ht_cap->cap = 0;
@@ -1568,7 +1568,7 @@ static u16 rtw_get_max_scan_ie_len(struct rtw_dev *rtwdev)
 }
 
 static void rtw_set_supported_band(struct ieee80211_hw *hw,
-				   struct rtw_chip_info *chip)
+				   const struct rtw_chip_info *chip)
 {
 	struct rtw_dev *rtwdev = hw->priv;
 	struct ieee80211_supported_band *sband;
@@ -1600,7 +1600,7 @@ static void rtw_set_supported_band(struct ieee80211_hw *hw,
 }
 
 static void rtw_unset_supported_band(struct ieee80211_hw *hw,
-				     struct rtw_chip_info *chip)
+				     const struct rtw_chip_info *chip)
 {
 	kfree(hw->wiphy->bands[NL80211_BAND_2GHZ]);
 	kfree(hw->wiphy->bands[NL80211_BAND_5GHZ]);
@@ -1622,7 +1622,7 @@ static void rtw_vif_smps_iter(void *data, u8 *mac,
 
 void rtw_set_txrx_1ss(struct rtw_dev *rtwdev, bool txrx_1ss)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_hal *hal = &rtwdev->hal;
 
 	if (!chip->ops->config_txrx_mode || rtwdev->hal.txrx_1ss == txrx_1ss)
@@ -1743,7 +1743,7 @@ static int rtw_load_firmware(struct rtw_dev *rtwdev, enum rtw_fw_type type)
 
 static int rtw_chip_parameter_setup(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_hal *hal = &rtwdev->hal;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 
@@ -2001,7 +2001,7 @@ static void rtw_stats_init(struct rtw_dev *rtwdev)
 
 int rtw_core_init(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	int ret;
 
@@ -2195,7 +2195,7 @@ EXPORT_SYMBOL(rtw_register_hw);
 
 void rtw_unregister_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 
 	ieee80211_unregister_hw(hw);
 	rtw_unset_supported_band(hw, chip);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 69d0a700c2ae9..b3a7969b2b81c 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1980,7 +1980,7 @@ struct rtw_dev {
 	struct rtw_hci hci;
 
 	struct rtw_hw_scan_info scan_info;
-	struct rtw_chip_info *chip;
+	const struct rtw_chip_info *chip;
 	struct rtw_hal hal;
 	struct rtw_fifo_conf fifo;
 	struct rtw_fw_state fw;
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 24d5695363d3f..7abb1e22b7083 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -322,7 +322,7 @@ static int rtw_pci_init_trx_ring(struct rtw_dev *rtwdev)
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
 	struct rtw_pci_tx_ring *tx_ring;
 	struct rtw_pci_rx_ring *rx_ring;
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	int i = 0, j = 0, tx_alloced = 0, rx_alloced = 0;
 	int tx_desc_size, rx_desc_size;
 	u32 len;
@@ -721,7 +721,7 @@ static void rtw_pci_dma_check(struct rtw_dev *rtwdev,
 			      u32 idx)
 {
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_pci_rx_buffer_desc *buf_desc;
 	u32 desc_sz = chip->rx_buf_desc_sz;
 	u16 total_pkt_size;
@@ -834,7 +834,7 @@ static int rtw_pci_tx_write_data(struct rtw_dev *rtwdev,
 				 struct sk_buff *skb, u8 queue)
 {
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_pci_tx_ring *ring;
 	struct rtw_pci_tx_data *tx_data;
 	dma_addr_t dma;
@@ -1073,7 +1073,7 @@ static int rtw_pci_get_hw_rx_ring_nr(struct rtw_dev *rtwdev,
 static u32 rtw_pci_rx_napi(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
 			   u8 hw_queue, u32 limit)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct napi_struct *napi = &rtwpci->napi;
 	struct rtw_pci_rx_ring *ring = &rtwpci->rx_rings[RTW_RX_QUEUE_MPDU];
 	struct rtw_rx_pkt_stat pkt_stat;
@@ -1425,7 +1425,7 @@ static void rtw_pci_link_ps(struct rtw_dev *rtwdev, bool enter)
 
 static void rtw_pci_link_cfg(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
 	struct pci_dev *pdev = rtwpci->pdev;
 	u16 link_ctrl;
@@ -1467,7 +1467,7 @@ static void rtw_pci_link_cfg(struct rtw_dev *rtwdev)
 
 static void rtw_pci_interface_cfg(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 
 	switch (chip->id) {
 	case RTW_CHIP_TYPE_8822C:
@@ -1483,7 +1483,7 @@ static void rtw_pci_interface_cfg(struct rtw_dev *rtwdev)
 static void rtw_pci_phy_cfg(struct rtw_dev *rtwdev)
 {
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct pci_dev *pdev = rtwpci->pdev;
 	const struct rtw_intf_phy_para *para;
 	u16 cut;
@@ -1538,7 +1538,7 @@ static int __maybe_unused rtw_pci_suspend(struct device *dev)
 {
 	struct ieee80211_hw *hw = dev_get_drvdata(dev);
 	struct rtw_dev *rtwdev = hw->priv;
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 
 	if (chip->id == RTW_CHIP_TYPE_8822C && efuse->rfe_option == 6)
@@ -1550,7 +1550,7 @@ static int __maybe_unused rtw_pci_resume(struct device *dev)
 {
 	struct ieee80211_hw *hw = dev_get_drvdata(dev);
 	struct rtw_dev *rtwdev = hw->priv;
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 
 	if (chip->id == RTW_CHIP_TYPE_8822C && efuse->rfe_option == 6)
@@ -1848,7 +1848,7 @@ void rtw_pci_shutdown(struct pci_dev *pdev)
 {
 	struct ieee80211_hw *hw = pci_get_drvdata(pdev);
 	struct rtw_dev *rtwdev;
-	struct rtw_chip_info *chip;
+	const struct rtw_chip_info *chip;
 
 	if (!hw)
 		return;
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index da1efec0aa85c..bd7d05e080848 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -138,7 +138,7 @@ EXPORT_SYMBOL(rtw_phy_set_edcca_th);
 
 void rtw_phy_adaptivity_set_mode(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 
 	/* turn off in debugfs for debug usage */
@@ -165,7 +165,7 @@ void rtw_phy_adaptivity_set_mode(struct rtw_dev *rtwdev)
 
 static void rtw_phy_adaptivity_init(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 
 	rtw_phy_adaptivity_set_mode(rtwdev);
 	if (chip->ops->adaptivity_init)
@@ -180,7 +180,7 @@ static void rtw_phy_adaptivity(struct rtw_dev *rtwdev)
 
 static void rtw_phy_cfo_init(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 
 	if (chip->ops->cfo_init)
 		chip->ops->cfo_init(rtwdev);
@@ -199,7 +199,7 @@ static void rtw_phy_tx_path_div_init(struct rtw_dev *rtwdev)
 
 void rtw_phy_init(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 	u32 addr, mask;
 
@@ -226,7 +226,7 @@ EXPORT_SYMBOL(rtw_phy_init);
 
 void rtw_phy_dig_write(struct rtw_dev *rtwdev, u8 igi)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_hal *hal = &rtwdev->hal;
 	u32 addr, mask;
 	u8 path;
@@ -245,7 +245,7 @@ void rtw_phy_dig_write(struct rtw_dev *rtwdev, u8 igi)
 
 static void rtw_phy_stat_false_alarm(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 
 	chip->ops->false_alarm_statistics(rtwdev);
 }
@@ -603,7 +603,7 @@ static void rtw_phy_rrsr_update(struct rtw_dev *rtwdev)
 
 static void rtw_phy_dpk_track(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 
 	if (chip->ops->dpk_track)
 		chip->ops->dpk_track(rtwdev);
@@ -659,7 +659,7 @@ EXPORT_SYMBOL(rtw_phy_parsing_cfo);
 
 static void rtw_phy_cfo_track(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 
 	if (chip->ops->cfo_track)
 		chip->ops->cfo_track(rtwdev);
@@ -720,8 +720,8 @@ static u8 rtw_phy_cck_pd_lv(struct rtw_dev *rtwdev)
 
 static void rtw_phy_cck_pd(struct rtw_dev *rtwdev)
 {
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	u32 cck_fa = dm_info->cck_fa_cnt;
 	u8 level;
 
@@ -895,7 +895,7 @@ u32 rtw_phy_read_rf(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 		    u32 addr, u32 mask)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	const u32 *base_addr = chip->rf_base_addr;
 	u32 val, direct_addr;
 
@@ -918,7 +918,7 @@ u32 rtw_phy_read_rf_sipi(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 			 u32 addr, u32 mask)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	const struct rtw_rf_sipi_addr *rf_sipi_addr;
 	const struct rtw_rf_sipi_addr *rf_sipi_addr_a;
 	u32 val32;
@@ -967,8 +967,8 @@ bool rtw_phy_write_rf_reg_sipi(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 			       u32 addr, u32 mask, u32 data)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
-	struct rtw_chip_info *chip = rtwdev->chip;
-	u32 *sipi_addr = chip->rf_sipi_addr;
+	const struct rtw_chip_info *chip = rtwdev->chip;
+	const u32 *sipi_addr = chip->rf_sipi_addr;
 	u32 data_and_addr;
 	u32 old_data = 0;
 	u32 shift;
@@ -1007,7 +1007,7 @@ bool rtw_phy_write_rf_reg(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 			  u32 addr, u32 mask, u32 data)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	const u32 *base_addr = chip->rf_base_addr;
 	u32 direct_addr;
 
@@ -1742,7 +1742,7 @@ EXPORT_SYMBOL(rtw_phy_cfg_rf);
 
 static void rtw_load_rfk_table(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_dpk_info *dpk_info = &rtwdev->dm_info.dpk_info;
 
 	if (!chip->rfk_init_tbl)
@@ -1761,7 +1761,7 @@ static void rtw_load_rfk_table(struct rtw_dev *rtwdev)
 
 void rtw_phy_load_tables(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	u8 rf_path;
 
 	rtw_load_table(rtwdev, chip->mac_tbl);
@@ -1870,7 +1870,7 @@ static u8 rtw_get_channel_group(u8 channel, u8 rate)
 
 static s8 rtw_phy_get_dis_dpd_by_rate_diff(struct rtw_dev *rtwdev, u16 rate)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	s8 dpd_diff = 0;
 
 	if (!chip->en_dis_dpd)
@@ -1904,7 +1904,7 @@ static u8 rtw_phy_get_2g_tx_power_index(struct rtw_dev *rtwdev,
 					enum rtw_bandwidth bandwidth,
 					u8 rate, u8 group)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	u8 tx_power;
 	bool mcs_rate;
 	bool above_2ss;
@@ -1951,7 +1951,7 @@ static u8 rtw_phy_get_5g_tx_power_index(struct rtw_dev *rtwdev,
 					enum rtw_bandwidth bandwidth,
 					u8 rate, u8 group)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	u8 tx_power;
 	u8 upper, lower;
 	bool mcs_rate;
@@ -2204,7 +2204,7 @@ static void rtw_phy_set_tx_power_level_by_path(struct rtw_dev *rtwdev,
 
 void rtw_phy_set_tx_power_level(struct rtw_dev *rtwdev, u8 channel)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_hal *hal = &rtwdev->hal;
 	u8 path;
 
@@ -2479,7 +2479,7 @@ static void rtw_phy_set_tx_path_by_reg(struct rtw_dev *rtwdev,
 {
 	struct rtw_path_div *path_div = &rtwdev->dm_path_div;
 	enum rtw_bb_path tx_path_sel_cck = tx_path_sel_1ss;
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 
 	if (tx_path_sel_1ss == path_div->current_tx_path)
 		return;
@@ -2534,7 +2534,7 @@ static void rtw_phy_tx_path_diversity_2ss(struct rtw_dev *rtwdev)
 
 void rtw_phy_tx_path_diversity(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 
 	if (!chip->path_div_supported)
 		return;
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index b6c5ae60a4620..ccfcbd3ced03a 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -114,7 +114,7 @@ const struct rtw_table name ## _tbl = {			\
 
 static inline const struct rtw_rfe_def *rtw_get_rfe_def(struct rtw_dev *rtwdev)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	const struct rtw_rfe_def *rfe_def = NULL;
 
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 60d40a5c2c6a4..ab39245e9c2fd 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -384,7 +384,7 @@ void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
 			    struct ieee80211_sta *sta,
 			    struct sk_buff *skb)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct rtw_sta_info *si;
@@ -424,7 +424,7 @@ void rtw_tx_rsvd_page_pkt_info_update(struct rtw_dev *rtwdev,
 				      struct sk_buff *skb,
 				      enum rtw_rsvd_packet_type type)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	bool bmc;
 
@@ -475,7 +475,7 @@ rtw_tx_write_data_rsvd_page_get(struct rtw_dev *rtwdev,
 				struct rtw_tx_pkt_info *pkt_info,
 				u8 *buf, u32 size)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct sk_buff *skb;
 	u32 tx_pkt_desc_sz;
 	u32 length;
@@ -501,7 +501,7 @@ rtw_tx_write_data_h2c_get(struct rtw_dev *rtwdev,
 			  struct rtw_tx_pkt_info *pkt_info,
 			  u8 *buf, u32 size)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct sk_buff *skb;
 	u32 tx_pkt_desc_sz;
 	u32 length;
diff --git a/drivers/net/wireless/realtek/rtw88/util.c b/drivers/net/wireless/realtek/rtw88/util.c
index 2c515af214e76..cdfd66a85075a 100644
--- a/drivers/net/wireless/realtek/rtw88/util.c
+++ b/drivers/net/wireless/realtek/rtw88/util.c
@@ -23,7 +23,7 @@ EXPORT_SYMBOL(check_hw_ready);
 
 bool ltecoex_read_reg(struct rtw_dev *rtwdev, u16 offset, u32 *val)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	const struct rtw_ltecoex_addr *ltecoex = chip->ltecoex_addr;
 
 	if (!check_hw_ready(rtwdev, ltecoex->ctrl, LTECOEX_READY, 1))
@@ -37,7 +37,7 @@ bool ltecoex_read_reg(struct rtw_dev *rtwdev, u16 offset, u32 *val)
 
 bool ltecoex_reg_write(struct rtw_dev *rtwdev, u16 offset, u32 value)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	const struct rtw_ltecoex_addr *ltecoex = chip->ltecoex_addr;
 
 	if (!check_hw_ready(rtwdev, ltecoex->ctrl, LTECOEX_READY, 1))
-- 
2.25.1

