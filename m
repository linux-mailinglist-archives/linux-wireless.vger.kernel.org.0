Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA616E5D62
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjDRJ3B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjDRJ24 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:28:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A946580
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681810130; x=1713346130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tZ2JYM5on+6omqoscBepvneDj/G7qOyGSvdSXYj8Ars=;
  b=apDBzoLcByc1pOBmlmvMl6xGoxvmHbMIBcBbSMFsZ3XuWIZr2DTSRLyu
   jkqMbcNO6irvOog9IvCwhfWLPiyAlc8GP0CGQ3t7Ewk34m/27FetmSUo4
   pv5sQcdCYnovQ4X6yESUQ1QmoFkSHkE/dSSKlG1tfug4nY9dxOr0f43C7
   xk8AO87dwOjQJzPcB8ES3ZW0TKgDpi+EO55hkIB1FoicRMY82rZnc2cfK
   K+l7p83tnLiY+LIzICWHDLEtHTIc6nYy+1tUjVAvp7crjBe6Vxe6ZsyFA
   okvhI4tfpy9u0z2CWcSJbExKvfRu+DbH5MlrB45gD1UeJ26Yl5v89ZBP4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="410341202"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="410341202"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 02:28:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="684511265"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="684511265"
Received: from kadanh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.234.12])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 02:28:48 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/11] wifi: iwlwifi: mvm: fix RFKILL report when driver is going down
Date:   Tue, 18 Apr 2023 12:28:14 +0300
Message-Id: <20230418122405.29ac3cd3df73.I96b32bc274bfe1e3871e54d3fa29c7ac4f40446f@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230418092814.1438734-1-gregory.greenman@intel.com>
References: <20230418092814.1438734-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

When CSME takes ownership, the driver sets RFKILL on, and this
triggers driver unload and sending the confirmation SAP message.
However, when IWL_MVM_MEI_REPORT_RFKILL is set, RFKILL was not
reported and as a result, the driver did not confirm the ownership
transition. Fix it.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mei/main.c    | 13 +++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c     |  6 +++++-
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h b/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
index ae66192feefe..655d95d3a068 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
+++ b/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) 2021 Intel Corporation
+ * Copyright (C) 2021 - 2022 Intel Corporation
  */
 
 #ifndef __iwl_mei_h__
@@ -301,7 +301,7 @@ struct iwl_mei_colloc_info {
 struct iwl_mei_ops {
 	void (*me_conn_status)(void *priv,
 			       const struct iwl_mei_conn_info *conn_info);
-	void (*rfkill)(void *priv, bool blocked);
+	void (*rfkill)(void *priv, bool blocked, bool csme_taking_ownership);
 	void (*roaming_forbidden)(void *priv, bool forbidden);
 	void (*sap_connected)(void *priv);
 	void (*nic_stolen)(void *priv);
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index f1e0fe806a00..0a29fb013005 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -724,7 +724,7 @@ iwl_mei_handle_conn_status(struct mei_cl_device *cldev,
 						     status->link_prot_state);
 	else
 		iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv,
-					  status->link_prot_state);
+					  status->link_prot_state, false);
 }
 
 static void iwl_mei_set_init_conf(struct iwl_mei *mei)
@@ -796,7 +796,7 @@ static void iwl_mei_handle_amt_state(struct mei_cl_device *cldev,
 	if (mei->amt_enabled)
 		iwl_mei_set_init_conf(mei);
 	else if (iwl_mei_cache.ops)
-		iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv, false);
+		iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv, false, false);
 
 	schedule_work(&mei->netdev_work);
 
@@ -837,7 +837,7 @@ static void iwl_mei_handle_csme_taking_ownership(struct mei_cl_device *cldev,
 		 */
 		mei->csme_taking_ownership = true;
 
-		iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv, true);
+		iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv, true, true);
 	} else {
 		iwl_mei_send_sap_msg(cldev,
 				     SAP_MSG_NOTIF_CSME_OWNERSHIP_CONFIRMED);
@@ -892,7 +892,7 @@ static void iwl_mei_handle_rx_host_own_req(struct mei_cl_device *cldev,
 
 	/* We can now start the connection, unblock rfkill */
 	if (iwl_mei_cache.ops)
-		iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv, false);
+		iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv, false, false);
 }
 
 static void iwl_mei_handle_pldr_ack(struct mei_cl_device *cldev,
@@ -1791,7 +1791,8 @@ int iwl_mei_register(void *priv, const struct iwl_mei_ops *ops)
 		if (iwl_mei_is_connected()) {
 			if (mei->amt_enabled)
 				iwl_mei_send_sap_msg(mei->cldev,
-						     SAP_MSG_NOTIF_WIFIDR_UP);
+						     SAP_MSG_NOTIF_WIFIDR_UP,
+						     false);
 			ops->rfkill(priv, mei->link_prot_state);
 		}
 	}
@@ -2111,7 +2112,7 @@ static void iwl_mei_remove(struct mei_cl_device *cldev)
 	spin_unlock_bh(&mei->data_q_lock);
 
 	if (iwl_mei_cache.ops)
-		iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv, false);
+		iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv, false, false);
 
 	/*
 	 * mei_cldev_disable will return only after all the MEI Rx is done.
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 26c3f00d6f7d..32625bfacaae 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1020,10 +1020,14 @@ static void iwl_mvm_me_conn_status(void *priv, const struct iwl_mei_conn_info *c
 		kfree_rcu(prev_conn_info, rcu_head);
 }
 
-static void iwl_mvm_mei_rfkill(void *priv, bool blocked)
+static void iwl_mvm_mei_rfkill(void *priv, bool blocked,
+			       bool csme_taking_ownership)
 {
 	struct iwl_mvm *mvm = priv;
 
+	if (blocked && !csme_taking_ownership)
+		return;
+
 	mvm->mei_rfkill_blocked = blocked;
 	if (!mvm->hw_registered)
 		return;
-- 
2.38.1

