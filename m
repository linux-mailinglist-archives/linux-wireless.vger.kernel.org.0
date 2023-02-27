Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16E86A494A
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 19:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjB0SKN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 13:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjB0SKL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 13:10:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E2622DF8
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 10:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677521350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N1MGFP6503Z109f88tuGoqHCcLznU5WJ5kjZwW8STZM=;
        b=WgTEk7uH3NSoSTuSsj3xHecubCkaTRVKIqGCq4sETaufAScSddRoi+36uPN0FSqXACJnNN
        lhDt3WRqZER1hBBRgI4CuDDTsJktGtY401TpS9XgOaopwb4RFVJgap9Khh2V6Xi4exgj8d
        GEFeiZFZQmeGWHs3PP78KrXXFL4voIg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-SNAF_nxRMEKbsBcoYwYP8w-1; Mon, 27 Feb 2023 13:09:08 -0500
X-MC-Unique: SNAF_nxRMEKbsBcoYwYP8w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A70D185A794;
        Mon, 27 Feb 2023 18:09:08 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.22.48.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B35751121315;
        Mon, 27 Feb 2023 18:09:07 +0000 (UTC)
Message-ID: <cc905b745580b0300d10f1f88d714305c7544f67.camel@redhat.com>
Subject: Re: [PATCH 2/2] wifi: move raycs, wl3501 and rndis_wlan to legacy
 directory
From:   Dan Williams <dcbw@redhat.com>
To:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Date:   Mon, 27 Feb 2023 12:09:06 -0600
In-Reply-To: <20230227121732.8967-3-kvalo@kernel.org>
References: <20230227121732.8967-1-kvalo@kernel.org>
         <20230227121732.8967-3-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-02-27 at 14:17 +0200, Kalle Valo wrote:
> To clean up drivers/net/wireless move the old drivers drivers left in
> the
> directory to a new "legacy" directory. I did consider adding
> CONFIG_WLAN_VENDOR_LEGACY like other vendors have but then dropped
> the idea as
> these are really old drivers and hopefully we get to remove them
> soon.

Why is rndis_wlan legacy? It supports devices that are way newer than
ray_cs or wl3501... like this Linksys WUSB54GSC from late 2007:

[1086339.589565] rndis_wlan 1-3:1.0 wlan0: register 'rndis_wlan' at
usb-0000:00:14.0-3, Wireless RNDIS device, BCM4320b based,
00:1d:7e:9e:2f:bb
[1086339.589961] usbcore: registered new interface driver rndis_wlan

Dunno, just seems a completely different class of devices than old
802.11b-only PCMCIA ones...

Dan

>=20
> There should be no changes in compilation or in Kconfig options,
> merely moving files.
>=20
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> ---
> =C2=A0drivers/net/wireless/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 55 +-----=
-----------
> --
> =C2=A0drivers/net/wireless/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +--
> =C2=A0drivers/net/wireless/legacy/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 55
> +++++++++++++++++++
> =C2=A0drivers/net/wireless/legacy/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++
> =C2=A0drivers/net/wireless/{ =3D> legacy}/ray_cs.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 0
> =C2=A0drivers/net/wireless/{ =3D> legacy}/ray_cs.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0 0
> =C2=A0drivers/net/wireless/{ =3D> legacy}/rayctl.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0 0
> =C2=A0.../net/wireless/{ =3D> legacy}/rndis_wlan.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 0
> =C2=A0drivers/net/wireless/{ =3D> legacy}/wl3501.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0 0
> =C2=A0drivers/net/wireless/{ =3D> legacy}/wl3501_cs.c |=C2=A0 0
> =C2=A010 files changed, 63 insertions(+), 60 deletions(-)
> =C2=A0create mode 100644 drivers/net/wireless/legacy/Kconfig
> =C2=A0create mode 100644 drivers/net/wireless/legacy/Makefile
> =C2=A0rename drivers/net/wireless/{ =3D> legacy}/ray_cs.c (100%)
> =C2=A0rename drivers/net/wireless/{ =3D> legacy}/ray_cs.h (100%)
> =C2=A0rename drivers/net/wireless/{ =3D> legacy}/rayctl.h (100%)
> =C2=A0rename drivers/net/wireless/{ =3D> legacy}/rndis_wlan.c (100%)
> =C2=A0rename drivers/net/wireless/{ =3D> legacy}/wl3501.h (100%)
> =C2=A0rename drivers/net/wireless/{ =3D> legacy}/wl3501_cs.c (100%)
>=20
> diff --git a/drivers/net/wireless/Kconfig
> b/drivers/net/wireless/Kconfig
> index 42b40cc96b21..7555af5195ec 100644
> --- a/drivers/net/wireless/Kconfig
> +++ b/drivers/net/wireless/Kconfig
> @@ -38,60 +38,7 @@ source "drivers/net/wireless/ti/Kconfig"
> =C2=A0source "drivers/net/wireless/zydas/Kconfig"
> =C2=A0source "drivers/net/wireless/quantenna/Kconfig"
> =C2=A0
> -config PCMCIA_RAYCS
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "Aviator/Raytheon 2.4=
GHz wireless support"
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on PCMCIA
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select WIRELESS_EXT
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select WEXT_SPY
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select WEXT_PRIV
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Say Y here if you inten=
d to attach an Aviator/Raytheon
> PCMCIA
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (PC-card) wireless Ethe=
rnet networking card to your
> computer.
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Please read the file
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> <file:Documentation/networking/device_drivers/wifi/ray_cs.rst> for
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 details.
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To compile this driver =
as a module, choose M here: the
> module will be
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 called ray_cs.=C2=A0 If=
 unsure, say N.
> -
> -config PCMCIA_WL3501
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "Planet WL3501 PCMCIA=
 cards"
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on CFG80211 && PCMCIA
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select WIRELESS_EXT
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select WEXT_SPY
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A driver for WL3501 PCM=
CIA 802.11 wireless cards made by
> Planet.
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 It has basic support fo=
r Linux wireless extensions and
> initial
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 micro support for ethto=
ol.
> -
> -config USB_NET_RNDIS_WLAN
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "Wireless RNDIS USB s=
upport"
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on USB
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on CFG80211
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select USB_NET_DRIVERS
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select USB_USBNET
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select USB_NET_CDCETHER
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select USB_NET_RNDIS_HOST
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This is a driver for wi=
reless RNDIS devices.
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 These are USB based ada=
pters found in devices such as:
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Buffalo WLI-U2-KG125S
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 U.S. Robotics USR5421
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Belkin F5D7051
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Linksys WUSB54GSv2
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Linksys WUSB54GSC
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Asus WL169gE
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Eminent EM4045
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BT Voyager 1055
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Linksys WUSB54GSv1
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 U.S. Robotics USR5420
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUFFALO WLI-USB-G54
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 All of these devices ar=
e based on Broadcom 4320 chip which
> is the
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 only wireless RNDIS chi=
p known to date.
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If you choose to build =
a module, it'll be called
> rndis_wlan.
> +source "drivers/net/wireless/legacy/Kconfig"
> =C2=A0
> =C2=A0source "drivers/net/wireless/virtual/Kconfig"
> =C2=A0
> diff --git a/drivers/net/wireless/Makefile
> b/drivers/net/wireless/Makefile
> index 1b697cfe0a13..4d7374d567d1 100644
> --- a/drivers/net/wireless/Makefile
> +++ b/drivers/net/wireless/Makefile
> @@ -23,10 +23,5 @@ obj-$(CONFIG_WLAN_VENDOR_ST) +=3D st/
> =C2=A0obj-$(CONFIG_WLAN_VENDOR_TI) +=3D ti/
> =C2=A0obj-$(CONFIG_WLAN_VENDOR_ZYDAS) +=3D zydas/
> =C2=A0
> -# 16-bit wireless PCMCIA client drivers
> -obj-$(CONFIG_PCMCIA_RAYCS)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+=3D ray_cs.o
> -obj-$(CONFIG_PCMCIA_WL3501)=C2=A0=C2=A0=C2=A0=C2=A0+=3D wl3501_cs.o
> -
> -obj-$(CONFIG_USB_NET_RNDIS_WLAN)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0+=3D rndis_wlan.o
> -
> +obj-$(CONFIG_WLAN) +=3D legacy/
> =C2=A0obj-$(CONFIG_WLAN) +=3D virtual/
> diff --git a/drivers/net/wireless/legacy/Kconfig
> b/drivers/net/wireless/legacy/Kconfig
> new file mode 100644
> index 000000000000..3a5275941212
> --- /dev/null
> +++ b/drivers/net/wireless/legacy/Kconfig
> @@ -0,0 +1,55 @@
> +config PCMCIA_RAYCS
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "Aviator/Raytheon 2.4=
GHz wireless support"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on PCMCIA
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select WIRELESS_EXT
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select WEXT_SPY
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select WEXT_PRIV
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Say Y here if you inten=
d to attach an Aviator/Raytheon
> PCMCIA
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (PC-card) wireless Ethe=
rnet networking card to your
> computer.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Please read the file
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> <file:Documentation/networking/device_drivers/wifi/ray_cs.rst> for
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 details.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To compile this driver =
as a module, choose M here: the
> module will be
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 called ray_cs.=C2=A0 If=
 unsure, say N.
> +
> +config PCMCIA_WL3501
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "Planet WL3501 PCMCIA=
 cards"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on CFG80211 && PCMCIA
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select WIRELESS_EXT
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select WEXT_SPY
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A driver for WL3501 PCM=
CIA 802.11 wireless cards made by
> Planet.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 It has basic support fo=
r Linux wireless extensions and
> initial
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 micro support for ethto=
ol.
> +
> +config USB_NET_RNDIS_WLAN
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "Wireless RNDIS USB s=
upport"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on USB
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on CFG80211
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select USB_NET_DRIVERS
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select USB_USBNET
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select USB_NET_CDCETHER
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select USB_NET_RNDIS_HOST
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This is a driver for wi=
reless RNDIS devices.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 These are USB based ada=
pters found in devices such as:
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Buffalo WLI-U2-KG125S
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 U.S. Robotics USR5421
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Belkin F5D7051
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Linksys WUSB54GSv2
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Linksys WUSB54GSC
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Asus WL169gE
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Eminent EM4045
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BT Voyager 1055
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Linksys WUSB54GSv1
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 U.S. Robotics USR5420
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUFFALO WLI-USB-G54
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 All of these devices ar=
e based on Broadcom 4320 chip which
> is the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 only wireless RNDIS chi=
p known to date.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If you choose to build =
a module, it'll be called
> rndis_wlan.
> +
> diff --git a/drivers/net/wireless/legacy/Makefile
> b/drivers/net/wireless/legacy/Makefile
> new file mode 100644
> index 000000000000..36878f080bfc
> --- /dev/null
> +++ b/drivers/net/wireless/legacy/Makefile
> @@ -0,0 +1,6 @@
> +# 16-bit wireless PCMCIA client drivers
> +obj-$(CONFIG_PCMCIA_RAYCS)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+=3D ray_cs.o
> +obj-$(CONFIG_PCMCIA_WL3501)=C2=A0=C2=A0=C2=A0=C2=A0+=3D wl3501_cs.o
> +
> +obj-$(CONFIG_USB_NET_RNDIS_WLAN)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0+=3D rndis_wlan.o
> +
> diff --git a/drivers/net/wireless/ray_cs.c
> b/drivers/net/wireless/legacy/ray_cs.c
> similarity index 100%
> rename from drivers/net/wireless/ray_cs.c
> rename to drivers/net/wireless/legacy/ray_cs.c
> diff --git a/drivers/net/wireless/ray_cs.h
> b/drivers/net/wireless/legacy/ray_cs.h
> similarity index 100%
> rename from drivers/net/wireless/ray_cs.h
> rename to drivers/net/wireless/legacy/ray_cs.h
> diff --git a/drivers/net/wireless/rayctl.h
> b/drivers/net/wireless/legacy/rayctl.h
> similarity index 100%
> rename from drivers/net/wireless/rayctl.h
> rename to drivers/net/wireless/legacy/rayctl.h
> diff --git a/drivers/net/wireless/rndis_wlan.c
> b/drivers/net/wireless/legacy/rndis_wlan.c
> similarity index 100%
> rename from drivers/net/wireless/rndis_wlan.c
> rename to drivers/net/wireless/legacy/rndis_wlan.c
> diff --git a/drivers/net/wireless/wl3501.h
> b/drivers/net/wireless/legacy/wl3501.h
> similarity index 100%
> rename from drivers/net/wireless/wl3501.h
> rename to drivers/net/wireless/legacy/wl3501.h
> diff --git a/drivers/net/wireless/wl3501_cs.c
> b/drivers/net/wireless/legacy/wl3501_cs.c
> similarity index 100%
> rename from drivers/net/wireless/wl3501_cs.c
> rename to drivers/net/wireless/legacy/wl3501_cs.c

