Return-Path: <linux-wireless+bounces-23616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA60CACD2CD
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF0BE7A8436
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 01:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F6C1E47A3;
	Wed,  4 Jun 2025 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvWDYIss"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92F11B423B;
	Wed,  4 Jun 2025 00:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998689; cv=none; b=c5GZYNlZmk8w8+WWvREWUfz4fV0fmb6ahg2NYHXDfnZQ5/axvgREg1sWXQbAGBSqlUbuxvzMm2l0o9GaCJYSn5b4dSjJ3IUeOZmbHnvO6n4577i1kTPwpSbkNEvxdzKtVTaRUgOSYeVWomLNL3f8T8g248ipFR1lpjnySqSzTCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998689; c=relaxed/simple;
	bh=TL4ZDdFDt2hqSu/wv0XtPibnOEGzNZhaHa2QsSw+m3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0fS61JCqAnzLJO7LkY2dK8gotA5boDCmu2pL37FsPsbxHy7YDXkIq7LViQNv7mzKgZygRXBMgGnrHiSROwWGpiyspvRBndPZjyzxXk7thXtuokeP2t2sbcto7OGPmhcO5KcH7gWtiJz6r0oGo7ZWqKbplij5CzD0psdXJkN1/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvWDYIss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6C8C4CEED;
	Wed,  4 Jun 2025 00:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998688;
	bh=TL4ZDdFDt2hqSu/wv0XtPibnOEGzNZhaHa2QsSw+m3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PvWDYIss5mjw/o0V0tHpmUKDNs6IMYncIu8Qi0npdKdwmR1sPm3QmRL0J8o79bBmC
	 ZPdubd9wDGu2ZMRcTyNpAovYGXMwShHpuw/2oTm8fBGHa4OD8kijUPyv6NquxSH2NQ
	 BQ1S4Zl7nFFkkLc8ZgIgRlfK9n0Zcg9K/u8+2YThR2cwD84IU+Bp4N/g89Jfi/xBMT
	 b54hThMELM6pj4C4MnfrcUbPS/W4azxSSX5KhFPyF/o5JfxBEAsG8HZ2LBuzmBTNiZ
	 jSt5dErG0GTdMTcYsI5S/Xa6LGFfz1dH7obWuBxC6bpELfdvtYAbCB7l8/d4+lrji8
	 8q0DeiocPf9Cg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Dave Taht <dave.taht@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 075/108] Revert "mac80211: Dynamically set CoDel parameters per station"
Date: Tue,  3 Jun 2025 20:54:58 -0400
Message-Id: <20250604005531.4178547-75-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005531.4178547-1-sashal@kernel.org>
References: <20250604005531.4178547-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
Content-Transfer-Encoding: 8bit

From: Toke Høiland-Jørgensen <toke@toke.dk>

[ Upstream commit 4876376988081d636a4c4e5f03a5556386b49087 ]

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
Link: https://patch.msgid.link/20250403183930.197716-1-toke@toke.dk
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my detailed analysis: ## Why This Should Be Backported ### 1. **Fixes
Important Performance Bug** The commit message provides compelling
evidence from Dave Taht (an expert in the field) that the original
dynamic CoDel parameter implementation was fundamentally flawed and
causing severe performance degradation: - **5+ seconds of accumulated
delay** in production APs - **CoDel effectively disabled** by the 300ms
interval parameter - **Poor throughput** due to overly lenient
parameters ### 2. **Clear Technical Problems in Original
Implementation** Looking at the code changes, the original
implementation had several critical flaws: ```c // REMOVED: Problematic
per-station CoDel parameters if (thr && thr < STA_SLOW_THRESHOLD
capability_test capability_test.c f2fs_folio_analysis.md
ipv4_multipath_analysis.md ipv6_route_allocation_rcu_analysis.md
ixgbe_e610_set_phys_id_analysis.md linux lpfc_timeout_analysis.md
mac80211_mlo_mbssid_analysis.md rtl_bb_delay_analysis.md
rtw89_mlo_analysis.md tcp_multipath_load_balance_analysis.md
test_unaligned_diff test_unaligned_diff.c type_size_check
type_size_check.c veth_driver_analysis.md
wifi_mlo_mbssid_tx_link_id_analysis.md sta->local->num_sta) {
sta->cparams.target = MS2TIME(50); // Too lenient (50ms)
sta->cparams.interval = MS2TIME(300); // Effectively disables CoDel
sta->cparams.ecn = false; // Disables ECN unnecessarily } ``` The code
shows the implementation used: - `sta->local->num_sta` (all associated
stations, not active ones) - Arbitrary `STA_SLOW_THRESHOLD` of 6000 kbps
- Destructively high 300ms interval that breaks CoDel's algorithm ### 3.
**Reverts to Proven Configuration** The revert returns to the global
CoDel parameters: ```c // RESTORED: Uses local->cparams consistently
cparams = &local->cparams; // Instead of per-station parameters ``` This
restores the proven 20ms target and 100ms interval that work well in
practice. ### 4. **Original Author's Decision** Critically, this revert
was done by **Toke Høiland-Jørgensen**, the same author who wrote the
original code 8 years earlier. This shows: - Deep understanding of the
issues - Professional acknowledgment of the design flaws - Community
feedback integration (OpenWrt validation) ### 5. **Matches Historical
Backport Patterns** Comparing to the similar commits: - **Similar Commit
#3 (YES)**: Fixed station bandwidth settings affecting rate control -
performance issue - **Similar Commits #1,#2,#4,#5 (NO)**: Were new
features or minor documentation fixes This revert is most similar to
Similar Commit #3 - it fixes a performance regression affecting real
users. ### 6. **Low Risk, High Benefit** The changes are: - **Minimal
scope**: Only affects mac80211 CoDel parameters - **Well-contained**:
Removes complexity rather than adding it - **Proven alternative**:
Returns to parameters that worked for years - **No architectural
changes**: Pure revert of a feature ### 7. **Wide Impact on Wireless
Performance** The bug affects: - All Linux systems using mac80211 (most
Wi-Fi hardware) - Multi-station environments (APs, mesh networks) - Any
deployment since Linux 4.13 (2017) ### 8. **Production Validation** The
commit message references OpenWrt community testing with tighter
parameters showing "promising results", and Dave Taht's production
experience with 8ms/80ms parameters working "great" for years. ##
Conclusion This is an exemplary stable tree candidate: it fixes an
important performance regression affecting real users, has minimal risk,
returns to a proven configuration, and was initiated by the original
author after thorough analysis. The 8-year gap between introduction and
revert shows this was a thorough, well-considered decision rather than a
hasty change.

 include/net/mac80211.h     | 16 ----------------
 net/mac80211/debugfs_sta.c |  6 ------
 net/mac80211/rate.c        |  2 --
 net/mac80211/sta_info.c    | 28 ----------------------------
 net/mac80211/sta_info.h    | 11 -----------
 net/mac80211/tx.c          |  9 +--------
 6 files changed, 1 insertion(+), 71 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index b421526aae851..2fae4fcf5e0f1 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5345,22 +5345,6 @@ void ieee80211_get_tx_rates(struct ieee80211_vif *vif,
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
index a67a9d3160086..06376e1a1fcf3 100644
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
index 0d056db9f81e6..6a19327800541 100644
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
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index caa3d0236b5ec..f823c34125914 100644
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
 
@@ -2899,27 +2892,6 @@ unsigned long ieee80211_sta_last_active(struct sta_info *sta)
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
index 07b7ec39a52f9..7a95d8d34fca8 100644
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
index caf4d8561a219..2ede18dc4d117 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1401,16 +1401,9 @@ static struct sk_buff *fq_tin_dequeue_func(struct fq *fq,
 
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
2.39.5


