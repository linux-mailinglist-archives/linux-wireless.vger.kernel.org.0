Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9E4094AD6
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 18:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfHSQuR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 12:50:17 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:36988 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727540AbfHSQuR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 12:50:17 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hzkrG-0007zi-U0; Mon, 19 Aug 2019 19:50:15 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 19 Aug 2019 19:49:48 +0300
Message-Id: <20190819165007.10181-4-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190819165007.10181-1-luca@coelho.fi>
References: <20190819165007.10181-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v3 03/22] iwlwifi: mvm: remove redundant condition in iwl_mvm_set_hw_rfkill_state
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

If mvm->fwrt.cur_fw_img != IWL_UCODE_INIT, then
rfkill_safe_init_done must be true since
rfkill_safe_init_done is set to true before we start to load
the runtime image.
Remove the redundant condition.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 4888054dc3d8..722e427d534c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1234,8 +1234,7 @@ static bool iwl_mvm_set_hw_rfkill_state(struct iwl_op_mode *op_mode, bool state)
 	 * Stop the device if we run OPERATIONAL firmware or if we are in the
 	 * middle of the calibrations.
 	 */
-	return state && (mvm->fwrt.cur_fw_img != IWL_UCODE_INIT ||
-			 rfkill_safe_init_done);
+	return state && rfkill_safe_init_done;
 }
 
 static void iwl_mvm_free_skb(struct iwl_op_mode *op_mode, struct sk_buff *skb)
-- 
2.23.0.rc1

