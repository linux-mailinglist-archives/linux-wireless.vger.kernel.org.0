Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAB1A6039
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 06:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfICE3z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 00:29:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35984 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfICE3y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 00:29:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id l20so139096ljj.3
        for <linux-wireless@vger.kernel.org>; Mon, 02 Sep 2019 21:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xd1Alt9j2r8DmeeHg4iVBf4lvIDi1nSctRfRervr+Wo=;
        b=hDrJSzrght0RtbDsgKpQzwdf8zXtvFc7siniMrTbkKoARcQwl6hhivgpVfKew2nQaQ
         lWSNZkkiK4E2OoqbdngLNg8BpklKxDDcex6sKgJ78zcc2CMiFI7mRk/4yKWJqJq3qzi/
         P4VYA/PMtqvbOVTWVrPLu1fuh30BGLH1tuNfvxQRJaGD2fBk1oYAmOxmS4IQpNRVuz0Y
         tzK5gX3ZtzSxrrcafasmYEBQsVLPhfQyNCC6TMBqLyoqQ4Ea8SrTOZdqEDxXOHKqaGcK
         GBFtvcTkvKFyGFXuj7uDlUpsIV9D127Uzafc/uVe/6UlOwYbJxnJ2fXxdQ89jBe9KlFi
         4W0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xd1Alt9j2r8DmeeHg4iVBf4lvIDi1nSctRfRervr+Wo=;
        b=tvC1FFFq2UuTV6Nap8Q024CMCSnlQZu2Nv85jrcLo2ZZCdgvoaRrxQaOg+RTZ06TuB
         zo6yv3Du0DLHztI1ZK6PUbDGb70RVZZSVCbxb0Hh2D9TKnkIlQFzvFRhO9Yvu5/XymaR
         KYkJZIvs+iAoQ1iNsSLQXnGPN4FZiSL9edg0SDbDxuf9+9kOS8Mb3td7KySw6KT+ZOlT
         8wQuTYCS30Mq674zK0xaBJs+YeqhztIWgxA7S7htwzOBSvjgJGbMdsf2PQ3irWnx3m++
         +W5YTVIl4TeGGplHeX6JCS/QE6YyxPTtnKgX8JBRVciqyWzdjZZTeEOT1ttiTb3brejS
         WWCg==
X-Gm-Message-State: APjAAAWjI5xbmgsNVnBzOtR9k/NarOZ6a8teYjPqDWxv5Tk94f1NpiJB
        +dkz97zU2QT/sJ7wGV8qjiw=
X-Google-Smtp-Source: APXvYqx33LDjbOavO2kg95NmURJDE1aNNjon2FMZZ9alALL6Rkp+EF69u3QxjEYuRDwPxhyAOwS7Lg==
X-Received: by 2002:a05:651c:292:: with SMTP id b18mr2035149ljo.131.1567484992191;
        Mon, 02 Sep 2019 21:29:52 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id d25sm2265125lfj.15.2019.09.02.21.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 21:29:51 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Winnie Chang <winnie.chang@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/3] brcmfmac: split brcmf_attach() and brcmf_detach() functions
Date:   Tue,  3 Sep 2019 06:29:27 +0200
Message-Id: <20190903042928.18621-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903042928.18621-1-zajec5@gmail.com>
References: <20190903042928.18621-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Move code allocating/freeing wiphy out of above functions. This will
allow reinitializing the driver (e.g. on some error) without allocating
a new wiphy.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../broadcom/brcm80211/brcmfmac/bus.h         |  4 ++-
 .../broadcom/brcm80211/brcmfmac/core.c        | 33 ++++++++++++++----
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 13 +++++--
 .../broadcom/brcm80211/brcmfmac/sdio.c        | 15 ++++++--
 .../broadcom/brcm80211/brcmfmac/usb.c         | 34 +++++++++++++++----
 5 files changed, 80 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
index 0988a166a785..623c0168da79 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
@@ -253,10 +253,12 @@ void brcmf_rx_frame(struct device *dev, struct sk_buff *rxp, bool handle_event);
 /* Receive async event packet from firmware. Callee disposes of rxp. */
 void brcmf_rx_event(struct device *dev, struct sk_buff *rxp);
 
+int brcmf_alloc(struct device *dev, struct brcmf_mp_device *settings);
 /* Indication from bus module regarding presence/insertion of dongle. */
-int brcmf_attach(struct device *dev, struct brcmf_mp_device *settings);
+int brcmf_attach(struct device *dev);
 /* Indication from bus module regarding removal/absence of dongle */
 void brcmf_detach(struct device *dev);
+void brcmf_free(struct device *dev);
 /* Indication from bus module that dongle should be reset */
 void brcmf_dev_reset(struct device *dev);
 /* Request from bus module to initiate a coredump */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index e8c488376ff9..406b367c284c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1209,13 +1209,11 @@ static int brcmf_bus_started(struct brcmf_pub *drvr, struct cfg80211_ops *ops)
 	return ret;
 }
 
-int brcmf_attach(struct device *dev, struct brcmf_mp_device *settings)
+int brcmf_alloc(struct device *dev, struct brcmf_mp_device *settings)
 {
 	struct wiphy *wiphy;
 	struct cfg80211_ops *ops;
 	struct brcmf_pub *drvr = NULL;
-	int ret = 0;
-	int i;
 
 	brcmf_dbg(TRACE, "Enter\n");
 
@@ -1233,6 +1231,21 @@ int brcmf_attach(struct device *dev, struct brcmf_mp_device *settings)
 	drvr = wiphy_priv(wiphy);
 	drvr->wiphy = wiphy;
 	drvr->ops = ops;
+	drvr->bus_if = dev_get_drvdata(dev);
+	drvr->bus_if->drvr = drvr;
+	drvr->settings = settings;
+
+	return 0;
+}
+
+int brcmf_attach(struct device *dev)
+{
+	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
+	struct brcmf_pub *drvr = bus_if->drvr;
+	int ret = 0;
+	int i;
+
+	brcmf_dbg(TRACE, "Enter\n");
 
 	for (i = 0; i < ARRAY_SIZE(drvr->if2bss); i++)
 		drvr->if2bss[i] = BRCMF_BSSIDX_INVALID;
@@ -1241,9 +1254,6 @@ int brcmf_attach(struct device *dev, struct brcmf_mp_device *settings)
 
 	/* Link to bus module */
 	drvr->hdrlen = 0;
-	drvr->bus_if = dev_get_drvdata(dev);
-	drvr->bus_if->drvr = drvr;
-	drvr->settings = settings;
 
 	/* Attach and link in the protocol */
 	ret = brcmf_proto_attach(drvr);
@@ -1259,7 +1269,7 @@ int brcmf_attach(struct device *dev, struct brcmf_mp_device *settings)
 	/* attach firmware event handler */
 	brcmf_fweh_attach(drvr);
 
-	ret = brcmf_bus_started(drvr, ops);
+	ret = brcmf_bus_started(drvr, drvr->ops);
 	if (ret != 0) {
 		bphy_err(drvr, "dongle is not responding: err=%d\n", ret);
 		goto fail;
@@ -1351,6 +1361,15 @@ void brcmf_detach(struct device *dev)
 		brcmf_cfg80211_detach(drvr->config);
 		drvr->config = NULL;
 	}
+}
+
+void brcmf_free(struct device *dev)
+{
+	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
+	struct brcmf_pub *drvr = bus_if->drvr;
+
+	if (!drvr)
+		return;
 
 	bus_if->drvr = NULL;
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 7ac945369762..b01b33e99c14 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -1430,6 +1430,7 @@ static int brcmf_pcie_reset(struct device *dev)
 	brcmf_pcie_bus_console_read(devinfo, true);
 
 	brcmf_detach(dev);
+	brcmf_free(dev);
 
 	brcmf_pcie_release_irq(devinfo);
 	brcmf_pcie_release_scratchbuffers(devinfo);
@@ -1824,11 +1825,18 @@ static void brcmf_pcie_setup(struct device *dev, int ret,
 
 	brcmf_pcie_intr_enable(devinfo);
 	brcmf_pcie_hostready(devinfo);
-	if (brcmf_attach(&devinfo->pdev->dev, devinfo->settings) == 0)
-		return;
+
+	ret = brcmf_alloc(&devinfo->pdev->dev, devinfo->settings);
+	if (ret)
+		goto fail;
+	ret = brcmf_attach(&devinfo->pdev->dev);
+	if (ret)
+		goto fail;
 
 	brcmf_pcie_bus_console_read(devinfo, false);
 
+	return;
+
 fail:
 	device_release_driver(dev);
 }
@@ -1971,6 +1979,7 @@ brcmf_pcie_remove(struct pci_dev *pdev)
 		brcmf_pcie_intr_disable(devinfo);
 
 	brcmf_detach(&pdev->dev);
+	brcmf_free(&pdev->dev);
 
 	kfree(bus->bus_priv.pcie);
 	kfree(bus->msgbuf->flowrings);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 629140b6d7e2..264ad63232f8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -4247,17 +4247,26 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
 	sdiod->bus_if->chip = bus->ci->chip;
 	sdiod->bus_if->chiprev = bus->ci->chiprev;
 
+	err = brcmf_alloc(sdiod->dev, sdiod->settings);
+	if (err) {
+		brcmf_err("brcmf_alloc failed\n");
+		goto claim;
+	}
+
 	/* Attach to the common layer, reserve hdr space */
-	err = brcmf_attach(sdiod->dev, sdiod->settings);
+	err = brcmf_attach(sdiod->dev);
 	if (err != 0) {
 		brcmf_err("brcmf_attach failed\n");
-		sdio_claim_host(sdiod->func1);
-		goto checkdied;
+		goto free;
 	}
 
 	/* ready */
 	return;
 
+free:
+	brcmf_free(sdiod->dev);
+claim:
+	sdio_claim_host(sdiod->func1);
 checkdied:
 	brcmf_sdio_checkdied(bus);
 release:
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index d33628b79a3a..06f3c01f10b3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1178,8 +1178,12 @@ static void brcmf_usb_probe_phase2(struct device *dev, int ret,
 	if (ret)
 		goto error;
 
+	ret = brcmf_alloc(devinfo->dev, devinfo->settings);
+	if (ret)
+		goto error;
+
 	/* Attach to the common driver interface */
-	ret = brcmf_attach(devinfo->dev, devinfo->settings);
+	ret = brcmf_attach(devinfo->dev);
 	if (ret)
 		goto error;
 
@@ -1251,7 +1255,10 @@ static int brcmf_usb_probe_cb(struct brcmf_usbdev_info *devinfo)
 	}
 
 	if (!brcmf_usb_dlneeded(devinfo)) {
-		ret = brcmf_attach(devinfo->dev, devinfo->settings);
+		ret = brcmf_alloc(devinfo->dev, devinfo->settings);
+		if (ret)
+			goto fail;
+		ret = brcmf_attach(devinfo->dev);
 		if (ret)
 			goto fail;
 		/* we are done */
@@ -1279,6 +1286,7 @@ static int brcmf_usb_probe_cb(struct brcmf_usbdev_info *devinfo)
 
 fail:
 	/* Release resources in reverse order */
+	brcmf_free(devinfo->dev);
 	kfree(bus);
 	brcmf_usb_detach(devinfo);
 	return ret;
@@ -1292,6 +1300,7 @@ brcmf_usb_disconnect_cb(struct brcmf_usbdev_info *devinfo)
 	brcmf_dbg(USB, "Enter, bus_pub %p\n", devinfo);
 
 	brcmf_detach(devinfo->dev);
+	brcmf_free(devinfo->dev);
 	kfree(devinfo->bus_pub.bus);
 	brcmf_usb_detach(devinfo);
 }
@@ -1435,10 +1444,12 @@ static int brcmf_usb_suspend(struct usb_interface *intf, pm_message_t state)
 
 	brcmf_dbg(USB, "Enter\n");
 	devinfo->bus_pub.state = BRCMFMAC_USB_STATE_SLEEP;
-	if (devinfo->wowl_enabled)
+	if (devinfo->wowl_enabled) {
 		brcmf_cancel_all_urbs(devinfo);
-	else
+	} else {
 		brcmf_detach(&usb->dev);
+		brcmf_free(&usb->dev);
+	}
 	return 0;
 }
 
@@ -1451,8 +1462,19 @@ static int brcmf_usb_resume(struct usb_interface *intf)
 	struct brcmf_usbdev_info *devinfo = brcmf_usb_get_businfo(&usb->dev);
 
 	brcmf_dbg(USB, "Enter\n");
-	if (!devinfo->wowl_enabled)
-		return brcmf_attach(devinfo->dev, devinfo->settings);
+	if (!devinfo->wowl_enabled) {
+		int err;
+
+		err = brcmf_alloc(&usb->dev, devinfo->settings);
+		if (err)
+			return err;
+
+		err = brcmf_attach(devinfo->dev);
+		if (err) {
+			brcmf_free(devinfo->dev);
+			return err;
+		}
+	}
 
 	devinfo->bus_pub.state = BRCMFMAC_USB_STATE_UP;
 	brcmf_usb_rx_fill_all(devinfo);
-- 
2.21.0

