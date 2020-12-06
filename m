Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EB02D0190
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 09:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgLFIW4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 03:22:56 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34638 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725779AbgLFIWt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 03:22:49 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=localhost.localdomain)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1klpIx-003A2r-3i; Sun, 06 Dec 2020 10:22:03 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun,  6 Dec 2020 10:21:49 +0200
Message-Id: <iwlwifi.20201206100942.5961c7d79648.Ic35b2f28ff08f7ac23143c80f224d52eb97a0454@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206082159.440198-1-luca@coelho.fi>
References: <20201206082159.440198-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 02/12] iwlwifi: avoid endless HW errors at assert time
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Curretly we only mark HW error state "after" trying to collect HW data,
but if any HW error happens while colleting HW data we go into endless
loop. avoid this by setting HW error state "before" collecting HW data.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index da55133f1a2d..70b3b9797c2d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1298,6 +1298,12 @@ void iwl_mvm_nic_restart(struct iwl_mvm *mvm, bool fw_error)
 	} else if (mvm->fwrt.cur_fw_img == IWL_UCODE_REGULAR &&
 		   mvm->hw_registered &&
 		   !test_bit(STATUS_TRANS_DEAD, &mvm->trans->status)) {
+		/* This should be first thing before trying to collect any
+		 * data to avoid endless loops if any HW error happens while
+		 * collecting debug data.
+		 */
+		set_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED, &mvm->status);
+
 		if (mvm->fw->ucode_capa.error_log_size) {
 			u32 src_size = mvm->fw->ucode_capa.error_log_size;
 			u32 src_addr = mvm->fw->ucode_capa.error_log_addr;
@@ -1316,7 +1322,6 @@ void iwl_mvm_nic_restart(struct iwl_mvm *mvm, bool fw_error)
 
 		if (fw_error && mvm->fw_restart > 0)
 			mvm->fw_restart--;
-		set_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED, &mvm->status);
 		ieee80211_restart_hw(mvm->hw);
 	}
 }
-- 
2.29.2

