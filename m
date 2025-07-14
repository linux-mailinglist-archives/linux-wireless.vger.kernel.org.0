Return-Path: <linux-wireless+bounces-25351-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A74BB0357F
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 07:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F390168391
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 05:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4F61F541E;
	Mon, 14 Jul 2025 05:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="mer1ZXTe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603B61F19A
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 05:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752470079; cv=none; b=avkc3jSKrVij9+4c7N5dftgxmYxWvuaUCOP12BxxSSl/uTuTQh81b2wqBAzfKtCZGtTpVMs8ya821QvSRqipTBURbFMlJzzA9CqFT/x9GXGP+5c4O7ZcVYQrW8O1osvmeL+aJfkcFicW793aqj2krBLjZm1HFZpPEaug1/hndj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752470079; c=relaxed/simple;
	bh=XEzoX3+hh7gk99kXoS5lk33/BoaJpmtnSbCHcVETlQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wm29IMrbAQ549kSE6JMIuDKsrsq+1XSMat8ILQ0QBy2L/D7CEBhlyKDKPtMypiLyHah5DURFCxUfSlb4RHKSPdrho/eolfqSB6G9ngYoR8Xz0JH1GyRUbcIoaoMHTOMQRwcZTVhqI1SmdKpnpCdKSmVBYZ44VkTXdyfPW2hrhWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=mer1ZXTe; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso3154207a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 13 Jul 2025 22:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1752470076; x=1753074876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EeGSu2rp0klK9/8BD2RxRJn89ygrDZwHwC+GtQINe0=;
        b=mer1ZXTeNNYoRlctIwdTEkrN2QMdl8ALp5hyg9EDPt9nSyRbVtoKofMoviQl0/hvJh
         SivZMYNzimEx6LIqOsplsOkHCUmzfvvC74M7hVajuYoWJyhL+jWBUXA5OgaBFW7ldKTp
         YrQmbTZYYzz6qHJFb9u6jmMK0hbQDNKdcCwsXVLVFjyb/vJABCUrvmKlSOvJZh5mX2VF
         o0ittXYhZo10VoxJmPXLonLODpnvhvpuacBtPTvTXBkuMSoAIw5trLs93lI/A37mbXLe
         ix8G6wGDAtsZkfkBa8Z0stJHMq1nRu3vuwIHPNKswa+BjHwmKHk8oLXu2ZNp4QWyld5x
         YEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752470076; x=1753074876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EeGSu2rp0klK9/8BD2RxRJn89ygrDZwHwC+GtQINe0=;
        b=Vu0rOh8KCIimCJ6dMvk5NlVyEI496BY75na+yyxTyNJoZAIo8/fb70xhQDJdySzCuP
         SNyLG89OvBP4tBGrLpunS02cJX61BjO8RW4XAo2T98O4tC/yHaTTe+AAFysTD2kOpweh
         oRym05pbFmrfenvib8oDlcBKtxXqhdw07EIhtmhaLblf1KpKzIKtvJplFeIE1ksQx4sd
         2gCX8ZJHc+uUGAepWvbQRLpKIcxrTdIxXOA8bpqTgWj/DrdrqLfS2+X6lDafxqt16Hpz
         0s1zh57B0fvX4nVwnNvifcqH8cMcG2PNj7sZvQMPnefeRli2WZThawSPtjthHaDV9Jyu
         w1KQ==
X-Gm-Message-State: AOJu0YxwfwyURpearsPjKqaLawR/kXjsUNii1B3idoYXgGJF7GcJI60t
	4yOoMvJdQ0cj1u0uyzlm968bRLE3x0acFhXKUy+MlMmR6hWKuxtld+GKUGrXMCP/twA=
X-Gm-Gg: ASbGncv08DhLvXBdaOWH80k2WQjpu2Oe73r90l5kiGaREIMCdkuM2bpo88LmMOTeOmO
	CM8inA8J4+vootqzYfI0Z+zzo9NQWtUB0KC5CYnFfGxu+mW7KG0fbQ/LeErthcQllL4Lt9utCoI
	V9wKwnhgHzgfLVcTS/DVarSTymBmI9OAufzQuyaXRvPZc28jlhM+FD9bHiM7j++fKLnB9Wjng/0
	qg0IYocb1gz79Rx3z5RLVab4bWumyQG5TpmTlgUwthzzKVx38KQW/X00i15u6CzUDCRTj2+RIKn
	wSJdLAYj+Edl5Rhenw/hUYbwOTgyNTL3qirlN2vC+4jiPddP1n0a5KsjtkYlLJRwC4Ad98Lyii6
	42NtIBj2AsAWef02Ob3K5O0zpPIUYvL7rX7525k6rurtDsl7ErkVH/W+1X35uk/j3ASzWrJ0=
X-Google-Smtp-Source: AGHT+IHpQy2zDaGzF8clSOOA45WwPahelqM5Zdv6H0fJSBA+8cQFuh9GXZ5JjoLufaSe3ytCWjjzoQ==
X-Received: by 2002:a17:90a:fc44:b0:311:fde5:c4be with SMTP id 98e67ed59e1d1-31c4cd158bamr16339658a91.35.1752470076519;
        Sun, 13 Jul 2025 22:14:36 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb61291sm9881930a91.34.2025.07.13.22.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 22:14:36 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [RFC 3/5] wifi: mac80211: configure power save for an S1G short beaconing BSS
Date: Mon, 14 Jul 2025 15:14:01 +1000
Message-ID: <20250714051403.597090-4-lachlan.hodges@morsemicro.com>
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

Configure the short beacon count and DTIM count using the
s1g_short_beacon_int and s1g_short_beacon_dtim_period values
when short beaconing is enabled as per:

(1) IEEE80211-2024 9.4.2.5.1 for the short beacon interval
(2) IEEE80211-2024 11.1.2.1 for the short beacon DTIM period

The short beacon count represents the number of short beacons
that will be sent until the next long beacon. This is stored
in the struct ps_data as it is fundamentally a power save
feature.

In addition, use the short beacon variants rather then the
traditional variants. Also initialise the short beacon count
using the same TSF value to ensure they are in sync at
initilisation. The DTIM count and short beacon count are initialised
separately as it is perfectly valid to have a short beacon period
that differs from the short beacon dtim period.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 net/mac80211/cfg.c            |  8 +++++-
 net/mac80211/debugfs_netdev.c |  2 +-
 net/mac80211/ieee80211_i.h    |  6 ++---
 net/mac80211/mesh.c           |  2 +-
 net/mac80211/tx.c             | 11 ++++++--
 net/mac80211/util.c           | 50 +++++++++++++++++++++++++++++++----
 6 files changed, 66 insertions(+), 13 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d955bf8a6654..4f6755244030 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1395,6 +1395,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_link_data *link;
 	struct ieee80211_bss_conf *link_conf;
 	struct ieee80211_chan_req chanreq = { .oper = params->chandef };
+	u64 tsf;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -1653,7 +1654,12 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
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
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 6fa883a9250d..4c457b715b22 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4881,6 +4881,13 @@ static void __ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
 	int aid0 = 0;
 	int i, have_bits = 0, n1, n2;
 	struct ieee80211_bss_conf *link_conf = link->conf;
+	/*
+	 * via IEEE80211-2024 11.1.3.10.2 if we are short beaconing,
+	 * use dot11ShortBeaconDTIMPeriod, else use dot11DTIMPeriod.
+	 */
+	u8 dtim_period = link_conf->s1g_short_beaconing ?
+			      link_conf->s1g_short_beacon_dtim_period :
+			      link_conf->dtim_period;
 
 	/* Generate bitmap for TIM only if there are any STAs in power save
 	 * mode. */
@@ -4891,7 +4898,7 @@ static void __ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
 					  IEEE80211_MAX_AID+1);
 	if (!is_template) {
 		if (ps->dtim_count == 0)
-			ps->dtim_count = link_conf->dtim_period - 1;
+			ps->dtim_count = dtim_period - 1;
 		else
 			ps->dtim_count--;
 	}
@@ -4900,7 +4907,7 @@ static void __ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
 	*pos++ = WLAN_EID_TIM;
 	*pos++ = 3;
 	*pos++ = ps->dtim_count;
-	*pos++ = link_conf->dtim_period;
+	*pos++ = dtim_period;
 
 	if (ps->dtim_count == 0 && !skb_queue_empty(&ps->bc_buf))
 		aid0 = 1;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 0d85a382746f..47e86461c209 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3913,15 +3913,28 @@ int ieee80211_parse_p2p_noa(const struct ieee80211_p2p_noa_attr *attr,
 }
 EXPORT_SYMBOL(ieee80211_parse_p2p_noa);
 
-void ieee80211_recalc_dtim(struct ieee80211_local *local,
-			   struct ieee80211_sub_if_data *sdata)
+void ieee80211_recalc_dtim(struct ieee80211_sub_if_data *sdata, u64 tsf)
 {
-	u64 tsf = drv_get_tsf(local, sdata);
 	u64 dtim_count = 0;
-	u32 beacon_int = sdata->vif.bss_conf.beacon_int * 1024;
-	u8 dtim_period = sdata->vif.bss_conf.dtim_period;
 	struct ps_data *ps;
 	u8 bcns_from_dtim;
+	bool short_beaconing = sdata->vif.bss_conf.s1g_short_beaconing;
+	/*
+	 * When short beaconing, ensure we use the short beacon interval
+	 * as opposed to the beacon interval as per IEEE80211-2024 11.1.2.1.
+	 */
+	u32 beacon_int = (short_beaconing ?
+				  sdata->vif.bss_conf.s1g_short_beacon_int :
+				  sdata->vif.bss_conf.beacon_int) * 1024;
+	/*
+	 * When short beaconing, all DTIM calculations are made using the
+	 * dot11ShortBeaconDTIMPeriod value and the dot11DTIMPeriod value
+	 * is unused as per IEEE80211-2024 9.4.2.5.1.
+	 */
+	u8 dtim_period =
+		short_beaconing ?
+			sdata->vif.bss_conf.s1g_short_beacon_dtim_period :
+			sdata->vif.bss_conf.dtim_period;
 
 	if (tsf == -1ULL || !beacon_int || !dtim_period)
 		return;
@@ -3954,6 +3967,33 @@ void ieee80211_recalc_dtim(struct ieee80211_local *local,
 	ps->dtim_count = dtim_count;
 }
 
+/*
+ * Given a short beacon period, calculate the current index into
+ * that period to determine the number of TSBTTs until the next TBTT.
+ * It is completely valid to have a short beacon period that differs
+ * from the dtim period (i.e a TBTT thats not a DTIM).
+ */
+void ieee80211_recalc_sb_count(struct ieee80211_sub_if_data *sdata, u64 tsf)
+{
+	u32 sb_idx;
+	struct ps_data *ps = &sdata->bss->ps;
+	u16 sb_period = sdata->vif.bss_conf.s1g_short_beacon_period;
+	u32 beacon_int = sdata->vif.bss_conf.s1g_short_beacon_int * 1024;
+
+	/* No mesh / IBSS support for short beaconing */
+	if (tsf == -1ULL || !sb_period ||
+	    (sdata->vif.type != NL80211_IFTYPE_AP &&
+	     sdata->vif.type != NL80211_IFTYPE_AP_VLAN))
+		return;
+
+	/* find the current TSBTT index in our sb_period */
+	do_div(tsf, beacon_int);
+	sb_idx = do_div(tsf, sb_period);
+
+	/* num TSBTTs until the next TBTT */
+	ps->sb_count = sb_idx ? sb_period - sb_idx : 0;
+}
+
 static u8 ieee80211_chanctx_radar_detect(struct ieee80211_local *local,
 					 struct ieee80211_chanctx *ctx)
 {
-- 
2.43.0


