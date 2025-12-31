Return-Path: <linux-wireless+bounces-30222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF52BCEBACB
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 10:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18808303D68E
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 09:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643852D660E;
	Wed, 31 Dec 2025 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="n9C/z2IZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4545B313E11
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767172078; cv=none; b=sECIBUfF56KO3BgDWJ4QfCwdmXMnU8I13ew249XCx6BfUwAyf0FcWvePxukMX/JmRLO8mjYxzvi0XpYEXSlWAAWct9mbOjR2OKa5dfA5diLhr//j0xP/BJWuy5gasv8QTKv+uPmik5oDdQ8SSi3Mf0bmeqp8Gtrli4nZO/RtHuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767172078; c=relaxed/simple;
	bh=H8hnWgmpJwAqwzR2TnRDNqW/e+/HecVq+TN8+XPgIkQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBB5FoDGYodg9vzR5Hdm/yEY0kaPwn+a2NmJO2fY4ogTqL/xb3AESYgpNwydFS1qPtY47DFYlgtxPM3ierg+yLIP9LgJnfHPWan7nukRq9zkOyIDeB78NwzUuwyd0NhlmXq8yJmTu9cFgZholZU556xMj2U1aF6zS5aXNZ91kcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=n9C/z2IZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BV97sUE2881266, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767172074; bh=O8A/jNrXD0H5oYu66gjPEuXJ4GN3//vFPevspLgUl/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=n9C/z2IZI9MhWTEgmHKEG1h//sxBRkVqtrqp2MBcnJ/dPKBY5WyjEUPP2nUOpmyzJ
	 FHaSHxsWk8LcnlbyJngVDoouQ3ooZxpT8RvXf9GnpzBAdw2d5odl3EeN01Um3PQjwD
	 rvx9N9i/fo45FBMsLerc0C/GXCJMJ6XMO0NAQnHzALqa3SelvjKxAkaA07917ccuwj
	 BZgsXPnK2+/tLUjWmTNhYtUKOkEaf+aCY/NAP+2wsvBPuTgG/8rmqjTMSvTmcmqsOw
	 YEn4uiKvO662d6KZlZqnjB44MABfcbe/iJaK92WDEf7k0RrCfOfiGe5hLAqrMuFgh+
	 EUjcMbwnIZpEw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BV97sUE2881266
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 17:07:54 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 17:07:54 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 17:07:53 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 31 Dec 2025 17:07:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 09/11] wifi: rtw89: rfk: update rtw89_fw_h2c_rf_pre_ntfy_mcc format
Date: Wed, 31 Dec 2025 17:06:45 +0800
Message-ID: <20251231090647.56407-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251231090647.56407-1-pkshih@realtek.com>
References: <20251231090647.56407-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Chih-Kang Chang <gary.chang@realtek.com>

The H2C command rtw89_fw_h2c_rf_pre_ntfy_mcc have different format.
8922A after FW 0.35.49.0 use v0, after FW 0.35.84.0 use v1. The coming
8922D will use v2.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  5 ++
 drivers/net/wireless/realtek/rtw89/fw.c       | 55 ++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/fw.h       | 12 +++-
 drivers/net/wireless/realtek/rtw89/phy.c      | 23 ++++----
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.c | 48 +++++++++++++++-
 5 files changed, 122 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 38a64b0bfb5c..661b6a23082a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4688,6 +4688,11 @@ enum rtw89_fw_feature {
 			       RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V2,
 			       RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V3,
 	),
+	RTW89_FW_FEATURE_GROUP(WITH_RFK_PRE_NOTIFY_MCC,
+			       RTW89_FW_FEATURE_RFK_PRE_NOTIFY_MCC_V0,
+			       RTW89_FW_FEATURE_RFK_PRE_NOTIFY_MCC_V1,
+			       RTW89_FW_FEATURE_RFK_PRE_NOTIFY_MCC_V2,
+	),
 	RTW89_FW_FEATURE_RFK_RXDCK_V0,
 	RTW89_FW_FEATURE_RFK_IQK_V0,
 	RTW89_FW_FEATURE_NO_WOW_CPU_IO_RX,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index fed9b3db1543..24077a8095c4 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -912,6 +912,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 46, 0, NOTIFY_AP_INFO),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 47, 0, CH_INFO_BE_V0),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 49, 0, RFK_PRE_NOTIFY_V2),
+	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 49, 0, RFK_PRE_NOTIFY_MCC_V0),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 51, 0, NO_PHYCAP_P1),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 64, 0, NO_POWER_DIFFERENCE),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 71, 0, BEACON_LOSS_COUNT_V1),
@@ -919,6 +920,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 79, 0, CRASH_TRIGGER_TYPE_1),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 80, 0, BEACON_TRACKING),
 	__DIS_FW_FEAT(RTL8922A, ge, 0, 35, 84, 0, WITH_RFK_PRE_NOTIFY, G),
+	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 84, 0, RFK_PRE_NOTIFY_MCC_V1),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 84, 0, ADDR_CAM_V0),
 };
 
@@ -6529,45 +6531,84 @@ int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_rf_pre_ntfy_mcc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	struct rtw89_rfk_mcc_info_data *rfk_mcc = rtwdev->rfk_mcc.data;
+	struct rtw89_rfk_mcc_info *rfk_mcc_v0 = &rtwdev->rfk_mcc;
+	struct rtw89_fw_h2c_rfk_pre_info_mcc_v0 *h2c_v0;
+	struct rtw89_fw_h2c_rfk_pre_info_mcc_v1 *h2c_v1;
 	struct rtw89_fw_h2c_rfk_pre_info_mcc *h2c;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
+	u8 ver = U8_MAX;
 	u8 tbl, path;
+	u8 tbl_sel;
 	int ret;
 
+	if (RTW89_CHK_FW_FEATURE(RFK_PRE_NOTIFY_MCC_V2, &rtwdev->fw)) {
+	} else if (RTW89_CHK_FW_FEATURE(RFK_PRE_NOTIFY_MCC_V1, &rtwdev->fw)) {
+		len = sizeof(*h2c_v1);
+		ver = 1;
+	} else if (RTW89_CHK_FW_FEATURE(RFK_PRE_NOTIFY_MCC_V0, &rtwdev->fw)) {
+		len = sizeof(*h2c_v0);
+		ver = 0;
+	}
+
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for h2c rfk_pre_ntfy_mcc\n");
 		return -ENOMEM;
 	}
 	skb_put(skb, len);
-	h2c = (struct rtw89_fw_h2c_rfk_pre_info_mcc *)skb->data;
+
+	if (ver != 0)
+		goto v1;
+
+	h2c_v0 = (struct rtw89_fw_h2c_rfk_pre_info_mcc_v0 *)skb->data;
+	for (tbl = 0; tbl < NUM_OF_RTW89_FW_RFK_TBL; tbl++) {
+		for (path = 0; path < NUM_OF_RTW89_FW_RFK_PATH; path++) {
+			h2c_v0->tbl_18[tbl][path] =
+				cpu_to_le32(rfk_mcc_v0->data[path].rf18[tbl]);
+			tbl_sel = rfk_mcc_v0->data[path].table_idx;
+			h2c_v0->cur_18[path] =
+				cpu_to_le32(rfk_mcc_v0->data[path].rf18[tbl_sel]);
+		}
+	}
+
+	h2c_v0->mlo_mode = cpu_to_le32(rtwdev->mlo_dbcc_mode);
+	goto done;
+
+v1:
+	h2c_v1 = (struct rtw89_fw_h2c_rfk_pre_info_mcc_v1 *)skb->data;
 
 	BUILD_BUG_ON(NUM_OF_RTW89_FW_RFK_TBL > RTW89_RFK_CHS_NR);
 
 	for (tbl = 0; tbl < NUM_OF_RTW89_FW_RFK_TBL; tbl++)
-		h2c->tbl_18[tbl] = cpu_to_le32(rfk_mcc->rf18[tbl]);
+		h2c_v1->tbl_18[tbl] = cpu_to_le32(rfk_mcc->rf18[tbl]);
 
 	BUILD_BUG_ON(ARRAY_SIZE(rtwdev->rfk_mcc.data) < NUM_OF_RTW89_FW_RFK_PATH);
 
 	/* shared table array, but tbl_sel can be independent by path */
 	for (path = 0; path < NUM_OF_RTW89_FW_RFK_PATH; path++) {
 		tbl = rfk_mcc[path].table_idx;
-		h2c->cur_18[path] = cpu_to_le32(rfk_mcc->rf18[tbl]);
+		h2c_v1->cur_18[path] = cpu_to_le32(rfk_mcc->rf18[tbl]);
 
 		if (path == phy_idx)
-			h2c->tbl_idx = tbl;
+			h2c_v1->tbl_idx = tbl;
 	}
 
-	h2c->mlo_mode = cpu_to_le32(rtwdev->mlo_dbcc_mode);
+	h2c_v1->mlo_mode = cpu_to_le32(rtwdev->mlo_dbcc_mode);
+	h2c_v1->phy_idx = phy_idx;
 
 	if (rtw89_is_mlo_1_1(rtwdev))
-		h2c->mlo_1_1 = cpu_to_le32(1);
+		h2c_v1->mlo_1_1 = cpu_to_le32(1);
+
+	if (ver == 1)
+		goto done;
+
+	h2c = (struct rtw89_fw_h2c_rfk_pre_info_mcc *)skb->data;
 
-	h2c->phy_idx = phy_idx;
 	h2c->aid = cpu_to_le32(hal->aid);
 
+done:
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RF_FW_NOTIFY,
 			      H2C_FUNC_OUTSRC_RF_MCC_INFO, 0, 0, len);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 5292b568e2bf..91eaf07f5824 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4586,13 +4586,23 @@ struct rtw89_fw_h2c_rfk_pre_info {
 	__le32 mlo_1_1;
 } __packed;
 
-struct rtw89_fw_h2c_rfk_pre_info_mcc {
+struct rtw89_fw_h2c_rfk_pre_info_mcc_v0 {
+	__le32 tbl_18[NUM_OF_RTW89_FW_RFK_TBL][NUM_OF_RTW89_FW_RFK_PATH];
+	__le32 cur_18[NUM_OF_RTW89_FW_RFK_PATH];
+	__le32 mlo_mode;
+} __packed;
+
+struct rtw89_fw_h2c_rfk_pre_info_mcc_v1 {
 	__le32 tbl_18[NUM_OF_RTW89_FW_RFK_TBL];
 	__le32 cur_18[NUM_OF_RTW89_FW_RFK_PATH];
 	__le32 mlo_mode;
 	__le32 mlo_1_1;
 	u8 phy_idx;
 	u8 tbl_idx;
+} __packed;
+
+struct rtw89_fw_h2c_rfk_pre_info_mcc {
+	struct rtw89_fw_h2c_rfk_pre_info_mcc_v1 base;
 	u8 rsvd[2];
 	__le32 aid;
 } __packed;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index f56b433a1674..d29fbc9cb5ac 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3808,19 +3808,22 @@ int rtw89_phy_rfk_pre_ntfy_and_wait(struct rtw89_dev *rtwdev,
 {
 	int ret;
 
-	if (RTW89_CHK_FW_FEATURE_GROUP(WITH_RFK_PRE_NOTIFY, &rtwdev->fw))
-		goto pre_ntfy;
-
-	return rtw89_fw_h2c_rf_pre_ntfy_mcc(rtwdev, phy_idx);
+	if (RTW89_CHK_FW_FEATURE_GROUP(WITH_RFK_PRE_NOTIFY, &rtwdev->fw)) {
+		rtw89_phy_rfk_report_prep(rtwdev);
+		rtw89_fw_h2c_rf_pre_ntfy(rtwdev, phy_idx);
+		ret = rtw89_phy_rfk_report_wait(rtwdev, "PRE_NTFY", ms);
+		if (ret)
+			return ret;
+	}
 
-pre_ntfy:
-	rtw89_phy_rfk_report_prep(rtwdev);
+	if (RTW89_CHK_FW_FEATURE_GROUP(WITH_RFK_PRE_NOTIFY_MCC, &rtwdev->fw)) {
+		ret = rtw89_fw_h2c_rf_pre_ntfy_mcc(rtwdev, phy_idx);
+		if (ret)
+			return ret;
+	}
 
-	ret = rtw89_fw_h2c_rf_pre_ntfy(rtwdev, phy_idx);
-	if (ret)
-		return ret;
+	return 0;
 
-	return rtw89_phy_rfk_report_wait(rtwdev, "PRE_NTFY", ms);
 }
 EXPORT_SYMBOL(rtw89_phy_rfk_pre_ntfy_and_wait);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
index fce094c7ce93..98f14b31cf52 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
@@ -205,11 +205,11 @@ static void rtw8922a_chlk_ktbl_sel(struct rtw89_dev *rtwdev, u8 kpath, u8 idx)
 	}
 }
 
-static u8 rtw8922a_chlk_reload_sel_tbl(struct rtw89_dev *rtwdev,
-				       const struct rtw89_chan *chan, u8 path)
+static u8 rtw8922a_chlk_reload_sel_tbl_v0(struct rtw89_dev *rtwdev,
+					  const struct rtw89_chan *chan, u8 path)
 {
-	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
 	struct rtw89_rfk_chan_desc desc[__RTW89_RFK_CHS_NR_V1] = {};
+	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
 	u8 tbl_sel;
 
 	for (tbl_sel = 0; tbl_sel < ARRAY_SIZE(desc); tbl_sel++) {
@@ -229,11 +229,53 @@ static u8 rtw8922a_chlk_reload_sel_tbl(struct rtw89_dev *rtwdev,
 	rfk_mcc->data[path].ch[tbl_sel] = chan->channel;
 	rfk_mcc->data[path].band[tbl_sel] = chan->band_type;
 	rfk_mcc->data[path].bw[tbl_sel] = chan->band_width;
+	rfk_mcc->data[path].rf18[tbl_sel] = rtw89_chip_chan_to_rf18_val(rtwdev, chan);
 	rfk_mcc->data[path].table_idx = tbl_sel;
 
 	return tbl_sel;
 }
 
+static u8 rtw8922a_chlk_reload_sel_tbl_v1(struct rtw89_dev *rtwdev,
+					  const struct rtw89_chan *chan, u8 path)
+{
+	struct rtw89_rfk_mcc_info_data *rfk_mcc = rtwdev->rfk_mcc.data;
+	struct rtw89_rfk_chan_desc desc[__RTW89_RFK_CHS_NR_V1] = {};
+	u8 tbl_sel;
+
+	for (tbl_sel = 0; tbl_sel < ARRAY_SIZE(desc); tbl_sel++) {
+		struct rtw89_rfk_chan_desc *p = &desc[tbl_sel];
+
+		p->ch = rfk_mcc->ch[tbl_sel];
+
+		p->has_band = true;
+		p->band = rfk_mcc->band[tbl_sel];
+
+		p->has_bw = true;
+		p->bw = rfk_mcc->bw[tbl_sel];
+	}
+
+	tbl_sel = rtw89_rfk_chan_lookup(rtwdev, desc, ARRAY_SIZE(desc), chan);
+
+	rfk_mcc->ch[tbl_sel] = chan->channel;
+	rfk_mcc->band[tbl_sel] = chan->band_type;
+	rfk_mcc->bw[tbl_sel] = chan->band_width;
+	rfk_mcc->rf18[tbl_sel] = rtw89_chip_chan_to_rf18_val(rtwdev, chan);
+
+	/* shared table array, but tbl_sel can be independent by path */
+	rfk_mcc[path].table_idx = tbl_sel;
+
+	return tbl_sel;
+}
+
+static u8 rtw8922a_chlk_reload_sel_tbl(struct rtw89_dev *rtwdev,
+				       const struct rtw89_chan *chan, u8 path)
+{
+	if (RTW89_CHK_FW_FEATURE(RFK_PRE_NOTIFY_MCC_V1, &rtwdev->fw))
+		return rtw8922a_chlk_reload_sel_tbl_v1(rtwdev, chan, path);
+	else
+		return rtw8922a_chlk_reload_sel_tbl_v0(rtwdev, chan, path);
+}
+
 static void rtw8922a_chlk_reload(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chan *chan0, *chan1;
-- 
2.25.1


