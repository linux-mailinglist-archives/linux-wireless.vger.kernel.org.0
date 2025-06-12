Return-Path: <linux-wireless+bounces-24059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD58AD6F69
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 13:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3C23B1B07
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 11:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0257723C8B3;
	Thu, 12 Jun 2025 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SvMUqw/k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52688223DF6
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728963; cv=none; b=li9MjwOGQHjGsypvtBb6qp5vJ8sp3Qo9Btj9AgkBFbn88oU9PMoESLtthiXAXvhtvel1BQubYa0mlFZj4yeQiUpGp/2GZSqD6F9D2tzjSMozRut985PnE5yZF1x7nCgrDU/oGQMfRYlbBaW2RUhIbKHcI/WiEHS1wLaHE+A8gmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728963; c=relaxed/simple;
	bh=r+tBw0qxGq/2Pa7snel7AkFmqWNSnOuEyBwrt4yYSi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zr2HX/tWyldxGeVlFS5YzL+Ot8lzqNj9JUrea8EKAn1juMR+r98piSpu93hZI2XWLmY44XhMGYoDyyZOO5JOlH0SfPXKAkAZKRCFbWXFryzbvdmRQyFrH7S8zkqhkLRF44YYROs41UFKtNtCLoCdJlwa6tONo0FQ4r6KWVLldaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SvMUqw/k; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749728963; x=1781264963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r+tBw0qxGq/2Pa7snel7AkFmqWNSnOuEyBwrt4yYSi8=;
  b=SvMUqw/k0fy7sT6Xtcg8VAurezWxZcomKgzQmyD38GzuPSMtJo/INcWC
   uiCmw1s3ZwRMnBHqACsQOtiVj/cuiWzcVEloqwJqJJMWH3WN0t2L/l/us
   Pq21dRh76XVP3vYy+uAiAx4FY5IEdQHCwuIUv3jxM/iCkIl7nnuc7gv1l
   gJBJU9mnHtQALISEAtEnWMbidSZfnz9gP8BSUUEfIxVY4rG9G4529m0ug
   M24oAuSmtpAl9uU1RSNe0by0LiU2ra+2zlSOx6hEb5mGswnLocCHiVC0p
   +XIoHnEI6o1KtKiAaSIWj04hpRfMALFNZ13KCO033QcSnPTrbUNOdrjtY
   Q==;
X-CSE-ConnectionGUID: sV1BiqnYSrGoxzAAD4IuXA==
X-CSE-MsgGUID: KvV0lDmoSpmI8LD0Ndhyrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="63248330"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="63248330"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:23 -0700
X-CSE-ConnectionGUID: 1XPH6PC+SuSI01ynVZcbCQ==
X-CSE-MsgGUID: 8IjFnBoeQo6l9EVuy5YvAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="147382115"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:21 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next 05/13] wifi: iwlwifi: mld: Block EMLSR when scanning on P2P Device
Date: Thu, 12 Jun 2025 14:48:51 +0300
Message-Id: <20250612144708.85fb79d537fe.I27523f8d3f00f2b66f5f555f098e323be29465ea@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612114859.3094387-1-miriam.rachel.korenblit@intel.com>
References: <20250612114859.3094387-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Temporarily block EMLSR when scanning on a P2P Device interface,
as this is an indication that P2P activity is about to start, e.g.,
P2P client connection to a P2P GO.

Since a P2P scan while a station interface connection is active might
be long, increase the EMLSR blocking timeout to 10 seconds.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 27 +----------------
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  | 30 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h  |  2 ++
 drivers/net/wireless/intel/iwlwifi/mld/scan.c |  4 +++
 4 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 0f156e868504..1eb4dfb83778 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -2580,28 +2580,6 @@ static int iwl_mld_mac80211_tx_last_beacon(struct ieee80211_hw *hw)
 	return mld->ibss_manager;
 }
 
-#define IWL_MLD_EMLSR_BLOCKED_TMP_NON_BSS_TIMEOUT (5 * HZ)
-
-static void iwl_mld_vif_iter_emlsr_block_tmp_non_bss(void *_data, u8 *mac,
-						     struct ieee80211_vif *vif)
-{
-	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
-	int ret;
-
-	if (!iwl_mld_vif_has_emlsr_cap(vif))
-		return;
-
-	ret = iwl_mld_block_emlsr_sync(mld_vif->mld, vif,
-				       IWL_MLD_EMLSR_BLOCKED_TMP_NON_BSS,
-				       iwl_mld_get_primary_link(vif));
-	if (ret)
-		return;
-
-	wiphy_delayed_work_queue(mld_vif->mld->wiphy,
-				 &mld_vif->emlsr.tmp_non_bss_done_wk,
-				 IWL_MLD_EMLSR_BLOCKED_TMP_NON_BSS_TIMEOUT);
-}
-
 static void iwl_mld_prep_add_interface(struct ieee80211_hw *hw,
 				       enum nl80211_iftype type)
 {
@@ -2614,10 +2592,7 @@ static void iwl_mld_prep_add_interface(struct ieee80211_hw *hw,
 	      type == NL80211_IFTYPE_P2P_CLIENT))
 		return;
 
-	ieee80211_iterate_active_interfaces_mtx(mld->hw,
-						IEEE80211_IFACE_ITER_NORMAL,
-						iwl_mld_vif_iter_emlsr_block_tmp_non_bss,
-						NULL);
+	iwl_mld_emlsr_block_tmp_non_bss(mld);
 }
 
 static int iwl_mld_set_hw_timestamp(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index 20c2b436039a..8ed2c6de1282 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -287,6 +287,36 @@ int iwl_mld_block_emlsr_sync(struct iwl_mld *mld, struct ieee80211_vif *vif,
 	return _iwl_mld_emlsr_block(mld, vif, reason, link_to_keep, true);
 }
 
+#define IWL_MLD_EMLSR_BLOCKED_TMP_NON_BSS_TIMEOUT (10 * HZ)
+
+static void iwl_mld_vif_iter_emlsr_block_tmp_non_bss(void *_data, u8 *mac,
+						     struct ieee80211_vif *vif)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	int ret;
+
+	if (!iwl_mld_vif_has_emlsr_cap(vif))
+		return;
+
+	ret = iwl_mld_block_emlsr_sync(mld_vif->mld, vif,
+				       IWL_MLD_EMLSR_BLOCKED_TMP_NON_BSS,
+				       iwl_mld_get_primary_link(vif));
+	if (ret)
+		return;
+
+	wiphy_delayed_work_queue(mld_vif->mld->wiphy,
+				 &mld_vif->emlsr.tmp_non_bss_done_wk,
+				 IWL_MLD_EMLSR_BLOCKED_TMP_NON_BSS_TIMEOUT);
+}
+
+void iwl_mld_emlsr_block_tmp_non_bss(struct iwl_mld *mld)
+{
+	ieee80211_iterate_active_interfaces_mtx(mld->hw,
+						IEEE80211_IFACE_ITER_NORMAL,
+						iwl_mld_vif_iter_emlsr_block_tmp_non_bss,
+						NULL);
+}
+
 static void _iwl_mld_select_links(struct iwl_mld *mld,
 				  struct ieee80211_vif *vif);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.h b/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
index 9afa3d6ea649..704f64134798 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
@@ -157,6 +157,8 @@ struct iwl_mld_link_sel_data {
 	u16 grade;
 };
 
+void iwl_mld_emlsr_block_tmp_non_bss(struct iwl_mld *mld);
+
 #if IS_ENABLED(CONFIG_IWLWIFI_KUNIT_TESTS)
 u32 iwl_mld_emlsr_pair_state(struct ieee80211_vif *vif,
 			     struct iwl_mld_link_sel_data *a,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/scan.c b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
index cf3063e6ec53..63d5d39bb083 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
@@ -1752,6 +1752,10 @@ int iwl_mld_regular_scan_start(struct iwl_mld *mld, struct ieee80211_vif *vif,
 			       struct cfg80211_scan_request *req,
 			       struct ieee80211_scan_ies *ies)
 {
+
+	if (vif->type == NL80211_IFTYPE_P2P_DEVICE)
+		iwl_mld_emlsr_block_tmp_non_bss(mld);
+
 	return _iwl_mld_single_scan_start(mld, vif, req, ies,
 					  IWL_MLD_SCAN_REGULAR);
 }
-- 
2.34.1


