Return-Path: <linux-wireless+bounces-21366-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15014A83644
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 04:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D7807A7F07
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 02:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D02F1C7007;
	Thu, 10 Apr 2025 02:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="oGXzMqPn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FED918A6A9;
	Thu, 10 Apr 2025 02:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251237; cv=none; b=a/pEaPkaba+nukECgiKUCZY32D5OhIy/l1P8ArZyevcKgHeSkDcFWC2yapcaFRWClSzf0sUJyA7df3bo9USZdDUgLmLb7VKC99OxYUW/OtpE3SG1iQau2UtkHOGYKvU9n2CMUODyBcMG+MKMNjDkz5a0RLV/Bm63yS23Uy7JhiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251237; c=relaxed/simple;
	bh=9u60sO7OOT1oWOmjPwikFu4rY64oDd58zik3I0OmYfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyrx9vcKh3bQBwlFUn5MCd03clO2cOnKXN0/VHVawSfJhx3OrL+vuYxCQixECWJov5lKBt9rI+r8GLFYxoRz9760wpu7sDj1ao+nLg7LgGmSn6bqt7pXWP/0AL3taPtxaXDAeo+2/qUhQxoOHG/dBa4OQKDjm6r/E2KJKIRCd1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=oGXzMqPn; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:1f94:9d5:a0c2:3619:62ac] ([IPv6:2601:646:8081:1f94:9d5:a0c2:3619:62ac])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 53A29YJd3849252
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 9 Apr 2025 19:09:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 53A29YJd3849252
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025032001; t=1744250985;
	bh=sYPb2HJP4fVpfYUaFUUZ0pgxUHfO2I9/b7H7IqJmj3c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oGXzMqPnDihlvH8csOG6X1vYEL5+OkVYip8jhTPp6IM9qVTa+TE2DQN/NL7CCufbI
	 W70VoP5+eXYAecjlqh+Tn7MRcWyYYPY6ri9KgXYwsAfXP39A5RG5P/1U2MrIrPxIl4
	 LgNJ7p5qe7PlXd1brGtIHKI9TjgO8NyN/0p80ooXB7kFpxcUb3DSe2qpaXbL6MYH5Y
	 jkbPJIJLpQn1W597tFm89pO6yOJzSzHl/UbpTIyOav94ZVlYeTk/+v6ZOvSDveTwGk
	 3WaanUXTgaBtSBGsUrLEl+lM6ukmEGPsrkHUnC15nBvJNz4rVyDO7jHqYWigKmp0ks
	 M5Uu5VvWQnEFA==
Message-ID: <e97a83a2-dabd-4dc3-b69a-840ca17d70b5@zytor.com>
Date: Wed, 9 Apr 2025 19:09:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/13] Introduce parity_odd() and refactor redundant
 parity code
To: Yury Norov <yury.norov@gmail.com>, Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, jk@ozlabs.org,
        joel@jms.id.au, eajames@linux.ibm.com, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
        dmitry.torokhov@gmail.com, mchehab@kernel.org, awalls@md.metrocast.net,
        hverkuil@xs4all.nl, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, louis.peens@corigine.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
        johannes@sipsolutions.net, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, akpm@linux-foundation.org, jdelvare@suse.com,
        linux@roeck-us.net, alexandre.belloni@bootlin.com, pgaj@cadence.com,
        alistair@popple.id.au, linux@rasmusvillemoes.dk,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
        oss-drivers@corigine.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
        brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
        bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw, Frank.Li@nxp.com,
        linux-hwmon@vger.kernel.org, linux-i3c@lists.infradead.org,
        david.laight.linux@gmail.com, andrew.cooper3@citrix.com,
        Yu-Chun Lin <eleanor15x@gmail.com>
References: <20250409154356.423512-1-visitorckw@gmail.com>
 <Z_amQp3gK5Dm8Qz3@yury> <Z/a5Qh/OeLT8JBS4@visitorckw-System-Product-Name>
 <Z_a9YpE46Xf8581l@yury>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <Z_a9YpE46Xf8581l@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/25 11:33, Yury Norov wrote:
>>>
>> I don't have a strong preference for the name, but if I had to guess
>> the return value from the function prototype, I would intuitively
>> expect an int to return "0 for even and 1 for odd," and a bool to
>> return "true for even, false for odd." I recall Jiri and Jacob shared
>> similar thoughts, which is why I felt adding _odd could provide better
>> clarity.
> 
> I think they said they are convinced that parity should return 1 for
> odd because of folding and __builtin_parity() arguments.
> 

And for bool, 0 == false, and 1 == true. In fact, the *definitions* for 
false and true in C (but not C++) is:

<stdbool.h>:
typedef _Bool bool;
#define false	0
#define true	1

If someone wants to make more clear, it would be better to put "typedef 
bool bit_t" in a common header, but that personally seems ridiculous to me.
   >>>> type from u8 to u64 for broader applicability, and updates its 
return
>>>> type from int to bool to make its usage and return semantics more
>>>> intuitive-returning true for odd parity and false for even parity. It
>>>> also adds __attribute_const__ to enable compiler optimizations.
>>>
>>> That's correct and nice, but can you support it with a bloat-o-meter's
>>> before/after and/or asm snippets? I also think it worth to be a separate
>>> patch, preferably the last patch in the series.
>>>
>> I quickly tested it with the x86 defconfig, and it appears that the
>> generated code doesn't change. I forgot who requested the addition
>> during the review process, but I initially thought it would either
>> improve the generated code or leave it unchanged without significantly
>> increasing the source code size.
> 
> That's what I actually expected, but was shy to guess openly. :). It's
> hard to imagine how compiler may improve code generation in this case...
> 
> This attribute is used when there's an asm block, or some non-trivial
> function call. In this case, the function is self-consistent and makes
> no calls. And you see, const annotation raises more questions than
> solves problems. Let's drop it.

Ah yes; one of the quirks about gcc asm is that an asm is implicitly 
assumed "const" (with no memory operands) or "pure" (with memory 
operands) unless declared volatile or given an explicit "memory" clobber.

So yes, the compiler can most definitely derive the constness from the 
form of the function even in the variable case.

I would still like to see __builtin_parity() being used as an 
architecture opt-in; it can, of course, also be unconditionally used in 
the constant case.

So in the end one of these two become my preferred implementation, and I 
really don't think it is very complicated:

#ifndef use_builtin_parity
#define use_builtin_parity(x) __builtin_constant_p(x)
#endif

static inline bool parity8(u8 val)
{
	if (use_builtin_parity(val))
		return __builtin_parity(val);
	val ^= val >> 4;
	return (0x6996 >> (val & 0xf)) & 1;
}

static inline bool parity16(u16 val)
{
	if (use_builtin_parity(val))
		return __builtin_parity(val);
	return parity8(val ^ (val >> 8));
}

static inline bool parity32(u32 val)
{
	if (use_builtin_parity(val))
		return __builtin_parity(val);
	return parity16(val ^ (val >> 16));
}

static inline bool parity64(u64 val)
{
	if (use_builtin_parity(val))
		return __builtin_parityll(val);
	return parity32(val ^ (val >> 32));
}

This means that an architecture -- in particular, x86 -- can still ask 
to use __builtin_parity*() directly. It means that architectures on 
which __builtin_parity*() produces bad code should either complain to 
the gcc/clang team and have it fixed, or we can add additional mechanism 
for them to override the implementation at that time.

The alternative is to stop worrying about overengineering, and just do 
it once and for all:

#ifndef parity8
static inline bool parity8(u8 val)
{
	val ^= val >> 4;
	return (0x6996 >> (val & 0xf)) & 1;
}
#endif

#ifndef parity16
static inline bool parity16(u16 val)
{
	return parity8(val ^ (val >> 8));
}
#endif

#ifndef parity32
static inline bool parity32(u32 val)
{
	return parity16(val ^ (val >> 16));
}
#endif

#ifndef parity64
static inline bool parity64(u64 val)
{
	return parity32(val ^ (val >> 32));
}
#endif

In either case, instead of packing the cascade into one function, make 
good use of it.

In the latter case, __builtin_constant_p() isn't necessary as it puts 
the onus on the architecture to separate out const and non-const cases, 
if it matters -- which it doesn't if the architecture simply wants to 
use __builtin_parity:

#define parity8(x)  ((bool) __builtin_parity((u8)(x)))
#define parity16(x) ((bool) __builtin_parity((u16)(x)))
#define parity32(x) ((bool) __builtin_parity((u32)(x)))
#define parity64(x) ((bool) __builtin_parityll((u64)(x)))

As stated before, I don't really see that the parity function itself 
would be very suitable for a generic helper, but if it were to, then 
using the "standard" macro construct for it would seem to be the better 
option.

(And I would be very much in favor of not open-coding the helper 
everywhere but to macroize it; effectively creating a C++ template 
equivalent. It is out of scope for this project, though.)

	-hpa


