Return-Path: <linux-wireless+bounces-11600-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8417595640C
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 08:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45E3280DE6
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 06:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC6F156677;
	Mon, 19 Aug 2024 06:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="VRk73GFE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A124155756
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724050774; cv=none; b=Wjvxx9JGF64eMnAo2WZ4KXBEPWcRy+vTiR5J7AbJ1KhuNWhWJDAZNAtI41G5aJHwxE7QWVhFz2a8phsTBCG5CtXpuKPMdP/n/zy1RCSs4DvYpvghtTluQxpeFfh4UR+HMNkQIQccODqQ/82B25pGes+ZqFUqyCwb5JjhXn+MFSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724050774; c=relaxed/simple;
	bh=cW8RZkHJLBZIFLyZi9VtceHHWN3hhL+eYC/A3adD85U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBbjpMrkHkymGexackgOxWWXXMwkeZ8zWsFARhQ7OTFYXPAtvGVMSON/A69VVnXnNRUL0vMguCo4iWLQj0S9OYrm7OxwEQuh02CIjCcWRRPNPtGkw2kZuFmmx3UPBTdBFHEBA6JMkhePsA40SAt+XI3kW87Tn58eUOVmPva4i14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=VRk73GFE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47J6xBLe94007835, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724050751; bh=cW8RZkHJLBZIFLyZi9VtceHHWN3hhL+eYC/A3adD85U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=VRk73GFEYXBLLHBfzY4uPsf5XIwRvscLbnil81R067KU8VahTUcKscZ62V877JIT+
	 r+oYVC/+q4LTWZRiJaLQj/nvlJisgWmZGqK2qLvIqwmbUKeppnf7N+7Bb/lSpmcKcO
	 +zIS6g7iVXhVbi1RbvmQras0BDreAt93je6FtVnlEDIjt8CRBdivCsqV8v19KPjSc0
	 ao0M2IUwyqF0iFNoppNuy6vsN2+W0dn1oxedfWi921XCGg1DJ4N7Of1kB1LA+O78yf
	 iyHHFhqeCZ/7q6iY1Kkmar6JwnlO4wxwwxk+RW+gRKJOvtZ47l0jGbYyTCSk+2clxt
	 VgRyFzc3PE+2g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47J6xBLe94007835
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 14:59:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 14:59:12 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 19 Aug
 2024 14:59:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC: <pbrobinson@gmail.com>
Subject: [PATCH 2/2] wifi: rtw88: use ieee80211_purge_tx_queue() to purge TX skb
Date: Mon, 19 Aug 2024 14:58:55 +0800
Message-ID: <20240819065855.25678-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240819065855.25678-1-pkshih@realtek.com>
References: <20240819065855.25678-1-pkshih@realtek.com>
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

When removing kernel modules by:
   rmmod rtw88_8723cs rtw88_8703b rtw88_8723x rtw88_sdio rtw88_core

Driver uses skb_queue_purge() to purge TX skb, but not report tx status
causing "Have pending ack frames!" warning. Use ieee80211_purge_tx_queue()
to correct this.

   wlan0: deauthenticating from aa:f5:fd:60:4c:a8 by local
     choice (Reason: 3=DEAUTH_LEAVING)
   ------------[ cut here ]------------
   Have pending ack frames!
   WARNING: CPU: 3 PID: 9232 at net/mac80211/main.c:1691
       ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
   CPU: 3 PID: 9232 Comm: rmmod Tainted: G         C
       6.10.1-200.fc40.aarch64 #1
   Hardware name: pine64 Pine64 PinePhone Braveheart
      (1.1)/Pine64 PinePhone Braveheart (1.1), BIOS 2024.01 01/01/2024
   pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
   pc : ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
   lr : ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
   sp : ffff80008c1b37b0
   x29: ffff80008c1b37b0 x28: ffff000003be8000 x27: 0000000000000000
   x26: 0000000000000000 x25: ffff000003dc14b8 x24: ffff80008c1b37d0
   x23: ffff000000ff9f80 x22: 0000000000000000 x21: 000000007fffffff
   x20: ffff80007c7e93d8 x19: ffff00006e66f400 x18: 0000000000000000
   x17: ffff7ffffd2b3000 x16: ffff800083fc0000 x15: 0000000000000000
   x14: 0000000000000000 x13: 2173656d61726620 x12: 6b636120676e6964
   x11: 0000000000000000 x10: 000000000000005d x9 : ffff8000802af2b0
   x8 : ffff80008c1b3430 x7 : 0000000000000001 x6 : 0000000000000001
   x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
   x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000003be8000
   Call trace:
    ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
    idr_for_each+0x74/0x110
    ieee80211_free_hw+0x44/0xe8 [mac80211]
    rtw_sdio_remove+0x9c/0xc0 [rtw88_sdio]
    sdio_bus_remove+0x44/0x180
    device_remove+0x54/0x90
    device_release_driver_internal+0x1d4/0x238
    driver_detach+0x54/0xc0
    bus_remove_driver+0x78/0x108
    driver_unregister+0x38/0x78
    sdio_unregister_driver+0x2c/0x40
    rtw_8723cs_driver_exit+0x18/0x1000 [rtw88_8723cs]
    __do_sys_delete_module.isra.0+0x190/0x338
    __arm64_sys_delete_module+0x1c/0x30
    invoke_syscall+0x74/0x100
    el0_svc_common.constprop.0+0x48/0xf0
    do_el0_svc+0x24/0x38
    el0_svc+0x3c/0x158
    el0t_64_sync_handler+0x120/0x138
    el0t_64_sync+0x194/0x198
   ---[ end trace 0000000000000000 ]---

Reported-by: Peter Robinson <pbrobinson@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/CALeDE9OAa56KMzgknaCD3quOgYuEHFx9_hcT=OFgmMAb+8MPyA@mail.gmail.com/
Tested-by: Peter Robinson <pbrobinson@gmail.com> # Pinephone
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 2 +-
 drivers/net/wireless/realtek/rtw88/usb.c  | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 21d0754dd7f6..949ea155dde8 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -1298,7 +1298,7 @@ static void rtw_sdio_deinit_tx(struct rtw_dev *rtwdev)
 	int i;
 
 	for (i = 0; i < RTK_MAX_TX_QUEUE_NUM; i++)
-		skb_queue_purge(&rtwsdio->tx_queue[i]);
+		ieee80211_purge_tx_queue(rtwdev->hw, &rtwsdio->tx_queue[i]);
 
 	flush_workqueue(rtwsdio->txwq);
 	destroy_workqueue(rtwsdio->txwq);
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index e83ab6fb83f5..e3a094b10753 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -423,10 +423,11 @@ static void rtw_usb_tx_handler(struct work_struct *work)
 
 static void rtw_usb_tx_queue_purge(struct rtw_usb *rtwusb)
 {
+	struct rtw_dev *rtwdev = rtwusb->rtwdev;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(rtwusb->tx_queue); i++)
-		skb_queue_purge(&rtwusb->tx_queue[i]);
+		ieee80211_purge_tx_queue(rtwdev->hw, &rtwusb->tx_queue[i]);
 }
 
 static void rtw_usb_write_port_complete(struct urb *urb)
-- 
2.25.1


