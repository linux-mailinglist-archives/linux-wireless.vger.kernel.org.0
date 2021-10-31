Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7B3440FD6
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Oct 2021 18:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhJaRn7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 31 Oct 2021 13:43:59 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:35619 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhJaRn4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 31 Oct 2021 13:43:56 -0400
Received: by mail-il1-f199.google.com with SMTP id h12-20020a056e021b8c00b0025aca6d29dfso8736459ili.2
        for <linux-wireless@vger.kernel.org>; Sun, 31 Oct 2021 10:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XZIexutBcQl4+tfwI5ceaURTk9hVCO5nBeCW0ejq1+c=;
        b=W/DXecwu3cWOmz4SV0UKNC1oQfOE3HLtocCFBXLkmhvyWTI9Dn8peDWssWuQhPByIV
         BHlvPijBPl92jFqlS942FIyNiRPex1deGdzytUGDKJS39Iqqg/IqR4A6SyhadLbfcj5T
         xPIIurmef3NvPmkexMJLkZaLR0Mb+CGP3y9MEV8TyDmfiBi90U8fcq0OivWNbR/oFg2s
         xe37WogEYwxvxVvLx7zJc/gNp0VcCuXjRXf4APl33pbgnj3K6Ste91zW/MHEJfnLTHnd
         0U0xZZPk7wDda0MCJN9ZMg5Z1rhUdSyQoZ/UdQMO3Eds4Z/8SOIXCnGu2H5qBiAduRGb
         Ne2A==
X-Gm-Message-State: AOAM5322N8HUTjP0y5hdgldeRgin6u5UvlB7Wjrmnvvy7OmFY1h6z3Yg
        /DCrJtGVrHT6AYtGs3dlS0AHiTMNY93nA13NYG5PtmaG1cTg
X-Google-Smtp-Source: ABdhPJwPz9+jO4xrI2cjDlEWJ666m9x8lq5Dmb+29JHkXh493otH1nbQ8sRlcpFYnfdkGmCOtV2TjYgMqTnv7WbBVgl0dH+wnUUG
MIME-Version: 1.0
X-Received: by 2002:a02:b807:: with SMTP id o7mr5718395jam.43.1635702084795;
 Sun, 31 Oct 2021 10:41:24 -0700 (PDT)
Date:   Sun, 31 Oct 2021 10:41:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b902e505cfa99115@google.com>
Subject: [syzbot] WARNING in carl9170_usb_init_device/usb_submit_urb
From:   syzbot <syzbot+e394db78ae0b0032cb4d@syzkaller.appspotmail.com>
To:     chunkeey@googlemail.com, davem@davemloft.net, kuba@kernel.org,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1fc596a56b33 Merge tag 'trace-v5.15-rc6' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100b3d64b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e24661dcff16e3ec
dashboard link: https://syzkaller.appspot.com/bug?extid=e394db78ae0b0032cb4d
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152ebd9ab00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170d4408b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e394db78ae0b0032cb4d@syzkaller.appspotmail.com

usb 1-1: device descriptor read/64, error -71
usb 1-1: reset high-speed USB device number 2 using dummy_hcd
usb 1-1: Using ep0 maxpacket: 8
usb 1-1: driver   API: 1.9.9 2016-02-15 [1-1]
usb 1-1: firmware API: 1.9.6 2012-07-07
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 0 PID: 1053 at drivers/usb/core/urb.c:503 usb_submit_urb+0xcd2/0x1970 drivers/usb/core/urb.c:502
Modules linked in:
CPU: 0 PID: 1053 Comm: kworker/0:2 Not tainted 5.15.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events request_firmware_work_func
RIP: 0010:usb_submit_urb+0xcd2/0x1970 drivers/usb/core/urb.c:502
Code: d8 48 c1 e8 03 42 8a 04 20 84 c0 0f 85 89 09 00 00 44 8b 03 48 c7 c7 c0 2c 04 8b 4c 89 fe 4c 89 f2 89 e9 31 c0 e8 5e c7 6f fb <0f> 0b 4c 8b 7c 24 10 4c 8b 64 24 38 8b 5c 24 28 45 89 e6 4c 89 f7
RSP: 0018:ffffc900045bfa20 EFLAGS: 00010246
RAX: c0488d4b2013c100 RBX: ffffffff8b042a08 RCX: ffff88801c0eb900
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff81695fe2 R09: ffffed10173857a8
R10: ffffed10173857a8 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff888014de4400 R14: ffff888012bb16b8 R15: ffffffff8b04cc80
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffa69fe690 CR3: 0000000071447000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 carl9170_usb_send_rx_irq_urb drivers/net/wireless/ath/carl9170/usb.c:504 [inline]
 carl9170_usb_init_device+0x243/0x880 drivers/net/wireless/ath/carl9170/usb.c:939
 carl9170_usb_firmware_finish drivers/net/wireless/ath/carl9170/usb.c:999 [inline]
 carl9170_usb_firmware_step2+0xa5/0x260 drivers/net/wireless/ath/carl9170/usb.c:1028
 request_firmware_work_func+0x19b/0x270 drivers/base/firmware_loader/main.c:1081
 process_one_work+0x853/0x1140 kernel/workqueue.c:2297
 worker_thread+0xac1/0x1320 kernel/workqueue.c:2444
 kthread+0x453/0x480 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
