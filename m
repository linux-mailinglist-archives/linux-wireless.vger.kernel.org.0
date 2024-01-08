Return-Path: <linux-wireless+bounces-1583-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FDE826A69
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 10:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 651E1B22578
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 09:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6222C13AC7;
	Mon,  8 Jan 2024 09:13:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB2613AEC
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4089DdMS23873421, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4089DdMS23873421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jan 2024 17:13:39 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 8 Jan 2024 17:13:39 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 Jan 2024
 17:13:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 09/10] wifi: rtw89: add H2C command to download beacon frame for WiFi 7 chips
Date: Mon, 8 Jan 2024 17:13:33 +0800
Message-ID: <20240108091333.67484-1-pkshih@realtek.com>
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

The firmware of coming WiFi 7 chips can support more AP functions, like
virtual AP, so extend format of download beacon frame to configure them.
Currently rtw89 only enables AP mode as old chips, so leave new fields
zeros.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 82 +++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h | 51 +++++++++++++++
 2 files changed, 133 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 89eda20c20cb..42214af0e15a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2356,6 +2356,88 @@ int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+int rtw89_fw_h2c_update_beacon_be(struct rtw89_dev *rtwdev,
+				  struct rtw89_vif *rtwvif)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct rtw89_h2c_bcn_upd_be *h2c;
+	struct sk_buff *skb_beacon;
+	struct ieee80211_hdr *hdr;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int bcn_total_len;
+	u16 beacon_rate;
+	u16 tim_offset;
+	void *noa_data;
+	u8 noa_len;
+	int ret;
+
+	if (vif->p2p)
+		beacon_rate = RTW89_HW_RATE_OFDM6;
+	else if (chan->band_type == RTW89_BAND_2G)
+		beacon_rate = RTW89_HW_RATE_CCK1;
+	else
+		beacon_rate = RTW89_HW_RATE_OFDM6;
+
+	skb_beacon = ieee80211_beacon_get_tim(rtwdev->hw, vif, &tim_offset,
+					      NULL, 0);
+	if (!skb_beacon) {
+		rtw89_err(rtwdev, "failed to get beacon skb\n");
+		return -ENOMEM;
+	}
+
+	noa_len = rtw89_p2p_noa_fetch(rtwvif, &noa_data);
+	if (noa_len &&
+	    (noa_len <= skb_tailroom(skb_beacon) ||
+	     pskb_expand_head(skb_beacon, 0, noa_len, GFP_KERNEL) == 0)) {
+		skb_put_data(skb_beacon, noa_data, noa_len);
+	}
+
+	hdr = (struct ieee80211_hdr *)skb_beacon;
+	tim_offset -= ieee80211_hdrlen(hdr->frame_control);
+
+	bcn_total_len = len + skb_beacon->len;
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, bcn_total_len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for fw dl\n");
+		dev_kfree_skb_any(skb_beacon);
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_bcn_upd_be *)skb->data;
+
+	h2c->w0 = le32_encode_bits(rtwvif->port, RTW89_H2C_BCN_UPD_BE_W0_PORT) |
+		  le32_encode_bits(0, RTW89_H2C_BCN_UPD_BE_W0_MBSSID) |
+		  le32_encode_bits(rtwvif->mac_idx, RTW89_H2C_BCN_UPD_BE_W0_BAND) |
+		  le32_encode_bits(tim_offset | BIT(7), RTW89_H2C_BCN_UPD_BE_W0_GRP_IE_OFST);
+	h2c->w1 = le32_encode_bits(rtwvif->mac_id, RTW89_H2C_BCN_UPD_BE_W1_MACID) |
+		  le32_encode_bits(RTW89_MGMT_HW_SSN_SEL, RTW89_H2C_BCN_UPD_BE_W1_SSN_SEL) |
+		  le32_encode_bits(RTW89_MGMT_HW_SEQ_MODE, RTW89_H2C_BCN_UPD_BE_W1_SSN_MODE) |
+		  le32_encode_bits(beacon_rate, RTW89_H2C_BCN_UPD_BE_W1_RATE);
+
+	skb_put_data(skb, skb_beacon->data, skb_beacon->len);
+	dev_kfree_skb_any(skb_beacon);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FR_EXCHG,
+			      H2C_FUNC_MAC_BCN_UPD_BE, 0, 1,
+			      bcn_total_len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
 #define H2C_ROLE_MAINTAIN_LEN 4
 int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
 			       struct rtw89_vif *rtwvif,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 9424b4add222..dc1c805f1500 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1536,6 +1536,54 @@ struct rtw89_h2c_bcn_upd {
 #define RTW89_H2C_BCN_UPD_W2_PATH_ANTSEL_D BIT(16)
 #define RTW89_H2C_BCN_UPD_W2_CSA_OFST GENMASK(31, 17)
 
+struct rtw89_h2c_bcn_upd_be {
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
+} __packed;
+
+#define RTW89_H2C_BCN_UPD_BE_W0_PORT GENMASK(7, 0)
+#define RTW89_H2C_BCN_UPD_BE_W0_MBSSID GENMASK(15, 8)
+#define RTW89_H2C_BCN_UPD_BE_W0_BAND GENMASK(23, 16)
+#define RTW89_H2C_BCN_UPD_BE_W0_GRP_IE_OFST GENMASK(31, 24)
+#define RTW89_H2C_BCN_UPD_BE_W1_MACID GENMASK(7, 0)
+#define RTW89_H2C_BCN_UPD_BE_W1_SSN_SEL GENMASK(9, 8)
+#define RTW89_H2C_BCN_UPD_BE_W1_SSN_MODE GENMASK(11, 10)
+#define RTW89_H2C_BCN_UPD_BE_W1_RATE GENMASK(20, 12)
+#define RTW89_H2C_BCN_UPD_BE_W1_TXPWR GENMASK(23, 21)
+#define RTW89_H2C_BCN_UPD_BE_W1_MACID_EXT GENMASK(31, 24)
+#define RTW89_H2C_BCN_UPD_BE_W2_TXINFO_CTRL_EN BIT(0)
+#define RTW89_H2C_BCN_UPD_BE_W2_NTX_PATH_EN GENMASK(4, 1)
+#define RTW89_H2C_BCN_UPD_BE_W2_PATH_MAP_A GENMASK(6, 5)
+#define RTW89_H2C_BCN_UPD_BE_W2_PATH_MAP_B GENMASK(8, 7)
+#define RTW89_H2C_BCN_UPD_BE_W2_PATH_MAP_C GENMASK(10, 9)
+#define RTW89_H2C_BCN_UPD_BE_W2_PATH_MAP_D GENMASK(12, 11)
+#define RTW89_H2C_BCN_UPD_BE_W2_ANTSEL_A BIT(13)
+#define RTW89_H2C_BCN_UPD_BE_W2_ANTSEL_B BIT(14)
+#define RTW89_H2C_BCN_UPD_BE_W2_ANTSEL_C BIT(15)
+#define RTW89_H2C_BCN_UPD_BE_W2_ANTSEL_D BIT(16)
+#define RTW89_H2C_BCN_UPD_BE_W2_CSA_OFST GENMASK(31, 17)
+#define RTW89_H2C_BCN_UPD_BE_W3_MLIE_CSA_OFST GENMASK(15, 0)
+#define RTW89_H2C_BCN_UPD_BE_W3_CRITICAL_UPD_FLAG_OFST GENMASK(31, 16)
+#define RTW89_H2C_BCN_UPD_BE_W4_VAP1_DTIM_CNT_OFST GENMASK(15, 0)
+#define RTW89_H2C_BCN_UPD_BE_W4_VAP2_DTIM_CNT_OFST GENMASK(31, 16)
+#define RTW89_H2C_BCN_UPD_BE_W5_VAP3_DTIM_CNT_OFST GENMASK(15, 0)
+#define RTW89_H2C_BCN_UPD_BE_W5_VAP4_DTIM_CNT_OFST GENMASK(31, 16)
+#define RTW89_H2C_BCN_UPD_BE_W6_VAP5_DTIM_CNT_OFST GENMASK(15, 0)
+#define RTW89_H2C_BCN_UPD_BE_W6_VAP6_DTIM_CNT_OFST GENMASK(31, 16)
+#define RTW89_H2C_BCN_UPD_BE_W7_VAP7_DTIM_CNT_OFST GENMASK(15, 0)
+#define RTW89_H2C_BCN_UPD_BE_W7_ECSA_OFST GENMASK(30, 16)
+#define RTW89_H2C_BCN_UPD_BE_W7_PROTECTION_KEY_ID BIT(31)
+
 static inline void SET_FWROLE_MAINTAIN_MACID(void *h2c, u32 val)
 {
 	le32p_replace_bits((__le32 *)h2c, val, GENMASK(7, 0));
@@ -3570,6 +3618,7 @@ struct rtw89_fw_h2c_rf_reg_info {
 #define H2C_FUNC_MAC_BCN_UPD		0x5
 #define H2C_FUNC_MAC_DCTLINFO_UD_V1	0x9
 #define H2C_FUNC_MAC_CCTLINFO_UD_V1	0xa
+#define H2C_FUNC_MAC_BCN_UPD_BE		0xd
 
 /* CLASS 6 - Address CAM */
 #define H2C_CL_MAC_ADDR_CAM_UPDATE	0x6
@@ -3766,6 +3815,8 @@ int rtw89_fw_h2c_txpath_cmac_tbl(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta *rtwsta);
 int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 			       struct rtw89_vif *rtwvif);
+int rtw89_fw_h2c_update_beacon_be(struct rtw89_dev *rtwdev,
+				  struct rtw89_vif *rtwvif);
 int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *vif,
 		     struct rtw89_sta *rtwsta, const u8 *scan_mac_addr);
 int rtw89_fw_h2c_dctl_sec_cam_v1(struct rtw89_dev *rtwdev,
-- 
2.25.1


