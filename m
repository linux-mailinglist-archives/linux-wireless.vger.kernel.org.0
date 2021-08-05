Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A124C3E129C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 12:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240315AbhHEK0P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 06:26:15 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51262 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239963AbhHEK0P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 06:26:15 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mBaTa-00240Q-ER; Thu, 05 Aug 2021 13:19:47 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu,  5 Aug 2021 13:19:34 +0300
Message-Id: <iwlwifi.20210805130823.00b5084be918.I18efb3c45bffacfa9a356c2c8d34e5ffbb3eb423@changeid>
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
Subject: [PATCH 12/12] iwlwifi: remove ACPI_SAR_NUM_TABLES definition
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

This definition was only used to pass the size of the tables in the FW
API to the iwl_sar_select_profile() function, but we should actually
pass the definition from the FW API file.  We don't have the concept
of tables in the ACPI definition, so we can remove it.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h | 1 -
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index cd26a155baf7..245f0646c8f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -34,7 +34,6 @@
 
 #define ACPI_SAR_NUM_CHAINS		2
 #define ACPI_SAR_NUM_SUB_BANDS		5
-#define ACPI_SAR_NUM_TABLES		1
 
 #define ACPI_WRDS_WIFI_DATA_SIZE	(ACPI_SAR_NUM_CHAINS * \
 					 ACPI_SAR_NUM_SUB_BANDS + 2)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 38fd5886af2d..0b769aac0b02 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -743,7 +743,8 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 	/* all structs have the same common part, add it */
 	len += sizeof(cmd.common);
 
-	ret = iwl_sar_select_profile(&mvm->fwrt, per_chain, ACPI_SAR_NUM_TABLES,
+	ret = iwl_sar_select_profile(&mvm->fwrt, per_chain,
+				     IWL_NUM_CHAIN_TABLES,
 				     n_subbands, prof_a, prof_b);
 
 	/* return on error or if the profile is disabled (positive number) */
-- 
2.32.0

