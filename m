Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8A41CB168
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2020 16:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgEHOIY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 10:08:24 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:60308 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727907AbgEHOIY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 10:08:24 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jX3fp-000WXw-Hc; Fri, 08 May 2020 17:08:22 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  8 May 2020 17:08:00 +0300
Message-Id: <iwlwifi.20200508170402.aabc3f85c78e.Id7516fbb3482131d0c9dfb51ff20b226617ddb49@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508140802.558267-1-luca@coelho.fi>
References: <20200508140802.558267-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 09/11] iwlwifi: mvm: fix aux station leak
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sharon <sara.sharon@intel.com>

When mvm is initialized we alloc aux station with aux queue.
We later free the station memory when driver is stopped, but we
never free the queue's memory, which casues a leak.

Add a proper de-initialization of the station.

Signed-off-by: Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c  |  5 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c   | 18 +++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h   |  6 +++---
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 10df77ab1a77..77916231ff7d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1208,14 +1208,13 @@ void __iwl_mvm_mac_stop(struct iwl_mvm *mvm)
 	 */
 	flush_work(&mvm->roc_done_wk);
 
+	iwl_mvm_rm_aux_sta(mvm);
+
 	iwl_mvm_stop_device(mvm);
 
 	iwl_mvm_async_handlers_purge(mvm);
 	/* async_handlers_list is empty and will stay empty: HW is stopped */
 
-	/* the fw is stopped, the aux sta is dead: clean up driver state */
-	iwl_mvm_del_aux_sta(mvm);
-
 	/*
 	 * Clear IN_HW_RESTART and HW_RESTART_REQUESTED flag when stopping the
 	 * hw (as restart_complete() won't be called in this case) and mac80211
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 44d4720b7629..fee01cbbd3ac 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2093,16 +2093,24 @@ int iwl_mvm_rm_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	return ret;
 }
 
-void iwl_mvm_dealloc_snif_sta(struct iwl_mvm *mvm)
+int iwl_mvm_rm_aux_sta(struct iwl_mvm *mvm)
 {
-	iwl_mvm_dealloc_int_sta(mvm, &mvm->snif_sta);
-}
+	int ret;
 
-void iwl_mvm_del_aux_sta(struct iwl_mvm *mvm)
-{
 	lockdep_assert_held(&mvm->mutex);
 
+	iwl_mvm_disable_txq(mvm, NULL, mvm->aux_queue, IWL_MAX_TID_COUNT, 0);
+	ret = iwl_mvm_rm_sta_common(mvm, mvm->aux_sta.sta_id);
+	if (ret)
+		IWL_WARN(mvm, "Failed sending remove station\n");
 	iwl_mvm_dealloc_int_sta(mvm, &mvm->aux_sta);
+
+	return ret;
+}
+
+void iwl_mvm_dealloc_snif_sta(struct iwl_mvm *mvm)
+{
+	iwl_mvm_dealloc_int_sta(mvm, &mvm->snif_sta);
 }
 
 /*
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 8d70093847cb..da2d1ac01229 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -8,7 +8,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2016 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -31,7 +31,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2016 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -541,7 +541,7 @@ int iwl_mvm_sta_tx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		       int tid, u8 queue, bool start);
 
 int iwl_mvm_add_aux_sta(struct iwl_mvm *mvm);
-void iwl_mvm_del_aux_sta(struct iwl_mvm *mvm);
+int iwl_mvm_rm_aux_sta(struct iwl_mvm *mvm);
 
 int iwl_mvm_alloc_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_send_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
-- 
2.26.2

