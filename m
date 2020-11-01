Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BA92A2092
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Nov 2020 18:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgKARko (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Nov 2020 12:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgKARkn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Nov 2020 12:40:43 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDC7C0617A6
        for <linux-wireless@vger.kernel.org>; Sun,  1 Nov 2020 09:40:43 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id r10so5653875plx.3
        for <linux-wireless@vger.kernel.org>; Sun, 01 Nov 2020 09:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=OFBukevqehLwV1KalE+IHx2TKC043rfNcCvr22d8rTc=;
        b=TlE3lskq0GSNt1gnZAAzI8XGGtutLKY2otNzTdfOnjWTmw/Ti5k1+zGaPPaLkgkeVu
         3Av7kiiYIM76NKPq7dRJgS0TUoWfiQwGx+WrDinJq92EtzS/OOQPZSE8HrUc62wbHB8J
         3M/G2d1rdPxFzQKoZJVTmE8fzYYXAiEMM6Ot7oxsuCeHbgguNLrdu20J3WELnMbRC7V9
         XIV5I8T6OAQ+qXV2CluXXHGhs/pbhQN3o9m7lgSFO5kjcS0FnERjRbKdMIyHoraaPD4W
         OnMeXVjgffVzckDDGeilD68CP+iJfCGxSJJt1wbGP4ZmHpm8w6SNkJ10vl1P78B3oLwk
         CNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OFBukevqehLwV1KalE+IHx2TKC043rfNcCvr22d8rTc=;
        b=CB7jqayh/6YBRLKHQpeSBfss0hIVV9qa4/1gfXax8LgOaXkrjNci7KADuI7O06nQiQ
         8F943nq8aYMfX6bDs+nqpTaeInBB61KfyJPBNs6MjCpsKM5jIKkavmI824t40Phl8kLZ
         AddTuFzjoCSP6/d96jQHWDR7jx9Yw1ptMsIcHvjeMXTBgtQpEdf04R79gl9JflP957N7
         mBpKiAfiuvnsHvBdxk6sSZuE0Th5TEa/XzNNTfh9x5wvnmqxi4zhEzI5ZRFiwYkPih2g
         aQK/6bvGVLt8T5+4cSPjv9mAXnQa+Sa/q4GFLF8B74ZD2R7WHLb67/Z0YMMCFy6h3mIy
         8m6A==
X-Gm-Message-State: AOAM532wk+rNvzS2QRBzprMM59O/OCDfiwCxQOvIvFRSM2SB8EIxoi7H
        QpFVp+u2JZiXNnZzhxphI4PETYAmTDVOOg==
X-Google-Smtp-Source: ABdhPJzmjjf0xTLF04gykROqrRKyzSwfJRFrlyDQoAHQMSj982zYxV/xcybESRjLWnhDZ0ClIBEdUQ==
X-Received: by 2002:a17:902:9f94:b029:d5:aad0:d18a with SMTP id g20-20020a1709029f94b02900d5aad0d18amr17820023plq.69.1604252443100;
        Sun, 01 Nov 2020 09:40:43 -0800 (PST)
Received: from ?IPv6:240b:10:2720:5510:8f22:949a:103d:7b6d? ([240b:10:2720:5510:8f22:949a:103d:7b6d])
        by smtp.gmail.com with ESMTPSA id o15sm11860779pfd.16.2020.11.01.09.40.42
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2020 09:40:42 -0800 (PST)
Subject: Re: [PATCH] rtl8xxxu: Add Buffalo WI-U3-866D to list of supported
 devices
To:     linux-wireless@vger.kernel.org
References: <20201101172317.7412-1-ikegami.t@gmail.com>
From:   Tokunori Ikegami <ikegami.t@gmail.com>
Message-ID: <e6f14453-4d1e-f576-322e-d87968e94cb9@gmail.com>
Date:   Mon, 2 Nov 2020 02:40:41 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201101172317.7412-1-ikegami.t@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Sorry I have just resent the new version patch to fix the uppercase 
letter USB product ID to lowercase as below.
   Previous: 0x025D
   Fixed: 0x025d

Regards,
Ikegami

On 2020/11/02 2:23, Tokunori Ikegami wrote:
> Buffalo WI-U3-866D is supported by the rtl8812au driver.
> Also RTL8812AU software supports the product RTL8192EU also.
> So add Buffalo WI-U3-866D with the RTL8192EU driver info.
>
> Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
> Cc: linux-wireless@vger.kernel.org
> ---
>   drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 5cd7ef3625c5..226c85ab3aa9 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -6761,6 +6761,9 @@ static const struct usb_device_id dev_table[] = {
>   /* Tested by Myckel Habets */
>   {USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0109, 0xff, 0xff, 0xff),
>   	.driver_info = (unsigned long)&rtl8192eu_fops},
> +/* Buffalo WI-U3-866D */
> +{USB_DEVICE_AND_INTERFACE_INFO(0x0411, 0x025D, 0xff, 0xff, 0xff),
> +	.driver_info = (unsigned long)&rtl8192eu_fops},
>   {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0xb720, 0xff, 0xff, 0xff),
>   	.driver_info = (unsigned long)&rtl8723bu_fops},
>   {USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xa611, 0xff, 0xff, 0xff),
