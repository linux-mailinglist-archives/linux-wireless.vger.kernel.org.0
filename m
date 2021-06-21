Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04C23AE441
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jun 2021 09:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhFUHkG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Jun 2021 03:40:06 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48424 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229651AbhFUHkE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Jun 2021 03:40:04 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lvEV9-001aFa-Nt; Mon, 21 Jun 2021 10:37:49 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon, 21 Jun 2021 10:37:35 +0300
Message-Id: <iwlwifi.20210621103449.c705ac86f2e9.Ia7421c17fe52929e4098b4f0cf070809ed3ef906@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621073740.1105911-1-luca@coelho.fi>
References: <20210621073740.1105911-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 4/9] iwlwifi: move UEFI code to a separate file
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We are going to read more variables from UEFI, so it's cleaner to have
all the code that handles UEFI variables in a separate file.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Makefile  |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 105 +++++--------------
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c |  64 +++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h |  25 +++++
 4 files changed, 114 insertions(+), 81 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/uefi.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/uefi.h

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index c033caa0eaa9..12ce156c2e9d 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -19,6 +19,7 @@ iwlwifi-objs		+= fw/img.o fw/notif-wait.o
 iwlwifi-objs		+= fw/dbg.o fw/pnvm.o
 iwlwifi-$(CONFIG_IWLMVM) += fw/paging.o fw/smem.o fw/init.o
 iwlwifi-$(CONFIG_ACPI) += fw/acpi.o
+iwlwifi-$(CONFIG_EFI)	+= fw/uefi.o
 iwlwifi-$(CONFIG_IWLWIFI_DEBUGFS) += fw/debugfs.o
 
 iwlwifi-objs += $(iwlwifi-m)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 40f2109a097f..565c19475155 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -10,13 +10,22 @@
 #include "fw/api/commands.h"
 #include "fw/api/nvm-reg.h"
 #include "fw/api/alive.h"
-#include <linux/efi.h>
+#include "fw/uefi.h"
 
 struct iwl_pnvm_section {
 	__le32 offset;
 	const u8 data[];
 } __packed;
 
+struct pnvm_sku_package {
+	u8 rev;
+	u8 reserved1[3];
+	u32 total_size;
+	u8 n_skus;
+	u8 reserved2[11];
+	u8 data[];
+};
+
 static bool iwl_pnvm_complete_fn(struct iwl_notif_wait_data *notif_wait,
 				 struct iwl_rx_packet *pkt, void *data)
 {
@@ -220,83 +229,6 @@ static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
 	return -ENOENT;
 }
 
-#if defined(CONFIG_EFI)
-
-#define IWL_EFI_VAR_GUID EFI_GUID(0x92daaf2f, 0xc02b, 0x455b,	\
-				  0xb2, 0xec, 0xf5, 0xa3,	\
-				  0x59, 0x4f, 0x4a, 0xea)
-
-#define IWL_UEFI_OEM_PNVM_NAME	L"UefiCnvWlanOemSignedPnvm"
-
-#define IWL_HARDCODED_PNVM_SIZE 4096
-
-struct pnvm_sku_package {
-	u8 rev;
-	u8 reserved1[3];
-	u32 total_size;
-	u8 n_skus;
-	u8 reserved2[11];
-	u8 data[];
-};
-
-static int iwl_pnvm_get_from_efi(struct iwl_trans *trans,
-				 u8 **data, size_t *len)
-{
-	struct efivar_entry *pnvm_efivar;
-	struct pnvm_sku_package *package;
-	unsigned long package_size;
-	int err;
-
-	pnvm_efivar = kzalloc(sizeof(*pnvm_efivar), GFP_KERNEL);
-	if (!pnvm_efivar)
-		return -ENOMEM;
-
-	memcpy(&pnvm_efivar->var.VariableName, IWL_UEFI_OEM_PNVM_NAME,
-	       sizeof(IWL_UEFI_OEM_PNVM_NAME));
-	pnvm_efivar->var.VendorGuid = IWL_EFI_VAR_GUID;
-
-	/*
-	 * TODO: we hardcode a maximum length here, because reading
-	 * from the UEFI is not working.  To implement this properly,
-	 * we have to call efivar_entry_size().
-	 */
-	package_size = IWL_HARDCODED_PNVM_SIZE;
-
-	package = kmalloc(package_size, GFP_KERNEL);
-	if (!package) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	err = efivar_entry_get(pnvm_efivar, NULL, &package_size, package);
-	if (err) {
-		IWL_DEBUG_FW(trans,
-			     "PNVM UEFI variable not found %d (len %lu)\n",
-			     err, package_size);
-		goto out;
-	}
-
-	IWL_DEBUG_FW(trans, "Read PNVM fro UEFI with size %lu\n", package_size);
-
-	*data = kmemdup(package->data, *len, GFP_KERNEL);
-	if (!*data)
-		err = -ENOMEM;
-	*len = package_size - sizeof(*package);
-
-out:
-	kfree(package);
-	kfree(pnvm_efivar);
-
-	return err;
-}
-#else /* CONFIG_EFI */
-static inline int iwl_pnvm_get_from_efi(struct iwl_trans *trans,
-					u8 **data, size_t *len)
-{
-	return -EOPNOTSUPP;
-}
-#endif /* CONFIG_EFI */
-
 static int iwl_pnvm_get_from_fs(struct iwl_trans *trans, u8 **data, size_t *len)
 {
 	const struct firmware *pnvm;
@@ -335,6 +267,7 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 {
 	u8 *data;
 	size_t len;
+	struct pnvm_sku_package *package;
 	struct iwl_notification_wait pnvm_wait;
 	static const u16 ntf_cmds[] = { WIDE_ID(REGULATORY_AND_NVM_GROUP,
 						PNVM_INIT_COMPLETE_NTFY) };
@@ -356,9 +289,19 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 	}
 
 	/* First attempt to get the PNVM from BIOS */
-	ret = iwl_pnvm_get_from_efi(trans, &data, &len);
-	if (!ret)
-		goto parse;
+	package = iwl_uefi_get_pnvm(trans, &len);
+	if (!IS_ERR_OR_NULL(package)) {
+		data = kmemdup(package->data, len, GFP_KERNEL);
+
+		/* free package regardless of whether kmemdup succeeded */
+		kfree(package);
+
+		if (data) {
+			/* we need only the data size */
+			len -= sizeof(*package);
+			goto parse;
+		}
+	}
 
 	/* If it's not available, try from the filesystem */
 	ret = iwl_pnvm_get_from_fs(trans, &data, &len);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
new file mode 100644
index 000000000000..bdcdca178eda
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2021 Intel Corporation
+ */
+
+#include "iwl-drv.h"
+#include "pnvm.h"
+#include "iwl-prph.h"
+#include "iwl-io.h"
+
+#include "fw/uefi.h"
+#include <linux/efi.h>
+
+#define IWL_EFI_VAR_GUID EFI_GUID(0x92daaf2f, 0xc02b, 0x455b,	\
+				  0xb2, 0xec, 0xf5, 0xa3,	\
+				  0x59, 0x4f, 0x4a, 0xea)
+
+void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
+{
+	struct efivar_entry *pnvm_efivar;
+	void *data;
+	unsigned long package_size;
+	int err;
+
+	pnvm_efivar = kzalloc(sizeof(*pnvm_efivar), GFP_KERNEL);
+	if (!pnvm_efivar)
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(&pnvm_efivar->var.VariableName, IWL_UEFI_OEM_PNVM_NAME,
+	       sizeof(IWL_UEFI_OEM_PNVM_NAME));
+	pnvm_efivar->var.VendorGuid = IWL_EFI_VAR_GUID;
+
+	/*
+	 * TODO: we hardcode a maximum length here, because reading
+	 * from the UEFI is not working.  To implement this properly,
+	 * we have to call efivar_entry_size().
+	 */
+	package_size = IWL_HARDCODED_PNVM_SIZE;
+
+	data = kmalloc(package_size, GFP_KERNEL);
+	if (!data) {
+		data = ERR_PTR(-ENOMEM);
+		*len = 0;
+		goto out;
+	}
+
+	err = efivar_entry_get(pnvm_efivar, NULL, &package_size, data);
+	if (err) {
+		IWL_DEBUG_FW(trans,
+			     "PNVM UEFI variable not found %d (len %zd)\n",
+			     err, package_size);
+		kfree(data);
+		data = ERR_PTR(err);
+		goto out;
+	}
+
+	IWL_DEBUG_FW(trans, "Read PNVM from UEFI with size %zd\n", package_size);
+	*len = package_size;
+
+out:
+	kfree(pnvm_efivar);
+
+	return data;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
new file mode 100644
index 000000000000..48f1b54e3e76
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2021 Intel Corporation
+ */
+
+
+#define IWL_UEFI_OEM_PNVM_NAME	L"UefiCnvWlanOemSignedPnvm"
+
+/*
+ * TODO: we have these hardcoded values that the caller must pass,
+ * because reading from the UEFI is not working.  To implement this
+ * properly, we have to change iwl_pnvm_get_from_uefi() to call
+ * efivar_entry_size() and return the value to the caller instead.
+ */
+#define IWL_HARDCODED_PNVM_SIZE 4096
+
+#ifdef CONFIG_EFI
+void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len);
+#else /* CONFIG_EFI */
+static inline
+void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+#endif /* CONFIG_EFI */
-- 
2.32.0

