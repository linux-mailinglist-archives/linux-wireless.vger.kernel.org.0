Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551367215BF
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jun 2023 11:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjFDJMZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Jun 2023 05:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjFDJMY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Jun 2023 05:12:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC551A7
        for <linux-wireless@vger.kernel.org>; Sun,  4 Jun 2023 02:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685869933; x=1717405933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/3RV5OzV8x1LrXl6x7UU9s56VAFdRYqqjIe34wrVNKk=;
  b=Z9quCWoGr2nFjRxV3ZbWvRYEUJz/q5qvKwMqQ7QlZHxHfFOs4FTK8FpD
   mEg5l5H8wJLPTiCdh7+/Vz92qtMUtUQbEk3mNYzUq21dSMlt+u1xsIKbn
   tC/LTT4QO9WeRF5vY/tUl/QhqxOMwAHtarjc0Xd/fzV5RYugIsY9mWyQZ
   ugvIEM6P8Ko/VO8yExsnQLk5+LzEWGJ/3t+q0yU2h9N8J7SO1dz5LicVt
   mmlcTCOsZBv1Euin3+WNLyENN2eVwxYWjsTsssD2GJ9by3GvkUUxfUmKg
   7yshsqTh3DWrEjkJz1G2h7HcM5zKwTBJR01ow7AkzyylEM95Ipa58SSzd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="336526540"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336526540"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:12:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="820804759"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="820804759"
Received: from yfruchte-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.219.60])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 02:12:10 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/16] wifi: mac80211: add helpers to access sband iftype data
Date:   Sun,  4 Jun 2023 12:11:24 +0300
Message-Id: <20230604120651.db099f49e764.Ie892966c49e22c7b7ee1073bc684f142debfdc84@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230604091128.609335-1-gregory.greenman@intel.com>
References: <20230604091128.609335-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's quite a bit of code accessing sband iftype data
(HE, HE 6 GHz, EHT) and we always need to remember to use
the ieee80211_vif_type_p2p() helper. Add new helpers to
directly get it from the sband/vif rather than having to
call ieee80211_vif_type_p2p().

Convert most code with the following spatch:

    @@
    expression vif, sband;
    @@
    -ieee80211_get_he_iftype_cap(sband, ieee80211_vif_type_p2p(vif))
    +ieee80211_get_he_iftype_cap_vif(sband, vif)

    @@
    expression vif, sband;
    @@
    -ieee80211_get_eht_iftype_cap(sband, ieee80211_vif_type_p2p(vif))
    +ieee80211_get_eht_iftype_cap_vif(sband, vif)

    @@
    expression vif, sband;
    @@
    -ieee80211_get_he_6ghz_capa(sband, ieee80211_vif_type_p2p(vif))
    +ieee80211_get_he_6ghz_capa_vif(sband, vif)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  6 +--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  5 +--
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  5 +--
 include/net/mac80211.h                        | 44 ++++++++++++++++++-
 net/mac80211/eht.c                            |  5 +--
 net/mac80211/he.c                             |  3 +-
 net/mac80211/mlme.c                           | 30 +++++--------
 net/mac80211/util.c                           | 11 ++---
 8 files changed, 66 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 0f01b62357c6..16a36797b836 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2285,8 +2285,7 @@ bool iwl_mvm_is_nic_ack_enabled(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	 * so take it from one of them.
 	 */
 	sband = mvm->hw->wiphy->bands[NL80211_BAND_2GHZ];
-	own_he_cap = ieee80211_get_he_iftype_cap(sband,
-						 ieee80211_vif_type_p2p(vif));
+	own_he_cap = ieee80211_get_he_iftype_cap_vif(sband, vif);
 
 	return (own_he_cap && (own_he_cap->he_cap_elem.mac_cap_info[2] &
 			       IEEE80211_HE_MAC_CAP2_ACK_EN));
@@ -3468,8 +3467,7 @@ static void iwl_mvm_reset_cca_40mhz_workaround(struct iwl_mvm *mvm,
 
 	sband->ht_cap.cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40;
 
-	he_cap = ieee80211_get_he_iftype_cap(sband,
-					     ieee80211_vif_type_p2p(vif));
+	he_cap = ieee80211_get_he_iftype_cap_vif(sband, vif);
 
 	if (he_cap) {
 		/* we know that ours is writable */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 32625bfacaae..6ba4ad6b1380 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -192,8 +192,7 @@ static void iwl_mvm_rx_monitor_notif(struct iwl_mvm *mvm,
 	WARN_ON(!(sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40));
 	sband->ht_cap.cap &= ~IEEE80211_HT_CAP_SUP_WIDTH_20_40;
 
-	he_cap = ieee80211_get_he_iftype_cap(sband,
-					     ieee80211_vif_type_p2p(vif));
+	he_cap = ieee80211_get_he_iftype_cap_vif(sband, vif);
 
 	if (he_cap) {
 		/* we know that ours is writable */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index c3a00bfbeef2..f72d1ca3cfed 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 #include "rs.h"
 #include "fw-api.h"
@@ -94,8 +94,7 @@ static u16 rs_fw_get_config_flags(struct iwl_mvm *mvm,
 	    IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD))
 		flags |= IWL_TLC_MNG_CFG_FLAGS_LDPC_MSK;
 
-	sband_he_cap = ieee80211_get_he_iftype_cap(sband,
-						   ieee80211_vif_type_p2p(vif));
+	sband_he_cap = ieee80211_get_he_iftype_cap_vif(sband, vif);
 	if (sband_he_cap &&
 	    !(sband_he_cap->he_cap_elem.phy_cap_info[1] &
 			IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD))
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f4516c034da2..8ea23884a583 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7,7 +7,7 @@
  * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2022 Intel Corporation
+ * Copyright (C) 2018 - 2023 Intel Corporation
  */
 
 #ifndef MAC80211_H
@@ -6866,6 +6866,48 @@ ieee80211_vif_type_p2p(struct ieee80211_vif *vif)
 	return ieee80211_iftype_p2p(vif->type, vif->p2p);
 }
 
+/**
+ * ieee80211_get_he_iftype_cap_vif - return HE capabilities for sband/vif
+ * @sband: the sband to search for the iftype on
+ * @vif: the vif to get the iftype from
+ *
+ * Return: pointer to the struct ieee80211_sta_he_cap, or %NULL is none found
+ */
+static inline const struct ieee80211_sta_he_cap *
+ieee80211_get_he_iftype_cap_vif(const struct ieee80211_supported_band *sband,
+				struct ieee80211_vif *vif)
+{
+	return ieee80211_get_he_iftype_cap(sband, ieee80211_vif_type_p2p(vif));
+}
+
+/**
+ * ieee80211_get_he_6ghz_capa_vif - return HE 6 GHz capabilities
+ * @sband: the sband to search for the STA on
+ * @vif: the vif to get the iftype from
+ *
+ * Return: the 6GHz capabilities
+ */
+static inline __le16
+ieee80211_get_he_6ghz_capa_vif(const struct ieee80211_supported_band *sband,
+			       struct ieee80211_vif *vif)
+{
+	return ieee80211_get_he_6ghz_capa(sband, ieee80211_vif_type_p2p(vif));
+}
+
+/**
+ * ieee80211_get_eht_iftype_cap_vif - return ETH capabilities for sband/vif
+ * @sband: the sband to search for the iftype on
+ * @vif: the vif to get the iftype from
+ *
+ * Return: pointer to the struct ieee80211_sta_eht_cap, or %NULL is none found
+ */
+static inline const struct ieee80211_sta_eht_cap *
+ieee80211_get_eht_iftype_cap_vif(const struct ieee80211_supported_band *sband,
+				 struct ieee80211_vif *vif)
+{
+	return ieee80211_get_eht_iftype_cap(sband, ieee80211_vif_type_p2p(vif));
+}
+
 /**
  * ieee80211_update_mu_groups - set the VHT MU-MIMO groud data
  *
diff --git a/net/mac80211/eht.c b/net/mac80211/eht.c
index 18bc6b78b267..ddc7acc68335 100644
--- a/net/mac80211/eht.c
+++ b/net/mac80211/eht.c
@@ -2,7 +2,7 @@
 /*
  * EHT handling
  *
- * Copyright(c) 2021-2022 Intel Corporation
+ * Copyright(c) 2021-2023 Intel Corporation
  */
 
 #include "ieee80211_i.h"
@@ -25,8 +25,7 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 	memset(eht_cap, 0, sizeof(*eht_cap));
 
 	if (!eht_cap_ie_elem ||
-	    !ieee80211_get_eht_iftype_cap(sband,
-					 ieee80211_vif_type_p2p(&sdata->vif)))
+	    !ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif))
 		return;
 
 	mcs_nss_size = ieee80211_eht_mcs_nss_size(he_cap_ie_elem,
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 0322abae0825..9f5ffdc9db28 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -128,8 +128,7 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	own_he_cap_ptr =
-		ieee80211_get_he_iftype_cap(sband,
-					    ieee80211_vif_type_p2p(&sdata->vif));
+		ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
 	if (!own_he_cap_ptr)
 		return;
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a404448eb84e..7d6248b8d280 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -511,16 +511,14 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 
 	/* don't check HE if we associated as non-HE station */
 	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE ||
-	    !ieee80211_get_he_iftype_cap(sband,
-					 ieee80211_vif_type_p2p(&sdata->vif))) {
+	    !ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif)) {
 		he_oper = NULL;
 		eht_oper = NULL;
 	}
 
 	/* don't check EHT if we associated as non-EHT station */
 	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT ||
-	    !ieee80211_get_eht_iftype_cap(sband,
-					 ieee80211_vif_type_p2p(&sdata->vif)))
+	    !ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif))
 		eht_oper = NULL;
 
 	/*
@@ -776,8 +774,7 @@ static void ieee80211_add_he_ie(struct ieee80211_sub_if_data *sdata,
 	const struct ieee80211_sta_he_cap *he_cap;
 	u8 he_cap_size;
 
-	he_cap = ieee80211_get_he_iftype_cap(sband,
-					     ieee80211_vif_type_p2p(&sdata->vif));
+	he_cap = ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
 	if (WARN_ON(!he_cap))
 		return;
 
@@ -806,10 +803,8 @@ static void ieee80211_add_eht_ie(struct ieee80211_sub_if_data *sdata,
 	const struct ieee80211_sta_eht_cap *eht_cap;
 	u8 eht_cap_size;
 
-	he_cap = ieee80211_get_he_iftype_cap(sband,
-					     ieee80211_vif_type_p2p(&sdata->vif));
-	eht_cap = ieee80211_get_eht_iftype_cap(sband,
-					       ieee80211_vif_type_p2p(&sdata->vif));
+	he_cap = ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
+	eht_cap = ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif);
 
 	/*
 	 * EHT capabilities element is only added if the HE capabilities element
@@ -3949,8 +3944,7 @@ static bool ieee80211_twt_req_supported(struct ieee80211_sub_if_data *sdata,
 					const struct ieee802_11_elems *elems)
 {
 	const struct ieee80211_sta_he_cap *own_he_cap =
-		ieee80211_get_he_iftype_cap(sband,
-					    ieee80211_vif_type_p2p(&sdata->vif));
+		ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
 
 	if (elems->ext_capab_len < 10)
 		return false;
@@ -3986,8 +3980,7 @@ static bool ieee80211_twt_bcast_support(struct ieee80211_sub_if_data *sdata,
 					struct link_sta_info *link_sta)
 {
 	const struct ieee80211_sta_he_cap *own_he_cap =
-		ieee80211_get_he_iftype_cap(sband,
-					    ieee80211_vif_type_p2p(&sdata->vif));
+		ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
 
 	return bss_conf->he_support &&
 		(link_sta->pub->he_cap.he_cap_elem.mac_cap_info[2] &
@@ -4624,8 +4617,7 @@ ieee80211_verify_sta_he_mcs_support(struct ieee80211_sub_if_data *sdata,
 				    const struct ieee80211_he_operation *he_op)
 {
 	const struct ieee80211_sta_he_cap *sta_he_cap =
-		ieee80211_get_he_iftype_cap(sband,
-					    ieee80211_vif_type_p2p(&sdata->vif));
+		ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
 	u16 ap_min_req_set;
 	int i;
 
@@ -4759,15 +4751,13 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		*conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 	}
 
-	if (!ieee80211_get_he_iftype_cap(sband,
-					 ieee80211_vif_type_p2p(&sdata->vif))) {
+	if (!ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif)) {
 		mlme_dbg(sdata, "HE not supported, disabling HE and EHT\n");
 		*conn_flags |= IEEE80211_CONN_DISABLE_HE;
 		*conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 	}
 
-	if (!ieee80211_get_eht_iftype_cap(sband,
-					  ieee80211_vif_type_p2p(&sdata->vif))) {
+	if (!ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif)) {
 		mlme_dbg(sdata, "EHT not supported, disabling EHT\n");
 		*conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 	}
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index d178dc8ab500..316a052d61bd 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -6,7 +6,7 @@
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  *
  * utilities for mac80211
  */
@@ -2121,8 +2121,7 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 		*offset = noffset;
 	}
 
-	he_cap = ieee80211_get_he_iftype_cap(sband,
-					     ieee80211_vif_type_p2p(&sdata->vif));
+	he_cap = ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
 	if (he_cap &&
 	    cfg80211_any_usable_channels(local->hw.wiphy, BIT(sband->band),
 					 IEEE80211_CHAN_NO_HE)) {
@@ -2131,8 +2130,7 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 			goto out_err;
 	}
 
-	eht_cap = ieee80211_get_eht_iftype_cap(sband,
-					       ieee80211_vif_type_p2p(&sdata->vif));
+	eht_cap = ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif);
 
 	if (eht_cap &&
 	    cfg80211_any_usable_channels(local->hw.wiphy, BIT(sband->band),
@@ -2150,8 +2148,7 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 		struct ieee80211_supported_band *sband6;
 
 		sband6 = local->hw.wiphy->bands[NL80211_BAND_6GHZ];
-		he_cap = ieee80211_get_he_iftype_cap(sband6,
-				ieee80211_vif_type_p2p(&sdata->vif));
+		he_cap = ieee80211_get_he_iftype_cap_vif(sband6, &sdata->vif);
 
 		if (he_cap) {
 			enum nl80211_iftype iftype =
-- 
2.38.1

