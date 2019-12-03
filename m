Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27DAA10F959
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2019 08:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfLCH5n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Dec 2019 02:57:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37900 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727491AbfLCH5n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Dec 2019 02:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575359861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cDWEBHCnG2vGwY1nP9LtEUIVTK6pOZmQ4hIi7g8vyBg=;
        b=RTqz8REd73ALqo8o1MSzuld5JtuTlCFZ+dGOiEmH/p/7b4303fmHw1/1by6TpxgtorqtLX
        DpNIj+ApkihiwciofMPdhQykXyGx7APDekjygRVVo3Gr9p6+B4drPvl5wazi1DywTDty1K
        9uzwtEbsGg1jQETt1izyU29lNL/yi08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-LigURxhuO_Cwm02mkwznNQ-1; Tue, 03 Dec 2019 02:57:39 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B07212A7E2F;
        Tue,  3 Dec 2019 07:57:38 +0000 (UTC)
Received: from localhost (ovpn-204-228.brq.redhat.com [10.40.204.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 059C210016DA;
        Tue,  3 Dec 2019 07:57:37 +0000 (UTC)
Date:   Tue, 3 Dec 2019 08:57:36 +0100
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Exuvo <exuvo@exuvo.se>
Cc:     linux-wireless@vger.kernel.org,
        Helmut Schaa <helmut.schaa@googlemail.com>
Subject: Re: rt2x00 regression
Message-ID: <20191203075736.GA701@redhat.com>
References: <bff7d309-a816-6a75-51b6-5928ef4f7a8c@exuvo.se>
 <20190927080303.GA7667@redhat.com>
 <CA+GwT0B5SyRZnGLqwqOeuJK4CWMVc=dKaWre9VN8KQC6kBzKGw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+GwT0B5SyRZnGLqwqOeuJK4CWMVc=dKaWre9VN8KQC6kBzKGw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: LigURxhuO_Cwm02mkwznNQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 02, 2019 at 05:40:20PM +0100, Exuvo wrote:
> Sorry for the late reply
>=20
> The patch for increasing the amount did not work, i'll get around to
> testing with the commit reverted.

So, revert of that commit makes the problem gone ?

> As an aside what function can i call at that point in the code to print t=
he
> value in num_proto_errs? I assume some kernel special printf?
It's printk. You can add line like this to print values:

printk("status %d num_proto_errs %u\n", status, rt2x00dev->num_proto_errs);

Stanislaw


> On Fri, 27 Sep 2019, 10:03 Stanislaw Gruszka, <sgruszka@redhat.com> wrote=
:
>=20
> > On Thu, Sep 26, 2019 at 06:32:23PM +0200, Anton Olsson wrote:
> > > Hello I have a USB based ID 148f:3070 Ralink Technology, Corp.
> > RT2870/RT3070 Wireless Adapter, that stops working with recent kernels.=
 It
> > works on kernel 5.1.15 and does not work with 5.2.7 or 5.3.1 (I have no=
t
> > tested other versions). I use it in AP mode.
> > >
> > > I found this similar bug report
> > https://marc.info/?l=3Dlinux-wireless&m=3D156630037103575&w=3D2 but tha=
t did
> > not have related error messages so I assume this is different?
> > >
> > > Logs of working kernel 5.1.15-arch1-1-ARCH.
> > > [   78.680555] ieee80211 phy0: rt2x00_set_rt: Info - RT chipset 3070,
> > rev 0201 detected
> > > [   78.690992] ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0005
> > detected
> > > [   78.799625] ieee80211 phy0: Selected rate control algorithm
> > 'minstrel_ht'
> > > sep 26 17:13:03 kernel: usbcore: registered new interface driver
> > rt2800usb
> > > sep 26 17:13:03 systemd[1]: Found device RT2870/RT3070 Wireless Adapt=
er.
> > > [  113.812454] ieee80211 phy0: rt2x00lib_request_firmware: Info -
> > Loading firmware file 'rt2870.bin'
> > > [  113.905279] ieee80211 phy0: rt2x00lib_request_firmware: Info -
> > Firmware detected - version: 0.36
> > > [  114.028703] ieee80211 phy0: rt2x00usb_vendor_request: Error - Vend=
or
> > Request 0x06 failed for offset 0x0404 with error -71
> > >
> > > The last error there does not seem to affect the operation of the dev=
ice.
> > >
> > > Logs of not working with kernel 5.3.1, 5.2.7 has similar output.
> > > sep 26 17:06:12 kernel: ieee80211 phy0: rt2x00_set_rt: Info - RT chip=
set
> > 3070, rev 0201 detected
> > > sep 26 17:06:12 kernel: ieee80211 phy0: rt2x00_set_rf: Info - RF chip=
set
> > 0005 detected
> > > sep 26 17:06:12 kernel: ieee80211 phy0: Selected rate control algorit=
hm
> > 'minstrel_ht'
> > > sep 26 17:06:12 kernel: usbcore: registered new interface driver
> > rt2800usb
> > > sep 26 17:06:12 systemd[1]: Found device RT2870/RT3070 Wireless Adapt=
er.
> > > sep 26 17:06:21 ieee80211 phy0: rt2x00lib_request_firmware: Info -
> > Loading firmware file 'rt2870.bin'
> > > sep 26 17:06:21 ieee80211 phy0: rt2x00lib_request_firmware: Info -
> > Firmware detected - version: 0.36
> > > sep 26 17:06:21 ieee80211 phy0: rt2x00usb_vendor_request: Error - Ven=
dor
> > Request 0x06 failed for offset 0x0404 with>
> > > sep 26 17:06:22 ieee80211 phy0: rt2800_wait_csr_ready: Error - Unstab=
le
> > hardware
> > > sep 26 17:06:22 ieee80211 phy0: rt2800usb_set_device_state: Error -
> > Device failed to enter state 4 (-5)
> > >
> > > Unable to bring up the network interface here.
> >
> > This most likely is the problem introduced by commit:
> >
> > commit e383c70474db32b9d4a3de6dfbd08784d19e6751
> > Author: Stanislaw Gruszka <sgruszka@redhat.com>
> > Date:   Tue Mar 12 10:51:42 2019 +0100
> >
> >     rt2x00: check number of EPROTO errors
> >
> > Plase check below patch that increase number of EPROTO checks
> > before marking device removed. If it does not help, plese
> > check if reverting above commits helps.
> >
> > diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> > b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> > index bc2dfef0de22..215c3f092306 100644
> > --- a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> > +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> > @@ -30,7 +30,7 @@ static bool rt2x00usb_check_usb_error(struct rt2x00_d=
ev
> > *rt2x00dev, int status)
> >         else
> >                 rt2x00dev->num_proto_errs =3D 0;
> >
> > -       if (rt2x00dev->num_proto_errs > 3)
> > +       if (rt2x00dev->num_proto_errs > 8)
> >                 return true;
> >
> >         return false;
> >

