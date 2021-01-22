Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62864300381
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jan 2021 13:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbhAVMyF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jan 2021 07:54:05 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:41648 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727401AbhAVMxu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jan 2021 07:53:50 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l2vvi-003vnH-TS; Fri, 22 Jan 2021 14:52:47 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 22 Jan 2021 14:52:39 +0200
Message-Id: <iwlwifi.20210122144849.fe927ec939c6.I103d3321fb55da7e6c6c51582cfadf94eb8b6c58@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122125242.107146-1-luca@coelho.fi>
References: <20210122125242.107146-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH for v5.11 4/7] iwlwifi: mvm: clear IN_D3 after wowlan status cmd
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

In D3 resume flow, avoid the following race where sending
packets before updating the sequence number (sequence
number received from the wowlan status command response):
Thread 1:
__iwl_mvm_resume clears IWL_MVM_STATUS_IN_D3 and is cut
by thread 2 before reaching iwl_mvm_query_wakeup_reasons.
Thread 2:
iwl_mvm_mac_itxq_xmit calls iwl_mvm_tx_skb since
IWL_MVM_STATUS_IN_D3 is not set using a wrong sequence number.
Thread 1:
__iwl_mvm_resume continues and calls iwl_mvm_query_wakeup_reasons
updating the sequence number received from the firmware.

The next packet that will be sent now will cause sysassert 0x1096.

Fix the bug by moving 'clear IWL_MVM_STATUS_IN_D3' to after
sending the wowlan status command and updating the sequence
number.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index c025188fa9bc..df018972a46b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -2032,8 +2032,6 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 
 	mutex_lock(&mvm->mutex);
 
-	clear_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
-
 	/* get the BSS vif pointer again */
 	vif = iwl_mvm_get_bss_vif(mvm);
 	if (IS_ERR_OR_NULL(vif))
@@ -2148,6 +2146,8 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 			iwl_mvm_d3_disconnect_iter, keep ? vif : NULL);
 
 out:
+	clear_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
+
 	/* no need to reset the device in unified images, if successful */
 	if (unified_image && !ret) {
 		/* nothing else to do if we already sent D0I3_END_CMD */
-- 
2.29.2

