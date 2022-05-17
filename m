Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E388529D77
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 11:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244299AbiEQJIK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 May 2022 05:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244350AbiEQJHn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 May 2022 05:07:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C706A237D3
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 02:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652778405; x=1684314405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KmWmLlbKUi121ynjXFfpB6/+wcP8pN4quC5pQRcgklE=;
  b=YH6JDToA5fXJiHpG4jrANUsgPTRNnYyFL0TxfZiUZ6NW1qxwDr2zQ+ye
   u+o2t4OiLWqPKsHr0cn63lwUFOq/wwjZoY22rD5GBb03sR6fhpbG/ZW+n
   BR2GphdwbIkPe7OOjDfLojzzHoJK+jcEcTjDNsJdCce2bx05q/RRFZL0B
   ZbDX9BhIkw624vgN1qt+voTTrrbst8d/qsdz+euI1nDFpZVagyfVFTr+R
   n49G0mw5K8nvd4Yvc5u4eA8gtZdlFwSKemmvuj4+afVn3iFLUb94U3sAe
   eEE+s87iv6M9LOB9SSqcWUVsfCq/Pmr4B2kt3cNT3MNHSC1PV+Hm9ZZe6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="271064796"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="271064796"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 02:06:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="741679742"
Received: from sgens-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.212.48])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 02:06:27 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org
Cc:     johannes@sipsolutions.net, gregory.greenman@intel.com,
        linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>
Subject: [PATCH 06/10] iwlwifi: mvm: add OTP info in case of init failure
Date:   Tue, 17 May 2022 12:05:10 +0300
Message-Id: <20220517120045.48464938b27a.I9b381f0da5e0636ad6a5f6c13f98edb9031b50fb@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517090514.211796-1-gregory.greenman@intel.com>
References: <20220517090514.211796-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

This helps to understand HW issues that can happen while
initializing the nic.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 15 +++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index a22788a68168..157d1f31c487 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -389,6 +389,8 @@ enum {
 #define WFPM_LMAC1_PD_NOTIFICATION      0xa0338c
 #define WFPM_ARC1_PD_NOTIFICATION       0xa03044
 #define HPM_SECONDARY_DEVICE_STATE      0xa03404
+#define WFPM_MAC_OTP_CFG7_ADDR		0xa03338
+#define WFPM_MAC_OTP_CFG7_DATA		0xa0333c
 
 
 /* For UMAG_GEN_HW_STATUS reg check */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index e842816134f1..f041e77af059 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -287,6 +287,9 @@ static bool iwl_wait_phy_db_entry(struct iwl_notif_wait_data *notif_wait,
 
 static void iwl_mvm_print_pd_notification(struct iwl_mvm *mvm)
 {
+#define IWL_FW_PRINT_REG_INFO(reg_name) \
+	IWL_ERR(mvm, #reg_name ": 0x%x\n", iwl_read_umac_prph(trans, reg_name))
+
 	struct iwl_trans *trans = mvm->trans;
 	enum iwl_device_family device_family = trans->trans_cfg->device_family;
 
@@ -294,15 +297,15 @@ static void iwl_mvm_print_pd_notification(struct iwl_mvm *mvm)
 		return;
 
 	if (device_family <= IWL_DEVICE_FAMILY_9000)
-		IWL_ERR(mvm, "WFPM_ARC1_PD_NOTIFICATION: 0x%x\n",
-			iwl_read_umac_prph(trans, WFPM_ARC1_PD_NOTIFICATION));
+		IWL_FW_PRINT_REG_INFO(WFPM_ARC1_PD_NOTIFICATION);
 	else
-		IWL_ERR(mvm, "WFPM_LMAC1_PD_NOTIFICATION: 0x%x\n",
-			iwl_read_umac_prph(trans, WFPM_LMAC1_PD_NOTIFICATION));
+		IWL_FW_PRINT_REG_INFO(WFPM_LMAC1_PD_NOTIFICATION);
 
-	IWL_ERR(mvm, "HPM_SECONDARY_DEVICE_STATE: 0x%x\n",
-		iwl_read_umac_prph(trans, HPM_SECONDARY_DEVICE_STATE));
+	IWL_FW_PRINT_REG_INFO(HPM_SECONDARY_DEVICE_STATE);
 
+	/* print OPT info */
+	IWL_FW_PRINT_REG_INFO(WFPM_MAC_OTP_CFG7_ADDR);
+	IWL_FW_PRINT_REG_INFO(WFPM_MAC_OTP_CFG7_DATA);
 }
 
 static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
-- 
2.35.1

