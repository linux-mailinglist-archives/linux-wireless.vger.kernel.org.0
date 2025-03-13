Return-Path: <linux-wireless+bounces-20322-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F8BA5F4E5
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 13:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F2167A9D26
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 12:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7886D267392;
	Thu, 13 Mar 2025 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kjelFqp4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F417266590;
	Thu, 13 Mar 2025 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870227; cv=none; b=k3ZI1MH575w6F/5Gu/gyeOWKgAXNB2zIqe/u3Hd7I+3GkI4sb2arVWKGywhBpVe2EABOyXkLosbYDKtRTrE1XlZu2irlcXxSCv33DIiC5CYS1XhMkM5E5akCge4kFSY/fYvL5LS0IRvMbrFIH8WdZ8b+YnfijH39jxUKmV0Pdiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870227; c=relaxed/simple;
	bh=oR/FOTGpD7ULVyHXL30j9v0bs5KEW/bAEWpuMNpwgs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s+uwXC11n/rkUwfMw0D/8OiHeHNTTZczX3wUSXx4bHHxbPYiAH/y79GWYIukLwu6ehE3dJvQzNF3CrVaWEPe7tJ0aDxmK2JRiwwSR+AV1ahesh351OYhpKuErvDZlmrbzcrrZ6pdo2KVTG2KhEB2ired0QcAndDHbuvCmi3g0Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kjelFqp4; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=+kuVs+5VOg64wjtKDeqaYWPBfW7mwU/NExIX/melAfM=; t=1741870225; x=1743079825; 
	b=kjelFqp461uaEZ680JjzvLzNV6QPnExhlYQTK1SmBh27y4ExrLemnm72pEWdHyatYLGFMnutMD8
	x4s74Tg8RbJpZE/GDlp8iadvTy6wD1S2xc6A+FRISkkgSqc6+TnQgI2ibhZTW4De4EXiLBGUJihnd
	O5jSMrBN5AgccKGFApPEDeb8YHeEsMjHyAAJgSMTlPzPnCvV5qL0wQ1rEB1rD2NdyZO5jL+kxUH+W
	gUS8NCaDWAwvWYPqvdA7MC9I/mxqASuAKWwIux4y7/k96sMSfWIe2ZsRZ3ZggtC2pzY/5bFpSnCKF
	mVQJQlEg8IDeP83RFCqJN4ps1bekNlMsGHJQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tsi0u-00000009zlb-2Hzs;
	Thu, 13 Mar 2025 13:50:16 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH] wifi: free SKBTX_WIFI_STATUS skb tx_flags flag
Date: Thu, 13 Mar 2025 13:49:39 +0100
Message-ID: <20250313134942.52ff54a140ec.If390bbdc46904cf451256ba989d7a056c457af6e@changeid>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Someone mentioned today at netdevconf that we've run out of
tx_flags in the skb_shinfo(). Gain one bit back by removing
the wifi bit. We should be able to do that because the only
userspace application for it (hostapd) doesn't change the
setting on the socket, it just uses different sockets, and
normally doesn't even use this any more, sending the frames
over nl80211 instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/wil6210/txrx.h     | 3 ++-
 drivers/net/wireless/marvell/mwifiex/main.c | 3 ++-
 include/linux/skbuff.h                      | 3 ---
 include/net/sock.h                          | 2 --
 net/mac80211/mesh.c                         | 3 ++-
 net/mac80211/tx.c                           | 9 ++++-----
 6 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/txrx.h b/drivers/net/wireless/ath/wil6210/txrx.h
index 689f68d89a44..33ccd0b248d4 100644
--- a/drivers/net/wireless/ath/wil6210/txrx.h
+++ b/drivers/net/wireless/ath/wil6210/txrx.h
@@ -7,6 +7,7 @@
 #ifndef WIL6210_TXRX_H
 #define WIL6210_TXRX_H
 
+#include <net/sock.h>
 #include "wil6210.h"
 #include "txrx_edma.h"
 
@@ -617,7 +618,7 @@ static inline bool wil_need_txstat(struct sk_buff *skb)
 	const u8 *da = wil_skb_get_da(skb);
 
 	return is_unicast_ether_addr(da) && skb->sk &&
-	       (skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS);
+	       sock_flag(skb->sk, SOCK_WIFI_STATUS);
 }
 
 static inline void wil_consume_skb(struct sk_buff *skb, bool acked)
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 45eecb5f643b..058687793a10 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/suspend.h>
+#include <net/sock.h>
 
 #include "main.h"
 #include "wmm.h"
@@ -943,7 +944,7 @@ mwifiex_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	multicast = is_multicast_ether_addr(skb->data);
 
 	if (unlikely(!multicast && skb->sk &&
-		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS &&
+		     sock_flag(skb->sk, SOCK_WIFI_STATUS) &&
 		     priv->adapter->fw_api_ver == MWIFIEX_FW_V15))
 		skb = mwifiex_clone_skb_for_tx_status(priv,
 						      skb,
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 14517e95a46c..a8638c8a53b4 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -481,9 +481,6 @@ enum {
 	/* reserved */
 	SKBTX_RESERVED = 1 << 3,
 
-	/* generate wifi status information (where possible) */
-	SKBTX_WIFI_STATUS = 1 << 4,
-
 	/* determine hardware time stamp based on time or cycles */
 	SKBTX_HW_TSTAMP_NETDEV = 1 << 5,
 
diff --git a/include/net/sock.h b/include/net/sock.h
index 8daf1b3b12c6..2668c3ed45ef 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2700,8 +2700,6 @@ static inline void _sock_tx_timestamp(struct sock *sk,
 				*tskey = atomic_inc_return(&sk->sk_tskey) - 1;
 		}
 	}
-	if (unlikely(sock_flag(sk, SOCK_WIFI_STATUS)))
-		*tx_flags |= SKBTX_WIFI_STATUS;
 }
 
 static inline void sock_tx_timestamp(struct sock *sk,
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 974081324aa4..e77e623c8b77 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -8,6 +8,7 @@
 
 #include <linux/slab.h>
 #include <linux/unaligned.h>
+#include <net/sock.h>
 #include "ieee80211_i.h"
 #include "mesh.h"
 #include "wme.h"
@@ -776,7 +777,7 @@ bool ieee80211_mesh_xmit_fast(struct ieee80211_sub_if_data *sdata,
 	if (ethertype < ETH_P_802_3_MIN)
 		return false;
 
-	if (skb->sk && skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)
+	if (skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS))
 		return false;
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 20179db88c4a..b75f72fbefd9 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -26,6 +26,7 @@
 #include <net/codel_impl.h>
 #include <linux/unaligned.h>
 #include <net/fq_impl.h>
+#include <net/sock.h>
 #include <net/gso.h>
 
 #include "ieee80211_i.h"
@@ -2876,8 +2877,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (unlikely(!multicast &&
-		     ((skb->sk &&
-		       skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS) ||
+		     ((skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS)) ||
 		      ctrl_flags & IEEE80211_TX_CTL_REQ_TX_STATUS)))
 		info_id = ieee80211_store_ack_skb(local, skb, &info_flags,
 						  cookie);
@@ -3774,7 +3774,7 @@ static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 		return false;
 
 	/* don't handle TX status request here either */
-	if (skb->sk && skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)
+	if (skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS))
 		return false;
 
 	if (hdr->frame_control & cpu_to_le16(IEEE80211_STYPE_QOS_DATA)) {
@@ -4664,8 +4664,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 			memcpy(IEEE80211_SKB_CB(seg), info, sizeof(*info));
 	}
 
-	if (unlikely(skb->sk &&
-		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)) {
+	if (unlikely(skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS))) {
 		info->status_data = ieee80211_store_ack_skb(local, skb,
 							    &info->flags, NULL);
 		if (info->status_data)
-- 
2.48.1


