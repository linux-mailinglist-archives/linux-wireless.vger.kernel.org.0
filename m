Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECED535AD2
	for <lists+linux-wireless@lfdr.de>; Fri, 27 May 2022 09:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348469AbiE0H41 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 May 2022 03:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348345AbiE0H4Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 May 2022 03:56:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBE1222B6
        for <linux-wireless@vger.kernel.org>; Fri, 27 May 2022 00:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=GihyiXyG+NPy3C9guc9UeCXqbIA4uizMKkFbhuHfZiw=;
        t=1653638179; x=1654847779; b=qy1VE8hDnUGkCZ34ZT6P/D/YsuqRiZPzeP0RFxXSCGVYDf8
        k8mrrkEf1I+fWjn1n7hM8W/NHquuDXssF01AAZakb47KNMJQA1JBG+m1ma3Dj4xAIF4a6iaYkl6n2
        KWItUnuTsgAy4AqHHr/NOxopA8WWI17ebV9ZsJlK2wfMlIWeeePpQlY1Iw9Ev1VtFblHgOWLfJZmv
        01cIgv1RAX1PONyCzZbP6LERctsJjFtJ5e/E/YtOnyl22FjrvGJbfcy/uW9MYcOROK0OVLizapYQg
        6+hZcK9AfdV0Ryw149onpopsTIckkohm9yqgvzPP9EAT812FDe3Q4b+8fcdYVjPA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nuUpU-005xv4-NK;
        Fri, 27 May 2022 09:56:16 +0200
Message-ID: <9270689aeb7de1c2f9764d8e79f28c2b9aafcedc.camel@sipsolutions.net>
Subject: Re: [RFC] cfg80211: Indicate MLO connection info in connect and
 roam callbacks
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 27 May 2022 09:56:15 +0200
In-Reply-To: <1653528391-21718-1-git-send-email-quic_vjakkam@quicinc.com>
References: <1653528391-21718-1-git-send-email-quic_vjakkam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Thu, 2022-05-26 at 06:56 +0530, Veerendranath Jakkam wrote:
> The MLO links used for connection with an MLD AP are decided by the
> driver in case of SME offloaded to driver.
>=20
> Add support for the drivers to indicate the information of links used
> for MLO connection in connect and roam callbacks, update the connected
> links information in wdev from connect/roam result sent by driver.
> Also, send the connected links information to userspace.
>=20
> Add a netlink flag attribute to indicate that userspace supports
> handling of MLO connection. Drivers must not do MLO connection when this
> flag is not set. This is to maintain backwards compatibility with older
> supplicant versions which doesn't have support for MLO connection.


Looks good to me!

Couple of questions/nits below:

> + * @links.bssid: For MLO connection, MAC address of the AP link. For non=
-MLO
> + *	connection, links[0].bssid points to the BSSID of the AP (may be %NUL=
L).
> + * @links.bss: For MLO connection, entry of bss to which STA link is con=
nected
> + *	to, can be obtained through cfg80211_get_bss() but may be %NULL for s=
ome
> + *	valid links as scan results of all AP links may not be received.

Do we want to encourage that? In that case, we cannot show all the
information about the BSS to userspace, nor hold on to the entry to
later show that we're connected, etc.

Even now I'm not sure I like this code that lets the driver get away
without a BSS entry.

Maybe it'd be better to ask the driver to make up an entry on the fly
and reference it, at least with the right channel, so it can be updated
later?

> =20
> +	NL80211_ATTR_MLO_SUPPORT,
>  	/* add attributes here, update the policy in nl80211.c */
>=20

please add a blank line there after the new attribute


> +	unsigned int link;
> +	const u8 *connected_addr;
> +	bool bss_found =3D false;
> +	bool self_link_addr_miss =3D false;
>=20
[...]
> =20
> +	if (cr->valid_links) {
> +		for_each_valid_link(cr, link) {
> +			if (!cr->links[link].addr) {
> +				self_link_addr_miss =3D true;

You can declare self_link_addr_miss inside the "if (cr->valid_links) {"
scope, I think?

> +			for_each_valid_link(cr, link)
> +				cfg80211_put_bss(wdev->wiphy, cr->links[link].bss);

It might be worth extracting this into a small helper function, you do
it quite a number of times.

> +		if ((!cr->valid_links && link =3D=3D 1) ||
> +		    (cr->valid_links && link =3D=3D ARRAY_SIZE(wdev->links)))
> +				WARN_ON_ONCE(!wiphy_to_rdev(wdev->wiphy)->ops->connect);

You can put all the conditions inside the WARN_ON_ONCE(), no?

But is this even right, seems like even mac80211 with auth/assoc might
eventually get to some of this code?

> +	memset(wdev->links, 0, sizeof(wdev->links));
> +	wdev->valid_links =3D cr->valid_links;
> +	for_each_valid_link(cr, link) {
> +		if (!cr->links[link].bss)
> +			continue;
> +
> +		wdev->links[link].client.current_bss =3D bss_from_pub(
> +							cr->links[link].bss);

maybe line-break after =3D, instead of like this

> +	if (cr->valid_links)
> +		for_each_valid_link(cr, link)
> +			ether_addr_copy(wdev->links[link].addr,
> +					cr->links[link].addr);
>=20

I think I might prefer braces for the "if", so it's more obvious. Dunno.

Are you sure ether_addr_copy is fine, there wasn't really any alignment
guarantee on cr->links[link].addr.

> @@ -910,6 +1025,11 @@ void __cfg80211_roamed(struct wireless_dev *wdev,
>  #ifdef CONFIG_CFG80211_WEXT
>  	union iwreq_data wrqu;
>  #endif
> +	unsigned int link;
> +	const u8 *connected_addr;
> +	bool bss_found =3D false;
> +	bool self_link_addr_miss =3D false;
> +
>  	ASSERT_WDEV_LOCK(wdev);
> =20
>  	if (WARN_ON(wdev->iftype !=3D NL80211_IFTYPE_STATION &&
> @@ -919,14 +1039,50 @@ void __cfg80211_roamed(struct wireless_dev *wdev,
>  	if (WARN_ON(!wdev->connected))
>  		goto out;
> =20
> +	if (info->valid_links) {
> +		for_each_valid_link(info, link) {
> +			if (!info->links[link].addr) {
> +				self_link_addr_miss =3D true;

same here as above

maybe it's worth pulling out the validation into a separate function?

> @@ -949,18 +1105,19 @@ void __cfg80211_roamed(struct wireless_dev *wdev,
> =20
>  	memset(&wrqu, 0, sizeof(wrqu));
>  	wrqu.ap_addr.sa_family =3D ARPHRD_ETHER;
> -	memcpy(wrqu.ap_addr.sa_data, info->bss->bssid, ETH_ALEN);
> -	memcpy(wdev->wext.prev_bssid, info->bss->bssid, ETH_ALEN);
> +	memcpy(wrqu.ap_addr.sa_data, connected_addr, ETH_ALEN);
> +	memcpy(wdev->wext.prev_bssid, connected_addr, ETH_ALEN);
>  	wdev->wext.prev_bssid_valid =3D true;
>  	wireless_send_event(wdev->netdev, SIOCGIWAP, &wrqu, NULL);
>  #endif

I wonder if we should just completely skip WEXT stuff for MLD, it's
probably not going to result in anything useful? Hmm.

> +	for_each_valid_link(info, link)
> +		cfg80211_put_bss(wdev->wiphy, info->links[link].bss);

again this :)


> @@ -969,23 +1126,42 @@ void cfg80211_roamed(struct net_device *dev, struc=
t cfg80211_roam_info *info,
>  	struct cfg80211_event *ev;
>  	unsigned long flags;
>  	u8 *next;
> +	unsigned int link;
> +	size_t link_info_size =3D 0;
> +	bool bss_found =3D false;
> +
> +	for_each_valid_link(info, link) {
> +		link_info_size +=3D info->links[link].addr ? ETH_ALEN : 0;
> +		link_info_size +=3D info->links[link].bssid ? ETH_ALEN : 0;
> =20
> -	if (!info->bss) {
> -		info->bss =3D cfg80211_get_bss(wdev->wiphy, info->channel,
> -					     info->bssid, wdev->u.client.ssid,
> -					     wdev->u.client.ssid_len,
> -					     wdev->conn_bss_type,
> -					     IEEE80211_PRIVACY_ANY);
> +		if (info->links[link].bss) {
> +			bss_found =3D true;
> +			continue;
> +		}
> +
> +		info->links[link].bss =3D cfg80211_get_bss(
> +						wdev->wiphy,
> +						info->links[link].channel,
> +						info->links[link].bssid,
> +						wdev->u.client.ssid,
> +						wdev->u.client.ssid_len,
> +						wdev->conn_bss_type,
> +						IEEE80211_PRIVACY_ANY);
> +
> +		if (info->links[link].bss)
> +			bss_found =3D true;
>  	}
> =20
> -	if (WARN_ON(!info->bss))
> +	if (WARN_ON(!bss_found))
>  		return;

This goes with my question earlier - here you're basically assuming
finding a single BSS is fine. Do we really think so? It used to be we
wanted all of them, and I kind of tend to think drivers should just make
sure they have all of them - once we have the entry it can be updated,
but if we don't have one, we'll never again get the information on the
BSS, for purposes such as "iw link" output.

I tend to think we should always require all BSS entries to exist, even
if the driver initially has to make up a fake entry with pretty much no
information.

Or maybe we have enough information here already (BSSID/frequency) to
make up a fake entry in cfg80211?


> +	if (info->ap_mld_addr) {
> +		ev->rm.ap_mld_addr =3D next;
> +		memcpy((void *)ev->rm.ap_mld_addr, info->ap_mld_addr,
> +		       ETH_ALEN);

Why the cast?

johannes
