Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6D51F43FA
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 10:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbfKHJzg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 04:55:36 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:53408 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730719AbfKHJzf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 04:55:35 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iT0zJ-0007ES-UJ; Fri, 08 Nov 2019 10:55:30 +0100
Message-ID: <e131cd2251fc022f8bef91882c03e85b4a9f4243.camel@sipsolutions.net>
Subject: Re: [PATCHv8 1/6] nl80211: New netlink command for TID specific
 configuration
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tamizh chelvam <tamizhr@codeaurora.org>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 08 Nov 2019 10:55:29 +0100
In-Reply-To: <1572957714-16085-2-git-send-email-tamizhr@codeaurora.org>
References: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
         <1572957714-16085-2-git-send-email-tamizhr@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I was tempted to fix this up myself and finally get it over with, but
then I thought it's probably better if I don't - it's a lot of things.

> Add a new NL command, NL80211_CMD_SET_TID_CONFIG to support
> data TID specific configuration. This per TID configurations
> are passed in NL80211_TID_CONFIG_ATTR_TID which is a nested
> attribute. This patch adds support to configure per TID
> noack policy through NL80211_TID_CONFIG_ATTR_NOACK attribute.
> Data TID value for this configuration will be passed through
> NL80211_TID_CONFIG_ATTR_TID attribute. When the user-space wants
> this configuration peer specific rather than being applied for
> all the connected stations, MAC address of the peer can be passed
> in NL80211_ATTR_MAC attribute. This patch introduced
> enum ieee80211_tid_conf_mask to notify the driver that which
> configuration modified.
> Driver supporting data TID specific noack policy configuration
> should be advertise through NL80211_EXT_FEATURE_PER_TID_NOACK_CONFIG
> and supporting per STA data TID noack policy configuration
> should be advertise through NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG

This is just a wall of text, it's also wrong in some places. I was going
to replace it with this:

    nl80211: add command for TID specific configuration
    
    Add the new NL80211_CMD_SET_TID_CONFIG command to support
    data TID specific configuration. Per TID configuration is
    passed in the nested NL80211_ATTR_TID_CONFIG attribute.
    
    This patch adds support to configure per TID noack policy
    through the NL80211_TID_CONFIG_ATTR_NOACK attribute.
    
    Configuration can be STA-specific (if supported) or for
    all stations on a given interface if no STA is selected.
    
    Two new feature flags are added:
     * NL80211_EXT_FEATURE_PER_TID_NOACK_CONFIG for noack, and
     * NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG for STA-specific
       noack support.

which IMHO makes more sense. Can you rewrite it? Feel free to copy this
I guess.

> +enum ieee80211_tid_conf_mask {
> +       IEEE80211_TID_CONF_NOACK        = BIT(0),
> +};

Why not remove this and use BIT(NL80211_TID_CONFIG_ATTR_NOACK)?

> + * @tid_conf_mask: bitmap indicating which parameter changed
> + *	see %enum ieee80211_tid_conf_mask

Either way use &enum so you get a link.

> + * @noack: noack configuration value for the TID

Should be enum nl80211_tid_config not u8?

> @@ -3625,6 +3654,10 @@ struct cfg80211_update_owe_info {
>   *
>   * @probe_mesh_link: Probe direct Mesh peer's link quality by sending data frame
>   *	and overrule HWMP path selection algorithm.
> + * @set_tid_config: TID specific configuration. Apply this configuration for
> + *	all the connected stations in the BSS if peer is %NULL. Otherwise
> + *	apply this configuration to the specific station.
> + *	This callback may sleep.

This should document the stuff discussed with Sergey, whatever we decide
there.

> + * @NL80211_CMD_SET_TID_CONFIG: Data frame TID specific configuration
> + *	is passed through this command using %NL80211_ATTR_TID_CONFIG

to not through

> + *	nested attributes.

Using the %NL80211_ATTR_TID_CONFIG attribute.

> + * @NL80211_ATTR_TID_CONFIG: TID specific configuration in a
> + *	nested attribute with %NL80211_TID_CONFIG_ATTR_* sub-attributes.

Would be worthwhile to link to the enum (&enum nl80211_tid_config_attr)
instead of giving the %NL80211_... thing.

>  /**
> + * enum nl80211_tid_config - TID config state
> + * @NL80211_TID_CONFIG_DEFAULT: Default config for the TID. This is to
> + *	notify driver to reset the previous config and use vif specific
> + *	default config
> + * @NL80211_TID_CONFIG_ENABLE: Enable config for the TID
> + * NL80211_TID_CONFIG_DISABLE: Disable config for the TID

missing @

I'm still a bit on the fence on this.

How about we add an explicit "reset" API instead? So you could say

set_tid(sta=..., tid=7, reset=BIT(NL80211_TID_CONFIG_ATTR_NOACK) or so?

(or IEEE80211_TID_CONF_NOACK if we prefer that, not sure)

Just throwing that out here for ideas, not for you to go implement it
right now :)


Then we don't really need NL80211_TID_CONFIG_DEFAULT. We still need
ENABLE/DISABLE to allow "leave unchanged", though I'd probably formulate
that a bit more generic than anything with "TID" in the name then.

That would also address something you can't do now - you cannot reset
the TX rate to the default this way, i.e. removing the STA override for
a TX rate isn't possible.

> + * @NL80211_TID_CONFIG_ATTR_TID: a TID value (u8 attribute).
> + * @NL80211_TID_CONFIG_ATTR_NOACK: Configure ack policy for the TID.
> + *	specified in %NL80211_TID_CONFIG_ATTR_TID. see %enum nl80211_tid_config.
> + *	Its type is u8, if the peer MAC address is passed in %NL80211_ATTR_MAC,
> + *	then the noack configuration is applied to the data frame for the tid
> + *	to that connected station. This configuration is valid only for STA's
> + *	current connection. i.e. the configuration will be reset to default when
> + *	the station connects back after disconnection/roaming.
> + *	when user-space does not include %NL80211_ATTR_MAC, then this
> + *	configuration should be treated as per-netdev configuration.
> + *	This configuration will be cleared when the interface goes down and on
> + *	the disconnection from a BSS. Driver supporting this feature should
> + *	advertise NL80211_EXT_FEATURE_PER_TID_NOACK_CONFIG and
> + *	NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG for supporting  per sta
> + *	configuration.

Most of this text should be somewhere else, in a general text about the
TID-specific configuration, in particular all the stuff about the
lifetime etc. You can put it into the method documentation, but it might
be better to just add a "DOC:" section explaining it all.

> +	if (!wiphy_ext_feature_isset(&rdev->wiphy, per_tid_config)) {
> +		NL_SET_ERR_MSG_ATTR(extack, attr, "TID specific configuration not supported");

please add linebreaks - it'll still be longer than 80 cols, but at least
if you break after "attr," it's not *that* long.

> +		return -ENOTSUPP;
> +	}
> +	

there's a stray space here

> +	if (peer && !wiphy_ext_feature_isset(&rdev->wiphy, per_sta_config)) {
> +		NL_SET_ERR_MSG_ATTR(extack, attr, "peer specific TID configuration not supported");

same as above

> +	tid_conf->tid = nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_TID]);
> +	if (attrs[NL80211_TID_CONFIG_ATTR_NOACK]) {
> +		err = nl80211_check_tid_config_support(rdev, extack, peer,
> +				attrs[NL80211_TID_CONFIG_ATTR_NOACK],
> +				NL80211_EXT_FEATURE_PER_TID_NOACK_CONFIG,
> +				NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG);
> +		if (err)
> +			return err;
> +
> +		tid_conf->tid_conf_mask |= IEEE80211_TID_CONF_NOACK;

If you change the tid_conf_mask to be BIT() you can roll that |= into
the nl80211_check_tid_config_support() function, which seems nicer?

I might go as far as suggesting a wrapper macro for this that lets you
save typing on the whole "NL80211_*" prefixes, so you just have

err = nl80211_check_tid_config_supoprt(rdev, extack, peer, attrs,
                                       NOACK);

and the other arguments are generated by the macro based on the NOACK
portion. That'll save a lot of typing in the next patches ...

> +		tid_conf->noack =
> +			nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_NOACK]);

Maybe even roll that in by having some kind of function pointer, like
the mesh code did? But that's harder, might not be worth it. But if you
do then you can also roll in the "if (attr[])" presence check and make
this a lot more streamlined.

> +		if (!attrs[NL80211_TID_CONFIG_ATTR_TID]) {
> +			ret = -EINVAL;
> +			goto bad_tid_conf;
> +		}

Maybe move that into the function:

> +		ret = parse_tid_conf(rdev, attrs,
> +				     &tid_config->tid_conf[conf_idx],
> +				     info, tid_config->peer);

johannes

