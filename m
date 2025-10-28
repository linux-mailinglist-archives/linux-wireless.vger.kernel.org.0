Return-Path: <linux-wireless+bounces-28341-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A260C14488
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 12:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90924581A85
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 11:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C02C305953;
	Tue, 28 Oct 2025 10:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fqPj69tw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFE0306498
	for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649134; cv=none; b=ET7a/r1085PUuEtUcSCj6yteJsr7mQZ/7SrTw5BVP/gjk7DpKd6bhGuLTnK5Rm7QuYPTb03txajjdW9SuIDiiVfKrbhNrMQ4igzuUTTOW+kOuzV7wGBrMR/78FgA4e77yvzHqrjATRm0yuS2X87iw4kBljJ2fBJSQBrdTUKggd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649134; c=relaxed/simple;
	bh=phj9qOuOr865HycJIeOWhLcNat6kQ5Wr5JWsxJLbAwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZouQslxiKFqELrJrsDad/wYyh94lkeFk+T9yCCG7JvfTDjAoFFIPQcRFzsBz9bMEEoSoWBK4PVAz637SJv0YGGpmhYdR4DzlPKuW1K9qPbvWPsIMq2E5w59lQ6jt2xW9/Ry5y0tv3aS/w0L1vnIl84HGLlN7EXxVf+Gkve+KSGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fqPj69tw; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761649133; x=1793185133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=phj9qOuOr865HycJIeOWhLcNat6kQ5Wr5JWsxJLbAwA=;
  b=fqPj69tw6TugimyCwiCg1Xbk+J7VaeomMT/IDTV8agOujPmSt2rwS1e1
   esaSnsdFjYZM8ryi8nHolX8bOtm9P6LbmWMx1D6IoGTjaN4WLYBwycOF1
   DFlSAN4hxIJelIJOEiq0iO4K5uAtP8nV8M9eqr/ON4TidnXdOXJClAxyy
   ZXudVa8XxDkfTZIzped3s/WVqjrkxI+VgvO5uM1+dsiWIK1EIWf8elcme
   PDII/XwyYBi/uuLQg4Uc0Mm4WPD52V+CAP20POhCp7m+EdQK9704xTG/G
   V9CVTDEEcif3D36Wlr/wNXuTHrWDF7mwJGnwklTyMQgCcmQg0AO6EHrN2
   Q==;
X-CSE-ConnectionGUID: RUZCaOEpQFqggJJt7Arptg==
X-CSE-MsgGUID: s8J6C1A/R2KVAb2cPnxksQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="89215638"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="89215638"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 03:58:52 -0700
X-CSE-ConnectionGUID: UA08Dr+7TIuSPHVIjD+tqA==
X-CSE-MsgGUID: 9bBOig57ThGJifQY3D1rgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="184549959"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 03:58:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless v4 4/4] wifi: mac80211: use wiphy_hrtimer_work for csa.switch_work
Date: Tue, 28 Oct 2025 12:58:40 +0200
Message-Id: <20251028125710.68258c7e4ac4.I4ff2b2cdffbbf858bf5f08baccc7a88c4f9efe6f@changeid>
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


