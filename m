Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D5C588100
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Aug 2022 19:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiHBR2o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Aug 2022 13:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiHBR2n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Aug 2022 13:28:43 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DD449B7E
        for <linux-wireless@vger.kernel.org>; Tue,  2 Aug 2022 10:28:42 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id z19so14105466plb.1
        for <linux-wireless@vger.kernel.org>; Tue, 02 Aug 2022 10:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=matician-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=XqQF25ac2l268JtpnnExAQm1fo+B/IRlhKl2qkgoAiw=;
        b=DOY3Ghe8VtGtVzsEvTzYVCa1qEza79tRezeS+NN+pgcT5FA9RJ0o48w6p7ywktO4G2
         3QcflXGqIlxHcvV9dt7vcVbaAY6ySHniY3dYCLtncCo3x9F+43mj27Z1h90nBeWXYsz5
         h5wQ0dsPfDgWkK8suXrjLmAaAC03BnG+Pa4OR7330jXt+V5d4cJVV1+AKtqAXjO28bLV
         Li2PE8cRE02h5j87z8BV/+W4Ag0QSRv1fO1jb8Ku/zaIHcDfNErzKAa2aohOCYotuwix
         jujWwAf1H9jT8OBLX/g/uesAXd2fqP79nYJtaWEQ4z2SjFdgshZyUjH6cLA4KEhcYU2U
         H3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=XqQF25ac2l268JtpnnExAQm1fo+B/IRlhKl2qkgoAiw=;
        b=3dGN88dcNf1mXxR9mIqoLfcTtankD3Crcaf1NR5IKsfXWsCL8/stLaPdoYhj7OzACp
         b5lre5v5lVR/v0sO8XA49LAi7+HdzaXSZacWUY5tbVxwKJTYhcA6h7PRr0GNfSOnC7Vu
         uYzU1YkNy8lxY7UAr7HwvqtAnGHpkVKKTCC/ZrQTZ5aqxcSI5BFA7Fc2fcnu3p9jeKGE
         4YVcioSz8FhqBf0U1Tfesnz0VcVElZ4vPiikLd2X31gNmM2Zu0HfDb8yRGK2gUdqqdps
         gCYWbOxr3JFCAnEKLHYzgEbUcIngwcszigQgYTBhmNcTAFyWoOm8bbin24Kk+w1O5qAu
         P4mA==
X-Gm-Message-State: ACgBeo1FJBek4CWrSjsFFtyZ44atWaLoDLCF0GII+pykJGrWogcUOeAR
        /5HuGoo3XSotmqA99CpJK+Bnew==
X-Google-Smtp-Source: AA6agR4aq18EAkjYoImOqa+ZILpagKc7tGzgEm73agkz9YfsCdcA6CNb44sR2XK9UzCTHULMBIE9gQ==
X-Received: by 2002:a17:90b:1c08:b0:1f2:19da:aa04 with SMTP id oc8-20020a17090b1c0800b001f219daaa04mr576553pjb.90.1659461321927;
        Tue, 02 Aug 2022 10:28:41 -0700 (PDT)
Received: from coffindebian.corp.matician.com (64-71-25-152.static.wiline.com. [64.71.25.152])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902ec8900b0016c3affe60esm12339056plg.46.2022.08.02.10.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 10:28:41 -0700 (PDT)
From:   Alexander Coffin <alex.coffin@matician.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: brcmfmac: fix use-after-free bug
Date:   Tue,  2 Aug 2022 10:28:22 -0700
Message-Id: <20220802172823.1696680-1-alex.coffin@matician.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The following use-after-free is addressed by this patch. I have not used git
send-email in a long time, and I have never contributed to the Linux kernel
before so I have you can forgive, and correct and mistakes that I may have made
in my process of submitting this patch.

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



