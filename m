Return-Path: <linux-wireless+bounces-22324-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5643CAA70DC
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 13:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11D09A0B45
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 11:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4629A15C140;
	Fri,  2 May 2025 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ixpppb7/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899EA3D76
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746186547; cv=none; b=FG+d+W0hnOEBrRfuF6YdcyjZRYZjWqr32jCHNccdyYrhdKV026Ga+aZo+UlHmRzOecdKP8GgurEe1pOJTYixihA8uX3gVchfeYT8GAYmvGIjEQjhE8ojcLF4V/YXmnOt8Kee5tdIaR2i3dqZkXdHcZm8A3hZiZkNSckMgdMpbb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746186547; c=relaxed/simple;
	bh=PF4QvOXYtnKxvyiE8J+J2rrQvH4jT+8hVsfCdPzTpWI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=IMt0MsWBtECZwD+dX525zcrHBDv2qCks4vlwAfZJOvsI0cWZRT92MoSPpYrhagJ6ErydgsxpET9z+5vcVkxa//W+GlzlUD6ad7LJUf6HmjlGi3LxtgoR2lIzZGNR9tmSodBgVV7Hw39RiPUs9NAtaSN/3WWOdSurCSL0K5MtJxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ixpppb7/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5f861d16622so3222313a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 02 May 2025 04:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746186544; x=1746791344; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VU0T8HiU4xATyOjzce/z1DVs6p+g0NeyojheO6vIMSI=;
        b=Ixpppb7/Mfz0qGYq1P7JXmsilv3deYPuxrwIBm7XSBBC/lPC34rg2vJ2bTgTpaDUlH
         vrT5zTiBl5khQdyCT2vFqcw/6wKbkDCgktRGWL8f2zo9VqD8arofagfyf5BedZa+gfjE
         dEzFh2sDLGDgp5zQQdh332VVwkS+eu+mtFRAJ3SOMiT9cjFokHpjqbNivKl47n4C3Xq7
         NkHTfkZBKHMeOfqfGnVtNavh5G7okCWEdVR0dxzHcJlEHOTlXIDZj7lImeX5APQ+qrAg
         /p/Su5BXTgWXj40TlYZ8xfjlg1W4M3rDjf1RoHlrltn6PMKoMnjdrXXaYCBmY+a6Lt0E
         WUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746186544; x=1746791344;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VU0T8HiU4xATyOjzce/z1DVs6p+g0NeyojheO6vIMSI=;
        b=GV3Tlldq50DGRIRdyqmsZ7VACfSlDUnQVc9oHS7f6vSg+dAvFLWejqw2FJH20wCa2j
         dQbXX6e4pOqxGW/1l8iNTUhbSHRK7kwLEoHH1aZHU9ljRQM9EUCgc20s/AxvxhI2X1KE
         LWAXCKqkPSegxRLNhBfM70dckpKO2Mh+jS07xdKmU00ZMeM4bvYnZLGWc6Avs9Jm1Knh
         H7zXOifko1iwqS0sgneh5qgetcPoYrLR8WT3At2W/i9I1NtiBnoqv1wesw5fLVgyk4nG
         7vj/kiF6ipUKC9d+1W9WPenwmcsPpFtB/HHw5mZW10UI1SYQqS0vdbLhloKj6qK6jIVK
         fcxA==
X-Gm-Message-State: AOJu0YytJsIRZmVOpNi3eLc29oEx/k3hKWW6kprLzkjqhUlaBqvVonlI
	pFG/vXwG+tMEWn5MJ5+HLDOawS1G2QlwpdNlZXO+k+qIIxs+QuNRmkj1zg==
X-Gm-Gg: ASbGncvywV6gztm5eXcTx4rQHhSZFzNQdeCucq7hznKIfQKswsardMZyrBBmXezaz8N
	OEjb5Le0gADR3W6zS7o2IkP3FZHxbCAz/2I+uEYC2nli5edm6ay7YDo0M4D66Cr2gX4/cR7/V+h
	QuyNmFj/MtJWIEAQhcRl1HPdEDYgXtGYQcdznu2lH03Cb+UvvKz605gtmPpceYZM6wJRVI7b5E1
	paWy54RvpyL2RQuR65HZZY81i8HkPYxOV6SSb7KZzvfAQix3cdj3aPv3Zm56FOI/uwHZX+hx/sb
	vIn0pNzZKnZByhPd7SgBSQ+ndHeEv9hId4R0BZ1vx8r3pUoSJQ==
X-Google-Smtp-Source: AGHT+IFMEQzrbFa875Cz9sFTG3m2LrK7PwxVWqmvwlxuKsgFGsPO+t1PGIkT/hLYCRfERl9PSC9cKg==
X-Received: by 2002:a05:6402:13d0:b0:5f4:d0c3:4dd with SMTP id 4fb4d7f45d1cf-5fa77fd7135mr1795556a12.6.1746186543463;
        Fri, 02 May 2025 04:49:03 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa76f3b9e6sm1142855a12.0.2025.05.02.04.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 04:49:02 -0700 (PDT)
Message-ID: <4c79fdc1-54bc-4986-9931-bb3ceb418b97@gmail.com>
Date: Fri, 2 May 2025 14:49:01 +0300
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
Subject: [PATCH rtw-next v2 1/2] wifi: rtw88: Fix RX aggregation settings for
 RTL8723DS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use the same RX aggregation size and timeout used by the out-of-tree
RTL8723DS driver. Also set mystery bit 31 of REG_RXDMA_AGG_PG_TH. This
improves the RX speed from ~44 Mbps to ~67 Mbps.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Restore the original behaviour for RTL8821A and RTL8812A.
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index c57f683d9af8..71cbe49b6c59 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -677,12 +677,22 @@ static void rtw_sdio_enable_rx_aggregation(struct rtw_dev *rtwdev)
 {
 	u8 size, timeout;
 
-	if (rtw_chip_wcpu_11n(rtwdev)) {
+	switch (rtwdev->chip->id) {
+	case RTW_CHIP_TYPE_8703B:
+	case RTW_CHIP_TYPE_8821A:
+	case RTW_CHIP_TYPE_8812A:
 		size = 0x6;
 		timeout = 0x6;
-	} else {
+		break;
+	case RTW_CHIP_TYPE_8723D:
+		size = 0xa;
+		timeout = 0x3;
+		rtw_write8_set(rtwdev, REG_RXDMA_AGG_PG_TH + 3, BIT(7));
+		break;
+	default:
 		size = 0xff;
 		timeout = 0x1;
+		break;
 	}
 
 	/* Make the firmware honor the size limit configured below */
-- 
2.49.0


