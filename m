Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA88D6D30CC
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Apr 2023 14:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjDAMpt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Apr 2023 08:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDAMpr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Apr 2023 08:45:47 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6746F1F7B3
        for <linux-wireless@vger.kernel.org>; Sat,  1 Apr 2023 05:45:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 331CjCPv9021660, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 331CjCPv9021660
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 1 Apr 2023 20:45:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 1 Apr 2023 20:45:30 +0800
Received: from localhost (172.16.16.15) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sat, 1 Apr 2023
 20:45:29 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/7] wifi: rtw88: add bitmap for dynamic port settings
Date:   Sat, 1 Apr 2023 20:44:04 +0800
Message-ID: <20230401124410.33221-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230401124410.33221-1-pkshih@realtek.com>
References: <20230401124410.33221-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.15]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

In order to support multiple interfaces, multiple port settings will
be required. Current code always uses port 0 and should be changed.
Declare a bitmap with size equal to hardware port number to record
the current usage.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c | 13 ++++++++++---
 drivers/net/wireless/realtek/rtw88/main.c     |  1 +
 drivers/net/wireless/realtek/rtw88/main.h     | 10 ++++++++++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 3b92ac611d3fd..d026094a72c40 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -155,25 +155,30 @@ static int rtw_ops_add_interface(struct ieee80211_hw *hw,
 	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
 	enum rtw_net_type net_type;
 	u32 config = 0;
-	u8 port = 0;
+	u8 port;
 	u8 bcn_ctrl = 0;
 
 	if (rtw_fw_feature_check(&rtwdev->fw, FW_FEATURE_BCN_FILTER))
 		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER |
 				     IEEE80211_VIF_SUPPORTS_CQM_RSSI;
-	rtwvif->port = port;
 	rtwvif->stats.tx_unicast = 0;
 	rtwvif->stats.rx_unicast = 0;
 	rtwvif->stats.tx_cnt = 0;
 	rtwvif->stats.rx_cnt = 0;
 	rtwvif->scan_req = NULL;
 	memset(&rtwvif->bfee, 0, sizeof(struct rtw_bfee));
-	rtwvif->conf = &rtw_vif_port[port];
 	rtw_txq_init(rtwdev, vif->txq);
 	INIT_LIST_HEAD(&rtwvif->rsvd_page_list);
 
 	mutex_lock(&rtwdev->mutex);
 
+	port = find_first_zero_bit(rtwdev->hw_port, RTW_PORT_NUM);
+	if (port >= RTW_PORT_NUM)
+		return -EINVAL;
+	set_bit(port, rtwdev->hw_port);
+
+	rtwvif->port = port;
+	rtwvif->conf = &rtw_vif_port[port];
 	rtw_leave_lps_deep(rtwdev);
 
 	switch (vif->type) {
@@ -195,6 +200,7 @@ static int rtw_ops_add_interface(struct ieee80211_hw *hw,
 		break;
 	default:
 		WARN_ON(1);
+		clear_bit(rtwvif->port, rtwdev->hw_port);
 		mutex_unlock(&rtwdev->mutex);
 		return -EINVAL;
 	}
@@ -236,6 +242,7 @@ static void rtw_ops_remove_interface(struct ieee80211_hw *hw,
 	rtwvif->bcn_ctrl = 0;
 	config |= PORT_SET_BCN_CTRL;
 	rtw_vif_port_config(rtwdev, rtwvif, config);
+	clear_bit(rtwvif->port, rtwdev->hw_port);
 
 	mutex_unlock(&rtwdev->mutex);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index b2e78737bd5d0..39b18c7468c9e 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -609,6 +609,7 @@ static void __fw_recovery_work(struct rtw_dev *rtwdev)
 	rcu_read_unlock();
 	rtw_iterate_stas_atomic(rtwdev, rtw_reset_sta_iter, rtwdev);
 	rtw_iterate_vifs_atomic(rtwdev, rtw_reset_vif_iter, rtwdev);
+	bitmap_zero(rtwdev->hw_port, RTW_PORT_NUM);
 	rtw_enter_ips(rtwdev);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index d4a53d5567451..efac271497f5b 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -395,6 +395,15 @@ enum rtw_snr {
 	RTW_SNR_NUM
 };
 
+enum rtw_port {
+	RTW_PORT_0 = 0,
+	RTW_PORT_1 = 1,
+	RTW_PORT_2 = 2,
+	RTW_PORT_3 = 3,
+	RTW_PORT_4 = 4,
+	RTW_PORT_NUM
+};
+
 enum rtw_wow_flags {
 	RTW_WOW_FLAG_EN_MAGIC_PKT,
 	RTW_WOW_FLAG_EN_REKEY_PKT,
@@ -2036,6 +2045,7 @@ struct rtw_dev {
 	u8 sta_cnt;
 	u32 rts_threshold;
 
+	DECLARE_BITMAP(hw_port, RTW_PORT_NUM);
 	DECLARE_BITMAP(mac_id_map, RTW_MAX_MAC_ID_NUM);
 	DECLARE_BITMAP(flags, NUM_OF_RTW_FLAGS);
 
-- 
2.25.1

