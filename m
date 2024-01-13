Return-Path: <linux-wireless+bounces-1883-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB99482CEFD
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 23:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DBFB1C20F90
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 22:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C12318036;
	Sat, 13 Jan 2024 22:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASjtNXuI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48471802B
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jan 2024 22:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e6275e9beso13215365e9.1
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jan 2024 14:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705186530; x=1705791330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=scyGgWx+S19nzeMm3XKHE4H/wDN57mlqC/FIRkzKKfg=;
        b=ASjtNXuIkkLeE/RKxc2+mQOY507Gurh0zlyv9wjx2u+wndcagV6PeWJicFQgyvBSJn
         y8AikifNXfRgj0TN2Q11aR43siRa+Iz2N3ROaLgVXMnIOpVzw2mTHSWfK/vBXUxDh0n8
         dqfei5J07QTyVeoDH+5D+7nS25iQnrm9McnJBXvUAO1aLpF3hH5babQQaWz7kkGHL5qW
         LLa9wBmbuhQS9F99CvWUJmsgO/Vh0C+0uIRSEddPHj7t8Oe5CVrw0ywHLXS877bE3nnX
         nF48TizE7StBj+nIBbua/jaQKjDei6xIhjOw33xtqqfF+C5/yy0VpDzV5iBu1N3+2y4W
         1N2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705186530; x=1705791330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=scyGgWx+S19nzeMm3XKHE4H/wDN57mlqC/FIRkzKKfg=;
        b=PzeVvxh4Cjv4TZQl+xBQiThyspeEAg4kEoQhTbRAEUX+YYlfbUfActS6Y+a5GI1FHN
         KMpiL4l0Js2h/zAY86M4aiGruVlkOfDPCKJ1yx87R56B6sHvA39MBQDvTsVru7ZEf3Os
         +gLW6kn9HGCIV5pwSXlt5s0qNTmCT6EtSLwX74R0QzWJEiZ5+27d2SRInMDu5KvEporE
         WTCJ0b5tQ+CPYX0ka9VOiuaP3YOj8ClB0zKHwM5785++QH7X5pjud7y6z8HJStxbq8Gf
         sgARJE9kurZvm+SSKVC+fPhOC5CXS0cWrcPMWj6maNN7sIeUw3sxKF65WbIrhbMXY9xM
         yxwg==
X-Gm-Message-State: AOJu0YyRz1vyYtfse5TRbhBqbD4PLIQ38ZxzGhYNgkMUZBDK0WV6kZ1z
	zhY5i6TtaKDamOCkyMKyr8s=
X-Google-Smtp-Source: AGHT+IFB8VBN5ap4rcu6ShvdCqgRi4rTcAbynsJ8yfsELTnJKDaFCVTGTWnrVzdP/aCci8nJ0iD16Q==
X-Received: by 2002:a05:600c:4e8d:b0:40e:4a60:4f4b with SMTP id f13-20020a05600c4e8d00b0040e4a604f4bmr1514689wmq.121.1705186529714;
        Sat, 13 Jan 2024 14:55:29 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.51])
        by smtp.gmail.com with ESMTPSA id m35-20020a05600c3b2300b0040e541ddcb1sm10720483wms.33.2024.01.13.14.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jan 2024 14:55:29 -0800 (PST)
Message-ID: <d53d8311-efaf-44a2-ac4f-accbbdce2a40@gmail.com>
Date: Sun, 14 Jan 2024 00:55:28 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wifi: rtlwifi: Speed up firmware loading for USB
To: Kalle Valo <kvalo@kernel.org>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>, Larry Finger <Larry.Finger@lwfinger.net>
References: <6351ca3f-6b06-4fe1-ace7-6e9d67497dce@gmail.com>
 <87o7dphha3.fsf@kernel.org> <e72fdcf0-2d2c-496e-a9be-8b554dec9fd4@gmail.com>
 <87v87x8kft.fsf@kernel.org>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <87v87x8kft.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/01/2024 14:52, Kalle Valo wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:
> 
>> On 13/01/2024 08:35, Kalle Valo wrote:
>>
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:
>>>
>>>> Currently it takes almost 6 seconds to upload the firmware for RTL8192CU
>>>> (and 11 seconds for RTL8192DU). That's because the firmware is uploaded
>>>> one byte at a time.
>>>>
>>>> Also, after plugging the device, the firmware gets uploaded three times
>>>> before a connection to the AP is established.
>>>>
>>>> Maybe this is fine for most users, but when testing changes to the
>>>> driver it's really annoying to wait so long.
>>>>
>>>> Speed up the firmware upload by writing chunks of 64 bytes at a time.
>>>> This way it takes about 110 ms for RTL8192CU (and about 210 ms for
>>>> RTL8192DU).
>>>>
>>>> PCI devices could upload it in chunks of 4 bytes, but I don't have any
>>>> to test and commit 89d32c9071aa ("rtlwifi: Download firmware as bytes
>>>> rather than as dwords") decided otherwise anyway.
>>>>
>>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>>
>>> There's another version so I assume I can drop this one:
>>>
>>> https://patchwork.kernel.org/project/linux-wireless/patch/0d262acd-4f94-41c2-8d15-83486aeb976b@gmail.com/
>>>
>>
>> Yes, you can drop this one. Sorry about that. I forgot to write
>> "[PATCH]" in the subject. I thought you wouldn't even notice this
>> one because of that.
> 
> I think patchwork assumes that any mail with a diff is a patch, like
> this one:
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/c7b331edd65b66521a6605177d654e55051568a3.camel@toradex.com/
> 
> So "[PATCH]" is more like a visual clue. BTW usually it's a good idea to
> mark the next mail as v2 and explain in changelog what happened/changed,
> that way everyone are on the same page. But no big deal, just trying to
> make this smooth for everyone :)
> 

Ahh, got it. I will remember to do that if something like this happens again.

