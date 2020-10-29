Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853AD29F0A4
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Oct 2020 16:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgJ2P7Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Oct 2020 11:59:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48594 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727290AbgJ2P7Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Oct 2020 11:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603987154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aajVOp/UIuOe1/LuSwzWc3QP2wiYu3hX91vy3AywAnI=;
        b=iTpgidRlv2foUqMZYTwwnVGm8I1OhQ5Dm3Mf2u4uH7C6TlVN1Ft0+9WftqQBEcrvhEHlr1
        pICK3M6xEx5VQ/GY7J7QnOYIQghHHpPys82lPrw9MDvFKhTuv+6hRAY1y+93dvWMcU2FfR
        yi9GlpP73XJYCC0wUZ/NrBy4Kj5UG/0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-4aWxRbexNb-Mbb8LgkP28g-1; Thu, 29 Oct 2020 11:59:12 -0400
X-MC-Unique: 4aWxRbexNb-Mbb8LgkP28g-1
Received: by mail-ed1-f71.google.com with SMTP id b16so1361773edn.6
        for <linux-wireless@vger.kernel.org>; Thu, 29 Oct 2020 08:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aajVOp/UIuOe1/LuSwzWc3QP2wiYu3hX91vy3AywAnI=;
        b=j2JTpEGBVrNV/SDnXyfWtwEZbZPQr6YAT7x7/7JIalGDE55XpyXpVzQMV+SApiIx0d
         Ib2cAZaQzsU4avgvL/h3sOx+LynBcPhHgkXVp/CvjrPng9Mah01Qn8C0CxQzreBzj3Cj
         19F7mAkaiJrbTxhbWgmSxFIgQGvNoApZ7qh0Kagz4lZc3kuJeg7HVSzPfqxQM8Q0y+Zc
         21BCX80Gzyis9hQQxdNdVeNlh0+TXFhoh3+cRedx0y003LyvnH6NJTxXTUV1THlpb27l
         gzzVDVMD2WNJqCLTTt7M/PW0luH0lIeXr6CWnT4uaeCCXPbF4VyzzTJpxBCuNHkhziGT
         ZhiA==
X-Gm-Message-State: AOAM533mXtMiaQR+FwOQ1krLd+tGpXNLVBX/otfHNm2jCqIrHTLWmAqI
        vMIpFRTzXMUO0AkrHthKJp9lDWgsulUYRnvGlBSXdQqv6AtAhl2o1NDWwNztDbvoGPea11KBX2P
        TcsmHJ7Wzk+EEVEQewYtLFYDFKwE=
X-Received: by 2002:a17:906:1804:: with SMTP id v4mr4806584eje.201.1603987150637;
        Thu, 29 Oct 2020 08:59:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjvRjIrXVXU41RIjyQesCFbhP44ypjML0pHq6oeGxLXXZmX7Wxx9y2CWmpZmK+Qwg2036xFg==
X-Received: by 2002:a17:906:1804:: with SMTP id v4mr4806568eje.201.1603987150483;
        Thu, 29 Oct 2020 08:59:10 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id sb29sm1720724ejb.76.2020.10.29.08.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 08:59:09 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8723bs: Add 024c:0627 to the list of SDIO
 device-ids
To:     Brian O'Keefe <bokeefe@alum.wpi.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org
References: <CABtq2xReyqg1wJM7W1d=KWRNTNN0Q6HCgJMWcQ6DH=SmKcxQRg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c396ef73-a3d0-2e4d-b212-80728dc69dea@redhat.com>
Date:   Thu, 29 Oct 2020 16:59:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CABtq2xReyqg1wJM7W1d=KWRNTNN0Q6HCgJMWcQ6DH=SmKcxQRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 10/29/20 2:52 PM, Brian O'Keefe wrote:
> Add 024c:0627 to the list of SDIO device-ids, based on hardware found in
> the wild. This hardware exists on at least some Acer SW1-011 tablets.
> 
> Signed-off-by: Brian O'Keefe <bokeefe@alum.wpi.edu>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> index 5b1392deb0a7..7256d55fcc1b 100644
> --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> @@ -21,6 +21,7 @@ static const struct sdio_device_id sdio_ids[] =
>         { SDIO_DEVICE(0x024c, 0x0525), },
>         { SDIO_DEVICE(0x024c, 0x0623), },
>         { SDIO_DEVICE(0x024c, 0x0626), },
> +       { SDIO_DEVICE(0x024c, 0x0627), },
>         { SDIO_DEVICE(0x024c, 0xb723), },
>         { /* end: all zeroes */                         },
>  };
> --
> 2.25.1
> 

