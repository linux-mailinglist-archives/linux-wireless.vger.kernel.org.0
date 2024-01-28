Return-Path: <linux-wireless+bounces-2619-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D63CC83F476
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 07:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500BE1F22CAD
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 06:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEB38F68;
	Sun, 28 Jan 2024 06:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/0TVe9B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269BB6117
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jan 2024 06:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706424908; cv=none; b=Rt4Vkoi4B8XLOO0tPlk+TPEfejmVYuO45c+eGT6FbZzo3g4mzT6Jb+1cb9tggi0pBuzTp1TA7b9B/sOW9iejpBkGbHL2dGQaahGkyNasPA3KwJYBujMePy+OtJ3qbfqk8mcADdXBBV6xL43YWbL0B1M7ZiBTcQvSyYed84oCU0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706424908; c=relaxed/simple;
	bh=VKaKRttL+jYdNTSm0AEVNuR8TUVRuMeynjujA9ebhws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h+wyK4nTGueQAZKz8fqbv2vhNPp6XisCbiPf8RfnG1NKUmFgR1f5/jdU9aEDYVR1XTgDwidk2JyfVjXR+eUOTqZqcqsBOTSDvp/q1mZd9liG6jWCoa/NL/KQ1eExVeMvZ+F2Xq25KepUf+NUvVzbSqZ6Yz91ZmkEsmy14XTo7ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/0TVe9B; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706424907; x=1737960907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VKaKRttL+jYdNTSm0AEVNuR8TUVRuMeynjujA9ebhws=;
  b=m/0TVe9BvUS5ATJ8sMtYfbrr+yUfvaHtLprv4YoXkEJjtZpGclxxwd7F
   02ifxNOP+2f10A77cBV+04kkm7/ekaEm0SlJyajQ4k18tLPfmzVSaLLxo
   VXFNF9v8Eirf9DSI7+QecAjILpzpuCNySyyWoCnSUrns+tD6hzSCbgWbw
   ntlm3H9iEWtttrTD9AEv6wFYZFzZg8qrNhoZYvZHG05864ec+2y3L0pn+
   16wSD23nMgZVDfJKnVrnfaIWV7c+jmwa9NscKyIm6w8DUW52pnEc5LNrE
   a1NbFuWZIzxU/WYnx5LObkm8fYV8EFcK01IIVzBbFIsWPYIH5nrmVcejO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="24217695"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="24217695"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:55:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="35833385"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:55:05 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/14] wifi: iwlwifi: implement GLAI ACPI table loading
Date: Sun, 28 Jan 2024 08:53:59 +0200
Message-Id: <20240128084842.53994809fbdd.I1bd10aafc387bc04f375e386861ee2bcb82f0a61@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128065400.2550604-1-miriam.rachel.korenblit@intel.com>
References: <20240128065400.2550604-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

All the regulatory tables from BIOS are going to be loaded
(preferably) from the UEFI instead of the ACPI.
There is a security issue with the fact that anyone can
add these UEFI variables.
The solution for that is to have a lock for all WIFI GUID UEFI
variables, and only if the UEFI variables are locked then we can
read it.
The status of the lock (unlocked, locked, test mode) is indicated
in a ACPI table: Guid Lock ACPI Indicator.
Load this table so the driver knows whether to read from UEFI or
not

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 35 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  | 13 ++++++-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  4 +++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  2 ++
 4 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 72a0a9565371..dd68d382d7de 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -1318,3 +1318,38 @@ void iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt,
 	kfree(data);
 }
 IWL_EXPORT_SYMBOL(iwl_acpi_get_phy_filters);
+
+void iwl_acpi_get_guid_lock_status(struct iwl_fw_runtime *fwrt)
+{
+	union acpi_object *wifi_pkg, *data;
+	int tbl_rev;
+
+	data = iwl_acpi_get_object(fwrt->dev, ACPI_GLAI_METHOD);
+	if (IS_ERR(data))
+		return;
+
+	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
+					 ACPI_GLAI_WIFI_DATA_SIZE,
+					 &tbl_rev);
+	if (IS_ERR(wifi_pkg))
+		goto out_free;
+
+	if (tbl_rev != 0) {
+		IWL_DEBUG_RADIO(fwrt, "Invalid GLAI revision: %d\n", tbl_rev);
+		goto out_free;
+	}
+
+	if (wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER ||
+	    wifi_pkg->package.elements[1].integer.value > ACPI_GLAI_MAX_STATUS)
+		goto out_free;
+
+	fwrt->uefi_tables_lock_status =
+		wifi_pkg->package.elements[1].integer.value;
+
+	IWL_DEBUG_RADIO(fwrt,
+			"Loaded UEFI WIFI GUID lock status: %d from ACPI\n",
+			fwrt->uefi_tables_lock_status);
+out_free:
+	kfree(data);
+}
+IWL_EXPORT_SYMBOL(iwl_acpi_get_guid_lock_status);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 39106ccb4b9b..7b3c6fca7591 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -25,6 +25,7 @@
 #define ACPI_PPAG_METHOD	"PPAG"
 #define ACPI_WTAS_METHOD	"WTAS"
 #define ACPI_WPFC_METHOD	"WPFC"
+#define ACPI_GLAI_METHOD	"GLAI"
 
 #define ACPI_WIFI_DOMAIN	(0x07)
 
@@ -66,7 +67,12 @@
 #define ACPI_WRDD_WIFI_DATA_SIZE	2
 #define ACPI_SPLC_WIFI_DATA_SIZE	2
 #define ACPI_ECKV_WIFI_DATA_SIZE	2
-
+/*
+ * One element for domain type,
+ * and one for the status
+ */
+#define ACPI_GLAI_WIFI_DATA_SIZE	2
+#define ACPI_GLAI_MAX_STATUS		2
 /*
  * TAS size: 1 elelment for type,
  *	     1 element for enabled field,
@@ -237,6 +243,8 @@ bool iwl_acpi_is_ppag_approved(struct iwl_fw_runtime *fwrt);
 void iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt,
 			      struct iwl_phy_specific_cfg *filters);
 
+void iwl_acpi_get_guid_lock_status(struct iwl_fw_runtime *fwrt);
+
 #else /* CONFIG_ACPI */
 
 static inline void *iwl_acpi_get_dsm_object(struct device *dev, int rev,
@@ -331,6 +339,9 @@ static inline void iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt,
 {
 }
 
+static inline void iwl_acpi_get_guid_lock_status(struct iwl_fw_runtime *fwrt)
+{
+}
 #endif /* CONFIG_ACPI */
 
 #endif /* __iwl_fw_acpi__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 357727774db9..1ec2bcdf92b8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -100,6 +100,9 @@ struct iwl_txf_iter_data {
  * @dump: debug dump data
  * @uats_enabled: VLP or AFC AP is enabled
  * @uats_table: AP type table
+ * @uefi_tables_lock_status: The status of the WIFI GUID UEFI variables lock:
+ *	0: Unlocked, 1 and 2: Locked.
+ *	Only read the UEFI variables if locked.
  */
 struct iwl_fw_runtime {
 	struct iwl_trans *trans;
@@ -175,6 +178,7 @@ struct iwl_fw_runtime {
 	u8 reduced_power_flags;
 	bool uats_enabled;
 	struct iwl_uats_table_cmd uats_table;
+	u8 uefi_tables_lock_status;
 #endif
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 175024170357..a6db290923cd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1402,6 +1402,8 @@ void iwl_mvm_get_acpi_tables(struct iwl_mvm *mvm)
 {
 	int ret;
 
+	iwl_acpi_get_guid_lock_status(&mvm->fwrt);
+
 	/* read PPAG table */
 	ret = iwl_acpi_get_ppag_table(&mvm->fwrt);
 	if (ret < 0) {
-- 
2.34.1


