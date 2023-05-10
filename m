Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA496FDFE0
	for <lists+linux-wireless@lfdr.de>; Wed, 10 May 2023 16:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbjEJOTz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 May 2023 10:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbjEJOTx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 May 2023 10:19:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5342B2D63
        for <linux-wireless@vger.kernel.org>; Wed, 10 May 2023 07:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683728344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=I3UrWSrzJKX0tjy3agppZnZNgX5U4BYubRWFY3jwDKM=;
        b=LC2xU6svgAKJCsd3X3nxtAoj47N3Qx2K9B3+NPI6kFqAjvCB5hCmH9gzD/DMAsGZkJ0zbf
        Du4dAhwmbZ+PV1Yc+dldfqsoOgUmfHFAdrsmSq92Ni3SXOR66S8iiw4R/wmNYsVthcasOs
        ifwTi4jCuSmTOm9yh8mf5+u1IBaqWH8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-77-EnOzf-MaOlSmgJT0Zd9HYg-1; Wed, 10 May 2023 10:19:00 -0400
X-MC-Unique: EnOzf-MaOlSmgJT0Zd9HYg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BD4C3C0ED58;
        Wed, 10 May 2023 14:18:59 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.195.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C11963F88;
        Wed, 10 May 2023 14:18:57 +0000 (UTC)
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
Subject: [PATCH v2] wifi: brcmfmac: Check for probe() id argument being NULL
Date:   Wed, 10 May 2023 16:18:56 +0200
Message-Id: <20230510141856.46532-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

In the PCI and USB cases try a manual lookup of the id so that manually
binding the driver through sysfs and more importantly brcmf_pcie_probe()
on resume will work.

For the SDIO case there is no helper to do a manual sdio_device_id lookup,
so just directly error out on a NULL id there.

Fixes: da6d9c8ecd00 ("wifi: brcmfmac: add firmware vendor info in driver info")
Reported-by: Felix <nimrod4garoa@gmail.com>
Link: https://lore.kernel.org/regressions/4ef3f252ff530cbfa336f5a0d80710020fc5cb1e.camel@gmail.com/
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Using BRCMF_FWVENDOR_INVALID will just lead to a probe() error later on,
  if NULL error out immediately instead of using BRCMF_FWVENDOR_INVALID.
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c |  5 +++++
 .../net/wireless/broadcom/brcm80211/brcmfmac/pcie.c   | 11 +++++++++++
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c    | 11 +++++++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 65d4799a5658..f06684f84789 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -1032,6 +1032,11 @@ static int brcmf_ops_sdio_probe(struct sdio_func *func,
 	struct brcmf_sdio_dev *sdiodev;
 	struct brcmf_bus *bus_if;
 
+	if (!id) {
+		dev_err(&func->dev, "Error no sdio_device_id passed for %x:%x\n", func->vendor, func->device);
+		return -ENODEV;
+	}
+
 	brcmf_dbg(SDIO, "Enter\n");
 	brcmf_dbg(SDIO, "Class=%x\n", func->class);
 	brcmf_dbg(SDIO, "sdio vendor ID: 0x%04x\n", func->vendor);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index a9b9b2dc62d4..d9ecaa0cfdc4 100644
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
@@ -2349,6 +2352,14 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct brcmf_core *core;
 	struct brcmf_bus *bus;
 
+	if (!id) {
+		id = pci_match_id(brcmf_pcie_devid_table, pdev);
+		if (!id) {
+			pci_err(pdev, "Error could not find pci_device_id for %x:%x\n", pdev->vendor, pdev->device);
+			return -ENODEV;
+		}
+	}
+
 	brcmf_dbg(PCIE, "Enter %x:%x\n", pdev->vendor, pdev->device);
 
 	ret = -ENOMEM;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 246843aeb696..2178675ae1a4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1331,6 +1331,9 @@ brcmf_usb_disconnect_cb(struct brcmf_usbdev_info *devinfo)
 	brcmf_usb_detach(devinfo);
 }
 
+/* Forward declaration for usb_match_id() call */
+static const struct usb_device_id brcmf_usb_devid_table[];
+
 static int
 brcmf_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
@@ -1342,6 +1345,14 @@ brcmf_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	u32 num_of_eps;
 	u8 endpoint_num, ep;
 
+	if (!id) {
+		id = usb_match_id(intf, brcmf_usb_devid_table);
+		if (!id) {
+			dev_err(&intf->dev, "Error could not find matching usb_device_id\n");
+			return -ENODEV;
+		}
+	}
+
 	brcmf_dbg(USB, "Enter 0x%04x:0x%04x\n", id->idVendor, id->idProduct);
 
 	devinfo = kzalloc(sizeof(*devinfo), GFP_ATOMIC);
-- 
2.40.1

