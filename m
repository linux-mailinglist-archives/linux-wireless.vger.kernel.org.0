Return-Path: <linux-wireless+bounces-10568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F7D93E270
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 03:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4AB81F219ED
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 01:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38273B665;
	Sun, 28 Jul 2024 00:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXQnyAmT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB01548F7;
	Sun, 28 Jul 2024 00:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128018; cv=none; b=lXj0dzWystPv80zxgWVD20v0JnPm3tIuNS1CWt3u25M6hzaUK8cGzxT1WQKs0erFlCLtqhzo/sscnx8QmpQlKvelAy9nz33FA2tBGSsN1JfcijfgsZjklFoEGhv1xH7TcpemQPjA1J1eCkYxTabuCA6uBygapCRlYrWVgGRdWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128018; c=relaxed/simple;
	bh=8pdPmDc7A9V3JVnmqFMglg/ubX4as4zK0LS2cchC1JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDbDMOCdAU48H98Z2euh5E0wgANb2+neH8n8pcwDyh8h8NpQf1MMWcy9MsxqXgnsLcp43abE2PX0XEBvGZ0YnPdW3lDJjIrgNNzUX/UGyyOp2NXgLNGvXMPNIA8YKdMNXrrZhtIwk4aVob6MKLnAUXVq42sMxWKGvcXCyPQKq2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXQnyAmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA466C4AF11;
	Sun, 28 Jul 2024 00:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128017;
	bh=8pdPmDc7A9V3JVnmqFMglg/ubX4as4zK0LS2cchC1JA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TXQnyAmTTdzQ406TACxIv6XCPc7e7zPXpfyTwkPfeJ2cjvzfQO60HmecRqXKeT20o
	 udqEozBCNRiZN9XnjN4Y3ImLCEr42fg09sBR0inHw66sEMSM/2SGniN99OLUgzXCen
	 gqLr0zQtYC1XVUeqQTSIjrG8TAsK3vH0sxvp5zs5769w/CP2LTYLj1yf1t+9KSb1wA
	 hkI6nG4ScaCuHMPUpjxIkVGaIbBo47Wcl/zQRixzkcUgiYIB7S0XLE9fZhYQU4ccb0
	 mbMsW7udd/t/0aED6BhBBS0Z6h74W1g89W/Aa7dCklfz/3UQONDsNXZ2ElsPqh4ScU
	 p5Nvs6HMM3BFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Shichao Lai <shichaorai@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 04/27] wifi: rtlwifi: handle return value of usb init TX/RX
Date: Sat, 27 Jul 2024 20:52:47 -0400
Message-ID: <20240728005329.1723272-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005329.1723272-1-sashal@kernel.org>
References: <20240728005329.1723272-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 9c4fde42cce05719120cf892a44b76ff61d908c7 ]

Handle error code to cause failed to USB probe result from unexpected
USB EP number, otherwise when USB disconnect skb_dequeue() an uninitialized
skb list and cause warnings below.

usb 2-1: USB disconnect, device number 76
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 54060 Comm: kworker/0:1 Not tainted 6.9.0-rc7 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:114
 assign_lock_key kernel/locking/lockdep.c:976 [inline]
 register_lock_class+0xc18/0xfa0 kernel/locking/lockdep.c:1289
 __lock_acquire+0x108/0x3bc0 kernel/locking/lockdep.c:5014
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b0/0x550 kernel/locking/lockdep.c:5719
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
 skb_dequeue+0x20/0x180 net/core/skbuff.c:3846
 rtl_usb_cleanup drivers/net/wireless/realtek/rtlwifi/usb.c:706 [inline]
 rtl_usb_deinit drivers/net/wireless/realtek/rtlwifi/usb.c:721 [inline]
 rtl_usb_disconnect+0x4a4/0x850 drivers/net/wireless/realtek/rtlwifi/usb.c:1051
 usb_unbind_interface+0x1e8/0x980 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:568 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:560
 __device_release_driver drivers/base/dd.c:1270 [inline]
 device_release_driver_internal+0x443/0x620 drivers/base/dd.c:1293
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:574
 device_del+0x395/0x9f0 drivers/base/core.c:3909
 usb_disable_device+0x360/0x7b0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2db/0x930 drivers/usb/core/hub.c:2305
 hub_port_connect drivers/usb/core/hub.c:5362 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5662 [inline]
 port_event drivers/usb/core/hub.c:5822 [inline]
 hub_event+0x1e39/0x4ce0 drivers/usb/core/hub.c:5904
 process_one_work+0x97b/0x1a90 kernel/workqueue.c:3267
 process_scheduled_works kernel/workqueue.c:3348 [inline]
 worker_thread+0x680/0xf00 kernel/workqueue.c:3429
 kthread+0x2c7/0x3b0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Reported-by: Shichao Lai <shichaorai@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/CAEk6kZuuezkH1dVRJf3EAVZK-83=OpTz62qCugkpTkswj8JF6w@mail.gmail.com/T/#u
Tested-by: Shichao Lai <shichaorai@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://msgid.link/20240524003248.5952-1-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtlwifi/usb.c | 34 +++++++++++++++++-----
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 2ea72d9e39577..4d2931e544278 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -23,6 +23,8 @@ MODULE_DESCRIPTION("USB basic driver for rtlwifi");
 
 #define MAX_USBCTRL_VENDORREQ_TIMES		10
 
+static void _rtl_usb_cleanup_tx(struct ieee80211_hw *hw);
+
 static void _usbctrl_vendorreq_sync(struct usb_device *udev, u8 reqtype,
 				   u16 value, void *pdata, u16 len)
 {
@@ -285,9 +287,23 @@ static int _rtl_usb_init(struct ieee80211_hw *hw)
 	}
 	/* usb endpoint mapping */
 	err = rtlpriv->cfg->usb_interface_cfg->usb_endpoint_mapping(hw);
-	rtlusb->usb_mq_to_hwq =  rtlpriv->cfg->usb_interface_cfg->usb_mq_to_hwq;
-	_rtl_usb_init_tx(hw);
-	_rtl_usb_init_rx(hw);
+	if (err)
+		return err;
+
+	rtlusb->usb_mq_to_hwq = rtlpriv->cfg->usb_interface_cfg->usb_mq_to_hwq;
+
+	err = _rtl_usb_init_tx(hw);
+	if (err)
+		return err;
+
+	err = _rtl_usb_init_rx(hw);
+	if (err)
+		goto err_out;
+
+	return 0;
+
+err_out:
+	_rtl_usb_cleanup_tx(hw);
 	return err;
 }
 
@@ -691,17 +707,13 @@ static int rtl_usb_start(struct ieee80211_hw *hw)
 }
 
 /*=======================  tx =========================================*/
-static void rtl_usb_cleanup(struct ieee80211_hw *hw)
+static void _rtl_usb_cleanup_tx(struct ieee80211_hw *hw)
 {
 	u32 i;
 	struct sk_buff *_skb;
 	struct rtl_usb *rtlusb = rtl_usbdev(rtl_usbpriv(hw));
 	struct ieee80211_tx_info *txinfo;
 
-	/* clean up rx stuff. */
-	_rtl_usb_cleanup_rx(hw);
-
-	/* clean up tx stuff */
 	for (i = 0; i < RTL_USB_MAX_EP_NUM; i++) {
 		while ((_skb = skb_dequeue(&rtlusb->tx_skb_queue[i]))) {
 			rtlusb->usb_tx_cleanup(hw, _skb);
@@ -715,6 +727,12 @@ static void rtl_usb_cleanup(struct ieee80211_hw *hw)
 	usb_kill_anchored_urbs(&rtlusb->tx_submitted);
 }
 
+static void rtl_usb_cleanup(struct ieee80211_hw *hw)
+{
+	_rtl_usb_cleanup_rx(hw);
+	_rtl_usb_cleanup_tx(hw);
+}
+
 /* We may add some struct into struct rtl_usb later. Do deinit here.  */
 static void rtl_usb_deinit(struct ieee80211_hw *hw)
 {
-- 
2.43.0


