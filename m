Return-Path: <linux-wireless+bounces-8597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B29F68FE040
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 09:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43492285D38
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 07:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA3113B28F;
	Thu,  6 Jun 2024 07:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="bLtW0eWN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4947D13B28A
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 07:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660548; cv=none; b=RyfOTNpf1SYAJBA7ICf5Q+ToBQExLaWTYGK9kzqVlS/b8e4/wrHadZ32sNLziNlvHOY9HI7QkuXtUmnf3zVjX6/kZXvaxFxRSrBwX7OGVX8i3SxHW3/50cco9B/zY3XMrnRDhk7YXP0bvBFJhPGsVXWe2TlIGR3N6PUPNPYpyrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660548; c=relaxed/simple;
	bh=mHUs1YJ25BjUfYmNgfZ7BjcESLbTkSLXechQiXnzgXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jx2wBmQQYFUiBYB4PL887N6ZACuNN5KCeuckRxfkJe4990gX3Jnu7Xqi4fg+L6hqMJgPHaiaBCO7cNQ57tDKENUuX5ciacXET/mY7qcQ4Bb/unssAbuEPoXbp1CzbG0TCDgUuR7gusQNYNoYAPqdmu1xK+BOJOwxndpd2GjXG48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=bLtW0eWN; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xUaduUiqNmiplI2h75LJ+VdVKcIAqjGVy539P8mndaY=; b=bLtW0eWNcFEki02OrmU6dmpH5z
	XFVjKsyl20zgkIYsdpHJ/q2G1Ej1xTPNh49MUXRy7s3NNSMR7IVYHhnE3rdNJB2/s9e4rkh4AR6UK
	NXlOmuwSvqyEPh1ABO4OTk6qMUw+OPMvbDR7FLXzmFp9IW3vsRd2LlR56YncDE/Wn6Og=;
Received: from p4ff130d0.dip0.t-ipconnect.de ([79.241.48.208] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sF7yE-008QzB-2S;
	Thu, 06 Jun 2024 09:55:38 +0200
Message-ID: <23a6d1eb-3ce9-400c-aa3d-a7d29c953079@nbd.name>
Date: Thu, 6 Jun 2024 09:55:38 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 3/7] wifi: cfg80211: extend interface combination check
 for multi-radio
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
 linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net, quic_adisi@quicinc.com,
 ath12k@lists.infradead.org
References: <cover.c104c0bb3a14f4ac26aee71f4979846f6ad87742.1717611760.git-series.nbd@nbd.name>
 <8fc2f117346fcb4ed11bb20cdf9cb1f88bcf64b4.1717611760.git-series.nbd@nbd.name>
 <8add7134-9929-0288-0770-7778013cc37c@quicinc.com>
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
In-Reply-To: <8add7134-9929-0288-0770-7778013cc37c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.06.24 09:20, Karthikeyan Periyasamy wrote:
> 
> 
> On 6/6/2024 12:01 AM, Felix Fietkau wrote:
>>   
>>   	/*
>>   	 * This is a bit strange, since the iteration used to rely only on
>> @@ -2384,8 +2383,10 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
>>   	 * cfg80211 already - the only thing not would appear to be any new
>>   	 * interfaces (while being brought up) and channel/radar data.
>>   	 */
>> -	cfg80211_calculate_bi_data(wiphy, params->new_beacon_int,
>> -				   &beacon_int_gcd, &beacon_int_different);
>> +	if (!radio)
>> +			cfg80211_calculate_bi_data(wiphy, params->new_beacon_int,
>> +						   &beacon_int_gcd,
>> +						   &beacon_int_different);
>>   
> 
> Why its avoid for radio specific iface combination ?

Because it iterates over all wdevs within cfg80211. I didn't think this 
was necessary, given that it already excludes MLO wdevs.

- Felix


