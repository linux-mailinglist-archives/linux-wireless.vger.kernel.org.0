Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9D32A5FD1
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 09:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgKDIor (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 03:44:47 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:60759 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbgKDIor (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 03:44:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604479485; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Dew3SIbuHkUlTA5jTaFp/8Zyx60Z8M8viQuMX8cH34c=;
 b=Ktff3Ex4XOA9w8IszBXtEw/w424OApdIPyAA8sD+oU60bt879lRuESFxK7N3AWFFe7UYHOuF
 t8mbI+XFZplR5nOYMDyz/+wrxeTh5A09YhZ1a5HohUUAFxueNBsx1VW8WIVi72CnVPHmEDVR
 GTYi9daH7fRLm1T6vE+cgLG7ZV8=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5fa269e1b64b1c5b785852b2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 04 Nov 2020 08:44:17
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6BCDAC433CB; Wed,  4 Nov 2020 08:44:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 32DF7C433C6;
        Wed,  4 Nov 2020 08:44:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 04 Nov 2020 16:44:15 +0800
From:   Carl Huang <cjhuang@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        briannorris@chromium.org, dianders@chromium.org
Subject: Re: [RFC 1/2] nl80211: add common API to configure SAR power
 limitations.
In-Reply-To: <6649b0c2ff988c2ae8723ea633f86cc12da43d95.camel@sipsolutions.net>
References: <1600753775-4745-1-git-send-email-cjhuang@codeaurora.org>
 (sfid-20200922_074952_776521_0528DF1D)
 <6649b0c2ff988c2ae8723ea633f86cc12da43d95.camel@sipsolutions.net>
Message-ID: <d424aa0e80ac55e511ddb33b41d40fea@codeaurora.org>
X-Sender: cjhuang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-28 20:36, Johannes Berg wrote:
> On Tue, 2020-09-22 at 13:49 +0800, Carl Huang wrote:
>> NL80211_CMD_SET_SAR_SPECS is added to configure SAR from
>> user space. NL80211_ATTR_SAR_SPEC is used to pass the SAR
>> power specification when used with NL80211_CMD_SET_SAR_SPECS.
>> 
>> Wireless driver needs to register SAR type, supported frequency
>> ranges to wiphy, so user space can query it. The index in
>> frequency range is used to specify which sub band the power
>> limitation applies to. The SAR type is for compatibility, so later
>> other SAR mechanism can be implemented without breaking the user
>> space SAR applications.
>> 
>> Normal process is user space quries the SAR capability, and
> 
> typo: queries
> 
sure, I'll fix it in v2.

>> gets the index of supported frequency ranges and associates the
>> power limitation with this index and sends to kernel.
>> 
>> Here is an example of message send to kernel:
>> 8c 00 00 00 08 00 03 00 15 00 00 00 38 00 26 81
>> 08 00 01 00 00 00 00 00 2c 00 02 80 14 00 01 80
>> 05 00 02 00 00 00 00 00 05 00 01 00 38 00 00 00
>> 14 00 02 80 05 00 02 00 01 00 00 00 05 00 01 00
>> 48 00 00 00
> 
> Heh, that's not super useful, though that doesn't matter much I guess 
> :)
> 
>> NL80211_CMD_SET_SAR_SPECS:  0x8c
>> NL80211_ATTR_SAR_SPEC:  0x8126 (NLA_NESTED)
>> NL80211_SAR_ATTR_TYPE:  0x00 (NL80211_SAR_TYPE_POWER)
>> NL80211_SAR_ATTR_SPECS: 0x8002 (NLA_NESTED)
>> freq range 0 power: 0x38 in 0.25dbm unit (14dbm)
>> freq range 1 power: 0x48 in 0.25dbm unit (18dbm)
> 
> that makes more sense :)
> 
As this is an explanation of the message above, is it good to keep the 
message?

>> +/**
>> + * struct cfg80211_sar_sub_specs - sub specs limit
>> + * @power: value in 0.25dbm
> 
> I guess the documentation should state that it's a power limit, or
> something?
> 
>> + * @freq_range_index: index the power limitation applies to
>> + */
>> +struct cfg80211_sar_sub_specs {
>> +	u8 power;
>> +	u8 freq_range_index;
>> +};
>> +
>> +/**
>> + * struct cfg80211_sar_specs - sar limit specs
>> + * @type: it's set with power in 0.25dbm or other types
>> + * @num_sub_specs: number of sar sub specs
>> + * @sub_specs: memory to hold the sar sub specs
>> + */
>> +struct cfg80211_sar_specs {
>> +	enum nl80211_sar_type type;
>> +	u16 num_sub_specs;
>> +	struct cfg80211_sar_sub_specs *sub_specs;
> 
> Wouldn't it make more sense to just have sub_specs[] and inline? The
> pointers here are bigger than many of the sub-specs I guess...
> 
> Also, is num_sub_specs even needed? It seems we could just require that
> userspace sends all of them all the time?
> 
Agree as long as user space sends all of them.

>> +struct cfg80211_sar_freq_ranges {
>> +	u8 index;
> 
> Does an index here make sense?
> 
With agreement from Google, it's OK to remove it.

>> +	u32 start_freq;
>> +	u32 end_freq;
>> +};
>> +
>> +/**
>> + * struct cfg80211_sar_capa - sar limit capability
>> + * @type: it's set via power in 0.25dbm or other types
>> + * @num_freq_ranges: number of frequency ranges
>> + * @chan_ranges: memory to hold the channel ranges.
>> + */
>> +struct cfg80211_sar_capa {
>> +	enum nl80211_sar_type type;
>> +	u8 num_freq_ranges;
>> +	const struct cfg80211_sar_freq_ranges *freq_ranges;
> 
> You end up with an array here, so some kind of index is implicit, the
> array index. I don't see why you'd want to have a separate index
> *within* the frequency range, then you just have to check those make
> sense, etc.?
> 
>> + * @NL80211_ATTR_SAR_SPEC: SAR power limitation specification when
>> + *	used with %NL80211_CMD_SET_SAR_SPECS. It contains array of
>> + *	%nl80211_sar_specs_attrs.
> 
> I think I know what you mean (a nested array where each item has
> attributes from &enum nl80211_sar_specs_attrs), but could state that a
> bit clearer.
> 

I'll try to describe it more clear in v2.

>> +#define NL80211_SAR_ALL_FREQ_RNAGES	0xff
> 
> typo
> 
sure, will fix in v2.

>> +#define NUM_MAX_NL80211_SAR_FREQ_RANGES 0xfe
> 
> but I'm not sure what these are used for in the first place, they seem
> more like internal implementation details?
> 
In v1 design, userspace doesn't need to specify all the sub bands if the 
a power
limitation applies to all sub bands, so NL80211_SAR_ALL_FREQ_RNAGES is 
defined
for this purpose. To distinguish from NL80211_SAR_ALL_FREQ_RNAGES, the 
maximum
number of freq ranges should not exceed  (NL80211_SAR_ALL_FREQ_RNAGES - 
1), so
define NUM_MAX_NL80211_SAR_FREQ_RANGES as 0xfe.

It's right these two definitions are internal, userspace doesn't use 
them.

Again as user-space will sends all the ranges, let me remove these 2 
definitions.

>> +/**
>> + * nl80211_sar_specs_attrs - Attributes for SAR power limit specs
>> + *
>> + * @NL80211_SAR_ATTR_SPECS_POWER: Required (u32)value to specify the 
>> actual
>> + *	power limit value in units of 0.25 dBm if type is
>> + *	NL80211_SAR_TYPE_POWER. (i.e., a value of 44 represents 11 dBm)
>> + *
>> + * @NL80211_SAR_ATTR_SPECS_FREQ_RANGES_INDEX: optional (u32) value to 
>> specify the
>> + *	index of exported freq ranges table. If this attribute is not 
>> present, then
>> + *	the power is applied to all freq ranges, i.e, all bands
> 
> Especially since this says "[i]f this attribute is not present".
> 
> Does that make sense though? It seems possible to just use the nesting
> entry as the index, and just require userspace to set up all indexes if
> it wants to apply to all of them, why bother having to deal with that
> case in the kernel and perhaps even drivers?
> 

Ok, let me drop it in v2.

Johannes, want to confirm with you "nesting entry as the index". Do you 
mean that kernel
take the first entry as index 0, then second entry as index 1 and etc?


>> + * @NL80211_SAR_ATTR_SPECS_START_FREQ: Required (u32) value to 
>> specify the start
>> + *	frequency of this range to register SAR capability to wihpy and 
>> the unit
> 
> typo: wiphy
> 
>> + *	is kHZ
> 
> kHz
> 
Will fix it in v2.

>> + *
>> + * @NL80211_SAR_ATTR_SPECS_END_FREQ: Required (u32) value to specify 
>> the end frequency
>> + *	of this range to register SAR capability to wiphy and the unit is 
>> kHZ
> 
> kHz
> 
> But hm, are you mixing the capability advertisement and the actual
> request into the same attributes? Perhaps that makes sense, but the
> documentation could be a bit clearer IMHO.
> 
>> +++ b/net/mac80211/cfg.c
> 
> The mac80211 bits could probably be in a separate patch, just for
> clarity.
> 
>> +static const struct nla_policy
>> +sar_specs_policy[NL80211_SAR_ATTR_SPECS_MAX + 1] = {
>> +		[NL80211_SAR_ATTR_SPECS_POWER] = { .type = NLA_U8 },
> 
> double indentation?
> 
>> +		[NL80211_SAR_ATTR_SPECS_FREQ_RANGE_INDEX] =
>> +			NLA_POLICY_MAX(NLA_U8, NUM_MAX_NL80211_SAR_FREQ_RANGES),
> 
> I don't see a good reason to limit to 0xfe? The kernel could just use a
> wider datatype internally.
> 
> Anyway, I'm not sure the attribute is even needed, see above.
> 
If userspace has to sends all the sub bands, then
NL80211_SAR_ALL_FREQ_RNAGES is not required, and therefore 
NUM_MAX_NL80211_SAR_FREQ_RANGES
is also not required.

I'll delete these 2 definitions, and change policy to { .type = NLA_U8 }

>> @@ -1856,6 +1870,8 @@ static int nl80211_add_commands_unsplit(struct 
>> cfg80211_registered_device *rdev,
>>  			goto nla_put_failure;
>>  	}
>> 
>> +	CMD(set_sar_specs, SET_SAR_SPECS);
> 
> Don't add to _unsplit() please.
> 
Do you mean add it to below block?
if (state->split) {
...
CMD(set_sar_specs, SET_SAR_SPECS);
}


>> +	specs = nla_nest_start_noflag(msg, NL80211_SAR_ATTR_SPECS);
> 
> Don't use _noflag() please, that's just for backward compatibility.
> 
sure.

>> +	if (!specs)
>> +		goto fail;
>> +
>> +	/* report supported freq_ranges */
>> +	for (i = 0; i < num_freq_ranges; i++) {
>> +		sub_freq_range = nla_nest_start_noflag(msg, i + 1);
> 
> Same here.
> 
>> @@ -2598,6 +2663,9 @@ static int nl80211_send_wiphy(struct 
>> cfg80211_registered_device *rdev,
>>  		if (nl80211_put_tid_config_support(rdev, msg))
>>  			goto nla_put_failure;
>> 
>> +		if (nl80211_put_sar_specs(rdev, msg))
>> +			goto nla_put_failure;
> 
> Perhaps better to have a separate message (case entry) since it might
> get fairly big?
> 
>> +	sar_spec = kzalloc(sizeof(*sar_spec) +
>> +			   specs * sizeof(struct cfg80211_sar_sub_specs),
>> +			   GFP_KERNEL);
>> +	if (!sar_spec)
>> +		return -ENOMEM;
>> +
>> +	sar_spec->sub_specs = (struct cfg80211_sar_sub_specs *)
>> +			((char *)sar_spec + sizeof(*sar_spec));
> 
> If you anyway set the pointer there then you can actually just make it 
> a
> [] array instead of having the pointer in the first place ... would be
> equivalent but save you from these contortions :)
> 
Right.

>> +	specs = 0;
>> +	sar_spec->type = type;
>> +
>> +	nla_for_each_nested(spec_list, tb[NL80211_SAR_ATTR_SPECS], rem) {
>> +		if (nla_parse(spec,
>> +			      NL80211_SAR_ATTR_SPECS_MAX,
>> +			      nla_data(spec_list),
>> +			      nla_len(spec_list),
>> +			      sar_specs_policy,
>> +			      NULL)) {
>> +			err = -EINVAL;
>> +			goto error;
>> +		}
>> +
>> +		/* for power type, power value must be presented */
>> +		if (!spec[NL80211_SAR_ATTR_SPECS_POWER] &&
>> +		    type == NL80211_SAR_TYPE_POWER) {
>> +			err = -EINVAL;
>> +			goto error;
>> +		}
> 
> Somewhere you should probably also check that the type matches the
> advertised type.
> 
Agree.

>> +		power = nla_get_u8(spec[NL80211_SAR_ATTR_SPECS_POWER]);
>> +		sar_spec->sub_specs[specs].power = power;
>> +
>> +		/* if NL80211_SAR_ATTR_SPECS_FREQ_RANGE_INDEX isn't present,
>> +		 * then the power applies to all bands. But it's only valid
>> +		 * for the first entry.
>> +		 */
>> +		if (!spec[NL80211_SAR_ATTR_SPECS_FREQ_RANGE_INDEX]) {
>> +			if (specs) {
>> +				err = -EINVAL;
>> +				goto error;
>> +			} else {
>> +				sar_spec->sub_specs[specs].freq_range_index =
>> +					NL80211_SAR_ALL_FREQ_RNAGES;
>> +				specs++;
>> +				break;
>> +			}
>> +		}
> 
> Yeah... not sure I see this as being worth it, vs. userspace just
> filling all the possible entries.
> 
Yes, let me remove this logic in v2.

>> +		index = nla_get_u8(spec[NL80211_SAR_ATTR_SPECS_FREQ_RANGE_INDEX]);
>> +		sar_spec->sub_specs[specs].freq_range_index = index;
>> +		specs++;
>> +	}
>> +
>> +	sar_spec->num_sub_specs = specs;
>> +
>> +	rdev->cur_cmd_info = info;
>> +	if (rdev->ops->set_sar_specs)
>> +		err = rdev_set_sar_specs(rdev, sar_spec);
>> +	else
>> +		err = -EOPNOTSUPP;
> 
> Might be worth checking this early and avoiding the allocation and all?
> 
> OTOH, that gives you error checking even if the driver was completely
> confused and advertised sar specs without the method ...
> 
Here, it checks whether mac80211 layer implements the function. It's 
ieee80211_set_sar_specs
to check whether driver has implemented set_sar function.

I'll move the check to the beginning of this function.

> johannes
