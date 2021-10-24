Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4744389C6
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Oct 2021 17:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhJXPXN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Oct 2021 11:23:13 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58632 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231372AbhJXPXK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Oct 2021 11:23:10 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mefIl-000czj-Jo; Sun, 24 Oct 2021 18:20:48 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 24 Oct 2021 18:20:29 +0300
Message-Id: <iwlwifi.20211024181719.ce6841093681.I09634a0aa845a0256e79c7895154d9ac35bc26be@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211024152037.332948-1-luca@coelho.fi>
References: <20211024152037.332948-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 04/12] iwlwifi: mvm: don't get address of mvm->fwrt just to dereference as a pointer
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The mvm->fwrt element is not a pointer, but an instance of the
structure, so we should access its elements with a dot-notation
instead of getting the address and dereferencing it as a pointer.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 6063b2ffe266..8b96b885658f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1144,7 +1144,7 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 static u8 iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
 {
 	u8 value;
-	int ret = iwl_acpi_get_dsm_u8((&mvm->fwrt)->dev, 0, DSM_RFI_FUNC_ENABLE,
+	int ret = iwl_acpi_get_dsm_u8(mvm->fwrt.dev, 0, DSM_RFI_FUNC_ENABLE,
 				      &iwl_rfi_guid, &value);
 
 	if (ret < 0) {
@@ -1173,18 +1173,18 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 
 	cmd.config_bitmap = iwl_acpi_get_lari_config_bitmap(&mvm->fwrt);
 
-	ret = iwl_acpi_get_dsm_u32((&mvm->fwrt)->dev, 0, DSM_FUNC_11AX_ENABLEMENT,
+	ret = iwl_acpi_get_dsm_u32(mvm->fwrt.dev, 0, DSM_FUNC_11AX_ENABLEMENT,
 				   &iwl_guid, &value);
 	if (!ret)
 		cmd.oem_11ax_allow_bitmap = cpu_to_le32(value);
 
-	ret = iwl_acpi_get_dsm_u32((&mvm->fwrt)->dev, 0,
+	ret = iwl_acpi_get_dsm_u32(mvm->fwrt.dev, 0,
 				   DSM_FUNC_ENABLE_UNII4_CHAN,
 				   &iwl_guid, &value);
 	if (!ret)
 		cmd.oem_unii4_allow_bitmap = cpu_to_le32(value);
 
-	ret = iwl_acpi_get_dsm_u32((&mvm->fwrt)->dev, 0,
+	ret = iwl_acpi_get_dsm_u32(mvm->fwrt.dev, 0,
 				   DSM_FUNC_ACTIVATE_CHANNEL,
 				   &iwl_guid, &value);
 	if (!ret)
-- 
2.33.0

