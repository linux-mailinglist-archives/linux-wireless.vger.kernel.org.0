Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B0B574A18
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jul 2022 12:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbiGNKGK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jul 2022 06:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238111AbiGNKFh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jul 2022 06:05:37 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7474551426
        for <linux-wireless@vger.kernel.org>; Thu, 14 Jul 2022 03:05:36 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id b12so694930ilh.4
        for <linux-wireless@vger.kernel.org>; Thu, 14 Jul 2022 03:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LDjJyUSkOlX/2H1Dive48wrqPvTAsUMOt9cw//VSMrc=;
        b=q1ELvm7oR2NzdBi0ujuceOdlQGdJDpT6NOD0OWgbFKut+pagnhtHwWyGvGP9U3ZGtS
         T5W2f7V7NVLLh5thUxJu8HdFyw9nt+UlY9k4orcm2mTey0WMn5Oc3dI5JUVftBoyACFS
         Vv80H1u6uxGbWudW5F+spfFRWGqzrxqXS7MQ5QgtzhqdlazfQzQaAEwPDeiHy25FRyy0
         /5bnNaL4CO/p9vZXkVmtODglknULaKGMvWEVFJ/jZdI8N7n5vLcj4xbdQGoB/quX9ljG
         EfhswoCJ4uXi1g4e+68BdP/EAXH2a7U61w5p0/8WjW/iwWibrDHcwmdliWCUe/bwNAEp
         w1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LDjJyUSkOlX/2H1Dive48wrqPvTAsUMOt9cw//VSMrc=;
        b=4E0DnkJTUa0xgEc5E7kGMdGu8A8Sl50n4GS+iub2FtSd1rp/pf4hLOy5bWHz6pmG+D
         VR/kdGlE1mA75PGNaF2DTT5GL6X1xz8jQ4hLc5XhZPOXKPfo81GTyPuY1baOGeiI3pWj
         jwzrZdjzYAmyqtmVwhZ0kve6dwME+VvyVaX0Q2KONo8sQubPkRL8nUUsmjaWaaJMGSA7
         qJ6CHLLBQt5Gy07jBjIZhmySk0tKjJVHKBjfngjliXLQbJY06si2nnrZGtwmBnsKnqDS
         lrWG7el81dA6+Bab/QTUdWSygfU0YOCAu4+QectNEr1vHsyazJUa9vFe+eMcU9NBIlbT
         j0rg==
X-Gm-Message-State: AJIora8pz227SL0cJ1nYvMeE+VUGAnN4VqeRM2noCVvXJ0y6UzTTaNVN
        OQlhPwF9s5q3lb3U311eWlNZT3ua/CMMOfukf66LjxJ71AhnEQ==
X-Google-Smtp-Source: AGRyM1tXPEiF/Ebqv0UIK3YrJR3rUIt+FlvFw69mtkWy5wB9QvELbcveOsX3e0Zj139v8uMp69Irif9XkGwkT3QHZp4=
X-Received: by 2002:a05:6e02:20e9:b0:2dc:734b:d52b with SMTP id
 q9-20020a056e0220e900b002dc734bd52bmr4366286ilv.261.1657793135719; Thu, 14
 Jul 2022 03:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <id1HN6qCMAirApBzTA6fT7ZFWBBGCJhULpflxQ7NT6cgCboVnn3RHpiOFjA9SbRqzBRFLk9ES0C4FNvO6fUQsNg7pqF6ZSNAYUo99nHy8PY=@dannyvanheumen.nl>
In-Reply-To: <id1HN6qCMAirApBzTA6fT7ZFWBBGCJhULpflxQ7NT6cgCboVnn3RHpiOFjA9SbRqzBRFLk9ES0C4FNvO6fUQsNg7pqF6ZSNAYUo99nHy8PY=@dannyvanheumen.nl>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Jul 2022 12:04:59 +0200
Message-ID: <CAPDyKFpa6Z0Uhb0OnhMJ-KTQg5CQW93KMz1j1cQJS-Ho8FVhmQ@mail.gmail.com>
Subject: Re: [PATCH v5] brcmfmac: prevent double-free on hardware-reset
To:     Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 12 Jul 2022 at 01:22, Danny van Heumen <danny@dannyvanheumen.nl> wrote:
>
> In case of buggy firmware, brcmfmac may perform a hardware reset. If during
> reset and subsequent probing an early failure occurs, a memory region is
> accidentally double-freed. With hardened memory allocation enabled, this error
> will be detected.
>
> - return early where appropriate to skip unnecessary clean-up.
> - set '.freezer' pointer to NULL to prevent double-freeing under possible
>   other circumstances and to re-align result under various different
>   behaviors of memory allocation freeing.
> - correctly claim host on func1 for disabling func2.
> - after reset, do not initiate probing immediately, but rely on events.
>
> Given a firmware crash, function 'brcmf_sdio_bus_reset' is called. It calls
> 'brcmf_sdiod_remove', then follows up with 'brcmf_sdiod_probe' to reinitialize
> the hardware. If 'brcmf_sdiod_probe' fails to "set F1 blocksize", it exits
> early, which includes calling 'brcmf_sdiod_remove'. In both cases
> 'brcmf_sdiod_freezer_detach' is called to free allocated '.freezer', which
> has not yet been re-allocated the second time.
>
> Stacktrace of (failing) hardware reset after firmware-crash:
>
> Code: b9402b82 8b0202c0 eb1a02df 54000041 (d4210000)
>  ret_from_fork+0x10/0x20
>  kthread+0x154/0x160
>  worker_thread+0x188/0x504
>  process_one_work+0x1f4/0x490
>  brcmf_core_bus_reset+0x34/0x44 [brcmfmac]
>  brcmf_sdio_bus_reset+0x68/0xc0 [brcmfmac]
>  brcmf_sdiod_probe+0x170/0x21c [brcmfmac]
>  brcmf_sdiod_remove+0x48/0xc0 [brcmfmac]
>  kfree+0x210/0x220
>  __slab_free+0x58/0x40c
> Call trace:
> x2 : 0000000000000040 x1 : fffffc00002d2b80 x0 : ffff00000b4aee40
> x5 : ffff8000013fa728 x4 : 0000000000000001 x3 : ffff00000b4aee00
> x8 : ffff800009967ce0 x7 : ffff8000099bfce0 x6 : 00000006f8005d01
> x11: ffff8000099bfce0 x10: 00000000fffff000 x9 : ffff8000083401d0
> x14: 0000000000000000 x13: 657a69736b636f6c x12: 6220314620746573
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000030
> x20: fffffc00002d2ba0 x19: fffffc00002d2b80 x18: 0000000000000000
> x23: ffff00000b4aee00 x22: ffff00000b4aee00 x21: 0000000000000001
> x26: ffff00000b4aee00 x25: ffff0000f7753705 x24: 000000000001288a
> x29: ffff80000a22bbf0 x28: ffff000000401200 x27: 000000008020001a
> sp : ffff80000a22bbf0
> lr : kfree+0x210/0x220
> pc : __slab_free+0x58/0x40c
> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> Workqueue: events brcmf_core_bus_reset [brcmfmac]
> Hardware name: Pine64 Pinebook Pro (DT)
> CPU: 2 PID: 639 Comm: kworker/2:2 Tainted: G         C        5.16.0-0.bpo.4-arm64 #1  Debian 5.16.12-1~bpo11+1
>  nvmem_rockchip_efuse industrialio_triggered_buffer videodev snd_soc_core snd_pcm_dmaengine kfifo_buf snd_pcm io_domain mc industrialio mt>
> Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq_device nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reje>
> Internal error: Oops - BUG: 0 [#1] SMP
> kernel BUG at mm/slub.c:379!
>
> Signed-off-by: Danny van Heumen <danny@dannyvanheumen.nl>

I have to admit that, to me, it looks a bit weird to have one driver
instance managing two different SDIO func devices. On the other hand,
I don't know the HW so there might be good reasons for why.

In any case, I want to point out a commit [1] for the mwifiex driver,
which could serve as a good inspiration of how to make use of the
mmc_hw_reset(). For example, one may look at the return code from
mmc_hw_reset() to understand whether the reset will be done
synchronous or asynchronous (via device re-registration).

That said, I think the $subject patch looks reasonable to me. So feel
free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

[1]
cdb2256f795e ("mwifiex: Re-work support for SDIO HW reset")

> ---
>  .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c   | 13 +++++--------
>  .../net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 10 +---------
>  2 files changed, 6 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> index ac02244a6fdf..414ee21f42e3 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> @@ -802,6 +802,7 @@ static void brcmf_sdiod_freezer_detach(struct brcmf_sdio_dev *sdiodev)
>         if (sdiodev->freezer) {
>                 WARN_ON(atomic_read(&sdiodev->freezer->freezing));
>                 kfree(sdiodev->freezer);
> +               sdiodev->freezer = NULL;
>         }
>  }
>
> @@ -875,13 +876,9 @@ int brcmf_sdiod_remove(struct brcmf_sdio_dev *sdiodev)
>
>         brcmf_sdiod_freezer_detach(sdiodev);
>
> -       /* Disable Function 2 */
> -       sdio_claim_host(sdiodev->func2);
> -       sdio_disable_func(sdiodev->func2);
> -       sdio_release_host(sdiodev->func2);
> -
> -       /* Disable Function 1 */
> +       /* Disable functions 2 then 1. */
>         sdio_claim_host(sdiodev->func1);
> +       sdio_disable_func(sdiodev->func2);
>         sdio_disable_func(sdiodev->func1);
>         sdio_release_host(sdiodev->func1);
>
> @@ -911,7 +908,7 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
>         if (ret) {
>                 brcmf_err("Failed to set F1 blocksize\n");
>                 sdio_release_host(sdiodev->func1);
> -               goto out;
> +               return ret;
>         }
>         switch (sdiodev->func2->device) {
>         case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
> @@ -933,7 +930,7 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
>         if (ret) {
>                 brcmf_err("Failed to set F2 blocksize\n");
>                 sdio_release_host(sdiodev->func1);
> -               goto out;
> +               return ret;
>         } else {
>                 brcmf_dbg(SDIO, "set F2 blocksize to %d\n", f2_blksz);
>         }
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> index 212fbbe1cd7e..2ed70f809097 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> @@ -4152,7 +4152,6 @@ int brcmf_sdio_get_fwname(struct device *dev, const char *ext, u8 *fw_name)
>
>  static int brcmf_sdio_bus_reset(struct device *dev)
>  {
> -       int ret = 0;
>         struct brcmf_bus *bus_if = dev_get_drvdata(dev);
>         struct brcmf_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
>
> @@ -4169,14 +4168,7 @@ static int brcmf_sdio_bus_reset(struct device *dev)
>         sdio_release_host(sdiodev->func1);
>
>         brcmf_bus_change_state(sdiodev->bus_if, BRCMF_BUS_DOWN);
> -
> -       ret = brcmf_sdiod_probe(sdiodev);
> -       if (ret) {
> -               brcmf_err("Failed to probe after sdio device reset: ret %d\n",
> -                         ret);
> -       }
> -
> -       return ret;
> +       return 0;
>  }
>
>  static const struct brcmf_bus_ops brcmf_sdio_bus_ops = {
> --
> 2.34.1
>
