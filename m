Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289AD6963C6
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Feb 2023 13:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjBNMqS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Feb 2023 07:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjBNMqH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Feb 2023 07:46:07 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8639E24489
        for <linux-wireless@vger.kernel.org>; Tue, 14 Feb 2023 04:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=2e8GL0ei8StvHaCh7RBbwmDmdYpFbNkOkUXaRi+KdFI=;
        t=1676378757; x=1677588357; b=Qxg9TpVNV34wop9zUQBEP8lYjqLbWqMWPirhSk92bgSXDfu
        t66FsfUm/fikAdBjsqJoi6xfsliOWr7IzIclJINLjnAHj7HDhzDUos1gHZ+SmYaH6jy4gSRvj+D9r
        IhmhwOEmYrsiy+lz8bNB+S9Uv1h44V4REax22cG6eOBBHdXMS2Rn8SQoSXsAqe4CdCiEa5UAfJ+vK
        2EMAFSzh50LVO59rX34JbEJyJebHhYCOTGHIJrP22RKVtnG5ocFDVY7LauzRQJgXyDKnar/C3jObr
        gagncrRbPbqZBO5QwcZyc1rckib9CKqlfduRTzBFbhW2ePzjc4mz9AvILHYtSyyg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pRuh0-00C8ow-2S;
        Tue, 14 Feb 2023 13:45:54 +0100
Message-ID: <5fe1e6eea00f33be59ae0aaf0429be08595dfc03.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: validate link status before deciding
 on mgmt tx
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sriram R <quic_srirrama@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 14 Feb 2023 13:45:53 +0100
In-Reply-To: <20230119221306.24526-1-quic_srirrama@quicinc.com>
References: <20230119221306.24526-1-quic_srirrama@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2023-01-20 at 03:43 +0530, Sriram R wrote:
> Currently we check the status of bss active flag to see if the
> AP is active.
>=20

Following so far :)

> But in case of a MLD AP, when some of the links
> are getting teardown=C2=A0

"getting torn down"?

> and some are active, mgmt Tx(like deauth)
> can be sent on some links before they are brought down as well.

Makes sense.

> In such cases, the bss active flag might not provide the exact
> status of the MLD links, which becomes false on first link deleted.

Wait, isn't that already a bug?

> Hence check if any of the links can be used for mgmt tx
> before returning error status.
>=20
> Also, use the link id passed from userspace when the link bss
> address matches the mgmt SA and the chan params match the request.
> This will avoid scenario where the link id from userspace
> gets reset.

"gets reset"??

> =20
> +static bool ieee80211_is_link_bss_active(struct ieee80211_sub_if_data *s=
data,
> +					 int link_id)
> +{
[...]
> +	sdata_lock(sdata);
> +	link =3D sdata_dereference(sdata->link[link_id], sdata);
> +	if (!link) {
> +		sdata_unlock(sdata);
> +		return false;
> +	}
> +
> +	if (sdata_dereference(link->u.ap.beacon, sdata)) {
> +		sdata_unlock(sdata);
> +		return true;
> +	}
> +
> +	sdata_unlock(sdata);

The locking here is ... decidedly odd. It feels like with all the
wdev_lock()ing going on in cfg80211_mlme_mgmt_tx() we should probably
just lock around the *entire* thing in cfg80211, including the
driver/mac80211 call?

> @@ -883,8 +920,17 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wi=
reless_dev *wdev,
>  				break;
>  			}
> =20
> -			if (ether_addr_equal(conf->addr, mgmt->sa))
> +			if (ether_addr_equal(conf->addr, mgmt->sa)) {
> +				/* If userspace requested Tx on a specific link
> +				 * use the same link id if the link bss is matching
> +				 * the requested chan.
> +				 */
> +				if (sdata->vif.valid_links &&
> +				    params->link_id >=3D 0 && params->link_id =3D=3D i &&
> +				    params->chan =3D=3D chanctx_conf->def.chan)
> +					link_id =3D i;
>  				break;
> +			}


Not sure I get it, if it's bad (link ID doesn't match BSS) then
shouldn't we just reject it?

johannes
