Return-Path: <linux-wireless+bounces-10589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BDB93EA16
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 00:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF8A1C2017C
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 22:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0218B2AD29;
	Sun, 28 Jul 2024 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XN2+2j29"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4008E54FAD
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jul 2024 22:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722206986; cv=none; b=XkWsUdcexxm//aKSX6ACrayNpaqtdxHMrylWSVrMCwiFv/ZTpKdQJX1skX06iDULrdFiVis2dcagmQh+vQ0Pd0ToxpO4CyF0yOsvXN9oIJDSeiaGE87zk5m360rTHvZ+/RpyXsSsqZhY0o5qH13Kg8eFc2n+N2ACheAawqIRumg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722206986; c=relaxed/simple;
	bh=+qQgl5RDDxvPgxbPVpsTRIN2/kQd3NzjM3gOvdhKGpQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=r4kf21ri41G+C78JhdDINP7P7fXxB9Hc+Cy+yuQydmQIRl0ZGY5QW/QfbXsp/OCpwyQzVN2bHLBLxAbtBN7jLOrAE5q/WjuvBQUSPSqznKhbNc4D7OobOJYqKwBmYVUjNAW6U4SjusCAET+LsjCUEGlzdq6BVpwRI5RIiv6er14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XN2+2j29; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a167b9df7eso4934975a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jul 2024 15:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722206983; x=1722811783; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkd+uLao6ZqaDu9jzLhPqRnTuRtSnl73/shl3OW7cwI=;
        b=XN2+2j29C0QzaQ1QeOayN2DQ8XeHQ/XHU3cFOv1WBgmFlP4V99dSY/IkpUVDdrhzP2
         F61QMmr8E1sJqvc+Rk3bz6GvfgHD2WFtLX62bYFxujfcfq1YQRjwkMPTA9le5EbHpitF
         NCh3shEIRDyhBdVHhzIpw1gyNAwHH2Mf6LDmmZ1AXjra83Jwn5ZZrUP7W0G8gN6NJXD1
         umQJyOuAdy+nuXPjqhFn3OkCQev8SXqgpL3WEjrR4WSelPnkjjBrO6Y/sVQv2LpaxbJA
         el0bk7MxyuJXcUWZ0HyoRbQ7TnFryJ3+GlLR+zW3juy6br5QRzkjGfxm+NlTxfTsjBvf
         CDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722206983; x=1722811783;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hkd+uLao6ZqaDu9jzLhPqRnTuRtSnl73/shl3OW7cwI=;
        b=dQWSkmpeEXUqrQGT0QPpnMLd+LNayjqS0J3QuygDjgjcuTG4lKoX7IUg0+FJydk1uB
         o2zZz7kCBw4Y7u2d/I/Zth+qODccNYQVScFLm/lHJ0Vh6dJ4zU7PmNW3mXZs7/K61yde
         qMSE3OGayqVSJQxkB4rAS3uiiawdcKqKQhgOvlH2NqQQ5HMmF3afxngtmckqF22oaH7u
         hIKl/HYYexHMMj8HmosGWgZmX2KGCxLCcPAY+hqRqTY+MJxltVtD3pUL2s4EV/INz9XW
         b0gT2XNJ6UOPyZOhImDypNk2j2TFj8HOwCb7HpUV3sH51pXBJDQ7mxqMBYcIvZKYRTHS
         kJ/A==
X-Gm-Message-State: AOJu0YyaIghuIBcAVX8MVzEM/8tQz0f6LC9y08K60SWPzHKPcyi1V08I
	RAbXaPmLtBj6k9fIdm5t+3RUIMFJJ8dQsDFjt6uyUfkb6NpeKWG68JGaVg==
X-Google-Smtp-Source: AGHT+IG0XFymc1lXg9gtz8hddBzlcCvCIPUqPeFJwVkHmLTtgG+Vuwi1qlOYncp7Vglv5l8dDsclVw==
X-Received: by 2002:a17:906:7950:b0:a77:c9cc:f96f with SMTP id a640c23a62f3a-a7d3ffdadc2mr475904566b.7.1722206983226;
        Sun, 28 Jul 2024 15:49:43 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad9104csm430179166b.157.2024.07.28.15.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 15:49:42 -0700 (PDT)
Message-ID: <9174a776-4771-4351-85fa-476e240d8ace@gmail.com>
Date: Mon, 29 Jul 2024 01:49:39 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH 1/2] wifi: rtw88: Fix USB devices not transmitting beacons
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

All USB devices supported by rtw88 have the same problem: they don't
transmit beacons in AP mode. The cause appears to be clearing
BIT_EN_BCNQ_DL of REG_FWHW_TXQ_CTRL before uploading the beacon reserved
page, so don't clear the bit for USB devices.

Tested with RTL8811CU and RTL8723DU.

Cc: stable@vger.kernel.org # 6.6.x
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
I'm not sure if SDIO devices have the same problem. Also, should
BIT_EN_BCNQ_DL ever be cleared in this function? The relevant code is
disabled in all these drivers:

https://github.com/morrownr/8821cu-20210916/blob/3eacc28b721950b51b0249508cc31e6e54988a0c/hal/rtl8821c/rtl8821c_ops.c#L1603

https://github.com/tomaspinho/rtl8821ce/blob/f119398d868b1a3395f40c1df2e08b57b2c882cd/hal/rtl8821c/rtl8821c_ops.c#L1668

https://github.com/alireza-tabatabaee/RTL8821CS/blob/2d8a102dd7399a243f11b13314c299e509cc4ef1/rtl8821cs/hal/rtl8821c/rtl8821c_ops.c#L1603

https://github.com/morrownr/88x2bu-20210702/blob/3c8f59b5b05e5090e8593da1940a8d3ccac3f878/hal/rtl8822b/rtl8822b_ops.c#L1771

https://github.com/thales-dis-dr/rtl8822CU/blob/4182c79e0c5362dcea46088dab9fed27795b5579/hal/rtl8822c/rtl8822c_ops.c#L1941
---
 drivers/net/wireless/realtek/rtw88/fw.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index ab7d414d0ba6..782f3776e0a0 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -1468,10 +1468,12 @@ int rtw_fw_write_data_rsvd_page(struct rtw_dev *rtwdev, u16 pg_addr,
 	val |= BIT_ENSWBCN >> 8;
 	rtw_write8(rtwdev, REG_CR + 1, val);
 
-	val = rtw_read8(rtwdev, REG_FWHW_TXQ_CTRL + 2);
-	bckp[1] = val;
-	val &= ~(BIT_EN_BCNQ_DL >> 16);
-	rtw_write8(rtwdev, REG_FWHW_TXQ_CTRL + 2, val);
+	if (rtw_hci_type(rtwdev) != RTW_HCI_TYPE_USB) {
+		val = rtw_read8(rtwdev, REG_FWHW_TXQ_CTRL + 2);
+		bckp[1] = val;
+		val &= ~(BIT_EN_BCNQ_DL >> 16);
+		rtw_write8(rtwdev, REG_FWHW_TXQ_CTRL + 2, val);
+	}
 
 	ret = rtw_hci_write_data_rsvd_page(rtwdev, buf, size);
 	if (ret) {
@@ -1496,7 +1498,8 @@ int rtw_fw_write_data_rsvd_page(struct rtw_dev *rtwdev, u16 pg_addr,
 	rsvd_pg_head = rtwdev->fifo.rsvd_boundary;
 	rtw_write16(rtwdev, REG_FIFOPAGE_CTRL_2,
 		    rsvd_pg_head | BIT_BCN_VALID_V1);
-	rtw_write8(rtwdev, REG_FWHW_TXQ_CTRL + 2, bckp[1]);
+	if (rtw_hci_type(rtwdev) != RTW_HCI_TYPE_USB)
+		rtw_write8(rtwdev, REG_FWHW_TXQ_CTRL + 2, bckp[1]);
 	rtw_write8(rtwdev, REG_CR + 1, bckp[0]);
 
 	return ret;
-- 
2.45.2


