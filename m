Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAE191942C5
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 16:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgCZPOT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 11:14:19 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:38293 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgCZPOT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 11:14:19 -0400
Received: by mail-il1-f199.google.com with SMTP id b6so5707981iln.5
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2020 08:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=sMQYIcxP6s383S1Iv/2tUT3HdLMKF9nZyauaAtUzZEM=;
        b=oeyClxTxg4UuywkIJ216fN41q9NorJP0//55Jsj7yfPyqiD1QQm0HdssfqrmSuHqsN
         q8d51jw9s7k5qmKXhgOajaxrnKTV2dnz9k5UQuRolupoj/awqj00B+E8yKnTR14beqLL
         bArXU1n39y/3/hWo27MBsC3zkpM/1aWTuM4XLtAgCndWUN6sNAO6RT1oDEbnZHT4xQHD
         cxBw+Y2A2/pgYqLqU+giNZ/WULQpaJNVtoYyOpNag/C02ewSNGHbMrIquMwg4F84GLhr
         o0u0gfuR7wTqYD2Wpc8LZ+3rnnUDWDRFCSYpVPvra9JOX+WawIi3iAt5c0+HdsfEDaLd
         nV+A==
X-Gm-Message-State: ANhLgQ0fFnFiqN+FrOgorhrC6WODTjghNuijs/wjWDFlTZsh6sM6Fuvt
        5QKBhGpLGkDFiWOW4f8/dKZXg00JmIeSthKucoDH0zk0KJL6
X-Google-Smtp-Source: ADFU+vuS4lXG57+YM3bVs1vgJ/z/JIV1Uy0m8cbiF4B/9amQkvgycJ+FyjmwTmZl6UYrFWNtSaercpmV9IAuTecdiZbttwsiBwdK
MIME-Version: 1.0
X-Received: by 2002:a92:c9c9:: with SMTP id k9mr8765625ilq.307.1585235658914;
 Thu, 26 Mar 2020 08:14:18 -0700 (PDT)
Date:   Thu, 26 Mar 2020 08:14:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000055c12d05a1c3701e@google.com>
Subject: KASAN: use-after-free Read in ath9k_htc_rx_msg
From:   syzbot <syzbot+666280b21749af5d36db@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, ath9k-devel@qca.qualcomm.com,
        davem@davemloft.net, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e17994d1 usb: core: kcov: collect coverage from usb comple..
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=113938c5e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d64370c438bc60
dashboard link: https://syzkaller.appspot.com/bug?extid=666280b21749af5d36db
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13fdc1e5e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1507178de00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+666280b21749af5d36db@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __wake_up_common+0x634/0x650 kernel/sched/wait.c:86
Read of size 8 at addr ffff8881cec10000 by task swapper/1/0

CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.6.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xef/0x16e lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x314 mm/kasan/report.c:374
 __kasan_report.cold+0x37/0x77 mm/kasan/report.c:506
 kasan_report+0xe/0x20 mm/kasan/common.c:641
 __wake_up_common+0x634/0x650 kernel/sched/wait.c:86
 complete+0x51/0x70 kernel/sched/completion.c:36
 htc_process_conn_rsp drivers/net/wireless/ath/ath9k/htc_hst.c:138 [inline]
 ath9k_htc_rx_msg+0x7c2/0xaf0 drivers/net/wireless/ath/ath9k/htc_hst.c:443
 ath9k_hif_usb_reg_in_cb+0x1ba/0x630 drivers/net/wireless/ath/ath9k/hif_usb.c:718
 __usb_hcd_giveback_urb+0x29a/0x550 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x368/0x420 drivers/usb/core/hcd.c:1716
 dummy_timer+0x1258/0x32ae drivers/usb/gadget/udc/dummy_hcd.c:1966


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
