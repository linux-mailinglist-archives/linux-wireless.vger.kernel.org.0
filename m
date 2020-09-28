Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0364527ADF0
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 14:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgI1Mg1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 08:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgI1Mg0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 08:36:26 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE985C061755
        for <linux-wireless@vger.kernel.org>; Mon, 28 Sep 2020 05:36:26 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kMsOC-00CTuA-Q6; Mon, 28 Sep 2020 14:36:20 +0200
Message-ID: <6649b0c2ff988c2ae8723ea633f86cc12da43d95.camel@sipsolutions.net>
Subject: Re: [RFC 1/2] nl80211: add common API to configure SAR power
 limitations.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Carl Huang <cjhuang@codeaurora.org>, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, briannorris@chromium.org,
        dianders@chromium.org
Date:   Mon, 28 Sep 2020 14:36:09 +0200
In-Reply-To: <1600753775-4745-1-git-send-email-cjhuang@codeaurora.org> (sfid-20200922_074952_776521_0528DF1D)
References: <1600753775-4745-1-git-send-email-cjhuang@codeaurora.org>
         (sfid-20200922_074952_776521_0528DF1D)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-09-22 at 13:49 +0800, Carl Huang wrote:
> NL80211_CMD_SET_SAR_SPECS is added to configure SAR from
> user space. NL80211_ATTR_SAR_SPEC is used to pass the SAR
> power specification when used with NL80211_CMD_SET_SAR_SPECS.
> 
> Wireless driver needs to register SAR type, supported frequency
> ranges to wiphy, so user space can query it. The index in
> frequency range is used to specify which sub band the power
> limitation applies to. The SAR type is for compatibility, so later
> other SAR mechanism can be implemented without breaking the user
> space SAR applications.
> 
> Normal process is user space quries the SAR capability, and

typo: queries

> gets the index of supported frequency ranges and associates the
> power limitation with this index and sends to kernel.
> 
> Here is an example of message send to kernel:
> 8c 00 00 00 08 00 03 00 15 00 00 00 38 00 26 81
> 08 00 01 00 00 00 00 00 2c 00 02 80 14 00 01 80
> 05 00 02 00 00 00 00 00 05 00 01 00 38 00 00 00
> 14 00 02 80 05 00 02 00 01 00 00 00 05 00 01 00
> 48 00 00 00

Heh, that's not super useful, though that doesn't matter much I guess :)

> NL80211_CMD_SET_SAR_SPECS:  0x8c
> NL80211_ATTR_SAR_SPEC:  0x8126 (NLA_NESTED)
> NL80211_SAR_ATTR_TYPE:  0x00 (NL80211_SAR_TYPE_POWER)
> NL80211_SAR_ATTR_SPECS: 0x8002 (NLA_NESTED)
> freq range 0 power: 0x38 in 0.25dbm unit (14dbm)
> freq range 1 power: 0x48 in 0.25dbm unit (18dbm)

that makes more sense :)

> +/**
> + * struct cfg80211_sar_sub_specs - sub specs limit
> + * @power: value in 0.25dbm

I guess the documentation should state that it's a power limit, or
something?

> + * @freq_range_index: index the power limitation applies to
> + */
> +struct cfg80211_sar_sub_specs {
> +	u8 power;
> +	u8 freq_range_index;
> +};
> +
> +/**
> + * struct cfg80211_sar_specs - sar limit specs
> + * @type: it's set with power in 0.25dbm or other types
> + * @num_sub_specs: number of sar sub specs
> + * @sub_specs: memory to hold the sar sub specs
> + */
> +struct cfg80211_sar_specs {
> +	enum nl80211_sar_type type;
> +	u16 num_sub_specs;
> +	struct cfg80211_sar_sub_specs *sub_specs;

Wouldn't it make more sense to just have sub_specs[] and inline? The
pointers here are bigger than many of the sub-specs I guess...

Also, is num_sub_specs even needed? It seems we could just require that
userspace sends all of them all the time?

> +struct cfg80211_sar_freq_ranges {
> +	u8 index;

Does an index here make sense?

> +	u32 start_freq;
> +	u32 end_freq;
> +};
> +
> +/**
> + * struct cfg80211_sar_capa - sar limit capability
> + * @type: it's set via power in 0.25dbm or other types
> + * @num_freq_ranges: number of frequency ranges
> + * @chan_ranges: memory to hold the channel ranges.
> + */
> +struct cfg80211_sar_capa {
> +	enum nl80211_sar_type type;
> +	u8 num_freq_ranges;
> +	const struct cfg80211_sar_freq_ranges *freq_ranges;

You end up with an array here, so some kind of index is implicit, the
array index. I don't see why you'd want to have a separate index
*within* the frequency range, then you just have to check those make
sense, etc.?

> + * @NL80211_ATTR_SAR_SPEC: SAR power limitation specification when
> + *	used with %NL80211_CMD_SET_SAR_SPECS. It contains array of
> + *	%nl80211_sar_specs_attrs.

I think I know what you mean (a nested array where each item has
attributes from &enum nl80211_sar_specs_attrs), but could state that a
bit clearer.

> +#define NL80211_SAR_ALL_FREQ_RNAGES	0xff

typo

> +#define NUM_MAX_NL80211_SAR_FREQ_RANGES 0xfe

but I'm not sure what these are used for in the first place, they seem
more like internal implementation details?

> +/**
> + * nl80211_sar_specs_attrs - Attributes for SAR power limit specs
> + *
> + * @NL80211_SAR_ATTR_SPECS_POWER: Required (u32)value to specify the actual
> + *	power limit value in units of 0.25 dBm if type is
> + *	NL80211_SAR_TYPE_POWER. (i.e., a value of 44 represents 11 dBm)
> + *
> + * @NL80211_SAR_ATTR_SPECS_FREQ_RANGES_INDEX: optional (u32) value to specify the
> + *	index of exported freq ranges table. If this attribute is not present, then
> + *	the power is applied to all freq ranges, i.e, all bands

Especially since this says "[i]f this attribute is not present".

Does that make sense though? It seems possible to just use the nesting
entry as the index, and just require userspace to set up all indexes if
it wants to apply to all of them, why bother having to deal with that
case in the kernel and perhaps even drivers?

> + * @NL80211_SAR_ATTR_SPECS_START_FREQ: Required (u32) value to specify the start
> + *	frequency of this range to register SAR capability to wihpy and the unit

typo: wiphy

> + *	is kHZ

kHz

> + *
> + * @NL80211_SAR_ATTR_SPECS_END_FREQ: Required (u32) value to specify the end frequency
> + *	of this range to register SAR capability to wiphy and the unit is kHZ

kHz

But hm, are you mixing the capability advertisement and the actual
request into the same attributes? Perhaps that makes sense, but the
documentation could be a bit clearer IMHO.

> +++ b/net/mac80211/cfg.c

The mac80211 bits could probably be in a separate patch, just for
clarity.

> +static const struct nla_policy
> +sar_specs_policy[NL80211_SAR_ATTR_SPECS_MAX + 1] = {
> +		[NL80211_SAR_ATTR_SPECS_POWER] = { .type = NLA_U8 },

double indentation?

> +		[NL80211_SAR_ATTR_SPECS_FREQ_RANGE_INDEX] =
> +			NLA_POLICY_MAX(NLA_U8, NUM_MAX_NL80211_SAR_FREQ_RANGES),

I don't see a good reason to limit to 0xfe? The kernel could just use a
wider datatype internally.

Anyway, I'm not sure the attribute is even needed, see above.

> @@ -1856,6 +1870,8 @@ static int nl80211_add_commands_unsplit(struct cfg80211_registered_device *rdev,
>  			goto nla_put_failure;
>  	}
>  
> +	CMD(set_sar_specs, SET_SAR_SPECS);

Don't add to _unsplit() please.

> +	specs = nla_nest_start_noflag(msg, NL80211_SAR_ATTR_SPECS);

Don't use _noflag() please, that's just for backward compatibility.

> +	if (!specs)
> +		goto fail;
> +
> +	/* report supported freq_ranges */
> +	for (i = 0; i < num_freq_ranges; i++) {
> +		sub_freq_range = nla_nest_start_noflag(msg, i + 1);

Same here.

> @@ -2598,6 +2663,9 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
>  		if (nl80211_put_tid_config_support(rdev, msg))
>  			goto nla_put_failure;
>  
> +		if (nl80211_put_sar_specs(rdev, msg))
> +			goto nla_put_failure;

Perhaps better to have a separate message (case entry) since it might
get fairly big?

> +	sar_spec = kzalloc(sizeof(*sar_spec) +
> +			   specs * sizeof(struct cfg80211_sar_sub_specs),
> +			   GFP_KERNEL);
> +	if (!sar_spec)
> +		return -ENOMEM;
> +
> +	sar_spec->sub_specs = (struct cfg80211_sar_sub_specs *)
> +			((char *)sar_spec + sizeof(*sar_spec));

If you anyway set the pointer there then you can actually just make it a
[] array instead of having the pointer in the first place ... would be
equivalent but save you from these contortions :)

> +	specs = 0;
> +	sar_spec->type = type;
> +
> +	nla_for_each_nested(spec_list, tb[NL80211_SAR_ATTR_SPECS], rem) {
> +		if (nla_parse(spec,
> +			      NL80211_SAR_ATTR_SPECS_MAX,
> +			      nla_data(spec_list),
> +			      nla_len(spec_list),
> +			      sar_specs_policy,
> +			      NULL)) {
> +			err = -EINVAL;
> +			goto error;
> +		}
> +
> +		/* for power type, power value must be presented */
> +		if (!spec[NL80211_SAR_ATTR_SPECS_POWER] &&
> +		    type == NL80211_SAR_TYPE_POWER) {
> +			err = -EINVAL;
> +			goto error;
> +		}

Somewhere you should probably also check that the type matches the
advertised type.

> +		power = nla_get_u8(spec[NL80211_SAR_ATTR_SPECS_POWER]);
> +		sar_spec->sub_specs[specs].power = power;
> +
> +		/* if NL80211_SAR_ATTR_SPECS_FREQ_RANGE_INDEX isn't present,
> +		 * then the power applies to all bands. But it's only valid
> +		 * for the first entry.
> +		 */
> +		if (!spec[NL80211_SAR_ATTR_SPECS_FREQ_RANGE_INDEX]) {
> +			if (specs) {
> +				err = -EINVAL;
> +				goto error;
> +			} else {
> +				sar_spec->sub_specs[specs].freq_range_index =
> +					NL80211_SAR_ALL_FREQ_RNAGES;
> +				specs++;
> +				break;
> +			}
> +		}

Yeah... not sure I see this as being worth it, vs. userspace just
filling all the possible entries.

> +		index = nla_get_u8(spec[NL80211_SAR_ATTR_SPECS_FREQ_RANGE_INDEX]);
> +		sar_spec->sub_specs[specs].freq_range_index = index;
> +		specs++;
> +	}
> +
> +	sar_spec->num_sub_specs = specs;
> +
> +	rdev->cur_cmd_info = info;
> +	if (rdev->ops->set_sar_specs)
> +		err = rdev_set_sar_specs(rdev, sar_spec);
> +	else
> +		err = -EOPNOTSUPP;

Might be worth checking this early and avoiding the allocation and all?

OTOH, that gives you error checking even if the driver was completely
confused and advertised sar specs without the method ...

johannes

