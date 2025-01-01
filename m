Return-Path: <linux-wireless+bounces-16966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 984319FF2E1
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 06:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBDBB7A14E0
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 05:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0865BF513;
	Wed,  1 Jan 2025 05:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R0WIkmlT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129A5EED6
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jan 2025 05:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735707978; cv=none; b=q+3ypranNvxO954GInUFv6AjNo2jMrP322ipeOeFHGx0jv8duikUnZ/XKgE2q+jU4FZFC2jOWsGn17FgZLKQydnkiSKiLKGuBoDau57sUW9IE4moJTQcA4tHSAjvwKL8uYVoZjS0aWLesbt9ZwXlkGBLF4J22JZn5G7SbaJoci8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735707978; c=relaxed/simple;
	bh=LkIJCXJHnYSEoFCjupiqXHIsDyxuwGPR0ieCrjDZWus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WKVXKfe2VlYzmrWz/lA4QQ7A+TIml4PLfh8Aq2gDw5KOXMMWdUA728hlr4Ldbx5YrkXYU/dHjUYFyoW+WjKMs3wL0jTaCeLSRxTw0AEsU/h8aP6tyL68c4/aQbKNFktCy/SnLHAacvi72p3H/vQq2zRWFPFWK7lEBlPrGFVbNig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R0WIkmlT; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735707977; x=1767243977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LkIJCXJHnYSEoFCjupiqXHIsDyxuwGPR0ieCrjDZWus=;
  b=R0WIkmlT+uHk+WYXK06qJtsT8OY9XcstTxS0gTTlwiGkbK1wFbMHFIdx
   xWwALygle6oic56PESe7gx52zz9wfmsGgcWonDD17WNe1yCksCF35f7Ip
   Loxek6dY9fdU4YAjiUHfSQtEcQ09PWZ8VlXpILGQ/qIsCQyDy92BKK1vc
   WjvodEn3bwE99mS0/Pjid2LUdK4+jiEgf9ltaWbQ82N6ior9C7kjhdIH2
   IFkqlKpR4MEXsNqRlyFG9yOAKpKSZFlgDuPhhoHA6HJfwi8alEfzdjCa0
   WFcdlLYNpxmynG0tZrHrd/yl11YMHILp9TDWv/hGCzuB7tVoRDu5YkGon
   A==;
X-CSE-ConnectionGUID: 1vPblFDvS3uWkxdD9DOLQw==
X-CSE-MsgGUID: b0IF9mBESOiZ9MitL2SQNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="36194444"
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="36194444"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:17 -0800
X-CSE-ConnectionGUID: qIkl1THgTqKPNmFXjQRklQ==
X-CSE-MsgGUID: yF5cI8vrTKaLvYvD3h2RaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="101618942"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:16 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 16/19] wifi: mac80211: verify BSS membership selectors and basic rates
Date: Wed,  1 Jan 2025 07:05:36 +0200
Message-Id: <20250101070249.e58a0f34c798.Ifeb3bfd7b157ffa2ccdb20ca1cba6cf068fd117d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
References: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

We should not attempt a connection if the BSS we are connecting to
requires support for a basic rate or other feature using the BSS
membership selector. Add a check verifying this.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/ieee80211_i.h |   4 +
 net/mac80211/mlme.c        | 193 ++++++++++++++++++++++++-------------
 2 files changed, 132 insertions(+), 65 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a98133d5c362..8081607ccbd3 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -404,6 +404,8 @@ struct ieee80211_mgd_auth_data {
 	int tries;
 	u16 algorithm, expected_transaction;
 
+	unsigned long userspace_selectors[BITS_TO_LONGS(128)];
+
 	u8 key[WLAN_KEY_LEN_WEP104];
 	u8 key_len, key_idx;
 	bool done, waiting;
@@ -444,6 +446,8 @@ struct ieee80211_mgd_assoc_data {
 	const u8 *supp_rates;
 	u8 supp_rates_len;
 
+	unsigned long userspace_selectors[BITS_TO_LONGS(128)];
+
 	unsigned long timeout;
 	int tries;
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a1197ac68c98..9735ce4adffe 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -694,6 +694,63 @@ ieee80211_verify_sta_eht_mcs_support(struct ieee80211_sub_if_data *sdata,
 	return true;
 }
 
+static void ieee80211_get_rates(struct ieee80211_supported_band *sband,
+				const u8 *supp_rates,
+				unsigned int supp_rates_len,
+				u32 *rates, u32 *basic_rates,
+				unsigned long *unknown_rates_selectors,
+				bool *have_higher_than_11mbit,
+				int *min_rate, int *min_rate_index)
+{
+	int i, j;
+
+	for (i = 0; i < supp_rates_len; i++) {
+		int rate = supp_rates[i] & 0x7f;
+		bool is_basic = !!(supp_rates[i] & 0x80);
+
+		if ((rate * 5) > 110 && have_higher_than_11mbit)
+			*have_higher_than_11mbit = true;
+
+		/*
+		 * Skip membership selectors since they're not rates.
+		 *
+		 * Note: Even though the membership selector and the basic
+		 *	 rate flag share the same bit, they are not exactly
+		 *	 the same.
+		 */
+		if (is_basic && rate >= BSS_MEMBERSHIP_SELECTOR_MIN) {
+			if (unknown_rates_selectors)
+				set_bit(rate, unknown_rates_selectors);
+			continue;
+		}
+
+		for (j = 0; j < sband->n_bitrates; j++) {
+			struct ieee80211_rate *br;
+			int brate;
+
+			br = &sband->bitrates[j];
+
+			brate = DIV_ROUND_UP(br->bitrate, 5);
+			if (brate == rate) {
+				if (rates)
+					*rates |= BIT(j);
+				if (is_basic && basic_rates)
+					*basic_rates |= BIT(j);
+				if (min_rate && (rate * 5) < *min_rate) {
+					*min_rate = rate * 5;
+					if (min_rate_index)
+						*min_rate_index = j;
+				}
+				break;
+			}
+		}
+
+		/* Handle an unknown entry as if it is an unknown selector */
+		if (is_basic && unknown_rates_selectors && j == sband->n_bitrates)
+			set_bit(rate, unknown_rates_selectors);
+	}
+}
+
 static bool ieee80211_chandef_usable(struct ieee80211_sub_if_data *sdata,
 				     const struct cfg80211_chan_def *chandef,
 				     u32 prohibited_flags)
@@ -924,7 +981,8 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 			      struct ieee80211_conn_settings *conn,
 			      struct cfg80211_bss *cbss, int link_id,
 			      struct ieee80211_chan_req *chanreq,
-			      struct cfg80211_chan_def *ap_chandef)
+			      struct cfg80211_chan_def *ap_chandef,
+			      unsigned long *userspace_selectors)
 {
 	const struct cfg80211_bss_ies *ies = rcu_dereference(cbss->ies);
 	struct ieee80211_bss *bss = (void *)cbss->priv;
@@ -938,6 +996,8 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 	struct ieee802_11_elems *elems;
 	struct ieee80211_supported_band *sband;
 	enum ieee80211_conn_mode ap_mode;
+	unsigned long unknown_rates_selectors[BITS_TO_LONGS(128)] = {};
+	unsigned long sta_selectors[BITS_TO_LONGS(128)] = {};
 	int ret;
 
 again:
@@ -966,6 +1026,10 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 
 	sband = sdata->local->hw.wiphy->bands[channel->band];
 
+	ieee80211_get_rates(sband, elems->supp_rates, elems->supp_rates_len,
+			    NULL, NULL, unknown_rates_selectors, NULL, NULL,
+			    NULL);
+
 	switch (channel->band) {
 	case NL80211_BAND_S1GHZ:
 		if (WARN_ON(ap_mode != IEEE80211_CONN_MODE_S1G)) {
@@ -1016,6 +1080,29 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 
 	chanreq->oper = *ap_chandef;
 
+	bitmap_copy(sta_selectors, userspace_selectors, 128);
+	if (conn->mode >= IEEE80211_CONN_MODE_HT)
+		set_bit(BSS_MEMBERSHIP_SELECTOR_HT_PHY, sta_selectors);
+	if (conn->mode >= IEEE80211_CONN_MODE_VHT)
+		set_bit(BSS_MEMBERSHIP_SELECTOR_VHT_PHY, sta_selectors);
+	if (conn->mode >= IEEE80211_CONN_MODE_HE)
+		set_bit(BSS_MEMBERSHIP_SELECTOR_HE_PHY, sta_selectors);
+	if (conn->mode >= IEEE80211_CONN_MODE_EHT)
+		set_bit(BSS_MEMBERSHIP_SELECTOR_EHT_PHY, sta_selectors);
+
+	/*
+	 * We do not support EPD or GLK so never add them.
+	 * SAE_H2E is handled through userspace_selectors.
+	 */
+
+	/* Check if we support all required features */
+	if (!bitmap_subset(unknown_rates_selectors, sta_selectors, 128)) {
+		link_id_info(sdata, link_id,
+			     "required basic rate or BSS membership selectors not supported or disabled, rejecting connection\n");
+		ret = -EINVAL;
+		goto free;
+	}
+
 	ieee80211_set_chanreq_ap(sdata, chanreq, conn, ap_chandef);
 
 	while (!ieee80211_chandef_usable(sdata, &chanreq->oper,
@@ -4729,62 +4816,6 @@ static void ieee80211_rx_mgmt_disassoc(struct ieee80211_sub_if_data *sdata,
 				    false);
 }
 
-static void ieee80211_get_rates(struct ieee80211_supported_band *sband,
-				u8 *supp_rates, unsigned int supp_rates_len,
-				u32 *rates, u32 *basic_rates,
-				unsigned long *unknown_rates_selectors,
-				bool *have_higher_than_11mbit,
-				int *min_rate, int *min_rate_index)
-{
-	int i, j;
-
-	for (i = 0; i < supp_rates_len; i++) {
-		int rate = supp_rates[i] & 0x7f;
-		bool is_basic = !!(supp_rates[i] & 0x80);
-
-		if ((rate * 5) > 110 && have_higher_than_11mbit)
-			*have_higher_than_11mbit = true;
-
-		/*
-		 * Skip membership selectors since they're not rates.
-		 *
-		 * Note: Even though the membership selector and the basic
-		 *	 rate flag share the same bit, they are not exactly
-		 *	 the same.
-		 */
-		if (is_basic && rate >= BSS_MEMBERSHIP_SELECTOR_MIN) {
-			if (unknown_rates_selectors)
-				set_bit(rate, unknown_rates_selectors);
-			continue;
-		}
-
-		for (j = 0; j < sband->n_bitrates; j++) {
-			struct ieee80211_rate *br;
-			int brate;
-
-			br = &sband->bitrates[j];
-
-			brate = DIV_ROUND_UP(br->bitrate, 5);
-			if (brate == rate) {
-				if (rates)
-					*rates |= BIT(j);
-				if (is_basic && basic_rates)
-					*basic_rates |= BIT(j);
-				if (min_rate && (rate * 5) < *min_rate) {
-					*min_rate = rate * 5;
-					if (min_rate_index)
-						*min_rate_index = j;
-				}
-				break;
-			}
-		}
-
-		/* Handle an unknown entry as if it is an unknown selector */
-		if (is_basic && unknown_rates_selectors && j == sband->n_bitrates)
-			set_bit(rate, unknown_rates_selectors);
-	}
-}
-
 static bool ieee80211_twt_req_supported(struct ieee80211_sub_if_data *sdata,
 					struct ieee80211_supported_band *sband,
 					const struct link_sta_info *link_sta,
@@ -5650,7 +5681,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 				  struct ieee80211_link_data *link,
 				  int link_id,
 				  struct cfg80211_bss *cbss, bool mlo,
-				  struct ieee80211_conn_settings *conn)
+				  struct ieee80211_conn_settings *conn,
+				  unsigned long *userspace_selectors)
 {
 	struct ieee80211_local *local = sdata->local;
 	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
@@ -5663,7 +5695,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 
 	rcu_read_lock();
 	elems = ieee80211_determine_chan_mode(sdata, conn, cbss, link_id,
-					      &chanreq, &ap_chandef);
+					      &chanreq, &ap_chandef,
+					      userspace_selectors);
 
 	if (IS_ERR(elems)) {
 		rcu_read_unlock();
@@ -5857,7 +5890,8 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 			link->u.mgd.conn = assoc_data->link[link_id].conn;
 
 			err = ieee80211_prep_channel(sdata, link, link_id, cbss,
-						     true, &link->u.mgd.conn);
+						     true, &link->u.mgd.conn,
+						     assoc_data->userspace_selectors);
 			if (err) {
 				link_info(link, "prep_channel failed\n");
 				goto out_err;
@@ -8367,7 +8401,8 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 				     struct cfg80211_bss *cbss, s8 link_id,
 				     const u8 *ap_mld_addr, bool assoc,
 				     struct ieee80211_conn_settings *conn,
-				     bool override)
+				     bool override,
+				     unsigned long *userspace_selectors)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
@@ -8506,7 +8541,8 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 		 */
 		link->u.mgd.conn = *conn;
 		err = ieee80211_prep_channel(sdata, link, link->link_id, cbss,
-					     mlo, &link->u.mgd.conn);
+					     mlo, &link->u.mgd.conn,
+					     userspace_selectors);
 		if (err) {
 			if (new_sta)
 				sta_info_free(local, new_sta);
@@ -8622,6 +8658,22 @@ static bool ieee80211_mgd_csa_in_process(struct ieee80211_sub_if_data *sdata,
 	return ret;
 }
 
+static void ieee80211_parse_cfg_selectors(unsigned long *userspace_selectors,
+					  const u8 *supported_selectors,
+					  u8 supported_selectors_len)
+{
+	if (supported_selectors) {
+		for (int i = 0; i < supported_selectors_len; i++) {
+			set_bit(supported_selectors[i],
+				userspace_selectors);
+		}
+	} else {
+		/* Assume SAE_H2E support for backward compatibility. */
+		set_bit(BSS_MEMBERSHIP_SELECTOR_SAE_H2E,
+			userspace_selectors);
+	}
+}
+
 /* config hooks */
 int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 		       struct cfg80211_auth_request *req)
@@ -8723,6 +8775,10 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 		memcpy(auth_data->key, req->key, req->key_len);
 	}
 
+	ieee80211_parse_cfg_selectors(auth_data->userspace_selectors,
+				      req->supported_selectors,
+				      req->supported_selectors_len);
+
 	auth_data->algorithm = auth_alg;
 
 	/* try to authenticate/probe */
@@ -8776,7 +8832,8 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 
 	err = ieee80211_prep_connection(sdata, req->bss, req->link_id,
 					req->ap_mld_addr, cont_auth,
-					&conn, false);
+					&conn, false,
+					auth_data->userspace_selectors);
 	if (err)
 		goto err_clear;
 
@@ -9063,6 +9120,10 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 					    false);
 	}
 
+	ieee80211_parse_cfg_selectors(assoc_data->userspace_selectors,
+				      req->supported_selectors,
+				      req->supported_selectors_len);
+
 	memcpy(&ifmgd->ht_capa, &req->ht_capa, sizeof(ifmgd->ht_capa));
 	memcpy(&ifmgd->ht_capa_mask, &req->ht_capa_mask,
 	       sizeof(ifmgd->ht_capa_mask));
@@ -9309,7 +9370,8 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		/* only calculate the mode, hence link == NULL */
 		err = ieee80211_prep_channel(sdata, NULL, i,
 					     assoc_data->link[i].bss, true,
-					     &assoc_data->link[i].conn);
+					     &assoc_data->link[i].conn,
+					     assoc_data->userspace_selectors);
 		if (err) {
 			req->links[i].error = err;
 			goto err_clear;
@@ -9325,7 +9387,8 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	err = ieee80211_prep_connection(sdata, cbss, req->link_id,
 					req->ap_mld_addr, true,
 					&assoc_data->link[assoc_link_id].conn,
-					override);
+					override,
+					assoc_data->userspace_selectors);
 	if (err)
 		goto err_clear;
 
-- 
2.34.1


