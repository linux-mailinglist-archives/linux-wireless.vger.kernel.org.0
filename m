Return-Path: <linux-wireless+bounces-25787-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D411B0D074
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 05:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C6C188E3C4
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 03:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC86828B7F0;
	Tue, 22 Jul 2025 03:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVKHkeYN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381D628B7D0
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 03:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155720; cv=none; b=QWqzPNqj/wUnWMSLNE9F2PEaNWZ4sSVoiWbTkiQayV6B+su9wpTF4pl9pOZKVJ/kzKEt+p4T8OZE7F5h88x38nsE1qnZZSl5yTNQta0G0eT3o0qNX57HGLw1HRpEZEC2AcPwuyoO3mrz1uFtboSET5oL4sXrpTbOvMxNm2SrysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155720; c=relaxed/simple;
	bh=4Us21ubapp+32DxdDcJWWqTfVyMAyu0sdSYhiVarmng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eAYRvn2IRQ50PVkjOKfkcALt9foNf+XKkYoVlipZOhzUo0jto7Ancxj0wxZy3w3NVakwlU1zDKcm7lCWvemMo2Q3cIQRGfEaaImjLd5au6n2qDFB10LiSGmQ9PGw5OP/i/Uo1LgBI6zN2IUdFUmZpQaWXmVmkA+IPJ6dTrG+SS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BVKHkeYN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753155719; x=1784691719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Us21ubapp+32DxdDcJWWqTfVyMAyu0sdSYhiVarmng=;
  b=BVKHkeYNFKUm25jFNWLgdHqgIxGnNBYjWBzik5yxvyJjZ0HQ3ZohpqFg
   LuGeazUiUPQZb0CkNaMMQiuhRRSIj56m3tbOvGn7APT28YEbZnUYEmy1P
   IKd/TyFTmNXjU9d6WyvrN88ApVGLZShFAzMZLHsGDtwWeL5RJu/Fbx0YG
   wspre1C7kHU65T4EKe3bjvn1BA+Bfasw2y+FpkBUAHkqO/WjAR6zJZNVQ
   XEpPSGKIalGOY4aKxRKqZpC3EsMCfAoFQf8F626NAcoTe33c90q29diP+
   7KV2UDqQDMO9t6ZkdQf4B8mQkRygFFBrNqd8u+9oHX9QOnDg05aNW3LRV
   w==;
X-CSE-ConnectionGUID: oqCs21/IRJ+GAce9dpRtXw==
X-CSE-MsgGUID: AA6NtH3VTBKKvsWIhbLtNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="43006160"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="43006160"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:41:59 -0700
X-CSE-ConnectionGUID: INdHjgpnTr+EzlHm+BimCA==
X-CSE-MsgGUID: NL0OXJ0nSpuMIqrSssj98g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="159338110"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:41:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: mvm: Remove NAN support
Date: Tue, 22 Jul 2025 06:41:18 +0300
Message-Id: <20250722063923.39d731dc2a96.I0357e383ab5df72d8b87e0dee10609a6946865b6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
References: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

NAN is not officially supported on any of the MVM devices so there
is no need to maintain it.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 6 ------
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c  | 9 ---------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      | 1 -
 drivers/net/wireless/intel/iwlwifi/mvm/power.c    | 1 -
 5 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 7d2b496aadc5..8805ab344895 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -301,7 +301,7 @@ int iwl_mvm_mac_ctxt_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	iwl_mvm_init_link(&mvmvif->deflink);
 
-	/* No need to allocate data queues to P2P Device MAC and NAN.*/
+	/* No need to allocate data queues to P2P Device MAC */
 	if (vif->type == NL80211_IFTYPE_P2P_DEVICE)
 		return 0;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 55ae1caded53..ed19b82d14fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1833,12 +1833,6 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 
 	rcu_assign_pointer(mvm->vif_id_to_mac[mvmvif->id], vif);
 
-	/* Currently not much to do for NAN */
-	if (vif->type == NL80211_IFTYPE_NAN) {
-		ret = 0;
-		goto out;
-	}
-
 	/*
 	 * The AP binding flow can be done only after the beacon
 	 * template is configured (which happens only in the mac80211
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
index 3f8b840871d3..2d116a41913c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
@@ -282,9 +282,6 @@ int iwl_mvm_mld_mac_ctxt_add(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ret;
 
-	if (WARN_ON_ONCE(vif->type == NL80211_IFTYPE_NAN))
-		return -EOPNOTSUPP;
-
 	if (WARN_ONCE(mvmvif->uploaded, "Adding active MAC %pM/%d\n",
 		      vif->addr, ieee80211_vif_type_p2p(vif)))
 		return -EIO;
@@ -307,9 +304,6 @@ int iwl_mvm_mld_mac_ctxt_changed(struct iwl_mvm *mvm,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-	if (WARN_ON_ONCE(vif->type == NL80211_IFTYPE_NAN))
-		return -EOPNOTSUPP;
-
 	if (WARN_ONCE(!mvmvif->uploaded, "Changing inactive MAC %pM/%d\n",
 		      vif->addr, ieee80211_vif_type_p2p(vif)))
 		return -EIO;
@@ -327,9 +321,6 @@ int iwl_mvm_mld_mac_ctxt_remove(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	};
 	int ret;
 
-	if (WARN_ON_ONCE(vif->type == NL80211_IFTYPE_NAN))
-		return -EOPNOTSUPP;
-
 	if (WARN_ONCE(!mvmvif->uploaded, "Removing inactive MAC %pM/%d\n",
 		      vif->addr, ieee80211_vif_type_p2p(vif)))
 		return -EIO;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index af73ff09d609..fdaeefa305e1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1325,7 +1325,6 @@ struct iwl_mvm {
 		u8 range_resp;
 	} cmd_ver;
 
-	struct ieee80211_vif *nan_vif;
 	struct iwl_mvm_baid_data __rcu *baid_map[IWL_MAX_BAID];
 
 	/*
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index 0057fddf88f0..610de29b7be0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -231,7 +231,6 @@ static void iwl_mvm_allow_uapsd_iterator(void *_data, u8 *mac,
 	switch (vif->type) {
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_ADHOC:
-	case NL80211_IFTYPE_NAN:
 		data->allow_uapsd = false;
 		break;
 	case NL80211_IFTYPE_STATION:
-- 
2.34.1


