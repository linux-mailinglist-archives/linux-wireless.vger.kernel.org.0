Return-Path: <linux-wireless+bounces-7870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 787858CA952
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 09:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6EE1F2334B
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 07:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4DA4778B;
	Tue, 21 May 2024 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unstable.cc header.i=a@unstable.cc header.b="n0Rr0caw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B4F54BDB;
	Tue, 21 May 2024 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.3.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716277800; cv=none; b=b9fa944iDjhhJ6o09EG21BuY+8Fm1ivf8Prx5v58wb+dcHXOU2MrKltTntR5Hf1NhY44Z3CjUEEwwuWi2CfNXlD6naQItvDJHsUjncnE/NWHSLRjwd/qwAgw2kfGhniPWJMQnkBQFP+a7zsWszAx1uB67vTp/5BuIA9hnvFBXwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716277800; c=relaxed/simple;
	bh=ngJA16RR/OPoMkf7Y90IPOnKzfACzKGIQnec9KB66OI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qg36nT1+X4FA65KElU04xqqrpghMhVJdyFgcgIbEAIW8J3G5UfPMVb6mZYU5CJjC+qcDS906NEFwWmgNHnuu/n9qWtwGTcYFaGXGkpaKyySeFs1rUCcf5aym2VbBh9cUaw7XM7HONRxHGxx9edlxazhPCprmX1inqEN0nP7dB9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unstable.cc; spf=pass smtp.mailfrom=unstable.cc; dkim=pass (2048-bit key) header.d=unstable.cc header.i=a@unstable.cc header.b=n0Rr0caw; arc=none smtp.client-ip=212.3.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unstable.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unstable.cc
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 1C6E662B;
	Tue, 21 May 2024 09:42:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1716277352;
	s=20220809-q8oc; d=unstable.cc; i=a@unstable.cc;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	l=806; bh=bq5w2dOXUmXaYoJcODSZnEnefduxYXuMwA2eq9OQaUA=;
	b=n0Rr0cawN+9kwK/ld4MhADhhB/ovjNsZrbSNOP/1cmqTKmB9LLbYztcKxx/iG45B
	8BItVLyL5olFXnSfgXZ/OlPPqLbm2n3lWooU97HUgdBI6twWM1pTtD/6ecg5QumlISP
	Lmkra4a2jae/+hlsnTg3RvdHCo8Vg1FjDy+jxdqhBV9QSPFQ+KQbWxnsT1VbDNg60y1
	7VsQV4ymKsGkCn+u1vgGl93f3DXaWhZp3rfzc1xeOtbgA4iEvOx1fhqqrRxWdV5Hypw
	hvI9iGdsGpg1IseQjzzHfRmHCvMafwlEVhbMYZr5bflQO/uhDvOt/GDwqkKYOuF9eOa
	98nLFdfUNw==
Received: by smtp.mailfence.com with ESMTPSA ; Tue, 21 May 2024 09:42:30 +0200 (CEST)
Message-ID: <cef03d6c-7be8-4527-b38b-eadca2789f9b@unstable.cc>
Date: Tue, 21 May 2024 09:43:56 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: Lock wiphy in cfg80211_get_station
To: Remi Pommarel <repk@triplefau.lt>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org
References: <983b24a6a176e0800c01aedcd74480d9b551cb13.1716046653.git.repk@triplefau.lt>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <983b24a6a176e0800c01aedcd74480d9b551cb13.1716046653.git.repk@triplefau.lt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-ContactOffice-Account: com:375058688

Hi,

On 18/05/2024 17:50, Remi Pommarel wrote:
> Wiphy should be locked before calling rdev_get_station() (see lockdep
> assert in ieee80211_get_station()).

Adding the lock is fine as nowadays it is taken in pre_doit and released 
in post_doit (with some exceptions). Therefore when invoking 
.get_station from a side path the lock should be taken too.

It was actually a05829a7222e9d10c416dd2dbbf3929fe6646b89 that introduced 
this requirement AFAICS.

> 
> This fixes the following kernel NULL dereference:

As already said by Johannes, I am not sure it truly fixes this NULL 
dereference though.

Have you checked where in ath10k_sta_statistics this is exactly 
happening? Do you think some sta was partly released and thus fields 
were NULLified?

Regards,


-- 
Antonio Quartulli

