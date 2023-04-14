Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F176E22EB
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 14:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjDNMNj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 08:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjDNMNi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 08:13:38 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6431FF2
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 05:13:36 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33ECD7In8008049, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33ECD7In8008049
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 14 Apr 2023 20:13:07 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 14 Apr 2023 20:13:29 +0800
Received: from localhost (172.16.20.53) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 14 Apr
 2023 20:13:29 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 7/8] wifi: rtw88: handle station mode concurrent scan with AP mode
Date:   Fri, 14 Apr 2023 20:13:23 +0800
Message-ID: <20230414121323.18008-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.20.53]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

This patch allows vifs sharing same hardware with the AP mode vif to
do scan, do note that this could lead to packet loss or disconnection
of the AP's clients. Since we don't have chanctx, update scan info
upon set channel so bandwidth changes won't go unnoticed and get
misconfigured after scan. Download beacon just before scan starts to
allow hardware to get proper content to do beaconing. Last, beacons
should only be transmitted in AP's operating channel. Turn related
beacon functions off while we're in other channels so the receiving
stations won't get confused.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: new introduction file to handle station mode scan
---
 drivers/net/wireless/realtek/rtw88/fw.c       | 11 +++++-
 drivers/net/wireless/realtek/rtw88/mac80211.c |  5 ++-
 drivers/net/wireless/realtek/rtw88/main.c     | 39 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.h     |  2 +
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index f2d48091b1e98..2a8ccc8a7f60d 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -2160,6 +2160,12 @@ int rtw_hw_scan_offload(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 	}
 	rtw_fw_set_scan_offload(rtwdev, &cs_option, rtwvif, &chan_list);
 out:
+	if (rtwdev->ap_active) {
+		ret = rtw_download_beacon(rtwdev);
+		if (ret)
+			rtw_err(rtwdev, "HW scan download beacon failed\n");
+	}
+
 	return ret;
 }
 
@@ -2251,6 +2257,7 @@ void rtw_hw_scan_chan_switch(struct rtw_dev *rtwdev, struct sk_buff *skb)
 		if (rtw_is_op_chan(rtwdev, chan)) {
 			rtw_store_op_chan(rtwdev, false);
 			ieee80211_wake_queues(rtwdev->hw);
+			rtw_core_enable_beacon(rtwdev, true);
 		}
 	} else if (id == RTW_SCAN_NOTIFY_ID_PRESWITCH) {
 		if (IS_CH_5G_BAND(chan)) {
@@ -2269,8 +2276,10 @@ void rtw_hw_scan_chan_switch(struct rtw_dev *rtwdev, struct sk_buff *skb)
 		 * if next channel is non-op channel.
 		 */
 		if (!rtw_is_op_chan(rtwdev, chan) &&
-		    rtw_is_op_chan(rtwdev, hal->current_channel))
+		    rtw_is_op_chan(rtwdev, hal->current_channel)) {
+			rtw_core_enable_beacon(rtwdev, false);
 			ieee80211_stop_queues(rtwdev->hw);
+		}
 	}
 
 	rtw_dbg(rtwdev, RTW_DBG_HW_SCAN,
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index b3e4c699d4254..7aa6edad0d012 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -404,7 +404,7 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_BSSID) {
 		ether_addr_copy(rtwvif->bssid, conf->bssid);
 		config |= PORT_SET_BSSID;
-		if (is_zero_ether_addr(rtwvif->bssid))
+		if (!rtw_core_check_sta_active(rtwdev))
 			rtw_clear_op_chan(rtwdev);
 		else
 			rtw_store_op_chan(rtwdev, true);
@@ -452,6 +452,7 @@ static int rtw_ops_start_ap(struct ieee80211_hw *hw,
 
 	mutex_lock(&rtwdev->mutex);
 	rtwdev->ap_active = true;
+	rtw_store_op_chan(rtwdev, true);
 	chip->ops->phy_calibration(rtwdev);
 	mutex_unlock(&rtwdev->mutex);
 
@@ -466,6 +467,8 @@ static void rtw_ops_stop_ap(struct ieee80211_hw *hw,
 
 	mutex_lock(&rtwdev->mutex);
 	rtwdev->ap_active = false;
+	if (!rtw_core_check_sta_active(rtwdev))
+		rtw_clear_op_chan(rtwdev);
 	mutex_unlock(&rtwdev->mutex);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 4537513d06689..c3a91bef13e4e 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -830,6 +830,9 @@ void rtw_set_channel(struct rtw_dev *rtwdev)
 
 	rtw_update_channel(rtwdev, center_chan, primary_chan, band, bandwidth);
 
+	if (rtwdev->scan_info.op_chan)
+		rtw_store_op_chan(rtwdev, true);
+
 	chip->ops->set_channel(rtwdev, center_chan, bandwidth,
 			       hal->current_primary_channel_index);
 
@@ -2330,6 +2333,42 @@ void rtw_core_port_switch(struct rtw_dev *rtwdev, struct ieee80211_vif *vif)
 	rtw_iterate_vifs(rtwdev, rtw_port_switch_iter, &iter_data);
 }
 
+static void rtw_check_sta_active_iter(void *data, u8 *mac,
+				      struct ieee80211_vif *vif)
+{
+	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
+	bool *active = data;
+
+	if (*active)
+		return;
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	if (vif->cfg.assoc || !is_zero_ether_addr(rtwvif->bssid))
+		*active = true;
+}
+
+bool rtw_core_check_sta_active(struct rtw_dev *rtwdev)
+{
+	bool sta_active = false;
+
+	rtw_iterate_vifs(rtwdev, rtw_check_sta_active_iter, &sta_active);
+
+	return rtwdev->ap_active || sta_active;
+}
+
+void rtw_core_enable_beacon(struct rtw_dev *rtwdev, bool enable)
+{
+	if (!rtwdev->ap_active)
+		return;
+
+	if (enable)
+		rtw_write32_set(rtwdev, REG_BCN_CTRL, BIT_EN_BCN_FUNCTION);
+	else
+		rtw_write32_clr(rtwdev, REG_BCN_CTRL, BIT_EN_BCN_FUNCTION);
+}
+
 MODULE_AUTHOR("Realtek Corporation");
 MODULE_DESCRIPTION("Realtek 802.11ac wireless core module");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index b04ed190ea5d4..621355f84d028 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -2201,4 +2201,6 @@ void rtw_update_channel(struct rtw_dev *rtwdev, u8 center_channel,
 			u8 primary_channel, enum rtw_supported_band band,
 			enum rtw_bandwidth bandwidth);
 void rtw_core_port_switch(struct rtw_dev *rtwdev, struct ieee80211_vif *vif);
+bool rtw_core_check_sta_active(struct rtw_dev *rtwdev);
+void rtw_core_enable_beacon(struct rtw_dev *rtwdev, bool enable);
 #endif
-- 
2.25.1

