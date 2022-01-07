Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B792F487164
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 04:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345915AbiAGDnh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 22:43:37 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:51122 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345918AbiAGDna (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 22:43:30 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2073hQkrD023029, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2073hQkrD023029
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 7 Jan 2022 11:43:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 11:43:25 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 7 Jan
 2022 11:43:25 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 17/19] rtw89: implement ieee80211_ops::start_ap and stop_ap
Date:   Fri, 7 Jan 2022 11:42:37 +0800
Message-ID: <20220107034239.22002-18-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107034239.22002-1-pkshih@realtek.com>
References: <20220107034239.22002-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 01/07/2022 03:26:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvNyCkV6TIIDAxOjMzOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
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
index c7208fad31dd6..091c0aa631855 100644
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

