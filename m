Return-Path: <linux-wireless+bounces-23966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D801AD496E
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 05:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD47416A2A8
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC85F1F7904;
	Wed, 11 Jun 2025 03:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MlHV5wUd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1A0221708
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 03:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749612884; cv=none; b=PSQ+UrfyJtyIPVIWzCygtfjk6ZkvZwh8gI6xuskmYM3k2fYZhxY3QtoEi9Vs2vkUnVTaCOrdOd1wyyo57Thp1yaH3f2F7VbP+04CPt6iU+M/7YeH73+kF8OEoi9XZt/A7Suy3QxiqnnEYe1AEhLVgGuGVi6yFDMNuXIGLwq34fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749612884; c=relaxed/simple;
	bh=upJdgO0YoDXWHgyMLaOstcjSmA+5OZbHowYyTIq4BIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iB/wpN5AkR3w/1dwDRLWZNdPgffkr4TudxcneXGMOqU7BQwUUJKNrPQcAfXavnlcIrBsSxLx8r/EOC87LLTy+K+ksI8H/I6euRe6+epQCd7PVgSWAwMkCAxr9BzD+mq6/9mZJBRvdjZQutpn5uosAxZaPoa6OXcL599WqJCQltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MlHV5wUd; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749612883; x=1781148883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=upJdgO0YoDXWHgyMLaOstcjSmA+5OZbHowYyTIq4BIk=;
  b=MlHV5wUdYuZmxjJfDVlljDelQ+ljgZSgDtV/bj/xJkG0Hr87dYQbAaCz
   gHqSG3exxIxC5ZCotFDc/tid5eAZG33VzDhdGg/bvvVrfxKO+Z2PiPkxb
   Rx0IGfRO4D5sMStK8jTMIo/95bPL8rTHAAKNrPYPqv58zaUSd1L7xvr5c
   nsbrYGJhpCgsrR6DbDl6osyrO6PAizo38prcRIX1gjkR2SeNeiopP4WeT
   N8Gp9LUZdfgk2UkV896NaiopwSRpDXjYcr2rj5YiGFMoqCc7lmEo55zLD
   tFYBwkojZVstyvmVfZrTm3x8T9rWBAfriNAMA1d2hYgmqZJxZl4ktoYmh
   w==;
X-CSE-ConnectionGUID: 37L9QmHHRPOtbtchfLMs5w==
X-CSE-MsgGUID: KuN/l9lFRgaoscVkq/e/XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="63094893"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="63094893"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:43 -0700
X-CSE-ConnectionGUID: giKpQRd1TS+NcbbPU9PW1g==
X-CSE-MsgGUID: cLumpeO8TB6BIVduPHi2Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="150880953"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:41 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: defer MLO scan after link activation
Date: Wed, 11 Jun 2025 06:34:09 +0300
Message-Id: <20250611063124.09548e958a9e.I24dbfd425da260f3ae6fa5a48fe25bd4ab6fcf99@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
References: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Doing a scan right after link activation can be less reliable
than at other times, as the firmware is still busy trying to
catch beacons from the just activated link, etc. In case a new
MLO scan request comes in, defer it for a few seconds after a
link activation.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/iface.c | 15 +++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/iface.h | 12 ++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/link.c  |  4 ++++
 drivers/net/wireless/intel/iwlwifi/mld/scan.c  | 12 ++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index 235b55e0fe59..38993d65c052 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -55,6 +55,8 @@ void iwl_mld_cleanup_vif(void *data, u8 *mac, struct ieee80211_vif *vif)
 
 	ieee80211_iter_keys(mld->hw, vif, iwl_mld_cleanup_keys_iter, NULL);
 
+	wiphy_delayed_work_cancel(mld->wiphy, &mld_vif->mlo_scan_start_wk);
+
 	CLEANUP_STRUCT(mld_vif);
 }
 
@@ -385,6 +387,17 @@ int iwl_mld_mac_fw_action(struct iwl_mld *mld, struct ieee80211_vif *vif,
 	return iwl_mld_send_mac_cmd(mld, &cmd);
 }
 
+static void iwl_mld_mlo_scan_start_wk(struct wiphy *wiphy,
+				      struct wiphy_work *wk)
+{
+	struct iwl_mld_vif *mld_vif = container_of(wk, struct iwl_mld_vif,
+						   mlo_scan_start_wk.work);
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
+
+	iwl_mld_int_mlo_scan(mld, iwl_mld_vif_to_mac80211(mld_vif));
+}
+
 IWL_MLD_ALLOC_FN(vif, vif)
 
 /* Constructor function for struct iwl_mld_vif */
@@ -412,6 +425,8 @@ iwl_mld_init_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
 					iwl_mld_emlsr_prevent_done_wk);
 		wiphy_delayed_work_init(&mld_vif->emlsr.tmp_non_bss_done_wk,
 					iwl_mld_emlsr_tmp_non_bss_done_wk);
+		wiphy_delayed_work_init(&mld_vif->mlo_scan_start_wk,
+					iwl_mld_mlo_scan_start_wk);
 	}
 	iwl_mld_init_internal_sta(&mld_vif->aux_sta);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index 49e2ce65557d..874e9ef9e798 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -133,6 +133,8 @@ struct iwl_mld_emlsr {
  * @low_latency_causes: bit flags, indicating the causes for low-latency,
  *	see @iwl_mld_low_latency_cause.
  * @ps_disabled: indicates that PS is disabled for this interface
+ * @last_link_activation_time: last time a link was activated, for
+ *	deferring MLO scans (to make them more reliable)
  * @mld: pointer to the mld structure.
  * @deflink: default link data, for use in non-MLO,
  * @link: reference to link data for each valid link, for use in MLO.
@@ -144,6 +146,7 @@ struct iwl_mld_emlsr {
  * @roc_activity: the id of the roc_activity running. Relevant for STA and
  *	p2p device only. Set to %ROC_NUM_ACTIVITIES when not in use.
  * @aux_sta: station used for remain on channel. Used in P2P device.
+ * @mlo_scan_start_wk: worker to start a deferred MLO scan
  */
 struct iwl_mld_vif {
 	/* Add here fields that need clean up on restart */
@@ -161,6 +164,7 @@ struct iwl_mld_vif {
 #endif
 		u8 low_latency_causes;
 		bool ps_disabled;
+		time64_t last_link_activation_time;
 	);
 	/* And here fields that survive a fw restart */
 	struct iwl_mld *mld;
@@ -179,6 +183,8 @@ struct iwl_mld_vif {
 #endif
 	enum iwl_roc_activity roc_activity;
 	struct iwl_mld_int_sta aux_sta;
+
+	struct wiphy_delayed_work mlo_scan_start_wk;
 };
 
 static inline struct iwl_mld_vif *
@@ -187,6 +193,12 @@ iwl_mld_vif_from_mac80211(struct ieee80211_vif *vif)
 	return (void *)vif->drv_priv;
 }
 
+static inline struct ieee80211_vif *
+iwl_mld_vif_to_mac80211(struct iwl_mld_vif *mld_vif)
+{
+	return container_of((void *)mld_vif, struct ieee80211_vif, drv_priv);
+}
+
 #define iwl_mld_link_dereference_check(mld_vif, link_id)		\
 	rcu_dereference_check((mld_vif)->link[link_id],			\
 			      lockdep_is_held(&mld_vif->mld->wiphy->mtx))
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index d0f56189ad3f..c65ac6ecbd1d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -404,6 +404,7 @@ int iwl_mld_activate_link(struct iwl_mld *mld,
 			  struct ieee80211_bss_conf *link)
 {
 	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(mld_link->vif);
 	int ret;
 
 	lockdep_assert_wiphy(mld->wiphy);
@@ -418,6 +419,9 @@ int iwl_mld_activate_link(struct iwl_mld *mld,
 					LINK_CONTEXT_MODIFY_ACTIVE);
 	if (ret)
 		mld_link->active = false;
+	else
+		mld_vif->last_link_activation_time =
+			ktime_get_boottime_seconds();
 
 	return ret;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/scan.c b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
index 55d54bf29eae..cf3063e6ec53 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
@@ -1800,9 +1800,12 @@ static void iwl_mld_int_mlo_scan_start(struct iwl_mld *mld,
 	IWL_DEBUG_SCAN(mld, "Internal MLO scan: ret=%d\n", ret);
 }
 
+#define IWL_MLD_MLO_SCAN_BLOCKOUT_TIME		5 /* seconds */
+
 void iwl_mld_int_mlo_scan(struct iwl_mld *mld, struct ieee80211_vif *vif)
 {
 	struct ieee80211_channel *channels[IEEE80211_MLD_MAX_NUM_LINKS];
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
 	unsigned long usable_links = ieee80211_vif_usable_links(vif);
 	size_t n_channels = 0;
 	u8 link_id;
@@ -1818,6 +1821,15 @@ void iwl_mld_int_mlo_scan(struct iwl_mld *mld, struct ieee80211_vif *vif)
 		return;
 	}
 
+	if (mld_vif->last_link_activation_time > ktime_get_boottime_seconds() -
+						 IWL_MLD_MLO_SCAN_BLOCKOUT_TIME) {
+		/* timing doesn't matter much, so use the blockout time */
+		wiphy_delayed_work_queue(mld->wiphy,
+					 &mld_vif->mlo_scan_start_wk,
+					 IWL_MLD_MLO_SCAN_BLOCKOUT_TIME);
+		return;
+	}
+
 	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct ieee80211_bss_conf *link_conf =
 			link_conf_dereference_check(vif, link_id);
-- 
2.34.1


