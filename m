Return-Path: <linux-wireless+bounces-7963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5948CC523
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 18:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE981F23945
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 16:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10C47D3EF;
	Wed, 22 May 2024 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="AE5I3rrZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F004762FF
	for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396616; cv=none; b=GJ5OzHT6Nj18c1e13igTnAuRejPSxZIbr10cpTjq7/rIxngbt3tXc8b5okbTLEG2Sm1omQvw/ZTC2mn+G6TG0CjNh6sx6mu4S9xdILfFwGGIhfgiQbD3/fBDkfaYERAnP4k470YHYD2CyIESpYylMiBGJ6t6mwZWN96by+CadfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396616; c=relaxed/simple;
	bh=AbVxxsYs7Zyyb+FvotT8qSB/1GTvQBjuv8nrFEG+iqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=T6tw+i6bp+AOmwBrlEpHKBmMpD6p2E+kfLQ0qUCZictch1W+Zr3Bg74FMrxUtXXAjbzBmQOxbDiVoOhH2YDUSNq2u/aX6NuUdmBJIGkNfDv2Mxgo/vnm/X5prTfJoOWFyIjFWLQMFLN+8sCCPzuO5BAtIz2Z9vSEfh74k8wzNag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=AE5I3rrZ; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A1E242C5AE0
	for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 16:44:00 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B29F4C0061;
	Wed, 22 May 2024 16:43:52 +0000 (UTC)
Received: from [10.74.46.197] (unknown [109.144.222.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 51D7213C2B0;
	Wed, 22 May 2024 09:43:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 51D7213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1716396232;
	bh=AbVxxsYs7Zyyb+FvotT8qSB/1GTvQBjuv8nrFEG+iqM=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=AE5I3rrZ0T5pxzZu/FKrEBB7wZFdCUeKmL5cXzlqyF7xZJU0Q2KU5Gz+ZSRNzT08A
	 cxRzYHBBmvc0+Fj7T5ZfNc1rFvsATAv683QKJDlrHx3aVQhkTRACJjJoTSXXHK9LXt
	 KbNQIlmQ10x4TULKifQmeLb3z3jFBYl3qCI0EkwI=
Message-ID: <e9ccc6cd-12da-0684-3993-b7f4e350c4f2@candelatech.com>
Date: Wed, 22 May 2024 09:43:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC 1/2] cfg80211: add support for advertising multiple radios
 belonging to a wiphy
Content-Language: en-MW
To: Felix Fietkau <nbd@nbd.name>
References: <20240522123005.41026-1-nbd@nbd.name>
 <4f0d56b4-3911-21fb-1460-7f7ed1301cd3@candelatech.com>
 <8c279839-34da-4a3e-a807-64050d0af6ae@nbd.name>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <8c279839-34da-4a3e-a807-64050d0af6ae@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1716396233-IdBhOcvNRx7T
X-MDID-O:
 us5;ut7;1716396233;IdBhOcvNRx7T;<greearb@candelatech.com>;340f598122f25443170ac9d27e6a82df

On 5/22/24 07:46, Felix Fietkau wrote:
> On 22.05.24 16:23, Ben Greear wrote:
>> On 5/22/24 05:30, Felix Fietkau wrote:
>>> The prerequisite for MLO support in cfg80211/mac80211 is that all the links
>>> participating in MLO must be from the same wiphy/ieee80211_hw. To meet this
>>> expectation, some drivers may need to group multiple discrete hardware each
>>> acting as a link in MLO under single wiphy.
>>> With this change, the bands and supported frequencies of each individual
>>> radio are reported to user space. This allows user space to figure out the
>>> limitations of what combination of channels can be used concurrently.
>>>
>>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>>> ---
>>>   include/net/cfg80211.h       | 34 ++++++++++++++++
>>>   include/uapi/linux/nl80211.h | 48 +++++++++++++++++++++++
>>>   net/wireless/nl80211.c       | 75 ++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 157 insertions(+)
>>>
>>> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
>>> index f2ca495ac9f8..58d8375ffa11 100644
>>> --- a/include/net/cfg80211.h
>>> +++ b/include/net/cfg80211.h
>>> @@ -5407,6 +5407,34 @@ struct wiphy_iftype_akm_suites {
>>>       int n_akm_suites;
>>>   };
>>> +/**
>>> + * struct wiphy_radio_freq_range - wiphy frequency range
>>> + * @start_freq:  start range edge frequency (kHz)
>>> + * @end_freq:    end range edge frequency (kHz)
>>> + */
>>> +struct wiphy_radio_freq_range {
>>> +    u32 start_freq;
>>> +    u32 end_freq;
>>> +};
>>> +
>>> +
>>> +/**
>>> + * struct wiphy_radio - This structure describes a physical radio belonging
>>> + * to a wiphy. It is used to describe concurrent-channel capabilities of the
>>> + * phy. Only one channel can be active on the radio described by struct
>>> + * wiphy_radio.
>>> + *
>>> + * @band_mask: Mask of enum nl80211_band describing the bands that the radio
>>> + *    can operate on.
>>> + * @num_freq_range: number of elements in @freq_range
>>> + * @freq_range: frequency range that the radio can operate on (optional)
>>> + */
>>> +struct wiphy_radio {
>>> +    u16 band_mask;
>>> +    u16 n_freq_range;
>>> +    const struct wiphy_radio_freq_range *freq_range;
>>> +};
>>
>> Do you think we might should add the radio_idx in here so that we don't
>> depend on position in the array in case we need to add/remove radios
>> for some reason?
>>
>> Or radio MAC addr or some other more persistent way to detect exactly
>> what this is in user-space?
> 
> Why would radios be added/removed at run time?

I'm thinking I might want to have radio(s) work in legacy mode sometimes and then change
to combined mode.

Another possibility is unrecoverable firmware/radio crashes, where maybe only one of them
dies and so system could remove the wedged hardware from the radio list
if it cannot recover.

If putting radios in/out of combined mode is not feasible, then I will instead
want to be able to pin legacy STA/VAP/monitor ports to specific radios.  It would
be nice if the radios could be reliably addressed from user-space without having
to query the frequency band and use that as unique identifier.  Especially if someone
manages to make something like an mtk7996 that can do more than one radio per frequency
range.

And, is the hardware discrete enough that if you had two mtk7996 3-radio NICs,
could you actually do a 6-radio OFDMA configuration with a 'fake' virtual wiphy
device to hold the underlying wiphys/radios?  If so, having better radio identifier
would be required at that point I think.

> 
>>>   #define CFG80211_HW_TIMESTAMP_ALL_PEERS    0xffff
>>>   /**
>>> @@ -5625,6 +5653,9 @@ struct wiphy_iftype_akm_suites {
>>>    *    A value of %CFG80211_HW_TIMESTAMP_ALL_PEERS indicates the driver
>>>    *    supports enabling HW timestamping for all peers (i.e. no need to
>>>    *    specify a mac address).
>>> + *
>>> + * @radio: radios belonging to this wiphy
>>> + * @n_radio: number of radios
>>>    */
>>>   struct wiphy {
>>>       struct mutex mtx;
>>> @@ -5775,6 +5806,9 @@ struct wiphy {
>>>       u16 hw_timestamp_max_peers;
>>> +    const struct wiphy_radio *radio;
>>> +    int n_radio;
>>> +
>>>       char priv[] __aligned(NETDEV_ALIGN);
>>>   };
>>> diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
>>> index f917bc6c9b6f..dfb01d673094 100644
>>> --- a/include/uapi/linux/nl80211.h
>>> +++ b/include/uapi/linux/nl80211.h
>>> @@ -3401,6 +3401,8 @@ enum nl80211_attrs {
>>>       NL80211_ATTR_ASSOC_SPP_AMSDU,
>>> +    NL80211_ATTR_RADIOS,
>>> +
>>>       /* add attributes here, update the policy in nl80211.c */
>>>       __NL80211_ATTR_AFTER_LAST,
>>> @@ -7999,4 +8001,50 @@ enum nl80211_ap_settings_flags {
>>>       NL80211_AP_SETTINGS_SA_QUERY_OFFLOAD_SUPPORT    = 1 << 1,
>>>   };
>>> +/**
>>> + * enum nl80211_wiphy_radio_attrs - wiphy radio attributes
>>> + *
>>> + * @__NL80211_WIPHY_RADIO_ATTR_INVALID: Invalid
>>> + *
>>> + * @NL80211_WIPHY_RADIO_ATTR_BAND_MASK: Bitmask of bands supported by this
>>> + *    radio.
>>> + *
>>> + * @NL80211_WIPHY_RADIO_ATTR_FREQ_RANGES: Nested array of frequency ranges
>>> + *    supported by this radio.
>>> + *
>>> + * @__NL80211_WIPHY_RADIO_ATTR_LAST: Internal
>>> + * @NL80211_WIPHY_RADIO_ATTR_MAX: Highest attribute
>>> + */
>>> +enum nl80211_wiphy_radio_attrs {
>>> +    __NL80211_WIPHY_RADIO_ATTR_INVALID,
>>> +
>>> +    NL80211_WIPHY_RADIO_ATTR_BAND_MASK,
>>> +    NL80211_WIPHY_RADIO_ATTR_FREQ_RANGES,
>>> +
>>> +    /* keep last */
>>> +    __NL80211_WIPHY_RADIO_ATTR_LAST,
>>> +    NL80211_WIPHY_RADIO_ATTR_MAX = __NL80211_WIPHY_RADIO_ATTR_LAST - 1,
>>> +};
>>> +
>>> +/**
>>> + * enum nl80211_wiphy_radio_freq_range - wiphy radio frequency range
>>> + *
>>> + * @__NL80211_WIPHY_RADIO_FREQ_ATTR_INVALID: Invalid
>>> + *
>>> + * @NL80211_WIPHY_RADIO_FREQ_ATTR_START: Frequency range start
>>> + * @NL80211_WIPHY_RADIO_FREQ_ATTR_END: Frequency range end
>>> + *
>>> + * @__NL80211_WIPHY_RADIO_FREQ_ATTR_LAST: Internal
>>> + * @NL80211_WIPHY_RADIO_FREQ_ATTR_MAX: Highest attribute
>>> + */
>>> +enum nl80211_wiphy_radio_freq_range {
>>> +    __NL80211_WIPHY_RADIO_FREQ_ATTR_INVALID,
>>> +
>>> +    NL80211_WIPHY_RADIO_FREQ_ATTR_START,
>>> +    NL80211_WIPHY_RADIO_FREQ_ATTR_END,
>>> +
>>> +    __NL80211_WIPHY_RADIO_FREQ_ATTR_LAST,
>>> +    NL80211_WIPHY_RADIO_FREQ_ATTR_MAX = __NL80211_WIPHY_RADIO_FREQ_ATTR_LAST - 1,
>>> +};
>>> +
>>>   #endif /* __LINUX_NL80211_H */
>>> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
>>> index 3c0bca4238d3..c07abdf104ec 100644
>>> --- a/net/wireless/nl80211.c
>>> +++ b/net/wireless/nl80211.c
>>> @@ -2392,6 +2392,78 @@ static int nl80211_put_mbssid_support(struct wiphy *wiphy, struct sk_buff *msg)
>>>       return -ENOBUFS;
>>>   }
>>> +static int nl80211_put_radio(struct wiphy *wiphy, struct sk_buff *msg, int idx)
>>> +{
>>> +    const struct wiphy_radio *r = &wiphy->radio[idx];
>>
>> Maybe allow radio[] array to be sparse (ie, idx 0 is there, idx 2 is there, idx 1 is NULL
>> because user wants to remove that radio from MLO consideration for whatever reason?
> 
> Why should the user want to do this?

unrecoverable radio failures and putting radio into legacy mode...

Thanks,
Ben

> 
> - Felix
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

