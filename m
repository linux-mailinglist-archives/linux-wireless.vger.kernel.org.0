Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C777430132
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Oct 2021 10:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243824AbhJPIqM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Oct 2021 04:46:12 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52850 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S243800AbhJPIqL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Oct 2021 04:46:11 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mbfIQ-000Xqv-Ix; Sat, 16 Oct 2021 11:44:03 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 16 Oct 2021 11:43:55 +0300
Message-Id: <iwlwifi.20211016114029.7ceb9eaca9f6.If0cbef38c6d07ec1ddce125878a4bdadcb35d2c9@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211016084359.246930-1-luca@coelho.fi>
References: <20211016084359.246930-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH for v5.15 1/5] iwlwifi: mvm: reset PM state on unsuccessful resume
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If resume fails for some reason, we need to set the PM state
back to normal so we're able to send commands during firmware
reset, rather than failing all of them because we're in D3.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Fixes: 708a39aaca22 ("iwlwifi: mvm: don't send commands during suspend\resume transition")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 9f706fffb592..d3013a51a509 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2336,7 +2336,6 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 		iwl_fw_dbg_collect_desc(&mvm->fwrt, &iwl_dump_desc_assert,
 					false, 0);
 		ret = 1;
-		mvm->trans->system_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
 		goto err;
 	}
 
@@ -2385,6 +2384,7 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 		}
 	}
 
+	/* after the successful handshake, we're out of D3 */
 	mvm->trans->system_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
 
 	/*
@@ -2455,6 +2455,9 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 	 */
 	set_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED, &mvm->status);
 
+	/* regardless of what happened, we're now out of D3 */
+	mvm->trans->system_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
+
 	return 1;
 }
 
-- 
2.33.0

