Return-Path: <linux-wireless+bounces-11298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 947BC94E996
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 11:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA1C1F22D02
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 09:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E355415C155;
	Mon, 12 Aug 2024 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Se3p6+c5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABB414D712
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723454540; cv=none; b=TTjjRcpcb1TK3lROGTV5hA7YbR9UZXuBW3CI9/AXcJPM/LkvJqA2eFYmPhtdL+6wxmdTiAo2z3bTTAnNbwXe5sHvkBLGUzMrI9oVT3X2NfUoBLu1rHBZ2bW7L8O22kyOOcAJfJdIyjhF35hfDdEjviNjfwD7694SuJj4wttv8hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723454540; c=relaxed/simple;
	bh=dZC8meJ4AS2+6AjEz1+G3qaJztIrxVb0pe+cx6t/vNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNu1iU3NNN2TRw1vhf4MMqhfkHOiyYTJMolQfSulxkXV/OhDrorzaKYv/4VDnj7jkDUIP9Wnwhk1ulafR8io6zTTJrgPgeEfgUkZVMpdk+m/rRayHhQIUa941Fmem6KFF88naQJQwS1vKCIjstKI+lLsN9wbFum8PasZKEgM4RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Se3p6+c5; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso3752235b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 02:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723454539; x=1724059339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tl5A5OblV5XVWMm0AASRkS892R+h1FRmHY3a39/eDWk=;
        b=Se3p6+c55kQm3nKYxNgzYft9BccXw7ErPQxy5f/6zlFQ/xTIA2INk5xx3CMIi4GhKv
         MSM4t/fk2dP5G4+3Y4+6vpeLD0LXGxWUpdSbJviNHFDRK27uIZmc7waJGGPGcnnRGBHT
         c5PAZjdbKAqmBKSOiofud6j9gy6S2LL9q6DRcQ0jNqY9XrWDHEG2SMtFVBtvpCcxsU2T
         oXpyWsACgbRPDYIUnTUUJgV7Ygqv6KQtPGFpEFICYuRRVPX50K62osvJDvjCVfKHXp8q
         rgRn17VoBIxQDVbrHe7LQMPjZHdm2DOthSSV4tB7pPeGxBescMYMWeD0hMZ9pK8SBpR3
         xs2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723454539; x=1724059339;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tl5A5OblV5XVWMm0AASRkS892R+h1FRmHY3a39/eDWk=;
        b=pByxyhIoGuHUsDomMFKbrt24Yz6B4ziJOx73Gap2HYCnPsIaRJPh4c9wl/kAtvoBzj
         1tuC8KttQ6OSyo6NP+c8fTis0SzuLy8FsqqWfsJyrFVt8ZBwPXAhNFik02R9uTq8NVXx
         W6kILI6HqJKhdxnxJVKPjt7yj3Ok9AHpQLsZRmgfotQEhsr0AHTApYowDKgLxfWjPfOr
         utOf8C0KIl/xCyDz40klMamPBPSYEhMQzyVSfFFoySWX3Sy9AcQ19PdBYESCgykfu85m
         SZpFHYldpVjf0R/e9F+3PX6krbv9F9ElP57AbjmH6sGeyBSewbxVFJ8/eJyo6EYK/H0y
         rthA==
X-Gm-Message-State: AOJu0Yzybq+HfHONDeM6ZSajSKhsXh74YIv1DZCbK5f/b+z9TQhuiqdg
	T11dHrSjbszkYGNjdX8tXe8BlrVU6MjR9JdovM3SQ7s7LXBWIvXF
X-Google-Smtp-Source: AGHT+IEcog8jghpbEsT40ekKK8skI8oBehCCCPOecT8tMxB1IXsyOm//ovP2R7SJg5PhzQbQpS83uA==
X-Received: by 2002:aa7:8892:0:b0:70d:350c:757e with SMTP id d2e1a72fcca58-710dc6cb9cbmr10744935b3a.10.1723454538538;
        Mon, 12 Aug 2024 02:22:18 -0700 (PDT)
Received: from [172.16.40.166] ([103.78.35.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58a80dfsm3573500b3a.52.2024.08.12.02.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 02:22:18 -0700 (PDT)
Message-ID: <53f4f012-a454-443b-a2de-6151752fa5db@gmail.com>
Date: Mon, 12 Aug 2024 17:22:15 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wireless-regdb: Inaccurate regulatory rules for Brunei (BN)
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
References: <45213523-32f6-4e82-958b-6271e8b7e366@gmail.com>
 <CAGb2v64OsGpERdrojMgfbQspk_vwsm-X16Nj4ntvN+1azaEM9w@mail.gmail.com>
Content-Language: en-GB
From: Nathaniel Chin <thegamingorangutans@gmail.com>
In-Reply-To: <CAGb2v64OsGpERdrojMgfbQspk_vwsm-X16Nj4ntvN+1azaEM9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

> Thank you for reporting this. I currently cannot open the 2014-2015
> document, nor the underlying website. It seems I am blocked.
I also seem to be unable to access the entire aiti.gov.bn domain as a 
whole as well but this specific document hasbeen archived in archive.org 
<https://web.archive.org/web/20240724130146/https://www.aiti.gov.bn/media/voqau1jw/brunei-darussalam-radio-spectrum-plan-2014-2015.pdf>

> the 2018 document reports two
> limits: 100 mW and 1000 mW. Do you know what that is about?
Unfortunately, no

I've found another document 
<https://web.archive.org/web/20240724125731/https://www.aiti.gov.bn/media/qjchjoni/code-of-practice-for-srd.pdf> 
(appears to be un-dated) which makes specific mention of DFS and TPC.

Best regards,
Nathaniel

On 12/8/2024 4:19 pm, Chen-Yu Tsai wrote:
> Hi,
>
> On Tue, Aug 6, 2024 at 12:51 PM Nathaniel Chin
> <thegamingorangutans@gmail.com> wrote:
>> Hi,
>>
>> I've noticed that the current values in the regdb for Brunei do not
>> match with the Brunei Darussalam Radio Spectrum Plan (2014-2015 version)
>> <https://www.aiti.gov.bn/media/voqau1jw/brunei-darussalam-radio-spectrum-plan-2014-2015.pdf>
>> and the Telecommunications (Exemption from Sections 33,34(1)(b) and 35)
>> Notification, 2018
>> <https://www.agc.gov.bn/AGC%20Images/LAWS/Gazette_PDF/2018/S039.pdf>.
>>
>> Which both state that the authorised bands are: 2.4000 - 2.4835 GHz at a
>> max of 200 mW; 5.150-5.350 GHz at a max of 1000 mW (2018 document); and
>> 5.725 - 5.850 GHz at a max of 1000/4000 mW (with the latter requiring a
>> license).
> Thank you for reporting this. I currently cannot open the 2014-2015
> document, nor the underlying website. It seems I am blocked.
>
> Regardless, the values you report align with the 2018 document. One
> oddity is that for 5.150-5.350 GHz, the 2018 document reports two
> limits: 100 mW and 1000 mW. Do you know what that is about?
>
>> Additionally the 2015 document refers to FCC and ETSI regulations and I
>> don't see any mention of Japanese regulations?
> This is from an old change that added DFS-JP and associated a bunch of
> regions with it. There was no reference given.
>
> Without access to the 2015 document I have no idea what the DFS requirements
> are. They could also be under some technical specification that describes
> the test methods for compliance.
>
>
> Thanks
> ChenYu
>
>> Best regards,
>> Nathaniel Chin
>>
>> P.S I've had to resend this email because initially it was sent as HTML
>> instead of plain text so if you've received two copies: sorry.
>>


