Return-Path: <linux-wireless+bounces-15621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFC99D707D
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 14:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B3D163276
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 13:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFC9192D64;
	Sun, 24 Nov 2024 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqAO+hjN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3098192D61;
	Sun, 24 Nov 2024 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455197; cv=none; b=rJzFzakN3JA+z6a8N/Sn1dVbFkx3pRlaabar8Yt0Y2j9BPaWCkHBYatqzPxRH9WBglgaFQ0LCkqKwshtTXK3axU6xi4tEE22TG+kUrK0lHMH+RN+XWkBbOHi5buXR0J/K8UX0X/F22GszYh4FcZ6wjILASydcxqUFxPM3F/8ngw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455197; c=relaxed/simple;
	bh=fXjFAP9o3L9NJQ4trWUYtBcHl9hlse8x8GuECP8pCMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owcEHjRoTG+NUMhWPUIR407Isl641UjO83EIVMCCnvw8ntj4dQnTua3u3y6o5eB+4WkiY0RIsdt0B1+HX2FZo3K/wpHytbxr+SM2lVsq+3d9BzEOw/cHNBpMEqkoA+cp+9C2Rf/oI3B2lqFuErPwBywQeT42ATx9/+HRCYK4moI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqAO+hjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7C6C4CED7;
	Sun, 24 Nov 2024 13:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455195;
	bh=fXjFAP9o3L9NJQ4trWUYtBcHl9hlse8x8GuECP8pCMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mqAO+hjNGSdqGv5ojSfd3kz3L3az3dDz/avbwqgUpCdQuWFdocPR2vITCt0RiJR1F
	 u2F10Xwd5uw1u2YhbDMsuKa94rtun+dPizDoUsW0UYoG2Jdb4aMxZZ3eBDUzLNv9gR
	 Vmro549Pp7z0/++vHoaArID7S7dSIaxvTkWvgIxvplL7Kz81t+RpYVEbmhAS87Ox1N
	 T7c4jdvRrVKyctawii2LHAlxuEGMVKbgZI04GKkTmfvJH1tYfeDq5P/WAbNfalqq33
	 2+NO6UqELzAtR6wR1+fb+pExX4eKjRHjV35/eLfRQ9oiwiIUbDPnjf9HSGb/pazyvK
	 OXLGwabafVEcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 007/107] wifi: rtw88: use ieee80211_purge_tx_queue() to purge TX skb
Date: Sun, 24 Nov 2024 08:28:27 -0500
Message-ID: <20241124133301.3341829-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 3e5e4a801aaf4283390cc34959c6c48f910ca5ea ]

When removing kernel modules by:
   rmmod rtw88_8723cs rtw88_8703b rtw88_8723x rtw88_sdio rtw88_core

Driver uses skb_queue_purge() to purge TX skb, but not report tx status
causing "Have pending ack frames!" warning. Use ieee80211_purge_tx_queue()
to correct this.

Since ieee80211_purge_tx_queue() doesn't take locks, to prevent racing
between TX work and purge TX queue, flush and destroy TX work in advance.

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
Tested-by: Ping-Ke Shih <pkshih@realtek.com> # 8723DU
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20240822014255.10211-2-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 6 +++---
 drivers/net/wireless/realtek/rtw88/usb.c  | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 21d0754dd7f6a..b67e551fcee3e 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -1297,12 +1297,12 @@ static void rtw_sdio_deinit_tx(struct rtw_dev *rtwdev)
 	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
 	int i;
 
-	for (i = 0; i < RTK_MAX_TX_QUEUE_NUM; i++)
-		skb_queue_purge(&rtwsdio->tx_queue[i]);
-
 	flush_workqueue(rtwsdio->txwq);
 	destroy_workqueue(rtwsdio->txwq);
 	kfree(rtwsdio->tx_handler_data);
+
+	for (i = 0; i < RTK_MAX_TX_QUEUE_NUM; i++)
+		ieee80211_purge_tx_queue(rtwdev->hw, &rtwsdio->tx_queue[i]);
 }
 
 int rtw_sdio_probe(struct sdio_func *sdio_func,
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index b17a429bcd299..07695294767ac 100644
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
@@ -888,9 +889,9 @@ static void rtw_usb_deinit_tx(struct rtw_dev *rtwdev)
 {
 	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
 
-	rtw_usb_tx_queue_purge(rtwusb);
 	flush_workqueue(rtwusb->txwq);
 	destroy_workqueue(rtwusb->txwq);
+	rtw_usb_tx_queue_purge(rtwusb);
 }
 
 static int rtw_usb_intf_init(struct rtw_dev *rtwdev,
-- 
2.43.0


