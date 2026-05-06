Return-Path: <linux-wireless+bounces-36017-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIR2G48++2nUXwMAu9opvQ
	(envelope-from <linux-wireless+bounces-36017-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:13:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ACE4DACD3
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0002530125EF
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 13:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A630023D7FF;
	Wed,  6 May 2026 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="tLnuay27"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F3734252D
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073041; cv=none; b=S9bfVHXcetVJVNzs5E6mrxEOPZYPFXEW1lgIrnAdWZYHRLLdfpcHBFTMrpRjB4fhzwZKyWdeDHvURTwGUeZ7DML3annG9eYmjPyD9HhwpMK0aqwBamBmROvcNyTacf07rnDiF/bjwmusLu1O3ejUJ9K3lGNACPMv2bRYwIzi5YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073041; c=relaxed/simple;
	bh=xQOGgRJqGXJT7Kqx3zxvKuHtBfeomTjx4wq7Z9jhw2Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MokwAWtMlSLkR9CgvVjkT4mAv251byv17Hpfe0P5xSsHeKrikbHQEQTYSmrucI6puscODanS/CBf8oPOS+ol8utxwcYy/IKuaLgE9SLLV4G6oiRlve+d75fOWB2Vke4nqiCHuR9SVf9TNbL9LIXUNHdNa2GYbaCFRb71XQHkHT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=tLnuay27; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 646DAcJtA1986913, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778073038; bh=GaLHYLC+4gOHw8Mss2X/1oRQET0zSnj0pwx6f/Z++SA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=tLnuay27NafWo0W+nkGBg9oQllYbs9GUrC/Npk1TRF5gSou6x5oTzejZ4IYFCvc0e
	 16tRZt5j43PU2Mq8WLMU/2C82yhlmQ46YKq32FYwPr8j069eQftEptrjlHjTfBAYs1
	 GUyVdtI+91M0RNJjhNSXlF12d38u0ublYDCDQQ/uI+PykDiuvZJox7yLfZv+4igmWC
	 Y5+rgs7X+dzxFzYXgb9Uxi6ntvkbB/gB7lcy7Gi9XDM6beWmv2KcgfpcaSKIHU/lFt
	 Ig4oBU1LiK7dQBCbxAqhBNfnRFNaiPx5wsaSC9NeZRnV8z0n6huJF6EYMvyKHX7HXO
	 p3TN5AtTQZP0Q==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 646DAcJtA1986913
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 6 May 2026 21:10:38 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 May 2026 21:10:38 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 6 May 2026 21:10:37 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 6 May 2026 21:10:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 07/14] wifi: rtw89: fill VHT radiotap
Date: Wed, 6 May 2026 21:09:53 +0800
Message-ID: <20260506131000.1706298-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260506131000.1706298-1-pkshih@realtek.com>
References: <20260506131000.1706298-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: E4ACE4DACD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36017-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:dkim,realtek.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Fill VHT radiotap by PHY status IE-09 which contains VHT SIG-A.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 53 +++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h |  4 +-
 drivers/net/wireless/realtek/rtw89/txrx.h | 26 +++++++++++
 3 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index a27e482e38a6..2a9326335c53 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3176,6 +3176,50 @@ void rtw89_core_update_rx_status_by_ppdu(struct rtw89_dev *rtwdev,
 		rx_status->enc_flags |= u8_encode_bits(1, RX_ENC_FLAG_STBC_MASK);
 }
 
+static void rtw89_core_update_radiotap_vht(struct rtw89_dev *rtwdev,
+					   struct sk_buff *skb,
+					   struct ieee80211_rx_status *rx_status,
+					   struct rtw89_rx_phy_ppdu *phy_ppdu)
+{
+	const struct rtw89_phy_sts_ie09 *ie09;
+	struct ieee80211_radiotap_vht *vht;
+	u8 group_id;
+	u32 sig_a1;
+	u16 paid;
+	u8 nss;
+
+	if (!phy_ppdu)
+		return;
+
+	ie09 = phy_ppdu->ie09;
+	if (!ie09)
+		return;
+
+	vht = skb_push(skb, sizeof(*vht));
+	memset(vht, 0, sizeof(*vht));
+	rx_status->flag |= RX_FLAG_RADIOTAP_VHT;
+
+	sig_a1 = le64_get_bits(ie09->qw0, RTW89_PHY_STS_IE09_VHT_SIG_A1_MASK);
+
+	group_id = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_VHT_SIG_A1_GRP_ID);
+	vht->group_id = group_id;
+
+	if (group_id == 0 || group_id == 63) {
+		paid = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_VHT_SIG_A1_SU_PAID);
+		vht->partial_aid = cpu_to_le16(paid);
+	} else {
+		/* let mac80211 fill vht->mcs_nss[0] */
+#define WITH_MCS_IS_NOT_KNOWN(nss) ((nss) ? (15 << 4) | (nss) : 0)
+		nss = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_VHT_SIG_A1_MU_NSTS1);
+		vht->mcs_nss[1] = WITH_MCS_IS_NOT_KNOWN(nss);
+		nss = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_VHT_SIG_A1_MU_NSTS2);
+		vht->mcs_nss[2] = WITH_MCS_IS_NOT_KNOWN(nss);
+		nss = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_VHT_SIG_A1_MU_NSTS3);
+		vht->mcs_nss[3] = WITH_MCS_IS_NOT_KNOWN(nss);
+#undef WITH_MCS_IS_NOT_KNOWN
+	}
+}
+
 static void rtw89_core_update_radiotap_he(struct rtw89_dev *rtwdev,
 					  struct sk_buff *skb,
 					  struct ieee80211_rx_status *rx_status)
@@ -3266,12 +3310,15 @@ static void rtw89_core_update_radiotap_eht(struct rtw89_dev *rtwdev,
 
 static void rtw89_core_update_radiotap(struct rtw89_dev *rtwdev,
 				       struct sk_buff *skb,
-				       struct ieee80211_rx_status *rx_status)
+				       struct ieee80211_rx_status *rx_status,
+				       struct rtw89_rx_phy_ppdu *phy_ppdu)
 {
 	if (!(rtwdev->hw->conf.flags & IEEE80211_CONF_MONITOR))
 		return;
 
-	if (rx_status->encoding == RX_ENC_HE)
+	if (rx_status->encoding == RX_ENC_VHT)
+		rtw89_core_update_radiotap_vht(rtwdev, skb, rx_status, phy_ppdu);
+	else if (rx_status->encoding == RX_ENC_HE)
 		rtw89_core_update_radiotap_he(rtwdev, skb, rx_status);
 	else if (rx_status->encoding == RX_ENC_EHT)
 		rtw89_core_update_radiotap_eht(rtwdev, skb, rx_status);
@@ -3484,7 +3531,7 @@ static void rtw89_core_rx_to_mac80211(struct rtw89_dev *rtwdev,
 	rtw89_core_hw_to_sband_rate(rx_status);
 	rtw89_core_rx_stats(rtwdev, phy_ppdu, desc_info, skb_ppdu);
 	rtw89_core_update_rx_status_by_ppdu(rtwdev, rx_status, phy_ppdu);
-	rtw89_core_update_radiotap(rtwdev, skb_ppdu, rx_status);
+	rtw89_core_update_radiotap(rtwdev, skb_ppdu, rx_status, phy_ppdu);
 	rtw89_core_validate_rx_signal(rx_status);
 	rtw89_core_update_rx_freq_from_ie(rtwdev, skb_ppdu, rx_status);
 	rtw89_core_correct_mcc_chan(rtwdev, desc_info, rx_status, phy_ppdu);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ca716e95cb2c..d1cd5997cf97 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -58,6 +58,7 @@ extern const struct ieee80211_ops rtw89_ops;
 #define RTW89_TX_DIV_RSSI_RAW_TH (2 << RSSI_FACTOR)
 #define DELTA_SWINGIDX_SIZE 30
 
+#define RTW89_RADIOTAP_ROOM_VHT sizeof(struct ieee80211_radiotap_vht)
 #define RTW89_RADIOTAP_ROOM_HE sizeof(struct ieee80211_radiotap_he)
 #define RTW89_RADIOTAP_ROOM_EHT \
 	(sizeof(struct ieee80211_radiotap_tlv) + \
@@ -65,7 +66,8 @@ extern const struct ieee80211_ops rtw89_ops;
 	 sizeof(struct ieee80211_radiotap_tlv) + \
 	 ALIGN(sizeof(struct ieee80211_radiotap_eht_usig), 4))
 #define RTW89_RADIOTAP_ROOM \
-	ALIGN(max(RTW89_RADIOTAP_ROOM_HE, RTW89_RADIOTAP_ROOM_EHT), 64)
+	ALIGN(max3(RTW89_RADIOTAP_ROOM_VHT, RTW89_RADIOTAP_ROOM_HE, \
+		   RTW89_RADIOTAP_ROOM_EHT), 64)
 
 #define RTW89_HTC_MASK_VARIANT GENMASK(1, 0)
 #define RTW89_HTC_VARIANT_HE 3
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index 18fe6d3d0f83..ddf8742d6712 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -662,6 +662,32 @@ struct rtw89_phy_sts_ie09 {
 	__le64 qw0;
 } __packed;
 
+#define RTW89_PHY_STS_IE09_L_SIG_MASK GENMASK(21, 5) /* Legacy/VHT/HE L-SIG */
+#define RTW89_PHY_STS_IE09_L_SIG_RATE GENMASK(3, 0)
+#define RTW89_PHY_STS_IE09_L_SIG_RSVD BIT(4)
+#define RTW89_PHY_STS_IE09_L_SIG_LENGTH GENMASK(16, 5)
+#define RTW89_PHY_STS_IE09_VHT_SIG_A1_MASK GENMASK_ULL(45, 22) /* VHT SIG-A1 */
+#define RTW89_PHY_STS_IE09_VHT_SIG_A1_BW GENMASK(1, 0)
+#define RTW89_PHY_STS_IE09_VHT_SIG_A1_RSVD1 BIT(2)
+#define RTW89_PHY_STS_IE09_VHT_SIG_A1_STBC BIT(3)
+#define RTW89_PHY_STS_IE09_VHT_SIG_A1_GRP_ID GENMASK(9, 4)
+#define RTW89_PHY_STS_IE09_VHT_SIG_A1_SU_NSTS GENMASK(12, 10)
+#define RTW89_PHY_STS_IE09_VHT_SIG_A1_SU_PAID GENMASK(21, 13)
+#define RTW89_PHY_STS_IE09_VHT_SIG_A1_MU_NSTS0 GENMASK(12, 10)
+#define RTW89_PHY_STS_IE09_VHT_SIG_A1_MU_NSTS1 GENMASK(15, 13)
+#define RTW89_PHY_STS_IE09_VHT_SIG_A1_MU_NSTS2 GENMASK(18, 16)
+#define RTW89_PHY_STS_IE09_VHT_SIG_A1_MU_NSTS3 GENMASK(21, 19)
+#define RTW89_PHY_STS_IE09_VHT_SIG_A1_TXOP_NOPS BIT(22)
+#define RTW89_PHY_STS_IE09_VHT_SIG_A1_RSVD2 BIT(23)
+#define RTW89_PHY_STS_IE09_VHT_SIG_A2_MASK GENMASK_ULL(55, 46) /* VHT SIG-A2 */
+#define RTW89_PHY_STS_IE09_VHT_SIG_A2_SGI BIT(0)
+#define RTW89_PHY_STS_IE09_VHT_SIG_A2_SGI_DISA BIT(1)
+#define RTW89_PHY_STS_IE09_VHT_SIG_A2_SUMU_CODE0 BIT(2)
+#define RTW89_PHY_STS_IE09_VHT_SIG_A2_LDPC BIT(3)
+#define RTW89_PHY_STS_IE09_VHT_SIG_A2_SUMU_CODE3 GENMASK(7, 4)
+#define RTW89_PHY_STS_IE09_VHT_SIG_A2_BF BIT(8)
+#define RTW89_PHY_STS_IE09_VHT_SIG_A2_RSVD3 BIT(9)
+
 struct rtw89_phy_sts_ie10 {
 	__le64 qw0;
 	u8 sigb[];
-- 
2.25.1


