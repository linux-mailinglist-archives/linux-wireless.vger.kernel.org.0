Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D412876CD
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 17:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbgJHPKJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 11:10:09 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54520 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730912AbgJHPKJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 11:10:09 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kQXYO-002Qut-78; Thu, 08 Oct 2020 18:10:00 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  8 Oct 2020 18:09:46 +0300
Message-Id: <iwlwifi.20201008180656.ac3b43e97aa8.I308f8ed2238e32d5eef9c35ad7962f0e8b9c1902@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008150949.331882-1-luca@coelho.fi>
References: <20201008150949.331882-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 10/13] iwlwifi: mvm: add a get lmac id function
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Nathan Errera <nathan.errera@intel.com>

As some functions need to check which lmac id to use, add
a new function to find the lmac id instead of open coding it
in every function.

Signed-off-by: Nathan Errera <nathan.errera@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/binding.h  | 16 +++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/binding.c | 11 ++++-------
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c    |  7 ++-----
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c      |  6 +-----
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/binding.h b/drivers/net/wireless/intel/iwlwifi/fw/api/binding.h
index 570f19026c91..6cb22a9a9380 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/binding.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/binding.h
@@ -5,7 +5,7 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2012 - 2014, 2020 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
  *
@@ -27,7 +27,7 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2012 - 2014, 2020 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
  * All rights reserved.
@@ -59,10 +59,12 @@
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  *****************************************************************************/
-
 #ifndef __iwl_fw_api_binding_h__
 #define __iwl_fw_api_binding_h__
 
+#include <fw/file.h>
+#include <fw/img.h>
+
 #define MAX_MACS_IN_BINDING	(3)
 #define MAX_BINDINGS		(4)
 
@@ -112,6 +114,14 @@ struct iwl_binding_cmd {
 #define IWL_LMAC_24G_INDEX		0
 #define IWL_LMAC_5G_INDEX		1
 
+static inline u32 iwl_mvm_get_lmac_id(const struct iwl_fw *fw,
+				      enum nl80211_band band){
+	if (!fw_has_capa(&fw->ucode_capa, IWL_UCODE_TLV_CAPA_CDB_SUPPORT) ||
+	    band == NL80211_BAND_2GHZ)
+		return IWL_LMAC_24G_INDEX;
+	return IWL_LMAC_5G_INDEX;
+}
+
 /* The maximal number of fragments in the FW's schedule session */
 #define IWL_MVM_MAX_QUOTA 128
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/binding.c b/drivers/net/wireless/intel/iwlwifi/mvm/binding.c
index 4094a4158032..5e731c57e4f7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/binding.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/binding.c
@@ -5,7 +5,7 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2012 - 2014, 2020 Intel Corporation. All rights reserved.
  * Copyright(c) 2016 Intel Deutschland GmbH
  *
  * This program is free software; you can redistribute it and/or modify
@@ -26,7 +26,7 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2012 - 2014, 2020 Intel Corporation. All rights reserved.
  * Copyright(c) 2016 Intel Deutschland GmbH
  * All rights reserved.
  *
@@ -86,11 +86,8 @@ static int iwl_mvm_binding_cmd(struct iwl_mvm *mvm, u32 action,
 	if (fw_has_capa(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_CAPA_BINDING_CDB_SUPPORT)) {
 		size = sizeof(cmd);
-		if (phyctxt->channel->band == NL80211_BAND_2GHZ ||
-		    !iwl_mvm_is_cdb_supported(mvm))
-			cmd.lmac_id = cpu_to_le32(IWL_LMAC_24G_INDEX);
-		else
-			cmd.lmac_id = cpu_to_le32(IWL_LMAC_5G_INDEX);
+		cmd.lmac_id = cpu_to_le32(iwl_mvm_get_lmac_id(mvm->fw,
+							      phyctxt->channel->band));
 	} else {
 		size = IWL_BINDING_CMD_SIZE_V1;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index a5da4106ba5a..bf2fc44dcb8d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -194,11 +194,8 @@ static void iwl_mvm_phy_ctxt_cmd_data(struct iwl_mvm *mvm,
 				      struct cfg80211_chan_def *chandef,
 				      u8 chains_static, u8 chains_dynamic)
 {
-	if (chandef->chan->band == NL80211_BAND_2GHZ ||
-	    !iwl_mvm_is_cdb_supported(mvm))
-		cmd->lmac_id = cpu_to_le32(IWL_LMAC_24G_INDEX);
-	else
-		cmd->lmac_id = cpu_to_le32(IWL_LMAC_5G_INDEX);
+	cmd->lmac_id = cpu_to_le32(iwl_mvm_get_lmac_id(mvm->fw,
+						       chandef->chan->band));
 
 	/* Set the channel info data */
 	iwl_mvm_set_chan_info_chandef(mvm, &cmd->ci, chandef);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 12e5d00ef5cd..fe1c538cd718 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -793,11 +793,7 @@ unsigned int iwl_mvm_max_amsdu_size(struct iwl_mvm *mvm,
 	enum nl80211_band band = mvmsta->vif->bss_conf.chandef.chan->band;
 	u8 ac = tid_to_mac80211_ac[tid];
 	unsigned int txf;
-	int lmac = IWL_LMAC_24G_INDEX;
-
-	if (iwl_mvm_is_cdb_supported(mvm) &&
-	    band == NL80211_BAND_5GHZ)
-		lmac = IWL_LMAC_5G_INDEX;
+	int lmac = iwl_mvm_get_lmac_id(mvm->fw, band);
 
 	/* For HE redirect to trigger based fifos */
 	if (sta->he_cap.has_he && !WARN_ON(!iwl_mvm_has_new_tx_api(mvm)))
-- 
2.28.0

