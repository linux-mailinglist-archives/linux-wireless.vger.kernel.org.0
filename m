Return-Path: <linux-wireless+bounces-22435-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00091AA8CFA
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 09:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C74C47A84CC
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 07:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60AD1DDA00;
	Mon,  5 May 2025 07:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="iXjLPkjL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906D31DF75D
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 07:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746429913; cv=none; b=gug9QZc82fsNU+qwza2c9fAuZEtDhYc6xAMLSLkykU0TYKEc0AM7IbJwjV642mbwSYyJmWjZxIO0StJecsJQBB+op5t+2Xh6IpusvFvnfYUd5pD0oTfzHto/aJ9GMVVJGWfI0bo2nsu/SaHKHE1psvYEROEKq8oIw72mcCN3tng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746429913; c=relaxed/simple;
	bh=yFjAPDpDiAsfnPqCUk7fkKe2vULYOdTvnqIeFl9y5jA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tIzh/jphb7doJp3rbkK4TZnrczRO+3AVP0hdl+WVUTbJC0279UNE1VKW0w61mccwLX18cHjiL2Geapbs3E/I9vzfEiEqB8IgxHv/GWAGMcQ+EkPDnho04y5WqnIWmdfPzE86IVKSWb1b2ZCU5euRME9W0h078JyQ2QOgAjiqxJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=iXjLPkjL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5457P9FR03831182, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746429909; bh=yFjAPDpDiAsfnPqCUk7fkKe2vULYOdTvnqIeFl9y5jA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=iXjLPkjLEd4+s7heVqW06Wx7Cn5B4L7bJGeOC7Epq4GQMf5BgPefHItNCpGG/YKAM
	 IvSHKCWh3UZ66bWvnADoCK8q2y3rl50MBRE+Ir0TxhOZRwA1NG+v6rdxrSD7NlONUD
	 HnGRiWqvFLj9AgUZs5pWJxaec98+x4Jop1qcHmUFrmQaCoOkahN7WxdcSvDNekJfqz
	 I1itxdN5CWN8WsKuwzLy/RIB8D673Kb8wIV6pLw4AM6U81v02b0bjbjYKYSoO6T1te
	 B4Gu4YbKtuvFzH5Lgzk5BaLM+woeakvrJuM0ZWWf2ZCI9zCFw7lXHrsaMBbz6bJuso
	 8dQg0hSHjqcPA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5457P9FR03831182
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 5 May 2025 15:25:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 May 2025 15:25:09 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 5 May
 2025 15:25:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 05/11] wifi: rtw89: add handling of mlo_link_cfg H2C command and C2H event
Date: Mon, 5 May 2025 15:24:34 +0800
Message-ID: <20250505072440.45113-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250505072440.45113-1-pkshih@realtek.com>
References: <20250505072440.45113-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

The mlo_link_cfg H2C command is used to tell FW to enter/leave PS mode
on a given link. And, need to wait for status of C2H event to ensure if
FW deals with it successfully.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  1 +
 drivers/net/wireless/realtek/rtw89/core.h |  5 +++
 drivers/net/wireless/realtek/rtw89/fw.c   | 41 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h   | 48 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.c  | 39 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h  | 13 ++++++
 6 files changed, 147 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 1546e3d8e2e0..b7b2670cbc88 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4945,6 +4945,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	rtwdev->total_sta_assoc = 0;
 
 	rtw89_init_wait(&rtwdev->mcc.wait);
+	rtw89_init_wait(&rtwdev->mlo.wait);
 	rtw89_init_wait(&rtwdev->mac.fw_ofld_wait);
 	rtw89_init_wait(&rtwdev->wow.wait);
 	rtw89_init_wait(&rtwdev->mac.ps_wait);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4e44cbd6cc53..86bbe8cf8cc0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5738,6 +5738,10 @@ struct rtw89_mcc_info {
 	struct rtw89_mcc_config config;
 };
 
+struct rtw89_mlo_info {
+	struct rtw89_wait_info wait;
+};
+
 struct rtw89_dev {
 	struct ieee80211_hw *hw;
 	struct device *dev;
@@ -5753,6 +5757,7 @@ struct rtw89_dev {
 	const struct rtw89_rfe_parms *rfe_parms;
 	struct rtw89_hal hal;
 	struct rtw89_mcc_info mcc;
+	struct rtw89_mlo_info mlo;
 	struct rtw89_mac_info mac;
 	struct rtw89_fw_info fw;
 	struct rtw89_hci_info hci;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 23f4dea64dc6..aa748fe3f39e 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -8956,6 +8956,47 @@ int rtw89_fw_h2c_ap_info_refcount(struct rtw89_dev *rtwdev, bool en)
 	return 0;
 }
 
+int rtw89_fw_h2c_mlo_link_cfg(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
+			      bool enable)
+{
+	struct rtw89_wait_info *wait = &rtwdev->mlo.wait;
+	struct rtw89_h2c_mlo_link_cfg *h2c;
+	u8 mac_id = rtwvif_link->mac_id;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	unsigned int cond;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for mlo link cfg\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_mlo_link_cfg *)skb->data;
+
+	h2c->w0 = le32_encode_bits(mac_id, RTW89_H2C_MLO_LINK_CFG_W0_MACID) |
+		  le32_encode_bits(enable, RTW89_H2C_MLO_LINK_CFG_W0_OPTION);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MLO,
+			      H2C_FUNC_MLO_LINK_CFG, 0, 0,
+			      len);
+
+	cond = RTW89_MLO_WAIT_COND(mac_id, H2C_FUNC_MLO_LINK_CFG);
+
+	ret = rtw89_h2c_tx_and_wait(rtwdev, skb, wait, cond);
+	if (ret) {
+		rtw89_err(rtwdev, "mlo link cfg (%s link id %u) failed: %d\n",
+			  str_enable_disable(enable), rtwvif_link->link_id, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static bool __fw_txpwr_entry_zero_ext(const void *ext_ptr, u8 ext_len)
 {
 	static const u8 zeros[U8_MAX] = {};
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 559f3f6190eb..207ec88ea456 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2865,6 +2865,13 @@ struct rtw89_h2c_fwips {
 #define RTW89_H2C_FW_IPS_W0_MACID GENMASK(7, 0)
 #define RTW89_H2C_FW_IPS_W0_ENABLE BIT(8)
 
+struct rtw89_h2c_mlo_link_cfg {
+	__le32 w0;
+};
+
+#define RTW89_H2C_MLO_LINK_CFG_W0_MACID GENMASK(15, 0)
+#define RTW89_H2C_MLO_LINK_CFG_W0_OPTION GENMASK(19, 16)
+
 static inline void RTW89_SET_FWCMD_P2P_MACID(void *cmd, u32 val)
 {
 	le32p_replace_bits((__le32 *)cmd, val, GENMASK(7, 0));
@@ -3733,6 +3740,25 @@ static_assert(sizeof(struct rtw89_mac_mcc_tsf_rpt) <= RTW89_COMPLETION_BUF_SIZE)
 #define RTW89_GET_MAC_C2H_MCC_STATUS_RPT_TSF_HIGH(c2h) \
 	le32_get_bits(*((const __le32 *)(c2h) + 4), GENMASK(31, 0))
 
+struct rtw89_c2h_mlo_link_cfg_rpt {
+	struct rtw89_c2h_hdr hdr;
+	__le32 w2;
+} __packed;
+
+#define RTW89_C2H_MLO_LINK_CFG_RPT_W2_MACID GENMASK(15, 0)
+#define RTW89_C2H_MLO_LINK_CFG_RPT_W2_STATUS GENMASK(19, 16)
+
+enum rtw89_c2h_mlo_link_status {
+	RTW89_C2H_MLO_LINK_CFG_IDLE = 0,
+	RTW89_C2H_MLO_LINK_CFG_DONE = 1,
+	RTW89_C2H_MLO_LINK_CFG_ISSUE_NULL_FAIL = 2,
+	RTW89_C2H_MLO_LINK_CFG_TX_NULL_FAIL = 3,
+	RTW89_C2H_MLO_LINK_CFG_ROLE_NOT_EXIST = 4,
+	RTW89_C2H_MLO_LINK_CFG_NULL_1_TIMEOUT = 5,
+	RTW89_C2H_MLO_LINK_CFG_NULL_0_TIMEOUT = 6,
+	RTW89_C2H_MLO_LINK_CFG_RUNNING = 0xff,
+};
+
 struct rtw89_mac_mrc_tsf_rpt {
 	unsigned int num;
 	u64 tsfs[RTW89_MAC_MRC_MAX_REQ_TSF_NUM];
@@ -4252,6 +4278,26 @@ enum rtw89_mcc_h2c_func {
 #define RTW89_MCC_WAIT_COND(group, func) \
 	((group) * NUM_OF_RTW89_MCC_H2C_FUNC + (func))
 
+/* CLASS 20 - MLO */
+#define H2C_CL_MLO                     0x14
+enum rtw89_mlo_h2c_func {
+	H2C_FUNC_MLO_TBL_CFG		= 0x0,
+	H2C_FUNC_MLO_STA_CFG		= 0x1,
+	H2C_FUNC_MLO_TTLM		= 0x2,
+	H2C_FUNC_MLO_DM_CFG		= 0x3,
+	H2C_FUNC_MLO_EMLSR_STA_CFG	= 0x4,
+	H2C_FUNC_MLO_MCMLO_RELINK_DROP	= 0x5,
+	H2C_FUNC_MLO_MCMLO_SN_SYNC	= 0x6,
+	H2C_FUNC_MLO_RELINK		= 0x7,
+	H2C_FUNC_MLO_LINK_CFG		= 0x8,
+	H2C_FUNC_MLO_DM_DBG		= 0x9,
+
+	NUM_OF_RTW89_MLO_H2C_FUNC,
+};
+
+#define RTW89_MLO_WAIT_COND(macid, func) \
+	((macid) * NUM_OF_RTW89_MLO_H2C_FUNC + (func))
+
 /* CLASS 24 - MRC */
 #define H2C_CL_MRC			0x18
 enum rtw89_mrc_h2c_func {
@@ -4829,6 +4875,8 @@ int rtw89_fw_h2c_mrc_sync(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_mrc_upd_duration(struct rtw89_dev *rtwdev,
 				  const struct rtw89_fw_mrc_upd_duration_arg *arg);
 int rtw89_fw_h2c_ap_info_refcount(struct rtw89_dev *rtwdev, bool en);
+int rtw89_fw_h2c_mlo_link_cfg(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
+			      bool enable);
 
 static inline void rtw89_fw_h2c_init_ba_cam(struct rtw89_dev *rtwdev)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 449865f7b7a9..e3976ba6dda2 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5408,6 +5408,27 @@ rtw89_mac_c2h_wow_aoac_rpt(struct rtw89_dev *rtwdev, struct sk_buff *skb, u32 le
 	rtw89_complete_cond(wait, RTW89_WOW_WAIT_COND_AOAC, &data);
 }
 
+static void
+rtw89_mac_c2h_mlo_link_cfg_stat(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+	const struct rtw89_c2h_mlo_link_cfg_rpt *c2h_rpt;
+	struct rtw89_wait_info *wait = &rtwdev->mlo.wait;
+	struct rtw89_completion_data data = {};
+	unsigned int cond;
+	u16 mac_id;
+	u8 status;
+
+	c2h_rpt = (const struct rtw89_c2h_mlo_link_cfg_rpt *)c2h->data;
+
+	mac_id = le32_get_bits(c2h_rpt->w2, RTW89_C2H_MLO_LINK_CFG_RPT_W2_MACID);
+	status = le32_get_bits(c2h_rpt->w2, RTW89_C2H_MLO_LINK_CFG_RPT_W2_STATUS);
+
+	data.err = status == RTW89_C2H_MLO_LINK_CFG_ROLE_NOT_EXIST ||
+		   status == RTW89_C2H_MLO_LINK_CFG_RUNNING;
+	cond = RTW89_MLO_WAIT_COND(mac_id, H2C_FUNC_MLO_LINK_CFG);
+	rtw89_complete_cond(wait, cond, &data);
+}
+
 static void
 rtw89_mac_c2h_mrc_status_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
@@ -5562,6 +5583,18 @@ void (* const rtw89_mac_c2h_mcc_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_MAC_C2H_FUNC_MCC_STATUS_RPT] = rtw89_mac_c2h_mcc_status_rpt,
 };
 
+static
+void (* const rtw89_mac_c2h_mlo_handler[])(struct rtw89_dev *rtwdev,
+					   struct sk_buff *c2h, u32 len) = {
+	[RTW89_MAC_C2H_FUNC_MLO_GET_TBL] = NULL,
+	[RTW89_MAC_C2H_FUNC_MLO_EMLSR_TRANS_DONE] = NULL,
+	[RTW89_MAC_C2H_FUNC_MLO_EMLSR_STA_CFG_DONE] = NULL,
+	[RTW89_MAC_C2H_FUNC_MCMLO_RELINK_RPT] = NULL,
+	[RTW89_MAC_C2H_FUNC_MCMLO_SN_SYNC_RPT] = NULL,
+	[RTW89_MAC_C2H_FUNC_MLO_LINK_CFG_STAT] = rtw89_mac_c2h_mlo_link_cfg_stat,
+	[RTW89_MAC_C2H_FUNC_MLO_DM_DBG_DUMP] = NULL,
+};
+
 static
 void (* const rtw89_mac_c2h_mrc_handler[])(struct rtw89_dev *rtwdev,
 					   struct sk_buff *c2h, u32 len) = {
@@ -5631,6 +5664,8 @@ bool rtw89_mac_c2h_chk_atomic(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 		}
 	case RTW89_MAC_C2H_CLASS_MCC:
 		return true;
+	case RTW89_MAC_C2H_CLASS_MLO:
+		return true;
 	case RTW89_MAC_C2H_CLASS_MRC:
 		return true;
 	case RTW89_MAC_C2H_CLASS_WOW:
@@ -5664,6 +5699,10 @@ void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 		if (func < NUM_OF_RTW89_MAC_C2H_FUNC_MCC)
 			handler = rtw89_mac_c2h_mcc_handler[func];
 		break;
+	case RTW89_MAC_C2H_CLASS_MLO:
+		if (func < NUM_OF_RTW89_MAC_C2H_FUNC_MLO)
+			handler = rtw89_mac_c2h_mlo_handler[func];
+		break;
 	case RTW89_MAC_C2H_CLASS_MRC:
 		if (func < NUM_OF_RTW89_MAC_C2H_FUNC_MRC)
 			handler = rtw89_mac_c2h_mrc_handler[func];
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 47d655fbf2ca..e1083b0f8136 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -427,6 +427,18 @@ enum rtw89_mac_c2h_mcc_func {
 	NUM_OF_RTW89_MAC_C2H_FUNC_MCC,
 };
 
+enum rtw89_mac_c2h_mlo_func {
+	RTW89_MAC_C2H_FUNC_MLO_GET_TBL			= 0x0,
+	RTW89_MAC_C2H_FUNC_MLO_EMLSR_TRANS_DONE		= 0x1,
+	RTW89_MAC_C2H_FUNC_MLO_EMLSR_STA_CFG_DONE	= 0x2,
+	RTW89_MAC_C2H_FUNC_MCMLO_RELINK_RPT		= 0x3,
+	RTW89_MAC_C2H_FUNC_MCMLO_SN_SYNC_RPT		= 0x4,
+	RTW89_MAC_C2H_FUNC_MLO_LINK_CFG_STAT		= 0x5,
+	RTW89_MAC_C2H_FUNC_MLO_DM_DBG_DUMP		= 0x6,
+
+	NUM_OF_RTW89_MAC_C2H_FUNC_MLO,
+};
+
 enum rtw89_mac_c2h_mrc_func {
 	RTW89_MAC_C2H_FUNC_MRC_TSF_RPT = 0,
 	RTW89_MAC_C2H_FUNC_MRC_STATUS_RPT = 1,
@@ -453,6 +465,7 @@ enum rtw89_mac_c2h_class {
 	RTW89_MAC_C2H_CLASS_WOW = 0x3,
 	RTW89_MAC_C2H_CLASS_MCC = 0x4,
 	RTW89_MAC_C2H_CLASS_FWDBG = 0x5,
+	RTW89_MAC_C2H_CLASS_MLO = 0xc,
 	RTW89_MAC_C2H_CLASS_MRC = 0xe,
 	RTW89_MAC_C2H_CLASS_AP = 0x18,
 	RTW89_MAC_C2H_CLASS_MAX,
-- 
2.25.1


