Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA461E64D3
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 16:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391303AbgE1OzA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 10:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391243AbgE1Oy7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 10:54:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D2BC08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 07:54:58 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeJrZ-004vYI-Ru; Thu, 28 May 2020 16:50:30 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 15/24] mac80211: use HE 6 GHz band capability and pass it to the driver
Date:   Thu, 28 May 2020 16:50:11 +0200
Message-Id: <20200528165011.12e16ac7a32e.I5f1230d5ab27e84e7bbe88e3645b24ea15a0c146@changeid>
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

In order to handle 6 GHz AP side, take the HE 6 GHz band capability
data and pass it to the driver (which needs it for A-MPDU spacing
and A-MPDU length).

Link: https://lore.kernel.org/r/1589399105-25472-6-git-send-email-rmanohar@codeaurora.org
Co-developed-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h     |  4 +++-
 net/mac80211/cfg.c         |  4 +++-
 net/mac80211/he.c          | 48 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/mesh_plink.c  |  4 +++-
 net/mac80211/mlme.c        |  1 +
 6 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 7cb712427df1..11d5610d2ad5 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7,7 +7,7 @@
  * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright (C) 2018 - 2020 Intel Corporation
  */
 
 #ifndef MAC80211_H
@@ -1977,6 +1977,7 @@ struct ieee80211_sta_txpwr {
  * @ht_cap: HT capabilities of this STA; restricted to our own capabilities
  * @vht_cap: VHT capabilities of this STA; restricted to our own capabilities
  * @he_cap: HE capabilities of this STA
+ * @he_6ghz_capa: on 6 GHz, holds the HE 6 GHz band capabilities
  * @max_rx_aggregation_subframes: maximal amount of frames in a single AMPDU
  *	that this station is allowed to transmit to us.
  *	Can be modified by driver.
@@ -2016,6 +2017,7 @@ struct ieee80211_sta {
 	struct ieee80211_sta_ht_cap ht_cap;
 	struct ieee80211_sta_vht_cap vht_cap;
 	struct ieee80211_sta_he_cap he_cap;
+	struct ieee80211_he_6ghz_capa he_6ghz_capa;
 	u16 max_rx_aggregation_subframes;
 	bool wme;
 	u8 uapsd_queues;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 06a2b7640a9d..90a07d075fdb 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1520,7 +1520,9 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	if (params->he_capa)
 		ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband,
 						  (void *)params->he_capa,
-						  params->he_capa_len, sta);
+						  params->he_capa_len,
+						  (void *)params->he_6ghz_capa,
+						  sta);
 
 	if (params->opmode_notif_used) {
 		/* returned value is only needed for rc update, but the
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index f520552b22be..cc26f239838b 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -8,10 +8,55 @@
 
 #include "ieee80211_i.h"
 
+static void
+ieee80211_update_from_he_6ghz_capa(const struct ieee80211_he_6ghz_capa *he_6ghz_capa,
+				   struct sta_info *sta)
+{
+	enum ieee80211_smps_mode smps_mode;
+
+	if (sta->sdata->vif.type == NL80211_IFTYPE_AP ||
+	    sta->sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
+		switch (le16_get_bits(he_6ghz_capa->capa,
+				      IEEE80211_HE_6GHZ_CAP_SM_PS)) {
+		case WLAN_HT_CAP_SM_PS_INVALID:
+		case WLAN_HT_CAP_SM_PS_STATIC:
+			smps_mode = IEEE80211_SMPS_STATIC;
+			break;
+		case WLAN_HT_CAP_SM_PS_DYNAMIC:
+			smps_mode = IEEE80211_SMPS_DYNAMIC;
+			break;
+		case WLAN_HT_CAP_SM_PS_DISABLED:
+			smps_mode = IEEE80211_SMPS_OFF;
+			break;
+		}
+
+		sta->sta.smps_mode = smps_mode;
+	} else {
+		sta->sta.smps_mode = IEEE80211_SMPS_OFF;
+	}
+
+	switch (le16_get_bits(he_6ghz_capa->capa,
+			      IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN)) {
+	case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454:
+		sta->sta.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_VHT_11454;
+		break;
+	case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991:
+		sta->sta.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_VHT_7991;
+		break;
+	case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895:
+	default:
+		sta->sta.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_VHT_3895;
+		break;
+	}
+
+	sta->sta.he_6ghz_capa = *he_6ghz_capa;
+}
+
 void
 ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 				  struct ieee80211_supported_band *sband,
 				  const u8 *he_cap_ie, u8 he_cap_len,
+				  const struct ieee80211_he_6ghz_capa *he_6ghz_capa,
 				  struct sta_info *sta)
 {
 	struct ieee80211_sta_he_cap *he_cap = &sta->sta.he_cap;
@@ -53,6 +98,9 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 
 	sta->cur_max_bandwidth = ieee80211_sta_cap_rx_bw(sta);
 	sta->sta.bandwidth = ieee80211_sta_cur_vht_bw(sta);
+
+	if (sband->band == NL80211_BAND_6GHZ && he_6ghz_capa)
+		ieee80211_update_from_he_6ghz_capa(he_6ghz_capa, sta);
 }
 
 void
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 6cac5bf7cba3..24dc1fd57000 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1899,6 +1899,7 @@ void
 ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 				  struct ieee80211_supported_band *sband,
 				  const u8 *he_cap_ie, u8 he_cap_len,
+				  const struct ieee80211_he_6ghz_capa *he_6ghz_capa,
 				  struct sta_info *sta);
 void
 ieee80211_he_spr_ie_to_bss_conf(struct ieee80211_vif *vif,
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index fbbfc5d4a51c..798e4b6b383f 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -444,7 +444,9 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 					    elems->vht_cap_elem, sta);
 
 	ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband, elems->he_cap,
-					  elems->he_cap_len, sta);
+					  elems->he_cap_len,
+					  elems->he_6ghz_capa,
+					  sta);
 
 	if (bw != sta->sta.bandwidth)
 		changed |= IEEE80211_RC_BW_CHANGED;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index abb507908982..9fe4ca42b7aa 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3430,6 +3430,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband,
 						  elems->he_cap,
 						  elems->he_cap_len,
+						  elems->he_6ghz_capa,
 						  sta);
 
 		bss_conf->he_support = sta->sta.he_cap.has_he;
-- 
2.26.2

