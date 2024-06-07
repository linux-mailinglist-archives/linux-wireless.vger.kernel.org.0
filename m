Return-Path: <linux-wireless+bounces-8686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5EC900191
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 13:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8191C22E8E
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 11:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A64D1862BF;
	Fri,  7 Jun 2024 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Jzk1Omjh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59441862B8
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758271; cv=none; b=iJr0Uq+XamDVJO7lVV9v9sEiCw+lQjxTtDIPoWJq1CXfSJZu588Y8S5f8KFVHbKAVuTEUSjxR2F8IjV3kuhNYwZp3T8ZZbviawarURmoz2KZV2fAqr+32MEJrhbQvpBov04LItkbHil1PcKcX4hcbSYPvh5t39Knz9TaZvtEpJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758271; c=relaxed/simple;
	bh=ltQkzk+5DKkvhyCz6MIBT2v8rK+b7coXNDX/sKwIsRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKZKJJUx7LspXSwXKagkYcVDqICfkohvAMQbNwTS4/DugqDdOWGmR+BGGT/ldW7InJ57G/tdxkoh0DWA61Nmg/mDuIlDSktiX5tFX4toqenOrNhAr6gthPhZ/3ZaYaBaNMkgPJGWGVah0V3RCZXiv47xMw4N6cFQAY5JLDeFncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Jzk1Omjh; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fispS20cFDaSfj9ElcLdmKhsIT5a+xs6wq1EJuK18P0=; b=Jzk1Omjh0wNozjIEpqlHS/YVEp
	wCzYMMKV641v957XXKEAkmIMmwnSB0wC3GdEcMu0+PLVlV6qVOx/5NBlewZf77pdlJQDGg7xrM7Ff
	iKbGUO5xPCUQ86scXVo/mRUMetoAVSREF2ILUPKgl15E0BjxxXSpqiueeTvLq66S2AvM=;
Received: from p4ff13226.dip0.t-ipconnect.de ([79.241.50.38] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sFXOS-008sN8-1z;
	Fri, 07 Jun 2024 13:04:24 +0200
Message-ID: <096940e3-713a-4533-ab0f-e82bd647e205@nbd.name>
Date: Fri, 7 Jun 2024 13:04:24 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 6/8] wifi: mac80211: extend ifcomb check functions for
 multi-radio
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
 linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net, quic_adisi@quicinc.com,
 ath12k@lists.infradead.org
References: <cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
 <bc603fc671010bb720e75881ef0e22d81ec6e2eb.1717696995.git-series.nbd@nbd.name>
 <a337de2e-fe3e-18ed-b55b-9ea2cd21baed@quicinc.com>
 <1f32cb6c-6be8-4e3d-8e8f-2d3c728875a9@nbd.name>
 <479752f5-221d-746b-7513-ba27ef547ac1@quicinc.com>
From: Felix Fietkau <nbd@nbd.name>
Content-Language: en-US
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <479752f5-221d-746b-7513-ba27ef547ac1@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.06.24 12:53, Karthikeyan Periyasamy wrote:
> 
> 
> On 6/7/2024 3:52 PM, Felix Fietkau wrote:
>> On 07.06.24 12:07, Karthikeyan Periyasamy wrote:
>>>
>>>
>>> On 6/6/2024 11:37 PM, Felix Fietkau wrote:
>>>> Add support for counting global and per-radio max/current number of
>>>> channels, as well as checking radio-specific interface combinations.
>>>>
>>>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>>>> ---
>>>>   net/mac80211/cfg.c         |   7 +-
>>>>   net/mac80211/chan.c        |  17 +++--
>>>>   net/mac80211/ibss.c        |   2 +-
>>>>   net/mac80211/ieee80211_i.h |   6 +-
>>>>   net/mac80211/iface.c       |   2 +-
>>>>   net/mac80211/util.c        | 131 
>>>> +++++++++++++++++++++++++++-----------
>>>>   6 files changed, 116 insertions(+), 49 deletions(-)
>>>>
>>>> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
>>>> index 62119e957cd8..950b7b72f0b8 100644
>>>> --- a/net/mac80211/cfg.c
>>>> +++ b/net/mac80211/cfg.c
>>>> @@ -263,7 +263,7 @@ static int ieee80211_start_p2p_device(struct 
>>>> wiphy *wiphy,
>>>>       lockdep_assert_wiphy(sdata->local->hw.wiphy);
>>>> -    ret = ieee80211_check_combinations(sdata, NULL, 0, 0);
>>>> +    ret = ieee80211_check_combinations(sdata, NULL, 0, 0, -1);
>>>>       if (ret < 0)
>>>>           return ret;
>>>> @@ -285,7 +285,7 @@ static int ieee80211_start_nan(struct wiphy *wiphy,
>>>>       lockdep_assert_wiphy(sdata->local->hw.wiphy);
>>>> -    ret = ieee80211_check_combinations(sdata, NULL, 0, 0);
>>>> +    ret = ieee80211_check_combinations(sdata, NULL, 0, 0, -1);
>>>>       if (ret < 0)
>>>>           return ret;
>>>> @@ -4001,7 +4001,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, 
>>>> struct net_device *dev,
>>>>           goto out;
>>>>       /* if reservation is invalid then this will fail */
>>>> -    err = ieee80211_check_combinations(sdata, NULL, chanctx->mode, 0);
>>>> +    err = ieee80211_check_combinations(sdata, NULL, chanctx->mode, 
>>>> 0, -1);
>>>
>>> Once we reach the global limit, all the -1 passing caller get fail
>>> becuase the iface check param (existing and new) is validated against
>>> the global limit. since global limt as a sort of union of all per-radio
>>> limits.
>>>
>>> Ex:
>>> Global iface = 6 (Radio iface 2GHz:4, 5GHz:4, 6GHz:6)
>>>
>>>
>>> So far 6 iface created (Radio iface 2GHz:2, 5GHz:3, 6GHz:1)
>>>
>>> In this case, new iface creation get fail because caller uses
>>> ieee80211_check_combinations() with -1 as radio idx, so it checked
>>> against global limit
>> 
>> Use the sum of the number of interfaces from each radio instead of the 
>> maximum.
> 
> Oh, then legacy user have misconception of the global interfaces
> advertised and try to fail for the allowed limits.

Sure, but that might be an issue either way until user space is updated 
and users start looking at the per-radio ifcomb data.
The global data is simply not enough to describe the details of the 
radio split.

- Felix

