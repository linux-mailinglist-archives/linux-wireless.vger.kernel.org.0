Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD72345B29F
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Nov 2021 04:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240484AbhKXD3x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Nov 2021 22:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhKXD3w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Nov 2021 22:29:52 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C596BC061574
        for <linux-wireless@vger.kernel.org>; Tue, 23 Nov 2021 19:26:43 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id az37so2097273uab.13
        for <linux-wireless@vger.kernel.org>; Tue, 23 Nov 2021 19:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klGilqjUZU6ZdsmEtW9xvGC+xGkfpuphyvZBpG8MLiQ=;
        b=AWAjlDSuB3LCOnhqmu/VryPoQeaK3mhGhREEWvvfsTc5j1YNhwFkT+8Pgsqqp45uTa
         yh0+BBAuWZLNVr364YPujdIQtelYFg9X25eWoKA7Pki+SX8a/N+RxylRlPwwUYIqP+D2
         X9QfgeXiZmGGrZAPGrzB4dkSPwuTfD4y7Wea5mtxa+um2c1csyAtyApGT5blfYDZxUYO
         QgtWStWY646NC+hTa90YVYTzPsmBQyrfCLGooVUV5QoKLEBhSZ/LqRGdfdnI8eKYQczM
         iD6cWj3AVbKZQ9qarzZ6KFPGaqFgTUgQwc9WnqLONQQIJsInb+vbouHaDnKufVY0h40x
         EjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klGilqjUZU6ZdsmEtW9xvGC+xGkfpuphyvZBpG8MLiQ=;
        b=FTcZU5wap9EoA2psUdsP2t8P3cVRhkhzSSzY+zhns5KQMHWB8mH0VlmriYE40tyI5o
         pThlVX9U+aR6NVIw3B63M4pvSZAEr5UZ9qVk1akXeo390cBsEN3XFlmB+gv06/y925WN
         nHv68UaEte/kDsMg/B+jOod9+9ThA1vGRKfbvUGrL+aEWnTXCe2iwDN6+PBAAFeY7rUO
         RTA/dSQgy32kRbDI1ZR6cOjEvQa7f7tZzEaT17lhet6wUxoLeBoVDKqWhHuTJKXjMMxW
         XWwQn3goS0Kt4kW5F5Q9K9FDfvIgp35Fx/LlWGzJBrf8DajGbziHMiOk/brSNH6C4trv
         XkVg==
X-Gm-Message-State: AOAM532v0V9xWpkJ3LlF/mJqX9tVIWpH6fv3LX5LvWxb/PkiRe54uajO
        sr0s3Pa87qBx8NdgMWixoGdzD7f2nQd/5XnDsdY=
X-Google-Smtp-Source: ABdhPJz7DGhq8oqHGaOwKJW8EzBZqDhs2Y7wDuLhPhPq/CDuRyyctNW0yvUP4FA+VeBEUydRMAmcdhpjteTQupJhDa0=
X-Received: by 2002:ab0:6eca:: with SMTP id c10mr4698623uav.118.1637724402914;
 Tue, 23 Nov 2021 19:26:42 -0800 (PST)
MIME-Version: 1.0
References: <20210915160422.2839595-1-festevam@denx.de> <CAOMZO5AYUxJg4bWudT3L1P=qNR2UBcNR1zmjCf5O9_ExyPw4ww@mail.gmail.com>
In-Reply-To: <CAOMZO5AYUxJg4bWudT3L1P=qNR2UBcNR1zmjCf5O9_ExyPw4ww@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 24 Nov 2021 00:26:32 -0300
Message-ID: <CAOMZO5AJ8q06YTHP=p84nJnKOYU+=MKVqJ3qz3XnUGcAg0xo=g@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Clean the HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE flag
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Fabio Estevam <festevam@denx.de>, wgong@codeaurora.org,
        ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        erik.stromdahl@gmail.com, alagusankar@silex-india.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

On Mon, Nov 15, 2021 at 3:06 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Kalle,
>
> On Wed, Sep 15, 2021 at 1:05 PM Fabio Estevam <festevam@denx.de> wrote:
> >
> > On an imx6dl-pico-pi board with a QCA9377 SDIO chip, the following
> > errors are observed when the board works in STA mode:
> >
> > Simply running "ssh user@192.168.0.1" causes:
> >
> > [   55.824159] ath10k_sdio mmc1:0001:1: failed to transmit packet, dropping: -12
> > [   55.832169] ath10k_sdio mmc1:0001:1: failed to submit frame: -12
> > [   55.838529] ath10k_sdio mmc1:0001:1: failed to push frame: -12
> > [   55.905863] ath10k_sdio mmc1:0001:1: failed to transmit packet, dropping: -12
> > [   55.913650] ath10k_sdio mmc1:0001:1: failed to submit frame: -12
> > [   55.919887] ath10k_sdio mmc1:0001:1: failed to push frame: -12
> >
> > and it is not possible to connect via ssh to the other machine.
> >
> > One user inspected the size of frames on Wireshark and reported
> > the followig:
> >
> > "I was able to narrow the issue down to the mtu. If I set the mtu for
> > the wlan0 device to 1486 instead of 1500, the issue does not happen.
> >
> > The size of frames that I see on Wireshark is exactly 1500 after
> > setting it to 1486."
> >
> > Clearing the HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE avoids the problem and
> > the ssh command works successfully after that.
> >
> > Tested with QCA9377 SDIO with firmware WLAN.TF.1.1.1-00061-QCATFSWPZ-1.
> >
> > Fixes: 2f918ea98606 ("ath10k: enable alt data of TX path for sdio")
> > Signed-off-by: Fabio Estevam <festevam@denx.de>
>
> A gentle ping on this one.

Any comments, please? Without this fix, we can not log via ssh to other machine.
