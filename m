Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29187573346
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbiGMJp7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbiGMJpV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:21 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD56F5107
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=3oPbRuAzVvl0K9+eYjq+6gKlcWlwpNfi5wwXLYFatZI=;
        t=1657705516; x=1658915116; b=A5IDmXWr7gBDK+LXuhl/EDuYdEW3mwxCy5t2eFDfuGNQQ1K
        6dWkP5KnfsaM+mrr2MhoUdyEX4A3lzU5qvbPHGLILTjxdp7KC0PGzYtc3DarZQMTKEAY5pej19ZZx
        lCiCSzTnnetF0dkfm9Suk6R+X4yFbpaIcotgGTL08/dsM3oV/RcjlxqiklvXQMhVFpDYIbs9sOPoY
        WUBART36jQrWe5f+fzxmulZNcmwFtMKSx6fpsQd6G+5fd1XpRnd2LAi4RHfAsQ5zoAnbCEUKViAQ0
        6uQ5//ONk0Mq8OY+VYeStGbSW4NybI4ajJi8NwMZmhj2fJwp/n0lk6lQ/87VAWyg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvi-00EgvB-Fy;
        Wed, 13 Jul 2022 11:45:14 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 33/76] wifi: mac80211: mlme: first adjustments for MLO
Date:   Wed, 13 Jul 2022 11:44:19 +0200
Message-Id: <20220713114425.c20fc4556cea.I809a07f6c091f34f28d531a864cd483393f62e7e@changeid>
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

Do the first adjustments in the client-side code to pass
the link pointer (instead of sdata) to most places etc.

This is just preparation, so the real MLO patches become
smaller.

Note that this isn't complete, notably there are still
quite a few references to sta->deflink and sta->sta.deflink.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c        |   2 +-
 net/mac80211/ieee80211_i.h |   4 +-
 net/mac80211/mlme.c        | 765 ++++++++++++++++++++-----------------
 3 files changed, 408 insertions(+), 363 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 8d384956fde5..92fe40539091 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1188,7 +1188,7 @@ ieee80211_link_chanctx_reservation_complete(struct ieee80211_link_data *link)
 		break;
 	case NL80211_IFTYPE_STATION:
 		ieee80211_queue_work(&sdata->local->hw,
-				     &sdata->u.mgd.chswitch_work);
+				     &link->u.mgd.chswitch_work);
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_AP_VLAN:
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 711129edd923..20b9979d1506 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -448,9 +448,7 @@ struct ieee80211_if_managed {
 	struct timer_list timer;
 	struct timer_list conn_mon_timer;
 	struct timer_list bcn_mon_timer;
-	struct timer_list chswitch_timer;
 	struct work_struct monitor_work;
-	struct work_struct chswitch_work;
 	struct work_struct beacon_connection_loss_work;
 	struct work_struct csa_connection_drop_work;
 
@@ -888,6 +886,8 @@ struct ieee80211_link_data_managed {
 
 	bool csa_waiting_bcn;
 	bool csa_ignored_same_chan;
+	struct timer_list chswitch_timer;
+	struct work_struct chswitch_work;
 
 	struct work_struct request_smps_work;
 	bool beacon_crc_valid;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index bcc817de6bd0..f3e901793ae1 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -143,7 +143,7 @@ static int ecw2cw(int ecw)
 }
 
 static ieee80211_conn_flags_t
-ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
+ieee80211_determine_chantype(struct ieee80211_link_data *link,
 			     struct ieee80211_supported_band *sband,
 			     struct ieee80211_channel *channel,
 			     u32 vht_cap_info,
@@ -154,6 +154,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 			     const struct ieee80211_s1g_oper_ie *s1g_oper,
 			     struct cfg80211_chan_def *chandef, bool tracking)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct cfg80211_chan_def vht_chandef;
 	struct ieee80211_sta_ht_cap sta_ht_cap;
 	ieee80211_conn_flags_t ret;
@@ -248,7 +249,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	}
 
 	vht_chandef = *chandef;
-	if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
+	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
 	    he_oper &&
 	    (le32_to_cpu(he_oper->he_oper_params) &
 	     IEEE80211_HE_OPERATION_VHT_OPER_INFO)) {
@@ -264,7 +265,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 		if (!ieee80211_chandef_vht_oper(&sdata->local->hw, vht_cap_info,
 						&he_oper_vht_cap, ht_oper,
 						&vht_chandef)) {
-			if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE))
+			if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE))
 				sdata_info(sdata,
 					   "HE AP VHT information is invalid, disabling HE\n");
 			ret = IEEE80211_CONN_DISABLE_HE | IEEE80211_CONN_DISABLE_EHT;
@@ -274,7 +275,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 					       vht_cap_info,
 					       vht_oper, ht_oper,
 					       &vht_chandef)) {
-		if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
+		if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
 			sdata_info(sdata,
 				   "AP VHT information is invalid, disabling VHT\n");
 		ret = IEEE80211_CONN_DISABLE_VHT;
@@ -282,7 +283,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (!cfg80211_chandef_valid(&vht_chandef)) {
-		if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
+		if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
 			sdata_info(sdata,
 				   "AP VHT information is invalid, disabling VHT\n");
 		ret = IEEE80211_CONN_DISABLE_VHT;
@@ -295,7 +296,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (!cfg80211_chandef_compatible(chandef, &vht_chandef)) {
-		if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
+		if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
 			sdata_info(sdata,
 				   "AP VHT information doesn't match HT, disabling VHT\n");
 		ret = IEEE80211_CONN_DISABLE_VHT;
@@ -318,7 +319,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 					   false, &eht_chandef);
 
 		if (!cfg80211_chandef_valid(&eht_chandef)) {
-			if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT))
+			if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT))
 				sdata_info(sdata,
 					   "AP EHT information is invalid, disabling EHT\n");
 			ret = IEEE80211_CONN_DISABLE_EHT;
@@ -326,7 +327,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 		}
 
 		if (!cfg80211_chandef_compatible(chandef, &eht_chandef)) {
-			if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT))
+			if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT))
 				sdata_info(sdata,
 					   "AP EHT information is incompatible, disabling EHT\n");
 			ret = IEEE80211_CONN_DISABLE_EHT;
@@ -358,7 +359,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	 * less common and wouldn't completely prevent using the AP.
 	 */
 	if (tracking &&
-	    cfg80211_chandef_identical(chandef, &sdata->vif.bss_conf.chandef))
+	    cfg80211_chandef_identical(chandef, &link->conf->chandef))
 		return ret;
 
 	/* don't print the message below for VHT mismatch if VHT is disabled */
@@ -403,7 +404,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	return ret;
 }
 
-static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
+static int ieee80211_config_bw(struct ieee80211_link_data *link,
 			       struct sta_info *sta,
 			       const struct ieee80211_ht_cap *ht_cap,
 			       const struct ieee80211_vht_cap *vht_cap,
@@ -414,9 +415,10 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 			       const struct ieee80211_s1g_oper_ie *s1g_oper,
 			       const u8 *bssid, u32 *changed)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
-	struct ieee80211_channel *chan = sdata->vif.bss_conf.chandef.chan;
+	struct ieee80211_channel *chan = link->conf->chandef.chan;
 	struct ieee80211_supported_band *sband =
 		local->hw.wiphy->bands[chan->band];
 	struct cfg80211_chan_def chandef;
@@ -426,15 +428,15 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 	int ret;
 
 	/* if HT was/is disabled, don't track any bandwidth changes */
-	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT || !ht_oper)
+	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT || !ht_oper)
 		return 0;
 
 	/* don't check VHT if we associated as non-VHT station */
-	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)
+	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)
 		vht_oper = NULL;
 
 	/* don't check HE if we associated as non-HE station */
-	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE ||
+	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE ||
 	    !ieee80211_get_he_iftype_cap(sband,
 					 ieee80211_vif_type_p2p(&sdata->vif))) {
 		he_oper = NULL;
@@ -442,7 +444,7 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 	}
 
 	/* don't check EHT if we associated as non-EHT station */
-	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT ||
+	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT ||
 	    !ieee80211_get_eht_iftype_cap(sband,
 					 ieee80211_vif_type_p2p(&sdata->vif)))
 		eht_oper = NULL;
@@ -455,16 +457,16 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 	 * this may be applicable even if channel is identical
 	 */
 	ht_opmode = le16_to_cpu(ht_oper->operation_mode);
-	if (sdata->vif.bss_conf.ht_operation_mode != ht_opmode) {
+	if (link->conf->ht_operation_mode != ht_opmode) {
 		*changed |= BSS_CHANGED_HT;
-		sdata->vif.bss_conf.ht_operation_mode = ht_opmode;
+		link->conf->ht_operation_mode = ht_opmode;
 	}
 
 	if (vht_cap)
 		vht_cap_info = le32_to_cpu(vht_cap->vht_cap_info);
 
 	/* calculate new channel (type) based on HT/VHT/HE operation IEs */
-	flags = ieee80211_determine_chantype(sdata, sband, chan, vht_cap_info,
+	flags = ieee80211_determine_chantype(link, sband, chan, vht_cap_info,
 					     ht_oper, vht_oper,
 					     he_oper, eht_oper,
 					     s1g_oper, &chandef, true);
@@ -476,28 +478,27 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 	 * reasons) then switching to a 40 MHz channel now won't do us
 	 * any good -- we couldn't use it with the AP.
 	 */
-	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_80P80MHZ &&
+	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_80P80MHZ &&
 	    chandef.width == NL80211_CHAN_WIDTH_80P80)
 		flags |= ieee80211_chandef_downgrade(&chandef);
-	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_160MHZ &&
+	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_160MHZ &&
 	    chandef.width == NL80211_CHAN_WIDTH_160)
 		flags |= ieee80211_chandef_downgrade(&chandef);
-	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_40MHZ &&
+	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_40MHZ &&
 	    chandef.width > NL80211_CHAN_WIDTH_20)
 		flags |= ieee80211_chandef_downgrade(&chandef);
 
-	if (cfg80211_chandef_identical(&chandef, &sdata->vif.bss_conf.chandef))
+	if (cfg80211_chandef_identical(&chandef, &link->conf->chandef))
 		return 0;
 
-	sdata_info(sdata,
-		   "AP %pM changed bandwidth, new config is %d.%03d MHz, "
-		   "width %d (%d.%03d/%d MHz)\n",
-		   sdata->deflink.u.mgd.bssid, chandef.chan->center_freq,
-		   chandef.chan->freq_offset, chandef.width,
-		   chandef.center_freq1, chandef.freq1_offset,
-		   chandef.center_freq2);
-
-	if (flags != (sdata->deflink.u.mgd.conn_flags &
+	link_info(link,
+		  "AP %pM changed bandwidth, new config is %d.%03d MHz, width %d (%d.%03d/%d MHz)\n",
+		  link->u.mgd.bssid, chandef.chan->center_freq,
+		  chandef.chan->freq_offset, chandef.width,
+		  chandef.center_freq1, chandef.freq1_offset,
+		  chandef.center_freq2);
+
+	if (flags != (link->u.mgd.conn_flags &
 				(IEEE80211_CONN_DISABLE_HT |
 				 IEEE80211_CONN_DISABLE_VHT |
 				 IEEE80211_CONN_DISABLE_HE |
@@ -509,16 +510,16 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 	    !cfg80211_chandef_valid(&chandef)) {
 		sdata_info(sdata,
 			   "AP %pM changed caps/bw in a way we can't support (0x%x/0x%x) - disconnect\n",
-			   sdata->deflink.u.mgd.bssid, flags, ifmgd->flags);
+			   link->u.mgd.bssid, flags, ifmgd->flags);
 		return -EINVAL;
 	}
 
-	ret = ieee80211_link_change_bandwidth(&sdata->deflink, &chandef, changed);
+	ret = ieee80211_link_change_bandwidth(link, &chandef, changed);
 
 	if (ret) {
 		sdata_info(sdata,
 			   "AP %pM changed bandwidth to incompatible one - disconnect\n",
-			   sdata->deflink.u.mgd.bssid);
+			   link->u.mgd.bssid);
 		return ret;
 	}
 
@@ -527,12 +528,13 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 
 /* frame sending functions */
 
-static void ieee80211_add_ht_ie(struct ieee80211_sub_if_data *sdata,
+static void ieee80211_add_ht_ie(struct ieee80211_link_data *link,
 				struct sk_buff *skb, u8 ap_ht_param,
 				struct ieee80211_supported_band *sband,
 				struct ieee80211_channel *channel,
 				enum ieee80211_smps_mode smps)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	u8 *pos;
 	u32 flags = channel->flags;
 	u16 cap;
@@ -566,7 +568,7 @@ static void ieee80211_add_ht_ie(struct ieee80211_sub_if_data *sdata,
 	 * capable of 40 MHz -- some broken APs will never fall
 	 * back to trying to transmit in 20 MHz.
 	 */
-	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_40MHZ) {
+	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_40MHZ) {
 		cap &= ~IEEE80211_HT_CAP_SUP_WIDTH_20_40;
 		cap &= ~IEEE80211_HT_CAP_SGI_40;
 	}
@@ -601,11 +603,12 @@ static void ieee80211_add_ht_ie(struct ieee80211_sub_if_data *sdata,
  * and builds the IE.
  * Note - the function may set the owner of the MU-MIMO capability
  */
-static void ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
+static void ieee80211_add_vht_ie(struct ieee80211_link_data *link,
 				 struct sk_buff *skb,
 				 struct ieee80211_supported_band *sband,
 				 struct ieee80211_vht_cap *ap_vht_cap)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	u8 *pos;
 	u32 cap;
@@ -620,7 +623,7 @@ static void ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 	/* determine capability flags */
 	cap = vht_cap.cap;
 
-	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_80P80MHZ) {
+	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_80P80MHZ) {
 		u32 bw = cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
 
 		cap &= ~IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
@@ -629,7 +632,7 @@ static void ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 			cap |= IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ;
 	}
 
-	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_160MHZ) {
+	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_160MHZ) {
 		cap &= ~IEEE80211_VHT_CAP_SHORT_GI_160;
 		cap &= ~IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
 	}
@@ -666,7 +669,7 @@ static void ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 		if (disable_mu_mimo)
 			cap &= ~IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE;
 		else
-			sdata->vif.bss_conf.mu_mimo_owner = true;
+			link->conf->mu_mimo_owner = true;
 	}
 
 	mask = IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK;
@@ -687,10 +690,11 @@ static void ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 /* This function determines HE capability flags for the association
  * and builds the IE.
  */
-static void ieee80211_add_he_ie(struct ieee80211_sub_if_data *sdata,
+static void ieee80211_add_he_ie(struct ieee80211_link_data *link,
 				struct sk_buff *skb,
 				struct ieee80211_supported_band *sband)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	u8 *pos, *pre_he_pos;
 	const struct ieee80211_sta_he_cap *he_cap = NULL;
 	struct ieee80211_chanctx_conf *chanctx_conf;
@@ -698,7 +702,7 @@ static void ieee80211_add_he_ie(struct ieee80211_sub_if_data *sdata,
 	bool reg_cap = false;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
+	chanctx_conf = rcu_dereference(link->conf->chanctx_conf);
 	if (!WARN_ON_ONCE(!chanctx_conf))
 		reg_cap = cfg80211_chandef_usable(sdata->wdev.wiphy,
 						  &chanctx_conf->def,
@@ -719,7 +723,7 @@ static void ieee80211_add_he_ie(struct ieee80211_sub_if_data *sdata,
 				      he_cap->he_cap_elem.phy_cap_info);
 	pos = skb_put(skb, he_cap_size);
 	pre_he_pos = pos;
-	pos = ieee80211_ie_build_he_cap(sdata->deflink.u.mgd.conn_flags,
+	pos = ieee80211_ie_build_he_cap(link->u.mgd.conn_flags,
 					pos, he_cap, pos + he_cap_size);
 	/* trim excess if any */
 	skb_trim(skb, skb->len - (pre_he_pos + he_cap_size - pos));
@@ -727,10 +731,11 @@ static void ieee80211_add_he_ie(struct ieee80211_sub_if_data *sdata,
 	ieee80211_ie_build_he_6ghz_cap(sdata, skb);
 }
 
-static void ieee80211_add_eht_ie(struct ieee80211_sub_if_data *sdata,
+static void ieee80211_add_eht_ie(struct ieee80211_link_data *link,
 				 struct sk_buff *skb,
 				 struct ieee80211_supported_band *sband)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	u8 *pos;
 	const struct ieee80211_sta_he_cap *he_cap;
 	const struct ieee80211_sta_eht_cap *eht_cap;
@@ -739,7 +744,7 @@ static void ieee80211_add_eht_ie(struct ieee80211_sub_if_data *sdata,
 	bool reg_cap = false;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
+	chanctx_conf = rcu_dereference(link->conf->chanctx_conf);
 	if (!WARN_ON_ONCE(!chanctx_conf))
 		reg_cap = cfg80211_chandef_usable(sdata->wdev.wiphy,
 						  &chanctx_conf->def,
@@ -789,6 +794,7 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	enum nl80211_iftype iftype = ieee80211_vif_type_p2p(&sdata->vif);
 	const struct ieee80211_sband_iftype_data *iftd;
 	struct ieee80211_prep_tx_info info = {};
+	struct ieee80211_link_data *link = &sdata->deflink;
 	int ret;
 
 	/* we know it's writable, cast away the const */
@@ -800,7 +806,7 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	sdata_assert_lock(sdata);
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
+	chanctx_conf = rcu_dereference(link->conf->chanctx_conf);
 	if (WARN_ON(!chanctx_conf)) {
 		rcu_read_unlock();
 		return -EINVAL;
@@ -979,7 +985,7 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 
 	/* Set MBSSID support for HE AP if needed */
 	if (ieee80211_hw_check(&local->hw, SUPPORTS_ONLY_HE_MULTI_BSSID) &&
-	    !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) && assoc_data->ie_len &&
+	    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) && assoc_data->ie_len &&
 	    ext_capa && ext_capa->datalen >= 3)
 		ext_capa->data[2] |= WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT;
 
@@ -1024,14 +1030,14 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 		offset = noffset;
 	}
 
-	if (WARN_ON_ONCE((sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT) &&
-			 !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)))
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+	if (WARN_ON_ONCE((link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT) &&
+			 !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)))
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
 
 	if (sband->band != NL80211_BAND_6GHZ &&
-	    !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT))
-		ieee80211_add_ht_ie(sdata, skb, assoc_data->ap_ht_param,
-				    sband, chan, sdata->deflink.smps_mode);
+	    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT))
+		ieee80211_add_ht_ie(link, skb, assoc_data->ap_ht_param,
+				    sband, chan, link->smps_mode);
 
 	/* if present, add any custom IEs that go before VHT */
 	if (assoc_data->ie_len) {
@@ -1084,25 +1090,25 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	}
 
 	if (sband->band != NL80211_BAND_6GHZ &&
-	    !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
-		ieee80211_add_vht_ie(sdata, skb, sband,
+	    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
+		ieee80211_add_vht_ie(link, skb, sband,
 				     &assoc_data->ap_vht_cap);
 
 	/*
 	 * If AP doesn't support HT, mark HE and EHT as disabled.
 	 * If on the 5GHz band, make sure it supports VHT.
 	 */
-	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT ||
+	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT ||
 	    (sband->band == NL80211_BAND_5GHZ &&
-	     sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE |
+	     link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE |
 						   IEEE80211_CONN_DISABLE_EHT;
 
-	if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE)) {
-		ieee80211_add_he_ie(sdata, skb, sband);
+	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE)) {
+		ieee80211_add_he_ie(link, skb, sband);
 
-		if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT))
-			ieee80211_add_eht_ie(sdata, skb, sband);
+		if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT))
+			ieee80211_add_eht_ie(link, skb, sband);
 	}
 
 	/* if present, add any custom non-vendor IEs that go after HE */
@@ -1247,8 +1253,9 @@ void ieee80211_send_4addr_nullfunc(struct ieee80211_local *local,
 /* spectrum management related things */
 static void ieee80211_chswitch_work(struct work_struct *work)
 {
-	struct ieee80211_sub_if_data *sdata =
-		container_of(work, struct ieee80211_sub_if_data, u.mgd.chswitch_work);
+	struct ieee80211_link_data *link =
+		container_of(work, struct ieee80211_link_data, u.mgd.chswitch_work);
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	int ret;
@@ -1263,7 +1270,7 @@ static void ieee80211_chswitch_work(struct work_struct *work)
 	if (!ifmgd->associated)
 		goto out;
 
-	if (!sdata->vif.bss_conf.csa_active)
+	if (!link->conf->csa_active)
 		goto out;
 
 	/*
@@ -1273,16 +1280,16 @@ static void ieee80211_chswitch_work(struct work_struct *work)
 	 * completed successfully
 	 */
 
-	if (sdata->deflink.reserved_chanctx) {
+	if (link->reserved_chanctx) {
 		/*
 		 * with multi-vif csa driver may call ieee80211_csa_finish()
 		 * many times while waiting for other interfaces to use their
 		 * reservations
 		 */
-		if (sdata->deflink.reserved_ready)
+		if (link->reserved_ready)
 			goto out;
 
-		ret = ieee80211_link_use_reserved_context(&sdata->deflink);
+		ret = ieee80211_link_use_reserved_context(link);
 		if (ret) {
 			sdata_info(sdata,
 				   "failed to use reserved channel context, disconnecting (err=%d)\n",
@@ -1295,8 +1302,8 @@ static void ieee80211_chswitch_work(struct work_struct *work)
 		goto out;
 	}
 
-	if (!cfg80211_chandef_identical(&sdata->vif.bss_conf.chandef,
-					&sdata->deflink.csa_chandef)) {
+	if (!cfg80211_chandef_identical(&link->conf->chandef,
+					&link->csa_chandef)) {
 		sdata_info(sdata,
 			   "failed to finalize channel switch, disconnecting\n");
 		ieee80211_queue_work(&sdata->local->hw,
@@ -1304,7 +1311,7 @@ static void ieee80211_chswitch_work(struct work_struct *work)
 		goto out;
 	}
 
-	sdata->deflink.u.mgd.csa_waiting_bcn = true;
+	link->u.mgd.csa_waiting_bcn = true;
 
 	ieee80211_sta_reset_beacon_monitor(sdata);
 	ieee80211_sta_reset_conn_monitor(sdata);
@@ -1315,29 +1322,30 @@ static void ieee80211_chswitch_work(struct work_struct *work)
 	sdata_unlock(sdata);
 }
 
-static void ieee80211_chswitch_post_beacon(struct ieee80211_sub_if_data *sdata)
+static void ieee80211_chswitch_post_beacon(struct ieee80211_link_data *link)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	int ret;
 
 	sdata_assert_lock(sdata);
 
-	WARN_ON(!sdata->vif.bss_conf.csa_active);
+	WARN_ON(!link->conf->csa_active);
 
-	if (sdata->deflink.csa_block_tx) {
+	if (link->csa_block_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->deflink.csa_block_tx = false;
+		link->csa_block_tx = false;
 	}
 
-	sdata->vif.bss_conf.csa_active = false;
-	sdata->deflink.u.mgd.csa_waiting_bcn = false;
+	link->conf->csa_active = false;
+	link->u.mgd.csa_waiting_bcn = false;
 	/*
 	 * If the CSA IE is still present on the beacon after the switch,
 	 * we need to consider it as a new CSA (possibly to self).
 	 */
-	sdata->deflink.u.mgd.beacon_crc_valid = false;
+	link->u.mgd.beacon_crc_valid = false;
 
 	ret = drv_post_channel_switch(sdata);
 	if (ret) {
@@ -1348,8 +1356,7 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_sub_if_data *sdata)
 		return;
 	}
 
-	cfg80211_ch_switch_notify(sdata->dev, &sdata->deflink.reserved_chandef,
-				  0);
+	cfg80211_ch_switch_notify(sdata->dev, &link->reserved_chandef, 0);
 }
 
 void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success)
@@ -1357,6 +1364,9 @@ void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success)
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 
+	if (WARN_ON(sdata->vif.valid_links))
+		success = false;
+
 	trace_api_chswitch_done(sdata, success);
 	if (!success) {
 		sdata_info(sdata,
@@ -1364,22 +1374,25 @@ void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success)
 		ieee80211_queue_work(&sdata->local->hw,
 				     &ifmgd->csa_connection_drop_work);
 	} else {
-		ieee80211_queue_work(&sdata->local->hw, &ifmgd->chswitch_work);
+		ieee80211_queue_work(&sdata->local->hw,
+				     &sdata->deflink.u.mgd.chswitch_work);
 	}
 }
 EXPORT_SYMBOL(ieee80211_chswitch_done);
 
 static void ieee80211_chswitch_timer(struct timer_list *t)
 {
-	struct ieee80211_sub_if_data *sdata =
-		from_timer(sdata, t, u.mgd.chswitch_timer);
+	struct ieee80211_link_data *link =
+		from_timer(link, t, u.mgd.chswitch_timer);
 
-	ieee80211_queue_work(&sdata->local->hw, &sdata->u.mgd.chswitch_work);
+	ieee80211_queue_work(&link->sdata->local->hw,
+			     &link->u.mgd.chswitch_work);
 }
 
 static void
-ieee80211_sta_abort_chanswitch(struct ieee80211_sub_if_data *sdata)
+ieee80211_sta_abort_chanswitch(struct ieee80211_link_data *link)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 
 	if (!local->ops->abort_channel_switch)
@@ -1388,15 +1401,15 @@ ieee80211_sta_abort_chanswitch(struct ieee80211_sub_if_data *sdata)
 	mutex_lock(&local->mtx);
 
 	mutex_lock(&local->chanctx_mtx);
-	ieee80211_link_unreserve_chanctx(&sdata->deflink);
+	ieee80211_link_unreserve_chanctx(link);
 	mutex_unlock(&local->chanctx_mtx);
 
-	if (sdata->deflink.csa_block_tx)
+	if (link->csa_block_tx)
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
 
-	sdata->deflink.csa_block_tx = false;
-	sdata->vif.bss_conf.csa_active = false;
+	link->csa_block_tx = false;
+	link->conf->csa_active = false;
 
 	mutex_unlock(&local->mtx);
 
@@ -1404,14 +1417,15 @@ ieee80211_sta_abort_chanswitch(struct ieee80211_sub_if_data *sdata)
 }
 
 static void
-ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
+ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 				 u64 timestamp, u32 device_timestamp,
 				 struct ieee802_11_elems *elems,
 				 bool beacon)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
-	struct cfg80211_bss *cbss = sdata->deflink.u.mgd.bss;
+	struct cfg80211_bss *cbss = link->u.mgd.bss;
 	struct ieee80211_chanctx_conf *conf;
 	struct ieee80211_chanctx *chanctx;
 	enum nl80211_band current_band;
@@ -1432,8 +1446,8 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	bss = (void *)cbss->priv;
 	res = ieee80211_parse_ch_switch_ie(sdata, elems, current_band,
 					   bss->vht_cap_info,
-					   sdata->deflink.u.mgd.conn_flags,
-					   sdata->deflink.u.mgd.bssid, &csa_ie);
+					   link->u.mgd.conn_flags,
+					   link->u.mgd.bssid, &csa_ie);
 
 	if (!res) {
 		ch_switch.timestamp = timestamp;
@@ -1447,23 +1461,23 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	if (res < 0)
 		goto lock_and_drop_connection;
 
-	if (beacon && sdata->vif.bss_conf.csa_active &&
-	    !sdata->deflink.u.mgd.csa_waiting_bcn) {
+	if (beacon && link->conf->csa_active &&
+	    !link->u.mgd.csa_waiting_bcn) {
 		if (res)
-			ieee80211_sta_abort_chanswitch(sdata);
+			ieee80211_sta_abort_chanswitch(link);
 		else
 			drv_channel_switch_rx_beacon(sdata, &ch_switch);
 		return;
-	} else if (sdata->vif.bss_conf.csa_active || res) {
+	} else if (link->conf->csa_active || res) {
 		/* disregard subsequent announcements if already processing */
 		return;
 	}
 
-	if (sdata->vif.bss_conf.chandef.chan->band !=
+	if (link->conf->chandef.chan->band !=
 	    csa_ie.chandef.chan->band) {
 		sdata_info(sdata,
 			   "AP %pM switches to different band (%d MHz, width:%d, CF1/2: %d/%d MHz), disconnecting\n",
-			   sdata->deflink.u.mgd.bssid,
+			   link->u.mgd.bssid,
 			   csa_ie.chandef.chan->center_freq,
 			   csa_ie.chandef.width, csa_ie.chandef.center_freq1,
 			   csa_ie.chandef.center_freq2);
@@ -1476,7 +1490,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 			   "AP %pM switches to unsupported channel "
 			   "(%d.%03d MHz, width:%d, CF1/2: %d.%03d/%d MHz), "
 			   "disconnecting\n",
-			   sdata->deflink.u.mgd.bssid,
+			   link->u.mgd.bssid,
 			   csa_ie.chandef.chan->center_freq,
 			   csa_ie.chandef.chan->freq_offset,
 			   csa_ie.chandef.width, csa_ie.chandef.center_freq1,
@@ -1486,14 +1500,14 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (cfg80211_chandef_identical(&csa_ie.chandef,
-				       &sdata->vif.bss_conf.chandef) &&
+				       &link->conf->chandef) &&
 	    (!csa_ie.mode || !beacon)) {
-		if (sdata->deflink.u.mgd.csa_ignored_same_chan)
+		if (link->u.mgd.csa_ignored_same_chan)
 			return;
 		sdata_info(sdata,
 			   "AP %pM tries to chanswitch to same channel, ignore\n",
-			   sdata->deflink.u.mgd.bssid);
-		sdata->deflink.u.mgd.csa_ignored_same_chan = true;
+			   link->u.mgd.bssid);
+		link->u.mgd.csa_ignored_same_chan = true;
 		return;
 	}
 
@@ -1507,7 +1521,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 
 	mutex_lock(&local->mtx);
 	mutex_lock(&local->chanctx_mtx);
-	conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
+	conf = rcu_dereference_protected(link->conf->chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
 	if (!conf) {
 		sdata_info(sdata,
@@ -1530,7 +1544,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 		goto drop_connection;
 	}
 
-	res = ieee80211_link_reserve_chanctx(&sdata->deflink, &csa_ie.chandef,
+	res = ieee80211_link_reserve_chanctx(link, &csa_ie.chandef,
 					     chanctx->mode, false);
 	if (res) {
 		sdata_info(sdata,
@@ -1540,13 +1554,13 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	}
 	mutex_unlock(&local->chanctx_mtx);
 
-	sdata->vif.bss_conf.csa_active = true;
-	sdata->deflink.csa_chandef = csa_ie.chandef;
-	sdata->deflink.csa_block_tx = csa_ie.mode;
-	sdata->deflink.u.mgd.csa_ignored_same_chan = false;
-	sdata->deflink.u.mgd.beacon_crc_valid = false;
+	link->conf->csa_active = true;
+	link->csa_chandef = csa_ie.chandef;
+	link->csa_block_tx = csa_ie.mode;
+	link->u.mgd.csa_ignored_same_chan = false;
+	link->u.mgd.beacon_crc_valid = false;
 
-	if (sdata->deflink.csa_block_tx)
+	if (link->csa_block_tx)
 		ieee80211_stop_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
 	mutex_unlock(&local->mtx);
@@ -1562,9 +1576,9 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 
 	/* channel switch handled in software */
 	if (csa_ie.count <= 1)
-		ieee80211_queue_work(&local->hw, &ifmgd->chswitch_work);
+		ieee80211_queue_work(&local->hw, &link->u.mgd.chswitch_work);
 	else
-		mod_timer(&ifmgd->chswitch_timer,
+		mod_timer(&link->u.mgd.chswitch_timer,
 			  TU_TO_EXP_TIME((csa_ie.count - 1) *
 					 cbss->beacon_interval));
 	return;
@@ -1579,8 +1593,8 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	 * send a deauthentication frame. Those two fields will be
 	 * reset when the disconnection worker runs.
 	 */
-	sdata->vif.bss_conf.csa_active = true;
-	sdata->deflink.csa_block_tx = csa_ie.mode;
+	link->conf->csa_active = true;
+	link->csa_block_tx = csa_ie.mode;
 
 	ieee80211_queue_work(&local->hw, &ifmgd->csa_connection_drop_work);
 	mutex_unlock(&local->chanctx_mtx);
@@ -1673,13 +1687,14 @@ static void ieee80211_find_cisco_dtpc(struct ieee80211_sub_if_data *sdata,
 	*pwr_level = (__s8)cisco_dtpc_ie[4];
 }
 
-static u32 ieee80211_handle_pwr_constr(struct ieee80211_sub_if_data *sdata,
+static u32 ieee80211_handle_pwr_constr(struct ieee80211_link_data *link,
 				       struct ieee80211_channel *channel,
 				       struct ieee80211_mgmt *mgmt,
 				       const u8 *country_ie, u8 country_ie_len,
 				       const u8 *pwr_constr_ie,
 				       const u8 *cisco_dtpc_ie)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	bool has_80211h_pwr = false, has_cisco_pwr = false;
 	int chan_pwr = 0, pwr_reduction_80211h = 0;
 	int pwr_level_cisco, pwr_level_80211h;
@@ -1715,25 +1730,25 @@ static u32 ieee80211_handle_pwr_constr(struct ieee80211_sub_if_data *sdata,
 	    (!has_cisco_pwr || pwr_level_80211h <= pwr_level_cisco)) {
 		new_ap_level = pwr_level_80211h;
 
-		if (sdata->deflink.ap_power_level == new_ap_level)
+		if (link->ap_power_level == new_ap_level)
 			return 0;
 
 		sdata_dbg(sdata,
 			  "Limiting TX power to %d (%d - %d) dBm as advertised by %pM\n",
 			  pwr_level_80211h, chan_pwr, pwr_reduction_80211h,
-			  sdata->deflink.u.mgd.bssid);
+			  link->u.mgd.bssid);
 	} else {  /* has_cisco_pwr is always true here. */
 		new_ap_level = pwr_level_cisco;
 
-		if (sdata->deflink.ap_power_level == new_ap_level)
+		if (link->ap_power_level == new_ap_level)
 			return 0;
 
 		sdata_dbg(sdata,
 			  "Limiting TX power to %d dBm as advertised by %pM\n",
-			  pwr_level_cisco, sdata->deflink.u.mgd.bssid);
+			  pwr_level_cisco, link->u.mgd.bssid);
 	}
 
-	sdata->deflink.ap_power_level = new_ap_level;
+	link->ap_power_level = new_ap_level;
 	if (__ieee80211_recalc_txpower(sdata))
 		return BSS_CHANGED_TXPOWER;
 	return 0;
@@ -1972,14 +1987,15 @@ void ieee80211_dynamic_ps_timer(struct timer_list *t)
 void ieee80211_dfs_cac_timer_work(struct work_struct *work)
 {
 	struct delayed_work *delayed_work = to_delayed_work(work);
-	struct ieee80211_sub_if_data *sdata =
-		container_of(delayed_work, struct ieee80211_sub_if_data,
-			     deflink.dfs_cac_timer_work);
-	struct cfg80211_chan_def chandef = sdata->vif.bss_conf.chandef;
+	struct ieee80211_link_data *link =
+		container_of(delayed_work, struct ieee80211_link_data,
+			     dfs_cac_timer_work);
+	struct cfg80211_chan_def chandef = link->conf->chandef;
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 
 	mutex_lock(&sdata->local->mtx);
 	if (sdata->wdev.cac_started) {
-		ieee80211_link_release_channel(&sdata->deflink);
+		ieee80211_link_release_channel(link);
 		cfg80211_cac_event(sdata->dev, &chandef,
 				   NL80211_RADAR_CAC_FINISHED,
 				   GFP_KERNEL);
@@ -2299,7 +2315,8 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_bss *bss = (void *)cbss->priv;
 	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
+	struct ieee80211_link_data *link = &sdata->deflink;
+	struct ieee80211_bss_conf *bss_conf = link->conf;
 	struct ieee80211_vif_cfg *vif_cfg = &sdata->vif.cfg;
 
 	bss_info_changed |= BSS_CHANGED_ASSOC;
@@ -2310,8 +2327,8 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 		beacon_loss_count * bss_conf->beacon_int));
 
 	sdata->u.mgd.associated = true;
-	sdata->deflink.u.mgd.bss = cbss;
-	memcpy(sdata->deflink.u.mgd.bssid, cbss->bssid, ETH_ALEN);
+	link->u.mgd.bss = cbss;
+	memcpy(link->u.mgd.bssid, cbss->bssid, ETH_ALEN);
 	memcpy(sdata->vif.cfg.ap_addr, cbss->bssid, ETH_ALEN);
 
 	ieee80211_check_rate_mask(sdata);
@@ -2331,7 +2348,7 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 					(u8 *) &bss_conf->p2p_noa_attr,
 					sizeof(bss_conf->p2p_noa_attr));
 			if (ret >= 2) {
-				sdata->deflink.u.mgd.p2p_noa_index =
+				link->u.mgd.p2p_noa_index =
 					bss_conf->p2p_noa_attr.index;
 				bss_info_changed |= BSS_CHANGED_P2P_PS;
 			}
@@ -2344,14 +2361,14 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 
 	ieee80211_led_assoc(local, 1);
 
-	if (sdata->deflink.u.mgd.have_beacon) {
+	if (link->u.mgd.have_beacon) {
 		/*
 		 * If the AP is buggy we may get here with no DTIM period
 		 * known, so assume it's 1 which is the only safe assumption
 		 * in that case, although if the TIM IE is broken powersave
 		 * probably just won't work at all.
 		 */
-		bss_conf->dtim_period = sdata->deflink.u.mgd.dtim_period ?: 1;
+		bss_conf->dtim_period = link->u.mgd.dtim_period ?: 1;
 		bss_conf->beacon_rate = bss->beacon_rate;
 		bss_info_changed |= BSS_CHANGED_BEACON_INFO;
 	} else {
@@ -2389,6 +2406,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
+	struct ieee80211_link_data *link = &sdata->deflink;
 	u32 changed = 0;
 	struct ieee80211_prep_tx_info info = {
 		.subtype = stype,
@@ -2405,7 +2423,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	ieee80211_stop_poll(sdata);
 
 	ifmgd->associated = false;
-	sdata->deflink.u.mgd.bss = NULL;
+	link->u.mgd.bss = NULL;
 	netif_carrier_off(sdata->dev);
 
 	/*
@@ -2443,12 +2461,12 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 		 * driver requested so.
 		 */
 		if (ieee80211_hw_check(&local->hw, DEAUTH_NEED_MGD_TX_PREP) &&
-		    !sdata->deflink.u.mgd.have_beacon) {
+		    !link->u.mgd.have_beacon) {
 			drv_mgd_prepare_tx(sdata->local, sdata, &info);
 		}
 
-		ieee80211_send_deauth_disassoc(sdata, sdata->deflink.u.mgd.bssid,
-					       sdata->deflink.u.mgd.bssid, stype, reason,
+		ieee80211_send_deauth_disassoc(sdata, link->u.mgd.bssid,
+					       link->u.mgd.bssid, stype, reason,
 					       tx, frame_buf);
 	}
 
@@ -2459,7 +2477,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	drv_mgd_complete_tx(sdata->local, sdata, &info);
 
 	/* clear bssid only after building the needed mgmt frames */
-	eth_zero_addr(sdata->deflink.u.mgd.bssid);
+	eth_zero_addr(link->u.mgd.bssid);
 
 	eth_zero_addr(sdata->vif.cfg.ap_addr);
 	sdata->vif.cfg.ssid_len = 0;
@@ -2474,9 +2492,9 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	changed |= BSS_CHANGED_ASSOC;
 	sdata->vif.cfg.assoc = false;
 
-	sdata->deflink.u.mgd.p2p_noa_index = -1;
-	memset(&sdata->vif.bss_conf.p2p_noa_attr, 0,
-	       sizeof(sdata->vif.bss_conf.p2p_noa_attr));
+	link->u.mgd.p2p_noa_index = -1;
+	memset(&link->conf->p2p_noa_attr, 0,
+	       sizeof(link->conf->p2p_noa_attr));
 
 	/* on the next assoc, re-program HT/VHT parameters */
 	memset(&ifmgd->ht_capa, 0, sizeof(ifmgd->ht_capa));
@@ -2485,14 +2503,14 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	memset(&ifmgd->vht_capa_mask, 0, sizeof(ifmgd->vht_capa_mask));
 
 	/* reset MU-MIMO ownership and group data */
-	memset(sdata->vif.bss_conf.mu_group.membership, 0,
-	       sizeof(sdata->vif.bss_conf.mu_group.membership));
-	memset(sdata->vif.bss_conf.mu_group.position, 0,
-	       sizeof(sdata->vif.bss_conf.mu_group.position));
+	memset(link->conf->mu_group.membership, 0,
+	       sizeof(link->conf->mu_group.membership));
+	memset(link->conf->mu_group.position, 0,
+	       sizeof(link->conf->mu_group.position));
 	changed |= BSS_CHANGED_MU_GROUPS;
-	sdata->vif.bss_conf.mu_mimo_owner = false;
+	link->conf->mu_mimo_owner = false;
 
-	sdata->deflink.ap_power_level = IEEE80211_UNSET_POWER_LEVEL;
+	link->ap_power_level = IEEE80211_UNSET_POWER_LEVEL;
 
 	del_timer_sync(&local->dynamic_ps_timer);
 	cancel_work_sync(&local->dynamic_ps_enable_work);
@@ -2501,7 +2519,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	if (sdata->vif.cfg.arp_addr_cnt)
 		changed |= BSS_CHANGED_ARP_FILTER;
 
-	sdata->vif.bss_conf.qos = false;
+	link->conf->qos = false;
 	changed |= BSS_CHANGED_QOS;
 
 	/* The BSSID (not really interesting) and HT changed */
@@ -2514,26 +2532,26 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	del_timer_sync(&sdata->u.mgd.conn_mon_timer);
 	del_timer_sync(&sdata->u.mgd.bcn_mon_timer);
 	del_timer_sync(&sdata->u.mgd.timer);
-	del_timer_sync(&sdata->u.mgd.chswitch_timer);
+	del_timer_sync(&link->u.mgd.chswitch_timer);
 
-	sdata->vif.bss_conf.dtim_period = 0;
-	sdata->vif.bss_conf.beacon_rate = NULL;
+	link->conf->dtim_period = 0;
+	link->conf->beacon_rate = NULL;
 
-	sdata->deflink.u.mgd.have_beacon = false;
-	sdata->deflink.u.mgd.tracking_signal_avg = false;
+	link->u.mgd.have_beacon = false;
+	link->u.mgd.tracking_signal_avg = false;
 
 	ifmgd->flags = 0;
-	sdata->deflink.u.mgd.conn_flags = 0;
+	link->u.mgd.conn_flags = 0;
 	mutex_lock(&local->mtx);
-	ieee80211_link_release_channel(&sdata->deflink);
+	ieee80211_link_release_channel(link);
 
-	sdata->vif.bss_conf.csa_active = false;
-	sdata->deflink.u.mgd.csa_waiting_bcn = false;
-	sdata->deflink.u.mgd.csa_ignored_same_chan = false;
-	if (sdata->deflink.csa_block_tx) {
+	link->conf->csa_active = false;
+	link->u.mgd.csa_waiting_bcn = false;
+	link->u.mgd.csa_ignored_same_chan = false;
+	if (link->csa_block_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->deflink.csa_block_tx = false;
+		link->csa_block_tx = false;
 	}
 	mutex_unlock(&local->mtx);
 
@@ -2657,6 +2675,9 @@ static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 	u8 unicast_limit = max(1, max_probe_tries - 3);
 	struct sta_info *sta;
 
+	if (WARN_ON(sdata->vif.valid_links))
+		return;
+
 	/*
 	 * Try sending broadcast probe requests for the last three
 	 * probe requests after the first ones failed since some
@@ -2702,6 +2723,9 @@ static void ieee80211_mgd_probe_ap(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	bool already = false;
 
+	if (WARN_ON(sdata->vif.valid_links))
+		return;
+
 	if (!ieee80211_sdata_running(sdata))
 		return;
 
@@ -2773,7 +2797,8 @@ struct sk_buff *ieee80211_ap_probereq_get(struct ieee80211_hw *hw,
 	const struct element *ssid;
 	int ssid_len;
 
-	if (WARN_ON(sdata->vif.type != NL80211_IFTYPE_STATION))
+	if (WARN_ON(sdata->vif.type != NL80211_IFTYPE_STATION ||
+		    sdata->vif.valid_links))
 		return NULL;
 
 	sdata_assert_lock(sdata);
@@ -2877,9 +2902,6 @@ static void ieee80211_beacon_connection_loss_work(struct work_struct *work)
 			     u.mgd.beacon_connection_loss_work);
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 
-	if (ifmgd->associated)
-		sdata->deflink.u.mgd.beacon_loss_count++;
-
 	if (ifmgd->connection_loss) {
 		sdata_info(sdata, "Connection to AP %pM lost\n",
 			   sdata->vif.cfg.ap_addr);
@@ -2892,6 +2914,8 @@ static void ieee80211_beacon_connection_loss_work(struct work_struct *work)
 		__ieee80211_disconnect(sdata);
 		ifmgd->driver_disconnect = false;
 	} else {
+		if (ifmgd->associated)
+			sdata->deflink.u.mgd.beacon_loss_count++;
 		ieee80211_mgd_probe_ap(sdata, true);
 	}
 }
@@ -2961,11 +2985,12 @@ static void ieee80211_destroy_auth_data(struct ieee80211_sub_if_data *sdata,
 		del_timer_sync(&sdata->u.mgd.timer);
 		sta_info_destroy_addr(sdata, auth_data->bss->bssid);
 
+		/* FIXME: other links are destroyed? */
+		sdata->deflink.u.mgd.conn_flags = 0;
 		eth_zero_addr(sdata->deflink.u.mgd.bssid);
 		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
 						  BSS_CHANGED_BSSID);
 		sdata->u.mgd.flags = 0;
-		sdata->deflink.u.mgd.conn_flags = 0;
 		mutex_lock(&sdata->local->mtx);
 		ieee80211_link_release_channel(&sdata->deflink);
 		mutex_unlock(&sdata->local->mtx);
@@ -2992,11 +3017,12 @@ static void ieee80211_destroy_assoc_data(struct ieee80211_sub_if_data *sdata,
 		del_timer_sync(&sdata->u.mgd.timer);
 		sta_info_destroy_addr(sdata, assoc_data->bss->bssid);
 
+		/* FIXME: other links are destroyed? */
+		sdata->deflink.u.mgd.conn_flags = 0;
 		eth_zero_addr(sdata->deflink.u.mgd.bssid);
 		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
 						  BSS_CHANGED_BSSID);
 		sdata->u.mgd.flags = 0;
-		sdata->deflink.u.mgd.conn_flags = 0;
 		sdata->vif.bss_conf.mu_mimo_owner = false;
 
 		mutex_lock(&sdata->local->mtx);
@@ -3385,14 +3411,14 @@ static bool ieee80211_twt_req_supported(const struct sta_info *sta,
 		IEEE80211_HE_MAC_CAP0_TWT_RES;
 }
 
-static int ieee80211_recalc_twt_req(struct ieee80211_sub_if_data *sdata,
+static int ieee80211_recalc_twt_req(struct ieee80211_link_data *link,
 				    struct sta_info *sta,
 				    struct ieee802_11_elems *elems)
 {
 	bool twt = ieee80211_twt_req_supported(sta, elems);
 
-	if (sdata->vif.bss_conf.twt_requester != twt) {
-		sdata->vif.bss_conf.twt_requester = twt;
+	if (link->conf->twt_requester != twt) {
+		link->conf->twt_requester = twt;
 		return BSS_CHANGED_TWT;
 	}
 	return 0;
@@ -3430,6 +3456,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_mgd_assoc_data *assoc_data = ifmgd->assoc_data;
 	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
 	bool is_s1g = cbss->channel->band == NL80211_BAND_S1GHZ;
+	struct ieee80211_link_data *link = &sdata->deflink;
 	u32 changed = 0;
 	u8 *pos;
 	int err;
@@ -3488,9 +3515,9 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	 */
 	if (!is_6ghz &&
 	    ((assoc_data->wmm && !elems->wmm_param) ||
-	     (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT) &&
+	     (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT) &&
 	      (!elems->ht_cap_elem || !elems->ht_operation)) ||
-	     (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT) &&
+	     (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT) &&
 	      (!elems->vht_cap_elem || !elems->vht_operation)))) {
 		const struct cfg80211_bss_ies *ies;
 		struct ieee802_11_elems *bss_elems;
@@ -3526,25 +3553,25 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		 * have to include the IEs in the (re)association response.
 		 */
 		if (!elems->ht_cap_elem && bss_elems->ht_cap_elem &&
-		    !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT)) {
+		    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT)) {
 			elems->ht_cap_elem = bss_elems->ht_cap_elem;
 			sdata_info(sdata,
 				   "AP bug: HT capability missing from AssocResp\n");
 		}
 		if (!elems->ht_operation && bss_elems->ht_operation &&
-		    !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT)) {
+		    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT)) {
 			elems->ht_operation = bss_elems->ht_operation;
 			sdata_info(sdata,
 				   "AP bug: HT operation missing from AssocResp\n");
 		}
 		if (!elems->vht_cap_elem && bss_elems->vht_cap_elem &&
-		    !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)) {
+		    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)) {
 			elems->vht_cap_elem = bss_elems->vht_cap_elem;
 			sdata_info(sdata,
 				   "AP bug: VHT capa missing from AssocResp\n");
 		}
 		if (!elems->vht_operation && bss_elems->vht_operation &&
-		    !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)) {
+		    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)) {
 			elems->vht_operation = bss_elems->vht_operation;
 			sdata_info(sdata,
 				   "AP bug: VHT operation missing from AssocResp\n");
@@ -3557,7 +3584,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	 * We previously checked these in the beacon/probe response, so
 	 * they should be present here. This is just a safety net.
 	 */
-	if (!is_6ghz && !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT) &&
+	if (!is_6ghz && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT) &&
 	    (!elems->wmm_param || !elems->ht_cap_elem || !elems->ht_operation)) {
 		sdata_info(sdata,
 			   "HT AP is missing WMM params or HT capability/operation\n");
@@ -3565,7 +3592,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		goto out;
 	}
 
-	if (!is_6ghz && !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT) &&
+	if (!is_6ghz && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT) &&
 	    (!elems->vht_cap_elem || !elems->vht_operation)) {
 		sdata_info(sdata,
 			   "VHT AP is missing VHT capability/operation\n");
@@ -3573,7 +3600,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		goto out;
 	}
 
-	if (is_6ghz && !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
+	if (is_6ghz && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
 	    !elems->he_6ghz_capa) {
 		sdata_info(sdata,
 			   "HE 6 GHz AP is missing HE 6 GHz band capability\n");
@@ -3600,7 +3627,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		goto out;
 	}
 
-	if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
+	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
 	    (!elems->he_cap || !elems->he_operation)) {
 		mutex_unlock(&sdata->local->sta_mtx);
 		sdata_info(sdata,
@@ -3610,17 +3637,17 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	}
 
 	/* Set up internal HT/VHT capabilities */
-	if (elems->ht_cap_elem && !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT))
+	if (elems->ht_cap_elem && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT))
 		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
 						  elems->ht_cap_elem,
 						  &sta->deflink);
 
-	if (elems->vht_cap_elem && !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
+	if (elems->vht_cap_elem && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
 		ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
 						    elems->vht_cap_elem,
 						    &sta->deflink);
 
-	if (elems->he_operation && !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
+	if (elems->he_operation && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
 	    elems->he_cap) {
 		ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband,
 						  elems->he_cap,
@@ -3637,10 +3664,10 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		else
 			bss_conf->twt_protected = false;
 
-		changed |= ieee80211_recalc_twt_req(sdata, sta, elems);
+		changed |= ieee80211_recalc_twt_req(link, sta, elems);
 
 		if (elems->eht_operation && elems->eht_cap &&
-		    !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT)) {
+		    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT)) {
 			ieee80211_eht_cap_ie_to_sta_eht_cap(sdata, sband,
 							    elems->he_cap,
 							    elems->he_cap_len,
@@ -3764,17 +3791,16 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	 * that effect because the AP values is an unsigned
 	 * 4-bit value.
 	 */
-	sdata->deflink.u.mgd.wmm_last_param_set = -1;
-	sdata->deflink.u.mgd.mu_edca_last_param_set = -1;
+	link->u.mgd.wmm_last_param_set = -1;
+	link->u.mgd.mu_edca_last_param_set = -1;
 
 	if (ifmgd->flags & IEEE80211_STA_DISABLE_WMM) {
-		ieee80211_set_wmm_default(&sdata->deflink, false, false);
-	} else if (!ieee80211_sta_wmm_params(local, &sdata->deflink,
-					     elems->wmm_param,
+		ieee80211_set_wmm_default(link, false, false);
+	} else if (!ieee80211_sta_wmm_params(local, link, elems->wmm_param,
 					     elems->wmm_param_len,
 					     elems->mu_edca_param_set)) {
 		/* still enable QoS since we might have HT/VHT */
-		ieee80211_set_wmm_default(&sdata->deflink, false, true);
+		ieee80211_set_wmm_default(link, false, true);
 		/* set the disable-WMM flag in this case to disable
 		 * tracking WMM parameter changes in the beacon if
 		 * the parameters weren't actually valid. Doing so
@@ -3954,10 +3980,11 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 	kfree(elems);
 }
 
-static void ieee80211_rx_bss_info(struct ieee80211_sub_if_data *sdata,
+static void ieee80211_rx_bss_info(struct ieee80211_link_data *link,
 				  struct ieee80211_mgmt *mgmt, size_t len,
 				  struct ieee80211_rx_status *rx_status)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_bss *bss;
 	struct ieee80211_channel *channel;
@@ -3971,15 +3998,16 @@ static void ieee80211_rx_bss_info(struct ieee80211_sub_if_data *sdata,
 
 	bss = ieee80211_bss_info_update(local, rx_status, mgmt, len, channel);
 	if (bss) {
-		sdata->vif.bss_conf.beacon_rate = bss->beacon_rate;
+		link->conf->beacon_rate = bss->beacon_rate;
 		ieee80211_rx_bss_put(local, bss);
 	}
 }
 
 
-static void ieee80211_rx_mgmt_probe_resp(struct ieee80211_sub_if_data *sdata,
+static void ieee80211_rx_mgmt_probe_resp(struct ieee80211_link_data *link,
 					 struct sk_buff *skb)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_mgmt *mgmt = (void *)skb->data;
 	struct ieee80211_if_managed *ifmgd;
 	struct ieee80211_rx_status *rx_status = (void *) skb->cb;
@@ -4011,10 +4039,10 @@ static void ieee80211_rx_mgmt_probe_resp(struct ieee80211_sub_if_data *sdata,
 	if (baselen > len)
 		return;
 
-	ieee80211_rx_bss_info(sdata, mgmt, len, rx_status);
+	ieee80211_rx_bss_info(link, mgmt, len, rx_status);
 
 	if (ifmgd->associated &&
-	    ether_addr_equal(mgmt->bssid, sdata->deflink.u.mgd.bssid))
+	    ether_addr_equal(mgmt->bssid, link->u.mgd.bssid))
 		ieee80211_reset_ap_probe(sdata);
 }
 
@@ -4042,31 +4070,33 @@ static const u64 care_about_ies =
 	(1ULL << WLAN_EID_HT_OPERATION) |
 	(1ULL << WLAN_EID_EXT_CHANSWITCH_ANN);
 
-static void ieee80211_handle_beacon_sig(struct ieee80211_sub_if_data *sdata,
+static void ieee80211_handle_beacon_sig(struct ieee80211_link_data *link,
 					struct ieee80211_if_managed *ifmgd,
 					struct ieee80211_bss_conf *bss_conf,
 					struct ieee80211_local *local,
 					struct ieee80211_rx_status *rx_status)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+
 	/* Track average RSSI from the Beacon frames of the current AP */
 
-	if (!sdata->deflink.u.mgd.tracking_signal_avg) {
-		sdata->deflink.u.mgd.tracking_signal_avg = true;
-		ewma_beacon_signal_init(&sdata->deflink.u.mgd.ave_beacon_signal);
-		sdata->deflink.u.mgd.last_cqm_event_signal = 0;
-		sdata->deflink.u.mgd.count_beacon_signal = 1;
-		sdata->deflink.u.mgd.last_ave_beacon_signal = 0;
+	if (!link->u.mgd.tracking_signal_avg) {
+		link->u.mgd.tracking_signal_avg = true;
+		ewma_beacon_signal_init(&link->u.mgd.ave_beacon_signal);
+		link->u.mgd.last_cqm_event_signal = 0;
+		link->u.mgd.count_beacon_signal = 1;
+		link->u.mgd.last_ave_beacon_signal = 0;
 	} else {
-		sdata->deflink.u.mgd.count_beacon_signal++;
+		link->u.mgd.count_beacon_signal++;
 	}
 
-	ewma_beacon_signal_add(&sdata->deflink.u.mgd.ave_beacon_signal,
+	ewma_beacon_signal_add(&link->u.mgd.ave_beacon_signal,
 			       -rx_status->signal);
 
 	if (ifmgd->rssi_min_thold != ifmgd->rssi_max_thold &&
-	    sdata->deflink.u.mgd.count_beacon_signal >= IEEE80211_SIGNAL_AVE_MIN_COUNT) {
-		int sig = -ewma_beacon_signal_read(&sdata->deflink.u.mgd.ave_beacon_signal);
-		int last_sig = sdata->deflink.u.mgd.last_ave_beacon_signal;
+	    link->u.mgd.count_beacon_signal >= IEEE80211_SIGNAL_AVE_MIN_COUNT) {
+		int sig = -ewma_beacon_signal_read(&link->u.mgd.ave_beacon_signal);
+		int last_sig = link->u.mgd.last_ave_beacon_signal;
 		struct ieee80211_event event = {
 			.type = RSSI_EVENT,
 		};
@@ -4077,36 +4107,36 @@ static void ieee80211_handle_beacon_sig(struct ieee80211_sub_if_data *sdata,
 		 */
 		if (sig > ifmgd->rssi_max_thold &&
 		    (last_sig <= ifmgd->rssi_min_thold || last_sig == 0)) {
-			sdata->deflink.u.mgd.last_ave_beacon_signal = sig;
+			link->u.mgd.last_ave_beacon_signal = sig;
 			event.u.rssi.data = RSSI_EVENT_HIGH;
 			drv_event_callback(local, sdata, &event);
 		} else if (sig < ifmgd->rssi_min_thold &&
 			   (last_sig >= ifmgd->rssi_max_thold ||
 			   last_sig == 0)) {
-			sdata->deflink.u.mgd.last_ave_beacon_signal = sig;
+			link->u.mgd.last_ave_beacon_signal = sig;
 			event.u.rssi.data = RSSI_EVENT_LOW;
 			drv_event_callback(local, sdata, &event);
 		}
 	}
 
 	if (bss_conf->cqm_rssi_thold &&
-	    sdata->deflink.u.mgd.count_beacon_signal >= IEEE80211_SIGNAL_AVE_MIN_COUNT &&
+	    link->u.mgd.count_beacon_signal >= IEEE80211_SIGNAL_AVE_MIN_COUNT &&
 	    !(sdata->vif.driver_flags & IEEE80211_VIF_SUPPORTS_CQM_RSSI)) {
-		int sig = -ewma_beacon_signal_read(&sdata->deflink.u.mgd.ave_beacon_signal);
-		int last_event = sdata->deflink.u.mgd.last_cqm_event_signal;
+		int sig = -ewma_beacon_signal_read(&link->u.mgd.ave_beacon_signal);
+		int last_event = link->u.mgd.last_cqm_event_signal;
 		int thold = bss_conf->cqm_rssi_thold;
 		int hyst = bss_conf->cqm_rssi_hyst;
 
 		if (sig < thold &&
 		    (last_event == 0 || sig < last_event - hyst)) {
-			sdata->deflink.u.mgd.last_cqm_event_signal = sig;
+			link->u.mgd.last_cqm_event_signal = sig;
 			ieee80211_cqm_rssi_notify(
 				&sdata->vif,
 				NL80211_CQM_RSSI_THRESHOLD_EVENT_LOW,
 				sig, GFP_KERNEL);
 		} else if (sig > thold &&
 			   (last_event == 0 || sig > last_event + hyst)) {
-			sdata->deflink.u.mgd.last_cqm_event_signal = sig;
+			link->u.mgd.last_cqm_event_signal = sig;
 			ieee80211_cqm_rssi_notify(
 				&sdata->vif,
 				NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH,
@@ -4115,22 +4145,22 @@ static void ieee80211_handle_beacon_sig(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (bss_conf->cqm_rssi_low &&
-	    sdata->deflink.u.mgd.count_beacon_signal >= IEEE80211_SIGNAL_AVE_MIN_COUNT) {
-		int sig = -ewma_beacon_signal_read(&sdata->deflink.u.mgd.ave_beacon_signal);
-		int last_event = sdata->deflink.u.mgd.last_cqm_event_signal;
+	    link->u.mgd.count_beacon_signal >= IEEE80211_SIGNAL_AVE_MIN_COUNT) {
+		int sig = -ewma_beacon_signal_read(&link->u.mgd.ave_beacon_signal);
+		int last_event = link->u.mgd.last_cqm_event_signal;
 		int low = bss_conf->cqm_rssi_low;
 		int high = bss_conf->cqm_rssi_high;
 
 		if (sig < low &&
 		    (last_event == 0 || last_event >= low)) {
-			sdata->deflink.u.mgd.last_cqm_event_signal = sig;
+			link->u.mgd.last_cqm_event_signal = sig;
 			ieee80211_cqm_rssi_notify(
 				&sdata->vif,
 				NL80211_CQM_RSSI_THRESHOLD_EVENT_LOW,
 				sig, GFP_KERNEL);
 		} else if (sig > high &&
 			   (last_event == 0 || last_event <= high)) {
-			sdata->deflink.u.mgd.last_cqm_event_signal = sig;
+			link->u.mgd.last_cqm_event_signal = sig;
 			ieee80211_cqm_rssi_notify(
 				&sdata->vif,
 				NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH,
@@ -4149,10 +4179,11 @@ static bool ieee80211_rx_our_beacon(const u8 *tx_bssid,
 	return ether_addr_equal(tx_bssid, bss->transmitted_bss->bssid);
 }
 
-static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
+static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 				     struct ieee80211_hdr *hdr, size_t len,
 				     struct ieee80211_rx_status *rx_status)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
 	struct ieee80211_vif_cfg *vif_cfg = &sdata->vif.cfg;
@@ -4188,7 +4219,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
+	chanctx_conf = rcu_dereference(link->conf->chanctx_conf);
 	if (!chanctx_conf) {
 		rcu_read_unlock();
 		return;
@@ -4210,18 +4241,18 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 		if (!elems)
 			return;
 
-		ieee80211_rx_bss_info(sdata, mgmt, len, rx_status);
+		ieee80211_rx_bss_info(link, mgmt, len, rx_status);
 
 		if (elems->dtim_period)
-			sdata->deflink.u.mgd.dtim_period = elems->dtim_period;
-		sdata->deflink.u.mgd.have_beacon = true;
+			link->u.mgd.dtim_period = elems->dtim_period;
+		link->u.mgd.have_beacon = true;
 		ifmgd->assoc_data->need_beacon = false;
 		if (ieee80211_hw_check(&local->hw, TIMING_BEACON_ONLY)) {
-			sdata->vif.bss_conf.sync_tsf =
+			link->conf->sync_tsf =
 				le64_to_cpu(mgmt->u.beacon.timestamp);
-			sdata->vif.bss_conf.sync_device_ts =
+			link->conf->sync_device_ts =
 				rx_status->device_timestamp;
-			sdata->vif.bss_conf.sync_dtim_count = elems->dtim_count;
+			link->conf->sync_dtim_count = elems->dtim_count;
 		}
 
 		if (elems->mbssid_config_ie)
@@ -4245,12 +4276,12 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (!ifmgd->associated ||
-	    !ieee80211_rx_our_beacon(bssid, sdata->deflink.u.mgd.bss))
+	    !ieee80211_rx_our_beacon(bssid, link->u.mgd.bss))
 		return;
-	bssid = sdata->deflink.u.mgd.bssid;
+	bssid = link->u.mgd.bssid;
 
 	if (!(rx_status->flag & RX_FLAG_NO_SIGNAL_VAL))
-		ieee80211_handle_beacon_sig(sdata, ifmgd, bss_conf,
+		ieee80211_handle_beacon_sig(link, ifmgd, bss_conf,
 					    local, rx_status);
 
 	if (ifmgd->flags & IEEE80211_STA_CONNECTION_POLL) {
@@ -4313,28 +4344,28 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 					    IEEE80211_P2P_ATTR_ABSENCE_NOTICE,
 					    (u8 *) &noa, sizeof(noa));
 		if (ret >= 2) {
-			if (sdata->deflink.u.mgd.p2p_noa_index != noa.index) {
+			if (link->u.mgd.p2p_noa_index != noa.index) {
 				/* valid noa_attr and index changed */
-				sdata->deflink.u.mgd.p2p_noa_index = noa.index;
+				link->u.mgd.p2p_noa_index = noa.index;
 				memcpy(&bss_conf->p2p_noa_attr, &noa, sizeof(noa));
 				changed |= BSS_CHANGED_P2P_PS;
 				/*
 				 * make sure we update all information, the CRC
 				 * mechanism doesn't look at P2P attributes.
 				 */
-				sdata->deflink.u.mgd.beacon_crc_valid = false;
+				link->u.mgd.beacon_crc_valid = false;
 			}
-		} else if (sdata->deflink.u.mgd.p2p_noa_index != -1) {
+		} else if (link->u.mgd.p2p_noa_index != -1) {
 			/* noa_attr not found and we had valid noa_attr before */
-			sdata->deflink.u.mgd.p2p_noa_index = -1;
+			link->u.mgd.p2p_noa_index = -1;
 			memset(&bss_conf->p2p_noa_attr, 0, sizeof(bss_conf->p2p_noa_attr));
 			changed |= BSS_CHANGED_P2P_PS;
-			sdata->deflink.u.mgd.beacon_crc_valid = false;
+			link->u.mgd.beacon_crc_valid = false;
 		}
 	}
 
-	if (sdata->deflink.u.mgd.csa_waiting_bcn)
-		ieee80211_chswitch_post_beacon(sdata);
+	if (link->u.mgd.csa_waiting_bcn)
+		ieee80211_chswitch_post_beacon(link);
 
 	/*
 	 * Update beacon timing and dtim count on every beacon appearance. This
@@ -4346,27 +4377,27 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	 */
 	if (ieee80211_hw_check(&local->hw, TIMING_BEACON_ONLY) &&
 	    !ieee80211_is_s1g_beacon(hdr->frame_control)) {
-		sdata->vif.bss_conf.sync_tsf =
+		link->conf->sync_tsf =
 			le64_to_cpu(mgmt->u.beacon.timestamp);
-		sdata->vif.bss_conf.sync_device_ts =
+		link->conf->sync_device_ts =
 			rx_status->device_timestamp;
-		sdata->vif.bss_conf.sync_dtim_count = elems->dtim_count;
+		link->conf->sync_dtim_count = elems->dtim_count;
 	}
 
-	if ((ncrc == sdata->deflink.u.mgd.beacon_crc && sdata->deflink.u.mgd.beacon_crc_valid) ||
+	if ((ncrc == link->u.mgd.beacon_crc && link->u.mgd.beacon_crc_valid) ||
 	    ieee80211_is_s1g_short_beacon(mgmt->frame_control))
 		goto free;
-	sdata->deflink.u.mgd.beacon_crc = ncrc;
-	sdata->deflink.u.mgd.beacon_crc_valid = true;
+	link->u.mgd.beacon_crc = ncrc;
+	link->u.mgd.beacon_crc_valid = true;
 
-	ieee80211_rx_bss_info(sdata, mgmt, len, rx_status);
+	ieee80211_rx_bss_info(link, mgmt, len, rx_status);
 
-	ieee80211_sta_process_chanswitch(sdata, rx_status->mactime,
+	ieee80211_sta_process_chanswitch(link, rx_status->mactime,
 					 rx_status->device_timestamp,
 					 elems, true);
 
 	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_WMM) &&
-	    ieee80211_sta_wmm_params(local, &sdata->deflink, elems->wmm_param,
+	    ieee80211_sta_wmm_params(local, link, elems->wmm_param,
 				     elems->wmm_param_len,
 				     elems->mu_edca_param_set))
 		changed |= BSS_CHANGED_QOS;
@@ -4375,12 +4406,12 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	 * If we haven't had a beacon before, tell the driver about the
 	 * DTIM period (and beacon timing if desired) now.
 	 */
-	if (!sdata->deflink.u.mgd.have_beacon) {
+	if (!link->u.mgd.have_beacon) {
 		/* a few bogus AP send dtim_period = 0 or no TIM IE */
 		bss_conf->dtim_period = elems->dtim_period ?: 1;
 
 		changed |= BSS_CHANGED_BEACON_INFO;
-		sdata->deflink.u.mgd.have_beacon = true;
+		link->u.mgd.have_beacon = true;
 
 		mutex_lock(&local->iflist_mtx);
 		ieee80211_recalc_ps(local);
@@ -4404,9 +4435,9 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	mutex_lock(&local->sta_mtx);
 	sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
 
-	changed |= ieee80211_recalc_twt_req(sdata, sta, elems);
+	changed |= ieee80211_recalc_twt_req(link, sta, elems);
 
-	if (ieee80211_config_bw(sdata, sta, elems->ht_cap_elem,
+	if (ieee80211_config_bw(link, sta, elems->ht_cap_elem,
 				elems->vht_cap_elem, elems->ht_operation,
 				elems->vht_operation, elems->he_operation,
 				elems->eht_operation,
@@ -4426,20 +4457,18 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (sta && elems->opmode_notif)
-		ieee80211_vht_handle_opmode(sdata,
-					    &sta->deflink,
+		ieee80211_vht_handle_opmode(sdata, &sta->deflink,
 					    *elems->opmode_notif,
 					    rx_status->band);
 	mutex_unlock(&local->sta_mtx);
 
-	changed |= ieee80211_handle_pwr_constr(sdata, chan, mgmt,
+	changed |= ieee80211_handle_pwr_constr(link, chan, mgmt,
 					       elems->country_elem,
 					       elems->country_elem_len,
 					       elems->pwr_constr_elem,
 					       elems->cisco_dtpc_elem);
 
-	ieee80211_link_info_change_notify(sdata, &sdata->deflink,
-					  changed);
+	ieee80211_link_info_change_notify(sdata, link, changed);
 free:
 	kfree(elems);
 }
@@ -4447,6 +4476,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 void ieee80211_sta_rx_queued_ext(struct ieee80211_sub_if_data *sdata,
 				 struct sk_buff *skb)
 {
+	struct ieee80211_link_data *link = &sdata->deflink;
 	struct ieee80211_rx_status *rx_status;
 	struct ieee80211_hdr *hdr;
 	u16 fc;
@@ -4458,7 +4488,7 @@ void ieee80211_sta_rx_queued_ext(struct ieee80211_sub_if_data *sdata,
 	sdata_lock(sdata);
 	switch (fc & IEEE80211_FCTL_STYPE) {
 	case IEEE80211_STYPE_S1G_BEACON:
-		ieee80211_rx_mgmt_beacon(sdata, hdr, skb->len, rx_status);
+		ieee80211_rx_mgmt_beacon(link, hdr, skb->len, rx_status);
 		break;
 	}
 	sdata_unlock(sdata);
@@ -4467,6 +4497,7 @@ void ieee80211_sta_rx_queued_ext(struct ieee80211_sub_if_data *sdata,
 void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 				  struct sk_buff *skb)
 {
+	struct ieee80211_link_data *link = &sdata->deflink;
 	struct ieee80211_rx_status *rx_status;
 	struct ieee80211_mgmt *mgmt;
 	u16 fc;
@@ -4480,11 +4511,11 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 
 	switch (fc & IEEE80211_FCTL_STYPE) {
 	case IEEE80211_STYPE_BEACON:
-		ieee80211_rx_mgmt_beacon(sdata, (void *)mgmt,
+		ieee80211_rx_mgmt_beacon(link, (void *)mgmt,
 					 skb->len, rx_status);
 		break;
 	case IEEE80211_STYPE_PROBE_RESP:
-		ieee80211_rx_mgmt_probe_resp(sdata, skb);
+		ieee80211_rx_mgmt_probe_resp(link, skb);
 		break;
 	case IEEE80211_STYPE_AUTH:
 		ieee80211_rx_mgmt_auth(sdata, mgmt, skb->len);
@@ -4516,7 +4547,7 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 					ies_len, true, mgmt->bssid, NULL);
 
 			if (elems && !elems->parse_error)
-				ieee80211_sta_process_chanswitch(sdata,
+				ieee80211_sta_process_chanswitch(link,
 								 rx_status->mactime,
 								 rx_status->device_timestamp,
 								 elems, false);
@@ -4544,7 +4575,7 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 				elems->ext_chansw_ie =
 					&mgmt->u.action.u.ext_chan_switch.data;
 
-				ieee80211_sta_process_chanswitch(sdata,
+				ieee80211_sta_process_chanswitch(link,
 								 rx_status->mactime,
 								 rx_status->device_timestamp,
 								 elems, false);
@@ -4860,6 +4891,9 @@ static void ieee80211_sta_bcn_mon_timer(struct timer_list *t)
 	struct ieee80211_sub_if_data *sdata =
 		from_timer(sdata, t, u.mgd.bcn_mon_timer);
 
+	if (WARN_ON(sdata->vif.valid_links))
+		return;
+
 	if (sdata->vif.bss_conf.csa_active &&
 	    !sdata->deflink.u.mgd.csa_waiting_bcn)
 		return;
@@ -4881,6 +4915,9 @@ static void ieee80211_sta_conn_mon_timer(struct timer_list *t)
 	struct sta_info *sta;
 	unsigned long timeout;
 
+	if (WARN_ON(sdata->vif.valid_links))
+		return;
+
 	if (sdata->vif.bss_conf.csa_active &&
 	    !sdata->deflink.u.mgd.csa_waiting_bcn)
 		return;
@@ -5040,7 +5077,6 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 
 	INIT_WORK(&ifmgd->monitor_work, ieee80211_sta_monitor_work);
-	INIT_WORK(&ifmgd->chswitch_work, ieee80211_chswitch_work);
 	INIT_WORK(&ifmgd->beacon_connection_loss_work,
 		  ieee80211_beacon_connection_loss_work);
 	INIT_WORK(&ifmgd->csa_connection_drop_work,
@@ -5050,7 +5086,6 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 	timer_setup(&ifmgd->timer, ieee80211_sta_timer, 0);
 	timer_setup(&ifmgd->bcn_mon_timer, ieee80211_sta_bcn_mon_timer, 0);
 	timer_setup(&ifmgd->conn_mon_timer, ieee80211_sta_conn_mon_timer, 0);
-	timer_setup(&ifmgd->chswitch_timer, ieee80211_chswitch_timer, 0);
 	INIT_DELAYED_WORK(&ifmgd->tx_tspec_wk,
 			  ieee80211_sta_handle_tspec_ac_params_wk);
 
@@ -5078,6 +5113,9 @@ void ieee80211_mgd_setup_link(struct ieee80211_link_data *link)
 		link->u.mgd.req_smps = IEEE80211_SMPS_AUTOMATIC;
 	else
 		link->u.mgd.req_smps = IEEE80211_SMPS_OFF;
+
+	INIT_WORK(&link->u.mgd.chswitch_work, ieee80211_chswitch_work);
+	timer_setup(&link->u.mgd.chswitch_timer, ieee80211_chswitch_timer, 0);
 }
 
 /* scan finished notification */
@@ -5094,7 +5132,7 @@ void ieee80211_mlme_notify_scan_completed(struct ieee80211_local *local)
 	rcu_read_unlock();
 }
 
-static u8 ieee80211_max_rx_chains(struct ieee80211_sub_if_data *sdata,
+static u8 ieee80211_max_rx_chains(struct ieee80211_link_data *link,
 				  struct cfg80211_bss *cbss)
 {
 	struct ieee80211_he_mcs_nss_supp *he_mcs_nss_supp;
@@ -5109,7 +5147,7 @@ static u8 ieee80211_max_rx_chains(struct ieee80211_sub_if_data *sdata,
 	bool support_160;
 	u8 chains = 1;
 
-	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT)
+	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT)
 		return chains;
 
 	ht_cap_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_HT_CAPABILITY);
@@ -5122,7 +5160,7 @@ static u8 ieee80211_max_rx_chains(struct ieee80211_sub_if_data *sdata,
 		 */
 	}
 
-	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)
+	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)
 		return chains;
 
 	vht_cap_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_VHT_CAPABILITY);
@@ -5141,7 +5179,7 @@ static u8 ieee80211_max_rx_chains(struct ieee80211_sub_if_data *sdata,
 		chains = max(chains, nss);
 	}
 
-	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE)
+	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE)
 		return chains;
 
 	ies = rcu_dereference(cbss->ies);
@@ -5363,6 +5401,7 @@ ieee80211_verify_sta_he_mcs_support(struct ieee80211_sub_if_data *sdata,
 }
 
 static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
+				  struct ieee80211_link_data *link,
 				  struct cfg80211_bss *cbss)
 {
 	struct ieee80211_local *local = sdata->local;
@@ -5395,77 +5434,77 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 
 	sband = local->hw.wiphy->bands[cbss->channel->band];
 
-	sdata->deflink.u.mgd.conn_flags &= ~(IEEE80211_CONN_DISABLE_40MHZ |
-					     IEEE80211_CONN_DISABLE_80P80MHZ |
-					     IEEE80211_CONN_DISABLE_160MHZ);
+	link->u.mgd.conn_flags &= ~(IEEE80211_CONN_DISABLE_40MHZ |
+				    IEEE80211_CONN_DISABLE_80P80MHZ |
+				    IEEE80211_CONN_DISABLE_160MHZ);
 
 	/* disable HT/VHT/HE if we don't support them */
 	if (!sband->ht_cap.ht_supported && !is_6ghz) {
 		mlme_dbg(sdata, "HT not supported, disabling HT/VHT/HE/EHT\n");
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 	}
 
 	if (!sband->vht_cap.vht_supported && is_5ghz) {
 		mlme_dbg(sdata, "VHT not supported, disabling VHT/HE/EHT\n");
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 	}
 
 	if (!ieee80211_get_he_iftype_cap(sband,
 					 ieee80211_vif_type_p2p(&sdata->vif))) {
 		mlme_dbg(sdata, "HE not supported, disabling HE and EHT\n");
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 	}
 
 	if (!ieee80211_get_eht_iftype_cap(sband,
 					  ieee80211_vif_type_p2p(&sdata->vif))) {
 		mlme_dbg(sdata, "EHT not supported, disabling EHT\n");
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 	}
 
-	if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT) && !is_6ghz) {
+	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT) && !is_6ghz) {
 		ht_oper = elems->ht_operation;
 		ht_cap = elems->ht_cap_elem;
 
 		if (!ht_cap) {
-			sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
+			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
 			ht_oper = NULL;
 		}
 	}
 
-	if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT) && !is_6ghz) {
+	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT) && !is_6ghz) {
 		vht_oper = elems->vht_operation;
 		if (vht_oper && !ht_oper) {
 			vht_oper = NULL;
 			sdata_info(sdata,
 				   "AP advertised VHT without HT, disabling HT/VHT/HE\n");
-			sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
-			sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-			sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
-			sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
+			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
+			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 		}
 
 		if (!elems->vht_cap_elem) {
 			sdata_info(sdata,
 				   "bad VHT capabilities, disabling VHT\n");
-			sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
 			vht_oper = NULL;
 		}
 	}
 
-	if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE)) {
+	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE)) {
 		he_oper = elems->he_operation;
 
 		if (is_6ghz) {
 			struct ieee80211_bss_conf *bss_conf;
 			u8 i, j = 0;
 
-			bss_conf = &sdata->vif.bss_conf;
+			bss_conf = link->conf;
 
 			if (elems->pwr_constr_elem)
 				bss_conf->pwr_reduction = *elems->pwr_constr_elem;
@@ -5487,8 +5526,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 
 		if (!ieee80211_verify_peer_he_mcs_support(sdata, ies, he_oper) ||
 		    !ieee80211_verify_sta_he_mcs_support(sdata, sband, he_oper))
-			sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE |
-							   IEEE80211_CONN_DISABLE_EHT;
+			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE |
+						  IEEE80211_CONN_DISABLE_EHT;
 	}
 
 	/*
@@ -5497,7 +5536,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	 * both the 6 GHz operation information (from the HE operation IE) and
 	 * EHT operation.
 	 */
-	if (!(sdata->deflink.u.mgd.conn_flags &
+	if (!(link->u.mgd.conn_flags &
 			(IEEE80211_CONN_DISABLE_HE |
 			 IEEE80211_CONN_DISABLE_EHT)) &&
 	    he_oper) {
@@ -5527,7 +5566,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 
 	if (!have_80mhz) {
 		sdata_info(sdata, "80 MHz not supported, disabling VHT\n");
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
 	}
 
 	if (sband->band == NL80211_BAND_S1GHZ) {
@@ -5537,8 +5576,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 				   "AP missing S1G operation element?\n");
 	}
 
-	sdata->deflink.u.mgd.conn_flags |=
-		ieee80211_determine_chantype(sdata, sband,
+	link->u.mgd.conn_flags |=
+		ieee80211_determine_chantype(link, sband,
 					     cbss->channel,
 					     bss->vht_cap_info,
 					     ht_oper, vht_oper,
@@ -5546,21 +5585,21 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 					     s1g_oper,
 					     &chandef, false);
 
-	sdata->deflink.needed_rx_chains =
-		min(ieee80211_max_rx_chains(sdata, cbss), local->rx_chains);
+	link->needed_rx_chains =
+		min(ieee80211_max_rx_chains(link, cbss), local->rx_chains);
 
 	rcu_read_unlock();
 	/* the element data was RCU protected so no longer valid anyway */
 	kfree(elems);
 	elems = NULL;
 
-	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE && is_6ghz) {
+	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE && is_6ghz) {
 		sdata_info(sdata, "Rejecting non-HE 6/7 GHz connection");
 		return -EINVAL;
 	}
 
 	/* will change later if needed */
-	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
+	link->smps_mode = IEEE80211_SMPS_OFF;
 
 	mutex_lock(&local->mtx);
 	/*
@@ -5568,7 +5607,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	 * on incompatible channels, e.g. 80+80 and 160 sharing the
 	 * same control channel) try to use a smaller bandwidth.
 	 */
-	ret = ieee80211_link_use_channel(&sdata->deflink, &chandef,
+	ret = ieee80211_link_use_channel(link, &chandef,
 					 IEEE80211_CHANCTX_SHARED);
 
 	/* don't downgrade for 5 and 10 MHz channels, though. */
@@ -5577,9 +5616,9 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		goto out;
 
 	while (ret && chandef.width != NL80211_CHAN_WIDTH_20_NOHT) {
-		sdata->deflink.u.mgd.conn_flags |=
+		link->u.mgd.conn_flags |=
 			ieee80211_chandef_downgrade(&chandef);
-		ret = ieee80211_link_use_channel(&sdata->deflink, &chandef,
+		ret = ieee80211_link_use_channel(link, &chandef,
 						 IEEE80211_CHANCTX_SHARED);
 	}
  out:
@@ -5630,6 +5669,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_bss *bss = (void *)cbss->priv;
 	struct sta_info *new_sta = NULL;
 	struct ieee80211_supported_band *sband;
+	struct ieee80211_link_data *link = &sdata->deflink;
 	bool have_sta = false;
 	int err;
 
@@ -5673,6 +5713,9 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 		int min_rate = INT_MAX, min_rate_index = -1;
 		const struct cfg80211_bss_ies *ies;
 		int shift = ieee80211_vif_get_shift(&sdata->vif);
+		struct ieee80211_link_sta *link_sta = &new_sta->sta.deflink;
+
+		memcpy(link_sta->addr, cbss->bssid, ETH_ALEN);
 
 		/* TODO: S1G Basic Rate Set is expressed elsewhere */
 		if (cbss->channel->band == NL80211_BAND_S1GHZ) {
@@ -5710,12 +5753,12 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 		}
 
 		if (rates)
-			new_sta->sta.deflink.supp_rates[cbss->channel->band] = rates;
+			link_sta->supp_rates[cbss->channel->band] = rates;
 		else
 			sdata_info(sdata,
 				   "No rates found, keeping mandatory only\n");
 
-		sdata->vif.bss_conf.basic_rates = basic_rates;
+		link->conf->basic_rates = basic_rates;
 
 		/* cf. IEEE 802.11 9.2.12 */
 		if (cbss->channel->band == NL80211_BAND_2GHZ &&
@@ -5725,38 +5768,38 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 			sdata->flags &= ~IEEE80211_SDATA_OPERATING_GMODE;
 
 skip_rates:
-		memcpy(sdata->deflink.u.mgd.bssid, cbss->bssid, ETH_ALEN);
+		memcpy(link->u.mgd.bssid, cbss->bssid, ETH_ALEN);
 
 		/* set timing information */
-		sdata->vif.bss_conf.beacon_int = cbss->beacon_interval;
+		link->conf->beacon_int = cbss->beacon_interval;
 		rcu_read_lock();
 		ies = rcu_dereference(cbss->beacon_ies);
 		if (ies) {
-			sdata->vif.bss_conf.sync_tsf = ies->tsf;
-			sdata->vif.bss_conf.sync_device_ts =
+			link->conf->sync_tsf = ies->tsf;
+			link->conf->sync_device_ts =
 				bss->device_ts_beacon;
 
 			ieee80211_get_dtim(ies,
-					   &sdata->vif.bss_conf.sync_dtim_count,
+					   &link->conf->sync_dtim_count,
 					   NULL);
 		} else if (!ieee80211_hw_check(&sdata->local->hw,
 					       TIMING_BEACON_ONLY)) {
 			ies = rcu_dereference(cbss->proberesp_ies);
 			/* must be non-NULL since beacon IEs were NULL */
-			sdata->vif.bss_conf.sync_tsf = ies->tsf;
-			sdata->vif.bss_conf.sync_device_ts =
+			link->conf->sync_tsf = ies->tsf;
+			link->conf->sync_device_ts =
 				bss->device_ts_presp;
-			sdata->vif.bss_conf.sync_dtim_count = 0;
+			link->conf->sync_dtim_count = 0;
 		} else {
-			sdata->vif.bss_conf.sync_tsf = 0;
-			sdata->vif.bss_conf.sync_device_ts = 0;
-			sdata->vif.bss_conf.sync_dtim_count = 0;
+			link->conf->sync_tsf = 0;
+			link->conf->sync_device_ts = 0;
+			link->conf->sync_dtim_count = 0;
 		}
 		rcu_read_unlock();
 	}
 
 	if (new_sta || override) {
-		err = ieee80211_prep_channel(sdata, cbss);
+		err = ieee80211_prep_channel(sdata, link, cbss);
 		if (err) {
 			if (new_sta)
 				sta_info_free(local, new_sta);
@@ -5769,7 +5812,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 		 * tell driver about BSSID, basic rates and timing
 		 * this was set up above, before setting the channel
 		 */
-		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+		ieee80211_link_info_change_notify(sdata, link,
 						  BSS_CHANGED_BSSID |
 						  BSS_CHANGED_BASIC_RATES |
 						  BSS_CHANGED_BEACON_INT);
@@ -5786,7 +5829,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 			return err;
 		}
 	} else
-		WARN_ON_ONCE(!ether_addr_equal(sdata->deflink.u.mgd.bssid, cbss->bssid));
+		WARN_ON_ONCE(!ether_addr_equal(link->u.mgd.bssid, cbss->bssid));
 
 	/* Cancel scan to ensure that nothing interferes with connection */
 	if (local->scanning)
@@ -5799,6 +5842,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 		       struct cfg80211_auth_request *req)
 {
+	struct ieee80211_link_data *link = &sdata->deflink;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_mgd_auth_data *auth_data;
@@ -5937,7 +5981,7 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	return 0;
 
  err_clear:
-	eth_zero_addr(sdata->deflink.u.mgd.bssid);
+	eth_zero_addr(link->u.mgd.bssid);
 	ieee80211_link_info_change_notify(sdata, &sdata->deflink,
 					  BSS_CHANGED_BSSID);
 	ifmgd->auth_data = NULL;
@@ -5961,6 +6005,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_vif_cfg *vif_cfg = &sdata->vif.cfg;
 	const struct element *ssid_elem, *ht_elem, *vht_elem;
+	struct ieee80211_link_data *link = &sdata->deflink;
 	int i, err;
 	bool override = false;
 
@@ -6018,7 +6063,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 
 	/* prepare assoc data */
 
-	sdata->deflink.u.mgd.beacon_crc_valid = false;
+	link->u.mgd.beacon_crc_valid = false;
 
 	assoc_data->wmm = bss->wmm_used &&
 			  (local->hw.queues >= IEEE80211_NUM_ACS);
@@ -6034,10 +6079,10 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		if (req->crypto.ciphers_pairwise[i] == WLAN_CIPHER_SUITE_WEP40 ||
 		    req->crypto.ciphers_pairwise[i] == WLAN_CIPHER_SUITE_TKIP ||
 		    req->crypto.ciphers_pairwise[i] == WLAN_CIPHER_SUITE_WEP104) {
-			sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
-			sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-			sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
-			sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
+			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
+			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 			netdev_info(sdata->dev,
 				    "disabling HT/VHT/HE due to WEP/TKIP use\n");
 		}
@@ -6047,10 +6092,10 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 
 	/* also disable HT/VHT/HE/EHT if the AP doesn't use WMM */
 	if (!bss->wmm_used) {
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 		netdev_info(sdata->dev,
 			    "disabling HT/VHT/HE as WMM/QoS is not supported by the AP\n");
 	}
@@ -6098,7 +6143,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		assoc_data->ap_ht_param =
 			((struct ieee80211_ht_operation *)(ht_elem->data))->ht_param;
 	else if (!is_6ghz)
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
 	vht_elem = ieee80211_bss_get_elem(req->bss, WLAN_EID_VHT_CAPABILITY);
 	if (vht_elem && vht_elem->datalen >= sizeof(struct ieee80211_vht_cap)) {
 		memcpy(&assoc_data->ap_vht_cap, vht_elem->data,
@@ -6106,7 +6151,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	} else if (is_5ghz) {
 		sdata_info(sdata,
 			   "VHT capa missing/short, disabling VHT/HE/EHT\n");
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT |
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT |
 				IEEE80211_CONN_DISABLE_HE |
 				IEEE80211_CONN_DISABLE_EHT;
 	}
@@ -6156,11 +6201,11 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	/* kick off associate process */
 
 	ifmgd->assoc_data = assoc_data;
-	sdata->deflink.u.mgd.dtim_period = 0;
-	sdata->deflink.u.mgd.have_beacon = false;
+	link->u.mgd.dtim_period = 0;
+	link->u.mgd.have_beacon = false;
 
 	/* override HT/VHT configuration only if the AP and we support it */
-	if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT)) {
+	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT)) {
 		struct ieee80211_sta_ht_cap sta_ht_cap;
 
 		if (req->flags & ASSOC_REQ_DISABLE_HT)
@@ -6170,49 +6215,49 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);
 
 		/* check for 40 MHz disable override */
-		if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_40MHZ) &&
+		if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_40MHZ) &&
 		    sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
 		    !(sta_ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40))
 			override = true;
 
-		if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT) &&
+		if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT) &&
 		    req->flags & ASSOC_REQ_DISABLE_VHT)
 			override = true;
 	}
 
 	if (req->flags & ASSOC_REQ_DISABLE_HT) {
 		mlme_dbg(sdata, "HT disabled by flag, disabling HT/VHT/HE\n");
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 	}
 
 	if (req->flags & ASSOC_REQ_DISABLE_VHT) {
 		mlme_dbg(sdata, "VHT disabled by flag, disabling VHT\n");
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
 	}
 
 	if (req->flags & ASSOC_REQ_DISABLE_HE) {
 		mlme_dbg(sdata, "HE disabled by flag, disabling HE/EHT\n");
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 	}
 
 	if (req->flags & ASSOC_REQ_DISABLE_EHT)
-		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 
 	err = ieee80211_prep_connection(sdata, req->bss, true, override);
 	if (err)
 		goto err_clear;
 
-	if (sdata->deflink.u.mgd.req_smps == IEEE80211_SMPS_AUTOMATIC) {
+	if (link->u.mgd.req_smps == IEEE80211_SMPS_AUTOMATIC) {
 		if (ifmgd->powersave)
-			sdata->deflink.smps_mode = IEEE80211_SMPS_DYNAMIC;
+			link->smps_mode = IEEE80211_SMPS_DYNAMIC;
 		else
-			sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
+			link->smps_mode = IEEE80211_SMPS_OFF;
 	} else {
-		sdata->deflink.smps_mode = sdata->deflink.u.mgd.req_smps;
+		link->smps_mode = link->u.mgd.req_smps;
 	}
 
 	rcu_read_lock();
@@ -6225,7 +6270,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		 * should this be more if we miss one?
 		 */
 		sdata_info(sdata, "waiting for beacon from %pM\n",
-			   sdata->deflink.u.mgd.bssid);
+			   link->u.mgd.bssid);
 		assoc_data->timeout = TU_TO_EXP_TIME(req->bss->beacon_interval);
 		assoc_data->timeout_started = true;
 		assoc_data->need_beacon = true;
@@ -6234,33 +6279,33 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		u8 dtim_count = 0;
 
 		ieee80211_get_dtim(beacon_ies, &dtim_count,
-				   &sdata->deflink.u.mgd.dtim_period);
+				   &link->u.mgd.dtim_period);
 
-		sdata->deflink.u.mgd.have_beacon = true;
+		link->u.mgd.have_beacon = true;
 		assoc_data->timeout = jiffies;
 		assoc_data->timeout_started = true;
 
 		if (ieee80211_hw_check(&local->hw, TIMING_BEACON_ONLY)) {
-			sdata->vif.bss_conf.sync_tsf = beacon_ies->tsf;
-			sdata->vif.bss_conf.sync_device_ts =
+			link->conf->sync_tsf = beacon_ies->tsf;
+			link->conf->sync_device_ts =
 				bss->device_ts_beacon;
-			sdata->vif.bss_conf.sync_dtim_count = dtim_count;
+			link->conf->sync_dtim_count = dtim_count;
 		}
 
 		elem = cfg80211_find_ext_elem(WLAN_EID_EXT_MULTIPLE_BSSID_CONFIGURATION,
 					      beacon_ies->data, beacon_ies->len);
 		if (elem && elem->datalen >= 3)
-			sdata->vif.bss_conf.profile_periodicity = elem->data[2];
+			link->conf->profile_periodicity = elem->data[2];
 		else
-			sdata->vif.bss_conf.profile_periodicity = 0;
+			link->conf->profile_periodicity = 0;
 
 		elem = cfg80211_find_elem(WLAN_EID_EXT_CAPABILITY,
 					  beacon_ies->data, beacon_ies->len);
 		if (elem && elem->datalen >= 11 &&
 		    (elem->data[10] & WLAN_EXT_CAPA11_EMA_SUPPORT))
-			sdata->vif.bss_conf.ema_ap = true;
+			link->conf->ema_ap = true;
 		else
-			sdata->vif.bss_conf.ema_ap = false;
+			link->conf->ema_ap = false;
 	} else {
 		assoc_data->timeout = jiffies;
 		assoc_data->timeout_started = true;
@@ -6285,7 +6330,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 
 	return 0;
  err_clear:
-	eth_zero_addr(sdata->deflink.u.mgd.bssid);
+	eth_zero_addr(link->u.mgd.bssid);
 	ieee80211_link_info_change_notify(sdata, &sdata->deflink,
 					  BSS_CHANGED_BSSID);
 	ifmgd->assoc_data = NULL;
@@ -6393,6 +6438,7 @@ int ieee80211_mgd_disassoc(struct ieee80211_sub_if_data *sdata,
 void ieee80211_mgd_stop_link(struct ieee80211_link_data *link)
 {
 	cancel_work_sync(&link->u.mgd.request_smps_work);
+	cancel_work_sync(&link->u.mgd.chswitch_work);
 }
 
 void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
@@ -6407,7 +6453,6 @@ void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 	cancel_work_sync(&ifmgd->monitor_work);
 	cancel_work_sync(&ifmgd->beacon_connection_loss_work);
 	cancel_work_sync(&ifmgd->csa_connection_drop_work);
-	cancel_work_sync(&ifmgd->chswitch_work);
 	cancel_delayed_work_sync(&ifmgd->tdls_peer_del_work);
 
 	sdata_lock(sdata);
-- 
2.36.1

