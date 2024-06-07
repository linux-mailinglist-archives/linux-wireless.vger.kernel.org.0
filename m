Return-Path: <linux-wireless+bounces-8656-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2A38FFB04
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 06:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 014EBB28A56
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 04:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195561C2AF;
	Fri,  7 Jun 2024 04:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="qe2rM1U0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF88218EA1
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 04:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734963; cv=none; b=uxbLm7B82YAitN/ltfyvQNnfC86oVUNhw+JETSxiMEUt1np+U4nZ/0mDk+s4PNUQMXV4PzgMpGneBdEje+zqaZgYsnwbgXeUr1dVNtaTF2Cv6If/DM551WcBl3jk9ilCsL2V3qdnvu5GB5iOFa4GJzS1UNhE4TM3W7PZwOM3iLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734963; c=relaxed/simple;
	bh=3J+sEFzXG5Howp/VtIK091uHLFBpgm3vDT5qWDyk9iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6s5dKhots/Vd9OM+zB609RfcaB965+6/AHh2nyPyIuaMGX4/pvkKBH3k1O8iIuYX9gAI7xxTjmJQi3RXzM0L2eEI4y0Zd8snswLyzOOwzLVFO1nhikBRnA1KiZBx9fj/SfUUHdLGRUVoitg441Ux3wZzgeitn+mqR824Y7oksE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=qe2rM1U0; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=naU5WeYsROXjbtH0p646BSs21ltEq8OndR4T8Kgvluc=; b=qe2rM1U0yNZA+UdZwHEGC8Xyzg
	YP4osmpDv4H3XwnQgDoil6mJ81kV4St2iZv+m+OmT4Spq2WfYaJWFjnc43QEZdMPBz9FACkOc+YeC
	W3jzd0AWIAPjoEP3iJMepTV39zAudQj7I92NumNCyjtCwDJBs0pTGXtil/pvFaRfwe3c=;
Received: from p4ff13226.dip0.t-ipconnect.de ([79.241.50.38] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sFRKQ-008muC-20;
	Fri, 07 Jun 2024 06:35:50 +0200
Message-ID: <21956735-3a04-4f29-8f13-0f84ed93cda2@nbd.name>
Date: Fri, 7 Jun 2024 06:35:50 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 4/8] wifi: mac80211: add support for DFS with multiple
 radios
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
 linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net, quic_adisi@quicinc.com,
 ath12k@lists.infradead.org
References: <cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
 <7cc3d89225f365c85b363874725cfbc77c9c1db5.1717696995.git-series.nbd@nbd.name>
 <2014e488-b930-43ff-86a6-c5a4801b82f5@quicinc.com>
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
In-Reply-To: <2014e488-b930-43ff-86a6-c5a4801b82f5@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.06.24 06:25, Karthikeyan Periyasamy wrote:
> 
> 
> On 6/6/2024 11:37 PM, Felix Fietkau wrote:
>> DFS can be supported with multi-channel combinations, as long as each DFS
>> capable radio only supports one channel.
>> 
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>   net/mac80211/main.c | 32 ++++++++++++++++++++++++--------
>>   1 file changed, 24 insertions(+), 8 deletions(-)
>> 
>> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
>> index 40fbf397ce74..e9c4cf611e94 100644
>> --- a/net/mac80211/main.c
>> +++ b/net/mac80211/main.c
> 
> ...
> 
>>   int ieee80211_register_hw(struct ieee80211_hw *hw)
>>   {
>>   	struct ieee80211_local *local = hw_to_local(hw);
>> @@ -1173,17 +1188,18 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
>>   			if (comb->num_different_channels > 1)
>>   				return -EINVAL;
>>   		}
>> -	} else {
>> -		/* DFS is not supported with multi-channel combinations yet */
>> -		for (i = 0; i < local->hw.wiphy->n_iface_combinations; i++) {
>> -			const struct ieee80211_iface_combination *comb;
>> -
>> -			comb = &local->hw.wiphy->iface_combinations[i];
>> +	} else if (hw->wiphy->n_radio) {
>> +		for (i = 0; i < hw->wiphy->n_radio; i++) {
>> +			const struct wiphy_radio *radio = &hw->wiphy->radio[i];
>>   
>> -			if (comb->radar_detect_widths &&
>> -			    comb->num_different_channels > 1)
>> +			if (!ieee80211_ifcomb_check_radar(radio->iface_combinations,
>> +							  radio->n_iface_combinations))
>>   				return -EINVAL;
>>   		}
>> +	} else {
>> +		if (!ieee80211_ifcomb_check_radar(hw->wiphy->iface_combinations,
>> +						  hw->wiphy->n_iface_combinations))
>> +			return -EINVAL;
>>   	}
>>   
>>   	/* Only HW csum features are currently compatible with mac80211 */
> 
> Are we omitting the "wiphy->iface_combinations" if the radio specific
> iface combination advertised ?
> 
> If so, it looks like unused "wiphy->iface_combinations" for radio
> specific combination advertised.

This patch series assumes that you have both wiphy->iface_combinations 
and radio->iface_combinations set. wiphy->iface_combinations applies to 
the full wiphy, whereas radio->iface_combinations only applies to vifs 
assigned to the radio.

- Felix

