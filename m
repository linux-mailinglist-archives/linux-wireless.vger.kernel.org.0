Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8396152E
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Jul 2019 16:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfGGOLD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 7 Jul 2019 10:11:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60360 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfGGOLD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 7 Jul 2019 10:11:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5879460A0A; Sun,  7 Jul 2019 14:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562508661;
        bh=7n+S52F6X5h6zq/t0qa5zrqb277zGmM9s40DaB3fwi4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iHgeG4lfgswPR0GkZd1OKQZcYOXm7Gn3Kf8Bds59g0sTknBC/2q9OtNygXgSLCFK2
         icTkeQNdoYKX3oa7GEcv0q9LpItk180jSwBuNbciDTMd5ynmIijPflK0GG5iqEed44
         2YL4zd1Tp9AR6tMcnn0CyXyAk/++rQh9E8jz/G0U=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 70FED60770;
        Sun,  7 Jul 2019 14:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562508660;
        bh=7n+S52F6X5h6zq/t0qa5zrqb277zGmM9s40DaB3fwi4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hr1habysOkZ9DLEa2uTbHm/msimi7gNz6lU4LhBCCmYLq7ijNOMGr8aXTEcfiLq5Y
         oTLdy05Qvw6wZtuFfL/a69uud8aqM3ypbxvU59c7UBd/xI3WG4ew1zLj9FythWrg9g
         FFlR9VWMXZAFB9cU/WOLSIGMJxgY50GEytZFhmZs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 07 Jul 2019 17:11:00 +0300
From:   Alexei Lazar <ailizaro@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
Subject: Re: [PATCH v3 1/2] nl80211: Add support for EDMG channels
In-Reply-To: <77b693b163faf61d72b2734b97081734f0345211.camel@sipsolutions.net>
References: <1561458567-31866-1-git-send-email-ailizaro@codeaurora.org>
 <1561458567-31866-2-git-send-email-ailizaro@codeaurora.org>
 <77b693b163faf61d72b2734b97081734f0345211.camel@sipsolutions.net>
Message-ID: <b3b97ea0dbe2fe115976c2728a041171@codeaurora.org>
X-Sender: ailizaro@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-06-28 16:21, Johannes Berg wrote:
> On Tue, 2019-06-25 at 13:29 +0300, Alexei Avshalom Lazar wrote:

Hi Johannes,

Again, Thank you for the review, comments inline.

Thanks,
Alex.

>> 
>>  /**
>> + * struct ieee80211_sta_edmg_cap - EDMG capabilities
>> + *
>> + * This structure describes most essential parameters needed
>> + * to describe 802.11ay EDMG capabilities
>> + *
>> + * @channels: bitmap that indicates the 2.16 GHz channel(s)
>> + *	that are allowed to be used for transmissions.
>> + *	Bit 0 indicates channel 1, bit 1 indicates channel 2, etc.
>> + *	Set to 0 indicate EDMG not supported.
>> + * @bw_config: Channel BW Configuration subfield encodes
>> + *	the allowed channel bandwidth configurations
>> + */
>> +struct ieee80211_sta_edmg_cap {
>> +	u8 channels;
>> +	u8 bw_config;
>> +};
> 
> [...]
> 
>> + * @edmg: define the EDMG channels configuration.
>> + *	If edmg is set, chan will define the primary channel and all other
>> + *	parameters are ignored.
>> 
>>  struct cfg80211_chan_def {
> 
> Thinking out loud, maybe this should say "If edmg is requested (i.e. 
> the
> .channels member is non-zero) [...]" or so?

Done.

> 
>> @@ -1192,6 +1218,7 @@ enum rate_info_bw {
>>   * @he_dcm: HE DCM value
>>   * @he_ru_alloc: HE RU allocation (from &enum nl80211_he_ru_alloc,
>>   *	only valid if bw is %RATE_INFO_BW_HE_RU)
>> + * @n_bonded_ch: In case of EDMG the number of bonded channels (1-4)
> 
> So, just for the stupid me because I didn't really read the spec.
> 
> You have N channels (can only be 8 since you use a u8, looking at the
> code further it looks like there are only 7) and edmg_cap::channels
> indicates which are supported/requested, and then edmg_cap::bw_config
> indicates how the channels are used?
> 
> I'm not sure I understand this part, because if you, say, request
> channels 1 and 2 (channels=0x3) then what configurations could be
> possible below that?
> 
> Oh, something about the primary channel maybe?
> 
> 
> I guess I would've expected something like a list of bitmaps that the
> device supports, and then at runtime you select only one bitmap.
> 
> If I have channels 1 and 2 enabled, how do the configurations differ?
> 
> Clearly they don't differ enough to make capturing them in the rate
> worthwhile, here n_bonded_ch would presumably only be 2, and that's
> enough to tell the rate. What then does the configuration mean?

Channels is a bitmap of 2.16GHz (normal) channels 1..6
bw_config defines the allowed combinations (bonding) of these "normal"
channels.
Let's say driver reports support for channels number 1,2,3 
(channels=0x7).
Example #1: driver reports bw_config=5
bw_config=5 allows combinations of 1 or 2 channels.
It means driver can operate in one of these combinations:
Channel 1 only
Channel 2 only
Channel 3 only
Channels 1+2 (cb2)
Channels 2+3 (cb2)

Example #2: driver reports bw_config=10
bw_config=10 allows combinations of 1,2 or 3 channels.
It means driver can operate in one of these combinations:
Channel 1 only
Channel 2 only
Channel 3 only
Channels 1+2 (cb2)
Channels 2+3 (cb2)
Channels 1+3 (cb2) - note 1 & 3 are non-contiguous channels, This 
combination
is not allow in bw_config=5
Channels 1+2+3 (cb3)

The primary channel BTW must be one of the operational channels so if
driver choose channels 1+3 then primary channel cannot be 2.

> 
> 
> It seems to me that you should, however, expose n_bonded_ch to
> userspace? We do expose all the details about the bitrate normally, see
> nl80211_put_sta_rate(). We do calculate the bitrate to expose that too,
> but do expose all the details too.
> 
> Hmm. Looking at that, it looks like DMG doesn't actually do that. So
> perhaps not, though it seems to me that it ought to be possible?

We will look into that and address in separate patch.

> 
>> @@ -2436,6 +2467,7 @@ struct cfg80211_connect_params {
>>  	const u8 *fils_erp_rrk;
>>  	size_t fils_erp_rrk_len;
>>  	bool want_1x;
>> +	struct ieee80211_sta_edmg_cap edmg;
> 
> Maybe we really should rename this struct type? It's not a "capability"
> here.

Done.

> 
>> +static bool cfg80211_edmg_chandef_valid(const struct 
>> cfg80211_chan_def *chandef)
>> +{
>> +	int max_continuous = 0;
>> +	int num_of_enabled = 0;
>> +	int contiguous = 0;
> 
> max_continuous vs. contiguous is even more confusing now :-)
> 
> 
>> +		max_continuous = max(contiguous, max_continuous);
> 
> See? :)

Done.

> 
>> +	/* basic verification of edmg configuration according to
>> +	 * IEEE802.11 section 9.4.2.251
> 
> All the IEEE 802.11 references (more than just this one) ... please
> qualify them with a version. I'm thinking these are not in -2016, so
> probably 802.11ay (perhaps even draft?)

Done.

> 
>> +	 */
>> +	/* check bw_config against contiguous edmg channels */
>> +	switch (chandef->edmg.bw_config) {
>> +	case 4:
>> +	case 8:
>> +	case 12:
>> +		if (max_continuous < 1)
>> +			return false;
>> +		break;
> 
> I guess I really should try to find a copy of the appropriate spec ...
> 
> johannes

-- 
Alexei Lazar
Qualcomm Israel, on behalf of Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum a
Linux Foundation Collaborative Project
