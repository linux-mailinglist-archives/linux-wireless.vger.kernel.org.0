Return-Path: <linux-wireless+bounces-22218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF02AA1BA3
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 21:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5903BEEB8
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 19:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA98267B0C;
	Tue, 29 Apr 2025 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dvXuVH1D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C07025A2A5
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956465; cv=none; b=FCVohwlrrLDrYfrgUt6AejTzoQECScarS5dSFtsLz358I6fFU7WadlWMAOcjpmnIe4L0FCUOobHJ2veqyvM0y2u1+k1zg0/zsflRRAbGBEsbGJuDc2B71H1sDoH9yhWsBDvHqqdZdWBD6Q8miN/QkWrO0CXa76KWeH5JizD8gdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956465; c=relaxed/simple;
	bh=fHvmKbD+3qW8W9mSM2sAi6M98o4JUE5JKVWgUNiVjN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EFuObZj0OsXkez5yZ8Kn9yovGz0nYLWn+bte3iNYo/f7nPN6f9jDTrJwFBnGuMJyx5vkmIpEK7ICPLpmkYmI505Rb3CD5G1Gm345RdBaa5V7+G/OitqhjHJs9Gdsx/cWVpCni+hH2Rf/qB4SUqJZqJVVQtAFI7OZOmBlAgR9Lw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dvXuVH1D; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745956464; x=1777492464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fHvmKbD+3qW8W9mSM2sAi6M98o4JUE5JKVWgUNiVjN4=;
  b=dvXuVH1DRVTo0EYoTM/PkIs1svYc7FEgwMOajS0Oyv58PcWLXVpOTrJB
   DV4y4f8jmKo2LsHC738CR9HhnJK6wgtQODovfjFHqnTXZjba1AfAZFjfY
   pHBVAln+PpL+mVQgSXHY3b10WncpvGkw66cbw1FFEJN/mpCEEqBqsHLZd
   DZ1Htx3pGfDe0Jc1iMSDmKAXT9NHgV28UW7S2jAg2bgJ93WZLm8nJRrAh
   gtLdahb2qyKh17KJ/JHud8xNOxxP17NA8wt+BqZucb+5XqdXAEeqAwIel
   2efSNMrSQbhvCQXpgD+0bMVVJo+6cFsGixt2PPs596YS9/EBb7Nbbl8ux
   Q==;
X-CSE-ConnectionGUID: b1TBl+edTZy2ScMqsBPX4Q==
X-CSE-MsgGUID: UlUb4tFKSLCGxqLyOSGDGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="46713601"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="46713601"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:24 -0700
X-CSE-ConnectionGUID: 0dbetbVoQ++5Fv2GqNgEKw==
X-CSE-MsgGUID: q4aukIf7TZ6in7HV/grlGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="171155041"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:23 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next 13/14] wifi: iwlwifi: fw: support reading PPAG BIOS table revision 4
Date: Tue, 29 Apr 2025 22:53:43 +0300
Message-Id: <20250429224932.5633d853cb25.I56d6887866f76fd02b2cd298e3de1189c6d3890e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250429195344.254957-1-miriam.rachel.korenblit@intel.com>
References: <20250429195344.254957-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

PPAG revision 4 data has more supported bits than supported in
version 6 of PPAG command. So, adjust by masking accordingly to
firmware acceptance.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       | 4 ++--
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  | 9 +++++++++
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c | 4 +++-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h | 4 ++++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       | 2 +-
 5 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 68b461297174..a1c949d15d94 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -847,12 +847,12 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	/* try to read ppag table rev 3, 2 or 1 (all have the same data size) */
+	/* try to read ppag table rev 1 to 4 (all have the same data size) */
 	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
 				ACPI_PPAG_WIFI_DATA_SIZE_V2, &tbl_rev);
 
 	if (!IS_ERR(wifi_pkg)) {
-		if (tbl_rev >= 1 && tbl_rev <= 3) {
+		if (tbl_rev >= 1 && tbl_rev <= 4) {
 			num_sub_bands = IWL_NUM_SUB_BANDS_V2;
 			IWL_DEBUG_RADIO(fwrt,
 					"Reading PPAG table (tbl_rev=%d)\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 1238c23ac48b..1c09c30055b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -658,6 +658,15 @@ union iwl_ppag_table_cmd {
 			      IWL_PPAG_ETSI_LPI_UHB_MASK | \
 			      IWL_PPAG_USA_LPI_UHB_MASK)
 
+#define IWL_PPAG_CMD_V6_MASK (IWL_PPAG_CMD_V5_MASK |		\
+			      IWL_PPAG_ETSI_VLP_UHB_MASK |	\
+			      IWL_PPAG_ETSI_SP_UHB_MASK |	\
+			      IWL_PPAG_USA_VLP_UHB_MASK |	\
+			      IWL_PPAG_USA_SP_UHB_MASK |	\
+			      IWL_PPAG_CANADA_LPI_UHB_MASK |	\
+			      IWL_PPAG_CANADA_VLP_UHB_MASK |	\
+			      IWL_PPAG_CANADA_SP_UHB_MASK)
+
 #define MCC_TO_SAR_OFFSET_TABLE_ROW_SIZE	26
 #define MCC_TO_SAR_OFFSET_TABLE_COL_SIZE	13
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index bb8ddfad8621..4508de2508d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -374,7 +374,9 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 			"PPAG MODE bits were read from bios: %d\n",
 			le32_to_cpu(cmd->v1.flags));
 
-	if (cmd_ver == 5)
+	if (cmd_ver == 6)
+		cmd->v1.flags &= cpu_to_le32(IWL_PPAG_CMD_V6_MASK);
+	else if (cmd_ver == 5)
 		cmd->v1.flags &= cpu_to_le32(IWL_PPAG_CMD_V5_MASK);
 	else if (cmd_ver < 5)
 		cmd->v1.flags &= cpu_to_le32(IWL_PPAG_CMD_V4_MASK);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 641b4463e898..bd5c0a27718c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -226,6 +226,10 @@ int iwl_bios_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 static inline u32 iwl_bios_get_ppag_flags(const u32 ppag_modes,
 					  const u8 ppag_bios_rev)
 {
+	/* For revision 4 and above driver is pipe */
+	if (ppag_bios_rev >= 4)
+		return ppag_modes;
+
 	return ppag_modes & (ppag_bios_rev < 3 ? IWL_PPAG_ETSI_CHINA_MASK :
 						 IWL_PPAG_REV3_MASK);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 37d2ced03ce1..ace36cb081e6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -34,7 +34,7 @@
 #define IWL_UEFI_EWRD_REVISION		2
 #define IWL_UEFI_WGDS_REVISION		3
 #define IWL_UEFI_MIN_PPAG_REV		1
-#define IWL_UEFI_MAX_PPAG_REV		3
+#define IWL_UEFI_MAX_PPAG_REV		4
 #define IWL_UEFI_MIN_WTAS_REVISION	1
 #define IWL_UEFI_MAX_WTAS_REVISION	2
 #define IWL_UEFI_SPLC_REVISION		0
-- 
2.34.1


