Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184AD7D48E1
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Oct 2023 09:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjJXHqy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Oct 2023 03:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjJXHqw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Oct 2023 03:46:52 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BABE8;
        Tue, 24 Oct 2023 00:46:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgJMAZaT9VdyswKn1/5blNJ6tdixrdiatmofq5YIzA2nJVsrT/oekZ5xBqe4Yf5Y7SGO+w6n+f1ZdjnIKb3jwpns5mCdK1SjNc0ftdfYhOgwGHYQHzbnU9iNq5TwP3QK4r0iyN0esj9gwiGSM5wSKKA3wQ+NicHFI7V9sGufi7I6C062AaLok0MKjpy+IgMXN4PLB7Ozg/Uuz/yIm+vErr/Ago/+PZlQ4u5QKHc7SDz7nR172cr4MI5PKuUUxB+7XMyPlS8kKFnK9wXi+MQ2FjhInknyd7trAgItI7vmWFkdzu4jFEMTeCNvoNsXk3i0l3yQNLtjpbNw1jzyH+zAVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrDH8jP7lNgIeWFJ88+84lFUOeqd8EUjO64UfGSiGPc=;
 b=XPW54UY9TB2AVIGdH/90KGMBcC/F659MBFUM7u0+t6DSQyrHdFFC/EbXbPwrONAFbQSM9ts30fKliLfpwPYUVoHE18CtL8mZSPzgUn+rwMJkIQZvw+vhu5Tqh9Fsilf3NhSwTDa9f7OslVCQkW8Lsm4yk73pCes/VvSmBf1X5xlrzEproheOEQFn9jRE0Bq8U821etateNvkHnEbxo4E6SSCUJLTFWNUmOfb7i2zPJlARVPr7rHPRpUrqE4dYf51/Y+35dPoG3C9Hpia1kEuJNZ8IFrnL9kykJd8HQqBm2CqWoUnvMWybR1b7SaUoHWN8Q7Ou3T4iMZRIS2kqz2wJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrDH8jP7lNgIeWFJ88+84lFUOeqd8EUjO64UfGSiGPc=;
 b=oBY5dcpizosXF86sLhVMBTVrPXuGMM2+1wogO3z88KmAyKu++J1MNQWez86zGg+7NvCtC4RO3RSOCPUTmB9hwqpG5NcE22E5C7tK/3TWtbLmRlqd1VLluuzSRCs/B+VSKynaaENM18k3k+vWOdqAhTEHcZ9hrAANRn/G1aSdzuU=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI1PR04MB7181.eurprd04.prod.outlook.com (2603:10a6:800:12a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14; Tue, 24 Oct
 2023 07:46:41 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.6933.011; Tue, 24 Oct 2023
 07:46:41 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "amitkarwar@gmail.com" <amitkarwar@gmail.com>,
        "ganapathi017@gmail.com" <ganapathi017@gmail.com>,
        "huxinming820@gmail.com" <huxinming820@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Brian Norris <briannorris@chromium.org>
Subject: RE: [EXT] Re: [PATCH v4 1/1] wifi: mwifiex: added code to support
 host mlme.
Thread-Topic: [EXT] Re: [PATCH v4 1/1] wifi: mwifiex: added code to support
 host mlme.
Thread-Index: AdnPR2mvHOQJHhM/R5inuXZ0d62ZCghP92GABXFMFQA=
Date:   Tue, 24 Oct 2023 07:46:41 +0000
Message-ID: <PA4PR04MB9638EFD3B4415229E962FEF2D1DFA@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <PA4PR04MB96386B2937FE0F7BD0BFAEB3D114A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZRLsuJfxuvFk1K16@francesco-nb.int.toradex.com>
In-Reply-To: <ZRLsuJfxuvFk1K16@francesco-nb.int.toradex.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|VI1PR04MB7181:EE_
x-ms-office365-filtering-correlation-id: 29f7d1d0-1dd2-4ed9-b2e3-08dbd4655c82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bwu8by8dnxFTxXQcpVGQBIkJh7d3/qZhZ2AObdFi3cbGct2Li089W24mkJ/1s7dGck3qnLGR3yTlEMCze1Y52/RVblWi3Kt02V27j741YlJxbbF854+gLN/8WjNlIg2xUWc/yMoLPdjV4oEjG+Mzyp2XjfxL8ju49KY/REBO6TMryj5pXaZqNpN3nlNGGxo7j1bcj2eHOef2MeHqko34wPfZU6xGeL8v0XELzmSxFrwDP5ELSr4Y1JzRMuEVEisVNc963yEkM02u6XXIPm2lBZTbtPuzENXA3bkUXyix+DLDnKOkoWZHebq1Dp0nDb2yXjVUdZF5l1MWtNVcNsPJGDv2Pp+J9Gt2p6eangXD167wCoEFHoT5bejgfzOq/oMO7A6JIkDMaj/DamTzUa/slSvbcsn8M5ORaVNHu3assb4nS8wimxU/XCo9fA09iCDLnz4gqaG8UJ9URKAdISNVkAMXBhKg5P6h93Hj+pqppwGri0kTBhLoHWfABa9nfkAW2tkfBbvYbLG4HC9Eqm7mryYbhao+DKyQk37AazvbpQQX6QJ2I6Lr8mSLEmJp/ARLNjka1CQFKNg37ov1u/0MlvpDMrrf/XoVPSCPCfc7NjDFfHKyyKERy4SPTAJ5Gfo6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(38070700009)(66899024)(38100700002)(2906002)(30864003)(55016003)(7696005)(41300700001)(86362001)(52536014)(5660300002)(7416002)(4326008)(8676002)(8936002)(33656002)(478600001)(6916009)(66556008)(6506007)(71200400001)(316002)(64756008)(122000001)(54906003)(76116006)(66446008)(66476007)(66946007)(83380400001)(9686003)(53546011)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yimYVgSpEJC5A4cSyTZ+invYi/b+v8U+lTrJ2Hu1Cz0/RkI+Jt4qqeWRXax/?=
 =?us-ascii?Q?qvE/KgX1ybZmW4gtxr253teyX33CCiMZHRcNyYu2ROIInxZsz2ePJHo66xMX?=
 =?us-ascii?Q?Y3EN0E+OeMQiYpiU2WgLPHf8yW7NtlfREo81PppIf8Z+TpQXBzp/faRu1mM8?=
 =?us-ascii?Q?5dlm4fnMR6PMaMu1sR0PxEf3PBi3Z6gYkbvYAY3U6YNDIUtnRToJcO0THwZX?=
 =?us-ascii?Q?kCNF+pmNWVFDE9cyHBUO8VdZaBl9u2QQVj6bZAj9aTdAKqim068RlOc50dhn?=
 =?us-ascii?Q?xnmMtDVrSDTzKNFgb/cWTf4FrL2SHmoqzfC5o1wFP3p4Pa8N93WEZckYgjXl?=
 =?us-ascii?Q?IJXLlxve9IsqdRSuWrzhEFmJqRpHBB/fhzUzGW9jCv/H2hRBKWxySuPHchOo?=
 =?us-ascii?Q?Me5myEXlt7uIpvz2T3jLqZOhtnXXYQTNPV4bI17jJNus5a99uQeSuPfi2IF0?=
 =?us-ascii?Q?5V1k0B+B34Xr0ySJEgErQASVIo//9P9Zods6B2Uc0oxffUi4UAVgbJ/l16jO?=
 =?us-ascii?Q?yJJesvxMcxRNCqGWNUgHk0lnQOGkYJ7v1T9GIll+6FUxr6+YVs6ej427rujL?=
 =?us-ascii?Q?J1iw94FHQeyn3OPf/y8TOtDo5NbFMxhVCYyT9qV8c1PnDx6lMHh/HzQW6+qw?=
 =?us-ascii?Q?KCkpNkjuqGdTtlv4WtCaPNvc1cwJQw3k98ZqT7pWDnFUabenp6Q2Q3/dDwRY?=
 =?us-ascii?Q?4vJRVjwVFzgLAlI+yFgZIPu0/Zfiq52pRSuT5+yH/Chg5taY5+h8A6xmzfS8?=
 =?us-ascii?Q?YfEL/BmZMFUUo1KZgJ0GOKWaVaVPWKSrDgtNda9sO0CP0zR+xDvO+tbRuGVb?=
 =?us-ascii?Q?i7j+HFCqLLO/UbVIzlZtTnUSVXxWgM0XaH+SrJnT/s5turN5d460gQWyGbdc?=
 =?us-ascii?Q?V7/SzWIh0k5HCd1MSSEDA5GC1HC78p+R6DvhpUe93fv3yiGnCGdKaM8lItld?=
 =?us-ascii?Q?PeWvsGKaFtX2IEI7cjAOxRVdkZiXTpRw8l/jTVerz6spq61ULsDVdd1UMK5q?=
 =?us-ascii?Q?Sbz6MtoryGLM4c0vRTp1bTqAjJBZDnxFg7rekPdsLXFmJG8q3YWTNZOgBYWc?=
 =?us-ascii?Q?DL1Dyeunek4wJrvM5Jmxljx4gl0hrp4gQ6/WBEn81kQdTtGnBl4NeM9ii+60?=
 =?us-ascii?Q?dGhAU9THzrbVS+OU9wIoONGGGjVtRniewJ7DdokWU2cpX9yQ3y+iAp31KXEj?=
 =?us-ascii?Q?irxFVnwvXEe6N8gjoT4eG6WUGqP4HiagnQ4jE5uCjS/47OYVPyA8le3fzka/?=
 =?us-ascii?Q?U39bQVrz3PV39f5P5zHxR5fnXagO9KOMQLrTxqi7IqJDCOXgvxTqSipZ1F7Y?=
 =?us-ascii?Q?dCTVgxN/8zMJrIU0JyaFn99TLM0ID03OQxAOu1aozzvQIYptSQXznjz4Z0oa?=
 =?us-ascii?Q?N0YMapirECC7pKjkjs36qjD8oDiV/vaCYPYhbIMnCpl0/IuiF66oaz2F1XFS?=
 =?us-ascii?Q?nkbEpQZbu5KFUa4rHwfG2yvmY4Z/mQ4FnyFlE7+puu3wZol+fTbQqp76NkmS?=
 =?us-ascii?Q?j5mQjKRrGdqpKpJr8e20A3AWeiGS990OhvW6379BLmQ49G7zdTXPgCJvp0kR?=
 =?us-ascii?Q?U26M1Vylif3/ErOKuImS7tpbDd1LKNUsXVZjHxMl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f7d1d0-1dd2-4ed9-b2e3-08dbd4655c82
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 07:46:41.1344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jx62Sl/+qn4TDC251jGA1C+vybPrYE1qRi/W4EB2gFWSDFk9hmMztBIJ7gjx9YCBf4l3P/zZShV+W44LFYElLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7181
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Tuesday, September 26, 2023 10:40 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org; Sharvar=
i
> Harisangam <sharvari.harisangam@nxp.com>; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; kvalo@kernel.org; amitkarwar@gmail.com;
> ganapathi017@gmail.com; huxinming820@gmail.com; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Brian Norris
> <briannorris@chromium.org>
> Subject: [EXT] Re: [PATCH v4 1/1] wifi: mwifiex: added code to support ho=
st
> mlme.
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Hello David,
>=20
> For the next v5 please be sure to properly thread the series as git-send-=
email
> would normally do (if you are going to have a cover
> letter) or even better just add the changelog after the commit message
> (separated with ---).
>=20
>=20
> On Tue, Aug 15, 2023 at 07:09:25AM +0000, David Lin wrote:
> > 1. For station mode first.
> > 2. This feature is a must for WPA3.
> > 3. Firmware key api version 2 is needed for this feature.
> > 4. The code is only enabled and tested with IW416.
> > 5. This feature is disabled for other chips.
>=20
> I believe that this commit message should be rewritten, at least to me th=
is was
> confusing to read at first.
>=20
> Maybe something like that?
>=20
> ```
> wifi: mwifiex: add MLME support
>=20
> Add host based MLME support for station mode to enable WPA3
> functionalities.
>=20
> This feature requires a firmware with key API major version 2 and is curr=
ently
> enabled and tested only for IW416.
> ```
>=20
> Was this patch tested to be wholly working with WPA3 or you expect follow=
 up
> patches for proper enabling WPA3 support?
>=20

I will prepare cover letter with related patches for same thread for Patch =
v7.

>=20
> > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > ---
> >  .../net/wireless/marvell/mwifiex/cfg80211.c   | 327
> ++++++++++++++++++
> >  drivers/net/wireless/marvell/mwifiex/cmdevt.c |  14 +-
> >  drivers/net/wireless/marvell/mwifiex/decl.h   |  12 +
> >  drivers/net/wireless/marvell/mwifiex/fw.h     |  15 +
> >  drivers/net/wireless/marvell/mwifiex/init.c   |   3 +
> >  drivers/net/wireless/marvell/mwifiex/join.c   |  64 +++-
> >  drivers/net/wireless/marvell/mwifiex/main.h   |  10 +
> >  drivers/net/wireless/marvell/mwifiex/scan.c   |   6 +
> >  drivers/net/wireless/marvell/mwifiex/sdio.c   |  13 +
> >  drivers/net/wireless/marvell/mwifiex/sdio.h   |   2 +
> >  .../net/wireless/marvell/mwifiex/sta_event.c  |  18 +-
> >  .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   3 +-
> >  drivers/net/wireless/marvell/mwifiex/sta_tx.c |  10 +-
> >  .../net/wireless/marvell/mwifiex/uap_cmd.c    |  26 ++
> >  drivers/net/wireless/marvell/mwifiex/util.c   |  73 ++++
> >  15 files changed, 583 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > index ba4e29713a8c..605952ee0aa9 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > @@ -57,6 +57,31 @@ ieee80211_iface_combination
> mwifiex_iface_comb_ap_sta_drcs =3D {
> >       .beacon_int_infra_match =3D true,
> >  };
> >
> > +struct mwifiex_ieee80211_mgmt {
> What's the reasoning for having this in cfg80211.c?
> Am I wrong or most of this binary structures are defined in fw.h?

Yes. You are right. I will move this definition to fw.h. Patch v7 will have=
 this modification.

>=20
> > +     __le16 frame_control;
> > +     __le16 duration;
> > +     u8 da[ETH_ALEN];
> > +     u8 sa[ETH_ALEN];
> > +     u8 bssid[ETH_ALEN];
> > +     __le16 seq_ctrl;
> > +     u8 addr4[ETH_ALEN];
> > +     union {
> > +             struct {
> > +                     __le16 auth_alg;
> > +                     __le16 auth_transaction;
> > +                     __le16 status_code;
> > +                     /* possibly followed by Challenge text */
> > +                     u8 variable[];
> > +             } __packed auth;
> > +             struct {
> > +                     __le16 capab_info;
> > +                     __le16 listen_interval;
> > +                     /* followed by SSID and Supported rates */
> > +                     u8 variable[];
> > +             } __packed assoc_req;
> > +     } u;
> > +} __pack;
>=20
> __packed
>=20

Modification will be included in Patch v7.

> >  /*
> >   * This function maps the nl802.11 channel type into driver channel ty=
pe.
> >   *
> > @@ -268,6 +293,8 @@
> > mwifiex_cfg80211_update_mgmt_frame_registrations(struct wiphy *wiphy,
> >
> >       if (mask !=3D priv->mgmt_frame_mask) {
> >               priv->mgmt_frame_mask =3D mask;
> > +             if (priv->host_mlme_reg)
> > +                     priv->mgmt_frame_mask |=3D
> HOST_MLME_MGMT_MASK;
> >               mwifiex_send_cmd(priv,
> HostCmd_CMD_MGMT_FRAME_REG,
> >                                HostCmd_ACT_GEN_SET, 0,
> >                                &priv->mgmt_frame_mask, false);
> @@
> > -848,6 +875,7 @@ static int mwifiex_deinit_priv_params(struct
> mwifiex_private *priv)
> >       struct mwifiex_adapter *adapter =3D priv->adapter;
> >       unsigned long flags;
> >
> > +     priv->host_mlme_reg =3D false;
> >       priv->mgmt_frame_mask =3D 0;
> >       if (mwifiex_send_cmd(priv, HostCmd_CMD_MGMT_FRAME_REG,
> >                            HostCmd_ACT_GEN_SET, 0, @@ -4201,6
> > +4229,292 @@ mwifiex_cfg80211_change_station(struct wiphy *wiphy,
> struct net_device *dev,
> >       return ret;
> >  }
> >
> > +static int
> > +mwifiex_cfg80211_authenticate(struct wiphy *wiphy,
> > +                           struct net_device *dev,
> > +                           struct cfg80211_auth_request *req) {
> > +     struct mwifiex_private *priv =3D mwifiex_netdev_get_priv(dev);
> > +     struct mwifiex_adapter *adapter =3D priv->adapter;
> > +     struct sk_buff *skb;
> > +     u16 pkt_len, auth_alg;
> > +     int ret;
> > +     struct mwifiex_ieee80211_mgmt *mgmt;
> > +     struct mwifiex_txinfo *tx_info;
> > +     u32 tx_control =3D 0, pkt_type =3D PKT_TYPE_MGMT;
> > +     u8 addr[ETH_ALEN] =3D {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};
> > +     u8 trans =3D 1, status_code =3D 0;
> > +     u8 *varptr;
> > +
> > +     if (GET_BSS_ROLE(priv) =3D=3D MWIFIEX_BSS_ROLE_UAP) {
> > +             mwifiex_dbg(priv->adapter, ERROR, "Interface role is
> AP\n");
> > +             return -EFAULT;
> > +     }
> > +
> > +     if (priv->wdev.iftype !=3D NL80211_IFTYPE_STATION) {
> > +             mwifiex_dbg(priv->adapter, ERROR,
> > +                         "Interface type is not correct (type %d)\n",
> > +                         priv->wdev.iftype);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (priv->auth_alg !=3D WLAN_AUTH_SAE &&
> > +         (priv->auth_flag & HOST_MLME_AUTH_PENDING)) {
> > +             mwifiex_dbg(priv->adapter, ERROR, "Pending auth on
> going\n");
> > +             return -EBUSY;
> > +     }
> > +
> > +     if (!priv->host_mlme_reg) {
> > +             priv->host_mlme_reg =3D true;
> > +             priv->mgmt_frame_mask |=3D HOST_MLME_MGMT_MASK;
> > +             mwifiex_send_cmd(priv,
> HostCmd_CMD_MGMT_FRAME_REG,
> > +                              HostCmd_ACT_GEN_SET, 0,
> > +                              &priv->mgmt_frame_mask, false);
> > +     }
> > +
> > +     switch (req->auth_type) {
> > +     case NL80211_AUTHTYPE_OPEN_SYSTEM:
> > +             auth_alg =3D WLAN_AUTH_OPEN;
> > +             break;
> > +     case NL80211_AUTHTYPE_SHARED_KEY:
> > +             auth_alg =3D WLAN_AUTH_SHARED_KEY;
> > +             break;
> > +     case NL80211_AUTHTYPE_FT:
> > +             auth_alg =3D WLAN_AUTH_FT;
> > +             break;
> > +     case NL80211_AUTHTYPE_NETWORK_EAP:
> > +             auth_alg =3D WLAN_AUTH_LEAP;
> > +             break;
> > +     case NL80211_AUTHTYPE_SAE:
> > +             auth_alg =3D WLAN_AUTH_SAE;
> > +             break;
> > +     default:
> > +             mwifiex_dbg(priv->adapter, ERROR,
> > +                         "unsupported auth type=3D%d\n",
> req->auth_type);
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     if (!priv->auth_flag) {
> > +             ret =3D mwifiex_remain_on_chan_cfg(priv,
> HostCmd_ACT_GEN_SET,
> > +                                              req->bss->channel,
> > +
> > + AUTH_TX_DEFAULT_WAIT_TIME);
> > +
> > +             if (!ret) {
> > +                     priv->roc_cfg.cookie =3D get_random_u32() | 1;
> > +                     priv->roc_cfg.chan =3D *req->bss->channel;
> > +             }
> > +     }
> > +
> > +     priv->sec_info.authentication_mode =3D auth_alg;
> > +
> > +     mwifiex_cancel_scan(adapter);
> > +
> > +     pkt_len =3D (u16)req->ie_len + req->auth_data_len +
> > +                  MWIFIEX_MGMT_HEADER_LEN +
> MWIFIEX_AUTH_BODY_LEN;
> > +     if (req->auth_data_len >=3D 4)
> > +             pkt_len -=3D 4;
> > +
> > +     skb =3D dev_alloc_skb(MWIFIEX_MIN_DATA_HEADER_LEN +
> > +                         MWIFIEX_MGMT_FRAME_HEADER_SIZE +
> > +                         pkt_len + sizeof(pkt_len));
> > +     if (!skb) {
> > +             mwifiex_dbg(priv->adapter, ERROR,
> > +                         "allocate skb failed for management
> frame\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     tx_info =3D MWIFIEX_SKB_TXCB(skb);
> > +     memset(tx_info, 0, sizeof(*tx_info));
> > +     tx_info->bss_num =3D priv->bss_num;
> > +     tx_info->bss_type =3D priv->bss_type;
> > +     tx_info->pkt_len =3D pkt_len;
> > +
> > +     skb_reserve(skb, MWIFIEX_MIN_DATA_HEADER_LEN +
> > +                 MWIFIEX_MGMT_FRAME_HEADER_SIZE +
> sizeof(pkt_len));
> > +     memcpy(skb_push(skb, sizeof(pkt_len)), &pkt_len, sizeof(pkt_len))=
;
> > +     memcpy(skb_push(skb, sizeof(tx_control)),
> > +            &tx_control, sizeof(tx_control));
> > +     memcpy(skb_push(skb, sizeof(pkt_type)), &pkt_type,
> > + sizeof(pkt_type));
> > +
> > +     mgmt =3D (struct mwifiex_ieee80211_mgmt *)skb_put(skb, pkt_len);
> > +     memset(mgmt, 0, pkt_len);
> > +     mgmt->frame_control =3D
> > +             cpu_to_le16(IEEE80211_FTYPE_MGMT |
> IEEE80211_STYPE_AUTH);
> > +     memcpy(mgmt->da, req->bss->bssid, ETH_ALEN);
> > +     memcpy(mgmt->sa, priv->curr_addr, ETH_ALEN);
> > +     memcpy(mgmt->bssid, req->bss->bssid, ETH_ALEN);
> > +     memcpy(mgmt->addr4, addr, ETH_ALEN);
> > +
> > +     if (req->auth_data_len >=3D 4) {
> > +             if (req->auth_type =3D=3D NL80211_AUTHTYPE_SAE) {
> > +                     __le16 *pos =3D (__le16 *)req->auth_data;
> > +
> > +                     trans =3D le16_to_cpu(pos[0]);
> > +                     status_code =3D le16_to_cpu(pos[1]);
> > +             }
> > +             memcpy((u8 *)(&mgmt->u.auth.variable), req->auth_data +
> 4,
> > +                    req->auth_data_len - 4);
> > +             varptr =3D (u8 *)&mgmt->u.auth.variable +
> > +                      (req->auth_data_len - 4);
> > +     }
> > +
> > +     mgmt->u.auth.auth_alg =3D cpu_to_le16(auth_alg);
> > +     mgmt->u.auth.auth_transaction =3D trans;
> > +     mgmt->u.auth.status_code =3D status_code;
> > +
> > +     if (req->ie && req->ie_len) {
> > +             if (!varptr)
> > +                     varptr =3D (u8 *)&mgmt->u.auth.variable;
> > +             memcpy((u8 *)varptr, req->ie, req->ie_len);
> > +     }
> > +
> > +     priv->auth_flag =3D HOST_MLME_AUTH_PENDING;
> > +     priv->auth_alg =3D auth_alg;
> > +
> > +     skb->priority =3D WMM_HIGHEST_PRIORITY;
> > +     __net_timestamp(skb);
> > +
> > +     mwifiex_dbg(priv->adapter, MSG,
> > +                 "auth: send authentication to %pM\n",
> > + req->bss->bssid);
> > +
> > +     mwifiex_queue_tx_pkt(priv, skb);
> > +
> > +     return 0;
> > +}
> > +
> > +static int
> > +mwifiex_cfg80211_associate(struct wiphy *wiphy, struct net_device *dev=
,
> > +                        struct cfg80211_assoc_request *req) {
> > +     struct mwifiex_private *priv =3D mwifiex_netdev_get_priv(dev);
> > +     struct mwifiex_adapter *adapter =3D priv->adapter;
> > +     int ret;
> > +     struct cfg80211_ssid req_ssid;
> > +     const u8 *ssid_ie;
> > +     struct cfg80211_rx_assoc_resp assoc_resp =3D {
> > +             .uapsd_queues =3D -1,
> > +     };
> > +
> > +     if (GET_BSS_ROLE(priv) !=3D MWIFIEX_BSS_ROLE_STA) {
> > +             mwifiex_dbg(adapter, ERROR,
> > +                         "%s: reject infra assoc request in non-STA
> role\n",
> > +                         dev->name);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (test_bit(MWIFIEX_SURPRISE_REMOVED, &adapter->work_flags) ||
> > +         test_bit(MWIFIEX_IS_CMD_TIMEDOUT, &adapter->work_flags))
> {
> > +             mwifiex_dbg(adapter, ERROR,
> > +                         "%s: Ignore association.\t"
> > +                         "Card removed or FW in bad state\n",
> > +                         dev->name);
> > +             return -EFAULT;
> > +     }
> > +
> > +     if (priv->auth_alg =3D=3D WLAN_AUTH_SAE)
> > +             priv->auth_flag =3D HOST_MLME_AUTH_DONE;
> > +
> > +     if (priv->auth_flag && !(priv->auth_flag &
> HOST_MLME_AUTH_DONE))
> > +             return -EBUSY;
> > +
> > +     if (!mwifiex_stop_bg_scan(priv))
> > +             cfg80211_sched_scan_stopped_locked(priv->wdev.wiphy,
> 0);
> > +
> > +     memset(&req_ssid, 0, sizeof(struct cfg80211_ssid));
> > +     rcu_read_lock();
> > +     ssid_ie =3D ieee80211_bss_get_ie(req->bss, WLAN_EID_SSID);
> > +
> > +     if (!ssid_ie)
> > +             goto ssid_err;
> > +
> > +     req_ssid.ssid_len =3D ssid_ie[1];
> > +     if (req_ssid.ssid_len > IEEE80211_MAX_SSID_LEN) {
> > +             mwifiex_dbg(priv->adapter, ERROR, "invalid SSID -
> aborting\n");
> > +             goto ssid_err;
> > +     }
> > +
> > +     memcpy(req_ssid.ssid, ssid_ie + 2, req_ssid.ssid_len);
> > +     if (!req_ssid.ssid_len || req_ssid.ssid[0] < 0x20) {
> > +             mwifiex_dbg(priv->adapter, ERROR, "invalid SSID -
> aborting\n");
> > +             goto ssid_err;
> > +     }
> > +     rcu_read_unlock();
> > +
> > +     /* As this is new association, clear locally stored
> > +      * keys and security related flags
> > +      */
> > +     priv->sec_info.wpa_enabled =3D false;
> > +     priv->sec_info.wpa2_enabled =3D false;
> > +     priv->wep_key_curr_index =3D 0;
> > +     priv->sec_info.encryption_mode =3D 0;
> > +     priv->sec_info.is_authtype_auto =3D 0;
> > +     ret =3D mwifiex_set_encode(priv, NULL, NULL, 0, 0, NULL, 1);
> > +
> > +     if (req->crypto.n_ciphers_pairwise)
> > +             priv->sec_info.encryption_mode =3D
> > +                     req->crypto.ciphers_pairwise[0];
> > +
> > +     if (req->crypto.cipher_group)
> > +             priv->sec_info.encryption_mode =3D
> > + req->crypto.cipher_group;
> > +
> > +     if (req->ie)
> > +             ret =3D mwifiex_set_gen_ie(priv, req->ie, req->ie_len);
> > +
> > +     memcpy(priv->cfg_bssid, req->bss->bssid, ETH_ALEN);
> > +
> > +     mwifiex_dbg(priv->adapter, MSG,
> > +                 "assoc: send association to %pM\n",
> > + req->bss->bssid);
> > +
> > +     cfg80211_ref_bss(priv->adapter->wiphy, req->bss);
> > +
> > +     ret =3D mwifiex_bss_start(priv, req->bss, &req_ssid);
> > +
> > +     if (!ret) {
> > +             assoc_resp.links[0].bss =3D priv->attempted_bss_desc->bss=
;
> > +             assoc_resp.buf =3D priv->assoc_rsp_buf;
> > +             assoc_resp.len =3D priv->assoc_rsp_size;
> > +             cfg80211_rx_assoc_resp(priv->netdev,
> > +                                    &assoc_resp);
> > +     } else {
> > +             priv->auth_flag =3D 0;
> > +             priv->auth_alg =3D 0xFFFF;
> worth a define? you have it multiple times.
>=20

O.K. Modifications will be included in Patch v7.

> > +             eth_zero_addr(priv->cfg_bssid);
> > +     }
> > +
> > +     cfg80211_put_bss(priv->adapter->wiphy, req->bss);
> > +
> > +     return 0;
> > +
> > +ssid_err:
> > +
> > +     rcu_read_unlock();
> > +     return -EFAULT;
> > +}
> > +
> > +static int
> > +mwifiex_cfg80211_deauthenticate(struct wiphy *wiphy,
> > +                             struct net_device *dev,
> > +                             struct cfg80211_deauth_request *req) {
> > +     return mwifiex_cfg80211_disconnect(wiphy, dev,
> > +req->reason_code); }
> > +
> > +static int
> > +mwifiex_cfg80211_disassociate(struct wiphy *wiphy,
> > +                           struct net_device *dev,
> > +                           struct cfg80211_disassoc_request *req) {
> > +     return mwifiex_cfg80211_disconnect(wiphy, dev,
> > +req->reason_code); }
> > +
> > +static int
> > +mwifiex_cfg80211_probe_client(struct wiphy *wiphy,
> > +                           struct net_device *dev, const u8 *peer,
> > +                           u64 *cookie) {
> > +     return -1;
> > +}
> > +
> >  /* station cfg80211 operations */
> >  static struct cfg80211_ops mwifiex_cfg80211_ops =3D {
> >       .add_virtual_intf =3D mwifiex_add_virtual_intf, @@ -4346,6
> > +4660,16 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter
> *adapter)
> >                           "%s: creating new wiphy\n", __func__);
> >               return -ENOMEM;
> >       }
> > +     if (adapter->host_mlme) {
> I think this variable should be renamed to host_mlme_enabled or
> mlme_enabled, not sure what's the best.

I will change it as host_mlme_enabled. Patch v7 will include this modificat=
ion.

>=20
> > +             mwifiex_cfg80211_ops.auth =3D
> mwifiex_cfg80211_authenticate;
> > +             mwifiex_cfg80211_ops.assoc =3D
> mwifiex_cfg80211_associate;
> > +             mwifiex_cfg80211_ops.deauth =3D
> mwifiex_cfg80211_deauthenticate;
> > +             mwifiex_cfg80211_ops.disassoc =3D
> mwifiex_cfg80211_disassociate;
> > +             mwifiex_cfg80211_ops.disconnect =3D NULL;
> > +             mwifiex_cfg80211_ops.connect =3D NULL;
> > +             mwifiex_cfg80211_ops.probe_client =3D
> > +                     mwifiex_cfg80211_probe_client;
> do you need defining this to a function that just return -1? Is this requ=
ired?
>=20
> > +     }
> >       wiphy->max_scan_ssids =3D MWIFIEX_MAX_SSID_LIST_LENGTH;
> >       wiphy->max_scan_ie_len =3D MWIFIEX_MAX_VSIE_LEN;
> >       wiphy->mgmt_stypes =3D mwifiex_mgmt_stypes; @@ -4427,6 +4751,9
> @@
> > int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
> >                          NL80211_FEATURE_LOW_PRIORITY_SCAN |
> >                          NL80211_FEATURE_NEED_OBSS_SCAN;
> >
> > +     if (adapter->host_mlme)
> > +             wiphy->features |=3D NL80211_FEATURE_SAE;
> > +
> >       if (ISSUPP_ADHOC_ENABLED(adapter->fw_cap_info))
> >               wiphy->features |=3D NL80211_FEATURE_HT_IBSS;
> >
> > diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
> > b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
> > index 3756aa247e77..311af5f40c3e 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
> > @@ -654,7 +654,7 @@ int mwifiex_send_cmd(struct mwifiex_private *priv,
> u16 cmd_no,
> >       if (ret) {
> >               mwifiex_dbg(adapter, ERROR,
> >                           "PREP_CMD: cmd %#x preparation
> failed\n",
> > -                     cmd_no);
> > +                         cmd_no);
> unrelated change
>=20

Fixed format.

> >               mwifiex_insert_cmd_to_free_q(adapter, cmd_node);
> >               return -1;
> >       }
> > @@ -1477,6 +1477,17 @@ int mwifiex_cmd_get_hw_spec(struct
> mwifiex_private *priv,
> >       return 0;
> >  }
> >
> > +static void mwifiex_check_key_api_ver(struct mwifiex_adapter
> > +*adapter) {
> > +     if (adapter->host_mlme) {
> > +             if (adapter->key_api_major_ver !=3D
> KEY_API_VER_MAJOR_V2)
> > +                     adapter->host_mlme =3D false;
> > +             mwifiex_dbg(adapter, MSG, "host_mlme: %s, key_api:
> %d\n",
> > +                         adapter->host_mlme ? "enable" : "disable",
> > +                         adapter->key_api_major_ver);
> > +     }
> > +}
> > +
> >  /*
> >   * This function handles the command response of get hardware
> >   * specifications.
> > @@ -1586,6 +1597,7 @@ int mwifiex_ret_get_hw_spec(struct
> mwifiex_private *priv,
> >                                                   "key_api
> v%d.%d\n",
> >
> adapter->key_api_major_ver,
> >
> > adapter->key_api_minor_ver);
> > +
> > + mwifiex_check_key_api_ver(adapter);
> for other functionalities you have everything at the end of
> mwifiex_ret_get_hw_spec()
>=20
> why not doing the same here? Just do the check in a similar way as done f=
or
> scan_chan_gap_enabled.
>

O.K. Patch v7 will include the modification.
=20
>=20
>=20
> >                                       break;
> >                               case FW_API_VER_ID:
> >                                       adapter->fw_api_ver =3D diff
> --git
> > a/drivers/net/wireless/marvell/mwifiex/decl.h
> > b/drivers/net/wireless/marvell/mwifiex/decl.h
> > index 88648c062713..385b5119f2ee 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/decl.h
> > +++ b/drivers/net/wireless/marvell/mwifiex/decl.h
> > @@ -24,6 +24,18 @@
> >  #define MWIFIEX_RX_HEADROOM      64
> >  #define MAX_TXPD_SZ              32
> >  #define INTF_HDR_ALIGN                    4
> > +/* frmctl + durationid + addr1 + addr2 + addr3 + seqctl + addr4 */
> > +#define MWIFIEX_MGMT_HEADER_LEN   (2 + 2 + 6 + 6 + 6 + 2 + 6)
> > +/* 6   =3D auth_alg + auth_transaction + auth_status */
> > +#define MWIFIEX_AUTH_BODY_LEN     6
>=20
> those comments and magic number are quite confusing, in other part of the
> code (just a few lines after), proper defines are used. Maybe doing the s=
ame
> here would help and we could get rid of the comment?

O.K. I will redefine them.

>=20
> > +
> > +#define HOST_MLME_AUTH_PENDING    BIT(0)
> > +#define HOST_MLME_AUTH_DONE       BIT(1)
> > +
> > +#define HOST_MLME_MGMT_MASK       (BIT(IEEE80211_STYPE_AUTH
> >> 4) | \
> > +                                BIT(IEEE80211_STYPE_DEAUTH >> 4)
> | \
> > +                                BIT(IEEE80211_STYPE_DISASSOC >>
> 4))
> > +#define AUTH_TX_DEFAULT_WAIT_TIME 2400
> >
> >  #define MWIFIEX_MIN_DATA_HEADER_LEN (MWIFIEX_DMA_ALIGN_SZ +
> INTF_HDR_ALIGN + \
> >                                    MAX_TXPD_SZ) diff --git
> > a/drivers/net/wireless/marvell/mwifiex/fw.h
> > b/drivers/net/wireless/marvell/mwifiex/fw.h
> > index f2168fac95ed..5e6bda38f22c 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/fw.h
> > +++ b/drivers/net/wireless/marvell/mwifiex/fw.h
> > @@ -209,6 +209,9 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
> >  #define TLV_TYPE_RANDOM_MAC         (PROPRIETARY_TLV_BASE_ID
> + 236)
> >  #define TLV_TYPE_CHAN_ATTR_CFG      (PROPRIETARY_TLV_BASE_ID +
> 237)
> >  #define TLV_TYPE_MAX_CONN           (PROPRIETARY_TLV_BASE_ID
> + 279)
> > +#define TLV_TYPE_HOST_MLME          (PROPRIETARY_TLV_BASE_ID +
> 307)
> > +#define TLV_TYPE_SAE_PWE_MODE       (PROPRIETARY_TLV_BASE_ID +
> 339)
> > +
> >
> >  #define MWIFIEX_TX_DATA_BUF_SIZE_2K        2048
> >
> > @@ -802,6 +805,11 @@ struct mwifiex_ie_types_ssid_param_set {
> >       u8 ssid[];
> >  } __packed;
> >
> > +struct mwifiex_ie_types_host_mlme {
> > +     struct mwifiex_ie_types_header header;
> > +     u8 host_mlme;
> > +} __packed;
> > +
> >  struct mwifiex_ie_types_num_probes {
> >       struct mwifiex_ie_types_header header;
> >       __le16 num_probes;
> > @@ -905,6 +913,13 @@ struct mwifiex_ie_types_tdls_idle_timeout {
> >       __le16 value;
> >  } __packed;
> >
> > +#define MWIFIEX_AUTHTYPE_SAE 6
> > +
> > +struct mwifiex_ie_types_sae_pwe_mode {
> > +     struct mwifiex_ie_types_header header;
> > +     u8 pwe[];
> > +} __packed;
> > +
> >  struct mwifiex_ie_types_rsn_param_set {
> >       struct mwifiex_ie_types_header header;
> >       u8 rsn_ie[];
> > diff --git a/drivers/net/wireless/marvell/mwifiex/init.c
> > b/drivers/net/wireless/marvell/mwifiex/init.c
> > index 7dddb4b5dea1..ca23be8d3ac3 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/init.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/init.c
> > @@ -81,6 +81,9 @@ int mwifiex_init_priv(struct mwifiex_private *priv)
> >       priv->bcn_avg_factor =3D DEFAULT_BCN_AVG_FACTOR;
> >       priv->data_avg_factor =3D DEFAULT_DATA_AVG_FACTOR;
> >
> > +     priv->auth_flag =3D 0;
> > +     priv->auth_alg =3D 0xFFFF;
> > +
> >       priv->sec_info.wep_enabled =3D 0;
> >       priv->sec_info.authentication_mode =3D
> NL80211_AUTHTYPE_OPEN_SYSTEM;
> >       priv->sec_info.encryption_mode =3D 0; diff --git
> > a/drivers/net/wireless/marvell/mwifiex/join.c
> > b/drivers/net/wireless/marvell/mwifiex/join.c
> > index a6e254a1185c..ef7cc40c3ba4 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/join.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/join.c
> > @@ -382,7 +382,9 @@ int mwifiex_cmd_802_11_associate(struct
> mwifiex_private *priv,
> >       struct mwifiex_ie_types_ss_param_set *ss_tlv;
> >       struct mwifiex_ie_types_rates_param_set *rates_tlv;
> >       struct mwifiex_ie_types_auth_type *auth_tlv;
> > +     struct mwifiex_ie_types_sae_pwe_mode *sae_pwe_tlv;
> >       struct mwifiex_ie_types_chan_list_param_set *chan_tlv;
> > +     struct mwifiex_ie_types_host_mlme *host_mlme_tlv;
> >       u8 rates[MWIFIEX_SUPPORTED_RATES];
> >       u32 rates_size;
> >       u16 tmp_cap;
> > @@ -448,7 +450,7 @@ int mwifiex_cmd_802_11_associate(struct
> mwifiex_private *priv,
> >       mwifiex_dbg(priv->adapter, INFO, "info: ASSOC_CMD: rates size =3D
> %d\n",
> >                   rates_size);
> >
> > -     /* Add the Authentication type to be used for Auth frames */
> > +     /* Add the Authentication type */
> >       auth_tlv =3D (struct mwifiex_ie_types_auth_type *) pos;
> >       auth_tlv->header.type =3D cpu_to_le16(TLV_TYPE_AUTH_TYPE);
> >       auth_tlv->header.len =3D cpu_to_le16(sizeof(auth_tlv->auth_type))=
;
> > @@ -460,6 +462,24 @@ int mwifiex_cmd_802_11_associate(struct
> > mwifiex_private *priv,
> >
> >       pos +=3D sizeof(auth_tlv->header) +
> > le16_to_cpu(auth_tlv->header.len);
> >
> > +     if (priv->sec_info.authentication_mode =3D=3D WLAN_AUTH_SAE) {
> > +             auth_tlv->auth_type =3D
> cpu_to_le16(MWIFIEX_AUTHTYPE_SAE);
> > +             if (bss_desc->bcn_rsnx_ie &&
> > +                 bss_desc->bcn_rsnx_ie->ieee_hdr.len &&
> > +                 (bss_desc->bcn_rsnx_ie->data[0] &
> > +                 WLAN_RSNX_CAPA_SAE_H2E)) {
> > +                     sae_pwe_tlv =3D
> > +                             (struct
> mwifiex_ie_types_sae_pwe_mode *)pos;
> > +                     sae_pwe_tlv->header.type =3D
> > +
> cpu_to_le16(TLV_TYPE_SAE_PWE_MODE);
> > +                     sae_pwe_tlv->header.len =3D
> > +
> cpu_to_le16(sizeof(sae_pwe_tlv->pwe[0]));
> > +                     sae_pwe_tlv->pwe[0] =3D
> bss_desc->bcn_rsnx_ie->data[0];
> > +                     pos +=3D sizeof(sae_pwe_tlv->header) +
> > +                             sizeof(sae_pwe_tlv->pwe[0]);
> > +             }
> > +     }
> > +
> >       if (IS_SUPPORT_MULTI_BANDS(priv->adapter) &&
> >           !(ISSUPP_11NENABLED(priv->adapter->fw_cap_info) &&
> >           (!bss_desc->disable_11n) &&
> > @@ -491,6 +511,16 @@ int mwifiex_cmd_802_11_associate(struct
> mwifiex_private *priv,
> >                       sizeof(struct mwifiex_chan_scan_param_set);
> >       }
> >
> > +     if (priv->adapter->host_mlme) {
> > +             host_mlme_tlv =3D (struct mwifiex_ie_types_host_mlme
> *)pos;
> > +             host_mlme_tlv->header.type =3D
> cpu_to_le16(TLV_TYPE_HOST_MLME);
> > +             host_mlme_tlv->header.len =3D
> > +                     cpu_to_le16(sizeof(host_mlme_tlv->host_mlme));
> > +             host_mlme_tlv->host_mlme =3D 1;
> > +             pos +=3D sizeof(host_mlme_tlv->header) +
> > +                     sizeof(host_mlme_tlv->host_mlme);
> > +     }
> > +
> >       if (!priv->wps.session_enable) {
> >               if (priv->sec_info.wpa_enabled ||
> priv->sec_info.wpa2_enabled)
> >                       rsn_ie_len =3D
> > mwifiex_append_rsn_ie_wpa_wpa2(priv, &pos); @@ -634,6 +664,7 @@ int
> mwifiex_ret_802_11_associate(struct mwifiex_private *priv,
> >       u16 cap_info, status_code, aid;
> >       const u8 *ie_ptr;
> >       struct ieee80211_ht_operation *assoc_resp_ht_oper;
> > +     struct ieee80211_mgmt *hdr;
> >
> >       if (!priv->attempted_bss_desc) {
> >               mwifiex_dbg(priv->adapter, ERROR, @@ -641,7 +672,19
> @@
> > int mwifiex_ret_802_11_associate(struct mwifiex_private *priv,
> >               goto done;
> >       }
> >
> > -     assoc_rsp =3D (struct ieee_types_assoc_rsp *) &resp->params;
> > +     if (adapter->host_mlme) {
> > +             hdr =3D (struct ieee80211_mgmt *)&resp->params;
> > +             if (!memcmp(hdr->bssid,
> > +                         priv->attempted_bss_desc->mac_address,
> > +                         ETH_ALEN))
> > +                     assoc_rsp =3D (struct ieee_types_assoc_rsp *)
> > +                             &hdr->u.assoc_resp;
> > +             else
> > +                     assoc_rsp =3D
> > +                             (struct ieee_types_assoc_rsp
> *)&resp->params;
> > +     } else {
> > +             assoc_rsp =3D (struct ieee_types_assoc_rsp *)&resp->param=
s;
> > +     }
> >
> >       cap_info =3D le16_to_cpu(assoc_rsp->cap_info_bitmap);
> >       status_code =3D le16_to_cpu(assoc_rsp->status_code);
> > @@ -778,7 +821,8 @@ int mwifiex_ret_802_11_associate(struct
> > mwifiex_private *priv,
> >
> >       priv->adapter->dbg.num_cmd_assoc_success++;
> >
> > -     mwifiex_dbg(priv->adapter, INFO, "info: ASSOC_RESP: associated\n"=
);
> > +     mwifiex_dbg(priv->adapter, MSG, "assoc: associated with %pM\n",
> > +                 priv->attempted_bss_desc->mac_address);
> >
> >       /* Add the ra_list here for infra mode as there will be only 1 ra
> >          always */
> > @@ -1491,6 +1535,20 @@ int mwifiex_deauthenticate(struct
> mwifiex_private *priv, u8 *mac)
> >       if (!priv->media_connected)
> >               return 0;
> >
> > +     if (priv->adapter->host_mlme) {
> > +             priv->auth_flag =3D 0;
> > +             priv->auth_alg =3D 0xFFFF;
> > +             priv->host_mlme_reg =3D false;
> > +             priv->mgmt_frame_mask =3D 0;
> > +             if (mwifiex_send_cmd(priv,
> HostCmd_CMD_MGMT_FRAME_REG,
> > +                                  HostCmd_ACT_GEN_SET, 0,
> > +                                  &priv->mgmt_frame_mask, false))
> {
> > +                     mwifiex_dbg(priv->adapter, ERROR,
> > +                                 "could not unregister mgmt frame
> rx\n");
> > +                     return -1;
> > +             }
> > +     }
> > +
> >       switch (priv->bss_mode) {
> >       case NL80211_IFTYPE_STATION:
> >       case NL80211_IFTYPE_P2P_CLIENT:
> > diff --git a/drivers/net/wireless/marvell/mwifiex/main.h
> > b/drivers/net/wireless/marvell/mwifiex/main.h
> > index b95886e1413e..6d0b9fcfe07c 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/main.h
> > +++ b/drivers/net/wireless/marvell/mwifiex/main.h
> > @@ -384,6 +384,7 @@ struct ieee_types_aid {
> >
> >  struct mwifiex_bssdescriptor {
> >       u8 mac_address[ETH_ALEN];
> > +     struct cfg80211_bss *bss;
> >       struct cfg80211_ssid ssid;
> >       u32 privacy;
> >       s32 rssi;
> > @@ -426,6 +427,8 @@ struct mwifiex_bssdescriptor {
> >       u16 wpa_offset;
> >       struct ieee_types_generic *bcn_rsn_ie;
> >       u16 rsn_offset;
> > +     struct ieee_types_generic *bcn_rsnx_ie;
> > +     u16 rsnx_offset;
> >       struct ieee_types_generic *bcn_wapi_ie;
> >       u16 wapi_offset;
> >       u8 *beacon_buf;
> > @@ -536,6 +539,8 @@ struct mwifiex_private {
> >       u8 bss_priority;
> >       u8 bss_num;
> >       u8 bss_started;
> > +     u8 auth_flag;
> > +     u16 auth_alg;
> >       u8 frame_type;
> >       u8 curr_addr[ETH_ALEN];
> >       u8 media_connected;
> > @@ -658,6 +663,7 @@ struct mwifiex_private {
> >       u16 gen_idx;
> >       u8 ap_11n_enabled;
> >       u8 ap_11ac_enabled;
> > +     bool host_mlme_reg;
> >       u32 mgmt_frame_mask;
> >       struct mwifiex_roc_cfg roc_cfg;
> >       bool scan_aborting;
> > @@ -1012,6 +1018,7 @@ struct mwifiex_adapter {
> >       bool is_up;
> >
> >       bool ext_scan;
> > +     bool host_mlme;
> >       u8 fw_api_ver;
> >       u8 key_api_major_ver, key_api_minor_ver;
> >       u8 max_p2p_conn, max_sta_conn;
> > @@ -1077,6 +1084,9 @@ int mwifiex_recv_packet(struct mwifiex_private
> > *priv, struct sk_buff *skb);  int mwifiex_uap_recv_packet(struct
> mwifiex_private *priv,
> >                           struct sk_buff *skb);
> >
> > +void mwifiex_host_mlme_disconnect(struct mwifiex_private *priv,
> > +                               u16 reason_code, u8 *sa);
> > +
> Remove? Not used
>=20

Yes. I will remove this function.

> >  int mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
> >                               struct sk_buff *skb);
> >
> > diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c
> > b/drivers/net/wireless/marvell/mwifiex/scan.c
> > index 644b1e134b01..27eb9a073666 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/scan.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/scan.c
> > @@ -1388,6 +1388,12 @@ int mwifiex_update_bss_desc_with_ie(struct
> mwifiex_adapter *adapter,
> >                       bss_entry->rsn_offset =3D (u16) (current_ptr -
> >
> bss_entry->beacon_buf);
> >                       break;
> > +             case WLAN_EID_RSNX:
> > +                     bss_entry->bcn_rsnx_ie =3D
> > +                             (struct ieee_types_generic
> *)current_ptr;
> > +                     bss_entry->rsnx_offset =3D
> > +                             (u16)(current_ptr -
> bss_entry->beacon_buf);
> > +                     break;
> >               case WLAN_EID_BSS_AC_ACCESS_DELAY:
> >                       bss_entry->bcn_wapi_ie =3D
> >                               (struct ieee_types_generic *)
> > current_ptr; diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c
> > b/drivers/net/wireless/marvell/mwifiex/sdio.c
> > index a24bd40dd41a..6ba0339ccc65 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/sdio.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
> > @@ -331,6 +331,7 @@ static const struct mwifiex_sdio_device
> mwifiex_sdio_sd8786 =3D {
> >       .can_dump_fw =3D false,
> >       .can_auto_tdls =3D false,
> >       .can_ext_scan =3D false,
> > +     .host_mlme =3D false,
> what about the PCIe devices? nothing needed there?
>=20

Since we only enabled and tested for IW416/SDIO, there is no need to modify=
 PCIe related code.

> >  };
> >
> >  static const struct mwifiex_sdio_device mwifiex_sdio_sd8787 =3D { @@
> > -346,6 +347,7 @@ static const struct mwifiex_sdio_device
> mwifiex_sdio_sd8787 =3D {
> >       .can_dump_fw =3D false,
> >       .can_auto_tdls =3D false,
> >       .can_ext_scan =3D true,
> > +     .host_mlme =3D false,
> >  };
> >
> >  static const struct mwifiex_sdio_device mwifiex_sdio_sd8797 =3D { @@
> > -361,6 +363,7 @@ static const struct mwifiex_sdio_device
> mwifiex_sdio_sd8797 =3D {
> >       .can_dump_fw =3D false,
> >       .can_auto_tdls =3D false,
> >       .can_ext_scan =3D true,
> > +     .host_mlme =3D false,
> >  };
> >
> >  static const struct mwifiex_sdio_device mwifiex_sdio_sd8897 =3D { @@
> > -376,6 +379,7 @@ static const struct mwifiex_sdio_device
> mwifiex_sdio_sd8897 =3D {
> >       .can_dump_fw =3D true,
> >       .can_auto_tdls =3D false,
> >       .can_ext_scan =3D true,
> > +     .host_mlme =3D false,
> >  };
> >
> >  static const struct mwifiex_sdio_device mwifiex_sdio_sd8977 =3D { @@
> > -392,6 +396,7 @@ static const struct mwifiex_sdio_device
> mwifiex_sdio_sd8977 =3D {
> >       .fw_dump_enh =3D true,
> >       .can_auto_tdls =3D false,
> >       .can_ext_scan =3D true,
> > +     .host_mlme =3D false,
> >  };
> >
> >  static const struct mwifiex_sdio_device mwifiex_sdio_sd8978 =3D { @@
> > -408,6 +413,7 @@ static const struct mwifiex_sdio_device
> mwifiex_sdio_sd8978 =3D {
> >       .fw_dump_enh =3D true,
> >       .can_auto_tdls =3D false,
> >       .can_ext_scan =3D true,
> > +     .host_mlme =3D true,
> >  };
> >
> >  static const struct mwifiex_sdio_device mwifiex_sdio_sd8997 =3D { @@
> > -425,6 +431,7 @@ static const struct mwifiex_sdio_device
> mwifiex_sdio_sd8997 =3D {
> >       .fw_dump_enh =3D true,
> >       .can_auto_tdls =3D false,
> >       .can_ext_scan =3D true,
> > +     .host_mlme =3D false,
> >  };
> >
> >  static const struct mwifiex_sdio_device mwifiex_sdio_sd8887 =3D { @@
> > -440,6 +447,7 @@ static const struct mwifiex_sdio_device
> mwifiex_sdio_sd8887 =3D {
> >       .can_dump_fw =3D false,
> >       .can_auto_tdls =3D true,
> >       .can_ext_scan =3D true,
> > +     .host_mlme =3D false,
> >  };
> >
> >  static const struct mwifiex_sdio_device mwifiex_sdio_sd8987 =3D { @@
> > -456,6 +464,7 @@ static const struct mwifiex_sdio_device
> mwifiex_sdio_sd8987 =3D {
> >       .fw_dump_enh =3D true,
> >       .can_auto_tdls =3D true,
> >       .can_ext_scan =3D true,
> > +     .host_mlme =3D false,
> >  };
> >
> >  static const struct mwifiex_sdio_device mwifiex_sdio_sd8801 =3D { @@
> > -471,6 +480,7 @@ static const struct mwifiex_sdio_device
> mwifiex_sdio_sd8801 =3D {
> >       .can_dump_fw =3D false,
> >       .can_auto_tdls =3D false,
> >       .can_ext_scan =3D true,
> > +     .host_mlme =3D false,
> >  };
> >
> >  static struct memory_type_mapping generic_mem_type_map[] =3D { @@
> > -563,6 +573,7 @@ mwifiex_sdio_probe(struct sdio_func *func, const struc=
t
> sdio_device_id *id)
> >               card->fw_dump_enh =3D data->fw_dump_enh;
> >               card->can_auto_tdls =3D data->can_auto_tdls;
> >               card->can_ext_scan =3D data->can_ext_scan;
> > +             card->host_mlme =3D data->host_mlme;
> >               INIT_WORK(&card->work, mwifiex_sdio_work);
> >       }
> >
> > @@ -2493,6 +2504,8 @@ static int mwifiex_register_dev(struct
> mwifiex_adapter *adapter)
> >               adapter->num_mem_types =3D
> ARRAY_SIZE(mem_type_mapping_tbl);
> >       }
> >
> > +     adapter->host_mlme =3D card->host_mlme;
> > +
> >       return 0;
> >  }
> >
> > diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.h
> > b/drivers/net/wireless/marvell/mwifiex/sdio.h
> > index ae94c172310f..d2da8c45a9be 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/sdio.h
> > +++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
> > @@ -258,6 +258,7 @@ struct sdio_mmc_card {
> >       bool fw_dump_enh;
> >       bool can_auto_tdls;
> >       bool can_ext_scan;
> > +     bool host_mlme;
> >
> >       struct mwifiex_sdio_mpa_tx mpa_tx;
> >       struct mwifiex_sdio_mpa_rx mpa_rx; @@ -281,6 +282,7 @@ struct
> > mwifiex_sdio_device {
> >       bool fw_dump_enh;
> >       bool can_auto_tdls;
> >       bool can_ext_scan;
> > +     bool host_mlme;
> >  };
> >
> >  /*
> > diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c
> > b/drivers/net/wireless/marvell/mwifiex/sta_event.c
> > index df9cdd10a494..69426ddd9c3a 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
> > @@ -135,6 +135,9 @@ void mwifiex_reset_connect_state(struct
> > mwifiex_private *priv, u16 reason_code,
> >
> >       priv->media_connected =3D false;
> >
> > +     priv->auth_flag =3D 0;
> > +     priv->auth_alg =3D 0xFFFF;
> > +
> >       priv->scan_block =3D false;
> >       priv->port_open =3D false;
> >
> > @@ -999,10 +1002,17 @@ int mwifiex_process_sta_event(struct
> mwifiex_private *priv)
> >       case EVENT_REMAIN_ON_CHAN_EXPIRED:
> >               mwifiex_dbg(adapter, EVENT,
> >                           "event: Remain on channel expired\n");
> > -             cfg80211_remain_on_channel_expired(&priv->wdev,
> > -
> priv->roc_cfg.cookie,
> > -
> &priv->roc_cfg.chan,
> > -                                                GFP_ATOMIC);
> > +
> > +             if (adapter->host_mlme &&
> > +                 (priv->auth_flag & HOST_MLME_AUTH_PENDING)) {
> > +                     priv->auth_flag =3D 0;
> > +                     priv->auth_alg =3D 0xFFFF;
> > +             } else {
> > +
> cfg80211_remain_on_channel_expired(&priv->wdev,
> > +
> priv->roc_cfg.cookie,
> > +
> &priv->roc_cfg.chan,
> > +
> GFP_ATOMIC);
> > +             }
> >
> >               memset(&priv->roc_cfg, 0x00, sizeof(struct
> > mwifiex_roc_cfg));
> >
> > diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> > b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> > index a2ad2b53f016..046541713318 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> > @@ -136,6 +136,7 @@ int mwifiex_fill_new_bss_desc(struct
> mwifiex_private *priv,
> >       const struct cfg80211_bss_ies *ies;
> >
> >       rcu_read_lock();
> > +     bss_desc->bss =3D bss;
> >       ies =3D rcu_dereference(bss->ies);
> >       beacon_ie =3D kmemdup(ies->data, ies->len, GFP_ATOMIC);
> >       beacon_ie_len =3D ies->len;
> > @@ -339,7 +340,7 @@ int mwifiex_bss_start(struct mwifiex_private *priv,
> struct cfg80211_bss *bss,
> >                       ret =3D mwifiex_associate(priv, bss_desc);
> >               }
> >
> > -             if (bss)
> > +             if (bss && !priv->adapter->host_mlme)
> >                       cfg80211_put_bss(priv->adapter->wiphy, bss);
> >       } else {
> >               /* Adhoc mode */
> > diff --git a/drivers/net/wireless/marvell/mwifiex/sta_tx.c
> > b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
> > index 13c0e67ededf..6aed6a334d15 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/sta_tx.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
> > @@ -36,7 +36,7 @@ void *mwifiex_process_sta_txpd(struct
> mwifiex_private *priv,
> >       struct txpd *local_tx_pd;
> >       struct mwifiex_txinfo *tx_info =3D MWIFIEX_SKB_TXCB(skb);
> >       unsigned int pad;
> > -     u16 pkt_type, pkt_offset;
> > +     u16 pkt_type, pkt_length, pkt_offset;
> >       int hroom =3D adapter->intf_hdr_len;
> >
> >       if (!skb->len) {
> > @@ -58,9 +58,11 @@ void *mwifiex_process_sta_txpd(struct
> mwifiex_private *priv,
> >       memset(local_tx_pd, 0, sizeof(struct txpd));
> >       local_tx_pd->bss_num =3D priv->bss_num;
> >       local_tx_pd->bss_type =3D priv->bss_type;
> > -     local_tx_pd->tx_pkt_length =3D cpu_to_le16((u16)(skb->len -
> > -
> (sizeof(struct txpd) +
> > -                                                     pad)));
> > +
> > +     pkt_length =3D (u16)(skb->len - (sizeof(struct txpd) + pad));
> > +     if (pkt_type =3D=3D PKT_TYPE_MGMT)
> > +             pkt_length -=3D MWIFIEX_MGMT_FRAME_HEADER_SIZE;
> > +     local_tx_pd->tx_pkt_length =3D cpu_to_le16(pkt_length);
> >
> >       local_tx_pd->priority =3D (u8) skb->priority;
> >       local_tx_pd->pkt_delay_2ms =3D
> > diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > index e78a201cd150..eb0b8016d43d 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > @@ -743,6 +743,29 @@ mwifiex_cmd_uap_sys_config(struct
> host_cmd_ds_command *cmd, u16 cmd_action,
> >       return 0;
> >  }
> >
> > +/* This function prepares AP start up command with or without host
> > +MLME  */ static int mwifiex_cmd_uap_bss_start(struct mwifiex_private
> > +*priv,
> > +                                  struct host_cmd_ds_command
> *cmd) {
> > +     struct mwifiex_ie_types_host_mlme *tlv;
> > +
> > +     cmd->command =3D cpu_to_le16(HostCmd_CMD_UAP_BSS_START);
> > +     cmd->size =3D S_DS_GEN;
> > +
> > +     if (priv->adapter->host_mlme) {
> > +             tlv =3D (struct mwifiex_ie_types_host_mlme *)((u8 *)cmd +
> cmd->size);
> > +             tlv->header.type =3D cpu_to_le16(TLV_TYPE_HOST_MLME);
> > +             tlv->header.len =3D cpu_to_le16(sizeof(tlv->host_mlme));
> > +             tlv->host_mlme =3D 1;
> > +             cmd->size +=3D sizeof(struct mwifiex_ie_types_host_mlme);
> > +     }
> > +
> > +     cmd->size =3D cpu_to_le16(cmd->size);
> > +
> > +     return 0;
> > +}
> > +
> >  /* This function prepares AP specific deauth command with mac supplied
> in
> >   * function parameter.
> >   */
> > @@ -777,6 +800,9 @@ int mwifiex_uap_prepare_cmd(struct
> mwifiex_private *priv, u16 cmd_no,
> >                       return -1;
> >               break;
> >       case HostCmd_CMD_UAP_BSS_START:
> > +             if (mwifiex_cmd_uap_bss_start(priv, cmd))
> > +                     return -1;
> > +             break;
> >       case HostCmd_CMD_UAP_BSS_STOP:
> >       case HOST_CMD_APCMD_SYS_RESET:
> >       case HOST_CMD_APCMD_STA_LIST:
> > diff --git a/drivers/net/wireless/marvell/mwifiex/util.c
> > b/drivers/net/wireless/marvell/mwifiex/util.c
> > index 745b1d925b21..bd9bf2888485 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/util.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/util.c
> > @@ -370,6 +370,46 @@ mwifiex_parse_mgmt_packet(struct
> mwifiex_private
> > *priv, u8 *payload, u16 len,
> >
> >       return 0;
> >  }
> > +
> > +/* This function sends deauth packet to the kernel. */ void
> > +mwifiex_host_mlme_disconnect(struct mwifiex_private *priv,
> > +                               u16 reason_code, u8 *sa)
> Not used? Remove the whole function.
>

Yes.
=20
> >  /*
> >   * This function processes the received management packet and send it
> >   * to the kernel.
> > @@ -417,6 +457,39 @@ mwifiex_process_mgmt_packet(struct
> mwifiex_private *priv,
> >       pkt_len -=3D ETH_ALEN;
> >       rx_pd->rx_pkt_length =3D cpu_to_le16(pkt_len);
> >
> > +     if (priv->host_mlme_reg &&
> > +         (GET_BSS_ROLE(priv) !=3D MWIFIEX_BSS_ROLE_UAP) &&
> > +         (ieee80211_is_auth(ieee_hdr->frame_control) ||
> > +          ieee80211_is_deauth(ieee_hdr->frame_control) ||
> > +          ieee80211_is_disassoc(ieee_hdr->frame_control))) {
> > +             if (ieee80211_is_auth(ieee_hdr->frame_control)) {
> > +                     if (priv->auth_flag &
> HOST_MLME_AUTH_PENDING) {
> > +                             if (priv->auth_alg !=3D WLAN_AUTH_SAE)
> {
> > +                                     priv->auth_flag &=3D
> > +
> ~HOST_MLME_AUTH_PENDING;
> > +                                     priv->auth_flag |=3D
> > +
> HOST_MLME_AUTH_DONE;
> > +                             }
> > +                     } else {
> > +                             return 0;
> > +                     }
> > +
> > +                     mwifiex_dbg(priv->adapter, MSG,
> > +                                 "auth: receive authentication from
> %pM\n",
> > +                                 ieee_hdr->addr3);
> > +             } else {
> > +                     if (!priv->wdev.connected)
> > +                             return 0;
> > +
> > +                     if
> (ieee80211_is_deauth(ieee_hdr->frame_control)) {
> > +                             priv->auth_flag =3D 0;
> > +                             priv->auth_alg =3D 0xFFFF;
> > +                     }
> > +             }
> > +
> > +             cfg80211_rx_mlme_mgmt(priv->netdev, skb->data,
> pkt_len);
> > +     }
> > +
> >       cfg80211_rx_mgmt(&priv->wdev, priv->roc_cfg.chan.center_freq,
> >                        CAL_RSSI(rx_pd->snr, rx_pd->nf), skb->data,
> pkt_len,
> >                        0);
> > --
> > 2.25.1
> >
>=20

