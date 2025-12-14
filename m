Return-Path: <linux-wireless+bounces-29736-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC66CBC139
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Dec 2025 23:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E8393004520
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Dec 2025 22:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425172494FE;
	Sun, 14 Dec 2025 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtqhApte"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692EC25A359
	for <linux-wireless@vger.kernel.org>; Sun, 14 Dec 2025 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765751530; cv=none; b=PbhQfgN3oOmnqCYsKH9JsrK1QX6F3lSucFe6fPWrS5PWO8h5F3Zilgkh8IlPYxz21m2wAHCot5/ovg41s+EcOAw3OwACFrTZM/77/1M5fC3BvoZyJnzrUuH78+L16qY3ERY2BEmflS2di/TsdvWinUP2GHD3wJILsUd8fU6P6Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765751530; c=relaxed/simple;
	bh=XWRN9Lu5HkG56t12j0inScxWHR33I+1yBiScjTM7es0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=stmwjOHwwcyIW/QoRUJJp+oLdn2ywUp7nQg1SzhuOyzo6p96Xxm69mu+86MJ1pFQoexXKJjPI3/ViLOebWWAw1stAmutqWx2mGbPvFt1G04J+OUFsR1+cbOZbpFh1jLhZlNGv82Ny+/ZMux+WwyfrwFER4knqJVofP9nxptd/EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtqhApte; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so32314725e9.2
        for <linux-wireless@vger.kernel.org>; Sun, 14 Dec 2025 14:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765751527; x=1766356327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=METaqTSgSoom9qZ9BplLmwb9BKc7d/+64iFqrjJD6ao=;
        b=AtqhAptePL1/R9HgAic81W2ZsKBdytR74VnDlH4EAjvmBimN11dmc3A1gJ1Qxt/BTK
         7ATFOiFKg8WCWhNeJkuBFcnHNcDlWAzGLviyFljELWZIDNV2F8nQkwUa9ZyLFIEBpVLm
         lbJbC6fiyxZBUTd9h/H0CwnAtFoWFhN90Qd0IW+KTwpOFHaZmVWSijs6/jd6F9/GLnj4
         pWKZpe2jvk0C5sGrumCUve5LHUquCmA4g9vHRi2ft0mbTbHfSdbJWC06yGKeiK+5yH+j
         q+NLz2hWgZ4jFXO7HEzVDzsW1LXp3K/BsOQL5uZoyt6YVLeHnzGxDpSBBRJ5Y/vXzaHB
         lPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765751527; x=1766356327;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=METaqTSgSoom9qZ9BplLmwb9BKc7d/+64iFqrjJD6ao=;
        b=reB00eqRVBtIAsEX6rjFOyXtAdUqOTDr9BjnOiDhpV3SVa51Et4avTCeTWOPOo92qu
         Mp2RccHiqiguBgWxdiIRDKASqEMAtV06i+VlEQ34Ju/ducqSht/rfWgLoVqF+wA6bcYL
         V09apA4aroUFnsb8e2tjRXjrZmxY1IUmEAHZOizXr+VnhmPl+8KhMNF0SamHZYax0TSH
         7FJPvCR9NpFauU26gFrxuWwOoAMz3ITWFRu1UQYuGjgN003EiX5vp9H04AmozHo7YDe4
         wxKpUQzbNZaza1whgL3732bPhxx7bJqGuSrk+WYy3lKx+zcZmyRcMr5gkS/VOx3VhcC6
         VqhA==
X-Forwarded-Encrypted: i=1; AJvYcCUEt5xNX5FmyxucbNzTJ7FLwsBd8WVM4nc2zzkHmkWG8wsvtkONnwD6iz6SX4uyC/J318vm1Nol28Mkmw5YvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAV1SFoYcQREg1CaWgl5OPIieoYaR++dEEndKIs8UxF++OkjKR
	89NFWx+Lrn+OpDhpzkedxdtTojWOVcme1epX+BTZodqpTJuIguBwF/Aj
X-Gm-Gg: AY/fxX4duSnxj6DM5oNIgzYjkNdEp6ul0AQgWaUGsHJuXBVKUvt4yObTHExtvkE361M
	oLIJsBkILLsEYzQhqPgSaIuOzoR8siDf7a7lqds43XnEbP8/MRxPyEVERyeXeYQ91pMKj+eGz4s
	GUb1WIrVwX2lQYPUU81f/IT2mlraW+0xLqqD/w4BNXK5F5qfCGiyYEvi3SMJ6GuCbIKlqGeOhTb
	z9L0Yc9grcZsjdoSvtrH0hyV5JskWRTlsTKj/Yq88FxBASbSgqQIpbhZricPHK0A540ZL4n4sZR
	+jTAqNbUvZvg2YNz1cocB6o2rKA/qMooYiuBS14mxT1ETQgPWmVssTUGM5P2uktXILs1RGOY3JA
	YjY8dB0OkFnYiShd8LYjj3KVrxmOfFC2ub+fOnkIqwWZ+PUzI8Gbja/0StS0eGxyclyYeqFFWYw
	wNP/Ul9FYrYSp4x5sPNM1W
X-Google-Smtp-Source: AGHT+IHdO7wexURdZxqfdAecf1uwBbN3T0FiVjZcWpRkDtre+VqW1u1OAE5uVA6pCIP08Hj7uKuOAw==
X-Received: by 2002:a05:600c:530c:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-47a8f91289emr110717115e9.32.1765751526596;
        Sun, 14 Dec 2025 14:32:06 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f8d9d63sm154490325e9.9.2025.12.14.14.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Dec 2025 14:32:06 -0800 (PST)
Message-ID: <fffdce20-1cc0-4e51-babf-2a759ed37444@gmail.com>
Date: Mon, 15 Dec 2025 00:32:04 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next 10/12] wifi: rtw89: warn unexpected polling value
 of XTAL SI
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Cc: gary.chang@realtek.com, damon.chen@realtek.com, kevin_yang@realtek.com
References: <20251212031303.19882-1-pkshih@realtek.com>
 <20251212031303.19882-11-pkshih@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20251212031303.19882-11-pkshih@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/2025 05:13, Ping-Ke Shih wrote:
> XTAL SI is an indirect serial interface to access registers in another
> hardware domain. When BT driver initializes UART interface, firmware might
> rarely control XTAL SI at the same time causing access racing.
> 
> Current is to adjust initialization flow to avoid the racing. To make
> the racing visible if it still presents, add a message to address this.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw89/mac.c    | 11 ++++++++++-
>  drivers/net/wireless/realtek/rtw89/mac_be.c | 11 ++++++++++-
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
> index cf36be167162..066c99f3e53a 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -7023,6 +7023,11 @@ int rtw89_mac_write_xtal_si_ax(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8 m
>  		return ret;
>  	}
>  
> +	if (u32_get_bits(val32, B_AX_WL_XTAL_SI_ADDR_MASK) != offset ||
> +	    u32_get_bits(val32, B_AX_WL_XTAL_SI_DATA_MASK) != val)
> +		rtw89_warn(rtwdev, "xtal si write: offset=%x val=%x poll=%x\n",
> +			   offset, val, val32);
> +

This message appears several times after I unplug a USB adapter:

[  +0.834445] rtw89_8851bu 1-2:1.2: xtal si write: offset=90 val=10 poll=0
[  +0.000015] rtw89_8851bu 1-2:1.2: xtal si write: offset=90 val=0 poll=0
[  +0.000007] rtw89_8851bu 1-2:1.2: xtal si write: offset=90 val=0 poll=0
[  +0.000004] rtw89_8851bu 1-2:1.2: xtal si write: offset=80 val=0 poll=0
[  +0.000005] rtw89_8851bu 1-2:1.2: xtal si write: offset=90 val=80 poll=0
[  +0.000005] rtw89_8851bu 1-2:1.2: xtal si write: offset=90 val=0 poll=0
[  +0.000004] rtw89_8851bu 1-2:1.2: xtal si write: offset=90 val=0 poll=0

>  	return 0;
>  }
>  
> @@ -7046,7 +7051,11 @@ int rtw89_mac_read_xtal_si_ax(struct rtw89_dev *rtwdev, u8 offset, u8 *val)
>  		return ret;
>  	}
>  
> -	*val = rtw89_read8(rtwdev, R_AX_WLAN_XTAL_SI_CTRL + 1);
> +	if (u32_get_bits(val32, B_AX_WL_XTAL_SI_ADDR_MASK) != offset)
> +		rtw89_warn(rtwdev, "xtal si read: offset=%x poll=%x\n",
> +			   offset, val32);
> +
> +	*val = u32_get_bits(val32, B_AX_WL_XTAL_SI_DATA_MASK);
>  
>  	return 0;
>  }
> diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
> index 2bc329c13443..d75c55cc34b8 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac_be.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
> @@ -396,6 +396,11 @@ int rtw89_mac_write_xtal_si_be(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8 m
>  		return ret;
>  	}
>  
> +	if (u32_get_bits(val32, B_BE_WL_XTAL_SI_ADDR_MASK) != offset ||
> +	    u32_get_bits(val32, B_BE_WL_XTAL_SI_DATA_MASK) != val)
> +		rtw89_warn(rtwdev, "xtal si write: offset=%x val=%x poll=%x\n",
> +			   offset, val, val32);
> +

Same here:

[Dec14 18:42] rtw89_8922au 2-4:1.0: xtal si write: offset=90 val=10 poll=0
[  +0.000009] rtw89_8922au 2-4:1.0: xtal si write: offset=90 val=0 poll=0 
[  +0.000005] rtw89_8922au 2-4:1.0: xtal si write: offset=90 val=0 poll=0 
[  +0.000005] rtw89_8922au 2-4:1.0: xtal si write: offset=80 val=c6 poll=0
[  +0.000004] rtw89_8922au 2-4:1.0: xtal si write: offset=81 val=c6 poll=0
[  +0.000005] rtw89_8922au 2-4:1.0: xtal si write: offset=90 val=80 poll=0
[  +0.000005] rtw89_8922au 2-4:1.0: xtal si write: offset=90 val=0 poll=0 
[  +0.000003] rtw89_8922au 2-4:1.0: xtal si write: offset=90 val=0 poll=0 
[  +0.000004] rtw89_8922au 2-4:1.0: xtal si write: offset=e0 val=2 poll=0 
[  +0.000003] rtw89_8922au 2-4:1.0: xtal si write: offset=e0 val=0 poll=0 
[  +0.000004] rtw89_8922au 2-4:1.0: xtal si write: offset=90 val=0 poll=0 
[  +0.000003] rtw89_8922au 2-4:1.0: xtal si write: offset=90 val=0 poll=0 

>  	return 0;
>  }
>  
> @@ -420,7 +425,11 @@ int rtw89_mac_read_xtal_si_be(struct rtw89_dev *rtwdev, u8 offset, u8 *val)
>  		return ret;
>  	}
>  
> -	*val = rtw89_read8(rtwdev, R_BE_WLAN_XTAL_SI_CTRL + 1);
> +	if (u32_get_bits(val32, B_BE_WL_XTAL_SI_ADDR_MASK) != offset)
> +		rtw89_warn(rtwdev, "xtal si read: offset=%x poll=%x\n",
> +			   offset, val32);
> +
> +	*val = u32_get_bits(val32, B_BE_WL_XTAL_SI_DATA_MASK);
>  
>  	return 0;
>  }


