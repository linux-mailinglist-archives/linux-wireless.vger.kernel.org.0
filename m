Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30FA58CD09
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Aug 2022 19:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243874AbiHHRuU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Aug 2022 13:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243576AbiHHRuS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Aug 2022 13:50:18 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462E0D57
        for <linux-wireless@vger.kernel.org>; Mon,  8 Aug 2022 10:50:17 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so9811955pjf.5
        for <linux-wireless@vger.kernel.org>; Mon, 08 Aug 2022 10:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=matician-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2uLgVPF3hPniIzOaH2tVmzScivrhh1ffmhXJDKK6zzw=;
        b=C6Vj1WsdHnEOoEkYe44diB7UdZqNtlS/gIRtc/GKMBKdKRwUM0u84H8avxGQW3aO6k
         u5vrkVuqGDqFj4vpdxYXP8zpxhEuDUD8z6nYjZECtd7ldn8IiexAK0v21hoinmB0twYN
         rA/ozeJD+xs5w6RjzuSM3JuDwhYOhyWnuR4XZ9LJAnbyGMYHMEuXBRGnw/xGRKddBx9l
         SyEzd6gSHh7eCvmUuydqPnPb09Zqa3gEqJikkfZLlAEMZFikY8JIKSleqDAm6YXC+UTp
         qu74q/+qHeYHcxGW0lfr5JP9kliyLCcAlOqLj9IULtUmRB/msTKxXqStikK+miI1lDok
         dEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2uLgVPF3hPniIzOaH2tVmzScivrhh1ffmhXJDKK6zzw=;
        b=RlRakEAHSm5YbnQenRwz9brhw7YSdwBYccliMxzmZ2FsKyvKtn1aZLVjV5z3vpq1dP
         qzTqBJtCBZfW91YGE8jjlzodNtNDNqaSQ2A27rbwgMq1mPzCEIW5QueBkLjQx1uKUucz
         86YJmPTSDi8KC7D4qdQDTms2TidRKzvLzn1wwMaahXQ10yG7VxD9O2OCkAo7NLiEu+ZV
         TiMksCRs+B4Ri5wF8jP+/K+7diFpO0FjBOLN6Zpxyu7r0ckB59psURq/ngg9PAYFpm7v
         eplIFcyTyfmJAIHgbY48m6COdmpeosDdhgTsgfqtXIIKo/5W8BS2vc2TuCeYGqsgflfD
         oc8Q==
X-Gm-Message-State: ACgBeo3Hy7PLmxDN2fr6WT6FZsfnVa9CS5qjTuag06yzLiAsg1b03hpC
        sR5WB7dpws60T2c5L/OxnWQrJx/+9cEMJw==
X-Google-Smtp-Source: AA6agR5bCLQ6S6kDi8lCjjA9FM+jtoz0sJGTINgTTlGlLlQgKKNs6fZJ4VstJTVm4VJYd0bCC4hxLw==
X-Received: by 2002:a17:902:e80a:b0:16f:52e:21b1 with SMTP id u10-20020a170902e80a00b0016f052e21b1mr19460781plg.161.1659981016819;
        Mon, 08 Aug 2022 10:50:16 -0700 (PDT)
Received: from coffindebian.corp.matician.com (64-71-25-152.static.wiline.com. [64.71.25.152])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902d2c800b0016dc240b24bsm9135853plc.95.2022.08.08.10.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 10:50:16 -0700 (PDT)
From:   Alexander Coffin <alex.coffin@matician.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Alexander Coffin <alex.coffin@matician.com>
Subject: [PATCH v2] brcmfmac: fix use-after-free bug
Date:   Mon,  8 Aug 2022 10:49:26 -0700
Message-Id: <20220808174925.3922558-1-alex.coffin@matician.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <fa1879c7-ba9e-fcd7-9a5b-f6a187b74781@gmail.com>
References: <fa1879c7-ba9e-fcd7-9a5b-f6a187b74781@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> ret = brcmf_proto_tx_queue_data(drvr, ifp->ifidx, skb);

may be schedule, and then complete before the line

> ndev->stats.tx_bytes += skb->len;

[   46.912801] ==================================================================
[   46.920552] BUG: KASAN: use-after-free in brcmf_netdev_start_xmit+0x718/0x8c8 [brcmfmac]
[   46.928673] Read of size 4 at addr ffffff803f5882e8 by task systemd-resolve/328
[   46.935991]
[   46.937514] CPU: 1 PID: 328 Comm: systemd-resolve Tainted: G           O      5.4.199-[REDACTED] #1
[   46.947255] Hardware name: [REDACTED]
[   46.954568] Call trace:
[   46.957037]  dump_backtrace+0x0/0x2b8
[   46.960719]  show_stack+0x24/0x30
[   46.964052]  dump_stack+0x128/0x194
[   46.967557]  print_address_description.isra.0+0x64/0x380
[   46.972877]  __kasan_report+0x1d4/0x240
[   46.976723]  kasan_report+0xc/0x18
[   46.980138]  __asan_report_load4_noabort+0x18/0x20
[   46.985027]  brcmf_netdev_start_xmit+0x718/0x8c8 [brcmfmac]
[   46.990613]  dev_hard_start_xmit+0x1bc/0xda0
[   46.994894]  sch_direct_xmit+0x198/0xd08
[   46.998827]  __qdisc_run+0x37c/0x1dc0
[   47.002500]  __dev_queue_xmit+0x1528/0x21f8
[   47.006692]  dev_queue_xmit+0x24/0x30
[   47.010366]  neigh_resolve_output+0x37c/0x678
[   47.014734]  ip_finish_output2+0x598/0x2458
[   47.018927]  __ip_finish_output+0x300/0x730
[   47.023118]  ip_output+0x2e0/0x430
[   47.026530]  ip_local_out+0x90/0x140
[   47.030117]  igmpv3_sendpack+0x14c/0x228
[   47.034049]  igmpv3_send_cr+0x384/0x6b8
[   47.037895]  igmp_ifc_timer_expire+0x4c/0x118
[   47.042262]  call_timer_fn+0x1cc/0xbe8
[   47.046021]  __run_timers+0x4d8/0xb28
[   47.049693]  run_timer_softirq+0x24/0x40
[   47.053626]  __do_softirq+0x2c0/0x117c
[   47.057387]  irq_exit+0x2dc/0x388
[   47.060715]  __handle_domain_irq+0xb4/0x158
[   47.064908]  gic_handle_irq+0x58/0xb0
[   47.068581]  el0_irq_naked+0x50/0x5c
[   47.072162]
[   47.073665] Allocated by task 328:
[   47.077083]  save_stack+0x24/0xb0
[   47.080410]  __kasan_kmalloc.isra.0+0xc0/0xe0
[   47.084776]  kasan_slab_alloc+0x14/0x20
[   47.088622]  kmem_cache_alloc+0x15c/0x468
[   47.092643]  __alloc_skb+0xa4/0x498
[   47.096142]  igmpv3_newpack+0x158/0xd78
[   47.099987]  add_grhead+0x210/0x288
[   47.103485]  add_grec+0x6b0/0xb70
[   47.106811]  igmpv3_send_cr+0x2e0/0x6b8
[   47.110657]  igmp_ifc_timer_expire+0x4c/0x118
[   47.115027]  call_timer_fn+0x1cc/0xbe8
[   47.118785]  __run_timers+0x4d8/0xb28
[   47.122457]  run_timer_softirq+0x24/0x40
[   47.126389]  __do_softirq+0x2c0/0x117c
[   47.130142]
[   47.131643] Freed by task 180:
[   47.134712]  save_stack+0x24/0xb0
[   47.138041]  __kasan_slab_free+0x108/0x180
[   47.142146]  kasan_slab_free+0x10/0x18
[   47.145904]  slab_free_freelist_hook+0xa4/0x1b0
[   47.150444]  kmem_cache_free+0x8c/0x528
[   47.154292]  kfree_skbmem+0x94/0x108
[   47.157880]  consume_skb+0x10c/0x5a8
[   47.161466]  __dev_kfree_skb_any+0x88/0xa0
[   47.165598]  brcmu_pkt_buf_free_skb+0x44/0x68 [brcmutil]
[   47.171023]  brcmf_txfinalize+0xec/0x190 [brcmfmac]
[   47.176016]  brcmf_proto_bcdc_txcomplete+0x1c0/0x210 [brcmfmac]
[   47.182056]  brcmf_sdio_sendfromq+0x8dc/0x1e80 [brcmfmac]
[   47.187568]  brcmf_sdio_dpc+0xb48/0x2108 [brcmfmac]
[   47.192529]  brcmf_sdio_dataworker+0xc8/0x238 [brcmfmac]
[   47.197859]  process_one_work+0x7fc/0x1a80
[   47.201965]  worker_thread+0x31c/0xc40
[   47.205726]  kthread+0x2d8/0x370
[   47.208967]  ret_from_fork+0x10/0x18
[   47.212546]
[   47.214051] The buggy address belongs to the object at ffffff803f588280
[   47.214051]  which belongs to the cache skbuff_head_cache of size 208
[   47.227086] The buggy address is located 104 bytes inside of
[   47.227086]  208-byte region [ffffff803f588280, ffffff803f588350)
[   47.238814] The buggy address belongs to the page:
[   47.243618] page:ffffffff00dd6200 refcount:1 mapcount:0 mapping:ffffff804b6bf800 index:0xffffff803f589900 compound_mapcount: 0
[   47.255007] flags: 0x10200(slab|head)
[   47.258689] raw: 0000000000010200 ffffffff00dfa980 0000000200000002 ffffff804b6bf800
[   47.266439] raw: ffffff803f589900 0000000080190018 00000001ffffffff 0000000000000000
[   47.274180] page dumped because: kasan: bad access detected
[   47.279752]
[   47.281251] Memory state around the buggy address:
[   47.286051]  ffffff803f588180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   47.293277]  ffffff803f588200: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   47.300502] >ffffff803f588280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   47.307723]                                                           ^
[   47.314343]  ffffff803f588300: fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc
[   47.321569]  ffffff803f588380: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
[   47.328789] ==================================================================

Signed-off-by: Alexander Coffin <alex.coffin@matician.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 87aef211b35f..12ee8b7163fd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -296,6 +296,7 @@ static netdev_tx_t brcmf_netdev_start_xmit(struct sk_buff *skb,
 	struct brcmf_pub *drvr = ifp->drvr;
 	struct ethhdr *eh;
 	int head_delta;
+	unsigned int tx_bytes = skb->len;
 
 	brcmf_dbg(DATA, "Enter, bsscfgidx=%d\n", ifp->bsscfgidx);
 
@@ -370,7 +371,7 @@ static netdev_tx_t brcmf_netdev_start_xmit(struct sk_buff *skb,
 		ndev->stats.tx_dropped++;
 	} else {
 		ndev->stats.tx_packets++;
-		ndev->stats.tx_bytes += skb->len;
+		ndev->stats.tx_bytes += tx_bytes;
 	}
 
 	/* Return ok: we always eat the packet */
-- 
2.30.2

