Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB273B1E27
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jun 2021 17:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhFWP6F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Jun 2021 11:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhFWP6E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Jun 2021 11:58:04 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A780C061574
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jun 2021 08:55:47 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lw5E3-00AcKs-Jd; Wed, 23 Jun 2021 17:55:39 +0200
Message-ID: <6c0cec1a254ba488cd807e6a26609592d2109071.camel@sipsolutions.net>
Subject: Re: [PATCH v10 1/4] nl80211: multiple bssid and EMA support in AP
 mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Wed, 23 Jun 2021 17:55:38 +0200
In-Reply-To: <20210426190534.12667-2-alokad@codeaurora.org>
References: <20210426190534.12667-1-alokad@codeaurora.org>
         <20210426190534.12667-2-alokad@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Aloka,

Sorry for the long delay.

> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Please drop those, you can list them in the version annotations, but
they didn't really report the feature or something :)


> + * @mbssid.max_interfaces: maximum number of interfaces supported by the driver
> + *	in a multiple BSSID set that can ben configured using
> + *	%NL80211_MBSSID_CONFIG_ATTR_COUNT.

I don't quite understand why you need this as well as
NL80211_EXT_FEATURE_MBSSID_AP? Isn't it quite clear that if you have
mbssid.max_interfaces then it must support MBSSID_AP, and vice versa?

Also, I don't think I am happy with the code that lets you advertise
NL80211_EXT_FEATURE_MBSSID_AP and not have a max_interfaces, and then
the kernel just accepts an arbitrary number - if that's the case, why
bother advertising max_interfaces at all?

IOW, I think you should drop NL80211_EXT_FEATURE_MBSSID_AP and force
having max_interfaces.


> +/**
> + * enum nl80211_mbssid_config_attributes - Attributes to configure/advertise
> + *	multiple BSSID and enhanced multi-BSSID advertisements in AP mode.
> + *
> + * @__NL80211_MBSSID_CONFIG_ATTR_INVALID: Invalid
> + *
> + * @NL80211_MBSSID_CONFIG_ATTR_PARENT: For a non-transmitted BSSID, this
> + *	attribute provides the interface index (u32) of the transmitted profile.
> + *	Must match one of the interface indices advertised by the kernel.
> + *	Mandatory parameter for non-transmitting interfaces, ignored for the
> + *	transmitting interface.
> + *
> + * @NL80211_MBSSID_CONFIG_ATTR_COUNT: Total number of BSSs (u8) in the
> + *	multiple BSSID set. Mandatory attribute with minimum value of 1.


I have a feeling we've discussed this before and I just forgot - but why
do we need the count at all? Shouldn't that be obvious by the various
values of ..._CONFIG_ATTR_INDEX?

What happens if you call it with

 * index=1, count=3
 * index=2, count=3
 * index=3, count=4

for three non-transmitting interfaces? That would cause ... issues?

But that sort of means the drivers cannot rely on the 'count' anyway,
unless it's somehow only set up on the *first* (transmitting) interface,
or something like that, and then validated later? But that means
cfg80211 cannot do the validation, and so what's the point?

What is it needed for anyway? Couldn't you just take the maximum index
plus 1 as the count? Somehow we've got to be keeping track of all of
that anyhow.

Perhaps we should actually do _more_ tracking in cfg80211 and link it to
the parent, and then track that the index space is allocated
contiguously?

Also, regarding the count, what if you never reach it, because you only
configure

 * index=1, count=4
 * index=2, count=4

and that's it - seems like the count thing just causes confusion and
tracking it internally makes more sense?

mac80211 also never even uses the count, afaict.


> + * @NL80211_MBSSID_CONFIG_ATTR_INDEX: The index of this BSS (u8) in the
> + *	multiple BSSID set. Mandatory parameter for non-transmitting interfaces,
> + *	ignored for the transmitting interface.
> + *	Range: 1 to %NL80211_MBSSID_CONFIG_ATTR_COUNT-1.

0 is for the transmitting interface then?

> + * @NL80211_MBSSID_CONFIG_ATTR_EMA: Userspace and the drivers should use this
> + *	flag to indicate if enhanced multi-BSSID advertisements (EMA AP) feature
> + *	is supported/enabled. When set, beacons are generated as per EMA rules,
> + *	see %nl80211_mbssid_elems_attributes for details. Drivers must set
> + *	NL80211_EXT_FEATURE_EMA_AP for this flag to be used.


I guess 'used' -> 'permitted' or something.


> + * @NL80211_MBSSID_ELEMS_ATTR_COUNT: Number of multiple BSSID elements (u8).
> + *	This attribute is also used to advertise the maximum profile periodicity
> + *	supported by the driver if EMA is enabled.
This one I see even less value in than the count above - isn't that
simply counting the number of entries in ...MBSSID_ELEMS_ATTR_DATA?

FWIW, your code is also quite happy to let userspace crash the kernel if
it specifies _COUNT=1 and then has 100 entries in _DATA, as far as I can
tell.

Again, I think you should remove this and just count the entries in
..._ATTR_DATA first.

> +static const struct nla_policy
> +nl80211_mbssid_elems_policy[NL80211_MBSSID_ELEMS_ATTR_MAX + 1] = {
> +	[NL80211_MBSSID_ELEMS_ATTR_COUNT] = { .type = NLA_U8 },
> +	[NL80211_MBSSID_ELEMS_ATTR_DATA] = { .type = NLA_NESTED },

Some of this could be more explicit, e.g. if we keep COUNT despite the
discussion above, the policy should specify a min value of 1.

Same is probably true elsewhere.


> +static int nl80211_put_mbssid_support(struct wiphy *wiphy,
> +				      struct sk_buff *msg)
> +{
> +	struct nlattr *config = NULL, *elems = NULL;

You don't need that - you can move those into the ifs

> +fail:
> +	if (elems)
> +		nla_nest_cancel(msg, elems);
> +	if (config)
> +		nla_nest_cancel(msg, config);

because you don't need that

> +static int nl80211_parse_mbssid_config(struct wiphy *wiphy,
> +				       struct net_device *dev,
> +				       struct nlattr *attrs, u8 num_elems,
> +				       struct cfg80211_mbssid_config *config)
> +{
> +	struct nlattr *tb[NL80211_MBSSID_CONFIG_ATTR_MAX + 1];
> +	struct net_device *parent;
> +
> +	if (!wiphy_ext_feature_isset(wiphy, NL80211_EXT_FEATURE_MBSSID_AP))
> +		return -EOPNOTSUPP;
> +
> +	if (nla_parse_nested(tb, NL80211_MBSSID_CONFIG_ATTR_MAX, attrs, NULL,
> +			     NULL) || !tb[NL80211_MBSSID_CONFIG_ATTR_COUNT])

please reformat

> +		return -EINVAL;
> +
> +	config->ema = nla_get_flag(tb[NL80211_MBSSID_CONFIG_ATTR_EMA]);
> +	if (config->ema) {
> +		if (!wiphy_ext_feature_isset(wiphy, NL80211_EXT_FEATURE_EMA_AP))
> +			return -EOPNOTSUPP;
> +
> +		/* nl80211_parse_mbssid_elems() sets this value */
> +		if (!num_elems || (wiphy->mbssid.max_periodicity &&
> +				   num_elems > wiphy->mbssid.max_periodicity))

the !num_elems check should be moved to the policy, and I think
mbssid.max_periodicity should be required

> +	config->count = nla_get_u8(tb[NL80211_MBSSID_CONFIG_ATTR_COUNT]);
> +	if (!config->count || (wiphy->mbssid.max_interfaces &&
> +			       config->count > wiphy->mbssid.max_interfaces))
> +		return -EINVAL;

same with max_interfaces imho.

> +
> +	if (tb[NL80211_MBSSID_CONFIG_ATTR_PARENT]) {
> +		config->parent = nla_get_u32(tb[NL80211_MBSSID_CONFIG_ATTR_PARENT]);
> +		parent = __dev_get_by_index(wiphy_net(wiphy), config->parent);
> +		if (!parent || !parent->ieee80211_ptr)
> +			return -EINVAL;
> +
> +		if (parent == dev)
> +			config->parent = 0;
> +	}
> +
> +	if (tb[NL80211_MBSSID_CONFIG_ATTR_INDEX] && config->parent) {
> +		config->index = nla_get_u8(tb[NL80211_MBSSID_CONFIG_ATTR_INDEX]);
> +		if (!config->index || config->index >= config->count)

policy check for the index please

> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct cfg80211_mbssid_elems *
> +nl80211_parse_mbssid_elems(struct wiphy *wiphy, struct nlattr *attrs)
> +{
> +	struct nlattr *nl_elems, *tb[NL80211_MBSSID_ELEMS_ATTR_MAX + 1];
> +	struct cfg80211_mbssid_elems *elems = NULL;
> +	int rem_elems;
> +	u8 i = 0, num_elems;
> +
> +	if (!wiphy_ext_feature_isset(wiphy, NL80211_EXT_FEATURE_MBSSID_AP))
> +		return NULL;
> +
> +	if (nla_parse_nested(tb, NL80211_MBSSID_ELEMS_ATTR_MAX, attrs, NULL,
> +			     NULL) ||
> +	    !tb[NL80211_MBSSID_ELEMS_ATTR_COUNT] ||
> +	    !tb[NL80211_MBSSID_ELEMS_ATTR_DATA])
> +		return NULL;
> +
> +	num_elems = nla_get_u8(tb[NL80211_MBSSID_ELEMS_ATTR_COUNT]);
> +	if (!num_elems)
> +		return NULL;
> +
> +	elems = kzalloc(struct_size(elems, elem, num_elems), GFP_KERNEL);
> +	if (!elems)
> +		return NULL;
> +
> +	elems->cnt = num_elems;
> +	nla_for_each_nested(nl_elems, tb[NL80211_MBSSID_ELEMS_ATTR_DATA],
> +			    rem_elems) {

This is the bug I was talking about - num_elems can be much less than
the actual number of elements in here.

johannes

