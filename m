Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360DF62D8B3
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Nov 2022 12:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239536AbiKQLBR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Nov 2022 06:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239546AbiKQLAW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Nov 2022 06:00:22 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F07B20BF1
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 02:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=JuepEJ6Pr2GcBlNDEfn4OkLBPqT1V7mQUvqOHNnaSfM=;
        t=1668682717; x=1669892317; b=m5LltYXhdZO8gUjWZAzTPuiWBLMJhE9GBzuzNPs4H27bQAJ
        7nRVX06tOGEkmwbEF9PzfdI45g7MPfRSJ3nmZrr2lsBS8X4KeWzDWzNI0UUR76Ep57uvL5wGsZfcZ
        XNfYVX5P2Ea5ONxaYtZTBZ0SDOrqu7oa32DIARMpRGJc2NjmL9tIGIpw833BtPmm5zAqjaFZ3++im
        SIsyQ+N6oNDLSjYPMdHylyjwYNWbFyjPLW4RdF7GhU9VkTpmGVzivCdz7BL+U7asXz0uBqJDG861e
        0U4T83Meinl6k3bBwoLonwQi92j7A7qsQeGN98tT+YYP74YxEFFEzBK1pVS36XRw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ovcbL-002CJo-0x;
        Thu, 17 Nov 2022 11:58:35 +0100
Message-ID: <05d8f323f68412c1e0284ccf52321ab776674a59.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 2/2] wifi: wireless: deny wireless extensions on
 MLO-capable devices
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 17 Nov 2022 11:58:34 +0100
In-Reply-To: <87r0y1rgz6.fsf@kernel.org>
References: <20221104174218.26f9541c0bfa.Ifcf30eeeb8fc7019e4dcf2782b04515254d165e1@changeid>
         <20221104174218.7817a3abaf39.Ib9eabc2ec5bf6b0244e4d973e93baaa3d8c91bd8@changeid>
         <87r0y1rgz6.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
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

On Thu, 2022-11-17 at 12:51 +0200, Kalle Valo wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
>=20
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > These are new devices that will be introduced into the market
>=20
> s/new/Wi-Fi 7/?
>=20
> > in 2023, with new drivers. Wireless extensions haven't been in
> > real development since 2006. Since wireless has evolved a lot,
> > and continues to evolve significantly with MLO, there's really
>=20
> s/MLO/Multi-Link Operation/?
>=20
> It would good to spell out the acronym at least once per commit log.

:)

> > +++ b/net/wireless/wext-core.c
> > @@ -662,6 +662,8 @@ struct iw_statistics *get_wireless_stats(struct net=
_device *dev)
> >  	    dev->ieee80211_ptr->wiphy->wext &&
> >  	    dev->ieee80211_ptr->wiphy->wext->get_wireless_stats) {
> >  		wireless_warn_cfg80211_wext();
> > +		if (dev->ieee80211_ptr->wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO)
> > +			return NULL;
>=20
> Should we have a some kind of warning in this case as well? Otherwise
> the user has no idea why it stopped working, right?

Well it's added after the warning wireless_warn_cfg80211_wext(), so it
already prints the warning from the previous.

I guess we could make an argument to the warning and modify the message
if it's rejected?

johannes
