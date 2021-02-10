Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90883174C0
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Feb 2021 00:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbhBJXvg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 18:51:36 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45464 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234118AbhBJXvc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 18:51:32 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9zFq-004ACH-Me; Thu, 11 Feb 2021 01:50:43 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 11 Feb 2021 01:50:41 +0200
Message-Id: <iwlwifi.20210211015026.289084803334.Ie234805047df3be84f4235f9dafaf4cdecf0db9a@changeid>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2] iwlwifi: pnvm: implement reading PNVM from UEFI
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We now support fetching the PNVM data from a UEFI variable.  Add the
code to read this variable first and use it.  If it's not available,
we fall back to reading the data from the filesystem, as before.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 91 +++++++++++++++++++-
 1 file changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index d515af8c1686..2cd07d2690e0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -10,6 +10,7 @@
 #include "fw/api/commands.h"
 #include "fw/api/nvm-reg.h"
 #include "fw/api/alive.h"
+#include <linux/efi.h>
 
 struct iwl_pnvm_section {
 	__le32 offset;
@@ -219,6 +220,88 @@ static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
 	return -ENOENT;
 }
 
+/*
+ * This is known to be broken on v4.19 and to work on v5.4.  Until we
+ * figure out why this is the case and how to make it work, simply
+ * disable the feature in old kernels.
+ */
+#if defined(CONFIG_EFI)
+
+#define IWL_EFI_VAR_GUID EFI_GUID(0x92daaf2f, 0xc02b, 0x455b,	\
+				  0xb2, 0xec, 0xf5, 0xa3,	\
+				  0x59, 0x4f, 0x4a, 0xea)
+
+#define IWL_UEFI_OEM_PNVM_NAME	L"UefiCnvWlanOemSignedPnvm"
+
+#define IWL_HARDCODED_PNVM_SIZE 4096
+
+struct pnvm_sku_package {
+	u8 rev;
+	u8 reserved1[3];
+	u32 total_size;
+	u8 n_skus;
+	u8 reserved2[11];
+	u8 data[];
+};
+
+static int iwl_pnvm_get_from_efi(struct iwl_trans *trans,
+				 u8 **data, size_t *len)
+{
+	struct efivar_entry *pnvm_efivar;
+	struct pnvm_sku_package *package;
+	unsigned long package_size;
+	int err;
+
+	pnvm_efivar = kzalloc(sizeof(*pnvm_efivar), GFP_KERNEL);
+	if (!pnvm_efivar)
+		return -ENOMEM;
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
+	package = kmalloc(package_size, GFP_KERNEL);
+	if (!package) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = efivar_entry_get(pnvm_efivar, NULL, &package_size, package);
+	if (err) {
+		IWL_DEBUG_FW(trans,
+			     "PNVM UEFI variable not found %d (len %zd)\n",
+			     err, package_size);
+		goto out;
+	}
+
+	IWL_DEBUG_FW(trans, "Read PNVM fro UEFI with size %zd\n", package_size);
+
+	*data = kmemdup(package->data, *len, GFP_KERNEL);
+	if (!*data)
+		err = -ENOMEM;
+	*len = package_size - sizeof(*package);
+
+out:
+	kfree(package);
+	kfree(pnvm_efivar);
+
+	return err;
+}
+#else /* CONFIG_EFI */
+static inline int iwl_pnvm_get_from_efi(struct iwl_trans *trans,
+					u8 **data, size_t *len)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_EFI */
+
 static int iwl_pnvm_get_from_fs(struct iwl_trans *trans, u8 **data, size_t *len)
 {
 	const struct firmware *pnvm;
@@ -277,7 +360,12 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 		goto skip_parse;
 	}
 
-	/* Try to load the PNVM from the filesystem */
+	/* First attempt to get the PNVM from BIOS */
+	ret = iwl_pnvm_get_from_efi(trans, &data, &len);
+	if (!ret)
+		goto parse;
+
+	/* If it's not available, try from the filesystem */
 	ret = iwl_pnvm_get_from_fs(trans, &data, &len);
 	if (ret) {
 		/*
@@ -290,6 +378,7 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 		goto skip_parse;
 	}
 
+parse:
 	iwl_pnvm_parse(trans, data, len);
 
 	kfree(data);
-- 
2.30.0

