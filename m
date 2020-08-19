Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6ED249524
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 08:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgHSGpy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Aug 2020 02:45:54 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62192 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgHSGpy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Aug 2020 02:45:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597819553; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=S5SeyNfb/UzBxcxnfBBStp1s+s3Sc6yBy2ZrjtLRqmY=; b=KHYmC10hLOvXxNC9n0vHnyeKe53oO/4Qtapb+LK1gwF8qjQz7nsT9NAKfWvVxWkcQQAOZLj4
 DcFUoQlk+mIIlchIXXqWpjzGCqnXR108rEaTcpeko7xwvq1AWGgdRJks17VB+vOgJgo990a6
 LHDx7RV56hOqxFdVdwkX7kE7c6s=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f3ccaa1247ccc308c0821ca (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 19 Aug 2020 06:45:53
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3ECE9C433CB; Wed, 19 Aug 2020 06:45:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from seevalam-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: seevalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 27060C433CA;
        Wed, 19 Aug 2020 06:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27060C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=seevalam@codeaurora.org
From:   Seevalamuthu Mariappan <seevalam@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>
Subject: [PATCH] mac80211: send only vlan group traffics in 80211 xmit path
Date:   Wed, 19 Aug 2020 12:15:27 +0530
Message-Id: <1597819527-31887-1-git-send-email-seevalam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

AP-VLAN multicast/broadcast packets are expected to be encrypted
in software. Those packets should follow 802.11 xmit path.
AP-VLAN unicast packets can go with encryption in driver/hardware.
Redirect these packets to 'ieee80211_8023_xmit' from
'__ieee80211_subif_start_xmit' if encapsulation offload is
enabled on AP interface.

Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
---
 net/mac80211/tx.c | 201 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 106 insertions(+), 95 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index dca01d7..bfe74e0 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3919,101 +3919,6 @@ void ieee80211_txq_schedule_start(struct ieee80211_hw *hw, u8 ac)
 }
 EXPORT_SYMBOL(ieee80211_txq_schedule_start);
 
-void __ieee80211_subif_start_xmit(struct sk_buff *skb,
-				  struct net_device *dev,
-				  u32 info_flags,
-				  u32 ctrl_flags,
-				  u64 *cookie)
-{
-	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
-	struct ieee80211_local *local = sdata->local;
-	struct sta_info *sta;
-	struct sk_buff *next;
-
-	if (unlikely(skb->len < ETH_HLEN)) {
-		kfree_skb(skb);
-		return;
-	}
-
-	rcu_read_lock();
-
-	if (ieee80211_lookup_ra_sta(sdata, skb, &sta))
-		goto out_free;
-
-	if (IS_ERR(sta))
-		sta = NULL;
-
-	if (local->ops->wake_tx_queue) {
-		u16 queue = __ieee80211_select_queue(sdata, sta, skb);
-		skb_set_queue_mapping(skb, queue);
-		skb_get_hash(skb);
-	}
-
-	if (sta) {
-		struct ieee80211_fast_tx *fast_tx;
-
-		sk_pacing_shift_update(skb->sk, sdata->local->hw.tx_sk_pacing_shift);
-
-		fast_tx = rcu_dereference(sta->fast_tx);
-
-		if (fast_tx &&
-		    ieee80211_xmit_fast(sdata, sta, fast_tx, skb))
-			goto out;
-	}
-
-	if (skb_is_gso(skb)) {
-		struct sk_buff *segs;
-
-		segs = skb_gso_segment(skb, 0);
-		if (IS_ERR(segs)) {
-			goto out_free;
-		} else if (segs) {
-			consume_skb(skb);
-			skb = segs;
-		}
-	} else {
-		/* we cannot process non-linear frames on this path */
-		if (skb_linearize(skb)) {
-			kfree_skb(skb);
-			goto out;
-		}
-
-		/* the frame could be fragmented, software-encrypted, and other
-		 * things so we cannot really handle checksum offload with it -
-		 * fix it up in software before we handle anything else.
-		 */
-		if (skb->ip_summed == CHECKSUM_PARTIAL) {
-			skb_set_transport_header(skb,
-						 skb_checksum_start_offset(skb));
-			if (skb_checksum_help(skb))
-				goto out_free;
-		}
-	}
-
-	skb_list_walk_safe(skb, skb, next) {
-		skb_mark_not_on_list(skb);
-
-		if (skb->protocol == sdata->control_port_protocol)
-			ctrl_flags |= IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP;
-
-		skb = ieee80211_build_hdr(sdata, skb, info_flags,
-					  sta, ctrl_flags, cookie);
-		if (IS_ERR(skb)) {
-			kfree_skb_list(next);
-			goto out;
-		}
-
-		ieee80211_tx_stats(dev, skb->len);
-
-		ieee80211_xmit(sdata, sta, skb);
-	}
-	goto out;
- out_free:
-	kfree_skb(skb);
- out:
-	rcu_read_unlock();
-}
-
 static int ieee80211_change_da(struct sk_buff *skb, struct sta_info *sta)
 {
 	struct ethhdr *eth;
@@ -4267,6 +4172,112 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	kfree_skb(skb);
 }
 
+void __ieee80211_subif_start_xmit(struct sk_buff *skb,
+				  struct net_device *dev,
+				  u32 info_flags,
+				  u32 ctrl_flags,
+				  u64 *cookie)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_local *local = sdata->local;
+	struct sta_info *sta;
+	struct sk_buff *next;
+	struct ieee80211_sub_if_data *ap_sdata;
+
+	if (unlikely(skb->len < ETH_HLEN)) {
+		kfree_skb(skb);
+		return;
+	}
+
+	rcu_read_lock();
+
+	if (ieee80211_lookup_ra_sta(sdata, skb, &sta))
+		goto out_free;
+
+	if (IS_ERR(sta))
+		sta = NULL;
+
+	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
+		ap_sdata = container_of(sdata->bss,
+					struct ieee80211_sub_if_data, u.ap);
+		if (ap_sdata->hw_80211_encap && !is_multicast_ether_addr(skb->data)) {
+			ieee80211_8023_xmit(sdata, dev, sta, skb);
+			rcu_read_unlock();
+			return;
+		}
+	}
+
+	if (local->ops->wake_tx_queue) {
+		u16 queue = __ieee80211_select_queue(sdata, sta, skb);
+		skb_set_queue_mapping(skb, queue);
+		skb_get_hash(skb);
+	}
+
+	if (sta) {
+		struct ieee80211_fast_tx *fast_tx;
+
+		sk_pacing_shift_update(skb->sk, sdata->local->hw.tx_sk_pacing_shift);
+
+		fast_tx = rcu_dereference(sta->fast_tx);
+
+		if (fast_tx &&
+		    ieee80211_xmit_fast(sdata, sta, fast_tx, skb))
+			goto out;
+	}
+
+	if (skb_is_gso(skb)) {
+		struct sk_buff *segs;
+
+		segs = skb_gso_segment(skb, 0);
+		if (IS_ERR(segs)) {
+			goto out_free;
+		} else if (segs) {
+			consume_skb(skb);
+			skb = segs;
+		}
+	} else {
+		/* we cannot process non-linear frames on this path */
+		if (skb_linearize(skb)) {
+			kfree_skb(skb);
+			goto out;
+		}
+
+		/* the frame could be fragmented, software-encrypted, and other
+		 * things so we cannot really handle checksum offload with it -
+		 * fix it up in software before we handle anything else.
+		 */
+		if (skb->ip_summed == CHECKSUM_PARTIAL) {
+			skb_set_transport_header(skb,
+						 skb_checksum_start_offset(skb));
+			if (skb_checksum_help(skb))
+				goto out_free;
+		}
+	}
+
+	skb_list_walk_safe(skb, skb, next) {
+		skb_mark_not_on_list(skb);
+
+		if (skb->protocol == sdata->control_port_protocol)
+			ctrl_flags |= IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP;
+
+		skb = ieee80211_build_hdr(sdata, skb, info_flags,
+					  sta, ctrl_flags, cookie);
+		if (IS_ERR(skb)) {
+			kfree_skb_list(next);
+			goto out;
+		}
+
+		ieee80211_tx_stats(dev, skb->len);
+
+		ieee80211_xmit(sdata, sta, skb);
+	}
+	goto out;
+ out_free:
+	kfree_skb(skb);
+ out:
+	rcu_read_unlock();
+}
+
 netdev_tx_t ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
 					    struct net_device *dev)
 {
-- 
2.7.4

