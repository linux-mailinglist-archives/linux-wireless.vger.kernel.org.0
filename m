Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6205871E5B
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2019 20:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391406AbfGWSAO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jul 2019 14:00:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:13111 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391444AbfGWSAN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jul 2019 14:00:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2019 11:00:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,299,1559545200"; 
   d="scan'208";a="180817260"
Received: from itatikis-mobl.ger.corp.intel.com (HELO egrumbac-mobl1.ger.corp.intel.com) ([10.254.154.160])
  by orsmga002.jf.intel.com with ESMTP; 23 Jul 2019 11:00:10 -0700
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] mac80211: pass the vif to cancel_remain_on_channel
Date:   Tue, 23 Jul 2019 21:00:01 +0300
Message-Id: <20190723180001.5828-1-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This low level driver can find it useful to get the vif
when a remain on channel session is cancelled.

iwlwifi will need this soon.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/ath/ath10k/mac.c             | 3 ++-
 drivers/net/wireless/ath/ath9k/main.c             | 3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 3 ++-
 drivers/net/wireless/mac80211_hwsim.c             | 3 ++-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c       | 3 ++-
 drivers/net/wireless/ti/wlcore/main.c             | 3 ++-
 include/net/mac80211.h                            | 3 ++-
 net/mac80211/driver-ops.h                         | 8 +++++---
 net/mac80211/offchannel.c                         | 5 +++--
 net/mac80211/trace.h                              | 7 ++++---
 10 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 9c703d287333..8cb5e9bd8d41 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6875,7 +6875,8 @@ static int ath10k_remain_on_channel(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static int ath10k_cancel_remain_on_channel(struct ieee80211_hw *hw)
+static int ath10k_cancel_remain_on_channel(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif)
 {
 	struct ath10k *ar = hw->priv;
 
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index f23cb2f3d296..34121fbf32e3 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -2392,7 +2392,8 @@ static int ath9k_remain_on_channel(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static int ath9k_cancel_remain_on_channel(struct ieee80211_hw *hw)
+static int ath9k_cancel_remain_on_channel(struct ieee80211_hw *hw,
+					  struct ieee80211_vif *vif)
 {
 	struct ath_softc *sc = hw->priv;
 	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index fdbabca0280e..35e312aa3244 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3960,7 +3960,8 @@ static int iwl_mvm_roc(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static int iwl_mvm_cancel_roc(struct ieee80211_hw *hw)
+static int iwl_mvm_cancel_roc(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index d396a33bbc9c..2710bddf3dec 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2216,7 +2216,8 @@ static int mac80211_hwsim_roc(struct ieee80211_hw *hw,
 	return 0;
 }
 
-static int mac80211_hwsim_croc(struct ieee80211_hw *hw)
+static int mac80211_hwsim_croc(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif)
 {
 	struct mac80211_hwsim_data *hwsim = hw->priv;
 
diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index 49df3bb08d41..ce5e92d82efc 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -1818,7 +1818,8 @@ static int rsi_mac80211_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return status;
 }
 
-static int rsi_mac80211_cancel_roc(struct ieee80211_hw *hw)
+static int rsi_mac80211_cancel_roc(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif)
 {
 	struct rsi_hw *adapter = hw->priv;
 	struct rsi_common *common = adapter->priv;
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index c9a485ecee7b..e10fe1d597d3 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -5749,7 +5749,8 @@ static void wlcore_roc_complete_work(struct work_struct *work)
 		ieee80211_remain_on_channel_expired(wl->hw);
 }
 
-static int wlcore_op_cancel_remain_on_channel(struct ieee80211_hw *hw)
+static int wlcore_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
+					      struct ieee80211_vif *vif)
 {
 	struct wl1271 *wl = hw->priv;
 
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d26da013f7c0..e39bf85ae4c2 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3914,7 +3914,8 @@ struct ieee80211_ops {
 				 struct ieee80211_channel *chan,
 				 int duration,
 				 enum ieee80211_roc_type type);
-	int (*cancel_remain_on_channel)(struct ieee80211_hw *hw);
+	int (*cancel_remain_on_channel)(struct ieee80211_hw *hw,
+					struct ieee80211_vif *vif);
 	int (*set_ringparam)(struct ieee80211_hw *hw, u32 tx, u32 rx);
 	void (*get_ringparam)(struct ieee80211_hw *hw,
 			      u32 *tx, u32 *tx_max, u32 *rx, u32 *rx_max);
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index c2d8b5451a5e..2c9b3eb8b652 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -692,14 +692,16 @@ static inline int drv_remain_on_channel(struct ieee80211_local *local,
 	return ret;
 }
 
-static inline int drv_cancel_remain_on_channel(struct ieee80211_local *local)
+static inline int
+drv_cancel_remain_on_channel(struct ieee80211_local *local,
+			     struct ieee80211_sub_if_data *sdata)
 {
 	int ret;
 
 	might_sleep();
 
-	trace_drv_cancel_remain_on_channel(local);
-	ret = local->ops->cancel_remain_on_channel(&local->hw);
+	trace_drv_cancel_remain_on_channel(local, sdata);
+	ret = local->ops->cancel_remain_on_channel(&local->hw, &sdata->vif);
 	trace_drv_return_int(local, ret);
 
 	return ret;
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 60ef8972b254..c710504ccf1a 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -8,6 +8,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2009	Johannes Berg <johannes@sipsolutions.net>
+ * Copyright (C) 2019 Intel Corporation
  */
 #include <linux/export.h>
 #include <net/mac80211.h>
@@ -732,7 +733,7 @@ static int ieee80211_cancel_roc(struct ieee80211_local *local,
 	}
 
 	if (local->ops->remain_on_channel) {
-		ret = drv_cancel_remain_on_channel(local);
+		ret = drv_cancel_remain_on_channel(local, roc->sdata);
 		if (WARN_ON_ONCE(ret)) {
 			mutex_unlock(&local->mtx);
 			return ret;
@@ -991,7 +992,7 @@ void ieee80211_roc_purge(struct ieee80211_local *local,
 		if (roc->started) {
 			if (local->ops->remain_on_channel) {
 				/* can race, so ignore return value */
-				drv_cancel_remain_on_channel(local);
+				drv_cancel_remain_on_channel(local, sdata);
 				ieee80211_roc_notify_destroy(roc);
 			} else {
 				roc->abort = true;
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 3bb4459b52c7..4768322dc202 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -1242,9 +1242,10 @@ TRACE_EVENT(drv_remain_on_channel,
 	)
 );
 
-DEFINE_EVENT(local_only_evt, drv_cancel_remain_on_channel,
-	TP_PROTO(struct ieee80211_local *local),
-	TP_ARGS(local)
+DEFINE_EVENT(local_sdata_evt, drv_cancel_remain_on_channel,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata),
+	TP_ARGS(local, sdata)
 );
 
 TRACE_EVENT(drv_set_ringparam,
-- 
2.17.1

