Return-Path: <linux-wireless+bounces-12464-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4B396B46C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 10:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4918B276D0
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 08:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95FD18732F;
	Wed,  4 Sep 2024 08:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="l6cRbhUj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78D7187325
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438095; cv=none; b=MAC/C+2LGiddaaOQPcESSDu0TUj1iFKq69+xlYDBqwXOpzdaytzadhnggJ/OR+MEg3Rg4eT8NevkD+fxEH/8Xl3PCHaVgvVnRVihFPnGyD8B5byQUOHrOd2JYx6jfQJw6htTVdg85XoOgOuk6n7m8+7T17Dp681hb7kTffrHtBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438095; c=relaxed/simple;
	bh=zwexA7QA8ZQuV4njlArLWG14EC+0QVDEFT8n7yP9aug=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Iy0NRMdt8siDqM48GGv4tbpuDmBUqt9Sv2f5rUBNS9g+rEVPf2c+NZENW6GL7ZmnZaZCCr+aF9cxkVInua69a6gsVcFQFIjVArF7V5hmdyDN9/OIlDL6lsYDIcHmKj6+bDAKT/sA/u91emJyVMFUFpfmSCF26Xo+tphuejJzxJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=l6cRbhUj; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: abd834d26a9611ef8b96093e013ec31c-20240904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=RGoKtXGhFRvA43iHeqpp1zH38L0V9PQaJEueQf9bljk=;
	b=l6cRbhUjeKH0B6m5htTCXIX3bB/V+cl02qF9PGdFluU+eEBDAwBkLiWfCtBqWV9IhB8r37WBA0sdBMjkvZZAat+NC5pP6+O18dE4AXNHtl41wCtMw5fl/gad2R5007NRLZ6rL/ATf885BHT4hN4RqYsURIPSTimNd2toOQsS+9w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:8356ce2a-15c0-4963-a739-a7208c213e9e,IP:0,U
	RL:0,TC:0,Content:34,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:34
X-CID-META: VersionHash:6dc6a47,CLOUDID:89f6abcf-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: abd834d26a9611ef8b96093e013ec31c-20240904
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 287802252; Wed, 04 Sep 2024 16:21:23 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 4 Sep 2024 16:21:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 4 Sep 2024 16:21:21 +0800
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
	<quan.zhou@mediatek.com>, Ming Yen Hsieh <MingYen.Hsieh@mediatek.com>
Subject: [PATCH v3] wifi: mac80211: introduce EHT rate support in AQL airtime
Date: Wed, 4 Sep 2024 16:21:09 +0800
Message-ID: <20240904082109.4339-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-0.920200-8.000000
X-TMASE-MatchedRID: 7LSGhW1Vq0aGeTbGWdRz1u7KTDtx8CggojQrbrPpzzpF+YXPIqAdvlmE
	vDqzEeg3sThZ10FHnFGE8dia6GlRD294Ipa1otxo4vPWjjRvIiq4pLI6MoPBuED0B37vQ26TrWv
	A11V1iKnZoTly3PGW4L3HkclgTlsWKerAqZTShjMWny127IX6IH6KoWUwYBEPtWFMPVR2Crynci
	ta11QPxZoBkr4qgGPCgDLqnrRlXrZ8nn9tnqel2MprJP8FBOIaiQxw9a3yYufV2suOiFdeNgzMT
	rh0Ci0D22M283UcFzM3dONe5A9bBu+M6VEvD3ckuTiLKtWfq3YoknVW/QAjiplG1vToQG8pxCbc
	O+QiMtt0BNB20+SxH7f8mJY57oZddJaBDYald1n0PpssEkz020MMprcbiest
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-0.920200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 1125126D1A5E73668301381701A2B891547FE368F4EE65784F2CD62AFAFEC2BF2000:8

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Add definitions related to EHT mode and airtime calculation
according to the 802.11BE_D4.0.

Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Signed-off-by: Ming Yen Hsieh <MingYen.Hsieh@mediatek.com>
---
v2:
 - add BW_320 support in ieee80211_get_rate_duration().
 - rewrite the existing WARN_ON for property stream condition.
v3:
 - add a macro EHT_GROUP_RANGE() to reduce the line which repetitive the EHT_GROUP().
 - to comply with the current use of EHT streams, the WARN_ON check has been modified
   to be consistent with HE.
---
 net/mac80211/airtime.c | 138 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 133 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
index fdf8b658fede..7801b361db98 100644
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
+#define IEEE80211_EHT_MAX_STREAMS	16
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
@@ -203,6 +223,77 @@
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
+	EHT_GROUP(8, _gi, _bw),		\
+	EHT_GROUP(9, _gi, _bw),		\
+	EHT_GROUP(10, _gi, _bw),	\
+	EHT_GROUP(11, _gi, _bw),	\
+	EHT_GROUP(12, _gi, _bw),	\
+	EHT_GROUP(13, _gi, _bw),	\
+	EHT_GROUP(14, _gi, _bw),	\
+	EHT_GROUP(15, _gi, _bw),	\
+	EHT_GROUP(16, _gi, _bw)
+
 struct mcs_group {
 	u8 shift;
 	u16 duration[MCS_GROUP_RATES];
@@ -376,6 +467,26 @@ static const struct mcs_group airtime_mcs_groups[] = {
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
@@ -422,6 +533,9 @@ static u32 ieee80211_get_rate_duration(struct ieee80211_hw *hw,
 	case RATE_INFO_BW_160:
 		bw = BW_160;
 		break;
+	case RATE_INFO_BW_320:
+		bw = BW_320;
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -443,13 +557,18 @@ static u32 ieee80211_get_rate_duration(struct ieee80211_hw *hw,
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
+	if (WARN_ON_ONCE((status->encoding > RX_ENC_HE && streams > 8) ||
+			 (status->encoding < RX_ENC_HE && streams > 4)))
 		return 0;
 
 	if (idx >= MCS_GROUP_RATES)
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
2.45.2


