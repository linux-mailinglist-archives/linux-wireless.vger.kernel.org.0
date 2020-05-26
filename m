Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C241C26B4
	for <lists+linux-wireless@lfdr.de>; Sat,  2 May 2020 18:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgEBQAs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 May 2020 12:00:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727897AbgEBQAs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 May 2020 12:00:48 -0400
Received: from localhost.localdomain (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4377D24954;
        Sat,  2 May 2020 16:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588435247;
        bh=qKygv4X/XmIZL+CFHgEY9V+g3eCmGKSdkVjI0VZtll8=;
        h=From:To:Cc:Subject:Date:From;
        b=J8CEKnx8GfhJUGWZmVzS6duIZ7fx+DIa/cQ0Sk5xL4ivQ/K30qpVLzmWAA6+kT7Dp
         6MmEdHHV0VPNrKNlPiuoe875MwU4mi5p9F0GShZ3NjMfZpk4+ivKfO/vQE/AK6wl60
         0R61lBeTHDqwpxnioYgdGjNVd8I1anO4ohetIARY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7615: fix ibss mode for mt7663
Date:   Sat,  2 May 2020 18:00:41 +0200
Message-Id: <3401e41202ef64fca89c090a227da632cd93190c.1588435127.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following kernel warning adding an adhoc interface to a
mt7663e device

[  233.363394] WARNING: CPU: 0 PID: 2345 at drivers/net/wireless/mt76/mt7615/mcu.c:1449 mt7615_mcu_uni_add_bss+0x15f/0x24e [mt7615_common]
[  233.363432] CPU: 0 PID: 2345 Comm: iw Tainted: G        W       4.14.171 #12
[  233.363434] Hardware name: HP Meep/Meep, BIOS Google_Meep.11297.75.0 06/17/2019
[  233.363436] task: ffff9a1a4020e3c0 task.stack: ffffb9124113c000
[  233.363441] RIP: 0010:mt7615_mcu_uni_add_bss+0x15f/0x24e [mt7615_common]
[  233.363443] RSP: 0018:ffffb9124113f730 EFLAGS: 00010246
[  233.363446] RAX: 0000000000000024 RBX: ffff9a1a788c74e8 RCX: 41826d413aea9200
[  233.363448] RDX: 0000000000000007 RSI: 0000000000000006 RDI: ffff9a1a7fc15418
[  233.363450] RBP: ffffb9124113f7c0 R08: 0000000000000356 R09: 00000000ffff0a10
[  233.363452] R10: 0000001000000000 R11: ffffffff93f2a4be R12: 0000000000000000
[  233.363454] R13: ffff9a1a7383bd48 R14: ffffb9124113f77a R15: 0000000000000000
[  233.363456] FS:  00007f203314ab80(0000) GS:ffff9a1a7fc00000(0000) knlGS:0000000000000000
[  233.363458] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  233.363460] CR2: 00005a13d647c950 CR3: 0000000171238000 CR4: 00000000003406f0
[  233.363462] Call Trace:
[  233.363470]  mt7615_bss_info_changed+0x98/0xf4 [mt7615_common]
[  233.363484]  ieee80211_bss_info_change_notify+0x139/0x1d4 [mt76_mac80211]
[  233.363496]  ieee80211_ibss_disconnect+0x183/0x1bb [mt76_mac80211]
[  233.363507]  ieee80211_ibss_leave+0x14/0xa0 [mt76_mac80211]
[  233.363519]  __cfg80211_leave_ibss+0xa6/0x13a [cfg80211]
[  233.363528]  cfg80211_netdev_notifier_call+0x8b/0x631 [cfg80211]
[  233.363535]  ? packet_notifier+0x196/0x1a3
[  233.363540]  raw_notifier_call_chain+0x39/0x58
[  233.363544]  __dev_close_many+0x6b/0xf0
[  233.363548]  dev_close_many+0x62/0xe8
[  233.363552]  ? _raw_spin_unlock_irq+0xe/0x21
[  233.363555]  rollback_registered_many+0xf6/0x35c
[  233.363560]  ? __rcu_read_unlock+0x4a/0x4a
[  233.363563]  unregister_netdevice_queue+0x7f/0x105
[  233.363573]  ieee80211_del_iface+0x12/0x16 [mt76_mac80211]
[  233.363582]  nl80211_del_interface+0xa8/0x124 [cfg80211]
[  233.363588]  genl_rcv_msg+0x40b/0x481
[  233.363592]  ? genl_unbind+0xb8/0xb8
[  233.363595]  netlink_rcv_skb+0x85/0xf8
[  233.363598]  genl_rcv+0x28/0x36
[  233.363601]  netlink_unicast+0x165/0x1f8
[  233.363604]  netlink_sendmsg+0x35f/0x3a6
[  233.363608]  sock_sendmsg+0x38/0x48
[  233.363611]  ___sys_sendmsg+0x1bf/0x267
[  233.363615]  ? __inode_wait_for_writeback+0x72/0xd7
[  233.363619]  ? dentry_kill+0x69/0x76
[  233.363622]  ? dput+0xd1/0x170
[  233.363624]  __sys_sendmsg+0x52/0x8f
[  233.363628]  do_syscall_64+0x6b/0xf7
[  233.363632]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[  233.363635] RIP: 0033:0x7f2032ca1264
[  233.363637] RSP: 002b:00007ffec3668e38 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[  233.363639] RAX: ffffffffffffffda RBX: 000058f7175e7880 RCX: 00007f2032ca1264
[  233.363641] RDX: 0000000000000000 RSI: 00007ffec3668e98 RDI: 0000000000000003
[  233.363643] RBP: 00007ffec3668e70 R08: 0000000000000001 R09: 00007f2032ce1fd0
[  233.363645] R10: 000058f7175e2010 R11: 0000000000000246 R12: 000058f7175e7740
[  233.363646] R13: 00007ffec3668ff0 R14: 000058f7175e2350 R15: 00007ffec3668e98

Fixes: f40ac0f3d3c0 ("mt76: mt7615: introduce mt7663e support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index d479df6a7f40..a4d90a8b347a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1417,6 +1417,9 @@ mt7615_mcu_uni_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	case NL80211_IFTYPE_STATION:
 		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_STA);
 		break;
+	case NL80211_IFTYPE_ADHOC:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
+		break;
 	default:
 		WARN_ON(1);
 		break;
-- 
2.26.2

