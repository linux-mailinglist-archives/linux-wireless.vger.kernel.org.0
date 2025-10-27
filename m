Return-Path: <linux-wireless+bounces-28315-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A0AC0D987
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 13:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E6919A24FF
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 12:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E02C30F959;
	Mon, 27 Oct 2025 12:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CkQiDI3v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FB730F921
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568451; cv=none; b=dEaIwD8PK5BDP5BOdKogGnlxOTkGNICpkVexWSW/AjdLbGOY0X71uSfGjMjatuBHhAcQP1BHN3rtsZI/pEgrPpLlvQAfxoM4ArRlWus4UneS6w3k0R0rLKUtbJAJkt/bmq+0caFckZjVn/r3p+VKHXqFkK44zE04NduC6bLy1d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568451; c=relaxed/simple;
	bh=dGL4Jm1ew5khgBhB6mbdQygeiPY7CEaGZ0zXi3YNTTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tP7C5+ugTSe3dQpFV/PWkTlLmdksUQQmrnrn5cE6QcGqe2tvHiz5Q+5/AeMz4f5KvIctBrWThpQefE+V2V76dZxvAEigakpKfepQaI4o988TvcuwVMhK5+7MJYgqjQ8DmY/sczGmkcoLcg/oYtxglGZaxGpvJKKJoKxsKqSCRY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CkQiDI3v; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761568449; x=1793104449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dGL4Jm1ew5khgBhB6mbdQygeiPY7CEaGZ0zXi3YNTTE=;
  b=CkQiDI3v3VP2/6MyttsH8tcOw0KZ+X1UY0qHyw7rKYly3VkSy06kNBPh
   uKDrUptKmVm4hWWRamxMk5/pMrCv1r5DJsPKwTyyXoRyOcP+04DPHHMpZ
   OLT6wbI1lvMfIy2FJBJzlqhgjwz41++db+t2ZI/RrHKupZORC1P9/4Py/
   1bXtv9ia+9vmJKv+qwClMp0wJWvl7TbCXyvMxJ+9i86HpMCH/p7AnYrUS
   Za4Qui3PTbwTv5x7Z4pHsWwfClayaz0R+zWHn4xJH7C8ucAEWl/BgtLlI
   3sHyQOL67sGO/leloeyaXwk1MDAE/wFB/afDRZgmW3E9JSRcT9Xvxd3mo
   w==;
X-CSE-ConnectionGUID: nR3WcMD8T6iXgqSrZ4cBZA==
X-CSE-MsgGUID: DdlWLSXKR2qGblyohHJFYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66258579"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="66258579"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:34:09 -0700
X-CSE-ConnectionGUID: ozK0NQXoT7OPPDyeBymF7A==
X-CSE-MsgGUID: bKkjsP/wRTiWljAp0MsDOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="190162834"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:34:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next v3 4/4] wifi: mac80211: use wiphy_hrtimer_work for csa.switch_work
Date: Mon, 27 Oct 2025 14:33:57 +0200
Message-Id: <20251027143011.8e0ca5adf1c2.I4ff2b2cdffbbf858bf5f08baccc7a88c4f9efe6f@changeid>
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
index dad3985b5704..767804e41a34 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2604,7 +2604,7 @@ void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success,
 			return;
 		}
 
-		wiphy_delayed_work_queue(sdata->local->hw.wiphy,
+		wiphy_hrtimer_work_queue(sdata->local->hw.wiphy,
 					 &link->u.mgd.csa.switch_work, 0);
 	}
 
@@ -2763,7 +2763,8 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 		.timestamp = timestamp,
 		.device_timestamp = device_timestamp,
 	};
-	unsigned long now;
+	u32 csa_time_tu;
+	ktime_t now;
 	int res;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -2993,10 +2994,9 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
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
@@ -3011,7 +3011,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	}
 
 	/* channel switch handled in software */
-	wiphy_delayed_work_queue(local->hw.wiphy,
+	wiphy_hrtimer_work_queue(local->hw.wiphy,
 				 &link->u.mgd.csa.switch_work,
 				 link->u.mgd.csa.time - now);
 	return;
@@ -8859,7 +8859,7 @@ void ieee80211_mgd_setup_link(struct ieee80211_link_data *link)
 	else
 		link->u.mgd.req_smps = IEEE80211_SMPS_OFF;
 
-	wiphy_delayed_work_init(&link->u.mgd.csa.switch_work,
+	wiphy_hrtimer_work_init(&link->u.mgd.csa.switch_work,
 				ieee80211_csa_switch_work);
 
 	ieee80211_clear_tpe(&link->conf->tpe);
@@ -10074,7 +10074,7 @@ void ieee80211_mgd_stop_link(struct ieee80211_link_data *link)
 			  &link->u.mgd.request_smps_work);
 	wiphy_work_cancel(link->sdata->local->hw.wiphy,
 			  &link->u.mgd.recalc_smps);
-	wiphy_delayed_work_cancel(link->sdata->local->hw.wiphy,
+	wiphy_hrtimer_work_cancel(link->sdata->local->hw.wiphy,
 				  &link->u.mgd.csa.switch_work);
 }
 
-- 
2.34.1


