Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C36A249BBB
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 13:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgHSL2V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Aug 2020 07:28:21 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:41259 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgHSL2Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Aug 2020 07:28:16 -0400
Received: by mail-il1-f198.google.com with SMTP id l71so16471756ild.8
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 04:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fZ+jHgbDVnTePiqQLf+qDPU79cvKlvXb87FOaXtnhP4=;
        b=su9j7h/MY5xEpG9f2Uv6ovs48gE91rs/9zets+v/tVCUTs/gUyYEYIKQKeWUDMBdlW
         AW0QyyX8csNcNdzS43NT3WsDltcNvJRCGbFGkaNYg9Bpwei/VYpQuk7omFHNrtL7j7+d
         DRbw1BETNtAMPLGc0cpMbF0YI9RZTd4MchgiLkll+DHGjhEjjvQG46JzEpZWLeIWxF7S
         JK+li66/Hl55jmj1cbchIdoHgbN/4m2E0AIvxV8w1Zzt/lXFjNhkiLhMTYdf33gu8EX0
         9jxl+qIV/uH0lZJ7Ggbar0qvGSr/iI8kF8vx5eUecm27USGytH4+nR4+Q2OXM1pjk4SC
         ZPSw==
X-Gm-Message-State: AOAM5331p/xhjLeS3ZOJzmSPDKROZTBmlmWKIP8ezFMri4TRIPAzuUrt
        odIOW2MWklHpejxq4DKRgRYPDdzYCmIHqOJvJG+eoHhMv2OB
X-Google-Smtp-Source: ABdhPJyYxCaTjoXI5lwBslHbXVUaP0mdunUILc4ZtNELRPRKvkHL8k2pW1d50vmUXXUCxuPOh/VozsgqiR+8Aerk512vkbZi4J8M
MIME-Version: 1.0
X-Received: by 2002:a92:d7cd:: with SMTP id g13mr9475062ilq.51.1597836495670;
 Wed, 19 Aug 2020 04:28:15 -0700 (PDT)
Date:   Wed, 19 Aug 2020 04:28:15 -0700
In-Reply-To: <0000000000008e983905ac9d0182@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bbd1ff05ad394c92@google.com>
Subject: Re: KASAN: use-after-free Read in rtl_fw_do_work
From:   syzbot <syzbot+ff4b26b0bfbff2dc7960@syzkaller.appspotmail.com>
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    28157b8c USB: Better name for __check_usb_generic()
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1064697a900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccafc70ac3d5f49c
dashboard link: https://syzkaller.appspot.com/bug?extid=ff4b26b0bfbff2dc7960
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f0a00e900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162bc289900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff4b26b0bfbff2dc7960@syzkaller.appspotmail.com

usb 6-1: Direct firmware load for rtlwifi/rtl8192cufw_TMSC.bin failed with error -2
usb 6-1: Direct firmware load for rtlwifi/rtl8192cufw.bin failed with error -2
==================================================================
BUG: KASAN: use-after-free in rtl_fw_do_work+0x407/0x430 drivers/net/wireless/realtek/rtlwifi/core.c:87
Read of size 8 at addr ffff8881ca9aff38 by task kworker/0:1/328

CPU: 0 PID: 328 Comm: kworker/0:1 Not tainted 5.9.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events request_firmware_work_func
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xf6/0x16e lib/dump_stack.c:118
 print_address_description.constprop.0+0x1c/0x210 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x37/0x7c mm/kasan/report.c:530
 rtl_fw_do_work+0x407/0x430 drivers/net/wireless/realtek/rtlwifi/core.c:87
 request_firmware_work_func+0x126/0x250 drivers/base/firmware_loader/main.c:1001
 process_one_work+0x94c/0x15f0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x392/0x470 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

The buggy address belongs to the page:
page:00000000fcdef481 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1ca9af
flags: 0x200000000000000()
raw: 0200000000000000 0000000000000000 ffffea00072a6bc8 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8881ca9afe00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8881ca9afe80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8881ca9aff00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                        ^
 ffff8881ca9aff80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8881ca9b0000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================

