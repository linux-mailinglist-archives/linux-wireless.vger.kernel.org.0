Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EE434A58E
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Mar 2021 11:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhCZKan (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Mar 2021 06:30:43 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43316 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230105AbhCZKam (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Mar 2021 06:30:42 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lPjjj-0003EY-3B; Fri, 26 Mar 2021 12:30:40 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 26 Mar 2021 12:30:32 +0200
Message-Id: <20210326103035.206088-5-luca@coelho.fi>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326103035.206088-1-luca@coelho.fi>
References: <20210326103035.206088-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH for v5.12 4/7] iwlwifi: fw: fix notification wait locking
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Since we now call iwl_notification_wait_notify() from the
NAPI poll in soft-IRQ, we get a (valid) lockdep complaint
that we could get a deadlock by taking the spinlock from
sleeping context and then getting the soft-IRQ that also
tries to take it (in NAPI polling).

Fix this by disabling soft-IRQs for this lock.

Change-Id: Ic56f351d04674df70567bab0269cba91bdbc853c
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Fixes: 25edc8f259c7 ("iwlwifi: pcie: properly implement NAPI")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/notif-wait.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/notif-wait.c b/drivers/net/wireless/intel/iwlwifi/fw/notif-wait.c
index 3dbc6f3f92cc..231d2517f398 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/notif-wait.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/notif-wait.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014 Intel Corporation
+ * Copyright (C) 2005-2014, 2021 Intel Corporation
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
 #include <linux/sched.h>
@@ -26,7 +26,7 @@ bool iwl_notification_wait(struct iwl_notif_wait_data *notif_wait,
 	if (!list_empty(&notif_wait->notif_waits)) {
 		struct iwl_notification_wait *w;
 
-		spin_lock(&notif_wait->notif_wait_lock);
+		spin_lock_bh(&notif_wait->notif_wait_lock);
 		list_for_each_entry(w, &notif_wait->notif_waits, list) {
 			int i;
 			bool found = false;
@@ -59,7 +59,7 @@ bool iwl_notification_wait(struct iwl_notif_wait_data *notif_wait,
 				triggered = true;
 			}
 		}
-		spin_unlock(&notif_wait->notif_wait_lock);
+		spin_unlock_bh(&notif_wait->notif_wait_lock);
 	}
 
 	return triggered;
@@ -70,10 +70,10 @@ void iwl_abort_notification_waits(struct iwl_notif_wait_data *notif_wait)
 {
 	struct iwl_notification_wait *wait_entry;
 
-	spin_lock(&notif_wait->notif_wait_lock);
+	spin_lock_bh(&notif_wait->notif_wait_lock);
 	list_for_each_entry(wait_entry, &notif_wait->notif_waits, list)
 		wait_entry->aborted = true;
-	spin_unlock(&notif_wait->notif_wait_lock);
+	spin_unlock_bh(&notif_wait->notif_wait_lock);
 
 	wake_up_all(&notif_wait->notif_waitq);
 }
-- 
2.31.0

