Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46917E569F
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 13:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344521AbjKHM7A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 07:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344383AbjKHM7A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 07:59:00 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4D51BF3
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 04:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=oSs6Bob0xva7GxhXmcE4fSs5B8dOwVuaf4sIW5P27As=;
        t=1699448338; x=1700657938; b=SsrHCtw5Q2/MB1d7y+TF/gIEfW5NC+pIyB1VSRDqV/8JFd1
        UY7ysDEheRaoUhUD+pFdJEonSC6eGCMkZx6gUi2U4b8tSdesV/9HuhWQjk41nAJTe+X5h/8/k8vFX
        Gkep0AHJGyxECHzQpQsi4Y4fbBBopGNoW131k9dTfRJkDJBvRiAiEagDCW05dI508GJYFgzLRfrEH
        ZO95+uYmxrOy+rG1VUEYAKbCc0eao+k8O/+Z3q5+rxMBnUrCyJp407v2C2XIGCSQNpyrbiqRjtsrJ
        n3dtQQ53PbPGH5YfU3sA1ZBDAviUlhWifXANg1KfCQHAsJc+AhLa0xHQQKrtvYrw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r0i91-00000000VbF-27gL;
        Wed, 08 Nov 2023 13:58:55 +0100
Message-ID: <009fc2c209027efb5578e57926276be81891faca.camel@sipsolutions.net>
Subject: Re: [PATCH 2/3] cfg80211: validate RU puncturing bitmap
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 08 Nov 2023 13:58:54 +0100
In-Reply-To: <587c4a25-4977-b2d7-a587-f2a742105a43@quicinc.com>
References: <20220214223051.3610-1-quic_alokad@quicinc.com>
         <20220214223051.3610-3-quic_alokad@quicinc.com>
         <a9813545a25cd63f71cc31476230514a80350802.camel@sipsolutions.net>
         <6cf56be5-16d6-2bcd-150f-bf29f98b7f1b@quicinc.com>
         <58fdd62041c0388740cabea5a421c5417f959124.camel@sipsolutions.net>
         <9fd4a3097e078c1fe2acd5fbd0c559b0390daa49.camel@sipsolutions.net>
         <460cb443-868c-ec05-7aec-5b1eee381ae2@quicinc.com>
         <28b099e7a37824f0b59ab824e67b3437485e45d5.camel@sipsolutions.net>
         <587c4a25-4977-b2d7-a587-f2a742105a43@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-10-18 at 17:09 -0700, Aloka Dixit wrote:
> On 10/18/2023 5:58 AM, Johannes Berg wrote:
> >=20
> > Are you thinking about (separately?) configuring the OFDMA puncturing?
> > Which spec-wise you do per PPDU, controlled by the AP (trigger frame), =
I
> > think?
> >=20
>=20
> Need to study the spec again so not any time soon.
> Will send a new series if it is needed.

OK.

> > > >      1. The DSP/radio can receive punctured PPDUs if listening on t=
he non
> > > >         punctured channel.
> > > >        =20
> > > >         At least for our device that's not true, not sure about ath=
12k? It
> > > >         seems you have a per-peer puncturing configuration even, bu=
t that
> > > >         seems odd, and it's always just set to the vif puncturing
> > > >         configuration.
> > > >        =20
> > >=20
> > > Yes, same vif puncturing pattern is assigned for all the peers
> > > associated on that vif, but firmware requires it to be sent separatel=
y
> > > for each peer.
> >=20
> > OK, thanks.
> >=20
> > What if it differs for different vifs?
> >=20
>=20
> So far that use-case hasn't come up but I'm confirming if we really need=
=20
> that support or not. Will get back you.

Thanks.
(Also reminder, but yeah, I've also been busy otherwise.)

> > > If we do end up moving the bitmap back to chandef, we may need some
> > > changes, because as I said above, when I originally added it I hadn't
> > > thought of different bitmaps for each vif.
> > > But can you give an example of what you would consider as compatible
> > > channel contexts and what would be incompatible? I'm not clear on tha=
t part.
> >=20
> > Easy example:
> >=20
> >   * control channel 36, 80 MHz, puncturing bitmap 0x2
> >   * control channel 36, 80 MHz, puncturing bitmap 0
> >=20
> > Contrary to what I thought and said before, I want to treat these as
> > *not* compatible now, and allocate two channel contexts if I end up
> > having to do this.

> I'm okay if you want to move it back to chandef, in fact I myself can=20
> send a series for it.

I'm planning to start working on it now/soon.

> As far as two contexts are concerned, sounds like you don't need that=20
> for your use-case. And I will confirm if we need it or not.

Not sure what you mean - I do in fact want two channel contexts for
this?

But please check if you need that or not, as discussed above - this is
the "different puncturing pattern for different vifs" case.

johannes
