Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BFC56340B
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Jul 2022 15:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbiGANIX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Jul 2022 09:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiGANIW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Jul 2022 09:08:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EE114035
        for <linux-wireless@vger.kernel.org>; Fri,  1 Jul 2022 06:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=WRR2a7zQNUGOPWONXeK+EK0N2B1DHw3R1BDJNKtC/CU=;
        t=1656680901; x=1657890501; b=tZpBiBRmcMP2HFrd0VTFiLEtN3o9U7Gjd52BXfbpCphVKAh
        3A9zUsV8XdRD6bvEkwUnWru55Gyl4Xe2qqoKJMWyHgioCDhk0hftCZo9r0jT7lFOZeiFkv/Mvu7C6
        yEFMP3vAdUo5LBV/cGiLX262Qp3bm4/gZnAkhSd43IQfQs08lF50Md4DuMoNlOxoEEvw8sn4SFXZM
        xkteAw3dmuw9BsEqnOANf1n2q6PXMsOQsSOEVe9UbC9HNYiSCOGwvlvdGjW8dVXAHTJ6BTgWk8LFW
        fsOrQulgOfeOYPjBgHHboHsbLXFoeL71rsS6p9MlIjTDJ00ZNdpx3nZ+m6afA95w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1o7GNd-003UmJ-72;
        Fri, 01 Jul 2022 15:08:17 +0200
Message-ID: <d383ef715a7186cb382ff9450878747b8384dd0f.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: report per-chain signal values through
 ethtool.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 01 Jul 2022 15:08:16 +0200
In-Reply-To: <c7ee84a4-2be5-4176-2701-8c2e691a85fe@candelatech.com>
References: <20220329210228.8137-1-greearb@candelatech.com>
         <8542c3eac729563fef1bc78d28c740453fba88bd.camel@sipsolutions.net>
         <c7ee84a4-2be5-4176-2701-8c2e691a85fe@candelatech.com>
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

On Fri, 2022-07-01 at 06:05 -0700, Ben Greear wrote:
> On 7/1/22 2:55 AM, Johannes Berg wrote:
> > On Tue, 2022-03-29 at 14:02 -0700, greearb@candelatech.com wrote:
> > > From: Ben Greear <greearb@candelatech.com>
> > >=20
> > > Combine them into a u64, each byte is one chain.
> >=20
> > This only works up to 4 chains, but the specs at least support 8. I
> > don't think we have any drivers for that, but ...
>=20
> u64 gives 8 bytes, so the ethtool part can support 8 chains.
> The mac80211 part only supports up to 4 chains currently though.

Oops, right, sorry.

Still, I'm not sure I like munging it all up into one value - the value
itself then doesn't mean anything, and the normal ethtool APIs userspace
tools would be pretty much useless for it?

> > We're reporting these through nl80211 anyway though, no? Why should we
> > prefer ethtool, which fundamentally limits to a single value for the AP
> > rather than giving the full per-station view.
>=20
> I already gather ethtool stats for STA vdevs, so adding another stat is
> basically free as far as performance is concerned.  That is important
> to me.  I do not currently program much against netlink API (just scrape
> existing tools output).

Well I guess then I think you probably should program against the
netlink API :)

> > > Re-work the way that APs averaged stats to be more
> > > efficient.
> >=20
> > Isn't that completely unrelated?
>=20
> At least somewhat unrelated.
>=20

Fair enough. Maybe send that separately? I guess that's something I'd
understand a bit more and improving the existing code is an easier sell
than adding a whole new thing there :)

johannes
