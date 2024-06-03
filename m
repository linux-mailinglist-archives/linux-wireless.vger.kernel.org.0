Return-Path: <linux-wireless+bounces-8422-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E868D82FE
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 14:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3DB01C21B06
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 12:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B98112CDB5;
	Mon,  3 Jun 2024 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3nozxma"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD8912D1F6
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419337; cv=none; b=QhrYvirA5uMdplfF5vWEhVpN6I1qT89gqbqlRd7A5AlUxom78XhYlcvlAL7U/+BegwakTAKwJ2SDSuvcDb/8Slmier72Phxok79BDqXIMFBSkQcSTUtT43y0wbpCXXoLgIBiCq1CiayNDdQRPoLUYm1j+BHM7tXTEQL6fvTtMpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419337; c=relaxed/simple;
	bh=xWFHGhnBbBP+xwKXHEAbyl10bDwvO6e+6uznSOCmNts=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SIlvTMS4txl2mb+TcxnKw+Qd8g+cv5KDz/pO2G8aKKrNOKhPtKVSkkvlpt7t2NKPw9BWPHSHvabqt/+Hy4thb2Rv5iHiS6+AlU+wFoDw/9AoVk5iMisNA4+ntyjBWJBB/IAypaIZ/CEhw9AYIbfQpJ6iLvJc9uOFpi6f3FOsUAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3nozxma; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6265d48ec3so465010566b.0
        for <linux-wireless@vger.kernel.org>; Mon, 03 Jun 2024 05:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717419334; x=1718024134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EGqODB2B5hU/MJQp87PaqNGd7REFw3DUM0ywjszQU2k=;
        b=I3nozxma12a2e1NoZulYuhCTOqxdqLWhmqZNoNZEmN4cJhEBdsgpsAmcQpXalAcY2l
         DY5WKPQejnA598+MZ8fJGo1oN01W6ntD+ZIPc91TASAgAt5N3KKBN0/dKswKY8J1e9c5
         eNhIoozohd1nz7mNTFHvrKcsvU7YMRblfXNXBXMNOSbnYYkYd6FcycisnmvjiAx/Pb2R
         out9GojWXFI/E1j/fQW+KlCwBSSKq5x2nf2Wh8bh7yGvjtvn28UEW+kK8C8AAOXNa4dr
         sL9Z41Dniw/1+i7DTB+wU89tYB5tkK9WQuKrPkKtRVyzIRylZBCYXhbCFUDehiRDvFb+
         WWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717419334; x=1718024134;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EGqODB2B5hU/MJQp87PaqNGd7REFw3DUM0ywjszQU2k=;
        b=Fqs/7YJweRMq6/s3m4K8hfJrJhYpwd9SejWWtl/X10GSGa4eIJ5SrHPXjvxpYx+XiA
         Mk7Iav9r/WDDA5r0r0paTZ/AxlN+1e9awzrWDggarHUu8ak6XmTS8RZdyLPvMRkuL++X
         jfSStmB7kMzfgV5KcDcg7XkghZb1e2oJHGANAxQTq2b8KATLvIqxY/v2Evd6PL81fmcQ
         1TBeLXhUSXS2rnTxvhnO+mJr8X5w07R73eSrufd1w6YFMsim7nvpCpHa5dDh9O6AhAUa
         SCUMNItOS+1ymemN1+qcL6fh8NoZF5fvjK6/VaK7nI5NODQq5Kuf0vE9vVoq8uTcadty
         jPGA==
X-Forwarded-Encrypted: i=1; AJvYcCVFSAq445O4s7uv898sakngyEknt5guIYzfli+MSxMsWeMWupfKaxhYISAndbsbx2HbyHGVxxZWOhHHoQ0sv7LNha5Ckn2yqDhuIKoGAeE=
X-Gm-Message-State: AOJu0Yx3wVHZ1+EjC2+zhFoMoiYmTKZRMvAc2N2gGMHNcAAj5KibFVYB
	RhN0+Rq96+ds7tTuXtihY5wq/DfqpVqlnOXXe6aHNpMNjkDcCekV
X-Google-Smtp-Source: AGHT+IFPlOWtjVPKyve+/2nfgUKamrPpy54bfe/iD/7RZNRfm+Lm+AAGE6nHC5TqX2fXPVNgWKK/hQ==
X-Received: by 2002:a17:906:eb0d:b0:a68:f28f:5158 with SMTP id a640c23a62f3a-a68f28f51b5mr277632566b.35.1717419333487;
        Mon, 03 Jun 2024 05:55:33 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a690cd83f2csm149160366b.218.2024.06.03.05.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 05:55:33 -0700 (PDT)
Message-ID: <d48eaed2-10b8-4d45-ad76-4bc01606e8e6@gmail.com>
Date: Mon, 3 Jun 2024 15:55:31 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Add Realtek RTL8812AU chipset to project rtw88
To: Ping-Ke Shih <pkshih@realtek.com>, Liam <mothsarecool524@proton.me>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <j4XA74KT9pFZBalRpR2dCG07ohOgN6kwhU-Y8LPDUU53D7Kuk6vWQKbu635doolHWOQ96fL4fs7mNWP_zThhLfNvfpeGxQYATdPwfhSuWbc=@proton.me>
 <e8b0d83bc11442ccb8621ea465c31938@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <e8b0d83bc11442ccb8621ea465c31938@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/06/2024 03:50, Ping-Ke Shih wrote:
> Liam <mothsarecool524@proton.me> wrote:
>> This email is directed to the Realtek engineers working on the project rtw88.
>>
>> Good afternoon Realtek engineers,
>>
>> In the list of supported chipsets, there seems to be one missing:
>>
>> RTL8812AU
>>
>> This chipset is used in quite a number of smaller USB Wi-Fi adapters, such as the NETGEAR A6100, UGREEN
>> A1300, so on and so forth. It may also be used in PCIe cards as well, but I'm not quite sure on that front.
>>
>> Here's hoping the efforts of the project go smoothly and pay off, so that more of us can enjoy not having
>> to be tethered via an Ethernet cable.
>>
> 
> RTL8812AE (PCIE interface of RTL8812A) is supported by rtlwifi, which USB
> infrastructure is also built, so that is a choice to support RTL8812AU.
> Patches are welcome. 
> 
> Ping-Ke 
> 

I actually modified rtl8821ae a while back. It took something
like 8 days to make RTL8821AU and RTL8812AU kind of functional.
But in the end I stopped and switched to rtw88. Partly because
Kalle doesn't like rtlwifi (I don't like it either), and partly
because there are several problems which I don't want to fix.
rtw88 is more pleasant to work with.

At this point, rtw88 support for RTL8821AU is almost complete.
It's only missing the bluetooth coexistence code. RTL8812AU
still needs some more work.

