Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC5749FACB
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 14:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348911AbiA1Nen (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 08:34:43 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37848 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348905AbiA1Nem (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 08:34:42 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDROh-0002DK-Je;
        Fri, 28 Jan 2022 15:34:40 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 28 Jan 2022 15:34:24 +0200
Message-Id: <iwlwifi.20220128153014.1717817392df.I75add2a50a69d28eaebfd67e5a0524bf43119a81@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128133433.591765-1-luca@coelho.fi>
References: <20220128133433.591765-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 04/13] iwlwifi: mvm: fw: clean up hcmd struct creation
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This is valid, but pretty uncommon in the driver, clean up
the code here a bit to use an initializer.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 0bb288a17353..61741f07dd7f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -814,7 +814,11 @@ int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
 	struct iwl_geo_tx_power_profiles_resp *resp;
 	u16 len;
 	int ret;
-	struct iwl_host_cmd cmd;
+	struct iwl_host_cmd cmd = {
+		.id = WIDE_ID(PHY_OPS_GROUP, PER_CHAIN_LIMIT_OFFSET_CMD),
+		.flags = CMD_WANT_SKB,
+		.data = { &geo_tx_cmd },
+	};
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, PHY_OPS_GROUP,
 					   PER_CHAIN_LIMIT_OFFSET_CMD,
 					   IWL_FW_CMD_VER_UNKNOWN);
@@ -838,12 +842,7 @@ int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
 	if (!iwl_sar_geo_support(&mvm->fwrt))
 		return -EOPNOTSUPP;
 
-	cmd = (struct iwl_host_cmd){
-		.id =  WIDE_ID(PHY_OPS_GROUP, PER_CHAIN_LIMIT_OFFSET_CMD),
-		.len = { len, },
-		.flags = CMD_WANT_SKB,
-		.data = { &geo_tx_cmd },
-	};
+	cmd.len[0] = len;
 
 	ret = iwl_mvm_send_cmd(mvm, &cmd);
 	if (ret) {
-- 
2.34.1

