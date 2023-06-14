Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16A372F9E0
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 11:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbjFNJ4W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 05:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbjFNJ4V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 05:56:21 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B54AC;
        Wed, 14 Jun 2023 02:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=4urHoDTcQ5msAxG4a15V6mp6BTEGox77QEHbH6T6xAY=;
        t=1686736580; x=1687946180; b=a068PTVACzZ2zwKBGJVo0NpbWiyTEcx1cN59ma26XaR2GGB
        A4i2RuABcgI/e9zGALMxdd6AUnvVTvTDwFosymbLtZ5mwLsrRxnbiDoNbx/R+7Jublq5K8owMHI+0
        gijwct76TmWVeRkybayNyEIQF726bgjmOnCHEKxKZ660PwvrViP7tG9D/5+T5v3672dDkj+w562RI
        /Bwy9NKDHNschIoPww4/TIDotkj11O6XgyEBFYphXHE5sBTa/6qkFuKoOH+YnIDiDNMc3+LqRcELV
        IcH7VjIexUI/yQ8LFcj13W7c3uLK7R2MHa9x68fE4QLRF9ClAAqARH7qvOWoVgkw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q9NEf-0063ay-2e;
        Wed, 14 Jun 2023 11:56:17 +0200
Message-ID: <c7c9418bcd5ac1035a007d336004eff48994dde7.camel@sipsolutions.net>
Subject: Re: Closing down the wireless trees for a summer break?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Date:   Wed, 14 Jun 2023 11:56:16 +0200
In-Reply-To: <20230613195136.6815df9b@kernel.org>
References: <87y1kncuh4.fsf@kernel.org> <871qifxm9b.fsf@toke.dk>
         <20230613112834.7df36e95@kernel.org>
         <ba933d6e3d360298e400196371e37735aef3b1eb.camel@sipsolutions.net>
         <20230613195136.6815df9b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-06-13 at 19:51 -0700, Jakub Kicinski wrote:
> On Tue, 13 Jun 2023 22:00:35 +0200 Johannes Berg wrote:
> > On Tue, 2023-06-13 at 11:28 -0700, Jakub Kicinski wrote:
> > > On Tue, 13 Jun 2023 20:14:40 +0200 Toke H=C3=B8iland-J=C3=B8rgensen w=
rote: =20
> > > > I think this sounds reasonable, and I applaud the effort to take so=
me
> > > > time off during the summer :)
> > > >=20
> > > > One question that comes to mind is how would this work for patchwor=
k?
> > > > Would we keep using the wireless patchwork instance for the patches
> > > > going to -net in that period, or will there be some other process f=
or
> > > > this? I realise the setup we have for ath9k is a bit special in thi=
s
> > > > regard with the ack-on-list+delegation, so I'm obviously mostly
> > > > interested in what to do about that... :) =20
> > >=20
> > > Whatever's easiest :) It's probably a good idea for Kalle to write
> > > down all the local rules and customs and share those with us.
> >=20
> > While that's probably a good idea regardless, I'd think that patchwork
> > doesn't really matter that much - we'll have some catching up to do
> > anyway after the vacations, so looking through patchwork etc. would be
> > perfectly acceptable. Worst case we'd notice when a patch doesn't apply=
,
> > right? :)
>=20
> Right, I meant it more in terms of patch flow. Is looking at which
> drivers have a tree specified in MAINTAINERS enough to know what
> should be applied directly?

Oh, right. Not really sure how well that all is reflected in
MAINTAINERS.

So Gregory usually handles patches for iwlwifi, but he'll _also_ be on
vacation around a similar time frame.

Toke usually reviews patches for ath9k but then asks Kalle (via
assigning in patchwork) to apply them.

Felix usually picks up patches for mediatek drivers (unless specifically
asking Kalle for individual ones) and then sends a pull request.

For the stack (all the bits we have under net/) that's just on me,
normally.

I think that's it? But I guess Kalle will have more comments.


> > Wrt. ath9k patches I guess "delegate in patchwork" won't work anymore,
> > but "resend to netdev" or something perhaps?
>=20
> We can watch PW state and apply from linux-wireless, I reckon.
> That said I don't know how you use delegation :)

We have auto-delegation set up for this, except iwlwifi is on me right
now for the upstream, and I just delegate other incoming patches to
Gregory.

johannes
