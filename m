Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4052034629C
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Mar 2021 16:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhCWPQY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Mar 2021 11:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbhCWPQD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Mar 2021 11:16:03 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F048DC061574
        for <linux-wireless@vger.kernel.org>; Tue, 23 Mar 2021 08:16:01 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id b10so6810626uap.4
        for <linux-wireless@vger.kernel.org>; Tue, 23 Mar 2021 08:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G6jaym5lpanLdZuf3CxItL8aYukOchw2eAUreDUEMc8=;
        b=KoVgnd2X/VnehHUfwLfD8GWb4VWf5XxWyPQGEukZVKK9NVaHUfPG+Y1HSVZjjYRVkH
         ciJQ2GGiIvxeu6LCy/czi/c3hP9pSLHrj3ndz8ilLWRtRuX4blzeaxpEFQ6HyghtLyvL
         fHjzXAuU6J8AoBjBiyGdAWPzmtghPx6Vqu4n0b4Xn2NkeEBZZRAzsuqHiyzfqpmpeVdQ
         VGW0ZhIppC0QLMaxA9MB0GyehxUHyE6YrR9JrYpZFEazi/z7xlOODaK5GKnun5+EWbwk
         NBuOc7htuXRzXpsVwKjzUtf4LgHjJLdP7hudCvPSTbf5eheHHGZ5PAl5ecFJJCedvUia
         fuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G6jaym5lpanLdZuf3CxItL8aYukOchw2eAUreDUEMc8=;
        b=Yf//lJShyPS96R1zUXICW4Fcy0H/QLxc236AHAvICEclmsitwZAwi42ttNqBOWELR5
         i/Qf0iSz2yUDmUYWbkbyJVSdJJit2X+b2QIP4y1u8oYXW+/GTeNl1l7BwD/GnMK7Cv5j
         aw8n6hpbRpB9jc8Fmr1v0moOFpbTgdqYdtMNnoFtoWs8oCkkfqyQWAz9XAPtapVK5KQh
         TxJ82RooL0n7Ov0vCP+VY3nt5N109PM87V27U2aRys5pHxhS9T/Nr2W2CZo715+xzTMO
         OHcEHuV7KvcCOGcMvgw/aEg2UgayXKEh13lAPm91qdEeRzamHWv9LWHUKugOWNIAPq33
         fiaw==
X-Gm-Message-State: AOAM533bcEBat+PBKAl5BD9oYCpoGVuXx5Wk++sRd7ZFWpJwYBWBzAsu
        HZyHO2zThIIVPTYFK5c+L6etZBb0H+gKjC1Yl6C++UzaZfgpkg==
X-Google-Smtp-Source: ABdhPJzW5y9I7LJlHitTmGZLlCmWrqNaEo1EnGMGDxNzR57MaH0aQUHZ1pzEDCYsbO39Rbbdf1PBgsmcgZb9EGE1Cxo=
X-Received: by 2002:ab0:5a8a:: with SMTP id w10mr2169429uae.111.1616512560975;
 Tue, 23 Mar 2021 08:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210322204633.102581-1-emmanuel.grumbach@intel.com> <20210322204633.102581-2-emmanuel.grumbach@intel.com>
In-Reply-To: <20210322204633.102581-2-emmanuel.grumbach@intel.com>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Tue, 23 Mar 2021 17:15:47 +0200
Message-ID: <CANUX_P3w9gkRsvddx-fHhHngdEbe6g5xXLmjyquC1DMXZtU2MQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] mei: allow map and unmap of client dma buffer only
 for disconnected client
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "Berg, Johannes" <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>, luca@coelho.fi,
        Tomas Winkler <tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Mar 22, 2021 at 10:49 PM Emmanuel Grumbach
<emmanuel.grumbach@intel.com> wrote:
>
> From: Tomas Winkler <tomas.winkler@intel.com>
>
> Allow map and unmap of the client dma buffer only when the client is not
> connected. The functions return -EPROTO if the client is already connected.
> This is to fix the race when traffic may start or stop when buffer
> is not available.
>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This one has been taken by Greg through his tree so I'll drop it.
I won't resend the series for this though.

> ---
>  drivers/misc/mei/client.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
> index 4378a9b25848..2cc370adb238 100644
> --- a/drivers/misc/mei/client.c
> +++ b/drivers/misc/mei/client.c
> @@ -2286,8 +2286,8 @@ int mei_cl_dma_alloc_and_map(struct mei_cl *cl, const struct file *fp,
>         if (buffer_id == 0)
>                 return -EINVAL;
>
> -       if (!mei_cl_is_connected(cl))
> -               return -ENODEV;
> +       if (mei_cl_is_connected(cl))
> +               return -EPROTO;
>
>         if (cl->dma_mapped)
>                 return -EPROTO;
> @@ -2327,9 +2327,7 @@ int mei_cl_dma_alloc_and_map(struct mei_cl *cl, const struct file *fp,
>
>         mutex_unlock(&dev->device_lock);
>         wait_event_timeout(cl->wait,
> -                          cl->dma_mapped ||
> -                          cl->status ||
> -                          !mei_cl_is_connected(cl),
> +                          cl->dma_mapped || cl->status,
>                            mei_secs_to_jiffies(MEI_CL_CONNECT_TIMEOUT));
>         mutex_lock(&dev->device_lock);
>
> @@ -2376,8 +2374,9 @@ int mei_cl_dma_unmap(struct mei_cl *cl, const struct file *fp)
>                 return -EOPNOTSUPP;
>         }
>
> -       if (!mei_cl_is_connected(cl))
> -               return -ENODEV;
> +       /* do not allow unmap for connected client */
> +       if (mei_cl_is_connected(cl))
> +               return -EPROTO;
>
>         if (!cl->dma_mapped)
>                 return -EPROTO;
> @@ -2405,9 +2404,7 @@ int mei_cl_dma_unmap(struct mei_cl *cl, const struct file *fp)
>
>         mutex_unlock(&dev->device_lock);
>         wait_event_timeout(cl->wait,
> -                          !cl->dma_mapped ||
> -                          cl->status ||
> -                          !mei_cl_is_connected(cl),
> +                          !cl->dma_mapped || cl->status,
>                            mei_secs_to_jiffies(MEI_CL_CONNECT_TIMEOUT));
>         mutex_lock(&dev->device_lock);
>
> --
> 2.25.1
>
