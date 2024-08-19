Return-Path: <linux-wireless+bounces-11617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9951F9569D5
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 13:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8271C2246B
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 11:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1145016B381;
	Mon, 19 Aug 2024 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRbShc4h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7073815DBAB
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068075; cv=none; b=ouLmUNTlNS7XVctSAzflL/A46wuJE17dNuC16akUPjhLdKEiwuDajFchKTE4F/WZOOODe9JwqQNQI+mulgrzhp0JsD9RSdiTYOy3i2jkn9oQsnhBerKGh9ew+Sjbh1IMq38n32rwki8vlFDyqgXmUp5amK73UKZqjigyl0DEqoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068075; c=relaxed/simple;
	bh=2kE2LePAAcpuM+xGIztbkq3u0cdJiVPEGITi7YqmtzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZTopg4EuEWC5x0/zZ7B9naIUBYO972bPh65E4eZIaliQ8NZbDSUfwCHqX71da+Oz9+a+1ZwGOeWmflhDNZBughIEYVq4l0bNtvSEKfxjzrhajq7Iv6m1eeVfBkhs96whYezS+J228S98De0M4t6/82RkGOvvF04bGP5NfhhBXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRbShc4h; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44fee8813c3so25440031cf.2
        for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 04:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724068072; x=1724672872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5d7cw/YWHZ4nKAN+vpIKJ2wO1nm4VwfTAFEM5eJD4Q=;
        b=KRbShc4hOkO0jfS2NZxu8DPKDNzAzNmGrY8LVSdN320oTbOLalTfXPyU0c/vTruJM4
         ouwnl0Sbh9GeA2LvllRqaBl7uXksk1Px7//3rlqpC2ixPj5PiEJl5JJpQb+iYcHqNPzv
         iNOSGGcVlBnkTUlUUowU6bvvX41UX/GZKYQY5fqKKxOL4nrPkcLsulXtG0dZEdGkBzgp
         szokTUkvH2R8ecG8MY7/35T3F/O98j6e03NTLkI6GdeCNJL7xPwCcRU7nKU1/Cu4FK7a
         SRGn8LferNjSLBznUKKBvXTJzKQ1QWNfIwfGZ2Gn2bBVrdLh3zi8rcFSey4hDDihxEUu
         aKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724068072; x=1724672872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5d7cw/YWHZ4nKAN+vpIKJ2wO1nm4VwfTAFEM5eJD4Q=;
        b=D7FmzebZePw79dloeKcs48KHRG4Dn56Qtpjdqj3o5ojM1ol2mEKRvyXONl0Iel5we7
         CiyQ/rVFMZRukprYQx1wTHKzV5Rzp6OE15eg3BuTzIeSeCAsDGqVlSNvXctlYIV18OMB
         f5ms9dwsxmef2fsBylgFNAblcwNlidJcglJF7wZCIb9q98zQGtPLrfUB0Ty+ofYOEMQg
         KT87A6DpINNQ8pWKGmw/qDDSwKA2/IUfXezs1ke19dqXyT2GNZPXonaUIzXC7azmeXZg
         WWxLAcnreUoZIcFmeyCb1Ey2x4RLWHfz9wpfAqPADMbhErM6ifeMF8j6W6E9zzzghb+1
         rHCQ==
X-Gm-Message-State: AOJu0YwuBlLuZpv8lUmAO39AEm5VR/3CoPCd0o4IZGdROo7S6XzCHdMP
	RiiGIkgW/dEsCYWAXhbfFR4iRpe+Iffg/BmbOYNIP359Izj3vE8p
X-Google-Smtp-Source: AGHT+IEwn4dvL8BKDykbdDKw/fXfIwMmGaf0fumMw/yF9FcviDfDSH6adsnhTCOGh+MUDuQ2pZBBUA==
X-Received: by 2002:a05:622a:590d:b0:450:9:a434 with SMTP id d75a77b69052e-45374207abdmr127292521cf.19.1724068072090;
        Mon, 19 Aug 2024 04:47:52 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fe6da1sm39618721cf.22.2024.08.19.04.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 04:47:51 -0700 (PDT)
Message-ID: <6e93a6c8-015f-4649-8c72-d21fa9f9fde9@gmail.com>
Date: Mon, 19 Aug 2024 04:47:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] wifi: ath10k: fix invalid VHT parameters
To: Baochen Qiang <quic_bqiang@quicinc.com>, ath10k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20240711020344.98040-1-quic_bqiang@quicinc.com>
 <603104a7-a1ea-43c2-b0d5-fd4e46a27fe6@gmail.com>
 <64c8a9c6-9da7-4e25-9245-490c9e7e21d2@gmail.com>
 <e49b05be-7fdd-4007-9137-e46703812fa1@quicinc.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <e49b05be-7fdd-4007-9137-e46703812fa1@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Baochen,

On 8/19/24 2:45 AM, Baochen Qiang wrote:
>
> On 8/14/2024 11:46 PM, James Prestwood wrote:
>> Hi Baochen,
>>
>> On 7/15/24 5:38 AM, James Prestwood wrote:
>>> Hi Baochen,
>>>
>>> I've compiled both changes and so far those messages are gone.
>>>
>>> Tested-By: James Prestwood <prestwoj@gmail.com> # on QCA6174 hw3.2
>> I just noticed another one actually:
>>
>> invalid vht params rate 585 100kbps nss 1 mcs 4
> Ah :(
>
> James, could you share some info about this? like hardware target, firmware version, AP model, and any specific steps to hit this.

This is running with your fixes in this patch set, which did fix the 
majority of the "invalid vht params" messages, but then recently I 
noticed some others.

The hardware:

kernel: ath10k_pci 0000:02:00.0: qca6174 hw3.2 target 0x05030000 chip_id 
0x00340aff sub 168c:3363
kernel: ath10k_pci 0000:02:00.0: firmware ver WLAN.RM.4.4.1-00288- api 6 
features wowlan,ignore-otp,mfp crc32 bf907c7c

And its actually a few more than I thought:

ath10k_pci 0000:02:00.0: invalid vht params rate 900 100kbps nss 3 mcs 4
ath10k_pci 0000:02:00.0: invalid vht params rate 867 100kbps nss 2 mcs 6
ath10k_pci 0000:02:00.0: invalid vht params rate 540 100kbps nss 3 mcs 3
ath10k_pci 0000:02:00.0: invalid vht params rate 1500 100kbps nss 3 mcs 7

I unfortunately don't have a way to reproduce it. We just see this now 
somewhat rarely, e.g. 13 of the above in the last 3 days. I assume its 
just when the MCS/NSS changes and we hit a rate that isn't mapped right 
like the few you fixed.

Thanks,

James


>
>> Thanks,
>>
>> James
>>
>>> On 7/10/24 7:03 PM, Baochen Qiang wrote:
>>>> supported_vht_mcs_rate_nss1 and supported_vht_mcs_rate_nss2 in host do not
>>>> align with firmware's definitions, resulting in some warnings. Fix them.
>>>>
>>>> Baochen Qiang (2):
>>>>     wifi: ath10k: fix invalid VHT parameters in
>>>>       supported_vht_mcs_rate_nss1
>>>>     wifi: ath10k: fix invalid VHT parameters in
>>>>       supported_vht_mcs_rate_nss2
>>>>
>>>>    drivers/net/wireless/ath/ath10k/mac.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>>
>>>> base-commit: db1ce56e6e1d395dd42a3cd6332a871d9be59c45

