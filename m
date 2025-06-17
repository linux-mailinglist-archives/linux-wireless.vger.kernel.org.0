Return-Path: <linux-wireless+bounces-24219-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E510FADCE6F
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 15:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A168A1887DD0
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 13:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3095A2E265D;
	Tue, 17 Jun 2025 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aladdin.ru header.i=@aladdin.ru header.b="EZBPgu0+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CD62DE20F;
	Tue, 17 Jun 2025 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750168641; cv=none; b=pCV6Jxgf1hpY5Olc+SyCdlQ/VdR3EIdIwN0OLwWvuhvHASbDhZMgHfdqFbs6Jse9YmE2xJgMrhF8lZzRCkfJzDCF5fUi1dlJFxmW/Q/aRfWK52gaY7u+CUL63FnccbmPALP75eCDhmbesHBQWpK6TUGHnA4xjOgrVLtodfjZRcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750168641; c=relaxed/simple;
	bh=k9v+mhlnLVnU1GF8Pm1ZEjsgwL3Z/jsaM86/lu0/bQM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UhM78LfbJL8OYVeR2fR6nnf+ryalgZwjPi8EcCu88ZzwDKpZR95vQVujqAELbL3JwZuHyu23gHBunSNmcnp0sxfjil+nJTwhcyLN8K6UiUE1mcDeXP7a2tQ3m2S7eUxMcwWWejSetKbpP90tKRZmVQbZ6cdFew+GrCVdZ5Va3L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; dkim=pass (2048-bit key) header.d=aladdin.ru header.i=@aladdin.ru header.b=EZBPgu0+; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
DKIM-Signature: v=1; a=rsa-sha256; d=aladdin.ru; s=mail; c=simple/simple;
	t=1750168615; h=from:subject:to:date:message-id;
	bh=k9v+mhlnLVnU1GF8Pm1ZEjsgwL3Z/jsaM86/lu0/bQM=;
	b=EZBPgu0+VdrozN2LpNsfq2gHJNFUH2BvvD80figcSrR202xv+zA0D+vlym0EDsmy54P6o3eSoTp
	XuOBGFm8GNSK79Wxb1tDVJixt6Yoz48lrb02m6jxfx7iHif0GdFSRC0uJcwhRB9Sla6/FKkHWuRfU
	rte5Qt0l9Z1g5CsTUQQLl/P+DNyVKCCWAqrBFrSt4VH4lAdwNec2yeGJ9pSSpvPv5Nst4WFdcWbaX
	aCkZT4qburcxAnv7m1iSq3qkm/ftoWdx88QX2K+2pa7vlwhaBn2ZKzT1jcKbnzuQFM1qalFnIceCX
	hkuOrExt5CdZWtmzwqmP2nG23hP7SrDT3dLw==
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Hin-Tak Leung <hintak.leung@gmail.com>,
	Larry Finger <Larry.Finger@lwfinger.net>, "John W. Linville"
	<linville@tuxdriver.com>, <linux-wireless@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2] rtl818x: Kill URBs before clearing tx status queue
Date: Tue, 17 Jun 2025 16:56:34 +0300
Message-ID: <20250617135634.21760-1-d.dulov@aladdin.ru>
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

In rtl8187_stop() move the call of usb_kill_anchored_urbs() before clearing
b_tx_status.queue. This change prevents callbacks from using already freed
skb due to anchor was not killed before freeing such skb.

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

Tested on RTL8187BvE device.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c1db52b9d27e ("rtl8187: Use usb anchor facilities to manage urbs")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
index 220ac5bdf279..8a57d6c72335 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
@@ -1041,10 +1041,11 @@ static void rtl8187_stop(struct ieee80211_hw *dev, bool suspend)
 	rtl818x_iowrite8(priv, &priv->map->CONFIG4, reg | RTL818X_CONFIG4_VCOOFF);
 	rtl818x_iowrite8(priv, &priv->map->EEPROM_CMD, RTL818X_EEPROM_CMD_NORMAL);
 
+	usb_kill_anchored_urbs(&priv->anchored);
+
 	while ((skb = skb_dequeue(&priv->b_tx_status.queue)))
 		dev_kfree_skb_any(skb);
 
-	usb_kill_anchored_urbs(&priv->anchored);
 	mutex_unlock(&priv->conf_mutex);
 
 	if (!priv->is_rtl8187b)
-- 
2.34.1


