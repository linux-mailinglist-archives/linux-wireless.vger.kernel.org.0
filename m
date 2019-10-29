Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABAEE83EC
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 10:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbfJ2JNP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 05:13:15 -0400
Received: from nbd.name ([46.4.11.11]:53986 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfJ2JNP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 05:13:15 -0400
Received: from p5dcfbe82.dip0.t-ipconnect.de ([93.207.190.130] helo=bertha.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1iPNYt-0005ZW-7E; Tue, 29 Oct 2019 10:13:11 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V9 1/3] mac80211: move store skb ack code to its own function
Date:   Tue, 29 Oct 2019 10:13:02 +0100
Message-Id: <20191029091304.7330-2-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191029091304.7330-1-john@phrozen.org>
References: <20191029091304.7330-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch moves the code handling SKBTX_WIFI_STATUS inside the TX path
into an extra function. This allows us to reuse it inside the 802.11 encap
offloading datapath.

Signed-off-by: John Crispin <john@phrozen.org>
---
 net/mac80211/tx.c | 49 ++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 235c6377a203..be3ce5e5a1c3 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2423,6 +2423,33 @@ static int ieee80211_lookup_ra_sta(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+static int ieee80211_store_ack_skb(struct ieee80211_local *local,
+				   struct sk_buff *skb,
+				   u32 *info_flags)
+{
+	struct sk_buff *ack_skb = skb_clone_sk(skb);
+	u16 info_id = 0;
+
+	if (ack_skb) {
+		unsigned long flags;
+		int id;
+
+		spin_lock_irqsave(&local->ack_status_lock, flags);
+		id = idr_alloc(&local->ack_status_frames, ack_skb,
+			       1, 0x10000, GFP_ATOMIC);
+		spin_unlock_irqrestore(&local->ack_status_lock, flags);
+
+		if (id >= 0) {
+			info_id = id;
+			*info_flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
+		} else {
+			kfree_skb(ack_skb);
+		}
+	}
+
+	return info_id;
+}
+
 /**
  * ieee80211_build_hdr - build 802.11 header in the given frame
  * @sdata: virtual interface to build the header for
@@ -2716,26 +2743,8 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (unlikely(!multicast && skb->sk &&
-		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
-		struct sk_buff *ack_skb = skb_clone_sk(skb);
-
-		if (ack_skb) {
-			unsigned long flags;
-			int id;
-
-			spin_lock_irqsave(&local->ack_status_lock, flags);
-			id = idr_alloc(&local->ack_status_frames, ack_skb,
-				       1, 0x10000, GFP_ATOMIC);
-			spin_unlock_irqrestore(&local->ack_status_lock, flags);
-
-			if (id >= 0) {
-				info_id = id;
-				info_flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
-			} else {
-				kfree_skb(ack_skb);
-			}
-		}
-	}
+		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS))
+		info_id = ieee80211_store_ack_skb(local, skb, &info_flags);
 
 	/*
 	 * If the skb is shared we need to obtain our own copy.
-- 
2.20.1

