Return-Path: <linux-wireless+bounces-22809-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED792AB23BD
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 14:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F33B3ADBE7
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 12:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA41A1F2C58;
	Sat, 10 May 2025 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWT3HNVm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F781E520E
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746879691; cv=none; b=rgTC+3zZ8bTPqQPz8bn6mSljnl4OW/oui3OP+2FLVy19Jn4HeVMdcXS0BC1R/79ZUVWrZmt5JpgeOB7NxsitxGGHiuqBBBhQvbMyO3OgtQ342wHVKoJO3SJ6gmpllg+zEkfVbZZJSDLBXV7YGfddmzHy52ym3qgEASOtsRYcXwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746879691; c=relaxed/simple;
	bh=yRHnIuAADgrFSak4F/lXCqFMMANSwdDOZx5U/vW0jQk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=iFmxYiJOBB1TzTQvh5IzKxMf+pEGQgaJZg7YmX4sOjvYNA1sgrLdJyuEr15QN1ODsdgBVmV7kL8c/DsoweuGF4mfCYASTT8cWahOsxW+S5P4fZxyAxtZRHEgkauyi/FEKDtCwkwZIbTFg5ppj6wrtVv6eGQv+1VnpyTHy4q5veY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWT3HNVm; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5fbfa0a7d2cso5001005a12.1
        for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 05:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746879688; x=1747484488; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwyOQdoFrAmqngZgMLScvZZ/U1kJhuHRNHW+VmqS3LY=;
        b=MWT3HNVmHJtRWtfSTmgfZ7LBA43erL5bTpiGZ+8Wf6DlgdfU3Y5HbX8UNxM8/1lIk2
         R+5GvvEBhNO3NapDBHpQnYZ8zSOFdflwCxK42jHr0JTDdOGFnuq4gXBIFp7/ajzvzpUg
         pd5J0xEU2rdBxqvnvDk1W95ZDw+oREbVXTEDeWKPhaEgTEbbtPT+iFMJVrV/Ia/F+YHr
         YOnc/YXmnUM0xHxpORD8wZ3brNWIuxGEwPeO1oI8SztIrAGhgVS6cPgVtURqP+92FwdX
         cl7wkahnB8/l7z2821n52fpKQ7mbbK8gVUKkertRVitCNnmwPTV7IAsbIPxVUhuq4hPL
         /lEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746879688; x=1747484488;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dwyOQdoFrAmqngZgMLScvZZ/U1kJhuHRNHW+VmqS3LY=;
        b=JE8Nqfa2WWJo2HVuLXdYZGze574QKwOKhCBlrLn5ptVMMMeDnO4BmzhEj2hFj6RU98
         uwcSHNej2Vg9O9g3S9ftJx07NpPabtl93MUClBsAIEpty3EqX3oTuIPgi6chWOaJ/UDj
         VpNt7E1PZuvyn0PcOeACxM4+0zPjOLETphiXdHfCUjaI8LKHsyWRXalo03UkNm5Dp/ns
         sbAQFRHMFyH8urmxuZlK3fFHQsGHmid2u23XNrGOxMiA1ay2NCz69EJg2JamCAnwYB7f
         2iQi9vH/jFPV582U/pJEvLeaw97pYVJULOTEhE10b64KpCNHXvzjCh9Vg73o1CBfhE8l
         IK+g==
X-Gm-Message-State: AOJu0YxQeQkQidoJB7UT5HEW62NNIZGMKjqh+osudF5r6tNsJ0FK80h3
	7/jMwEGs1izkEpSv+z9zBUF+CQhiJKuoK2Fk/4wEdkL5wO+O9Hg9FqYbVw==
X-Gm-Gg: ASbGncsetgzIO/98jKGOLkBRZcdeDvLKpyoBeX5HLKLo9XXcTuH1UfjFeICHmvkA3a6
	9oN7xR2gFGSH1bLC5fhhpLjSJQgd/uDHm2Lk45LBPLEUeC15jXnahEuNQotpSHfqarNXaXgO9/q
	Mjq/8Pdvi6u54jWrathsCZMhshhLVzYQLYsY2PZ/bbBYPEGNRp+p5ie3Q9YoHSkGFnZxWobCroF
	Bi9FRCAjCN58Oxsh0GniAwIM6e3WDti8HpKWuuWaZjENXujvf9sU9k4zZExlYRq5ez0nV3Pj3ks
	vH2h9WO1YHj7c4UBQj7UN8bxziCessS+6aV6gp9OJCY6DTALyLwuusy0HYa1
X-Google-Smtp-Source: AGHT+IFCCgENojwKExNPUOi7pb0jasQ7V0qFCK2BEXkomrplo5jrr0kx5huVlFZQF39RWkB2M3oE6A==
X-Received: by 2002:a17:907:7f21:b0:ac1:ea29:4e63 with SMTP id a640c23a62f3a-ad219002422mr593014166b.26.1746879687803;
        Sat, 10 May 2025 05:21:27 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad22abb2f0bsm185542266b.123.2025.05.10.05.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 May 2025 05:21:27 -0700 (PDT)
Message-ID: <1e35dd26-3f10-40b1-b2b4-f72184a26611@gmail.com>
Date: Sat, 10 May 2025 15:21:25 +0300
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
Subject: [PATCH rtw-next v2 1/2] wifi: rtw88: usb: Reduce control message
 timeout to 500 ms
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
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
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


