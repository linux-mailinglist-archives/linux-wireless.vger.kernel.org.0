Return-Path: <linux-wireless+bounces-36023-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCHXCvQ9+2nUXwMAu9opvQ
	(envelope-from <linux-wireless+bounces-36023-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:11:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0714DAC33
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CB9C300889D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 13:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F933EF65D;
	Wed,  6 May 2026 13:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="gJ3yfKPF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFD823D7FF
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073072; cv=none; b=ALCAUjd1AwDbbwcB8tjMRVpwIQ2S98dRDFRuZmaKUT8nkXo+K3P4WD87H1w8ubjbC7UZX3WQUSN3NZoTbQ5/Ljxp0DvZLiBlBmIvZoiMom0oFhneexM7UHMauVxLx62M+LwrkhG9zSSguy65Nuf5XnOSXtmuxLQ/O87SdzZGX3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073072; c=relaxed/simple;
	bh=4KfMZIgZP9hQo4XpGM/LpGPE/RYEw4Rrf2vVc2oPfKM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IPj3AS8pcbyCAeSbvEOTilOyOhkeC5V5TMh/OGjKC2JLHV8hkwLGx/7MYud6XV36VaUAXmpCQPGGuvEeaWwimEkSEqz6ircvLsSmjKIgydtkAK54Gq+RrFxznTczeeF6nYrarbbJ+QYQqEOLghTmCdz9MdvvfV5FfGrgGh+Yi+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=gJ3yfKPF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 646DB9EV01987201, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778073069; bh=rt3sbhayKEQqD0LAC75z8hvpSBpqnEsXJWvFeCfUGd0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=gJ3yfKPF102MLElsN9qzboVXXcVLIDQsIlcW/VO9FiazSnQAAkKbtX2eBZaFYWxiM
	 fatV1Q73X9igNZuyM6QTLVGIfNMalTG2yij8xr2oBBYbJ2tBJ5LEcWerfhXLxe6LSG
	 ALo9ZiBiHsjiy0OO2kTIVO03Qogo91lyBE3Lak9IxEhdcwy/Ds99q3At5q8TFNcyPP
	 5GIrFf/mm1ny5mTdNlY4CzV6W1GeCSmpuRNxiE4u2ma6pAILJGoTwcBOeSHWWYLPjt
	 cJHhqg1ztfutG8uLKlssDaKg42zPYFjsl6/6WIJbg+oohwuNP6c2zi2LRymUbYfAdD
	 jdDTU96I5JlCg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 646DB9EV01987201
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 6 May 2026 21:11:09 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 6 May 2026 21:11:09 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 6 May 2026 21:11:09 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 6 May 2026 21:11:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 13/14] wifi: rtw89: phy: support PHY status IE-09 GEN2 for RTL8922D
Date: Wed, 6 May 2026 21:09:59 +0800
Message-ID: <20260506131000.1706298-14-pkshih@realtek.com>
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
X-Rspamd-Queue-Id: BA0714DAC33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36023-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:dkim,realtek.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

The format of PHY status IE-10 for RTL8922D is different from earlier
chips. Fortunately only starting bit is different, but the layout is the
same. Get the VHT/HE SIG-A value by corresponding mask accordingly.

The IE-09 format of generation 0 and 1 are totally the same.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 72 +++++++++++++++++++----
 drivers/net/wireless/realtek/rtw89/core.h |  4 +-
 drivers/net/wireless/realtek/rtw89/txrx.h | 23 +++++++-
 3 files changed, 82 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index fddb0c822c28..c21737981b61 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2156,7 +2156,19 @@ static void rtw89_core_parse_phy_status_ie09(struct rtw89_dev *rtwdev,
 					     const struct rtw89_phy_sts_iehdr *iehdr,
 					     struct rtw89_rx_phy_ppdu *phy_ppdu)
 {
-	phy_ppdu->ie09 = (const void *)iehdr;
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+	const union rtw89_phy_sts_ie09 *ie09;
+	u16 ie_len;
+
+	ie09 = (const void *)iehdr;
+
+	if (phy->physt_gen >= 2) {
+		ie_len = rtw89_core_get_phy_status_ie_len(rtwdev, (const void *)iehdr);
+		if (ie_len < sizeof(ie09->gen2))
+			return;
+	}
+
+	phy_ppdu->ie09 = ie09;
 }
 
 static void rtw89_core_parse_phy_status_ie10(struct rtw89_dev *rtwdev,
@@ -3190,7 +3202,8 @@ static void rtw89_core_update_radiotap_vht(struct rtw89_dev *rtwdev,
 					   struct ieee80211_rx_status *rx_status,
 					   struct rtw89_rx_phy_ppdu *phy_ppdu)
 {
-	const struct rtw89_phy_sts_ie09 *ie09;
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+	const union rtw89_phy_sts_ie09 *ie09;
 	struct ieee80211_radiotap_vht *vht;
 	u8 group_id;
 	u32 sig_a1;
@@ -3208,7 +3221,10 @@ static void rtw89_core_update_radiotap_vht(struct rtw89_dev *rtwdev,
 	memset(vht, 0, sizeof(*vht));
 	rx_status->flag |= RX_FLAG_RADIOTAP_VHT;
 
-	sig_a1 = le64_get_bits(ie09->qw0, RTW89_PHY_STS_IE09_VHT_SIG_A1_MASK);
+	if (phy->physt_gen >= 2)
+		sig_a1 = le64_get_bits(ie09->gen2.qw0, RTW89_PHY_STS_IE09_VHT_SIG_A1_MASK_GEN2);
+	else
+		sig_a1 = le64_get_bits(ie09->gen0.qw0, RTW89_PHY_STS_IE09_VHT_SIG_A1_MASK);
 
 	group_id = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_VHT_SIG_A1_GRP_ID);
 	vht->group_id = group_id;
@@ -3233,16 +3249,26 @@ static void rtw89_core_update_radiotap_he_su(struct rtw89_dev *rtwdev,
 					     struct sk_buff *skb,
 					     struct ieee80211_rx_status *rx_status,
 					     struct ieee80211_radiotap_he *he,
-					     const struct rtw89_phy_sts_ie09 *ie09)
+					     const union rtw89_phy_sts_ie09 *ie09)
 {
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
 	u32 sig_a1, sig_a2;
 	u16 t;
 
 	if (!ie09)
 		return;
 
-	sig_a1 = le64_get_bits(ie09->qw0, RTW89_PHY_STS_IE09_HE_SU_SIG_A1_MASK);
-	sig_a2 = le64_get_bits(ie09->qw0, RTW89_PHY_STS_IE09_HE_SU_SIG_A2_MASK);
+	if (phy->physt_gen >= 2) {
+		sig_a1 = le64_get_bits(ie09->gen2.qw0,
+				       RTW89_PHY_STS_IE09_HE_SU_SIG_A1_MASK_GEN2);
+		sig_a2 = le64_get_bits(ie09->gen2.qw0,
+				       RTW89_PHY_STS_IE09_HE_SU_SIG_A2_MASK_GEN2_L0);
+		sig_a2 |= le64_get_bits(ie09->gen2.qw1,
+					RTW89_PHY_STS_IE09_HE_SU_SIG_A2_MASK_GEN2_H6) << 6;
+	} else {
+		sig_a1 = le64_get_bits(ie09->gen0.qw0, RTW89_PHY_STS_IE09_HE_SU_SIG_A1_MASK);
+		sig_a2 = le64_get_bits(ie09->gen0.qw0, RTW89_PHY_STS_IE09_HE_SU_SIG_A2_MASK);
+	}
 
 	he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_BEAM_CHANGE_KNOWN |
 				 IEEE80211_RADIOTAP_HE_DATA1_UL_DL_KNOWN |
@@ -3295,16 +3321,26 @@ static void rtw89_core_update_radiotap_he_tb(struct rtw89_dev *rtwdev,
 					     struct sk_buff *skb,
 					     struct ieee80211_rx_status *rx_status,
 					     struct ieee80211_radiotap_he *he,
-					     const struct rtw89_phy_sts_ie09 *sig)
+					     const union rtw89_phy_sts_ie09 *sig)
 {
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
 	u32 sig_a1, sig_a2;
 	u16 t;
 
 	if (!sig)
 		return;
 
-	sig_a1 = le64_get_bits(sig->qw0, RTW89_PHY_STS_IE09_HE_TB_SIG_A1_MASK);
-	sig_a2 = le64_get_bits(sig->qw0, RTW89_PHY_STS_IE09_HE_TB_SIG_A2_MASK);
+	if (phy->physt_gen >= 2) {
+		sig_a1 = le64_get_bits(sig->gen2.qw0,
+				       RTW89_PHY_STS_IE09_HE_TB_SIG_A1_MASK_GEN2);
+		sig_a2 = le64_get_bits(sig->gen2.qw0,
+				       RTW89_PHY_STS_IE09_HE_TB_SIG_A2_MASK_GEN2_L0);
+		sig_a2 |= le64_get_bits(sig->gen2.qw1,
+					RTW89_PHY_STS_IE09_HE_TB_SIG_A2_MASK_GEN2_H6);
+	} else {
+		sig_a1 = le64_get_bits(sig->gen0.qw0, RTW89_PHY_STS_IE09_HE_TB_SIG_A1_MASK);
+		sig_a2 = le64_get_bits(sig->gen0.qw0, RTW89_PHY_STS_IE09_HE_TB_SIG_A2_MASK);
+	}
 
 	he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_BSS_COLOR_KNOWN |
 				 IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE_KNOWN |
@@ -3445,9 +3481,10 @@ static void rtw89_core_update_radiotap_he_mu(struct rtw89_dev *rtwdev,
 					     struct ieee80211_rx_status *rx_status,
 					     struct ieee80211_radiotap_he *he,
 					     struct ieee80211_radiotap_he_mu *he_mu,
-					     const struct rtw89_phy_sts_ie09 *ie09,
+					     const union rtw89_phy_sts_ie09 *ie09,
 					     const struct rtw89_phy_sts_ie10 *ie10)
 {
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
 	const u8 *c1 = NULL, *c2 = NULL;
 	int n_center_26tone, n_ru, i;
 	bool doppler, comp;
@@ -3468,8 +3505,17 @@ static void rtw89_core_update_radiotap_he_mu(struct rtw89_dev *rtwdev,
 				 IEEE80211_RADIOTAP_HE_DATA2_PRE_FEC_PAD_KNOWN |
 				 IEEE80211_RADIOTAP_HE_DATA2_PE_DISAMBIG_KNOWN);
 
-	sig_a1 = le64_get_bits(ie09->qw0, RTW89_PHY_STS_IE09_HE_MU_SIG_A1_MASK);
-	sig_a2 = le64_get_bits(ie09->qw0, RTW89_PHY_STS_IE09_HE_MU_SIG_A2_MASK);
+	if (phy->physt_gen >= 2) {
+		sig_a1 = le64_get_bits(ie09->gen2.qw0,
+				       RTW89_PHY_STS_IE09_HE_MU_SIG_A1_MASK_GEN2);
+		sig_a2 = le64_get_bits(ie09->gen2.qw0,
+				       RTW89_PHY_STS_IE09_HE_MU_SIG_A2_MASK_GEN2_L0);
+		sig_a2 |= le64_get_bits(ie09->gen2.qw1,
+					RTW89_PHY_STS_IE09_HE_MU_SIG_A2_MASK_GEN2_H6) << 6;
+	} else {
+		sig_a1 = le64_get_bits(ie09->gen0.qw0, RTW89_PHY_STS_IE09_HE_MU_SIG_A1_MASK);
+		sig_a2 = le64_get_bits(ie09->gen0.qw0, RTW89_PHY_STS_IE09_HE_MU_SIG_A2_MASK);
+	}
 
 	t = u32_get_bits(sig_a1, RTW89_PHY_STS_IE09_HE_MU_SIG_A1_ULDL);
 	he->data3 |= le16_encode_bits(t, IEEE80211_RADIOTAP_HE_DATA3_UL_DL);
@@ -3593,7 +3639,7 @@ static void rtw89_core_update_radiotap_he(struct rtw89_dev *rtwdev,
 		.data2 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_GI_KNOWN),
 	};
 	struct ieee80211_radiotap_he_mu *he_mu = NULL;
-	const struct rtw89_phy_sts_ie09 *ie09;
+	const union rtw89_phy_sts_ie09 *ie09;
 	const struct rtw89_phy_sts_ie10 *ie10;
 	struct ieee80211_radiotap_he *he;
 	u16 he_format;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b85d7fa4296a..a6dee97d99f2 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -24,7 +24,7 @@ struct rtw89_h2c_rf_tssi;
 struct rtw89_fw_txpwr_track_cfg;
 struct rtw89_phy_rfk_log_fmt;
 struct rtw89_phy_calc_efuse_gain;
-struct rtw89_phy_sts_ie09;
+union rtw89_phy_sts_ie09;
 struct rtw89_phy_sts_ie10;
 struct rtw89_debugfs;
 struct rtw89_regd_data;
@@ -867,7 +867,7 @@ struct rtw89_rx_phy_ppdu {
 	bool to_self;
 	bool valid;
 	bool hdr_2_en;
-	const struct rtw89_phy_sts_ie09 *ie09; /* SIG-A */
+	const union rtw89_phy_sts_ie09 *ie09; /* SIG-A */
 	const struct rtw89_phy_sts_ie10 *ie10; /* SIG-B */
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index 4a567d3fe3f7..4e7109fbe7c9 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -658,15 +658,23 @@ struct rtw89_phy_sts_ie01_v2 {
 #define RTW89_PHY_STS_IE01_V2_W9_RPL_FD_C GENMASK(11, 4)
 #define RTW89_PHY_STS_IE01_V2_W9_RPL_FD_D GENMASK(23, 16)
 
-struct rtw89_phy_sts_ie09 {
-	__le64 qw0;
+union rtw89_phy_sts_ie09 {
+	struct {
+		__le64 qw0;
+	} gen0;
+	struct {
+		__le64 qw0;
+		__le64 qw1;
+	} gen2;
 } __packed;
 
 #define RTW89_PHY_STS_IE09_L_SIG_MASK GENMASK(21, 5) /* Legacy/VHT/HE L-SIG */
+#define RTW89_PHY_STS_IE09_L_SIG_MASK_GEN2 GENMASK(31, 15) /* Legacy/VHT/HE L-SIG for GEN2 */
 #define RTW89_PHY_STS_IE09_L_SIG_RATE GENMASK(3, 0)
 #define RTW89_PHY_STS_IE09_L_SIG_RSVD BIT(4)
 #define RTW89_PHY_STS_IE09_L_SIG_LENGTH GENMASK(16, 5)
 #define RTW89_PHY_STS_IE09_VHT_SIG_A1_MASK GENMASK_ULL(45, 22) /* VHT SIG-A1 */
+#define RTW89_PHY_STS_IE09_VHT_SIG_A1_MASK_GEN2 GENMASK_ULL(55, 32) /* VHT SIG-A1 for GEN2 */
 #define RTW89_PHY_STS_IE09_VHT_SIG_A1_BW GENMASK(1, 0)
 #define RTW89_PHY_STS_IE09_VHT_SIG_A1_RSVD1 BIT(2)
 #define RTW89_PHY_STS_IE09_VHT_SIG_A1_STBC BIT(3)
@@ -680,6 +688,8 @@ struct rtw89_phy_sts_ie09 {
 #define RTW89_PHY_STS_IE09_VHT_SIG_A1_TXOP_NOPS BIT(22)
 #define RTW89_PHY_STS_IE09_VHT_SIG_A1_RSVD2 BIT(23)
 #define RTW89_PHY_STS_IE09_VHT_SIG_A2_MASK GENMASK_ULL(55, 46) /* VHT SIG-A2 */
+#define RTW89_PHY_STS_IE09_VHT_SIG_A2_MASK_GEN2_L0 GENMASK_ULL(63, 56) /* VHT SIG-A2 for GEN2 */
+#define RTW89_PHY_STS_IE09_VHT_SIG_A2_MASK_GEN2_H8 GENMASK_ULL(1, 0) /* VHT SIG-A2 for GEN2 */
 #define RTW89_PHY_STS_IE09_VHT_SIG_A2_SGI BIT(0)
 #define RTW89_PHY_STS_IE09_VHT_SIG_A2_SGI_DISA BIT(1)
 #define RTW89_PHY_STS_IE09_VHT_SIG_A2_SUMU_CODE0 BIT(2)
@@ -688,6 +698,7 @@ struct rtw89_phy_sts_ie09 {
 #define RTW89_PHY_STS_IE09_VHT_SIG_A2_BF BIT(8)
 #define RTW89_PHY_STS_IE09_VHT_SIG_A2_RSVD3 BIT(9)
 #define RTW89_PHY_STS_IE09_HE_SU_SIG_A1_MASK GENMASK_ULL(47, 22) /* HE SU SIG-A1 */
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A1_MASK_GEN2 GENMASK_ULL(57, 32) /* HE SU SIG-A1 for GEN2 */
 #define RTW89_PHY_STS_IE09_HE_SU_SIG_A1_FORMAT BIT(0)
 #define RTW89_PHY_STS_IE09_HE_SU_SIG_A1_BEAM_CHANGE BIT(1)
 #define RTW89_PHY_STS_IE09_HE_SU_SIG_A1_ULDL BIT(2)
@@ -700,6 +711,8 @@ struct rtw89_phy_sts_ie09 {
 #define RTW89_PHY_STS_IE09_HE_SU_SIG_A1_GILTF GENMASK(22, 21)
 #define RTW89_PHY_STS_IE09_HE_SU_SIG_A1_NSTS GENMASK(25, 23)
 #define RTW89_PHY_STS_IE09_HE_SU_SIG_A2_MASK GENMASK_ULL(63, 48) /* HE SU SIG-A2 */
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A2_MASK_GEN2_L0 GENMASK_ULL(63, 58) /* HE SU SIG-A2 for GEN2 */
+#define RTW89_PHY_STS_IE09_HE_SU_SIG_A2_MASK_GEN2_H6 GENMASK_ULL(9, 0) /* HE SU SIG-A2 for GEN2 */
 #define RTW89_PHY_STS_IE09_HE_SU_SIG_A2_TXOP GENMASK(6, 0)
 #define RTW89_PHY_STS_IE09_HE_SU_SIG_A2_CODING BIT(7)
 #define RTW89_PHY_STS_IE09_HE_SU_SIG_A2_LDPC_XSYMSEG BIT(8)
@@ -710,6 +723,7 @@ struct rtw89_phy_sts_ie09 {
 #define RTW89_PHY_STS_IE09_HE_SU_SIG_A2_RSVD2 BIT(14)
 #define RTW89_PHY_STS_IE09_HE_SU_SIG_A2_DOPPLER BIT(15)
 #define RTW89_PHY_STS_IE09_HE_TB_SIG_A1_MASK GENMASK_ULL(47, 22) /* HE TB SIG-A1 */
+#define RTW89_PHY_STS_IE09_HE_TB_SIG_A1_MASK_GEN2 GENMASK_ULL(57, 32) /* HE TB SIG-A1 for GEN2 */
 #define RTW89_PHY_STS_IE09_HE_TB_SIG_A1_FORMAT BIT(0)
 #define RTW89_PHY_STS_IE09_HE_TB_SIG_A1_BSS_COLOR GENMASK(6, 1)
 #define RTW89_PHY_STS_IE09_HE_TB_SIG_A1_SB1 GENMASK(10, 7)
@@ -719,9 +733,12 @@ struct rtw89_phy_sts_ie09 {
 #define RTW89_PHY_STS_IE09_HE_TB_SIG_A1_RSVD1 BIT(23)
 #define RTW89_PHY_STS_IE09_HE_TB_SIG_A1_BW GENMASK(25, 24)
 #define RTW89_PHY_STS_IE09_HE_TB_SIG_A2_MASK GENMASK_ULL(63, 48) /* HE TB SIG-A2 */
+#define RTW89_PHY_STS_IE09_HE_TB_SIG_A2_MASK_GEN2_L0 GENMASK_ULL(63, 58) /* HE TB SIG-A2 for GEN2 */
+#define RTW89_PHY_STS_IE09_HE_TB_SIG_A2_MASK_GEN2_H6 GENMASK_ULL(9, 0) /* HE TB SIG-A2 for GEN2 */
 #define RTW89_PHY_STS_IE09_HE_TB_SIG_A2_TXOP GENMASK(6, 0)
 #define RTW89_PHY_STS_IE09_HE_TB_SIG_A2_RSVD1 GENMASK(15, 7)
 #define RTW89_PHY_STS_IE09_HE_MU_SIG_A1_MASK GENMASK_ULL(47, 22) /* HE MU SIG-A1 */
+#define RTW89_PHY_STS_IE09_HE_MU_SIG_A1_MASK_GEN2 GENMASK_ULL(57, 32) /* HE MU SIG-A1 for GEN2 */
 #define RTW89_PHY_STS_IE09_HE_MU_SIG_A1_ULDL BIT(0)
 #define RTW89_PHY_STS_IE09_HE_MU_SIG_A1_SIGB_MCS GENMASK(3, 1)
 #define RTW89_PHY_STS_IE09_HE_MU_SIG_A1_SIGB_DCM BIT(4)
@@ -733,6 +750,8 @@ struct rtw89_phy_sts_ie09 {
 #define RTW89_PHY_STS_IE09_HE_MU_SIG_A1_GI_LTF GENMASK(24, 23)
 #define RTW89_PHY_STS_IE09_HE_MU_SIG_A1_DOPPLER BIT(25)
 #define RTW89_PHY_STS_IE09_HE_MU_SIG_A2_MASK GENMASK_ULL(63, 48) /* HE MU SIG-A2 */
+#define RTW89_PHY_STS_IE09_HE_MU_SIG_A2_MASK_GEN2_L0 GENMASK_ULL(63, 58) /* HE MU SIG-A2 for GEN2 */
+#define RTW89_PHY_STS_IE09_HE_MU_SIG_A2_MASK_GEN2_H6 GENMASK_ULL(9, 0) /* HE MU SIG-A2 for GEN2 */
 #define RTW89_PHY_STS_IE09_HE_MU_SIG_A2_TXOP GENMASK(6, 0)
 #define RTW89_PHY_STS_IE09_HE_MU_SIG_A2_RSVD BIT(7)
 #define RTW89_PHY_STS_IE09_HE_MU_SIG_A2_LTF_MID GENMASK(10, 8)
-- 
2.25.1


