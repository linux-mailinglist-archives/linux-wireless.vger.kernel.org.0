Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B223276D65
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Sep 2020 11:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgIXJ1v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Sep 2020 05:27:51 -0400
Received: from mail-io1-f77.google.com ([209.85.166.77]:50339 "EHLO
        mail-io1-f77.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbgIXJ01 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Sep 2020 05:26:27 -0400
Received: by mail-io1-f77.google.com with SMTP id b16so1919783iod.17
        for <linux-wireless@vger.kernel.org>; Thu, 24 Sep 2020 02:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zkwYPXXqbu6Jbit+dih6xwU3OyHwkBJP9aKMHzOM6ec=;
        b=StWhtYssZzgNc4wv9qr7fhPGDw+MvMxAltU6mmk6AUMvSq/stjHlwteJBJN8DqtdCc
         ONA6mRjidGXTHUF8FdZQzYuWsE8OgVaBdZb/V/5oB6K7TbY0fonVsBa9rZRQjzbZnDwW
         AnQnZQ+y1y23ristT8frJpFtadREAvWLTZmF6gafw5ioXVS3QauF2VkjOFc/93+VOseu
         XRY3HO4Xni6tldIe6HLgAFBc903yZf+ttHNOtIFscjTv2VCM9hB060XSrfH54zkNvx7f
         JAGebwdBHy3X1x2RPdr/TyJk2JiJlB89BQr0BAihmrFbSLnYKTZM7xvOJ5aVo01O4LOK
         MQPg==
X-Gm-Message-State: AOAM532QEgt3Nj5TscXQM85zIvCLr+OfqVsxYO8UuJUVbes6EoPbwiv9
        LvjVGAZfd0U41wsp5FJk60wmU4B3j83Iy2d0nzmzEUcDgQyO
X-Google-Smtp-Source: ABdhPJwfvyxW/EjELvpHYZMhxwKdeNbMg8UUCWaHwdC4LaRjb0YPxjphmEUMlB28B1tXx3++LCtXW7OHL2Nr9e7POvZcNL8/y7C6
MIME-Version: 1.0
X-Received: by 2002:a6b:8f10:: with SMTP id r16mr2597910iod.165.1600939585140;
 Thu, 24 Sep 2020 02:26:25 -0700 (PDT)
Date:   Thu, 24 Sep 2020 02:26:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000477d5705b00bcbec@google.com>
Subject: memory leak in ieee80211_check_fast_xmit
From:   syzbot <syzbot+2e293dbd67de2836ba42@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c9c9e6a4 Merge tag 'trace-v5.9-rc5-2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13735209900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23de0cdbdd5f681b
dashboard link: https://syzkaller.appspot.com/bug?extid=2e293dbd67de2836ba42
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1762d887900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174c88ad900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e293dbd67de2836ba42@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888115177200 (size 96):
  comm "kworker/u4:0", pid 7, jiffies 4294961513 (age 31.340s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 1e 0a 04 00 00 00 08 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 50 50  ..............PP
  backtrace:
    [<000000007aa91ff2>] kmemdup+0x23/0x50 mm/util.c:127
    [<0000000000c381ce>] kmemdup include/linux/string.h:479 [inline]
    [<0000000000c381ce>] ieee80211_check_fast_xmit+0x33c/0x590 net/mac80211/tx.c:3103
    [<00000000b3947435>] sta_info_move_state+0xbf/0x3e0 net/mac80211/sta_info.c:2024
    [<000000008c85d507>] sta_info_pre_move_state net/mac80211/sta_info.h:706 [inline]
    [<000000008c85d507>] ieee80211_ibss_finish_sta+0x113/0x180 net/mac80211/ibss.c:587
    [<00000000cf829a1b>] ieee80211_ibss_work+0xfc/0x430 net/mac80211/ibss.c:1699
    [<00000000beb78158>] ieee80211_iface_work+0x3d0/0x440 net/mac80211/iface.c:1438
    [<000000001352d51f>] process_one_work+0x213/0x4d0 kernel/workqueue.c:2269
    [<000000005e0a2f8f>] worker_thread+0x58/0x4b0 kernel/workqueue.c:2415
    [<000000007ed18dcd>] kthread+0x164/0x190 kernel/kthread.c:292
    [<000000005a47bdfe>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff888115177200 (size 96):
  comm "kworker/u4:0", pid 7, jiffies 4294961513 (age 31.420s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 1e 0a 04 00 00 00 08 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 50 50  ..............PP
  backtrace:
    [<000000007aa91ff2>] kmemdup+0x23/0x50 mm/util.c:127
    [<0000000000c381ce>] kmemdup include/linux/string.h:479 [inline]
    [<0000000000c381ce>] ieee80211_check_fast_xmit+0x33c/0x590 net/mac80211/tx.c:3103
    [<00000000b3947435>] sta_info_move_state+0xbf/0x3e0 net/mac80211/sta_info.c:2024
    [<000000008c85d507>] sta_info_pre_move_state net/mac80211/sta_info.h:706 [inline]
    [<000000008c85d507>] ieee80211_ibss_finish_sta+0x113/0x180 net/mac80211/ibss.c:587
    [<00000000cf829a1b>] ieee80211_ibss_work+0xfc/0x430 net/mac80211/ibss.c:1699
    [<00000000beb78158>] ieee80211_iface_work+0x3d0/0x440 net/mac80211/iface.c:1438
    [<000000001352d51f>] process_one_work+0x213/0x4d0 kernel/workqueue.c:2269
    [<000000005e0a2f8f>] worker_thread+0x58/0x4b0 kernel/workqueue.c:2415
    [<000000007ed18dcd>] kthread+0x164/0x190 kernel/kthread.c:292
    [<000000005a47bdfe>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff888115177200 (size 96):
  comm "kworker/u4:0", pid 7, jiffies 4294961513 (age 31.500s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 1e 0a 04 00 00 00 08 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 50 50  ..............PP
  backtrace:
    [<000000007aa91ff2>] kmemdup+0x23/0x50 mm/util.c:127
    [<0000000000c381ce>] kmemdup include/linux/string.h:479 [inline]
    [<0000000000c381ce>] ieee80211_check_fast_xmit+0x33c/0x590 net/mac80211/tx.c:3103
    [<00000000b3947435>] sta_info_move_state+0xbf/0x3e0 net/mac80211/sta_info.c:2024
    [<000000008c85d507>] sta_info_pre_move_state net/mac80211/sta_info.h:706 [inline]
    [<000000008c85d507>] ieee80211_ibss_finish_sta+0x113/0x180 net/mac80211/ibss.c:587
    [<00000000cf829a1b>] ieee80211_ibss_work+0xfc/0x430 net/mac80211/ibss.c:1699
    [<00000000beb78158>] ieee80211_iface_work+0x3d0/0x440 net/mac80211/iface.c:1438
    [<000000001352d51f>] process_one_work+0x213/0x4d0 kernel/workqueue.c:2269
    [<000000005e0a2f8f>] worker_thread+0x58/0x4b0 kernel/workqueue.c:2415
    [<000000007ed18dcd>] kthread+0x164/0x190 kernel/kthread.c:292
    [<000000005a47bdfe>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff888115177200 (size 96):
  comm "kworker/u4:0", pid 7, jiffies 4294961513 (age 31.580s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 1e 0a 04 00 00 00 08 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 50 50  ..............PP
  backtrace:
    [<000000007aa91ff2>] kmemdup+0x23/0x50 mm/util.c:127
    [<0000000000c381ce>] kmemdup include/linux/string.h:479 [inline]
    [<0000000000c381ce>] ieee80211_check_fast_xmit+0x33c/0x590 net/mac80211/tx.c:3103
    [<00000000b3947435>] sta_info_move_state+0xbf/0x3e0 net/mac80211/sta_info.c:2024
    [<000000008c85d507>] sta_info_pre_move_state net/mac80211/sta_info.h:706 [inline]
    [<000000008c85d507>] ieee80211_ibss_finish_sta+0x113/0x180 net/mac80211/ibss.c:587
    [<00000000cf829a1b>] ieee80211_ibss_work+0xfc/0x430 net/mac80211/ibss.c:1699
    [<00000000beb78158>] ieee80211_iface_work+0x3d0/0x440 net/mac80211/iface.c:1438
    [<000000001352d51f>] process_one_work+0x213/0x4d0 kernel/workqueue.c:2269
    [<000000005e0a2f8f>] worker_thread+0x58/0x4b0 kernel/workqueue.c:2415
    [<000000007ed18dcd>] kthread+0x164/0x190 kernel/kthread.c:292
    [<000000005a47bdfe>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff888115177200 (size 96):
  comm "kworker/u4:0", pid 7, jiffies 4294961513 (age 31.660s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 1e 0a 04 00 00 00 08 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 50 50  ..............PP
  backtrace:
    [<000000007aa91ff2>] kmemdup+0x23/0x50 mm/util.c:127
    [<0000000000c381ce>] kmemdup include/linux/string.h:479 [inline]
    [<0000000000c381ce>] ieee80211_check_fast_xmit+0x33c/0x590 net/mac80211/tx.c:3103
    [<00000000b3947435>] sta_info_move_state+0xbf/0x3e0 net/mac80211/sta_info.c:2024
    [<000000008c85d507>] sta_info_pre_move_state net/mac80211/sta_info.h:706 [inline]
    [<000000008c85d507>] ieee80211_ibss_finish_sta+0x113/0x180 net/mac80211/ibss.c:587
    [<00000000cf829a1b>] ieee80211_ibss_work+0xfc/0x430 net/mac80211/ibss.c:1699
    [<00000000beb78158>] ieee80211_iface_work+0x3d0/0x440 net/mac80211/iface.c:1438
    [<000000001352d51f>] process_one_work+0x213/0x4d0 kernel/workqueue.c:2269
    [<000000005e0a2f8f>] worker_thread+0x58/0x4b0 kernel/workqueue.c:2415
    [<000000007ed18dcd>] kthread+0x164/0x190 kernel/kthread.c:292
    [<000000005a47bdfe>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff888115177200 (size 96):
  comm "kworker/u4:0", pid 7, jiffies 4294961513 (age 31.740s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 1e 0a 04 00 00 00 08 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 50 50  ..............PP
  backtrace:
    [<000000007aa91ff2>] kmemdup+0x23/0x50 mm/util.c:127
    [<0000000000c381ce>] kmemdup include/linux/string.h:479 [inline]
    [<0000000000c381ce>] ieee80211_check_fast_xmit+0x33c/0x590 net/mac80211/tx.c:3103
    [<00000000b3947435>] sta_info_move_state+0xbf/0x3e0 net/mac80211/sta_info.c:2024
    [<000000008c85d507>] sta_info_pre_move_state net/mac80211/sta_info.h:706 [inline]
    [<000000008c85d507>] ieee80211_ibss_finish_sta+0x113/0x180 net/mac80211/ibss.c:587
    [<00000000cf829a1b>] ieee80211_ibss_work+0xfc/0x430 net/mac80211/ibss.c:1699
    [<00000000beb78158>] ieee80211_iface_work+0x3d0/0x440 net/mac80211/iface.c:1438
    [<000000001352d51f>] process_one_work+0x213/0x4d0 kernel/workqueue.c:2269
    [<000000005e0a2f8f>] worker_thread+0x58/0x4b0 kernel/workqueue.c:2415
    [<000000007ed18dcd>] kthread+0x164/0x190 kernel/kthread.c:292
    [<000000005a47bdfe>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff888115177200 (size 96):
  comm "kworker/u4:0", pid 7, jiffies 4294961513 (age 31.820s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 1e 0a 04 00 00 00 08 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 50 50  ..............PP
  backtrace:
    [<000000007aa91ff2>] kmemdup+0x23/0x50 mm/util.c:127
    [<0000000000c381ce>] kmemdup include/linux/string.h:479 [inline]
    [<0000000000c381ce>] ieee80211_check_fast_xmit+0x33c/0x590 net/mac80211/tx.c:3103
    [<00000000b3947435>] sta_info_move_state+0xbf/0x3e0 net/mac80211/sta_info.c:2024
    [<000000008c85d507>] sta_info_pre_move_state net/mac80211/sta_info.h:706 [inline]
    [<000000008c85d507>] ieee80211_ibss_finish_sta+0x113/0x180 net/mac80211/ibss.c:587
    [<00000000cf829a1b>] ieee80211_ibss_work+0xfc/0x430 net/mac80211/ibss.c:1699
    [<00000000beb78158>] ieee80211_iface_work+0x3d0/0x440 net/mac80211/iface.c:1438
    [<000000001352d51f>] process_one_work+0x213/0x4d0 kernel/workqueue.c:2269
    [<000000005e0a2f8f>] worker_thread+0x58/0x4b0 kernel/workqueue.c:2415
    [<000000007ed18dcd>] kthread+0x164/0x190 kernel/kthread.c:292
    [<000000005a47bdfe>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff888115177200 (size 96):
  comm "kworker/u4:0", pid 7, jiffies 4294961513 (age 31.900s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 1e 0a 04 00 00 00 08 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 50 50  ..............PP
  backtrace:
    [<000000007aa91ff2>] kmemdup+0x23/0x50 mm/util.c:127
    [<0000000000c381ce>] kmemdup include/linux/string.h:479 [inline]
    [<0000000000c381ce>] ieee80211_check_fast_xmit+0x33c/0x590 net/mac80211/tx.c:3103
    [<00000000b3947435>] sta_info_move_state+0xbf/0x3e0 net/mac80211/sta_info.c:2024
    [<000000008c85d507>] sta_info_pre_move_state net/mac80211/sta_info.h:706 [inline]
    [<000000008c85d507>] ieee80211_ibss_finish_sta+0x113/0x180 net/mac80211/ibss.c:587
    [<00000000cf829a1b>] ieee80211_ibss_work+0xfc/0x430 net/mac80211/ibss.c:1699
    [<00000000beb78158>] ieee80211_iface_work+0x3d0/0x440 net/mac80211/iface.c:1438
    [<000000001352d51f>] process_one_work+0x213/0x4d0 kernel/workqueue.c:2269
    [<000000005e0a2f8f>] worker_thread+0x58/0x4b0 kernel/workqueue.c:2415
    [<000000007ed18dcd>] kthread+0x164/0x190 kernel/kthread.c:292
    [<000000005a47bdfe>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
