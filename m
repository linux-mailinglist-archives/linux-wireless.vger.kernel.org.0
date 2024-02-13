Return-Path: <linux-wireless+bounces-3509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2231E852A23
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 08:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCFB62845AA
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 07:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3EB22319;
	Tue, 13 Feb 2024 07:36:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44BE208C3
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809781; cv=none; b=CgadAFRWvxb3ul9vwYC+ofQEvm3VJHyJUVHjrBkwaHvtutFAhOmRJjXyffim+YBbQ1O7k0zgImzQuQX/TmpGbdZbqrDiyLxfEBZ+AtP/X8hpl/CGW8KMo2QaRVcDhAWglcAHc+EYZdtnXat3E2l+rKNX/x7a0FbSV9orsg0CARc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809781; c=relaxed/simple;
	bh=e1C1TkpA9+FKQ7YPAhwhf94M30NHuWzoCQU6JsN/em0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JoQTILxcT9ZJ3UAGFLPzP64Jf5bGypFnWK30RrdZ67cDDjR+tEqLk9ocvt85ei03PPiifmqRHlrIl+z7HHTcz1TQwpa8+cXLRa4MzdsuysMVVkjuJpf3ADXwump76uxfaomYvlVi0olNuZ8sSEPPzRsD0Wj5+RqcjBngaRKowac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41D7a4VB11671591, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41D7a4VB11671591
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 15:36:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Tue, 13 Feb 2024 15:36:05 +0800
Received: from [127.0.1.1] (172.16.16.31) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 13 Feb
 2024 15:36:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/5] wifi: rtw89: fw: add definition of H2C command and C2H event for MRC series
Date: Tue, 13 Feb 2024 15:35:10 +0800
Message-ID: <20240213073514.23796-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240213073514.23796-1-pkshih@realtek.com>
References: <20240213073514.23796-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Zong-Zhe Yang <kevin_yang@realtek.com>

For Wi-Fi 7 chips, FW supports MRC (multi-role concurrent) functions
including H2C commands and C2H events. We can consider FW MRC functions
as a superset of FW MCC (multi-channel concurrent) functions. And, MRC
functions can take MLO things into account.

Basically before MLO, SW can also manipulate FW MRC to work original
SW MCC flow. So, we add them first and implement the handling in the
following. And then, SW MCC will call different series of FW functions
according to chip later.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.h  | 172 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h |  24 +++-
 2 files changed, 190 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 5609e5f7d7eb..409f62cea0d7 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3385,6 +3385,143 @@ inline void RTW89_SET_FWCMD_MCC_SET_DURATION_DURATION_Y(void *cmd, u32 val)
 	le32p_replace_bits((__le32 *)cmd + 4, val, GENMASK(31, 0));
 }
 
+enum rtw89_h2c_mrc_sch_types {
+	RTW89_H2C_MRC_SCH_BAND0_ONLY = 0,
+	RTW89_H2C_MRC_SCH_BAND1_ONLY = 1,
+	RTW89_H2C_MRC_SCH_DUAL_BAND = 2,
+};
+
+enum rtw89_h2c_mrc_role_types {
+	RTW89_H2C_MRC_ROLE_WIFI = 0,
+	RTW89_H2C_MRC_ROLE_BT = 1,
+	RTW89_H2C_MRC_ROLE_EMPTY = 2,
+};
+
+struct rtw89_h2c_mrc_add_role {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 macid_main_bitmap;
+	__le32 macid_paired_bitmap;
+} __packed;
+
+#define RTW89_H2C_MRC_ADD_ROLE_W0_MACID GENMASK(15, 0)
+#define RTW89_H2C_MRC_ADD_ROLE_W0_ROLE_TYPE GENMASK(23, 16)
+#define RTW89_H2C_MRC_ADD_ROLE_W0_IS_MASTER BIT(24)
+#define RTW89_H2C_MRC_ADD_ROLE_W0_IS_ALT_ROLE BIT(25)
+#define RTW89_H2C_MRC_ADD_ROLE_W0_TX_NULL_EN BIT(26)
+#define RTW89_H2C_MRC_ADD_ROLE_W0_ROLE_ALT_EN BIT(27)
+#define RTW89_H2C_MRC_ADD_ROLE_W1_CENTRAL_CH_SEG GENMASK(7, 0)
+#define RTW89_H2C_MRC_ADD_ROLE_W1_PRI_CH GENMASK(15, 8)
+#define RTW89_H2C_MRC_ADD_ROLE_W1_BW GENMASK(19, 16)
+#define RTW89_H2C_MRC_ADD_ROLE_W1_CH_BAND_TYPE GENMASK(21, 20)
+#define RTW89_H2C_MRC_ADD_ROLE_W1_RFK_BY_PASS BIT(22)
+#define RTW89_H2C_MRC_ADD_ROLE_W1_CAN_BTC BIT(23)
+#define RTW89_H2C_MRC_ADD_ROLE_W1_NULL_EARLY GENMASK(31, 24)
+#define RTW89_H2C_MRC_ADD_ROLE_W2_ALT_PERIOD GENMASK(7, 0)
+#define RTW89_H2C_MRC_ADD_ROLE_W2_ALT_ROLE_TYPE GENMASK(15, 8)
+#define RTW89_H2C_MRC_ADD_ROLE_W2_ALT_ROLE_MACID GENMASK(23, 16)
+
+struct rtw89_h2c_mrc_add_slot {
+	__le32 w0;
+	__le32 w1;
+	struct rtw89_h2c_mrc_add_role roles[];
+} __packed;
+
+#define RTW89_H2C_MRC_ADD_SLOT_W0_DURATION GENMASK(15, 0)
+#define RTW89_H2C_MRC_ADD_SLOT_W0_COURTESY_EN BIT(17)
+#define RTW89_H2C_MRC_ADD_SLOT_W0_ROLE_NUM GENMASK(31, 24)
+#define RTW89_H2C_MRC_ADD_SLOT_W1_COURTESY_PERIOD GENMASK(7, 0)
+#define RTW89_H2C_MRC_ADD_SLOT_W1_COURTESY_TARGET GENMASK(15, 8)
+
+struct rtw89_h2c_mrc_add {
+	__le32 w0;
+	/* Logically append flexible struct rtw89_h2c_mrc_add_slot, but there
+	 * are other flexible array inside it. We cannot access them correctly
+	 * through this struct. So, in case misusing, we don't really declare
+	 * it here.
+	 */
+} __packed;
+
+#define RTW89_H2C_MRC_ADD_W0_SCH_IDX GENMASK(3, 0)
+#define RTW89_H2C_MRC_ADD_W0_SCH_TYPE GENMASK(7, 4)
+#define RTW89_H2C_MRC_ADD_W0_SLOT_NUM GENMASK(15, 8)
+#define RTW89_H2C_MRC_ADD_W0_BTC_IN_SCH BIT(16)
+
+enum rtw89_h2c_mrc_start_actions {
+	RTW89_H2C_MRC_START_ACTION_START_NEW = 0,
+	RTW89_H2C_MRC_START_ACTION_REPLACE_OLD = 1,
+};
+
+struct rtw89_h2c_mrc_start {
+	__le32 w0;
+	__le32 start_tsf_low;
+	__le32 start_tsf_high;
+} __packed;
+
+#define RTW89_H2C_MRC_START_W0_SCH_IDX GENMASK(3, 0)
+#define RTW89_H2C_MRC_START_W0_OLD_SCH_IDX GENMASK(7, 4)
+#define RTW89_H2C_MRC_START_W0_ACTION GENMASK(15, 8)
+
+struct rtw89_h2c_mrc_del {
+	__le32 w0;
+} __packed;
+
+#define RTW89_H2C_MRC_DEL_W0_SCH_IDX GENMASK(3, 0)
+#define RTW89_H2C_MRC_DEL_W0_DEL_ALL BIT(4)
+#define RTW89_H2C_MRC_DEL_W0_STOP_ONLY BIT(5)
+#define RTW89_H2C_MRC_DEL_W0_SPECIFIC_ROLE_EN BIT(6)
+#define RTW89_H2C_MRC_DEL_W0_STOP_SLOT_IDX GENMASK(15, 8)
+#define RTW89_H2C_MRC_DEL_W0_SPECIFIC_ROLE_MACID GENMASK(31, 16)
+
+struct rtw89_h2c_mrc_req_tsf {
+	u8 req_tsf_num;
+	u8 infos[] __counted_by(req_tsf_num);
+} __packed;
+
+#define RTW89_H2C_MRC_REQ_TSF_INFO_BAND GENMASK(3, 0)
+#define RTW89_H2C_MRC_REQ_TSF_INFO_PORT GENMASK(7, 4)
+
+enum rtw89_h2c_mrc_upd_bitmap_actions {
+	RTW89_H2C_MRC_UPD_BITMAP_ACTION_DEL = 0,
+	RTW89_H2C_MRC_UPD_BITMAP_ACTION_ADD = 1,
+};
+
+struct rtw89_h2c_mrc_upd_bitmap {
+	__le32 w0;
+	__le32 w1;
+} __packed;
+
+#define RTW89_H2C_MRC_UPD_BITMAP_W0_SCH_IDX GENMASK(3, 0)
+#define RTW89_H2C_MRC_UPD_BITMAP_W0_ACTION BIT(4)
+#define RTW89_H2C_MRC_UPD_BITMAP_W0_MACID GENMASK(31, 16)
+#define RTW89_H2C_MRC_UPD_BITMAP_W1_CLIENT_MACID GENMASK(15, 0)
+
+struct rtw89_h2c_mrc_sync {
+	__le32 w0;
+	__le32 w1;
+} __packed;
+
+#define RTW89_H2C_MRC_SYNC_W0_SYNC_EN BIT(0)
+#define RTW89_H2C_MRC_SYNC_W0_SRC_PORT GENMASK(11, 8)
+#define RTW89_H2C_MRC_SYNC_W0_SRC_BAND GENMASK(15, 12)
+#define RTW89_H2C_MRC_SYNC_W0_DEST_PORT GENMASK(19, 16)
+#define RTW89_H2C_MRC_SYNC_W0_DEST_BAND GENMASK(23, 20)
+#define RTW89_H2C_MRC_SYNC_W1_OFFSET GENMASK(15, 0)
+
+struct rtw89_h2c_mrc_upd_duration {
+	__le32 w0;
+	__le32 start_tsf_low;
+	__le32 start_tsf_high;
+	__le32 slots[];
+} __packed;
+
+#define RTW89_H2C_MRC_UPD_DURATION_W0_SCH_IDX GENMASK(3, 0)
+#define RTW89_H2C_MRC_UPD_DURATION_W0_SLOT_NUM GENMASK(15, 8)
+#define RTW89_H2C_MRC_UPD_DURATION_W0_BTC_IN_SCH BIT(16)
+#define RTW89_H2C_MRC_UPD_DURATION_SLOT_SLOT_IDX GENMASK(7, 0)
+#define RTW89_H2C_MRC_UPD_DURATION_SLOT_DURATION GENMASK(31, 16)
+
 #define RTW89_C2H_HEADER_LEN 8
 
 struct rtw89_c2h_hdr {
@@ -3573,6 +3710,29 @@ static_assert(sizeof(struct rtw89_mac_mcc_tsf_rpt) <= RTW89_COMPLETION_BUF_SIZE)
 #define RTW89_GET_MAC_C2H_MCC_STATUS_RPT_TSF_HIGH(c2h) \
 	le32_get_bits(*((const __le32 *)(c2h) + 4), GENMASK(31, 0))
 
+struct rtw89_c2h_mrc_tsf_rpt_info {
+	__le32 tsf_low;
+	__le32 tsf_high;
+} __packed;
+
+struct rtw89_c2h_mrc_tsf_rpt {
+	struct rtw89_c2h_hdr hdr;
+	__le32 w2;
+	struct rtw89_c2h_mrc_tsf_rpt_info infos[];
+} __packed;
+
+#define RTW89_C2H_MRC_TSF_RPT_W2_REQ_TSF_NUM GENMASK(7, 0)
+
+struct rtw89_c2h_mrc_status_rpt {
+	struct rtw89_c2h_hdr hdr;
+	__le32 w2;
+	__le32 tsf_low;
+	__le32 tsf_high;
+} __packed;
+
+#define RTW89_C2H_MRC_STATUS_RPT_W2_STATUS GENMASK(5, 0)
+#define RTW89_C2H_MRC_STATUS_RPT_W2_SCH_IDX GENMASK(7, 6)
+
 struct rtw89_c2h_pkt_ofld_rsp {
 	__le32 w0;
 	__le32 w1;
@@ -3959,6 +4119,18 @@ enum rtw89_mcc_h2c_func {
 #define RTW89_MCC_WAIT_COND(group, func) \
 	((group) * NUM_OF_RTW89_MCC_H2C_FUNC + (func))
 
+/* CLASS 24 - MRC */
+#define H2C_CL_MRC			0x18
+enum rtw89_mrc_h2c_func {
+	H2C_FUNC_MRC_REQ_TSF		= 0x0,
+	H2C_FUNC_ADD_MRC		= 0x1,
+	H2C_FUNC_START_MRC		= 0x2,
+	H2C_FUNC_DEL_MRC		= 0x3,
+	H2C_FUNC_MRC_SYNC		= 0x4,
+	H2C_FUNC_MRC_UPD_DURATION	= 0x5,
+	H2C_FUNC_MRC_UPD_BITMAP		= 0x6,
+};
+
 #define H2C_CAT_OUTSRC			0x2
 
 #define H2C_CL_OUTSRC_RA		0x1
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index c5ebac1d5990..12318d850475 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -406,13 +406,19 @@ enum rtw89_mac_c2h_mcc_func {
 	NUM_OF_RTW89_MAC_C2H_FUNC_MCC,
 };
 
+enum rtw89_mac_c2h_mrc_func {
+	RTW89_MAC_C2H_FUNC_MRC_TSF_RPT = 0,
+	RTW89_MAC_C2H_FUNC_MRC_STATUS_RPT = 1,
+};
+
 enum rtw89_mac_c2h_class {
-	RTW89_MAC_C2H_CLASS_INFO,
-	RTW89_MAC_C2H_CLASS_OFLD,
-	RTW89_MAC_C2H_CLASS_TWT,
-	RTW89_MAC_C2H_CLASS_WOW,
-	RTW89_MAC_C2H_CLASS_MCC,
-	RTW89_MAC_C2H_CLASS_FWDBG,
+	RTW89_MAC_C2H_CLASS_INFO = 0x0,
+	RTW89_MAC_C2H_CLASS_OFLD = 0x1,
+	RTW89_MAC_C2H_CLASS_TWT = 0x2,
+	RTW89_MAC_C2H_CLASS_WOW = 0x3,
+	RTW89_MAC_C2H_CLASS_MCC = 0x4,
+	RTW89_MAC_C2H_CLASS_FWDBG = 0x5,
+	RTW89_MAC_C2H_CLASS_MRC = 0xe,
 	RTW89_MAC_C2H_CLASS_MAX,
 };
 
@@ -441,6 +447,12 @@ enum rtw89_mac_mcc_status {
 	RTW89_MAC_MCC_TXNULL1_FAIL = 27,
 };
 
+enum rtw89_mac_mrc_status {
+	RTW89_MAC_MRC_START_SCH_OK = 0,
+	RTW89_MAC_MRC_STOP_SCH_OK = 1,
+	RTW89_MAC_MRC_DEL_SCH_OK = 2,
+};
+
 struct rtw89_mac_ax_coex {
 #define RTW89_MAC_AX_COEX_RTK_MODE 0
 #define RTW89_MAC_AX_COEX_CSR_MODE 1
-- 
2.25.1


