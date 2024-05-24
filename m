Return-Path: <linux-wireless+bounces-8032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C69868CDEEC
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 02:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8282F280C90
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 00:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDA97FB;
	Fri, 24 May 2024 00:33:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B3D36D
	for <linux-wireless@vger.kernel.org>; Fri, 24 May 2024 00:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716510797; cv=none; b=qEHIpnfSpBX1LLYJE1POvvn6ZF2migYr1rKJuOZSUN2p2LgxgVQVqx2C/5NihLFa10juNb9cLcrM9C6kD7KXGShKpLc7f6MNYsnm45lYXXsX00Btf2riRxPFWAf8f0Ym5EMfcBQWB4VHdJBpJN6wQZq2/6wIyWbtml7bt5AYSTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716510797; c=relaxed/simple;
	bh=Jl5epB1Wdlod8bi2OgdJhUys1RzoPDcaC4Nu0H0sVao=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j8xVFhdai1t3I3I1dn+ybBT5OjnZEpxxXjMtRCt/3FKKGnu62LPR7qm3ComNW7kADBGyFD6ujlbOOzWD5DWhbEr6CW1nwpnmtEd2mei5S7jnm5e0F7noSbrGyoh3pARN/FR694o0UPFDtxvlSh/6Hj21Ud1LzLR9kqPJBOsIpyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44O0X9Ul81487015, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44O0X9Ul81487015
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 08:33:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 08:33:10 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 24 May
 2024 08:33:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <shichaorai@gmail.com>
Subject: [PATCH] wifi: rtlwifi: handle return value of usb init TX/RX
Date: Fri, 24 May 2024 08:32:48 +0800
Message-ID: <20240524003248.5952-1-pkshih@realtek.com>
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
---
 drivers/net/wireless/realtek/rtlwifi/usb.c | 34 +++++++++++++++++-----
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 2ea72d9e3957..4d2931e54427 100644
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
2.25.1


