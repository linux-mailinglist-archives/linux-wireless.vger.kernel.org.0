Return-Path: <linux-wireless+bounces-6843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B97A8B2037
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 13:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D4A1F245CF
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 11:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451CB12AACD;
	Thu, 25 Apr 2024 11:29:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327EC12A16C
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714044571; cv=none; b=bLHL7X+MBntOCR/TammGpcnMJRTTAhV18JM6OiQsTXdeFPdf6aRF9+OSsrz05PAPP96Y4TPX+hOtYnRwfPrQnH25f03ocCWq8GuM9dQ01WkbuQceSeKJMzv93jk0FP8tPh9MQ6VLDJYKWn0qlGwyeYoX6TwYiPmuGZvQLR8g6tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714044571; c=relaxed/simple;
	bh=bPsHjCcfbGY5+REzSB6OQMOZLPvc7KpafFm7sLt0IIY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAZm7joNd9Z9CrYPssRdq5Xw9N+s+eib0afqH5/49F6kBxqrWKuEKg8Su7L01ZKUntSyH101Fqw5pNFrsBQ8rGylFVu4kVXCsD2OtNDvOk04NU61rS59nWVT0lZeMYAftgJR4YqECJk6jJzqkEAKcoj9jmUNvzwwV4L+xXvSrhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43PBTRAl83482370, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43PBTRAl83482370
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 19:29:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 19:29:27 +0800
Received: from [127.0.1.1] (172.16.16.129) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 25 Apr
 2024 19:29:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>
Subject: [PATCH 10/12] wifi: rtw89: wow: support 802.11w PMF IGTK rekey
Date: Thu, 25 Apr 2024 19:28:14 +0800
Message-ID: <20240425112816.26431-11-pkshih@realtek.com>
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

Once we connect to AP with 802.11w enabled, IGTK rekey happen during GTK
happen. We get IGTK IPN from mac80211 and set to firmware, and get latest
IGTK IPN from AOAC report then update to mac80211 after resume. When rekey
happen, also update new IGTK key info to mac80211. Furthermore, We
construct SA query reply packet to firmware. If firmware received SA query
request from AP can transmit reply back when suspend.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c |   3 +
 drivers/net/wireless/realtek/rtw89/fw.c  |  52 ++++++++++-
 drivers/net/wireless/realtek/rtw89/mac.c |   3 +
 drivers/net/wireless/realtek/rtw89/wow.c | 110 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/wow.h |  10 +++
 5 files changed, 175 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 67f13e4c3d15..e334b0c8ec5b 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -356,6 +356,9 @@ int rtw89_cam_sec_key_add(struct rtw89_dev *rtwdev,
 		key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
 		ext_key = true;
 		break;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		hw_key_type = RTW89_SEC_KEY_TYPE_BIP_CCMP128;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 50df25e6484d..444badc3eede 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -20,6 +20,12 @@ struct rtw89_eapol_2_of_2 {
 	u8 rsvd[92];
 } __packed __aligned(2);
 
+struct rtw89_sa_query {
+	struct ieee80211_hdr_3addr hdr;
+	u8 category;
+	u8 action;
+} __packed __aligned(2);
+
 static const u8 mss_signature[] = {0x4D, 0x53, 0x53, 0x4B, 0x50, 0x4F, 0x4F, 0x4C};
 
 union rtw89_fw_element_arg {
@@ -2192,6 +2198,31 @@ static struct sk_buff *rtw89_eapol_get(struct rtw89_dev *rtwdev,
 	return skb;
 }
 
+static struct sk_buff *rtw89_sa_query_get(struct rtw89_dev *rtwdev,
+					  struct rtw89_vif *rtwvif)
+{
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
+	struct rtw89_sa_query *sa_query;
+	struct sk_buff *skb;
+
+	skb = dev_alloc_skb(sizeof(*sa_query));
+	if (!skb)
+		return NULL;
+
+	sa_query = skb_put_zero(skb, sizeof(*sa_query));
+	sa_query->hdr.frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
+						  IEEE80211_STYPE_ACTION |
+						  IEEE80211_FCTL_PROTECTED);
+	ether_addr_copy(sa_query->hdr.addr1, bss_conf->bssid);
+	ether_addr_copy(sa_query->hdr.addr2, vif->addr);
+	ether_addr_copy(sa_query->hdr.addr3, bss_conf->bssid);
+	sa_query->category = WLAN_CATEGORY_SA_QUERY;
+	sa_query->action = WLAN_ACTION_SA_QUERY_RESPONSE;
+
+	return skb;
+}
+
 static int rtw89_fw_h2c_add_general_pkt(struct rtw89_dev *rtwdev,
 					struct rtw89_vif *rtwvif,
 					enum rtw89_fw_pkt_ofld_type type,
@@ -2222,6 +2253,9 @@ static int rtw89_fw_h2c_add_general_pkt(struct rtw89_dev *rtwdev,
 	case RTW89_PKT_OFLD_TYPE_EAPOL_KEY:
 		skb = rtw89_eapol_get(rtwdev, rtwvif);
 		break;
+	case RTW89_PKT_OFLD_TYPE_SA_QUERY:
+		skb = rtw89_sa_query_get(rtwdev, rtwvif);
+		break;
 	default:
 		goto err;
 	}
@@ -6556,6 +6590,7 @@ int rtw89_fw_h2c_wow_gtk_ofld(struct rtw89_dev *rtwdev,
 	struct rtw89_h2c_wow_gtk_ofld *h2c;
 	u8 macid = rtwvif->mac_id;
 	u32 len = sizeof(*h2c);
+	u8 pkt_id_sa_query = 0;
 	struct sk_buff *skb;
 	u8 pkt_id_eapol = 0;
 	int ret;
@@ -6583,13 +6618,24 @@ int rtw89_fw_h2c_wow_gtk_ofld(struct rtw89_dev *rtwdev,
 	if (ret)
 		goto fail;
 
-	/* not support TKIP and IEEE80211W yet */
+	if (gtk_info->igtk_keyid) {
+		ret = rtw89_fw_h2c_add_general_pkt(rtwdev, rtwvif,
+						   RTW89_PKT_OFLD_TYPE_SA_QUERY,
+						   &pkt_id_sa_query);
+		if (ret)
+			goto fail;
+	}
+
+	/* not support TKIP yet */
 	h2c->w0 = le32_encode_bits(enable, RTW89_H2C_WOW_GTK_OFLD_W0_EN) |
 		  le32_encode_bits(0, RTW89_H2C_WOW_GTK_OFLD_W0_TKIP_EN) |
-		  le32_encode_bits(0, RTW89_H2C_WOW_GTK_OFLD_W0_IEEE80211W_EN) |
+		  le32_encode_bits(gtk_info->igtk_keyid ? 1 : 0,
+				   RTW89_H2C_WOW_GTK_OFLD_W0_IEEE80211W_EN) |
 		  le32_encode_bits(macid, RTW89_H2C_WOW_GTK_OFLD_W0_MAC_ID) |
 		  le32_encode_bits(pkt_id_eapol, RTW89_H2C_WOW_GTK_OFLD_W0_GTK_RSP_ID);
-	h2c->w1 = le32_encode_bits(rtw_wow->akm, RTW89_H2C_WOW_GTK_OFLD_W1_ALGO_AKM_SUIT);
+	h2c->w1 = le32_encode_bits(gtk_info->igtk_keyid ? pkt_id_sa_query : 0,
+				   RTW89_H2C_WOW_GTK_OFLD_W1_PMF_SA_QUERY_ID) |
+		  le32_encode_bits(rtw_wow->akm, RTW89_H2C_WOW_GTK_OFLD_W1_ALGO_AKM_SUIT);
 	h2c->gtk_info = rtw_wow->gtk_info;
 
 hdr:
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 2d9983592223..3f4719d8bf53 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5154,6 +5154,9 @@ rtw89_mac_c2h_wow_aoac_rpt(struct rtw89_dev *rtwdev, struct sk_buff *skb, u32 le
 	memcpy(aoac_rpt->gtk, c2h->gtk, sizeof(aoac_rpt->gtk));
 	memcpy(aoac_rpt->ptk_rx_iv, c2h->ptk_rx_iv, sizeof(aoac_rpt->ptk_rx_iv));
 	memcpy(aoac_rpt->gtk_rx_iv, c2h->gtk_rx_iv, sizeof(aoac_rpt->gtk_rx_iv));
+	aoac_rpt->igtk_key_id = le64_to_cpu(c2h->igtk_key_id);
+	aoac_rpt->igtk_ipn = le64_to_cpu(c2h->igtk_ipn);
+	memcpy(aoac_rpt->igtk, c2h->igtk, sizeof(aoac_rpt->igtk));
 
 	cond = RTW89_WOW_WAIT_COND(H2C_FUNC_AOAC_REPORT_REQ);
 	rtw89_complete_cond(wait, cond, &data);
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index a930a3054325..f85f622893ba 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -35,6 +35,7 @@ static const struct rtw89_cipher_info rtw89_cipher_info_defs[] = {
 	{WLAN_CIPHER_SUITE_GCMP,	.fw_alg = 8,	.len = WLAN_KEY_LEN_GCMP,},
 	{WLAN_CIPHER_SUITE_CCMP_256,	.fw_alg = 7,	.len = WLAN_KEY_LEN_CCMP_256,},
 	{WLAN_CIPHER_SUITE_GCMP_256,	.fw_alg = 23,	.len = WLAN_KEY_LEN_GCMP_256,},
+	{WLAN_CIPHER_SUITE_AES_CMAC,	.fw_alg = 32,	.len = WLAN_KEY_LEN_AES_CMAC,},
 };
 
 static const
@@ -203,6 +204,63 @@ static int rtw89_tx_iv_to_pn(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static int rtw89_rx_pn_get_pmf(struct rtw89_dev *rtwdev,
+			       struct ieee80211_key_conf *key,
+			       struct rtw89_wow_gtk_info *gtk_info)
+{
+	struct ieee80211_key_seq seq;
+	u64 pn;
+
+	if (key->keyidx == 4)
+		memcpy(gtk_info->igtk[0], key->key, key->keylen);
+	else if (key->keyidx == 5)
+		memcpy(gtk_info->igtk[1], key->key, key->keylen);
+	else
+		return -EINVAL;
+
+	ieee80211_get_key_rx_seq(key, 0, &seq);
+
+	/* seq.ccmp.pn[] is BE order array */
+	pn = u64_encode_bits(seq.ccmp.pn[0], RTW89_KEY_PN_5) |
+	     u64_encode_bits(seq.ccmp.pn[1], RTW89_KEY_PN_4) |
+	     u64_encode_bits(seq.ccmp.pn[2], RTW89_KEY_PN_3) |
+	     u64_encode_bits(seq.ccmp.pn[3], RTW89_KEY_PN_2) |
+	     u64_encode_bits(seq.ccmp.pn[4], RTW89_KEY_PN_1) |
+	     u64_encode_bits(seq.ccmp.pn[5], RTW89_KEY_PN_0);
+	gtk_info->ipn = cpu_to_le64(pn);
+	gtk_info->igtk_keyid = cpu_to_le32(key->keyidx);
+	rtw89_debug(rtwdev, RTW89_DBG_WOW, "%s key %d pn-%llx\n",
+		    __func__, key->keyidx, pn);
+
+	return 0;
+}
+
+static int rtw89_rx_pn_set_pmf(struct rtw89_dev *rtwdev,
+			       struct ieee80211_key_conf *key,
+			       u64 pn)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw89_wow_aoac_report *aoac_rpt = &rtw_wow->aoac_rpt;
+	struct ieee80211_key_seq seq;
+
+	if (key->keyidx != aoac_rpt->igtk_key_id)
+		return 0;
+
+	/* seq.ccmp.pn[] is BE order array */
+	seq.ccmp.pn[0] = u64_get_bits(pn, RTW89_KEY_PN_5);
+	seq.ccmp.pn[1] = u64_get_bits(pn, RTW89_KEY_PN_4);
+	seq.ccmp.pn[2] = u64_get_bits(pn, RTW89_KEY_PN_3);
+	seq.ccmp.pn[3] = u64_get_bits(pn, RTW89_KEY_PN_2);
+	seq.ccmp.pn[4] = u64_get_bits(pn, RTW89_KEY_PN_1);
+	seq.ccmp.pn[5] = u64_get_bits(pn, RTW89_KEY_PN_0);
+
+	ieee80211_set_key_rx_seq(key, 0, &seq);
+	rtw89_debug(rtwdev, RTW89_DBG_WOW, "%s key %d pn-%*ph\n",
+		    __func__, key->keyidx, 6, seq.ccmp.pn);
+
+	return 0;
+}
+
 static void rtw89_wow_get_key_info_iter(struct ieee80211_hw *hw,
 					struct ieee80211_vif *vif,
 					struct ieee80211_sta *sta,
@@ -212,6 +270,7 @@ static void rtw89_wow_get_key_info_iter(struct ieee80211_hw *hw,
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct rtw89_wow_key_info *key_info = &rtw_wow->key_info;
+	struct rtw89_wow_gtk_info *gtk_info = &rtw_wow->gtk_info;
 	const struct rtw89_cipher_info *cipher_info;
 	bool *err = data;
 	int ret;
@@ -246,6 +305,11 @@ static void rtw89_wow_get_key_info_iter(struct ieee80211_hw *hw,
 			key_info->gtk_keyidx = key->keyidx;
 		}
 		break;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		ret = rtw89_rx_pn_get_pmf(rtwdev, key, gtk_info);
+		if (ret)
+			goto err;
+		break;
 	default:
 		rtw89_debug(rtwdev, RTW89_DBG_WOW, "unsupport cipher %x\n",
 			    key->cipher);
@@ -300,6 +364,17 @@ static void rtw89_wow_set_key_info_iter(struct ieee80211_hw *hw,
 		if (!sta && update_tx_key_info && aoac_rpt->rekey_ok)
 			iter_data->gtk_cipher = key->cipher;
 		break;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		if (update_tx_key_info) {
+			if (aoac_rpt->rekey_ok)
+				iter_data->igtk_cipher = key->cipher;
+		} else {
+			ret = rtw89_rx_pn_set_pmf(rtwdev, key,
+						  aoac_rpt->igtk_ipn);
+			if (ret)
+				goto err;
+		}
+		break;
 	default:
 		rtw89_debug(rtwdev, RTW89_DBG_WOW, "unsupport cipher %x\n",
 			    key->cipher);
@@ -392,6 +467,7 @@ static int rtw89_wow_get_aoac_rpt_reg(struct rtw89_dev *rtwdev)
 	struct rtw89_wow_aoac_report *aoac_rpt = &rtw_wow->aoac_rpt;
 	struct rtw89_mac_c2h_info c2h_info = {};
 	struct rtw89_mac_h2c_info h2c_info = {};
+	u8 igtk_ipn[8];
 	u8 key_idx;
 	int ret;
 
@@ -443,6 +519,30 @@ static int rtw89_wow_get_aoac_rpt_reg(struct rtw89_dev *rtwdev)
 		u32_get_bits(c2h_info.u.c2hreg[1], RTW89_C2HREG_AOAC_RPT_2_W1_PTK_IV_6);
 	aoac_rpt->ptk_rx_iv[7] =
 		u32_get_bits(c2h_info.u.c2hreg[1], RTW89_C2HREG_AOAC_RPT_2_W1_PTK_IV_7);
+	igtk_ipn[0] =
+		u32_get_bits(c2h_info.u.c2hreg[1], RTW89_C2HREG_AOAC_RPT_2_W1_IGTK_IPN_IV_0);
+	igtk_ipn[1] =
+		u32_get_bits(c2h_info.u.c2hreg[1], RTW89_C2HREG_AOAC_RPT_2_W1_IGTK_IPN_IV_1);
+	igtk_ipn[2] =
+		u32_get_bits(c2h_info.u.c2hreg[2], RTW89_C2HREG_AOAC_RPT_2_W2_IGTK_IPN_IV_2);
+	igtk_ipn[3] =
+		u32_get_bits(c2h_info.u.c2hreg[2], RTW89_C2HREG_AOAC_RPT_2_W2_IGTK_IPN_IV_3);
+	igtk_ipn[4] =
+		u32_get_bits(c2h_info.u.c2hreg[2], RTW89_C2HREG_AOAC_RPT_2_W2_IGTK_IPN_IV_4);
+	igtk_ipn[5] =
+		u32_get_bits(c2h_info.u.c2hreg[2], RTW89_C2HREG_AOAC_RPT_2_W2_IGTK_IPN_IV_5);
+	igtk_ipn[6] =
+		u32_get_bits(c2h_info.u.c2hreg[3], RTW89_C2HREG_AOAC_RPT_2_W3_IGTK_IPN_IV_6);
+	igtk_ipn[7] =
+		u32_get_bits(c2h_info.u.c2hreg[3], RTW89_C2HREG_AOAC_RPT_2_W3_IGTK_IPN_IV_7);
+	aoac_rpt->igtk_ipn = u64_encode_bits(igtk_ipn[0], RTW89_IGTK_IPN_0) |
+			     u64_encode_bits(igtk_ipn[1], RTW89_IGTK_IPN_1) |
+			     u64_encode_bits(igtk_ipn[2], RTW89_IGTK_IPN_2) |
+			     u64_encode_bits(igtk_ipn[3], RTW89_IGTK_IPN_3) |
+			     u64_encode_bits(igtk_ipn[4], RTW89_IGTK_IPN_4) |
+			     u64_encode_bits(igtk_ipn[5], RTW89_IGTK_IPN_5) |
+			     u64_encode_bits(igtk_ipn[6], RTW89_IGTK_IPN_6) |
+			     u64_encode_bits(igtk_ipn[7], RTW89_IGTK_IPN_7);
 
 	return 0;
 }
@@ -540,6 +640,16 @@ static void rtw89_wow_update_key_info(struct rtw89_dev *rtwdev, bool rx_ready)
 
 	rtw89_rx_iv_to_pn(rtwdev, key,
 			  aoac_rpt->gtk_rx_iv[key->keyidx]);
+
+	if (!data.igtk_cipher)
+		return;
+
+	key = rtw89_wow_gtk_rekey(rtwdev, data.igtk_cipher, aoac_rpt->igtk_key_id,
+				  aoac_rpt->igtk);
+	if (!key)
+		return;
+
+	rtw89_rx_pn_set_pmf(rtwdev, key, aoac_rpt->igtk_ipn);
 	ieee80211_gtk_rekey_notify(wow_vif, wow_vif->bss_conf.bssid,
 				   aoac_rpt->eapol_key_replay_count,
 				   GFP_KERNEL);
diff --git a/drivers/net/wireless/realtek/rtw89/wow.h b/drivers/net/wireless/realtek/rtw89/wow.h
index 4ce248defc94..1601c99341d5 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.h
+++ b/drivers/net/wireless/realtek/rtw89/wow.h
@@ -12,6 +12,15 @@
 #define RTW89_KEY_PN_4 GENMASK_ULL(39, 32)
 #define RTW89_KEY_PN_5 GENMASK_ULL(47, 40)
 
+#define RTW89_IGTK_IPN_0 GENMASK_ULL(7, 0)
+#define RTW89_IGTK_IPN_1 GENMASK_ULL(15, 8)
+#define RTW89_IGTK_IPN_2 GENMASK_ULL(23, 16)
+#define RTW89_IGTK_IPN_3 GENMASK_ULL(31, 24)
+#define RTW89_IGTK_IPN_4 GENMASK_ULL(39, 32)
+#define RTW89_IGTK_IPN_5 GENMASK_ULL(47, 40)
+#define RTW89_IGTK_IPN_6 GENMASK_ULL(55, 48)
+#define RTW89_IGTK_IPN_7 GENMASK_ULL(63, 56)
+
 #define RTW89_WOW_VALID_CHECK 0xDD
 #define RTW89_WOW_SYMBOL_CHK_PTK BIT(0)
 #define RTW89_WOW_SYMBOL_CHK_GTK BIT(1)
@@ -50,6 +59,7 @@ struct rtw89_cipher_info {
 
 struct rtw89_set_key_info_iter_data {
 	u32 gtk_cipher;
+	u32 igtk_cipher;
 	bool rx_ready;
 	bool error;
 };
-- 
2.25.1


