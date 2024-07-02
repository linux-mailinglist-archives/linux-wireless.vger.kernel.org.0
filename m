Return-Path: <linux-wireless+bounces-9822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E409D923C08
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 13:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7093E1F218BE
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 11:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C67B156F5D;
	Tue,  2 Jul 2024 11:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="WgAZ5E4p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB49158D60
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 11:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918472; cv=none; b=mdK2musSwfcya8UXqdkIbiD6Ewmp2eUC3FlWsJENSI1wDFFxdop5udeOSbhN5Jw8blR0nwOvn+tSAv/yZL9zIrhGJS1sSjQDKQmmBvZY4l04UoIKxrH/8cMoNm9ynv0mT5Ep96PIvH8yuKrz4FZ3a18rlsaN7N7wqS+WxMJ/1qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918472; c=relaxed/simple;
	bh=G+Pp74kSL4cOxr9CtfYYp/+SbmMpDxckxoaZI9Lrw1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QN1p0UFGfgOUSzBRGSeXAskzgFSD4iRpY3VKd9cD0o71nJdRvj+E0zVEhaM8pEkmaJWm/YGzsexQzYb2IxI8N0JZyj7qOSHLJPQwJDkcYP3tSH+NrqAwfJHwOWOiLTLGKvc9ldENZ13MTS0D+96srwjzsahmLw73YE5GsRVnkis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=WgAZ5E4p; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DPUwk9Bg7NOVcMjpKZiBrNcQqZRu3Q+f17SRCYvy4Hg=; b=WgAZ5E4pb2qeFoMJwG+hj3zA+x
	6HSxi23BxTpnDkp++Y6FnSbWuG+kx5Bqq5+UfuyWqQ+dX/swc/2JYLf1BMgzfeBz4rAkN6C9fWBI5
	Mr7MOuTZLQ3mGiounH4jomoqx9CRrOVMk4m4s1l0/0XPWwEqDWVLDbFAm/Zqn1wHcuyE=;
Received: from p54ae9766.dip0.t-ipconnect.de ([84.174.151.102] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sObMQ-001kfi-2w;
	Tue, 02 Jul 2024 13:07:46 +0200
Message-ID: <a57d5571-f252-49b7-b182-75df6dd2d96a@nbd.name>
Date: Tue, 2 Jul 2024 13:07:46 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] wifi: mac80211: add support for DFS with
 multiple radios
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
 linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net, quic_adisi@quicinc.com,
 ath12k@lists.infradead.org
References: <cover.a50ea6fd728e14cfdaafeb9cfac003364713c8e7.1719843147.git-series.nbd@nbd.name>
 <61899e29de4e0f5437643d578999d2a3d4d7d7b2.1719843147.git-series.nbd@nbd.name>
 <bbb93003-807b-b6af-2096-20837de902f0@quicinc.com>
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
In-Reply-To: <bbb93003-807b-b6af-2096-20837de902f0@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.07.24 12:58, Karthikeyan Periyasamy wrote:
> 
> 
> On 7/1/2024 7:43 PM, Felix Fietkau wrote:
>> DFS can be supported with multi-channel combinations, as long as each DFS
>> capable radio only supports one channel.
>> 
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>   net/mac80211/main.c | 32 ++++++++++++++++++++++++--------
>>   1 file changed, 24 insertions(+), 8 deletions(-)
>> 
>> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
>> index 7578ea56c12f..58bebfdaa062 100644
>> --- a/net/mac80211/main.c
>> +++ b/net/mac80211/main.c
>> @@ -1091,6 +1091,21 @@ static int ieee80211_init_cipher_suites(struct ieee80211_local *local)
>>   	return 0;
>>   }
>>   
>> +static bool
>> +ieee80211_ifcomb_check_radar(const struct ieee80211_iface_combination *comb,
>> +			     int n_comb)
>> +{
>> +	int i;
>> +
>> +	/* DFS is not supported with multi-channel combinations yet */
>> +	for (i = 0; i < n_comb; i++, comb++)
>> +		if (comb->radar_detect_widths &&
>> +		    comb->num_different_channels > 1)
>> +			return false;
>> +
>> +	return true;
>> +}
>> +
>>   int ieee80211_register_hw(struct ieee80211_hw *hw)
>>   {
>>   	struct ieee80211_local *local = hw_to_local(hw);
>> @@ -1177,17 +1192,18 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
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
> In ieee80211_register_hw(), mac80211 check the global iface combination
> against the IBSS interface max.
> 
> This check may fail for the radio specific iface combination
> advertisement since global iface combination is sum of all radio
> capabilities, no ?

You're right, will fix.

Thanks,

- Felix

