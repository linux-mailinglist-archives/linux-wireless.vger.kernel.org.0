Return-Path: <linux-wireless+bounces-8677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 745198FFFE4
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 11:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28EB1F239B4
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 09:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5823E200A0;
	Fri,  7 Jun 2024 09:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="LV8w1Sub"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1369F38F86
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754001; cv=none; b=Zgv+vzT8MiCMLmfAc44wMb0UbQ1X3BRq6RssSiglx6vauoCSLYz+wdjZ4IxEOYgAyTCXTY95i4w9eN0/QDK283jPKWZjV7UrdJ5SD0a6mZOZ2e1dccWmw7ovIHlu9KdvdwvVI4pjzxe0OKaPz8p5HriZcLH5FNWlUVhf3Pldmz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754001; c=relaxed/simple;
	bh=fwmxpE++em0KlAqNuSlBzd2aKINdxHQH+tsAz/7z8VQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fe6Smu6wkdzqzjnckziagjcHTRJwtvoT67d2nccu4kO3o+lcfKbvoZP8lit2fuZkMYw4bpxUEg08nEOiHdAEe2xkPAfxOFWkOWcckJvCbj+M5vcDaae89o7FuqVO32JkCqR4HMhQbCnq8SvMMCsCQpYdesPMc271mskmvglXVHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=LV8w1Sub; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gtKIrhZDo3HUPfaEUxWbifFSV2AQTRnni/waVDEvR64=; b=LV8w1Sub1LSmVc2LdCzHaGGRHJ
	GiuDO2J8SQxa+c33Gs8a+og9Wz/fNhtAJVOH8YBAjOXuCebvaOwuA9cEL9/LoJWPFUDY82VLnBeVY
	Znpy7r04g3qC62czXbjOL0faJTNK/b6uoLBCjId7zayv3Gq2cOnvHHNFF4L7Z2oPHipY=;
Received: from p4ff13226.dip0.t-ipconnect.de ([79.241.50.38] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sFWHb-008rRA-2Y;
	Fri, 07 Jun 2024 11:53:15 +0200
Message-ID: <c5abf1ae-bdda-42b2-95c0-9b1c39659bbd@nbd.name>
Date: Fri, 7 Jun 2024 11:53:15 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 8/8] wifi: mac80211: add wiphy radio assignment and
 validation
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: quic_adisi@quicinc.com, quic_periyasa@quicinc.com,
 ath12k@lists.infradead.org
References: <cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
 <9b331a61b8d53284b044bc594cf9952c60164e5f.1717696995.git-series.nbd@nbd.name>
 <a1cff51f789c21b2b307c58ee4d743a62874cec6.camel@sipsolutions.net>
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
In-Reply-To: <a1cff51f789c21b2b307c58ee4d743a62874cec6.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.06.24 11:44, Johannes Berg wrote:
> On Thu, 2024-06-06 at 20:07 +0200, Felix Fietkau wrote:
>> 
>> +static bool
>> +ieee80211_radio_freq_match(const struct wiphy_radio *radio,
>> +			   const struct ieee80211_chan_req *chanreq)
>> +{
>> +	const struct wiphy_radio_freq_range *r;
>> +	u32 freq;
>> +	int i;
>> +
>> +	freq = ieee80211_channel_to_khz(chanreq->oper.chan);
>> +	for (i = 0; i < radio->n_freq_range; i++) {
>> +		r = &radio->freq_range[i];
>> +		if (freq >= r->start_freq && freq <= r->end_freq)
>> +			return true;
> 
> IMHO should be inclusive only on one side of the range. Can always make
> it work since channels are at least a few MHz apart, but the purist in
> me says it's easier to grok if the end is not inclusive :)

Sure, no problem.

> Maybe this should be a cfg80211 helper like
> 
> struct wiphy_radio *wiphy_get_radio(struct wiphy *wiphy, ... *chandef);

I didn't add such a helper, in case we get hardware where multiple 
radios support the same band. That's why ieee80211_find_available_radio 
loops over all radios until it finds one that matches both the freq 
range and the ifcomb constraints.

> which could also check that the _whole_ chandef fits (though that should
> probably also be handled elsewhere, like chandef_valid), and you can use
> it to get the radio pointer and then check for == below.
> 
> The point would be to have a single place with this kind of range logic.
> This is only going to get done by mac80211 now, but it'd really be
> awkward if some other driver had some other logic later.

I will move a variation of the freq range match helper to cfg80211.

>>  	if (!curr_ctx || (curr_ctx->replace_state ==
>>  			  IEEE80211_CHANCTX_WILL_BE_REPLACED) ||
>> @@ -1096,6 +1117,12 @@ ieee80211_replace_chanctx(struct ieee80211_local *local,
>>  			if (!list_empty(&ctx->reserved_links))
>>  				continue;
>>  
>> +			if (ctx->conf.radio_idx >= 0) {
>> +					radio = &wiphy->radio[ctx->conf.radio_idx];
>> +					if (!ieee80211_radio_freq_match(radio, chanreq))
>> +							continue;
>> +			}
> 
> something happened to indentation here :)

Will fix :)

>> +static bool
>> +ieee80211_find_available_radio(struct ieee80211_local *local,
>> +			       const struct ieee80211_chan_req *chanreq,
>> +			       int *radio_idx)
>> +{
>> +	struct wiphy *wiphy = local->hw.wiphy;
>> +	const struct wiphy_radio *radio;
>> +	int i;
>> +
>> +	*radio_idx = -1;
>> +	if (!wiphy->n_radio)
>> +		return true;
>> +
>> +	for (i = 0; i < wiphy->n_radio; i++) {
>> +		radio = &wiphy->radio[i];
>> +		if (!ieee80211_radio_freq_match(radio, chanreq))
>> +			continue;
>> +
>> +		if (!ieee80211_can_create_new_chanctx(local, i))
>> +			continue;
>> +
>> +		*radio_idx = i;
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
> 
> which would also get used here to find the radio first, though would
> have to differentiate n_radio still, of course.

See above

- Felix



