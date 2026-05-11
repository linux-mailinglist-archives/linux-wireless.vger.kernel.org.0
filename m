Return-Path: <linux-wireless+bounces-36251-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLuwFiYVAmrangEAu9opvQ
	(envelope-from <linux-wireless+bounces-36251-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 19:43:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B1F513A90
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 19:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F24430888DE
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 17:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C6D466B59;
	Mon, 11 May 2026 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3C+jOkb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA34466B6E
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521022; cv=none; b=GAmTVibkitS0PQYchxorz/MjHnnIxSG41S3P7B/wDgJhVcMC45K01SsTvo3WE2Zyz9JOYHyiVCJQ2TwCcI9BLUr0OD/oFPl2yFLqACecwysRXrK3k64kj97xOe7dgySYB/0n7V7H9Y/3Ofxv7s8BpVct+/dwiG4NBBC3RLbf0Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521022; c=relaxed/simple;
	bh=GpbTackrbkwDs5Fk3ejtxTJ0IAOtXAEwOkt+IADtbqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gQXc92Kue53UQ7O/lUggroJpiU1PDukBLGCt6moIBU7z3xg7i2uqOnDuLQDoWK0UAt4uQYlL/KT2vn47UDQRXzBQoOISznW51SF3DEqQmhhVcyzI8CfE0967lMtHIEo+Q75BAHXBddtiflgLytIaOfRJ2rtAp8bA7+4vkIc4qWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3C+jOkb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778521021; x=1810057021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GpbTackrbkwDs5Fk3ejtxTJ0IAOtXAEwOkt+IADtbqM=;
  b=i3C+jOkbUJjw9W6mN4wzhC8BGpaLZz9VMjo5mU5/rn92ech8mpBnJUIN
   Re/KP5WcnwgCPq7iUhLeC+z/pPmx2cz8ZZSTy4Q4lNSUzoUb3P8cLxmiS
   Y8oCcNmtK6m108hoWHjgm5RTzIXowADOkSRbSvQ0WSb22TXdkQEEL3WVH
   ddt6nWnE0iLVzK1txKDmafLF6Lvw4DRT87EBMmgc9O4Q7hBOStQxp4IcB
   UsxO15yVLGzv80gpacsGeYGhLm+tY063ouvKfT3T4olHJPqayDV4Spdqw
   Jl1x5tUmreRpOJj9wVceUhmmIBWZeg/0fElukeNz8T0FOn9VyfRVRGuO6
   g==;
X-CSE-ConnectionGUID: vGmGHH2OTNSzNlRvONKRsg==
X-CSE-MsgGUID: wi7kHxQfRmyvzPJKoRKQCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79314827"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79314827"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:37:01 -0700
X-CSE-ConnectionGUID: FWM07MQiQVOiuKc9fa6gOA==
X-CSE-MsgGUID: q+LMX01AQryD8lBF8R7oXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="261004833"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:36:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: mld: track TX/RX IGTKs separately
Date: Mon, 11 May 2026 20:36:26 +0300
Message-Id: <20260511203428.8fa6859b185d.I584e8b9d238f0b9ef6b65f95114c255209d1c2a3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511173631.1067831-1-miriam.rachel.korenblit@intel.com>
References: <20260511173631.1067831-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A4B1F513A90
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36251-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

Due to FW/HW limitations and the MME being at the end of the
frame, the devices only support a single IGTK for RX. For TX
multiple aren't needed, only the latest will be used, but in
the device there are space restrictions, so we can also only
install one.

For NAN, however, we will have one for RX for each peer, and
one for ourselves to transmit with.

Separate out the tracking of IGTK: instead of being per link
make the TX ones per link and the RX ones per (link) station.

Note that we currently hardcode that the FW can only have two
(IWL_MAX_NUM_IGTKS) IGTKs, which won't be sufficient for NAN
with security, concurrently with BSS.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   | 20 ++--
 .../net/wireless/intel/iwlwifi/mld/iface.h    | 15 +++
 drivers/net/wireless/intel/iwlwifi/mld/key.c  | 98 ++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/mld/link.h |  9 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.h  |  4 +
 5 files changed, 97 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index ef98efc8fb1b..c44f02f225ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 #include "mld.h"
 
@@ -951,19 +951,25 @@ iwl_mld_add_mcast_rekey(struct ieee80211_vif *vif,
 
 	iwl_mld_update_mcast_rx_seq(key_config, key_data);
 
-	/* The FW holds only one igtk so we keep track of the valid one */
+	/* The FW holds only one IGTK so we keep track of the valid one */
 	if (key_config->keyidx == 4 || key_config->keyidx == 5) {
-		struct iwl_mld_link *mld_link =
-			iwl_mld_link_from_mac80211(link_conf);
+		struct iwl_mld_link_sta *mld_ap_link_sta;
+
+		mld_ap_link_sta = iwl_mld_get_ap_link_sta(vif,
+							  link_conf->link_id);
+		if (WARN_ON(!mld_ap_link_sta))
+			return;
 
 		/* If we had more than one rekey, mac80211 will tell us to
 		 * remove the old and add the new so we will update the IGTK in
 		 * drv_set_key
 		 */
-		if (mld_link->igtk && mld_link->igtk != key_config) {
+		if (mld_ap_link_sta->rx_igtk &&
+		    mld_ap_link_sta->rx_igtk != key_config) {
 			/* mark the old IGTK as not in FW */
-			mld_link->igtk->hw_key_idx = STA_KEY_IDX_INVALID;
-			mld_link->igtk = key_config;
+			mld_ap_link_sta->rx_igtk->hw_key_idx =
+				STA_KEY_IDX_INVALID;
+			mld_ap_link_sta->rx_igtk = key_config;
 		}
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index ce4f8ca885cf..147ff6787ed9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -289,4 +289,19 @@ static inline bool iwl_mld_vif_low_latency(const struct iwl_mld_vif *mld_vif)
 
 struct ieee80211_vif *iwl_mld_get_bss_vif(struct iwl_mld *mld);
 
+static inline struct iwl_mld_link_sta *
+iwl_mld_get_ap_link_sta(struct ieee80211_vif *vif, int link_id)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct ieee80211_sta *ap_sta = mld_vif->ap_sta;
+	struct iwl_mld_sta *mld_ap_sta;
+
+	if (!ap_sta)
+		return NULL;
+
+	mld_ap_sta = iwl_mld_sta_from_mac80211(ap_sta);
+
+	return iwl_mld_link_sta_dereference_check(mld_ap_sta, link_id);
+}
+
 #endif /* __iwl_mld_iface_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/key.c b/drivers/net/wireless/intel/iwlwifi/mld/key.c
index 2cb312ebd7a7..944d5487c110 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/key.c
@@ -170,34 +170,69 @@ static void iwl_mld_remove_key_from_fw(struct iwl_mld *mld, u32 sta_mask,
 	iwl_mld_send_cmd_pdu(mld, WIDE_ID(DATA_PATH_GROUP, SEC_KEY_CMD), &cmd);
 }
 
+static struct ieee80211_key_conf **
+iwl_mld_get_igtk_ptr(struct ieee80211_vif *vif,
+		     struct ieee80211_sta *sta,
+		     struct ieee80211_key_conf *key)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	/* key's link ID is set to -1 for non-MLO */
+	int link_id = key->link_id < 0 ? 0 : key->link_id;
+	struct iwl_mld_link_sta *mld_ap_link_sta;
+	struct iwl_mld_link *mld_link;
+	struct iwl_mld_sta *mld_sta;
+
+	if (key->keyidx != 4 && key->keyidx != 5)
+		return NULL;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_STATION:
+		if (WARN_ON(!sta))
+			return NULL;
+
+		mld_sta = iwl_mld_sta_from_mac80211(sta);
+		mld_ap_link_sta = iwl_mld_link_sta_dereference_check(mld_sta,
+								     link_id);
+		if (WARN_ON(!mld_ap_link_sta))
+			return NULL;
+
+		return &mld_ap_link_sta->rx_igtk;
+	case NL80211_IFTYPE_NAN:
+		if (sta) {
+			mld_sta = iwl_mld_sta_from_mac80211(sta);
+
+			return &mld_sta->deflink.rx_igtk;
+		}
+
+		return &mld_vif->deflink.tx_igtk;
+	case NL80211_IFTYPE_AP:
+		mld_link = iwl_mld_link_dereference_check(mld_vif, link_id);
+		if (WARN_ON(!mld_link))
+			return NULL;
+
+		return &mld_link->tx_igtk;
+	default:
+		WARN_ONCE(1, "invalid iftype %d for IGTK\n", vif->type);
+		return NULL;
+	}
+}
+
 void iwl_mld_remove_key(struct iwl_mld *mld, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta,
 			struct ieee80211_key_conf *key)
 {
 	u32 sta_mask = iwl_mld_get_key_sta_mask(mld, vif, sta, key);
 	u32 key_flags = iwl_mld_get_key_flags(mld, vif, sta, key);
-	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct ieee80211_key_conf **igtk_ptr;
 
 	lockdep_assert_wiphy(mld->wiphy);
 
 	if (!sta_mask)
 		return;
 
-	if (key->keyidx == 4 || key->keyidx == 5) {
-		struct iwl_mld_link *mld_link;
-		unsigned int link_id = 0;
-
-		/* set to -1 for non-MLO right now */
-		if (key->link_id >= 0)
-			link_id = key->link_id;
-
-		mld_link = iwl_mld_link_dereference_check(mld_vif, link_id);
-		if (WARN_ON(!mld_link))
-			return;
-
-		if (mld_link->igtk == key)
-			mld_link->igtk = NULL;
-
+	igtk_ptr = iwl_mld_get_igtk_ptr(vif, sta, key);
+	if (igtk_ptr && *igtk_ptr == key) {
+		*igtk_ptr = NULL;
 		mld->num_igtks--;
 	}
 
@@ -214,9 +249,7 @@ int iwl_mld_add_key(struct iwl_mld *mld,
 {
 	u32 sta_mask = iwl_mld_get_key_sta_mask(mld, vif, sta, key);
 	u32 key_flags = iwl_mld_get_key_flags(mld, vif, sta, key);
-	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
-	struct iwl_mld_link *mld_link = NULL;
-	bool igtk = key->keyidx == 4 || key->keyidx == 5;
+	struct ieee80211_key_conf **igtk_ptr;
 	int ret;
 
 	lockdep_assert_wiphy(mld->wiphy);
@@ -224,36 +257,25 @@ int iwl_mld_add_key(struct iwl_mld *mld,
 	if (!sta_mask)
 		return -EINVAL;
 
-	if (igtk) {
+	igtk_ptr = iwl_mld_get_igtk_ptr(vif, sta, key);
+	if (igtk_ptr) {
 		if (mld->num_igtks == IWL_MAX_NUM_IGTKS)
 			return -EOPNOTSUPP;
 
-		u8 link_id = 0;
-
-		/* set to -1 for non-MLO right now */
-		if (key->link_id >= 0)
-			link_id = key->link_id;
-
-		mld_link = iwl_mld_link_dereference_check(mld_vif, link_id);
-
-		if (WARN_ON(!mld_link))
-			return -EINVAL;
-
-		if (mld_link->igtk) {
+		if (*igtk_ptr) {
 			IWL_DEBUG_MAC80211(mld, "remove old IGTK %d\n",
-					   mld_link->igtk->keyidx);
-			iwl_mld_remove_key(mld, vif, sta, mld_link->igtk);
+					   (*igtk_ptr)->keyidx);
+			iwl_mld_remove_key(mld, vif, sta, *igtk_ptr);
 		}
-
-		WARN_ON(mld_link->igtk);
 	}
 
 	ret = iwl_mld_add_key_to_fw(mld, sta_mask, key_flags, key);
 	if (ret)
 		return ret;
 
-	if (mld_link) {
-		mld_link->igtk = key;
+	if (igtk_ptr) {
+		WARN_ON(*igtk_ptr);
+		*igtk_ptr = key;
 		mld->num_igtks++;
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.h b/drivers/net/wireless/intel/iwlwifi/mld/link.h
index 84d9a24134a8..2b3e6b55367f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 #ifndef __iwl_mld_link_h__
 #define __iwl_mld_link_h__
@@ -34,8 +34,9 @@ struct iwl_probe_resp_data {
  * @chan_ctx: pointer to the channel context assigned to the link. If a link
  *	has an assigned channel context it means that it is active.
  * @he_ru_2mhz_block: 26-tone RU OFDMA transmissions should be blocked.
- * @igtk: fw can only have one IGTK at a time, whereas mac80211 can have two.
- *	This tracks the one IGTK that currently exists in FW.
+ * @tx_igtk: FW can only have one IGTK per MAC at a time, whereas mac80211 can
+ *	have two. This tracks the one IGTK that currently exists in FW, for TX
+ *	purposes. The RX IGTKs are tracked per station.
  * @bigtks: BIGTKs of the AP. Only valid for STA mode.
  * @bcast_sta: station used for broadcast packets. Used in AP, GO and IBSS.
  * @mcast_sta: station used for multicast packets. Used in AP, GO and IBSS.
@@ -60,7 +61,7 @@ struct iwl_mld_link {
 		struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
 		struct ieee80211_chanctx_conf __rcu *chan_ctx;
 		bool he_ru_2mhz_block;
-		struct ieee80211_key_conf *igtk;
+		struct ieee80211_key_conf *tx_igtk;
 		struct ieee80211_key_conf __rcu *bigtks[2];
 	);
 	/* And here fields that survive a fw restart */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.h b/drivers/net/wireless/intel/iwlwifi/mld/sta.h
index 13644ffd185d..dff14ff0a5af 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.h
@@ -28,6 +28,9 @@ struct iwl_mld_rxq_dup_data {
  * This represents the link-level sta - the driver level equivalent to the
  * ieee80211_link_sta
  *
+ * @rx_igtk: FW can only have one IGTK for RX at a time, whereas mac80211 will
+ *	have two. This tracks the one IGTK that currently exists in FW, to
+ *	remove it there when a new one is installed.
  * @last_rate_n_flags: rate_n_flags from the last &iwl_tlc_update_notif
  * @signal_avg: the signal average coming from the firmware
  * @in_fw: whether the link STA is uploaded to the FW (false during restart)
@@ -37,6 +40,7 @@ struct iwl_mld_rxq_dup_data {
 struct iwl_mld_link_sta {
 	/* Add here fields that need clean up on restart */
 	struct_group(zeroed_on_hw_restart,
+		struct ieee80211_key_conf *rx_igtk;
 		u32 last_rate_n_flags;
 		bool in_fw;
 		s8 signal_avg;
-- 
2.34.1


