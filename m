Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E0A396E0B
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 09:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhFAHpi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 03:45:38 -0400
Received: from mail-db8eur05on2071.outbound.protection.outlook.com ([40.107.20.71]:17313
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231139AbhFAHpi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 03:45:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/3v7hC9Dp8Vz0DyAjBioB47XHGsSzPj6ffF8DzpOffNoCknRZX7hywk6ffKzeavVxAq1d66Z2o9r6IqTdokuEGgfaVAtr82bKW96TPUAuBfGpFno6ODyyuCZTH+SqtxNDpz72h1SeGbSRhufZ2C7BcJym4dec+HRhUjFHZAOJzynhDzSqqgjvjoXSwzcx0or6Js8CM+9t52g7hpGuGuxmaJaDGKbozLA4E1qfPNdTe+W02QfV3pImXTEud2QgBgEWxaJKpQQxjzncjNy1Vau1ZpBByaTlW2qCHd7g+hOHaMY9Ff6BCYjBvDTsALyHSurF/iNYwDWu2YE3vjp9wOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbPI4qDkEN6f2gvQ1vX5aIv/vKo3I6kbWSwR6R3FBR8=;
 b=OPf4TXMaDRozbTt1PTdxH+GjRNQh8+Xr0s80e2kMXkMU0baLoTJR3pcbU1fbaw+ayV8NAbdbX3SwKe3XrGqX2OQfkE/kYpsPHfxTctYHbVyZHL+kKlzqlC9GFBWixZ3yYX+Rh7YAlUhG1V0vPcH6popVYcd7IVzBoGpiOlM7wQKTK0OBe9xBmhSwJ0qGFq7DZu7VswX5fqJmaf2q4ByPT/+Eh61H/E9duZPNGjQ9ufd8FdEnLjEGsHVqnnNF3rZeN1B9NXceZxYzRnyXvOwk7yXcaCyc4UtqoROpSCczvvMN9FiCl0WCqMgkOGJp/ku1guaQlOOSPg2Ym7KKTKI0zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbPI4qDkEN6f2gvQ1vX5aIv/vKo3I6kbWSwR6R3FBR8=;
 b=GzNMseCwEF7tZTeGKUoGsdKThaoDErErGFYpbFek2OZaJYmA2if9Vh6Q6QN+JfOVYHrh1OObnjyeHbtuO8Ceaku9WFNk0xzlIhYR5JTfI4o+cBk2yVlsy6lhy/K4uhgQFtdWdzth3iydVnZjHNgGNB2hh2ZZcfbSyB7D2mW/wfw=
Received: from DB7PR04MB4538.eurprd04.prod.outlook.com (2603:10a6:5:2e::18) by
 DB7PR04MB3978.eurprd04.prod.outlook.com (2603:10a6:5:1a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.21; Tue, 1 Jun 2021 07:43:55 +0000
Received: from DB7PR04MB4538.eurprd04.prod.outlook.com
 ([fe80::3c19:872c:5f5:e3fd]) by DB7PR04MB4538.eurprd04.prod.outlook.com
 ([fe80::3c19:872c:5f5:e3fd%7]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 07:43:55 +0000
From:   Sharvari Harisangam <sharvari.harisangam@nxp.com>
To:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
CC:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Cathy Luo <xiaohua.luo@nxp.com>,
        Rakesh Parmar <rakesh.parmar@nxp.com>
Subject: RE: [EXT] Re: pull-request mwifiex-firmware 2021-05-25
Thread-Topic: [EXT] Re: pull-request mwifiex-firmware 2021-05-25
Thread-Index: AddRMRR92hX51an2SCObLVa46U9J2wCG7L8AANtAzVA=
Date:   Tue, 1 Jun 2021 07:43:55 +0000
Message-ID: <DB7PR04MB4538C0AFF34981AEC26C54EFFC3E9@DB7PR04MB4538.eurprd04.prod.outlook.com>
References: <DB7PR04MB4538AF222036C6549FF460EBFC259@DB7PR04MB4538.eurprd04.prod.outlook.com>
 <20210527230526.2skr7pxcpxam3vga@pali>
In-Reply-To: <20210527230526.2skr7pxcpxam3vga@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [116.75.139.158]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 859b113e-93b2-4b18-dcec-08d924d1024e
x-ms-traffictypediagnostic: DB7PR04MB3978:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB39784286219E6CC5BD0FEC8BFC3E9@DB7PR04MB3978.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o3bp4zEpvo1175f0t0HmipTcx7ftlLylOmVJM70F+2QQOzIGQQV/vo1XiQhFwI7uW7PMvT4FGunm9+Epm0FbdAVT+OfioZt/1jDNZJEuMZSgGd1Vyts1XG+HrKb/5drQeQb9zjmKe/e0bmc+EhlY3MyoEDYHKEq+ZtBiiQfogK7AwkmENMIPNxwV1ENfT72lmOEMF1GoDQFKcOiXFuiIfyyQ9zg4VxhtWIbWUZBFdWuabNKAG01VOxgIZi4Xbvx0vSn0KrJAv1sKK1yAArqT1an07ZIziR714Pwfmt5ltPzH4qlgDivajZXjeO4TAbYevmByxPLiksRDKCzK2NBntaVfyUtAXeuMweUbQu4zx6tEVjpI6nEOa+x3MVV6ipEBQlbAL9dxqDB/5/zhz5nLta2j+umtuhM68S8t9EMQwEsDCV9rJDM4wBUXvvGC0sl/Bpeov/8LbvfNg/pKoJ2jF39IconzmYwjfAyD+pSJXfgLzdqpxpvGee0YjqWsApvMQoqUiMNd9pRUDzjs69cT0FZ7O9QwpTgClTe5BSIj7dVx37FssUnk138aRsabfudeylSHAXhya75Be/j8RktHBVPQH9E79VBUE9OEo5C7j0sEA6v27nB8C6o8R3jjhHiGIY5CgYFcY8o+Dx8Sq2w0+PxxIdwgfaclEFT7BzGB18YnZuPA33+1X2dE7wqBW16Cs5umyREFYfBOtjnxLSMy3VeWn5AvLOpHwspBxK3TM1s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4538.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(76116006)(5660300002)(33656002)(66946007)(64756008)(44832011)(55236004)(6916009)(52536014)(122000001)(26005)(66556008)(66476007)(186003)(86362001)(2906002)(66446008)(966005)(9686003)(54906003)(4326008)(83380400001)(45080400002)(8676002)(66574015)(55016002)(478600001)(71200400001)(53546011)(7696005)(6506007)(316002)(8936002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?kNdBJvRIIne69MnBATVmFW4Bfw8VTiwwCYZmZ6m6L0wA5w3OmW7a7cAQIg?=
 =?iso-8859-1?Q?kCHwQWkwOeGiExgreoOVA8yKm4Jh2mU1ixwvWKFf4F/JWdeySk7JgKXHmA?=
 =?iso-8859-1?Q?/MN5jhK9nreBmErNljUnR2cxlajeU50BEpKyMa9e6hJ/p6ZjMLXn7a6o9m?=
 =?iso-8859-1?Q?moh2OrkOY3b5bBOlHmYmgQD4jhWg2XOFbnRYLKCnMcThHObJscT/bJC2OL?=
 =?iso-8859-1?Q?kC9URS8zSCsOkny/wn/O395YaqCq4cBoRa+tPPjlV/kNvOZAt/PUR8sVxR?=
 =?iso-8859-1?Q?g+rvvp19bCp91hRqUwRD8L9gsudNImTKdt4+WWqWFPIb3rEFgbLH+ZpucU?=
 =?iso-8859-1?Q?vES4rRHTBcFE9aWtXdNavmGVf8BfSRrSDoBu/efnZ4okmy3tpI/UMBMnoj?=
 =?iso-8859-1?Q?5eQOVUL1HUMjCsb+bPcqSJ4N58RSEZHV32xrWOUMmNf+QE6B8Vl3pa2dQe?=
 =?iso-8859-1?Q?0vVI+sxJOr18ZCb9bgQYJc/PJl2befbfpVb2LHkDLHtQKzn2vkZNSguqKD?=
 =?iso-8859-1?Q?Y2dBO9Qvk4lm5MoG5cXbRogidt9lgKcEUWFFy3zhwiF8axUHFBMU3L2ZC1?=
 =?iso-8859-1?Q?5C623Yr/ec+ytxPnDOuSOyXcK1tpdCARhI7DkEky6YMM6LRoP5JpI+nCPc?=
 =?iso-8859-1?Q?oUwYSwnP0n26iF4r4rRt4M3uW2NO0yfkvGrCBbSZN7gxEWEObI1UMI96Ec?=
 =?iso-8859-1?Q?hGKNupNDu9NmBPHH4yHAkoEJa4YUW3EwAen1GB+RJwMJyWo6UA5mtaf1yC?=
 =?iso-8859-1?Q?Nnbl+ioSvLixUT3Kd6ZpeIHpIYwua5Nk3H7ZkCLlX/jpSTbdFk/Jpafl4g?=
 =?iso-8859-1?Q?Y4qhF6T8/+REcH/4AKE1X0rmDZp+pa8ON7s33wiN4iEPi07nuWyuX8AK4q?=
 =?iso-8859-1?Q?MKVa1h4JLSys9VJpyxsska8n9f3Mg0Xpu1sTY0iC2IXBk000IOtNh8VTT1?=
 =?iso-8859-1?Q?MiJkjp2HYTFPN5KHoX4TF2+XiytxTgyk6wWk/6HTXyFvmw4KL22iIArhGT?=
 =?iso-8859-1?Q?wL9UcUXYBef+Lm5RFHcC3AFZlCl4yBpkr028UxwNzCIJTdLDssbsfPx1+9?=
 =?iso-8859-1?Q?pFY4WrcooFdvUmp7uleC3lVhu4hfHUv795ZfQKkEOTPRzHX1XvOmIZEtWX?=
 =?iso-8859-1?Q?IErzz7GVgu0TmmuF2DjwUWDx58RIuDZyrTqbvs36O8heH9tpy4mPR4YEw6?=
 =?iso-8859-1?Q?S+7NZsMnJSg+8bn1HL6oVzZl3DZVN40ZU6UxZzdkBfdY3uo7MZx1PIJ8ac?=
 =?iso-8859-1?Q?1k1WTsAKPEwKaOIT+5nTJTtoBK/aU4+JazQArtyO0eKm2+HmQtV8oGpew3?=
 =?iso-8859-1?Q?9PBbKJcjYyW5B3gjY/lHemXrVsl3dh/jWTs+0Kf/UbgNnVFN7zWkoZ4dhg?=
 =?iso-8859-1?Q?owndln05k+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4538.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859b113e-93b2-4b18-dcec-08d924d1024e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 07:43:55.4783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jtDIVQTW7j9uPtAw1lk9fDv42C9RidwwraHIu0i9SmOoRU1Vjz+Dw0omEGXHliiuoRDyxTjDIbx1cpoIzCiMobEioy51Ruy7qbgp5JmgkFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB3978
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We are planning to update the firmware in phases.

Thanks,
Sharvari

> -----Original Message-----
> From: Pali Roh=E1r <pali@kernel.org>
> Sent: Friday, May 28, 2021 4:35 AM
> To: Sharvari Harisangam <sharvari.harisangam@nxp.com>
> Cc: linux-firmware@kernel.org; linux-wireless@vger.kernel.org; Cathy Luo
> <xiaohua.luo@nxp.com>; Rakesh Parmar <rakesh.parmar@nxp.com>; Mayur
> Arakere <mayur.arakere@nxp.com>
> Subject: [EXT] Re: pull-request mwifiex-firmware 2021-05-25
>=20
> Caution: EXT Email
>=20
> On Tuesday 25 May 2021 06:42:47 Sharvari Harisangam wrote:
> > The following changes since commit
> db190ade4569c542cd257a9334f8f8956372f7b3:
> >
> >   linux-firmware: update NXP PCIE-USB-8997 firmware image (2021-05-19
> 12:57:21 -0700)
> >
> > are available in the git repository at:
> >
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.co
> m%2FNXP%2Fmwifiex-
> firmware.git&amp;data=3D04%7C01%7Csharvari.harisangam%40nxp.com%7C23c
> cf252b3cf4bb04e9508d92163ed1b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C637577535329511768%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&a
> mp;sdata=3DiUx3hV9qMv36jIz8wT22NbKoqbwNvylhmNT6ElRd9jg%3D&amp;reser
> ved=3D0
> >
> > for you to fetch changes up to
> 267febb1c43c119a7a65ddabc2c33c28a7803324:
> >
> >   linux-firmware: update Marvell 8897/8997 firmware images (2021-05-25
> 05:09:25 -0700)
> >
> > ----------------------------------------------------------------
> > Sharvari Harisangam (1):
> >       linux-firmware: update Marvell 8897/8997 firmware images
> >
> >  mrvl/pcieusb8997_combo_v4.bin | Bin 634228 -> 638992 bytes
> >  mrvl/sd8897_uapsta.bin        | Bin 701072 -> 717068 bytes
> >  2 files changed, 0 insertions(+), 0 deletions(-)
>=20
> Hello and thank you for this pull request!
>=20
> Could you send update also for other 8997 firmware variant files?
>=20
> sdsd8997_combo_v4.bin
> usbusb8997_combo_v4.bin
> pcieuart8997_combo_v4.bin
