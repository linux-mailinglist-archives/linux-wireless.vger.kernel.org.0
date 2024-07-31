Return-Path: <linux-wireless+bounces-10756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D229433F5
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 18:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8041F24DA4
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 16:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F093C1BB6B2;
	Wed, 31 Jul 2024 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="ZhS3voQW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35291B29A7
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442450; cv=none; b=QwngxcKCoI7rg7DWxbWowOrAHe1ZplNb2meefdY5IEc729q0zgyRWrG1aJIQBS+FQlvi6jptzQfhBxywyK4M8B+sKMiJoAgYyY/E+D2z+utpNFr+lU0bgVfKjaxIbaTJ5yD8GqkSm6ljbzVe1/fGT7wukJFHR/NKxPzEu2fAdkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442450; c=relaxed/simple;
	bh=IDvyFcrV4a+Fp8uQoeZa7lRsG3SBu5cWL4QFaQw3ox4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eV5jLHdxm5e2CVtL89jJR1jrxbhN123OOwXVznXr8K4xtwRn6CapGRXHUoPnbjm234c6xT5O1l4oVrn9IYkEWZStwQja1n+rZjfl9HDWMa6ob3NRA8X0mvbCJgFg1o9o4De04wwLsI0pdfs7pBBlYkCVKMk498VKIleYU+ip/68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=ZhS3voQW; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8557444008F;
	Wed, 31 Jul 2024 16:14:00 +0000 (UTC)
Received: from [10.0.0.141] (c-73-239-116-235.hsd1.wa.comcast.net [73.239.116.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 84D8213C2B0;
	Wed, 31 Jul 2024 09:13:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 84D8213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1722442440;
	bh=IDvyFcrV4a+Fp8uQoeZa7lRsG3SBu5cWL4QFaQw3ox4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZhS3voQW5f+glXQ2bUhkHF1I32MyeYLr2M5bvfRY70wtzQVAXQkjywMPITKxh1m18
	 bwjfG7izpTndAosTiXw4PePUV0b5xH8e3n6FJmD2b9Sr5++VqBXm4MHEDjpmA+Dc/K
	 KOlUshqsw3is0k3pI4UhuDkwZtIDi0dtodMF8qzs=
Message-ID: <f2219dd4-3ae6-42f2-bd9e-2fb0112a65af@candelatech.com>
Date: Wed, 31 Jul 2024 09:13:58 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iw: scan: add EHT beacon info support
To: Kalle Valo <kvalo@kernel.org>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org
References: <20240729220421.2030748-2-dylan.eskew@candelatech.com>
 <87bk2dlxou.fsf@kernel.org>
Content-Language: en-US
From: "Dylan E." <dylan.eskew@candelatech.com>
In-Reply-To: <87bk2dlxou.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1722442441-Qrfary-m8Dp2
X-MDID-O:
 us5;at1;1722442441;Qrfary-m8Dp2;<dylan.eskew@candelatech.com>;9989741adba0574bb335b9e9d00002fb

Ah, I did not realize. I will rectify this.

- Dylan

On 7/31/24 02:26, Kalle Valo wrote:
> "Dylan E." <dylan.eskew@candelatech.com> writes:
>
>> Update and add to the old EHT beacon info implementation to print
>> EHT PHY and MAC capabilities as well as MCS/NSS information for WiFi-7
>> beacons.
>>
>> Signed-off-by: Dylan E. <dylan.eskew@candelatech.com>
> I assume your last name is not "E.". We use full legal names in From and
> s-o-b fields, the same name as you would use to sign a legal document.
>

