Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DFC47A02C
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 11:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbhLSKSh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 05:18:37 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51394 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235597AbhLSKSg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 05:18:36 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mytH0-001O3b-3I; Sun, 19 Dec 2021 12:18:34 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 19 Dec 2021 12:18:20 +0200
Message-Id: <iwlwifi.20211219121514.6d5c043372cf.I251dd5618a3f0b8febbcca788eb861f1cd6039bc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211219101820.85153-1-luca@coelho.fi>
References: <20211219101820.85153-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 12/12] iwlwifi: mvm: perform 6GHz passive scan after suspend
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

The 6GHz passive scan is performed only once every 50 minutes.
However, in case of suspend/resume, the regulatory information
is reset, so 6GHz channels may become disabled.
Fix it by performing a 6GHz passive scan within 60 seconds after
suspend/resume even if the 50 minutes timeout did not expire yet.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Fixes: e8fe3b41c3a3 ("iwlwifi: mvm: Add support for 6GHz passive scan")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 21 ++++++++-----------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index cad190fac9e3..68ee57790b17 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1925,22 +1925,19 @@ static void iwl_mvm_scan_6ghz_passive_scan(struct iwl_mvm *mvm,
 	}
 
 	/*
-	 * 6GHz passive scan is allowed while associated in a defined time
-	 * interval following HW reset or resume flow
+	 * 6GHz passive scan is allowed in a defined time interval following HW
+	 * reset or resume flow, or while not associated and a large interval
+	 * has passed since the last 6GHz passive scan.
 	 */
-	if (vif->bss_conf.assoc &&
+	if ((vif->bss_conf.assoc ||
+	     time_after(mvm->last_6ghz_passive_scan_jiffies +
+			(IWL_MVM_6GHZ_PASSIVE_SCAN_TIMEOUT * HZ), jiffies)) &&
 	    (time_before(mvm->last_reset_or_resume_time_jiffies +
 			 (IWL_MVM_6GHZ_PASSIVE_SCAN_ASSOC_TIMEOUT * HZ),
 			 jiffies))) {
-		IWL_DEBUG_SCAN(mvm, "6GHz passive scan: associated\n");
-		return;
-	}
-
-	/* No need for 6GHz passive scan if not enough time elapsed */
-	if (time_after(mvm->last_6ghz_passive_scan_jiffies +
-		       (IWL_MVM_6GHZ_PASSIVE_SCAN_TIMEOUT * HZ), jiffies)) {
-		IWL_DEBUG_SCAN(mvm,
-			       "6GHz passive scan: timeout did not expire\n");
+		IWL_DEBUG_SCAN(mvm, "6GHz passive scan: %s\n",
+			       vif->bss_conf.assoc ? "associated" :
+			       "timeout did not expire");
 		return;
 	}
 
-- 
2.34.1

