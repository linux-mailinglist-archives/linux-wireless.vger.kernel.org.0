Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58D54C3C2B
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Feb 2022 04:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbiBYDKH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Feb 2022 22:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236900AbiBYDKG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Feb 2022 22:10:06 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A272C032D
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 19:09:34 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21P39SC30000880, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21P39SC30000880
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Feb 2022 11:09:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 25 Feb 2022 11:09:28 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 25 Feb
 2022 11:09:27 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>,
        <phhuang@realtek.com>
Subject: [PATCH 2/2] rtw89: add tx_wake notify for low ps mode
Date:   Fri, 25 Feb 2022 11:08:51 +0800
Message-ID: <20220225030851.13327-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225030851.13327-1-pkshih@realtek.com>
References: <20220225030851.13327-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 02/25/2022 02:51:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvMjUgpFekyCAwMToyMTowMA==?=
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

From: Chin-Yen Lee <timlee@realtek.com>

We found management frames get stuck when wifi chip
enters low ps mode. So we add one notify wake function
to trigger wifi chip into normal mode before forwarding
management frames.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 19 +++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h |  3 ++
 drivers/net/wireless/realtek/rtw89/fw.c   |  4 +++
 drivers/net/wireless/realtek/rtw89/mac.c  | 34 +++++++++++++++++------
 drivers/net/wireless/realtek/rtw89/mac.h  |  1 +
 drivers/net/wireless/realtek/rtw89/reg.h  |  1 +
 6 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 88f1d452e5d64..3adb52f3dc457 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -755,6 +755,22 @@ rtw89_core_tx_btc_spec_pkt_notify(struct rtw89_dev *rtwdev,
 	return PACKET_MAX;
 }
 
+static void
+rtw89_core_tx_wake(struct rtw89_dev *rtwdev,
+		   struct rtw89_core_tx_request *tx_req)
+{
+	if (!rtwdev->fw.tx_wake)
+		return;
+
+	if (!test_bit(RTW89_FLAG_LOW_POWER_MODE, rtwdev->flags))
+		return;
+
+	if (tx_req->tx_type != RTW89_CORE_TX_TYPE_MGMT)
+		return;
+
+	rtw89_mac_notify_wake(rtwdev);
+}
+
 static void
 rtw89_core_tx_update_desc_info(struct rtw89_dev *rtwdev,
 			       struct rtw89_core_tx_request *tx_req)
@@ -853,6 +869,8 @@ int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	rtw89_traffic_stats_accu(rtwdev, &rtwdev->stats, skb, true);
 	rtw89_traffic_stats_accu(rtwdev, &rtwvif->stats, skb, true);
 	rtw89_core_tx_update_desc_info(rtwdev, &tx_req);
+	rtw89_core_tx_wake(rtwdev, &tx_req);
+
 	ret = rtw89_hci_tx_write(rtwdev, &tx_req);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to transmit skb to HCI\n");
@@ -2618,6 +2636,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	INIT_DELAYED_WORK(&rtwdev->cfo_track_work, rtw89_phy_cfo_track_work);
 	rtwdev->txq_wq = alloc_workqueue("rtw89_tx_wq", WQ_UNBOUND | WQ_HIGHPRI, 0);
 	spin_lock_init(&rtwdev->ba_lock);
+	spin_lock_init(&rtwdev->rpwm_lock);
 	mutex_init(&rtwdev->mutex);
 	mutex_init(&rtwdev->rf_mutex);
 	rtwdev->total_sta_assoc = 0;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e033deb38efd9..f066e6c24e80f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2351,6 +2351,7 @@ struct rtw89_fw_info {
 	bool fw_log_enable;
 	bool old_ht_ra_format;
 	bool scan_offload;
+	bool tx_wake;
 };
 
 struct rtw89_cam_info {
@@ -2848,6 +2849,8 @@ struct rtw89_dev {
 	/* txqs to setup ba session */
 	struct list_head ba_list;
 	struct work_struct ba_work;
+	/* used to protect rpwm */
+	spinlock_t rpwm_lock;
 
 	struct rtw89_cam_info cam_info;
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index b610f676dab25..97224483f6188 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -205,6 +205,10 @@ static void rtw89_fw_recognize_features(struct rtw89_dev *rtwdev)
 	if (chip->chip_id == RTL8852A &&
 	    RTW89_FW_SUIT_VER_CODE(fw_suit) >= RTW89_FW_VER_CODE(0, 13, 35, 0))
 		rtwdev->fw.scan_offload = true;
+
+	if (chip->chip_id == RTL8852A &&
+	    RTW89_FW_SUIT_VER_CODE(fw_suit) >= RTW89_FW_VER_CODE(0, 13, 35, 0))
+		rtwdev->fw.tx_wake = true;
 }
 
 int rtw89_fw_recognize(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 5e140290fe04a..9a91b408cd28e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -917,23 +917,31 @@ rtw89_mac_get_req_pwr_state(struct rtw89_dev *rtwdev)
 }
 
 static void rtw89_mac_send_rpwm(struct rtw89_dev *rtwdev,
-				enum rtw89_rpwm_req_pwr_state req_pwr_state)
+				enum rtw89_rpwm_req_pwr_state req_pwr_state,
+				bool notify_wake)
 {
 	u16 request;
 
+	spin_lock_bh(&rtwdev->rpwm_lock);
+
 	request = rtw89_read16(rtwdev, R_AX_RPWM);
 	request ^= request | PS_RPWM_TOGGLE;
-
-	rtwdev->mac.rpwm_seq_num = (rtwdev->mac.rpwm_seq_num + 1) &
-				   RPWM_SEQ_NUM_MAX;
-	request |= FIELD_PREP(PS_RPWM_SEQ_NUM, rtwdev->mac.rpwm_seq_num);
-
 	request |= req_pwr_state;
 
-	if (req_pwr_state < RTW89_MAC_RPWM_REQ_PWR_STATE_CLK_GATED)
-		request |= PS_RPWM_ACK;
+	if (notify_wake) {
+		request |= PS_RPWM_NOTIFY_WAKE;
+	} else {
+		rtwdev->mac.rpwm_seq_num = (rtwdev->mac.rpwm_seq_num + 1) &
+					    RPWM_SEQ_NUM_MAX;
+		request |= FIELD_PREP(PS_RPWM_SEQ_NUM,
+				      rtwdev->mac.rpwm_seq_num);
 
+		if (req_pwr_state < RTW89_MAC_RPWM_REQ_PWR_STATE_CLK_GATED)
+			request |= PS_RPWM_ACK;
+	}
 	rtw89_write16(rtwdev, rtwdev->hci.rpwm_addr, request);
+
+	spin_unlock_bh(&rtwdev->rpwm_lock);
 }
 
 static int rtw89_mac_check_cpwm_state(struct rtw89_dev *rtwdev,
@@ -993,7 +1001,7 @@ void rtw89_mac_power_mode_change(struct rtw89_dev *rtwdev, bool enter)
 	else
 		state = RTW89_MAC_RPWM_REQ_PWR_STATE_ACTIVE;
 
-	rtw89_mac_send_rpwm(rtwdev, state);
+	rtw89_mac_send_rpwm(rtwdev, state, false);
 	ret = read_poll_timeout_atomic(rtw89_mac_check_cpwm_state, ret, !ret,
 				       1000, 15000, false, rtwdev, state);
 	if (ret)
@@ -1001,6 +1009,14 @@ void rtw89_mac_power_mode_change(struct rtw89_dev *rtwdev, bool enter)
 			  enter ? "entering" : "leaving");
 }
 
+void rtw89_mac_notify_wake(struct rtw89_dev *rtwdev)
+{
+	enum rtw89_rpwm_req_pwr_state state;
+
+	state = rtw89_mac_get_req_pwr_state(rtwdev);
+	rtw89_mac_send_rpwm(rtwdev, state, true);
+}
+
 static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 {
 #define PWR_ACT 1
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 9ea84349e593c..5c7a9d784265a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -799,6 +799,7 @@ bool rtw89_mac_get_txpwr_cr(struct rtw89_dev *rtwdev,
 			    enum rtw89_phy_idx phy_idx,
 			    u32 reg_base, u32 *cr);
 void rtw89_mac_power_mode_change(struct rtw89_dev *rtwdev, bool enter);
+void rtw89_mac_notify_wake(struct rtw89_dev *rtwdev);
 void rtw89_mac_bf_assoc(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta);
 void rtw89_mac_bf_disassoc(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index b39e531df2d7a..62dca0888d88d 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -112,6 +112,7 @@
 #define PS_RPWM_TOGGLE BIT(15)
 #define PS_RPWM_ACK BIT(14)
 #define PS_RPWM_SEQ_NUM GENMASK(13, 12)
+#define PS_RPWM_NOTIFY_WAKE BIT(8)
 #define PS_RPWM_STATE 0x7
 #define RPWM_SEQ_NUM_MAX 3
 #define PS_CPWM_SEQ_NUM GENMASK(13, 12)
-- 
2.25.1

