Return-Path: <linux-wireless+bounces-1579-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3922826A65
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 10:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EB55B22C1E
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 09:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2F311711;
	Mon,  8 Jan 2024 09:12:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEE911709
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4089CoakE3873146, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4089CoakE3873146
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jan 2024 17:12:50 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 8 Jan 2024 17:12:50 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 Jan 2024
 17:12:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 05/10] wifi: rtw89: fw: use struct to fill BA CAM H2C commands
Date: Mon, 8 Jan 2024 17:12:45 +0800
Message-ID: <20240108091245.67220-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240108091134.67007-1-pkshih@realtek.com>
References: <20240108091134.67007-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

The WiFi 6 chips use these commands to create BA CAM entry when RX BA
session is established, this BA CAM can record whether packets are received
or not, then reply BA for current status. This patch doesn't change logic.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 52 ++++++++++---------
 drivers/net/wireless/realtek/rtw89/fw.h | 68 ++++++-------------------
 2 files changed, 44 insertions(+), 76 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index b1215200f5a1..61ae8e584a3b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1485,13 +1485,14 @@ int rtw89_fw_h2c_dctl_sec_cam_v1(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_fw_h2c_dctl_sec_cam_v1);
 
-#define H2C_BA_CAM_LEN 8
 int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			bool valid, struct ieee80211_ampdu_params *params)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
+	struct rtw89_h2c_ba_cam *h2c;
 	u8 macid = rtwsta->mac_id;
+	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
 	u8 entry_idx;
 	int ret;
@@ -1509,32 +1510,34 @@ int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 		return 0;
 	}
 
-	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_BA_CAM_LEN);
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for h2c ba cam\n");
 		return -ENOMEM;
 	}
-	skb_put(skb, H2C_BA_CAM_LEN);
-	SET_BA_CAM_MACID(skb->data, macid);
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_ba_cam *)skb->data;
+
+	h2c->w0 = le32_encode_bits(macid, RTW89_H2C_BA_CAM_W0_MACID);
 	if (chip->bacam_ver == RTW89_BACAM_V0_EXT)
-		SET_BA_CAM_ENTRY_IDX_V1(skb->data, entry_idx);
+		h2c->w1 |= le32_encode_bits(entry_idx, RTW89_H2C_BA_CAM_W1_ENTRY_IDX_V1);
 	else
-		SET_BA_CAM_ENTRY_IDX(skb->data, entry_idx);
+		h2c->w0 |= le32_encode_bits(entry_idx, RTW89_H2C_BA_CAM_W0_ENTRY_IDX);
 	if (!valid)
 		goto end;
-	SET_BA_CAM_VALID(skb->data, valid);
-	SET_BA_CAM_TID(skb->data, params->tid);
+	h2c->w0 |= le32_encode_bits(valid, RTW89_H2C_BA_CAM_W0_VALID) |
+		   le32_encode_bits(params->tid, RTW89_H2C_BA_CAM_W0_TID);
 	if (params->buf_size > 64)
-		SET_BA_CAM_BMAP_SIZE(skb->data, 4);
+		h2c->w0 |= le32_encode_bits(4, RTW89_H2C_BA_CAM_W0_BMAP_SIZE);
 	else
-		SET_BA_CAM_BMAP_SIZE(skb->data, 0);
+		h2c->w0 |= le32_encode_bits(0, RTW89_H2C_BA_CAM_W0_BMAP_SIZE);
 	/* If init req is set, hw will set the ssn */
-	SET_BA_CAM_INIT_REQ(skb->data, 1);
-	SET_BA_CAM_SSN(skb->data, params->ssn);
+	h2c->w0 |= le32_encode_bits(1, RTW89_H2C_BA_CAM_W0_INIT_REQ) |
+		   le32_encode_bits(params->ssn, RTW89_H2C_BA_CAM_W0_SSN);
 
 	if (chip->bacam_ver == RTW89_BACAM_V0_EXT) {
-		SET_BA_CAM_STD_EN(skb->data, 1);
-		SET_BA_CAM_BAND(skb->data, rtwvif->mac_idx);
+		h2c->w1 |= le32_encode_bits(1, RTW89_H2C_BA_CAM_W1_STD_EN) |
+			   le32_encode_bits(rtwvif->mac_idx, RTW89_H2C_BA_CAM_W1_BAND);
 	}
 
 end:
@@ -1542,7 +1545,7 @@ int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			      H2C_CAT_MAC,
 			      H2C_CL_BA_CAM,
 			      H2C_FUNC_MAC_BA_CAM, 0, 1,
-			      H2C_BA_CAM_LEN);
+			      len);
 
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
@@ -1561,27 +1564,30 @@ EXPORT_SYMBOL(rtw89_fw_h2c_ba_cam);
 static int rtw89_fw_h2c_init_ba_cam_v0_ext(struct rtw89_dev *rtwdev,
 					   u8 entry_idx, u8 uid)
 {
+	struct rtw89_h2c_ba_cam *h2c;
+	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
 	int ret;
 
-	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_BA_CAM_LEN);
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for dynamic h2c ba cam\n");
 		return -ENOMEM;
 	}
-	skb_put(skb, H2C_BA_CAM_LEN);
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_ba_cam *)skb->data;
 
-	SET_BA_CAM_VALID(skb->data, 1);
-	SET_BA_CAM_ENTRY_IDX_V1(skb->data, entry_idx);
-	SET_BA_CAM_UID(skb->data, uid);
-	SET_BA_CAM_BAND(skb->data, 0);
-	SET_BA_CAM_STD_EN(skb->data, 0);
+	h2c->w0 = le32_encode_bits(1, RTW89_H2C_BA_CAM_W0_VALID);
+	h2c->w1 = le32_encode_bits(entry_idx, RTW89_H2C_BA_CAM_W1_ENTRY_IDX_V1) |
+		  le32_encode_bits(uid, RTW89_H2C_BA_CAM_W1_UID) |
+		  le32_encode_bits(0, RTW89_H2C_BA_CAM_W1_BAND) |
+		  le32_encode_bits(0, RTW89_H2C_BA_CAM_W1_STD_EN);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC,
 			      H2C_CL_BA_CAM,
 			      H2C_FUNC_MAC_BA_CAM, 0, 1,
-			      H2C_BA_CAM_LEN);
+			      len);
 
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 6c51ee9a5fa8..ec90cc9b0b53 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1741,60 +1741,22 @@ static inline void SET_LOG_CFG_COMP_EXT(void *h2c, u32 val)
 	le32p_replace_bits((__le32 *)(h2c) + 2, val, GENMASK(31, 0));
 }
 
-static inline void SET_BA_CAM_VALID(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, BIT(0));
-}
-
-static inline void SET_BA_CAM_INIT_REQ(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, BIT(1));
-}
-
-static inline void SET_BA_CAM_ENTRY_IDX(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(3, 2));
-}
-
-static inline void SET_BA_CAM_TID(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(7, 4));
-}
-
-static inline void SET_BA_CAM_MACID(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(15, 8));
-}
-
-static inline void SET_BA_CAM_BMAP_SIZE(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(19, 16));
-}
-
-static inline void SET_BA_CAM_SSN(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(31, 20));
-}
-
-static inline void SET_BA_CAM_UID(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c + 1, val, GENMASK(7, 0));
-}
-
-static inline void SET_BA_CAM_STD_EN(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c + 1, val, BIT(8));
-}
-
-static inline void SET_BA_CAM_BAND(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c + 1, val, BIT(9));
-}
+struct rtw89_h2c_ba_cam {
+	__le32 w0;
+	__le32 w1;
+} __packed;
 
-static inline void SET_BA_CAM_ENTRY_IDX_V1(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c + 1, val, GENMASK(31, 28));
-}
+#define RTW89_H2C_BA_CAM_W0_VALID BIT(0)
+#define RTW89_H2C_BA_CAM_W0_INIT_REQ BIT(1)
+#define RTW89_H2C_BA_CAM_W0_ENTRY_IDX GENMASK(3, 2)
+#define RTW89_H2C_BA_CAM_W0_TID GENMASK(7, 4)
+#define RTW89_H2C_BA_CAM_W0_MACID GENMASK(15, 8)
+#define RTW89_H2C_BA_CAM_W0_BMAP_SIZE GENMASK(19, 16)
+#define RTW89_H2C_BA_CAM_W0_SSN GENMASK(31, 20)
+#define RTW89_H2C_BA_CAM_W1_UID GENMASK(7, 0)
+#define RTW89_H2C_BA_CAM_W1_STD_EN BIT(8)
+#define RTW89_H2C_BA_CAM_W1_BAND BIT(9)
+#define RTW89_H2C_BA_CAM_W1_ENTRY_IDX_V1 GENMASK(31, 28)
 
 struct rtw89_h2c_ba_cam_v1 {
 	__le32 w0;
-- 
2.25.1


