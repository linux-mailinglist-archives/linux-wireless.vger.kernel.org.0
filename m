Return-Path: <linux-wireless+bounces-29924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D72DECCF7DA
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 11:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57C1C30813CE
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 10:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0EE25DB12;
	Fri, 19 Dec 2025 10:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYJ0Iay9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB581F7916
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 10:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766141503; cv=none; b=PTqq+zo9h9CJ6bEWC4PJzuHIKGT+Q0LJEesx8H62g29wLY0oVGRyVFzqZIFjboCHyA6+YL6pJo71zdIttspansN+wciyrXXma7Sq+ks1ozT6G9MxhP3+EBfm2SDQIgufzGhC7tNBEVAZnZshKLM9cbxrPd51bUdWxY84crXLyek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766141503; c=relaxed/simple;
	bh=V6cSyOIwwDNhIwGrK7ZuWBTVzM3V18BgdnFx4GP2A94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hI/WVTkJWcd9NMD6xSUkqgEuq7e3cHdTfGVzbztY99xLAp9wjr09TZZPpDNVvSvEOMmgoXuMfpAydAPsuiQtkTvteoKVWdNwti5rZVTt7tlKO2mb9K5lkilT3ZGsSP2b2PY8PqOrWZ+/n6xc5S5qTukR+XtNp64CvpvbdnVNMwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYJ0Iay9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477770019e4so14004645e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 02:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766141500; x=1766746300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2aEntp+H3t0PC3zZlw72YZZBufJ6vmr1LZ/xhhZ9ago=;
        b=LYJ0Iay9ZX5xnu3v+uEEHM8R4YfrOsKY+YNgrxZGmiatnjiTB+fT8QmZu+xYt+TYfU
         uZ6XkLoQ5koj5kkM9bWDcThjj/TJlswkaahnIyPMut8eYExAm+9waEERbk8wEU1hjQch
         DLM47kQpU5p5jm2+vL99CUykgo8hEt9f9ANZ5nW2A+4ulsIk6kX9ZJlm/4/sGHCjtVCA
         sCjBVtvRkpdBbRd65wPCVhpsFTdBvwC3XkjBd2P+w9CiDaHhYSnIJnJQcS66Fa1ObwG3
         DXeS8E7TIBTWC9ITGeDeK1agPyYMK+aGY81jh/taA32QIAM6pZ95bXo6/gGLZi7EoLSY
         2MLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766141500; x=1766746300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2aEntp+H3t0PC3zZlw72YZZBufJ6vmr1LZ/xhhZ9ago=;
        b=FbgmRgAQwIGVrgL8XDWb1tzSyczifumbUFTqJ0S7sZFVRBVdKPulbGFa6HboLOGRsV
         YLwoDlnfKBCAUGgbI5XP505WQau2Jb3Se5OOG5lYqu01+HDv960jsbBPU6X1V8z/SDd7
         0JCH7UW2IBRBPuQiMPJWX4doBaZyI+wQjzdyXRRzOpSxwVhz9Mb58AzGbAz09Aykc0ZA
         A8IiXofIFIw8wNlLTpzumkkRHJp9+jDRXBgzuKc4eH6I/rrTDJQgIRiA90qec35Xi6+t
         pUGUid9uU5rE+bfGGYDsM8E3dgQFo8mSUfRPeZA9YEGVdOvqmB0tY/XYefpwh7Y7SQyC
         c6iw==
X-Forwarded-Encrypted: i=1; AJvYcCXuNstCrGdyzFRwWp9QgVMLUi0GlJM6caOlicqoJ08MiPasoLDTXEPotCzpoB2FOL8+IuTRevqOk4+kw8jP2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyINsPrNnA5GdwcBZ+vuA3+A6DoBypSHkzfq7IBsV8J5V4uzAb
	xP5DKoDILPIICgRhdi0Sh5o6S5Qm6E5iGDj+8vHtK9A+3zo3rQ2P/eXfKTcaqg==
X-Gm-Gg: AY/fxX7PSLTgKavmTeOhTsD4FGbN7wiB8qXTJsU/Q17VXIdMJL2dN8Hdjer5h85HkRT
	BscVJra+kmZWOR4sEbHTRcUw38NdgyijDYVoD7FXsAVjH+hxbSO8NhvjGWNPLclAxC1dwYvZAAU
	GERFuqLu5N8DlLcB8krZhmmWrHuIRcyp4Bf/oOOq/AJl3xXmQMGJ/+yUWOVTlTmjxO38QiGpESR
	6jQvy7+Ws7AFXXIKAuarLfYH2UDP0wi0AsSzr04IQ+zS4HpXlgymWHG2W6cOukkkkHhFvF+6m5D
	Ps2THnBJEG/gUVQ0OM5FX6/4LKYf6dLkIJPGSM7plKYQ3wfFZdnrSG2mr8BuggVnFMCWkmO/ypR
	zuQmLZFud4iGpaPhpZFutCNrKwmzLYSFi1vqpcLZZyLoh8OhbrBdTenxZZMw4b6WhVv1Cvb4ycD
	mL6AYefYmRiQknCp9GIXch
X-Google-Smtp-Source: AGHT+IFtOx2HIRN2DYZr+pupZ1v36n/dgywPF9qEqRGrnzCrPjgeMPDPsedf/iJSj2O28BhdhNs5wQ==
X-Received: by 2002:a05:600c:4fce:b0:47a:935f:61a0 with SMTP id 5b1f17b1804b1-47d194c659emr21375595e9.0.1766141500105;
        Fri, 19 Dec 2025 02:51:40 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193e329asm38101855e9.15.2025.12.19.02.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 02:51:39 -0800 (PST)
Message-ID: <fd0e0d09-e220-4465-a80a-b26974602fa9@gmail.com>
Date: Fri, 19 Dec 2025 12:51:37 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v2 10/12] wifi: rtw89: warn unexpected polling
 value of XTAL SI
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Cc: gary.chang@realtek.com, damon.chen@realtek.com, kevin_yang@realtek.com
References: <20251218063117.26278-1-pkshih@realtek.com>
 <20251218063117.26278-11-pkshih@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20251218063117.26278-11-pkshih@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/12/2025 08:31, Ping-Ke Shih wrote:
> XTAL SI is an indirect serial interface to access registers in another
> hardware domain. When BT driver initializes UART interface, firmware might
> rarely control XTAL SI at the same time causing access racing.
> 
> Current is to adjust initialization flow to avoid the racing. To make
> the racing visible if it still presents, add a message to address this.
> 
> USB adapters might be unplugged suddenly, causing flooding messages. Check
> RTW89_FLAG_UNPLUGGED flag to avoid them.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
> v2: handle USB being unplugged case to avoid warnings.
> ---
>  drivers/net/wireless/realtek/rtw89/mac.c    | 31 +++++++++++++++++++--
>  drivers/net/wireless/realtek/rtw89/mac_be.c | 13 ++++++++-
>  2 files changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
> index e5f2fa3b2b37..8987077bf756 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -1483,6 +1483,15 @@ static void rtw89_mac_power_switch_boot_mode(struct rtw89_dev *rtwdev)
>  	rtw89_write32_clr(rtwdev, R_AX_RSV_CTRL, B_AX_R_DIS_PRST);
>  }
>  
> +static int rtw89_mac_pwr_off_func_for_unplugged(struct rtw89_dev *rtwdev)
> +{
> +	/*
> +	 * Avoid accessing IO for unplugged power-off to prevent warnings,
> +	 * especially XTAL SI.
> +	 */
> +	return 0;
> +}
> +
>  static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
>  {
>  	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
> @@ -1497,8 +1506,13 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
>  		cfg_seq = chip->pwr_on_seq;
>  		cfg_func = chip->ops->pwr_on_func;
>  	} else {
> -		cfg_seq = chip->pwr_off_seq;
> -		cfg_func = chip->ops->pwr_off_func;
> +		if (test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags)) {
> +			cfg_seq = NULL;

I just realised, this NULL will be dereferenced in rtw89_mac_pwr_seq().

> +			cfg_func = rtw89_mac_pwr_off_func_for_unplugged;
> +		} else {
> +			cfg_seq = chip->pwr_off_seq;
> +			cfg_func = chip->ops->pwr_off_func;
> +		}
>  	}
>  
>  	if (test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags))
> @@ -7033,6 +7047,12 @@ int rtw89_mac_write_xtal_si_ax(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8 m
>  		return ret;
>  	}
>  
> +	if (!test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags) &&
> +	    (u32_get_bits(val32, B_AX_WL_XTAL_SI_ADDR_MASK) != offset ||
> +	     u32_get_bits(val32, B_AX_WL_XTAL_SI_DATA_MASK) != val))
> +		rtw89_warn(rtwdev, "xtal si write: offset=%x val=%x poll=%x\n",
> +			   offset, val, val32);
> +
>  	return 0;
>  }
>  
> @@ -7056,7 +7076,12 @@ int rtw89_mac_read_xtal_si_ax(struct rtw89_dev *rtwdev, u8 offset, u8 *val)
>  		return ret;
>  	}
>  
> -	*val = rtw89_read8(rtwdev, R_AX_WLAN_XTAL_SI_CTRL + 1);
> +	if (!test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags) &&
> +	    u32_get_bits(val32, B_AX_WL_XTAL_SI_ADDR_MASK) != offset)
> +		rtw89_warn(rtwdev, "xtal si read: offset=%x poll=%x\n",
> +			   offset, val32);
> +
> +	*val = u32_get_bits(val32, B_AX_WL_XTAL_SI_DATA_MASK);
>  
>  	return 0;
>  }
> diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
> index 2bc329c13443..c0204e68c172 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac_be.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
> @@ -396,6 +396,12 @@ int rtw89_mac_write_xtal_si_be(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8 m
>  		return ret;
>  	}
>  
> +	if (!test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags) &&
> +	    (u32_get_bits(val32, B_BE_WL_XTAL_SI_ADDR_MASK) != offset ||
> +	     u32_get_bits(val32, B_BE_WL_XTAL_SI_DATA_MASK) != val))
> +		rtw89_warn(rtwdev, "xtal si write: offset=%x val=%x poll=%x\n",
> +			   offset, val, val32);
> +
>  	return 0;
>  }
>  
> @@ -420,7 +426,12 @@ int rtw89_mac_read_xtal_si_be(struct rtw89_dev *rtwdev, u8 offset, u8 *val)
>  		return ret;
>  	}
>  
> -	*val = rtw89_read8(rtwdev, R_BE_WLAN_XTAL_SI_CTRL + 1);
> +	if (!test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags) &&
> +	    u32_get_bits(val32, B_BE_WL_XTAL_SI_ADDR_MASK) != offset)
> +		rtw89_warn(rtwdev, "xtal si read: offset=%x poll=%x\n",
> +			   offset, val32);
> +
> +	*val = u32_get_bits(val32, B_BE_WL_XTAL_SI_DATA_MASK);
>  
>  	return 0;
>  }


