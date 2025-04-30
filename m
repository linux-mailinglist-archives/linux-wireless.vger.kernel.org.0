Return-Path: <linux-wireless+bounces-22284-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8F8AA5676
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 23:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FFB981A0B
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 21:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC27266B47;
	Wed, 30 Apr 2025 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="jOB54YGU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46F7347C7
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746047271; cv=none; b=GJ9dRJ+YoYS8U5yS6Pt94tF/anAAXwxI5ZrNNrFN+ueKZChq9rLBih+25s/9OMd951pB8KFdCCiLSonn/B5mVscFj5WNTX8k7FTfOJJts5AeK6R3g/XX0Npt2g8rnhejq4KzXlaHpHLaYC5yAJe7M7FHB/mXsHYHvYlBdZZDO8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746047271; c=relaxed/simple;
	bh=xRpF/t/AILT89nDGMalZwbDaiIM2Bg6wraGR/kZ03Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m3lLYq8PNR0EwimXDJHeKNVVqAZLuxEn4DOyMtyJVNdRQUUXUvMSbhZ67gFDDPv+yZS6+fJNX9NeR1MK39KygZ74Sr1t9vE37044lua+WGRCfAS+EuK7UQUIy5IHsrCGFmHHjKUIVJBiJ2YHIZrTuAtPndChz7BIwMfzwATwHjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=jOB54YGU; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from engine.ppe-hosted.com (unknown [10.7.65.208])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id CD0B0600CF;
	Wed, 30 Apr 2025 21:07:43 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5ED9210007E;
	Wed, 30 Apr 2025 21:07:42 +0000 (UTC)
Received: from carkeek.lan (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 7AE6613C2B0;
	Wed, 30 Apr 2025 14:07:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7AE6613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1746047261;
	bh=xRpF/t/AILT89nDGMalZwbDaiIM2Bg6wraGR/kZ03Dg=;
	h=From:To:Cc:Subject:Date:From;
	b=jOB54YGURRcExUJdtShgwasaKA2fZcEpIA4IGahxrWRCv+0GrKQ5Hd1x2Sf9la9Y2
	 KJORcrqUBtM7eT8Om5j58nkxH5FZldztHqtuA4JRbnR6Bva3ViaTaaOYm529n5eWgz
	 1ZtzjRAx04r0hVnigy8o8/MEA7MVlJrVyJq49D4A=
From: Rory Little <rory@candelatech.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org,
	Rory Little <rory@candelatech.com>
Subject: [PATCH iwlwifi-next] wifi: iwlwifi: mld: Fix iteration of uninitialized async handler list.
Date: Wed, 30 Apr 2025 14:06:27 -0700
Message-ID: <20250430210627.3674314-1-rory@candelatech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1746047263-W34QHECfapzc
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1746047263;W34QHECfapzc;<rory@candelatech.com>;b05365583a7ac22983513582f8b41fd7
X-PPE-TRUSTED: V=1;DIR=OUT;

There were a few cases where iteration of the async_handlers_list would
be attempted before the list was initialized by async_handlers_wk. This
patch initializes that list during mld construction to guard against
that case.

This fixes a panic seen on boot:

BUG: kernel NULL pointer dereference, address: 0000000000000000
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP
CPU: 1 UID: 0 PID: 910 Comm: modprobe Not tainted 6.15.0-rc2+ #3 PREEMPT(full)
Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
RIP: 0010:iwl_mld_cancel_async_notifications+0x4a/0xd0 [iwlmld]
Code: ...
RSP: 0018:ffffc9000097fbf0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000004000000
RDX: 0000000000000001 RSI: 0000000000000292 RDI: ffff888127d73d70
RBP: ffff888127d72028 R08: ffffffffa0fc9485 R09: ffffffffa0fc8b8a
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888127d73d60
R13: 0000000000000003 R14: ffff888127d73150 R15: ffff888127d72020
FS:  00007f942ece3740(0000) GS:ffff8884da78e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000135bd6004 CR4: 00000000003726f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iwl_mld_stop_fw+0x35/0x40 [iwlmld]
 iwl_op_mode_mld_start+0x3b6/0x4c0 [iwlmld]
 ? inode_set_ctime_current+0x185/0x220
 _iwl_op_mode_start+0x58/0xd0 [iwlwifi]
 iwl_opmode_register+0x69/0xc0 [iwlwifi]
 ? mt7996_init+0x1000/0x1000 [mt7996e]
 iwl_mld_init+0x19/0x1000 [iwlmld]
 ? mt7996_init+0x1000/0x1000 [mt7996e]
 do_one_initcall+0x3e/0x2e0
 ? do_init_module+0x22/0x210
 do_init_module+0x60/0x210
 init_module_from_file+0x85/0xc0
 idempotent_init_module+0xfe/0x2f0
 __x64_sys_finit_module+0x61/0xc0
 do_syscall_64+0x4b/0xf50
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Signed-off-by: Rory Little <rory@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 87624730fb50..d78d1b4334de 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -77,6 +77,7 @@ void iwl_construct_mld(struct iwl_mld *mld, struct iwl_trans *trans,
 
 	/* Setup async RX handling */
 	spin_lock_init(&mld->async_handlers_lock);
+	INIT_LIST_HEAD(&mld->async_handlers_list);
 	wiphy_work_init(&mld->async_handlers_wk,
 			iwl_mld_async_handlers_wk);
 
-- 
2.45.2


