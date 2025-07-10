Return-Path: <linux-wireless+bounces-25200-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E255B0095D
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A403D3A8C63
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 16:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C6E2F199C;
	Thu, 10 Jul 2025 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqJvon5S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB572F1994
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166527; cv=none; b=nEVxC1zRg9N/J91udgTHO+anjEOG5FuRCTLrxSlgsD8+YuLtslkWWM9q7rLVSAx9mZjPKWvFRlZAUmH2amSRdi+8OLbUNjlBor7T+6y56/U5V7ORHLNBurSNGYCoq7WdyC2myrnZQnNPl/XyqbhMspZNj29GvDc0Ftj63xiLG5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166527; c=relaxed/simple;
	bh=evc3CH4TWY7UvLmB2iGx3UMhA+9JAK/U5Rt26uBdefk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MUzatvcxQ7o3NcDOYKp4I85clPvSibmf7wVMIwLX1xUac4BObU+f3P+6CvWyvrmiyZl7Y4VlAKb3UftqJQGYDxWb83mB+O7J2P/MYrk9zCcn9ls59kZZ57MyNKHZJw+KoUGmJreXh9wilSiPNJOn7wedvOMkTuKKrdw5+MJxMoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqJvon5S; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752166525; x=1783702525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=evc3CH4TWY7UvLmB2iGx3UMhA+9JAK/U5Rt26uBdefk=;
  b=hqJvon5SX6M3hQEYmrio++Bl3yRNgkHJ8kB9itjVa2X+TY7z6Ntn2wfr
   sXUETjeFOtdw+naHkPCaZxnU0d1KsgCegKvWWvZCew+8o0b8lSIJlqoCb
   d4PkMaa110h2o5Fmdwd0cRaMNZ0o+ov5/zm9EyTQu9/J1d+ODdB5ingdT
   PAbCb+FR38uSiArobYvh56IlPNFfLGyZr3shIredm1KIeNkmHFwL836ys
   NbcMBvPbbpq+NKWQ8a8lDKEOkyr6151DNLv9GvHk9vOqd0CiwdewNrlV9
   L2NgJEnIJp0+j7DyR/gEiOzDV/E4H6M2Yp0U85a7GBQl+Nk3nxOUykBTv
   A==;
X-CSE-ConnectionGUID: NLAojGBGSFSNLugoelYtXQ==
X-CSE-MsgGUID: QHnHgmAVTiqYY+PPyRvzfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54610026"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54610026"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:25 -0700
X-CSE-ConnectionGUID: 30spRLEVSoW4NFPYga+6bA==
X-CSE-MsgGUID: v4/9z1mnTE6lM0c84GqmYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="156277106"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 13/15] wifi: iwlwifi: mld: don't remove all keys in mcast rekey
Date: Thu, 10 Jul 2025 19:54:46 +0300
Message-Id: <20250710195219.f0b5e19f77f5.I958f4926f168cdad6d4d7720ebde2f5e812b297d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
References: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
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
 drivers/net/wireless/intel/iwlwifi/mld/d3.c  | 112 +++++++------------
 drivers/net/wireless/intel/iwlwifi/mld/key.c |  12 ++
 drivers/net/wireless/intel/iwlwifi/mld/mld.h |   2 +
 3 files changed, 53 insertions(+), 73 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index af12b3d81899..26255246a320 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -646,51 +646,6 @@ iwl_mld_set_key_rx_seq(struct ieee80211_key_conf *key,
 	}
 }
 
-static void
-iwl_mld_d3_update_mcast_key(struct iwl_mld *mld,
-			    struct ieee80211_vif *vif,
-			    struct iwl_mld_wowlan_status *wowlan_status,
-			    struct ieee80211_key_conf *key,
-			    struct iwl_mld_mcast_key_data *key_data)
-{
-	if (key->keyidx != key_data->id &&
-	    (key->keyidx < 4 || key->keyidx > 5)) {
-		IWL_ERR(mld,
-			"Unexpected keyId mismatch. Old keyId:%d, New keyId:%d\n",
-			key->keyidx, key_data->id);
-		return;
-	}
-
-	/* All installed keys are sent by the FW, even weren't
-	 * rekeyed during D3.
-	 * We remove an existing key if it has the same index as
-	 * a new key and a rekey has occurred during d3
-	 */
-	if (wowlan_status->num_of_gtk_rekeys && key_data->len) {
-		if (key->keyidx == 4 || key->keyidx == 5) {
-			struct iwl_mld_vif *mld_vif =
-				iwl_mld_vif_from_mac80211(vif);
-			struct iwl_mld_link *mld_link;
-			int link_id = vif->active_links ?
-				__ffs(vif->active_links) : 0;
-
-			mld_link = iwl_mld_link_dereference_check(mld_vif,
-								  link_id);
-			if (WARN_ON(!mld_link))
-				return;
-
-			if (mld_link->igtk == key)
-				mld_link->igtk = NULL;
-			mld->num_igtks--;
-		}
-
-		ieee80211_remove_key(key);
-		return;
-	}
-
-	iwl_mld_set_key_rx_seq(key, key_data);
-}
-
 static void
 iwl_mld_update_ptk_rx_seq(struct iwl_mld *mld,
 			  struct iwl_mld_wowlan_status *wowlan_status,
@@ -759,8 +714,7 @@ iwl_mld_resume_keys_iter(struct ieee80211_hw *hw,
 
 		data->gtk_cipher = key->cipher;
 		status_idx = key->keyidx == wowlan_status->gtk[1].id;
-		iwl_mld_d3_update_mcast_key(data->mld, vif, wowlan_status, key,
-					    &wowlan_status->gtk[status_idx]);
+		iwl_mld_set_key_rx_seq(key, &wowlan_status->gtk[status_idx]);
 		break;
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
@@ -772,9 +726,8 @@ iwl_mld_resume_keys_iter(struct ieee80211_hw *hw,
 				return;
 
 			data->igtk_cipher = key->cipher;
-			iwl_mld_d3_update_mcast_key(data->mld, vif,
-						    wowlan_status,
-						    key, &wowlan_status->igtk);
+			if (key->keyidx == wowlan_status->igtk.id)
+				iwl_mld_set_key_rx_seq(key, &wowlan_status->igtk);
 		}
 		if (key->keyidx == 6 || key->keyidx == 7) {
 			if (WARN_ON(data->bigtk_cipher &&
@@ -783,9 +736,7 @@ iwl_mld_resume_keys_iter(struct ieee80211_hw *hw,
 
 			data->bigtk_cipher = key->cipher;
 			status_idx = key->keyidx == wowlan_status->bigtk[1].id;
-			iwl_mld_d3_update_mcast_key(data->mld, vif,
-						    wowlan_status, key,
-						    &wowlan_status->bigtk[status_idx]);
+			iwl_mld_set_key_rx_seq(key, &wowlan_status->bigtk[status_idx]);
 		}
 		break;
 	default:
@@ -795,7 +746,7 @@ iwl_mld_resume_keys_iter(struct ieee80211_hw *hw,
 	data->num_keys++;
 }
 
-static bool
+static void
 iwl_mld_add_mcast_rekey(struct ieee80211_vif *vif,
 			struct iwl_mld *mld,
 			struct iwl_mld_mcast_key_data *key_data,
@@ -822,7 +773,7 @@ iwl_mld_add_mcast_rekey(struct ieee80211_vif *vif,
 	BUILD_BUG_ON(sizeof(conf.key) < sizeof(key_data->key));
 
 	if (!key_data->len)
-		return true;
+		return;
 
 	switch (cipher) {
 	case WLAN_CIPHER_SUITE_CCMP:
@@ -854,7 +805,7 @@ iwl_mld_add_mcast_rekey(struct ieee80211_vif *vif,
 	memcpy(conf.conf.key, key_data->key, conf.conf.keylen);
 	key_config = ieee80211_gtk_rekey_add(vif, &conf.conf, link_id);
 	if (IS_ERR(key_config))
-		return false;
+		return;
 
 	iwl_mld_set_key_rx_seq(key_config, key_data);
 
@@ -862,10 +813,25 @@ iwl_mld_add_mcast_rekey(struct ieee80211_vif *vif,
 	if (key_config->keyidx == 4 || key_config->keyidx == 5) {
 		struct iwl_mld_link *mld_link =
 			iwl_mld_link_from_mac80211(link_conf);
-		mld_link->igtk = key_config;
-		mld->num_igtks++;
+
+		/* If we had more than one rekey, mac80211 will tell us to
+		 * remove the old and add the new so we will update the IGTK in
+		 * drv_set_key
+		 */
+		if (mld_link->igtk && mld_link->igtk != key_config) {
+			/* mark the old IGTK as not in FW */
+			mld_link->igtk->hw_key_idx = STA_KEY_IDX_INVALID;
+			mld_link->igtk = key_config;
+		}
+	}
+
+	/* Also keep track of the new BIGTK */
+	if ((key_config->keyidx == 6 || key_config->keyidx == 7) &&
+	    vif->type == NL80211_IFTYPE_STATION) {
+		struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+
+		rcu_assign_pointer(mld_vif->bigtks[key_config->keyidx - 6], key_config);
 	}
-	return true;
 }
 
 static void
@@ -877,23 +843,20 @@ iwl_mld_add_all_rekeys(struct ieee80211_vif *vif,
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(wowlan_status->gtk); i++)
-		if (!iwl_mld_add_mcast_rekey(vif, key_iter_data->mld,
-					     &wowlan_status->gtk[i],
-					     link_conf,
-					     key_iter_data->gtk_cipher))
-			return;
+		iwl_mld_add_mcast_rekey(vif, key_iter_data->mld,
+					&wowlan_status->gtk[i],
+					link_conf,
+					key_iter_data->gtk_cipher);
 
-	if (!iwl_mld_add_mcast_rekey(vif, key_iter_data->mld,
-				     &wowlan_status->igtk,
-				     link_conf, key_iter_data->igtk_cipher))
-		return;
+	iwl_mld_add_mcast_rekey(vif, key_iter_data->mld,
+				&wowlan_status->igtk,
+				link_conf, key_iter_data->igtk_cipher);
 
 	for (i = 0; i < ARRAY_SIZE(wowlan_status->bigtk); i++)
-		if (!iwl_mld_add_mcast_rekey(vif, key_iter_data->mld,
-					     &wowlan_status->bigtk[i],
-					     link_conf,
-					     key_iter_data->bigtk_cipher))
-			return;
+		iwl_mld_add_mcast_rekey(vif, key_iter_data->mld,
+					&wowlan_status->bigtk[i],
+					link_conf,
+					key_iter_data->bigtk_cipher);
 }
 
 static bool
@@ -1851,6 +1814,7 @@ int iwl_mld_wowlan_resume(struct iwl_mld *mld)
 		goto err;
 	}
 
+	mld->fw_status.resuming = true;
 	mld->fw_status.in_d3 = false;
 	mld->scan.last_start_time_jiffies = jiffies;
 
@@ -1926,6 +1890,8 @@ int iwl_mld_wowlan_resume(struct iwl_mld *mld)
 	mld->fw_status.in_hw_restart = true;
 	ret = 1;
  out:
+	mld->fw_status.resuming = false;
+
 	if (resume_data.wowlan_status) {
 		kfree(resume_data.wowlan_status->wake_packet);
 		kfree(resume_data.wowlan_status);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/key.c b/drivers/net/wireless/intel/iwlwifi/mld/key.c
index 0eff13e5ffd5..13462a5ad79a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/key.c
@@ -129,6 +129,12 @@ static int iwl_mld_add_key_to_fw(struct iwl_mld *mld, u32 sta_mask,
 	bool tkip = key->cipher == WLAN_CIPHER_SUITE_TKIP;
 	int max_key_len = sizeof(cmd.u.add.key);
 
+#ifdef CONFIG_PM_SLEEP
+	/* If there was a rekey in wowlan, FW already has the key */
+	if (mld->fw_status.resuming)
+		return 0;
+#endif
+
 	if (WARN_ON(!sta_mask))
 		return -EINVAL;
 
@@ -160,6 +166,12 @@ static void iwl_mld_remove_key_from_fw(struct iwl_mld *mld, u32 sta_mask,
 		.u.remove.key_flags = cpu_to_le32(key_flags),
 	};
 
+#ifdef CONFIG_PM_SLEEP
+	/* If there was a rekey in wowlan, FW already removed the key */
+	if (mld->fw_status.resuming)
+		return;
+#endif
+
 	if (WARN_ON(!sta_mask))
 		return;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index 241ab3a00e56..a9e59378f142 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -149,6 +149,7 @@
  * @running: true if the firmware is running
  * @do_not_dump_once: true if firmware dump must be prevented once
  * @in_d3: indicates FW is in suspend mode and should be resumed
+ * @resuming: indicates the driver is resuming from wowlan
  * @in_hw_restart: indicates that we are currently in restart flow.
  *	rather than restarted. Should be unset upon restart.
  * @radio_kill: bitmap of radio kill status
@@ -237,6 +238,7 @@ struct iwl_mld {
 		    do_not_dump_once:1,
 #ifdef CONFIG_PM_SLEEP
 		    in_d3:1,
+		    resuming:1,
 #endif
 		    in_hw_restart:1;
 
-- 
2.34.1


