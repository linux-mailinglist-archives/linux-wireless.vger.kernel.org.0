Return-Path: <linux-wireless+bounces-9265-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF78F90FC6A
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 07:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85AE1C215A5
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 05:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9F538F97;
	Thu, 20 Jun 2024 05:58:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4D32744C
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 05:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718863125; cv=none; b=GokGFE3YGFiYA4kqohVuOF6b8LfAZYK52IF94Ynk38fxZpjj19DCbwlxROibXDJgnBJWxdmrA8hjq43tDVCZZ7+jH2MCxcWsflYiGzdO/1zWNvETb1oKF4mHnLFVBpl+bZLaHStaZdXsBAX96LjoNSHIaLnyggFDWUS1laNpbSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718863125; c=relaxed/simple;
	bh=6swFbiZodTUVIQ8Ps1Z861qK5ohIV4NkzIOcUhK+VdM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAGaSBE3dwnKl0F600bTTs3/CpTve8qoeFUaIO6CWd4HKnPABMVR/zdOwfZhcv2we5gi+Rf9+Mwz0o2p9Hs/VrpFn6f31I0Jt+u5wJ7pAb6O0ijJa//9Rb7MqlhvMA6zwt+RvrGog5sqwD7PFp4oMAsTr4iBM9OQBdSIrs+29hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45K5wf3W32577628, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45K5wf3W32577628
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 13:58:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 13:58:41 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 20 Jun
 2024 13:58:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH 1/7] wifi: rtw89: wow: append security header offset for different cipher
Date: Thu, 20 Jun 2024 13:58:19 +0800
Message-ID: <20240620055825.17592-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620055825.17592-1-pkshih@realtek.com>
References: <20240620055825.17592-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

When creating EAPOL_KEY, SA_QUERY and ARP_RSP packet offload, we need
to append security header offset for different cipher as required by
the firmware. Only 8852A, 8852B, 8852BT and 8851B need it.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c  | 67 +++++++++++++++---------
 drivers/net/wireless/realtek/rtw89/wow.c | 22 +++++---
 drivers/net/wireless/realtek/rtw89/wow.h | 30 +++++++++++
 3 files changed, 85 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 23204b2706c9..3c666fd0f8ed 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -13,22 +13,20 @@
 #include "ps.h"
 #include "reg.h"
 #include "util.h"
+#include "wow.h"
 
 struct rtw89_eapol_2_of_2 {
-	struct ieee80211_hdr_3addr hdr;
 	u8 gtkbody[14];
 	u8 key_des_ver;
 	u8 rsvd[92];
-} __packed __aligned(2);
+} __packed;
 
 struct rtw89_sa_query {
-	struct ieee80211_hdr_3addr hdr;
 	u8 category;
 	u8 action;
-} __packed __aligned(2);
+} __packed;
 
 struct rtw89_arp_rsp {
-	struct ieee80211_hdr_3addr addr;
 	u8 llc_hdr[sizeof(rfc1042_header)];
 	__be16 llc_type;
 	struct arphdr arp_hdr;
@@ -36,7 +34,7 @@ struct rtw89_arp_rsp {
 	__be32 sender_ip;
 	u8 target_hw[ETH_ALEN];
 	__be32 target_ip;
-} __packed __aligned(2);
+} __packed;
 
 static const u8 mss_signature[] = {0x4D, 0x53, 0x53, 0x4B, 0x50, 0x4F, 0x4F, 0x4C};
 
@@ -2197,8 +2195,10 @@ static struct sk_buff *rtw89_eapol_get(struct rtw89_dev *rtwdev,
 				     0x8E, 0x01, 0x03, 0x00, 0x5F, 0x02, 0x03};
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
 	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
+	u8 sec_hdr_len = rtw89_wow_get_sec_hdr_len(rtwdev);
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct rtw89_eapol_2_of_2 *eapol_pkt;
+	struct ieee80211_hdr_3addr *hdr;
 	struct sk_buff *skb;
 	u8 key_des_ver;
 
@@ -2211,17 +2211,21 @@ static struct sk_buff *rtw89_eapol_get(struct rtw89_dev *rtwdev,
 	else
 		key_des_ver = 0;
 
-	skb = dev_alloc_skb(sizeof(*eapol_pkt));
+	skb = dev_alloc_skb(sizeof(*hdr) + sec_hdr_len + sizeof(*eapol_pkt));
 	if (!skb)
 		return NULL;
 
+	hdr = skb_put_zero(skb, sizeof(*hdr));
+	hdr->frame_control = cpu_to_le16(IEEE80211_FTYPE_DATA |
+					 IEEE80211_FCTL_TODS |
+					 IEEE80211_FCTL_PROTECTED);
+	ether_addr_copy(hdr->addr1, bss_conf->bssid);
+	ether_addr_copy(hdr->addr2, vif->addr);
+	ether_addr_copy(hdr->addr3, bss_conf->bssid);
+
+	skb_put_zero(skb, sec_hdr_len);
+
 	eapol_pkt = skb_put_zero(skb, sizeof(*eapol_pkt));
-	eapol_pkt->hdr.frame_control = cpu_to_le16(IEEE80211_FTYPE_DATA |
-						   IEEE80211_FCTL_TODS |
-						   IEEE80211_FCTL_PROTECTED);
-	ether_addr_copy(eapol_pkt->hdr.addr1, bss_conf->bssid);
-	ether_addr_copy(eapol_pkt->hdr.addr2, vif->addr);
-	ether_addr_copy(eapol_pkt->hdr.addr3, bss_conf->bssid);
 	memcpy(eapol_pkt->gtkbody, gtkbody, sizeof(gtkbody));
 	eapol_pkt->key_des_ver = key_des_ver;
 
@@ -2233,20 +2237,26 @@ static struct sk_buff *rtw89_sa_query_get(struct rtw89_dev *rtwdev,
 {
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
 	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
+	u8 sec_hdr_len = rtw89_wow_get_sec_hdr_len(rtwdev);
+	struct ieee80211_hdr_3addr *hdr;
 	struct rtw89_sa_query *sa_query;
 	struct sk_buff *skb;
 
-	skb = dev_alloc_skb(sizeof(*sa_query));
+	skb = dev_alloc_skb(sizeof(*hdr) + sec_hdr_len + sizeof(*sa_query));
 	if (!skb)
 		return NULL;
 
+	hdr = skb_put_zero(skb, sizeof(*hdr));
+	hdr->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
+					 IEEE80211_STYPE_ACTION |
+					 IEEE80211_FCTL_PROTECTED);
+	ether_addr_copy(hdr->addr1, bss_conf->bssid);
+	ether_addr_copy(hdr->addr2, vif->addr);
+	ether_addr_copy(hdr->addr3, bss_conf->bssid);
+
+	skb_put_zero(skb, sec_hdr_len);
+
 	sa_query = skb_put_zero(skb, sizeof(*sa_query));
-	sa_query->hdr.frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
-						  IEEE80211_STYPE_ACTION |
-						  IEEE80211_FCTL_PROTECTED);
-	ether_addr_copy(sa_query->hdr.addr1, bss_conf->bssid);
-	ether_addr_copy(sa_query->hdr.addr2, vif->addr);
-	ether_addr_copy(sa_query->hdr.addr3, bss_conf->bssid);
 	sa_query->category = WLAN_CATEGORY_SA_QUERY;
 	sa_query->action = WLAN_ACTION_SA_QUERY_RESPONSE;
 
@@ -2256,17 +2266,19 @@ static struct sk_buff *rtw89_sa_query_get(struct rtw89_dev *rtwdev,
 static struct sk_buff *rtw89_arp_response_get(struct rtw89_dev *rtwdev,
 					      struct rtw89_vif *rtwvif)
 {
+	u8 sec_hdr_len = rtw89_wow_get_sec_hdr_len(rtwdev);
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct ieee80211_hdr_3addr *hdr;
 	struct rtw89_arp_rsp *arp_skb;
 	struct arphdr *arp_hdr;
 	struct sk_buff *skb;
 	__le16 fc;
 
-	skb = dev_alloc_skb(sizeof(struct rtw89_arp_rsp));
+	skb = dev_alloc_skb(sizeof(*hdr) + sec_hdr_len + sizeof(*arp_skb));
 	if (!skb)
 		return NULL;
 
-	arp_skb = skb_put_zero(skb, sizeof(*arp_skb));
+	hdr = skb_put_zero(skb, sizeof(*hdr));
 
 	if (rtw_wow->ptk_alg)
 		fc = cpu_to_le16(IEEE80211_FTYPE_DATA | IEEE80211_FCTL_TODS |
@@ -2274,11 +2286,14 @@ static struct sk_buff *rtw89_arp_response_get(struct rtw89_dev *rtwdev,
 	else
 		fc = cpu_to_le16(IEEE80211_FTYPE_DATA | IEEE80211_FCTL_TODS);
 
-	arp_skb->addr.frame_control = fc;
-	ether_addr_copy(arp_skb->addr.addr1, rtwvif->bssid);
-	ether_addr_copy(arp_skb->addr.addr2, rtwvif->mac_addr);
-	ether_addr_copy(arp_skb->addr.addr3, rtwvif->bssid);
+	hdr->frame_control = fc;
+	ether_addr_copy(hdr->addr1, rtwvif->bssid);
+	ether_addr_copy(hdr->addr2, rtwvif->mac_addr);
+	ether_addr_copy(hdr->addr3, rtwvif->bssid);
+
+	skb_put_zero(skb, sec_hdr_len);
 
+	arp_skb = skb_put_zero(skb, sizeof(*arp_skb));
 	memcpy(arp_skb->llc_hdr, rfc1042_header, sizeof(rfc1042_header));
 	arp_skb->llc_type = htons(ETH_P_ARP);
 
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index fa61484c3839..df22a53b8f41 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -27,17 +27,23 @@ void rtw89_wow_parse_akm(struct rtw89_dev *rtwdev, struct sk_buff *skb)
 	rtw_wow->akm = rsn_ie->akm_cipher_suite.type;
 }
 
+#define RTW89_CIPHER_INFO_DEF(cipher) \
+	{WLAN_CIPHER_SUITE_ ## cipher, .fw_alg = RTW89_WOW_FW_ALG_ ## cipher, \
+	 .len = WLAN_KEY_LEN_ ## cipher}
+
 static const struct rtw89_cipher_info rtw89_cipher_info_defs[] = {
-	{WLAN_CIPHER_SUITE_WEP40,	.fw_alg = 1,	.len = WLAN_KEY_LEN_WEP40,},
-	{WLAN_CIPHER_SUITE_WEP104,	.fw_alg = 2,	.len = WLAN_KEY_LEN_WEP104,},
-	{WLAN_CIPHER_SUITE_TKIP,	.fw_alg = 3,	.len = WLAN_KEY_LEN_TKIP,},
-	{WLAN_CIPHER_SUITE_CCMP,	.fw_alg = 6,	.len = WLAN_KEY_LEN_CCMP,},
-	{WLAN_CIPHER_SUITE_GCMP,	.fw_alg = 8,	.len = WLAN_KEY_LEN_GCMP,},
-	{WLAN_CIPHER_SUITE_CCMP_256,	.fw_alg = 7,	.len = WLAN_KEY_LEN_CCMP_256,},
-	{WLAN_CIPHER_SUITE_GCMP_256,	.fw_alg = 23,	.len = WLAN_KEY_LEN_GCMP_256,},
-	{WLAN_CIPHER_SUITE_AES_CMAC,	.fw_alg = 32,	.len = WLAN_KEY_LEN_AES_CMAC,},
+	RTW89_CIPHER_INFO_DEF(WEP40),
+	RTW89_CIPHER_INFO_DEF(WEP104),
+	RTW89_CIPHER_INFO_DEF(TKIP),
+	RTW89_CIPHER_INFO_DEF(CCMP),
+	RTW89_CIPHER_INFO_DEF(GCMP),
+	RTW89_CIPHER_INFO_DEF(CCMP_256),
+	RTW89_CIPHER_INFO_DEF(GCMP_256),
+	RTW89_CIPHER_INFO_DEF(AES_CMAC),
 };
 
+#undef RTW89_CIPHER_INFO_DEF
+
 static const
 struct rtw89_cipher_info *rtw89_cipher_alg_recognize(u32 cipher)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/wow.h b/drivers/net/wireless/realtek/rtw89/wow.h
index e595aee0196d..0d90add0e88d 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.h
+++ b/drivers/net/wireless/realtek/rtw89/wow.h
@@ -35,6 +35,17 @@ enum rtw89_wake_reason {
 	RTW89_WOW_RSN_RX_NLO = 0x55,
 };
 
+enum rtw89_fw_alg {
+	RTW89_WOW_FW_ALG_WEP40 = 0x1,
+	RTW89_WOW_FW_ALG_WEP104 = 0x2,
+	RTW89_WOW_FW_ALG_TKIP = 0x3,
+	RTW89_WOW_FW_ALG_CCMP = 0x6,
+	RTW89_WOW_FW_ALG_CCMP_256 = 0x7,
+	RTW89_WOW_FW_ALG_GCMP = 0x8,
+	RTW89_WOW_FW_ALG_GCMP_256 = 0x9,
+	RTW89_WOW_FW_ALG_AES_CMAC = 0xa,
+};
+
 struct rtw89_cipher_suite {
 	u8 oui[3];
 	u8 type;
@@ -64,6 +75,25 @@ struct rtw89_set_key_info_iter_data {
 	bool error;
 };
 
+static inline int rtw89_wow_get_sec_hdr_len(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+
+	if (!(rtwdev->chip->chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev)))
+		return 0;
+
+	switch (rtw_wow->ptk_alg) {
+	case RTW89_WOW_FW_ALG_WEP40:
+		return 4;
+	case RTW89_WOW_FW_ALG_TKIP:
+	case RTW89_WOW_FW_ALG_CCMP:
+	case RTW89_WOW_FW_ALG_GCMP_256:
+		return 8;
+	default:
+		return 0;
+	}
+}
+
 #ifdef CONFIG_PM
 int rtw89_wow_suspend(struct rtw89_dev *rtwdev, struct cfg80211_wowlan *wowlan);
 int rtw89_wow_resume(struct rtw89_dev *rtwdev);
-- 
2.25.1


