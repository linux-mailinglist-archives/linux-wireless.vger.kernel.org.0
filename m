Return-Path: <linux-wireless+bounces-30118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DED4CDE5ED
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 07:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 695923002D15
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 06:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8901F12E9;
	Fri, 26 Dec 2025 06:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="sHqW+ptn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950B72F12C3
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 06:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766729711; cv=none; b=AaDAU1bkngNCx2lyv0VsCtTIW92suqwjQd41IhWdJeDMe5qXw7YCTXKiniPPm92s+e3X54z643SYQpenbC8vcnydY6zL8Bq4BZSMWPuLwn6v4Cf1G2gcKJmP0oqfgewC7ZRJNMbWy8HWhFqgrF4j6Vqw06yMxsCF0GEqiZgSOsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766729711; c=relaxed/simple;
	bh=MpXQsNJeRld8AUZOw9LWd1083DdF+meGJgURLSwSomM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrIT0PA+b5BD811NYqEAhsBYSA25MGHFV/flEuWmbAFRD00+GPtwnV/O4ZYjuwjOzGGWTicCCxrjQ+MAIIO+XbHWJSFufWmmomsGUBsBC8So62e/gg/yv6FSFVaBkqSdarz7lwJgaXGnZ+xZIl+3jN90X6rRrjS88kG0kg76+Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=sHqW+ptn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BQ6F5lZ43112781, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766729705; bh=Ra1nEtWVhgRhwlWrSeaUIgFA0u/3gqMLO5IKZ5LsMmQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=sHqW+ptn3qtnlbKidbZxyV/Ew5i98JCIJhGCqJLbYijeAzmwImLxrcfmNkkUnujCP
	 rRRWfyk4hI6mMW2nhwc7HBDXsRqqAoRSNJ8F4kezEwKaDzd4xLdBPzHSlxYAe9rNIO
	 +Z+/xwYYWmUUkTaD00G2UPT170KGIqxgfBt5b1ucxGuza3BLmT7/jBWoeX24I4jmg0
	 JFFKLuJtSkksA2umJE+DUcuVozkd8LIZ4lTKgQAHHzYu68ICKkHKRdHb656qq8cOGT
	 1mcm0S3y5hm1vC3Nw9CDFlEzxdjUCZ9L4/DPm5zuOLhL4yuBEwV/T8hrGRs0p5i+Mo
	 VIu0yBnT+m/VQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BQ6F5lZ43112781
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 14:15:05 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 14:15:06 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 14:15:05 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 26 Dec 2025 14:15:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
        <dian_syuan0116@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 01/12] wifi: rtw89: wow: use struct style to fill WOW CAM H2C command
Date: Fri, 26 Dec 2025 14:14:35 +0800
Message-ID: <20251226061446.63514-2-pkshih@realtek.com>
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

The WOW CAM H2C command is used to tell firmware the content
of pattern match. Use struct instead of macros to fill the data.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c  | 56 ++++++++-------
 drivers/net/wireless/realtek/rtw89/fw.h  | 88 +++++++-----------------
 drivers/net/wireless/realtek/rtw89/wow.c |  4 +-
 3 files changed, 55 insertions(+), 93 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index fd49e651aeed..bb6f2802446e 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -8717,44 +8717,48 @@ int rtw89_fw_h2c_wow_wakeup_ctrl(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-#define H2C_WOW_CAM_UPD_LEN 24
-int rtw89_fw_wow_cam_update(struct rtw89_dev *rtwdev,
-			    struct rtw89_wow_cam_info *cam_info)
+int rtw89_fw_h2c_wow_cam_update(struct rtw89_dev *rtwdev,
+				struct rtw89_wow_cam_info *cam_info)
 {
+	struct rtw89_h2c_wow_cam_update *h2c;
+	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
 	int ret;
 
-	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_WOW_CAM_UPD_LEN);
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
-		rtw89_err(rtwdev, "failed to alloc skb for keep alive\n");
+		rtw89_err(rtwdev, "failed to alloc skb for wow cam update\n");
 		return -ENOMEM;
 	}
-
-	skb_put(skb, H2C_WOW_CAM_UPD_LEN);
-
-	RTW89_SET_WOW_CAM_UPD_R_W(skb->data, cam_info->r_w);
-	RTW89_SET_WOW_CAM_UPD_IDX(skb->data, cam_info->idx);
-	if (cam_info->valid) {
-		RTW89_SET_WOW_CAM_UPD_WKFM1(skb->data, cam_info->mask[0]);
-		RTW89_SET_WOW_CAM_UPD_WKFM2(skb->data, cam_info->mask[1]);
-		RTW89_SET_WOW_CAM_UPD_WKFM3(skb->data, cam_info->mask[2]);
-		RTW89_SET_WOW_CAM_UPD_WKFM4(skb->data, cam_info->mask[3]);
-		RTW89_SET_WOW_CAM_UPD_CRC(skb->data, cam_info->crc);
-		RTW89_SET_WOW_CAM_UPD_NEGATIVE_PATTERN_MATCH(skb->data,
-							     cam_info->negative_pattern_match);
-		RTW89_SET_WOW_CAM_UPD_SKIP_MAC_HDR(skb->data,
-						   cam_info->skip_mac_hdr);
-		RTW89_SET_WOW_CAM_UPD_UC(skb->data, cam_info->uc);
-		RTW89_SET_WOW_CAM_UPD_MC(skb->data, cam_info->mc);
-		RTW89_SET_WOW_CAM_UPD_BC(skb->data, cam_info->bc);
-	}
-	RTW89_SET_WOW_CAM_UPD_VALID(skb->data, cam_info->valid);
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_wow_cam_update *)skb->data;
+
+	h2c->w0 = le32_encode_bits(cam_info->r_w, RTW89_H2C_WOW_CAM_UPD_W0_R_W) |
+		  le32_encode_bits(cam_info->idx, RTW89_H2C_WOW_CAM_UPD_W0_IDX);
+
+	if (!cam_info->valid)
+		goto fill_valid;
+
+	h2c->wkfm0 = le32_encode_bits(cam_info->mask[0], RTW89_H2C_WOW_CAM_UPD_WKFM0);
+	h2c->wkfm1 = le32_encode_bits(cam_info->mask[1], RTW89_H2C_WOW_CAM_UPD_WKFM1);
+	h2c->wkfm2 = le32_encode_bits(cam_info->mask[2], RTW89_H2C_WOW_CAM_UPD_WKFM2);
+	h2c->wkfm3 = le32_encode_bits(cam_info->mask[3], RTW89_H2C_WOW_CAM_UPD_WKFM3);
+	h2c->w5 = le32_encode_bits(cam_info->crc, RTW89_H2C_WOW_CAM_UPD_W5_CRC) |
+		  le32_encode_bits(cam_info->negative_pattern_match,
+				   RTW89_H2C_WOW_CAM_UPD_W5_NEGATIVE_PATTERN_MATCH) |
+		  le32_encode_bits(cam_info->skip_mac_hdr,
+				   RTW89_H2C_WOW_CAM_UPD_W5_SKIP_MAC_HDR) |
+		  le32_encode_bits(cam_info->uc, RTW89_H2C_WOW_CAM_UPD_W5_UC) |
+		  le32_encode_bits(cam_info->mc, RTW89_H2C_WOW_CAM_UPD_W5_MC) |
+		  le32_encode_bits(cam_info->bc, RTW89_H2C_WOW_CAM_UPD_W5_BC);
+fill_valid:
+	h2c->w5 |= le32_encode_bits(cam_info->valid, RTW89_H2C_WOW_CAM_UPD_W5_VALID);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC,
 			      H2C_CL_MAC_WOW,
 			      H2C_FUNC_WOW_CAM_UPD, 0, 1,
-			      H2C_WOW_CAM_UPD_LEN);
+			      len);
 
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index dfae652686cd..8d8d82b51f43 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2053,70 +2053,28 @@ static inline void RTW89_SET_WOW_WAKEUP_CTRL_MAC_ID(void *h2c, u32 val)
 	le32p_replace_bits((__le32 *)h2c, val, GENMASK(31, 24));
 }
 
-static inline void RTW89_SET_WOW_CAM_UPD_R_W(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, BIT(0));
-}
-
-static inline void RTW89_SET_WOW_CAM_UPD_IDX(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(7, 1));
-}
-
-static inline void RTW89_SET_WOW_CAM_UPD_WKFM1(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c + 1, val, GENMASK(31, 0));
-}
-
-static inline void RTW89_SET_WOW_CAM_UPD_WKFM2(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c + 2, val, GENMASK(31, 0));
-}
-
-static inline void RTW89_SET_WOW_CAM_UPD_WKFM3(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c + 3, val, GENMASK(31, 0));
-}
-
-static inline void RTW89_SET_WOW_CAM_UPD_WKFM4(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c + 4, val, GENMASK(31, 0));
-}
-
-static inline void RTW89_SET_WOW_CAM_UPD_CRC(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c + 5, val, GENMASK(15, 0));
-}
-
-static inline void RTW89_SET_WOW_CAM_UPD_NEGATIVE_PATTERN_MATCH(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c + 5, val, BIT(22));
-}
-
-static inline void RTW89_SET_WOW_CAM_UPD_SKIP_MAC_HDR(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c + 5, val, BIT(23));
-}
-
-static inline void RTW89_SET_WOW_CAM_UPD_UC(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c + 5, val, BIT(24));
-}
-
-static inline void RTW89_SET_WOW_CAM_UPD_MC(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c + 5, val, BIT(25));
-}
-
-static inline void RTW89_SET_WOW_CAM_UPD_BC(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c + 5, val, BIT(26));
-}
+struct rtw89_h2c_wow_cam_update {
+	__le32 w0;
+	__le32 wkfm0;
+	__le32 wkfm1;
+	__le32 wkfm2;
+	__le32 wkfm3;
+	__le32 w5;
+} __packed;
 
-static inline void RTW89_SET_WOW_CAM_UPD_VALID(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c + 5, val, BIT(31));
-}
+#define RTW89_H2C_WOW_CAM_UPD_W0_R_W BIT(0)
+#define RTW89_H2C_WOW_CAM_UPD_W0_IDX GENMASK(7, 1)
+#define RTW89_H2C_WOW_CAM_UPD_WKFM0 GENMASK(31, 0)
+#define RTW89_H2C_WOW_CAM_UPD_WKFM1 GENMASK(31, 0)
+#define RTW89_H2C_WOW_CAM_UPD_WKFM2 GENMASK(31, 0)
+#define RTW89_H2C_WOW_CAM_UPD_WKFM3 GENMASK(31, 0)
+#define RTW89_H2C_WOW_CAM_UPD_W5_CRC GENMASK(15, 0)
+#define RTW89_H2C_WOW_CAM_UPD_W5_NEGATIVE_PATTERN_MATCH BIT(22)
+#define RTW89_H2C_WOW_CAM_UPD_W5_SKIP_MAC_HDR BIT(23)
+#define RTW89_H2C_WOW_CAM_UPD_W5_UC BIT(24)
+#define RTW89_H2C_WOW_CAM_UPD_W5_MC BIT(25)
+#define RTW89_H2C_WOW_CAM_UPD_W5_BC BIT(26)
+#define RTW89_H2C_WOW_CAM_UPD_W5_VALID BIT(31)
 
 struct rtw89_h2c_wow_gtk_ofld {
 	__le32 w0;
@@ -5055,8 +5013,8 @@ int rtw89_fw_h2c_wow_global(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtw
 			    bool enable);
 int rtw89_fw_h2c_wow_wakeup_ctrl(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif_link *rtwvif_link, bool enable);
-int rtw89_fw_wow_cam_update(struct rtw89_dev *rtwdev,
-			    struct rtw89_wow_cam_info *cam_info);
+int rtw89_fw_h2c_wow_cam_update(struct rtw89_dev *rtwdev,
+				struct rtw89_wow_cam_info *cam_info);
 int rtw89_fw_h2c_wow_gtk_ofld(struct rtw89_dev *rtwdev,
 			      struct rtw89_vif_link *rtwvif_link,
 			      bool enable);
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 46aba4cb2ee9..417720067e78 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -1070,7 +1070,7 @@ static void rtw89_wow_pattern_clear_cam(struct rtw89_dev *rtwdev)
 	for (i = 0; i < rtw_wow->pattern_cnt; i++) {
 		rtw_pattern = &rtw_wow->patterns[i];
 		rtw_pattern->valid = false;
-		rtw89_fw_wow_cam_update(rtwdev, rtw_pattern);
+		rtw89_fw_h2c_wow_cam_update(rtwdev, rtw_pattern);
 	}
 }
 
@@ -1081,7 +1081,7 @@ static void rtw89_wow_pattern_write(struct rtw89_dev *rtwdev)
 	int i;
 
 	for (i = 0; i < rtw_wow->pattern_cnt; i++)
-		rtw89_fw_wow_cam_update(rtwdev, rtw_pattern + i);
+		rtw89_fw_h2c_wow_cam_update(rtwdev, rtw_pattern + i);
 }
 
 static void rtw89_wow_pattern_clear(struct rtw89_dev *rtwdev)
-- 
2.25.1


