Return-Path: <linux-wireless+bounces-22713-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 336E2AAE001
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 15:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B06188E57C
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 13:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8492772619;
	Wed,  7 May 2025 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gn/VDqoA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04504D599
	for <linux-wireless@vger.kernel.org>; Wed,  7 May 2025 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623002; cv=none; b=jfku2BntrXaarsXKkviMw7QhJDlUlj4YR06VfRuWc9fbzW3/8Q9EW/14S/bmCP2tIykHahCKhssx1kmyNPZTXAnsKu0178WWhK6GU4WdrucdUvNpx6iiVojuB+jFR92Miya52ZDNXMPhFtUUUJecqQue5/8bx5MmBz2nfQomw6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623002; c=relaxed/simple;
	bh=MV6tJwu4RoogTcKx5mnNBJi6bVJKULQXAb5hb15g0sk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=b+C0MJRBQIe2zDGQ+9M1SlnD9mPkgIpuMQUhvfb6ikHFDDmu2UqSdyOHxej+vxM2qnj0wRBPo9pVwUjLZLQtICSkyuQ1Caau6Pv1rtW+SnYBPPLcSMXtTa19uqV73vHxYKvsY+W96ivKgcUjVrPyKSQyF1R8IYTB+ioit+9iSvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gn/VDqoA; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5fbfa0a7d2cso654075a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 07 May 2025 06:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746622998; x=1747227798; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTJ0vSgiCcOsm5K7WcRghePLxmmBRGmrDaFbuYp2/0g=;
        b=Gn/VDqoAQxX4IBu1qqD8+FiWU8KPQeXFbra07OSGHdtI/bEsKOzFTzKjGdC0Sp3iy3
         igdoxPssjTzOWrMLj24mUdYCeecaXCq+lGjctLfwySO7YXIpHOAjtBeQ1y16sA57yT7u
         QtDVeRyecRPbkK7UMl58WWV8hab2FfcGnUwJ+o1Z8XlEJXcOCPM6EO6vmPglC4utvwNL
         yHBNgYTfnfYHMiwS4e/Gv3okSFfbXQE1oHDlPblQHnYRdxQiT2XhTt4HHfhf+X+/KpmA
         Ip7af0TPyjvTgpvCmtln4tSPB4K/MTw1eVf2X8VZ/JKD1blWwS4hnwkUnmLSuhAiZkof
         6Bkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746622998; x=1747227798;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lTJ0vSgiCcOsm5K7WcRghePLxmmBRGmrDaFbuYp2/0g=;
        b=UaA4CDTm0087gh4aXtB9RYtFTG//Zlx7jHXX6fFvm95gNOLX2id03aXZJY7vrXMVcF
         PK2ciDeTMN326kJakKasutV7TxcfvNpDUu4Jt5rlwvY8QqGWLi7Td6x0dgvVbdSnuaVx
         9nuln36bStJjRFFrwiq3LUxf48Cec95NQHuLJLcMg0RWX0YsquvSh75FjgWqSAhZuIED
         1w2LtIS6gLpK+hbbajhtH1eD5f7MQBG2S2Vsc9h+waZDDivmIPMyaGjoSDDmEaCk6BxL
         LHpRHkXAFhRJCEeIaMUP9P1+Oc0k7ISkAUxsCNKhHolTGMkfZbkjY6h12SOjdCi00YX+
         0uzA==
X-Gm-Message-State: AOJu0Yz2AbnXbPpRwTYrL53o98XjP77XLxJSnYfTgcHRg6CcP9x64tco
	p1iVB5dzSRbVE8XXcqhUU93y2xijrsXvmXjWKUABLBPuxCTYzrb66PTh+Q==
X-Gm-Gg: ASbGncuIFw7X5xRS1ymngrSlba8Kkl57JGL2r4KBGW2YSjRiKhGgba78eiK7N/I5mQu
	AFWFyZQcQQWxq/ZgcVfgHeZfj/vopaYw4VGo/nwOO2lUAp2G6y/RtHMaHXJxS8YmhTfzJRc/POE
	AUYBA22+ZSMNrWwpmXdVtPEc5CRHRe1vyaJQXw8QrNKXxXpaL0E2Lw5hOpA811ChMhFPSQszbzd
	Ia5BePGyEbltkr+1QyqXlgAam/8VO+S6jWC4s6Mc8laqgBSOIm2g0KH0JJekbCQZRdbAJEGm3h3
	Mi8yDCjL2Nx9U6GlWoVOwso1hHTI7T1Jj4xd48RSrz9StdiJxw==
X-Google-Smtp-Source: AGHT+IEetQAPGLWD2CrYj3lRO23NcBoiSoHJ7U988QVFMhkdqZ42B8fcQDu9oGtX2RYwqusvYR8naQ==
X-Received: by 2002:a05:6402:3514:b0:5fb:6172:c65d with SMTP id 4fb4d7f45d1cf-5fbe9dcb9bcmr2943162a12.10.1746622997445;
        Wed, 07 May 2025 06:03:17 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.158])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc001e59cfsm149573a12.37.2025.05.07.06.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 06:03:16 -0700 (PDT)
Message-ID: <af4d2d58-f567-4bdf-841b-8345d21f7035@gmail.com>
Date: Wed, 7 May 2025 16:03:14 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next 1/2] wifi: rtw88: usb: Reduce control message timeout
 to 500 ms
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8811AU stops responding during the firmware download on some systems:

[  809.256440] rtw_8821au 5-2.1:1.0: Firmware version 42.4.0, H2C version 0
[  812.759142] rtw_8821au 5-2.1:1.0 wlp48s0f4u2u1: renamed from wlan0
[  837.315388] rtw_8821au 1-4:1.0: write register 0x1ef4 failed with -110
[  867.524259] rtw_8821au 1-4:1.0: write register 0x1ef8 failed with -110
[  868.930976] rtw_8821au 5-2.1:1.0 wlp48s0f4u2u1: entered promiscuous mode
[  897.730952] rtw_8821au 1-4:1.0: write register 0x1efc failed with -110

Each write takes 30 seconds to fail because that's the timeout currently
used for control messages in rtw_usb_write().

In this scenario the firmware download takes at least 2000 seconds.
Because this is done from the USB probe function, the long delay makes
other things in the system hang.

Reduce the timeout to 500 ms. This is the value used by the official USB
wifi drivers from Realtek.

Of course this only makes things hang for ~30 seconds instead of ~30
minutes. It doesn't fix the firmware download.

Tested with RTL8822CU, RTL8812BU, RTL8811CU, RTL8814AU, RTL8811AU,
RTL8812AU, RTL8821AU, RTL8723DU.

Cc: stable@vger.kernel.org
Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
Link: https://github.com/lwfinger/rtw88/issues/344
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 204343ac2558..b16db579fdce 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -139,7 +139,7 @@ static void rtw_usb_write(struct rtw_dev *rtwdev, u32 addr, u32 val, int len)
 
 	ret = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
 			      RTW_USB_CMD_REQ, RTW_USB_CMD_WRITE,
-			      addr, 0, data, len, 30000);
+			      addr, 0, data, len, 500);
 	if (ret < 0 && ret != -ENODEV && count++ < 4)
 		rtw_err(rtwdev, "write register 0x%x failed with %d\n",
 			addr, ret);
-- 
2.49.0


