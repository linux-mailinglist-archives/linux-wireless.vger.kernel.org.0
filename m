Return-Path: <linux-wireless+bounces-13911-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A95E99ADBE
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 22:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4341C2241C
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 20:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703E01CFED3;
	Fri, 11 Oct 2024 20:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3J8iLRX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57FE199231
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679908; cv=none; b=hhl4MsnnBIgKyMdME2sCz3CLF+mLR0Plcjd1SKa3jB4iW6WhDVqZCYTs/HRxr0WZNxZFUr2VqZlvnvnhGZiFaPGSLgaaRxPx1obOrJ0vivzzYEJoIJ8zP00+ZkajeCROchQMTiU9LW8cRWDputHY951WkKDY0x6Z1g7hKZsXFRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679908; c=relaxed/simple;
	bh=UbA0TywvskXxF+9DKZ6GT/p+Dk/aH8lTYhVcGSQYuEc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ulSbVPWzKw8DkcaaA266TVrSJ4a36cEdzWUkJ/KyeP+xWbTTcoFDYpK5kIJgZuAnemv1VwEMrceE373emauqGLfyY1im9S/dRYwU22v3uN3IVmWkSJKyEhPfUQWx0WfkWuh9O54wbpXtwifhs0zgY9f1JQTy/gdna5Y1WhG18rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3J8iLRX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-431126967d6so20545975e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 13:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728679905; x=1729284705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N4gHsOWopAUyOMIcj4ZxnrWi4bRy89tHLLOXtaS3+Rg=;
        b=m3J8iLRXMJg425bKhKx/cd9LBjYRQ7PrVjniUCRSHdqh7bVQ38CFiHpgRkHMXSwZ5g
         jb3loE2dzVrFwSTkvZV7Q9TGBnWkUgf2r0GCnE5yn/ncBwusFrdewyU/xN578X4O605H
         LYSdCQinPG/WbNNz1XfN8upKM+4g5XH0+PnJTQDSglC9Gezo3LpYHHmU3nkahLvrp0cX
         4dZuym3KD4FOwQ6XRqJcmj86pW200V2yXWejyWn5y3WKGNEjJhpjer/f9p3kMAfO4fxQ
         zIGDDdR+ecUSVCK2Mz2qEYoMvgcaS81chZuYAVHBsQeqfBfRROdNldlKSqbxqR090jpS
         2Q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728679905; x=1729284705;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N4gHsOWopAUyOMIcj4ZxnrWi4bRy89tHLLOXtaS3+Rg=;
        b=NXNVbOP9G20c/VkjOYSof5MhEM2TIWiRB4BP2q8TJKzYUh8/Q+q+yvg4l1cSj4twpz
         zgAVIb3OjwQHIjvLnloOoJmR/q+Ox74IbNgwiqbKywBjmeCGTHmU66T5+J3KvcZ2hEkF
         tNkRZNhjNiUaiiRGVYtUwsiQd7XjR6m52RGvlM+LFbHkkCKXSPli/wmyAU/hDM58YLwh
         NYKLJT5KZqPcQK8dMke+UrsLl2fteupfP2jKcs3ewVxzpL0TAfC7IvFGDw4gooZwNe+N
         L5P0n/K4yVK6Ouymzm8S2mOHWqugn3oe/nAPPDm52ssYihsgV5gznNC5b/4KATgO+FBk
         RReg==
X-Gm-Message-State: AOJu0YyskV7DXC/Twt8l43zTuJ8mY6Lxbq7Wn1LUGjxdCAHVd6Pp+G2X
	wv5SCmJLO+k7HmGs9EQXi0iUqgPguLagFG3om11VmAyZN/LWOak8ZuTqkw==
X-Google-Smtp-Source: AGHT+IGxhE1Cl1RmgUmVjjxB8DRIEcLHSK6wwj7AvB7m71FhU1F5ULTT6EKp3iCiW7/RsIjzrA3R9Q==
X-Received: by 2002:a05:600c:510d:b0:42c:bd4d:e8ba with SMTP id 5b1f17b1804b1-4311ded1c9dmr29928245e9.8.1728679905051;
        Fri, 11 Oct 2024 13:51:45 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d748d421sm83211375e9.42.2024.10.11.13.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 13:51:44 -0700 (PDT)
Message-ID: <92c49ebb-0408-48e7-9025-566ada0197b0@gmail.com>
Date: Fri, 11 Oct 2024 23:51:43 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 11/22] wifi: rtw88: usb: Set pkt_info.ls for the reserved
 page
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Language: en-US
In-Reply-To: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

"ls" meaning "last segment". Without this RTL8812AU can't upload the
reserved page in USB 2 mode. (Somehow it's fine in USB 3 mode.)

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change.
---
 drivers/net/wireless/realtek/rtw88/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index a3d2b40ec67b..6fa3c37205f5 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -478,6 +478,7 @@ static int rtw_usb_write_data_rsvd_page(struct rtw_dev *rtwdev, u8 *buf,
 	pkt_info.tx_pkt_size = size;
 	pkt_info.qsel = TX_DESC_QSEL_BEACON;
 	pkt_info.offset = chip->tx_pkt_desc_sz;
+	pkt_info.ls = true;
 
 	return rtw_usb_write_data(rtwdev, &pkt_info, buf);
 }
-- 
2.46.0


