Return-Path: <linux-wireless+bounces-28068-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13FFBEE0FE
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357C03A7083
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08102BDC01;
	Sun, 19 Oct 2025 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YDCDkI4v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E442BE653
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863550; cv=none; b=BqxYRoFTfzyaCdsMUXVOCTEpzuLZrWjy8iPxmPNPiNPew3KO9xiBTIjUGWnFNU/xZf+80N9cgcfs+qUruT7/bJk33DVU+7FzxNAexle14cr/f9emRyj8209R3wSy4kVqV6D8PR2LjcSUBgBFHegcTCX6NvRal20gOpCbS7hxUAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863550; c=relaxed/simple;
	bh=nb/DQiIQjIE324eJGk2LLRLwx8AhY+Dzf0y+POW0eCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iRzOA/3lIfJAWHLuxQ+OwKNBBSlERuadaRLQxnbuz4XAAV3teB0pLcHxcg+fsPRZGBHHeYlT2syR6ny6R/p4W5JQsQdKhmLZB28wXt0goJDM2RV1kh4WgZiD6I2RDcaqqsbDwcQfxnOUvMhH/IUtm1VV4n+80wkp/hUxGEf89tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YDCDkI4v; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760863549; x=1792399549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nb/DQiIQjIE324eJGk2LLRLwx8AhY+Dzf0y+POW0eCQ=;
  b=YDCDkI4vutqpMIbm2RDqvbU3KzrkA1WheBVCcyHyLM7BTaO/9ONZ7Okj
   XJXkKsso7uCQKF6nPS4G9yGIeqI7dI3Ljxr35+rl7tuQovLXztXDpQl7m
   abGLqHsT6qZ67m8+XiKYEYymJGXwVcoLresnwq3DU+hcu1OqmsAnPFH5H
   8tUdEizPk2dJRTC9s674UIGn7MKZzY4BvUhFMW3MJoWrizxgpJIZTjzdH
   82L0vA5rkBgwdNo/sJ/5LUQFouqEtB1dZ1WcjpHHPFKyQAt8aE2V73CJX
   3BEvY1JMxHAu2KtvvU3sAlYMbxaTjVXqnEG0QzhaEDjHvqtwTzd9wo3Xy
   w==;
X-CSE-ConnectionGUID: lkpokyUVQuG6VJBkKqQhXw==
X-CSE-MsgGUID: p+8MvXzZTWaxzSNPgzoqaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74363194"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="74363194"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:49 -0700
X-CSE-ConnectionGUID: yGUREXXOR/G9T/elNQvm0w==
X-CSE-MsgGUID: eYUkI2GjTTmDdn3upPB0mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="182279908"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Nidhish A N <nidhish.a.n@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: mld: Move EMLSR prints to IWL_DL_EHT
Date: Sun, 19 Oct 2025 11:45:14 +0300
Message-Id: <20251019114304.3bfc2bc8f410.I405ab2aa81af1ba0ea5eaff343eae1778f2035d9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
References: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Nidhish A N <nidhish.a.n@intel.com>

Modify EMLSR debug prints to use IWL_DL_EHT instead
of IWL_DL_INFO. This will allow better communication
with validation as they might enable only IWL_DL_EHT
or IWL_DL_INFO as required.

Add prints to log attempt to switch links when
missed beacons exceed threshold.

Print both link ids and missed beacons when in EMLSR
mode.

Signed-off-by: Nidhish A N <nidhish.a.n@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c |  9 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  | 97 +++++++++----------
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |  2 +-
 3 files changed, 52 insertions(+), 56 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 738f80fe0c50..deb1e7227dd8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -571,8 +571,12 @@ void iwl_mld_handle_missed_beacon_notif(struct iwl_mld *mld,
 		/* Not in EMLSR and we can't hear the link.
 		 * Try to switch to a better link. EMLSR case is handled below.
 		 */
-		if (!iwl_mld_emlsr_active(vif))
+		if (!iwl_mld_emlsr_active(vif)) {
+			IWL_DEBUG_EHT(mld,
+				      "missed beacons exceeds threshold. link_id=%u. Try to switch to a better link.\n",
+				      link_id);
 			iwl_mld_int_mlo_scan(mld, vif);
+		}
 	}
 
 	/* no more logic if we're not in EMLSR */
@@ -591,7 +595,8 @@ void iwl_mld_handle_missed_beacon_notif(struct iwl_mld *mld,
 		return;
 
 	IWL_DEBUG_EHT(mld,
-		      "missed bcn on the other link (link_id=%u): %u\n",
+		      "missed bcn link_id=%u: %u consecutive=%u, other link_id=%u: %u\n",
+		      link_id, missed_bcon, missed_bcon_since_rx,
 		      other_link->link_id, scnd_lnk_bcn_lost);
 
 	/* Exit EMLSR if we lost more than
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index fa04fbe06656..c6b151f26921 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -31,11 +31,9 @@ static void iwl_mld_print_emlsr_blocked(struct iwl_mld *mld, u32 mask)
 {
 #define NAME_FMT(x) "%s"
 #define NAME_PR(x) (mask & IWL_MLD_EMLSR_BLOCKED_##x) ? "[" #x "]" : "",
-	IWL_DEBUG_INFO(mld,
-		       "EMLSR blocked = " HANDLE_EMLSR_BLOCKED_REASONS(NAME_FMT)
-		       " (0x%x)\n",
-		       HANDLE_EMLSR_BLOCKED_REASONS(NAME_PR)
-		       mask);
+	IWL_DEBUG_EHT(mld,
+		      "EMLSR blocked = " HANDLE_EMLSR_BLOCKED_REASONS(NAME_FMT)
+		      " (0x%x)\n", HANDLE_EMLSR_BLOCKED_REASONS(NAME_PR) mask);
 #undef NAME_FMT
 #undef NAME_PR
 }
@@ -72,11 +70,9 @@ static void iwl_mld_print_emlsr_exit(struct iwl_mld *mld, u32 mask)
 {
 #define NAME_FMT(x) "%s"
 #define NAME_PR(x) (mask & IWL_MLD_EMLSR_EXIT_##x) ? "[" #x "]" : "",
-	IWL_DEBUG_INFO(mld,
-		       "EMLSR exit = " HANDLE_EMLSR_EXIT_REASONS(NAME_FMT)
-		       " (0x%x)\n",
-		       HANDLE_EMLSR_EXIT_REASONS(NAME_PR)
-		       mask);
+	IWL_DEBUG_EHT(mld,
+		      "EMLSR exit = " HANDLE_EMLSR_EXIT_REASONS(NAME_FMT)
+		      " (0x%x)\n", HANDLE_EMLSR_EXIT_REASONS(NAME_PR) mask);
 #undef NAME_FMT
 #undef NAME_PR
 }
@@ -170,10 +166,10 @@ static void iwl_mld_check_emlsr_prevention(struct iwl_mld *mld,
 		WARN_ON(mld_vif->emlsr.exit_repeat_count > 3);
 	}
 
-	IWL_DEBUG_INFO(mld,
-		       "Preventing EMLSR for %ld seconds due to %u exits with the reason = %s (0x%x)\n",
-		       delay / HZ, mld_vif->emlsr.exit_repeat_count,
-		       iwl_mld_get_emlsr_exit_string(reason), reason);
+	IWL_DEBUG_EHT(mld,
+		      "Preventing EMLSR for %ld seconds due to %u exits with the reason = %s (0x%x)\n",
+		      delay / HZ, mld_vif->emlsr.exit_repeat_count,
+		      iwl_mld_get_emlsr_exit_string(reason), reason);
 
 	wiphy_delayed_work_queue(mld->wiphy,
 				 &mld_vif->emlsr.prevent_done_wk, delay);
@@ -217,10 +213,10 @@ static int _iwl_mld_exit_emlsr(struct iwl_mld *mld, struct ieee80211_vif *vif,
 		link_to_keep = __ffs(vif->active_links);
 
 	new_active_links = BIT(link_to_keep);
-	IWL_DEBUG_INFO(mld,
-		       "Exiting EMLSR. reason = %s (0x%x). Current active links=0x%x, new active links = 0x%x\n",
-		       iwl_mld_get_emlsr_exit_string(exit), exit,
-		       vif->active_links, new_active_links);
+	IWL_DEBUG_EHT(mld,
+		      "Exiting EMLSR. reason = %s (0x%x). Current active links=0x%x, new active links = 0x%x\n",
+		      iwl_mld_get_emlsr_exit_string(exit), exit,
+		      vif->active_links, new_active_links);
 
 	if (sync)
 		ret = ieee80211_set_active_links(vif, new_active_links);
@@ -262,9 +258,8 @@ static int _iwl_mld_emlsr_block(struct iwl_mld *mld, struct ieee80211_vif *vif,
 
 	mld_vif->emlsr.blocked_reasons |= reason;
 
-	IWL_DEBUG_INFO(mld,
-		       "Blocking EMLSR mode. reason = %s (0x%x)\n",
-		       iwl_mld_get_emlsr_blocked_string(reason), reason);
+	IWL_DEBUG_EHT(mld, "Blocking EMLSR mode. reason = %s (0x%x)\n",
+		      iwl_mld_get_emlsr_blocked_string(reason), reason);
 	iwl_mld_print_emlsr_blocked(mld, mld_vif->emlsr.blocked_reasons);
 
 	if (reason == IWL_MLD_EMLSR_BLOCKED_TPT)
@@ -335,9 +330,8 @@ void iwl_mld_unblock_emlsr(struct iwl_mld *mld, struct ieee80211_vif *vif,
 
 	mld_vif->emlsr.blocked_reasons &= ~reason;
 
-	IWL_DEBUG_INFO(mld,
-		       "Unblocking EMLSR mode. reason = %s (0x%x)\n",
-		       iwl_mld_get_emlsr_blocked_string(reason), reason);
+	IWL_DEBUG_EHT(mld, "Unblocking EMLSR mode. reason = %s (0x%x)\n",
+		      iwl_mld_get_emlsr_blocked_string(reason), reason);
 	iwl_mld_print_emlsr_blocked(mld, mld_vif->emlsr.blocked_reasons);
 
 	if (reason == IWL_MLD_EMLSR_BLOCKED_TPT)
@@ -348,7 +342,7 @@ void iwl_mld_unblock_emlsr(struct iwl_mld *mld, struct ieee80211_vif *vif,
 	if (mld_vif->emlsr.blocked_reasons)
 		return;
 
-	IWL_DEBUG_INFO(mld, "EMLSR is unblocked\n");
+	IWL_DEBUG_EHT(mld, "EMLSR is unblocked\n");
 	iwl_mld_int_mlo_scan(mld, vif);
 }
 
@@ -365,18 +359,17 @@ iwl_mld_vif_iter_emlsr_mode_notif(void *data, u8 *mac,
 
 	switch (action) {
 	case ESR_RECOMMEND_LEAVE:
-		IWL_DEBUG_INFO(mld_vif->mld,
-			       "FW recommend leave reason = 0x%x\n",
-			       le32_to_cpu(notif->leave_reason_mask));
+		IWL_DEBUG_EHT(mld_vif->mld,
+			      "FW recommend leave reason = 0x%x\n",
+			      le32_to_cpu(notif->leave_reason_mask));
 
 		iwl_mld_exit_emlsr(mld_vif->mld, vif,
 				   IWL_MLD_EMLSR_EXIT_FW_REQUEST,
 				   iwl_mld_get_primary_link(vif));
 		break;
 	case ESR_FORCE_LEAVE:
-		IWL_DEBUG_INFO(mld_vif->mld,
-			       "FW force leave reason = 0x%x\n",
-			       le32_to_cpu(notif->leave_reason_mask));
+		IWL_DEBUG_EHT(mld_vif->mld, "FW force leave reason = 0x%x\n",
+			      le32_to_cpu(notif->leave_reason_mask));
 		fallthrough;
 	case ESR_RECOMMEND_ENTER:
 	default:
@@ -412,11 +405,12 @@ void iwl_mld_handle_emlsr_trans_fail_notif(struct iwl_mld *mld,
 	struct ieee80211_bss_conf *bss_conf =
 		iwl_mld_fw_id_to_link_conf(mld, fw_link_id);
 
-	IWL_DEBUG_INFO(mld, "Failed to %s EMLSR on link %d (FW: %d), reason %d\n",
-		       le32_to_cpu(notif->activation) ? "enter" : "exit",
-		       bss_conf ? bss_conf->link_id : -1,
-		       le32_to_cpu(notif->link_id),
-		       le32_to_cpu(notif->err_code));
+	IWL_DEBUG_EHT(mld,
+		      "Failed to %s EMLSR on link %d (FW: %d), reason %d\n",
+		      le32_to_cpu(notif->activation) ? "enter" : "exit",
+		      bss_conf ? bss_conf->link_id : -1,
+		      le32_to_cpu(notif->link_id),
+		      le32_to_cpu(notif->err_code));
 
 	if (IWL_FW_CHECK(mld, !bss_conf,
 			 "FW reported failure to %sactivate EMLSR on a non-existing link: %d\n",
@@ -590,8 +584,8 @@ void iwl_mld_emlsr_check_tpt(struct wiphy *wiphy, struct wiphy_work *wk)
 		spin_unlock_bh(&queue_counter->lock);
 	}
 
-	IWL_DEBUG_INFO(mld, "total Tx MPDUs: %ld. total Rx MPDUs: %ld\n",
-		       total_tx, total_rx);
+	IWL_DEBUG_EHT(mld, "total Tx MPDUs: %ld. total Rx MPDUs: %ld\n",
+		      total_tx, total_rx);
 
 	/* If we don't have enough MPDUs - exit EMLSR */
 	if (total_tx < IWL_MLD_ENTER_EMLSR_TPT_THRESH &&
@@ -605,8 +599,8 @@ void iwl_mld_emlsr_check_tpt(struct wiphy *wiphy, struct wiphy_work *wk)
 	if (sec_link_id == -1)
 		goto schedule;
 
-	IWL_DEBUG_INFO(mld, "Secondary Link %d: Tx MPDUs: %ld. Rx MPDUs: %ld\n",
-		       sec_link_id, sec_link_tx, sec_link_rx);
+	IWL_DEBUG_EHT(mld, "Secondary Link %d: Tx MPDUs: %ld. Rx MPDUs: %ld\n",
+		      sec_link_id, sec_link_tx, sec_link_rx);
 
 	/* Calculate the percentage of the secondary link TX/RX */
 	sec_link_tx_perc = total_tx ? sec_link_tx * 100 / total_tx : 0;
@@ -703,10 +697,8 @@ iwl_mld_emlsr_disallowed_with_link(struct iwl_mld *mld,
 		ret |= IWL_MLD_EMLSR_EXIT_CSA;
 
 	if (ret) {
-		IWL_DEBUG_INFO(mld,
-			       "Link %d is not allowed for EMLSR as %s\n",
-			       link->link_id,
-			       primary ? "primary" : "secondary");
+		IWL_DEBUG_EHT(mld, "Link %d is not allowed for EMLSR as %s\n",
+			      link->link_id, primary ? "primary" : "secondary");
 		iwl_mld_print_emlsr_exit(mld, ret);
 	}
 
@@ -870,13 +862,12 @@ iwl_mld_emlsr_pair_state(struct ieee80211_vif *vif,
 		reason_mask |= IWL_MLD_EMLSR_EXIT_CHAN_LOAD;
 
 	if (reason_mask) {
-		IWL_DEBUG_INFO(mld,
-			       "Links %d and %d are not a valid pair for EMLSR\n",
-			       a->link_id, b->link_id);
-		IWL_DEBUG_INFO(mld,
-			       "Links bandwidth are: %d and %d\n",
-			       nl80211_chan_width_to_mhz(a->chandef->width),
-			       nl80211_chan_width_to_mhz(b->chandef->width));
+		IWL_DEBUG_EHT(mld,
+			      "Links %d and %d are not a valid pair for EMLSR\n",
+			      a->link_id, b->link_id);
+		IWL_DEBUG_EHT(mld, "Links bandwidth are: %d and %d\n",
+			      nl80211_chan_width_to_mhz(a->chandef->width),
+			      nl80211_chan_width_to_mhz(b->chandef->width));
 		iwl_mld_print_emlsr_exit(mld, reason_mask);
 	}
 
@@ -994,8 +985,8 @@ static void _iwl_mld_select_links(struct iwl_mld *mld,
 	}
 
 set_active:
-	IWL_DEBUG_INFO(mld, "Link selection result: 0x%x. Primary = %d\n",
-		       new_active, new_primary);
+	IWL_DEBUG_EHT(mld, "Link selection result: 0x%x. Primary = %d\n",
+		      new_active, new_primary);
 
 	mld_vif->emlsr.selected_primary = new_primary;
 	mld_vif->emlsr.selected_links = new_active;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index 5cdbfa29a202..61ecc33116cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -890,7 +890,7 @@ static void iwl_mld_count_mpdu(struct ieee80211_link_sta *link_sta, int queue,
 		       sizeof(queue_counter->per_link));
 		queue_counter->window_start_time = jiffies;
 
-		IWL_DEBUG_INFO(mld, "MPDU counters are cleared\n");
+		IWL_DEBUG_EHT(mld, "MPDU counters are cleared\n");
 	}
 
 	link_counter = &queue_counter->per_link[mld_link->fw_id];
-- 
2.34.1


