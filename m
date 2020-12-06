Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC022D032E
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 12:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgLFLIU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 06:08:20 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34780 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726840AbgLFLIT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 06:08:19 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1klrt6-003AAN-7m; Sun, 06 Dec 2020 13:07:32 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun,  6 Dec 2020 13:07:20 +0200
Message-Id: <iwlwifi.20201206130357.49566b6a57d9.I7c69ff999419368266279ec27dd618eb450908b3@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206110729.488452-1-luca@coelho.fi>
References: <20201206110729.488452-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 03/12] iwlwifi: mvm: do more useful queue sync accounting
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We're currently doing accounting on the queue sync with an
atomic variable that counts down the number of remaining
notifications that we still need.

As we've been hitting issues in this area, modify this to
track a bitmap of queues, not just the number of queues,
and print out the remaining bitmap in the warning.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 11 ++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c     | 10 +++++++---
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 766aeeaf1fcf..be3d4515b772 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5097,8 +5097,7 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 
 	if (notif->sync) {
 		notif->cookie = mvm->queue_sync_cookie;
-		atomic_set(&mvm->queue_sync_counter,
-			   mvm->trans->num_rx_queues);
+		mvm->queue_sync_state = (1 << mvm->trans->num_rx_queues) - 1;
 	}
 
 	ret = iwl_mvm_notify_rx_queue(mvm, qmask, notif, size, !notif->sync);
@@ -5110,14 +5109,16 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 	if (notif->sync) {
 		lockdep_assert_held(&mvm->mutex);
 		ret = wait_event_timeout(mvm->rx_sync_waitq,
-					 atomic_read(&mvm->queue_sync_counter) == 0 ||
+					 READ_ONCE(mvm->queue_sync_state) == 0 ||
 					 iwl_mvm_is_radio_killed(mvm),
 					 HZ);
-		WARN_ON_ONCE(!ret && !iwl_mvm_is_radio_killed(mvm));
+		WARN_ONCE(!ret && !iwl_mvm_is_radio_killed(mvm),
+			  "queue sync: failed to sync, state is 0x%lx\n",
+			  mvm->queue_sync_state);
 	}
 
 out:
-	atomic_set(&mvm->queue_sync_counter, 0);
+	mvm->queue_sync_state = 0;
 	if (notif->sync)
 		mvm->queue_sync_cookie++;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index de43ffff0a5d..afa04952107e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -842,7 +842,7 @@ struct iwl_mvm {
 	unsigned long status;
 
 	u32 queue_sync_cookie;
-	atomic_t queue_sync_counter;
+	unsigned long queue_sync_state;
 	/*
 	 * for beacon filtering -
 	 * currently only one interface can be supported
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index e54c48af1913..2a497fb77e3a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -703,7 +703,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	init_waitqueue_head(&mvm->rx_sync_waitq);
 
-	atomic_set(&mvm->queue_sync_counter, 0);
+	mvm->queue_sync_state = 0;
 
 	SET_IEEE80211_DEV(mvm->hw, mvm->trans->dev);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index ef5bd58ef742..d4465164457d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -827,9 +827,13 @@ void iwl_mvm_rx_queue_notif(struct iwl_mvm *mvm, struct napi_struct *napi,
 		WARN_ONCE(1, "Invalid identifier %d", internal_notif->type);
 	}
 
-	if (internal_notif->sync &&
-	    !atomic_dec_return(&mvm->queue_sync_counter))
-		wake_up(&mvm->rx_sync_waitq);
+	if (internal_notif->sync) {
+		WARN_ONCE(!test_and_clear_bit(queue, &mvm->queue_sync_state),
+			  "queue sync: queue %d responded a second time!\n",
+			  queue);
+		if (READ_ONCE(mvm->queue_sync_state) == 0)
+			wake_up(&mvm->rx_sync_waitq);
+	}
 }
 
 static void iwl_mvm_oldsn_workaround(struct iwl_mvm *mvm,
-- 
2.29.2

