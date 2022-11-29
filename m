Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7C863C181
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 14:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbiK2NzT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 08:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbiK2NzS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 08:55:18 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000794FFA0
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 05:55:16 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bs21so22205018wrb.4
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 05:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PT42QUdga1BadgvUoACPgJ7wqz9xTZNAPV+kv7LmgGo=;
        b=X/fmf5HqvShOXZLs+6F+JDuqmWHKaZ5YOBzSimyurCdauv0Qr6tnT7l+ng2JruTOqk
         VHo602updcPLIk0T3nEJg0OS2YPuj2TiTcR/MZHnowO1Ogs0muApvkCGu24jttKCr3aZ
         CBO4banyfUcTBmuDcMH01vfPPgngW4qY2gyuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PT42QUdga1BadgvUoACPgJ7wqz9xTZNAPV+kv7LmgGo=;
        b=MlLryNvIKN0hpJbhHoNFctvblCoECDnzURlC/QHrPcCT216vjjQj8ait0REgoeiE7R
         bcIbM903pwFUrOB9dY1l3p9NIBT7CApZP9bLNJm3/TnMZ+v4ayUhgcx91To34AoVST2o
         YQ97p7cChQQSyLASvpon1Puq5JaF67FreLpmjjNGtF5xJ19EKis/wernAnzCtyxjYASc
         bdRQ3UyfpR+6rYFy8jMU8lzmiq1/1cub66jiONxBfR+oqZWiRHtXm86urbDgAtlBCaPf
         O6MoXSJHjVd83DBBNPdD9YD2BIBhIgYQWKtQLPw7uXqtFXhlHgWLM70cGbMIqOmZBWCp
         n8DA==
X-Gm-Message-State: ANoB5plS9KCISc/Fvl9iLZWXnepq66fjQVUMjWzq/HQfamuvieFlsisu
        w/joa/sWijeAbUzbp0QU0NQc68jLOZMbg/Tsgo0=
X-Google-Smtp-Source: AA0mqf6Qfx5PMS/Ca86+T+xg/6pG+j6jz6TKYnY9GWtwxQ0hLz4TDglXk+W6HgQDqDW2Qb9IgWaFww==
X-Received: by 2002:adf:ead1:0:b0:238:55af:b5db with SMTP id o17-20020adfead1000000b0023855afb5dbmr34874339wrn.97.1669730115510;
        Tue, 29 Nov 2022 05:55:15 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.com ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id hn25-20020a05600ca39900b003b4935f04a4sm2472005wmb.5.2022.11.29.05.55.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2022 05:55:14 -0800 (PST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>
Subject: [PATCH V2 4/7] brcmfmac: add support for Cypress firmware api
Date:   Tue, 29 Nov 2022 14:54:43 +0100
Message-Id: <20221129135446.151065-5-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221129135446.151065-1-arend.vanspriel@broadcom.com>
References: <20221129135446.151065-1-arend.vanspriel@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006ba65f05ee9c56d5"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--0000000000006ba65f05ee9c56d5
Content-Transfer-Encoding: 8bit

Cypress uses the brcmfmac driver and releases firmware which will
likely diverge over time (or already has). So adding support for
handling that.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../broadcom/brcm80211/brcmfmac/Makefile      |  2 +
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      | 48 +++++++++----------
 .../broadcom/brcm80211/brcmfmac/bus.h         |  1 +
 .../broadcom/brcm80211/brcmfmac/cyw/Makefile  | 12 +++++
 .../broadcom/brcm80211/brcmfmac/cyw/core.c    | 27 +++++++++++
 .../broadcom/brcm80211/brcmfmac/cyw/module.c  | 26 ++++++++++
 .../broadcom/brcm80211/brcmfmac/cyw/vops.h    | 11 +++++
 .../broadcom/brcm80211/brcmfmac/fwvid.c       |  2 +
 8 files changed, 105 insertions(+), 24 deletions(-)
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/Makefile
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/vops.h

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
index e7ceea7af13f..64fd77a378fd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
@@ -51,6 +51,8 @@ brcmfmac-$(CONFIG_DMI) += \
 
 ifeq ($(CONFIG_BRCMFMAC),m)
 obj-m += wcc/
+obj-m += cyw/
 else
 brcmfmac-$(CONFIG_BRCMFMAC) += wcc/core.o
+brcmfmac-$(CONFIG_BRCMFMAC) += cyw/core.o
 endif
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index fa919432b1c6..b7c918f241c9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -959,36 +959,36 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
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
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439),
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
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439, CYW),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752, CYW),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_89359, CYW),
 	{ /* end: all zeroes */ }
 };
 MODULE_DEVICE_TABLE(sdio, brcmf_sdmmc_ids);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
index 26be49ee8c90..72036fec9a8e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
@@ -33,6 +33,7 @@
 
 enum brcmf_fwvendor {
 	BRCMF_FWVENDOR_WCC,
+	BRCMF_FWVENDOR_CYW,
 	/* keep last */
 	BRCMF_FWVENDOR_NUM,
 	BRCMF_FWVENDOR_INVALID
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/Makefile b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/Makefile
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
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
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
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
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
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/vops.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/vops.h
new file mode 100644
index 000000000000..870b5bead436
--- /dev/null
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/vops.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2022 Broadcom Corporation
+ */
+#ifndef _BRCMFMAC_CYW_VOPS_H
+#define _BRCMFMAC_CYW_VOPS_H
+
+extern const struct brcmf_fwvid_ops brcmf_cyw_ops;
+#define CYW_VOPS	(&brcmf_cyw_ops)
+
+#endif /* _BRCMFMAC_CYW_VOPS_H */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
index f5cbb09b1c83..ee23eb1809c4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
@@ -19,6 +19,7 @@
 #include "fwvid.h"
 
 #include "wcc/vops.h"
+#include "cyw/vops.h"
 
 struct brcmf_fwvid_entry {
 	const char *name;
@@ -50,6 +51,7 @@ static DEFINE_MUTEX(fwvid_list_lock);
 
 static struct brcmf_fwvid_entry fwvid_list[BRCMF_FWVENDOR_NUM] = {
 	FWVID_ENTRY_INIT(WCC, wcc),
+	FWVID_ENTRY_INIT(CYW, cyw),
 };
 
 #if IS_MODULE(CONFIG_BRCMFMAC)
-- 
2.35.1


--0000000000006ba65f05ee9c56d5
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC72fqkGJnIQvixFQY4
54cInhiB6l1jP75kX9nVLmwfKjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMjExMjkxMzU1MTVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEA5iVZn4T8SIIPWzWxh2JVxmvNvm++uhoWrKpF
L3NA/FmgX+fGH+2OPGt/LXtjRRVTKYiUUvS9z5y131FtsouHQCT6mu0BY74HoCSgljkePxY+Hc1f
AXl5LRouEzDdlTVC50uJKqCtAZDOSpNBJZNPP+8C7Ho5aPBry9Supk+cdbnUm10ov1Xnsda1TFzi
pPXx1RQFSyFM+yPkv3WYcLMBydPQLK841d16Wbk4jb8DoB6w8RtFzZPT+2Pt5sBP1iNdQ0HvuXUa
R+MlJBYoYO9SXClNmAqMkxIVOAzi9UdyHmjxo8OxscVvzp4HVt70+hL4GZfpotQgBf8/D1SW+g+4
cg==
--0000000000006ba65f05ee9c56d5--
