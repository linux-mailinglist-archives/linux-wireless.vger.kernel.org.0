Return-Path: <linux-wireless+bounces-6839-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89548B2032
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 13:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E931C22C8F
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 11:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDD312A177;
	Thu, 25 Apr 2024 11:29:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDF812A16C
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714044551; cv=none; b=rlg6UNNYYjyUOXOXCrJaNQIpweDmiHcyuzIvLycbRQwYzXf9yPx4c9HAEhD3gkxRxz6qMoF4KE10GP6rsJPS6baUV/DvoST0sLLb1ukiZbIP9Rcx3lfew6BYGnbbwiflAa0eLC16YjWlxXSS4cKQDepZ/GuGgEGzhsr+OSR0vSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714044551; c=relaxed/simple;
	bh=sVTuFE0Sc+5TDnhCPMUbg6KDhgpMaiShAzH613KwuKo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6IIY7KjOaVNMd2W2Tc2Bo5IJbce3c+/jMaVP0ZCR4b/GUjAJfRJutN9odc/NgVZOYCBRAtHMqcpyzMRE64qz37RlSu15DAqvNUYINwVbZxN1cD2hnsJpvGyDNmzzhczUR1bGBf83tZfK9tSDASZKNrJjP9T2RSf24LG+o9s3yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43PBT77q83482326, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43PBT77q83482326
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 19:29:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 19:29:07 +0800
Received: from [127.0.1.1] (172.16.16.129) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 25 Apr
 2024 19:29:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>
Subject: [PATCH 06/12] wifi: rtw89: use struct to fill H2C of WoWLAN global configuration
Date: Thu, 25 Apr 2024 19:28:10 +0800
Message-ID: <20240425112816.26431-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240425112816.26431-1-pkshih@realtek.com>
References: <20240425112816.26431-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

This H2C command is used to set WoWLAN global config, and we correct
the H2C format by enlarging the H2C size to fill GTK and PTK info.
This fix is compatible with old firmware.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 18 +++++----
 drivers/net/wireless/realtek/rtw89/fw.h | 49 ++++++-------------------
 2 files changed, 21 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index ce12638da3e6..059c92ecfc7c 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6353,30 +6353,32 @@ int rtw89_fw_h2c_disconnect_detect(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-#define H2C_WOW_GLOBAL_LEN 8
 int rtw89_fw_h2c_wow_global(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			    bool enable)
 {
-	struct sk_buff *skb;
+	struct rtw89_h2c_wow_global *h2c;
 	u8 macid = rtwvif->mac_id;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
 	int ret;
 
-	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_WOW_GLOBAL_LEN);
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
-		rtw89_err(rtwdev, "failed to alloc skb for keep alive\n");
+		rtw89_err(rtwdev, "failed to alloc skb for wow global\n");
 		return -ENOMEM;
 	}
 
-	skb_put(skb, H2C_WOW_GLOBAL_LEN);
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_wow_global *)skb->data;
 
-	RTW89_SET_WOW_GLOBAL_ENABLE(skb->data, enable);
-	RTW89_SET_WOW_GLOBAL_MAC_ID(skb->data, macid);
+	h2c->w0 = le32_encode_bits(enable, RTW89_H2C_WOW_GLOBAL_W0_ENABLE) |
+		  le32_encode_bits(macid, RTW89_H2C_WOW_GLOBAL_W0_MAC_ID);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC,
 			      H2C_CL_MAC_WOW,
 			      H2C_FUNC_WOW_GLOBAL, 0, 1,
-			      H2C_WOW_GLOBAL_LEN);
+			      len);
 
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index dc5b44a0b375..ce6bf8c3ec96 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1856,45 +1856,18 @@ static inline void RTW89_SET_DISCONNECT_DETECT_TRYOK_BCNFAIL_COUNT_LIMIT(void *h
 	le32p_replace_bits((__le32 *)(h2c) + 1, val, GENMASK(7, 0));
 }
 
-static inline void RTW89_SET_WOW_GLOBAL_ENABLE(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, BIT(0));
-}
-
-static inline void RTW89_SET_WOW_GLOBAL_DROP_ALL_PKT(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, BIT(1));
-}
-
-static inline void RTW89_SET_WOW_GLOBAL_RX_PARSE_AFTER_WAKE(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, BIT(2));
-}
-
-static inline void RTW89_SET_WOW_GLOBAL_WAKE_BAR_PULLED(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, BIT(3));
-}
-
-static inline void RTW89_SET_WOW_GLOBAL_MAC_ID(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(15, 8));
-}
-
-static inline void RTW89_SET_WOW_GLOBAL_PAIRWISE_SEC_ALGO(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(23, 16));
-}
-
-static inline void RTW89_SET_WOW_GLOBAL_GROUP_SEC_ALGO(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(31, 24));
-}
+struct rtw89_h2c_wow_global {
+	__le32 w0;
+	struct rtw89_wow_key_info key_info;
+} __packed;
 
-static inline void RTW89_SET_WOW_GLOBAL_REMOTECTRL_INFO_CONTENT(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)(h2c) + 1, val, GENMASK(31, 0));
-}
+#define RTW89_H2C_WOW_GLOBAL_W0_ENABLE BIT(0)
+#define RTW89_H2C_WOW_GLOBAL_W0_DROP_ALL_PKT BIT(1)
+#define RTW89_H2C_WOW_GLOBAL_W0_RX_PARSE_AFTER_WAKE BIT(2)
+#define RTW89_H2C_WOW_GLOBAL_W0_WAKE_BAR_PULLED BIT(3)
+#define RTW89_H2C_WOW_GLOBAL_W0_MAC_ID GENMASK(15, 8)
+#define RTW89_H2C_WOW_GLOBAL_W0_PAIRWISE_SEC_ALGO GENMASK(23, 16)
+#define RTW89_H2C_WOW_GLOBAL_W0_GROUP_SEC_ALGO GENMASK(31, 24)
 
 static inline void RTW89_SET_WOW_WAKEUP_CTRL_PATTERN_MATCH_ENABLE(void *h2c, u32 val)
 {
-- 
2.25.1


