Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110C47C4FC0
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 12:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346388AbjJKKKD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 06:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbjJKKJj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 06:09:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E42268C
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 03:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697018900; x=1728554900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6avcSBc2nWsyXIHPhseJhtxWUNyqJX6lpDl/0cR2N7w=;
  b=RJa+BBqjGJ9gYTqJHgmZ7awffhdint3JWPg1lwbQqE9wWkUgeHSR4+rm
   /+RrjTooEDlgYDdIg68OtqGZFC3j3JmVE0Zf2DD/alnRDTLtHxJhnvhvz
   OQbBqPXQS96o64LgMptRqDqEchr1S4eZyvraje2RUVjqXOgg8rKBbi2oL
   v/NriK3EPmg0sqVwvWmuEg0fmdQgq6aCw46iNe8nvOWeJ/AvhvoyPxSQo
   Vqc510DkCQcT8d36ioLQ+ui92jke2/pQstIMnvO98anvmgtsiBxDaNE+j
   qz2MPN9N8YkQQfGnOOBQKlvkKpH2/WBsgsYoWKX4NwR8PJG2s3J4yXPaV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415670709"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="415670709"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:08:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1001050339"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="1001050339"
Received: from mzarix-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.125])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:08:18 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 16/16] wifi: iwlwifi: add support for activating UNII-1 in WW via BIOS
Date:   Wed, 11 Oct 2023 13:07:31 +0300
Message-Id: <20231011130030.86d4ad178042.Ief40acc08b5482ff147fd17e74e36f1933e43def@changeid>
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

There is a requirement from OEMs to support a new bit in DSM function 8,
which will indicate that this device is an indoor one, and that it
should activate UNII-1 (5.2GHz) sub band in the World Wide Geo Profile.
Add support for this by reading this bit from BIOS and sending it to the
FW.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h | 17 +++++++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c     | 14 +++++++++-----
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index d1fede962573..0fa88ee76477 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -605,6 +605,7 @@ struct iwl_lari_config_change_cmd_v6 {
 
 /**
  * struct iwl_lari_config_change_cmd_v7 - change LARI configuration
+ * This structure is used also for lari cmd version 8.
  * @config_bitmap: Bitmap of the config commands. Each bit will trigger a
  *     different predefined FW config operation.
  * @oem_uhb_allow_bitmap: Bitmap of UHB enabled MCC sets.
@@ -614,9 +615,12 @@ struct iwl_lari_config_change_cmd_v6 {
  * @oem_unii4_allow_bitmap: Bitmap of unii4 allowed MCCs.There are two bits
  *     per country, one to indicate whether to override and the other to
  *     indicate allow/disallow unii4 channels.
- * @chan_state_active_bitmap: Bitmap for overriding channel state to active.
- *     Each bit represents a country or region to activate, according to the
- *     BIOS definitions.
+ * @chan_state_active_bitmap: Bitmap to enable different bands per country
+ *     or region.
+ *     Each bit represents a country or region, and a band to activate
+ *     according to the BIOS definitions.
+ *     For LARI cmd version 7 - bits 0:3 are supported.
+ *     For LARI cmd version 8 - bits 0:4 are supported.
  * @force_disable_channels_bitmap: Bitmap of disabled bands/channels.
  *     Each bit represents a set of channels in a specific band that should be
  *     disabled
@@ -631,7 +635,12 @@ struct iwl_lari_config_change_cmd_v7 {
 	__le32 chan_state_active_bitmap;
 	__le32 force_disable_channels_bitmap;
 	__le32 edt_bitmap;
-} __packed; /* LARI_CHANGE_CONF_CMD_S_VER_7 */
+} __packed;
+/* LARI_CHANGE_CONF_CMD_S_VER_7 */
+/* LARI_CHANGE_CONF_CMD_S_VER_8 */
+
+/* Activate UNII-1 (5.2GHz) for World Wide */
+#define ACTIVATE_5G2_IN_WW_MASK	BIT(4)
 
 /**
  * struct iwl_pnvm_init_complete_ntfy - PNVM initialization complete
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index f04f85320133..103233c0f38f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1233,6 +1233,9 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 	int ret;
 	u32 value;
 	struct iwl_lari_config_change_cmd_v7 cmd = {};
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
+					   WIDE_ID(REGULATORY_AND_NVM_GROUP,
+						   LARI_CONFIG_CHANGE), 1);
 
 	cmd.config_bitmap = iwl_acpi_get_lari_config_bitmap(&mvm->fwrt);
 
@@ -1250,8 +1253,11 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 	ret = iwl_acpi_get_dsm_u32(mvm->fwrt.dev, 0,
 				   DSM_FUNC_ACTIVATE_CHANNEL,
 				   &iwl_guid, &value);
-	if (!ret)
+	if (!ret) {
+		if (cmd_ver < 8)
+			value &= ~ACTIVATE_5G2_IN_WW_MASK;
 		cmd.chan_state_active_bitmap = cpu_to_le32(value);
+	}
 
 	ret = iwl_acpi_get_dsm_u32(mvm->fwrt.dev, 0,
 				   DSM_FUNC_ENABLE_6E,
@@ -1279,11 +1285,9 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 	    cmd.force_disable_channels_bitmap ||
 	    cmd.edt_bitmap) {
 		size_t cmd_size;
-		u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
-						   WIDE_ID(REGULATORY_AND_NVM_GROUP,
-							   LARI_CONFIG_CHANGE),
-						   1);
+
 		switch (cmd_ver) {
+		case 8:
 		case 7:
 			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v7);
 			break;
-- 
2.38.1

