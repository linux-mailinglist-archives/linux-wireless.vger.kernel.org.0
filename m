Return-Path: <linux-wireless+bounces-22917-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE36AB580C
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 17:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0A83BF41E
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 15:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88DF259CAB;
	Tue, 13 May 2025 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByNS4TpU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB72C1AB528
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148647; cv=none; b=R6KG+bHMwPAQv7bsMyGtcbpc0g0IP6tF2yMdQp9Vb+wWhK+6u24QjUzajdA63dcHx7KBsUYtruTzSvdo8vvYbVw7c5Y1XYdM+3/GKD0wKWOkqnwzFvG9QRf1jlaQepD1wUP8U7o3BJjx9ZrD2u/Und4ROftylUrhYj04a1njy4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148647; c=relaxed/simple;
	bh=43xx++o4uTnjgHoQXQVkWznsuofhJZ4RXeG54guknOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfMoQ78O+9rrkm5b0qrNJkeWHZ+eT1Vfi+Ov70U7wAKDmErk8endbwLq6lY+IaFzqWqQwF5D0Hs0+gPgViE1QSqUEIBgVP5s5EQx13Xd20EVKkcsYeCDcJkAzoQwTLx7HLizpv9/XXD+mU93luLVREMdSChZunRJO2fHKl5JyM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByNS4TpU; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-606477d77easo3634049eaf.1
        for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 08:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747148645; x=1747753445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5OdMGtjLFIcrdrNv9jN6bRUk9RHa4iwKrLXSmFvBS+E=;
        b=ByNS4TpUINydzw3BPJmnhOoYEJNMMNvaA7u0qzr8fPJjtp1oQMQzcZ23ariB9Z5nRk
         wJyY9BEsXPWlCGQbrve9OnL3VdIk41gXlbB/Z8cuUhHNQfKKqPA60VbOIv/pgwRvciU6
         y7JRQppW+29yaaz+5kad6QYXxQtCIxqJdEa5/NZUn0HFOxbUWO0b+v+dj2Phpva8qALA
         /8wSyFhxe7QNRrO17H2ay0tTJO0l8K7K+jlBx1AgDxvflEqwlcehpAHP5Buu9q38hKcH
         lkjLXOiODF3D6YVUwevBT7mtH3p9S+IqKRZyBKML8cAjc2YzosPgg8YMRuB0VEgaK3FK
         DsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747148645; x=1747753445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5OdMGtjLFIcrdrNv9jN6bRUk9RHa4iwKrLXSmFvBS+E=;
        b=MMNseea5m6+mzvK4kX4LOrxME/Dw50Fq9uJ9s3J5IPeGXFApofa8lC8Go4mplAKPLz
         7MIrsFCi/7Ha9H8nRljN4yU/3gywXap3xRuortv7GGgBoELIPPN2Ze6XDCDluP3M7SQm
         tnxj4aPx6kKBB0g2BK4k+TzcIEdXAPgNVQShALHSq8gcKLUJN4UHLvr6/wSEBMgtlAlU
         +2ONCK9F23hcN7uyt1TqSeOsYaVtNle5YWZHO7X0a4hfOt0JuU481ZX+1ZS3MPlhNZ/n
         Sd4VkDsDueRHzBM4Le42SEVJfK4JC1P6esUlVsi9A4eMjFe/66v9ycETx1MM/RezHGK5
         FvwA==
X-Forwarded-Encrypted: i=1; AJvYcCW3YEJnH8yvnerdbw0KKHqNFAewnTE9Wl/Ro0pVWjEaigXMzpHFpQ3eBUWDtsroWF1OtCc6wKr/WHRfMexBXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfF0H2/7FAF9YMVrMtZA8/MM8vjub+ZdCLrtljDCd1BvrSEfw0
	BZVV8MjN+Jvo8BCX9IReOTvz3U6s+Puy7pfU4NuYh0Hq7y/ZQBWLgEXN3Q==
X-Gm-Gg: ASbGncsQ75PCDxz64WQRs/bf8BCHIiWp3pMFKhDEVlZ4BeO0o4neb/F1tfcR5W0Vs4V
	N/WHhhryXo6T6ZNlkTf8Iu8c/c89NZeHrBM9D+OBk0PmWphrplbkvK+hjoiX1lhJDTusTFsRCEd
	5kS5/uhwqcgWq3zVlUKgJLh6CU2d9mi6KVx7e+rJLoHp2D4cZ8Ji+obgDpVKa9ATCRgIB5s1m7g
	i1uIBda+wsEVbwL2OSSyUMybAhrnx6OTWyxsk7Oo3dc0RxqhWoybramH7O3kCu3t1kVmNiDmbd3
	hZV18cVrUEcyixDpqJ6vGzAZ7KnUBo1/nFxuO2sus3foooT9wcTfSZvIEbWBHYvT6E7EhRRS4Fo
	yBpqrnutg21Bjx5pQ
X-Google-Smtp-Source: AGHT+IFn6w77ozGG4F0ly97ZAaxGXJU3dRqw6wttJRWEMPmPnlsbu/Uvwz4gVMaM/S2DxGo7v2KOtg==
X-Received: by 2002:a05:6820:1f01:b0:600:5673:69ef with SMTP id 006d021491bc7-609d3082ebfmr2243716eaf.1.1747148644830;
        Tue, 13 May 2025 08:04:04 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-60842b09865sm1946381eaf.32.2025.05.13.08.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 08:04:04 -0700 (PDT)
Message-ID: <f413e1d5-a10b-4317-86b0-2c1cb0dc3df7@gmail.com>
Date: Tue, 13 May 2025 10:04:03 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wifi: iwlwifi: SAE fails when AP sends confirm before STA
To: Johannes Berg <johannes@sipsolutions.net>,
 Jan Hendrik Farr <kernel@jfarr.cc>
Cc: James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, iwd@lists.linux.dev
References: <aB30Ea2kRG24LINR@archlinux>
 <4ffbeb94-ac19-4437-9d98-24981fe6c240@gmail.com> <aB4HC8Iaa6wR5dj7@archlinux>
 <15943a1f-0e5d-4705-b8ef-3f22fa3fe672@gmail.com> <aB4hMsBfyawYatoj@archlinux>
 <902daf8802c723d72fff0155cd0638848ce1bc7f.camel@sipsolutions.net>
 <aB5onavenLymR-QJ@archlinux>
 <8a1c5172bc0fd9d2a33522294d1a2a4c4ceb313a.camel@sipsolutions.net>
 <aCMtCCYtNNl4dL5Q@archlinux> <562c4ac5-088d-4bab-9883-1d4f8eca2b2a@gmail.com>
 <eb59751ab2a22adc6237c05cb0a5519657498613.camel@sipsolutions.net>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <eb59751ab2a22adc6237c05cb0a5519657498613.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes,

On 5/13/25 9:53 AM, Johannes Berg wrote:
> On Tue, 2025-05-13 at 09:03 -0500, Denis Kenzior wrote:
>> Hi Jan,
>>
>>   >
>>> There is a an SAE confirm sent by the AP. It's frame 170 in
>>> capture2.pcapng. It's also retried a number of times after that.
>>>
>>
>> What I also find interesting is that the kernel on the client side reports
>> sending the Authenticate-Confirm 3 times (according to dmesg and trace2.dat),
>> but only a single Confirm from the client is seen in the air trace.  I'm
>> guessing the retransmissions (attempt 2 & 3) are lost somehow?.
>>
>> [64414.164169] wlan0: send auth to 96:2a:6f:b6:d7:9f (try 2/3)
>> [64415.063575] iwlwifi 0000:00:14.3: Not associated and the session protection
>> is over already...
>> [64415.063668] wlan0: Connection to AP 96:2a:6f:b6:d7:9f lost
>> [64416.215729] wlan0: send auth to 96:2a:6f:b6:d7:9f (try 3/3)
>>
> 
> I think it's expecting a confirm in response, but that was already lost
> before.

Sorry, what is 'it' referring to here?

iwd sends the Commit and Confirm via CMD_AUTHENTICATE.  You can see that Commit 
frame from the AP was received and then iwd submits a Confirm to the kernel:

May 09 22:10:56 archlinux iwd[31729]: [SAE]: Sending Commit to 96:2a:6f:b6:d7:9f
May 09 22:10:56 archlinux iwd[31729]: [SAE]: Received frame transaction=1 
status=126 state=committed
May 09 22:10:56 archlinux iwd[31729]: [SAE]: Sending Confirm to 
96:2a:6f:b6:d7:9f sc=1

The kernel then transmits the Confirm three times, but attempt 2 and 3 somehow 
never make it out over the air.  I find that strange since they should still go 
out, regardless whether the Confirm from the AP was lost initially.

Regards,
-Denis

