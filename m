Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73FB548324
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jun 2022 11:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240729AbiFMJTh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jun 2022 05:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240687AbiFMJTa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jun 2022 05:19:30 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10654167D0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 02:19:29 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b8so6209269edj.11
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 02:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:in-reply-to:references:date:message-id:subject:to
         :cc;
        bh=AoyhwOdBuFeoX2d5q11RC9zfYPFePR0tB/zW7SrbQXE=;
        b=BgzL+qeXUyX+K/8rT0nEdeK4dcEfs4b0lZM0CFimwMjkXPzGfJniqFidh29EeNjv9P
         HuTG3uH1KTrzTvO6S0BU/77jC0ZlucnfcRPr2jlBrKL4X3qIvPPqUdKeipEUbkmiR+0p
         pm+x8c/XSO0mH7vz0ld8di6oxQnkdvqJnvOhLgSGEbGXp95HgH9GCo7PfVVMy4D8hX9j
         LySROsEXHcb7uZsm83clqui+RmPot2y5Po7meQ/ANm/CCr24IfYfpEa+aHYTa7XAUOz6
         2lpMYkOuRuMzsABUM9Abnc/y3yE6tkBIY9WJgXPgv/ueF8KYvx259Jt0/be6kQeME8Cj
         LXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:in-reply-to:references:date
         :message-id:subject:to:cc;
        bh=AoyhwOdBuFeoX2d5q11RC9zfYPFePR0tB/zW7SrbQXE=;
        b=pEdEsEUk2Bwb79VhVKt70J+j1SE2Ii1cMvrL4uqwPF+zg7DtxT5XxOOgD15f3nsAOy
         RU4EcPiqiMXxhEvLFN9y+8NqFs+MAJNKte/nlXHKLsn82v31dC9VQqIX7qYyWlgaQFwP
         4+98c8LVt9kAMUX9Gwqs5VNHJ14LWE603Gk7+Q/FoNKaAtEKCGCmByYtL9Qe5ISPO2Bm
         PfC+oDx9R2YgGPsSu3d0g2ClEtzvegytR8a5G+Vpi8/YJJhadFJlgeJLCVsanljSxEs7
         PvLSXIXR2JG2y0YaWoXZ6L5g92lB+vd3P0Z5BTgf4gb1m6ezIAp+kc2qw1JtvcImNehX
         sbsA==
X-Gm-Message-State: AOAM532xLq6EZCVDSP/U0WGnd4d5z4OBiyo5fAVlbB+GPj2g9SgGqEeG
        j3zWpRN1gm11bU7924yONNdKOanV5vQPkg2dB1PnbDWpolA=
X-Google-Smtp-Source: ABdhPJwDWvGlI9p8IRmDTXgKJQ2TOgVG3UnfuP0fdfmvQGmGkcYVwtERuoKNSi7EDuX/P8DwQToyNOomahS9mK/Yvt0=
MIME-Version: 1.0
X-Received: by 2002:aa7:d989:0:b0:431:75d5:f204 with SMTP id
 u9-20020aa7d989000000b0043175d5f204mr37709138eds.230.1655111967490; Mon, 13
 Jun 2022 02:19:27 -0700 (PDT)
Received: from 35650733073 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 13 Jun 2022 05:19:26 -0400
From:   aspriel@gmail.com
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20220613091915.18884-1-arend.vanspriel@broadcom.com>
References: <20220613091915.18884-1-arend.vanspriel@broadcom.com>
Date:   Mon, 13 Jun 2022 05:19:26 -0400
Message-ID: <CAJ65rDwp=rR2noaUXMXd5cw9TVzFepmy8MGCyZDv4Keu3Dsz9A@mail.gmail.com>
Subject: [PATCH 4/7] brcmfmac: add support for Cypress firmware api
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

Cypress uses the brcmfmac driver and releases firmware which will
likely diverge over time. So adding support for handling that.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../broadcom/brcm80211/brcmfmac/Kconfig       |  7 +++
 .../broadcom/brcm80211/brcmfmac/Makefile      |  2 +
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      | 46 +++++++++----------
 .../broadcom/brcm80211/brcmfmac/bus.h         |  1 +
 .../broadcom/brcm80211/brcmfmac/cyw/Makefile  | 12 +++++
 .../broadcom/brcm80211/brcmfmac/cyw/core.c    | 27 +++++++++++
 .../broadcom/brcm80211/brcmfmac/cyw/module.c  | 26 +++++++++++
 .../broadcom/brcm80211/brcmfmac/cyw/vops.h    | 15 ++++++
 .../broadcom/brcm80211/brcmfmac/fwvid.c       |  2 +
 9 files changed, 115 insertions(+), 23 deletions(-)
 create mode 100644
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/Makefile
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
 create mode 100644
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/vops.h

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
index 32c2f6e42a3e..60b6e218306b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
@@ -24,6 +24,13 @@ config BRCMFMAC_VENDOR_WCC
           This option will allow the driver to communicate with devices
           shipped by Broadcom WCC division.

+config BRCMFMAC_VENDOR_CYW
+	bool "Cypress Wireless"
+	depends on BRCMFMAC
+	help
+          This option will allow the driver to communicate with devices
+          shipped by Cypress.
+
 config BRCMFMAC_PROTO_BCDC
 	bool

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
index 08dbafdb6527..1c481477c28a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
@@ -51,6 +51,8 @@ brcmfmac-$(CONFIG_DMI) += \

 ifeq ($(CONFIG_BRCMFMAC_VENDOR_MODULES),)
 brcmfmac-$(CONFIG_BRCMFMAC_VENDOR_WCC) += wcc/core.o
+brcmfmac-$(CONFIG_BRCMFMAC_VENDOR_CYW) += cyw/core.o
 else
 obj-$(CONFIG_BRCMFMAC_VENDOR_WCC) += wcc/
+obj-$(CONFIG_BRCMFMAC_VENDOR_CYW) += cyw/
 endif
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 5ec56567dab6..16e49291ffcc 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -967,35 +967,35 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 	return ret;
 }

-#define BRCMF_SDIO_DEVICE(dev_id)	\
+#define BRCMF_SDIO_DEVICE(dev_id, fw_vend) \
 	{ \
 		SDIO_DEVICE(SDIO_VENDOR_ID_BROADCOM, dev_id), \
-		.driver_data = BRCMF_FWVENDOR_WCC \
+		.driver_data = BRCMF_FWVENDOR_ ## fw_vend \
 	}

 /* devices we support, null terminated */
 static const struct sdio_device_id brcmf_sdmmc_ids[] = {
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43143),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43241),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4329),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4330),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4334),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43340),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43341),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43362),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43364),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4335_4339),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4339),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43430),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4345),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43455),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4354),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4356),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4359),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43012),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_89359),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43143, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43241, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4329, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4330, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4334, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43340, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43341, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43362, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43364, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4335_4339, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4339, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43430, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4345, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43455, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4354, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4356, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4359, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373, CYW),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43012, CYW),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752, CYW),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_89359, CYW),
 	{ /* end: all zeroes */ }
 };
 MODULE_DEVICE_TABLE(sdio, brcmf_sdmmc_ids);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
index a2759171fcc9..e114c65a75d7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
@@ -25,6 +25,7 @@

 enum brcmf_fwvendor {
 	BRCMF_FWVENDOR_WCC,
+	BRCMF_FWVENDOR_CYW,
 	/* keep last */
 	BRCMF_FWVENDOR_NUM,
 	BRCMF_FWVENDOR_INVALID
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/Makefile
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/Makefile
new file mode 100644
index 000000000000..5e1fddaff79e
--- /dev/null
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/Makefile
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
+obj-m += brcmfmac-cyw.o
+brcmfmac-cyw-objs += \
+		core.o module.o
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
new file mode 100644
index 000000000000..b75652ba9359
--- /dev/null
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
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
+static int brcmf_cyw_attach(struct brcmf_pub *drvr)
+{
+	pr_err("%s: executing\n", __func__);
+	return 0;
+}
+
+static void brcmf_cyw_detach(struct brcmf_pub *drvr)
+{
+	pr_err("%s: executing\n", __func__);
+}
+
+const struct brcmf_fwvid_ops brcmf_cyw_ops = {
+	.attach = brcmf_cyw_attach,
+	.detach = brcmf_cyw_detach,
+};
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
new file mode 100644
index 000000000000..34294724a1f8
--- /dev/null
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
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
+static int __init brcmf_cyw_init(void)
+{
+	return brcmf_fwvid_register_vendor(BRCMF_FWVENDOR_CYW, THIS_MODULE,
+					   &brcmf_cyw_ops);
+}
+
+static void __exit brcmf_cyw_exit(void)
+{
+	brcmf_fwvid_unregister_vendor(BRCMF_FWVENDOR_CYW, THIS_MODULE);
+}
+
+MODULE_LICENSE("Dual BSD/GPL");
+
+module_init(brcmf_cyw_init);
+module_exit(brcmf_cyw_exit);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/vops.h
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/vops.h
new file mode 100644
index 000000000000..cc158b24f782
--- /dev/null
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/vops.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2022 Broadcom Corporation
+ */
+#ifndef _BRCMFMAC_CYW_VOPS_H
+#define _BRCMFMAC_CYW_VOPS_H
+
+#ifdef CONFIG_BRCMFMAC_VENDOR_CYW
+extern const struct brcmf_fwvid_ops brcmf_cyw_ops;
+#define CYW_VOPS	(&brcmf_cyw_ops)
+#else
+#define CYW_VOPS	(NULL)
+#endif /* CONFIG_BRCMFMAC_VENDOR_CYW */
+
+#endif /* _BRCMFMAC_CYW_VOPS_H */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
index 654a31caa643..e6b8bbb99c88 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
@@ -19,6 +19,7 @@
 #include "fwvid.h"

 #include "wcc/vops.h"
+#include "cyw/vops.h"

 struct brcmf_fwvid_entry {
 	bool enabled;
@@ -53,6 +54,7 @@ static DEFINE_MUTEX(fwvid_list_lock);

 static struct brcmf_fwvid_entry fwvid_list[BRCMF_FWVENDOR_NUM] = {
 	FWVID_ENTRY_INIT(WCC, wcc),
+	FWVID_ENTRY_INIT(CYW, cyw),
 };

 #ifdef CONFIG_BRCMFMAC_VENDOR_MODULES
-- 
2.32.0
