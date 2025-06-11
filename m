Return-Path: <linux-wireless+bounces-24010-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD57EAD5F0E
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 21:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540C73A9DCD
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 19:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA391D89FD;
	Wed, 11 Jun 2025 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KVz8eLAd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713C32BE7B2
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 19:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670025; cv=none; b=jL69Z7kXJihV7ji36mtb3Oxgt5ihxDnTQKmEm2EtP8l7E3brhflUh0KYO4+M7KFv0BsOWZ4AWzQcrNIvHTU46RSVr8YNqDneb/ElOzRJ4qv+r8yo3TXdtOQQjCtURCPEtzbj4uC4WOWRBu1au2ZZQ0o5oBgIpiwaC0iTFuonxUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670025; c=relaxed/simple;
	bh=wBnwp+mNZAFi30/OAc8C/4tNSChKGQhgL+qWAuxDAJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MGhWl0IBDTwZIBaxcoTqmbCK7eq4ubpDS89g2uZKNjLwD9l/xmZyLKqFdbvX7JgqRqSGE+B/VMahEaV2IGLd+fewDL7286wkZjkpVP/tJOju3q4i5CukrFtbvzYCyQRFPHUNdUxYjlK0iEYskdqYamx1eRdU6VVU/Rue12gJp7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KVz8eLAd; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749670024; x=1781206024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wBnwp+mNZAFi30/OAc8C/4tNSChKGQhgL+qWAuxDAJw=;
  b=KVz8eLAdxWeRzjMy6mQPSu7T4TwzzHCRTjKx25VSUxhdzNVCQsWIebea
   7g1/wlnseZMzHdn6nSlfAykpCjY/U56apsGnWom7YCiYxTVB1ryDp8SiF
   CGiEmT4ILL/exm73LFDIRpr4VVWzTBwZyomSzmQUaaqlraCt97DI55hfj
   T3jBACSwpK+bUyWEKYK7D1VozIZEm/IeLwuIphu5MXlnYmx4kQM6LVoaA
   ZvV0m/tzMTn/rZ5IlIRAg38J8cT/qD+a2RR1hstoz8KKkKaO6r7PmBzXF
   GL36awZ7CbHRD4RB9jIhu8g8B96tk7Y/6Xht2huCVqILZ9itz+4P/Y3jY
   w==;
X-CSE-ConnectionGUID: v6+yEWB5R8exg05gcX6jXA==
X-CSE-MsgGUID: kQfuaLQhSnWp07vKHTc5/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="74360896"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="74360896"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:27:04 -0700
X-CSE-ConnectionGUID: nkSV0QACS6yneOSB1a53Og==
X-CSE-MsgGUID: jZGSmVRHSN2uN63dK1OP3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="147165870"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:27:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next v2 10/15] wifi: iwlwifi: dvm: fix some kernel-doc issues
Date: Wed, 11 Jun 2025 22:26:29 +0300
Message-Id: <20250611222325.b33528d06431.I948261d6610c47f09133fa73f5e5ea9b9848fd21@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
References: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Fix a couple of kernel-doc warnings in the old DVM code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h      |  2 ++
 drivers/net/wireless/intel/iwlwifi/dvm/commands.h | 14 +++++++-------
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h      |  4 ++--
 drivers/net/wireless/intel/iwlwifi/dvm/devices.c  |  2 ++
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c       |  2 ++
 5 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/agn.h b/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
index 1ebc7effcc2a..9fbdff28c88b 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
@@ -397,6 +397,8 @@ static inline void iwl_dvm_set_pmi(struct iwl_priv *priv, bool state)
  * returns a (newly allocated) struct containing all the
  * relevant values for driver use. The struct must be freed
  * later with iwl_free_nvm_data().
+ *
+ * Return: the parsed NVM data
  */
 struct iwl_nvm_data *
 iwl_parse_eeprom_data(struct iwl_trans *trans, const struct iwl_rf_cfg *cfg,
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/commands.h b/drivers/net/wireless/intel/iwlwifi/dvm/commands.h
index 96ea6c8dfc89..9eef2134392e 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/commands.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2023-2024 Intel Corporation
+ * Copyright (C) 2005-2014, 2023-2025 Intel Corporation
  */
 /*
  * Please use this file (commands.h) only for uCode API definitions.
@@ -614,7 +614,7 @@ struct iwl_rxon_time_cmd {
  * REPLY_CHANNEL_SWITCH = 0x72 (command, has simple generic response)
  */
 /**
- * struct iwl5000_channel_switch_cmd
+ * struct iwl5000_channel_switch_cmd - channel switch command (5000 series)
  * @band: 0- 5.2GHz, 1- 2.4GHz
  * @expect_beacon: 0- resume transmits after channel switch
  *		   1- wait for beacon to resume transmits
@@ -635,7 +635,7 @@ struct iwl5000_channel_switch_cmd {
 } __packed;
 
 /**
- * struct iwl6000_channel_switch_cmd
+ * struct iwl6000_channel_switch_cmd - channel switch command (6000 series)
  * @band: 0- 5.2GHz, 1- 2.4GHz
  * @expect_beacon: 0- resume transmits after channel switch
  *		   1- wait for beacon to resume transmits
@@ -791,7 +791,7 @@ struct iwl_keyinfo {
 } __packed;
 
 /**
- * struct sta_id_modify
+ * struct sta_id_modify - station modify command
  * @addr: station's MAC address
  * @reserved1: reserved for alignment
  * @sta_id: index of station in uCode's station table
@@ -2992,7 +2992,7 @@ struct iwl_missed_beacon_notif {
 #define SENSITIVITY_CMD_CONTROL_WORK_TABLE	cpu_to_le16(1)
 
 /**
- * struct iwl_sensitivity_cmd
+ * struct iwl_sensitivity_cmd - sensitivity configuration command
  * @control:  (1) updates working table, (0) updates default table
  * @table:  energy threshold values, use HD_* as index into table
  *
@@ -3848,7 +3848,7 @@ struct iwlagn_wowlan_status {
 #define IWL_MIN_SLOT_TIME	20
 
 /**
- * struct iwl_wipan_slot
+ * struct iwl_wipan_slot - WiPAN slot configuration
  * @width: Time in TU
  * @type:
  *   0 - BSS
@@ -3868,7 +3868,7 @@ struct iwl_wipan_slot {
 #define IWL_WIPAN_PARAMS_FLG_FULL_SLOTTED_MODE		BIT(5)
 
 /**
- * struct iwl_wipan_params_cmd
+ * struct iwl_wipan_params_cmd - WiPAN parameters
  * @flags:
  *   bit0: reserved
  *   bit1: CP leave channel with CTS
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/dev.h b/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
index 25b24820466d..4d12bf901703 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
@@ -104,7 +104,7 @@ struct iwl_qos_info {
 };
 
 /**
- * enum iwl_agg_state
+ * enum iwl_agg_state - aggregation state
  *
  * The state machine of the BA agreement establishment / tear down.
  * These states relate to a specific RA / TID.
@@ -519,7 +519,7 @@ enum iwl_scan_type {
 };
 
 /**
- * struct iwl_hw_params
+ * struct iwl_hw_params - HW parameters
  *
  * Holds the module parameters
  *
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/devices.c b/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
index 3447ae0b160a..be7e61e2b291 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
@@ -55,6 +55,7 @@ static void iwl1000_nic_config(struct iwl_priv *priv)
  * iwl_beacon_time_mask_low - mask of lower 32 bit of beacon time
  * @priv: pointer to iwl_priv data structure
  * @tsf_bits: number of bits need to shift for masking)
+ * Return: low 32 bits of beacon time mask
  */
 static inline u32 iwl_beacon_time_mask_low(struct iwl_priv *priv,
 					   u16 tsf_bits)
@@ -66,6 +67,7 @@ static inline u32 iwl_beacon_time_mask_low(struct iwl_priv *priv,
  * iwl_beacon_time_mask_high - mask of higher 32 bit of beacon time
  * @priv: pointer to iwl_priv data structure
  * @tsf_bits: number of bits need to shift for masking)
+ * Return: high 32 bits of beacon time mask
  */
 static inline u32 iwl_beacon_time_mask_high(struct iwl_priv *priv,
 					    u16 tsf_bits)
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
index 24fefa0e8148..a7806776a51e 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
@@ -232,6 +232,8 @@ static void iwlagn_tx_cmd_build_hwcrypto(struct iwl_priv *priv,
  * that may be %NULL, for example during TX or key setup. In
  * that case, we need to use the broadcast station, so this
  * inline wraps that pattern.
+ *
+ * Return: station ID for mac80211 station (or broadcast if %NULL)
  */
 static int iwl_sta_id_or_broadcast(struct iwl_rxon_context *context,
 				   struct ieee80211_sta *sta)
-- 
2.34.1


