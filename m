Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C92D2C4A48
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 11:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbfJBJMf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 05:12:35 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:60246 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJBJMf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 05:12:35 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iFagR-0002MA-Ac; Wed, 02 Oct 2019 11:12:31 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3] mac80211: simplify TX aggregation start
Date:   Wed,  2 Oct 2019 11:12:25 +0200
Message-Id: <1570007543-I152912660131cbab2e5d80b4218238c20f8a06e5@changeid>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There really is no need to make drivers call the
ieee80211_start_tx_ba_cb_irqsafe() function and then
schedule the worker if all we want is to set a bit.

Add a new return value (that was previously considered
invalid) to indicate that the driver is immediately
ready for the session, and make drivers use it. The
only drivers that remain different are the Intel ones
as they need to negotiate more with the firmware.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: fix compilation
v3: fix rt2800lib to not return 1 for -ENOSPC
---
 drivers/net/wireless/ath/ath9k/htc_drv_main.c         |  2 +-
 drivers/net/wireless/ath/ath9k/main.c                 |  2 +-
 drivers/net/wireless/ath/carl9170/main.c              |  3 +--
 drivers/net/wireless/ath/wcn36xx/main.c               |  5 +++--
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c         |  3 +--
 drivers/net/wireless/intel/iwlegacy/4965-mac.c        |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c           |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c          |  5 ++---
 drivers/net/wireless/mac80211_hwsim.c                 |  3 +--
 drivers/net/wireless/marvell/mwl8k.c                  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c      |  3 +--
 drivers/net/wireless/mediatek/mt76/mt7615/main.c      |  3 +--
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c     |  3 +--
 drivers/net/wireless/mediatek/mt7601u/main.c          |  3 +--
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c        |  4 ++--
 drivers/net/wireless/realtek/rtlwifi/base.c           |  3 +--
 drivers/net/wireless/realtek/rtw88/mac80211.c         |  3 +--
 drivers/net/wireless/rsi/rsi_91x_mac80211.c           |  3 +--
 include/net/mac80211.h                                | 11 +++++++++--
 net/mac80211/agg-tx.c                                 |  9 ++++++++-
 20 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_main.c b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
index a82ad739ab80..791f6633667c 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_main.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
@@ -1674,7 +1674,7 @@ static int ath9k_htc_ampdu_action(struct ieee80211_hw *hw,
 	case IEEE80211_AMPDU_TX_START:
 		ret = ath9k_htc_tx_aggr_oper(priv, vif, sta, action, tid);
 		if (!ret)
-			ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
+			ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
 		break;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index 34121fbf32e3..0548aa3702e3 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -1921,7 +1921,7 @@ static int ath9k_ampdu_action(struct ieee80211_hw *hw,
 		ath9k_ps_wakeup(sc);
 		ret = ath_tx_aggr_start(sc, sta, tid, ssn);
 		if (!ret)
-			ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
+			ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
 		ath9k_ps_restore(sc);
 		break;
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index 40a8054f8aa6..5914926a5c5b 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -1449,8 +1449,7 @@ static int carl9170_op_ampdu_action(struct ieee80211_hw *hw,
 		rcu_assign_pointer(sta_info->agg[tid], tid_info);
 		spin_unlock_bh(&ar->tx_ampdu_list_lock);
 
-		ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
-		break;
+		return IEEE80211_AMPDU_TX_START_IMMEDIATE;
 
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 79998a3ddb7a..a276dae30887 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1084,6 +1084,7 @@ static int wcn36xx_ampdu_action(struct ieee80211_hw *hw,
 	enum ieee80211_ampdu_mlme_action action = params->action;
 	u16 tid = params->tid;
 	u16 *ssn = &params->ssn;
+	int ret = 0;
 
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac ampdu action action %d tid %d\n",
 		    action, tid);
@@ -1106,7 +1107,7 @@ static int wcn36xx_ampdu_action(struct ieee80211_hw *hw,
 		sta_priv->ampdu_state[tid] = WCN36XX_AMPDU_START;
 		spin_unlock_bh(&sta_priv->ampdu_lock);
 
-		ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
+		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
 		break;
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
 		spin_lock_bh(&sta_priv->ampdu_lock);
@@ -1131,7 +1132,7 @@ static int wcn36xx_ampdu_action(struct ieee80211_hw *hw,
 
 	mutex_unlock(&wcn->conf_mutex);
 
-	return 0;
+	return ret;
 }
 
 static const struct ieee80211_ops wcn36xx_ops = {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
index 6188275b17e5..8e8b685cfe09 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
@@ -850,8 +850,7 @@ brcms_ops_ampdu_action(struct ieee80211_hw *hw,
 				     "START: tid %d is not agg\'able\n", tid);
 			return -EINVAL;
 		}
-		ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
-		break;
+		return IEEE80211_AMPDU_TX_START_IMMEDIATE;
 
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index ffb705b18fb1..51fdd7ce30af 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -2265,7 +2265,7 @@ il4965_tx_agg_start(struct il_priv *il, struct ieee80211_vif *vif,
 	if (tid_data->tfds_in_queue == 0) {
 		D_HT("HW queue is empty\n");
 		tid_data->agg.state = IL_AGG_ON;
-		ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
+		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
 	} else {
 		D_HT("HW queue is NOT empty: %d packets in HW queue\n",
 		     tid_data->tfds_in_queue);
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
index 3029e3f6de63..cd73fc5cfcbb 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
@@ -621,7 +621,7 @@ int iwlagn_tx_agg_start(struct iwl_priv *priv, struct ieee80211_vif *vif,
 		IWL_DEBUG_TX_QUEUES(priv, "Can proceed: ssn = next_recl = %d\n",
 				    tid_data->agg.ssn);
 		tid_data->agg.state = IWL_AGG_STARTING;
-		ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
+		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
 	} else {
 		IWL_DEBUG_TX_QUEUES(priv, "Can't proceed: ssn %d, "
 				    "next_reclaimed = %d\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 0bedba4c61f2..1d6bc62b104c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2818,13 +2818,12 @@ int iwl_mvm_sta_tx_agg_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	if (normalized_ssn == tid_data->next_reclaimed) {
 		tid_data->state = IWL_AGG_STARTING;
-		ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
+		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
 	} else {
 		tid_data->state = IWL_EMPTYING_HW_QUEUE_ADDBA;
+		ret = 0;
 	}
 
-	ret = 0;
-
 out:
 	spin_unlock_bh(&mvmsta->lock);
 
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 635956024e88..1aeb38296ec3 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1979,8 +1979,7 @@ static int mac80211_hwsim_ampdu_action(struct ieee80211_hw *hw,
 
 	switch (action) {
 	case IEEE80211_AMPDU_TX_START:
-		ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
-		break;
+		return IEEE80211_AMPDU_TX_START_IMMEDIATE;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index c4db6417748f..d55f229abeea 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -5520,7 +5520,7 @@ mwl8k_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			rc = -EBUSY;
 			break;
 		}
-		ieee80211_start_tx_ba_cb_irqsafe(vif, addr, tid);
+		rc = IEEE80211_AMPDU_TX_START_IMMEDIATE;
 		break;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 25d5b1608bc9..4b3217b43a04 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -582,8 +582,7 @@ mt7603_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		break;
 	case IEEE80211_AMPDU_TX_START:
 		mtxq->agg_ssn = IEEE80211_SN_TO_SEQ(ssn);
-		ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
-		break;
+		return IEEE80211_AMPDU_TX_START_IMMEDIATE;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
 		mt7603_mac_tx_ba_reset(dev, msta->wcid.idx, tid, -1);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 87c748715b5d..b6d78212306a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -477,8 +477,7 @@ mt7615_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		break;
 	case IEEE80211_AMPDU_TX_START:
 		mtxq->agg_ssn = IEEE80211_SN_TO_SEQ(ssn);
-		ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
-		break;
+		return IEEE80211_AMPDU_TX_START_IMMEDIATE;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
 		mt7615_mcu_set_tx_ba(dev, params, 0);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index aec73a0295e8..414b22399d93 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -393,8 +393,7 @@ int mt76x02_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		break;
 	case IEEE80211_AMPDU_TX_START:
 		mtxq->agg_ssn = IEEE80211_SN_TO_SEQ(ssn);
-		ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
-		break;
+		return IEEE80211_AMPDU_TX_START_IMMEDIATE;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
diff --git a/drivers/net/wireless/mediatek/mt7601u/main.c b/drivers/net/wireless/mediatek/mt7601u/main.c
index 72e608cc53af..671d8897ae76 100644
--- a/drivers/net/wireless/mediatek/mt7601u/main.c
+++ b/drivers/net/wireless/mediatek/mt7601u/main.c
@@ -372,8 +372,7 @@ mt76_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		break;
 	case IEEE80211_AMPDU_TX_START:
 		msta->agg_ssn[tid] = ssn << 4;
-		ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
-		break;
+		return IEEE80211_AMPDU_TX_START_IMMEDIATE;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index f1cdcd61c54a..25466454b73e 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -10476,7 +10476,7 @@ int rt2800_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	 * when the hw reorders frames due to aggregation.
 	 */
 	if (sta_priv->wcid > WCID_END)
-		return 1;
+		return -ENOSPC;
 
 	switch (action) {
 	case IEEE80211_AMPDU_RX_START:
@@ -10489,7 +10489,7 @@ int rt2800_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		 */
 		break;
 	case IEEE80211_AMPDU_TX_START:
-		ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
+		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
 		break;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index ac746c322554..c75192c4447f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -1776,8 +1776,7 @@ int rtl_tx_agg_start(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	tid_data->agg.agg_state = RTL_AGG_START;
 
-	ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
-	return 0;
+	return IEEE80211_AMPDU_TX_START_IMMEDIATE;
 }
 
 int rtl_tx_agg_stop(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index e5e3605bb693..a203b4705b94 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -437,8 +437,7 @@ static int rtw_ops_ampdu_action(struct ieee80211_hw *hw,
 
 	switch (params->action) {
 	case IEEE80211_AMPDU_TX_START:
-		ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
-		break;
+		return IEEE80211_AMPDU_TX_START_IMMEDIATE;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index ce5e92d82efc..440088293aff 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -1140,8 +1140,7 @@ static int rsi_mac80211_ampdu_action(struct ieee80211_hw *hw,
 		else if ((vif->type == NL80211_IFTYPE_AP) ||
 			 (vif->type == NL80211_IFTYPE_P2P_GO))
 			rsta->seq_start[tid] = seq_no;
-		ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
-		status = 0;
+		status = IEEE80211_AMPDU_TX_START_IMMEDIATE;
 		break;
 
 	case IEEE80211_AMPDU_TX_STOP_CONT:
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 523c6a09e1c8..d69081c38788 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3095,7 +3095,9 @@ enum ieee80211_filter_flags {
  *
  * @IEEE80211_AMPDU_RX_START: start RX aggregation
  * @IEEE80211_AMPDU_RX_STOP: stop RX aggregation
- * @IEEE80211_AMPDU_TX_START: start TX aggregation
+ * @IEEE80211_AMPDU_TX_START: start TX aggregation, the driver must either
+ *	call ieee80211_start_tx_ba_cb_irqsafe() or return the special
+ *	status %IEEE80211_AMPDU_TX_START_IMMEDIATE.
  * @IEEE80211_AMPDU_TX_OPERATIONAL: TX aggregation has become operational
  * @IEEE80211_AMPDU_TX_STOP_CONT: stop TX aggregation but continue transmitting
  *	queued packets, now unaggregated. After all packets are transmitted the
@@ -3119,6 +3121,8 @@ enum ieee80211_ampdu_mlme_action {
 	IEEE80211_AMPDU_TX_OPERATIONAL,
 };
 
+#define IEEE80211_AMPDU_TX_START_IMMEDIATE 1
+
 /**
  * struct ieee80211_ampdu_params - AMPDU action parameters
  *
@@ -3896,7 +3900,10 @@ struct ieee80211_ops {
 	 *
 	 * Even ``189`` would be wrong since 1 could be lost again.
 	 *
-	 * Returns a negative error code on failure.
+	 * Returns a negative error code on failure. The driver may return
+	 * %IEEE80211_AMPDU_TX_START_IMMEDIATE for %IEEE80211_AMPDU_TX_START
+	 * if the session can start immediately.
+	 *
 	 * The callback can sleep.
 	 */
 	int (*ampdu_action)(struct ieee80211_hw *hw,
diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index b11883d26875..33da6f738c99 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -485,7 +485,14 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 
 	params.ssn = sta->tid_seq[tid] >> 4;
 	ret = drv_ampdu_action(local, sdata, &params);
-	if (ret) {
+	if (ret == IEEE80211_AMPDU_TX_START_IMMEDIATE) {
+		/*
+		 * We didn't send the request yet, so don't need to check
+		 * here if we already got a response, just mark as driver
+		 * ready immediately.
+		 */
+		set_bit(HT_AGG_STATE_DRV_READY, &tid_tx->state);
+	} else if (ret) {
 		ht_dbg(sdata,
 		       "BA request denied - HW unavailable for %pM tid %d\n",
 		       sta->sta.addr, tid);
-- 
2.20.1

