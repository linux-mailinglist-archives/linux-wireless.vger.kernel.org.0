Return-Path: <linux-wireless+bounces-20477-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8204AA6671D
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 04:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3157C3BD9B0
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 03:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89496199FD0;
	Tue, 18 Mar 2025 03:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="XO5R4i5D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA48D18FC67;
	Tue, 18 Mar 2025 03:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742267647; cv=none; b=r9IAvRsOvxncBsY7EYACIed+KyI0xE2fzqXvRg4sENj/c8faO+dDBaepeTHrtHdAWvDwD9Zd/6GeSB6ubjN4n3/86Lz4ctiKnGaTQ2ngXrjCbDSp9p4K8m2Ec3EjIbIhjGDV8J7y57te8CAdFkACKeMAZjtI/SPI9Uougm4nlNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742267647; c=relaxed/simple;
	bh=AZ55Y92hDkMTOjwm7JJ9rYKlm9+ZZbx/UiUTMCgRNrg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=eMgvaB12SbWPHmiJrgonY8HCvrXaJg4uHZmoCGO4SEhRy940uuG9zk6emH+HFtd/KdcCYePkuq4hpnimYJ9aSjArJ+CjDnw2ghQVJ1bERjf7CnNywwWiJS/D4OGTNC9mfOzSRbRzmVg/9JOUumoU9SempeZrDzMohl3V6qj4SPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=XO5R4i5D; arc=none smtp.client-ip=43.163.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742267626; bh=RbkgErBKSjIjyF/NQ8SNlrc08UBPt0RCDXZR18vxpx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XO5R4i5DvgofXa8GJUrpll78yZaxMc8y9TODoPv//kPBSG38Wi4Tlnpdw5qzYuAz0
	 fR2920lwn7fytgyPhkc6juIq2jHSypRfv0a3PFkxVRMGW66BQTq5JDYJGHdFUeq9Ex
	 vNiAZBf1EJS4MfikJ2PPhKsSvm4k/LTw+J/lBGfM=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 36CB9081; Tue, 18 Mar 2025 11:13:44 +0800
X-QQ-mid: xmsmtpt1742267624tayv9vcrg
Message-ID: <tencent_258DD9121DDDB9DD9A1939CFAA0D8625B107@qq.com>
X-QQ-XMAILINFO: N2OjbX1i5tuyTIiVi6B6/ExXFm3Cn/m/CL81NjqXX405hDX1Nl0Us9snWAQ5+F
	 dnaHTj4NZwLVj1hzU3GFjc2Dtpu6I65OR5+9y0SBTrxYHnrwm0ob+KbJHvCGH1IPNTfvIk7ZTq8Q
	 o1WHR3Y4R3GBeQbNqqIHNjibqyqS3D4SyfekJEGDV6A8e407QChzzPH4kx4YI/4/L4IVzyz9+SSI
	 zjE39tsinsIB4cYYyWRftinBVT3jsdUgIOrDlaf9+73ZubpjREC9QIP8GJcSvH4eVkCjGh5GR7dh
	 Qt9QhCWlgW9VP0yg5s0icjSCSCL/k5+rgS1C239EOK805Mh4Hrqp0A6T8U7avzEncvJHVPbpjntF
	 4GZTcsn+eupV7MKufWnUxl2IDeN/sJjUtB4q/oWtFUX+pC3/AxAhHFZ6v+NRNTZO7pfZweQwabux
	 Uo72l33vnEqKgFw0M7Zq4Ik3NS8pp472JyObv4S7H4wkq7CIYDQ0FQ+RfsywcpvE80CETG4rdRZM
	 8acTg8p68MDANoif1Kr1fXeYleLKq0E9GKa6dHSZNvIdcMZZ8ZzmqwvpMyasm3WG2BpfN5Cgf3j2
	 zykhXbzUT5msO4N7nB/w1mtIw7LPW5R7wYrrrbsiiS2QRoTt3Is0lWjbFZgE77VCKFm3RV2sCJWw
	 zJwKheNRs94wqpzQt0SZyAwabaQ0A1AoOQEqRBbSDo6jNbW7J5w9G1kDwGDS6omZNytLYq40WBfv
	 S8/2MmFeLIWDg+EC/vu7Ai6HeGkb6w6bjZ5jQutdu3qn/DHpIZHFiTbmZDQ2BdptG4GSF4TApC9D
	 +s8oZYxwlBDB8b5oKz9d+5Sy4QmPEEQComRz9e2VTlikd0tBcgL3P4uEba6hj9LoJCtww8hXKht9
	 4yZK0HjZeSG3zHw1CrIGEUjKt1adLbla88MCI5e0OVGaKK1eluZ1I=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+aaf0488c83d1d5f4f029@syzkaller.appspotmail.com
Cc: johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] wifi: cfg80211: init wiphy_work before allocating rfkill fails
Date: Tue, 18 Mar 2025 11:13:45 +0800
X-OQ-MSGID: <20250318031344.3109525-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67d8804b.050a0220.2ca2c6.006b.GAE@google.com>
References: <67d8804b.050a0220.2ca2c6.006b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbort reported a uninitialize wiphy_work_lock in cfg80211_dev_free. [1]

After rfkill allocation fails, the wiphy release process will be performed,
which will cause cfg80211_dev_free to access the uninitialized wiphy_work
related data.

Move the initialization of wiphy_work to before rfkill initialization to
avoid this issue.

[1]
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 5935 Comm: syz-executor550 Not tainted 6.14.0-rc6-syzkaller-00103-g4003c9e78778 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 assign_lock_key kernel/locking/lockdep.c:983 [inline]
 register_lock_class+0xc39/0x1240 kernel/locking/lockdep.c:1297
 __lock_acquire+0x135/0x3c40 kernel/locking/lockdep.c:5103
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
 cfg80211_dev_free+0x30/0x3d0 net/wireless/core.c:1196
 device_release+0xa1/0x240 drivers/base/core.c:2568
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e4/0x5a0 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3774
 wiphy_free net/wireless/core.c:1224 [inline]
 wiphy_new_nm+0x1c1f/0x2160 net/wireless/core.c:562
 ieee80211_alloc_hw_nm+0x1b7a/0x2260 net/mac80211/main.c:835
 mac80211_hwsim_new_radio+0x1d6/0x54e0 drivers/net/wireless/virtual/mac80211_hwsim.c:5185
 hwsim_new_radio_nl+0xb42/0x12b0 drivers/net/wireless/virtual/mac80211_hwsim.c:6242
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2533
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1338
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1882
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg net/socket.c:733 [inline]
 ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2573
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2627
 __sys_sendmsg+0x16e/0x220 net/socket.c:2659
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83

Fixes: 72d520476a2f ("wifi: cfg80211: cancel wiphy_work before freeing wiphy")
Reported-by: syzbot+aaf0488c83d1d5f4f029@syzkaller.appspotmail.com
Close: https://syzkaller.appspot.com/bug?extid=aaf0488c83d1d5f4f029
Tested-by: syzbot+aaf0488c83d1d5f4f029@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/wireless/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 828e29872633..ceb768925b85 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -546,6 +546,9 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 	INIT_WORK(&rdev->mgmt_registrations_update_wk,
 		  cfg80211_mgmt_registrations_update_wk);
 	spin_lock_init(&rdev->mgmt_registrations_lock);
+	INIT_WORK(&rdev->wiphy_work, cfg80211_wiphy_work);
+	INIT_LIST_HEAD(&rdev->wiphy_work_list);
+	spin_lock_init(&rdev->wiphy_work_lock);
 
 #ifdef CONFIG_CFG80211_DEFAULT_PS
 	rdev->wiphy.flags |= WIPHY_FLAG_PS_ON_BY_DEFAULT;
@@ -563,9 +566,6 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 		return NULL;
 	}
 
-	INIT_WORK(&rdev->wiphy_work, cfg80211_wiphy_work);
-	INIT_LIST_HEAD(&rdev->wiphy_work_list);
-	spin_lock_init(&rdev->wiphy_work_lock);
 	INIT_WORK(&rdev->rfkill_block, cfg80211_rfkill_block_work);
 	INIT_WORK(&rdev->conn_work, cfg80211_conn_work);
 	INIT_WORK(&rdev->event_work, cfg80211_event_work);
-- 
2.43.0


