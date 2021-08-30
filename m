Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6E43FB1D6
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Aug 2021 09:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhH3HWW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Aug 2021 03:22:22 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:46831 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbhH3HWU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Aug 2021 03:22:20 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 17U7LMfA4005173, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 17U7LMfA4005173
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Aug 2021 15:21:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 30 Aug 2021 15:21:21 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 30 Aug
 2021 15:21:21 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH v2 4/4] rtw88: move adaptivity mechanism to firmware
Date:   Mon, 30 Aug 2021 15:20:14 +0800
Message-ID: <20210830072014.12250-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210830072014.12250-1-pkshih@realtek.com>
References: <20210830072014.12250-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/30/2021 07:07:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzgvMzAgpFekyCAwNDoyMTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 08/30/2021 07:04:47
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165837 [Aug 30 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 457 457 f9912fc467375383fbac52a53ade5bbe1c769e2a
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/30/2021 07:07:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

Current adaptivity mechanism is achieved in driver, by periodically
referencing the IGI value and then updating related registers.
But we find that this way may halt TX activity too long if huge
and temporary energy is detected frequently. So we move the mechanism
to firmware for immediately reacting this case to recover TX rapidly.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/debug.h |  1 +
 drivers/net/wireless/realtek/rtw88/fw.c    | 47 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/fw.h    | 24 +++++++++++
 drivers/net/wireless/realtek/rtw88/phy.c   |  6 ++-
 drivers/net/wireless/realtek/rtw88/reg.h   |  3 ++
 5 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.h b/drivers/net/wireless/realtek/rtw88/debug.h
index 0dd3f9a88c8d..47c57f395f52 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.h
+++ b/drivers/net/wireless/realtek/rtw88/debug.h
@@ -21,6 +21,7 @@ enum rtw_debug_mask {
 	RTW_DBG_WOW		= 0x00001000,
 	RTW_DBG_CFO		= 0x00002000,
 	RTW_DBG_PATH_DIV	= 0x00004000,
+	RTW_DBG_ADAPTIVITY	= 0x00008000,
 
 	RTW_DBG_ALL		= 0xffffffff
 };
diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index e6399519584b..ccd8221ab264 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -183,6 +183,28 @@ static void rtw_fw_scan_result(struct rtw_dev *rtwdev, u8 *payload,
 		dm_info->scan_density);
 }
 
+static void rtw_fw_adaptivity_result(struct rtw_dev *rtwdev, u8 *payload,
+				     u8 length)
+{
+	struct rtw_hw_reg_offset *edcca_th = rtwdev->chip->edcca_th;
+	struct rtw_c2h_adaptivity *result = (struct rtw_c2h_adaptivity *)payload;
+
+	rtw_dbg(rtwdev, RTW_DBG_ADAPTIVITY,
+		"Adaptivity: density %x igi %x l2h_th_init %x l2h %x h2l %x option %x\n",
+		result->density, result->igi, result->l2h_th_init, result->l2h,
+		result->h2l, result->option);
+
+	rtw_dbg(rtwdev, RTW_DBG_ADAPTIVITY, "Reg Setting: L2H %x H2L %x\n",
+		rtw_read32_mask(rtwdev, edcca_th[EDCCA_TH_L2H_IDX].hw_reg.addr,
+				edcca_th[EDCCA_TH_L2H_IDX].hw_reg.mask),
+		rtw_read32_mask(rtwdev, edcca_th[EDCCA_TH_H2L_IDX].hw_reg.addr,
+				edcca_th[EDCCA_TH_H2L_IDX].hw_reg.mask));
+
+	rtw_dbg(rtwdev, RTW_DBG_ADAPTIVITY, "EDCCA Flag %s\n",
+		rtw_read32_mask(rtwdev, REG_EDCCA_REPORT, BIT_EDCCA_FLAG) ?
+		"Set" : "Unset");
+}
+
 void rtw_fw_c2h_cmd_handle(struct rtw_dev *rtwdev, struct sk_buff *skb)
 {
 	struct rtw_c2h_cmd *c2h;
@@ -252,6 +274,10 @@ void rtw_fw_c2h_cmd_rx_irqsafe(struct rtw_dev *rtwdev, u32 pkt_offset,
 		rtw_fw_scan_result(rtwdev, c2h->payload, len);
 		dev_kfree_skb_any(skb);
 		break;
+	case C2H_ADAPTIVITY:
+		rtw_fw_adaptivity_result(rtwdev, c2h->payload, len);
+		dev_kfree_skb_any(skb);
+		break;
 	default:
 		/* pass offset for further operation */
 		*((u32 *)skb->cb) = pkt_offset;
@@ -1722,6 +1748,27 @@ void rtw_fw_channel_switch(struct rtw_dev *rtwdev, bool enable)
 	rtw_fw_send_h2c_packet(rtwdev, h2c_pkt);
 }
 
+void rtw_fw_adaptivity(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+
+	if (!rtw_edcca_enabled) {
+		dm_info->edcca_mode = RTW_EDCCA_NORMAL;
+		rtw_dbg(rtwdev, RTW_DBG_ADAPTIVITY,
+			"EDCCA disabled by debugfs\n");
+	}
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_ADAPTIVITY);
+	SET_ADAPTIVITY_MODE(h2c_pkt, dm_info->edcca_mode);
+	SET_ADAPTIVITY_OPTION(h2c_pkt, 2);
+	SET_ADAPTIVITY_IGI(h2c_pkt, dm_info->igi_history[0]);
+	SET_ADAPTIVITY_L2H(h2c_pkt, dm_info->l2h_th_ini);
+	SET_ADAPTIVITY_DENSITY(h2c_pkt, dm_info->scan_density);
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
+
 void rtw_fw_scan_notify(struct rtw_dev *rtwdev, bool start)
 {
 	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 64dcde35a021..09c7afb99e63 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -41,6 +41,7 @@ enum rtw_c2h_cmd_id {
 	C2H_WLAN_INFO = 0x27,
 	C2H_WLAN_RFON = 0x32,
 	C2H_BCN_FILTER_NOTIFY = 0x36,
+	C2H_ADAPTIVITY = 0x37,
 	C2H_SCAN_RESULT = 0x38,
 	C2H_HW_FEATURE_DUMP = 0xfd,
 	C2H_HALMAC = 0xff,
@@ -56,6 +57,15 @@ struct rtw_c2h_cmd {
 	u8 payload[];
 } __packed;
 
+struct rtw_c2h_adaptivity {
+	u8 density;
+	u8 igi;
+	u8 l2h_th_init;
+	u8 l2h;
+	u8 h2l;
+	u8 option;
+} __packed;
+
 enum rtw_rsvd_packet_type {
 	RSVD_BEACON,
 	RSVD_DUMMY,
@@ -90,6 +100,7 @@ enum rtw_fw_feature {
 	FW_FEATURE_PG = BIT(3),
 	FW_FEATURE_BCN_FILTER = BIT(5),
 	FW_FEATURE_NOTIFY_SCAN = BIT(6),
+	FW_FEATURE_ADAPTIVITY = BIT(7),
 	FW_FEATURE_MAX = BIT(31),
 };
 
@@ -375,6 +386,7 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 #define H2C_CMD_BCN_FILTER_OFFLOAD_P1	0x57
 #define H2C_CMD_WL_PHY_INFO		0x58
 #define H2C_CMD_SCAN			0x59
+#define H2C_CMD_ADAPTIVITY		0x5A
 
 #define H2C_CMD_COEX_TDMA_TYPE		0x60
 #define H2C_CMD_QUERY_BT_INFO		0x61
@@ -428,6 +440,17 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 #define SET_SCAN_START(h2c_pkt, value)					       \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(8))
 
+#define SET_ADAPTIVITY_MODE(h2c_pkt, value)				       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(11, 8))
+#define SET_ADAPTIVITY_OPTION(h2c_pkt, value)				       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(15, 12))
+#define SET_ADAPTIVITY_IGI(h2c_pkt, value)				       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(23, 16))
+#define SET_ADAPTIVITY_L2H(h2c_pkt, value)				       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(31, 24))
+#define SET_ADAPTIVITY_DENSITY(h2c_pkt, value)				       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x01, value, GENMASK(7, 0))
+
 #define SET_PWR_MODE_SET_MODE(h2c_pkt, value)                                  \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(14, 8))
 #define SET_PWR_MODE_SET_RLBM(h2c_pkt, value)                                  \
@@ -662,4 +685,5 @@ void rtw_fw_c2h_cmd_isr(struct rtw_dev *rtwdev);
 int rtw_fw_dump_fifo(struct rtw_dev *rtwdev, u8 fifo_sel, u32 addr, u32 size,
 		     u32 *buffer);
 void rtw_fw_scan_notify(struct rtw_dev *rtwdev, bool start);
+void rtw_fw_adaptivity(struct rtw_dev *rtwdev);
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index e0daf12d2484..bfddfcbe63f5 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -770,7 +770,11 @@ void rtw_phy_dynamic_mechanism(struct rtw_dev *rtwdev)
 	rtw_phy_cfo_track(rtwdev);
 	rtw_phy_dpk_track(rtwdev);
 	rtw_phy_pwr_track(rtwdev);
-	rtw_phy_adaptivity(rtwdev);
+
+	if (rtw_fw_feature_check(&rtwdev->fw, FW_FEATURE_ADAPTIVITY))
+		rtw_fw_adaptivity(rtwdev);
+	else
+		rtw_phy_adaptivity(rtwdev);
 }
 
 #define FRAC_BITS 3
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 8adac30ee08e..abb7b490d8fa 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -642,6 +642,9 @@
 
 #define REG_HRCV_MSG	0x1cf
 
+#define REG_EDCCA_REPORT	0x2d38
+#define BIT_EDCCA_FLAG		BIT(24)
+
 #define REG_IGN_GNTBT4	0x4160
 
 #define RF_MODE		0x00
-- 
2.25.1

