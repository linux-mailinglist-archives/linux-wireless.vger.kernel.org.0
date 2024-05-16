Return-Path: <linux-wireless+bounces-7726-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B218C6FC5
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 02:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A596F1F24A6D
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 00:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B904910E6;
	Thu, 16 May 2024 00:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iifZ+N53"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17A810F2
	for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 00:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715821162; cv=none; b=Od8Fqm9OEViMYrXs0dzw8psTrgo6VZH9lgVv5MRj9ysAOPEOhSPrNu3hFcluc5fWEIwVYYO7O2DnvFRFvrhZff76ER9z9DAyhGVbTrw37aV5mGu4io2Hlkaeu3l7QBE4+9Sum5djzZgTpgvt9o3xO8Xv166ru1RfhEYTX7FHqPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715821162; c=relaxed/simple;
	bh=VOi8DhSsuEFN6EWjn6DcSpujeYcFzUbhHF2uJyn5XVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GW8nq/m4LUQ5nP+66VrrsdDn4M76js4AMkAzQk+fxFFwYjjklY3vHerBDbf0f9nIi9G+aWD6wbAugyISGqZi8i01n8LVdpouCoxw83z01VEWuQ/YbmW+WAGHSpiXhxvkH+736ODu+Rw2p2pBY+pQwI564W3508l1l+kR/wI4Isg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iifZ+N53; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c9936cb7a8so3611758b6e.2
        for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 17:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715821160; x=1716425960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PstTPLu3x8DIZuYAnSTBISykBCVy2toijVp22obvS1I=;
        b=iifZ+N538MVFR5XoUbyHx8c+ShpmbYYzAFaUg+6SYTtP7xKrG0std0bwDIRuLizrMG
         MI5MQuv+T1fzIE65KWinjOZiIVAj26P7VPATvZG+ErX/s0MvydU7BaZ/kndTGSinQ0qj
         JfW34kiyRZrDFI5ufO0avoWYX7UT7BRRqfOVTP7FCRYvQquBkesrVZDCsFKyZ7UOBFxw
         kYe0xTPM4vnfl68FqAXIUbQ3dyIgC/7Oyb1oPdrUySNZFfPe3HpQK5jcYqRGs5hGEr0C
         EXD+YPEwYyQ8IaWeLToaEAWnxJuRD6ajd6oGXGpeBLVAdqQwxdmPNM/nV/xcX/Cas3TW
         zO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715821160; x=1716425960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PstTPLu3x8DIZuYAnSTBISykBCVy2toijVp22obvS1I=;
        b=bNaP35kcaKHX53DmmVciXOiU4aIwRx7M4EADzj/zr6L+qwPnvvSNjlOiJ7bsIhRqTp
         qXfeixPAMUaKOv5cl+eStKcK8bYtPUoazeyIWH4MpqSiont3tqU0snknluuahAtjikBb
         Xto0+83MxOt5OmtBYMsGvk4/PoOVOyYwL87Wkk2A9E3fithNW2COhLPSVAqI3cPwW5ul
         eZed7wQ5yLO0HA94SK3FjqHWr7muLaWULCV7TIcjhgRKBqdvgGCIul5f4LYsn7bLKoLo
         /l8jqbA/SrjjSdrJScttlYHBsh5IT0gt64NH9VE6R898BoPbyLuz19icCXYRMyXJwwLi
         KaLA==
X-Gm-Message-State: AOJu0YyRkXmCJj6YLkhnP1nTs54uMcayP+D3zq8IeTIS8Y9rmILIDLL4
	pxknWGMuXILJ52tJiXP5mE7XwcXyZANzRc2rhSIHXw/CD0fpzczCOMgfbQ==
X-Google-Smtp-Source: AGHT+IGDDF9uEnVZvxaAuriUu2avzb5Qh6DeJpIVauQM8eOusvGtjVxusm6SyDFlZX8JDwhhBp9aWQ==
X-Received: by 2002:a05:6808:1209:b0:3c9:93b5:ae1 with SMTP id 5614622812f47-3c997066d66mr23261384b6e.28.1715821159787;
        Wed, 15 May 2024 17:59:19 -0700 (PDT)
Received: from [192.168.0.123] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3c9c37e3e20sm103880b6e.23.2024.05.15.17.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 17:59:17 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <723e1eed-e706-4533-b33b-a880b9a46fd8@lwfinger.net>
Date: Wed, 15 May 2024 19:59:16 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with 8922ae
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
References: <898f027b-bf08-4f6b-b0c7-623ca5c5f23c@lwfinger.net>
 <fec7536d76cd469e8fbc375219205d1b@realtek.com>
Content-Language: en-US
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <fec7536d76cd469e8fbc375219205d1b@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 7:40 PM, Ping-Ke Shih wrote:
> Larry Finger <larry.finger@gmail.com> wrote:
>>
>> I have been busy with the 8821au driver and had not done anything with the
>> 8922ae driver in the meantime. Now, I am getting some warhings in the logs:
>>
>> This warning came while running a kernel generated from rtw-next with commit
>> 28818b4d871bc93.
>>
> 
> The log said SER occurs. I will check this internally.
> 
> Question: How frequent you met this warning? and is there a method you can
> always reproduce this symptom?

I have had 43 of them in about 7 hours of running time. Unfortunately, I do not 
know how to reproduce them.

I will try to bisect the problem as they were not present earlier.

Larry



