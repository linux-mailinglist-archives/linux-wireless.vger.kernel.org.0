Return-Path: <linux-wireless+bounces-4749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C0087BE0B
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 14:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65381F21BFB
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 13:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBB66FE27;
	Thu, 14 Mar 2024 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFjnzYWX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A826FE01
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710424240; cv=none; b=QdZ+P/4HyAPr6YDVt0p//UHRRVoi08YwcUdTUHeSrkyiWmlq8IaTv51PqP8vMAfWN4PmRrFKynuzYup7Rw/KEKfDzC+xJb7OtszK6EbqmrzU1CQVx2zdDzEBWpP8vUexbuRRtxwm5acSTq+FMRvZx0/zQweoaLptq8zoS3hEOKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710424240; c=relaxed/simple;
	bh=dRacphyH+U+MYUIyrQY1+Am4jouMi5WqHwzc2QkcfHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBDB1F3aTi9S0kcQsLSP47JslYmRvXT9GN3ptsYb4ltzZRBxkTWNA9zjYDweyegUa+9ipugSaf2kuWEBEUl0O2T0K7Wh9bh9vCidWgVMhTlPouXPe5GlNRU97tGOYPB2TWCvSBH1+5rU6u2BnQgVl4sYqNuSfv8+o9qgPPMG+Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFjnzYWX; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a28a6cef709so129729166b.1
        for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 06:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710424237; x=1711029037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=avJCQMG6Pf0zzn2eFFgh6QeYbr+jhS3nUWUPtuqZD9w=;
        b=XFjnzYWX284moRp/jRggvLALFe1Vf4oWjuYWtdF5UerqXacyjf2Mvax3+a10Y4oBXb
         Klx3sYToE59q0Yd+VmrIXhT1xyM9003Ut0ydwYA1TaqVJTR/WKLlXLNNqyKNpWesYPdp
         OrNQs6Nu05qhzSfJ+uWARJ/J2ESLehi52WjAIkkJrEBcWQ8VuBIaNuC+uKMrWb5v6oBe
         nNTquqpaACSbbx2x6tyojqEAQg4fEM7o0jldKL1xZ5Z8pEH9kLzg4hQk6dQojtXbTS+R
         lhlgsG4pAnz+LiGdBgpzl5jdJVyeCo9rZTIY4xRBdi0q05wZgT9BOkLpmI+J8M13lZeO
         Fw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710424237; x=1711029037;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=avJCQMG6Pf0zzn2eFFgh6QeYbr+jhS3nUWUPtuqZD9w=;
        b=QqVTzynfx46vLtwJDgWoz7Pst+D6PI/fIwZ2c8CDSAKWTdNZl5/owutkOzYCMp5gZg
         j1XEaJ7MayudhknIYKe9ZQYZJ7ZodUJdYIFhS2F7mWnl36WWJL7r9n4cVi5bgTJX2Zye
         m5b1DFJNMd9bAXZNUuzhjg5FUSzA8CPcZgLMovphHj1dJPqHLT/QgU/ViDQ3pY7XPxK0
         2E9QvhiPPKr5nqC4AaEOtDyQ7Qkc64J4ATnjRHzXcfFKmCfwTpRPP1SYaclESqLJvpQc
         ph8nvVkcSU+GIm1QOEHhsIJoacmBwqqI5ffx4NaqM+HJ/l6m2sl5DHdKs74rNmxRu8ZQ
         9yLQ==
X-Gm-Message-State: AOJu0YwSQLOwJnLikXpbQsVMzapAH5Rar3U8dfM7uMVRjLX3AD1nh6Iu
	lTAm53IO2wYnVxsX1pharaNKn1Msri6Hf+u77e5NYFSv1nTHNr+Y
X-Google-Smtp-Source: AGHT+IEkfKoUnmfQYoOv2+qoAb1Lcsa2lDpDkDVKHAPxQmxQT+i4LqJXus1DFu1st2OPiWlYVgu4EQ==
X-Received: by 2002:a17:906:548d:b0:a46:557b:c72c with SMTP id r13-20020a170906548d00b00a46557bc72cmr552039ejo.8.1710424237129;
        Thu, 14 Mar 2024 06:50:37 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id h11-20020a17090619cb00b00a3ce60b003asm730923ejd.176.2024.03.14.06.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 06:50:36 -0700 (PDT)
Message-ID: <5e86599c-c313-45d0-a49c-1c247f8cd230@gmail.com>
Date: Thu, 14 Mar 2024 15:50:36 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>, Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
 <87jzm64ig6.fsf@kernel.org> <7fd2d445-9db0-4170-8d89-78d42f476255@gmail.com>
 <87a5n1fcqi.fsf@kernel.org> <871q8dfbmq.fsf@kernel.org>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <871q8dfbmq.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/03/2024 10:42, Kalle Valo wrote:
> Kalle Valo <kvalo@kernel.org> writes:
> 
>> Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:
>>
>>> On 13/03/2024 10:58, Kalle Valo wrote:
>>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:
>>>>
>>>>> Create the new module rtl8192d-common and move some code into it from
>>>>> rtl8192de. Now the rtl8192de driver (PCI) and the new rtl8192du driver
>>>>> (USB) can share some of the code.
>>>>>
>>>>> This is mostly the code that required little effort to make it
>>>>> shareable. There are a few more functions which they could share, with
>>>>> some changes.
>>>>>
>>>>> The only other changes in this patch should be adjusting whitespace and
>>>>> renaming some functions.
>>>>>
>>>>> Tested only with RTL8192DU.
>>>>>
>>>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>>>
>>>> A cover letter is would be really good to have.
>>>
>>> I can add one. What should I write in it?
>>
>> Basically just a short (few sentences) introduction what the patchset
>> adds and if there are problematic/broken/todo items, for example in this
>> case that the firmware upload is pending. This info helps the reviewers
>> and also having the cover letters makes the grouping in email
>> applications better.
> 
> Here's a very good example of a cover letter:
> 
> https://patchwork.kernel.org/project/linux-wireless/cover/20240311103735.615541-1-fiona.klute@gmx.de/
> 
> The only gripe I have is that the version change log should be in
> reverse order (v4, v3, v2 instead of v2, v3, v4) but that's just
> cosmetics.
> 

Okay, I will send v2 with a cover letter.

