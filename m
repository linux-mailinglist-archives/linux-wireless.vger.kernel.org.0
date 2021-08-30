Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975613FB8FB
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Aug 2021 17:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbhH3P1u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Aug 2021 11:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237550AbhH3P1q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Aug 2021 11:27:46 -0400
Received: from mail-ed1-x563.google.com (mail-ed1-x563.google.com [IPv6:2a00:1450:4864:20::563])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258A7C06175F
        for <linux-wireless@vger.kernel.org>; Mon, 30 Aug 2021 08:26:52 -0700 (PDT)
Received: by mail-ed1-x563.google.com with SMTP id s25so22306855edw.0
        for <linux-wireless@vger.kernel.org>; Mon, 30 Aug 2021 08:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ExRvH1Jgn+sQe7cf+qhrLRjyf/V8Wg2gbLCRLIZyA34=;
        b=ZeLO3+sCIn3HZOSUc+DLsEhh2dK+OrloRMRMQu1FgzPrLyLYiUkBNBE9elL+ddA+ls
         VsyPnxwRxeK0uaDJ9dUhdaOhY3bZ5i68jFrI+radcnSAZfoAG2eZPceAjWH9aKXb4fvU
         gJqSf/sruK5kWJ+ea9TgudRYKZ8wkfqH1EqfkFoIBw0Ixpgx57RTcdJ4VS4M+e+Y2Xv6
         /janDJAHMHwhnsbGigsmRl25fpLlRMwS3fkMTGtGOW2+dbIuudYfOYA++cbsCJtUzXg9
         /AuknGihTp38hLMuTX8/m85ypldkjOBwHYbelRtK/SJzPZBMKW8lOZv3LvI1vX/AlnOG
         ndWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ExRvH1Jgn+sQe7cf+qhrLRjyf/V8Wg2gbLCRLIZyA34=;
        b=CqZfCHGyqD85WsdFE8NC3AlLgxysykto2xWlTAFJEtMt2YCkfxTK37k15a0FLb43RQ
         6TUA/QaMkZWRDIsGurcQj+bmeMGDrSB2K6C+M+gBKw+05SFfhyy3MMngZ/TdQQaNcix7
         9db1PWXd0TuzjwP3Hm1humkUJSPdnv1K/HMHM+wcWWFLC+lFqmF+7AdgTVVkxwfFLWsJ
         b73oum0cJkAhXU6fxqipBl0hz2eh9PGxyjX44uz6EiPSMelM7kCwRK/oJLXXBeEKmQ1f
         hje7qePhfEcCPeVzFsGBUD6j7Qe6I/1+iASpCOr5A/tDXCSpub6IXIGOzhEjpPRsClNi
         75aQ==
X-Gm-Message-State: AOAM530itwdZoTB3fGp2be3AfR33+AwEsVKaY3hovU90nsjZcDbAE00w
        tI1Nv6klStVvyYynhpTW0k6Y2DchqrvYd/zzbhRVHxfgDmZlBEJmeyEg9o0yte253p7oWOajiF6
        jIOyUapurt3WV0tfFz8h0ciXkJNEHGGQUwk4smkbdiIjbBLdYPg8t7/LoEgj+6olKMqPYCruXNq
        MFhlJnPHeHj/t3l6j0K0xVQsM68c5F5A==
X-Google-Smtp-Source: ABdhPJwmAlJGz963vJJbAsHxv5O7uYV8rARc7Tt3ijVIBZ1KlYUmDPaRVgxz3RqpFVSgrGBWWdikukOBb3Zj
X-Received: by 2002:aa7:c60e:: with SMTP id h14mr14561694edq.43.1630337210535;
        Mon, 30 Aug 2021 08:26:50 -0700 (PDT)
Received: from mta1.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id p21sm194264ejy.180.2021.08.30.08.26.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 30 Aug 2021 08:26:50 -0700 (PDT)
X-Relaying-Domain: flowbird.group
Received: from [172.16.13.38] (port=37560 helo=PC12445-BES.dynamic.besancon.parkeon.com)
        by mta1.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1mKjBS-0005mz-0n; Mon, 30 Aug 2021 17:26:50 +0200
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
To:     linux-wireless@vger.kernel.org
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
        linux-kernel@vger.kernel.org,
        Martin Fuzzey <martin.fuzzey@flowbird.group>
Subject: [PATCH v2 3/3] rsi: fix rate mask set leading to P2P failure
Date:   Mon, 30 Aug 2021 17:26:46 +0200
Message-Id: <1630337206-12410-4-git-send-email-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1630337206-12410-1-git-send-email-martin.fuzzey@flowbird.group>
References: <1630337206-12410-1-git-send-email-martin.fuzzey@flowbird.group>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

P2P client mode was only working the first time.
On subsequent connection attempts the group was successfully created but
no data was sent (no transmitted data packets were seen with a sniffer).

The reason for this was that the hardware was being configured in fixed
rate mode with rate RSI_RATE_1 (1Mbps) which is not valid in the 5GHz band.

In P2P mode wpa_supplicant uses NL80211_CMD_SET_TX_BITRATE_MASK to disallow
the 11b rates in the 2.4GHz band which updated common->fixedrate_mask.

rsi_set_min_rate() then used the fixedrate_mask to calculate the minimum
allowed rate, or 0xffff = auto if none was found.
However that calculation did not account for the different rate sets
allowed in the different bands leading to the error.

Fixing set_min_rate() would result in 6Mb/s being used all the time
which is not what we want either.

The reason the problem did not occur on the first connection is that
rsi_mac80211_set_rate_mask() only updated the fixedrate_mask for
the *current* band. When it was called that was still 2.4GHz as the
switch is done later. So the when set_min_rate() was subsequently
called after the switch to 5GHz it still had a mask of zero, leading
to defaulting to auto mode.

Fix this by differentiating the case of a single rate being
requested, in which case the hardware will be used in fixed rate
mode with just that rate, and multiple rates being requested,
in which case we remain in auto mode but the firmware rate selection
algorithm is configured with a restricted set of rates.

Fixes: dad0d04fa7ba ("rsi: Add RS9113 wireless driver")
Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
CC: stable@vger.kernel.org
---
 drivers/net/wireless/rsi/rsi_91x_hal.c      |  8 ++--
 drivers/net/wireless/rsi/rsi_91x_mac80211.c | 74 +++++++++--------------------
 drivers/net/wireless/rsi/rsi_91x_mgmt.c     | 21 +++++---
 drivers/net/wireless/rsi/rsi_main.h         | 12 +++--
 4 files changed, 50 insertions(+), 65 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_hal.c b/drivers/net/wireless/rsi/rsi_91x_hal.c
index 2aa9f0b..dca81a4 100644
--- a/drivers/net/wireless/rsi/rsi_91x_hal.c
+++ b/drivers/net/wireless/rsi/rsi_91x_hal.c
@@ -214,15 +214,17 @@ int rsi_prepare_data_desc(struct rsi_common *common, struct sk_buff *skb)
 			RSI_WIFI_DATA_Q);
 	data_desc->header_len = ieee80211_size;
 
-	if (common->min_rate != RSI_RATE_AUTO) {
+	if (common->rate_config[common->band].fixed_enabled) {
 		/* Send fixed rate */
+		u16 fixed_rate = common->rate_config[common->band].fixed_hw_rate;
+
 		data_desc->frame_info = cpu_to_le16(RATE_INFO_ENABLE);
-		data_desc->rate_info = cpu_to_le16(common->min_rate);
+		data_desc->rate_info = cpu_to_le16(fixed_rate);
 
 		if (conf_is_ht40(&common->priv->hw->conf))
 			data_desc->bbp_info = cpu_to_le16(FULL40M_ENABLE);
 
-		if ((common->vif_info[0].sgi) && (common->min_rate & 0x100)) {
+		if (common->vif_info[0].sgi && (fixed_rate & 0x100)) {
 		       /* Only MCS rates */
 			data_desc->rate_info |=
 				cpu_to_le16(ENABLE_SHORTGI_RATE);
diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index b66975f..e70c1c7f 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -510,7 +510,6 @@ static int rsi_mac80211_add_interface(struct ieee80211_hw *hw,
 	if ((vif->type == NL80211_IFTYPE_AP) ||
 	    (vif->type == NL80211_IFTYPE_P2P_GO)) {
 		rsi_send_rx_filter_frame(common, DISALLOW_BEACONS);
-		common->min_rate = RSI_RATE_AUTO;
 		for (i = 0; i < common->max_stations; i++)
 			common->stations[i].sta = NULL;
 	}
@@ -1228,20 +1227,32 @@ static int rsi_mac80211_set_rate_mask(struct ieee80211_hw *hw,
 				      struct ieee80211_vif *vif,
 				      const struct cfg80211_bitrate_mask *mask)
 {
+	const unsigned int mcs_offset = ARRAY_SIZE(rsi_rates);
 	struct rsi_hw *adapter = hw->priv;
 	struct rsi_common *common = adapter->priv;
-	enum nl80211_band band = hw->conf.chandef.chan->band;
+	int i;
 
 	mutex_lock(&common->mutex);
-	common->fixedrate_mask[band] = 0;
 
-	if (mask->control[band].legacy == 0xfff) {
-		common->fixedrate_mask[band] =
-			(mask->control[band].ht_mcs[0] << 12);
-	} else {
-		common->fixedrate_mask[band] =
-			mask->control[band].legacy;
+	for (i = 0; i < ARRAY_SIZE(common->rate_config); i++) {
+		struct rsi_rate_config *cfg = &common->rate_config[i];
+		u32 bm;
+
+		bm = mask->control[i].legacy | (mask->control[i].ht_mcs[0] << mcs_offset);
+		if (hweight32(bm) == 1) { /* single rate */
+			int rate_index = ffs(bm) - 1;
+
+			if (rate_index < mcs_offset)
+				cfg->fixed_hw_rate = rsi_rates[rate_index].hw_value;
+			else
+				cfg->fixed_hw_rate = rsi_mcsrates[rate_index - mcs_offset];
+			cfg->fixed_enabled = true;
+		} else {
+			cfg->configured_mask = bm;
+			cfg->fixed_enabled = false;
+		}
 	}
+
 	mutex_unlock(&common->mutex);
 
 	return 0;
@@ -1378,46 +1389,6 @@ void rsi_indicate_pkt_to_os(struct rsi_common *common,
 	ieee80211_rx_irqsafe(hw, skb);
 }
 
-static void rsi_set_min_rate(struct ieee80211_hw *hw,
-			     struct ieee80211_sta *sta,
-			     struct rsi_common *common)
-{
-	u8 band = hw->conf.chandef.chan->band;
-	u8 ii;
-	u32 rate_bitmap;
-	bool matched = false;
-
-	common->bitrate_mask[band] = sta->supp_rates[band];
-
-	rate_bitmap = (common->fixedrate_mask[band] & sta->supp_rates[band]);
-
-	if (rate_bitmap & 0xfff) {
-		/* Find out the min rate */
-		for (ii = 0; ii < ARRAY_SIZE(rsi_rates); ii++) {
-			if (rate_bitmap & BIT(ii)) {
-				common->min_rate = rsi_rates[ii].hw_value;
-				matched = true;
-				break;
-			}
-		}
-	}
-
-	common->vif_info[0].is_ht = sta->ht_cap.ht_supported;
-
-	if ((common->vif_info[0].is_ht) && (rate_bitmap >> 12)) {
-		for (ii = 0; ii < ARRAY_SIZE(rsi_mcsrates); ii++) {
-			if ((rate_bitmap >> 12) & BIT(ii)) {
-				common->min_rate = rsi_mcsrates[ii];
-				matched = true;
-				break;
-			}
-		}
-	}
-
-	if (!matched)
-		common->min_rate = 0xffff;
-}
-
 /**
  * rsi_mac80211_sta_add() - This function notifies driver about a peer getting
  *			    connected.
@@ -1516,9 +1487,9 @@ static int rsi_mac80211_sta_add(struct ieee80211_hw *hw,
 
 	if ((vif->type == NL80211_IFTYPE_STATION) ||
 	    (vif->type == NL80211_IFTYPE_P2P_CLIENT)) {
-		rsi_set_min_rate(hw, sta, common);
+		common->bitrate_mask[common->band] = sta->supp_rates[common->band];
+		common->vif_info[0].is_ht = sta->ht_cap.ht_supported;
 		if (sta->ht_cap.ht_supported) {
-			common->vif_info[0].is_ht = true;
 			common->bitrate_mask[NL80211_BAND_2GHZ] =
 					sta->supp_rates[NL80211_BAND_2GHZ];
 			if ((sta->ht_cap.cap & IEEE80211_HT_CAP_SGI_20) ||
@@ -1592,7 +1563,6 @@ static int rsi_mac80211_sta_remove(struct ieee80211_hw *hw,
 		bss->qos = sta->wme;
 		common->bitrate_mask[NL80211_BAND_2GHZ] = 0;
 		common->bitrate_mask[NL80211_BAND_5GHZ] = 0;
-		common->min_rate = 0xffff;
 		common->vif_info[0].is_ht = false;
 		common->vif_info[0].sgi = false;
 		common->vif_info[0].seq_start = 0;
diff --git a/drivers/net/wireless/rsi/rsi_91x_mgmt.c b/drivers/net/wireless/rsi/rsi_91x_mgmt.c
index a25742a..0848f7a 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mgmt.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mgmt.c
@@ -276,7 +276,7 @@ static void rsi_set_default_parameters(struct rsi_common *common)
 	common->channel_width = BW_20MHZ;
 	common->rts_threshold = IEEE80211_MAX_RTS_THRESHOLD;
 	common->channel = 1;
-	common->min_rate = 0xffff;
+	memset(&common->rate_config, 0, sizeof(common->rate_config));
 	common->fsm_state = FSM_CARD_NOT_READY;
 	common->iface_down = true;
 	common->endpoint = EP_2GHZ_20MHZ;
@@ -1314,7 +1314,7 @@ static int rsi_send_auto_rate_request(struct rsi_common *common,
 	u8 band = hw->conf.chandef.chan->band;
 	u8 num_supported_rates = 0;
 	u8 rate_table_offset, rate_offset = 0;
-	u32 rate_bitmap;
+	u32 rate_bitmap, configured_rates;
 	u16 *selected_rates, min_rate;
 	bool is_ht = false, is_sgi = false;
 	u16 frame_len = sizeof(struct rsi_auto_rate);
@@ -1364,6 +1364,10 @@ static int rsi_send_auto_rate_request(struct rsi_common *common,
 			is_sgi = true;
 	}
 
+	/* Limit to any rates administratively configured by cfg80211 */
+	configured_rates = common->rate_config[band].configured_mask ?: 0xffffffff;
+	rate_bitmap &= configured_rates;
+
 	if (band == NL80211_BAND_2GHZ) {
 		if ((rate_bitmap == 0) && (is_ht))
 			min_rate = RSI_RATE_MCS0;
@@ -1389,10 +1393,13 @@ static int rsi_send_auto_rate_request(struct rsi_common *common,
 	num_supported_rates = jj;
 
 	if (is_ht) {
-		for (ii = 0; ii < ARRAY_SIZE(mcs); ii++)
-			selected_rates[jj++] = mcs[ii];
-		num_supported_rates += ARRAY_SIZE(mcs);
-		rate_offset += ARRAY_SIZE(mcs);
+		for (ii = 0; ii < ARRAY_SIZE(mcs); ii++) {
+			if (configured_rates & BIT(ii + ARRAY_SIZE(rsi_rates))) {
+				selected_rates[jj++] = mcs[ii];
+				num_supported_rates++;
+				rate_offset++;
+			}
+		}
 	}
 
 	sort(selected_rates, jj, sizeof(u16), &rsi_compare, NULL);
@@ -1482,7 +1489,7 @@ void rsi_inform_bss_status(struct rsi_common *common,
 					      qos_enable,
 					      aid, sta_id,
 					      vif);
-		if (common->min_rate == 0xffff)
+		if (!common->rate_config[common->band].fixed_enabled)
 			rsi_send_auto_rate_request(common, sta, sta_id, vif);
 		if (opmode == RSI_OPMODE_STA &&
 		    !(assoc_cap & WLAN_CAPABILITY_PRIVACY) &&
diff --git a/drivers/net/wireless/rsi/rsi_main.h b/drivers/net/wireless/rsi/rsi_main.h
index 810485a..dcf8fb4 100644
--- a/drivers/net/wireless/rsi/rsi_main.h
+++ b/drivers/net/wireless/rsi/rsi_main.h
@@ -61,6 +61,7 @@ enum RSI_FSM_STATES {
 extern u32 rsi_zone_enabled;
 extern __printf(2, 3) void rsi_dbg(u32 zone, const char *fmt, ...);
 
+#define RSI_MAX_BANDS			2
 #define RSI_MAX_VIFS                    3
 #define NUM_EDCA_QUEUES                 4
 #define IEEE80211_ADDR_LEN              6
@@ -230,6 +231,12 @@ struct rsi_9116_features {
 	u32 ps_options;
 };
 
+struct rsi_rate_config {
+	u32 configured_mask;	/* configured by mac80211 bits 0-11=legacy 12+ mcs */
+	u16 fixed_hw_rate;
+	bool fixed_enabled;
+};
+
 struct rsi_common {
 	struct rsi_hw *priv;
 	struct vif_priv vif_info[RSI_MAX_VIFS];
@@ -255,8 +262,8 @@ struct rsi_common {
 	u8 channel_width;
 
 	u16 rts_threshold;
-	u16 bitrate_mask[2];
-	u32 fixedrate_mask[2];
+	u32 bitrate_mask[RSI_MAX_BANDS];
+	struct rsi_rate_config rate_config[RSI_MAX_BANDS];
 
 	u8 rf_reset;
 	struct transmit_q_stats tx_stats;
@@ -277,7 +284,6 @@ struct rsi_common {
 	u8 mac_id;
 	u8 radio_id;
 	u16 rate_pwr[20];
-	u16 min_rate;
 
 	/* WMM algo related */
 	u8 selected_qnum;
-- 
1.9.1

