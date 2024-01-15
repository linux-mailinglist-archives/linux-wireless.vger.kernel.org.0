Return-Path: <linux-wireless+bounces-1910-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D18F82D369
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 04:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B14A28159B
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 03:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB4A3C15;
	Mon, 15 Jan 2024 03:38:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE933C0B
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 03:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40F3cPDY13528820, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40F3cPDY13528820
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 11:38:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Mon, 15 Jan 2024 11:38:25 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 15 Jan
 2024 11:38:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/8] wifi: rtw89: fw: add H2C command to reset CMAC table for WiFi 7
Date: Mon, 15 Jan 2024 11:37:39 +0800
Message-ID: <20240115033742.16372-6-pkshih@realtek.com>
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

Do reset on CMAC tables by mac_id, so we don't get random values when
powering on. Therefore, add the same function for WiFi 7 chips.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  4 +
 drivers/net/wireless/realtek/rtw89/core.h     |  3 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 90 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h       | 26 +++++-
 drivers/net/wireless/realtek/rtw89/mac.c      |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 10 files changed, 126 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 1a355fe0d986..afad864e279a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3345,6 +3345,10 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 			return ret;
 		}
 
+		ret = rtw89_chip_h2c_default_cmac_tbl(rtwdev, rtwvif, rtwsta);
+		if (ret)
+			return ret;
+
 		rtw89_queue_chanctx_change(rtwdev, RTW89_CHANCTX_REMOTE_STA_CHANGE);
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 8f4be9184427..b524af83a39d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3198,6 +3198,9 @@ struct rtw89_chip_ops {
 	int (*h2c_dctl_sec_cam)(struct rtw89_dev *rtwdev,
 				struct rtw89_vif *rtwvif,
 				struct rtw89_sta *rtwsta);
+	int (*h2c_default_cmac_tbl)(struct rtw89_dev *rtwdev,
+				    struct rtw89_vif *rtwvif,
+				    struct rtw89_sta *rtwsta);
 	int (*h2c_assoc_cmac_tbl)(struct rtw89_dev *rtwdev,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_sta *sta);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 3181cde5ab93..052dc3cc01eb 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2053,11 +2053,12 @@ static void __rtw89_fw_h2c_set_tx_path(struct rtw89_dev *rtwdev,
 
 #define H2C_CMC_TBL_LEN 68
 int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
-				  struct rtw89_vif *rtwvif)
+				  struct rtw89_vif *rtwvif,
+				  struct rtw89_sta *rtwsta)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u8 macid = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
 	struct sk_buff *skb;
-	u8 macid = rtwvif->mac_id;
 	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_CMC_TBL_LEN);
@@ -2098,6 +2099,91 @@ int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
 
 	return ret;
 }
+EXPORT_SYMBOL(rtw89_fw_h2c_default_cmac_tbl);
+
+int rtw89_fw_h2c_default_cmac_tbl_g7(struct rtw89_dev *rtwdev,
+				     struct rtw89_vif *rtwvif,
+				     struct rtw89_sta *rtwsta)
+{
+	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
+	struct rtw89_h2c_cctlinfo_ud_g7 *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for cmac g7\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_cctlinfo_ud_g7 *)skb->data;
+
+	h2c->c0 = le32_encode_bits(mac_id, CCTLINFO_G7_C0_MACID) |
+		  le32_encode_bits(1, CCTLINFO_G7_C0_OP);
+
+	h2c->w0 = le32_encode_bits(4, CCTLINFO_G7_W0_DATARATE);
+	h2c->m0 = cpu_to_le32(CCTLINFO_G7_W0_ALL);
+
+	h2c->w1 = le32_encode_bits(4, CCTLINFO_G7_W1_DATA_RTY_LOWEST_RATE) |
+		  le32_encode_bits(0xa, CCTLINFO_G7_W1_RTSRATE) |
+		  le32_encode_bits(4, CCTLINFO_G7_W1_RTS_RTY_LOWEST_RATE);
+	h2c->m1 = cpu_to_le32(CCTLINFO_G7_W1_ALL);
+
+	h2c->m2 = cpu_to_le32(CCTLINFO_G7_W2_ALL);
+
+	h2c->m3 = cpu_to_le32(CCTLINFO_G7_W3_ALL);
+
+	h2c->w4 = le32_encode_bits(0xFFFF, CCTLINFO_G7_W4_ACT_SUBCH_CBW);
+	h2c->m4 = cpu_to_le32(CCTLINFO_G7_W4_ALL);
+
+	h2c->w5 = le32_encode_bits(2, CCTLINFO_G7_W5_NOMINAL_PKT_PADDING0) |
+		  le32_encode_bits(2, CCTLINFO_G7_W5_NOMINAL_PKT_PADDING1) |
+		  le32_encode_bits(2, CCTLINFO_G7_W5_NOMINAL_PKT_PADDING2) |
+		  le32_encode_bits(2, CCTLINFO_G7_W5_NOMINAL_PKT_PADDING3) |
+		  le32_encode_bits(2, CCTLINFO_G7_W5_NOMINAL_PKT_PADDING4);
+	h2c->m5 = cpu_to_le32(CCTLINFO_G7_W5_ALL);
+
+	h2c->w6 = le32_encode_bits(0xb, CCTLINFO_G7_W6_RESP_REF_RATE);
+	h2c->m6 = cpu_to_le32(CCTLINFO_G7_W6_ALL);
+
+	h2c->w7 = le32_encode_bits(1, CCTLINFO_G7_W7_NC) |
+		  le32_encode_bits(1, CCTLINFO_G7_W7_NR) |
+		  le32_encode_bits(1, CCTLINFO_G7_W7_CB) |
+		  le32_encode_bits(0x1, CCTLINFO_G7_W7_CSI_PARA_EN) |
+		  le32_encode_bits(0xb, CCTLINFO_G7_W7_CSI_FIX_RATE);
+	h2c->m7 = cpu_to_le32(CCTLINFO_G7_W7_ALL);
+
+	h2c->m8 = cpu_to_le32(CCTLINFO_G7_W8_ALL);
+
+	h2c->w14 = le32_encode_bits(0, CCTLINFO_G7_W14_VO_CURR_RATE) |
+		   le32_encode_bits(0, CCTLINFO_G7_W14_VI_CURR_RATE) |
+		   le32_encode_bits(0, CCTLINFO_G7_W14_BE_CURR_RATE_L);
+	h2c->m14 = cpu_to_le32(CCTLINFO_G7_W14_ALL);
+
+	h2c->w15 = le32_encode_bits(0, CCTLINFO_G7_W15_BE_CURR_RATE_H) |
+		   le32_encode_bits(0, CCTLINFO_G7_W15_BK_CURR_RATE) |
+		   le32_encode_bits(0, CCTLINFO_G7_W15_MGNT_CURR_RATE);
+	h2c->m15 = cpu_to_le32(CCTLINFO_G7_W15_ALL);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FR_EXCHG,
+			      H2C_FUNC_MAC_CCTLINFO_UD_G7, 0, 1,
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
+EXPORT_SYMBOL(rtw89_fw_h2c_default_cmac_tbl_g7);
 
 static void __get_sta_he_pkt_padding(struct rtw89_dev *rtwdev,
 				     struct ieee80211_sta *sta, u8 *pads)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index b9159278dd4b..b9e8fb693202 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1260,10 +1260,12 @@ struct rtw89_h2c_cctlinfo_ud_g7 {
 #define CCTLINFO_G7_W0_DISDATAFB BIT(26)
 #define CCTLINFO_G7_W0_NSTR_EN BIT(27)
 #define CCTLINFO_G7_W0_AMPDU_DENSITY GENMASK(31, 28)
+#define CCTLINFO_G7_W0_ALL (GENMASK(31, 20) | GENMASK(18, 0))
 #define CCTLINFO_G7_W1_DATA_RTY_LOWEST_RATE GENMASK(11, 0)
 #define CCTLINFO_G7_W1_RTS_TXCNT_LMT GENMASK(15, 12)
 #define CCTLINFO_G7_W1_RTSRATE GENMASK(27, 16)
 #define CCTLINFO_G7_W1_RTS_RTY_LOWEST_RATE GENMASK(31, 28)
+#define CCTLINFO_G7_W1_ALL GENMASK(31, 0)
 #define CCTLINFO_G7_W2_DATA_TX_CNT_LMT GENMASK(5, 0)
 #define CCTLINFO_G7_W2_DATA_TXCNT_LMT_SEL BIT(6)
 #define CCTLINFO_G7_W2_MAX_AGG_NUM_SEL BIT(7)
@@ -1276,6 +1278,7 @@ struct rtw89_h2c_cctlinfo_ud_g7 {
 #define CCTLINFO_G7_W2_AMPDU_MAX_LEN GENMASK(26, 16)
 #define CCTLINFO_G7_W2_UL_MU_DIS BIT(27)
 #define CCTLINFO_G7_W2_AMPDU_MAX_TIME GENMASK(31, 28)
+#define CCTLINFO_G7_W2_ALL GENMASK(31, 0)
 #define CCTLINFO_G7_W3_MAX_AGG_NUM GENMASK(7, 0)
 #define CCTLINFO_G7_W3_DATA_BW GENMASK(10, 8)
 #define CCTLINFO_G7_W3_DATA_BW_ER BIT(11)
@@ -1289,6 +1292,7 @@ struct rtw89_h2c_cctlinfo_ud_g7 {
 #define CCTLINFO_G7_W3_AMPDU_LEN_SEL BIT(29)
 #define CCTLINFO_G7_W3_RTS_TXCNT_LMT_SEL BIT(30)
 #define CCTLINFO_G7_W3_LSIG_TXOP_EN BIT(31)
+#define CCTLINFO_G7_W3_ALL GENMASK(31, 0)
 #define CCTLINFO_G7_W4_MULTI_PORT_ID GENMASK(2, 0)
 #define CCTLINFO_G7_W4_BYPASS_PUNC BIT(3)
 #define CCTLINFO_G7_W4_MBSSID GENMASK(7, 4)
@@ -1300,6 +1304,7 @@ struct rtw89_h2c_cctlinfo_ud_g7 {
 #define CCTLINFO_G7_W4_A_CTRL_BSR BIT(14)
 #define CCTLINFO_G7_W4_A_CTRL_CAS BIT(15)
 #define CCTLINFO_G7_W4_ACT_SUBCH_CBW GENMASK(31, 16)
+#define CCTLINFO_G7_W4_ALL (GENMASK(31, 14) | GENMASK(12, 0))
 #define CCTLINFO_G7_W5_NOMINAL_PKT_PADDING0 GENMASK(1, 0)
 #define CCTLINFO_G7_W5_NOMINAL_PKT_PADDING1 GENMASK(3, 2)
 #define CCTLINFO_G7_W5_NOMINAL_PKT_PADDING2 GENMASK(5, 4)
@@ -1308,9 +1313,11 @@ struct rtw89_h2c_cctlinfo_ud_g7 {
 #define CCTLINFO_G7_W5_SR_RATE GENMASK(14, 10)
 #define CCTLINFO_G7_W5_TID_DISABLE GENMASK(23, 16)
 #define CCTLINFO_G7_W5_ADDR_CAM_INDEX GENMASK(31, 24)
+#define CCTLINFO_G7_W5_ALL (GENMASK(31, 16) | GENMASK(14, 0))
 #define CCTLINFO_G7_W6_AID12_PAID GENMASK(11, 0)
 #define CCTLINFO_G7_W6_RESP_REF_RATE GENMASK(23, 12)
 #define CCTLINFO_G7_W6_ULDL BIT(31)
+#define CCTLINFO_G7_W6_ALL (BIT(31) | GENMASK(23, 0))
 #define CCTLINFO_G7_W7_NC GENMASK(2, 0)
 #define CCTLINFO_G7_W7_NR GENMASK(5, 3)
 #define CCTLINFO_G7_W7_NG GENMASK(7, 6)
@@ -1321,6 +1328,7 @@ struct rtw89_h2c_cctlinfo_ud_g7 {
 #define CCTLINFO_G7_W7_CSI_PARA_EN BIT(15)
 #define CCTLINFO_G7_W7_CSI_FIX_RATE GENMASK(27, 16)
 #define CCTLINFO_G7_W7_CSI_BW GENMASK(31, 29)
+#define CCTLINFO_G7_W7_ALL (GENMASK(31, 29) | GENMASK(27, 13) | GENMASK(11, 0))
 #define CCTLINFO_G7_W8_ALL_ACK_SUPPORT BIT(0)
 #define CCTLINFO_G7_W8_BSR_QUEUE_SIZE_FORMAT BIT(1)
 #define CCTLINFO_G7_W8_BSR_OM_UPD_EN BIT(2)
@@ -1331,13 +1339,16 @@ struct rtw89_h2c_cctlinfo_ud_g7 {
 #define CCTLINFO_G7_W8_CTRL_CNT_VLD BIT(7)
 #define CCTLINFO_G7_W8_CTRL_CNT GENMASK(11, 8)
 #define CCTLINFO_G7_W8_RESP_SEC_TYPE GENMASK(15, 12)
+#define CCTLINFO_G7_W8_ALL GENMASK(15, 0)
 /* W9~13 are reserved */
 #define CCTLINFO_G7_W14_VO_CURR_RATE GENMASK(11, 0)
 #define CCTLINFO_G7_W14_VI_CURR_RATE GENMASK(23, 12)
 #define CCTLINFO_G7_W14_BE_CURR_RATE_L GENMASK(31, 24)
+#define CCTLINFO_G7_W14_ALL GENMASK(31, 0)
 #define CCTLINFO_G7_W15_BE_CURR_RATE_H GENMASK(3, 0)
 #define CCTLINFO_G7_W15_BK_CURR_RATE GENMASK(15, 4)
 #define CCTLINFO_G7_W15_MGNT_CURR_RATE GENMASK(27, 16)
+#define CCTLINFO_G7_W15_ALL GENMASK(27, 0)
 
 static inline void SET_DCTL_MACID_V1(void *table, u32 val)
 {
@@ -3939,7 +3950,11 @@ void rtw89_h2c_pkt_set_hdr(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			   u8 type, u8 cat, u8 class, u8 func,
 			   bool rack, bool dack, u32 len);
 int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
-				  struct rtw89_vif *rtwvif);
+				  struct rtw89_vif *rtwvif,
+				  struct rtw89_sta *rtwsta);
+int rtw89_fw_h2c_default_cmac_tbl_g7(struct rtw89_dev *rtwdev,
+				     struct rtw89_vif *rtwvif,
+				     struct rtw89_sta *rtwsta);
 int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 				struct ieee80211_vif *vif,
 				struct ieee80211_sta *sta);
@@ -4089,6 +4104,15 @@ static inline void rtw89_fw_h2c_init_ba_cam(struct rtw89_dev *rtwdev)
 		rtw89_fw_h2c_init_dynamic_ba_cam_v0_ext(rtwdev);
 }
 
+static inline int rtw89_chip_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
+						  struct rtw89_vif *rtwvif,
+						  struct rtw89_sta *rtwsta)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	return chip->ops->h2c_default_cmac_tbl(rtwdev, rtwvif, rtwsta);
+}
+
 static inline int rtw89_chip_h2c_update_beacon(struct rtw89_dev *rtwdev,
 					       struct rtw89_vif *rtwvif)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 0d5f91d4adee..cee1e512d264 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4497,7 +4497,7 @@ int rtw89_mac_vif_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	if (ret)
 		return ret;
 
-	ret = rtw89_fw_h2c_default_cmac_tbl(rtwdev, rtwvif);
+	ret = rtw89_chip_h2c_default_cmac_tbl(rtwdev, rtwvif, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index ed9d47ff6d97..32b986165e2f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2334,6 +2334,7 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx,
 	.h2c_dctl_sec_cam	= NULL,
+	.h2c_default_cmac_tbl	= rtw89_fw_h2c_default_cmac_tbl,
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
 	.h2c_ampdu_cmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index df6299800ba1..cfb2432dca35 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2078,6 +2078,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx,
 	.h2c_dctl_sec_cam	= NULL,
+	.h2c_default_cmac_tbl	= rtw89_fw_h2c_default_cmac_tbl,
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
 	.h2c_ampdu_cmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 0ace2accb663..93728efee696 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2503,6 +2503,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx,
 	.h2c_dctl_sec_cam	= NULL,
+	.h2c_default_cmac_tbl	= rtw89_fw_h2c_default_cmac_tbl,
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
 	.h2c_ampdu_cmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 124b5e38f13e..a0c1901e5a26 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2848,6 +2848,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx_v1,
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx_v1,
 	.h2c_dctl_sec_cam	= rtw89_fw_h2c_dctl_sec_cam_v1,
+	.h2c_default_cmac_tbl	= rtw89_fw_h2c_default_cmac_tbl,
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
 	.h2c_ampdu_cmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index ff166654d9b0..cb385a9b061f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -823,6 +823,7 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.pwr_on_func		= rtw8922a_pwr_on_func,
 	.pwr_off_func		= rtw8922a_pwr_off_func,
 	.h2c_dctl_sec_cam	= rtw89_fw_h2c_dctl_sec_cam_v2,
+	.h2c_default_cmac_tbl	= rtw89_fw_h2c_default_cmac_tbl_g7,
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl_g7,
 	.h2c_ampdu_cmac_tbl	= rtw89_fw_h2c_ampdu_cmac_tbl_g7,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon_be,
-- 
2.25.1


