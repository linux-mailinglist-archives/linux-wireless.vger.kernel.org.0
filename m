Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41175F50E0
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 10:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiJEIdP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 04:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiJEIdH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 04:33:07 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 318EA753B9
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 01:32:52 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2958W88E0010386, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2958W88E0010386
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 5 Oct 2022 16:32:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 5 Oct 2022 16:32:35 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 5 Oct 2022
 16:32:27 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <echuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/6] wifi: rtw89: coex: move chip_ops::btc_bt_aci_imp to a generic code
Date:   Wed, 5 Oct 2022 16:32:07 +0800
Message-ID: <20221005083212.45683-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005083212.45683-1-pkshih@realtek.com>
References: <20221005083212.45683-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 10/05/2022 03:37:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzUgpFekyCAwMjo1OTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

From: Ching-Te Ku <ku920601@realtek.com>

This chunk is to set fixed BT LNA2 at level5 when WiFi/BT shared BTG RFC
to improve BT anti-interference ability from adjacent channel. Since all
chips use the same setting, remove chip_ops::btc_bt_aci_imp.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c     |  9 +++++++--
 drivers/net/wireless/realtek/rtw89/core.h     |  1 -
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 14 --------------
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 14 --------------
 4 files changed, 7 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index bbdfa9ac203cc..f21c73310fdb6 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1809,13 +1809,18 @@ static void _set_rf_trx_para(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_link_info *b = &bt->link_info;
 	struct rtw89_btc_rf_trx_para para;
 	u32 wl_stb_chg = 0;
 	u8 level_id = 0;
 
 	if (!dm->freerun) {
-		dm->trx_para_level = 0;
-		chip->ops->btc_bt_aci_imp(rtwdev);
+		/* fix LNA2 = level-5 for BT ACI issue at BTG */
+		if ((btc->dm.wl_btg_rx && b->profile_cnt.now != 0) ||
+		    dm->bt_only == 1)
+			dm->trx_para_level = 1;
+		else
+			dm->trx_para_level = 0;
 	}
 
 	level_id = (u8)dm->trx_para_level;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 51af91b30fc4d..b04e7a54b1e0a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2363,7 +2363,6 @@ struct rtw89_chip_ops {
 	void (*btc_set_wl_pri)(struct rtw89_dev *rtwdev, u8 map, bool state);
 	void (*btc_set_wl_txpwr_ctrl)(struct rtw89_dev *rtwdev, u32 txpwr_val);
 	s8 (*btc_get_bt_rssi)(struct rtw89_dev *rtwdev, s8 val);
-	void (*btc_bt_aci_imp)(struct rtw89_dev *rtwdev);
 	void (*btc_update_bt_cnt)(struct rtw89_dev *rtwdev);
 	void (*btc_wl_s1_standby)(struct rtw89_dev *rtwdev, bool state);
 	void (*btc_set_policy)(struct rtw89_dev *rtwdev, u16 policy_type);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 5678683ec02a5..b5aa8697a0982 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1870,19 +1870,6 @@ static struct rtw89_btc_fbtc_mreg rtw89_btc_8852a_mon_reg[] = {
 	RTW89_DEF_FBTC_MREG(REG_BT_MODEM, 4, 0x178),
 };
 
-static
-void rtw8852a_btc_bt_aci_imp(struct rtw89_dev *rtwdev)
-{
-	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_dm *dm = &btc->dm;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
-	struct rtw89_btc_bt_link_info *b = &bt->link_info;
-
-	/* fix LNA2 = level-5 for BT ACI issue at BTG */
-	if (btc->dm.wl_btg_rx && b->profile_cnt.now != 0)
-		dm->trx_para_level = 1;
-}
-
 static
 void rtw8852a_btc_update_bt_cnt(struct rtw89_dev *rtwdev)
 {
@@ -2041,7 +2028,6 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.btc_set_wl_pri		= rtw8852a_btc_set_wl_pri,
 	.btc_set_wl_txpwr_ctrl	= rtw8852a_btc_set_wl_txpwr_ctrl,
 	.btc_get_bt_rssi	= rtw8852a_btc_get_bt_rssi,
-	.btc_bt_aci_imp		= rtw8852a_btc_bt_aci_imp,
 	.btc_update_bt_cnt	= rtw8852a_btc_update_bt_cnt,
 	.btc_wl_s1_standby	= rtw8852a_btc_wl_s1_standby,
 	.btc_set_wl_rx_gain	= rtw8852a_btc_set_wl_rx_gain,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index a5bcd3fcecb71..00f564be29e8d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2684,19 +2684,6 @@ static const struct rtw89_btc_fbtc_mreg rtw89_btc_8852c_mon_reg[] = {
 	RTW89_DEF_FBTC_MREG(REG_BB, 4, 0x980),
 };
 
-static
-void rtw8852c_btc_bt_aci_imp(struct rtw89_dev *rtwdev)
-{
-	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_dm *dm = &btc->dm;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
-	struct rtw89_btc_bt_link_info *b = &bt->link_info;
-
-	/* fix LNA2 = level-5 for BT ACI issue at BTG */
-	if (btc->dm.wl_btg_rx && b->profile_cnt.now != 0)
-		dm->trx_para_level = 1;
-}
-
 static
 void rtw8852c_btc_update_bt_cnt(struct rtw89_dev *rtwdev)
 {
@@ -2893,7 +2880,6 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.btc_set_wl_pri		= rtw8852c_btc_set_wl_pri,
 	.btc_set_wl_txpwr_ctrl	= rtw8852c_btc_set_wl_txpwr_ctrl,
 	.btc_get_bt_rssi	= rtw8852c_btc_get_bt_rssi,
-	.btc_bt_aci_imp		= rtw8852c_btc_bt_aci_imp,
 	.btc_update_bt_cnt	= rtw8852c_btc_update_bt_cnt,
 	.btc_wl_s1_standby	= rtw8852c_btc_wl_s1_standby,
 	.btc_set_wl_rx_gain	= rtw8852c_btc_set_wl_rx_gain,
-- 
2.25.1

