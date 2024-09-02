Return-Path: <linux-wireless+bounces-12307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF6D967EE3
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 07:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696F11C218C5
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 05:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBB1195;
	Mon,  2 Sep 2024 05:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iQqotS0J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABDB144D0A
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 05:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725255881; cv=none; b=t4asd++oYCxna9FsSoMeb3eLt2RD709Km+KWXg6lvQTJ20KzJeGDfu+kmQPLCJOpZvlNOulh+svjUhX7loMr3BLAHBFj4GmSQbOXYXPMB6/29n+6d0eoZWMryNIrBUSrSeiNRS3HURds71SVG6wa6Y+VzrMFjretEZ7Jt8cSVu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725255881; c=relaxed/simple;
	bh=3ersn6/9ELgM4uQeWUUxLp72mTnhLjrfNdxMvrBWHpg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qCcwMFqnT/JsuE3i75LErwd5CK6I1Pxn/t1xvgh0VKuigFjJmOI9NIq/qSKkWglp9i+YgHceEWEQ+fXJb6B8xHsIPUXpMG4Fm4pQQ/mKwQu6HJ+B8z2vCRmmPIsfU893fnHbrW2zPTbPQiE7jY/mMAMxHp/6NpJowa1XJ5nP09o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=iQqotS0J; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6c25d2a868ee11ef8593d301e5c8a9c0-20240902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=SA8cM8CLfvKePwSRzt6T3y/YIArr8lXvjnWU01EPMoM=;
	b=iQqotS0JpCGWYOl82ZTiPyM+zWzHcMFd2L/wQqCdudW5r3jtxlFWSLYkRjmE7BdTWsMwzkxtsfq+TxfN2+STC2qhta9hIyudJpkn9E+pvmCRzuqMXhie83mrKNSBNT1UFPubDVE+W2STe/TROqjCwP1N7oZHeLhkxc62apD9Bs0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:58d8a5f8-801b-4ffc-ae6e-2860d6b4da74,IP:0,U
	RL:0,TC:0,Content:39,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:39
X-CID-META: VersionHash:6dc6a47,CLOUDID:a0c64bbf-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6c25d2a868ee11ef8593d301e5c8a9c0-20240902
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 670572861; Mon, 02 Sep 2024 13:44:29 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 1 Sep 2024 22:44:30 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 2 Sep 2024 13:44:30 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <jonas.gorski@gmail.com>, <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Michael.Lo@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
	<posh.sun@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, Quan Zhou
	<quan.zhou@mediatek.com>
Subject: [PATCH v2] wifi: mac80211: introduce EHT rate support in AQL airtime
Date: Mon, 2 Sep 2024 13:44:28 +0800
Message-ID: <20240902054428.13273-1-mingyen.hsieh@mediatek.com>
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
---
 net/mac80211/airtime.c | 356 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 351 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
index fdf8b658fede..920718640962 100644
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
@@ -203,6 +223,59 @@
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
 struct mcs_group {
 	u8 shift;
 	u16 duration[MCS_GROUP_RATES];
@@ -376,6 +449,261 @@ static const struct mcs_group airtime_mcs_groups[] = {
 	HE_GROUP(6, HE_GI_32, BW_160),
 	HE_GROUP(7, HE_GI_32, BW_160),
 	HE_GROUP(8, HE_GI_32, BW_160),
+
+	EHT_GROUP(1, EHT_GI_08, BW_20),
+	EHT_GROUP(2, EHT_GI_08, BW_20),
+	EHT_GROUP(3, EHT_GI_08, BW_20),
+	EHT_GROUP(4, EHT_GI_08, BW_20),
+	EHT_GROUP(5, EHT_GI_08, BW_20),
+	EHT_GROUP(6, EHT_GI_08, BW_20),
+	EHT_GROUP(7, EHT_GI_08, BW_20),
+	EHT_GROUP(8, EHT_GI_08, BW_20),
+	EHT_GROUP(9, EHT_GI_08, BW_20),
+	EHT_GROUP(10, EHT_GI_08, BW_20),
+	EHT_GROUP(11, EHT_GI_08, BW_20),
+	EHT_GROUP(12, EHT_GI_08, BW_20),
+	EHT_GROUP(13, EHT_GI_08, BW_20),
+	EHT_GROUP(14, EHT_GI_08, BW_20),
+	EHT_GROUP(15, EHT_GI_08, BW_20),
+	EHT_GROUP(16, EHT_GI_08, BW_20),
+
+	EHT_GROUP(1, EHT_GI_16, BW_20),
+	EHT_GROUP(2, EHT_GI_16, BW_20),
+	EHT_GROUP(3, EHT_GI_16, BW_20),
+	EHT_GROUP(4, EHT_GI_16, BW_20),
+	EHT_GROUP(5, EHT_GI_16, BW_20),
+	EHT_GROUP(6, EHT_GI_16, BW_20),
+	EHT_GROUP(7, EHT_GI_16, BW_20),
+	EHT_GROUP(8, EHT_GI_16, BW_20),
+	EHT_GROUP(9, EHT_GI_16, BW_20),
+	EHT_GROUP(10, EHT_GI_16, BW_20),
+	EHT_GROUP(11, EHT_GI_16, BW_20),
+	EHT_GROUP(12, EHT_GI_16, BW_20),
+	EHT_GROUP(13, EHT_GI_16, BW_20),
+	EHT_GROUP(14, EHT_GI_16, BW_20),
+	EHT_GROUP(15, EHT_GI_16, BW_20),
+	EHT_GROUP(16, EHT_GI_16, BW_20),
+
+	EHT_GROUP(1, EHT_GI_32, BW_20),
+	EHT_GROUP(2, EHT_GI_32, BW_20),
+	EHT_GROUP(3, EHT_GI_32, BW_20),
+	EHT_GROUP(4, EHT_GI_32, BW_20),
+	EHT_GROUP(5, EHT_GI_32, BW_20),
+	EHT_GROUP(6, EHT_GI_32, BW_20),
+	EHT_GROUP(7, EHT_GI_32, BW_20),
+	EHT_GROUP(8, EHT_GI_32, BW_20),
+	EHT_GROUP(9, EHT_GI_32, BW_20),
+	EHT_GROUP(10, EHT_GI_32, BW_20),
+	EHT_GROUP(11, EHT_GI_32, BW_20),
+	EHT_GROUP(12, EHT_GI_32, BW_20),
+	EHT_GROUP(13, EHT_GI_32, BW_20),
+	EHT_GROUP(14, EHT_GI_32, BW_20),
+	EHT_GROUP(15, EHT_GI_32, BW_20),
+	EHT_GROUP(16, EHT_GI_32, BW_20),
+
+	EHT_GROUP(1, EHT_GI_08, BW_40),
+	EHT_GROUP(2, EHT_GI_08, BW_40),
+	EHT_GROUP(3, EHT_GI_08, BW_40),
+	EHT_GROUP(4, EHT_GI_08, BW_40),
+	EHT_GROUP(5, EHT_GI_08, BW_40),
+	EHT_GROUP(6, EHT_GI_08, BW_40),
+	EHT_GROUP(7, EHT_GI_08, BW_40),
+	EHT_GROUP(8, EHT_GI_08, BW_40),
+	EHT_GROUP(9, EHT_GI_08, BW_40),
+	EHT_GROUP(10, EHT_GI_08, BW_40),
+	EHT_GROUP(11, EHT_GI_08, BW_40),
+	EHT_GROUP(12, EHT_GI_08, BW_40),
+	EHT_GROUP(13, EHT_GI_08, BW_40),
+	EHT_GROUP(14, EHT_GI_08, BW_40),
+	EHT_GROUP(15, EHT_GI_08, BW_40),
+	EHT_GROUP(16, EHT_GI_08, BW_40),
+
+	EHT_GROUP(1, EHT_GI_16, BW_40),
+	EHT_GROUP(2, EHT_GI_16, BW_40),
+	EHT_GROUP(3, EHT_GI_16, BW_40),
+	EHT_GROUP(4, EHT_GI_16, BW_40),
+	EHT_GROUP(5, EHT_GI_16, BW_40),
+	EHT_GROUP(6, EHT_GI_16, BW_40),
+	EHT_GROUP(7, EHT_GI_16, BW_40),
+	EHT_GROUP(8, EHT_GI_16, BW_40),
+	EHT_GROUP(9, EHT_GI_16, BW_40),
+	EHT_GROUP(10, EHT_GI_16, BW_40),
+	EHT_GROUP(11, EHT_GI_16, BW_40),
+	EHT_GROUP(12, EHT_GI_16, BW_40),
+	EHT_GROUP(13, EHT_GI_16, BW_40),
+	EHT_GROUP(14, EHT_GI_16, BW_40),
+	EHT_GROUP(15, EHT_GI_16, BW_40),
+	EHT_GROUP(16, EHT_GI_16, BW_40),
+
+	EHT_GROUP(1, EHT_GI_32, BW_40),
+	EHT_GROUP(2, EHT_GI_32, BW_40),
+	EHT_GROUP(3, EHT_GI_32, BW_40),
+	EHT_GROUP(4, EHT_GI_32, BW_40),
+	EHT_GROUP(5, EHT_GI_32, BW_40),
+	EHT_GROUP(6, EHT_GI_32, BW_40),
+	EHT_GROUP(7, EHT_GI_32, BW_40),
+	EHT_GROUP(8, EHT_GI_32, BW_40),
+	EHT_GROUP(9, EHT_GI_32, BW_40),
+	EHT_GROUP(10, EHT_GI_32, BW_40),
+	EHT_GROUP(11, EHT_GI_32, BW_40),
+	EHT_GROUP(12, EHT_GI_32, BW_40),
+	EHT_GROUP(13, EHT_GI_32, BW_40),
+	EHT_GROUP(14, EHT_GI_32, BW_40),
+	EHT_GROUP(15, EHT_GI_32, BW_40),
+	EHT_GROUP(16, EHT_GI_32, BW_40),
+
+	EHT_GROUP(1, EHT_GI_08, BW_80),
+	EHT_GROUP(2, EHT_GI_08, BW_80),
+	EHT_GROUP(3, EHT_GI_08, BW_80),
+	EHT_GROUP(4, EHT_GI_08, BW_80),
+	EHT_GROUP(5, EHT_GI_08, BW_80),
+	EHT_GROUP(6, EHT_GI_08, BW_80),
+	EHT_GROUP(7, EHT_GI_08, BW_80),
+	EHT_GROUP(8, EHT_GI_08, BW_80),
+	EHT_GROUP(9, EHT_GI_08, BW_80),
+	EHT_GROUP(10, EHT_GI_08, BW_80),
+	EHT_GROUP(11, EHT_GI_08, BW_80),
+	EHT_GROUP(12, EHT_GI_08, BW_80),
+	EHT_GROUP(13, EHT_GI_08, BW_80),
+	EHT_GROUP(14, EHT_GI_08, BW_80),
+	EHT_GROUP(15, EHT_GI_08, BW_80),
+	EHT_GROUP(16, EHT_GI_08, BW_80),
+
+	EHT_GROUP(1, EHT_GI_16, BW_80),
+	EHT_GROUP(2, EHT_GI_16, BW_80),
+	EHT_GROUP(3, EHT_GI_16, BW_80),
+	EHT_GROUP(4, EHT_GI_16, BW_80),
+	EHT_GROUP(5, EHT_GI_16, BW_80),
+	EHT_GROUP(6, EHT_GI_16, BW_80),
+	EHT_GROUP(7, EHT_GI_16, BW_80),
+	EHT_GROUP(8, EHT_GI_16, BW_80),
+	EHT_GROUP(9, EHT_GI_16, BW_80),
+	EHT_GROUP(10, EHT_GI_16, BW_80),
+	EHT_GROUP(11, EHT_GI_16, BW_80),
+	EHT_GROUP(12, EHT_GI_16, BW_80),
+	EHT_GROUP(13, EHT_GI_16, BW_80),
+	EHT_GROUP(14, EHT_GI_16, BW_80),
+	EHT_GROUP(15, EHT_GI_16, BW_80),
+	EHT_GROUP(16, EHT_GI_16, BW_80),
+
+	EHT_GROUP(1, EHT_GI_32, BW_80),
+	EHT_GROUP(2, EHT_GI_32, BW_80),
+	EHT_GROUP(3, EHT_GI_32, BW_80),
+	EHT_GROUP(4, EHT_GI_32, BW_80),
+	EHT_GROUP(5, EHT_GI_32, BW_80),
+	EHT_GROUP(6, EHT_GI_32, BW_80),
+	EHT_GROUP(7, EHT_GI_32, BW_80),
+	EHT_GROUP(8, EHT_GI_32, BW_80),
+	EHT_GROUP(9, EHT_GI_32, BW_80),
+	EHT_GROUP(10, EHT_GI_32, BW_80),
+	EHT_GROUP(11, EHT_GI_32, BW_80),
+	EHT_GROUP(12, EHT_GI_32, BW_80),
+	EHT_GROUP(13, EHT_GI_32, BW_80),
+	EHT_GROUP(14, EHT_GI_32, BW_80),
+	EHT_GROUP(15, EHT_GI_32, BW_80),
+	EHT_GROUP(16, EHT_GI_32, BW_80),
+
+	EHT_GROUP(1, EHT_GI_08, BW_160),
+	EHT_GROUP(2, EHT_GI_08, BW_160),
+	EHT_GROUP(3, EHT_GI_08, BW_160),
+	EHT_GROUP(4, EHT_GI_08, BW_160),
+	EHT_GROUP(5, EHT_GI_08, BW_160),
+	EHT_GROUP(6, EHT_GI_08, BW_160),
+	EHT_GROUP(7, EHT_GI_08, BW_160),
+	EHT_GROUP(8, EHT_GI_08, BW_160),
+	EHT_GROUP(9, EHT_GI_08, BW_160),
+	EHT_GROUP(10, EHT_GI_08, BW_160),
+	EHT_GROUP(11, EHT_GI_08, BW_160),
+	EHT_GROUP(12, EHT_GI_08, BW_160),
+	EHT_GROUP(13, EHT_GI_08, BW_160),
+	EHT_GROUP(14, EHT_GI_08, BW_160),
+	EHT_GROUP(15, EHT_GI_08, BW_160),
+	EHT_GROUP(16, EHT_GI_08, BW_160),
+
+	EHT_GROUP(1, EHT_GI_16, BW_160),
+	EHT_GROUP(2, EHT_GI_16, BW_160),
+	EHT_GROUP(3, EHT_GI_16, BW_160),
+	EHT_GROUP(4, EHT_GI_16, BW_160),
+	EHT_GROUP(5, EHT_GI_16, BW_160),
+	EHT_GROUP(6, EHT_GI_16, BW_160),
+	EHT_GROUP(7, EHT_GI_16, BW_160),
+	EHT_GROUP(8, EHT_GI_16, BW_160),
+	EHT_GROUP(9, EHT_GI_16, BW_160),
+	EHT_GROUP(10, EHT_GI_16, BW_160),
+	EHT_GROUP(11, EHT_GI_16, BW_160),
+	EHT_GROUP(12, EHT_GI_16, BW_160),
+	EHT_GROUP(13, EHT_GI_16, BW_160),
+	EHT_GROUP(14, EHT_GI_16, BW_160),
+	EHT_GROUP(15, EHT_GI_16, BW_160),
+	EHT_GROUP(16, EHT_GI_16, BW_160),
+
+	EHT_GROUP(1, EHT_GI_32, BW_160),
+	EHT_GROUP(2, EHT_GI_32, BW_160),
+	EHT_GROUP(3, EHT_GI_32, BW_160),
+	EHT_GROUP(4, EHT_GI_32, BW_160),
+	EHT_GROUP(5, EHT_GI_32, BW_160),
+	EHT_GROUP(6, EHT_GI_32, BW_160),
+	EHT_GROUP(7, EHT_GI_32, BW_160),
+	EHT_GROUP(8, EHT_GI_32, BW_160),
+	EHT_GROUP(9, EHT_GI_32, BW_160),
+	EHT_GROUP(10, EHT_GI_32, BW_160),
+	EHT_GROUP(11, EHT_GI_32, BW_160),
+	EHT_GROUP(12, EHT_GI_32, BW_160),
+	EHT_GROUP(13, EHT_GI_32, BW_160),
+	EHT_GROUP(14, EHT_GI_32, BW_160),
+	EHT_GROUP(15, EHT_GI_32, BW_160),
+	EHT_GROUP(16, EHT_GI_32, BW_160),
+
+	EHT_GROUP(1, EHT_GI_08, BW_320),
+	EHT_GROUP(2, EHT_GI_08, BW_320),
+	EHT_GROUP(3, EHT_GI_08, BW_320),
+	EHT_GROUP(4, EHT_GI_08, BW_320),
+	EHT_GROUP(5, EHT_GI_08, BW_320),
+	EHT_GROUP(6, EHT_GI_08, BW_320),
+	EHT_GROUP(7, EHT_GI_08, BW_320),
+	EHT_GROUP(8, EHT_GI_08, BW_320),
+	EHT_GROUP(9, EHT_GI_08, BW_320),
+	EHT_GROUP(10, EHT_GI_08, BW_320),
+	EHT_GROUP(11, EHT_GI_08, BW_320),
+	EHT_GROUP(12, EHT_GI_08, BW_320),
+	EHT_GROUP(13, EHT_GI_08, BW_320),
+	EHT_GROUP(14, EHT_GI_08, BW_320),
+	EHT_GROUP(15, EHT_GI_08, BW_320),
+	EHT_GROUP(16, EHT_GI_08, BW_320),
+
+	EHT_GROUP(1, EHT_GI_16, BW_320),
+	EHT_GROUP(2, EHT_GI_16, BW_320),
+	EHT_GROUP(3, EHT_GI_16, BW_320),
+	EHT_GROUP(4, EHT_GI_16, BW_320),
+	EHT_GROUP(5, EHT_GI_16, BW_320),
+	EHT_GROUP(6, EHT_GI_16, BW_320),
+	EHT_GROUP(7, EHT_GI_16, BW_320),
+	EHT_GROUP(8, EHT_GI_16, BW_320),
+	EHT_GROUP(9, EHT_GI_16, BW_320),
+	EHT_GROUP(10, EHT_GI_16, BW_320),
+	EHT_GROUP(11, EHT_GI_16, BW_320),
+	EHT_GROUP(12, EHT_GI_16, BW_320),
+	EHT_GROUP(13, EHT_GI_16, BW_320),
+	EHT_GROUP(14, EHT_GI_16, BW_320),
+	EHT_GROUP(15, EHT_GI_16, BW_320),
+	EHT_GROUP(16, EHT_GI_16, BW_320),
+
+	EHT_GROUP(1, EHT_GI_32, BW_320),
+	EHT_GROUP(2, EHT_GI_32, BW_320),
+	EHT_GROUP(3, EHT_GI_32, BW_320),
+	EHT_GROUP(4, EHT_GI_32, BW_320),
+	EHT_GROUP(5, EHT_GI_32, BW_320),
+	EHT_GROUP(6, EHT_GI_32, BW_320),
+	EHT_GROUP(7, EHT_GI_32, BW_320),
+	EHT_GROUP(8, EHT_GI_32, BW_320),
+	EHT_GROUP(9, EHT_GI_32, BW_320),
+	EHT_GROUP(10, EHT_GI_32, BW_320),
+	EHT_GROUP(11, EHT_GI_32, BW_320),
+	EHT_GROUP(12, EHT_GI_32, BW_320),
+	EHT_GROUP(13, EHT_GI_32, BW_320),
+	EHT_GROUP(14, EHT_GI_32, BW_320),
+	EHT_GROUP(15, EHT_GI_32, BW_320),
+	EHT_GROUP(16, EHT_GI_32, BW_320),
 };
 
 static u32
@@ -422,6 +750,9 @@ static u32 ieee80211_get_rate_duration(struct ieee80211_hw *hw,
 	case RATE_INFO_BW_160:
 		bw = BW_160;
 		break;
+	case RATE_INFO_BW_320:
+		bw = BW_320;
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -443,13 +774,19 @@ static u32 ieee80211_get_rate_duration(struct ieee80211_hw *hw,
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
+	if (WARN_ON_ONCE((status->encoding == RX_ENC_EHT && streams > 16) ||
+			 (status->encoding == RX_ENC_HE && streams > 8) ||
+			 (status->encoding < RX_ENC_HE && streams > 4)))
 		return 0;
 
 	if (idx >= MCS_GROUP_RATES)
@@ -517,7 +854,9 @@ static bool ieee80211_fill_rate_info(struct ieee80211_hw *hw,
 	stat->nss = ri->nss;
 	stat->rate_idx = ri->mcs;
 
-	if (ri->flags & RATE_INFO_FLAGS_HE_MCS)
+	if (ri->flags & RATE_INFO_FLAGS_EHT_MCS)
+		stat->encoding = RX_ENC_EHT;
+	else if (ri->flags & RATE_INFO_FLAGS_HE_MCS)
 		stat->encoding = RX_ENC_HE;
 	else if (ri->flags & RATE_INFO_FLAGS_VHT_MCS)
 		stat->encoding = RX_ENC_VHT;
@@ -529,7 +868,14 @@ static bool ieee80211_fill_rate_info(struct ieee80211_hw *hw,
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


