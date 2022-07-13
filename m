Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93895573A46
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 17:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbiGMPev (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 11:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbiGMPen (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 11:34:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914E430F46
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=IBwzJ2pYjQdKlLTvLxk5WbODqcT3/OVmRQWSGr+aRTE=;
        t=1657726481; x=1658936081; b=ug15WYw3mhgtLnTyd0IeXd5IxY+B+vsYNvdQNfgvus9H6fX
        dB4yPLGGF019EUP3DJMiKEgs++Ib34JKUh3n5a2Yyx/S/TYwUXaII9hZ3idbgVCv6CbSWJvcn/SBP
        NilZ3ES4lck5905++RyQ1KiEQ5sABO3wRpKujTB/1EmA3+xSjsyWRM61Sa/mk1OvvN0LPBYow/BXJ
        zWfXF2ytlfogPB+qeafhoNABs1KxWuyipYz/fV4Lx9fmTHONyL7bP5JExmurwMZJDRugnkZ23DXgr
        fw3TL7MeQT3kYjglA0b4YM2yn9sjGauboxF8dxRRXv79OaS0dUMFNcy5waoRPSfw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBeNr-00EnaA-Mw;
        Wed, 13 Jul 2022 17:34:39 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/21] wifi: mac80211: mlme: refactor link station setup
Date:   Wed, 13 Jul 2022 17:34:22 +0200
Message-Id: <20220713173301.c21bda9e2df3.I3a34da939f6aa4772c07b59e9aaaa08601c20ddb@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713153433.279227-1-johannes@sipsolutions.net>
References: <20220713153433.279227-1-johannes@sipsolutions.net>
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

Refactor the code here since we need to have it also for each
link station after association in MLO later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 119 ++++++++++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 54 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 6822bf1c3cae..78b8fcd5fdb2 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3484,6 +3484,67 @@ static bool ieee80211_twt_bcast_support(struct ieee80211_sub_if_data *sdata,
 			IEEE80211_HE_MAC_CAP2_BCAST_TWT);
 }
 
+static int ieee80211_mgd_setup_link_sta(struct ieee80211_link_data *link,
+					struct sta_info *sta,
+					struct ieee80211_link_sta *link_sta,
+					struct cfg80211_bss *cbss)
+{
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_bss *bss = (void *)cbss->priv;
+	u32 rates = 0, basic_rates = 0;
+	bool have_higher_than_11mbit = false;
+	int min_rate = INT_MAX, min_rate_index = -1;
+	/* this is clearly wrong for MLO but we'll just remove it later */
+	int shift = ieee80211_vif_get_shift(&sdata->vif);
+	struct ieee80211_supported_band *sband;
+
+	memcpy(link_sta->addr, cbss->bssid, ETH_ALEN);
+
+	/* TODO: S1G Basic Rate Set is expressed elsewhere */
+	if (cbss->channel->band == NL80211_BAND_S1GHZ) {
+		ieee80211_s1g_sta_rate_init(sta);
+		return 0;
+	}
+
+	sband = local->hw.wiphy->bands[cbss->channel->band];
+
+	ieee80211_get_rates(sband, bss->supp_rates, bss->supp_rates_len,
+			    &rates, &basic_rates, &have_higher_than_11mbit,
+			    &min_rate, &min_rate_index, shift);
+
+	/*
+	 * This used to be a workaround for basic rates missing
+	 * in the association response frame. Now that we no
+	 * longer use the basic rates from there, it probably
+	 * doesn't happen any more, but keep the workaround so
+	 * in case some *other* APs are buggy in different ways
+	 * we can connect -- with a warning.
+	 * Allow this workaround only in case the AP provided at least
+	 * one rate.
+	 */
+	if (min_rate_index < 0) {
+		link_info(link, "No legacy rates in association response\n");
+		return -EINVAL;
+	} else if (!basic_rates) {
+		link_info(link, "No basic rates, using min rate instead\n");
+		basic_rates = BIT(min_rate_index);
+	}
+
+	if (rates)
+		link_sta->supp_rates[cbss->channel->band] = rates;
+	else
+		link_info(link, "No rates found, keeping mandatory only\n");
+
+	link->conf->basic_rates = basic_rates;
+
+	/* cf. IEEE 802.11 9.2.12 */
+	link->operating_11g_mode = sband->band == NL80211_BAND_2GHZ &&
+				   have_higher_than_11mbit;
+
+	return 0;
+}
+
 static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 				    struct cfg80211_bss *cbss,
 				    struct ieee80211_mgmt *mgmt, size_t len,
@@ -5717,13 +5778,10 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_bss *bss = (void *)cbss->priv;
 	struct sta_info *new_sta = NULL;
-	struct ieee80211_supported_band *sband;
 	struct ieee80211_link_data *link = &sdata->deflink;
 	bool have_sta = false;
 	int err;
 
-	sband = local->hw.wiphy->bands[cbss->channel->band];
-
 	if (WARN_ON(!ifmgd->auth_data && !ifmgd->assoc_data))
 		return -EINVAL;
 
@@ -5757,63 +5815,16 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 	 * it might need the new channel for that.
 	 */
 	if (new_sta) {
-		u32 rates = 0, basic_rates = 0;
-		bool have_higher_than_11mbit = false;
-		int min_rate = INT_MAX, min_rate_index = -1;
 		const struct cfg80211_bss_ies *ies;
-		int shift = ieee80211_vif_get_shift(&sdata->vif);
 		struct ieee80211_link_sta *link_sta = &new_sta->sta.deflink;
 
-		memcpy(link_sta->addr, cbss->bssid, ETH_ALEN);
-
-		/* TODO: S1G Basic Rate Set is expressed elsewhere */
-		if (cbss->channel->band == NL80211_BAND_S1GHZ) {
-			ieee80211_s1g_sta_rate_init(new_sta);
-			goto skip_rates;
-		}
-
-		ieee80211_get_rates(sband, bss->supp_rates,
-				    bss->supp_rates_len,
-				    &rates, &basic_rates,
-				    &have_higher_than_11mbit,
-				    &min_rate, &min_rate_index,
-				    shift);
-
-		/*
-		 * This used to be a workaround for basic rates missing
-		 * in the association response frame. Now that we no
-		 * longer use the basic rates from there, it probably
-		 * doesn't happen any more, but keep the workaround so
-		 * in case some *other* APs are buggy in different ways
-		 * we can connect -- with a warning.
-		 * Allow this workaround only in case the AP provided at least
-		 * one rate.
-		 */
-		if (min_rate_index < 0) {
-			sdata_info(sdata,
-				   "No legacy rates in association response\n");
-
+		err = ieee80211_mgd_setup_link_sta(link, new_sta,
+						   link_sta, cbss);
+		if (err) {
 			sta_info_free(local, new_sta);
-			return -EINVAL;
-		} else if (!basic_rates) {
-			sdata_info(sdata,
-				   "No basic rates, using min rate instead\n");
-			basic_rates = BIT(min_rate_index);
+			return err;
 		}
 
-		if (rates)
-			link_sta->supp_rates[cbss->channel->band] = rates;
-		else
-			sdata_info(sdata,
-				   "No rates found, keeping mandatory only\n");
-
-		link->conf->basic_rates = basic_rates;
-
-		/* cf. IEEE 802.11 9.2.12 */
-		link->operating_11g_mode = sband->band == NL80211_BAND_2GHZ &&
-					   have_higher_than_11mbit;
-
-skip_rates:
 		memcpy(link->u.mgd.bssid, cbss->bssid, ETH_ALEN);
 
 		/* set timing information */
-- 
2.36.1

