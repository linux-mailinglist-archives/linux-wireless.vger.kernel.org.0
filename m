Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317E25ACEE6
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Sep 2022 11:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbiIEJcx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Sep 2022 05:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbiIEJcw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Sep 2022 05:32:52 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC845006C
        for <linux-wireless@vger.kernel.org>; Mon,  5 Sep 2022 02:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=tX9QgcGn7+fLXns8mV9DE9uO/rUf0e8OnYl5WG4WCJ4=;
        t=1662370371; x=1663579971; b=uzNU4imbetzad3/Hy/cPTZT/spBwdKz6LsfmiNoIe4BrUOu
        lJcx00+7whJluJZw1gV1hMY2/ynB9qIFtcnV9YYUm45VrNipFugCwZwGHn08bqtSR4zlwKVfa51Gc
        BKKlr4o1OvMAs6SnnuBmIRuO+Nj+FUToLly6aXm7fM6StfUhcXm0XMo0UBD341702lMWbrpSQSn8D
        hBIcjbO2MoKJtUrPNcRjbWSFrjE43GYcSxWKOsFFcSYm1YGZwohtDD8j7GgYDLzSUJiCEBS+OADNJ
        EQOPVu/PxbEDzVvuqT3dZB0FvMpD3T4BF7TtyvNcNzwvu1soUb+YxmDWpFBaFOHw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oV8TH-008UlX-1E;
        Mon, 05 Sep 2022 11:32:47 +0200
Message-ID: <af05af0f8f88c42af486bbc6cd5412e3f97e1369.camel@sipsolutions.net>
Subject: Re: [PATCHv4] wifi: mac80211: Mesh Fast xmit support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        "nbd@nbd.name" <nbd@nbd.name>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Mon, 05 Sep 2022 11:32:46 +0200
In-Reply-To: <SN6PR02MB4334A54FCCA1F46A0FF4CC5FF77C9@SN6PR02MB4334.namprd02.prod.outlook.com>
References: <20220818070542.15870-1-quic_srirrama@quicinc.com>
         <5e0b07409a8c30f61ebe514d31d77e4564b86258.camel@sipsolutions.net>
         <SN6PR02MB4334A54FCCA1F46A0FF4CC5FF77C9@SN6PR02MB4334.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
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

On Sun, 2022-09-04 at 03:14 +0000, Sriram R (QUIC) wrote:
> >=20
> > Though I've actually thought for a while now that we have so many capab=
ility
> > checks, we might benefit from making those static keys for systems that=
 only
> > have a single wifi NIC (or multiple similar ones), which is quite many =
I guess.
> Sure, we could check for fast-xmit cap. But, I added 'enabled' so as to a=
void
> accessing local->hw in all these functions and also in case if we need a
> selective enable/disable of this cache in future.

Right, that's what I meant wrt. cache locality - I guess we can keep it
this way. Though we probably check local so often I'm not sure it
matters, and if we ever do revive the static keys idea (I did have a
patch at some point), it'd be better with the flag check.

> > > +     if (key) {
> > > +             hdr =3D (struct ieee80211_hdr *)mhdr->hdr;
> > > +             hdr->frame_control |=3D cpu_to_le16(IEEE80211_FCTL_PROT=
ECTED);
> > > +     }
> >=20
> > Isn't "if (key)" equivalent to "if (pn_offs)" at this point, so you can=
 move it into
> > the same if?
> The pn_offs will be set only on IEEE80211_KEY_FLAG_GENERATE_IV is set in =
key->conf.flags
> So had separate checks.

Ack.

> > > +     /* availability of hdr entry ensures the mpath and sta are vali=
d
> > > +      * hence validation can be avoided.
> >=20
> > What about key? :)

> Hmm.. I was relying on the availability of cache entry to ensure sta and =
key are valid.

And I thought you're right - but you didn't mention it in the comment,
so I wanted to double-check.

> But I see your point and realize the entry gets removed later in __sta_in=
fo_destroy_part2()
> whereas the key can get cleared before the entry is flushed.
> May be I'll see if I could flush the cache entry in __sta_info_destroy_pa=
rt1() so that
> the entry itself is not visible. Hope that solves if such race occurs.
>=20

Alright, let's see. But you can also remove a key without removing a
STA, so maybe there's some flushing needed there too?

johannes
