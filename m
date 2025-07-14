Return-Path: <linux-wireless+bounces-25353-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DC8B03581
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 07:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046983B6114
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 05:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8751F4701;
	Mon, 14 Jul 2025 05:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="bpLmGA+D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0541F19A
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 05:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752470086; cv=none; b=PwLZoE/07M+5lyWzmoejUFeG8FtgOokxOXwznuxhIEeSuM65VcgP8JdY6VaZ3HO980stXYCVWxsxC0lCcnHHcg4h52rAkm91GDzCnW6jQCvhtrZ8OTshKtQjlMQTtJZNcDPZHFdL7IQ2F+qoCgh8gsk/a7cDdlBp49xHgiLMUpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752470086; c=relaxed/simple;
	bh=7IOMmnOjW5qtARb+frNONAkthQ3Rq6JubCbVL/H1lrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpM/lowWFgj+cqI4doCPUjmsB/jHCVWIfxf92mJj49F3cXlHZtNuULZLropcqXGDZZ8B9lDOv2wwPygAPR7ug59MMQZi+5M1gj1uIzi/NYYA8BFPb6IzWu3D3bOpknu3fuYYw0EcB2WvfH2kcZyQ5zncVwgfdYZNhvxtsM4SjuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=bpLmGA+D; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so3685734a91.1
        for <linux-wireless@vger.kernel.org>; Sun, 13 Jul 2025 22:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1752470084; x=1753074884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvdxzJWBRoTpMKjP8SohkoxYVdR7q7FUC+tsVKXLAxU=;
        b=bpLmGA+Dv2zbGyBvq7BAALuSp1ma2ejSJADhramti/aiQgspcmRDdKlyMLF6IclLw7
         gBeTq105lg6mBFpnrZEA3RXTE7q8eyylUcn/MMl4KhBDG9NURhFolsmCO+m+Db7H9tgS
         F9spOYYVWkcs8uLiSKGO1m73Zsa8pjtfEt3j5OiDXw11MVxK4LZ0kM41DwMJqXIGeiG6
         YNeJ0dYQlaudz3j8/1GsAdRtbqFpKMhSUSElMv6pELsxp4wVkhdlowGhRwisMJB/IXte
         tIdKNN5NNn52pBapt7F8goYGBEslgdtXEge9jb/SmJZznBHV2ooAAJtGqNjtYXca+vUH
         AN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752470084; x=1753074884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvdxzJWBRoTpMKjP8SohkoxYVdR7q7FUC+tsVKXLAxU=;
        b=WEeMGjfKq0r7SMEeyNOEzBn0v/s0zYt6Rv0dhh1Vb6EptTGkYSpwcvSwmZrtKlag/7
         XeC1kDwgRL3YTdX0HVjLwDVf0sl4o0pPhV6Zm4+ZCnpmcUCN3Bd8vUy1W15HgwT5Ej5M
         KQn+Sr0BAnMP2LGE9Sqr/oJuiHdftf6DbAB4GvGeODzRP7E4hbz3/JAlBWSfc8rW8bW8
         M1csGQRhjHle9DXf859InZyWc/uEFRd5ROztDOt3DIK4PuTjtQW4eykpS1t0UNbu1F6j
         RBSt+mh29Izn4Tp0S/KS5gtAN85TpXGAp/eiu++zNJOxN1k7pUWYYrk6FcCj+BXY0N1p
         qdUg==
X-Gm-Message-State: AOJu0YymFLlDo9mEh8JZVSeigCBf4jLLrEBLf96NNcnAvPDnuDDG7CZw
	a1nrBzYWrd7Pu2Zll2PxhhbBpf3Ai2f9zcssmlB6DcCVHLKQXLQDvgyPDg7T4GhwxMk=
X-Gm-Gg: ASbGncve3uCxZMomAL9Do5sG058Ik7MAnKSFwhMNov9y4hoTCGufk4QJ9kEn8DKh6wZ
	ESC4mIMyLp7Bv6qpf9Tf6E13oRGANcj+Rgp0/z1OqhghyP3aT2nSBWZhxlleEjQJBIZPPF3x5Yj
	krCU7EB2qFe6TDJKUNkT4O34dEJ8jJcjl1IC7pAIuIWjPOGmceBoVrYwr8dHBU5IbaApb6UrPv4
	Qdwd+YhtNJhbJZasR7SnygSbouhSPez27x8CzGUdN9ebY0sKQ9w/k8zA6ZzZuQ0aYhy2QJfOEx8
	K+8zQS+ZXju6rpyLNUbcgWW/dn+crQuaseB47o2POgCIjDye8XDmewW1vkAWkl3GTz+SQQIf/0W
	O0w6ZVG/+l1zanNuOJLfvnimp9jJt1kh2QeS3EqRPrD5qO1Q760H18qd2SjHvUIvY1kP7bYKXQ8
	xKJC2hDQ==
X-Google-Smtp-Source: AGHT+IEaK+eIz8tbjG5bfCbrYYYBbH/VNJRTxYffwV2APcHS0/EZ/k0To9gXhxKR8YwrDyRur4wILw==
X-Received: by 2002:a17:90b:4cc5:b0:31c:404f:c14a with SMTP id 98e67ed59e1d1-31c4cd09cbemr15859765a91.29.1752470084419;
        Sun, 13 Jul 2025 22:14:44 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb61291sm9881930a91.34.2025.07.13.22.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 22:14:44 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [RFC 5/5] wifi: mac80211_hwsim: add S1G short beacon support
Date: Mon, 14 Jul 2025 15:14:03 +1000
Message-ID: <20250714051403.597090-6-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714051403.597090-1-lachlan.hodges@morsemicro.com>
References: <20250714051403.597090-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When short beaconing is enabled, correctly initialise the beacon
timer using the short beacon interval. Additionally, utilise the
correct short beaconing BSS configuration values when short beaconing
is enabled for an S1G BSS within mac80211_hwsim.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 109 ++++++++++++------
 1 file changed, 76 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index eefe8da3b14d..daeb7ff23384 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -655,6 +655,8 @@ static struct platform_driver mac80211_hwsim_driver = {
 struct mac80211_hwsim_link_data {
 	u32 link_id;
 	u64 beacon_int	/* beacon interval in us */;
+	bool s1g_short_beaconing; /* whether this link is short beaconing */
+	u64 s1g_short_beacon_int; /* S1G short beacon interval in us */
 	struct hrtimer beacon_timer;
 };
 
@@ -1226,15 +1228,18 @@ static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
 {
 	struct mac80211_hwsim_data *data = hw->priv;
 	u64 now = mac80211_hwsim_get_tsf(hw, vif);
-	/* MLD not supported here */
-	u32 bcn_int = data->link_data[0].beacon_int;
 	u64 delta = abs(tsf - now);
 	struct ieee80211_bss_conf *conf;
+	u32 bcn_int;
 
 	conf = link_conf_dereference_protected(vif, data->link_data[0].link_id);
-	if (conf && !conf->enable_beacon)
+	if (!conf || !conf->enable_beacon)
 		return;
 
+	/* MLD not supported here */
+	bcn_int = conf->s1g_short_beaconing ?
+			     data->link_data[0].s1g_short_beacon_int :
+			     data->link_data[0].beacon_int;
 	/* adjust after beaconing with new timestamp at old TBTT */
 	if (tsf > now) {
 		data->tsf_offset += delta;
@@ -2345,7 +2350,9 @@ mac80211_hwsim_beacon(struct hrtimer *timer)
 		container_of(link_data, struct mac80211_hwsim_data,
 			     link_data[link_data->link_id]);
 	struct ieee80211_hw *hw = data->hw;
-	u64 bcn_int = link_data->beacon_int;
+	u64 bcn_int = link_data->s1g_short_beaconing ?
+			      link_data->s1g_short_beacon_int :
+			      link_data->beacon_int;
 
 	if (!data->started)
 		return HRTIMER_NORESTART;
@@ -2449,11 +2456,14 @@ static int mac80211_hwsim_config(struct ieee80211_hw *hw, int radio_idx,
 		struct mac80211_hwsim_link_data *link_data =
 			&data->link_data[idx];
 
-		if (!data->started || !link_data->beacon_int) {
+		if (!data->started || (!link_data->beacon_int &&
+				       !link_data->s1g_short_beacon_int)) {
 			hrtimer_cancel(&link_data->beacon_timer);
 		} else if (!hrtimer_active(&link_data->beacon_timer)) {
 			u64 tsf = mac80211_hwsim_get_tsf(hw, NULL);
-			u32 bcn_int = link_data->beacon_int;
+			u32 bcn_int = link_data->s1g_short_beaconing ?
+					      link_data->s1g_short_beacon_int :
+					      link_data->beacon_int;
 			u64 until_tbtt = bcn_int - do_div(tsf, bcn_int);
 
 			hrtimer_start(&link_data->beacon_timer,
@@ -2520,6 +2530,55 @@ static void mac80211_hwsim_vif_info_changed(struct ieee80211_hw *hw,
 	}
 }
 
+static void
+mac80211_hwsim_link_change_beacon(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_bss_conf *info,
+				  struct mac80211_hwsim_link_data *link_data,
+				  struct mac80211_hwsim_data *data,
+				  struct hwsim_vif_priv *vp)
+{
+	u64 tsf, until_tbtt;
+	u32 bcn_interval_us;
+	bool short_beaconing = vif->cfg.s1g && info->s1g_short_beaconing;
+
+	vp->bcn_en = info->enable_beacon;
+	if (info->enable_beacon && data->started &&
+	    !hrtimer_active(&link_data->beacon_timer)) {
+		if (short_beaconing) {
+			link_data->s1g_short_beacon_int =
+				info->s1g_short_beacon_int * 1024;
+			bcn_interval_us = link_data->s1g_short_beacon_int;
+			link_data->s1g_short_beaconing = true;
+		} else {
+			link_data->beacon_int = info->beacon_int * 1024;
+			bcn_interval_us = link_data->beacon_int;
+		}
+
+		tsf = mac80211_hwsim_get_tsf(hw, vif);
+		until_tbtt = bcn_interval_us - do_div(tsf, bcn_interval_us);
+
+		hrtimer_start(&link_data->beacon_timer,
+			      ns_to_ktime(until_tbtt * NSEC_PER_USEC),
+			      HRTIMER_MODE_REL_SOFT);
+	} else if (!info->enable_beacon) {
+		unsigned int count = 0;
+
+		ieee80211_iterate_active_interfaces_atomic(
+			data->hw, IEEE80211_IFACE_ITER_NORMAL,
+			mac80211_hwsim_bcn_en_iter, &count);
+
+		wiphy_dbg(hw->wiphy, "  beaconing vifs remaining: %u", count);
+
+		if (count == 0) {
+			hrtimer_cancel(&link_data->beacon_timer);
+			link_data->beacon_int = 0;
+			link_data->s1g_short_beacon_int = 0;
+			link_data->s1g_short_beaconing = false;
+		}
+	}
+}
+
 static void mac80211_hwsim_link_info_changed(struct ieee80211_hw *hw,
 					     struct ieee80211_vif *vif,
 					     struct ieee80211_bss_conf *info,
@@ -2542,34 +2601,18 @@ static void mac80211_hwsim_link_info_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_BEACON_ENABLED) {
-		wiphy_dbg(hw->wiphy, "  BCN EN: %d (BI=%u)\n",
-			  info->enable_beacon, info->beacon_int);
-		vp->bcn_en = info->enable_beacon;
-		if (data->started &&
-		    !hrtimer_active(&link_data->beacon_timer) &&
-		    info->enable_beacon) {
-			u64 tsf, until_tbtt;
-			u32 bcn_int;
-			link_data->beacon_int = info->beacon_int * 1024;
-			tsf = mac80211_hwsim_get_tsf(hw, vif);
-			bcn_int = link_data->beacon_int;
-			until_tbtt = bcn_int - do_div(tsf, bcn_int);
-
-			hrtimer_start(&link_data->beacon_timer,
-				      ns_to_ktime(until_tbtt * NSEC_PER_USEC),
-				      HRTIMER_MODE_REL_SOFT);
-		} else if (!info->enable_beacon) {
-			unsigned int count = 0;
-			ieee80211_iterate_active_interfaces_atomic(
-				data->hw, IEEE80211_IFACE_ITER_NORMAL,
-				mac80211_hwsim_bcn_en_iter, &count);
-			wiphy_dbg(hw->wiphy, "  beaconing vifs remaining: %u",
-				  count);
-			if (count == 0) {
-				hrtimer_cancel(&link_data->beacon_timer);
-				link_data->beacon_int = 0;
-			}
+		if (info->s1g_short_beaconing) {
+			wiphy_dbg(hw->wiphy,
+				  "  SHORT BCN EN: %d (BI=%u, SBI=%u)\n",
+				  info->enable_beacon, info->beacon_int,
+				  info->s1g_short_beacon_int);
+		} else {
+			wiphy_dbg(hw->wiphy, "  BCN EN: %d (BI=%u)\n",
+				  info->enable_beacon, info->beacon_int);
 		}
+
+		mac80211_hwsim_link_change_beacon(hw, vif, info, link_data,
+						  data, vp);
 	}
 
 	if (changed & BSS_CHANGED_ERP_CTS_PROT) {
-- 
2.43.0


