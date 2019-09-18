Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9E7B64FC
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 15:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfIRNtK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Sep 2019 09:49:10 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43438 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726659AbfIRNtJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Sep 2019 09:49:09 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iAaKR-0008Si-Op; Wed, 18 Sep 2019 16:49:08 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 18 Sep 2019 16:49:03 +0300
Message-Id: <20190918134903.10103-1-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v5.4] iwlwifi: mvm: fix build w/o CONFIG_THERMAL
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Without CONFIG_THERMAL, the driver fails to link as it calls
iwl_mvm_send_temp_report_ths_cmd() unconditionally. Fix this
by making that function available, but do almost nothing but
send the empty firmware command to enable CT-kill reporting.

While at it, also fix that function itself to not error out
when the thermal zone hasn't been initialized, but instead
just send the empty firmware command in this case as well.

Fixes: 242d9c8b9a93 ("iwlwifi: mvm: use FW thermal monitoring regardless of CONFIG_THERMAL")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 32a708301cfc..f0c539b37ea7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -555,16 +555,19 @@ static int compare_temps(const void *a, const void *b)
 	return ((s16)le16_to_cpu(*(__le16 *)a) -
 		(s16)le16_to_cpu(*(__le16 *)b));
 }
+#endif
 
 int iwl_mvm_send_temp_report_ths_cmd(struct iwl_mvm *mvm)
 {
 	struct temp_report_ths_cmd cmd = {0};
-	int ret, i, j, idx = 0;
+	int ret;
+#ifdef CONFIG_THERMAL
+	int i, j, idx = 0;
 
 	lockdep_assert_held(&mvm->mutex);
 
 	if (!mvm->tz_device.tzone)
-		return -EINVAL;
+		goto send;
 
 	/* The driver holds array of temperature trips that are unsorted
 	 * and uncompressed, the FW should get it compressed and sorted
@@ -597,6 +600,7 @@ int iwl_mvm_send_temp_report_ths_cmd(struct iwl_mvm *mvm)
 	}
 
 send:
+#endif
 	ret = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(PHY_OPS_GROUP,
 						TEMP_REPORTING_THRESHOLDS_CMD),
 				   0, sizeof(cmd), &cmd);
@@ -607,6 +611,7 @@ int iwl_mvm_send_temp_report_ths_cmd(struct iwl_mvm *mvm)
 	return ret;
 }
 
+#ifdef CONFIG_THERMAL
 static int iwl_mvm_tzone_get_temp(struct thermal_zone_device *device,
 				  int *temperature)
 {
-- 
2.23.0

