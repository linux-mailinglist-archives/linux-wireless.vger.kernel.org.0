Return-Path: <linux-wireless+bounces-25900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7883B0EADF
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 08:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02061580014
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 06:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FEC271450;
	Wed, 23 Jul 2025 06:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/YPPRwS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A878526FA76
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 06:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253152; cv=none; b=QmDlMGT0KcGv7E+xZW2ikKpcDmjEV/Hj9SkIghIq+yWq4do5DVLpQP4h4gGfak/Z5I1KDkOXjQsTY95HnU5EksARJYCe4uTKQWoL32iVqGM8alM99J7uS2EyR+K64nOze64+FP/N9de65gZgDAjW1HwoETq/l9ZBFpf0vp8jzoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253152; c=relaxed/simple;
	bh=4Us21ubapp+32DxdDcJWWqTfVyMAyu0sdSYhiVarmng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ReFTKMFYK65WqtOAMo/2PK/mOLyJu90DGQ7KfkeNB0Bk1wRnJMQWWARcFSGhyNwi+XqAtnL/CPuLzh4uxxUN3YObmfI1GU2nSd7oUYC1LRg/33VMjMpj9y7yD2O1coKHQi4vDeDp/1OK1Qixn+PnqAOeuqVSUK9OmoER6FoRm6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/YPPRwS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753253150; x=1784789150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Us21ubapp+32DxdDcJWWqTfVyMAyu0sdSYhiVarmng=;
  b=F/YPPRwSROWP34UTyjrrGJDtj1QAy9NlNFzpnIWS0peotDt7su+GXF5e
   X2rpFzg1fae2y9ZcFupenJnDayzlH/GlL0339hQwXOdTOoRQQv5GVF1zq
   /hSW40j7Yzo665zvVwvSs4t/BPprO/AwrR3R9ZU4/5UnNEYu/dJC9Vouh
   HD2+PMjoaK5D6zxon9UaFh9toh2A2s0VO53Bck+7Br8xbGT+lpMIW09+6
   D3RVuey6jReFmVNWkBcW6x0Qo+tHL0uuLXIpSVQxpdvqWywGKI7EcD1e0
   4ljr7uif5bqIYoOvw/pDjXGU11OVMH6Ym/bZtNr6O5gU/VTZYEQ20jIYd
   A==;
X-CSE-ConnectionGUID: RWwZ/Nx1RDmuVEtEZlYKTQ==
X-CSE-MsgGUID: F/xznxarRAmuaw723DARvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59340757"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59340757"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:45:45 -0700
X-CSE-ConnectionGUID: 9dVCSs2rRa68gIPbV341rg==
X-CSE-MsgGUID: PPp6sU42TYmRIf1q7g0low==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159918088"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:45:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next 06/14] wifi: iwlwifi: mvm: Remove NAN support
Date: Wed, 23 Jul 2025 09:45:07 +0300
Message-Id: <20250723094230.b327adbf35c0.I0357e383ab5df72d8b87e0dee10609a6946865b6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723064515.2084903-1-miriam.rachel.korenblit@intel.com>
References: <20250723064515.2084903-1-miriam.rachel.korenblit@intel.com>
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


