Return-Path: <linux-wireless+bounces-25512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5C9B06D3E
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 07:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F51050009E
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 05:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B96F2E6D2D;
	Wed, 16 Jul 2025 05:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="t4BC1SWw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838AB2E7BB2
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 05:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752644027; cv=none; b=KpNe2Dz6sFpTd1A8YNVS+G/JDK+D74VBz/ntJU37w+1MHrdBFhGv+9fhGcoN8ugSXRELGDsrLPU6g0ijCgpSG/n+0ZsUrnIrM3oScQrR0KcukpJ0uwJjiC65mVXskY9WjbWw1QiNQNrdhVUjnM1e76XgI08X6orWFAtKR4niyLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752644027; c=relaxed/simple;
	bh=rIWUwAzP4Qh9EozFaPTKy/JqyKPDOw+VUG+XjwZ4lhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbnZxQIo3SOqTYAdv6yXNBbt6Ko3GWQAY7qC3rsNNl+LRllGUiVPGUcwYaw777lOGIwzr0NQH6TDG64HPE/pjpyzgqihgSOmpDYVoJHq1yLWsZb2qWXWfvGdS1a74wSps1NDHkgUyOlKfmaigdgcHcoK642HzipVvDhNrIsWHZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=t4BC1SWw; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b271f3ae786so4694740a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 22:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1752644025; x=1753248825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqtVwZSeRCA6cHFdtdQSheaDrzGMyuYxXxg+/T7uhow=;
        b=t4BC1SWwSamLANU+e6T2sPp4yGNuyY5ibtU0SC0Mbj06WLvyehgNJUq0Du4dbEbuoH
         mLaotJdKQG2lsT2+Een04obUAsjwE6otiIp3RJTYDoDzzS2g5LjjmEef5S3PX+JcQQLB
         gPjWz0EfyCefetDe62aKKJMBrw6P79/D/RzJ2f2Gd65VUOKzzDWmrSeDJsqmCC8BIaJI
         DVZuh2DhRFLrXbvjEIZWju49Y97b3xqmOFKUEFXJfhRubMnGEonppBSQwjUyvpP0nXRV
         yhVi6HuMdUUeWQPZVDyvumwhzkLan5gqVnQ3uuvlzhXLMB/hE3itIo+8x3sMus6gGQCF
         4YyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752644025; x=1753248825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqtVwZSeRCA6cHFdtdQSheaDrzGMyuYxXxg+/T7uhow=;
        b=Xcnuc3hQdCb01ECC72qwQ4tTJh6pW8j2TUMHg35Fp3sQL2IVcnwm0nluQxpKg/Spho
         YvKeZtdi7GkpoKdLQ0Qk70XP3ZeygDfYFwASEZHV4hsj1REu4mD7CsiiIqPO+65U+IoH
         yG5IHZKPnTo6AQtazAr8f4xoJe49epq2CeO6L2mqB8q8nnaF2KEhc/A7F1Ak/Njrf9Np
         ID7cNm3ZWW1/3fkIRK4M2m3jdPwTT7/DCFmFYDuqwgODfa8UdlEpCgqqXtGFf/drgOnz
         xyZZsnbK7zDTstKTK7KRoZkvxdKEVRwb0wCzD//ge+vg7lLO+10PnuzhuwOHJFQvNbtO
         tGJA==
X-Gm-Message-State: AOJu0YxodGyN+tIOoXJdi45pY1enwQrnEfozUmJldcNPPmA8peUC0F5j
	Xlo7H/9ckqp36fpV+a3qoDh+mzc264jf7/jUFSWAad/K07RGYmfaMTab0l8j/gH2UfP7HJGH/wv
	L6mDuTfI=
X-Gm-Gg: ASbGncteXvBp1xiZ/MVPDgt0ba5YgWnfzURvKmqrNzNyOsSym3LWXeHE+tWzm5FiNdu
	IKXKfduTcIRw7QF8K1fD7LaY11XPxu+kJXm1jscCD8kEpIOZerMWK4tsVI0+XxNAoJzIohFSr04
	KO877i/h5DZBrZj1YDh/bAhMCdeqSsg0GOS3hQBOrHkWkfsLiwgi3CSNeHcLN+VDgOmXO5Z9xIt
	mLQ6JAJw2Aa/s9efJOLJpdB823X80h0xeWNh8DjkGhxjtWlgFft7ceReaoKjSVxzA/4C7J8felj
	IHzSwkfIWYa3U6ueT9zkFalPuJyMLHPtWxGCG1rFMUpDwMYEHlmDNzDaisBtkk3dMC8j9EOCpd5
	k3ZVGxHLBQ7kzC3HKmqevUY5EGV0S+YAxggTKafA=
X-Google-Smtp-Source: AGHT+IHa37psyQqOnrarFU7KoY7zq01ll3zaHYJiHFD1kLgWPMIeiKZHlVEOo/HyvvF0ITbKwbcN5w==
X-Received: by 2002:a17:90b:3f8d:b0:316:d69d:49fb with SMTP id 98e67ed59e1d1-31c9e70915amr3081625a91.14.1752644024632;
        Tue, 15 Jul 2025 22:33:44 -0700 (PDT)
Received: from mma-H9MHD44.lan ([101.180.88.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1ba792sm580382a91.5.2025.07.15.22.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 22:33:44 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [wireless-next v2 3/4] wifi: mac80211: support initialising current short beacon index
Date: Wed, 16 Jul 2025 15:32:53 +1000
Message-ID: <20250716053254.439698-4-lachlan.hodges@morsemicro.com>
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

Introduce the sb_count variable which tracks the number of
beacon intervals until the next long beacon. Similarly to the DTIM
count, initialise the current index into the long beacon period
using the current TSF. Utilise the same TSF value used to initialise
the DTIM count to ensure they are in sync as its common for the long
beacon period and DTIM period to be equal.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
v1 -> v2:

- Rely on existing beacon_int and dtim_period values rather then
  selecting the short variants (removed).

---
 net/mac80211/cfg.c            |  8 +++++++-
 net/mac80211/debugfs_netdev.c |  2 +-
 net/mac80211/ieee80211_i.h    |  6 +++---
 net/mac80211/mesh.c           |  2 +-
 net/mac80211/util.c           | 31 ++++++++++++++++++++++++++++---
 5 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index aeceac5747b6..8fb73952bf39 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1395,6 +1395,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_link_data *link;
 	struct ieee80211_bss_conf *link_conf;
 	struct ieee80211_chan_req chanreq = { .oper = params->chandef };
+	u64 tsf;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -1624,7 +1625,12 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		goto error;
 	}
 
-	ieee80211_recalc_dtim(local, sdata);
+	tsf = drv_get_tsf(local, sdata);
+	ieee80211_recalc_dtim(sdata, tsf);
+
+	if (link_conf->s1g_short_beaconing)
+		ieee80211_recalc_sb_count(sdata, tsf);
+
 	ieee80211_vif_cfg_change_notify(sdata, BSS_CHANGED_SSID);
 	ieee80211_link_info_change_notify(sdata, link, changed);
 
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 54c479910d05..1dac78271045 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -704,7 +704,7 @@ static ssize_t ieee80211_if_parse_tsf(
 		}
 	}
 
-	ieee80211_recalc_dtim(local, sdata);
+	ieee80211_recalc_dtim(sdata, drv_get_tsf(local, sdata));
 	return buflen;
 }
 IEEE80211_IF_FILE_RW(tsf);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 47b51c7eb09c..297ae35a1e79 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -314,6 +314,7 @@ struct ps_data {
 	atomic_t num_sta_ps; /* number of stations in PS mode */
 	int dtim_count;
 	bool dtim_bc_mc;
+	int sb_count; /* num short beacons til next long beacon */
 };
 
 struct ieee80211_if_ap {
@@ -2740,9 +2741,8 @@ void ieee80211_dfs_radar_detected_work(struct wiphy *wiphy,
 				       struct wiphy_work *work);
 int ieee80211_send_action_csa(struct ieee80211_sub_if_data *sdata,
 			      struct cfg80211_csa_settings *csa_settings);
-
-void ieee80211_recalc_dtim(struct ieee80211_local *local,
-			   struct ieee80211_sub_if_data *sdata);
+void ieee80211_recalc_sb_count(struct ieee80211_sub_if_data *sdata, u64 tsf);
+void ieee80211_recalc_dtim(struct ieee80211_sub_if_data *sdata, u64 tsf);
 int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 				 const struct cfg80211_chan_def *chandef,
 				 enum ieee80211_chanctx_mode chanmode,
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index d00d9d413c5c..a4a715f6f1c3 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1202,7 +1202,7 @@ int ieee80211_start_mesh(struct ieee80211_sub_if_data *sdata)
 		return -ENOMEM;
 	}
 
-	ieee80211_recalc_dtim(local, sdata);
+	ieee80211_recalc_dtim(sdata, drv_get_tsf(local, sdata));
 	ieee80211_link_info_change_notify(sdata, &sdata->deflink, changed);
 
 	netif_carrier_on(sdata->dev);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 0d85a382746f..d5dbfd37dd85 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3913,10 +3913,8 @@ int ieee80211_parse_p2p_noa(const struct ieee80211_p2p_noa_attr *attr,
 }
 EXPORT_SYMBOL(ieee80211_parse_p2p_noa);
 
-void ieee80211_recalc_dtim(struct ieee80211_local *local,
-			   struct ieee80211_sub_if_data *sdata)
+void ieee80211_recalc_dtim(struct ieee80211_sub_if_data *sdata, u64 tsf)
 {
-	u64 tsf = drv_get_tsf(local, sdata);
 	u64 dtim_count = 0;
 	u32 beacon_int = sdata->vif.bss_conf.beacon_int * 1024;
 	u8 dtim_period = sdata->vif.bss_conf.dtim_period;
@@ -3954,6 +3952,33 @@ void ieee80211_recalc_dtim(struct ieee80211_local *local,
 	ps->dtim_count = dtim_count;
 }
 
+/*
+ * Given a long beacon period, calculate the current index into
+ * that period to determine the number of TSBTTs until the next TBTT.
+ * It is completely valid to have a short beacon period that differs
+ * from the dtim period (i.e a TBTT thats not a DTIM).
+ */
+void ieee80211_recalc_sb_count(struct ieee80211_sub_if_data *sdata, u64 tsf)
+{
+	u32 sb_idx;
+	struct ps_data *ps = &sdata->bss->ps;
+	u16 lb_period = sdata->vif.bss_conf.s1g_long_beacon_period;
+	u32 beacon_int = sdata->vif.bss_conf.beacon_int * 1024;
+
+	/* No mesh / IBSS support for short beaconing */
+	if (tsf == -1ULL || !lb_period ||
+	    (sdata->vif.type != NL80211_IFTYPE_AP &&
+	     sdata->vif.type != NL80211_IFTYPE_AP_VLAN))
+		return;
+
+	/* find the current TSBTT index in our lb_period */
+	do_div(tsf, beacon_int);
+	sb_idx = do_div(tsf, lb_period);
+
+	/* num TSBTTs until the next TBTT */
+	ps->sb_count = sb_idx ? lb_period - sb_idx : 0;
+}
+
 static u8 ieee80211_chanctx_radar_detect(struct ieee80211_local *local,
 					 struct ieee80211_chanctx *ctx)
 {
-- 
2.43.0


