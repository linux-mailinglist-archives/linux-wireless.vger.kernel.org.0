Return-Path: <linux-wireless+bounces-7188-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3008BBF76
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 08:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E8A281DAE
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 06:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1DD3D8E;
	Sun,  5 May 2024 06:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBubrUSd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E97C2E3
	for <linux-wireless@vger.kernel.org>; Sun,  5 May 2024 06:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714890032; cv=none; b=gFLJhhGRvgS/0+QL4txlFIZDSSmUxrXY4oA1TqtEZ5SOjhpOru7hNbtijyIucALsp6Dd2YvMhpH1hlbTz7yVp1VaFbaNmtlObn4GbmvlIAqxnSI4s/ck60UI3Fs/QW4QVhMIp1IL/sNvzUdiPSK6PJhO4HFp3nXOL6aEVlHYWaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714890032; c=relaxed/simple;
	bh=4Rds04Yji55POsrMc06eGsBRVfr/P7flP8aG6DXvlBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gh8jagzgjMCBBgdmjb2V/AiENcPBY+9WZ8EuEPV9G+qPzrjAeA9FjaBJHKk3L7FuZztIgqwYMLCrIdr5JJPWXPe+KOnA3KjEsBQlsPwSbdHDNbMu+OHRdiY7/gPV25IbaT8Elv9N2MZX4W070gw+bK2yuqWqSdIoLLNPmtXAURk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KBubrUSd; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714890031; x=1746426031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Rds04Yji55POsrMc06eGsBRVfr/P7flP8aG6DXvlBc=;
  b=KBubrUSd6fMW/iC+u4xzsDSJdQTwiiG1sshLRE3ab1pG8VYNjjM+TIxb
   ZoqUvVlmdPJA88xaw5+Ie6d2qFzlNzyjfKCFX6HI+dwXoXR4aVq78VwOV
   QV51Ypjatn7UfVxU+Qm4ayALMnFAv2n9FVrMNmkKLhfvAhgWC4uedkQa4
   MvRICG0XkwkWvZVtMQCtjlJVzFW79H9lCVFKgQjsSgregmfsQHw2uCMEe
   o8GXa9NkR69g2hC0XXcJM6/S+Cw2kpi4AXuE+si1DA7jKhrboVb/9jdhk
   /RXPTcqn6iZZ8C69stwKL4TjD33zLErCbgP7njVQ5wcwbUP8oBp1Ptp6X
   g==;
X-CSE-ConnectionGUID: Kl7A0SedSs2ncXqTKTCyPA==
X-CSE-MsgGUID: wYvtMw77QLSqmrbdE1x4eA==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14461825"
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="14461825"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:31 -0700
X-CSE-ConnectionGUID: PsFojQp+QDGzEIa0JJn0XQ==
X-CSE-MsgGUID: hea0xll3RxSydvqZgvHjNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="27903619"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Subject: [PATCH 10/15] wifi: iwlwifi: mvm: Disable/enable EMLSR due to link's bandwidth/band
Date: Sun,  5 May 2024 09:19:54 +0300
Message-Id: <20240505091420.4e473d4f7f5c.I3adf5619b60bfba8af0cd7eae9dac947419603b6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
References: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

Enable EMLSR when bandwidth settings meet the criteria in
both band and width, otherwise disable.

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  7 +++
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 27 ++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 +
 .../wireless/intel/iwlwifi/mvm/tests/links.c  | 61 ++++++++-----------
 4 files changed, 63 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 9d7f9e5be253..b2a52e7b4a1c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -629,6 +629,13 @@ bool iwl_mvm_mld_valid_link_pair(struct ieee80211_vif *vif,
 	    iwl_mvm_esr_disallowed_with_link(vif, b, false))
 		return false;
 
+	if (a->chandef->width != b->chandef->width)
+		return false;
+
+	if (!(a->chandef->chan->band == NL80211_BAND_6GHZ &&
+	      b->chandef->chan->band == NL80211_BAND_5GHZ))
+		return false;
+
 	/* Per-combination considerations */
 	return a->chandef->chan->band != b->chandef->chan->band;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 31669996ecce..de04b44bcf48 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -693,6 +693,25 @@ static int iwl_mvm_mld_mac_sta_state(struct ieee80211_hw *hw,
 					    &callbacks);
 }
 
+static bool iwl_mvm_esr_bw_criteria(struct iwl_mvm *mvm,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_bss_conf *link_conf)
+{
+	struct ieee80211_bss_conf *other_link;
+	int link_id;
+
+	/* Exit EMLSR if links don't have equal bandwidths */
+	for_each_vif_active_link(vif, other_link, link_id) {
+		if (link_id == link_conf->link_id)
+			continue;
+		if (link_conf->chanreq.oper.width ==
+		    other_link->chanreq.oper.width)
+			return true;
+	}
+
+	return false;
+}
+
 static void
 iwl_mvm_mld_link_info_changed_station(struct iwl_mvm *mvm,
 				      struct ieee80211_vif *vif,
@@ -722,6 +741,14 @@ iwl_mvm_mld_link_info_changed_station(struct iwl_mvm *mvm,
 		link_changes |= LINK_CONTEXT_MODIFY_HE_PARAMS;
 	}
 
+	if ((changes & BSS_CHANGED_BANDWIDTH) &&
+	    ieee80211_vif_link_active(vif, link_conf->link_id) &&
+	    mvmvif->esr_active &&
+	    !iwl_mvm_esr_bw_criteria(mvm, vif, link_conf))
+		iwl_mvm_exit_esr(mvm, vif,
+				 IWL_MVM_ESR_EXIT_BANDWIDTH,
+				 iwl_mvm_get_primary_link(vif));
+
 	/* if associated, maybe puncturing changed - we'll check later */
 	if (vif->cfg.assoc)
 		link_changes |= LINK_CONTEXT_MODIFY_EHT_PARAMS;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index bc1826450048..433b29334039 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -363,6 +363,8 @@ struct iwl_mvm_vif_link_info {
  *	due to low RSSI.
  * @IWL_MVM_ESR_EXIT_COEX: link is deactivated/not allowed for EMLSR
  *	due to BT Coex.
+ * @IWL_MVM_ESR_EXIT_BANDWIDTH: Bandwidths of primary and secondry links
+ *	preventing the enablement of EMLSR
  */
 enum iwl_mvm_esr_state {
 	IWL_MVM_ESR_BLOCKED_PREVENTION	= 0x1,
@@ -372,6 +374,7 @@ enum iwl_mvm_esr_state {
 	IWL_MVM_ESR_EXIT_MISSED_BEACON	= 0x10000,
 	IWL_MVM_ESR_EXIT_LOW_RSSI	= 0x20000,
 	IWL_MVM_ESR_EXIT_COEX		= 0x40000,
+	IWL_MVM_ESR_EXIT_BANDWIDTH	= 0x80000,
 };
 
 #define IWL_MVM_BLOCK_ESR_REASONS 0xffff
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c b/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
index 217dbb823691..66dd89103dfe 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
@@ -241,15 +241,15 @@ static const struct valid_link_pair_case {
 } valid_link_pair_cases[] = {
 	{
 		.desc = "HB + UHB, valid.",
-		.chan_a = &chan_5ghz,
-		.chan_b = &chan_6ghz,
+		.chan_a = &chan_6ghz,
+		.chan_b = &chan_5ghz,
 		.valid = true,
 	},
 	{
 		.desc = "LB + HB, no BT.",
 		.chan_a = &chan_2ghz,
 		.chan_b = &chan_5ghz,
-		.valid = true,
+		.valid = false,
 	},
 	{
 		.desc = "LB + HB, with BT.",
@@ -273,75 +273,66 @@ static const struct valid_link_pair_case {
 		.valid = false,
 	},
 	{
-		.desc = "RSSI: LB, 20 MHz, high",
-		.chan_a = &chan_2ghz,
+		.desc = "RSSI: UHB, 20 MHz, high",
+		.chan_a = &chan_6ghz,
 		.cw_a = NL80211_CHAN_WIDTH_20,
 		.sig_a = -66,
 		.chan_b = &chan_5ghz,
+		.cw_b = NL80211_CHAN_WIDTH_20,
 		.valid = true,
 	},
 	{
-		.desc = "RSSI: LB, 40 MHz, low",
-		.chan_a = &chan_2ghz,
+		.desc = "RSSI: UHB, 40 MHz, low",
+		.chan_a = &chan_6ghz,
 		.cw_a = NL80211_CHAN_WIDTH_40,
 		.sig_a = -65,
 		.chan_b = &chan_5ghz,
+		.cw_b = NL80211_CHAN_WIDTH_40,
 		.valid = false,
 	},
 	{
-		.desc = "RSSI: LB, 40 MHz, high",
-		.chan_a = &chan_2ghz,
+		.desc = "RSSI: UHB, 40 MHz, high",
+		.chan_a = &chan_6ghz,
 		.cw_a = NL80211_CHAN_WIDTH_40,
 		.sig_a = -63,
 		.chan_b = &chan_5ghz,
+		.cw_b = NL80211_CHAN_WIDTH_40,
 		.valid = true,
 	},
 	{
-		.desc = "RSSI: HB, 80 MHz, low",
-		.chan_a = &chan_5ghz,
+		.desc = "RSSI: UHB, 80 MHz, low",
+		.chan_a = &chan_6ghz,
 		.cw_a = NL80211_CHAN_WIDTH_80,
 		.sig_a = -62,
-		.chan_b = &chan_2ghz,
+		.chan_b = &chan_5ghz,
+		.cw_b = NL80211_CHAN_WIDTH_80,
 		.valid = false,
 	},
 	{
-		.desc = "RSSI: HB, 80 MHz, high",
-		.chan_a = &chan_5ghz,
+		.desc = "RSSI: UHB, 80 MHz, high",
+		.chan_a = &chan_6ghz,
 		.cw_a = NL80211_CHAN_WIDTH_80,
 		.sig_a = -60,
-		.chan_b = &chan_2ghz,
+		.chan_b = &chan_5ghz,
+		.cw_b = NL80211_CHAN_WIDTH_80,
 		.valid = true,
 	},
 	{
-		.desc = "RSSI: HB, 160 MHz, low",
-		.chan_a = &chan_5ghz,
+		.desc = "RSSI: UHB, 160 MHz, low",
+		.chan_a = &chan_6ghz,
 		.cw_a = NL80211_CHAN_WIDTH_160,
 		.sig_a = -59,
-		.chan_b = &chan_2ghz,
+		.chan_b = &chan_5ghz,
+		.cw_b = NL80211_CHAN_WIDTH_160,
 		.valid = false,
 	},
 	{
 		.desc = "RSSI: HB, 160 MHz, high",
-		.chan_a = &chan_5ghz,
+		.chan_a = &chan_6ghz,
 		.cw_a = NL80211_CHAN_WIDTH_160,
 		.sig_a = -5,
-		.chan_b = &chan_2ghz,
-		.valid = true,
-	},
-	{
-		.desc = "RSSI: UHB, 320 MHz, low",
-		.chan_a = &chan_6ghz,
-		.cw_a = NL80211_CHAN_WIDTH_320,
-		.sig_a = -68,
-		.chan_b = &chan_6ghz,
-		.valid = false,
-	},
-	{
-		.desc = "RSSI: UHB, 320 MHz, high",
-		.chan_a = &chan_6ghz,
-		.cw_a = NL80211_CHAN_WIDTH_320,
-		.sig_a = -66,
 		.chan_b = &chan_5ghz,
+		.cw_b = NL80211_CHAN_WIDTH_160,
 		.valid = true,
 	},
 };
-- 
2.34.1


