Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E727187D3
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 18:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjEaQvv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 12:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjEaQvu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 12:51:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D7418C
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 09:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685551906; x=1717087906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ksb2Rl37zTGPvHJiSgirHeM76PqfidjbTc0/JdyMyC4=;
  b=g1Z+5lboi7wfUoOn5ePTv9pMJDW3zBD5jq1YLIt5X0WVkfSRiVhJJ+xJ
   jiqNeRkOTMkLpl6JV+IPynTGRoEvlITSQByM6SDElZyRCjzJ+NYCQ+8ua
   Otd3+srKSq3m/epagJsJmeL/U4RpqWkytBMGAblPXJ06nBqGJNfzaVwcD
   d3klfTXsQhs8b9Bn0d28qfxTbfp3KXg0Mzl75K7VDcrI/aBsKrljT5ViW
   FtY9UyhjIABmMG5YuED8B+IZNQDnEU4gUQA7AjFlq+nIQWTy6kvfsrKds
   u3c469We479N6qxFv0VLFuIVLTS5Vd130QTJopprsrdbu2yMplR9Dv3oG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="339890697"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="339890697"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="706987998"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="706987998"
Received: from amilman1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.102])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:49 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/14] wifi: iwlwifi: remove dead code in iwl_dump_ini_imr_get_size()
Date:   Wed, 31 May 2023 19:50:04 +0300
Message-Id: <20230531194630.58eec8d40729.Ifb7d64706eed45726db804f36e785283dff7adab@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531165006.273284-1-gregory.greenman@intel.com>
References: <20230531165006.273284-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Remove the check for the IMR debug data size which
leads to dead code.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index d9faaae01abd..3180cabc0212 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2031,7 +2031,6 @@ static u32
 iwl_dump_ini_imr_get_size(struct iwl_fw_runtime *fwrt,
 			  struct iwl_dump_ini_region_data *reg_data)
 {
-	u32 size = 0;
 	u32 ranges = 0;
 	u32 imr_enable = fwrt->trans->dbg.imr_data.imr_enable;
 	u32 imr_size = fwrt->trans->dbg.imr_data.imr_size;
@@ -2041,17 +2040,16 @@ iwl_dump_ini_imr_get_size(struct iwl_fw_runtime *fwrt,
 		IWL_DEBUG_INFO(fwrt,
 			       "WRT: Invalid imr data enable: %d, imr_size: %d, sram_size: %d\n",
 			       imr_enable, imr_size, sram_size);
-		return size;
+		return 0;
 	}
-	size = imr_size;
 	ranges = iwl_dump_ini_imr_ranges(fwrt, reg_data);
-	if (!size && !ranges) {
-		IWL_ERR(fwrt, "WRT: imr_size :=%d, ranges :=%d\n", size, ranges);
+	if (!ranges) {
+		IWL_ERR(fwrt, "WRT: ranges :=%d\n", ranges);
 		return 0;
 	}
-	size += sizeof(struct iwl_fw_ini_error_dump) +
+	imr_size += sizeof(struct iwl_fw_ini_error_dump) +
 		ranges * sizeof(struct iwl_fw_ini_error_dump_range);
-	return size;
+	return imr_size;
 }
 
 /**
-- 
2.38.1

