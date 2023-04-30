Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193786F29FC
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Apr 2023 19:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjD3RUd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Apr 2023 13:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjD3RUK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Apr 2023 13:20:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DB54EC0
        for <linux-wireless@vger.kernel.org>; Sun, 30 Apr 2023 10:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682875158; x=1714411158;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wwo6mt5ifcY6gk/8FB/v/TQvwtpDseGP5aUp0bhcFr8=;
  b=SBpFq+vx6qpOLNb2T6aFMpxP+1EyNg0xoRmxsA/bF6MfYrDtJEsV/Kg5
   BOWCPY1hnveBcvbfMoK7z9/uRxF9M8li3mytMmBdaAf0OdQ+AbZgTToHJ
   ktzihe+44oWQ3JZ9wmQNiMmD2VQp6VWlW97yuMqRhcJQVO7A+XP+QHBxA
   8W/4hKYvRFh12KjtEbVfAt37oJYhu6IFHdjlsV5NC43UPRhD3sW7JiSUc
   fUtv+lAJTPjG1m7RDMV0AT9l3cAf0l+iWi9A4QRTb+bX6wMvE2MCbwpuo
   c516U+OpRv3new7s6EkezKybTEKfPe+CM6+RsxBOJLd73OdTgdvDsRiJr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10696"; a="332386642"
X-IronPort-AV: E=Sophos;i="5.99,239,1677571200"; 
   d="scan'208";a="332386642"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2023 10:18:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10696"; a="1025383951"
X-IronPort-AV: E=Sophos;i="5.99,239,1677571200"; 
   d="scan'208";a="1025383951"
Received: from sshushan-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.202.249])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2023 10:18:55 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        Jeff Chua <jeff.chua.linux@gmail.com>
Subject: [PATCH] wifi: iwlwifi: mvm: rfi: disable RFI feature
Date:   Sun, 30 Apr 2023 20:18:30 +0300
Message-Id: <20230430201830.2f8f88fe49f6.I2f0076ef1d1cbe5d10010549c875b7038ec4c365@changeid>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

This feature depends on a platform bugfix. Until we have a
mechanism that can verify a platform has the required bugfix,
disable RFI.

Fixes: ef3ed33dfc8f ("wifi: iwlwifi: bump FW API to 77 for AX devices")
Reported-by: Jeff Chua <jeff.chua.linux@gmail.com>
Link: https://lore.kernel.org/linux-wireless/CAAJw_ZvZdFpw9W2Hisc9c2BAFbYAnQuaFFaFG6N7qPUP2fOL_w@mail.gmail.com/
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  |  3 +--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c | 16 +++++++++++++---
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index b35c96cf7ad2..e2573a9d6f27 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1727,8 +1727,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	iwl_mvm_tas_init(mvm);
 	iwl_mvm_leds_sync(mvm);
 
-	if (fw_has_capa(&mvm->fw->ucode_capa,
-			IWL_UCODE_TLV_CAPA_RFIM_SUPPORT)) {
+	if (iwl_rfi_supported(mvm)) {
 		if (iwl_mvm_eval_dsm_rfi(mvm) == DSM_VALUE_RFI_ENABLE)
 			iwl_rfi_send_config_cmd(mvm, NULL);
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 6e7470d3a826..9e5008e0e47f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2347,6 +2347,7 @@ int iwl_mvm_mld_update_sta_keys(struct iwl_mvm *mvm,
 				u32 old_sta_mask,
 				u32 new_sta_mask);
 
+bool iwl_rfi_supported(struct iwl_mvm *mvm);
 int iwl_rfi_send_config_cmd(struct iwl_mvm *mvm,
 			    struct iwl_rfi_lut_entry *rfi_table);
 struct iwl_rfi_freq_table_resp_cmd *iwl_rfi_get_freq_table(struct iwl_mvm *mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c b/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
index bb77bc9aa821..2ecd32bed752 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2020 - 2021 Intel Corporation
+ * Copyright (C) 2020 - 2022 Intel Corporation
  */
 
 #include "mvm.h"
@@ -70,6 +70,16 @@ static const struct iwl_rfi_lut_entry iwl_rfi_table[IWL_RFI_LUT_SIZE] = {
 		PHY_BAND_6, PHY_BAND_6,}},
 };
 
+bool iwl_rfi_supported(struct iwl_mvm *mvm)
+{
+	/* The feature depends on a platform bugfix, so for now
+	 * it's always disabled.
+	 * When the platform support detection is implemented we should
+	 * check FW TLV and platform support instead.
+	 */
+	return false;
+}
+
 int iwl_rfi_send_config_cmd(struct iwl_mvm *mvm, struct iwl_rfi_lut_entry *rfi_table)
 {
 	int ret;
@@ -81,7 +91,7 @@ int iwl_rfi_send_config_cmd(struct iwl_mvm *mvm, struct iwl_rfi_lut_entry *rfi_t
 		.len[0] = sizeof(cmd),
 	};
 
-	if (!fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_RFIM_SUPPORT))
+	if (!iwl_rfi_supported(mvm))
 		return -EOPNOTSUPP;
 
 	lockdep_assert_held(&mvm->mutex);
@@ -113,7 +123,7 @@ struct iwl_rfi_freq_table_resp_cmd *iwl_rfi_get_freq_table(struct iwl_mvm *mvm)
 		.flags = CMD_WANT_SKB,
 	};
 
-	if (!fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_RFIM_SUPPORT))
+	if (!iwl_rfi_supported(mvm))
 		return ERR_PTR(-EOPNOTSUPP);
 
 	mutex_lock(&mvm->mutex);
-- 
2.38.1

