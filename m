Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167A51B7C0F
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 18:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgDXQrY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 12:47:24 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57986 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728575AbgDXQrX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 12:47:23 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jS1U1-000OcH-3Y; Fri, 24 Apr 2020 19:47:21 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 24 Apr 2020 19:46:58 +0300
Message-Id: <iwlwifi.20200424194456.0dc957a264ff.I43cfd72d539c1287ccaaa454e95c673dac38214f@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424164707.2715869-1-luca@coelho.fi>
References: <20200424164707.2715869-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 02/11] iwlwifi: mvm: initialize iwl_dev_tx_power_cmd to zero
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

If the REDUCE_TX_POWER_CMD version is v4 or v5, we are not
initializing some values before sending to the FW, which causes SAR
not to work properly.  Solve this by initializing the struct in the
declaration.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index d6598339c55c..c987d14597a6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -787,12 +787,11 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 	union {
 		struct iwl_dev_tx_power_cmd v5;
 		struct iwl_dev_tx_power_cmd_v4 v4;
-	} cmd;
-
+	} cmd = {
+		.v5.v3.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_CHAINS),
+	};
 	u16 len = 0;
 
-	cmd.v5.v3.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_CHAINS);
-
 	if (fw_has_api(&mvm->fw->ucode_capa,
 		       IWL_UCODE_TLV_API_REDUCE_TX_POWER))
 		len = sizeof(cmd.v5);
-- 
2.26.2

