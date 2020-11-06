Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F982A941C
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 11:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgKFKZJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 05:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFKZJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 05:25:09 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A966C0613CF
        for <linux-wireless@vger.kernel.org>; Fri,  6 Nov 2020 02:25:09 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kayvX-002E06-RC; Fri, 06 Nov 2020 11:25:03 +0100
Message-ID: <64e072a168c12f58847a5ee16bfdb7e47576284f.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] nl80211: add common API to configure SAR power
 limitations.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Carl Huang <cjhuang@codeaurora.org>, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, briannorris@chromium.org,
        dianders@chromium.org, kuabhs@google.com
Date:   Fri, 06 Nov 2020 11:25:02 +0100
In-Reply-To: <20201106100708.4609-2-cjhuang@codeaurora.org> (sfid-20201106_110730_189162_E9D09205)
References: <20201106100708.4609-1-cjhuang@codeaurora.org>
         <20201106100708.4609-2-cjhuang@codeaurora.org>
         (sfid-20201106_110730_189162_E9D09205)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Looks pretty good. Some comments, mostly nits, below.


> +/**
> + * nl80211_sar_attrs - Attributes for SAR spec

missing enum

> + *
> + * @NL80211_SAR_ATTR_TYPE: the SAR type and it's defined in %nl80211_sar_type.

better use &enum nl80211_sar_type for a link in docs

> + *
> + * @NL80211_SAR_ATTR_SPECS: Nested array of SAR power
> + *	limit specifications. Each specification contains a set
> + *      of %nl80211_sar_specs_attrs.
> + *
> + *      For SET operation, it contains array of NL80211_SAR_ATTR_SPECS_POWER

some odd indent?

Usually we just use a single tab.

> +/**
> + * nl80211_sar_specs_attrs - Attributes for SAR power limit specs

again, enum missing

> + *
> + * @NL80211_SAR_ATTR_SPECS_POWER: Required (u32)value to specify the actual
> + *	power limit value in units of 0.25 dBm if type is
> + *	NL80211_SAR_TYPE_POWER. (i.e., a value of 44 represents 11 dBm).
> + *	0 means userspace doesn't have SAR limitation on this associated range.
> + *
> + * @NL80211_SAR_ATTR_SPECS_RANGE_INDEX: Required (u32) value to specify the
> + *	index of exported freq range table and the associated power limitation
> + *	is applied to this range.
> + *
> + *	Userspace isn't required to set all the ranges advertised by WLAN driver,
> + *	and userspace can skip some certain ranges. These skipped ranges don't
> + *	have SAR limitations, and these are same as setting the
> + *	%NL80211_SAR_ATTR_SPECS_POWER to 0. But it's required to set at least one range,
> + *	no matter the power limiation is 0 or not.

(typo - limitation)

Should "0" really be the magic value? Theoretically, 0 and even negative
values are valid. Perhaps we should just use something big (0xffffffff)
to indicate no limit, or just not have such a "no limitation" value
because userspace can always set it to something very big that means no
practical limitation anyway?

OK actually you have a U8 now so the high limit is 63.75dBm, but there's
not really a good reason for that, since U32 takes the same space in
netlink anyway.

And wait, I thought we agreed to remove the index? Now I'm confused.

And even if we do need the index, then perhaps we should use the
(otherwise anyway ignored) nla_type() of the container, instead of an
explicit inner attribute?

> + *
> + *	Every SET operation overwrites previous SET operation.
> + *
> + * @NL80211_SAR_ATTR_SPECS_START_FREQ: Required (u32) value to specify the start
> + *	frequency of this range edge when registering SAR capability to wiphy. It's
> + *	not a channel center frequency. The unit is KHz.

"kHz" not "KHz", in a few places other than this too

> +static int
> +nl80211_put_sar_specs(struct cfg80211_registered_device *rdev,
> +		      struct sk_buff *msg)
> +{
> +	struct nlattr *sar_capa, *specs, *sub_freq_range;
> +	u8  num_freq_ranges;

extra space?

> +	for (i = 0; i < num_freq_ranges; i++) {
> +		sub_freq_range = nla_nest_start(msg, i + 1);
> +
> +		nla_put_u32(msg, NL80211_SAR_ATTR_SPECS_START_FREQ,
> +			    rdev->wiphy.sar_capa->freq_ranges[i].start_freq);
> +
> +		nla_put_u32(msg, NL80211_SAR_ATTR_SPECS_END_FREQ,
> +			    rdev->wiphy.sar_capa->freq_ranges[i].end_freq);


Need to check the return values of these three calls.


And an aside, unrelated to this particular code: Should we do some kind
of validation that the ranges reported actually overlap all supported
channels (taking 20 MHz bandwidth into account)?

> +	nla_parse_nested(tb, NL80211_SAR_ATTR_MAX, info->attrs[NL80211_ATTR_SAR_SPEC],
> +			 sar_policy, info->extack);

If you're not checking the return value then no point in passing a
policy or extack :-)

And yes, it's already validated, so you don't have to do it again.

> +	sar_spec->type = type;
> +	specs = 0;
> +	nla_for_each_nested(spec_list, tb[NL80211_SAR_ATTR_SPECS], rem) {
> +		if (nla_parse(spec,
> +			      NL80211_SAR_ATTR_SPECS_MAX,
> +			      nla_data(spec_list),
> +			      nla_len(spec_list),
> +			      sar_specs_policy,
> +			      NULL)) {

Similar here, don't really need to validate it since it's done by the
policy.

> +			err = -EINVAL;
> +			goto error;
> +		}
> +
> +		/* for power type, power value and index must be presented */
> +		if ((!spec[NL80211_SAR_ATTR_SPECS_POWER] ||
> +		     !spec[NL80211_SAR_ATTR_SPECS_RANGE_INDEX]) &&
> +		    type == NL80211_SAR_TYPE_POWER) {

maybe "switch (type) {...}" or something and return -EINVAL also if it's
a type not supported in the code yet, i.e. default case?

Otherwise we might add a type, and forget this pretty easily.

> +			err = -EINVAL;
> +			goto error;
> +		}
> +
> +		power = nla_get_u8(spec[NL80211_SAR_ATTR_SPECS_POWER]);
> +		sar_spec->sub_specs[specs].power = power;

and that probably should then be in a sub function or something also
inside the particular type.

or maybe just all in a separate function? dunno. not really _necessary_,
but the lines are getting kinda long already, and one more indentation
level with the switch won't help ...

johannes

