Return-Path: <linux-wireless+bounces-22305-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A55CAA5CE2
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 12:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E801BC2014
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 10:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E202822D4D0;
	Thu,  1 May 2025 10:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bL5seiuM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B7E21931B
	for <linux-wireless@vger.kernel.org>; Thu,  1 May 2025 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746093613; cv=none; b=F3JGNKvbI4letZF/gYDXNoxY8mSQJVZY5cvtOKxvcgg8dsfO9lKTAs4yuBw9iJhY1WGaqnKi9kPpzJ8u7/CE0Z+32GjvNuW6nLDsjV55iHul1XIChYQyVFpglHcpR8BL2UYyEgO41AxvjWMWPo38yc/3CVtffFLExqT8OLkwDQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746093613; c=relaxed/simple;
	bh=vGByVOzX8iQMcUZYnDosItx15iWS4KQAM3DfhppGtqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g9Uw+Pp1ZjW8W2UYo4h1rqgs3i9cHTJeteHTm+WhgXkUgu7dThzI0gt/AN8C642ZAy9s99Qrto6dhNmuy8BeKTH38mHb/g+Qe0qkv/cDuBD/2npT40+tYr8k641vEFndNRfOiRTVD2AJ7m+Lv3H4jLwHo34FpwKK/g8wEP5Zci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bL5seiuM; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746093612; x=1777629612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vGByVOzX8iQMcUZYnDosItx15iWS4KQAM3DfhppGtqk=;
  b=bL5seiuMLgut161dbRezKpiZfoY1caRFX4hjKRd83WpMkV+AEQJ8U41k
   Wzw7F7gTDF5JdaOeY0bUGp7HLzQDjXhJbt4dbkiaoPTatD7WEUOyd74CE
   SNg11Fgrf4CukCoL1gdbnpr+95BTpwz3zPirjCK2rhijclhYHrBS+g7Yk
   RyRfaeGydjS3JDrHqLwzP3K7Nc3ADGv/3zRywGSXWbbqwA2jH6XgXVSn7
   73dC02hYLM29G1H6Gr+ojW0dKuYXiJirfCS4r+ebVAd5Njvpuyp/EeXrq
   WEBAC0rbLoLcPWaetXnyKNIK1pdnA7PZWCPxAcDa92k/JdZFTCmdsOA6s
   g==;
X-CSE-ConnectionGUID: mF11Y0DhS/u8puFOAeythw==
X-CSE-MsgGUID: RDKuWCTeSrO45T2xpYARLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="57962851"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="57962851"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 03:00:12 -0700
X-CSE-ConnectionGUID: 66uTiCJLRhyUYdpe3iXnag==
X-CSE-MsgGUID: N7ZvsYf2SlmQYxYjgkhsiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="135318019"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 03:00:10 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: cfg: remove iwl_ax201_cfg_qu_hr
Date: Thu,  1 May 2025 12:59:35 +0300
Message-Id: <20250501125731.e59e3b379aec.I2cb4476b9bca6e770bd375ad6ce650553dbde0f1@changeid>
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

We can handle the name differently, so do that and remove
the extra config entry.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   6 -
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   1 -
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 130 +++++++++---------
 3 files changed, 65 insertions(+), 72 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 70005e6b2d57..172ca18d888b 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -215,12 +215,6 @@ const struct iwl_cfg iwl_qu_hr = {
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
-const struct iwl_cfg iwl_ax201_cfg_qu_hr = {
-	.name = "Intel(R) Wi-Fi 6 AX201 160MHz",
-	IWL_DEVICE_22500,
-	.num_rbds = IWL_NUM_RBDS_22000_HE,
-};
-
 const struct iwl_cfg iwl_ax200_cfg_cc = {
 	.fw_name_pre = IWL_CC_A_FW_PRE,
 	IWL_DEVICE_22500,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 26d0faa44695..cdb3f4abd21b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -623,7 +623,6 @@ extern const struct iwl_cfg iwl9560_2ac_cfg_soc;
 extern const struct iwl_cfg iwl_qu_hr1;
 extern const struct iwl_cfg iwl_qu_hr;
 extern const struct iwl_cfg iwl_ax200_cfg_cc;
-extern const struct iwl_cfg iwl_ax201_cfg_qu_hr;
 extern const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0;
 extern const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0;
 extern const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0_long;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 0a068ca6fee8..db9b582795ba 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -647,137 +647,137 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x2723), SUBDEV(0x1654), BW_NO_LIMIT),
 
 	/* Qu with Hr */
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x43F0), SUBDEV(0x0070), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x43F0), SUBDEV(0x0074), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x43F0), SUBDEV(0x0078), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x43F0), SUBDEV(0x007C), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650s_name,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650s_name,
 		     DEVICE(0x43F0), SUBDEV(0x1651), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650i_name,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650i_name,
 		     DEVICE(0x43F0), SUBDEV(0x1652), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x43F0), SUBDEV(0x2074), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x43F0), SUBDEV(0x4070), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0xA0F0), SUBDEV(0x0070), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0xA0F0), SUBDEV(0x0074), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0xA0F0), SUBDEV(0x0078), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0xA0F0), SUBDEV(0x007C), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0xA0F0), SUBDEV(0x0A10), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650s_name,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650s_name,
 		     DEVICE(0xA0F0), SUBDEV(0x1651), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650i_name,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650i_name,
 		     DEVICE(0xA0F0), SUBDEV(0x1652), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0xA0F0), SUBDEV(0x2074), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0xA0F0), SUBDEV(0x4070), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0xA0F0), SUBDEV(0x6074), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x02F0), SUBDEV(0x0070), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x02F0), SUBDEV(0x0074), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x02F0), SUBDEV(0x6074), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x02F0), SUBDEV(0x0078), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x02F0), SUBDEV(0x007C), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x02F0), SUBDEV(0x0310), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650s_name,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650s_name,
 		     DEVICE(0x02F0), SUBDEV(0x1651), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650i_name,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650i_name,
 		     DEVICE(0x02F0), SUBDEV(0x1652), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x02F0), SUBDEV(0x2074), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x02F0), SUBDEV(0x4070), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x06F0), SUBDEV(0x0070), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x06F0), SUBDEV(0x0074), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x06F0), SUBDEV(0x0078), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x06F0), SUBDEV(0x007C), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x06F0), SUBDEV(0x0310), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650s_name,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650s_name,
 		     DEVICE(0x06F0), SUBDEV(0x1651), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650i_name,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650i_name,
 		     DEVICE(0x06F0), SUBDEV(0x1652), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x06F0), SUBDEV(0x2074), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x06F0), SUBDEV(0x4070), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x34F0), SUBDEV(0x0070), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x34F0), SUBDEV(0x0074), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x34F0), SUBDEV(0x0078), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x34F0), SUBDEV(0x007C), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x34F0), SUBDEV(0x0310), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650s_name,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650s_name,
 		     DEVICE(0x34F0), SUBDEV(0x1651), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650i_name,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650i_name,
 		     DEVICE(0x34F0), SUBDEV(0x1652), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x34F0), SUBDEV(0x2074), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x34F0), SUBDEV(0x4070), BW_NO_LIMIT),
 
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x3DF0), SUBDEV(0x0070), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x3DF0), SUBDEV(0x0074), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x3DF0), SUBDEV(0x0078), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x3DF0), SUBDEV(0x007C), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x3DF0), SUBDEV(0x0310), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650s_name,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650s_name,
 		     DEVICE(0x3DF0), SUBDEV(0x1651), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650i_name,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650i_name,
 		     DEVICE(0x3DF0), SUBDEV(0x1652), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x3DF0), SUBDEV(0x2074), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x3DF0), SUBDEV(0x4070), BW_NO_LIMIT),
 
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x4DF0), SUBDEV(0x0070), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x4DF0), SUBDEV(0x0074), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x4DF0), SUBDEV(0x0078), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x4DF0), SUBDEV(0x007C), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x4DF0), SUBDEV(0x0310), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650s_name,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650s_name,
 		     DEVICE(0x4DF0), SUBDEV(0x1651), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, iwl_ax201_killer_1650i_name,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650i_name,
 		     DEVICE(0x4DF0), SUBDEV(0x1652), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x4DF0), SUBDEV(0x2074), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x4DF0), SUBDEV(0x4070), BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_ax201_cfg_qu_hr, NULL,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
 		     DEVICE(0x4DF0), SUBDEV(0x6074), BW_NO_LIMIT),
 
 	/* So with HR */
-- 
2.34.1


