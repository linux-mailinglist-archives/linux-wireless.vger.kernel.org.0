Return-Path: <linux-wireless+bounces-5971-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF6C89BEB5
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 14:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA02E2838B4
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 12:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69C63BBD8;
	Mon,  8 Apr 2024 12:14:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D1E6A347;
	Mon,  8 Apr 2024 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578477; cv=none; b=LmBccGZ29rE6PA0HexL2dLyontfqF2g4NUcSVtutXyjQCqHvQc+dx3iphGkOpeyYLGtxvNbrpyp7VoIqj4vYkJVGJqGiRAOsr1ga7QX915Tf0oniS+RdbVS27EzFNn+/yQ3cYcMi0ri+ffvBL237K6cWVKybxtFDYQPNEZ7uJ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578477; c=relaxed/simple;
	bh=qgZsHg6eDtT2YJiUeBg3UDqbrXbnKl+EsVP7WJDqH50=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tvSPXA4n+KxM9c8/fdrbc6uYwEl2H4z/x2slMMV+2TWvESf8aNMnKkd0aL3mutBA8EVbj6lijLdgbZhg5mu3t88ddR6CS1c+MGSxc3VjiaNSfsWdksHh9B3+pUATY/ILhOxzqjPRv6TY0LPtEJBG4toLJIFvRTVm2sA/A/SdXkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 8 Apr
 2024 15:14:29 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 8 Apr 2024
 15:14:29 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Kalle Valo <kvalo@kernel.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Wu Yunchuan
	<yunchuan@nfschina.com>, Johannes Berg <johannes.berg@intel.com>, "Breno
 Leitao" <leitao@debian.org>, <linux-wireless@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com>
Subject: [PATCH v2] wifi: ar5523: enable proper endpoint verification
Date: Mon, 8 Apr 2024 05:14:25 -0700
Message-ID: <20240408121425.29392-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Syzkaller reports [1] hitting a warning about an endpoint in use
not having an expected type to it.

Fix the issue by checking for the existence of all proper
endpoints with their according types intact.

Sadly, this patch has not been tested on real hardware.

[1] Syzkaller report:
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 3 != type 1
WARNING: CPU: 0 PID: 3643 at drivers/usb/core/urb.c:504 usb_submit_urb+0xed6/0x1880 drivers/usb/core/urb.c:504
...
Call Trace:
 <TASK>
 ar5523_cmd+0x41b/0x780 drivers/net/wireless/ath/ar5523/ar5523.c:275
 ar5523_cmd_read drivers/net/wireless/ath/ar5523/ar5523.c:302 [inline]
 ar5523_host_available drivers/net/wireless/ath/ar5523/ar5523.c:1376 [inline]
 ar5523_probe+0x14b0/0x1d10 drivers/net/wireless/ath/ar5523/ar5523.c:1655
 usb_probe_interface+0x30f/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:560 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:639
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:936
 bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:427
 __device_attach+0x1e4/0x530 drivers/base/dd.c:1008
 bus_probe_device+0x1e8/0x2a0 drivers/base/bus.c:487
 device_add+0xbd9/0x1e90 drivers/base/core.c:3517
 usb_set_configuration+0x101d/0x1900 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xbe/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd8/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:560 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:639
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:936
 bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:427
 __device_attach+0x1e4/0x530 drivers/base/dd.c:1008
 bus_probe_device+0x1e8/0x2a0 drivers/base/bus.c:487
 device_add+0xbd9/0x1e90 drivers/base/core.c:3517
 usb_new_device.cold+0x685/0x10ad drivers/usb/core/hub.c:2573
 hub_port_connect drivers/usb/core/hub.c:5353 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5653 [inline]
 hub_event+0x26cb/0x45d0 drivers/usb/core/hub.c:5735
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Reported-and-tested-by: syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com
Fixes: b7d572e1871d ("ar5523: Add new driver")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
v2: added 'const' qualifier to bulk_ep_addr[] per Jeff Johnson's
helpful suggestion.

 drivers/net/wireless/ath/ar5523/ar5523.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
index 815f8f599f5d..5a55db349cb5 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -1594,6 +1594,20 @@ static int ar5523_probe(struct usb_interface *intf,
 	struct ar5523 *ar;
 	int error = -ENOMEM;
 
+	static const u8 bulk_ep_addr[] = {
+		AR5523_CMD_TX_PIPE | USB_DIR_OUT,
+		AR5523_DATA_TX_PIPE | USB_DIR_OUT,
+		AR5523_CMD_RX_PIPE | USB_DIR_IN,
+		AR5523_DATA_RX_PIPE | USB_DIR_IN,
+		0};
+
+	if (!usb_check_bulk_endpoints(intf, bulk_ep_addr)) {
+		dev_err(&dev->dev,
+			"Could not find all expected endpoints\n");
+		error = -ENODEV;
+		goto out;
+	}
+
 	/*
 	 * Load firmware if the device requires it.  This will return
 	 * -ENXIO on success and we'll get called back afer the usb

