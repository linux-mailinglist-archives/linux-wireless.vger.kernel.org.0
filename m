Return-Path: <linux-wireless+bounces-19012-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B092A373A1
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03BA51891BFD
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F2E18FC84;
	Sun, 16 Feb 2025 09:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HpOHKfKz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541D618DB18
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699071; cv=none; b=uPE5fSOUYhr/nzVRTnPXgaF2Himqx9sNt7u0EgyjjoKQ6mk/+alhsYB+6ErWtVRUq8LvURJGqVsv3HYnh/OwFKHwp+N1WxKbSplpYpFIE1MB9LJ8uYx7UcuV6ZnZhgGrPWozD4PguBqWPbajE+zNA3+paDQCQYo2nqgFBpkkxXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699071; c=relaxed/simple;
	bh=Sc0k4+bvQeNwmmYdEkyUF/Dwy4TvN6Zg9uYl6eA8iW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=knNuX/VK+GzlJWE3qnIobP5HVLdAyBKpEP6osIMyx36LIKtcjoixY/IhlYjDZcPEA6uOYGKAhcrkfTFNPcyDsW+0/MbmeUVcDixTM2YrOMzow/eIz4+XqPHcvL8uUC5sdcn3CFIqW1B5F2eVibWoYrkXxHROJ3r3p2f5uK2O1c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HpOHKfKz; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699069; x=1771235069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sc0k4+bvQeNwmmYdEkyUF/Dwy4TvN6Zg9uYl6eA8iW4=;
  b=HpOHKfKz1J4mLXoLBbYwqJ4Kv31qeGW0dr4sx9occy3OSfqhyL56YgkA
   8OLfuLt2rbXL5jYfpwsvDrwBrAkNTQXP5uf27DbBdv1jNFcXMlqXP4lXI
   sLHITU6U+mYzdE+JoNFGE2ITPrN6rm2eVG2D+TyWsUJRH5yyVURm/F2SL
   Sw5pB4YZGkRB5cybL078MUpXWxKWT4pmLvL+o6nmv33WGXNBqIJcDRBJa
   qMo2OsH5pnNSQnA6XrILIdjvd2xzpfCzBZorZgrOMbQA5y1ZElFMLverR
   +WYvI7gwntDSMHf9JIxk4Mdm/xua0N8hJFcyaNiE6WMwdmFhxeYc1fZmj
   Q==;
X-CSE-ConnectionGUID: zU/9KaWVSSKhreIfSoLV3g==
X-CSE-MsgGUID: UdZ2YiqHQsa/mD1dYWAcAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323443"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323443"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:29 -0800
X-CSE-ConnectionGUID: n3VsqqGGShOPmWecNC7A3Q==
X-CSE-MsgGUID: stFTZcdYTTu5gQNyY4eMCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785321"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:28 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 42/42] wifi: iwlwifi: mld: enable the new operation mode
Date: Sun, 16 Feb 2025 11:43:21 +0200
Message-Id: <20250216111649.980c4a14b7ca.Ib58a6d779cb85a52868f7dfb5f28221f35e5aedf@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
References: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Enable the new operation mode:
Add the modules Makefile,
Load this opertation mode automatically for the relevant HW and FW.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Kconfig    | 16 +++++++++--
 drivers/net/wireless/intel/iwlwifi/Makefile   |  5 +++-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  5 ++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  6 +++-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 28 +++++++++++++++++--
 .../net/wireless/intel/iwlwifi/mld/Makefile   | 16 +++++++++++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  9 ++++--
 7 files changed, 75 insertions(+), 10 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/Makefile

diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
index 4b04865fc2c9..5eead5a143a1 100644
--- a/drivers/net/wireless/intel/iwlwifi/Kconfig
+++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
@@ -81,14 +81,26 @@ config IWLMVM
 	  of the devices that use this firmware is available here:
 	  https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi#firmware
 
+config IWLMLD
+	tristate "Intel Wireless WiFi MLD Firmware support"
+	depends on m
+	select BPAUTO_WANT_DEV_COREDUMP
+	depends on MAC80211
+	depends on PTP_1588_CLOCK_OPTIONAL
+	help
+	  This is the driver that supports firmwares of MLD capable devices.
+	  The list of the devices that use this firmware is available here:
+	  https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi#firmware
+
 # don't call it _MODULE -- will confuse Kconfig/fixdep/...
 config IWLWIFI_OPMODE_MODULAR
 	bool
 	default y if IWLDVM=m
 	default y if IWLMVM=m
+	default y if IWLMLD=m
 
-comment "WARNING: iwlwifi is useless without IWLDVM or IWLMVM"
-	depends on IWLDVM=n && IWLMVM=n
+comment "WARNING: iwlwifi is useless without IWLDVM or IWLMVM or IWLMLD"
+	depends on IWLDVM=n && IWLMVM=n && IWLMLD=n
 
 menu "Debugging Options"
 
diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index 19c4ce6f2465..9546ceeaf5e3 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -12,7 +12,8 @@ iwlwifi-objs		+= pcie/ctxt-info.o pcie/ctxt-info-gen3.o
 iwlwifi-objs		+= pcie/trans-gen2.o pcie/tx-gen2.o
 iwlwifi-$(CONFIG_IWLDVM) += cfg/1000.o cfg/2000.o cfg/5000.o cfg/6000.o
 iwlwifi-$(CONFIG_IWLMVM) += cfg/7000.o cfg/8000.o cfg/9000.o cfg/22000.o
-iwlwifi-$(CONFIG_IWLMVM) += cfg/ax210.o cfg/bz.o cfg/sc.o cfg/dr.o
+iwlwifi-$(CONFIG_IWLMVM) += cfg/ax210.o
+iwlwifi-$(CONFIG_IWLMLD) += cfg/bz.o cfg/sc.o cfg/dr.o
 iwlwifi-objs		+= iwl-dbg-tlv.o
 iwlwifi-objs		+= iwl-trans.o
 
@@ -20,6 +21,7 @@ iwlwifi-objs		+= fw/img.o fw/notif-wait.o fw/rs.o
 iwlwifi-objs		+= fw/dbg.o fw/pnvm.o fw/dump.o
 iwlwifi-objs		+= fw/regulatory.o
 iwlwifi-$(CONFIG_IWLMVM) += fw/paging.o fw/smem.o fw/init.o
+iwlwifi-$(CONFIG_IWLMLD) += fw/smem.o fw/init.o
 iwlwifi-$(CONFIG_ACPI) += fw/acpi.o
 iwlwifi-$(CONFIG_EFI)	+= fw/uefi.o
 iwlwifi-$(CONFIG_IWLWIFI_DEBUGFS) += fw/debugfs.o
@@ -33,6 +35,7 @@ ccflags-y += -I$(src)
 obj-$(CONFIG_IWLDVM)	+= dvm/
 obj-$(CONFIG_IWLMVM)	+= mvm/
 obj-$(CONFIG_IWLMEI)	+= mei/
+obj-$(CONFIG_IWLMLD)	+= mld/
 
 obj-$(CONFIG_IWLWIFI_KUNIT_TESTS) += tests/
 
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 64a5bbb45c83..36e8e3a991dc 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -38,6 +38,11 @@
 #define IWL_BZ_A_HR_B_MODULE_FIRMWARE(api) \
 	IWL_BZ_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 
+#if !IS_ENABLED(CONFIG_IWLMVM)
+const char iwl_ax211_name[] = "Intel(R) Wi-Fi 6E AX211 160MHz";
+const char iwl_ax201_name[] = "Intel(R) Wi-Fi 6 AX201 160MHz";
+#endif
+
 static const struct iwl_base_params iwl_bz_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
 	.num_of_queues = 512,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 5fc9ce2b350e..7e4864c00780 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -653,6 +653,10 @@ extern const struct iwl_cfg iwl_cfg_ma;
 
 extern const struct iwl_cfg iwl_cfg_so_a0_hr_a0;
 extern const struct iwl_cfg iwl_cfg_quz_a0_hr_b0;
+#endif /* CONFIG_IWLMVM */
+
+#if IS_ENABLED(CONFIG_IWLMLD)
+extern const struct iwl_ht_params iwl_bz_ht_params;
 
 extern const struct iwl_ht_params iwl_bz_ht_params;
 
@@ -664,6 +668,6 @@ extern const struct iwl_cfg iwl_cfg_sc2;
 extern const struct iwl_cfg iwl_cfg_sc2f;
 extern const struct iwl_cfg iwl_cfg_dr;
 extern const struct iwl_cfg iwl_cfg_br;
-#endif /* CONFIG_IWLMVM */
+#endif /* CONFIG_IWLMLD */
 
 #endif /* __IWL_CONFIG_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index d3a65f33097c..7606780c59de 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -75,6 +75,9 @@ struct iwl_drv {
 enum {
 	DVM_OP_MODE,
 	MVM_OP_MODE,
+#if IS_ENABLED(CONFIG_IWLMLD)
+	MLD_OP_MODE,
+#endif
 };
 
 /* Protects the table contents, i.e. the ops pointer & drv list */
@@ -86,6 +89,9 @@ static struct iwlwifi_opmode_table {
 } iwlwifi_opmode_table[] = {		/* ops set when driver is initialized */
 	[DVM_OP_MODE] = { .name = "iwldvm", .ops = NULL },
 	[MVM_OP_MODE] = { .name = "iwlmvm", .ops = NULL },
+#if IS_ENABLED(CONFIG_IWLMLD)
+	[MLD_OP_MODE] = { .name = "iwlmld", .ops = NULL },
+#endif
 };
 
 #define IWL_DEFAULT_SCAN_CHANNELS 40
@@ -316,6 +322,7 @@ struct iwl_firmware_pieces {
 	size_t dbg_trigger_tlv_len[FW_DBG_TRIGGER_MAX];
 	struct iwl_fw_dbg_mem_seg_tlv *dbg_mem_tlv;
 	size_t n_mem_tlv;
+	u32 major;
 };
 
 static void alloc_sec_data(struct iwl_firmware_pieces *pieces,
@@ -957,19 +964,19 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 			break;
 		case IWL_UCODE_TLV_FW_VERSION: {
 			const __le32 *ptr = (const void *)tlv_data;
-			u32 major, minor;
+			u32 minor;
 			u8 local_comp;
 
 			if (tlv_len != sizeof(u32) * 3)
 				goto invalid_tlv_len;
 
-			major = le32_to_cpup(ptr++);
+			pieces->major = le32_to_cpup(ptr++);
 			minor = le32_to_cpup(ptr++);
 			local_comp = le32_to_cpup(ptr);
 
 			snprintf(drv->fw.fw_version,
 				 sizeof(drv->fw.fw_version),
-				 "%u.%08x.%u %s", major, minor,
+				 "%u.%08x.%u %s", pieces->major, minor,
 				 local_comp, iwl_reduced_fw_name(drv));
 			break;
 			}
@@ -1468,6 +1475,8 @@ static void _iwl_op_mode_stop(struct iwl_drv *drv)
 	}
 }
 
+#define IWL_MLD_SUPPORTED_FW_VERSION 97
+
 /*
  * iwl_req_fw_callback - callback when firmware was loaded
  *
@@ -1720,6 +1729,19 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 		break;
 	}
 
+#if IS_ENABLED(CONFIG_IWLMLD)
+	if (pieces->major >= IWL_MLD_SUPPORTED_FW_VERSION)
+		op = &iwlwifi_opmode_table[MLD_OP_MODE];
+	else
+#else
+	if (pieces->major >= IWL_MLD_SUPPORTED_FW_VERSION) {
+		IWL_ERR(drv,
+			"IWLMLD needs to be compiled to support this firmware\n");
+		mutex_unlock(&iwlwifi_opmode_table_mtx);
+		goto out_unbind;
+	}
+#endif
+
 	IWL_INFO(drv, "loaded firmware version %s op_mode %s\n",
 		 drv->fw.fw_version, op->name);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/Makefile b/drivers/net/wireless/intel/iwlwifi/mld/Makefile
new file mode 100644
index 000000000000..ece66e7a9be4
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+obj-$(CONFIG_IWLMLD)   += iwlmld.o
+obj-$(CONFIG_IWLWIFI_KUNIT_TESTS) += tests/
+
+iwlmld-y += mld.o notif.o mac80211.o fw.o power.o iface.o link.o rx.o mcc.o session-protect.o phy.o
+iwlmld-y += scan.o sta.o tx.o coex.o tlc.o agg.o key.o regulatory.o ap.o thermal.o roc.o stats.o
+iwlmld-y += low_latency.o mlo.o ptp.o time_sync.o ftm-initiator.o
+iwlmld-$(CONFIG_IWLWIFI_DEBUGFS) += debugfs.o
+iwlmld-$(CONFIG_IWLWIFI_LEDS) += led.o
+iwlmld-$(CONFIG_PM_SLEEP) += d3.o
+
+# non-upstream things
+iwlmld-$(CONFIG_IWL_VENDOR_CMDS) += vendor-cmd.o
+iwlmld-$(CONFIG_IWLMVM_AX_SOFTAP_TESTMODE) += ax-softap-testmode.o
+
+subdir-ccflags-y += -I$(src)/../
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index cd347cd8176a..03f7eb46bbc7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -498,7 +498,8 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct pci_device_id iwl_hw_card_ids[] = {
 /* Ma devices */
 	{IWL_PCI_DEVICE(0x2729, PCI_ANY_ID, iwl_ma_trans_cfg)},
 	{IWL_PCI_DEVICE(0x7E40, PCI_ANY_ID, iwl_ma_trans_cfg)},
-
+#endif /* CONFIG_IWLMVM */
+#if IS_ENABLED(CONFIG_IWLMLD)
 /* Bz devices */
 	{IWL_PCI_DEVICE(0x272b, PCI_ANY_ID, iwl_gl_trans_cfg)},
 	{IWL_PCI_DEVICE(0xA840, 0x0000, iwl_bz_trans_cfg)},
@@ -543,7 +544,7 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct pci_device_id iwl_hw_card_ids[] = {
 
 /* Dr devices */
 	{IWL_PCI_DEVICE(0x272F, PCI_ANY_ID, iwl_dr_trans_cfg)},
-#endif /* CONFIG_IWLMVM */
+#endif /* CONFIG_IWLMLD */
 
 	{0}
 };
@@ -1109,6 +1110,8 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9462_name),
 
+#endif /* CONFIG_IWLMVM */
+#if IS_ENABLED(CONFIG_IWLMLD)
 /* Bz */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
@@ -1230,7 +1233,7 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_br, iwl_br_name),
-#endif /* CONFIG_IWLMVM */
+#endif /* CONFIG_IWLMLD */
 };
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_dev_info_table);
 
-- 
2.34.1


