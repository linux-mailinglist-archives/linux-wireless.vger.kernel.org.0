Return-Path: <linux-wireless+bounces-28681-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40455C40C24
	for <lists+linux-wireless@lfdr.de>; Fri, 07 Nov 2025 17:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86EF9427587
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Nov 2025 16:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1BB26FD84;
	Fri,  7 Nov 2025 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5o3LEgL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9493256C9E
	for <linux-wireless@vger.kernel.org>; Fri,  7 Nov 2025 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531594; cv=none; b=cn+aMujST71/k3Ensm0qDnZF6SnY3faZcheJVwhbSQdbS7zBKySssIQ10DzR6fiW3sUAk9L52Q7NMHc/wh/osuMcEfeK3DdKMiQ4L+ekwHIA+Fr8dmbXQuw7bIYh5P2rr/2S1qiHinnsvU8wRTtmC9HzW4jsb5gPlTAL0YLEafw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531594; c=relaxed/simple;
	bh=jJDksfRG4/U1nDKBjqjn9QYst66E1JkuY/478nkqWnU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QgUqUk+lUUCRFif0UwHHVku5In1HjV88aqwfh4xeyAL49pIrC3WPk3AibxIb6P/shctPzCIXxkurNBLnz5/3ntlOYfnL/JaLHJb2tN5dqc/KXlT6nTrjxg7jzNu3e88dppJ83up8m6xMZhNq2XK+fj6bLx8UaSYP+dZAQmfK3h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5o3LEgL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477632d9326so7356245e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 07 Nov 2025 08:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762531590; x=1763136390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0xGhbTamNcdk5JPCXCF124XWtMbE4m+qRs/aynFPWS8=;
        b=L5o3LEgLdo1zPwmK/A/ppB2mibEisaC5iHzU0EgPodBycC2yyQozQzWOtBjNqSSlca
         XMXuBFQPLKpwNumoglPNkkanG3ah3Il6NrT+yivyE0tyHGDog90xGsYOThNtRfGqDE96
         6A9Cvt0hNAl4W/i/JRKesyub9+IEZMYCZEh3YzvCa4YCDFDFgbhHgZ2zeQc0b7cg2Lb/
         apfd0H2110MIWwX1mLdSR5RyV6UARAsrMZD6yu5wupabp+HaSQ+HTZNsbQVSwQsjC+El
         P0TBn9/DtQ5sn/JjO6urn/z8OOBC9103Y6RS2JAFdqz+Fd/U/LtlciHGRGJpQtFlDXpR
         KQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762531590; x=1763136390;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0xGhbTamNcdk5JPCXCF124XWtMbE4m+qRs/aynFPWS8=;
        b=C3JZm2JomifLT8bxNwjskGSptADFxQ02PUxalBq4SMANYw6VRbbd/I7Jc4pDDmYvl0
         xo4giltD7XIVn4Y2AUfMqqGSgYT8WHeMI3KhBoXGT2M/m72gBCHP+G8hZaTqW+oCnvT8
         ceiYUDvX/ikbvG8+h76kbv+w/b/VIotrb+6IP8lBk2WzIAUqQLFtQJf+rDCxI+UaVtMh
         VmEzqq1mG0JPUF3u7sn/fGMsxP/PUjuxVUyFLq737WE+zcFfxzlXMSfB2H9Oyap4XxO4
         spudVFI+hz6j8HoDflAazasXZBrzAJ/wIgKSAeQGnOILgJL3GFcEhBuyULahjN6rH+r9
         2QBg==
X-Gm-Message-State: AOJu0YwTPuvCxz8o+KrT1HyJGXdzGGlKOmqM6kugIJPSMJRuyhpv49Yk
	LvS9NIut47UR/3oaytIA6tewKjxCpZg8VZkWLzQhYns4MUT1AB6ALvLSQZPNuQ==
X-Gm-Gg: ASbGncv3QcoYgPOJrSUAUiW/dm49JmXYJ3iL/z8WiDMPgWs1ZEk+1NDX94gcQoVVMMD
	z0m8VlkbtUHA0TJtGP7wVUWJG2hTCufPgLa35yLOX0pHS7uhETKTqXYN/kzhP8LbvT4qzbWj1Cb
	3+G6ocsqetYyaUYQtiv2cIKcB0wc5uV8aBT9G2A0ESqHDfxIFIvBHjkEIiT76xyTxPjSdQ1Ejtb
	tmDVrYEkhwN3lvgV4boLJ3lNwTjefGRJWASa30Sd0Qda8t1cXv5AuMyW2w3G6BY6+tOX1xpxgiY
	k+bY/z2arXsVx5C/RZyvmwt0abGj5PoCJNuuZKVv090z8jTKNpWiL21iq3lmjvaHaohPthj1NSy
	dyGpeTpv+QjvYNltwYEuQkQnSV9WnO15a2OGdVnnQPg2X6CguSfBZKslIUsci43hV8g+Lju3pYM
	xFCgHiMjM+AuP1DsbVVOIh0KUDFNL+sw==
X-Google-Smtp-Source: AGHT+IHd5AM1SSWfibj2XkAeICkwWZp4gJUu1zDAFMmwhHN9mhKAy7QyBnzKc4HRW1YwpEKMNO25RQ==
X-Received: by 2002:a05:600c:c8d:b0:477:4483:f491 with SMTP id 5b1f17b1804b1-4776bc96819mr30669745e9.10.1762531589946;
        Fri, 07 Nov 2025 08:06:29 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47764ec7736sm41989345e9.6.2025.11.07.08.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 08:06:29 -0800 (PST)
Message-ID: <dec13310-06eb-429e-acb8-4c5b62656836@gmail.com>
Date: Fri, 7 Nov 2025 18:06:27 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 1/6] wifi: rtw89: Use the correct power sequences for
 USB/SDIO
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <f0021b8c-efc7-4993-b0a8-8954c682d13b@gmail.com>
Content-Language: en-US
In-Reply-To: <f0021b8c-efc7-4993-b0a8-8954c682d13b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Make rtw89_mac_pwr_seq() select the right parts of the power sequences
based on the interface type.

This is only relevant for RTL8852A. The other chips don't use power
sequences.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 0a8474002cb7..e22b5d8c8171 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1295,11 +1295,26 @@ static int rtw89_mac_sub_pwr_seq(struct rtw89_dev *rtwdev, u8 cv_msk,
 static int rtw89_mac_pwr_seq(struct rtw89_dev *rtwdev,
 			     const struct rtw89_pwr_cfg * const *cfg_seq)
 {
+	u8 intf_msk;
 	int ret;
 
+	switch (rtwdev->hci.type) {
+	case RTW89_HCI_TYPE_PCIE:
+		intf_msk = PWR_INTF_MSK_PCIE;
+		break;
+	case RTW89_HCI_TYPE_USB:
+		intf_msk = PWR_INTF_MSK_USB;
+		break;
+	case RTW89_HCI_TYPE_SDIO:
+		intf_msk = PWR_INTF_MSK_SDIO;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
 	for (; *cfg_seq; cfg_seq++) {
 		ret = rtw89_mac_sub_pwr_seq(rtwdev, BIT(rtwdev->hal.cv),
-					    PWR_INTF_MSK_PCIE, *cfg_seq);
+					    intf_msk, *cfg_seq);
 		if (ret)
 			return -EBUSY;
 	}
-- 
2.51.1


