Return-Path: <linux-wireless+bounces-3752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0BA859859
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 18:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A70C1F21988
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 17:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE396F505;
	Sun, 18 Feb 2024 17:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnlpmXEs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5A36F07F
	for <linux-wireless@vger.kernel.org>; Sun, 18 Feb 2024 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708278760; cv=none; b=tsj5DbVP7HeTreSSat2qO7zNvESqfYIrL3wXtgAw99icF6e5x7awTFwEgMMIf3LXH9V5OjcjM14U5uDayQNlm98UFT/g63SDGBzsG2jWNe9S/9oaaNlDms7nxVobaf9Vl+LoURAzYjp/Qt7tteVMJYUSxTsYsNKph+t3yh8i4KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708278760; c=relaxed/simple;
	bh=WZLy47OalfPpmhmdoWBPLEZ6ydjRfJfM93jaNaHm7D8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PrpTF2+3qPMwdATPsqGP2RVTo03jlsMqmG03HV+RyDo5P2OJfVoK/3/66uvPLtRNVcNB/yM34gKPgeU6/PutTQvMzF/1rQSV9FppGNHa+eQP48N+gQmRXkLgPd12lH89SM0V1S/WCHtCoeo+Wn+9gyNKyiKEdPZOeuPIB6YQsOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnlpmXEs; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708278749; x=1739814749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WZLy47OalfPpmhmdoWBPLEZ6ydjRfJfM93jaNaHm7D8=;
  b=CnlpmXEsPTlSE9+gR2crklrEm2HRxFuMzuwAcWFlC93wWyjybEqlN/gt
   LKk6WaNdoaoFHmhVCyEF15AYx8yyAxAr4kk6TokDB1I8p7nsPVXEQ93I7
   SAmyp6nPEOsDJKVjeWxQcgvw49RTahyQMkbzUvh6SgvAeYsCx4F3xnDt7
   J4DJwXxU38zBXAu9wGOqz3KBwSmUFlTXTvvaAvQfHlagd7Pj6nxg9uDt7
   dmMgcCzjqtbDAUYU89DDmeeJBBxLeuUwvSDqzg4rSs4//xMhddDg9c7ZI
   MiI0dzV4WZ9pgKJ4V7TRTlaiFDyxGE/YW+d7blKToGqt3hbEtMJoOZwoo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2464992"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="2464992"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:52:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="27459456"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:52:24 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/11] wifi: iwlwifi: handle per-phy statistics from fw
Date: Sun, 18 Feb 2024 19:51:51 +0200
Message-Id: <20240218194912.e84f975b69ee.Ibbc7817135827e45adaaa47b796be165f9f1ca48@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218175152.3133364-1-miriam.rachel.korenblit@intel.com>
References: <20240218175152.3133364-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

In the operational statistics notifications (both old and new
API) the driver receives the statistics per phy.
currently this statistics wasn't handled because they wasn't needed.

Now the channel_load_by_us parameter in these statistics will be used
for the link grading calculation (implemented in another patch),
so store its value in phy_ctxt.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c  | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 8a45d69d0f81..13b803101d4b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -106,6 +106,7 @@ struct iwl_mvm_phy_ctxt {
 	/* track for RLC config command */
 	u32 center_freq1;
 	bool rlc_disabled;
+	u32 channel_load_by_us;
 };
 
 struct iwl_mvm_time_event_data {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 72df41996464..b1add7942c5b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -752,6 +752,19 @@ iwl_mvm_update_tcm_from_stats(struct iwl_mvm *mvm, __le32 *air_time_le,
 	spin_unlock(&mvm->tcm.lock);
 }
 
+static void iwl_mvm_handle_per_phy_stats(struct iwl_mvm *mvm,
+					 struct iwl_stats_ntfy_per_phy *per_phy)
+{
+	int i;
+
+	for (i = 0; i < NUM_PHY_CTX; i++) {
+		if (!mvm->phy_ctxts[i].ref)
+			continue;
+		mvm->phy_ctxts[i].channel_load_by_us =
+			le32_to_cpu(per_phy[i].channel_load_by_us);
+	}
+}
+
 static void
 iwl_mvm_stats_ver_15(struct iwl_mvm *mvm,
 		     struct iwl_statistics_operational_ntfy *stats)
@@ -766,6 +779,7 @@ iwl_mvm_stats_ver_15(struct iwl_mvm *mvm,
 					    IEEE80211_IFACE_ITER_NORMAL,
 					    iwl_mvm_stat_iterator_all_macs,
 					    &data);
+	iwl_mvm_handle_per_phy_stats(mvm, stats->per_phy);
 }
 
 static void
@@ -942,6 +956,7 @@ void iwl_mvm_handle_rx_system_oper_stats(struct iwl_mvm *mvm,
 
 	ieee80211_iterate_stations_atomic(mvm->hw, iwl_mvm_stats_energy_iter,
 					  average_energy);
+	iwl_mvm_handle_per_phy_stats(mvm, stats->per_phy);
 }
 
 void iwl_mvm_handle_rx_system_oper_part1_stats(struct iwl_mvm *mvm,
-- 
2.34.1


