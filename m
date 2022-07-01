Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074D85630DA
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Jul 2022 12:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbiGAKAW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Jul 2022 06:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbiGAKAV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Jul 2022 06:00:21 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617817392E
        for <linux-wireless@vger.kernel.org>; Fri,  1 Jul 2022 03:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1H/SKq42ufaqJw4esn9+wGh5rFQ0cje5lBEt5DNGY5k=;
        t=1656669620; x=1657879220; b=iigPt5a1TK8inh7texcxd87aiNvpM77HJC2p16ovgDGncVs
        lG23PY2KLzel/uEUBgez1G/UV73QSZ47gHhoW1Nol4oiVjiJ+W718VPhUc8VSoYh3uQwLClBd48Fd
        pKYG6EWuN+pbRAzu1Rh7//K5SOz2xrpNpgaM5JUM/uV1pWcImOrw7Xp9ylWvMMEG5rTj/rll9pkqc
        PW4t/lP4a2Gf1LeFkBqYani/2OwF7UunXjwXaA/tVFOtG0r2L3dpV0Kato05V4m1t10tWGDn2XaPI
        JYC2jRk7pYvX6ebwo7cxRELENYBGEAXBR1/8L4cerh6y9+/tGL5zsj+35TEqnWZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1o7DRi-003R2z-32;
        Fri, 01 Jul 2022 12:00:18 +0200
Message-ID: <19477e0584f7031b37fcdfcc5ef10e7b00842f07.camel@sipsolutions.net>
Subject: Re: [PATCH 0/3] Mesh Fast xmit support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        "nbd@nbd.name" <nbd@nbd.name>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Fri, 01 Jul 2022 12:00:17 +0200
In-Reply-To: <940aa2fe0f2497e9fab9a5118001034b5de18d64.camel@sipsolutions.net>
References: <1654857639-12346-1-git-send-email-quic_srirrama@quicinc.com>
         <98e3a2743ab770fbd3f14dca14b62105c8457bf6.camel@sipsolutions.net>
         <SN6PR02MB4334670B5FD85EB6940A64F8F7BD9@SN6PR02MB4334.namprd02.prod.outlook.com>
         <9bce16843dcc698740d90d8963a1a55516fb1d39.camel@sipsolutions.net>
         <SN6PR02MB4334F77368A1AC3F1202117CF7BD9@SN6PR02MB4334.namprd02.prod.outlook.com>
         <940aa2fe0f2497e9fab9a5118001034b5de18d64.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
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

On Fri, 2022-07-01 at 11:59 +0200, Johannes Berg wrote:
>=20
> >   So was skeptical on having a higher cache size(like 250 or 500 max).
> > Hence had a value of 50 and left the configuration part for devices
> > which needed higher
> > cache.=20
> > But as you mentioned, this is only runtime max memory and not default.
> > =C2=A0So we should be fine to set some high limit, If above is not a
> > concern could we stick to
> > an upper limit of ~150-200 ?
>=20
> Right, I'm fine with that. I was just throwing out 500 as a random
> number to show that it's not really a huge memory requirement.
>=20

But maybe Felix wants to comment? Felix?

johannes
