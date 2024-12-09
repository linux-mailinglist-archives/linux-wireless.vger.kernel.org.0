Return-Path: <linux-wireless+bounces-16027-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EAA9E8D6C
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 09:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA4C18852DD
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 08:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA4122C6E8;
	Mon,  9 Dec 2024 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRiMP4BB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19CA2156E1
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 08:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733733047; cv=none; b=OAdmFsJn7ylScSlNBf0Ob2NVIkDsURk28TRRvoQ3+7NxkN/c4WvyJ3etXDvVKB+KQ8FiJfO1BZs/6xcuqyH7SB5GoW5DCllaIybsLGlmBUhBYZedzJ4UdHKDhm7+zZ83o00e2ZwUdX2OhTfNxj7mO+IWQKv/ftWcvtw6WqY7Mpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733733047; c=relaxed/simple;
	bh=1d2UQs4IpJLHgNHjQ0N7DB/H72rwjrFm6x80oXir/GQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bui0bs7NOmbyQ/BqyvCYMyD0YRsOXEXclHFY6PSyssa5Kvg17cf/zTPyLJcgssI1s06/IVmnnFHOt3EborbB6zWuTm2f15kvHCLZn8d7yHJaGaQdRleFUDRylCK0FbzzJAq9bJmPxPpVjVJykOIHsRNyFxPFvujfWJt/53ZhBG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GRiMP4BB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733733043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBKF2UFZWXbCYwAhv8QttLFQKMvyT8IMYojBhS1/oT8=;
	b=GRiMP4BBoOXcEbPQL+CxzFl156wy66nO/c9zq5/0AZDsVWho05QXTIRs/qyc0CZuAW1N/1
	J8afIrdUEtzfiDewWLGVQrYqDar8AtZw47SK//XDNP3HWYKFUXaKsZR7c0SkFh/qEL4i79
	cytDKbCBCTAV3T+uBnwcrp/0zZFTv4o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-kas9BU4zPdqUA9UgdzUXXQ-1; Mon, 09 Dec 2024 03:30:42 -0500
X-MC-Unique: kas9BU4zPdqUA9UgdzUXXQ-1
X-Mimecast-MFC-AGG-ID: kas9BU4zPdqUA9UgdzUXXQ
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa638b40b1cso305890066b.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2024 00:30:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733733041; x=1734337841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBKF2UFZWXbCYwAhv8QttLFQKMvyT8IMYojBhS1/oT8=;
        b=t5qhTCdfVYN7kAfU+DVG3GXGjUP2na8EtJOGsWQ/z+LdzJ60Mw1ZT/iRcpnGhT2KWS
         fA2eiJSfCIRqExtOEEQ61+L0pQTxeFdiV5jAZ+fehAbuGau85+T0EQ22/jKtroe9UldS
         iWKUiuRkElZbDK4teKvZi0g6Ec96BTCCD3ryjNByO2/SYsfYWBBFOObyqbaGSot7YEiH
         6rY9CkBw4AoUAraX3k0kHbKtfrq1yKQXLNHDDKxqtJ2AwwlFQsWUBt1RNOFz3TVNZc0m
         5wNh2kCR+fsFsQqCLOsn8ULGER8E9Zh0sG3lB8Stg3DB1faVC2083lpH+fGGiypXFNIr
         3j1A==
X-Gm-Message-State: AOJu0Yz56ATh7UMhvnHmU6Zf+9tz+eYUMBoztNGnlQuJeYPwwYpxft+a
	FuDlI91gT19cIGSi9YRpKCqbgrAY0kVGn/X9D0aZmiBOq/oQFNfore7qdq0A++ZXMKUFgAiXegv
	5VJ6bYoH8LitNcnSvTp6WCPpcu68g1jRixApyCo9o8bC5EPC9VJUEI2sTrMy61dU/
X-Gm-Gg: ASbGnct7JtuQtbdr9l4coA+rCglxAwg231kKdvFCv/peMGQJTCUgMrsoPtlAhFanVT8
	+T5B2aRwM25fJ1OfkgEnXxObTCgYePLHaXvuqcBlaaANFa3pKWKTgGl/+D0jLzwVVUTPyTY/Ii/
	c46kvnyzTii2WufXzFbi56KLlrKNqj69JTC5rsblaSpGZE9Rn27sDtiGoDY8tvV/mkV55/l7uB2
	6UeG9HPlirsFQq4L4ghL1pR1jBAecnYMQjTLZCHPN3JMGdtSquMzQ==
X-Received: by 2002:a17:907:938a:b0:aa6:851d:af4d with SMTP id a640c23a62f3a-aa6851db0ddmr295609266b.21.1733733041416;
        Mon, 09 Dec 2024 00:30:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEq7O6vhfSo0hMIn8Em0ocaUBDqo5E0XsXucfSOt0kTSkILyqyAJlHkBj5DDT0CDvMJvO4tg==
X-Received: by 2002:a17:907:938a:b0:aa6:851d:af4d with SMTP id a640c23a62f3a-aa6851db0ddmr295607366b.21.1733733041066;
        Mon, 09 Dec 2024 00:30:41 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260e2c31sm651505666b.180.2024.12.09.00.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 00:30:40 -0800 (PST)
Message-ID: <1d59a602-053a-47f1-9dac-5c95483d07b6@redhat.com>
Date: Mon, 9 Dec 2024 09:30:39 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtl8xxxu: add more missing rtl8192cu USB IDs
To: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>,
 Kalle Valo <kvalo@kernel.org>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Peter Robinson <pbrobinson@gmail.com>
References: <20241107140833.274986-1-hdegoede@redhat.com>
 <6cf370a2-4777-4f25-95ab-43f5c7add127@RTEXMBS04.realtek.com.tw>
 <094431c4-1f82-43e0-b3f0-e9c127198e98@redhat.com>
 <8e0a643ecdc2469f936c607dbd555b4c@realtek.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <8e0a643ecdc2469f936c607dbd555b4c@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9-Dec-24 1:26 AM, Ping-Ke Shih wrote:
> Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 18-Nov-24 3:23 AM, Ping-Ke Shih wrote:
>>> Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>>> The rtl8xxxu has all the rtl8192cu USB IDs from rtlwifi/rtl8192cu/sw.c
>>>> except for the following 10, add these to the untested section so they
>>>> can be used with the rtl8xxxu as the rtl8192cu are well supported.
>>>>
>>>> This fixes these wifi modules not working on distributions which have
>>>> disabled CONFIG_RTL8192CU replacing it with CONFIG_RTL8XXXU_UNTESTED,
>>>> like Fedora.
>>>>
>>>> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2321540
>>>> Cc: stable@vger.kernel.org
>>>> Cc: Peter Robinson <pbrobinson@gmail.com>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
>>>
>>> 1 patch(es) applied to rtw-next branch of rtw.git, thanks.
>>>
>>> 31be3175bd7b wifi: rtl8xxxu: add more missing rtl8192cu USB IDs
>>
>> Thank you for merging this, since this is a bugfix patch, see e.g. :
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=2321540
>>
>> I was expecting this patch to show up in 6.13-rc1 but it does
>> not appear to be there.
>>
>> Can you please include this in a fixes-pull-request to the network
>> maintainer so that gets added to a 6.13-rc# release soon and then
>> can be backported to various stable kernels ?
>>
> 
> This patch stays in rtw.git and 6.14 will have it, and then drain to stable
> trees. For the redhat users, could you ask the distro maintainer to take this
> patch ahead?

That is not how things are supposed to work. You are supposed to have a fixes
tree/branch and a next tree/branch and fixes should be send out ASAP.

Ideally you would have already send this out as a fixes pull-request for
6.12 but waiting till 6.14 really is not acceptable IMHO.

Note this is not just about Red Hat / Fedora users, other distros are
likely impacted by this too.

Regards,

Hans



