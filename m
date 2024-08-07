Return-Path: <linux-wireless+bounces-11092-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF3594AD62
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 17:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA6F1C21951
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 15:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F5A12C54D;
	Wed,  7 Aug 2024 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIS3ycco"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A6183CD9;
	Wed,  7 Aug 2024 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045981; cv=none; b=MuxuCstk2pkvc3W0I25I2Hv/jO0WdxU2MBgOOD7YXELr7MmjNiw5zfxxNomwOWPZqtM65gxncFUxv9Ec5oJsQPyCjAJzg/9FqrZYi4ZXVICD9qj0thqD2VUhm5sQjW1rSk04hp9wPIKGVnIbhbQwgk7DgIvEakrYP96zng8PpHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045981; c=relaxed/simple;
	bh=wXPWh6k6pBHGMN6va5P/75EbKPnOuDRurzYoTKaEwVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aAERzijJqkEAw+vnMxeivEueYlkEqlWdcTZOPP+wxiFEuake/c+ut7wsgSsbB1fEGDjF6x8odEMFrePnIQKRRN5map4Qw7eyv+oz/LjoHxVUuE5FoItAMPRJaXN0tlp9uaudaecp9hxw0njKSNDR0MlNkmOIFEW76qTNSh2EtPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIS3ycco; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5b4e2db85ecso307803a12.0;
        Wed, 07 Aug 2024 08:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723045977; x=1723650777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qUiUvKTQQVHMdxw66WRr+aSl8RyfjXAJRd+5JETrf0E=;
        b=CIS3yccoop1Vm7QSyYKH7mplxP58XXnemHPJCvJSqYohsUUzp7o9d/yUgt/Q2sqKVm
         AL4HWVJRngj6s/VZISjS6oWDyVuYHw6OM87qtyRKw8IM1Q3IsJChDe9tt2C4wKXWYNJ8
         rUVbEyJRjj4xoymMQH/L3kXlU0PqxpQxXUUX3LiwkIMTQCr6MJR6crxqNUdWQjjPXAm0
         BbK3MW3rVRCEL7dtrTWWIzFkp37iGMU3Nku1MFAbbOgcp73NDA0dfr5oLQkR9iZEC4OZ
         ga/tdr9kHAcBQE5jnHbf+OjxQyACnakJgzHwWHP4kO4C8oZzfwZb1Bw57Xrnwrxq5NIa
         pYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723045977; x=1723650777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUiUvKTQQVHMdxw66WRr+aSl8RyfjXAJRd+5JETrf0E=;
        b=KDNV01rSIErHik1eCXOANnThF5xq6vKEH61R3IgpwDdGfsFk+c3u/vC4nryAHVOjka
         SxszNFv7GXKXk4AWh34T3QiD21VY8D/zkrcjU8yTNVNgR8TLvXdhyg2mQV3WPMcGfIxt
         s8T5J1hU979dG4hkby6icPtNqGWJ0icmN0OsYpDfypB2l2gHF+KqCKrULRUqa0zT4+wC
         MR9SsZzhd6AuUxpSwtevSYrzC3IfscEniq4vftGI6I/KYA5X3Osq72XHshxRUh6EqwZ8
         xx5krLMzMvnNeqSwk6D3G/Z8DD+0ZBwDcNudzwYsY+MrMwUC9e8NYP9bAvlGLiLJgsyS
         xTZA==
X-Forwarded-Encrypted: i=1; AJvYcCV8spC0gtMpPDOIMlfNOqq9dhzd5tyBVp6GXj+kyxO9omlKSJJbkRU1tSRB8sXe3dSIK63WkV3P@vger.kernel.org, AJvYcCW5ceGAo9/8enUNDVXPxgsC6+f/LJvJKYJTKa3CtlpOzOdDAl+ns0tBLq2dU8bfFfynOwrcf1M/JRfLi1m5BKk=@vger.kernel.org, AJvYcCXUKFSG+zHAMUX942aiCs3KXUKEe0utrGJrriGZZ/HKegdB1Ipux9s5l11CziO6aJWc49MgmeSQ9sp++uet@vger.kernel.org
X-Gm-Message-State: AOJu0YwSUxDs7FhnrlKnRI0RBMxht/SohmP8g8AdzwYKf4HyQMeDK01o
	kbngTkrzJfeIuuKKNkEmywWaqtOs8WbmwNLIJqqaRgyy71FTJvYC
X-Google-Smtp-Source: AGHT+IGFO3IapnBF3tCg1oFuCGSR2iozMJtvYIm+8ITSbjakxWwa/3Sic7jLMArrMzztkADGamL5nA==
X-Received: by 2002:a17:907:6d06:b0:a7a:b895:6571 with SMTP id a640c23a62f3a-a7dc51b4cf1mr864700466b.9.1723045976910;
        Wed, 07 Aug 2024 08:52:56 -0700 (PDT)
Received: from [192.168.0.104] (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d437dfsm654958766b.133.2024.08.07.08.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 08:52:56 -0700 (PDT)
Message-ID: <f24782cf-bace-491e-9cf9-28d515d4fc54@gmail.com>
Date: Wed, 7 Aug 2024 17:52:54 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] staging: rtl8192e: Constify struct
 lib80211_crypto_ops
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 stas.yakovlev@gmail.com, kvalo@kernel.org, gregkh@linuxfoundation.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, linux-staging@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <cover.1722839425.git.christophe.jaillet@wanadoo.fr>
 <dfda6343781ae3d50cd2ec7bbdcf76a489b6922a.1722839425.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <dfda6343781ae3d50cd2ec7bbdcf76a489b6922a.1722839425.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/24 08:40, Christophe JAILLET wrote:
> Now that functions in lib80211 handle "const struct lib80211_crypto_ops",
> some structure can be constified as well.
> 
> Constifying these structures moves some data to a read-only section, so
> increase overall security.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
> 
> Changes in v2:
>    - No changes
> 
> v1: https://lore.kernel.org/all/81be9eb42a2339eaa7466578773945a48904d3b5.1715443223.git.christophe.jaillet@wanadoo.fr/
> ---
>   drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 2 +-
>   drivers/staging/rtl8192e/rtllib_crypt_tkip.c | 2 +-
>   drivers/staging/rtl8192e/rtllib_crypt_wep.c  | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
> index 639877069fad..138733cb00e2 100644
> --- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
> +++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
> @@ -378,7 +378,7 @@ static void rtllib_ccmp_print_stats(struct seq_file *m, void *priv)
>   		   ccmp->dot11rsna_stats_ccmp_decrypt_errors);
>   }
>   
> -static struct lib80211_crypto_ops rtllib_crypt_ccmp = {
> +static const struct lib80211_crypto_ops rtllib_crypt_ccmp = {
>   	.name			= "R-CCMP",
>   	.init			= rtllib_ccmp_init,
>   	.deinit			= rtllib_ccmp_deinit,
> diff --git a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
> index dc0917b03511..74dc8326c886 100644
> --- a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
> +++ b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
> @@ -678,7 +678,7 @@ static void rtllib_tkip_print_stats(struct seq_file *m, void *priv)
>   		   tkip->dot11RSNAStatsTKIPLocalMICFailures);
>   }
>   
> -static struct lib80211_crypto_ops rtllib_crypt_tkip = {
> +static const struct lib80211_crypto_ops rtllib_crypt_tkip = {
>   	.name			= "R-TKIP",
>   	.init			= rtllib_tkip_init,
>   	.deinit			= rtllib_tkip_deinit,
> diff --git a/drivers/staging/rtl8192e/rtllib_crypt_wep.c b/drivers/staging/rtl8192e/rtllib_crypt_wep.c
> index 10092f6884ff..aa18c060d727 100644
> --- a/drivers/staging/rtl8192e/rtllib_crypt_wep.c
> +++ b/drivers/staging/rtl8192e/rtllib_crypt_wep.c
> @@ -209,7 +209,7 @@ static void prism2_wep_print_stats(struct seq_file *m, void *priv)
>   	seq_printf(m, "key[%d] alg=WEP len=%d\n", wep->key_idx, wep->key_len);
>   }
>   
> -static struct lib80211_crypto_ops rtllib_crypt_wep = {
> +static const struct lib80211_crypto_ops rtllib_crypt_wep = {
>   	.name			= "R-WEP",
>   	.init			= prism2_wep_init,
>   	.deinit			= prism2_wep_deinit,

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>


