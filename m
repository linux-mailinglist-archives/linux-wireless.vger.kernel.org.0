Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B91745AD3
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jul 2023 13:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjGCLQE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Jul 2023 07:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGCLQD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Jul 2023 07:16:03 -0400
Received: from mail-pg1-f206.google.com (mail-pg1-f206.google.com [209.85.215.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0826BD7
        for <linux-wireless@vger.kernel.org>; Mon,  3 Jul 2023 04:16:00 -0700 (PDT)
Received: by mail-pg1-f206.google.com with SMTP id 41be03b00d2f7-53ba38cf091so4427411a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 03 Jul 2023 04:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688382959; x=1690974959;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XXNgRtmNb1bvHo0qrdCNGlVQz0VT2KR3h4bH/4bvDhQ=;
        b=ZmfI9iYLy8lfUj8LvZR7K9OYpBIgmhTGFxiau+WAl2GcA+2Su+N4UrXTb1SOuRTNhw
         yt0yY+Wm8OCRlouWN0uH7OT87iRJusDLIapmp1MrTBGloa9Sj6S6+L6oeB4xd2Jit5Si
         daRkeoC++gRW4kfm864kt6SX2i/usNBhCOtAUbioN2TuvxYwyL4Oquy7eGxF/TSAyksg
         XbmsxJ9ig4A6la5N2O8vgkxwBCRTCHllwKYVOoWMvQ6xFo23UxkVmhqNP6naq1P1+ETK
         Suut3WKSwuFG9hd0xgOzPfzk/chFz2HTlpEzmlaEIc9r4R/KOV7Yevft6hA4A8+lRT6S
         JHhQ==
X-Gm-Message-State: AC+VfDyq60qGpNUoXJZbHwc2ZSvA1XJr8pMQCcXu5yUpH7jFEI5WD9Ng
        V+tP5aUQpxB3uNK7bnQel3Ec5DKGKkjdpt3AiG20qVfpeTFb
X-Google-Smtp-Source: ACHHUZ4ErtoXsFN2urYqeqVA5Ft/zMpgnov6cqPCn4we9TqXxLLnobX7TNFGJcC/bL9dzTLnmb/rFC90lP2r/EeD+9ZwMvY1LF0g
MIME-Version: 1.0
X-Received: by 2002:a17:903:40c6:b0:1b3:a8f6:1231 with SMTP id
 t6-20020a17090340c600b001b3a8f61231mr6953486pld.4.1688382959538; Mon, 03 Jul
 2023 04:15:59 -0700 (PDT)
Date:   Mon, 03 Jul 2023 04:15:59 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c5b8c05ff934a6c@google.com>
Subject: [syzbot] [wireless?] KMSAN: uninit-value in ieee80211_rx_handlers
From:   syzbot <syzbot+be9c824e6f269d608288@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, glider@google.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    257152fe29be string: use __builtin_memcpy() in strlcpy/str..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13ba5e6f280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7bdd043d54243c
dashboard link: https://syzkaller.appspot.com/bug?extid=be9c824e6f269d608288
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/43dcd4dfe7e1/disk-257152fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f3fcd9dec66c/vmlinux-257152fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/08620f02113d/bzImage-257152fe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+be9c824e6f269d608288@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ieee80211_rx_h_action net/mac80211/rx.c:3716 [inline]
BUG: KMSAN: uninit-value in ieee80211_rx_handlers+0xccf5/0x10320 net/mac80211/rx.c:4110
 ieee80211_rx_h_action net/mac80211/rx.c:3716 [inline]
 ieee80211_rx_handlers+0xccf5/0x10320 net/mac80211/rx.c:4110
 ieee80211_invoke_rx_handlers net/mac80211/rx.c:4145 [inline]
 ieee80211_prepare_and_rx_handle+0x563e/0x9620 net/mac80211/rx.c:4987
 ieee80211_rx_for_interface+0x88d/0x990 net/mac80211/rx.c:5072
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5229 [inline]
 ieee80211_rx_list+0x5737/0x6550 net/mac80211/rx.c:5364
 ieee80211_rx_napi+0x87/0x350 net/mac80211/rx.c:5387
 ieee80211_rx include/net/mac80211.h:4918 [inline]
 ieee80211_tasklet_handler+0x1a0/0x310 net/mac80211/main.c:316
 tasklet_action_common+0x391/0xd30 kernel/softirq.c:798
 tasklet_action+0x26/0x30 kernel/softirq.c:823
 __do_softirq+0x1b7/0x78f kernel/softirq.c:571
 do_softirq+0x10d/0x190 kernel/softirq.c:472
 __local_bh_enable_ip+0x99/0xa0 kernel/softirq.c:396
 local_bh_enable+0x28/0x30 include/linux/bottom_half.h:33
 __ieee80211_tx_skb_tid_band+0x276/0x560 net/mac80211/tx.c:6057
 ieee80211_tx_skb_tid+0x203/0x290 net/mac80211/tx.c:6084
 ieee80211_mgmt_tx+0x1cff/0x2070 net/mac80211/offchannel.c:965
 rdev_mgmt_tx net/wireless/rdev-ops.h:746 [inline]
 cfg80211_mlme_mgmt_tx+0x133b/0x1ba0 net/wireless/mlme.c:815
 nl80211_tx_mgmt+0x1297/0x1840 net/wireless/nl80211.c:12594
 genl_family_rcv_msg_doit net/netlink/genetlink.c:968 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1048 [inline]
 genl_rcv_msg+0x12ed/0x1380 net/netlink/genetlink.c:1065
 netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2546
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1076
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0xf28/0x1230 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x122f/0x13d0 net/netlink/af_netlink.c:1913
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg net/socket.c:747 [inline]
 ____sys_sendmsg+0x999/0xd50 net/socket.c:2503
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2557
 __sys_sendmsg+0x222/0x3c0 net/socket.c:2586
 __compat_sys_sendmsg net/compat.c:346 [inline]
 __do_compat_sys_sendmsg net/compat.c:353 [inline]
 __se_compat_sys_sendmsg net/compat.c:350 [inline]
 __ia32_compat_sys_sendmsg+0x9d/0xe0 net/compat.c:350
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was stored to memory at:
 skb_copy_from_linear_data_offset include/linux/skbuff.h:4088 [inline]
 skb_copy_bits+0x149/0xd30 net/core/skbuff.c:2758
 skb_copy+0x47f/0xa00 net/core/skbuff.c:1948
 mac80211_hwsim_tx_frame_no_nl+0x18db/0x2130 drivers/net/wireless/virtual/mac80211_hwsim.c:1835
 mac80211_hwsim_tx+0x1a9b/0x2a10 drivers/net/wireless/virtual/mac80211_hwsim.c:2046
 drv_tx net/mac80211/driver-ops.h:35 [inline]
 ieee80211_tx_frags+0x5e7/0xd90 net/mac80211/tx.c:1752
 __ieee80211_tx+0x46e/0x630 net/mac80211/tx.c:1806
 ieee80211_tx+0x52e/0x570 net/mac80211/tx.c:1986
 ieee80211_xmit+0x54a/0x5b0 net/mac80211/tx.c:2078
 __ieee80211_tx_skb_tid_band+0x271/0x560 net/mac80211/tx.c:6056
 ieee80211_tx_skb_tid+0x203/0x290 net/mac80211/tx.c:6084
 ieee80211_mgmt_tx+0x1cff/0x2070 net/mac80211/offchannel.c:965
 rdev_mgmt_tx net/wireless/rdev-ops.h:746 [inline]
 cfg80211_mlme_mgmt_tx+0x133b/0x1ba0 net/wireless/mlme.c:815
 nl80211_tx_mgmt+0x1297/0x1840 net/wireless/nl80211.c:12594
 genl_family_rcv_msg_doit net/netlink/genetlink.c:968 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1048 [inline]
 genl_rcv_msg+0x12ed/0x1380 net/netlink/genetlink.c:1065
 netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2546
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1076
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0xf28/0x1230 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x122f/0x13d0 net/netlink/af_netlink.c:1913
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg net/socket.c:747 [inline]
 ____sys_sendmsg+0x999/0xd50 net/socket.c:2503
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2557
 __sys_sendmsg+0x222/0x3c0 net/socket.c:2586
 __compat_sys_sendmsg net/compat.c:346 [inline]
 __do_compat_sys_sendmsg net/compat.c:353 [inline]
 __se_compat_sys_sendmsg net/compat.c:350 [inline]
 __ia32_compat_sys_sendmsg+0x9d/0xe0 net/compat.c:350
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was created at:
 slab_post_alloc_hook+0x12d/0xb60 mm/slab.h:716
 slab_alloc_node mm/slub.c:3451 [inline]
 kmem_cache_alloc_node+0x535/0xa30 mm/slub.c:3496
 kmalloc_reserve+0x148/0x470 net/core/skbuff.c:568
 __alloc_skb+0x318/0x740 net/core/skbuff.c:654
 __netdev_alloc_skb+0x11a/0x6f0 net/core/skbuff.c:718
 netdev_alloc_skb include/linux/skbuff.h:3204 [inline]
 dev_alloc_skb include/linux/skbuff.h:3217 [inline]
 ieee80211_mgmt_tx+0x1316/0x2070 net/mac80211/offchannel.c:907
 rdev_mgmt_tx net/wireless/rdev-ops.h:746 [inline]
 cfg80211_mlme_mgmt_tx+0x133b/0x1ba0 net/wireless/mlme.c:815
 nl80211_tx_mgmt+0x1297/0x1840 net/wireless/nl80211.c:12594
 genl_family_rcv_msg_doit net/netlink/genetlink.c:968 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1048 [inline]
 genl_rcv_msg+0x12ed/0x1380 net/netlink/genetlink.c:1065
 netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2546
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1076
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0xf28/0x1230 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x122f/0x13d0 net/netlink/af_netlink.c:1913
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg net/socket.c:747 [inline]
 ____sys_sendmsg+0x999/0xd50 net/socket.c:2503
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2557
 __sys_sendmsg+0x222/0x3c0 net/socket.c:2586
 __compat_sys_sendmsg net/compat.c:346 [inline]
 __do_compat_sys_sendmsg net/compat.c:353 [inline]
 __se_compat_sys_sendmsg net/compat.c:350 [inline]
 __ia32_compat_sys_sendmsg+0x9d/0xe0 net/compat.c:350
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

CPU: 0 PID: 5275 Comm: syz-executor.5 Not tainted 6.4.0-syzkaller-g257152fe29be #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
