Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B505AFE39
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Sep 2022 09:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiIGH5d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Sep 2022 03:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiIGH5a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Sep 2022 03:57:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE158A8304
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 00:57:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27208616EF
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 07:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0711C433D6;
        Wed,  7 Sep 2022 07:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662537444;
        bh=qxK25gBTPVPe8NGhGr7OBlcBbqybg2HbOoJia7k8/Gg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=maetztPPxBlBkcV7PGBqynFCbmY/8DAwN/8FWZZcloNUBbSFNk8rJleU39gANDfcE
         4ZkyUJRfD7p7uAAqU05HguNi4dM2MOfL1ZFejFDmhokc2KVzEa1q7kjpXNQ7nnrbXf
         +O+htihm0HtZltnxXyBVNzSewh1BE5DmXdgqzZeuMO/BUO8mgawxsGsuyiOW+jCxw3
         XNnjt28y6Doh1o8fBF4BQm8ARhOpmbWhYQ9cYP0IOCDyM7UeKA2cP+daxAZdcKk+yq
         3M2e9nfohiVzZO2Fxo0F0n3TnEOZggknxW+sgMWmOrH5JvmqnnOtbcs210IwXk8q7t
         QWOLV7T6tCUTA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2] wifi: brcmfmac: fix use-after-free bug in
 brcmf_netdev_start_xmit()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220808174925.3922558-1-alex.coffin@matician.com>
References: <20220808174925.3922558-1-alex.coffin@matician.com>
To:     Alexander Coffin <alex.coffin@matician.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Alexander Coffin <alex.coffin@matician.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166253743736.23292.8785422233314184876.kvalo@kernel.org>
Date:   Wed,  7 Sep 2022 07:57:22 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Alexander Coffin <alex.coffin@matician.com> wrote:

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

Patch applied to wireless-next.git, thanks.

3f42faf6db43 wifi: brcmfmac: fix use-after-free bug in brcmf_netdev_start_xmit()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220808174925.3922558-1-alex.coffin@matician.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

