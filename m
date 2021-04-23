Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20F4368F54
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 11:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241733AbhDWJ2F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 05:28:05 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:45138 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhDWJ2E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 05:28:04 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 13N9RLsxC002795, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 13N9RLsxC002795
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Apr 2021 17:27:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 23 Apr 2021 17:27:20 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 23 Apr
 2021 17:27:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>
Subject: [PATCH v3 1/3] rtw88: add beacon filter support
Date:   Fri, 23 Apr 2021 17:26:54 +0800
Message-ID: <20210423092656.20603-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMjMgpFekyCAwNjoxOTowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/23/2021 09:13:16
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163299 [Apr 22 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 443 443 d64ad0ad6f66abd85f8fb55fe5d831fdcc4c44a0
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
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
X-KSE-Antiphishing-Bases: 04/23/2021 09:16:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/23/2021 09:13:16
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163299 [Apr 22 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 443 443 d64ad0ad6f66abd85f8fb55fe5d831fdcc4c44a0
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/23/2021 09:16:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Adding this supports beacon filter and CQM.
Let firmware perform connection quality monitor and beacon processing.
This make host CPU wakeup less under power save mode.
To make mechanisms work as usual, fw will notify driver events such as
signal change and beacon loss.

This feature needs firmware 9.9.8 or newer to support it, and driver is
compatible with older firmware.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v3: fix C2H format
v2: no change
---
 drivers/net/wireless/realtek/rtw88/fw.c       | 91 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/fw.h       | 39 ++++++++
 drivers/net/wireless/realtek/rtw88/mac80211.c |  7 ++
 drivers/net/wireless/realtek/rtw88/main.c     |  4 +-
 drivers/net/wireless/realtek/rtw88/main.h     |  1 +
 5 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index ea2cd4db1d3c..797b08b2a494 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -127,6 +127,51 @@ static void rtw_fw_ra_report_handle(struct rtw_dev *rtwdev, u8 *payload,
 	rtw_iterate_stas_atomic(rtwdev, rtw_fw_ra_report_iter, &ra_data);
 }
 
+struct rtw_beacon_filter_iter_data {
+	struct rtw_dev *rtwdev;
+	u8 *payload;
+};
+
+static void rtw_fw_bcn_filter_notify_vif_iter(void *data, u8 *mac,
+					      struct ieee80211_vif *vif)
+{
+	struct rtw_beacon_filter_iter_data *iter_data = data;
+	struct rtw_dev *rtwdev = iter_data->rtwdev;
+	u8 *payload = iter_data->payload;
+	u8 type = GET_BCN_FILTER_NOTIFY_TYPE(payload);
+	u8 event = GET_BCN_FILTER_NOTIFY_EVENT(payload);
+	s8 sig = (s8)GET_BCN_FILTER_NOTIFY_RSSI(payload);
+
+	switch (type) {
+	case BCN_FILTER_NOTIFY_SIGNAL_CHANGE:
+		event = event ? NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH :
+			NL80211_CQM_RSSI_THRESHOLD_EVENT_LOW;
+		ieee80211_cqm_rssi_notify(vif, event, sig, GFP_KERNEL);
+		break;
+	case BCN_FILTER_CONNECTION_LOSS:
+		ieee80211_connection_loss(vif);
+		break;
+	case BCN_FILTER_CONNECTED:
+		rtwdev->beacon_loss = false;
+		break;
+	case BCN_FILTER_NOTIFY_BEACON_LOSS:
+		rtwdev->beacon_loss = true;
+		rtw_leave_lps(rtwdev);
+		break;
+	}
+}
+
+static void rtw_fw_bcn_filter_notify(struct rtw_dev *rtwdev, u8 *payload,
+				     u8 length)
+{
+	struct rtw_beacon_filter_iter_data dev_iter_data;
+
+	dev_iter_data.rtwdev = rtwdev;
+	dev_iter_data.payload = payload;
+	rtw_iterate_vifs(rtwdev, rtw_fw_bcn_filter_notify_vif_iter,
+			 &dev_iter_data);
+}
+
 void rtw_fw_c2h_cmd_handle(struct rtw_dev *rtwdev, struct sk_buff *skb)
 {
 	struct rtw_c2h_cmd *c2h;
@@ -152,6 +197,9 @@ void rtw_fw_c2h_cmd_handle(struct rtw_dev *rtwdev, struct sk_buff *skb)
 	case C2H_WLAN_INFO:
 		rtw_coex_wl_fwdbginfo_notify(rtwdev, c2h->payload, len);
 		break;
+	case C2H_BCN_FILTER_NOTIFY:
+		rtw_fw_bcn_filter_notify(rtwdev, c2h->payload, len);
+		break;
 	case C2H_HALMAC:
 		rtw_fw_c2h_cmd_handle_ext(rtwdev, skb);
 		break;
@@ -527,6 +575,49 @@ void rtw_fw_update_wl_phy_info(struct rtw_dev *rtwdev)
 	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
 }
 
+void rtw_fw_beacon_filter_config(struct rtw_dev *rtwdev, bool connect,
+				 struct ieee80211_vif *vif)
+{
+	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
+	struct ieee80211_sta *sta = ieee80211_find_sta(vif, bss_conf->bssid);
+	static const u8 rssi_min = 0, rssi_max = 100, rssi_offset = 100;
+	struct rtw_sta_info *si =
+		sta ? (struct rtw_sta_info *)sta->drv_priv : NULL;
+	s32 threshold = bss_conf->cqm_rssi_thold + rssi_offset;
+	struct rtw_fw_state *fw = &rtwdev->fw;
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+
+	if (!(fw->feature & FW_FEATURE_BCN_FILTER))
+		return;
+
+	if (!connect) {
+		SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_BCN_FILTER_OFFLOAD_P1);
+		SET_BCN_FILTER_OFFLOAD_P1_ENABLE(h2c_pkt, connect);
+		rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+
+		return;
+	}
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_BCN_FILTER_OFFLOAD_P0);
+	ether_addr_copy(&h2c_pkt[1], bss_conf->bssid);
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+
+	memset(h2c_pkt, 0, sizeof(h2c_pkt));
+	threshold = clamp_t(s32, threshold, rssi_min, rssi_max);
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_BCN_FILTER_OFFLOAD_P1);
+	SET_BCN_FILTER_OFFLOAD_P1_ENABLE(h2c_pkt, connect);
+	SET_BCN_FILTER_OFFLOAD_P1_OFFLOAD_MODE(h2c_pkt,
+					       BCN_FILTER_OFFLOAD_MODE_DEFAULT);
+	SET_BCN_FILTER_OFFLOAD_P1_THRESHOLD(h2c_pkt, (u8)threshold);
+	SET_BCN_FILTER_OFFLOAD_P1_BCN_LOSS_CNT(h2c_pkt, BCN_LOSS_CNT);
+	if (si)
+		SET_BCN_FILTER_OFFLOAD_P1_MACID(h2c_pkt, si->mac_id);
+	else
+		rtw_warn(rtwdev, "CQM config with station not found\n");
+	SET_BCN_FILTER_OFFLOAD_P1_HYST(h2c_pkt, bss_conf->cqm_rssi_hyst);
+	SET_BCN_FILTER_OFFLOAD_P1_BCN_INTERVAL(h2c_pkt, bss_conf->beacon_int);
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
+
 void rtw_fw_set_pwr_mode(struct rtw_dev *rtwdev)
 {
 	struct rtw_lps_conf *conf = &rtwdev->lps_conf;
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 7c5b1d75e26f..2fb064fc4e89 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -24,6 +24,12 @@
 #define DLFW_BLK_SIZE_LEGACY		4
 #define FW_START_ADDR_LEGACY		0x1000
 
+#define BCN_LOSS_CNT			7
+#define BCN_FILTER_NOTIFY_SIGNAL_CHANGE	0
+#define BCN_FILTER_CONNECTION_LOSS	1
+#define BCN_FILTER_CONNECTED		2
+#define BCN_FILTER_NOTIFY_BEACON_LOSS	3
+
 enum rtw_c2h_cmd_id {
 	C2H_CCX_TX_RPT = 0x03,
 	C2H_BT_INFO = 0x09,
@@ -32,6 +38,7 @@ enum rtw_c2h_cmd_id {
 	C2H_HW_FEATURE_REPORT = 0x19,
 	C2H_WLAN_INFO = 0x27,
 	C2H_WLAN_RFON = 0x32,
+	C2H_BCN_FILTER_NOTIFY = 0x36,
 	C2H_HW_FEATURE_DUMP = 0xfd,
 	C2H_HALMAC = 0xff,
 };
@@ -78,9 +85,19 @@ enum rtw_fw_feature {
 	FW_FEATURE_LPS_C2H = BIT(1),
 	FW_FEATURE_LCLK = BIT(2),
 	FW_FEATURE_PG = BIT(3),
+	FW_FEATURE_BCN_FILTER = BIT(5),
 	FW_FEATURE_MAX = BIT(31),
 };
 
+enum rtw_beacon_filter_offload_mode {
+	BCN_FILTER_OFFLOAD_MODE_0 = 0,
+	BCN_FILTER_OFFLOAD_MODE_1,
+	BCN_FILTER_OFFLOAD_MODE_2,
+	BCN_FILTER_OFFLOAD_MODE_3,
+
+	BCN_FILTER_OFFLOAD_MODE_DEFAULT = BCN_FILTER_OFFLOAD_MODE_1,
+};
+
 struct rtw_coex_info_req {
 	u8 seq;
 	u8 op_code;
@@ -237,6 +254,10 @@ struct rtw_fw_hdr_legacy {
 #define GET_RA_REPORT_BW(c2h_payload)		(c2h_payload[6])
 #define GET_RA_REPORT_MACID(c2h_payload)	(c2h_payload[1])
 
+#define GET_BCN_FILTER_NOTIFY_TYPE(c2h_payload)	(c2h_payload[1] & 0xf)
+#define GET_BCN_FILTER_NOTIFY_EVENT(c2h_payload)	(c2h_payload[1] & 0x10)
+#define GET_BCN_FILTER_NOTIFY_RSSI(c2h_payload)	(c2h_payload[2] - 100)
+
 /* PKT H2C */
 #define H2C_PKT_CMD_ID 0xFF
 #define H2C_PKT_CATEGORY 0x01
@@ -345,6 +366,8 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 #define H2C_CMD_LPS_PG_INFO		0x2b
 #define H2C_CMD_RA_INFO			0x40
 #define H2C_CMD_RSSI_MONITOR		0x42
+#define H2C_CMD_BCN_FILTER_OFFLOAD_P0	0x56
+#define H2C_CMD_BCN_FILTER_OFFLOAD_P1	0x57
 #define H2C_CMD_WL_PHY_INFO		0x58
 
 #define H2C_CMD_COEX_TDMA_TYPE		0x60
@@ -381,6 +404,20 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x01, value, GENMASK(15, 8))
 #define SET_WL_PHY_INFO_RX_EVM(h2c_pkt, value)				       \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x01, value, GENMASK(23, 16))
+#define SET_BCN_FILTER_OFFLOAD_P1_MACID(h2c_pkt, value)			       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(15, 8))
+#define SET_BCN_FILTER_OFFLOAD_P1_ENABLE(h2c_pkt, value)		       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(16))
+#define SET_BCN_FILTER_OFFLOAD_P1_HYST(h2c_pkt, value)			       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(20, 17))
+#define SET_BCN_FILTER_OFFLOAD_P1_OFFLOAD_MODE(h2c_pkt, value)		       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(23, 21))
+#define SET_BCN_FILTER_OFFLOAD_P1_THRESHOLD(h2c_pkt, value)		       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(31, 24))
+#define SET_BCN_FILTER_OFFLOAD_P1_BCN_LOSS_CNT(h2c_pkt, value)		       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x01, value, GENMASK(3, 0))
+#define SET_BCN_FILTER_OFFLOAD_P1_BCN_INTERVAL(h2c_pkt, value)		       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x01, value, GENMASK(13, 4))
 
 #define SET_PWR_MODE_SET_MODE(h2c_pkt, value)                                  \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(14, 8))
@@ -577,6 +614,8 @@ void rtw_fw_send_rssi_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si);
 void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si);
 void rtw_fw_media_status_report(struct rtw_dev *rtwdev, u8 mac_id, bool conn);
 void rtw_fw_update_wl_phy_info(struct rtw_dev *rtwdev);
+void rtw_fw_beacon_filter_config(struct rtw_dev *rtwdev, bool connect,
+				 struct ieee80211_vif *vif);
 int rtw_fw_write_data_rsvd_page(struct rtw_dev *rtwdev, u16 pg_addr,
 				u8 *buf, u32 size);
 void rtw_remove_rsvd_page(struct rtw_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 333df6b38113..9087c5b1ea80 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -148,11 +148,15 @@ static int rtw_ops_add_interface(struct ieee80211_hw *hw,
 {
 	struct rtw_dev *rtwdev = hw->priv;
 	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
+	struct rtw_fw_state *fw = &rtwdev->fw;
 	enum rtw_net_type net_type;
 	u32 config = 0;
 	u8 port = 0;
 	u8 bcn_ctrl = 0;
 
+	if (fw->feature & FW_FEATURE_BCN_FILTER)
+		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER |
+				     IEEE80211_VIF_SUPPORTS_CQM_RSSI;
 	rtwvif->port = port;
 	rtwvif->stats.tx_unicast = 0;
 	rtwvif->stats.rx_unicast = 0;
@@ -399,6 +403,8 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 			rtw_write32_clr(rtwdev, REG_FWHW_TXQ_CTRL,
 					BIT_EN_BCNQ_DL);
 	}
+	if (changed & BSS_CHANGED_CQM)
+		rtw_fw_beacon_filter_config(rtwdev, true, vif);
 
 	if (changed & BSS_CHANGED_MU_GROUPS)
 		rtw_chip_set_gid_table(rtwdev, vif, conf);
@@ -450,6 +456,7 @@ static int rtw_ops_sta_remove(struct ieee80211_hw *hw,
 {
 	struct rtw_dev *rtwdev = hw->priv;
 
+	rtw_fw_beacon_filter_config(rtwdev, false, vif);
 	mutex_lock(&rtwdev->mutex);
 	rtw_sta_remove(rtwdev, sta, true);
 	mutex_unlock(&rtwdev->mutex);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index f3a3a86fa9b5..94fadef5c131 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -239,7 +239,8 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	 * get that vif and check if device is having traffic more than the
 	 * threshold.
 	 */
-	if (rtwdev->ps_enabled && data.rtwvif && !ps_active)
+	if (rtwdev->ps_enabled && data.rtwvif && !ps_active &&
+	    !rtwdev->beacon_loss)
 		rtw_enter_lps(rtwdev, data.rtwvif->port);
 
 	rtwdev->watch_dog_cnt++;
@@ -292,6 +293,7 @@ int rtw_sta_add(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 	rtw_fw_media_status_report(rtwdev, si->mac_id, true);
 
 	rtwdev->sta_cnt++;
+	rtwdev->beacon_loss = false;
 	rtw_info(rtwdev, "sta %pM joined with macid %d\n",
 		 sta->addr, si->mac_id);
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index dc3744847ba9..321667c03b16 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1837,6 +1837,7 @@ struct rtw_dev {
 	/* lps power state & handler work */
 	struct rtw_lps_conf lps_conf;
 	bool ps_enabled;
+	bool beacon_loss;
 	struct completion lps_leave_check;
 
 	struct dentry *debugfs;
-- 
2.21.0

