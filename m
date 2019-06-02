Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2E92322C4
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jun 2019 11:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfFBJG0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Jun 2019 05:06:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53978 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfFBJG0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Jun 2019 05:06:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id d17so848633wmb.3;
        Sun, 02 Jun 2019 02:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cUgqrtnNCrNgdH7RxnKnTZ25cFkzrfwXIvqrOhjb+M4=;
        b=Uhyl95P2agOSqF7eBT1Vvacwh9DYD9gATseg0PHZX9sR9+9MVu1OwK0hPUPmghxVkZ
         WQvJiYBzUgHnhtlV/4poTCFRJfhGg36E+VfzMKfb3gRTpxtcUzk1XVitnYxgZBwksTtf
         Bliwyial7RvN+7tIkDu12+HALc+Mf3z3MVtTc/KKRJQNV3DNnHPSoS553oFnrF8LuriR
         U3GkIYlTt1n7hPVaghQ5rXdtJ6vwpHpUrnfhs5jZ0vFA+Hb3MpbM3xHUfxrDp+ZnNGBH
         AylD2D72OQg73HhCitnak4qoF5EKstSwUHFVjA/PC4n9mODPSrBLRMoEo2bVIk1RWDjt
         pzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cUgqrtnNCrNgdH7RxnKnTZ25cFkzrfwXIvqrOhjb+M4=;
        b=Csh3Lksvmbu2kp8BNdO3D4NsIQ+4m39ImZlU+4PXccgCGljWtPpYLcz5NhUYcozeqK
         RPKeJOs+Y7UhkZ8wN97vUTsWp0KAHKI8myhf/W3nhRWYnIFwXQVeKZe2pDsXydUqf19I
         Us1ZgtLV0ugD8k/9TNfA7z1B/8N4ENIfOcAlfQ2WjpTy6vhzwmeTKQ/FwjwHyN7rfyoc
         Rrk4UBGDoeThftddTURx/NcdeDEpVX/ZSC91iz/zKjY3lmf/TaPFVJHj9Pa+GB3Lxw3e
         s7yqEgJAXClYlTzgNFhqK0KtakkfXVZ4vn18UyUxN/y+hJBayg/bf0yo9diXKJsFBj0B
         ZxVA==
X-Gm-Message-State: APjAAAWiCSQnIpU1sPsy4RZFHLrOBF1UHvFUaXLng4AwtKEagPHKE8X9
        wtqUJFWk7A6TEbdxXkPXwsdYIXPm
X-Google-Smtp-Source: APXvYqxPJbtNd2bKWTeZcQQ+oJpbcmUNpfCyWLpAGGD/MtvV1+7Spbs5RufNg0j1iiCSBsNxQN6A4w==
X-Received: by 2002:a1c:7e8d:: with SMTP id z135mr10590160wmc.72.1559466383914;
        Sun, 02 Jun 2019 02:06:23 -0700 (PDT)
Received: from debian64.daheim (p4FD09A91.dip0.t-ipconnect.de. [79.208.154.145])
        by smtp.gmail.com with ESMTPSA id k2sm19186735wrg.41.2019.06.02.02.06.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 02:06:23 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.92)
        (envelope-from <chunkeey@gmail.com>)
        id 1hXMRa-0003Z0-8p; Sun, 02 Jun 2019 11:06:22 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        USB list <linux-usb@vger.kernel.org>
Subject: [PATCH] carl9170: Fix misuse of device driver API
Date:   Sun,  2 Jun 2019 11:06:22 +0200
Message-Id: <20190602090622.13656-1-chunkeey@gmail.com>
X-Mailer: git-send-email 2.20.1
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
 drivers/net/wireless/ath/carl9170/usb.c | 26 ++++++++++++-------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/usb.c b/drivers/net/wireless/ath/carl9170/usb.c
index e7c3f3b8457d..297a7b877d31 100644
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
@@ -966,7 +968,7 @@ static int carl9170_usb_init_device(struct ar9170 *ar)
 
 static void carl9170_usb_firmware_failed(struct ar9170 *ar)
 {
-	struct device *parent = ar->udev->dev.parent;
+	struct usb_interface *intf = ar->intf;
 	struct usb_device *udev;
 
 	/*
@@ -978,16 +980,15 @@ static void carl9170_usb_firmware_failed(struct ar9170 *ar)
 	udev = ar->udev;
 
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
@@ -1009,7 +1010,7 @@ static void carl9170_usb_firmware_finish(struct ar9170 *ar)
 		goto err_unrx;
 
 	complete(&ar->fw_load_wait);
-	usb_put_dev(ar->udev);
+	usb_put_intf(ar->intf);
 	return;
 
 err_unrx:
@@ -1052,7 +1053,6 @@ static int carl9170_usb_probe(struct usb_interface *intf,
 		return PTR_ERR(ar);
 
 	udev = interface_to_usbdev(intf);
-	usb_get_dev(udev);
 	ar->udev = udev;
 	ar->intf = intf;
 	ar->features = id->driver_info;
@@ -1094,15 +1094,14 @@ static int carl9170_usb_probe(struct usb_interface *intf,
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
@@ -1131,7 +1130,6 @@ static void carl9170_usb_disconnect(struct usb_interface *intf)
 
 	carl9170_release_firmware(ar);
 	carl9170_free(ar);
-	usb_put_dev(udev);
 }
 
 #ifdef CONFIG_PM
-- 
2.20.1

