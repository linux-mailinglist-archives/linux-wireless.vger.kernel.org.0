Return-Path: <linux-wireless+bounces-10717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5342D94275E
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 09:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF2C1F26A32
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 07:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B7315884D;
	Wed, 31 Jul 2024 07:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Z9OdlVCZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7279F16CD03
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 07:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722409535; cv=none; b=ua0P8OJ5f4mZOlYvDm/gAvQ8OiiQTy6Td0taZJekgamnTGKHEUXgBFTrFgXtw8sGQu4JjsgKH51coRoopedt/GQVAgBMPfFkhwepu8enLoE/A2xpO9LQzCzGbNq7fcNXn5rz+EZp6+wAHPwDYHkkaCSV/ft7hqy/aVryrRsc8LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722409535; c=relaxed/simple;
	bh=QpJH3x6cQ+b97Mt+6c1aKPsduw7olRjezVs74tglT78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eWlj0ZKCW9V5Z3nDY3cSyws+yptBblgTgiS4LtfR5CoviSfQNfB14OKtRfosVqBoN9v0p9IplsD17bvmfMJz6pUqAXQxvAN4pKeaSpXTxGpbTFEKiPavSL+JnUoC2/6mB41uKOcx2Y99PxSvVTp4kMJI+gjFi71DokbPVwn3TXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Z9OdlVCZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46V75TfN42075353, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722409529; bh=QpJH3x6cQ+b97Mt+6c1aKPsduw7olRjezVs74tglT78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Z9OdlVCZi+wy1v4eGGr25esMDjFpUHnhLMKwXoFajBr18VSMxrVRX31tbFwk09SEl
	 5pkglghI7GGzdUWyBvZeMKut1HXhqw917BiZWZwOI0OyfkXB67EuH1p8g/g6uU7mdy
	 zmH7jWLwlw5MV/dfqTubl5uqhfQYBR+2wVa3xig+DQ7S+E9k/w7VBaa3pDehJX21UH
	 vI+uwEFwszOBr5GbLvudW8hM2H1DcbHfeX14D+aGzlGJtGr6z7tkePYAaM+AUvh5fe
	 GyVPIFFEaBlr9V28PVLvDqa0VDQI1g3G04mARU5J8CDeA217tWN3rwZ3tN19VUr8D2
	 CydtJqhIP3uIA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46V75TfN42075353
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 15:05:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 15:05:30 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 31 Jul
 2024 15:05:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH 1/5] wifi: rtw89: 8922a: new implementation for RFK pre-notify H2C
Date: Wed, 31 Jul 2024 15:05:02 +0800
Message-ID: <20240731070506.46100-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240731070506.46100-1-pkshih@realtek.com>
References: <20240731070506.46100-1-pkshih@realtek.com>
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

For firmware version 0.35.31 and above, update H2C RFK
pre-notify to new implementation. Rename existing H2C
to v0 for backward compatibility.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 62 +++++++++++++++--------
 drivers/net/wireless/realtek/rtw89/fw.h   | 12 ++++-
 3 files changed, 53 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d7d98678184b..9e26763d3269 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4358,6 +4358,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_BEACON_FILTER,
 	RTW89_FW_FEATURE_MACID_PAUSE_SLEEP,
 	RTW89_FW_FEATURE_WOW_REASON_V1,
+	RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V0,
 };
 
 struct rtw89_fw_suit {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index b9bf9ae3a512..fcbc7de48ddd 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -685,6 +685,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 35, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 12, 0, BEACON_FILTER),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 22, 0, WOW_REASON_V1),
+	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 31, 0, RFK_PRE_NOTIFY_V0),
 };
 
 static void rtw89_fw_iterate_feature_cfg(struct rtw89_fw_info *fw,
@@ -5136,14 +5137,21 @@ int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 			     enum rtw89_phy_idx phy_idx)
 {
 	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
+	struct rtw89_fw_h2c_rfk_pre_info_v0 *h2c_v0;
 	struct rtw89_fw_h2c_rfk_pre_info *h2c;
 	u8 tbl_sel = rfk_mcc->table_idx;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
+	u8 ver = U8_MAX;
 	u8 tbl, path;
 	u32 val32;
 	int ret;
 
+	if (RTW89_CHK_FW_FEATURE(RFK_PRE_NOTIFY_V0, &rtwdev->fw)) {
+		len = sizeof(*h2c_v0);
+		ver = 0;
+	}
+
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for h2c rfk_pre_ntfy\n");
@@ -5152,41 +5160,53 @@ int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 	skb_put(skb, len);
 	h2c = (struct rtw89_fw_h2c_rfk_pre_info *)skb->data;
 
-	h2c->mlo_mode = cpu_to_le32(rtwdev->mlo_dbcc_mode);
+	h2c->common.mlo_mode = cpu_to_le32(rtwdev->mlo_dbcc_mode);
 
 	BUILD_BUG_ON(NUM_OF_RTW89_FW_RFK_TBL > RTW89_RFK_CHS_NR);
 
 	for (tbl = 0; tbl < NUM_OF_RTW89_FW_RFK_TBL; tbl++) {
 		for (path = 0; path < NUM_OF_RTW89_FW_RFK_PATH; path++) {
-			h2c->dbcc.ch[path][tbl] = cpu_to_le32(rfk_mcc->ch[tbl]);
-			h2c->dbcc.band[path][tbl] = cpu_to_le32(rfk_mcc->band[tbl]);
+			h2c->common.dbcc.ch[path][tbl] =
+				cpu_to_le32(rfk_mcc->ch[tbl]);
+			h2c->common.dbcc.band[path][tbl] =
+				cpu_to_le32(rfk_mcc->band[tbl]);
 		}
 	}
 
 	for (path = 0; path < NUM_OF_RTW89_FW_RFK_PATH; path++) {
-		h2c->tbl.cur_ch[path] = cpu_to_le32(rfk_mcc->ch[tbl_sel]);
-		h2c->tbl.cur_band[path] = cpu_to_le32(rfk_mcc->band[tbl_sel]);
+		h2c->common.tbl.cur_ch[path] = cpu_to_le32(rfk_mcc->ch[tbl_sel]);
+		h2c->common.tbl.cur_band[path] = cpu_to_le32(rfk_mcc->band[tbl_sel]);
 	}
 
-	h2c->phy_idx = cpu_to_le32(phy_idx);
-	h2c->cur_band = cpu_to_le32(rfk_mcc->band[tbl_sel]);
-	h2c->cur_bw = cpu_to_le32(rfk_mcc->bw[tbl_sel]);
-	h2c->cur_center_ch = cpu_to_le32(rfk_mcc->ch[tbl_sel]);
-
-	val32 = rtw89_phy_read32_mask(rtwdev, R_COEF_SEL, B_COEF_SEL_IQC_V1);
-	h2c->ktbl_sel0 = cpu_to_le32(val32);
-	val32 = rtw89_phy_read32_mask(rtwdev, R_COEF_SEL_C1, B_COEF_SEL_IQC_V1);
-	h2c->ktbl_sel1 = cpu_to_le32(val32);
-	val32 = rtw89_read_rf(rtwdev, RF_PATH_A, RR_CFGCH, RFREG_MASK);
-	h2c->rfmod0 = cpu_to_le32(val32);
-	val32 = rtw89_read_rf(rtwdev, RF_PATH_B, RR_CFGCH, RFREG_MASK);
-	h2c->rfmod1 = cpu_to_le32(val32);
+	h2c->common.phy_idx = cpu_to_le32(phy_idx);
 
-	if (rtw89_is_mlo_1_1(rtwdev))
-		h2c->mlo_1_1 = cpu_to_le32(1);
+	if (ver == 0) { /* RFK_PRE_NOTIFY_V0 */
+		h2c_v0 = (struct rtw89_fw_h2c_rfk_pre_info_v0 *)skb->data;
+
+		h2c_v0->cur_band = cpu_to_le32(rfk_mcc->band[tbl_sel]);
+		h2c_v0->cur_bw = cpu_to_le32(rfk_mcc->bw[tbl_sel]);
+		h2c_v0->cur_center_ch = cpu_to_le32(rfk_mcc->ch[tbl_sel]);
+
+		val32 = rtw89_phy_read32_mask(rtwdev, R_COEF_SEL, B_COEF_SEL_IQC_V1);
+		h2c_v0->ktbl_sel0 = cpu_to_le32(val32);
+		val32 = rtw89_phy_read32_mask(rtwdev, R_COEF_SEL_C1, B_COEF_SEL_IQC_V1);
+		h2c_v0->ktbl_sel1 = cpu_to_le32(val32);
+		val32 = rtw89_read_rf(rtwdev, RF_PATH_A, RR_CFGCH, RFREG_MASK);
+		h2c_v0->rfmod0 = cpu_to_le32(val32);
+		val32 = rtw89_read_rf(rtwdev, RF_PATH_B, RR_CFGCH, RFREG_MASK);
+		h2c_v0->rfmod1 = cpu_to_le32(val32);
 
-	h2c->rfe_type = cpu_to_le32(rtwdev->efuse.rfe_type);
+		if (rtw89_is_mlo_1_1(rtwdev))
+			h2c_v0->mlo_1_1 = cpu_to_le32(1);
 
+		h2c_v0->rfe_type = cpu_to_le32(rtwdev->efuse.rfe_type);
+
+		goto done;
+	}
+
+	if (rtw89_is_mlo_1_1(rtwdev))
+		h2c->mlo_1_1 = cpu_to_le32(1);
+done:
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RF_FW_RFK,
 			      H2C_FUNC_RFK_PRE_NOTIFY, 0, 0,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 7d48383c6244..dccda3a12616 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4106,7 +4106,7 @@ struct rtw89_fw_h2c_rf_get_mccch {
 #define NUM_OF_RTW89_FW_RFK_PATH 2
 #define NUM_OF_RTW89_FW_RFK_TBL 3
 
-struct rtw89_fw_h2c_rfk_pre_info {
+struct rtw89_fw_h2c_rfk_pre_info_common {
 	struct {
 		__le32 ch[NUM_OF_RTW89_FW_RFK_PATH][NUM_OF_RTW89_FW_RFK_TBL];
 		__le32 band[NUM_OF_RTW89_FW_RFK_PATH][NUM_OF_RTW89_FW_RFK_TBL];
@@ -4119,6 +4119,11 @@ struct rtw89_fw_h2c_rfk_pre_info {
 	} __packed tbl;
 
 	__le32 phy_idx;
+} __packed;
+
+struct rtw89_fw_h2c_rfk_pre_info_v0 {
+	struct rtw89_fw_h2c_rfk_pre_info_common common;
+
 	__le32 cur_band;
 	__le32 cur_bw;
 	__le32 cur_center_ch;
@@ -4138,6 +4143,11 @@ struct rtw89_fw_h2c_rfk_pre_info {
 	} __packed mlo;
 } __packed;
 
+struct rtw89_fw_h2c_rfk_pre_info {
+	struct rtw89_fw_h2c_rfk_pre_info_common common;
+	__le32 mlo_1_1;
+} __packed;
+
 struct rtw89_h2c_rf_tssi {
 	__le16 len;
 	u8 phy;
-- 
2.25.1


