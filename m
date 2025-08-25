Return-Path: <linux-wireless+bounces-26582-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B61B33E7D
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 13:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A180317DD8C
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 11:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06582D46DA;
	Mon, 25 Aug 2025 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhB5Is0z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D13738D
	for <linux-wireless@vger.kernel.org>; Mon, 25 Aug 2025 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122944; cv=none; b=WRsRvWKDeUFveNuRWdrULMn+ONtWwasJkWbXb5LT7PljuNWRnM6Nqv4KOFG4yzsY1uWoux7GWLE1BIiPhHWEC86VmYxMEur+aZNQRXD88mRhHIE6rGldvb8NHjgYqkEf88Gc1LZJBUpFrW1gz0d5aVGOgbtdYd2U4IYLrN98mEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122944; c=relaxed/simple;
	bh=wh4ctjMum6qXVLjCmzfbLlXL/OUrc6/bczg6MAPTW4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uqYZAZPQogbb72daL2QpRL57wvHPh7M9ZMWFi5pjIPQdQtTfTPRyVmXDMnVOh7X9+gP1zOhrrRPGzxul2heNAXeeThbX3WTOXlcTbg8oPZ6q5McMy0VAsIjNikEeiomBoroaBVfEuDTXPmOirsOB5vFGrupG18EhhJ6sVRED7i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhB5Is0z; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b0bde14so23032955e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 25 Aug 2025 04:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756122941; x=1756727741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UpJ2DCe4Gamv6Mrh1lHghP3N8MU8ypDdUY7GeyX9/7g=;
        b=bhB5Is0z6k15YvOZpo+Rhx6difZrOrzBPa80yFACpfu1KHjiiVO9iCwOB9C1qsLGgN
         ySEftquuIYKz7zoLltZ+SKUplh7aVJnXVxJ9N7lGyYwUq7cA6CQbGzbh/vioj9SJEi1+
         Y5KB16MdXunelt01V6nUN940qO8/kc94OWYRYsFTiT3vv0dQy5yAGU/T6awRu6gwYyqg
         TLPniuUKxs1dHx5NCGkS+fCUxvN5XtRZj17coPPK383eYccNr67Q5E/79P9AOy3G+a+H
         GAqzMT+LbN1bTrFGZU4JP+83Cl0eyZiI0lv2HHwPipeWjY7LJo4IDIJwSf9OZrW28DFp
         BE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756122941; x=1756727741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpJ2DCe4Gamv6Mrh1lHghP3N8MU8ypDdUY7GeyX9/7g=;
        b=Vnv16iz9xJfTvTAbsVG0dzItk10XqrbcVptg/co7dFrO0DMHq1eSODzBD0sTQ7fc/N
         KGkCm1s9RvvX6RJwoaU9vLnO2V6cv8S5rJy4mimlnUGZiGkxnQtzaPM77Sjp6mJDyCAr
         n4HhPVyvICKbCec3OSC2+0mNkpZJOUkBd+nLv7G3tTOPbMri1Y9yZfGDoX5wF0u3bJcb
         N1749Ti3JAd9xdfAAUKLwFf755FyebC0q93f/RS5Q3Itixz5vAEPx/m5JVkWpIJ4pFCE
         lYlryrolyhHvXL1eiLxxuMlxIyhGotn6zLqq0Wkumc6dP6YuI5Aaa8mYNnCOWYBZwC9S
         n8Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWoq+wT0LGOY1QjB108ZdPu5BCDfUDgHeDf+jIP+8YQqQJigZneoITv5qn+8phfwJ2BoY5RyQu7x+BmZipo0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxd6x/FwHFjmMBQez6FRiQNW2ayJ1ITZBl3bbJmvHXiAbCz4O2
	t96yNPd90tgFlVyE2HE9BAbHyo9kx5RQEipsUk4XiODju4yRQKo6N/vB
X-Gm-Gg: ASbGncvr+DNCCqLpf2np3iV3rxn+qg3NBzlvlQK9YcgAMzgDBjtHhPWoTJEjR7+IXqr
	vjiNbcVvFpzn3p1kAtr507jFVtm5nG2JIviudmyLqSbb/6BOyaBN/QcKFP/+flcJiiuR6eQUBpt
	H26RhR8Ai2KCdd62g9tjUxBrKwjpfe+4llweqVQxxbLELMQ7v4skiULdqE02iq3c6RLNaKfNrpR
	L6eRne6atAtLRB9UHNogQ9byoQZO0zHUFDn3cmCIKFLjzpmqfJjqqmHhxJDxfiWpb7adqIqeHLe
	MSW+4OqVLsao2O+H6+71FPn234WYw82KcWyIUE6Bf9V9sXOqKCYhAnpQnroDbG8zdmG5qzmYFa7
	S5KaaGivUtIuI8YkvP5nmKMLwwypAdA==
X-Google-Smtp-Source: AGHT+IEkPA2R15dQDACSBdNvUB8odhXO+PQ3jxJSAYlsNIvxW2/XHnDaQczfq2K638GMlDaOpaXHKg==
X-Received: by 2002:a05:600c:4743:b0:458:bfe1:4a82 with SMTP id 5b1f17b1804b1-45b5179683dmr134925305e9.16.1756122941170;
        Mon, 25 Aug 2025 04:55:41 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5757453fsm105090445e9.14.2025.08.25.04.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 04:55:40 -0700 (PDT)
Message-ID: <d05522ce-48e6-4e7a-bbdd-327a6fb3dd99@gmail.com>
Date: Mon, 25 Aug 2025 14:55:39 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Remove TL-WN722N V2 from untested devices
To: Ping-Ke Shih <pkshih@realtek.com>, =?UTF-8?B?0JDQu9C10LrRgdC10Lkg0KE=?=
 =?UTF-8?B?0LzQuNGA0L3QvtCy?= <debugger94@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <CAAN7eZ7QKEeQgNHEBuZKy4Gqg3oqpGi6BUdOVBOxPN7dedhVJQ@mail.gmail.com>
 <6851d6d86fb84b2d8f5a787906bc58cd@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <6851d6d86fb84b2d8f5a787906bc58cd@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/08/2025 08:57, Ping-Ke Shih wrote:
> Алексей Смирнов <debugger94@gmail.com> wrote:
>> I have been using this Wi-Fi dongle for many years now and have had no
>> problems with it. The device is quite old and known, dumping its efuse to
>> the log and asking the user to send the results to Jes.Sorensen@gmail.com
>> on every boot makes little sense. Please apply:
> 
> I'll rephrase commit message when I merge this:
> 
> wifi: rtl8xxxu: Remove TL-WN722N V2 (0x2357: 0x010c) from untested devices
> 
> This Wi-Fi dongle has been used for many years now and have had no problems
> with it. The device is quite old and known, dumping its efuse to the log and
> asking the user to send the results to Jes.Sorensen@gmail.com on every boot
> makes little sense.
> 
> Signed-off-by: Алексей Смирнов <debugger94@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
> 
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/core.c
>> index 831b5025c634..113e01df0902 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
>> @@ -7815,7 +7815,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
>>                         untested = 0;
>>                 break;
>>         case 0x2357:
>> -               if (id->idProduct == 0x0109 || id->idProduct == 0x0135)
>> +               if (id->idProduct == 0x0109 || id->idProduct == 0x010c
>> || id->idProduct == 0x0135)
>>                         untested = 0;
>>                 break;
>>         case 0x0b05:
> 

I propose we simply remove the entire list of tested devices. It's not
particularly useful to tell people to report if a device works or not.
If it doesn't work they will report it anyway.

