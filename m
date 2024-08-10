Return-Path: <linux-wireless+bounces-11253-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F01A994DC25
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 11:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02751F219F9
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 09:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0065114C586;
	Sat, 10 Aug 2024 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5o8F080"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8AB12F399;
	Sat, 10 Aug 2024 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723283986; cv=none; b=bjYmRM4v5agBEZUEYwt8Vj0OWD4j68anUemsXf7WHfE5voOwvE6Oxe3DAEXt/IrKK9wsfu6ZQ4sZCTCtoJGTGQZ6Fld/WVozVgIW+w0nwIJxgZODYOGlehENmOSJqxr9i8Ra8cUQED1r0Mxtibu7F/oewGZwELb2rBII/kuRDZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723283986; c=relaxed/simple;
	bh=Eos5OrWju3q9VNj8863o2jSSNytrHsCwXWdpjZax35c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4mHqJphfUYAPA+eZ0tUMeuYfR23sB7CdUdYhVzv7OFhp0lLh5F6S6POBFRBLhY2I6yhPCNJW0xzoW6pInGaNyhe6qbDTocYgUM+6pSwVpZIkA+e2hm/R4CZ1EHvOUFJ7uIDI3pZm5exslCzmthGoyXFp7djiiqUk7mV0igWS/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5o8F080; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bb85e90ad5so2552814a12.3;
        Sat, 10 Aug 2024 02:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723283984; x=1723888784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ufjWIF7ovSvw4Egs+nhOKZIcCZ2hYtulQ4jV8EnQZKQ=;
        b=b5o8F080SbKmtJeOhdv7LAG0Nbg7HuwmGQ6G9Me23A4OHI9VK0uEj/TKkPba4IePLy
         xpjzGBD4UmJotudRz2aTpKSRd4/4Fw8VpVgOGQE39WA0xSU+eGb9NYx3zgcqdZIadQJj
         mfNYkEtAf3DRQz1oERjOcSNx/JpIZMQ218fB/5sStMLrvep4k2WpEgO2qMab/XVBFRLW
         jMiteSJP66JZPA3D7MeQp/GjrugnQ0jdfQbeH5sDO99t9+f7kP8nfiZlUrfDkKkyD/5C
         p8jOzM9xL6UYM23zIwkimkosIHdSMmEbAqHafOhasLrUXqLhAuxlLm2T+SFrP+1TTeEw
         5z7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723283984; x=1723888784;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufjWIF7ovSvw4Egs+nhOKZIcCZ2hYtulQ4jV8EnQZKQ=;
        b=bV6NdQZ9A+xOJkvjf15phULKNLUAP4LZtghprwA6vZuc8IcPXIzn8TzxaYrN5qcc7a
         BTXcQLnjJIwnat6MAIv4/sn7MXUuxk+pyglAOxG+Er7+uLEi6/6AtR2rPJvEhWacXXmV
         XvLMO58xVKEV9QzwP/KoqhF30bxZEBU8MviqwoDZdcezPrgSXNzH+BKEOIYFo41H1MgZ
         B6Wf/u8Sw5FmSnQnMYPmu4C2FT+fHSar553HaeK7Xnk8/7TiuiMySxbS3woxD+noY7pt
         nPQshiX5xUV9RKMKRUVDJ4fTF627sovLvO+J3DQdYEnNktVvixsXQ4YbzRi8sz4V4GdB
         4wuA==
X-Forwarded-Encrypted: i=1; AJvYcCX+adseMKlRyUudVfJR3Lc9x2plr/qwe8OgHBLOC3RcXKMAS+/87gLKy36JzJ5d68ewC2k8td6xpu5TcdQ+nKd7iNQ9lqNms8h/HLWLkNXcG0h1ujtOuN+wJeOsZKohi4FHEbOOOgz43RslKeKYUELtCVWkoQf+IfW9On4tSw4=
X-Gm-Message-State: AOJu0Yw5UaIS1ErUtgPJ2oALn0aN7N5KeMvM/hDBD+qvxpx/7qwTLZsf
	ecgjJijpk9SjfYyOafdCwbmVyj9JKqDD+MKhG9x2qymeiUycU0RI
X-Google-Smtp-Source: AGHT+IHuibuosDraN54YWhLgpVT4Q5DmW8EepJIgbRpRL8oKvJymiyx4wsc5KPlRFFSX6vVctDq62g==
X-Received: by 2002:a05:6402:26c9:b0:5a2:cc1c:4cf0 with SMTP id 4fb4d7f45d1cf-5bd0a535ccemr2285582a12.7.1723283983467;
        Sat, 10 Aug 2024 02:59:43 -0700 (PDT)
Received: from [192.168.1.19] (net-93-65-244-85.cust.vodafonedsl.it. [93.65.244.85])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a60984bsm482259a12.79.2024.08.10.02.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Aug 2024 02:59:43 -0700 (PDT)
Message-ID: <35593d3b-e4df-45a3-9c9b-101420aedff8@gmail.com>
Date: Sat, 10 Aug 2024 11:59:41 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: check basic rates validity
To: Greg KH <gregkh@linuxfoundation.org>
Cc: johannes@sipsolutions.net, sashal@kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 javier.carrasco.cruz@gmail.com, skhan@linuxfoundation.org,
 stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
 syzbot+07bee335584b04e7c2f8@syzkaller.appspotmail.com
References: <20240729134318.291424-1-vincenzo.mezzela@gmail.com>
 <2024073014-borrowing-justifier-18c8@gregkh>
Content-Language: en-US
From: vincenzo mezzela <vincenzo.mezzela@gmail.com>
In-Reply-To: <2024073014-borrowing-justifier-18c8@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 16:23, Greg KH wrote:
> On Mon, Jul 29, 2024 at 03:43:18PM +0200, Vincenzo Mezzela wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> commit ce04abc3fcc62cd5640af981ebfd7c4dc3bded28 upstream.
>>
>> When userspace sets basic rates, it might send us some rates
>> list that's empty or consists of invalid values only. We're
>> currently ignoring invalid values and then may end up with a
>> rates bitmap that's empty, which later results in a warning.
>>
>> Reject the call if there were no valid rates.
>>
>> [ Conflict resolution involved adjusting the patch to accommodate
>> changes in the function signature of ieee80211_parse_bitrates and
>> ieee80211_check_rate_mask ]
>>
>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>> Reported-by: syzbot+07bee335584b04e7c2f8@syzkaller.appspotmail.com
>> Tested-by: syzbot+07bee335584b04e7c2f8@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=07bee335584b04e7c2f8
>> Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
>> ---
>> Hi,
>> please note that a backport of the same patch for v5.15 is available at
>> [1].
> Please resend [1] as it's gone from my queue.
>
> greg k-h

Hi Greg,

I've just sent it here [1].


Vincenzo


- [1] 
https://lore.kernel.org/all/20240810095432.89063-1-vincenzo.mezzela@gmail.com/


