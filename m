Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83973731EA
	for <lists+linux-wireless@lfdr.de>; Tue,  4 May 2021 23:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhEDV3i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 May 2021 17:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbhEDV3h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 May 2021 17:29:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67F1C061574
        for <linux-wireless@vger.kernel.org>; Tue,  4 May 2021 14:28:41 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id t4so15446250ejo.0
        for <linux-wireless@vger.kernel.org>; Tue, 04 May 2021 14:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZZvdTpVzKytL+rUETzdNGHFwnxZ9kT9mkT+bCXVESvo=;
        b=FSuNDq7jHh+v2UdIIW+IGi81xmNjOGdscE4CLvfnKfRdB+znOe2U2JWmjICDZozmsH
         feln6SXbfQ9+Eeq535VHmY8hmvoGjb51q91LWuZ8GqgjURxI/lrj6cEky3BllHnZ86Hu
         chi21FVftrev+oy7IMRihQmWqjV5NJstvocnpBymqUDTleHNkF124c/lak+USeEPpdRV
         trCx4MFnUxZEmkSevqB2APscdmpj6zwA7qE4iZDEjDP46TLB6Q2A97YU+CcuzIc1zZcs
         dnCBv1Vk1GRQdFO/Se/GsYCFrNjZVDGTeO6g/z+k04XLvY0Ck4mb13FPJtCPeJFLh9/+
         Tbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZZvdTpVzKytL+rUETzdNGHFwnxZ9kT9mkT+bCXVESvo=;
        b=jnfV86ep+0qz03nYhi62Xq04/IQ6YleCH0gIWC25/rkbgD9P7lv4FBiUcXLjK1ZApr
         3vHoVHrDWinLAlmg1T2dYKqrttd88VE/GOXEp2N1H7wf1zUr/lujVq7zkdMhDWazbZTQ
         w6iWVDwBN0rg8F9R/wIUil4zES1mjihk5kODGdRqJqh3T0di/d2coDY9RdGxpb86zBQb
         dUctCWzRNEfOincH9C1hanBi2SpWdfSY1y7/LdhEbc+j0Fc2kyAV4/fLWPkq7jTN/cvl
         /QcUqInt6SUGSdixGThyKs9o1njZzwOKyO+GbV2tR9rXHSDk6h2Zwyrk0PSNDe1JWbSB
         u4+Q==
X-Gm-Message-State: AOAM532gyDkPAcVKuPnCZ4PE0o8XqFJY+o8eelk36Uof6LR/QFY7Aq6d
        XfUSigml6p6q4NUcY4ZQWw==
X-Google-Smtp-Source: ABdhPJw7C67T82XIHwzj4I+j4nakPSR5gNkSE6fsw5b3AM0tYpKoapTRICEvlLfG7Cjb8pvETgwGmg==
X-Received: by 2002:a17:906:3949:: with SMTP id g9mr24088836eje.7.1620163720574;
        Tue, 04 May 2021 14:28:40 -0700 (PDT)
Received: from presler.lan (a95-94-79-115.cpe.netcabo.pt. [95.94.79.115])
        by smtp.gmail.com with ESMTPSA id p18sm1954488ejb.19.2021.05.04.14.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 14:28:39 -0700 (PDT)
From:   Rui Salvaterra <rsalvaterra@gmail.com>
To:     stf_xl@wp.pl
Cc:     lorenzo@kernel.org, kuba@kernel.org,
        linux-wireless@vger.kernel.org,
        Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [RFC PATCH] mt7601u: make the driver work again
Date:   Tue,  4 May 2021 22:28:28 +0100
Message-Id: <20210504212828.815-1-rsalvaterra@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a tentative fix for a long-standing issue [1] with MT7601U devices. In
my case, this is what I see in the dmesg when I plug the device in:

[  660.810386] usb 1-7: new high-speed USB device number 119 using ehci-pci
[  661.031390] usb 1-7: New USB device found, idVendor=148f,
idProduct=7601, bcdDevice= 0.00
[  661.031400] usb 1-7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  661.031404] usb 1-7: Product: 802.11 n WLAN
[  661.031408] usb 1-7: Manufacturer: MediaTek
[  661.031411] usb 1-7: SerialNumber: 1.0
[  661.200379] usb 1-7: reset high-speed USB device number 119 using ehci-pci
[  661.403137] mt7601u 1-7:1.0: ASIC revision: 76010001 MAC revision: 76010500
[  661.404566] mt7601u 1-7:1.0: Firmware Version: 0.1.00 Build: 7640
Build time: 201302052146____
[  661.828765] mt7601u 1-7:1.0: EEPROM ver:0d fae:00
[  662.005518] mt7601u 1-7:1.0: Error: MCU resp urb failed:-71
[  662.005525] mt7601u 1-7:1.0: Error: MCU resp evt:0 seq:5-4!
[  662.010015] mt7601u 1-7:1.0: Error: MCU resp urb failed:-71
[  662.010020] mt7601u 1-7:1.0: Error: MCU resp evt:0 seq:5-4!
[  662.014269] mt7601u 1-7:1.0: Error: MCU resp urb failed:-71
[  662.014275] mt7601u 1-7:1.0: Error: MCU resp evt:0 seq:5-4!
[  662.018516] mt7601u 1-7:1.0: Error: MCU resp urb failed:-71
[  662.018521] mt7601u 1-7:1.0: Error: MCU resp evt:0 seq:5-4!
[  662.022768] mt7601u 1-7:1.0: Error: MCU resp urb failed:-71
[  662.022775] mt7601u 1-7:1.0: Error: MCU resp evt:0 seq:5-4!
[  662.022779] mt7601u 1-7:1.0: Error: mt7601u_mcu_wait_resp timed out
[  662.350350] mt7601u 1-7:1.0: Vendor request req:07 off:0080 failed:-71
[  662.650344] mt7601u 1-7:1.0: Vendor request req:02 off:0080 failed:-71
[  662.950339] mt7601u 1-7:1.0: Vendor request req:02 off:0080 failed:-71
[  662.950389] mt7601u: probe of 1-7:1.0 failed with error -110
[  662.950850] usb 1-7: USB disconnect, device number 119

This loops continuously. The device never comes up.
Turns out, this issue has been narrowed down to a possible calibration
problem [2]. Stanislaw repeatedly asked if disabling DPD calibration only
(keeping the RXIQ calibration) would fix the problem, but nobody seems to have
paid attention. :) Additionally, he asked for contents of
/sys/kernel/debug/ieee80211/phy0/mt7601u/eeprom_param, so here they are:

RF freq offset: 5f
RSSI offset: 0 0
Reference temp: f9
LNA gain: 0
Reg channels: 1-14
Per rate power:
	 raw:05 bw20:05 bw40:05
	 raw:05 bw20:05 bw40:05
	 raw:03 bw20:03 bw40:03
	 raw:03 bw20:03 bw40:03
	 raw:04 bw20:04 bw40:04
	 raw:00 bw20:00 bw40:00
	 raw:00 bw20:00 bw40:00
	 raw:00 bw20:00 bw40:00
	 raw:02 bw20:02 bw40:02
	 raw:00 bw20:00 bw40:00
Per channel power:
	 tx_power  ch1:0c ch2:0c
	 tx_power  ch3:0b ch4:0b
	 tx_power  ch5:0a ch6:0a
	 tx_power  ch7:0a ch8:0a
	 tx_power  ch9:0a ch10:0a
	 tx_power  ch11:0a ch12:0a
	 tx_power  ch13:0a ch14:0a

The attached patch fixes the driver for me. Sending as RFC because this will
probably warrant some kind of quirk to be fixed correctly. Besides, there's an
additional DPD calibration in mt7601u_temp_comp, which I haven't touched, since
it seems a bit more convoluted. The driver works for me regardless (I've sent
this email through one of my MT7601U adapters).

[1] https://github.com/kuba-moo/mt7601u/issues/64
[2] https://github.com/kuba-moo/mt7601u/issues/64#issuecomment-352250127

Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
---
 drivers/net/wireless/mediatek/mt7601u/phy.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt7601u/phy.c b/drivers/net/wireless/mediatek/mt7601u/phy.c
index 8a00f6a75ca9..daa6a042f2c7 100644
--- a/drivers/net/wireless/mediatek/mt7601u/phy.c
+++ b/drivers/net/wireless/mediatek/mt7601u/phy.c
@@ -589,8 +589,6 @@ void mt7601u_phy_recalibrate_after_assoc(struct mt7601u_dev *dev)
 	if (test_bit(MT7601U_STATE_REMOVED, &dev->state))
 		return;
 
-	mt7601u_mcu_calibrate(dev, MCU_CAL_DPD, dev->curr_temp);
-
 	mt7601u_rxdc_cal(dev);
 }
 
@@ -1157,9 +1155,6 @@ static int mt7601u_init_cal(struct mt7601u_dev *dev)
 	if (ret)
 		return ret;
 	ret = mt7601u_mcu_calibrate(dev, MCU_CAL_RXIQ, 0);
-	if (ret)
-		return ret;
-	ret = mt7601u_mcu_calibrate(dev, MCU_CAL_DPD, dev->dpd_temp);
 	if (ret)
 		return ret;
 
-- 
2.31.1

