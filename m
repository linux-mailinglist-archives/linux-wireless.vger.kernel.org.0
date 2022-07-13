Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4A7573364
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbiGMJqj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbiGMJpf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108EEF6B9C
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=mAOFgOfRBaknxxFn4zSmw/a1Saw5PKXIgJyoiyGAQhQ=;
        t=1657705526; x=1658915126; b=gUldFmTXVSn6kgoQNyPPmIBIDLxhnrp0Qit8tLDmx4lWX7n
        RN1rbiLs6XnfHP+wqp9dMqputpsJDJp/1x4rHze9KrPQIFoDFpfd/yfCu+4cJhcqpUZtmY9DujKI+
        KLZOidiBkn4Tf7Z4ogSR4tPSNLo0GmzWQ+jhh63gPRjbq0o4D/tDqFwkgndbka1rjV7YdDkRgHx3z
        tw6UVqUtLOo8fsLis1lxh8soMAR/I4Qj9wqQA0HHHcy9jEM0Rkhky+coIkAsdSHxokU1BdKzX1jQa
        /AjXCadkT1e81H+8pc30O2mNr5Eb3uKrlyMg/ehE2F+xbS0jg1U/41cem8uJPa9w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvs-00EgvB-8u;
        Wed, 13 Jul 2022 11:45:24 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 55/76] wifi: mac80211: mlme: simplify adding ht/vht/he/eht elements
Date:   Wed, 13 Jul 2022 11:44:41 +0200
Message-Id: <20220713114425.d7236451605f.I9c3953eb2452c7564e81cd98a4e65d11e333db1a@changeid>
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

The functions currently take a link and check data
from it, but this needs to change for MLO. Simplify
the prototypes by passing only the needed arguments.

Remove the regulatory checks, the warnings shouldn't
trigger, and haven't as far as I know.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 79 ++++++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 48 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 36cce750528a..b56f2cefee44 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -524,13 +524,13 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 
 /* frame sending functions */
 
-static void ieee80211_add_ht_ie(struct ieee80211_link_data *link,
+static void ieee80211_add_ht_ie(struct ieee80211_sub_if_data *sdata,
 				struct sk_buff *skb, u8 ap_ht_param,
 				struct ieee80211_supported_band *sband,
 				struct ieee80211_channel *channel,
-				enum ieee80211_smps_mode smps)
+				enum ieee80211_smps_mode smps,
+				ieee80211_conn_flags_t conn_flags)
 {
-	struct ieee80211_sub_if_data *sdata = link->sdata;
 	u8 *pos;
 	u32 flags = channel->flags;
 	u16 cap;
@@ -564,7 +564,7 @@ static void ieee80211_add_ht_ie(struct ieee80211_link_data *link,
 	 * capable of 40 MHz -- some broken APs will never fall
 	 * back to trying to transmit in 20 MHz.
 	 */
-	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_40MHZ) {
+	if (conn_flags & IEEE80211_CONN_DISABLE_40MHZ) {
 		cap &= ~IEEE80211_HT_CAP_SUP_WIDTH_20_40;
 		cap &= ~IEEE80211_HT_CAP_SGI_40;
 	}
@@ -597,19 +597,20 @@ static void ieee80211_add_ht_ie(struct ieee80211_link_data *link,
 
 /* This function determines vht capability flags for the association
  * and builds the IE.
- * Note - the function may set the owner of the MU-MIMO capability
+ * Note - the function returns true to own the MU-MIMO capability
  */
-static void ieee80211_add_vht_ie(struct ieee80211_link_data *link,
+static bool ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 				 struct sk_buff *skb,
 				 struct ieee80211_supported_band *sband,
-				 struct ieee80211_vht_cap *ap_vht_cap)
+				 struct ieee80211_vht_cap *ap_vht_cap,
+				 ieee80211_conn_flags_t conn_flags)
 {
-	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	u8 *pos;
 	u32 cap;
 	struct ieee80211_sta_vht_cap vht_cap;
 	u32 mask, ap_bf_sts, our_bf_sts;
+	bool mu_mimo_owner = false;
 
 	BUILD_BUG_ON(sizeof(vht_cap) != sizeof(sband->vht_cap));
 
@@ -619,7 +620,7 @@ static void ieee80211_add_vht_ie(struct ieee80211_link_data *link,
 	/* determine capability flags */
 	cap = vht_cap.cap;
 
-	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_80P80MHZ) {
+	if (conn_flags & IEEE80211_CONN_DISABLE_80P80MHZ) {
 		u32 bw = cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
 
 		cap &= ~IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
@@ -628,7 +629,7 @@ static void ieee80211_add_vht_ie(struct ieee80211_link_data *link,
 			cap |= IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ;
 	}
 
-	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_160MHZ) {
+	if (conn_flags & IEEE80211_CONN_DISABLE_160MHZ) {
 		cap &= ~IEEE80211_VHT_CAP_SHORT_GI_160;
 		cap &= ~IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
 	}
@@ -665,7 +666,7 @@ static void ieee80211_add_vht_ie(struct ieee80211_link_data *link,
 		if (disable_mu_mimo)
 			cap &= ~IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE;
 		else
-			link->conf->mu_mimo_owner = true;
+			mu_mimo_owner = true;
 	}
 
 	mask = IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK;
@@ -681,34 +682,25 @@ static void ieee80211_add_vht_ie(struct ieee80211_link_data *link,
 	/* reserve and fill IE */
 	pos = skb_put(skb, sizeof(struct ieee80211_vht_cap) + 2);
 	ieee80211_ie_build_vht_cap(pos, &vht_cap, cap);
+
+	return mu_mimo_owner;
 }
 
 /* This function determines HE capability flags for the association
  * and builds the IE.
  */
-static void ieee80211_add_he_ie(struct ieee80211_link_data *link,
+static void ieee80211_add_he_ie(struct ieee80211_sub_if_data *sdata,
 				struct sk_buff *skb,
-				struct ieee80211_supported_band *sband)
+				struct ieee80211_supported_band *sband,
+				ieee80211_conn_flags_t conn_flags)
 {
-	struct ieee80211_sub_if_data *sdata = link->sdata;
 	u8 *pos, *pre_he_pos;
-	const struct ieee80211_sta_he_cap *he_cap = NULL;
-	struct ieee80211_chanctx_conf *chanctx_conf;
+	const struct ieee80211_sta_he_cap *he_cap;
 	u8 he_cap_size;
-	bool reg_cap = false;
-
-	rcu_read_lock();
-	chanctx_conf = rcu_dereference(link->conf->chanctx_conf);
-	if (!WARN_ON_ONCE(!chanctx_conf))
-		reg_cap = cfg80211_chandef_usable(sdata->wdev.wiphy,
-						  &chanctx_conf->def,
-						  IEEE80211_CHAN_NO_HE);
-
-	rcu_read_unlock();
 
 	he_cap = ieee80211_get_he_iftype_cap(sband,
 					     ieee80211_vif_type_p2p(&sdata->vif));
-	if (!he_cap || !chanctx_conf || !reg_cap)
+	if (WARN_ON(!he_cap))
 		return;
 
 	/* get a max size estimate */
@@ -719,7 +711,7 @@ static void ieee80211_add_he_ie(struct ieee80211_link_data *link,
 				      he_cap->he_cap_elem.phy_cap_info);
 	pos = skb_put(skb, he_cap_size);
 	pre_he_pos = pos;
-	pos = ieee80211_ie_build_he_cap(link->u.mgd.conn_flags,
+	pos = ieee80211_ie_build_he_cap(conn_flags,
 					pos, he_cap, pos + he_cap_size);
 	/* trim excess if any */
 	skb_trim(skb, skb->len - (pre_he_pos + he_cap_size - pos));
@@ -727,26 +719,14 @@ static void ieee80211_add_he_ie(struct ieee80211_link_data *link,
 	ieee80211_ie_build_he_6ghz_cap(sdata, skb);
 }
 
-static void ieee80211_add_eht_ie(struct ieee80211_link_data *link,
+static void ieee80211_add_eht_ie(struct ieee80211_sub_if_data *sdata,
 				 struct sk_buff *skb,
 				 struct ieee80211_supported_band *sband)
 {
-	struct ieee80211_sub_if_data *sdata = link->sdata;
 	u8 *pos;
 	const struct ieee80211_sta_he_cap *he_cap;
 	const struct ieee80211_sta_eht_cap *eht_cap;
-	struct ieee80211_chanctx_conf *chanctx_conf;
 	u8 eht_cap_size;
-	bool reg_cap = false;
-
-	rcu_read_lock();
-	chanctx_conf = rcu_dereference(link->conf->chanctx_conf);
-	if (!WARN_ON_ONCE(!chanctx_conf))
-		reg_cap = cfg80211_chandef_usable(sdata->wdev.wiphy,
-						  &chanctx_conf->def,
-						  IEEE80211_CHAN_NO_HE |
-						  IEEE80211_CHAN_NO_EHT);
-	rcu_read_unlock();
 
 	he_cap = ieee80211_get_he_iftype_cap(sband,
 					     ieee80211_vif_type_p2p(&sdata->vif));
@@ -757,7 +737,7 @@ static void ieee80211_add_eht_ie(struct ieee80211_link_data *link,
 	 * EHT capabilities element is only added if the HE capabilities element
 	 * was added so assume that 'he_cap' is valid and don't check it.
 	 */
-	if (WARN_ON(!he_cap || !eht_cap || !reg_cap))
+	if (WARN_ON(!he_cap || !eht_cap))
 		return;
 
 	eht_cap_size =
@@ -1118,8 +1098,9 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 
 	if (sband->band != NL80211_BAND_6GHZ &&
 	    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT))
-		ieee80211_add_ht_ie(link, skb, assoc_data->ap_ht_param,
-				    sband, chan, link->smps_mode);
+		ieee80211_add_ht_ie(sdata, skb, assoc_data->ap_ht_param,
+				    sband, chan, link->smps_mode,
+				    link->u.mgd.conn_flags);
 
 	/* if present, add any custom IEs that go before VHT */
 	offset = ieee80211_add_before_vht_elems(skb, assoc_data->ie,
@@ -1128,8 +1109,10 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 
 	if (sband->band != NL80211_BAND_6GHZ &&
 	    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
-		ieee80211_add_vht_ie(link, skb, sband,
-				     &assoc_data->ap_vht_cap);
+		link->conf->mu_mimo_owner =
+			ieee80211_add_vht_ie(sdata, skb, sband,
+					     &assoc_data->ap_vht_cap,
+					     link->u.mgd.conn_flags);
 
 	/*
 	 * If AP doesn't support HT, mark HE and EHT as disabled.
@@ -1147,10 +1130,10 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 					       offset);
 
 	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE)) {
-		ieee80211_add_he_ie(link, skb, sband);
+		ieee80211_add_he_ie(sdata, skb, sband, link->u.mgd.conn_flags);
 
 		if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT))
-			ieee80211_add_eht_ie(link, skb, sband);
+			ieee80211_add_eht_ie(sdata, skb, sband);
 	}
 
 	/* if present, add any custom non-vendor IEs that go after HE */
-- 
2.36.1

