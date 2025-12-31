Return-Path: <linux-wireless+bounces-30206-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD46DCEB380
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 05:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1E2E300D4B2
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 04:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D33C30F80C;
	Wed, 31 Dec 2025 04:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c/aMFKC7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1333930F80A
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 04:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767154077; cv=none; b=I50r2dysmBZqB/lMEGYmZ8S/WcCMs4wIPWyTgVBbFiQg20gnHZ9BDmtCEd9X/iRPc97yKIdjNYfZZtQxjJRhCdw52kbuTT3KOcRH757KE2GzIbeBKk1DUKntaDTDBHTqWF1MDko49yGLRlptow7c0UxAN7urmP2Ejq2iEX58qRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767154077; c=relaxed/simple;
	bh=BHQXxscP62wZkhfnXCyIlpXpap4Nwg2ykXcaQRU1Aio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WErn/Q0Ou0DDd280oTXu2lEjVAwuqXhBAEoBtpERqmHOwS4OLNLSseMt6LGRnUFtuLZ5CD2zV3sVp91TJ8WUbm2xCYerLgjWRpJQWx3r/32xyLeNASf/+rrijSfHEKXbVCvkdimq7yjOtQrTV5SejHDfPo3hoCtio8nopB41d8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c/aMFKC7; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4557f0e5e60so6090089b6e.3
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 20:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1767154075; x=1767758875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rEWpU9UfmDCYEMxA6nsMxalblaTS4cfYkzlnNo+UBaQ=;
        b=c/aMFKC7kQ8Aqu4r4ADTBUdfpneuwzqjNhuutyejKhYt+kNAYIBNMm5jUBhUjA1/Rf
         4/5qR8MhCPq3be6jm0JO7gb5PVM3hVj9GphyB4G4nQ7j39sZgKIKU8ZVzkaoGsl8P4QN
         Bd+LffWJ4SATIJkE/pWEwcqcOAg2T+AiS/6YI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767154075; x=1767758875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEWpU9UfmDCYEMxA6nsMxalblaTS4cfYkzlnNo+UBaQ=;
        b=ONQ8jpNju027AjWE+0tfisCUj1IfON1HYB4kI9VeR8UBxRkT4AuMUJraUEB9ASJTjw
         u/zq7bdNjPbXTlJdepPrlrjQ8QV8/zmqjXvWnPeZ1FOMpa1d+RCT0kwTmMX/PBPxe6Vy
         ByHe9CcVekdGzq6V05fTHdVAg9C6CszJLfEhCpexvRAdpLaP4tTLJ9rkf9+BW9JcYn/C
         hHzSLh5d9gm4zRqEHAR0iVLKZXZNDrPaXthFew5nynMVgjJ6Un/99hlfz5rvUCwMbjsv
         b8sn4Ge/O9Tud4V9CymbBtIxMSKfexl3CGUKIcCLvGYMCPrrL15FFPeHvsbG5tkiCAmk
         UJBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGBAyWPjjSezBQFqr+887AXLVocsYAM1WaYs22KHP2Hr6fIEOh+XYKvOhLeqrG4IRWrwqXyVyMW3MogUkdiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZbHj6Aesc3ic9dytWXHT1hiu0lJ7+CKIF+EFBo08QoQwLPXy+
	MIlIqrdP3z+kR9CRLi/v0TSTSZwKWBhApUaG0XcQp7CHUqkw8OsmizH3hGdvYSE7l0k=
X-Gm-Gg: AY/fxX4qZ6W283GolafN6AEhvetJl5OLxhtP0hw71CNyERr18VinRBTXcS/CR0BzgBQ
	qfJebX+MLI5kvXttxDOb23ntKVb8Dcs1AueDjSxFSVja0BF9rQR34vruhWMHfTZ1My/J01B8ERX
	NWbGqc2iAKcE5p2wqnJKXFZ7gaihHjMhGdQjBTXL2WJxdVSgDhsdHPxTSeEwMHWwHbJ+AXKAR4K
	SVRTrpel2nTCTOPmoU3crZnigZ7lYkTX3/+YhdUfKSewrDi3EBxgx33y7TEOH3whZfVuKcBea7c
	wor1IuOfUtbNZhI4QYMctOPLpjGl5i5zcnFfZ3gEh2RuRXGaxJZFlMIFsWrwMV9jVLzLyyD7/l3
	/XqvRiQJ6d/2mVEtGPvA3pD2PKwX564siKlMVhQaR1iarETQfI+XGY9lp4nOz2T98ZC9tMIkEBV
	gCF+WjxHRa+KT2mDLAyJGO0Ys=
X-Google-Smtp-Source: AGHT+IGk43rmMGz2LTVg3do8lOBVQ/ADeo1lfHCAWZcf3O24miuOt3rdd/Qp6y8+P/Y0QEMjm9pUgA==
X-Received: by 2002:a05:6808:2e4d:b0:44f:8f27:e39a with SMTP id 5614622812f47-457b2061b07mr18260342b6e.8.1767154074844;
        Tue, 30 Dec 2025 20:07:54 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fdaabbf2e6sm21907245fac.17.2025.12.30.20.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 20:07:54 -0800 (PST)
Message-ID: <30d14c51-3325-49be-9510-43f4661ff6c4@linuxfoundation.org>
Date: Tue, 30 Dec 2025 21:07:53 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.19-rc1 mediatek mt7921e broke badly
To: Eric Biggers <ebiggers@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Mario Limonciello <superm1@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>, quan.zhou@mediatek.com,
 Felix Fietkau <nbd@nbd.name>, lorenzo@kernel.org, ryder.lee@mediatek.com,
 linux-wireless@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-mediatek@lists.infradead.org, shuah <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <d7f3b00d-beec-41f0-b157-7cfb871f9a46@linuxfoundation.org>
 <756e3f65-b2f2-4da3-985a-17754a7a872d@t-8ch.de>
 <CAHk-=wjO-7uR5HBi-MFnkxAxjhpgfbAQ+HCMKPiXFVwM+AJ7tA@mail.gmail.com>
 <6fc04df5-b753-4b2d-b978-0e59a7f48ff7@linux.dev>
 <c1304430-dd7d-437b-8744-70af9ca85c0d@linuxfoundation.org>
 <CAHk-=wh6WP0Wq=rbC2Md6vsFrV-+nvDjxgfx9NpMzUmVFNkJ9A@mail.gmail.com>
 <20251231015712.GA2299@sol>
 <fdebed60-264d-4f05-9423-618bc3ec6d6d@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <fdebed60-264d-4f05-9423-618bc3ec6d6d@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/30/25 21:00, Shuah Khan wrote:
> On 12/30/25 18:57, Eric Biggers wrote:
>> On Tue, Dec 30, 2025 at 05:27:13PM -0800, Linus Torvalds wrote:
>>> On Tue, 30 Dec 2025 at 15:57, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>
>>>> I would recommend reverting f804a5895eba instead of trying
>>>> fix it. Then find a better way to eliminate extra newline that
>>>> shows up in dmesg when firmware build date happens to have
>>>> a newline.
>>>
>>> Yeah. Let's revert it.
>>>
>>> And the way to fix the extra newline is trivial: just remove it from
>>> the "dev_info()" format string.
>>>
>>> Our kernel printing logic will add a newline for the next line anyway
>>> if it is missing (unless somebody explicitly uses PR_CONT).
>>>
>>> Can whoever saw the problem confirm that just a revert and a "remove
>>> \n from that dev_info()" fixes the output for them?
>>
>> That works for me.  The revert by itself makes the FORTIFY_SOURCE crash
>> go away and reintroduces a blank line in the log.  Removing the \n from
>> the string passed to dev_info as well makes the blank line go away.
>>
> 
> I just sent the revert. I will try removing \n from dev_info()
> later on tomorrow.
> 
> My quick trial still showed extra line which didn't make sense
> to me. More trials have to wait for tomorrow.
> 

Hmm - there are 3 places that print build_date in  mt76_connac2_load_ram()

3022         dev_info(dev->dev, "WM Firmware Version: %.10s, Build Time: %.15s\n     ",
3023                  hdr->fw_ver, hdr->build_date);


3051         dev_info(dev->dev, "WA Firmware Version: %.10s, Build Time: %.15s\n     ",
3052                  hdr->fw_ver, hdr->build_date);

3127         dev_info(dev->dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
3128                  be32_to_cpu(hdr->hw_sw_ver), hdr->build_date);

The last one prints %.16s and other two do %.15s - is the fix simply
changing last one on line 3127 to print %.15s - this avoids printing
the extra \n?

thanks,
-- Shuah

