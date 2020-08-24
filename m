Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3E725087B
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 20:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgHXSxP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Aug 2020 14:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgHXSxN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Aug 2020 14:53:13 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F282C061573
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 11:53:11 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v4so10912362ljd.0
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 11:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kr/ilKP3KtnpaNLBR4Wfqo2ibtevdlA/61dd3WxVQbQ=;
        b=bqOH7tKogCiyKYB3sMzalRYYv42T8tBwVa1C577l6dLDiQqHISTeBcw3/rVMjcQVRr
         +oeKkG0mXbC9eLC33+u8/ltcR8dvp2UukEC9uSYpxY/C3Gkwd5Y8jfWXavf3P3sBT+Er
         X0gXWdng+UeTkQ4qPQxDaSxZZL7g5raQtCJsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kr/ilKP3KtnpaNLBR4Wfqo2ibtevdlA/61dd3WxVQbQ=;
        b=Gi0u4R3v7IjjDbQCu/meXp/HR3KHxtAW3UoK+Bt1obLubnf6jkSXt1UryoystdwWoa
         k4bLwwk0CMzDHpcgJUXBD5bbJcj6Tt16N4SiExpaEhlrhjEqaaJRh8CJ48QYx482si3n
         D227WdRnllL0kM+uqj1K/RQx5PHSJQ/+mo1CWif2MQ73CGrUD0cORI1zvVc5I5OyMLzL
         Dv+qN/sP5+zezfPqlFvenCRTfuKLRTHPofDMB0iTLt9Q4MmCk8E9pRx8UWLMwnAXz+uG
         ejmB93aEdF2r+T1gdjhLNMnGkGyTveqTv931DG3BBerg9i2R7mFI+nEP+HEZQE37VOqh
         gAjQ==
X-Gm-Message-State: AOAM533d4E2zfiHLfbnruAp+wqAMuzMs4Fu1iPtsZ1oQdB+oA2hMQwt2
        IgBhBswovIRAED/l3h8Ys6OI/9BOR7adXw==
X-Google-Smtp-Source: ABdhPJyDlPkZ43nfVE30qByjyuQZcTAM1/1P1gwXwVMoHVm5uPke47U+VNqVDLiA+Sqj2if6SLpeOA==
X-Received: by 2002:a2e:b80b:: with SMTP id u11mr3400638ljo.286.1598295188485;
        Mon, 24 Aug 2020 11:53:08 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id t12sm2425136lfe.43.2020.08.24.11.53.06
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 11:53:06 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id t23so10902988ljc.3
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 11:53:06 -0700 (PDT)
X-Received: by 2002:a05:651c:d5:: with SMTP id 21mr2906073ljr.276.1598295186265;
 Mon, 24 Aug 2020 11:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <MN2PR18MB2637D7C742BC235FE38367F0A09C0@MN2PR18MB2637.namprd18.prod.outlook.com>
 <20200821082720.7716-1-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20200821082720.7716-1-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 24 Aug 2020 11:52:53 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOHDU+SWmr+7aOUtbuzC22T-UWhZXJ5UXtcsev5ZTbqMw@mail.gmail.com>
Message-ID: <CA+ASDXOHDU+SWmr+7aOUtbuzC22T-UWhZXJ5UXtcsev5ZTbqMw@mail.gmail.com>
Subject: Re: [PATCH v2] mwifiex: don't call del_timer_sync() on uninitialized timer
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        amit karwar <amitkarwar@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Nishant Sarmukadam <nishants@marvell.com>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+373e6719b49912399d21@syzkaller.appspotmail.com>,
        syzbot <syzbot+dc4127f950da51639216@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 21, 2020 at 1:28 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> syzbot is reporting that del_timer_sync() is called from
> mwifiex_usb_cleanup_tx_aggr() from mwifiex_unregister_dev() without
> checking timer_setup() from mwifiex_usb_tx_init() was called [1].
>
> Ganapathi Bhat proposed a possibly cleaner fix, but it seems that
> that fix was forgotten [2].
>
> "grep -FrB1 'del_timer' drivers/ | grep -FA1 '.function)'" says that
> currently there are 28 locations which call del_timer[_sync]() only if
> that timer's function field was initialized (because timer_setup() sets
> that timer's function field). Therefore, let's use same approach here.
>
> [1] https://syzkaller.appspot.com/bug?id=26525f643f454dd7be0078423e3cdb0d57744959
> [2] https://lkml.kernel.org/r/CA+ASDXMHt2gq9Hy+iP_BYkWXsSreWdp3_bAfMkNcuqJ3K+-jbQ@mail.gmail.com
>
> Reported-by: syzbot <syzbot+dc4127f950da51639216@syzkaller.appspotmail.com>
> Cc: Ganapathi Bhat <ganapathi.bhat@nxp.com>
> Cc: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

This seems good to me:

Reviewed-by: Brian Norris <briannorris@chromium.org>

> ---
>  drivers/net/wireless/marvell/mwifiex/usb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
> index 6f3cfde4654c..426e39d4ccf0 100644
> --- a/drivers/net/wireless/marvell/mwifiex/usb.c
> +++ b/drivers/net/wireless/marvell/mwifiex/usb.c
> @@ -1353,7 +1353,8 @@ static void mwifiex_usb_cleanup_tx_aggr(struct mwifiex_adapter *adapter)
>                                 skb_dequeue(&port->tx_aggr.aggr_list)))
>                                 mwifiex_write_data_complete(adapter, skb_tmp,
>                                                             0, -1);
> -               del_timer_sync(&port->tx_aggr.timer_cnxt.hold_timer);
> +               if (port->tx_aggr.timer_cnxt.hold_timer.function)
> +                       del_timer_sync(&port->tx_aggr.timer_cnxt.hold_timer);
>                 port->tx_aggr.timer_cnxt.is_hold_timer_set = false;
>                 port->tx_aggr.timer_cnxt.hold_tmo_msecs = 0;
>         }
> --
> 2.18.4
>
