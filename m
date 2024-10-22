Return-Path: <linux-wireless+bounces-14335-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D333B9AB39E
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 18:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA311C22BFE
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 16:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DFF13957E;
	Tue, 22 Oct 2024 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="b6X1AenF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC641A4F2B
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613673; cv=none; b=tZvjgtItHxDrpjPG1A4QbeFpevVMnZsEhnfx6KWGBYAgT0mnn1V7ZUJ3q7BjdTPGSlBgL72PydFhS5w6olJ7oskH7Eiqu7xvT3cwL8w9OmgPqoOjuqYuzk9StPF7ucvgSVQiU3cDCYJe/hBaDblNdFjx8W10raL+J1R6UZJuX40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613673; c=relaxed/simple;
	bh=rxo5ot133js5y5p9zaBIPOPChjBgEkl/PKbg22K6OWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=udquFRoYZ89ACja+IoAGdBdrVw1kQmBjRUMYoCJt+0o7A+aGQEZVeRBC0prs20DxJGyNAaHm3E5SPn9xP5GkVemWuFNlbDNtxWU6Tkoa2elgCM5Bb52cEEZDFMBzotARo1scsci2z4bOdlveWhYvUbLK3pmGVNl8xIjpe1su12g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=b6X1AenF; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 37555280079;
	Tue, 22 Oct 2024 16:14:24 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id B96ED13C2B0;
	Tue, 22 Oct 2024 09:14:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B96ED13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1729613663;
	bh=rxo5ot133js5y5p9zaBIPOPChjBgEkl/PKbg22K6OWA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=b6X1AenFn8e7NKWt6p5a5vYNn1HV+Xt7v2ecpkjKDuImva2KQ30xCIlx3MQDGMqIl
	 URFf0aBUgctXmB6JtsNnOkj1bVaW6KZcFzYmBRQLCcKiHPQMtVRNgoEQs+NrlXvqx3
	 mQH+2R7zvZEcMSkynRIJl6nqhH933DSgGtAa3jPA=
Message-ID: <d739e7a1-5b17-903e-d560-27c442661ab2@candelatech.com>
Date: Tue, 22 Oct 2024 09:14:23 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mac80211: Remove NOP call to ieee80211_hw_config
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20241010204036.1219896-1-greearb@candelatech.com>
 <404d0ef8b9a5e70dcab331a5ee73155313464d06.camel@sipsolutions.net>
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <404d0ef8b9a5e70dcab331a5ee73155313464d06.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1729613664-PMbdfs5z3opj
X-MDID-O:
 us5;ut7;1729613664;PMbdfs5z3opj;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-PPE-TRUSTED: V=1;DIR=OUT;

On 10/22/24 06:29, Johannes Berg wrote:
> On Thu, 2024-10-10 at 13:40 -0700, greearb@candelatech.com wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> If changed is '0', then the ieee80211_hw_config takes no
>> action, so just remove the call in
>> __ieee809211_recalc_txpower()
> 
> Hmm. I think it may have done something in the past, so perhaps this is
> a bug that needs to be fixed instead?
> 
> -       if (!local->use_chanctx)
> -               changed |= ieee80211_hw_conf_chan(local);
> 
> in "wifi: mac80211: simplify non-chanctx drivers".
> 
> But maybe that's exactly the previous patch? Would be nice though to
> have that in the commit message, or if it's related maybe even squash
> them?

I'm not sure exactly how it is all supposed to work, but at least with the patches
I posted, the mtk7996 driver works again.  The mtk7996 driver does still have
code to handle CONF_CHANGE_POWER, so possibly the code you reference above
that if re-added would allow ieee80211_hw_config to configure txpower should
be re-added.

If this is what you mean by previous patch:
mac80211: fix user-power when emulating chanctx
then I don't think it should be squashed with anything, but if you want me to squash it,
let me know and I will do so and repost.

Thanks,
Ben

> 
> johannes
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



