Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBBFF129BE2
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2019 00:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfLWXrm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Dec 2019 18:47:42 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54742 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726861AbfLWXrl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Dec 2019 18:47:41 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ijXQK-00010j-1b; Tue, 24 Dec 2019 01:47:40 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 24 Dec 2019 01:47:21 +0200
Message-Id: <20191223234721.1513938-8-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191223234721.1513938-1-luca@coelho.fi>
References: <20191223234721.1513938-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.5 7/7] iwlwifi: fw: make pos static in iwl_sar_get_ewrd_table() loop
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

In the for loop where we are supposed to go through the entire table,
we are using a non-static local to keep the pos index.  This makes
each iteration start with 3, so we always access the first item on the
table.  Fix this by moving the variable outside of the loo so it
doesn't lose its value at every iteration.

Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Fixes: ba3224db7803 ("iwlwifi: mvm: fix an out-of-bound access")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 40fe2d667622..48d375a86d86 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -357,8 +357,8 @@ int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 {
 	union acpi_object *wifi_pkg, *data;
 	bool enabled;
-	int i, n_profiles, tbl_rev;
-	int  ret = 0;
+	int i, n_profiles, tbl_rev, pos;
+	int ret = 0;
 
 	data = iwl_acpi_get_object(fwrt->dev, ACPI_EWRD_METHOD);
 	if (IS_ERR(data))
@@ -390,10 +390,10 @@ int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 		goto out_free;
 	}
 
-	for (i = 0; i < n_profiles; i++) {
-		/* the tables start at element 3 */
-		int pos = 3;
+	/* the tables start at element 3 */
+	pos = 3;
 
+	for (i = 0; i < n_profiles; i++) {
 		/* The EWRD profiles officially go from 2 to 4, but we
 		 * save them in sar_profiles[1-3] (because we don't
 		 * have profile 0).  So in the array we start from 1.
-- 
2.24.0

