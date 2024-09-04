Return-Path: <linux-wireless+bounces-12475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D046C96B9F2
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 13:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4D61F21F52
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 11:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243781CFECA;
	Wed,  4 Sep 2024 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VKccHo7u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3081CFEC2
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448398; cv=none; b=N8ngdxwd6d6j+Od/t4ahBHdIBFcX+fnuFDi71MvnS/gJitVntcdmdPV6UCSLPRFh7zQJ2yy6TW0Ai7Ib0zTBgvMG8VABYZq1M79T0gAU4Rn5zzPv9MrkntrdcNRSmDUDKBi7oelHVgVsiePUduwuamQlz0yLNv65vqFTIL89WWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448398; c=relaxed/simple;
	bh=fQxSUxdZmadUrspQZnhV5v/COAMgclUmJA1Gka5h49w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R6ZbzvFa/CyC0GnPtUjezZEOaiNV8ll/wGnYGna6utakLWEGnTF73/1xMwHRm9pgAQbF4FNI8ftkTCjHvlskAiuIYFJU9QPKS3x5kvI/uIkVJAX2B5y7+DP2WjXh58pXW0zVpzuQG6+LRabQEvLeUmz6XsXR8S/3VtBoiiip7q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VKccHo7u; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a5495a706aae11ef8b96093e013ec31c-20240904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=HESMGutimECO7wRTLpcnVcd1uPlr9AHsGq0msCqFBt8=;
	b=VKccHo7uKYv4Xnfh3uts0UDbmfaA9Qo6tsZU/239X0jb540c27OCCtoIUyKXkzY2DB4dCA1K7UqOCQLVWdidiv+xjw+KBeoaOZCbDUyfKzB5LnDHntJBqBQ6PhByRZWLgm7pbE2ELJ0g67gr+NUZl4ICYt2snnw0pHyPujHS5rI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:b9f8edcd-af2c-49b5-8a69-6b5398b84c06,IP:0,U
	RL:0,TC:0,Content:33,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:33
X-CID-META: VersionHash:6dc6a47,CLOUDID:28662d05-42cd-428b-a1e3-ab5b763cfa17,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: a5495a706aae11ef8b96093e013ec31c-20240904
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 579576276; Wed, 04 Sep 2024 19:13:00 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 4 Sep 2024 19:13:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 4 Sep 2024 19:13:00 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <johannes@sipsolutions.net>, <jonas.gorski@gmail.com>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Michael.Lo@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
	<posh.sun@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, Quan Zhou
	<quan.zhou@mediatek.com>
Subject: [PATCH v5] wifi: mac80211: introduce EHT rate support in AQL airtime
Date: Wed, 4 Sep 2024 19:12:56 +0800
Message-ID: <20240904111256.11734-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Add definitions related to EHT mode and airtime calculation
according to the 802.11BE_D4.0.

Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
v2:
 - add BW_320 support in ieee80211_get_rate_duration().
 - rewrite the existing WARN_ON for property stream condition.
v3:
 - add a macro EHT_GROUP_RANGE() to reduce the line which repetitive the EHT_GROUP().
 - to comply with the current use of EHT streams, the WARN_ON check has been modified
   to be consistent with HE. 
v4:
 - change IEEE80211_EHT_MAX_STREAMS 16 to 8.
v5:
 - use switch-case instead of if-else for stream check.
---
 net/mac80211/airtime.c | 140 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 134 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
index fdf8b658fede..c61df637232a 100644
--- a/net/mac80211/airtime.c
+++ b/net/mac80211/airtime.c
@@ -55,10 +55,21 @@
 #define HE_DURATION_S(shift, streams, gi, bps)		\
 	(HE_DURATION(streams, gi, bps) >> shift)
 
+/* gi in HE/EHT is identical. It matches enum nl80211_eht_gi as well */
+#define EHT_GI_08 HE_GI_08
+#define EHT_GI_16 HE_GI_16
+#define EHT_GI_32 HE_GI_32
+
+#define EHT_DURATION(streams, gi, bps)			\
+	HE_DURATION(streams, gi, bps)
+#define EHT_DURATION_S(shift, streams, gi, bps)		\
+	HE_DURATION_S(shift, streams, gi, bps)
+
 #define BW_20			0
 #define BW_40			1
 #define BW_80			2
 #define BW_160			3
+#define BW_320			4
 
 /*
  * Define group sort order: HT40 -> SGI -> #streams
@@ -68,17 +79,26 @@
 #define IEEE80211_VHT_STREAM_GROUPS	8 /* BW(=4) * SGI(=2) */
 
 #define IEEE80211_HE_MAX_STREAMS	8
+#define IEEE80211_HE_STREAM_GROUPS	12 /* BW(=4) * GI(=3) */
+
+#define IEEE80211_EHT_MAX_STREAMS	8
+#define IEEE80211_EHT_STREAM_GROUPS	15 /* BW(=5) * GI(=3) */
 
 #define IEEE80211_HT_GROUPS_NB	(IEEE80211_MAX_STREAMS *	\
 				 IEEE80211_HT_STREAM_GROUPS)
 #define IEEE80211_VHT_GROUPS_NB	(IEEE80211_MAX_STREAMS *	\
 					 IEEE80211_VHT_STREAM_GROUPS)
+#define IEEE80211_HE_GROUPS_NB	(IEEE80211_HE_MAX_STREAMS *	\
+				 IEEE80211_HE_STREAM_GROUPS)
+#define IEEE80211_EHT_GROUPS_NB	(IEEE80211_EHT_MAX_STREAMS *	\
+				 IEEE80211_EHT_STREAM_GROUPS)
 
 #define IEEE80211_HT_GROUP_0	0
 #define IEEE80211_VHT_GROUP_0	(IEEE80211_HT_GROUP_0 + IEEE80211_HT_GROUPS_NB)
 #define IEEE80211_HE_GROUP_0	(IEEE80211_VHT_GROUP_0 + IEEE80211_VHT_GROUPS_NB)
+#define IEEE80211_EHT_GROUP_0	(IEEE80211_HE_GROUP_0 + IEEE80211_HE_GROUPS_NB)
 
-#define MCS_GROUP_RATES		12
+#define MCS_GROUP_RATES		14
 
 #define HT_GROUP_IDX(_streams, _sgi, _ht40)	\
 	IEEE80211_HT_GROUP_0 +			\
@@ -203,6 +223,69 @@
 #define HE_GROUP(_streams, _gi, _bw)					\
 	__HE_GROUP(_streams, _gi, _bw,				\
 		   HE_GROUP_SHIFT(_streams, _gi, _bw))
+
+#define EHT_BW2VBPS(_bw, r5, r4, r3, r2, r1)					\
+	((_bw) == BW_320 ? r5 : BW2VBPS(_bw, r4, r3, r2, r1))
+
+#define EHT_GROUP_IDX(_streams, _gi, _bw)				\
+	(IEEE80211_EHT_GROUP_0 +					\
+	 IEEE80211_EHT_MAX_STREAMS * 3 * (_bw) +			\
+	 IEEE80211_EHT_MAX_STREAMS * (_gi) +				\
+	 (_streams) - 1)
+
+#define __EHT_GROUP(_streams, _gi, _bw, _s)						\
+	[EHT_GROUP_IDX(_streams, _gi, _bw)] = {						\
+	.shift = _s,									\
+	.duration = {									\
+		EHT_DURATION_S(_s, _streams, _gi,					\
+			       EHT_BW2VBPS(_bw,  1960,   980,  490,  234,  117)),	\
+		EHT_DURATION_S(_s, _streams, _gi,					\
+			       EHT_BW2VBPS(_bw,  3920,  1960,  980,  468,  234)),	\
+		EHT_DURATION_S(_s, _streams, _gi,					\
+			       EHT_BW2VBPS(_bw,  5880,  2937, 1470,  702,  351)),	\
+		EHT_DURATION_S(_s, _streams, _gi,					\
+			       EHT_BW2VBPS(_bw,  7840,  3920, 1960,  936,  468)),	\
+		EHT_DURATION_S(_s, _streams, _gi,					\
+			       EHT_BW2VBPS(_bw, 11760,  5880, 2940, 1404,  702)),	\
+		EHT_DURATION_S(_s, _streams, _gi,					\
+			       EHT_BW2VBPS(_bw, 15680,  7840, 3920, 1872,  936)),	\
+		EHT_DURATION_S(_s, _streams, _gi,					\
+			       EHT_BW2VBPS(_bw, 17640,  8820, 4410, 2106, 1053)),	\
+		EHT_DURATION_S(_s, _streams, _gi,					\
+			       EHT_BW2VBPS(_bw, 19600,  9800, 4900, 2340, 1170)),	\
+		EHT_DURATION_S(_s, _streams, _gi,					\
+			       EHT_BW2VBPS(_bw, 23520, 11760, 5880, 2808, 1404)),	\
+		EHT_DURATION_S(_s, _streams, _gi,					\
+			       EHT_BW2VBPS(_bw, 26133, 13066, 6533, 3120, 1560)),	\
+		EHT_DURATION_S(_s, _streams, _gi,					\
+			       EHT_BW2VBPS(_bw, 29400, 14700, 7350, 3510, 1755)),	\
+		EHT_DURATION_S(_s, _streams, _gi,					\
+			       EHT_BW2VBPS(_bw, 32666, 16333, 8166, 3900, 1950)),	\
+		EHT_DURATION_S(_s, _streams, _gi,					\
+			       EHT_BW2VBPS(_bw, 35280, 17640, 8820, 4212, 2106)),	\
+		EHT_DURATION_S(_s, _streams, _gi,					\
+			       EHT_BW2VBPS(_bw, 39200, 19600, 9800, 4680, 2340))	\
+		}									\
+}
+
+#define EHT_GROUP_SHIFT(_streams, _gi, _bw)						\
+	GROUP_SHIFT(EHT_DURATION(_streams, _gi,						\
+				 EHT_BW2VBPS(_bw, 1960, 980, 490, 234, 117)))
+
+#define EHT_GROUP(_streams, _gi, _bw)					\
+	__EHT_GROUP(_streams, _gi, _bw,				\
+		   EHT_GROUP_SHIFT(_streams, _gi, _bw))
+
+#define EHT_GROUP_RANGE(_gi, _bw)	\
+	EHT_GROUP(1, _gi, _bw),		\
+	EHT_GROUP(2, _gi, _bw),		\
+	EHT_GROUP(3, _gi, _bw),		\
+	EHT_GROUP(4, _gi, _bw),		\
+	EHT_GROUP(5, _gi, _bw),		\
+	EHT_GROUP(6, _gi, _bw),		\
+	EHT_GROUP(7, _gi, _bw),		\
+	EHT_GROUP(8, _gi, _bw)
+
 struct mcs_group {
 	u8 shift;
 	u16 duration[MCS_GROUP_RATES];
@@ -376,6 +459,26 @@ static const struct mcs_group airtime_mcs_groups[] = {
 	HE_GROUP(6, HE_GI_32, BW_160),
 	HE_GROUP(7, HE_GI_32, BW_160),
 	HE_GROUP(8, HE_GI_32, BW_160),
+
+	EHT_GROUP_RANGE(EHT_GI_08, BW_20),
+	EHT_GROUP_RANGE(EHT_GI_16, BW_20),
+	EHT_GROUP_RANGE(EHT_GI_32, BW_20),
+
+	EHT_GROUP_RANGE(EHT_GI_08, BW_40),
+	EHT_GROUP_RANGE(EHT_GI_16, BW_40),
+	EHT_GROUP_RANGE(EHT_GI_32, BW_40),
+
+	EHT_GROUP_RANGE(EHT_GI_08, BW_80),
+	EHT_GROUP_RANGE(EHT_GI_16, BW_80),
+	EHT_GROUP_RANGE(EHT_GI_32, BW_80),
+
+	EHT_GROUP_RANGE(EHT_GI_08, BW_160),
+	EHT_GROUP_RANGE(EHT_GI_16, BW_160),
+	EHT_GROUP_RANGE(EHT_GI_32, BW_160),
+
+	EHT_GROUP_RANGE(EHT_GI_08, BW_320),
+	EHT_GROUP_RANGE(EHT_GI_16, BW_320),
+	EHT_GROUP_RANGE(EHT_GI_32, BW_320),
 };
 
 static u32
@@ -422,6 +525,9 @@ static u32 ieee80211_get_rate_duration(struct ieee80211_hw *hw,
 	case RATE_INFO_BW_160:
 		bw = BW_160;
 		break;
+	case RATE_INFO_BW_320:
+		bw = BW_320;
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -443,14 +549,27 @@ static u32 ieee80211_get_rate_duration(struct ieee80211_hw *hw,
 		idx = status->rate_idx;
 		group = HE_GROUP_IDX(streams, status->he_gi, bw);
 		break;
+	case RX_ENC_EHT:
+		streams = status->nss;
+		idx = status->rate_idx;
+		group = EHT_GROUP_IDX(streams, status->eht.gi, bw);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
 	}
 
-	if (WARN_ON_ONCE((status->encoding != RX_ENC_HE && streams > 4) ||
-			 (status->encoding == RX_ENC_HE && streams > 8)))
-		return 0;
+	switch (status->encoding) {
+	case RX_ENC_EHT:
+	case RX_ENC_HE:
+		if (WARN_ON_ONCE(streams > 8))
+			return 0;
+		break;
+	default:
+		if (WARN_ON_ONCE(streams > 4))
+			return 0;
+		break;
+	}
 
 	if (idx >= MCS_GROUP_RATES)
 		return 0;
@@ -517,7 +636,9 @@ static bool ieee80211_fill_rate_info(struct ieee80211_hw *hw,
 	stat->nss = ri->nss;
 	stat->rate_idx = ri->mcs;
 
-	if (ri->flags & RATE_INFO_FLAGS_HE_MCS)
+	if (ri->flags & RATE_INFO_FLAGS_EHT_MCS)
+		stat->encoding = RX_ENC_EHT;
+	else if (ri->flags & RATE_INFO_FLAGS_HE_MCS)
 		stat->encoding = RX_ENC_HE;
 	else if (ri->flags & RATE_INFO_FLAGS_VHT_MCS)
 		stat->encoding = RX_ENC_VHT;
@@ -529,7 +650,14 @@ static bool ieee80211_fill_rate_info(struct ieee80211_hw *hw,
 	if (ri->flags & RATE_INFO_FLAGS_SHORT_GI)
 		stat->enc_flags |= RX_ENC_FLAG_SHORT_GI;
 
-	stat->he_gi = ri->he_gi;
+	switch (stat->encoding) {
+	case RX_ENC_EHT:
+		stat->eht.gi = ri->eht_gi;
+		break;
+	default:
+		stat->he_gi = ri->he_gi;
+		break;
+	}
 
 	if (stat->encoding != RX_ENC_LEGACY)
 		return true;
-- 
2.25.1


