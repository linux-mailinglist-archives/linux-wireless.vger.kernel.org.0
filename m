Return-Path: <linux-wireless+bounces-495-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D1C807021
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 13:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED44281C63
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 12:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BFF374D4;
	Wed,  6 Dec 2023 12:46:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216F41BD
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 04:46:17 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B6Ck5xoD3602903, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B6Ck5xoD3602903
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Dec 2023 20:46:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 6 Dec 2023 20:46:06 +0800
Received: from [127.0.1.1] (172.16.20.124) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 6 Dec 2023
 20:46:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/6] wifi: rtw89: load RFK log format string from firmware file
Date: Wed, 6 Dec 2023 20:44:45 +0800
Message-ID: <20231206124448.10537-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206124448.10537-1-pkshih@realtek.com>
References: <20231206124448.10537-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

To debug RFK (RF calibration) in firmware, it sends log via firmware C2H
events to driver with string format ID and four arguments. Load formatted
string from firmware file, and the string ID can get back its string. Then,
use regular print format to show the message.

This firmware element layout looks like

    +============================================+
    |  elm ID  | elm size | version  |           |
    +----------+----------+----------+-----------+
    |                     | nr |rsvd |rfk_id|rsvd|
    +--------------------------------------------+
    | offset[] (__le16 * nr)                     |
    | ...                                        |
    +--------------------------------------------+
    | formatted string with null termintor (*nr) |
    | ...                                        |
    +============================================+

 * a firmware file can contains more than one elements with this element ID
   named RTW89_FW_ELEMENT_ID_RFKLOG_FMT (19), because many RFK needs its
   own formatted strings, so add 'rfk_id' to know it belongs to which RFK.
 * the 'formatted string' just follow 'offset[]' without padding to align
   32bits.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  2 ++
 drivers/net/wireless/realtek/rtw89/fw.c   | 29 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h   |  8 +++++++
 drivers/net/wireless/realtek/rtw89/phy.h  | 15 ++++++++++++
 4 files changed, 54 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 396e6dd08b04..3080a3515aed 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -18,6 +18,7 @@ struct rtw89_mac_gen_def;
 struct rtw89_phy_gen_def;
 struct rtw89_efuse_block_cfg;
 struct rtw89_fw_txpwr_track_cfg;
+struct rtw89_phy_rfk_log_fmt;
 
 extern const struct ieee80211_ops rtw89_ops;
 
@@ -3939,6 +3940,7 @@ struct rtw89_fw_elm_info {
 	struct rtw89_phy_table *rf_radio[RF_PATH_MAX];
 	struct rtw89_phy_table *rf_nctl;
 	struct rtw89_fw_txpwr_track_cfg *txpwr_trk;
+	struct rtw89_phy_rfk_log_fmt *rfk_log_fmt;
 };
 
 struct rtw89_fw_info {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 546569a8fd5b..497c6dd5edf0 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -728,6 +728,31 @@ int rtw89_build_txpwr_trk_tbl_from_elm(struct rtw89_dev *rtwdev,
 	return -EFAULT;
 }
 
+static
+int rtw89_build_rfk_log_fmt_from_elm(struct rtw89_dev *rtwdev,
+				     const struct rtw89_fw_element_hdr *elm,
+				     const union rtw89_fw_element_arg arg)
+{
+	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
+	u8 rfk_id;
+
+	if (elm_info->rfk_log_fmt)
+		goto allocated;
+
+	elm_info->rfk_log_fmt = kzalloc(sizeof(*elm_info->rfk_log_fmt), GFP_KERNEL);
+	if (!elm_info->rfk_log_fmt)
+		return 1; /* this is an optional element, so just ignore this */
+
+allocated:
+	rfk_id = elm->u.rfk_log_fmt.rfk_id;
+	if (rfk_id >= RTW89_PHY_C2H_RFK_LOG_FUNC_NUM)
+		return 1;
+
+	elm_info->rfk_log_fmt->elm[rfk_id] = elm;
+
+	return 0;
+}
+
 static const struct rtw89_fw_element_handler __fw_element_handlers[] = {
 	[RTW89_FW_ELEMENT_ID_BBMCU0] = {__rtw89_fw_recognize_from_elm,
 					{ .fw_type = RTW89_FW_BBMCU0 }, NULL},
@@ -783,6 +808,9 @@ static const struct rtw89_fw_element_handler __fw_element_handlers[] = {
 	[RTW89_FW_ELEMENT_ID_TXPWR_TRK] = {
 		rtw89_build_txpwr_trk_tbl_from_elm, {}, "PWR_TRK",
 	},
+	[RTW89_FW_ELEMENT_ID_RFKLOG_FMT] = {
+		rtw89_build_rfk_log_fmt_from_elm, {}, NULL,
+	},
 };
 
 int rtw89_fw_recognize_elements(struct rtw89_dev *rtwdev)
@@ -1212,6 +1240,7 @@ static void rtw89_unload_firmware_elements(struct rtw89_dev *rtwdev)
 	rtw89_free_phy_tbl_from_elm(elm_info->rf_nctl);
 
 	kfree(elm_info->txpwr_trk);
+	kfree(elm_info->rfk_log_fmt);
 }
 
 void rtw89_unload_firmware(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 6abe4f4e3489..1d909d684ed9 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3427,6 +3427,7 @@ enum rtw89_fw_element_id {
 	RTW89_FW_ELEMENT_ID_TX_SHAPE_LMT = 16,
 	RTW89_FW_ELEMENT_ID_TX_SHAPE_LMT_RU = 17,
 	RTW89_FW_ELEMENT_ID_TXPWR_TRK = 18,
+	RTW89_FW_ELEMENT_ID_RFKLOG_FMT = 19,
 
 	RTW89_FW_ELEMENT_ID_NUM,
 };
@@ -3542,6 +3543,13 @@ struct rtw89_fw_element_hdr {
 			__le32 rsvd;
 			s8 contents[][DELTA_SWINGIDX_SIZE];
 		} __packed txpwr_trk;
+		struct {
+			u8 nr;
+			u8 rsvd[3];
+			u8 rfk_id; /* enum rtw89_phy_c2h_rfk_log_func */
+			u8 rsvd1[3];
+			__le16 offset[];
+		} __packed rfk_log_fmt;
 		struct __rtw89_fw_txpwr_element txpwr;
 	} __packed u;
 } __packed;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 6792b73e9ca3..b60bc563d86f 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -136,6 +136,17 @@ enum rtw89_phy_c2h_ra_func {
 	RTW89_PHY_C2H_FUNC_RA_MAX,
 };
 
+enum rtw89_phy_c2h_rfk_log_func {
+	RTW89_PHY_C2H_RFK_LOG_FUNC_IQK = 0,
+	RTW89_PHY_C2H_RFK_LOG_FUNC_DPK = 1,
+	RTW89_PHY_C2H_RFK_LOG_FUNC_DACK = 2,
+	RTW89_PHY_C2H_RFK_LOG_FUNC_RXDCK = 3,
+	RTW89_PHY_C2H_RFK_LOG_FUNC_TSSI = 4,
+	RTW89_PHY_C2H_RFK_LOG_FUNC_TXGAPK = 5,
+
+	RTW89_PHY_C2H_RFK_LOG_FUNC_NUM,
+};
+
 enum rtw89_phy_c2h_dm_func {
 	RTW89_PHY_C2H_DM_FUNC_FW_TEST,
 	RTW89_PHY_C2H_DM_FUNC_FW_TRIG_TX_RPT,
@@ -483,6 +494,10 @@ struct rtw89_txpwr_limit_ru_be {
 	s8 ru106_26[RTW89_RU_SEC_NUM_BE];
 };
 
+struct rtw89_phy_rfk_log_fmt {
+	const struct rtw89_fw_element_hdr *elm[RTW89_PHY_C2H_RFK_LOG_FUNC_NUM];
+};
+
 struct rtw89_phy_gen_def {
 	u32 cr_base;
 	const struct rtw89_ccx_regs *ccx;
-- 
2.25.1


