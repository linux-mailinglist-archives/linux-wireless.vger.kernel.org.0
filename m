Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631E14AB57C
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Feb 2022 08:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239154AbiBGHDf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Feb 2022 02:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357052AbiBGGnG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Feb 2022 01:43:06 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80326C043181
        for <linux-wireless@vger.kernel.org>; Sun,  6 Feb 2022 22:43:05 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2176e7pvD024695, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2176e7pvD024695
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 7 Feb 2022 14:40:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Feb 2022 14:40:07 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 7 Feb
 2022 14:40:07 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/7] rtw89: implement ieee80211_ops::start_ap and stop_ap
Date:   Mon, 7 Feb 2022 14:38:58 +0800
Message-ID: <20220207063900.43643-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207063900.43643-1-pkshih@realtek.com>
References: <20220207063900.43643-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 02/07/2022 06:18:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvNyCkV6TIIDAzOjUyOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Configure firmware and hardware to run AP mode. The start_ap() setup
bssid, mac port, mac_id entry, and does RFK. The stop_ap() reset the
state.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 295d54c0fc94a..5df7aceabdf5e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -371,6 +371,37 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 	mutex_unlock(&rtwdev->mutex);
 }
 
+static int rtw89_ops_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+
+	mutex_lock(&rtwdev->mutex);
+	ether_addr_copy(rtwvif->bssid, vif->bss_conf.bssid);
+	rtw89_cam_bssid_changed(rtwdev, rtwvif);
+	rtw89_mac_port_update(rtwdev, rtwvif);
+	rtw89_fw_h2c_assoc_cmac_tbl(rtwdev, vif, NULL);
+	rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, NULL, RTW89_ROLE_TYPE_CHANGE);
+	rtw89_fw_h2c_join_info(rtwdev, rtwvif, NULL, true);
+	rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL, NULL);
+	rtw89_chip_rfk_channel(rtwdev);
+	mutex_unlock(&rtwdev->mutex);
+
+	return 0;
+}
+
+static
+void rtw89_ops_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+
+	mutex_lock(&rtwdev->mutex);
+	rtw89_fw_h2c_assoc_cmac_tbl(rtwdev, vif, NULL);
+	rtw89_fw_h2c_join_info(rtwdev, rtwvif, NULL, true);
+	mutex_unlock(&rtwdev->mutex);
+}
+
 static int rtw89_ops_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 			     bool set)
 {
@@ -699,6 +730,8 @@ const struct ieee80211_ops rtw89_ops = {
 	.remove_interface	= rtw89_ops_remove_interface,
 	.configure_filter	= rtw89_ops_configure_filter,
 	.bss_info_changed	= rtw89_ops_bss_info_changed,
+	.start_ap		= rtw89_ops_start_ap,
+	.stop_ap		= rtw89_ops_stop_ap,
 	.set_tim		= rtw89_ops_set_tim,
 	.conf_tx		= rtw89_ops_conf_tx,
 	.sta_state		= rtw89_ops_sta_state,
-- 
2.25.1

