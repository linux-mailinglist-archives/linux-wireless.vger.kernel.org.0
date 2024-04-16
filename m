Return-Path: <linux-wireless+bounces-6387-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0088A6928
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 12:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718A61F21F99
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 10:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222D6128807;
	Tue, 16 Apr 2024 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KE5O0DPI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4F2127E32
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264884; cv=none; b=PKtMfLbwaazNNhc2FxfW28XNj4kfNwQ8gbhhDJSCWWskBm9jF937Qzk53UUEifOtxjFmh9jTXHj3T5+vIOJi/nQlyPiS/HuMZxCWHESlc8cw1uJxnilyub1blPc3RdxpwcegcbHALN+36KMNmwLPf0jrYaivvFAvXNMiLCsEhw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264884; c=relaxed/simple;
	bh=6JFOi7rW2E67w13fLzZKE23FbHnQp6+kapanCUHT9c0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nEzeSfP+fuGJK4s4UDzzDSNp65FkXb1KyOY7uma1CRxkWbspXrLpxlsET6IyGy/cbiG6J9di5GcljbnpLqJf6anlPCICqZj4Feer5Cp4xPRzJW5HPohDaWxy5qQwk0PAQwVgimxrudIRjc4O6g6/IPhFr6zXU38wWiM1lNo8g3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KE5O0DPI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713264883; x=1744800883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6JFOi7rW2E67w13fLzZKE23FbHnQp6+kapanCUHT9c0=;
  b=KE5O0DPI4WeaX+CdGlJ08pFwTSYmbwPUxot4d8GBKbv8XBmlzG//FbGo
   xr+WbwaZsmaQuqusl9IZY/vK28tMsMhom0TuqeEscxvTlR1yFf+i42dMO
   6lY9VuCWmGP8NDmPG6QZwB5tN3TeMlBNswGt1Op4M+stTIUo7QlfgyJWg
   z4OB4aY1LeDDk7j4wHXn2NEPuu76L7DCujhAYjZXjfDvn+OiArgl5N3RY
   bOOLxAoI6LiyT3N6aUzXSL0vllmngA9fZLeX8M7QIw4JfkLmn8O6A4xfX
   0KmlL3HUN927RezTxo/Kium1eWdI1ioojYuUW3ArfHCv0uSzRcGUzX6OR
   A==;
X-CSE-ConnectionGUID: 03w3B7YZQBuIVuaWgFfb2g==
X-CSE-MsgGUID: qX6ZlN7ASXKeH4trIq5QJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8556057"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8556057"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:41 -0700
X-CSE-ConnectionGUID: GsDqfJh0ScKYLloL7tuA2Q==
X-CSE-MsgGUID: Oc2HNAlRRSiv/d2NlErozg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26872538"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/16] wifi: iwlwifi: mvm: init vif works only once
Date: Tue, 16 Apr 2024 13:54:05 +0300
Message-Id: <20240416134215.ddf8eece5eac.I4164f5c9c444b64a9abbaab14c23858713778e35@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

It's dangerous to re-initialize works repeatedly, especially
delayed ones that have an associated timer, and even more so
if they're not necessarily canceled inbetween. This can be
the case for these workers here during FW restart scenarios,
so make sure to initialize it only once.

While at it, also ensure it is cancelled correctly.

Fixes: f67806140220 ("iwlwifi: mvm: disconnect in case of bad channel switch parameters")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 19 +++++++++++++++++--
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 ++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index a9bcf235cde9..efe9205a7cf2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1612,6 +1612,17 @@ static int iwl_mvm_alloc_bcast_mcast_sta(struct iwl_mvm *mvm,
 					IWL_STA_MULTICAST);
 }
 
+void iwl_mvm_mac_init_mvmvif(struct iwl_mvm *mvm, struct iwl_mvm_vif *mvmvif)
+{
+	lockdep_assert_held(&mvm->mutex);
+
+	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
+		return;
+
+	INIT_DELAYED_WORK(&mvmvif->csa_work,
+			  iwl_mvm_channel_switch_disconnect_wk);
+}
+
 static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif)
 {
@@ -1622,6 +1633,8 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 
 	mutex_lock(&mvm->mutex);
 
+	iwl_mvm_mac_init_mvmvif(mvm, mvmvif);
+
 	mvmvif->mvm = mvm;
 
 	/* the first link always points to the default one */
@@ -1703,8 +1716,6 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 		mvm->p2p_device_vif = vif;
 
 	iwl_mvm_tcm_add_vif(mvm, vif);
-	INIT_DELAYED_WORK(&mvmvif->csa_work,
-			  iwl_mvm_channel_switch_disconnect_wk);
 
 	if (vif->type == NL80211_IFTYPE_MONITOR) {
 		mvm->monitor_on = true;
@@ -1742,6 +1753,8 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 void iwl_mvm_prepare_mac_removal(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif)
 {
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
 	if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
 		/*
 		 * Flush the ROC worker which will flush the OFFCHANNEL queue.
@@ -1750,6 +1763,8 @@ void iwl_mvm_prepare_mac_removal(struct iwl_mvm *mvm,
 		 */
 		flush_work(&mvm->roc_done_wk);
 	}
+
+	cancel_delayed_work_sync(&mvmvif->csa_work);
 }
 
 /* This function is doing the common part of removing the interface for
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 2a7d7d4e0649..61f4c5dc3cec 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -14,6 +14,8 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 
 	mutex_lock(&mvm->mutex);
 
+	iwl_mvm_mac_init_mvmvif(mvm, mvmvif);
+
 	mvmvif->mvm = mvm;
 
 	/* Not much to do here. The stack will not allow interface
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 3b726c8b9261..edeea988e819 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1805,6 +1805,8 @@ int iwl_mvm_load_d3_fw(struct iwl_mvm *mvm);
 
 int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm);
 
+void iwl_mvm_mac_init_mvmvif(struct iwl_mvm *mvm, struct iwl_mvm_vif *mvmvif);
+
 /*
  * FW notifications / CMD responses handlers
  * Convention: iwl_mvm_rx_<NAME OF THE CMD>
-- 
2.34.1


