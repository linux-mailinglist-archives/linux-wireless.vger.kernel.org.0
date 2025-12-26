Return-Path: <linux-wireless+bounces-30120-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBF5CDE5F3
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 07:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E69F30052B0
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 06:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AC2135A53;
	Fri, 26 Dec 2025 06:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jDOvUYL5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139B21E9919
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 06:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766729721; cv=none; b=rSXYITX+W5iWlw0qlibHyFvs58LQgEEfDQIf241EGBUsxyVBDNtx2GFSG/vvmweGptFpK9T3A2GPYR/+susB9/AYM4ogV490W3i9WVwhR1jVYQZ7vXeWmJFP8rOiMwM6F7bJFrjFjlEP1r0dP09BKhwVZ2uyVt4UYXDm5wImP0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766729721; c=relaxed/simple;
	bh=zPMvbGHLSPmyxW9qHbKFqC1IcWot8XwCwYJIKzGA9Lk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZAh2xG1Cam2gCaQC4BPIRKlf9A82U9XOmcWQOCUrAAcrwvAdeWAv5hgcstjlFhXO/5l8earNobFy57lRN2aeTn1Jrq1+SzmeFS3rSCoZCri/RW/1Hudlvu7CY8OM47cndNXgVyHA5l8XV/CwOWRZpBg/pFMfefDa3DS/12C5pr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jDOvUYL5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BQ6FG3N03112806, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766729716; bh=yj6Uo+onek+cly8JpneeYg1yZrf/q+Kk27TGaKtaw8k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=jDOvUYL5+vQ+DqYA5sngqBt1x9vlzUJJ8sxvtUB4DzFZOpD55fjNIfHgRVM9gKswX
	 JNBflH7vqLI6Q0HSrtYf+M8ZN/pi6P/jByt/zJNt9ej0/yJvGiyYB4CH6kiRKYBJSy
	 OobNge3fXpwyG/+TXgKCuW6U3VvneziBjUBlK7UcONfihvWFKbflh8R1bb+WHkcCN/
	 zFnw9Ab0u1UAXAfwCFueTNih7rYtL3cj/rPq9xend9ckvUzL9GMkOABUz3sA1/H9ic
	 6dctvoVtvJqAafUEWLkpAeURfNoJprJbuoSXbv3YuOkl5tGEOuCRwTWqpddSCx8lB4
	 rrmQUXU+eI7Nw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BQ6FG3N03112806
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 14:15:16 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 14:15:17 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 14:15:16 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 26 Dec 2025 14:15:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
        <dian_syuan0116@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 03/12] wifi: rtw89: wow: add WOW_CAM update function for 8922D
Date: Fri, 26 Dec 2025 14:14:37 +0800
Message-ID: <20251226061446.63514-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251226061446.63514-1-pkshih@realtek.com>
References: <20251226061446.63514-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Chin-Yen Lee <timlee@realtek.com>

For WOW_CAM update function, 8922DE use different H2C command from 8922AE.
Use chip to distinguish them.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  3 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 59 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       | 39 ++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 drivers/net/wireless/realtek/rtw89/wow.c      |  4 +-
 10 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 6c4dbab999cd..5b4f998e1978 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -25,6 +25,7 @@ struct rtw89_fw_txpwr_track_cfg;
 struct rtw89_phy_rfk_log_fmt;
 struct rtw89_debugfs;
 struct rtw89_regd_data;
+struct rtw89_wow_cam_info;
 
 extern const struct ieee80211_ops rtw89_ops;
 
@@ -3835,6 +3836,8 @@ struct rtw89_chip_ops {
 			  struct rtw89_vif_link *rtwvif_link,
 			  struct rtw89_sta_link *rtwsta_link,
 			  bool valid, struct ieee80211_ampdu_params *params);
+	int (*h2c_wow_cam_update)(struct rtw89_dev *rtwdev,
+				  struct rtw89_wow_cam_info *cam_info);
 
 	void (*btc_set_rfe)(struct rtw89_dev *rtwdev);
 	void (*btc_init_cfg)(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index c8ea4a9f24e0..9b3a9fc7c629 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -8772,6 +8772,65 @@ int rtw89_fw_h2c_wow_cam_update(struct rtw89_dev *rtwdev,
 
 	return ret;
 }
+EXPORT_SYMBOL(rtw89_fw_h2c_wow_cam_update);
+
+int rtw89_fw_h2c_wow_cam_update_v1(struct rtw89_dev *rtwdev,
+				   struct rtw89_wow_cam_info *cam_info)
+{
+	struct rtw89_h2c_wow_payload_cam_update *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for wow payload cam update\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_wow_payload_cam_update *)skb->data;
+
+	h2c->w0 = le32_encode_bits(cam_info->r_w, RTW89_H2C_WOW_PLD_CAM_UPD_W0_R_W) |
+		  le32_encode_bits(cam_info->idx, RTW89_H2C_WOW_PLD_CAM_UPD_W0_IDX);
+	h2c->w8 = le32_encode_bits(cam_info->valid, RTW89_H2C_WOW_PLD_CAM_UPD_W8_VALID) |
+		  le32_encode_bits(1, RTW89_H2C_WOW_PLD_CAM_UPD_W8_WOW_PTR);
+
+	if (!cam_info->valid)
+		goto done;
+
+	h2c->wkfm0 = cam_info->mask[0];
+	h2c->wkfm1 = cam_info->mask[1];
+	h2c->wkfm2 = cam_info->mask[2];
+	h2c->wkfm3 = cam_info->mask[3];
+	h2c->w5 = le32_encode_bits(cam_info->uc, RTW89_H2C_WOW_PLD_CAM_UPD_W5_UC) |
+		  le32_encode_bits(cam_info->mc, RTW89_H2C_WOW_PLD_CAM_UPD_W5_MC) |
+		  le32_encode_bits(cam_info->bc, RTW89_H2C_WOW_PLD_CAM_UPD_W5_BC) |
+		  le32_encode_bits(cam_info->skip_mac_hdr,
+				   RTW89_H2C_WOW_PLD_CAM_UPD_W5_SKIP_MAC_HDR);
+	h2c->w6 = le32_encode_bits(cam_info->crc, RTW89_H2C_WOW_PLD_CAM_UPD_W6_CRC);
+	h2c->w7 = le32_encode_bits(cam_info->negative_pattern_match,
+				   RTW89_H2C_WOW_PLD_CAM_UPD_W7_NEGATIVE_PATTERN_MATCH);
+
+done:
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MAC_WOW,
+			      H2C_FUNC_WOW_PLD_CAM_UPD, 0, 1,
+			      len);
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
+EXPORT_SYMBOL(rtw89_fw_h2c_wow_cam_update_v1);
 
 int rtw89_fw_h2c_wow_gtk_ofld(struct rtw89_dev *rtwdev,
 			      struct rtw89_vif_link *rtwvif_link,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 8d8d82b51f43..3a72ab3f1895 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2076,6 +2076,33 @@ struct rtw89_h2c_wow_cam_update {
 #define RTW89_H2C_WOW_CAM_UPD_W5_BC BIT(26)
 #define RTW89_H2C_WOW_CAM_UPD_W5_VALID BIT(31)
 
+struct rtw89_h2c_wow_payload_cam_update {
+	__le32 w0;
+	__le32 wkfm0;
+	__le32 wkfm1;
+	__le32 wkfm2;
+	__le32 wkfm3;
+	__le32 w5;
+	__le32 w6;
+	__le32 w7;
+	__le32 w8;
+} __packed;
+
+#define RTW89_H2C_WOW_PLD_CAM_UPD_W0_R_W BIT(0)
+#define RTW89_H2C_WOW_PLD_CAM_UPD_W0_IDX GENMASK(7, 1)
+#define RTW89_H2C_WOW_PLD_CAM_UPD_WKFM0 GENMASK(31, 0)
+#define RTW89_H2C_WOW_PLD_CAM_UPD_WKFM1 GENMASK(31, 0)
+#define RTW89_H2C_WOW_PLD_CAM_UPD_WKFM2 GENMASK(31, 0)
+#define RTW89_H2C_WOW_PLD_CAM_UPD_WKFM3 GENMASK(31, 0)
+#define RTW89_H2C_WOW_PLD_CAM_UPD_W5_UC BIT(0)
+#define RTW89_H2C_WOW_PLD_CAM_UPD_W5_MC BIT(1)
+#define RTW89_H2C_WOW_PLD_CAM_UPD_W5_BC BIT(2)
+#define RTW89_H2C_WOW_PLD_CAM_UPD_W5_SKIP_MAC_HDR BIT(7)
+#define RTW89_H2C_WOW_PLD_CAM_UPD_W6_CRC GENMASK(15, 0)
+#define RTW89_H2C_WOW_PLD_CAM_UPD_W7_NEGATIVE_PATTERN_MATCH BIT(0)
+#define RTW89_H2C_WOW_PLD_CAM_UPD_W8_VALID BIT(0)
+#define RTW89_H2C_WOW_PLD_CAM_UPD_W8_WOW_PTR BIT(1)
+
 struct rtw89_h2c_wow_gtk_ofld {
 	__le32 w0;
 	__le32 w1;
@@ -4266,6 +4293,7 @@ enum rtw89_wow_h2c_func {
 	H2C_FUNC_WAKEUP_CTRL		= 0x8,
 	H2C_FUNC_WOW_CAM_UPD		= 0xC,
 	H2C_FUNC_AOAC_REPORT_REQ	= 0xD,
+	H2C_FUNC_WOW_PLD_CAM_UPD	= 0x12,
 
 	NUM_OF_RTW89_WOW_H2C_FUNC,
 };
@@ -5015,6 +5043,8 @@ int rtw89_fw_h2c_wow_wakeup_ctrl(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif_link *rtwvif_link, bool enable);
 int rtw89_fw_h2c_wow_cam_update(struct rtw89_dev *rtwdev,
 				struct rtw89_wow_cam_info *cam_info);
+int rtw89_fw_h2c_wow_cam_update_v1(struct rtw89_dev *rtwdev,
+				   struct rtw89_wow_cam_info *cam_info);
 int rtw89_fw_h2c_wow_gtk_ofld(struct rtw89_dev *rtwdev,
 			      struct rtw89_vif_link *rtwvif_link,
 			      bool enable);
@@ -5178,6 +5208,15 @@ int rtw89_chip_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 	return 0;
 }
 
+static inline
+int rtw89_chip_h2c_wow_cam_update(struct rtw89_dev *rtwdev,
+				  struct rtw89_wow_cam_info *cam_info)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	return chip->ops->h2c_wow_cam_update(rtwdev, cam_info);
+}
+
 /* Must consider compatibility; don't insert new in the mid.
  * Fill each field's default value in rtw89_regd_entcpy().
  */
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 84b628d23882..97254fe638d1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2553,6 +2553,7 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.h2c_default_dmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
+	.h2c_wow_cam_update	= rtw89_fw_h2c_wow_cam_update,
 
 	.btc_set_rfe		= rtw8851b_btc_set_rfe,
 	.btc_init_cfg		= rtw8851b_btc_init_cfg,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 8677723e3561..f44ea4cd4c9e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2247,6 +2247,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.h2c_default_dmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
+	.h2c_wow_cam_update	= rtw89_fw_h2c_wow_cam_update,
 
 	.btc_set_rfe		= rtw8852a_btc_set_rfe,
 	.btc_init_cfg		= rtw8852a_btc_init_cfg,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 70fb05bc5e98..b1ea0a6e38c2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -858,6 +858,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.h2c_default_dmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
+	.h2c_wow_cam_update	= rtw89_fw_h2c_wow_cam_update,
 
 	.btc_set_rfe		= rtw8852b_btc_set_rfe,
 	.btc_init_cfg		= rtw8852bx_btc_init_cfg,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index f956474c3b72..362d92d86aa1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -724,6 +724,7 @@ static const struct rtw89_chip_ops rtw8852bt_chip_ops = {
 	.h2c_default_dmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
+	.h2c_wow_cam_update	= rtw89_fw_h2c_wow_cam_update,
 
 	.btc_set_rfe		= rtw8852bt_btc_set_rfe,
 	.btc_init_cfg		= rtw8852bx_btc_init_cfg,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index db99450e9158..bc31f563ad93 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3088,6 +3088,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.h2c_default_dmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
+	.h2c_wow_cam_update	= rtw89_fw_h2c_wow_cam_update,
 
 	.btc_set_rfe		= rtw8852c_btc_set_rfe,
 	.btc_init_cfg		= rtw8852c_btc_init_cfg,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 4bcf20612a45..cfd42b0145d3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2861,6 +2861,7 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.h2c_default_dmac_tbl	= rtw89_fw_h2c_default_dmac_tbl_v2,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon_be,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam_v1,
+	.h2c_wow_cam_update	= rtw89_fw_h2c_wow_cam_update,
 
 	.btc_set_rfe		= rtw8922a_btc_set_rfe,
 	.btc_init_cfg		= rtw8922a_btc_init_cfg,
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 417720067e78..8224f0e3fb9a 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -1070,7 +1070,7 @@ static void rtw89_wow_pattern_clear_cam(struct rtw89_dev *rtwdev)
 	for (i = 0; i < rtw_wow->pattern_cnt; i++) {
 		rtw_pattern = &rtw_wow->patterns[i];
 		rtw_pattern->valid = false;
-		rtw89_fw_h2c_wow_cam_update(rtwdev, rtw_pattern);
+		rtw89_chip_h2c_wow_cam_update(rtwdev, rtw_pattern);
 	}
 }
 
@@ -1081,7 +1081,7 @@ static void rtw89_wow_pattern_write(struct rtw89_dev *rtwdev)
 	int i;
 
 	for (i = 0; i < rtw_wow->pattern_cnt; i++)
-		rtw89_fw_h2c_wow_cam_update(rtwdev, rtw_pattern + i);
+		rtw89_chip_h2c_wow_cam_update(rtwdev, rtw_pattern + i);
 }
 
 static void rtw89_wow_pattern_clear(struct rtw89_dev *rtwdev)
-- 
2.25.1


