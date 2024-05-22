Return-Path: <linux-wireless+bounces-7958-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8A48CC370
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 16:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51DDF1C21592
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 14:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAA51864C;
	Wed, 22 May 2024 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Of9E3IVH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AAE249FE
	for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389017; cv=none; b=kne2yKAgCqdho+4P+V60NQ4EvO6HhiAHcKtIZDPBk0SCTLwE1qKeOjHPy3qoN672kzBjh+a1DzYOm7O/xsL+K8D+5d8Hw9swMLZ7nj4lpixrzZWwTfhNfz3CaOeWCYcinMLwzY77+5sXYQ8JF8RdAOe0SgqybbZ3caoMXIlsCso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389017; c=relaxed/simple;
	bh=e/TH510ismbkrsAW+6E5C+9X/qcgyVTkvTLM8eC+G0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=FN8cSpQnnUq/yrtp9ehfViQ+BG9OXWdH+7e+hY1w+VULJKH2LDYCq/yBaAoZFxw6hKVSmaMZg9DCPu3iXy8ww+wyaqxRqQ3yb9sYHenp20wD0Or5UWj8+vKxnPObgnAS8xZwyOHTzWIianBpBHTgSoAiRGD2mNVdhs5lUT40dBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=Of9E3IVH; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C9F0050283D
	for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 14:24:00 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2B0C0300067;
	Wed, 22 May 2024 14:23:52 +0000 (UTC)
Received: from [10.74.46.53] (unknown [109.144.221.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id E460013C2B0;
	Wed, 22 May 2024 07:23:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E460013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1716387832;
	bh=e/TH510ismbkrsAW+6E5C+9X/qcgyVTkvTLM8eC+G0s=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=Of9E3IVHEf0AagPz7PnScaQpwgsYEggyHOtru949Kiw2IbOxnDCSARb/RUrjkkRqv
	 vNovunhyrty04QubEtGNtOXPDRfX24KQLXNfXSDekH4pgxrblY76tael6/0imbNKgO
	 0bLtBC/Vk+qqFyCnL/D5S0Bm+pDkl58oGRTVJTao=
Message-ID: <4f0d56b4-3911-21fb-1460-7f7ed1301cd3@candelatech.com>
Date: Wed, 22 May 2024 07:23:50 -0700
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
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20240522123005.41026-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1716387834-bhtku76mOUKM
X-MDID-O:
 us5;at1;1716387834;bhtku76mOUKM;<greearb@candelatech.com>;340f598122f25443170ac9d27e6a82df

On 5/22/24 05:30, Felix Fietkau wrote:
> The prerequisite for MLO support in cfg80211/mac80211 is that all the links
> participating in MLO must be from the same wiphy/ieee80211_hw. To meet this
> expectation, some drivers may need to group multiple discrete hardware each
> acting as a link in MLO under single wiphy.
> With this change, the bands and supported frequencies of each individual
> radio are reported to user space. This allows user space to figure out the
> limitations of what combination of channels can be used concurrently.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>   include/net/cfg80211.h       | 34 ++++++++++++++++
>   include/uapi/linux/nl80211.h | 48 +++++++++++++++++++++++
>   net/wireless/nl80211.c       | 75 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 157 insertions(+)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index f2ca495ac9f8..58d8375ffa11 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -5407,6 +5407,34 @@ struct wiphy_iftype_akm_suites {
>   	int n_akm_suites;
>   };
>   
> +/**
> + * struct wiphy_radio_freq_range - wiphy frequency range
> + * @start_freq:  start range edge frequency (kHz)
> + * @end_freq:    end range edge frequency (kHz)
> + */
> +struct wiphy_radio_freq_range {
> +	u32 start_freq;
> +	u32 end_freq;
> +};
> +
> +
> +/**
> + * struct wiphy_radio - This structure describes a physical radio belonging
> + * to a wiphy. It is used to describe concurrent-channel capabilities of the
> + * phy. Only one channel can be active on the radio described by struct
> + * wiphy_radio.
> + *
> + * @band_mask: Mask of enum nl80211_band describing the bands that the radio
> + *	can operate on.
> + * @num_freq_range: number of elements in @freq_range
> + * @freq_range: frequency range that the radio can operate on (optional)
> + */
> +struct wiphy_radio {
> +	u16 band_mask;
> +	u16 n_freq_range;
> +	const struct wiphy_radio_freq_range *freq_range;
> +};

Do you think we might should add the radio_idx in here so that we don't
depend on position in the array in case we need to add/remove radios
for some reason?

Or radio MAC addr or some other more persistent way to detect exactly
what this is in user-space?


> +
>   #define CFG80211_HW_TIMESTAMP_ALL_PEERS	0xffff
>   
>   /**
> @@ -5625,6 +5653,9 @@ struct wiphy_iftype_akm_suites {
>    *	A value of %CFG80211_HW_TIMESTAMP_ALL_PEERS indicates the driver
>    *	supports enabling HW timestamping for all peers (i.e. no need to
>    *	specify a mac address).
> + *
> + * @radio: radios belonging to this wiphy
> + * @n_radio: number of radios
>    */
>   struct wiphy {
>   	struct mutex mtx;
> @@ -5775,6 +5806,9 @@ struct wiphy {
>   
>   	u16 hw_timestamp_max_peers;
>   
> +	const struct wiphy_radio *radio;
> +	int n_radio;
> +
>   	char priv[] __aligned(NETDEV_ALIGN);
>   };
>   
> diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
> index f917bc6c9b6f..dfb01d673094 100644
> --- a/include/uapi/linux/nl80211.h
> +++ b/include/uapi/linux/nl80211.h
> @@ -3401,6 +3401,8 @@ enum nl80211_attrs {
>   
>   	NL80211_ATTR_ASSOC_SPP_AMSDU,
>   
> +	NL80211_ATTR_RADIOS,
> +
>   	/* add attributes here, update the policy in nl80211.c */
>   
>   	__NL80211_ATTR_AFTER_LAST,
> @@ -7999,4 +8001,50 @@ enum nl80211_ap_settings_flags {
>   	NL80211_AP_SETTINGS_SA_QUERY_OFFLOAD_SUPPORT	= 1 << 1,
>   };
>   
> +/**
> + * enum nl80211_wiphy_radio_attrs - wiphy radio attributes
> + *
> + * @__NL80211_WIPHY_RADIO_ATTR_INVALID: Invalid
> + *
> + * @NL80211_WIPHY_RADIO_ATTR_BAND_MASK: Bitmask of bands supported by this
> + *	radio.
> + *
> + * @NL80211_WIPHY_RADIO_ATTR_FREQ_RANGES: Nested array of frequency ranges
> + *	supported by this radio.
> + *
> + * @__NL80211_WIPHY_RADIO_ATTR_LAST: Internal
> + * @NL80211_WIPHY_RADIO_ATTR_MAX: Highest attribute
> + */
> +enum nl80211_wiphy_radio_attrs {
> +	__NL80211_WIPHY_RADIO_ATTR_INVALID,
> +
> +	NL80211_WIPHY_RADIO_ATTR_BAND_MASK,
> +	NL80211_WIPHY_RADIO_ATTR_FREQ_RANGES,
> +
> +	/* keep last */
> +	__NL80211_WIPHY_RADIO_ATTR_LAST,
> +	NL80211_WIPHY_RADIO_ATTR_MAX = __NL80211_WIPHY_RADIO_ATTR_LAST - 1,
> +};
> +
> +/**
> + * enum nl80211_wiphy_radio_freq_range - wiphy radio frequency range
> + *
> + * @__NL80211_WIPHY_RADIO_FREQ_ATTR_INVALID: Invalid
> + *
> + * @NL80211_WIPHY_RADIO_FREQ_ATTR_START: Frequency range start
> + * @NL80211_WIPHY_RADIO_FREQ_ATTR_END: Frequency range end
> + *
> + * @__NL80211_WIPHY_RADIO_FREQ_ATTR_LAST: Internal
> + * @NL80211_WIPHY_RADIO_FREQ_ATTR_MAX: Highest attribute
> + */
> +enum nl80211_wiphy_radio_freq_range {
> +	__NL80211_WIPHY_RADIO_FREQ_ATTR_INVALID,
> +
> +	NL80211_WIPHY_RADIO_FREQ_ATTR_START,
> +	NL80211_WIPHY_RADIO_FREQ_ATTR_END,
> +
> +	__NL80211_WIPHY_RADIO_FREQ_ATTR_LAST,
> +	NL80211_WIPHY_RADIO_FREQ_ATTR_MAX = __NL80211_WIPHY_RADIO_FREQ_ATTR_LAST - 1,
> +};
> +
>   #endif /* __LINUX_NL80211_H */
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 3c0bca4238d3..c07abdf104ec 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -2392,6 +2392,78 @@ static int nl80211_put_mbssid_support(struct wiphy *wiphy, struct sk_buff *msg)
>   	return -ENOBUFS;
>   }
>   
> +static int nl80211_put_radio(struct wiphy *wiphy, struct sk_buff *msg, int idx)
> +{
> +	const struct wiphy_radio *r = &wiphy->radio[idx];

Maybe allow radio[] array to be sparse (ie, idx 0 is there, idx 2 is there, idx 1 is NULL
because user wants to remove that radio from MLO consideration for whatever reason?

For what it's worth, I like the general approach.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

