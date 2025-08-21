Return-Path: <linux-wireless+bounces-26534-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1569B30172
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 19:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D61760226F
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 17:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212EF34320F;
	Thu, 21 Aug 2025 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nYK6uYvZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E33A3431FD
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798483; cv=none; b=QLoX0rJRcaKN7JGfvdZuRYFtreg0Z4tNShnFrwgNCTUpA2j+9LEiYVZRBxyRlq5GfULtvfBqGmQeSomSjdBGdkxa7m2BEiaFyCzim7yKZCOIGCRjgh6szBr9AYBmdcT95bW3Tdl/3PKBVFq/jMUZqub7F5MKSXzAZq5vkngxuvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798483; c=relaxed/simple;
	bh=73bRyuet2AQNQqew0FGdlj5i6sZgLAOTPJ1nkDlDAOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HLzMq1E8tWfPKvN0uGvY5UYQ9Tdr9f3m5YUXTvRQEJ7QiAguzogaTuTTUimsL9UQiF6M4hQv/6EIhxj7j9DZXxOMyl2BNL0G7ncad6mB13qE1EUCLFcVfjSynyv2RMQCMov9/vbPYLiPciUV9yWDENtVOKU3u5rN6loRzTgcaWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nYK6uYvZ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755798481; x=1787334481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=73bRyuet2AQNQqew0FGdlj5i6sZgLAOTPJ1nkDlDAOo=;
  b=nYK6uYvZ1Xy2d5AxgzsYaZhK2J1O2k5IW3HpDlp3wcfjD1Sj8DiXGRD0
   Wv8M3OtKLRIs7j7AYB2sfgMO3RNXe1FPKGg5UPyCnZ24NLzFm88mLAa9F
   gwyMlKRc6BuoivY/l+RwHDVuq7kU980fBn7XxmoxK0NvH8Uoda3eIqzbe
   YSSfUpwMGI44U+uZwwhqYrriN47yHkwBocxanyLOEOw2xmLNjWA2car1B
   4qgaOMHQIy36dv+9oj/V9tfxHU6ELEhRnPtgbgmXiVFwCNkslSuXCKdbQ
   QeTZfZITwxOBG4aObYRWVyCM5mCLo6eTonmJteJR4HNFGoRTsexbiMmaC
   w==;
X-CSE-ConnectionGUID: 0hJiVsZwS8+rcOatgxwBGA==
X-CSE-MsgGUID: aL/JNH+uS+S/Wip4YleOcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68806072"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="68806072"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:48:01 -0700
X-CSE-ConnectionGUID: fL6vyJ1XT664w+YE3zhqRA==
X-CSE-MsgGUID: kMMOrGrcQvKdYZuXC9QjJA==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:48:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 07/15] wifi: iwlwifi: mld/mvm: set beacon protection capability in wowlan config
Date: Thu, 21 Aug 2025 20:47:18 +0300
Message-Id: <20250821204455.d3968487865e.I784f564ab85f618f26d3f082197a384bb219e07c@changeid>
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


