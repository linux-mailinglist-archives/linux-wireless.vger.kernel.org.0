Return-Path: <linux-wireless+bounces-14219-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 264869A43FE
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 18:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08FD1F24385
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1A220371E;
	Fri, 18 Oct 2024 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIqInSiF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BE72036F2
	for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729269707; cv=none; b=eDdCMh/tgEF31ONoC8v3uoHpkuIqz3vRj00fDT5UhpnIweJR2Qv3dDY/QZ1y2JBNLC5oB3vb7yu2eRpwKPP5Qvanr+vfc3pBGLLS6IS2nucUQlx24MjHFrP4uHCXGReExwg+Chl9kj4/V4EZalQUfNifthi72gGlP/09vYeB20c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729269707; c=relaxed/simple;
	bh=mv5fw+IHDMU8J7iF4mVDmDLwGRJQomRgrbBa8Jywkwo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=i5cxu4zu1RSCx0riqmbVWDvjpD3Y4Ctwji12baX8tJ4NdJZxJpfZbn5fTk0dJIAg289DNbYu2ch4pBEQObXvdqJWkNljfczwsz4leCZ89VNTGTnTzQeyWgwzhC7pb9G6eOxXb+4IOTka5fAC27WuFchmRt2HkW/KwVQIJUOA8vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIqInSiF; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43163667f0eso6684545e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 09:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729269704; x=1729874504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1iNwDavuzP+OmqTbsj+fCB7PZTubF53PxHS2FeiEwLw=;
        b=DIqInSiF3CTTFTy4UdFJkd+rMmfxbuQxB/Is4YlKzpmi7fmihCOcQXKmJorybYfn2P
         DTqYVUb5FJ0iLsWe2I7EunTMeMHL5R/ZazX7wgT6GurBgBGe+0z24Htj7Dyp9xMrLShu
         2mIWusEJAx1H0mbZzA3um42Kz6m2GOW0dNl1QkTJa+TtuLAfDFJ09fyHmm0OD3X0aNWZ
         DTXhXZ/8fWvGPbv29lY7Wru/QCrWF2ci/nNHxOiKMHHoUJsOCP3XLlvsVJwYbezYYb+0
         UxdTAGg+ciMURJb/QUHnmvAhvYtC6+OMb53TvGNdsZLHkc2Ug271jiNXlKPvCKeEEkt6
         15OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729269704; x=1729874504;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1iNwDavuzP+OmqTbsj+fCB7PZTubF53PxHS2FeiEwLw=;
        b=n5C4H7Kz3vyClNhE0uGzxeleF+PWzDOVlVu3hN/VMkp/OY7UvTML+b2OmMBRvcXkBz
         leY8NUW0edE4pvrW7MRrv5NpbqPduNE+tEXru1x7AF4wKeoLyqFiWGNJyVftZu8auQ9L
         asWvExB8mRqj6SErD85JR3LL+PtCWqFJPlTgbIQKayb706D/o6/JYwo7/VRk1fQWQksZ
         4vJY9A0500i/g/6th/6prfYzcZXBXWDEDf4+iqdNofY8H9I9Ve4q1Ojpa/vqaVcs9e/9
         Buz8k0OWaxFeJLPnSdUdbf9e4P5C/I+f8r78H5rqsS7YwgRR0Zve5OYQBINF92958sKQ
         gDmA==
X-Forwarded-Encrypted: i=1; AJvYcCXbE0S0O2F5m8ZbASYB8meQr5n1ba6AwPrWfFq9vaKKsOjsyWNnRsRmhLtir3raFt+c19zLAIW3+MwIT8ob6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8OQ6yTMVyXMm6a9HW+s3HauxoLjBjFrI3WWfkTwb548GsTjTy
	11jQrIF2SOZxtoqYD1Deoq0ywul815p9+abSO66vqKAqR7ty3SYHY6fJZg==
X-Google-Smtp-Source: AGHT+IG7c3e8XeICBT8i8EpUZ4C0KMY1FaI9bhpWjKOA13xwb+eCnZT3k+fJvRO6dAvjYMHlXCbrpQ==
X-Received: by 2002:a05:600c:4e12:b0:431:4f29:9542 with SMTP id 5b1f17b1804b1-431616332a7mr24997875e9.6.1729269703845;
        Fri, 18 Oct 2024 09:41:43 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160696dacsm31359435e9.26.2024.10.18.09.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 09:41:43 -0700 (PDT)
Message-ID: <b4225966-435e-4a0a-9d7e-607f666b48e0@gmail.com>
Date: Fri, 18 Oct 2024 19:41:42 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH v2 07/22] wifi: rtw88: Enable data rate fallback for older
 chips
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
 <21dbccaf-82e2-48aa-9b11-dc217ca76309@gmail.com>
 <db016f99a85241798d28bf60edb0e61b@realtek.com>
Content-Language: en-US
In-Reply-To: <db016f99a85241798d28bf60edb0e61b@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/10/2024 09:26, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>
>> RTL8811AU fails to perform the 4-way handshake when the AP is too far
>> because it transmits the EAPOL frames at MCS9 and when that doesn't
>> work it retries 48 times with the same rate, to no avail.
> 
> It looks weird that it doesn't try lower rate.
> 
>>
>> Retrying 48 times with the same rate seems pointless. Set the
>> appropriate field in the TX descriptor to allow it to use lower rates
>> when retrying.
> 
> This means setting 0x1f as limit in TX descriptor, and then it will
> try lower rates?
> 
> 

That's right.

