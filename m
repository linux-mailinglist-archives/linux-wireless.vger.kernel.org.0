Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFB524B20B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Aug 2020 11:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgHTJTj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Aug 2020 05:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgHTJTd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Aug 2020 05:19:33 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BCEC061757
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 02:19:32 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id u6so768552ybf.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 02:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SW3KNzUfHsk62wnE32vbuF2S61G6VGXEL8ea6YI0vqY=;
        b=JcO0hdnvDa+TW9o0NsK9zxcJOyUKp9MUEcEzRh7eCqDVVLAECaWxG5UtgM5speHQ8S
         Y4hkHwTlBIT4HXB5xeXm3ZMleWLj5CKC7Dy5iznT1IJDTomQw79joiyygePccVXGixel
         mI1Jsgo5NNYHRuYmjNi4+L75mhfRgpQEZ3+kfmOFObSzP/vUFJyEBMZOI6u/Y9RCrWHt
         WbM3K0AZNT80Fl0Y/8A9HIUzgkJtkX9fkAMlFY8b33Gf6iozhNzeJvQTik+HtogT8yKB
         GkIVZnO//qZUeAtT4f5YQZLsia+/xLF97PIsEVTy3DhFq6XKiSL4m6tiv959g7d5BGVb
         YkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SW3KNzUfHsk62wnE32vbuF2S61G6VGXEL8ea6YI0vqY=;
        b=oMApbqMwLyNyO+961RZddVmP0fFONN3GyoQESvtWRAUUYFJJmz8IW6Z8qK2y3jjHAj
         KiEuonVdPt2rEbb2Er3jLdzs6NO5Rgu+8c08LAPltxHGAG5eiHDKrTxwvIEbT+XwQtzQ
         LzpIF9enl4za2+vcl/XZDEqd0S4LB76unLY0K68EFCR9UvTwnofsVf7Wnq0j1sRm5trs
         lkwdll7rBi8pCx3QzGxhpkcq4v3HJ7U2+aEPqcwhzst0jz+t1gjL9fIV/YwxzrH76TE3
         RZ5q/cmr3CbbMc2/Bvu69u0cxN08C0gANysLPvNvhw6sJ1eqjk4kBrJ6nkm7ca+5cHFD
         hcjg==
X-Gm-Message-State: AOAM530XmyBXSldfqfoz17PkdnuToZj73nG9/zc368E9Z+Yn20N5l8XG
        UOClKZ4sSba8s30Dkh55JNxsQOwk/3Ummq9hlQHK4Kqnv9E=
X-Google-Smtp-Source: ABdhPJyYm0ipt/s76Rncx5AobguvmU5SCaHzq2/2sBeXsIft0bwArSNWhpJqORSW/GKUVuI0pqyDp0LhBtmncaXuapM=
X-Received: by 2002:a5b:d12:: with SMTP id y18mr3401291ybp.400.1597915169954;
 Thu, 20 Aug 2020 02:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200214035555.24762-1-wgong@codeaurora.org> <878se9iup3.fsf@codeaurora.org>
In-Reply-To: <878se9iup3.fsf@codeaurora.org>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Thu, 20 Aug 2020 14:49:18 +0530
Message-ID: <CABPxzYK4kYvBAvYxk6rs-PHM==vBaHQTm3dCCh_+Z+KOB+c6qA@mail.gmail.com>
Subject: Re: [RFC] ath10k: change to do napi_enable and napi_disable when
 insmod and rmmod for sdio
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Wen Gong <wgong@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 20, 2020 at 2:03 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Wen Gong <wgong@codeaurora.org> writes:
>
> > It happened "Kernel panic - not syncing: hung_task: blocked tasks" when
> > test simulate crash and ifconfig down/rmmod meanwhile.
> >
> > Test steps:
> >
> > 1.Test commands
> > echo soft > /sys/kernel/debug/ieee80211/phy0/ath10k/simulate_fw_crash;sleep 0.05;ifconfig wlan0 down
> > echo soft > /sys/kernel/debug/ieee80211/phy0/ath10k/simulate_fw_crash;rmmod ath10k_sdio
> >
> > 2. dmesg:
> > [ 5622.548630] ath10k_sdio mmc1:0001:1: simulating soft firmware crash
> > [ 5622.655995] ieee80211 phy0: Hardware restart was requested
> > [ 5776.355164] INFO: task shill:1572 blocked for more than 122 seconds.
> > [ 5776.355687] INFO: task kworker/1:2:24437 blocked for more than 122 seconds.
> > [ 5776.359812] Kernel panic - not syncing: hung_task: blocked tasks
> > [ 5776.359836] CPU: 1 PID: 55 Comm: khungtaskd Tainted: G        W         4.19.86 #137
> > [ 5776.359846] Hardware name: MediaTek krane sku176 board (DT)
> > [ 5776.359855] Call trace:
> > [ 5776.359868]  dump_backtrace+0x0/0x170
> > [ 5776.359881]  show_stack+0x20/0x2c
> > [ 5776.359896]  dump_stack+0xd4/0x10c
> > [ 5776.359916]  panic+0x12c/0x29c
> > [ 5776.359937]  hung_task_panic+0x0/0x50
> > [ 5776.359953]  kthread+0x120/0x130
> > [ 5776.359965]  ret_from_fork+0x10/0x18
> > [ 5776.359986] SMP: stopping secondary CPUs
> > [ 5776.360012] Kernel Offset: 0x141ea00000 from 0xffffff8008000000
> > [ 5776.360026] CPU features: 0x0,2188200c
> > [ 5776.360035] Memory Limit: none
> >
> > command "ifconfig wlan0 down" or "rmmod ath10k_sdio" will be blocked
> > callstack of ifconfig:
> > [<0>] __switch_to+0x120/0x13c
> > [<0>] msleep+0x28/0x38
> > [<0>] ath10k_sdio_hif_stop+0x24c/0x294 [ath10k_sdio]
> > [<0>] ath10k_core_stop+0x50/0x78 [ath10k_core]
> > [<0>] ath10k_halt+0x120/0x178 [ath10k_core]
> > [<0>] ath10k_stop+0x4c/0x8c [ath10k_core]
> > [<0>] drv_stop+0xe0/0x1e4 [mac80211]
> > [<0>] ieee80211_stop_device+0x48/0x54 [mac80211]
> > [<0>] ieee80211_do_stop+0x678/0x6f8 [mac80211]
> > [<0>] ieee80211_stop+0x20/0x30 [mac80211]
> > [<0>] __dev_close_many+0xb8/0x11c
> > [<0>] __dev_change_flags+0xe0/0x1d0
> > [<0>] dev_change_flags+0x30/0x6c
> > [<0>] devinet_ioctl+0x370/0x564
> > [<0>] inet_ioctl+0xdc/0x304
> > [<0>] sock_do_ioctl+0x50/0x288
> > [<0>] compat_sock_ioctl+0x1b4/0x1aac
> > [<0>] __se_compat_sys_ioctl+0x100/0x26fc
> > [<0>] __arm64_compat_sys_ioctl+0x20/0x2c
> > [<0>] el0_svc_common+0xa4/0x154
> > [<0>] el0_svc_compat_handler+0x2c/0x38
> > [<0>] el0_svc_compat+0x8/0x18
> > [<0>] 0xffffffffffffffff
> >
> > callstack of rmmod:
> > [<0>] __switch_to+0x120/0x13c
> > [<0>] msleep+0x28/0x38
> > [<0>] ath10k_sdio_hif_stop+0x294/0x31c [ath10k_sdio]
> > [<0>] ath10k_core_stop+0x50/0x78 [ath10k_core]
> > [<0>] ath10k_halt+0x120/0x178 [ath10k_core]
> > [<0>] ath10k_stop+0x4c/0x8c [ath10k_core]
> > [<0>] drv_stop+0xe0/0x1e4 [mac80211]
> > [<0>] ieee80211_stop_device+0x48/0x54 [mac80211]
> > [<0>] ieee80211_do_stop+0x678/0x6f8 [mac80211]
> > [<0>] ieee80211_stop+0x20/0x30 [mac80211]
> > [<0>] __dev_close_many+0xb8/0x11c
> > [<0>] dev_close_many+0x70/0x100
> > [<0>] dev_close+0x4c/0x80
> > [<0>] cfg80211_shutdown_all_interfaces+0x50/0xcc [cfg80211]
> > [<0>] ieee80211_remove_interfaces+0x58/0x1a0 [mac80211]
> > [<0>] ieee80211_unregister_hw+0x40/0x100 [mac80211]
> > [<0>] ath10k_mac_unregister+0x1c/0x44 [ath10k_core]
> > [<0>] ath10k_core_unregister+0x38/0x7c [ath10k_core]
> > [<0>] ath10k_sdio_remove+0x8c/0xd0 [ath10k_sdio]
> > [<0>] sdio_bus_remove+0x48/0x108
> > [<0>] device_release_driver_internal+0x138/0x1ec
> > [<0>] driver_detach+0x6c/0xa8
> > [<0>] bus_remove_driver+0x78/0xa8
> > [<0>] driver_unregister+0x30/0x50
> > [<0>] sdio_unregister_driver+0x28/0x34
> > [<0>] cleanup_module+0x14/0x6bc [ath10k_sdio]
> > [<0>] __arm64_sys_delete_module+0x1e0/0x22c
> > [<0>] el0_svc_common+0xa4/0x154
> > [<0>] el0_svc_compat_handler+0x2c/0x38
> > [<0>] el0_svc_compat+0x8/0x18
> > [<0>] 0xffffffffffffffff
> >
> > The test command run simulate_fw_crash firstly and it call into
> > ath10k_sdio_hif_stop from ath10k_core_restart, then napi_disable
> > is called and bit NAPI_STATE_SCHED is set. After that, function
> > ath10k_sdio_hif_stop is called again from ath10k_stop by command
> > "ifconfig wlan0 down" or "rmmod ath10k_sdio", then command blocked.
> >
> > It is blocked by napi_synchronize, napi_disable will set bit with
> > NAPI_STATE_SCHED, and then napi_synchronize will enter dead loop
> > becuase bit NAPI_STATE_SCHED is set by napi_disable.
> >
> > function of napi_synchronize
> > static inline void napi_synchronize(const struct napi_struct *n)
> > {
> >       if (IS_ENABLED(CONFIG_SMP))
> >               while (test_bit(NAPI_STATE_SCHED, &n->state))
> >                       msleep(1);
> >       else
> >               barrier();
> > }
> >
> > function of napi_disable
> > void napi_disable(struct napi_struct *n)
> > {
> >       might_sleep();
> >       set_bit(NAPI_STATE_DISABLE, &n->state);
> >
> >       while (test_and_set_bit(NAPI_STATE_SCHED, &n->state))
> >               msleep(1);
> >       while (test_and_set_bit(NAPI_STATE_NPSVC, &n->state))
> >               msleep(1);
> >
> >       hrtimer_cancel(&n->timer);
> >
> >       clear_bit(NAPI_STATE_DISABLE, &n->state);
> > }
> >
> > Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00042.
> >
> > Signed-off-by: Wen Gong <wgong@codeaurora.org>
> > ---
> >  drivers/net/wireless/ath/ath10k/sdio.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
> > index 7b894dcaad2e..b71499b171c6 100644
> > --- a/drivers/net/wireless/ath/ath10k/sdio.c
> > +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> > @@ -1756,8 +1756,6 @@ static int ath10k_sdio_hif_start(struct ath10k *ar)
> >       struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
> >       int ret;
> >
> > -     napi_enable(&ar->napi);
> > -
> >       /* Sleep 20 ms before HIF interrupts are disabled.
> >        * This will give target plenty of time to process the BMI done
> >        * request before interrupts are disabled.
> > @@ -1884,7 +1882,6 @@ static void ath10k_sdio_hif_stop(struct ath10k *ar)
> >       spin_unlock_bh(&ar_sdio->wr_async_lock);
> >
> >       napi_synchronize(&ar->napi);
> > -     napi_disable(&ar->napi);
> >  }
> >
> >  #ifdef CONFIG_PM
> > @@ -2121,6 +2118,7 @@ static int ath10k_sdio_probe(struct sdio_func *func,
> >
> >       netif_napi_add(&ar->napi_dev, &ar->napi, ath10k_sdio_napi_poll,
> >                      ATH10K_NAPI_BUDGET);
> > +     napi_enable(&ar->napi);
> >
> >       ath10k_dbg(ar, ATH10K_DBG_BOOT,
> >                  "sdio new func %d vendor 0x%x device 0x%x block 0x%x/0x%x\n",
> > @@ -2235,6 +2233,7 @@ static void ath10k_sdio_remove(struct sdio_func *func)
> >
> >       ath10k_core_unregister(ar);
> >
> > +     napi_disable(&ar->napi);
> >       netif_napi_del(&ar->napi);
> >
> >       ath10k_core_destroy(ar);
>
> I'm not really convinced that this is the right fix, but I'm no NAPI
> expert. Can anyone else help?
Calling napi_disable() twice can lead to hangs, but moving NAPI from
start/stop to
the probe isn't the right approach as the datapath is tied to start/stop.

Maybe check the state of NAPI before disable?

 if (test_bit(NAPI_STATE_SCHED, &ar->napi.napi.state))
  napi_disable(&ar->napi)

or maintain napi_state like this https://patchwork.kernel.org/patch/10249365/

Also, the most common cause for such issues (1st
napi_synchronize/napi_disable hang)
is that napi_poll is being scheduled, so, you might want to check that
napi_schedule isn't
called after stop.

cd ath10k; git log --grep=napi shows plenty of such issues. the one
that matches closest is
c2cac2f74ab4bcf0db0dcf3a612f1e5b52d145c8, so, it could just be a regression.
