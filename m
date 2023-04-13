Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A92B6E080D
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 09:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjDMHqR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 03:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjDMHqP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 03:46:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9427D96
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 00:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681371974; x=1712907974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rGoID+Lcddzs+iHp/xsTC+IGaV45B4iELsQ2PXaZReo=;
  b=dFHKfKyJWcur1GVUdkqC6/sBz2Ca2hdkc/h1Fb63p8+rLSJAqspeWdKQ
   Nioh3xuQ8sZ9+xruFRlhDj2w7ahw43o+G+bl/XBK18T/TONnhKs2F15XL
   nu1gnGGOEVqcq5B9NksYCcyS8sOQaLxsDGSRPdgiI4DlEZRhqjNU2Lixc
   1h6NVj85X4EOfKyZqUDhoVD55hHdVLG+Fv5MVEtbP/qh/I4GzELwsR3nI
   joJHtIxbgoiqgeWEUpzEm9VnRIUln06kU1DY1qBhm8n4xZDTsePFnFKJ9
   3iJL01IH+6619mJUTTf7F/IQfy27hSkdp6JEGGgXtxkx/rn2u7VRwA3QI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323736088"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="323736088"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="833034812"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="833034812"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:32 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/15] wifi: iwlwifi: mvm: move function sequence
Date:   Thu, 13 Apr 2023 10:44:11 +0300
Message-Id: <20230413102635.00a6c203712f.I7c099e5c1954f1daa5a5039b98149b6f081e46ae@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230413074415.1054160-1-gregory.greenman@intel.com>
References: <20230413074415.1054160-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Need to move a function definition and actual changes
will be done in following commit.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 210 ++++++++++----------
 1 file changed, 105 insertions(+), 105 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 7fe733dcc748..a6b11bccb0c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -467,111 +467,6 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 	return 0;
 }
 
-static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm)
-{
-	struct iwl_notification_wait init_wait;
-	struct iwl_nvm_access_complete_cmd nvm_complete = {};
-	struct iwl_init_extended_cfg_cmd init_cfg = {
-		.init_flags = cpu_to_le32(BIT(IWL_INIT_NVM)),
-	};
-	static const u16 init_complete[] = {
-		INIT_COMPLETE_NOTIF,
-	};
-	int ret;
-
-	if (mvm->trans->cfg->tx_with_siso_diversity)
-		init_cfg.init_flags |= cpu_to_le32(BIT(IWL_INIT_PHY));
-
-	lockdep_assert_held(&mvm->mutex);
-
-	mvm->rfkill_safe_init_done = false;
-
-	iwl_init_notification_wait(&mvm->notif_wait,
-				   &init_wait,
-				   init_complete,
-				   ARRAY_SIZE(init_complete),
-				   iwl_wait_init_complete,
-				   NULL);
-
-	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_POINT_EARLY, NULL);
-
-	/* Will also start the device */
-	ret = iwl_mvm_load_ucode_wait_alive(mvm, IWL_UCODE_REGULAR);
-	if (ret) {
-		IWL_ERR(mvm, "Failed to start RT ucode: %d\n", ret);
-		goto error;
-	}
-	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_POINT_AFTER_ALIVE,
-			       NULL);
-
-	/* Send init config command to mark that we are sending NVM access
-	 * commands
-	 */
-	ret = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(SYSTEM_GROUP,
-						INIT_EXTENDED_CFG_CMD),
-				   CMD_SEND_IN_RFKILL,
-				   sizeof(init_cfg), &init_cfg);
-	if (ret) {
-		IWL_ERR(mvm, "Failed to run init config command: %d\n",
-			ret);
-		goto error;
-	}
-
-	/* Load NVM to NIC if needed */
-	if (mvm->nvm_file_name) {
-		ret = iwl_read_external_nvm(mvm->trans, mvm->nvm_file_name,
-					    mvm->nvm_sections);
-		if (ret)
-			goto error;
-		ret = iwl_mvm_load_nvm_to_nic(mvm);
-		if (ret)
-			goto error;
-	}
-
-	if (IWL_MVM_PARSE_NVM && !mvm->nvm_data) {
-		ret = iwl_nvm_init(mvm);
-		if (ret) {
-			IWL_ERR(mvm, "Failed to read NVM: %d\n", ret);
-			goto error;
-		}
-	}
-
-	ret = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(REGULATORY_AND_NVM_GROUP,
-						NVM_ACCESS_COMPLETE),
-				   CMD_SEND_IN_RFKILL,
-				   sizeof(nvm_complete), &nvm_complete);
-	if (ret) {
-		IWL_ERR(mvm, "Failed to run complete NVM access: %d\n",
-			ret);
-		goto error;
-	}
-
-	/* We wait for the INIT complete notification */
-	ret = iwl_wait_notification(&mvm->notif_wait, &init_wait,
-				    MVM_UCODE_ALIVE_TIMEOUT);
-	if (ret)
-		return ret;
-
-	/* Read the NVM only at driver load time, no need to do this twice */
-	if (!IWL_MVM_PARSE_NVM && !mvm->nvm_data) {
-		mvm->nvm_data = iwl_get_nvm(mvm->trans, mvm->fw);
-		if (IS_ERR(mvm->nvm_data)) {
-			ret = PTR_ERR(mvm->nvm_data);
-			mvm->nvm_data = NULL;
-			IWL_ERR(mvm, "Failed to read NVM: %d\n", ret);
-			return ret;
-		}
-	}
-
-	mvm->rfkill_safe_init_done = true;
-
-	return 0;
-
-error:
-	iwl_remove_notification(&mvm->notif_wait, &init_wait);
-	return ret;
-}
-
 #ifdef CONFIG_ACPI
 static void iwl_mvm_phy_filter_init(struct iwl_mvm *mvm,
 				    struct iwl_phy_specific_cfg *phy_filters)
@@ -698,6 +593,111 @@ static int iwl_send_phy_cfg_cmd(struct iwl_mvm *mvm)
 	return iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, cmd_size, &phy_cfg_cmd);
 }
 
+static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm)
+{
+	struct iwl_notification_wait init_wait;
+	struct iwl_nvm_access_complete_cmd nvm_complete = {};
+	struct iwl_init_extended_cfg_cmd init_cfg = {
+		.init_flags = cpu_to_le32(BIT(IWL_INIT_NVM)),
+	};
+	static const u16 init_complete[] = {
+		INIT_COMPLETE_NOTIF,
+	};
+	int ret;
+
+	if (mvm->trans->cfg->tx_with_siso_diversity)
+		init_cfg.init_flags |= cpu_to_le32(BIT(IWL_INIT_PHY));
+
+	lockdep_assert_held(&mvm->mutex);
+
+	mvm->rfkill_safe_init_done = false;
+
+	iwl_init_notification_wait(&mvm->notif_wait,
+				   &init_wait,
+				   init_complete,
+				   ARRAY_SIZE(init_complete),
+				   iwl_wait_init_complete,
+				   NULL);
+
+	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_POINT_EARLY, NULL);
+
+	/* Will also start the device */
+	ret = iwl_mvm_load_ucode_wait_alive(mvm, IWL_UCODE_REGULAR);
+	if (ret) {
+		IWL_ERR(mvm, "Failed to start RT ucode: %d\n", ret);
+		goto error;
+	}
+	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_POINT_AFTER_ALIVE,
+			       NULL);
+
+	/* Send init config command to mark that we are sending NVM access
+	 * commands
+	 */
+	ret = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(SYSTEM_GROUP,
+						INIT_EXTENDED_CFG_CMD),
+				   CMD_SEND_IN_RFKILL,
+				   sizeof(init_cfg), &init_cfg);
+	if (ret) {
+		IWL_ERR(mvm, "Failed to run init config command: %d\n",
+			ret);
+		goto error;
+	}
+
+	/* Load NVM to NIC if needed */
+	if (mvm->nvm_file_name) {
+		ret = iwl_read_external_nvm(mvm->trans, mvm->nvm_file_name,
+					    mvm->nvm_sections);
+		if (ret)
+			goto error;
+		ret = iwl_mvm_load_nvm_to_nic(mvm);
+		if (ret)
+			goto error;
+	}
+
+	if (IWL_MVM_PARSE_NVM && !mvm->nvm_data) {
+		ret = iwl_nvm_init(mvm);
+		if (ret) {
+			IWL_ERR(mvm, "Failed to read NVM: %d\n", ret);
+			goto error;
+		}
+	}
+
+	ret = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(REGULATORY_AND_NVM_GROUP,
+						NVM_ACCESS_COMPLETE),
+				   CMD_SEND_IN_RFKILL,
+				   sizeof(nvm_complete), &nvm_complete);
+	if (ret) {
+		IWL_ERR(mvm, "Failed to run complete NVM access: %d\n",
+			ret);
+		goto error;
+	}
+
+	/* We wait for the INIT complete notification */
+	ret = iwl_wait_notification(&mvm->notif_wait, &init_wait,
+				    MVM_UCODE_ALIVE_TIMEOUT);
+	if (ret)
+		return ret;
+
+	/* Read the NVM only at driver load time, no need to do this twice */
+	if (!IWL_MVM_PARSE_NVM && !mvm->nvm_data) {
+		mvm->nvm_data = iwl_get_nvm(mvm->trans, mvm->fw);
+		if (IS_ERR(mvm->nvm_data)) {
+			ret = PTR_ERR(mvm->nvm_data);
+			mvm->nvm_data = NULL;
+			IWL_ERR(mvm, "Failed to read NVM: %d\n", ret);
+			return ret;
+		}
+	}
+
+	mvm->rfkill_safe_init_done = true;
+
+	return 0;
+
+error:
+	iwl_remove_notification(&mvm->notif_wait, &init_wait);
+	return ret;
+}
+
 int iwl_run_init_mvm_ucode(struct iwl_mvm *mvm)
 {
 	struct iwl_notification_wait calib_wait;
-- 
2.38.1

