Return-Path: <linux-wireless+bounces-21135-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEB7A7A9A2
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 20:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB19166A68
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 18:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341C8253334;
	Thu,  3 Apr 2025 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="iXR2sCOq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D91D2512D0
	for <linux-wireless@vger.kernel.org>; Thu,  3 Apr 2025 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743705593; cv=none; b=uzH4Nocnbj5I/zSDbEf7GZbAJcTay7PkuinuvRrekOmX+KK6LsjHzip9C4Wrvb8i2+RQvetidWQlG4FWin4BU1QRfw7umo79wEa4ZArTrk0clo5Q6j6NHUxiRJUqLvYDN1IEgudg02JkJyIjF61geLJDBUPEqqn/O8HKg35mZ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743705593; c=relaxed/simple;
	bh=IkGyPJwRtQD9jkm9OH2lsvhlOaVyX4qrz/r4yRsyj3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sl5PzKbsGc2g9yujJygUYJq5iAh5Nc++hnhZMDms9uCZsKzWwgqAjrFzr1k16rqGqf4zKg7Y9DEwHJ/KSgY6IhJnBkkPR/RU6OYbPdzdKADqr4n9ApYmhdZUlmB1TIGIcqhtqTrpn6H/G3T3W8uABghRX/UGfpk9Es6wxg7r88o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=iXR2sCOq; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1743705577; bh=IkGyPJwRtQD9jkm9OH2lsvhlOaVyX4qrz/r4yRsyj3I=;
	h=From:To:Cc:Subject:Date:From;
	b=iXR2sCOqiB1CuHFkPPZznb8rexR4lWqPK1EDrEzicHP+WfCXp8VOESTQLVTkIJ6bh
	 9Qul1044Yfts28+LeMzWyo+zqZvFMMyuzPbSYGBM9ZgH4jju8hEYoeIIhnOWTG/I08
	 vFtZNcf/FlA8TAbV56fUTb9Nx48m5lmUWVEZopE4gWJ/CeJgz0hKKJxuMAHHGfR1g+
	 5T0nIONXAyttCz1Q2ryg6vhcaa8fZxqOeKS9MmjZN4I1ihdeMKkzZVGfHYaIbGir5j
	 BedKNNMC/1o+wtGrEs8x1f2OeUdh+99/zDOjEELyJ0D0ZDFXgjmool7LMNVrn9Qn1o
	 VNmGtxIjPl5QA==
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Subject: [PATCH wireless-next] Revert "mac80211: Dynamically set CoDel parameters per station"
Date: Thu,  3 Apr 2025 20:39:28 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <20250403183930.197716-1-toke@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This reverts commit 484a54c2e597dbc4ace79c1687022282905afba0. The CoDel
parameter change essentially disables CoDel on slow stations, with some
questionable assumptions, as Dave pointed out in [0]. Quoting from
there:

  But here are my pithy comments as to why this part of mac80211 is so
  wrong...

   static void sta_update_codel_params(struct sta_info *sta, u32 thr)
   {
  -       if (thr && thr < STA_SLOW_THRESHOLD * sta->local->num_sta) {

  1) sta->local->num_sta is the number of associated, rather than
  active, stations. "Active" stations in the last 50ms or so, might have
  been a better thing to use, but as most people have far more than that
  associated, we end up with really lousy codel parameters, all the
  time. Mistake numero uno!

  2) The STA_SLOW_THRESHOLD was completely arbitrary in 2016.

  -               sta->cparams.target = MS2TIME(50);

  This, by itself, was probably not too bad. 30ms might have been
  better, at the time, when we were battling powersave etc, but 20ms was
  enough, really, to cover most scenarios, even where we had low rate
  2Ghz multicast to cope with. Even then, codel has a hard time finding
  any sane drop rate at all, with a target this high.

  -               sta->cparams.interval = MS2TIME(300);

  But this was horrible, a total mistake, that is leading to codel being
  completely ineffective in almost any scenario on clients or APS.
  100ms, even 80ms, here, would be vastly better than this insanity. I'm
  seeing 5+seconds of delay accumulated in a bunch of otherwise happily
  fq-ing APs....

  100ms of observed jitter during a flow is enough. Certainly (in 2016)
  there were interactions with powersave that I did not understand, and
  still don't, but if you are transmitting in the first place, powersave
  shouldn't be a problemmmm.....

  -               sta->cparams.ecn = false;

  At the time we were pretty nervous about ecn, I'm kind of sanguine
  about it now, and reliably indicating ecn seems better than turning it
  off for any reason.

  [...]

  In production, on p2p wireless, I've had 8ms and 80ms for target and
  interval for years now, and it works great.

I think Dave's arguments above are basically sound on the face of it,
and various experimentation with tighter CoDel parameters in the OpenWrt
community have show promising results[1]. So I don't think there's any
reason to keep this parameter fiddling; hence this revert.

[0] https://lore.kernel.org/linux-wireless/CAA93jw6NJ2cmLmMauz0xAgC2MGbBq6n0ZiZzAdkK0u4b+O2yXg@mail.gmail.com/
[1] https://forum.openwrt.org/t/reducing-multiplexing-latencies-still-further-in-wifi/133605/130

Suggested-By: Dave Taht <dave.taht@gmail.com>
In-memory-of: Dave Taht <dave.taht@gmail.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
---
 include/net/mac80211.h     | 16 ----------------
 net/mac80211/debugfs_sta.c |  6 ------
 net/mac80211/rate.c        |  3 +--
 net/mac80211/sta_info.c    | 28 ----------------------------
 net/mac80211/sta_info.h    | 11 -----------
 net/mac80211/tx.c          |  9 +--------
 6 files changed, 2 insertions(+), 71 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c498f685d01f..5349df596157 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5346,22 +5346,6 @@ void ieee80211_get_tx_rates(struct ieee80211_vif *vif,
 			    struct ieee80211_tx_rate *dest,
 			    int max_rates);
 
-/**
- * ieee80211_sta_set_expected_throughput - set the expected tpt for a station
- *
- * Call this function to notify mac80211 about a change in expected throughput
- * to a station. A driver for a device that does rate control in firmware can
- * call this function when the expected throughput estimate towards a station
- * changes. The information is used to tune the CoDel AQM applied to traffic
- * going towards that station (which can otherwise be too aggressive and cause
- * slow stations to starve).
- *
- * @pubsta: the station to set throughput for.
- * @thr: the current expected throughput in kbps.
- */
-void ieee80211_sta_set_expected_throughput(struct ieee80211_sta *pubsta,
-					   u32 thr);
-
 /**
  * ieee80211_tx_rate_update - transmit rate update callback
  *
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index a67a9d316008..06376e1a1fcf 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -150,12 +150,6 @@ static ssize_t sta_aqm_read(struct file *file, char __user *userbuf,
 	spin_lock_bh(&local->fq.lock);
 	rcu_read_lock();
 
-	p += scnprintf(p,
-		       bufsz + buf - p,
-		       "target %uus interval %uus ecn %s\n",
-		       codel_time_to_us(sta->cparams.target),
-		       codel_time_to_us(sta->cparams.interval),
-		       sta->cparams.ecn ? "yes" : "no");
 	p += scnprintf(p,
 		       bufsz + buf - p,
 		       "tid ac backlog-bytes backlog-packets new-flows drops marks overlimit collisions tx-bytes tx-packets flags\n");
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 0d056db9f81e..a63723ba691d 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -990,8 +990,6 @@ int rate_control_set_rates(struct ieee80211_hw *hw,
 	if (sta->uploaded)
 		drv_sta_rate_tbl_update(hw_to_local(hw), sta->sdata, pubsta);
 
-	ieee80211_sta_set_expected_throughput(pubsta, sta_get_expected_throughput(sta));
-
 	return 0;
 }
 EXPORT_SYMBOL(rate_control_set_rates);
@@ -1040,3 +1038,4 @@ void rate_control_deinitialize(struct ieee80211_local *local)
 	local->rate_ctrl = NULL;
 	rate_control_free(local, ref);
 }
+
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 30cdc783999d..da9d17e7bf0d 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -18,7 +18,6 @@
 #include <linux/timer.h>
 #include <linux/rtnetlink.h>
 
-#include <net/codel.h>
 #include <net/mac80211.h>
 #include "ieee80211_i.h"
 #include "driver-ops.h"
@@ -701,12 +700,6 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
-	sta->cparams.ce_threshold = CODEL_DISABLED_THRESHOLD;
-	sta->cparams.target = MS2TIME(20);
-	sta->cparams.interval = MS2TIME(100);
-	sta->cparams.ecn = true;
-	sta->cparams.ce_threshold_selector = 0;
-	sta->cparams.ce_threshold_mask = 0;
 
 	sta_dbg(sdata, "Allocated STA %pM\n", sta->sta.addr);
 
@@ -2905,27 +2898,6 @@ unsigned long ieee80211_sta_last_active(struct sta_info *sta)
 	return sta->deflink.status_stats.last_ack;
 }
 
-static void sta_update_codel_params(struct sta_info *sta, u32 thr)
-{
-	if (thr && thr < STA_SLOW_THRESHOLD * sta->local->num_sta) {
-		sta->cparams.target = MS2TIME(50);
-		sta->cparams.interval = MS2TIME(300);
-		sta->cparams.ecn = false;
-	} else {
-		sta->cparams.target = MS2TIME(20);
-		sta->cparams.interval = MS2TIME(100);
-		sta->cparams.ecn = true;
-	}
-}
-
-void ieee80211_sta_set_expected_throughput(struct ieee80211_sta *pubsta,
-					   u32 thr)
-{
-	struct sta_info *sta = container_of(pubsta, struct sta_info, sta);
-
-	sta_update_codel_params(sta, thr);
-}
-
 int ieee80211_sta_allocate_link(struct sta_info *sta, unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 07b7ec39a52f..7a95d8d34fca 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -466,14 +466,6 @@ struct ieee80211_fragment_cache {
 	unsigned int next;
 };
 
-/*
- * The bandwidth threshold below which the per-station CoDel parameters will be
- * scaled to be more lenient (to prevent starvation of slow stations). This
- * value will be scaled by the number of active stations when it is being
- * applied.
- */
-#define STA_SLOW_THRESHOLD 6000 /* 6 Mbps */
-
 /**
  * struct link_sta_info - Link STA information
  * All link specific sta info are stored here for reference. This can be
@@ -626,7 +618,6 @@ struct link_sta_info {
  * @sta: station information we share with the driver
  * @sta_state: duplicates information about station state (for debug)
  * @rcu_head: RCU head used for freeing this station struct
- * @cparams: CoDel parameters for this station.
  * @reserved_tid: reserved TID (if any, otherwise IEEE80211_TID_UNRESERVED)
  * @amsdu_mesh_control: track the mesh A-MSDU format used by the peer:
  *
@@ -717,8 +708,6 @@ struct sta_info {
 	struct dentry *debugfs_dir;
 #endif
 
-	struct codel_params cparams;
-
 	u8 reserved_tid;
 	s8 amsdu_mesh_control;
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 20179db88c4a..25f38e7eb58a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1402,16 +1402,9 @@ static struct sk_buff *fq_tin_dequeue_func(struct fq *fq,
 
 	local = container_of(fq, struct ieee80211_local, fq);
 	txqi = container_of(tin, struct txq_info, tin);
+	cparams = &local->cparams;
 	cstats = &txqi->cstats;
 
-	if (txqi->txq.sta) {
-		struct sta_info *sta = container_of(txqi->txq.sta,
-						    struct sta_info, sta);
-		cparams = &sta->cparams;
-	} else {
-		cparams = &local->cparams;
-	}
-
 	if (flow == &tin->default_flow)
 		cvars = &txqi->def_cvars;
 	else
-- 
2.48.1


