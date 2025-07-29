Return-Path: <linux-wireless+bounces-26048-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153C0B153C3
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Jul 2025 21:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C286562539
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Jul 2025 19:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CD81E25F8;
	Tue, 29 Jul 2025 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwknOKXV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704B0239E81;
	Tue, 29 Jul 2025 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818275; cv=none; b=rUWHXkxwrm5N6qV8ejTPOZzOadpHKeXRDx7sewEf8J0AJ1JT9fHl7wQ580rtSws9Z6YoNReQx+1anDeB3qZN+1VLbmfqE+3EvAWc/FwPGWNQIh3N1Z0ekLUPWDgFA6EFqNuBkN1GeholxuaW9akG+4NcXCKD/0XAga65bHKBh8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818275; c=relaxed/simple;
	bh=t5rBEPy8lyRXVnt8hpZYd6LYWIoFVy22g9IXu7rHQZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqp5mLkcfBoTv0+uF9aAmQSBZVKzLCEahWPxES9ofhnXqsqtOsKpdssiEN0Fdg9I595CJZIRcpGRmKMoAl952VOv2ZQPBbe6BZSG7YJnvsYkI4M1WpwjxaR1EmoLVJAJYDaszTXKCvPGAAGR9d7W4zTd+ccHRRKtqTiCmjR8XWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwknOKXV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-456108bf94bso32741665e9.0;
        Tue, 29 Jul 2025 12:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753818271; x=1754423071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i6WRel8vteowVQsID2OZy9WxilgTBD0nyTvxuC5AojI=;
        b=HwknOKXVOcWN+bBFzC2CDwq/9j6TvtE5OzmXcfclIo/dmMTb5GEGOn2nhZ3hNN6OZ3
         enTrSTix5AhUSK/13NcjkAYhDjyQftl/wE9s/bm7C+lm5ve4IymcqopVCPAwslrrlqJK
         1t1nJOBeY3jVqsKLPtIlggRxZedBLgRaUmAkl5fZFFUb58WSZqY1aKNhRdNIKUm8Laq4
         qOkCvZZb/Ab5p4GlC1UxDzpYluY3YLz6+T+YNBcuMwxUi3xkf2w3YumIvTYP1Q7UR2hV
         YPkQ6y6LB3lJrkvHJTu9r88dGQc5kDW5/+pV9uVmaHz4ywTlmIvYD8GJxVLc/R1t/NjM
         1NVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753818271; x=1754423071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6WRel8vteowVQsID2OZy9WxilgTBD0nyTvxuC5AojI=;
        b=azpNTSy8acyVYd+X361SPXIdGkZtBaCyD9X0IGMwjDckR2wVUkSONdQNf0UlrxB56K
         nHnY+z+l6ouPDewhWPI1z1MShI74IOJ+zutTIpmGbfy0yCnMuWBGDSzVZisNl2WTBVbt
         Bkw0euHBXGHetQlra7bEP/VlnVBu7YitId+ZnUGO5v6SGwTZLn5jwOqtph6SErtzZP7n
         YSOtGCWf3gmwCQt4u7VTbfT5yGZZTijqJgwRJD5Z+MeGfbEga0PWa+/slAJviXSbdmKK
         sUbMZRYAr2PKOrkabDjnT/IN5nb+aKZ/HA6P008IDCvmN4wMeCHRREt1XgI6s9PrNq5p
         MRhA==
X-Forwarded-Encrypted: i=1; AJvYcCVlBAY/jHPvRqWpnDQA5SWwcPsgft489uTjWS6RWXuCJBcUyuego+0HbN2p4v1B4xgFGVKHxeCIq415M38aaw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1mm9aQST/yQTDHo0YckQzBqeuEJhEZ0Lk/Pb+kuSR3z29Zq1k
	cuYtEQ1ZLqGBCrhm6aWCfEZ6FnY1GBqnJlzbZgWurOEskFpzQ39KQffG2rbqdw==
X-Gm-Gg: ASbGncvI/0lLan+GY7SMVl0i6yfsaziB1iGiI8etEvv+1/3AcKDa7ZpoAJvbTJx8gqj
	ovRZ7bTjsRI1Rk+7E6YqTUSz1W1CntjZWfkudyvLZq4ibfmeR41fIU+EwGol+mt++IRpka9ChPG
	+LDBBK5AOM2o8IYkAP4Wva/w+Qtr2u3ZHBtG6Xr7DgDplAZQruSvkY3QStdM/i8tGj/ljnezFYS
	mhIKmRY2taJXSbRPWtV0I2foDTA0jm/L9swBou8qyzUEhw2r0kAYzuvyCMIJhAMCiidydW/XYns
	zBd1+LCt3aPRiSy4WoOnW+hD4isMPF98DjE8Q6FTAa3zjZ8I8MVJKIhIpS7XjAjrbxz6KeieizA
	GNrnayscoWdFo9qajgM3gEcMxuC1uMw==
X-Google-Smtp-Source: AGHT+IFU29dRiRxSRID6Xbo4H8eFoYhiPevioddhqBZiIFbq3Gsf5fWcrl3Vu6i7dfMaQ7WxB5AdcA==
X-Received: by 2002:a05:600c:1c20:b0:456:2d06:618a with SMTP id 5b1f17b1804b1-45892bc7929mr9402185e9.18.1753818271281;
        Tue, 29 Jul 2025 12:44:31 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f04744sm12868602f8f.54.2025.07.29.12.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 12:44:30 -0700 (PDT)
Message-ID: <d2d62793-046c-4b55-93ed-1d1f43cff7f2@gmail.com>
Date: Tue, 29 Jul 2025 22:44:29 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtw89: Print only once for unsupported c2h classes
To: Sean Anderson <sean.anderson@linux.dev>, Ping-Ke Shih
 <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20250729182743.114733-1-sean.anderson@linux.dev>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20250729182743.114733-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/07/2025 21:27, Sean Anderson wrote:
> There are more unsupported functions than just LOWRT_RTY. Improve on
> commit 3b66519b023b ("wifi: rtw89: phy: add dummy c2h handler to avoid
> warning message") by printing a message just once when we first
> encounter an unsupported class. This prevents messages like
> 
> rtw89_8922ae 0000:81:00.0: PHY c2h class 2 not support
> 
> from filling up dmesg.
> 

I also get "MAC c2h class 1 func 3 not support" and "MAC c2h class
0 func 6 not support" with RTL8832CU.

The second one appears a lot in AP mode.

> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>  drivers/net/wireless/realtek/rtw89/phy.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
> index f4eee642e5ce..5280ffd77b39 100644
> --- a/drivers/net/wireless/realtek/rtw89/phy.c
> +++ b/drivers/net/wireless/realtek/rtw89/phy.c
> @@ -3535,6 +3535,7 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
>  {
>  	void (*handler)(struct rtw89_dev *rtwdev,
>  			struct sk_buff *c2h, u32 len) = NULL;
> +	static DECLARE_BITMAP(printed_support, U8_MAX);
>  
>  	switch (class) {
>  	case RTW89_PHY_C2H_CLASS_RA:
> @@ -3549,17 +3550,15 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
>  		if (func < ARRAY_SIZE(rtw89_phy_c2h_rfk_report_handler))
>  			handler = rtw89_phy_c2h_rfk_report_handler[func];
>  		break;
> -	case RTW89_PHY_C2H_CLASS_DM:
> -		if (func == RTW89_PHY_C2H_DM_FUNC_LOWRT_RTY)
> -			return;
> -		fallthrough;
>  	default:
> -		rtw89_info(rtwdev, "PHY c2h class %d not support\n", class);
> +		if (!test_and_set_bit(class, printed_support))
> +			rtw89_info(rtwdev, "PHY c2h class %d not supported\n",
> +				   class);
>  		return;
>  	}
>  	if (!handler) {
> -		rtw89_info(rtwdev, "PHY c2h class %d func %d not support\n", class,
> -			   func);
> +		rtw89_info(rtwdev, "PHY c2h class %d func %d not supported\n",
> +			   class, func);
>  		return;
>  	}
>  	handler(rtwdev, skb, len);


