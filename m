Return-Path: <linux-wireless+bounces-4317-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D253086EDAC
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 01:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875DC286BC6
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 00:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DF579CB;
	Sat,  2 Mar 2024 00:59:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97ED79C8
	for <linux-wireless@vger.kernel.org>; Sat,  2 Mar 2024 00:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341193; cv=none; b=PwzK9Egdsnip5UA04QMYngoeSF3pdK6FRUEoUE2OfeBdLS3VHBQm6jAYhpdpb5UJNAmtJ5AHk4DGw6MnANte8aUOfsdKfHpaAQHKBNKl6bK3ZO+VOQWK22/whnpQqKNJk4QmFNstgAC685tqbG7hIuuU9xwxC0sc3Zkyn3fhvSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341193; c=relaxed/simple;
	bh=1l37Jzl/3/kMVPjHL5TQZ8N71Fh0t0gJQy0IsqgKtLE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rzLYG4OjRFSsJnv69emRbYaC8YTTeuZ58aq2l6Hp/DJBP1Pa1L1GdkkX6KKKIafa4QduURfBpaFvQYSl/IBv5AGgT53L41FTmLX0WKc985egQQOHsx+gRC6c0v0UTkdZfzFAuOYbcsPQJWpusLa9w9jaLkU9O/WPNYzmt0mErlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4220xj7gB2370287, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4220xj7gB2370287
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 Mar 2024 08:59:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Sat, 2 Mar 2024 08:59:45 +0800
Received: from [127.0.1.1] (172.16.16.155) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 2 Mar
 2024 08:59:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/7] wifi: rtw89: wow: update config mac function with different generation
Date: Sat, 2 Mar 2024 08:58:25 +0800
Message-ID: <20240302005828.13666-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240302005828.13666-1-pkshih@realtek.com>
References: <20240302005828.13666-1-pkshih@realtek.com>
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

From: Chin-Yen Lee <timlee@realtek.com>

The registers to configure mac function for WoWLAN mode that are different
from different generation, so update them.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.h     |  9 +++-
 drivers/net/wireless/realtek/rtw89/mac.c    | 37 ++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h    |  8 ++++
 drivers/net/wireless/realtek/rtw89/mac_be.c | 48 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    | 16 +++++++
 drivers/net/wireless/realtek/rtw89/wow.c    | 28 +-----------
 6 files changed, 117 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 9c5464dcc081..bdfd2583650d 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -64,6 +64,8 @@ struct rtw89_h2creg_sch_tx_en {
 #define RTW89_H2CREG_SCH_TX_EN_W1_MASK GENMASK(15, 0)
 #define RTW89_H2CREG_SCH_TX_EN_W1_BAND BIT(16)
 
+#define RTW89_H2CREG_WOW_CPUIO_RX_CTRL_EN GENMASK(23, 16)
+
 #define RTW89_H2CREG_MAX 4
 #define RTW89_C2HREG_MAX 4
 #define RTW89_C2HREG_HDR_LEN 2
@@ -95,7 +97,9 @@ enum rtw89_mac_h2c_type {
 	RTW89_FWCMD_H2CREG_FUNC_FWERR,
 	RTW89_FWCMD_H2CREG_FUNC_GET_FEATURE,
 	RTW89_FWCMD_H2CREG_FUNC_GETPKT_INFORM,
-	RTW89_FWCMD_H2CREG_FUNC_SCH_TX_EN
+	RTW89_FWCMD_H2CREG_FUNC_SCH_TX_EN,
+	RTW89_FWCMD_H2CREG_FUNC_WOW_TRX_STOP = 0x6,
+	RTW89_FWCMD_H2CREG_FUNC_WOW_CPUIO_RX_CTRL = 0xA,
 };
 
 enum rtw89_mac_c2h_type {
@@ -104,7 +108,8 @@ enum rtw89_mac_c2h_type {
 	RTW89_FWCMD_C2HREG_FUNC_ERR_MSG,
 	RTW89_FWCMD_C2HREG_FUNC_PHY_CAP,
 	RTW89_FWCMD_C2HREG_FUNC_TX_PAUSE_RPT,
-	RTW89_FWCMD_C2HREG_FUNC_NULL = 0xFF
+	RTW89_FWCMD_C2HREG_FUNC_WOW_CPUIO_RX_ACK = 0xA,
+	RTW89_FWCMD_C2HREG_FUNC_NULL = 0xFF,
 };
 
 enum rtw89_fw_c2h_category {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 28e07ff7eb2a..38124f9a178b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -6265,6 +6265,41 @@ int rtw89_mac_ptk_drop_by_band_and_wait(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+static int rtw89_wow_config_mac_ax(struct rtw89_dev *rtwdev, bool enable_wow)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	int ret;
+
+	if (enable_wow) {
+		ret = rtw89_mac_resize_ple_rx_quota(rtwdev, true);
+		if (ret) {
+			rtw89_err(rtwdev, "[ERR]patch rx qta %d\n", ret);
+			return ret;
+		}
+
+		rtw89_write32_set(rtwdev, R_AX_RX_FUNCTION_STOP, B_AX_HDR_RX_STOP);
+		rtw89_write32_clr(rtwdev, mac->rx_fltr, B_AX_SNIFFER_MODE);
+		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, false);
+		rtw89_write32(rtwdev, R_AX_ACTION_FWD0, 0);
+		rtw89_write32(rtwdev, R_AX_ACTION_FWD1, 0);
+		rtw89_write32(rtwdev, R_AX_TF_FWD, 0);
+		rtw89_write32(rtwdev, R_AX_HW_RPT_FWD, 0);
+	} else {
+		ret = rtw89_mac_resize_ple_rx_quota(rtwdev, false);
+		if (ret) {
+			rtw89_err(rtwdev, "[ERR]patch rx qta %d\n", ret);
+			return ret;
+		}
+
+		rtw89_write32_clr(rtwdev, R_AX_RX_FUNCTION_STOP, B_AX_HDR_RX_STOP);
+		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, true);
+		rtw89_write32(rtwdev, R_AX_ACTION_FWD0, TRXCFG_MPDU_PROC_ACT_FRWD);
+		rtw89_write32(rtwdev, R_AX_TF_FWD, TRXCFG_MPDU_PROC_TF_FRWD);
+	}
+
+	return 0;
+}
+
 static u8 rtw89_fw_get_rdy_ax(struct rtw89_dev *rtwdev, enum rtw89_fwdl_check_type type)
 {
 	u8 val = rtw89_read8(rtwdev, R_AX_WCPU_FW_CTRL);
@@ -6353,5 +6388,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 
 	.add_chan_list = rtw89_hw_scan_add_chan_list,
 	.scan_offload = rtw89_fw_h2c_scan_offload,
+
+	.wow_config_mac = rtw89_wow_config_mac_ax,
 };
 EXPORT_SYMBOL(rtw89_mac_gen_ax);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 8904ae222331..331beeabae09 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -169,6 +169,12 @@ enum rtw89_mac_ax_l0_to_l1_event {
 	MAC_AX_L0_TO_L1_EVENT_MAX = 15,
 };
 
+enum rtw89_mac_wow_fw_status {
+	WOWLAN_NOT_READY = 0x00,
+	WOWLAN_SLEEP_READY = 0x01,
+	WOWLAN_RESUME_READY = 0x02,
+};
+
 #define RTW89_PORT_OFFSET_TU_TO_32US(shift_tu) ((shift_tu) * 1024 / 32)
 
 enum rtw89_mac_dbg_port_sel {
@@ -977,6 +983,8 @@ struct rtw89_mac_gen_def {
 	int (*scan_offload)(struct rtw89_dev *rtwdev,
 			    struct rtw89_scan_option *option,
 			    struct rtw89_vif *rtwvif);
+
+	int (*wow_config_mac)(struct rtw89_dev *rtwdev, bool enable_wow);
 };
 
 extern const struct rtw89_mac_gen_def rtw89_mac_gen_ax;
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index ffa185ba0ab7..cc7d3b3fab90 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2193,6 +2193,52 @@ static void rtw89_mac_dump_qta_lost_be(struct rtw89_dev *rtwdev)
 	dump_err_status_dispatcher_be(rtwdev);
 }
 
+static int rtw89_mac_cpu_io_rx(struct rtw89_dev *rtwdev, bool wow_enable)
+{
+	struct rtw89_mac_h2c_info h2c_info = {};
+	struct rtw89_mac_c2h_info c2h_info = {};
+	u32 ret;
+
+	h2c_info.id = RTW89_FWCMD_H2CREG_FUNC_WOW_CPUIO_RX_CTRL;
+	h2c_info.content_len = sizeof(h2c_info.u.hdr);
+	h2c_info.u.hdr.w0 = u32_encode_bits(wow_enable, RTW89_H2CREG_WOW_CPUIO_RX_CTRL_EN);
+
+	ret = rtw89_fw_msg_reg(rtwdev, &h2c_info, &c2h_info);
+	if (ret)
+		return ret;
+
+	if (c2h_info.id != RTW89_FWCMD_C2HREG_FUNC_WOW_CPUIO_RX_ACK)
+		ret = -EINVAL;
+
+	return ret;
+}
+
+static int rtw89_wow_config_mac_be(struct rtw89_dev *rtwdev, bool enable_wow)
+{
+	if (enable_wow) {
+		rtw89_write32_set(rtwdev, R_BE_RX_STOP, B_BE_HOST_RX_STOP);
+		rtw89_write32_clr(rtwdev, R_BE_RX_FLTR_OPT, B_BE_SNIFFER_MODE);
+		rtw89_mac_cpu_io_rx(rtwdev, enable_wow);
+		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, false);
+		rtw89_write32(rtwdev, R_BE_FWD_ERR, 0);
+		rtw89_write32(rtwdev, R_BE_FWD_ACTN0, 0);
+		rtw89_write32(rtwdev, R_BE_FWD_ACTN1, 0);
+		rtw89_write32(rtwdev, R_BE_FWD_ACTN2, 0);
+		rtw89_write32(rtwdev, R_BE_FWD_TF0, 0);
+		rtw89_write32(rtwdev, R_BE_FWD_TF1, 0);
+		rtw89_write32(rtwdev, R_BE_FWD_ERR, 0);
+		rtw89_write32(rtwdev, R_BE_HW_PPDU_STATUS, 0);
+		rtw89_write8(rtwdev, R_BE_DBG_WOW_READY, WOWLAN_NOT_READY);
+	} else {
+		rtw89_mac_cpu_io_rx(rtwdev, enable_wow);
+		rtw89_write32_clr(rtwdev, R_BE_RX_STOP, B_BE_HOST_RX_STOP);
+		rtw89_write32_set(rtwdev, R_BE_RX_FLTR_OPT, R_BE_RX_FLTR_OPT);
+		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, true);
+	}
+
+	return 0;
+}
+
 static void rtw89_mac_dump_cmac_err_status_be(struct rtw89_dev *rtwdev,
 					      u8 band)
 {
@@ -2452,5 +2498,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 
 	.add_chan_list = rtw89_hw_scan_add_chan_list_be,
 	.scan_offload = rtw89_fw_h2c_scan_offload_be,
+
+	.wow_config_mac = rtw89_wow_config_mac_be,
 };
 EXPORT_SYMBOL(rtw89_mac_gen_be);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 9419960d1faf..1dca93d0401d 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4451,6 +4451,9 @@
 #define B_BE_HCI_RXDMA_EN BIT(1)
 #define B_BE_HCI_TXDMA_EN BIT(0)
 
+#define R_BE_DBG_WOW_READY 0x815E
+#define B_BE_DBG_WOW_READY GENMASK(7, 0)
+
 #define R_BE_DMAC_FUNC_EN 0x8400
 #define B_BE_DMAC_CRPRT BIT(31)
 #define B_BE_MAC_FUNC_EN BIT(30)
@@ -5004,6 +5007,12 @@
 			       B_BE_CR_WRFF_OVERFLOW_ERR_INT_EN | \
 			       B_BE_CR_WRFF_UNDERFLOW_ERR_INT_EN)
 
+#define R_BE_RX_STOP 0x8914
+#define B_BE_CPU_RX_STOP BIT(17)
+#define B_BE_HOST_RX_STOP BIT(16)
+#define B_BE_CPU_RX_CH_STOP_MSK GENMASK(15, 8)
+#define B_BE_HOST_RX_CH_STOP_MSK GENMASK(5, 0)
+
 #define R_BE_DISP_FWD_WLAN_0 0x8938
 #define B_BE_FWD_WLAN_CPU_TYPE_13_MASK GENMASK(31, 30)
 #define B_BE_FWD_WLAN_CPU_TYPE_12_MASK GENMASK(29, 28)
@@ -5519,6 +5528,13 @@
 #define B_BE_DROP_NONDMA_PPDU BIT(2)
 #define B_BE_APPEND_FCS BIT(0)
 
+#define R_BE_FWD_ERR 0x9C10
+#define R_BE_FWD_ACTN0 0x9C14
+#define R_BE_FWD_ACTN1 0x9C18
+#define R_BE_FWD_ACTN2 0x9C1C
+#define R_BE_FWD_TF0 0x9C20
+#define R_BE_FWD_TF1 0x9C24
+
 #define R_BE_HW_PPDU_STATUS 0x9C30
 #define B_BE_FWD_RPKTTYPE_MASK GENMASK(31, 26)
 #define B_BE_FWD_PPDU_PRTID_MASK GENMASK(25, 23)
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 286c59931fca..689a4e94387a 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -41,34 +41,8 @@ static void rtw89_wow_leave_lps(struct rtw89_dev *rtwdev)
 static int rtw89_wow_config_mac(struct rtw89_dev *rtwdev, bool enable_wow)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
-	int ret;
 
-	if (enable_wow) {
-		ret = rtw89_mac_resize_ple_rx_quota(rtwdev, true);
-		if (ret) {
-			rtw89_err(rtwdev, "[ERR]patch rx qta %d\n", ret);
-			return ret;
-		}
-		rtw89_write32_set(rtwdev, R_AX_RX_FUNCTION_STOP, B_AX_HDR_RX_STOP);
-		rtw89_write32_clr(rtwdev, mac->rx_fltr, B_AX_SNIFFER_MODE);
-		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, false);
-		rtw89_write32(rtwdev, R_AX_ACTION_FWD0, 0);
-		rtw89_write32(rtwdev, R_AX_ACTION_FWD1, 0);
-		rtw89_write32(rtwdev, R_AX_TF_FWD, 0);
-		rtw89_write32(rtwdev, R_AX_HW_RPT_FWD, 0);
-	} else {
-		ret = rtw89_mac_resize_ple_rx_quota(rtwdev, false);
-		if (ret) {
-			rtw89_err(rtwdev, "[ERR]patch rx qta %d\n", ret);
-			return ret;
-		}
-		rtw89_write32_clr(rtwdev, R_AX_RX_FUNCTION_STOP, B_AX_HDR_RX_STOP);
-		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, true);
-		rtw89_write32(rtwdev, R_AX_ACTION_FWD0, TRXCFG_MPDU_PROC_ACT_FRWD);
-		rtw89_write32(rtwdev, R_AX_TF_FWD, TRXCFG_MPDU_PROC_TF_FRWD);
-	}
-
-	return 0;
+	return mac->wow_config_mac(rtwdev, enable_wow);
 }
 
 static void rtw89_wow_set_rx_filter(struct rtw89_dev *rtwdev, bool enable)
-- 
2.25.1


