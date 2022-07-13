Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334DB57335B
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbiGMJq3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiGMJpc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:32 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE27E0279
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=IBOQ418tE56q8szLN9lqkFLIhYwqB3RBHJTKCj1uteo=;
        t=1657705525; x=1658915125; b=LarnNZjeeknB3nJ1EXvV9rJwXp+ONU0ROSpfYbSD/Gdn4Ts
        5R0slB0dwj+NhC/uLOis/rMj3NKIX3OJRphB4i0p26lZCxHlDXc4yL+OA9teKWVIvOSrn4iYp9Yno
        0XxMkv0Y+k1b3mwP+DS8BD/2i0ms81kTCm68jLXUSLwyWdRCfceLwwcW7aLPfocwWOucOoBqTkJ1s
        VlWPeTgFRZX/vaegmgvIFtEircbIqpwteCv3TTyOpQOsZnLEdvBzge/teYwVQSbpaoUPbdk9uFOoy
        huo4Jz0wyxAz0oO3LuGCZjQGs3C4pCK4hJP23sEthii1Jk1bpgC+DqaxDmCrYUlQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvr-00EgvB-Fr;
        Wed, 13 Jul 2022 11:45:23 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 53/76] wifi: mac80211: refactor adding rates to assoc request
Date:   Wed, 13 Jul 2022 11:44:39 +0200
Message-Id: <20220713114425.7cbc8a87848d.I7e9c71b58c7bc510f967c28fc82bf37acc01f3e1@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's some awkward code that really only exists
because we want to optimize the allocation size,
but that's not really all that necessary.

Refactor the code that adds rates to the association
request frame to have a separate function, removing
the goto.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 141 +++++++++++++++++++++++---------------------
 1 file changed, 74 insertions(+), 67 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index c65fe9f6f000..a442de3670b9 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -770,6 +770,75 @@ static void ieee80211_add_eht_ie(struct ieee80211_link_data *link,
 	ieee80211_ie_build_eht_cap(pos, he_cap, eht_cap, pos + eht_cap_size);
 }
 
+static void ieee80211_assoc_add_rates(struct sk_buff *skb,
+				      enum nl80211_chan_width width,
+				      struct ieee80211_supported_band *sband,
+				      struct ieee80211_mgd_assoc_data *assoc_data)
+{
+	unsigned int shift = ieee80211_chanwidth_get_shift(width);
+	unsigned int rates_len, supp_rates_len;
+	u32 rates = 0;
+	int i, count;
+	u8 *pos;
+
+	if (assoc_data->supp_rates_len) {
+		/*
+		 * Get all rates supported by the device and the AP as
+		 * some APs don't like getting a superset of their rates
+		 * in the association request (e.g. D-Link DAP 1353 in
+		 * b-only mode)...
+		 */
+		rates_len = ieee80211_parse_bitrates(width, sband,
+						     assoc_data->supp_rates,
+						     assoc_data->supp_rates_len,
+						     &rates);
+	} else {
+		/*
+		 * In case AP not provide any supported rates information
+		 * before association, we send information element(s) with
+		 * all rates that we support.
+		 */
+		rates_len = sband->n_bitrates;
+		for (i = 0; i < sband->n_bitrates; i++)
+			rates |= BIT(i);
+	}
+
+	supp_rates_len = rates_len;
+	if (supp_rates_len > 8)
+		supp_rates_len = 8;
+
+	pos = skb_put(skb, supp_rates_len + 2);
+	*pos++ = WLAN_EID_SUPP_RATES;
+	*pos++ = supp_rates_len;
+
+	count = 0;
+	for (i = 0; i < sband->n_bitrates; i++) {
+		if (BIT(i) & rates) {
+			int rate = DIV_ROUND_UP(sband->bitrates[i].bitrate,
+						5 * (1 << shift));
+			*pos++ = (u8)rate;
+			if (++count == 8)
+				break;
+		}
+	}
+
+	if (rates_len > count) {
+		pos = skb_put(skb, rates_len - count + 2);
+		*pos++ = WLAN_EID_EXT_SUPP_RATES;
+		*pos++ = rates_len - count;
+
+		for (i++; i < sband->n_bitrates; i++) {
+			if (BIT(i) & rates) {
+				int rate;
+
+				rate = DIV_ROUND_UP(sband->bitrates[i].bitrate,
+						    5 * (1 << shift));
+				*pos++ = (u8)rate;
+			}
+		}
+	}
+}
+
 static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_local *local = sdata->local;
@@ -779,12 +848,11 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_mgmt *mgmt;
 	u8 *pos, qos_info, *ie_start;
 	size_t offset = 0, noffset;
-	int i, count, rates_len, supp_rates_len, shift;
+	int i;
 	u16 capab;
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct ieee80211_channel *chan;
-	u32 rates = 0;
 	__le16 listen_int;
 	struct element *ext_capa = NULL;
 	enum nl80211_iftype iftype = ieee80211_vif_type_p2p(&sdata->vif);
@@ -810,39 +878,13 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	chan = chanctx_conf->def.chan;
 	rcu_read_unlock();
 	sband = local->hw.wiphy->bands[chan->band];
-	shift = ieee80211_vif_get_shift(&sdata->vif);
-
-	if (assoc_data->supp_rates_len) {
-		/*
-		 * Get all rates supported by the device and the AP as
-		 * some APs don't like getting a superset of their rates
-		 * in the association request (e.g. D-Link DAP 1353 in
-		 * b-only mode)...
-		 */
-		rates_len = ieee80211_parse_bitrates(chanctx_conf->def.width,
-						     sband,
-						     assoc_data->supp_rates,
-						     assoc_data->supp_rates_len,
-						     &rates);
-	} else {
-		/*
-		 * In case AP not provide any supported rates information
-		 * before association, we send information element(s) with
-		 * all rates that we support.
-		 */
-		rates_len = 0;
-		for (i = 0; i < sband->n_bitrates; i++) {
-			rates |= BIT(i);
-			rates_len++;
-		}
-	}
 
 	iftd = ieee80211_get_sband_iftype_data(sband, iftype);
 
 	skb = alloc_skb(local->hw.extra_tx_headroom +
 			sizeof(*mgmt) + /* bit too much but doesn't matter */
 			2 + assoc_data->ssid_len + /* SSID */
-			4 + rates_len + /* (extended) rates */
+			4 + sband->n_bitrates + /* (extended) rates */
 			4 + /* power capability */
 			2 + 2 * sband->n_channels + /* supported channels */
 			2 + sizeof(struct ieee80211_ht_cap) + /* HT */
@@ -911,45 +953,10 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	*pos++ = assoc_data->ssid_len;
 	memcpy(pos, assoc_data->ssid, assoc_data->ssid_len);
 
-	if (sband->band == NL80211_BAND_S1GHZ)
-		goto skip_rates;
-
-	/* add all rates which were marked to be used above */
-	supp_rates_len = rates_len;
-	if (supp_rates_len > 8)
-		supp_rates_len = 8;
-
-	pos = skb_put(skb, supp_rates_len + 2);
-	*pos++ = WLAN_EID_SUPP_RATES;
-	*pos++ = supp_rates_len;
-
-	count = 0;
-	for (i = 0; i < sband->n_bitrates; i++) {
-		if (BIT(i) & rates) {
-			int rate = DIV_ROUND_UP(sband->bitrates[i].bitrate,
-						5 * (1 << shift));
-			*pos++ = (u8) rate;
-			if (++count == 8)
-				break;
-		}
-	}
-
-	if (rates_len > count) {
-		pos = skb_put(skb, rates_len - count + 2);
-		*pos++ = WLAN_EID_EXT_SUPP_RATES;
-		*pos++ = rates_len - count;
-
-		for (i++; i < sband->n_bitrates; i++) {
-			if (BIT(i) & rates) {
-				int rate;
-				rate = DIV_ROUND_UP(sband->bitrates[i].bitrate,
-						    5 * (1 << shift));
-				*pos++ = (u8) rate;
-			}
-		}
-	}
+	if (sband->band != NL80211_BAND_S1GHZ)
+		ieee80211_assoc_add_rates(skb, chanctx_conf->def.width,
+					  sband, assoc_data);
 
-skip_rates:
 	if (capab & WLAN_CAPABILITY_SPECTRUM_MGMT ||
 	    capab & WLAN_CAPABILITY_RADIO_MEASURE) {
 		pos = skb_put(skb, 4);
-- 
2.36.1

