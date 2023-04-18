Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BE86E5BE0
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 10:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjDRITI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 04:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjDRITF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 04:19:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7D9618A
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 01:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Ikol0l/TvRGzuG8c6TvFV/l96gE43Z3P2Br4TTBQDGE=;
        t=1681805940; x=1683015540; b=qyhBN9MbcZ/T9EmUUOBDCiAW7UncqSr7mZgJOscPWpB7gZ8
        ltMwhPoOJ56dIrAsEqLarnCvItTUxGpj3R9hTgqxLDBNG36wzMYi0xejIOBdJxjF1tdZ+nq2j+LU+
        bt1+/19qc/W8jrvYtzkdKxnthYGU7ngm3sOheAMGw2nJgOt6ldkgCluALEEUwpnxzJnkgT7HKPtFq
        u4gP4k8qvD/ohVBWJ7o8CxVjGt4wRYHHiMiC3YYEA25cDXUwf3gB+w/p1yQgQh7ThrzJS1WliWEhS
        DNNsJ+J5/AZzXSPySaTpQfLVanN2Ad87rzjOw+iVVUlvu2NNA10HRDbSox+GyXig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pogYD-001XZP-2H;
        Tue, 18 Apr 2023 10:18:57 +0200
Message-ID: <113761966918b2f390d3c9304307b42a0b4a829b.camel@sipsolutions.net>
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Date:   Tue, 18 Apr 2023 10:18:56 +0200
In-Reply-To: <c15e368e-2fea-a1d8-9c0d-db9278ded5e5@quicinc.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
         <20220902161143.5ce3dad3be7c.I92e9f7a6c120cd4a3631baf486ad8b6aafcd796f@changeid>
         <5d82e564-86bf-c26b-077a-d0bc14e2d3c3@quicinc.com>
         <74f3eb848326607b15336c31a02bdd861ccafb47.camel@sipsolutions.net>
         <d10b88b4-0bd7-a38c-e8d7-8982a281c4b3@quicinc.com>
         <e5adbed1524b27228c152ba14f78c550c8730baa.camel@sipsolutions.net>
         <c15e368e-2fea-a1d8-9c0d-db9278ded5e5@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
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

On Mon, 2023-04-17 at 22:13 +0800, Wen Gong wrote:
> On 4/11/2023 3:38 PM, Johannes Berg wrote:
> > On Tue, 2023-04-04 at 11:28 +0800, Wen Gong wrote:
> > > May I also add a field such as "u16 active_links_count" in struct
> > > wiphy_iftype_ext_capab,
> > > and add logic in function ieee80211_set_vif_links_bitmaps() for stati=
on
> > > like this ?:
> > > if (active_links_count && hweight16(links) <=3D active_links_count)
> > >   =C2=A0=C2=A0=C2=A0 then sdata->vif.active_links =3D links;
> > >=20
> > Also here, not sure it makes sense in cfg80211 level?
> >=20
> > Though I'm not sure what the idea here is at all - you can refuse to
> > link switch etc, what would you use this for?
> If I use ieee80211_set_active_links(),
> then I need add BSS_CHANGED_ASSOC and key for 2nd link in lower-driver.
>=20
> I would like to active all links while assoc,
> then BSS_CHANGED_ASSOC and key will auto set for the 2nd link to=20
> lower-driver from mac80211.

I'm not convinced that makes sense. You're going to have to be able to
deal with changing links after association _anyway_, unless you plan on
breaking the entire connection once any of the links is getting out of
range or something?

So anyway you're going to have to be able to this for new links anyway?
I mean doing key management when link switching, and "association" (in
quotes, because as a term doesn't even make sense since this state is on
the MLD level, not the link level)...

So not sure I get it?

johannes
