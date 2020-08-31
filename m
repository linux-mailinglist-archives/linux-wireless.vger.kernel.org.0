Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2ABE2578A7
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 13:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgHaLsT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 07:48:19 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:43187 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgHaLsQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 07:48:16 -0400
Received: by mail-il1-f197.google.com with SMTP id 2so4838054ill.10
        for <linux-wireless@vger.kernel.org>; Mon, 31 Aug 2020 04:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/iTRQyL/57CWo3c4FNSLWhOYt/YjpXSA+mhZxmmaW1c=;
        b=h+4wsLf5wwRRmIn2BwfkTT1z13N2Yeo7tdngnk6mFTN4OC1TBfzWJe2fXCQKVVZwKK
         xUkod5qNaE1Cs3QSMFezb4iur+yUXhHmCymh0qwgc3vNeLE6LSokQrEpsAqzUzP6oWGS
         U8YbmJmaNbk7cgvqJBIBmm0CDtIQ4x0fh7oozyuMWMZFhJ0BMqFQfd/QUk3hgedzLKl/
         K9ziRjiQE88bUNmJP/jCgoKHcfldPiuE/UpxvK94VW3BT3DwMDeFs+4mQfYw9W0tnpk/
         7AoEEQskt1hKLFAbwh9QpRxmdP7Px7+1+RKrW+sYV0eWob1SLUL/dA1U1V5k2zhhnPzG
         B9iw==
X-Gm-Message-State: AOAM533bRYWDK0yQqIFgEjH4G5pwnHslsrOHUEGX/SW5JFEPtbIuCNm8
        doJ45kLIJL6EjLEhepg8VxDvAp7MT56FKHeZQC+NV69GRdmP
X-Google-Smtp-Source: ABdhPJyf0IWvn2xSDtVDcy9jX1mz8uFJZ2ZodF7CPXTs66vFHYZXXKd+eUzFUOOruTJFjocyhSNDf4WK9HL/mjX1bIBQdv5MigNK
MIME-Version: 1.0
X-Received: by 2002:a92:c9ca:: with SMTP id k10mr1023132ilq.81.1598874495578;
 Mon, 31 Aug 2020 04:48:15 -0700 (PDT)
Date:   Mon, 31 Aug 2020 04:48:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059779405ae2afa90@google.com>
Subject: KASAN: use-after-free Write in rtl_fw_do_work
From:   syzbot <syzbot+dc3cab055dff074f2d7f@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, davem@davemloft.net, kuba@kernel.org,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pkshih@realtek.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3ed8e1c2 usb: typec: tcpm: Migrate workqueue to RT priorit..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=111f9015900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccafc70ac3d5f49c
dashboard link: https://syzkaller.appspot.com/bug?extid=dc3cab055dff074f2d7f
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148a00c9900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dc3cab055dff074f2d7f@syzkaller.appspotmail.com

usb 1-1: Direct firmware load for rtlwifi/rtl8192cufw_TMSC.bin failed with error -2
usb 1-1: Direct firmware load for rtlwifi/rtl8192cufw.bin failed with error -2
rtlwifi: Loading alternative firmware rtlwifi/rtl8192cufw.bin
rtlwifi: Selected firmware is not available
==================================================================
BUG: KASAN: use-after-free in rtl_fw_do_work.cold+0x68/0x6a drivers/net/wireless/realtek/rtlwifi/core.c:93
Write of size 4 at addr ffff8881c9c2ff30 by task kworker/1:5/3063

CPU: 1 PID: 3063 Comm: kworker/1:5 Not tainted 5.9.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events request_firmware_work_func
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xf6/0x16e lib/dump_stack.c:118
 print_address_description.constprop.0+0x1c/0x210 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x37/0x7c mm/kasan/report.c:530
 rtl_fw_do_work.cold+0x68/0x6a drivers/net/wireless/realtek/rtlwifi/core.c:93
 request_firmware_work_func+0x126/0x250 drivers/base/firmware_loader/main.c:1001
 process_one_work+0x94c/0x15f0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x392/0x470 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

The buggy address belongs to the page:
page:000000008323bb9d refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1c9c2f
flags: 0x200000000000000()
raw: 0200000000000000 0000000000000000 ffffea0007270bc8 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8881c9c2fe00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8881c9c2fe80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8881c9c2ff00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                     ^
 ffff8881c9c2ff80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8881c9c30000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
