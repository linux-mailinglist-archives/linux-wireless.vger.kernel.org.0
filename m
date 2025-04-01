Return-Path: <linux-wireless+bounces-21038-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5E8A78330
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 22:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B553AE0EA
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 20:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4516B211282;
	Tue,  1 Apr 2025 20:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHBHhYK8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E5F212FAB
	for <linux-wireless@vger.kernel.org>; Tue,  1 Apr 2025 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743538395; cv=none; b=MX7eTb0vbWVEbbqpmL7DV1DPvmp8zO521/GmGeZmoR7HO3bZe25hOYRAQihDU3wWfKEajIRQXbgyzPbWEKCDg6PI65Zn5Sl2Z6nrRyvAM5WArpoflFFTQvq+ipqMmUHHku6VACJ5qJ9ZCWRX4hJddJKjCsrkOTZMAlhDb1gq38E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743538395; c=relaxed/simple;
	bh=su3I/D0MCADnRzFn2+FjyOCRyOhWkiI7Sy68Bxzq1o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjigHytQ9paDgZi/JfrLVSqC8iln7vS7nqDM2a4zOBCxv6EsYh0N4C3tFwbePfSngTILcoR2n1J9ppOEFHD2Q0BiVBrnIApdi/cQ5eHeDje+ydC69+7wCcZRDS3LKHnqZSptjQV3HnmYWABwbUfYZfRMa9yNP4JYIa56Fyxt+MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHBHhYK8; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5b6f3025dso9467687a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 01 Apr 2025 13:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743538391; x=1744143191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CH6twD9Do2AGCBeielImpT3yqHriaA5aGUTeV1qLbyc=;
        b=ZHBHhYK81lyjvlAdnTwjKhU76sMMsWrbaXFQoUtDOk6NRmsewEAS7Mg4oe8qZ00Cy2
         fdwN6K2Z6uWFWJNbGSY4Ehz+gCjR+aglV4SuypmGObNfUbdBAuemqlEpptTHP6tZYXWX
         sQQP6JO6MMDubjHgGaTjUdBCKImKdaoQc8wckCVYQRWRg0mmz1omgxdHWq8mKCJ/j20T
         nxu4BG/5R9hLVPaY1E1wd3h2bmQa3yJJb/H3p3cEHKrGriQ43eZn4tI4n6pfTK83+Gi9
         lFz8rgRE0slVDdPYs0i6aLkeFsBcPEW6r2hovixBM1aGtVg7lC4zeAh1B5pD/+Mf+Wyx
         pFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743538391; x=1744143191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CH6twD9Do2AGCBeielImpT3yqHriaA5aGUTeV1qLbyc=;
        b=XuNnjLdRwlc2Z+//WVxWLU61i4l6/MumIhGKWAfLPdIL4nPEwRZJkVqU0rZ/A2EdPY
         4Z5K3Ss8i8gYuSuOyKkXK0FBwrZARiir4Lv9x1Lsgd1tzm36B91Wcflhv5X60SuRv22e
         By1gTil1/NvjixE+G1n9eAXcgNYcv/mMvIpPyxiiEmW6NXyLjzy5QM8fs5jvJzSADNkA
         wU3af8HYPUI4MRYoSm4b8avsxPKQyNyelo6S/GIvRcCV2CdeLMEtG6QkRb+w+h5HUPMe
         ovshq8FTtlzrU9XRD3HDsVs2xbApvxugx11ky92OOcHj0dn4c5QsN/0DIsvwHQYExKXt
         6t7Q==
X-Gm-Message-State: AOJu0YxiU2Y7aQLVzmlUCwgYETLBxu4sEBaiqlZro4wY1SGnIOaLyTrx
	ohdD7YYD0lMtse1CGKQbLPYz/SsWNwRY0wr93ivmqDP3FNuJ0T83mPvfle5K
X-Gm-Gg: ASbGncsFJfAhYxp+4ZnKRF1rgwpupT2rUQrSG7g7jui/14Si96EYfU1D4DSIEKprUxo
	Vf42yUQWLSuqSoFxE7CL2c1S/swKIvHkNK5nNZuAvGiITw7LP9bvwKQN8nA9yGIbNTKL+g99ULC
	G+dznk/RJ9dYF1LsKTWpioG3zHtNaFlGypx5xQSv1gOY99ufn4kzOD+ToIYS3GkN9NsBeokWN3R
	1OCKP8UEAIYIufl1EK+sCwDxYuCH5a784UzkiZWvh9BR9TI/75gyHkDZJsfuhI/uEFyDJ36O+s4
	TaIsLJyGSYyL8155jsUkMBvH2DI5C7MHaVuof34Glrviz2mt7acKLA0lHflPgNMKquJA6p/rq1X
	9zlAfJEPp/ytLuhpv/RYjd5OVMPEFBICJtTTzXl3BB1GrfMAQCYHGSCtRSo+SnCE67j2MQmQ=
X-Google-Smtp-Source: AGHT+IF3ZhDRZpxwWRNTLrY+6nBGfVcx+gYeMdTt+AfrQ4MakiUfITMGxPYFYzASG5deRek6XDRQsw==
X-Received: by 2002:a17:907:25cb:b0:ac7:982f:c299 with SMTP id a640c23a62f3a-ac7982fd5e6mr104081166b.38.1743538391189;
        Tue, 01 Apr 2025 13:13:11 -0700 (PDT)
Received: from hp.NAT.swidnica_mmp.vectranet.pl (178235177162.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7196ddfebsm799078966b.164.2025.04.01.13.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 13:13:10 -0700 (PDT)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	j@w1.fi,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC wireless-next 2/2] wifi: mac80211: allow tagged control packets
Date: Tue,  1 Apr 2025 22:04:14 +0200
Message-ID: <20250401201259.50627-3-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401201259.50627-1-janusz.dziedzic@gmail.com>
References: <20250401201259.50627-1-janusz.dziedzic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tag/untag control packets when requested.

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 net/mac80211/cfg.c         |  3 +++
 net/mac80211/ieee80211_i.h |  3 ++-
 net/mac80211/iface.c       |  2 ++
 net/mac80211/rx.c          | 40 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/tx.c          | 24 ++++++++++++++++++-----
 5 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 9f683f838431..33de4c1cafd6 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1443,6 +1443,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 				params->crypto.control_port_over_nl80211;
 	sdata->control_port_no_preauth =
 				params->crypto.control_port_no_preauth;
+	sdata->control_port_vlan_id = params->crypto.control_port_vlan_id;
 
 	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list) {
 		vlan->control_port_protocol =
@@ -1453,6 +1454,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 			params->crypto.control_port_over_nl80211;
 		vlan->control_port_no_preauth =
 			params->crypto.control_port_no_preauth;
+		vlan->control_port_vlan_id =
+			params->crypto.control_port_vlan_id;
 	}
 
 	link_conf->dtim_period = params->dtim_period;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index fb05f3cd37ec..c2af887e861d 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1142,6 +1142,7 @@ struct ieee80211_sub_if_data {
 	bool control_port_no_encrypt;
 	bool control_port_no_preauth;
 	bool control_port_over_nl80211;
+	u16 control_port_vlan_id;
 
 	atomic_t num_tx_queued;
 	struct mac80211_qos_map __rcu *qos_map;
@@ -2105,7 +2106,7 @@ void ieee80211_clear_fast_xmit(struct sta_info *sta);
 int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len,
 			      const u8 *dest, __be16 proto, bool unencrypted,
-			      int link_id, u64 *cookie);
+			      int link_id, u64 *cookie, u16 vlan_id);
 int ieee80211_probe_mesh_link(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len);
 void __ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index b0423046028c..9e5e40aabee0 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1257,6 +1257,8 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 			master->control_port_over_nl80211;
 		sdata->control_port_no_preauth =
 			master->control_port_no_preauth;
+		sdata->control_port_vlan_id =
+			master->control_port_vlan_id;
 		sdata->vif.cab_queue = master->vif.cab_queue;
 		memcpy(sdata->vif.hw_queue, master->vif.hw_queue,
 		       sizeof(sdata->vif.hw_queue));
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index f7f89cd1b7d7..c1381c964674 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -23,6 +23,7 @@
 #include <net/mac80211.h>
 #include <net/ieee80211_radiotap.h>
 #include <linux/unaligned.h>
+#include <linux/if_vlan.h>
 
 #include "ieee80211_i.h"
 #include "driver-ops.h"
@@ -114,6 +115,28 @@ static inline bool should_drop_frame(struct sk_buff *skb, int present_fcs_len,
 	return false;
 }
 
+static bool ieee80211_vlan_control_allowed(struct ieee80211_rx_data *rx,
+					   struct sk_buff *skb,
+					   struct ethhdr *ehdr)
+{
+	struct vlan_ethhdr *vhdr = (void *)ehdr;
+	struct ieee80211_sub_if_data *sdata = rx->sdata;
+	u16 vlan_id;
+
+	if (!sdata->control_port_vlan_id)
+		return false;
+	if (ehdr->h_proto != cpu_to_be16(ETH_P_8021Q))
+		return false;
+	if (vhdr->h_vlan_encapsulated_proto != sdata->control_port_protocol)
+		return false;
+
+	vlan_id = be16_to_cpu(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
+	if (vlan_id != sdata->control_port_vlan_id)
+		return false;
+
+	return true;
+}
+
 static int
 ieee80211_rx_radiotap_hdrlen(struct ieee80211_local *local,
 			     struct ieee80211_rx_status *status,
@@ -2553,6 +2576,8 @@ __ieee80211_data_to_8023(struct ieee80211_rx_data *rx, bool *port_control)
 	ehdr = (struct ethhdr *) rx->skb->data;
 	if (ehdr->h_proto == rx->sdata->control_port_protocol)
 		*port_control = true;
+	else if (ieee80211_vlan_control_allowed(rx, rx->skb, ehdr))
+		*port_control = true;
 	else if (check_port_control)
 		return RX_DROP_U_NOT_PORT_CONTROL;
 
@@ -2606,6 +2631,11 @@ static bool ieee80211_frame_allowed(struct ieee80211_rx_data *rx, __le16 fc)
 		return ieee80211_is_our_addr(rx->sdata, ehdr->h_dest, NULL) ||
 		       ether_addr_equal(ehdr->h_dest, pae_group_addr);
 
+	/* Allow encapsulated EAPOL frames if requested */
+	if (ieee80211_vlan_control_allowed(rx, rx->skb, ehdr))
+		return ether_addr_equal(ehdr->h_dest, rx->sdata->vif.addr) ||
+		       ether_addr_equal(ehdr->h_dest, pae_group_addr);
+
 	if (ieee80211_802_1x_port_control(rx) ||
 	    ieee80211_drop_unencrypted(rx, fc))
 		return false;
@@ -2626,6 +2656,16 @@ static void ieee80211_deliver_skb_to_local_stack(struct sk_buff *skb,
 		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 		bool noencrypt = !(status->flag & RX_FLAG_DECRYPTED);
 
+		cfg80211_rx_control_port(dev, skb, noencrypt, rx->link_id);
+		dev_kfree_skb(skb);
+	} else if (ieee80211_vlan_control_allowed(rx, skb, (void *)skb_mac_header(skb))) {
+		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
+		bool noencrypt = !(status->flag & RX_FLAG_DECRYPTED);
+
+		/* strip VLAN */
+		skb_pull(skb, VLAN_HLEN);
+		skb->protocol = sdata->control_port_protocol;
+
 		cfg80211_rx_control_port(dev, skb, noencrypt, rx->link_id);
 		dev_kfree_skb(skb);
 	} else {
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 20179db88c4a..de7ce0beed1e 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2862,7 +2862,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 	if (unlikely(!ieee80211_vif_is_mesh(&sdata->vif) &&
 		     (sdata->vif.type != NL80211_IFTYPE_OCB) &&
 		     !multicast && !authorized &&
-		     (cpu_to_be16(ethertype) != sdata->control_port_protocol ||
+		     (!(ctrl_flags & IEEE80211_TX_CTRL_PORT_CTRL_PROTO) ||
 		      !ieee80211_is_our_addr(sdata, skb->data + ETH_ALEN, NULL)))) {
 #ifdef CONFIG_MAC80211_VERBOSE_DEBUG
 		net_info_ratelimited("%s: dropped frame to %pM (unauthorized port)\n",
@@ -6139,10 +6139,12 @@ void ieee80211_tx_skb_tid(struct ieee80211_sub_if_data *sdata,
 int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len,
 			      const u8 *dest, __be16 proto, bool unencrypted,
-			      int link_id, u64 *cookie)
+			      int link_id, u64 *cookie, u16 vlan_id)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
+	unsigned int hdrlen = sizeof(struct ethhdr);
+	struct vlan_hdr *vhdr;
 	struct sta_info *sta;
 	struct sk_buff *skb;
 	struct ethhdr *ehdr;
@@ -6170,17 +6172,29 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 	if (cookie)
 		ctrl_flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
 
-	flags |= IEEE80211_TX_INTFL_NL80211_FRAME_TX;
+	flags |= IEEE80211_TX_INTFL_NL80211_FRAME_TX |
+		 IEEE80211_TX_CTL_USE_MINRATE;
+
+	if (vlan_id)
+		hdrlen += sizeof(struct vlan_hdr);
 
 	skb = dev_alloc_skb(local->hw.extra_tx_headroom +
-			    sizeof(struct ethhdr) + len);
+			    hdrlen + len);
 	if (!skb)
 		return -ENOMEM;
 
-	skb_reserve(skb, local->hw.extra_tx_headroom + sizeof(struct ethhdr));
+	skb_reserve(skb, local->hw.extra_tx_headroom + hdrlen);
 
 	skb_put_data(skb, buf, len);
 
+	if (vlan_id) {
+		vhdr = skb_push(skb, VLAN_HLEN);
+		vhdr->h_vlan_encapsulated_proto =
+			sdata->control_port_protocol;
+		vhdr->h_vlan_TCI = cpu_to_be16(vlan_id & VLAN_VID_MASK);
+		proto = cpu_to_be16(ETH_P_8021Q);
+	}
+
 	ehdr = skb_push(skb, sizeof(struct ethhdr));
 	memcpy(ehdr->h_dest, dest, ETH_ALEN);
 
-- 
2.43.0


