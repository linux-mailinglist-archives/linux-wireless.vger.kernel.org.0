Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87F62470F3
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Aug 2020 20:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390544AbgHQSSl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Aug 2020 14:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388364AbgHQQF3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Aug 2020 12:05:29 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2B7C061345
        for <linux-wireless@vger.kernel.org>; Mon, 17 Aug 2020 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3bKhuwMXKBfq/Ho3kUouM3H0+iWcaoy2ObtimfrkTEM=; b=NkDESr4cBr3GvRqxAVlcQ/61ZD
        ASilMiv+/93/8NoVyyaHbiocIR0ikfs5X2CZiCGGPOTrE8SqE6C4x3h/vmEQy3cmEGBKZHidRzNor
        /mQ+9pfE+KKXoiFVjT5szFEMTnmY4Mva9zx16rg/1B6bY1g7f2K1GZx5+J/CU1JUnzZg=;
Received: from p54ae996c.dip0.t-ipconnect.de ([84.174.153.108] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k7hdP-0004Gg-Ia; Mon, 17 Aug 2020 18:05:19 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 4/7] mac80211: optimize station connection monitor
Date:   Mon, 17 Aug 2020 18:05:14 +0200
Message-Id: <20200817160517.94564-4-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817160517.94564-1-nbd@nbd.name>
References: <20200817160517.94564-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Calling mod_timer for every rx/tx packet can be quite expensive.
Instead of constantly updating the timer, we can simply let it run out
and check the timestamp of the last ACK or rx packet to re-arm it.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/ieee80211_i.h |  2 --
 net/mac80211/mlme.c        | 53 ++++++++++++++++----------------------
 net/mac80211/rx.c          |  9 -------
 net/mac80211/sta_info.h    |  2 --
 net/mac80211/status.c      |  3 ---
 5 files changed, 22 insertions(+), 47 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index b6fb85ff3ce4..54f2bf67d2cc 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2039,8 +2039,6 @@ void ieee80211_dynamic_ps_timer(struct timer_list *t);
 void ieee80211_send_nullfunc(struct ieee80211_local *local,
 			     struct ieee80211_sub_if_data *sdata,
 			     bool powersave);
-void ieee80211_sta_rx_notify(struct ieee80211_sub_if_data *sdata,
-			     struct ieee80211_hdr *hdr);
 void ieee80211_sta_tx_notify(struct ieee80211_sub_if_data *sdata,
 			     struct ieee80211_hdr *hdr, bool ack, u16 tx_time);
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ac870309b911..f241decf843d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2432,23 +2432,6 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	sdata->encrypt_headroom = IEEE80211_ENCRYPT_HEADROOM;
 }
 
-void ieee80211_sta_rx_notify(struct ieee80211_sub_if_data *sdata,
-			     struct ieee80211_hdr *hdr)
-{
-	/*
-	 * We can postpone the mgd.timer whenever receiving unicast frames
-	 * from AP because we know that the connection is working both ways
-	 * at that time. But multicast frames (and hence also beacons) must
-	 * be ignored here, because we need to trigger the timer during
-	 * data idle periods for sending the periodic probe request to the
-	 * AP we're connected to.
-	 */
-	if (is_multicast_ether_addr(hdr->addr1))
-		return;
-
-	ieee80211_sta_reset_conn_monitor(sdata);
-}
-
 static void ieee80211_reset_ap_probe(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
@@ -2521,21 +2504,13 @@ void ieee80211_sta_tx_notify(struct ieee80211_sub_if_data *sdata,
 {
 	ieee80211_sta_tx_wmm_ac_notify(sdata, hdr, tx_time);
 
-	if (!ieee80211_is_data(hdr->frame_control))
-	    return;
-
-	if (ieee80211_is_any_nullfunc(hdr->frame_control) &&
-	    sdata->u.mgd.probe_send_count > 0) {
-		if (ack)
-			ieee80211_sta_reset_conn_monitor(sdata);
-		else
-			sdata->u.mgd.nullfunc_failed = true;
-		ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+	if (!ieee80211_is_any_nullfunc(hdr->frame_control) ||
+	    !sdata->u.mgd.probe_send_count)
 		return;
-	}
 
-	if (ack)
-		ieee80211_sta_reset_conn_monitor(sdata);
+	if (!ack)
+		sdata->u.mgd.nullfunc_failed = true;
+	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
 }
 
 static void ieee80211_mlme_send_probe_req(struct ieee80211_sub_if_data *sdata,
@@ -3605,8 +3580,8 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	 * Start timer to probe the connection to the AP now.
 	 * Also start the timer that will detect beacon loss.
 	 */
-	ieee80211_sta_rx_notify(sdata, (struct ieee80211_hdr *)mgmt);
 	ieee80211_sta_reset_beacon_monitor(sdata);
+	ieee80211_sta_reset_conn_monitor(sdata);
 
 	ret = true;
  out:
@@ -4577,10 +4552,26 @@ static void ieee80211_sta_conn_mon_timer(struct timer_list *t)
 		from_timer(sdata, t, u.mgd.conn_mon_timer);
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_local *local = sdata->local;
+	struct sta_info *sta;
+	unsigned long timeout;
 
 	if (sdata->vif.csa_active && !ifmgd->csa_waiting_bcn)
 		return;
 
+	sta = sta_info_get(sdata, ifmgd->bssid);
+	if (!sta)
+		return;
+
+	timeout = sta->status_stats.last_ack;
+	if (time_before(sta->status_stats.last_ack, sta->rx_stats.last_rx))
+		timeout = sta->rx_stats.last_rx;
+	timeout += IEEE80211_CONNECTION_IDLE_TIME;
+
+	if (time_is_before_jiffies(timeout)) {
+		mod_timer(&ifmgd->conn_mon_timer, round_jiffies_up(timeout));
+		return;
+	}
+
 	ieee80211_queue_work(&local->hw, &ifmgd->monitor_work);
 }
 
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 836cde516a18..bd8c15a65a16 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1811,9 +1811,6 @@ ieee80211_rx_h_sta_process(struct ieee80211_rx_data *rx)
 			sta->rx_stats.last_rate = sta_stats_encode_rate(status);
 	}
 
-	if (rx->sdata->vif.type == NL80211_IFTYPE_STATION)
-		ieee80211_sta_rx_notify(rx->sdata, hdr);
-
 	sta->rx_stats.fragments++;
 
 	u64_stats_update_begin(&rx->sta->rx_stats.syncp);
@@ -4148,7 +4145,6 @@ void ieee80211_check_fast_rx(struct sta_info *sta)
 			fastrx.sa_offs = offsetof(struct ieee80211_hdr, addr2);
 			fastrx.expected_ds_bits = 0;
 		} else {
-			fastrx.sta_notify = sdata->u.mgd.probe_send_count > 0;
 			fastrx.da_offs = offsetof(struct ieee80211_hdr, addr1);
 			fastrx.sa_offs = offsetof(struct ieee80211_hdr, addr3);
 			fastrx.expected_ds_bits =
@@ -4378,11 +4374,6 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 	    pskb_trim(skb, skb->len - fast_rx->icv_len))
 		goto drop;
 
-	if (unlikely(fast_rx->sta_notify)) {
-		ieee80211_sta_rx_notify(rx->sdata, hdr);
-		fast_rx->sta_notify = false;
-	}
-
 	/* statistics part of ieee80211_rx_h_sta_process() */
 	if (!(status->flag & RX_FLAG_NO_SIGNAL_VAL)) {
 		stats->last_signal = status->signal;
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 459310d2b921..51b284852dfd 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -336,7 +336,6 @@ struct ieee80211_fast_tx {
  * @expected_ds_bits: from/to DS bits expected
  * @icv_len: length of the MIC if present
  * @key: bool indicating encryption is expected (key is set)
- * @sta_notify: notify the MLME code (once)
  * @internal_forward: forward froms internally on AP/VLAN type interfaces
  * @uses_rss: copy of USES_RSS hw flag
  * @da_offs: offset of the DA in the header (for header conversion)
@@ -352,7 +351,6 @@ struct ieee80211_fast_rx {
 	__le16 expected_ds_bits;
 	u8 icv_len;
 	u8 key:1,
-	   sta_notify:1,
 	   internal_forward:1,
 	   uses_rss:1;
 	u8 da_offs, sa_offs;
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 67df7a5acee5..28ab29a5694d 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -1214,9 +1214,6 @@ void ieee80211_tx_status_8023(struct ieee80211_hw *hw,
 	sta->status_stats.retry_count += retry_count;
 
 	if (ieee80211_hw_check(hw, REPORTS_TX_ACK_STATUS)) {
-		if (acked && vif->type == NL80211_IFTYPE_STATION)
-			ieee80211_sta_reset_conn_monitor(sdata);
-
 		sta->status_stats.last_ack = jiffies;
 		if (info->flags & IEEE80211_TX_STAT_ACK) {
 			if (sta->status_stats.lost_packets)
-- 
2.28.0

