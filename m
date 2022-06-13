Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD15548337
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jun 2022 11:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240707AbiFMJTc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jun 2022 05:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240666AbiFMJT1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jun 2022 05:19:27 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE96D17044
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 02:19:26 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id d14so6208215eda.12
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 02:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:in-reply-to:references:date:message-id:subject:to
         :cc;
        bh=YCsndrMJLVIw2GObEy/S2kpkzKFFbVzehHSlvDh46Z4=;
        b=T4XPK3jNvBBEEi5dlOOEAfz4gsearjQoeIF3BOw9L/Dbk2F7kj379P+kspdK11uRG3
         iVu2SR9qy/G9eHpwmJcP6Q6Q1T+hB+e20+78RYDQ26dKt0IfwM1cGhKSmukW0G0yBJpR
         nXXRWFSA4Ha5R2YCxPRyhjV2ET8AHOzwQyBMg7JL6xXG8HJZYPuKzbbefMmg4Afkl+PN
         E3a3YxFjaP76PMDSRlwxnuKcLhGvWV8ObBVdaVqgi0rHy6CB82b/FwAaG3KzqinI6icb
         ayf2R0J8fqB18qv842AxA7gX9kOJwKxliwvdprRRYojb46BKXFOOZEVTVfSqEcdkpP1p
         RvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:in-reply-to:references:date
         :message-id:subject:to:cc;
        bh=YCsndrMJLVIw2GObEy/S2kpkzKFFbVzehHSlvDh46Z4=;
        b=mZCOIZR9Dx6c4BgFokGt+JZcvZ1UlunBbuII72uDICfNbIhtu18DLyeyhlKNF8A8bw
         6h07buYYiGj+BFYlXv1ETwTHUAQLLngw4zqHhXorJexNsAlcjYVi+jqWX5zB0N2eiN5O
         JA7p+8UntkFlTlYX7YqT4NyB+3ZojhrZqbLz2UNYIPdvTB8aoLRlG9edjTcNCeJh05oA
         fwwf86l3/cCSmpGaOwM/XenGP/tsBFauV27JWwE6nz2jk7ZJgihjhyamcLn9fTW6NyEM
         0yxD+9pjCc0onpH3WUoONMCycBsGixZzDV7u4UsyI1Jd6KWxafuUNxEMsc8vh6TIteVE
         IZzw==
X-Gm-Message-State: AOAM530SImHdqrZXai4Uoxgym9tSDiPYFb6nbp8deBQ7KnU1tLrTmW5G
        JO8Pfie5AO2tOce5lc3Syx4AMvAK+PkDpoL8bZM=
X-Google-Smtp-Source: ABdhPJwEDhjBUtHDBwZ2758maEy7tFzgt22I9umJK7S4o2XHRHBnwquzNelYXXifDivt0Ev6Qd5/1UA/Yj27sSI1qlk=
MIME-Version: 1.0
X-Received: by 2002:a05:6402:ea7:b0:433:6141:840e with SMTP id
 h39-20020a0564020ea700b004336141840emr13193013eda.266.1655111965459; Mon, 13
 Jun 2022 02:19:25 -0700 (PDT)
Received: from 35650733073 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 13 Jun 2022 05:19:24 -0400
From:   aspriel@gmail.com
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20220613091915.18884-1-arend.vanspriel@broadcom.com>
References: <20220613091915.18884-1-arend.vanspriel@broadcom.com>
Date:   Mon, 13 Jun 2022 05:19:24 -0400
Message-ID: <CAJ65rDwH9SYhsTKM_4c6e0EN6qfp16kGVsVtSs0d+TNou=DF5g@mail.gmail.com>
Subject: [PATCH 2/7] brcmfmac: add firmware vendor info in driver data
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

In order to determine the vendor that released a firmware image for
a specific device, the device table now sets the vendor identifier
and it is stored in struct brcmf_bus::fwvid during probe.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  6 ++++-
 .../broadcom/brcm80211/brcmfmac/bus.h         | 11 +++++++-
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 20 ++++++++++----
 .../broadcom/brcm80211/brcmfmac/usb.c         | 27 +++++++++++++------
 4 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 9c598ea97499..5ec56567dab6 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -968,7 +968,10 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 }

 #define BRCMF_SDIO_DEVICE(dev_id)	\
-	{SDIO_DEVICE(SDIO_VENDOR_ID_BROADCOM, dev_id)}
+	{ \
+		SDIO_DEVICE(SDIO_VENDOR_ID_BROADCOM, dev_id), \
+		.driver_data = BRCMF_FWVENDOR_WCC \
+	}

 /* devices we support, null terminated */
 static const struct sdio_device_id brcmf_sdmmc_ids[] = {
@@ -1058,6 +1061,7 @@ static int brcmf_ops_sdio_probe(struct sdio_func *func,
 	sdiodev->bus_if = bus_if;
 	bus_if->bus_priv.sdio = sdiodev;
 	bus_if->proto_type = BRCMF_PROTO_BCDC;
+	bus_if->fwvid = id->driver_data;
 	dev_set_drvdata(&func->dev, bus_if);
 	dev_set_drvdata(&sdiodev->func1->dev, bus_if);
 	sdiodev->dev = &sdiodev->func1->dev;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
index a9363de809ea..2008fde3ff4e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
@@ -23,6 +23,13 @@
 #define BRCMF_NROF_COMMON_MSGRINGS	(BRCMF_NROF_H2D_COMMON_MSGRINGS + \
 					 BRCMF_NROF_D2H_COMMON_MSGRINGS)

+enum brcmf_fwvendor {
+	BRCMF_FWVENDOR_WCC,
+	/* keep last */
+	BRCMF_FWVENDOR_NUM,
+	BRCMF_FWVENDOR_INVALID
+};
+
 /* The level of bus communication with the dongle */
 enum brcmf_bus_state {
 	BRCMF_BUS_DOWN,		/* Not ready for frame transfers */
@@ -131,9 +138,10 @@ struct brcmf_bus_stats {
  * @stats: statistics shared between common and bus layer.
  * @maxctl: maximum size for rxctl request message.
  * @chip: device identifier of the dongle chip.
+ * @chiprev: revision of the dongle chip.
+ * @fwvid: firmware vendor-support identifier of the device.
  * @always_use_fws_queue: bus wants use queue also when fwsignal is inactive.
  * @wowl_supported: is wowl supported by bus driver.
- * @chiprev: revision of the dongle chip.
  * @msgbuf: msgbuf protocol parameters provided by bus layer.
  */
 struct brcmf_bus {
@@ -150,6 +158,7 @@ struct brcmf_bus {
 	uint maxctl;
 	u32 chip;
 	u32 chiprev;
+	enum brcmf_fwvendor fwvid;
 	bool always_use_fws_queue;
 	bool wowl_supported;

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 97f0f13dfe50..0599dad96018 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -1910,6 +1910,7 @@ brcmf_pcie_probe(struct pci_dev *pdev, const
struct pci_device_id *id)
 	bus->bus_priv.pcie = pcie_bus_dev;
 	bus->ops = &brcmf_pcie_bus_ops;
 	bus->proto_type = BRCMF_PROTO_MSGBUF;
+	bus->fwvid = id->driver_data;
 	bus->chip = devinfo->coreid;
 	bus->wowl_supported = pci_pme_capable(pdev, PCI_D3hot);
 	dev_set_drvdata(&pdev->dev, bus);
@@ -2076,11 +2077,20 @@ static const struct dev_pm_ops brcmf_pciedrvr_pm = {
 #endif /* CONFIG_PM */


-#define BRCMF_PCIE_DEVICE(dev_id)	{ BRCM_PCIE_VENDOR_ID_BROADCOM, dev_id,\
-	PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, 0 }
-#define BRCMF_PCIE_DEVICE_SUB(dev_id, subvend, subdev)	{ \
-	BRCM_PCIE_VENDOR_ID_BROADCOM, dev_id,\
-	subvend, subdev, PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, 0 }
+#define BRCMF_PCIE_DEVICE(dev_id) \
+	{ \
+		BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
+		PCI_ANY_ID, PCI_ANY_ID, \
+		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
+		BRCMF_FWVENDOR_WCC \
+	}
+#define BRCMF_PCIE_DEVICE_SUB(dev_id, subvend, subdev) \
+	{ \
+		BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
+		(subvend), (subdev), \
+		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
+		BRCMF_FWVENDOR_WCC \
+	}

 static const struct pci_device_id brcmf_pcie_devid_table[] = {
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4350_DEVICE_ID),
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 9fb68c2dc7e3..e34523c8a275 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1253,7 +1253,8 @@ brcmf_usb_prepare_fw_request(struct
brcmf_usbdev_info *devinfo)
 	return fwreq;
 }

-static int brcmf_usb_probe_cb(struct brcmf_usbdev_info *devinfo)
+static int brcmf_usb_probe_cb(struct brcmf_usbdev_info *devinfo,
+			      enum brcmf_fwvendor fwvid)
 {
 	struct brcmf_bus *bus = NULL;
 	struct brcmf_usbdev *bus_pub = NULL;
@@ -1278,6 +1279,7 @@ static int brcmf_usb_probe_cb(struct
brcmf_usbdev_info *devinfo)
 	dev_set_drvdata(dev, bus);
 	bus->ops = &brcmf_usb_bus_ops;
 	bus->proto_type = BRCMF_PROTO_BCDC;
+	bus->fwvid = fwvid;
 	bus->always_use_fws_queue = true;
 #ifdef CONFIG_PM
 	bus->wowl_supported = true;
@@ -1436,7 +1438,7 @@ brcmf_usb_probe(struct usb_interface *intf,
const struct usb_device_id *id)
 	else
 		brcmf_dbg(USB, "Broadcom full speed USB WLAN interface detected\n");

-	ret = brcmf_usb_probe_cb(devinfo);
+	ret = brcmf_usb_probe_cb(devinfo, id->driver_info);
 	if (ret)
 		goto fail;

@@ -1524,14 +1526,23 @@ static int brcmf_usb_reset_resume(struct
usb_interface *intf)
 	return ret;
 }

-#define BRCMF_USB_DEVICE(dev_id)	\
-	{ USB_DEVICE(BRCM_USB_VENDOR_ID_BROADCOM, dev_id) }
+#define BRCMF_USB_DEVICE(dev_id) \
+	{ \
+		USB_DEVICE(BRCM_USB_VENDOR_ID_BROADCOM, dev_id), \
+		.driver_info = BRCMF_FWVENDOR_WCC \
+	}

-#define LINKSYS_USB_DEVICE(dev_id)	\
-	{ USB_DEVICE(BRCM_USB_VENDOR_ID_LINKSYS, dev_id) }
+#define LINKSYS_USB_DEVICE(dev_id) \
+	{ \
+		USB_DEVICE(BRCM_USB_VENDOR_ID_LINKSYS, dev_id), \
+		.driver_info = BRCMF_FWVENDOR_WCC \
+	}

-#define CYPRESS_USB_DEVICE(dev_id)	\
-	{ USB_DEVICE(CY_USB_VENDOR_ID_CYPRESS, dev_id) }
+#define CYPRESS_USB_DEVICE(dev_id) \
+	{ \
+		USB_DEVICE(CY_USB_VENDOR_ID_CYPRESS, dev_id), \
+		.driver_info = BRCMF_FWVENDOR_WCC \
+	}

 static const struct usb_device_id brcmf_usb_devid_table[] = {
 	BRCMF_USB_DEVICE(BRCM_USB_43143_DEVICE_ID),
-- 
2.32.0
