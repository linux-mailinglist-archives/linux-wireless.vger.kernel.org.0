Return-Path: <linux-wireless+bounces-1582-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A67D826A68
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 10:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B12A8B22595
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 09:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A105134AC;
	Mon,  8 Jan 2024 09:13:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77236134BD
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4089DUNX03873343, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4089DUNX03873343
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jan 2024 17:13:30 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 8 Jan 2024 17:13:31 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 Jan 2024
 17:13:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 08/10] wifi: rtw89: use struct to fill H2C command to download beacon frame
Date: Mon, 8 Jan 2024 17:13:25 +0800
Message-ID: <20240108091325.67424-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Download beacon frame via H2C command for AP mode, and then firmware can
issues beacon periodically. Originally TIM offset minus fixed 24 bytes of
frame header implicitly in macro, and this patch explicitly uses
ieee80211_hdrlen() to get header length, but expected to change nothing
at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c |  36 ++++---
 drivers/net/wireless/realtek/rtw89/fw.h | 123 +++++-------------------
 2 files changed, 46 insertions(+), 113 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 9d6748f65ba3..89eda20c20cb 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2277,18 +2277,20 @@ int rtw89_fw_h2c_txpath_cmac_tbl(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-#define H2C_BCN_BASE_LEN 12
 int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 			       struct rtw89_vif *rtwvif)
 {
-	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
 						       rtwvif->sub_entity_idx);
-	struct sk_buff *skb;
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct rtw89_h2c_bcn_upd *h2c;
 	struct sk_buff *skb_beacon;
-	u16 tim_offset;
+	struct ieee80211_hdr *hdr;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
 	int bcn_total_len;
 	u16 beacon_rate;
+	u16 tim_offset;
 	void *noa_data;
 	u8 noa_len;
 	int ret;
@@ -2314,23 +2316,27 @@ int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 		skb_put_data(skb_beacon, noa_data, noa_len);
 	}
 
-	bcn_total_len = H2C_BCN_BASE_LEN + skb_beacon->len;
+	hdr = (struct ieee80211_hdr *)skb_beacon;
+	tim_offset -= ieee80211_hdrlen(hdr->frame_control);
+
+	bcn_total_len = len + skb_beacon->len;
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, bcn_total_len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for fw dl\n");
 		dev_kfree_skb_any(skb_beacon);
 		return -ENOMEM;
 	}
-	skb_put(skb, H2C_BCN_BASE_LEN);
-
-	SET_BCN_UPD_PORT(skb->data, rtwvif->port);
-	SET_BCN_UPD_MBSSID(skb->data, 0);
-	SET_BCN_UPD_BAND(skb->data, rtwvif->mac_idx);
-	SET_BCN_UPD_GRP_IE_OFST(skb->data, tim_offset);
-	SET_BCN_UPD_MACID(skb->data, rtwvif->mac_id);
-	SET_BCN_UPD_SSN_SEL(skb->data, RTW89_MGMT_HW_SSN_SEL);
-	SET_BCN_UPD_SSN_MODE(skb->data, RTW89_MGMT_HW_SEQ_MODE);
-	SET_BCN_UPD_RATE(skb->data, beacon_rate);
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_bcn_upd *)skb->data;
+
+	h2c->w0 = le32_encode_bits(rtwvif->port, RTW89_H2C_BCN_UPD_W0_PORT) |
+		  le32_encode_bits(0, RTW89_H2C_BCN_UPD_W0_MBSSID) |
+		  le32_encode_bits(rtwvif->mac_idx, RTW89_H2C_BCN_UPD_W0_BAND) |
+		  le32_encode_bits(tim_offset | BIT(7), RTW89_H2C_BCN_UPD_W0_GRP_IE_OFST);
+	h2c->w1 = le32_encode_bits(rtwvif->mac_id, RTW89_H2C_BCN_UPD_W1_MACID) |
+		  le32_encode_bits(RTW89_MGMT_HW_SSN_SEL, RTW89_H2C_BCN_UPD_W1_SSN_SEL) |
+		  le32_encode_bits(RTW89_MGMT_HW_SEQ_MODE, RTW89_H2C_BCN_UPD_W1_SSN_MODE) |
+		  le32_encode_bits(beacon_rate, RTW89_H2C_BCN_UPD_W1_RATE);
 
 	skb_put_data(skb, skb_beacon->data, skb_beacon->len);
 	dev_kfree_skb_any(skb_beacon);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 0365cd7b8da0..9424b4add222 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1509,105 +1509,32 @@ static inline void SET_DCTL_SEC_ENT6_V1(void *table, u32 val)
 			   GENMASK(31, 24));
 }
 
-static inline void SET_BCN_UPD_PORT(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(7, 0));
-}
-
-static inline void SET_BCN_UPD_MBSSID(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(15, 8));
-}
-
-static inline void SET_BCN_UPD_BAND(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(23, 16));
-}
-
-static inline void SET_BCN_UPD_GRP_IE_OFST(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, (val - 24) | BIT(7), GENMASK(31, 24));
-}
-
-static inline void SET_BCN_UPD_MACID(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)(h2c) + 1, val, GENMASK(7, 0));
-}
-
-static inline void SET_BCN_UPD_SSN_SEL(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)(h2c) + 1, val, GENMASK(9, 8));
-}
-
-static inline void SET_BCN_UPD_SSN_MODE(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)(h2c) + 1, val, GENMASK(11, 10));
-}
-
-static inline void SET_BCN_UPD_RATE(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)(h2c) + 1, val, GENMASK(20, 12));
-}
-
-static inline void SET_BCN_UPD_TXPWR(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)(h2c) + 1, val, GENMASK(23, 21));
-}
-
-static inline void SET_BCN_UPD_TXINFO_CTRL_EN(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)(h2c) + 2, val, BIT(0));
-}
-
-static inline void SET_BCN_UPD_NTX_PATH_EN(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)(h2c) + 2, val,  GENMASK(4, 1));
-}
-
-static inline void SET_BCN_UPD_PATH_MAP_A(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)(h2c) + 2, val,  GENMASK(6, 5));
-}
-
-static inline void SET_BCN_UPD_PATH_MAP_B(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)(h2c) + 2, val,  GENMASK(8, 7));
-}
-
-static inline void SET_BCN_UPD_PATH_MAP_C(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)(h2c) + 2, val,  GENMASK(10, 9));
-}
-
-static inline void SET_BCN_UPD_PATH_MAP_D(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)(h2c) + 2, val,  GENMASK(12, 11));
-}
-
-static inline void SET_BCN_UPD_PATH_ANTSEL_A(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)(h2c) + 2, val,  BIT(13));
-}
-
-static inline void SET_BCN_UPD_PATH_ANTSEL_B(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)(h2c) + 2, val,  BIT(14));
-}
-
-static inline void SET_BCN_UPD_PATH_ANTSEL_C(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)(h2c) + 2, val,  BIT(15));
-}
-
-static inline void SET_BCN_UPD_PATH_ANTSEL_D(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)(h2c) + 2, val,  BIT(16));
-}
+struct rtw89_h2c_bcn_upd {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+} __packed;
 
-static inline void SET_BCN_UPD_CSA_OFST(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)(h2c) + 2, val,  GENMASK(31, 17));
-}
+#define RTW89_H2C_BCN_UPD_W0_PORT GENMASK(7, 0)
+#define RTW89_H2C_BCN_UPD_W0_MBSSID GENMASK(15, 8)
+#define RTW89_H2C_BCN_UPD_W0_BAND GENMASK(23, 16)
+#define RTW89_H2C_BCN_UPD_W0_GRP_IE_OFST GENMASK(31, 24)
+#define RTW89_H2C_BCN_UPD_W1_MACID GENMASK(7, 0)
+#define RTW89_H2C_BCN_UPD_W1_SSN_SEL GENMASK(9, 8)
+#define RTW89_H2C_BCN_UPD_W1_SSN_MODE GENMASK(11, 10)
+#define RTW89_H2C_BCN_UPD_W1_RATE GENMASK(20, 12)
+#define RTW89_H2C_BCN_UPD_W1_TXPWR GENMASK(23, 21)
+#define RTW89_H2C_BCN_UPD_W2_TXINFO_CTRL_EN BIT(0)
+#define RTW89_H2C_BCN_UPD_W2_NTX_PATH_EN GENMASK(4, 1)
+#define RTW89_H2C_BCN_UPD_W2_PATH_MAP_A GENMASK(6, 5)
+#define RTW89_H2C_BCN_UPD_W2_PATH_MAP_B GENMASK(8, 7)
+#define RTW89_H2C_BCN_UPD_W2_PATH_MAP_C GENMASK(10, 9)
+#define RTW89_H2C_BCN_UPD_W2_PATH_MAP_D GENMASK(12, 11)
+#define RTW89_H2C_BCN_UPD_W2_PATH_ANTSEL_A BIT(13)
+#define RTW89_H2C_BCN_UPD_W2_PATH_ANTSEL_B BIT(14)
+#define RTW89_H2C_BCN_UPD_W2_PATH_ANTSEL_C BIT(15)
+#define RTW89_H2C_BCN_UPD_W2_PATH_ANTSEL_D BIT(16)
+#define RTW89_H2C_BCN_UPD_W2_CSA_OFST GENMASK(31, 17)
 
 static inline void SET_FWROLE_MAINTAIN_MACID(void *h2c, u32 val)
 {
-- 
2.25.1


