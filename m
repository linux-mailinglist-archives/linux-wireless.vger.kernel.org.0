Return-Path: <linux-wireless+bounces-21504-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C448A87C1D
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 11:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5771D188C2FB
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 09:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A854B25E822;
	Mon, 14 Apr 2025 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JEVW145G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1151A2632
	for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744623861; cv=none; b=cRJ+Yf6q6WMWklcuJRqvxOJocFWuq9M3S/8xh2/oqqteM3VzMSId7GBR/1zwGzTvc6IIzqCqggOytnRhAZBUq9HXOPmZF/vR+IlmMtviC4y14pQzDnaCuWduuxx5VKANt/fXDv2UKwKqvd0Bf97+z73P3w1SMVQQLg9RffqKKqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744623861; c=relaxed/simple;
	bh=NXvUhNlB1aPee7uCd9a9odVHLo/yRPdk/MtLRPcDwqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0thrS8YI7ppjtqQxQIZn2dkka7mGIOA8nAPfCGL9j9fBo+l6Rxe7pHXsVXqK/sRuM2pGwPQZG1ainFr0yyAG4Bure4gwooNsPnLFQTKr8iy8NeUIVZAaIgYwdHoRl0T1xF8Ep/55xANqOL8BmPjeoac/L0J1ew7VTY4s6f2USQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JEVW145G; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6021e3daeabso2054120eaf.3
        for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 02:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744623859; x=1745228659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CbM+1WmBZ2Io1n+rSXRsp0Md07GTpvrvG0bVbAmVeMs=;
        b=JEVW145GbBL3gPGGQ9yAzATfEoWvjwN4uQ2ZnglMOQR1rFW4RRXrJwNuoAJw/YWMXC
         olPMlrvPJzGQuBe46rqJA1FD6VuA8TDuejUdwRw49YIyWcU5QfW8nN6oojahrPv49yjL
         K8itRpTFr/HyaX7Ny0777ndiSoZnPwsACTtUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744623859; x=1745228659;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbM+1WmBZ2Io1n+rSXRsp0Md07GTpvrvG0bVbAmVeMs=;
        b=V2YP3FbJE6gr3osB8/Mu9hlov0N8IxyWa4HN1xQgjyaWEMwzZ0dIqQEEOc+Uz2B7Cw
         5gRmPaP1f9PeUxfIvNgrwfKKgzmNdTG+H+RExgOxyalsqHVMpaeufPseBzjNShhWVXWm
         dImuzf82j0I3pgT9ynViI0GvrxnpRlxZUoiqWij+MDNwX+7NY75ko8M3QRxaLEXuGXYC
         x8Vd1cRtdyr8QyjbE1s9CIgxlzFV50UjHypOKuTVPb5rKxsq5JxyBavlI62ZFZiFBcJ3
         yrdYfggLlCbNdC60tAm2lSRHEzR0F5P30uJf14WJSZaWA4GGhqqG0KBE2kZEsCPEW8UC
         m0Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWOMVd6CPd9dHbLZ1dv6NoxP+j6D1bnmlyF6c7Q0uAYxatgheBx+jA8BTp0kmFHk+41UhTsHcQjqOT9cvsT9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcU63fH/BgFkI5Ojb/LU+8VI1hyxozboDVcB/YRlRR2PU7oYhG
	QkfqVseYqnQzfJ8dUtn1ZCjcf49o6TCcQtj6ZNI37ZpqPt+L8Qfln+zRADjt3g==
X-Gm-Gg: ASbGncvGkrUVWMnGyHYHtPLLRJi11av0k4qwCTwrg9Gj1HShwYWlmKko0khxCLnlW0/
	t4/Ejr8HPaHsTo3hL1Hxgqd+7r2Df9J0ah24SQHF/Ij1KQK4OJHRyMC3TZQnSzw4dzBfgCHtzWB
	5R2O0BFfA5hWKg3EImBH2xgUzjpe1WYZHauPs8QmEU1tKXjUXIzqzOIwbe42DPIjMliDx3XzXjq
	RGzw+X4Y7yMaLVnyqmVYv5oj/4t28PEQ9l9xbxALYCp0pjB9usVCaaMkrOIf7r4G9zwR4xBL9Uj
	9gnnKbapUy5YumB41LrK9Laz+zAv9D/n0Z+A/UVi80U0i4cjm/viAeA9PnNH/gEKay4=
X-Google-Smtp-Source: AGHT+IHoa/4/GaqO5TrPYoiHTitCv7q3FYMa5EoLzYEXRejGfSZ58lhxAhVipcuemkWz6IEsfTI5Ig==
X-Received: by 2002:a05:6870:1587:b0:2cb:c780:ac52 with SMTP id 586e51a60fabf-2d0d5d9e35cmr5396992fac.23.1744623858829;
        Mon, 14 Apr 2025 02:44:18 -0700 (PDT)
Received: from [10.176.68.80] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d096cd262asm2314652fac.35.2025.04.14.02.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 02:44:17 -0700 (PDT)
Message-ID: <282afdd9-bb71-40f8-bfa9-bc7e57e1957d@broadcom.com>
Date: Mon, 14 Apr 2025 11:44:12 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] brcm80211: fmac: Add error handling for
 brcmf_usb_dl_writeimage()
To: Wentao Liang <vulab@iscas.ac.cn>, kvalo@kernel.org
Cc: jacobe.zang@wesion.com, sebastian.reichel@collabora.com,
 christophe.jaillet@wanadoo.fr, erick.archer@outlook.com,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250414072058.2222-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20250414072058.2222-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/14/2025 9:20 AM, Wentao Liang wrote:
> The function brcmf_usb_dl_writeimage() calls the function
> brcmf_usb_dl_cmd() but dose not check its return value. The
> 'state.state' and the 'state.bytes' are uninitialized if the
> function brcmf_usb_dl_cmd() fails. It is dangerous to use
> uninitialized variables in the conditions.
> 
> Add error handling for brcmf_usb_dl_cmd() to jump to error
> handling path if the brcmf_usb_dl_cmd() fails and the
> 'state.state' and the 'state.bytes' are uninitialized.

Agree. Have one request though...

Just below the code you touched the USB bootloader state is checked:

	/* 2) Check we are in the Waiting state */
	if (rdlstate != DL_WAITING) {
-		brcmf_err("Failed to DL_START\n");
+		brcmf_err("Invalid DL state: %u\n", rdlstate);
		err = -EINVAL;
		goto fail;
	}

Can you improve the error message as suggested.

Regards,
Arend

> Fixes: 71bb244ba2fd ("brcm80211: fmac: add USB support for bcm43235/6/8 chipsets")
> Cc: stable@vger.kernel.org # v3.4+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

