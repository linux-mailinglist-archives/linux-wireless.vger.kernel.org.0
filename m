Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675D557333E
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbiGMJpu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbiGMJpQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8663DA7BF
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=jnpQEm8HJyetPw8vzkh3pT+9HqgkZ6syIeMeCwPgCuw=;
        t=1657705512; x=1658915112; b=AcFy6HyH6KSqOAm0FCteqJ5/q/l1OoHvA5R3c0DGfFqSy04
        mcljs7+EQPZ/APOYq3sHfifF982+p1fd2I9iMA3u8CFiRutgEzkdYfQjN+DyG5m/rX9nPRt5SRdVI
        GS88XbzkH1aTIWlOQDKOsfOOczSe2GS4uEX1JYzPfM5QemP0PX2JY9ev6e/E+8VrPTWB14K8xLN8X
        imCMG08lRrYz6DoGEReDMaQ5+7QKagS5hNixyqVLEX8JEDqt/1rSn2nuT8cUIHOoyNMBEabpkfqv+
        TcBbjz0AAvobbrEd5pO6+YLeEM09dn+mO1cGy933N+zqDXk2h/57sGukIAsjsASA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYve-00EgvB-NV;
        Wed, 13 Jul 2022 11:45:10 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 21/76] wifi: mac80211: separate out connection downgrade flags
Date:   Wed, 13 Jul 2022 11:44:07 +0200
Message-Id: <20220713114425.27b9a68f81cf.Ica2a53c7767df75b35fe44f978d7be96b6b6462d@changeid>
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

Separate out the connection downgrade flags from the ifmgd->flags
and put them into the link information instead. While at it, make
them a separate sparse type so we don't get confused about where
they belong and have static checking on correct handling.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ibss.c        |  13 +-
 net/mac80211/ieee80211_i.h |  38 +++--
 net/mac80211/mesh.c        |  12 +-
 net/mac80211/mlme.c        | 314 +++++++++++++++++++------------------
 net/mac80211/spectmgmt.c   |  16 +-
 net/mac80211/tdls.c        |   3 +-
 net/mac80211/util.c        |  34 ++--
 7 files changed, 221 insertions(+), 209 deletions(-)

diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 393c7595bfa4..561abcf4def9 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -770,20 +770,21 @@ ieee80211_ibss_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_ibss *ifibss = &sdata->u.ibss;
 	enum nl80211_channel_type ch_type;
 	int err;
-	u32 sta_flags;
+	ieee80211_conn_flags_t conn_flags;
 	u32 vht_cap_info = 0;
 
 	sdata_assert_lock(sdata);
 
-	sta_flags = IEEE80211_STA_DISABLE_VHT;
+	conn_flags = IEEE80211_CONN_DISABLE_VHT;
+
 	switch (ifibss->chandef.width) {
 	case NL80211_CHAN_WIDTH_5:
 	case NL80211_CHAN_WIDTH_10:
 	case NL80211_CHAN_WIDTH_20_NOHT:
-		sta_flags |= IEEE80211_STA_DISABLE_HT;
+		conn_flags |= IEEE80211_CONN_DISABLE_HT;
 		fallthrough;
 	case NL80211_CHAN_WIDTH_20:
-		sta_flags |= IEEE80211_STA_DISABLE_40MHZ;
+		conn_flags |= IEEE80211_CONN_DISABLE_40MHZ;
 		break;
 	default:
 		break;
@@ -796,7 +797,7 @@ ieee80211_ibss_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	err = ieee80211_parse_ch_switch_ie(sdata, elems,
 					   ifibss->chandef.chan->band,
 					   vht_cap_info,
-					   sta_flags, ifibss->bssid, &csa_ie);
+					   conn_flags, ifibss->bssid, &csa_ie);
 	/* can't switch to destination channel, fail */
 	if (err < 0)
 		goto disconnect;
@@ -839,7 +840,7 @@ ieee80211_ibss_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 		}
 		break;
 	default:
-		/* should not happen, sta_flags should prevent VHT modes. */
+		/* should not happen, conn_flags should prevent VHT modes. */
 		WARN_ON(1);
 		goto disconnect;
 	}
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index aa1e438ee61e..154ff50e99a0 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -358,20 +358,25 @@ struct ieee80211_roc_work {
 enum ieee80211_sta_flags {
 	IEEE80211_STA_CONNECTION_POLL	= BIT(1),
 	IEEE80211_STA_CONTROL_PORT	= BIT(2),
-	IEEE80211_STA_DISABLE_HT	= BIT(4),
 	IEEE80211_STA_MFP_ENABLED	= BIT(6),
 	IEEE80211_STA_UAPSD_ENABLED	= BIT(7),
 	IEEE80211_STA_NULLFUNC_ACKED	= BIT(8),
 	IEEE80211_STA_RESET_SIGNAL_AVE	= BIT(9),
-	IEEE80211_STA_DISABLE_40MHZ	= BIT(10),
-	IEEE80211_STA_DISABLE_VHT	= BIT(11),
-	IEEE80211_STA_DISABLE_80P80MHZ	= BIT(12),
-	IEEE80211_STA_DISABLE_160MHZ	= BIT(13),
 	IEEE80211_STA_DISABLE_WMM	= BIT(14),
 	IEEE80211_STA_ENABLE_RRM	= BIT(15),
-	IEEE80211_STA_DISABLE_HE	= BIT(16),
-	IEEE80211_STA_DISABLE_EHT	= BIT(17),
-	IEEE80211_STA_DISABLE_320MHZ	= BIT(18),
+};
+
+typedef u32 __bitwise ieee80211_conn_flags_t;
+
+enum ieee80211_conn_flags {
+	IEEE80211_CONN_DISABLE_HT	= (__force ieee80211_conn_flags_t)BIT(0),
+	IEEE80211_CONN_DISABLE_40MHZ	= (__force ieee80211_conn_flags_t)BIT(1),
+	IEEE80211_CONN_DISABLE_VHT	= (__force ieee80211_conn_flags_t)BIT(2),
+	IEEE80211_CONN_DISABLE_80P80MHZ	= (__force ieee80211_conn_flags_t)BIT(3),
+	IEEE80211_CONN_DISABLE_160MHZ	= (__force ieee80211_conn_flags_t)BIT(4),
+	IEEE80211_CONN_DISABLE_HE	= (__force ieee80211_conn_flags_t)BIT(5),
+	IEEE80211_CONN_DISABLE_EHT	= (__force ieee80211_conn_flags_t)BIT(6),
+	IEEE80211_CONN_DISABLE_320MHZ	= (__force ieee80211_conn_flags_t)BIT(7),
 };
 
 struct ieee80211_mgd_auth_data {
@@ -875,6 +880,8 @@ struct ieee80211_link_data_managed {
 	enum ieee80211_smps_mode req_smps, /* requested smps mode */
 				 driver_smps_mode; /* smps mode request */
 
+	ieee80211_conn_flags_t conn_flags;
+
 	s16 p2p_noa_index;
 
 	bool have_beacon;
@@ -2051,12 +2058,9 @@ void ieee80211_process_measurement_req(struct ieee80211_sub_if_data *sdata,
  * @elems: parsed 802.11 elements received with the frame
  * @current_band: indicates the current band
  * @vht_cap_info: VHT capabilities of the transmitter
- * @sta_flags: contains information about own capabilities and restrictions
- *	to decide which channel switch announcements can be accepted. Only the
- *	following subset of &enum ieee80211_sta_flags are evaluated:
- *	%IEEE80211_STA_DISABLE_HT, %IEEE80211_STA_DISABLE_VHT,
- *	%IEEE80211_STA_DISABLE_40MHZ, %IEEE80211_STA_DISABLE_80P80MHZ,
- *	%IEEE80211_STA_DISABLE_160MHZ.
+ * @conn_flags: contains information about own capabilities and restrictions
+ *	to decide which channel switch announcements can be accepted, using
+ *	flags from &enum ieee80211_conn_flags.
  * @bssid: the currently connected bssid (for reporting)
  * @csa_ie: parsed 802.11 csa elements on count, mode, chandef and mesh ttl.
 	All of them will be filled with if success only.
@@ -2066,7 +2070,7 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 				 struct ieee802_11_elems *elems,
 				 enum nl80211_band current_band,
 				 u32 vht_cap_info,
-				 u32 sta_flags, u8 *bssid,
+				 ieee80211_conn_flags_t conn_flags, u8 *bssid,
 				 struct ieee80211_csa_ie *csa_ie);
 
 /* Suspend/resume and hw reconfiguration */
@@ -2297,7 +2301,7 @@ u8 *ieee80211_ie_build_vht_cap(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 u8 *ieee80211_ie_build_vht_oper(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 				const struct cfg80211_chan_def *chandef);
 u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata, u8 iftype);
-u8 *ieee80211_ie_build_he_cap(u32 disable_flags, u8 *pos,
+u8 *ieee80211_ie_build_he_cap(ieee80211_conn_flags_t disable_flags, u8 *pos,
 			      const struct ieee80211_sta_he_cap *he_cap,
 			      u8 *end);
 void ieee80211_ie_build_he_6ghz_cap(struct ieee80211_sub_if_data *sdata,
@@ -2336,7 +2340,7 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 				    struct cfg80211_chan_def *chandef);
 bool ieee80211_chandef_s1g_oper(const struct ieee80211_s1g_oper_ie *oper,
 				struct cfg80211_chan_def *chandef);
-u32 ieee80211_chandef_downgrade(struct cfg80211_chan_def *c);
+ieee80211_conn_flags_t ieee80211_chandef_downgrade(struct cfg80211_chan_def *c);
 
 int __must_check
 ieee80211_link_use_channel(struct ieee80211_link_data *link,
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index ba4e0921fa5d..b656cb647763 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1129,7 +1129,8 @@ ieee80211_mesh_process_chnswitch(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
 	struct ieee80211_supported_band *sband;
 	int err;
-	u32 sta_flags, vht_cap_info = 0;
+	ieee80211_conn_flags_t conn_flags = 0;
+	u32 vht_cap_info = 0;
 
 	sdata_assert_lock(sdata);
 
@@ -1137,16 +1138,15 @@ ieee80211_mesh_process_chnswitch(struct ieee80211_sub_if_data *sdata,
 	if (!sband)
 		return false;
 
-	sta_flags = 0;
 	switch (sdata->vif.bss_conf.chandef.width) {
 	case NL80211_CHAN_WIDTH_20_NOHT:
-		sta_flags |= IEEE80211_STA_DISABLE_HT;
+		conn_flags |= IEEE80211_CONN_DISABLE_HT;
 		fallthrough;
 	case NL80211_CHAN_WIDTH_20:
-		sta_flags |= IEEE80211_STA_DISABLE_40MHZ;
+		conn_flags |= IEEE80211_CONN_DISABLE_40MHZ;
 		fallthrough;
 	case NL80211_CHAN_WIDTH_40:
-		sta_flags |= IEEE80211_STA_DISABLE_VHT;
+		conn_flags |= IEEE80211_CONN_DISABLE_VHT;
 		break;
 	default:
 		break;
@@ -1159,7 +1159,7 @@ ieee80211_mesh_process_chnswitch(struct ieee80211_sub_if_data *sdata,
 	memset(&params, 0, sizeof(params));
 	err = ieee80211_parse_ch_switch_ie(sdata, elems, sband->band,
 					   vht_cap_info,
-					   sta_flags, sdata->vif.addr,
+					   conn_flags, sdata->vif.addr,
 					   &csa_ie);
 	if (err < 0)
 		return false;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 74676bbd6e23..5a208a01e278 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -142,7 +142,7 @@ static int ecw2cw(int ecw)
 	return (1 << ecw) - 1;
 }
 
-static u32
+static ieee80211_conn_flags_t
 ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 			     struct ieee80211_supported_band *sband,
 			     struct ieee80211_channel *channel,
@@ -154,10 +154,10 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 			     const struct ieee80211_s1g_oper_ie *s1g_oper,
 			     struct cfg80211_chan_def *chandef, bool tracking)
 {
-	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct cfg80211_chan_def vht_chandef;
 	struct ieee80211_sta_ht_cap sta_ht_cap;
-	u32 ht_cfreq, ret;
+	ieee80211_conn_flags_t ret;
+	u32 ht_cfreq;
 
 	memset(chandef, 0, sizeof(struct cfg80211_chan_def));
 	chandef->chan = channel;
@@ -170,10 +170,10 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 						    chandef)) {
 			mlme_dbg(sdata,
 				 "bad 6 GHz operation, disabling HT/VHT/HE/EHT\n");
-			ret = IEEE80211_STA_DISABLE_HT |
-			      IEEE80211_STA_DISABLE_VHT |
-			      IEEE80211_STA_DISABLE_HE |
-			      IEEE80211_STA_DISABLE_EHT;
+			ret = IEEE80211_CONN_DISABLE_HT |
+			      IEEE80211_CONN_DISABLE_VHT |
+			      IEEE80211_CONN_DISABLE_HE |
+			      IEEE80211_CONN_DISABLE_EHT;
 		} else {
 			ret = 0;
 		}
@@ -186,10 +186,10 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 			chandef->width = ieee80211_s1g_channel_width(channel);
 		}
 
-		ret = IEEE80211_STA_DISABLE_HT | IEEE80211_STA_DISABLE_40MHZ |
-		      IEEE80211_STA_DISABLE_VHT |
-		      IEEE80211_STA_DISABLE_80P80MHZ |
-		      IEEE80211_STA_DISABLE_160MHZ;
+		ret = IEEE80211_CONN_DISABLE_HT | IEEE80211_CONN_DISABLE_40MHZ |
+		      IEEE80211_CONN_DISABLE_VHT |
+		      IEEE80211_CONN_DISABLE_80P80MHZ |
+		      IEEE80211_CONN_DISABLE_160MHZ;
 		goto out;
 	}
 
@@ -198,10 +198,10 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 
 	if (!ht_oper || !sta_ht_cap.ht_supported) {
 		mlme_dbg(sdata, "HT operation missing / HT not supported\n");
-		ret = IEEE80211_STA_DISABLE_HT |
-		      IEEE80211_STA_DISABLE_VHT |
-		      IEEE80211_STA_DISABLE_HE |
-		      IEEE80211_STA_DISABLE_EHT;
+		ret = IEEE80211_CONN_DISABLE_HT |
+		      IEEE80211_CONN_DISABLE_VHT |
+		      IEEE80211_CONN_DISABLE_HE |
+		      IEEE80211_CONN_DISABLE_EHT;
 		goto out;
 	}
 
@@ -222,10 +222,10 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 			   "Wrong control channel: center-freq: %d ht-cfreq: %d ht->primary_chan: %d band: %d - Disabling HT\n",
 			   channel->center_freq, ht_cfreq,
 			   ht_oper->primary_chan, channel->band);
-		ret = IEEE80211_STA_DISABLE_HT |
-		      IEEE80211_STA_DISABLE_VHT |
-		      IEEE80211_STA_DISABLE_HE |
-		      IEEE80211_STA_DISABLE_EHT;
+		ret = IEEE80211_CONN_DISABLE_HT |
+		      IEEE80211_CONN_DISABLE_VHT |
+		      IEEE80211_CONN_DISABLE_HE |
+		      IEEE80211_CONN_DISABLE_EHT;
 		goto out;
 	}
 
@@ -235,20 +235,21 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	} else {
 		mlme_dbg(sdata, "40 MHz not supported\n");
 		/* 40 MHz (and 80 MHz) must be supported for VHT */
-		ret = IEEE80211_STA_DISABLE_VHT;
+		ret = IEEE80211_CONN_DISABLE_VHT;
 		/* also mark 40 MHz disabled */
-		ret |= IEEE80211_STA_DISABLE_40MHZ;
+		ret |= IEEE80211_CONN_DISABLE_40MHZ;
 		goto out;
 	}
 
 	if (!vht_oper || !sband->vht_cap.vht_supported) {
 		mlme_dbg(sdata, "VHT operation missing / VHT not supported\n");
-		ret = IEEE80211_STA_DISABLE_VHT;
+		ret = IEEE80211_CONN_DISABLE_VHT;
 		goto out;
 	}
 
 	vht_chandef = *chandef;
-	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE) && he_oper &&
+	if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
+	    he_oper &&
 	    (le32_to_cpu(he_oper->he_oper_params) &
 	     IEEE80211_HE_OPERATION_VHT_OPER_INFO)) {
 		struct ieee80211_vht_operation he_oper_vht_cap;
@@ -263,28 +264,28 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 		if (!ieee80211_chandef_vht_oper(&sdata->local->hw, vht_cap_info,
 						&he_oper_vht_cap, ht_oper,
 						&vht_chandef)) {
-			if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE))
+			if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE))
 				sdata_info(sdata,
 					   "HE AP VHT information is invalid, disabling HE\n");
-			ret = IEEE80211_STA_DISABLE_HE | IEEE80211_STA_DISABLE_EHT;
+			ret = IEEE80211_CONN_DISABLE_HE | IEEE80211_CONN_DISABLE_EHT;
 			goto out;
 		}
 	} else if (!ieee80211_chandef_vht_oper(&sdata->local->hw,
 					       vht_cap_info,
 					       vht_oper, ht_oper,
 					       &vht_chandef)) {
-		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
+		if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
 			sdata_info(sdata,
 				   "AP VHT information is invalid, disabling VHT\n");
-		ret = IEEE80211_STA_DISABLE_VHT;
+		ret = IEEE80211_CONN_DISABLE_VHT;
 		goto out;
 	}
 
 	if (!cfg80211_chandef_valid(&vht_chandef)) {
-		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
+		if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
 			sdata_info(sdata,
 				   "AP VHT information is invalid, disabling VHT\n");
-		ret = IEEE80211_STA_DISABLE_VHT;
+		ret = IEEE80211_CONN_DISABLE_VHT;
 		goto out;
 	}
 
@@ -294,10 +295,10 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (!cfg80211_chandef_compatible(chandef, &vht_chandef)) {
-		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
+		if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
 			sdata_info(sdata,
 				   "AP VHT information doesn't match HT, disabling VHT\n");
-		ret = IEEE80211_STA_DISABLE_VHT;
+		ret = IEEE80211_CONN_DISABLE_VHT;
 		goto out;
 	}
 
@@ -317,18 +318,18 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 					   false, &eht_chandef);
 
 		if (!cfg80211_chandef_valid(&eht_chandef)) {
-			if (!(ifmgd->flags & IEEE80211_STA_DISABLE_EHT))
+			if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT))
 				sdata_info(sdata,
 					   "AP EHT information is invalid, disabling EHT\n");
-			ret = IEEE80211_STA_DISABLE_EHT;
+			ret = IEEE80211_CONN_DISABLE_EHT;
 			goto out;
 		}
 
 		if (!cfg80211_chandef_compatible(chandef, &eht_chandef)) {
-			if (!(ifmgd->flags & IEEE80211_STA_DISABLE_EHT))
+			if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT))
 				sdata_info(sdata,
 					   "AP EHT information is incompatible, disabling EHT\n");
-			ret = IEEE80211_STA_DISABLE_EHT;
+			ret = IEEE80211_CONN_DISABLE_EHT;
 			goto out;
 		}
 
@@ -361,7 +362,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 		return ret;
 
 	/* don't print the message below for VHT mismatch if VHT is disabled */
-	if (ret & IEEE80211_STA_DISABLE_VHT)
+	if (ret & IEEE80211_CONN_DISABLE_VHT)
 		vht_chandef = *chandef;
 
 	/*
@@ -376,10 +377,10 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 					tracking ? 0 :
 						   IEEE80211_CHAN_DISABLED)) {
 		if (WARN_ON(chandef->width == NL80211_CHAN_WIDTH_20_NOHT)) {
-			ret = IEEE80211_STA_DISABLE_HT |
-			      IEEE80211_STA_DISABLE_VHT |
-			      IEEE80211_STA_DISABLE_HE |
-			      IEEE80211_STA_DISABLE_EHT;
+			ret = IEEE80211_CONN_DISABLE_HT |
+			      IEEE80211_CONN_DISABLE_VHT |
+			      IEEE80211_CONN_DISABLE_HE |
+			      IEEE80211_CONN_DISABLE_EHT;
 			break;
 		}
 
@@ -388,11 +389,11 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 
 	if (!he_oper || !cfg80211_chandef_usable(sdata->wdev.wiphy, chandef,
 						 IEEE80211_CHAN_NO_HE))
-		ret |= IEEE80211_STA_DISABLE_HE | IEEE80211_STA_DISABLE_EHT;
+		ret |= IEEE80211_CONN_DISABLE_HE | IEEE80211_CONN_DISABLE_EHT;
 
 	if (!eht_oper || !cfg80211_chandef_usable(sdata->wdev.wiphy, chandef,
 						  IEEE80211_CHAN_NO_EHT))
-		ret |= IEEE80211_STA_DISABLE_EHT;
+		ret |= IEEE80211_CONN_DISABLE_EHT;
 
 	if (chandef->width != vht_chandef.width && !tracking)
 		sdata_info(sdata,
@@ -420,20 +421,20 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 		local->hw.wiphy->bands[chan->band];
 	struct cfg80211_chan_def chandef;
 	u16 ht_opmode;
-	u32 flags;
+	ieee80211_conn_flags_t flags;
 	u32 vht_cap_info = 0;
 	int ret;
 
 	/* if HT was/is disabled, don't track any bandwidth changes */
-	if (ifmgd->flags & IEEE80211_STA_DISABLE_HT || !ht_oper)
+	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT || !ht_oper)
 		return 0;
 
 	/* don't check VHT if we associated as non-VHT station */
-	if (ifmgd->flags & IEEE80211_STA_DISABLE_VHT)
+	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)
 		vht_oper = NULL;
 
 	/* don't check HE if we associated as non-HE station */
-	if (ifmgd->flags & IEEE80211_STA_DISABLE_HE ||
+	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE ||
 	    !ieee80211_get_he_iftype_cap(sband,
 					 ieee80211_vif_type_p2p(&sdata->vif))) {
 		he_oper = NULL;
@@ -441,7 +442,7 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 	}
 
 	/* don't check EHT if we associated as non-EHT station */
-	if (ifmgd->flags & IEEE80211_STA_DISABLE_EHT ||
+	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT ||
 	    !ieee80211_get_eht_iftype_cap(sband,
 					 ieee80211_vif_type_p2p(&sdata->vif)))
 		eht_oper = NULL;
@@ -475,13 +476,13 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 	 * reasons) then switching to a 40 MHz channel now won't do us
 	 * any good -- we couldn't use it with the AP.
 	 */
-	if (ifmgd->flags & IEEE80211_STA_DISABLE_80P80MHZ &&
+	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_80P80MHZ &&
 	    chandef.width == NL80211_CHAN_WIDTH_80P80)
 		flags |= ieee80211_chandef_downgrade(&chandef);
-	if (ifmgd->flags & IEEE80211_STA_DISABLE_160MHZ &&
+	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_160MHZ &&
 	    chandef.width == NL80211_CHAN_WIDTH_160)
 		flags |= ieee80211_chandef_downgrade(&chandef);
-	if (ifmgd->flags & IEEE80211_STA_DISABLE_40MHZ &&
+	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_40MHZ &&
 	    chandef.width > NL80211_CHAN_WIDTH_20)
 		flags |= ieee80211_chandef_downgrade(&chandef);
 
@@ -496,14 +497,15 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 		   chandef.center_freq1, chandef.freq1_offset,
 		   chandef.center_freq2);
 
-	if (flags != (ifmgd->flags & (IEEE80211_STA_DISABLE_HT |
-				      IEEE80211_STA_DISABLE_VHT |
-				      IEEE80211_STA_DISABLE_HE |
-				      IEEE80211_STA_DISABLE_EHT |
-				      IEEE80211_STA_DISABLE_40MHZ |
-				      IEEE80211_STA_DISABLE_80P80MHZ |
-				      IEEE80211_STA_DISABLE_160MHZ |
-				      IEEE80211_STA_DISABLE_320MHZ)) ||
+	if (flags != (sdata->deflink.u.mgd.conn_flags &
+				(IEEE80211_CONN_DISABLE_HT |
+				 IEEE80211_CONN_DISABLE_VHT |
+				 IEEE80211_CONN_DISABLE_HE |
+				 IEEE80211_CONN_DISABLE_EHT |
+				 IEEE80211_CONN_DISABLE_40MHZ |
+				 IEEE80211_CONN_DISABLE_80P80MHZ |
+				 IEEE80211_CONN_DISABLE_160MHZ |
+				 IEEE80211_CONN_DISABLE_320MHZ)) ||
 	    !cfg80211_chandef_valid(&chandef)) {
 		sdata_info(sdata,
 			   "AP %pM changed caps/bw in a way we can't support (0x%x/0x%x) - disconnect\n",
@@ -564,7 +566,7 @@ static void ieee80211_add_ht_ie(struct ieee80211_sub_if_data *sdata,
 	 * capable of 40 MHz -- some broken APs will never fall
 	 * back to trying to transmit in 20 MHz.
 	 */
-	if (sdata->u.mgd.flags & IEEE80211_STA_DISABLE_40MHZ) {
+	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_40MHZ) {
 		cap &= ~IEEE80211_HT_CAP_SUP_WIDTH_20_40;
 		cap &= ~IEEE80211_HT_CAP_SGI_40;
 	}
@@ -618,7 +620,7 @@ static void ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 	/* determine capability flags */
 	cap = vht_cap.cap;
 
-	if (sdata->u.mgd.flags & IEEE80211_STA_DISABLE_80P80MHZ) {
+	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_80P80MHZ) {
 		u32 bw = cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
 
 		cap &= ~IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
@@ -627,7 +629,7 @@ static void ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 			cap |= IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ;
 	}
 
-	if (sdata->u.mgd.flags & IEEE80211_STA_DISABLE_160MHZ) {
+	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_160MHZ) {
 		cap &= ~IEEE80211_VHT_CAP_SHORT_GI_160;
 		cap &= ~IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
 	}
@@ -717,7 +719,7 @@ static void ieee80211_add_he_ie(struct ieee80211_sub_if_data *sdata,
 				      he_cap->he_cap_elem.phy_cap_info);
 	pos = skb_put(skb, he_cap_size);
 	pre_he_pos = pos;
-	pos = ieee80211_ie_build_he_cap(sdata->u.mgd.flags,
+	pos = ieee80211_ie_build_he_cap(sdata->deflink.u.mgd.conn_flags,
 					pos, he_cap, pos + he_cap_size);
 	/* trim excess if any */
 	skb_trim(skb, skb->len - (pre_he_pos + he_cap_size - pos));
@@ -977,7 +979,7 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 
 	/* Set MBSSID support for HE AP if needed */
 	if (ieee80211_hw_check(&local->hw, SUPPORTS_ONLY_HE_MULTI_BSSID) &&
-	    !(ifmgd->flags & IEEE80211_STA_DISABLE_HE) && assoc_data->ie_len &&
+	    !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) && assoc_data->ie_len &&
 	    ext_capa && ext_capa->datalen >= 3)
 		ext_capa->data[2] |= WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT;
 
@@ -1022,12 +1024,12 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 		offset = noffset;
 	}
 
-	if (WARN_ON_ONCE((ifmgd->flags & IEEE80211_STA_DISABLE_HT) &&
-			 !(ifmgd->flags & IEEE80211_STA_DISABLE_VHT)))
-		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
+	if (WARN_ON_ONCE((sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT) &&
+			 !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)))
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
 
 	if (sband->band != NL80211_BAND_6GHZ &&
-	    !(ifmgd->flags & IEEE80211_STA_DISABLE_HT))
+	    !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT))
 		ieee80211_add_ht_ie(sdata, skb, assoc_data->ap_ht_param,
 				    sband, chan, sdata->deflink.smps_mode);
 
@@ -1082,7 +1084,7 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	}
 
 	if (sband->band != NL80211_BAND_6GHZ &&
-	    !(ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
+	    !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
 		ieee80211_add_vht_ie(sdata, skb, sband,
 				     &assoc_data->ap_vht_cap);
 
@@ -1090,16 +1092,16 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	 * If AP doesn't support HT, mark HE and EHT as disabled.
 	 * If on the 5GHz band, make sure it supports VHT.
 	 */
-	if (ifmgd->flags & IEEE80211_STA_DISABLE_HT ||
+	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT ||
 	    (sband->band == NL80211_BAND_5GHZ &&
-	     ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
-		ifmgd->flags |= IEEE80211_STA_DISABLE_HE |
-			        IEEE80211_STA_DISABLE_EHT;
+	     sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE |
+						   IEEE80211_CONN_DISABLE_EHT;
 
-	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE)) {
+	if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE)) {
 		ieee80211_add_he_ie(sdata, skb, sband);
 
-		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_EHT))
+		if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT))
 			ieee80211_add_eht_ie(sdata, skb, sband);
 	}
 
@@ -1430,7 +1432,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	bss = (void *)cbss->priv;
 	res = ieee80211_parse_ch_switch_ie(sdata, elems, current_band,
 					   bss->vht_cap_info,
-					   ifmgd->flags,
+					   sdata->deflink.u.mgd.conn_flags,
 					   sdata->deflink.u.mgd.bssid, &csa_ie);
 
 	if (!res) {
@@ -2517,6 +2519,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	sdata->deflink.u.mgd.have_beacon = false;
 
 	ifmgd->flags = 0;
+	sdata->deflink.u.mgd.conn_flags = 0;
 	mutex_lock(&local->mtx);
 	ieee80211_link_release_channel(&sdata->deflink);
 
@@ -2958,6 +2961,7 @@ static void ieee80211_destroy_auth_data(struct ieee80211_sub_if_data *sdata,
 		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
 						  BSS_CHANGED_BSSID);
 		sdata->u.mgd.flags = 0;
+		sdata->deflink.u.mgd.conn_flags = 0;
 		mutex_lock(&sdata->local->mtx);
 		ieee80211_link_release_channel(&sdata->deflink);
 		mutex_unlock(&sdata->local->mtx);
@@ -2988,6 +2992,7 @@ static void ieee80211_destroy_assoc_data(struct ieee80211_sub_if_data *sdata,
 		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
 						  BSS_CHANGED_BSSID);
 		sdata->u.mgd.flags = 0;
+		sdata->deflink.u.mgd.conn_flags = 0;
 		sdata->vif.bss_conf.mu_mimo_owner = false;
 
 		mutex_lock(&sdata->local->mtx);
@@ -3479,9 +3484,9 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	 */
 	if (!is_6ghz &&
 	    ((assoc_data->wmm && !elems->wmm_param) ||
-	     (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT) &&
+	     (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT) &&
 	      (!elems->ht_cap_elem || !elems->ht_operation)) ||
-	     (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT) &&
+	     (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT) &&
 	      (!elems->vht_cap_elem || !elems->vht_operation)))) {
 		const struct cfg80211_bss_ies *ies;
 		struct ieee802_11_elems *bss_elems;
@@ -3517,25 +3522,25 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		 * have to include the IEs in the (re)association response.
 		 */
 		if (!elems->ht_cap_elem && bss_elems->ht_cap_elem &&
-		    !(ifmgd->flags & IEEE80211_STA_DISABLE_HT)) {
+		    !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT)) {
 			elems->ht_cap_elem = bss_elems->ht_cap_elem;
 			sdata_info(sdata,
 				   "AP bug: HT capability missing from AssocResp\n");
 		}
 		if (!elems->ht_operation && bss_elems->ht_operation &&
-		    !(ifmgd->flags & IEEE80211_STA_DISABLE_HT)) {
+		    !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT)) {
 			elems->ht_operation = bss_elems->ht_operation;
 			sdata_info(sdata,
 				   "AP bug: HT operation missing from AssocResp\n");
 		}
 		if (!elems->vht_cap_elem && bss_elems->vht_cap_elem &&
-		    !(ifmgd->flags & IEEE80211_STA_DISABLE_VHT)) {
+		    !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)) {
 			elems->vht_cap_elem = bss_elems->vht_cap_elem;
 			sdata_info(sdata,
 				   "AP bug: VHT capa missing from AssocResp\n");
 		}
 		if (!elems->vht_operation && bss_elems->vht_operation &&
-		    !(ifmgd->flags & IEEE80211_STA_DISABLE_VHT)) {
+		    !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)) {
 			elems->vht_operation = bss_elems->vht_operation;
 			sdata_info(sdata,
 				   "AP bug: VHT operation missing from AssocResp\n");
@@ -3548,7 +3553,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	 * We previously checked these in the beacon/probe response, so
 	 * they should be present here. This is just a safety net.
 	 */
-	if (!is_6ghz && !(ifmgd->flags & IEEE80211_STA_DISABLE_HT) &&
+	if (!is_6ghz && !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT) &&
 	    (!elems->wmm_param || !elems->ht_cap_elem || !elems->ht_operation)) {
 		sdata_info(sdata,
 			   "HT AP is missing WMM params or HT capability/operation\n");
@@ -3556,7 +3561,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		goto out;
 	}
 
-	if (!is_6ghz && !(ifmgd->flags & IEEE80211_STA_DISABLE_VHT) &&
+	if (!is_6ghz && !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT) &&
 	    (!elems->vht_cap_elem || !elems->vht_operation)) {
 		sdata_info(sdata,
 			   "VHT AP is missing VHT capability/operation\n");
@@ -3564,7 +3569,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		goto out;
 	}
 
-	if (is_6ghz && !(ifmgd->flags & IEEE80211_STA_DISABLE_HE) &&
+	if (is_6ghz && !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
 	    !elems->he_6ghz_capa) {
 		sdata_info(sdata,
 			   "HE 6 GHz AP is missing HE 6 GHz band capability\n");
@@ -3591,7 +3596,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		goto out;
 	}
 
-	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE) &&
+	if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
 	    (!elems->he_cap || !elems->he_operation)) {
 		mutex_unlock(&sdata->local->sta_mtx);
 		sdata_info(sdata,
@@ -3601,17 +3606,17 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	}
 
 	/* Set up internal HT/VHT capabilities */
-	if (elems->ht_cap_elem && !(ifmgd->flags & IEEE80211_STA_DISABLE_HT))
+	if (elems->ht_cap_elem && !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT))
 		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
 						  elems->ht_cap_elem,
 						  &sta->deflink);
 
-	if (elems->vht_cap_elem && !(ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
+	if (elems->vht_cap_elem && !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
 		ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
 						    elems->vht_cap_elem,
 						    &sta->deflink);
 
-	if (elems->he_operation && !(ifmgd->flags & IEEE80211_STA_DISABLE_HE) &&
+	if (elems->he_operation && !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
 	    elems->he_cap) {
 		ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband,
 						  elems->he_cap,
@@ -3631,7 +3636,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		changed |= ieee80211_recalc_twt_req(sdata, sta, elems);
 
 		if (elems->eht_operation && elems->eht_cap &&
-		    !(ifmgd->flags & IEEE80211_STA_DISABLE_EHT)) {
+		    !(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT)) {
 			ieee80211_eht_cap_ie_to_sta_eht_cap(sdata, sband,
 							    elems->he_cap,
 							    elems->he_cap_len,
@@ -5040,6 +5045,7 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 	ifmgd->uapsd_queues = sdata->local->hw.uapsd_queues;
 	ifmgd->uapsd_max_sp_len = sdata->local->hw.uapsd_max_sp_len;
 	sdata->deflink.u.mgd.p2p_noa_index = -1;
+	sdata->deflink.u.mgd.conn_flags = 0;
 
 	if (sdata->local->hw.wiphy->features & NL80211_FEATURE_DYNAMIC_SMPS)
 		sdata->deflink.u.mgd.req_smps = IEEE80211_SMPS_AUTOMATIC;
@@ -5070,7 +5076,6 @@ static u8 ieee80211_max_rx_chains(struct ieee80211_sub_if_data *sdata,
 				  struct cfg80211_bss *cbss)
 {
 	struct ieee80211_he_mcs_nss_supp *he_mcs_nss_supp;
-	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	const struct element *ht_cap_elem, *vht_cap_elem;
 	const struct cfg80211_bss_ies *ies;
 	const struct ieee80211_ht_cap *ht_cap;
@@ -5082,7 +5087,7 @@ static u8 ieee80211_max_rx_chains(struct ieee80211_sub_if_data *sdata,
 	bool support_160;
 	u8 chains = 1;
 
-	if (ifmgd->flags & IEEE80211_STA_DISABLE_HT)
+	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT)
 		return chains;
 
 	ht_cap_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_HT_CAPABILITY);
@@ -5095,7 +5100,7 @@ static u8 ieee80211_max_rx_chains(struct ieee80211_sub_if_data *sdata,
 		 */
 	}
 
-	if (ifmgd->flags & IEEE80211_STA_DISABLE_VHT)
+	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)
 		return chains;
 
 	vht_cap_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_VHT_CAPABILITY);
@@ -5114,7 +5119,7 @@ static u8 ieee80211_max_rx_chains(struct ieee80211_sub_if_data *sdata,
 		chains = max(chains, nss);
 	}
 
-	if (ifmgd->flags & IEEE80211_STA_DISABLE_HE)
+	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE)
 		return chains;
 
 	ies = rcu_dereference(cbss->ies);
@@ -5339,7 +5344,6 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 				  struct cfg80211_bss *cbss)
 {
 	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	const struct ieee80211_ht_cap *ht_cap = NULL;
 	const struct ieee80211_ht_operation *ht_oper = NULL;
 	const struct ieee80211_vht_operation *vht_oper = NULL;
@@ -5369,70 +5373,70 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 
 	sband = local->hw.wiphy->bands[cbss->channel->band];
 
-	ifmgd->flags &= ~(IEEE80211_STA_DISABLE_40MHZ |
-			  IEEE80211_STA_DISABLE_80P80MHZ |
-			  IEEE80211_STA_DISABLE_160MHZ);
+	sdata->deflink.u.mgd.conn_flags &= ~(IEEE80211_CONN_DISABLE_40MHZ |
+					     IEEE80211_CONN_DISABLE_80P80MHZ |
+					     IEEE80211_CONN_DISABLE_160MHZ);
 
 	/* disable HT/VHT/HE if we don't support them */
 	if (!sband->ht_cap.ht_supported && !is_6ghz) {
 		mlme_dbg(sdata, "HT not supported, disabling HT/VHT/HE/EHT\n");
-		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
-		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
-		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
-		ifmgd->flags |= IEEE80211_STA_DISABLE_EHT;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 	}
 
 	if (!sband->vht_cap.vht_supported && is_5ghz) {
 		mlme_dbg(sdata, "VHT not supported, disabling VHT/HE/EHT\n");
-		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
-		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
-		ifmgd->flags |= IEEE80211_STA_DISABLE_EHT;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 	}
 
 	if (!ieee80211_get_he_iftype_cap(sband,
 					 ieee80211_vif_type_p2p(&sdata->vif))) {
 		mlme_dbg(sdata, "HE not supported, disabling HE and EHT\n");
-		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
-		ifmgd->flags |= IEEE80211_STA_DISABLE_EHT;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 	}
 
 	if (!ieee80211_get_eht_iftype_cap(sband,
 					  ieee80211_vif_type_p2p(&sdata->vif))) {
 		mlme_dbg(sdata, "EHT not supported, disabling EHT\n");
-		ifmgd->flags |= IEEE80211_STA_DISABLE_EHT;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 	}
 
-	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT) && !is_6ghz) {
+	if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT) && !is_6ghz) {
 		ht_oper = elems->ht_operation;
 		ht_cap = elems->ht_cap_elem;
 
 		if (!ht_cap) {
-			ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
+			sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
 			ht_oper = NULL;
 		}
 	}
 
-	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT) && !is_6ghz) {
+	if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT) && !is_6ghz) {
 		vht_oper = elems->vht_operation;
 		if (vht_oper && !ht_oper) {
 			vht_oper = NULL;
 			sdata_info(sdata,
 				   "AP advertised VHT without HT, disabling HT/VHT/HE\n");
-			ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
-			ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
-			ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
-			ifmgd->flags |= IEEE80211_STA_DISABLE_EHT;
+			sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
+			sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+			sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
+			sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 		}
 
 		if (!elems->vht_cap_elem) {
 			sdata_info(sdata,
 				   "bad VHT capabilities, disabling VHT\n");
-			ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
+			sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
 			vht_oper = NULL;
 		}
 	}
 
-	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE)) {
+	if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE)) {
 		he_oper = elems->he_operation;
 
 		if (is_6ghz) {
@@ -5461,8 +5465,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 
 		if (!ieee80211_verify_peer_he_mcs_support(sdata, ies, he_oper) ||
 		    !ieee80211_verify_sta_he_mcs_support(sdata, sband, he_oper))
-			ifmgd->flags |= IEEE80211_STA_DISABLE_HE |
-				        IEEE80211_STA_DISABLE_EHT;
+			sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE |
+							   IEEE80211_CONN_DISABLE_EHT;
 	}
 
 	/*
@@ -5471,8 +5475,10 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	 * both the 6 GHz operation information (from the HE operation IE) and
 	 * EHT operation.
 	 */
-	if (!(ifmgd->flags & (IEEE80211_STA_DISABLE_HE |
-			      IEEE80211_STA_DISABLE_EHT)) && he_oper) {
+	if (!(sdata->deflink.u.mgd.conn_flags &
+			(IEEE80211_CONN_DISABLE_HE |
+			 IEEE80211_CONN_DISABLE_EHT)) &&
+	    he_oper) {
 		const struct cfg80211_bss_ies *ies;
 		const u8 *eht_oper_ie;
 
@@ -5499,7 +5505,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 
 	if (!have_80mhz) {
 		sdata_info(sdata, "80 MHz not supported, disabling VHT\n");
-		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
 	}
 
 	if (sband->band == NL80211_BAND_S1GHZ) {
@@ -5509,13 +5515,14 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 				   "AP missing S1G operation element?\n");
 	}
 
-	ifmgd->flags |= ieee80211_determine_chantype(sdata, sband,
-						     cbss->channel,
-						     bss->vht_cap_info,
-						     ht_oper, vht_oper,
-						     he_oper, eht_oper,
-						     s1g_oper,
-						     &chandef, false);
+	sdata->deflink.u.mgd.conn_flags |=
+		ieee80211_determine_chantype(sdata, sband,
+					     cbss->channel,
+					     bss->vht_cap_info,
+					     ht_oper, vht_oper,
+					     he_oper, eht_oper,
+					     s1g_oper,
+					     &chandef, false);
 
 	sdata->deflink.needed_rx_chains =
 		min(ieee80211_max_rx_chains(sdata, cbss), local->rx_chains);
@@ -5525,7 +5532,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	kfree(elems);
 	elems = NULL;
 
-	if (ifmgd->flags & IEEE80211_STA_DISABLE_HE && is_6ghz) {
+	if (sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE && is_6ghz) {
 		sdata_info(sdata, "Rejecting non-HE 6/7 GHz connection");
 		return -EINVAL;
 	}
@@ -5548,7 +5555,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		goto out;
 
 	while (ret && chandef.width != NL80211_CHAN_WIDTH_20_NOHT) {
-		ifmgd->flags |= ieee80211_chandef_downgrade(&chandef);
+		sdata->deflink.u.mgd.conn_flags |=
+			ieee80211_chandef_downgrade(&chandef);
 		ret = ieee80211_link_use_channel(&sdata->deflink, &chandef,
 						 IEEE80211_CHANCTX_SHARED);
 	}
@@ -6004,10 +6012,10 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		if (req->crypto.ciphers_pairwise[i] == WLAN_CIPHER_SUITE_WEP40 ||
 		    req->crypto.ciphers_pairwise[i] == WLAN_CIPHER_SUITE_TKIP ||
 		    req->crypto.ciphers_pairwise[i] == WLAN_CIPHER_SUITE_WEP104) {
-			ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
-			ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
-			ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
-			ifmgd->flags |= IEEE80211_STA_DISABLE_EHT;
+			sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
+			sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+			sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
+			sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 			netdev_info(sdata->dev,
 				    "disabling HT/VHT/HE due to WEP/TKIP use\n");
 		}
@@ -6017,10 +6025,10 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 
 	/* also disable HT/VHT/HE/EHT if the AP doesn't use WMM */
 	if (!bss->wmm_used) {
-		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
-		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
-		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
-		ifmgd->flags |= IEEE80211_STA_DISABLE_EHT;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 		netdev_info(sdata->dev,
 			    "disabling HT/VHT/HE as WMM/QoS is not supported by the AP\n");
 	}
@@ -6068,7 +6076,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		assoc_data->ap_ht_param =
 			((struct ieee80211_ht_operation *)(ht_elem->data))->ht_param;
 	else if (!is_6ghz)
-		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
 	vht_elem = ieee80211_bss_get_elem(req->bss, WLAN_EID_VHT_CAPABILITY);
 	if (vht_elem && vht_elem->datalen >= sizeof(struct ieee80211_vht_cap)) {
 		memcpy(&assoc_data->ap_vht_cap, vht_elem->data,
@@ -6076,9 +6084,9 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	} else if (is_5ghz) {
 		sdata_info(sdata,
 			   "VHT capa missing/short, disabling VHT/HE/EHT\n");
-		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT |
-				IEEE80211_STA_DISABLE_HE |
-				IEEE80211_STA_DISABLE_EHT;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT |
+				IEEE80211_CONN_DISABLE_HE |
+				IEEE80211_CONN_DISABLE_EHT;
 	}
 	rcu_read_unlock();
 
@@ -6130,7 +6138,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	sdata->deflink.u.mgd.have_beacon = false;
 
 	/* override HT/VHT configuration only if the AP and we support it */
-	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT)) {
+	if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT)) {
 		struct ieee80211_sta_ht_cap sta_ht_cap;
 
 		if (req->flags & ASSOC_REQ_DISABLE_HT)
@@ -6140,37 +6148,37 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);
 
 		/* check for 40 MHz disable override */
-		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_40MHZ) &&
+		if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_40MHZ) &&
 		    sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
 		    !(sta_ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40))
 			override = true;
 
-		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT) &&
+		if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT) &&
 		    req->flags & ASSOC_REQ_DISABLE_VHT)
 			override = true;
 	}
 
 	if (req->flags & ASSOC_REQ_DISABLE_HT) {
 		mlme_dbg(sdata, "HT disabled by flag, disabling HT/VHT/HE\n");
-		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
-		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
-		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
-		ifmgd->flags |= IEEE80211_STA_DISABLE_EHT;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 	}
 
 	if (req->flags & ASSOC_REQ_DISABLE_VHT) {
 		mlme_dbg(sdata, "VHT disabled by flag, disabling VHT\n");
-		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
 	}
 
 	if (req->flags & ASSOC_REQ_DISABLE_HE) {
 		mlme_dbg(sdata, "HE disabled by flag, disabling HE/EHT\n");
-		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
-		ifmgd->flags |= IEEE80211_STA_DISABLE_EHT;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 	}
 
 	if (req->flags & ASSOC_REQ_DISABLE_EHT)
-		ifmgd->flags |= IEEE80211_STA_DISABLE_EHT;
+		sdata->deflink.u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 
 	err = ieee80211_prep_connection(sdata, req->bss, true, override);
 	if (err)
diff --git a/net/mac80211/spectmgmt.c b/net/mac80211/spectmgmt.c
index 76747bfdaddd..871cdac2d0f4 100644
--- a/net/mac80211/spectmgmt.c
+++ b/net/mac80211/spectmgmt.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2008, Intel Corporation
  * Copyright 2008, Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2018, 2020 Intel Corporation
+ * Copyright (C) 2018, 2020, 2022 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -23,7 +23,7 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 				 struct ieee802_11_elems *elems,
 				 enum nl80211_band current_band,
 				 u32 vht_cap_info,
-				 u32 sta_flags, u8 *bssid,
+				 ieee80211_conn_flags_t conn_flags, u8 *bssid,
 				 struct ieee80211_csa_ie *csa_ie)
 {
 	enum nl80211_band new_band = current_band;
@@ -40,13 +40,13 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 	sec_chan_offs = elems->sec_chan_offs;
 	wide_bw_chansw_ie = elems->wide_bw_chansw_ie;
 
-	if (sta_flags & (IEEE80211_STA_DISABLE_HT |
-			 IEEE80211_STA_DISABLE_40MHZ)) {
+	if (conn_flags & (IEEE80211_CONN_DISABLE_HT |
+			  IEEE80211_CONN_DISABLE_40MHZ)) {
 		sec_chan_offs = NULL;
 		wide_bw_chansw_ie = NULL;
 	}
 
-	if (sta_flags & IEEE80211_STA_DISABLE_VHT)
+	if (conn_flags & IEEE80211_CONN_DISABLE_VHT)
 		wide_bw_chansw_ie = NULL;
 
 	if (elems->ext_chansw_ie) {
@@ -93,7 +93,7 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 
 	if (sec_chan_offs) {
 		secondary_channel_offset = sec_chan_offs->sec_chan_offs;
-	} else if (!(sta_flags & IEEE80211_STA_DISABLE_HT)) {
+	} else if (!(conn_flags & IEEE80211_CONN_DISABLE_HT)) {
 		/* If the secondary channel offset IE is not present,
 		 * we can't know what's the post-CSA offset, so the
 		 * best we can do is use 20MHz.
@@ -160,10 +160,10 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 						&new_vht_chandef))
 			new_vht_chandef.chan = NULL;
 
-		if (sta_flags & IEEE80211_STA_DISABLE_80P80MHZ &&
+		if (conn_flags & IEEE80211_CONN_DISABLE_80P80MHZ &&
 		    new_vht_chandef.width == NL80211_CHAN_WIDTH_80P80)
 			ieee80211_chandef_downgrade(&new_vht_chandef);
-		if (sta_flags & IEEE80211_STA_DISABLE_160MHZ &&
+		if (conn_flags & IEEE80211_CONN_DISABLE_160MHZ &&
 		    new_vht_chandef.width == NL80211_CHAN_WIDTH_160)
 			ieee80211_chandef_downgrade(&new_vht_chandef);
 	}
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 71883ffd7061..30f2b340017c 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1311,7 +1311,6 @@ static void
 iee80211_tdls_recalc_ht_protection(struct ieee80211_sub_if_data *sdata,
 				   struct sta_info *sta)
 {
-	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	bool tdls_ht;
 	u16 protection = IEEE80211_HT_OP_MODE_PROTECTION_NONHT_MIXED |
 			 IEEE80211_HT_OP_MODE_NON_GF_STA_PRSNT |
@@ -1319,7 +1318,7 @@ iee80211_tdls_recalc_ht_protection(struct ieee80211_sub_if_data *sdata,
 	u16 opmode;
 
 	/* Nothing to do if the BSS connection uses HT */
-	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT))
+	if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT))
 		return;
 
 	tdls_ht = (sta && sta->sta.deflink.ht_cap.ht_supported) ||
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 24b5e5d10d66..275310b6fc38 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2945,7 +2945,7 @@ u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata, u8 iftype)
 				     he_cap->he_cap_elem.phy_cap_info);
 }
 
-u8 *ieee80211_ie_build_he_cap(u32 disable_flags, u8 *pos,
+u8 *ieee80211_ie_build_he_cap(ieee80211_conn_flags_t disable_flags, u8 *pos,
 			      const struct ieee80211_sta_he_cap *he_cap,
 			      u8 *end)
 {
@@ -2965,16 +2965,16 @@ u8 *ieee80211_ie_build_he_cap(u32 disable_flags, u8 *pos,
 	/* modify on stack first to calculate 'n' and 'ie_len' correctly */
 	elem = he_cap->he_cap_elem;
 
-	if (disable_flags & IEEE80211_STA_DISABLE_40MHZ)
+	if (disable_flags & IEEE80211_CONN_DISABLE_40MHZ)
 		elem.phy_cap_info[0] &=
 			~(IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
 			  IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G);
 
-	if (disable_flags & IEEE80211_STA_DISABLE_160MHZ)
+	if (disable_flags & IEEE80211_CONN_DISABLE_160MHZ)
 		elem.phy_cap_info[0] &=
 			~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
 
-	if (disable_flags & IEEE80211_STA_DISABLE_80P80MHZ)
+	if (disable_flags & IEEE80211_CONN_DISABLE_80P80MHZ)
 		elem.phy_cap_info[0] &=
 			~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
 
@@ -4063,21 +4063,21 @@ void ieee80211_radar_detected(struct ieee80211_hw *hw)
 }
 EXPORT_SYMBOL(ieee80211_radar_detected);
 
-u32 ieee80211_chandef_downgrade(struct cfg80211_chan_def *c)
+ieee80211_conn_flags_t ieee80211_chandef_downgrade(struct cfg80211_chan_def *c)
 {
-	u32 ret;
+	ieee80211_conn_flags_t ret;
 	int tmp;
 
 	switch (c->width) {
 	case NL80211_CHAN_WIDTH_20:
 		c->width = NL80211_CHAN_WIDTH_20_NOHT;
-		ret = IEEE80211_STA_DISABLE_HT | IEEE80211_STA_DISABLE_VHT;
+		ret = IEEE80211_CONN_DISABLE_HT | IEEE80211_CONN_DISABLE_VHT;
 		break;
 	case NL80211_CHAN_WIDTH_40:
 		c->width = NL80211_CHAN_WIDTH_20;
 		c->center_freq1 = c->chan->center_freq;
-		ret = IEEE80211_STA_DISABLE_40MHZ |
-		      IEEE80211_STA_DISABLE_VHT;
+		ret = IEEE80211_CONN_DISABLE_40MHZ |
+		      IEEE80211_CONN_DISABLE_VHT;
 		break;
 	case NL80211_CHAN_WIDTH_80:
 		tmp = (30 + c->chan->center_freq - c->center_freq1)/20;
@@ -4086,13 +4086,13 @@ u32 ieee80211_chandef_downgrade(struct cfg80211_chan_def *c)
 		/* freq_P40 */
 		c->center_freq1 = c->center_freq1 - 20 + 40 * tmp;
 		c->width = NL80211_CHAN_WIDTH_40;
-		ret = IEEE80211_STA_DISABLE_VHT;
+		ret = IEEE80211_CONN_DISABLE_VHT;
 		break;
 	case NL80211_CHAN_WIDTH_80P80:
 		c->center_freq2 = 0;
 		c->width = NL80211_CHAN_WIDTH_80;
-		ret = IEEE80211_STA_DISABLE_80P80MHZ |
-		      IEEE80211_STA_DISABLE_160MHZ;
+		ret = IEEE80211_CONN_DISABLE_80P80MHZ |
+		      IEEE80211_CONN_DISABLE_160MHZ;
 		break;
 	case NL80211_CHAN_WIDTH_160:
 		/* n_P20 */
@@ -4101,8 +4101,8 @@ u32 ieee80211_chandef_downgrade(struct cfg80211_chan_def *c)
 		tmp /= 4;
 		c->center_freq1 = c->center_freq1 - 40 + 80 * tmp;
 		c->width = NL80211_CHAN_WIDTH_80;
-		ret = IEEE80211_STA_DISABLE_80P80MHZ |
-		      IEEE80211_STA_DISABLE_160MHZ;
+		ret = IEEE80211_CONN_DISABLE_80P80MHZ |
+		      IEEE80211_CONN_DISABLE_160MHZ;
 		break;
 	case NL80211_CHAN_WIDTH_320:
 		/* n_P20 */
@@ -4111,13 +4111,13 @@ u32 ieee80211_chandef_downgrade(struct cfg80211_chan_def *c)
 		tmp /= 8;
 		c->center_freq1 = c->center_freq1 - 80 + 160 * tmp;
 		c->width = NL80211_CHAN_WIDTH_160;
-		ret = IEEE80211_STA_DISABLE_320MHZ;
+		ret = IEEE80211_CONN_DISABLE_320MHZ;
 		break;
 	default:
 	case NL80211_CHAN_WIDTH_20_NOHT:
 		WARN_ON_ONCE(1);
 		c->width = NL80211_CHAN_WIDTH_20_NOHT;
-		ret = IEEE80211_STA_DISABLE_HT | IEEE80211_STA_DISABLE_VHT;
+		ret = IEEE80211_CONN_DISABLE_HT | IEEE80211_CONN_DISABLE_VHT;
 		break;
 	case NL80211_CHAN_WIDTH_1:
 	case NL80211_CHAN_WIDTH_2:
@@ -4128,7 +4128,7 @@ u32 ieee80211_chandef_downgrade(struct cfg80211_chan_def *c)
 	case NL80211_CHAN_WIDTH_10:
 		WARN_ON_ONCE(1);
 		/* keep c->width */
-		ret = IEEE80211_STA_DISABLE_HT | IEEE80211_STA_DISABLE_VHT;
+		ret = IEEE80211_CONN_DISABLE_HT | IEEE80211_CONN_DISABLE_VHT;
 		break;
 	}
 
-- 
2.36.1

