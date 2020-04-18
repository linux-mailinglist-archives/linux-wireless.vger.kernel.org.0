Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4832B1AEAB6
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2020 10:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgDRIJU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Apr 2020 04:09:20 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56758 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725982AbgDRIJT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Apr 2020 04:09:19 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPiXM-000L3r-Ge; Sat, 18 Apr 2020 11:09:16 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 18 Apr 2020 11:08:49 +0300
Message-Id: <iwlwifi.20200418110539.03bd49c3432b.Ie62047d3b364b19c8c3584ea37790220466f2a8d@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200418080857.2232093-1-luca@coelho.fi>
References: <20200418080857.2232093-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 04/12] iwlwifi: remove fw_monitor module parameter
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This module parameter is no longer useful now that other debug
infrastructure was added to iwlwifi.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c      |  4 ----
 .../net/wireless/intel/iwlwifi/iwl-modparams.h    |  2 --
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c   | 15 +--------------
 3 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index ff52e69c1c80..9ff12c207f25 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1872,10 +1872,6 @@ module_param_named(power_level, iwlwifi_mod_params.power_level, int, 0444);
 MODULE_PARM_DESC(power_level,
 		 "default power save level (range from 1 - 5, default: 1)");
 
-module_param_named(fw_monitor, iwlwifi_mod_params.fw_monitor, bool, 0444);
-MODULE_PARM_DESC(fw_monitor,
-		 "firmware monitor - to debug FW (default: false - needs lots of memory)");
-
 module_param_named(disable_11ac, iwlwifi_mod_params.disable_11ac, bool, 0444);
 MODULE_PARM_DESC(disable_11ac, "Disable VHT capabilities (default: false)");
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h b/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
index 82e5cac23d8d..b094cc1e9be0 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
@@ -115,7 +115,6 @@ enum iwl_uapsd_disable {
  * @nvm_file: specifies a external NVM file
  * @uapsd_disable: disable U-APSD, see &enum iwl_uapsd_disable, default =
  *	IWL_DISABLE_UAPSD_BSS | IWL_DISABLE_UAPSD_P2P_CLIENT
- * @fw_monitor: allow to use firmware monitor
  * @disable_11ac: disable VHT capabilities, default = false.
  * @remove_when_gone: remove an inaccessible device from the PCIe bus.
  * @enable_ini: enable new FW debug infratructure (INI TLVs)
@@ -135,7 +134,6 @@ struct iwl_mod_params {
 	int antenna_coupling;
 	char *nvm_file;
 	u32 uapsd_disable;
-	bool fw_monitor;
 	bool disable_11ac;
 	/**
 	 * @disable_11ax: disable HE capabilities, default = false
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 06785c46c50d..a0daae058c1c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1019,21 +1019,8 @@ static int iwl_pcie_load_given_ucode(struct iwl_trans *trans,
 			return ret;
 	}
 
-	/* supported for 7000 only for the moment */
-	if (iwlwifi_mod_params.fw_monitor &&
-	    trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_7000) {
-		struct iwl_dram_data *fw_mon = &trans->dbg.fw_mon;
-
-		iwl_pcie_alloc_fw_monitor(trans, 0);
-		if (fw_mon->size) {
-			iwl_write_prph(trans, MON_BUFF_BASE_ADDR,
-				       fw_mon->physical >> 4);
-			iwl_write_prph(trans, MON_BUFF_END_ADDR,
-				       (fw_mon->physical + fw_mon->size) >> 4);
-		}
-	} else if (iwl_pcie_dbg_on(trans)) {
+	if (iwl_pcie_dbg_on(trans))
 		iwl_pcie_apply_destination(trans);
-	}
 
 	iwl_enable_interrupts(trans);
 
-- 
2.25.1

