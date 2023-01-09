Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EC56623D8
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 12:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbjAILHx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 06:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjAILHv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 06:07:51 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C06140BF
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 03:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673262470; x=1704798470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RvsjNi7NbUFnVCxXppfl98EHcVAStmHE96MUFuGfh6U=;
  b=WQeIBDvvWsfeB/cAzXI4nWq62234NirF2pcBAjaB/t0vrkPg6Zc6l55g
   QgYXpLo4q4skW8BI30E8lSEgPB0gGUhnqeNOuXBNt9hP1vf0BMRimbDTO
   AtOz4HA48YyOCJCCrAQ1nU6pkX1EOXTiN0hBjLj/Jz8buCQTu7+h+ubyi
   enE+1xRy5p/36kjVL5bz1HJWjW/kZsQg/t/UJEtxhmE1aPkKe1KiMD0SK
   fJzUxnBI0EHvjsErBhM86NuKFZ1vCnsa71nb/rckbUAwindEtvQJa/R6x
   tGlAbESxgsSDFm935VjQOp8JNlPVaqT0jHqYNTVp+WGvGDIOlfRh2N9vb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="387296441"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="387296441"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 03:07:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="689003130"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="689003130"
Received: from djacobi-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.191.194])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 03:07:48 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 1/2] mac80211: support minimal EHT rate reporting on RX
Date:   Mon,  9 Jan 2023 13:07:21 +0200
Message-Id: <20230109130329.ead56028f756.Ide5d392e2918ff126439e0c8b868fd92f92ed015@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230109110722.212758-1-gregory.greenman@intel.com>
References: <20230109110722.212758-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add minimal support for RX EHT rate reporting, not yet
adding (modifying) any radiotap headers, just statistics
for cfg80211.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/mac80211.h  | 19 ++++++++++++++++---
 net/mac80211/rx.c       |  9 +++++++++
 net/mac80211/sta_info.c |  9 ++++++++-
 net/mac80211/sta_info.h | 24 ++++++++++++++++++------
 net/mac80211/util.c     | 13 +++++++++++++
 5 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 689da327ce2e..759f5c9d3e0a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1436,6 +1436,7 @@ enum mac80211_rx_encoding {
 	RX_ENC_HT,
 	RX_ENC_VHT,
 	RX_ENC_HE,
+	RX_ENC_EHT,
 };
 
 /**
@@ -1469,7 +1470,7 @@ enum mac80211_rx_encoding {
  * @antenna: antenna used
  * @rate_idx: index of data rate into band's supported rates or MCS index if
  *	HT or VHT is used (%RX_FLAG_HT/%RX_FLAG_VHT)
- * @nss: number of streams (VHT and HE only)
+ * @nss: number of streams (VHT, HE and EHT only)
  * @flag: %RX_FLAG_\*
  * @encoding: &enum mac80211_rx_encoding
  * @bw: &enum rate_info_bw
@@ -1477,6 +1478,8 @@ enum mac80211_rx_encoding {
  * @he_ru: HE RU, from &enum nl80211_he_ru_alloc
  * @he_gi: HE GI, from &enum nl80211_he_gi
  * @he_dcm: HE DCM value
+ * @eht.ru: EHT RU, from &enum nl80211_eht_ru_alloc
+ * @eht.gi: EHT GI, from &enum nl80211_eht_gi
  * @rx_flags: internal RX flags for mac80211
  * @ampdu_reference: A-MPDU reference number, must be a different value for
  *	each A-MPDU but the same for each subframe within one A-MPDU
@@ -1498,8 +1501,18 @@ struct ieee80211_rx_status {
 	u32 flag;
 	u16 freq: 13, freq_offset: 1;
 	u8 enc_flags;
-	u8 encoding:2, bw:3, he_ru:3;
-	u8 he_gi:2, he_dcm:1;
+	u8 encoding:3, bw:4;
+	union {
+		struct {
+			u8 he_ru:3;
+			u8 he_gi:2;
+			u8 he_dcm:1;
+		};
+		struct {
+			u8 ru:4;
+			u8 gi:2;
+		} eht;
+	};
 	u8 rate_idx;
 	u8 nss;
 	u8 rx_flags;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 7e3ab6e1b28f..a4243a6e0446 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5215,6 +5215,15 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 				      status->rate_idx, status->nss))
 				goto drop;
 			break;
+		case RX_ENC_EHT:
+			if (WARN_ONCE(status->rate_idx > 15 ||
+				      !status->nss ||
+				      status->nss > 8 ||
+				      status->eht.gi > NL80211_RATE_INFO_EHT_GI_3_2,
+				      "Rate marked as an EHT rate but data is invalid: MCS:%d, NSS:%d, GI:%d\n",
+				      status->rate_idx, status->nss, status->eht.gi))
+				goto drop;
+			break;
 		default:
 			WARN_ON_ONCE(1);
 			fallthrough;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 04e0f132b1d9..27c737fe7fb8 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -4,7 +4,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  */
 
 #include <linux/module.h>
@@ -2406,6 +2406,13 @@ static void sta_stats_decode_rate(struct ieee80211_local *local, u32 rate,
 		rinfo->he_ru_alloc = STA_STATS_GET(HE_RU, rate);
 		rinfo->he_dcm = STA_STATS_GET(HE_DCM, rate);
 		break;
+	case STA_STATS_RATE_TYPE_EHT:
+		rinfo->flags = RATE_INFO_FLAGS_EHT_MCS;
+		rinfo->mcs = STA_STATS_GET(EHT_MCS, rate);
+		rinfo->nss = STA_STATS_GET(EHT_NSS, rate);
+		rinfo->eht_gi = STA_STATS_GET(EHT_GI, rate);
+		rinfo->eht_ru_alloc = STA_STATS_GET(EHT_RU, rate);
+		break;
 	}
 }
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 69820b551668..c30f02874fb1 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -936,6 +936,7 @@ enum sta_stats_type {
 	STA_STATS_RATE_TYPE_VHT,
 	STA_STATS_RATE_TYPE_HE,
 	STA_STATS_RATE_TYPE_S1G,
+	STA_STATS_RATE_TYPE_EHT,
 };
 
 #define STA_STATS_FIELD_HT_MCS		GENMASK( 7,  0)
@@ -945,12 +946,16 @@ enum sta_stats_type {
 #define STA_STATS_FIELD_VHT_NSS		GENMASK( 7,  4)
 #define STA_STATS_FIELD_HE_MCS		GENMASK( 3,  0)
 #define STA_STATS_FIELD_HE_NSS		GENMASK( 7,  4)
-#define STA_STATS_FIELD_BW		GENMASK(11,  8)
-#define STA_STATS_FIELD_SGI		GENMASK(12, 12)
-#define STA_STATS_FIELD_TYPE		GENMASK(15, 13)
-#define STA_STATS_FIELD_HE_RU		GENMASK(18, 16)
-#define STA_STATS_FIELD_HE_GI		GENMASK(20, 19)
-#define STA_STATS_FIELD_HE_DCM		GENMASK(21, 21)
+#define STA_STATS_FIELD_EHT_MCS		GENMASK( 3,  0)
+#define STA_STATS_FIELD_EHT_NSS		GENMASK( 7,  4)
+#define STA_STATS_FIELD_BW		GENMASK(12,  8)
+#define STA_STATS_FIELD_SGI		GENMASK(13, 13)
+#define STA_STATS_FIELD_TYPE		GENMASK(16, 14)
+#define STA_STATS_FIELD_HE_RU		GENMASK(19, 17)
+#define STA_STATS_FIELD_HE_GI		GENMASK(21, 20)
+#define STA_STATS_FIELD_HE_DCM		GENMASK(22, 22)
+#define STA_STATS_FIELD_EHT_RU		GENMASK(20, 17)
+#define STA_STATS_FIELD_EHT_GI		GENMASK(22, 21)
 
 #define STA_STATS_FIELD(_n, _v)		FIELD_PREP(STA_STATS_FIELD_ ## _n, _v)
 #define STA_STATS_GET(_n, _v)		FIELD_GET(STA_STATS_FIELD_ ## _n, _v)
@@ -989,6 +994,13 @@ static inline u32 sta_stats_encode_rate(struct ieee80211_rx_status *s)
 		r |= STA_STATS_FIELD(HE_RU, s->he_ru);
 		r |= STA_STATS_FIELD(HE_DCM, s->he_dcm);
 		break;
+	case RX_ENC_EHT:
+		r |= STA_STATS_FIELD(TYPE, STA_STATS_RATE_TYPE_EHT);
+		r |= STA_STATS_FIELD(EHT_NSS, s->nss);
+		r |= STA_STATS_FIELD(EHT_MCS, s->rate_idx);
+		r |= STA_STATS_FIELD(EHT_GI, s->eht.gi);
+		r |= STA_STATS_FIELD(EHT_RU, s->eht.ru);
+		break;
 	default:
 		WARN_ON(1);
 		return STA_STATS_RATE_INVALID;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 6f5407038459..c2fce5a20cbd 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4069,6 +4069,19 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 
 	/* Fill cfg80211 rate info */
 	switch (status->encoding) {
+	case RX_ENC_EHT:
+		ri.flags |= RATE_INFO_FLAGS_EHT_MCS;
+		ri.mcs = status->rate_idx;
+		ri.nss = status->nss;
+		ri.eht_ru_alloc = status->eht.ru;
+		if (status->enc_flags & RX_ENC_FLAG_SHORT_GI)
+			ri.flags |= RATE_INFO_FLAGS_SHORT_GI;
+		/* TODO/FIXME: is this right? handle other PPDUs */
+		if (status->flag & RX_FLAG_MACTIME_PLCP_START) {
+			mpdu_offset += 2;
+			ts += 36;
+		}
+		break;
 	case RX_ENC_HE:
 		ri.flags |= RATE_INFO_FLAGS_HE_MCS;
 		ri.mcs = status->rate_idx;
-- 
2.38.1

