Return-Path: <linux-wireless+bounces-20272-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4AAA5E744
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 23:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE993B28E3
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 22:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B037E1F0E33;
	Wed, 12 Mar 2025 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7gtgGwg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B481F0E28
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 22:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818183; cv=none; b=I79xjGciNlwcSXPq9cJf/ltWGoXLJhDrcKpFQA2YWu8ZyG3bOkgx4wHhnATqR/qXZ82jB4uk5KN7vL4cwNI5rVsmCTGCfnHYyP4PTru/NzC4Sm2ShJs6kJW9nLVwb7Xg1OU1AxjDTxAD6gVaTy0wLVobNBEuv7yZnCVTbT2hdx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818183; c=relaxed/simple;
	bh=mF/PG3eB9sAQWQfYg/PW5VXCNofRojIJ1PSnbbG7ai8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pDsvbC79JFF+ZnAqjqr9AgUG8//CjVtTnGku2sBQiE2++E3U7xqqUW3yYo1+enl0EiUaJEnSAcwR4peMuq8W/34ZLcCmhnjwmHb8jKqfXI7gU3DNC4P+DiDKUQ8ovo3q5/M64M+hFrr05kwxTfvtruXKqjomehQCSptBerXQ2BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7gtgGwg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741818182; x=1773354182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mF/PG3eB9sAQWQfYg/PW5VXCNofRojIJ1PSnbbG7ai8=;
  b=Z7gtgGwgM+RNvdJKqhpQnil0H4IP+9RkuY3CC6XftnQDIiAQxlCZ5K1x
   cbI4mHRI1n5DFkz3hTFnlN1LvmAkQwHZiL2C1vT4Jbfli+huuBi7pW2+S
   T7UTk0e6AZyvgfmhE5/uM04mLcN+1DmCTbIDXYaYc+ecQowSLQRz7q5rH
   f+4/nROZRbnY0Yu8OKuCdt/O24KUJWWQy1Bds68AAim0MerKHzX+svcpM
   vsrPwULLsZxXrd2u8GgWUvkTIgdq795Qt15t019AOeeXUiYame42pSSIM
   gOyPTIJNwJiEjnnnURDELrDKWvRyit5sSf3NNQH9zR7ARsBMe3Limraal
   Q==;
X-CSE-ConnectionGUID: wIQnYcTcTNSs1Uh/MghrxQ==
X-CSE-MsgGUID: 6Ak2CV3BTmGGhG/VUvMVig==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42826750"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42826750"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:23:02 -0700
X-CSE-ConnectionGUID: ZAe0+xsjTguuWsICuvxZ5w==
X-CSE-MsgGUID: r2n6ENd4QxGBz9XVHiMFeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121267380"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:23:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 07/15] wifi: iwlwifi: mld: allow EMLSR for unequal bandwidth
Date: Thu, 13 Mar 2025 00:22:30 +0200
Message-Id: <20250313002008.150c330711c4.Ifd72d2e076783991852a7f1756948b4f0efb9fea@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
References: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Allow EMLSR if the bandwidths of the links are unequal if one of the
following conditions is true:
1. in low latency mode
2. bandwidth of the secondary link is greater than the bandwidth of the
   primary
3. the primary link is active and is loaded enough to justify EMLSR

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/iface.h    | 15 ++---
 .../wireless/intel/iwlwifi/mld/low_latency.c  |  4 ++
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 10 +--
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  | 63 +++++++++++--------
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h  |  4 --
 5 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index 550ae3c9d766..d1d56b081bf6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -52,8 +52,6 @@ enum iwl_mld_emlsr_blocked {
  * @IWL_MLD_EMLSR_EXIT_FAIL_ENTRY: FW failed to enter EMLSR
  * @IWL_MLD_EMLSR_EXIT_CSA: EMLSR prevented due to channel switch on link
  * @IWL_MLD_EMLSR_EXIT_EQUAL_BAND: EMLSR prevented as both links share the band
- * @IWL_MLD_EMLSR_EXIT_BANDWIDTH: Bandwidths of primary and secondary links are
- *      not equal
  * @IWL_MLD_EMLSR_EXIT_LOW_RSSI: Link RSSI is unsuitable for EMLSR
  * @IWL_MLD_EMLSR_EXIT_LINK_USAGE: Exit EMLSR due to low TPT on secondary link
  * @IWL_MLD_EMLSR_EXIT_BT_COEX: Exit EMLSR due to BT coexistence
@@ -68,13 +66,12 @@ enum iwl_mld_emlsr_exit {
 	IWL_MLD_EMLSR_EXIT_FAIL_ENTRY		= 0x4,
 	IWL_MLD_EMLSR_EXIT_CSA			= 0x8,
 	IWL_MLD_EMLSR_EXIT_EQUAL_BAND		= 0x10,
-	IWL_MLD_EMLSR_EXIT_BANDWIDTH		= 0x20,
-	IWL_MLD_EMLSR_EXIT_LOW_RSSI		= 0x40,
-	IWL_MLD_EMLSR_EXIT_LINK_USAGE		= 0x80,
-	IWL_MLD_EMLSR_EXIT_BT_COEX		= 0x100,
-	IWL_MLD_EMLSR_EXIT_CHAN_LOAD		= 0x200,
-	IWL_MLD_EMLSR_EXIT_RFI			= 0x400,
-	IWL_MLD_EMLSR_EXIT_FW_REQUEST		= 0x800,
+	IWL_MLD_EMLSR_EXIT_LOW_RSSI		= 0x20,
+	IWL_MLD_EMLSR_EXIT_LINK_USAGE		= 0x40,
+	IWL_MLD_EMLSR_EXIT_BT_COEX		= 0x80,
+	IWL_MLD_EMLSR_EXIT_CHAN_LOAD		= 0x100,
+	IWL_MLD_EMLSR_EXIT_RFI			= 0x200,
+	IWL_MLD_EMLSR_EXIT_FW_REQUEST		= 0x400,
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c b/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c
index e74e66735f52..a4a612afb3b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c
@@ -7,6 +7,7 @@
 #include "low_latency.h"
 #include "hcmd.h"
 #include "power.h"
+#include "mlo.h"
 
 #define MLD_LL_WK_INTERVAL_MSEC 500
 #define MLD_LL_PERIOD (HZ * MLD_LL_WK_INTERVAL_MSEC / 1000)
@@ -230,6 +231,9 @@ void iwl_mld_vif_update_low_latency(struct iwl_mld *mld,
 		return;
 
 	iwl_mld_update_mac_power(mld, vif, false);
+
+	if (low_latency)
+		iwl_mld_retry_emlsr(mld, vif);
 }
 
 static bool iwl_mld_is_vo_vi_pkt(struct ieee80211_hdr *hdr)
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index f6623988fff6..938cf5900a29 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1187,15 +1187,11 @@ iwl_mld_mac80211_link_info_changed_sta(struct iwl_mld *mld,
 		bw = ieee80211_chan_width_to_rx_bw(link_conf->chanreq.oper.width);
 
 		iwl_mld_omi_ap_changed_bw(mld, link_conf, bw);
-	}
 
-	if (changes & BSS_CHANGED_BANDWIDTH) {
-		if (iwl_mld_emlsr_active(vif))
-			iwl_mld_emlsr_check_equal_bw(mld, vif, link_conf);
-		else
-			/* Channel load threshold may have changed */
-			iwl_mld_retry_emlsr(mld, vif);
 	}
+
+	if (changes & BSS_CHANGED_BANDWIDTH)
+		iwl_mld_retry_emlsr(mld, vif);
 }
 
 static int iwl_mld_update_mu_groups(struct iwl_mld *mld,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index 8f6da90bf82c..9342f03c0908 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -47,7 +47,6 @@ static void iwl_mld_print_emlsr_blocked(struct iwl_mld *mld, u32 mask)
 	HOW(FAIL_ENTRY)			\
 	HOW(CSA)			\
 	HOW(EQUAL_BAND)			\
-	HOW(BANDWIDTH)			\
 	HOW(LOW_RSSI)			\
 	HOW(LINK_USAGE)			\
 	HOW(BT_COEX)			\
@@ -748,6 +747,7 @@ iwl_mld_channel_load_allows_emlsr(struct iwl_mld *mld,
 	struct iwl_mld_link *link_a =
 		iwl_mld_link_dereference_check(mld_vif, a->link_id);
 	struct ieee80211_chanctx_conf *chanctx_a = NULL;
+	u32 bw_a, bw_b, ratio;
 	u32 primary_load_perc;
 
 	if (!link_a || !link_a->active) {
@@ -765,7 +765,34 @@ iwl_mld_channel_load_allows_emlsr(struct iwl_mld *mld,
 
 	IWL_DEBUG_EHT(mld, "Average channel load not by us: %u\n", primary_load_perc);
 
-	return primary_load_perc > iwl_mld_get_min_chan_load_thresh(chanctx_a);
+	if (primary_load_perc < iwl_mld_get_min_chan_load_thresh(chanctx_a)) {
+		IWL_DEBUG_EHT(mld, "Channel load is below the minimum threshold\n");
+		return false;
+	}
+
+	if (iwl_mld_vif_low_latency(mld_vif)) {
+		IWL_DEBUG_EHT(mld, "Low latency vif, EMLSR is allowed\n");
+		return true;
+	}
+
+	if (a->chandef->width <= b->chandef->width)
+		return true;
+
+	bw_a = nl80211_chan_width_to_mhz(a->chandef->width);
+	bw_b = nl80211_chan_width_to_mhz(b->chandef->width);
+	ratio = bw_a / bw_b;
+
+	switch (ratio) {
+	case 2:
+		return primary_load_perc > 25;
+	case 4:
+		return primary_load_perc > 40;
+	case 8:
+	case 16:
+		return primary_load_perc > 50;
+	}
+
+	return false;
 }
 
 static bool
@@ -784,12 +811,6 @@ iwl_mld_valid_emlsr_pair(struct ieee80211_vif *vif,
 
 	if (a->chandef->chan->band == b->chandef->chan->band)
 		reason_mask |= IWL_MLD_EMLSR_EXIT_EQUAL_BAND;
-	if (a->chandef->width != b->chandef->width) {
-		/* TODO: task=EMLSR task=statistics
-		 * replace BANDWIDTH exit reason with channel load criteria
-		 */
-		reason_mask |= IWL_MLD_EMLSR_EXIT_BANDWIDTH;
-	}
 	if (!iwl_mld_channel_load_allows_emlsr(mld, vif, a, b))
 		reason_mask |= IWL_MLD_EMLSR_EXIT_CHAN_LOAD;
 
@@ -941,23 +962,6 @@ void iwl_mld_select_links(struct iwl_mld *mld)
 						NULL);
 }
 
-void iwl_mld_emlsr_check_equal_bw(struct iwl_mld *mld,
-				  struct ieee80211_vif *vif,
-				  struct ieee80211_bss_conf *link)
-{
-	u8 other_link_id = iwl_mld_get_other_link(vif, link->link_id);
-	struct ieee80211_bss_conf *other_link =
-		link_conf_dereference_check(vif, other_link_id);
-
-	if (!ieee80211_vif_link_active(vif, link->link_id) ||
-	    WARN_ON(link->link_id == other_link_id || !other_link))
-		return;
-
-	if (link->chanreq.oper.width != other_link->chanreq.oper.width)
-		iwl_mld_exit_emlsr(mld, vif, IWL_MLD_EMLSR_EXIT_BANDWIDTH,
-				   iwl_mld_get_primary_link(vif));
-}
-
 static void iwl_mld_emlsr_check_bt_iter(void *_data, u8 *mac,
 					struct ieee80211_vif *vif)
 {
@@ -1038,10 +1042,15 @@ static void iwl_mld_chan_load_update_iter(void *_data, u8 *mac,
 	} else {
 		u32 old_chan_load = data->prev_chan_load_not_by_us;
 		u32 new_chan_load = phy->avg_channel_load_not_by_us;
-		u32 thresh = iwl_mld_get_min_chan_load_thresh(chanctx);
+		u32 min_thresh = iwl_mld_get_min_chan_load_thresh(chanctx);
+
+#define THRESHOLD_CROSSED(threshold) \
+	(old_chan_load <= (threshold) && new_chan_load > (threshold))
 
-		if (old_chan_load <= thresh && new_chan_load > thresh)
+		if (THRESHOLD_CROSSED(min_thresh) || THRESHOLD_CROSSED(25) ||
+		    THRESHOLD_CROSSED(40) || THRESHOLD_CROSSED(50))
 			iwl_mld_retry_emlsr(mld, vif);
+#undef THRESHOLD_CROSSED
 	}
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.h b/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
index a5fbe1919c6d..6c652c17069f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
@@ -134,10 +134,6 @@ void iwl_mld_emlsr_unblock_tpt_wk(struct wiphy *wiphy, struct wiphy_work *wk);
 
 void iwl_mld_select_links(struct iwl_mld *mld);
 
-void iwl_mld_emlsr_check_equal_bw(struct iwl_mld *mld,
-				  struct ieee80211_vif *vif,
-				  struct ieee80211_bss_conf *link);
-
 void iwl_mld_emlsr_check_bt(struct iwl_mld *mld);
 
 void iwl_mld_emlsr_check_chan_load(struct ieee80211_hw *hw,
-- 
2.34.1


