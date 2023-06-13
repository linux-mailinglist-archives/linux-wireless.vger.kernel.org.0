Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F40172E382
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 14:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241923AbjFMM6W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 08:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241991AbjFMM6V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 08:58:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972F91984
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 05:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686661086; x=1718197086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7kfB8jwrvISjAOsElfqu8BRzYgFf8quTAnuxH78M5z8=;
  b=J2JEFCbdCwJzEnQNTrbRbeH6jSMi9aj/EAspUAOKULca5c5JV4yJke97
   pgD0RfR373JodXhOEMtSp9lKZMSbDfbnahUsnlu72+hXViN0tzRvV5gyI
   QO+Uqve2ufhEhJlTKpJCGNvNDqmvg+sGZ1sqfaPlpc5NcPoMh6UEJM1qb
   9Td+5k818AkwSKcCm9MMx92urkP5hMBW2c6FItie+EokFO9RuXYVseSfq
   1OmdxDc3tOCpgIO2nF4LbNs970QiqZtZfmUXanqg/dwMOD2WnrW7HLa9d
   36hxdceIR4pxbnuE2KqAdqorAdUGoZbXWoYf82qYb7IihWi6pOSIkb1bo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="347973762"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="347973762"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:58:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="835880831"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="835880831"
Received: from slerer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.90.17])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:58:01 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/14] wifi: iwlwifi: dbg-tlv: fix DRAM data init
Date:   Tue, 13 Jun 2023 15:57:24 +0300
Message-Id: <20230613155501.87cf5528f4bc.I26ac907a4162297808b33467fc7f5d8177474a34@changeid>
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

Given the existing code in iwl_dbg_tlv_update_drams(), the
following can happen and cause firmware asserts, and even
the device to become unusable:

 * We set the magic so the firmware will use the data;
 * we try to fill multiple allocation IDs, with at least
   one successful, but - crucially - one failing and thus
   not touching the data;
 * we don't clear the data since there was one success.

This doesn't seem like much of a problem just yet, however,
what happens now is that the allocation ID(s) that failed
are not initialized.

There are two additional things to know:
 * we never free these allocations across FW restart or
   interface down/up etc., in fact we never free them until
   the driver is unbound from the device (e.g. unloaded)
 * the firmware uses the DRAM info structure for real debug
   data when it has used it completely

Given that, and the fact that we never initialize the data
on restart, we can be unlucky and end up with an allocation
that looks for the most part valid (valid ID, valid number
of buffers, etc.) but has bad sizes - causing the firmware
to throw an assert we can never recover from.

Fixing the code to have the entire buffers cleared (which
we should do so old debug data isn't sticking around) is a
bit more complex, so as a first step make the actual code
that fills the information more robust by clearing the
structure first, and filling the magic values only if it
actually succeeded for one, rather than doing it the other
way around.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index fb0277bd12cf..3f9d4670f6c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 #include <linux/firmware.h>
 #include "iwl-drv.h"
@@ -795,8 +795,7 @@ static void iwl_dbg_tlv_update_drams(struct iwl_fw_runtime *fwrt)
 			 IWL_UCODE_TLV_CAPA_DRAM_FRAG_SUPPORT))
 		return;
 
-	dram_info->first_word = cpu_to_le32(DRAM_INFO_FIRST_MAGIC_WORD);
-	dram_info->second_word = cpu_to_le32(DRAM_INFO_SECOND_MAGIC_WORD);
+	memset(dram_info, 0, sizeof(*dram_info));
 
 	for (i = IWL_FW_INI_ALLOCATION_ID_DBGC1;
 	     i < IWL_FW_INI_ALLOCATION_NUM; i++) {
@@ -813,11 +812,10 @@ static void iwl_dbg_tlv_update_drams(struct iwl_fw_runtime *fwrt)
 				 i, ret);
 	}
 
-	if (dram_alloc)
-		IWL_DEBUG_FW(fwrt, "block data after  %08x\n",
-			     dram_info->first_word);
-	else
-		memset(frags->block, 0, sizeof(*dram_info));
+	if (dram_alloc) {
+		dram_info->first_word = cpu_to_le32(DRAM_INFO_FIRST_MAGIC_WORD);
+		dram_info->second_word = cpu_to_le32(DRAM_INFO_SECOND_MAGIC_WORD);
+	}
 }
 
 static void iwl_dbg_tlv_send_hcmds(struct iwl_fw_runtime *fwrt,
-- 
2.38.1

