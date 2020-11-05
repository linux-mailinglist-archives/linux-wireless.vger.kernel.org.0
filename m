Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056FF2A8339
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Nov 2020 17:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbgKEQOg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Nov 2020 11:14:36 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:52367 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbgKEQOS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Nov 2020 11:14:18 -0500
Received: by mail-il1-f200.google.com with SMTP id y15so1424812ilp.19
        for <linux-wireless@vger.kernel.org>; Thu, 05 Nov 2020 08:14:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=iCE791O+YomKx6jeJuYW72QC2S3jn0tEqUW0wtAGdsU=;
        b=eajwOrGBRmOd3Laa4XHx4TtN2OkEWCZi7Xb66sYrDKwvKonIMFY47n6XEeEq3reBss
         WUDIHPOMInRUSLiT6HukWYZcufsrQhnaliXdFVnOwbhYdPlQ7mG7ZqKmxBukPNrKa5ap
         6mXWh8lXPHpH+iYPh8HKDRdsRagfNJhOOrPf7GJz6z6GnBZK/pf6K1oA/tIakBnJso35
         skGnaaqeYOxUYRzJ2FEh6EkAAwJtYMrRcTdXHWeq8VDUUejgtq6Ii9dJ4SJ4/nYnbofv
         LbcnWMseb1KTP5Tedyvgx7Y5nVaG8BDH/9y/buwCQs7vW7TcWkUrFAiUzHSv+mlgSBUP
         8qlg==
X-Gm-Message-State: AOAM531dvsgEIcMHjsj2S3VxmFmzY4IRooFeMhwx36elWXrdnvJ8Pajl
        dgWsZUu+w6IY3FKqb/4mo+0xaomIECg2l/H66/Cf79b5+LWt
X-Google-Smtp-Source: ABdhPJwyBRqZxGelvCgD9e46F4X9OqBodPAEL6N9MJswi6mJfjBZ+T933YxLTI0nBML3N2kUJ5W1h+T0unz+HSx2YQuxY5ey01Oy
MIME-Version: 1.0
X-Received: by 2002:a02:cbde:: with SMTP id u30mr2677796jaq.69.1604592856927;
 Thu, 05 Nov 2020 08:14:16 -0800 (PST)
Date:   Thu, 05 Nov 2020 08:14:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003f135105b35e639d@google.com>
Subject: net test error: BUG: sleeping function called from invalid context in sta_info_move_state
From:   syzbot <syzbot+6a7fe9faf0d1d61bc24a@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2aaf09a0 r8169: work around short packet hw bug on RTL8125
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=15c416fc500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=803dd96a0e492ac1
dashboard link: https://syzkaller.appspot.com/bug?extid=6a7fe9faf0d1d61bc24a
compiler:       gcc (GCC) 10.1.0-syz 20200507

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6a7fe9faf0d1d61bc24a@syzkaller.appspotmail.com

wlan1: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
BUG: sleeping function called from invalid context at net/mac80211/sta_info.c:1962
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 536, name: kworker/u4:5
4 locks held by kworker/u4:5/536:
 #0: ffff88801b08a938 ((wq_completion)phy3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88801b08a938 ((wq_completion)phy3){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff88801b08a938 ((wq_completion)phy3){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff88801b08a938 ((wq_completion)phy3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff88801b08a938 ((wq_completion)phy3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff88801b08a938 ((wq_completion)phy3){+.+.}-{0:0}, at: process_one_work+0x821/0x15a0 kernel/workqueue.c:2243
 #1: ffffc9000294fda8 ((work_completion)(&sdata->work)){+.+.}-{0:0}, at: process_one_work+0x854/0x15a0 kernel/workqueue.c:2247
 #2: ffff88801bc98d00 (&wdev->mtx){+.+.}-{3:3}, at: sdata_lock net/mac80211/ieee80211_i.h:1021 [inline]
 #2: ffff88801bc98d00 (&wdev->mtx){+.+.}-{3:3}, at: ieee80211_ibss_work+0x93/0xe80 net/mac80211/ibss.c:1683
 #3: ffffffff8b337160 (rcu_read_lock){....}-{1:2}, at: sta_info_insert_finish net/mac80211/sta_info.c:644 [inline]
 #3: ffffffff8b337160 (rcu_read_lock){....}-{1:2}, at: sta_info_insert_rcu+0x680/0x2ba0 net/mac80211/sta_info.c:732
Preemption disabled at:
[<ffffffff88e6168f>] __mutex_lock_common kernel/locking/mutex.c:955 [inline]
[<ffffffff88e6168f>] __mutex_lock+0x10f/0x10e0 kernel/locking/mutex.c:1103
CPU: 1 PID: 536 Comm: kworker/u4:5 Not tainted 5.10.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: phy3 ieee80211_iface_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 ___might_sleep.cold+0x1e8/0x22e kernel/sched/core.c:7298
 sta_info_move_state+0x32/0x8d0 net/mac80211/sta_info.c:1962
 sta_info_free+0x65/0x3b0 net/mac80211/sta_info.c:274
 sta_info_insert_rcu+0x303/0x2ba0 net/mac80211/sta_info.c:738
 ieee80211_ibss_finish_sta+0x212/0x390 net/mac80211/ibss.c:592
 ieee80211_ibss_work+0x2c7/0xe80 net/mac80211/ibss.c:1700
 ieee80211_iface_work+0x82e/0x970 net/mac80211/iface.c:1476
 process_one_work+0x933/0x15a0 kernel/workqueue.c:2272
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

=============================
[ BUG: Invalid wait context ]
5.10.0-rc1-syzkaller #0 Tainted: G        W        
-----------------------------
kworker/u4:5/536 is trying to lock:
ffff888019d729d0 (&local->chanctx_mtx){+.+.}-{3:3}, at: ieee80211_recalc_min_chandef+0x49/0x140 net/mac80211/util.c:2740
other info that might help us debug this:
context-{4:4}
4 locks held by kworker/u4:5/536:
 #0: ffff88801b08a938 ((wq_completion)phy3){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88801b08a938 ((wq_completion)phy3){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff88801b08a938 ((wq_completion)phy3){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff88801b08a938 ((wq_completion)phy3){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff88801b08a938 ((wq_completion)phy3){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff88801b08a938 ((wq_completion)phy3){+.+.}-{0:0}, at: process_one_work+0x821/0x15a0 kernel/workqueue.c:2243
 #1: ffffc9000294fda8 ((work_completion)(&sdata->work)){+.+.}-{0:0}, at: process_one_work+0x854/0x15a0 kernel/workqueue.c:2247
 #2: ffff88801bc98d00 (&wdev->mtx){+.+.}-{3:3}, at: sdata_lock net/mac80211/ieee80211_i.h:1021 [inline]
 #2: ffff88801bc98d00 (&wdev->mtx){+.+.}-{3:3}, at: ieee80211_ibss_work+0x93/0xe80 net/mac80211/ibss.c:1683
 #3: ffffffff8b337160 (rcu_read_lock){....}-{1:2}, at: sta_info_insert_finish net/mac80211/sta_info.c:644 [inline]
 #3: ffffffff8b337160 (rcu_read_lock){....}-{1:2}, at: sta_info_insert_rcu+0x680/0x2ba0 net/mac80211/sta_info.c:732
stack backtrace:
CPU: 1 PID: 536 Comm: kworker/u4:5 Tainted: G        W         5.10.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: phy3 ieee80211_iface_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4489 [inline]
 check_wait_context kernel/locking/lockdep.c:4550 [inline]
 __lock_acquire.cold+0x310/0x3a2 kernel/locking/lockdep.c:4787
 lock_acquire kernel/locking/lockdep.c:5442 [inline]
 lock_acquire+0x1af/0x8b0 kernel/locking/lockdep.c:5407
 __mutex_lock_common kernel/locking/mutex.c:956 [inline]
 __mutex_lock+0x134/0x10e0 kernel/locking/mutex.c:1103
 ieee80211_recalc_min_chandef+0x49/0x140 net/mac80211/util.c:2740
 sta_info_move_state+0x3cf/0x8d0 net/mac80211/sta_info.c:2019
 sta_info_free+0x65/0x3b0 net/mac80211/sta_info.c:274
 sta_info_insert_rcu+0x303/0x2ba0 net/mac80211/sta_info.c:738
 ieee80211_ibss_finish_sta+0x212/0x390 net/mac80211/ibss.c:592
 ieee80211_ibss_work+0x2c7/0xe80 net/mac80211/ibss.c:1700
 ieee80211_iface_work+0x82e/0x970 net/mac80211/iface.c:1476
 process_one_work+0x933/0x15a0 kernel/workqueue.c:2272
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
