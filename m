Return-Path: <linux-wireless+bounces-4275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC8986D70E
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 23:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB4C1F2627E
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 22:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3C32260A;
	Thu, 29 Feb 2024 22:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="RKiKIyTJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7B616FF51
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 22:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709247234; cv=none; b=gf2ksuze+333ECIS+oBMDFOhP51G4QujzF/tJFEKsTrvT2Q19bnDrKS9q3LHPDwmEleMOdEQp1JANaJVFo1dxex+Sc9n7tTocwADawXmH/1UNR7vlUyfCGLbWRQKZdflSaxR2C+YtBjkIJsh/GwrYV+/zIPZ48BBEVFSKMFTTog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709247234; c=relaxed/simple;
	bh=Kk+mCtsdo1C+zMRPhkUufeNKxpL9EnMUcP1ZFW4XGz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1CNAu3o7fHG9HwvsH8eaF+3GeUnu5R35cTjmfJ41tYahG2XQCEZvbpRv5XfUg1pOh0sU8fuyIv/QkihnQRRFeSDpXUeO6yZ7we/J29T2p8LKMh8Ach5BfYOU15Pa4tmKftpKq4W51RUMESTvtUVaiCgTYbIAC0WHh9yeJvW/ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=RKiKIyTJ; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5F6448007C;
	Thu, 29 Feb 2024 22:53:34 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id ADF7C13C2B0;
	Thu, 29 Feb 2024 14:53:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com ADF7C13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1709247213;
	bh=Kk+mCtsdo1C+zMRPhkUufeNKxpL9EnMUcP1ZFW4XGz0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RKiKIyTJAwjdC6R2wtJafzqvytVL82/4DQ1T6SrZ2E+reZ4yc9DmMzKOIt/n9as4L
	 62Ff2DrS+pUHOvCVdhmNcvJ83xrr123IuzusmNIUrxvL9cSatQZGl7CPcbvArP1C0S
	 6uuvy/TsAd1RmBjXkCFQCUEscafNPOBc6b5Et8eY=
Message-ID: <2368f17c-5c27-f96b-d13f-a6b6e40eefbb@candelatech.com>
Date: Thu, 29 Feb 2024 14:53:33 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 11/13] wifi: mac80211: fix advertised TTLM scheduling
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, Ayala Beker <ayala.beker@intel.com>
References: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
 <20231220133549.15079c34e5c8.I0dd50bcceff5953080cdd7aee5118b72c78c6507@changeid>
 <b502cc28-865c-4f00-9f09-76851d6629ba@candelatech.com>
 <4b906144041ab6e7bf4fb35e6cb42635c8cd21d5.camel@sipsolutions.net>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <4b906144041ab6e7bf4fb35e6cb42635c8cd21d5.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1709247215-S2zUhACfgJ3y
X-MDID-O:
 us5;at1;1709247215;S2zUhACfgJ3y;<greearb@candelatech.com>;99fdaccc4e084a2fd5cb63a9d04fe0c6

On 2/29/24 14:47, Johannes Berg wrote:
> On Thu, 2024-02-29 at 13:41 -0800, Ben Greear wrote:
>> On 12/20/23 03:41, Miri Korenblit wrote:
>>> From: Ayala Beker <ayala.beker@intel.com>
>>>
>>> Handle a case of time overflow, where the switch time might
>>> be smaller than the partial TSF in the beacon.
>>> Additionally, apply advertised TTLM earlier in order to be
>>> ready on time on the newly activated links.
>>>
>>> Fixes: 702e80470a33 ("wifi: mac80211: support handling of advertised TID-to-link mapping")
>>> Signed-off-by: Ayala Beker <ayala.beker@intel.com>
>>> Reviewed-by: Johannes Berg <johannes.berg@intel.com>
>>> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
>>
>> While rebasing my 6.7 tree on 6.8, I notice this patch applied, which I think means
>> it was not applied to 6.8 upstream.  Was that on purpose?
>>
> 
> It's there as far as I can tell?

Yes, sorry about that.  I even did a grep but my eyes saw only what they
expected to see.  I just ended up with it double-applied, and will fix
that in my tree.

Thanks,
Ben

> 
> 
> commit b1a23f8ae0d76ad32fe36682730c050251275b0b
> Author: Ayala Beker <ayala.beker@intel.com>
> Date:   Wed Dec 20 13:41:44 2023 +0200
> 
>      wifi: mac80211: fix advertised TTLM scheduling
> 
> 
> Maybe git rebase reduced yours to some whitespace changes or something
> :)
> 
> johannes
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



