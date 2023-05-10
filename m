Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F088F6FDDC5
	for <lists+linux-wireless@lfdr.de>; Wed, 10 May 2023 14:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbjEJMZn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 May 2023 08:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbjEJMZm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 May 2023 08:25:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBFA1BD
        for <linux-wireless@vger.kernel.org>; Wed, 10 May 2023 05:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=fH86BazKajYWz6GKOtNlQLeQieZJZxHPckvxia2YnZo=;
        t=1683721541; x=1684931141; b=srz3aerLnh+WKH1iLz2U4uGOYuCTKkda8xPhPF8Hytcas/Y
        ZhOpsSW4VJZcjRLjzrQgraBIoTp0xTPLEJ+gNPp5olIrb1n+c88154wT1mdilLXedPInp6UkKCB4w
        berEA3KsweEgpBqT8TL2u3CUtDcCrfAblVFcoZo17FvLY60J4nZ1tzUgDfoAzztoSRmtWH/jyU6sA
        jbsewgfT6yYVz7o0MyoirzsEaF7iLgVyOXrZejtOc6kTW9xBoptwVjYwqThIRQ+9uan79DBKT+DJB
        1kRhvjbXbz3u/D0fHRF+sCzbCoD7kvmyIBXcncmeq0RiRQ1EVDwgKAtHo2v+3xDw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pwit0-005OZF-1y;
        Wed, 10 May 2023 14:25:38 +0200
Message-ID: <c1adcc4ddeb7c47c3255cc2953d3b9debee681ca.camel@sipsolutions.net>
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Date:   Wed, 10 May 2023 14:25:37 +0200
In-Reply-To: <de1f920b-66f5-fb0a-47a5-622ba6bbbff8@quicinc.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
         <20220902161143.5ce3dad3be7c.I92e9f7a6c120cd4a3631baf486ad8b6aafcd796f@changeid>
         <5d82e564-86bf-c26b-077a-d0bc14e2d3c3@quicinc.com>
         <74f3eb848326607b15336c31a02bdd861ccafb47.camel@sipsolutions.net>
         <d10b88b4-0bd7-a38c-e8d7-8982a281c4b3@quicinc.com>
         <e5adbed1524b27228c152ba14f78c550c8730baa.camel@sipsolutions.net>
         <5e3ec5f8-1462-5de6-2b5a-4cf62f23deb7@quicinc.com>
         <0e7023062f44d0ea68625c27cb13731d17857311.camel@sipsolutions.net>
         <de1f920b-66f5-fb0a-47a5-622ba6bbbff8@quicinc.com>
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

On Wed, 2023-05-10 at 20:25 +0800, Wen Gong wrote:
> On 5/10/2023 7:24 PM, Johannes Berg wrote:
> > On Wed, 2023-05-10 at 19:06 +0800, Wen Gong wrote:
> > > On 4/11/2023 3:38 PM, Johannes Berg wrote:
> > > > On Tue, 2023-04-04 at 11:28 +0800, Wen Gong wrote:
> > > > > May I also add a field such as "u16 active_links_count" in struct
> > > > > wiphy_iftype_ext_capab,
> > > > > and add logic in function ieee80211_set_vif_links_bitmaps() for s=
tation
> > > > > like this ?:
> > > > > if (active_links_count && hweight16(links) <=3D active_links_coun=
t)
> > > > >    =C2=A0=C2=A0=C2=A0 then sdata->vif.active_links =3D links;
> > > > >=20
> > > > Also here, not sure it makes sense in cfg80211 level?
> > > >=20
> > > > Though I'm not sure what the idea here is at all - you can refuse t=
o
> > > > link switch etc, what would you use this for?
> > > >=20
> > > > Then again, we haven't really designed out all the link selection s=
tuff,
> > > > do we want wpa_s to do it, driver to do it, etc.? Hence debugfs. So
> > > > depending on what end up doing there, we will obviously need to
> > > > advertise some level of link-concurrency to userspace.
> > > So will you plan to do something to let wpa_s/userspace app
> > > active/deactive links?
> > >=20
> > > Or you already have implemented that?
> > >=20
> > No plans right now, and honestly not sure what the right thing even is.
> OK. For "advertise some level of link-concurrency to userspace", do you=
=20
> have any plan/idea?

No, not really.

johannes
>=20
