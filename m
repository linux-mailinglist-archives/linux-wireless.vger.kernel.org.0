Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D87C701C7A
	for <lists+linux-wireless@lfdr.de>; Sun, 14 May 2023 11:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbjENJQe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 May 2023 05:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbjENJQ1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 May 2023 05:16:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C3F2691
        for <linux-wireless@vger.kernel.org>; Sun, 14 May 2023 02:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684055786; x=1715591786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SSJ/aDCQfbvSV86JqW7iGE2mjb+1YyiDQwxDMz73nTQ=;
  b=W5u227SDXUXv6G+jp823G1MwfXmBC73smwpia5OgiG0XEIwp9kIjbhMB
   ot5zMVRw9ouiWUUgG1XZUAKjnG60WZ8PbbG9B0tCi0q5TXEl7ug0ajG0I
   RDOM5yfuehPZhR28tt6/al01N94ytugGfrLco3vy5tnzMkeFFe4upOCnf
   blxbD41oeqoG7KyeSYKtuHAhpc4/Cr81dYQ/Yh7ghmBTCwHiWANz3JOry
   Lsi9MyBRBsBszGwbndM/sU8DJ+foHgllT2CYQfHiNFxMR1bqH4nYibr8W
   F2+ueh9PL9OUN20+SPRAY6Pybrgfjf1+G5JxRbuD/ks+qq/P3TS+R/0uc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="340366843"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="340366843"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 02:16:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="731300381"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="731300381"
Received: from seran-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.239.223])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 02:16:25 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH wireless 05/12] wifi: iwlwifi: fw: fix DBGI dump
Date:   Sun, 14 May 2023 12:15:48 +0300
Message-Id: <20230514120631.19a302ae4c65.I12272599f7c1930666157b9d5e7f81fe9ec4c421@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230514091555.168392-1-gregory.greenman@intel.com>
References: <20230514091555.168392-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The DBGI dump is (unsurprisingly) of type DBGI, not SRAM.
This leads to bad register accesses because the union is
built differently, there's no allocation ID, and thus the
allocation ID ends up being 0x8000.

Note that this was already wrong for DRAM vs. SMEM since
they use different parts of the union, but the allocation
ID is at the same place, so it worked.

Fix all of this but set the allocation ID in a way that
the offset calculation ends up without any offset.

Fixes: 34bc27783a31 ("iwlwifi: yoyo: fix DBGI_SRAM ini dump header.")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index d9faaae01abd..55219974b92b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1664,14 +1664,10 @@ static __le32 iwl_get_mon_reg(struct iwl_fw_runtime *fwrt, u32 alloc_id,
 }
 
 static void *
-iwl_dump_ini_mon_fill_header(struct iwl_fw_runtime *fwrt,
-			     struct iwl_dump_ini_region_data *reg_data,
+iwl_dump_ini_mon_fill_header(struct iwl_fw_runtime *fwrt, u32 alloc_id,
 			     struct iwl_fw_ini_monitor_dump *data,
 			     const struct iwl_fw_mon_regs *addrs)
 {
-	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
-	u32 alloc_id = le32_to_cpu(reg->dram_alloc_id);
-
 	if (!iwl_trans_grab_nic_access(fwrt->trans)) {
 		IWL_ERR(fwrt, "Failed to get monitor header\n");
 		return NULL;
@@ -1702,8 +1698,10 @@ iwl_dump_ini_mon_dram_fill_header(struct iwl_fw_runtime *fwrt,
 				  void *data, u32 data_len)
 {
 	struct iwl_fw_ini_monitor_dump *mon_dump = (void *)data;
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	u32 alloc_id = le32_to_cpu(reg->dram_alloc_id);
 
-	return iwl_dump_ini_mon_fill_header(fwrt, reg_data, mon_dump,
+	return iwl_dump_ini_mon_fill_header(fwrt, alloc_id, mon_dump,
 					    &fwrt->trans->cfg->mon_dram_regs);
 }
 
@@ -1713,8 +1711,10 @@ iwl_dump_ini_mon_smem_fill_header(struct iwl_fw_runtime *fwrt,
 				  void *data, u32 data_len)
 {
 	struct iwl_fw_ini_monitor_dump *mon_dump = (void *)data;
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	u32 alloc_id = le32_to_cpu(reg->internal_buffer.alloc_id);
 
-	return iwl_dump_ini_mon_fill_header(fwrt, reg_data, mon_dump,
+	return iwl_dump_ini_mon_fill_header(fwrt, alloc_id, mon_dump,
 					    &fwrt->trans->cfg->mon_smem_regs);
 }
 
@@ -1725,7 +1725,10 @@ iwl_dump_ini_mon_dbgi_fill_header(struct iwl_fw_runtime *fwrt,
 {
 	struct iwl_fw_ini_monitor_dump *mon_dump = (void *)data;
 
-	return iwl_dump_ini_mon_fill_header(fwrt, reg_data, mon_dump,
+	return iwl_dump_ini_mon_fill_header(fwrt,
+					    /* no offset calculation later */
+					    IWL_FW_INI_ALLOCATION_ID_DBGC1,
+					    mon_dump,
 					    &fwrt->trans->cfg->mon_dbgi_regs);
 }
 
-- 
2.38.1

