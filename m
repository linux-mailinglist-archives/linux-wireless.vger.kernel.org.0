Return-Path: <linux-wireless+bounces-22466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1F9AA9C14
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 20:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE5E1A80939
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 18:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9D326FA7B;
	Mon,  5 May 2025 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NpAPyAFr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB0026F45F
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471435; cv=none; b=ZrmM/lPJiqypY3gqLXQPniiL7O/j6Oxi7IES7TViefH/gS6pGxZo4zrRrFfw0H4Nv/lhZCGWwgQ6EtceLFyQ/r8zILZnlSZFaBXqdwZKgNteT6jOc8z0sbhoy4f1XDX9Ocb0vtdnlj73nYqmmTxEn37xudc5xAiUvD/+GhrrwPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471435; c=relaxed/simple;
	bh=3OTaaI1aYNG3y8yvQ3/Zy/q1AeEbkw5ZBfeLL5YQyu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bam2gYJmhJCS4lWMacQHOhppiyhOPjU/uzzuUqREvkjoaQq3/h7eeDD8YF/aoA1sDQODFxCeWSAzn8+4t83YP13YtPbCKelLakIKgXBXQFlUSDZ36OzX7hsNVdMhy9sp4H55Kgm3ceHgJ1PeDHpvFzjgUGVx0c8zYEL1cApf/SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NpAPyAFr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746471433; x=1778007433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3OTaaI1aYNG3y8yvQ3/Zy/q1AeEbkw5ZBfeLL5YQyu4=;
  b=NpAPyAFrgE7VpJPwpNY64vbml1CuF3q9axyGm85d/LIG5+EmrEhjoazB
   0esYta3Lw1DMFMMoXMuGf8IE/TmBJamVsKj1TQ/uRUprSlIG3otU8Klm2
   bWRXtaAD+2Tg40f0aJCZQAWXDWg4kPZ02+0ONTkX0XTGmyvv2QYhhBus/
   l0PUa+T6EQf4+O/5zMNjcDsQSu9ibq6Cy50mrrvNPauNvsvIXgAPlgVE6
   AGSo/rOzdI8k5cVJlPDI+wzCF0177+R8+EnlVgAMgE/6ds0hCmUDIDU22
   YZLbsOHBpnYIlPN/QyeLATVOTB4PkTnWIdts+uU5VuKZ8DwHBfWp60MjD
   Q==;
X-CSE-ConnectionGUID: f5fex1ufRaih+5Wovx6IxA==
X-CSE-MsgGUID: puw+8chfSGmO95XfdMBCDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47359438"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="47359438"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:13 -0700
X-CSE-ConnectionGUID: qORmzhKnR0m1S9Mw47Delw==
X-CSE-MsgGUID: kAQg+fovSbOFreYnjs/BJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="135697931"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:12 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: mld: don't check the TPT counters when scanning
Date: Mon,  5 May 2025 21:56:42 +0300
Message-Id: <20250505215512.330ea440d19c.Ib10dae0b7a0cb0e10c59a9edf5ff7af0f065ac60@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
References: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

If there is an ongoing scan that lasts long, the MPDU counters may not
increase enough due the device being busy with scanning and not
because we are in a low throughput scenario.

In that case we don't want to block EMLSR.
Instead, stop checking the counters from the moment we started
scanning, and when the scan ends - clear the counters and schedule a
check in 5 seconds, as usual.

Note that this is only done for regular scan since MLO scan is too short
to affect the counters, and scheduled scan is mainly used when we are
not connected.

Also note that we only stop checking whether to block EMLSR, and not if to
unblock.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 16 ++++-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  | 66 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h  |  3 +
 drivers/net/wireless/intel/iwlwifi/mld/scan.c |  3 +
 4 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index ce5c84e6bdb7..0406c727c0a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1322,13 +1322,22 @@ iwl_mld_mac80211_hw_scan(struct ieee80211_hw *hw,
 			 struct ieee80211_scan_request *hw_req)
 {
 	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
+	int ret;
 
 	if (WARN_ON(!hw_req->req.n_channels ||
 		    hw_req->req.n_channels >
 		    mld->fw->ucode_capa.n_scan_channels))
 		return -EINVAL;
 
-	return iwl_mld_regular_scan_start(mld, vif, &hw_req->req, &hw_req->ies);
+	ret = iwl_mld_regular_scan_start(mld, vif, &hw_req->req, &hw_req->ies);
+	if (!ret) {
+		/* We will be busy with scanning, so the counters may not reflect the
+		 * reality. Stop checking the counters until the scan ends
+		 */
+		iwl_mld_start_ignoring_tpt_updates(mld);
+	}
+
+	return ret;
 }
 
 static void
@@ -1344,8 +1353,11 @@ iwl_mld_mac80211_cancel_hw_scan(struct ieee80211_hw *hw,
 	 * cancel scan before ieee80211_scan_work() could run.
 	 * To handle that, simply return if the scan is not running.
 	 */
-	if (mld->scan.status & IWL_MLD_SCAN_REGULAR)
+	if (mld->scan.status & IWL_MLD_SCAN_REGULAR) {
 		iwl_mld_scan_stop(mld, IWL_MLD_SCAN_REGULAR, true);
+		/* Scan is over, we can check again the tpt counters */
+		iwl_mld_stop_ignoring_tpt_updates(mld);
+	}
 }
 
 static int
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index f65ff513ae63..93d0547798c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -1170,3 +1170,69 @@ void iwl_mld_retry_emlsr(struct iwl_mld *mld, struct ieee80211_vif *vif)
 
 	iwl_mld_int_mlo_scan(mld, vif);
 }
+
+static void iwl_mld_ignore_tpt_iter(void *data, u8 *mac,
+				    struct ieee80211_vif *vif)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_mld *mld = mld_vif->mld;
+	struct iwl_mld_sta *mld_sta;
+	bool *start = (void *)data;
+
+	/* check_tpt_wk is only used when TPT block isn't set */
+	if (mld_vif->emlsr.blocked_reasons & IWL_MLD_EMLSR_BLOCKED_TPT ||
+	    !IWL_MLD_AUTO_EML_ENABLE || !mld_vif->ap_sta)
+		return;
+
+	mld_sta = iwl_mld_sta_from_mac80211(mld_vif->ap_sta);
+
+	/* We only count for the AP sta in a MLO connection */
+	if (!mld_sta->mpdu_counters)
+		return;
+
+	if (*start) {
+		wiphy_delayed_work_cancel(mld_vif->mld->wiphy,
+					  &mld_vif->emlsr.check_tpt_wk);
+		IWL_DEBUG_EHT(mld, "TPT check disabled\n");
+		return;
+	}
+
+	/* Clear the counters so we start from the beginning */
+	for (int q = 0; q < mld->trans->info.num_rxqs; q++) {
+		struct iwl_mld_per_q_mpdu_counter *queue_counter =
+			&mld_sta->mpdu_counters[q];
+
+		spin_lock_bh(&queue_counter->lock);
+
+		memset(queue_counter->per_link, 0,
+		       sizeof(queue_counter->per_link));
+
+		spin_unlock_bh(&queue_counter->lock);
+	}
+
+	/* Schedule the check in 5 seconds */
+	wiphy_delayed_work_queue(mld_vif->mld->wiphy,
+				 &mld_vif->emlsr.check_tpt_wk,
+				 round_jiffies_relative(IWL_MLD_TPT_COUNT_WINDOW));
+	IWL_DEBUG_EHT(mld, "TPT check enabled\n");
+}
+
+void iwl_mld_start_ignoring_tpt_updates(struct iwl_mld *mld)
+{
+	bool start = true;
+
+	ieee80211_iterate_active_interfaces_mtx(mld->hw,
+						IEEE80211_IFACE_ITER_NORMAL,
+						iwl_mld_ignore_tpt_iter,
+						&start);
+}
+
+void iwl_mld_stop_ignoring_tpt_updates(struct iwl_mld *mld)
+{
+	bool start = false;
+
+	ieee80211_iterate_active_interfaces_mtx(mld->hw,
+						IEEE80211_IFACE_ITER_NORMAL,
+						iwl_mld_ignore_tpt_iter,
+						&start);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.h b/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
index 459959f83c6d..9afa3d6ea649 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
@@ -167,4 +167,7 @@ bool iwl_mld_bt_allows_emlsr(struct iwl_mld *mld,
 			     bool entry_criteria);
 #endif
 
+void iwl_mld_start_ignoring_tpt_updates(struct iwl_mld *mld);
+void iwl_mld_stop_ignoring_tpt_updates(struct iwl_mld *mld);
+
 #endif /* __iwl_mld_mlo_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/scan.c b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
index 7ec04318ec2f..3fce7cd2d512 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
@@ -1920,6 +1920,9 @@ void iwl_mld_handle_scan_complete_notif(struct iwl_mld *mld,
 			IWL_DEBUG_SCAN(mld, "Scan link is no longer valid\n");
 
 		ieee80211_scan_completed(mld->hw, &info);
+
+		/* Scan is over, we can check again the tpt counters */
+		iwl_mld_stop_ignoring_tpt_updates(mld);
 	} else if (mld->scan.uid_status[uid] == IWL_MLD_SCAN_SCHED) {
 		ieee80211_sched_scan_stopped(mld->hw);
 		mld->scan.pass_all_sched_res = SCHED_SCAN_PASS_ALL_STATE_DISABLED;
-- 
2.34.1


