Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE252D45CA
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 16:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgLIPtw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 10:49:52 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:44838 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgLIPtw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 10:49:52 -0500
Received: by mail-il1-f197.google.com with SMTP id c76so1658489ilf.11
        for <linux-wireless@vger.kernel.org>; Wed, 09 Dec 2020 07:49:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=yeGmm0MG4HbaGBkCEsUlCG6OY5l6+vaGEd6w4DBQHNw=;
        b=XfI9IKbzlS2KOWlPpaFM7JAT3g7EGbPpKFWhbHzATJS/IK86Ek5PL/+R+He4WjAVFI
         JYRytMQNpa/aERv75nzfL10veWP3te1q1sKFEX64PAzkhgDNJtLWBuGR77XzM6N07hQt
         1M9UipQrR59oe2RPEIHAALDAwoTf+dE299V1K2cjSFiQa0jdpj6vRLN6zPH4yUON0TFD
         lov1aPhwQfBFz49cjKAcrPJOePX5pGL1UWLep/ZtSAQO07JwhBeyrEz4S1aFdlPz8xho
         ri9RjxD1PVJhCQAlEROcCzjkmgfNFDjQDnL3DtJJvEjM8Ow4sSCm15Bv+L6Q9hBBstXb
         U2sw==
X-Gm-Message-State: AOAM533Q5xD6nc/lZITOTNKll29XkJBRGEsi4LtW3s+fL5pGRFNUf+nS
        KW2SSCt31RzyBwvG3YdnX/VDSPHO8GK1LISw6EJoVFtlSKmh
X-Google-Smtp-Source: ABdhPJwg9I+mcg1YDkCZsYwVQlfQO7HdRJG0Q1KyIJutqIWYltfuwWGQEo+XNuAIl2CuVhN4yacwB2lde2u4YdYVy8OhXA7wJVEp
MIME-Version: 1.0
X-Received: by 2002:a92:d11:: with SMTP id 17mr3821470iln.84.1607528951520;
 Wed, 09 Dec 2020 07:49:11 -0800 (PST)
Date:   Wed, 09 Dec 2020 07:49:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f22d305b60a00a4@google.com>
Subject: KASAN: use-after-free Write in rtl_fw_do_work (2)
From:   syzbot <syzbot+65be4277f3c489293939@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, davem@davemloft.net, kuba@kernel.org,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pkshih@realtek.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b175d273 USB: legotower: fix logical error in recent commit
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=12ee7c87500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d24ee9ecd7ce968e
dashboard link: https://syzkaller.appspot.com/bug?extid=65be4277f3c489293939
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+65be4277f3c489293939@syzkaller.appspotmail.com

usb 5-1: Direct firmware load for rtlwifi/rtl8192cufw.bin failed with error -2
rtlwifi: Loading alternative firmware rtlwifi/rtl8192cufw.bin
rtlwifi: Selected firmware is not available
==================================================================
BUG: KASAN: use-after-free in rtl_fw_do_work.cold+0x68/0x6a drivers/net/wireless/realtek/rtlwifi/core.c:93
Write of size 4 at addr ffff8881454cff50 by task kworker/0:6/7379

CPU: 0 PID: 7379 Comm: kworker/0:6 Not tainted 5.10.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events request_firmware_work_func
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x4c8 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
 rtl_fw_do_work.cold+0x68/0x6a drivers/net/wireless/realtek/rtlwifi/core.c:93
 request_firmware_work_func+0x12c/0x230 drivers/base/firmware_loader/main.c:1079
 process_one_work+0x933/0x1520 kernel/workqueue.c:2272
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

The buggy address belongs to the page:
page:00000000f54435b3 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1454cf
flags: 0x200000000000000()
raw: 0200000000000000 0000000000000000 ffffea00051533c8 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8881454cfe00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8881454cfe80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8881454cff00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                 ^
 ffff8881454cff80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8881454d0000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
