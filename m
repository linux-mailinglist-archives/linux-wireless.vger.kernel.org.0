Return-Path: <linux-wireless+bounces-30093-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B33DBCDA150
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 18:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC83B3011034
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 17:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E04C2F1FDB;
	Tue, 23 Dec 2025 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aladdin.ru header.i=@aladdin.ru header.b="bfVaSIZ2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCBC3446C5;
	Tue, 23 Dec 2025 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766510435; cv=none; b=pLOrzbXVD919WCtWxduIr/uQhHefLcmjX299DHeNq14denmi0GA7pEecgDTeH3oPnTtQMZR+ZA7+EJcxK3krHN4yh5mYjQKpD+gvxIMQdAiRkUNWbOHVWjol42tnEPJp2w9Z2nNL7FHCvK0dH2oPdGUlFn2Un7ugMO1iUcYQnf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766510435; c=relaxed/simple;
	bh=z4DQUzCCy9A0c/Hf5lvP7ZtopB6V7r4uQdBwN/oigFA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eiSgiXp1Gd0i/8JHySwyK6ZJZrPTdQLs+bACGqUMQe5Cq7QCDqzixnc6aQS71xDhbibUGCYdwxQ8eueMp0SDqBehpO4gYCiUDc0blBWLDyEVuuS+Npo8L2ooHxMAWig8SCu++niadY75RdIXMf8sKM4r68bc2Mi2DkteiWFByt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; dkim=pass (2048-bit key) header.d=aladdin.ru header.i=@aladdin.ru header.b=bfVaSIZ2; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
DKIM-Signature: v=1; a=rsa-sha256; d=aladdin.ru; s=mail; c=simple/simple;
	t=1766509500; h=from:subject:to:date:message-id;
	bh=z4DQUzCCy9A0c/Hf5lvP7ZtopB6V7r4uQdBwN/oigFA=;
	b=bfVaSIZ2lIEuSqMQFhrv7O6thpJ/LKf0tWqI2IQrnJxLT8RHNPgQdaEf+poTos4K4MbO9EepDua
	d4RuNuYRIhnNjKvCz3z/4kSyVIKXe5wcHbyTETfGMqYRsNpqbOgoS1FqMeyZqG/EabxjiouXtBJz3
	T/jn8NnqVVW4yvVqcBM4hesQWLc9If5ynXlKnXXyoyxLPyeIrO3u9kiFGDI0QIn5p48CqahsSPkiD
	0gdemNuL9GLa5hnsBTpFk6cm0cQpPyrD76Xz4q56ou83BCmwkMUqCSjjO71iPngiBddCdVOijJ+gV
	2bgvoH+MDonIqt/yqar4HP53MAYEhzrMKiNg==
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Johannes Berg <johannes@sipsolutions.net>
CC: Daniil Dulov <d.dulov@aladdin.ru>, "John W. Linville"
	<linville@tuxdriver.com>, <linux-wireless@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<stable@vger.kernel.org>
Subject: [PATCH] wifi: cfg80211: Fix use-after-free in cfg80211_shutdown_all_interfaces
Date: Tue, 23 Dec 2025 20:04:52 +0300
Message-ID: <20251223170452.75358-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-04.aladdin.ru (192.168.1.104) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

There is a use-after-free error in cfg80211_shutdown_all_interfaces found
by syzkaller:

BUG: KASAN: use-after-free in cfg80211_shutdown_all_interfaces+0x213/0x220
Read of size 8 at addr ffff888112a78d98 by task kworker/0:5/5326
CPU: 0 UID: 0 PID: 5326 Comm: kworker/0:5 Not tainted 6.19.0-rc2 #2 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: events cfg80211_rfkill_block_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x116/0x1f0
 print_report+0xcd/0x630
 kasan_report+0xe0/0x110
 cfg80211_shutdown_all_interfaces+0x213/0x220
 cfg80211_rfkill_block_work+0x1e/0x30
 process_one_work+0x9cf/0x1b70
 worker_thread+0x6c8/0xf10
 kthread+0x3c5/0x780
 ret_from_fork+0x56d/0x700
 ret_from_fork_asm+0x1a/0x30
 </TASK>

The problem arises due to the rfkill_block work is not cancelled when
cfg80211 device is being freed. In order to fix the issue cancel the
corresponding work before destroying rfkill in cfg80211_dev_free().

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 1f87f7d3a3b4 ("cfg80211: add rfkill support")
Cc: stable@vger.kernel.org
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 net/wireless/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 54a34d8d356e..e94f69205f50 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1226,6 +1226,7 @@ void cfg80211_dev_free(struct cfg80211_registered_device *rdev)
 	spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
 	cancel_work_sync(&rdev->wiphy_work);
 
+	cancel_work_sync(&rdev->rfkill_block);
 	rfkill_destroy(rdev->wiphy.rfkill);
 	list_for_each_entry_safe(reg, treg, &rdev->beacon_registrations, list) {
 		list_del(&reg->list);
-- 
2.34.1


