Return-Path: <linux-wireless+bounces-25066-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D198AFDF26
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BDB5856BC
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F386520010C;
	Wed,  9 Jul 2025 05:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahOfWv7c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DC626B74E
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752038233; cv=none; b=XpGlExgqyUyJw7SWXWJAT0YczPKRdjwJKtqvrRcbQITuULA0HJxRTP/Q7U+T9UTMuOfe7IM9OitW/FVXkRXW3c4GqNwac+XxJj+BTJeSsTvcsw0oWXWiPWKkEcopxzZZqC9jsGSDWUfK+H4C6am7/o3Z97PCCuf0iBnMXx93jZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752038233; c=relaxed/simple;
	bh=++THLWso1lccu60dgEUlY4xzTMUNHv/420raC7Fc+GU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hA+0y3qfOo6oJqaU7Cc7NYfZuOuEKhiSWoYnnhA2Mf/VH1RnKJ6eH8U+TTFKX/q9J1g37EbMcxrGronIfiQsXfgUHxWZJ77HewfG5irIWWokFNirqRVQMAZBZvbTOnr/oLrke7BzVYgJBDay5sHlgmJMFN3iQgM6Xtn4zAOqmY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahOfWv7c; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752038232; x=1783574232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=++THLWso1lccu60dgEUlY4xzTMUNHv/420raC7Fc+GU=;
  b=ahOfWv7ctGl0xt8LRGYmoyXQ+uImmDcv0Hq7ZrryY5g7suj6l6hDLosq
   TTUEEPAKVomW8Xqaa+/xDYAOJ3u1W7/xtZSkX7AnnBzZhjEapL1RYZAeA
   WhS72yAl6O0VI2iVI54a6KstAjguNgTHiIbbF1snEcippap6rzRv3h61J
   TL21My/ivRravkQhTm3UnC3a/qGThnP6Xsm34+rZocrj4pZcOLvfBtNyK
   hHPBGWf6KUR380IX81EATQ9yB9RtEtAFCOlimgOBGsdKrpDD/Iqe3AuyO
   G5Y1F2bsTYbE5sdt4Z39hDtmLP9WqWLBHChHn2KNPMRvYexQLM00YGm++
   Q==;
X-CSE-ConnectionGUID: nQJ05uynQYKJ/R3e07L/Gw==
X-CSE-MsgGUID: DPhT+rGLRvew2mIa8xJYYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="58091179"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="58091179"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:17:12 -0700
X-CSE-ConnectionGUID: paCP3MP2RdubMrPJmomrkg==
X-CSE-MsgGUID: da4D5LmhTTiFyz7IbGcFxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161327891"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:17:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next v3 12/15] wifi: iwlwifi: mvm: remove MLO GTK rekey code
Date: Wed,  9 Jul 2025 08:16:31 +0300
Message-Id: <20250709081300.4957e50dee91.I2a432256dbc3069e0300e1f833e10a93d203f538@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709051634.866992-1-miriam.rachel.korenblit@intel.com>
References: <20250709051634.866992-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

iwlmvm driver does not support MLO. Remove this code

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 210 +-------------------
 1 file changed, 10 insertions(+), 200 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index e1070b891300..1af9e54a882d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1474,9 +1474,6 @@ struct iwl_wowlan_status_data {
 	struct iwl_multicast_key_data igtk;
 	struct iwl_multicast_key_data bigtk[WOWLAN_BIGTK_KEYS_NUM];
 
-	int num_mlo_keys;
-	struct iwl_wowlan_mlo_gtk mlo_keys[WOWLAN_MAX_MLO_KEYS];
-
 	u8 *wake_packet;
 };
 
@@ -1986,167 +1983,6 @@ static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
 	}
 }
 
-struct iwl_mvm_d3_mlo_old_keys {
-	u32 cipher[IEEE80211_MLD_MAX_NUM_LINKS][WOWLAN_MLO_GTK_KEY_NUM_TYPES];
-	struct ieee80211_key_conf *key[IEEE80211_MLD_MAX_NUM_LINKS][8];
-};
-
-static void iwl_mvm_mlo_key_ciphers(struct ieee80211_hw *hw,
-				    struct ieee80211_vif *vif,
-				    struct ieee80211_sta *sta,
-				    struct ieee80211_key_conf *key,
-				    void *data)
-{
-	struct iwl_mvm_d3_mlo_old_keys *old_keys = data;
-	enum iwl_wowlan_mlo_gtk_type key_type;
-
-	if (key->link_id < 0)
-		return;
-
-	if (WARN_ON(key->link_id >= IEEE80211_MLD_MAX_NUM_LINKS ||
-		    key->keyidx >= 8))
-		return;
-
-	if (WARN_ON(old_keys->key[key->link_id][key->keyidx]))
-		return;
-
-	switch (key->cipher) {
-	case WLAN_CIPHER_SUITE_CCMP:
-	case WLAN_CIPHER_SUITE_GCMP:
-	case WLAN_CIPHER_SUITE_GCMP_256:
-		key_type = WOWLAN_MLO_GTK_KEY_TYPE_GTK;
-		break;
-	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
-	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
-	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
-	case WLAN_CIPHER_SUITE_AES_CMAC:
-		if (key->keyidx == 4 || key->keyidx == 5) {
-			key_type = WOWLAN_MLO_GTK_KEY_TYPE_IGTK;
-			break;
-		} else if (key->keyidx == 6 || key->keyidx == 7) {
-			key_type = WOWLAN_MLO_GTK_KEY_TYPE_BIGTK;
-			break;
-		}
-		return;
-	default:
-		/* ignore WEP/TKIP or unknown ciphers */
-		return;
-	}
-
-	old_keys->cipher[key->link_id][key_type] = key->cipher;
-	old_keys->key[key->link_id][key->keyidx] = key;
-}
-
-static bool iwl_mvm_mlo_gtk_rekey(struct iwl_wowlan_status_data *status,
-				  struct ieee80211_vif *vif,
-				  struct iwl_mvm *mvm)
-{
-	int i;
-	struct iwl_mvm_d3_mlo_old_keys *old_keys;
-	bool ret = true;
-
-	IWL_DEBUG_WOWLAN(mvm, "Num of MLO Keys: %d\n", status->num_mlo_keys);
-	if (!status->num_mlo_keys)
-		return true;
-
-	old_keys = kzalloc(sizeof(*old_keys), GFP_KERNEL);
-	if (!old_keys)
-		return false;
-
-	/* find the cipher for each mlo key */
-	ieee80211_iter_keys(mvm->hw, vif, iwl_mvm_mlo_key_ciphers, old_keys);
-
-	for (i = 0; i < status->num_mlo_keys; i++) {
-		struct iwl_wowlan_mlo_gtk *mlo_key = &status->mlo_keys[i];
-		struct ieee80211_key_conf *key, *old_key;
-		struct ieee80211_key_seq seq;
-		DEFINE_RAW_FLEX(struct ieee80211_key_conf, conf, key,
-				WOWLAN_KEY_MAX_SIZE);
-		u16 flags = le16_to_cpu(mlo_key->flags);
-		int j, link_id, key_id, key_type;
-
-		link_id = u16_get_bits(flags, WOWLAN_MLO_GTK_FLAG_LINK_ID_MSK);
-		key_id = u16_get_bits(flags, WOWLAN_MLO_GTK_FLAG_KEY_ID_MSK);
-		key_type = u16_get_bits(flags,
-					WOWLAN_MLO_GTK_FLAG_KEY_TYPE_MSK);
-
-		if (!(vif->valid_links & BIT(link_id)))
-			continue;
-
-		if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS ||
-			    key_id >= 8 ||
-			    key_type >= WOWLAN_MLO_GTK_KEY_NUM_TYPES))
-			continue;
-
-		conf->cipher = old_keys->cipher[link_id][key_type];
-		/* WARN_ON? */
-		if (!conf->cipher)
-			continue;
-
-		conf->keylen = 0;
-		switch (conf->cipher) {
-		case WLAN_CIPHER_SUITE_CCMP:
-		case WLAN_CIPHER_SUITE_GCMP:
-			conf->keylen = WLAN_KEY_LEN_CCMP;
-			break;
-		case WLAN_CIPHER_SUITE_GCMP_256:
-			conf->keylen = WLAN_KEY_LEN_GCMP_256;
-			break;
-		case WLAN_CIPHER_SUITE_BIP_GMAC_128:
-			conf->keylen = WLAN_KEY_LEN_BIP_GMAC_128;
-			break;
-		case WLAN_CIPHER_SUITE_BIP_GMAC_256:
-			conf->keylen = WLAN_KEY_LEN_BIP_GMAC_256;
-			break;
-		case WLAN_CIPHER_SUITE_AES_CMAC:
-			conf->keylen = WLAN_KEY_LEN_AES_CMAC;
-			break;
-		case WLAN_CIPHER_SUITE_BIP_CMAC_256:
-			conf->keylen = WLAN_KEY_LEN_BIP_CMAC_256;
-			break;
-		}
-
-		if (WARN_ON(!conf->keylen ||
-			    conf->keylen > WOWLAN_KEY_MAX_SIZE))
-			continue;
-
-		memcpy(conf->key, mlo_key->key, conf->keylen);
-		conf->keyidx = key_id;
-
-		old_key = old_keys->key[link_id][key_id];
-		if (old_key) {
-			IWL_DEBUG_WOWLAN(mvm,
-					 "Remove MLO key id %d, link id %d\n",
-					 key_id, link_id);
-			ieee80211_remove_key(old_key);
-		}
-
-		IWL_DEBUG_WOWLAN(mvm, "Add MLO key id %d, link id %d\n",
-				 key_id, link_id);
-		key = ieee80211_gtk_rekey_add(vif, conf, link_id);
-		if (WARN_ON(IS_ERR(key))) {
-			ret = false;
-			goto out;
-		}
-
-		/*
-		 * mac80211 expects the pn in big-endian
-		 * also note that seq is a union of all cipher types
-		 * (ccmp, gcmp, cmac, gmac), and they all have the same
-		 * pn field (of length 6) so just copy it to ccmp.pn.
-		 */
-		for (j = 5; j >= 0; j--)
-			seq.ccmp.pn[5 - j] = mlo_key->pn[j];
-
-		/* group keys are non-QoS and use TID 0 */
-		ieee80211_set_key_rx_seq(key, 0, &seq);
-	}
-
-out:
-	kfree(old_keys);
-	return ret;
-}
-
 static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
 			      struct ieee80211_vif *vif,
 			      struct iwl_mvm *mvm, u32 gtk_cipher)
@@ -2346,9 +2182,6 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 				return false;
 		}
 
-		if (!iwl_mvm_mlo_gtk_rekey(status, vif, mvm))
-			return false;
-
 		ieee80211_gtk_rekey_notify(vif, vif->bss_conf.bssid,
 					   (void *)&replay_ctr, GFP_KERNEL);
 	}
@@ -2479,10 +2312,11 @@ static void iwl_mvm_parse_wowlan_info_notif(struct iwl_mvm *mvm,
 					    struct iwl_wowlan_status_data *status,
 					    u32 len)
 {
-	u32 expected_len = sizeof(*data) +
-		data->num_mlo_link_keys * sizeof(status->mlo_keys[0]);
+	if (IWL_FW_CHECK(mvm, data->num_mlo_link_keys,
+			 "MLO is not supported, shouldn't receive MLO keys\n"))
+		return;
 
-	if (len < expected_len) {
+	if (len < sizeof(*data)) {
 		IWL_ERR(mvm, "Invalid WoWLAN info notification!\n");
 		status = NULL;
 		return;
@@ -2511,33 +2345,21 @@ static void iwl_mvm_parse_wowlan_info_notif(struct iwl_mvm *mvm,
 		le32_to_cpu(data->num_of_gtk_rekeys);
 	status->received_beacons = le32_to_cpu(data->received_beacons);
 	status->tid_tear_down = data->tid_tear_down;
-
-	if (data->num_mlo_link_keys) {
-		status->num_mlo_keys = data->num_mlo_link_keys;
-		if (IWL_FW_CHECK(mvm,
-				 status->num_mlo_keys > WOWLAN_MAX_MLO_KEYS,
-				 "Too many mlo keys: %d, max %d\n",
-				 status->num_mlo_keys, WOWLAN_MAX_MLO_KEYS))
-			status->num_mlo_keys = WOWLAN_MAX_MLO_KEYS;
-		memcpy(status->mlo_keys, data->mlo_gtks,
-		       status->num_mlo_keys * sizeof(status->mlo_keys[0]));
-	}
 }
 
 static void
 iwl_mvm_parse_wowlan_info_notif_v4(struct iwl_mvm *mvm,
 				   struct iwl_wowlan_info_notif_v4 *data,
 				   struct iwl_wowlan_status_data *status,
-				   u32 len, bool has_mlo_keys)
+				   u32 len)
 {
 	u32 i;
-	u32 expected_len = sizeof(*data);
 
-	if (has_mlo_keys)
-		expected_len += (data->num_mlo_link_keys *
-				 sizeof(status->mlo_keys[0]));
+	if (IWL_FW_CHECK(mvm, data->num_mlo_link_keys,
+			 "MLO is not supported, shouldn't receive MLO keys\n"))
+		return;
 
-	if (len < expected_len) {
+	if (len < sizeof(*data)) {
 		IWL_ERR(mvm, "Invalid WoWLAN info notification!\n");
 		status = NULL;
 		return;
@@ -2560,17 +2382,6 @@ iwl_mvm_parse_wowlan_info_notif_v4(struct iwl_mvm *mvm,
 		le32_to_cpu(data->num_of_gtk_rekeys);
 	status->received_beacons = le32_to_cpu(data->received_beacons);
 	status->tid_tear_down = data->tid_tear_down;
-
-	if (has_mlo_keys && data->num_mlo_link_keys) {
-		status->num_mlo_keys = data->num_mlo_link_keys;
-		if (IWL_FW_CHECK(mvm,
-				 status->num_mlo_keys > WOWLAN_MAX_MLO_KEYS,
-				 "Too many mlo keys: %d, max %d\n",
-				 status->num_mlo_keys, WOWLAN_MAX_MLO_KEYS))
-			status->num_mlo_keys = WOWLAN_MAX_MLO_KEYS;
-		memcpy(status->mlo_keys, data->mlo_gtks,
-		       status->num_mlo_keys * sizeof(status->mlo_keys[0]));
-	}
 }
 
 static void
@@ -3321,8 +3132,7 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 				(void *)pkt->data;
 
 			iwl_mvm_parse_wowlan_info_notif_v4(mvm, notif,
-							   d3_data->status, len,
-							   wowlan_info_ver > 3);
+							   d3_data->status, len);
 		} else {
 			struct iwl_wowlan_info_notif *notif =
 				(void *)pkt->data;
-- 
2.34.1


