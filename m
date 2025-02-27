Return-Path: <linux-wireless+bounces-19539-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 608E3A47EA4
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 14:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B973B3E34
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 13:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAAC22F145;
	Thu, 27 Feb 2025 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="PN5no1NX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E00621ABBE
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661973; cv=none; b=RxJTv5/kaf1VWCWXjTKI8DYIpz/E+EjHAHOQSc582wuogaLp+EA/lzAe4NVdPLbJ6sMUP50iselfO8ilEXfM51JPEwVIkGOI+ZhK9qAjiu32W+Y0nZSsFEvGswXvoffIsk3E69dNpG07FLcwMfc7Fm7EhW/wIuNaqQKXC3K0Fvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661973; c=relaxed/simple;
	bh=5a5NPTuiOFu0aJ7PebTGy6VAR2RAKkZ4ULD/pJkU4h4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jyUnm479FWlEbe0uZPGuEs+zX1D/IETwWf7tQzFD75zGwgfoQQOvU9WhVIkQyhFA78HwC1LDx40f/qj+wluOjThM9o9M1I1nWZhMZwS56iKRiLC5FMYpHgYQuPjzeDPJnCTU3g2Y7igR7cPCZD6gJaTQmlSt4GAKTFDJMpBlH6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=PN5no1NX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51RDCmTK22008950, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740661968; bh=5a5NPTuiOFu0aJ7PebTGy6VAR2RAKkZ4ULD/pJkU4h4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=PN5no1NX+9hfxvuFu8Pscx2Cbfi6g0YEQANqrFVtEsy7zEpl3JYG3DIMAt0xPrNrs
	 2+W34KszuDAu33M5dp7C0qsCcxjcPeAgxaEAAsy9nJUQhs11/xnAa2IObExPkTxGyd
	 YTkZoIL9/wW5QblFfDfIX3TZkE/Tp430e6LcLAYfoL7mdaX5ValHyQ/drQuZ1HUv3q
	 EdCVWKzh/YMwZ2hMsjk91ynhuNeiIdQdR9C9T8H1b7ALGLLOdJZCQN5P28/c1e2oci
	 RagKTZIP7lPEC3ozEhTCKQoQXARi/muTy1ddXBU/tqNC+NOaC+3rozYhytJIHbhWBK
	 qzPnsWA/Bm2RA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51RDCmTK22008950
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 21:12:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Feb 2025 21:12:49 +0800
Received: from [127.0.1.1] (172.16.24.143) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 27 Feb
 2025 21:12:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>
Subject: [PATCH rtw-next v2 1/4] wifi: rtw89: fw: use struct to fill role_maintain H2C command
Date: Thu, 27 Feb 2025 21:12:25 +0800
Message-ID: <20250227131228.8457-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227131228.8457-1-pkshih@realtek.com>
References: <20250227131228.8457-1-pkshih@realtek.com>
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

From: Po-Hao Huang <phhuang@realtek.com>

The role_maintain H2C command is to align operating mode of WiFi role,
such as STA or AP modes, between driver and firmware.

Use a struct to fill fields of this H2C command.

Don't change logic at all.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/fw.c | 22 +++++++++++--------
 drivers/net/wireless/realtek/rtw89/fw.h | 28 +++++++++----------------
 2 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index b843d259fbfa..3e4a3200358a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3901,14 +3901,15 @@ int rtw89_fw_h2c_update_beacon_be(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_fw_h2c_update_beacon_be);
 
-#define H2C_ROLE_MAINTAIN_LEN 4
 int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
 			       struct rtw89_vif_link *rtwvif_link,
 			       struct rtw89_sta_link *rtwsta_link,
 			       enum rtw89_upd_mode upd_mode)
 {
-	struct sk_buff *skb;
 	u8 mac_id = rtwsta_link ? rtwsta_link->mac_id : rtwvif_link->mac_id;
+	struct rtw89_h2c_role_maintain *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
 	u8 self_role;
 	int ret;
 
@@ -3921,21 +3922,24 @@ int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
 		self_role = rtwvif_link->self_role;
 	}
 
-	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_ROLE_MAINTAIN_LEN);
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for h2c join\n");
 		return -ENOMEM;
 	}
-	skb_put(skb, H2C_ROLE_MAINTAIN_LEN);
-	SET_FWROLE_MAINTAIN_MACID(skb->data, mac_id);
-	SET_FWROLE_MAINTAIN_SELF_ROLE(skb->data, self_role);
-	SET_FWROLE_MAINTAIN_UPD_MODE(skb->data, upd_mode);
-	SET_FWROLE_MAINTAIN_WIFI_ROLE(skb->data, rtwvif_link->wifi_role);
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_role_maintain *)skb->data;
+
+	h2c->w0 = le32_encode_bits(mac_id, RTW89_H2C_ROLE_MAINTAIN_W0_MACID) |
+		  le32_encode_bits(self_role, RTW89_H2C_ROLE_MAINTAIN_W0_SELF_ROLE) |
+		  le32_encode_bits(upd_mode, RTW89_H2C_ROLE_MAINTAIN_W0_UPD_MODE) |
+		  le32_encode_bits(rtwvif_link->wifi_role,
+				   RTW89_H2C_ROLE_MAINTAIN_W0_WIFI_ROLE);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC, H2C_CL_MAC_MEDIA_RPT,
 			      H2C_FUNC_MAC_FWROLE_MAINTAIN, 0, 1,
-			      H2C_ROLE_MAINTAIN_LEN);
+			      len);
 
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 1c53c1e22439..e0faed076150 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1591,25 +1591,17 @@ struct rtw89_h2c_bcn_upd_be {
 #define RTW89_H2C_BCN_UPD_BE_W7_ECSA_OFST GENMASK(30, 16)
 #define RTW89_H2C_BCN_UPD_BE_W7_PROTECTION_KEY_ID BIT(31)
 
-static inline void SET_FWROLE_MAINTAIN_MACID(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(7, 0));
-}
-
-static inline void SET_FWROLE_MAINTAIN_SELF_ROLE(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(9, 8));
-}
-
-static inline void SET_FWROLE_MAINTAIN_UPD_MODE(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(12, 10));
-}
+struct rtw89_h2c_role_maintain {
+	__le32 w0;
+};
 
-static inline void SET_FWROLE_MAINTAIN_WIFI_ROLE(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(16, 13));
-}
+#define RTW89_H2C_ROLE_MAINTAIN_W0_MACID GENMASK(7, 0)
+#define RTW89_H2C_ROLE_MAINTAIN_W0_SELF_ROLE GENMASK(9, 8)
+#define RTW89_H2C_ROLE_MAINTAIN_W0_UPD_MODE GENMASK(12, 10)
+#define RTW89_H2C_ROLE_MAINTAIN_W0_WIFI_ROLE GENMASK(16, 13)
+#define RTW89_H2C_ROLE_MAINTAIN_W0_BAND GENMASK(18, 17)
+#define RTW89_H2C_ROLE_MAINTAIN_W0_PORT GENMASK(21, 19)
+#define RTW89_H2C_ROLE_MAINTAIN_W0_MACID_EXT GENMASK(31, 24)
 
 enum rtw89_fw_sta_type { /* value of RTW89_H2C_JOININFO_W1_STA_TYPE */
 	RTW89_FW_N_AC_STA = 0,
-- 
2.25.1


