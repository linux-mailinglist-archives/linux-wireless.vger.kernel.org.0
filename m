Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3893D43B841
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 19:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbhJZRi1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Oct 2021 13:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237836AbhJZRiR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Oct 2021 13:38:17 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B86C061348
        for <linux-wireless@vger.kernel.org>; Tue, 26 Oct 2021 10:35:52 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id z5-20020a9d4685000000b005537cbe6e5aso14144054ote.1
        for <linux-wireless@vger.kernel.org>; Tue, 26 Oct 2021 10:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ANjT17K3ayZRw6d7hdD8+s5Skaoxr1KQOeOiPXOn+/A=;
        b=CPQt/KpbL1B1CLWaw8s2/N8hYoD+t6qyE8pvv1K0DevOBforkxredd1J4DHrpEEsG8
         BHekRZyOFZ1/nw6a0C6Rjd4QBpgzrYXasZrvJvRVGB9mvVQ8bgg6jP7/0ElTU81D09dQ
         NLj7Z7pxJ8vnXvWD++CgHEtnhCDO5ZM0gfEfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANjT17K3ayZRw6d7hdD8+s5Skaoxr1KQOeOiPXOn+/A=;
        b=o/gDYbGyiE3brlnyUO6NbSC6/FuXY6cC2qP082rEuRYIIZZ35C9mttArSivhb/xS/o
         ECoLVL/n0Ol2Ly6mtSbZXlItlRUcgVb04ebVC5D+thKGyKZ2k7tS7U7uRsGRWwIGqyEk
         EAUdA7GUsWIkpVBZP575kzXCNOwhcJFAsCGtR8Z014kq8Nmuynb9U70r6ra638gOZdmz
         aTXw7hk+XvwekE8ktGTjw12AJtDX6yTgHnDvuX7q33frTVSTAQhQXu8DULMm6p8GyvEi
         4jHerTRzsHXGpRmsdEt3YUtdqPDOWyHI3TmShQYGVV65UoFzEYhDKyBI+/7h2+EakGAy
         ljrw==
X-Gm-Message-State: AOAM5330K40U9381K2JNVybOEKEaUAddLbCMUPyKOwit71Tp6IvhLq6o
        ighYg7w+JH2v/aAJSkQz9mZvznPbUwCqow==
X-Google-Smtp-Source: ABdhPJzdXaKbXOeOX5ZcvzjvAHpCNVSSwncUHvGzO6iFIG9b0Hfgoi1acTAeFWQxiNMpgz8Wt9LR/g==
X-Received: by 2002:a05:6830:57b:: with SMTP id f27mr20483530otc.343.1635269751085;
        Tue, 26 Oct 2021 10:35:51 -0700 (PDT)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id d25sm4657745otp.33.2021.10.26.10.35.49
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 10:35:49 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id l24-20020a9d1c98000000b00552a5c6b23cso20860594ota.9
        for <linux-wireless@vger.kernel.org>; Tue, 26 Oct 2021 10:35:49 -0700 (PDT)
X-Received: by 2002:a05:6830:44a9:: with SMTP id r41mr20622101otv.230.1635269748963;
 Tue, 26 Oct 2021 10:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211026095214.26375-1-johan@kernel.org> <20211026095214.26375-3-johan@kernel.org>
In-Reply-To: <20211026095214.26375-3-johan@kernel.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 26 Oct 2021 10:35:37 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNbMJ1EgPRvosx0AbJgsE-qOiaQjeD=vCEyDLoUQAgkiw@mail.gmail.com>
Message-ID: <CA+ASDXNbMJ1EgPRvosx0AbJgsE-qOiaQjeD=vCEyDLoUQAgkiw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mwifiex: fix division by zero in fw download path
To:     Johan Hovold <johan@kernel.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Amitkumar Karwar <akarwar@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 26, 2021 at 2:53 AM Johan Hovold <johan@kernel.org> wrote:
>
> Add the missing endpoint max-packet sanity check to probe() to avoid
> division by zero in mwifiex_write_data_sync() in case a malicious device
> has broken descriptors (or when doing descriptor fuzz testing).
>
> Note that USB core will reject URBs submitted for endpoints with zero
> wMaxPacketSize but that drivers doing packet-size calculations still
> need to handle this (cf. commit 2548288b4fb0 ("USB: Fix: Don't skip
> endpoint descriptors with maxpacket=0")).
>
> Fixes: 4daffe354366 ("mwifiex: add support for Marvell USB8797 chipset")
> Cc: stable@vger.kernel.org      # 3.5
> Cc: Amitkumar Karwar <akarwar@marvell.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Seems like you're missing a changelog and a version number, since
you've already sent previous versions of this patch.

>  drivers/net/wireless/marvell/mwifiex/usb.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
> index 426e39d4ccf0..2826654907d9 100644
> --- a/drivers/net/wireless/marvell/mwifiex/usb.c
> +++ b/drivers/net/wireless/marvell/mwifiex/usb.c
> @@ -502,6 +502,9 @@ static int mwifiex_usb_probe(struct usb_interface *intf,
>                         atomic_set(&card->tx_cmd_urb_pending, 0);
>                         card->bulk_out_maxpktsize =
>                                         le16_to_cpu(epd->wMaxPacketSize);
> +                       /* Reject broken descriptors. */
> +                       if (card->bulk_out_maxpktsize == 0)
> +                               return -ENODEV;

If we're really talking about malicious devices, I'm still not 100%
sure this is sufficient -- what if the device doesn't advertise the
right endpoints? Might we get through the surrounding loop without
ever even reaching this code? Seems like the right thing to do would
be to pull the validation outside the loop.

Brian
