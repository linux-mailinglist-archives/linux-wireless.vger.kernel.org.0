Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE7B2A937E
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 10:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgKFJzy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 04:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgKFJzx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 04:55:53 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81502C0613CF
        for <linux-wireless@vger.kernel.org>; Fri,  6 Nov 2020 01:55:53 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kayTH-002D6c-6M; Fri, 06 Nov 2020 10:55:51 +0100
Message-ID: <8fbd821bbbe3e2cd9efcb3caf3be7e9483b98bcf.camel@sipsolutions.net>
Subject: Re: [PATCH V6 1/3] nl80211: add support for BSS coloring
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 06 Nov 2020 10:55:50 +0100
In-Reply-To: <20201103092244.1925158-2-john@phrozen.org>
References: <20201103092244.1925158-1-john@phrozen.org>
         <20201103092244.1925158-2-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> +
> +/*
> + * cfg80211_bss_color_notify - notify about bss color event

These all need /**

I was going to fix that (and some below things), but it got a bit
complex, and there's a question ... and patch 2 needs significant work
anyway.

> +	NL80211_CMD_OBSS_COLOR_COLLISION,
> +
> +	NL80211_CMD_COLOR_CHANGE,
> +	NL80211_CMD_COLOR_CHANGE_ANNOUNCEMENT_STARTED,
> +	NL80211_CMD_COLOR_CHANGE_ANNOUNCEMENT_ABORTED,
> +	NL80211_CMD_COLOR_CHANGE_ANNOUNCEMENT_COMPLETED,

Might make sense to multiplex that into a single
NL80211_CMD_COLOR_CHANGE event? Not sure, it doesn't matter too much
now, but ... we do have limited commands eventually :-)

> + * @NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_IES: Nested set of attributes containing the IE
> + *	information for the time while performing a color switch.

_ELEMS perhaps?

Should probably also be a bit more specific on what's used from there.

> + * @NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_C_OFF_BEACON: An array of offsets (u16) to the color
> + *	switch counters in the beacons tail (%NL80211_ATTR_BEACON_TAIL).

Is this inside or outside, for example? I think outside, but should it
be? I guess should be just like CSA though.

> + * @NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_C_OFF_PRESP: An array of offsets (u16) to the color
> + *	switch counters in the probe response (%NL80211_ATTR_PROBE_RESP).

This is unused?

>   * @NUM_NL80211_ATTR: total number of nl80211_attrs available
>   * @NL80211_ATTR_MAX: highest attribute number currently defined
>   * @__NL80211_ATTR_AFTER_LAST: internal use
> @@ -3035,6 +3071,12 @@ enum nl80211_attrs {
>  	NL80211_ATTR_MULTIPLE_BSSID_IES,
>  	NL80211_ATTR_MULTIPLE_BSSID_EMA,
>  
> +	NL80211_ATTR_OBSS_COLOR_BITMAP,
> +
> +	NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_COUNT,
> +	NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_COLOR,
> +	NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_IES,

and in fact not defined?

> +static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct cfg80211_registered_device *rdev = info->user_ptr[0];
> +	struct net_device *dev = info->user_ptr[1];
> +	struct wireless_dev *wdev = dev->ieee80211_ptr;
> +	struct cfg80211_color_change_settings params;
> +	static struct nlattr *color_change_attrs[NL80211_ATTR_MAX + 1];

I'd prefer you didn't. I'm working on getting rid of the RTNL in most
places, and that just adds more complexity to that ... please
dynamically allocate it.

Also, it just reserves space in the binary for a very rarely used code
path.

> +	int err, len;
> +
> +	if (!rdev->ops->color_change ||
> +	    !(wiphy_ext_feature_isset(&rdev->wiphy, NL80211_EXT_FEATURE_BSS_COLOR)))


some line wrapping in some places would be nice - not sure if this one
is affected, but still, you have a few that wouldn't be hard to wrap
IMHO.

> +	err = nla_parse_nested(color_change_attrs, NL80211_ATTR_MAX,
> +			       info->attrs[NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_IES],
> +			       nl80211_policy, NULL);

Please pass info->extack through to the last argument.

> +	if (err)
> +		return err;
> +
> +	err = nl80211_parse_beacon(rdev, color_change_attrs, &params.beacon_color_change);

(here for example, re wrapping)

> +	if (!info->attrs[NL80211_ATTR_CNTDWN_OFFS_BEACON])
> +		return -EINVAL;
> +
> +	len = nla_len(info->attrs[NL80211_ATTR_CNTDWN_OFFS_BEACON]);
> +	if (len != sizeof(u16))
> +		return -EINVAL;
> +
> +	memcpy(&params.counter_offset_beacon,
> +	       nla_data(info->attrs[NL80211_ATTR_CNTDWN_OFFS_BEACON]),
> +	       sizeof(u16));

In the CSA case, this comes from the *inner* attributes. In your case,
it comes from the *outer*. IMHO that's super confusing.

> +	if (params.counter_offset_beacon >= params.beacon_color_change.tail_len)
> +		return -EINVAL;
> +
> +	if (params.beacon_color_change.tail[params.counter_offset_beacon] != params.count)
> +		return -EINVAL;
> +
> +	if (info->attrs[NL80211_ATTR_CNTDWN_OFFS_PRESP]) {
> +		params.counter_offset_presp =
> +			nla_get_u16(info->attrs[NL80211_ATTR_CNTDWN_OFFS_PRESP]);

same here.

In CSA this is also allowed to be an array - the parsing code probably
needs to be different because we currently don't validate the size/type
of this to be NLA_U16, just like you did above with the
NL80211_ATTR_CNTDWN_OFFS_BEACON.

johannes

