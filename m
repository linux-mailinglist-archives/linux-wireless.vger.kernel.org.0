Return-Path: <linux-wireless+bounces-4541-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30523877AF0
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 07:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541C01C20F3A
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 06:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6886813AC3;
	Mon, 11 Mar 2024 06:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YDP84iiQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800B2134DE
	for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 06:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710138528; cv=none; b=rXrD+xGyqnLaoirGdZHEkQK0PUyA178yp1WpQmb30Q2+hTE7ehPrmert/sl5i4vrvKVEUUXhBdOeweIWsjgQOnJ8N6kFuqRaM47HQD7a1a+o9WjmmZ/DoFsWN/y23275qmQIa7oQ3QoUtSrCrf7R+Juo95KZ/21Pt4U29L4b34A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710138528; c=relaxed/simple;
	bh=3dOpZTFKr1XDBEl5kAXlqvEDFhc1AnotYm/RVZOT+YI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JSLIkoQvTPF8VWUtpxoAqSijj5PWTloSqdO0ZaBtrQOHUH8Lu/PgekspwRqqUQs+Y0NI56ndxZM9L9YO7QVC+VDWsT7X1S9AUIY4jCGZui/OlJhVSd8Z4mAsELYLexShAyQwXpEu4STrcAZCvUkTiOwm0AWrM3rkbQWtF4WAmLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YDP84iiQ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710138526; x=1741674526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3dOpZTFKr1XDBEl5kAXlqvEDFhc1AnotYm/RVZOT+YI=;
  b=YDP84iiQUCyjJnmrsEYUpVnJF8cKit2gvyETdsGhuWxDOtxmYnxHQZ29
   MfaUYVqMkmihPRMJ2Ctq0l2JHEUQ7t+msGq96hXmetLs6ydFO8+Ke981+
   5ChNc9gBv8UOYWNjGEnLIlu7K6apUHJCUzTUZIVNf+F4M+zRXZ0ezBGWO
   h0B47K6rT9yb1gSv0GSE/yy12Ta7a4dwh02UuvPRvHzfedhXYFJNFmiP3
   byL2XqcwsiZqROxBz5vPob2B7qavFmMkSkqPXH3C/LW5n63LE/G7tAWAo
   36l1p0grTYPHk5wjB3xRDAexPpwH9A3w6/5HpK1Md984qwBywOV8qFsgr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="30226781"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="30226781"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="15657709"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Shaul Triebitz <shaul.triebitz@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/15] wifi: iwlwifi: mvm: support wowlan notif version 4
Date: Mon, 11 Mar 2024 08:28:09 +0200
Message-Id: <20240311081938.6524de988ed3.Id065ddd2f4a71b0243c33ae0c5476ac41bfe2dc2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
References: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Shaul Triebitz <shaul.triebitz@intel.com>

In version 4, in case of MLO GTK rekey during D3,
the firmware sends all the new keys, including
the keys on the non-active links.

Update also the non active link keys.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  57 +++++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 192 +++++++++++++++++-
 2 files changed, 243 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index d2a74beed3a1..bbaaf3c73115 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -843,6 +843,52 @@ struct iwl_wowlan_info_notif_v2 {
 	u8 reserved2[2];
 } __packed; /* WOWLAN_INFO_NTFY_API_S_VER_2 */
 
+/* MAX MLO keys of non-active links that can arrive in the notification */
+#define WOWLAN_MAX_MLO_KEYS 18
+
+/**
+ * enum iwl_wowlan_mlo_gtk_type - GTK types
+ * @WOWLAN_MLO_GTK_KEY_TYPE_GTK: GTK
+ * @WOWLAN_MLO_GTK_KEY_TYPE_IGTK: IGTK
+ * @WOWLAN_MLO_GTK_KEY_TYPE_BIGTK: BIGTK
+ * @WOWLAN_MLO_GTK_KEY_NUM_TYPES: number of key types
+ */
+enum iwl_wowlan_mlo_gtk_type {
+	WOWLAN_MLO_GTK_KEY_TYPE_GTK,
+	WOWLAN_MLO_GTK_KEY_TYPE_IGTK,
+	WOWLAN_MLO_GTK_KEY_TYPE_BIGTK,
+	WOWLAN_MLO_GTK_KEY_NUM_TYPES
+}; /* WOWLAN_MLO_GTK_KEY_TYPE_API_E_VER_1 */
+
+/**
+ * enum iwl_wowlan_mlo_gtk_flag - MLO GTK flags
+ * @WOWLAN_MLO_GTK_FLAG_KEY_LEN_MSK: 0 for len 16, 1 for len 32
+ * @WOWLAN_MLO_GTK_FLAG_KEY_ID_MSK: key id (ranges from 0 to 7)
+ * @WOWLAN_MLO_GTK_FLAG_LINK_ID_MSK: spec link id of the key
+ * @WOWLAN_MLO_GTK_FLAG_KEY_TYPE_MSK: &enum iwl_wowlan_mlo_gtk_type
+ * @WOWLAN_MLO_GTK_FLAG_LAST_KEY_MSK: is this the last given key per
+ *	key-type / link-id - the currently used key
+ */
+enum iwl_wowlan_mlo_gtk_flag {
+	WOWLAN_MLO_GTK_FLAG_KEY_LEN_MSK = 0x0001,
+	WOWLAN_MLO_GTK_FLAG_KEY_ID_MSK = 0x000E,
+	WOWLAN_MLO_GTK_FLAG_LINK_ID_MSK = 0x00F0,
+	WOWLAN_MLO_GTK_FLAG_KEY_TYPE_MSK = 0x0300,
+	WOWLAN_MLO_GTK_FLAG_LAST_KEY_MSK = 0x0400
+}; /* WOWLAN_MLO_GTK_FLAG_API_E_VER_1 */
+
+/**
+ * struct iwl_wowlan_mlo_gtk - MLO GTK info
+ * @key: key material
+ * @flags: &enum iwl_wowlan_mlo_gtk_flag
+ * @pn: packet number
+ */
+struct iwl_wowlan_mlo_gtk {
+	u8 key[WOWLAN_KEY_MAX_SIZE];
+	__le16 flags;
+	u8 pn[6];
+} __packed; /* WOWLAN_MLO_GTK_KEY_API_S_VER_1 */
+
 /**
  * struct iwl_wowlan_info_notif - WoWLAN information notification
  * @gtk: GTK data
@@ -859,7 +905,10 @@ struct iwl_wowlan_info_notif_v2 {
  * @tid_tear_down: bit mask of tids whose BA sessions were closed
  *	in suspend state
  * @station_id: station id
+ * @num_mlo_link_keys: number of &struct iwl_wowlan_mlo_gtk structs
+ *	following this notif, or reserved in version < 4
  * @reserved2: reserved
+ * @mlo_gtks: array of GTKs of size num_mlo_link_keys for version >= 4
  */
 struct iwl_wowlan_info_notif {
 	struct iwl_wowlan_gtk_status_v3 gtk[WOWLAN_GTK_KEYS_NUM];
@@ -875,8 +924,10 @@ struct iwl_wowlan_info_notif {
 	__le32 received_beacons;
 	u8 tid_tear_down;
 	u8 station_id;
-	u8 reserved2[2];
-} __packed; /* WOWLAN_INFO_NTFY_API_S_VER_3 */
+	u8 num_mlo_link_keys;
+	u8 reserved2;
+	struct iwl_wowlan_mlo_gtk mlo_gtks[];
+} __packed; /* WOWLAN_INFO_NTFY_API_S_VER_3, _VER_4 */
 
 /**
  * struct iwl_wowlan_wake_pkt_notif - WoWLAN wake packet notification
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 7ee3d6fa4526..86b572690906 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1466,6 +1466,9 @@ struct iwl_wowlan_status_data {
 	struct iwl_multicast_key_data igtk;
 	struct iwl_multicast_key_data bigtk[WOWLAN_BIGTK_KEYS_NUM];
 
+	int num_mlo_keys;
+	struct iwl_wowlan_mlo_gtk mlo_keys[WOWLAN_MAX_MLO_KEYS];
+
 	u8 *wake_packet;
 };
 
@@ -1975,6 +1978,169 @@ static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
 	}
 }
 
+struct iwl_mvm_d3_mlo_old_keys {
+	u32 cipher[IEEE80211_MLD_MAX_NUM_LINKS][WOWLAN_MLO_GTK_KEY_NUM_TYPES];
+	struct ieee80211_key_conf *key[IEEE80211_MLD_MAX_NUM_LINKS][8];
+};
+
+static void iwl_mvm_mlo_key_ciphers(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_sta *sta,
+				    struct ieee80211_key_conf *key,
+				    void *data)
+{
+	struct iwl_mvm_d3_mlo_old_keys *old_keys = data;
+	enum iwl_wowlan_mlo_gtk_type key_type;
+
+	if (key->link_id < 0)
+		return;
+
+	if (WARN_ON(key->link_id >= IEEE80211_MLD_MAX_NUM_LINKS ||
+		    key->keyidx >= 8))
+		return;
+
+	if (WARN_ON(old_keys->key[key->link_id][key->keyidx]))
+		return;
+
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		key_type = WOWLAN_MLO_GTK_KEY_TYPE_GTK;
+		break;
+	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
+	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
+	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		if (key->keyidx == 4 || key->keyidx == 5) {
+			key_type = WOWLAN_MLO_GTK_KEY_TYPE_IGTK;
+			break;
+		} else if (key->keyidx == 6 || key->keyidx == 7) {
+			key_type = WOWLAN_MLO_GTK_KEY_TYPE_BIGTK;
+			break;
+		}
+		return;
+	default:
+		/* ignore WEP/TKIP or unknown ciphers */
+		return;
+	}
+
+	old_keys->cipher[key->link_id][key_type] = key->cipher;
+	old_keys->key[key->link_id][key->keyidx] = key;
+}
+
+static bool iwl_mvm_mlo_gtk_rekey(struct iwl_wowlan_status_data *status,
+				  struct ieee80211_vif *vif,
+				  struct iwl_mvm *mvm)
+{
+	int i;
+	struct iwl_mvm_d3_mlo_old_keys *old_keys;
+	bool ret = true;
+
+	IWL_DEBUG_WOWLAN(mvm, "Num of MLO Keys: %d\n", status->num_mlo_keys);
+	if (!status->num_mlo_keys)
+		return true;
+
+	old_keys = kzalloc(sizeof(*old_keys), GFP_KERNEL);
+	if (!old_keys)
+		return false;
+
+	/* find the cipher for each mlo key */
+	ieee80211_iter_keys(mvm->hw, vif, iwl_mvm_mlo_key_ciphers, old_keys);
+
+	for (i = 0; i < status->num_mlo_keys; i++) {
+		struct iwl_wowlan_mlo_gtk *mlo_key = &status->mlo_keys[i];
+		struct ieee80211_key_conf *key, *old_key;
+		struct ieee80211_key_seq seq;
+		struct {
+			struct ieee80211_key_conf conf;
+			u8 key[32];
+		} conf = {};
+		u16 flags = le16_to_cpu(mlo_key->flags);
+		int j, link_id, key_id, key_type;
+
+		link_id = u16_get_bits(flags, WOWLAN_MLO_GTK_FLAG_LINK_ID_MSK);
+		key_id = u16_get_bits(flags, WOWLAN_MLO_GTK_FLAG_KEY_ID_MSK);
+		key_type = u16_get_bits(flags,
+					WOWLAN_MLO_GTK_FLAG_KEY_TYPE_MSK);
+
+		if (!(vif->valid_links & BIT(link_id)))
+			continue;
+
+		if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS ||
+			    key_id >= 8 ||
+			    key_type >= WOWLAN_MLO_GTK_KEY_NUM_TYPES))
+			continue;
+
+		conf.conf.cipher = old_keys->cipher[link_id][key_type];
+		/* WARN_ON? */
+		if (!conf.conf.cipher)
+			continue;
+
+		conf.conf.keylen = 0;
+		switch (conf.conf.cipher) {
+		case WLAN_CIPHER_SUITE_CCMP:
+		case WLAN_CIPHER_SUITE_GCMP:
+			conf.conf.keylen = WLAN_KEY_LEN_CCMP;
+			break;
+		case WLAN_CIPHER_SUITE_GCMP_256:
+			conf.conf.keylen = WLAN_KEY_LEN_GCMP_256;
+			break;
+		case WLAN_CIPHER_SUITE_BIP_GMAC_128:
+			conf.conf.keylen = WLAN_KEY_LEN_BIP_GMAC_128;
+			break;
+		case WLAN_CIPHER_SUITE_BIP_GMAC_256:
+			conf.conf.keylen = WLAN_KEY_LEN_BIP_GMAC_256;
+			break;
+		case WLAN_CIPHER_SUITE_AES_CMAC:
+			conf.conf.keylen = WLAN_KEY_LEN_AES_CMAC;
+			break;
+		case WLAN_CIPHER_SUITE_BIP_CMAC_256:
+			conf.conf.keylen = WLAN_KEY_LEN_BIP_CMAC_256;
+			break;
+		}
+
+		if (WARN_ON(!conf.conf.keylen ||
+			    conf.conf.keylen > sizeof(conf.key)))
+			continue;
+
+		memcpy(conf.conf.key, mlo_key->key, conf.conf.keylen);
+		conf.conf.keyidx = key_id;
+
+		old_key = old_keys->key[link_id][key_id];
+		if (old_key) {
+			IWL_DEBUG_WOWLAN(mvm,
+					 "Remove MLO key id %d, link id %d\n",
+					 key_id, link_id);
+			ieee80211_remove_key(old_key);
+		}
+
+		IWL_DEBUG_WOWLAN(mvm, "Add MLO key id %d, link id %d\n",
+				 key_id, link_id);
+		key = ieee80211_gtk_rekey_add(vif, &conf.conf, link_id);
+		if (WARN_ON(IS_ERR(key))) {
+			ret = false;
+			goto out;
+		}
+
+		/*
+		 * mac80211 expects the pn in big-endian
+		 * also note that seq is a union of all cipher types
+		 * (ccmp, gcmp, cmac, gmac), and they all have the same
+		 * pn field (of length 6) so just copy it to ccmp.pn.
+		 */
+		for (j = 5; j >= 0; j--)
+			seq.ccmp.pn[5 - j] = mlo_key->pn[j];
+
+		/* group keys are non-QoS and use TID 0 */
+		ieee80211_set_key_rx_seq(key, 0, &seq);
+	}
+
+out:
+	kfree(old_keys);
+	return ret;
+}
+
 static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
 			      struct ieee80211_vif *vif,
 			      struct iwl_mvm *mvm, u32 gtk_cipher)
@@ -2178,6 +2344,9 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 				return false;
 		}
 
+		if (!iwl_mvm_mlo_gtk_rekey(status, vif, mvm))
+			return false;
+
 		ieee80211_gtk_rekey_notify(vif, vif->bss_conf.bssid,
 					   (void *)&replay_ctr, GFP_KERNEL);
 	}
@@ -2305,9 +2474,10 @@ static void iwl_mvm_convert_bigtk(struct iwl_wowlan_status_data *status,
 static void iwl_mvm_parse_wowlan_info_notif(struct iwl_mvm *mvm,
 					    struct iwl_wowlan_info_notif *data,
 					    struct iwl_wowlan_status_data *status,
-					    u32 len)
+					    u32 len, bool has_mlo_keys)
 {
 	u32 i;
+	u32 expected_len = sizeof(*data);
 
 	if (!data) {
 		IWL_ERR(mvm, "iwl_wowlan_info_notif data is NULL\n");
@@ -2315,7 +2485,11 @@ static void iwl_mvm_parse_wowlan_info_notif(struct iwl_mvm *mvm,
 		return;
 	}
 
-	if (len < sizeof(*data)) {
+	if (has_mlo_keys)
+		expected_len += (data->num_mlo_link_keys *
+				 sizeof(status->mlo_keys[0]));
+
+	if (len < expected_len) {
 		IWL_ERR(mvm, "Invalid WoWLAN info notification!\n");
 		status = NULL;
 		return;
@@ -2335,6 +2509,17 @@ static void iwl_mvm_parse_wowlan_info_notif(struct iwl_mvm *mvm,
 		le32_to_cpu(data->num_of_gtk_rekeys);
 	status->received_beacons = le32_to_cpu(data->received_beacons);
 	status->tid_tear_down = data->tid_tear_down;
+
+	if (has_mlo_keys && data->num_mlo_link_keys) {
+		status->num_mlo_keys = data->num_mlo_link_keys;
+		if (IWL_FW_CHECK(mvm,
+				 status->num_mlo_keys > WOWLAN_MAX_MLO_KEYS,
+				 "Too many mlo keys: %d, max %d\n",
+				 status->num_mlo_keys, WOWLAN_MAX_MLO_KEYS))
+			status->num_mlo_keys = WOWLAN_MAX_MLO_KEYS;
+		memcpy(status->mlo_keys, data->mlo_gtks,
+		       status->num_mlo_keys * sizeof(status->mlo_keys[0]));
+	}
 }
 
 static void
@@ -3081,7 +3266,8 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 				(void *)pkt->data;
 
 			iwl_mvm_parse_wowlan_info_notif(mvm, notif,
-							d3_data->status, len);
+							d3_data->status, len,
+							wowlan_info_ver > 3);
 		}
 
 		d3_data->notif_received |= IWL_D3_NOTIF_WOWLAN_INFO;
-- 
2.34.1


