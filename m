Return-Path: <linux-wireless+bounces-30170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 695CDCE8ADC
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 05:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F256300F9C8
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 04:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A4461FFE;
	Tue, 30 Dec 2025 04:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G3UyDjRw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6F4288D2
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 04:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767068517; cv=none; b=KGstixFt5HjDUPC6oSukyDQNHDov+U3aKhCq52LsbsZLrgA3bSHMIuJXXot7znozI1PIbP/Tp5I0VKL/y2zbp2x2bJqmo82fNHV8fmmoKEYaQ5TLJXpmPpRLn/t9Zbd5kgcjkFsUHzyXOqk8YN4DZ9TsdvbvQ/MB3v7Qz3Lrnn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767068517; c=relaxed/simple;
	bh=9JnTaD70fmCW24RiiJ0ZL4hI+3iweHsqOVQEpS95SMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJnL+sRu40swpN3rTI6qi6okG8HV2bKQxyTUn20yxIkytmgFW/Ne7g8XD3+hkga4yxgwleX7b1yIQe5gTDlypRWClssV6Qy5ErL4SHHoSwTQcMPfQIuxZKILaE7PozDxuhzEHvoxcK8LAJYPhfhjceyBS0EsxMMAEWMorUqkWU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G3UyDjRw; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6fc04df5-b753-4b2d-b978-0e59a7f48ff7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767068513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CE0uoDBxEzq5zFGaeAbRYm/n5NwUtj70NZaOvkqXjjQ=;
	b=G3UyDjRwLJH28uP5zc8lKPPwWMslzjOntuSzEyzWFtkT7zPqu1nN8GcyzkLWWj3WjBZvVf
	uiRkMcEtBDu7cWYSTHwKkFTAyfplwjEJBwbSjGpwXXft9SoTKXOEYa3DYNprgwqYpO1kxm
	joC7Em5pwRNMTzCpqLUztOPa5WQSaaU=
Date: Mon, 29 Dec 2025 20:21:48 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Linux 6.19-rc1 mediatek mt7921e broke badly
To: Linus Torvalds <torvalds@linux-foundation.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Eric Biggers <ebiggers@kernel.org>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Mario Limonciello <superm1@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, quan.zhou@mediatek.com,
 Felix Fietkau <nbd@nbd.name>, lorenzo@kernel.org, ryder.lee@mediatek.com,
 linux-wireless@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-mediatek@lists.infradead.org, shuah <shuah@kernel.org>
References: <d7f3b00d-beec-41f0-b157-7cfb871f9a46@linuxfoundation.org>
 <756e3f65-b2f2-4da3-985a-17754a7a872d@t-8ch.de>
 <CAHk-=wjO-7uR5HBi-MFnkxAxjhpgfbAQ+HCMKPiXFVwM+AJ7tA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <CAHk-=wjO-7uR5HBi-MFnkxAxjhpgfbAQ+HCMKPiXFVwM+AJ7tA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/29/25 4:41 PM, Linus Torvalds wrote:
> On Sat, 27 Dec 2025 at 04:25, Thomas Weißschuh <linux@weissschuh.net> wrote:
>>
>> Hi Shuah,
>>
>> On 2025-12-27 02:07:24-0700, Shuah Khan wrote:
>>> mt7921e doesn't load on my primary laptopn on Linux 6.19-rc1 and problem
>>> still there on 6.19-rc2.
>>
>> This should be a duplicate of
>> https://lore.kernel.org/all/CABXGCsMeAZyNJ-Axt_CUCXgyieWPV3rrcLpWsveMPT8R0YPGnQ@mail.gmail.com/
> 
> Hmm. I wonder if we could instead do this:
> 
>   --- a/lib/string.c
>   +++ b/lib/string.c
>   @@ -113,7 +113,7 @@ EXPORT_SYMBOL(strncpy);
>    ssize_t sized_strscpy(char *dest, const char *src, size_t count)
>    {
>           const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
>   -       size_t max = count;
>   +       size_t max = count - 1;
>           long res = 0;
> 
>           if (count == 0 || WARN_ON_ONCE(count > INT_MAX))
> 
> (intentionally whitespace-damaged patch, because I want people to
> think about it).

I gave this a try on its own but I was still experiencing a kernel crash:

[    3.339408] strnlen: detected buffer overflow: 17 byte read of buffer size 16
[    3.339804] WARNING: lib/string_helpers.c:1035 at __fortify_report+0x41/0x50, CPU#14: kworker/14:0/105
[    3.352248]  __fortify_panic+0xd/0xf
[    3.352259]  mt76_connac2_load_patch.cold+0x2b/0x95a [mt76_connac_lib 8f0d0f7b30f881af23462dac0a8cc5ff88d08cd0]

However, applying a similar diff in the fortify wrapper does prevent the crash:

--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -306,13 +306,13 @@ __FORTIFY_INLINE ssize_t sized_strscpy(char * const POS p, const char * const PO
      * This call protects from read overflow, because len will default to q
      * length if it smaller than size.
      */
-    len = strnlen(q, size);
+    len = strnlen(q, size - 1);
     /*
      * If len equals size, we will copy only size bytes which leads to
      * -E2BIG being returned.
      * Otherwise we will copy len + 1 because of the final '\O'.
      */
-    len = len == size ? size : len + 1;
+    len = len == size - 1 ? size : len + 1;
 
     /*
      * Generate a runtime write overflow error if len is greater than

Not sure what the implications of such a change would be relative to the proposed
fix here: https://lore.kernel.org/all/20251205161202.48409-1-mikhail.v.gavrilov@gmail.com/

Matt

> 
> It basically says that if the size of the 'strscpy()' buffer is N,
> then we do the "word-at-a-time" only up to 'N-1' bytes, because we
> don't even need to read the last byte of the source, because we will
> always NUL-terminate the destination...
> 
> That would basically make it ok to use a destination that is one byte
> larger than the source (in order to fit NUL termination that doesn't
> exist in the source).
> 
> The downside, of course, is that it means that we possibly miss out of
> doing the last word of the copy a word-at-a-time. But possibly not a
> big downside, and it would make strscpy() able to deal with this case
> natively.
> 
> The *real* issue is that we don't have a "source is this big,
> destination is that big" version of string copy.
> 
> Normally that is a non-issue - just pick the smaller size of the two.
> Except for this particular case, where the destination is exactly one
> byte larger, and wants to be NUL-terminated while the source might not
> be.
> 
> I haven't really thought this through fully, which is why that patch
> is very much whitespace-damaged. Somebody else should verify my
> thinking.
> 
>                    Linus
> 


