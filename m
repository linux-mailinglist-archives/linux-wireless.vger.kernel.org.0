Return-Path: <linux-wireless+bounces-6388-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAB28A6929
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 12:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550FC281D95
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 10:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94465129E9F;
	Tue, 16 Apr 2024 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NCxjPuYL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E0012838A
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264884; cv=none; b=iJxy8qzT8oQmwMoN87g0by7hebvppULIGcIFtjrwyAnCG4bZTc9Gpv0bcrmlYZY/ecptPw1B1PXyEzSgsWfR0eYll9cO6sH+W+3L50+IN8Fv2ugxTBkNv4WIgAJQthKq7w0Tdl/9dfaWf7ucG4NvB0gmvXEHW5jm2awUK/YMSqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264884; c=relaxed/simple;
	bh=jQYHG4saoJkL6RZdFxtzDLzhl74TGmwS1U2y2PbZkho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ExX492KkVQeD8aDnKqa1+o/gqRfoKM4YxHkznQ0fmxb2j7TbExc+mdgHqDKdyJ8mod8RvspvWewVLHNMEEsRIxEiF9GYUNZtaSnpPTxdVp8Z44qWec4UCih/3ObqjWjx1djZpBHfP2AK+t+NbuiUOaIEgioKo7AxMlZnVSUUOMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NCxjPuYL; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713264883; x=1744800883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jQYHG4saoJkL6RZdFxtzDLzhl74TGmwS1U2y2PbZkho=;
  b=NCxjPuYLNZ1s38/PTWJ4L8fSeu0BTGnhii6OA3oSKW5g2fDyeiy/NTGn
   vEaYm+VdcNtaZtgZU337fDx4DCncfZ8XLI0PFa5akRpqvcnD09dKHj4Jp
   nZjWupnLhLE5P25GNQnGRvbGgEvdf3+6b2Ii5s4yokgdHXzhCxg7eUaqa
   luot3p6EutVKIOeFnQ52Ntz7JdsR1wfPMv53gNbRdai7EcfcIBVK+c7kJ
   +4FQzkYP1D9urfs7pCqKTd17JFRsQgaWj+9vQDmN9yrOoOSVl75fhpgJx
   YM5Jfm65wk6EtTQ+NcBavJPZ7lO1yt+iN3wGuXaBAxHAZCDBYz+BSNqTU
   Q==;
X-CSE-ConnectionGUID: SgY8BHWgSkiOY2HWN7yY9A==
X-CSE-MsgGUID: A/nJXiD0TFKejAOhGfA1zA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8556060"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8556060"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:42 -0700
X-CSE-ConnectionGUID: 76pNOfppRTO1bs92McddHA==
X-CSE-MsgGUID: L/H5yzbBTeKCNbeeuvilfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26872542"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:41 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 11/16] wifi: iwlwifi: mvm: exit EMLSR upon missed beacon
Date: Tue, 16 Apr 2024 13:54:06 +0300
Message-Id: <20240416134215.f9111c79cb53.Ie95ea60149a9bc4367f6b338b37c8635051351ba@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416105411.706221-1-miriam.rachel.korenblit@intel.com>
References: <20240416105411.706221-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

In case of more than 6 missed beacons on one of the links,
exit EMLSR by deactivating that link.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/constants.h    |  3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 22 +++++++++++++++++--
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 21 +++++++++---------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  5 +++++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  3 ++-
 5 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index f5122c4678a1..a79395d8c0f1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
- * Copyright (C) 2013-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2013-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2015 Intel Deutschland GmbH
  */
 #ifndef __MVM_CONSTANTS_H
@@ -123,5 +123,6 @@
 #define IWL_MVM_6GHZ_PASSIVE_SCAN_TIMEOUT       3000 /* in seconds */
 #define IWL_MVM_6GHZ_PASSIVE_SCAN_ASSOC_TIMEOUT 60   /* in seconds */
 #define IWL_MVM_AUTO_EML_ENABLE                 true
+#define IWL_MVM_MISSED_BEACONS_EXIT_ESR_THRESH	7
 
 #endif /* __MVM_CONSTANTS_H */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 8a4b1b89791c..acbe8e6f14c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -527,6 +527,7 @@ u8 iwl_mvm_set_link_selection_data(struct ieee80211_vif *vif,
 	u16 max_grade = 0;
 	unsigned long link_id;
 
+	/* TODO: don't select links that weren't discovered in the last scan */
 	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct ieee80211_bss_conf *link_conf =
 			link_conf_dereference_protected(vif, link_id);
@@ -692,6 +693,25 @@ u8 iwl_mvm_get_primary_link(struct ieee80211_vif *vif)
 	return __ffs(vif->active_links);
 }
 
+/*
+ * For non-MLO/single link, this will return the deflink/single active link,
+ * respectively
+ */
+u8 iwl_mvm_get_other_link(struct ieee80211_vif *vif, u8 link_id)
+{
+	switch (hweight16(vif->active_links)) {
+	case 0:
+		return 0;
+	default:
+		WARN_ON(1);
+		fallthrough;
+	case 1:
+		return __ffs(vif->active_links);
+	case 2:
+		return __ffs(vif->active_links & ~BIT(link_id));
+	}
+}
+
 /* API to exit eSR mode */
 void iwl_mvm_exit_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		      enum iwl_mvm_esr_state reason,
@@ -720,8 +740,6 @@ void iwl_mvm_exit_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	ieee80211_set_active_links_async(vif, new_active_links);
 }
 
-#define IWL_MVM_BLOCK_ESR_REASONS IWL_MVM_ESR_BLOCKED_COEX
-
 void iwl_mvm_block_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		       enum iwl_mvm_esr_state reason,
 		       u8 link_to_keep)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 228ede7b8957..2718db5aa3f5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1591,23 +1591,23 @@ void iwl_mvm_rx_missed_beacons_notif(struct iwl_mvm *mvm,
 	u32 id = le32_to_cpu(mb->link_id);
 	union iwl_dbg_tlv_tp_data tp_data = { .fw_pkt = pkt };
 	u32 mac_type;
+	int link_id = -1;
 	u8 notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
 					       MISSED_BEACONS_NOTIFICATION,
 					       0);
 
-	rcu_read_lock();
-
 	/* before version four the ID in the notification refers to mac ID */
 	if (notif_ver < 4) {
-		vif = iwl_mvm_rcu_dereference_vif_id(mvm, id, true);
+		vif = iwl_mvm_rcu_dereference_vif_id(mvm, id, false);
 	} else {
 		struct ieee80211_bss_conf *bss_conf =
-			iwl_mvm_rcu_fw_link_id_to_link_conf(mvm, id, true);
+			iwl_mvm_rcu_fw_link_id_to_link_conf(mvm, id, false);
 
 		if (!bss_conf)
-			goto out;
+			return;
 
 		vif = bss_conf->vif;
+		link_id = bss_conf->link_id;
 	}
 
 	IWL_DEBUG_INFO(mvm,
@@ -1620,7 +1620,7 @@ void iwl_mvm_rx_missed_beacons_notif(struct iwl_mvm *mvm,
 		       le32_to_cpu(mb->num_expected_beacons));
 
 	if (!vif)
-		goto out;
+		return;
 
 	mac_type = iwl_mvm_get_mac_type(vif);
 
@@ -1647,6 +1647,10 @@ void iwl_mvm_rx_missed_beacons_notif(struct iwl_mvm *mvm,
 				 "missed_beacons:%d, missed_beacons_since_rx:%d\n",
 				 rx_missed_bcon, rx_missed_bcon_since_rx);
 		}
+	} else if (rx_missed_bcon >= IWL_MVM_MISSED_BEACONS_EXIT_ESR_THRESH &&
+		   link_id >= 0 && hweight16(vif->active_links) > 1) {
+		iwl_mvm_exit_esr(mvm, vif, IWL_MVM_ESR_EXIT_MISSED_BEACON,
+				 iwl_mvm_get_other_link(vif, link_id));
 	} else if (rx_missed_bcon_since_rx > IWL_MVM_MISSED_BEACONS_THRESHOLD) {
 		if (!iwl_mvm_has_new_tx_api(mvm))
 			ieee80211_beacon_loss(vif);
@@ -1660,7 +1664,7 @@ void iwl_mvm_rx_missed_beacons_notif(struct iwl_mvm *mvm,
 	trigger = iwl_fw_dbg_trigger_on(&mvm->fwrt, ieee80211_vif_to_wdev(vif),
 					FW_DBG_TRIGGER_MISSED_BEACONS);
 	if (!trigger)
-		goto out;
+		return;
 
 	bcon_trig = (void *)trigger->data;
 	stop_trig_missed_bcon = le32_to_cpu(bcon_trig->stop_consec_missed_bcon);
@@ -1672,9 +1676,6 @@ void iwl_mvm_rx_missed_beacons_notif(struct iwl_mvm *mvm,
 	if (rx_missed_bcon_since_rx >= stop_trig_missed_bcon_since_rx ||
 	    rx_missed_bcon >= stop_trig_missed_bcon)
 		iwl_fw_dbg_collect_trig(&mvm->fwrt, trigger, NULL);
-
-out:
-	rcu_read_unlock();
 }
 
 void iwl_mvm_rx_stored_beacon_notif(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index edeea988e819..3f13b346bfc6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -354,11 +354,15 @@ struct iwl_mvm_vif_link_info {
  * reasons - use iwl_mvm_exit_esr().
  *
  * @IWL_MVM_ESR_BLOCKED_COEX: COEX is preventing the enablement of EMLSR
+ * @IWL_MVM_ESR_EXIT_MISSED_BEACON: exited EMLSR due to missed beacons
  */
 enum iwl_mvm_esr_state {
 	IWL_MVM_ESR_BLOCKED_COEX	= 0x1,
+	IWL_MVM_ESR_EXIT_MISSED_BEACON	= 0x10000,
 };
 
+#define IWL_MVM_BLOCK_ESR_REASONS 0xffff
+
 /**
  * struct iwl_mvm_vif - data per Virtual Interface, it is a MAC context
  * @mvm: pointer back to the mvm struct
@@ -1963,6 +1967,7 @@ int iwl_mvm_disable_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 void iwl_mvm_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 u8 iwl_mvm_get_primary_link(struct ieee80211_vif *vif);
+u8 iwl_mvm_get_other_link(struct ieee80211_vif *vif, u8 link_id);
 
 #if IS_ENABLED(CONFIG_IWLWIFI_KUNIT_TESTS)
 unsigned int iwl_mvm_get_link_grade(struct ieee80211_bss_conf *link_conf);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 7b70248c6090..c4528a979add 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -372,7 +372,8 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 		   struct iwl_umac_scan_iter_complete_notif),
 
 	RX_HANDLER(MISSED_BEACONS_NOTIFICATION, iwl_mvm_rx_missed_beacons_notif,
-		   RX_HANDLER_SYNC, struct iwl_missed_beacons_notif),
+		   RX_HANDLER_ASYNC_LOCKED_WIPHY,
+		   struct iwl_missed_beacons_notif),
 
 	RX_HANDLER(REPLY_ERROR, iwl_mvm_rx_fw_error, RX_HANDLER_SYNC,
 		   struct iwl_error_resp),
-- 
2.34.1


