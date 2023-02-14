Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D27B69662F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Feb 2023 15:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjBNOM3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Feb 2023 09:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbjBNOMM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Feb 2023 09:12:12 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6620023324
        for <linux-wireless@vger.kernel.org>; Tue, 14 Feb 2023 06:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=fvWoeiINvXZLD7QC0+aGEZOCt4bdZlOt9OaBHiUeOyo=;
        t=1676383901; x=1677593501; b=Pmt34ncHNggHAkEa33aJHDefg5MWcZQJhLruuZ3bjdOzQu3
        In49k31k/Q9WYOMx2/8obHCDV+uCIqOWCTQGtkUnLtXTwQBYMsELquZF+SCBs12FkvlcS9xAVHkGL
        Vie6fQsmv5eirh0UrdEQJr0zxIBvFc+j2sTjQddHOQzleQegjmCp38qQf3WyVVGaxRfeSuG5s0o53
        m7x/pbswWu3ufQPczg79iepRN6HVuuubpyjTODvMBUjLgDF7DyQ1cd8tU/ZahJWOy+qN6jThsxjoO
        metwdvstxqUdoZ1G4lZeceMx2MnJPSzBVIgz5BKVpm7lAlqyQAT1dFmjuoO6MUfg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pRw1V-00CAUv-1s;
        Tue, 14 Feb 2023 15:11:09 +0100
Message-ID: <0bcf6cc8b7cb1208330bc161a29bede7b28d9145.camel@sipsolutions.net>
Subject: Re: [PATCH v7 2/3] nl80211: additional processing in
 NL80211_CMD_SET_BEACON
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 14 Feb 2023 15:11:08 +0100
In-Reply-To: <5accd9bb-b172-be8f-2045-a55b2695b2d4@quicinc.com>
References: <20221109214720.6097-1-quic_alokad@quicinc.com>
         <20221109214720.6097-3-quic_alokad@quicinc.com>
         <0b42cfb9f0effce61b33c41ec9067b3747fade5c.camel@sipsolutions.net>
         <9ff00d88-6d12-8ee5-aa25-a5e82879d25c@quicinc.com>
         <26ef0d67db3af16853915568585767b13a73ef9a.camel@sipsolutions.net>
         <1598bf6d-1d0b-3753-73fa-2568d27d60b6@quicinc.com>
         <733b35861bbed8d3b7cf8625d3bf59f1c34e08da.camel@sipsolutions.net>
         <5accd9bb-b172-be8f-2045-a55b2695b2d4@quicinc.com>
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

Hi Aloka,

Sorry, clearly I dropped the ball on this.


On Thu, 2023-01-19 at 13:19 -0800, Aloka Dixit wrote:
> > But it doesn't change in bss_conf if you send change beacon, at least
> > not before these patches?
> >=20
> > Or am I confusing myself?
> >=20
>=20
> Your understanding is correct, however, without these patches there is a=
=20
> cascading effect.
> -> NL80211: If the attribute is not sent by user-space/processed in this=
=20
> layer then cfg80211_ap_settings->fils_discovery->max_interval is 0=20
> (default).
> -> MAC80211: max_interval=3D0, hence BSS_CHANGED_FILS_DISCOVERY is not se=
t
> -> ath11k: BSS_CHANGED_FILS_DISCOVERY is not set hence driver doesn't=20
> configure/re-configure. Unless target doesn't receive it every beacon=20
> change, it disables it.

Hmm. But if max_interval is 0 in bss_conf then the driver might still
look at it even if BSS_CHANGED_FILS_DISCOVERY is not set, for example
for firmware restart? It seems bad to rely on the change flag only for
all this.

> I can make changes up to the driver to fix this part.

Not sure it's a driver change?

> > > I can think of following:
> > > (1) max_interval cannot be the enable/disable knob because then every
> > > code path in the userspace would still need to set it to non-zero to
> > > continue transmission. Are you okay with having extra members in enum
> > > nl80211_fils_discovery_attributes to ENABLE/DISABLE? I think that is
> > > what you suggested in your comment for the next patch in this series =
as
> > > well.
> > >=20
> > > (2) If the template needs changing for any reason then the userspace
> > > will be responsible to send a new one. Until then the driver will
> > > continue the transmission with existing template and interval unless
> > > DISABLE is used.
> > >=20
> >=20
> > Were those meant to be mutually exclusive, because it doesn't seem like
> > that to me? I think (2) must be what happens now, before these patches,
> > because I don't see where it would be changed? Like I said above.
> >=20
>=20
> Not exclusive. I meant I can make both the changes above to not have the=
=20
> above mentioned cascading effect

Right ok.

>=20
> > I agree that we'd now need an explicit way to indicate "disable", but w=
e
> > could for example say you disable by adding a nested
> > NL80211_ATTR_FILS_DISCOVERY attribute without any of the sub-attributes=
,
> > which logically kind of makes sense - you're changing
> > NL80211_ATTR_FILS_DISCOVERY, but you're not including a new set of
> > parameters, so logically that means disable?
> >=20
> > johannes
>=20
> Sure, will update nl80211_parse_fils_discovery() to allow this case and=
=20
> reset all to 0/null etc.
>=20
> I can start a new series with all the changes, and include current=20
> patches last.
>=20
> Will that work?

I think yes, seems like we have to fix up some things here first.

johannes
