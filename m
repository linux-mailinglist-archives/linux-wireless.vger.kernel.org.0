Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D50316A0E
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 16:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhBJPZA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 10:25:00 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45342 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231666AbhBJPYq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 10:24:46 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9rLR-0049nr-OJ; Wed, 10 Feb 2021 17:23:58 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 17:23:49 +0200
Message-Id: <iwlwifi.20210210172142.ad170ad48409.Ifc6b10e8b3f235876af91d0e23e90b462d270eff@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210152355.419776-1-luca@coelho.fi>
References: <20210210152355.419776-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 2/8] iwlwifi: mvm: global PM mode does not reset after FW crash
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ravi Darsi <ravi.darsi@intel.com>

When The driver in D3 and FW crash happens, trans->system_pm_mode
is  not reset to IWL_PLAT_PM_MODE_DISABLED which causes the driver
not to send INIT conmmands and D3 resume fails.

This patch contains the fix for resetting trans->system_pm_mode to
IWL_PLAT_PM_MODE_DISABLED and D3 resume is successful.

Signed-off-by: Ravi Darsi <ravi.darsi@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 7c51c781cfaf..a7dc85c704a9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2043,6 +2043,7 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 		iwl_fw_dbg_collect_desc(&mvm->fwrt, &iwl_dump_desc_assert,
 					false, 0);
 		ret = 1;
+		mvm->trans->system_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
 		goto err;
 	}
 
-- 
2.30.0

