Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48BDDEF789
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 09:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbfKEIxS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 03:53:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29689 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729171AbfKEIxS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 03:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572943996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YVPc0+mqquR3l7zUD0Sc0a1/wfluhM4tfIW9rRnKpZk=;
        b=XisHm7F+bV4vHt79PgEzGe2tDIqw+m1Ps92CqcL4SJb494SB+Q37e65udd3bUryfg1hU7W
        gamlZgnpSoYrgKkmFSB5aa/ZC35deto2p088+zOeVRvSQcj0pDCCbrs1JkrHZrr0CKtqol
        g2EDQFujaa0ThEfPFtpev5Du1muBt2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-XUojAqkKNSezxNrM1BE4jQ-1; Tue, 05 Nov 2019 03:53:13 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F64D107ACC2;
        Tue,  5 Nov 2019 08:53:12 +0000 (UTC)
Received: from localhost (unknown [10.40.205.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C57D600C4;
        Tue,  5 Nov 2019 08:53:06 +0000 (UTC)
Date:   Tue, 5 Nov 2019 09:53:05 +0100
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, nbd@nbd.name,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: mt76x02: fix num slots in beacon config init
Message-ID: <20191105085305.GA21352@redhat.com>
References: <20191104150341.13896-1-markus.theil@tu-ilmenau.de>
 <20191104154537.GE3935@localhost.localdomain>
 <a6238611-45d6-ffbc-1db2-2b3203c987f8@tu-ilmenau.de>
MIME-Version: 1.0
In-Reply-To: <a6238611-45d6-ffbc-1db2-2b3203c987f8@tu-ilmenau.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: XUojAqkKNSezxNrM1BE4jQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 04, 2019 at 05:07:16PM +0100, Markus Theil wrote:
> On 04.11.19 16:45, Lorenzo Bianconi wrote:
> >> mt76x02 mmio and usb devices use a different number of beacon slots (8
> >> vs. 5). Consider this in mt76x02_init_beacon_config.
> >>
> >> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
> >> ---
> >>  drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/dri=
vers/net/wireless/mediatek/mt76/mt76x02_beacon.c
> >> index 4209209ac940..b7412953ff26 100644
> >> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
> >> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
> >> @@ -249,7 +249,7 @@ void mt76x02_init_beacon_config(struct mt76x02_dev=
 *dev)
> >>  =09mt76_set(dev, MT_BEACON_TIME_CFG, MT_BEACON_TIME_CFG_SYNC_MODE);
> >>  =09mt76_wr(dev, MT_BCN_BYPASS_MASK, 0xffff);
> >> =20
> >> -=09for (i =3D 0; i < 8; i++)
> >> +=09for (i =3D 0; i < dev->beacon_ops->nslots; i++)
> >>  =09=09mt76x02_mac_set_beacon(dev, i, NULL);
> >> =20
> >>  =09mt76x02_set_beacon_offsets(dev);
> > Hi Markus,
> >
> > mt76x02_init_beacon_config is run just at bootstrap and it is used to c=
lean all
> > beacon RAM memory. It can't see any issue with the current code.
> >
> > Regards,
> > Lorenzo
> >
> >> --=20
> >> 2.17.1
> >>
> Hi Lorenzo,
>=20
> I just thought this function should overwrite all 8192 byte beacon RAM
> memory. If the loop count is set to 8 it would overwrite 8 x 1024 =3D 819=
2
> byte in the mmio case and 8 x 1638 =3D 13104 byte in the USB case. 1638 i=
s
> 8192 / N_BCN_SLOTS. N_BCN_SLOTS is currently 5 for USB. mt76x02_beacon.c
> has no further checks for beacon_ops->nslots in the case of setting a
> beacon.

We do not override beacon SRAM memory in mt76x02_init_beacon_config()
as bcn_idx increase only if !!dev->beacons[i], so we 8 times nullify
beacon 0 .

Patch is fine though, but things can be optimized more ...

We possibly can skip beacon SRAM nullification at all (even if there is
garbage in the memory, beacon will not be sent if blocked by
MT_BCN_BYPASS_MASK =3D 0xffff). Or nullify SRAM at once. And just set
proper MT_MAC_BSSID_DW1_MBEACON_N value.

Stanislaw

