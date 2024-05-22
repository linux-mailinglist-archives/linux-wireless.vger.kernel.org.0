Return-Path: <linux-wireless+bounces-7959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C428CC378
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 16:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8624B20C66
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 14:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E4C7489;
	Wed, 22 May 2024 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="ro1BedV2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE286AD7
	for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389177; cv=none; b=sd13uskpLluwlUsVe8dFkoKUkIUTsW7CmVCboDqUEs/4qdDKyxJ63lOKPfKpps4bRdYuAt7qUkKo2oa+kBVdHTCQb4+1rtGrfK/1nPnyWCJFQiDtpOPZ1EIvkWrqCwZVtYbrQN/iXNDc1wrC/B4OZ9PajTU11qjpnGocPwy2ooE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389177; c=relaxed/simple;
	bh=f85SUoCWHlM1KNi3RKOIvVtFifmL0bDyST3koHENUIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YX/oj6ve1o+toeym1zpEF0eRIXRfMC28HtB1W0BPkjHvu7MPsoGe9+7t0CIC6nyR9VJ9Pg2b/oDZJyb0WAN6xiWCH9mQGstuIbC1XgqzhdxmxTsSXcYlLNWWyLf1rRuf9pSMOPtM5FwS3zvIM0v+UkPpZr8a2p0mZpvJIuoqhVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=ro1BedV2; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BhsvpP0eFwT3IK9fQEu8frMoKdfKKpRCgz7yWGrh/us=; b=ro1BedV29ayGtprCpmQ1xW94iF
	7Zh7eQrlXR9QeCDShSENyghf4sVsK6iiNEyLTWkZffyiimFEcDYgl5vf/QML6nZdXRv2aLcjQr3NM
	RzVR40zhiS3keb3fQ9Cjs5kE7IFugc67AUXHXl4CRXqq7IJypPVCbmZLWrqSQ4HTNMhw=;
Received: from p4ff13644.dip0.t-ipconnect.de ([79.241.54.68] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s9nEK-003aRb-05;
	Wed, 22 May 2024 16:46:12 +0200
Message-ID: <8c279839-34da-4a3e-a807-64050d0af6ae@nbd.name>
Date: Wed, 22 May 2024 16:46:11 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] cfg80211: add support for advertising multiple radios
 belonging to a wiphy
To: Ben Greear <greearb@candelatech.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20240522123005.41026-1-nbd@nbd.name>
 <4f0d56b4-3911-21fb-1460-7f7ed1301cd3@candelatech.com>
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
In-Reply-To: <4f0d56b4-3911-21fb-1460-7f7ed1301cd3@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.05.24 16:23, Ben Greear wrote:
> On 5/22/24 05:30, Felix Fietkau wrote:
>> The prerequisite for MLO support in cfg80211/mac80211 is that all the links
>> participating in MLO must be from the same wiphy/ieee80211_hw. To meet this
>> expectation, some drivers may need to group multiple discrete hardware each
>> acting as a link in MLO under single wiphy.
>> With this change, the bands and supported frequencies of each individual
>> radio are reported to user space. This allows user space to figure out the
>> limitations of what combination of channels can be used concurrently.
>> 
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>   include/net/cfg80211.h       | 34 ++++++++++++++++
>>   include/uapi/linux/nl80211.h | 48 +++++++++++++++++++++++
>>   net/wireless/nl80211.c       | 75 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 157 insertions(+)
>> 
>> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
>> index f2ca495ac9f8..58d8375ffa11 100644
>> --- a/include/net/cfg80211.h
>> +++ b/include/net/cfg80211.h
>> @@ -5407,6 +5407,34 @@ struct wiphy_iftype_akm_suites {
>>   	int n_akm_suites;
>>   };
>>   
>> +/**
>> + * struct wiphy_radio_freq_range - wiphy frequency range
>> + * @start_freq:  start range edge frequency (kHz)
>> + * @end_freq:    end range edge frequency (kHz)
>> + */
>> +struct wiphy_radio_freq_range {
>> +	u32 start_freq;
>> +	u32 end_freq;
>> +};
>> +
>> +
>> +/**
>> + * struct wiphy_radio - This structure describes a physical radio belonging
>> + * to a wiphy. It is used to describe concurrent-channel capabilities of the
>> + * phy. Only one channel can be active on the radio described by struct
>> + * wiphy_radio.
>> + *
>> + * @band_mask: Mask of enum nl80211_band describing the bands that the radio
>> + *	can operate on.
>> + * @num_freq_range: number of elements in @freq_range
>> + * @freq_range: frequency range that the radio can operate on (optional)
>> + */
>> +struct wiphy_radio {
>> +	u16 band_mask;
>> +	u16 n_freq_range;
>> +	const struct wiphy_radio_freq_range *freq_range;
>> +};
> 
> Do you think we might should add the radio_idx in here so that we don't
> depend on position in the array in case we need to add/remove radios
> for some reason?
> 
> Or radio MAC addr or some other more persistent way to detect exactly
> what this is in user-space?

Why would radios be added/removed at run time?

>>   #define CFG80211_HW_TIMESTAMP_ALL_PEERS	0xffff
>>   
>>   /**
>> @@ -5625,6 +5653,9 @@ struct wiphy_iftype_akm_suites {
>>    *	A value of %CFG80211_HW_TIMESTAMP_ALL_PEERS indicates the driver
>>    *	supports enabling HW timestamping for all peers (i.e. no need to
>>    *	specify a mac address).
>> + *
>> + * @radio: radios belonging to this wiphy
>> + * @n_radio: number of radios
>>    */
>>   struct wiphy {
>>   	struct mutex mtx;
>> @@ -5775,6 +5806,9 @@ struct wiphy {
>>   
>>   	u16 hw_timestamp_max_peers;
>>   
>> +	const struct wiphy_radio *radio;
>> +	int n_radio;
>> +
>>   	char priv[] __aligned(NETDEV_ALIGN);
>>   };
>>   
>> diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
>> index f917bc6c9b6f..dfb01d673094 100644
>> --- a/include/uapi/linux/nl80211.h
>> +++ b/include/uapi/linux/nl80211.h
>> @@ -3401,6 +3401,8 @@ enum nl80211_attrs {
>>   
>>   	NL80211_ATTR_ASSOC_SPP_AMSDU,
>>   
>> +	NL80211_ATTR_RADIOS,
>> +
>>   	/* add attributes here, update the policy in nl80211.c */
>>   
>>   	__NL80211_ATTR_AFTER_LAST,
>> @@ -7999,4 +8001,50 @@ enum nl80211_ap_settings_flags {
>>   	NL80211_AP_SETTINGS_SA_QUERY_OFFLOAD_SUPPORT	= 1 << 1,
>>   };
>>   
>> +/**
>> + * enum nl80211_wiphy_radio_attrs - wiphy radio attributes
>> + *
>> + * @__NL80211_WIPHY_RADIO_ATTR_INVALID: Invalid
>> + *
>> + * @NL80211_WIPHY_RADIO_ATTR_BAND_MASK: Bitmask of bands supported by this
>> + *	radio.
>> + *
>> + * @NL80211_WIPHY_RADIO_ATTR_FREQ_RANGES: Nested array of frequency ranges
>> + *	supported by this radio.
>> + *
>> + * @__NL80211_WIPHY_RADIO_ATTR_LAST: Internal
>> + * @NL80211_WIPHY_RADIO_ATTR_MAX: Highest attribute
>> + */
>> +enum nl80211_wiphy_radio_attrs {
>> +	__NL80211_WIPHY_RADIO_ATTR_INVALID,
>> +
>> +	NL80211_WIPHY_RADIO_ATTR_BAND_MASK,
>> +	NL80211_WIPHY_RADIO_ATTR_FREQ_RANGES,
>> +
>> +	/* keep last */
>> +	__NL80211_WIPHY_RADIO_ATTR_LAST,
>> +	NL80211_WIPHY_RADIO_ATTR_MAX = __NL80211_WIPHY_RADIO_ATTR_LAST - 1,
>> +};
>> +
>> +/**
>> + * enum nl80211_wiphy_radio_freq_range - wiphy radio frequency range
>> + *
>> + * @__NL80211_WIPHY_RADIO_FREQ_ATTR_INVALID: Invalid
>> + *
>> + * @NL80211_WIPHY_RADIO_FREQ_ATTR_START: Frequency range start
>> + * @NL80211_WIPHY_RADIO_FREQ_ATTR_END: Frequency range end
>> + *
>> + * @__NL80211_WIPHY_RADIO_FREQ_ATTR_LAST: Internal
>> + * @NL80211_WIPHY_RADIO_FREQ_ATTR_MAX: Highest attribute
>> + */
>> +enum nl80211_wiphy_radio_freq_range {
>> +	__NL80211_WIPHY_RADIO_FREQ_ATTR_INVALID,
>> +
>> +	NL80211_WIPHY_RADIO_FREQ_ATTR_START,
>> +	NL80211_WIPHY_RADIO_FREQ_ATTR_END,
>> +
>> +	__NL80211_WIPHY_RADIO_FREQ_ATTR_LAST,
>> +	NL80211_WIPHY_RADIO_FREQ_ATTR_MAX = __NL80211_WIPHY_RADIO_FREQ_ATTR_LAST - 1,
>> +};
>> +
>>   #endif /* __LINUX_NL80211_H */
>> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
>> index 3c0bca4238d3..c07abdf104ec 100644
>> --- a/net/wireless/nl80211.c
>> +++ b/net/wireless/nl80211.c
>> @@ -2392,6 +2392,78 @@ static int nl80211_put_mbssid_support(struct wiphy *wiphy, struct sk_buff *msg)
>>   	return -ENOBUFS;
>>   }
>>   
>> +static int nl80211_put_radio(struct wiphy *wiphy, struct sk_buff *msg, int idx)
>> +{
>> +	const struct wiphy_radio *r = &wiphy->radio[idx];
> 
> Maybe allow radio[] array to be sparse (ie, idx 0 is there, idx 2 is there, idx 1 is NULL
> because user wants to remove that radio from MLO consideration for whatever reason?

Why should the user want to do this?

- Felix


