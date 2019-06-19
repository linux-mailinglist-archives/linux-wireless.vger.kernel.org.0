Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81D644BFFB
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2019 19:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbfFSRmN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jun 2019 13:42:13 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54540 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730272AbfFSRmM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jun 2019 13:42:12 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hdeb4-0002zq-AF; Wed, 19 Jun 2019 20:42:10 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 6/6] iwlwifi: mvm: clear rfkill_safe_init_done when we start the firmware
Date:   Wed, 19 Jun 2019 20:41:59 +0300
Message-Id: <20190619174159.13927-7-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619174159.13927-1-luca@coelho.fi>
References: <20190619174159.13927-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Otherwise it'll stay set forever which is clearly buggy.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 153717587aeb..559f6df1a74d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -419,6 +419,8 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm, bool read_nvm)
 
 	lockdep_assert_held(&mvm->mutex);
 
+	mvm->rfkill_safe_init_done = false;
+
 	iwl_init_notification_wait(&mvm->notif_wait,
 				   &init_wait,
 				   init_complete,
@@ -537,8 +539,7 @@ int iwl_run_init_mvm_ucode(struct iwl_mvm *mvm, bool read_nvm)
 
 	lockdep_assert_held(&mvm->mutex);
 
-	if (WARN_ON_ONCE(mvm->rfkill_safe_init_done))
-		return 0;
+	mvm->rfkill_safe_init_done = false;
 
 	iwl_init_notification_wait(&mvm->notif_wait,
 				   &calib_wait,
@@ -1108,10 +1109,13 @@ static int iwl_mvm_load_rt_fw(struct iwl_mvm *mvm)
 
 	iwl_fw_dbg_apply_point(&mvm->fwrt, IWL_FW_INI_APPLY_EARLY);
 
+	mvm->rfkill_safe_init_done = false;
 	ret = iwl_mvm_load_ucode_wait_alive(mvm, IWL_UCODE_REGULAR);
 	if (ret)
 		return ret;
 
+	mvm->rfkill_safe_init_done = true;
+
 	iwl_fw_dbg_apply_point(&mvm->fwrt, IWL_FW_INI_APPLY_AFTER_ALIVE);
 
 	return iwl_init_paging(&mvm->fwrt, mvm->fwrt.cur_fw_img);
-- 
2.20.1

