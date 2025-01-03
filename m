Return-Path: <linux-wireless+bounces-17022-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F64BA002DA
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 03:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591BD1883E7E
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 02:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737A81714C0;
	Fri,  3 Jan 2025 02:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ppz31jmI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D091A841F
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jan 2025 02:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735872347; cv=none; b=MYBexUxvcPUINmOFmJFRmUgnIzeiFf3nWgywS0tOtSL8ENoXZn3BF5y1LdgvxTdnBHBQL5S0Df7gZrX0P3OejF6ITJJ5xGGLa/iLstatjYsOHA3qgnNy6Rzm1tuJeTbRlwEJEYpN2FqDy4G4YgjYMEPj4q0BwseVPboqT2Pxg58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735872347; c=relaxed/simple;
	bh=csNapMOzDYW2GpT++51AOfypsnzXLx0xy53Xo0iRFkA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HZoy6JccjnN764qPj+3M25U7yaCbqNwTa98OAmPeL8HXEvT/K1v3sfALJJRuGC4HTKx9DMxE5ACgFBBO6RyoNNbiQaYgYnTDE91cPmNJzG9ZvdmNbbnCISk+5nvGweyqlQ2gGonz5j3uZBYmS9RxUV2VoePsSZ8oxE8ipkISE+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ppz31jmI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5032jYtnD1320884, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1735872334; bh=csNapMOzDYW2GpT++51AOfypsnzXLx0xy53Xo0iRFkA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=ppz31jmIEz1Xp8GOcR46/QKsvvKAcpxAcqb8zu7Xm1PnWR25tQNxHCm0OnzYV3kce
	 8w5nKFKj4H88rv87kn6fQCCxCmLlEZHRE6A31XsyEpSDehDOEegJuNxw6dh/WQcFHe
	 9ZwZbZeeufkMJRROvo7TTboc/2RCXfE81L7lmMqnVlsYmPajxgyHXHfRD1EBGFjUhf
	 W7jiCeyAA+AGW+ZxHaZPAO6G1SokPQ7R259GJWHrsM8ENBE7RuZjxVSjhFYBNZ3+Du
	 Rr1MoGUdEbWmYMhI5zyvL3E8eVqwJ1SSA+CbkMGV/90767nv7LifBHzU3K/EwT1XlK
	 5WEcBOnPlCjzQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5032jYtnD1320884
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jan 2025 10:45:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 3 Jan 2025 10:45:34 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 3 Jan
 2025 10:45:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH] wifi: rtw89: avoid to init mgnt_entry list twice when WoWLAN failed
Date: Fri, 3 Jan 2025 10:45:00 +0800
Message-ID: <20250103024500.14990-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Chih-Kang Chang <gary.chang@realtek.com>

If WoWLAN failed in resume flow, the rtw89_ops_add_interface() triggered
without removing the interface first. Then the mgnt_entry list init again,
causing the list_empty() check in rtw89_chanctx_ops_assign_vif()
useless, and list_add_tail() again. Therefore, we have added a check to
prevent double adding of the list.

rtw89_8852ce 0000:01:00.0: failed to check wow status disabled
rtw89_8852ce 0000:01:00.0: wow: failed to check disable fw ready
rtw89_8852ce 0000:01:00.0: wow: failed to swap to normal fw
rtw89_8852ce 0000:01:00.0: failed to disable wow
rtw89_8852ce 0000:01:00.0: failed to resume for wow -110
rtw89_8852ce 0000:01:00.0: MAC has already powered on
i2c_hid_acpi i2c-ILTK0001:00: PM: acpi_subsys_resume+0x0/0x60 returned 0 after 284705 usecs
list_add corruption. prev->next should be next (ffff9d9719d82228), but was ffff9d9719f96030. (prev=ffff9d9719f96030).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:34!
invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 2 PID: 6918 Comm: kworker/u8:19 Tainted: G     U     O
Hardware name: Google Anraggar/Anraggar, BIOS Google_Anraggar.15217.514.0 03/25/2024
Workqueue: events_unbound async_run_entry_fn
RIP: 0010:__list_add_valid_or_report+0x9f/0xb0
Code: e8 56 89 ff ff 0f 0b 48 c7 c7 3e fc e0 96 48 89 c6 e8 45 89 ff ...
RSP: 0018:ffffa51b42bbbaf0 EFLAGS: 00010246
RAX: 0000000000000075 RBX: ffff9d9719d82ab0 RCX: 13acb86e047a4400
RDX: 3fffffffffffffff RSI: 0000000000000000 RDI: 00000000ffffdfff
RBP: ffffa51b42bbbb28 R08: ffffffff9768e250 R09: 0000000000001fff
R10: ffffffff9765e250 R11: 0000000000005ffd R12: ffff9d9719f95c40
R13: ffff9d9719f95be8 R14: ffff9d97081bfd78 R15: ffff9d9719d82060
FS:  0000000000000000(0000) GS:ffff9d9a6fb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007e7d029a4060 CR3: 0000000345e38000 CR4: 0000000000750ee0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __die_body+0x68/0xb0
 ? die+0xaa/0xd0
 ? do_trap+0x9f/0x170
 ? __list_add_valid_or_report+0x9f/0xb0
 ? __list_add_valid_or_report+0x9f/0xb0
 ? handle_invalid_op+0x69/0x90
 ? __list_add_valid_or_report+0x9f/0xb0
 ? exc_invalid_op+0x3c/0x50
 ? asm_exc_invalid_op+0x16/0x20
 ? __list_add_valid_or_report+0x9f/0xb0
 rtw89_chanctx_ops_assign_vif+0x1f9/0x210 [rtw89_core cbb375c44bf28564ce479002bff66617a25d9ac1]
 ? __mutex_unlock_slowpath+0xa0/0xf0
 rtw89_ops_assign_vif_chanctx+0x4b/0x90 [rtw89_core cbb375c44bf28564ce479002bff66617a25d9ac1]
 drv_assign_vif_chanctx+0xa7/0x1f0 [mac80211 6efaad16237edaaea0868b132d4f93ecf918a8b6]
 ieee80211_reconfig+0x9cb/0x17b0 [mac80211 6efaad16237edaaea0868b132d4f93ecf918a8b6]
 ? __pfx_wiphy_resume+0x10/0x10 [cfg80211 572d03acaaa933fe38251be7fce3b3675284b8ed]
 ? dev_printk_emit+0x51/0x70
 ? _dev_info+0x6e/0x90
 wiphy_resume+0x89/0x180 [cfg80211 572d03acaaa933fe38251be7fce3b3675284b8ed]
 ? __pfx_wiphy_resume+0x10/0x10 [cfg80211 572d03acaaa933fe38251be7fce3b3675284b8ed]
 dpm_run_callback+0x37/0x1e0
 device_resume+0x26d/0x4b0
 ? __pfx_dpm_watchdog_handler+0x10/0x10
 async_resume+0x1d/0x30
 async_run_entry_fn+0x29/0xd0
 worker_thread+0x397/0x970
 kthread+0xed/0x110
 ? __pfx_worker_thread+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x38/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>

Fixes: 68ec751b2881 ("wifi: rtw89: chan: manage active interfaces")
Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 5eac0b524060..793db52ad60a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -189,10 +189,10 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 
 	rtw89_core_txq_init(rtwdev, vif->txq);
 
-	if (!rtw89_rtwvif_in_list(rtwdev, rtwvif))
+	if (!rtw89_rtwvif_in_list(rtwdev, rtwvif)) {
 		list_add_tail(&rtwvif->list, &rtwdev->rtwvifs_list);
-
-	INIT_LIST_HEAD(&rtwvif->mgnt_entry);
+		INIT_LIST_HEAD(&rtwvif->mgnt_entry);
+	}
 
 	ether_addr_copy(rtwvif->mac_addr, vif->addr);
 
-- 
2.25.1


