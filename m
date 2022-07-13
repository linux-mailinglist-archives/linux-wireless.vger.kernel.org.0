Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21952573B41
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 18:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbiGMQaM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 12:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237213AbiGMQaM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 12:30:12 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847F72C65F
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 09:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=q+fN+LzF5b7dHfJQ5jKwjfo6dRTzwPf4H8/CIoy9H6s=;
        t=1657729810; x=1658939410; b=glugkMOqnLGWODyiLcMZ0wJjGGzufMFOj8ZaAkJzbtBhCeb
        1wwnBCd7/L4VvaQMTHR1tP5wvPymN9bwD4A5HePEPBicgUFflUdCEuTEIsfCxwAnTzxzNj4O6GK58
        XAYqljK7W1U1nY19maxxwc4a6BFNFqqFEpvxkx68+9HsNl2os7eW5WMDhUY/M0yyg6dXEQ/3S67q6
        PMtqzRz2kuNGW5kCgaKLl1+hXNbxVGLRd581tjLexUkj1Gsf62n/wEIeASyvFA/JKcfzKlb70nJAi
        2cfi3GSkly7QwpEgnivYm5j9mY/oQEz0e0IqGPORWXLeLrif2yKtfKytK6sV1SpQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBfFY-00Eol6-2u;
        Wed, 13 Jul 2022 18:30:08 +0200
Message-ID: <6e13438e28908504a539ae751977b1eb27a1610a.camel@sipsolutions.net>
Subject: Re: [PATCH 03/76] wifi: mac80211: rx: accept link-addressed frames
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 13 Jul 2022 18:30:06 +0200
In-Reply-To: <6c529c77-079e-4817-3f2c-ed60c5cfd1ee@quicinc.com>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
         <20220713114425.bf1302a63e1c.Idcd337705a4d1737a89bf9247ba73f82a0fc8b61@changeid>
         <bc928f09-cdbc-b5e5-c2f2-0c13ba3ebadb@quicinc.com>
         <d2f68ad4dbe7157fcd5b405a0f12176e03dafe70.camel@sipsolutions.net>
         <48389f1dc78383f6d863b13543bc8fc7902a1896.camel@sipsolutions.net>
         <6c529c77-079e-4817-3f2c-ed60c5cfd1ee@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
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

On Wed, 2022-07-13 at 09:29 -0700, Jeff Johnson wrote:
> On 7/13/2022 9:23 AM, Johannes Berg wrote:
> > On Wed, 2022-07-13 at 18:16 +0200, Johannes Berg wrote:
> > > On Wed, 2022-07-13 at 09:14 -0700, Jeff Johnson wrote:
> > > > On 7/13/2022 2:43 AM, Johannes Berg wrote:
> > > > >     * This structure is the "EHT Operation Element" fields as
> > > > > - * described in P802.11be_D1.4 section 9.4.2.311
> > > > > + * described in P802.11be_D1.5 section 9.4.2.311
> > > >=20
> > > > In D2.0 this has changed to add the fixed 4-octet Basic EHT-MCS
> > > > And Nss Set before the variable-length EHT Operation
> > > > Information
> > > >=20
> > > > Do you have a timeline to incorporate D2.0 changes?
> > > >=20
> > >=20
> > > Erm. I don't know what happened with this patch - it shouldn't have h=
ad
> > > this contents ...
> > >=20
> > > But yes we also have D2.0 changes prepared somewhere.
> > >=20
> >=20
> > I'm not going to repost the set, but I pushed those out too now, with
> > the D1.5 changes broken out from this patch into a proper separate patc=
h
> > - not sure how that happened, sorry.
> >=20
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.=
git/commit/?h=3Dmld&id=3Dd0d0f80a4c685f4bdc7164c15ee6b83b69877e23
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.=
git/commit/?h=3Dmld&id=3Dddfde5917e6ac5d081bf771b3a28125d416c625e
>=20
> Thanks, Johannes. You're awesome as always!
>=20
Well these I can't take credit for, it was Ilan's doing :-)

johannes
