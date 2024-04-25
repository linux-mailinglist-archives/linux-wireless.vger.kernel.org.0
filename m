Return-Path: <linux-wireless+bounces-6842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4CA8B2036
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 13:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92F19B2494B
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 11:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CAF83CCD;
	Thu, 25 Apr 2024 11:29:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFEC12A16C
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714044566; cv=none; b=vAwJKnAHXgNyEZDXWiZnwsp1jj5TX9bD3rAgfUDGd21CY9/7t7OiRp8IetMqwMR3Dg4K4hQIvDDw9JuP2NlCerFPMV+vOrW8jR97Hf2yTh32VuxHCfaM2qN/s4akbxozwbF89/9cuwdPWAUiOnL1GN6U0PG5gNiqTuHK1oF9dBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714044566; c=relaxed/simple;
	bh=8RjvWsmU9aPnLkeYK4Q0FJkCy7ACBKGqWBVljT7FDhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYHA+WP13n8lOifPKuR5GjNZLtmJ5myDGfuu5nDkZLSEC/CPVbng1gjz0Yl0jMCMbcr/PSq/C2A99n329FbWZj7qsc0EPvKX7B16A+ifMup9XCzAF+czr3FTxOBOUpYIjhoZQM56ZRyj+AqYI75yg9lZaz2HidTUsM3TmoLASVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43PBTMkU43482365, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43PBTMkU43482365
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 19:29:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 19:29:22 +0800
Received: from [127.0.1.1] (172.16.16.129) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 25 Apr
 2024 19:29:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>
Subject: [PATCH 09/12] wifi: rtw89: wow: update latest PTK GTK info to mac80211 after resume
Date: Thu, 25 Apr 2024 19:28:13 +0800
Message-ID: <20240425112816.26431-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240425112816.26431-1-pkshih@realtek.com>
References: <20240425112816.26431-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Chih-Kang Chang <gary.chang@realtek.com>

When resume we parse AOAC report from firmware using H2C and C2H
registers before enable interrupt, then update PTK RX PN and GTK RX PN.
After enable interrupt, we parse AOAC report using H2C and C2H commands,
then update PTK TX PN and update new GTK key info if GTK rekey during
suspend. Furthermore, We update pattern match index if wakeup by pattern.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  22 ++
 drivers/net/wireless/realtek/rtw89/fw.c   |  29 ++
 drivers/net/wireless/realtek/rtw89/fw.h   |  82 ++++-
 drivers/net/wireless/realtek/rtw89/mac.c  |  40 +++
 drivers/net/wireless/realtek/rtw89/mac.h  |   7 +
 drivers/net/wireless/realtek/rtw89/wow.c  | 355 +++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/wow.h  |   6 +
 7 files changed, 529 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index f4b439ec30fd..1aa25a3f3659 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5178,12 +5178,34 @@ struct rtw89_wow_gtk_info {
 	u8 psk[32];
 } __packed;
 
+struct rtw89_wow_aoac_report {
+	u8 rpt_ver;
+	u8 sec_type;
+	u8 key_idx;
+	u8 pattern_idx;
+	u8 rekey_ok;
+	u8 ptk_tx_iv[8];
+	u8 eapol_key_replay_count[8];
+	u8 gtk[32];
+	u8 ptk_rx_iv[8];
+	u8 gtk_rx_iv[4][8];
+	u64 igtk_key_id;
+	u64 igtk_ipn;
+	u8 igtk[32];
+	u8 csa_pri_ch;
+	u8 csa_bw;
+	u8 csa_ch_offset;
+	u8 csa_chsw_failed;
+	u8 csa_ch_band;
+};
+
 struct rtw89_wow_param {
 	struct ieee80211_vif *wow_vif;
 	DECLARE_BITMAP(flags, RTW89_WOW_FLAG_NUM);
 	struct rtw89_wow_cam_info patterns[RTW89_MAX_PATTERN_NUM];
 	struct rtw89_wow_key_info key_info;
 	struct rtw89_wow_gtk_info gtk_info;
+	struct rtw89_wow_aoac_report aoac_rpt;
 	u8 pattern_cnt;
 	u8 ptk_alg;
 	u8 gtk_alg;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index f47bdede6c62..50df25e6484d 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6612,6 +6612,35 @@ int rtw89_fw_h2c_wow_gtk_ofld(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+int rtw89_fw_h2c_wow_request_aoac(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_wait_info *wait = &rtwdev->mac.fw_ofld_wait;
+	struct rtw89_h2c_wow_aoac *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	unsigned int cond;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for aoac\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, len);
+
+	/* This H2C only nofity firmware to generate AOAC report C2H,
+	 * no need any parameter.
+	 */
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MAC_WOW,
+			      H2C_FUNC_AOAC_REPORT_REQ, 1, 0,
+			      len);
+
+	cond = RTW89_WOW_WAIT_COND(H2C_FUNC_AOAC_REPORT_REQ);
+	return rtw89_h2c_tx_and_wait(rtwdev, skb, wait, cond);
+}
+
 /* Return < 0, if failures happen during waiting for the condition.
  * Return 0, when waiting for the condition succeeds.
  * Return > 0, if the wait is considered unreachable due to driver/FW design,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 03cad18f2dac..5e51267558ad 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -48,6 +48,32 @@ struct rtw89_c2hreg_phycap {
 #define RTW89_C2HREG_PHYCAP_W3_ANT_TX_NUM GENMASK(15, 8)
 #define RTW89_C2HREG_PHYCAP_W3_ANT_RX_NUM GENMASK(23, 16)
 
+#define RTW89_C2HREG_AOAC_RPT_1_W0_KEY_IDX GENMASK(23, 16)
+#define RTW89_C2HREG_AOAC_RPT_1_W1_IV_0 GENMASK(7, 0)
+#define RTW89_C2HREG_AOAC_RPT_1_W1_IV_1 GENMASK(15, 8)
+#define RTW89_C2HREG_AOAC_RPT_1_W1_IV_2 GENMASK(23, 16)
+#define RTW89_C2HREG_AOAC_RPT_1_W1_IV_3 GENMASK(31, 24)
+#define RTW89_C2HREG_AOAC_RPT_1_W2_IV_4 GENMASK(7, 0)
+#define RTW89_C2HREG_AOAC_RPT_1_W2_IV_5 GENMASK(15, 8)
+#define RTW89_C2HREG_AOAC_RPT_1_W2_IV_6 GENMASK(23, 16)
+#define RTW89_C2HREG_AOAC_RPT_1_W2_IV_7 GENMASK(31, 24)
+#define RTW89_C2HREG_AOAC_RPT_1_W3_PTK_IV_0 GENMASK(7, 0)
+#define RTW89_C2HREG_AOAC_RPT_1_W3_PTK_IV_1 GENMASK(15, 8)
+#define RTW89_C2HREG_AOAC_RPT_1_W3_PTK_IV_2 GENMASK(23, 16)
+#define RTW89_C2HREG_AOAC_RPT_1_W3_PTK_IV_3 GENMASK(31, 24)
+#define RTW89_C2HREG_AOAC_RPT_2_W0_PTK_IV_4 GENMASK(23, 16)
+#define RTW89_C2HREG_AOAC_RPT_2_W0_PTK_IV_5 GENMASK(31, 24)
+#define RTW89_C2HREG_AOAC_RPT_2_W1_PTK_IV_6 GENMASK(7, 0)
+#define RTW89_C2HREG_AOAC_RPT_2_W1_PTK_IV_7 GENMASK(15, 8)
+#define RTW89_C2HREG_AOAC_RPT_2_W1_IGTK_IPN_IV_0 GENMASK(23, 16)
+#define RTW89_C2HREG_AOAC_RPT_2_W1_IGTK_IPN_IV_1 GENMASK(31, 24)
+#define RTW89_C2HREG_AOAC_RPT_2_W2_IGTK_IPN_IV_2 GENMASK(7, 0)
+#define RTW89_C2HREG_AOAC_RPT_2_W2_IGTK_IPN_IV_3 GENMASK(15, 8)
+#define RTW89_C2HREG_AOAC_RPT_2_W2_IGTK_IPN_IV_4 GENMASK(23, 16)
+#define RTW89_C2HREG_AOAC_RPT_2_W2_IGTK_IPN_IV_5 GENMASK(31, 24)
+#define RTW89_C2HREG_AOAC_RPT_2_W3_IGTK_IPN_IV_6 GENMASK(7, 0)
+#define RTW89_C2HREG_AOAC_RPT_2_W3_IGTK_IPN_IV_7 GENMASK(15, 8)
+
 struct rtw89_h2creg_hdr {
 	u32 w0;
 };
@@ -98,8 +124,11 @@ enum rtw89_mac_h2c_type {
 	RTW89_FWCMD_H2CREG_FUNC_GET_FEATURE,
 	RTW89_FWCMD_H2CREG_FUNC_GETPKT_INFORM,
 	RTW89_FWCMD_H2CREG_FUNC_SCH_TX_EN,
-	RTW89_FWCMD_H2CREG_FUNC_WOW_TRX_STOP = 0x6,
-	RTW89_FWCMD_H2CREG_FUNC_WOW_CPUIO_RX_CTRL = 0xA,
+	RTW89_FWCMD_H2CREG_FUNC_WOW_TRX_STOP,
+	RTW89_FWCMD_H2CREG_FUNC_AOAC_RPT_1,
+	RTW89_FWCMD_H2CREG_FUNC_AOAC_RPT_2,
+	RTW89_FWCMD_H2CREG_FUNC_AOAC_RPT_3_REQ,
+	RTW89_FWCMD_H2CREG_FUNC_WOW_CPUIO_RX_CTRL,
 };
 
 enum rtw89_mac_c2h_type {
@@ -3352,6 +3381,10 @@ struct rtw89_h2c_mrc_upd_duration {
 #define RTW89_H2C_MRC_UPD_DURATION_SLOT_SLOT_IDX GENMASK(7, 0)
 #define RTW89_H2C_MRC_UPD_DURATION_SLOT_DURATION GENMASK(31, 16)
 
+struct rtw89_h2c_wow_aoac {
+	__le32 w0;
+} __packed;
+
 #define RTW89_C2H_HEADER_LEN 8
 
 struct rtw89_c2h_hdr {
@@ -3580,6 +3613,30 @@ struct rtw89_c2h_pkt_ofld_rsp {
 #define RTW89_C2H_PKT_OFLD_RSP_W2_PTK_OP GENMASK(10, 8)
 #define RTW89_C2H_PKT_OFLD_RSP_W2_PTK_LEN GENMASK(31, 16)
 
+struct rtw89_c2h_wow_aoac_report {
+	struct rtw89_c2h_hdr c2h_hdr;
+	u8 rpt_ver;
+	u8 sec_type;
+	u8 key_idx;
+	u8 pattern_idx;
+	u8 rekey_ok;
+	u8 rsvd1[3];
+	u8 ptk_tx_iv[8];
+	u8 eapol_key_replay_count[8];
+	u8 gtk[32];
+	u8 ptk_rx_iv[8];
+	u8 gtk_rx_iv[4][8];
+	__le64 igtk_key_id;
+	__le64 igtk_ipn;
+	u8 igtk[32];
+	u8 csa_pri_ch;
+	u8 csa_bw_ch_offset;
+	u8 csa_ch_band_chsw_failed;
+	u8 csa_rsvd1;
+} __packed;
+
+#define RTW89_C2H_WOW_AOAC_RPT_REKEY_IDX BIT(0)
+
 struct rtw89_h2c_bcnfltr {
 	__le32 w0;
 } __packed;
@@ -3857,12 +3914,20 @@ struct rtw89_fw_h2c_rf_reg_info {
 
 /* CLASS 1 - WOW */
 #define H2C_CL_MAC_WOW			0x1
-#define H2C_FUNC_KEEP_ALIVE		0x0
-#define H2C_FUNC_DISCONNECT_DETECT	0x1
-#define H2C_FUNC_WOW_GLOBAL		0x2
-#define H2C_FUNC_GTK_OFLD		0x3
-#define H2C_FUNC_WAKEUP_CTRL		0x8
-#define H2C_FUNC_WOW_CAM_UPD		0xC
+enum rtw89_wow_h2c_func {
+	H2C_FUNC_KEEP_ALIVE		= 0x0,
+	H2C_FUNC_DISCONNECT_DETECT	= 0x1,
+	H2C_FUNC_WOW_GLOBAL		= 0x2,
+	H2C_FUNC_GTK_OFLD		= 0x3,
+	H2C_FUNC_WAKEUP_CTRL		= 0x8,
+	H2C_FUNC_WOW_CAM_UPD		= 0xC,
+	H2C_FUNC_AOAC_REPORT_REQ	= 0xD,
+
+	NUM_OF_RTW89_WOW_H2C_FUNC,
+};
+
+#define RTW89_WOW_WAIT_COND(func) \
+	(NUM_OF_RTW89_WOW_H2C_FUNC + (func))
 
 /* CLASS 2 - PS */
 #define H2C_CL_MAC_PS			0x2
@@ -4382,6 +4447,7 @@ int rtw89_fw_wow_cam_update(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_wow_gtk_ofld(struct rtw89_dev *rtwdev,
 			      struct rtw89_vif *rtwvif,
 			      bool enable);
+int rtw89_fw_h2c_wow_request_aoac(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_add_mcc(struct rtw89_dev *rtwdev,
 			 const struct rtw89_fw_mcc_add_req *p);
 int rtw89_fw_h2c_start_mcc(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 8b34044f7a8a..2d9983592223 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5131,6 +5131,34 @@ rtw89_mac_c2h_mrc_tsf_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len
 	rtw89_complete_cond(wait, RTW89_MRC_WAIT_COND_REQ_TSF, &data);
 }
 
+static void
+rtw89_mac_c2h_wow_aoac_rpt(struct rtw89_dev *rtwdev, struct sk_buff *skb, u32 len)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw89_wow_aoac_report *aoac_rpt = &rtw_wow->aoac_rpt;
+	struct rtw89_wait_info *wait = &rtwdev->mac.fw_ofld_wait;
+	const struct rtw89_c2h_wow_aoac_report *c2h =
+		(const struct rtw89_c2h_wow_aoac_report *)skb->data;
+	struct rtw89_completion_data data = {};
+	unsigned int cond;
+
+	aoac_rpt->rpt_ver = c2h->rpt_ver;
+	aoac_rpt->sec_type = c2h->sec_type;
+	aoac_rpt->key_idx = c2h->key_idx;
+	aoac_rpt->pattern_idx = c2h->pattern_idx;
+	aoac_rpt->rekey_ok = u8_get_bits(c2h->rekey_ok,
+					 RTW89_C2H_WOW_AOAC_RPT_REKEY_IDX);
+	memcpy(aoac_rpt->ptk_tx_iv, c2h->ptk_tx_iv, sizeof(aoac_rpt->ptk_tx_iv));
+	memcpy(aoac_rpt->eapol_key_replay_count, c2h->eapol_key_replay_count,
+	       sizeof(aoac_rpt->eapol_key_replay_count));
+	memcpy(aoac_rpt->gtk, c2h->gtk, sizeof(aoac_rpt->gtk));
+	memcpy(aoac_rpt->ptk_rx_iv, c2h->ptk_rx_iv, sizeof(aoac_rpt->ptk_rx_iv));
+	memcpy(aoac_rpt->gtk_rx_iv, c2h->gtk_rx_iv, sizeof(aoac_rpt->gtk_rx_iv));
+
+	cond = RTW89_WOW_WAIT_COND(H2C_FUNC_AOAC_REPORT_REQ);
+	rtw89_complete_cond(wait, cond, &data);
+}
+
 static void
 rtw89_mac_c2h_mrc_status_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
@@ -5218,6 +5246,12 @@ void (* const rtw89_mac_c2h_mrc_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_MAC_C2H_FUNC_MRC_STATUS_RPT] = rtw89_mac_c2h_mrc_status_rpt,
 };
 
+static
+void (* const rtw89_mac_c2h_wow_handler[])(struct rtw89_dev *rtwdev,
+					   struct sk_buff *c2h, u32 len) = {
+	[RTW89_MAC_C2H_FUNC_AOAC_REPORT] = rtw89_mac_c2h_wow_aoac_rpt,
+};
+
 static void rtw89_mac_c2h_scanofld_rsp_atomic(struct rtw89_dev *rtwdev,
 					      struct sk_buff *skb)
 {
@@ -5270,6 +5304,8 @@ bool rtw89_mac_c2h_chk_atomic(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 		return true;
 	case RTW89_MAC_C2H_CLASS_MRC:
 		return true;
+	case RTW89_MAC_C2H_CLASS_WOW:
+		return true;
 	}
 }
 
@@ -5296,6 +5332,10 @@ void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 		if (func < NUM_OF_RTW89_MAC_C2H_FUNC_MRC)
 			handler = rtw89_mac_c2h_mrc_handler[func];
 		break;
+	case RTW89_MAC_C2H_CLASS_WOW:
+		if (func < NUM_OF_RTW89_MAC_C2H_FUNC_WOW)
+			handler = rtw89_mac_c2h_wow_handler[func];
+		break;
 	case RTW89_MAC_C2H_CLASS_FWDBG:
 		return;
 	default:
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 6fb457153a11..a580cb719233 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -419,6 +419,13 @@ enum rtw89_mac_c2h_mrc_func {
 	NUM_OF_RTW89_MAC_C2H_FUNC_MRC,
 };
 
+enum rtw89_mac_c2h_wow_func {
+	RTW89_MAC_C2H_FUNC_AOAC_REPORT,
+	RTW89_MAC_C2H_FUNC_READ_WOW_CAM,
+
+	NUM_OF_RTW89_MAC_C2H_FUNC_WOW,
+};
+
 enum rtw89_mac_c2h_class {
 	RTW89_MAC_C2H_CLASS_INFO = 0x0,
 	RTW89_MAC_C2H_CLASS_OFLD = 0x1,
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 3fb352f65e67..a930a3054325 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -128,6 +128,81 @@ static int rtw89_tx_pn_to_iv(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static int _iv_to_pn(struct rtw89_dev *rtwdev, u8 *iv, u64 *pn, u8 *key_id,
+		     struct ieee80211_key_conf *key)
+{
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_TKIP:
+		*pn = u64_encode_bits(iv[2], RTW89_KEY_PN_0) |
+		      u64_encode_bits(iv[0], RTW89_KEY_PN_1);
+		break;
+	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_CCMP_256:
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		*pn = u64_encode_bits(iv[0], RTW89_KEY_PN_0) |
+		      u64_encode_bits(iv[1], RTW89_KEY_PN_1);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	*pn |= u64_encode_bits(iv[4], RTW89_KEY_PN_2) |
+	       u64_encode_bits(iv[5], RTW89_KEY_PN_3) |
+	       u64_encode_bits(iv[6], RTW89_KEY_PN_4) |
+	       u64_encode_bits(iv[7], RTW89_KEY_PN_5);
+
+	if (key_id)
+		*key_id = *(iv + 3) >> 6;
+
+	return 0;
+}
+
+static int rtw89_rx_iv_to_pn(struct rtw89_dev *rtwdev,
+			     struct ieee80211_key_conf *key,
+			     u8 *iv)
+{
+	struct ieee80211_key_seq seq;
+	int err;
+	u64 pn;
+
+	err = _iv_to_pn(rtwdev, iv, &pn, NULL, key);
+	if (err)
+		return err;
+
+	/* seq.ccmp.pn[] is BE order array */
+	seq.ccmp.pn[0] = u64_get_bits(pn, RTW89_KEY_PN_5);
+	seq.ccmp.pn[1] = u64_get_bits(pn, RTW89_KEY_PN_4);
+	seq.ccmp.pn[2] = u64_get_bits(pn, RTW89_KEY_PN_3);
+	seq.ccmp.pn[3] = u64_get_bits(pn, RTW89_KEY_PN_2);
+	seq.ccmp.pn[4] = u64_get_bits(pn, RTW89_KEY_PN_1);
+	seq.ccmp.pn[5] = u64_get_bits(pn, RTW89_KEY_PN_0);
+
+	ieee80211_set_key_rx_seq(key, 0, &seq);
+	rtw89_debug(rtwdev, RTW89_DBG_WOW, "%s key %d iv-%*ph to pn-%*ph\n",
+		    __func__, key->keyidx, 8, iv, 6, seq.ccmp.pn);
+
+	return 0;
+}
+
+static int rtw89_tx_iv_to_pn(struct rtw89_dev *rtwdev,
+			     struct ieee80211_key_conf *key,
+			     u8 *iv)
+{
+	int err;
+	u64 pn;
+
+	err = _iv_to_pn(rtwdev, iv, &pn, NULL, key);
+	if (err)
+		return err;
+
+	atomic64_set(&key->tx_pn, pn);
+	rtw89_debug(rtwdev, RTW89_DBG_WOW, "%s key %d iv-%*ph to pn-%llx\n",
+		    __func__, key->keyidx, 8, iv, pn);
+
+	return 0;
+}
+
 static void rtw89_wow_get_key_info_iter(struct ieee80211_hw *hw,
 					struct ieee80211_vif *vif,
 					struct ieee80211_sta *sta,
@@ -182,10 +257,67 @@ static void rtw89_wow_get_key_info_iter(struct ieee80211_hw *hw,
 	*err = true;
 }
 
+static void rtw89_wow_set_key_info_iter(struct ieee80211_hw *hw,
+					struct ieee80211_vif *vif,
+					struct ieee80211_sta *sta,
+					struct ieee80211_key_conf *key,
+					void *data)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw89_wow_aoac_report *aoac_rpt = &rtw_wow->aoac_rpt;
+	struct rtw89_set_key_info_iter_data *iter_data = data;
+	bool update_tx_key_info = iter_data->rx_ready;
+	int ret;
+
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_TKIP:
+	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_CCMP_256:
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		if (sta && !update_tx_key_info) {
+			ret = rtw89_rx_iv_to_pn(rtwdev, key,
+						aoac_rpt->ptk_rx_iv);
+			if (ret)
+				goto err;
+		}
+
+		if (sta && update_tx_key_info) {
+			ret = rtw89_tx_iv_to_pn(rtwdev, key,
+						aoac_rpt->ptk_tx_iv);
+			if (ret)
+				goto err;
+		}
+
+		if (!sta && !update_tx_key_info) {
+			ret = rtw89_rx_iv_to_pn(rtwdev, key,
+						aoac_rpt->gtk_rx_iv[key->keyidx]);
+			if (ret)
+				goto err;
+		}
+
+		if (!sta && update_tx_key_info && aoac_rpt->rekey_ok)
+			iter_data->gtk_cipher = key->cipher;
+		break;
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_WOW, "unsupport cipher %x\n",
+			    key->cipher);
+		goto err;
+	}
+
+	return;
+
+err:
+	iter_data->error = true;
+}
+
 static void rtw89_wow_key_clear(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 
+	memset(&rtw_wow->aoac_rpt, 0, sizeof(rtw_wow->aoac_rpt));
+	memset(&rtw_wow->gtk_info, 0, sizeof(rtw_wow->gtk_info));
 	memset(&rtw_wow->key_info, 0, sizeof(rtw_wow->key_info));
 	rtw_wow->ptk_alg = 0;
 	rtw_wow->gtk_alg = 0;
@@ -213,6 +345,206 @@ static void rtw89_wow_construct_key_info(struct rtw89_dev *rtwdev)
 				    RTW89_WOW_SYMBOL_CHK_GTK;
 }
 
+static void rtw89_wow_debug_aoac_rpt(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw89_wow_aoac_report *aoac_rpt = &rtw_wow->aoac_rpt;
+
+	if (!rtw89_debug_is_enabled(rtwdev, RTW89_DBG_WOW))
+		return;
+
+	rtw89_debug(rtwdev, RTW89_DBG_WOW, "[aoac_rpt] rpt_ver = %d\n",
+		    aoac_rpt->rpt_ver);
+	rtw89_debug(rtwdev, RTW89_DBG_WOW, "[aoac_rpt] sec_type = %d\n",
+		    aoac_rpt->sec_type);
+	rtw89_debug(rtwdev, RTW89_DBG_WOW, "[aoac_rpt] key_idx = %d\n",
+		    aoac_rpt->key_idx);
+	rtw89_debug(rtwdev, RTW89_DBG_WOW, "[aoac_rpt] pattern_idx = %d\n",
+		    aoac_rpt->pattern_idx);
+	rtw89_debug(rtwdev, RTW89_DBG_WOW, "[aoac_rpt] rekey_ok = %d\n",
+		    aoac_rpt->rekey_ok);
+	rtw89_debug(rtwdev, RTW89_DBG_WOW, "[aoac_rpt] ptk_tx_iv = %*ph\n",
+		    8, aoac_rpt->ptk_tx_iv);
+	rtw89_debug(rtwdev, RTW89_DBG_WOW,
+		    "[aoac_rpt] eapol_key_replay_count = %*ph\n",
+		    8, aoac_rpt->eapol_key_replay_count);
+	rtw89_debug(rtwdev, RTW89_DBG_WOW, "[aoac_rpt] ptk_rx_iv = %*ph\n",
+		    8, aoac_rpt->ptk_rx_iv);
+	rtw89_debug(rtwdev, RTW89_DBG_WOW, "[aoac_rpt] gtk_rx_iv[0] = %*ph\n",
+		    8, aoac_rpt->gtk_rx_iv[0]);
+	rtw89_debug(rtwdev, RTW89_DBG_WOW, "[aoac_rpt] gtk_rx_iv[1] = %*ph\n",
+		    8, aoac_rpt->gtk_rx_iv[1]);
+	rtw89_debug(rtwdev, RTW89_DBG_WOW, "[aoac_rpt] gtk_rx_iv[2] = %*ph\n",
+		    8, aoac_rpt->gtk_rx_iv[2]);
+	rtw89_debug(rtwdev, RTW89_DBG_WOW, "[aoac_rpt] gtk_rx_iv[3] = %*ph\n",
+		    8, aoac_rpt->gtk_rx_iv[3]);
+	rtw89_debug(rtwdev, RTW89_DBG_WOW, "[aoac_rpt] igtk_key_id = %llu\n",
+		    aoac_rpt->igtk_key_id);
+	rtw89_debug(rtwdev, RTW89_DBG_WOW, "[aoac_rpt] igtk_ipn = %llu\n",
+		    aoac_rpt->igtk_ipn);
+	rtw89_debug(rtwdev, RTW89_DBG_WOW, "[aoac_rpt] igtk = %*ph\n",
+		    32, aoac_rpt->igtk);
+}
+
+static int rtw89_wow_get_aoac_rpt_reg(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw89_wow_aoac_report *aoac_rpt = &rtw_wow->aoac_rpt;
+	struct rtw89_mac_c2h_info c2h_info = {};
+	struct rtw89_mac_h2c_info h2c_info = {};
+	u8 key_idx;
+	int ret;
+
+	h2c_info.id = RTW89_FWCMD_H2CREG_FUNC_AOAC_RPT_1;
+	h2c_info.content_len = 2;
+	ret = rtw89_fw_msg_reg(rtwdev, &h2c_info, &c2h_info);
+	if (ret)
+		return ret;
+
+	aoac_rpt->key_idx =
+		u32_get_bits(c2h_info.u.c2hreg[0], RTW89_C2HREG_AOAC_RPT_1_W0_KEY_IDX);
+	key_idx = aoac_rpt->key_idx;
+	aoac_rpt->gtk_rx_iv[key_idx][0] =
+		u32_get_bits(c2h_info.u.c2hreg[1], RTW89_C2HREG_AOAC_RPT_1_W1_IV_0);
+	aoac_rpt->gtk_rx_iv[key_idx][1] =
+		u32_get_bits(c2h_info.u.c2hreg[1], RTW89_C2HREG_AOAC_RPT_1_W1_IV_1);
+	aoac_rpt->gtk_rx_iv[key_idx][2] =
+		u32_get_bits(c2h_info.u.c2hreg[1], RTW89_C2HREG_AOAC_RPT_1_W1_IV_2);
+	aoac_rpt->gtk_rx_iv[key_idx][3] =
+		u32_get_bits(c2h_info.u.c2hreg[1], RTW89_C2HREG_AOAC_RPT_1_W1_IV_3);
+	aoac_rpt->gtk_rx_iv[key_idx][4] =
+		u32_get_bits(c2h_info.u.c2hreg[2], RTW89_C2HREG_AOAC_RPT_1_W2_IV_4);
+	aoac_rpt->gtk_rx_iv[key_idx][5] =
+		u32_get_bits(c2h_info.u.c2hreg[2], RTW89_C2HREG_AOAC_RPT_1_W2_IV_5);
+	aoac_rpt->gtk_rx_iv[key_idx][6] =
+		u32_get_bits(c2h_info.u.c2hreg[2], RTW89_C2HREG_AOAC_RPT_1_W2_IV_6);
+	aoac_rpt->gtk_rx_iv[key_idx][7] =
+		u32_get_bits(c2h_info.u.c2hreg[2], RTW89_C2HREG_AOAC_RPT_1_W2_IV_7);
+	aoac_rpt->ptk_rx_iv[0] =
+		u32_get_bits(c2h_info.u.c2hreg[3], RTW89_C2HREG_AOAC_RPT_1_W3_PTK_IV_0);
+	aoac_rpt->ptk_rx_iv[1] =
+		u32_get_bits(c2h_info.u.c2hreg[3], RTW89_C2HREG_AOAC_RPT_1_W3_PTK_IV_1);
+	aoac_rpt->ptk_rx_iv[2] =
+		u32_get_bits(c2h_info.u.c2hreg[3], RTW89_C2HREG_AOAC_RPT_1_W3_PTK_IV_2);
+	aoac_rpt->ptk_rx_iv[3] =
+		u32_get_bits(c2h_info.u.c2hreg[3], RTW89_C2HREG_AOAC_RPT_1_W3_PTK_IV_3);
+
+	h2c_info.id = RTW89_FWCMD_H2CREG_FUNC_AOAC_RPT_2;
+	h2c_info.content_len = 2;
+	ret = rtw89_fw_msg_reg(rtwdev, &h2c_info, &c2h_info);
+	if (ret)
+		return ret;
+
+	aoac_rpt->ptk_rx_iv[4] =
+		u32_get_bits(c2h_info.u.c2hreg[0], RTW89_C2HREG_AOAC_RPT_2_W0_PTK_IV_4);
+	aoac_rpt->ptk_rx_iv[5] =
+		u32_get_bits(c2h_info.u.c2hreg[0], RTW89_C2HREG_AOAC_RPT_2_W0_PTK_IV_5);
+	aoac_rpt->ptk_rx_iv[6] =
+		u32_get_bits(c2h_info.u.c2hreg[1], RTW89_C2HREG_AOAC_RPT_2_W1_PTK_IV_6);
+	aoac_rpt->ptk_rx_iv[7] =
+		u32_get_bits(c2h_info.u.c2hreg[1], RTW89_C2HREG_AOAC_RPT_2_W1_PTK_IV_7);
+
+	return 0;
+}
+
+static int rtw89_wow_get_aoac_rpt(struct rtw89_dev *rtwdev, bool rx_ready)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	int ret;
+
+	if (!rtw_wow->ptk_alg)
+		return -EPERM;
+
+	if (!rx_ready) {
+		ret = rtw89_wow_get_aoac_rpt_reg(rtwdev);
+		if (ret) {
+			rtw89_err(rtwdev, "wow: failed to get aoac rpt by reg\n");
+			return ret;
+		}
+	} else {
+		ret = rtw89_fw_h2c_wow_request_aoac(rtwdev);
+		if (ret) {
+			rtw89_err(rtwdev, "wow: failed to get aoac rpt by pkt\n");
+			return ret;
+		}
+	}
+
+	rtw89_wow_debug_aoac_rpt(rtwdev);
+
+	return 0;
+}
+
+static struct ieee80211_key_conf *rtw89_wow_gtk_rekey(struct rtw89_dev *rtwdev,
+						      u32 cipher, u8 keyidx, u8 *gtk)
+{
+	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
+	const struct rtw89_cipher_info *cipher_info;
+	struct ieee80211_key_conf *rekey_conf;
+	struct ieee80211_key_conf *key;
+	u8 sz;
+
+	cipher_info = rtw89_cipher_alg_recognize(cipher);
+	sz = struct_size(rekey_conf, key, cipher_info->len);
+	rekey_conf = kmalloc(sz, GFP_KERNEL);
+	if (!rekey_conf)
+		return NULL;
+
+	rekey_conf->cipher = cipher;
+	rekey_conf->keyidx = keyidx;
+	rekey_conf->keylen = cipher_info->len;
+	memcpy(rekey_conf->key, gtk,
+	       flex_array_size(rekey_conf, key, cipher_info->len));
+
+	/* ieee80211_gtk_rekey_add() will call set_key(), therefore we
+	 * need to unlock mutex
+	 */
+	mutex_unlock(&rtwdev->mutex);
+	key = ieee80211_gtk_rekey_add(wow_vif, rekey_conf, -1);
+	mutex_lock(&rtwdev->mutex);
+
+	kfree(rekey_conf);
+	if (IS_ERR(key)) {
+		rtw89_err(rtwdev, "ieee80211_gtk_rekey_add failed\n");
+		return NULL;
+	}
+
+	return key;
+}
+
+static void rtw89_wow_update_key_info(struct rtw89_dev *rtwdev, bool rx_ready)
+{
+	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw89_wow_aoac_report *aoac_rpt = &rtw_wow->aoac_rpt;
+	struct rtw89_set_key_info_iter_data data = {.error = false,
+						    .rx_ready = rx_ready};
+	struct ieee80211_key_conf *key;
+
+	rcu_read_lock();
+	ieee80211_iter_keys_rcu(rtwdev->hw, wow_vif,
+				rtw89_wow_set_key_info_iter, &data);
+	rcu_read_unlock();
+
+	if (data.error) {
+		rtw89_debug(rtwdev, RTW89_DBG_WOW, "%s error\n", __func__);
+		return;
+	}
+
+	if (!data.gtk_cipher)
+		return;
+
+	key = rtw89_wow_gtk_rekey(rtwdev, data.gtk_cipher, aoac_rpt->key_idx,
+				  aoac_rpt->gtk);
+	if (!key)
+		return;
+
+	rtw89_rx_iv_to_pn(rtwdev, key,
+			  aoac_rpt->gtk_rx_iv[key->keyidx]);
+	ieee80211_gtk_rekey_notify(wow_vif, wow_vif->bss_conf.bssid,
+				   aoac_rpt->eapol_key_replay_count,
+				   GFP_KERNEL);
+}
+
 static void rtw89_wow_leave_deep_ps(struct rtw89_dev *rtwdev)
 {
 	__rtw89_leave_ps_mode(rtwdev);
@@ -260,6 +592,8 @@ static void rtw89_wow_set_rx_filter(struct rtw89_dev *rtwdev, bool enable)
 
 static void rtw89_wow_show_wakeup_reason(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw89_wow_aoac_report *aoac_rpt = &rtw_wow->aoac_rpt;
 	u32 wow_reason_reg = rtwdev->chip->wow_reason_reg;
 	struct cfg80211_wowlan_nd_info nd_info;
 	struct cfg80211_wowlan_wakeup wakeup = {
@@ -286,10 +620,7 @@ static void rtw89_wow_show_wakeup_reason(struct rtw89_dev *rtwdev)
 		rtw89_debug(rtwdev, RTW89_DBG_WOW, "WOW: Rx gtk rekey\n");
 		break;
 	case RTW89_WOW_RSN_RX_PATTERN_MATCH:
-		/* Current firmware and driver don't report pattern index
-		 * Use pattern_idx to 0 defaultly.
-		 */
-		wakeup.pattern_idx = 0;
+		wakeup.pattern_idx = aoac_rpt->pattern_idx;
 		rtw89_debug(rtwdev, RTW89_DBG_WOW, "WOW: Rx pattern match packet\n");
 		break;
 	case RTW89_WOW_RSN_RX_NLO:
@@ -808,7 +1139,22 @@ static int rtw89_wow_disable_trx_pre(struct rtw89_dev *rtwdev)
 		rtw89_err(rtwdev, "failed to config mac\n");
 		return ret;
 	}
+
+	/* Before enabling interrupt, we need to get AOAC report by reg due to RX
+	 * not enabled yet. Also, we need to sync RX related IV from firmware to
+	 * mac80211 before receiving RX packets from driver.
+	 * After enabling interrupt, we can get AOAC report from h2c and c2h, and
+	 * can get TX IV and complete rekey info. We need to update TX related IV
+	 * and new GTK info if rekey happened.
+	 */
+	ret = rtw89_wow_get_aoac_rpt(rtwdev, false);
+	if (!ret)
+		rtw89_wow_update_key_info(rtwdev, false);
+
 	rtw89_hci_enable_intr(rtwdev);
+	ret = rtw89_wow_get_aoac_rpt(rtwdev, true);
+	if (!ret)
+		rtw89_wow_update_key_info(rtwdev, true);
 
 	return 0;
 }
@@ -893,6 +1239,7 @@ static int rtw89_wow_fw_stop(struct rtw89_dev *rtwdev)
 		goto out;
 	}
 
+	rtw89_wow_key_clear(rtwdev);
 	rtw89_fw_release_general_pkt_list(rtwdev, true);
 
 	ret = rtw89_wow_cfg_wake(rtwdev, false);
diff --git a/drivers/net/wireless/realtek/rtw89/wow.h b/drivers/net/wireless/realtek/rtw89/wow.h
index 4db07636a34d..4ce248defc94 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.h
+++ b/drivers/net/wireless/realtek/rtw89/wow.h
@@ -48,6 +48,12 @@ struct rtw89_cipher_info {
 	enum ieee80211_key_len len;
 };
 
+struct rtw89_set_key_info_iter_data {
+	u32 gtk_cipher;
+	bool rx_ready;
+	bool error;
+};
+
 int rtw89_wow_suspend(struct rtw89_dev *rtwdev, struct cfg80211_wowlan *wowlan);
 int rtw89_wow_resume(struct rtw89_dev *rtwdev);
 void rtw89_wow_parse_akm(struct rtw89_dev *rtwdev, struct sk_buff *skb);
-- 
2.25.1


