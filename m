Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17467D2373
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Oct 2023 16:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjJVO4d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Oct 2023 10:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjJVO4b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Oct 2023 10:56:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD05188
        for <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 07:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697986589; x=1729522589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X4viXoW7S/XoryaDSdM3/eTozQDQWVEhyDSCmb7MuWc=;
  b=kPNxHtKh8q3vSK5ixdYZT9xJd+SSg5V5l9272DdZIduKWd7Qy9pfqPw4
   cuqb6ivd1zWUkoUADlKvTP2X5FURLo6HMHAiLsKVKuSLn5gCCe9sHp0V4
   RAQxdcjVxsorng1bvzFBN+cOicz89mvKOwkzsPZNhOrXdeI9+RszalTGV
   mQkJFdtNEL/FU79BMpG0PJ+cUvZQ7c3srIRzroVXJcPkJTRQaSQSsamXT
   3eXc+RmRFJ2paL9U3wvxNiWz170s1RCCx9Fy2GeJfqH4y7ENak+/ceuh2
   hpS80E+o1EG36wnls8QaAQuf2P9plrZpO18a5rqz524wScJOGHbDJPWoS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="472925865"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="472925865"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 07:56:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="5556219"
Received: from umark-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.231.87])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 07:55:12 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Daniel Gabay <daniel.gabay@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/10] wifi: iwlwifi: read DSM func 2 for specific RF types
Date:   Sun, 22 Oct 2023 17:55:55 +0300
Message-Id: <20231022173519.eec3b5d6152f.Ibc7ffe5ef1c156d878f1300c6059c6c91b374114@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231022145556.244202-1-gregory.greenman@intel.com>
References: <20231022145556.244202-1-gregory.greenman@intel.com>
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

From: Daniel Gabay <daniel.gabay@intel.com>

By definition, this DSM func is valid only for HR/JF RF types.
Until now firmware ignored this bit (if set) on other than the
above types, but in future firmware versions sending this bit
will lead to firmware 0x3426 assert.
Avoid that by verifying the HW in driver first.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 26 ++++++++++++++------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index e83ce797a68b..b96f30d11644 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -1015,15 +1015,25 @@ __le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 	__le32 config_bitmap = 0;
 
 	/*
-	 ** Evaluate func 'DSM_FUNC_ENABLE_INDONESIA_5G2'
+	 * Evaluate func 'DSM_FUNC_ENABLE_INDONESIA_5G2'.
+	 * Setting config_bitmap Indonesia bit is valid only for HR/JF.
 	 */
-	ret = iwl_acpi_get_dsm_u8(fwrt->dev, 0,
-				  DSM_FUNC_ENABLE_INDONESIA_5G2,
-				  &iwl_guid, &value);
-
-	if (!ret && value == DSM_VALUE_INDONESIA_ENABLE)
-		config_bitmap |=
-			cpu_to_le32(LARI_CONFIG_ENABLE_5G2_IN_INDONESIA_MSK);
+	switch (CSR_HW_RFID_TYPE(fwrt->trans->hw_rf_id)) {
+	case IWL_CFG_RF_TYPE_HR1:
+	case IWL_CFG_RF_TYPE_HR2:
+	case IWL_CFG_RF_TYPE_JF1:
+	case IWL_CFG_RF_TYPE_JF2:
+		ret = iwl_acpi_get_dsm_u8(fwrt->dev, 0,
+					  DSM_FUNC_ENABLE_INDONESIA_5G2,
+					  &iwl_guid, &value);
+
+		if (!ret && value == DSM_VALUE_INDONESIA_ENABLE)
+			config_bitmap |=
+			    cpu_to_le32(LARI_CONFIG_ENABLE_5G2_IN_INDONESIA_MSK);
+		break;
+	default:
+		break;
+	}
 
 	/*
 	 ** Evaluate func 'DSM_FUNC_DISABLE_SRD'
-- 
2.38.1

