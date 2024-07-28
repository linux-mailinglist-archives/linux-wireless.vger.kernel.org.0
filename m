Return-Path: <linux-wireless+bounces-10586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A710E93E916
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 21:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5629B1F2146C
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 19:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6F8B669;
	Sun, 28 Jul 2024 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHUUV8Vi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68848C06
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jul 2024 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722195680; cv=none; b=r4VfBaCbsKhE39r+bX9arl0cF9YSJpoWvitoyoW8PIhdE/kPtwBTIh0Fp1CiuKzJfcbae3RzAU/EfTjttCnRERjm1zSReDRxydYF51/iyCzLfy34h55JXna5p2gbwJD4TwzKfm7494+SGvBLp3mxdAAqyPf+p2QbY7wulXRH8RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722195680; c=relaxed/simple;
	bh=bT02QokMQ88ULwFLpOxrfE76ODww4/Lu3O4eJwDi32Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aRysMyptFHMNi2GiViQacstOCRMSz6mobDWK5DF0J7gOsOH0zZNMYWgIvIWVOyKrsYRR6syqhOM8fhIxc/hAGnCzjyH8kFlJxpFkahyp5/J+/u356pie0Mz33ntJLlI3qJUM8yi0bunNehz1XtjUkO8P4QkrMyFGDoWWDaLt2Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHUUV8Vi; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso4689871a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jul 2024 12:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722195677; x=1722800477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sjrkjs/+cwpe0x7RH4BvRMc4pac2tBvtqybWn+Umeec=;
        b=gHUUV8Vi7QWTXrjwaeGIAl19qxbwSZC9C8GlMT7miUo+8YyKyPGBgHAXPRJHbahtcY
         XbXIs0WiLvkRQ8mztRulHDmFyXj+y4/9rNbyG/d/erDm47acwbbcTRo+xUambreWcpMY
         2QCzQcT2y5y2ZNF5BtbSn9Bu1swlrS9/7J3MQzUCiuQe4ydd78T9XQFB+7zJwzEcXm0e
         MA97RijWHkcSkpJ1EkLtQ0ksH26VDdHW0/PDcDopZJDRo7SPtPLpONOy9jZpTfMgVDwn
         PC/rrGQ3A478u0/ypfwxVGrvzHg60ZcWl+bP2aATt4CXjhCF2gG2yCm0C2p27jfQey7E
         ddAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722195677; x=1722800477;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sjrkjs/+cwpe0x7RH4BvRMc4pac2tBvtqybWn+Umeec=;
        b=vgzpHWqRyZYNxMyZq7Bp06IMzsvuUw/kc1SK+V0dMsi9WsJYF2q6fBOeq7awyzgUMa
         UVbV9Zy1P025p3Ce2YJNLK7H6bG5XQJm2Et4ojA5DyN3L8T+kP1WmAqB8NKGIQ+er1fY
         4aZjMTvnWssjOFvY6iEAxyTBJcSRZKpJ2wWdI6lwC5zdQ+W3lpAunckEMFc84v1gtq7W
         7512ApqMEoAPRaSN4KxkyGHIx5vUcPAvf+2waN2C6lhqXOwfe2RVsW2GaUJjvswRqZal
         d82jBqDJE6yQPl9J3ayb1qnTZcOk7tVg1kwpH/Wl2MNw1r/XgXq/ae/1XuXtkvetrdhg
         Rx8g==
X-Gm-Message-State: AOJu0YyNo7IMelRlFax69kTT70VDcdej9eIVS1CFHYTUrxU/XWfSGq3g
	bSr/K5yWJ+GYnvXUC656YtYuoteeNNK1T2xK1MF4HAYSIauqYCspR0oMfw==
X-Google-Smtp-Source: AGHT+IEo253fYZ/60SeJNNAuSlBUjXJuzDLDDk8hATChUPHlvPkeLPouAo8vY6C76mmNEv+98TBx9g==
X-Received: by 2002:a50:cd9d:0:b0:5a2:fc48:db12 with SMTP id 4fb4d7f45d1cf-5b020cb9a13mr3303572a12.19.1722195676668;
        Sun, 28 Jul 2024 12:41:16 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63b59aa5sm4744906a12.43.2024.07.28.12.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 12:41:16 -0700 (PDT)
Message-ID: <47a89cd7-7767-4b41-abf4-7197e977b7c4@gmail.com>
Date: Sun, 28 Jul 2024 22:41:14 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/4] wifi: rtw88: usb: Update the RX stats after every frame
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
References: <c03390ce-34c2-42dd-9bd6-b231bb1f2fae@gmail.com>
Content-Language: en-US
In-Reply-To: <c03390ce-34c2-42dd-9bd6-b231bb1f2fae@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Update the number of received unicast data frames and bytes every time
a frame is received. This is what the PCI and SDIO drivers do.

This has an influence on the power saving, bluetooth coexistence, and
(in a future patch) the use of RX aggregation.

Tested with RTL8811CU and RTL8723DU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 251a5726f3ee..73948078068f 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -579,6 +579,7 @@ static void rtw_usb_rx_handler(struct work_struct *work)
 
 		skb_put(skb, pkt_stat.pkt_len);
 		skb_reserve(skb, pkt_offset);
+		rtw_rx_stats(rtwdev, pkt_stat.vif, skb);
 		memcpy(skb->cb, &rx_status, sizeof(rx_status));
 		ieee80211_rx_irqsafe(rtwdev->hw, skb);
 	}
-- 
2.45.2


