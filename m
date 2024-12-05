Return-Path: <linux-wireless+bounces-15926-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E56D9E563B
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 14:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3655D2845F9
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 13:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18007218847;
	Thu,  5 Dec 2024 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PVl0tRPy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A9421770D
	for <linux-wireless@vger.kernel.org>; Thu,  5 Dec 2024 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733404259; cv=none; b=kvs5kIBYZUkoB9OiLXg96C77VJdQ7AlSNBVwWXseNs37QUDBKG5QdOfDiLHCeK9JjQovP27eKHFI+/dmU7iE4VQAe00C1QQ5rJb07f6VUaUugtOwY1eeMPGXtxJlrtmib2bBToiFCg/XrAamUlIuyUUQGHLbTVxZebE3oLYaHb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733404259; c=relaxed/simple;
	bh=tXJRiFavBk5Y67bEBO6QAAaW+2R1zBHGkwkuzQ8MryQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=SidelMqXVBXBQrmgrhPEi4UlOGP2ubOU/ADQxFdgOqQ9MaJkyJHGkJ8zkIivZpIPiCyqZpeGWCtlHXSozDryp6TSEIG7MtSL19V4GxcM5DTGEhcw+xKbsEBOTEmhDoxak2+bj5JQKXMGcCOlFnCQRg9/7H9/19SiMsT2w/+LRCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PVl0tRPy; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2156e078563so6407395ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 05 Dec 2024 05:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733404257; x=1734009057; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tXJRiFavBk5Y67bEBO6QAAaW+2R1zBHGkwkuzQ8MryQ=;
        b=PVl0tRPy4iWw0Ea+Eonv9LbNx698YUr5XXJEjdYMBREkanIgdWxrsailrEDv9KBV/l
         7nC2fM3QHdt09zwVh5QeviOb7vipcy1sE5JRarnPbI6Q2LWCcFrqIgeW/j7fwhJp51VY
         7gwBAmiFGGwuAoqgDoC6N2OS86SWKMxD+7jCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733404257; x=1734009057;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tXJRiFavBk5Y67bEBO6QAAaW+2R1zBHGkwkuzQ8MryQ=;
        b=Yfye65FZeJLB2/mpjiyz3BqvMgifS8mjXmr5v8l+fgwYiX6/s/L6Xyz1oLImOZDULF
         GqnZcb9lLhhQDMUVB/kwbx9i+dzOHcXQhD6Z9/2p0TYb8unvN7/p+sLS3ImTqVNUj0V/
         Aia7ZFhCLrzSFa7RnPwHE8xovgcCDFDu6X58OkfTVp42zamVbWMs26f4pzzHkYgGXcMv
         CztESqhX184nmERpNzmRaUYDCWE86HX+S29BiHoTQ8taYGY5gGYpdFIjVsAErpY05WCL
         /N74+OSyB3taHL86j9UNy6B3fkDPMHud5GVbISSaq5e2blEXpqnLKKFdx3kY8rXwhYEJ
         mIGg==
X-Gm-Message-State: AOJu0YyyeO+hFllY85h9sU9GygSejhzWlwjArpZgmU+6cStFYtv+e6pW
	kv1dRrm8f724jMYcLbdtMkhPFY2DzBhO7IRSkY6dBGGICN0pABw+dc2qR+we/w==
X-Gm-Gg: ASbGncuVbVe+nRZHSnysYC4OOUPITgdZ3ZT8MUzOwTFygZy3JHo3864YdRchEmhMR18
	O9nl8L6gY7xIkgTt0KlhEsaj/Vo66J5gbObVUg/iaEkpeEE5dQSscXh7IFIyA5lexRsqn4i/VWb
	RNRp5FJROlTWlI4EKyvQqn/uKNfibqQphzEI661EpACz4pVj6vTQwW5DHKdL05QyovBu32jsTJd
	xQS8B3RXofCQWX370hyrQ68B9OuFCG8Djp55DYfvy6UaKoMWrxpBhUv+ikDK4bm9gFCQODeiXED
X-Google-Smtp-Source: AGHT+IG1r5T2xgZjXQRBvGTrj5MYVU4mVCnLPxxddQTaOrxQJFAS2hM+1tg4mceX/OdWIduvS/2vqg==
X-Received: by 2002:a17:903:1ca:b0:20b:8a71:b5c1 with SMTP id d9443c01a7336-215bd1b4604mr150384445ad.1.1733404256567;
        Thu, 05 Dec 2024 05:10:56 -0800 (PST)
Received: from [10.176.68.83] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3e446sm12206095ad.9.2024.12.05.05.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 05:10:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------0kMsNbHUpNusmzrfzjHMuXuZ"
Message-ID: <6b2fcdb4-f00d-4a17-909d-f92ed0240cbf@broadcom.com>
Date: Thu, 5 Dec 2024 14:10:51 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail,
 reason -52 - Part 2
To: KeithG <ys3al35l@gmail.com>
Cc: linux-wireless@vger.kernel.org
References: <CAG17S_P=bz0DFU71jEnV4RkT-Vxwvb2GpPwvLnjmD_n=2hLfUw@mail.gmail.com>
 <19388725ac0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_MJZ4VHvXiGj0qoimfQ8GLE6OEZe4DHZLx0H+0U_1X4pQ@mail.gmail.com>
 <CAG17S_NQ4vhKv153Hf_sfvseTpGjLr-UZQ0vEeqr-+q-op+R5w@mail.gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <CAG17S_NQ4vhKv153Hf_sfvseTpGjLr-UZQ0vEeqr-+q-op+R5w@mail.gmail.com>

This is a multi-part message in MIME format.
--------------0kMsNbHUpNusmzrfzjHMuXuZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/5/2024 1:54 AM, KeithG wrote:
> On Mon, Dec 2, 2024 at 5:49 PM KeithG <ys3al35l@gmail.com> wrote:
>>
>> Arend,
>>
>> Yes, I can build and test patches.
>>
>> I will build a current kernel version tonight and will then be able to
>> add any patches you may develop to address this issue.
>>
>> If I may ask, could you also patch the WPA3 External_Auth
>> functionality as well? I can test patches to that as well.
>>
>> Regards,
>>
>> Keith
>>
>> On Mon, Dec 2, 2024 at 11:36 AM Arend Van Spriel
>> <arend.vanspriel@broadcom.com> wrote:
>>>
>>> On December 1, 2024 10:55:26 PM KeithG <ys3al35l@gmail.com> wrote:
>>>
>>>> This floods the journal of my Pi ev ery 6 seconds:
>>>> Dec 01 15:51:30 pi5 kernel: brcmfmac: brcmf_set_channel: set chanspec
>>>> 0xd022 fail, reason -52
>>>> Dec 01 15:51:31 pi5 kernel: brcmfmac: brcmf_set_channel: set chanspec
>>>> 0xd026 fail, reason -52
>>>> Dec 01 15:51:31 pi5 kernel: brcmfmac: brcmf_set_channel: set chanspec
>>>> 0xd02a fail, reason -52
>>>> Dec 01 15:51:31 pi5 kernel: brcmfmac: brcmf_set_channel: set chanspec
>>>> 0xd02e fail, reason -52
>>>>
>>>> Is there something that can be done? Is there something I can help
>>>> with to fix this? I can test on multiple Pis, but cannot actually code
>>>> anything. Is this going to wait for the new infineon driver
>>>> development? The latest kernel where this has been seen is:
>>>> Linux pi5 6.6.62+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.6.62-1+rpt1
>>>> (2024-11-25) aarch64 GNU/Linux
>>>
>>> You can build and test patches? Is it only those specific channels as
>>> listed above? Those are pre -802.11b allowed in Japan. I don't think any of
>>> the brcmfmac devices actually support those channels.
>>>
>>> Regards,
>>> Arend
>>>
>>>
>>>
> I built a fresh kernel and can build and test brcmfmac driver mods on
> my Pis. Awaiting further instructions.

Can you try the patch attached?

Regards,
Arend
--------------0kMsNbHUpNusmzrfzjHMuXuZ
Content-Type: text/plain; charset=UTF-8;
 name="0001-wifi-brcmfmac-remove-old-802.11a-channels-for-Japan.patch"
Content-Disposition: attachment;
 filename*0="0001-wifi-brcmfmac-remove-old-802.11a-channels-for-Japan.pat";
 filename*1="ch"
Content-Transfer-Encoding: base64

RnJvbSA1OTlmZmVjMTYzMzllMjNlNTY1MTI3YmU1ZGY4YjhlNGJmYzc2NDM5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBcmVuZCB2YW4gU3ByaWVsIDxhcmVuZC52YW5zcHJp
ZWxAYnJvYWRjb20uY29tPgpEYXRlOiBUaHUsIDUgRGVjIDIwMjQgMTQ6MDE6MzYgKzAxMDAK
U3ViamVjdDogW1BBVENIXSB3aWZpOiBicmNtZm1hYzogcmVtb3ZlIG9sZCA4MDIuMTFhIGNo
YW5uZWxzIGZvciBKYXBhbgoKQ2hhbm5lbHMgMzQsIDM4LCBldGMuIHdlcmUgY2hhbm5lbHMg
YWxsb3dlZCBmb3IgdW5saWNlbnNlZCB1c2UgaW4KSmFwYW4gaW4gdGhlIDgwMi4xMWEgZXJh
LiBUaGVzZSBjaGFubmVscyBhcmUgY2F1c2luZyAocXVpdGUpIGEgYml0Cm9mIHNwYW0gaW4g
dGhlIGtlcm5lbCBsb2cuIEFsc28gdGhlIHdpcmVsZXNzLXJlZ2RiIGRvZXMgbm90IGNvbnRh
aW4KdGhlc2UgYW55bW9yZSBzbyBsZXQncyBnZXQgcmlkIG9mIHRoZW0uCgpTaWduZWQtb2Zm
LWJ5OiBBcmVuZCB2YW4gU3ByaWVsIDxhcmVuZC52YW5zcHJpZWxAYnJvYWRjb20uY29tPgot
LS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1hYy9j
Zmc4MDIxMS5jIHwgMyArLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9icm9hZGNv
bS9icmNtODAyMTEvYnJjbWZtYWMvY2ZnODAyMTEuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1hYy9jZmc4MDIxMS5jCmluZGV4IDJhOTBiYjI0
YmE3Ny4uZGJhZGIzZjg1ZWIzIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9i
cm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvY2ZnODAyMTEuYworKysgYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9icm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvY2ZnODAyMTEuYwpAQCAt
MTg2LDggKzE4Niw3IEBAIHN0YXRpYyBzdHJ1Y3QgaWVlZTgwMjExX2NoYW5uZWwgX193bF8y
Z2h6X2NoYW5uZWxzW10gPSB7CiB9OwogCiBzdGF0aWMgc3RydWN0IGllZWU4MDIxMV9jaGFu
bmVsIF9fd2xfNWdoel9jaGFubmVsc1tdID0gewotCUNIQU41RygzNCksIENIQU41RygzNiks
IENIQU41RygzOCksIENIQU41Ryg0MCksIENIQU41Ryg0MiksCi0JQ0hBTjVHKDQ0KSwgQ0hB
TjVHKDQ2KSwgQ0hBTjVHKDQ4KSwgQ0hBTjVHKDUyKSwgQ0hBTjVHKDU2KSwKKwlDSEFONUco
MzYpLCBDSEFONUcoNDApLCBDSEFONUcoNDQpLCBDSEFONUcoNDgpLCBDSEFONUcoNTIpLCBD
SEFONUcoNTYpLAogCUNIQU41Ryg2MCksIENIQU41Ryg2NCksIENIQU41RygxMDApLCBDSEFO
NUcoMTA0KSwgQ0hBTjVHKDEwOCksCiAJQ0hBTjVHKDExMiksIENIQU41RygxMTYpLCBDSEFO
NUcoMTIwKSwgQ0hBTjVHKDEyNCksIENIQU41RygxMjgpLAogCUNIQU41RygxMzIpLCBDSEFO
NUcoMTM2KSwgQ0hBTjVHKDE0MCksIENIQU41RygxNDQpLCBDSEFONUcoMTQ5KSwKCmJhc2Ut
Y29tbWl0OiBmZmMyNTMyNjNhMTM3NWE2NWZhNmM5ZjYyYTg5M2U5NzY3ZmJlYmZhCi0tIAoy
LjMyLjAKCg==

--------------0kMsNbHUpNusmzrfzjHMuXuZ--

