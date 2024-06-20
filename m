Return-Path: <linux-wireless+bounces-9340-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8906391152F
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 23:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0121C229F2
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 21:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A36F6F311;
	Thu, 20 Jun 2024 21:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="OsBw3Pqu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10913757E3
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 21:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718920404; cv=none; b=pAYgR0g2Iv0OBHAX1763GBjOgQJHy3xGAxIXZykv3FrglJ4EkA1imtJ+Tfmj23SjpOBveAqXsCg7TycomtmiJUIrCvd6tRquVpzelh8H5MzZdzk0hro30qG3HzA06L0aaD5z+NHi3RA9PTeNWvkdz1lwnAkeOT9oVuMFFrRthGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718920404; c=relaxed/simple;
	bh=7TT9B+hStNm4w3T3KVJ+4AA0JPJhPyaoLdCBUUM124w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGmFDknzbvtQ49oSybRYdvKcH+LKoXmHJMRfDGYTwBBMwXVoCaRZt1cFqtSRxq6q11ZjvPfAAamCLP3/3SveTI27ld6vABwzACTNoxW4KHBDAeq/9GmBE8eyxR3XuxRRpJvy+gNOHJACZtouwJR9qwYlig13kT/thXj1HNpMzyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=OsBw3Pqu; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id BFDE82C5849
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 21:44:50 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 4BB05B00066;
	Thu, 20 Jun 2024 21:44:43 +0000 (UTC)
Received: from [192.168.166.224] (70.sub-174-231-83.myvzw.com [174.231.83.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 1786C13C2B0;
	Thu, 20 Jun 2024 14:44:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1786C13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1718919881;
	bh=7TT9B+hStNm4w3T3KVJ+4AA0JPJhPyaoLdCBUUM124w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OsBw3PquHy99wxqUmn21LVnM+Yllt8CGWosI8j5daD7OMve+K5DoeujE6g1qRy/YR
	 VGjR/Y6gDrQ8mmB5hS6DPFcvvU+FKjs8WEJ7gkG9q5KIgO0McOApboWnwOyedPIoVK
	 foOuK/2y3eTOymsXuw17ee0+LhqrZx2OwAyQLG1g=
Message-ID: <cc12d6e8-bafb-e2d2-dac6-45fb8a64aafc@candelatech.com>
Date: Thu, 20 Jun 2024 14:44:38 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Intel BE200 - mld/mlo supplicant testing
Content-Language: en-MW
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>,
 linux-wireless <linux-wireless@vger.kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
References: <CAFED-jnTOkH6BwUAUnTvr9SSqrwV-2fUCuwywwt+JOKQJx__ew@mail.gmail.com>
 <CAFED-j=_DRXb6+dTGRaBGGtD_efrCw1BPC2CvLfZpRxoPVQB_g@mail.gmail.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <CAFED-j=_DRXb6+dTGRaBGGtD_efrCw1BPC2CvLfZpRxoPVQB_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1718919884-fTXsh69mHdYK
X-MDID-O:
 us5;ut7;1718919884;fTXsh69mHdYK;<greearb@candelatech.com>;34c747a789912928d0aa9a6167f839c3

On 6/20/24 11:13, Janusz Dziedzic wrote:
> czw., 20 cze 2024 o 20:10 Janusz Dziedzic <janusz.dziedzic@gmail.com>
> napisał(a):
>>
>> Hello,
>>
>> Just check:
>>   -  6.10.0-rc4-next-20240619
>>   - latest supplicant
>>
>> Seems supplicant report:
>>
> nl80211: EML Capability: 0x0 MLD Capability: 0x0
> nl80211: EML Capability: 0x0 MLD Capability: 0x0
> 
> 
>>
>> WIPHY_FLAG_SUPPORTS_MLO
> I see only hwsim set it today.
> 
> My iwl firmware:
> loaded firmware version 90.38c93dbc.0 gl-c0-fm-c0-90.ucode op_mode iwlmvm
> 
> So, question here - how could I use Intel BE200 with MLO/MLD?
> Do I need some test firmware/driver?
> Or just set WIPHY_FLAG_SUPPORTS_MLO with FW I already have?

Add patch to iwlwifi to re-enable that flag.  The 6.10 kernel on my (greearb)
github has it (among a lot of other stuff you may or may not want), and we had some
success testing MLO with the v90 intel firmware.

Thanks,
Ben

> 
> BR
> Janusz
> 
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

