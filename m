Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A47BF9F9A0
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2019 06:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfH1E7v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Aug 2019 00:59:51 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:43779 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725865AbfH1E7v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Aug 2019 00:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1566968389; x=1598504389;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=w4KPaoYWDrgMXJycc8M6JvzivFxU31rwMM3DvliFfk8=;
  b=lRc8hpMlMEFosYKnm9cB5Hv4Ef4sJw8bqAKm0IWB0sMjItSUxzPQ+AUc
   XGCpaxzJFso5KEERCa+426cyT/kuNpmWVkplBkhjV7WOiqFEMiJzsT9qF
   3cG11bvVlVbusrw2lvR/SkQ7xuVwIPk6Upyk8iJz+VZr9+fNQOWjwYmx/
   8=;
Subject: RE: [PATCH] ath10k: add fw coredump for sdio when firmware assert
Thread-Topic: [PATCH] ath10k: add fw coredump for sdio when firmware assert
Received: from ironmsg02-tai.qualcomm.com ([10.249.140.7])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 28 Aug 2019 12:59:48 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([10.249.150.16])
  by ironmsg02-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 28 Aug 2019 12:59:42 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02f.ap.qualcomm.com (10.249.150.16) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Wed, 28 Aug 2019 12:59:40 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Wed, 28 Aug 2019 12:59:40 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Wen Gong <wgong@codeaurora.org>
CC:     Brian Norris <briannorris@chromium.org>,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Thread-Index: AQHVXNAbtURsVnEXnU268W2eITmuOKcP+xkw
Date:   Wed, 28 Aug 2019 04:59:40 +0000
Message-ID: <8f0f2930e12a4dcabb69c13affe89a31@aptaiexm02f.ap.qualcomm.com>
References: <1566371979-22730-1-git-send-email-wgong@codeaurora.org>
 <CANMq1KDGWh6Cc8akX_1g-n_fYe_2FHrpgnWf=sLxFnME7t5vBQ@mail.gmail.com>
In-Reply-To: <CANMq1KDGWh6Cc8akX_1g-n_fYe_2FHrpgnWf=sLxFnME7t5vBQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.249.136.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> -----Original Message-----
> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Nicolas
> Boichat
> Sent: Tuesday, August 27, 2019 8:08 PM
> To: Wen Gong <wgong@codeaurora.org>
> Cc: Brian Norris <briannorris@chromium.org>; open list:NETWORKING
> DRIVERS (WIRELESS) <linux-wireless@vger.kernel.org>;
> ath10k@lists.infradead.org
> Subject: [EXT] Re: [PATCH] ath10k: add fw coredump for sdio when firmware
> assert
>=20
> Just a few nits, this is a lot of code and I'll try to give it a second p=
ass.
>=20
> On Wed, Aug 21, 2019 at 3:20 PM Wen Gong <wgong@codeaurora.org>
> wrote:
> >
> > When firmware assert, it need coredump to analyze, this patch will
> > collect the register and memory info for sdio chip.
> >
> > The coredump configuration is different between PCIE and SDIO for
> > the same reversion, so this patch add bus type to distinguish PCIE
> > and SDIO chip for coredump.
> >
> > Tested with QCA6174 SDIO with firmware
> > WLAN.RMH.4.4.1-00007-QCARMSWP-1.
> >
> > Signed-off-by: Wen Gong <wgong@codeaurora.org>
> > ---
> >  drivers/net/wireless/ath/ath10k/bmi.c       |   1 +
> >  drivers/net/wireless/ath/ath10k/core.c      |   7 +-
> >  drivers/net/wireless/ath/ath10k/core.h      |   4 +-
> >  drivers/net/wireless/ath/ath10k/coredump.c  | 338
> +++++++++++++++++++++++++++-
> >  drivers/net/wireless/ath/ath10k/coredump.h  |   1 +
> >  drivers/net/wireless/ath/ath10k/hw.h        |   1 +
> >  drivers/net/wireless/ath/ath10k/sdio.c      | 335
> ++++++++++++++++++++++++++-
> >  drivers/net/wireless/ath/ath10k/targaddrs.h |  10 +
> >  8 files changed, 692 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ath/ath10k/bmi.c
> b/drivers/net/wireless/ath/ath10k/bmi.c
> > index 95dc4be..990fa4d 100644
> > --- a/drivers/net/wireless/ath/ath10k/bmi.c
> > +++ b/drivers/net/wireless/ath/ath10k/bmi.c
> > @@ -197,6 +197,7 @@ int ath10k_bmi_read_memory(struct ath10k *ar,
> >
> >         return 0;
> >  }
> > +EXPORT_SYMBOL(ath10k_bmi_read_memory);
> >
> >  int ath10k_bmi_write_soc_reg(struct ath10k *ar, u32 address, u32 reg_v=
al)
> >  {
> > diff --git a/drivers/net/wireless/ath/ath10k/core.c
> b/drivers/net/wireless/ath/ath10k/core.c
> > index dc45d16..0ea4c36 100644
> > --- a/drivers/net/wireless/ath/ath10k/core.c
> > +++ b/drivers/net/wireless/ath/ath10k/core.c
> > @@ -33,7 +33,6 @@
> >  static bool skip_otp;
> >  static bool rawmode;
> >  static bool fw_diag_log;
> > -
>=20
> Don't do whitespace changes (unless you're changing code in the area
> anyway).
Will remove this
>=20
> >  unsigned long ath10k_coredump_mask =3D
> >  static int ath10k_init_configure_target(struct ath10k *ar)
> > @@ -1953,6 +1956,8 @@ static void ath10k_core_get_fw_name(struct
> ath10k *ar, char *fw_name,
> >                 scnprintf(fw_name, fw_name_len, "%s-%d.bin",
> >                           ATH10K_FW_FILE_BASE, fw_api);
> >                 break;
> > +       default:
> > +               break;
>=20
> Why?
It is a error for build, so add it.
core.c:1815:10: error: enumeration value 'ATH10K_BUS_UNDEF' not handled in =
switch [-Werror,-Wswitch]
        switch (ar->hif.bus) {

>=20
> >         }
> >  }
> >
> > diff --git a/drivers/net/wireless/ath/ath10k/core.h
> b/drivers/net/wireless/ath/ath10k/core.h
> > index 4d7db07..1b52a3c 100644
> > --- a/drivers/net/wireless/ath/ath10k/core.h
> > +++ b/drivers/net/wireless/ath/ath10k/core.h
> > @@ -97,7 +97,9 @@ static inline const char *ath10k_bus_str(enum
> ath10k_bus bus)
> >                 return "usb";
> >         case ATH10K_BUS_SNOC:
> >                 return "snoc";
> > -       }
> > +       default:
> > +               return "unknown";
> > +}
>=20
> This change does not look very useful? Also the indentation is broken.
It is a error for build, so add it. same with last one
Will change indentation.
>=20
>=20
> >
> >         return "unknown";
> >  }
> > diff --git a/drivers/net/wireless/ath/ath10k/coredump.c
> b/drivers/net/wireless/ath/ath10k/coredump.c
> > index b6d2932..b287509 100644
> > --- a/drivers/net/wireless/ath/ath10k/coredump.c
> > +++ b/drivers/net/wireless/ath/ath10k/coredump.c
> > @@ -270,6 +270,277 @@
> >         {0x80010, 0x80020},
> >  };
> >
> > +static const struct ath10k_mem_section
> qca6174_hw30_sdio_register_sections[] =3D {
> > +       {0x800, 0x810},
> > +       {0x820, 0x82C},
> > +
> > +       /* EFUSE0,1,2 is disabled here
> > +        * because it's state may be reset
>=20
> its state
Will change it
>=20
> >  static const struct ath10k_mem_section qca6174_hw30_register_sections[=
]
> =3D {
> >         {0x800, 0x810},
> >         {0x820, 0x82C},
> > @@ -602,6 +873,59 @@
> >         },
> >  };
> >
> > +static const struct ath10k_mem_region
> qca6174_hw30_sdio_mem_regions[] =3D {
> > +       {
> > +               .type =3D ATH10K_MEM_REGION_TYPE_DRAM,
> > +               .start =3D 0x400000,
> > +               .len =3D 0xa8000,
> > +               .name =3D "DRAM",
> > +               .section_table =3D {
> > +               .sections =3D NULL,
> > +               .size =3D 0,
>=20
> Indentation.
Will change it.
>=20
> > +               },
> > +       },
> > +       {
> > +               .type =3D ATH10K_MEM_REGION_TYPE_AXI,
> > +               .start =3D 0xa0000,
> > +               .len =3D 0x18000,
> > +               .name =3D "AXI",
> > +               .section_table =3D {
> > +                       .sections =3D NULL,
> > +                       .size =3D 0,
> > +               },
> > +       },
> > +       {
> > +               .type =3D ATH10K_MEM_REGION_TYPE_IRAM1,
> > +               .start =3D 0x00980000,
> > +               .len =3D 0x00080000,
> > +               .name =3D "IRAM1",
> > +               .section_table =3D {
> > +               .sections =3D NULL,
> > +               .size =3D 0,
>=20
> Indentation
Will change it.
>=20
> > +               },
> > +       },
> > +       {
> > +               .type =3D ATH10K_MEM_REGION_TYPE_IRAM2,
> > +               .start =3D 0x00a00000,
> > +               .len =3D 0x00040000,
> > +               .name =3D "IRAM2",
> > +               .section_table =3D {
> > +               .sections =3D NULL,
> > +               .size =3D 0,
>=20
> Indentation
Will change it.
>=20
> >
> >  enum ath10k_bus {
> > +       ATH10K_BUS_UNDEF,
>=20
> Maybe call this "_ANY", given that you use it to match any bus?
Yes, seems ANY is more reasonable
>=20
> >         ATH10K_BUS_PCI,
> >         ATH10K_BUS_AHB,
> >         ATH10K_BUS_SDIO,
>=20
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
