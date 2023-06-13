Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6664572E37D
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 14:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjFMM60 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 08:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241991AbjFMM6Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 08:58:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB321BC3
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686661088; x=1718197088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QrGrHHjwUZ/nyJVta2w/KrqWDVrPMRv3Vapu+SLjkWE=;
  b=NWC/M34RHsV1uvfSiwC/Nob1MK8GcmaKLg1LlQExSEPgop6YH7PDCQKt
   s+EOXUIH4IdMG8ghC491Jl3p+SbdA6nSikMEEqd85urnkrgO4dXOFvxxt
   ZyM4aEFXnJya2TsjEt4JHsSuv5CybRzciz4l7qpIwI0TYTbviddSX3Nf1
   382Tl3rlmYLlr9wjejSoEJqY+k7R7XaO2nwOJJkm5yBuTdhtHBJu/2x+R
   BuBCthKbM8nQtVDEffKLVsA3Fhi6wz4KQnwSiaBSfMsEYishCb4Dvtk6Q
   BVG+HlKeWrFuVNM3l6/sWOhVNvNcZz8QO2VoK+wRKqFj11T/Z54X8Jhun
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="347973769"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="347973769"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:58:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="835880839"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="835880839"
Received: from slerer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.90.17])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:58:04 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/14] wifi: iwlwifi: pcie: clear FW debug memory on init
Date:   Tue, 13 Jun 2023 15:57:25 +0300
Message-Id: <20230613155501.73c32255a132.Ibd7101dcd285b01ee879fddfbf52c30d49ced3c0@changeid>
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

When we restart the firmware, we shouldn't keep old debug data
around. Since the "allocate" function might not reallocate the
memory block (it's only freed when we unbind from the device),
clear the memory to have a clean slate for debug data.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 7240beca6419..84e832fdfa83 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2007-2015, 2018-2022 Intel Corporation
+ * Copyright (C) 2007-2015, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -171,8 +171,10 @@ static void iwl_pcie_alloc_fw_monitor_block(struct iwl_trans *trans,
 	u32 size = 0;
 	u8 power;
 
-	if (fw_mon->size)
+	if (fw_mon->size) {
+		memset(fw_mon->block, 0, fw_mon->size);
 		return;
+	}
 
 	for (power = max_power; power >= min_power; power--) {
 		size = BIT(power);
@@ -215,9 +217,6 @@ void iwl_pcie_alloc_fw_monitor(struct iwl_trans *trans, u8 max_power)
 		 max_power))
 		return;
 
-	if (trans->dbg.fw_mon.size)
-		return;
-
 	iwl_pcie_alloc_fw_monitor_block(trans, max_power, 11);
 }
 
-- 
2.38.1

