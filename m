Return-Path: <linux-wireless+bounces-484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A08806A21
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 09:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAEC91C21678
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 08:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6750D2E408;
	Wed,  6 Dec 2023 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A/GQ3gIK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129361709
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 00:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701852608; x=1733388608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e8eUO1jJAba7f5Dmwwk0HDeYAVr39DhfPJMZiMOPyuc=;
  b=A/GQ3gIK9NVT95JXfFqTU53nKbVh8g54g6Bo9tLX7v/B52oM2me5bqiV
   MZWud60VuoFuSFuZKj6Tz+jQm6K7/IVSR85oS+UCa49hnwj2KJES8lJRa
   GKM0I1uwqKwj+0W4EjbE5EttnzYPkZ7uBC3N3PabLscW11oYxG6L2vN7d
   4SUX3D7tErYLQNBQO4koKb1A4qWdyYs6yrhGSUQjURnLvqt+uKnezWkRo
   YHvx89MtfxVPj5fQ9cRcLkTQLzk5WAdG75pITUFHvJPRsqPFTvtgWMxBM
   1slkr4yOFSEayJADSt1eKA/ai69mbD9xO3YM92LRaEJxiaRh/KUPjc2V9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="397916600"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="397916600"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:50:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="805575423"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="805575423"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:50:06 -0800
From: Miri@web.codeaurora.org, Korenblit@web.codeaurora.org,
	miriam.rachel.korenblit@intel.com
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 11/13] wifi: iwlwifi: mvm: do not send STA_DISABLE_TX_CMD for newer firmware
Date: Thu,  7 Dec 2023 04:50:16 +0200
Message-Id: <20231207044813.e64ef70c0133.I9f47cdef2ba45f1f383b70023857376973de3a8c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
References: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spam-Level: ****

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Newest firmware has completely offloaded this logic and this command
will be deprecated soon. Based on a capability bit advertised by the
firmware, skip this command.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h     |  3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c |  3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h     |  6 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c     | 10 +++++++---
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 7bbc55ccc3ce..c38e5194c55f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -243,6 +243,8 @@ typedef unsigned int __bitwise iwl_ucode_tlv_api_t;
  *	version tables.
  * @IWL_UCODE_TLV_API_REDUCED_SCAN_CONFIG: This ucode supports v3 of
  *  SCAN_CONFIG_DB_CMD_API_S.
+ * @IWL_UCODE_TLV_API_NO_HOST_DISABLE_TX: Firmware offloaded the station disable tx
+ *	logic.
  *
  * @NUM_IWL_UCODE_TLV_API: number of bits used
  */
@@ -280,6 +282,7 @@ enum iwl_ucode_tlv_api {
 	IWL_UCODE_TLV_API_ADWELL_HB_DEF_N_AP	= (__force iwl_ucode_tlv_api_t)57,
 	IWL_UCODE_TLV_API_SCAN_EXT_CHAN_VER	= (__force iwl_ucode_tlv_api_t)58,
 	IWL_UCODE_TLV_API_BAND_IN_RX_DATA	= (__force iwl_ucode_tlv_api_t)59,
+	IWL_UCODE_TLV_API_NO_HOST_DISABLE_TX	= (__force iwl_ucode_tlv_api_t)66,
 
 	NUM_IWL_UCODE_TLV_API
 /*
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index ca5e4fbcf8ce..d7a0ce2bb0f7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -872,6 +872,9 @@ void iwl_mvm_mld_sta_modify_disable_tx(struct iwl_mvm *mvm,
 	cmd.sta_id = cpu_to_le32(mvmsta->deflink.sta_id);
 	cmd.disable = cpu_to_le32(disable);
 
+	if (WARN_ON(iwl_mvm_has_no_host_disable_tx(mvm)))
+		return;
+
 	ret = iwl_mvm_send_cmd_pdu(mvm,
 				   WIDE_ID(MAC_CONF_GROUP, STA_DISABLE_TX_CMD),
 				   CMD_ASYNC, sizeof(cmd), &cmd);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index b04485b7e1f6..40627961b834 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1514,6 +1514,12 @@ static inline bool iwl_mvm_has_quota_low_latency(struct iwl_mvm *mvm)
 			  IWL_UCODE_TLV_API_QUOTA_LOW_LATENCY);
 }
 
+static inline bool iwl_mvm_has_no_host_disable_tx(struct iwl_mvm *mvm)
+{
+	return fw_has_api(&mvm->fw->ucode_capa,
+			  IWL_UCODE_TLV_API_NO_HOST_DISABLE_TX);
+}
+
 static inline bool iwl_mvm_has_tlc_offload(const struct iwl_mvm *mvm)
 {
 	return fw_has_capa(&mvm->fw->ucode_capa,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 49542b3cb76e..efe3e111ea0a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -4150,7 +4150,8 @@ void iwl_mvm_sta_modify_disable_tx(struct iwl_mvm *mvm,
 	int ret;
 
 	if (mvm->mld_api_is_used) {
-		iwl_mvm_mld_sta_modify_disable_tx(mvm, mvmsta, disable);
+		if (!iwl_mvm_has_no_host_disable_tx(mvm))
+			iwl_mvm_mld_sta_modify_disable_tx(mvm, mvmsta, disable);
 		return;
 	}
 
@@ -4167,7 +4168,8 @@ void iwl_mvm_sta_modify_disable_tx_ap(struct iwl_mvm *mvm,
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
 
 	if (mvm->mld_api_is_used) {
-		iwl_mvm_mld_sta_modify_disable_tx_ap(mvm, sta, disable);
+		if (!iwl_mvm_has_no_host_disable_tx(mvm))
+			iwl_mvm_mld_sta_modify_disable_tx_ap(mvm, sta, disable);
 		return;
 	}
 
@@ -4222,7 +4224,9 @@ void iwl_mvm_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
 	int i;
 
 	if (mvm->mld_api_is_used) {
-		iwl_mvm_mld_modify_all_sta_disable_tx(mvm, mvmvif, disable);
+		if (!iwl_mvm_has_no_host_disable_tx(mvm))
+			iwl_mvm_mld_modify_all_sta_disable_tx(mvm, mvmvif,
+							      disable);
 		return;
 	}
 
-- 
2.34.1


