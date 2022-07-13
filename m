Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3058F57334C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbiGMJqS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235978AbiGMJpa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC70BEF9E9
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=6hkyIoxtSbW7yRmyNtLjsHefhPxJcz2Z2WkVIGcU5/g=;
        t=1657705523; x=1658915123; b=B6puJGYIeH+vtEYj/WAndCTLQGPBhiI3aZ7RULJHh9JWriG
        okYSGhc8y8z7GuSl9hsP32ZbXIaBR+A6Kvhr8iTa7lYLuNSpJwPRM5jYNyL1lDp5nEADAYE36q0Ww
        b1Us20FDRDPGqYrmkI6E8unBiH2mUUWiIrepNnJm0Vkd71mMmNOzSFHFzYAJsxCYhIngrvjWltKQF
        5edjzCBaC4NNw4Ln+teGFuj/TEUfytfpjc8eewYLLpj8YWuOAeHcm+y9JGrdAdh2zwFR+5hpacyex
        2pSPGSzQnA6idkRDrcD/Cn0Fn7JGTKZmxfpuBAw+JoW0ezo8QwG4VBTYl9zTfeXA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvp-00EgvB-AI;
        Wed, 13 Jul 2022 11:45:21 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 48/76] wifi: mac80211: fix multi-BSSID element parsing
Date:   Wed, 13 Jul 2022 11:44:34 +0200
Message-Id: <20220713114425.9ee458cf5e69.I53783bb838d68a65bc1c0e7b5a5f4a6213f8cdc8@changeid>
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

When parsing a frame containing a multi-BSSID element, we
need to know both the transmitted and non-transmitted BSSID
so we can parse it correctly.

Unfortunately, in quite a number of cases, we got this wrong
and were passing the wrong BSSID or useless information:
 * the mgmt->bssid from a frame is only the transmitted
   BSSID if the frame is a beacon
 * passing just one of the parameters as non-NULL isn't
   useful and ignored

In those case where we need to parse for a specific BSS we
always have a BSS structure pointer, representing the BSS
we need, whether transmitted or not. Thus, pass that pointer
to the parsing function instead of the two BSSIDs.

Also fix two bugs:
 * we need to re-parse all the elements for the other BSS
   when iterating the non-transmitted BSSes in scan
 * we need to parse for the correct BSS when setting up
   the channel data in client code

Fixes: 78ac51f81532 ("mac80211: support multi-bssid")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/agg-rx.c      |  2 +-
 net/mac80211/ibss.c        |  5 ++---
 net/mac80211/ieee80211_i.h | 22 ++++++++--------------
 net/mac80211/mesh.c        |  8 +++-----
 net/mac80211/mesh_hwmp.c   |  2 +-
 net/mac80211/mesh_plink.c  |  3 +--
 net/mac80211/mlme.c        | 17 +++++++----------
 net/mac80211/scan.c        | 12 ++++++++----
 net/mac80211/tdls.c        |  4 ++--
 net/mac80211/util.c        | 13 +++++--------
 10 files changed, 38 insertions(+), 50 deletions(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index b7c50646063d..9414d3bbd65f 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -502,7 +502,7 @@ void ieee80211_process_addba_request(struct ieee80211_local *local,
 				 u.action.u.addba_req.variable);
 	if (ies_len) {
 		elems = ieee802_11_parse_elems(mgmt->u.action.u.addba_req.variable,
-					       ies_len, true, mgmt->bssid, NULL);
+					       ies_len, true, NULL);
 		if (!elems || elems->parse_error)
 			goto free;
 	}
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 0a1d51c60530..e8df4ce33984 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1601,8 +1601,7 @@ void ieee80211_rx_mgmt_probe_beacon(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	elems = ieee802_11_parse_elems(mgmt->u.probe_resp.variable,
-				       len - baselen, false,
-				       mgmt->bssid, NULL);
+				       len - baselen, false, NULL);
 
 	if (elems) {
 		ieee80211_rx_bss_info(sdata, mgmt, len, rx_status, elems);
@@ -1655,7 +1654,7 @@ void ieee80211_ibss_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 
 			elems = ieee802_11_parse_elems(
 				mgmt->u.action.u.chan_switch.variable,
-				ies_len, true, mgmt->bssid, NULL);
+				ies_len, true, NULL);
 
 			if (elems && !elems->parse_error)
 				ieee80211_rx_mgmt_spectrum_mgmt(sdata, mgmt,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a8211ced719e..dc38f57fcdc9 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2147,10 +2147,9 @@ static inline void ieee80211_tx_skb(struct ieee80211_sub_if_data *sdata,
  * @filter: bitmap of element IDs to filter out while calculating
  *	the element CRC
  * @crc: CRC starting value
- * @transmitter_bssid: transmitter BSSID to parse the multi-BSSID
- *	element
- * @bss_bssid: BSSID of the BSS we want to obtain elements for
- *	when parsing the multi-BSSID element
+ * @bss: the BSS to parse this as, for multi-BSSID cases this can
+ *	represent a non-transmitting BSS in which case the data
+ *	for that non-transmitting BSS is returned
  */
 struct ieee80211_elems_parse_params {
 	const u8 *start;
@@ -2158,8 +2157,7 @@ struct ieee80211_elems_parse_params {
 	bool action;
 	u64 filter;
 	u32 crc;
-	const u8 *transmitter_bssid;
-	const u8 *bss_bssid;
+	struct cfg80211_bss *bss;
 };
 
 struct ieee802_11_elems *
@@ -2168,8 +2166,7 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params);
 static inline struct ieee802_11_elems *
 ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 			   u64 filter, u32 crc,
-			   const u8 *transmitter_bssid,
-			   const u8 *bss_bssid)
+			   struct cfg80211_bss *bss)
 {
 	struct ieee80211_elems_parse_params params = {
 		.start = start,
@@ -2177,8 +2174,7 @@ ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 		.action = action,
 		.filter = filter,
 		.crc = crc,
-		.transmitter_bssid = transmitter_bssid,
-		.bss_bssid = bss_bssid,
+		.bss = bss,
 	};
 
 	return ieee802_11_parse_elems_full(&params);
@@ -2186,11 +2182,9 @@ ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 
 static inline struct ieee802_11_elems *
 ieee802_11_parse_elems(const u8 *start, size_t len, bool action,
-		       const u8 *transmitter_bssid,
-		       const u8 *bss_bssid)
+		       struct cfg80211_bss *bss)
 {
-	return ieee802_11_parse_elems_crc(start, len, action, 0, 0,
-					  transmitter_bssid, bss_bssid);
+	return ieee802_11_parse_elems_crc(start, len, action, 0, 0, bss);
 }
 
 
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index b656cb647763..6991c4c479da 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1256,8 +1256,7 @@ ieee80211_mesh_rx_probe_req(struct ieee80211_sub_if_data *sdata,
 	if (baselen > len)
 		return;
 
-	elems = ieee802_11_parse_elems(pos, len - baselen, false, mgmt->bssid,
-				       NULL);
+	elems = ieee802_11_parse_elems(pos, len - baselen, false, NULL);
 	if (!elems)
 		return;
 
@@ -1326,7 +1325,7 @@ static void ieee80211_mesh_rx_bcn_presp(struct ieee80211_sub_if_data *sdata,
 
 	elems = ieee802_11_parse_elems(mgmt->u.probe_resp.variable,
 				       len - baselen,
-				       false, mgmt->bssid, NULL);
+				       false, NULL);
 	if (!elems)
 		return;
 
@@ -1468,8 +1467,7 @@ static void mesh_rx_csa_frame(struct ieee80211_sub_if_data *sdata,
 	pos = mgmt->u.action.u.chan_switch.variable;
 	baselen = offsetof(struct ieee80211_mgmt,
 			   u.action.u.chan_switch.variable);
-	elems = ieee802_11_parse_elems(pos, len - baselen, true,
-				       mgmt->bssid, NULL);
+	elems = ieee802_11_parse_elems(pos, len - baselen, true, NULL);
 	if (!elems)
 		return;
 
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 45e7c1b307bc..b8fe13777cbe 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -927,7 +927,7 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 
 	baselen = (u8 *) mgmt->u.action.u.mesh_action.variable - (u8 *) mgmt;
 	elems = ieee802_11_parse_elems(mgmt->u.action.u.mesh_action.variable,
-				       len - baselen, false, mgmt->bssid, NULL);
+				       len - baselen, false, NULL);
 	if (!elems)
 		return;
 
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index d67011745048..84e3f43fd5c6 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -1229,8 +1229,7 @@ void mesh_rx_plink_frame(struct ieee80211_sub_if_data *sdata,
 		if (baselen > len)
 			return;
 	}
-	elems = ieee802_11_parse_elems(baseaddr, len - baselen, true,
-				       mgmt->bssid, NULL);
+	elems = ieee802_11_parse_elems(baseaddr, len - baselen, true, NULL);
 	mesh_process_plink_frame(sdata, mgmt, elems, rx_status);
 	kfree(elems);
 }
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 404edb975a2f..d4a54375b9d2 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3535,8 +3535,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		}
 
 		bss_elems = ieee802_11_parse_elems(bss_ies->data, bss_ies->len,
-						   false, mgmt->bssid,
-						   assoc_data->bss->bssid);
+						   false, assoc_data->bss);
 		if (!bss_elems) {
 			ret = false;
 			goto out;
@@ -3926,7 +3925,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	elems = ieee802_11_parse_elems(pos, len - (pos - (u8 *)mgmt), false,
-				       mgmt->bssid, assoc_data->bss->bssid);
+				       assoc_data->bss);
 	if (!elems)
 		goto notify_driver;
 
@@ -4251,8 +4250,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	if (ifmgd->assoc_data && ifmgd->assoc_data->need_beacon &&
 	    ieee80211_rx_our_beacon(bssid, ifmgd->assoc_data->bss)) {
 		elems = ieee802_11_parse_elems(variable, len - baselen, false,
-					       bssid,
-					       ifmgd->assoc_data->bss->bssid);
+					       ifmgd->assoc_data->bss);
 		if (!elems)
 			return;
 
@@ -4320,7 +4318,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 		ncrc = crc32_be(0, (void *)&mgmt->u.beacon.beacon_int, 4);
 	elems = ieee802_11_parse_elems_crc(variable, len - baselen,
 					   false, care_about_ies, ncrc,
-					   mgmt->bssid, bssid);
+					   link->u.mgd.bss);
 	if (!elems)
 		return;
 	ncrc = elems->crc;
@@ -4565,7 +4563,7 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 			/* CSA IE cannot be overridden, no need for BSSID */
 			elems = ieee802_11_parse_elems(
 					mgmt->u.action.u.chan_switch.variable,
-					ies_len, true, mgmt->bssid, NULL);
+					ies_len, true, NULL);
 
 			if (elems && !elems->parse_error)
 				ieee80211_sta_process_chanswitch(link,
@@ -4589,7 +4587,7 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 			 */
 			elems = ieee802_11_parse_elems(
 					mgmt->u.action.u.ext_chan_switch.variable,
-					ies_len, true, mgmt->bssid, NULL);
+					ies_len, true, NULL);
 
 			if (elems && !elems->parse_error) {
 				/* for the handling code pretend it was an IE */
@@ -5444,8 +5442,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	rcu_read_lock();
 
 	ies = rcu_dereference(cbss->ies);
-	elems = ieee802_11_parse_elems(ies->data, ies->len, false,
-				       NULL, NULL);
+	elems = ieee802_11_parse_elems(ies->data, ies->len, false, cbss);
 	if (!elems) {
 		rcu_read_unlock();
 		return -ENOMEM;
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index f80284eee055..fa8ddf576bc1 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -209,8 +209,7 @@ ieee80211_bss_info_update(struct ieee80211_local *local,
 	if (baselen > len)
 		return NULL;
 
-	elems = ieee802_11_parse_elems(elements, len - baselen, false,
-				       mgmt->bssid, cbss->bssid);
+	elems = ieee802_11_parse_elems(elements, len - baselen, false, cbss);
 	if (!elems)
 		return NULL;
 
@@ -221,16 +220,21 @@ ieee80211_bss_info_update(struct ieee80211_local *local,
 
 	bss = (void *)cbss->priv;
 	ieee80211_update_bss_from_elems(local, bss, elems, rx_status, beacon);
+	kfree(elems);
 
 	list_for_each_entry(non_tx_cbss, &cbss->nontrans_list, nontrans_list) {
 		non_tx_bss = (void *)non_tx_cbss->priv;
 
+		elems = ieee802_11_parse_elems(elements, len - baselen, false,
+					       non_tx_cbss);
+		if (!elems)
+			continue;
+
 		ieee80211_update_bss_from_elems(local, non_tx_bss, elems,
 						rx_status, beacon);
+		kfree(elems);
 	}
 
-	kfree(elems);
-
 	return bss;
 }
 
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index e7bdcdb488e2..36bfc54b3d2d 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1720,7 +1720,7 @@ ieee80211_process_tdls_channel_switch_resp(struct ieee80211_sub_if_data *sdata,
 	}
 
 	elems = ieee802_11_parse_elems(tf->u.chan_switch_resp.variable,
-				       skb->len - baselen, false, NULL, NULL);
+				       skb->len - baselen, false, NULL);
 	if (!elems) {
 		ret = -ENOMEM;
 		goto out;
@@ -1838,7 +1838,7 @@ ieee80211_process_tdls_channel_switch_req(struct ieee80211_sub_if_data *sdata,
 	}
 
 	elems = ieee802_11_parse_elems(tf->u.chan_switch_req.variable,
-				       skb->len - baselen, false, NULL, NULL);
+				       skb->len - baselen, false, NULL);
 	if (!elems)
 		return -ENOMEM;
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index f7c127a434b8..1de6b6256acc 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1422,15 +1422,14 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 
 static size_t ieee802_11_find_bssid_profile(const u8 *start, size_t len,
 					    struct ieee802_11_elems *elems,
-					    const u8 *transmitter_bssid,
-					    const u8 *bss_bssid,
+					    struct cfg80211_bss *bss,
 					    u8 *nontransmitted_profile)
 {
 	const struct element *elem, *sub;
 	size_t profile_len = 0;
 	bool found = false;
 
-	if (!bss_bssid || !transmitter_bssid)
+	if (!bss || !bss->transmitted_bss)
 		return profile_len;
 
 	for_each_element_id(elem, WLAN_EID_MULTIPLE_BSSID, start, len) {
@@ -1472,11 +1471,11 @@ static size_t ieee802_11_find_bssid_profile(const u8 *start, size_t len,
 				continue;
 			}
 
-			cfg80211_gen_new_bssid(transmitter_bssid,
+			cfg80211_gen_new_bssid(bss->transmitted_bss->bssid,
 					       elem->data[0],
 					       index[2],
 					       new_bssid);
-			if (ether_addr_equal(new_bssid, bss_bssid)) {
+			if (ether_addr_equal(new_bssid, bss->bssid)) {
 				found = true;
 				elems->bssid_index_len = index[1];
 				elems->bssid_index = (void *)&index[2];
@@ -1506,9 +1505,7 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 	if (nontransmitted_profile) {
 		nontransmitted_profile_len =
 			ieee802_11_find_bssid_profile(params->start, params->len,
-						      elems,
-						      params->transmitter_bssid,
-						      params->bss_bssid,
+						      elems, params->bss,
 						      nontransmitted_profile);
 		non_inherit =
 			cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
-- 
2.36.1

