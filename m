Return-Path: <linux-wireless+bounces-8678-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A11900017
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 12:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61B12B22FD6
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 10:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644F115CD4D;
	Fri,  7 Jun 2024 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="UvgQ+vKh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3803715B99D
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754437; cv=none; b=EyvxfwCrRsvk2lQNkQOOxv3kKO6fOcGL+WGReaKdwjkvskL8ux13g4dA/8eGM3y6jh+MllkG0fP2ZvMyj2wMRZCfO30oZa9T5Zovc40gZrz50FBZV/NLUZuMOXIy2DOIBzVIIPp3PZPpUl4SJy0BWGXbPeit9/Q5JAgzRSVCr8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754437; c=relaxed/simple;
	bh=7E4HtPLIw8sTz5LGdU2O2J9Ct8razI8eMNK36M1Nk9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+lLiYWqYabO5ckrf/ft8l7uABPY4ezLmFTNtjU5A+JB4PWKWFeaCy3spteGR4XAQMzWJ9UtHPqKQv10fcXZwe/WltvTaAURVemBENm2X10rqUEA+TOALIcYXUlbEErUui9wIpsint55nNE1CUHyQzQ6mq4rsE5RTDzeNFELMO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=UvgQ+vKh; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g4Dq4IjFiBoum8D5sFwswSjNrHssL9Lf4YpXqPif9Wc=; b=UvgQ+vKhoi+ZMSuw51J55epZSj
	rX6rZXa8cpypYjaw7oYAXpRtrYj+6eKZTFD277B+mLTJycuFlCWGZi2TD/n6HDvWRZUjkke8J+7CF
	s03FkLItQH4zW+4+ym612Hh35Et405OiHmv7h2aZfNg876gFOE4O0MsMHsLQwVBq0oeQ=;
Received: from p4ff13226.dip0.t-ipconnect.de ([79.241.50.38] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sFWOd-008rWv-2V;
	Fri, 07 Jun 2024 12:00:31 +0200
Message-ID: <ce3cd7b2-4e95-411f-a08c-4bb86ad4be7e@nbd.name>
Date: Fri, 7 Jun 2024 12:00:31 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 2/8] wifi: cfg80211: add support for advertising multiple
 radios belonging to a wiphy
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: quic_adisi@quicinc.com, quic_periyasa@quicinc.com,
 ath12k@lists.infradead.org
References: <cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
 <db7d83ea6d97e118a14029727e9e18d6e47b753d.1717696995.git-series.nbd@nbd.name>
 <0ae7869140c8c2537fc638dba14223b25383f3d9.camel@sipsolutions.net>
Content-Language: en-US
From: Felix Fietkau <nbd@nbd.name>
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
In-Reply-To: <0ae7869140c8c2537fc638dba14223b25383f3d9.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.06.24 11:24, Johannes Berg wrote:
> On Thu, 2024-06-06 at 20:07 +0200, Felix Fietkau wrote:
> 
>> The prerequisite for MLO support in cfg80211/mac80211 is that all the links
>> participating in MLO must be from the same wiphy/ieee80211_hw. To meet this
>> expectation, some drivers may need to group multiple discrete hardware each
>> acting as a link in MLO under single wiphy.
> 
> This is of course the motivation now, but I do wonder if this wouldn't
> potentially also apply to a single device that's full dual-band capable
> in some way? But doesn't really matter now.
> 
> But the thing is that it would let userspace differentiate between what
> we mostly have today in a single device (multiple channels can be used,
> but you have to go to powersave etc.), vs. a fully concurrent device.
> 
> IOW, it feels like this could be used to advertise fully concurrent
> capabilities?

Yes, that's my intention with the patches as well. I will update the 
description.

>> + * struct wiphy_radio - This structure describes a physical radio belonging
>> + * to a wiphy. It is used to describe concurrent-channel capabilities of the
>> + * phy. Only one channel can be active on the radio described by struct
>> + * wiphy_radio.
> 
> that's a bit long for the 'short description' :P
> 
> maybe just say "struct wiphy_radio - physical radio of a wiphy" and move
> the full description down.

Sure

>> + *
>> + * @radio: radios belonging to this wiphy
>> + * @n_radio: number of radios
> 
> Somewhere - either here or above - we should probably say that it's
> assumed you only have a single radio (with the properties covered by the
> interface combinations in the wiphy itself) if this isn't given at all.
> 
> (Which is what we assume today, more or less.)
> 
>> +++ b/include/uapi/linux/nl80211.h
>> @@ -3401,6 +3401,8 @@ enum nl80211_attrs {
>>  
>>  	NL80211_ATTR_ASSOC_SPP_AMSDU,
>>  
>> +	NL80211_ATTR_RADIOS,
> 
> missing docs
> 
>> +/**
>> + * enum nl80211_wiphy_radio_attrs - wiphy radio attributes
>> + *
>> + * @__NL80211_WIPHY_RADIO_ATTR_INVALID: Invalid
> 
> maybe if this is WIPHY_RADIO also call it NL80211_ATTR_WIPHY_RADIOS
> above?

Will do

>> + * @NL80211_WIPHY_RADIO_ATTR_FREQ_RANGES: Nested array of frequency ranges
>> + *	supported by this radio.
> 
> Do we really want this complexity? We only have a single range now, do
> we expect that to change? Non-contiguous ranges, where a hole in the
> middle is supported by another radio?
> 
> Not sure I see the value vs. just having min/max freq directly here?

I think there's hardware where one of the radios can be dual-band 
(non-concurrent).

>> +	freqs = nla_nest_start_noflag(msg, NL80211_WIPHY_RADIO_ATTR_FREQ_RANGES);
> 
> Please don't add new _noflag code.
> 
>> +	nl_combis = nla_nest_start_noflag(msg,
>> +					  NL80211_WIPHY_RADIO_ATTR_INTERFACE_COMBINATIONS);
> 
> same here
> 
> (and yes maybe userspace wants to unify the parsing of this with the
> existing interface combinations attribute and pass the attribute ID or
> something, but then it can fix the nested flag too.)

Will remove _noflag.

- Felix


