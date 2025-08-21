Return-Path: <linux-wireless+bounces-26496-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD00B2F8C5
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 14:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67AC45E20A9
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 12:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6344C2DC349;
	Thu, 21 Aug 2025 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+X2i4nY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2A72F5321
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780305; cv=none; b=R6HLkBU+JUQOsPsM/w313BNPL+yxln3ey/HeC6R+PuBbPkFYu4ItC8KYk2bJUYc1C/es6YNFdS+Rfc2NkA+ICbyyAFVRcdBQC9l9HU03q+g8guU9ccyWceyhr+v1LXAj7+1Ht7iLMDMqDqQerkPJfUbTTBi4KkCd9kM0V/7JQFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780305; c=relaxed/simple;
	bh=6tJagAHqVr6YNWFl0JjZHIHedIOuc7LsSEbzHvETQjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ff9yajIrpqroC+TALfU72ThPCtSSAqcV9VUnVvBrn8UbJW5eGaiQAsG5QEI3LhfsTd0cYozkD+MlcPOzY37fxG1Z3mcTUVfUd2ii5EeP/rwSUSRZ5iQdhNEPFUc5YFyvBY85W2sDkqEGMsI54BlEtC1Q8S5AsBbK44AH4/qgGBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P+X2i4nY; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755780303; x=1787316303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6tJagAHqVr6YNWFl0JjZHIHedIOuc7LsSEbzHvETQjQ=;
  b=P+X2i4nYGrtff3LQsJ5iFYOUiIv42pRsLdW9NgtO9z5k8nOPJ27nabAc
   KDDJOE028BvgRtSuUIREqNSTjWk3q95NPmylNsnz3RNEgk+8lIKqMMpZ7
   Rr0SoWcrlzLbf3IGX2rFD0LSO3YQETVH9rSiEzYknUsPN6YHyh3qd5upY
   ZNyYkeZTuR2GWKXZDC+z6Z2q/e3zRYz7Hsxj/oCwPy+41F/7DCFQrUQR5
   uptc6R6ak1eVR5dTJmwkDQWkgnSQGLJnGm1ha/G7WE9/645ozdLiZQ5fV
   BbSiTz2nxxG6J+8dNqbJwljY+p7rtLx8nyBTkx1QtpXjy5PEFa4cqXbpV
   A==;
X-CSE-ConnectionGUID: YFmljpyZRNSTEaqRtOVgug==
X-CSE-MsgGUID: U53152JGSdqcrCf9Nii9yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="61895732"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="61895732"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:45:03 -0700
X-CSE-ConnectionGUID: 2dTNW0PpTiSFLo+461mwLw==
X-CSE-MsgGUID: W80hUzxkT5+pvasr7/hXfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="172622128"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:45:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: mld: cleanup cipher lookup in resume
Date: Thu, 21 Aug 2025 15:44:20 +0300
Message-Id: <20250821154216.0650021c587b.Iae55243b575248cb4cc0b416f7f63092b5803219@changeid>
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
 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 81 ++-------------------
 1 file changed, 7 insertions(+), 74 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index ed0a0f76f1c5..daa01fe62f84 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -40,7 +40,7 @@ enum iwl_mld_d3_notif {
 struct iwl_mld_resume_key_iter_data {
 	struct iwl_mld *mld;
 	struct iwl_mld_wowlan_status *wowlan_status;
-	u32 num_keys, gtk_cipher, igtk_cipher, bigtk_cipher;
+	u32 num_keys;
 	bool unhandled_cipher;
 };
 
@@ -708,11 +708,6 @@ iwl_mld_resume_keys_iter(struct ieee80211_hw *hw,
 			return;
 		}
 
-		if (WARN_ON(data->gtk_cipher &&
-			    data->gtk_cipher != key->cipher))
-			return;
-
-		data->gtk_cipher = key->cipher;
 		status_idx = key->keyidx == wowlan_status->gtk[1].id;
 		iwl_mld_set_key_rx_seq(key, &wowlan_status->gtk[status_idx]);
 		break;
@@ -721,20 +716,10 @@ iwl_mld_resume_keys_iter(struct ieee80211_hw *hw,
 	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
 	case WLAN_CIPHER_SUITE_AES_CMAC:
 		if (key->keyidx == 4 || key->keyidx == 5) {
-			if (WARN_ON(data->igtk_cipher &&
-				    data->igtk_cipher != key->cipher))
-				return;
-
-			data->igtk_cipher = key->cipher;
 			if (key->keyidx == wowlan_status->igtk.id)
 				iwl_mld_set_key_rx_seq(key, &wowlan_status->igtk);
 		}
 		if (key->keyidx == 6 || key->keyidx == 7) {
-			if (WARN_ON(data->bigtk_cipher &&
-				    data->bigtk_cipher != key->cipher))
-				return;
-
-			data->bigtk_cipher = key->cipher;
 			status_idx = key->keyidx == wowlan_status->bigtk[1].id;
 			iwl_mld_set_key_rx_seq(key, &wowlan_status->bigtk[status_idx]);
 		}
@@ -750,65 +735,16 @@ static void
 iwl_mld_add_mcast_rekey(struct ieee80211_vif *vif,
 			struct iwl_mld *mld,
 			struct iwl_mld_mcast_key_data *key_data,
-			struct ieee80211_bss_conf *link_conf,
-			u32 cipher)
+			struct ieee80211_bss_conf *link_conf)
 {
 	struct ieee80211_key_conf *key_config;
-	struct {
-		struct ieee80211_key_conf conf;
-		u8 key[WOWLAN_KEY_MAX_SIZE];
-	} conf = {
-		.conf.cipher = cipher,
-		.conf.keyidx = key_data->id,
-	};
 	int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
-	u8 key[WOWLAN_KEY_MAX_SIZE];
-
-	BUILD_BUG_ON(WLAN_KEY_LEN_CCMP != WLAN_KEY_LEN_GCMP);
-	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_CCMP);
-	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_GCMP_256);
-	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_TKIP);
-	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_BIP_GMAC_128);
-	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_BIP_GMAC_256);
-	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_AES_CMAC);
-	BUILD_BUG_ON(sizeof(conf.key) < sizeof(key_data->key));
 
 	if (!key_data->len)
 		return;
 
-	switch (cipher) {
-	case WLAN_CIPHER_SUITE_CCMP:
-	case WLAN_CIPHER_SUITE_GCMP:
-		conf.conf.keylen = WLAN_KEY_LEN_CCMP;
-		break;
-	case WLAN_CIPHER_SUITE_GCMP_256:
-		conf.conf.keylen = WLAN_KEY_LEN_GCMP_256;
-		break;
-	case WLAN_CIPHER_SUITE_TKIP:
-		conf.conf.keylen = WLAN_KEY_LEN_TKIP;
-		break;
-	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
-		conf.conf.keylen = WLAN_KEY_LEN_BIP_GMAC_128;
-		break;
-	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
-		conf.conf.keylen = WLAN_KEY_LEN_BIP_GMAC_256;
-		break;
-	case WLAN_CIPHER_SUITE_AES_CMAC:
-		conf.conf.keylen = WLAN_KEY_LEN_AES_CMAC;
-		break;
-	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
-		conf.conf.keylen = WLAN_KEY_LEN_BIP_CMAC_256;
-		break;
-	default:
-		WARN_ON(1);
-	}
-
-	memcpy(conf.conf.key, key_data->key, conf.conf.keylen);
-
-	memcpy(key, key_data->key, sizeof(key_data->key));
-
-	key_config = ieee80211_gtk_rekey_add(vif, key_data->id, key,
-					     sizeof(key), link_id);
+	key_config = ieee80211_gtk_rekey_add(vif, key_data->id, key_data->key,
+					     sizeof(key_data->key), link_id);
 	if (IS_ERR(key_config))
 		return;
 
@@ -850,18 +786,15 @@ iwl_mld_add_all_rekeys(struct ieee80211_vif *vif,
 	for (i = 0; i < ARRAY_SIZE(wowlan_status->gtk); i++)
 		iwl_mld_add_mcast_rekey(vif, key_iter_data->mld,
 					&wowlan_status->gtk[i],
-					link_conf,
-					key_iter_data->gtk_cipher);
+					link_conf);
 
 	iwl_mld_add_mcast_rekey(vif, key_iter_data->mld,
-				&wowlan_status->igtk,
-				link_conf, key_iter_data->igtk_cipher);
+				&wowlan_status->igtk, link_conf);
 
 	for (i = 0; i < ARRAY_SIZE(wowlan_status->bigtk); i++)
 		iwl_mld_add_mcast_rekey(vif, key_iter_data->mld,
 					&wowlan_status->bigtk[i],
-					link_conf,
-					key_iter_data->bigtk_cipher);
+					link_conf);
 }
 
 static bool
-- 
2.34.1


