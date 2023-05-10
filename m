Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786116FDB36
	for <lists+linux-wireless@lfdr.de>; Wed, 10 May 2023 12:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbjEJKBo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 May 2023 06:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbjEJKBl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 May 2023 06:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87A41BCF
        for <linux-wireless@vger.kernel.org>; Wed, 10 May 2023 03:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683712857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dJ4F6g28hq8D1nFIvqzmkMiK9sXqDGEezYdmUJFKfMw=;
        b=AMe5LPB+SKR/SPlRFQDqJtTvEgv9WvcLtdfmrwvsTws0TPqCL5APdse5qCtbIAgJImqOe+
        Z8ZNMD+r8ThZpzm0VEgT9ptO1TLykEy057GyqJ9OymbqHURNU7Ma0zYGY930XmRskmv972
        cSxygMr5Eo/NPwoyAcImflzuRzW0yfk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-iZ3bdhTnNHCYjCmBDjDpUQ-1; Wed, 10 May 2023 06:00:53 -0400
X-MC-Unique: iZ3bdhTnNHCYjCmBDjDpUQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44B03805F5A;
        Wed, 10 May 2023 10:00:53 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.195.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E07F4078906;
        Wed, 10 May 2023 10:00:51 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, regressions@lists.linux.dev,
        Felix <nimrod4garoa@gmail.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        stable@vger.kernel.org
Subject: [PATCH] wifi: brcmfmac: Check for probe() id argument being NULL
Date:   Wed, 10 May 2023 12:00:50 +0200
Message-Id: <20230510100050.27099-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The probe() id argument may be NULL in 2 scenarios:

1. brcmf_pcie_pm_leave_D3() calling brcmf_pcie_probe() to reprobe
   the device.

2. If a user tries to manually bind the driver from sysfs then the sdio /
   pcie / usb probe() function gets called with NULL as id argument.

1. Is being hit by users causing the following oops on resume and causing
wifi to stop working:

BUG: kernel NULL pointer dereference, address: 0000000000000018
<snip>
Hardware name: Dell Inc. XPS 13 9350/0PWNCR, BIDS 1.13.0 02/10/2020
Workgueue: events_unbound async_run_entry_fn
RIP: 0010:brcmf_pcie_probe+Ox16b/0x7a0 [brcmfmac]
<snip>
Call Trace:
 <TASK>
 brcmf_pcie_pm_leave_D3+0xc5/8x1a0 [brcmfmac be3b4cefca451e190fa35be8f00db1bbec293887]
 ? pci_pm_resume+0x5b/0xf0
 ? pci_legacy_resume+0x80/0x80
 dpm_run_callback+0x47/0x150
 device_resume+0xa2/0x1f0
 async_resume+0x1d/0x30
<snip>

Fix this by checking for id being NULL.

In the case of brcmf_pcie_probe() also add a manual lookup of the id
when it is NULL so that fwvid will still get set correctly on reprobe
on resume.

Fixes: da6d9c8ecd00 ("wifi: brcmfmac: add firmware vendor info in driver info")
Reported-by: Felix <nimrod4garoa@gmail.com>
Link: https://lore.kernel.org/regressions/4ef3f252ff530cbfa336f5a0d80710020fc5cb1e.camel@gmail.com/
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c   | 8 +++++++-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c    | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 65d4799a5658..833524bc9b50 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -1067,7 +1067,7 @@ static int brcmf_ops_sdio_probe(struct sdio_func *func,
 	sdiodev->bus_if = bus_if;
 	bus_if->bus_priv.sdio = sdiodev;
 	bus_if->proto_type = BRCMF_PROTO_BCDC;
-	bus_if->fwvid = id->driver_data;
+	bus_if->fwvid = id ? id->driver_data : BRCMF_FWVENDOR_INVALID;
 	dev_set_drvdata(&func->dev, bus_if);
 	dev_set_drvdata(&sdiodev->func1->dev, bus_if);
 	sdiodev->dev = &sdiodev->func1->dev;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index a9b9b2dc62d4..b29ab19d695d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -2339,6 +2339,9 @@ static void brcmf_pcie_debugfs_create(struct device *dev)
 }
 #endif
 
+/* Forward declaration for pci_match_id() call */
+static const struct pci_device_id brcmf_pcie_devid_table[];
+
 static int
 brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
@@ -2351,6 +2354,9 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	brcmf_dbg(PCIE, "Enter %x:%x\n", pdev->vendor, pdev->device);
 
+	if (!id)
+		id = pci_match_id(brcmf_pcie_devid_table, pdev);
+
 	ret = -ENOMEM;
 	devinfo = kzalloc(sizeof(*devinfo), GFP_KERNEL);
 	if (devinfo == NULL)
@@ -2406,7 +2412,7 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	bus->bus_priv.pcie = pcie_bus_dev;
 	bus->ops = &brcmf_pcie_bus_ops;
 	bus->proto_type = BRCMF_PROTO_MSGBUF;
-	bus->fwvid = id->driver_data;
+	bus->fwvid = id ? id->driver_data : BRCMF_FWVENDOR_INVALID;
 	bus->chip = devinfo->coreid;
 	bus->wowl_supported = pci_pme_capable(pdev, PCI_D3hot);
 	dev_set_drvdata(&pdev->dev, bus);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 246843aeb696..2541a47b1f8f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1425,7 +1425,7 @@ brcmf_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	else
 		brcmf_dbg(USB, "Broadcom full speed USB WLAN interface detected\n");
 
-	ret = brcmf_usb_probe_cb(devinfo, id->driver_info);
+	ret = brcmf_usb_probe_cb(devinfo, id ? id->driver_info : BRCMF_FWVENDOR_INVALID);
 	if (ret)
 		goto fail;
 
-- 
2.40.1

