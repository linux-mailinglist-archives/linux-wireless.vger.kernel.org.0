Return-Path: <linux-wireless+bounces-24173-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8D9ADC241
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 08:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8B9171373
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 06:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF008212B31;
	Tue, 17 Jun 2025 06:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cL58Bri+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019B04430;
	Tue, 17 Jun 2025 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750141130; cv=none; b=IEpkqaL3J6PnoVJVGvC5HP9iMtJTgvaGWZ2ozGchTfwexkVZwUz6UXfgcAM9nqK3daVg6zjbiv7pzeSjGjNrc+KiCWksOpvn85A/WAoZOtqdQk2Fd6EtAkgw+WeefFc/o4LWci/oMcg0IkbfbxUCP2NB8xv3KoW0LV6QyidP9SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750141130; c=relaxed/simple;
	bh=hC3N6mB43enMOOEM98dOuvar9RH8tCwqnwUmAhEnHMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ow/9NeSc5O3Jwu9pDelQQNvgcH4SUKZfkhXTfhqEmp3WipSzF8+LJvnmsbD6z3hMB1z2Ya548IxFVQ762POV6emyum273WNz4QIIJok57HqCajRsTmQveILsdGVui56R5zGiVwnnqJLZE+baOPQkNQ6dd5mQvwTUordU5Uw4Txw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cL58Bri+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-453426170b6so14347645e9.1;
        Mon, 16 Jun 2025 23:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750141127; x=1750745927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5g9a+ee0HF8AQqt4aQIZgSq68mE+z3YEyfrqwRi2gq0=;
        b=cL58Bri+l03eQM3GgsVD4GTkRjXhS7XIl4wPj0yhM9Cu/6gAzw5oKEVVdZSxSGQfNk
         kB2BWbpfE0zf2lsaYi4mt31qo5LCzm+cV2TBE7dt2f2r+/o0QysrTOSjVTEDQ+knkyBr
         yr/BfxmD65x8LJvcRntrmanUVzYYS3xHVkO1paWddbXkAdum+PDCajBH8+IxeO3xdiyo
         h5NUvl5r9qRwg4Rjcdq2ptlZsXb68Q02qwTNzTaaMHOFiTUSqOUJDkKCqLl/5r1Y3jeC
         AUHWekpJmWX2t0aZcxHHyHPwHIqh48TlnvAsdILj0H4mzDo2KODH34SwdC8B3uEV9AQF
         A8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750141127; x=1750745927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5g9a+ee0HF8AQqt4aQIZgSq68mE+z3YEyfrqwRi2gq0=;
        b=j5n8OVpf89yNOvqd/cZJxOzyL26igIRqFfM48fkIhklYt2pgQCjWWtFe9+p/ui2Qpa
         BSZ3akb7BcrvHSUZNvaGaNgb+2jgUN7y1y5K4QNG2fmmcpsHaa9OIQNExHPO6OnjsYBr
         lQRnA58u0NTNrFb76n00un2dXpOMpfxeL4laYkHXTQXfNKRJAw0N8CBVdgtn9y0mgrJf
         s2rlNvZovQ1PqyMoUfhWBmLbsweXW1G928MKOdX6icl1p/VoLJMYWUtznw6id4RpsuTj
         GjXZbn8nCSTjTXP3uIp7sMd67UFQBuTfizAc5b3f4nyZ0Yc3WwkN8+xi8xJcoImricnG
         90Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVOQ43IHkboMF0+1W95smnMp5xShtcw/eRwYR6yGDJ2wLPQGY3beXZxGPw5tvhiu9tKMM4lQMGOD8btaH/B+GY=@vger.kernel.org, AJvYcCVhsolEuJv/JNz8pqK/XnkYMlQFh2M0mSXTvNiW+9j7fT488u5IsIeUS6uOMEkpnmudgF4Zr4UfNj9rmZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT9Lx2SNx1KiYGPkY2QD2xsNHU7nuhKDOgE5W2iO8WJ6B7zsRf
	8xOd310LoMkq6s4zP6UshiOKpzlQHzWIAP3nyxQc/j+TqvFOxpznVVAJ
X-Gm-Gg: ASbGncsYXHIWhOzbksSXaMGZgkQacrj2vDcgACf+Jy0Bp6PEIPrcA2z3IxRbdrVptvL
	Q7JEYmb7cBMFDdnki0uHaXGJYP85QmyhaFLauIYcQsQ2uQHpQ907JG2pVnR8jtPxNYVwX2vS7Mc
	dQby0KkL/QlZnm+xqW+wzMtjA6lCKEemorenQ0Cwk91jOOuNXFDLHRlxMMFm8djwrRWgmkd9+cJ
	WEc7QKidwC4vsBw+Xh1zTVQv9kq+dhAFg74Ber2fLweZFtVEcDKDLpSWZNpVKX2QWFS9ibrAGyl
	dOnRNlPyGveZRkkOOSdNMFIOEuOa8tW746N099fK8CoOmnwmFYygu3K6upAQm4bpUrgwUFxdEdD
	er+Zrubgft5v33GCA4diix7BWtiRCGaV7NhEd6Ud26GAGbsovqER8NvaWBQ==
X-Google-Smtp-Source: AGHT+IFK073YbC2M2l+D0rpiNN+kHfW4htKCPOH38yO5FXCFdPw6UP7/xSiAaoY7PuYoZ+KXJBGA9A==
X-Received: by 2002:a05:6000:310b:b0:3a4:d9d3:b7cc with SMTP id ffacd0b85a97d-3a56d853c46mr10278186f8f.28.1750141126967;
        Mon, 16 Jun 2025 23:18:46 -0700 (PDT)
Received: from shift (p200300d5ff34db0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff34:db00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b087a9sm13212196f8f.55.2025.06.16.23.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 23:18:46 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.98.2)
	(envelope-from <chunkeey@gmail.com>)
	id 1uRPe7-000000004Fn-2CHN;
	Tue, 17 Jun 2025 08:18:45 +0200
Message-ID: <6454c831-24e7-4b72-979c-7922092877ba@gmail.com>
Date: Tue, 17 Jun 2025 08:18:45 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: carl9170: do not ping device which has failed to
 load firmware
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeff Johnson <quic_jjohnson@quicinc.com>
References: <6bacdb9c-6064-43ea-9dfe-0eca496d1c9b@gmail.com>
 <20250616181205.38883-1-dmantipov@yandex.ru>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20250616181205.38883-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/16/25 8:12 PM, Dmitry Antipov wrote:
> Syzkaller reports [1, 2] crashes caused by an attempts to ping
> the device which has failed to load firmware. Since such a device
> doesn't pass 'ieee80211_register_hw()', an internal workqueue
> managed by 'ieee80211_queue_work()' is not yet created and an
> attempt to queue work on it causes null-ptr-deref.
> 
> [1] https://syzkaller.appspot.com/bug?extid=9a4aec827829942045ff
> [2] https://syzkaller.appspot.com/bug?extid=0d8afba53e8fb2633217
> Fixes: e4a668c59080 ("carl9170: fix spurious restart due to high latency")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Christian Lamparter <chunkeey@gmail.com>
Cc: <stable@vger.kernel.org>

> ---
> v2: prefer pr_warn_once() over WARN_ON_ONCE()
> ---
>   drivers/net/wireless/ath/carl9170/usb.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/usb.c b/drivers/net/wireless/ath/carl9170/usb.c
> index a3e03580cd9f..564ca6a61985 100644
> --- a/drivers/net/wireless/ath/carl9170/usb.c
> +++ b/drivers/net/wireless/ath/carl9170/usb.c
> @@ -438,14 +438,21 @@ static void carl9170_usb_rx_complete(struct urb *urb)
>   
>   		if (atomic_read(&ar->rx_anch_urbs) == 0) {
>   			/*
> -			 * The system is too slow to cope with
> -			 * the enormous workload. We have simply
> -			 * run out of active rx urbs and this
> -			 * unfortunately leads to an unpredictable
> -			 * device.
> +			 * At this point, either the system is too slow to
> +			 * cope with the enormous workload (so we have simply
> +			 * run out of active rx urbs and this unfortunately
> +			 * leads to an unpredictable device), or the device
> +			 * is not fully functional after an unsuccessful
> +			 * firmware loading attempts (so it doesn't pass
> +			 * ieee80211_register_hw() and there is no internal
> +			 * workqueue at all).
>   			 */
>   
> -			ieee80211_queue_work(ar->hw, &ar->ping_work);
> +			if (ar->registered)
> +				ieee80211_queue_work(ar->hw, &ar->ping_work);
> +			else
> +				pr_warn_once("device %s is not registered\n",
> +					     dev_name(&ar->udev->dev));
>   		}
>   	} else {
>   		/*


