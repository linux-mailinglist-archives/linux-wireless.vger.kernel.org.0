Return-Path: <linux-wireless+bounces-22302-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1441AA5CDF
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 12:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554EF3BEAC9
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 10:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6639222D4FF;
	Thu,  1 May 2025 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iw9cyxc5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DDC22D4D0
	for <linux-wireless@vger.kernel.org>; Thu,  1 May 2025 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746093609; cv=none; b=prVI4YIrQ8Or1uCO1J+13JWxvbZhScJN2Ow2uxu3Ymgqbhqq3DjW7ERSum7l/ohSQX5HvKVsrFzIN2pKLr0X9iYNTP9tey4ldKvR5nnLhNf2FbR7BVw0e9Wl/SPm2Q2h3nGpBI8Tf9nmQiUIcHwTP8sLK+oWmurY+Veu25ppqUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746093609; c=relaxed/simple;
	bh=y76PBGs8aNWPdZ3nWBjNQWLYJnKn+KBDb/Zawxbf/AY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y2VHZ8YZ3bAgCMVi785uUc/ulR3KyMMX03+DZnNZd4shnpaNBdWCv/3hZ7NIi1HIJrctarV566yamSES+gFPeFcUmwE0ZJ8Z8xweUX4UTauUWV+nR3S8feTHNItVtUt2F1IsuILsgP08AMhTqGJ5c0Z+snrH1evdRmiCtHqyZVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iw9cyxc5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746093607; x=1777629607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y76PBGs8aNWPdZ3nWBjNQWLYJnKn+KBDb/Zawxbf/AY=;
  b=iw9cyxc5IBlUIZPwdFPZZJPloUv3izLk9HW+kusn4aZpTfiUa8OV3lX0
   LPf8qqgBklNAV6T7I/ifoihrY2/hZA1K1tf1u9F8Qnu1K1b8Q3JOQ0Eqw
   /ME0ah4W3go5wbW5KTqi7B3Ihvgi0AVlhsmHq78dPvM5FQTex7kLN0Ptm
   VT+qr3twSA7pwMrBtTUmWDJvAZmABzxoQ5SDy+5filtBcJHrsBb208qb4
   dOijs/ntDONXroU8cxB9wwN6I863xym/pZXke+i8ulSkghO4b1bHg/tbJ
   PY33zaihb2sflBzkT+r3Ao9KejeppkivdCKvhZvO5BCa0MUOjTguo75mi
   A==;
X-CSE-ConnectionGUID: JH0n05WUTzW6Qu/i7cBXaA==
X-CSE-MsgGUID: ArgoKxXeTrmP9jF/GZRzZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="57962839"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="57962839"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 03:00:07 -0700
X-CSE-ConnectionGUID: xvsutZVwQRi/c/3cPI6K+w==
X-CSE-MsgGUID: 4pDkEwcSSPiAmzqGUZPOkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="135317997"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 03:00:06 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: cfg: unify Killer 1650s/i with Qu/Hr
Date: Thu,  1 May 2025 12:59:32 +0300
Message-Id: <20250501125731.754fe4a848f1.Iad8bff04138538a8bc9f7920077ea24a699b1ed4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250501095937.2097123-1-miriam.rachel.korenblit@intel.com>
References: <20250501095937.2097123-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

These configs are the same except for the name, but we
can use a separate per-device name to override the name.
So do that, and remove the separate configs.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 24 ---------------
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  2 --
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 30 +++++++++----------
 3 files changed, 14 insertions(+), 42 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index ac137c82f7c5..4affcf079a85 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -257,30 +257,6 @@ const struct iwl_cfg iwl_ax200_cfg_cc = {
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
-const struct iwl_cfg killer1650s_2ax_cfg_qu_hr = {
-	.name = iwl_ax201_killer_1650s_name,
-	IWL_DEVICE_22500,
-	/*
-	 * This device doesn't support receiving BlockAck with a large bitmap
-	 * so we need to restrict the size of transmitted aggregation to the
-	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
-	 */
-	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.num_rbds = IWL_NUM_RBDS_22000_HE,
-};
-
-const struct iwl_cfg killer1650i_2ax_cfg_qu_hr = {
-	.name = iwl_ax201_killer_1650i_name,
-	IWL_DEVICE_22500,
-	/*
-	 * This device doesn't support receiving BlockAck with a large bitmap
-	 * so we need to restrict the size of transmitted aggregation to the
-	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
-	 */
-	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.num_rbds = IWL_NUM_RBDS_22000_HE,
-};
-
 MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_B_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 127d4dd548ac..a551967d1724 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -626,8 +626,6 @@ extern const struct iwl_cfg iwl_qu_hr1;
 extern const struct iwl_cfg iwl_qu_hr;
 extern const struct iwl_cfg iwl_ax200_cfg_cc;
 extern const struct iwl_cfg iwl_ax201_cfg_qu_hr;
-extern const struct iwl_cfg killer1650s_2ax_cfg_qu_hr;
-extern const struct iwl_cfg killer1650i_2ax_cfg_qu_hr;
 extern const struct iwl_cfg killer1650x_2ax_cfg;
 extern const struct iwl_cfg killer1650w_2ax_cfg;
 extern const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index bc7a3197c6f4..0a068ca6fee8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -655,11 +655,9 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x43F0), SUBDEV(0x0078), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x43F0), SUBDEV(0x007C), BW_NO_LIMIT),
-	IWL_DEV_INFO(killer1650s_2ax_cfg_qu_hr,
-		     iwl_ax201_killer_1650s_name,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650s_name,
 		     DEVICE(0x43F0), SUBDEV(0x1651), BW_NO_LIMIT),
-	IWL_DEV_INFO(killer1650i_2ax_cfg_qu_hr,
-		     iwl_ax201_killer_1650i_name,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650i_name,
 		     DEVICE(0x43F0), SUBDEV(0x1652), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x43F0), SUBDEV(0x2074), BW_NO_LIMIT),
@@ -675,9 +673,9 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0xA0F0), SUBDEV(0x007C), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0xA0F0), SUBDEV(0x0A10), BW_NO_LIMIT),
-	IWL_DEV_INFO(killer1650s_2ax_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650s_name,
 		     DEVICE(0xA0F0), SUBDEV(0x1651), BW_NO_LIMIT),
-	IWL_DEV_INFO(killer1650i_2ax_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650i_name,
 		     DEVICE(0xA0F0), SUBDEV(0x1652), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0xA0F0), SUBDEV(0x2074), BW_NO_LIMIT),
@@ -697,9 +695,9 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x02F0), SUBDEV(0x007C), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x02F0), SUBDEV(0x0310), BW_NO_LIMIT),
-	IWL_DEV_INFO(killer1650s_2ax_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650s_name,
 		     DEVICE(0x02F0), SUBDEV(0x1651), BW_NO_LIMIT),
-	IWL_DEV_INFO(killer1650i_2ax_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650i_name,
 		     DEVICE(0x02F0), SUBDEV(0x1652), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x02F0), SUBDEV(0x2074), BW_NO_LIMIT),
@@ -715,9 +713,9 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x06F0), SUBDEV(0x007C), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x06F0), SUBDEV(0x0310), BW_NO_LIMIT),
-	IWL_DEV_INFO(killer1650s_2ax_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650s_name,
 		     DEVICE(0x06F0), SUBDEV(0x1651), BW_NO_LIMIT),
-	IWL_DEV_INFO(killer1650i_2ax_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650i_name,
 		     DEVICE(0x06F0), SUBDEV(0x1652), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x06F0), SUBDEV(0x2074), BW_NO_LIMIT),
@@ -733,9 +731,9 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x34F0), SUBDEV(0x007C), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x34F0), SUBDEV(0x0310), BW_NO_LIMIT),
-	IWL_DEV_INFO(killer1650s_2ax_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650s_name,
 		     DEVICE(0x34F0), SUBDEV(0x1651), BW_NO_LIMIT),
-	IWL_DEV_INFO(killer1650i_2ax_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650i_name,
 		     DEVICE(0x34F0), SUBDEV(0x1652), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x34F0), SUBDEV(0x2074), BW_NO_LIMIT),
@@ -752,9 +750,9 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x3DF0), SUBDEV(0x007C), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x3DF0), SUBDEV(0x0310), BW_NO_LIMIT),
-	IWL_DEV_INFO(killer1650s_2ax_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650s_name,
 		     DEVICE(0x3DF0), SUBDEV(0x1651), BW_NO_LIMIT),
-	IWL_DEV_INFO(killer1650i_2ax_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650i_name,
 		     DEVICE(0x3DF0), SUBDEV(0x1652), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x3DF0), SUBDEV(0x2074), BW_NO_LIMIT),
@@ -771,9 +769,9 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x4DF0), SUBDEV(0x007C), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x4DF0), SUBDEV(0x0310), BW_NO_LIMIT),
-	IWL_DEV_INFO(killer1650s_2ax_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650s_name,
 		     DEVICE(0x4DF0), SUBDEV(0x1651), BW_NO_LIMIT),
-	IWL_DEV_INFO(killer1650i_2ax_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650i_name,
 		     DEVICE(0x4DF0), SUBDEV(0x1652), BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
 		     DEVICE(0x4DF0), SUBDEV(0x2074), BW_NO_LIMIT),
-- 
2.34.1


