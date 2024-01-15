Return-Path: <linux-wireless+bounces-1907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8955682D366
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 04:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960F828159B
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 03:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22E21872;
	Mon, 15 Jan 2024 03:38:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BD61842
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 03:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40F3cAHW13528784, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40F3cAHW13528784
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 11:38:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Mon, 15 Jan 2024 11:38:10 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 15 Jan
 2024 11:38:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/8] wifi: rtw89: fw: fill CMAC table to associated station for WiFi 7 chips
Date: Mon, 15 Jan 2024 11:37:36 +0800
Message-ID: <20240115033742.16372-3-pkshih@realtek.com>
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

When a station get connected, fill hardware CMAC table via H2C command to
tell hardware arguments related to transmit, such as the lowest rate,
packet padding and so on.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |   2 +-
 drivers/net/wireless/realtek/rtw89/fw.c       | 175 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h       | 136 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   1 +
 4 files changed, 309 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 73694aca1108..88ae5cc85877 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -879,7 +879,7 @@ enum rtw89_ps_mode {
 #define RTW89_5G_BW_NUM (RTW89_CHANNEL_WIDTH_160 + 1)
 #define RTW89_6G_BW_NUM (RTW89_CHANNEL_WIDTH_320 + 1)
 #define RTW89_BYR_BW_NUM (RTW89_CHANNEL_WIDTH_320 + 1)
-#define RTW89_PPE_BW_NUM (RTW89_CHANNEL_WIDTH_160 + 1)
+#define RTW89_PPE_BW_NUM (RTW89_CHANNEL_WIDTH_320 + 1)
 
 enum rtw89_ru_bandwidth {
 	RTW89_RU26 = 0,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index bc4c09939160..7c33b10a39be 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2111,9 +2111,6 @@ static void __get_sta_he_pkt_padding(struct rtw89_dev *rtwdev,
 	u16 ppe;
 	int i;
 
-	if (!sta->deflink.he_cap.has_he)
-		return;
-
 	ppe_th = FIELD_GET(IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT,
 			   sta->deflink.he_cap.he_cap_elem.phy_cap_info[6]);
 	if (!ppe_th) {
@@ -2172,7 +2169,7 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 	int ret;
 
 	memset(pads, 0, sizeof(pads));
-	if (sta)
+	if (sta && sta->deflink.he_cap.has_he)
 		__get_sta_he_pkt_padding(rtwdev, sta, pads);
 
 	if (vif->p2p)
@@ -2235,6 +2232,176 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+static void __get_sta_eht_pkt_padding(struct rtw89_dev *rtwdev,
+				      struct ieee80211_sta *sta, u8 *pads)
+{
+	u8 nss = min(sta->deflink.rx_nss, rtwdev->hal.tx_nss) - 1;
+	u16 ppe_thres_hdr;
+	u8 ppe16, ppe8;
+	u8 n, idx, sh;
+	u8 ru_bitmap;
+	bool ppe_th;
+	u16 ppe;
+	int i;
+
+	ppe_th = !!u8_get_bits(sta->deflink.eht_cap.eht_cap_elem.phy_cap_info[5],
+			       IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT);
+	if (!ppe_th) {
+		u8 pad;
+
+		pad = u8_get_bits(sta->deflink.eht_cap.eht_cap_elem.phy_cap_info[5],
+				  IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_MASK);
+
+		for (i = 0; i < RTW89_PPE_BW_NUM; i++)
+			pads[i] = pad;
+
+		return;
+	}
+
+	ppe_thres_hdr = get_unaligned_le16(sta->deflink.eht_cap.eht_ppe_thres);
+	ru_bitmap = u16_get_bits(ppe_thres_hdr,
+				 IEEE80211_EHT_PPE_THRES_RU_INDEX_BITMASK_MASK);
+	n = hweight8(ru_bitmap);
+	n = IEEE80211_EHT_PPE_THRES_INFO_HEADER_SIZE +
+	    (n * IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE * 2) * nss;
+
+	for (i = 0; i < RTW89_PPE_BW_NUM; i++) {
+		if (!(ru_bitmap & BIT(i))) {
+			pads[i] = 1;
+			continue;
+		}
+
+		idx = n >> 3;
+		sh = n & 7;
+		n += IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE * 2;
+
+		ppe = get_unaligned_le16(sta->deflink.eht_cap.eht_ppe_thres + idx);
+		ppe16 = (ppe >> sh) & IEEE80211_PPE_THRES_NSS_MASK;
+		sh += IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE;
+		ppe8 = (ppe >> sh) & IEEE80211_PPE_THRES_NSS_MASK;
+
+		if (ppe16 != 7 && ppe8 == 7)
+			pads[i] = 2;
+		else if (ppe8 != 7)
+			pads[i] = 1;
+		else
+			pads[i] = 0;
+	}
+}
+
+int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_sta *sta)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
+	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
+	struct rtw89_h2c_cctlinfo_ud_g7 *h2c;
+	u8 pads[RTW89_PPE_BW_NUM];
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	u16 lowest_rate;
+	int ret;
+
+	memset(pads, 0, sizeof(pads));
+	if (sta) {
+		if (sta->deflink.eht_cap.has_eht)
+			__get_sta_eht_pkt_padding(rtwdev, sta, pads);
+		else if (sta->deflink.he_cap.has_he)
+			__get_sta_he_pkt_padding(rtwdev, sta, pads);
+	}
+
+	if (vif->p2p)
+		lowest_rate = RTW89_HW_RATE_OFDM6;
+	else if (chan->band_type == RTW89_BAND_2G)
+		lowest_rate = RTW89_HW_RATE_CCK1;
+	else
+		lowest_rate = RTW89_HW_RATE_OFDM6;
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
+	h2c->w0 = le32_encode_bits(1, CCTLINFO_G7_W0_DISRTSFB) |
+		  le32_encode_bits(1, CCTLINFO_G7_W0_DISDATAFB);
+	h2c->m0 = cpu_to_le32(CCTLINFO_G7_W0_DISRTSFB |
+			      CCTLINFO_G7_W0_DISDATAFB);
+
+	h2c->w1 = le32_encode_bits(lowest_rate, CCTLINFO_G7_W1_RTS_RTY_LOWEST_RATE);
+	h2c->m1 = cpu_to_le32(CCTLINFO_G7_W1_RTS_RTY_LOWEST_RATE);
+
+	h2c->w2 = le32_encode_bits(0, CCTLINFO_G7_W2_DATA_TXCNT_LMT_SEL);
+	h2c->m2 = cpu_to_le32(CCTLINFO_G7_W2_DATA_TXCNT_LMT_SEL);
+
+	h2c->w3 = le32_encode_bits(0, CCTLINFO_G7_W3_RTS_TXCNT_LMT_SEL);
+	h2c->m3 = cpu_to_le32(CCTLINFO_G7_W3_RTS_TXCNT_LMT_SEL);
+
+	h2c->w4 = le32_encode_bits(rtwvif->port, CCTLINFO_G7_W4_MULTI_PORT_ID);
+	h2c->m4 = cpu_to_le32(CCTLINFO_G7_W4_MULTI_PORT_ID);
+
+	if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE) {
+		h2c->w4 |= le32_encode_bits(0, CCTLINFO_G7_W4_DATA_DCM);
+		h2c->m4 |= cpu_to_le32(CCTLINFO_G7_W4_DATA_DCM);
+	}
+
+	if (vif->bss_conf.eht_support) {
+		h2c->w4 |= le32_encode_bits(~vif->bss_conf.eht_puncturing,
+					    CCTLINFO_G7_W4_ACT_SUBCH_CBW);
+		h2c->m4 |= cpu_to_le32(CCTLINFO_G7_W4_ACT_SUBCH_CBW);
+	}
+
+	h2c->w5 = le32_encode_bits(pads[RTW89_CHANNEL_WIDTH_20],
+				   CCTLINFO_G7_W5_NOMINAL_PKT_PADDING0) |
+		  le32_encode_bits(pads[RTW89_CHANNEL_WIDTH_40],
+				   CCTLINFO_G7_W5_NOMINAL_PKT_PADDING1) |
+		  le32_encode_bits(pads[RTW89_CHANNEL_WIDTH_80],
+				   CCTLINFO_G7_W5_NOMINAL_PKT_PADDING2) |
+		  le32_encode_bits(pads[RTW89_CHANNEL_WIDTH_160],
+				   CCTLINFO_G7_W5_NOMINAL_PKT_PADDING3) |
+		  le32_encode_bits(pads[RTW89_CHANNEL_WIDTH_320],
+				   CCTLINFO_G7_W5_NOMINAL_PKT_PADDING4);
+	h2c->m5 = cpu_to_le32(CCTLINFO_G7_W5_NOMINAL_PKT_PADDING0 |
+			      CCTLINFO_G7_W5_NOMINAL_PKT_PADDING1 |
+			      CCTLINFO_G7_W5_NOMINAL_PKT_PADDING2 |
+			      CCTLINFO_G7_W5_NOMINAL_PKT_PADDING3 |
+			      CCTLINFO_G7_W5_NOMINAL_PKT_PADDING4);
+
+	h2c->w6 = le32_encode_bits(vif->type == NL80211_IFTYPE_STATION ? 1 : 0,
+				   CCTLINFO_G7_W6_ULDL);
+	h2c->m6 = cpu_to_le32(CCTLINFO_G7_W6_ULDL);
+
+	if (sta) {
+		h2c->w8 = le32_encode_bits(sta->deflink.he_cap.has_he,
+					   CCTLINFO_G7_W8_BSR_QUEUE_SIZE_FORMAT);
+		h2c->m8 = cpu_to_le32(CCTLINFO_G7_W8_BSR_QUEUE_SIZE_FORMAT);
+	}
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
+
 int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta *rtwsta)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 7ff04472fbdc..dad09e57b821 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1207,6 +1207,138 @@ static inline void SET_CMC_TBL_CSI_BW(void *table, u32 val)
 			   GENMASK(31, 30));
 }
 
+struct rtw89_h2c_cctlinfo_ud_g7 {
+	__le32 c0;
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 w3;
+	__le32 w4;
+	__le32 w5;
+	__le32 w6;
+	__le32 w7;
+	__le32 w8;
+	__le32 w9;
+	__le32 w10;
+	__le32 w11;
+	__le32 w12;
+	__le32 w13;
+	__le32 w14;
+	__le32 w15;
+	__le32 m0;
+	__le32 m1;
+	__le32 m2;
+	__le32 m3;
+	__le32 m4;
+	__le32 m5;
+	__le32 m6;
+	__le32 m7;
+	__le32 m8;
+	__le32 m9;
+	__le32 m10;
+	__le32 m11;
+	__le32 m12;
+	__le32 m13;
+	__le32 m14;
+	__le32 m15;
+} __packed;
+
+#define CCTLINFO_G7_C0_MACID GENMASK(6, 0)
+#define CCTLINFO_G7_C0_OP BIT(7)
+
+#define CCTLINFO_G7_W0_DATARATE GENMASK(11, 0)
+#define CCTLINFO_G7_W0_DATA_GI_LTF GENMASK(14, 12)
+#define CCTLINFO_G7_W0_TRYRATE BIT(15)
+#define CCTLINFO_G7_W0_ARFR_CTRL GENMASK(17, 16)
+#define CCTLINFO_G7_W0_DIS_HE1SS_STBC BIT(18)
+#define CCTLINFO_G7_W0_ACQ_RPT_EN BIT(20)
+#define CCTLINFO_G7_W0_MGQ_RPT_EN BIT(21)
+#define CCTLINFO_G7_W0_ULQ_RPT_EN BIT(22)
+#define CCTLINFO_G7_W0_TWTQ_RPT_EN BIT(23)
+#define CCTLINFO_G7_W0_FORCE_TXOP BIT(24)
+#define CCTLINFO_G7_W0_DISRTSFB BIT(25)
+#define CCTLINFO_G7_W0_DISDATAFB BIT(26)
+#define CCTLINFO_G7_W0_NSTR_EN BIT(27)
+#define CCTLINFO_G7_W0_AMPDU_DENSITY GENMASK(31, 28)
+#define CCTLINFO_G7_W1_DATA_RTY_LOWEST_RATE GENMASK(11, 0)
+#define CCTLINFO_G7_W1_RTS_TXCNT_LMT GENMASK(15, 12)
+#define CCTLINFO_G7_W1_RTSRATE GENMASK(27, 16)
+#define CCTLINFO_G7_W1_RTS_RTY_LOWEST_RATE GENMASK(31, 28)
+#define CCTLINFO_G7_W2_DATA_TX_CNT_LMT GENMASK(5, 0)
+#define CCTLINFO_G7_W2_DATA_TXCNT_LMT_SEL BIT(6)
+#define CCTLINFO_G7_W2_MAX_AGG_NUM_SEL BIT(7)
+#define CCTLINFO_G7_W2_RTS_EN BIT(8)
+#define CCTLINFO_G7_W2_CTS2SELF_EN BIT(9)
+#define CCTLINFO_G7_W2_CCA_RTS GENMASK(11, 10)
+#define CCTLINFO_G7_W2_HW_RTS_EN BIT(12)
+#define CCTLINFO_G7_W2_RTS_DROP_DATA_MODE GENMASK(14, 13)
+#define CCTLINFO_G7_W2_PRELD_EN BIT(15)
+#define CCTLINFO_G7_W2_AMPDU_MAX_LEN GENMASK(26, 16)
+#define CCTLINFO_G7_W2_UL_MU_DIS BIT(27)
+#define CCTLINFO_G7_W2_AMPDU_MAX_TIME GENMASK(31, 28)
+#define CCTLINFO_G7_W3_MAX_AGG_NUM GENMASK(7, 0)
+#define CCTLINFO_G7_W3_DATA_BW GENMASK(10, 8)
+#define CCTLINFO_G7_W3_DATA_BW_ER BIT(11)
+#define CCTLINFO_G7_W3_BA_BMAP GENMASK(14, 12)
+#define CCTLINFO_G7_W3_VCS_STBC BIT(15)
+#define CCTLINFO_G7_W3_VO_LFTIME_SEL GENMASK(18, 16)
+#define CCTLINFO_G7_W3_VI_LFTIME_SEL GENMASK(21, 19)
+#define CCTLINFO_G7_W3_BE_LFTIME_SEL GENMASK(24, 22)
+#define CCTLINFO_G7_W3_BK_LFTIME_SEL GENMASK(27, 25)
+#define CCTLINFO_G7_W3_AMPDU_TIME_SEL BIT(28)
+#define CCTLINFO_G7_W3_AMPDU_LEN_SEL BIT(29)
+#define CCTLINFO_G7_W3_RTS_TXCNT_LMT_SEL BIT(30)
+#define CCTLINFO_G7_W3_LSIG_TXOP_EN BIT(31)
+#define CCTLINFO_G7_W4_MULTI_PORT_ID GENMASK(2, 0)
+#define CCTLINFO_G7_W4_BYPASS_PUNC BIT(3)
+#define CCTLINFO_G7_W4_MBSSID GENMASK(7, 4)
+#define CCTLINFO_G7_W4_DATA_DCM BIT(8)
+#define CCTLINFO_G7_W4_DATA_ER BIT(9)
+#define CCTLINFO_G7_W4_DATA_LDPC BIT(10)
+#define CCTLINFO_G7_W4_DATA_STBC BIT(11)
+#define CCTLINFO_G7_W4_A_CTRL_BQR BIT(12)
+#define CCTLINFO_G7_W4_A_CTRL_BSR BIT(14)
+#define CCTLINFO_G7_W4_A_CTRL_CAS BIT(15)
+#define CCTLINFO_G7_W4_ACT_SUBCH_CBW GENMASK(31, 16)
+#define CCTLINFO_G7_W5_NOMINAL_PKT_PADDING0 GENMASK(1, 0)
+#define CCTLINFO_G7_W5_NOMINAL_PKT_PADDING1 GENMASK(3, 2)
+#define CCTLINFO_G7_W5_NOMINAL_PKT_PADDING2 GENMASK(5, 4)
+#define CCTLINFO_G7_W5_NOMINAL_PKT_PADDING3 GENMASK(7, 6)
+#define CCTLINFO_G7_W5_NOMINAL_PKT_PADDING4 GENMASK(9, 8)
+#define CCTLINFO_G7_W5_SR_RATE GENMASK(14, 10)
+#define CCTLINFO_G7_W5_TID_DISABLE GENMASK(23, 16)
+#define CCTLINFO_G7_W5_ADDR_CAM_INDEX GENMASK(31, 24)
+#define CCTLINFO_G7_W6_AID12_PAID GENMASK(11, 0)
+#define CCTLINFO_G7_W6_RESP_REF_RATE GENMASK(23, 12)
+#define CCTLINFO_G7_W6_ULDL BIT(31)
+#define CCTLINFO_G7_W7_NC GENMASK(2, 0)
+#define CCTLINFO_G7_W7_NR GENMASK(5, 3)
+#define CCTLINFO_G7_W7_NG GENMASK(7, 6)
+#define CCTLINFO_G7_W7_CB GENMASK(9, 8)
+#define CCTLINFO_G7_W7_CS GENMASK(11, 10)
+#define CCTLINFO_G7_W7_CSI_STBC_EN BIT(13)
+#define CCTLINFO_G7_W7_CSI_LDPC_EN BIT(14)
+#define CCTLINFO_G7_W7_CSI_PARA_EN BIT(15)
+#define CCTLINFO_G7_W7_CSI_FIX_RATE GENMASK(27, 16)
+#define CCTLINFO_G7_W7_CSI_BW GENMASK(31, 29)
+#define CCTLINFO_G7_W8_ALL_ACK_SUPPORT BIT(0)
+#define CCTLINFO_G7_W8_BSR_QUEUE_SIZE_FORMAT BIT(1)
+#define CCTLINFO_G7_W8_BSR_OM_UPD_EN BIT(2)
+#define CCTLINFO_G7_W8_MACID_FWD_IDC BIT(3)
+#define CCTLINFO_G7_W8_AZ_SEC_EN BIT(4)
+#define CCTLINFO_G7_W8_CSI_SEC_EN BIT(5)
+#define CCTLINFO_G7_W8_FIX_UL_ADDRCAM_IDX BIT(6)
+#define CCTLINFO_G7_W8_CTRL_CNT_VLD BIT(7)
+#define CCTLINFO_G7_W8_CTRL_CNT GENMASK(11, 8)
+#define CCTLINFO_G7_W8_RESP_SEC_TYPE GENMASK(15, 12)
+/* W9~13 are reserved */
+#define CCTLINFO_G7_W14_VO_CURR_RATE GENMASK(11, 0)
+#define CCTLINFO_G7_W14_VI_CURR_RATE GENMASK(23, 12)
+#define CCTLINFO_G7_W14_BE_CURR_RATE_L GENMASK(31, 24)
+#define CCTLINFO_G7_W15_BE_CURR_RATE_H GENMASK(3, 0)
+#define CCTLINFO_G7_W15_BK_CURR_RATE GENMASK(15, 4)
+#define CCTLINFO_G7_W15_MGNT_CURR_RATE GENMASK(27, 16)
+
 static inline void SET_DCTL_MACID_V1(void *table, u32 val)
 {
 	le32p_replace_bits((__le32 *)(table) + 0, val, GENMASK(6, 0));
@@ -3620,6 +3752,7 @@ struct rtw89_fw_h2c_rf_reg_info {
 #define H2C_FUNC_MAC_CCTLINFO_UD_V1	0xa
 #define H2C_FUNC_MAC_DCTLINFO_UD_V2	0xc
 #define H2C_FUNC_MAC_BCN_UPD_BE		0xd
+#define H2C_FUNC_MAC_CCTLINFO_UD_G7	0x11
 
 /* CLASS 6 - Address CAM */
 #define H2C_CL_MAC_ADDR_CAM_UPDATE	0x6
@@ -3810,6 +3943,9 @@ int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 				struct ieee80211_vif *vif,
 				struct ieee80211_sta *sta);
+int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_sta *sta);
 int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta *rtwsta);
 int rtw89_fw_h2c_txpath_cmac_tbl(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 806ab51caed6..15809cb5c03c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -895,6 +895,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 				  BIT(RTW89_PS_MODE_CLK_GATED) |
 				  BIT(RTW89_PS_MODE_PWR_GATED),
 	.low_power_hci_modes	= 0,
+	.h2c_cctl_func_id	= H2C_FUNC_MAC_CCTLINFO_UD_G7,
 	.hci_func_en_addr	= R_BE_HCI_FUNC_EN,
 	.h2c_desc_size		= sizeof(struct rtw89_rxdesc_short_v2),
 	.txwd_body_size		= sizeof(struct rtw89_txwd_body_v2),
-- 
2.25.1


