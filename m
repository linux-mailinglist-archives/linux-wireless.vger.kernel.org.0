Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBF565AA1E
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Jan 2023 14:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjAAN3t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Jan 2023 08:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjAAN3s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Jan 2023 08:29:48 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C537E3892
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 05:29:45 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id o10-20020a056e02102a00b003006328df7bso16301048ilj.17
        for <linux-wireless@vger.kernel.org>; Sun, 01 Jan 2023 05:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJrTYtXkrhxe9xTeCysUakAqqFTIJN+FsVKxmA+OWM4=;
        b=Geu4qXll26EBHuh5uV/W59smkpYxoE28fcuRgADspJAPW7lSFcDizlCkzaCGPU/XoX
         QOajSSbgK2tQh8S1Ph5Ll8EiCKnCPSUIAhRhE3QUpB3pDJtuOX+SqfXNlsZiphMtIVDM
         196w3m0bmbMlMDqalvJHvarvo58LQiPYb0u6ufdq5Igr3LAfFHhjkuJ25l0ytwhOhYHG
         rDFueBak5uMLV+yaRhAi7KXVa/IqT7Y4+ZF1KUZ8b7txeZ5Gni7mgC3K7nFaVbkE6XPI
         qvGNiLW/dMb5dMTEn4wTudJke4gzbtLwMQU3vbbTbA9/y+LvilrXejr36KRbnEOtR76u
         tQUQ==
X-Gm-Message-State: AFqh2krKB+UYgDnlDoPVGpQeBWM/AXXctDOPY/gW8OSk5zO7VIQJVkMY
        1ew4HXxXMzAsw7Pu1BPh2a1+PKNEFR7Npl94uEc9lpbh8tdB
X-Google-Smtp-Source: AMrXdXv2Jri5CVaxogWE649lcSUg9xCzPks/6o+gBH0oIn0IiDMWBc/CZ4bRvZddpzd1bRtiir8l1u9hOsItbPJGMh+dq8cLHulj
MIME-Version: 1.0
X-Received: by 2002:a02:9448:0:b0:39d:3dda:5d26 with SMTP id
 a66-20020a029448000000b0039d3dda5d26mr2796516jai.30.1672579785153; Sun, 01
 Jan 2023 05:29:45 -0800 (PST)
Date:   Sun, 01 Jan 2023 05:29:45 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3e5f805f133d3f7@google.com>
Subject: [syzbot] memory leak in __build_skb (3)
From:   syzbot <syzbot+e008dccab31bd3647609@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        kvalo@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com, toke@toke.dk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1b929c02afd3 Linux 6.2-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b7126c480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4fb7ad9185f1501
dashboard link: https://syzkaller.appspot.com/bug?extid=e008dccab31bd3647609
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ee522f880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d6e73c480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/800650ebc0df/disk-1b929c02.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b1f1852b762a/vmlinux-1b929c02.xz
kernel image: https://storage.googleapis.com/syzbot-assets/15ebd3d96567/bzImage-1b929c02.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e008dccab31bd3647609@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810535b500 (size 240):
  comm "softirq", pid 0, jiffies 4294946605 (age 8.190s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83b0df31>] __build_skb+0x21/0x60 net/core/skbuff.c:377
    [<ffffffff83b0e23e>] __netdev_alloc_skb+0x14e/0x220 net/core/skbuff.c:657
    [<ffffffff82e49530>] __dev_alloc_skb include/linux/skbuff.h:3165 [inline]
    [<ffffffff82e49530>] ath9k_hif_usb_rx_stream drivers/net/wireless/ath/ath9k/hif_usb.c:635 [inline]
    [<ffffffff82e49530>] ath9k_hif_usb_rx_cb+0x1d0/0x660 drivers/net/wireless/ath/ath9k/hif_usb.c:686
    [<ffffffff8302c52c>] __usb_hcd_giveback_urb+0xfc/0x230 drivers/usb/core/hcd.c:1671
    [<ffffffff8302c80b>] usb_hcd_giveback_urb+0x1ab/0x1c0 drivers/usb/core/hcd.c:1754
    [<ffffffff831d5874>] dummy_timer+0x8e4/0x14c0 drivers/usb/gadget/udc/dummy_hcd.c:1988
    [<ffffffff8132a8b3>] call_timer_fn+0x33/0x1f0 kernel/time/timer.c:1700
    [<ffffffff8132ab6f>] expire_timers+0xff/0x1d0 kernel/time/timer.c:1751
    [<ffffffff8132ad69>] __run_timers kernel/time/timer.c:2022 [inline]
    [<ffffffff8132ad69>] __run_timers kernel/time/timer.c:1995 [inline]
    [<ffffffff8132ad69>] run_timer_softirq+0x129/0x2f0 kernel/time/timer.c:2035
    [<ffffffff84908afb>] __do_softirq+0xeb/0x2ef kernel/softirq.c:571



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
