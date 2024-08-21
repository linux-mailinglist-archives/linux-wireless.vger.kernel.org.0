Return-Path: <linux-wireless+bounces-11744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB93F959E36
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 15:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4573BB22C34
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 13:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCC6192D9C;
	Wed, 21 Aug 2024 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkEitXiX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61A3199939
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724245870; cv=none; b=gm2CiWi+jQCETgavJQTewuFdpiXhv+EcGuQ+0zEqwj1b2LLYNi4WDuR2gfTjiuSrtTo6a51xyvkYOadiePVCKbLKFhC5Sn33lh3WR14Tsi2gfY3GnT+pGwhQ/r8GI1tQfPWgkwv6gMle5Zon2TfQJdzshMXVhGE2YORCl+UIWRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724245870; c=relaxed/simple;
	bh=yKrWgSvrw7rXrSG2YXIc+mUm8jHfiMjfFHr8X7c3lqA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=jWJAaaVQVjDZLGRSSgighRyjYcqg+eH7gS5EN1x0/8jm2E2B//PFGu+tScTnrFQH8sIDfpWDCqhkjK5mUNar/rvdt7PAieWSZAR8w+v0O3uqIYcyJvzGQQHuy3mrVZm0mNqfDNGNuKu7QlvdRZ1drlD+yrawE9tbBTDzoTQFJ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkEitXiX; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8647056026so234868066b.0
        for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 06:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724245867; x=1724850667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTnowNxLgQDXngdT2ho0supNXficugR1TOkRkefXIdQ=;
        b=hkEitXiXhJuMmXUsAlJxwVB6wBEq1N2yztsljEfHk4FkiGs5YkB3FGlJQt1k4r/Nzr
         8/XJ2aDg3oYN5NjARENbaB0fDwPAfNZnRQEQ1LZ+/9W1r8kduIgYt8wqxSS+zceBuKg5
         GTPNgq8Wh+3yVM2LRVhDaFR/J41EQbOtjH9tyIqeRVxgU6adm3fgqA3WSb+fZzOfttBU
         sPEHpHlUBosdA9B09rMFxnF4tENK/hBLDjo9Jbifdbbc0f0zs2NtDD4E6KAUN6yzGLM3
         DVrLNbZZm56slIG2Y7uHlZBwHWChA1e9hfcNj/Unq6gli4iIedq63hwgAp88RUsM1jCl
         01qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724245867; x=1724850667;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LTnowNxLgQDXngdT2ho0supNXficugR1TOkRkefXIdQ=;
        b=IaAbxBLeTCjB5bj20L6dNV41iJaDMjxoSJtoWROO4Ve1uMaq/XMBEbWTegp/1jfrAq
         6w3EOe7LOKKKec2e4Yue2+0/CWZATahUgqbU0GCytHNyqt4CQlKBrv3COpm/NdJnPZdU
         RSLXYHHR953zHzVkSVrF9BpEg6XPysONIW58YeTxjTSoGGNkmDxzTfGl6Nhj3m1/Km9O
         uUuWwDpt6xTnSdVMWn2/9QVciRYHqgMUZFYuwNBEvDQKMxTEE1qH41aGQScfPWr0PMQi
         tLSYJPAe0AY3nsXqB45Kjt56QrWaXa0NBsHQMLNBD48Xdtued3x6TRhgG0EuR6N2VUIq
         R/UA==
X-Gm-Message-State: AOJu0YwKi/u7q5BHM47JeA0+Eox2qII8TCl2Gmuj7BgxcM//9A/sisft
	7n0dQnnhjLZjq2AWWudsNA+IeT2nWA5UI630e8ffj69Bao0eoOjlSK+LKw==
X-Google-Smtp-Source: AGHT+IEBSN4Az+S1PtZlFqwnyK/s/x/Mm+bHZz0wFeNtC6IYhNRkWeXGCIQN2SfoY8s4oj3j6byreQ==
X-Received: by 2002:a17:907:f70e:b0:a7a:d093:f843 with SMTP id a640c23a62f3a-a866f9cabbfmr170967466b.63.1724245866564;
        Wed, 21 Aug 2024 06:11:06 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839356fasm894782566b.124.2024.08.21.06.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 06:11:06 -0700 (PDT)
Message-ID: <49de73b5-698f-4865-ab63-100e28dfc4a1@gmail.com>
Date: Wed, 21 Aug 2024 16:11:03 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2] wifi: rtw88: Fix USB/SDIO devices not transmitting beacons
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

All USB devices supported by rtw88 have the same problem: they don't
transmit beacons in AP mode. (Some?) SDIO devices are also affected.
The cause appears to be clearing BIT_EN_BCNQ_DL of REG_FWHW_TXQ_CTRL
before uploading the beacon reserved page, so don't clear the bit for
USB and SDIO devices.

Tested with RTL8811CU and RTL8723DU.

Cc: <stable@vger.kernel.org> # 6.6.x
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Only clear BIT_EN_BCNQ_DL for PCIE devices:
   https://lore.kernel.org/linux-wireless/CAP8xZ6n8utvFJCmTwnRzFccRkZZzk+R5Bf69UArbbzd4Ev9aRQ@mail.gmail.com/
 - Update the commit message.
---
 drivers/net/wireless/realtek/rtw88/fw.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index ab7d414d0ba6..b9b0114e253b 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -1468,10 +1468,12 @@ int rtw_fw_write_data_rsvd_page(struct rtw_dev *rtwdev, u16 pg_addr,
 	val |= BIT_ENSWBCN >> 8;
 	rtw_write8(rtwdev, REG_CR + 1, val);
 
-	val = rtw_read8(rtwdev, REG_FWHW_TXQ_CTRL + 2);
-	bckp[1] = val;
-	val &= ~(BIT_EN_BCNQ_DL >> 16);
-	rtw_write8(rtwdev, REG_FWHW_TXQ_CTRL + 2, val);
+	if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_PCIE) {
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
+	if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_PCIE)
+		rtw_write8(rtwdev, REG_FWHW_TXQ_CTRL + 2, bckp[1]);
 	rtw_write8(rtwdev, REG_CR + 1, bckp[0]);
 
 	return ret;
-- 
2.46.0


