Return-Path: <linux-wireless+bounces-18808-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3D4A31E1A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 06:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91BF9162268
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 05:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931AC1E1A05;
	Wed, 12 Feb 2025 05:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUHzGsVD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EFB1F91C5
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 05:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339034; cv=none; b=tQUqU78pmoLyJqQ0JmmcltKTdXfirkJA3r1Codye0ZNKyAVQ4H2OUa65btzax0/5+6823utSs2+65c2JE0o+B83kWQuy3WRznc6v26Avs3k9nkznXPdOnDti3cGqNEkuhrFk5J4RX2IzPSdfwDBTy4H8s7ZIKFUEwec4d6Jkydw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339034; c=relaxed/simple;
	bh=GVaBKmL+tiIGh0KJysrc+WlPH0ku4pLIyz+OMRB8l00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dETPrVO5MZvdeNntIyul5VIQphWV0cc/Qwv5DcTqWcFpxvp+0+qEKSrOVqMh0c5z7nRbxHs4M2H2r9wq0w2XJHicJs/i1G8TQLcROSx1oSTpo8TrQmDJxm0P0HsyDZ6bDOQQwdhqN4f6x2/KLi0N5aZ9UJchpy46IBEPYsbLy/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUHzGsVD; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739339033; x=1770875033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GVaBKmL+tiIGh0KJysrc+WlPH0ku4pLIyz+OMRB8l00=;
  b=kUHzGsVDJmkntnMzJxSr7go6eQDiMBJM0Oj4UyzF3z9tc3o1NJtnOk5c
   9/cig04QjsyYrQP+ipn0MxHattsABAutkX5iKJXrx832BssC13pb6Y2af
   Llvbwy3SxhCbUyq+ibFWpVs1imVkor8rc+Rmpthjuh1Myi7WGFtCZDBTi
   x6QUxcueQLYAPlD8Eiy0o+FAQlu4xFQiFN+gCmLcrhGJjnr+GVtr882Ue
   epBbVYWmUwUHgKSEI/RADIj9RUF1HWA2fjMUOaj8DZczqM0Q8RPdcMao5
   /njeVpZYmeagDsbYazt3de/TgZVYnMyLKXpdCnN85yYufij2DBhub1ay6
   w==;
X-CSE-ConnectionGUID: bVdZbKRnQZOOIrWWIK1bSw==
X-CSE-MsgGUID: //rMEMTYTK+TeQX57jItiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39172211"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39172211"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:43:52 -0800
X-CSE-ConnectionGUID: veMNyNOjQFumOQwQ4tTCHA==
X-CSE-MsgGUID: BW66F8Z1RwmuxVeAVAesSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117893845"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:43:51 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 03/12] wifi: iwlwifi: remove mvm prefix from iwl_mvm_esr_mode_notif
Date: Wed, 12 Feb 2025 07:43:24 +0200
Message-Id: <20250212073923.c536eeaae129.I848307be6df21913c0ce3eb6baef715cd401db1a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212054333.376219-1-miriam.rachel.korenblit@intel.com>
References: <20250212054333.376219-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This is not specific to mvm.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h | 4 ++--
 drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h  | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c         | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index 570a3f722510..34a562d6c208 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2024 Intel Corporation
+ * Copyright (C) 2024-2025 Intel Corporation
  * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
@@ -92,7 +92,7 @@ enum iwl_data_path_subcmd_ids {
 
 	/**
 	 * @ESR_MODE_NOTIF: notification to recommend/force a wanted esr mode,
-	 *	uses &struct iwl_mvm_esr_mode_notif
+	 *	uses &struct iwl_esr_mode_notif
 	 */
 	ESR_MODE_NOTIF = 0xF3,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 511e86ea11d4..b511e3aa6bb2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -697,11 +697,11 @@ enum iwl_mvm_fw_esr_recommendation {
 }; /* ESR_MODE_RECOMMENDATION_CODE_API_E_VER_1 */
 
 /**
- * struct iwl_mvm_esr_mode_notif - FWs recommendation/force for esr mode
+ * struct iwl_esr_mode_notif - FWs recommendation/force for esr mode
  *
  * @action: the action to apply on esr state. See &iwl_mvm_fw_esr_recommendation
  */
-struct iwl_mvm_esr_mode_notif {
+struct iwl_esr_mode_notif {
 	__le32 action;
 } __packed; /* ESR_MODE_RECOMMENDATION_NTFY_API_S_VER_1 */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 984f407f7027..76603ef02704 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -145,7 +145,7 @@ static void iwl_mvm_rx_esr_mode_notif(struct iwl_mvm *mvm,
 				      struct iwl_rx_cmd_buffer *rxb)
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
-	struct iwl_mvm_esr_mode_notif *notif = (void *)pkt->data;
+	struct iwl_esr_mode_notif *notif = (void *)pkt->data;
 	struct ieee80211_vif *vif = iwl_mvm_get_bss_vif(mvm);
 
 	/* FW recommendations is only for entering EMLSR */
@@ -495,7 +495,7 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 	RX_HANDLER_GRP(DATA_PATH_GROUP, ESR_MODE_NOTIF,
 		       iwl_mvm_rx_esr_mode_notif,
 		       RX_HANDLER_ASYNC_LOCKED_WIPHY,
-		       struct iwl_mvm_esr_mode_notif),
+		       struct iwl_esr_mode_notif),
 
 	RX_HANDLER_GRP(DATA_PATH_GROUP, MONITOR_NOTIF,
 		       iwl_mvm_rx_monitor_notif, RX_HANDLER_ASYNC_LOCKED,
-- 
2.34.1


