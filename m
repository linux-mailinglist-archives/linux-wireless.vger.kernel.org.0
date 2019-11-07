Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFB3EF334E
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2019 16:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388317AbfKGPeX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Nov 2019 10:34:23 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:36158 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729953AbfKGPeK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Nov 2019 10:34:10 -0500
Received: by mail-il1-f197.google.com with SMTP id y7so3010853ilb.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 Nov 2019 07:34:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xXSZuLJlKOSAiQeCDNop2/Po7TAwJIhgGKQhTrYo5uc=;
        b=WPONC8I7aLrDwjci26aXwlt1+MBbqgl+jaJyKB75y8jZL64YsAfERiJqik2vrSH34q
         sJJP61NH993PIhiZWV0bcKrH7z5fkES+oBjTu4hdBIfAAQBVrHBPr4KnZ8+0lGGjn2pC
         kIUueD9HVIY38LnNCLA21qccIgdtr5Z9mvl3ZX9t25dFHZYJnluxFi2HKdqg0N/i8eYX
         Pez6637pdi7UElsov5vsxh2PMfrSfqq1VE4SZGbg0TxIt4uobPjghmxr72ehscCKLEMV
         EcLq6D3jzjMHmUR8yXdLBR2Z6WvsV4rQDTDNe22pRq9g/5aviZImC1vINFuAWf92/Awj
         veiQ==
X-Gm-Message-State: APjAAAXukSkFax1ogACWFr+gEkiLe30+OFaORSpsLNuetmpmWRjl6Aj/
        0wQbeUeto7OTe5xNmHSr4FeCjxvCxIRVx6+/IvgPhDOHfwE9
X-Google-Smtp-Source: APXvYqyUy/EHdTm3OkPUEXgsq0v+2vA6a+9xeM0aG5CRFMMGKUgoUlk/A9BrfCK35av6wp5etl0ZlVVeGtJY8MGnXPyIKxZzd1JB
MIME-Version: 1.0
X-Received: by 2002:a6b:700a:: with SMTP id l10mr4184214ioc.164.1573140849301;
 Thu, 07 Nov 2019 07:34:09 -0800 (PST)
Date:   Thu, 07 Nov 2019 07:34:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008123610596c36579@google.com>
Subject: WARNING in ath6kl_htc_pipe_rx_complete
From:   syzbot <syzbot+555908813b2ea35dae9a@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, davem@davemloft.net, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d60bbfea usb: raw: add raw-gadget interface
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1029829ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79de80330003b5f7
dashboard link: https://syzkaller.appspot.com/bug?extid=555908813b2ea35dae9a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1388a2aae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13aa35dce00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+555908813b2ea35dae9a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 17 at drivers/net/wireless/ath/ath6kl/htc_pipe.c:963  
ath6kl_htc_pipe_rx_complete+0xc58/0xef0  
drivers/net/wireless/ath/ath6kl/htc_pipe.c:963
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 17 Comm: kworker/1:0 Not tainted 5.4.0-rc6+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events ath6kl_usb_io_comp_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  panic+0x2aa/0x6e1 kernel/panic.c:221
  __warn.cold+0x2f/0x33 kernel/panic.c:582
  report_bug+0x27b/0x2f0 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:ath6kl_htc_pipe_rx_complete+0xc58/0xef0  
drivers/net/wireless/ath/ath6kl/htc_pipe.c:963
Code: 45 31 ed e8 da 0f a6 02 e9 01 fb ff ff 4c 8b 74 24 70 4c 8b 6c 24 60  
e8 f6 84 74 fe 8b 5c 24 6c e9 3b f9 ff ff e8 e8 84 74 fe <0f> 0b 48 c7 c7  
40 53 03 86 41 bc ea ff ff ff e8 7f 83 fe ff e9 cb
RSP: 0018:ffff8881da267c00 EFLAGS: 00010293
RAX: ffff8881da24b000 RBX: ffff8881cf9d0ba0 RCX: 1ffffffff0c06a9e
RDX: 0000000000000000 RSI: ffffffff82c9a178 RDI: ffff8881cf9d0c10
RBP: dffffc0000000000 R08: ffff8881da24b000 R09: fffffbfff11ab3b5
R10: fffffbfff11ab3b4 R11: ffffffff88d59da7 R12: ffff8881cfc18000
R13: ffff8881d20ca280 R14: 0000000000000000 R15: 0000000000000000
  ath6kl_usb_io_comp_work+0x11e/0x160  
drivers/net/wireless/ath/ath6kl/usb.c:598
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
