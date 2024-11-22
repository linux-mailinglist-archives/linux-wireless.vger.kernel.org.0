Return-Path: <linux-wireless+bounces-15599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E679D6181
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 16:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F2C2826DA
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 15:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0684E13D8B1;
	Fri, 22 Nov 2024 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm0LYAU0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B833086
	for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2024 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290347; cv=none; b=Wb18Yr5EUaAHaJG4wOFosMH1SEMXcR6s/ZrTLaetyKcGv9qC/pSxF+TkSIU5Rxk140gKodP9SRLr15QThNniuCFfwuwoNncIoqEX74BJhfG6NkhzWgdux3zLCEu3DrVLrM6FAxlQlv4RT4KJ+Of4lLo12YBKslEJwR7zNyM1yQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290347; c=relaxed/simple;
	bh=lVWYOoaBBazNVwx8HLGaKYliH1P4nIi8J2kwNMjPXX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Cfb1fhJt7N7EHzdMnsEub5n6ZcyQxeU3sExppOXSfDsGJTrhNMZb3+6Ga+z9wFghfE3PHPHlcMy75eKtq5zrorCXrAdboZ3cHeEJdZjJRC4l1GCS4EPCo5JWkDKc/Hf9XHEh/ksj/p9EKVkhaihMY+P82SLM7ZVcwO4+r98okRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hm0LYAU0; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cfcf4df87aso2947866a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2024 07:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732290344; x=1732895144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ORO4fsOZ0CMXrFbWl3UeIo+2f5M+A3sp/yVtBXPUV98=;
        b=hm0LYAU0v2BqrNcP4D/GxUtFa2lDI6GZqIQ7byxB9O+D/AAl1m9NvoiXxHUYnhL7mz
         OgCKlTCdeaFz/yYrmQWaFX9ZvsyX7lIH5054zQ/zvttqa6Qj5LMIXbe7eSHdIfyztHmn
         DyxXlo2BbX57CQvqrfDw3QtHjkMGkX7BQ5UI6Tl/fGOqpvFvPZSBY23VOPT8yT3ydTnb
         95CMVH+zw4qfyaDeWJXnkrYBCl8p/iXW1SVAptGRxov1TwnzFiN+VKu+PLKsij/o3n0x
         SvZN1HDi4pog972MjSaDOJUFvJ4sDfYxdHK3dY5qwHc52RposzXzYsfpjDi5hhgB5Egf
         wcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732290344; x=1732895144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORO4fsOZ0CMXrFbWl3UeIo+2f5M+A3sp/yVtBXPUV98=;
        b=Vyhz0LAXohUTDD5d93AI4iUTUqPlNKi4SOSd5HSUJHbU0hbNEru7t8fMAyEl4xK0Pg
         6U7iIEWYq2zZlHKs741Nqic/hy3knbKg4A8wjwebVBWduTXh/yqDjEJXV8XwF7GO2xyN
         cVZ2ndjM77egGVZ/IQANSbvO/PlUT8IVswNCsBPYIlWjHFgmcym1cjupl9liHih1E+Z8
         Ec0u1Dq1hItS44QBA11eEhwWtqnJc84BNd2ajjktIpGVTrd9oL+dJqcWXd2Bhfxtwvqb
         MWa3PN6oLgPSQdbGSJ0eFXsxQP9tOywNAgZXQFIwcR2cQs4vaQfbSiCazSlJOGBrOWt1
         Sq/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvsEIn2iOmlHvSsSbHoX6sZKhhminSnCRBruZGRekigjx/pE1QZ8C7PjHou7viscPs9H4QxT8mbjCvferhpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRTO6dNiKyfj5Psm54UvY4Smmr+SxXCPNGkp495Hh9x+MNCFpg
	zZlo76aizByfVy52GJNUZshvZxU/UprMZho/uwrldDYfG0kb6GbDxZ4EsA==
X-Gm-Gg: ASbGnctrSyB/3SaY4k44MqBH9TadKRxa8rH7SDweHD8JTiHFoS8qMKcwbRo1uMXpGfq
	g4CPGysLUSG92A5Kip9NIK262iDDU+X0ZSCfGXU80dk3Gk6oXJ4Fo7Qc1VWkQWiJjUM7/JGPhAm
	uXH8bWuDhU0tPkOqzPPp0ZR6DCD+fS0p+liB6IiaYzp0W0fjafBJW9qpSS54nRtuaynBE9AeTk3
	+r+X2DSSpFTJVRVljDzd3Ixag78dmVAg5fiz5N5bF7Gycgr5gyMCfXid/Mg3CtfT/JG6heOYC3P
	9CFWk7/q/+cKhA4+C8DhZa3MDB897kFUacWcFy1YPFwLEQ==
X-Google-Smtp-Source: AGHT+IHwmgZUI1gSzKZ/XLOC8LJAClVI6n/P+vivT7/p777qgOmPGzflj+EOhUyELmVSrJenzUdPKw==
X-Received: by 2002:a05:6402:2551:b0:5cf:e77b:4fa1 with SMTP id 4fb4d7f45d1cf-5d0207b31cdmr2270679a12.33.1732290344288;
        Fri, 22 Nov 2024 07:45:44 -0800 (PST)
Received: from [172.23.31.140] (cable-188-2-10-66.dynamic.sbb.rs. [188.2.10.66])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d41af02sm1040152a12.87.2024.11.22.07.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 07:45:43 -0800 (PST)
Message-ID: <756efc9e-6853-481b-bd9c-a5dc86e03d63@gmail.com>
Date: Fri, 22 Nov 2024 16:45:42 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression "Direct Firmware loading for Intel Wi-Fi 6 AX201 (rev
 30) QuZ-a0-hr-b0-77 failed"
To: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, Stanislav Yakovlev
 <stas.yakovlev@gmail.com>, Miri Korenblit <miriam.rachel.korenblit@intel.com>
References: <ab27218b-5e16-4932-a497-eb19491568b1@gmail.com>
 <f5c7eb4f-fd8d-457b-92c4-8957f70888b9@gmail.com>
 <0158732da5a64f907326f89de8f9c8aa27aae874.camel@sipsolutions.net>
Content-Language: en-US
From: Zoran Davidovac <zoran.davidovac@gmail.com>
In-Reply-To: <0158732da5a64f907326f89de8f9c8aa27aae874.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I am telling you that *initial direct loading is broken*!

Direct loading of v77 firmware, when ax201 is built in kernel is 
broken!  This worked in kernel 6.4.x year ago.

Proof to that is if I copy .77 to .76 and I use my patch *just to repeat 
direct loading* of next file, and 60 seconds later it actually loads v77 
firmware that is named .76.ucode and this works.

That also tell us that current firmware v77 is ok!

Hope that that explains what problem is.

I can debug more if needed, but I am not programmer and It would need 
substantial more time to find why initial direct loading fails and how 
to fix it.

Kind Regards,

Zoran



On 11/22/24 09:36, Johannes Berg wrote:
> Hi,
>
> Sorry, what, I'm confused.
>
>> it will not even try to load next working QuZ-a0-hr-b0-74.ucode
>
> That's intentional... We released -77 firmware for this device in 2022,
> a little over two years ago. We can't and won't support ancient firmware
> *forever*. We've already supported it for a very long time.
>
>> either direct loading or with included firmware in kernel
>> ("CONFIG_EXTRA_FIRMWARE="i915/tgl_dmc_ver2_12.bin intel/ibt-19-0-4.sfi intel/ibt-19-0-4.ddc iwlwifi-QuZ-a0-hr-b0-77.ucode"
>> caused kernel reboot) and that kernel 6.4.X could load
>> firmware direct or included.
> I have no idea what might be the issue here. Perhaps your kernel ends up
> too big for the way you're booting it? If you insist on booting without
> initramfs but with iwlwifi built-in, you need to debug and fix *this*.
> Or I guess you could always try probing/binding the driver again after
> the system really boots.
>
>>   vanilla kernel from 6.11.9 log:
>>   [    1.903903] Intel(R) Wireless WiFi driver for Linux
>>   [    1.904006] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
>>   [    1.906832] iwlwifi 0000:00:14.3: Detected crf-id 0x3617, cnv-id 0x20000302 wfpm id 0x80000000
>>   [    1.906890] iwlwifi 0000:00:14.3: PCI dev a0f0/0074, rev=0x351, rfid=0x10a100
>>   [    1.906891] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201 160MHz
>>   ...
>>   [    1.907036] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-QuZ-a0-hr-b0-77.ucode failed with error -2
> but I guess that's when you try to have wifi built-in and no firmware
> built-in
>
> johannes



