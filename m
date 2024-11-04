Return-Path: <linux-wireless+bounces-14901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5259BC0CC
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 23:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9841C21C3A
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 22:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606F11FCC6B;
	Mon,  4 Nov 2024 22:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gUThltp6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9543C1FCC69
	for <linux-wireless@vger.kernel.org>; Mon,  4 Nov 2024 22:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759008; cv=none; b=JRzmHXle0QHI8tRU/puqV5690Ozzgr/bsVwOvcsHlVa92MgrSVrrPbDQlTB3U1mzs42VFKokxFYXwWTsrJqlY1oQkQBUu6tiU21/TSlep36li5JpVxKg1U+b1UgEAlFwtJE7p79+fERDsz61ZRGeR/BiOUHXWQblQHBqSIgzl1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759008; c=relaxed/simple;
	bh=5aZ4rN+V3tZIqwKEGyMkKz8Q872/oU+WDr8s/OyAhT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tROAxBLpd9Dut+xMtAzaa0slr4U5pJUJNMmzVE2QuSdmpivNxuyt5O/JLEsQpuZshHI24Xp3T2JCIzVqX71WS84dpcR1p2fFIY0P8ocUxJH4XYqxZ5h4gvNNYoVaazOQcCB6T18CkgDlsx++EbM5NHRR1moznKR/PU+u14Uk52c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gUThltp6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315eac969aso29828625e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 04 Nov 2024 14:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730759005; x=1731363805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GHNu8odpsTM4XqBAMuGgYmLrbmeSY9TiYv7pcBRrj7w=;
        b=gUThltp6e5rBNK7K8eUQFWkiyd2JO00/Xf2HakIdiyzwo+4NBKjKx4oPn69Y9XokyT
         JkZO9qo6H8JeZA4ujWDYdeRrpt624b0rvEeJg85iadkhWbFznup7FJzBAzhmiNvqis+M
         7G1GAuM9yQXWGy5gabhMLSLy79EqMg2lvwHU2WC+EYdRV7LZ7Us8v3p40WhMgojAqBBE
         fypvd0gptpFLBo3fw0g9CEdAHUN8HA9pS8b1YScKbUEgoTAORHHvcdpR8ovgkE3d79Qt
         oxf3RaJrO0/Nppzh3HQta8/gUwXDbPuO1FHweLRbdgF6M52wF8C20vBHMXdLbmp0IWqv
         Ottg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730759005; x=1731363805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHNu8odpsTM4XqBAMuGgYmLrbmeSY9TiYv7pcBRrj7w=;
        b=QYG8astSmAA6HqbcbfAoFtLTtlLhevAxKGbhDJ7+mCQtEM6jUHRRF44U41Txcy7glM
         ckumSee9F0MUdhgzPt47qVYlZ3czJgXDzUMsxcvfH3b7EWffQLLanvRpW5Gkz66baBI9
         5QT3enbxYwlnngReAlJFMQO1HGI8i5eu9wGsYp8YG78XTSHeXltCuCgckRE0oyrxBoiC
         HEerId1sNkJ7pqyhGc8w4OfyEVGd+BASJzMFwPgpq9WodAryft6AQCTbw7Nbz6I/k+if
         ERM1QlJFydbUGlD+RiazV3DhfSODwrFZYLUnfSxWMP2Il5H2wZVQ0fswPypt8wLsa09g
         9yOg==
X-Forwarded-Encrypted: i=1; AJvYcCX1PS0gnzx0Ehcqty+YMq9ZCSo6ZQGt9mhzK4smGVOnBC5OyJZhFaHmaXjdM64XPzLDKKTJ9s5aFlO9SgU9Zg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdtWjAdw2Vg/rQQAdknvqpqLq5yuMXvejAYfA6BpcgsMNSTyEv
	HlV4bHb7Ovrxt2k+BHB9FcYB836Nt2NjT0jQrIPDnFyFwT4jEvmhNzIavAcoIG0=
X-Google-Smtp-Source: AGHT+IEST4pFb7N6NqT24LHT0qD9HpQC+scjfouwyiscDUX7D18ufBHRphhTDbRNmFAOLCKZvA8/gg==
X-Received: by 2002:a05:600c:354e:b0:431:4fbd:f571 with SMTP id 5b1f17b1804b1-4327dac6ab4mr141238035e9.13.1730759004756;
        Mon, 04 Nov 2024 14:23:24 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7f80sm14343743f8f.20.2024.11.04.14.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 14:23:24 -0800 (PST)
Message-ID: <78405309-b28d-4a7f-8cca-5410a9c05cb1@linaro.org>
Date: Mon, 4 Nov 2024 22:23:22 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wcn36xx: fix channel survey memory allocation size
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
 Loic Poulain <loic.poulain@linaro.org>, Kalle Valo <kvalo@kernel.org>
Cc: Kalle Valo <quic_kvalo@quicinc.com>, wcn36xx@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241104-wcn36xx-memory-allocation-v1-1-5ec901cf37b6@mainlining.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241104-wcn36xx-memory-allocation-v1-1-5ec901cf37b6@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/11/2024 20:00, Barnabás Czémán wrote:
> KASAN reported a memory allocation issue in wcn->chan_survey
> due to incorrect size calculation.
> This commit uses kcalloc to allocate memory for wcn->chan_survey,
> ensuring proper initialization and preventing the use of uninitialized
> values when there are no frames on the channel.
> 
> Fixes: 29696e0aa413 ("wcn36xx: Track SNR and RSSI for each RX frame")
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>   drivers/net/wireless/ath/wcn36xx/main.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
> index 408776562a7e56da3017aa074396bcd241d62f8c..cd36cab6db75d300f4f6617a6a9e1550f62921c7 100644
> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> @@ -1590,7 +1590,10 @@ static int wcn36xx_probe(struct platform_device *pdev)
>   	}
>   
>   	n_channels = wcn_band_2ghz.n_channels + wcn_band_5ghz.n_channels;
> -	wcn->chan_survey = devm_kmalloc(wcn->dev, n_channels, GFP_KERNEL);
> +	wcn->chan_survey = devm_kcalloc(wcn->dev,
> +					n_channels,
> +					sizeof(struct wcn36xx_chan_survey),
> +					GFP_KERNEL);
>   	if (!wcn->chan_survey) {
>   		ret = -ENOMEM;
>   		goto out_wq;
> 
> ---
> base-commit: 1ffec08567f426a1c593e038cadc61bdc38cb467
> change-id: 20241104-wcn36xx-memory-allocation-803e4e3de9a6
> 
> Best regards,
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

