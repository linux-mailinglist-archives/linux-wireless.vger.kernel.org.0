Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB63F4B5632
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 17:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356397AbiBNQaa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 11:30:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356389AbiBNQaW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 11:30:22 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F86E60AB8
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 08:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=E+VQTb/6oqbOJmKq11AjFK4ElJlzMfMPVab0PznaSwk=;
        t=1644856213; x=1646065813; b=tJ0dGLKFiAEHY7KH+WVAzxMZhJWYXjtA0WJxUwImg2d1AH1
        vwK4pKwBZbYgbra7n1MIfqtlQaGDwZcFDJqbRFSl4In/5hYfbdW94ikSrWXuwugOp0EMONvfS/ulu
        nE27JsWtvHr+zL+/Vrl5+QNFlkIBrF96OnmHCu311jHgyKthv/iPGOKgi6KxqqDjpDoixrwP4MB5s
        Xp3X6SwfR/7U+cxRez6SNWt/SIAXCuV4OBdFVBmNGY9lQFNjUlUwypHT4ovBGZ07x3rj4NxbylRc3
        sG60ljpMYRuZx6y3EgaptWb2vozmzl1J7CgQtH0RJtOS8dOyeEr5Fxkjiy/I6Mcw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nJeEt-0011mw-KH;
        Mon, 14 Feb 2022 17:30:11 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v3 13/19] mac80211: Add initial support for EHT and 320 MHz channels
Date:   Mon, 14 Feb 2022 17:30:00 +0100
Message-Id: <20220214173004.0f144cc0bba6.Iad18111264da87eed5fd7b017f0cc6e58c604e07@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
References: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
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

From: Ilan Peer <ilan.peer@intel.com>

Add initial support for EHT and 320 MHz bandwidth in mac80211.

As a new IEEE80211_STA_RX_BW_320 is added to
enum ieee80211_sta_rx_bandwidth, update the drivers to avoid
compilation warnings.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c |   1 +
 drivers/net/wireless/mac80211_hwsim.c        |   1 +
 include/net/mac80211.h                       |   2 +
 net/mac80211/chan.c                          |   5 +-
 net/mac80211/ieee80211_i.h                   |   3 +
 net/mac80211/mesh.c                          |   5 +-
 net/mac80211/mlme.c                          | 109 +++++++++++---
 net/mac80211/util.c                          | 142 ++++++++++++++-----
 net/mac80211/vht.c                           |   4 +-
 9 files changed, 213 insertions(+), 59 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index feab0bfcd7a2..da40fd043c0e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -87,6 +87,7 @@ int iwl_mvm_sta_send_to_fw(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	}
 
 	switch (sta->bandwidth) {
+	case IEEE80211_STA_RX_BW_320:
 	case IEEE80211_STA_RX_BW_160:
 		add_sta_cmd.station_flags |= cpu_to_le32(STA_FLG_FAT_EN_160MHZ);
 		fallthrough;
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 0054c234fb9a..fdf781548e3f 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2195,6 +2195,7 @@ mac80211_hwsim_sta_rc_update(struct ieee80211_hw *hw,
 	C(40);
 	C(80);
 	C(160);
+	C(320);
 #undef C
 	}
 
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index bd6912d0292b..586d3c26c8ac 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2005,6 +2005,7 @@ enum ieee80211_sta_state {
  * @IEEE80211_STA_RX_BW_80: station can receive up to 80 MHz
  * @IEEE80211_STA_RX_BW_160: station can receive up to 160 MHz
  *	(including 80+80 MHz)
+ * @IEEE80211_STA_RX_BW_320: station can receive up to 320 MHz
  *
  * Implementation note: 20 must be zero to be initialized
  *	correctly, the values must be sorted.
@@ -2014,6 +2015,7 @@ enum ieee80211_sta_rx_bandwidth {
 	IEEE80211_STA_RX_BW_40,
 	IEEE80211_STA_RX_BW_80,
 	IEEE80211_STA_RX_BW_160,
+	IEEE80211_STA_RX_BW_320,
 };
 
 /**
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 76fc36a68750..e26d42de14ec 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -218,6 +218,8 @@ static enum nl80211_chan_width ieee80211_get_sta_bw(struct sta_info *sta)
 		 * might be smaller than the configured bw (160).
 		 */
 		return NL80211_CHAN_WIDTH_160;
+	case IEEE80211_STA_RX_BW_320:
+		return NL80211_CHAN_WIDTH_320;
 	default:
 		WARN_ON(1);
 		return NL80211_CHAN_WIDTH_20;
@@ -417,7 +419,7 @@ static void ieee80211_change_chanctx(struct ieee80211_local *local,
 {
 	u32 changed;
 
-	/* expected to handle only 20/40/80/160 channel widths */
+	/* expected to handle only 20/40/80/160/320 channel widths */
 	switch (chandef->width) {
 	case NL80211_CHAN_WIDTH_20_NOHT:
 	case NL80211_CHAN_WIDTH_20:
@@ -425,6 +427,7 @@ static void ieee80211_change_chanctx(struct ieee80211_local *local,
 	case NL80211_CHAN_WIDTH_80:
 	case NL80211_CHAN_WIDTH_80P80:
 	case NL80211_CHAN_WIDTH_160:
+	case NL80211_CHAN_WIDTH_320:
 		break;
 	default:
 		WARN_ON(1);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 538d047d7f27..6a93dfcaad21 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -366,6 +366,8 @@ enum ieee80211_sta_flags {
 	IEEE80211_STA_DISABLE_WMM	= BIT(14),
 	IEEE80211_STA_ENABLE_RRM	= BIT(15),
 	IEEE80211_STA_DISABLE_HE	= BIT(16),
+	IEEE80211_STA_DISABLE_EHT	= BIT(17),
+	IEEE80211_STA_DISABLE_320MHZ	= BIT(18),
 };
 
 struct ieee80211_mgd_auth_data {
@@ -2414,6 +2416,7 @@ bool ieee80211_chandef_vht_oper(struct ieee80211_hw *hw, u32 vht_cap_info,
 				struct cfg80211_chan_def *chandef);
 bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 				    const struct ieee80211_he_operation *he_oper,
+				    const struct ieee80211_eht_operation *eht_oper,
 				    struct cfg80211_chan_def *chandef);
 bool ieee80211_chandef_s1g_oper(const struct ieee80211_s1g_oper_ie *oper,
 				struct cfg80211_chan_def *chandef);
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 6847fdf93439..1d3b4ad32965 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2008, 2009 open80211s Ltd.
- * Copyright (C) 2018 - 2020 Intel Corporation
+ * Copyright (C) 2018 - 2021 Intel Corporation
  * Authors:    Luis Carlos Cobo <luisca@cozybit.com>
  * 	       Javier Cardona <javier@cozybit.com>
  */
@@ -104,7 +104,8 @@ bool mesh_matches_local(struct ieee80211_sub_if_data *sdata,
 	ieee80211_chandef_vht_oper(&sdata->local->hw, vht_cap_info,
 				   ie->vht_operation, ie->ht_operation,
 				   &sta_chan_def);
-	ieee80211_chandef_he_6ghz_oper(sdata, ie->he_operation, &sta_chan_def);
+	ieee80211_chandef_he_6ghz_oper(sdata, ie->he_operation, NULL,
+				       &sta_chan_def);
 
 	if (!cfg80211_chandef_compatible(&sdata->vif.bss_conf.chandef,
 					 &sta_chan_def))
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index cb89538571c2..dac0b495ae76 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -149,6 +149,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 			     const struct ieee80211_ht_operation *ht_oper,
 			     const struct ieee80211_vht_operation *vht_oper,
 			     const struct ieee80211_he_operation *he_oper,
+			     const struct ieee80211_eht_operation *eht_oper,
 			     const struct ieee80211_s1g_oper_ie *s1g_oper,
 			     struct cfg80211_chan_def *chandef, bool tracking)
 {
@@ -164,12 +165,14 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	chandef->freq1_offset = channel->freq_offset;
 
 	if (channel->band == NL80211_BAND_6GHZ) {
-		if (!ieee80211_chandef_he_6ghz_oper(sdata, he_oper, chandef)) {
+		if (!ieee80211_chandef_he_6ghz_oper(sdata, he_oper, eht_oper,
+						    chandef)) {
 			mlme_dbg(sdata,
-				 "bad 6 GHz operation, disabling HT/VHT/HE\n");
+				 "bad 6 GHz operation, disabling HT/VHT/HE/EHT\n");
 			ret = IEEE80211_STA_DISABLE_HT |
 			      IEEE80211_STA_DISABLE_VHT |
-			      IEEE80211_STA_DISABLE_HE;
+			      IEEE80211_STA_DISABLE_HE |
+			      IEEE80211_STA_DISABLE_EHT;
 		} else {
 			ret = 0;
 		}
@@ -196,7 +199,8 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 		mlme_dbg(sdata, "HT operation missing / HT not supported\n");
 		ret = IEEE80211_STA_DISABLE_HT |
 		      IEEE80211_STA_DISABLE_VHT |
-		      IEEE80211_STA_DISABLE_HE;
+		      IEEE80211_STA_DISABLE_HE |
+		      IEEE80211_STA_DISABLE_EHT;
 		goto out;
 	}
 
@@ -219,7 +223,8 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 			   ht_oper->primary_chan, channel->band);
 		ret = IEEE80211_STA_DISABLE_HT |
 		      IEEE80211_STA_DISABLE_VHT |
-		      IEEE80211_STA_DISABLE_HE;
+		      IEEE80211_STA_DISABLE_HE |
+		      IEEE80211_STA_DISABLE_EHT;
 		goto out;
 	}
 
@@ -260,7 +265,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 			if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE))
 				sdata_info(sdata,
 					   "HE AP VHT information is invalid, disabling HE\n");
-			ret = IEEE80211_STA_DISABLE_HE;
+			ret = IEEE80211_STA_DISABLE_HE | IEEE80211_STA_DISABLE_EHT;
 			goto out;
 		}
 	} else if (!ieee80211_chandef_vht_oper(&sdata->local->hw,
@@ -340,7 +345,8 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 		if (WARN_ON(chandef->width == NL80211_CHAN_WIDTH_20_NOHT)) {
 			ret = IEEE80211_STA_DISABLE_HT |
 			      IEEE80211_STA_DISABLE_VHT |
-			      IEEE80211_STA_DISABLE_HE;
+			      IEEE80211_STA_DISABLE_HE |
+			      IEEE80211_STA_DISABLE_EHT;
 			break;
 		}
 
@@ -349,7 +355,11 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 
 	if (!he_oper || !cfg80211_chandef_usable(sdata->wdev.wiphy, chandef,
 						 IEEE80211_CHAN_NO_HE))
-		ret |= IEEE80211_STA_DISABLE_HE;
+		ret |= IEEE80211_STA_DISABLE_HE | IEEE80211_STA_DISABLE_EHT;
+
+	if (!eht_oper || !cfg80211_chandef_usable(sdata->wdev.wiphy, chandef,
+						  IEEE80211_CHAN_NO_EHT))
+		ret |= IEEE80211_STA_DISABLE_EHT;
 
 	if (chandef->width != vht_chandef.width && !tracking)
 		sdata_info(sdata,
@@ -366,6 +376,7 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 			       const struct ieee80211_ht_operation *ht_oper,
 			       const struct ieee80211_vht_operation *vht_oper,
 			       const struct ieee80211_he_operation *he_oper,
+			       const struct ieee80211_eht_operation *eht_oper,
 			       const struct ieee80211_s1g_oper_ie *s1g_oper,
 			       const u8 *bssid, u32 *changed)
 {
@@ -391,9 +402,16 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 	/* don't check HE if we associated as non-HE station */
 	if (ifmgd->flags & IEEE80211_STA_DISABLE_HE ||
 	    !ieee80211_get_he_iftype_cap(sband,
-					 ieee80211_vif_type_p2p(&sdata->vif)))
-
+					 ieee80211_vif_type_p2p(&sdata->vif))) {
 		he_oper = NULL;
+		eht_oper = NULL;
+	}
+
+	/* don't check EHT if we associated as non-EHT station */
+	if (ifmgd->flags & IEEE80211_STA_DISABLE_EHT ||
+	    !ieee80211_get_eht_iftype_cap(sband,
+					 ieee80211_vif_type_p2p(&sdata->vif)))
+		eht_oper = NULL;
 
 	if (WARN_ON_ONCE(!sta))
 		return -EINVAL;
@@ -413,7 +431,8 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 
 	/* calculate new channel (type) based on HT/VHT/HE operation IEs */
 	flags = ieee80211_determine_chantype(sdata, sband, chan, vht_cap_info,
-					     ht_oper, vht_oper, he_oper,
+					     ht_oper, vht_oper,
+					     he_oper, eht_oper,
 					     s1g_oper, &chandef, true);
 
 	/*
@@ -447,9 +466,11 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 	if (flags != (ifmgd->flags & (IEEE80211_STA_DISABLE_HT |
 				      IEEE80211_STA_DISABLE_VHT |
 				      IEEE80211_STA_DISABLE_HE |
+				      IEEE80211_STA_DISABLE_EHT |
 				      IEEE80211_STA_DISABLE_40MHZ |
 				      IEEE80211_STA_DISABLE_80P80MHZ |
-				      IEEE80211_STA_DISABLE_160MHZ)) ||
+				      IEEE80211_STA_DISABLE_160MHZ |
+				      IEEE80211_STA_DISABLE_320MHZ)) ||
 	    !cfg80211_chandef_valid(&chandef)) {
 		sdata_info(sdata,
 			   "AP %pM changed caps/bw in a way we can't support (0x%x/0x%x) - disconnect\n",
@@ -990,13 +1011,14 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 				     &assoc_data->ap_vht_cap);
 
 	/*
-	 * If AP doesn't support HT, mark HE as disabled.
+	 * If AP doesn't support HT, mark HE and EHT as disabled.
 	 * If on the 5GHz band, make sure it supports VHT.
 	 */
 	if (ifmgd->flags & IEEE80211_STA_DISABLE_HT ||
 	    (sband->band == NL80211_BAND_5GHZ &&
 	     ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
-		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
+		ifmgd->flags |= IEEE80211_STA_DISABLE_HE |
+			        IEEE80211_STA_DISABLE_EHT;
 
 	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE))
 		ieee80211_add_he_ie(sdata, skb, sband);
@@ -4258,6 +4280,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	if (ieee80211_config_bw(sdata, sta, elems->ht_cap_elem,
 				elems->vht_cap_elem, elems->ht_operation,
 				elems->vht_operation, elems->he_operation,
+				elems->eht_operation,
 				elems->s1g_oper, bssid, &changed)) {
 		mutex_unlock(&local->sta_mtx);
 		sdata_info(sdata,
@@ -5185,6 +5208,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	const struct ieee80211_ht_operation *ht_oper = NULL;
 	const struct ieee80211_vht_operation *vht_oper = NULL;
 	const struct ieee80211_he_operation *he_oper = NULL;
+	const struct ieee80211_eht_operation *eht_oper = NULL;
 	const struct ieee80211_s1g_oper_ie *s1g_oper = NULL;
 	struct ieee80211_supported_band *sband;
 	struct cfg80211_chan_def chandef;
@@ -5215,22 +5239,31 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 
 	/* disable HT/VHT/HE if we don't support them */
 	if (!sband->ht_cap.ht_supported && !is_6ghz) {
-		mlme_dbg(sdata, "HT not supported, disabling HT/VHT/HE\n");
+		mlme_dbg(sdata, "HT not supported, disabling HT/VHT/HE/EHT\n");
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
+		ifmgd->flags |= IEEE80211_STA_DISABLE_EHT;
 	}
 
 	if (!sband->vht_cap.vht_supported && is_5ghz) {
-		mlme_dbg(sdata, "VHT not supported, disabling VHT/HE\n");
+		mlme_dbg(sdata, "VHT not supported, disabling VHT/HE/EHT\n");
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
+		ifmgd->flags |= IEEE80211_STA_DISABLE_EHT;
 	}
 
 	if (!ieee80211_get_he_iftype_cap(sband,
 					 ieee80211_vif_type_p2p(&sdata->vif))) {
-		mlme_dbg(sdata, "HE not supported, disabling it\n");
+		mlme_dbg(sdata, "HE not supported, disabling HE and EHT\n");
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
+		ifmgd->flags |= IEEE80211_STA_DISABLE_EHT;
+	}
+
+	if (!ieee80211_get_eht_iftype_cap(sband,
+					  ieee80211_vif_type_p2p(&sdata->vif))) {
+		mlme_dbg(sdata, "EHT not supported, disabling EHT\n");
+		ifmgd->flags |= IEEE80211_STA_DISABLE_EHT;
 	}
 
 	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT) && !is_6ghz) {
@@ -5252,6 +5285,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 			ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
 			ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
 			ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
+			ifmgd->flags |= IEEE80211_STA_DISABLE_EHT;
 		}
 
 		if (!elems->vht_cap_elem) {
@@ -5291,7 +5325,29 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 
 		if (!ieee80211_verify_peer_he_mcs_support(sdata, ies, he_oper) ||
 		    !ieee80211_verify_sta_he_mcs_support(sdata, sband, he_oper))
-			ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
+			ifmgd->flags |= IEEE80211_STA_DISABLE_HE |
+				        IEEE80211_STA_DISABLE_EHT;
+	}
+
+	/*
+	 * EHT requires HE to be supported as well. Specifically for 6 GHz
+	 * channels, the operation channel information can only be deduced from
+	 * both the 6 GHz operation information (from the HE operation IE) and
+	 * EHT operation.
+	 */
+	if (!(ifmgd->flags & (IEEE80211_STA_DISABLE_HE |
+			      IEEE80211_STA_DISABLE_EHT)) && he_oper) {
+		const struct cfg80211_bss_ies *ies;
+		const u8 *eht_oper_ie;
+
+		ies = rcu_dereference(cbss->ies);
+		eht_oper_ie = cfg80211_find_ext_ie(WLAN_EID_EXT_EHT_OPERATION,
+						   ies->data, ies->len);
+		if (eht_oper_ie && eht_oper_ie[1] >=
+		    1 + sizeof(struct ieee80211_eht_operation))
+			eht_oper = (void *)(eht_oper_ie + 3);
+		else
+			eht_oper = NULL;
 	}
 
 	/* Allow VHT if at least one channel on the sband supports 80 MHz */
@@ -5320,7 +5376,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	ifmgd->flags |= ieee80211_determine_chantype(sdata, sband,
 						     cbss->channel,
 						     bss->vht_cap_info,
-						     ht_oper, vht_oper, he_oper,
+						     ht_oper, vht_oper,
+						     he_oper, eht_oper,
 						     s1g_oper,
 						     &chandef, false);
 
@@ -5811,6 +5868,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 			ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
 			ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
 			ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
+			ifmgd->flags |= IEEE80211_STA_DISABLE_EHT;
 			netdev_info(sdata->dev,
 				    "disabling HT/VHT/HE due to WEP/TKIP use\n");
 		}
@@ -5818,11 +5876,12 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 
 	sband = local->hw.wiphy->bands[req->bss->channel->band];
 
-	/* also disable HT/VHT/HE if the AP doesn't use WMM */
+	/* also disable HT/VHT/HE/EHT if the AP doesn't use WMM */
 	if (!bss->wmm_used) {
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
+		ifmgd->flags |= IEEE80211_STA_DISABLE_EHT;
 		netdev_info(sdata->dev,
 			    "disabling HT/VHT/HE as WMM/QoS is not supported by the AP\n");
 	}
@@ -5876,9 +5935,11 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		memcpy(&assoc_data->ap_vht_cap, vht_elem->data,
 		       sizeof(struct ieee80211_vht_cap));
 	} else if (is_5ghz) {
-		sdata_info(sdata, "VHT capa missing/short, disabling VHT/HE\n");
+		sdata_info(sdata,
+			   "VHT capa missing/short, disabling VHT/HE/EHT\n");
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT |
-				IEEE80211_STA_DISABLE_HE;
+				IEEE80211_STA_DISABLE_HE |
+				IEEE80211_STA_DISABLE_EHT;
 	}
 	rcu_read_unlock();
 
@@ -5957,6 +6018,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
+		ifmgd->flags |= IEEE80211_STA_DISABLE_EHT;
 	}
 
 	if (req->flags & ASSOC_REQ_DISABLE_VHT) {
@@ -5965,8 +6027,9 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (req->flags & ASSOC_REQ_DISABLE_HE) {
-		mlme_dbg(sdata, "HE disabled by flag, disabling VHT\n");
+		mlme_dbg(sdata, "HE disabled by flag, disabling HE/EHT\n");
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
+		ifmgd->flags |= IEEE80211_STA_DISABLE_EHT;
 	}
 
 	err = ieee80211_prep_connection(sdata, req->bss, true, override);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index b3c3191b86ee..09bf9c45256e 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3086,6 +3086,10 @@ u8 *ieee80211_ie_build_ht_oper(u8 *pos, struct ieee80211_sta_ht_cap *ht_cap,
 		else
 			ht_oper->ht_param = IEEE80211_HT_PARAM_CHA_SEC_BELOW;
 		break;
+	case NL80211_CHAN_WIDTH_320:
+		/* HT information element should not be included on 6GHz */
+		WARN_ON(1);
+		return pos;
 	default:
 		ht_oper->ht_param = IEEE80211_HT_PARAM_CHA_SEC_NONE;
 		break;
@@ -3125,6 +3129,10 @@ void ieee80211_ie_build_wide_bw_cs(u8 *pos,
 	case NL80211_CHAN_WIDTH_80P80:
 		*pos++ = IEEE80211_VHT_CHANWIDTH_80P80MHZ;
 		break;
+	case NL80211_CHAN_WIDTH_320:
+		/* The behavior is not defined for 320 MHz channels */
+		WARN_ON(1);
+		fallthrough;
 	default:
 		*pos++ = IEEE80211_VHT_CHANWIDTH_USE_HT;
 	}
@@ -3177,6 +3185,10 @@ u8 *ieee80211_ie_build_vht_oper(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 	case NL80211_CHAN_WIDTH_80:
 		vht_oper->chan_width = IEEE80211_VHT_CHANWIDTH_80MHZ;
 		break;
+	case NL80211_CHAN_WIDTH_320:
+		/* VHT information element should not be included on 6GHz */
+		WARN_ON(1);
+		return pos;
 	default:
 		vht_oper->chan_width = IEEE80211_VHT_CHANWIDTH_USE_HT;
 		break;
@@ -3237,6 +3249,13 @@ u8 *ieee80211_ie_build_he_oper(u8 *pos, struct cfg80211_chan_def *chandef)
 		he_6ghz_op->ccfs1 = 0;
 
 	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_320:
+		/*
+		 * TODO: mesh operation is not defined over 6GHz 320 MHz
+		 * channels.
+		 */
+		WARN_ON(1);
+		break;
 	case NL80211_CHAN_WIDTH_160:
 		/* Convert 160 MHz channel width to new style as interop
 		 * workaround.
@@ -3425,17 +3444,19 @@ bool ieee80211_chandef_vht_oper(struct ieee80211_hw *hw, u32 vht_cap_info,
 
 bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 				    const struct ieee80211_he_operation *he_oper,
+				    const struct ieee80211_eht_operation *eht_oper,
 				    struct cfg80211_chan_def *chandef)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_supported_band *sband;
 	enum nl80211_iftype iftype = ieee80211_vif_type_p2p(&sdata->vif);
 	const struct ieee80211_sta_he_cap *he_cap;
+	const struct ieee80211_sta_eht_cap *eht_cap;
 	struct cfg80211_chan_def he_chandef = *chandef;
 	const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
 	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
-	bool support_80_80, support_160;
-	u8 he_phy_cap;
+	bool support_80_80, support_160, support_320;
+	u8 he_phy_cap, eht_phy_cap;
 	u32 freq;
 
 	if (chandef->chan->band != NL80211_BAND_6GHZ)
@@ -3464,6 +3485,12 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 		return false;
 	}
 
+	eht_cap = ieee80211_get_eht_iftype_cap(sband, iftype);
+	if (!eht_cap) {
+		sdata_info(sdata, "Missing iftype sband data/EHT cap");
+		eht_oper = NULL;
+	}
+
 	he_6ghz_oper = ieee80211_he_6ghz_oper(he_oper);
 
 	if (!he_6ghz_oper) {
@@ -3473,6 +3500,11 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 		return false;
 	}
 
+	/*
+	 * The EHT operation IE does not contain the primary channel so the
+	 * primary channel frequency should be taken from the 6 GHz operation
+	 * information.
+	 */
 	freq = ieee80211_channel_to_frequency(he_6ghz_oper->primary,
 					      NL80211_BAND_6GHZ);
 	he_chandef.chan = ieee80211_get_channel(sdata->local->hw.wiphy, freq);
@@ -3490,43 +3522,80 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 		break;
 	}
 
-	switch (u8_get_bits(he_6ghz_oper->control,
-			    IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH)) {
-	case IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_20MHZ:
-		he_chandef.width = NL80211_CHAN_WIDTH_20;
-		break;
-	case IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_40MHZ:
-		he_chandef.width = NL80211_CHAN_WIDTH_40;
-		break;
-	case IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_80MHZ:
-		he_chandef.width = NL80211_CHAN_WIDTH_80;
-		break;
-	case IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ:
-		he_chandef.width = NL80211_CHAN_WIDTH_80;
-		if (!he_6ghz_oper->ccfs1)
+	if (!eht_oper) {
+		switch (u8_get_bits(he_6ghz_oper->control,
+				    IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH)) {
+		case IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_20MHZ:
+			he_chandef.width = NL80211_CHAN_WIDTH_20;
+			break;
+		case IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_40MHZ:
+			he_chandef.width = NL80211_CHAN_WIDTH_40;
+			break;
+		case IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_80MHZ:
+			he_chandef.width = NL80211_CHAN_WIDTH_80;
+			break;
+		case IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ:
+			he_chandef.width = NL80211_CHAN_WIDTH_80;
+			if (!he_6ghz_oper->ccfs1)
+				break;
+			if (abs(he_6ghz_oper->ccfs1 - he_6ghz_oper->ccfs0) == 8) {
+				if (support_160)
+					he_chandef.width = NL80211_CHAN_WIDTH_160;
+			} else {
+				if (support_80_80)
+					he_chandef.width = NL80211_CHAN_WIDTH_80P80;
+			}
+			break;
+		}
+
+		if (he_chandef.width == NL80211_CHAN_WIDTH_160) {
+			he_chandef.center_freq1 =
+				ieee80211_channel_to_frequency(he_6ghz_oper->ccfs1,
+							       NL80211_BAND_6GHZ);
+		} else {
+			he_chandef.center_freq1 =
+				ieee80211_channel_to_frequency(he_6ghz_oper->ccfs0,
+							       NL80211_BAND_6GHZ);
+			if (support_80_80 || support_160)
+				he_chandef.center_freq2 =
+					ieee80211_channel_to_frequency(he_6ghz_oper->ccfs1,
+								       NL80211_BAND_6GHZ);
+		}
+	} else {
+		eht_phy_cap = eht_cap->eht_cap_elem.phy_cap_info[0];
+		support_320 =
+			eht_phy_cap & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
+
+		switch (u8_get_bits(eht_oper->chan_width,
+				    IEEE80211_EHT_OPER_CHAN_WIDTH)) {
+		case IEEE80211_EHT_OPER_CHAN_WIDTH_20MHZ:
+			he_chandef.width = NL80211_CHAN_WIDTH_20;
+			break;
+		case IEEE80211_EHT_OPER_CHAN_WIDTH_40MHZ:
+			he_chandef.width = NL80211_CHAN_WIDTH_40;
+			break;
+		case IEEE80211_EHT_OPER_CHAN_WIDTH_80MHZ:
+			he_chandef.width = NL80211_CHAN_WIDTH_80;
 			break;
-		if (abs(he_6ghz_oper->ccfs1 - he_6ghz_oper->ccfs0) == 8) {
+		case IEEE80211_EHT_OPER_CHAN_WIDTH_160MHZ:
 			if (support_160)
 				he_chandef.width = NL80211_CHAN_WIDTH_160;
-		} else {
-			if (support_80_80)
-				he_chandef.width = NL80211_CHAN_WIDTH_80P80;
+			else
+				he_chandef.width = NL80211_CHAN_WIDTH_80;
+			break;
+		case IEEE80211_EHT_OPER_CHAN_WIDTH_320MHZ:
+			if (support_320)
+				he_chandef.width = NL80211_CHAN_WIDTH_320;
+			else if (support_160)
+				he_chandef.width = NL80211_CHAN_WIDTH_160;
+			else
+				he_chandef.width = NL80211_CHAN_WIDTH_80;
+			break;
 		}
-		break;
-	}
 
-	if (he_chandef.width == NL80211_CHAN_WIDTH_160) {
-		he_chandef.center_freq1 =
-			ieee80211_channel_to_frequency(he_6ghz_oper->ccfs1,
-						       NL80211_BAND_6GHZ);
-	} else {
 		he_chandef.center_freq1 =
-			ieee80211_channel_to_frequency(he_6ghz_oper->ccfs0,
+			ieee80211_channel_to_frequency(eht_oper->ccfs,
 						       NL80211_BAND_6GHZ);
-		if (support_80_80 || support_160)
-			he_chandef.center_freq2 =
-				ieee80211_channel_to_frequency(he_6ghz_oper->ccfs1,
-							       NL80211_BAND_6GHZ);
 	}
 
 	if (!cfg80211_chandef_valid(&he_chandef)) {
@@ -3998,6 +4067,15 @@ u32 ieee80211_chandef_downgrade(struct cfg80211_chan_def *c)
 		ret = IEEE80211_STA_DISABLE_80P80MHZ |
 		      IEEE80211_STA_DISABLE_160MHZ;
 		break;
+	case NL80211_CHAN_WIDTH_320:
+		/* n_P20 */
+		tmp = (150 + c->chan->center_freq - c->center_freq1) / 20;
+		/* n_P160 */
+		tmp /= 80;
+		c->center_freq1 = c->center_freq1 - 80 + 160 * tmp;
+		c->width = NL80211_CHAN_WIDTH_160;
+		ret = IEEE80211_STA_DISABLE_320MHZ;
+		break;
 	default:
 	case NL80211_CHAN_WIDTH_20_NOHT:
 		WARN_ON_ONCE(1);
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index a45dacde96f7..904611d681cb 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -4,7 +4,7 @@
  *
  * Portions of this file
  * Copyright(c) 2015 - 2016 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2020 Intel Corporation
+ * Copyright (C) 2018 - 2021 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -445,6 +445,8 @@ ieee80211_chan_width_to_rx_bw(enum nl80211_chan_width width)
 	case NL80211_CHAN_WIDTH_160:
 	case NL80211_CHAN_WIDTH_80P80:
 		return IEEE80211_STA_RX_BW_160;
+	case NL80211_CHAN_WIDTH_320:
+		return IEEE80211_STA_RX_BW_320;
 	default:
 		WARN_ON_ONCE(1);
 		return IEEE80211_STA_RX_BW_20;
-- 
2.34.1

