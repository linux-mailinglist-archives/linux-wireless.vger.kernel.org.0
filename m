Return-Path: <linux-wireless+bounces-16510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B44409F59E1
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 23:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99892188ECE7
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 22:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547701DFD91;
	Tue, 17 Dec 2024 22:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/tGWuEt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD4A155CB3
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 22:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734475998; cv=none; b=ZjtVgWifriv9DjZxaui0aandQ6UwLUujI6XWZ6/3vOlwArEBkWUisLVsEX4TwRJL5K1BHIyvavckVdHFi0wcyQGl/av82UdCXpm+etC9LXRwl2SWx9T+0bskoYYwVw1iAzXkxyHf33rwytyz+YjeT+bb8lor11UacoJDHdDnsRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734475998; c=relaxed/simple;
	bh=Xl+PzgEth6aB2C+yrz/45dzzqRyVaahpfjhGj+cUX7w=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=P1uNfQuJgaERYSdnKAoPJmVCcNA/nJbkXGfZ8mrQBPJflUpPnoCzBARVbT+tKEEpaNGaB1xoSSxSfBsasrBnT5B6AC8WTxqvULJQcLlWbKauiy4EmIHHgFqSuFAvRIUIW05/FKISM+Mopy6AzaHiR6dHLTwoGVD2JGRuk+0PcKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/tGWuEt; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aab9e281bc0so607125266b.3
        for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 14:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734475995; x=1735080795; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJgcL0J1KPHBlPFkJwqqwpw2wPZqsZ9g4xy0UKAYgms=;
        b=b/tGWuEtasf37x/OW6AnX3gMy2ri8mmOW8qwGIlsJ3GWwcxJuIyF5zKDtVbWMgX0mh
         vXZnCWjsfHaR8sryKIVTinXmeKGTHHKHe/fQnhP6ZfXq5gD8jpcf2c52zvB4s3Gi5qBK
         l2hsqK2UK0YmtoxGxOp5hFJsv/LUglOkO1ljrAawjKFqv1JeGC5sqUO3Iy+07P2E9g2J
         u0KRHxBkym0j5mshZkqZ5BfBVJwxfA/eiAQH7maDibyacfBGvwWZrq0/GiZqJNPmfIci
         JRSBYVumrrKbmgTPHcaYTleUBZv5B7UFtc4Fdtf79OW0QaaDWmB1Qe6r56/vGVGCtquX
         wFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734475995; x=1735080795;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eJgcL0J1KPHBlPFkJwqqwpw2wPZqsZ9g4xy0UKAYgms=;
        b=sxN7vn5xF3rmRSJ390FoCNNB9x/Ksl3n9+WUeNWwmzThAxUc95aU1vjfzBE8ZOY6Vf
         7JGaD1vXxATF17iiUJjr3TQj2tisI33I+x+V4LnX4euDhYpHo2l3MWIXkf0dgJLygTPb
         7zlh8unfyLxJQH0LJOT4yMz7S6Tgx0bl1BMUKqMSh9M6In40kCaQmSS+uw35nTH9xfS2
         tmZwQUL/wz5Eo0bn189v56cHeszzOqaP0YlGfnRJjR6DzwojYQR1PTiq7pFFDGRUuHPm
         Omxl2GsLjmseD7QDirVBx4YI0gWwA6h9y7urzx3tCSDc3SAZv2+fcOnCqJ27sUZhIh1y
         YIYQ==
X-Gm-Message-State: AOJu0YxWst2jerM/TNF2MFtw6tEKh34YlYu2a7WX50C+0wSAjFc6i3nu
	ty5psDijBnyEfh0+b7xqwI+BGI58W5c55iLO6cFG7TUjS3eqVud9/0ZbUA==
X-Gm-Gg: ASbGncszBeWPxjstTjCyp98SB/S/epDQ2bgX4K0yDho8yx4hMwylr4vNrQvOCODoDb5
	7/xobqc6baN3S/m7NTXZ2MaVcufnPwWFqsds5wLF159734W3KPzFKqcjeDZJZBM0942WJAH/ETP
	ZsD+UICl3v1pB1CY4U5MsKZNXTBKmck/Km8ZPVyHqmrjVq4VfSB2Vo5LypnH+wPRS10/TQAADHT
	nmhS94AU3bgSgJWXwLcfb9V/No71Il+/mmm7hXjyFR/6vyhQU1Zf6VCymhfuKnw
X-Google-Smtp-Source: AGHT+IGO+n8jCcxgMeoCY8ZUnsmIvWt8Jm9x1i+Eb/O/1ZAGBiJtKXVZNpMA7PHLSUJm4ejMNva5Kg==
X-Received: by 2002:a17:906:30c3:b0:aa6:8f71:1645 with SMTP id a640c23a62f3a-aabf4902d54mr42486566b.55.1734475994554;
        Tue, 17 Dec 2024 14:53:14 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.78])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ab5077sm4767971a12.17.2024.12.17.14.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 14:53:13 -0800 (PST)
Message-ID: <754785b3-8a78-4554-b80d-de5f603b410b@gmail.com>
Date: Wed, 18 Dec 2024 00:53:11 +0200
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
Subject: [PATCH] wifi: rtlwifi: rtl8821ae: Fix media status report
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8821AE is stuck transmitting at the lowest rate allowed by the rate
mask. This is because the firmware doesn't know the device is connected
to a network.

Fix the macros SET_H2CCMD_MSRRPT_PARM_OPMODE and
SET_H2CCMD_MSRRPT_PARM_MACID_IND to work on the first byte of __cmd,
not the second. Now the firmware is correctly notified when the device
is connected to a network and it activates the rate control.

Before (MCS3):

[  5]   0.00-1.00   sec  12.5 MBytes   105 Mbits/sec    0    339 KBytes
[  5]   1.00-2.00   sec  10.6 MBytes  89.1 Mbits/sec    0    339 KBytes
[  5]   2.00-3.00   sec  10.6 MBytes  89.1 Mbits/sec    0    386 KBytes
[  5]   3.00-4.00   sec  10.6 MBytes  89.1 Mbits/sec    0    386 KBytes
[  5]   4.00-5.00   sec  10.2 MBytes  86.0 Mbits/sec    0    427 KBytes

After (MCS9):

[  5]   0.00-1.00   sec  33.9 MBytes   284 Mbits/sec    0    771 KBytes
[  5]   1.00-2.00   sec  31.6 MBytes   265 Mbits/sec    0    865 KBytes
[  5]   2.00-3.00   sec  29.9 MBytes   251 Mbits/sec    0    963 KBytes
[  5]   3.00-4.00   sec  28.2 MBytes   237 Mbits/sec    0    963 KBytes
[  5]   4.00-5.00   sec  26.8 MBytes   224 Mbits/sec    0    963 KBytes

Fixes: 39f40710d0b5 ("rtlwifi: rtl88821ae: Remove usage of private bit manipulation macros")
Cc: stable@vger.kernel.org
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.h b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.h
index c269942b3f4a..af8d17b9e012 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.h
@@ -197,9 +197,9 @@ enum rtl8821a_h2c_cmd {
 
 /* _MEDIA_STATUS_RPT_PARM_CMD1 */
 #define SET_H2CCMD_MSRRPT_PARM_OPMODE(__cmd, __value)	\
-	u8p_replace_bits(__cmd + 1, __value, BIT(0))
+	u8p_replace_bits(__cmd, __value, BIT(0))
 #define SET_H2CCMD_MSRRPT_PARM_MACID_IND(__cmd, __value)	\
-	u8p_replace_bits(__cmd + 1, __value, BIT(1))
+	u8p_replace_bits(__cmd, __value, BIT(1))
 
 /* AP_OFFLOAD */
 #define SET_H2CCMD_AP_OFFLOAD_ON(__cmd, __value)	\
-- 
2.47.1


