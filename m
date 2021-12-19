Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A164947A05F
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 12:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbhLSL2s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 06:28:48 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51436 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235623AbhLSL2r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 06:28:47 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1myuMv-001O73-K2; Sun, 19 Dec 2021 13:28:46 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 19 Dec 2021 13:28:30 +0200
Message-Id: <iwlwifi.20211219132536.b1e96021b616.Id0164855f2dd01ecdecf79b239d6ee5974882245@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211219112836.132859-1-luca@coelho.fi>
References: <20211219112836.132859-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 06/12] iwlwifi: return op_mode only in case the failure is from MEI
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Currently we always return the op_mode with valid pointer in case
getting NVM failed, while it's only relevant for cases that CSME is the
owner of the nic.

Fix this by checking also who's the owner of the nic.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 83d5df52f2af..3a308585ed06 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1303,12 +1303,18 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	mvm->mei_registered = !iwl_mei_register(mvm, &mei_ops);
 
-	/*
-	 * Get NVM failed, but we are registered to MEI, we'll get
-	 * the NVM later when it'll be possible to get it from CSME.
-	 */
-	if (iwl_mvm_start_get_nvm(mvm) && mvm->mei_registered)
-		return op_mode;
+	if (iwl_mvm_start_get_nvm(mvm)) {
+		/*
+		 * Getting NVM failed while CSME is the owner, but we are
+		 * registered to MEI, we'll get the NVM later when it'll be
+		 * possible to get it from CSME.
+		 */
+		if (trans->csme_own && mvm->mei_registered)
+			return op_mode;
+
+		goto out_thermal_exit;
+	}
+
 
 	if (iwl_mvm_start_post_nvm(mvm))
 		goto out_thermal_exit;
-- 
2.34.1

