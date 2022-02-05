Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E174AA7E2
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Feb 2022 10:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350389AbiBEJV4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Feb 2022 04:21:56 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:38004 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1352990AbiBEJVz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Feb 2022 04:21:55 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nGHGT-0006b7-6j;
        Sat, 05 Feb 2022 11:21:54 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  5 Feb 2022 11:21:39 +0200
Message-Id: <iwlwifi.20220205112029.e3530bf30f1f.Ib354675937352f6e4a992f1d5d49f2f38acfe2e5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205092140.751171-1-luca@coelho.fi>
References: <20220205092140.751171-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 11/12] iwlwifi: mvm: add additional info for boot info failures
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

This info helps for additional info in case we have issues
with HPM state at boot time.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h | 2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index c610f59081c9..a22788a68168 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -388,6 +388,8 @@ enum {
 
 #define WFPM_LMAC1_PD_NOTIFICATION      0xa0338c
 #define WFPM_ARC1_PD_NOTIFICATION       0xa03044
+#define HPM_SECONDARY_DEVICE_STATE      0xa03404
+
 
 /* For UMAG_GEN_HW_STATUS reg check */
 enum {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 77953ee708d2..9aa15f0cf79c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -279,6 +279,10 @@ static void iwl_mvm_print_pd_notification(struct iwl_mvm *mvm)
 	else
 		IWL_ERR(mvm, "WFPM_LMAC1_PD_NOTIFICATION: 0x%x\n",
 			iwl_read_umac_prph(trans, WFPM_LMAC1_PD_NOTIFICATION));
+
+	IWL_ERR(mvm, "HPM_SECONDARY_DEVICE_STATE: 0x%x\n",
+		iwl_read_umac_prph(trans, HPM_SECONDARY_DEVICE_STATE));
+
 }
 
 static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
-- 
2.34.1

