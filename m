Return-Path: <linux-wireless+bounces-2886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024AF843F6A
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 13:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8542E295AD2
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 12:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84427690E;
	Wed, 31 Jan 2024 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NitBhiFJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D4179DB6
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706704120; cv=none; b=X0ErdlqWK7jG/SbCPMT3xeR71swHzgmwHtBpxlbQFHzpp40sqj849urpPXcM20RW238gDrjVi5TTqWJgKrjnZCIYWETJaLCt3W20KNZP5+VQrcPhgs3BIMfJn0emVmzG0UCjm5rY9P/bLw8tb4nJaxr9wMTNjpBiF+pSBNWzZJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706704120; c=relaxed/simple;
	bh=qAIRzLGhu9tpKiBbf4s4IHZESQc66rUfe9T2E/kYCKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U3olfqIeIN4PkpruKrjVJlvdBzqkYfLEhCP167aPOW1FoZ7u5e1exT7tJIlkMvtDUki1uL8u/JbvZCtbm/k2Zm0suQNL168Cm/Xdjj/84penM3VHOt95hxm4MFFK4psiN6QJQf5OHMx9CBgXqUmtqTtWhwHCIk0v0HeSN2W9sGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NitBhiFJ; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6432ee799so4964486276.0
        for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 04:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706704118; x=1707308918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o6fPFLRogoez4lUvnD9zuYyX17OKr+lSjtZ0hdtK4gQ=;
        b=NitBhiFJ/EX0IaOHxNYiIkesWU4oukYNvGLM0CCWgLx4h7S86NKl3L5OaZAEZWm+KZ
         432TwCXQrUldqh9iA4jv2UmQfVO6q7T9zriNC9MOPabYOv+Ep+2giwEWuLntfUPqueTR
         QFKy25VlemS/3859IihrLpu9Zi4rh26K5U/AIqXdeqgu/43xCBCb7defihvBVwuCvpQT
         IVVKx4xi5HJ0Wz/7k/061TIInKfoVhmGeSnkhsVUepRm8tc+0lHtA+8nqywcUj8ApiUb
         YLiqFP7ztUT+5hgthePMG5zubyryvxCtbOqdSbBEwLGrxSh6oTKZHTHBenWafj43c3ug
         eZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706704118; x=1707308918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6fPFLRogoez4lUvnD9zuYyX17OKr+lSjtZ0hdtK4gQ=;
        b=DDgAdwIpIK2Xowx6zyLnJ68n5o8/Y3GrtDQhz1Y6k1O+DixZj+590yHt1CRm+F0nkw
         gN3QqboguXcqb5898mPyfCnBwqlOLr3I7DKiRI4hBj9ETiE2oow6WaB4nh9KFsmf1Rf2
         M1kXHGcrhZOhKu85xjpJRaP4zK+ZN1hw5g+zDGAvSuc0Mg8mh9yM7LcfKquLKl7CtTkG
         nUFpyu6OIpDVwRbIVlJDxCs1qGsudSrRBwYrjmkFD1T3XxSomP5OvWk4wPvnVaZ5rgP/
         l3lOQ8MsaOozi40kbDzjzx22u0/s0CyPdzFtcrDK9NXuDOWTTIozYkKKGGU6JMBr5u84
         NvSA==
X-Gm-Message-State: AOJu0YwE1jv/2r71UYtKKVDT5aX49mHu3uEYZdxxRyuCNGncsWm1r6AT
	M652PuseBsR250f/85JFeYJbKOBHfMng+qrOIPcYHjUxLkspLodGmSRqTDktroc=
X-Google-Smtp-Source: AGHT+IG7C0vBUbXvYLfEOWifYXv1EhJbV02s1Ag/e3h63zpdMxv7FSpFj3fUmVbcLnDtjJYV8b1i5g==
X-Received: by 2002:a25:9c48:0:b0:dc6:9b89:3f75 with SMTP id x8-20020a259c48000000b00dc69b893f75mr1370030ybo.40.1706704118086;
        Wed, 31 Jan 2024 04:28:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXqgUX7oFOcIwd8hNTNZTtRcGQz7UBLezi+WmUKI+vVCa/geaxtOLyaUe1GIvhIoNn+xG0MPpudz0yq1trvE67Sb5KrO7SRgWC2NOn7nsWbatmIvUmzVGzO0PSxm6KNTxyt85jjpNSKV5tr
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id i18-20020a0cfcd2000000b0068c471ad935sm3662820qvq.70.2024.01.31.04.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 04:28:37 -0800 (PST)
Message-ID: <7a62031b-ad1f-4da2-8217-19a5d7fdc0f4@gmail.com>
Date: Wed, 31 Jan 2024 04:28:35 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k multicast action frame RX
To: Baochen Qiang <quic_bqiang@quicinc.com>,
 "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>, ath11k@lists.infradead.org
References: <dcdbd757-ad6e-4fe0-a0c1-fe328431b73b@locusrobotics.com>
 <642b61a6-e3c0-4831-887f-f25314bf166d@locusrobotics.com>
 <90ac3bdc-8797-4d57-8bc9-48e0ad406674@quicinc.com>
 <1dafe0e5-292b-4764-86c7-cc1757aeb3b6@gmail.com>
 <ed8eeb92-e1eb-445e-989d-2340c26faf44@quicinc.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <ed8eeb92-e1eb-445e-989d-2340c26faf44@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Baochen,

>> As you may have guessed I don't _really_ know what I'm doing. When I 
>> got this working with ath10k I saw monitor device was being used in 
>> order to receive probes, and did the same for multicast action frames 
>> and it "just worked". The frames themselves were still being received 
>> on the station device. I attempted to mimic the changes with ath11k.
>>
>> The end goal here is just that, be able to receive multicast action 
>> frames on the station device which currently does not work. I'm only 
>> seeing unicast frames when i enable RX debugging. The driver support 
>> for multicast action RX in the kernel for this is basically zero. An 
>> extended feature flag was added by Jouni when he added support to 
>> ath9k, I added limited ath10k support for a variant I tested, and I'd 
>> like to do the same for ath11k as we are transitioning to the WCN6855.
> OK, so you are testing this with latest ath.git, without any private 
> changes, and it doesn't work, right? Could you share your test steps? 
> Basically how are you sending multicast action frames from AP/peer, 
> and how to check if that frame received or not (I am assuming by 
> checking RX logs)?

Yep I'm on the latest ath.git, and with no changes apart from that MSI 
vector hack to get it working with vfio-pci.

The way I'm testing this is using IWD with DPP PKEX. Building IWD should 
be relatively straight forward, very few dependencies. This will also 
include iwctl which is IWD's command line utility:

https://git.kernel.org/pub/scm/network/wireless/iwd.git/

I have two devices, the configurator device (device A, ath11k) is what 
should be able to receive the multicast action frames. The enrollee 
device (device B) can use probably any hardware as sending multicast 
action frames should be supported. IWD will not start a DPP PKEX 
configurator without EXT_FEATURE_MULTICAST_REGISTRATIONS set but if you 
enable RX logging that should be good enough to see if the frame is 
making it to the ath11k driver itself. Once multicast RX is supported we 
would need to add that extended feature to ath11k, or at least the 
tested variant. If you want, you can hack in that feature bit and start 
a configurator but if your able to get the muticast RX working I can 
probably take it from there:

1. Enable RX logging on device A

2. Start IWD on device A

     iwd -d

3. Connect to a network on device A

     iwctl station <wlan> connect <ssid>

     <enter passphrase>

# Optional: start a configurator. This won't work without the ext 
feature set

    iwctl pkex <wlan> configure secret123

4. Start IWD on device B, do not connect.

     iwd -d

5. Start DPP PKEX as an enrollee on device B:

     iwctl pkex <wlan> enroll secret123

On device B you should see IWD first scan to establish nearby 
APs/frequencies, then begin iterating those frequencies and sending a 
multicast action frame.

Thanks,

James

>
>>
>> And help is much appreciated, and I'm happy to put in the work its 
>> just a steep learning curve coupled with the fact that any FW level 
>> communication is proprietary. I really just need a nudge in the right 
>> direction.
>>
>> Thanks,
>>
>> James
>>
>>>
>>>> Thanks,
>>>>
>>>> James
>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>> James
>>>>>
>>>>>
>>>

