Return-Path: <linux-wireless+bounces-19216-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AC4A3DBFA
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 15:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BEE3188FDBE
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8184D1FAC30;
	Thu, 20 Feb 2025 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSGQBoMA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26BA1F9AB6
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059819; cv=none; b=Aiw31/EGDbK9xuI37Sz8l5S/vmMGdpWoPBECsWIW3UGX/y20/9IyJPlc3K+VN9mJCSPZa7ZCrnPYhYgK2lkY6QkJo2RVaXssjleZCn8ZGvcPYSaC6CVa9IYjqQaLC75KsSfVl8CMn/uR1Ju+dJOrXg3IoatJ3q2EVYN/R5jkVc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059819; c=relaxed/simple;
	bh=SuPwTUl1+D+jR/4WrqO+zOBr8f2Al33bxXl4oTe9mmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cU2qNwdNT9GTo6yTxhjlg7eWWXZf5NtUQ1RTAPalxu7sMzFSVJiZ+qNoN2/JEWRMMHLDTGjBQ1DOXDu6U7lnZ3m9f6SMYGNcFes25Q27aVDcapbTXdhTJrF8oOIzxLtaOM1UY/nJvDZuGtDaCkTGBE22xBCHx7bPetieD1VWPjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSGQBoMA; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c0b9f35dc7so123138785a.2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 05:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740059816; x=1740664616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RW0UCqWX/l+n3jYLyBzuECOY8BYnHFlum299EUoN1U8=;
        b=WSGQBoMA2kXLCQY3seVbH9hjHbppvWSxCTZSB9oINjRfHRG3iDjEXp9/u04ru6gKZD
         Ge/G4Ru35ceSttcIA/2lgFzdJRIFsXwzRDzPMog92PTwzM8l7TtpT7NDV2xBUQ1isgxX
         PuSQUSP/X8fz/u21zoMXQJ6j/toh0tFqhv9WRkKdRGn7G2bp2VIlOgK8Ydj4OfifFwTH
         OT6EOLZEy9fDyj20w8KdmKrxN4NQRfcm1UYPMOenAsYSGw+NbbKPH+SiSV7YbgjIf8O+
         2nUyuQgihNq4/XP3oYnlUG61tfLYUiAr/hp7RArxfSjHjDaT0n6Xp+qJFxTGx8H12rDa
         XKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740059816; x=1740664616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RW0UCqWX/l+n3jYLyBzuECOY8BYnHFlum299EUoN1U8=;
        b=ln4SEtiDwrNhWjI5MCrW4lFwWHw3HqgXqxhGOK5E85+KT59k2U53NbBpBChBKupwYe
         jV8m7nC6JLktdKpqcdJrpo9tjUny1/Ua6ocv52uOLPYZBYYHvsIDTiGz6JlI7Gc+yD2f
         bNRQvtxE8Z792FN4LaCYCvBuol1tMdlf9zAbV7u+0M0gwZLFdtjK3IuDIQFQ6vfE7FjE
         gPx1ZZACulLhAabla2EJ24YJR9mh2ljOfke95gqt0Nm7Ub4iGGeKosLl2q0QEZkOG0bi
         mmP0CBxFzbdMJ3ORWOsg3nQcwKBbNA27nxRWLVMjnGl1mkUc50ffZl+kDenp0w8xDFjP
         Umiw==
X-Forwarded-Encrypted: i=1; AJvYcCU/OJ7xH5FIjmiI8xrDdULB/nWN9xo8E2ApvbT6wXHzt8FpYDMD3xYvnbmdfPCSrGaiIOiF5fAaBvn8eGACvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyM6R3EmKA+5iAXhwjZSZKR3SEhJOWmqQqitNy3VObFNcAZAmhG
	R0d7YHh0Bc6PZNO+14bbRHv5e9yCfbxHVSOwL2GbvPxOiBCR2xQH
X-Gm-Gg: ASbGncs+dMVc6k6nTQ/9sdojFtDoC7LEk61aL4tiau3nQK8ZYm4c9dd26lkEIbP9GMD
	04uE3V++Zm9jJY0MJrQCtGjq551gp0Iva3VNlQRMo4/Q1JZgFliQNo/F9rf6zpFHeByxmQbTms3
	CSUo0K6knYLVzTrPuvduESP24F7J15uBtfxFTelCJymb7iIRRCCSFHRrhiKAOIteKVdhmB5PPao
	2IJt+cgQfMRN8cFLPuQuiOR6c53z6hy29H3vbrhFUy1wfSM1tWgB88vdg70ymmd4FDnGt9Ynfis
	hUHzOwuzrrD/8JnTEjs=
X-Google-Smtp-Source: AGHT+IFyMpMdZjPWG7BXix80U9jYLJDhistuhM5RgZth54SZJl3KVv1PWz94DWh7WI6Z2Kk7SNjB7Q==
X-Received: by 2002:a05:620a:2a13:b0:7c0:79c3:fd2a with SMTP id af79cd13be357-7c0b53080dcmr1101097285a.43.1740059816622;
        Thu, 20 Feb 2025 05:56:56 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a526cc38sm409417985a.91.2025.02.20.05.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 05:56:56 -0800 (PST)
Message-ID: <ebeb4471-9c89-4b33-9889-b87f2d218508@gmail.com>
Date: Thu, 20 Feb 2025 05:56:54 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] Convert mac80211 to TXQs only
To: Alexander Wetzel <alexander@wetzel-home.de>,
 linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>, ath10k@lists.infradead.org,
 Remi Pommarel <repk@triplefau.lt>
References: <20250217081721.45110-1-Alexander@wetzel-home.de>
 <548270b0-8267-4a94-85ab-597ade0f5082@gmail.com>
 <6586339a-d9c5-4787-95e4-202368341541@wetzel-home.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <6586339a-d9c5-4787-95e4-202368341541@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2/19/25 1:27 PM, Alexander Wetzel wrote:
> On 19.02.25 20:19, James Prestwood wrote:
> ...
>>>
>> Trying to get some clarity if this might fix a regression [1] with 
>> ath10k where upon roaming the TX queue hangs on flush for ~4-10 
>> seconds. I was hopeful for another set [2] but it looks like this 
>> only effected AP mode and with that applied I still notice the behavior.
>>
>> In the worse case we see two failures, which add up to about 10 
>> seconds of delays, more often its just the single "failed to flush 
>> transmit queue"
>>
>> Feb 19 14:15:59 kernel: ath10k_pci 0000:02:00.0: failed to flush sta 
>> txq (sta 6a:3a:0e:22:45:08 skip 0 ar-state 1): 0
>> Feb 19 14:16:04 kernel: ath10k_pci 0000:02:00.0: failed to flush 
>> transmit queue (skip 0 ar-state 1): 0
>>
>> Crossing my fingers this set will have some positive effect here
>>
>
> I had a quick look at ath10k driver and the error message you have. 
> The patch series here will probably not help with that. From driver 
> perspective nothing relevant should be different...
Well thank you for looking at least, I appreciate that.
>
>
>> [1] https://lore.kernel.org/all/ 
>> CA+Xfe4FjUmzM5mvPxGbpJsF3SvSdE5_wgxvgFJ0bsdrKODVXCQ@mail.gmail.com/
>> [2] https://lore.kernel.org/linux-wireless/ 
>> cover.1732293922.git.repk@triplefau.lt/
>>
>> Thanks,
>>
>> James
>>
>

