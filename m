Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449E04E73D9
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 13:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359194AbiCYM6d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 08:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347741AbiCYM6c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 08:58:32 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AF6D0AB1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 05:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=sM3gAVPDWiQVKmoDz3Gf2dMl+3SvmTeBjE2WbYrJ/VU=;
        t=1648213017; x=1649422617; b=gdWEaiVdozemIvgU+1wn5PCz35ENm+VbRs7E5/yvmFFC/I4
        y3Qxp1xqmiPXypdp4PxqOHzfqdraG4Jt2u5OrrUZ6XkEKQ2yMAZXMBxphAuIRZNP8ZnuGwz0kIwgW
        ZoJdkNut2YJndcbeSbJGQr7GuiQB/1diC5pTBB5IgxnCaJygG9U8fPoDIKyLPS+kgf90h1DgFTamJ
        kNWRLzMdYXzZMfMqknosGils4wU98iSsUTDs6/hKWxCXY4I956z4fgH1owcOOgpvqqBvHCC4pB/et
        tGlqIfwMZt+vqq4T6qSkuZHac3B466MpdCf4NANxIbAS8PNmm9RNRE1EWIh0zHrw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nXjUt-000Kh3-To;
        Fri, 25 Mar 2022 13:56:56 +0100
Message-ID: <20abb029438166d02b5fb47093ea857671fa86e8.camel@sipsolutions.net>
Subject: Re: [RFC] mac80211: prepare sta handling for MLO support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sriram R <quic_srirrama@quicinc.com>,
        linux-wireless@vger.kernel.org
Cc:     vkthiagu@gmail.com, Aaron Komisar <akomisar@maxlinear.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Jouni Malinen <j@w1.fi>
Date:   Fri, 25 Mar 2022 13:56:54 +0100
In-Reply-To: <1648194497-15848-1-git-send-email-quic_srirrama@quicinc.com>
References: <1648194497-15848-1-git-send-email-quic_srirrama@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2022-03-25 at 13:18 +0530, Sriram R wrote:
> [snip]

I think this looks good so far!

> RFC Note:
> This patch breaks build since it requires changes in all
> mac80211 based drivers. Only ath11k driver changes are added
> here for reference. All driver changes will be covered once
> we arrive at final design.
> Basically for existing drivers, the link params that are moved
> to a new struct within ieee80211_sta will be accessed via first link.
> Ex. 'sta->rx_nss' will change to 'sta->link[0]->rx_nss'

Right. These are large but fairly mechanical changes as long as there's
no MLO support, I guess most could be done with a carefully crafted
spatch.

>  
> +#define MAX_STA_LINKS			16

Isn't that 15? 15 is reserved, I believe?

> +struct ieee80211_link_sta {
> +	u8 addr[ETH_ALEN];
> +
> +	struct ieee80211_sta_ht_cap ht_cap;
> +	struct ieee80211_sta_vht_cap vht_cap;
> +	struct ieee80211_sta_he_cap he_cap;
> +	struct ieee80211_he_6ghz_capa he_6ghz_capa;
> +
> +	u8 rx_nss;
> +	enum ieee80211_sta_rx_bandwidth bandwidth;
> +	struct ieee80211_sta_txpwr txpwr;

That looks mostly fine.

I think you missed at least
 - supp_rates (clearly, the list of legacy rates)
 - rates (rate control must be done separately per band)

and I'm not sure about the A-MSDU related ones?

> +	bool multi_link_sta;
> +	u8 num_sta_links;

Why do we need the num_sta_links? We can always count which link[]
entries are non-NULL?

> +	struct ieee80211_link_sta *link[MAX_STA_LINKS];

I guess we index this by link-ID, which may be assigned by the AP and we
might end up using e.g. 1 and 14, and then things are simpler but we
might have a lot of NULL pointers? I'm fine with that, just asking if
I'm interpreting it correctly.

> +static int sta_link_alloc(struct ieee80211_sub_if_data *sdata,
> +			  struct sta_info *sta, const u8 *addr,
> +			  bool update, gfp_t gfp)

no point passing gfp

> +{
> +	struct ieee80211_local *local = sdata->local;
> +	struct ieee80211_hw *hw = &local->hw;
> +	struct link_sta_info *lsinfo = NULL;
> +	struct ieee80211_link_sta *lsta = NULL;
> +	u8 link_id, i;
> +
> +	spin_lock_bh(&sta->lock);

you spin_lock here so you need GFP_ATOMIC always

> +	/* TODO This is temporary, the link_id will be assigned based on sta vif */
> +	link_id = sta->num_sta_links;
> +
> +	if (update) {
> +		if (!sta->link[link_id] || !sta->sta.link[link_id])
> +			return -EINVAL;
> +		ether_addr_copy(sta->link[link_id]->addr, addr);
> +		ether_addr_copy(sta->sta.link[link_id]->addr, addr);
> +		goto out;
> +	}
> +
> +	lsinfo = kzalloc(sizeof(*lsinfo), gfp);
> +	if (!lsinfo)
> +		goto free;
> +
> +	lsta = kzalloc(sizeof(*lsta), gfp);
> +	if (!lsta)
> +		goto free;

I did start wondering if we wouldn't want to move struct link_sta_info
to mac80211.h as well, though I'm not sure what else we'd have to move,
and not have to allocate all of these separately?

Though if we follow them through pointers, we can still allocate them in
the same memory chunk (just add the sizes).

Not sure we need to optimise anything here though.

Or maybe in addition or instead we should allocate an *array* of links?
But of course only however many we actually need, regardless of which
ones are actually active.

OTOH, maybe we should keep it this way, and then we could embed the 0th
link instead? Then we wouldn't have

	sta->link[0]->rx_nss

(picking up your example), but

	sta->deflink.rx_nss

which saves a pointer dereference. We'd also do

	sta->link[0] = &sta->deflink;

of course. This removes the MLO overhead in the *drivers* at least, for
those drivers not supporting MLO at all.

We couldn't do this in mac80211 though, only in the mac80211.h level,
but still, might be worthwhile?

You say in the commit message:

> Stats are accumulated per link sta and finally aggregated
> if mld sta stats is required.

but the changes here

>  static struct ieee80211_sta_rx_stats *
>  sta_get_last_rx_stats(struct sta_info *sta)
>  {
> -	struct ieee80211_sta_rx_stats *stats = &sta->rx_stats;
> +	struct ieee80211_sta_rx_stats *stats = &sta->link[0]->rx_stats;

don't seem like you did that yet? Which again, is fine, just wondering
if I'm missing something.


Which, btw, makes this patch fairly much mechanical, so maybe put the
spatch in the commit message? That way can re-apply it if there are
conflicts, or such.

> + * TODO Move other link params from sta_info as required for MLD operation

:)

So looks good I think! Let's get an spatch to do it in both mac80211 and
the drivers, and start splitting things.

Unless you see any major problem with it, I think I'd really prefer to
have a "deflink" embedded and instead of changing

	sta->something
to
	sta->links[0]->something

make all the changes be like

	sta->something
to
	sta->deflink.something

which of course does nothing for MLO yet, but it's easier to grep for,
and we'll surely always have a single link, so in the non-MLO cases we
need not have all the extra allocations around etc., even if in mac80211
we end up accessing through a pointer.



Pivoting a bit - I meant to work on the netdev/wdev stuff again today,
but got side-tracked into the locking issue... but nonetheless I've been
thinking about it, and looking at this, I'm starting to wonder if we
shouldn't do the same with interfaces. The changes are large, but
basically mechanical, and then we can incrementally build on them to
differentiate the link[] in different areas, which makes it nicer to
work on things in parallel?

From an API POV that would obviously require a LINK_ID attribute for a
lot of operations (like GTK settings, AP, add/remove station if not MLD,
etc.), and it would be a *required* attribute in those cases, i.e. if
the interface is in MLD mode.

It would also require some other new attributes, like when you add an
MLD station you'd of course have to give the link addresses for each of
the links, but all of those things are required anyway.

The alternative - having the different wdevs/netdevs as we have seen in
the RFC patches and discussed before seems to have a lot of issues. We
basically discussed a few approaches so far:

1) My original favourite of adding NL80211_IFTYPE_MLD, which would then
have a netdev and get a bunch of non-netdev NL80211_IFTYPE_(STATION|AP)
linked to it, and know what it is based on that.
Problem: you'd have to change the interface type (and destroy the links,
but that's less interesting, though it might actually take quite some
time with synchronize_rcu and all in there) when roaming from an MLO AP
to a non-MLO AP.


2) A variant of this, which was discussed even earlier, where the APs
also have netdevs, so that you can separate the traffic from non-MLD
clients.
Problem: Now you have to deal with multicast in very fancy ways,
especially since you don't immediately know if all the netdevs are
bridged together, or only some, etc. This gets hugely complex, you even
need to still assign sequence numbers for multicast on the separate non-
MLD netdevs from the MLD ... I cannot see this working well.


3) Doing it the other way around - having NL80211_IFTYPE_(STATION|AP) be
the MLD (with netdev) and adding an NL80211_IFTYPE_MLD_LINK (no netdev)
that gets linked to it, and knows what kind it is because it's linked.
This solves the roaming.
Problem: As you have to set the GTK on the _MLD_LINK wdev, it gets
extremely messy to support AP_VLAN here, you'd likely have to have
AP_VLAN under the AP as MLD, so you can add MLD stations to it, but then
you need _MLD_LINKs for each link for the AP_VLAN as well? I cannot see
how that would really work well...

This latter issue actually came up only because I said to Jouni that the
issue of separating non-MLD clients out addressed by (2) above could
instead be solved by putting them into different AP_VLAN, which then got
me thinking about AP_VLAN in the context of MLD :) [1]


Which then leads me to think that maybe the approach with some form of
separate netdev/wdev, that I at least seemed to think was better (in
part because it'd require fewer API changes), isn't so great after all?
And then I'm back at adding a LINK_ID and splitting the wdev/sdata/vif
state in a similar way to the station splitting in this patch.

Thoughts?

Oh also I've been thinking about doing a (video) meeting say next week
or so, in order to hash out this stuff, but I guess timezone wise that
might be very difficult with the different locations people are in?

johannes


[1] I'll note that if we solve the non-MLD client separation issue with
AP_VLAN, we might want to optimize multicast a bit to restrict to a
subset of the links that are actually used by the clients that the
multicast is intended for, but that's probably something we want to do
anyway, since you might at any given time have only legacy clients
connected to only a single band or a subset of bands, or have an MLD
client that has many inactive links (depending on how the spec ends up
evolving in this area).
