Return-Path: <linux-wireless+bounces-9884-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6142D924FE1
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 05:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1841F22BAC
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 03:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65830182BB;
	Wed,  3 Jul 2024 03:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PiC93lKy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930E717BBE
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 03:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719978212; cv=none; b=LUbhq8uGmDsfBgJ931CnvD/18JGqMfCX4gwVjq1iCGLN5LAvjbgH5fHw3DQeaKnX4JcLtY96Sa5sx9/ufbVTRSWCRFtY/4RAKq6jcADEic98iuuDlYyidL6EwWFVD9KqUNP3jL4XMymcq/CJBOZ7idh1o3CIMsHuB0ULw0S1oC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719978212; c=relaxed/simple;
	bh=d1LBJFOV9RiLlyT6QZGIf814dNeSg88ky26RZtUypcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b8ejCzDULiNS9uGCuH5YjrCJj2S7Z26tFNgHWXF4Z8NDCAL+A6LQ6HIJQPYaWGUYAmBtyXIq8SkJrG8b95c3aKJlBIRtgqIFs4NcZoVtHsD0tYOMcdtc7kp0c5KR9Wq6mtWN1GyA1n9U87KnQEsFWkckffXfjL1wOggraQ9BnSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PiC93lKy; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719978211; x=1751514211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d1LBJFOV9RiLlyT6QZGIf814dNeSg88ky26RZtUypcc=;
  b=PiC93lKyC3Jw08s48EOebE6md4b9v0FQZynZ0px+N868Fyexc3pHKJJj
   TPlV0zGjmEaO880ep7+hTZ52bVDCcBTSHOA+XZz96Ksg02fvGxCa9rj75
   lV7fb9CEoAJ+j4uTHgYWY0OK8qbF82O26oWDt7S60BICIfY90pto1A4z5
   zWpc5/gC4WpiMzUnoTSRw6LWZQR0NSrKR2jjNcRH59rstZuzJQ5H/7Qi3
   f8K95viAVpIG/dkRvMkC+xTZJHnY+/h1fUYjXdyr4cayzCc76VV8T7uNl
   RUaTceIjP4PjddR6tMmfyw2UJvAV9+8pPhzjW3rhlSX6Z8JHUICPKYJt3
   Q==;
X-CSE-ConnectionGUID: hmxp5zKzSVe2rYHS+ZGMvQ==
X-CSE-MsgGUID: dbb4+zFHTgO22uqLR5zEww==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17304041"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="17304041"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 20:43:30 -0700
X-CSE-ConnectionGUID: kZDIkayGSE6UWVrdJCSAvw==
X-CSE-MsgGUID: cFPcqZBjTS+7U2Ag7TrPkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="51291065"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 20:43:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 2/5] wifi: iwlwifi: mvm: avoid link lookup in statistics
Date: Wed,  3 Jul 2024 06:43:14 +0300
Message-Id: <20240703064026.346a6ef67a86.Iba5d65d728ca9f58518c88d029496c1250670544@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703034317.595020-1-miriam.rachel.korenblit@intel.com>
References: <20240703034317.595020-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We already iterate the link bss_conf/link_info and have the
pointer, or know that deflink/bss_conf is used, so avoid an
extra lookup and just pass the pointer. This may also avoid
a crash when this is processed during restart, where the FW
to link conf array (link_id_to_link_conf) may be NULLed out.

Fixes: c1e458b987f2 ("wifi: iwlwifi: mvm: Move beacon filtering to be per link")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 4fa8066a89b6..773cc2bdcb0b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -557,12 +557,10 @@ struct iwl_mvm_stat_data_all_macs {
 };
 
 static void iwl_mvm_update_link_sig(struct ieee80211_vif *vif, int sig,
-				    struct iwl_mvm_vif_link_info *link_info)
+				    struct iwl_mvm_vif_link_info *link_info,
+				    struct ieee80211_bss_conf *bss_conf)
 {
 	struct iwl_mvm *mvm = iwl_mvm_vif_from_mac80211(vif)->mvm;
-	struct ieee80211_bss_conf *bss_conf =
-		iwl_mvm_rcu_fw_link_id_to_link_conf(mvm, link_info->fw_link_id,
-						    false);
 	int thold = bss_conf->cqm_rssi_thold;
 	int hyst = bss_conf->cqm_rssi_hyst;
 	int last_event;
@@ -670,7 +668,7 @@ static void iwl_mvm_stat_iterator(void *_data, u8 *mac,
 			mvmvif->deflink.beacon_stats.num_beacons;
 
 	/* This is used in pre-MLO API so use deflink */
-	iwl_mvm_update_link_sig(vif, sig, &mvmvif->deflink);
+	iwl_mvm_update_link_sig(vif, sig, &mvmvif->deflink, &vif->bss_conf);
 }
 
 static void iwl_mvm_stat_iterator_all_macs(void *_data, u8 *mac,
@@ -705,7 +703,7 @@ static void iwl_mvm_stat_iterator_all_macs(void *_data, u8 *mac,
 	sig = -le32_to_cpu(mac_stats->beacon_filter_average_energy);
 
 	/* This is used in pre-MLO API so use deflink */
-	iwl_mvm_update_link_sig(vif, sig, &mvmvif->deflink);
+	iwl_mvm_update_link_sig(vif, sig, &mvmvif->deflink, &vif->bss_conf);
 }
 
 static inline void
@@ -921,7 +919,8 @@ iwl_mvm_stat_iterator_all_links(struct iwl_mvm *mvm,
 				mvmvif->link[link_id]->beacon_stats.num_beacons;
 
 		sig = -le32_to_cpu(link_stats->beacon_filter_average_energy);
-		iwl_mvm_update_link_sig(bss_conf->vif, sig, link_info);
+		iwl_mvm_update_link_sig(bss_conf->vif, sig, link_info,
+					bss_conf);
 
 		if (WARN_ONCE(mvmvif->id >= MAC_INDEX_AUX,
 			      "invalid mvmvif id: %d", mvmvif->id))
-- 
2.34.1


