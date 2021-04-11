Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE80335B2E1
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 11:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbhDKJrb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 05:47:31 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44456 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235267AbhDKJr0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 05:47:26 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lVWfs-000Jkq-Re; Sun, 11 Apr 2021 12:46:38 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 11 Apr 2021 12:46:25 +0300
Message-Id: <iwlwifi.20210411124417.4d27bd36e10e.I1fd8e8fe442c41a5deaa560452b598ed7a60ada5@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210411094630.431873-1-luca@coelho.fi>
References: <20210411094630.431873-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 07/12] iwlwifi: mvm: don't lock mutex in RCU critical section
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We cannot lock a mutex while we're in an RCU critical section. At
the same time, we're accessing data structures that are protected
by the mvm->mutex anyway, so just move the entire locking here to
use only that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 130760572262..c3be03027aed 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1210,10 +1210,10 @@ static int _iwl_dbgfs_inject_beacon_ie(struct iwl_mvm *mvm, char *bin, int len)
 			IWL_UCODE_TLV_API_NEW_BEACON_TEMPLATE))
 		return -EINVAL;
 
-	rcu_read_lock();
+	mutex_lock(&mvm->mutex);
 
 	for (i = 0; i < NUM_MAC_INDEX_DRIVER; i++) {
-		vif = iwl_mvm_rcu_dereference_vif_id(mvm, i, true);
+		vif = iwl_mvm_rcu_dereference_vif_id(mvm, i, false);
 		if (!vif)
 			continue;
 
@@ -1253,18 +1253,16 @@ static int _iwl_dbgfs_inject_beacon_ie(struct iwl_mvm *mvm, char *bin, int len)
 				 &beacon_cmd.tim_size,
 				 beacon->data, beacon->len);
 
-	mutex_lock(&mvm->mutex);
 	iwl_mvm_mac_ctxt_send_beacon_cmd(mvm, beacon, &beacon_cmd,
 					 sizeof(beacon_cmd));
 	mutex_unlock(&mvm->mutex);
 
 	dev_kfree_skb(beacon);
 
-	rcu_read_unlock();
 	return 0;
 
 out_err:
-	rcu_read_unlock();
+	mutex_unlock(&mvm->mutex);
 	return -EINVAL;
 }
 
-- 
2.31.0

