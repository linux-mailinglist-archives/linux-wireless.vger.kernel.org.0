Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95973165E5
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 13:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhBJL7v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 06:59:51 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:44976 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231327AbhBJL5i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 06:57:38 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9o6r-0049Ur-A2; Wed, 10 Feb 2021 13:56:41 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 13:56:30 +0200
Message-Id: <iwlwifi.20210210135352.889862e6d393.I8b894c1b2b3fe0ad2fb39bf438273ea47eb5afa4@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210115637.276676-1-luca@coelho.fi>
References: <20210210115637.276676-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 05/12] iwlwifi: mvm: store PPAG enabled/disabled flag properly
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

When reading the PPAG table from ACPI, we should store everything in
our fwrt structure, so it can be accessed later.  But we had a local
ppag_table variable in the function and were erroneously storing the
enabled/disabled flag in it instead of storing it in the fwrt.  Fix
this by removing the local variable and storing everything directly in
fwrt.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Fixes: f2134f66f40e ("iwlwifi: acpi: support ppag table command v2")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 3bfb80dd17cf..57471ab2f5ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -895,7 +895,6 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
 {
 	union acpi_object *wifi_pkg, *data, *enabled;
-	union iwl_ppag_table_cmd ppag_table;
 	int i, j, ret, tbl_rev, num_sub_bands;
 	int idx = 2;
 	s8 *gain;
@@ -949,8 +948,8 @@ static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
 		goto out_free;
 	}
 
-	ppag_table.v1.enabled = cpu_to_le32(enabled->integer.value);
-	if (!ppag_table.v1.enabled) {
+	mvm->fwrt.ppag_table.v1.enabled = cpu_to_le32(enabled->integer.value);
+	if (!mvm->fwrt.ppag_table.v1.enabled) {
 		ret = 0;
 		goto out_free;
 	}
@@ -978,7 +977,7 @@ static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
 			    (j != 0 &&
 			     (gain[i * num_sub_bands + j] > ACPI_PPAG_MAX_HB ||
 			      gain[i * num_sub_bands + j] < ACPI_PPAG_MIN_HB))) {
-				ppag_table.v1.enabled = cpu_to_le32(0);
+				mvm->fwrt.ppag_table.v1.enabled = cpu_to_le32(0);
 				ret = -EINVAL;
 				goto out_free;
 			}
-- 
2.30.0

