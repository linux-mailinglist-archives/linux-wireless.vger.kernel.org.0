Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E5525458A
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 14:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgH0M7R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 08:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgH0M7N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 08:59:13 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D90DC061264
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 05:58:55 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kBHUT-00Bb1B-PY; Thu, 27 Aug 2020 14:58:53 +0200
Message-ID: <6a4fa0a60089bb1565def2bca187b9c0afc36022.camel@sipsolutions.net>
Subject: Re: [PATCH V3 1/9] nl80211: add basic multiple bssid support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Thu, 27 Aug 2020 14:58:52 +0200
In-Reply-To: <20200812150050.2683396-2-john@phrozen.org>
References: <20200812150050.2683396-1-john@phrozen.org>
         <20200812150050.2683396-2-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-08-12 at 17:00 +0200, John Crispin wrote:
> This patch adds support for passing the multiple bssid config to the
> kernel when adding an interface. If the BSS is non-transmitting it needs
> to be indicated. A non-transmitting BSSID will have a parent interface,
> which needs to be transmitting. The multiple bssid elements are passed
> as an array.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  include/net/cfg80211.h       | 35 +++++++++++++++++++++++++++++++
>  include/uapi/linux/nl80211.h | 22 ++++++++++++++++++++
>  net/wireless/nl80211.c       | 40 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 97 insertions(+)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 541dea0fd571..0b0c730dc8d2 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -470,6 +470,21 @@ struct ieee80211_supported_band {
>  	const struct ieee80211_sband_iftype_data *iftype_data;
>  };
>  
> +/**
> + * struct ieee80211_multiple_bssid - AP settings for multi bssid
> + *
> + * @index: the index of this AP in the multi bssid group.
> + * @count: the total number of multi bssid peer APs.
> + * @parent: a non-transmitted bssid has a transmitted parent

It obviously has a parent, but what does this u32 value mean?

> +/**
> + * struct cfg80211_multiple_bssid_data - multiple_bssid data
> + * @ies: array of extra information element(s) to add into Beacon frames for multiple
> + *	bssid or %NULL
> + * @len: array of lengths of multiple_bssid.ies in octets
> + * @cnt: number of entries in multiple_bssid.ies
> + */
> +struct cfg80211_multiple_bssid_data {
> +	u8 *ies[NL80211_MULTIPLE_BSSID_IES_MAX];
> +	size_t len[NL80211_MULTIPLE_BSSID_IES_MAX];

This is all pretty much dynamic - why have the hard-coded limitation?
Wouldn't it be only marginally harder to do

struct ... {
	int cnt;
	struct {
		const u8 *ies;
		size_t len;
	} data[];
};

and size it dynamically?

And have the driver advertise some kind of limit, I guess.

In fact, even with the patch as is, what if a driver only can do 4 not
8... Or what if your driver can do 8, but the next driver comes along
and has to bump it to 16, then your current driver will be a mess.

> + * @NL80211_ATTR_MULTIPLE_BSSID_PARENT: If this is a Non-Transmitted BSSID, define
> + *	the parent (transmitting) interface.

By what? interface index?

> @@ -662,6 +662,11 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
>         [NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_COUNT] = { .type = NLA_U8 },
>         [NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_COLOR] = { .type = NLA_U8 },
>         [NL80211_ATTR_COLOR_CHANGE_ANNOUNCEMENT_IES] = NLA_POLICY_NESTED(nl80211_policy),
> +       [NL80211_ATTR_MULTIPLE_BSSID_NON_TRANSMITTING] = { .type = NLA_FLAG },
> +       [NL80211_ATTR_MULTIPLE_BSSID_PARENT] = { .type = NLA_U32 },
> +       [NL80211_ATTR_MULTIPLE_BSSID_INDEX] = { .type = NLA_U8 },
> +       [NL80211_ATTR_MULTIPLE_BSSID_COUNT] = { .type = NLA_U8 },
> +       [NL80211_ATTR_MULTIPLE_BSSID_IES] = { .type = NLA_NESTED },

Maybe those should all go into a single top-level attribute with their
own nested policy? Or maybe not, I'm certainly willing to entertain
arguments eitherway.

What's the point of BSSID_COUNT by the way, you can count based on the
number of elements in the BSSID_IES array, no?


Actually, I don't understand this API at all. This is being set on a
single virtual interface. Clearly, you need a new interface for every
BSSID, transmitting or not. So why can you have many things set on a
single interface? And why do you need a count, if you know the number of
interfaces you have?


> +	if (info->attrs[NL80211_ATTR_MULTIPLE_BSSID_PARENT])
> +		params.multiple_bssid.parent =
> +			nla_get_u8(info->attrs[NL80211_ATTR_MULTIPLE_BSSID_PARENT]);


As Aloka also pointed out, this must be nla_get_u32().

But I don't really like passing that down - if it's an interface index
then resolve it here and pass a pointer.

If it's something else, please document it clearly.

Thanks,
johannes


