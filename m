Return-Path: <linux-wireless+bounces-10636-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E99AF93FC5C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 19:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717A71F2105C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 17:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CFF17F394;
	Mon, 29 Jul 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vp2XSxvA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A10187563
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273658; cv=none; b=gLtzg8h2eGIxJsUQujkpZUlS6G2QCHoSGg3fqkQjAxpweRak19MDlFNlusavPtGamwsQh51OWqR2pFn3oSEiNeRpJJjTn3dKlYQaQYXgCqGgxPg2mprmBBLoFkOwp8l+8bN1LJVy3YmuPtjZ07pIGaLxsftWv2ac/pPDQRKZYBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273658; c=relaxed/simple;
	bh=mZ8TSs2cc3DIyTdmF6pRI2inFHdhSBZgU8cj2YcnQgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ej1/WbzVKmoqKo0ESGPmMkZfVPLKlsrhVuL9h+07337BMosG2G5pjpKbQwbu2JROW6PCpjmcO1Q+ZJvUsuRi274WiVw8MiA6ZKX4V/QpWMiay/HzsHep/BfjkMP23BypQtU6PXTZkSzqbStQSL36fHUXOnJY3PlOZtRNZ/i/RHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vp2XSxvA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722273657; x=1753809657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mZ8TSs2cc3DIyTdmF6pRI2inFHdhSBZgU8cj2YcnQgM=;
  b=Vp2XSxvA207AVP0HCtt/oalR6cAr4jAH5aIia3RvvAsVKr1Z1EeRN4JY
   KVsHMecXan0a8nTErZNXnyBUu9GR/FXcqYp59Vctu0iCsEtblt0DBFDps
   rtFMu4otKH/wrzN9iJCE0gRE/MdyJkjKLaa3er5as8xfB9PV52CMETKRO
   dI9rbBkxS/dEmyoHuSyBiTAcRMGnzZuKhbDORXTBqqF1jZ5EXJ8sbltlD
   A5DHCtk39CxSxbTB89zuLpuof9ZEL67jfjC/ffvYfy+DPgTi8coKYCbzG
   fL2m33FgqebarC7Sqpc57SpqfwIhLyurt3eDuPHKJ8EqaytZzWOPNiSCQ
   g==;
X-CSE-ConnectionGUID: zIQqIWKcTJ+QkM3vo7Yp9w==
X-CSE-MsgGUID: cIMSdjkKQQe/FPVsgLQOpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31445636"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="31445636"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:57 -0700
X-CSE-ConnectionGUID: 6Lj3dOZBRpqtFrkgWrbojA==
X-CSE-MsgGUID: vhSUgbjoT1itOdde33BvLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54288365"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	"Somashekhar(Som)" <somashekhar.puttagangaiah@intel.com>
Subject: [PATCH 16/17] wifi: iwlwifi: Enable channel puncturing for US/CAN from bios
Date: Mon, 29 Jul 2024 20:20:17 +0300
Message-Id: <20240729201718.828f3ecf5118.I5561ab8c7cd48ad4e5d6daf21b037bf88c619a4a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
References: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: "Somashekhar(Som)" <somashekhar.puttagangaiah@intel.com>

Add support for enabling channel puncturing for US/CAN based
on BIOS configuration through UEFI

Signed-off-by: Somashekhar(Som) <somashekhar.puttagangaiah@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 16 ++++++++++
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  2 ++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 29 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  | 28 ++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  8 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  1 +
 7 files changed, 79 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 560a91998cc4..4d9a1f83ef8c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -634,3 +634,19 @@ int iwl_bios_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 	GET_BIOS_TABLE(dsm, fwrt, func, value);
 }
 IWL_EXPORT_SYMBOL(iwl_bios_get_dsm);
+
+bool iwl_puncturing_is_allowed_in_bios(u32 puncturing, u16 mcc)
+{
+	/* Some kind of regulatory mess means we need to currently disallow
+	 * puncturing in the US and Canada unless enabled in BIOS.
+	 */
+	switch (mcc) {
+	case IWL_MCC_US:
+		return puncturing & IWL_UEFI_CNV_PUNCTURING_USA_EN_MSK;
+	case IWL_MCC_CANADA:
+		return puncturing & IWL_UEFI_CNV_PUNCTURING_CANADA_EN_MSK;
+	default:
+		return true;
+	}
+}
+IWL_EXPORT_SYMBOL(iwl_puncturing_is_allowed_in_bios);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index e2c056f483c1..c2209948b4c0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -217,4 +217,6 @@ static inline u32 iwl_bios_get_ppag_flags(const u32 ppag_modes,
 	return ppag_modes & (ppag_ver < 3 ? IWL_PPAG_ETSI_CHINA_MASK :
 					    IWL_PPAG_REV3_MASK);
 }
+
+bool iwl_puncturing_is_allowed_in_bios(u32 puncturing, u16 mcc);
 #endif /* __fw_regulatory_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index fb982d4fe851..754fc5014fbf 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -729,3 +729,32 @@ int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 	kfree(data);
 	return ret;
 }
+
+int iwl_uefi_get_puncturing(struct iwl_fw_runtime *fwrt)
+{
+	struct uefi_cnv_var_puncturing_data *data;
+	/* default value is not enabled if there is any issue in reading
+	 * uefi variable or revision is not supported
+	 */
+	int puncturing = 0;
+
+	data = iwl_uefi_get_verified_variable(fwrt->trans,
+					      IWL_UEFI_PUNCTURING_NAME,
+					      "UefiCnvWlanPuncturing",
+					      sizeof(*data), NULL);
+	if (IS_ERR(data))
+		return puncturing;
+
+	if (data->revision != IWL_UEFI_PUNCTURING_REVISION) {
+		IWL_DEBUG_RADIO(fwrt, "Unsupported UEFI PUNCTURING rev:%d\n",
+				data->revision);
+	} else {
+		puncturing = data->puncturing & IWL_UEFI_PUNCTURING_REV0_MASK;
+		IWL_DEBUG_RADIO(fwrt, "Loaded puncturing bits from UEFI: %d\n",
+				puncturing);
+	}
+
+	kfree(data);
+	return puncturing;
+}
+IWL_EXPORT_SYMBOL(iwl_uefi_get_puncturing);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 1f8884ca8997..0b2477190070 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -22,6 +22,7 @@
 #define IWL_UEFI_ECKV_NAME		L"UefiCnvWlanECKV"
 #define IWL_UEFI_DSM_NAME		L"UefiCnvWlanGeneralCfg"
 #define IWL_UEFI_WBEM_NAME		L"UefiCnvWlanWBEM"
+#define IWL_UEFI_PUNCTURING_NAME	L"UefiCnvWlanPuncturing"
 
 
 #define IWL_SGOM_MAP_SIZE		339
@@ -38,6 +39,7 @@
 #define IWL_UEFI_ECKV_REVISION		0
 #define IWL_UEFI_WBEM_REVISION		0
 #define IWL_UEFI_DSM_REVISION		4
+#define IWL_UEFI_PUNCTURING_REVISION	0
 
 struct pnvm_sku_package {
 	u8 rev;
@@ -194,6 +196,25 @@ struct uefi_cnv_wlan_wbem_data {
 	u32 wbem_320mhz_per_mcc;
 } __packed;
 
+enum iwl_uefi_cnv_puncturing_flags {
+	IWL_UEFI_CNV_PUNCTURING_USA_EN_MSK	= BIT(0),
+	IWL_UEFI_CNV_PUNCTURING_CANADA_EN_MSK	= BIT(1),
+};
+
+#define IWL_UEFI_PUNCTURING_REV0_MASK (IWL_UEFI_CNV_PUNCTURING_USA_EN_MSK | \
+				       IWL_UEFI_CNV_PUNCTURING_CANADA_EN_MSK)
+/**
+ * struct uefi_cnv_var_puncturing_data - controlling channel
+ *	puncturing for few countries.
+ * @revision: the revision of the table
+ * @puncturing: enablement of channel puncturing per mcc
+ *	see &enum iwl_uefi_cnv_puncturing_flags.
+ */
+struct uefi_cnv_var_puncturing_data {
+	u8 revision;
+	u32 puncturing;
+} __packed;
+
 /*
  * This is known to be broken on v4.19 and to work on v5.4.  Until we
  * figure out why this is the case and how to make it work, simply
@@ -224,6 +245,7 @@ int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 void iwl_uefi_get_sgom_table(struct iwl_trans *trans, struct iwl_fw_runtime *fwrt);
 int iwl_uefi_get_uats_table(struct iwl_trans *trans,
 			    struct iwl_fw_runtime *fwrt);
+int iwl_uefi_get_puncturing(struct iwl_fw_runtime *fwrt);
 #else /* CONFIG_EFI */
 static inline void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 {
@@ -320,5 +342,11 @@ int iwl_uefi_get_uats_table(struct iwl_trans *trans,
 {
 	return 0;
 }
+
+static inline
+int iwl_uefi_get_puncturing(struct iwl_fw_runtime *fwrt)
+{
+	return 0;
+}
 #endif /* CONFIG_EFI */
 #endif /* __iwl_fw_uefi__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index f48f445e006c..d6f4caa939bd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -165,12 +165,8 @@ struct ieee80211_regdomain *iwl_mvm_get_regdomain(struct wiphy *wiphy,
 	mvm->lar_regdom_set = true;
 	mvm->mcc_src = src_id;
 
-	/* Some kind of regulatory mess means we need to currently disallow
-	 * puncturing in the US and Canada. Do that here, at least until we
-	 * figure out the new chanctx APIs for puncturing.
-	 */
-	if (resp->mcc == cpu_to_le16(IWL_MCC_US) ||
-	    resp->mcc == cpu_to_le16(IWL_MCC_CANADA))
+	if (!iwl_puncturing_is_allowed_in_bios(mvm->bios_enable_puncturing,
+					       le16_to_cpu(resp->mcc)))
 		ieee80211_hw_set(mvm->hw, DISALLOW_PUNCTURING);
 	else
 		__clear_bit(IEEE80211_HW_DISALLOW_PUNCTURING, mvm->hw->flags);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 9cb7045cc0ba..bd754b8a71fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1368,6 +1368,7 @@ struct iwl_mvm {
 	struct iwl_mvm_acs_survey *acs_survey;
 
 	bool statistics_clear;
+	u32 bios_enable_puncturing;
 };
 
 /* Extract MVM priv from op_mode and _hw */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 279c92307420..8896d9792feb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1296,6 +1296,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	}
 
 	mvm->fw_restart = iwlwifi_mod_params.fw_restart ? -1 : 0;
+	mvm->bios_enable_puncturing = iwl_uefi_get_puncturing(&mvm->fwrt);
 
 	if (iwl_mvm_has_new_tx_api(mvm)) {
 		/*
-- 
2.34.1


