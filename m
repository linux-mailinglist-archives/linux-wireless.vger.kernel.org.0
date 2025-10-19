Return-Path: <linux-wireless+bounces-28052-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1869BEE079
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0109E4023C5
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB43C1C54AF;
	Sun, 19 Oct 2025 08:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fLZI0JVq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB38354AEB
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760861595; cv=none; b=n6MPYY7yglv4Y3mYnHuahHvr+NSnHDKJaLktqdy3n/KRYdhTe9LFZCUljmhC60G+2ddSJh5mtesIGVgas8OH1vZafH5X3D/9C7S3fMt7kaMlaToycy6Zso1kAjMZOZXHBYD8nWy6ix1/wMUjaPSC8A/xVTGxGV5kw09DXpoalGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760861595; c=relaxed/simple;
	bh=phj9qOuOr865HycJIeOWhLcNat6kQ5Wr5JWsxJLbAwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T0EZNky/1Mne79YQAKqm25Np3S1wFmej6UUKbb3VKYZYW6QSk+Af8RssbP7HG726KY9z7sAugfi1UhH3U09Tz1Ci6iQsJGM7dM4Jdt11euHH6wRbZnSkcfwHBuA0DtbS30MyavU4P6nSSkCHccoFQ9/Fw7adQYOf7IsIzH8znuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fLZI0JVq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760861594; x=1792397594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=phj9qOuOr865HycJIeOWhLcNat6kQ5Wr5JWsxJLbAwA=;
  b=fLZI0JVqlh/G+2UfzquDgN+aybOigeSAhBqz5xuCPclZnAXqKrifSEHA
   DjOkUPBqngd9zPmgHgNGXe0zymfNECAXLsAe35tyMgAouK9xIWpyzauYO
   pZlrr5UGcLF2SpMr/5qo/zBAtjWcaMAS+bhgcu0ql+dBq/dmCarahyPXh
   ObjhsUapgDnmkC0RUGHtaR9ZfF+tHLKFf3aR4VIKeErVPA8oggArLiuMO
   VHpKqz8qKFykWNC5dwy711KlmgJHeZdswd13AeiXbSL2NAnaqrV3nIgGs
   au59hiWaPLhFQRCvIYGGCN6wZQ+2MfI0hWbIIqhyIBjM1R0+QKSTwzB9m
   g==;
X-CSE-ConnectionGUID: wtBfUw5UT7ihGwP85qYyfQ==
X-CSE-MsgGUID: iHLhWfWdTgeKFg4icatC/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62912544"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="62912544"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:13:14 -0700
X-CSE-ConnectionGUID: K8EbTh7nSD2qqdNLQRTsWA==
X-CSE-MsgGUID: 8/pboil6QNifwim0XO8c+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="183501623"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:13:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4/4] wifi: mac80211: use wiphy_hrtimer_work for csa.switch_work
Date: Sun, 19 Oct 2025 11:12:59 +0300
Message-Id: <20251019111003.09b3ef1c0953.I4ff2b2cdffbbf858bf5f08baccc7a88c4f9efe6f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019081259.2455317-1-miriam.rachel.korenblit@intel.com>
References: <20251019081259.2455317-1-miriam.rachel.korenblit@intel.com>
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

Switch to use wiphy_hrtimer_work so that the accuracy is sufficient. To
make this work, use the same clock to store the timestamp.

Fixes: ec3252bff7b6 ("wifi: mac80211: use wiphy work for channel switch")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/chan.c        |  2 +-
 net/mac80211/ieee80211_i.h |  4 ++--
 net/mac80211/link.c        |  4 ++--
 net/mac80211/mlme.c        | 18 +++++++++---------
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 57065714cf8c..7f8799fd673e 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1290,7 +1290,7 @@ ieee80211_link_chanctx_reservation_complete(struct ieee80211_link_data *link)
 				 &link->csa.finalize_work);
 		break;
 	case NL80211_IFTYPE_STATION:
-		wiphy_delayed_work_queue(sdata->local->hw.wiphy,
+		wiphy_hrtimer_work_queue(sdata->local->hw.wiphy,
 					 &link->u.mgd.csa.switch_work, 0);
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index eb38049b2252..878c3b14aeb8 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1017,10 +1017,10 @@ struct ieee80211_link_data_managed {
 	bool operating_11g_mode;
 
 	struct {
-		struct wiphy_delayed_work switch_work;
+		struct wiphy_hrtimer_work switch_work;
 		struct cfg80211_chan_def ap_chandef;
 		struct ieee80211_parsed_tpe tpe;
-		unsigned long time;
+		ktime_t time;
 		bool waiting_bcn;
 		bool ignored_same_chan;
 		bool blocked_tx;
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index d71eabe5abf8..4a19b765ccb6 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -472,10 +472,10 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 		 * from there.
 		 */
 		if (link->conf->csa_active)
-			wiphy_delayed_work_queue(local->hw.wiphy,
+			wiphy_hrtimer_work_queue(local->hw.wiphy,
 						 &link->u.mgd.csa.switch_work,
 						 link->u.mgd.csa.time -
-						 jiffies);
+						 ktime_get_boottime());
 	}
 
 	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f95bcf84ecc2..f3138d158535 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2594,7 +2594,7 @@ void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success,
 			return;
 		}
 
-		wiphy_delayed_work_queue(sdata->local->hw.wiphy,
+		wiphy_hrtimer_work_queue(sdata->local->hw.wiphy,
 					 &link->u.mgd.csa.switch_work, 0);
 	}
 
@@ -2753,7 +2753,8 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 		.timestamp = timestamp,
 		.device_timestamp = device_timestamp,
 	};
-	unsigned long now;
+	u32 csa_time_tu;
+	ktime_t now;
 	int res;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -2983,10 +2984,9 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 					  csa_ie.mode);
 
 	/* we may have to handle timeout for deactivated link in software */
-	now = jiffies;
-	link->u.mgd.csa.time = now +
-			       TU_TO_JIFFIES((max_t(int, csa_ie.count, 1) - 1) *
-					     link->conf->beacon_int);
+	now = ktime_get_boottime();
+	csa_time_tu = (max_t(int, csa_ie.count, 1) - 1) * link->conf->beacon_int;
+	link->u.mgd.csa.time = now + us_to_ktime(ieee80211_tu_to_usec(csa_time_tu));
 
 	if (ieee80211_vif_link_active(&sdata->vif, link->link_id) &&
 	    local->ops->channel_switch) {
@@ -3001,7 +3001,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	}
 
 	/* channel switch handled in software */
-	wiphy_delayed_work_queue(local->hw.wiphy,
+	wiphy_hrtimer_work_queue(local->hw.wiphy,
 				 &link->u.mgd.csa.switch_work,
 				 link->u.mgd.csa.time - now);
 	return;
@@ -8849,7 +8849,7 @@ void ieee80211_mgd_setup_link(struct ieee80211_link_data *link)
 	else
 		link->u.mgd.req_smps = IEEE80211_SMPS_OFF;
 
-	wiphy_delayed_work_init(&link->u.mgd.csa.switch_work,
+	wiphy_hrtimer_work_init(&link->u.mgd.csa.switch_work,
 				ieee80211_csa_switch_work);
 
 	ieee80211_clear_tpe(&link->conf->tpe);
@@ -10064,7 +10064,7 @@ void ieee80211_mgd_stop_link(struct ieee80211_link_data *link)
 			  &link->u.mgd.request_smps_work);
 	wiphy_work_cancel(link->sdata->local->hw.wiphy,
 			  &link->u.mgd.recalc_smps);
-	wiphy_delayed_work_cancel(link->sdata->local->hw.wiphy,
+	wiphy_hrtimer_work_cancel(link->sdata->local->hw.wiphy,
 				  &link->u.mgd.csa.switch_work);
 }
 
-- 
2.34.1


