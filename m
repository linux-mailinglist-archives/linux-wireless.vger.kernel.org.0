Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C66B63C182
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 14:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbiK2NzV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 08:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbiK2NzT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 08:55:19 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D594FFA0
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 05:55:18 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso10859007wmp.5
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 05:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7XFjrA51EOVG7xzcUOwrfRaKSsrr6QiNlF29l1Lx7s=;
        b=gZ+V7uTMfpqKNgXqmLSN1N9cvAgxlBLj7b0mwiqw0DADPPnEfXqZxsYFp3Gp0zGBbf
         lJ5pZ5S73u9P3K3BENxVTgyvhKWve7xLT6U+rsff4qIIVjxFFjd9kKyVMZDLlZ3BmNfr
         gOxwJYJAxpy+IkbYqjazaGlOKvHUAt9b9BxCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7XFjrA51EOVG7xzcUOwrfRaKSsrr6QiNlF29l1Lx7s=;
        b=RNhCWKegDGBG7Y5GshVVHzXQli6ofHdIfb+NaPsuo0vu1XR7bEuNxBIp1Y54L4hr3i
         mV+fist4wpc3WVtnpVyGCl34W+8DlWGhnFazPE2W2WZVvM/mK0wQS9UXvqO7Gl8vvBb5
         VW9XL7in/Kuv3RI6a1AxF1uqD69UNY/BZSFT35vRgIgdE3olorJRoVV43J4iNH8sFdaP
         e5jFyvLrcPWWLTUqRbGRB3PwirGpcIpXnfLdBeaf6dt8cYXB5rQU3jri9x9A+XBIY2MO
         U5RR006lFEntAhlo5qDtLIr/e61uT47WIEyOfEGa2YRvU2V2Vji8k1LhGIYuxP7jpGvC
         TQKg==
X-Gm-Message-State: ANoB5pn/pwSfYriSX/iVtSjTp0Zaaa+Nv/JcJl32RPl3iRGEuKx7zGJg
        687cIQ5AXQmCrtityG04V3Cwrg==
X-Google-Smtp-Source: AA0mqf7AesrESv0rQo9J1lhr6BQr5S/KyvrYpUD2vMm1ijbh33DM0cwcPAFo+JkIdnvpjuwMWpwHjQ==
X-Received: by 2002:a05:600c:4f90:b0:3c1:aeb9:29b6 with SMTP id n16-20020a05600c4f9000b003c1aeb929b6mr27672032wmq.97.1669730116993;
        Tue, 29 Nov 2022 05:55:16 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.com ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id hn25-20020a05600ca39900b003b4935f04a4sm2472005wmb.5.2022.11.29.05.55.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2022 05:55:15 -0800 (PST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>
Subject: [PATCH V2 5/7] brcmfmac: add support Broadcom BCA firmware api
Date:   Tue, 29 Nov 2022 14:54:44 +0100
Message-Id: <20221129135446.151065-6-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221129135446.151065-1-arend.vanspriel@broadcom.com>
References: <20221129135446.151065-1-arend.vanspriel@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000082b8cb05ee9c564d"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--00000000000082b8cb05ee9c564d
Content-Transfer-Encoding: 8bit

Broadcom BCA division develops its own firmware api and as such will
likely diverge over time (or already has). Add support for handling
this.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../broadcom/brcm80211/brcmfmac/Makefile      |  2 +
 .../broadcom/brcm80211/brcmfmac/bca/Makefile  | 12 ++++
 .../broadcom/brcm80211/brcmfmac/bca/core.c    | 27 +++++++++
 .../broadcom/brcm80211/brcmfmac/bca/module.c  | 26 +++++++++
 .../broadcom/brcm80211/brcmfmac/bca/vops.h    | 11 ++++
 .../broadcom/brcm80211/brcmfmac/bus.h         |  1 +
 .../broadcom/brcm80211/brcmfmac/fwvid.c       |  2 +
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 58 +++++++++----------
 8 files changed, 110 insertions(+), 29 deletions(-)
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/Makefile
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/core.c
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/vops.h

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
index 64fd77a378fd..0e996cf24f88 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
@@ -52,7 +52,9 @@ brcmfmac-$(CONFIG_DMI) += \
 ifeq ($(CONFIG_BRCMFMAC),m)
 obj-m += wcc/
 obj-m += cyw/
+obj-m += bca/
 else
 brcmfmac-$(CONFIG_BRCMFMAC) += wcc/core.o
 brcmfmac-$(CONFIG_BRCMFMAC) += cyw/core.o
+brcmfmac-$(CONFIG_BRCMFMAC) += bca/core.o
 endif
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/Makefile b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/Makefile
new file mode 100644
index 000000000000..46098705e236
--- /dev/null
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: ISC
+#
+# Copyright (c) 2022 Broadcom Corporation
+
+ccflags-y += \
+	-I $(srctree)/$(src) \
+	-I $(srctree)/$(src)/.. \
+	-I $(srctree)/$(src)/../../include
+
+obj-m += brcmfmac-bca.o
+brcmfmac-bca-objs += \
+		core.o module.o
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/core.c
new file mode 100644
index 000000000000..ac3a36fa3640
--- /dev/null
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/core.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2022 Broadcom Corporation
+ */
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <core.h>
+#include <bus.h>
+#include <fwvid.h>
+
+#include "vops.h"
+
+static int brcmf_bca_attach(struct brcmf_pub *drvr)
+{
+	pr_err("%s: executing\n", __func__);
+	return 0;
+}
+
+static void brcmf_bca_detach(struct brcmf_pub *drvr)
+{
+	pr_err("%s: executing\n", __func__);
+}
+
+const struct brcmf_fwvid_ops brcmf_bca_ops = {
+	.attach = brcmf_bca_attach,
+	.detach = brcmf_bca_detach,
+};
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
new file mode 100644
index 000000000000..790116a735c7
--- /dev/null
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2022 Broadcom Corporation
+ */
+#include <linux/module.h>
+#include <bus.h>
+#include <core.h>
+#include <fwvid.h>
+
+#include "vops.h"
+
+static int __init brcmf_bca_init(void)
+{
+	return brcmf_fwvid_register_vendor(BRCMF_FWVENDOR_BCA, THIS_MODULE,
+					   &brcmf_bca_ops);
+}
+
+static void __exit brcmf_bca_exit(void)
+{
+	brcmf_fwvid_unregister_vendor(BRCMF_FWVENDOR_BCA, THIS_MODULE);
+}
+
+MODULE_LICENSE("Dual BSD/GPL");
+
+module_init(brcmf_bca_init);
+module_exit(brcmf_bca_exit);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/vops.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/vops.h
new file mode 100644
index 000000000000..7897e6b6eefb
--- /dev/null
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/vops.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2022 Broadcom Corporation
+ */
+#ifndef _BRCMFMAC_BCA_VOPS_H
+#define _BRCMFMAC_BCA_VOPS_H
+
+extern const struct brcmf_fwvid_ops brcmf_bca_ops;
+#define BCA_VOPS	(&brcmf_bca_ops)
+
+#endif /* _BRCMFMAC_BCA_VOPS_H */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
index 72036fec9a8e..501136e011b5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
@@ -34,6 +34,7 @@
 enum brcmf_fwvendor {
 	BRCMF_FWVENDOR_WCC,
 	BRCMF_FWVENDOR_CYW,
+	BRCMF_FWVENDOR_BCA,
 	/* keep last */
 	BRCMF_FWVENDOR_NUM,
 	BRCMF_FWVENDOR_INVALID
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
index ee23eb1809c4..274d512cbdad 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
@@ -20,6 +20,7 @@
 
 #include "wcc/vops.h"
 #include "cyw/vops.h"
+#include "bca/vops.h"
 
 struct brcmf_fwvid_entry {
 	const char *name;
@@ -52,6 +53,7 @@ static DEFINE_MUTEX(fwvid_list_lock);
 static struct brcmf_fwvid_entry fwvid_list[BRCMF_FWVENDOR_NUM] = {
 	FWVID_ENTRY_INIT(WCC, wcc),
 	FWVID_ENTRY_INIT(CYW, cyw),
+	FWVID_ENTRY_INIT(BCA, bca),
 };
 
 #if IS_MODULE(CONFIG_BRCMFMAC)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 094bb84ed72f..3e121e56e800 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -2571,47 +2571,47 @@ static const struct dev_pm_ops brcmf_pciedrvr_pm = {
 #endif /* CONFIG_PM */
 
 
-#define BRCMF_PCIE_DEVICE(dev_id) \
+#define BRCMF_PCIE_DEVICE(dev_id, fw_vend) \
 	{ \
 		BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
 		PCI_ANY_ID, PCI_ANY_ID, \
 		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
-		BRCMF_FWVENDOR_WCC \
+		BRCMF_FWVENDOR_ ## fw_vend \
 	}
-#define BRCMF_PCIE_DEVICE_SUB(dev_id, subvend, subdev) \
+#define BRCMF_PCIE_DEVICE_SUB(dev_id, subvend, subdev, fw_vend) \
 	{ \
 		BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
 		(subvend), (subdev), \
 		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
-		BRCMF_FWVENDOR_WCC \
+		BRCMF_FWVENDOR_ ## fw_vend \
 	}
 
 static const struct pci_device_id brcmf_pcie_devid_table[] = {
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4350_DEVICE_ID),
-	BRCMF_PCIE_DEVICE_SUB(0x4355, BRCM_PCIE_VENDOR_ID_BROADCOM, 0x4355),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4354_RAW_DEVICE_ID),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4356_DEVICE_ID),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_43567_DEVICE_ID),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_43570_DEVICE_ID),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_43570_RAW_DEVICE_ID),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4358_DEVICE_ID),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4359_DEVICE_ID),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_43602_DEVICE_ID),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_43602_2G_DEVICE_ID),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_43602_5G_DEVICE_ID),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_43602_RAW_DEVICE_ID),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4364_DEVICE_ID),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4365_DEVICE_ID),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4365_2G_DEVICE_ID),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4365_5G_DEVICE_ID),
-	BRCMF_PCIE_DEVICE_SUB(0x4365, BRCM_PCIE_VENDOR_ID_BROADCOM, 0x4365),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_DEVICE_ID),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_2G_DEVICE_ID),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_5G_DEVICE_ID),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4371_DEVICE_ID),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID),
-	BRCMF_PCIE_DEVICE(CY_PCIE_89459_DEVICE_ID),
-	BRCMF_PCIE_DEVICE(CY_PCIE_89459_RAW_DEVICE_ID),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4350_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE_SUB(0x4355, BRCM_PCIE_VENDOR_ID_BROADCOM, 0x4355, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4354_RAW_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4356_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_43567_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_43570_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_43570_RAW_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4358_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4359_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_43602_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_43602_2G_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_43602_5G_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_43602_RAW_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4364_DEVICE_ID, BCA),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4365_DEVICE_ID, BCA),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4365_2G_DEVICE_ID, BCA),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4365_5G_DEVICE_ID, BCA),
+	BRCMF_PCIE_DEVICE_SUB(0x4365, BRCM_PCIE_VENDOR_ID_BROADCOM, 0x4365, BCA),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_DEVICE_ID, BCA),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_2G_DEVICE_ID, BCA),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_5G_DEVICE_ID, BCA),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4371_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(CY_PCIE_89459_DEVICE_ID, CYW),
+	BRCMF_PCIE_DEVICE(CY_PCIE_89459_RAW_DEVICE_ID, CYW),
 	{ /* end: all zeroes */ }
 };
 
-- 
2.35.1


--00000000000082b8cb05ee9c564d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQdwYJKoZIhvcNAQcCoIIQaDCCEGQCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3OMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVYwggQ+oAMCAQICDE79bW6SMzVJMuOi1zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMTQzMjNaFw0yNTA5MTAxMTQzMjNaMIGV
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEFyZW5kIFZhbiBTcHJpZWwxKzApBgkqhkiG
9w0BCQEWHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQDxOB8Yu89pZLsG9Ic8ZY3uGibuv+NRsij+E70OMJQIwugrByyNq5xgH0BI22vJ
LT7VKCB6YJC88ewEFfYi3EKW/sn6RL16ImUM40beDmQ12WBquJRoxVNyoByNalmTOBNYR95ZQZJw
1nrzaoJtK0XIsv0dNCUcLlAc+jHkngD+I0ptVuWoMO1BcJexqJf5iX2M1CdC8PXTh9g4FIQnG2mc
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDGGBCDdRowGrJuV7Oc
cm/bUW6f42bM90fEkxp5msJnozAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMjExMjkxMzU1MTdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEACcGwcLst/Pt0P2g1sznCpljcOs/nebsnQIv/
/rw3psABn6rueJ6yCih9MQmOFr+tp9A37M7v6tkzlqaZlFzaRm39/YuWiyNkWQsImM7LIIY/wRYg
OPK0Lo+W3VaHVnlAktBzSBTfCZYxd5u6J22px3xep/rYrWuiwKbaQE19t6qGXZi8EYXiGVJy/oLe
q8r56WC20+TfChq15/DgCn7U6f7hCfPq8/GClU72J+kO84lqTfvP0CYdpoye6uQm2QpGx5UqsMcO
Ud4oSUchbOZ583cbM2dSwD8EPkVbNgSrPJbMsAGK5vNXTZsUWwAAocZ0fLUvOu0BV6eU527amG1C
2w==
--00000000000082b8cb05ee9c564d--
