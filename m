Return-Path: <linux-wireless+bounces-8669-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F788FFE88
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 11:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED0E1F246FC
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 09:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DCF15B143;
	Fri,  7 Jun 2024 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="jxc/2rsA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA69917C6C
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717750807; cv=none; b=S53rkNXcUvZuWF5JxHKoHh5FzI5FGHtuvn1rx78ZFAiRDKaoi46MjKJdwuIg2zE37Zuja8VkF4OgEgkUGkIDe4ls7/BhQABhIdIPFMh99U3ttIqyg1xG3jNxHm7FCv1esVx/GpgRlkIhcEvtvAw37Z5nMQlGJ7m4atvKrH5wzyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717750807; c=relaxed/simple;
	bh=yKRXsIdfp2vvjbmEwyaLsH9TsfFbyqJZE7yoZ90zxCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e180XPoMltla+fsTVxUjkEhbseRyX5k+V+nnrPqSDLRNpiuwkGTYqGIVWoWgtNpbn6XJQiPQNYTCNwFfgEA5SrMHKhGtgFXkmkrXdTqebWjnRlD84Hq1A9LYpAi4/eRnJjf+BlVNVKfMPsQkGPFbovzaMNUiDXVhepneYRQ+XkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=jxc/2rsA; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lHpBbbSnX11+WIDfDLJzDQ8MhPhluRIKnF22jdjHUdo=; b=jxc/2rsARPOsvi9vNsGPLckWzp
	KAqgbc0MBu/QpIDPkNatMwXT5CgeoMLUCBOGFXppTFM2JLhVactWtR+U48OzzDbEPUq/889CrSY+i
	d+1+m3oo9g7I1kd4+3ZDeNFbIGazNhpiuuNrqVPnQljowgZ4FjrRlpz3yq1nxNcGegsk=;
Received: from p4ff13226.dip0.t-ipconnect.de ([79.241.50.38] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sFVS5-008qlj-2L;
	Fri, 07 Jun 2024 11:00:01 +0200
Message-ID: <dd7a8ed4-3e6c-478e-ad7c-976679f59b1d@nbd.name>
Date: Fri, 7 Jun 2024 11:00:01 +0200
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
 <21956735-3a04-4f29-8f13-0f84ed93cda2@nbd.name>
 <cdf2d06a-4d06-df69-245b-fc9ece0c1f2b@quicinc.com>
 <da6038ed-87f8-40ec-a327-6065334097af@nbd.name>
 <6704d2ba-8ac8-cd33-9d3b-95dae2613d9f@quicinc.com>
 <80aed11e-12be-472a-8664-1bd1e6dce8f3@nbd.name>
 <d2d93a48-e8f9-eb4c-7914-5886f60fad65@quicinc.com>
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
In-Reply-To: <d2d93a48-e8f9-eb4c-7914-5886f60fad65@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.06.24 10:54, Karthikeyan Periyasamy wrote:
> 
> 
> On 6/7/2024 1:46 PM, Felix Fietkau wrote:
>> On 07.06.24 08:45, Karthikeyan Periyasamy wrote:
>>>
>>>
>>> On 6/7/2024 10:33 AM, Felix Fietkau wrote:
>>>> On 07.06.24 06:54, Karthikeyan Periyasamy wrote:
>>>>>
>>>>>
>>>>> On 6/7/2024 10:05 AM, Felix Fietkau wrote:
>>>>>> On 07.06.24 06:25, Karthikeyan Periyasamy wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 6/6/2024 11:37 PM, Felix Fietkau wrote:
>>>>>>>> DFS can be supported with multi-channel combinations, as long as 
>>>>>>>> each DFS
>>>>>>>> capable radio only supports one channel.
>>>>>>>>
>>>>>>>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>>>>>>>> ---
>>>>>>>>   net/mac80211/main.c | 32 ++++++++++++++++++++++++--------
>>>>>>>>   1 file changed, 24 insertions(+), 8 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
>>>>>>>> index 40fbf397ce74..e9c4cf611e94 100644
>>>>>>>> --- a/net/mac80211/main.c
>>>>>>>> +++ b/net/mac80211/main.c
>>>>>>>
>>>>>>> ...
>>>>>>>
>>>>>>>>   int ieee80211_register_hw(struct ieee80211_hw *hw)
>>>>>>>>   {
>>>>>>>>       struct ieee80211_local *local = hw_to_local(hw);
>>>>>>>> @@ -1173,17 +1188,18 @@ int ieee80211_register_hw(struct 
>>>>>>>> ieee80211_hw *hw)
>>>>>>>>               if (comb->num_different_channels > 1)
>>>>>>>>                   return -EINVAL;
>>>>>>>>           }
>>>>>>>> -    } else {
>>>>>>>> -        /* DFS is not supported with multi-channel combinations 
>>>>>>>> yet */
>>>>>>>> -        for (i = 0; i < local->hw.wiphy->n_iface_combinations; 
>>>>>>>> i++) {
>>>>>>>> -            const struct ieee80211_iface_combination *comb;
>>>>>>>> -
>>>>>>>> -            comb = &local->hw.wiphy->iface_combinations[i];
>>>>>>>> +    } else if (hw->wiphy->n_radio) {
>>>>>>>> +        for (i = 0; i < hw->wiphy->n_radio; i++) {
>>>>>>>> +            const struct wiphy_radio *radio = &hw->wiphy->radio[i];
>>>>>>>> -            if (comb->radar_detect_widths &&
>>>>>>>> -                comb->num_different_channels > 1)
>>>>>>>> +            if 
>>>>>>>> (!ieee80211_ifcomb_check_radar(radio->iface_combinations,
>>>>>>>> +                              radio->n_iface_combinations))
>>>>>>>>                   return -EINVAL;
>>>>>>>>           }
>>>>>>>> +    } else {
>>>>>>>> +        if 
>>>>>>>> (!ieee80211_ifcomb_check_radar(hw->wiphy->iface_combinations,
>>>>>>>> +                          hw->wiphy->n_iface_combinations))
>>>>>>>> +            return -EINVAL;
>>>>>>>>       }
>>>>>>>>       /* Only HW csum features are currently compatible with 
>>>>>>>> mac80211 */
>>>>>>>
>>>>>>> Are we omitting the "wiphy->iface_combinations" if the radio specific
>>>>>>> iface combination advertised ?
>>>>>>>
>>>>>>> If so, it looks like unused "wiphy->iface_combinations" for radio
>>>>>>> specific combination advertised.
>>>>>>
>>>>>> This patch series assumes that you have both 
>>>>>> wiphy->iface_combinations and radio->iface_combinations set. 
>>>>>> wiphy->iface_combinations applies to the full wiphy, whereas 
>>>>>> radio->iface_combinations only applies to vifs assigned to the radio.
>>>>>
>>>>>
>>>>> If radio->iface_combinations is set then always vifs assigned to the
>>>>> radio. so wiphy->iface_combinations get avoid for all the use cases.
>>>>>
>>>>> Ultimately either of one combination only get used by this proposal.
>>>>>
>>>>> or I am missing something here ?
>>>>
>>>> The functions that perform interface combination checks are called 
>>>> both with -1 as radio_idx (meaning per-wiphy), as well as with the 
>>>> assigned radio id. That way, both kinds of combinations/limits are 
>>>> checked and enforced.
>>>>
>>> In the radio specific iface advertisement, global iface combination
>>> represent the union or intersection of all radio iface combination ?
>> 
>> The global interface combination should be a union of all radio 
>> interface combinations.
>> You can also use them to apply extra limits, e.g. if you have a limit on 
>> the per-wiphy number of interfaces (regardless of the assigned radio), 
>> you use the global interface combination to apply it.
>> 
> If the global combination follow union representation, the non-ML client
> takes wrong/invalid perception against the global advertisement.
> 
> Ex:
> 
> Global iface = 14 ( Radio iface: 2G = 4, 5G = 4, 6G = 6 ).
> 
> 2G non-client read the global configuration and understand it can able
> to create 14 interfaces. But in reality it allowed to create max 4
> interface only.
> 
> we have to follow intersection or minimal set, no ?

Maybe I misunderstood your question earlier. I meant that the driver can 
set the global limit as a sort of union of all per-radio limits.
For each individual radio, the intersection of the global limit (taking 
into account other radios as well) and the per-radio limit (considering 
only per-radio vifs) applies.

- Felix

