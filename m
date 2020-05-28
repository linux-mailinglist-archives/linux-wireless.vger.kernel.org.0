Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750911E64D0
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 16:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403758AbgE1Oyp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 10:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391286AbgE1Oyo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 10:54:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1099BC08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 07:54:44 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeJrY-004vYI-Qx; Thu, 28 May 2020 16:50:28 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/24] mac80211: avoid using ext NSS high BW if not supported
Date:   Thu, 28 May 2020 16:50:08 +0200
Message-Id: <20200528165011.0e55d40c3ccc.I6fd0b4708ebd087e5e46466c3e91f6efbcbef668@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528165011.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
References: <20200528165011.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If the AP advertises inconsistent data, namely it has CCFS1 or CCFS2,
but doesn't advertise support for 160/80+80 bandwidth or "Extended NSS
BW Support", then we cannot use any MCSes in the the higher bandwidth.
Thus, avoid connecting with higher bandwidth since it's less efficient
that way.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ibss.c        | 11 +++++++--
 net/mac80211/ieee80211_i.h |  6 ++++-
 net/mac80211/mesh.c        | 16 ++++++++++---
 net/mac80211/mlme.c        | 25 ++++++++++++++-----
 net/mac80211/scan.c        |  6 +++++
 net/mac80211/spectmgmt.c   |  4 +++-
 net/mac80211/util.c        | 49 ++++++++++++++++++++++++++++++++++----
 7 files changed, 100 insertions(+), 17 deletions(-)

diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 2479cd48fed0..81d26fef41e9 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -9,7 +9,7 @@
  * Copyright 2009, Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2016 Intel Deutschland GmbH
- * Copyright(c) 2018-2019 Intel Corporation
+ * Copyright(c) 2018-2020 Intel Corporation
  */
 
 #include <linux/delay.h>
@@ -781,6 +781,7 @@ ieee80211_ibss_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	enum nl80211_channel_type ch_type;
 	int err;
 	u32 sta_flags;
+	u32 vht_cap_info = 0;
 
 	sdata_assert_lock(sdata);
 
@@ -798,9 +799,13 @@ ieee80211_ibss_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 		break;
 	}
 
+	if (elems->vht_cap_elem)
+		vht_cap_info = le32_to_cpu(elems->vht_cap_elem->vht_cap_info);
+
 	memset(&params, 0, sizeof(params));
 	err = ieee80211_parse_ch_switch_ie(sdata, elems,
 					   ifibss->chandef.chan->band,
+					   vht_cap_info,
 					   sta_flags, ifibss->bssid, &csa_ie);
 	/* can't switch to destination channel, fail */
 	if (err < 0)
@@ -1060,8 +1065,10 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 			/* we both use VHT */
 			struct ieee80211_vht_cap cap_ie;
 			struct ieee80211_sta_vht_cap cap = sta->sta.vht_cap;
+			u32 vht_cap_info =
+				le32_to_cpu(elems->vht_cap_elem->vht_cap_info);
 
-			ieee80211_chandef_vht_oper(&local->hw,
+			ieee80211_chandef_vht_oper(&local->hw, vht_cap_info,
 						   elems->vht_operation,
 						   elems->ht_operation,
 						   &chandef);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 9f874ce500f6..0cc584574976 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -111,6 +111,8 @@ struct ieee80211_bss {
 	size_t supp_rates_len;
 	struct ieee80211_rate *beacon_rate;
 
+	u32 vht_cap_info;
+
 	/*
 	 * During association, we save an ERP value from a probe response so
 	 * that we can feed ERP info to the driver when handling the
@@ -1915,6 +1917,7 @@ void ieee80211_process_measurement_req(struct ieee80211_sub_if_data *sdata,
  * @sdata: the sdata of the interface which has received the frame
  * @elems: parsed 802.11 elements received with the frame
  * @current_band: indicates the current band
+ * @vht_cap_info: VHT capabilities of the transmitter
  * @sta_flags: contains information about own capabilities and restrictions
  *	to decide which channel switch announcements can be accepted. Only the
  *	following subset of &enum ieee80211_sta_flags are evaluated:
@@ -1929,6 +1932,7 @@ void ieee80211_process_measurement_req(struct ieee80211_sub_if_data *sdata,
 int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 				 struct ieee802_11_elems *elems,
 				 enum nl80211_band current_band,
+				 u32 vht_cap_info,
 				 u32 sta_flags, u8 *bssid,
 				 struct ieee80211_csa_ie *csa_ie);
 
@@ -2194,7 +2198,7 @@ u8 *ieee80211_add_wmm_info_ie(u8 *buf, u8 qosinfo);
 /* channel management */
 bool ieee80211_chandef_ht_oper(const struct ieee80211_ht_operation *ht_oper,
 			       struct cfg80211_chan_def *chandef);
-bool ieee80211_chandef_vht_oper(struct ieee80211_hw *hw,
+bool ieee80211_chandef_vht_oper(struct ieee80211_hw *hw, u32 vht_cap_info,
 				const struct ieee80211_vht_operation *oper,
 				const struct ieee80211_ht_operation *htop,
 				struct cfg80211_chan_def *chandef);
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 79e0a90982dd..696d6fb322e6 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2008, 2009 open80211s Ltd.
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright (C) 2018 - 2020 Intel Corporation
  * Authors:    Luis Carlos Cobo <luisca@cozybit.com>
  * 	       Javier Cardona <javier@cozybit.com>
  */
@@ -63,6 +63,7 @@ bool mesh_matches_local(struct ieee80211_sub_if_data *sdata,
 	u32 basic_rates = 0;
 	struct cfg80211_chan_def sta_chan_def;
 	struct ieee80211_supported_band *sband;
+	u32 vht_cap_info = 0;
 
 	/*
 	 * As support for each feature is added, check for matching
@@ -96,7 +97,11 @@ bool mesh_matches_local(struct ieee80211_sub_if_data *sdata,
 	cfg80211_chandef_create(&sta_chan_def, sdata->vif.bss_conf.chandef.chan,
 				NL80211_CHAN_NO_HT);
 	ieee80211_chandef_ht_oper(ie->ht_operation, &sta_chan_def);
-	ieee80211_chandef_vht_oper(&sdata->local->hw,
+
+	if (ie->vht_cap_elem)
+		vht_cap_info = le32_to_cpu(ie->vht_cap_elem->vht_cap_info);
+
+	ieee80211_chandef_vht_oper(&sdata->local->hw, vht_cap_info,
 				   ie->vht_operation, ie->ht_operation,
 				   &sta_chan_def);
 
@@ -1076,7 +1081,7 @@ ieee80211_mesh_process_chnswitch(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
 	struct ieee80211_supported_band *sband;
 	int err;
-	u32 sta_flags;
+	u32 sta_flags, vht_cap_info = 0;
 
 	sdata_assert_lock(sdata);
 
@@ -1099,8 +1104,13 @@ ieee80211_mesh_process_chnswitch(struct ieee80211_sub_if_data *sdata,
 		break;
 	}
 
+	if (elems->vht_cap_elem)
+		vht_cap_info =
+			le32_to_cpu(elems->vht_cap_elem->vht_cap_info);
+
 	memset(&params, 0, sizeof(params));
 	err = ieee80211_parse_ch_switch_ie(sdata, elems, sband->band,
+					   vht_cap_info,
 					   sta_flags, sdata->vif.addr,
 					   &csa_ie);
 	if (err < 0)
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f6ddce646f18..1f9c48414c85 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -145,6 +145,7 @@ static u32
 ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 			     struct ieee80211_supported_band *sband,
 			     struct ieee80211_channel *channel,
+			     u32 vht_cap_info,
 			     const struct ieee80211_ht_operation *ht_oper,
 			     const struct ieee80211_vht_operation *vht_oper,
 			     const struct ieee80211_he_operation *he_oper,
@@ -223,7 +224,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 		memcpy(&he_oper_vht_cap, he_oper->optional, 3);
 		he_oper_vht_cap.basic_mcs_set = cpu_to_le16(0);
 
-		if (!ieee80211_chandef_vht_oper(&sdata->local->hw,
+		if (!ieee80211_chandef_vht_oper(&sdata->local->hw, vht_cap_info,
 						&he_oper_vht_cap, ht_oper,
 						&vht_chandef)) {
 			if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE))
@@ -232,8 +233,10 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 			ret = IEEE80211_STA_DISABLE_HE;
 			goto out;
 		}
-	} else if (!ieee80211_chandef_vht_oper(&sdata->local->hw, vht_oper,
-					       ht_oper, &vht_chandef)) {
+	} else if (!ieee80211_chandef_vht_oper(&sdata->local->hw,
+					       vht_cap_info,
+					       vht_oper, ht_oper,
+					       &vht_chandef)) {
 		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
 			sdata_info(sdata,
 				   "AP VHT information is invalid, disable VHT\n");
@@ -329,6 +332,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 			       struct sta_info *sta,
 			       const struct ieee80211_ht_cap *ht_cap,
+			       const struct ieee80211_vht_cap *vht_cap,
 			       const struct ieee80211_ht_operation *ht_oper,
 			       const struct ieee80211_vht_operation *vht_oper,
 			       const struct ieee80211_he_operation *he_oper,
@@ -343,6 +347,7 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 	u16 ht_opmode;
 	u32 flags;
 	enum ieee80211_sta_rx_bandwidth new_sta_bw;
+	u32 vht_cap_info = 0;
 	int ret;
 
 	/* if HT was/is disabled, don't track any bandwidth changes */
@@ -371,8 +376,11 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 		sdata->vif.bss_conf.ht_operation_mode = ht_opmode;
 	}
 
+	if (vht_cap)
+		vht_cap_info = le32_to_cpu(vht_cap->vht_cap_info);
+
 	/* calculate new channel (type) based on HT/VHT/HE operation IEs */
-	flags = ieee80211_determine_chantype(sdata, sband, chan,
+	flags = ieee80211_determine_chantype(sdata, sband, chan, vht_cap_info,
 					     ht_oper, vht_oper, he_oper,
 					     &chandef, true);
 
@@ -1327,6 +1335,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	enum nl80211_band current_band;
 	struct ieee80211_csa_ie csa_ie;
 	struct ieee80211_channel_switch ch_switch;
+	struct ieee80211_bss *bss;
 	int res;
 
 	sdata_assert_lock(sdata);
@@ -1338,7 +1347,9 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	current_band = cbss->channel->band;
+	bss = (void *)cbss->priv;
 	res = ieee80211_parse_ch_switch_ie(sdata, elems, current_band,
+					   bss->vht_cap_info,
 					   ifmgd->flags,
 					   ifmgd->associated->bssid, &csa_ie);
 
@@ -4097,8 +4108,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 
 	changed |= ieee80211_recalc_twt_req(sdata, sta, &elems);
 
-	if (ieee80211_config_bw(sdata, sta,
-				elems.ht_cap_elem, elems.ht_operation,
+	if (ieee80211_config_bw(sdata, sta, elems.ht_cap_elem,
+				elems.vht_cap_elem, elems.ht_operation,
 				elems.vht_operation, elems.he_operation,
 				bssid, &changed)) {
 		mutex_unlock(&local->sta_mtx);
@@ -4815,6 +4826,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	const struct ieee80211_he_operation *he_oper = NULL;
 	struct ieee80211_supported_band *sband;
 	struct cfg80211_chan_def chandef;
+	struct ieee80211_bss *bss = (void *)cbss->priv;
 	int ret;
 	u32 i;
 	bool have_80mhz;
@@ -4913,6 +4925,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 
 	ifmgd->flags |= ieee80211_determine_chantype(sdata, sband,
 						     cbss->channel,
+						     bss->vht_cap_info,
 						     ht_oper, vht_oper, he_oper,
 						     &chandef, false);
 
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 5db15996524f..d0c2e8012118 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -132,6 +132,12 @@ ieee80211_update_bss_from_elems(struct ieee80211_local *local,
 			bss->beacon_rate =
 				&sband->bitrates[rx_status->rate_idx];
 	}
+
+	if (elems->vht_cap_elem)
+		bss->vht_cap_info =
+			le32_to_cpu(elems->vht_cap_elem->vht_cap_info);
+	else
+		bss->vht_cap_info = 0;
 }
 
 struct ieee80211_bss *
diff --git a/net/mac80211/spectmgmt.c b/net/mac80211/spectmgmt.c
index 5fe2b645912f..ae1cb2c68722 100644
--- a/net/mac80211/spectmgmt.c
+++ b/net/mac80211/spectmgmt.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2008, Intel Corporation
  * Copyright 2008, Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2018        Intel Corporation
+ * Copyright (C) 2018, 2020 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -22,6 +22,7 @@
 int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 				 struct ieee802_11_elems *elems,
 				 enum nl80211_band current_band,
+				 u32 vht_cap_info,
 				 u32 sta_flags, u8 *bssid,
 				 struct ieee80211_csa_ie *csa_ie)
 {
@@ -150,6 +151,7 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 
 		/* ignore if parsing fails */
 		if (!ieee80211_chandef_vht_oper(&sdata->local->hw,
+						vht_cap_info,
 						&vht_oper, &ht_oper,
 						&new_vht_chandef))
 			new_vht_chandef.chan = NULL;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 87dd003dbdf2..e6104829fa1c 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3120,7 +3120,7 @@ bool ieee80211_chandef_ht_oper(const struct ieee80211_ht_operation *ht_oper,
 	return true;
 }
 
-bool ieee80211_chandef_vht_oper(struct ieee80211_hw *hw,
+bool ieee80211_chandef_vht_oper(struct ieee80211_hw *hw, u32 vht_cap_info,
 				const struct ieee80211_vht_operation *oper,
 				const struct ieee80211_ht_operation *htop,
 				struct cfg80211_chan_def *chandef)
@@ -3132,6 +3132,10 @@ bool ieee80211_chandef_vht_oper(struct ieee80211_hw *hw,
 	u32 vht_cap;
 	bool support_80_80 = false;
 	bool support_160 = false;
+	u8 ext_nss_bw_supp = u32_get_bits(vht_cap_info,
+					  IEEE80211_VHT_CAP_EXT_NSS_BW_MASK);
+	u8 supp_chwidth = u32_get_bits(vht_cap_info,
+				       IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK);
 
 	if (!oper || !htop)
 		return false;
@@ -3151,11 +3155,48 @@ bool ieee80211_chandef_vht_oper(struct ieee80211_hw *hw,
 				IEEE80211_HT_OP_MODE_CCFS2_MASK)
 			>> IEEE80211_HT_OP_MODE_CCFS2_SHIFT;
 
-	/* when parsing (and we know how to) CCFS1 and CCFS2 are equivalent */
 	ccf0 = ccfs0;
-	ccf1 = ccfs1;
-	if (!ccfs1 && ieee80211_hw_check(hw, SUPPORTS_VHT_EXT_NSS_BW))
+
+	/* if not supported, parse as though we didn't understand it */
+	if (!ieee80211_hw_check(hw, SUPPORTS_VHT_EXT_NSS_BW))
+		ext_nss_bw_supp = 0;
+
+	/*
+	 * Cf. IEEE 802.11 Table 9-250
+	 *
+	 * We really just consider that because it's inefficient to connect
+	 * at a higher bandwidth than we'll actually be able to use.
+	 */
+	switch ((supp_chwidth << 4) | ext_nss_bw_supp) {
+	default:
+	case 0x00:
+		ccf1 = 0;
+		support_160 = false;
+		support_80_80 = false;
+		break;
+	case 0x01:
+		support_80_80 = false;
+		/* fall through */
+	case 0x02:
+	case 0x03:
 		ccf1 = ccfs2;
+		break;
+	case 0x10:
+		ccf1 = ccfs1;
+		break;
+	case 0x11:
+	case 0x12:
+		if (!ccfs1)
+			ccf1 = ccfs2;
+		else
+			ccf1 = ccfs1;
+		break;
+	case 0x13:
+	case 0x20:
+	case 0x23:
+		ccf1 = ccfs1;
+		break;
+	}
 
 	cf0 = ieee80211_channel_to_frequency(ccf0, chandef->chan->band);
 	cf1 = ieee80211_channel_to_frequency(ccf1, chandef->chan->band);
-- 
2.26.2

