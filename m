Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA2065974B
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 11:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfF1JU0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 05:20:26 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54720 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726738AbfF1JUZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 05:20:25 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hgn3P-0001ny-Ed; Fri, 28 Jun 2019 12:20:23 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 08/20] iwlwifi: mvm: Add log information about SAR status
Date:   Fri, 28 Jun 2019 12:19:56 +0300
Message-Id: <20190628092008.11049-9-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628092008.11049-1-luca@coelho.fi>
References: <20190628092008.11049-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

Inform users when SAR status is changing.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index b27be2e3eca2..41a98cf01d0e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -850,6 +850,9 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 			return -ENOENT;
 		}
 
+		IWL_DEBUG_INFO(mvm,
+			       "SAR EWRD: chain %d profile index %d\n",
+			       i, profs[i]);
 		IWL_DEBUG_RADIO(mvm, "  Chain[%d]:\n", i);
 		for (j = 0; j < ACPI_SAR_NUM_SUB_BANDS; j++) {
 			idx = (i * ACPI_SAR_NUM_SUB_BANDS) + j;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index 7bdbd010ae6b..719f793b3487 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -620,6 +620,7 @@ void iwl_mvm_rx_chub_update_mcc(struct iwl_mvm *mvm,
 	enum iwl_mcc_source src;
 	char mcc[3];
 	struct ieee80211_regdomain *regd;
+	u32 wgds_tbl_idx;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -643,6 +644,14 @@ void iwl_mvm_rx_chub_update_mcc(struct iwl_mvm *mvm,
 	if (IS_ERR_OR_NULL(regd))
 		return;
 
+	wgds_tbl_idx = iwl_mvm_get_sar_geo_profile(mvm);
+	if (wgds_tbl_idx < 0)
+		IWL_DEBUG_INFO(mvm, "SAR WGDS is disabled (%d)\n",
+			       wgds_tbl_idx);
+	else
+		IWL_DEBUG_INFO(mvm, "SAR WGDS: geo profile %d is configured\n",
+			       wgds_tbl_idx);
+
 	regulatory_set_wiphy_regd(mvm->hw->wiphy, regd);
 	kfree(regd);
 }
-- 
2.20.1

