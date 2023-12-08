Return-Path: <linux-wireless+bounces-581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C08280A896
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 17:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51BFF1F21083
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 16:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6110532C9B;
	Fri,  8 Dec 2023 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOshdzg0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A77E19A1
	for <linux-wireless@vger.kernel.org>; Fri,  8 Dec 2023 08:17:07 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b2e330033fso1643661b6e.3
        for <linux-wireless@vger.kernel.org>; Fri, 08 Dec 2023 08:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702052226; x=1702657026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KqLOEpU6i4cWRcRsrFgCO2vfOp2+vlSaElORfK5x/U0=;
        b=WOshdzg02Xe+Ky0tInrvKWzX1SYqh/v1JvSOLh1euF+r73MUzkwHgBYYDRG43yr8xI
         TtsfAW/OSvCwStqWVEnHL04nkMfPRK8hXQyrbG3oBHWYN6yUajaTL0UfORbaMGswBsvw
         JRncjACCcKoF6OGuYVIPhC3ft2GNM50wGow/Lrk4EG7I78IOuExeLk+o6jrcUh2RkwHW
         brj2UHm9Ulk/V2/HdJZ1A0S3RgNC9wwfiZt51f+1mAmrfEOet44u7kyvZaHzzGYj1I+A
         1gQBsSy0ayHWVbtzfUHxg+ivfpnsnzcZ1g9cqCpJsa/2Ex7oqMOY/uhH51oYyyMl7EkN
         EV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702052226; x=1702657026;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqLOEpU6i4cWRcRsrFgCO2vfOp2+vlSaElORfK5x/U0=;
        b=ehHpJqqogvfbpISJpXjqtbIRjZhTQoH+Qxm0yIvyMXXpS41CoL2WnNTmrQ0hNR+b7C
         CU3qI3lG1YDQ9m6miscjTCWhD/QsEjTIU6010YyNDPEoJYKisQQo5ivLgn6K10zQu6g+
         HFHxVpr8pRCjIRrwx42QrfBptZysY6jIAVYAQTwvvb3nZ73NtnwXp36nk45DWzTcV9U2
         LIrCm/bHGRcUxKmE+awy/n6hrqNlIcAR/hqv0apNMtcAFqptFeI8cp/0ohne36/zyCur
         MJCm1iH+mP7cSIm3+eLQv3P7+xizaT3cOk5Tc3Vghc0gGN8WFZtHczJN8OC4kNWCXXlI
         pidw==
X-Gm-Message-State: AOJu0YxA8QZc/N9GxWgWJdZX81CNvXnRm6kAMyd+tScdl/R+2BzFEs+C
	LL97JXO31KfbnyF+s5NYGz0=
X-Google-Smtp-Source: AGHT+IG4sr9MT5uLtSNCeutocxvyLl866UcYhYsyd1mAAzM+J+CYq5JnVmS7goeseEQVn5T/hciTRA==
X-Received: by 2002:a05:6870:f806:b0:1fb:75a:de79 with SMTP id fr6-20020a056870f80600b001fb075ade79mr358489oab.103.1702052221818;
        Fri, 08 Dec 2023 08:17:01 -0800 (PST)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id qb7-20020a056871e78700b001fac77ee907sm455790oac.33.2023.12.08.08.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 08:17:01 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <c06e862c-e5b7-4459-aaed-4f69c3881b84@lwfinger.net>
Date: Fri, 8 Dec 2023 10:17:00 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtw88: Use random MAC when efuse MAC invalid
Content-Language: en-US
To: Chris Morgan <macroalpha82@gmail.com>, linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org, pkshih@realtek.com,
 Chris Morgan <macromorgan@hotmail.com>
References: <20231208150739.129753-1-macroalpha82@gmail.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20231208150739.129753-1-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/8/23 09:07, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> When the MAC address read from the efuse data is invalid, warn the
> user and use a random MAC address instead.
> 
> On a device I am currently using (Anbernic RG-ARC) with a rtw8821cs
> the efuse appears to be incompletely/improperly programmed. The MAC
> address reads as ff:ff:ff:ff:ff:ff. When networkmanager attempts to
> initiate a connection (and I haven't hard-coded a MAC address or
> set it to random) it fails to establish a connection.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>   drivers/net/wireless/realtek/rtw88/main.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
> index 4a33d2e47f33..6d22628129d0 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> @@ -2008,6 +2008,11 @@ static int rtw_chip_efuse_info_setup(struct rtw_dev *rtwdev)
>   	efuse->ext_pa_5g = efuse->pa_type_5g & BIT(0) ? 1 : 0;
>   	efuse->ext_lna_2g = efuse->lna_type_5g & BIT(3) ? 1 : 0;
>   
> +	if (!is_valid_ether_addr(efuse->addr)) {
> +		eth_random_addr(efuse->addr);
> +		dev_warn(rtwdev->dev, "efuse MAC invalid, using random\n");
> +	}
> +
>   out_disable:
>   	rtw_chip_efuse_disable(rtwdev);
>   

Reviewed by Larry Finger <Larry.Finger@lwfinger.net>

Thanks for this patch.

There are a number of SDIO devices known to me with improperly coded EFUSE 
values. It seems that RTW8723DS chips perform poorly even when given a valid MAC 
address. Is this also true for RTW8821CS chips?

Larry


