Return-Path: <linux-wireless+bounces-25588-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC80BB08737
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 09:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D3D172DBB
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 07:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E7425FA00;
	Thu, 17 Jul 2025 07:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="n+dA2YW8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B4C267F59
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 07:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738159; cv=none; b=FfUVS+nu+r7BTDywkxYXsLZW3jy7K/Zu4PpPHvlXymAt9KeX/JR2UenSIKzgP/K7w+jMvk++4Dihrd+vktvrapOVVC9YH9SMn++zXNTgWOj7SN1TqZq25SSYvnB9p/RtrejvcbNUwt9yQDOyRMTF02UiCzXSYyIHA/mmtwsY0Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738159; c=relaxed/simple;
	bh=lkuIIZTEipwt32lw1f/UDV5NmtKUmPKI3xC6p8L5C/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIwYbpZpXwQIE8g2K7U5EEqpK/OxXZv8qLrNnpnxg+hXWzfoR/XlXv2RByQ8UBV/4PiEB1/4lDms9hA27u+3gy+5V9zoV29pwUorJLuzm876++ODquVD1p4NsVgnsbVhKi/2Rkr5HDByVf2ZVeic9seERREWQvh8Ci+T78yI5As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=n+dA2YW8; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso433292b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 00:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1752738157; x=1753342957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0NptTkXT8MDnBD8JlNDxsBShtIbwPasCZUKpFu6qMA=;
        b=n+dA2YW8/slWRCCdXkdCagzHes1ziWKCxsPGVhZvBqN//+kcgPAoDEN1weQXN55g/g
         17jKFyPtPqyzn1FWNrvIiP9VSt9FwQTyq7tsXkSybq93nP1dszYmVmw8C2eS8th1zGfy
         wrqmpKbqLTX23uJ1IPbzXdjDOoenHLgeBsQbkL86T312L8lR+jEJHn4vXwuugBlEk8Z9
         vB4wSBq9+/Xw6EHggS+xX33/ADvyTsAM8snAZac+Hvq+nmL+ShMHgGqbPNlI+VIYbDZ+
         EX5A+8r7oHEskWpMkNP7SgwtDrjza3XfaBZBZugv612keQAbI8Nl73KZFDL0GiYaFHe1
         0DZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752738157; x=1753342957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0NptTkXT8MDnBD8JlNDxsBShtIbwPasCZUKpFu6qMA=;
        b=Rs7e7rJh7sKOYQNTgfQS4lonXJiA1RaK8ihM9OFGKT/p7Kcmo7DqzBITw6IpsZ/xTk
         6IO6DSUDcUYqea1d9tMkesKwUwErLZ0SZwWlm3HVJjA0XdqATf3o4vKC0TuK9QgmcPQQ
         Jt5hZm3sHjSd8eWx1ihcbPWBRRVz2gn0yjb3Gv7aRKmslLMkBmS6Zp0PUWiCGM88TDF2
         UHhcyUkOoSdyT0qhOb26hK/p0xywG68F8vCpaEFECk5zQD++Dol+2aFfcn/RXq6AlZYh
         V4dYm3vDEwcPjsLuh2Mwthuej3sm+Yn6qbzbqtWSO+KNXMDn7+NVdx2IM33jFqcJAwey
         KXHg==
X-Gm-Message-State: AOJu0YxYivRZTNjQr2KP+PwlSM3gTOTKvLl5rnB2yiQePiyFeYi1w4zD
	tEIakHIab1WX+6q5l4ubM8+b+WIIOBgOFAzZN8w4tsVm3KtOfyxAdKFLkpWSddELPzY=
X-Gm-Gg: ASbGncvL7pI6KdN3hwC7DErMC7JJosMCisndnDc8SMalse438kC8NqokBAzeSCVzaQw
	q3ZBVWPtNMzlXxDCRIwFon5rXPX3Nio7U7aZCM/obPCZZd3ddu+bkK+41PeznChghxkumd15h2f
	+hh4XnGHO9nnyBEgn7Oo5SmWr8WSqprFDLd0rscI0dL2LmF/ZA1/EMNDzjlH/GPDDLpIrUs8LJC
	mAHKC5w3jVfzfdWYAo5I4TUW3s9n1pH3VihOSJn7qjYKbspt1ameyH2IBnE9kmuaxkjN2A/yB1C
	wNvlmwsRwxvbQf+S3VlnxFdnfPs6itiDi74NYfqx4cLutfUVfIlU3BbKqzIONcPCICzOe+WNljM
	a8AZJv9RiZb5yUieQK1WdoVgZHpXsR3Y5N5WpOmqW6qwebvQwd3eOneOnIJ4+1JAz4qo/Gr0=
X-Google-Smtp-Source: AGHT+IGe7ww2fcJGur+KIm+JNC5R1WBF2ZmYaYiL+HGyiNteb017LxmSinpb494y4/FVxuzwmU797Q==
X-Received: by 2002:a05:6a00:2350:b0:742:a91d:b2f6 with SMTP id d2e1a72fcca58-7572466bc03mr7488757b3a.13.1752738156991;
        Thu, 17 Jul 2025 00:42:36 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e063b3sm16072550b3a.54.2025.07.17.00.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 00:42:36 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [wireless-next v3 4/4] wifi: mac80211: support returning the S1G short beacon skb
Date: Thu, 17 Jul 2025 17:42:05 +1000
Message-ID: <20250717074205.312577-5-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717074205.312577-1-lachlan.hodges@morsemicro.com>
References: <20250717074205.312577-1-lachlan.hodges@morsemicro.com>
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
v2 -> v3:

- Remove s1g_short_beconing reference (removed).
- Remove this check entirely as its performed in __ieee80211_beacon_get

---
 net/mac80211/tx.c | 95 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 84 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 6fa883a9250d..f3a065313a31 100644
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
@@ -5358,6 +5358,71 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
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
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+
+	if (!sdata->vif.cfg.s1g || !s1g_sb ||
+	    ieee80211_s1g_need_long_beacon(sdata, link))
+		return __ieee80211_beacon_get_ap(hw, vif, link, offs,
+						 is_template, beacon,
+						 chanctx_conf, ema_index);
+
+	return ieee80211_s1g_short_beacon_get(hw, vif, link, chanctx_conf,
+					      s1g_sb, is_template);
+}
+
 static struct ieee80211_ema_beacons *
 ieee80211_beacon_get_ap_ema_list(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
@@ -5381,7 +5446,7 @@ ieee80211_beacon_get_ap_ema_list(struct ieee80211_hw *hw,
 			ieee80211_beacon_get_ap(hw, vif, link,
 						&ema->bcn[ema->cnt].offs,
 						is_template, beacon,
-						chanctx_conf, ema->cnt);
+						chanctx_conf, ema->cnt, NULL);
 		if (!ema->bcn[ema->cnt].skb)
 			break;
 	}
@@ -5410,6 +5475,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 	struct ieee80211_sub_if_data *sdata = NULL;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct ieee80211_link_data *link;
+	struct s1g_short_beacon_data *s1g_short_bcn = NULL;
 
 	rcu_read_lock();
 
@@ -5431,6 +5497,13 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		if (!beacon)
 			goto out;
 
+		if (vif->cfg.s1g && link->u.ap.s1g_short_beacon) {
+			s1g_short_bcn =
+				rcu_dereference(link->u.ap.s1g_short_beacon);
+			if (!s1g_short_bcn)
+				goto out;
+		}
+
 		if (ema_beacons) {
 			*ema_beacons =
 				ieee80211_beacon_get_ap_ema_list(hw, vif, link,
@@ -5451,8 +5524,8 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 
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


