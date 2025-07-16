Return-Path: <linux-wireless+bounces-25513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBD6B06D3F
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 07:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0DB5001CB
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 05:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667302E7634;
	Wed, 16 Jul 2025 05:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="X33qzvLZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B362E7BA9
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 05:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752644030; cv=none; b=GS7BGRkB5DU2gpWj8fMJ6GbXyQlXP4G9LDbngUUJ9npVupG6f3YQgYrje/VtTLgvBy+kM6Ry3m0QtTw05jT4Ug0yv8jGOagOLrkAMulR1G4xc+SKJYfZwCOkAe6ZSsCPhbaiPrAjK2HJK57XdKiXMmS0TjqyNfGGmyuxiezxDxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752644030; c=relaxed/simple;
	bh=ePODAOINBVPi1dLzYiNrCY7n3yzwrTgi7JrVgCAB4i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIRiJoRHVszOhRkEEc1Cr1lQR1MZkpzCTHrURMOO9XnZnDXShqZQzl4xMZ4tHAC1Y6EvNRqAW/+nX8P+Q5OlU79HKDPsOjZuKSS31reft0CNiXOwn+dan4/30DMMwvM7iA42QzWWIEfg8s4kyJgro9WXzfn8sgpgKIMjgPzirZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=X33qzvLZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2350fc2591dso5230545ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 22:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1752644028; x=1753248828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1owtfS7EFiNYiyz3yGZbKzDjqZdfeO+pxLURPVkbAzM=;
        b=X33qzvLZ1bLamJ8F+vFHNf1/pZZ29JmzcRFXvtBoexEosssILLJzihVy6Ns96rXOvq
         Vm1+XIt4K+z1kbrwPDw2qTQ63U48c5hNgVpwltlwl9LnG2Fpyy12qASXQZrOTGpoub6I
         9p4zk+irtmKc8XMGZZ5w+IX2ObaAMMwZi3plLt1r9q1jUV/1w3Dmb8bsNpfb8PCnv9b6
         tUcUEpujPgdABaTWQ1xyWy5cakmPuPOQwZEh+/pGun2yIa/jdIzW3RctzsCOc10hrcBT
         OnSHBTCXvxHML1iaMAKPGd8rI22RxRzbrIZE3q4cFeX6Rxk1oMhvb/vavGZ6gIXJfRuF
         ocgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752644028; x=1753248828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1owtfS7EFiNYiyz3yGZbKzDjqZdfeO+pxLURPVkbAzM=;
        b=cnQ/ttl71wAMhg0ozNG6zLHNe2Dmtbjxuz71yAikM9zcQ9KsrIdDo1BsihXGLvgOqN
         wiDgtQDxb97GBHpDUqKc5RWP09WQjl6Rp+KsVz1idgq54iRSSJX/IiTmj9JF7GWBfuQT
         OLCPE1jCbD6ClfOZsC7QjDYLwwLl8JgsrYsAmgIos3ZQegm9LQVDVplwiotrYZpBNJIj
         nqoduuFb1Ws1GEYQnYxdT79lLa7+JeNq1/K0DTnzpI7ZOI9I93F63IiLqwY21Q4AbO6j
         M6WSbfush1t2usyh7qJaDv/P4R6Z9KgiuWpOt4nw42Q1kmCxY6RtUwAZjAEsPcbqNMod
         2NWA==
X-Gm-Message-State: AOJu0YzVp0ivS0Xj/ZCoycNyhMUMzP8HrQ9PKOP7Iqon/A6xORpMUDQX
	awcHv4E2zVuxo9i99Z5din7qidDok7tRgZlN3cxH1QIM9rBNuKzH4C7n7Y9vHfoMTqs=
X-Gm-Gg: ASbGncshg3wqajgGRKc3GxGKduDD1LzWkK8HyNlctxUB93X++TOzGAm/SNTZ/zYWktk
	3Ngv8XvYKh2W6ziNDvQA40p4jeP7EQ7XfZc24Qpp3kOmdVmPp1G9MJxk/5+q+wxWNfVmjgGYWQb
	71FdlxIbkFruOwbQlMzbbOnFq78CiEYMjIwBTbctZuVOIqS++6hDD5/p8NIJRm2PqhzXYgrNLGr
	ZzgqUxNN77LUTGVUsKMQZjABJ//xQU5EezdNr/1yNiWeywqkAABQVAza0lQA0+ZR5LWXMjYvhls
	kYLlQiIaxtcCb09Tj34UgdvmDbGgLJ6TaMRWDB++SnrtymKyAXH0mrW4LR5gFgKVJcZl0q1uc6n
	F3PfErGzPGEtPpo1zJLidrwG4gxPUzN+G5rx6GZMfHBItL8i5nw==
X-Google-Smtp-Source: AGHT+IFfpHkGoTdADDUUDdLSaYztHO0htQOdBQiPOVJBaMDY7XI0ZtV/Zq9thrMzou5/WMYaSCYG2g==
X-Received: by 2002:a17:903:230f:b0:232:609:86c9 with SMTP id d9443c01a7336-23e1a43ad9amr79791815ad.9.1752644027906;
        Tue, 15 Jul 2025 22:33:47 -0700 (PDT)
Received: from mma-H9MHD44.lan ([101.180.88.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1ba792sm580382a91.5.2025.07.15.22.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 22:33:47 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [wireless-next v2 4/4] wifi: mac80211: support returning the S1G short beacon skb
Date: Wed, 16 Jul 2025 15:32:54 +1000
Message-ID: <20250716053254.439698-5-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716053254.439698-1-lachlan.hodges@morsemicro.com>
References: <20250716053254.439698-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When short beaconing is enabled, check the value of the sb_count
to determine whether we are to send a long beacon or short beacon.
sb_count represents the number of short beacons until the next
long beacon, where if its value is 0 we are to send a long beacon.
The value is then reset to the long beacon period, which represents
the number of beacon intervals between each long beacon. The decrement
process follows the same cadence as the decrement of the DTIM count value.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
v1 -> v2:

- short_beacon_period -> long_beacon_period

---
 net/mac80211/tx.c | 104 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 93 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 6fa883a9250d..d59cf87c6d96 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5290,14 +5290,14 @@ ieee80211_beacon_add_mbssid(struct sk_buff *skb, struct beacon_data *beacon,
 }
 
 static struct sk_buff *
-ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
-			struct ieee80211_vif *vif,
-			struct ieee80211_link_data *link,
-			struct ieee80211_mutable_offsets *offs,
-			bool is_template,
-			struct beacon_data *beacon,
-			struct ieee80211_chanctx_conf *chanctx_conf,
-			u8 ema_index)
+__ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_link_data *link,
+			  struct ieee80211_mutable_offsets *offs,
+			  bool is_template,
+			  struct beacon_data *beacon,
+			  struct ieee80211_chanctx_conf *chanctx_conf,
+			  u8 ema_index)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
@@ -5358,6 +5358,80 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 	return skb;
 }
 
+static bool ieee80211_s1g_need_long_beacon(struct ieee80211_sub_if_data *sdata,
+					   struct ieee80211_link_data *link)
+{
+	struct ps_data *ps = &sdata->u.ap.ps;
+
+	if (ps->sb_count == 0)
+		ps->sb_count = link->conf->s1g_long_beacon_period - 1;
+	else
+		ps->sb_count--;
+
+	return ps->sb_count == 0;
+}
+
+static struct sk_buff *
+ieee80211_s1g_short_beacon_get(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif,
+			       struct ieee80211_link_data *link,
+			       struct ieee80211_chanctx_conf *chanctx_conf,
+			       struct s1g_short_beacon_data *sb,
+			       bool is_template)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	struct ieee80211_if_ap *ap = &sdata->u.ap;
+	struct sk_buff *skb;
+
+	skb = dev_alloc_skb(local->tx_headroom + sb->short_head_len +
+			    sb->short_tail_len + 256 +
+			    local->hw.extra_beacon_tailroom);
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, local->tx_headroom);
+	skb_put_data(skb, sb->short_head, sb->short_head_len);
+
+	ieee80211_beacon_add_tim(sdata, link, &ap->ps, skb, is_template);
+
+	if (sb->short_tail)
+		skb_put_data(skb, sb->short_tail, sb->short_tail_len);
+
+	ieee80211_beacon_get_finish(hw, vif, link, NULL, NULL, skb,
+				    chanctx_conf, 0);
+	return skb;
+}
+
+static struct sk_buff *
+ieee80211_beacon_get_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			struct ieee80211_link_data *link,
+			struct ieee80211_mutable_offsets *offs,
+			bool is_template, struct beacon_data *beacon,
+			struct ieee80211_chanctx_conf *chanctx_conf,
+			u8 ema_index, struct s1g_short_beacon_data *s1g_sb)
+{
+	struct sk_buff *skb = NULL;
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+
+	if (!vif->cfg.s1g || !link->conf->s1g_short_beaconing || !s1g_sb)
+		return __ieee80211_beacon_get_ap(hw, vif, link, offs,
+						 is_template, beacon,
+						 chanctx_conf, ema_index);
+
+	if (ieee80211_s1g_need_long_beacon(sdata, link)) {
+		skb = __ieee80211_beacon_get_ap(hw, vif, link, offs,
+						is_template, beacon,
+						chanctx_conf, ema_index);
+	} else {
+		skb = ieee80211_s1g_short_beacon_get(hw, vif, link,
+						     chanctx_conf, s1g_sb,
+						     is_template);
+	}
+
+	return skb;
+}
+
 static struct ieee80211_ema_beacons *
 ieee80211_beacon_get_ap_ema_list(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
@@ -5381,7 +5455,7 @@ ieee80211_beacon_get_ap_ema_list(struct ieee80211_hw *hw,
 			ieee80211_beacon_get_ap(hw, vif, link,
 						&ema->bcn[ema->cnt].offs,
 						is_template, beacon,
-						chanctx_conf, ema->cnt);
+						chanctx_conf, ema->cnt, NULL);
 		if (!ema->bcn[ema->cnt].skb)
 			break;
 	}
@@ -5410,6 +5484,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 	struct ieee80211_sub_if_data *sdata = NULL;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct ieee80211_link_data *link;
+	struct s1g_short_beacon_data *s1g_short_bcn = NULL;
 
 	rcu_read_lock();
 
@@ -5431,6 +5506,13 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		if (!beacon)
 			goto out;
 
+		if (vif->cfg.s1g && link->conf->s1g_short_beaconing) {
+			s1g_short_bcn =
+				rcu_dereference(link->u.ap.s1g_short_beacon);
+			if (!s1g_short_bcn)
+				goto out;
+		}
+
 		if (ema_beacons) {
 			*ema_beacons =
 				ieee80211_beacon_get_ap_ema_list(hw, vif, link,
@@ -5451,8 +5533,8 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 
 			skb = ieee80211_beacon_get_ap(hw, vif, link, offs,
 						      is_template, beacon,
-						      chanctx_conf,
-						      ema_index);
+						      chanctx_conf, ema_index,
+						      s1g_short_bcn);
 		}
 	} else if (sdata->vif.type == NL80211_IFTYPE_ADHOC) {
 		struct ieee80211_if_ibss *ifibss = &sdata->u.ibss;
-- 
2.43.0


