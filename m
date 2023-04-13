Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E208C6E1445
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 20:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjDMSld (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 14:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjDMSlc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 14:41:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0A76A70
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 11:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681411291; x=1712947291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5+iNU+i8QnIdQ8zsG0C+boijfHiP1t66VsjIaNxoYNQ=;
  b=IefKMJPMn4pEyeSC0I2JnpTTVRi8uuzzrh07RMLDP1EPdEPK5g9Q352w
   x3KWMsMc3tcv+65EjF7vXspGEgzZD+6gBXNXnENuz5QcP1WY/PhPs5vJg
   O+/L0bVuO//aCcaaFHgIg9YvcmyzkZpOXKcG/p4REHZLmSmuvHJyiJw2O
   CcvvRAvRXQvck67C+OjMR8N4POMuRQq6djYsaaio40UqnMhdvL0mO3QC+
   eNs95A3bFZyd/P1QNP0WfYqdANDIfTn9U+UPQbUnnhkrr2qWH4TI2nCG0
   Mm6RE2clPsW7EbnFYyowy02uFxHcDpn8GKqjawbBQ3M/mnHesvMoKKFIF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="372126967"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="372126967"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:40:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="719984336"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="719984336"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:40:56 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alon Giladi <alon.giladi@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/15] wifi: iwlwifi: acpi: support modules with high antenna gain
Date:   Thu, 13 Apr 2023 21:40:23 +0300
Message-Id: <20230413213309.a965365e2336.I1081f00ae309d9225d0529fa2da6ba7e34a8bd4f@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230413184035.1140892-1-gregory.greenman@intel.com>
References: <20230413184035.1140892-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Alon Giladi <alon.giladi@intel.com>

Starting from version 4 of ANT_GAIN_CMD verification of ppag table
values is done by the FW. Driver has to send the complete table as
it appears in the BIOS. Make this change.

Signed-off-by: Alon Giladi <alon.giladi@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 41 ++++++++++++-------
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  1 +
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index a02e5a67b706..5f4a51310add 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -1006,8 +1006,10 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 	union acpi_object *wifi_pkg, *data, *flags;
 	int i, j, ret, tbl_rev, num_sub_bands = 0;
 	int idx = 2;
+	u8 cmd_ver;
 
 	fwrt->ppag_flags = 0;
+	fwrt->ppag_table_valid = false;
 
 	data = iwl_acpi_get_object(fwrt->dev, ACPI_PPAG_METHOD);
 	if (IS_ERR(data))
@@ -1054,8 +1056,15 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 	}
 
 	fwrt->ppag_flags = flags->integer.value & ACPI_PPAG_MASK;
-
-	if (!fwrt->ppag_flags) {
+	cmd_ver = iwl_fw_lookup_cmd_ver(fwrt->fw,
+					WIDE_ID(PHY_OPS_GROUP,
+						PER_PLATFORM_ANT_GAIN_CMD),
+					IWL_FW_CMD_VER_UNKNOWN);
+	if (cmd_ver == IWL_FW_CMD_VER_UNKNOWN) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+	if (!fwrt->ppag_flags && cmd_ver <= 3) {
 		ret = 0;
 		goto out_free;
 	}
@@ -1076,21 +1085,22 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 			}
 
 			fwrt->ppag_chains[i].subbands[j] = ent->integer.value;
-
+			/* from ver 4 the fw deals with out of range values */
+			if (cmd_ver >= 4)
+				continue;
 			if ((j == 0 &&
 				(fwrt->ppag_chains[i].subbands[j] > ACPI_PPAG_MAX_LB ||
 				 fwrt->ppag_chains[i].subbands[j] < ACPI_PPAG_MIN_LB)) ||
 				(j != 0 &&
 				(fwrt->ppag_chains[i].subbands[j] > ACPI_PPAG_MAX_HB ||
 				fwrt->ppag_chains[i].subbands[j] < ACPI_PPAG_MIN_HB))) {
-					fwrt->ppag_flags = 0;
 					ret = -EINVAL;
 					goto out_free;
 				}
 		}
 	}
 
-
+	fwrt->ppag_table_valid = true;
 	ret = 0;
 
 out_free:
@@ -1115,19 +1125,22 @@ int iwl_read_ppag_table(struct iwl_fw_runtime *fwrt, union iwl_ppag_table_cmd *c
                 IWL_DEBUG_RADIO(fwrt,
                                 "PPAG capability not supported by FW, command not sent.\n");
                 return -EINVAL;
-        }
-        if (!fwrt->ppag_flags) {
-                IWL_DEBUG_RADIO(fwrt, "PPAG not enabled, command not sent.\n");
-                return -EINVAL;
-        }
+	}
+
+	cmd_ver = iwl_fw_lookup_cmd_ver(fwrt->fw,
+					WIDE_ID(PHY_OPS_GROUP,
+						PER_PLATFORM_ANT_GAIN_CMD),
+					IWL_FW_CMD_VER_UNKNOWN);
+	if (!fwrt->ppag_table_valid || (cmd_ver <= 3 && !fwrt->ppag_flags)) {
+		IWL_DEBUG_RADIO(fwrt, "PPAG not enabled, command not sent.\n");
+		return -EINVAL;
+	}
 
         /* The 'flags' field is the same in v1 and in v2 so we can just
          * use v1 to access it.
          */
         cmd->v1.flags = cpu_to_le32(fwrt->ppag_flags);
-        cmd_ver = iwl_fw_lookup_cmd_ver(fwrt->fw,
-                                        WIDE_ID(PHY_OPS_GROUP, PER_PLATFORM_ANT_GAIN_CMD),
-                                        IWL_FW_CMD_VER_UNKNOWN);
+
 	if (cmd_ver == 1) {
                 num_sub_bands = IWL_NUM_SUB_BANDS_V1;
                 gain = cmd->v1.gain[0];
@@ -1138,7 +1151,7 @@ int iwl_read_ppag_table(struct iwl_fw_runtime *fwrt, union iwl_ppag_table_cmd *c
                                         fwrt->ppag_ver);
                         cmd->v1.flags &= cpu_to_le32(IWL_PPAG_ETSI_MASK);
 		}
-	} else if (cmd_ver == 2 || cmd_ver == 3) {
+	} else if (cmd_ver >= 2 && cmd_ver <= 4) {
                 num_sub_bands = IWL_NUM_SUB_BANDS_V2;
                 gain = cmd->v2.gain[0];
                 *cmd_size = sizeof(cmd->v2);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index a59cf4d9567c..df689a9b7e2c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -165,6 +165,7 @@ struct iwl_fw_runtime {
 	struct iwl_ppag_chain ppag_chains[IWL_NUM_CHAIN_LIMITS];
 	u32 ppag_flags;
 	u32 ppag_ver;
+	bool ppag_table_valid;
 	struct iwl_sar_offset_mapping_cmd sgom_table;
 	bool sgom_enabled;
 	u8 reduced_power_flags;
-- 
2.38.1

