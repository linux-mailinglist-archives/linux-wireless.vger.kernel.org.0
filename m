Return-Path: <linux-wireless+bounces-13816-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF14997132
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 18:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711BF1C20E87
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 16:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229491BE869;
	Wed,  9 Oct 2024 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kw2CMd/X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E85019B5B4
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490314; cv=none; b=mVP51f8XkkOdv/Yc0Gr27mYLWd5JZBieXETn2HNLRInug84Q9Uvk1giDeqVwBrtiE1vNpzLOhqwResbkCwqGoIy/LiYtnHPACRCaFADzx7GpWY1Mm5BIxZ3PowUN3CNv3ERsuSYVKQrOl1gc/FFREJMtS95m5fKALtpIFFctqUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490314; c=relaxed/simple;
	bh=RJnevKDvXlV1mvs8U7nLDZC2yL9TpHRnzo9zBdU7FYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zk7YIf++5X+ybmmFouYGT2H4u9ja3mIWmpvcTLYOuxw44Cmww0OTWZgP/3O/TNu7Ry6py+lN1lnjSdYRkb5pkqxD0mT4uA8Pc2kUnLaAd5E4+zclHcwld0j8QmJnRmHRyokg/UYo8p1qQRE1t8YIaH/MQK4AWi7UxnGYxpSJqUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kw2CMd/X; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539885dd4bcso8832228e87.0
        for <linux-wireless@vger.kernel.org>; Wed, 09 Oct 2024 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728490310; x=1729095110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cCX+oBnGc2JIl6RNV3OGgS87u/6b9yORWSnJkz/zXSI=;
        b=Kw2CMd/XyHoqZjQZLPG3NqsGdCu4MfFd0TF19QmOlUDFqXKKJjrcxEx2q0ajcBLI2A
         VBfsk+dRRoO/NwlZ5NCBt9S/rqLI8/WPUt5W8bKMOjEfTw8LDlpOWQsLH/0AXb0MB5ER
         eYTM+Huu/JFNCqgSc3pEnaErsVT4Ul8AHccr1V95y7+PikdNrWoaxYSdZunxipAn8w58
         zGviIU1NcQhyXel+zwc6BWogZQ9fP9lfDE2ctbI+6o6v4FcxULSe237S1E2+uYU7bm1c
         pzvrDAjCMH4AYprWdqj0AJeQycfzC6dOYbq4p4mZr4W/xQBn4L9cCU7iQSrEqj7t+ZkL
         qMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728490310; x=1729095110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCX+oBnGc2JIl6RNV3OGgS87u/6b9yORWSnJkz/zXSI=;
        b=jQizLc3jWoaPFRt+v/DChZwsnpBh0kgXNN0QtR+p+RZv5ms6FflJa00PLBi+33DCji
         pG0F/ila3rKFbngZ328bW8u7OpxogdRPmMoOS65pzV6wnHGjR1uZ4mG+8hJ2yGupfWrj
         J6wud9nx5sGsIhizJUsCLsYERaNW4JkS3LlFnKeTEjzdxdlemnpneTzP8AWBeNtANu4R
         0wunjB1+x+q7MSTYDFqC+zz/tHJPXXMTPWxH1ZVUcDvIzfx+b7TO6unvI+7aY3yYJwWK
         1RS28PLY4eK++NjczGD0eCBhSzcb81NI1JPC1bOAhhmaSTVQr6+Zn15KFmnukkyL/lcz
         e8iw==
X-Forwarded-Encrypted: i=1; AJvYcCWkqCG0GOydkohZ7YJuLojdgWnmqf9CK+ZJbycVa2w+F9DPzlf+wInJS4MWzadzAEnKNtCpF1qI1a/ohiyGSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzciqP9DxPzj7h1y6722GY4w1reVlCuFNExrHoBEX0K6rwlc6Mf
	erE6uIQIePnkQCSCYe6dT/rFLp2kBYbvDfvd0hKuqBqpO8b2YbgR8KXoaw==
X-Google-Smtp-Source: AGHT+IETS1KQf+hk0W/VMfhOmK20nGXMV3m5D8iwAFs6HhqgIgE66CtshucLvyAKQKyrYYQOp3wz/Q==
X-Received: by 2002:a05:6512:2302:b0:539:9155:e8b4 with SMTP id 2adb3069b0e04-539c488d7f6mr1915748e87.2.1728490310125;
        Wed, 09 Oct 2024 09:11:50 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf510dcsm24358265e9.18.2024.10.09.09.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 09:11:49 -0700 (PDT)
Message-ID: <01536d81-b6e6-4e83-9a8f-5ff1314f4add@gmail.com>
Date: Wed, 9 Oct 2024 19:11:46 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtw88: Fix the RX aggregation in USB 3 mode
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Kalle Valo <kvalo@kernel.org>
References: <afb94a82-3d18-459e-97fc-1a217608cdf0@gmail.com>
 <3731c7452dbf48f8a35e982d08963ba8@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <3731c7452dbf48f8a35e982d08963ba8@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/10/2024 03:18, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> RTL8822CU, RTL8822BU, and RTL8821CU don't need BIT_EN_PRE_CALC.
>> In fact, RTL8822BU in USB 3 mode doesn't pass all the frames to the
>> driver, resulting in much lower download speed than normal:
> 
> Have you also tested in USB 2 mode? Just want to know this patch works on
> both modes. 
> 

Yes, USB 2 mode was working before and it still works after this patch.

>> [  5]   0.00-10.00  sec  98.6 MBytes  82.7 Mbits/sec                  receiver
>>
>> Don't set BIT_EN_PRE_CALC. Then the speed is much better:
>>
>> [  5]   0.00-10.00  sec   714 MBytes   599 Mbits/sec                  receiver
> 
> Good job. That improves ten times of RX throughput!
> 
>>
>> Fixes: 002a5db9a52a ("wifi: rtw88: Enable USB RX aggregation for 8822c/8822b/8821c")
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 
>> ---
>> The code in the official drivers is a little broken. It sets
>> BIT_EN_PRE_CALC and then immediately unsets it. I didn't notice that
>> before.
>>
>> Maybe this should go to kernel 6.12, if it's not too late. Commit 002a5db9a52a
>> ("wifi: rtw88: Enable USB RX aggregation for 8822c/8822b/8821c") first appears
>> in 6.12.
> 
> Kalle, could you help to take this patch via wireless tree? If yes, I will
> assign this to you in patchwork. 
> 
> 


