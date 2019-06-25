Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF0B5294B
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 12:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbfFYKVx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 06:21:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59698 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfFYKVx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 06:21:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 400FE607C3; Tue, 25 Jun 2019 10:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561458111;
        bh=hyDhwAbXy1Bj5qG5JrEdCbAbSbbrdaEuU1K8NqGyhJw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gtW99jieJj5jeEzrkY5drX5KKcjewwfjSAX932EghT0jwDbR3LYZnTrvgJpN4JiSz
         HtcNdtdTD6kR3s5EcxxJN+XPmA6x7Ark888fvkYJSgm89i8fE2R+JFQYbGaK52aXWS
         0Krxc1nNQ09Zz+dcO8mJBg/fq9/uVhGuVKNiNS+U=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 12BCA60255;
        Tue, 25 Jun 2019 10:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561458110;
        bh=hyDhwAbXy1Bj5qG5JrEdCbAbSbbrdaEuU1K8NqGyhJw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U0z5fN3IxtKje4/0calj3B4JynziHizSIgNy6LPImYAbgK7bUbVzst1bKMgLyJ4B5
         7xK+0GEJC9p83VuX/yN7cT+7YiQTwb9QKFF2Djsb/rhoLjF8L7spBn351qp3a8+Z+G
         NmO+r4SEVfUCPDaOmr2F1wH+UtQi50QuhYDLMpEQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 Jun 2019 13:21:50 +0300
From:   Alexei Lazar <ailizaro@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
Subject: Re: [PATCH v3 1/2] nl80211: Add support for EDMG channels
In-Reply-To: <d1c2fd8d99d8f8420ba265f31709da9326ad38f1.camel@sipsolutions.net>
References: <1558364020-11064-1-git-send-email-ailizaro@codeaurora.org>
 <1558364020-11064-2-git-send-email-ailizaro@codeaurora.org>
 <d1c2fd8d99d8f8420ba265f31709da9326ad38f1.camel@sipsolutions.net>
Message-ID: <40d70ed94b1d79d481511031e8f4ea45@codeaurora.org>
X-Sender: ailizaro@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-06-14 15:31, Johannes Berg wrote:
> Hi Alexei,
> 
> Sorry for the long delay here.
> 
> I have a few questions.
> 
> Looking at this:

Hi Johannes,

Thank you for the review, comments inline.

Thanks,
Alex.

> 
>>  /**
>> + * struct ieee80211_sta_edmg_cap - EDMG capabilities
>> + *
>> + * This structure describes most essential parameters needed
>> + * to describe 802.11ay EDMG capabilities
>> + *
>> + * @channels: bitmap that indicates the 2.16 GHz channel(s)
>> + *	that are allowed to be used for transmissions in the BSS.
>> + *	Set to 0 indicate EDMG not supported.
>> + * @bw_config: Channel BW Configuration subfield encodes
>> + *	the allowed channel bandwidth configurations
>> + */
>> +struct ieee80211_sta_edmg_cap {
>> +	u8 channels;
>> +	u8 bw_config;
>> +};
> 
> What are the bits actually? Seems you should define some enum or so 
> that
> shows which bits are used here?

Enum is not needed in this case, Each bit in the channels represent 
legacy
channel, bit 0 represent channel 1, bit 1 represent channel 2 and so 
on...
till bit 5 that represent channel 6.
I will update the description to make it more clear.

> 
>>   * @center_freq1: center frequency of first segment
>>   * @center_freq2: center frequency of second segment
>>   *	(only with 80+80 MHz)
>> + * @edmg_channels: bitmap that indicates the 2.16 GHz channel(s)
>> + *	that are allowed to be used for transmissions in the BSS.
>> + * @edmg_bw_config: Channel BW Configuration subfield encodes
>> + *	the allowed channel bandwidth configurations
>>   */
>>  struct cfg80211_chan_def {
>>  	struct ieee80211_channel *chan;
>>  	enum nl80211_chan_width width;
>>  	u32 center_freq1;
>>  	u32 center_freq2;
>> +	u8 edmg_channels;
>> +	u8 edmg_bw_config;
>>  };
> 
> This isn't clear to me. How can the capability and the configuration be
> exactly the same? In the capability, you should be able to capture
> multiple possible things, and in the setting only choose one?

edmg_channels can specify multiple channels and edmg_bw_config can 
specify
multiple bonding options. For example edmg_bw_config = 15 means that
association is allowed/requested with bonding of 1, 2, 3 or 4 channels.
When driver reports capability - it obviously can report multiple 
options.
For the setting (connect command or start AP), kernel can request 
multiple
options (subset of reported capabilities) and the driver will choose one 
of
them, based on BSS configuration and resource availability.

> 
> And if they really are the same, why not use the struct
> ieee80211_sta_edmg_cap here? Seems weird to me, but I don't know 11ay.

Good comment, will use the ieee80211_sta_edmg_cap struct.

> 
> 
> Also, I think you should describe a bit more how this plays together
> with the existing settings. Will ->chan still be set, to something like
> the control channel?

Updated cfg80211.h
wil->chan in case of 11ay is the primary channel and other setting being
ignored.

> 
>>  /**
>> @@ -1144,15 +1169,17 @@ int cfg80211_check_station_change(struct wiphy 
>> *wiphy,
>>   * @RATE_INFO_FLAGS_MCS: mcs field filled with HT MCS
>>   * @RATE_INFO_FLAGS_VHT_MCS: mcs field filled with VHT MCS
>>   * @RATE_INFO_FLAGS_SHORT_GI: 400ns guard interval
>> - * @RATE_INFO_FLAGS_60G: 60GHz MCS
>> + * @RATE_INFO_FLAGS_DMG: 60GHz MCS
>>   * @RATE_INFO_FLAGS_HE_MCS: HE MCS information
>> + * @RATE_INFO_FLAGS_EDMG: 60GHz MCS in EDMG mode
>>   */
>>  enum rate_info_flags {
>>  	RATE_INFO_FLAGS_MCS			= BIT(0),
>>  	RATE_INFO_FLAGS_VHT_MCS			= BIT(1),
>>  	RATE_INFO_FLAGS_SHORT_GI		= BIT(2),
>> -	RATE_INFO_FLAGS_60G			= BIT(3),
>> +	RATE_INFO_FLAGS_DMG			= BIT(3),
>>  	RATE_INFO_FLAGS_HE_MCS			= BIT(4),
>> +	RATE_INFO_FLAGS_EDMG			= BIT(5),
>>  };
>> 
>>  /**
>> @@ -1192,6 +1219,7 @@ enum rate_info_bw {
>>   * @he_dcm: HE DCM value
>>   * @he_ru_alloc: HE RU allocation (from &enum nl80211_he_ru_alloc,
>>   *	only valid if bw is %RATE_INFO_BW_HE_RU)
>> + * @n_bonded_ch: In case of EDMG the number of bonded channels (1-4)
>>   */
>>  struct rate_info {
>>  	u8 flags;
>> @@ -1202,6 +1230,7 @@ struct rate_info {
>>  	u8 he_gi;
>>  	u8 he_dcm;
>>  	u8 he_ru_alloc;
>> +	u8 n_bonded_ch;
>>  };
> 
> 
> It seems like this is missing corresponding nl80211.h changes?

n_bonded_ch not exposed to the userspace, like flags.

> 
>> @@ -2436,6 +2469,8 @@ struct cfg80211_connect_params {
>>  	const u8 *fils_erp_rrk;
>>  	size_t fils_erp_rrk_len;
>>  	bool want_1x;
>> +	u8 edmg_channels;
>> +	u8 edmg_bw_config;
>>  };
> 
> Same question as above, why not embed the struct if it's the same?

Done.

> 
> Again it seems like it shouldn't be the same though.
> 
>> + * @NL80211_ATTR_WIPHY_EDMG_CHANNELS: bitmap that indicates the 2.16 
>> GHz
>> + *	channel(s) that are allowed to be used for EDMG transmissions in 
>> the
>> + *	BSS as defined by IEEE 802.11 section 9.4.2.251.
>> + * @NL80211_ATTR_WIPHY_EDMG_BW_CONFIG: Channel BW Configuration 
>> subfield encodes
>> + *	the allowed channel bandwidth configurations as defined by IEEE 
>> 802.11
>> + *	section 9.4.2.251, Table 13.
> 
> This is unclear - "in the BSS" means nothing in this context, since
> you're using this to advertise capabilities?
> 
> This isn't a BSS attribute, after all.
> 
> Ah - but looking further, you use this to *set* the channel, not for
> capabilities... I guess that makes sense.

You are correct, this is for setting the channel, I've updated the
description.

> 
> 
>>   * @NL80211_BAND_ATTR_VHT_CAPA: VHT capabilities, as in the HT 
>> information IE
>>   * @NL80211_BAND_ATTR_IFTYPE_DATA: nested array attribute, with each 
>> entry using
>>   *	attributes from &enum nl80211_band_iftype_attr
>> + * @NL80211_BAND_ATTR_EDMG_CHANNELS: bitmap that indicates the 2.16 
>> GHz
>> + *	channel(s) that are allowed to be used for EDMG transmissions in 
>> the
>> + *	BSS as defined by IEEE 802.11 section 9.4.2.251.
>> + * @NL80211_BAND_ATTR_EDMG_BW_CONFIG: Channel BW Configuration 
>> subfield
>> + *	encodes the allowed channel bandwidth configurations as defined by
>> + *	IEEE 802.11 section 9.4.2.251, Table 13.
>>   * @NL80211_BAND_ATTR_MAX: highest band attribute currently defined
>>   * @__NL80211_BAND_ATTR_AFTER_LAST: internal use
> 
> And ... that makes more sense than the global attribute I guess?

We feel it belongs to the BAND attributes because for example also VHT
capability is there. There are however 2 other options:
1. Move the attribute to the NL80211_FREQUENCY_ATTR
2. Move them to the global attributes
Any preference?

> 
>> +static bool cfg80211_edmg_chandef_valid(const struct 
>> cfg80211_chan_def *chandef)
>> +{
>> +	int max_continuous = 0;
>> +	int num_of_enabled = 0;
>> +	int continuous = 0;
> 
> do you mean "contiguous"? "continuous" doesn't make much sense?

Updated , contiguous.

> 
>> +	int i;
>> +
>> +	if (!chandef->edmg_channels && !chandef->edmg_bw_config)
>> +		return true;
>> +
>> +	if ((!chandef->edmg_channels && chandef->edmg_bw_config) ||
>> +	    (chandef->edmg_channels && !chandef->edmg_bw_config))
>> +		return false;
> 
> There probably should be some kind of WARN_ON() check that validates 
> you
> get here only if the ->chan is actually 60GHz?

Added 60GHz check.

> 
>> +++ b/net/wireless/nl80211.c
>> @@ -288,6 +288,9 @@ static int validate_ie_attr(const struct nlattr 
>> *attr,
>> 
>>  	[NL80211_ATTR_WIPHY_FREQ] = { .type = NLA_U32 },
>>  	[NL80211_ATTR_WIPHY_CHANNEL_TYPE] = { .type = NLA_U32 },
>> +	[NL80211_ATTR_WIPHY_EDMG_CHANNELS] = { .type = NLA_U8 },
>> +	[NL80211_ATTR_WIPHY_EDMG_BW_CONFIG] = { .type = NLA_U8 },
> 
> You probably want something like NLA_POLICY_RANGE() here? This was only
> 1-4 IIRC?

Updated to NLA_POLICY_RANGE, the range value is 4-15, align with the 
Spec.

> 
>> +	if (info->attrs[NL80211_ATTR_WIPHY_EDMG_CHANNELS]) {
>> +		chandef->edmg_channels =
>> +		      nla_get_u8(info->attrs[NL80211_ATTR_WIPHY_EDMG_CHANNELS]);
>> +
>> +		if (info->attrs[NL80211_ATTR_WIPHY_EDMG_BW_CONFIG])
>> +			chandef->edmg_bw_config =
>> +		     nla_get_u8(info->attrs[NL80211_ATTR_WIPHY_EDMG_BW_CONFIG]);
>> +	} else {
>> +		chandef->edmg_bw_config = 0;
>> +		chandef->edmg_channels = 0;
>> +	}
>> +
>>  	if (!cfg80211_chandef_valid(chandef)) {
> 
> So I guess what I suggested above shouldn't actually be a WARN_ON() but
> just a check w/o WARN_ON()?

Added 60GHz check.

> 
> johannes

-- 
Alexei Lazar
Qualcomm Israel, on behalf of Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum a
Linux Foundation Collaborative Project
