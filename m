Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C681776DFA
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 04:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjHJCXm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Aug 2023 22:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHJCXl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Aug 2023 22:23:41 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2047.outbound.protection.outlook.com [40.107.8.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F51619A1
        for <linux-wireless@vger.kernel.org>; Wed,  9 Aug 2023 19:23:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZmQDJvFK/KAlUh6mpv0UEX1AvImHEfxJq9ikE6DJZQNgnvlIWXhP6ELZ17WQGqdPN5ALrEzxVWl9NZxaw1326K0ZEGN1LDSWSVi4iGJz+UbryP1ndwX7FFUKB+tczEaZLboldHeOlKPGTlCIg2+GxSr6iUlRIXaI93OiJ363EWB2AWaegxva43giSngmJNZOqFfmkgv6QuYYycCmPplBmLzuE5MzDxM9WMFXwlOxPRM2jmPX3TQIoY9uYNWfBZ1Q11iMJlX5pgxkg+TBbsCCYTxFabRZMPZU3gMZ32JgtK4+5j58Xn2efgg06OKVi4zdZCY0rVjozaOL54AtMFNwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfi66QYsdtcjCJBqn/TIePFRaajUBqma++dwN2ah0Pw=;
 b=jW8RTM2ZEAwyLHNXbm2eCgxS+0+Wu5OW9iADinF/MJVTgJVlOhsjuvuKxZBb+9WWuqrbswlCVkeaezSVkgSimcLitj9h8HwIpq1MM9hsirhLKOxkhWgZboHEJGtHdYcEq/jPG0k1STNK4GNY/qsUJE8ZzaQNGm9q42a9tHqVHmQN7bvX3keOCaltQWuRgm3KzLg1WbMB/TsmS8ziuQkHw6bX8tNvqkyjVForS4285TI/lol+QXCGyrGffAfLPanIV7CqO3CrdcSEfQeloU6buJRZe1/VXGjtFs2TQkkjVQ2rulC/KThm5TppAJweRcmvIwP8+M/DStzSylYHfewKFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfi66QYsdtcjCJBqn/TIePFRaajUBqma++dwN2ah0Pw=;
 b=OVRoxnqTDgfjpld3Uc+7c/oAYrDyc6HZTx86LFMDTvD553PDtruOTLI7t6fqROzuOdI5vYMCHelXTQIjog61AdsqnQ05e767FYmYqeceyaZKoEv5Dv5jjCQmIBnKTNuWAyg418dZ+QljRPwjWX7K7xi6QKMqs3zXZymUbmi608w=
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by PAXPR04MB8560.eurprd04.prod.outlook.com (2603:10a6:102:217::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 02:23:37 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::5db6:ba53:768:f057]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::5db6:ba53:768:f057%5]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 02:23:37 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v2] wifi: mwifiex: added code to support host
 mlme.
Thread-Topic: [EXT] Re: [PATCH v2] wifi: mwifiex: added code to support host
 mlme.
Thread-Index: AdnKdwWMgAI8idR0S3aBP+we4161gwARUUkAAB0u9HA=
Date:   Thu, 10 Aug 2023 02:23:37 +0000
Message-ID: <DU0PR04MB963625D3534FFA6677CD9356D113A@DU0PR04MB9636.eurprd04.prod.outlook.com>
References: <PA4PR04MB9638FE710460BC44BA290470D112A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <e78119dc1ae2e22ea84b6528492aeba1ab6bfcec.camel@sipsolutions.net>
In-Reply-To: <e78119dc1ae2e22ea84b6528492aeba1ab6bfcec.camel@sipsolutions.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9636:EE_|PAXPR04MB8560:EE_
x-ms-office365-filtering-correlation-id: a360ca06-7039-451a-c71d-08db9948cdc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dy5f09XwRjnzntvxQ9VNRlYanG50kYcCfXonng2SX3hDOuM3SGanfzw7kXtFL5f7JG3mhs/f8jUEWMQCNAZXA0KL6B/tRP5F/oMKPg876Xf5PNAEGQfz2qDkhhnxAiGJCD4hh+ywyvOwWg7ZMuiiZeuIm78ntVoNuzYDzZ8Lz9iDfh0w1lYZGHi4CxP+lYGvkF1ZO0gNV27NThxXpmSMCT+1y99RY9z/1JQw0M+Wva3iihbBhZ4z3CvUvMhUr5gVVetxEHTrzWM7rXNxgwY3vFlEmAK1MXPsML+WI40o/1OSrESOnYLGTzmPnCy9pEF0blORwVHnAvnkPN+DzFmEj69SzsvyRNwrkmQQ4eafW12lUBFRw67rge3cZOAHHLYLHU5R+c/23CIiVa05efkWAcjeaOt7zllnd7KfBgU8r+VfksfLV1w1qQbMwV7tatVCsIwa4Mno6npymGtmQMvDUgBD91R8GsKv4R3Sf23foRz3TfDdEWMJfw/ILFjU/TCFl7DDljKFUlRHdQ31UPR0kxh42DAzI3oDLD6BHvv+NRgxvtLGvLjRgl8XSakZAOgCXtEeOq38Ixlkt+gDmTFo3n6p1vfnUdW+89koWDoxFeExt+1hwnDxk5CfskYRppQV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9636.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(1800799006)(186006)(451199021)(33656002)(71200400001)(478600001)(45080400002)(66446008)(76116006)(66946007)(66556008)(66476007)(64756008)(54906003)(6506007)(110136005)(53546011)(966005)(7696005)(9686003)(4326008)(2906002)(41300700001)(316002)(8676002)(5660300002)(122000001)(52536014)(8936002)(38100700002)(38070700005)(86362001)(83380400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S7qafGeKJjoy4klpIKeG2rv0gp1+y0zyoue7iJWxycNOTt0GUbTjp/piRlz4?=
 =?us-ascii?Q?cgVw9Rud3H56fGlxDU1M9d2sk6WRl4b6/Df7Eg58tR1Sums+RGCqJDDk5YAz?=
 =?us-ascii?Q?bNyeaDLwrJP3WbFlhF4wtA19LmjrpRQlaLI1m7WdHcUf3RGrGxyG/5WDiEmm?=
 =?us-ascii?Q?Roxe9TDMHtDYtQsMbsajR0ZAOFT2AvXzAySlK5C2gHyBhxLXdMiHFX9VV1Fj?=
 =?us-ascii?Q?kDHrB6BskrQ7EsfWc1Eb7d6HlOf7QlY9Cnz8jdN2DnnX4Vf6HIboNteov+fU?=
 =?us-ascii?Q?+RxkUgN1HP9Bn44Ps08mVgaOAByCoXiOK5JuqIOI4MlSH5rWdoLmIPmpB1e5?=
 =?us-ascii?Q?x0+BfTVj5G+/lUYtx5XsMkH2+rhMpE/dDbV3ps8rtMi+TehqHPrIhCNQxpHG?=
 =?us-ascii?Q?zs1m0oNT5Ebhzu80PmUq5Oa6Zs/hVYmAMwvJXxGiSDbSWAdTkLbmrWGhIAiF?=
 =?us-ascii?Q?tZCvR1xYMlRpTA70iPuM+Ep5taz/99DdRX0xar1MNikoke1FND1FwEGsQ0Ms?=
 =?us-ascii?Q?bazip913P6ZUFsAt0PWNw68jVGhG4DNLSvvUSkhE8WVxnvky113pAs5BX+r/?=
 =?us-ascii?Q?CXOjujoD8C+0WW8yQc+pki5/khqOOeGgYN5dpeGKPvfDyaOUY5xLuB3BzRKZ?=
 =?us-ascii?Q?vMQHUUJgsHa6lJbzYeAKnAqOdVRS4UuQRbQgPTm+QpUAGLj1lmmsNI2Xg9in?=
 =?us-ascii?Q?XBE+ySWfabdD96KFeMvgyDR3DlbeCAWrJyiqEM5Q3aAK3lCC+fdCfiURLHYj?=
 =?us-ascii?Q?nuUUv/0HFCbXkszD5NOprFirvK7zMcAWQ5aBs5tmqU/cKnc/AckUU2/O5d1q?=
 =?us-ascii?Q?C173CR8R94QCACdTdbD6hPi7fpcPSjukNS2na9HTd6Bvi1uT8zAEQROUqyiS?=
 =?us-ascii?Q?yu9epSs5mm9KpSCdXr3g6swtW7ABWsBf1rS3EUxYOuta75nPOjIMrF2zagpy?=
 =?us-ascii?Q?DldzVMe8iEvwfjCVPwCIZgLYQCMQr914DLDtt3S2zTneppqmYPGLruMbEJd3?=
 =?us-ascii?Q?jkjglSoQ4wqFk+MdNDbemrtJvO4CAbBIuuU9szhjPvFgac79WiqajcID6WCO?=
 =?us-ascii?Q?PtSEYXlgkLC3Be37mE0vHpPR0d7VzV3E32dbIQrzTiEfaVGZk+iEtPlHd52U?=
 =?us-ascii?Q?Zn4axS0vod+CmwHE1A0LlVWhDtftoKfTSO0Njn+Pigmf3IwtGLjMQ3EvfWM+?=
 =?us-ascii?Q?WaIiyHAPfrQWb88T9PEZsNwgl4hUlIlg9zOsJxcMkJJXCsfBOXOKwvQaEZwV?=
 =?us-ascii?Q?WFFKmA+Xy4RXIv90v1MN4hsWMAmMXuGgY0qqNxgcU6wgeOHmNWCd+G9JeCPF?=
 =?us-ascii?Q?PpVLIQXHF25ZAye0DGJNYiM/X2w7sNXB8HXBKu2nwgGUc+PXD+H6rekRUA4e?=
 =?us-ascii?Q?/RxOBtD9stt0nOgf/vagsl74THfaUCr2tMumad2lMme1bKM3jqZBZz8tEisj?=
 =?us-ascii?Q?gcYuadK8HMzQ7hTKC5ET6hiOb7dUSIq+n8xTYMoMXqtDHqcn5HnxlIz6TSzy?=
 =?us-ascii?Q?iF8qqKE5SbvrDEOucmEisG4kTViyicPE13kz44d8K5NIbK60K7Q0EC6qmQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a360ca06-7039-451a-c71d-08db9948cdc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 02:23:37.2052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ruQ3CMxTkJZ8IPbx6fU7JRMMZVsiDQUh3iwX5M/j9Wl/p2dXOvoOQK00Ey6iPm35vbEasF20Wmx0XYaCPlghqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8560
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> From: Johannes Berg <johannes@sipsolutions.net>
> Sent: Wednesday, August 9, 2023 8:23 PM
> To: David Lin <yu-hao.lin@nxp.com>; linux-wireless@vger.kernel.org
> Cc: Sharvari Harisangam <sharvari.harisangam@nxp.com>; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH v2] wifi: mwifiex: added code to support host m=
lme.
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Please see
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwirel=
ess.
> wiki.kernel.org%2Fen%2Fdevelopers%2Fdocumentation%2Fsubmittingpatches
> %23commit_messages&data=3D05%7C01%7Cyu-hao.lin%40nxp.com%7C92701a7
> 62acb49fb977608db98d36f73%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C0%7C638271806093535337%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> %7C%7C&sdata=3D9eVhKVmr%2F6NAKODF7zYH5Dvm9bDvdrzJOcZ0FpmGVWI%3
> D&reserved=3D0
>=20
> > 3. The code is enabled and tested with IW416.
> >    There is no guarantee for other chips.
>=20
> That seems misleading - it's not even enabled for other chips, is it?
>=20
> Or are you saying that there are multiple variants of sd8979, and only on=
e of
> them is supported?! In that case you need to detect it.
>=20
> Also, it seems like you likely need to detect the firmware version that h=
as the
> support, not just the hardware?
>

Sorry. Only enable for IW416. Yes, it needs firmware version 2 to support t=
his feature.
=20
>=20
> > +++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
> > @@ -331,6 +331,7 @@ static const struct mwifiex_sdio_device
> mwifiex_sdio_sd8786 =3D {
> >       .can_dump_fw =3D false,
> >       .can_auto_tdls =3D false,
> >       .can_ext_scan =3D false,
> > +     .host_mlme =3D false,
>=20
> probably better to not have all the =3Dfalse lines that are default anywa=
y?
>=20

I followed original code. I will keep this in mind when we create new cfg80=
211 driver.

> This is the only one enabling it afaict:
>=20
> >  static const struct mwifiex_sdio_device mwifiex_sdio_sd8978 =3D { @@
> > -408,6 +413,7 @@ static const struct mwifiex_sdio_device
> mwifiex_sdio_sd8978 =3D {
> >       .fw_dump_enh =3D true,
> >       .can_auto_tdls =3D false,
> >       .can_ext_scan =3D true,
> > +     .host_mlme =3D true,
> >  };
>=20

Yes.

> johannes
