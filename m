Return-Path: <linux-wireless+bounces-22743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A233AAF977
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 14:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2FDD4A7389
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 12:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7892F22578A;
	Thu,  8 May 2025 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gQIJ/Ib8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAF6225776
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 12:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706410; cv=none; b=ILE7xNQTF2Xw8d84kVAHzmH4NmfG/RWdDhYDZLUpt7LmDpf/B+vRIFiTN1CJTBDYEkY/+bINMKym0s0uX5hH2k6s+7jIXWhIW3gAcMxYnsaPJd5ARDfJk8VAI4+wpd/Fozl0Pkw0nxvnJEpBDWO0G5ds4Ggq/q1LzVtd8TMt0z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706410; c=relaxed/simple;
	bh=f6cI72XIlJ19aGk5G3JZNnD8mDsgPwtTk/Di6EAmbyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OUm2+GN8DiYMmZLUHzD56PvEpk9KHwSlXoGraHLRl/dp0Tz/2MsoE1DLT/+mpudNY0f7y963tqXHhOyS7mlGzye4TN+MdhnEmwI5joBGfbbVHZBAKm/nfkRigHoper81LhH960Qhid02znh5mlo+NCa7BpkR/j4Y49+6UplRcKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gQIJ/Ib8; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746706409; x=1778242409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f6cI72XIlJ19aGk5G3JZNnD8mDsgPwtTk/Di6EAmbyk=;
  b=gQIJ/Ib8V9WKbVmyAu00uo7XivZ7MYhvqu4BNCx1V/I0olFPwabeFAKa
   Y3wROIw8VfEaWVjOFPFxNIsMkA66LbfAT/PqG8LPUbzVeuUWNpZ2/AF6W
   f8cNNJGN0CZEWEEsK5odNM0wwYTywBDGoM562W4G7PXCsrn5g7tFp3uvI
   VloMV4N3sAFM4/AfJi7s6VZGJcR50FvYpzvcpQf1I7uck74YEnLlRL2Mc
   RCOgxn8dHro+aFlcy7u2bPOgvVzl/4CIn4mcg5sCNpU5NLCa5gVgMdtQO
   KtBTYmu/Uw/p2gYXSRUljyzd+A3lNwvTXT4GBHPvswcglptVEkMy2qGE5
   Q==;
X-CSE-ConnectionGUID: dZQ2o7FlSl+1YMr3NOQEGQ==
X-CSE-MsgGUID: SRe2XX++RUun0whVucaOyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="58688039"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="58688039"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:29 -0700
X-CSE-ConnectionGUID: uD2el7vNQESxDEDF94uKIQ==
X-CSE-MsgGUID: 6I0bfoNLTIiESYsyUSPOiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="167347812"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:27 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: cfg: handle cc firmware dynamically
Date: Thu,  8 May 2025 15:12:56 +0300
Message-Id: <20250508121306.1277801-6-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250508121306.1277801-1-miriam.rachel.korenblit@intel.com>
References: <20250508121306.1277801-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Instead of using fw_name_pre, handle the cc firmware file
name specially in iwl_drv_get_fwname_pre() for the cc MAC
type.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250508151045.a6e47e2f761d.I5d58561503c8b02f9145a0c09737897031a909a5@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c  | 6 ------
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c    | 4 ++++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 6 +++---
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 5b0704241b15..073e95a61c0d 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -214,12 +214,6 @@ const struct iwl_cfg iwl_qu_hr_80mhz = {
 	.bw_limit = 80,
 };
 
-const struct iwl_cfg iwl_ax200_cfg_cc = {
-	.fw_name_pre = IWL_CC_A_FW_PRE,
-	IWL_DEVICE_22500,
-	.num_rbds = IWL_NUM_RBDS_22000_HE,
-};
-
 MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_B_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 0977a683459a..320b14303a66 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -410,6 +410,7 @@ struct iwl_cfg {
 #define IWL_CFG_MAC_TYPE_PU		0x31
 #define IWL_CFG_MAC_TYPE_TH		0x32
 #define IWL_CFG_MAC_TYPE_QU		0x33
+#define IWL_CFG_MAC_TYPE_CC		0x34
 #define IWL_CFG_MAC_TYPE_QUZ		0x35
 #define IWL_CFG_MAC_TYPE_SO		0x37
 #define IWL_CFG_MAC_TYPE_TY		0x42
@@ -671,7 +672,6 @@ extern const struct iwl_cfg iwl9560_qu_jf_cfg_80mhz;
 extern const struct iwl_cfg iwl_qu_hr1;
 extern const struct iwl_cfg iwl_qu_hr;
 extern const struct iwl_cfg iwl_qu_hr_80mhz;
-extern const struct iwl_cfg iwl_ax200_cfg_cc;
 extern const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0;
 extern const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0_80mhz;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index eb57981e4c8c..2fade565a810 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -201,6 +201,10 @@ const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
 	case IWL_CFG_MAC_TYPE_QU:
 		mac = "Qu";
 		break;
+	case IWL_CFG_MAC_TYPE_CC:
+		/* special case - no RF since it's fixed (discrete) */
+		scnprintf(buf, FW_NAME_PRE_BUFSIZE, "iwlwifi-cc-a0");
+		return buf;
 	case IWL_CFG_MAC_TYPE_QUZ:
 		mac = "QuZ";
 		/* all QuZ use A0 firmware */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index bffe3bb3e3f0..94c1b844a6b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -997,11 +997,11 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x7E40), SUBDEV(0x1692)),
 
 /* AX200 */
-	IWL_DEV_INFO(iwl_ax200_cfg_cc, iwl_ax200_name,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax200_name,
 		     DEVICE(0x2723)),
-	IWL_DEV_INFO(iwl_ax200_cfg_cc, iwl_ax200_killer_1650w_name,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax200_killer_1650w_name,
 		     DEVICE(0x2723), SUBDEV(0x1653)),
-	IWL_DEV_INFO(iwl_ax200_cfg_cc, iwl_ax200_killer_1650x_name,
+	IWL_DEV_INFO(iwl_qu_hr, iwl_ax200_killer_1650x_name,
 		     DEVICE(0x2723), SUBDEV(0x1654)),
 
 	/* Qu with Hr */
-- 
2.34.1


