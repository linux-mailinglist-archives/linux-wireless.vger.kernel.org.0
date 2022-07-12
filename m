Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4695713F6
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jul 2022 10:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiGLIIu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Jul 2022 04:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiGLIIq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Jul 2022 04:08:46 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EC6B8B
        for <linux-wireless@vger.kernel.org>; Tue, 12 Jul 2022 01:08:45 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id f11so6031067pgj.7
        for <linux-wireless@vger.kernel.org>; Tue, 12 Jul 2022 01:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pzJTgHxnVDfTRaJRoB3wwlxvvS4lZP03lPF4R3W+UM0=;
        b=X3BEJ/zfAFm6L3cV3zyNpVGacJU4hfM2Ed7E8dzJvVK72VSr6lHHUBEKW9cOgGy9vn
         lIAu/TcBcWIbNAFkOCVArhbD6a4VhxquVxBTkQW23IJ5Ab4t+VKvuKudSJdeeX85iTn8
         eo1IDVCAWTq1Bxwz0LbAr8Ymkye0tPETo6rOLe9eHE3ZqD9iLmAwQHGFsqKp+y20Ei+3
         ii6EMZ9fJPU2STorUnxQbsF/y00N4nQNjKQa06r1dd1KvUh1DHdwx5cjTt0oAYZZIviH
         zZ4fvhb9R2BFZrS5xY7uNTMeBdlO2dPL7NWg0gnQukAebVsmJtD1IGkpIPmusz5bhJr8
         oTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pzJTgHxnVDfTRaJRoB3wwlxvvS4lZP03lPF4R3W+UM0=;
        b=ScLlRWG5hiTK8t3AlRF/KNOHgd844Jf1ZlpJkTgCjE207s+2nGe2I1OW4oC8cRIZmZ
         0ldRzajdwigcJO1C0uZ6S4bJMKgZ5e1Nn/cOPjjXzGv1i0/jnXC5R7D4YO3FwC1Q490J
         VHUz5XshUbI9nm7w5A/WzeENnaqceHdv8MwVwosott591sSiJBKvrpyigHYFMc0xT+H9
         Ie/rimtELPAjjwVmFifITrOyMktooOFzYzcK6ZBWpPtVU4zuFK4e5/latuHh1PhtQ14y
         Ab+VshBBmx+5MGTjhQ57sPYzElqN4ROrpLmzhZ7CTVltDBg4TiycCFZDXLfUh6tuxLRZ
         v+xA==
X-Gm-Message-State: AJIora/49ISwqWH38jVoIBkPDOk7BDJoNavaK9uXc4UZAb8i11HMUQXp
        y/DI9FwdoMD+7iYk17r2lrQ=
X-Google-Smtp-Source: AGRyM1t/4i/+AC+R3PKe/4AcCHJW23qfQBDTi2+uNj90LqQROU2Nehwnw6Yizx5KiEv56gqTHDDUnw==
X-Received: by 2002:a62:2546:0:b0:505:b6d2:abc8 with SMTP id l67-20020a622546000000b00505b6d2abc8mr22851366pfl.11.1657613324616;
        Tue, 12 Jul 2022 01:08:44 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id q190-20020a632ac7000000b00412434a6fcesm5440145pgq.68.2022.07.12.01.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 01:08:43 -0700 (PDT)
Message-ID: <bea1f663-0dfd-e1c4-29c5-1f6251a24c31@gmail.com>
Date:   Tue, 12 Jul 2022 10:08:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5] brcmfmac: prevent double-free on hardware-reset
Content-Language: en-US
To:     Danny van Heumen <danny@dannyvanheumen.nl>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <id1HN6qCMAirApBzTA6fT7ZFWBBGCJhULpflxQ7NT6cgCboVnn3RHpiOFjA9SbRqzBRFLk9ES0C4FNvO6fUQsNg7pqF6ZSNAYUo99nHy8PY=@dannyvanheumen.nl>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <id1HN6qCMAirApBzTA6fT7ZFWBBGCJhULpflxQ7NT6cgCboVnn3RHpiOFjA9SbRqzBRFLk9ES0C4FNvO6fUQsNg7pqF6ZSNAYUo99nHy8PY=@dannyvanheumen.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/12/2022 1:21 AM, Danny van Heumen wrote:
> In case of buggy firmware, brcmfmac may perform a hardware reset. If during
> reset and subsequent probing an early failure occurs, a memory region is
> accidentally double-freed. With hardened memory allocation enabled, this error
> will be detected.
> 
> - return early where appropriate to skip unnecessary clean-up.
> - set '.freezer' pointer to NULL to prevent double-freeing under possible
>    other circumstances and to re-align result under various different
>    behaviors of memory allocation freeing.
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
>   ret_from_fork+0x10/0x20
>   kthread+0x154/0x160
>   worker_thread+0x188/0x504
>   process_one_work+0x1f4/0x490
>   brcmf_core_bus_reset+0x34/0x44 [brcmfmac]
>   brcmf_sdio_bus_reset+0x68/0xc0 [brcmfmac]
>   brcmf_sdiod_probe+0x170/0x21c [brcmfmac]
>   brcmf_sdiod_remove+0x48/0xc0 [brcmfmac]
>   kfree+0x210/0x220
>   __slab_free+0x58/0x40c
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
>   nvmem_rockchip_efuse industrialio_triggered_buffer videodev snd_soc_core snd_pcm_dmaengine kfifo_buf snd_pcm io_domain mc industrialio mt>
> Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq_device nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reje>
> Internal error: Oops - BUG: 0 [#1] SMP
> kernel BUG at mm/slub.c:379!

Reviewed-by: Arend van Spriel <aspriel.gmail.com>
> Signed-off-by: Danny van Heumen <danny@dannyvanheumen.nl>
> ---
>   .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c   | 13 +++++--------
>   .../net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 10 +---------
>   2 files changed, 6 insertions(+), 17 deletions(-)
