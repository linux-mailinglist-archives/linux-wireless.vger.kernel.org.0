Return-Path: <linux-wireless+bounces-25654-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7D7B0A0B3
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 12:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E894E0F03
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 10:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5BD198A2F;
	Fri, 18 Jul 2025 10:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FGPwPmmx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16202EAE3
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834677; cv=none; b=Uuck+Zm6CoUFvIWp2t9sLgLjEfwKmKCkcVf8qGIX3BL+EQlpLnFDsHosWSbYeCkIg+ewEqmG7TBFnmYc1g+++Bmr553an3pdhuO15Y0V79P601tODFOQdfr967l2Lx/HBvnec1AgZN1Gx/LzR9q4OushFLupNCbhL22zpo39Vw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834677; c=relaxed/simple;
	bh=WWg6MBGv38Tm36mwG/FuPlXOO0l9S5FTb8TXeTWet6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+RAdxZOlOzaCKXqtEU3k3XIYZg2qrsdzkAAfBGU1QHe9O4OIoQk+j6mRvS6bfGN7qTFBcGfnltCfJEo3ava3MX9a4CZ4iMa2IDxBd89GnpbU6i1xonwP4mz7UAB9w6rWkWqzuPoT2y/D2UdOUfFMRLOmh/izeIqVyiQOEluxU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FGPwPmmx; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ab53fce526so28556621cf.2
        for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 03:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752834675; x=1753439475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R9WPk8aPKLe1G69XM4dNOt8IpjWfnNfoYmOHm3WzbAY=;
        b=FGPwPmmxu1J+/+8elic+OdEAZsWjPmfV8uqfmUqHhMmH9Ra1ZJgGDoixT+zKMqCz3U
         aSb8g98yebR2SKLEZUX3rRRkoDWOLPmSYtPiJVJ/R0UPhgPeBKjQuWIMq9k2F4ABEU9G
         5qKFoUcHbuYwSTn4uXSD4FNzzMj3WnZoySZN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752834675; x=1753439475;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9WPk8aPKLe1G69XM4dNOt8IpjWfnNfoYmOHm3WzbAY=;
        b=azxgudrlqXaxe6Szz2DAc+UPrAS7dffF3AO3q43loqL61xR1bNR1WRYOmo8VbCUt33
         sebsge9xHQFZlNhn5yLngoJEqXdqIlq9zC7qbVYkUT2UNmiEpS8G4/XoVwwt7Ao+liSS
         oEs+jdO0NXXiN3NKaL/ujpesEv1F2xw5AZQMURZYP0IV23JcLXoUg5MxtvRxldz1ggdV
         2Y1iieJ1xKWsIXQgmFbvU9B+mXkd2fBalEvkc9SZKAEL0kvf7qGDsFZW4ty4z/4bGEsG
         +8Eph/uOdey7ccxCIIY0xzmrYBw0p0bu01SC80OkY114Nw+U1svf28C/udGqx+HKn+U8
         x5Gg==
X-Gm-Message-State: AOJu0Yygdx508FwSb56y8gzauGJrKMbhdo+1VWt+vTjunzVfVrvlrKkb
	PLMQw1TJi31WvcxTrdxkVM1x4/q6H8O0GezJHJDgR1pPN9HtOmPgQkyFJwpuhcvMpw==
X-Gm-Gg: ASbGnctMpknoTibYsA5pVEuABL9UCRYUD6+lEEtvTWQ8YWTQIomQqh8M7mTtAsg8lRU
	2vElk9IvcVC70PwPxQ2dJ6yt0bcKQl7TMU3Caex6S3K9Zdr3tGOTr7HASYlcZjP1FHKsNQJEnT2
	z/typdQ56hvqIj5fPa7hBTTAUnhFwJyA5+tF4bP3VHFK0QjdanpsndH948j8LXiGJtcH1XCgu63
	NvkqmE1r9qKs3R+B6bL+VHa8lplp9CycdY//fbo7uo771rkA45hiRFp1bfQIhuSqFwl2/RqqQl3
	+oXBBNEUyTiVMsRmiCHXFZI3yVR5Vmjvz8huM8nOaLW2aJAtxkEjwj44oeCnOBCWbThWaUwUaTO
	u4vZn43WAxtaZd2lWqZqohtOohCzTOYkIBPrvYDQlcCb2nFmglRo=
X-Google-Smtp-Source: AGHT+IFnS/sBMsCQF8ir9ETlwK9uMWpC1im5EdvJ5cQQSkgledwF4j3tjDWV/FzNasYprvJfY6T7Mw==
X-Received: by 2002:a05:6214:8117:b0:704:f7cb:dd25 with SMTP id 6a1803df08f44-704f7cbdd7cmr106620256d6.21.1752834674421;
        Fri, 18 Jul 2025 03:31:14 -0700 (PDT)
Received: from [10.229.41.1] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051ba93626sm5870606d6.87.2025.07.18.03.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 03:31:13 -0700 (PDT)
Message-ID: <0f645579-0c37-4dd1-8c01-dc9a6dfb4131@broadcom.com>
Date: Fri, 18 Jul 2025 12:31:11 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: brcmfmac: Add support for the SDIO 43751 device
To: Fabio Estevam <festevam@gmail.com>, kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org, gokulkumar.sivakumar@infineon.com
References: <20250712215307.1310802-1-festevam@gmail.com>
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
In-Reply-To: <20250712215307.1310802-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/12/2025 11:53 PM, Fabio Estevam wrote:
> Add the SDIO ID and firmware matching for the 43751 device.
> 
> Based on the previous work from Marc Gonzalez <mgonzalez@freebox.fr>.
> 
> Tested on an i.MX6DL board connected to an AP6398SV chip with the
> brcmfmac43752-sdio.bin firmware taken from:
> 
> https://source.puri.sm/Librem5/firmware-brcm43752-nonfree

These chips seem to be shipped by Synaptics so maybe worth adding that 
in the commit message(?). Other than that it looks fine so...

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>> 
Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
> Changes since v1:
> - Do not declare 43751 as a Infineon/Cypress device. (Gokul)
> 
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c    | 1 +
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c      | 2 ++
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c      | 5 ++++-
>   .../net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h    | 1 +
>   include/linux/mmc/sdio_ids.h                                 | 1 +
>   5 files changed, 9 insertions(+), 1 deletion(-)

