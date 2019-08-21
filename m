Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5906397B09
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 15:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfHUNiM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 09:38:12 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:37758 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728932AbfHUNiK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 09:38:10 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i0QoS-0000lZ-HN; Wed, 21 Aug 2019 16:38:08 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 21 Aug 2019 16:37:46 +0300
Message-Id: <20190821133800.23636-5-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190821133800.23636-1-luca@coelho.fi>
References: <20190821133800.23636-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 04/18] iwlwifi: mvm: use FW thermal monitoring regardless of CONFIG_THERMAL
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

It doesn't make sense to use the FW thermal monitoring only if we
have CONFIG_THERMAL, because then we use the default thresholds
etc. which may be different from what the firmware implements, as
we don't maintain them in the driver now. Only the CTDP code needs
to actually be under CONFIG_THERMAL.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 5 +----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h | 4 ----
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index bb2aec9c6738..411a79e15333 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1273,7 +1273,6 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 			goto error;
 	}
 
-#ifdef CONFIG_THERMAL
 	if (iwl_mvm_is_tt_in_fw(mvm)) {
 		/* in order to give the responsibility of ct-kill and
 		 * TX backoff to FW we need to send empty temperature reporting
@@ -1285,6 +1284,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 		iwl_mvm_tt_tx_backoff(mvm, 0);
 	}
 
+#ifdef CONFIG_THERMAL
 	/* TODO: read the budget from BIOS / Platform NVM */
 
 	/*
@@ -1297,9 +1297,6 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 		if (ret)
 			goto error;
 	}
-#else
-	/* Initialize tx backoffs to the minimal possible */
-	iwl_mvm_tt_tx_backoff(mvm, 0);
 #endif
 
 	if (!fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_SET_LTR_GEN2))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 2aa9bfc5e113..3efcc3a939b8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1422,7 +1422,6 @@ iwl_mvm_get_agg_status(struct iwl_mvm *mvm, void *tx_resp)
 
 static inline bool iwl_mvm_is_tt_in_fw(struct iwl_mvm *mvm)
 {
-#ifdef CONFIG_THERMAL
 	/* these two TLV are redundant since the responsibility to CT-kill by
 	 * FW happens only after we send at least one command of
 	 * temperature THs report.
@@ -1431,9 +1430,6 @@ static inline bool iwl_mvm_is_tt_in_fw(struct iwl_mvm *mvm)
 			   IWL_UCODE_TLV_CAPA_CT_KILL_BY_FW) &&
 	       fw_has_capa(&mvm->fw->ucode_capa,
 			   IWL_UCODE_TLV_CAPA_TEMP_THS_REPORT_SUPPORT);
-#else /* CONFIG_THERMAL */
-	return false;
-#endif /* CONFIG_THERMAL */
 }
 
 static inline bool iwl_mvm_is_ctdp_supported(struct iwl_mvm *mvm)
-- 
2.23.0.rc1

