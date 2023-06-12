Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F3472CAAE
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jun 2023 17:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbjFLPv5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jun 2023 11:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbjFLPv4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jun 2023 11:51:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB5D10F4
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jun 2023 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686585110; x=1718121110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+rRxN7f3DnXd22g+Cw2cuOVyje88p+jpvd9EwhByPEc=;
  b=OQoEb6cOTu0XwnUekx7FKuGgDiL8OKjtfiEbY1WrqKXe7eCx8hG7VEcN
   lZ3YMSR+kZrJoDu5LHT6wNpZTJh6sqOyBLuESMtaGKGa0rB9nj/HjWB5Y
   1SWrW/19PfIDpkPDK5izbvVph/vAU2R+QeP6i88J2JPYBD9vv4AwoFrLn
   tCbT4kfpSd/gNbIzbDIpZjnllPyIAEmySHqJOGsfnyk9xv7bdf9ewmUDG
   03rCcGVCYKaP9TuM2ZwXcclrb+Fv9Sqigyt6LMvksfJEpo2TIIsNEjJVV
   DYUW1UBG7l1+uxIRZ5y/8jhNYP8RqkB45pVzH5Z9eS40WPkLxTKLXAIJR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="421674254"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="421674254"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="885499347"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="885499347"
Received: from azvuluno-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.109])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:48 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/15] wifi: iwlwifi: unify checks for HW error values
Date:   Mon, 12 Jun 2023 18:51:10 +0300
Message-Id: <20230612184434.3e2959741a38.I1c297a53787b87e4e2b8f296c041921338573f4d@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230612155116.168000-1-gregory.greenman@intel.com>
References: <20230612155116.168000-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The hardware, depending on which part fails or times out,
returns 0xA5A5A5A. or 0x5A5A5A5. with the lowest 4 bits
encoding some further reason/status. However, mostly we
don't really need to care about the exact reasons, so
unify the checks for this to avoid hardcoding those magic
values all over the driver.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c     | 4 ++--
 drivers/net/wireless/intel/iwlwifi/fw/dump.c    | 2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c     | 4 +++-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h  | 5 +++++
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c    | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 2 +-
 6 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 3c5a43a619c6..3253d89e522a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1038,7 +1038,7 @@ iwl_dump_ini_prph_mac_iter(struct iwl_fw_runtime *fwrt,
 	range->range_data_size = reg->dev_addr.size;
 	for (i = 0; i < le32_to_cpu(reg->dev_addr.size); i += 4) {
 		prph_val = iwl_read_prph(fwrt->trans, addr + i);
-		if ((prph_val & ~0xf) == 0xa5a5a5a0)
+		if (iwl_trans_is_hw_error_value(prph_val))
 			return -EBUSY;
 		*val++ = cpu_to_le32(prph_val);
 	}
@@ -1562,7 +1562,7 @@ iwl_dump_ini_dbgi_sram_iter(struct iwl_fw_runtime *fwrt,
 		prph_data = iwl_read_prph_no_grab(fwrt->trans, (i % 2) ?
 					  DBGI_SRAM_TARGET_ACCESS_RDATA_MSB :
 					  DBGI_SRAM_TARGET_ACCESS_RDATA_LSB);
-		if ((prph_data & ~0xf) == 0xa5a5a5a0) {
+		if (iwl_trans_is_hw_error_value(prph_data)) {
 			iwl_trans_release_nic_access(fwrt->trans);
 			return -EBUSY;
 		}
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index f86f7b4baa18..64e83f30f947 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -194,7 +194,7 @@ static void iwl_fwrt_dump_lmac_error_log(struct iwl_fw_runtime *fwrt, u8 lmac_nu
 
 	/* check if there is a HW error */
 	val = iwl_trans_read_mem32(trans, base);
-	if (((val & ~0xf) == 0xa5a5a5a0) || ((val & ~0xf) == 0x5a5a5a50)) {
+	if (iwl_trans_is_hw_error_value(val)) {
 		int err;
 
 		IWL_ERR(trans, "HW error, resetting before reading\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index 396f2c997da6..c60f9466c5fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2003-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2003-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2015-2016 Intel Deutschland GmbH
  */
 #include <linux/delay.h>
@@ -72,6 +72,7 @@ u32 iwl_read_direct32(struct iwl_trans *trans, u32 reg)
 		return value;
 	}
 
+	/* return as if we have a HW timeout/failure */
 	return 0x5a5a5a5a;
 }
 IWL_EXPORT_SYMBOL(iwl_read_direct32);
@@ -143,6 +144,7 @@ u32 iwl_read_prph(struct iwl_trans *trans, u32 ofs)
 		return val;
 	}
 
+	/* return as if we have a HW timeout/failure */
 	return 0x5a5a5a5a;
 }
 IWL_EXPORT_SYMBOL(iwl_read_prph);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index d9e465d0f4af..1fa035decc03 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1613,6 +1613,11 @@ struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 int iwl_trans_init(struct iwl_trans *trans);
 void iwl_trans_free(struct iwl_trans *trans);
 
+static inline bool iwl_trans_is_hw_error_value(u32 val)
+{
+	return ((val & ~0xf) == 0xa5a5a5a0) || ((val & ~0xf) == 0x5a5a5a50);
+}
+
 /*****************************************************
 * driver (transport) register/unregister functions
 ******************************************************/
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 0d7890f99a5f..4ee4886babcb 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1873,7 +1873,7 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
-	if (unlikely(inta == 0xFFFFFFFF || (inta & 0xFFFFFFF0) == 0xa5a5a5a0)) {
+	if (unlikely(inta == 0xFFFFFFFF || iwl_trans_is_hw_error_value(inta))) {
 		/*
 		 * Hardware disappeared. It might have
 		 * already raised an interrupt.
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 15419397ac73..7240beca6419 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1788,7 +1788,7 @@ static int iwl_trans_pcie_clear_persistence_bit(struct iwl_trans *trans)
 	}
 
 	hpm = iwl_read_umac_prph_no_grab(trans, HPM_DEBUG);
-	if (hpm != 0xa5a5a5a0 && (hpm & PERSISTENCE_BIT)) {
+	if (!iwl_trans_is_hw_error_value(hpm) && (hpm & PERSISTENCE_BIT)) {
 		u32 wprot_val = iwl_read_umac_prph_no_grab(trans, wprot);
 
 		if (wprot_val & PREG_WFPM_ACCESS) {
-- 
2.38.1

