Return-Path: <linux-wireless+bounces-26499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C11B2F8E1
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 14:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8571CE3276
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 12:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6023218CD;
	Thu, 21 Aug 2025 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fqvpmn9K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB57320CC4
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 12:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780308; cv=none; b=VpGtYBpUQoN0EbAKH3K0a3yEvaxuiRG69PpdNfeSXQahJJRMk/62MXjIwpcX7b9iY/uhqZjoWazUVHjLYZDxSsEn4BKOfUcbQ1ay7HvOPlteFw08JgG5GMiJ3QfDLlcs8ihNq+KHJcpEGzgfLbx23OGXWH7shjrA6VaFcDAHJDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780308; c=relaxed/simple;
	bh=AUlYbGMKji7DnKbX6KgtfJqYj5973BmzYYBMakC4CYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TbiI4O+WSDycKlPFD+tthYG7r190SrwgIUSvd8s8iq7qdmwLthiEVB+KcLm8vJIASHOlXKhW6WXdqPS5BlXaQ0XA+Kxfeb7+bcG7s7Y8BZ5WQdhrzCWGLViduO9nr/bMzIWPV3yI0KFiudWg/vPFXt37qaNBmp8K4giAWwswqak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fqvpmn9K; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755780305; x=1787316305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AUlYbGMKji7DnKbX6KgtfJqYj5973BmzYYBMakC4CYk=;
  b=Fqvpmn9KU4BQ20WzUl4PhtFaNPG8ByQ2YReYmUrvNHXzQHg8zjsKTg7C
   6G7evDIaJnVXiY7BU4jqoxWvwQangWxXeTzWMRv/VNtoap0hDZ9drjp12
   FqfH1dubjVk6ktAzcd1Dv8o2UH9ot75ytGcwVSlL/qSsH39A9RlwH/vFn
   8tDHcEzrvTLKrH6pxMIn73SsONMcbfzoyd+kLfbftMx/cPUiKjq8gldNo
   CMUwJr7v9kCEEzhoQO8kN7QEo5pAsXCDA7bTE9cUmHzFrq1ZESXhkmFGv
   S0gTNVTmi1OG95WmDW8k9hEolssbs3uagzH5u1CqdEf3YRKrRG0trPPyC
   g==;
X-CSE-ConnectionGUID: 5TcPEyHEQw2wwBKFfiCvUA==
X-CSE-MsgGUID: OFj15NXeQvKira5Yhc7xXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="61895735"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="61895735"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:45:04 -0700
X-CSE-ConnectionGUID: RojRqx8QTSGVUeFDbOTWNw==
X-CSE-MsgGUID: JYJV+8GNQ/2006YYUsqVXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="172622147"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:45:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: mvm: cleanup cipher lookup in resume
Date: Thu, 21 Aug 2025 15:44:21 +0300
Message-Id: <20250821154216.937cbf5fd26e.I5d92258a9d63a39ee3acb02a72a2af9984993018@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821124433.2234183-1-miriam.rachel.korenblit@intel.com>
References: <20250821124433.2234183-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

We used to lookup the ciphers of the mcast keys, but this was beacuse it
was required for ieee80211_get_rekey_add. Now as this API no longer
needs the cipher as an argument, we can remove the cipher lookups.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 165 ++------------------
 1 file changed, 14 insertions(+), 151 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index a4090db00d0b..a31bc2af5300 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1790,63 +1790,8 @@ static void iwl_mvm_set_key_rx_seq(struct ieee80211_key_conf *key,
 struct iwl_mvm_d3_gtk_iter_data {
 	struct iwl_mvm *mvm;
 	struct iwl_wowlan_status_data *status;
-	u32 gtk_cipher, igtk_cipher, bigtk_cipher;
-	bool unhandled_cipher, igtk_support, bigtk_support;
-	int num_keys;
 };
 
-static void iwl_mvm_d3_find_last_keys(struct ieee80211_hw *hw,
-				      struct ieee80211_vif *vif,
-				      struct ieee80211_sta *sta,
-				      struct ieee80211_key_conf *key,
-				      void *_data)
-{
-	struct iwl_mvm_d3_gtk_iter_data *data = _data;
-	int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
-
-	if (link_id >= 0 && key->link_id >= 0 && link_id != key->link_id)
-		return;
-
-	if (data->unhandled_cipher)
-		return;
-
-	switch (key->cipher) {
-	case WLAN_CIPHER_SUITE_WEP40:
-	case WLAN_CIPHER_SUITE_WEP104:
-		/* ignore WEP completely, nothing to do */
-		return;
-	case WLAN_CIPHER_SUITE_CCMP:
-	case WLAN_CIPHER_SUITE_GCMP:
-	case WLAN_CIPHER_SUITE_GCMP_256:
-	case WLAN_CIPHER_SUITE_TKIP:
-		/* we support these */
-		data->gtk_cipher = key->cipher;
-		break;
-	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
-	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
-	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
-	case WLAN_CIPHER_SUITE_AES_CMAC:
-		/* we support these */
-		if (data->igtk_support &&
-		    (key->keyidx == 4 || key->keyidx == 5)) {
-			data->igtk_cipher = key->cipher;
-		} else if (data->bigtk_support &&
-			   (key->keyidx == 6 || key->keyidx == 7)) {
-			data->bigtk_cipher = key->cipher;
-		} else {
-			data->unhandled_cipher = true;
-			return;
-		}
-		break;
-	default:
-		/* everything else - disconnect from AP */
-		data->unhandled_cipher = true;
-		return;
-	}
-
-	data->num_keys++;
-}
-
 static void
 iwl_mvm_d3_set_igtk_bigtk_ipn(const struct iwl_multicast_key_data *key,
 			      struct ieee80211_key_seq *seq, u32 cipher)
@@ -1892,9 +1837,6 @@ static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
 	if (link_id >= 0 && key->link_id >= 0 && link_id != key->link_id)
 		return;
 
-	if (data->unhandled_cipher)
-		return;
-
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
 	case WLAN_CIPHER_SUITE_WEP104:
@@ -1943,52 +1885,24 @@ static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
 
 static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
 			      struct ieee80211_vif *vif,
-			      struct iwl_mvm *mvm, u32 gtk_cipher)
+			      struct iwl_mvm *mvm)
 {
 	int i, j;
 	struct ieee80211_key_conf *key;
-	DEFINE_RAW_FLEX(struct ieee80211_key_conf, conf, key,
-			WOWLAN_KEY_MAX_SIZE);
 	int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
-	u8 key_data[WOWLAN_KEY_MAX_SIZE];
-
-	conf->cipher = gtk_cipher;
-
-	BUILD_BUG_ON(WLAN_KEY_LEN_CCMP != WLAN_KEY_LEN_GCMP);
-	BUILD_BUG_ON(WOWLAN_KEY_MAX_SIZE < WLAN_KEY_LEN_CCMP);
-	BUILD_BUG_ON(WOWLAN_KEY_MAX_SIZE < WLAN_KEY_LEN_GCMP_256);
-	BUILD_BUG_ON(WOWLAN_KEY_MAX_SIZE < WLAN_KEY_LEN_TKIP);
-	BUILD_BUG_ON(WOWLAN_KEY_MAX_SIZE < sizeof(status->gtk[0].key));
-
-	switch (gtk_cipher) {
-	case WLAN_CIPHER_SUITE_CCMP:
-	case WLAN_CIPHER_SUITE_GCMP:
-		conf->keylen = WLAN_KEY_LEN_CCMP;
-		break;
-	case WLAN_CIPHER_SUITE_GCMP_256:
-		conf->keylen = WLAN_KEY_LEN_GCMP_256;
-		break;
-	case WLAN_CIPHER_SUITE_TKIP:
-		conf->keylen = WLAN_KEY_LEN_TKIP;
-		break;
-	default:
-		WARN_ON(1);
-	}
 
 	for (i = 0; i < ARRAY_SIZE(status->gtk); i++) {
 		if (!status->gtk[i].len)
 			continue;
 
-		conf->keyidx = status->gtk[i].id;
 		IWL_DEBUG_WOWLAN(mvm,
-				 "Received from FW GTK cipher %d, key index %d\n",
-				 conf->cipher, conf->keyidx);
-		memcpy(conf->key, status->gtk[i].key,
-		       sizeof(status->gtk[i].key));
-		memcpy(key_data, status->gtk[i].key, sizeof(status->gtk[i].key));
-
-		key = ieee80211_gtk_rekey_add(vif, status->gtk[i].id, key_data,
-					      sizeof(key_data), link_id);
+				 "Received from FW GTK: key index %d\n",
+				 status->gtk[i].id);
+
+		key = ieee80211_gtk_rekey_add(vif, status->gtk[i].id,
+					      status->gtk[i].key,
+					      sizeof(status->gtk[i].key),
+					      link_id);
 		if (IS_ERR(key)) {
 			/* FW may send also the old keys */
 			if (PTR_ERR(key) == -EALREADY)
@@ -2011,53 +1925,26 @@ static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
 
 static bool
 iwl_mvm_d3_igtk_bigtk_rekey_add(struct iwl_wowlan_status_data *status,
-				struct ieee80211_vif *vif, u32 cipher,
+				struct ieee80211_vif *vif,
 				struct iwl_multicast_key_data *key_data)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	DEFINE_RAW_FLEX(struct ieee80211_key_conf, conf, key,
-			WOWLAN_KEY_MAX_SIZE);
 	struct ieee80211_key_conf *key_config;
 	struct ieee80211_key_seq seq;
 	int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
-	u8 key[WOWLAN_KEY_MAX_SIZE];
 	s8 keyidx = key_data->id;
 
-	conf->cipher = cipher;
-	conf->keyidx = keyidx;
-
 	if (!key_data->len)
 		return true;
 
-	iwl_mvm_d3_set_igtk_bigtk_ipn(key_data, &seq, conf->cipher);
-
-	switch (cipher) {
-	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
-		conf->keylen = WLAN_KEY_LEN_BIP_GMAC_128;
-		break;
-	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
-		conf->keylen = WLAN_KEY_LEN_BIP_GMAC_256;
-		break;
-	case WLAN_CIPHER_SUITE_AES_CMAC:
-		conf->keylen = WLAN_KEY_LEN_AES_CMAC;
-		break;
-	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
-		conf->keylen = WLAN_KEY_LEN_BIP_CMAC_256;
-		break;
-	default:
-		WARN_ON(1);
-	}
-	BUILD_BUG_ON(WOWLAN_KEY_MAX_SIZE < sizeof(key_data->key));
-	memcpy(conf->key, key_data->key, conf->keylen);
-
-	memcpy(key, key_data->key, sizeof(key_data->key));
-
-	key_config = ieee80211_gtk_rekey_add(vif, keyidx, key, sizeof(key),
-					     link_id);
+	key_config = ieee80211_gtk_rekey_add(vif, keyidx, key_data->key,
+					     sizeof(key_data->key), link_id);
 	if (IS_ERR(key_config)) {
 		/* FW may send also the old keys */
 		return PTR_ERR(key_config) == -EALREADY;
 	}
+
+	iwl_mvm_d3_set_igtk_bigtk_ipn(key_data, &seq, key_config->cipher);
 	ieee80211_set_key_rx_seq(key_config, 0, &seq);
 
 	if (keyidx == 4 || keyidx == 5) {
@@ -2111,27 +1998,6 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 
 	if (!status || !vif->bss_conf.bssid)
 		return false;
-
-	if (iwl_mvm_lookup_wowlan_status_ver(mvm) > 6 ||
-	    iwl_fw_lookup_notif_ver(mvm->fw, PROT_OFFLOAD_GROUP,
-				    WOWLAN_INFO_NOTIFICATION,
-				    0))
-		gtkdata.igtk_support = true;
-
-	if (iwl_fw_lookup_notif_ver(mvm->fw, PROT_OFFLOAD_GROUP,
-				    WOWLAN_INFO_NOTIFICATION,
-				    0) >= 3)
-		gtkdata.bigtk_support = true;
-
-	/* find last GTK that we used initially, if any */
-	ieee80211_iter_keys(mvm->hw, vif,
-			    iwl_mvm_d3_find_last_keys, &gtkdata);
-	/* not trying to keep connections with MFP/unhandled ciphers */
-	if (gtkdata.unhandled_cipher)
-		return false;
-	if (!gtkdata.num_keys)
-		goto out;
-
 	/*
 	 * invalidate all other GTKs that might still exist and update
 	 * the one that we used
@@ -2145,17 +2011,15 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 		IWL_DEBUG_WOWLAN(mvm, "num of GTK rekeying %d\n",
 				 status->num_of_gtk_rekeys);
 
-		if (!iwl_mvm_gtk_rekey(status, vif, mvm, gtkdata.gtk_cipher))
+		if (!iwl_mvm_gtk_rekey(status, vif, mvm))
 			return false;
 
 		if (!iwl_mvm_d3_igtk_bigtk_rekey_add(status, vif,
-						     gtkdata.igtk_cipher,
 						     &status->igtk))
 			return false;
 
 		for (i = 0; i < ARRAY_SIZE(status->bigtk); i++) {
 			if (!iwl_mvm_d3_igtk_bigtk_rekey_add(status, vif,
-							     gtkdata.bigtk_cipher,
 							     &status->bigtk[i]))
 				return false;
 		}
@@ -2164,7 +2028,6 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 					   (void *)&replay_ctr, GFP_KERNEL);
 	}
 
-out:
 	if (iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP,
 				    WOWLAN_GET_STATUSES,
 				    IWL_FW_CMD_VER_UNKNOWN) < 10) {
-- 
2.34.1


