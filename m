Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE04FB478
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2019 17:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfKMQAT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Nov 2019 11:00:19 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52108 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfKMQAS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Nov 2019 11:00:18 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2A47F6076A; Wed, 13 Nov 2019 16:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573660817;
        bh=H1PMM7dfaW4GETpO3V3j1O2EmVkjQhOAruUnBrJItmM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gbFWIfVXWoLDa6o0hmsH7mv9kF8PmjWLfTo18MsaS4RldSBWCC9RjNOn/K2SbMX0n
         vHd/ySDRa97WHjgu/CV19PhlDNofFW3mOojJWoobrzX/O9lqjFkgZY6Yg4Ri4Z8OK3
         ZaESWzsVhycdPDAVCQ9oVQqK9RSfZB5M37Ei9/9Y=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6E59C606FB;
        Wed, 13 Nov 2019 16:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573660816;
        bh=H1PMM7dfaW4GETpO3V3j1O2EmVkjQhOAruUnBrJItmM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R6mcUaCeDFq89XdY2ZXVcL9kHMTioSHW6SRm7Ck8iHjYygDzuWQSjXaraEIrYc0AA
         y1Z4KnVh+kwJR9ND6C5wXTtVIOsq/ksU69GGTmBSzyqZrD5NlvEQDJCwjethhRJ9Ir
         QWjbJvJ/Y0ROxr1CcH0rEng70EiytuIs4Lpef19s=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Nov 2019 21:30:16 +0530
From:   Tamizh chelvam <tamizhr@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCHv8 1/6] nl80211: New netlink command for TID specific
 configuration
In-Reply-To: <e131cd2251fc022f8bef91882c03e85b4a9f4243.camel@sipsolutions.net>
References: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
 <1572957714-16085-2-git-send-email-tamizhr@codeaurora.org>
 <e131cd2251fc022f8bef91882c03e85b4a9f4243.camel@sipsolutions.net>
Message-ID: <8849a80626630876aa3e09ed2c9ef24b@codeaurora.org>
X-Sender: tamizhr@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes/Sergey,

Thanks for your review comments

> Hi,
> 
> I was tempted to fix this up myself and finally get it over with, but
> then I thought it's probably better if I don't - it's a lot of things.
> 
>> Add a new NL command, NL80211_CMD_SET_TID_CONFIG to support
>> data TID specific configuration. This per TID configurations
>> are passed in NL80211_TID_CONFIG_ATTR_TID which is a nested
>> attribute. This patch adds support to configure per TID
>> noack policy through NL80211_TID_CONFIG_ATTR_NOACK attribute.
>> Data TID value for this configuration will be passed through
>> NL80211_TID_CONFIG_ATTR_TID attribute. When the user-space wants
>> this configuration peer specific rather than being applied for
>> all the connected stations, MAC address of the peer can be passed
>> in NL80211_ATTR_MAC attribute. This patch introduced
>> enum ieee80211_tid_conf_mask to notify the driver that which
>> configuration modified.
>> Driver supporting data TID specific noack policy configuration
>> should be advertise through NL80211_EXT_FEATURE_PER_TID_NOACK_CONFIG
>> and supporting per STA data TID noack policy configuration
>> should be advertise through NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG
> 
> This is just a wall of text, it's also wrong in some places. I was 
> going
> to replace it with this:
> 
>     nl80211: add command for TID specific configuration
> 
>     Add the new NL80211_CMD_SET_TID_CONFIG command to support
>     data TID specific configuration. Per TID configuration is
>     passed in the nested NL80211_ATTR_TID_CONFIG attribute.
> 
>     This patch adds support to configure per TID noack policy
>     through the NL80211_TID_CONFIG_ATTR_NOACK attribute.
> 
>     Configuration can be STA-specific (if supported) or for
>     all stations on a given interface if no STA is selected.
> 
>     Two new feature flags are added:
>      * NL80211_EXT_FEATURE_PER_TID_NOACK_CONFIG for noack, and
>      * NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG for STA-specific
>        noack support.
> 
> which IMHO makes more sense. Can you rewrite it? Feel free to copy this
> I guess.
> 
Sure, I will use this.

>> +enum ieee80211_tid_conf_mask {
>> +       IEEE80211_TID_CONF_NOACK        = BIT(0),
>> +};
> 
> Why not remove this and use BIT(NL80211_TID_CONFIG_ATTR_NOACK)?
> 
Sure.
>> + * @tid_conf_mask: bitmap indicating which parameter changed
>> + *	see %enum ieee80211_tid_conf_mask
> 
> Either way use &enum so you get a link.
> 
Sure.
>> + * @noack: noack configuration value for the TID
> 
> Should be enum nl80211_tid_config not u8?
> 
Yes, I will change it.

>> @@ -3625,6 +3654,10 @@ struct cfg80211_update_owe_info {
>>   *
>>   * @probe_mesh_link: Probe direct Mesh peer's link quality by sending 
>> data frame
>>   *	and overrule HWMP path selection algorithm.
>> + * @set_tid_config: TID specific configuration. Apply this 
>> configuration for
>> + *	all the connected stations in the BSS if peer is %NULL. Otherwise
>> + *	apply this configuration to the specific station.
>> + *	This callback may sleep.
> 
> This should document the stuff discussed with Sergey, whatever we 
> decide
> there.
Sure.
> 
>> + * @NL80211_CMD_SET_TID_CONFIG: Data frame TID specific configuration
>> + *	is passed through this command using %NL80211_ATTR_TID_CONFIG
> 
> to not through
> 
>> + *	nested attributes.
> 
> Using the %NL80211_ATTR_TID_CONFIG attribute.
> 
Sure.
>> + * @NL80211_ATTR_TID_CONFIG: TID specific configuration in a
>> + *	nested attribute with %NL80211_TID_CONFIG_ATTR_* sub-attributes.
> 
> Would be worthwhile to link to the enum (&enum nl80211_tid_config_attr)
> instead of giving the %NL80211_... thing.
> 
Sure.
>>  /**
>> + * enum nl80211_tid_config - TID config state
>> + * @NL80211_TID_CONFIG_DEFAULT: Default config for the TID. This is 
>> to
>> + *	notify driver to reset the previous config and use vif specific
>> + *	default config
>> + * @NL80211_TID_CONFIG_ENABLE: Enable config for the TID
>> + * NL80211_TID_CONFIG_DISABLE: Disable config for the TID
> 
> missing @
> 
> I'm still a bit on the fence on this.
> 
> How about we add an explicit "reset" API instead? So you could say
> 
> set_tid(sta=..., tid=7, reset=BIT(NL80211_TID_CONFIG_ATTR_NOACK) or so?
> 
> (or IEEE80211_TID_CONF_NOACK if we prefer that, not sure)
> 
> Just throwing that out here for ideas, not for you to go implement it
> right now :)
> 
> 
> Then we don't really need NL80211_TID_CONFIG_DEFAULT. We still need
> ENABLE/DISABLE to allow "leave unchanged", though I'd probably 
> formulate
> that a bit more generic than anything with "TID" in the name then.
> 
> That would also address something you can't do now - you cannot reset
> the TX rate to the default this way, i.e. removing the STA override for
> a TX rate isn't possible.
> 
I thought of resetting it through "NL80211_TX_RATE_AUTOMATIC". Are you 
okay with that ?
I will document that in the next patchset.
>> + * @NL80211_TID_CONFIG_ATTR_TID: a TID value (u8 attribute).
>> + * @NL80211_TID_CONFIG_ATTR_NOACK: Configure ack policy for the TID.
>> + *	specified in %NL80211_TID_CONFIG_ATTR_TID. see %enum 
>> nl80211_tid_config.
>> + *	Its type is u8, if the peer MAC address is passed in 
>> %NL80211_ATTR_MAC,
>> + *	then the noack configuration is applied to the data frame for the 
>> tid
>> + *	to that connected station. This configuration is valid only for 
>> STA's
>> + *	current connection. i.e. the configuration will be reset to 
>> default when
>> + *	the station connects back after disconnection/roaming.
>> + *	when user-space does not include %NL80211_ATTR_MAC, then this
>> + *	configuration should be treated as per-netdev configuration.
>> + *	This configuration will be cleared when the interface goes down 
>> and on
>> + *	the disconnection from a BSS. Driver supporting this feature 
>> should
>> + *	advertise NL80211_EXT_FEATURE_PER_TID_NOACK_CONFIG and
>> + *	NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG for supporting  per sta
>> + *	configuration.
> 
> Most of this text should be somewhere else, in a general text about the
> TID-specific configuration, in particular all the stuff about the
> lifetime etc. You can put it into the method documentation, but it 
> might
> be better to just add a "DOC:" section explaining it all.
> 
Okay sure, I will reduce these texts in the commit log and add it to 
DOC: section.

>> +	if (!wiphy_ext_feature_isset(&rdev->wiphy, per_tid_config)) {
>> +		NL_SET_ERR_MSG_ATTR(extack, attr, "TID specific configuration not 
>> supported");
> 
> please add linebreaks - it'll still be longer than 80 cols, but at 
> least
> if you break after "attr," it's not *that* long.
> 
Okay.
>> +		return -ENOTSUPP;
>> +	}
>> +
> 
> there's a stray space here
> 
Will fix this in next patchset.

>> +	if (peer && !wiphy_ext_feature_isset(&rdev->wiphy, per_sta_config)) 
>> {
>> +		NL_SET_ERR_MSG_ATTR(extack, attr, "peer specific TID configuration 
>> not supported");
> 
> same as above
> 
>> +	tid_conf->tid = nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_TID]);
>> +	if (attrs[NL80211_TID_CONFIG_ATTR_NOACK]) {
>> +		err = nl80211_check_tid_config_support(rdev, extack, peer,
>> +				attrs[NL80211_TID_CONFIG_ATTR_NOACK],
>> +				NL80211_EXT_FEATURE_PER_TID_NOACK_CONFIG,
>> +				NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG);
>> +		if (err)
>> +			return err;
>> +
>> +		tid_conf->tid_conf_mask |= IEEE80211_TID_CONF_NOACK;
> 
> If you change the tid_conf_mask to be BIT() you can roll that |= into
> the nl80211_check_tid_config_support() function, which seems nicer?
> 
> I might go as far as suggesting a wrapper macro for this that lets you
> save typing on the whole "NL80211_*" prefixes, so you just have
> 
> err = nl80211_check_tid_config_supoprt(rdev, extack, peer, attrs,
>                                        NOACK);
> 
> and the other arguments are generated by the macro based on the NOACK
> portion. That'll save a lot of typing in the next patches ...
> 
Sure, I will go with wrapper macro method.

>> +		tid_conf->noack =
>> +			nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_NOACK]);
> 
> Maybe even roll that in by having some kind of function pointer, like
> the mesh code did? But that's harder, might not be worth it. But if you
> do then you can also roll in the "if (attr[])" presence check and make
> this a lot more streamlined.
> 
>> +		if (!attrs[NL80211_TID_CONFIG_ATTR_TID]) {
>> +			ret = -EINVAL;
>> +			goto bad_tid_conf;
>> +		}
> 
> Maybe move that into the function:
> 
Sure.
>> +		ret = parse_tid_conf(rdev, attrs,
>> +				     &tid_config->tid_conf[conf_idx],
>> +				     info, tid_config->peer);
> 
Tamizh.
