Return-Path: <linux-wireless+bounces-26639-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 081D7B36F5B
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 18:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D8A366B31
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 15:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474EA30AD12;
	Tue, 26 Aug 2025 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aa3sdM2O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B6721CC60
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223747; cv=none; b=qYr5ZBuqX6leBl7f9oRKtaRRtNnLjkbKPtJwSDRkRGTgtLagpCaTotCdAP0dvheA0aBLKXgHK5IQY+zGtxItWeMYwL4rc9zA+OtgxkJXeRxNakEOd/tBhwNy+qNHZ/+lpRbPUeNgP+HlwFPxQqLU07lTtPX3aq4zE3f5IaJUDew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223747; c=relaxed/simple;
	bh=sZW6dztz+vSaYnuqTQOnDaCeQy5lNti2/oQkzNgu6Ns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DhDiBP2uyul8MlKNseutb4Hzc54Ca1WxkOZTG6R2miwGXk+DZ0DX9gTQVTjqp9wxydbILdIWQ04qkPbuwHovJZ+j2BMbz2d+bV+iZzrF9L4RbkGihRvjYm91cPr+lbo5zZNKIQZi8U+YrVygXV3c25VSfWT1aO67BFIx8tc7onA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aa3sdM2O; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756223746; x=1787759746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sZW6dztz+vSaYnuqTQOnDaCeQy5lNti2/oQkzNgu6Ns=;
  b=Aa3sdM2O4IKdhfI8fYy3r56l5mxv6x9EVz58ZqOpuPn8P9BhA/Ddnpom
   +jQELYhAlPTOOpQuzjD/dyJkR3UcOBw5CTjGz/jNuSRX1RLCqjNwWwdl7
   ZihaxMkRebn/XUq76x/c2N8OBkvsFF5KbLJO+nlc1Ijl9qTnwJAUITUWP
   +YNhJBIqcyCWLn/rOvet4S93M9Wv/Cq8HiC0755qCAB1DUj8JclS/yn65
   z+vo6C+04npfLsKpgY9bAXCKsIy1WnsTIycC9ZALHB/3katodcb7e97CI
   2WBKAA6tq3lzBVvj+iqRKE0abwwlcPFTWTOyXtdxA4sgVtC98zGDMAiC7
   g==;
X-CSE-ConnectionGUID: 5CPkjajdRJyTynioxuHgmA==
X-CSE-MsgGUID: dNtOfCZGRt+hUoneRic2BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62108408"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62108408"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:33 -0700
X-CSE-ConnectionGUID: IQt15T3LS3Wi8chodLP/Ew==
X-CSE-MsgGUID: ZJuUYx3zTYWeRVfAamffvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169218198"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: mld: trigger mlo scan only when not in EMLSR
Date: Tue, 26 Aug 2025 18:54:51 +0300
Message-Id: <20250826184046.f6ae8e3882cf.I60901c16487371b8e62019bd0bf25c45ab23752f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
References: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>

When beacon loss happens or the RSSI drops, trigger MLO scan only
if not in EMLSR. The link switch was meant to be done when we are
not in EMLSR and we can try to switch to a better link.
If in EMLSR, we exit first and then trigger MLO scan.

Signed-off-by: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c  |  7 +++++--
 drivers/net/wireless/intel/iwlwifi/mld/stats.c | 11 +++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 782fc41aa1c3..dfaa6fbf8a54 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -572,8 +572,11 @@ void iwl_mld_handle_missed_beacon_notif(struct iwl_mld *mld,
 	if (missed_bcon_since_rx > IWL_MLD_MISSED_BEACONS_THRESHOLD) {
 		ieee80211_cqm_beacon_loss_notify(vif, GFP_ATOMIC);
 
-		/* try to switch links, no-op if we don't have MLO */
-		iwl_mld_int_mlo_scan(mld, vif);
+		/* Not in EMLSR and we can't hear the link.
+		 * Try to switch to a better link. EMLSR case is handled below.
+		 */
+		if (!iwl_mld_emlsr_active(vif))
+			iwl_mld_int_mlo_scan(mld, vif);
 	}
 
 	/* no more logic if we're not in EMLSR */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/stats.c b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
index cbc64db5eab6..7b8709716324 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/stats.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
@@ -379,11 +379,14 @@ static void iwl_mld_update_link_sig(struct ieee80211_vif *vif, int sig,
 
 	/* TODO: task=statistics handle CQM notifications */
 
-	if (sig < IWL_MLD_LOW_RSSI_MLO_SCAN_THRESH)
-		iwl_mld_int_mlo_scan(mld, vif);
-
-	if (!iwl_mld_emlsr_active(vif))
+	if (!iwl_mld_emlsr_active(vif)) {
+		/* We're not in EMLSR and our signal is bad,
+		 * try to switch link maybe. EMLSR will be handled below.
+		 */
+		if (sig < IWL_MLD_LOW_RSSI_MLO_SCAN_THRESH)
+			iwl_mld_int_mlo_scan(mld, vif);
 		return;
+	}
 
 	/* We are in EMLSR, check if we need to exit */
 	exit_emlsr_thresh =
-- 
2.34.1


