Return-Path: <linux-wireless+bounces-25655-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B691B0A0CA
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 12:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EFD11AA1CBC
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 10:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD9F29E0F5;
	Fri, 18 Jul 2025 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MEGDTNK7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ABE198A2F
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752835025; cv=none; b=NGtEMKlMGfXZCEP2JXwADQE10lKQPVdNtKgkhJWl4JeiQ+TsEucvyvbR4sX39t0dQXJ71XpMErcxpn4klE9sQnM+xhtC9GBfmls2uat63KYkmA+RxOQ0sVAGZY4j6FhmZXwROTVocMjM3vkqsq7S9yNg10Z5crOodB5+GnLrCSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752835025; c=relaxed/simple;
	bh=o7AiU/V34b0UGWXaW0uOVGBXivX7HWYrqo4HOg5hGI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a2q24BocEdMEvZCepqQBI5L2cD68Ve/vG0Adyj31t8Xkp/0pryP8V2aqFVxf/M1YY2Y1O7ivVCm8PXixgB93js1xB7qOebaieNLAXtaF8YBRHrdssQOSoG+V/SFe2fLaH8L0rcsHzQLe7CJQ4LQtwrBT+l18y3A0yI2wJDYnLgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MEGDTNK7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45618ddd62fso20757615e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 03:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752835022; x=1753439822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=be2WTQLsa5uvXybUvNfmScdP010rblWY6zgN5KBpjt0=;
        b=MEGDTNK7wnRBjnR5CJsIk8UQBa5WAY7ZzNrh14dFymaIHTme90Ovv5HuxQON/qlWpV
         9Bx6HAqyhYXA2IPMN8sKKfEx9/ZbeHyI3/wnjPyA/byyoj8YKPX4Hl3FImCREXeKLa4/
         E6TluHT52LATVutAa0nnIMlkfGMQqGvNS+RDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752835022; x=1753439822;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=be2WTQLsa5uvXybUvNfmScdP010rblWY6zgN5KBpjt0=;
        b=Ytdw+UdgmTTuJIfETWtLoYEsZumGceIvsvAn0K9zgkuSmnEi5xpeB1VcyMS8WSl5HV
         BPhmeXPXsgoECz3MsvOtSF8pz5iOl+N9p6rjskoqjhRmj4t4S6ScnYeoQpNYbDLvgkvM
         aFnLpyZwvT8QecXy1O5wCyxnFDCMolpf5gy9TzHH46FAYuTNTXmjb8gbGBN5nXk9ha02
         8FAs5MzwjHLRYVqSEQKmX2kl1yirh+lo1PsTKq89nHzjmWoxRc0vj8IE9oLjFKvk5fDS
         rCt2Rx2pH89AMTfyHyO979AxJ/wBrF2xwcIUDYJIrL8nKGEXWfScNJqKupxaHH5P3XoD
         +6ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/BqKhB8BPNZTYCUdzhL4ZQbci0NSwXCwj1Yreed5Y+Ho0fUK+Ak5FSndwNXc6pamK8cWrzNNCaVCh36mJNg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3epaWV1GxBk3MbCzsSWOiPC6Y5u8bUemkNXllm6AqMzqvi/+Y
	0KHzgZgecxA4I31Oo0htT1GZ4Wb+K5HObds7Tp4Y2E/MXWGXEuElpZ2WuQhHPTJDGg==
X-Gm-Gg: ASbGncuGJgUPLQmqO7IQvjZw0GNjm8vcFJ/vtQHV+xVBm/CqWZ0wGBIgberZ0PC6duk
	jl675SG9IZWjD2ZIL6auhVrHV3nUnX+erp5vfno7o1NjbHE5TQftkZiRVOpTa3dN83r+ywdzAHl
	PeignjpNbS/N5Ax0ltQ3qCIbTcPk7ephUh42lf5SZbGLepICb39ZusFM41uMgUSOrNEIQOJMv1a
	TSCqSruUBbo2nV5UY7ewgS3mtOYl4BX8bB3DrTKf/d9oPX4RUCNxM/dAIoEmt1N9LG62EhQKAVO
	Th+y0EKqz2NAIo+o+9u7Fhl5FWkwhNZ71TCW902AqHUrH7sQRtynuvuZykqCJ/8+wfDZqmcnquK
	5MLTPP4QXQKtr4eHZNSiPRMwFWMX9SpRz1/lO3KlSEqPWh9dNzgM=
X-Google-Smtp-Source: AGHT+IGaw18z6ZbgBi879Fyj3WOC2+vT3XshuuU7f+qrvOz7x5pcOoeAvZ79K/rtNQcSabe8GjOYiA==
X-Received: by 2002:a05:600c:4688:b0:456:a1b:e906 with SMTP id 5b1f17b1804b1-4562e3cbb03mr85040605e9.33.1752835022389;
        Fri, 18 Jul 2025 03:37:02 -0700 (PDT)
Received: from [10.229.41.1] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2ba0asm1461626f8f.21.2025.07.18.03.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 03:37:01 -0700 (PDT)
Message-ID: <f58ac73c-4d9d-4382-8bdb-65ac40ee529c@broadcom.com>
Date: Fri, 18 Jul 2025 12:37:00 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] wifi: brcm80211: Use min() to improve code
To: Qianfeng Rong <rongqianfeng@vivo.com>, Wentao Liang <vulab@iscas.ac.cn>,
 Johannes Berg <johannes.berg@intel.com>,
 Sai Krishna <saikrishnag@marvell.com>, Ondrej Jirman <megi@xff.cz>,
 Jacobe Zang <jacobe.zang@wesion.com>, Kalle Valo <kvalo@kernel.org>,
 Dmitry Antipov <dmantipov@yandex.ru>,
 "open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS"
 <linux-wireless@vger.kernel.org>,
 "open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS"
 <brcm80211@lists.linux.dev>,
 "open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS"
 <brcm80211-dev-list.pdl@broadcom.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20250715121721.266713-1-rongqianfeng@vivo.com>
 <20250715121721.266713-5-rongqianfeng@vivo.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 xsFNBGP96SABEACfErEjSRi7TA1ttHYaUM3GuirbgqrNvQ41UJs1ag1T0TeyINqG+s6aFuO8
 evRHRnyAqTjMQoo4tkfy21XQX/OsBlgvMeNzfs6jnVwlCVrhqPkX5g5GaXJnO3c4AvXHyWik
 SOd8nOIwt9MNfGn99tkRAmmsLaMiVLzYfg+n3kNDsqgylcSahbd+gVMq+32q8QA+L1B9tAkM
 UccmSXuhilER70gFMJeM9ZQwD/WPOQ2jHpd0hDVoQsTbBxZZnr2GSjSNr7r5ilGV7a3uaRUU
 HLWPOuGUngSktUTpjwgGYZ87Edp+BpxO62h0aKMyjzWNTkt6UVnMPOwvb70hNA2v58Pt4kHh
 8ApHky6IepI6SOCcMpUEHQuoKxTMw/pzmlb4A8PY//Xu/SJF8xpkpWPVcQxNTqkjbpazOUw3
 12u4EK1lzwH7wjnhM3Fs5aNBgyg+STS1VWIwoXJ7Q2Z51odh0XecsjL8EkHbp9qHdRvZQmMu
 Ns8lBPBkzpS7y2Q6Sp7DcRvDfQQxPrE2sKxKLZVGcRYAD90r7NANryRA/i+785MSPUNSTWK3
 MGZ3Xv3fY7phISvYAklVn/tYRh88Zthf6iDuq86m5mr+qOO8s1JnCz6uxd/SSWLVOWov9Gx3
 uClOYpVsUSu3utTta3XVcKVMWG/M+dWkbdt2KES2cv4P5twxyQARAQABzS9BcmVuZCB2YW4g
 U3ByaWVsIDxhcmVuZC52YW5zcHJpZWxAYnJvYWRjb20uY29tPsLBhwQTAQgAMRYhBLX1Z69w
 T4l/vfdb0pZ6NOIYA/1RBQJj/ek9AhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQlno04hgD/VGw
 8A//VEoGTamfCks+a12yFtT1d/GjDdf3i9agKMk3esn08JwjJ96x9OFFl2vFaQCSiefeXITR
 K4T/yT+n/IXntVWT3pOBfb343cAPjpaZvBMh8p32z3CuV1H0Y+753HX7gdWTEojGWaWmKkZh
 w3nGoRZQEeAcwcF3gMNwsM5Gemj7aInIhRLUeoKh/0yV85lNE1D7JkyNheQ+v91DWVj5/a9X
 7kiL18fH1iC9kvP3lq5VE54okpGqUj5KE5pmHNFBp7HZO3EXFAd3Zxm9ol5ic9tggY0oET28
 ucARi1wXLD/oCf1R9sAoWfSTnvOcJjG+kUwK7T+ZHTF8YZ4GAT3k5EwZ2Mk3+Rt62R81gzRF
 A6+zsewqdymbpwgyPDKcJ8YUHbqvspMQnPTmXNk+7p7fXReVPOYFtzzfBGSCByIkh1bB45jO
 +TM5ZbMmhsUbqA0dFT5JMHjJIaGmcw21ocgBcLsJ730fbLP/L08udgWHywPoq7Ja7lj5W0io
 ZDLz5uQ6CEER6wzD07vZwSl/NokljVexnOrwbR3wIhdr6B0Hc/0Bh7T8gpeM+QcK6EwJBG7A
 xCHLEacOuKo4jinf94YQrOEMnOmvucuQRm9CIwZrQ69Mg6rLn32pA4cK4XWQN1N3wQXnRUnb
 MTymLAoxE4MInhDVsZCtIDFxMVvBUgZiZZszN33OwU0EY/3pIgEQAN35Ii1Hn90ghm/qlvz/
 L+wFi3PTQ90V6UKPv5Q5hq+1BtLA6aj2qmdFBO9lgO9AbzHo8Eizrgtxp41GkKTgHuYChijI
 kdhTVPm+Pv44N/3uHUeFhN3wQ3sTs1ZT/0HhwXt8JvjqbhvtNmoGosZvpUCTwiyM1VBF/ICT
 ltzFmXd5z7sEuDyZcz9Q1t1Bb2cmbhp3eIgLmVA4Lc9ZS3sK1UMgSDwaR4KYBhF0OKMC1OH8
 M5jfcPHR8OLTLIM/Thw0YIUiYfj6lWwWkb82qa4IQvIEmz0LwvHkaLU1TCXbehO0pLWB9HnK
 r3nofx5oMfhu+cMa5C6g3fBB8Z43mDi2m/xM6p5c3q/EybOxBzhujeKN7smBTlkvAdwQfvuD
 jKr9lvrC2oKIjcsO+MxSGY4zRU0WKr4KD720PV2DCn54ZcOxOkOGR624d5bhDbjw1l2r+89V
 WLRLirBZn7VmWHSdfq5Xl9CyHT1uY6X9FRr3sWde9kA/C7Z2tqy0MevXAz+MtavOJb9XDUlI
 7Bm0OPe5BTIuhtLvVZiW4ivT2LJOpkokLy2K852u32Z1QlOYjsbimf77avcrLBplvms0D7j6
 OaKOq503UKfcSZo3lF70J5UtJfXy64noI4oyVNl1b+egkV2iSXifTGGzOjt50/efgm1bKNkX
 iCVOYt9sGTrVhiX1ABEBAAHCwXYEGAEIACAWIQS19WevcE+Jf733W9KWejTiGAP9UQUCY/3p
 PgIbDAAKCRCWejTiGAP9UaC/EACZvViKrMkFooyACGaukqIo/s94sGuqxj308NbZ4g5jgy/T
 +lYBzlurnFmIbJESFOEq0MBZorozDGk+/p8pfAh4S868i1HFeLivVIujkcL6unG1UYEnnJI9
 uSwUbEqgA8vwdUPEGewYkPH6AaQoh1DdYGOleQqDq1Mo62xu+bKstYHpArzT2islvLdrBtjD
 MEzYThskDgDUk/aGPgtPlU9mB7IiBnQcqbS/V5f01ZicI1esy9ywnlWdZCHy36uTUfacshpz
 LsTCSKICXRotA0p6ZiCQloW7uRH28JFDBEbIOgAcuXGojqYx5vSM6o+03W9UjKkBGYFCqjIy
 Ku843p86Ky4JBs5dAXN7msLGLhAhtiVx8ymeoLGMoYoxqIoqVNaovvH9y1ZHGqS/IYXWf+jE
 H4MX7ucv4N8RcsoMGzXyi4UbBjxgljAhTYs+c5YOkbXfkRqXQeECOuQ4prsc6/zxGJf7MlPy
 NKowQLrlMBGXT4NnRNV0+yHmusXPOPIqQCKEtbWSx9s2slQxmXukPYvLnuRJqkPkvrTgjn5d
 eSE0Dkhni4292/Nn/TnZf5mxCNWH1p3dz/vrT6EIYk2GSJgCLoTkCcqaM6+5E4IwgYOq3UYu
 AAgeEbPV1QeTVAPrntrLb0t0U5vdwG7Xl40baV9OydTv7ghjYZU349w1d5mdxg==
In-Reply-To: <20250715121721.266713-5-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/2025 2:16 PM, Qianfeng Rong wrote:
> Use min() to reduce the code and improve its readability.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>> 
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c      | 5 +----
>   .../net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c    | 6 ++----
>   2 files changed, 3 insertions(+), 8 deletions(-)

