Return-Path: <linux-wireless+bounces-8658-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3578FFB07
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 06:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC35A1F268A3
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 04:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959F11B59A;
	Fri,  7 Jun 2024 04:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="EW2tfOqw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E8338F96
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 04:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717735780; cv=none; b=aQo4vNFe8cft38dGD3EjN9spMc1uF/95IyE3TmDdJLjXDwA+3AaNQB14LCZUNRIk8OAQ5a0lM9IfkNz3wHnWvTCYdD52ktSqUe/3XBbfY0zbpb1SM3S6+snBOKdX9IIhAdTb7M59EMjREg6MhMWW2885PNb/CFD53ENJ3YX5UEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717735780; c=relaxed/simple;
	bh=sXmpSin4xcz5U9ACd2ZqKeulnpSQC1g4svY7/I36A08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUJJaSQWgeUqqbBGACrJYe3mq7t3ARGJNMwKH3NXhZh3xh3AsrCpzSEIIRzKKrlyvIC4byysnI4zTSJkbQR+b/4nFvtZmu7kQTfvY5yOKR4FQNhuCiAJ3ma/jFG3+NsEpH8IXBgozHcdhTpjc84gWgE3HwzwHKireBOi5U+M2Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=EW2tfOqw; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EccwJHAinwc9IMjUb7fiTtEJxEtENX38H43DKLAFQkc=; b=EW2tfOqwV8QCWppc2SazdrLbZN
	qNMvidONddX4wfTovCMsysKsQUMNX7pxxn96y9EFa+wwn1TY4N4sWI7rdVVrgO2YetSm6m+jOfP+8
	AfO/zOp6PfE5Umou5xEkgP07SAatMlw4v4a1F0GyLPZ0Jp2z1KBOvmO97Uy6whhDpBEA=;
Received: from p4ff13226.dip0.t-ipconnect.de ([79.241.50.38] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sFRXj-008n8Q-2E;
	Fri, 07 Jun 2024 06:49:35 +0200
Message-ID: <900697d8-9db7-49a5-9949-1e256e96b0c2@nbd.name>
Date: Fri, 7 Jun 2024 06:49:35 +0200
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
 <cc9a3955-fd59-ff9b-c96b-560e620b916d@quicinc.com>
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
In-Reply-To: <cc9a3955-fd59-ff9b-c96b-560e620b916d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.06.24 06:45, Karthikeyan Periyasamy wrote:
> 
> 
> On 6/6/2024 11:37 PM, Felix Fietkau wrote:
>> Add support for counting global and per-radio max/current number of
>> channels, as well as checking radio-specific interface combinations.
>> 
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>   net/mac80211/cfg.c         |   7 +-
>>   net/mac80211/chan.c        |  17 +++--
>>   net/mac80211/ibss.c        |   2 +-
>>   net/mac80211/ieee80211_i.h |   6 +-
>>   net/mac80211/iface.c       |   2 +-
>>   net/mac80211/util.c        | 131 +++++++++++++++++++++++++++-----------
>>   6 files changed, 116 insertions(+), 49 deletions(-)
>> 
> 
> ...
> 
>>   
>> +static u32
>> +__ieee80211_get_radio_mask(struct ieee80211_sub_if_data *sdata)
>> +{
>> +	struct ieee80211_local *local = sdata->local;
>> +	struct ieee80211_chanctx_conf *conf;
>> +	struct ieee80211_link_data *link;
>> +	u32 mask = 0;
>> +
>> +	for_each_sdata_link(local, link) {
>> +		conf = rcu_dereference(link->conf->chanctx_conf);
>> +		if (!conf || conf->radio_idx < 0)
>> +			continue;
>> +
>> +		mask |= BIT(conf->radio_idx);
>> +	}
>> +
>> +	return mask;
>> +}
>> +
> 
> I believe __ieee80211_get_radio_mask(sdata) should return the radio mask
> used by this sdata right ?
> 
> if so, then you should not use "for_each_sdata_link(local, link)"
> because it iterate for all the sdata in the given local and give the
> radio mask. So always return all the radio (bitmap mask) used by the
> wiphy currently.
> 
> You can use either of below one
> 
> for_each_vif_active_link()
> 
>    or
> 
> for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++)

Right, I copied the wrong code :)
Will fix, thanks.

- Felix

