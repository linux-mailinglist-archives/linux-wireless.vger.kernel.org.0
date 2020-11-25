Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744152C46C9
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Nov 2020 18:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732753AbgKYR3z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 12:29:55 -0500
Received: from mail-03.mail-europe.com ([91.134.188.129]:42076 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731392AbgKYR3y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 12:29:54 -0500
Date:   Wed, 25 Nov 2020 17:29:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1606325391;
        bh=NtCMlerF2C02xUHSqgq12ucBsNQ2hw7zeXg9YVNPYms=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:From;
        b=EGtlIHRHvVAu5UwbmVU/7lcN8MVbr+XziB9J2ftIXrFwUH/6rIrfdxgL5tG94/3IP
         hXb1xphfxDJabEt/08woR2SAfB0mFcCvNvLOt45lKm+9Hxp1en7CmVr58wNqXe3vam
         yXp5NaxUWvV5hZWxGOEix6ZyqBBJF+N4HyQPYSqM=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   cristian_ci <cristian_ci@protonmail.com>
Reply-To: cristian_ci <cristian_ci@protonmail.com>
Subject: Re: mediatek: mt7601u: driver fails
Message-ID: <L2x-FhQWkMbY4sVs8hFx2gMZRVncePrgjWBvThJkwKKfBeLU_fkf38cp55x7bv0UNYcY9X0EtmaQIydOjUJrJa7zWzg0XE8_CyrqCXMMWpY=@protonmail.com>
In-Reply-To: <7ZXTz4VMY76wIhNnRJtybPhyH_bQKtHuyH_v1n8hpRMmoeid8dFjHii1hOmEcib1q5KH2o8SlUAT6XZyTX1PKh15zT5-feZdNdaIeHgC5K8=@protonmail.com>
References: <7ZXTz4VMY76wIhNnRJtybPhyH_bQKtHuyH_v1n8hpRMmoeid8dFjHii1hOmEcib1q5KH2o8SlUAT6XZyTX1PKh15zT5-feZdNdaIeHgC5K8=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It could be useful posting phy.c related patch directly:

@@ -586,7 +586,7 @@

 void mt7601u_phy_recalibrate_after_assoc(struct mt7601u_dev *dev)
 {
-=09mt7601u_mcu_calibrate(dev, MCU_CAL_DPD, dev->curr_temp);
+=09//mt7601u_mcu_calibrate(dev, MCU_CAL_DPD, dev->curr_temp);

 =09mt7601u_rxdc_cal(dev);
 }
@@ -1153,12 +1153,12 @@
 =09ret =3D mt7601u_mcu_calibrate(dev, MCU_CAL_TXIQ, 0);
 =09if (ret)
 =09=09return ret;
-=09ret =3D mt7601u_mcu_calibrate(dev, MCU_CAL_RXIQ, 0);
-=09if (ret)
-=09=09return ret;
-=09ret =3D mt7601u_mcu_calibrate(dev, MCU_CAL_DPD, dev->dpd_temp);
-=09if (ret)
-=09=09return ret;
+=09//ret =3D mt7601u_mcu_calibrate(dev, MCU_CAL_RXIQ, 0);
+=09//if (ret)
+=09//=09return ret;
+=09//ret =3D mt7601u_mcu_calibrate(dev, MCU_CAL_DPD, dev->dpd_temp);
+=09//if (ret)
+=09//=09return ret;

 =09mt7601u_rxdc_cal(dev);


Waiting for a reply,

Cristian.

Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Sunday 15 November 2020 22:57, cristian_ci <cristian_ci@protonmail.com> =
wrote:

> When I connect usb wireless adapter:
>
> Bus 002 Device 111: ID 148f:7601 Ralink Technology, Corp. MT7601U Wireles=
s Adapter
>
> I notice continuos spamming messages to dmesg output:
>
> mt7601u 2-1.3:1.0: rx urb failed: -71
> mt7601u 2-1.3:1.0: Error: MCU resp urb failed:-71
> mt7601u 2-1.3:1.0: Error: MCU resp evt:0 seq:5-4!
>
> and:
>
> mt7601u 2-1.3:1.0: Error: mt7601u_mcu_wait_resp timed out
> mt7601u 2-1.3:1.0: Vendor request req:07 off:0080 failed:-71
> mt7601u 2-1.3:1.0: Vendor request req:02 off:0080 failed:-71
> mt7601u 2-1.3:1.0: Vendor request req:02 off:0080 failed:-71
> mt7601u: probe of 2-1.3:1.0 failed with error -110
>
> and then device is reset,, disconnecting and reconnecting itself in a loo=
p, making mt7601 module to fail probing.
>
> This failure happens just only with linux but not with 3.0.x kernel serie=
s. Just newer kernel versions are affected.
>
> If I make the following changes to drivers/net/wireless/mediatek/mt7601u/=
phy.c source code, mt7601 module is successfully probed, instead.
>
> In order to do that, in mt7601u_init_cal function you have to comment the=
se lines:
>
> ret =3D mt7601u_mcu_calibrate(dev, MCU_CAL_RXIQ, 0);
> if (ret)
> return ret;
> ret =3D mt7601u_mcu_calibrate(dev, MCU_CAL_DPD, dev->dpd_temp);
> if (ret)
> return ret;
>
> In mt7601u_phy_recalibrate_after_assoc function you have to comment this =
line:
>
> mt7601u_mcu_calibrate(dev, MCU_CAL_DPD, dev->curr_temp);
>
> Waiting for an answer, thanks in advance,
>
> Cristian.
>
> Sent with ProtonMail Secure Email.


