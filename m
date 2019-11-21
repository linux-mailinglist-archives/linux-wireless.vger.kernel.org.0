Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1AC9105287
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 13:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfKUM6v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 07:58:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42554 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726554AbfKUM6v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 07:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574341130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LlUSWR7i4MVMz++GpO9EMyzq8PClYFfOQBQsIzTVyUk=;
        b=EqG9NXwBJdc6FnVQQ1z7WQnwgL1uTIHKHpg95Jl5TwRW7w5+8hR0fnNW4qn/iDFVImQYFj
        ty1LMzTp53TaLwGZtARTy2Bj0onQr7jiFF2XDTE25IJsdhrFjGrYSfDS5C3TqhKu68MxwV
        RCAYQLfEVhrH2epVYjT5lLw+gB877dQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-ijfBycWsOUmy0T_KsfdGtQ-1; Thu, 21 Nov 2019 07:58:49 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5BBA18557D0;
        Thu, 21 Nov 2019 12:58:47 +0000 (UTC)
Received: from localhost (unknown [10.40.206.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8ACC128DF8;
        Thu, 21 Nov 2019 12:58:44 +0000 (UTC)
Date:   Thu, 21 Nov 2019 13:58:43 +0100
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH v6 2/5] mt76: mt76x02: split beaconing
Message-ID: <20191121125842.GB13833@redhat.com>
References: <20191119154746.20821-1-markus.theil@tu-ilmenau.de>
 <20191119154746.20821-3-markus.theil@tu-ilmenau.de>
 <20191120092803.GA517@redhat.com>
 <91b706b5-68b4-9679-a209-872f326de937@tu-ilmenau.de>
MIME-Version: 1.0
In-Reply-To: <91b706b5-68b4-9679-a209-872f326de937@tu-ilmenau.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ijfBycWsOUmy0T_KsfdGtQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Nov 20, 2019 at 11:27:55PM +0100, Markus Theil wrote:
> >> -=09}
> >> -
> >> -=09for (i =3D bcn_idx; i < ARRAY_SIZE(dev->beacons); i++) {
> >> -=09=09if (!(dev->beacon_data_mask & BIT(i)))
> >> -=09=09=09break;
> >> -
> >> -=09=09__mt76x02_mac_set_beacon(dev, i, NULL);
> >> -=09}
> >> =20
> >>  =09mt76_rmw_field(dev, MT_MAC_BSSID_DW1, MT_MAC_BSSID_DW1_MBEACON_N,
> >>  =09=09       bcn_idx - 1);
> >> +
> >> +=09mt76_wr(dev, MT_BCN_BYPASS_MASK, 0xff00 | ~dev->beacon_data_mask);
> > I'm not sure if this is correct for multi bss.
> >
> > In MT7620 manual BCM_BAYPASS_MASK is described as below:
> >
> > "
> > Directly bypasses the Tx Beacon frame with the  specified=20
> > Beacon number. Bit0=3DNth Beacon, bit1=3D(N- 1)th Beacon,... etc.
> > N is the number of  Beacons defined in the  MULTI_BCN_NUM field in the=
=20
> > MAC_BSSID_DW1(offset: 0x1014) register.
> > 0: Disable
> > 1: Enable
> > "
> >
> > Assuming manual is correct (it could be wrong) bypass mask should be
> > calculated differently.
> >
> > Stanislaw
> >
> I tested the updated code with my usb nic and an mbss with 2 ap vifs.
> Both beacons were transmitted. Maybe the manual is wrong in this place.

If MAC_BSSID_DW1_MBEACON_N is set to 1 (2 beacons) according to manual
bit0 is for second beacon slot and bit1 is for first beacon slot.
Those bits are both marked at once, so no problem will happen.

Problem may happen when you remove first vif/beacon. Then you will
have bit1 marked in ->beacon_data_mask . But bit0 will be expect
in BCM_BAYPASS_MASK by hardware (when MAC_BSSID_DW1_MBEACON_N=3D0)

This scenarios can be extended to more vifs. So if you no longer=20
use bcn_idx and use vif_idx directly to point beacon slot/address.
(ie. before for vif_idx 0,4,6, bcn_idx were 0,1,2 now there
will be 0,4,6). You need to specify 7 (8 beacons) in
MT_MAC_BSSID_DW1_MBEACON_N, and set bypass mask accordingly.
For example:

=09mt76_rmw_field(dev, MT_MAC_BSSID_DW1, MT_MAC_BSSID_DW1_MBEACON_N, 7);
=09mask =3D 0;
=09for (i =3D 0; i < 8; i++)
=09=09if (dev->beacons[i])
=09=09=09mask |=3D BIT(7 - i);

=09mt76_wr(dev, MT_BCN_BYPASS_MASK, 0xff00 | ~mask);

But again, this have to be tested. Ideally on mmio hardware which
support more bssid's or on usb hardware with temporally increased
num of bss limitation.

Stanislaw

