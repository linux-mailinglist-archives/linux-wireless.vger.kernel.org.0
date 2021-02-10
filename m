Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4784A3165E4
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 13:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhBJMAi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 07:00:38 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45000 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231387AbhBJL5q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 06:57:46 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9o6t-0049Ur-Gq; Wed, 10 Feb 2021 13:56:43 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 13:56:34 +0200
Message-Id: <iwlwifi.20210210135352.cef55ef3a065.If96c60f08d24c2262c287168a6f0dbd7cf0f8f5c@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210115637.276676-1-luca@coelho.fi>
References: <20210210115637.276676-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 09/12] iwlwifi: mvm: assign SAR table revision to the command later
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The call to iwl_sar_geo_init() was moved to the end of the
iwl_mvm_sar_geo_init() function, after the table revision is assigned
to the FW command.  But the revision is only known after
iwl_sar_geo_init() is called, so we were always assigning zero to it.

Fix that by moving the assignment code after the iwl_sar_geo_init()
function is called.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Fixes: 45acebf8d6a6 ("iwlwifi: fix sar geo table initialization")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 8675a78ff9e9..76c460852398 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -862,12 +862,10 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	if (cmd_ver == 3) {
 		len = sizeof(cmd.v3);
 		n_bands = ARRAY_SIZE(cmd.v3.table[0]);
-		cmd.v3.table_revision = cpu_to_le32(mvm->fwrt.geo_rev);
 	} else if (fw_has_api(&mvm->fwrt.fw->ucode_capa,
 			      IWL_UCODE_TLV_API_SAR_TABLE_VER)) {
 		len = sizeof(cmd.v2);
 		n_bands = ARRAY_SIZE(cmd.v2.table[0]);
-		cmd.v2.table_revision = cpu_to_le32(mvm->fwrt.geo_rev);
 	} else {
 		len = sizeof(cmd.v1);
 		n_bands = ARRAY_SIZE(cmd.v1.table[0]);
@@ -887,6 +885,16 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	if (ret)
 		return 0;
 
+	/*
+	 * Set the revision on versions that contain it.
+	 * This must be done after calling iwl_sar_geo_init().
+	 */
+	if (cmd_ver == 3)
+		cmd.v3.table_revision = cpu_to_le32(mvm->fwrt.geo_rev);
+	else if (fw_has_api(&mvm->fwrt.fw->ucode_capa,
+			    IWL_UCODE_TLV_API_SAR_TABLE_VER))
+		cmd.v2.table_revision = cpu_to_le32(mvm->fwrt.geo_rev);
+
 	return iwl_mvm_send_cmd_pdu(mvm,
 				    WIDE_ID(PHY_OPS_GROUP, GEO_TX_POWER_LIMIT),
 				    0, len, &cmd);
-- 
2.30.0

