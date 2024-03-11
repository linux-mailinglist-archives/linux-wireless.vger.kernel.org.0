Return-Path: <linux-wireless+bounces-4545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24221877AF4
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 07:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479A81C20EEF
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 06:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D461756E;
	Mon, 11 Mar 2024 06:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FVeufRNm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880611755F
	for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 06:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710138537; cv=none; b=i/R1d8v5SPP8ZdV55WL36bV+pKtZEvk20A0gdDdciZcpY+r4S+KqP6dXNPe/4UijfNL9+7lLbd5zGNfIMA3YOAfEOtalvU5pEfgybRq6Hy68BG7Pab+4LpTE3vm2kqFoVK7JhOd+jrRIfeHBr2ZSrLKlfy/W4zb/lnP1f3y2ceA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710138537; c=relaxed/simple;
	bh=4dUrLHU3oj3tzbYZe1E0dNFsqYHhaDT/JZq6ttfzrl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XFKTluhluboP0qcNDdE81QrIjh/diAO/DGqC+xBEcz/Ck6Pdw23zekqOHb8Q8tRI0JPPsXn11ZTGMHA04bVAjN8F3eOWJIIW/XVF+Cswuzb9xvebXnd83P6y+wLyMdL5T3KFtt9oacKBC4vEPLeSlbd+lHbMlfdvxRR0bGI1kus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FVeufRNm; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710138535; x=1741674535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4dUrLHU3oj3tzbYZe1E0dNFsqYHhaDT/JZq6ttfzrl4=;
  b=FVeufRNmkoO9H0mhC3YMREVMLpu+N69wTf30Y1rUCv7Bsq5Pk6ltUF+z
   2UVQhDN8FHTczkyytikHFgHyqU6rdKvHOBQVt0C2vOphf6rV6iwExPUDA
   lrqbcXtX/NytRhWNOh+1wm19s5YXVXvolBKFQ1PcRB949ureTiICPqyOt
   VcsHIpR/IqQvhXv994uNCwJjTIJGlPT3AJ4IDcshBaj33lMwWSSFnMNuM
   A+Bbo9UqxdakoI+32bqxrJuaNRWEufMPGAH1G71J8flnDC/WZfK4cwBWf
   cHGUQSuISMeFKAZV4c7D/cN5QKiBvdricndkAfZWqth+OIg2Pr4/EZiIS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="30226801"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="30226801"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="15657728"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Ayala Beker <ayala.beker@intel.com>
Subject: [PATCH 13/15] wifi: iwlwifi: mvm: Introduce internal MLO passive scan
Date: Mon, 11 Mar 2024 08:28:13 +0200
Message-Id: <20240311081938.a62347877b57.I4a41065f6b3a6ec6c6e44e83bc97c277ff7c599e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
References: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Add a new scan type that can be used for internal MLO purposes, i.e.,
in case updated BSS information is required. Currently only passive
scanning is supported.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  8 ++
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 85 ++++++++++++++++---
 2 files changed, 83 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index d58cd7d41fe1..2421f1f5222c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -493,10 +493,12 @@ enum iwl_scan_status {
 	IWL_MVM_SCAN_REGULAR		= BIT(0),
 	IWL_MVM_SCAN_SCHED		= BIT(1),
 	IWL_MVM_SCAN_NETDETECT		= BIT(2),
+	IWL_MVM_SCAN_INT_MLO		= BIT(3),
 
 	IWL_MVM_SCAN_STOPPING_REGULAR	= BIT(8),
 	IWL_MVM_SCAN_STOPPING_SCHED	= BIT(9),
 	IWL_MVM_SCAN_STOPPING_NETDETECT	= BIT(10),
+	IWL_MVM_SCAN_STOPPING_INT_MLO	= BIT(11),
 
 	IWL_MVM_SCAN_REGULAR_MASK	= IWL_MVM_SCAN_REGULAR |
 					  IWL_MVM_SCAN_STOPPING_REGULAR,
@@ -504,6 +506,8 @@ enum iwl_scan_status {
 					  IWL_MVM_SCAN_STOPPING_SCHED,
 	IWL_MVM_SCAN_NETDETECT_MASK	= IWL_MVM_SCAN_NETDETECT |
 					  IWL_MVM_SCAN_STOPPING_NETDETECT,
+	IWL_MVM_SCAN_INT_MLO_MASK       = IWL_MVM_SCAN_INT_MLO |
+					  IWL_MVM_SCAN_STOPPING_INT_MLO,
 
 	IWL_MVM_SCAN_STOPPING_MASK	= 0xff << IWL_MVM_SCAN_STOPPING_SHIFT,
 	IWL_MVM_SCAN_MASK		= 0xff,
@@ -2007,6 +2011,10 @@ int iwl_mvm_reg_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			   struct ieee80211_scan_ies *ies);
 size_t iwl_mvm_scan_size(struct iwl_mvm *mvm);
 int iwl_mvm_scan_stop(struct iwl_mvm *mvm, int type, bool notify);
+int iwl_mvm_int_mlo_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			       struct ieee80211_channel **channels,
+			       size_t n_channels);
+
 int iwl_mvm_max_scan_ie_len(struct iwl_mvm *mvm);
 void iwl_mvm_report_scan_aborted(struct iwl_mvm *mvm);
 void iwl_mvm_scan_timeout_wk(struct work_struct *work);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index a6f42d55bd98..ea05957fbcec 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1377,11 +1377,14 @@ static void iwl_mvm_scan_umac_dwell(struct iwl_mvm *mvm,
 		cmd->ooc_priority = cpu_to_le32(IWL_SCAN_PRIORITY_EXT_2);
 }
 
-static u32 iwl_mvm_scan_umac_ooc_priority(struct iwl_mvm_scan_params *params)
+static u32 iwl_mvm_scan_umac_ooc_priority(int type)
 {
-	return iwl_mvm_is_regular_scan(params) ?
-		IWL_SCAN_PRIORITY_EXT_6 :
-		IWL_SCAN_PRIORITY_EXT_2;
+	if (type == IWL_MVM_SCAN_REGULAR)
+		return IWL_SCAN_PRIORITY_EXT_6;
+	if (type == IWL_MVM_SCAN_INT_MLO)
+		return IWL_SCAN_PRIORITY_EXT_4;
+
+	return IWL_SCAN_PRIORITY_EXT_2;
 }
 
 static void
@@ -2452,7 +2455,7 @@ static int iwl_mvm_scan_umac_v12(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	mvm->scan_uid_status[uid] = type;
 
-	cmd->ooc_priority = cpu_to_le32(iwl_mvm_scan_umac_ooc_priority(params));
+	cmd->ooc_priority = cpu_to_le32(iwl_mvm_scan_umac_ooc_priority(type));
 	cmd->uid = cpu_to_le32(uid);
 
 	gen_flags = iwl_mvm_scan_umac_flags_v2(mvm, params, vif, type);
@@ -2489,7 +2492,7 @@ static int iwl_mvm_scan_umac_v14_and_above(struct iwl_mvm *mvm,
 
 	mvm->scan_uid_status[uid] = type;
 
-	cmd->ooc_priority = cpu_to_le32(iwl_mvm_scan_umac_ooc_priority(params));
+	cmd->ooc_priority = cpu_to_le32(iwl_mvm_scan_umac_ooc_priority(type));
 	cmd->uid = cpu_to_le32(uid);
 
 	gen_flags = iwl_mvm_scan_umac_flags_v2(mvm, params, vif, type);
@@ -3006,14 +3009,16 @@ static int _iwl_mvm_single_scan_start(struct iwl_mvm *mvm,
 
 	IWL_DEBUG_SCAN(mvm, "Scan request was sent successfully\n");
 	mvm->scan_status |= type;
-	mvm->scan_vif = iwl_mvm_vif_from_mac80211(vif);
+
+	if (type == IWL_MVM_SCAN_REGULAR) {
+		mvm->scan_vif = iwl_mvm_vif_from_mac80211(vif);
+		schedule_delayed_work(&mvm->scan_timeout_dwork,
+				      msecs_to_jiffies(SCAN_TIMEOUT));
+	}
 
 	if (params.enable_6ghz_passive)
 		mvm->last_6ghz_passive_scan_jiffies = jiffies;
 
-	schedule_delayed_work(&mvm->scan_timeout_dwork,
-			      msecs_to_jiffies(SCAN_TIMEOUT));
-
 	return 0;
 }
 
@@ -3189,6 +3194,8 @@ void iwl_mvm_rx_umac_scan_complete_notif(struct iwl_mvm *mvm,
 	} else if (mvm->scan_uid_status[uid] == IWL_MVM_SCAN_SCHED) {
 		ieee80211_sched_scan_stopped(mvm->hw);
 		mvm->sched_scan_pass_all = SCHED_SCAN_PASS_ALL_DISABLED;
+	} else if (mvm->scan_uid_status[uid] == IWL_MVM_SCAN_INT_MLO) {
+		IWL_DEBUG_SCAN(mvm, "Internal MLO scan completed\n");
 	}
 
 	mvm->scan_status &= ~mvm->scan_uid_status[uid];
@@ -3375,6 +3382,12 @@ void iwl_mvm_report_scan_aborted(struct iwl_mvm *mvm)
 			mvm->sched_scan_pass_all = SCHED_SCAN_PASS_ALL_DISABLED;
 			mvm->scan_uid_status[uid] = 0;
 		}
+		uid = iwl_mvm_scan_uid_by_status(mvm, IWL_MVM_SCAN_INT_MLO);
+		if (uid >= 0) {
+			IWL_DEBUG_SCAN(mvm, "Internal MLO scan aborted\n");
+			mvm->scan_uid_status[uid] = 0;
+		}
+
 		uid = iwl_mvm_scan_uid_by_status(mvm,
 						 IWL_MVM_SCAN_STOPPING_REGULAR);
 		if (uid >= 0)
@@ -3385,6 +3398,11 @@ void iwl_mvm_report_scan_aborted(struct iwl_mvm *mvm)
 		if (uid >= 0)
 			mvm->scan_uid_status[uid] = 0;
 
+		uid = iwl_mvm_scan_uid_by_status(mvm,
+						 IWL_MVM_SCAN_STOPPING_INT_MLO);
+		if (uid >= 0)
+			mvm->scan_uid_status[uid] = 0;
+
 		/* We shouldn't have any UIDs still set.  Loop over all the
 		 * UIDs to make sure there's nothing left there and warn if
 		 * any is found.
@@ -3456,3 +3474,50 @@ int iwl_mvm_scan_stop(struct iwl_mvm *mvm, int type, bool notify)
 
 	return ret;
 }
+
+int iwl_mvm_int_mlo_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			       struct ieee80211_channel **channels,
+			       size_t n_channels)
+{
+	struct cfg80211_scan_request *req = NULL;
+	struct ieee80211_scan_ies ies = {};
+	size_t size, i;
+	int ret;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	IWL_DEBUG_SCAN(mvm, "Starting Internal MLO scan: n_channels=%zu\n",
+		       n_channels);
+
+	if (!vif->cfg.assoc || !ieee80211_vif_is_mld(vif))
+		return -EINVAL;
+
+	size = struct_size(req, channels, n_channels);
+	req = kzalloc(size, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	/* set the requested channels */
+	for (i = 0; i < n_channels; i++)
+		req->channels[i] = channels[i];
+
+	req->n_channels = n_channels;
+
+	/* set the rates */
+	for (i = 0; i < NUM_NL80211_BANDS; i++)
+		if (mvm->hw->wiphy->bands[i])
+			req->rates[i] =
+				(1 << mvm->hw->wiphy->bands[i]->n_bitrates) - 1;
+
+	req->wdev = ieee80211_vif_to_wdev(vif);
+	req->wiphy = mvm->hw->wiphy;
+	req->scan_start = jiffies;
+	req->tsf_report_link_id = -1;
+
+	ret = _iwl_mvm_single_scan_start(mvm, vif, req, &ies,
+					 IWL_MVM_SCAN_INT_MLO);
+	kfree(req);
+
+	IWL_DEBUG_SCAN(mvm, "Internal MLO scan: ret=%d\n", ret);
+	return ret;
+}
-- 
2.34.1


