Return-Path: <linux-wireless+bounces-10621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 966AA93FC49
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 19:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDF64B22F13
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 17:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85A615CD7F;
	Mon, 29 Jul 2024 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZC7DRmWy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C238D15F3EA
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273633; cv=none; b=BS19M1do52WMBDXYhlK1aqYntCq6ZFPvG5t/KYQcoqBqw72tqbQlWyacYNFcKCgB83A1AHKvocZbAZgx5FyG+tmO/DaDfsv3wS1mzUrDBxpPK0ZnnxdG25tIxlEPEgC6tbOcGVBTwd/rVUdW6sJtDM7onh00T+QEFXv5p9gx46w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273633; c=relaxed/simple;
	bh=hefIMzRG/u8DQBCA4dqFAFOpl+BHelQ2BDRSN5uQTkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eHTyMw3hH+Jz0nx2GKoaVFzzu6KL1WrOQuBg0Yhf9PPB4HozFL6+W2GCeTsdYTZAiRjIEEGElf+CGSlEwUB6xbfVhzxLXvYHrqSgpXtycSsAwn6MGvLMz2gG++2Qu+gMgIlZ8uh2fJYFzFzvcQqfcElRGoMbyd7BxDLb2dVVe74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZC7DRmWy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722273632; x=1753809632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hefIMzRG/u8DQBCA4dqFAFOpl+BHelQ2BDRSN5uQTkc=;
  b=ZC7DRmWySrq/U3nDzEM/iYhyw5oe1vHpzvKB56t5RetmAfLV6Un7eCuD
   V4Ikv2c+Vzqo+xf7HRpt5nqJDZ8wCk079EZ2CEJHZCUUL2bT2phP+iHVy
   5QoeuXVZs0+84sFDTasgeR54VGVoa7yEGwDXovansDv0niaEHIn6J1R6F
   paTH6KqF7C5ixUzvN7UMOdtV+tVJHfIp7dwmpPMN9z2ZRP6wGlgzXBYRV
   poKFm3m27Vdvh3Q6DwzRykAp8ORENZHnbGd9mHhwqsM5wYmAlL4NYtEr+
   QMZ6iKlnwGxjPBB1MdAzXY8Bqxh6zhw1IstXWDJH1uRjLGTTbSluFRnWo
   w==;
X-CSE-ConnectionGUID: PfhRiz3EQXiz8em6DbYKWg==
X-CSE-MsgGUID: yC3hOvNpT6yAl8xOQb9BaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31445560"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="31445560"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:32 -0700
X-CSE-ConnectionGUID: VcPD6FCcSoKaOoBa0bDlfg==
X-CSE-MsgGUID: oLMhwDPDRyW7MWRaGzFBAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54288255"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 01/17] wifi: iwlwifi: mvm: prepare the introduction of V9 of REDUCED_TX_POWER
Date: Mon, 29 Jul 2024 20:20:02 +0300
Message-Id: <20240729201718.8da29a66984f.I922bdef4740d990f98cb452e858c4157bbc491c5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
References: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

* Rename iwl_dev_tx_power_cmd to iwl_dev_tx_power_cmd_v3_v8
* struct iwl_dev_tx_power_common needs to be packed. It was always the
  case, but now that its size is not a multiple of 4, it becomes
  meaningful.
* Move per_band data out of the common structure since it won't be
  present in the new versions of the command.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 25 ++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  7 ++++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  7 ++++--
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 6e6a92d173cc..4c9d28327efc 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -285,18 +285,12 @@ enum iwl_dev_tx_power_cmd_mode {
  * @set_mode: see &enum iwl_dev_tx_power_cmd_mode
  * @mac_context_id: id of the mac ctx for which we are reducing TX power.
  * @pwr_restriction: TX power restriction in 1/8 dBms.
- * @dev_24: device TX power restriction in 1/8 dBms
- * @dev_52_low: device TX power restriction upper band - low
- * @dev_52_high: device TX power restriction upper band - high
  */
 struct iwl_dev_tx_power_common {
 	__le32 set_mode;
 	__le32 mac_context_id;
 	__le16 pwr_restriction;
-	__le16 dev_24;
-	__le16 dev_52_low;
-	__le16 dev_52_high;
-};
+} __packed;
 
 /**
  * struct iwl_dev_tx_power_cmd_v3 - TX power reduction command version 3
@@ -412,8 +406,20 @@ struct iwl_dev_tx_power_cmd_v8 {
 	__le32 tpc_vlp_backoff_level;
 } __packed; /* TX_REDUCED_POWER_API_S_VER_8 */
 
+/*
+ * @dev_24: device TX power restriction in 1/8 dBms
+ * @dev_52_low: device TX power restriction upper band - low
+ * @dev_52_high: device TX power restriction upper band - high
+ */
+struct iwl_dev_tx_power_cmd_per_band {
+	__le16 dev_24;
+	__le16 dev_52_low;
+	__le16 dev_52_high;
+} __packed;
+
 /**
- * struct iwl_dev_tx_power_cmd - TX power reduction command (multiversion)
+ * struct iwl_dev_tx_power_cmd_v3_v8 - TX power reduction command (multiversion)
+ * @per_band: per band restrictions
  * @common: common part of the command
  * @v3: version 3 part of the command
  * @v4: version 4 part of the command
@@ -422,8 +428,9 @@ struct iwl_dev_tx_power_cmd_v8 {
  * @v7: version 7 part of the command
  * @v8: version 8 part of the command
  */
-struct iwl_dev_tx_power_cmd {
+struct iwl_dev_tx_power_cmd_v3_v8 {
 	struct iwl_dev_tx_power_common common;
+	struct iwl_dev_tx_power_cmd_per_band per_band;
 	union {
 		struct iwl_dev_tx_power_cmd_v3 v3;
 		struct iwl_dev_tx_power_cmd_v4 v4;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 08c4898c8f1a..4c0847446e22 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -863,7 +863,7 @@ static int iwl_mvm_config_ltr(struct iwl_mvm *mvm)
 int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 {
 	u32 cmd_id = REDUCE_TX_POWER_CMD;
-	struct iwl_dev_tx_power_cmd cmd = {
+	struct iwl_dev_tx_power_cmd_v3_v8 cmd = {
 		.common.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_CHAINS),
 	};
 	__le16 *per_chain;
@@ -899,9 +899,12 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 		per_chain = cmd.v3.per_chain[0][0];
 	}
 
-	/* all structs have the same common part, add it */
+	/* all structs have the same common part, add its length */
 	len += sizeof(cmd.common);
 
+	/* all structs have the same per_band part, add its length */
+	len += sizeof(cmd.per_band);
+
 	ret = iwl_sar_fill_profile(&mvm->fwrt, per_chain,
 				   IWL_NUM_CHAIN_TABLES,
 				   n_subbands, prof_a, prof_b);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 835a05b91833..f0b290aa6bec 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1480,7 +1480,7 @@ int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 {
 	u32 cmd_id = REDUCE_TX_POWER_CMD;
 	int len;
-	struct iwl_dev_tx_power_cmd cmd = {
+	struct iwl_dev_tx_power_cmd_v3_v8 cmd = {
 		.common.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_MAC),
 		.common.mac_context_id =
 			cpu_to_le32(iwl_mvm_vif_from_mac80211(vif)->id),
@@ -1507,9 +1507,12 @@ int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	else
 		len = sizeof(cmd.v3);
 
-	/* all structs have the same common part, add it */
+	/* all structs have the same common part, add its length */
 	len += sizeof(cmd.common);
 
+	/* all structs have the same per_band part, add its length */
+	len += sizeof(cmd.per_band);
+
 	return iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, len, &cmd);
 }
 
-- 
2.34.1


