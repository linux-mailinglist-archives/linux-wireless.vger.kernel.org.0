Return-Path: <linux-wireless+bounces-28313-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBF2C0DA32
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 13:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6738A3B1C0D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 12:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A5E302759;
	Mon, 27 Oct 2025 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bd2uYnkz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25B12E8E00
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 12:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568448; cv=none; b=eqjNB8RH+/S49nM+WnmlIj5QQHe/wV7lhIDuTXQePSD6grauYINbmUTbK/0Pay++J9lPQukR0/X+uC2WYrT8E3bOML6gnfn3ZkQXhT4kq275iU7iPuY9kRiiDEHT20AGYYlicJeJ4p0K0+rr0aUn0ZKtQwBD4xzpf1B3KUJbHRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568448; c=relaxed/simple;
	bh=ZfZfZ2YAzPP9kD2PXH6BFMq3A6Hi/QF9T1Vf3Nu2i2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=knBQk2JFg/Cj/EaYXLYrTqap+Y024iakKELdLltcnhTtoY2OxnUZ7L7O1sQDjaHx0VzVcxNdQVerawx3B9SPRbBN7FVvvsIGSEOvRTv8xAZ3BOWdmf/IaUk3QsMld/ab+e4Wh8Gdr7Ni6AOhQpsYh2UAuUMvnvN146y+8Ia5Xec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bd2uYnkz; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761568447; x=1793104447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZfZfZ2YAzPP9kD2PXH6BFMq3A6Hi/QF9T1Vf3Nu2i2c=;
  b=Bd2uYnkzWfPrkkc5tL1yqTL1W6kfKg8UG/yy2Bd0xQWunHxggGZZl8Hp
   lZ8cNaQPgFKBxYWH6BRNjRpWnMKSioh7sLw8Y1ju14fUrN72TVXGeoBAh
   hBslobRnz9a8k1j4itDywkBMWyMha2akteyD1lFxfGWTfa/nQDnzv+fkH
   l64vu0gc9QQWC/2tp9IlQL+9VwUl5MNy20tSE3VMtXMzd8+NzwjoZrj09
   SPtmy0d3t+NJuvUcBWdHV1DHrFgjeMQrbgfToPekc04mpZ2i36qt6oX4Y
   SnsaKZS2F3NzCwiQGrmTIywTSZlkd+9YtmSbXivgB3UZR1QNZb+NUXJIK
   g==;
X-CSE-ConnectionGUID: SvjsKsEPQ+WAZnVWAVnlUg==
X-CSE-MsgGUID: aH/dpptiQTmoVc0pGzNaPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66258575"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="66258575"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:34:06 -0700
X-CSE-ConnectionGUID: npVB2TerT7+TPbJcgMmi1w==
X-CSE-MsgGUID: i2v7FwS0QjCtFZuYWWvaXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="190162816"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:34:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next v3 2/4] wifi: mac80211: use wiphy_hrtimer_work for ttlm_work
Date: Mon, 27 Oct 2025 14:33:55 +0200
Message-Id: <20251027143011.d4cdfc66fed4.I35498a6d883ea24b0dc4910cf521aa768d2a0e90@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027123357.2221947-1-miriam.rachel.korenblit@intel.com>
References: <20251027123357.2221947-1-miriam.rachel.korenblit@intel.com>
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
index 025210d50405..1775835d255d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -45,7 +45,7 @@
 #define IEEE80211_ASSOC_TIMEOUT_SHORT	(HZ / 10)
 #define IEEE80211_ASSOC_MAX_TRIES	3
 
-#define IEEE80211_ADV_TTLM_SAFETY_BUFFER_MS msecs_to_jiffies(100)
+#define IEEE80211_ADV_TTLM_SAFETY_BUFFER_MS (100 * USEC_PER_MSEC)
 #define IEEE80211_ADV_TTLM_ST_UNDERFLOW 0xff00
 
 #define IEEE80211_NEG_TTLM_REQ_TIMEOUT (HZ / 5)
@@ -4252,7 +4252,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	memset(&sdata->u.mgd.ttlm_info, 0,
 	       sizeof(sdata->u.mgd.ttlm_info));
-	wiphy_delayed_work_cancel(sdata->local->hw.wiphy, &ifmgd->ttlm_work);
+	wiphy_hrtimer_work_cancel(sdata->local->hw.wiphy, &ifmgd->ttlm_work);
 
 	memset(&sdata->vif.neg_ttlm, 0, sizeof(sdata->vif.neg_ttlm));
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
@@ -7105,7 +7105,7 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
 			/* if a planned TID-to-link mapping was cancelled -
 			 * abort it
 			 */
-			wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+			wiphy_hrtimer_work_cancel(sdata->local->hw.wiphy,
 						  &sdata->u.mgd.ttlm_work);
 		} else if (sdata->u.mgd.ttlm_info.active) {
 			/* if no TID-to-link element, set to default mapping in
@@ -7140,7 +7140,7 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
 
 		if (ttlm_info.switch_time) {
 			u16 beacon_ts_tu, st_tu, delay;
-			u32 delay_jiffies;
+			u64 delay_usec;
 			u64 mask;
 
 			/* The t2l map switch time is indicated with a partial
@@ -7162,23 +7162,23 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
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
@@ -8812,7 +8812,7 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
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


