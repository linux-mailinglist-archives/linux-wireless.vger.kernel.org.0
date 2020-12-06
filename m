Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C772D018F
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 09:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgLFIW4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 03:22:56 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34644 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725772AbgLFIWv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 03:22:51 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=localhost.localdomain)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1klpIx-003A2r-QJ; Sun, 06 Dec 2020 10:22:04 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun,  6 Dec 2020 10:21:50 +0200
Message-Id: <iwlwifi.20201206100942.acf9ee6de665.I2da0ada577fc16268125a4a15b5e725c18c643ee@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206082159.440198-1-luca@coelho.fi>
References: <20201206082159.440198-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 03/12] iwlwifi: mvm: remove the read_nvm from iwl_run_unified_mvm_ucode
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Similarly to what I did to iwl_run_init_mvm_ucode, there is no
need to pass the read_nvm parameter. Either we have an NVM
and we don't need to read it, or we don't and we need to read it.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index a31a77f828fa..c29e55720179 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -460,7 +460,7 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 	return 0;
 }
 
-static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm, bool read_nvm)
+static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm)
 {
 	struct iwl_notification_wait init_wait;
 	struct iwl_nvm_access_complete_cmd nvm_complete = {};
@@ -517,7 +517,7 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm, bool read_nvm)
 		iwl_mvm_load_nvm_to_nic(mvm);
 	}
 
-	if (IWL_MVM_PARSE_NVM && read_nvm) {
+	if (IWL_MVM_PARSE_NVM && !mvm->nvm_data) {
 		ret = iwl_nvm_init(mvm);
 		if (ret) {
 			IWL_ERR(mvm, "Failed to read NVM: %d\n", ret);
@@ -542,7 +542,7 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm, bool read_nvm)
 		return ret;
 
 	/* Read the NVM only at driver load time, no need to do this twice */
-	if (!IWL_MVM_PARSE_NVM && read_nvm) {
+	if (!IWL_MVM_PARSE_NVM && !mvm->nvm_data) {
 		mvm->nvm_data = iwl_get_nvm(mvm->trans, mvm->fw);
 		if (IS_ERR(mvm->nvm_data)) {
 			ret = PTR_ERR(mvm->nvm_data);
@@ -657,7 +657,7 @@ int iwl_run_init_mvm_ucode(struct iwl_mvm *mvm)
 	int ret;
 
 	if (iwl_mvm_has_unified_ucode(mvm))
-		return iwl_run_unified_mvm_ucode(mvm, true);
+		return iwl_run_unified_mvm_ucode(mvm);
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -1330,7 +1330,7 @@ static int iwl_mvm_load_rt_fw(struct iwl_mvm *mvm)
 	int ret;
 
 	if (iwl_mvm_has_unified_ucode(mvm))
-		return iwl_run_unified_mvm_ucode(mvm, false);
+		return iwl_run_unified_mvm_ucode(mvm);
 
 	WARN_ON(!mvm->nvm_data);
 	ret = iwl_run_init_mvm_ucode(mvm);
-- 
2.29.2

