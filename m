Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B1D587745
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Aug 2022 08:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiHBGuv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Aug 2022 02:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbiHBGuq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Aug 2022 02:50:46 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F056379
        for <linux-wireless@vger.kernel.org>; Mon,  1 Aug 2022 23:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659423044; x=1690959044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=x1fdpQjtFhXWwz171+OjfmIrA+9rlXIAE97c3bs9u+c=;
  b=lUZulEpQAe71G46Ul6EBeCYEO22ZVPusV9zeqQjmUpWG7j3KiOFbn+lA
   TeXLWaB1G0aoj9JmEFiTEmXsWWAloxN5uIRuQ5vminmzwA6gff6+U2KF7
   IrEYPrDiwdSM8rbzp6DdMwpd7rZfniv+bTrBW9oUjav/TYUtgARWqqhuo
   M=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Aug 2022 23:50:44 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 23:50:44 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 1 Aug 2022 23:50:44 -0700
Received: from CDCCSTEX0180100-LIN.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 1 Aug 2022 23:50:42 -0700
From:   Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [RFC 2/2] wifi: mac80211: use link_id from ieee80211_rx_status to retrieve rx link
Date:   Tue, 2 Aug 2022 12:20:19 +0530
Message-ID: <20220802065019.20791-3-quic_vthiagar@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220802065019.20791-1-quic_vthiagar@quicinc.com>
References: <20220802065019.20791-1-quic_vthiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fill rx.link with respective data_link from the reported link_id
in rx_status. Any link_id > 15 is invalid. Non-MLO connections
can use either 0 or 15 as the link_id. Please note that link_id
0 is used with non-MLO connections to avoid changes in the
drivers not supporting MLO. For a 802.11 MLD address translated
frame, driver must report the right link_id for the
frame to get processed. When processing 802.3 frame format,
link_id is not that critical, used only with stats update.
In such case, all the stats will be updated for the deflink.

Signed-off-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
---
 net/mac80211/rx.c | 133 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 124 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 57df21e2170a..87aa81bc6595 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4508,6 +4508,16 @@ void ieee80211_check_fast_rx_iface(struct ieee80211_sub_if_data *sdata)
 	mutex_unlock(&local->sta_mtx);
 }
 
+static bool
+ieee80211_rx_is_valid_sta_link_id(struct ieee80211_sta *sta, u8 link_id)
+{
+	if (!sta->mlo && (link_id && link_id != IEEE80211_LINK_UNSPECIFIED))
+		return false;
+
+	return !(link_id != IEEE80211_LINK_UNSPECIFIED &&
+		 (sta->mlo && !(sta->valid_links & BIT(link_id))));
+}
+
 static void ieee80211_rx_8023(struct ieee80211_rx_data *rx,
 			      struct ieee80211_fast_rx *fast_rx,
 			      int orig_len)
@@ -4515,19 +4525,30 @@ static void ieee80211_rx_8023(struct ieee80211_rx_data *rx,
 	struct ieee80211_sta_rx_stats *stats;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(rx->skb);
 	struct sta_info *sta = rx->sta;
+	struct link_sta_info *link_sta;
 	struct sk_buff *skb = rx->skb;
 	void *sa = skb->data + ETH_ALEN;
 	void *da = skb->data;
 
-	stats = &sta->deflink.rx_stats;
+	if (rx->link_id >= 0) {
+		link_sta = rcu_dereference(sta->link[rx->link_id]);
+		if (WARN_ON_ONCE(!link_sta)) {
+			dev_kfree_skb(rx->skb);
+			return;
+		}
+	} else {
+		link_sta = &sta->deflink;
+	}
+
+	stats = &link_sta->rx_stats;
 	if (fast_rx->uses_rss)
-		stats = this_cpu_ptr(sta->deflink.pcpu_rx_stats);
+		stats = this_cpu_ptr(link_sta->pcpu_rx_stats);
 
 	/* statistics part of ieee80211_rx_h_sta_process() */
 	if (!(status->flag & RX_FLAG_NO_SIGNAL_VAL)) {
 		stats->last_signal = status->signal;
 		if (!fast_rx->uses_rss)
-			ewma_signal_add(&sta->deflink.rx_stats_avg.signal,
+			ewma_signal_add(&link_sta->rx_stats_avg.signal,
 					-status->signal);
 	}
 
@@ -4543,7 +4564,7 @@ static void ieee80211_rx_8023(struct ieee80211_rx_data *rx,
 
 			stats->chain_signal_last[i] = signal;
 			if (!fast_rx->uses_rss)
-				ewma_signal_add(&sta->deflink.rx_stats_avg.chain_signal[i],
+				ewma_signal_add(&link_sta->rx_stats_avg.chain_signal[i],
 						-signal);
 		}
 	}
@@ -4619,7 +4640,8 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 		u8 da[ETH_ALEN];
 		u8 sa[ETH_ALEN];
 	} addrs __aligned(2);
-	struct ieee80211_sta_rx_stats *stats = &sta->deflink.rx_stats;
+	struct link_sta_info *link_sta;
+	struct ieee80211_sta_rx_stats *stats;
 
 	/* for parallel-rx, we need to have DUP_VALIDATED, otherwise we write
 	 * to a common data structure; drivers can implement that per queue
@@ -4720,8 +4742,19 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 	return true;
  drop:
 	dev_kfree_skb(skb);
+
+	if (rx->link_id >= 0) {
+		link_sta = rcu_dereference(sta->link[rx->link_id]);
+		if (!link_sta)
+			return true;
+	} else {
+		link_sta = &sta->deflink;
+	}
+
 	if (fast_rx->uses_rss)
-		stats = this_cpu_ptr(sta->deflink.pcpu_rx_stats);
+		stats = this_cpu_ptr(link_sta->pcpu_rx_stats);
+	else
+		stats = &link_sta->rx_stats;
 
 	stats->dropped++;
 	return true;
@@ -4763,8 +4796,7 @@ static bool ieee80211_prepare_and_rx_handle(struct ieee80211_rx_data *rx,
 		return false;
 
 	if (rx->link_id >= 0) {
-		link = rcu_dereference(rx->sdata->link[rx->link_id]);
-
+		link =  rcu_dereference(sdata->link[rx->link_id]);
 		/* we might race link removal */
 		if (!link)
 			return true;
@@ -4827,6 +4859,7 @@ static void __ieee80211_rx_handle_8023(struct ieee80211_hw *hw,
 				       struct list_head *list)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
+	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_fast_rx *fast_rx;
 	struct ieee80211_rx_data rx;
 
@@ -4847,7 +4880,30 @@ static void __ieee80211_rx_handle_8023(struct ieee80211_hw *hw,
 
 	rx.sta = container_of(pubsta, struct sta_info, sta);
 	rx.sdata = rx.sta->sdata;
-	rx.link = &rx.sdata->deflink;
+
+	if (!ieee80211_rx_is_valid_sta_link_id(pubsta, status->link_id))
+		goto drop;
+
+	/*
+	 * TODO: In MLO, should the frame be dropped if the right link_id is not
+	 * available? Or may be it is fine in the current form to proceed with
+	 * the frame processing because with frame being in 802.3 format,
+	 * link_id is used only for stats purpose and updating the stats on
+	 * the deflink is fine?
+	 */
+	if (pubsta->mlo && status->link_id != IEEE80211_LINK_UNSPECIFIED)
+		rx.link_id = status->link_id;
+
+	if (rx.link_id >= 0) {
+		struct ieee80211_link_data *link;
+
+		link =  rcu_dereference(rx.sdata->link[rx.link_id]);
+		if (!link)
+			goto drop;
+		rx.link = link;
+	} else {
+		rx.link = &rx.sdata->deflink;
+	}
 
 	fast_rx = rcu_dereference(rx.sta->fast_rx);
 	if (!fast_rx)
@@ -4877,7 +4933,18 @@ static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
 		rx->sta = link_sta->sta;
 		rx->link_id = link_sta->link_id;
 	} else {
+		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
+
 		rx->sta = sta_info_get_bss(rx->sdata, hdr->addr2);
+		if (rx->sta) {
+			if ((status->link_id == IEEE80211_LINK_UNSPECIFIED &&
+			     rx->sta->sta.mlo) ||
+			    !ieee80211_rx_is_valid_sta_link_id(&rx->sta->sta,
+							       status->link_id))
+				return false;
+
+			rx->link_id = rx->sta->sta.mlo ? status->link_id : -1;
+		}
 	}
 
 	return ieee80211_prepare_and_rx_handle(rx, skb, consume);
@@ -4893,6 +4960,7 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 					 struct list_head *list)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
+	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_sub_if_data *sdata;
 	struct ieee80211_hdr *hdr;
 	__le16 fc;
@@ -4941,6 +5009,36 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 		if (pubsta) {
 			rx.sta = container_of(pubsta, struct sta_info, sta);
 			rx.sdata = rx.sta->sdata;
+
+			if (!ieee80211_rx_is_valid_sta_link_id(pubsta,
+							       status->link_id))
+				goto out;
+
+			if (pubsta->mlo &&
+			    status->link_id != IEEE80211_LINK_UNSPECIFIED)
+				rx.link_id = status->link_id;
+
+			/*
+			 * In MLO connection, fetch the link_id using addr2
+			 * when the driver passes unspecified link_id in status.
+			 * When the address translation is already performed by
+			 * driver/hw, the right link_id must be passed in
+			 * status.
+			 */
+
+			if (status->link_id == IEEE80211_LINK_UNSPECIFIED &&
+			    pubsta->mlo) {
+				struct ieee80211_hdr *hdr = (void *)skb->data;
+				struct link_sta_info *link_sta;
+
+				link_sta = link_sta_info_get_bss(rx.sdata,
+								 hdr->addr2);
+				if (!link_sta)
+					goto out;
+
+				rx.link_id = link_sta->link_id;
+			}
+
 			if (ieee80211_prepare_and_rx_handle(&rx, skb, true))
 				return;
 			goto out;
@@ -4954,6 +5052,13 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 				continue;
 			}
 
+			if ((status->link_id == IEEE80211_LINK_UNSPECIFIED &&
+			     sta->sta.mlo) ||
+			    !ieee80211_rx_is_valid_sta_link_id(&sta->sta,
+							       status->link_id))
+				continue;
+
+			rx.link_id = sta->sta.mlo ? status->link_id : -1;
 			rx.sta = prev_sta;
 			rx.sdata = prev_sta->sdata;
 			ieee80211_prepare_and_rx_handle(&rx, skb, false);
@@ -4962,6 +5067,13 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 		}
 
 		if (prev_sta) {
+			if ((status->link_id == IEEE80211_LINK_UNSPECIFIED &&
+			     prev_sta->sta.mlo) ||
+			    !ieee80211_rx_is_valid_sta_link_id(&prev_sta->sta,
+							       status->link_id))
+				goto out;
+
+			rx.link_id = sta->sta.mlo ? status->link_id : -1;
 			rx.sta = prev_sta;
 			rx.sdata = prev_sta->sdata;
 
@@ -5104,6 +5216,9 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 		}
 	}
 
+	if (WARN_ON_ONCE(status->link_id > IEEE80211_LINK_UNSPECIFIED))
+		goto drop;
+
 	status->rx_flags = 0;
 
 	kcov_remote_start_common(skb_get_kcov_handle(skb));
-- 
2.17.1

