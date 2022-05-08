Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7127D51EE76
	for <lists+linux-wireless@lfdr.de>; Sun,  8 May 2022 17:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbiEHPP2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 May 2022 11:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbiEHPP0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 May 2022 11:15:26 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D02DDF20
        for <linux-wireless@vger.kernel.org>; Sun,  8 May 2022 08:11:35 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k2so16257779wrd.5
        for <linux-wireless@vger.kernel.org>; Sun, 08 May 2022 08:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0OtKaBzwV+MDufxdPrWl94b5hc1bcRRO7KI2sXQym6g=;
        b=k6t77qaBugmMjj2ZC628zIQ2SiaGS+pUCKyASxtDThmKHV9VTEIZ0jQ3tiwUQXqocb
         JmXzP59Yfsr/LPk6uszp3B3LeO03KgYWfknwU/FPpQXHSPJj8FhKHKUz+fe6MUanavdG
         bDb9/vaHANI25I81Lil1IzDPOhC1AOY80mT+voLt0Xym7lWodwU6MjXnMIPsFx81ih8T
         fKh0D7X6zGR0glqA09xawH3ZT3V/ZwtDnm7HCZrL1+CoIdbGucrwNaSoIYqn9cQJKLSL
         Pc8G9+jFM5dk2dFyrnpjKH52OHqS6fC7tXSlzrX777BHq2ishpjqXF4izGM5zGoThCwP
         K5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0OtKaBzwV+MDufxdPrWl94b5hc1bcRRO7KI2sXQym6g=;
        b=6CJrkwgXPVaTNsZ66VSHSt0cViOiT6moh80gVvKiSTgjseHmFbf0L1V3CAJkrjq2x3
         C7X9VqApOYLTFsku+cXBULe49Fbvu1Pt7+xxTVmkXOvEgpkODF7RZv4u+N5/4i6kxaAz
         WLGLhXBowsB0LWWL8lVe47ipUDBwtagptFCSzFK8sCqZSThPKBawf+Ujtdwbs9pPswbE
         f78jrT5QA4adcHdUcIknzjfal1VHbuSaT6I+NyZXfZYkYyYbjZhd3ioqT4iUKbh/diza
         XBIcfg/D9F0vRqWwY9gaw4g51/8vXdQTnKp3PY/YsnmsfgZkK82kvbUDeCVYs6wHbIWG
         kFXg==
X-Gm-Message-State: AOAM533KRHIG/cf0t18s0sn732G89xBKrIIPGh82NZK8BOK7LUdoAgCW
        gYxayAmYZG3leoXyvxAvyvayMbO/Vts=
X-Google-Smtp-Source: ABdhPJxFZnIOl8jIqy78Ci8Fv782k0gjTk2jdn3Aih84r8bW9E8YkRo5FdEgjKYnEqJKcTrpT+c6QQ==
X-Received: by 2002:a05:6000:1206:b0:20c:84e7:b4df with SMTP id e6-20020a056000120600b0020c84e7b4dfmr10323011wrx.131.1652022693886;
        Sun, 08 May 2022 08:11:33 -0700 (PDT)
Received: from build-server.fritz.box (p200300c56f1bf700880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f1b:f700:880d:3dff:fede:fb04])
        by smtp.gmail.com with ESMTPSA id h22-20020a05600c145600b003942a244f2esm14788023wmi.7.2022.05.08.08.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 08:11:32 -0700 (PDT)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@kernel.org, nbd@nbd.name, johannes@sipsolutions.net,
        thomas.huehn@hs-nordhausen.de,
        Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH v3 1/2] mac80211: extend current rate control tx status API
Date:   Sun,  8 May 2022 17:10:55 +0200
Message-Id: <20220508151056.2431775-2-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220508151056.2431775-1-jelonek.jonas@gmail.com>
References: <20220508151056.2431775-1-jelonek.jonas@gmail.com>
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

An extension is introduced to struct ieee80211_hw. There are two new
members called 'tx_power_levels' and 'max_txpwr_levels_idx' acting as a
tx power level table. When a wifi device is registered, the driver shall
supply all supported power levels in this list. This allows to support
several quirks like differing power steps in power level ranges or
alike. TPC can use this for algorithm and thus be designed more abstract
instead of handling all possible step widths individually.

Further mandatory changes in status.c and mt76 driver due to the
removal of 'struct rate_info *rate' are also included.
status.c already uses the information in ieee80211_tx_status->rate in
radiotap, this is now changed to use ieee80211_rate_status->rate_idx.
mt76 driver already uses struct rate_info to pass the tx rate to status
path. The new members of the ieee80211_tx_status are set to NULL and 0
because the previously passed rate is not relevant to rate control and
accurate information is passed via tx_info->status.rates.

Compile-Tested: current wireless-next tree with all flags on
Tested-on: Xiaomi 4A Gigabit (MediaTek MT7603E, MT7612E) with OpenWrt
		Linux 5.10.83

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/tx.c |  5 +-
 include/net/mac80211.h                  | 33 ++++++++-
 net/mac80211/status.c                   | 91 ++++++++++++++-----------
 3 files changed, 85 insertions(+), 44 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 6b8c9dc80542..b49ef6619829 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -66,9 +66,8 @@ mt76_tx_status_unlock(struct mt76_dev *dev, struct sk_buff_head *list)
 		wcid = rcu_dereference(dev->wcid[cb->wcid]);
 		if (wcid) {
 			status.sta = wcid_to_sta(wcid);
-
-			if (status.sta)
-				status.rate = &wcid->rate;
+			status.rates = NULL;
+			status.n_rates = 0;
 		}
 
 		hw = mt76_tx_status_get_hw(dev, skb);
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c50221d7e82c..54455c8249c2 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1131,20 +1131,41 @@ ieee80211_info_get_tx_time_est(struct ieee80211_tx_info *info)
 	return info->tx_time_est << 2;
 }
 
+/***
+ * struct ieee80211_rate_status - mrr stage for status path
+ *
+ * This struct is used in struct ieee80211_tx_status to provide drivers a
+ * dynamic way to report about used rates and power levels per packet.
+ *
+ * @rate_idx The actual used rate.
+ * @try_count How often the rate was tried.
+ * @tx_power_idx An idx into the ieee80211_hw->tx_power_levels list of the
+ * 	corresponding wifi hardware. The idx shall point to the power level 
+ * 	that was used when sending the packet.
+ */
+struct ieee80211_rate_status {
+	struct rate_info rate_idx;
+	u8 try_count;
+	u8 tx_power_idx;
+};
+
 /**
  * struct ieee80211_tx_status - extended tx status info for rate control
  *
  * @sta: Station that the packet was transmitted for
  * @info: Basic tx status information
  * @skb: Packet skb (can be NULL if not provided by the driver)
- * @rate: The TX rate that was used when sending the packet
+ * @rates: Mrr stages that were used when sending the packet
+ * @n_rates: Number of mrr stages (count of instances for @rates)
  * @free_list: list where processed skbs are stored to be free'd by the driver
  */
 struct ieee80211_tx_status {
 	struct ieee80211_sta *sta;
 	struct ieee80211_tx_info *info;
 	struct sk_buff *skb;
-	struct rate_info *rate;
+	struct ieee80211_rate_status *rates;
+	u8 n_rates;
+
 	struct list_head *free_list;
 };
 
@@ -2601,6 +2622,12 @@ enum ieee80211_hw_flags {
  *	refilling deficit of each TXQ.
  *
  * @max_mtu: the max mtu could be set.
+ *
+ * @tx_power_levels: a list of power levels supported by the wifi hardware.
+ * 	The power levels can be specified either as integer or fractions.
+ * 	The power level at idx 0 shall be the maximum positive power level.
+ *
+ * @max_txpwr_levels_idx: the maximum valid idx of 'tx_power_levels' list.
  */
 struct ieee80211_hw {
 	struct ieee80211_conf conf;
@@ -2639,6 +2666,8 @@ struct ieee80211_hw {
 	u8 tx_sk_pacing_shift;
 	u8 weight_multiplier;
 	u32 max_mtu;
+	const s8 *tx_power_levels;
+	u8 max_txpwr_levels_idx;
 };
 
 static inline bool _ieee80211_hw_check(struct ieee80211_hw *hw,
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index f6f63a0b1b72..fc6f88ab648b 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -246,15 +246,19 @@ static void ieee80211_set_bar_pending(struct sta_info *sta, u8 tid, u16 ssn)
 static int ieee80211_tx_radiotap_len(struct ieee80211_tx_info *info,
 				     struct ieee80211_tx_status *status)
 {
+	struct ieee80211_rate_status *status_rate = NULL;
 	int len = sizeof(struct ieee80211_radiotap_header);
 
+	if (status && status->n_rates)
+		status_rate = &status->rates[status->n_rates - 1];
+
 	/* IEEE80211_RADIOTAP_RATE rate */
-	if (status && status->rate && !(status->rate->flags &
-					(RATE_INFO_FLAGS_MCS |
-					 RATE_INFO_FLAGS_DMG |
-					 RATE_INFO_FLAGS_EDMG |
-					 RATE_INFO_FLAGS_VHT_MCS |
-					 RATE_INFO_FLAGS_HE_MCS)))
+	if (status_rate && !(status_rate->rate_idx.flags &
+						(RATE_INFO_FLAGS_MCS |
+						 RATE_INFO_FLAGS_DMG |
+						 RATE_INFO_FLAGS_EDMG |
+						 RATE_INFO_FLAGS_VHT_MCS |
+						 RATE_INFO_FLAGS_HE_MCS)))
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
 
+	if (status && status->n_rates)
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
+						(RATE_INFO_FLAGS_MCS |
+						 RATE_INFO_FLAGS_DMG |
+						 RATE_INFO_FLAGS_EDMG |
+						 RATE_INFO_FLAGS_VHT_MCS |
+						 RATE_INFO_FLAGS_HE_MCS)))
+			legacy_rate = status_rate->rate_idx.legacy;
 	} else if (info->status.rates[0].idx >= 0 &&
 		 !(info->status.rates[0].flags & (IEEE80211_TX_RC_MCS |
 						  IEEE80211_TX_RC_VHT_MCS)))
@@ -356,20 +365,21 @@ ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
 	*pos = retry_count;
 	pos++;
 
-	if (status && status->rate &&
-	    (status->rate->flags & RATE_INFO_FLAGS_MCS)) {
+	if (status_rate && (status_rate->rate_idx.flags & RATE_INFO_FLAGS_MCS))
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
@@ -384,12 +394,12 @@ ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
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
@@ -406,7 +416,8 @@ ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
 		pos++;
 
 		/* u8 mcs_nss[4] */
-		*pos = (status->rate->mcs << 4) | status->rate->nss;
+		*pos = (status_rate->rate_idx.mcs << 4) |
+				status_rate->rate_idx.nss;
 		pos += 4;
 
 		/* u8 coding */
@@ -415,8 +426,9 @@ ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
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
@@ -434,7 +446,7 @@ ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
 
 #define HE_PREP(f, val) le16_encode_bits(val, IEEE80211_RADIOTAP_HE_##f)
 
-		he->data6 |= HE_PREP(DATA6_NSTS, status->rate->nss);
+		he->data6 |= HE_PREP(DATA6_NSTS, status_rate->rate_idx.nss);
 
 #define CHECK_GI(s) \
 	BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_DATA5_GI_##s != \
@@ -444,12 +456,12 @@ ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
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
@@ -480,16 +492,16 @@ ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
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
@@ -1108,8 +1120,9 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 	if (pubsta) {
 		sta = container_of(pubsta, struct sta_info, sta);
 
-		if (status->rate)
-			sta->tx_stats.last_rate_info = *status->rate;
+		if (status->rates)
+			sta->tx_stats.last_rate_info =
+				status->rates[status->n_rates - 1].rate_idx;
 	}
 
 	if (skb && (tx_time_est =
-- 
2.30.2

