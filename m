Return-Path: <linux-wireless+bounces-25464-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4718AB0577D
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 12:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A61947A47D7
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 10:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2D02D7810;
	Tue, 15 Jul 2025 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVu70fEn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04422D12E4
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752574049; cv=none; b=VVlbts1oJF8eyT3CPIH78LQRB+EtYyD22ynw/xxReoIaOed3uoSX+EM9xTwabwXAScxtLWrIITr9AJ+X61d4NIjBseyNWbRaJ+cFS0KTVDR71GTzMKzMQl7z3xAE8h2Rd/rOMlgSV4ZvlSdGUxMF0QNE2UmflL1B7qtMUYYwSVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752574049; c=relaxed/simple;
	bh=hOFfk3ODOl3A3dgoLqAqD/ifgxfbh7Op/eON6JMTA5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lxouWs2Z25X6BYas97td/HqTkbyfszhE2xZLjDtjgTE8EdfBytz/oM35MDl9RxC8IL7tw+a+2fPohPYMwoANPczbr5cQ24vAy4yf4MDuHXc63YlfLKEtX5VEdSqkWBVi9ed8rX9nrm2ad5hI+h0F89CEP1bKrAG1ZaYsPiz4XrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVu70fEn; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0a0cd709bso1290910266b.0
        for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 03:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752574046; x=1753178846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h1SI0zaETaEy8VkisAtkFcUBp/sz/alqQ2dJ8XRfreE=;
        b=QVu70fEnca7oSj6cn9kZQ1jyBG1xURxqQ/7dyyPr7ejQRKsCapfody5IrBWEga3rsf
         S4Y1M7zbBZ8NhXOV3lhaYV8e4fQQBWiB/guBnh2clS7xFiQpPseXjEBrguneA5StfVIC
         rc7WnPy6ydTU72P2KQflfbrUuEJmtEw2XUj3yxD6VsFsKlXPjwZuK3c6ZCpbvX8qXJjP
         vdreGYEFW8KuOEq50256JB4Nvedr2dNJenz4mSylJkiWCaLGE9YzIc2KwjurW7UmnCkS
         Wp+R5f3m8pp4Lywb7vpykH9ZgPvCRtirY+UvVn6xWrq83fJaqS1mk98Wr8KfZRYYvf8t
         3dUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752574046; x=1753178846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1SI0zaETaEy8VkisAtkFcUBp/sz/alqQ2dJ8XRfreE=;
        b=mCpF190RBHb5+vt6ScpLGeEfja7IHJSqNAddBDFd0T5ZuH8pgZBqs3p5BS7h3TDXwv
         fOhHrsjk8QZKnMxzY91lTPD0vkZOJ5eylbZe2X6DXjY0v09zycQBvs/O09oq8JUCNFSX
         Ww8dWrIc5m3GZCh05pG1pEGhp7245Kqe8CxYZ13E09cefaTahA3HsIxXH3rn5Y+4ZPB+
         g1Qo/voyUw14ScqCPg+3oSbTJdtHDHppNy84M4lCCWM9U+0vesCdIdLCFS7ERzseVxTE
         bWi80jeyPzeASprZRIdVP7i25qJiKrtMlG6JGrCjFs5wlJ2tNAmfS6sHBqkoo4L4sJgR
         Ftow==
X-Forwarded-Encrypted: i=1; AJvYcCXaeJSH5Ro0uRczAX1PIDSIN6g9JaKhK0GXEMrb0LAR69LhSanYTXS3k1NCWpBs6AY8dPNPBJlsx+las0ngYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPRhxmIFELyd3xahOmBnMFb1IHQJnJjTAJD42c/9v4D9BZx5Jh
	ptypj2N4ghUh4heyroCFX4I+7Vd7ewPieCg8YNlNjfYQO5MGv6yEtRvN
X-Gm-Gg: ASbGncseJP439kppfU1NiLidJ0TT1wapC2GMJGPWmjxfb0ANIyoWq7tEs/qWnn0uggx
	CTYwsfcAPv87NvTOzCv55x9rmNtpc+M7ZwQO2FfVivXSkTZA2098cHJ/QHdU8zSdHBUoq/ZCB52
	LpTPxtJF69L0rQ/SiNXSt/yw00WaNcK8c8NhdKg/U1YGr+6KqhDbI4bxki6Wn/UNmu472Nv5hmT
	wj3Fvpr6p1FCAI2XUmdZFIzAVAv2g2HVtv6oGFYi903TOwHeg46fmcssaIoKgWDwWriMJP38LCz
	mq4i7foDmAJbv+6pdrhZZ4kZIR0kk3HkGCkhFsrN+eHxzmzGLu4ffMkJwg+thhZ2Tony4LtjUw3
	vljBES7smFrYel4SDnnXaIaXpHKR8sTJMMrpLyA7S
X-Google-Smtp-Source: AGHT+IFX49N/dtq2R9i25vV26ipRiDizalSPmGjpjxsdJQ8OOeei/9ahddxWWbILt4WW1VQ16bGAOw==
X-Received: by 2002:a17:907:b815:b0:ae3:5185:5416 with SMTP id a640c23a62f3a-ae9b5c2bb65mr288591466b.13.1752574046056;
        Tue, 15 Jul 2025 03:07:26 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294013sm975112666b.118.2025.07.15.03.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 03:07:25 -0700 (PDT)
Message-ID: <e8b39833-2115-42dc-8f80-79559224aab0@gmail.com>
Date: Tue, 15 Jul 2025 13:07:23 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next 1/2] wifi: rtw89: Increase polling delay in
 rtw89_fw_read_c2h_reg() for USB
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <73f8bdbf-ff7f-4741-a6ea-b1d9026833c3@gmail.com>
 <9ce9b78535d74f08927ce2ac9c7731e9@realtek.com>
 <b24bb8a2-d635-4312-b451-065b8d8e950c@gmail.com>
 <541d90fbd7114d9b8c5247ee50d68507@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <541d90fbd7114d9b8c5247ee50d68507@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/07/2025 03:28, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 14/07/2025 05:49, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>> This read_poll_timeout_atomic() with a delay of 1 µs and a timeout of
>>>> 1000000 µs can take ~250 seconds in the worst case because sending a
>>>> USB control message takes ~250 µs.
>>>
>>> I was not aware of the change of [1]. The behavior of atomic version becomes
>>> different from non-atomic version.
>>>
>>> For this patch, I feel we can keep delay_us to 1 and treat timeout_us as
>>> 'count', which USB devices do smaller retries. The smaller delay_us can
>>> reduce total polling time, especially for PCIE devices (see my comments below)
>>>
>>> Though I don't measure total polling time of patch 2/2, I feel we can apply
>>> similar idea.
>>>
>>
>> Yes, a smaller timeout also works. I tested 4000 for this patch and 3200
>> for patch 2. 
> 
> Forgot to say, for PCIE devices please keep the timeout as was.
> 

Yes, of course.

>> (4000 * 250 = 1000000 and 3200 * 125 = 400000. I don't know
>> why rtw89_read8() in the second patch takes only 125 µs.)
> 
> 


