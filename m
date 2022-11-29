Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4825D63C180
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 14:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiK2NzR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 08:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbiK2NzQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 08:55:16 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3FC51C28
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 05:55:14 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o30so10960754wms.2
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 05:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1xKBT9NO97hbq5AX3FZlFJhIcopxjMpGPxASPP5ATVQ=;
        b=J95rXzvvZUze1lvdIqhhFA4PJQv246NMIDArbimy8E25DzR6V7ppZViI+omOa4+xkY
         BS2zsQSrLrjaF2Qk+vkBIv1P+CWN0z+K4f5iFV5JikZJgP0SogVJ2lZzhXiJMwbIc+xY
         wbjcYXERyh8UmO0awXCJKJGexCFIMKmucGEq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xKBT9NO97hbq5AX3FZlFJhIcopxjMpGPxASPP5ATVQ=;
        b=4E4VqbRSU+wz88NNoXzLPgglshguDDqQKsTF0dLyfhuTF5j7BJDDzpC1+LgGiD9SNt
         q3GFSFNTliAiZ5No68IMlG0JeoVHPGDDtqdS4S2LrTiDHC2Y4gEUDa2wlpk7EnQjusA3
         k6juYT6y59LrUH+PIOiYeHJzu9olUMcdiPw5aNBc7jqCdjupQPaUc7Ho5I7VzG/Bl4oW
         bWdg9O/xjMS7H6opyaFYmhxGJx1IQkju2TyTKz4wckVKiamA98gNpD1zA37RDmGJ764X
         jIU1enA6ba9eC4BtYNVkiYh5mukBnXaiMb96jeo/J48NxJc8bC7YhdCUvAiFZMRf+n/h
         0rLA==
X-Gm-Message-State: ANoB5pkN3v2s7UsKMiJxf6Mm3gkJOe64YWTrLoz13jAj8nAKVvHeuCRd
        tLUxnHVxBRzzuhM1iLFfCWKrow==
X-Google-Smtp-Source: AA0mqf5qmR64RQzlZF7/6z/JejYMitJleyme0eUjk66IVryn6c8PA4u0NH6SIuk0D76VtYyIHHv6pg==
X-Received: by 2002:a05:600c:3b85:b0:3d0:6f2a:d58e with SMTP id n5-20020a05600c3b8500b003d06f2ad58emr521591wms.71.1669730113222;
        Tue, 29 Nov 2022 05:55:13 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.com ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id hn25-20020a05600ca39900b003b4935f04a4sm2472005wmb.5.2022.11.29.05.55.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2022 05:55:11 -0800 (PST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>
Subject: [PATCH V2 3/7] brcmfmac: add support for vendor-specific firmware api
Date:   Tue, 29 Nov 2022 14:54:42 +0100
Message-Id: <20221129135446.151065-4-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221129135446.151065-1-arend.vanspriel@broadcom.com>
References: <20221129135446.151065-1-arend.vanspriel@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000049ca2305ee9c5658"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--00000000000049ca2305ee9c5658
Content-Transfer-Encoding: 8bit

The driver is being used by multiple vendors who develop the firmware
api independently. So far the firmware api as used by the driver has
not diverged (yet). This change adds framework for supporting multiple
firmware apis. The vendor-specific support code has to provide a number
of callback operations. Right now it is only attach and detach callbacks
so no real functionality as the api is still common. This code only
adds WCC variant anyway, which is selected for all devices right now.
The vendor-specific part will be built in a separate module when the
driver is configured to be built as a module through Kconfig, ie. when
CONFIG_BRCMFMAC=m.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../broadcom/brcm80211/brcmfmac/Makefile      |   7 +
 .../broadcom/brcm80211/brcmfmac/bus.h         |   4 +
 .../broadcom/brcm80211/brcmfmac/core.c        |   9 +
 .../broadcom/brcm80211/brcmfmac/core.h        |   2 +
 .../broadcom/brcm80211/brcmfmac/fwvid.c       | 190 ++++++++++++++++++
 .../broadcom/brcm80211/brcmfmac/fwvid.h       |  46 +++++
 .../broadcom/brcm80211/brcmfmac/wcc/Makefile  |  12 ++
 .../broadcom/brcm80211/brcmfmac/wcc/core.c    |  27 +++
 .../broadcom/brcm80211/brcmfmac/wcc/module.c  |  26 +++
 .../broadcom/brcm80211/brcmfmac/wcc/vops.h    |  11 +
 10 files changed, 334 insertions(+)
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/Makefile
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/vops.h

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
index 13c13504a6e8..e7ceea7af13f 100644
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
+ifeq ($(CONFIG_BRCMFMAC),m)
+obj-m += wcc/
+else
+brcmfmac-$(CONFIG_BRCMFMAC) += wcc/core.o
+endif
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
index 79fe0a49471c..26be49ee8c90 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
@@ -155,7 +155,9 @@ struct brcmf_bus_stats {
  * @fwvid: firmware vendor-support identifier of the device.
  * @always_use_fws_queue: bus wants use queue also when fwsignal is inactive.
  * @wowl_supported: is wowl supported by bus driver.
+ * @ops: callbacks for this bus instance.
  * @msgbuf: msgbuf protocol parameters provided by bus layer.
+ * @list: member used to add this bus instance to linked list.
  */
 struct brcmf_bus {
 	union {
@@ -177,6 +179,8 @@ struct brcmf_bus {
 
 	const struct brcmf_bus_ops *ops;
 	struct brcmf_bus_msgbuf *msgbuf;
+
+	struct list_head list;
 };
 
 /*
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index d354f79fd0ac..584431150f7c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -18,6 +18,7 @@
 
 #include "core.h"
 #include "bus.h"
+#include "fwvid.h"
 #include "debug.h"
 #include "fwil_types.h"
 #include "p2p.h"
@@ -1332,6 +1333,12 @@ int brcmf_attach(struct device *dev)
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
@@ -1443,6 +1450,8 @@ void brcmf_detach(struct device *dev)
 		brcmf_cfg80211_detach(drvr->config);
 		drvr->config = NULL;
 	}
+
+	brcmf_fwvid_detach(drvr);
 }
 
 void brcmf_free(struct device *dev)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
index 2e71b5c2a975..a98b86982502 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
@@ -137,6 +137,8 @@ struct brcmf_pub {
 
 	u8 clmver[BRCMF_DCMD_SMLEN];
 	u8 sta_mac_idx;
+	const struct brcmf_fwvid_ops *vops;
+	void *vdata;
 };
 
 /* forward declarations */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
new file mode 100644
index 000000000000..f5cbb09b1c83
--- /dev/null
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
@@ -0,0 +1,190 @@
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
+	const char *name;
+	const struct brcmf_fwvid_ops *vops;
+	struct list_head drvr_list;
+#if IS_MODULE(CONFIG_BRCMFMAC)
+	struct module *vmod;
+	struct completion reg_done;
+#endif
+};
+
+static DEFINE_MUTEX(fwvid_list_lock);
+
+#if IS_MODULE(CONFIG_BRCMFMAC)
+#define FWVID_ENTRY_INIT(_vid, _name) \
+	[BRCMF_FWVENDOR_ ## _vid] = { \
+		.name = #_name, \
+		.reg_done = COMPLETION_INITIALIZER(fwvid_list[BRCMF_FWVENDOR_ ## _vid].reg_done), \
+		.drvr_list = LIST_HEAD_INIT(fwvid_list[BRCMF_FWVENDOR_ ## _vid].drvr_list), \
+	}
+#else
+#define FWVID_ENTRY_INIT(_vid, _name) \
+	[BRCMF_FWVENDOR_ ## _vid] = { \
+		.name = #_name, \
+		.drvr_list = LIST_HEAD_INIT(fwvid_list[BRCMF_FWVENDOR_ ## _vid].drvr_list), \
+		.vops = _vid ## _VOPS \
+	}
+#endif /* IS_MODULE(CONFIG_BRCMFMAC) */
+
+static struct brcmf_fwvid_entry fwvid_list[BRCMF_FWVENDOR_NUM] = {
+	FWVID_ENTRY_INIT(WCC, wcc),
+};
+
+#if IS_MODULE(CONFIG_BRCMFMAC)
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
+int brcmf_fwvid_unregister_vendor(enum brcmf_fwvendor fwvid, struct module *mod)
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
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
new file mode 100644
index 000000000000..6b3aec190023
--- /dev/null
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: ISC */
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
+int brcmf_fwvid_unregister_vendor(enum brcmf_fwvendor fwvid, struct module *mod);
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
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/Makefile b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/Makefile
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
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
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
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c
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
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/vops.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/vops.h
new file mode 100644
index 000000000000..3aec44f80600
--- /dev/null
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/vops.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2022 Broadcom Corporation
+ */
+#ifndef _BRCMFMAC_WCC_VOPS_H
+#define _BRCMFMAC_WCC_VOPS_H
+
+extern const struct brcmf_fwvid_ops brcmf_wcc_ops;
+#define WCC_VOPS	(&brcmf_wcc_ops)
+
+#endif /* _BRCMFMAC_WCC_VOPS_H */
-- 
2.35.1


--00000000000049ca2305ee9c5658
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDUbaHfAYmHf3UDNv0o
oiKgg36PYmhq2bRB+pyZQt2CwDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMjExMjkxMzU1MTNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAzCr+tNL4k4DRdykEHyQ5xq3G5o30Uj7bfz7q
qfm3IEn9Rgxaudl1sXIuCDnXq40Z/YlzPQPMXDvzqejIb9PfF5ppzJbKZNPBi90UXSorF7Lo/PzX
0BKFnmHXThcCteKeq1eKPFWmELYlH/wjbcUlHm8w5EiHzOoShjAcK9zKNRoDy7rHZCuqaYvkv6TE
mYiU4C3Tcj5VexadUxc3A8gUVDFetVrB01MxPkUq8+F+Zrk3W9gNSeIRJ4eDE3AJJa3T3apVYUUs
iicg6fsUBLY4HyrtFVwHBDBajoRDOAe5K3XUaXW/XNvx9Aei3FlBJniOTePJCOimlJJ/L9lDVIlN
eg==
--00000000000049ca2305ee9c5658--
