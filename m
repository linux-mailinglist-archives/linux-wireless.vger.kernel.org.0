Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9484E640031
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Dec 2022 07:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiLBGQn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Dec 2022 01:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiLBGQk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Dec 2022 01:16:40 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B22AADC874
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 22:16:39 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2B26Fl7oA006325, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2B26Fl7oA006325
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 2 Dec 2022 14:15:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 2 Dec 2022 14:16:32 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 2 Dec 2022
 14:16:32 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/4] wifi: rtw89: stop mac port function when stop_ap()
Date:   Fri, 2 Dec 2022 14:15:25 +0800
Message-ID: <20221202061527.505668-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221202061527.505668-1-pkshih@realtek.com>
References: <20221202061527.505668-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 12/02/2022 06:00:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzIgpFekyCAwMToyMDowMA==?=
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

From: Po-Hao Huang <phhuang@realtek.com>

Disable hardware beacon related functions when ap stops. So hardware won't
transmit beacons while interface is already removed.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c      | 16 +++++++++++++---
 drivers/net/wireless/realtek/rtw89/mac.h      |  1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  1 +
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index a80690d0bf485..12cbf41590bbe 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3877,11 +3877,16 @@ static void rtw89_mac_port_cfg_hiq_drop(struct rtw89_dev *rtwdev,
 }
 
 static void rtw89_mac_port_cfg_func_en(struct rtw89_dev *rtwdev,
-				       struct rtw89_vif *rtwvif)
+				       struct rtw89_vif *rtwvif, bool enable)
 {
 	const struct rtw89_port_reg *p = &rtw_port_base;
 
-	rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, B_AX_PORT_FUNC_EN);
+	if (enable)
+		rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg,
+				       B_AX_PORT_FUNC_EN);
+	else
+		rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg,
+				       B_AX_PORT_FUNC_EN);
 }
 
 static void rtw89_mac_port_cfg_bcn_early(struct rtw89_dev *rtwdev,
@@ -4033,7 +4038,7 @@ int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtw89_mac_port_cfg_tbtt_shift(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_bss_color(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_mbssid(rtwdev, rtwvif);
-	rtw89_mac_port_cfg_func_en(rtwdev, rtwvif);
+	rtw89_mac_port_cfg_func_en(rtwdev, rtwvif, true);
 	rtw89_mac_port_tsf_resync_all(rtwdev);
 	fsleep(BCN_ERLY_SET_DLY);
 	rtw89_mac_port_cfg_bcn_early(rtwdev, rtwvif);
@@ -4085,6 +4090,11 @@ void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 		rtw89_write32_set(rtwdev, reg, B_AX_RXTRIG_RU26_DIS);
 }
 
+void rtw89_mac_stop_ap(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+{
+	rtw89_mac_port_cfg_func_en(rtwdev, rtwvif, false);
+}
+
 int rtw89_mac_add_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
 	int ret;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 766ca6934d33a..f0b684b205f10 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -908,6 +908,7 @@ int rtw89_mac_add_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
 int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 					struct ieee80211_vif *vif);
+void rtw89_mac_stop_ap(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 int rtw89_mac_remove_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
 void rtw89_mac_disable_cpu(struct rtw89_dev *rtwdev);
 int rtw89_mac_enable_cpu(struct rtw89_dev *rtwdev, u8 boot_reason, bool dlfw);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 1a99267d710d4..0c86d416b7ad2 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -454,6 +454,7 @@ void rtw89_ops_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 
 	mutex_lock(&rtwdev->mutex);
+	rtw89_mac_stop_ap(rtwdev, rtwvif);
 	rtw89_fw_h2c_assoc_cmac_tbl(rtwdev, vif, NULL);
 	rtw89_fw_h2c_join_info(rtwdev, rtwvif, NULL, true);
 	mutex_unlock(&rtwdev->mutex);
-- 
2.25.1

