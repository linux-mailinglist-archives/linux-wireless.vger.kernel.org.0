Return-Path: <linux-wireless+bounces-22329-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C53AA7195
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34201C00838
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC7B254877;
	Fri,  2 May 2025 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mP3klnN7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FA91E47CA
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188451; cv=none; b=hqhvzMqNeJgZS0NyrFQ9Sg0djRM0ufI+fiWMQDwr3isw5yL8qdRv1OEtAzKfOnjuirqVPT0mVDrueuPdokj2obem5BeKbXPHNza2sUVPNm8s80H/+NTk9hUddc1yAaTP3wXYBF7PPo6c61fL3qatdekmn1AKKXd13KBHiDT1T6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188451; c=relaxed/simple;
	bh=r2nNKam3BwQN0wvwg9ToaI6lC+QbC0QQtRUwUgZxOmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sZgqegHaHwd0aXZMA7XPk0KJIWne7nEwiM4k18Ky+5/wttWK2e9+S0XBgjmncEasm2GpmFMPVsN09SpzBnI3hKBIUTgNzQeadQb0t2b+Pt+Ym+hctIC60/hLPvbsRyvPcwNjztpRS9FiFE6UKPaVkhjQdQVOlLXSIUQ6UN0BvKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mP3klnN7; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746188450; x=1777724450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r2nNKam3BwQN0wvwg9ToaI6lC+QbC0QQtRUwUgZxOmE=;
  b=mP3klnN7Yd6MXD0ARTtlXcaNk4wlT++kSr+PI9/X0FrFiobhR2obJ9ux
   5F/cmmhbR88fIT2jpQpT3b8HBmJDRqiecb+jtwjXvMYUB2rMPLtexE1oj
   TpNexM2fEAt9J8k2EHfS7FYe218jJ4LR1et3yuVFnYD4BJj4ltiQdtQWZ
   mllv0qPJgoJHBFeOFIhIQ/eLiiq02K7kvTzIdDlk+rB9kWcwl4pu6W10x
   5KBwqM3j862iNQyRZH60+pTBJXE2EmCSCgqyzkLvCZzXCiWJW6FB6sysN
   OFZFmSJVVR3aR3FzAH9jWsQ1s3xj1CyX7wCGk1oFcxBXTxJGoo4LsrphZ
   Q==;
X-CSE-ConnectionGUID: xv1pT2p0SMWMpiy0/QZxOQ==
X-CSE-MsgGUID: 74JoW9xwT8ilPrdKKJr7bA==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="48010349"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="48010349"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:20:49 -0700
X-CSE-ConnectionGUID: hbzCJI+NSjyaPHuaZ588XQ==
X-CSE-MsgGUID: wsHABPn8TaqAfAnizkRLVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="134586103"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:20:47 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Subject: [PATCH v2 iwlwifi-next 03/15] wifi: iwlwifi: pcie: Add support for new device ids
Date: Fri,  2 May 2025 15:20:18 +0300
Message-Id: <20250502151751.a66928fcc82a.Icbbc7c28855f8de232cb3916901a4da3ac286117@changeid>
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

From: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>

Add device support for PeP on ScP

Signed-off-by: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c     | 1 +
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 1 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 670031fd60dc..5c740f302c93 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -143,6 +143,7 @@ const struct iwl_cfg_trans_params iwl_sc_trans_cfg = {
 };
 
 const char iwl_sp_name[] = "Intel(R) Wi-Fi 7 BE213 160MHz";
+const char iwl_pe_name[] = "Intel(R) Wi-Fi 8 BN201";
 
 const struct iwl_cfg iwl_cfg_sc = {
 	.fw_name_mac = "sc",
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index f9fdb7c97636..a14488f03f92 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -549,6 +549,7 @@ extern const char iwl_ax411_name[];
 extern const char iwl_fm_name[];
 extern const char iwl_wh_name[];
 extern const char iwl_sp_name[];
+extern const char iwl_pe_name[];
 extern const char iwl_gl_name[];
 extern const char iwl_mtp_name[];
 extern const char iwl_dr_name[];
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 7b09edc2430c..23edb203e983 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1131,18 +1131,21 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_sp_name, MAC_TYPE(SC), RF_TYPE(WH),
 		     BW_LIMIT(160)),
+	IWL_DEV_INFO(iwl_cfg_sc, iwl_pe_name, MAC_TYPE(SC), RF_TYPE(PE)),
 	IWL_DEV_INFO(iwl_cfg_sc2, iwl_ax211_name, MAC_TYPE(SC2), RF_TYPE(GF)),
 	IWL_DEV_INFO(iwl_cfg_sc2, iwl_fm_name, MAC_TYPE(SC2), RF_TYPE(FM)),
 	IWL_DEV_INFO(iwl_cfg_sc2, iwl_wh_name, MAC_TYPE(SC2), RF_TYPE(WH),
 		     BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_cfg_sc2, iwl_sp_name, MAC_TYPE(SC2), RF_TYPE(WH),
 		     BW_LIMIT(160)),
+	IWL_DEV_INFO(iwl_cfg_sc2, iwl_pe_name, MAC_TYPE(SC2), RF_TYPE(PE)),
 	IWL_DEV_INFO(iwl_cfg_sc2f, iwl_ax211_name, MAC_TYPE(SC2F), RF_TYPE(GF)),
 	IWL_DEV_INFO(iwl_cfg_sc2f, iwl_fm_name, MAC_TYPE(SC2F), RF_TYPE(FM)),
 	IWL_DEV_INFO(iwl_cfg_sc2f, iwl_wh_name, MAC_TYPE(SC2F), RF_TYPE(WH),
 		     BW_NO_LIMIT),
 	IWL_DEV_INFO(iwl_cfg_sc2f, iwl_sp_name, MAC_TYPE(SC2F), RF_TYPE(WH),
 		     BW_LIMIT(160)),
+	IWL_DEV_INFO(iwl_cfg_sc2f, iwl_pe_name, MAC_TYPE(SC2F), RF_TYPE(PE)),
 
 /* Dr */
 	IWL_DEV_INFO(iwl_cfg_dr, iwl_dr_name, MAC_TYPE(DR)),
-- 
2.34.1


