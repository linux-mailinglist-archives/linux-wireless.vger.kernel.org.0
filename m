Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6784C56A6
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Feb 2022 16:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiBZPjh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Feb 2022 10:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiBZPjg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Feb 2022 10:39:36 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF79F64C6
        for <linux-wireless@vger.kernel.org>; Sat, 26 Feb 2022 07:39:01 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d28so8811990wra.4
        for <linux-wireless@vger.kernel.org>; Sat, 26 Feb 2022 07:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0QnpAEElRkpnZqZl5AIAL2um7NgoerHmx8c1sgGSdlc=;
        b=EFmgebrpEs/NI4ENWl1lBCWxe5bHSUYJnZ5elBDpBk1+gH1YQLnBnwPD3LXuMTwJqD
         DQaDSoK9ZyWzgeY30ExlKty57obbnbGdd34j+MkJS9wj0EbZLEt2UppNxo5yFh9JG2SD
         wgF3tUJitKmVDH/LyyL2p/uaPJyrYOiXUAYM0a5lf/WEpqWASOm8Khdpk7b49rSARAEm
         NcSPFu88vqFYIUg36i7CQhs1lmLviYZL2idNvWp0qV3yF7a5SM50LbvokD/mlgM5zB+a
         sg1LXF2E4RfgsJzQ4Kl9PVPGoLfb2aMUMqn9XcSzdcsJCmN/sgyBRpodeF3QaNcO6pQH
         CPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0QnpAEElRkpnZqZl5AIAL2um7NgoerHmx8c1sgGSdlc=;
        b=yOnSTMMT//PPbaMoLhPsZj7d4BiP9G/2lLlqhIEEd1+So288+mbr64aGFPswt1F59H
         qLEUjmbp+R2++FqPeBq3CmGTD0pnkBTfqAE6sq2ZC+i+PpV5bUvcejbd92F7DAq0MnGy
         bMcrkxvDV+pMkfOz/KMDf40nWeL2PMxuvqJGX/sGCRtIioLiey8cLDMa9xjQQ5sD46yg
         rrfBKefNH46SBMRShXZUEUum7e4HXVhYH5+eTjVLSLaTUNMajTECQtkMP9Pv6dws76I1
         +yI+uIDUwig8UQPP+KtpMHYUth2U2CeY5XYdXZLcRapfrRXrD+2+kzZj/Vfg7lg1TdJu
         Ya3A==
X-Gm-Message-State: AOAM533fHQFYvFnIMaKYL1nOTvgrxygjnMYZ7SEZ+ZmFuVnBmVUJcZxJ
        baHDz7ImTyEe2HHfqw1VLgjgpS1wB6BkOw==
X-Google-Smtp-Source: ABdhPJwLI1KL6bCBoM5txOJsg/QMjZwJu7T2yFtf5fWr8VQ8bMPqEZE+1ldh+FeZq8o+kInGWGWQHw==
X-Received: by 2002:adf:c3cd:0:b0:1ed:c21c:b3f5 with SMTP id d13-20020adfc3cd000000b001edc21cb3f5mr9806585wrg.269.1645889940042;
        Sat, 26 Feb 2022 07:39:00 -0800 (PST)
Received: from build-server.fritz.box (p200300c56f4ead00880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f4e:ad00:880d:3dff:fede:fb04])
        by smtp.gmail.com with ESMTPSA id u9-20020a05600c19c900b0037c050d73dcsm10239054wmq.46.2022.02.26.07.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 07:38:59 -0800 (PST)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@kernel.org, ndb@nbd.name, johannes@sipsolutions.net,
        Jonas Jelonek <jelonek.jonas@gmail.com>,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Subject: [PATCH 1/2] mac80211: extend current rate control tx status API
Date:   Sat, 26 Feb 2022 16:38:42 +0100
Message-Id: <20220226153843.912-2-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220226153843.912-1-jelonek.jonas@gmail.com>
References: <20220226153843.912-1-jelonek.jonas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds the new struct ieee80211_rate_status and replaces
'struct rate_info *rate' in ieee80211_tx_status with pointer and length
annotation.

The struct ieee80211_rate_status allows to:
(1)	receive tx power status feedback for transmit power control (TPC)
	per packet or packet retry
(2)	dynamic mapping of wifi chip specific multi-rate retry (mrr)
	chains with different lengths
(3)	increase the limit of annotatable rate indices to support
	IEEE802.11ac rate sets and beyond

ieee80211_tx_info, control and status buffer, and ieee80211_tx_rate
cannot be used to achieve these goals due to fixed size limitations.

Our new struct contains a struct rate_info to annotate the rate that was
used, retry count of the rate and tx power. It is intended for all
information related to RC and TPC that needs to be passed from driver to
mac80211 and its RC/TPC algorithms like Minstrel_HT. It corresponds to
one stage in an mrr. Multiple subsequent instances of this struct can be
included in struct ieee80211_tx_status via a pointer and a length variable.
Those instances can be allocated on-stack. The former reference to a single
instance of struct rate_info is replaced with our new annotation.

Further mandatory changes in status.c and mt76 driver due to the
removal of 'struct rate_info *rate' are also included.
status.c already uses the information in ieee80211_tx_status->rate in
radiotap, this is now changed to use ieee80211_rate_status->rate_idx.
mt76 driver already uses struct rate_info to pass the tx rate to status
path. It is now enclosed in an instance of struct ieee80211_rate_status
with default values for retry_count and tx_power. The latter should be
adjusted later to pass more accurate values.

Compile-Tested: current wireless-next tree with all flags on
Tested-on: Xiaomi 4A Gigabit (MediaTek MT7603E, MT7612E) with OpenWrt
		Linux 5.10.83

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
Acked-by: Thomas Huehn <thomas.huehn@hs-nordhausen.de>
---
 drivers/net/wireless/mediatek/mt76/tx.c | 13 +++-
 include/net/mac80211.h                  | 10 ++-
 net/mac80211/status.c                   | 91 ++++++++++++++-----------
 3 files changed, 71 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 6b8c9dc80542..ed3f3654999f 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -62,13 +62,20 @@ mt76_tx_status_unlock(struct mt76_dev *dev, struct sk_buff_head *list)
 		};
 		struct mt76_tx_cb *cb = mt76_tx_skb_cb(skb);
 		struct mt76_wcid *wcid;
+		struct ieee80211_rate_status rate = {0};
 
 		wcid = rcu_dereference(dev->wcid[cb->wcid]);
 		if (wcid) {
 			status.sta = wcid_to_sta(wcid);
-
-			if (status.sta)
-				status.rate = &wcid->rate;
+			if (status.sta) {
+				rate.rate_idx = wcid->rate;
+				rate.retry_count = 1;
+				/* Default 0 for now, can be used by TPC algorithm */
+				rate.tx_power = 0;
+
+				status.rates = &rate;
+				status.n_rates = 1;
+			}
 		}
 
 		hw = mt76_tx_status_get_hw(dev, skb);
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c50221d7e82c..1e98ed04b446 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1131,6 +1131,12 @@ ieee80211_info_get_tx_time_est(struct ieee80211_tx_info *info)
 	return info->tx_time_est << 2;
 }
 
+struct ieee80211_rate_status {
+	struct rate_info rate_idx;
+	u8 retry_count;
+	s8 tx_power;
+};
+
 /**
  * struct ieee80211_tx_status - extended tx status info for rate control
  *
@@ -1144,7 +1150,9 @@ struct ieee80211_tx_status {
 	struct ieee80211_sta *sta;
 	struct ieee80211_tx_info *info;
 	struct sk_buff *skb;
-	struct rate_info *rate;
+	struct ieee80211_rate_status *rates;
+	u8 n_rates;
+
 	struct list_head *free_list;
 };
 
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index f6f63a0b1b72..b31b9a6d02cc 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -246,15 +246,19 @@ static void ieee80211_set_bar_pending(struct sta_info *sta, u8 tid, u16 ssn)
 static int ieee80211_tx_radiotap_len(struct ieee80211_tx_info *info,
 				     struct ieee80211_tx_status *status)
 {
+	struct ieee80211_rate_status *status_rate = NULL;
 	int len = sizeof(struct ieee80211_radiotap_header);
 
+	if (status && status->rates)
+		status_rate = &status->rates[status->n_rates - 1];
+
 	/* IEEE80211_RADIOTAP_RATE rate */
-	if (status && status->rate && !(status->rate->flags &
-					(RATE_INFO_FLAGS_MCS |
-					 RATE_INFO_FLAGS_DMG |
-					 RATE_INFO_FLAGS_EDMG |
-					 RATE_INFO_FLAGS_VHT_MCS |
-					 RATE_INFO_FLAGS_HE_MCS)))
+	if (status_rate && (status_rate->rate_idx.flags &
+				(RATE_INFO_FLAGS_MCS |
+	       			 RATE_INFO_FLAGS_DMG |
+				 RATE_INFO_FLAGS_EDMG |
+				 RATE_INFO_FLAGS_VHT_MCS |
+				 RATE_INFO_FLAGS_HE_MCS)))
 		len += 2;
 	else if (info->status.rates[0].idx >= 0 &&
 		 !(info->status.rates[0].flags &
@@ -269,12 +273,12 @@ static int ieee80211_tx_radiotap_len(struct ieee80211_tx_info *info,
 
 	/* IEEE80211_RADIOTAP_MCS
 	 * IEEE80211_RADIOTAP_VHT */
-	if (status && status->rate) {
-		if (status->rate->flags & RATE_INFO_FLAGS_MCS)
+	if (status_rate) {
+		if (status_rate->rate_idx.flags & RATE_INFO_FLAGS_MCS)
 			len += 3;
-		else if (status->rate->flags & RATE_INFO_FLAGS_VHT_MCS)
+		else if (status_rate->rate_idx.flags & RATE_INFO_FLAGS_VHT_MCS)
 			len = ALIGN(len, 2) + 12;
-		else if (status->rate->flags & RATE_INFO_FLAGS_HE_MCS)
+		else if (status_rate->rate_idx.flags & RATE_INFO_FLAGS_HE_MCS)
 			len = ALIGN(len, 2) + 12;
 	} else if (info->status.rates[0].idx >= 0) {
 		if (info->status.rates[0].flags & IEEE80211_TX_RC_MCS)
@@ -296,10 +300,14 @@ ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
 	struct ieee80211_radiotap_header *rthdr;
+	struct ieee80211_rate_status *status_rate = NULL;
 	unsigned char *pos;
 	u16 legacy_rate = 0;
 	u16 txflags;
 
+	if (status && status->rates)
+		status_rate = &status->rates[status->n_rates - 1];
+
 	rthdr = skb_push(skb, rtap_len);
 
 	memset(rthdr, 0, rtap_len);
@@ -317,13 +325,14 @@ ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
 
 	/* IEEE80211_RADIOTAP_RATE */
 
-	if (status && status->rate) {
-		if (!(status->rate->flags & (RATE_INFO_FLAGS_MCS |
-					     RATE_INFO_FLAGS_DMG |
-					     RATE_INFO_FLAGS_EDMG |
-					     RATE_INFO_FLAGS_VHT_MCS |
-					     RATE_INFO_FLAGS_HE_MCS)))
-			legacy_rate = status->rate->legacy;
+	if (status_rate) {
+		if (!(status_rate->rate_idx.flags &
+		      			(RATE_INFO_FLAGS_MCS |
+		       		 	 RATE_INFO_FLAGS_DMG |
+		       		 	 RATE_INFO_FLAGS_EDMG |
+		       			 RATE_INFO_FLAGS_VHT_MCS |
+		       			 RATE_INFO_FLAGS_HE_MCS)))
+			legacy_rate = status_rate->rate_idx.legacy;
 	} else if (info->status.rates[0].idx >= 0 &&
 		 !(info->status.rates[0].flags & (IEEE80211_TX_RC_MCS |
 						  IEEE80211_TX_RC_VHT_MCS)))
@@ -356,20 +365,22 @@ ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
 	*pos = retry_count;
 	pos++;
 
-	if (status && status->rate &&
-	    (status->rate->flags & RATE_INFO_FLAGS_MCS)) {
+	if (status_rate && (status_rate->rate_idx.flags &
+				RATE_INFO_FLAGS_MCS))
+	{
 		rthdr->it_present |= cpu_to_le32(BIT(IEEE80211_RADIOTAP_MCS));
 		pos[0] = IEEE80211_RADIOTAP_MCS_HAVE_MCS |
 			 IEEE80211_RADIOTAP_MCS_HAVE_GI |
 			 IEEE80211_RADIOTAP_MCS_HAVE_BW;
-		if (status->rate->flags & RATE_INFO_FLAGS_SHORT_GI)
+		if (status_rate->rate_idx.flags & RATE_INFO_FLAGS_SHORT_GI)
 			pos[1] |= IEEE80211_RADIOTAP_MCS_SGI;
-		if (status->rate->bw == RATE_INFO_BW_40)
+		if (status_rate->rate_idx.bw == RATE_INFO_BW_40)
 			pos[1] |= IEEE80211_RADIOTAP_MCS_BW_40;
-		pos[2] = status->rate->mcs;
+		pos[2] = status_rate->rate_idx.mcs;
 		pos += 3;
-	} else if (status && status->rate &&
-		   (status->rate->flags & RATE_INFO_FLAGS_VHT_MCS)) {
+	} else if (status_rate && (status_rate->rate_idx.flags &
+					RATE_INFO_FLAGS_VHT_MCS))
+	{
 		u16 known = local->hw.radiotap_vht_details &
 			(IEEE80211_RADIOTAP_VHT_KNOWN_GI |
 			 IEEE80211_RADIOTAP_VHT_KNOWN_BANDWIDTH);
@@ -384,12 +395,12 @@ ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
 		pos += 2;
 
 		/* u8 flags - IEEE80211_RADIOTAP_VHT_FLAG_* */
-		if (status->rate->flags & RATE_INFO_FLAGS_SHORT_GI)
+		if (status_rate->rate_idx.flags & RATE_INFO_FLAGS_SHORT_GI)
 			*pos |= IEEE80211_RADIOTAP_VHT_FLAG_SGI;
 		pos++;
 
 		/* u8 bandwidth */
-		switch (status->rate->bw) {
+		switch (status_rate->rate_idx.bw) {
 		case RATE_INFO_BW_160:
 			*pos = 11;
 			break;
@@ -406,7 +417,8 @@ ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
 		pos++;
 
 		/* u8 mcs_nss[4] */
-		*pos = (status->rate->mcs << 4) | status->rate->nss;
+		*pos = (status_rate->rate_idx.mcs << 4) |
+				status_rate->rate_idx.nss;
 		pos += 4;
 
 		/* u8 coding */
@@ -415,8 +427,9 @@ ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
 		pos++;
 		/* u16 partial_aid */
 		pos += 2;
-	} else if (status && status->rate &&
-		   (status->rate->flags & RATE_INFO_FLAGS_HE_MCS)) {
+	} else if (status_rate && (status_rate->rate_idx.flags &
+					RATE_INFO_FLAGS_HE_MCS))
+	{
 		struct ieee80211_radiotap_he *he;
 
 		rthdr->it_present |= cpu_to_le32(BIT(IEEE80211_RADIOTAP_HE));
@@ -434,7 +447,7 @@ ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
 
 #define HE_PREP(f, val) le16_encode_bits(val, IEEE80211_RADIOTAP_HE_##f)
 
-		he->data6 |= HE_PREP(DATA6_NSTS, status->rate->nss);
+		he->data6 |= HE_PREP(DATA6_NSTS, status_rate->rate_idx.nss);
 
 #define CHECK_GI(s) \
 	BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_DATA5_GI_##s != \
@@ -444,12 +457,12 @@ ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
 		CHECK_GI(1_6);
 		CHECK_GI(3_2);
 
-		he->data3 |= HE_PREP(DATA3_DATA_MCS, status->rate->mcs);
-		he->data3 |= HE_PREP(DATA3_DATA_DCM, status->rate->he_dcm);
+		he->data3 |= HE_PREP(DATA3_DATA_MCS, status_rate->rate_idx.mcs);
+		he->data3 |= HE_PREP(DATA3_DATA_DCM, status_rate->rate_idx.he_dcm);
 
-		he->data5 |= HE_PREP(DATA5_GI, status->rate->he_gi);
+		he->data5 |= HE_PREP(DATA5_GI, status_rate->rate_idx.he_gi);
 
-		switch (status->rate->bw) {
+		switch (status_rate->rate_idx.bw) {
 		case RATE_INFO_BW_20:
 			he->data5 |= HE_PREP(DATA5_DATA_BW_RU_ALLOC,
 					     IEEE80211_RADIOTAP_HE_DATA5_DATA_BW_RU_ALLOC_20MHZ);
@@ -480,16 +493,16 @@ ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
 			CHECK_RU_ALLOC(2x996);
 
 			he->data5 |= HE_PREP(DATA5_DATA_BW_RU_ALLOC,
-					     status->rate->he_ru_alloc + 4);
+					     status_rate->rate_idx.he_ru_alloc + 4);
 			break;
 		default:
-			WARN_ONCE(1, "Invalid SU BW %d\n", status->rate->bw);
+			WARN_ONCE(1, "Invalid SU BW %d\n", status_rate->rate_idx.bw);
 		}
 
 		pos += sizeof(struct ieee80211_radiotap_he);
 	}
 
-	if ((status && status->rate) || info->status.rates[0].idx < 0)
+	if (status_rate || info->status.rates[0].idx < 0)
 		return;
 
 	/* IEEE80211_RADIOTAP_MCS
@@ -1108,8 +1121,8 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 	if (pubsta) {
 		sta = container_of(pubsta, struct sta_info, sta);
 
-		if (status->rate)
-			sta->tx_stats.last_rate_info = *status->rate;
+		if (status->rates)
+			sta->tx_stats.last_rate_info = status->rates[0].rate_idx;
 	}
 
 	if (skb && (tx_time_est =
-- 
2.30.2

