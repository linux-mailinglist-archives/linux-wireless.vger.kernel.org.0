Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F87963C17F
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 14:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiK2NzQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 08:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbiK2NzO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 08:55:14 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E151902A
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 05:55:13 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m19so1804931wms.5
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 05:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uWEPaxoW5sXbNlBClO+kI3fqkCDBEdqSZCIrabN9Ayc=;
        b=MDm6p1QdUlBmutqGmRytxUvyXEuxz1mLKfcckwOQpRm+tLqjuLwNS1R//Gdi+ArEpu
         uY9zju44iBXA+cjndxwU9o2ESI7i4HU6IMBNE0sXHG9cKgC2Jl3P0riHQhB6ZOYBbOIl
         pYlBQDYr5cgxR+jatImxLOIRcnlY62jLeKS2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uWEPaxoW5sXbNlBClO+kI3fqkCDBEdqSZCIrabN9Ayc=;
        b=gDvkhfY7HKWjnzUMoa3L6wbPuoXDteXZNhVDCB+Blp3ha7iq77IalWucYktl9cxzSc
         xXBt8kd+YVIccmxs9itacamHEtF6ozWyMVWS9oHFKKq3WcHDw1U6Wh/AJY9gwcBpeiPz
         X7w+adw/N4Zw1psIHoqsuZ9K4AtL3l5SJW6GV++HJLrgcUTU35Ne/u5/iuzfIbnP5Lkc
         Fl/TDlIcyxZmCpb9N2VrN1M7Q4+WkKCFRSddl1v0zsz3B+Smnl5B4uYvvYtNSmC3Pe90
         49tINBZDq8iv51JkDOk3OJAtUKoAdAeN9BEg8VOzD3AFqJdIec+wfz1bCvPi9DjqBcnQ
         8erg==
X-Gm-Message-State: ANoB5pmw+7cFLX7QQ/wmWCcS7f2v5keFQ76sVZWLAVwLOrwsBtfTunmt
        NCXTM0jyrCw1sBdfj/L16chAqg==
X-Google-Smtp-Source: AA0mqf6qlS3pAxiREjCXoxCQQhaIUmdv4fGezeVlJ1pugK9N1zobuGfUN92BXNC+F+nCgX/r19d4tA==
X-Received: by 2002:a7b:cbc3:0:b0:3cf:a83d:28d1 with SMTP id n3-20020a7bcbc3000000b003cfa83d28d1mr45889026wmi.57.1669730111586;
        Tue, 29 Nov 2022 05:55:11 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.com ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id hn25-20020a05600ca39900b003b4935f04a4sm2472005wmb.5.2022.11.29.05.55.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2022 05:55:10 -0800 (PST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>
Subject: [PATCH V2 2/7] brcmfmac: add firmware vendor info in driver info
Date:   Tue, 29 Nov 2022 14:54:41 +0100
Message-Id: <20221129135446.151065-3-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221129135446.151065-1-arend.vanspriel@broadcom.com>
References: <20221129135446.151065-1-arend.vanspriel@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002f1e2105ee9c56e4"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--0000000000002f1e2105ee9c56e4
Content-Transfer-Encoding: 8bit

In order to determine the vendor that released a firmware image for
a specific device, the device table now sets the vendor identifier
in driver info and it is stored in struct brcmf_bus::fwvid during
probe.

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

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index d0daef674e72..fa919432b1c6 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -960,7 +960,10 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 }
 
 #define BRCMF_SDIO_DEVICE(dev_id)	\
-	{SDIO_DEVICE(SDIO_VENDOR_ID_BROADCOM, dev_id)}
+	{ \
+		SDIO_DEVICE(SDIO_VENDOR_ID_BROADCOM, dev_id), \
+		.driver_data = BRCMF_FWVENDOR_WCC \
+	}
 
 /* devices we support, null terminated */
 static const struct sdio_device_id brcmf_sdmmc_ids[] = {
@@ -1051,6 +1054,7 @@ static int brcmf_ops_sdio_probe(struct sdio_func *func,
 	sdiodev->bus_if = bus_if;
 	bus_if->bus_priv.sdio = sdiodev;
 	bus_if->proto_type = BRCMF_PROTO_BCDC;
+	bus_if->fwvid = id->driver_data;
 	dev_set_drvdata(&func->dev, bus_if);
 	dev_set_drvdata(&sdiodev->func1->dev, bus_if);
 	sdiodev->dev = &sdiodev->func1->dev;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
index 256456e38108..79fe0a49471c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
@@ -31,6 +31,13 @@
 /* The maximum console interval value (5 mins) */
 #define MAX_CONSOLE_INTERVAL	(5 * 60)
 
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
@@ -144,9 +151,10 @@ struct brcmf_bus_stats {
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
@@ -163,6 +171,7 @@ struct brcmf_bus {
 	uint maxctl;
 	u32 chip;
 	u32 chiprev;
+	enum brcmf_fwvendor fwvid;
 	bool always_use_fws_queue;
 	bool wowl_supported;
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index cf564adc612a..094bb84ed72f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -2389,6 +2389,7 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	bus->bus_priv.pcie = pcie_bus_dev;
 	bus->ops = &brcmf_pcie_bus_ops;
 	bus->proto_type = BRCMF_PROTO_MSGBUF;
+	bus->fwvid = id->driver_data;
 	bus->chip = devinfo->coreid;
 	bus->wowl_supported = pci_pme_capable(pdev, PCI_D3hot);
 	dev_set_drvdata(&pdev->dev, bus);
@@ -2570,11 +2571,20 @@ static const struct dev_pm_ops brcmf_pciedrvr_pm = {
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
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 85e18fb9c497..246843aeb696 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1240,7 +1240,8 @@ brcmf_usb_prepare_fw_request(struct brcmf_usbdev_info *devinfo)
 	return fwreq;
 }
 
-static int brcmf_usb_probe_cb(struct brcmf_usbdev_info *devinfo)
+static int brcmf_usb_probe_cb(struct brcmf_usbdev_info *devinfo,
+			      enum brcmf_fwvendor fwvid)
 {
 	struct brcmf_bus *bus = NULL;
 	struct brcmf_usbdev *bus_pub = NULL;
@@ -1265,6 +1266,7 @@ static int brcmf_usb_probe_cb(struct brcmf_usbdev_info *devinfo)
 	dev_set_drvdata(dev, bus);
 	bus->ops = &brcmf_usb_bus_ops;
 	bus->proto_type = BRCMF_PROTO_BCDC;
+	bus->fwvid = fwvid;
 	bus->always_use_fws_queue = true;
 #ifdef CONFIG_PM
 	bus->wowl_supported = true;
@@ -1423,7 +1425,7 @@ brcmf_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	else
 		brcmf_dbg(USB, "Broadcom full speed USB WLAN interface detected\n");
 
-	ret = brcmf_usb_probe_cb(devinfo);
+	ret = brcmf_usb_probe_cb(devinfo, id->driver_info);
 	if (ret)
 		goto fail;
 
@@ -1511,14 +1513,23 @@ static int brcmf_usb_reset_resume(struct usb_interface *intf)
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
2.35.1


--0000000000002f1e2105ee9c56e4
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCDxwhTuiIaWi7pfnBU
dqLocgnQxUZ9IyCuUkMieTRKLTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMjExMjkxMzU1MTFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAP7z3vgmI91jLqjyFYx3u8dwKRLf0AhGPtFjh
8JoDLvoPqhjYH40/jXUlCVcWIYphQHGmSJmi8bwA6YeFF3Bccl9EWlaRsaz78PPw4IEPxYdhLPLc
h8un3cydXUDvm9SY0aKXo0XCfKxG9bT2uBYZEQTGEHybSaWn3wtVMEwRZzsWcgJesG43AyL4Urpy
KNgei4crQf5lUIpBTBvwmQZt6jEMx0EcnPKbz30KJlMcySIKesBK3ADbvK5saNoklXsi8LX63fFw
Lski7Zc7q51B4ma1FAHGAGJTTwG8qlX4VA7J+edRa5uPtVlHw5hQK7rLxLXQXsmPtrs8UF+emx7O
0A==
--0000000000002f1e2105ee9c56e4--
