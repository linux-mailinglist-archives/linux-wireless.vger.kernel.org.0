Return-Path: <linux-wireless+bounces-16512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 818489F5B2F
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 01:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF820165F03
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 00:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D8D4A3C;
	Wed, 18 Dec 2024 00:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRRESnWu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3981D19A
	for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 00:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734480976; cv=none; b=EqQLu+30x2J7id9zbcoYHi+gIQYUdGezdiRV8TwlJT+fPY20Kd+Yyj7SpOXTyjNneiz06gWflM2+1wUwfG3euBAjGgik88V/V6cekIuJx6CVvBGQ95EPrNj6NbV7Qt46YEBFaSlz8tR7s+HnFG03FgqkyG3HRlEpsT0Z6dktg0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734480976; c=relaxed/simple;
	bh=77M9jMyTPC4IBu+J8InyLl02268tH8lGOTLa5nkZLUk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o1LDZBmiDNg5P+jIsawLA4VPjq6vU6sBd+UfJTG3e4UCCY/2zGFoLQpi36wZFxDydm8ayw7rYim0YvtAgl59eqdFIWe6rU91bSvMTySy2sMwib8XaKRAtvVM62ywuoJH7DwEu5Nt0HLo5P1dkfFL04EssgW8s7y99kQaLxQWO1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRRESnWu; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3e6274015so10241561a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 16:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734480973; x=1735085773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tFg+yTUmdm8c/I6+IE1t2ognBZtimaCAaDr6L/gSWPw=;
        b=GRRESnWuFOeIC4YECOJji+eg8lNerox0KtBFKLRxykiHmx6jzQsStzdsdIy4at09Lv
         vvyKhTk6MebhKMqt+u10dTMCIO+wmQEreHO4tH6vhjPMC8LANUYRA0T/lGChdEsZtq4u
         34Rhqnhnk68SOTG+w6IMSFFtRgwTVR2MTr0sL0nIAGnvGW3piuGDNXhIL28GH3yYaOwP
         5snLDp30LwKhJkVjusxZjtUk7z8VltNRC3PNZTNXHhgFHZwqrSKsiZcjB69UeDR7FX5y
         43qZU4MmsRUuMkUuPowRR6AG7+oWrjZAD5MWZpP8cwzlLXMX7G/lX1tHFDux8Hmv7Hwt
         i56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734480973; x=1735085773;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFg+yTUmdm8c/I6+IE1t2ognBZtimaCAaDr6L/gSWPw=;
        b=VXppxGIWmq/JiqhwHBnxQDXizDyCtNW82ZQsPVkeY9H8XF3J4eLS5U1/aBGPNr4TtQ
         6aKeqRoCBEIhK2ipMqqrx+4qrYpO19GXSYn/R2/wX1SqQ/gkIXk+Sb6Qcab8JV971K0o
         BYPU6WycVLiP0KGt5w2xsZ3F+6i2maDVtYvUCWpWXOrjDx6kKatRu4rAfyNJPBizGCwT
         MFnrZNo3ZIedv0YPRE3voP8rp+wRy2pX9yF0Bh1jotJmoXB1lEb/fLgUvG4qfetiplJx
         FJ+ZgqbsMj8z/JgLmbbYsHQt/Y6QFb7WaH6AX9Wrt/xggn0ZzbV8Re/vmtHbz9HZQBZT
         nO6w==
X-Gm-Message-State: AOJu0YwiN+hD+MMq0rOheRf8nvJVaMT8lqIglQ4wQmXwQSc+EnH4ng0D
	QVsFHXoXm8E6cg+eqI3OY2sn97KBdcqTrDDIeqRjdeAk7FIfvT2vXa476Q==
X-Gm-Gg: ASbGncvkAx4kdqrD3CF65PPKUkV09pdO3KkllmjstJNVXTCuDkVibRrNN2X7HR7500F
	YXGGKZpls3zFOn6QhqrFvzlwTRInLgnZpe0NQJhAbd0P0hmVLfSarz76dX4N3OfSzzplf/b9YSa
	RC+C+2hFs7ysHY5zzaAtsvbaykTJhNzCT8EnUKmTChqoUqPp8UauXxGdjOwuruWCUMR2voHLvBw
	ZQQ+uokbXAbBy2UJdEAWR079v4Fon6lD8dGl7aMwpj4fAlP2sZRkALK2xFtOHqN
X-Google-Smtp-Source: AGHT+IHd5TYU0EGOAIdpHbL84pRPNqb+lLh92th3jhCgQYcNALp+ukVbFqPsRDNz4Z6uvqnCOA56zw==
X-Received: by 2002:a17:906:730a:b0:aa6:2c18:aaa2 with SMTP id a640c23a62f3a-aabf47a6402mr51690466b.27.1734480973204;
        Tue, 17 Dec 2024 16:16:13 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.78])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96005f73sm496644466b.4.2024.12.17.16.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 16:16:12 -0800 (PST)
Message-ID: <1a477adb-60c3-463c-b158-3f86c94cb821@gmail.com>
Date: Wed, 18 Dec 2024 02:16:11 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] wifi: rtw88: 8821a/8812a: Set ptct_efuse_size to 0
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <2917c7fc-6d88-4007-b6a6-9130bd1991e5@gmail.com>
Content-Language: en-US
In-Reply-To: <2917c7fc-6d88-4007-b6a6-9130bd1991e5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Some RTL8812AU devices fail to probe:

[   12.478774] rtw_8812au 1-1.3:1.0: failed to dump efuse logical map
[   12.487712] rtw_8812au 1-1.3:1.0: failed to setup chip efuse info
[   12.487742] rtw_8812au 1-1.3:1.0: failed to setup chip information
[   12.491077] rtw_8812au: probe of 1-1.3:1.0 failed with error -22

It turns out these chips don't need to "protect" any bytes at the end of
the efuse.

The original value of 96 was copied from rtw8821c.c.

No one reported any failures with RTL8821AU yet, but the vendor driver
uses the same efuse reading code for both chips.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8812a.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821a.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8812a.c b/drivers/net/wireless/realtek/rtw88/rtw8812a.c
index d8f0ed70777f..21795286a1a0 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8812a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8812a.c
@@ -1027,7 +1027,7 @@ const struct rtw_chip_info rtw8812a_hw_spec = {
 	.rx_buf_desc_sz = 8,
 	.phy_efuse_size = 512,
 	.log_efuse_size = 512,
-	.ptct_efuse_size = 96 + 1, /* TODO or just 18? */
+	.ptct_efuse_size = 0,
 	.txff_size = 131072,
 	.rxff_size = 16128,
 	.rsvd_drv_pg_num = 9,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821a.c b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
index db242c9ad68f..dafab2af33bc 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
@@ -1118,7 +1118,7 @@ const struct rtw_chip_info rtw8821a_hw_spec = {
 	.rx_buf_desc_sz = 8,
 	.phy_efuse_size = 512,
 	.log_efuse_size = 512,
-	.ptct_efuse_size = 96 + 1, /* TODO or just 18? */
+	.ptct_efuse_size = 0,
 	.txff_size = 65536,
 	.rxff_size = 16128,
 	.rsvd_drv_pg_num = 8,
-- 
2.47.1


