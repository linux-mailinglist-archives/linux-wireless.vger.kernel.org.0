Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 458B81B876
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 16:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfEMOip (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 10:38:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58558 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbfEMOio (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 10:38:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6B4A160AA3; Mon, 13 May 2019 14:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557758323;
        bh=uL33hlIrxs+lapC+prVidP+zdzFCBH/xX5edNuqKeIs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bkQFrlfvz1BTj6ELseHPAVCwAAS8EoyelFp0mtCrV4JbWkV5KYWB2XH3usFAh6RNN
         Pyp9CkAEeXA+a0Q7XsFIOZgyoWRQt0pmXd7QYM8R0PBHoc4pH7tInLWQuaU9mrvWE/
         vTG47nDv2uzk8tHfy3nEGPvJSsToZUiS0PS8hEFA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from [10.18.172.35] (unknown [185.23.60.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ailizaro@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 52213608A5;
        Mon, 13 May 2019 14:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557758322;
        bh=uL33hlIrxs+lapC+prVidP+zdzFCBH/xX5edNuqKeIs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bp9zhU6tbCo+/5IPdzRl9/2Y+xiSHq6HW9eEO8OeYl9xu9pPnY+ihBmdGWqO3mJj3
         qE/9R5huRvlrbnI8M/hqT0AgXMeixi7lOQP2KXsTKoc8nQ68fk73X/kQWiLbjkA1bv
         5TDuQOjD6fKq+F/gjTbagi6Nq9EoqUluLyjedbMU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52213608A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ailizaro@codeaurora.org
Subject: Re: [PATCH 2/3] nl80211: Add support for EDMG channels
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
References: <1534163582-9983-1-git-send-email-ailizaro@codeaurora.org>
 <1534163582-9983-3-git-send-email-ailizaro@codeaurora.org>
 <1535448830.5895.30.camel@sipsolutions.net>
From:   Alexei Avshalom Lazar <ailizaro@codeaurora.org>
Message-ID: <9b69bcd6-8576-f900-c556-94c8e62ea91b@codeaurora.org>
Date:   Mon, 13 May 2019 17:38:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1535448830.5895.30.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 8/28/2018 12:33 PM, Johannes Berg wrote:
> On Mon, 2018-08-13 at 15:33 +0300, Alexei Avshalom Lazar wrote:
>>

Hi Johannes

The implementation has been updated according to the latest spec draft, 
Draft P802.11ay_D3.0
Most of the code that you commented has been updated in the new patch 
and your comments were taken into consideration where applicable.
I will upload an updated version of the patches shortly.

>>   /**
>> + * struct ieee80211_sta_edmg_cap - EDMG capabilities
>> + *
>> + * This structure describes most essential parameters needed
>> + * to describe 802.11ay EDMG capabilities
>> + *
>> + * @supported: is EDMG supported, Device may support EDMG
>> + *	without supporting channel bonding. In this case
>> + *	supported would be TRUE with n_channels = 0
> 
> TRUE -> %true

Not relevant with new patch.

> 
>> + * @channels: supported ieee EDMG channel numbers
> 
> IEEE

Not relevant with new patch.

> 
>> + * @n_channels: Number of channels in @channels
>> + */
>> +struct ieee80211_sta_edmg_cap {
>> +	bool supported;
>> +	u8 *channels;
> 
> const?
> 
> But really this is pointless - there are *two* channels here (6 and 7),
> and so at most you point to a 2-byte array? Just make it
> 
> 	u8 channels[2];
> 
> or something and save the whole pointering?
> 
> Ok, no, there are 9-25 or something, so I guess more than that...
> 
> Uh. Why do we bother though? Do we need the channel number anywhere? Why
> not just let userspace specify the bitmap to start with?
> 
> Would there really be devices that base their support for channels on
> anything other than support for the underlying DMG channels?

Devices will base their support on the combination of EDMG CB1 channels 
with the allowed bandwidth, for example if channels 1-3 are supported it 
doesn’t necessarily mean that CB3 (channel bonding of 3 channels) is 
supported. It is possible that device supports only CB2 (bonding of 2 
channels).
Please notice that the representation of the capabilities has been 
updated in the new patch.

> 
> 
>>    * @center_freq1: center frequency of first segment
>>    * @center_freq2: center frequency of second segment
>>    *	(only with 80+80 MHz)
>> + * @edmg_mode: if defined, edmg supported and primary channel is EDMG
>> + * @edmg_channel: the EDMG channel
>>    */
>>   struct cfg80211_chan_def {
>>   	struct ieee80211_channel *chan;
>>   	enum nl80211_chan_width width;
>>   	u32 center_freq1;
>>   	u32 center_freq2;
>> +	bool edmg_mode;
>> +	u8 edmg_channel;
> 
> This seems odd. What do you put into chan_width if it's EDMG then? What
> do you put into the chan pointer?

chan_width is not used today for the 11ad and cannot be used for channel 
bonding because the 11ay bandwidth configuration can have more than one 
option, for example - bandwidth configuration #13 means device can 
choose to associate on 2.16 or 4.32 or 2.16+2.16 channel width.
For the 11ay purposes the chan pointer has the information for the 
primary channel, band,  c_freq, hw_value (same as DMG case).

> 
>> + * @NL80211_ATTR_WIPHY_EDMG_CHANNEL: EDMG channel to be used for AP
>> + *      configuration and connect command.
> 
> u8 is intended, I assume?
> 
> But why do you need this anyhow? The EDMG channel has a frequency just
> like all other channels, no? Can't we continue to use the existing
> attributes?

This has been updated to bitmap of the legacy channel and the bandwidth 
configuration.
frequency attribute will be meaningless because they won't represent the 
relevant possibilities that defined by the spec, for example if the AP 
support CB2 and CB3 we won't be able to represent it with the frequencies.

> 
>> +static const struct edmg_chan_table {
>> +	/* the edmg channel - 9,10,11... */
>> +	u8 edmg_chan;
>> +	/* the sub channels represented as a bitfield where the bit-index
>> +	 * corresponds to the legacy channel (bit 0 not used).
>> +	 */
>> +	u8 sub_chans;
> 
> Uh, ok, so I guess it's more complicated?
> 
> I'm not familiar with 802.11ay ... I guess a short primer should be in
> the patch set here somewhere :)
> 
>> +} cfg80211_edmg_table[] = {
>> +	{9, 0x06},	/* channels 1,2 */
> 
> BIT(1) | BIT(2) ? then you don't really need the comments ...

Agree but not relevant with new patch.

> 
>> +	{10, 0x0c},	/* channels 2,3 */
>> +	{11, 0x18},	/* channels 3,4 */
>> +	{12, 0x30},	/* channels 4,5 */
>> +	{13, 0x60},	/* channels 5,6 */
>> +	{17, 0x0e},	/* channels 1,2,3 */
>> +	{18, 0x1c},	/* channels 2,3,4 */
>> +	{19, 0x38},	/* channels 3,4,5 */
>> +	{20, 0x70},	/* channels 4,5,6 */
> 
> What happened to 21-24?

The spec doesn’t define contiguous channel numbers so 21-24 are not 
defined, same for 14-16.

> 
>> +	{25, 0x1e},	/* channels 1,2,3,4 */
> 
>> +static u8 cfg80211_get_edmg_sub_chans(u8 edmg_channel)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(cfg80211_edmg_table); i++)
>> +		if (cfg80211_edmg_table[i].edmg_chan == edmg_channel)
>> +			return cfg80211_edmg_table[i].sub_chans;
> 
> Maybe just index the array at "edmg_channel - 9", add dummies for 21-24
> and save the whole loop? I guess it doesn't matter so much though.

Not relevant with new patch.

> 
> johannes
> 

-- 
Alexei Lazar
Qualcomm Israel, on behalf of Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum a 
Linux Foundation Collaborative Project
