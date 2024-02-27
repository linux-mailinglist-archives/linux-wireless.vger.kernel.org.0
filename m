Return-Path: <linux-wireless+bounces-4107-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEBE869C34
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 17:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3731B25EF8
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 16:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950DB1482FA;
	Tue, 27 Feb 2024 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEp1AAGD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3470145321
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051276; cv=none; b=SCu67pV68LTzkXXCzoFkGHta37QdKxHKxaP0ZAusyVN0i2Z+FpvpoOezEUw+OdCekudciAZgdp6YWkj3dTH2M6v1vDLb6FM4K5X+gAI9VoLvg6WP3Rq+MiGa2Anj25R62HQ6nrxEipyr4zUS/ESbgNCkNnm00eVOB9lWw3p1wD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051276; c=relaxed/simple;
	bh=OvXpsA93xm59ZyaavvETwj8M5JBsMJ3PoLtaa4ZDxRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jKnI6dudruwyFwLWTwnvqkQ26pScyNeODFJdE+PknFIppW1XnL3zGmMC/U945POjMaWoSCO7VVc232jZP29pUFyJaiLMGjG8PfLgFeFsitQa7oqGl1FAH6eEJq7s3uIAnKkJMsMPm/DNEeWNQNRbBlKWm4KFIOl36Y0/RcKvMOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEp1AAGD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so636833666b.2
        for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 08:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709051273; x=1709656073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n4PRTMKgdsyUAd6+XpEn/tSWs0U/FElHQbeSuxyAhiw=;
        b=jEp1AAGDgX8MxS/qtl8OhiLtcRQC4Sm2zgD+sFrR8fahDiPSL4zhT1jZm2ckubUbZp
         l4FFFs07gmmMFAAQnkX9BfNXVKRCH8VScFGnVQmwbQVv764rJ29AVrYJs1R8WaFjuLUb
         BJxAtGk/uSfPLjY6hJ072rYi0PHMfM1dtp1cGPmD44qyW/MPPlINGJzdJyjJEvmw1iTs
         LpxdcLqcvWj1aHRL4mylU828xqieE4Jmlpsc6/nJEEJmu2ZyR+Lu16m8U5TuVc4JTTln
         CEdj3LeF3e1s1J9O0nCNExzttv3mQLirkYHsRYAsd1SY3mNX3tqB53P+p76ESGJGxLci
         4fJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709051273; x=1709656073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4PRTMKgdsyUAd6+XpEn/tSWs0U/FElHQbeSuxyAhiw=;
        b=Cw6RPS7vNtQfL9cy/MJJBT57UyHaZSosfNXg/u/Gb1NQvzlWlesSaZNwsqtYPjDrd/
         IfkEQFU4jO8OGohvmIRLQyZfH7n7YogK2/Wp1eg5r9oRB1eMdtld3ysATwDwiqqR0tY5
         gXwmkrBB/P25YLlK2t8Rr/g9vpsoaWwYGDNY/tTgEolvJENYyP5FfU1AINHdwJeyD9gt
         RulbB34+vNreNE6XtrafDk77kPc+A+Y5byAZ0gbyNJovH6jl9UP0dD9RGM6zDv6mR8Tc
         tsQexKuEo7W3lp9pDZTglNBlZYcL9O7im+wKDBnnajYItxUK4qGKizwmmXxqTVFXEujm
         eDng==
X-Gm-Message-State: AOJu0YxLEe4rnwav0Fme9JoapfJYsd0GwMAaJZJEsBpVQ2j/E+0h/Z0c
	Bc3N8eU4aw4NsnzjOssnQwUofRGF1bLEggGF8/mIBV3AfOyn205G0SsD/4hH
X-Google-Smtp-Source: AGHT+IHfyUznoipnBSPXnB2tK+O8Q2p+gCiGzoz2DFbWaxg+I/Bv3Db6gdf2ouGjdhjFzHGWYYcRKw==
X-Received: by 2002:a17:906:19c5:b0:a3f:9d69:3643 with SMTP id h5-20020a17090619c500b00a3f9d693643mr7147645ejd.32.1709051273138;
        Tue, 27 Feb 2024 08:27:53 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id s18-20020a17090699d200b00a43a478e4f0sm846610ejn.180.2024.02.27.08.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 08:27:52 -0800 (PST)
Message-ID: <aacc9bf5-90e3-4e7a-af44-33d11fe89c18@gmail.com>
Date: Tue, 27 Feb 2024 18:27:51 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] wifi: rtw88: 8821cu: Fix firmware upload fail
To: Sascha Hauer <sha@pengutronix.de>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>, Sean Mollet <sean@malmoset.com>
References: <731ea688-04ef-4f02-9d01-3e9026981057@gmail.com>
 <Zd3b81m3_Hh47lww@pengutronix.de>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <Zd3b81m3_Hh47lww@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adding Sean Mollet because I forgot earlier.

On 27/02/2024 14:56, Sascha Hauer wrote:
> On Tue, Feb 27, 2024 at 02:18:20PM +0200, Bitterblue Smith wrote:
>> +	if (addr < 0xFE00) {
>> +		if (addr <= 0xff)
>> +			current_reg_sec = REG_ON_SEC;
>> +		else if (0x1000 <= addr && addr <= 0x10ff)
>> +			current_reg_sec = REG_ON_SEC;
>> +		else
>> +			current_reg_sec = REG_OFF_SEC;
>> +	} else {
>> +		current_reg_sec = REG_LOCAL_SEC;
>> +	}
>> +
>> +	if (current_reg_sec != REG_ON_SEC)
>> +		return;
> 
> Is there something we want to do with current_reg_sec == REG_LOCAL_SEC
> or current_reg_sec == REG_OFF_SEC later? If not the above could be
> rewritten as:
> 
> 	if (addr > 0xff && addr < 0x1000)
> 		return;
> 	if (addr > 0x10ff)
> 		return;
> 
> 	...

Dunno, I just copied the code from the other drivers:

https://github.com/morrownr/8821cu-20210916/blob/5b39398e2de146edeb76716420f3288f508bea61/os_dep/linux/usb_ops_linux.c#L171
https://github.com/morrownr/88x2bu-20210702/blob/bb6e514230791010a34daf0d6ccf55ef97309dbf/os_dep/linux/usb_ops_linux.c#L171
https://github.com/thales-dis-dr/rtl8822CU/blob/4182c79e0c5362dcea46088dab9fed27795b5579/os_dep/linux/usb_ops_linux.c#L171

