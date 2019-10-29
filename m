Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00CE7E896A
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 14:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbfJ2NZj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 09:25:39 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:34649 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ2NZj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 09:25:39 -0400
Received: by mail-il1-f195.google.com with SMTP id a13so11332954ilp.1
        for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2019 06:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EViMv99KOuHMGIzwksDwnv00hlPPpsoHFS8tDyvIgps=;
        b=hD2fvgDSJnc+gK6+VYkRh57zejntRFszKw9TudI1cDEsVM47YB3y/fs+0N3k0OF10H
         X7fm9fAdlS0wMLN/eR4hUdTJO+ns0hNqGHF+WaPUoJ90GgtlWFyR+cHKRcWgJXEOR73C
         pVlNybs6m4WRfoZwYyX7M3GIcrmfoDlN35YTMu+Dfl6jC4Fb9JrSNvC2Ib66GI+gevIU
         gqaXnzwASnZmEO3VK9HGThzccU41Pavj204Qm+9fNcUPIVpFOLliFzqDTfrTntUrxqal
         4cc6xCT7PXNvUEifrDma6DU0QkVzylNtBmU/S9m+i8vfMSiUbfw9mK/XmjezFBD8Kbp3
         3KpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EViMv99KOuHMGIzwksDwnv00hlPPpsoHFS8tDyvIgps=;
        b=JDOZ9Tk0KMcSV8Fj/hlc+SGYbYsZmIE29fKtJIIfk9DzZndPpZz8lt4nAGo7tzfy35
         ubGbSI+b2uOb7vWC6BJbQ7ovpmvZPeSE/KOO83t6QqG2iUOXirryM7tC0UfFjUXDHlKY
         gwnBSIjS6XEtN+7YUxnDBwC/5ebNMPv+ONRFT44fYLLvgVscKTNv8WAxkxEUtS62obtS
         /P2acQZx2QNMR4E/K+QZ3KxNe6Fet7PrcESNANtRVuyH01U0uvXsLD8NZ0SL8bqvjj60
         pSORseumPBr6QPhfjUg9C/nBw8bKLR5zrkZ9TJXlAoUapHVoHul4/uPy3cP6o856ciM/
         vtZA==
X-Gm-Message-State: APjAAAXV+cAZJk7gZkE4ou3HroFojd75K71x5iw5Ea/aPOv2ruEJQS7Y
        PzWVVwCxVUvAerxzK+5MveBjuYtCwBNh+5bz89c=
X-Google-Smtp-Source: APXvYqwzDAiT48/1hcZqor2HGPiGoK57G7m6JT/eAJeHv7iWx1iJB6dCkFtFxP50i5tNBtgaO1pFKj8dkebn8cIIC+s=
X-Received: by 2002:a92:405a:: with SMTP id n87mr8700278ila.16.1572355538093;
 Tue, 29 Oct 2019 06:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <0851d8f413ed0086a2734c06e6e4c203b63cd017.1572275706.git.lorenzo@kernel.org>
In-Reply-To: <0851d8f413ed0086a2734c06e6e4c203b63cd017.1572275706.git.lorenzo@kernel.org>
From:   Sid Hayn <sidhayn@gmail.com>
Date:   Tue, 29 Oct 2019 09:24:36 -0400
Message-ID: <CAM0KTbB8QUJBbbQ-uU_3uh8y3CJ7=W+d7nPxJhrN=6_J09R=zw@mail.gmail.com>
Subject: Re: [PATCH] mt76: mt76u: rely on usb_interface instead of usb_dev
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>, ZeroBeat@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tested-By: Zero_Chaos <sidhayn@gmail.com>

Works wonderfully, thanks Lorenzo!

-Zero_Chaos

On Mon, Oct 28, 2019 at 11:21 AM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> usb drivers are supposed to communicate using usb_interface instead
> mt76x{0,2}u is now registering through usb_device. Fix it by passing
> usb_intf device to mt76_alloc_device routine.
>
> Fixes: 112f980ac8926 ("mt76usb: use usb_dev private data")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76.h       |  3 ++-
>  drivers/net/wireless/mediatek/mt76/mt76x0/usb.c |  2 +-
>  drivers/net/wireless/mediatek/mt76/mt76x2/usb.c |  2 +-
>  drivers/net/wireless/mediatek/mt76/usb.c        | 12 +++++++++---
>  4 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
> index 8bcc7f21e83c..ccbc05d8e96d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -806,7 +806,8 @@ static inline int
>  mt76u_bulk_msg(struct mt76_dev *dev, void *data, int len, int *actual_len,
>                int timeout)
>  {
> -       struct usb_device *udev = to_usb_device(dev->dev);
> +       struct usb_interface *uintf = to_usb_interface(dev->dev);
> +       struct usb_device *udev = interface_to_usbdev(uintf);
>         struct mt76_usb *usb = &dev->usb;
>         unsigned int pipe;
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
> index ade6312c7367..b9fd41433106 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
> @@ -221,7 +221,7 @@ static int mt76x0u_probe(struct usb_interface *usb_intf,
>         u32 mac_rev;
>         int ret;
>
> -       mdev = mt76_alloc_device(&usb_dev->dev, sizeof(*dev), &mt76x0u_ops,
> +       mdev = mt76_alloc_device(&usb_intf->dev, sizeof(*dev), &mt76x0u_ops,
>                                  &drv_ops);
>         if (!mdev)
>                 return -ENOMEM;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
> index e6d778456e5e..48b9017813b5 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
> @@ -41,7 +41,7 @@ static int mt76x2u_probe(struct usb_interface *intf,
>         struct mt76_dev *mdev;
>         int err;
>
> -       mdev = mt76_alloc_device(&udev->dev, sizeof(*dev), &mt76x2u_ops,
> +       mdev = mt76_alloc_device(&intf->dev, sizeof(*dev), &mt76x2u_ops,
>                                  &drv_ops);
>         if (!mdev)
>                 return -ENOMEM;
> diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
> index cac058fc41ef..be19038ea7dd 100644
> --- a/drivers/net/wireless/mediatek/mt76/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/usb.c
> @@ -19,7 +19,8 @@ static int __mt76u_vendor_request(struct mt76_dev *dev, u8 req,
>                                   u8 req_type, u16 val, u16 offset,
>                                   void *buf, size_t len)
>  {
> -       struct usb_device *udev = to_usb_device(dev->dev);
> +       struct usb_interface *uintf = to_usb_interface(dev->dev);
> +       struct usb_device *udev = interface_to_usbdev(uintf);
>         unsigned int pipe;
>         int i, ret;
>
> @@ -234,7 +235,8 @@ mt76u_rd_rp(struct mt76_dev *dev, u32 base,
>
>  static bool mt76u_check_sg(struct mt76_dev *dev)
>  {
> -       struct usb_device *udev = to_usb_device(dev->dev);
> +       struct usb_interface *uintf = to_usb_interface(dev->dev);
> +       struct usb_device *udev = interface_to_usbdev(uintf);
>
>         return (!disable_usb_sg && udev->bus->sg_tablesize > 0 &&
>                 (udev->bus->no_sg_constraint ||
> @@ -369,7 +371,8 @@ mt76u_fill_bulk_urb(struct mt76_dev *dev, int dir, int index,
>                     struct urb *urb, usb_complete_t complete_fn,
>                     void *context)
>  {
> -       struct usb_device *udev = to_usb_device(dev->dev);
> +       struct usb_interface *uintf = to_usb_interface(dev->dev);
> +       struct usb_device *udev = interface_to_usbdev(uintf);
>         unsigned int pipe;
>
>         if (dir == USB_DIR_IN)
> @@ -951,6 +954,7 @@ int mt76u_init(struct mt76_dev *dev,
>                 .rd_rp = mt76u_rd_rp,
>                 .type = MT76_BUS_USB,
>         };
> +       struct usb_device *udev = interface_to_usbdev(intf);
>         struct mt76_usb *usb = &dev->usb;
>
>         tasklet_init(&usb->rx_tasklet, mt76u_rx_tasklet, (unsigned long)dev);
> @@ -964,6 +968,8 @@ int mt76u_init(struct mt76_dev *dev,
>         dev->bus = &mt76u_ops;
>         dev->queue_ops = &usb_queue_ops;
>
> +       dev_set_drvdata(&udev->dev, dev);
> +
>         usb->sg_en = mt76u_check_sg(dev);
>
>         return mt76u_set_endpoints(intf, usb);
> --
> 2.21.0
>
