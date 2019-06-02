Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB333235A
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jun 2019 15:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfFBNOz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Jun 2019 09:14:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50877 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfFBNOz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Jun 2019 09:14:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id f204so4787869wme.0
        for <linux-wireless@vger.kernel.org>; Sun, 02 Jun 2019 06:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gOITcy/fdy6OHEDbFzENuJ6XVLHHJ9AGoZ/Z5jtBUTk=;
        b=sumiE6SRj/FGuaLScUAT2GAYG/8KdAbGIzm8rCYCIXvWM1m06dayD3m8elPgBqR3dT
         QyMUbeW6bv0ysGQjbSBHe2jP/WY2TqOYqUt8VDj5r1WEAZUk0/dtqwCxCe4lonnra90f
         QpLPp/a6weCB9GztjZX/LMhmQZKTZWFznz8de0J1dJgOfLsg7B813VNxC1DvMvpEwxJL
         AXjTnrpnZFwGpUJMECMB5w+HMiBVLp/41+g+oaRv/89QeafAEo44wTWR4uqPAshGzhq8
         Ap+RJLRadL8lUEdk80qlPp9MRDDFjMkqEIJoWFnkXLoYBihhgKcF/Hkp61wDTgRLmp6T
         k9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gOITcy/fdy6OHEDbFzENuJ6XVLHHJ9AGoZ/Z5jtBUTk=;
        b=TI4sXiCUzOhw6V+gJVBdfNjPMY4Nqh5BO1Ikbv452aKSh+NLiX2XtJv4WxvDwtp1Ss
         xNn6a8gHZst7XNdmC4PUMCCQ6wk3A6maU7yIeKYKbionFn3wbZDnPiyLwTp/2/F0Bw5w
         c/YGogzrHj0fn2T6kfZmQMYNtuGqnKFth0StEkaOLuZLxXPK1+CgBMA4WjcV8+4TW8jj
         b5icPzy0jjyIRdjHKMM6cl8vuPUdEMMiZEuq/tot4GPzO334iaaHDWUHWkNZoIBMLKIG
         P4u4sTPxRzIkdxHrfVo4wZS4GT4GmIWmXH8oZSCXHMs+H0lQ9jCvA47ZCfsyMktwlycn
         7cQA==
X-Gm-Message-State: APjAAAWgNkOc4e0R5gwXCLrHAq20xOV4IOUy7Zlq5cFgtX/DrqzQHDzZ
        IgoTPW5RsRDuW+q4d/7TeG4=
X-Google-Smtp-Source: APXvYqx1kxSaJybr8WVe+7fNsclioCHmqON2h8ypaIx241YfUy2c3q77lqgH3/ZjwSbVG7FpTE2YkA==
X-Received: by 2002:a1c:ca06:: with SMTP id a6mr11335830wmg.48.1559481291974;
        Sun, 02 Jun 2019 06:14:51 -0700 (PDT)
Received: from debian64.daheim (p4FD09A91.dip0.t-ipconnect.de. [79.208.154.145])
        by smtp.gmail.com with ESMTPSA id e15sm8804289wme.0.2019.06.02.06.14.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 06:14:51 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
        by debian64.daheim with esmtp (Exim 4.92)
        (envelope-from <chunkeey@gmail.com>)
        id 1hXQK2-0005mU-FU; Sun, 02 Jun 2019 15:14:50 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     Julian Calaby <julian.calaby@gmail.com>
Cc:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        linux-wireless@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [RFC PATCH] ath9k: integrate AR92XX pci fixup code
Date:   Sun, 02 Jun 2019 15:14:50 +0200
Message-ID: <2349614.IEgcWBM518@debian64>
In-Reply-To: <CAGRGNgXqB=5oi1Nq4ZNSk3csOEr4A6WgN8QymKMriTcevnKUQw@mail.gmail.com>
References: <20190602102144.17360-1-chunkeey@gmail.com> <CAGRGNgXqB=5oi1Nq4ZNSk3csOEr4A6WgN8QymKMriTcevnKUQw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Julian,

On Sunday, June 2, 2019 1:43:52 PM CEST Julian Calaby wrote:
> On Sun, Jun 2, 2019 at 8:24 PM Christian Lamparter <chunkeey@gmail.com> wrote:
> >
> > Some devices (like the Cisco Meraki Z1 Cloud Managed Teleworker Gateway)
> > need to be able to initialize the PCIe wifi device. Normally, this is done
> > during the early stages of booting linux, because the necessary init code
> > is read from the memory mapped SPI and passed to pci_enable_ath9k_fixup.
> > However, this isn't possible for devices which have the init code for the
> > Atheros chip stored on NAND in an UBI volume. Hence, this module can be
> > used to initialize the chip when the user-space is ready to extract the
> > init code.
> >
> > Martin Blumenstingl prodived the following fixes:
> > owl-loader: add support for OWL emulation PCI devices
> > owl-loader: don't re-scan the bus when ath9k_pci_fixup failed
> > owl-loader: use dev_* instead of pr_* logging functions
> > owl-loader: auto-generate the eeprom filename as fallback
> > owl-loader: add a debug message when swapping the eeprom data
> > owl-loader: add missing newlines in log messages
> >
> > Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Two questions:
> 
> 1. This seems complicated enough that the functions introduced should
> probably go into a separate .c file, maybe "noeeprom.c", with a header
> file with all the ifdef / config magic in it.

In openwrt we called it owl-loader.c and it's a separate module there.
But I don't think that noeeprom.c is that great since ath9k also supports
AHB and htc_usb, so from this perspective it would mean:
pci_init_noeeprom.c ? (As AR5008, AR9160 and AR92XX seem to be affected). 

> 2. This smells almost like a completely separate PCI(e) driver for
> cards in a "weird" state.
It's in the Datasheet that the device initializes into this state. See
AR9280 6.1.2 DEVICE_ID. "... if the EEPROM content is not valid, a 
value of 0XFF1C returns when read from the register". This would also
mean that this routine can be used to resurrect aging AR9280 cards
that have a failed eeprom or are from APPLE, see this thread:

<https://www.mail-archive.com/ath9k-devel@lists.ath9k.org/msg03918.html>

"does anyone know whether 168c:ff1c can be supported by the current ath9k
driver? It isn't listed with the PCI IDs in the source. I bought it off
eBay as "Apple" AR5008. It is a PCI Express card with 3 Antenna
connectors and lots of Apple stampings on it. lspci says:"

> Is there anything you're using from ath9k
> other than the eeprom file naming? and is that really useful? Won't
> the eeprom files be device specific and therefore could always use the
> device name fallback?
Please take a look at the commit message. Unfortunately the Z1 stores
its calibration data in a ubi volume, these can't be easily read
without interfacing with either ubi or the vfs. In the future, simpler
devices that have it on SPI-NOR in a mtd partition can setup a nvmem
provider and the code can have a nvmem-consumer. (see attached patch).

Note: There are also devices with mutliple ath9k pci(e) chips
(usually one 2.4Ghz and one 5GHz), so a generic "ath9k" name is too
short and the pciids of both are the same. That's why the pci-bus
location is currently used for the eeprom name identifier.

Regards,
Christian

---

Note: nvmem dts is not finalized. See

commit 517f14d9cf3533d5ab4fded195ab6f80a92e378f
Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri Nov 30 11:53:25 2018 +0000

    nvmem: add new config option

for details why adding something like this unfinished patch
just does not makes sense (yet).

--- a/drivers/net/wireless/ath/ath9k/pci.c
+++ b/drivers/net/wireless/ath/ath9k/pci.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/completion.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/ath9k_platform.h>
 #include "ath9k.h"
 #include "eeprom.h"
@@ -1053,6 +1054,7 @@ static int ath_pci_fixup_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
 	struct ath_pci_fixup_ctx *ctx;
+	struct nvmem_cell *cell;
 	const char *eeprom_name;
 	int err = 0;
 
@@ -1062,6 +1064,21 @@ static int ath_pci_fixup_probe(struct pci_dev *pdev,
 
 	pcim_pin_device(pdev);
 
+	cell = nvmem_cell_get(&pdev->dev, "caldata");
+	if (!IS_ERR(cell)) {
+		void *value;
+		size_t len;
+
+		value = nvmem_cell_read(cell, &len);
+		if (!IS_ERR(value)) {
+			err = ath_pci_fixup(pdev, value, len);
+			kfree(value);
+		} else
+			err = -EINVAL;
+		nvmem_cell_put(cell);
+		return err;
+	}
+
 	eeprom_name = ath_pci_fixup_get_eeprom_name(pdev);
 	if (!eeprom_name) {
 		dev_err(&pdev->dev, "no eeprom filename found.\n");




