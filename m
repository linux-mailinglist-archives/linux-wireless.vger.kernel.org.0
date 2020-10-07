Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F9E285B92
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Oct 2020 11:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgJGJIR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Oct 2020 05:08:17 -0400
Received: from mail-io1-f77.google.com ([209.85.166.77]:34616 "EHLO
        mail-io1-f77.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgJGJIR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Oct 2020 05:08:17 -0400
Received: by mail-io1-f77.google.com with SMTP id y70so922483iof.1
        for <linux-wireless@vger.kernel.org>; Wed, 07 Oct 2020 02:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=f5og6DbWxpYcd90/DEz6IZXDliRgWnLuDlkXoFdfP2M=;
        b=ENPdnYsA4oqJELqTnKMeXFqMRcUqh9fY8jGEzenW5QOCCQ4adLIWII/A/Tl55aEAT+
         wEi+H+8oyNMl917atNLJGrHzmdsztE6VxxefWiN1nPFb/FUc6l3YOgAzehyRKfBVCphZ
         /qLfuv+RkvWBtS5mRcVIpfJfw2aHx844vyuR/Lp9cHa/HBth4knpcEWhvX9VVzS+5+mE
         CYgEw5D7/RRYIWBxTzIN5fV2/egZmbYPM8Tl4jJX25I/qT8Zh1lz1p7cHvrOfTZ4YGyH
         xb7jDrMczyaSvWyGqiLfTOxf8SA2wKFHo1H+tFD4Ond5A4Ua8Rv2qc2GldhI5+ANzdvI
         X1AQ==
X-Gm-Message-State: AOAM533yhDQtEoVB4TFBB2bLtBAao9zhn1Jh6HRK7EMFXUbAFmHV/MZL
        w6jvtza8+tHq1o/q//cQvcG/ptW6B8hE2jYV2kTxtFnuVtyr
X-Google-Smtp-Source: ABdhPJxVWDIGP/C0Y4y7Biv0A0CkHohIyEyidw8GxXqMDYEs2AG3BkRhVdRE75tgAKjvclnxgB3wCFfIeZlMRsMrsbq2Haq2Nokm
MIME-Version: 1.0
X-Received: by 2002:a92:6b06:: with SMTP id g6mr1958787ilc.194.1602061695845;
 Wed, 07 Oct 2020 02:08:15 -0700 (PDT)
Date:   Wed, 07 Oct 2020 02:08:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a0d5e05b1110e86@google.com>
Subject: WARNING in ieee80211_free_ack_frame
From:   syzbot <syzbot+a063bbf0b15737362592@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c85fb28b Merge tag 'arm64-fixes' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121fa53f900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c06bcf3cc963d91c
dashboard link: https://syzkaller.appspot.com/bug?extid=a063bbf0b15737362592
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a063bbf0b15737362592@syzkaller.appspotmail.com

------------[ cut here ]------------
Have pending ack frames!
WARNING: CPU: 0 PID: 8957 at net/mac80211/main.c:1396 ieee80211_free_ack_frame+0x48/0x50 net/mac80211/main.c:1396
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 8957 Comm: kworker/u4:8 Not tainted 5.9.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 panic+0x382/0x7fb kernel/panic.c:231
 __warn.cold+0x20/0x4b kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:ieee80211_free_ack_frame+0x48/0x50 net/mac80211/main.c:1396
Code: e8 5d 43 b8 f9 48 89 ef e8 b5 dc a8 fe 31 c0 5b 5d c3 e8 4b 43 b8 f9 48 c7 c7 00 c0 5e 89 c6 05 66 b5 96 03 01 e8 3a 80 88 f9 <0f> 0b eb d2 0f 1f 40 00 41 57 41 56 41 55 49 89 d5 41 54 49 89 f4
RSP: 0018:ffffc900075d79c8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880527e0480 RSI: ffffffff815f5a55 RDI: fffff52000ebaf2b
RBP: ffff8880a1746c00 R08: 0000000000000001 R09: ffff8880ae420f8b
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffffff87bdfb90 R14: 0000000000000000 R15: 0000000000000000
 idr_for_each+0x113/0x220 lib/idr.c:208
 ieee80211_free_hw+0x9b/0x2a0 net/mac80211/main.c:1412
 mac80211_hwsim_del_radio drivers/net/wireless/mac80211_hwsim.c:3285 [inline]
 hwsim_exit_net+0x5bc/0xc90 drivers/net/wireless/mac80211_hwsim.c:4037
 ops_exit_list+0xb0/0x160 net/core/net_namespace.c:186
 cleanup_net+0x4ea/0xa00 net/core/net_namespace.c:603
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
