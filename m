Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69367573A3F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 17:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbiGMPev (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 11:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236945AbiGMPen (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 11:34:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAD34B0E2
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=6nXTKEIE53vQkJfwYXrTV8vCLa+VW5ygDMmFJAiD4d8=;
        t=1657726481; x=1658936081; b=HQNRx5lZbsXr0juO5R7IZJOjUwZqoffmCP8Mk/clBH3uF9+
        WJVMOyzzKcTQZVYmcSvd2YBBcz5Y6SQz1QpVw+nrXOTBQXCO34kaXbJBaQM+4AXIgXFmfU6ONvDA6
        xR2MrKInYJUCviFAzeznrOZOjV42VlgFkChTSkPdtUOwPHUD4DgMzdkVasmMwLluMGCFE9+9URxKm
        TGdWL/H+CfmNJNqG7Wo8B62AvvvvZDM1YWgXN/W7iwDOR3UVyKBb3u17B85T3R+Uvl4NAkca2QYUb
        w49nX0B+hAlt2fLsj1oa5Au59JtBPMAA0vfpKB5qS+1tVli+c0wdiMizZVlECIOQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBeNr-00EnaA-EH;
        Wed, 13 Jul 2022 17:34:39 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/21] wifi: mac80211: move IEEE80211_SDATA_OPERATING_GMODE to link
Date:   Wed, 13 Jul 2022 17:34:21 +0200
Message-Id: <20220713173301.5533c438e2a3.Ia6f6f76d35f30a669968cb7bdb3912c2a89227e2@changeid>
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

The flag here is currently per interface, but the way we
set and clear it means it should be per link, so change
it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ibss.c        | 6 ++----
 net/mac80211/ieee80211_i.h | 6 ++++--
 net/mac80211/mlme.c        | 7 ++-----
 net/mac80211/ocb.c         | 2 +-
 net/mac80211/tx.c          | 2 +-
 net/mac80211/util.c        | 8 ++++----
 6 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index e8df4ce33984..60b5230778a3 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -351,10 +351,8 @@ static void __ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 	bss_change |= BSS_CHANGED_ERP_SLOT;
 
 	/* cf. IEEE 802.11 9.2.12 */
-	if (chan->band == NL80211_BAND_2GHZ && have_higher_than_11mbit)
-		sdata->flags |= IEEE80211_SDATA_OPERATING_GMODE;
-	else
-		sdata->flags &= ~IEEE80211_SDATA_OPERATING_GMODE;
+	sdata->deflink.operating_11g_mode =
+		chan->band == NL80211_BAND_2GHZ && have_higher_than_11mbit;
 
 	ieee80211_set_wmm_default(&sdata->deflink, true, false);
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 877f2441b74b..baaff4c7a79c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -726,7 +726,6 @@ struct ieee80211_if_mesh {
  * enum ieee80211_sub_if_data_flags - virtual interface flags
  *
  * @IEEE80211_SDATA_ALLMULTI: interface wants all multicast packets
- * @IEEE80211_SDATA_OPERATING_GMODE: operating in G-only mode
  * @IEEE80211_SDATA_DONT_BRIDGE_PACKETS: bridge packets between
  *	associated stations and deliver multicast frames both
  *	back to wireless media and to the local net stack.
@@ -737,7 +736,6 @@ struct ieee80211_if_mesh {
  */
 enum ieee80211_sub_if_data_flags {
 	IEEE80211_SDATA_ALLMULTI		= BIT(0),
-	IEEE80211_SDATA_OPERATING_GMODE		= BIT(2),
 	IEEE80211_SDATA_DONT_BRIDGE_PACKETS	= BIT(3),
 	IEEE80211_SDATA_DISCONNECT_RESUME	= BIT(4),
 	IEEE80211_SDATA_IN_DRIVER		= BIT(5),
@@ -884,6 +882,7 @@ struct ieee80211_link_data_managed {
 	bool have_beacon;
 	bool tracking_signal_avg;
 	bool disable_wmm_tracking;
+	bool operating_11g_mode;
 
 	bool csa_waiting_bcn;
 	bool csa_ignored_same_chan;
@@ -946,6 +945,9 @@ struct ieee80211_link_data {
 
 	struct work_struct csa_finalize_work;
 	bool csa_block_tx; /* write-protected by sdata_lock and local->mtx */
+
+	bool operating_11g_mode;
+
 	struct cfg80211_chan_def csa_chandef;
 
 	struct work_struct color_change_finalize_work;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 3986bf70fc5c..6822bf1c3cae 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5810,11 +5810,8 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 		link->conf->basic_rates = basic_rates;
 
 		/* cf. IEEE 802.11 9.2.12 */
-		if (cbss->channel->band == NL80211_BAND_2GHZ &&
-		    have_higher_than_11mbit)
-			sdata->flags |= IEEE80211_SDATA_OPERATING_GMODE;
-		else
-			sdata->flags &= ~IEEE80211_SDATA_OPERATING_GMODE;
+		link->operating_11g_mode = sband->band == NL80211_BAND_2GHZ &&
+					   have_higher_than_11mbit;
 
 skip_rates:
 		memcpy(link->u.mgd.bssid, cbss->bssid, ETH_ALEN);
diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index 2ca2164a3098..8664fee699e9 100644
--- a/net/mac80211/ocb.c
+++ b/net/mac80211/ocb.c
@@ -181,7 +181,7 @@ int ieee80211_ocb_join(struct ieee80211_sub_if_data *sdata,
 	if (ifocb->joined == true)
 		return -EINVAL;
 
-	sdata->flags |= IEEE80211_SDATA_OPERATING_GMODE;
+	sdata->deflink.operating_11g_mode = true;
 	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
 	sdata->deflink.needed_rx_chains = sdata->local->rx_chains;
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index b9cb71dfa6cf..f10318cadd4c 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -148,7 +148,7 @@ static __le16 ieee80211_duration(struct ieee80211_tx_data *tx,
 		case NL80211_BAND_2GHZ:
 		case NL80211_BAND_LC: {
 			u32 flag;
-			if (tx->sdata->flags & IEEE80211_SDATA_OPERATING_GMODE)
+			if (tx->sdata->deflink.operating_11g_mode)
 				flag = IEEE80211_RATE_MANDATORY_G;
 			else
 				flag = IEEE80211_RATE_MANDATORY_B;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index b6ddcbbb22e8..a6963feaf75d 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -191,7 +191,7 @@ __le16 ieee80211_generic_frame_duration(struct ieee80211_hw *hw,
 	if (vif) {
 		sdata = vif_to_sdata(vif);
 		short_preamble = sdata->vif.bss_conf.use_short_preamble;
-		if (sdata->flags & IEEE80211_SDATA_OPERATING_GMODE)
+		if (sdata->deflink.operating_11g_mode)
 			erp = rate->flags & IEEE80211_RATE_ERP_G;
 		shift = ieee80211_vif_get_shift(vif);
 	}
@@ -225,7 +225,7 @@ __le16 ieee80211_rts_duration(struct ieee80211_hw *hw,
 	if (vif) {
 		sdata = vif_to_sdata(vif);
 		short_preamble = sdata->vif.bss_conf.use_short_preamble;
-		if (sdata->flags & IEEE80211_SDATA_OPERATING_GMODE)
+		if (sdata->deflink.operating_11g_mode)
 			erp = rate->flags & IEEE80211_RATE_ERP_G;
 		shift = ieee80211_vif_get_shift(vif);
 	}
@@ -268,7 +268,7 @@ __le16 ieee80211_ctstoself_duration(struct ieee80211_hw *hw,
 	if (vif) {
 		sdata = vif_to_sdata(vif);
 		short_preamble = sdata->vif.bss_conf.use_short_preamble;
-		if (sdata->flags & IEEE80211_SDATA_OPERATING_GMODE)
+		if (sdata->deflink.operating_11g_mode)
 			erp = rate->flags & IEEE80211_RATE_ERP_G;
 		shift = ieee80211_vif_get_shift(vif);
 	}
@@ -1614,7 +1614,7 @@ void ieee80211_set_wmm_default(struct ieee80211_link_data *link,
 	chanctx_conf = rcu_dereference(link->conf->chanctx_conf);
 	use_11b = (chanctx_conf &&
 		   chanctx_conf->def.chan->band == NL80211_BAND_2GHZ) &&
-		 !(sdata->flags & IEEE80211_SDATA_OPERATING_GMODE);
+		 !link->operating_11g_mode;
 	rcu_read_unlock();
 
 	is_ocb = (sdata->vif.type == NL80211_IFTYPE_OCB);
-- 
2.36.1

