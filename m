Return-Path: <linux-wireless+bounces-13729-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D29A995709
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 20:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC83028B273
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 18:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90155213EC0;
	Tue,  8 Oct 2024 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArCuS6i2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C59212D17
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728413047; cv=none; b=OCdgwaAHhJvMkkR3+hubpcwhjaXfDZXEq6nDZW2KBkA+gTS1vn7Uir9G0PGjjUNd5SR4tmlrAVDV365W1uTPfyZlqvwn/41IhhQU+fySgFVkpI6/3Q7Cu0byiwGCeBAs7hhbYy6KUWM8ZL3haRGMy+7QU33CR9s4SkbuBgji9Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728413047; c=relaxed/simple;
	bh=Bq5zgCFmXLsJ3LuovW+5SV+B/UZh2uEIGdjhroPlaU4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=m9tW06Vr2TuwNtS37Zp04mmATFbIJ3Bo8Vrm92LRePSvPq69hIHiIAVL9eOUkazk0VQLKPkRSD5U7BOVs9X4NCH+C4n3V3gMGXEiCUELkIHanFVpG9UX30pZQ0TtsSKNMInRqANiOSc1CMd20yxsBGWlhyct3NwVHIHJuPtPY9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArCuS6i2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d39d9f782so59376f8f.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Oct 2024 11:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728413044; x=1729017844; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oY8qdbIaD4fQpJpbCqFCi211KMLt3iwhBJ5vOh1d3g4=;
        b=ArCuS6i2htiQTIHDoXKflneghi9GZeexKzVuXOnAytr0hE70rWc89zrreUQd8FCiaZ
         Bh546kaIhimU9718yG5iobAYMogW0N9iSW/iAENFuoQMxuWjHyXLcBxBDuM2wTOI9+Wl
         NfvKbvyRQX7lJ7z/gdllZ0+B//CnKfd0NIOqqdqqt1kmDBfZAQW81cIvOlVcv0lhlTRM
         SCi1agscTaVImDy79CQCUrXs80Pb1/mwDFnRAhl0EvHr9YWp6RPedALGL+wIYOm9HXB/
         x5fGJJz9tRRrB6vj+zhuscP+bLLAKCXj+RtiFBGwpnC8w0zYaceNiyYXAQ2ChLN6avTy
         DOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728413044; x=1729017844;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oY8qdbIaD4fQpJpbCqFCi211KMLt3iwhBJ5vOh1d3g4=;
        b=qrgxxzkWeFjTxWS+P28XC9wIBzlRriD2LbG4sgTw7o4dld4Ffg9PPRFWlahnHDLLVW
         YW1j+mm2tfDmJUnMK9Mo5K+8zxIeHrHFjK+lYw86ZKRyJUUzHwXtgXp5imHTQIgMzz4a
         8IWSypR3gFN90WkxF2HHAbINRkEzZAJ/4pboRWs00O/+eo/zYhJbCkKt0enKMqXHLyu4
         L5QYkK43rvJdsf7hdywIikzr7RfPJbPP9qGC6OMvRkxmqZW83DNbplSAUqflm3Niv7YT
         D0qjucWLksj8ztNU2pcc91WIB2ZeyrjaMBkDTR4oCQDyfyNcvAMBep3ZXyMAWdveCC62
         N1mw==
X-Gm-Message-State: AOJu0Yw4m75jYnUq+GkrR6pe+JXtg51IAcGrzfqkqkn+Osz64SFUJik+
	LC+IpmzGnNF+BvJNWbZ6ozuTB4dd+B76gcnsm2lA+fXZZgLjaYQRHBzp+A==
X-Google-Smtp-Source: AGHT+IFUeLvaiLNpwsJlilxrYkY5ll0P7tI03s3Kjno95xAMwdNmRLFuM4uGOfGcBdp2ZyquG8iOMg==
X-Received: by 2002:a5d:5108:0:b0:37c:d522:af6d with SMTP id ffacd0b85a97d-37d0eb1ae9fmr8430975f8f.58.1728413043672;
        Tue, 08 Oct 2024 11:44:03 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f1dasm8761444f8f.6.2024.10.08.11.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 11:44:03 -0700 (PDT)
Message-ID: <afb94a82-3d18-459e-97fc-1a217608cdf0@gmail.com>
Date: Tue, 8 Oct 2024 21:44:02 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtw88: Fix the RX aggregation in USB 3 mode
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8822CU, RTL8822BU, and RTL8821CU don't need BIT_EN_PRE_CALC.
In fact, RTL8822BU in USB 3 mode doesn't pass all the frames to the
driver, resulting in much lower download speed than normal:

$ iperf3 -c 192.168.0.1 -R
Connecting to host 192.168.0.1, port 5201
Reverse mode, remote host 192.168.0.1 is sending
[  5] local 192.168.0.50 port 43062 connected to 192.168.0.1 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  26.9 MBytes   225 Mbits/sec                  
[  5]   1.00-2.00   sec  7.50 MBytes  62.9 Mbits/sec                  
[  5]   2.00-3.00   sec  8.50 MBytes  71.3 Mbits/sec                  
[  5]   3.00-4.00   sec  8.38 MBytes  70.3 Mbits/sec                  
[  5]   4.00-5.00   sec  7.75 MBytes  65.0 Mbits/sec                  
[  5]   5.00-6.00   sec  8.00 MBytes  67.1 Mbits/sec                  
[  5]   6.00-7.00   sec  8.00 MBytes  67.1 Mbits/sec                  
[  5]   7.00-8.00   sec  7.75 MBytes  65.0 Mbits/sec                  
[  5]   8.00-9.00   sec  7.88 MBytes  66.1 Mbits/sec                  
[  5]   9.00-10.00  sec  7.88 MBytes  66.1 Mbits/sec                  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.02  sec   102 MBytes  85.1 Mbits/sec  224             sender
[  5]   0.00-10.00  sec  98.6 MBytes  82.7 Mbits/sec                  receiver

Don't set BIT_EN_PRE_CALC. Then the speed is much better:

% iperf3 -c 192.168.0.1 -R    
Connecting to host 192.168.0.1, port 5201
Reverse mode, remote host 192.168.0.1 is sending
[  5] local 192.168.0.50 port 39000 connected to 192.168.0.1 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  52.8 MBytes   442 Mbits/sec                  
[  5]   1.00-2.00   sec  71.9 MBytes   603 Mbits/sec                  
[  5]   2.00-3.00   sec  74.8 MBytes   627 Mbits/sec                  
[  5]   3.00-4.00   sec  75.9 MBytes   636 Mbits/sec                  
[  5]   4.00-5.00   sec  76.0 MBytes   638 Mbits/sec                  
[  5]   5.00-6.00   sec  74.1 MBytes   622 Mbits/sec                  
[  5]   6.00-7.00   sec  74.0 MBytes   621 Mbits/sec                  
[  5]   7.00-8.00   sec  76.0 MBytes   638 Mbits/sec                  
[  5]   8.00-9.00   sec  74.4 MBytes   624 Mbits/sec                  
[  5]   9.00-10.00  sec  63.9 MBytes   536 Mbits/sec                  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   717 MBytes   601 Mbits/sec   24             sender
[  5]   0.00-10.00  sec   714 MBytes   599 Mbits/sec                  receiver

Fixes: 002a5db9a52a ("wifi: rtw88: Enable USB RX aggregation for 8822c/8822b/8821c")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
The code in the official drivers is a little broken. It sets
BIT_EN_PRE_CALC and then immediately unsets it. I didn't notice that
before.

Maybe this should go to kernel 6.12, if it's not too late. Commit 002a5db9a52a
("wifi: rtw88: Enable USB RX aggregation for 8822c/8822b/8821c") first appears
in 6.12.
---
 drivers/net/wireless/realtek/rtw88/usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 10b840d59ebd..74ee5bdbb036 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -772,7 +772,6 @@ static void rtw_usb_dynamic_rx_agg_v1(struct rtw_dev *rtwdev, bool enable)
 	u8 size, timeout;
 	u16 val16;
 
-	rtw_write32_set(rtwdev, REG_RXDMA_AGG_PG_TH, BIT_EN_PRE_CALC);
 	rtw_write8_set(rtwdev, REG_TXDMA_PQ_MAP, BIT_RXDMA_AGG_EN);
 	rtw_write8_clr(rtwdev, REG_RXDMA_AGG_PG_TH + 3, BIT(7));
 
-- 
2.46.0

