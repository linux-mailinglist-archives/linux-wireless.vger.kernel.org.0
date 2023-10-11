Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD167C4FB3
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 12:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346329AbjJKKJ2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 06:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbjJKKIv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 06:08:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2121FCB
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 03:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697018877; x=1728554877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ke7gCm94387GLtS66tPtcQLrj/xubqc2iZTz3VnTGqw=;
  b=liSryA6guTusic7pYiZTOvoACPhEHUcKP48JD1w600ZmNBI0iPZrj7Be
   ivJ512BFvaMK/Om+qRv/oCfVm4qLcTCYxrxGseltKvX893DAv7/c6n/Lu
   tE9N2VyB5Mm0M+lRIJ78F2O4W6E0sZ35X6Sr4axTFpx4zTOj7jUU5vBKk
   338ILZeGyqv7hEaCKO6SWW0gyNXkYnwS5iDluCNslvgdce2sAO6p3HmL0
   p2el+O1Z+wA49hZbwTCZw9dQvLmBw5cBElcXR33rCqcIgREZ3TRxMPQeN
   H3ocUdOSkqsLAQbh41ib8rCackJVtsghuoovga4QjWviR10QLC7isFaAf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415670589"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="415670589"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:07:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1001050272"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="1001050272"
Received: from mzarix-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.125])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:07:55 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alon Giladi <alon.giladi@intel.com>,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/16] wifi: iwlwifi: send EDT table to FW
Date:   Wed, 11 Oct 2023 13:07:21 +0300
Message-Id: <20231011130030.0b78ee48219a.I8ecbd39d258e2ee0514a7e28632f6c18fb798a83@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231011100731.361200-1-gregory.greenman@intel.com>
References: <20231011100731.361200-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Alon Giladi <alon.giladi@intel.com>

Read the EDT (Energy detection threshold) optimization configuration
table from BIOS using DSM Function and send it to FW.

Signed-off-by: Alon Giladi <alon.giladi@intel.com>
Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  3 +-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 35 +++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 17 +++++++--
 3 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index d129fc66d8bb..e9277f6f3582 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -138,7 +138,8 @@ enum iwl_dsm_funcs_rev_0 {
 	DSM_FUNC_11AX_ENABLEMENT = 6,
 	DSM_FUNC_ENABLE_UNII4_CHAN = 7,
 	DSM_FUNC_ACTIVATE_CHANNEL = 8,
-	DSM_FUNC_FORCE_DISABLE_CHANNELS = 9
+	DSM_FUNC_FORCE_DISABLE_CHANNELS = 9,
+	DSM_FUNC_ENERGY_DETECTION_THRESHOLD = 10,
 };
 
 enum iwl_dsm_values_srd {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index c4577219c501..d1fede962573 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -21,8 +21,9 @@ enum iwl_regulatory_and_nvm_subcmd_ids {
 	 *	&struct iwl_lari_config_change_cmd_v2,
 	 *	&struct iwl_lari_config_change_cmd_v3,
 	 *	&struct iwl_lari_config_change_cmd_v4,
-	 *	&struct iwl_lari_config_change_cmd_v5 or
-	 *	&struct iwl_lari_config_change_cmd_v6
+	 *	&struct iwl_lari_config_change_cmd_v5,
+	 *	&struct iwl_lari_config_change_cmd_v6 or
+	 *	&struct iwl_lari_config_change_cmd_v7
 	 */
 	LARI_CONFIG_CHANGE = 0x1,
 
@@ -602,6 +603,36 @@ struct iwl_lari_config_change_cmd_v6 {
 	__le32 force_disable_channels_bitmap;
 } __packed; /* LARI_CHANGE_CONF_CMD_S_VER_6 */
 
+/**
+ * struct iwl_lari_config_change_cmd_v7 - change LARI configuration
+ * @config_bitmap: Bitmap of the config commands. Each bit will trigger a
+ *     different predefined FW config operation.
+ * @oem_uhb_allow_bitmap: Bitmap of UHB enabled MCC sets.
+ * @oem_11ax_allow_bitmap: Bitmap of 11ax allowed MCCs. There are two bits
+ *     per country, one to indicate whether to override and the other to
+ *     indicate the value to use.
+ * @oem_unii4_allow_bitmap: Bitmap of unii4 allowed MCCs.There are two bits
+ *     per country, one to indicate whether to override and the other to
+ *     indicate allow/disallow unii4 channels.
+ * @chan_state_active_bitmap: Bitmap for overriding channel state to active.
+ *     Each bit represents a country or region to activate, according to the
+ *     BIOS definitions.
+ * @force_disable_channels_bitmap: Bitmap of disabled bands/channels.
+ *     Each bit represents a set of channels in a specific band that should be
+ *     disabled
+ * @edt_bitmap: Bitmap of energy detection threshold table.
+ *	Disable/enable the EDT optimization method for different band.
+ */
+struct iwl_lari_config_change_cmd_v7 {
+	__le32 config_bitmap;
+	__le32 oem_uhb_allow_bitmap;
+	__le32 oem_11ax_allow_bitmap;
+	__le32 oem_unii4_allow_bitmap;
+	__le32 chan_state_active_bitmap;
+	__le32 force_disable_channels_bitmap;
+	__le32 edt_bitmap;
+} __packed; /* LARI_CHANGE_CONF_CMD_S_VER_7 */
+
 /**
  * struct iwl_pnvm_init_complete_ntfy - PNVM initialization complete
  * @status: PNVM image loading status
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index e9710e6e2efa..233c839de502 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1232,7 +1232,7 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 {
 	int ret;
 	u32 value;
-	struct iwl_lari_config_change_cmd_v6 cmd = {};
+	struct iwl_lari_config_change_cmd_v7 cmd = {};
 
 	cmd.config_bitmap = iwl_acpi_get_lari_config_bitmap(&mvm->fwrt);
 
@@ -1265,18 +1265,28 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 	if (!ret)
 		cmd.force_disable_channels_bitmap = cpu_to_le32(value);
 
+	ret = iwl_acpi_get_dsm_u32(mvm->fwrt.dev, 0,
+				   DSM_FUNC_ENERGY_DETECTION_THRESHOLD,
+				   &iwl_guid, &value);
+	if (!ret)
+		cmd.edt_bitmap = cpu_to_le32(value);
+
 	if (cmd.config_bitmap ||
 	    cmd.oem_uhb_allow_bitmap ||
 	    cmd.oem_11ax_allow_bitmap ||
 	    cmd.oem_unii4_allow_bitmap ||
 	    cmd.chan_state_active_bitmap ||
-	    cmd.force_disable_channels_bitmap) {
+	    cmd.force_disable_channels_bitmap ||
+	    cmd.edt_bitmap) {
 		size_t cmd_size;
 		u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
 						   WIDE_ID(REGULATORY_AND_NVM_GROUP,
 							   LARI_CONFIG_CHANGE),
 						   1);
 		switch (cmd_ver) {
+		case 7:
+			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v7);
+			break;
 		case 6:
 			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v6);
 			break;
@@ -1310,6 +1320,9 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 				"sending LARI_CONFIG_CHANGE, oem_uhb_allow_bitmap=0x%x, force_disable_channels_bitmap=0x%x\n",
 				le32_to_cpu(cmd.oem_uhb_allow_bitmap),
 				le32_to_cpu(cmd.force_disable_channels_bitmap));
+		IWL_DEBUG_RADIO(mvm,
+				"sending LARI_CONFIG_CHANGE, edt_bitmap=0x%x\n",
+				le32_to_cpu(cmd.edt_bitmap));
 		ret = iwl_mvm_send_cmd_pdu(mvm,
 					   WIDE_ID(REGULATORY_AND_NVM_GROUP,
 						   LARI_CONFIG_CHANGE),
-- 
2.38.1

