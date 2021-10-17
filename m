Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA94E430986
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 16:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343800AbhJQOCK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 10:02:10 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53940 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343772AbhJQOCJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 10:02:09 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc6hh-000Yi6-Qg; Sun, 17 Oct 2021 16:59:58 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 16:59:46 +0300
Message-Id: <iwlwifi.20211017165728.dda7f6ba0b22.Ia107bfe496b84e8a2edb33d9f39a5d2b56ed63f7@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017135954.504836-1-luca@coelho.fi>
References: <20211017135954.504836-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 02/10] iwlwifi: mvm: set inactivity timeouts also for PS-poll
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sara Sharon <sara.sharon@intel.com>

Code tried to avoid setting ACs for PS-poll by an early return.
However as a result the timeouts weren't set as well.

Inactivity timeout of zero means we will always try to go back to
sleep immediately after moving to AM, which doesn't make much sense,
and isn't supported by FW.

Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/power.c    | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index f2b090be3898..b2ea2fca5376 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2019 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2019, 2021 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -128,6 +128,19 @@ static void iwl_mvm_power_configure_uapsd(struct iwl_mvm *mvm,
 	enum ieee80211_ac_numbers ac;
 	bool tid_found = false;
 
+	if (test_bit(IWL_MVM_STATUS_IN_D3, &mvm->status) ||
+	    cmd->flags & cpu_to_le16(POWER_FLAGS_SNOOZE_ENA_MSK)) {
+		cmd->rx_data_timeout_uapsd =
+			cpu_to_le32(IWL_MVM_WOWLAN_PS_RX_DATA_TIMEOUT);
+		cmd->tx_data_timeout_uapsd =
+			cpu_to_le32(IWL_MVM_WOWLAN_PS_TX_DATA_TIMEOUT);
+	} else {
+		cmd->rx_data_timeout_uapsd =
+			cpu_to_le32(IWL_MVM_UAPSD_RX_DATA_TIMEOUT);
+		cmd->tx_data_timeout_uapsd =
+			cpu_to_le32(IWL_MVM_UAPSD_TX_DATA_TIMEOUT);
+	}
+
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	/* set advanced pm flag with no uapsd ACs to enable ps-poll */
 	if (mvmvif->dbgfs_pm.use_ps_poll) {
@@ -182,19 +195,6 @@ static void iwl_mvm_power_configure_uapsd(struct iwl_mvm *mvm,
 
 	cmd->uapsd_max_sp = mvm->hw->uapsd_max_sp_len;
 
-	if (test_bit(IWL_MVM_STATUS_IN_D3, &mvm->status) ||
-	    cmd->flags & cpu_to_le16(POWER_FLAGS_SNOOZE_ENA_MSK)) {
-		cmd->rx_data_timeout_uapsd =
-			cpu_to_le32(IWL_MVM_WOWLAN_PS_RX_DATA_TIMEOUT);
-		cmd->tx_data_timeout_uapsd =
-			cpu_to_le32(IWL_MVM_WOWLAN_PS_TX_DATA_TIMEOUT);
-	} else {
-		cmd->rx_data_timeout_uapsd =
-			cpu_to_le32(IWL_MVM_UAPSD_RX_DATA_TIMEOUT);
-		cmd->tx_data_timeout_uapsd =
-			cpu_to_le32(IWL_MVM_UAPSD_TX_DATA_TIMEOUT);
-	}
-
 	if (cmd->flags & cpu_to_le16(POWER_FLAGS_SNOOZE_ENA_MSK)) {
 		cmd->heavy_tx_thld_packets =
 			IWL_MVM_PS_SNOOZE_HEAVY_TX_THLD_PACKETS;
-- 
2.33.0

