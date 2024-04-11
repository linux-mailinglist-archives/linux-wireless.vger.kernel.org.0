Return-Path: <linux-wireless+bounces-6136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B39818A0580
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 03:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B0F1F22C2F
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 01:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7417679E2;
	Thu, 11 Apr 2024 01:28:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from pv237.mxout.mta2.net (pv237.mxout.mta2.net [178.33.242.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250ED657C6
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.242.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712798886; cv=none; b=d1UYrajxb17hdlGxBI5R48MfYX1jkeEauEFgWOxTkchkCMKiHV4UjkDv12E+GYaA9WslcMrYV3oxOK8slrHJMbpFoKShH9OY7WoAF/0OMfdXRySVpqpyCWttIT8n9BCg6H05qZXAp8hdedT1GKCDKcGfPSvMSJqqAKh3eljmsW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712798886; c=relaxed/simple;
	bh=EXDdSD9Uf0lflZMxVYblJkIy+5X74ZdTgv+ooU7jtcU=;
	h=From:Date:Subject:Message-Id:To:Cc:MIME-Version:Content-Type; b=I0z7GA6Tkx4TeYEEj4H2km1zU4unAUGZOPOuUny7OAwRPYqYDsH4flPFK5136dKkICrVRlCtdvbjG3zKR0xzm93CSg0RjvzzVpmId1ED3w3o77o18Iw0Fp0BTddDWJu5jXKgsftjOnyrh2XVA03/eolHNqh1tWtZE5AtWTwvluw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=bounces.elasticemail.net; arc=none smtp.client-ip=178.33.242.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounces.elasticemail.net
From: Larry Finger <Larry.Finger@gmail.com>
Date: Thu, 11 Apr 2024 01:26:55 +0000
Subject: [RFC] rtw88: Fix startup problems for SDIO wifi plus UART Bluetooth
Message-Id: <4umro86wvv84.MjDfYvt4P5uZryt8boBK8Q2@1EHFQ.trk.elasticemail.com>
Reply-To: Larry Finger <Larry.Finger@gmail.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org,
 Larry Finger <Larry.Finger@gmail.com>, stable@vger.kernel.org
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-Msg-EID: MjDfYvt4P5uZryt8boBK8Q2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

As discussed in the links below, the SDIO part of RTW8821CS fails to
start correctly if such startup happens while the UART portion of
the chip is initializing. The logged results with such failure is

[   10.230516] rtw_8821cs mmc3:0001:1: Start of rtw_sdio_probe
[   10.306569] Bluetooth: HCI UART driver ver 2.3
[   10.306717] Bluetooth: HCI UART protocol Three-wire (H5) registered
[   10.307167] of_dma_request_slave_channel: dma-names property of node '/serial@fe650000' missing or empty
[   10.307199] dw-apb-uart fe650000.serial: failed to request DMA
[   10.543474] rtw_8821cs mmc3:0001:1: Firmware version 24.8.0, H2C version 12
[   10.730744] rtw_8821cs mmc3:0001:1: sdio read32 failed (0x11080): -110
[   10.730923] rtw_8821cs mmc3:0001:1: sdio write32 failed (0x11080): -110

Due to the above errors, wifi fails to work.

For those instances when wifi works, the following is logged:

[   10.452861] Bluetooth: HCI UART protocol Three-wire (H5) registered
[   10.453580] of_dma_request_slave_channel: dma-names property of node '/serial@fe650000' missing or empty
[   10.453621] dw-apb-uart fe650000.serial: failed to request DMA
[   10.455741] rtw_8821cs mmc3:0001:1: Start of rtw_sdio_probe
[   10.639186] rtw_8821cs mmc3:0001:1: Firmware version 24.8.0, H2C version 12

In this case, SDIO wifi works correctly. The correct case is ensured by
adding an mdelay(500) statement before the call to rtw_core_init(). No
adverse effects are observed.

Link: https://1EHFQ.trk.elasticemail.com/tracking/click?d=1UfsVowwwMAM6kBoyumkHP3o7pYa4kGXhuklYI-QPLuVUi2ohkUG8HssjZcN67C_2TySHAezxTUVFT_8wvKkE9xqzm8H8qwhbclOJ9HB0cExNK65eHoXK4LaCW3PT7iyvMI3d6qqwN6PHhYj2GEblxeP4xr4CJPwZE7lyMCRTuxZ0
Link: https://1EHFQ.trk.elasticemail.com/tracking/click?d=XUEf4t8W9xt0czASPOeeDt8BnPqLK_YeGMMwadyXNu17p5TeSDk6RmEZ25rBt0-C5d-GR5IlKqu5URoKaespUAOAffgoysVTLbvgzQoAO57Ix1ChR-fYsf2VGRa1vIR9iWmNK1bUBvdHTZb0StprYVFMTYNi3fpihu3YoQYbaiZsYjqFovexmfiXfyHM3S00rqaJrXQwoylF4bELv8WaAC-QQM6OuDzE6rb32eW83smj0
Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
Signed-off-by: Larry Finger <Larry.Finger@gmail.com>
Cc: stable@vger.kernel.org # v6.4+
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 0cae5746f540..eec0ad85be72 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -1325,6 +1325,34 @@ int rtw_sdio_probe(struct sdio_func *sdio_func,
 	rtwdev->hci.ops = &rtw_sdio_ops;
 	rtwdev->hci.type = RTW_HCI_TYPE_SDIO;
 
+	/* Insert a delay of 500 ms. Without the delay, the wifi part
+	 * and the UART that controls Bluetooth interfere with one
+	 * another resulting in the following being logged:
+	 *
+	 * Start of SDIO probe function.
+	 * Bluetooth: HCI UART driver ver 2.3
+	 * Bluetooth: HCI UART protocol Three-wire (H5) registered
+	 * of_dma_request_slave_channel: dma-names property of node '/serial@fe650000'
+	 *	 missing or empty
+	 * dw-apb-uart fe650000.serial: failed to request DMA
+`	 * rtw_8821cs mmc3:0001:1: Firmware version 24.8.0, H2C version 12
+	 * rtw_8821cs mmc3:0001:1: sdio read32 failed (0x11080): -110
+	 *
+	 * If the UART is finished initializing before the SDIO probe
+	 * function startw, the following is logged:
+	 *
+	 * Bluetooth: HCI UART protocol Three-wire (H5) registered
+	 * of_dma_request_slave_channel: dma-names property of node '/serial@fe650000'
+	 *	missing or empty
+	 * dw-apb-uart fe650000.serial: failed to request DMA
+	 * Start of SDIO probe function.
+	 * rtw_8821cs mmc3:0001:1: Firmware version 24.8.0, H2C version 12
+	 * Bluetooth: hci0: RTL: examining hci_ver=08 hci_rev=000c lmp_ver=08 lmp_subver=8821
+	 * SDIO wifi works correctly.
+	 *
+	 * No adverse effects are observed from the delay.
+	 */
+	mdelay(500);
 	ret = rtw_core_init(rtwdev);
 	if (ret)
 		goto err_release_hw;
-- 
2.44.0


https://1EHFQ.trk.elasticemail.com/tracking/unsubscribe?d=Q8ssbFKKxFyDYflgetP6nBeacBsR9zpdaz0g6MwIeA6CJKd2sQMmPI9ONTwNj6faC9CgSWZc53ZQ96HQFrbDSPngQHeCyqSokhmrQJQALWxI0

