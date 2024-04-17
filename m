Return-Path: <linux-wireless+bounces-6453-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C35578A8589
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 16:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9657BB2829B
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 13:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C843413DDA8;
	Wed, 17 Apr 2024 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+ukzmfK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B3612DD8C
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713362302; cv=none; b=h4GbbVX0cBVCUH5p9fCU+4PCF2uwclAKlxHtxMVsVzqWQbIpAruAkhcieaFr3OM13Gd8BjRLJrkicLH7qVuCm3/MWG9z0x8Ti8nAJx/GH8AeWsqHAZQ9qbZomDjf8s/aJdmpEPFIMiMLlrYCejCcG5a1+vdO8GCVk0s5+H94fhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713362302; c=relaxed/simple;
	bh=Pa4utgYTccJf1liyMmN8RE3wJcfyFW6pn+f8wjHNTYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kfhQvjShCphK4h6CBsQ84dLtYHakLbNkLSKIRk5vrNK4B6OXinRMCpcjcZluN+4u5Sp8WNmXBP9Y58LWdiyf0K+tljBfa7AVmJqD17EPyhtmEB9bSWYSHA/R6kS5bB8z2Y6YcXAWyWWJcF55zWhkGg4KOJIUSpWiGTeFJKoGDrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+ukzmfK; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c5ee4ce695so1633492b6e.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 06:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713362300; x=1713967100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pg5WNLYsB3WinifJAqg0RF5waYmPebStvdmGjyYhRTo=;
        b=f+ukzmfKZ9a3U/DF+ubWEJR5eZLvEQhLLfyz18DTH/AKzdUc1vD3S7NacvaK+imIm6
         1k/MSTpfwujX0TzePrOcaQhUKZ0lx+Oa3iEQcA9BWwvWxpOUDmwht4ZHLR806De2rFLz
         fOUWdhhPWbZdsZgjdQFNb60KghlrnP9Rk+et/sWrt2IIV18XdEcdA0Pno1Q52k2Jm2TJ
         sHUAYngw4iXgg2rNygAaJTWt9rK83XD9pbt1ernoi2Y2GagTqnscBHXsnFxEhJUzN7Kl
         cdNH2gSbpvyt8G4QZ4h0Carle0m8wGPd4UnLahp8e/wlkVyOH0x886BomhUqz6qdbEDP
         78xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713362300; x=1713967100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pg5WNLYsB3WinifJAqg0RF5waYmPebStvdmGjyYhRTo=;
        b=OJQcnaTuLQDToyyjTuje7XaDY9sgsrwhmNzdcVg7QJ3S8HccTwU2gnN3uWSQet51XL
         Ov0bxcagEtqwO0HUzsmBtdCY47UjwjY2/npDY6y4qOvtlY0KsSQa/VsLzKMiN6CCB1z4
         cOnDstDrcecBq9FbAt9UDenbbwm9KlA8nHlpUQKkENyBccrfYtI9C7s8M/BBcp6EkXsv
         iHdvivnE3DiY/KtRBg2EGcM0qUS0/SIATd5tHHjrLQh4e8FbSfs7Pyvy4jH4eXEcvTpg
         5tKFsVQrghuVhpGFrif6IAqpN+b5NQy4rI0PQl8WqE7IBl0am5wpOjkNPjLG20X7O+o0
         V8dw==
X-Gm-Message-State: AOJu0YxhPpSVqz2vzpaCcINTCGbkUrSQSm2gfvU55oCYU2neMHQ3HVQ9
	lySloIc+YPUuGG4z3fsSzT+qTPb7PtKVm8O7J7b5F8fvskAta+og
X-Google-Smtp-Source: AGHT+IFBHseeoNdtd8Hh0AsNxb8X5LNp1lJN2YR/81gCsLeyiTY2i8vgV8EFmsvP31gica8t5MpQlg==
X-Received: by 2002:a05:6808:2228:b0:3c6:1566:af58 with SMTP id bd40-20020a056808222800b003c61566af58mr20204814oib.20.1713362300387;
        Wed, 17 Apr 2024 06:58:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:70:f702:9c77:c230:a0ba:a1a1? ([2600:1700:70:f702:9c77:c230:a0ba:a1a1])
        by smtp.gmail.com with ESMTPSA id b1-20020a056808010100b003c5f54d014dsm2379929oie.51.2024.04.17.06.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 06:58:20 -0700 (PDT)
Message-ID: <b7876373-08d9-4948-a49a-e79f42f3abcb@gmail.com>
Date: Wed, 17 Apr 2024 08:58:19 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: putting future iwlwifi firmware into intel/ ?
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, miriam.rachel.korenblit@intel.com
References: <fec30176f437d565d4c1dfc4944373f117d75a64.camel@sipsolutions.net>
 <9aa64d50-cb4d-4118-bc27-86c23410ff8b@gmail.com>
 <f65765b29ea7503fbbaa5e047c95a82de6fc2083.camel@sipsolutions.net>
 <b0e70576-a53f-4d03-a503-ddf1f98bbe9d@gmail.com>
 <b712f48a3e35221b7ff7f4c8cb495b5159bdd367.camel@sipsolutions.net>
From: Mario Limonciello <superm1@gmail.com>
In-Reply-To: <b712f48a3e35221b7ff7f4c8cb495b5159bdd367.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/24 07:45, Johannes Berg wrote:
> On Wed, 2024-04-17 at 07:42 -0500, Mario Limonciello wrote:
>>
>> On 4/17/24 07:39, Johannes Berg wrote:
>>> On Wed, 2024-04-17 at 07:31 -0500, Mario Limonciello wrote:
>>>>
>>>> On 4/17/24 06:18, Johannes Berg wrote:
>>>>> Hi,
>>>>>
>>>>> Since I was just looking at some firmware related thing (files for the
>>>>> hardware that might be shared between Intel BT and WiFi), I noticed that
>>>>> just over 30% of the files/dirs in the top-level firmware tree are
>>>>> iwlwifi-* files.
>>>>>
>>>>> While we can't move the files that older drivers might consume, we could
>>>>> e.g. change the driver to look up future versions/future hardware under
>>>>> intel/ instead? Would that be worth doing?
>>>>>
>>>>> johannes
>>>>>
>>>>
>>>> How about moving them all now and then creating compat symlinks for
>>>> older kernels at linux-firmware 'make install' time?
>>>>
>>>
>>> Didn't realize there even was a 'make install' time :-)
>>>
>>> But then I guess it'd be simpler in the driver since we could just
>>> unconditionally add the intel/ prefix to the request_firmware call.
>>>
>>> johannes
>>
>> Do both.  All the stuff already there add the compat symlinks in linux
>> firmware so that current and older kernels work with older hardware.
>>
>> Any "new firmware" only put in the new path, and add commits to the
>> kernel to look for "all" firmware in the new path.
>>
>> Should hopefully cover everything without too much pain then.
> 
> Yeah, I guess. Though not actually sure, do we need to support new
> kernel + old firmware install?
> 
> johannes

I'd say you should.  Here's a few examples of why:

1) Kernel documentation says so.  See 
https://github.com/torvalds/linux/blob/master/Documentation/driver-api/firmware/firmware-usage-guidelines.rst


2) Let's say you change this in latest linux-firmware and kernel 6.10 
but don't do a symlink.  A user upgrades to 6.10 and latest 
linux-firmware but finds a regression.  They're asked to come bisect it, 
but their kernel 6.9 can no longer work with wifi due to "missing" 
firmware.  The bisect gets WAY more painful.

3) Some distros do "HWE" kernels (for example Ubuntu).  This means they 
could do a HWE-6.10 or HWE-6.11 but expect that the exact same 
linux-firmware package works on all of them.  They could uprev their 
linux-firmware to the one matching this change but then their "LTS" 
kernel stops working.

So yes; do the symlinks when you move directories.  It's one line in 
WHENCE per file that you want a symlink.

