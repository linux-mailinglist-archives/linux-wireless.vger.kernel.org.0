Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB07F2798C3
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Sep 2020 14:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgIZMJY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Sep 2020 08:09:24 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:53383 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbgIZMJY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Sep 2020 08:09:24 -0400
Received: by mail-io1-f72.google.com with SMTP id x1so3975736iov.20
        for <linux-wireless@vger.kernel.org>; Sat, 26 Sep 2020 05:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=G3CO8apcR3uPwIt5d5uUeceIwwic8mBs/bCybEWaLjQ=;
        b=PkUU3G6YpKwjRNTCyGdnLsshwjsFLeyNu0zYlPW+wobU+Rnv5uMUGGau1EBAp7S5DW
         U3FO64rOiPsmtHSzLqfNNnM4cnemIEBZ8GEdfgbky+eVFG1GEqyIyYmCzU1gT5g5eRvF
         jr3B+3Z8CRbHjBpe7tgeHKaVq8P7KS6DES1MPSqURqu6nOOr1BfjSGXOuuJVn9SjFP9X
         IJxWY6Yw7GmRrQGqR48cCgoa8qkKmVYfrIcGJYXrSRlaF3gFWoYrmLwtYCPxXpa1Bb/e
         VfpFFOQJBo5dGN7RdDWwZPaZ1acKrZ6KjHISKsKubN53Xmuk8AZDM5cGJF3LDKhxXmpi
         L6WA==
X-Gm-Message-State: AOAM533sBHv826Ju6S+YeJ7Bepx55TOHvwiyGl1qD12pc3mBxJpL7rZW
        mewcokjU3ouNwva2PrWs8WmV+4i1qXHhb+CRKxmu3UHbzbkA
X-Google-Smtp-Source: ABdhPJyaN0zdQONqlEleLweGjbzzZCTrnYKNOLsHlWl9PmaS7iWCpDyfSApiqGSD9t1I8LMoNU1tXmAzYISojgu1u8g4NQb20RFl
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:de8:: with SMTP id m8mr3745524ilj.299.1601122163373;
 Sat, 26 Sep 2020 05:09:23 -0700 (PDT)
Date:   Sat, 26 Sep 2020 05:09:23 -0700
In-Reply-To: <00000000000088b1f405b00bcbb8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca3fdb05b0364d1a@google.com>
Subject: Re: WARNING in __cfg80211_ibss_joined (2)
From:   syzbot <syzbot+7f064ba1704c2466e36d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    7c7ec322 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f42f9b900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6184b75aa6d48d66
dashboard link: https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1757b773900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7f064ba1704c2466e36d@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 8356 at net/wireless/ibss.c:36 __cfg80211_ibss_joined+0x3fe/0x480 net/wireless/ibss.c:36
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 8356 Comm: kworker/u4:7 Not tainted 5.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: cfg80211 cfg80211_event_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1d6/0x29e lib/dump_stack.c:118
 panic+0x2c0/0x800 kernel/panic.c:231
 __warn+0x227/0x250 kernel/panic.c:600
 report_bug+0x1b1/0x2e0 lib/bug.c:198
 handle_bug+0x42/0x80 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x16/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:__cfg80211_ibss_joined+0x3fe/0x480 net/wireless/ibss.c:36
Code: 00 00 48 3b 44 24 30 0f 85 8d 00 00 00 48 83 c4 38 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 bb 54 9a f9 0f 0b eb d4 e8 b2 54 9a f9 <0f> 0b eb cb e8 a9 54 9a f9 0f 0b e9 82 fd ff ff e8 9d 54 9a f9 0f
RSP: 0018:ffffc9000a197bd8 EFLAGS: 00010293
RAX: ffffffff87daa87e RBX: 1ffff11012e3a182 RCX: ffff8880953ae080
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000006 R08: dffffc0000000000 R09: fffffbfff16c80a4
R10: fffffbfff16c80a4 R11: 0000000000000000 R12: ffff8880971d0c10
R13: ffff88808ddde418 R14: ffff888077e23350 R15: ffff8880971d0000
 cfg80211_process_wdev_events+0x3b5/0x4d0 net/wireless/util.c:910
 cfg80211_process_rdev_events+0x79/0xe0 net/wireless/util.c:936
 cfg80211_event_work+0x1d/0x30 net/wireless/core.c:320
 process_one_work+0x789/0xfc0 kernel/workqueue.c:2269
 worker_thread+0xaa4/0x1460 kernel/workqueue.c:2415
 kthread+0x37e/0x3a0 drivers/block/aoe/aoecmd.c:1234
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Kernel Offset: disabled
Rebooting in 86400 seconds..

