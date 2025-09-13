Return-Path: <linux-wireless+bounces-27274-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9D7B562EC
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Sep 2025 22:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59CD717E9E0
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Sep 2025 20:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F56F25B312;
	Sat, 13 Sep 2025 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3F3NRPx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4443B15D1
	for <linux-wireless@vger.kernel.org>; Sat, 13 Sep 2025 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757795299; cv=none; b=aBaqTU1iLFVbGJ6cGG6Zse2a1freFuM6d0X58NxivzWqF0MUwLbp55q6MDwtMoschRAf/K0B/+qwbnFLvZhlpAJMSEahJIVYf8sBnkIZGt3dK8gDUfUQUFq3IGmKGUy6TpMvMy3O2H77pO+yVi7trG3lr8Q7dTCKFYWDT7kewS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757795299; c=relaxed/simple;
	bh=iTe2yt3mS2gH1RR6xJ4iEOa1a++tcUx5b9pk8+i5EEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRIe2spQ7YHUYuyubnL5vabkjCsKF+KlmunvYWwWFwSn/RACWVwYn8YBkrTzjDZsReaAgcbH0GZUQrBMC4zZf5JPsRP3V14oY+pRgUS34irwPONKgEXms3RrPQU+Yv3/04+oDGDaDM7ciPf7WG/tghtkPv+oGaat6d1s12L7uNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3F3NRPx; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62ed3e929d1so4042805a12.3
        for <linux-wireless@vger.kernel.org>; Sat, 13 Sep 2025 13:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757795295; x=1758400095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vw2QA5kqG8WFKvdEvvdpb2LhLqBL+l569RZ+iJMB9YI=;
        b=T3F3NRPxNzxb5ZaS/Tx++vSD6+CEcHHH27Xlf0G5IGN2arPAEnHEJA7GvzHDsFbaAU
         MbK7E7jQxgDijYasffQ2YZTrA08q+puWvikEOBI+9a6kVf8TkJA01kb0ao2lx+uSxd14
         Cu4YtYHEkB9AUzMi0JtLfXwC/iGYkOCZgDaNtosHqlNCFRSOk3UMar+vQHfiYnmOJYDf
         gN4VH9NfmFj0dTbVmM4GG4hzWsJUFFcIYK3UBc5YtI8ZcMs26sND9ZV6+sUvgEXJfXR/
         +LEZOwGkGjF7muD3/L/9sWSljmntUNvdCXmrhY5iQUzNv7TCLLO7+66+NqtES+LyEqKA
         VsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757795295; x=1758400095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vw2QA5kqG8WFKvdEvvdpb2LhLqBL+l569RZ+iJMB9YI=;
        b=EFSrO/w0c61KQJ4P60d2/88U7HXgopqai5J256Bic15UWrSrUSdpuQjoawKvZbbtM9
         ixZKA8KLofJLJqdKIbtjsfvLq5o4FY6cNB5bkj04sPChp+rqDEG4l/b5R6hpH+XT3HXj
         UG5dFtr/iu0pm+FeNGo4QoJoe67HPRLGKf+nnLMqAeiXJYQQdXea97Bh94kwKl+LYZRl
         1yijJBhOP68hisDxwoojWME6Vz0xp1ocw+wqk6WCXpq5qQODciayew/f25xRBq5hqMQJ
         hzg/HzLrgtrkfNSMJG7hbkd2DIYa4XipNQEs/RJ9zek/S3h1QsazGYi6e2R0lO+wOIb7
         vwOQ==
X-Gm-Message-State: AOJu0Yzmedi7rUEvv/T5dRUy+RwTEnNxFCOecALdGTRSaW21/C3WhOFO
	2WogV6jI+PrGIh/7BMq7TWRd5Z3E3QyDJkUkkhBKL3lzRBejA+azYjJEOdnq/S+W
X-Gm-Gg: ASbGncswm8lEb0vVl47c7aVViLdnSvj4nzNnjx2LSviGbk3nug6TSOvlKpFouClv6gF
	C9gXmR8hKR4E/5dsJ8hnXSpquoZyIVe98PfSCuxG8mNfOJvfla2VN9B+p99e2lL6KfhFPXp8AwL
	uGXnAnsRHySr/RUWYX7cSNVPsz+mJTUQKPbqw7JySQdzhD99BvwOcG/NapFnAlFxXwJK0yZ85/M
	y8zpV7Oij4gMHv15VGtZuWLg+RxQETYs/L78neMYIHsmh+keqaqec04476Y4PW2g+5sCbwVdAI9
	XvQ7hoI+15GsiqVVAWRxMWaCPXPLNaoz+x4u4JWX524tJdjudN9+en1GHaKJ5lt2crhwV91sBKB
	3UJ3gcV/zyfRiRLldIgckVVHjKroz2T044a6dNI6pLf2iEorq6/8FVX2XTmpc
X-Google-Smtp-Source: AGHT+IFAPu/JZ40kYFS3afL8asJ65OVDz6Ou+VJixjxvWqrYQtkRLNF2P3uXotv1iqyBWW91yecA+g==
X-Received: by 2002:a17:907:97cb:b0:af9:a5f8:2f0c with SMTP id a640c23a62f3a-b07c35fb33amr666575666b.28.1757795295448;
        Sat, 13 Sep 2025 13:28:15 -0700 (PDT)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f1e26sm629095566b.77.2025.09.13.13.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 13:28:15 -0700 (PDT)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	j@w1.fi,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v3 wireless-next 2/2] wifi: mac80211: add support for VLAN-tagged EAPOL frames
Date: Sat, 13 Sep 2025 22:28:01 +0200
Message-ID: <20250913202801.448853-2-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250913202801.448853-1-janusz.dziedzic@gmail.com>
References: <20250913202801.448853-1-janusz.dziedzic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable transmission and reception of VLAN-tagged ctrl frames when
NL80211_ATTR_CONTROL_PORT_OVER_NL80211_VLAN is set. This allows mac80211
to handle tagged EAPOL frames.

Changes include:
- Add tagged EAPOL support flag to interface configuration
- Modify RX path to preserve VLAN tags on incoming EAPOL frames
- Update TX path to handle outgoing tagged EAPOL frames
- Initialize tagged EAPOL capability in driver setup

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 net/mac80211/cfg.c         |  3 ++
 net/mac80211/ieee80211_i.h |  3 ++
 net/mac80211/iface.c       |  2 ++
 net/mac80211/main.c        |  2 ++
 net/mac80211/rx.c          | 58 ++++++++++++++++++++++++++++++++++++--
 net/mac80211/tx.c          | 23 ++++++++++++---
 6 files changed, 85 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b26f61f13605..3a0e1193a211 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1517,6 +1517,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 				params->crypto.control_port_over_nl80211;
 	sdata->control_port_no_preauth =
 				params->crypto.control_port_no_preauth;
+	sdata->control_port_vlan_id = params->control_port_vlan_id;
 
 	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list) {
 		vlan->control_port_protocol =
@@ -1527,6 +1528,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 			params->crypto.control_port_over_nl80211;
 		vlan->control_port_no_preauth =
 			params->crypto.control_port_no_preauth;
+		vlan->control_port_vlan_id =
+			params->control_port_vlan_id;
 	}
 
 	link_conf->dtim_period = params->dtim_period;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 2c785ecf70f0..561d781c1ccb 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1160,6 +1160,7 @@ struct ieee80211_sub_if_data {
 	bool control_port_no_encrypt;
 	bool control_port_no_preauth;
 	bool control_port_over_nl80211;
+	u16 control_port_vlan_id;
 
 	atomic_t num_tx_queued;
 	struct mac80211_qos_map __rcu *qos_map;
@@ -1947,6 +1948,8 @@ void ieee80211_clear_fast_rx(struct sta_info *sta);
 
 bool ieee80211_is_our_addr(struct ieee80211_sub_if_data *sdata,
 			   const u8 *addr, int *out_link_id);
+bool ieee80211_is_vlan_control(struct ieee80211_sub_if_data *sdata,
+			       struct ethhdr *ehdr, u32 len);
 
 /* STA code */
 void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 07ba68f7cd81..d7a82d6593f1 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1298,6 +1298,8 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 			master->control_port_over_nl80211;
 		sdata->control_port_no_preauth =
 			master->control_port_no_preauth;
+		sdata->control_port_vlan_id =
+			master->control_port_vlan_id;
 		sdata->vif.cab_queue = master->vif.cab_queue;
 		memcpy(sdata->vif.hw_queue, master->vif.hw_queue,
 		       sizeof(sdata->vif.hw_queue));
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 437f1363c982..177120ba5763 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -884,6 +884,8 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 			      NL80211_EXT_FEATURE_CONTROL_PORT_NO_PREAUTH);
 	wiphy_ext_feature_set(wiphy,
 			      NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_TX_STATUS);
+	wiphy_ext_feature_set(wiphy,
+			      NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_VLAN);
 	wiphy_ext_feature_set(wiphy,
 			      NL80211_EXT_FEATURE_SCAN_FREQ_KHZ);
 	wiphy_ext_feature_set(wiphy,
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 4d4ff4d4917a..9f1222d3cd53 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -23,6 +23,7 @@
 #include <net/mac80211.h>
 #include <net/ieee80211_radiotap.h>
 #include <linux/unaligned.h>
+#include <linux/if_vlan.h>
 
 #include "ieee80211_i.h"
 #include "driver-ops.h"
@@ -114,6 +115,46 @@ static inline bool should_drop_frame(struct sk_buff *skb, int present_fcs_len,
 	return false;
 }
 
+bool ieee80211_is_vlan_control(struct ieee80211_sub_if_data *sdata,
+			       struct ethhdr *ehdr, u32 len)
+{
+	struct vlan_ethhdr *vhdr = (void *)ehdr;
+
+	if (!sdata->control_port_over_nl80211)
+		return false;
+	if (ehdr->h_proto != cpu_to_be16(ETH_P_8021Q))
+		return false;
+	if (len < sizeof(struct vlan_ethhdr))
+		return false;
+	if (vhdr->h_vlan_encapsulated_proto != sdata->control_port_protocol)
+		return false;
+
+	return true;
+}
+
+static bool ieee80211_vlan_control_allowed(struct ieee80211_rx_data *rx,
+					   struct ethhdr *ehdr, u32 len)
+{
+	struct vlan_ethhdr *vhdr = (void *)ehdr;
+	struct ieee80211_sub_if_data *sdata = rx->sdata;
+	u16 vlan_id;
+
+	if (!sdata->control_port_over_nl80211)
+		return false;
+
+	if (!sdata->control_port_vlan_id)
+		return false;
+
+	if (!ieee80211_is_vlan_control(sdata, ehdr, len))
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
@@ -2561,7 +2602,8 @@ __ieee80211_data_to_8023(struct ieee80211_rx_data *rx, bool *port_control)
 		return RX_DROP_U_INVALID_8023;
 
 	ehdr = (struct ethhdr *) rx->skb->data;
-	if (ehdr->h_proto == rx->sdata->control_port_protocol)
+	if (ehdr->h_proto == rx->sdata->control_port_protocol ||
+	    ieee80211_vlan_control_allowed(rx, ehdr, rx->skb->len))
 		*port_control = true;
 	else if (check_port_control)
 		return RX_DROP_U_NOT_PORT_CONTROL;
@@ -2612,7 +2654,8 @@ static bool ieee80211_frame_allowed(struct ieee80211_rx_data *rx, __le16 fc)
 	 * whether the frame was encrypted or not, and always disallow
 	 * all other destination addresses for them.
 	 */
-	if (unlikely(ehdr->h_proto == rx->sdata->control_port_protocol))
+	if (unlikely(ehdr->h_proto == rx->sdata->control_port_protocol ||
+		     ieee80211_vlan_control_allowed(rx, ehdr, rx->skb->len)))
 		return ieee80211_is_our_addr(rx->sdata, ehdr->h_dest, NULL) ||
 		       ether_addr_equal(ehdr->h_dest, pae_group_addr);
 
@@ -2636,6 +2679,17 @@ static void ieee80211_deliver_skb_to_local_stack(struct sk_buff *skb,
 		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 		bool noencrypt = !(status->flag & RX_FLAG_DECRYPTED);
 
+		cfg80211_rx_control_port(dev, skb, noencrypt, rx->link_id);
+		dev_kfree_skb(skb);
+	} else if (ieee80211_vlan_control_allowed(rx, (void *)skb_mac_header(skb),
+						  skb_tail_pointer(skb) - skb_mac_header(skb))) {
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
index 8e0221f68fa7..728fcee7c856 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2856,7 +2856,8 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 	if (unlikely(!ieee80211_vif_is_mesh(&sdata->vif) &&
 		     (sdata->vif.type != NL80211_IFTYPE_OCB) &&
 		     !multicast && !authorized &&
-		     (cpu_to_be16(ethertype) != sdata->control_port_protocol ||
+		     ((cpu_to_be16(ethertype) != sdata->control_port_protocol &&
+		       !ieee80211_is_vlan_control(sdata, (void *)skb->data, skb->len)) ||
 		      !ieee80211_is_our_addr(sdata, skb->data + ETH_ALEN, NULL)))) {
 #ifdef CONFIG_MAC80211_VERBOSE_DEBUG
 		net_info_ratelimited("%s: dropped frame to %pM (unauthorized port)\n",
@@ -6316,6 +6317,8 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
+	unsigned int hdrlen = sizeof(struct ethhdr);
+	struct vlan_hdr *vhdr;
 	struct sta_info *sta;
 	struct sk_buff *skb;
 	struct ethhdr *ehdr;
@@ -6343,17 +6346,29 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
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


