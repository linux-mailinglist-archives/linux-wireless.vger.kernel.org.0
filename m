Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61600363C06
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Apr 2021 09:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhDSHBF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Apr 2021 03:01:05 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:48377 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbhDSHBB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Apr 2021 03:01:01 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 13J70ALD0020362, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 13J70ALD0020362
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 19 Apr 2021 15:00:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 19 Apr 2021 15:00:10 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 19 Apr
 2021 15:00:09 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <mail@maciej.szmigiero.name>,
        <Larry.Finger@lwfinger.net>
Subject: [PATCH] rtlwifi: implement set_tim by update beacon content
Date:   Mon, 19 Apr 2021 14:59:56 +0800
Message-ID: <20210419065956.6085-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS03.realtek.com.tw (172.21.6.96) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMTkgpFekyCAwMzozMDowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/19/2021 06:34:40
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163190 [Apr 19 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 442 442 b985cb57763b61d2a20abb585d5d4cc10c315b09
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_all_Bitcoin, bb}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, headers_charset}
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/19/2021 06:38:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/19/2021 06:34:40
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163190 [Apr 19 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 442 442 b985cb57763b61d2a20abb585d5d4cc10c315b09
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_all_Bitcoin, bb}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/19/2021 06:38:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Once beacon content is changed, we update the content to wifi card by
send_beacon_frame(). Then, STA with PS can wake up properly to receive its
packets.

Since we update beacon content to PCI wifi devices every beacon interval,
the only one usb device, 8192CU, needs to update beacon content when
mac80211 calling set_tim.

Reported-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtlwifi/core.c | 32 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtlwifi/core.h |  1 +
 drivers/net/wireless/realtek/rtlwifi/usb.c  |  3 ++
 drivers/net/wireless/realtek/rtlwifi/wifi.h |  1 +
 4 files changed, 37 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/core.c b/drivers/net/wireless/realtek/rtlwifi/core.c
index c9b6ee81dcb9..8efe2f5e5b9f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/core.c
+++ b/drivers/net/wireless/realtek/rtlwifi/core.c
@@ -1018,6 +1018,25 @@ static void send_beacon_frame(struct ieee80211_hw *hw,
 	}
 }
 
+void rtl_update_beacon_work_callback(struct work_struct *work)
+{
+	struct rtl_works *rtlworks =
+	    container_of(work, struct rtl_works, update_beacon_work);
+	struct ieee80211_hw *hw = rtlworks->hw;
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct ieee80211_vif *vif = rtlpriv->mac80211.vif;
+
+	if (!vif) {
+		WARN_ONCE(true, "no vif to update beacon\n");
+		return;
+	}
+
+	mutex_lock(&rtlpriv->locks.conf_mutex);
+	send_beacon_frame(hw, vif);
+	mutex_unlock(&rtlpriv->locks.conf_mutex);
+}
+EXPORT_SYMBOL_GPL(rtl_update_beacon_work_callback);
+
 static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_bss_conf *bss_conf,
@@ -1747,6 +1766,18 @@ static void rtl_op_flush(struct ieee80211_hw *hw,
 		rtlpriv->intf_ops->flush(hw, queues, drop);
 }
 
+static int rtl_op_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
+			  bool set)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
+
+	if (rtlhal->hw_type == HARDWARE_TYPE_RTL8192CU)
+		schedule_work(&rtlpriv->works.update_beacon_work);
+
+	return 0;
+}
+
 /*	Description:
  *		This routine deals with the Power Configuration CMD
  *		 parsing for RTL8723/RTL8188E Series IC.
@@ -1903,6 +1934,7 @@ const struct ieee80211_ops rtl_ops = {
 	.sta_add = rtl_op_sta_add,
 	.sta_remove = rtl_op_sta_remove,
 	.flush = rtl_op_flush,
+	.set_tim = rtl_op_set_tim,
 };
 EXPORT_SYMBOL_GPL(rtl_ops);
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/core.h b/drivers/net/wireless/realtek/rtlwifi/core.h
index 7447ff456710..345161b47442 100644
--- a/drivers/net/wireless/realtek/rtlwifi/core.h
+++ b/drivers/net/wireless/realtek/rtlwifi/core.h
@@ -60,5 +60,6 @@ void rtl_bb_delay(struct ieee80211_hw *hw, u32 addr, u32 data);
 bool rtl_cmd_send_packet(struct ieee80211_hw *hw, struct sk_buff *skb);
 bool rtl_btc_status_false(void);
 void rtl_dm_diginit(struct ieee80211_hw *hw, u32 cur_igval);
+void rtl_update_beacon_work_callback(struct work_struct *work);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 37a9a03123f3..86a236873254 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -805,6 +805,7 @@ static void rtl_usb_stop(struct ieee80211_hw *hw)
 
 	tasklet_kill(&rtlusb->rx_work_tasklet);
 	cancel_work_sync(&rtlpriv->works.lps_change_work);
+	cancel_work_sync(&rtlpriv->works.update_beacon_work);
 
 	flush_workqueue(rtlpriv->works.rtl_wq);
 
@@ -1031,6 +1032,8 @@ int rtl_usb_probe(struct usb_interface *intf,
 		  rtl_fill_h2c_cmd_work_callback);
 	INIT_WORK(&rtlpriv->works.lps_change_work,
 		  rtl_lps_change_work_callback);
+	INIT_WORK(&rtlpriv->works.update_beacon_work,
+		  rtl_update_beacon_work_callback);
 
 	rtlpriv->usb_data_index = 0;
 	init_completion(&rtlpriv->firmware_loading_complete);
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 877ed6a1589f..aa07856411b1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2486,6 +2486,7 @@ struct rtl_works {
 
 	struct work_struct lps_change_work;
 	struct work_struct fill_h2c_cmd;
+	struct work_struct update_beacon_work;
 };
 
 struct rtl_debug {
-- 
2.21.0

