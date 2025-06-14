Return-Path: <linux-wireless+bounces-24102-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD224AD9E51
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Jun 2025 18:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1ED07A5A3B
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Jun 2025 16:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EABB1C6FFE;
	Sat, 14 Jun 2025 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcIiagrE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCF3DDC5;
	Sat, 14 Jun 2025 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749918813; cv=none; b=Zj4HwSplSmlBhXIZaMSBXuyz68Tncl10zHZ4u3cz4zQNsMljsD7oBq7875zDeoPe7mrP4J9QtjHoFiUhP8A1FEkqJH4C2WMk06ZS/usZfOGbqN/K/xdrH6aZXxXhiNsLGA1xAywUqi9VuyCwkAyYWXQxSwZBirt8eSPfc2Q5dtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749918813; c=relaxed/simple;
	bh=Mc9g/mMBVl0hoLxyjGjJDGEV32MkXt4yu8l6bhjTqlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UhEIZzseCZ5CxKhpvN48oZrikDyW36zF5JU6bjmUTUJjD3R8nGZ2GWB10/lrwSJqVimoWI9B4cGgB4+UfE86ZniGUEznUS+3c8F6obks1iR6uZkEA7Kn5mJRJ8phmjQGqN7q31z9H/oeg1tsS9+fx/eb5nDdoChiiN7OFoWaTEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcIiagrE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-451ebd3d149so20557045e9.2;
        Sat, 14 Jun 2025 09:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749918810; x=1750523610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rRVQLuTs3t7N1YX7qJ0PJ83crDrsg5WIEnLObX4tldE=;
        b=HcIiagrEVvCBlyKpGnPY2E5l9tdfZWjD35JQ/16MAAfxWfeFY2CiUHEGeXkDQ5DCYE
         5+E1Nt6DIdrJUHjwvnCEN28SWpSSRQa6f6jhVUXusxAlxCcyAa8bdWB2EYgI8u7w0Npf
         pRFdfLv46BoCXDp0Q8D7Ds4WVqG04Do90NxqVxLF0NLhC7Bx0oUBQlFSUuSsWGCtLdDU
         g111ELNssG53FA2eD1yMjhjTFKRNKs+rihqchM7hKVcanXs9hYy/66CTOKdCLvvOptAi
         Edon2Kl1od5lWD7JMW+TLy2sr4R8AC4/8z29ej9x9A+1H2KlOmQdGN7zALLOI/Wx7t9q
         SWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749918810; x=1750523610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rRVQLuTs3t7N1YX7qJ0PJ83crDrsg5WIEnLObX4tldE=;
        b=apQlCoZBmkW/H8+S9HNEHbpeUEfXJ9rShi6EfMThEwW66243QzWH1I2rwO3aarEZ5X
         U2UkA4QaM9u17CuwJh4VbwzA9R+A8botvnsuZJzTJnFaxA6Obi77mvmVB+1Dg+LpBNHk
         RbyFwUOR9eQAvnEWOsF9xDiAvrKxjnQ0Kep7Exq3iaP4rOqqjVUtFKOfCyZ/eCOcaYT1
         8uKHJuZtl5bxbILrTDaT7kS1ZxVRZ9CbzeOXDaMDQMM2fepvLsGT/6lGqsCr25YmB22z
         Kot6bkwR7NelwuX0zWY6ScV07avss5VCx2jmeMH1rNotWquf5oSze0GotowVv6raMbqh
         MKdg==
X-Forwarded-Encrypted: i=1; AJvYcCVEEu82Ag/aIj4DwXo9xumudSeSsWAcy8Ax1q14iUcNfwx4+u6d+V0LQbbwMJX7wLFruSey8T3Ars7fT9nn7j0=@vger.kernel.org, AJvYcCWwNxSlfYsa+gnU/EuouOZWD+NhpxpZvKrNBqkq2UoHf7PQWi3HuHP3rzhmEskyijNrpsQwm/LKMVHR7HM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUycTdlz9tv7qD2Sz3SrHTfrB52GcqnXZsoXLmo6oobe4tItMe
	FhWJpI9yw/1KNtNRNZCze0xSSdw571zqp9Pl+R7bQrZwIhAOJm8wBZ2k
X-Gm-Gg: ASbGnctsuth0T7tk20L0kZgLKC73PRbUVFcpcvIBlF4m3kyj7lPcMy3KpyPwLfHJZrN
	QJ84eSavSTzZPrTNeQXKBKxT6lCJaenapXp9zixnaPFxl96scjy67W0ppvpQifnQH7Tu1jvDI6Q
	jMzjDTzRNU3poEBs+M1hCzHHWZ1yHwpLTWdHmXjzBXl4ei7QogB/rK6+HHJ+jFmAI0NtiMlFrA6
	ZvsWIq/pz8UdhgMXK5JJwqEwQmZ77kWtUH0iHza/Ic17KGbsa9FcEeDVJJ6zxVv7SxZi9GgxJNa
	u2bSNgceR2F3nFwT3FeWoL7FBtRzo4gYSH9ImIRLEkJJsBAOXfBQRMerSdWKUc7f2HI3cO4xlFw
	UekxqRCSjLY+7D1LRvvqYqzBlS6g7f7kepxA54rtxYdsXMsH00/xv2YpINLE+F86JyCo=
X-Google-Smtp-Source: AGHT+IHPm2YETQdRcyhGLWGmJhloCz1JAThFE6G+ifkAVCY/pPuAelhjGCQsPMdx4iQWi3AdAUSfMA==
X-Received: by 2002:a05:600c:6814:b0:440:68db:9fef with SMTP id 5b1f17b1804b1-45344da0e63mr4007955e9.20.1749918809637;
        Sat, 14 Jun 2025 09:33:29 -0700 (PDT)
Received: from shift.daheim (p200300d5ff34db0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff34:db00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224cb2sm90519355e9.5.2025.06.14.09.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 09:33:29 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift with esmtp (Exim 4.98.2)
	(envelope-from <chunkeey@gmail.com>)
	id 1uQToR-00000000GqF-15UA;
	Sat, 14 Jun 2025 18:33:28 +0200
Message-ID: <eda7bc56-2fb6-4566-aecf-3a18de4029c3@gmail.com>
Date: Sat, 14 Jun 2025 18:33:28 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: carl9170: do not ping device which has failed to
 load firmware
To: Fedor Pchelkin <pchelkin@ispras.ru>, Dmitry Antipov <dmantipov@yandex.ru>
Cc: Christian Lamparter <chunkeey@googlemail.com>,
 linux-wireless@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
References: <y4ufvifcearf75qds5hlro3rfiadwfwlixz5xg3w6jjozk5sdg@7yyfsdvyehon>
Content-Language: de-DE, en-US
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <y4ufvifcearf75qds5hlro3rfiadwfwlixz5xg3w6jjozk5sdg@7yyfsdvyehon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 6/13/25 10:19 PM, Fedor Pchelkin wrote:
> Dmitry Antipov wrote:
>> Syzkaller reports [1, 2] crashes caused by an attempts to ping
>> the device which has failed to load firmware. Since such a device
>> doesn't pass 'ieee80211_register_hw()', an internal workqueue
>> managed by 'ieee80211_queue_work()' is not yet created and an
>> attempt to queue work on it causes null-ptr-deref.
>>
>> [1] https://syzkaller.appspot.com/bug?extid=9a4aec827829942045ff
>> [2] https://syzkaller.appspot.com/bug?extid=0d8afba53e8fb2633217
>> Fixes: e4a668c59080 ("carl9170: fix spurious restart due to high latency")
>> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>> ---
>>   drivers/net/wireless/ath/carl9170/usb.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/carl9170/usb.c b/drivers/net/wireless/ath/carl9170/usb.c
>> index a3e03580cd9f..a0bfa0c477ee 100644
>> --- a/drivers/net/wireless/ath/carl9170/usb.c
>> +++ b/drivers/net/wireless/ath/carl9170/usb.c
>> @@ -438,13 +438,18 @@ static void carl9170_usb_rx_complete(struct urb *urb)
>>   
>>   		if (atomic_read(&ar->rx_anch_urbs) == 0) {
>>   			/*
>> -			 * The system is too slow to cope with
>> -			 * the enormous workload. We have simply
>> -			 * run out of active rx urbs and this
>> -			 * unfortunately leads to an unpredictable
>> -			 * device.
>> +			 * At this point, either the system is too slow to
>> +			 * cope with the enormous workload (so we have simply
>> +			 * run out of active rx urbs and this unfortunately
>> +			 * leads to an unpredictable device), or the device
>> +			 * is not fully functional after an unsuccessful
>> +			 * firmware loading attempts (so it doesn't pass
>> +			 * ieee80211_register_hw() and there is no internal
>> +			 * workqueue at all).
>>   			 */
>>   
>> +			if (WARN_ON_ONCE(!ar->registered))
>> +				return;
> 
> Is WARN justifiable here if it concerns handling a predefined error
> condition?

The driver has many more WARN_ON_(ONCE). Most of them are from "back in the day". I think
carl9170 predates Syzkaller by something like 5 years or less.

In this case, it would be good to know if this only happens with syzkaller, or with some
dogy device (be it the hci, or maybe the ar9170 device itself - they are getting old by now).
I mean Garbage In => Garbage Out. But yes, it shouldn't crash.

> I mean, yeah, it avoids a crash in the completion handler but kernels
> with panic_on_warn - the ones which Syzkaller runs - will still stumble
> here for no reason.

I bet there is already a precedence for this, if someone knows it or has previous decisions:
Please join in!

Regards,
Christian

