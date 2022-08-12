Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4E359129C
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 17:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238408AbiHLPF2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 11:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiHLPF1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 11:05:27 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2249118B1F
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 08:05:26 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id p132so1419335oif.9
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 08:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=matician-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Ou11NpUX/PKVUjIDBGH/iYkdtiXMJe9fKo2HGtXh2iI=;
        b=Ow5yUp3vGjOSzl7in5f+Dw0jH2eYLzsLvK3C88E64EFm0hiUeEatESWMCA4IESs7Ri
         7qmtZTToHbMKdSOi709OOIp1/+d4ngM3UqVOiuRn7Rixj9YpQ9nn8FF7d+/TtKAj8YEa
         qGjSB2bC7rtF1t1qUVhqF5vQJsKc+hodnT6UWevOuTNzjcXiRgQgcxrskS2r+xAnWilX
         eoLTqxAjHIj2rf4jZVg/XPkPRnr4KByH17nTT27bgAI8qp5TpYMpDMFBy8kcMAztplx+
         nbNn5V2r73RFFZeBPElVATZN4nSI15KW9AiEWUg74WCBGwQTVNY4OFJP7ZmJY1Cf4Rwp
         jl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Ou11NpUX/PKVUjIDBGH/iYkdtiXMJe9fKo2HGtXh2iI=;
        b=ZbfB6nITqhA1Gj/6stme7txPZi4Rc/cpL/6RK1eKR4H4FzCvarVIo3+r/+1pbqV5O+
         3Y8UOTQvlpkOdnL/cRpBB19zLksrf+hLbgivyeHmQBGqQmA1+UPqjf3r36tT5KdVL2Xz
         IKQ8x2O+GCwZS5pDV9VfSxkHjTzcayCedWiAvS4rSm54Ldqp6AN/uR77cqxoLVQuSasI
         GgY9s9rk/uyxpZXV14vok7JhcDJuevSn9RF8rRCHlQAbf6IS9bGbYy3vrVjx6kNTmjfJ
         mGsjw6YPAD9hftaZxlSL9/Rin6QV/x/nHN948dpWOXeo+P6h5Iiswr3ocF/s7dPOFs0x
         eEmQ==
X-Gm-Message-State: ACgBeo3kaF1CAOzQt6esR1ZceS/ZwKoL/NkwUBeHgjCqGXKNmkTNwcTg
        D2yOxYkYvC6qvLP3EgFv14SeW/JIovDQwQ7zOjS6+A==
X-Google-Smtp-Source: AA6agR5fRpNhZy5lewZgCg+vZhCoF8gnoVdiDKEs0W+omB4lznmbz6PzwmNOHiqbX3G1y7mL4cfuyqqbyhVEbSvHVc0=
X-Received: by 2002:aca:c186:0:b0:342:d121:25d2 with SMTP id
 r128-20020acac186000000b00342d12125d2mr1916583oif.147.1660316724863; Fri, 12
 Aug 2022 08:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <fa1879c7-ba9e-fcd7-9a5b-f6a187b74781@gmail.com> <20220808174925.3922558-1-alex.coffin@matician.com>
In-Reply-To: <20220808174925.3922558-1-alex.coffin@matician.com>
From:   Alexander Coffin <alex.coffin@matician.com>
Date:   Fri, 12 Aug 2022 08:05:08 -0700
Message-ID: <CA+hUFcuqofeHaOkYySJNJexcEvJE0K-yNk+15=BcDVFCa2k=FQ@mail.gmail.com>
Subject: Re: [PATCH v2] brcmfmac: fix use-after-free bug
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend,

I just wanted to double check that you have received my second patch
as I'm beginning to be slightly worried that your spam filters are
blocking my stack traces.

- Alexander Coffin

On Mon, Aug 8, 2022 at 10:50 AM Alexander Coffin
<alex.coffin@matician.com> wrote:
>
> > ret = brcmf_proto_tx_queue_data(drvr, ifp->ifidx, skb);
>
> may be schedule, and then complete before the line
>
> > ndev->stats.tx_bytes += skb->len;
>
> [   46.912801] ==================================================================
> [   46.920552] BUG: KASAN: use-after-free in brcmf_netdev_start_xmit+0x718/0x8c8 [brcmfmac]
> [   46.928673] Read of size 4 at addr ffffff803f5882e8 by task systemd-resolve/328
> [   46.935991]
> [   46.937514] CPU: 1 PID: 328 Comm: systemd-resolve Tainted: G           O      5.4.199-[REDACTED] #1
> [   46.947255] Hardware name: [REDACTED]
> [   46.954568] Call trace:
> [   46.957037]  dump_backtrace+0x0/0x2b8
> [   46.960719]  show_stack+0x24/0x30
> [   46.964052]  dump_stack+0x128/0x194
> [   46.967557]  print_address_description.isra.0+0x64/0x380
> [   46.972877]  __kasan_report+0x1d4/0x240
> [   46.976723]  kasan_report+0xc/0x18
> [   46.980138]  __asan_report_load4_noabort+0x18/0x20
> [   46.985027]  brcmf_netdev_start_xmit+0x718/0x8c8 [brcmfmac]
> [   46.990613]  dev_hard_start_xmit+0x1bc/0xda0
> [   46.994894]  sch_direct_xmit+0x198/0xd08
> [   46.998827]  __qdisc_run+0x37c/0x1dc0
> [   47.002500]  __dev_queue_xmit+0x1528/0x21f8
> [   47.006692]  dev_queue_xmit+0x24/0x30
> [   47.010366]  neigh_resolve_output+0x37c/0x678
> [   47.014734]  ip_finish_output2+0x598/0x2458
> [   47.018927]  __ip_finish_output+0x300/0x730
> [   47.023118]  ip_output+0x2e0/0x430
> [   47.026530]  ip_local_out+0x90/0x140
> [   47.030117]  igmpv3_sendpack+0x14c/0x228
> [   47.034049]  igmpv3_send_cr+0x384/0x6b8
> [   47.037895]  igmp_ifc_timer_expire+0x4c/0x118
> [   47.042262]  call_timer_fn+0x1cc/0xbe8
> [   47.046021]  __run_timers+0x4d8/0xb28
> [   47.049693]  run_timer_softirq+0x24/0x40
> [   47.053626]  __do_softirq+0x2c0/0x117c
> [   47.057387]  irq_exit+0x2dc/0x388
> [   47.060715]  __handle_domain_irq+0xb4/0x158
> [   47.064908]  gic_handle_irq+0x58/0xb0
> [   47.068581]  el0_irq_naked+0x50/0x5c
> [   47.072162]
> [   47.073665] Allocated by task 328:
> [   47.077083]  save_stack+0x24/0xb0
> [   47.080410]  __kasan_kmalloc.isra.0+0xc0/0xe0
> [   47.084776]  kasan_slab_alloc+0x14/0x20
> [   47.088622]  kmem_cache_alloc+0x15c/0x468
> [   47.092643]  __alloc_skb+0xa4/0x498
> [   47.096142]  igmpv3_newpack+0x158/0xd78
> [   47.099987]  add_grhead+0x210/0x288
> [   47.103485]  add_grec+0x6b0/0xb70
> [   47.106811]  igmpv3_send_cr+0x2e0/0x6b8
> [   47.110657]  igmp_ifc_timer_expire+0x4c/0x118
> [   47.115027]  call_timer_fn+0x1cc/0xbe8
> [   47.118785]  __run_timers+0x4d8/0xb28
> [   47.122457]  run_timer_softirq+0x24/0x40
> [   47.126389]  __do_softirq+0x2c0/0x117c
> [   47.130142]
> [   47.131643] Freed by task 180:
> [   47.134712]  save_stack+0x24/0xb0
> [   47.138041]  __kasan_slab_free+0x108/0x180
> [   47.142146]  kasan_slab_free+0x10/0x18
> [   47.145904]  slab_free_freelist_hook+0xa4/0x1b0
> [   47.150444]  kmem_cache_free+0x8c/0x528
> [   47.154292]  kfree_skbmem+0x94/0x108
> [   47.157880]  consume_skb+0x10c/0x5a8
> [   47.161466]  __dev_kfree_skb_any+0x88/0xa0
> [   47.165598]  brcmu_pkt_buf_free_skb+0x44/0x68 [brcmutil]
> [   47.171023]  brcmf_txfinalize+0xec/0x190 [brcmfmac]
> [   47.176016]  brcmf_proto_bcdc_txcomplete+0x1c0/0x210 [brcmfmac]
> [   47.182056]  brcmf_sdio_sendfromq+0x8dc/0x1e80 [brcmfmac]
> [   47.187568]  brcmf_sdio_dpc+0xb48/0x2108 [brcmfmac]
> [   47.192529]  brcmf_sdio_dataworker+0xc8/0x238 [brcmfmac]
> [   47.197859]  process_one_work+0x7fc/0x1a80
> [   47.201965]  worker_thread+0x31c/0xc40
> [   47.205726]  kthread+0x2d8/0x370
> [   47.208967]  ret_from_fork+0x10/0x18
> [   47.212546]
> [   47.214051] The buggy address belongs to the object at ffffff803f588280
> [   47.214051]  which belongs to the cache skbuff_head_cache of size 208
> [   47.227086] The buggy address is located 104 bytes inside of
> [   47.227086]  208-byte region [ffffff803f588280, ffffff803f588350)
> [   47.238814] The buggy address belongs to the page:
> [   47.243618] page:ffffffff00dd6200 refcount:1 mapcount:0 mapping:ffffff804b6bf800 index:0xffffff803f589900 compound_mapcount: 0
> [   47.255007] flags: 0x10200(slab|head)
> [   47.258689] raw: 0000000000010200 ffffffff00dfa980 0000000200000002 ffffff804b6bf800
> [   47.266439] raw: ffffff803f589900 0000000080190018 00000001ffffffff 0000000000000000
> [   47.274180] page dumped because: kasan: bad access detected
> [   47.279752]
> [   47.281251] Memory state around the buggy address:
> [   47.286051]  ffffff803f588180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [   47.293277]  ffffff803f588200: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   47.300502] >ffffff803f588280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [   47.307723]                                                           ^
> [   47.314343]  ffffff803f588300: fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc
> [   47.321569]  ffffff803f588380: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> [   47.328789] ==================================================================
>
> Signed-off-by: Alexander Coffin <alex.coffin@matician.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> index 87aef211b35f..12ee8b7163fd 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> @@ -296,6 +296,7 @@ static netdev_tx_t brcmf_netdev_start_xmit(struct sk_buff *skb,
>         struct brcmf_pub *drvr = ifp->drvr;
>         struct ethhdr *eh;
>         int head_delta;
> +       unsigned int tx_bytes = skb->len;
>
>         brcmf_dbg(DATA, "Enter, bsscfgidx=%d\n", ifp->bsscfgidx);
>
> @@ -370,7 +371,7 @@ static netdev_tx_t brcmf_netdev_start_xmit(struct sk_buff *skb,
>                 ndev->stats.tx_dropped++;
>         } else {
>                 ndev->stats.tx_packets++;
> -               ndev->stats.tx_bytes += skb->len;
> +               ndev->stats.tx_bytes += tx_bytes;
>         }
>
>         /* Return ok: we always eat the packet */
> --
> 2.30.2
>
