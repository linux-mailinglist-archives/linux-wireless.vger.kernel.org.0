Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55E9797483
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Sep 2023 17:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjIGPjV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 11:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245191AbjIGP1Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 11:27:16 -0400
Received: from mail-yw1-f207.google.com (mail-yw1-f207.google.com [209.85.128.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6201BF1
        for <linux-wireless@vger.kernel.org>; Thu,  7 Sep 2023 08:26:48 -0700 (PDT)
Received: by mail-yw1-f207.google.com with SMTP id 00721157ae682-58e4d2b7d16so12850707b3.0
        for <linux-wireless@vger.kernel.org>; Thu, 07 Sep 2023 08:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100342; x=1694705142;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zW5qhnjQmXuAaFU5fKwA/lEli7GsBu/PGJfxRXG3SHY=;
        b=T2DwjBBmsDgCdOehbD/2C3xY9IVC4wf6T0vrUMpitHOEMO20zefIVcRwzbCeWBnUaN
         z7OkC2ASDm3VlRMTRgVhqmHRIpJG6a5EBFZVW8+I1MJwkyWSATOVj/j9L5It/2eAF/Oj
         kti9D19uUS3SCtAiYvpS5iPuj2rwDOnbZ+oQ/qTHhYGNz6y/AlPVWK2JXB4+RKPZ1q2Y
         awmNTNVP3ufdPyiBmp5Q1IU07kkLkrWPCQ7KaghUJ7DKv9b+MGDN3gIdRwuOuoSITd/l
         Jrxlx8Nui7Ix9QzL+Z4KFNx1uf0e9ndJElIGn6oJJZWnqJ4N91R3iwOTyc0DZ3xEQ9X+
         viWg==
X-Gm-Message-State: AOJu0YwIR5GbbY1cGBhxNllhggnw7WKlVvLy6I5rQmX+teY0FRUIy9WQ
        g2rG6cGW47ox3ystIlq87mmsIKLkYOhtThIla1L+1H0dSQQi
X-Google-Smtp-Source: AGHT+IG5wTTGmmZiHOULSKMs/aQJzNoUO7ZR1DHaaynqV/kIsxBQ60kNClLJ4OvCsCznerNQ8nbBG5G2Y/WjgpejAQ1X+NCllgum
MIME-Version: 1.0
X-Received: by 2002:a63:7d03:0:b0:569:356c:f365 with SMTP id
 y3-20020a637d03000000b00569356cf365mr3738671pgc.12.1694075041155; Thu, 07 Sep
 2023 01:24:01 -0700 (PDT)
Date:   Thu, 07 Sep 2023 01:24:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d1dbf0604c09577@google.com>
Subject: [syzbot] [wireless?] [net?] memory leak in restore_regulatory_settings
From:   syzbot <syzbot+68849d5e4a6e74f32c06@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    92901222f83d Merge tag 'f2fs-for-6-6-rc1' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c340b8680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3544ee7492950dd3
dashboard link: https://syzkaller.appspot.com/bug?extid=68849d5e4a6e74f32c06
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13fe378fa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11bf6f7ba80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7b5db23b3ecc/disk-92901222.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/135d82cfd540/vmlinux-92901222.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6e1b0da81493/bzImage-92901222.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+68849d5e4a6e74f32c06@syzkaller.appspotmail.com

write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
BUG: memory leak
unreferenced object 0xffff88810f8a4e80 (size 64):
  comm "kworker/0:1", pid 9, jiffies 4294945857 (age 8.050s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    ff ff ff ff 00 00 00 00 00 00 00 00 30 30 00 00  ............00..
  backtrace:
    [<ffffffff815739f5>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1114
    [<ffffffff84739940>] kmalloc include/linux/slab.h:599 [inline]
    [<ffffffff84739940>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff84739940>] regulatory_hint_core net/wireless/reg.c:3218 [inline]
    [<ffffffff84739940>] restore_regulatory_settings+0x820/0xa80 net/wireless/reg.c:3552
    [<ffffffff84739d71>] crda_timeout_work+0x21/0x30 net/wireless/reg.c:540
    [<ffffffff812c8f1d>] process_one_work+0x23d/0x530 kernel/workqueue.c:2630
    [<ffffffff812c9ac7>] process_scheduled_works kernel/workqueue.c:2703 [inline]
    [<ffffffff812c9ac7>] worker_thread+0x327/0x590 kernel/workqueue.c:2784
    [<ffffffff812d6f9b>] kthread+0x12b/0x170 kernel/kthread.c:388
    [<ffffffff81149875>] ret_from_fork+0x45/0x50 arch/x86/kernel/process.c:147
    [<ffffffff81002be1>] ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
