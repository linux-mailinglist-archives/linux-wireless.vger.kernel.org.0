Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 803F7331C2
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2019 16:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfFCOKr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Jun 2019 10:10:47 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46190 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728253AbfFCOKr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Jun 2019 10:10:47 -0400
Received: (qmail 1758 invoked by uid 2102); 3 Jun 2019 10:10:46 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Jun 2019 10:10:46 -0400
Date:   Mon, 3 Jun 2019 10:10:46 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Christian Lamparter <chunkeey@gmail.com>
cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] carl9170: Fix misuse of device driver API
In-Reply-To: <20190602090622.13656-1-chunkeey@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1906031007450.1547-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2 Jun 2019, Christian Lamparter wrote:

> This patch follows Alan Stern's recent patch:
> "p54: Fix race between disconnect and firmware loading"
> 
> that overhauled carl9170 buggy firmware loading and driver
> unbinding procedures.
> 
> Since the carl9170 code was adapted from p54 it uses the
> same functions and is likely to have the same problem, but
> it's just that the syzbot hasn't reproduce them (yet).
> 
> a summary from the changes (copied from the p54 patch):
>  * Call usb_driver_release_interface() rather than
>    device_release_driver().
> 
>  * Lock udev (the interface's parent) before unbinding the
>    driver instead of locking udev->parent.
> 
>  * During the firmware loading process, take a reference
>    to the USB interface instead of the USB device.
> 
>  * Don't take an unnecessary reference to the device during
>    probe (and then don't drop it during disconnect).
> 
> and
> 
>  * Make sure to prevent use-after-free bugs by explicitly
>    setting the driver context to NULL after signaling the
>    completion.
> 
> Cc: <stable@vger.kernel.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>

This basically looks right.  However...

> ---
>  drivers/net/wireless/ath/carl9170/usb.c | 26 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/usb.c b/drivers/net/wireless/ath/carl9170/usb.c
> index e7c3f3b8457d..297a7b877d31 100644
> --- a/drivers/net/wireless/ath/carl9170/usb.c
> +++ b/drivers/net/wireless/ath/carl9170/usb.c
> @@ -128,6 +128,8 @@ static const struct usb_device_id carl9170_usb_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(usb, carl9170_usb_ids);
>  
> +static struct usb_driver carl9170_driver;
> +
>  static void carl9170_usb_submit_data_urb(struct ar9170 *ar)
>  {
>  	struct urb *urb;
> @@ -966,7 +968,7 @@ static int carl9170_usb_init_device(struct ar9170 *ar)
>  
>  static void carl9170_usb_firmware_failed(struct ar9170 *ar)
>  {
> -	struct device *parent = ar->udev->dev.parent;
> +	struct usb_interface *intf = ar->intf;
>  	struct usb_device *udev;

It looks a little strange to initialize intf in the definition but to 
initialize udev afterward.  Nothing wrong with it, just odd.

>  
>  	/*
> @@ -978,16 +980,15 @@ static void carl9170_usb_firmware_failed(struct ar9170 *ar)
>  	udev = ar->udev;
>  
>  	complete(&ar->fw_load_wait);
> +	/* at this point 'ar' could be already freed. Don't use it anymore */
> +	ar = NULL;
>  
>  	/* unbind anything failed */
> -	if (parent)
> -		device_lock(parent);
> -
> -	device_release_driver(&udev->dev);
> -	if (parent)
> -		device_unlock(parent);
> +	usb_lock_device(udev);
> +	usb_driver_release_interface(&carl9170_driver, intf);
> +	usb_unlock_device(udev);
>  
> -	usb_put_dev(udev);
> +	usb_put_intf(intf);
>  }
>  
>  static void carl9170_usb_firmware_finish(struct ar9170 *ar)
> @@ -1009,7 +1010,7 @@ static void carl9170_usb_firmware_finish(struct ar9170 *ar)
>  		goto err_unrx;
>  
>  	complete(&ar->fw_load_wait);
> -	usb_put_dev(ar->udev);
> +	usb_put_intf(ar->intf);

But this could be a problem.  As soon as the complete() call runs, ar 
might be deallocated.  The code should copy ar->intf before calling 
complete().

Alan Stern

>  	return;
>  
>  err_unrx:
> @@ -1052,7 +1053,6 @@ static int carl9170_usb_probe(struct usb_interface *intf,
>  		return PTR_ERR(ar);
>  
>  	udev = interface_to_usbdev(intf);
> -	usb_get_dev(udev);
>  	ar->udev = udev;
>  	ar->intf = intf;
>  	ar->features = id->driver_info;
> @@ -1094,15 +1094,14 @@ static int carl9170_usb_probe(struct usb_interface *intf,
>  	atomic_set(&ar->rx_anch_urbs, 0);
>  	atomic_set(&ar->rx_pool_urbs, 0);
>  
> -	usb_get_dev(ar->udev);
> +	usb_get_intf(intf);
>  
>  	carl9170_set_state(ar, CARL9170_STOPPED);
>  
>  	err = request_firmware_nowait(THIS_MODULE, 1, CARL9170FW_NAME,
>  		&ar->udev->dev, GFP_KERNEL, ar, carl9170_usb_firmware_step2);
>  	if (err) {
> -		usb_put_dev(udev);
> -		usb_put_dev(udev);
> +		usb_put_intf(intf);
>  		carl9170_free(ar);
>  	}
>  	return err;
> @@ -1131,7 +1130,6 @@ static void carl9170_usb_disconnect(struct usb_interface *intf)
>  
>  	carl9170_release_firmware(ar);
>  	carl9170_free(ar);
> -	usb_put_dev(udev);
>  }
>  
>  #ifdef CONFIG_PM
> 

