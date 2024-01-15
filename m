Return-Path: <linux-wireless+bounces-1911-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A181482D36A
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 04:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F01F1C20DC2
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 03:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203743D8F;
	Mon, 15 Jan 2024 03:38:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F393D8E
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 03:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40F3cUxtD3528826, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40F3cUxtD3528826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 11:38:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Mon, 15 Jan 2024 11:38:30 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 15 Jan
 2024 11:38:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/8] wifi: rtw89: fw: add H2C command to reset DMAC table for WiFi 7
Date: Mon, 15 Jan 2024 11:37:40 +0800
Message-ID: <20240115033742.16372-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240115033742.16372-1-pkshih@realtek.com>
References: <20240115033742.16372-1-pkshih@realtek.com>
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

Reset DMAC table, so we get expected behavior instead of random values at
early stage.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.h      | 13 +++++
 drivers/net/wireless/realtek/rtw89/core.c     |  4 ++
 drivers/net/wireless/realtek/rtw89/core.h     |  3 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 55 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       | 15 +++++
 drivers/net/wireless/realtek/rtw89/mac.c      |  4 ++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 11 files changed, 99 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.h b/drivers/net/wireless/realtek/rtw89/cam.h
index 9a2dd5999edb..fa09d11c345c 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.h
+++ b/drivers/net/wireless/realtek/rtw89/cam.h
@@ -395,7 +395,9 @@ struct rtw89_h2c_dctlinfo_ud_v2 {
 #define DCTLINFO_V2_W0_HW_EXSEQ_MACID GENMASK(14, 8)
 #define DCTLINFO_V2_W0_QOS_DATA BIT(15)
 #define DCTLINFO_V2_W0_AES_IV_L GENMASK(31, 16)
+#define DCTLINFO_V2_W0_ALL GENMASK(31, 0)
 #define DCTLINFO_V2_W1_AES_IV_H GENMASK(31, 0)
+#define DCTLINFO_V2_W1_ALL GENMASK(31, 0)
 #define DCTLINFO_V2_W2_SEQ0 GENMASK(11, 0)
 #define DCTLINFO_V2_W2_SEQ1 GENMASK(23, 12)
 #define DCTLINFO_V2_W2_AMSDU_MAX_LEN GENMASK(26, 24)
@@ -404,11 +406,13 @@ struct rtw89_h2c_dctlinfo_ud_v2 {
 #define DCTLINFO_V2_W2_WITH_LLC BIT(29)
 #define DCTLINFO_V2_W2_NAT25_EN BIT(30)
 #define DCTLINFO_V2_W2_IS_MLD BIT(31)
+#define DCTLINFO_V2_W2_ALL GENMASK(31, 0)
 #define DCTLINFO_V2_W3_SEQ2 GENMASK(11, 0)
 #define DCTLINFO_V2_W3_SEQ3 GENMASK(23, 12)
 #define DCTLINFO_V2_W3_TGT_IND GENMASK(27, 24)
 #define DCTLINFO_V2_W3_TGT_IND_EN BIT(28)
 #define DCTLINFO_V2_W3_HTC_LB GENMASK(31, 29)
+#define DCTLINFO_V2_W3_ALL GENMASK(31, 0)
 #define DCTLINFO_V2_W4_VLAN_TAG_SEL GENMASK(7, 5)
 #define DCTLINFO_V2_W4_HTC_ORDER BIT(8)
 #define DCTLINFO_V2_W4_SEC_KEY_ID GENMASK(10, 9)
@@ -425,24 +429,33 @@ struct rtw89_h2c_dctlinfo_ud_v2 {
 #define DCTLINFO_V2_W4_SEC_ENT4_KEYID GENMASK(27, 26)
 #define DCTLINFO_V2_W4_SEC_ENT5_KEYID GENMASK(29, 28)
 #define DCTLINFO_V2_W4_SEC_ENT6_KEYID GENMASK(31, 30)
+#define DCTLINFO_V2_W4_ALL GENMASK(31, 5)
 #define DCTLINFO_V2_W5_SEC_ENT7_KEYID GENMASK(1, 0)
 #define DCTLINFO_V2_W5_SEC_ENT8_KEYID GENMASK(3, 2)
 #define DCTLINFO_V2_W5_SEC_ENT_VALID_V1 GENMASK(23, 8)
 #define DCTLINFO_V2_W5_SEC_ENT0_V1 GENMASK(31, 24)
+#define DCTLINFO_V2_W5_ALL (GENMASK(31, 8) | GENMASK(3, 0))
 #define DCTLINFO_V2_W6_SEC_ENT1_V1 GENMASK(7, 0)
 #define DCTLINFO_V2_W6_SEC_ENT2_V1 GENMASK(15, 8)
 #define DCTLINFO_V2_W6_SEC_ENT3_V1 GENMASK(23, 16)
 #define DCTLINFO_V2_W6_SEC_ENT4_V1 GENMASK(31, 24)
+#define DCTLINFO_V2_W6_ALL GENMASK(31, 0)
 #define DCTLINFO_V2_W7_SEC_ENT5_V1 GENMASK(7, 0)
 #define DCTLINFO_V2_W7_SEC_ENT6_V1 GENMASK(15, 8)
 #define DCTLINFO_V2_W7_SEC_ENT7 GENMASK(23, 16)
 #define DCTLINFO_V2_W7_SEC_ENT8 GENMASK(31, 24)
+#define DCTLINFO_V2_W7_ALL GENMASK(31, 0)
 #define DCTLINFO_V2_W8_MLD_SMA_L_V1 GENMASK(31, 0)
+#define DCTLINFO_V2_W8_ALL GENMASK(31, 0)
 #define DCTLINFO_V2_W9_MLD_SMA_H_V1 GENMASK(15, 0)
 #define DCTLINFO_V2_W9_MLD_TMA_L_V1 GENMASK(31, 16)
+#define DCTLINFO_V2_W9_ALL GENMASK(31, 0)
 #define DCTLINFO_V2_W10_MLD_TMA_H_V1 GENMASK(31, 0)
+#define DCTLINFO_V2_W10_ALL GENMASK(31, 0)
 #define DCTLINFO_V2_W11_MLD_TA_BSSID_L_V1 GENMASK(31, 0)
+#define DCTLINFO_V2_W11_ALL GENMASK(31, 0)
 #define DCTLINFO_V2_W12_MLD_TA_BSSID_H_V1 GENMASK(15, 0)
+#define DCTLINFO_V2_W12_ALL GENMASK(15, 0)
 
 int rtw89_cam_init(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
 void rtw89_cam_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index afad864e279a..d35e3090c572 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3349,6 +3349,10 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 		if (ret)
 			return ret;
 
+		ret = rtw89_chip_h2c_default_dmac_tbl(rtwdev, rtwvif, rtwsta);
+		if (ret)
+			return ret;
+
 		rtw89_queue_chanctx_change(rtwdev, RTW89_CHANCTX_REMOTE_STA_CHANGE);
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b524af83a39d..1d549272ca0e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3207,6 +3207,9 @@ struct rtw89_chip_ops {
 	int (*h2c_ampdu_cmac_tbl)(struct rtw89_dev *rtwdev,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_sta *sta);
+	int (*h2c_default_dmac_tbl)(struct rtw89_dev *rtwdev,
+				    struct rtw89_vif *rtwvif,
+				    struct rtw89_sta *rtwsta);
 	int (*h2c_update_beacon)(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif *rtwvif);
 	int (*h2c_ba_cam)(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 052dc3cc01eb..255be99b3630 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1525,6 +1525,61 @@ int rtw89_fw_h2c_dctl_sec_cam_v2(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_fw_h2c_dctl_sec_cam_v2);
 
+int rtw89_fw_h2c_default_dmac_tbl_v2(struct rtw89_dev *rtwdev,
+				     struct rtw89_vif *rtwvif,
+				     struct rtw89_sta *rtwsta)
+{
+	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
+	struct rtw89_h2c_dctlinfo_ud_v2 *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for dctl v2\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_dctlinfo_ud_v2 *)skb->data;
+
+	h2c->c0 = le32_encode_bits(mac_id, DCTLINFO_V2_C0_MACID) |
+		  le32_encode_bits(1, DCTLINFO_V2_C0_OP);
+
+	h2c->m0 = cpu_to_le32(DCTLINFO_V2_W0_ALL);
+	h2c->m1 = cpu_to_le32(DCTLINFO_V2_W1_ALL);
+	h2c->m2 = cpu_to_le32(DCTLINFO_V2_W2_ALL);
+	h2c->m3 = cpu_to_le32(DCTLINFO_V2_W3_ALL);
+	h2c->m4 = cpu_to_le32(DCTLINFO_V2_W4_ALL);
+	h2c->m5 = cpu_to_le32(DCTLINFO_V2_W5_ALL);
+	h2c->m6 = cpu_to_le32(DCTLINFO_V2_W6_ALL);
+	h2c->m7 = cpu_to_le32(DCTLINFO_V2_W7_ALL);
+	h2c->m8 = cpu_to_le32(DCTLINFO_V2_W8_ALL);
+	h2c->m9 = cpu_to_le32(DCTLINFO_V2_W9_ALL);
+	h2c->m10 = cpu_to_le32(DCTLINFO_V2_W10_ALL);
+	h2c->m11 = cpu_to_le32(DCTLINFO_V2_W11_ALL);
+	h2c->m12 = cpu_to_le32(DCTLINFO_V2_W12_ALL);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MAC_FR_EXCHG,
+			      H2C_FUNC_MAC_DCTLINFO_UD_V2, 0, 0,
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
+EXPORT_SYMBOL(rtw89_fw_h2c_default_dmac_tbl_v2);
+
 int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			bool valid, struct ieee80211_ampdu_params *params)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index b9e8fb693202..b5f724087954 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3955,6 +3955,9 @@ int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_default_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				     struct rtw89_vif *rtwvif,
 				     struct rtw89_sta *rtwsta);
+int rtw89_fw_h2c_default_dmac_tbl_v2(struct rtw89_dev *rtwdev,
+				     struct rtw89_vif *rtwvif,
+				     struct rtw89_sta *rtwsta);
 int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 				struct ieee80211_vif *vif,
 				struct ieee80211_sta *sta);
@@ -4113,6 +4116,18 @@ static inline int rtw89_chip_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
 	return chip->ops->h2c_default_cmac_tbl(rtwdev, rtwvif, rtwsta);
 }
 
+static inline int rtw89_chip_h2c_default_dmac_tbl(struct rtw89_dev *rtwdev,
+						  struct rtw89_vif *rtwvif,
+						  struct rtw89_sta *rtwsta)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->h2c_default_dmac_tbl)
+		return chip->ops->h2c_default_dmac_tbl(rtwdev, rtwvif, rtwsta);
+
+	return 0;
+}
+
 static inline int rtw89_chip_h2c_update_beacon(struct rtw89_dev *rtwdev,
 					       struct rtw89_vif *rtwvif)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index cee1e512d264..16f21406fbd2 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4501,6 +4501,10 @@ int rtw89_mac_vif_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	if (ret)
 		return ret;
 
+	ret = rtw89_chip_h2c_default_dmac_tbl(rtwdev, rtwvif, NULL);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 32b986165e2f..f1dcddfe843b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2337,6 +2337,7 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.h2c_default_cmac_tbl	= rtw89_fw_h2c_default_cmac_tbl,
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
 	.h2c_ampdu_cmac_tbl	= NULL,
+	.h2c_default_dmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index cfb2432dca35..6c63770cc598 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2081,6 +2081,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.h2c_default_cmac_tbl	= rtw89_fw_h2c_default_cmac_tbl,
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
 	.h2c_ampdu_cmac_tbl	= NULL,
+	.h2c_default_dmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 93728efee696..9be9a7e80b63 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2506,6 +2506,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.h2c_default_cmac_tbl	= rtw89_fw_h2c_default_cmac_tbl,
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
 	.h2c_ampdu_cmac_tbl	= NULL,
+	.h2c_default_dmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index a0c1901e5a26..39a47fd482f7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2851,6 +2851,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.h2c_default_cmac_tbl	= rtw89_fw_h2c_default_cmac_tbl,
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
 	.h2c_ampdu_cmac_tbl	= NULL,
+	.h2c_default_dmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index cb385a9b061f..38b815a07e37 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -826,6 +826,7 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.h2c_default_cmac_tbl	= rtw89_fw_h2c_default_cmac_tbl_g7,
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl_g7,
 	.h2c_ampdu_cmac_tbl	= rtw89_fw_h2c_ampdu_cmac_tbl_g7,
+	.h2c_default_dmac_tbl	= rtw89_fw_h2c_default_dmac_tbl_v2,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon_be,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam_v1,
 };
-- 
2.25.1


