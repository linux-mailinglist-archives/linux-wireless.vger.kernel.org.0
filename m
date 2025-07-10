Return-Path: <linux-wireless+bounces-25216-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB076B00B69
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 20:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC461CA3A26
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30F92FCFD1;
	Thu, 10 Jul 2025 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dD8ShzxC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A882FD582
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172150; cv=none; b=CvViigojHIkW4NzMzn9h2i4ezZbLZHZeh9AwKHvoSGK0Qel8XeaDwmzSoMWHSPGyidJBdYLYQ9M8byb3YLYxg6BW3jne1Q3jw4VXQYjiQc6XMwM4pip42HcskZGJDGCZvENyye4gEYULieuyAEcENutbw3Iz/tMQayqnq+I3Xqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172150; c=relaxed/simple;
	bh=0ppVBZ25RYJSjKTh+VE/EtmtAl/pl7P2Xwo2TjDXrmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FCzMJp/y8XuWSIracnvjfREKK/Cv+kzhdc6FqDgYOStr48uCOvsxWQKQBonXkaUlTM/46Ux/PxYaOYZwtJJruThKfG4YA5J2xNRxNjfYuyqVDcThDv8XoISgbzxJzbEDPFdNvUc1XsL0gl/vv7LnD+0Sw5lE3FsOJiOaHKiKaXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dD8ShzxC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752172149; x=1783708149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0ppVBZ25RYJSjKTh+VE/EtmtAl/pl7P2Xwo2TjDXrmA=;
  b=dD8ShzxCSb2Dphq7MBmnLxgYzav+gg0Wxxue6dOkiBAuCdzFic3Lhhbs
   +dFi+eq2OWTHTTvAIXkcJky2kmNGBCcWI9DlFNL1+5xQgFPUiE4hGQU5J
   LSxl6chgglcD70TrYXDMbnEL+waXvGSzuI5ZosMR04N0aq6W1iY87Ux7l
   Clcg3bqsD5MMu2KqsChFAySdHquDYMWYU0tfqh691VB2FOgaz6nrf8Djk
   JSX3Sl9Q5EuD6/PQUe7PWDC1pdEwf0U+BoBlheAWfwv6QwZVfyZ0heozy
   9ZYOGKjefPv6CNgzU9E6IqyizvDGIM22AfnuP9dSuePdU0EOePlHCRigk
   A==;
X-CSE-ConnectionGUID: NWQ80oIDTYu88kKC8vlLpA==
X-CSE-MsgGUID: 2SsuvhYPQvKRbmfjTdNVVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="57077811"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="57077811"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:29:09 -0700
X-CSE-ConnectionGUID: 697MKIkHQgm31EDpy0bWQQ==
X-CSE-MsgGUID: SpGJO9nNS9OqGlyC1dXAog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="160718745"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:29:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: mvm: don't remove all keys in mcast rekey
Date: Thu, 10 Jul 2025 21:28:29 +0300
Message-Id: <20250710212632.10091484e38e.I45daf089189f606f3879ca4538fb46303d761710@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
References: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

In the current code, if there was a rekey, we remove all the existing keys
from mac80211, then re-add the ones that the FW sent with
ieee80211_gtk_rekey_add, (newer FW will send also the existing GTKs/BIGTKs)
and then update the sequence number.

Instead of removing and re-adding the existing keys for no good reason,
we can just update the sequence of all keys, also of the ones that are
going to be replaced, and update again after the replace.

This change is required because ieee80211_gtk_rekey_add is going to be
changed to lookup the cipher from the old key instead of receiving it as an
argument, and for this it will need the old key(s), so we can't remove all
keys.

Note that with this change, in case that a key that existed before wowlan
is replaced, mac80211 will now call the driver to remove the old key and
add the new one (as opposed the previous behaviour, in which the key was
removed by the driver itself).
Of course we don't want to run the set_key callbacks in this case, so just
return early.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 68 ++++++++-----------
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 ++
 2 files changed, 34 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index e6806ef56e73..8930f8e3c0de 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1795,17 +1795,8 @@ static void iwl_mvm_set_key_rx_seq(struct ieee80211_key_conf *key,
 		if (!status->gtk_seq[i].valid)
 			continue;
 
-		if (status->gtk_seq[i].key_id == key->keyidx) {
-			s8 new_key_id = -1;
-
-			if (status->num_of_gtk_rekeys)
-				new_key_id = status->gtk[0].flags &
-						IWL_WOWLAN_GTK_IDX_MASK;
-
-			/* Don't install a new key's value to an old key */
-			if (new_key_id != key->keyidx)
-				iwl_mvm_set_key_rx_seq_idx(key, status, i);
-		}
+		if (status->gtk_seq[i].key_id == key->keyidx)
+			iwl_mvm_set_key_rx_seq_idx(key, status, i);
 	}
 }
 
@@ -1894,17 +1885,10 @@ iwl_mvm_d3_update_igtk_bigtk(struct iwl_wowlan_status_data *status,
 			     struct ieee80211_key_conf *key,
 			     struct iwl_multicast_key_data *key_data)
 {
-	if (status->num_of_gtk_rekeys && key_data->len) {
-		/* remove rekeyed key */
-		ieee80211_remove_key(key);
-	} else {
-		struct ieee80211_key_seq seq;
+	struct ieee80211_key_seq seq;
 
-		iwl_mvm_d3_set_igtk_bigtk_ipn(key_data,
-					      &seq,
-					      key->cipher);
-		ieee80211_set_key_rx_seq(key, 0, &seq);
-	}
+	iwl_mvm_d3_set_igtk_bigtk_ipn(key_data, &seq, key->cipher);
+	ieee80211_set_key_rx_seq(key, 0, &seq);
 }
 
 static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
@@ -1945,18 +1929,13 @@ static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
 			return;
 		}
 		keyidx = key->keyidx;
-		/* The current key is always sent by the FW, even if it wasn't
-		 * rekeyed during D3.
-		 * We remove an existing key if it has the same index as
-		 * a new key
+		/*
+		 * Update the seq even if there was a rekey. If there was a
+		 * rekey, we will update again after replacing the key
 		 */
-		if (status->num_of_gtk_rekeys &&
-		    ((status->gtk[0].len && keyidx == status->gtk[0].id) ||
-		     (status->gtk[1].len && keyidx == status->gtk[1].id))) {
-			ieee80211_remove_key(key);
-		} else {
-			iwl_mvm_set_key_rx_seq(key, data->status);
-		}
+		if ((status->gtk[0].len && keyidx == status->gtk[0].id) ||
+		    (status->gtk[1].len && keyidx == status->gtk[1].id))
+			iwl_mvm_set_key_rx_seq(key, status);
 		break;
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
@@ -2020,8 +1999,12 @@ static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
 		       sizeof(status->gtk[i].key));
 
 		key = ieee80211_gtk_rekey_add(vif, conf, link_id);
-		if (IS_ERR(key))
+		if (IS_ERR(key)) {
+			/* FW may send also the old keys */
+			if (PTR_ERR(key) == -EALREADY)
+				continue;
 			return false;
+		}
 
 		for (j = 0; j < ARRAY_SIZE(status->gtk_seq); j++) {
 			if (!status->gtk_seq[j].valid ||
@@ -2041,14 +2024,16 @@ iwl_mvm_d3_igtk_bigtk_rekey_add(struct iwl_wowlan_status_data *status,
 				struct ieee80211_vif *vif, u32 cipher,
 				struct iwl_multicast_key_data *key_data)
 {
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	DEFINE_RAW_FLEX(struct ieee80211_key_conf, conf, key,
 			WOWLAN_KEY_MAX_SIZE);
 	struct ieee80211_key_conf *key_config;
 	struct ieee80211_key_seq seq;
 	int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
+	s8 keyidx = key_data->id;
 
 	conf->cipher = cipher;
-	conf->keyidx = key_data->id;
+	conf->keyidx = keyidx;
 
 	if (!key_data->len)
 		return true;
@@ -2075,19 +2060,26 @@ iwl_mvm_d3_igtk_bigtk_rekey_add(struct iwl_wowlan_status_data *status,
 	memcpy(conf->key, key_data->key, conf->keylen);
 
 	key_config = ieee80211_gtk_rekey_add(vif, conf, link_id);
-	if (IS_ERR(key_config))
-		return false;
+	if (IS_ERR(key_config)) {
+		/* FW may send also the old keys */
+		return PTR_ERR(key_config) == -EALREADY;
+	}
 	ieee80211_set_key_rx_seq(key_config, 0, &seq);
 
-	if (key_config->keyidx == 4 || key_config->keyidx == 5) {
-		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	if (keyidx == 4 || keyidx == 5) {
 		struct iwl_mvm_vif_link_info *mvm_link;
 
 		link_id = link_id < 0 ? 0 : link_id;
 		mvm_link = mvmvif->link[link_id];
+		if (mvm_link->igtk)
+			mvm_link->igtk->hw_key_idx = STA_KEY_IDX_INVALID;
 		mvm_link->igtk = key_config;
 	}
 
+	if (vif->type == NL80211_IFTYPE_STATION && (keyidx == 6 || keyidx == 7))
+		rcu_assign_pointer(mvmvif->bcn_prot.keys[keyidx - 6],
+				   key_config);
+
 	return true;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index c16946950a8a..28a4630964d6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4612,6 +4612,10 @@ int iwl_mvm_mac_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
+	/* When resuming from wowlan, FW already knows about the newest keys */
+	if (test_bit(IWL_MVM_STATUS_IN_D3, &mvm->status))
+		return 0;
+
 	guard(mvm)(mvm);
 	return __iwl_mvm_mac_set_key(hw, cmd, vif, sta, key);
 }
-- 
2.34.1


