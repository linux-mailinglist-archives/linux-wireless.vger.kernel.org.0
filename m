Return-Path: <linux-wireless+bounces-24143-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D90AADAD50
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 12:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 274BE7A3DEC
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 10:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97702298CDE;
	Mon, 16 Jun 2025 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aladdin.ru header.i=@aladdin.ru header.b="jj971qK8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08E327FB34;
	Mon, 16 Jun 2025 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750069602; cv=none; b=JmWfbhldczNAzOTMaHwYbWBdIls/cDMSH6FDrfdfojc5gE4jkiHARMuVgd+AR8bp4WCl7A5DjXa7RoqrbHgZ68LWm1fTCNtwMl7Btne0RzMTwpuqW3RferAxuN6FgXCR/36nbIlm7uvNKjYvhXQo+bsNVlagD3biTRFc1Q/ASTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750069602; c=relaxed/simple;
	bh=tm0cg/s0vmolu2Kny17R4DVHWLwGluCROhsO6WcGzxs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXiqIAzzKjVd/L3eT16VatJVPVDm+of+xlTaI1QesoD7Jy9V8nydxHMv2CUXwpraGp/EG8r8aNhqkPK6rTH1lzJ/Xbd+L4sulXt4oUDx3ZmYnXEdtoH+J4e5NQjRFJ1UGRmAakbxJsTwPw+jMgchmKdoiidzOQWBVZATfPPsKhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; dkim=pass (2048-bit key) header.d=aladdin.ru header.i=@aladdin.ru header.b=jj971qK8; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
DKIM-Signature: v=1; a=rsa-sha256; d=aladdin.ru; s=mail; c=simple/simple;
	t=1750068666; h=from:subject:to:date:message-id;
	bh=tm0cg/s0vmolu2Kny17R4DVHWLwGluCROhsO6WcGzxs=;
	b=jj971qK8nnvu3Rqf/72J7oe78zpuJQ2P8XXHjPZMORAMqLvrY/dlcbHbx691rMzF7Z9uyBRUl5H
	Yypc/a+VkJRaUUKp7JTP9QVyj8c2Iv1Q5fztxHMW40a6frbTP3HVz9KwCw1ar4FSB2/ck6jDCZ/y/
	dbdhBBHBRwUl0vcwUjfU0+YSOeFIHJJHRGZB/upoDRdWX7S3l0fGylzTYf4M/e7rUYMeK96chHLVR
	RuD++KEMepmoHGcfUB2c+Hz7ivM/nlO+kQX543hqnQ14qjfKyqFGlbsX64lM4Y8mYmi2vmC8EhoGL
	NZolQzIEIMa14T/i3RDfllLtQ+QamqGEJswg==
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Hin-Tak Leung <hintak.leung@gmail.com>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Larry Finger
	<Larry.Finger@lwfinger.net>, "John W. Linville" <linville@tuxdriver.com>,
	<linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 1/2] rtl818x: Fix potential data race in rtl8187_tx_cb()
Date: Mon, 16 Jun 2025 13:10:49 +0300
Message-ID: <20250616101050.6911-2-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616101050.6911-1-d.dulov@aladdin.ru>
References: <20250616101050.6911-1-d.dulov@aladdin.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-03.aladdin.ru (192.168.1.103) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

There is a potential data race between rtl8187_tx_cb() and rtl8187_stop().
It is possible for rtl8187_stop() to clear the queue right after rtl8187_tx_cb()
checks that queue has more than 5 elements, but before it dequeues any skb.
This results in skb_dequeue() returns NULL and the pointer is dereferenced
in ieee80211_tx_status_irqsafe().

 BUG: kernel NULL pointer dereference, address: 0000000000000080
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] SMP NOPTI
 CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Not tainted 6.15.0 #8 PREEMPT(voluntary)
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
 RIP: 0010:ieee80211_tx_status_irqsafe+0x21/0xc0 [mac80211]
 Call Trace:
  <IRQ>
  rtl8187_tx_cb+0x116/0x150 [rtl8187]
  __usb_hcd_giveback_urb+0x9d/0x120
  usb_giveback_urb_bh+0xbb/0x140
  process_one_work+0x19b/0x3c0
  bh_worker+0x1a7/0x210
  tasklet_action+0x10/0x30
  handle_softirqs+0xf0/0x340
  __irq_exit_rcu+0xcd/0xf0
  common_interrupt+0x85/0xa0
  </IRQ>

In order to avoid potential data races and leading dereference of a NULL
pointer, acquire the queue lock before any work with the queue is done and
replace all skb_* calls with their lockless versions.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 3517afdefc3a ("rtl8187: feedback transmitted packets using tx close descriptor for 8187B")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 .../net/wireless/realtek/rtl818x/rtl8187/dev.c    | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
index 220ac5bdf279..8fe6fdc32e56 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
@@ -189,6 +189,7 @@ static void rtl8187_tx_cb(struct urb *urb)
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hw *hw = info->rate_driver_data[0];
 	struct rtl8187_priv *priv = hw->priv;
+	unsigned long flags;
 
 	skb_pull(skb, priv->is_rtl8187b ? sizeof(struct rtl8187b_tx_hdr) :
 					  sizeof(struct rtl8187_tx_hdr));
@@ -196,7 +197,8 @@ static void rtl8187_tx_cb(struct urb *urb)
 
 	if (!(urb->status) && !(info->flags & IEEE80211_TX_CTL_NO_ACK)) {
 		if (priv->is_rtl8187b) {
-			skb_queue_tail(&priv->b_tx_status.queue, skb);
+			spin_lock_irqsave(&priv->b_tx_status.queue.lock, flags);
+			__skb_queue_tail(&priv->b_tx_status.queue, skb);
 
 			/* queue is "full", discard last items */
 			while (skb_queue_len(&priv->b_tx_status.queue) > 5) {
@@ -205,9 +207,11 @@ static void rtl8187_tx_cb(struct urb *urb)
 				dev_dbg(&priv->udev->dev,
 					"transmit status queue full\n");
 
-				old_skb = skb_dequeue(&priv->b_tx_status.queue);
+				old_skb = __skb_dequeue(&priv->b_tx_status.queue);
 				ieee80211_tx_status_irqsafe(hw, old_skb);
 			}
+
+			spin_unlock_irqrestore(&priv->b_tx_status.queue.lock, flags);
 			return;
 		} else {
 			info->flags |= IEEE80211_TX_STAT_ACK;
@@ -893,6 +897,7 @@ static void rtl8187_work(struct work_struct *work)
 				    work.work);
 	struct ieee80211_tx_info *info;
 	struct ieee80211_hw *dev = priv->dev;
+	unsigned long flags;
 	static u16 retry;
 	u16 tmp;
 	u16 avg_retry;
@@ -900,6 +905,8 @@ static void rtl8187_work(struct work_struct *work)
 
 	mutex_lock(&priv->conf_mutex);
 	tmp = rtl818x_ioread16(priv, (__le16 *)0xFFFA);
+
+	spin_lock_irqsave(&priv->b_tx_status.queue.lock, flags);
 	length = skb_queue_len(&priv->b_tx_status.queue);
 	if (unlikely(!length))
 		length = 1;
@@ -909,13 +916,15 @@ static void rtl8187_work(struct work_struct *work)
 	while (skb_queue_len(&priv->b_tx_status.queue) > 0) {
 		struct sk_buff *old_skb;
 
-		old_skb = skb_dequeue(&priv->b_tx_status.queue);
+		old_skb = __skb_dequeue(&priv->b_tx_status.queue);
 		info = IEEE80211_SKB_CB(old_skb);
 		info->status.rates[0].count = avg_retry + 1;
 		if (info->status.rates[0].count > RETRY_COUNT)
 			info->flags &= ~IEEE80211_TX_STAT_ACK;
 		ieee80211_tx_status_irqsafe(dev, old_skb);
 	}
+	spin_unlock_irqrestore(&priv->b_tx_status.queue.lock, flags);
+
 	retry = tmp;
 	mutex_unlock(&priv->conf_mutex);
 }
-- 
2.34.1


