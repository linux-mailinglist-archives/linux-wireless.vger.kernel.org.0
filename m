Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01ED048D3C6
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 09:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbiAMImp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 03:42:45 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:52430 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231756AbiAMImp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 03:42:45 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1n7vgv-001bSo-UZ; Thu, 13 Jan 2022 10:42:42 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org, lenb@kernel.org,
        johannes@sipsolutions.net
Date:   Thu, 13 Jan 2022 10:42:40 +0200
Message-Id: <iwlwifi.20220113104217.0ae07c2712dc.I14e2985bfd7ddd8a8d83eb1869b800c0e7f30db4@changeid>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH] iwlwifi: mvm: check if SAR GEO is supported before sending command
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Older hardware, for instance 3160, do not support SAR GEO offsets.  We
used to check for support before sending the command, but when moving
the command to the init phase, we lost the check.  This causes a
failure when initializing HW that do not support this command.

Fix that by adding a check before sending the command.  Additionally,
fix the caller so that it checks for the return value of the
iwl_mvm_sar_geo_init() function, which it was ignoring.

Fixes: db700bc35703 ("iwlwifi: mvm: check if SAR GEO is supported before sending command")
Cc: stable@vger.kernel.org # 5.15+
Reported-by: Len Brown <lenb@kernel.org>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 6f4690e56a46..6528a6253336 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -882,6 +882,10 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v4, ops) !=
 		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v5, ops));
 
+	/* not supporting GEO is not a failure, so return 0 */
+	if (!iwl_sar_geo_support(&mvm->fwrt))
+		return 0;
+
 	/* the ops field is at the same spot for all versions, so set in v1 */
 	cmd.v1.ops = cpu_to_le32(IWL_PER_CHAIN_OFFSET_SET_TABLES);
 
@@ -1741,7 +1745,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	ret = iwl_mvm_sar_init(mvm);
 	if (ret == 0)
 		ret = iwl_mvm_sar_geo_init(mvm);
-	else if (ret < 0)
+	if (ret < 0)
 		goto error;
 
 	ret = iwl_mvm_sgom_init(mvm);
-- 
2.34.1

