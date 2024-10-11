Return-Path: <linux-wireless+bounces-13887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC5D99A430
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 14:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C4928430A
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 12:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46477217322;
	Fri, 11 Oct 2024 12:49:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681CC20C473;
	Fri, 11 Oct 2024 12:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728650971; cv=none; b=K0znWikQtx7bXIKm5Lvxvgb0cQ3lBOVoOnfbpcJMekV9UxrF6DFyw9WgQzT2vHqPMRCO1dbDIsJOt1fVum7w1PBbV9SrQAYYt99bxbfI36ki89F1la0zvmuafMhhbgBFvJYQF2zJHjBBLHaU9ic0TEN/QIVLp92/eOUy0KvJaWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728650971; c=relaxed/simple;
	bh=RQpbF9UMaCW8cg1eIeBjU6RZgWl6uJRfgX6QghLi/0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S04uLLApgo/1tBMi60eqjl8jb88Uy2Y6gTv0cfXM42cjSgUkisTybyatcg/pAqYq2ZYkrCbkZbl6KZupAPQZUIpR/6D74G46gQgw5Ty7AuwjZmj6deGYVKLvHKh5JAHm8VtmTd4NsjM5k0CKFecO/LcxhvRLFcjME59591enBVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id AE7AC61E5FE05;
	Fri, 11 Oct 2024 14:48:44 +0200 (CEST)
Message-ID: <8eda1bd2-88fc-4262-aec0-6f88a73797ef@molgen.mpg.de>
Date: Fri, 11 Oct 2024 14:48:44 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: failed to remove key (0, ce:ce:1e:27:bb:e0) from hardware (-110)
 (ETIMEDOUT)
To: James Prestwood <prestwoj@gmail.com>
Cc: Kalle Valo <kvalo@kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>,
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 LKML <linux-kernel@vger.kernel.org>
References: <d8253ab3-f4f0-40fd-a550-d75eef121b56@molgen.mpg.de>
 <8be8619d-f09f-43b2-ada8-2fca2a7d8ea5@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <8be8619d-f09f-43b2-ada8-2fca2a7d8ea5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear James,


Am 04.09.24 um 16:09 schrieb James Prestwood:

> On 9/4/24 3:45 AM, Paul Menzel wrote:

>> Linux 6.11-rc6+ logged the warning below when resuming from ACPI S3 
>> (or unloading and loading the `ath10k_core`/`ath10k_pci` modules) 
>> having been connected to an AVM network:
>>
>>     wlp58s0: failed to remove key (0, ce:ce:1e:27:bb:e0) from hardware (-110)
>>
>> Error code 110 is the value for ETIMEDOUT. I saw James patch [1], and 
>> applied it, and the error is still there (as expected).
> 
> My patch won't actually fix the timeout, I just lowered the time that 
> ath10k would wait before it continued which fixed some incompatibility 
> on the AP side of things. Based on your logs though, it appears you 
> already got disconnected before the failure to remove the key...

I am still applying your patch manually on the current master branch, 
and it looks like it hasn’t still been reviewed. Maybe it’s due to the 
RFC tag. Do you plan on moving it ahead?


Kind regards,

Paul


>> [1]: https://lore.kernel.org/all/20240814164507.996303-1-prestwoj@gmail.com/

