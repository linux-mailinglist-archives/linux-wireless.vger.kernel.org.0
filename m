Return-Path: <linux-wireless+bounces-25189-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2B7B00951
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C813B3E37
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 16:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B852F0050;
	Thu, 10 Jul 2025 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+9Ht+tp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED772EFDBE
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166513; cv=none; b=PM78Pt5SQRvDW6psPk9dLWGTwTM9jeB7Jm0AGKodRmvh4Xw0/1VfT9AXxLHr753/xLk/RPJOtRKDCw4r1ijN8YrMLwClEZxwaFX6j4ks12LtiSzqleGonf5E3PxUWyj2dWdSv5xrsPXCXhiFj4oshjdvZ4asUyz5I0HyosVkbZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166513; c=relaxed/simple;
	bh=LO7huGSL163+cY+C5ddUIBKoGInm0+2nmxJstvnm46w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hyFWyhzpJ7eKyYu0LzgnkTyHYPlMh6rcc4qV1/CbkL3MwH6Xgq+c5j7DrHyr2PYE5LOIznn/OHNH1R9ZY9bkzsI7mkwr/lax8+r+lfX+3+3cxIbk2NxWmMui67aH5GdEiy/K1OUTr4rzh5/yr9whqwkmjnsteIFyxo1p/9/au7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+9Ht+tp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752166512; x=1783702512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LO7huGSL163+cY+C5ddUIBKoGInm0+2nmxJstvnm46w=;
  b=W+9Ht+tp7zISSKRefBoubtmgSouunfkZ2WdpGSpXMryMdVEL+O8X5AdL
   CHRKxAZbthqEBnNcSqg8eiQU5pO7en70HEu2jsIZlc3YnSTW2EvoQDW0M
   BJz1f1jxmRklI6XHHU7rALiFNVpEiWcN1ktA/c5t9Pq5JFLpk8ov5YwYi
   W2PM3IAlm1p02nzjXNif15SEQWARqFFIH2bQ0ufQBq5SF+KQZTBxxk11c
   PQKfMNUDHZA1k66uySMCQlNO55f/AiQfHFIm2r3hnQPIAu+E11ulQdYtN
   ZU6QNU6O9+6zRi89zlnDwVBeeOPh2fVIpr5o0pVnVWLCauUXmvCMDXrGh
   w==;
X-CSE-ConnectionGUID: ZHyl6R5tR/S4rShVb0mzFg==
X-CSE-MsgGUID: Oupm+jPETIONwoQh6x2m2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54609987"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54609987"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:12 -0700
X-CSE-ConnectionGUID: DV75ui48S0mI1lKk+3mG7w==
X-CSE-MsgGUID: k+2n4Lz/QjeZR3ABwKnR6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="156276992"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH wireless-next 02/15] wifi: iwlwifi: mld: update the P2P device mac before starting the GO
Date: Thu, 10 Jul 2025 19:54:35 +0300
Message-Id: <20250710195219.463a0ad545f9.I85a25484d787b65f6a27e794285911e319df0b2d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
References: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

When a GO is started, the P2P device mac is updated to indicate
that frames for the P2P device mac should be filtered in while
the GO is active. However, this configuration is done after the GO is
already started so it doesn't take effect. Fix it by updating the
P2P device mac before adding the broadcast station, which actually
starts the GO.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/ap.c | 24 +++++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ap.c b/drivers/net/wireless/intel/iwlwifi/mld/ap.c
index 26511b49d89a..5c59acc8c4c5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/ap.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ap.c
@@ -294,9 +294,20 @@ int iwl_mld_start_ap_ibss(struct ieee80211_hw *hw,
 	if (ret)
 		return ret;
 
+	mld_vif->ap_ibss_active = true;
+
+	if (vif->p2p && mld->p2p_device_vif) {
+		ret = iwl_mld_mac_fw_action(mld, mld->p2p_device_vif,
+					    FW_CTXT_ACTION_MODIFY);
+		if (ret) {
+			mld_vif->ap_ibss_active = false;
+			goto rm_mcast;
+		}
+	}
+
 	ret = iwl_mld_add_bcast_sta(mld, vif, link);
 	if (ret)
-		goto rm_mcast;
+		goto update_p2p_dev;
 
 	/* Those keys were configured by the upper layers before starting the
 	 * AP. Now that it is started and the bcast and mcast sta were added to
@@ -310,12 +321,6 @@ int iwl_mld_start_ap_ibss(struct ieee80211_hw *hw,
 		iwl_mld_vif_update_low_latency(mld, vif, true,
 					       LOW_LATENCY_VIF_TYPE);
 
-	mld_vif->ap_ibss_active = true;
-
-	if (vif->p2p && mld->p2p_device_vif)
-		return iwl_mld_mac_fw_action(mld, mld->p2p_device_vif,
-					     FW_CTXT_ACTION_MODIFY);
-
 	/* When the channel context was added, the link is not yet active, so
 	 * min_def is always used. Update the PHY again here in case def should
 	 * actually be used.
@@ -326,6 +331,11 @@ int iwl_mld_start_ap_ibss(struct ieee80211_hw *hw,
 	return 0;
 rm_bcast:
 	iwl_mld_remove_bcast_sta(mld, vif, link);
+update_p2p_dev:
+	mld_vif->ap_ibss_active = false;
+	if (vif->p2p && mld->p2p_device_vif)
+		iwl_mld_mac_fw_action(mld, mld->p2p_device_vif,
+				      FW_CTXT_ACTION_MODIFY);
 rm_mcast:
 	iwl_mld_remove_mcast_sta(mld, vif, link);
 	return ret;
-- 
2.34.1


