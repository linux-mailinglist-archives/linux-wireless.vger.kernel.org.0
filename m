Return-Path: <linux-wireless+bounces-30200-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F7FCEAF1E
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 00:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C4063006467
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 23:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D41301010;
	Tue, 30 Dec 2025 23:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ffGa6lcP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6B72459D4
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767139045; cv=none; b=Qr0KfhC1fept1Xg9Msg9qZk6Gu0vOcj3joLmE/Mr7O6HMy+Se/ZetRuGcNjSkjyId48tVFPO4FewxTWEcmT0AkrzkFu7G/xwFRgpqezV4S5Hwcwj4Rxft3khAMUV1SguBvOwx3pZs6mNxYG558IOGmLi61tmjiQPVcO8+v+LEaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767139045; c=relaxed/simple;
	bh=jHB4OkJ6+efPlJQvfxdaq7E81qLhtpoIgfRX6fcwuLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVIzOFtBNdvaLSZvfkBfiRh808TQfuR9PX6nOYdDr+GZUtWhk6lcxi6ccU1LlQ+QT66ZbOshJf3t5lY9tyvw8DtH1CiTT5RxgByZrg5ED/3hgOrYbVORVOtzvx0IaHSlFzyOGHHNL2m/oOn/QsW44JHT+1RW5XMsVdZpRrW/uVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ffGa6lcP; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c52fa75cd3so11768617a34.3
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 15:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1767139042; x=1767743842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ZRg1doJmXxLNzyi9m4dAo35YsgsZxHf7TH/2wMLs8I=;
        b=ffGa6lcPukSiszSxcQm/GZuHOLfm/3IQkoCQMAEuWhMCnNN4YIf2/zGj0IIMyT+TZn
         XAIW3jZbRUNE5kawoSK1Stp4C92FBQIhK6ck2buwVAnXEWI5WNXCGCBtJQKkbYL4nzSc
         4JvEoHUV/5uU9hVc4IX2hmSYwP6DHrh7i2lD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767139042; x=1767743842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ZRg1doJmXxLNzyi9m4dAo35YsgsZxHf7TH/2wMLs8I=;
        b=WQ+UWetXnKCkeOs58fWAGN1V0zjbuk1+C79gWrJtVH1hsJtHhEadSmcJ9WBLh9dJPt
         uXICemv1ftVP+JyN9NguZFR6TzTE0aBWuOu3V2rrjvXk/yI9uDAZh8d9UnN5B4a7YmhY
         Xs/3yymMm3n4OxbG4uZ6lnVaFnHaCklcN/Sy5UW6lEDJLbJomI0t82o/KUhaL/WgnDYF
         +8XJdh8Q23TOjngi233tqWYVppI2bYV8AeJxpbzjw+ok3ylVGf5kC10jeGxo8YjfTmBj
         4cBW+G7aX4VXi9lPgRJPon/39gZkNl+PdhUFlSb7io92v/t6PvnJMMDki4HZdXeFLW0Q
         uSpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUA2QOdT3HzaaH/t/0VhGUFd0KWOUhOGTf3fNXBxM5jvRwS47E2lBmNvrBD5k585g7tHiUB2TTVKyb7qACjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyA8QkVvUvakkWsAG63Df2K980k6k2CowU0cVIKVKf5w8HASdmE
	3m7xciHFcbf4X6Qzdbwyu6kS+FNhDIZy0tziUiB87VVrV8AvIQ10Cb7JuM+tChi/9V4=
X-Gm-Gg: AY/fxX6exsmECnEv3D+jt2QUydGK09VOmS828D/fLKck+gO0rK/y71OMOkPeyA69Uvz
	+qSpHve3C6MkyjEbDKh4jK8R7lGE8sCLiXyzpukoqgHObTY8bIcaeCzPp1rbKbT7Z9rKXPbVvwI
	8BcY3PsctOzAqUkUC/uPcjridL3CMSUszX7tQyDbkQyf9K6+n41gqgoJHDP0TcK3rYf7lTIBBQQ
	157HeN9eWSs6NjbYWP4LEHL8+3cJnNvJMU4HgXWXf3CGLGkLx9+ZGl8lyLfar5lUnUt7eXrsYwU
	WJvL3PB33MnhwPdjXDmfxenM0zEWUJZ0i0soCJKKt2+cFZa+WIoRsAJQ8au/EUaJ+Qo2mtzlVT8
	AVMg5t+LckGfYfYlH9C5kLDAHVZkQoJIHtsYh3sLe07pZQxtBhll3hEE2RhqqaqHjRyxuj2yFLb
	6ZnfgO7aSem8m/uId3/nXix8A=
X-Google-Smtp-Source: AGHT+IFWzRYyQNvTNkw9RmEVarae7rk5zx6WELg3Z4a91hRiSu2BAOlPWkJeyCXLdCBX204JSS8o8g==
X-Received: by 2002:a05:6830:43a4:b0:7c7:6da2:6d67 with SMTP id 46e09a7af769-7cc6689d9a3mr23413145a34.3.1767139042078;
        Tue, 30 Dec 2025 15:57:22 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667f958asm23072914a34.27.2025.12.30.15.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 15:57:21 -0800 (PST)
Message-ID: <c1304430-dd7d-437b-8744-70af9ca85c0d@linuxfoundation.org>
Date: Tue, 30 Dec 2025 16:57:20 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.19-rc1 mediatek mt7921e broke badly
To: Matthew Schwartz <matthew.schwartz@linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Eric Biggers <ebiggers@kernel.org>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Mario Limonciello <superm1@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: quan.zhou@mediatek.com, Felix Fietkau <nbd@nbd.name>, lorenzo@kernel.org,
 ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-mediatek@lists.infradead.org, shuah <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <d7f3b00d-beec-41f0-b157-7cfb871f9a46@linuxfoundation.org>
 <756e3f65-b2f2-4da3-985a-17754a7a872d@t-8ch.de>
 <CAHk-=wjO-7uR5HBi-MFnkxAxjhpgfbAQ+HCMKPiXFVwM+AJ7tA@mail.gmail.com>
 <6fc04df5-b753-4b2d-b978-0e59a7f48ff7@linux.dev>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <6fc04df5-b753-4b2d-b978-0e59a7f48ff7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/29/25 21:21, Matthew Schwartz wrote:
> On 12/29/25 4:41 PM, Linus Torvalds wrote:
>> On Sat, 27 Dec 2025 at 04:25, Thomas Weißschuh <linux@weissschuh.net> wrote:
>>>
>>> Hi Shuah,
>>>
>>> On 2025-12-27 02:07:24-0700, Shuah Khan wrote:
>>>> mt7921e doesn't load on my primary laptopn on Linux 6.19-rc1 and problem
>>>> still there on 6.19-rc2.
>>>
>>> This should be a duplicate of
>>> https://lore.kernel.org/all/CABXGCsMeAZyNJ-Axt_CUCXgyieWPV3rrcLpWsveMPT8R0YPGnQ@mail.gmail.com/
>>
>> Hmm. I wonder if we could instead do this:
>>
>>    --- a/lib/string.c
>>    +++ b/lib/string.c
>>    @@ -113,7 +113,7 @@ EXPORT_SYMBOL(strncpy);
>>     ssize_t sized_strscpy(char *dest, const char *src, size_t count)
>>     {
>>            const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
>>    -       size_t max = count;
>>    +       size_t max = count - 1;
>>            long res = 0;
>>
>>            if (count == 0 || WARN_ON_ONCE(count > INT_MAX))
>>
>> (intentionally whitespace-damaged patch, because I want people to
>> think about it).
> 
> I gave this a try on its own but I was still experiencing a kernel crash:
> 
> [    3.339408] strnlen: detected buffer overflow: 17 byte read of buffer size 16
> [    3.339804] WARNING: lib/string_helpers.c:1035 at __fortify_report+0x41/0x50, CPU#14: kworker/14:0/105
> [    3.352248]  __fortify_panic+0xd/0xf
> [    3.352259]  mt76_connac2_load_patch.cold+0x2b/0x95a [mt76_connac_lib 8f0d0f7b30f881af23462dac0a8cc5ff88d08cd0]
> 
> However, applying a similar diff in the fortify wrapper does prevent the crash:
> 
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -306,13 +306,13 @@ __FORTIFY_INLINE ssize_t sized_strscpy(char * const POS p, const char * const PO
>        * This call protects from read overflow, because len will default to q
>        * length if it smaller than size.
>        */
> -    len = strnlen(q, size);
> +    len = strnlen(q, size - 1);
>       /*
>        * If len equals size, we will copy only size bytes which leads to
>        * -E2BIG being returned.
>        * Otherwise we will copy len + 1 because of the final '\O'.
>        */
> -    len = len == size ? size : len + 1;
> +    len = len == size - 1 ? size : len + 1;
>   
>       /*
>        * Generate a runtime write overflow error if len is greater than
> 
> Not sure what the implications of such a change would be relative to the proposed
> fix here: https://lore.kernel.org/all/20251205161202.48409-1-mikhail.v.gavrilov@gmail.com/

+ adding Johannes to this thread also.

Reverting the following fixed my problem.
  
f804a5895eba ("wifi: mt76: Strip whitespace from build ddate")

The above fixes an extra newline in the dmesg by making the
code more complex it needs to introducing local buffers and
strscpy() - the proposed fix replaces this with memcpy().

Is there a simple way to do this than introducing memcpy()
or strscpy() to remove an extra newline that might or might
not exist? Why not check if newline exists or not using
strstr()?

I would recommend reverting f804a5895eba instead of trying
fix it. Then find a better way to eliminate extra newline that
shows up in dmesg when firmware build date happens to have
a newline.

thanks,
-- Shuah


