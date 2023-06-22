Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B653573A681
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jun 2023 18:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjFVQw1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jun 2023 12:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjFVQw0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jun 2023 12:52:26 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5F710A
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 09:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1g6hYCNiNYmwPnQqbFbrbNpEP2N/g5kds1WiiOQ5moE=;
        t=1687452745; x=1688662345; b=Rq2tTvg0/N9VLiX3EJBBNkor3VLb4B6oEGQmuFV46uf5+qh
        qJFMUa4/5hW6UMggCSj2prR75E/nSoADahK4mteMyB7gxUOrJD47a+ABpz/L0GjCNOZInVG7W1sbU
        1qOf36ugKHWjdJPftDPjKz6tRaDMOJXpZitsYpyY3SgHrmrqtc6vygQd7K+MG+d6KQwor2L1ywtVW
        N5rDx65sqbChk0ssJzXWXzDVE0erTouD3IvCydq25mgv66cJTwBx9DcIPQGDpLxsg5ekoDrMHSzoZ
        8fHPUDVBESQD3mFUgI5mSsskxs2+fby+Gn13q5YAWtJeYXxLk3tnnK8auyI6dZag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qCNXj-00EpJl-2W;
        Thu, 22 Jun 2023 18:52:23 +0200
Message-ID: <588e079b244f302615cbb07741973035a0c9d42b.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: fix sband iftype data lookup for AP_VLAN
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date:   Thu, 22 Jun 2023 18:52:23 +0200
In-Reply-To: <14bd0b06-d8c1-5c02-42a6-0c8d045b93ff@nbd.name>
References: <20230622160501.40666-1-nbd@nbd.name>
         <adf8c1b8ea96c0c6ddc12579eacb8d9948440dcf.camel@sipsolutions.net>
         <2815ff55-5b5d-1412-5694-7692337bc473@nbd.name>
         <f717c60c24bf3dcec7cd3b0308c6bd804683276a.camel@sipsolutions.net>
         <14bd0b06-d8c1-5c02-42a6-0c8d045b93ff@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
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

On Thu, 2023-06-22 at 18:50 +0200, Felix Fietkau wrote:
> On 22.06.23 18:41, Johannes Berg wrote:
> > On Thu, 2023-06-22 at 18:25 +0200, Felix Fietkau wrote:
> > > On 22.06.23 18:07, Johannes Berg wrote:
> > > > On Thu, 2023-06-22 at 18:05 +0200, Felix Fietkau wrote:
> > > > > Since AP_VLAN interfaces are not pushed to the driver,=20
> > > > >=20
> > > > That's a mac80211 thing though.
> > > >=20
> > > > > the driver should not
> > > > > be expected to register iftype data for them.
> > > > > Map them to the regular AP iftype on lookup.
> > > >=20
> > > > And this is in cfg80211 - not sure that seems right?
> > > >=20
> > > > OTOH I'd expect no callers with VLAN here, it doesn't really make s=
ense
> > > > since they're not a standalone mode that actually has HE/EHT, but s=
till,
> > > > seems odd this way?
> > > >=20
> > > > What's actually calling it? I'm guessing somewhere in mac80211?
> > >=20
> > > Yes, I guess only mac80211 is affected. I put in the cfg80211 prefix
> > > because that's what the header file belongs to.
> > >=20
> > > I made the patch in response to this:
> > > https://patchwork.kernel.org/project/linux-wireless/patch/20230605152=
141.17434-4-shayne.chen@mediatek.com/
> >=20
> > OK, sure, that also doesn't really make sense.
> >=20
> > > I found that there are several calls to ieee80211_get_he_iftype_cap a=
nd
> > > ieee80211_get_eht_iftype_cap, which could be affected by this issue.
> > > I thought dealing with this in a single place would be better than pl=
aying
> > > whac-a-mole by fixing it at the call sites.
> > >=20
> >=20
> > I replaced almost all of them with ieee80211_get_he_iftype_cap_vif() so
> > it shouldn't be that bad? Looks like I forgot some though.
>=20
> I guess one advantage in using my fix would be that it's way easier to=
=20
> backport.
> How about using my fix initially (with a changed prefix if you prefer),=
=20
> and then replace it once the call sites have been switched over to=20
> ieee80211_get_he_iftype_cap_vif?
>=20

Actually, I don't even mind the fix itself that much, I just think the
description is a bit misleading :-)

How about just describing it as something like "AP_VLAN is virtual so it
doesn't really exist as a type for capabilities; surely AP was
intended"?

I can kind of see how this might happen too, you have a STA, check the
interface, etc.

johannes
