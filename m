Return-Path: <linux-wireless+bounces-28073-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A64BEE122
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 316F64E2CF2
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEC12356BA;
	Sun, 19 Oct 2025 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KVJnzS36"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ACA29DB65
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863802; cv=none; b=sUaqPbStksAUrmBk8/H3+J0kildZ5o7AMXNGokOu6Qu1qyE0aFZOWkpn2lnjFUKqgpmmxrTttCJdUWLgKIx9BW2hwXkubnKF6bzInM/RsxeKhF9+dWmOfpBT5uWRMofcugaGYBxEiQvRM2Cw6SLPlGv0mG0th5FSy7zeXA4PLes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863802; c=relaxed/simple;
	bh=caazNUvuy4FsgZYP10/JqTr8gldQZa/PWRW2mdCSjw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U2PchVrep4H6IRcGsnMJ3dTF4JF1tNyml6SYb6rkFlDJASKxYHnOyvC82OiOLtDGhIspjP+G9dA1FehHVeqOEJUpME83mRKpiq+CnwltXJx4h8ddJ88lTmsLUrLNRm/4EuMC6wr6iTy3F1g3g2k55XtirPeTdHJTX2w8rOGMKY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KVJnzS36; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760863801; x=1792399801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=caazNUvuy4FsgZYP10/JqTr8gldQZa/PWRW2mdCSjw0=;
  b=KVJnzS368CLSYf+EByZ2o+yJpKmmEE9zGsGPdasKJnT+vM2myVKNxwxB
   bzKHmrnLIEPdgujfNr1JJ24YGIe+pLTsw9lbsrhHvmrGye9HLFHpo96I3
   1dbuULYegh2/yJRwkPu4EAQi8qsrVETICC8emFDzXqjH1yWxCLnMwjbEn
   phtaeC+LGaVDUQLEwm2O9LODEBP/OLf2IeT6kfhaKErDTTCndq3ClfUDe
   p1zi311lA/X7PpeVNIWahvQLjNkedNAqs9A3rpxltXoPT9RXblojn21AS
   WmrM2WShwdFSdI5DMvJudtxsNATCYDvfBuOkVlJtrjY59kZ15eC3MmxM4
   Q==;
X-CSE-ConnectionGUID: rKBaqb6ITXuCw8gxB0JqLg==
X-CSE-MsgGUID: oza223fpQ26x+ZMNqky8NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="65634516"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="65634516"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:50:00 -0700
X-CSE-ConnectionGUID: g5zyoTCTR42thaRtcvjTIw==
X-CSE-MsgGUID: rstYdln/Rfue+XSBYIib9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="183055164"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:49:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next v2 2/4] wifi: mac80211: use wiphy_hrtimer_work for ttlm_work
Date: Sun, 19 Oct 2025 11:49:49 +0300
Message-Id: <20251019114824.68a808d3ee4f.I35498a6d883ea24b0dc4910cf521aa768d2a0e90@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019084951.2572582-1-miriam.rachel.korenblit@intel.com>
References: <20251019084951.2572582-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The work item may be scheduled relatively far in the future. As the
event happens at a specific point in time, the normal timer accuracy is
not sufficient in that case.

Switch to use wiphy_hrtimer_work so that the accuracy is sufficient.

Fixes: 702e80470a33 ("wifi: mac80211: support handling of advertised TID-to-link mapping")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/mlme.c        | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 73fd86ec1bce..eb22279c6e01 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -616,7 +616,7 @@ struct ieee80211_if_managed {
 	u16 removed_links;
 
 	/* TID-to-link mapping support */
-	struct wiphy_delayed_work ttlm_work;
+	struct wiphy_hrtimer_work ttlm_work;
 	struct ieee80211_adv_ttlm_info ttlm_info;
 	struct wiphy_work teardown_ttlm_work;
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 3b5827ea438e..623a46b3214e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -45,7 +45,7 @@
 #define IEEE80211_ASSOC_TIMEOUT_SHORT	(HZ / 10)
 #define IEEE80211_ASSOC_MAX_TRIES	3
 
-#define IEEE80211_ADV_TTLM_SAFETY_BUFFER_MS msecs_to_jiffies(100)
+#define IEEE80211_ADV_TTLM_SAFETY_BUFFER_MS (100 * USEC_PER_MSEC)
 #define IEEE80211_ADV_TTLM_ST_UNDERFLOW 0xff00
 
 #define IEEE80211_NEG_TTLM_REQ_TIMEOUT (HZ / 5)
@@ -4242,7 +4242,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	memset(&sdata->u.mgd.ttlm_info, 0,
 	       sizeof(sdata->u.mgd.ttlm_info));
-	wiphy_delayed_work_cancel(sdata->local->hw.wiphy, &ifmgd->ttlm_work);
+	wiphy_hrtimer_work_cancel(sdata->local->hw.wiphy, &ifmgd->ttlm_work);
 
 	memset(&sdata->vif.neg_ttlm, 0, sizeof(sdata->vif.neg_ttlm));
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
@@ -7095,7 +7095,7 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
 			/* if a planned TID-to-link mapping was cancelled -
 			 * abort it
 			 */
-			wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+			wiphy_hrtimer_work_cancel(sdata->local->hw.wiphy,
 						  &sdata->u.mgd.ttlm_work);
 		} else if (sdata->u.mgd.ttlm_info.active) {
 			/* if no TID-to-link element, set to default mapping in
@@ -7130,7 +7130,7 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
 
 		if (ttlm_info.switch_time) {
 			u16 beacon_ts_tu, st_tu, delay;
-			u32 delay_jiffies;
+			u64 delay_usec;
 			u64 mask;
 
 			/* The t2l map switch time is indicated with a partial
@@ -7152,23 +7152,23 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
 			if (delay > IEEE80211_ADV_TTLM_ST_UNDERFLOW)
 				return;
 
-			delay_jiffies = TU_TO_JIFFIES(delay);
+			delay_usec = ieee80211_tu_to_usec(delay);
 
 			/* Link switching can take time, so schedule it
 			 * 100ms before to be ready on time
 			 */
-			if (delay_jiffies > IEEE80211_ADV_TTLM_SAFETY_BUFFER_MS)
-				delay_jiffies -=
+			if (delay_usec > IEEE80211_ADV_TTLM_SAFETY_BUFFER_MS)
+				delay_usec -=
 					IEEE80211_ADV_TTLM_SAFETY_BUFFER_MS;
 			else
-				delay_jiffies = 0;
+				delay_usec = 0;
 
 			sdata->u.mgd.ttlm_info = ttlm_info;
-			wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+			wiphy_hrtimer_work_cancel(sdata->local->hw.wiphy,
 						  &sdata->u.mgd.ttlm_work);
-			wiphy_delayed_work_queue(sdata->local->hw.wiphy,
+			wiphy_hrtimer_work_queue(sdata->local->hw.wiphy,
 						 &sdata->u.mgd.ttlm_work,
-						 delay_jiffies);
+						 us_to_ktime(delay_usec));
 			return;
 		}
 	}
@@ -8802,7 +8802,7 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 	timer_setup(&ifmgd->conn_mon_timer, ieee80211_sta_conn_mon_timer, 0);
 	wiphy_delayed_work_init(&ifmgd->tx_tspec_wk,
 				ieee80211_sta_handle_tspec_ac_params_wk);
-	wiphy_delayed_work_init(&ifmgd->ttlm_work,
+	wiphy_hrtimer_work_init(&ifmgd->ttlm_work,
 				ieee80211_tid_to_link_map_work);
 	wiphy_delayed_work_init(&ifmgd->neg_ttlm_timeout_work,
 				ieee80211_neg_ttlm_timeout_work);
-- 
2.34.1


