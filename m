Return-Path: <linux-wireless+bounces-4537-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A380D877AEC
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 07:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308281F2188D
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 06:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3FF11725;
	Mon, 11 Mar 2024 06:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qlw9pORt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D0410A3D
	for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 06:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710138518; cv=none; b=Pf9HNZmiJ7HIn+BY84Fk5mpabebvZhwaejNcvrTqhYNeP7wgiwBlNjR/nbwhbt4TrtkpATE+QV+1nvDNaPSP5SseptGQgsgM/YYkZ1MQVnPTpBAZVIXBXzwSC2/KW23pjx81wHNoAc+/Jtb3dZ+4FT5Y/bW7LykaCAgtQVfz0MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710138518; c=relaxed/simple;
	bh=/AFgTFhfR7p7xvI77drSX6nxgl4ITPjkU0kRghTLhyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cFVI7Zm0FVz6+hAm+b4urd8H5u1l4Jw7+Us3vUB81igxmxyFvJRydvIvJ2KeRdCB2hNG1lbqnHeJAW6QnkDuKvMEW4qywiRl4wjOWaVnQBaHpQHIMKoyivO56CyJE41Hz8UzvaMU5QurrHkpWjGhxw6igpEsJK/1yb81eCkYcxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qlw9pORt; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710138517; x=1741674517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/AFgTFhfR7p7xvI77drSX6nxgl4ITPjkU0kRghTLhyc=;
  b=Qlw9pORtWL4NtFNe9VPMfRK/cC9u16NlYjGcaCnkWah2s33MeovShMyZ
   BN/gGv4qrz3230WGnUZOKRyU/bAvy5YIiDuwz9cJYi07A1YmIU/mFEiPz
   SLQC4SP8L7eAlmF2e2x8uC3ChA7miiSu3JZ4OW3knquaGz7srlHpHj7OK
   NEdSh1A1LRjx4GYY8UcirJ6bNlcUPXLn1HWscHY2CogR0YL34USzXhFrS
   Qc2EfNCEA0WPfqrpNRvvBkcHuTOVRv2OnWypYrFFUOQChpVNPMWDXW+Kt
   UfQ2/GKZO//mD0IjQWCsIbfktiMcZ1on/11Cx7YuTqBowzGQ7EIztcQsn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="30226745"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="30226745"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="15657635"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 05/15] wifi: iwlwifi: mvm: Configure the link mapping for completeness
Date: Mon, 11 Mar 2024 08:28:05 +0200
Message-Id: <20240311081938.0b5c361e8f0c.Ib11f41815d2efa5d1ec57f855de4c8563142987b@changeid>
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

From: Ilan Peer <ilan.peer@intel.com>

In the non MLD firmware flows, although the deflink is used, the mapping
of link ID to BSS configuration was missing, which causes flows that need
this mapping to crash.

Fix this by adding the link ID to BSS configuration mapping to non MLD
flows as well for completeness.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 59 ++++++++++++++-----
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  7 +++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 ++
 3 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index f13f13e6b71a..9f69e04594e4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -46,6 +46,27 @@ static int iwl_mvm_link_cmd_send(struct iwl_mvm *mvm,
 	return ret;
 }
 
+int iwl_mvm_set_link_mapping(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			     struct ieee80211_bss_conf *link_conf)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_vif_link_info *link_info =
+		mvmvif->link[link_conf->link_id];
+
+	if (link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID) {
+		link_info->fw_link_id = iwl_mvm_get_free_fw_link_id(mvm,
+								    mvmvif);
+		if (link_info->fw_link_id >=
+		    ARRAY_SIZE(mvm->link_id_to_link_conf))
+			return -EINVAL;
+
+		rcu_assign_pointer(mvm->link_id_to_link_conf[link_info->fw_link_id],
+				   link_conf);
+	}
+
+	return 0;
+}
+
 int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		     struct ieee80211_bss_conf *link_conf)
 {
@@ -55,19 +76,14 @@ int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	struct iwl_link_config_cmd cmd = {};
 	unsigned int cmd_id = WIDE_ID(MAC_CONF_GROUP, LINK_CONFIG_CMD);
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 1);
+	int ret;
 
 	if (WARN_ON_ONCE(!link_info))
 		return -EINVAL;
 
-	if (link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID) {
-		link_info->fw_link_id = iwl_mvm_get_free_fw_link_id(mvm,
-								    mvmvif);
-		if (link_info->fw_link_id >= ARRAY_SIZE(mvm->link_id_to_link_conf))
-			return -EINVAL;
-
-		rcu_assign_pointer(mvm->link_id_to_link_conf[link_info->fw_link_id],
-				   link_conf);
-	}
+	ret = iwl_mvm_set_link_mapping(mvm, vif, link_conf);
+	if (ret)
+		return ret;
 
 	/* Update SF - Disable if needed. if this fails, SF might still be on
 	 * while many macs are bound, which is forbidden - so fail the binding.
@@ -248,6 +264,24 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return ret;
 }
 
+int iwl_mvm_unset_link_mapping(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			       struct ieee80211_bss_conf *link_conf)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_vif_link_info *link_info =
+		mvmvif->link[link_conf->link_id];
+
+	/* mac80211 thought we have the link, but it was never configured */
+	if (WARN_ON(!link_info ||
+		    link_info->fw_link_id >=
+		    ARRAY_SIZE(mvm->link_id_to_link_conf)))
+		return -EINVAL;
+
+	RCU_INIT_POINTER(mvm->link_id_to_link_conf[link_info->fw_link_id],
+			 NULL);
+	return 0;
+}
+
 int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			struct ieee80211_bss_conf *link_conf)
 {
@@ -257,13 +291,10 @@ int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	struct iwl_link_config_cmd cmd = {};
 	int ret;
 
-	/* mac80211 thought we have the link, but it was never configured */
-	if (WARN_ON(!link_info ||
-		    link_info->fw_link_id >= ARRAY_SIZE(mvm->link_id_to_link_conf)))
+	ret = iwl_mvm_unset_link_mapping(mvm, vif, link_conf);
+	if (ret)
 		return 0;
 
-	RCU_INIT_POINTER(mvm->link_id_to_link_conf[link_info->fw_link_id],
-			 NULL);
 	cmd.link_id = cpu_to_le32(link_info->fw_link_id);
 	iwl_mvm_release_fw_link_id(mvm, link_info->fw_link_id);
 	link_info->fw_link_id = IWL_MVM_FW_LINK_ID_INVALID;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index f51e8e83b0a9..b8488984cc0e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1580,8 +1580,14 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 	mvmvif->mvm = mvm;
 
 	/* the first link always points to the default one */
+	mvmvif->deflink.fw_link_id = IWL_MVM_FW_LINK_ID_INVALID;
+	mvmvif->deflink.active = 0;
 	mvmvif->link[0] = &mvmvif->deflink;
 
+	ret = iwl_mvm_set_link_mapping(mvm, vif, &vif->bss_conf);
+	if (ret)
+		goto out;
+
 	/*
 	 * Not much to do here. The stack will not allow interface
 	 * types or combinations that we didn't advertise, so we
@@ -1786,6 +1792,7 @@ static void iwl_mvm_mac_remove_interface(struct ieee80211_hw *hw,
 		mvm->p2p_device_vif = NULL;
 	}
 
+	iwl_mvm_unset_link_mapping(mvm, vif, &vif->bss_conf);
 	iwl_mvm_mac_ctxt_remove(mvm, vif);
 
 	RCU_INIT_POINTER(mvm->vif_id_to_mac[mvmvif->id], NULL);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index b23fc84e3620..f932a4382912 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1915,11 +1915,15 @@ int iwl_mvm_binding_remove_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 u32 iwl_mvm_get_lmac_id(struct iwl_mvm *mvm, enum nl80211_band band);
 
 /* Links */
+int iwl_mvm_set_link_mapping(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			     struct ieee80211_bss_conf *link_conf);
 int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		     struct ieee80211_bss_conf *link_conf);
 int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 struct ieee80211_bss_conf *link_conf,
 			 u32 changes, bool active);
+int iwl_mvm_unset_link_mapping(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			       struct ieee80211_bss_conf *link_conf);
 int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			struct ieee80211_bss_conf *link_conf);
 int iwl_mvm_disable_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-- 
2.34.1


