Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7BF72F9AB
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 11:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244185AbjFNJpl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 05:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244321AbjFNJou (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 05:44:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20902723
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686735835; x=1718271835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NlcAj/sfb++wMa9QOjH86EhMcnCKswW7vniAtGATU+k=;
  b=QODE+VnDvM5EaQFuJWLc5MK54tkhPSLel6qMDGZy/YMyjliZjheNVQ5m
   C1Mff7fYDLYAB5VBnb6N1CFlW+JCdhg8zxeiqgp+UX/Czv72KjM3L4B0G
   QSxAuA7ajhVVt9PPMx8GKYzJU3RS1GFEjQdnGnGh+5bdKWDbSbSfqHTpu
   Wb8ApkeLqXiqvGCSf2s97uiWExdoqFeKNlA0Gp9SWeo970oar4E1lEOxM
   JG1IQg/Tmz7svApADQ8jPMqpl1XAHosHRdv+TYnLuKkFUoeVSdQsyubtu
   pBxryhtM+oPgq2E4f4Rj+MPS7WuyNxiTo0A/hBj0edIzdYqbmyt6NdkhT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361049886"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="361049886"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711989894"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="711989894"
Received: from basharil-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.203.45])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:27 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/20] wifi: iwlwifi: pcie: fix NULL pointer dereference in iwl_pcie_irq_rx_msix_handler()
Date:   Wed, 14 Jun 2023 12:41:32 +0300
Message-Id: <20230614123446.5a5eb3889a4a.I375a1d58f16b48cd2044e7b7caddae512d7c86fd@changeid>
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

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

rxq can be NULL only when trans_pcie->rxq is NULL and entry->entry
is zero. For the case when entry->entry is not equal to 0, rxq
won't be NULL even if trans_pcie->rxq is NULL. Modify checker to
check for trans_pcie->rxq.

Fixes: abc599efa67b ("iwlwifi: pcie: don't crash when rx queues aren't allocated in interrupt")
Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 4ee4886babcb..da1a27b1d8b6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1636,14 +1636,14 @@ irqreturn_t iwl_pcie_irq_rx_msix_handler(int irq, void *dev_id)
 	struct msix_entry *entry = dev_id;
 	struct iwl_trans_pcie *trans_pcie = iwl_pcie_get_trans_pcie(entry);
 	struct iwl_trans *trans = trans_pcie->trans;
-	struct iwl_rxq *rxq = &trans_pcie->rxq[entry->entry];
+	struct iwl_rxq *rxq;
 
 	trace_iwlwifi_dev_irq_msix(trans->dev, entry, false, 0, 0);
 
 	if (WARN_ON(entry->entry >= trans->num_rx_queues))
 		return IRQ_NONE;
 
-	if (!rxq) {
+	if (!trans_pcie->rxq) {
 		if (net_ratelimit())
 			IWL_ERR(trans,
 				"[%d] Got MSI-X interrupt before we have Rx queues\n",
@@ -1651,6 +1651,7 @@ irqreturn_t iwl_pcie_irq_rx_msix_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
+	rxq = &trans_pcie->rxq[entry->entry];
 	lock_map_acquire(&trans->sync_cmd_lockdep_map);
 	IWL_DEBUG_ISR(trans, "[%d] Got interrupt\n", entry->entry);
 
-- 
2.38.1

