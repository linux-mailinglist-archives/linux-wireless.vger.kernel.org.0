Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1112F4AA7DB
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Feb 2022 10:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244026AbiBEJVw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Feb 2022 04:21:52 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37994 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343667AbiBEJVu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Feb 2022 04:21:50 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nGHGO-0006b7-Sg;
        Sat, 05 Feb 2022 11:21:49 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  5 Feb 2022 11:21:34 +0200
Message-Id: <iwlwifi.20220205112029.7971a6d70653.Icb3ee1e5d52e5437531dadeda63e32719b44b645@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205092140.751171-1-luca@coelho.fi>
References: <20220205092140.751171-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 06/12] iwlwifi: mvm: add additional info for boot info failures
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

This info helps for additional info in case we have issues
with OTP at boot time.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  5 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 20 ++++++++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 03d296a2b38e..c610f59081c9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016 Intel Deutschland GmbH
  */
@@ -386,6 +386,9 @@ enum {
 #define UREG_LMAC1_CURRENT_PC		0xa05c1c
 #define UREG_LMAC2_CURRENT_PC		0xa05c20
 
+#define WFPM_LMAC1_PD_NOTIFICATION      0xa0338c
+#define WFPM_ARC1_PD_NOTIFICATION       0xa03044
+
 /* For UMAG_GEN_HW_STATUS reg check */
 enum {
 	UMAG_GEN_HW_IS_FPGA = BIT(1),
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 1e78599b63e3..135a715d924b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -265,6 +265,22 @@ static bool iwl_wait_phy_db_entry(struct iwl_notif_wait_data *notif_wait,
 	return false;
 }
 
+static void iwl_mvm_print_pd_notification(struct iwl_mvm *mvm)
+{
+	struct iwl_trans *trans = mvm->trans;
+	enum iwl_device_family device_family = trans->trans_cfg->device_family;
+
+	if (device_family < IWL_DEVICE_FAMILY_8000)
+		return;
+
+	if (device_family <= IWL_DEVICE_FAMILY_9000)
+		IWL_ERR(mvm, "WFPM_ARC1_PD_NOTIFICATION: 0x%x\n",
+			iwl_read_umac_prph(trans, WFPM_ARC1_PD_NOTIFICATION));
+	else
+		IWL_ERR(mvm, "WFPM_LMAC1_PD_NOTIFICATION: 0x%x\n",
+			iwl_read_umac_prph(trans, WFPM_LMAC1_PD_NOTIFICATION));
+}
+
 static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 					 enum iwl_ucode_type ucode_type)
 {
@@ -330,6 +346,8 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 				iwl_read_prph(trans, SB_CPU_2_STATUS));
 		}
 
+		iwl_mvm_print_pd_notification(mvm);
+
 		/* LMAC/UMAC PC info */
 		if (trans->trans_cfg->device_family >=
 					IWL_DEVICE_FAMILY_9000) {
-- 
2.34.1

