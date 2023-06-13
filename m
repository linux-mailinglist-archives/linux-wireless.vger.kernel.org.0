Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DD672E37F
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 14:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242005AbjFMM6a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 08:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241693AbjFMM62 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 08:58:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E6119B5
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 05:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686661095; x=1718197095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2sNM0bZ5K9wSo3V6c8lbIcfatOmHyY5gur/FQ4wBckQ=;
  b=S+RuZoPVAEMCPziY9gCm9aIZ3hKvCjHe8LOH0LBbRAzVhvfxtoeg9Q8e
   tYvz/TsYT1UqVK2NAU0PVzxFXm26SyYeGmW0M332xSryd+yBubE8jnLuC
   65VDFjM6Fp64g22sHu82UPgSnCMalOrALm7ErCLx8E1xEJBvIYvGSKowe
   DniEtkbZma8zgr5jZse5Kqu7yy54EfJ0KYGzW8Csk83sYQePaYjM+NTUa
   oslN421i4h/JfZiW8GJBBzeeOpCzNaJEjoF82cYxjgHrV44BPPHU/ZQMt
   AVdjssfEDJ4z8zdoKqimLp9KcVMrZCACC7XJ6zWpwswPItlqBhAgXlbW7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="347973778"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="347973778"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:58:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="835880846"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="835880846"
Received: from slerer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.90.17])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:58:06 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/14] wifi: iwlwifi: pcie: remove redundant argument
Date:   Tue, 13 Jun 2023 15:57:26 +0300
Message-Id: <20230613155501.737c153e8259.Ibe6250ca812cfa2f00ac47e5e0d1595c6b9b4875@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613125727.300445-1-gregory.greenman@intel.com>
References: <20230613125727.300445-1-gregory.greenman@intel.com>
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

The iwl_pcie_alloc_fw_monitor_block() function has an argument
that's only ever hard-coded to 11, remove it and hard-code the
value into the function itself with a comment.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 84e832fdfa83..3e88bbdb1f82 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -163,7 +163,7 @@ static void iwl_pcie_free_fw_monitor(struct iwl_trans *trans)
 }
 
 static void iwl_pcie_alloc_fw_monitor_block(struct iwl_trans *trans,
-					    u8 max_power, u8 min_power)
+					    u8 max_power)
 {
 	struct iwl_dram_data *fw_mon = &trans->dbg.fw_mon;
 	void *block = NULL;
@@ -176,7 +176,8 @@ static void iwl_pcie_alloc_fw_monitor_block(struct iwl_trans *trans,
 		return;
 	}
 
-	for (power = max_power; power >= min_power; power--) {
+	/* need at least 2 KiB, so stop at 11 */
+	for (power = max_power; power >= 11; power--) {
 		size = BIT(power);
 		block = dma_alloc_coherent(trans->dev, size, &physical,
 					   GFP_KERNEL | __GFP_NOWARN);
@@ -217,7 +218,7 @@ void iwl_pcie_alloc_fw_monitor(struct iwl_trans *trans, u8 max_power)
 		 max_power))
 		return;
 
-	iwl_pcie_alloc_fw_monitor_block(trans, max_power, 11);
+	iwl_pcie_alloc_fw_monitor_block(trans, max_power);
 }
 
 static u32 iwl_trans_pcie_read_shr(struct iwl_trans *trans, u32 reg)
-- 
2.38.1

