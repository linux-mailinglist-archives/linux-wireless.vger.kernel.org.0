Return-Path: <linux-wireless+bounces-26532-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF90EB30167
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 19:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA801BA87AC
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 17:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29813431F2;
	Thu, 21 Aug 2025 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WiRyig5P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F853341AA9
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798480; cv=none; b=QYsisve1FE257297pduQJUxVsW9SgqJ8QM6uChoc3ONYsTCxfQrVdd1oalY3EQSBm08RCGh0sY+UI4+GEqWInDGdLwkLM1Lc1V4nrw7vxbq2b2DLH1IsHO/8jDSrYF+MHSM1yGETyAyxDGnZBQ/SCwgW12i+ymbZos41aCIECUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798480; c=relaxed/simple;
	bh=IuWMIZNwe8RGKyVihcZ3FjTk/+4UEbjQhuBJVX2lH28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EsAgFaJwEEQOMZCBpSFM6+LqgBnV+DCIXRwtGE4E5Q+9hqjP5/HZo9/4CkeAqmAyMHOF/miyy1KvqIa43hOyW9LphfZ/sm0JHO4Ykfb3lBQGRXjQewpndoKLhi9OBIm0CfF8XqmipcxAVZUonp54QvzeKqYunEGySAaTftcUK9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WiRyig5P; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755798479; x=1787334479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IuWMIZNwe8RGKyVihcZ3FjTk/+4UEbjQhuBJVX2lH28=;
  b=WiRyig5PVB5iX0GyRMWfM9/Wg2iuM+9NpWpRd5oGaA7TSbGfBsXMD8YK
   5/4HS5aYcceURxTmyki1z+ZZ91Lf4rnALmm+CMWxk8OpnbR2ikkXtAWPP
   IDAL/ldTydW/aPbg6dh5bubkfTlQDIKL4UMbA2TJTp5mkUzJQr8bi7WMy
   g0e5jEYWyZeyqyWcQTzGDCGR/YJSmU8yhecZ7xb9gWWYcHi8h0WQFQOk3
   SHirTJ9F1lGjrvq9ZIBhA8Red64QmrJ1R7yk3FhfYRUMfRZqVX9x0LPRk
   UUO8a5Jg8qFcPHy4qlSUlyFCKkJ6jAkA1uUppmXj5j9IR6gxTi+oDJiFS
   A==;
X-CSE-ConnectionGUID: nwIem8J+TpCUrxaA1wusRQ==
X-CSE-MsgGUID: 1F3dPEuMTte5kFTlHWxnVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68806066"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="68806066"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:47:59 -0700
X-CSE-ConnectionGUID: D3z1uZeGSsOR9FJKTopkWw==
X-CSE-MsgGUID: W+uAUD03TJKeElc9dZlEJg==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:47:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 05/15] wifi: iwlwifi: mld: track BIGTK per link
Date: Thu, 21 Aug 2025 20:47:16 +0300
Message-Id: <20250821204455.0392769d3abb.I5d8e232d663e3ca8fc23de12dd8534cb076cabb9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821174726.2425334-1-miriam.rachel.korenblit@intel.com>
References: <20250821174726.2425334-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

We track the BIGTKs installed for beacon protection purposes.
But in MLO we will have a different BIGTK per link.
Track the BIGTK per-link and not per-vif.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   |  9 +++----
 .../net/wireless/intel/iwlwifi/mld/iface.h    |  3 ---
 drivers/net/wireless/intel/iwlwifi/mld/key.c  | 26 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/key.h  |  4 +++
 drivers/net/wireless/intel/iwlwifi/mld/link.h |  2 ++
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 10 +++----
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   | 13 +++++++---
 7 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index 0ac6ceddb44f..da621fe11d62 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -11,6 +11,7 @@
 #include "mcc.h"
 #include "sta.h"
 #include "mlo.h"
+#include "key.h"
 
 #include "fw/api/d3.h"
 #include "fw/api/offload.h"
@@ -825,12 +826,8 @@ iwl_mld_add_mcast_rekey(struct ieee80211_vif *vif,
 	}
 
 	/* Also keep track of the new BIGTK */
-	if ((key_config->keyidx == 6 || key_config->keyidx == 7) &&
-	    vif->type == NL80211_IFTYPE_STATION) {
-		struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
-
-		rcu_assign_pointer(mld_vif->bigtks[key_config->keyidx - 6], key_config);
-	}
+	if (key_config->keyidx == 6 || key_config->keyidx == 7)
+		iwl_mld_track_bigtk(mld, vif, key_config, true);
 }
 
 static void
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index 05dcb63701b1..38e10e279153 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -125,8 +125,6 @@ struct iwl_mld_emlsr {
  * @ap_sta: pointer to AP sta, for easier access to it.
  *	Relevant only for STA vifs.
  * @authorized: indicates the AP station was set to authorized
- * @bigtks: BIGTKs of the AP, for beacon protection.
- *	Only valid for STA. (FIXME: needs to be per link)
  * @num_associated_stas: number of associated STAs. Relevant only for AP mode.
  * @ap_ibss_active: whether the AP/IBSS was started
  * @cca_40mhz_workaround: When we are connected in 2.4 GHz and 40 MHz, and the
@@ -158,7 +156,6 @@ struct iwl_mld_vif {
 		struct iwl_mld_session_protect session_protect;
 		struct ieee80211_sta *ap_sta;
 		bool authorized;
-		struct ieee80211_key_conf __rcu *bigtks[2];
 		u8 num_associated_stas;
 		bool ap_ibss_active;
 		enum iwl_mld_cca_40mhz_wa_status cca_40mhz_workaround;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/key.c b/drivers/net/wireless/intel/iwlwifi/mld/key.c
index 13462a5ad79a..a90477971c72 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/key.c
@@ -368,3 +368,29 @@ int iwl_mld_update_sta_keys(struct iwl_mld *mld,
 			    &data);
 	return data.err;
 }
+
+void iwl_mld_track_bigtk(struct iwl_mld *mld,
+			 struct ieee80211_vif *vif,
+			 struct ieee80211_key_conf *key, bool add)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_mld_link *link;
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	if (WARN_ON(key->keyidx < 6 || key->keyidx > 7))
+		return;
+
+	if (WARN_ON(key->link_id < 0))
+		return;
+
+	link = iwl_mld_link_dereference_check(mld_vif, key->link_id);
+	if (WARN_ON(!link))
+		return;
+
+	if (add)
+		rcu_assign_pointer(link->bigtks[key->keyidx - 6], key);
+	else
+		RCU_INIT_POINTER(link->bigtks[key->keyidx - 6], NULL);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/key.h b/drivers/net/wireless/intel/iwlwifi/mld/key.h
index a68ea48913be..63de3469270a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/key.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/key.h
@@ -36,4 +36,8 @@ iwl_mld_cleanup_keys_iter(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	key->hw_key_idx = STA_KEY_IDX_INVALID;
 }
 
+void iwl_mld_track_bigtk(struct iwl_mld *mld,
+			 struct ieee80211_vif *vif,
+			 struct ieee80211_key_conf *key, bool add);
+
 #endif /* __iwl_mld_key_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.h b/drivers/net/wireless/intel/iwlwifi/mld/link.h
index cad2c9426349..9e4da8e4de93 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.h
@@ -36,6 +36,7 @@ struct iwl_probe_resp_data {
  * @he_ru_2mhz_block: 26-tone RU OFDMA transmissions should be blocked.
  * @igtk: fw can only have one IGTK at a time, whereas mac80211 can have two.
  *	This tracks the one IGTK that currently exists in FW.
+ * @bigtks: BIGTKs of the AP. Only valid for STA mode.
  * @bcast_sta: station used for broadcast packets. Used in AP, GO and IBSS.
  * @mcast_sta: station used for multicast packets. Used in AP, GO and IBSS.
  * @mon_sta: station used for TX injection in monitor interface.
@@ -59,6 +60,7 @@ struct iwl_mld_link {
 		struct ieee80211_chanctx_conf __rcu *chan_ctx;
 		bool he_ru_2mhz_block;
 		struct ieee80211_key_conf *igtk;
+		struct ieee80211_key_conf __rcu *bigtks[2];
 	);
 	/* And here fields that survive a fw restart */
 	struct iwl_mld_int_sta bcast_sta;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index b0bd01914a91..f434012b03a6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -2065,9 +2065,8 @@ static int iwl_mld_set_key_add(struct iwl_mld *mld,
 		return -EOPNOTSUPP;
 	}
 
-	if (vif->type == NL80211_IFTYPE_STATION &&
-	    (keyidx == 6 || keyidx == 7))
-		rcu_assign_pointer(mld_vif->bigtks[keyidx - 6], key);
+	if (keyidx == 6 || keyidx == 7)
+		iwl_mld_track_bigtk(mld, vif, key, true);
 
 	/* After exiting from RFKILL, hostapd configures GTK/ITGK before the
 	 * AP is started, but those keys can't be sent to the FW before the
@@ -2116,9 +2115,8 @@ static void iwl_mld_set_key_remove(struct iwl_mld *mld,
 		sta ? iwl_mld_sta_from_mac80211(sta) : NULL;
 	int keyidx = key->keyidx;
 
-	if (vif->type == NL80211_IFTYPE_STATION &&
-	    (keyidx == 6 || keyidx == 7))
-		RCU_INIT_POINTER(mld_vif->bigtks[keyidx - 6], NULL);
+	if (keyidx == 6 || keyidx == 7)
+		iwl_mld_track_bigtk(mld, vif, key, false);
 
 	if (mld_sta && key->flags & IEEE80211_KEY_FLAG_PAIRWISE &&
 	    (key->cipher == WLAN_CIPHER_SUITE_CCMP ||
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index b6dedd1ecd4d..53cac9d8018c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -1619,12 +1619,14 @@ static int iwl_mld_rx_mgmt_prot(struct ieee80211_sta *sta,
 				u32 mpdu_status,
 				u32 mpdu_len)
 {
+	struct iwl_mld_link *link;
 	struct wireless_dev *wdev;
 	struct iwl_mld_sta *mld_sta;
 	struct iwl_mld_vif *mld_vif;
 	u8 keyidx;
 	struct ieee80211_key_conf *key;
 	const u8 *frame = (void *)hdr;
+	u8 link_id;
 
 	if ((mpdu_status & IWL_RX_MPDU_STATUS_SEC_MASK) ==
 	     IWL_RX_MPDU_STATUS_SEC_NONE)
@@ -1657,12 +1659,17 @@ static int iwl_mld_rx_mgmt_prot(struct ieee80211_sta *sta,
 		return 0;
 	}
 
+	link_id = rx_status->link_valid ? rx_status->link_id : 0;
+	link = rcu_dereference(mld_vif->link[link_id]);
+	if (WARN_ON_ONCE(!link))
+		return -1;
+
 	/* both keys will have the same cipher and MIC length, use
 	 * whichever one is available
 	 */
-	key = rcu_dereference(mld_vif->bigtks[0]);
+	key = rcu_dereference(link->bigtks[0]);
 	if (!key) {
-		key = rcu_dereference(mld_vif->bigtks[1]);
+		key = rcu_dereference(link->bigtks[1]);
 		if (!key)
 			goto report;
 	}
@@ -1680,7 +1687,7 @@ static int iwl_mld_rx_mgmt_prot(struct ieee80211_sta *sta,
 		if (keyidx != 6 && keyidx != 7)
 			return -1;
 
-		key = rcu_dereference(mld_vif->bigtks[keyidx - 6]);
+		key = rcu_dereference(link->bigtks[keyidx - 6]);
 		if (!key)
 			goto report;
 	}
-- 
2.34.1


