Return-Path: <linux-wireless+bounces-28709-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (unknown [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B29C44641
	for <lists+linux-wireless@lfdr.de>; Sun, 09 Nov 2025 20:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AF474E2826
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Nov 2025 19:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA57421FF30;
	Sun,  9 Nov 2025 19:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLnIUjbn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B192FDF59
	for <linux-wireless@vger.kernel.org>; Sun,  9 Nov 2025 19:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762716964; cv=none; b=iM0Z9xwTf90x8z9McqcG6texRJRbYHbvj+qZb7TUk3MMRzKMuiDzSqJ/v/B7+j8j1qE+kV7KRBWlUJ2+h6YFxqtd0Xcf9afBlL49rg+gz5+YYVGIL6d76we2gsntb+pgQL4q7ImPpBEguOakRJtYFMopRIaTFoBdYEne7ShBbZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762716964; c=relaxed/simple;
	bh=ogKesy3y2+Rqqh3es9XidD30MBMzCSWr6UkUmop6aZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=si5jP7hKWN8tEoExerwZPkUDkF5r2sZyKu3shMStQRHGun1s02FKoe6jMBtA+crXaEs8Ygc3bNThjAO29LaJxsQTpVVX10yH7FxhpVEgxfDzZAGtDBTomkxg9VMmqV5WtKY2pPOQdH9bSowYjvktuxWnOJxYrjTc+9KtsX1RkLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLnIUjbn; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so3567972a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 09 Nov 2025 11:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762716961; x=1763321761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Kel143CgpibGXdM5NZO2vZP1Tdb0FbYj+A3+N0e6Vg=;
        b=aLnIUjbncDTkKyadx4GRm3VtZYHabTBNuv3pJhjGOevnqbz7Xt2yFoudM3LJJXPRjR
         8WTjFgEL6O2azBmbnM3hf9/lANaZCwMId98mltYpn9Ork9zOOz3otu6JTrP8v7kZfuV9
         P+pDL94Dog3gkGG3IH83SEEQePvo0Ydpl3bP7lAskjHFfjtGTR+hfXR5ZTtUNPhEBQtU
         uC1H6KXQwPcPj/4YkzJWt/YPS9YVqW8JK4TupubCgnNKRLC06CaRC5TLdw3qAFucE2vp
         GPjtQ2/vv3SAfzodLRZ22Iy15Y/ZyogmfQ4tReGEVAKVGGwxjXClbvrUhwP6wu3oeVWN
         BXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762716961; x=1763321761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Kel143CgpibGXdM5NZO2vZP1Tdb0FbYj+A3+N0e6Vg=;
        b=t+p3xW18QyODUAed9OxdlYGRMmoCKq40fltZJ0uZeJpejoXF0u9rggigtxCewoFzdQ
         s1DbvHPGf1+xYRwsFE1v7CRQQ2ufySn85N7M3SRTlDmI51XHBIJj6OZUwXgZ+2xpWR0z
         Vbbng6FCWxdpneVmPNsKszn8nspaesRhAy2r1ugQ1IAWq3tHfM1rFA3LK97p5H2mzD7S
         CErjODK7MsRXV4UzADnJ3cp613JwqyZzes+jBkGmo+r3dM58t8DcITbVyadu6ZF2/Pne
         76DWBOWvSRMdVSjqaZtZGaToIABpJhQHjbRqCVBAPk7pUANVNyY7TBlv0IXFiRogy10A
         Ybuw==
X-Gm-Message-State: AOJu0YzOpZRBCbmol2Y91xX6Xudz66cxT9vNR2HVTcnJSGTVg8VOOw/t
	uphOOa62GuIIwJ+msKWOYyPUd2WPBURk+mNPi7OeyUcv3c3OkrEAzZGoicjYz96c
X-Gm-Gg: ASbGncsJ4NdbbH/At87sEBchQyHRLJOZ+4YjC3mUQVdMeNsQLhTtqevjxXVopi99ecx
	wppa2wVfsYrlyIVbq5l+Wf0sXYm8RrnNJ3bzlrBa7iNlxQuif4NCVZ2uEmIopMhn4QEHfn+HFh1
	vffkKcRCBx2pHOS/7+ARk/T7XyxeYYCgN9CM0t7GS0RxuZ1QPaxckha6oyGRIZB3JaUMErTixAU
	cu1eJLrV4KDaayMF+P6a5zSD5uyNjDljkC44IwFFCSoYEIC2mteAecrTmqd/KptyEUS4ASCpNxy
	SwGyxYDhL9zp5pvvy/xdydx7tdFKXhoj3Li6m5+QlpfOvpkk6uHDirmdpZSwXQcg5rhvqBhqHed
	xT7ElFw9DpCrIKrvhHvMCSgrBJuB28IdLl5D8+M3pX3cQLlJPxXTH6YhriZiOuA6LX+8w2/n6Nx
	SR9Y/26f6oQwH2+HTdjnuapg02XH6Mg4iYeqwU
X-Google-Smtp-Source: AGHT+IEwzf7l9ybO6lDdgl9MTrPloBqmTstr2Wd4fjdk2BwEjgtwFEKNmu5wBqM/IuJL6KN0sYdnwQ==
X-Received: by 2002:a17:907:9343:b0:b3f:3570:3405 with SMTP id a640c23a62f3a-b72e0414b13mr650232666b.34.1762716960843;
        Sun, 09 Nov 2025 11:36:00 -0800 (PST)
Received: from hp.. (93-159-26-33.cgnat.inetia.pl. [93.159.26.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf31286esm873219766b.21.2025.11.09.11.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 11:36:00 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	j@w1.fi,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v4 wireless-next 2/2] wifi: mac80211: add support for VLAN-tagged EAPOL frames
Date: Sun,  9 Nov 2025 20:35:43 +0100
Message-ID: <20251109193543.2858854-2-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251109193543.2858854-1-janusz.dziedzic@gmail.com>
References: <20251109193543.2858854-1-janusz.dziedzic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement support for transmitting and receiving VLAN-tagged control port
frames (EAPOL) when NL80211_ATTR_CONTROL_PORT_OVER_NL80211_VLAN is set.
This enables 802.1X authentication in VLAN environments where EAPOL frames
must carry VLAN tags during the authentication phase.

When control_port_vlan_id is configured:
- RX path accepts both VLAN-tagged EAPOL frames (for backhaul STAs) and
  non-VLAN EAPOL frames (for regular clients), strips the VLAN header from
  tagged frames before passing to cfg80211
- TX path adds VLAN header with configured VLAN ID to outgoing EAPOL frames

This allows serving both fronthaul clients (non-tagged EAPs) and backhaul
STAs (VLAN-tagged EAPs) simultaneously.

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 net/mac80211/cfg.c         |  3 ++
 net/mac80211/ieee80211_i.h |  3 ++
 net/mac80211/iface.c       |  2 ++
 net/mac80211/main.c        |  2 ++
 net/mac80211/mlme.c        |  1 +
 net/mac80211/rx.c          | 64 ++++++++++++++++++++++++++++++++++----
 net/mac80211/tx.c          | 25 ++++++++++++---
 7 files changed, 90 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c52b0456039d..d162a37865f9 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1621,6 +1621,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 				params->crypto.control_port_over_nl80211;
 	sdata->control_port_no_preauth =
 				params->crypto.control_port_no_preauth;
+	sdata->control_port_vlan_id = params->control_port_vlan_id;
 
 	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list) {
 		vlan->control_port_protocol =
@@ -1631,6 +1632,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 			params->crypto.control_port_over_nl80211;
 		vlan->control_port_no_preauth =
 			params->crypto.control_port_no_preauth;
+		vlan->control_port_vlan_id =
+			params->control_port_vlan_id;
 	}
 
 	link_conf->dtim_period = params->dtim_period;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index b5442916df64..18e1b8465f97 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1162,6 +1162,7 @@ struct ieee80211_sub_if_data {
 	bool control_port_no_encrypt;
 	bool control_port_no_preauth;
 	bool control_port_over_nl80211;
+	u16 control_port_vlan_id;
 
 	atomic_t num_tx_queued;
 	struct mac80211_qos_map __rcu *qos_map;
@@ -1946,6 +1947,8 @@ void ieee80211_clear_fast_rx(struct sta_info *sta);
 
 bool ieee80211_is_our_addr(struct ieee80211_sub_if_data *sdata,
 			   const u8 *addr, int *out_link_id);
+bool ieee80211_is_control_port(struct ieee80211_sub_if_data *sdata,
+			       struct ethhdr *ehdr, u32 len);
 
 /* STA code */
 void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index a7873832d4fa..6e04115fe110 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1303,6 +1303,8 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 			master->control_port_over_nl80211;
 		sdata->control_port_no_preauth =
 			master->control_port_no_preauth;
+		sdata->control_port_vlan_id =
+			master->control_port_vlan_id;
 		sdata->vif.cab_queue = master->vif.cab_queue;
 		memcpy(sdata->vif.hw_queue, master->vif.hw_queue,
 		       sizeof(sdata->vif.hw_queue));
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index eefa6f7e899b..b057ac267854 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -889,6 +889,8 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 			      NL80211_EXT_FEATURE_CONTROL_PORT_NO_PREAUTH);
 	wiphy_ext_feature_set(wiphy,
 			      NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_TX_STATUS);
+	wiphy_ext_feature_set(wiphy,
+			      NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_VLAN);
 	wiphy_ext_feature_set(wiphy,
 			      NL80211_EXT_FEATURE_SCAN_FREQ_KHZ);
 	wiphy_ext_feature_set(wiphy,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 767804e41a34..545742719141 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -9902,6 +9902,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	sdata->control_port_over_nl80211 =
 					req->crypto.control_port_over_nl80211;
 	sdata->control_port_no_preauth = req->crypto.control_port_no_preauth;
+	sdata->control_port_vlan_id = req->control_port_vlan_id;
 
 	/* kick off associate process */
 	ifmgd->assoc_data = assoc_data;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 80067ed1da2f..8082e44beb13 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -23,6 +23,7 @@
 #include <net/mac80211.h>
 #include <net/ieee80211_radiotap.h>
 #include <linux/unaligned.h>
+#include <linux/if_vlan.h>
 
 #include "ieee80211_i.h"
 #include "driver-ops.h"
@@ -115,6 +116,43 @@ static inline bool should_drop_frame(struct sk_buff *skb, int present_fcs_len,
 	return false;
 }
 
+static bool ieee80211_is_vlan_control(struct ieee80211_sub_if_data *sdata,
+				      struct ethhdr *ehdr, u32 len)
+{
+	struct vlan_ethhdr *vhdr = (void *)ehdr;
+	u16 vlan_id;
+
+	if (ehdr->h_proto != cpu_to_be16(ETH_P_8021Q))
+		return false;
+
+	if (len < sizeof(struct vlan_ethhdr))
+		return false;
+
+	if (sdata->control_port_protocol != vhdr->h_vlan_encapsulated_proto)
+		return false;
+
+	vlan_id = be16_get_bits(vhdr->h_vlan_TCI, VLAN_VID_MASK);
+
+	return sdata->control_port_vlan_id == vlan_id;
+}
+
+bool ieee80211_is_control_port(struct ieee80211_sub_if_data *sdata,
+			       struct ethhdr *ehdr, u32 len)
+{
+	if (!sdata->control_port_over_nl80211)
+		return false;
+
+	/* If VLAN ID is configured, accept both VLAN-tagged (for backhaul STAs)
+	 * and non-VLAN (for regular clients) control port frames
+	 */
+	if (sdata->control_port_vlan_id)
+		return ieee80211_is_vlan_control(sdata, ehdr, len) ||
+		       ehdr->h_proto == sdata->control_port_protocol;
+
+	/* Otherwise, only accept non-VLAN control port frames */
+	return ehdr->h_proto == sdata->control_port_protocol;
+}
+
 static int
 ieee80211_rx_radiotap_hdrlen(struct ieee80211_local *local,
 			     struct ieee80211_rx_status *status,
@@ -2642,7 +2680,7 @@ __ieee80211_data_to_8023(struct ieee80211_rx_data *rx, bool *port_control)
 		return RX_DROP_U_INVALID_8023;
 
 	ehdr = (struct ethhdr *) rx->skb->data;
-	if (ehdr->h_proto == rx->sdata->control_port_protocol)
+	if (ieee80211_is_control_port(sdata, ehdr, rx->skb->len))
 		*port_control = true;
 	else if (check_port_control)
 		return RX_DROP_U_NOT_PORT_CONTROL;
@@ -2693,7 +2731,7 @@ static bool ieee80211_frame_allowed(struct ieee80211_rx_data *rx, __le16 fc)
 	 * whether the frame was encrypted or not, and always disallow
 	 * all other destination addresses for them.
 	 */
-	if (unlikely(ehdr->h_proto == rx->sdata->control_port_protocol))
+	if (unlikely(ieee80211_is_control_port(rx->sdata, ehdr, rx->skb->len)))
 		return ieee80211_is_our_addr(rx->sdata, ehdr->h_dest, NULL) ||
 		       ether_addr_equal(ehdr->h_dest, pae_group_addr);
 
@@ -2710,10 +2748,24 @@ static void ieee80211_deliver_skb_to_local_stack(struct sk_buff *skb,
 	struct ieee80211_sub_if_data *sdata = rx->sdata;
 	struct net_device *dev = sdata->dev;
 
-	if (unlikely((skb->protocol == sdata->control_port_protocol ||
-		     (skb->protocol == cpu_to_be16(ETH_P_PREAUTH) &&
-		      !sdata->control_port_no_preauth)) &&
-		     sdata->control_port_over_nl80211)) {
+	if (unlikely(ieee80211_is_control_port(sdata, (void *)skb_mac_header(skb),
+					       skb_tail_pointer(skb) - skb_mac_header(skb)))) {
+		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
+		struct ethhdr *ehdr = (void *)skb_mac_header(skb);
+		bool noencrypt = !(status->flag & RX_FLAG_DECRYPTED);
+
+		/* strip VLAN header if frame is VLAN-tagged */
+		if (sdata->control_port_vlan_id &&
+		    ehdr->h_proto == cpu_to_be16(ETH_P_8021Q)) {
+			skb_pull(skb, VLAN_HLEN);
+			skb->protocol = sdata->control_port_protocol;
+		}
+
+		cfg80211_rx_control_port(dev, skb, noencrypt, rx->link_id);
+		dev_kfree_skb(skb);
+	} else if (unlikely((skb->protocol == cpu_to_be16(ETH_P_PREAUTH) &&
+			     !sdata->control_port_no_preauth) &&
+			    sdata->control_port_over_nl80211)) {
 		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 		bool noencrypt = !(status->flag & RX_FLAG_DECRYPTED);
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index b2eb72cca892..840069d40645 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2860,7 +2860,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 	if (unlikely(!ieee80211_vif_is_mesh(&sdata->vif) &&
 		     (sdata->vif.type != NL80211_IFTYPE_OCB) &&
 		     !multicast && !authorized &&
-		     (cpu_to_be16(ethertype) != sdata->control_port_protocol ||
+		     (!ieee80211_is_control_port(sdata, (void *)skb->data, skb->len) ||
 		      !ieee80211_is_our_addr(sdata, skb->data + ETH_ALEN, NULL)))) {
 #ifdef CONFIG_MAC80211_VERBOSE_DEBUG
 		net_info_ratelimited("%s: dropped frame to %pM (unauthorized port)\n",
@@ -6322,6 +6322,8 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
+	unsigned int hdrlen = sizeof(struct ethhdr);
+	struct vlan_hdr *vhdr;
 	struct sta_info *sta;
 	struct sk_buff *skb;
 	struct ethhdr *ehdr;
@@ -6349,17 +6351,32 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 	if (cookie)
 		ctrl_flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
 
-	flags |= IEEE80211_TX_INTFL_NL80211_FRAME_TX;
+	flags |= IEEE80211_TX_INTFL_NL80211_FRAME_TX |
+		 IEEE80211_TX_CTL_USE_MINRATE;
+
+	if (vlan_id != sdata->control_port_vlan_id)
+		return -EINVAL;
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
+		vhdr->h_vlan_TCI = be16_encode_bits(vlan_id, VLAN_VID_MASK);
+		proto = cpu_to_be16(ETH_P_8021Q);
+	}
+
 	ehdr = skb_push(skb, sizeof(struct ethhdr));
 	memcpy(ehdr->h_dest, dest, ETH_ALEN);
 
-- 
2.43.0


