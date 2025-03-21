Return-Path: <linux-wireless+bounces-20685-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAC5A6C2CB
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 19:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E878D3BCA96
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 18:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30BE22FF35;
	Fri, 21 Mar 2025 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="X3tSc357"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ksmg02.maxima.ru (ksmg02.maxima.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D2722D7BA;
	Fri, 21 Mar 2025 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742583217; cv=none; b=Yw4dtrKm3SH8FSbYc0BDsJXjBRo4wE5PiybZUYHOCkFfMtdWuLqjIubVuz4lUjkj77skEiJT0WYHRNwhTrCJbOH8mE8bM3GiCPbrZxp/WRmiBybe06N/AdiJLKTFeeksRKN4wPOJdHVa+PdLsg893gpgx8mmJjCSI5Sp99fK8xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742583217; c=relaxed/simple;
	bh=QVEwT/ykQ9I6K/gDQNMOzSTQgUeryTa5hYsa2X5RmZ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G02suO0pByNbcUOBnu73L3ILxCeyrHZCYy9kNHbUwudOqETksWbCK0cicQ46OZidrOt++Qmpswc4FpD0IK8XbsA8L7wII6+YJ94O4hfK5YHWg8LYG4JlGFhu7aakAE38Q8LTafgdQWitOvlwt+/AIV3sJR/BtqYxrfsgReNmH0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=X3tSc357; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id CEA351E0010;
	Fri, 21 Mar 2025 21:53:32 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru CEA351E0010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1742583212; bh=BG20EjTXDeypKOSUQyeZVTaydt0RfTYxkDp4Kqypr9M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=X3tSc35772UcVLGjerfsFOvo7nvXRe1b3TwmnRnZ3Q7b7FJQ4SRAk1FbBttAnoHek
	 2dQVTKdSjZ+/5cMWbYEBmASMg9jj+c5JL/doxJKQ/Z0JXSkN1n31AsDgyWBJhiJeL6
	 BkXF556vyPvQsBmO2Ywgh4/oP/7uGQgtN+nWgptZHqugxzLkek/TYI/H4eUvbToyE/
	 A1iBI8X7T5CGpoiNUyqE/4+ij6UQ3L468c2698jgjpEacSwr3tEGrK2q7AnQl6Ohi0
	 V4gdsOII7+KtbKrqbRwl9LUuZNAgyCBVxx1bSWML5JatuxYoWCYe85CEewdaRLQ13P
	 evsYWhVsMdWkg==
Received: from ksmg02.maxima.ru (mail.maxima.ru [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Fri, 21 Mar 2025 21:53:32 +0300 (MSK)
Received: from GS-NOTE-190.mt.ru (10.0.247.178) by mmail-p-exch02.mt.ru
 (81.200.124.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Fri, 21 Mar
 2025 21:53:28 +0300
From: Murad Masimov <m.masimov@mt-integration.ru>
To: Srinivasan Raju <srini.raju@purelifi.com>
CC: Murad Masimov <m.masimov@mt-integration.ru>, Miri Korenblit
	<miriam.rachel.korenblit@intel.com>, Emmanuel Grumbach
	<emmanuel.grumbach@intel.com>, Johannes Berg <johannes.berg@intel.com>, Al
 Viro <viro@zeniv.linux.org.uk>, Kalle Valo <kvalo@kernel.org>,
	<linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>,
	<syzbot+7d4f142f6c288de8abfe@syzkaller.appspotmail.com>
Subject: [PATCH 1/2] wifi: plfxlc: Remove erroneous assert in plfxlc_mac_release
Date: Fri, 21 Mar 2025 21:52:25 +0300
Message-ID: <20250321185226.71-2-m.masimov@mt-integration.ru>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20250321185226.71-1-m.masimov@mt-integration.ru>
References: <20250321185226.71-1-m.masimov@mt-integration.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch02.mt.ru
 (81.200.124.62)
X-KSMG-AntiPhishing: NotDetected, bases: 2025/03/21 17:38:00
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: m.masimov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {rep_avail}, {Tracking_one_url}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;syzkaller.appspot.com:5.0.1,7.1.1;81.200.124.62:7.1.2;ksmg02.maxima.ru:7.1.1;mt-integration.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.62
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192024 [Mar 21 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/03/21 15:38:00 #27810206
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/03/21 17:39:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

plfxlc_mac_release() asserts that mac->lock is held. This assertion is
incorrect, because even if it was possible, it would not be the valid
behaviour. The function is used when probe fails or after the device is
disconnected. In both cases mac->lock can not be held as the driver is
not working with the device at the moment. All functions that use mac->lock
unlock it just after it was held. There is also no need to hold mac->lock
for plfxlc_mac_release() itself, as mac data is not affected, except for
mac->flags, which is modified atomically.

This bug leads to the following warning:
================================================================
WARNING: CPU: 0 PID: 127 at drivers/net/wireless/purelifi/plfxlc/mac.c:106 plfxlc_mac_release+0x7d/0xa0
Modules linked in:
CPU: 0 PID: 127 Comm: kworker/0:2 Not tainted 6.1.124-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:plfxlc_mac_release+0x7d/0xa0 drivers/net/wireless/purelifi/plfxlc/mac.c:106
Call Trace:
 <TASK>
 probe+0x941/0xbd0 drivers/net/wireless/purelifi/plfxlc/usb.c:694
 usb_probe_interface+0x5c0/0xaf0 drivers/usb/core/driver.c:396
 really_probe+0x2ab/0xcb0 drivers/base/dd.c:639
 __driver_probe_device+0x1a2/0x3d0 drivers/base/dd.c:785
 driver_probe_device+0x50/0x420 drivers/base/dd.c:815
 __device_attach_driver+0x2cf/0x510 drivers/base/dd.c:943
 bus_for_each_drv+0x183/0x200 drivers/base/bus.c:429
 __device_attach+0x359/0x570 drivers/base/dd.c:1015
 bus_probe_device+0xba/0x1e0 drivers/base/bus.c:489
 device_add+0xb48/0xfd0 drivers/base/core.c:3696
 usb_set_configuration+0x19dd/0x2020 drivers/usb/core/message.c:2165
 usb_generic_driver_probe+0x84/0x140 drivers/usb/core/generic.c:238
 usb_probe_device+0x130/0x260 drivers/usb/core/driver.c:293
 really_probe+0x2ab/0xcb0 drivers/base/dd.c:639
 __driver_probe_device+0x1a2/0x3d0 drivers/base/dd.c:785
 driver_probe_device+0x50/0x420 drivers/base/dd.c:815
 __device_attach_driver+0x2cf/0x510 drivers/base/dd.c:943
 bus_for_each_drv+0x183/0x200 drivers/base/bus.c:429
 __device_attach+0x359/0x570 drivers/base/dd.c:1015
 bus_probe_device+0xba/0x1e0 drivers/base/bus.c:489
 device_add+0xb48/0xfd0 drivers/base/core.c:3696
 usb_new_device+0xbdd/0x18f0 drivers/usb/core/hub.c:2620
 hub_port_connect drivers/usb/core/hub.c:5477 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5617 [inline]
 port_event drivers/usb/core/hub.c:5773 [inline]
 hub_event+0x2efe/0x5730 drivers/usb/core/hub.c:5855
 process_one_work+0x8a9/0x11d0 kernel/workqueue.c:2292
 worker_thread+0xa47/0x1200 kernel/workqueue.c:2439
 kthread+0x28d/0x320 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
================================================================

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 68d57a07bfe5 ("wireless: add plfxlc driver for pureLiFi X, XL, XC devices")
Reported-by: syzbot+7d4f142f6c288de8abfe@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7d4f142f6c288de8abfe
Signed-off-by: Murad Masimov <m.masimov@mt-integration.ru>
---
 drivers/net/wireless/purelifi/plfxlc/mac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/purelifi/plfxlc/mac.c b/drivers/net/wireless/purelifi/plfxlc/mac.c
index eae93efa6150..82d1bf7edba2 100644
--- a/drivers/net/wireless/purelifi/plfxlc/mac.c
+++ b/drivers/net/wireless/purelifi/plfxlc/mac.c
@@ -102,7 +102,6 @@ int plfxlc_mac_init_hw(struct ieee80211_hw *hw)
 void plfxlc_mac_release(struct plfxlc_mac *mac)
 {
 	plfxlc_chip_release(&mac->chip);
-	lockdep_assert_held(&mac->lock);
 }

 int plfxlc_op_start(struct ieee80211_hw *hw)
--
2.39.2


