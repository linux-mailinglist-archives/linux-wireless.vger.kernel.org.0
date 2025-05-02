Return-Path: <linux-wireless+bounces-22341-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61E9AA71A2
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1683C9C21AA
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF57426ACD;
	Fri,  2 May 2025 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fFNW9fyb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5DD253B7B
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188468; cv=none; b=o1hRXQOXpJTYe/G+mGXQb0D6XPZ3p0ZIksUMM69c4xusfGl+p5pXFMYONSFKu6hPa2MqCpwF0c4FNzZ8obegTMnn00KsxX6+vX4QWh/Zy7KaCYXb1wpO1sHr0GkchARQUxwrxe7fNiTCMtexyioboQkOlitf0aAKD4j5qAsCP+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188468; c=relaxed/simple;
	bh=oL6W625I1Ub6OsXIKPmhP07l8bfYzRKh9VF09GQOaq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VaCP1Rr8sDoCJcA+dnINo9R6veThPoDvRXIlIRfKTVgnbzoBZXN/D6nx70qhABgkBAqipDSC3FkTptv59T+YuVUfKoZZwwzns5n07kfZNeMz7Ug8ZJOppcupjduf/uKo7uV/2le4QEnTs6BGQbZCZuSWWycQeJwYcDqeS9CGVHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fFNW9fyb; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746188467; x=1777724467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oL6W625I1Ub6OsXIKPmhP07l8bfYzRKh9VF09GQOaq8=;
  b=fFNW9fybHUWAe98vFrpc5lgYqcM3e/mbhVB1q6nVqv/ph4NfeUThtzTn
   9L4wPMU1THk3VZhA5n2O4H56KkmACCrX/Ca1lDQeXsolDbBA4Bg6K2GoR
   zzp4j2phSW+Y/bRgik8Qr1MRqOY/c1u2P369y/od/TMJbRrLu5bSMk2To
   uCY32BZJAp+a345Vo4QUGZfAR/18yVEW7X1rHs4NPFGZYSTyMabtYBPG4
   tDh17syOjg0zvqHU8UYdcLkfFS16FV32iaxvM2UOD10HWErhdya13nWTk
   oTCkNVZNBEwFScUxr2WPnKQpybqnPS7XsRNyFThqa8zdSJp+vc3tv+HvA
   g==;
X-CSE-ConnectionGUID: hicDFWdKTySsotvqyef5Cw==
X-CSE-MsgGUID: ZF9DTxK/Scy4+vOSW5kqrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="48010375"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="48010375"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:21:06 -0700
X-CSE-ConnectionGUID: zIbKq25USearkOS34Rxo/A==
X-CSE-MsgGUID: sJoPdyzeQdSjUDa/+qDY4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="134586160"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:21:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 15/15] wifi: iwlwifi: cfg: remove duplicated Sc device configs
Date: Fri,  2 May 2025 15:20:30 +0300
Message-Id: <20250502151751.2bab15a21306.I079987bc4a1679789bacc1078952aa90c805ffe0@changeid>
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

The configurations for Sc, Sc2 and Sc2f are all the same,
so keep just a single config struct.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  8 --------
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  2 --
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 20 +++++++++----------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 4b39f11c9582..405c282e019c 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -149,14 +149,6 @@ const struct iwl_cfg iwl_cfg_sc = {
 	IWL_DEVICE_SC,
 };
 
-const struct iwl_cfg iwl_cfg_sc2 = {
-	IWL_DEVICE_SC,
-};
-
-const struct iwl_cfg iwl_cfg_sc2f = {
-	IWL_DEVICE_SC,
-};
-
 IWL_FW_AND_PNVM(IWL_SC_A_FM_B_FW_PRE, IWL_SC_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_SC_A_FM_C_FW_PRE, IWL_SC_UCODE_API_MAX);
 MODULE_FIRMWARE(IWL_SC_A_HR_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index c4f914010033..8862148a49bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -641,8 +641,6 @@ extern const struct iwl_ht_params iwl_bz_ht_params;
 extern const struct iwl_cfg iwl_cfg_bz;
 
 extern const struct iwl_cfg iwl_cfg_sc;
-extern const struct iwl_cfg iwl_cfg_sc2;
-extern const struct iwl_cfg iwl_cfg_sc2f;
 extern const struct iwl_cfg iwl_cfg_dr;
 extern const struct iwl_cfg iwl_cfg_br;
 #endif /* CONFIG_IWLMLD */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 950c680edbfa..6c4854f44b26 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1133,20 +1133,20 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_sp_name, MAC_TYPE(SC), RF_TYPE(WH),
 		     BW_LIMIT(160)),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_pe_name, MAC_TYPE(SC), RF_TYPE(PE)),
-	IWL_DEV_INFO(iwl_cfg_sc2, iwl_ax211_name, MAC_TYPE(SC2), RF_TYPE(GF)),
-	IWL_DEV_INFO(iwl_cfg_sc2, iwl_fm_name, MAC_TYPE(SC2), RF_TYPE(FM)),
-	IWL_DEV_INFO(iwl_cfg_sc2, iwl_wh_name, MAC_TYPE(SC2), RF_TYPE(WH),
+	IWL_DEV_INFO(iwl_cfg_sc, iwl_ax211_name, MAC_TYPE(SC2), RF_TYPE(GF)),
+	IWL_DEV_INFO(iwl_cfg_sc, iwl_fm_name, MAC_TYPE(SC2), RF_TYPE(FM)),
+	IWL_DEV_INFO(iwl_cfg_sc, iwl_wh_name, MAC_TYPE(SC2), RF_TYPE(WH),
 		     BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_cfg_sc2, iwl_sp_name, MAC_TYPE(SC2), RF_TYPE(WH),
+	IWL_DEV_INFO(iwl_cfg_sc, iwl_sp_name, MAC_TYPE(SC2), RF_TYPE(WH),
 		     BW_LIMIT(160)),
-	IWL_DEV_INFO(iwl_cfg_sc2, iwl_pe_name, MAC_TYPE(SC2), RF_TYPE(PE)),
-	IWL_DEV_INFO(iwl_cfg_sc2f, iwl_ax211_name, MAC_TYPE(SC2F), RF_TYPE(GF)),
-	IWL_DEV_INFO(iwl_cfg_sc2f, iwl_fm_name, MAC_TYPE(SC2F), RF_TYPE(FM)),
-	IWL_DEV_INFO(iwl_cfg_sc2f, iwl_wh_name, MAC_TYPE(SC2F), RF_TYPE(WH),
+	IWL_DEV_INFO(iwl_cfg_sc, iwl_pe_name, MAC_TYPE(SC2), RF_TYPE(PE)),
+	IWL_DEV_INFO(iwl_cfg_sc, iwl_ax211_name, MAC_TYPE(SC2F), RF_TYPE(GF)),
+	IWL_DEV_INFO(iwl_cfg_sc, iwl_fm_name, MAC_TYPE(SC2F), RF_TYPE(FM)),
+	IWL_DEV_INFO(iwl_cfg_sc, iwl_wh_name, MAC_TYPE(SC2F), RF_TYPE(WH),
 		     BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_cfg_sc2f, iwl_sp_name, MAC_TYPE(SC2F), RF_TYPE(WH),
+	IWL_DEV_INFO(iwl_cfg_sc, iwl_sp_name, MAC_TYPE(SC2F), RF_TYPE(WH),
 		     BW_LIMIT(160)),
-	IWL_DEV_INFO(iwl_cfg_sc2f, iwl_pe_name, MAC_TYPE(SC2F), RF_TYPE(PE)),
+	IWL_DEV_INFO(iwl_cfg_sc, iwl_pe_name, MAC_TYPE(SC2F), RF_TYPE(PE)),
 
 /* Dr */
 	IWL_DEV_INFO(iwl_cfg_dr, iwl_dr_name, MAC_TYPE(DR)),
-- 
2.34.1


