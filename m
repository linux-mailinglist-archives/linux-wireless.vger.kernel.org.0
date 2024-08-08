Return-Path: <linux-wireless+bounces-11136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C824A94C59C
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 22:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0509A1C20DA7
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 20:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B86158D72;
	Thu,  8 Aug 2024 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="elZ29iR7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D72146A69
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 20:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148585; cv=none; b=sXBCy5MhFNSG8D3QP6gblqCzOCloTjVHsg9+hs3/tgOV0QsKIZwcO/JjAlD04wvb2cNh/qLrZV8FNjtdM0V7GNElmk8H8J1zkmLiL0aXmFOzoCa52NaSEHsr5xi5UUD2s0IEN3H540u8GCcTn871MO9rQz4MaKa4L6l8fEYHsPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148585; c=relaxed/simple;
	bh=lURc50s5V+S3Sowi67xOdFvrm7KNjCkK24/9Ytssmz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MquxQyvy1zMf0blBiBsdGtufsp6nV36fPYx0V8gKE0t1w01KoJgOEItH4cgLnT8NM+ZgBgIDYPhgPEerhFx1V9DkEJPO3WOEWiaw6YNA1OkwrFvDYvvNeu2tEILaWABxmQ0rKake+FEcq7XfhYUqiwP6aTy/QhNvG0Ug43wbhy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=elZ29iR7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723148584; x=1754684584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lURc50s5V+S3Sowi67xOdFvrm7KNjCkK24/9Ytssmz8=;
  b=elZ29iR7CzsdGiFz2WRXzUlrUY4ZuAZChWX/KA0fP4GwSDfkgqurv8BB
   s4uLiyC1wD4GGcECVidqj/7kVJN39jLYGDYnexjenmVfdJOpxv+valXjW
   i6zXO8zhiwLAXwq3tkt7/qPGigb1xOsrhfnHmZzbFvMIJvmUnFR16DVWK
   6og25MyHrOgO/7Z820O1YRajuomQ402JJbO+/XHETUjw7nHrkgZDo6Soc
   eNcOwrUeNDeqfid3SeIsDj5lZPy9JUSqT++aHLz/9rvKlDyG6wnQroD/M
   j5DaKkFawBLB/w52i78c5ksqlJnG0vWxxDWNPTMElZngbsDb7bYHnt3hd
   g==;
X-CSE-ConnectionGUID: 1NUSCvArS3iMWxdQjcD6eA==
X-CSE-MsgGUID: YICXDmd1RTKbFlXYHDYz3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38808827"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="38808827"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:03 -0700
X-CSE-ConnectionGUID: jcRVIFv5Tf6wZP1HB7Nr8w==
X-CSE-MsgGUID: aTrFABGFSDGc7W6DkvsnYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57305276"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/13] wifi: iwlwifi: mvm: Offload RLC/SMPS functionality to firmware
Date: Thu,  8 Aug 2024 23:22:37 +0300
Message-Id: <20240808232017.45da23be1f65.I0d46db82dd990a82e8a66876fe2f5310bc9513be@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808202249.4004087-1-miriam.rachel.korenblit@intel.com>
References: <20240808202249.4004087-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

Currently, the driver handles SMPS decisions by tracking AP
capabilities, BT coexistence changes, sending necessary SMPS
frames to the AP, and updating firmware with RX chain info
using the RLC_CONFIG_CMD.

Starting with version 3 of the RLC_CONFIG_CMD, the firmware
takes over this responsibility. It now tracks SMPS, sends
frames, and configures the RLC.

In this patch:
1. Stop sending RLC_CONFIG_CMD when firmware supports RLC
   offload (version 3), as rlc.rx_chain_info is not needed by
   firmware, and no other field in the cmd is used.
2. Prevent the driver from forwarding any SMPS requests to
   mac80211, i.e., the driver should not transmit SMPS frames
   to the AP as firmware handles that.
3. Set NL80211_FEATURE_DYNAMIC_SMPS and NL80211_FEATURE_STATIC_SMPS
   conditionally based on RLC version.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 9 +++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      | 7 +++++++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      | 6 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c | 6 +++++-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c    | 4 ++++
 5 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index d6f4caa939bd..af892c8291d4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -635,10 +635,15 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 			       NL80211_FEATURE_LOW_PRIORITY_SCAN |
 			       NL80211_FEATURE_P2P_GO_OPPPS |
 			       NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
-			       NL80211_FEATURE_DYNAMIC_SMPS |
-			       NL80211_FEATURE_STATIC_SMPS |
 			       NL80211_FEATURE_SUPPORTS_WMM_ADMISSION;
 
+	/* when firmware supports RLC/SMPS offload, do not set these
+	 * driver features, since it's no longer supported by driver.
+	 */
+	if (!iwl_mvm_has_rlc_offload(mvm))
+		hw->wiphy->features |= NL80211_FEATURE_STATIC_SMPS |
+				       NL80211_FEATURE_DYNAMIC_SMPS;
+
 	if (fw_has_capa(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_CAPA_TXPOWER_INSERTION_SUPPORT))
 		hw->wiphy->features |= NL80211_FEATURE_TX_POWER_INSERTION;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index bd754b8a71fc..4cacaa7b398e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1768,6 +1768,13 @@ static inline u8 iwl_mvm_mac_ac_to_tx_fifo(struct iwl_mvm *mvm,
 	return iwl_mvm_ac_to_tx_fifo[ac];
 }
 
+static inline bool iwl_mvm_has_rlc_offload(struct iwl_mvm *mvm)
+{
+	return iwl_fw_lookup_cmd_ver(mvm->fw,
+				     WIDE_ID(DATA_PATH_GROUP, RLC_CONFIG_CMD),
+				     0) >= 3;
+}
+
 struct iwl_rate_info {
 	u8 plcp;	/* uCode API:  IWL_RATE_6M_PLCP, etc. */
 	u8 plcp_siso;	/* uCode API:  IWL_RATE_SISO_6M_PLCP, etc. */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 8896d9792feb..be20c8e3a389 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -261,6 +261,12 @@ static void iwl_mvm_rx_thermal_dual_chain_req(struct iwl_mvm *mvm,
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_thermal_dual_chain_request *req = (void *)pkt->data;
 
+	/* firmware is expected to handle that in RLC offload mode */
+	if (IWL_FW_CHECK(mvm, iwl_mvm_has_rlc_offload(mvm),
+			 "Got THERMAL_DUAL_CHAIN_REQUEST (0x%x) in RLC offload mode\n",
+			 req->event))
+		return;
+
 	/*
 	 * We could pass it to the iterator data, but also need to remember
 	 * it for new interfaces that are added while in this state.
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index ce264b386029..7cab5373c8ae 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -159,7 +159,11 @@ int iwl_mvm_phy_send_rlc(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 		.phy_id = cpu_to_le32(ctxt->id),
 	};
 
-	if (ctxt->rlc_disabled)
+	/* From version 3, RLC is offloaded to firmware, so the driver no
+	 * longer needs to send cmd.rlc, note that we are not using any
+	 * other fields in the command - don't send it.
+	 */
+	if (iwl_mvm_has_rlc_offload(mvm) || ctxt->rlc_disabled)
 		return 0;
 
 	if (iwl_fw_lookup_cmd_ver(mvm->fw, WIDE_ID(DATA_PATH_GROUP,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 0e5fa8374103..edcc6e2cb76a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -297,6 +297,10 @@ void iwl_mvm_update_smps(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return;
 
+	/* SMPS is handled by firmware */
+	if (iwl_mvm_has_rlc_offload(mvm))
+		return;
+
 	mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
 	if (WARN_ON_ONCE(!mvmvif->link[link_id]))
-- 
2.34.1


