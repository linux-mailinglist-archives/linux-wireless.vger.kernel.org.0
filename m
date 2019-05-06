Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61905148C5
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 13:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfEFLQJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 07:16:09 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:37514 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEFLQH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 07:16:07 -0400
Received: by mail-it1-f199.google.com with SMTP id d140so11260905itc.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 May 2019 04:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wfo46abTbmuRXvxeTUG8sMq7sgvtISG77eUoUAEQFR8=;
        b=kX2iJoTtMneNUppDJaCHJV51ao1LimT77gOxYx2jkbBozy9zRlxdDRTCWGf+yiCOgg
         oJyaAUpPfcj9+kxbSiniFhgaMp+iocc3/F0O0vOKt3cJ0HZe8P138EoVDbQ64MDHD6OZ
         K2isVNmDw9dSb3oXgsUMXcvjocH8BAg7CmAOwWw/5z7Tdlg600Vq1zj2g9Q9zoaRZe4w
         5IVWslXCUpcU4oHTJV5mB2LfFIOnLgdjtTtP3nGIeK52gD3rFD8LwmeJCf0JQWhQplj3
         3GZgwE0AiO/ZHfdwiDNu78D5+G37Nc0jeSRKCVc2qM+O7MFDjPvRY+EggmPfMz4E9uZZ
         h7Sg==
X-Gm-Message-State: APjAAAXXELDvL4/c8bCrbmC+/sAJUjJRd+RqY1Fw/9pqt9QRV2yGTWd9
        p5/sIEb3d/hNQ/O1A4ARQakZlXkCLmTXrJqBg/9k6mhHZxM0
X-Google-Smtp-Source: APXvYqzztlzlI6lMg9dhbdBE2nMsatxOpEwiQJkKfQh2hgdzj0WiGZDn2eO24DJhUe9O8pBYwusHdq0rIw///dxTCUPu68EKeRG3
MIME-Version: 1.0
X-Received: by 2002:a6b:3ac3:: with SMTP id h186mr12861180ioa.63.1557141366572;
 Mon, 06 May 2019 04:16:06 -0700 (PDT)
Date:   Mon, 06 May 2019 04:16:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000050c5f0588363ad6@google.com>
Subject: KASAN: use-after-free Read in p54u_load_firmware_cb
From:   syzbot <syzbot+200d4bb11b23d929335f@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, chunkeey@googlemail.com,
        davem@davemloft.net, kvalo@codeaurora.org,
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

HEAD commit:    43151d6c usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=142b312ca00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4183eeef650d1234
dashboard link: https://syzkaller.appspot.com/bug?extid=200d4bb11b23d929335f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+200d4bb11b23d929335f@syzkaller.appspotmail.com

usb 4-1: Direct firmware load for isl3887usb failed with error -2
usb 4-1: Firmware not found.
==================================================================
BUG: KASAN: use-after-free in p54u_load_firmware_cb.cold+0x97/0x13a  
drivers/net/wireless/intersil/p54/p54usb.c:936
Read of size 8 at addr ffff888098bf3588 by task kworker/0:1/12

CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.1.0-rc3-319004-g43151d6 #6
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events request_firmware_work_func
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xe8/0x16e lib/dump_stack.c:113
  print_address_description+0x6c/0x236 mm/kasan/report.c:187
  kasan_report.cold+0x1a/0x3c mm/kasan/report.c:317
  p54u_load_firmware_cb.cold+0x97/0x13a  
drivers/net/wireless/intersil/p54/p54usb.c:936
  request_firmware_work_func+0x12d/0x249  
drivers/base/firmware_loader/main.c:785
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

The buggy address belongs to the page:
page:ffffea000262fcc0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0xfff00000000000()
raw: 00fff00000000000 0000000000000000 ffffffff02620101 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888098bf3480: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff888098bf3500: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ffff888098bf3580: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                       ^
  ffff888098bf3600: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff888098bf3680: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
