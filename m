Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06B43E129B
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 12:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240270AbhHEK0M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 06:26:12 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51258 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239963AbhHEK0M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 06:26:12 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mBaTY-00240Q-Pr; Thu, 05 Aug 2021 13:19:46 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu,  5 Aug 2021 13:19:32 +0300
Message-Id: <iwlwifi.20210805130823.65591c9fa2af.Ie7e4ba94c903ef444cb07df61891394c11c7c864@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805101934.431479-1-luca@coelho.fi>
References: <20210805101934.431479-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 10/12] iwlwifi: rename ACPI_SAR_NUM_CHAIN_LIMITS to ACPI_SAR_NUM_CHAINS
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The "LIMITS" in the macro name don't have much meaning, so remove it
to make the macro shorter and better reflect that this is the number
of chains that we have limits for.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 6 +++---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 34933f133a0a..dff792653a24 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -433,10 +433,10 @@ static int iwl_sar_fill_table(struct iwl_fw_runtime *fwrt,
 			      __le16 *per_chain, u32 n_subbands,
 			      int prof_a, int prof_b)
 {
-	int profs[ACPI_SAR_NUM_CHAIN_LIMITS] = { prof_a, prof_b };
+	int profs[ACPI_SAR_NUM_CHAINS] = { prof_a, prof_b };
 	int i, j, idx;
 
-	for (i = 0; i < ACPI_SAR_NUM_CHAIN_LIMITS; i++) {
+	for (i = 0; i < ACPI_SAR_NUM_CHAINS; i++) {
 		struct iwl_sar_profile *prof;
 
 		/* don't allow SAR to be disabled (profile 0 means disable) */
@@ -486,7 +486,7 @@ int iwl_sar_select_profile(struct iwl_fw_runtime *fwrt,
 
 	for (i = 0; i < n_tables; i++) {
 		ret = iwl_sar_fill_table(fwrt,
-			 &per_chain[i * n_subbands * ACPI_SAR_NUM_CHAIN_LIMITS],
+			 &per_chain[i * n_subbands * ACPI_SAR_NUM_CHAINS],
 			 n_subbands, prof_a, prof_b);
 		if (ret)
 			break;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index b858e998999c..24e94430e5d9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -33,7 +33,7 @@
 #define ACPI_NUM_GEO_PROFILES		3
 #define ACPI_GEO_PER_CHAIN_SIZE		3
 
-#define ACPI_SAR_NUM_CHAIN_LIMITS	2
+#define ACPI_SAR_NUM_CHAINS		2
 #define ACPI_SAR_NUM_SUB_BANDS		5
 #define ACPI_SAR_NUM_TABLES		1
 
-- 
2.32.0

