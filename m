Return-Path: <linux-wireless+bounces-30215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE87ECEBA0A
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 10:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E950C300909E
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 09:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92FC313545;
	Wed, 31 Dec 2025 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="aSsTGIbo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7242D660E
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 09:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767172040; cv=none; b=rwhdFzCCNB1tIDB3sPMrZJCPPkVRkPbHtfzCwge4X+dKBBsNJvR9YFzKcx6jtoJl4VbQ7QAx+HdSvwmIngZ9sizNhLla3egSkb8Rc7Nz9QmugAsfeDduWxSo3EJxXd0omKjSkIPcA+CelXvsqfFse04K2POnc87riaOx0zz9c/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767172040; c=relaxed/simple;
	bh=Rg8hkfmjZyYeHP+BXbbmo+kSGWNIvxzqWwLnfXg17AU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nT882e649w3hWEN2ax2c6TlWHI5Y6gruQQnP434G+RPLr6BYLfiq3uqvj/ZBu3G5M/UE/bd9R2vELrFAEXS7ckPGRihy23+OdYcJNK42wkls5F75vAvdb5k5X+P4K+esgouhV2N1e1EQx/H0bsPPg8mmSd+z/AhW7Ll3J7xcXd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=aSsTGIbo; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BV97F1d8880553, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767172036; bh=MRR2Rjos+5ihLJDRnF2M5YFZYui+a3Jl5Q57OrtceQ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=aSsTGIbo6gqmgpFbq/ZNiwR4x19DWUG5srzWqXFWqJEexjf1oU8BvcJkOppn9hQaq
	 l3U/P+zxoW2VZvcUQDr3Cu6140O8nPiDmjOwT1gK9Y35vyOXBbqU7BcgTc06kMRu4v
	 bRwvTL4EWvIa997lQziwdkpl0hMI3U5P2cNuAS/H6dFLXSxI6yQywX/2JSGkdAgxJZ
	 KM7YF4gUVw54fqX9cCtdJH1Mc20XpofGU7cDASFBfxEiOHWayiKXjyi8qfXTdXHbhw
	 u+RkmCQC5wDC0Eoz9ozLI/Cdl9PJSoH6U/m1wUfByEd0+hlfFthKMoQyr4wevH1VdM
	 7dzrOTNi6URSQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BV97F1d8880553
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 17:07:15 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 17:07:15 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 31 Dec 2025 17:07:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 02/11] wifi: rtw89: rfk: add rtw89_fw_h2c_rf_pre_ntfy_mcc for new WiFi 7 firmware
Date: Wed, 31 Dec 2025 17:06:38 +0800
Message-ID: <20251231090647.56407-3-pkshih@realtek.com>
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

The pre-notify is to notify firmware the configured channels, and then
RF calibration in firmware can use these values to calibrate RF properly.

Since we need more information, change and add the new H2C command format.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  2 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 60 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h   | 13 +++++
 drivers/net/wireless/realtek/rtw89/phy.c  |  6 +++
 4 files changed, 81 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b42d3a4df4bf..b7d5eb25ef74 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4685,6 +4685,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V0,
 	RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V1,
 	RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V2,
+	RTW89_FW_FEATURE_WITH_RFK_PRE_NOTIFY,
 	RTW89_FW_FEATURE_RFK_RXDCK_V0,
 	RTW89_FW_FEATURE_RFK_IQK_V0,
 	RTW89_FW_FEATURE_NO_WOW_CPU_IO_RX,
@@ -5239,6 +5240,7 @@ struct rtw89_rfk_mcc_info_data {
 	u8 ch[RTW89_RFK_CHS_NR];
 	u8 band[RTW89_RFK_CHS_NR];
 	u8 bw[RTW89_RFK_CHS_NR];
+	u32 rf18[RTW89_RFK_CHS_NR];
 	u8 table_idx;
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index d05b15ea022a..d13c93fafb34 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -892,6 +892,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 76, 0, LPS_DACK_BY_C2H_REG),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 79, 0, CRASH_TRIGGER_TYPE_1),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 80, 0, BEACON_TRACKING),
+	__CFG_FW_FEAT(RTL8922A, le, 0, 35, 80, 0, WITH_RFK_PRE_NOTIFY),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 84, 0, ADDR_CAM_V0),
 };
 
@@ -6490,6 +6491,65 @@ int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+int rtw89_fw_h2c_rf_pre_ntfy_mcc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	struct rtw89_rfk_mcc_info_data *rfk_mcc = rtwdev->rfk_mcc.data;
+	struct rtw89_fw_h2c_rfk_pre_info_mcc *h2c;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	u8 tbl, path;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c rfk_pre_ntfy_mcc\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_fw_h2c_rfk_pre_info_mcc *)skb->data;
+
+	BUILD_BUG_ON(NUM_OF_RTW89_FW_RFK_TBL > RTW89_RFK_CHS_NR);
+
+	for (tbl = 0; tbl < NUM_OF_RTW89_FW_RFK_TBL; tbl++)
+		h2c->tbl_18[tbl] = cpu_to_le32(rfk_mcc->rf18[tbl]);
+
+	BUILD_BUG_ON(ARRAY_SIZE(rtwdev->rfk_mcc.data) < NUM_OF_RTW89_FW_RFK_PATH);
+
+	/* shared table array, but tbl_sel can be independent by path */
+	for (path = 0; path < NUM_OF_RTW89_FW_RFK_PATH; path++) {
+		tbl = rfk_mcc[path].table_idx;
+		h2c->cur_18[path] = cpu_to_le32(rfk_mcc->rf18[tbl]);
+
+		if (path == phy_idx)
+			h2c->tbl_idx = tbl;
+	}
+
+	h2c->mlo_mode = cpu_to_le32(rtwdev->mlo_dbcc_mode);
+
+	if (rtw89_is_mlo_1_1(rtwdev))
+		h2c->mlo_1_1 = cpu_to_le32(1);
+
+	h2c->phy_idx = phy_idx;
+	h2c->aid = cpu_to_le32(hal->aid);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RF_FW_NOTIFY,
+			      H2C_FUNC_OUTSRC_RF_MCC_INFO, 0, 0, len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
 int rtw89_fw_h2c_rf_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 			 const struct rtw89_chan *chan, enum rtw89_tssi_mode tssi_mode)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index f12728ccb31f..5292b568e2bf 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4471,6 +4471,7 @@ enum rtw89_mrc_h2c_func {
 #define H2C_CL_OUTSRC_RF_REG_B		0x9
 #define H2C_CL_OUTSRC_RF_FW_NOTIFY	0xa
 #define H2C_FUNC_OUTSRC_RF_GET_MCCCH	0x2
+#define H2C_FUNC_OUTSRC_RF_MCC_INFO	0xf
 #define H2C_FUNC_OUTSRC_RF_PS_INFO	0x10
 #define H2C_CL_OUTSRC_RF_FW_RFK		0xb
 
@@ -4585,6 +4586,17 @@ struct rtw89_fw_h2c_rfk_pre_info {
 	__le32 mlo_1_1;
 } __packed;
 
+struct rtw89_fw_h2c_rfk_pre_info_mcc {
+	__le32 tbl_18[NUM_OF_RTW89_FW_RFK_TBL];
+	__le32 cur_18[NUM_OF_RTW89_FW_RFK_PATH];
+	__le32 mlo_mode;
+	__le32 mlo_1_1;
+	u8 phy_idx;
+	u8 tbl_idx;
+	u8 rsvd[2];
+	__le32 aid;
+} __packed;
+
 struct rtw89_h2c_rf_tssi {
 	__le16 len;
 	u8 phy;
@@ -4942,6 +4954,7 @@ int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_rf_ps_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 			     enum rtw89_phy_idx phy_idx);
+int rtw89_fw_h2c_rf_pre_ntfy_mcc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 int rtw89_fw_h2c_mcc_dig(struct rtw89_dev *rtwdev,
 			 enum rtw89_chanctx_idx chanctx_idx,
 			 u8 mcc_role_idx, u8 pd_val, bool en);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 9f418b1fb7ed..d0e5d52964de 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3808,6 +3808,12 @@ int rtw89_phy_rfk_pre_ntfy_and_wait(struct rtw89_dev *rtwdev,
 {
 	int ret;
 
+	if (RTW89_CHK_FW_FEATURE(WITH_RFK_PRE_NOTIFY, &rtwdev->fw))
+		goto pre_ntfy;
+
+	return rtw89_fw_h2c_rf_pre_ntfy_mcc(rtwdev, phy_idx);
+
+pre_ntfy:
 	rtw89_phy_rfk_report_prep(rtwdev);
 
 	ret = rtw89_fw_h2c_rf_pre_ntfy(rtwdev, phy_idx);
-- 
2.25.1


