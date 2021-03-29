Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD86A34DB48
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Mar 2021 00:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhC2W13 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Mar 2021 18:27:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232744AbhC2WYK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Mar 2021 18:24:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 718CF619B5;
        Mon, 29 Mar 2021 22:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617056614;
        bh=wr1kZ79QxsRd59D8OKxICgc9aTlAjvNLpPyNm7bddsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aw4EN1DfJQFuUiGmtVgEFAL1RVNsvznaDryWAN/CgNYWXXghwIYjp9FFZcUl2OYjj
         40T796oeYZlhEhrHWsMtEGPeH2HzmbFUKCmlBzu9e5AD4VBoXKyWJuRtCeksvwoapK
         tAiNFNp1En+j/nPdzkCoKzDfno6AAr2C4ws7sbUvUxDjz/aRWpI37X7plwuhsL/jBr
         OuvNQ8wCqtbmktmePxsRTp0F5Fkl5rq3HUDfAvOcu4tkCjul+vNQ89Z91bZ0jxjgCC
         0zfh+pfMauYU/S2KBpGMupq+W23OKD0Fy2n8ywGYov3JvuCBrnHRP4Xe+wdz74Oc8Y
         2H7PiKjPjxM/Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Markus Theil <markus.theil@tu-ilmenau.de>,
        syzbot+93976391bf299d425f44@syzkaller.appspotmail.com,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 06/15] mac80211: fix double free in ibss_leave
Date:   Mon, 29 Mar 2021 18:23:17 -0400
Message-Id: <20210329222327.2383533-6-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210329222327.2383533-1-sashal@kernel.org>
References: <20210329222327.2383533-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Markus Theil <markus.theil@tu-ilmenau.de>

[ Upstream commit 3bd801b14e0c5d29eeddc7336558beb3344efaa3 ]

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
Link: https://lore.kernel.org/r/20210213133653.367130-1-markus.theil@tu-ilmenau.de
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/ibss.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index f0f5fedb8caa..fa13eef25f2c 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1861,6 +1861,8 @@ int ieee80211_ibss_leave(struct ieee80211_sub_if_data *sdata)
 
 	/* remove beacon */
 	kfree(sdata->u.ibss.ie);
+	sdata->u.ibss.ie = NULL;
+	sdata->u.ibss.ie_len = 0;
 
 	/* on the next join, re-program HT parameters */
 	memset(&ifibss->ht_capa, 0, sizeof(ifibss->ht_capa));
-- 
2.30.1

