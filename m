Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 948D6127A53
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 12:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfLTL4q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 06:56:46 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:53950 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727252AbfLTL4q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 06:56:46 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iiGtf-0007ip-Ee; Fri, 20 Dec 2019 13:56:44 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 20 Dec 2019 13:56:29 +0200
Message-Id: <20191220115638.1299888-2-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220115638.1299888-1-luca@coelho.fi>
References: <20191220115638.1299888-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.5 01/10] iwlwifi: don't send PPAG command if disabled
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gil Adam <gil.adam@intel.com>

we should not send the PPAG (Per-Platform Antenna Gain)
command to FW unless the platform has this ACPI table and it was
read and validated during the init flow. also no need to send the
command if the feature is disabled, so check if enabled before
sending, as if there is no valid table the feature is disabled.

Signed-off-by: Gil Adam <gil.adam@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index dd685f7eb410..c09624d8d7ee 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -841,9 +841,13 @@ int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
 		return 0;
 	}
 
+	if (!mvm->fwrt.ppag_table.enabled) {
+		IWL_DEBUG_RADIO(mvm,
+				"PPAG not enabled, command not sent.\n");
+		return 0;
+	}
+
 	IWL_DEBUG_RADIO(mvm, "Sending PER_PLATFORM_ANT_GAIN_CMD\n");
-	IWL_DEBUG_RADIO(mvm, "PPAG is %s\n",
-			mvm->fwrt.ppag_table.enabled ? "enabled" : "disabled");
 
 	for (i = 0; i < ACPI_PPAG_NUM_CHAINS; i++) {
 		for (j = 0; j < ACPI_PPAG_NUM_SUB_BANDS; j++) {
-- 
2.24.0

