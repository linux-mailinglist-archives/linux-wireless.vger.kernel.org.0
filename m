Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F02309C6F
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Jan 2021 15:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhAaNrh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 31 Jan 2021 08:47:37 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:42906 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231556AbhAaLlX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 31 Jan 2021 06:41:23 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l6AY1-004131-NV; Sun, 31 Jan 2021 13:05:42 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 31 Jan 2021 13:05:28 +0200
Message-Id: <iwlwifi.20210131125921.bb6d28ceca01.I770fdf3b9b9fa555fe0935926e32cc3509d980de@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210131110533.887130-1-luca@coelho.fi>
References: <20210131110533.887130-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 07/12] iwlwifi: mvm: move early time-point before nvm_init in non-unified
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We were starting the early time-point too late in non-unified
firmwares.  Unlike with unified firmwares, we were starting it only
after reading the NVM, so errors in the NVM read phase were not
logged.

Solve this by moving the time-point to the same place as we do with
unified firmwares, i.e. just before we go into the wait-alive code.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 0637eb1cff4e..be1cc8653147 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -633,6 +633,8 @@ int iwl_run_init_mvm_ucode(struct iwl_mvm *mvm)
 				   iwl_wait_phy_db_entry,
 				   mvm->phy_db);
 
+	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_POINT_EARLY, NULL);
+
 	/* Will also start the device */
 	ret = iwl_mvm_load_ucode_wait_alive(mvm, IWL_UCODE_INIT);
 	if (ret) {
@@ -1312,8 +1314,6 @@ static int iwl_mvm_load_rt_fw(struct iwl_mvm *mvm)
 	if (ret)
 		return ret;
 
-	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_POINT_EARLY, NULL);
-
 	mvm->rfkill_safe_init_done = false;
 	ret = iwl_mvm_load_ucode_wait_alive(mvm, IWL_UCODE_REGULAR);
 	if (ret)
-- 
2.29.2

