Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49573719FA5
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 16:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjFAOUp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 10:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjFAOUn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 10:20:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03936191
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 07:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685629236; x=1717165236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dIuq3ouTqGBd0tE/lCcZwgc9VcSPUwekBS4xoLOQK3s=;
  b=aGBtQkKIVSK5Ak94T9k3BqaNz1F5I9KAj0NeuafSRyLYoAWM5x/WiAfO
   DThOcxwrcmV7XbdPlnPGAEjxlUnT42bUBlEB5hwha2WL7k7ZdNexiMTDW
   nY0iLDb01JaiXbGkD2snoSyq1fV7vCvXAhZJHHVLtU1Z6PsTi0CGLjMkd
   5c92D0vMeQLDHaKbvemjFQ/zOdMfbJAMn64N5570PUS2zjjD+jV2V4xCm
   lX7ZwoqZhvhONhkrY97WO7VQ8ai0Eh97FqIuEtihl072iwZ/mCLue689B
   kMEfqx751HWfX1hA/+m5b5+0mG/CYOWwn/8PQ/lyeE9lGKPXhVbmmcWHa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="441931815"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="441931815"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:20:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="819812748"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="819812748"
Received: from dvinnyc-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.93.27])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:20:24 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 1/6] wifi: iwlwifi: api: link context action in kernel-doc
Date:   Thu,  1 Jun 2023 17:20:03 +0300
Message-Id: <20230601171633.e11ece794f60.I9874c7b0437071a2620d68ca5a16efed60da07a9@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230601142008.375040-1-gregory.greenman@intel.com>
References: <20230601142008.375040-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This is clearer in kernel-doc than spelling out the prefix.
It also lets us generate better tracing data.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/binding.h |  6 +++---
 drivers/net/wireless/intel/iwlwifi/fw/api/context.h | 13 +++++++++----
 drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h |  6 +++---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h     |  2 +-
 .../net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h    |  6 +++---
 .../net/wireless/intel/iwlwifi/fw/api/time-event.h  |  7 ++++---
 6 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/binding.h b/drivers/net/wireless/intel/iwlwifi/fw/api/binding.h
index 29e2816e7052..b6b5959cb259 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/binding.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/binding.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2020, 2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -18,7 +18,7 @@
  * ( BINDING_CONTEXT_CMD = 0x2b )
  * @id_and_color: ID and color of the relevant Binding,
  *	&enum iwl_ctxt_id_and_color
- * @action: action to perform, one of FW_CTXT_ACTION_*
+ * @action: action to perform, see &enum iwl_ctxt_action
  * @macs: array of MAC id and colors which belong to the binding,
  *	&enum iwl_ctxt_id_and_color
  * @phy: PHY id and color which belongs to the binding,
@@ -38,7 +38,7 @@ struct iwl_binding_cmd_v1 {
  * ( BINDING_CONTEXT_CMD = 0x2b )
  * @id_and_color: ID and color of the relevant Binding,
  *	&enum iwl_ctxt_id_and_color
- * @action: action to perform, one of FW_CTXT_ACTION_*
+ * @action: action to perform, see &enum iwl_ctxt_action
  * @macs: array of MAC id and colors which belong to the binding
  *	&enum iwl_ctxt_id_and_color
  * @phy: PHY id and color which belongs to the binding
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/context.h b/drivers/net/wireless/intel/iwlwifi/fw/api/context.h
index 105ba7170c3f..1fa5678c1cd6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/context.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/context.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014 Intel Corporation
+ * Copyright (C) 2012-2014, 2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -26,13 +26,18 @@ enum iwl_ctxt_id_and_color {
 #define FW_CMD_ID_AND_COLOR(_id, _color) (((_id) << FW_CTXT_ID_POS) |\
 					  ((_color) << FW_CTXT_COLOR_POS))
 
-/* Possible actions on PHYs, MACs and Bindings */
+/**
+ * enum iwl_ctxt_action - Posssible actions on PHYs, MACs, Bindings and other
+ * @FW_CTXT_ACTION_INVALID: unused, invalid action
+ * @FW_CTXT_ACTION_ADD: add the context
+ * @FW_CTXT_ACTION_MODIFY: modify the context
+ * @FW_CTXT_ACTION_REMOVE: remove the context
+ */
 enum iwl_ctxt_action {
-	FW_CTXT_ACTION_STUB = 0,
+	FW_CTXT_ACTION_INVALID = 0,
 	FW_CTXT_ACTION_ADD,
 	FW_CTXT_ACTION_MODIFY,
 	FW_CTXT_ACTION_REMOVE,
-	FW_CTXT_ACTION_NUM
 }; /* COMMON_CONTEXT_ACTION_API_E_VER_1 */
 
 #endif /* __iwl_fw_api_context_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index b4244fa0516b..a4cb24934a01 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -193,7 +193,7 @@ struct iwl_cancel_channel_switch_cmd {
  * struct iwl_chan_switch_te_cmd - Channel Switch Time Event command
  *
  * @mac_id: MAC ID for channel switch
- * @action: action to perform, one of FW_CTXT_ACTION_*
+ * @action: action to perform, see &enum iwl_ctxt_action
  * @tsf: beacon tsf
  * @cs_count: channel switch count from CSA/eCSA IE
  * @cs_delayed_bcn_count: if set to N (!= 0) GO/AP can delay N beacon intervals
@@ -296,7 +296,7 @@ enum iwl_mac_config_filter_flags {
  * ( MAC_CONTEXT_CONFIG_CMD = 0x8 )
  *
  * @id_and_color: ID and color of the MAC
- * @action: action to perform, one of FW_CTXT_ACTION_*
+ * @action: action to perform, see &enum iwl_ctxt_action
  * @mac_type: one of &enum iwl_mac_types
  * @local_mld_addr: mld address
  * @reserved_for_local_mld_addr: reserved
@@ -423,7 +423,7 @@ enum iwl_link_ctx_flags {
  *	in MLD API
  * ( LINK_CONFIG_CMD =0x9 )
  *
- * @action: action to perform, one of FW_CTXT_ACTION_*
+ * @action: action to perform, see &enum iwl_ctxt_action
  * @link_id: the id of the link that this cmd configures
  * @mac_id: interface ID. Relevant only if action is FW_CTXT_ACTION_ADD
  * @phy_id: PHY index. Can be changed only if the link was inactive
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
index c51c6c3a69ad..55882190251c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
@@ -295,7 +295,7 @@ struct iwl_ac_qos {
  * struct iwl_mac_ctx_cmd - command structure to configure MAC contexts
  * ( MAC_CONTEXT_CMD = 0x28 )
  * @id_and_color: ID and color of the MAC
- * @action: action to perform, one of FW_CTXT_ACTION_*
+ * @action: action to perform, see &enum iwl_ctxt_action
  * @mac_type: one of &enum iwl_mac_types
  * @tsf_id: TSF HW timer, one of &enum iwl_tsf_id
  * @node_addr: MAC address
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h b/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
index 2f7d8558becd..8fe42cff1102 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018, 2020-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018, 2020-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -116,7 +116,7 @@ struct iwl_phy_context_cmd_tail {
  * struct iwl_phy_context_cmd - config of the PHY context
  * ( PHY_CONTEXT_CMD = 0x8 )
  * @id_and_color: ID and color of the relevant Binding
- * @action: action to perform, one of FW_CTXT_ACTION_*
+ * @action: action to perform, see &enum iwl_ctxt_action
  * @apply_time: 0 means immediate apply and context switch.
  *	other value means apply new params after X usecs
  * @tx_param_color: ???
@@ -138,7 +138,7 @@ struct iwl_phy_context_cmd_v1 {
  * struct iwl_phy_context_cmd - config of the PHY context
  * ( PHY_CONTEXT_CMD = 0x8 )
  * @id_and_color: ID and color of the relevant Binding
- * @action: action to perform, one of FW_CTXT_ACTION_*
+ * @action: action to perform, see &enum iwl_ctxt_action
  * @lmac_id: the lmac id the phy context belongs to
  * @ci: channel info
  * @rxchain_info: ???
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h b/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
index 904cd78a9fa0..7cc706731d70 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2020, 2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -292,7 +292,7 @@ struct iwl_hs20_roc_req_tail {
  * ( HOT_SPOT_CMD 0x53 )
  *
  * @id_and_color: ID and color of the MAC
- * @action: action to perform, one of FW_CTXT_ACTION_*
+ * @action: action to perform, see &enum iwl_ctxt_action
  * @event_unique_id: If the action FW_CTXT_ACTION_REMOVE then the
  *	event_unique_id should be the id of the time event assigned by ucode.
  *	Otherwise ignore the event_unique_id.
@@ -377,7 +377,8 @@ enum iwl_mvm_session_prot_conf_id {
  * struct iwl_mvm_session_prot_cmd - configure a session protection
  * @id_and_color: the id and color of the mac for which this session protection
  *	is sent
- * @action: can be either FW_CTXT_ACTION_ADD or FW_CTXT_ACTION_REMOVE
+ * @action: can be either FW_CTXT_ACTION_ADD or FW_CTXT_ACTION_REMOVE,
+ *	see &enum iwl_ctxt_action
  * @conf_id: see &enum iwl_mvm_session_prot_conf_id
  * @duration_tu: the duration of the whole protection in TUs.
  * @repetition_count: not used
-- 
2.38.1

