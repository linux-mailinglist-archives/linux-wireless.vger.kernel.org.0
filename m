Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B13548398
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jun 2022 11:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240717AbiFMJTf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jun 2022 05:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240676AbiFMJT3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jun 2022 05:19:29 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B24186F0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 02:19:28 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id v1so9864539ejg.13
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 02:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:in-reply-to:references:date:message-id:subject:to
         :cc;
        bh=ENY/KOqqUnEnWDjjSY3OF68da/0petsodgVm2JNTiCg=;
        b=K7I3wwjdHvNsAxf4nc84zeMom9Crc7URxysiLj+qaMnAkbVoOFSPeumnbNhBWaYVTK
         mS6jB8hMIr3SVTeZ2yIdIehK9Wog9B+gM7ZQbPAAN4loDmKuX74EjF0foEAc4Kbv7iJv
         I/D5LjYsntHO8ogXHIvAwOHWYpPwXaRKXoa4jH4iKTgPb/rN3kRx2Xo4UqRjtCiZ9ry+
         x3va9JhbX/f7j5cXvTpXhcmVewFI8RwIMDUSkezmCFnwk50c1Ru5N4ESYI47iCIZHwvq
         /vtXb2zdds0RaphEmDIILNSzrgf+suSrnlWh0mA7YcnAsqWaMaRNfk9JJledP2Y8Oz8R
         2E8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:in-reply-to:references:date
         :message-id:subject:to:cc;
        bh=ENY/KOqqUnEnWDjjSY3OF68da/0petsodgVm2JNTiCg=;
        b=2NDtm7Ttc/ljUstrG3yeM/LMQ8eUFVE/aBPoyjkEgwwtxjFgY6kOvK2nR7X9mRILHa
         NVq93n8n/0yevSi/Bhj4K7EYOgPuP5JDeu4CKI4ay+eSMBY1yTBNl2B8VNvL7h8PjrZQ
         G/TuCtI735dgR3bmQMPrPUlHOLdT1xybwKWxa+iNzAMSLTWWb29cXFsog8kdUa9tRkAJ
         gPyFPy5sST2RHR+Bzra107QEsPz6IUZkz9SReBHtFA7E+R4vbdbCi7GoKu4Lrc52jy0e
         44PKggWIzrreYn8f3+gDzbZi/g0Tt2gWIkT68lty1/cFVktM1h09uYlPiOUeejC0u5Gp
         /3Lw==
X-Gm-Message-State: AOAM531eA+dLOuF47WDvuUiLHPQj2tNZubzHuL6wNf33ViIZwRyCYaLz
        G87u1AiuvdmSq7WbaQlJKQ2fRy5kh7yuUjwsEg4=
X-Google-Smtp-Source: ABdhPJz/CA4GWMHuuLjSYOcJyuBQZKuzQebDxMqVa0YMd+5XwVylnt802ePHxaOmhHYMidHjZirIId67TRqjav/OJuw=
MIME-Version: 1.0
X-Received: by 2002:a17:907:2095:b0:711:fbbe:e307 with SMTP id
 pv21-20020a170907209500b00711fbbee307mr19791774ejb.274.1655111966534; Mon, 13
 Jun 2022 02:19:26 -0700 (PDT)
Received: from 35650733073 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 13 Jun 2022 05:19:26 -0400
From:   aspriel@gmail.com
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20220613091915.18884-1-arend.vanspriel@broadcom.com>
References: <20220613091915.18884-1-arend.vanspriel@broadcom.com>
Date:   Mon, 13 Jun 2022 05:19:26 -0400
Message-ID: <CAJ65rDxy3ERmDAV1BYH_BCUM3_GnzotWpp7yYO6OtA_CZVgbzw@mail.gmail.com>
Subject: [PATCH 3/7] brcmfmac: add support for vendor-specific firmware api
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

The driver is being used by multiple vendors who develop the firmware
api independently. So far the firmware api as used by the driver has
not diverged (yet). This change adds framework for supporting multiple
firmware apis. The vendor-specific support code has to provide a number
of callback operations. Right now it is only attach and detach callbacks
so no real functionality as the api is still common. This code only
adds WCC variant anyway, which is selected for all devices right now.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../broadcom/brcm80211/brcmfmac/Kconfig       |  16 ++
 .../broadcom/brcm80211/brcmfmac/Makefile      |   7 +
 .../broadcom/brcm80211/brcmfmac/bus.h         |   4 +
 .../broadcom/brcm80211/brcmfmac/core.c        |   9 +
 .../broadcom/brcm80211/brcmfmac/core.h        |   2 +
 .../broadcom/brcm80211/brcmfmac/fwvid.c       | 196 ++++++++++++++++++
 .../broadcom/brcm80211/brcmfmac/fwvid.h       |  46 ++++
 .../broadcom/brcm80211/brcmfmac/wcc/Makefile  |  12 ++
 .../broadcom/brcm80211/brcmfmac/wcc/core.c    |  27 +++
 .../broadcom/brcm80211/brcmfmac/wcc/module.c  |  26 +++
 .../broadcom/brcm80211/brcmfmac/wcc/vops.h    |  15 ++
 11 files changed, 360 insertions(+)
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
 create mode 100644
drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/Makefile
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
 create mode 100644
drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/vops.h

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
index 32794c1eca23..32c2f6e42a3e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
@@ -8,6 +8,22 @@ config BRCMFMAC
 	  interface support. If you choose to build a module, it'll be called
 	  brcmfmac.ko.

+config BRCMFMAC_VENDOR_MODULES
+	bool "Use vendor-specific modules"
+	depends on BRCMFMAC = m
+	help
+	  This option will build separate modules for the vendor-specific
+	  firmware support. If not selected the vendor-specific support
+	  will be build in brcmfmac.ko.
+
+config BRCMFMAC_VENDOR_WCC
+	bool "Broadcom WCC"
+	default y
+	depends on BRCMFMAC
+        help
+          This option will allow the driver to communicate with devices
+          shipped by Broadcom WCC division.
+
 config BRCMFMAC_PROTO_BCDC
 	bool

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
index 13c13504a6e8..08dbafdb6527 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
@@ -20,6 +20,7 @@ brcmfmac-objs += \
 		common.o \
 		core.o \
 		firmware.o \
+		fwvid.o \
 		feature.o \
 		btcoex.o \
 		vendor.o \
@@ -47,3 +48,9 @@ brcmfmac-$(CONFIG_OF) += \
 		of.o
 brcmfmac-$(CONFIG_DMI) += \
 		dmi.o
+
+ifeq ($(CONFIG_BRCMFMAC_VENDOR_MODULES),)
+brcmfmac-$(CONFIG_BRCMFMAC_VENDOR_WCC) += wcc/core.o
+else
+obj-$(CONFIG_BRCMFMAC_VENDOR_WCC) += wcc/
+endif
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
index 2008fde3ff4e..a2759171fcc9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
@@ -142,7 +142,9 @@ struct brcmf_bus_stats {
  * @fwvid: firmware vendor-support identifier of the device.
  * @always_use_fws_queue: bus wants use queue also when fwsignal is inactive.
  * @wowl_supported: is wowl supported by bus driver.
+ * @ops: callbacks for this bus instance.
  * @msgbuf: msgbuf protocol parameters provided by bus layer.
+ * @list: member used to add this bus instance to linked list.
  */
 struct brcmf_bus {
 	union {
@@ -164,6 +166,8 @@ struct brcmf_bus {

 	const struct brcmf_bus_ops *ops;
 	struct brcmf_bus_msgbuf *msgbuf;
+
+	struct list_head list;
 };

 /*
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 87aef211b35f..9a77b100abbb 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -18,6 +18,7 @@

 #include "core.h"
 #include "bus.h"
+#include "fwvid.h"
 #include "debug.h"
 #include "fwil_types.h"
 #include "p2p.h"
@@ -1335,6 +1336,12 @@ int brcmf_attach(struct device *dev)
 	/* Link to bus module */
 	drvr->hdrlen = 0;

+	ret = brcmf_fwvid_attach(drvr);
+	if (ret != 0) {
+		bphy_err(drvr, "brcmf_fwvid_attach failed\n");
+		goto fail;
+	}
+
 	/* Attach and link in the protocol */
 	ret = brcmf_proto_attach(drvr);
 	if (ret != 0) {
@@ -1445,6 +1452,8 @@ void brcmf_detach(struct device *dev)
 		brcmf_cfg80211_detach(drvr->config);
 		drvr->config = NULL;
 	}
+
+	brcmf_fwvid_detach(drvr);
 }

 void brcmf_free(struct device *dev)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
index 340346c122d3..5d627b8dbb50 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
@@ -136,6 +136,8 @@ struct brcmf_pub {
 	struct work_struct bus_reset;

 	u8 clmver[BRCMF_DCMD_SMLEN];
+	const struct brcmf_fwvid_ops *vops;
+	void *vdata;
 };

 /* forward declarations */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
new file mode 100644
index 000000000000..654a31caa643
--- /dev/null
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2022 Broadcom Corporation
+ */
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/kmod.h>
+#include <linux/list.h>
+#include <linux/completion.h>
+#include <linux/mutex.h>
+#include <linux/printk.h>
+#include <linux/jiffies.h>
+#include <linux/workqueue.h>
+
+#include "core.h"
+#include "bus.h"
+#include "debug.h"
+#include "fwvid.h"
+
+#include "wcc/vops.h"
+
+struct brcmf_fwvid_entry {
+	bool enabled;
+	const char *name;
+	const struct brcmf_fwvid_ops *vops;
+	struct list_head drvr_list;
+#ifdef CONFIG_BRCMFMAC_VENDOR_MODULES
+	struct module *vmod;
+	struct completion reg_done;
+#endif
+};
+
+static DEFINE_MUTEX(fwvid_list_lock);
+
+#ifdef CONFIG_BRCMFMAC_VENDOR_MODULES
+#define FWVID_ENTRY_INIT(_vid, _name) \
+	[BRCMF_FWVENDOR_ ## _vid] = { \
+		.enabled = IS_ENABLED(CONFIG_BRCMFMAC_VENDOR_ ## _vid), \
+		.name = #_name, \
+		.reg_done = COMPLETION_INITIALIZER(fwvid_list[BRCMF_FWVENDOR_ ##
_vid].reg_done), \
+		.drvr_list = LIST_HEAD_INIT(fwvid_list[BRCMF_FWVENDOR_ ## _vid].drvr_list), \
+	}
+#else
+#define FWVID_ENTRY_INIT(_vid, _name) \
+	[BRCMF_FWVENDOR_ ## _vid] = { \
+		.enabled = IS_ENABLED(CONFIG_BRCMFMAC_VENDOR_ ## _vid), \
+		.name = #_name, \
+		.drvr_list = LIST_HEAD_INIT(fwvid_list[BRCMF_FWVENDOR_ ## _vid].drvr_list), \
+		.vops = _vid ## _VOPS \
+	}
+#endif /* CONFIG_BRCMFMAC_VENDOR_MODULES */
+
+static struct brcmf_fwvid_entry fwvid_list[BRCMF_FWVENDOR_NUM] = {
+	FWVID_ENTRY_INIT(WCC, wcc),
+};
+
+#ifdef CONFIG_BRCMFMAC_VENDOR_MODULES
+static int brcmf_fwvid_request_module(enum brcmf_fwvendor fwvid)
+{
+	int ret;
+
+	if (!fwvid_list[fwvid].vmod) {
+		struct completion *reg_done = &fwvid_list[fwvid].reg_done;
+
+		mutex_unlock(&fwvid_list_lock);
+
+		ret = request_module("brcmfmac-%s", fwvid_list[fwvid].name);
+		if (ret)
+			goto fail;
+
+		ret = wait_for_completion_interruptible(reg_done);
+		if (ret)
+			goto fail;
+
+		mutex_lock(&fwvid_list_lock);
+	}
+	return 0;
+
+fail:
+	brcmf_err("mod=%s: failed %d\n", fwvid_list[fwvid].name, ret);
+	return ret;
+}
+
+int brcmf_fwvid_register_vendor(enum brcmf_fwvendor fwvid, struct module *vmod,
+				const struct brcmf_fwvid_ops *vops)
+{
+	if (fwvid >= BRCMF_FWVENDOR_NUM)
+		return -ERANGE;
+
+	if (WARN_ON(!vmod) || WARN_ON(!vops) ||
+	    WARN_ON(!vops->attach) || WARN_ON(!vops->detach))
+		return -EINVAL;
+
+	if (WARN_ON(fwvid_list[fwvid].vmod))
+		return -EEXIST;
+
+	brcmf_dbg(TRACE, "mod=%s: enter\n", fwvid_list[fwvid].name);
+
+	mutex_lock(&fwvid_list_lock);
+
+	fwvid_list[fwvid].vmod = vmod;
+	fwvid_list[fwvid].vops = vops;
+
+	mutex_unlock(&fwvid_list_lock);
+
+	complete_all(&fwvid_list[fwvid].reg_done);
+
+	return 0;
+}
+EXPORT_SYMBOL(brcmf_fwvid_register_vendor);
+
+int brcmf_fwvid_unregister_vendor(enum brcmf_fwvendor fwvid, struct
module *mod)
+{
+	struct brcmf_bus *bus, *tmp;
+
+	if (fwvid >= BRCMF_FWVENDOR_NUM)
+		return -ERANGE;
+
+	if (WARN_ON(fwvid_list[fwvid].vmod != mod))
+		return -ENOENT;
+
+	mutex_lock(&fwvid_list_lock);
+
+	list_for_each_entry_safe(bus, tmp, &fwvid_list[fwvid].drvr_list, list) {
+		mutex_unlock(&fwvid_list_lock);
+
+		brcmf_dbg(INFO, "mod=%s: removing %s\n", fwvid_list[fwvid].name,
+			  dev_name(bus->dev));
+		brcmf_bus_remove(bus);
+
+		mutex_lock(&fwvid_list_lock);
+	}
+
+	fwvid_list[fwvid].vmod = NULL;
+	fwvid_list[fwvid].vops = NULL;
+	reinit_completion(&fwvid_list[fwvid].reg_done);
+
+	brcmf_dbg(TRACE, "mod=%s: exit\n", fwvid_list[fwvid].name);
+	mutex_unlock(&fwvid_list_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(brcmf_fwvid_unregister_vendor);
+#else
+static inline int brcmf_fwvid_request_module(enum brcmf_fwvendor fwvid)
+{
+	return 0;
+}
+#endif
+
+int brcmf_fwvid_attach_ops(struct brcmf_pub *drvr)
+{
+	enum brcmf_fwvendor fwvid = drvr->bus_if->fwvid;
+	int ret;
+
+	if (fwvid >= ARRAY_SIZE(fwvid_list))
+		return -ERANGE;
+
+	if (!fwvid_list[fwvid].enabled)
+		return -EPROTONOSUPPORT;
+
+	brcmf_dbg(TRACE, "mod=%s: enter: dev %s\n", fwvid_list[fwvid].name,
+		  dev_name(drvr->bus_if->dev));
+
+	mutex_lock(&fwvid_list_lock);
+
+	ret = brcmf_fwvid_request_module(fwvid);
+	if (ret)
+		return ret;
+
+	drvr->vops = fwvid_list[fwvid].vops;
+	list_add(&drvr->bus_if->list, &fwvid_list[fwvid].drvr_list);
+
+	mutex_unlock(&fwvid_list_lock);
+
+	return ret;
+}
+
+void brcmf_fwvid_detach_ops(struct brcmf_pub *drvr)
+{
+	enum brcmf_fwvendor fwvid = drvr->bus_if->fwvid;
+
+	if (fwvid >= ARRAY_SIZE(fwvid_list))
+		return;
+
+	brcmf_dbg(TRACE, "mod=%s: enter: dev %s\n", fwvid_list[fwvid].name,
+		  dev_name(drvr->bus_if->dev));
+
+	mutex_lock(&fwvid_list_lock);
+
+	drvr->vops = NULL;
+	list_del(&drvr->bus_if->list);
+
+	mutex_unlock(&fwvid_list_lock);
+}
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
new file mode 100644
index 000000000000..cc79df8cc428
--- /dev/null
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2022 Broadcom Corporation
+ */
+#ifndef FWVID_H_
+#define FWVID_H_
+
+#include "firmware.h"
+
+struct brcmf_pub;
+
+struct brcmf_fwvid_ops {
+	int (*attach)(struct brcmf_pub *drvr);
+	void (*detach)(struct brcmf_pub *drvr);
+};
+
+/* exported functions */
+int brcmf_fwvid_register_vendor(enum brcmf_fwvendor fwvid, struct module *mod,
+				const struct brcmf_fwvid_ops *ops);
+int brcmf_fwvid_unregister_vendor(enum brcmf_fwvendor fwvid, struct
module *mod);
+
+/* core driver functions */
+int brcmf_fwvid_attach_ops(struct brcmf_pub *drvr);
+void brcmf_fwvid_detach_ops(struct brcmf_pub *drvr);
+
+static inline int brcmf_fwvid_attach(struct brcmf_pub *drvr)
+{
+	int ret;
+
+	ret = brcmf_fwvid_attach_ops(drvr);
+	if (ret)
+		return ret;
+
+	return drvr->vops->attach(drvr);
+}
+
+static inline void brcmf_fwvid_detach(struct brcmf_pub *drvr)
+{
+	if (!drvr->vops)
+		return;
+
+	drvr->vops->detach(drvr);
+	brcmf_fwvid_detach_ops(drvr);
+}
+
+#endif /* FWVID_H_ */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/Makefile
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/Makefile
new file mode 100644
index 000000000000..7f455a19a2b1
--- /dev/null
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/Makefile
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
+obj-m += brcmfmac-wcc.o
+brcmfmac-wcc-objs += \
+		core.o module.o
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
new file mode 100644
index 000000000000..02de99818efa
--- /dev/null
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
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
+static int brcmf_wcc_attach(struct brcmf_pub *drvr)
+{
+	pr_err("%s: executing\n", __func__);
+	return 0;
+}
+
+static void brcmf_wcc_detach(struct brcmf_pub *drvr)
+{
+	pr_err("%s: executing\n", __func__);
+}
+
+const struct brcmf_fwvid_ops brcmf_wcc_ops = {
+	.attach = brcmf_wcc_attach,
+	.detach = brcmf_wcc_detach,
+};
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c
new file mode 100644
index 000000000000..23e3a4557880
--- /dev/null
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c
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
+static int __init brcmf_wcc_init(void)
+{
+	return brcmf_fwvid_register_vendor(BRCMF_FWVENDOR_WCC, THIS_MODULE,
+					   &brcmf_wcc_ops);
+}
+
+static void __exit brcmf_wcc_exit(void)
+{
+	brcmf_fwvid_unregister_vendor(BRCMF_FWVENDOR_WCC, THIS_MODULE);
+}
+
+MODULE_LICENSE("Dual BSD/GPL");
+
+module_init(brcmf_wcc_init);
+module_exit(brcmf_wcc_exit);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/vops.h
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/vops.h
new file mode 100644
index 000000000000..a836954334e5
--- /dev/null
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/vops.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2022 Broadcom Corporation
+ */
+#ifndef _BRCMFMAC_WCC_VOPS_H
+#define _BRCMFMAC_WCC_VOPS_H
+
+#ifdef CONFIG_BRCMFMAC_VENDOR_WCC
+extern const struct brcmf_fwvid_ops brcmf_wcc_ops;
+#define WCC_VOPS	(&brcmf_wcc_ops)
+#else
+#define WCC_VOPS	(NULL)
+#endif /* CONFIG_BRCMFMAC_VENDOR_WCC */
+
+#endif /* _BRCMFMAC_WCC_VOPS_H */
-- 
2.32.0
