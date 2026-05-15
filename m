Return-Path: <linux-wireless+bounces-36451-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBxVJhR7BmqFkAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36451-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:47:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6EA54887F
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DB75303308E
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 01:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB441E9B3A;
	Fri, 15 May 2026 01:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jOGJ5Wj8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F072816A956
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 01:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809548; cv=none; b=eF2Zh/nu72ARdt5iLwgHYbHXTzS2fZtY2eattWT2FqP1s0/he+s2hIwCc8doet/Xz/QLsfkqurckZWuxeD/26yaoS47IrkJ61M16zDQEdNutA/3D8GtK1p0T8n+KF3qKRerB4CU9iJaUGW9Ij0d9PzuaQeLjJ7i41G7Jvooegio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809548; c=relaxed/simple;
	bh=Lkm+ehHBCVACMkPld1ID8RZYb2eLur7Zu8elDuahB5I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fEWw1tQUqFW5oMRED0rFQEsXbNNi8CZwwtBURcIflVDZFcDy50le59UKELyNQkj9LVbXYIguRvxXQYrmHTvnK3EaySQnqHRi5DJndUzLIUsa3Vzxzs4fujEpfAj/WOM/I71tsYU7ns0gNM+DSg8VCe8GhOmZQjNmBUEdGjg/x5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jOGJ5Wj8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64F1jj1vB2587340, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778809545; bh=GO4kqwD5aakoIpOq/gQdrvYgD4q80F8iP6IdbDUgQ0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=jOGJ5Wj8lvZ5AuLoFex6j52KIbcX7RA3pGkVde2fAHe4cRu2kH8zFhzNDfAZtUetb
	 yUW6aCS3IK5dtE0patB+uJ+HSAENNfME8XgaKhp32ztgyumbfce55fDfA7grRlk0n3
	 PSHt3sZLXzkI8Wr7xiSdzzwFx1ZVPv8oAWtbxzpXjRn+J1n9OIcp3AIPNVAp3d5iXC
	 ro11U7pIVDdD/pFq2nHU1YGxhEOBbNtUQlCYqSbgd23WLUu4x/TupL1/LRdfsH1RAH
	 Zp7YlW2BExKeonOeYxs02VkejxYtDuLAHoZx7cFQ7UZf7bHJJg6PcMj478vP+uNBGl
	 3LBSfjG/JDhrQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64F1jj1vB2587340
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 09:45:45 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 May 2026 09:45:44 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 15 May 2026 09:45:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <dian_syuan0116@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 12/13] wifi: rtw89: mac: consolidate quota into a struct for variant chips
Date: Fri, 15 May 2026 09:44:32 +0800
Message-ID: <20260515014433.16168-13-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260515014433.16168-1-pkshih@realtek.com>
References: <20260515014433.16168-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 2A6EA54887F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36451-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:mid,realtek.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

RTL8922D has many variants, using different quota tables. Consolidate the
quota data into a struct, and then select corresponding table for the
chip variant.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 20 +++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/mac.c      |  6 ++++--
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  6 ++++--
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  6 ++++--
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  6 ++++--
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  6 ++++--
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  6 ++++--
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  7 +++++--
 drivers/net/wireless/realtek/rtw89/rtw8922d.c |  7 +++++--
 9 files changed, 52 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index fa5ba90f11c6..86e59dcccdff 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4229,6 +4229,11 @@ struct rtw89_fw_def {
 	u16 fw_b_aid;
 };
 
+struct rtw89_qta_def {
+	const struct rtw89_hfc_param_ini *hfc_param_ini[RTW89_HCI_DLE_TYPE_NUM];
+	const struct rtw89_dle_mem *dle_mem[RTW89_HCI_DLE_TYPE_NUM];
+};
+
 struct rtw89_phy_table {
 	const struct rtw89_reg2_def *regs;
 	u32 n_regs;
@@ -4643,8 +4648,7 @@ struct rtw89_chip_info {
 	u16 max_rx_agg_num;
 	bool dis_2g_40m_ul_ofdma;
 	u32 rsvd_ple_ofst;
-	const struct rtw89_hfc_param_ini *hfc_param_ini[RTW89_HCI_DLE_TYPE_NUM];
-	const struct rtw89_dle_mem *dle_mem[RTW89_HCI_DLE_TYPE_NUM];
+	struct rtw89_qta_def qta_def;
 	u8 wde_qempty_acq_grpnum;
 	u8 wde_qempty_mgq_grpsel;
 	u32 rf_base_addr[2];
@@ -4773,6 +4777,7 @@ struct rtw89_chip_variant {
 	bool no_mcs_12_13: 1;
 	u32 fw_min_ver_code;
 	const struct rtw89_fw_def *fw_def_override;
+	const struct rtw89_qta_def *qta_def_override;
 };
 
 union rtw89_bus_info {
@@ -7722,6 +7727,17 @@ const struct rtw89_fw_def *rtw89_chip_get_fw_def(struct rtw89_dev *rtwdev)
 	return __rtw89_chip_get_fw_def(rtwdev->chip, rtwdev->variant);
 }
 
+static inline
+const struct rtw89_qta_def *rtw89_chip_get_qta_def(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_variant *variant = rtwdev->variant;
+
+	if (variant && variant->qta_def_override)
+		return variant->qta_def_override;
+
+	return &rtwdev->chip->qta_def;
+}
+
 static inline void rtw89_load_txpwr_table(struct rtw89_dev *rtwdev,
 					  const struct rtw89_txpwr_table *tbl)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 5c22b2accf7c..bd606d1da634 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -894,11 +894,12 @@ EXPORT_SYMBOL(rtw89_mac_set_err_status);
 
 static int hfc_reset_param(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_qta_def *qta_def = rtw89_chip_get_qta_def(rtwdev);
 	const struct rtw89_hfc_param_ini *param_ini, *param_inis;
 	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
 	u8 qta_mode = rtwdev->mac.dle_info.qta_mode;
 
-	param_inis = rtwdev->chip->hfc_param_ini[rtwdev->hci.dle_type];
+	param_inis = qta_def->hfc_param_ini[rtwdev->hci.dle_type];
 	if (!param_inis)
 		return -EINVAL;
 
@@ -1897,10 +1898,11 @@ EXPORT_SYMBOL(rtw89_mac_size);
 static const struct rtw89_dle_mem *get_dle_mem_cfg(struct rtw89_dev *rtwdev,
 						   enum rtw89_qta_mode mode)
 {
+	const struct rtw89_qta_def *qta_def = rtw89_chip_get_qta_def(rtwdev);
 	struct rtw89_mac_info *mac = &rtwdev->mac;
 	const struct rtw89_dle_mem *cfg, *cfgs;
 
-	cfgs = rtwdev->chip->dle_mem[rtwdev->hci.dle_type];
+	cfgs = qta_def->dle_mem[rtwdev->hci.dle_type];
 	if (!cfgs)
 		return NULL;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index e047e716d9e3..cf2039fe81d3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2647,14 +2647,16 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.max_rx_agg_num		= 64,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
-	.hfc_param_ini		= {rtw8851b_hfc_param_ini_pcie,
+	.qta_def = {
+		.hfc_param_ini	= {rtw8851b_hfc_param_ini_pcie,
 				   rtw8851b_hfc_param_ini_usb,
 				   rtw8851b_hfc_param_ini_usb,
 				   NULL},
-	.dle_mem		= {rtw8851b_dle_mem_pcie,
+		.dle_mem	= {rtw8851b_dle_mem_pcie,
 				   rtw8851b_dle_mem_usb2,
 				   rtw8851b_dle_mem_usb3,
 				   NULL},
+	},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 686e489d42f2..5787a1aa7ea3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2384,14 +2384,16 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.max_rx_agg_num		= 64,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x6f800,
-	.hfc_param_ini		= {rtw8852a_hfc_param_ini_pcie,
+	.qta_def = {
+		.hfc_param_ini	= {rtw8852a_hfc_param_ini_pcie,
 				   rtw8852a_hfc_param_ini_usb,
 				   rtw8852a_hfc_param_ini_usb,
 				   NULL},
-	.dle_mem		= {rtw8852a_dle_mem_pcie,
+		.dle_mem	= {rtw8852a_dle_mem_pcie,
 				   rtw8852a_dle_mem_usb,
 				   rtw8852a_dle_mem_usb,
 				   NULL},
+	},
 	.wde_qempty_acq_grpnum	= 16,
 	.wde_qempty_mgq_grpsel	= 16,
 	.rf_base_addr		= {0xc000, 0xd000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 6ab99f72fda7..74feea6e7909 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -978,14 +978,16 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.max_rx_agg_num		= 64,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
-	.hfc_param_ini		= {rtw8852b_hfc_param_ini_pcie,
+	.qta_def = {
+		.hfc_param_ini	= {rtw8852b_hfc_param_ini_pcie,
 				   rtw8852b_hfc_param_ini_usb,
 				   rtw8852b_hfc_param_ini_usb,
 				   NULL},
-	.dle_mem		= {rtw8852b_dle_mem_pcie,
+		.dle_mem	= {rtw8852b_dle_mem_pcie,
 				   rtw8852b_dle_mem_usb3,
 				   rtw8852b_dle_mem_usb3,
 				   NULL},
+	},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000, 0xf000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 83de26273100..fc569e4723bd 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -824,8 +824,10 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.max_rx_agg_num		= 64,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x6f800,
-	.hfc_param_ini		= {rtw8852bt_hfc_param_ini_pcie, NULL, NULL, NULL},
-	.dle_mem		= {rtw8852bt_dle_mem_pcie, NULL, NULL, NULL},
+	.qta_def = {
+		.hfc_param_ini	= {rtw8852bt_hfc_param_ini_pcie, NULL, NULL, NULL},
+		.dle_mem	= {rtw8852bt_dle_mem_pcie, NULL, NULL, NULL},
+	},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000, 0xf000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index cc278587b532..1e4c555284f3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3173,14 +3173,16 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.max_rx_agg_num		= 64,
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x6f800,
-	.hfc_param_ini		= {rtw8852c_hfc_param_ini_pcie,
+	.qta_def = {
+		.hfc_param_ini	= {rtw8852c_hfc_param_ini_pcie,
 				   rtw8852c_hfc_param_ini_usb,
 				   rtw8852c_hfc_param_ini_usb,
 				   NULL},
-	.dle_mem		= {rtw8852c_dle_mem_pcie,
+		.dle_mem	= {rtw8852c_dle_mem_pcie,
 				   rtw8852c_dle_mem_usb2,
 				   rtw8852c_dle_mem_usb3,
 				   NULL},
+	},
 	.wde_qempty_acq_grpnum	= 16,
 	.wde_qempty_mgq_grpsel	= 16,
 	.rf_base_addr		= {0xe000, 0xf000},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index e6f15ee2a86b..965c4c01a75f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -3168,14 +3168,16 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.max_rx_agg_num		= 64,
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x8f800,
-	.hfc_param_ini		= {rtw8922a_hfc_param_ini_pcie,
+	.qta_def = {
+		.hfc_param_ini	= {rtw8922a_hfc_param_ini_pcie,
 				   rtw8922a_hfc_param_ini_usb2,
 				   rtw8922a_hfc_param_ini_usb3,
 				   NULL},
-	.dle_mem		= {rtw8922a_dle_mem_pcie,
+		.dle_mem	= {rtw8922a_dle_mem_pcie,
 				   rtw8922a_dle_mem_usb2,
 				   rtw8922a_dle_mem_usb3,
 				   NULL},
+	},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000, 0xf000},
@@ -3306,6 +3308,7 @@ const struct rtw89_chip_variant rtw8922ae_vs_variant = {
 	.no_mcs_12_13 = true,
 	.fw_min_ver_code = RTW89_FW_VER_CODE(0, 35, 54, 0),
 	.fw_def_override = NULL,
+	.qta_def_override = NULL,
 };
 EXPORT_SYMBOL(rtw8922ae_vs_variant);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index baa9ead64aa2..2f0c3a5d937c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -3013,8 +3013,10 @@ const struct rtw89_chip_info rtw8922d_chip_info = {
 	.max_rx_agg_num		= 256,
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x5f800,
-	.hfc_param_ini		= {rtw8922d_hfc_param_ini_pcie, NULL, NULL, NULL},
-	.dle_mem		= {rtw8922d_dle_mem_pcie, NULL, NULL, NULL},
+	.qta_def = {
+		.hfc_param_ini	= {rtw8922d_hfc_param_ini_pcie, NULL, NULL, NULL},
+		.dle_mem	= {rtw8922d_dle_mem_pcie, NULL, NULL, NULL},
+	},
 	.wde_qempty_acq_grpnum	= 8,
 	.wde_qempty_mgq_grpsel	= 8,
 	.rf_base_addr		= {0x3e000, 0x3f000},
@@ -3150,6 +3152,7 @@ const struct rtw89_chip_variant rtw8922de_vs_variant = {
 	.no_mcs_12_13 = true,
 	.fw_min_ver_code = RTW89_FW_VER_CODE(0, 0, 0, 0),
 	.fw_def_override = &rtw8922de_vs_fw_def,
+	.qta_def_override = NULL,
 };
 EXPORT_SYMBOL(rtw8922de_vs_variant);
 
-- 
2.25.1


