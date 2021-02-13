Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588C631ABE8
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Feb 2021 14:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhBMNhu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Feb 2021 08:37:50 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:53433 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhBMNhr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Feb 2021 08:37:47 -0500
Received: from legolas.fritz.box (unknown [84.174.249.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 8DAE458004F;
        Sat, 13 Feb 2021 14:37:03 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>,
        syzbot+93976391bf299d425f44@syzkaller.appspotmail.com
Subject: [PATCH] mac80211: fix double free in ibss_leave
Date:   Sat, 13 Feb 2021 14:36:53 +0100
Message-Id: <20210213133653.367130-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Clear beacon ie pointer and ie length after free
in order to prevent double free.

==================================================================
BUG: KASAN: double-free or invalid-free \
in ieee80211_ibss_leave+0x83/0xe0 net/mac80211/ibss.c:1876

CPU: 0 PID: 8472 Comm: syz-executor100 Not tainted 5.11.0-rc6-syzkaller #0
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2c6 mm/kasan/report.c:230
 kasan_report_invalid_free+0x51/0x80 mm/kasan/report.c:355
 ____kasan_slab_free+0xcc/0xe0 mm/kasan/common.c:341
 kasan_slab_free include/linux/kasan.h:192 [inline]
 __cache_free mm/slab.c:3424 [inline]
 kfree+0xed/0x270 mm/slab.c:3760
 ieee80211_ibss_leave+0x83/0xe0 net/mac80211/ibss.c:1876
 rdev_leave_ibss net/wireless/rdev-ops.h:545 [inline]
 __cfg80211_leave_ibss+0x19a/0x4c0 net/wireless/ibss.c:212
 __cfg80211_leave+0x327/0x430 net/wireless/core.c:1172
 cfg80211_leave net/wireless/core.c:1221 [inline]
 cfg80211_netdev_notifier_call+0x9e8/0x12c0 net/wireless/core.c:1335
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2040
 call_netdevice_notifiers_extack net/core/dev.c:2052 [inline]
 call_netdevice_notifiers net/core/dev.c:2066 [inline]
 __dev_close_many+0xee/0x2e0 net/core/dev.c:1586
 __dev_close net/core/dev.c:1624 [inline]
 __dev_change_flags+0x2cb/0x730 net/core/dev.c:8476
 dev_change_flags+0x8a/0x160 net/core/dev.c:8549
 dev_ifsioc+0x210/0xa70 net/core/dev_ioctl.c:265
 dev_ioctl+0x1b1/0xc40 net/core/dev_ioctl.c:511
 sock_do_ioctl+0x148/0x2d0 net/socket.c:1060
 sock_ioctl+0x477/0x6a0 net/socket.c:1177
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported-by: syzbot+93976391bf299d425f44@syzkaller.appspotmail.com
Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 net/mac80211/ibss.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 1f552f374e97..a7ac53a2f00d 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1874,6 +1874,8 @@ int ieee80211_ibss_leave(struct ieee80211_sub_if_data *sdata)
 
 	/* remove beacon */
 	kfree(sdata->u.ibss.ie);
+	sdata->u.ibss.ie = NULL;
+	sdata->u.ibss.ie_len = 0;
 
 	/* on the next join, re-program HT parameters */
 	memset(&ifibss->ht_capa, 0, sizeof(ifibss->ht_capa));
-- 
2.30.1

