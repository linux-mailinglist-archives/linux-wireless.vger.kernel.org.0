Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A54C430748
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 10:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245108AbhJQIqH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 04:46:07 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53562 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245092AbhJQIqD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 04:46:03 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc1lo-000YRM-Ts; Sun, 17 Oct 2021 11:43:53 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 11:43:41 +0300
Message-Id: <iwlwifi.20211017113927.e51c61b31037.I118299d9d6eeef211cc8d4ee72193fdddc54d446@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017084348.401570-1-luca@coelho.fi>
References: <20211017084348.401570-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 03/10] iwlwifi: mvm: add lmac/umac PC info in case of error
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Currently it's only added to 22000 family in this patch we also add
it to 9000 family where it's also relevant.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 74404c96063b..660860b8d02f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -295,6 +295,7 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 	if (ret) {
 		struct iwl_trans *trans = mvm->trans;
 
+		/* SecBoot info */
 		if (trans->trans_cfg->device_family >=
 					IWL_DEVICE_FAMILY_22000) {
 			IWL_ERR(mvm,
@@ -302,6 +303,17 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 				iwl_read_umac_prph(trans, UMAG_SB_CPU_1_STATUS),
 				iwl_read_umac_prph(trans,
 						   UMAG_SB_CPU_2_STATUS));
+		} else if (trans->trans_cfg->device_family >=
+			   IWL_DEVICE_FAMILY_8000) {
+			IWL_ERR(mvm,
+				"SecBoot CPU1 Status: 0x%x, CPU2 Status: 0x%x\n",
+				iwl_read_prph(trans, SB_CPU_1_STATUS),
+				iwl_read_prph(trans, SB_CPU_2_STATUS));
+		}
+
+		/* LMAC/UMAC PC info */
+		if (trans->trans_cfg->device_family >=
+					IWL_DEVICE_FAMILY_9000) {
 			IWL_ERR(mvm, "UMAC PC: 0x%x\n",
 				iwl_read_umac_prph(trans,
 						   UREG_UMAC_CURRENT_PC));
@@ -312,12 +324,6 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 				IWL_ERR(mvm, "LMAC2 PC: 0x%x\n",
 					iwl_read_umac_prph(trans,
 						UREG_LMAC2_CURRENT_PC));
-		} else if (trans->trans_cfg->device_family >=
-			   IWL_DEVICE_FAMILY_8000) {
-			IWL_ERR(mvm,
-				"SecBoot CPU1 Status: 0x%x, CPU2 Status: 0x%x\n",
-				iwl_read_prph(trans, SB_CPU_1_STATUS),
-				iwl_read_prph(trans, SB_CPU_2_STATUS));
 		}
 
 		if (ret == -ETIMEDOUT)
-- 
2.33.0

