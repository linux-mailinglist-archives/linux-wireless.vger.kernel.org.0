Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECD16A7151
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 17:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjCAQf5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 11:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjCAQfi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 11:35:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C2522794
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 08:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677688392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mBvJUqzz0B1IR3okz9xKdGxW4Xa3WX575vqp41+ynxk=;
        b=Pk50P+Wmk3ypmngs6KSgQbS6bJVeQ6BGUF9TWFaV0SOP9xneXUnk/2mcHrl4cBNivKIBG7
        c6l5kTU3o6JJkm4Vex2fpYcKbyugBKV1BBLfv8vhovOKDzULfka7n3Eya4SR6ZBoDmIcKh
        cM+cMFisAKvP4XKeX1ynrR3zWWweGnU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-fIkx4UotPWyMFy8-HMt4Jg-1; Wed, 01 Mar 2023 11:33:11 -0500
X-MC-Unique: fIkx4UotPWyMFy8-HMt4Jg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C45C486C168;
        Wed,  1 Mar 2023 16:33:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.22.48.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 485A5492C3E;
        Wed,  1 Mar 2023 16:33:10 +0000 (UTC)
Message-ID: <55672530d98e4ffb427da8253a8d52f5a6703d93.camel@redhat.com>
Subject: Re: [PATCH 2/2] wifi: move raycs, wl3501 and rndis_wlan to legacy
 directory
From:   Dan Williams <dcbw@redhat.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 01 Mar 2023 10:33:09 -0600
In-Reply-To: <877cw1q76q.fsf@kernel.org>
References: <20230227121732.8967-1-kvalo@kernel.org>
         <20230227121732.8967-3-kvalo@kernel.org>
         <cc905b745580b0300d10f1f88d714305c7544f67.camel@redhat.com>
         <87ilfmrkil.fsf@kernel.org>
         <c3f831e111e056c32f1822dde602e48eb764ea4f.camel@redhat.com>
         <87cz5u1ewt.fsf@kernel.org>
         <acc996e0b5ef1813e1073200ed50ca57b0b12934.camel@redhat.com>
         <877cw1q76q.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-03-01 at 09:09 +0200, Kalle Valo wrote:
> Dan Williams <dcbw@redhat.com> writes:
>=20
> > > > Is the goal just to get all the .c individual drivers out of
> > > > net/wireless?=20
> > >=20
> > > Yes, exactly. The extra files in drivers/net/wireless annoy me
> > > everytime
> > > when I'm checking something in the tree.
> >=20
> > ray_cs and wl3501_cs are also PCMCIA drivers (not CardBus) and isn't
> > Arnd trying to get rid of PCMCIA via "[RFC 0/6] pcmcia: separate 16-bit
> > support from cardbus"?
> >=20
> > Maybe those two drivers get solved for you :)
>=20
> That would be great :)
>=20
> > > > Also isn't Greg KH out to kill RNDIS too? I don't recall that being
> > > > a
> > > > settled question yet, but I lost track.
> > >=20
> > > I haven't heard anything about that recently, I hope we don't have to
> > > remove rndis_wlan from the tree. But wext drivers are another thing,
> > > we
> > > really should get rid of them (or convert to cfg80211).
> >=20
> > I have vague, morbid interest in converting atmel and prism54 to
> > cfg80211 but timeline on that would be "this year".
>=20
> As you already noticed, prism54 is already gone. But I'm keeping fingers
> crossed that who you would have time to convert atmel :)
>=20
> We really should get rid of wext, at least from drivers/net/wireless.
> Staging drivers are of course of another thing. Just for fun I decided
> to grep how many wext drivers and the first match was an ethernet
> driver, weird:
>=20
> drivers/net/ethernet/toshiba/ps3_gelic_wireless.c:2570: netdev->wireless_=
handlers =3D &gelic_wl_wext_handler_def;

Not super odd; that's the PlayStation 3. HW is an odd combo of ethernet
and WiFi and the FW interface is bizarre as you can see. At least it
supports 802.11g and WPA which is more than we can say for ipw2100.

>=20
> These are the mainline drivers using wext:
>=20
> drivers/net/wireless/atmel/atmel.c:1574:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0dev->wireless_handlers =3D &atmel_handler_def;
> drivers/net/wireless/cisco/airo.c:2674:=C2=A0dev->wireless_handlers =3D &=
airo_handler_def;
> drivers/net/wireless/cisco/airo.c:2828:=C2=A0dev->wireless_handlers =3D &=
airo_handler_def;
> drivers/net/wireless/intel/ipw2x00/ipw2100.c:6032:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0dev->wireless_handlers =3D &ipw2100_wx_handler_def;
> drivers/net/wireless/intel/ipw2x00/ipw2200.c:11675:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0net_dev->wireless_handlers =3D &ipw_wx_handler_def;
> drivers/net/wireless/intersil/hostap/hostap_main.c:851:=C2=A0dev->wireles=
s_handlers =3D &hostap_iw_handler_def;
> drivers/net/wireless/intersil/orinoco/main.c:2251:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0dev->wireless_handlers =3D &orinoco_handler_def;
> drivers/net/wireless/ray_cs.c:303:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev=
->wireless_handlers =3D &ray_handler_def;
> drivers/net/wireless/wl3501_cs.c:1886:=C2=A0=C2=A0dev->wireless_handlers=
=C2=A0=C2=A0=3D &wl3501_handler_def;
> drivers/net/wireless/zydas/zd1201.c:1782:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0dev->wireless_handlers =3D &zd1201_iw_handlers;

FWIW orinoco and ipw2x00 have some minimal cfg80211 code but IIRC it's
pretty limited.

Honestly we probably should start deprecation/removal for 802.11b-only
hardware which is everything on this list *except* ps3_gelic and
ipw2200.

Dan

>=20
> And these are the staging drivers:
>=20
> drivers/staging/ks7010/ks_wlan_net.c:2636:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0dev->wireless_handlers =3D &ks_wlan_handler_def;
> drivers/staging/r8188eu/os_dep/os_intfs.c:358:=C2=A0=C2=A0pnetdev->wirele=
ss_handlers =3D (struct iw_handler_def *)&rtw_handlers_def;
> drivers/staging/rtl8192e/rtl8192e/rtl_core.c:2334:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0dev->wireless_handlers =3D &r8192_wx_handlers_def;
> drivers/staging/rtl8192u/r8192U_core.c:4532:=C2=A0=C2=A0=C2=A0=C2=A0dev->=
wireless_handlers =3D &r8192_wx_handlers_def;
> drivers/staging/rtl8712/os_intfs.c:214:=C2=A0pnetdev->wireless_handlers =
=3D (struct iw_handler_def *)
>=20

