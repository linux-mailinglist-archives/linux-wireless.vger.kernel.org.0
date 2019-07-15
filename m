Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B852E6986B
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2019 17:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbfGOPi0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Jul 2019 11:38:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33438 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730333AbfGOPi0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Jul 2019 11:38:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so17676347wru.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jul 2019 08:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m8HqpA0lzy0qcdZrdNO9EMUvHzgXiTx53AeUWo7xYTs=;
        b=S0mdgQlGmXX169HzlWd9URsL/auA2CdJjzZ0k1Zk9hQFwK5h5RtIffcCkpoHqATRLu
         O517wkcWVJU+R+Yg32Mzsfqnoof8aW2CJLnt2UpjDi6XHL8RgVWdtmORHuXvtSv7KF7U
         i04Mal1nKwQjx8P+4HGCegZ1GTazzgZHoIatPLqpG1xSC3fp7RRhqFBGtlP8ue96U5he
         pX/PfVvjbROGTvzHAdFV55oaZafO/P3VF3EZUA2oS/8XiOkFJqqMlUEVKMj1gcx9twn8
         tF88QBdnU5/lJ1c4pNw13QuFW/xFmwZ5wt35uOacJ6zHBKlNV/rVl386jdEhK/9QED31
         wIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m8HqpA0lzy0qcdZrdNO9EMUvHzgXiTx53AeUWo7xYTs=;
        b=EVkAg4UyjN0YfoK86gAip03ULfbaa65SjffsvaSYcgGJ8MGdS4IYZDC/SnhRySCpPp
         PN+aSU7UOjItXCexr3NpHjwJi0mfPblVL/U1zx/MDWxr3Alj4vg3Zgu4oBj2OCnvRclC
         U93l1akGB5nLdMGuSTcAQ5EI5T+b3GM3gRHm7bNnuAIK55FFjbBroJU2mdxCubpS32mb
         6Aw6SxBzdYAaabDoQJbFEVZ3cy2ggi4c2L+M2d4UTF8EyH14Q8s4i5MM9m1B9VWqRO1V
         FmkMwPW3D6+9qcocE0aF2VdiwOLZA2dWLv+Svbod4c/EXHnIMyKrJZqsb/YxP5U5aaMB
         xtSw==
X-Gm-Message-State: APjAAAWTYgTK+EErDeitBIr9XVtLDMUBSBlP1551nzvaqzg/YisegPFD
        4K2qn/6JdWb47OUcOnDJTpKeHIo5JNtxpXGNWPU=
X-Google-Smtp-Source: APXvYqz+8gUXLrXFmdh7H2AXjY/xudElCxHcyKS55yBLpOdvgRz78YrUyvjBUGamfSB7eedP4XPo+ouKJ412OYeseCM=
X-Received: by 2002:a5d:498a:: with SMTP id r10mr30014693wrq.28.1563205103949;
 Mon, 15 Jul 2019 08:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <dfb97adb52811bed530449c22a172724ed992771.1562353065.git.lorenzo@kernel.org>
In-Reply-To: <dfb97adb52811bed530449c22a172724ed992771.1562353065.git.lorenzo@kernel.org>
From:   Sid Hayn <sidhayn@gmail.com>
Date:   Mon, 15 Jul 2019 11:38:01 -0400
Message-ID: <CAM0KTbBU7-BTTR_R9b7VNQuqRpd=rMk8nAQANQ7shns+XGahdw@mail.gmail.com>
Subject: Re: [PATCH] mt76: mt76x0u: add support to TP-Link T2UHP
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix,

I saw you accept this patch, thanks.  Any chance of pushing this
simple fix in 5.1.x and 5.2.x?  I've tested and confirmed this
hardware works fine.

Thanks,
Zero

On Fri, Jul 5, 2019 at 3:01 PM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> Introduce support to TP-Link T2UHP
> https://wikidevi.com/wiki/TP-LINK_Archer_T2UHP
>
> Tested-by: Sid Hayn <sidhayn@gmail.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76x0/usb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
> index 627ed1fc7b15..b007bcd2e999 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
> @@ -32,6 +32,7 @@ static struct usb_device_id mt76x0_device_table[] = {
>         { USB_DEVICE(0x20f4, 0x806b) }, /* TRENDnet TEW-806UBH  */
>         { USB_DEVICE(0x7392, 0xc711) }, /* Devolo Wifi ac Stick */
>         { USB_DEVICE(0x0df6, 0x0079) }, /* Sitecom Europe B.V. ac  Stick */
> +       { USB_DEVICE(0x2357, 0x0123) }, /* TP-LINK T2UHP */
>         { USB_DEVICE(0x2357, 0x0105),
>           .driver_info = 1,          }, /* TP-LINK Archer T1U */
>         { USB_DEVICE_AND_INTERFACE_INFO(0x0E8D, 0x7630, 0xff, 0x2, 0xff)}, /* MT7630U */
> --
> 2.21.0
>
