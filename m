Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5239573A3D
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 17:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbiGMPe4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 11:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236953AbiGMPeo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 11:34:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167C74D141
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=C2Wce6sXZ+PzZgeWx+oU5YujEGCViiUVKyqEEqUlbGY=;
        t=1657726483; x=1658936083; b=sfrhd1iURG/1dypIazDSfV892RxuiduLfYHHb64A2l7Pjl7
        Y99Lc3EwD0hv/Ty6ur6sV30h4nPYqY1jCw6gk/5pNzxEqECuTX0Ga5ErWejCvn53aotGDDkToPDjE
        LrcQUSzoNj71auj6XWXf5Zt6MsfuG1mCgk6M7MYfJUBWcqp1dSsAgpU9d0DqkisG0P+PxkzaqcEof
        g85DcKvWOK7CNRuAb58XaL8YMHu66NKKfkIPNbiH5/PtlzP269g2uyG0eIDJuEI6fACR+/k4SuvBq
        Gj3gfzpnWtB2WNasex+YnKPuZOqP5Zvm4X6QObTHNll/8H4iqJlSSALJW7wORw6w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBeNt-00EnaA-25;
        Wed, 13 Jul 2022 17:34:41 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 15/21] wifi: mac80211: mlme: refactor ieee80211_prep_channel() a bit
Date:   Wed, 13 Jul 2022 17:34:27 +0200
Message-Id: <20220713173301.d1c18ba15a6e.I84e9c2a7bee6a956a20bd5ceaa87fdf53add9203@changeid>
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

Refactor ieee80211_prep_channel() to make the link argument
optional and add a conn_flags pointer argument instead, so
that we can later use this for links that don't exist yet
to build the right information for MLO.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 81 ++++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 37 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 26c354e1b042..308b4ede10b9 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3887,7 +3887,8 @@ ieee80211_verify_sta_he_mcs_support(struct ieee80211_sub_if_data *sdata,
 
 static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 				  struct ieee80211_link_data *link,
-				  struct cfg80211_bss *cbss)
+				  struct cfg80211_bss *cbss,
+				  ieee80211_conn_flags_t *conn_flags)
 {
 	struct ieee80211_local *local = sdata->local;
 	const struct ieee80211_ht_cap *ht_cap = NULL;
@@ -3918,73 +3919,73 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 
 	sband = local->hw.wiphy->bands[cbss->channel->band];
 
-	link->u.mgd.conn_flags &= ~(IEEE80211_CONN_DISABLE_40MHZ |
-					     IEEE80211_CONN_DISABLE_80P80MHZ |
-					     IEEE80211_CONN_DISABLE_160MHZ);
+	*conn_flags &= ~(IEEE80211_CONN_DISABLE_40MHZ |
+			 IEEE80211_CONN_DISABLE_80P80MHZ |
+			 IEEE80211_CONN_DISABLE_160MHZ);
 
 	/* disable HT/VHT/HE if we don't support them */
 	if (!sband->ht_cap.ht_supported && !is_6ghz) {
 		mlme_dbg(sdata, "HT not supported, disabling HT/VHT/HE/EHT\n");
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+		*conn_flags |= IEEE80211_CONN_DISABLE_HT;
+		*conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+		*conn_flags |= IEEE80211_CONN_DISABLE_HE;
+		*conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 	}
 
 	if (!sband->vht_cap.vht_supported && is_5ghz) {
 		mlme_dbg(sdata, "VHT not supported, disabling VHT/HE/EHT\n");
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+		*conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+		*conn_flags |= IEEE80211_CONN_DISABLE_HE;
+		*conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 	}
 
 	if (!ieee80211_get_he_iftype_cap(sband,
 					 ieee80211_vif_type_p2p(&sdata->vif))) {
 		mlme_dbg(sdata, "HE not supported, disabling HE and EHT\n");
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+		*conn_flags |= IEEE80211_CONN_DISABLE_HE;
+		*conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 	}
 
 	if (!ieee80211_get_eht_iftype_cap(sband,
 					  ieee80211_vif_type_p2p(&sdata->vif))) {
 		mlme_dbg(sdata, "EHT not supported, disabling EHT\n");
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+		*conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 	}
 
-	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT) && !is_6ghz) {
+	if (!(*conn_flags & IEEE80211_CONN_DISABLE_HT) && !is_6ghz) {
 		ht_oper = elems->ht_operation;
 		ht_cap = elems->ht_cap_elem;
 
 		if (!ht_cap) {
-			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
+			*conn_flags |= IEEE80211_CONN_DISABLE_HT;
 			ht_oper = NULL;
 		}
 	}
 
-	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT) && !is_6ghz) {
+	if (!(*conn_flags & IEEE80211_CONN_DISABLE_VHT) && !is_6ghz) {
 		vht_oper = elems->vht_operation;
 		if (vht_oper && !ht_oper) {
 			vht_oper = NULL;
 			sdata_info(sdata,
 				   "AP advertised VHT without HT, disabling HT/VHT/HE\n");
-			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
-			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
-			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+			*conn_flags |= IEEE80211_CONN_DISABLE_HT;
+			*conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+			*conn_flags |= IEEE80211_CONN_DISABLE_HE;
+			*conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 		}
 
 		if (!elems->vht_cap_elem) {
 			sdata_info(sdata,
 				   "bad VHT capabilities, disabling VHT\n");
-			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+			*conn_flags |= IEEE80211_CONN_DISABLE_VHT;
 			vht_oper = NULL;
 		}
 	}
 
-	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE)) {
+	if (!(*conn_flags & IEEE80211_CONN_DISABLE_HE)) {
 		he_oper = elems->he_operation;
 
-		if (is_6ghz) {
+		if (link && is_6ghz) {
 			struct ieee80211_bss_conf *bss_conf;
 			u8 j = 0;
 
@@ -4010,8 +4011,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 
 		if (!ieee80211_verify_peer_he_mcs_support(sdata, ies, he_oper) ||
 		    !ieee80211_verify_sta_he_mcs_support(sdata, sband, he_oper))
-			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE |
-						  IEEE80211_CONN_DISABLE_EHT;
+			*conn_flags |= IEEE80211_CONN_DISABLE_HE |
+				       IEEE80211_CONN_DISABLE_EHT;
 	}
 
 	/*
@@ -4020,7 +4021,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	 * both the 6 GHz operation information (from the HE operation IE) and
 	 * EHT operation.
 	 */
-	if (!(link->u.mgd.conn_flags &
+	if (!(*conn_flags &
 			(IEEE80211_CONN_DISABLE_HE |
 			 IEEE80211_CONN_DISABLE_EHT)) &&
 	    he_oper) {
@@ -4050,7 +4051,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 
 	if (!have_80mhz) {
 		sdata_info(sdata, "80 MHz not supported, disabling VHT\n");
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+		*conn_flags |= IEEE80211_CONN_DISABLE_VHT;
 	}
 
 	if (sband->band == NL80211_BAND_S1GHZ) {
@@ -4060,29 +4061,34 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 				   "AP missing S1G operation element?\n");
 	}
 
-	link->u.mgd.conn_flags |=
-		ieee80211_determine_chantype(sdata, link,
-					     link->u.mgd.conn_flags,
-					     sband, cbss->channel,
+	*conn_flags |=
+		ieee80211_determine_chantype(sdata, link, *conn_flags,
+					     sband,
+					     cbss->channel,
 					     bss->vht_cap_info,
 					     ht_oper, vht_oper,
 					     he_oper, eht_oper,
 					     s1g_oper,
 					     &chandef, false);
 
-	link->needed_rx_chains =
-		min(ieee80211_max_rx_chains(link, cbss), local->rx_chains);
+	if (link)
+		link->needed_rx_chains =
+			min(ieee80211_max_rx_chains(link, cbss),
+			    local->rx_chains);
 
 	rcu_read_unlock();
 	/* the element data was RCU protected so no longer valid anyway */
 	kfree(elems);
 	elems = NULL;
 
-	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE && is_6ghz) {
+	if (*conn_flags & IEEE80211_CONN_DISABLE_HE && is_6ghz) {
 		sdata_info(sdata, "Rejecting non-HE 6/7 GHz connection");
 		return -EINVAL;
 	}
 
+	if (!link)
+		return 0;
+
 	/* will change later if needed */
 	link->smps_mode = IEEE80211_SMPS_OFF;
 
@@ -4101,7 +4107,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		goto out;
 
 	while (ret && chandef.width != NL80211_CHAN_WIDTH_20_NOHT) {
-		link->u.mgd.conn_flags |=
+		*conn_flags |=
 			ieee80211_chandef_downgrade(&chandef);
 		ret = ieee80211_link_use_channel(link, &chandef,
 						 IEEE80211_CHANCTX_SHARED);
@@ -5929,7 +5935,8 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (new_sta || override) {
-		err = ieee80211_prep_channel(sdata, link, cbss);
+		err = ieee80211_prep_channel(sdata, link, cbss,
+					     &link->u.mgd.conn_flags);
 		if (err) {
 			if (new_sta)
 				sta_info_free(local, new_sta);
-- 
2.36.1

