Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE9C6E3851
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Apr 2023 14:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjDPMsF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 08:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjDPMsA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 08:48:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5924A1726
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 05:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681649277; x=1713185277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jBeDvZkuDVcSz8a47lskFOPiTgV/2JmvTl5H9x4X/14=;
  b=S/ud2WdWj0mmPrUDTMuC408FCnmuGeQTtK6QCPRI2cyHP3RMe99X9D/S
   EjWP+Wew2M56bYL4+E+5GZv6WrB8WA2Z95Zp+SQJVdXuWObC5jfBAGaQz
   509TTzTVkjQ8K//3lYOP1bpXu7bWSFWu2jzh8YCHiJHqYWdOyVRccm+59
   x+mhkElpRE3+wMaCCKJo/JI8lFiypBvIJ8hn6vXdPNLqhAYT8HcRVFcjM
   9meIhL6fcfV8uP36a8njpvHRyOsphjV4FNr3rIGb7skuBofjzsbcu5/C3
   OIT6oOMCnG7XPcurOlLsTBXYMeMYpLSf4lJ9kT1JRvsVd1MEyXt54OzRV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333520547"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="333520547"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:47:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="640670415"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="640670415"
Received: from lavnon-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.99])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:47:55 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 02/15] wifi: iwlwifi: call napi_synchronize() before freeing rx/tx queues
Date:   Sun, 16 Apr 2023 15:47:26 +0300
Message-Id: <20230416154301.5171ee44dcc1.Iff18718540da412e084e7d8266447d40730600ed@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230416124739.1260800-1-gregory.greenman@intel.com>
References: <20230416124739.1260800-1-gregory.greenman@intel.com>
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

From: Gregory Greenman <gregory.greenman@intel.com>

When rx/tx queues are being freed, on a different CPU there could be
still rx flow running. Call napi_synchronize() to prevent such a race.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Co-developed-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 .../net/wireless/intel/iwlwifi/pcie/internal.h |  1 +
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c   | 18 +++++++++++++++++-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c   |  1 +
 .../net/wireless/intel/iwlwifi/pcie/trans.c    |  1 +
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index f7e4f868363d..69b95ad5993b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -497,6 +497,7 @@ int iwl_pcie_rx_stop(struct iwl_trans *trans);
 void iwl_pcie_rx_free(struct iwl_trans *trans);
 void iwl_pcie_free_rbs_pool(struct iwl_trans *trans);
 void iwl_pcie_rx_init_rxb_lists(struct iwl_rxq *rxq);
+void iwl_pcie_rx_napi_sync(struct iwl_trans *trans);
 void iwl_pcie_rxq_alloc_rbs(struct iwl_trans *trans, gfp_t priority,
 			    struct iwl_rxq *rxq);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 9c9f87fe8377..0d7890f99a5f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2003-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2003-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1053,6 +1053,22 @@ static int iwl_pcie_napi_poll_msix(struct napi_struct *napi, int budget)
 	return ret;
 }
 
+void iwl_pcie_rx_napi_sync(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	int i;
+
+	if (unlikely(!trans_pcie->rxq))
+		return;
+
+	for (i = 0; i < trans->num_rx_queues; i++) {
+		struct iwl_rxq *rxq = &trans_pcie->rxq[i];
+
+		if (rxq && rxq->napi.poll)
+			napi_synchronize(&rxq->napi);
+	}
+}
+
 static int _iwl_pcie_rx_init(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 45b63e3f5df3..73b395841ca8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -156,6 +156,7 @@ void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 	if (test_and_clear_bit(STATUS_DEVICE_ENABLED, &trans->status)) {
 		IWL_DEBUG_INFO(trans,
 			       "DEVICE_ENABLED bit was set and is now cleared\n");
+		iwl_pcie_rx_napi_sync(trans);
 		iwl_txq_gen2_tx_free(trans);
 		iwl_pcie_rx_stop(trans);
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 1b32a4035d88..c5446b82c6c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1260,6 +1260,7 @@ static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans)
 	if (test_and_clear_bit(STATUS_DEVICE_ENABLED, &trans->status)) {
 		IWL_DEBUG_INFO(trans,
 			       "DEVICE_ENABLED bit was set and is now cleared\n");
+		iwl_pcie_rx_napi_sync(trans);
 		iwl_pcie_tx_stop(trans);
 		iwl_pcie_rx_stop(trans);
 
-- 
2.38.1

