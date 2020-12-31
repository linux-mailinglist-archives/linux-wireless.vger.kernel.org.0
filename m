Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782B32E7D4D
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Dec 2020 01:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgLaAGO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Dec 2020 19:06:14 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:47720 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgLaAGN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Dec 2020 19:06:13 -0500
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id A66C213C2B7;
        Wed, 30 Dec 2020 16:05:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A66C213C2B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1609373132;
        bh=EgOrrtC4YhHgXlJn+I5ahTyMkr0l9CGLrIB7SLNkqzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/VC07KHWmqJff6i9NnuWYiQm4BYXHbd72hi2fGwHAdHs4YeyXxoup0iARgLa8moD
         YAqluy0Jn+Qdszn/iXEUuLRWpT+drE89AsVnLSGSj+X2nGAIcvt60Jzb6mYBzvrkVY
         bgpjCJmR+hUtxna0foYSQXLvlrfeH4rK93pjc80Y=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     luca@coelho.fi, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 5/6] iwlwifi: Make warnings unique to aid debugging.
Date:   Wed, 30 Dec 2020 16:05:22 -0800
Message-Id: <20201231000523.14963-5-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201231000523.14963-1-greearb@candelatech.com>
References: <20201231000523.14963-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

So we can be certain what code is generating kernel error
messages.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c       | 4 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 1386d8397204..44947c6436d5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -491,7 +491,7 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm, bool read_nvm)
 	/* Will also start the device */
 	ret = iwl_mvm_load_ucode_wait_alive(mvm, IWL_UCODE_REGULAR);
 	if (ret) {
-		IWL_ERR(mvm, "Failed to start RT ucode: %d\n", ret);
+		IWL_ERR(mvm, "run-mvm-ucode: Failed to start RT ucode: %d\n", ret);
 		goto error;
 	}
 	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_POINT_AFTER_ALIVE,
@@ -1455,7 +1455,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 
 	ret = iwl_mvm_load_rt_fw(mvm);
 	if (ret) {
-		IWL_ERR(mvm, "Failed to start RT ucode: %d\n", ret);
+		IWL_ERR(mvm, "mvm-up: Failed to start RT ucode: %d\n", ret);
 		if (ret != -ERFKILL)
 			iwl_fw_dbg_error_collect(&mvm->fwrt,
 						 FW_DBG_TRIGGER_DRIVER);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index baa83a0b8593..f31bdcfdc93e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -355,7 +355,7 @@ static int iwl_pcie_gen2_send_hcmd_sync(struct iwl_trans *trans,
 	}
 
 	if (test_bit(STATUS_FW_ERROR, &trans->status)) {
-		IWL_ERR(trans, "FW error in SYNC CMD %s\n", cmd_str);
+		IWL_ERR(trans, "gen2: FW error in SYNC CMD %s\n", cmd_str);
 		dump_stack();
 		ret = -EIO;
 		goto cancel;
-- 
2.20.1

