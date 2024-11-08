Return-Path: <linux-wireless+bounces-15153-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7219C26F8
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 22:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC35C284565
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 21:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4870F194082;
	Fri,  8 Nov 2024 21:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRwXDESS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59D5233D80
	for <linux-wireless@vger.kernel.org>; Fri,  8 Nov 2024 21:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731100669; cv=none; b=VdpKLRpTjVm83mPU/8UFHLC+OZe5/fRBaRBhKaAtKQNpW/4KXFiHnIwg4eUefG0eviVBvs72R0iHaJo6OvxUYfSEKxuMk9dwjUChGEclxXQEqgnMQcfQXllrQkgVZ2XoQbdaTQ+UPI7xaQEVwT6JcF2E5jzT9CmydqtH7W68pfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731100669; c=relaxed/simple;
	bh=vKTautb7BtoItacHHGP4UPL23Exm6AduYZ9vnah/mKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WKJ2Hr11iFaGRLCzfr9YGJG5OGORg0K8KDS+3kNiIASVxssvTw4hWisB/OyzTyYpeM4WQsRY/jSTkirJ7ltinX6Xxz4ARXASoqCzaLVdyc6WGVrVW2CO+HUnCAGDoDA0Dp6uJ/VRybiQJ5EIIrv+mFjRvK5aRDb0aHxkD1aleTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRwXDESS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so22368265e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 08 Nov 2024 13:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731100666; x=1731705466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wtx8fyIMlR7LT1BkKTPvGFUa6idCEZ7J3XwzD+mvU7M=;
        b=lRwXDESSgpK141gGbSkY3Ll//+ObBJrptttqPzmQW3ZY2jEklpnzUmcLwRpRHjp0k0
         ynKhASR0dw6KzyrutKRuTdigFJoqU83+szmT0hci1ggb3FaQM2a+sqAWEd/lcCkVkRhs
         UITCPlncSsVzGi9dk4n8l3AmPlzTVy9knn8wMJKHaFlAgb7yWBeZmug/xEd6OwqZUi9g
         zt8s8SQzmLQC6u2gIBqBpI1vRp7g1ADDHjFnGxGOvWahZ+cMfJxGvMa3ySeRDv5vyspq
         NdYdatAJfSg34voh7WXDHBKRx043cgUDLzk1C3fqIkmCDE/eRGm7O9ITKJ+0ZbQgJDfV
         RCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731100666; x=1731705466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wtx8fyIMlR7LT1BkKTPvGFUa6idCEZ7J3XwzD+mvU7M=;
        b=krdJa7JoVNpPw5rlxrFABmg9nEWnBqrjSGbprzIEnLgDzGuFL+8BAPktnGPBjY7GLy
         KhJQXbEX6Jv0rayEEqNtWaBODyDOvRsLsB52HNoYHuO5DniU7+XjFixNLfTM4NAKtNiH
         UygrWRThTNFpD02GTPopd1uR6W//WXfzVzLavMDj8XfNvr9pgQM1XZny3jArDT33GLAG
         pIgQ7IJfCfPHlYOjwofxZDPdNvd8waVAwXUrpAlipdOjAvIsPu8cN6AKcRrC66utpdtb
         vtFa4Dga3hjKACwQLn+c3o4LTUzvCOTc3GY5wPJniilIj8gReChSToJx3qhQrb11OP+e
         derw==
X-Forwarded-Encrypted: i=1; AJvYcCUzowX60MbiRBIvrQwlR6cCgnLUl39BxzlrUIV7O/IBgYtC0eRdbSXF0Pow4j/KN5+FcJS3vAxoGo6lJvwpkA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2YrFVE528TTyt50aTKLqGqvHf4WjZzmvALXGqbUm/PI+DITbV
	f5Q/+DRs8G9eRk3GbDs4Z9da6KmNVTYXy/A+apTNv5AJI+Jp5eXU
X-Google-Smtp-Source: AGHT+IHnxVL7lP13p+w+ihNSHHtQtaiU0gFTXq4d5fwTkPmuHsVEoWU+pA4HTT+PP9CN+ZVP062Vwg==
X-Received: by 2002:a05:600c:a384:b0:431:588a:44a2 with SMTP id 5b1f17b1804b1-432bb2402fbmr21973735e9.12.1731100665808;
        Fri, 08 Nov 2024 13:17:45 -0800 (PST)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432bbf436ffsm17627565e9.44.2024.11.08.13.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 13:17:45 -0800 (PST)
Message-ID: <ae457b1c-82a6-41b2-a001-be0a2b2389c9@gmail.com>
Date: Fri, 8 Nov 2024 23:17:43 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtl8xxxu: Enable AP mode for RTL8192CU (RTL8188CUS)
To: Ezra Buehler <ezra@easyb.ch>, linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>,
 Martin Kaistra <martin.kaistra@linutronix.de>,
 Johannes Berg <johannes.berg@intel.com>,
 Reto Schneider <reto.schneider@husqvarnagroup.com>,
 Ezra Buehler <ezra.buehler@husqvarnagroup.com>
References: <20241108195511.1338147-1-ezra@easyb.ch>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20241108195511.1338147-1-ezra@easyb.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/11/2024 21:55, Ezra Buehler wrote:
> From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> 
> This has been tested on the AT91SAM9G25-based GARDENA smart Gateway
> which uses an RTL8188CUS (product ID 0x8176).
> 
> Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> ---
> 
> Note that I was not able to figure out how many clients the RTL8192CU
> and similar can actually handle, 127 is a wild guess.
> 

I looked into that once and found that the old 8192cu and 8723au
drivers have a limit of 32 macids.

rtl8xxxu_fill_txdesc_v1() and rtl8xxxu_update_rate_mask() should
fill the macid for AP mode to work well. Otherwise the firmware
will not use the right TX rates for each connected client. It goes
in the lowest 5 bits of tx_desc->txdw1 and h2c.ramask.arg.

I tried AP mode in July 2023 and found that the TX speed was less
than 10 megabits/second. In station mode it was at least 40.
I didn't investigate more. How is the speed for you?

> 
>  drivers/net/wireless/realtek/rtl8xxxu/8192c.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8192c.c b/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
> index 0abb1b092bc20..72918fe621fa1 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
> @@ -644,6 +644,8 @@ struct rtl8xxxu_fileops rtl8192cu_fops = {
>  	.rx_agg_buf_size = 16000,
>  	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc32),
>  	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc16),
> +	.supports_ap = 1,
> +	.max_macid_num = 128,
>  	.max_sec_cam_num = 32,
>  	.adda_1t_init = 0x0b1b25a0,
>  	.adda_1t_path_on = 0x0bdb25a0,
> --
> 2.43.0


