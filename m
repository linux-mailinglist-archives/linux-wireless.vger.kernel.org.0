Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1CC6D1C02
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Mar 2023 11:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjCaJXj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Mar 2023 05:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCaJXi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Mar 2023 05:23:38 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5DF46BF
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 02:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=l8GbxTGJR0ffBdLvEXPlgu0KBiZ51z/vjHISIDMOxXI=;
        t=1680254617; x=1681464217; b=JAqsOsx4ZySe34ItDcRMUlwg0SU9Zp5Po4L4eJ6O5QScqO2
        DlRDyOxEZG43ZDv/9j7RS3NoaEqyM7KhxqoWY6rQHBejjB+xVtk4fA91MGPAuXKyWBd8k+CYo5hXS
        Q3jWqjjFYikGkvJMMhR3caOdPAyXgXwPfky5CGKXVWBbHzJ/DWr27n1VhGj9vpcKYf8+Y0sHu+Qrj
        qurb2Ya666bw1wzjDBrixqrONGtuS8qUsWofmcWzcUk0GwJcK9aQiZeRAsVDOXjAzS9LuTWejxmgV
        xNnKifwooyqnFH/mssqE3+cL/nwvexY2VdyzoWUV9S641mSsLLeOuKXJERAUQHEg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1piAyt-0029Tu-1t;
        Fri, 31 Mar 2023 11:23:35 +0200
Message-ID: <3abb2d127eaa3b76a8f4f34c795ddd6d502ce470.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: beacon EHT rate support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 31 Mar 2023 11:23:34 +0200
In-Reply-To: <312f1476-b78b-b7f0-26f9-512a7dc2b6b7@quicinc.com>
References: <20230329000902.17992-1-quic_alokad@quicinc.com>
         <d54800ae88be1eb232df7794e741dfc304c3ee9a.camel@sipsolutions.net>
         <312f1476-b78b-b7f0-26f9-512a7dc2b6b7@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2023-03-30 at 15:40 -0700, Aloka Dixit wrote:
> On 3/30/2023 3:44 AM, Johannes Berg wrote:
> > On Tue, 2023-03-28 at 17:09 -0700, Aloka Dixit wrote:
> >=20
> > > +		switch (wdev->iftype) {
> > > +		case NL80211_IFTYPE_AP:
> > > +			width =3D wdev->u.ap.preset_chandef.width;
> >=20
> > This seems a bit awkward and annoying, it means that we have to keep
> > using the API that sets the preset_chandef first, and it also means it
> > won't work for multi-link.
> >=20
>=20
> Okay, I can do it the same with it is done in he_get_txmcsmap():
> 	chandef =3D wdev_chandef(wdev, link_id);

Right, that should be better.

Though not sure that works already when you're doing START_AP, I'd think
we don't set the chandef before parsing the rate attribute?

Which would mean userspace would have to separately set the beacon rate,
which means even having the whole thing inside start_ap() is pointless?


> > Couldn't you link it with the config in start_ap/join_mesh? And per-lin=
k
> > config in set_tx_bitrate_mask()?
> >=20
>=20
> Please correct me if I'm wrong but ieee80211_set_bitrate_mask() need not=
=20
> be changed for setting the beacon rate in non-MLO case, right?
> Because it does not have anything related to he_mcs currently too.

How is ieee80211_set_bitrate_mask() related, it's in mac80211?

Oh you mean it doesn't need to be changed to support EHT? Looks like to
me that it would have to be changed, and even HE today only works in
non-mac80211 drivers that implement it correctly?

But again set_bitrate_mask() isn't even related to beacon rate?


Regarding beacon rate, it looks like mac80211 _only_ accepts legacy
rates, and then also _only_ in start_ap(), so I'm not sure how the whole
thing even works ...??

> > Also not sure about this at all in parse_tid_conf()?
> >=20
>=20
> Can you please explain this point.

parse_tid_conf() also calls nl80211_parse_tx_bitrate_mask(), and I don't
know how the right channel would be known there, that's all.


johannes
