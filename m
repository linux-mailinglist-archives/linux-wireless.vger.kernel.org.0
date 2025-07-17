Return-Path: <linux-wireless+bounces-25587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 914D0B08733
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 09:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F1C4E0715
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 07:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B429C25D546;
	Thu, 17 Jul 2025 07:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="FD8YFqaa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F203D25B31B
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 07:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738156; cv=none; b=XgwdD7G2Dh4eCSbP2mLYI3TxaNuMtU644HD5vMHcYU72xoGWtSswooKz5FTxrMP7Z9+w6xOTD6/gZci1DyACcMNb15XP/to1OQuhJwdBqshiMX2KNMHRmopt97gkMLhxq4oS6THoB1cT7NkEj/tmkKHqq3GbWPlmJzvKcl6VfcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738156; c=relaxed/simple;
	bh=g9PS0JUZtQ9p5/X3xVTxGDpJEwuYhAuYtEfki3ubPMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qX4wURCMMdR9UYNpUNvbri2NHLYrY0Tku3FxpgRcCoXPYCNihEJbU2V5uxp9uLTCSMMMyD5Jz1E8No3BubD+zo4CVFjh+qTG3OY1TRh4UO/4hXvnIu9jd0IA2LNID1S71LFUPpsmE+ayjgXW61+jVXCuBfsWuhIzY+3Ad7aqNGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=FD8YFqaa; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so737403b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 00:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1752738154; x=1753342954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sX4WnI6I3xND5CzpZ62Uuh7K1jyhCF4Ndy5nJ44qr7A=;
        b=FD8YFqaam3mYj4UKsmLsfJAMbgvvezI2fhC61vmC5WVj/jYIlqDsItPf83/lnlp3n1
         743XfYi9PtF3laB38ajV19bVCBEQVxSuFJxqj8Tqo57Is+Npxp8Zvy+cepj41G8HEuk1
         h09RcEmq5Em3cxjEiQ69rrXV+DiGA2POMslb3Nf5XcHfRvBISOAATq6gw4+GQDLzWTtW
         D5CGLWGdAeYnHDRtoR54uFh/8mSiqx12NoosqOTaKiuENVe9OAQ3wIm1OnZl012iGyjm
         1RlTjtLaSh4ZyUxddQssuIofHe2GXBkhaJiTngn+kgZxV+CLzihl/46agy+DLNsv3WHh
         Q2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752738154; x=1753342954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sX4WnI6I3xND5CzpZ62Uuh7K1jyhCF4Ndy5nJ44qr7A=;
        b=u+70lKR7f/RkZPs6gyCPweTyVgZ7sfhPhjmZoYU4X0riJR+X9GxwrHWuwOnXy+ewWY
         z/W2aRevkd3Qz8sRlD+9b3e0aZnXoT3rVYaC5I7lbQfd4PTh5tGLuWM9v/17QX1x/Xsz
         EYaRpYZMrYw8FDcXwOqY6Bo9BdC2udInXBM65xNPnArEk0J7tUPQ0GkGk9hfWCNFKo01
         In4GLTwAB3JGsmce+L3QPnQpX43BRC2UNrCVVOmVWy++GTil+2UNggNSI3LY1jCK+o5+
         VZwldZ37mp0F51QrnyDSNrAZ8Ysg1g1sFaS9koBcK0SxMwEyfwwOB/4yWJiJHNDe/NIi
         kkBA==
X-Gm-Message-State: AOJu0YxC2Giod07edxLowbFVpSllOvqzoelZeHorbdWpvkg7jZUaVbeZ
	TaHT8sIne20ugJ+Gn/Hh0ELy+y6vTbOtoNGlEChQ0xxBZbN5W94JF7wrbJonem5Eaj8=
X-Gm-Gg: ASbGnctgTsFkJeoUQOOYNFW1c+BQPdRKuXa4ghkBKp8rDnVAvMUiYNqXMbNn9/L97NC
	QRlgnWB7BY9zBzGvZ4AsNe2a6M7OLkO4S5eDVHp7ZqIMnBcG/7w218XOXhJVhpa2S4bR36MWoOJ
	mBJ/cazlD+kxypvfPRrTdtCDtj3BCDML5dTqwphOWqItfVzJrKzyJL/YyIdJEU3IHj+57z37NSt
	rlzlWfH9XHv9616nll5Dly+01+u76LGbL5tPAH4kAtRnnwCt3lTol25SgPaIGUF/+k3uMq+opxQ
	CVK6D2A+/hQJ2jo7Zlr4DjRIw/8IZsy/6UOTb31JzbxfphBC5QuC3WHw+il5BFez4WZQ6YKmPK+
	hm4Itvazye6KU9IhQPF7iaGwIoT95vMviqJ21cMTX+96M4hIhEZX7FYaGu1g3HUawCvAQCfA=
X-Google-Smtp-Source: AGHT+IHETTDxqi8gBalOTgu/fLq0vN1vy3FjkMi0ObLgXWzOzmuk1rdhU2cn96uFcZGMIyyL4wv9zQ==
X-Received: by 2002:a05:6a00:4c0a:b0:736:9f2e:1357 with SMTP id d2e1a72fcca58-75838074036mr3427502b3a.12.1752738153616;
        Thu, 17 Jul 2025 00:42:33 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e063b3sm16072550b3a.54.2025.07.17.00.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 00:42:33 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [wireless-next v3 3/4] wifi: mac80211: support initialising current S1G short beacon index
Date: Thu, 17 Jul 2025 17:42:04 +1000
Message-ID: <20250717074205.312577-4-lachlan.hodges@morsemicro.com>
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

Introduce the sb_count variable which tracks the number of
beacon intervals until the next long beacon. To initialise this
value, we find the current short beacon index into this period
which represents the number of short beacons left to send before
the next long beacon. We use the same TSF value used to initialise
the DTIM count to ensure the short beacon count and DTIM count
are in sync as its common for the long beacon period and DTIM period
to be equivalent.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
v2 -> v3:

- Use link->u.ap.s1g_short_beacon rather then s1g_short_beaconing
  (removed).

---
 net/mac80211/cfg.c            |  8 +++++++-
 net/mac80211/debugfs_netdev.c |  2 +-
 net/mac80211/ieee80211_i.h    |  6 +++---
 net/mac80211/mesh.c           |  2 +-
 net/mac80211/util.c           | 31 ++++++++++++++++++++++++++++---
 5 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 2b5c6318697f..cf77b2639ee1 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1382,6 +1382,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_link_data *link;
 	struct ieee80211_bss_conf *link_conf;
 	struct ieee80211_chan_req chanreq = { .oper = params->chandef };
+	u64 tsf;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -1603,7 +1604,12 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		goto error;
 	}
 
-	ieee80211_recalc_dtim(local, sdata);
+	tsf = drv_get_tsf(local, sdata);
+	ieee80211_recalc_dtim(sdata, tsf);
+
+	if (link->u.ap.s1g_short_beacon)
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
index 0d85a382746f..32f1bc5908c5 100644
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
+	u8 lb_period = sdata->vif.bss_conf.s1g_long_beacon_period;
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


