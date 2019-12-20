Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF32A127A59
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 12:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfLTL4x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 06:56:53 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:53996 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727177AbfLTL4w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 06:56:52 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iiGtm-0007ip-8b; Fri, 20 Dec 2019 13:56:50 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 20 Dec 2019 13:56:35 +0200
Message-Id: <20191220115638.1299888-8-luca@coelho.fi>
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
Subject: [PATCH v5.5 07/10] iwlwifi: mvm: fix NVM check for 3168 devices
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We had a check on !NVM_EXT and then a check for NVM_SDP in the else
block of this if.  The else block, obviously, could only be reached if
using NVM_EXT, so it would never be NVM_SDP.

Fix that by checking whether the nvm_type is IWL_NVM instead of
checking for !IWL_NVM_EXT to solve this issue.

Reported-by: Stefan Sperling <stsp@stsp.name>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index 945c1ea5cda8..493bcc54a848 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -281,7 +281,7 @@ iwl_parse_nvm_sections(struct iwl_mvm *mvm)
 	int regulatory_type;
 
 	/* Checking for required sections */
-	if (mvm->trans->cfg->nvm_type != IWL_NVM_EXT) {
+	if (mvm->trans->cfg->nvm_type == IWL_NVM) {
 		if (!mvm->nvm_sections[NVM_SECTION_TYPE_SW].data ||
 		    !mvm->nvm_sections[mvm->cfg->nvm_hw_section_num].data) {
 			IWL_ERR(mvm, "Can't parse empty OTP/NVM sections\n");
-- 
2.24.0

