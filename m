Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D829D2A9272
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 10:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgKFJYk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 04:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgKFJYk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 04:24:40 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2437CC0613CF
        for <linux-wireless@vger.kernel.org>; Fri,  6 Nov 2020 01:24:40 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kaxz4-002CEG-A6; Fri, 06 Nov 2020 10:24:38 +0100
Message-ID: <aea6777ee2f588cf8df26c416ec0cdb2399ff8cf.camel@sipsolutions.net>
Subject: Re: [PATCH V5 1/4] nl80211: add basic multiple bssid support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Date:   Fri, 06 Nov 2020 10:24:37 +0100
In-Reply-To: <20201103091743.1924854-2-john@phrozen.org>
References: <20201103091743.1924854-1-john@phrozen.org>
         <20201103091743.1924854-2-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-11-03 at 10:17 +0100, John Crispin wrote:

> +/**
> + * struct ieee80211_multiple_bssid - AP settings for multi bssid
> + *
> + * @index: the index of this AP in the multi bssid group.
> + * @count: the total number of multi bssid peer APs.
> + * @parent: non-transmitted BSSs transmitted parents index
> + * @ema: Shall the beacons be sent out in EMA mode.
> + */
> +struct ieee80211_multiple_bssid {
> +       u8 index;
> +       u8 count;
> +       u32 parent;
> +       bool ema;
> +};
> +

Why is that ieee80211_ rather than cfg80211_? We've often (mostly?)
reserved that for spec structs.

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
> +	int cnt;
> +};

Not sure if this is dynamically allocated but if now we could, and then
we can make that

struct ... {
	unsigned int cnt;
	struct {
		const u8 *data;
		size_t len;
	} elems[];
};

and get rid of NL80211_MULTIPLE_BSSID_IES_MAX.

> @@ -1072,6 +1101,8 @@ struct cfg80211_beacon_data {
>  	size_t probe_resp_len;
>  	size_t lci_len;
>  	size_t civicloc_len;
> +
> +	struct cfg80211_multiple_bssid_data multiple_bssid;

OK, so it's not (right now), but could even be embedded as the
dynamically sized struct here at the end ...

Or maybe keep some for the common case? But I don't think there's any
general limit of 8, so I'm not convinced it makes sense to have such a
(somewhat artificial) limit in nl80211.

> + * @NL80211_ATTR_MULTIPLE_BSSID_PARENT: If this is a Non-Transmitted BSSID, define
> + *	the parent (transmitting) interface.

by what, interface index? wdev id?

> + * @NL80211_ATTR_MULTIPLE_BSSID_INDEX: The index of this BSS inside the multi bssid
> + *	element.
> + *
> + * @NL80211_ATTR_MULTIPLE_BSSID_COUNT: The number of BSSs inside the multi bssid element.
> + *
> + * @NL80211_ATTR_MULTIPLE_BSSID_IES: The Elements that describe our multiple BSS group.

Might be better called "ELEMS" or something now, since "IE" is no longer
used in the spec.

> + *	these get passed separately as the kernel might need to split them up for EMA VAP.
> + *
> + * @NL80211_ATTR_MULTIPLE_BSSID_EMA: Shall the multiple BSS beacons be sent out in EMA mode.


Probably should describe the formats a bit - U32, nested with..., flag,
etc.

> +++ b/net/wireless/nl80211.c
> @@ -715,6 +715,11 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
>  		NLA_POLICY_EXACT_LEN(IEEE80211_S1G_CAPABILITY_LEN),
>  	[NL80211_ATTR_S1G_CAPABILITY_MASK] =
>  		NLA_POLICY_EXACT_LEN(IEEE80211_S1G_CAPABILITY_LEN),
> +	[NL80211_ATTR_MULTIPLE_BSSID_PARENT] = { .type = NLA_U32 },
> +	[NL80211_ATTR_MULTIPLE_BSSID_INDEX] = { .type = NLA_U8 },
> +	[NL80211_ATTR_MULTIPLE_BSSID_COUNT] = NLA_POLICY_RANGE(NLA_U8, 1, 16),

Where does the 16 come from?

johannes

