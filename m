Return-Path: <linux-wireless+bounces-22339-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17317AA719D
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F67E1735BE
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961E025484E;
	Fri,  2 May 2025 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AAMra7iW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1F22550D5
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188465; cv=none; b=IPk2rhn4tSERjsTSgio9wiyMKejey9pzkPfLy1wo8tOubRIh6vYgkrsBh0/uR92j62ioi/tYabXbmZ7Ta9vXj0giP3B+4S33yFR1YJraS2fCr87UnEEXOpRIdk1WxZSzxuhepH8fkXRspJJiJlIUEc+wy05WNpw0cfy6QoH+CTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188465; c=relaxed/simple;
	bh=t7YD4gtBUu98i9qV6T5EDwc4PEGmU5TVB1+yLSKWNQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CP5L+oem8/JCxLkueBaeC+YLmf0WpMOsgAkIGKNnH368q0I84z78ZNyFkQ4fWfki2MzKE2wI/hcRGwlXOn7CrlaZWqP8HvUcBPBW1XjyLWD3kt4QfnvumU3dXV8DlWrc8j0hFE0zBdDfOL/QJWFQIzbTdONH0/ujy7St8C+BMSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AAMra7iW; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746188464; x=1777724464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t7YD4gtBUu98i9qV6T5EDwc4PEGmU5TVB1+yLSKWNQ4=;
  b=AAMra7iWaSSXPUka9e+XusD48r9+pt0KmRhBR3DpsmDZh6X1xmQn2bNr
   nnAP9eN1tGGimSbmtoP6lvlg8qWn6O6/FGm6YxQA2GUEGxYHjB/0i/YJo
   6vRSf/WnsSYUAGoAYZMCZlTDDcHpRb5befRl9l3LJYR78pVWSdTzWbVEF
   MhRozzh8M7UDTqHHveJ0KNVNnbmUrbQgyvZs9jxVeXeuHB5577MtLN6IV
   rTaVNg2VS9lKCN86GWJR6hQunICMLlsM4dYnYmEiSvhznC/49EeuDC32w
   aHZkjkCSb6KMh9TvJcWp/ZnYyodV4oK1NFrHAsahqlVFG6UDy8s2g6C1l
   Q==;
X-CSE-ConnectionGUID: raJu/0rUTIGJ2jWR4WGMIA==
X-CSE-MsgGUID: 9JAZEGaDTrGp5NvEGx8PuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="48010371"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="48010371"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:21:03 -0700
X-CSE-ConnectionGUID: SQzTyIJlR72qM8WVkAcYIQ==
X-CSE-MsgGUID: AcYT7mbkT8GqizN66a8pPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="134586148"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:21:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 13/15] wifi: iwlwifi: cfg: remove iwl_ax201_cfg_qu_hr
Date: Fri,  2 May 2025 15:20:28 +0300
Message-Id: <20250502151751.17fc47c72232.I2cb4476b9bca6e770bd375ad6ce650553dbde0f1@changeid>
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
index 95123cb26de6..ad938f05410f 100644
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


