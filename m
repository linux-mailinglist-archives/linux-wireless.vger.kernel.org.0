Return-Path: <linux-wireless+bounces-9535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AF1916E72
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 18:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C808F1C21F67
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 16:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4CC176239;
	Tue, 25 Jun 2024 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ii5SLXrP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB53217622B
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334297; cv=none; b=nNOOdv5nC6JyiFycAmp2yYZWLrmjv3lreV+HA3B4AlgZm0qlDiSHUkJcHCUF0z5yIfBW+eUaNWlEbGwrU4PeklAxiLr2hbipnhz1Ddt635vnXZgJhz4cYO/T/ffqnTwj2j+CzRe/TR5lKBbMvpG4jJueOKQJauIgMTBb2KS5qb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334297; c=relaxed/simple;
	bh=f9mhB0HFbK7Uqzk+kkAx84fTOOGLW4lAfbsz4Ui2WNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=htcLdFYEj3HG1Wv7C0GXaViF0RkycelJwu2HWdCsQdB3kC30E9Qrfadhv7LSM8L95U1PvAn/P4bWYlMFIh1mi0Lvjj/Uu7qt9TDtjvrxDRxnjpOfw8qoxdkNR0xInhd97EZ4li0QLkph0uwBFx/5uLalznGvYRm2h2toenjmSk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ii5SLXrP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719334296; x=1750870296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f9mhB0HFbK7Uqzk+kkAx84fTOOGLW4lAfbsz4Ui2WNU=;
  b=ii5SLXrPBxmHKUDxUkNE8/mQW8m/z9gDEcyjORasW/iEPVRE4tiEgtQH
   PO+MxwULxWZL2TUZzequb19d45SeLK4v73iENwhggd2/uViVbO2thlEpa
   xLrlEsnz3mot5IhrvuXHhoXABIr+sbue3My4cYi8KkLk2BSkieQtMovNO
   AmS5SWDIIcYQ6GXIlB1KChgSJAfOR16Edvgx5Cey13UmJOLEukFNqvWgm
   hKRRUPlpz47UEcuukYSwc9xnaUMBP2mG2dFdEvs6RSwmS9o70vBDPosOh
   5bkmGOmupF+KoiLq4fs7HL+KTKN0EOkq9+BjKXak8VeLWOQ97BCvEjoOk
   g==;
X-CSE-ConnectionGUID: sy0Vh8F6SgmQTc+WEWKfdQ==
X-CSE-MsgGUID: Yp70hkn6Q2iFDgGitpsr/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16594679"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16594679"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:33 -0700
X-CSE-ConnectionGUID: LWZ3SLYNTWeKl82ND/g2sg==
X-CSE-MsgGUID: sxdnAx2mS3uZsZA/iAChyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48632429"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH 01/17] wifi: iwlwifi: remove MVM prefix from scan API
Date: Tue, 25 Jun 2024 19:51:07 +0300
Message-Id: <20240625194805.09f672318944.Idffeab6a4dfc12effebd1c50815ae5c540afca74@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
References: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

These are not MVM specific.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h  | 6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 8 ++++----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 6684506f4fc4..c00f9422306d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -443,10 +443,10 @@ struct iwl_periodic_scan_complete {
 /* UMAC Scan API */
 
 /* The maximum of either of these cannot exceed 8, because we use an
- * 8-bit mask (see IWL_MVM_SCAN_MASK in mvm.h).
+ * 8-bit mask (see enum iwl_scan_status).
  */
-#define IWL_MVM_MAX_UMAC_SCANS 4
-#define IWL_MVM_MAX_LMAC_SCANS 1
+#define IWL_MAX_UMAC_SCANS 4
+#define IWL_MAX_LMAC_SCANS 1
 
 enum scan_config_flags {
 	SCAN_CONFIG_FLAG_ACTIVATE			= BIT(0),
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 8c732becd281..d29531d95353 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -591,13 +591,13 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	hw->wiphy->max_scan_ssids = PROBE_OPTION_MAX;
 
 	BUILD_BUG_ON(IWL_MVM_SCAN_STOPPING_MASK & IWL_MVM_SCAN_MASK);
-	BUILD_BUG_ON(IWL_MVM_MAX_UMAC_SCANS > HWEIGHT32(IWL_MVM_SCAN_MASK) ||
-		     IWL_MVM_MAX_LMAC_SCANS > HWEIGHT32(IWL_MVM_SCAN_MASK));
+	BUILD_BUG_ON(IWL_MAX_UMAC_SCANS > HWEIGHT32(IWL_MVM_SCAN_MASK) ||
+		     IWL_MAX_LMAC_SCANS > HWEIGHT32(IWL_MVM_SCAN_MASK));
 
 	if (fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_UMAC_SCAN))
-		mvm->max_scans = IWL_MVM_MAX_UMAC_SCANS;
+		mvm->max_scans = IWL_MAX_UMAC_SCANS;
 	else
-		mvm->max_scans = IWL_MVM_MAX_LMAC_SCANS;
+		mvm->max_scans = IWL_MAX_LMAC_SCANS;
 
 	if (mvm->nvm_data->bands[NL80211_BAND_2GHZ].n_channels)
 		hw->wiphy->bands[NL80211_BAND_2GHZ] =
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 5bd388881092..e51e834902a9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1071,7 +1071,7 @@ struct iwl_mvm {
 	unsigned int max_scans;
 
 	/* UMAC scan tracking */
-	u32 scan_uid_status[IWL_MVM_MAX_UMAC_SCANS];
+	u32 scan_uid_status[IWL_MAX_UMAC_SCANS];
 
 	/* start time of last scan in TSF of the mac that requested the scan */
 	u64 scan_start;
-- 
2.34.1


