Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752403804BC
	for <lists+linux-wireless@lfdr.de>; Fri, 14 May 2021 09:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhENH4x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 May 2021 03:56:53 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:42835 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbhENH4w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 May 2021 03:56:52 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 14E7tanI7027727, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 14E7tanI7027727
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 14 May 2021 15:55:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 14 May 2021 15:55:35 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 14 May
 2021 15:55:34 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>
Subject: [PATCH 2/2] rtw88: notify fw when driver in scan-period to avoid potential problem
Date:   Fri, 14 May 2021 15:55:17 +0800
Message-ID: <20210514075517.14216-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210514075517.14216-1-pkshih@realtek.com>
References: <20210514075517.14216-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzUvMTQgpFekyCAwNjowMDowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 05/14/2021 07:33:30
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163650 [May 14 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, headers_charset}
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/14/2021 07:36:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 05/14/2021 07:43:34
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163650 [May 14 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/14/2021 07:46:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

It is found that driver scan could be affected by dynamic mechanism
of firmware, so we notify firmware to stop it in the scan period.
Another, firmware will detect the background noise and report to
driver for further use.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c       | 25 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/fw.h       | 10 +++++++-
 drivers/net/wireless/realtek/rtw88/mac80211.c |  3 +++
 drivers/net/wireless/realtek/rtw88/main.c     | 17 +++++++++++++
 drivers/net/wireless/realtek/rtw88/main.h     |  4 +++
 5 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 00c56ab6306b..58f4e47aa96a 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -172,6 +172,17 @@ static void rtw_fw_bcn_filter_notify(struct rtw_dev *rtwdev, u8 *payload,
 			 &dev_iter_data);
 }
 
+static void rtw_fw_scan_result(struct rtw_dev *rtwdev, u8 *payload,
+			       u8 length)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+
+	dm_info->scan_density = payload[0];
+
+	rtw_dbg(rtwdev, RTW_DBG_FW, "scan.density = %x\n",
+		dm_info->scan_density);
+}
+
 void rtw_fw_c2h_cmd_handle(struct rtw_dev *rtwdev, struct sk_buff *skb)
 {
 	struct rtw_c2h_cmd *c2h;
@@ -235,6 +246,10 @@ void rtw_fw_c2h_cmd_rx_irqsafe(struct rtw_dev *rtwdev, u32 pkt_offset,
 	case C2H_WLAN_RFON:
 		complete(&rtwdev->lps_leave_check);
 		break;
+	case C2H_SCAN_RESULT:
+		complete(&rtwdev->fw_scan_density);
+		rtw_fw_scan_result(rtwdev, c2h->payload, len);
+		break;
 	default:
 		/* pass offset for further operation */
 		*((u32 *)skb->cb) = pkt_offset;
@@ -1703,3 +1718,13 @@ void rtw_fw_channel_switch(struct rtw_dev *rtwdev, bool enable)
 
 	rtw_fw_send_h2c_packet(rtwdev, h2c_pkt);
 }
+
+void rtw_fw_scan_notify(struct rtw_dev *rtwdev, bool start)
+{
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_SCAN);
+	SET_SCAN_START(h2c_pkt, start);
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 832ef2bfe5f9..a8a7162fbe64 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -30,6 +30,8 @@
 #define BCN_FILTER_CONNECTED		2
 #define BCN_FILTER_NOTIFY_BEACON_LOSS	3
 
+#define SCAN_NOTIFY_TIMEOUT  msecs_to_jiffies(10)
+
 enum rtw_c2h_cmd_id {
 	C2H_CCX_TX_RPT = 0x03,
 	C2H_BT_INFO = 0x09,
@@ -39,6 +41,7 @@ enum rtw_c2h_cmd_id {
 	C2H_WLAN_INFO = 0x27,
 	C2H_WLAN_RFON = 0x32,
 	C2H_BCN_FILTER_NOTIFY = 0x36,
+	C2H_SCAN_RESULT = 0x38,
 	C2H_HW_FEATURE_DUMP = 0xfd,
 	C2H_HALMAC = 0xff,
 };
@@ -86,6 +89,7 @@ enum rtw_fw_feature {
 	FW_FEATURE_LCLK = BIT(2),
 	FW_FEATURE_PG = BIT(3),
 	FW_FEATURE_BCN_FILTER = BIT(5),
+	FW_FEATURE_NOTIFY_SCAN = BIT(6),
 	FW_FEATURE_MAX = BIT(31),
 };
 
@@ -369,6 +373,7 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 #define H2C_CMD_BCN_FILTER_OFFLOAD_P0	0x56
 #define H2C_CMD_BCN_FILTER_OFFLOAD_P1	0x57
 #define H2C_CMD_WL_PHY_INFO		0x58
+#define H2C_CMD_SCAN			0x59
 
 #define H2C_CMD_COEX_TDMA_TYPE		0x60
 #define H2C_CMD_QUERY_BT_INFO		0x61
@@ -419,6 +424,9 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 #define SET_BCN_FILTER_OFFLOAD_P1_BCN_INTERVAL(h2c_pkt, value)		       \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x01, value, GENMASK(13, 4))
 
+#define SET_SCAN_START(h2c_pkt, value)					       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(8))
+
 #define SET_PWR_MODE_SET_MODE(h2c_pkt, value)                                  \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(14, 8))
 #define SET_PWR_MODE_SET_RLBM(h2c_pkt, value)                                  \
@@ -652,5 +660,5 @@ void rtw_fw_h2c_cmd_dbg(struct rtw_dev *rtwdev, u8 *h2c);
 void rtw_fw_c2h_cmd_isr(struct rtw_dev *rtwdev);
 int rtw_fw_dump_fifo(struct rtw_dev *rtwdev, u8 fifo_sel, u32 addr, u32 size,
 		     u32 *buffer);
-
+void rtw_fw_scan_notify(struct rtw_dev *rtwdev, bool start);
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 8f46b16c8d5d..8a180c95e7e6 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -605,6 +605,7 @@ static void rtw_ops_sw_scan_start(struct ieee80211_hw *hw,
 	rtw_vif_port_config(rtwdev, rtwvif, config);
 
 	rtw_coex_scan_notify(rtwdev, COEX_SCAN_START);
+	rtw_core_fw_scan_notify(rtwdev, true);
 
 	set_bit(RTW_FLAG_DIG_DISABLE, rtwdev->flags);
 	set_bit(RTW_FLAG_SCANNING, rtwdev->flags);
@@ -624,6 +625,8 @@ static void rtw_ops_sw_scan_complete(struct ieee80211_hw *hw,
 	clear_bit(RTW_FLAG_SCANNING, rtwdev->flags);
 	clear_bit(RTW_FLAG_DIG_DISABLE, rtwdev->flags);
 
+	rtw_core_fw_scan_notify(rtwdev, false);
+
 	ether_addr_copy(rtwvif->mac_addr, vif->addr);
 	config |= PORT_SET_MAC_ADDR;
 	rtw_vif_port_config(rtwdev, rtwvif, config);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index df115bb7fdf7..47f4838d0c58 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1185,6 +1185,22 @@ static int rtw_power_on(struct rtw_dev *rtwdev)
 	return ret;
 }
 
+void rtw_core_fw_scan_notify(struct rtw_dev *rtwdev, bool start)
+{
+	if (!rtw_fw_feature_check(&rtwdev->fw, FW_FEATURE_NOTIFY_SCAN))
+		return;
+
+	if (start) {
+		rtw_fw_scan_notify(rtwdev, true);
+	} else {
+		reinit_completion(&rtwdev->fw_scan_density);
+		rtw_fw_scan_notify(rtwdev, false);
+		if (!wait_for_completion_timeout(&rtwdev->fw_scan_density,
+						 SCAN_NOTIFY_TIMEOUT))
+			rtw_warn(rtwdev, "firmware failed to report density after scan\n");
+	}
+}
+
 int rtw_core_start(struct rtw_dev *rtwdev)
 {
 	int ret;
@@ -1763,6 +1779,7 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 
 	init_waitqueue_head(&rtwdev->coex.wait);
 	init_completion(&rtwdev->lps_leave_check);
+	init_completion(&rtwdev->fw_scan_density);
 
 	rtwdev->sec.total_cam_num = 32;
 	rtwdev->hal.current_channel = 1;
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 02ad175055cb..20b20a6db9cc 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1620,6 +1620,8 @@ struct rtw_dm_info {
 	struct rtw_iqk_info iqk;
 	struct rtw_gapk_info gapk;
 	bool is_bt_iqk_timeout;
+
+	u8 scan_density;
 };
 
 struct rtw_efuse {
@@ -1869,6 +1871,7 @@ struct rtw_dev {
 	struct rtw_wow_param wow;
 
 	bool need_rfk;
+	struct completion fw_scan_density;
 
 	/* hci related data, must be last */
 	u8 priv[] __aligned(sizeof(void *));
@@ -1974,6 +1977,7 @@ int rtw_sta_add(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 void rtw_sta_remove(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 		    bool fw_exist);
 void rtw_fw_recovery(struct rtw_dev *rtwdev);
+void rtw_core_fw_scan_notify(struct rtw_dev *rtwdev, bool start);
 int rtw_dump_fw(struct rtw_dev *rtwdev, const u32 ocp_src, u32 size,
 		const char *prefix_str);
 int rtw_dump_reg(struct rtw_dev *rtwdev, const u32 addr, const u32 size,
-- 
2.21.0

