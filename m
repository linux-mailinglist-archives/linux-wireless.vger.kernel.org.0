Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2C8F103697
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 10:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfKTJ2O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 04:28:14 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37994 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726762AbfKTJ2O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 04:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574242093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4P8AxkoeMgsJhci2AUBreMbcjF9DmmicMU49Qec3kgY=;
        b=DVjdeVgbcsZa2NHWHKijNu8haZ6M4dTyIfRBAyrKyuXhe8+b8UEt/YsieCIwdilj/MwQ34
        1aSqE2C0zdwK8rYJDEFCKAU3Fb1l3KNcHA4A+sFBSD/hz8bIcAE00Wr9lkJLCV986c/Gbw
        1AUo8n5leAVSRcCEqKhLI4ZyI0CbNHs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-IJa3Lri6M_C8ggSOWhcfwQ-1; Wed, 20 Nov 2019 04:28:10 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A244107ACC5;
        Wed, 20 Nov 2019 09:28:09 +0000 (UTC)
Received: from localhost (unknown [10.40.205.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0869D60FFB;
        Wed, 20 Nov 2019 09:28:05 +0000 (UTC)
Date:   Wed, 20 Nov 2019 10:28:04 +0100
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH v6 2/5] mt76: mt76x02: split beaconing
Message-ID: <20191120092803.GA517@redhat.com>
References: <20191119154746.20821-1-markus.theil@tu-ilmenau.de>
 <20191119154746.20821-3-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
In-Reply-To: <20191119154746.20821-3-markus.theil@tu-ilmenau.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: IJa3Lri6M_C8ggSOWhcfwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Nov 19, 2019 at 04:47:43PM +0100, Markus Theil wrote:
> Sending beacons to the hardware always happens in batches. In order to
> speed up beacon processing on usb devices, this patch splits out common
> code an calls it only once (mt76x02_mac_set_beacon_prepare,
> mt76x02_mac_set_beacon_finish). Making this split breaks beacon
> enabling/disabling per vif. This is fixed by adding a call to set the
> bypass mask, if beaconing should be disabled for a vif. Otherwise the
> beacon is send after the next beacon interval.
>=20
> The code is also adapted for the mmio part of the driver, but should not
> have any performance implication there.
>=20
> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
> ---
>  .../wireless/mediatek/mt76/mt76x02_beacon.c   | 44 +++++++------------
>  .../net/wireless/mediatek/mt76/mt76x02_mac.h  |  1 +
>  .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  5 +++
>  .../wireless/mediatek/mt76/mt76x02_usb_core.c |  5 +++
>  4 files changed, 26 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/driver=
s/net/wireless/mediatek/mt76/mt76x02_beacon.c
> index 403866496640..09013adae854 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
> @@ -47,10 +47,6 @@ __mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 b=
cn_idx,
>  =09int beacon_len =3D dev->beacon_ops->slot_size;
>  =09int beacon_addr =3D MT_BEACON_BASE + (beacon_len * bcn_idx);
>  =09int ret =3D 0;
> -=09int i;
> -
> -=09/* Prevent corrupt transmissions during update */
> -=09mt76_set(dev, MT_BCN_BYPASS_MASK, BIT(bcn_idx));
> =20
>  =09if (skb) {
>  =09=09ret =3D mt76x02_write_beacon(dev, beacon_addr, skb);
> @@ -60,41 +56,30 @@ __mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 =
bcn_idx,
>  =09=09dev->beacon_data_mask &=3D ~BIT(bcn_idx);
>  =09}
> =20
> -=09mt76_wr(dev, MT_BCN_BYPASS_MASK, 0xff00 | ~dev->beacon_data_mask);
> -
>  =09return ret;
>  }
> =20
> -int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 vif_idx,
> -=09=09=09   struct sk_buff *skb)
> +void mt76x02_mac_set_beacon_finish(struct mt76x02_dev *dev)
>  {
> -=09bool force_update =3D false;
> -=09int bcn_idx =3D 0;
>  =09int i;
> +=09int bcn_idx =3D 0;
> =20
> -=09for (i =3D 0; i < ARRAY_SIZE(dev->beacons); i++) {
> -=09=09if (vif_idx =3D=3D i) {
> -=09=09=09force_update =3D !!dev->beacons[i] ^ !!skb;
> -=09=09=09dev_kfree_skb(dev->beacons[i]);
> -=09=09=09dev->beacons[i] =3D skb;
> -=09=09=09__mt76x02_mac_set_beacon(dev, bcn_idx, skb);
> -=09=09} else if (force_update && dev->beacons[i]) {
> -=09=09=09__mt76x02_mac_set_beacon(dev, bcn_idx,
> -=09=09=09=09=09=09 dev->beacons[i]);
> -=09=09}
> -
> +=09for (i =3D 0; i < hweight8(dev->mt76.beacon_mask); ++i)
>  =09=09bcn_idx +=3D !!dev->beacons[i];

This looks wrong since we do not calculate all beacons, only=20
up to hweight8(dev->mt76.beacon_mask).

But since we need to calculate number of all beacons we can just
use hweight8(dev->mt76.beacon_mask) directly.

> -=09}
> -
> -=09for (i =3D bcn_idx; i < ARRAY_SIZE(dev->beacons); i++) {
> -=09=09if (!(dev->beacon_data_mask & BIT(i)))
> -=09=09=09break;
> -
> -=09=09__mt76x02_mac_set_beacon(dev, i, NULL);
> -=09}
> =20
>  =09mt76_rmw_field(dev, MT_MAC_BSSID_DW1, MT_MAC_BSSID_DW1_MBEACON_N,
>  =09=09       bcn_idx - 1);
> +
> +=09mt76_wr(dev, MT_BCN_BYPASS_MASK, 0xff00 | ~dev->beacon_data_mask);

I'm not sure if this is correct for multi bss.

In MT7620 manual BCM_BAYPASS_MASK is described as below:

"
Directly bypasses the Tx Beacon frame with the  specified=20
Beacon number. Bit0=3DNth Beacon, bit1=3D(N- 1)th Beacon,... etc.
N is the number of  Beacons defined in the  MULTI_BCN_NUM field in the=20
MAC_BSSID_DW1(offset: 0x1014) register.
0: Disable
1: Enable
"

Assuming manual is correct (it could be wrong) bypass mask should be
calculated differently.

Stanislaw

