Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862D66743A7
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 21:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjASUr4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 15:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjASUrw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 15:47:52 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B49B4EEA
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 12:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=IrKXFoWY8QlPfpZ5xykFKvxWc+mI69/vdm8Cnw8Wy0o=;
        t=1674161271; x=1675370871; b=KYASbuwfgHB47yM2lxEmYFQvXpG5SXZyUg2ryD6mPuEJTTE
        BMbIMVe0/rPzHD11Z3HMEwUuFbYYvRbAN8E6oyHN9fQyeOYHBa6c3z/LF/WJ+mh6TNxEee4xZTpwh
        Mw1hEiOgPWFBlqj4y0OrDzp0rATmRzD4FCwnertnIt0Ow/+kQoSAOL/cqaYFAydW3PRA3+k+HyAB5
        Nq717eBmuv1ACKkCstM4myOrPCeM141XxPKaHx1MG5l+Um2wwgmLryQHRDEmNLmLWwvG7ikY3W1u1
        /yVZjuvCpd3sANp95TpjzW4ikh3dn6OH2k3wx3Ej41x1NaeshXrymrmojC1EqqOQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIbp7-006f1L-17;
        Thu, 19 Jan 2023 21:47:49 +0100
Message-ID: <733b35861bbed8d3b7cf8625d3bf59f1c34e08da.camel@sipsolutions.net>
Subject: Re: [PATCH v7 2/3] nl80211: additional processing in
 NL80211_CMD_SET_BEACON
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Thu, 19 Jan 2023 21:47:48 +0100
In-Reply-To: <1598bf6d-1d0b-3753-73fa-2568d27d60b6@quicinc.com>
References: <20221109214720.6097-1-quic_alokad@quicinc.com>
         <20221109214720.6097-3-quic_alokad@quicinc.com>
         <0b42cfb9f0effce61b33c41ec9067b3747fade5c.camel@sipsolutions.net>
         <9ff00d88-6d12-8ee5-aa25-a5e82879d25c@quicinc.com>
         <26ef0d67db3af16853915568585767b13a73ef9a.camel@sipsolutions.net>
         <1598bf6d-1d0b-3753-73fa-2568d27d60b6@quicinc.com>
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

On Thu, 2023-01-19 at 12:43 -0800, Aloka Dixit wrote:
> >=20
> > > Hence the
> > > current design, at least ath11k, assumes that BSS_CHANGED_FILS_DISCOV=
ERY
> > > and BSS_CHANGED_UNSOL_BCAST_PROBE_RESP "not being set", when beacon i=
s
> > > changed, means disable these features.
> > > What do you think?
> >=20
> > I think that makes no sense? If mac80211 didn't clear struct
> > ieee80211_bss_conf::fils_discovery, then surely it should stick around
> > even if the beacon changes???
> >=20
> "max_interval" was be used as the enable/disable knob for these=20
> features. Non-zero =3D enable, zero =3D disable.
> But the side effect of that is if NL80211 does not receive these=20
> attributes then by default the interval is set to 0.


But it doesn't change in bss_conf if you send change beacon, at least
not before these patches?

Or am I confusing myself?

> I can think of following:
> (1) max_interval cannot be the enable/disable knob because then every=20
> code path in the userspace would still need to set it to non-zero to=20
> continue transmission. Are you okay with having extra members in enum=20
> nl80211_fils_discovery_attributes to ENABLE/DISABLE? I think that is=20
> what you suggested in your comment for the next patch in this series as=
=20
> well.
>=20
> (2) If the template needs changing for any reason then the userspace=20
> will be responsible to send a new one. Until then the driver will=20
> continue the transmission with existing template and interval unless=20
> DISABLE is used.
>=20

Were those meant to be mutually exclusive, because it doesn't seem like
that to me? I think (2) must be what happens now, before these patches,
because I don't see where it would be changed? Like I said above.

I agree that we'd now need an explicit way to indicate "disable", but we
could for example say you disable by adding a nested
NL80211_ATTR_FILS_DISCOVERY attribute without any of the sub-attributes,
which logically kind of makes sense - you're changing
NL80211_ATTR_FILS_DISCOVERY, but you're not including a new set of
parameters, so logically that means disable?

johannes
