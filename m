Return-Path: <linux-wireless+bounces-18046-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C06A20178
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 00:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8293A5538
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 23:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F041DDA17;
	Mon, 27 Jan 2025 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7GY7Rmi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20E51DC9AD
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738019875; cv=none; b=GXFGo9gY271r/R5llDXKJ018RQmFabMIP8BLK4hRquFWbX8PlShoPdh6rN+X5/wvt+i40sdM33+rsNmeK7Tcfc3O1dtEhYX91O0YF7XAFIGc2D8WOjm5uoK+AABaln6o0+zVyPbh0rKIY3Pt0yTNxdfNdEVvAXsb52HjlZV410c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738019875; c=relaxed/simple;
	bh=Dgk2lHpd4F8e1Qi6P+0lgiZqAtsI6eWiMqTVaLugsIc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=dFJoXI2EAfQZPbgFzDUZQxbLoWzmDT8bnr4Ik5YhcUo0npD5dOcdUGpYmyUTWLoN0+ddPhbtrzjnxeRknGGfd87w70OdNoYc/BKLv1OKECz/XE1yOuEZl4Lp4idIhNOj655YW6eBWtPvi7R3cnADWjsNsiOAbIPMu7SxWctpgOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7GY7Rmi; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4368a293339so57446155e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 15:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738019872; x=1738624672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajtDGNa8k+ouxDwt4aUgc3QC1zODrp55wmxjSDaTJRw=;
        b=g7GY7RmioPzQr+Cj41a7OZMUInMT8j1KELToNpmUpV2U5PyrC/fLwaWzKqzh0xgijt
         VOZAtiTiGEZd4XmJG4z6Eletq1mqj6+h+26GGXQfOEO3LB5byX7cazd8brOAr71yM0Nx
         U8jwx1y5njgDvc8PGM07WhnFZLCWpWupy4aJHhfFp6F6K/R8SypKMIn95RsIt6eVmqAh
         TfNzq5fNR071z83gBMcj731EcarUJqG2EiI2eUiOM9rFtbSbQfeblML5rQZF4qE3OO/O
         vUlNc+CgRP5dpcFBhZeNXVKP61K5W4b72vwwr+Q6Gg8PTF3hwvjPOubg3zPhqVpI2P8Q
         EK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738019872; x=1738624672;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajtDGNa8k+ouxDwt4aUgc3QC1zODrp55wmxjSDaTJRw=;
        b=W1OH1NHiNXnwCvAHQVEn3TDj1Lzm8aIygsIwR05FpFbEaPftCmfQIrwtIbRsJAthK9
         ys/RPSGAnJlTLAllXw+DHV8C24X9L0SMDemUNygeDo3N6N7m/kcOLGZohDXsTW4PMn1I
         dTzchGH7vg+dg8LARXIMCYYFAX7KbjbyHI6pivzkSPyNfkY1M5Of0Zl8oye+QaawGyuz
         FKq84VhqIqRRqpEAX4xAVzWbivPb2Gktb2B39ebw4wALY/6YlulkQyPDA5F2pe5IOfaw
         rEtN61qoqTmumj8OUQ0zqwoI2J1n4zgd0qspy80lyrlmqZFEqnJ2jq2L7pCBhJQaFYM1
         0AYA==
X-Forwarded-Encrypted: i=1; AJvYcCWoy9TkIqFT0CYmLhvvw4OPreIU3sRZP6yiiMC3w6AdZPduYaOm0GPH4ElhobxPxX+TtZ20v+EE4vRVsCOGaw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1YvkV55jSK+TkHKc5qCohZAoaugVK5In2jbCqRIX2fOcKVQaD
	Iq3a1Ey/CeAu8TLePDumX8iDev0MRBWG7egnISnkOmrzH9F6NxED
X-Gm-Gg: ASbGnct/y/uxST+gTMLvJ/h6BWgyLC8oiHT0oTBUBNumYPm6TVR7CrVOuRj0mT73HPf
	ueMha4KePHaCfjybxdWtkg3/RX0VBjEeWFWXKFEq0oq/vxH3xuGvYLclNxDw/rvfBbslqGAqZuK
	jNwC3oCS07Y7xcF7MThMuvNEHx9mID9n7pDxiIYrugZq4cD64tHzcJ/iLn6TFJfPZY4z/k5zmzj
	1qnv2TecyxBRqCmAfc+Ku/0prZ2TLO0PqVOkDypOZi2af1EciTLT19jTDIr4qrHJNFS6MeFaFQi
	MM6ig/HCwOC2
X-Google-Smtp-Source: AGHT+IEUyu1wlesUQBLEoAsGNIKSeafrV+xxVgFHCMN7elmZkH4NJNky/1pdCqZL3z4vTl8LiuHIYQ==
X-Received: by 2002:a05:6000:154c:b0:38c:3eca:b30 with SMTP id ffacd0b85a97d-38c3eca0c11mr6888650f8f.14.1738019871704;
        Mon, 27 Jan 2025 15:17:51 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd48ae29sm152503685e9.22.2025.01.27.15.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 15:17:51 -0800 (PST)
Message-ID: <b7b8b246-f4cf-46e0-b92b-3c9f752af449@gmail.com>
Date: Tue, 28 Jan 2025 01:17:48 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 1/2] wifi: rtw88: Don't use static local variable in
 rtw8822b_set_tx_power_index_by_rate
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <8a60f581-0ab5-4d98-a97d-dd83b605008f@gmail.com>
 <11853ea27d7b4789b18557e44ef3e62a@realtek.com>
Content-Language: en-US
In-Reply-To: <11853ea27d7b4789b18557e44ef3e62a@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/01/2025 08:03, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>
>> Some users want to plug two identical USB devices at the same time.
>> This static variable could theoretically cause them to use incorrect
>> TX power values.
>>
>> Move the variable to the caller and pass a pointer to it to
>> rtw8822b_set_tx_power_index_by_rate().
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> By the way, if you interest to cleanup rtw88 and avoid this kind of limits,
> we can check symbols of output of "objdump -t *.o | grep "\.data". 
> Patches are welcome. 
> 

I see some tables that should be const. I will send a patch.

