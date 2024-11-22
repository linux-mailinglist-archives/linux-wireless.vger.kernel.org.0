Return-Path: <linux-wireless+bounces-15612-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7CA9D646B
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 20:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E7CCB21E63
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 19:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA7E1DE4E4;
	Fri, 22 Nov 2024 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xv3nCgt+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B291C70823;
	Fri, 22 Nov 2024 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732302616; cv=none; b=n2oj9cd/muPIkDMUZBi7t//TL2Z7OUmV1O8+fxHFopeMnsCQi0sjN3mY1Rh97td1EP1culBlrMayMPydaztOJE1vlzIEbfSaBLe2NHq8KZjjQ2m4J7FsBokb65uBk3UwjUp9Ql31ICTOmkIAqMMLfKBP7Fdx+NuN0gf1xYdnLfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732302616; c=relaxed/simple;
	bh=7Js9725yuDTaqZx4v6vLyqGvlwmpzX48vHgFV4IOGeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGO943RsIpg518w3hQ9hmH3hy+HwX0QTlRPk/dctLU2kVfJ1Ez0lSfpbY23+CY5YjynGHWK3pdt9Ae+rls+KkoKV5wTxVethzCRDCrm/wWJpUfMWyk8fDxvri4SgY61N9MwfGb4/eDmsGFlE1qwPirhBWRJQob+p78aJ/hch+Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xv3nCgt+; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffa12ad18cso25917341fa.2;
        Fri, 22 Nov 2024 11:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732302613; x=1732907413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EC3Zv8ppd5odVr8KSpm+U6T+1AdhI4uzCIwkEFj3kNY=;
        b=Xv3nCgt+hdxGQiX2N+10Mx2pQxlBupVEp5+cDVm4AbFBo3fZPGx1yHtgwEH8PHiYYG
         GS15h67LfdNLy+3ZTFJ7UC4ldmVJF2rDJqVMOecjcraKNVlLlyhulClcKhWRWjCDnPF/
         6UayX8Fknz/WjJHsJ+GqGu+1Vp8LMHzUkeKNG0iG5ODM0N4dcntEH4blqlVIWEHm81UH
         IS3aA6Apk1O6D0a2fPh5W9TpedA32WbXHncdcwOn43hizcy4288Hs3Px5zF014iJhXMx
         9PaYttyIQ9ukdwg5E/yp8G3WvsquZA3GwDu8aCMe8jEaxO7FlOGxohd/cBkWaX1Lq8SO
         /OUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732302613; x=1732907413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EC3Zv8ppd5odVr8KSpm+U6T+1AdhI4uzCIwkEFj3kNY=;
        b=TVHXZACpmkXsXsbLoYmVFAxFbm2CCeuKh0seANiHMKb+ZXgXdn+SnH+cMtGOHz/8jI
         l7HHOYwSrvVq989fK+sfsq2gnup2G/lrnlVOickDsrybhzynrIDAylrv7noOCSgte8SG
         YuHYKTLHLTfzA8+KK9BvSwnjHa6avFtBwtMQbmMNdy+UE40KzrF/ORKbclZGcBfVnCV6
         Q9DJ93Sx9je0SwB5VuQOW9Zi+dc9KxGtradRKDRBa829Qsz3GDO+p6umIW9GzwwRGSxH
         tsj/BMYKq4GGYBgKoslG79b5xiLhvfhfdO1cyXw1oiAXJ3TJNH3XjYhLkZX+W0To8PQX
         tzyw==
X-Forwarded-Encrypted: i=1; AJvYcCUMshvTEKAGxIWdnUVJJrg5yNAB9v68O196lx7zzRFUwIyrPaU1YYgGIVTlXePTUF0bUFlmZGm2cEUjlR2cQYE=@vger.kernel.org, AJvYcCV4Jlr7ByyV+JZhBrSXfqrZo8zXXFnGk56q5w0bvPJnPm4DUfwZhhaIR/j4k2b/jo2kU0rRWzPMKThHpts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYU7g5NNuB+JtCYzQiJCugnnirMhAWZxBD/OJUb4kx3aJtkTNV
	jP6oK5gDjEmhRXeDFbhrCqPuqMuRxhkuhbTRegil1QhOhyQz5DY0
X-Gm-Gg: ASbGncuJebPKS6AEnOObzF8brUZvaZqfKjeGfnaM0dw3DPlBMApjPhJ0HLu5BKCL0vS
	6XkFdcdMqLMiIyYEkxDHrMhtij26wJutf8hxNad9XLmmVorvDpGxmjgP23RUfIZFs81fIDh2zmO
	o2n1y9FVMyIUJocUFJRTbk6A2cpoUKjWHy99T/NYggBnPxX0aR1r72v94teFqX1bonjZk59PMx0
	yujpfHViXSoMQQUufjdw1V8kymsWmPK7Tl1p/14j/gubjR2HqTrZUJz
X-Google-Smtp-Source: AGHT+IHO0TeGbqkaOfQW2+IKeKdpnqM3Ct4QNhv9ccJAX31oRz7/MdACaTtHpxTcQrx5kpCbmVnsWA==
X-Received: by 2002:a05:651c:1992:b0:2ff:a928:a22f with SMTP id 38308e7fff4ca-2ffa928a4ddmr27044621fa.28.1732302612596;
        Fri, 22 Nov 2024 11:10:12 -0800 (PST)
Received: from [192.168.0.50] ([81.196.40.57])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d021179e8bsm1074416a12.23.2024.11.22.11.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 11:10:11 -0800 (PST)
Message-ID: <773afd3d-91f0-4dc6-abf8-481d3125c047@gmail.com>
Date: Fri, 22 Nov 2024 21:10:09 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: rtw88: Fix an unreachable code issue
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>,
 pkshih@realtek.com, linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org, linux-kernel@vger.kernel.org
References: <20241122121459.134107-1-dheeraj.linuxdev@gmail.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20241122121459.134107-1-dheeraj.linuxdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/11/2024 14:14, Dheeraj Reddy Jonnalagadda wrote:
> The error handling in rtw8821a_iqk_tx_vdf_true() contained unreachable
> code due to tx_fail being explicitly set to false before the error check.
> This prevented proper handling of failures and resulted in dead code.
> 
> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> ---
>  drivers/net/wireless/realtek/rtw88/rtw8821a.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821a.c b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
> index db242c9ad68f..c06ba7d615df 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8821a.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
> @@ -221,8 +221,6 @@ static void rtw8821a_iqk_tx_vdf_true(struct rtw_dev *rtwdev, u32 cal,
>  				/* Originally: if (~tx_fail) {
>  				 * It looks like a typo, so make it more explicit.
>  				 */
> -				tx_fail = false;
> -
>  				if (!tx_fail) {
>  					rtw_write32(rtwdev, REG_RFECTL_A,
>  						    0x02000000);

It's like that on purpose, as you can see from the comment.

Your patch changes the behaviour of the code. If it really bothers you,
fix it without changing the behaviour.

Also, you should mention in the commit message if you tested
with real hardware or not, and what tool brought this problem
to your attention.

