Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350187CBEC2
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 11:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbjJQJR1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 05:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343503AbjJQJRY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 05:17:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8307FED
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 02:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697534240; x=1729070240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2dGltWDP7HxVRgN4zqIONzmCZKGYcbYGTbFFf0FN5/A=;
  b=fTcaSiPiaOOqTy0JuGFg5bK/rnZPEpGcVneFvejcI2n5c0sTHXRrga0O
   SWpQupFGW09VM+TowTFOqCoTymzs85SdAy4brFm4Cqkpp6oFNGsSVMWjF
   09z6ihFnb4j1fxWaJzGfX7AcNhjOgLHvi45nUl5pGF5JAawRssyffrU4L
   KFQVOJ5NvEC/M8XGxYoRV7IUsoKUmkiOG9jrzXxZfOf7qQfvmlZxDx8zh
   v0CHc8kZIe23GTtOBCaLWJOgzK9tghu3gUPfAR8utmxKgc3osbNGRW58+
   LNdm5FkGWliUXrR57Bhz669RUMWFDzdvg1SbXgEGudKMIaB6eMsNqckx+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="370808551"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="370808551"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="759731925"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="759731925"
Received: from obarinsh-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.213.101])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:18 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/14] wifi: iwlwifi: pcie: synchronize IRQs before NAPI
Date:   Tue, 17 Oct 2023 12:16:43 +0300
Message-Id: <20231017115047.a0f4104b479a.Id5c50a944f709092aa6256e32d8c63b2b8d8d3ac@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231017091649.65090-1-gregory.greenman@intel.com>
References: <20231017091649.65090-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When we want to synchronize the NAPI, which was added in
commit 5af2bb3168db ("wifi: iwlwifi: call napi_synchronize()
before freeing rx/tx queues"), we also need to make sure we
can't actually reschedule the NAPI. Yes, this happens while
interrupts are disabled, but interrupts may still be running
or pending. Also call iwl_pcie_synchronize_irqs() to ensure
we won't reschedule the NAPI.

Fixes: 4cf2f5904d97 ("iwlwifi: queue: avoid memory leak in reset flow")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c | 1 +
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 085c4b49be87..c9e5bda8f0b7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -161,6 +161,7 @@ void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 	if (test_and_clear_bit(STATUS_DEVICE_ENABLED, &trans->status)) {
 		IWL_DEBUG_INFO(trans,
 			       "DEVICE_ENABLED bit was set and is now cleared\n");
+		iwl_pcie_synchronize_irqs(trans);
 		iwl_pcie_rx_napi_sync(trans);
 		iwl_txq_gen2_tx_free(trans);
 		iwl_pcie_rx_stop(trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 385e152f04fe..a468e5efeecd 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1264,6 +1264,7 @@ static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans)
 	if (test_and_clear_bit(STATUS_DEVICE_ENABLED, &trans->status)) {
 		IWL_DEBUG_INFO(trans,
 			       "DEVICE_ENABLED bit was set and is now cleared\n");
+		iwl_pcie_synchronize_irqs(trans);
 		iwl_pcie_rx_napi_sync(trans);
 		iwl_pcie_tx_stop(trans);
 		iwl_pcie_rx_stop(trans);
-- 
2.38.1

