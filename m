Return-Path: <linux-wireless+bounces-26502-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C09B2F8E2
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 14:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646ED3B0E87
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 12:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F903218BA;
	Thu, 21 Aug 2025 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U76rw89q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6E9320CC4
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780311; cv=none; b=GmqZbYhfMYszrysIsq/CfGKSB7iJ0vWUea6OqECg1dZ7TJMs27GZXu3PL6RuRqzxF1sLIlBSGg5XsY19n/hnBlHKEEMLx9kpo8U+FSCWTlWXYI81L4FrM3qJ9TEXJNnyi+guheOJNWMEvuO9dAxGdvkA1GBpvF10MjyFvq+krsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780311; c=relaxed/simple;
	bh=73bRyuet2AQNQqew0FGdlj5i6sZgLAOTPJ1nkDlDAOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XBAmhGSbJvMRbosiJ1GvIqrryJ2+Nav72kxjObgo5GrOsjxuR8+FvrJy29QZGvu+piC//iTctuz12shYxbkp3yYKPB7wF3MlzqD5iQB9Kn12oGJFb+9P4hDDdH7NhseRkq6bABiOnpDa/gwpTcI7Fd3IupKXHDxOqFqYQEQ0CW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U76rw89q; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755780310; x=1787316310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=73bRyuet2AQNQqew0FGdlj5i6sZgLAOTPJ1nkDlDAOo=;
  b=U76rw89q6TtOnwdfKDUDKGeCqvwPwsOG+1Glv0gltpiWrGEf9O18VjGI
   p53xF85z75EMVPnvQgkl7FPmHkTUc+BhM+ZpFjepJOxFXdGqQmfQ7ihe+
   zM7L8ZZ5+JluSEasVhibQt933Oofmb5wCtiZZuzoXxDzb1q1UOLf/p31o
   QAqSA0mMkjnhiALamiPH8wQBexN7RTG+6U+RVtx2MhUKpF6sIhhmkLhBU
   oQMv7ZE2Jh3g58qoqRBzbyU2nQnG5JOmpPWGuRlfI7kkqAJ/zLu50EsQP
   56uZLi5Eo+Vakfwd3ZKZM8jWpdX69WM469VyJJeSHSXQMXV7qIGDqv40D
   g==;
X-CSE-ConnectionGUID: xYaC4MTCQn2/6Hqyqfw7Mg==
X-CSE-MsgGUID: TbHjwCelTwGKEoo9taB5HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="61895749"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="61895749"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:45:09 -0700
X-CSE-ConnectionGUID: td4Ys6ArSjGBtui7RhgRVw==
X-CSE-MsgGUID: a0Vqq1hWTTy3zj3cj0Ysiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="172622192"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:45:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: mld/mvm: set beacon protection capability in wowlan config
Date: Thu, 21 Aug 2025 15:44:25 +0300
Message-Id: <20250821154216.d3968487865e.I784f564ab85f618f26d3f082197a384bb219e07c@changeid>
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

Although the FW knows if a BIGTK was installed and can conclude from
that the beacon protection capability, the specific component
of the FW that is responsible for rekeying while in wowlan, doesn't know
what keys were installed.
So we need to tell that the FW when we go to wowlan, otherwise it will
ignore the BIGTK rekey, if such occurs.
Set this bit when needed.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h |  1 +
 drivers/net/wireless/intel/iwlwifi/mld/d3.c    |  8 ++++++--
 drivers/net/wireless/intel/iwlwifi/mld/key.c   | 12 ++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/key.h   |  3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c    |  4 ++++
 5 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index 53445087e9cb..9103f70c41c0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -367,6 +367,7 @@ enum iwl_wowlan_flags {
 	ENABLE_NBNS_FILTERING	= BIT(2),
 	ENABLE_DHCP_FILTERING	= BIT(3),
 	ENABLE_STORE_BEACON	= BIT(4),
+	HAS_BEACON_PROTECTION	= BIT(5),
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index da621fe11d62..86bb3a7a9f7f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1570,7 +1570,8 @@ static void
 iwl_mld_set_wowlan_config_cmd(struct iwl_mld *mld,
 			      struct cfg80211_wowlan *wowlan,
 			      struct iwl_wowlan_config_cmd *wowlan_config_cmd,
-			      struct ieee80211_sta *ap_sta)
+			      struct ieee80211_sta *ap_sta,
+			      struct ieee80211_bss_conf *link)
 {
 	wowlan_config_cmd->is_11n_connection =
 					ap_sta->deflink.ht_cap.ht_supported;
@@ -1580,6 +1581,9 @@ iwl_mld_set_wowlan_config_cmd(struct iwl_mld *mld,
 	if (ap_sta->mfp)
 		wowlan_config_cmd->flags |= IS_11W_ASSOC;
 
+	if (iwl_mld_beacon_protection_enabled(mld, link))
+		wowlan_config_cmd->flags |= HAS_BEACON_PROTECTION;
+
 	if (wowlan->disconnect)
 		wowlan_config_cmd->wakeup_filter |=
 			cpu_to_le32(IWL_WOWLAN_WAKEUP_BEACON_MISS |
@@ -1777,7 +1781,7 @@ iwl_mld_wowlan_config(struct iwl_mld *mld, struct ieee80211_vif *bss_vif,
 		return ret;
 
 	iwl_mld_set_wowlan_config_cmd(mld, wowlan,
-				      &wowlan_config_cmd, ap_sta);
+				      &wowlan_config_cmd, ap_sta, link_conf);
 	ret = iwl_mld_send_cmd_pdu(mld, WOWLAN_CONFIGURATION,
 				   &wowlan_config_cmd);
 	if (ret)
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/key.c b/drivers/net/wireless/intel/iwlwifi/mld/key.c
index a90477971c72..04192c5f07ff 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/key.c
@@ -394,3 +394,15 @@ void iwl_mld_track_bigtk(struct iwl_mld *mld,
 	else
 		RCU_INIT_POINTER(link->bigtks[key->keyidx - 6], NULL);
 }
+
+bool iwl_mld_beacon_protection_enabled(struct iwl_mld *mld,
+				       struct ieee80211_bss_conf *link)
+{
+	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
+
+	if (WARN_ON(!mld_link))
+		return false;
+
+	return rcu_access_pointer(mld_link->bigtks[0]) ||
+		rcu_access_pointer(mld_link->bigtks[1]);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/key.h b/drivers/net/wireless/intel/iwlwifi/mld/key.h
index 63de3469270a..5a9efdaa3b03 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/key.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/key.h
@@ -40,4 +40,7 @@ void iwl_mld_track_bigtk(struct iwl_mld *mld,
 			 struct ieee80211_vif *vif,
 			 struct ieee80211_key_conf *key, bool add);
 
+bool iwl_mld_beacon_protection_enabled(struct iwl_mld *mld,
+				       struct ieee80211_bss_conf *link);
+
 #endif /* __iwl_mld_key_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index a31bc2af5300..198a280b60f9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -928,6 +928,10 @@ iwl_mvm_get_wowlan_config(struct iwl_mvm *mvm,
 	if (ap_sta->mfp)
 		wowlan_config_cmd->flags |= IS_11W_ASSOC;
 
+	if (rcu_access_pointer(mvmvif->bcn_prot.keys[0]) ||
+	    rcu_access_pointer(mvmvif->bcn_prot.keys[1]))
+		wowlan_config_cmd->flags |= HAS_BEACON_PROTECTION;
+
 	if (iwl_fw_lookup_cmd_ver(mvm->fw, WOWLAN_CONFIGURATION, 0) < 6) {
 		/* Query the last used seqno and set it */
 		int ret = iwl_mvm_get_last_nonqos_seq(mvm, vif);
-- 
2.34.1


