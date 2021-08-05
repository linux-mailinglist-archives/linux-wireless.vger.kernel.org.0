Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12ED53E13C8
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 13:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbhHELW0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 07:22:26 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51334 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241021AbhHELW0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 07:22:26 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mBbRx-00243p-Bl; Thu, 05 Aug 2021 14:22:11 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu,  5 Aug 2021 14:21:57 +0300
Message-Id: <iwlwifi.20210805141826.a6077801d7d5.I7d8d5c895bc467efbf81ea055dde366ea01cced1@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805112158.460799-1-luca@coelho.fi>
References: <20210805112158.460799-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 11/12] iwlwifi: mvm: load regdomain at INIT stage
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

We used to load the regdomain only in the load stage,
this caused the 'iw phy phy0 reg get' command to fail if we
booted a machine with wifi off.
Therefor we should load it in INIT stage already.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 19 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  5 +++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 2fbb7cdf00a4..03387a5f8cbc 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1381,6 +1381,25 @@ iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 		reg_query_regdb_wmm(regd->alpha2, center_freq, rule);
 	}
 
+	/*
+	 * Certain firmware versions might report no valid channels
+	 * if booted in RF-kill, i.e. not all calibrations etc. are
+	 * running. We'll get out of this situation later when the
+	 * rfkill is removed and we update the regdomain again, but
+	 * since cfg80211 doesn't accept an empty regdomain, add a
+	 * dummy (unusable) rule here in this case so we can init.
+	 */
+	if (!valid_rules) {
+		valid_rules = 1;
+		rule = &regd->reg_rules[valid_rules - 1];
+		rule->freq_range.start_freq_khz = MHZ_TO_KHZ(2412);
+		rule->freq_range.end_freq_khz = MHZ_TO_KHZ(2413);
+		rule->freq_range.max_bandwidth_khz = MHZ_TO_KHZ(1);
+		rule->power_rule.max_antenna_gain = DBI_TO_MBI(6);
+		rule->power_rule.max_eirp =
+			DBM_TO_MBM(IWL_DEFAULT_MAX_TX_POWER);
+	}
+
 	regd->n_reg_rules = valid_rules;
 
 	/*
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index 7fb4e618f76e..da705fcaf0fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2019 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2019, 2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -416,7 +416,7 @@ iwl_mvm_update_mcc(struct iwl_mvm *mvm, const char *alpha2,
 	struct iwl_rx_packet *pkt;
 	struct iwl_host_cmd cmd = {
 		.id = MCC_UPDATE_CMD,
-		.flags = CMD_WANT_SKB,
+		.flags = CMD_WANT_SKB | CMD_SEND_IN_RFKILL,
 		.data = { &mcc_update_cmd },
 	};
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index edff2cd3a30e..8ce937f8445a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -692,11 +692,16 @@ static int iwl_mvm_start_get_nvm(struct iwl_mvm *mvm)
 
 	if (ret && ret != -ERFKILL)
 		iwl_fw_dbg_error_collect(&mvm->fwrt, FW_DBG_TRIGGER_DRIVER);
+	if (!ret && iwl_mvm_is_lar_supported(mvm)) {
+		mvm->hw->wiphy->regulatory_flags |= REGULATORY_WIPHY_SELF_MANAGED;
+		ret = iwl_mvm_init_mcc(mvm);
+	}
 
 	if (!iwlmvm_mod_params.init_dbg || !ret)
 		iwl_mvm_stop_device(mvm);
 
 	mutex_unlock(&mvm->mutex);
+	rtnl_unlock();
 
 	if (ret < 0)
 		IWL_ERR(mvm, "Failed to run INIT ucode: %d\n", ret);
-- 
2.32.0

