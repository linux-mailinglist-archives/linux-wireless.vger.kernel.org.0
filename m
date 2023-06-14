Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26BD72F99A
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 11:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbjFNJpb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 05:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244306AbjFNJos (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 05:44:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8F12709
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 02:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686735831; x=1718271831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xjZ3DuTADVkP/z+VaKdesRTGe6LdrHm/wZ5DT7S0g3I=;
  b=LK/6oeHKClTdU1pc7HZQKdJMxyAVv5SIOXNOHn2uSa2xLYTRXifT1i+R
   MMk1k+fBqAPwXXFbIaS6m9dRs/3juG8v24HBXr14ZpmBq0xWlOfaauvgb
   x9N3IO9WyRx7mpKHM0luieNhCHcX0imZhRSeHodMY6ygPkyWIsoP67z2e
   WqzncM6usdnEW1cJKZi1UomMplxRmu63aaBeMWST+yXwXd7mx+xFp8Ixj
   CGBhEU6AhnNl4RYxQlluLAlNFKid6giFozP0pkxsAsNwJKvv+WZtsvo+N
   Fqm8do8Q1tafqqr0YBx4myEGLS/XNPSpKBU6luOa0M4LeY0gpVUnlcbi/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361049866"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="361049866"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711989874"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="711989874"
Received: from basharil-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.203.45])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:17 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/20] wifi: iwlwifi: mvm: store WMM params per link
Date:   Wed, 14 Jun 2023 12:41:28 +0300
Message-Id: <20230614123446.332c4949a1be.Icae03975d578b0cc82279911a1ea7cbc313046d6@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230614094137.379897-1-gregory.greenman@intel.com>
References: <20230614094137.379897-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We have the data structure set up to store the parameters
per link, but weren't using them. Fix that and store them
in the right link.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c   | 13 +++++++++----
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c   |  8 ++++++--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 954ea9ac8e5b..61c1ec46a2fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -470,19 +470,24 @@ void iwl_mvm_set_fw_qos_params(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			       struct iwl_ac_qos *ac, __le32 *qos_flags)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_vif_link_info *mvm_link =
+		mvmvif->link[link_conf->link_id];
 	int i;
 
+	if (!mvm_link)
+		return;
+
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 		u8 txf = iwl_mvm_mac_ac_to_tx_fifo(mvm, i);
 		u8 ucode_ac = iwl_mvm_mac80211_ac_to_ucode_ac(i);
 
 		ac[ucode_ac].cw_min =
-			cpu_to_le16(mvmvif->deflink.queue_params[i].cw_min);
+			cpu_to_le16(mvm_link->queue_params[i].cw_min);
 		ac[ucode_ac].cw_max =
-			cpu_to_le16(mvmvif->deflink.queue_params[i].cw_max);
+			cpu_to_le16(mvm_link->queue_params[i].cw_max);
 		ac[ucode_ac].edca_txop =
-			cpu_to_le16(mvmvif->deflink.queue_params[i].txop * 32);
-		ac[ucode_ac].aifsn = mvmvif->deflink.queue_params[i].aifs;
+			cpu_to_le16(mvm_link->queue_params[i].txop * 32);
+		ac[ucode_ac].aifsn = mvm_link->queue_params[i].aifs;
 		ac[ucode_ac].fifos_mask = BIT(txf);
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index cb4df8c6f9de..8cd03357ce79 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2022 Intel Corporation
+ * Copyright (C) 2022-2023 Intel Corporation
  */
 #include "mvm.h"
 
@@ -820,8 +820,12 @@ iwl_mvm_mld_mac_conf_tx(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_vif_link_info *mvm_link = mvmvif->link[link_id];
 
-	mvmvif->deflink.queue_params[ac] = *params;
+	if (!mvm_link)
+		return -EINVAL;
+
+	mvm_link->queue_params[ac] = *params;
 
 	/* No need to update right away, we'll get BSS_CHANGED_QOS
 	 * The exception is P2P_DEVICE interface which needs immediate update.
-- 
2.38.1

