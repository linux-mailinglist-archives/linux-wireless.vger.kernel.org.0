Return-Path: <linux-wireless+bounces-24276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E68BAE11B6
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 05:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C4F3ABE07
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 03:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C759117BB21;
	Fri, 20 Jun 2025 03:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="CGw+zoWO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142FB433B1;
	Fri, 20 Jun 2025 03:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750389661; cv=none; b=QFthMVmxLe0zfEACAlm5Vn8eSxPlW3bidoftp6gE/6gzDtAP8MvfTxpMs2PJtrmKBzO8XoLUb9bj15kUIo3c1yLQ0aBBfeAbb4s4pJKoYzsdF/obVNNisfsFuTibgg2iGzAzHkPtM/7NSu8qeLeQlJHdZeaukFpVjhBAFNs5FFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750389661; c=relaxed/simple;
	bh=hv8/QDw7pTZTw/Fw7H+r0p4y2KXq8fQUxP/gm1PJpEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MUXeF9O47JuRcJExaK0qI2Hj0hoBfSfT/abUqQJeYVO+1zFGxb1CUXSnk7NiMO73/HSizDU1Khi4wib2TAOqXol7CoT+eU7HUgHfw9nNU+2v6mXNAjsBmZHrjNTJ0CgOHx0kN3+f8XzH0dA7P5sf+L6zrQD9lk6KAojL6Nrps/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=CGw+zoWO; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1750389601;
	bh=QneHD96w8Ndl9vl9DqoNfTMZSsKRbHbYDBKvCqX8VZs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=CGw+zoWOrZSODPeJ8c26ciyuz4PVJ/RTo2UYyFbVMEgwp9TPtTIb2DX25LDmK6d+N
	 iIOieLgM35lyyDq1cFyJ/QAh0V7Clr8/lOMdMfFGM9C359q6h9xnj9exBTAo1mc6xY
	 NWRbRnksSF6uKTSJTYOTO+6l2LQYV2G4wkTU85XA=
X-QQ-mid: zesmtpip2t1750389596t81357189
X-QQ-Originating-IP: /ewM7Z9sq8LHm7YLngXRO+7G1aFgwPHWLDjF85ihRlA=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 20 Jun 2025 11:19:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16747492576848269704
EX-QQ-RecipientCnt: 10
From: WangYuli <wangyuli@uniontech.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edward Adam Davis <eadavis@qq.com>,
	syzbot+aaf0488c83d1d5f4f029@syzkaller.appspotmail.com,
	Johannes Berg <johannes.berg@intel.com>,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH 6.1/6.6] wifi: cfg80211: init wiphy_work before allocating rfkill fails
Date: Fri, 20 Jun 2025 11:19:49 +0800
Message-ID: <A203ED8C00632F28+20250620031949.227937-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Naz1YHCzw2jI/9JS+yjrnGlH+vTYLorxDLI1EtxBUHqa9y13fyy0Kw2h
	S05UoyG58TpRFfnsElz5fYUaxsNuYBGNretqajpbIoL/46Wz3+2GIjJOsByzFKzkGD3fC+Q
	Lf+12ElBpgU/TnMVr0SgYLHGO43nsJZCkPoyEpqkgicG/Azq+JfZSYckepxWU4Fhj3wgtiw
	6t5O7lvVExljmE5gabiMNWGfao6fUViEChXBea4MHjLK5U6HiJVS4FxarfL8VpUutWV2rh6
	q2CEP6Eo8D6QGF8h3kx4Yj7MG2+Ebox+3Acpx9iU8w6+QSldCI233GXo4EyymUCGY2WzD9n
	Dr1ds4XgKZrjEgXYRlEkmdgdOoZHQBZaN4mspiwD/g4L7a7TRwoWsdGZKduUa3k0JPfv9c4
	2iKPgdOJPDFNuQgYWRySayzTIMf/AEQCJR2AMVeqWz7Jp2PWW2Youzj0OnS9mlU8EVqdFzF
	rf3nE8sIC0jnTaCxkgl2hwvYRMfRCXsTcm5iZcB4ssf7pOWyqTjzuVittCT7oqD8gfeRVmM
	+94KcRIakjPMGq+qnDqF9uD4ketYfk0IOwyUwoSl7191hpYOEgL6iaScEAe5l+EAY6KsqCx
	+nXic8EWagCtjex80IE3SACa7QKqymcwVxpfpxsWKIprjA/pjvB5T1dEayymZKCdXvZB1LG
	gzcn60FRpYBwsM5jo17j3zSFG0S18DPE0fBLuDZxY8FhqIY/nQKVkPIYOHZJiLMrAox0wxX
	eiuLAwIS4fDSZQZQPG4ZADUZA1JGfSf73EHroxht23Z99+0d862ugfY3J/QsHkFYPg2ovzo
	nsvX1sFXc3d9jCRp9onmMu5SImZ/trn6gQmorD4Gb3KfAnFnyz0P3FX3MYGwNZYG7QRIuZL
	5BoCq6dIF37wgXcTB82y2vIi92KjkeZEuD8Y8RDvs+3bKcx1qwcL11GEtJ00aYF6tjWjGLh
	ie1gjZMKa+owNIj2tXz4LCaGDdOyHswGAOGiVW0UOcyxIcXZvcg3a/3gMvCU6Wh1jP1elmI
	krlUfxcA==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit fc88dee89d7b63eeb17699393eb659aadf9d9b7c ]

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
Link: https://patch.msgid.link/tencent_258DD9121DDDB9DD9A1939CFAA0D8625B107@qq.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 net/wireless/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 1ce8fff2a28a..586e50678ed8 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -553,6 +553,9 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 	INIT_WORK(&rdev->mgmt_registrations_update_wk,
 		  cfg80211_mgmt_registrations_update_wk);
 	spin_lock_init(&rdev->mgmt_registrations_lock);
+	INIT_WORK(&rdev->wiphy_work, cfg80211_wiphy_work);
+	INIT_LIST_HEAD(&rdev->wiphy_work_list);
+	spin_lock_init(&rdev->wiphy_work_lock);
 
 #ifdef CONFIG_CFG80211_DEFAULT_PS
 	rdev->wiphy.flags |= WIPHY_FLAG_PS_ON_BY_DEFAULT;
@@ -570,9 +573,6 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 		return NULL;
 	}
 
-	INIT_WORK(&rdev->wiphy_work, cfg80211_wiphy_work);
-	INIT_LIST_HEAD(&rdev->wiphy_work_list);
-	spin_lock_init(&rdev->wiphy_work_lock);
 	INIT_WORK(&rdev->rfkill_block, cfg80211_rfkill_block_work);
 	INIT_WORK(&rdev->conn_work, cfg80211_conn_work);
 	INIT_WORK(&rdev->event_work, cfg80211_event_work);
-- 
2.50.0


