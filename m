Return-Path: <linux-wireless+bounces-22335-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE80AA719B
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0AB71C012DC
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B5A253B7C;
	Fri,  2 May 2025 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ICNXWGH4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530A72550B1
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188461; cv=none; b=j5czZK7qrXfeEDA7INvi6wCLkM2+xLICU7ibF7n03lFd55sCbGukJtfDU0T+ncHgJfTPNsEi2YezrrzpNGEg7Oys78S6czmZ/YNV4zYbJK4ZvissbOfCi8lO6F8N1zzpAmwuI9TicP7iaXXwRoGvcqZlyePZ+r3E5aAYcQJ94C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188461; c=relaxed/simple;
	bh=0Ci3eF8UHmdIrywiPh3y6B346Fr9c/njemMkIvM56TQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CHlkmXBvC1ggqqnmAX9h8X0pYcmBern8Y5OFEhsS29KL9WekD7oRfQZU/ztTSlrQPfakE2AyyoZw2x2SpK4D5gCWfrcJsbdDCs0VuYq0pdqppW9Olv4fjT6Gm+zRy5OUyJ2uYj2Bm5Bxvn++j2mJKqCRI/uoNOis8iPIYTjLMxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ICNXWGH4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746188459; x=1777724459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Ci3eF8UHmdIrywiPh3y6B346Fr9c/njemMkIvM56TQ=;
  b=ICNXWGH4gbp2qtuMhUIiNFvjDFURMbjpdY+eNLQT4nxQ5etGgF9W5QUv
   i/J3wgUakz+xMW6WZFYnTGNGsj2YsdYtjDLW4wNNYXBIsclRejsN/Ztmi
   gTqOA17XiYt93G3JCx1eJiGPlhgFokVXNx41Nc02kr/qqIi2OV/J3JiuY
   ZXIGZg8J1cgrgBPDd7MZn2VY1ee4Sy/PNrVk11CD9GGPX0Q9EWON8DUwp
   shWhny3MpvHHQUFJyzkuKRBHBBl5gYjb5Q0vgvrVng68GGjZ5rDju1VZJ
   yo3/XxuEJodpNwHyhNqRJhQar0/lTYu4OPdHLzO7zvDrFTvwjMQG7o+3J
   w==;
X-CSE-ConnectionGUID: Oq7ZuhaLT1e92Ri2wLH0jw==
X-CSE-MsgGUID: UwmkVHRWTW+qz+EnGwJ1Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="48010366"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="48010366"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:20:59 -0700
X-CSE-ConnectionGUID: hf/i5+hRQkScjl2omqGgug==
X-CSE-MsgGUID: fJp8Y1w2R1+mDi7uQv1B8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="134586134"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:20:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 10/15] wifi: iwlwifi: cfg: unify Killer 1650s/i with Qu/Hr
Date: Fri,  2 May 2025 15:20:25 +0300
Message-Id: <20250502151751.a0a8ebbd473a.Iad8bff04138538a8bc9f7920077ea24a699b1ed4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502122030.3130085-1-miriam.rachel.korenblit@intel.com>
References: <20250502122030.3130085-1-miriam.rachel.korenblit@intel.com>
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
index deff291a43ca..95123cb26de6 100644
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


