Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E16E635D1
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2019 14:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfGIM1X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jul 2019 08:27:23 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:42656 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfGIM1J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jul 2019 08:27:09 -0400
Received: by mail-io1-f71.google.com with SMTP id f22so22862426ioj.9
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jul 2019 05:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UZp0N+xOAAczyA3pZl0OsLZcXAkB435anjzhpRD0vtc=;
        b=torvqSVct5H8LrmE63qHig0i12mwqDIYkQIV7QTUXG7rzYk3kRVRJ546YiYY2RDZvp
         ChizLfnC5kLMsMpgkljo5zfQcNaFMNmTbhDE7uY/FdHGWBZlryAdEgUufBACgxq7lLr4
         +tNXyKNHkeneQ/jYYVB92qEG5Qbv27HIGPowkP2QJ7jwuAHnfiQd797Gla9js0IWsXId
         t+7ybnPPnHtyMjov6w03lWas5OHI6/pbrvWHS8k4mI87TCJziDBD67qtg9Moq8eGY85f
         zmXE8mSaZOpgbzlLh/DroKI5GDO4TYVcCIkC0pWpCA1ByMK9prfPHYqiJ+sb+zdutgp8
         3ZHQ==
X-Gm-Message-State: APjAAAXNiOSK4vDNMtAOOPb0Qio+IWJEnjlMM5Hwu3qcsjxUr9KIPM0I
        Jl17EjYNK0BVFupH0ennF76CB3lZWdpWzybfD6HaFYWeSEOD
X-Google-Smtp-Source: APXvYqwErajSFEr7tGtQtEfYiBupcBnj0BvRo16vOfzsOxFx8naQtm9prx+l7V6z9OJaad4fgSlPeKIF91YAWnZwqKoL1zjEypX+
MIME-Version: 1.0
X-Received: by 2002:a02:ab83:: with SMTP id t3mr27669942jan.133.1562675228114;
 Tue, 09 Jul 2019 05:27:08 -0700 (PDT)
Date:   Tue, 09 Jul 2019 05:27:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df0913058d3ead47@google.com>
Subject: KASAN: global-out-of-bounds Read in load_next_firmware_from_table
From:   syzbot <syzbot+98156c174c5a2cad9f8f@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, kvalo@codeaurora.org,
        libertas-dev@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7829a896 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=12fd0e9ba00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6d4561982f71f63
dashboard link: https://syzkaller.appspot.com/bug?extid=98156c174c5a2cad9f8f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125f669ba00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146b806ba00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+98156c174c5a2cad9f8f@syzkaller.appspotmail.com

usb 1-1: Direct firmware load for libertas/usb8388_v5.bin failed with error  
-2
usb 1-1: Direct firmware load for libertas/usb8388.bin failed with error -2
usb 1-1: Direct firmware load for usb8388.bin failed with error -2
==================================================================
BUG: KASAN: global-out-of-bounds in  
load_next_firmware_from_table+0x267/0x2d0  
drivers/net/wireless/marvell/libertas/firmware.c:99
Read of size 8 at addr ffffffff860942b8 by task kworker/1:1/21

CPU: 1 PID: 21 Comm: kworker/1:1 Not tainted 5.2.0-rc6+ #13
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events request_firmware_work_func
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x67/0x231 mm/kasan/report.c:188
  __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:317
  kasan_report+0xe/0x20 mm/kasan/common.c:614
  load_next_firmware_from_table+0x267/0x2d0  
drivers/net/wireless/marvell/libertas/firmware.c:99
  helper_firmware_cb+0xdc/0x100  
drivers/net/wireless/marvell/libertas/firmware.c:70
  request_firmware_work_func+0x126/0x242  
drivers/base/firmware_loader/main.c:785
  process_one_work+0x905/0x1570 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x30b/0x410 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the variable:
  fw_table+0x98/0x5c0

Memory state around the buggy address:
  ffffffff86094180: fa fa fa fa 00 04 fa fa fa fa fa fa 00 00 05 fa
  ffffffff86094200: fa fa fa fa 00 00 00 00 00 00 00 00 00 00 00 00
> ffffffff86094280: 00 00 00 00 00 00 fa fa fa fa fa fa 00 00 00 00
                                         ^
  ffffffff86094300: 00 00 00 01 fa fa fa fa 00 00 00 00 02 fa fa fa
  ffffffff86094380: fa fa fa fa 00 03 fa fa fa fa fa fa 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
