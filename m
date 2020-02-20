Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFE0165ED7
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2020 14:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgBTNcB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Feb 2020 08:32:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbgBTNcB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Feb 2020 08:32:01 -0500
Received: from localhost.localdomain (unknown [151.48.137.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A20FF206E2;
        Thu, 20 Feb 2020 13:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582205520;
        bh=p3779NFQbJ5IeaDqGaAZYI8EXDFcNZzvXvtP1m8rAKs=;
        h=From:To:Cc:Subject:Date:From;
        b=P7LKNSKsZME4V0zve8aSoetlgUOVu2d70fGnz5do6FIozvbRrmEzto9k1IDCvtA/Z
         Dm3e0QpLusOdl4vJ7lz+V3QWJrE9fPj8lGCUtJ5Dr0dU6RF4e9QaPfEfk/+dKRxc/v
         ojObJ/zPnekGyVAL2QtbJgqWdg4kW9oQrzkojxr0=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        stf_xl@wp.pl
Subject: [PATCH] mt76: mt76u: rely only on data buffer for usb control messagges
Date:   Thu, 20 Feb 2020 14:31:51 +0100
Message-Id: <bfe28ce082e6d97f6785d9ecbb93952431e3db9e.1582205223.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Starting from commit 'a6bfb6d13f33 ("mt76: usb: use max packet length
for m76u_copy")' reg_val does not share memory with usb data buffer.
On non-coherent devices this approach can corrupt data pointer since data
and reg_val share the same cache-line, resulting in the following crash:

[  371.544901] CPU 0 Unable to handle kernel paging request at virtual address 00000000, epc == 8042fbb0
[  371.558521] CPU: 0 PID: 11 Comm: kworker/u2:2 Not tainted 4.14.160 #0
[  371.565204] Workqueue: mt76u mt76u_deinit [mt76_usb]
[  371.570331] task: 83823ac0 task.stack: 8386c000
[  371.575004] $ 0   : 00000000 80590000 00000000 00000000
[  371.580407] $ 4   : 82edaad0 00000002 83823ac0 fffffff8
[  371.585810] $ 8   : fffffffd 0000fc00 8052da00 00000000
[  371.591212] $12   : 000b2285 ae53a1a9 00108845 89da44c4
[  371.596615] $16   : 82edaad0 82ed9d20 00001798 832edf00
[  371.602019] $20   : 00000000 8386dda8 80530000 fffffffe
[  371.607421] $24   : 8051d040 76274d1b
[  371.612824] $28   : 8386c000 8386dd88 82edaad4 830d4d50
[  371.618228] Hi    : 000000f7
[  371.621203] Lo    : 33333371
[  371.624196] epc   : 8042fbb0 __mutex_lock.isra.2+0x134/0x378
[  371.630043] ra    : 830d4d50 mt76u_deinit+0x418/0xa6c [mt76_usb]
[  371.636237] Status: 1000fc03KERNEL EXL IE
[  371.640557] Cause : 0080000c (ExcCode 03)
[  371.644696] BadVA : 00000000
[  371.647671] PrId  : 00019374 (MIPS 24Kc)
[  371.726123]  usbcore nls_base usb_common
[  371.730180] Process kworker/u2:2 (pid: 11, threadinfo=8386c000, task=83823ac0, tls=00000000)
[  371.738884] Stack : 833d009c 83210b4c 82ed8bc0 8386ddac 000001ff 8008ac50 8386ddac 83b74b00
[  371.747519]         82edaad4 00000000 83b74b48 83210c38 82edaad0 82ed9d20 00001798 832edf00
[  371.756157]         00000000 00000000 80530000 fffffffe 80530000 830d4d50 00000040 8389d850
[  371.764794]         8052d9d8 8389d850 8386de30 82ed9d20 8386de5f 831c27bc 833d48ec 8052d9d8
[  371.773431]         83823ac0 83823af0 82edab00 82ed9d20 8386de5f 831c5c30 00000000 8052d9a8
[  371.782069]         ...
[  371.784598] Call Trace:
[  371.787130] [<8042fbb0>] __mutex_lock.isra.2+0x134/0x378
[  371.792622] [<830d4d50>] mt76u_deinit+0x418/0xa6c [mt76_usb]
[  371.808546]
[  371.810920] ---[ end trace c62f0601f6730eb0 ]---
[  371.818101] Kernel panic - not syncing: Fatal exception
[  371.824420] Rebooting in 3 seconds..

Fix the issue relying only on data buffer to send/receive usb control messages

Fixes: a6bfb6d13f33 ("mt76: usb: use max packet length for m76u_copy")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 1 -
 drivers/net/wireless/mediatek/mt76/usb.c  | 8 ++++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 2e57e7c6bd29..aca477434858 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -403,7 +403,6 @@ struct mt76_mcu {
 #define MCU_RESP_URB_SIZE	1024
 struct mt76_usb {
 	struct mutex usb_ctrl_mtx;
-	__le32 reg_val;
 	u8 *data;
 	u16 data_len;
 
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 2c0dbc36f9aa..3535577db1c6 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -70,10 +70,10 @@ static u32 ___mt76u_rr(struct mt76_dev *dev, u8 req, u32 addr)
 
 	ret = __mt76u_vendor_request(dev, req,
 				     USB_DIR_IN | USB_TYPE_VENDOR,
-				     addr >> 16, addr, &usb->reg_val,
+				     addr >> 16, addr, usb->data,
 				     sizeof(__le32));
 	if (ret == sizeof(__le32))
-		data = le32_to_cpu(usb->reg_val);
+		data = get_unaligned_le32(usb->data);
 	trace_usb_reg_rr(dev, addr, data);
 
 	return data;
@@ -125,10 +125,10 @@ static void ___mt76u_wr(struct mt76_dev *dev, u8 req,
 {
 	struct mt76_usb *usb = &dev->usb;
 
-	usb->reg_val = cpu_to_le32(val);
+	put_unaligned_le32(val, usb->data);
 	__mt76u_vendor_request(dev, req,
 			       USB_DIR_OUT | USB_TYPE_VENDOR,
-			       addr >> 16, addr, &usb->reg_val,
+			       addr >> 16, addr, usb->data,
 			       sizeof(__le32));
 	trace_usb_reg_wr(dev, addr, val);
 }
-- 
2.24.1

