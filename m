Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15F4E3A050
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jun 2019 16:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfFHOtw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Jun 2019 10:49:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41255 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfFHOtw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Jun 2019 10:49:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so4904042wrm.8;
        Sat, 08 Jun 2019 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eWOdxQrFr4RFjEMoqWRjZksTgoTUFpfXgF0kmiG4tnM=;
        b=QcE4ndQ8B18fmQ/brgW3sdTEjoYggt6GmVVYw+M4eUQT5SNjOOkc9cqyiwMx/aFryD
         wX17evhox8dJ48qCvOrutZ6OXXbg5VNgZ156xUIkcQYS9fbpCP3VdVmSbuhQ0uHdvfq6
         Ela9tp//984on3j3qUfoCPtPijRvd1lvETdh/6NOSl+ntHILYaCC0KW5Eug4MJ70FHWc
         8GgIVIFAFu2eXm8bzFcga2WJuOtsW1IMVU/Ou6ZjOnB1XWtlccY0DxnjW7xKySTctVFW
         awbUBZsCJ4Ga6DqMr+Izqehf9VCPWJnOqyO5nIGAQM6A76IXenaYMKpLECUHT3AOE1A3
         JDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eWOdxQrFr4RFjEMoqWRjZksTgoTUFpfXgF0kmiG4tnM=;
        b=d0i6SB16wSMghCHNVrqP3QEg1CMlf7Rd3HQoMgsuYiFf+oMWPeDGvfivbORWJ+Kvm/
         TvVJYrQFI3x6PIFhsDAaDCrt0NB0Un9Kkk/7zSkjRras1xwD+MV+HscMeGfo7mrebXXM
         Kg0glC9rvU7J6+TJZ2BIMg1jjfu6mcuj0deIgTa0dhWC3iAVqqDiHEERbiLLmLWV5h3j
         iRqkqTiXNO987GxVStOENVQ91QrogwfnUgxyRX2S3hMXRwzJid+k5HA4ywKZo0EILY/o
         1RAs/5e0+hzuL9vPHQ6AdyozdX1ePV8uFjOUWtwj6VqEeTCEUk65V3KqdaE8iPwfZWpA
         IkKw==
X-Gm-Message-State: APjAAAUsTFrXke+6GuBnmyBSlbZgGKkDn4vXLjEJ+STjxCUAkCyTTned
        bjN4WFHW/D/hGjGvXPhZ5lU4wO9s
X-Google-Smtp-Source: APXvYqw1h4EYjbXpyqb4DFtM0Mb3nKNri2gXI9/A7BX0grqWAUM3+TB0cwu8a1B2RXqoIp0bsU//hA==
X-Received: by 2002:adf:efc8:: with SMTP id i8mr9774465wrp.220.1560005388831;
        Sat, 08 Jun 2019 07:49:48 -0700 (PDT)
Received: from debian64.daheim (p5B0D753E.dip0.t-ipconnect.de. [91.13.117.62])
        by smtp.gmail.com with ESMTPSA id j132sm9691200wmj.21.2019.06.08.07.49.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 07:49:48 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.92)
        (envelope-from <chunkeey@gmail.com>)
        id 1hZcfD-0000Cv-F2; Sat, 08 Jun 2019 16:49:47 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH v2] carl9170: fix misuse of device driver API
Date:   Sat,  8 Jun 2019 16:49:47 +0200
Message-Id: <20190608144947.744-3-chunkeey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608144947.744-1-chunkeey@gmail.com>
References: <20190608144947.744-1-chunkeey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch follows Alan Stern's recent patch:
"p54: Fix race between disconnect and firmware loading"

that overhauled carl9170 buggy firmware loading and driver
unbinding procedures.

Since the carl9170 code was adapted from p54 it uses the
same functions and is likely to have the same problem, but
it's just that the syzbot hasn't reproduce them (yet).

a summary from the changes (copied from the p54 patch):
 * Call usb_driver_release_interface() rather than
   device_release_driver().

 * Lock udev (the interface's parent) before unbinding the
   driver instead of locking udev->parent.

 * During the firmware loading process, take a reference
   to the USB interface instead of the USB device.

 * Don't take an unnecessary reference to the device during
   probe (and then don't drop it during disconnect).

and

 * Make sure to prevent use-after-free bugs by explicitly
   setting the driver context to NULL after signaling the
   completion.

Cc: <stable@vger.kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
v2: Alan Stern's comments
  - fixed possible use-after-free
---
 drivers/net/wireless/ath/carl9170/usb.c | 39 +++++++++++--------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/usb.c b/drivers/net/wireless/ath/carl9170/usb.c
index e7c3f3b8457d..99f1897a775d 100644
--- a/drivers/net/wireless/ath/carl9170/usb.c
+++ b/drivers/net/wireless/ath/carl9170/usb.c
@@ -128,6 +128,8 @@ static const struct usb_device_id carl9170_usb_ids[] = {
 };
 MODULE_DEVICE_TABLE(usb, carl9170_usb_ids);
 
+static struct usb_driver carl9170_driver;
+
 static void carl9170_usb_submit_data_urb(struct ar9170 *ar)
 {
 	struct urb *urb;
@@ -966,32 +968,28 @@ static int carl9170_usb_init_device(struct ar9170 *ar)
 
 static void carl9170_usb_firmware_failed(struct ar9170 *ar)
 {
-	struct device *parent = ar->udev->dev.parent;
-	struct usb_device *udev;
-
-	/*
-	 * Store a copy of the usb_device pointer locally.
-	 * This is because device_release_driver initiates
-	 * carl9170_usb_disconnect, which in turn frees our
-	 * driver context (ar).
+	/* Store a copies of the usb_interface and usb_device pointer locally.
+	 * This is because release_driver initiates carl9170_usb_disconnect,
+	 * which in turn frees our driver context (ar).
 	 */
-	udev = ar->udev;
+	struct usb_interface *intf = ar->intf;
+	struct usb_device *udev = ar->udev;
 
 	complete(&ar->fw_load_wait);
+	/* at this point 'ar' could be already freed. Don't use it anymore */
+	ar = NULL;
 
 	/* unbind anything failed */
-	if (parent)
-		device_lock(parent);
-
-	device_release_driver(&udev->dev);
-	if (parent)
-		device_unlock(parent);
+	usb_lock_device(udev);
+	usb_driver_release_interface(&carl9170_driver, intf);
+	usb_unlock_device(udev);
 
-	usb_put_dev(udev);
+	usb_put_intf(intf);
 }
 
 static void carl9170_usb_firmware_finish(struct ar9170 *ar)
 {
+	struct usb_interface *intf = ar->intf;
 	int err;
 
 	err = carl9170_parse_firmware(ar);
@@ -1009,7 +1007,7 @@ static void carl9170_usb_firmware_finish(struct ar9170 *ar)
 		goto err_unrx;
 
 	complete(&ar->fw_load_wait);
-	usb_put_dev(ar->udev);
+	usb_put_intf(intf);
 	return;
 
 err_unrx:
@@ -1052,7 +1050,6 @@ static int carl9170_usb_probe(struct usb_interface *intf,
 		return PTR_ERR(ar);
 
 	udev = interface_to_usbdev(intf);
-	usb_get_dev(udev);
 	ar->udev = udev;
 	ar->intf = intf;
 	ar->features = id->driver_info;
@@ -1094,15 +1091,14 @@ static int carl9170_usb_probe(struct usb_interface *intf,
 	atomic_set(&ar->rx_anch_urbs, 0);
 	atomic_set(&ar->rx_pool_urbs, 0);
 
-	usb_get_dev(ar->udev);
+	usb_get_intf(intf);
 
 	carl9170_set_state(ar, CARL9170_STOPPED);
 
 	err = request_firmware_nowait(THIS_MODULE, 1, CARL9170FW_NAME,
 		&ar->udev->dev, GFP_KERNEL, ar, carl9170_usb_firmware_step2);
 	if (err) {
-		usb_put_dev(udev);
-		usb_put_dev(udev);
+		usb_put_intf(intf);
 		carl9170_free(ar);
 	}
 	return err;
@@ -1131,7 +1127,6 @@ static void carl9170_usb_disconnect(struct usb_interface *intf)
 
 	carl9170_release_firmware(ar);
 	carl9170_free(ar);
-	usb_put_dev(udev);
 }
 
 #ifdef CONFIG_PM
-- 
2.20.1

