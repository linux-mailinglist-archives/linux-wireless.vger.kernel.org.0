Return-Path: <linux-wireless+bounces-28339-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A166C14458
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 12:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A43A0581837
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 11:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6621630595F;
	Tue, 28 Oct 2025 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UNKD8hTG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C74304BCD
	for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649131; cv=none; b=PQptnL11riZKbKg4sR9vIVH6X3J3dLNjRqkr/94pOkOpa52yhyytpqXTsEycng0teyG3bcT+ETQXO/0/BqQwGWKjDQg6t0Xbv/9bg8sRjLJITh0WthCftUVKCp5M06vEPGExtAXGO+wyTNP42uDlRkw5XgxZsON7LflKYsvXKCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649131; c=relaxed/simple;
	bh=caazNUvuy4FsgZYP10/JqTr8gldQZa/PWRW2mdCSjw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZelfBlGsg9d3tXTRt8nwlqeEPySf9OgwsnDVAhStH/q//+n9gyIeC3qUibqH7+a5hY8TBeTv8h9iN+N9RIZrY8JD/28L03B5nRFD8PiLRuBhMcb1ctnE7XVwulyTq3xlcnaEVSgKNPy9reRTm8J9Yb5FPjT9dl8+B5jLdxWkWvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UNKD8hTG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761649129; x=1793185129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=caazNUvuy4FsgZYP10/JqTr8gldQZa/PWRW2mdCSjw0=;
  b=UNKD8hTGPMiu0jt13xaayMSiDyQkKT24A3o9ELzB5XoBBJGqhPt4tJJ/
   EDRvQf6LUmqtALPvFgxbTgQorReBlsIFJPF2qr49IDhgNQMuMaJoa4AVl
   QAII/FdJXn2XZDOA1XKhb9hCzbhAR2B//4xbFdkgh9QjTta3ttlhXmDkh
   Yu7ifstXpGbUTzRLzQZ7Ew6EtrqPfhgHPdHw9gGFx+cmmeGGeI1ChBme7
   3mCNcWM1rvt05zHkHpclNO0RAiNAoT5VoAgkqyaRVkOrHqCPnudktDhEa
   RrZGiQCuwZpnnxwsxESnsq4iQE4VgJzIVjhFzQE4EHf0J0u31Wnd+Ah/Q
   Q==;
X-CSE-ConnectionGUID: iDj4dJ5xSeKYXoEh+Pnrrg==
X-CSE-MsgGUID: hSXKE9LjTWSIWxEGWYw6cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="89215634"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="89215634"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 03:58:49 -0700
X-CSE-ConnectionGUID: YteVVU6fTEuQPA3ZNcIhYA==
X-CSE-MsgGUID: AETN6araR3aBpsj4iIompw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="184549948"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 03:58:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless v4 2/4] wifi: mac80211: use wiphy_hrtimer_work for ttlm_work
Date: Tue, 28 Oct 2025 12:58:38 +0200
Message-Id: <20251028125710.83c2c611545e.I35498a6d883ea24b0dc4910cf521aa768d2a0e90@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028105840.3140483-1-miriam.rachel.korenblit@intel.com>
References: <20251028105840.3140483-1-miriam.rachel.korenblit@intel.com>
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


