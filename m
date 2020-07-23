Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D412722AC16
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jul 2020 12:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgGWKDZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jul 2020 06:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgGWKDZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jul 2020 06:03:25 -0400
Received: from rhcavuit04.kulnet.kuleuven.be (rhcavuit04.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E704C0619DC
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 03:03:24 -0700 (PDT)
X-KULeuven-Envelope-From: mathy.vanhoef@kuleuven.be
X-Spam-Status: not spam, SpamAssassin (cached, score=-50.999, required 5,
        autolearn=disabled, ALL_TRUSTED -1.00, LOCAL_SMTPS -50.00,
        URIBL_BLOCKED 0.00)
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 78937120334.A0C2C
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-smtps-2.cc.kuleuven.be (icts-p-smtps-2e.kulnet.kuleuven.be [134.58.240.34])
        by rhcavuit04.kulnet.kuleuven.be (Postfix) with ESMTP id 78937120334
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 12:03:19 +0200 (CEST)
Received: from mathy-work.localhost (unknown [176.205.50.14])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by icts-p-smtps-2.cc.kuleuven.be (Postfix) with ESMTPSA id 6D1D2200A1;
        Thu, 23 Jul 2020 12:03:18 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc:     Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 5/6] mac80211: remove unused flags argument in transmit functions
Date:   Thu, 23 Jul 2020 14:01:52 +0400
Message-Id: <20200723100153.31631-5-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723100153.31631-1-Mathy.Vanhoef@kuleuven.be>
References: <20200723085126.29127-1-Mathy.Vanhoef@kuleuven.be>
 <20200723100153.31631-1-Mathy.Vanhoef@kuleuven.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The flags argument in transmit functions is no longer being used
and can be removed.

Signed-off-by: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
---
 net/mac80211/cfg.c         |  2 +-
 net/mac80211/ieee80211_i.h | 11 +++++------
 net/mac80211/offchannel.c  |  2 +-
 net/mac80211/rx.c          |  2 +-
 net/mac80211/scan.c        |  2 +-
 net/mac80211/sta_info.c    |  2 +-
 net/mac80211/tx.c          | 19 ++++++++-----------
 7 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 9b360544a..06f57b8b8 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3583,7 +3583,7 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	local_bh_disable();
-	ieee80211_xmit(sdata, sta, skb, 0);
+	ieee80211_xmit(sdata, sta, skb);
 	local_bh_enable();
 
 	ret = 0;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8f1a325e0..0e7ef5d5b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1966,12 +1966,11 @@ void ieee80211_regulatory_limit_wmm_params(struct ieee80211_sub_if_data *sdata,
 void ieee80211_set_wmm_default(struct ieee80211_sub_if_data *sdata,
 			       bool bss_notify, bool enable_qos);
 void ieee80211_xmit(struct ieee80211_sub_if_data *sdata,
-		    struct sta_info *sta, struct sk_buff *skb,
-		    u32 txdata_flags);
+		    struct sta_info *sta, struct sk_buff *skb);
 
 void __ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
 				 struct sk_buff *skb, int tid,
-				 enum nl80211_band band, u32 txdata_flags);
+				 enum nl80211_band band);
 
 /* sta_out needs to be checked for ERR_PTR() before using */
 int ieee80211_lookup_ra_sta(struct ieee80211_sub_if_data *sdata,
@@ -1981,10 +1980,10 @@ int ieee80211_lookup_ra_sta(struct ieee80211_sub_if_data *sdata,
 static inline void
 ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
 			  struct sk_buff *skb, int tid,
-			  enum nl80211_band band, u32 txdata_flags)
+			  enum nl80211_band band)
 {
 	rcu_read_lock();
-	__ieee80211_tx_skb_tid_band(sdata, skb, tid, band, txdata_flags);
+	__ieee80211_tx_skb_tid_band(sdata, skb, tid, band);
 	rcu_read_unlock();
 }
 
@@ -2002,7 +2001,7 @@ static inline void ieee80211_tx_skb_tid(struct ieee80211_sub_if_data *sdata,
 	}
 
 	__ieee80211_tx_skb_tid_band(sdata, skb, tid,
-				    chanctx_conf->def.chan->band, 0);
+				    chanctx_conf->def.chan->band);
 	rcu_read_unlock();
 }
 
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index db3b8bf75..882319bdb 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -264,7 +264,7 @@ static void ieee80211_handle_roc_started(struct ieee80211_roc_work *roc,
 	if (roc->mgmt_tx_cookie) {
 		if (!WARN_ON(!roc->frame)) {
 			ieee80211_tx_skb_tid_band(roc->sdata, roc->frame, 7,
-						  roc->chan->band, 0);
+						  roc->chan->band);
 			roc->frame = NULL;
 		}
 	} else {
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 5c5af4b5f..2c88a69b7 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3591,7 +3591,7 @@ ieee80211_rx_h_action_return(struct ieee80211_rx_data *rx)
 		}
 
 		__ieee80211_tx_skb_tid_band(rx->sdata, nskb, 7,
-					    status->band, 0);
+					    status->band);
 	}
 	dev_kfree_skb(rx->skb);
 	return RX_QUEUED;
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 8ccdafa62..8c6b4ff7b 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -607,7 +607,7 @@ static void ieee80211_send_scan_probe_req(struct ieee80211_sub_if_data *sdata,
 				cpu_to_le16(IEEE80211_SN_TO_SEQ(sn));
 		}
 		IEEE80211_SKB_CB(skb)->flags |= tx_flags;
-		ieee80211_tx_skb_tid_band(sdata, skb, 7, channel->band, 0);
+		ieee80211_tx_skb_tid_band(sdata, skb, 7, channel->band);
 	}
 }
 
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index cd8487bc6..6a368f41b 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1455,7 +1455,7 @@ static void ieee80211_send_null_response(struct sta_info *sta, int tid,
 	}
 
 	info->band = chanctx_conf->def.chan->band;
-	ieee80211_xmit(sdata, sta, skb, 0);
+	ieee80211_xmit(sdata, sta, skb);
 	rcu_read_unlock();
 }
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 279d1edbb..e2cb933cd 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1891,7 +1891,7 @@ EXPORT_SYMBOL(ieee80211_tx_prepare_skb);
  */
 static bool ieee80211_tx(struct ieee80211_sub_if_data *sdata,
 			 struct sta_info *sta, struct sk_buff *skb,
-			 bool txpending, u32 txdata_flags)
+			 bool txpending)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_tx_data tx;
@@ -1909,8 +1909,6 @@ static bool ieee80211_tx(struct ieee80211_sub_if_data *sdata,
 	led_len = skb->len;
 	res_prepare = ieee80211_tx_prepare(sdata, &tx, sta, skb);
 
-	tx.flags |= txdata_flags;
-
 	if (unlikely(res_prepare == TX_DROP)) {
 		ieee80211_free_txskb(&local->hw, skb);
 		return true;
@@ -1978,8 +1976,7 @@ static int ieee80211_skb_resize(struct ieee80211_sub_if_data *sdata,
 }
 
 void ieee80211_xmit(struct ieee80211_sub_if_data *sdata,
-		    struct sta_info *sta, struct sk_buff *skb,
-		    u32 txdata_flags)
+		    struct sta_info *sta, struct sk_buff *skb)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
@@ -2014,7 +2011,7 @@ void ieee80211_xmit(struct ieee80211_sub_if_data *sdata,
 	}
 
 	ieee80211_set_qos_hdr(sdata, skb);
-	ieee80211_tx(sdata, sta, skb, false, txdata_flags);
+	ieee80211_tx(sdata, sta, skb, false);
 }
 
 static bool ieee80211_parse_tx_radiotap(struct ieee80211_local *local,
@@ -2349,7 +2346,7 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 	if (!ieee80211_parse_tx_radiotap(local, skb))
 		goto fail_rcu;
 
-	ieee80211_xmit(sdata, NULL, skb, 0);
+	ieee80211_xmit(sdata, NULL, skb);
 	rcu_read_unlock();
 
 	return NETDEV_TX_OK;
@@ -4011,7 +4008,7 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 
 		ieee80211_tx_stats(dev, skb->len);
 
-		ieee80211_xmit(sdata, sta, skb, 0);
+		ieee80211_xmit(sdata, sta, skb);
 	}
 	goto out;
  out_free:
@@ -4377,7 +4374,7 @@ static bool ieee80211_tx_pending_skb(struct ieee80211_local *local,
 			return true;
 		}
 		info->band = chanctx_conf->def.chan->band;
-		result = ieee80211_tx(sdata, NULL, skb, true, 0);
+		result = ieee80211_tx(sdata, NULL, skb, true);
 	} else if (info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP) {
 		if (ieee80211_lookup_ra_sta(sdata, skb, &sta)) {
 			dev_kfree_skb(skb);
@@ -5336,7 +5333,7 @@ EXPORT_SYMBOL(ieee80211_unreserve_tid);
 
 void __ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
 				 struct sk_buff *skb, int tid,
-				 enum nl80211_band band, u32 txdata_flags)
+				 enum nl80211_band band)
 {
 	int ac = ieee80211_ac_from_tid(tid);
 
@@ -5353,7 +5350,7 @@ void __ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
 	 */
 	local_bh_disable();
 	IEEE80211_SKB_CB(skb)->band = band;
-	ieee80211_xmit(sdata, NULL, skb, txdata_flags);
+	ieee80211_xmit(sdata, NULL, skb);
 	local_bh_enable();
 }
 
-- 
2.27.0

