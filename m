Return-Path: <linux-wireless+bounces-21209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A1AA7EBF2
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 21:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C71947A2247
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 19:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB99254AFE;
	Mon,  7 Apr 2025 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrFeydJF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F363208
	for <linux-wireless@vger.kernel.org>; Mon,  7 Apr 2025 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051127; cv=none; b=thSHaUVU8aTACK7TFrXAFLi28obTR1HveshogU9q8/kOlqo1eDVLJlQ3Nz0iJ8U+a3YZT8SBv2hGjinWOtiHdpQxLxDjPpCsoDffcke1inJwOFgK8mFFzrHPSaZVaRraZCf2AGcIU6IEFl3OWopiSrG08VzfDL3PQST8BIOamXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051127; c=relaxed/simple;
	bh=Ls8kV5zIYbsE22Y3kiIuOqPmNCFWqLLTxpNTl88I+JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJNef00P/a8d3tPitYJ74Jf2NwruZV5jrY0D+vmQ9Vjp5lahcPwBZZFZ9/Nh+TcFu+z/vHxVe82jOOUPqdRdbf+Cxnu4jLct1vL8QCrw/k+BzjEM7aGh1y9mySHy0P+lyvXwZSsPtuDvGcg6XG5TLY2suCCFIF4jwjLrQwj/g5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrFeydJF; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso550314166b.0
        for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 11:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744051123; x=1744655923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Dv4+fJg4CM82PZEP84xrEdxNGkZsZOBCUv5yue9Iuk=;
        b=NrFeydJFDd3sQ5FwyzqZlfASAeFFCAarD1hoAXbb5VFXdTzh3455o8E3pV/Uxch7DL
         tJEeyqjRpE2L93jQ8q3A16AreRjPDKCWXL60LAKQYblnWemBbpCoFdYqPZ15FSOvG5NM
         l14Qez3+yn5s8RNfv7bXozNQdEdbyM2d5q4SK/AFgDbFST1qK78wJ7wqC187F62Alp3s
         RU+z0sGzkcGzXLi9dmu5zNGdeirY8BomSjhmWMCo1f4E2r+i5+CdEZJZA0ZY4mol1+HX
         C+aWZiEBShtep2iQO8ql4hQ9S1oB2vV9RbgWWDjWgVaG0XZBrETl1rF/kXw++iQ5WkGp
         R2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744051123; x=1744655923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Dv4+fJg4CM82PZEP84xrEdxNGkZsZOBCUv5yue9Iuk=;
        b=U6T0mR4qHZ920gMq+uC3i/HM/I/gtMu2PF4jYqUVCXixOKpK8AegL4VmeN08NjnNDn
         VwuBvs03pApE0xu1YbzWTFG3RqdaEiUafdxlGCvTHUO3c8WWl+tEGsrs4BDiZWaNpGnc
         DfX87/9f02UHcCyUOvM4ILuLNASFSeB/GQrYkm+euoixFWRr1ZaZe/gaWKqVswfgtxqk
         tvSltIeQ/gITrPqy7Y0IuZ5J/8WJVTQhtSHU1NNWcBObmo7OSVDI7xZJ4nfubb0DqgyZ
         30kEklfh0TrBai0tpd0Z0Z++zD5SkXvlYfpgFCDIGg/aVyjRMOFpMWVQ2vYT9S15JnwY
         XZOg==
X-Gm-Message-State: AOJu0YxaeoTSN2pualpRdUILCWR4/QDP2LYeqgSVw24KCpVnbivw/7eF
	Pz2vjKxJjSUFElryLkmIwu9oz6M28uNME6nzx5Pu3g7cdR7a/pz9RHwot3Ha
X-Gm-Gg: ASbGncv504bEEcrpSymv/2ifx/xz0MlombPeXK2wBiGGePcpffRFLQGG4OVn3iZy1P6
	lYZVNDwnbBXH7i6PiMi0YnD4Df5oH0Q/4XyEq/y7LAcfSP9Nue09XppvB/Awv0aGxFVlrMKHR2G
	47jd/43Uof1OGzaCqBQJEcAXR8Z5J3LGP6KGUkEl8CYogcKVJNZZa/VS+NPnYpK+XBYNOIRo+eM
	2plaQ4nkXkAExNfShd97RDfjlooX0YvxAncWmi5KD1N+S7Xrje1n53zw/Pxtt0vQaT5KVlP3iaG
	jj8GyT3Cosa3y1/yxsjC2ZmVxNKy6iY+vNpX2uJZxitcHfplyCF6b/O9aDkVonCIS+eP/Z9ZW2K
	W/Un70+jdXoyAx7CSgPZi8IW1IH5N2nevPZUYuAyBnenD50yzhEK0y+0gDEK7gaYw7tHlBp8=
X-Google-Smtp-Source: AGHT+IFcBAPIoOc021zKzjgQs58i7IqQm14LMxXpRjb8j49cfXOfUeEMBLgkKgDqL1O9VNeDUo00Gg==
X-Received: by 2002:a17:907:1c8e:b0:ac7:c584:e691 with SMTP id a640c23a62f3a-ac7d1ccdc8fmr1295026466b.54.1744051123100;
        Mon, 07 Apr 2025 11:38:43 -0700 (PDT)
Received: from hp.NAT.swidnica_mmp.vectranet.pl (178235177162.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe99b24sm795355866b.53.2025.04.07.11.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 11:38:42 -0700 (PDT)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	j@w1.fi,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v2 wireless-next 2/2] wifi: mac80211: support tagged EAPOLs
Date: Mon,  7 Apr 2025 20:34:08 +0200
Message-ID: <20250407183818.759759-2-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407183818.759759-1-janusz.dziedzic@gmail.com>
References: <20250407183818.759759-1-janusz.dziedzic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When configured control_port_over_nl80211 allow to
receive/send tagged EAPOLs.

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
[v2]:
 - introduce helpers
 - enable only when control_port_over_nl80211

 net/mac80211/cfg.c         |  3 +++
 net/mac80211/ieee80211_i.h |  3 +++
 net/mac80211/iface.c       |  2 ++
 net/mac80211/rx.c          | 54 ++++++++++++++++++++++++++++++++++++--
 net/mac80211/tx.c          | 23 +++++++++++++---
 5 files changed, 79 insertions(+), 6 deletions(-)

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
index 7012bda050bb..9d6e8f5df310 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1142,6 +1142,7 @@ struct ieee80211_sub_if_data {
 	bool control_port_no_encrypt;
 	bool control_port_no_preauth;
 	bool control_port_over_nl80211;
+	u16 control_port_vlan_id;
 
 	atomic_t num_tx_queued;
 	struct mac80211_qos_map __rcu *qos_map;
@@ -1890,6 +1891,8 @@ void ieee80211_clear_fast_rx(struct sta_info *sta);
 
 bool ieee80211_is_our_addr(struct ieee80211_sub_if_data *sdata,
 			   const u8 *addr, int *out_link_id);
+bool ieee80211_is_vlan_control(struct ieee80211_sub_if_data *sdata,
+			       struct ethhdr *ehdr);
 
 /* STA code */
 void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata);
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
index f7f89cd1b7d7..d525fe901afc 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -23,6 +23,7 @@
 #include <net/mac80211.h>
 #include <net/ieee80211_radiotap.h>
 #include <linux/unaligned.h>
+#include <linux/if_vlan.h>
 
 #include "ieee80211_i.h"
 #include "driver-ops.h"
@@ -114,6 +115,43 @@ static inline bool should_drop_frame(struct sk_buff *skb, int present_fcs_len,
 	return false;
 }
 
+bool ieee80211_is_vlan_control(struct ieee80211_sub_if_data *sdata,
+			       struct ethhdr *ehdr)
+{
+	struct vlan_ethhdr *vhdr = (void *)ehdr;
+
+	if (!sdata->control_port_over_nl80211)
+		return false;
+	if (ehdr->h_proto != cpu_to_be16(ETH_P_8021Q))
+		return false;
+	if (vhdr->h_vlan_encapsulated_proto != sdata->control_port_protocol)
+		return false;
+
+	return true;
+}
+
+static bool ieee80211_vlan_control_allowed(struct ieee80211_rx_data *rx,
+					   struct ethhdr *ehdr)
+{
+	struct vlan_ethhdr *vhdr = (void *)ehdr;
+	struct ieee80211_sub_if_data *sdata = rx->sdata;
+	u16 vlan_id;
+
+	if (!sdata->control_port_over_nl80211)
+		return false;
+	if (!sdata->control_port_vlan_id)
+		return false;
+
+	if (!ieee80211_is_vlan_control(sdata, ehdr))
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
@@ -2551,7 +2589,8 @@ __ieee80211_data_to_8023(struct ieee80211_rx_data *rx, bool *port_control)
 		return RX_DROP_U_INVALID_8023;
 
 	ehdr = (struct ethhdr *) rx->skb->data;
-	if (ehdr->h_proto == rx->sdata->control_port_protocol)
+	if (ehdr->h_proto == rx->sdata->control_port_protocol ||
+	    ieee80211_vlan_control_allowed(rx, ehdr))
 		*port_control = true;
 	else if (check_port_control)
 		return RX_DROP_U_NOT_PORT_CONTROL;
@@ -2602,7 +2641,8 @@ static bool ieee80211_frame_allowed(struct ieee80211_rx_data *rx, __le16 fc)
 	 * whether the frame was encrypted or not, and always disallow
 	 * all other destination addresses for them.
 	 */
-	if (unlikely(ehdr->h_proto == rx->sdata->control_port_protocol))
+	if (unlikely(ehdr->h_proto == rx->sdata->control_port_protocol ||
+		     ieee80211_vlan_control_allowed(rx, ehdr)))
 		return ieee80211_is_our_addr(rx->sdata, ehdr->h_dest, NULL) ||
 		       ether_addr_equal(ehdr->h_dest, pae_group_addr);
 
@@ -2626,6 +2666,16 @@ static void ieee80211_deliver_skb_to_local_stack(struct sk_buff *skb,
 		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 		bool noencrypt = !(status->flag & RX_FLAG_DECRYPTED);
 
+		cfg80211_rx_control_port(dev, skb, noencrypt, rx->link_id);
+		dev_kfree_skb(skb);
+	} else if (ieee80211_vlan_control_allowed(rx, (void *)skb_mac_header(skb))) {
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
index 1988234b6149..9b20f19bca4e 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2862,7 +2862,8 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 	if (unlikely(!ieee80211_vif_is_mesh(&sdata->vif) &&
 		     (sdata->vif.type != NL80211_IFTYPE_OCB) &&
 		     !multicast && !authorized &&
-		     (cpu_to_be16(ethertype) != sdata->control_port_protocol ||
+		     ((cpu_to_be16(ethertype) != sdata->control_port_protocol &&
+		       !ieee80211_is_vlan_control(sdata, (void *)skb->data)) ||
 		      !ieee80211_is_our_addr(sdata, skb->data + ETH_ALEN, NULL)))) {
 #ifdef CONFIG_MAC80211_VERBOSE_DEBUG
 		net_info_ratelimited("%s: dropped frame to %pM (unauthorized port)\n",
@@ -6143,6 +6144,8 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
+	unsigned int hdrlen = sizeof(struct ethhdr);
+	struct vlan_hdr *vhdr;
 	struct sta_info *sta;
 	struct sk_buff *skb;
 	struct ethhdr *ehdr;
@@ -6170,17 +6173,29 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
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


