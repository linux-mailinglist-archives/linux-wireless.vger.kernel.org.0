Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCD12311E9
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jul 2020 20:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgG1SqC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Jul 2020 14:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbgG1SqC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Jul 2020 14:46:02 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4BCC061794
        for <linux-wireless@vger.kernel.org>; Tue, 28 Jul 2020 11:46:02 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g26so19733964qka.3
        for <linux-wireless@vger.kernel.org>; Tue, 28 Jul 2020 11:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jdr1gVzgoBXFB+stTUTeunVZqOgXPnJz20tH+qp5ajw=;
        b=MFQCx1GKMluY3hy4StyDLrDfypn97t7pcQAX7c+HYjOGfDl+4jEVlsEYXmiSHawzIs
         oGreHihOlGfmzPgjNROKXyn6AqvmH9IqmQd1i5eUcJkgf9cLfNfYlkoRJdjApwVVAsUQ
         +xhDoQ1ZDgve6j6NeqYTU0c0r/b3dOWzvrhJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jdr1gVzgoBXFB+stTUTeunVZqOgXPnJz20tH+qp5ajw=;
        b=OsOs9XBa7RPHV/ICSds9O6+bma9X5WQzgwJN4Asn6xP/v2/fgzeXfQAli7KWhUnOBf
         MtfY9GSJurH+68Dy1IgBr3rFkNJJrnOyvSRu8FcwZaUbIS+5/xydCFEIfZ5cWFyn/OON
         nqDJwR/MkQ/CPLxwlu/EA4EU3XyrcfatgTq319VGSiaqyvzYyyvBSf/cH0/t0agr4Hfz
         vqQMAHjHj9l/M6rjdJ4g+uSicqyLLxsYd2CJZEk42PJReDHqg3++0m/IMEmp0vgcSdk5
         NiGCJznGMFFabjuhVwjrKLBQOwwWrHhFknVeKBjYMReH7bBJkzVc4iVuGeNgZqHPLNzW
         DWCg==
X-Gm-Message-State: AOAM531W+s/dC5sy4AK4eEcytn9yjYy14I8160bDXvdXxIlCywVG56xv
        MWRmEcggMkg+Fjs25VYvNPrLO4JwT6A=
X-Google-Smtp-Source: ABdhPJwZmZi5EV0kw1XXF8dJhiHAOm+VLyL9LvAKrevSyF/Kae/U90Y5zHkaISOTyC4+karwT/CwUg==
X-Received: by 2002:a37:4f07:: with SMTP id d7mr30837221qkb.144.1595961960667;
        Tue, 28 Jul 2020 11:46:00 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id z67sm23344087qkb.27.2020.07.28.11.45.57
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 11:45:58 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id v22so9732172qtq.8
        for <linux-wireless@vger.kernel.org>; Tue, 28 Jul 2020 11:45:57 -0700 (PDT)
X-Received: by 2002:ac8:6758:: with SMTP id n24mr27337056qtp.124.1595961956507;
 Tue, 28 Jul 2020 11:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <MN2PR18MB2637D7C742BC235FE38367F0A09C0@MN2PR18MB2637.namprd18.prod.outlook.com>
 <1595900652-3842-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <1595900652-3842-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 28 Jul 2020 11:45:45 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMHt2gq9Hy+iP_BYkWXsSreWdp3_bAfMkNcuqJ3K+-jbQ@mail.gmail.com>
Message-ID: <CA+ASDXMHt2gq9Hy+iP_BYkWXsSreWdp3_bAfMkNcuqJ3K+-jbQ@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: don't call del_timer_sync() on uninitialized timer
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Ganapathi Bhat <gbhat@marvell.com>,
        amit karwar <amitkarwar@gmail.com>, andreyknvl@google.com,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Nishant Sarmukadam <nishants@marvell.com>,
        syzbot+dc4127f950da51639216@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+373e6719b49912399d21@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Mon, Jul 27, 2020 at 6:45 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> syzbot is reporting that del_timer_sync() is called from
> mwifiex_usb_cleanup_tx_aggr() from mwifiex_unregister_dev() without
> checking timer_setup() from mwifiex_usb_tx_init() was called [1].
> Since mwifiex_usb_prepare_tx_aggr_skb() is calling del_timer() if
> is_hold_timer_set == true, use the same condition for del_timer_sync().
>
> [1] https://syzkaller.appspot.com/bug?id=fdeef9cf7348be8b8ab5b847f2ed993aba8ea7b6
>
> Reported-by: syzbot <syzbot+373e6719b49912399d21@syzkaller.appspotmail.com>
> Cc: Ganapathi Bhat <gbhat@marvell.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> A patch from Ganapathi Bhat ( https://patchwork.kernel.org/patch/10990275/ ) is stalling
> at https://lore.kernel.org/linux-usb/MN2PR18MB2637D7C742BC235FE38367F0A09C0@MN2PR18MB2637.namprd18.prod.outlook.com/ .
> syzbot by now got this report for 10000 times. Do we want to go with this simple patch?

Sorry, that stall is partly my fault, and partly Ganapathi's. It
doesn't help that it took him 4 months to reply to my questions, so I
completely lost even the tiny bit of context I had managed to build up
in my head at initial review time... and so it's still buried in the
dark corners of my inbox. (I think I'll go archive that now, because
it really deserves a better sell than it had initially, if Ganapathi
really wants to land it.)

>  drivers/net/wireless/marvell/mwifiex/usb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
> index 6f3cfde..04a1461 100644
> --- a/drivers/net/wireless/marvell/mwifiex/usb.c
> +++ b/drivers/net/wireless/marvell/mwifiex/usb.c
> @@ -1353,7 +1353,8 @@ static void mwifiex_usb_cleanup_tx_aggr(struct mwifiex_adapter *adapter)
>                                 skb_dequeue(&port->tx_aggr.aggr_list)))
>                                 mwifiex_write_data_complete(adapter, skb_tmp,
>                                                             0, -1);
> -               del_timer_sync(&port->tx_aggr.timer_cnxt.hold_timer);
> +               if (port->tx_aggr.timer_cnxt.is_hold_timer_set)

I believe if we ever actually started aggregation, then the timer can
be active at this point, and thus, the access to 'is_hold_timer_set'
is racy.

This *probably* deserves a better refactor, but in absence of that
(and a better explanation than Ganapathi gave), I think you at least
need to hold port->tx_aggr_lock. So perhaps (totally untested):

  spin_lock_bh(&port->tx_aggr_lock);
  if (port->tx_aggr.timer_cnxt.is_hold_timer_set) {
    port->tx_aggr.timer_cnxt.is_hold_timer_set = false;
    spin_unlock_bh(&port->tx_aggr_lock);
    /* Timer could still be running, but it can't be restarted at this
point, so this is safe. */
    del_timer_sync(&port->tx_aggr.timer_cnxt.hold_timer);
  } else {
    spin_unlock_bh(&port->tx_aggr_lock);
  }

Otherwise, I think this is fine:

Reviewed-by: Brian Norris <briannorris@chromium.org>

I also believe mwifiex_usb_prepare_tx_aggr_skb() needs to stop using
del_timer() (without the _sync()), because otherwise we might have
deactivated the timer already but not ensured that it has completely
finished executing on other CPUs. But that is probably orthogonal to
the current patch. (Again, so much in this driver needs refactoring.)

Side note: this entire TX aggregation feature for USB has been hidden
behind the mwifiex.aggr_ctrl module param since its introduction,
which has always been disabled by default. I wonder whether anybody is
*really* testing it, or whether it's 100% broken, as with many things
in this driver...


Brian

> +                       del_timer_sync(&port->tx_aggr.timer_cnxt.hold_timer);
>                 port->tx_aggr.timer_cnxt.is_hold_timer_set = false;
>                 port->tx_aggr.timer_cnxt.hold_tmo_msecs = 0;
>         }
> --
> 1.8.3.1
>
