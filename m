Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C02493A49
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jan 2022 13:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241856AbiASMbg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jan 2022 07:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbiASMbf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jan 2022 07:31:35 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C88C061574
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jan 2022 04:31:34 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id p27so8806730lfa.1
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jan 2022 04:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0GEOIM8l9FtTmni49vwe+DzBbTTaYfYBEtU5A35vito=;
        b=apxf71eG0w90DaXn5Z7UQroImCQHdmyAUEjfcLpU1YBzA48yKwK4/kIfLw1DUh82UU
         wdPuT64eQj3MaNkC12eMQg0pIxu4Uza+XlK3US9hek0QjbUAc0FmwZNsNhBeXdM5HsUU
         eT8Dnz/UYkTyU2kG2Dw5ClyAV6hUgIiZ+OokAqhv9Swq2TjHF+Yg2HNnf6FFKUkuXdb9
         uwa4NWWbLHDh4GQIc0ebNX9TyLnFeOFzrKwVa6MwNjUSGwO06qckYxMa1kA9Se4ZE76S
         1HOYMID2HvoDgEPFDLL3pC2DR1HBH1nyABfTzz49+WE+TplAQSSnESoXLyet8koD1tM/
         PXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0GEOIM8l9FtTmni49vwe+DzBbTTaYfYBEtU5A35vito=;
        b=rwFW1spKWmbNQn3GOB3dACRxcaVs7ftz22BBI8sD6Awz0+wisQf6ipxq5LwqWUfggX
         07ydMSb4Mud3WuLaEWW8wmd7oYqxOEEToXUDL4pH5i2WJ9RABQWGKlrb3RnsMyccgPhO
         pl9nETCycwEnqcn5ts04bOGIEbVv9AnSU8RrZXHJKkyYZpVsRWVDSAna9YQNLcxry2mt
         xsjOfMwyjofxIBQ1Zhfg6FAxIh7D0Q9MPlR/91E+WTs7cs3FdnBJ5ZHvGj6Gp0UgtMff
         FicidfNam3kPetgYzrsgIHlq+0cFjhdVmiVzzH1WfcnUrgSQExXNzmJnQuRPnstKcP1r
         cuEA==
X-Gm-Message-State: AOAM533WayvLlhhMy2bQusWsU0OE/EvysmWMu1U91popzTVHyL6vFaQa
        UYu4iiPrPrjX0YlC1qXa/GRqhKBhNug=
X-Google-Smtp-Source: ABdhPJxGmm1NbW8hThADRhdAzO8QMSGFQJPFo0mpSnlWh36EKa24W1S21XM1gWqD6BPDRCC0TouRAQ==
X-Received: by 2002:a05:6512:1293:: with SMTP id u19mr24537557lfs.373.1642595493179;
        Wed, 19 Jan 2022 04:31:33 -0800 (PST)
Received: from localhost.localdomain ([45.142.163.102])
        by smtp.gmail.com with ESMTPSA id h7sm2003163lfv.104.2022.01.19.04.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 04:31:32 -0800 (PST)
From:   Piotr Dymacz <pepe2k@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, lorenzo.bianconi83@gmail.com, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7615: add support for LG LGSBWAC02 (MT7663BUN)
Date:   Wed, 19 Jan 2022 13:31:21 +0100
Message-Id: <20220119123121.48351-1-pepe2k@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The LG LGSBWAC02 (FCC ID: BEJLGSBWAC02) is a combo Wi-Fi/BT module which
can be found in several different LG TV models. This module is based on
already supported MediaTek MT7663U series.

Device from /sys/kernel/debug/usb/devices:

T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=02 Dev#=  4 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=043e ProdID=310c Rev= 1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=000000000
C:* #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr=100mA
A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 8 Cls=ff(vend.) Sub=ff Prot=ff Driver=mt7663u
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=08(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=09(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

And dmesg:

usbcore: registered new interface driver mt7663u
mt7663u 1-1.4:1.2: N9 Firmware Version: 3.1.1, Build Time: 20200604161656
mt7663u 1-1.4:1.2: Region number: 0x4
mt7663u 1-1.4:1.2: Parsing tailer Region: 0
mt7663u 1-1.4:1.2: Region 0, override_addr = 0x00118000
mt7663u 1-1.4:1.2: Parsing tailer Region: 1
mt7663u 1-1.4:1.2: Parsing tailer Region: 2
mt7663u 1-1.4:1.2: Parsing tailer Region: 3
mt7663u 1-1.4:1.2: override_addr = 0x00118000, option = 3

Signed-off-by: Piotr Dymacz <pepe2k@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index 0396ad532ba6..5cad398abf63 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -17,6 +17,7 @@
 
 static const struct usb_device_id mt7615_device_table[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0e8d, 0x7663, 0xff, 0xff, 0xff) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x043e, 0x310c, 0xff, 0xff, 0xff) },
 	{ },
 };
 
-- 
2.34.1

