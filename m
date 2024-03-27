Return-Path: <linux-wireless+bounces-5359-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A0988E77D
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 15:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8523C1C22780
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 14:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F942130ADA;
	Wed, 27 Mar 2024 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7Wd1DX+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568C812DDAF
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711548446; cv=none; b=rXU/WN4E83LvARlQd7JWN7+BKoepsRll17E1BmfE3ufbJ7wau3YsgU5sepRiKiUDosru8/0gcgGnfqo4+kEaSZg8c1IAbUtYal3AS69kQ/teNtwKqCvnPcOg3CavKKGJD2AdDixJcEyWX1FbN2gTk9AW5b6nlrkW8XKF5qQKf7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711548446; c=relaxed/simple;
	bh=AIxyzss0uu4ZqGcEZaGkisgWl4oNWJ4zMn27fRqVTDc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=s+PZ6vhUuZgiIZajyHtlLuDR/X44l0u/TytvbsvyafjrXH7ytnvHyF+2Z7tp0g+injm2Upo/ZTCF2qx+6QmymHx3uca7TNNiaU6giNVWgg91I8SYfRoslo/Art0MXresloO00NHp0BjYs+NjunMDVdNb9ZkiJ/UU1BOtT25bmH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7Wd1DX+; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d46dd5f222so80479371fa.1
        for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 07:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711548442; x=1712153242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VH85LDanshnEfH59gVgWxhjvg7DEyyk9asBNYPxNyJU=;
        b=a7Wd1DX+YnhqILLF1ShvTTeKQQ5tEnXY1Lw/fOzKxNHiiN9ACZTfw75e+1g9lobXYf
         Y3MUhFJue15D8HJ8u3Dg2pWRKwYLpXyALEEQ0IG77pwd+37BB/khJlwvozbukrvKg1IE
         ZcTkIcDNhdAe/gt0aDHI+QvP8c2DiTh6Pc7Cke2KPDDuM7OFClntvMJ7FM0FLJzXCIF3
         NibVSgB8bSeWUkHxVR4i+r8flT+w8G7GvMgv12b5ric+IAhqbLsBQrIbviluC66M3beE
         IhUjs7xx6YpjAO1mwIW3qJeqmta9Hw/zefLQ+sk8eQQsdbVlQtoEL/y5cZ97vlXnU0lV
         Dn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711548442; x=1712153242;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VH85LDanshnEfH59gVgWxhjvg7DEyyk9asBNYPxNyJU=;
        b=WvIbZ8OjNDhfnBg+Ktjr6XFYwINr5IzLTUlUnFg4wRRd8LV/k10wv83T4HmEtlbfpY
         xXFyQuHyeaEsqueRZVfgjE+DzQtfKK+xrkb7y8w21J9phmsf5dvn9lzl4GK7bRnJzjFP
         f0ww1frq4EBpH7b9gYwb4XkK0iM/qvtwi27sTQ9Orpn+gGEEmo2EswVpN7pgJP2eONIc
         bCYLSGBQkrqckPOuDIIa01PbIYf8NlvhmLqp4Iw3JhV4KlDteIk8/qxLyv811MJT4yyw
         PEOMvn6sfa5XTSTNhGcUPI1qmhJkkWFXsOI347OltLqz5SYbZMZjglDqEN+0JJ1XOn3e
         oESQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrxBFhDxFJhVcoX1/Oo/nui0g7HWA/e90ER63m9PkD9jAIVlWf0FUNNPP1BpI4GdFY4zSxDNVEjsnl8d19rMOtPLz6QBSugID4qk8wdTk=
X-Gm-Message-State: AOJu0YzqFhOLfo+A5ykPlZ2DlQseKB3eio1YJ0AQ4Te4pko2PboZ8bfR
	k4Trwv2fL4Vx10uKV8pfeAtMIfC7b5rN7vvC/sEctQJUcAc2uuj4usIFQX/g
X-Google-Smtp-Source: AGHT+IEyxhDJQ3c42EI6pNGS4OeyztlUuCE7C0OQamPZAbT7p1PqBYP7yvF3atRRFBNdICkFXwTAuA==
X-Received: by 2002:a05:651c:2124:b0:2d6:a33c:66f8 with SMTP id a36-20020a05651c212400b002d6a33c66f8mr161592ljq.4.1711548442207;
        Wed, 27 Mar 2024 07:07:22 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.188])
        by smtp.gmail.com with ESMTPSA id b15-20020a05600c4e0f00b0041494665db1sm2113197wmq.15.2024.03.27.07.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 07:07:21 -0700 (PDT)
Message-ID: <66565618-3638-47e5-afe5-3530214da0c9@gmail.com>
Date: Wed, 27 Mar 2024 16:07:20 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH v3 11/12] wifi: rtlwifi: Add rtl8192du/sw.{c,h}
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
 "s.l-h@gmx.de" <s.l-h@gmx.de>, "chewitt@libreelec.tv" <chewitt@libreelec.tv>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
 <2eb79c8c-cf2c-4696-b958-e8d961628e17@gmail.com>
 <f86a40493745a53ff73083f87b3e8fae215eac77.camel@realtek.com>
Content-Language: en-US
In-Reply-To: <f86a40493745a53ff73083f87b3e8fae215eac77.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/03/2024 08:04, Ping-Ke Shih wrote:
> On Wed, 2024-03-20 at 21:43 +0200, Bitterblue Smith wrote:

[...]

>> +DEFINE_MUTEX(globalmutex_power);
>> +DEFINE_MUTEX(globalmutex_for_fwdownload);
>> +DEFINE_MUTEX(globalmutex_for_power_and_efuse);
>> +DEFINE_MUTEX(globalmutex_for_mac0_2g_mac1_5g);
> 
> The consumers of globalmutex_for_mac0_2g_mac1_5g are complex. Why do they
> check mutex_is_locked()? Race conditions between two instances?
> 

I couldn't think of a sufficiently short name, like
"lock_mac0_2g_mac1_5g", so I used mutex_is_locked(). That's probably
a bad idea. It should be like this:

	/* Let the first starting mac load RF parameters and do LCK */
	if (rtlhal->macphymode == DUALMAC_DUALPHY &&
	    ((rtlhal->interfaceindex == 0 && rtlhal->bandset == BAND_ON_2_4G) ||
	     (rtlhal->interfaceindex == 1 && rtlhal->bandset == BAND_ON_5G))) {
		mutex_lock(&globalmutex_for_mac0_2g_mac1_5g);
		lock_mac0_2g_mac1_5g = true;
	}

	....

	if (lock_mac0_2g_mac1_5g)
		mutex_unlock(&globalmutex_for_mac0_2g_mac1_5g);


