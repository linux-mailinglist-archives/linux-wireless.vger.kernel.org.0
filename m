Return-Path: <linux-wireless+bounces-22475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3BEAA9C1C
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 20:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E34387A8AC7
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 18:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B294726FD86;
	Mon,  5 May 2025 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cu4c8wJI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F103826FA7B
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 18:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471449; cv=none; b=L5URcrJBnFAXvDiU8eGquuueQntCBsThup98NwL/CHq/blYKjwMc6hcpyzYb36uAEF7pecdkLdqh++j1KQ+Nky4BPbMm6Ycr9/8L2dX08Yl6QbISa+eJm3AcvHVv2T1eDlW+ONLw97v0ZE7HOlNP0BEGYe8M1SYQF7ILqVafX9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471449; c=relaxed/simple;
	bh=S0zVByqLrem4kW69OTOgM1wC6CL1zGy//JE4WhP5YEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cixR/P38r5VMEcCTRL3pZsSzCVlVRvqTAccuy7siqrv0svlBrMFrVEda8NxwcwkCuitmqV16R5nrlWJ3r7Ju1w1HHYWpCRkWLR9NvzYIWlfbbmE2u6MRRnyad8KEz0C1BNKm0nSyBwkg3m3elEQc6fPSpMyvIRLFDqDFxfvwf+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cu4c8wJI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746471448; x=1778007448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S0zVByqLrem4kW69OTOgM1wC6CL1zGy//JE4WhP5YEk=;
  b=Cu4c8wJIQzdXQ+1Ev37LS6hpco4d4tshaAiU+AurzYVmhoZi73ebLx+P
   GJxcVDFE9YICEI+Zjujo1tURI7MxBTrO+NJvf2uDFaV9f8T3UPJ8udQLQ
   TIuJJ4+J2aEoUB/rQLNAfc3XlRP/mVYZ7xWDgO0OnHs6VlK3ulRFY/lOc
   Nh+w3puV5kqHR4RFkT+DRPnxLStXeUSKK1i0fSIs0q7snIW0HFRMpnchH
   nvwcq+Jfart9P892AYBC0ND2WGO1551baptTkwvP5lcrGcIcFgzzQaJIn
   4uMY04JhxhtKrZi1LZtvU0lOX7EVTmJaxNXGwcxH/VlDQrbheN+UNT4tv
   g==;
X-CSE-ConnectionGUID: NHrsG3ApSIK9U9kdPsoN9w==
X-CSE-MsgGUID: 4kELf3enT1ShM/oK1wKX7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47359459"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="47359459"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:27 -0700
X-CSE-ConnectionGUID: l2SzB+NkQ2ejfqFTar+gwA==
X-CSE-MsgGUID: 0tb9FlCvTaClcEQtnLZI1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="135698043"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	"Bjoern A . Zeeb" <bz@FreeBSD.org>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: make iwl_uefi_get_uats_table() return void
Date: Mon,  5 May 2025 21:56:51 +0300
Message-Id: <20250505215513.e981a7911228.Ic94b5e03e2053a08b84cabeb58ce3b6598fd9fc6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
References: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This sets both fwrt->uats_valid and returns 0, but in the
static inline it returns 0 without setting uats_valid,
which is confusing and the iwlmvm code misbehaves in this
case.

Since it already sets uats_valid, just remove the extra
return value.

Reported-by: Bjoern A. Zeeb <bz@FreeBSD.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c        | 13 ++++---------
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h        | 10 ++++------
 drivers/net/wireless/intel/iwlwifi/mld/regulatory.c |  4 +---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c         |  7 +++----
 4 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index ce17424f3a60..ce68d96c31b8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -410,8 +410,8 @@ static int iwl_uefi_uats_parse(struct uefi_cnv_wlan_uats_data *uats_data,
 	return 0;
 }
 
-int iwl_uefi_get_uats_table(struct iwl_trans *trans,
-			    struct iwl_fw_runtime *fwrt)
+void iwl_uefi_get_uats_table(struct iwl_trans *trans,
+			     struct iwl_fw_runtime *fwrt)
 {
 	struct uefi_cnv_wlan_uats_data *data;
 	int ret;
@@ -419,17 +419,12 @@ int iwl_uefi_get_uats_table(struct iwl_trans *trans,
 	data = iwl_uefi_get_verified_variable(trans, IWL_UEFI_UATS_NAME,
 					      "UATS", sizeof(*data), NULL);
 	if (IS_ERR(data))
-		return -EINVAL;
+		return;
 
 	ret = iwl_uefi_uats_parse(data, fwrt);
-	if (ret < 0) {
+	if (ret < 0)
 		IWL_DEBUG_FW(trans, "Cannot read UATS table. rev is invalid\n");
-		kfree(data);
-		return ret;
-	}
-
 	kfree(data);
-	return 0;
 }
 IWL_EXPORT_SYMBOL(iwl_uefi_get_uats_table);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 81df7020b2c7..5a4c557e47c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -272,8 +272,8 @@ int iwl_uefi_get_wbem(struct iwl_fw_runtime *fwrt, u32 *value);
 int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 		     u32 *value);
 void iwl_uefi_get_sgom_table(struct iwl_trans *trans, struct iwl_fw_runtime *fwrt);
-int iwl_uefi_get_uats_table(struct iwl_trans *trans,
-			    struct iwl_fw_runtime *fwrt);
+void iwl_uefi_get_uats_table(struct iwl_trans *trans,
+			     struct iwl_fw_runtime *fwrt);
 int iwl_uefi_get_puncturing(struct iwl_fw_runtime *fwrt);
 int iwl_uefi_get_dsbr(struct iwl_fw_runtime *fwrt, u32 *value);
 int iwl_uefi_get_phy_filters(struct iwl_fw_runtime *fwrt);
@@ -368,11 +368,9 @@ void iwl_uefi_get_sgom_table(struct iwl_trans *trans, struct iwl_fw_runtime *fwr
 {
 }
 
-static inline
-int iwl_uefi_get_uats_table(struct iwl_trans *trans,
-			    struct iwl_fw_runtime *fwrt)
+static inline void
+iwl_uefi_get_uats_table(struct iwl_trans *trans, struct iwl_fw_runtime *fwrt)
 {
-	return 0;
 }
 
 static inline
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
index fa9f8ac14631..326c300470ea 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
@@ -63,9 +63,7 @@ void iwl_mld_get_bios_tables(struct iwl_mld *mld)
 		/* we don't fail if the table is not available */
 	}
 
-	ret = iwl_uefi_get_uats_table(mld->trans, &mld->fwrt);
-	if (ret)
-		IWL_DEBUG_RADIO(mld, "failed to read UATS table (%d)\n", ret);
+	iwl_uefi_get_uats_table(mld->trans, &mld->fwrt);
 
 	iwl_bios_get_phy_filters(&mld->fwrt);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 5d2cafc44a7a..d3ec554d4eba 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -511,11 +511,10 @@ static void iwl_mvm_uats_init(struct iwl_mvm *mvm)
 		return;
 	}
 
-	ret = iwl_uefi_get_uats_table(mvm->trans, &mvm->fwrt);
-	if (ret < 0) {
-		IWL_DEBUG_FW(mvm, "failed to read UATS table (%d)\n", ret);
+	iwl_uefi_get_uats_table(mvm->trans, &mvm->fwrt);
+
+	if (!mvm->fwrt.uats_valid)
 		return;
-	}
 
 	ret = iwl_mvm_send_cmd(mvm, &cmd);
 	if (ret < 0)
-- 
2.34.1


