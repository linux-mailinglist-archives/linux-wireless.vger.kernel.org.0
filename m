Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12478548329
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jun 2022 11:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240716AbiFMJTi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jun 2022 05:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240698AbiFMJTb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jun 2022 05:19:31 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD92418E09
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 02:19:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id g25so9906651ejh.9
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 02:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:in-reply-to:references:date:message-id:subject:to
         :cc;
        bh=DMDAVT8+jSFRKW4nLUODpSb57j4Ye9kohAIn+1/vORY=;
        b=Rdeca3GpJHuL9E6SeY1SsscXBPbmfdFEE0zHgjWvolWdH8jvQyXZ6bibiaIEu9ET3L
         8dixfWXrkndQLvYOXkq3o4J2BqvMK58UjaX1PrZxHMFVaqGlyhmlI6mE9kTFmEkvr6ER
         oZzvwTBO1uzzm10A9UmHJD23pYi031Ex0lh8XmbBMFezp9goB989EjmHdDZtxLPXCi9f
         EumNq1HqE+p5+TYLSw4pkvOh2kI6isUIevROMQvPl0NCfY4j4EY0swWxlx4PUZQpvG3p
         BolklddVoieWHt0aXhK9JOHhkz+gX3eWQtnG+nrjCwuSmKNJhGVcuN8wOedVufcFEOIQ
         V86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:in-reply-to:references:date
         :message-id:subject:to:cc;
        bh=DMDAVT8+jSFRKW4nLUODpSb57j4Ye9kohAIn+1/vORY=;
        b=SgUUmfBN2DXcD9k4qEE54aztr+C2SJDiexLKfsClsZUnN1EfNlZrdo5GQeidfazVxh
         uN2+hwYd7gzU+6HejRrq0aJCU02di7IraYc+waX4RT2sO3uLGK1JLKYAnL/fMjEFiBd9
         d/Fw+5QfIsHN4jlOp/ILtfnj7/0hNRHThf/brmpvxaHH12E9/aZcjIW0VgqMSVrQ9Hnk
         WXSUKlQ4rsr+zAN3fwfKdRYDQ0pW3i1nybMqUQOmvmk/I5M928teKcvoMi7tnIgTfLZu
         4t0USAURjX+JHxE515K+6v4AtTu2VkHJB9l35KqLecLaONgpCegD4Z8sWlrhk59xfLfb
         IRAQ==
X-Gm-Message-State: AOAM533ZIHKmgEUNfKGOkWpMtTUMOcvzjdBInWJl0a2j7gIheh2G+7VT
        jWYvrbIXyM3zgrRVWtuwlo6rclF/mwoo36iSEYo=
X-Google-Smtp-Source: ABdhPJxQx8fYGgnH78GRRoTaLEVs5OXnY3od6EJgAiLp2ElzXiR4PWfqr4qAuYsimHH8nJC9J//WsKg05LGBpVtwIGE=
MIME-Version: 1.0
X-Received: by 2002:a17:907:9704:b0:711:f441:dbe6 with SMTP id
 jg4-20020a170907970400b00711f441dbe6mr23579370ejc.26.1655111968495; Mon, 13
 Jun 2022 02:19:28 -0700 (PDT)
Received: from 35650733073 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 13 Jun 2022 05:19:28 -0400
From:   aspriel@gmail.com
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20220613091915.18884-1-arend.vanspriel@broadcom.com>
References: <20220613091915.18884-1-arend.vanspriel@broadcom.com>
Date:   Mon, 13 Jun 2022 05:19:28 -0400
Message-ID: <CAJ65rDwC3U1KSCR0G4s=11bkRAxp0b2Y8p0AFKP9BpgjQECEag@mail.gmail.com>
Subject: [PATCH 5/7] brcmfmac: add support Broadcom BCA firmware api
To:     Kalle Valo <kvalo@kernel.org>, arend.vanspriel@broadcom.com
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Broadcom BCA division develops its own firmware api and as such will
likely diverge over time. Add support for handling this.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../broadcom/brcm80211/brcmfmac/Kconfig       |  7 +++
 .../broadcom/brcm80211/brcmfmac/Makefile      |  2 +
 .../broadcom/brcm80211/brcmfmac/bca/Makefile  | 12 +++++
 .../broadcom/brcm80211/brcmfmac/bca/core.c    | 27 ++++++++++
 .../broadcom/brcm80211/brcmfmac/bca/module.c  | 26 ++++++++++
 .../broadcom/brcm80211/brcmfmac/bca/vops.h    | 15 ++++++
 .../broadcom/brcm80211/brcmfmac/bus.h         |  1 +
 .../broadcom/brcm80211/brcmfmac/fwvid.c       |  2 +
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 52 +++++++++----------
 9 files changed, 118 insertions(+), 26 deletions(-)
 create mode 100644
drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/Makefile
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/core.c
 create mode 100644
drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/vops.h

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
index 60b6e218306b..19c7d88766bb 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
@@ -31,6 +31,13 @@ config BRCMFMAC_VENDOR_CYW
           This option will allow the driver to communicate with devices
           shipped by Cypress.

+config BRCMFMAC_VENDOR_BCA
+	bool "Broadcom BCA"
+	depends on BRCMFMAC
+	help
+	  This option will allow the driver to communicate with devices
+	  shipped by Broadcom BCA division.
+
 config BRCMFMAC_PROTO_BCDC
 	bool

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
index 1c481477c28a..a403c5cde618 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
@@ -52,7 +52,9 @@ brcmfmac-$(CONFIG_DMI) += \
 ifeq ($(CONFIG_BRCMFMAC_VENDOR_MODULES),)
 brcmfmac-$(CONFIG_BRCMFMAC_VENDOR_WCC) += wcc/core.o
 brcmfmac-$(CONFIG_BRCMFMAC_VENDOR_CYW) += cyw/core.o
+brcmfmac-$(CONFIG_BRCMFMAC_VENDOR_BCA) += bca/core.o
 else
 obj-$(CONFIG_BRCMFMAC_VENDOR_WCC) += wcc/
 obj-$(CONFIG_BRCMFMAC_VENDOR_CYW) += cyw/
+obj-$(CONFIG_BRCMFMAC_VENDOR_BCA) += bca/
 endif
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/Makefile
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/Makefile
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
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/core.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/core.c
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
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
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
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/vops.h
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/vops.h
new file mode 100644
index 000000000000..1df4c5f9b4f6
--- /dev/null
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/vops.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2022 Broadcom Corporation
+ */
+#ifndef _BRCMFMAC_BCA_VOPS_H
+#define _BRCMFMAC_BCA_VOPS_H
+
+#ifdef CONFIG_BRCMFMAC_VENDOR_BCA
+extern const struct brcmf_fwvid_ops brcmf_bca_ops;
+#define BCA_VOPS	(&brcmf_bca_ops)
+#else
+#define BCA_VOPS	(NULL)
+#endif /* CONFIG_BRCMFMAC_VENDOR_BCA */
+
+#endif /* _BRCMFMAC_BCA_VOPS_H */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
index e114c65a75d7..c4a6dd2ec617 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
@@ -26,6 +26,7 @@
 enum brcmf_fwvendor {
 	BRCMF_FWVENDOR_WCC,
 	BRCMF_FWVENDOR_CYW,
+	BRCMF_FWVENDOR_BCA,
 	/* keep last */
 	BRCMF_FWVENDOR_NUM,
 	BRCMF_FWVENDOR_INVALID
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
index e6b8bbb99c88..919c60172e08 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
@@ -20,6 +20,7 @@

 #include "wcc/vops.h"
 #include "cyw/vops.h"
+#include "bca/vops.h"

 struct brcmf_fwvid_entry {
 	bool enabled;
@@ -55,6 +56,7 @@ static DEFINE_MUTEX(fwvid_list_lock);
 static struct brcmf_fwvid_entry fwvid_list[BRCMF_FWVENDOR_NUM] = {
 	FWVID_ENTRY_INIT(WCC, wcc),
 	FWVID_ENTRY_INIT(CYW, cyw),
+	FWVID_ENTRY_INIT(BCA, bca),
 };

 #ifdef CONFIG_BRCMFMAC_VENDOR_MODULES
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 0599dad96018..68fd191aaae1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -2077,44 +2077,44 @@ static const struct dev_pm_ops brcmf_pciedrvr_pm = {
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
 	{ /* end: all zeroes */ }
 };

-- 
2.32.0
