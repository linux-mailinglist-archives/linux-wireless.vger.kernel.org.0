Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A877C6E64
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 14:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbjJLMm0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 08:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343894AbjJLMmZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 08:42:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6F2B8
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 05:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697114544; x=1728650544;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=txssGbNqUyoiw43rE6+UzN1EndvjDhdjXtlPodoMyDg=;
  b=POTV7ocoh8b5HPmpU0pAeobCLLlXJIxS3HFjBfFtyi60V9shtUs8uohf
   ECLOMmuPxEKavd4YGE9lf18PxO0Py+x2A0EbvKT/b43uS5lIvPSOI5TaD
   xj5ezsyYZwBI3QlOPoh91b6JbBdnGDMiYcoQcGSYS4Jw/NRLLPpsFqmod
   t8IuWmx3jqR5wCo4NxjXhZzMfOkwWqE4oWIXgtf6YzdOBG5G0SCcOzaH0
   0EarfmQWnA5rmSv1wtOB+etNb2il2JtJgYC64hx298UWkyA16ho+mkyx1
   LV41Mi8kBSpKoSFMTQR3tuGV+ecF3YNZSlXgFdgntnIaMF0yyVNcUc8uj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="449097019"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="449097019"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 05:42:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="878087327"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="878087327"
Received: from lzilberb-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.201.48])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 05:42:22 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 01/16] wifi: iwlwifi: fw: increase fw_version string size
Date:   Thu, 12 Oct 2023 15:41:48 +0300
Message-Id: <20231012153950.f4465b4b4e2b.Idced2e8d63c492872edcde1a3ce2cdd6cc0f8eb7@changeid>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

In reality 64 bytes are enough to hold fw version string,
but some compilers can complain (with W=1) that output may be
truncated when building this string with snprintf.
Increase the size to avoid this sort of warnings and state
explicitely that we want the size to be trancated to 32 bytes.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
v2: explicitely limit size to 32 bytes in several snprintf() calls.
---
 drivers/net/wireless/intel/iwlwifi/dvm/main.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.h   | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index a873be109f43..8774dd7b921e 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1464,7 +1464,7 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 
 	snprintf(priv->hw->wiphy->fw_version,
 		 sizeof(priv->hw->wiphy->fw_version),
-		 "%s", fw->fw_version);
+		 "%.31s", fw->fw_version);
 
 	priv->new_scan_threshold_behaviour =
 		!!(ucode_flags & IWL_UCODE_TLV_FLAGS_NEWSCAN);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index 8d0d58d61892..96bda80632f3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016 Intel Deutschland GmbH
  */
@@ -198,7 +198,7 @@ struct iwl_dump_exclude {
 struct iwl_fw {
 	u32 ucode_ver;
 
-	char fw_version[64];
+	char fw_version[128];
 
 	/* ucode images */
 	struct fw_img img[IWL_UCODE_TYPE_MAX];
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 465090f67aaf..4390adc31a29 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1304,7 +1304,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	snprintf(mvm->hw->wiphy->fw_version,
 		 sizeof(mvm->hw->wiphy->fw_version),
-		 "%s", fw->fw_version);
+		 "%.31s", fw->fw_version);
 
 	trans_cfg.fw_reset_handshake = fw_has_capa(&mvm->fw->ucode_capa,
 						   IWL_UCODE_TLV_CAPA_FW_RESET_HANDSHAKE);
-- 
2.38.1

