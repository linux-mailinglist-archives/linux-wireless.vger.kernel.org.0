Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCEA22AC17
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jul 2020 12:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgGWKD0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jul 2020 06:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgGWKD0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jul 2020 06:03:26 -0400
Received: from rhcavuit03.kulnet.kuleuven.be (rhcavuit03.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036E1C0619E2
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 03:03:25 -0700 (PDT)
X-KULeuven-Envelope-From: mathy.vanhoef@kuleuven.be
X-Spam-Status: not spam, SpamAssassin (not cached, score=-50.999, required 5,
        autolearn=disabled, ALL_TRUSTED -1.00, LOCAL_SMTPS -50.00,
        URIBL_BLOCKED 0.00)
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 7BAE9120330.AF669
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-smtps-2.cc.kuleuven.be (icts-p-smtps-2e.kulnet.kuleuven.be [134.58.240.34])
        by rhcavuit03.kulnet.kuleuven.be (Postfix) with ESMTP id 7BAE9120330
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 12:03:23 +0200 (CEST)
Received: from mathy-work.localhost (unknown [176.205.50.14])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by icts-p-smtps-2.cc.kuleuven.be (Postfix) with ESMTPSA id 5351C200A1;
        Thu, 23 Jul 2020 12:03:22 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc:     Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 6/6] mac80211: parse radiotap header when selecting Tx queue
Date:   Thu, 23 Jul 2020 14:01:53 +0400
Message-Id: <20200723100153.31631-6-Mathy.Vanhoef@kuleuven.be>
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

Already parse the radiotap header in ieee80211_monitor_select_queue.
In a subsequent commit this will allow us to add a radiotap flag that
influences the queue on which injected packets will be sent.

This also fixes the incomplete validation of the injected frame in
ieee80211_monitor_select_queue: currently an out of bounds memory
access may occur in in the called function ieee80211_select_queue_80211
if the 802.11 header is too small.

Note that in ieee80211_monitor_start_xmit the radiotap header is parsed
again, which is necessairy because ieee80211_monitor_select_queue is not
always called beforehand.

Signed-off-by: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
---
 include/net/mac80211.h |  8 +++++++
 net/mac80211/iface.c   | 15 ++++++++----
 net/mac80211/tx.c      | 54 +++++++++++++++++++-----------------------
 3 files changed, 43 insertions(+), 34 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 6615fe450..4e23ad385 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6238,6 +6238,14 @@ bool ieee80211_tx_prepare_skb(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif, struct sk_buff *skb,
 			      int band, struct ieee80211_sta **sta);
 
+/**
+ * Sanity-check and parse the radiotap header of injected frames
+ * @skb: packet injected by userspace
+ * @dev: the &struct device of this 802.11 device
+ */
+bool ieee80211_parse_tx_radiotap(struct sk_buff *skb,
+				 struct net_device *dev);
+
 /**
  * struct ieee80211_noa_data - holds temporary data for tracking P2P NoA state
  *
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index f900c84fb..132ff7678 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1183,17 +1183,24 @@ static u16 ieee80211_monitor_select_queue(struct net_device *dev,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hdr *hdr;
-	struct ieee80211_radiotap_header *rtap = (void *)skb->data;
+	int len_rthdr;
 
 	if (local->hw.queues < IEEE80211_NUM_ACS)
 		return 0;
 
-	if (skb->len < 4 ||
-	    skb->len < le16_to_cpu(rtap->it_len) + 2 /* frame control */)
+	/* reset flags and info before parsing radiotap header */
+	memset(info, 0, sizeof(*info));
+
+	if (!ieee80211_parse_tx_radiotap(skb, dev))
 		return 0; /* doesn't matter, frame will be dropped */
 
-	hdr = (void *)((u8 *)skb->data + le16_to_cpu(rtap->it_len));
+	len_rthdr = ieee80211_get_radiotap_len(skb->data);
+	hdr = (struct ieee80211_hdr *)(skb->data + len_rthdr);
+	if (skb->len < len_rthdr + 2 ||
+	    skb->len < len_rthdr + ieee80211_hdrlen(hdr->frame_control))
+		return 0; /* doesn't matter, frame will be dropped */
 
 	return ieee80211_select_queue_80211(sdata, skb, hdr);
 }
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index e2cb933cd..dac73baeb 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2014,9 +2014,10 @@ void ieee80211_xmit(struct ieee80211_sub_if_data *sdata,
 	ieee80211_tx(sdata, sta, skb, false);
 }
 
-static bool ieee80211_parse_tx_radiotap(struct ieee80211_local *local,
-					struct sk_buff *skb)
+bool ieee80211_parse_tx_radiotap(struct sk_buff *skb,
+				 struct net_device *dev)
 {
+	struct ieee80211_local *local = wdev_priv(dev->ieee80211_ptr);
 	struct ieee80211_radiotap_iterator iterator;
 	struct ieee80211_radiotap_header *rthdr =
 		(struct ieee80211_radiotap_header *) skb->data;
@@ -2035,6 +2036,18 @@ static bool ieee80211_parse_tx_radiotap(struct ieee80211_local *local,
 	u8 vht_mcs = 0, vht_nss = 0;
 	int i;
 
+	/* check for not even having the fixed radiotap header part */
+	if (unlikely(skb->len < sizeof(struct ieee80211_radiotap_header)))
+		return false; /* too short to be possibly valid */
+
+	/* is it a header version we can trust to find length from? */
+	if (unlikely(rthdr->it_version))
+		return false; /* only version 0 is supported */
+
+	/* does the skb contain enough to deliver on the alleged length? */
+	if (unlikely(skb->len < ieee80211_get_radiotap_len(skb->data)))
+		return false; /* skb too short for claimed rt header extent */
+
 	info->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT |
 		       IEEE80211_TX_CTL_DONTFRAG;
 
@@ -2188,13 +2201,6 @@ static bool ieee80211_parse_tx_radiotap(struct ieee80211_local *local,
 						     local->hw.max_rate_tries);
 	}
 
-	/*
-	 * remove the radiotap header
-	 * iterator->_max_length was sanity-checked against
-	 * skb->len by iterator init
-	 */
-	skb_pull(skb, iterator._max_length);
-
 	return true;
 }
 
@@ -2203,8 +2209,6 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 {
 	struct ieee80211_local *local = wdev_priv(dev->ieee80211_ptr);
 	struct ieee80211_chanctx_conf *chanctx_conf;
-	struct ieee80211_radiotap_header *prthdr =
-		(struct ieee80211_radiotap_header *)skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hdr *hdr;
 	struct ieee80211_sub_if_data *tmp_sdata, *sdata;
@@ -2212,21 +2216,17 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 	u16 len_rthdr;
 	int hdrlen;
 
-	/* check for not even having the fixed radiotap header part */
-	if (unlikely(skb->len < sizeof(struct ieee80211_radiotap_header)))
-		goto fail; /* too short to be possibly valid */
+	memset(info, 0, sizeof(*info));
+	info->flags = IEEE80211_TX_CTL_REQ_TX_STATUS |
+		      IEEE80211_TX_CTL_INJECTED;
 
-	/* is it a header version we can trust to find length from? */
-	if (unlikely(prthdr->it_version))
-		goto fail; /* only version 0 is supported */
+	/* Sanity-check and process the injection radiotap header */
+	if (!ieee80211_parse_tx_radiotap(skb, dev))
+		goto fail;
 
-	/* then there must be a radiotap header with a length we can use */
+	/* we now know there is a radiotap header with a length we can use */
 	len_rthdr = ieee80211_get_radiotap_len(skb->data);
 
-	/* does the skb contain enough to deliver on the alleged length? */
-	if (unlikely(skb->len < len_rthdr))
-		goto fail; /* skb too short for claimed rt header extent */
-
 	/*
 	 * fix up the pointers accounting for the radiotap
 	 * header still being in there.  We are being given
@@ -2272,11 +2272,6 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 		skb->priority = *p & IEEE80211_QOS_CTL_TAG1D_MASK;
 	}
 
-	memset(info, 0, sizeof(*info));
-
-	info->flags = IEEE80211_TX_CTL_REQ_TX_STATUS |
-		      IEEE80211_TX_CTL_INJECTED;
-
 	rcu_read_lock();
 
 	/*
@@ -2342,9 +2337,8 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 
 	info->band = chandef->chan->band;
 
-	/* process and remove the injection radiotap header */
-	if (!ieee80211_parse_tx_radiotap(local, skb))
-		goto fail_rcu;
+	/* remove the injection radiotap header */
+	skb_pull(skb, len_rthdr);
 
 	ieee80211_xmit(sdata, NULL, skb);
 	rcu_read_unlock();
-- 
2.27.0

