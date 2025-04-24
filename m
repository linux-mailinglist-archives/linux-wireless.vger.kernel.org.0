Return-Path: <linux-wireless+bounces-21986-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29632A9ADAD
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 14:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48F2A194087C
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 12:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2DE27A92F;
	Thu, 24 Apr 2025 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fpc60JCQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685341DEFC8
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498341; cv=none; b=Gt2E3i7PdmfVvcdzBEBaqdrwUMYcOyr6vJMKWowkuPivPRVvGa3lvhJYdgah+UQ0UuP6gROtkY9Nf7R2122EVhQjM7eQhX1k9B+32K2qv7niXQSNoNJ7/8BQxaBp/t+J/Hc801sVk0Is1CooF2Ic94MHR8334OoyrOJodShj9ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498341; c=relaxed/simple;
	bh=GBnpKikvvq+tCE0STbQdHm9/hk+ccq2DGtsV4gZroYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nuqEuNxwp3Sxo975+AH2DZ+3JAlFu/2YQRFt2ow9i4Q1Xb05KskZLyMUO/SKvUtFOhxTSbBg+S8Ir84q7y9LAsPOkqVI5vy6Ki/wo9VnYHwWpkGGI2+2KqJLWj/J6/uOVWSc1iqANCM3eXUt1ZvdMzZN5jLLOr79M4czQBKwnSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fpc60JCQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745498338; x=1777034338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GBnpKikvvq+tCE0STbQdHm9/hk+ccq2DGtsV4gZroYY=;
  b=Fpc60JCQyaCRq1EAPxHD7ibwYAKWC0ypEEN8wuYSK0PnYztRNF/xRGV8
   RGXTWVmOptVetSTaJ35adeCKt/sFNZXCDvoiMYxOHCWn+RETsDnAnQB4P
   gih694l5giBleFTUMtULZHuRD+QPeLkETC7yLZ58g5lZdL2qsTOh0XMuY
   j1So+yz8FpLh1HSmiaUlhtmfm/VeAwY/qFG10W5p6RhU4kuTribPomdDf
   0xQqQdPT67VaT8CYXOoNifPEOT/LrZHpgpS2epEPkKljucSwzWctLjRPk
   eFAtL3fBr1Te+mdDdL3B8OtVYGOw+o5MVk2yKIRMcsvlvj1zcO66fXub0
   g==;
X-CSE-ConnectionGUID: 0mXy9hvdQ76uGbeNoslgDA==
X-CSE-MsgGUID: 7crZPF7WTDOqQpdd820F7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47302421"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47302421"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:38:58 -0700
X-CSE-ConnectionGUID: tDksnUZYQzuFqRVzhsRhAg==
X-CSE-MsgGUID: KQrvglfwT++O/T4J+PL7Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="133137428"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:38:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 07/14] wifi: iwlwifi: mld: skip unknown FW channel load values
Date: Thu, 24 Apr 2025 15:38:24 +0300
Message-Id: <20250424153620.db5410318642.I4d2981f68b915ad335bb02c926e9289c2a60ea6c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
References: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The firmware statistics were previously reporting bogus/old
channel load values if the device hadn't been active on a
given channel; it'll report an unknown value now for those
statistics affected (channel_load and channel_load_not_by_us.)
Handle that by simply skipping the value, the averaging would
result in the exact same value as before.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/stats.h |  5 ++++-
 drivers/net/wireless/intel/iwlwifi/mld/stats.c    | 14 ++++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h b/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
index 0a9f14fb04be..00713a991879 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018, 2020 - 2021, 2023 - 2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018, 2020-2021, 2023-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -584,6 +584,9 @@ struct iwl_stats_ntfy_per_phy {
 	__le32 last_tx_ch_width_indx;
 } __packed; /* STATISTICS_NTFY_PER_PHY_API_S_VER_1 */
 
+/* unknown channel load (due to not being active on channel) */
+#define IWL_STATS_UNKNOWN_CHANNEL_LOAD	0xffffffff
+
 /**
  * struct iwl_stats_ntfy_per_sta
  *
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/stats.c b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
index 0715bbc31031..360a6bfbbfb2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/stats.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
@@ -467,12 +467,18 @@ static void iwl_mld_fill_chanctx_stats(struct ieee80211_hw *hw,
 
 	old_load = phy->avg_channel_load_not_by_us;
 	new_load = le32_to_cpu(per_phy[phy->fw_id].channel_load_not_by_us);
-	if (IWL_FW_CHECK(phy->mld, new_load > 100, "Invalid channel load %u\n",
-			 new_load))
+
+	if (IWL_FW_CHECK(phy->mld,
+			 new_load != IWL_STATS_UNKNOWN_CHANNEL_LOAD &&
+				new_load > 100,
+			 "Invalid channel load %u\n", new_load))
 		return;
 
-	/* give a weight of 0.5 for the old value */
-	phy->avg_channel_load_not_by_us = (new_load >> 1) + (old_load >> 1);
+	if (new_load != IWL_STATS_UNKNOWN_CHANNEL_LOAD) {
+		/* update giving a weight of 0.5 for the old value */
+		phy->avg_channel_load_not_by_us = (new_load >> 1) +
+						  (old_load >> 1);
+	}
 
 	iwl_mld_emlsr_check_chan_load(hw, phy, old_load);
 }
-- 
2.34.1


