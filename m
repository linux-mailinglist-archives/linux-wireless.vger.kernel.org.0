Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070BF54836C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jun 2022 11:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240720AbiFMJTe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jun 2022 05:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240658AbiFMJT1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jun 2022 05:19:27 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA2C14D14
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 02:19:25 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 25so6221627edw.8
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 02:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:in-reply-to:references:date:message-id:subject:to
         :cc;
        bh=v8H/f33+kWC02Y0QsHt0YH0sd8usWnmRB4IjtTkb5jk=;
        b=b5DYy3byv7K08kJ4yxHvw3ZMLmabIMHj2xtaiV/uTKCNUeLKya7NjO/SW8Fc7fjMf1
         ODEWP9JsmbKB3GX6ayjxt9LjPIcPMl8bnZwqMl8b0j7r5piQbICZc1lxGxIfqUolhXJA
         Lu7ujOBaUDM47upZXG6n0qHaF35nQbpo8WaDdlwbwO6F3sSaQKuxBRg0gDX4mfNPe5HX
         BpznOi1+1vDr1YlDJm6qPtPfCwxooJzSZLTzZwSYVgMm8ZWWv3OIbiCA6SEP4zsMwxhe
         9vvAYs3C0HdqR8m7rEcwbCIdmJZSmk/m4PweG2HYw5ZTSofOAJBCWGwMOhdaDZJ9A2Za
         gtkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:in-reply-to:references:date
         :message-id:subject:to:cc;
        bh=v8H/f33+kWC02Y0QsHt0YH0sd8usWnmRB4IjtTkb5jk=;
        b=rwwLQcZ3Bqf5xnHSMZd4XPkHPVMVCmGakSMxSHpDxEFJVNbOeEZ7WDDEJGhdheJ3TS
         iPdxyTePI3EdGivvQaD9eJmOyaV9mWLvTxbqjIbIhMxGdIb6REmb5UVF78LSBLAsY2nR
         SrPd4wCe4ZU0F+UE2veViPXViZ573xE+nAY5VZwJ5IiH+SDQOnUZI4L7tiqS1p77+QUr
         k0VOttJgQmMYLJv+ahHacW/TVmWyKZovwOgyeM7SNhnYuKzNPG5V25H7oyq59BWoDajy
         N/pEwxdUBZkWUr4ZecyvDZ/3arHq8Ql+dRMWWmGmlR+5yC69jz42fQxRVXZy5+Txt0SY
         REjw==
X-Gm-Message-State: AOAM533165/Nl3kpHqXzdL3PNc+Ja5ubVQkvuRUdq5ZexY59SVPUxPv4
        RqdQHSKps0SO5C4fuk3r4iPpKtSqcayYfOCWEUfXohvhg6A=
X-Google-Smtp-Source: ABdhPJyTx90naxxksXVKkiym3FSWpwqZ3yUOPutWvbsrOYjfwlNcHjobZ3k53wPpOUNMF4UXM3DHG8xBwXVzIZmJlwE=
MIME-Version: 1.0
X-Received: by 2002:aa7:da50:0:b0:42d:cdc8:8751 with SMTP id
 w16-20020aa7da50000000b0042dcdc88751mr64722450eds.19.1655111964486; Mon, 13
 Jun 2022 02:19:24 -0700 (PDT)
Received: from 35650733073 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 13 Jun 2022 05:19:23 -0400
From:   aspriel@gmail.com
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20220613091915.18884-1-arend.vanspriel@broadcom.com>
References: <20220613091915.18884-1-arend.vanspriel@broadcom.com>
Date:   Mon, 13 Jun 2022 05:19:23 -0400
Message-ID: <CAJ65rDx3pxNt56k4U=cD2gtJD959mMeKvGiYFBUkQ_RfbrouxQ@mail.gmail.com>
Subject: [PATCH 1/7] brcmfmac: add function to unbind device to bus layer api
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

Introduce a new bus callback .remove() which will unbind the device
from the driver. This allows the common driver layer to stop handling
a device.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/bus.h  | 13 +++++++++++++
 .../net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 12 +++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
index 3f5da3bb6aa5..a9363de809ea 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
@@ -6,6 +6,7 @@
 #ifndef BRCMFMAC_BUS_H
 #define BRCMFMAC_BUS_H

+#include <linux/device.h>
 #include "debug.h"

 /* IDs of the 6 default common rings of msgbuf protocol */
@@ -61,6 +62,7 @@ struct brcmf_bus_dcmd {
  * @get_ramsize: obtain size of device memory.
  * @get_memdump: obtain device memory dump in provided buffer.
  * @get_fwname: obtain firmware name.
+ * @remove: initiate unbind of the device.
  *
  * This structure provides an abstract interface towards the
  * bus specific driver. For control messages to common driver
@@ -81,6 +83,7 @@ struct brcmf_bus_ops {
 			  unsigned char *fw_name);
 	void (*debugfs_create)(struct device *dev);
 	int (*reset)(struct device *dev);
+	void (*remove)(struct device *dev);
 };


@@ -244,6 +247,16 @@ int brcmf_bus_reset(struct brcmf_bus *bus)
 	return bus->ops->reset(bus->dev);
 }

+static inline void brcmf_bus_remove(struct brcmf_bus *bus)
+{
+	if (!bus->ops->remove) {
+		device_release_driver(bus->dev);
+		return;
+	}
+
+	bus->ops->remove(bus->dev);
+}
+
 /*
  * interface functions from common layer
  */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 212fbbe1cd7e..be2e50ed6e1c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -4179,6 +4179,15 @@ static int brcmf_sdio_bus_reset(struct device *dev)
 	return ret;
 }

+static void brcmf_sdio_bus_remove(struct device *dev)
+{
+	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
+	struct brcmf_sdio_dev *sdiod = bus_if->bus_priv.sdio;
+
+	device_release_driver(&sdiod->func2->dev);
+	device_release_driver(&sdiod->func1->dev);
+}
+
 static const struct brcmf_bus_ops brcmf_sdio_bus_ops = {
 	.stop = brcmf_sdio_bus_stop,
 	.preinit = brcmf_sdio_bus_preinit,
@@ -4191,7 +4200,8 @@ static const struct brcmf_bus_ops brcmf_sdio_bus_ops = {
 	.get_memdump = brcmf_sdio_bus_get_memdump,
 	.get_fwname = brcmf_sdio_get_fwname,
 	.debugfs_create = brcmf_sdio_debugfs_create,
-	.reset = brcmf_sdio_bus_reset
+	.reset = brcmf_sdio_bus_reset,
+	.remove = brcmf_sdio_bus_remove,
 };

 #define BRCMF_SDIO_FW_CODE	0
-- 
2.32.0
