Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D97233455
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 16:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgG3O0r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 10:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgG3O0q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 10:26:46 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D8BC061574
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 07:26:46 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k19W9-00DZsD-4v; Thu, 30 Jul 2020 16:26:45 +0200
Message-ID: <350e8bd7bc1c892f1e28f0964de6618bb81edfc0.camel@sipsolutions.net>
Subject: Re: [PATCH V2 1/3] nl80211: add support for BSS coloring
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Thu, 30 Jul 2020 16:26:44 +0200
In-Reply-To: <20200706170616.1764626-1-john@phrozen.org>
References: <20200706170616.1764626-1-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-07-06 at 19:06 +0200, John Crispin wrote:
> 
> +/**
> + * struct cfg80211_cca_settings - color change settings
> + *
> + * Used for color change
> + *
> + * @beacon_cca: beacon data while performing the change
> + * @counter_offsets_beacon: offsets of the counters within the beacon (tail)
> + * @counter_offsets_presp: offsets of the counters within the probe response
> + * @beacon_after: beacon data to be used after the change
> + * @count: number of beacons until the change
> + * @color: the color that we will have after th change

typo: the change

>   * @WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK: The device supports bigger kek and kck keys
> + * @WIPHY_FLAG_SUPPORTS_BSS_COLOR: Device supports BSS coloring
>   */
>  enum wiphy_flags {
>  	WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK		= BIT(0),
> @@ -4198,6 +4224,7 @@ enum wiphy_flags {
>  	WIPHY_FLAG_SUPPORTS_5_10_MHZ		= BIT(22),
>  	WIPHY_FLAG_HAS_CHANNEL_SWITCH		= BIT(23),
>  	WIPHY_FLAG_HAS_STATIC_WEP		= BIT(24),
> +	WIPHY_FLAG_SUPPORTS_BSS_COLOR		= BIT(25),

That seems to belong into an entirely different patchset?

And probably should be an extended nl80211 feature?

> + * @NL80211_CMD_CCA_STARTED_NOTIFY: Notify userland, that we color change has
> + *	started
> + *
> + * @NL80211_CMD_CCA_ABORTED_NOTIFY: Notify userland, that we color change has
> + *	been aborted
> + *
> + * @NL80211_CMD_CCA_NOTIFY: Notify userland, that we color change has completed

s/userland,/userland/
s/we/the/

Btw, whoever came up with "CCA" as the acronym for this? if it's not in
the spec, can you change it? I can't not think "channel clear
assessment" ...

> + * @NL80211_ATTR_OBSS_COLOR_BITMAP: bitmap of the 64 BSS colors for the
> + *	%NL80211_CMD_OBSS_COLOR_COLLISION command.

u64 attribute then, presumably?

s/command/event/?

> + * @NL80211_ATTR_CCA_C_OFF_BEACON: An array of offsets (u16) to the color
> + *	switch counters in the beacons tail (%NL80211_ATTR_BEACON_TAIL).
> + * @NL80211_ATTR_CCA_C_OFF_PRESP: An array of offsets (u16) to the color
> + *	switch counters in the probe response (%NL80211_ATTR_PROBE_RESP).

I think we discussed this, and we're not going to support both CSA and
CCA at the same time, right?

So perhaps we can repurpose the CSA attributes, and even rename them by
leaving a "#define oldname newname" in nl80211.h. We've done that
before.

E.g. just NL80211_ATTR_CNTDWN_OFFS_PRESP or something like that?

> +	err = nla_parse_nested_deprecated(cca_attrs, NL80211_ATTR_MAX,
> +					  info->attrs[NL80211_ATTR_CCA_IES],
> +					  nl80211_policy, info->extack);

You shouldn't use the _deprecated function for new attributes.

And if this is nested, you should use NLA_POLICY_NESTED() in the policy.
You're now allowed to nest recursively (i.e. nest nl80211_policy into
its own nested attributes), but I'm a bit confused as to why you need
that and didn't move to use a new sub-enum? That'd save a ton of stack
space - in fact the "cca_attrs" array is probably big enough now to
cause stack size warnings immediately?

johannes

