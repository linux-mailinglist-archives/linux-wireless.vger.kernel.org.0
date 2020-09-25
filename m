Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C360279398
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 23:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgIYVbi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 17:31:38 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52396 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729008AbgIYVbi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 17:31:38 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kLvJ4-002J1P-D5; Sat, 26 Sep 2020 00:31:06 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 26 Sep 2020 00:30:51 +0300
Message-Id: <iwlwifi.20200926002540.9e2f296f5cfc.I4b2c025768b5ceff93a80ba0ae9ee7784d6d7402@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925213053.454459-1-luca@coelho.fi>
References: <20200925213053.454459-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 13/15] iwlwifi: remove iwl_validate_sar_geo_profile() export
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Only iwlmvm uses this function and it's so simple that it's clearer if
it's spelled out in the code anyway, so remove it and add the check
where needed.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 17 -----------------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h |  9 ---------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  |  9 ++++++++-
 3 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index b14260e303b7..e3de4e11f4ae 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -631,23 +631,6 @@ bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt)
 }
 IWL_EXPORT_SYMBOL(iwl_sar_geo_support);
 
-int iwl_validate_sar_geo_profile(struct iwl_fw_runtime *fwrt,
-				 struct iwl_host_cmd *cmd)
-{
-	struct iwl_geo_tx_power_profiles_resp *resp;
-	int ret;
-
-	resp = (void *)cmd->resp_pkt->data;
-	ret = le32_to_cpu(resp->profile_idx);
-	if (WARN_ON(ret > ACPI_NUM_GEO_PROFILES)) {
-		ret = -EIO;
-		IWL_WARN(fwrt, "Invalid geographic profile idx (%d)\n", ret);
-	}
-
-	return ret;
-}
-IWL_EXPORT_SYMBOL(iwl_validate_sar_geo_profile);
-
 int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
 		     struct iwl_per_chain_offset_group *table)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 39e6be21158d..56f3399fe99e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -194,9 +194,6 @@ int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt);
 
 bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt);
 
-int iwl_validate_sar_geo_profile(struct iwl_fw_runtime *fwrt,
-				 struct iwl_host_cmd *cmd);
-
 int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
 		     struct iwl_per_chain_offset_group *table);
 
@@ -278,12 +275,6 @@ static inline bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt)
 	return false;
 }
 
-static inline int iwl_validate_sar_geo_profile(struct iwl_fw_runtime *fwrt,
-					       struct iwl_host_cmd *cmd)
-{
-	return -ENOENT;
-}
-
 static inline int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
 				   struct iwl_per_chain_offset_group *table)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index ce0e0ff6193d..f76ed9d10af3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -770,6 +770,7 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
 {
 	union geo_tx_power_profiles_cmd geo_tx_cmd;
+	struct iwl_geo_tx_power_profiles_resp *resp;
 	u16 len;
 	int ret;
 	struct iwl_host_cmd cmd;
@@ -800,7 +801,13 @@ int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
 		IWL_ERR(mvm, "Failed to get geographic profile info %d\n", ret);
 		return ret;
 	}
-	ret = iwl_validate_sar_geo_profile(&mvm->fwrt, &cmd);
+
+	resp = (void *)cmd.resp_pkt->data;
+	ret = le32_to_cpu(resp->profile_idx);
+
+	if (WARN_ON(ret > ACPI_NUM_GEO_PROFILES))
+		ret = -EIO;
+
 	iwl_free_resp(&cmd);
 	return ret;
 }
-- 
2.28.0

