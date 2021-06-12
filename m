Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44E33A4E5A
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jun 2021 13:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhFLLeu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Jun 2021 07:34:50 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:47546 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229942AbhFLLet (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Jun 2021 07:34:49 -0400
Received: from [192.130.48.226] (helo=kveik.superpark.guest)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1ls1sc-001V8i-Ot; Sat, 12 Jun 2021 14:32:48 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 12 Jun 2021 14:32:35 +0300
Message-Id: <iwlwifi.20210612142637.093f6660e69b.Ifd2328ac2130269f729c9c1bceec44ba01d79e88@changeid>
X-Mailer: git-send-email 2.32.0.rc2
In-Reply-To: <20210612113245.691117-1-luca@coelho.fi>
References: <20210612113245.691117-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 02/12] iwlwifi: mvm: pass the clock type to iwl_mvm_get_sync_time()
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Allow the caller to pass the clock type to iwl_mvm_get_sync_time() so
callers with different needs can decide whether to use boottime or
realtime.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  4 ++--
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c    |  5 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h          |  5 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c        | 11 ++++++++---
 4 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index 38d0bfb649cc..7d9faeffd154 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -460,7 +460,7 @@ static ssize_t iwl_dbgfs_os_device_timediff_read(struct file *file,
 	int pos = 0;
 
 	mutex_lock(&mvm->mutex);
-	iwl_mvm_get_sync_time(mvm, &curr_gp2, &curr_os);
+	iwl_mvm_get_sync_time(mvm, CLOCK_BOOTTIME, &curr_gp2, &curr_os, NULL);
 	mutex_unlock(&mvm->mutex);
 
 	do_div(curr_os, NSEC_PER_USEC);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index a456b8a0ae58..a24e6c0490e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  */
 #include <linux/etherdevice.h>
 #include <linux/math64.h>
@@ -879,7 +879,8 @@ static u64 iwl_mvm_ftm_get_host_time(struct iwl_mvm *mvm, __le32 fw_gp2_ts)
 	u32 curr_gp2, diff;
 	u64 now_from_boot_ns;
 
-	iwl_mvm_get_sync_time(mvm, &curr_gp2, &now_from_boot_ns);
+	iwl_mvm_get_sync_time(mvm, CLOCK_BOOTTIME, &curr_gp2,
+			      &now_from_boot_ns, NULL);
 
 	if (curr_gp2 >= gp2_ts)
 		diff = curr_gp2 - gp2_ts;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 3df150d9b5f2..3d738243fcee 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -16,6 +16,8 @@
 #include <linux/thermal.h>
 #endif
 
+#include <linux/ktime.h>
+
 #include "iwl-op-mode.h"
 #include "iwl-trans.h"
 #include "fw/notif-wait.h"
@@ -1470,7 +1472,8 @@ u8 iwl_mvm_mac80211_ac_to_ucode_ac(enum ieee80211_ac_numbers ac);
 void iwl_mvm_dump_nic_error_log(struct iwl_mvm *mvm);
 u8 first_antenna(u8 mask);
 u8 iwl_mvm_next_antenna(struct iwl_mvm *mvm, u8 valid, u8 last_idx);
-void iwl_mvm_get_sync_time(struct iwl_mvm *mvm, u32 *gp2, u64 *boottime);
+void iwl_mvm_get_sync_time(struct iwl_mvm *mvm, int clock_type, u32 *gp2,
+			   u64 *boottime, ktime_t *realtime);
 u32 iwl_mvm_get_systime(struct iwl_mvm *mvm);
 
 /* Tx / Host Commands */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index c566be99a4c7..99105272139d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -1398,7 +1398,8 @@ u32 iwl_mvm_get_systime(struct iwl_mvm *mvm)
 	return iwl_read_prph(mvm->trans, reg_addr);
 }
 
-void iwl_mvm_get_sync_time(struct iwl_mvm *mvm, u32 *gp2, u64 *boottime)
+void iwl_mvm_get_sync_time(struct iwl_mvm *mvm, int clock_type,
+			   u32 *gp2, u64 *boottime, ktime_t *realtime)
 {
 	bool ps_disabled;
 
@@ -1412,7 +1413,11 @@ void iwl_mvm_get_sync_time(struct iwl_mvm *mvm, u32 *gp2, u64 *boottime)
 	}
 
 	*gp2 = iwl_mvm_get_systime(mvm);
-	*boottime = ktime_get_boottime_ns();
+
+	if (clock_type == CLOCK_BOOTTIME && boottime)
+		*boottime = ktime_get_boottime_ns();
+	else if (clock_type == CLOCK_REALTIME && realtime)
+		*realtime = ktime_get_real();
 
 	if (!ps_disabled) {
 		mvm->ps_disabled = ps_disabled;
-- 
2.32.0.rc2

