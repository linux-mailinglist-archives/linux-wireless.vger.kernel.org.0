Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580D36A5E53
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Feb 2023 18:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjB1RiO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Feb 2023 12:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB1RiK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Feb 2023 12:38:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549792CC7F
        for <linux-wireless@vger.kernel.org>; Tue, 28 Feb 2023 09:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677605845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ulMeVydqLzS1oiwrkOwMzk3aK2LwAQx69lUXeptgqmo=;
        b=Q0CdsssAjmXX6gwHznxo8OdIBdGt+xIvOIF62bDMrlursDkygbuD+piRLe8qA6LFcLHNJz
        xX2WAGS6eKmnCByXj3cvBQ/1t3LYEs7CqBYkX4Z55k6/GOKjqI+sUK6TSfMOUSqyNo1TEp
        4UZn5DDm7WD8RAH4To26nbSqTxKJyN8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-L7fsnHnCNvibq3jQgr2gkA-1; Tue, 28 Feb 2023 12:37:24 -0500
X-MC-Unique: L7fsnHnCNvibq3jQgr2gkA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2D1E3C02183;
        Tue, 28 Feb 2023 17:37:23 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.22.48.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41F81C15BAD;
        Tue, 28 Feb 2023 17:37:23 +0000 (UTC)
Message-ID: <acc996e0b5ef1813e1073200ed50ca57b0b12934.camel@redhat.com>
Subject: Re: [PATCH 2/2] wifi: move raycs, wl3501 and rndis_wlan to legacy
 directory
From:   Dan Williams <dcbw@redhat.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 28 Feb 2023 11:37:22 -0600
In-Reply-To: <87cz5u1ewt.fsf@kernel.org>
References: <20230227121732.8967-1-kvalo@kernel.org>
         <20230227121732.8967-3-kvalo@kernel.org>
         <cc905b745580b0300d10f1f88d714305c7544f67.camel@redhat.com>
         <87ilfmrkil.fsf@kernel.org>
         <c3f831e111e056c32f1822dde602e48eb764ea4f.camel@redhat.com>
         <87cz5u1ewt.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-02-28 at 08:29 +0200, Kalle Valo wrote:
> Dan Williams <dcbw@redhat.com> writes:
>=20
> > On Mon, 2023-02-27 at 21:11 +0200, Kalle Valo wrote:
> > > Dan Williams <dcbw@redhat.com> writes:
> > >=20
> > > > On Mon, 2023-02-27 at 14:17 +0200, Kalle Valo wrote:
> > > > > To clean up drivers/net/wireless move the old drivers drivers
> > > > > left in
> > > > > the
> > > > > directory to a new "legacy" directory. I did consider adding
> > > > > CONFIG_WLAN_VENDOR_LEGACY like other vendors have but then
> > > > > dropped
> > > > > the idea as
> > > > > these are really old drivers and hopefully we get to remove
> > > > > them
> > > > > soon.
> > > >=20
> > > > Why is rndis_wlan legacy? It supports devices that are way
> > > > newer
> > > > than
> > > > ray_cs or wl3501... like this Linksys WUSB54GSC from late 2007:
> > > >=20
> > > > [1086339.589565] rndis_wlan 1-3:1.0 wlan0: register
> > > > 'rndis_wlan' at
> > > > usb-0000:00:14.0-3, Wireless RNDIS device, BCM4320b based,
> > > > 00:1d:7e:9e:2f:bb
> > > > [1086339.589961] usbcore: registered new interface driver
> > > > rndis_wlan
> > >=20
> > > So you have this device? Does it work? I think I should make a
> > > table
> > > somewhere for these old drivers with last success reports :)
> >=20
> > Yep, I have it, it works. Needless to say, I don't *use* it.
>=20
> Yeah, I guessed that part :) But thanks for testing, good to know it
> works.
>=20
> > > > Dunno, just seems a completely different class of devices than
> > > > old
> > > > 802.11b-only PCMCIA ones...
> > >=20
> > > I was about to say that all drivers using Wireless Extensions are
> > > legacy, but to my surprise rndis_wlan actually uses cfg80211 :)
> > >=20
> > > I put this to "legacy" as I didn't find any better location and
> > > adding a
> > > new vendor driver just for rndis_wlan felt like overkill. The
> > > directory
> > > name "legacy" is just a name, it has no real meaning and users
> > > won't
> > > see
> > > it either. It could be "misc", "old" or something else as well.
> >=20
> > Is the goal just to get all the .c individual drivers out of
> > net/wireless?=20
>=20
> Yes, exactly. The extra files in drivers/net/wireless annoy me
> everytime
> when I'm checking something in the tree.

ray_cs and wl3501_cs are also PCMCIA drivers (not CardBus) and isn't
Arnd trying to get rid of PCMCIA via "[RFC 0/6] pcmcia: separate 16-bit
support from cardbus"?

Maybe those two drivers get solved for you :)

> > Also isn't Greg KH out to kill RNDIS too? I don't recall that being
> > a
> > settled question yet, but I lost track.
>=20
> I haven't heard anything about that recently, I hope we don't have to
> remove rndis_wlan from the tree. But wext drivers are another thing,
> we
> really should get rid of them (or convert to cfg80211).

I have vague, morbid interest in converting atmel and prism54 to
cfg80211 but timeline on that would be "this year".

Dan

