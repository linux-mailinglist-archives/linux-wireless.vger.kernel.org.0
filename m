Return-Path: <linux-wireless+bounces-8115-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB908D07EF
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 18:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C731F21D0F
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BDF61FFB;
	Mon, 27 May 2024 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1UeceCR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F6E17E912
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 16:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825987; cv=none; b=XlAP3145HFY8Lwd1CYz67Gm+CuHb2JfgX6FxiV2Vmrb60cE48kDZYTkVzlBPOlYpcz7WmdymhTvSq2DW6SXdIh6kGe4JKyUtTaCZWEyshiFnRiLiQ8590Dp/Sb35o/20zXnROB4SYw1L3gUNc3IpK+vriNI6p7sKRpX7enwoMDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825987; c=relaxed/simple;
	bh=3jrStSjjx6cpUKiSHySiyQIlpny2pdh8KDgY3wJv2q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V1m8jqQgJRbXvuihh3VGANhGrkEHuSc6PmQQr8kswdzynVSphaWwYJ4607vyrPQlU98D8yFVQTOs99ABbv0h+uGaD7MVTseAOvbPXpA/A6WJEgNtek2qRoBDugdRV0ELg9oTo2e9Q4UybzILvzsCeIDXbZIC2/Y3hM36rqQP/rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1UeceCR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716825986; x=1748361986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3jrStSjjx6cpUKiSHySiyQIlpny2pdh8KDgY3wJv2q4=;
  b=B1UeceCRKTvtJ+j8eaJMMfYbG3dZOT49AFwGIHvdNzZUAC6ANsIB0+o4
   4Z8vnyUgIGgMMmB0gTYTUYSIk/7FsVgRVtFGicVLgZFLI0D2f8CTf8/Wu
   smLpELwvHsoNBuf6zrypHhRAwEYusHhlHntCYTR0eqlHiISB3S0jJH45X
   MD603djoHMlPUsUdaosrSp7VWMFDXb6Q8MbvIjwr3moMUQ6E2qdfsQpKr
   6p2IVe38DsvoIgkhL0DeRYI45o3+qNgxvRQ6JtGNgIGnCqmDN+Y111996
   ZJlwWCHQDkn+11Eo3lN1T+FU6VeZsqoNJJkmNOvGkqha1ALii0LCGTurj
   g==;
X-CSE-ConnectionGUID: iHEI/IjeTZq3OQnkMhqLLw==
X-CSE-MsgGUID: Huyhca8ETQ2Szs4wXn1WxA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13002067"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13002067"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:26 -0700
X-CSE-ConnectionGUID: T87mtdBpTt2J+Zx3tPFzKQ==
X-CSE-MsgGUID: ZaOsCuDEQaWjrISSMMjUaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="35407059"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>, Greenman@web.codeaurora.org,
	Gregory <gregory.greenman@intel.com>
Subject: [PATCH 01/20] wifi: iwlwifi: mvm: add an option to use ptp clock for rx timestamp
Date: Mon, 27 May 2024 19:05:56 +0300
Message-Id: <20240527190228.b197b4f3f9ed.I578ee916d5f517a2e3a89e890a8ea24065946427@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
References: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

Add a debugfs option to use the ptp clock time for rx device
timestamps. This can be useful to e.g. synchronize multiple NICs or
reporting the timestamp in the system clock instead of gp2.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h     | 3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c    | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 7e7153220fd7..1504cbec69c9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -2450,6 +2450,9 @@ void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm)
 	debugfs_create_file("mem", 0600, mvm->debugfs_dir, mvm,
 			    &iwl_dbgfs_mem_ops);
 
+	debugfs_create_bool("rx_ts_ptp", 0600, mvm->debugfs_dir,
+			    &mvm->rx_ts_ptp);
+
 	/*
 	 * Create a symlink with mac80211. It will be removed when mac80211
 	 * exists (before the opmode exists which removes the target.)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 9e967b9cb015..f3d9b8355c6b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1309,6 +1309,9 @@ struct iwl_mvm {
 	struct iwl_phy_specific_cfg phy_filters;
 #endif
 
+	/* report rx timestamp in ptp clock time */
+	bool rx_ts_ptp;
+
 	unsigned long last_6ghz_passive_scan_jiffies;
 	unsigned long last_reset_or_resume_time_jiffies;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 0f78a9ef5240..34a0f524262a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1954,6 +1954,14 @@ static void iwl_mvm_rx_fill_status(struct iwl_mvm *mvm,
 	iwl_mvm_decode_lsig(skb, phy_data);
 
 	rx_status->device_timestamp = phy_data->gp2_on_air_rise;
+
+	if (mvm->rx_ts_ptp && mvm->monitor_on) {
+		u64 adj_time =
+			iwl_mvm_ptp_get_adj_time(mvm, phy_data->gp2_on_air_rise * NSEC_PER_USEC);
+
+		rx_status->device_timestamp = div64_u64(adj_time, NSEC_PER_USEC);
+	}
+
 	rx_status->freq = ieee80211_channel_to_frequency(phy_data->channel,
 							 rx_status->band);
 	iwl_mvm_get_signal_strength(mvm, rx_status, rate_n_flags,
-- 
2.34.1


