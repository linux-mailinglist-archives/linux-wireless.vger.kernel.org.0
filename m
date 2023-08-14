Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3D777B6ED
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Aug 2023 12:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjHNKkJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Aug 2023 06:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbjHNKj7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Aug 2023 06:39:59 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe16::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED311BD0
        for <linux-wireless@vger.kernel.org>; Mon, 14 Aug 2023 03:39:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFqj9WV7DjKUbOJJEW+XwP6ZZzxP946euMyNWxA4cGhh091rjInL6etFqXazZn74/ThHe+0x3+Wuga5Uo4XWv8nTyVuds6xMlmpvVoVa0ouBIo5GCa0/+vClqcvV6/kJmBPgCk2Y6PbJOojiL3NWgKtl4qqfdwDnQ8fStomJo8ec4uvy+Ws7HzUaft383LZYWmrNB8PDYSCy9L32Zdi5GuhWynxm4GswUXb7uY1UX9aifdprtIxlghqe3JBOnpTCCW/VfPuZgKUGvZ5L3tcmfuqggDthGwxPMTINGpVjidIwv5W4eWV5qrUEgQ+M7tx+z6tFZR5JOS35uWAIhi6KMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u87CCQvbHMGSsiF5BgUvN7HXd2QcmNhbzZYRJYtdwz4=;
 b=Lv7W+RXF3WchxO6+vw/k1lITp2hdDl18YqBXWoeKo+x3y3cjzFlgbhN3lefq84rkf4mKM3Nbc6JYTn6BJomzrRN4c+gcfLTNFfMKQvwmv0BNlPcHbyNqZMF6owY3uQkRTKzTqrtlG7gFHj/JhCKrybWWN9pybYgrxfKA2Zy5blzjDpcgK95YMaRlbDUAqDQi7BB6kWjUtzOvl7Wxwn2FeVWxPzrv6Cls7uqciCoAsMX0zGJOQZVuqA0akO3SuguM1ZW/9iKzjlejZlbxpac9g83ya83v43KDCmCOWnMonSTAlRybnUhjE+BvQtNRZ9nD5LEblXI4vdMeUmQeuG9+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u87CCQvbHMGSsiF5BgUvN7HXd2QcmNhbzZYRJYtdwz4=;
 b=A0PJaPkZgxV9VfQfid1USykMBSNeqIPGbsE9avk3emUbenoXrzl1dctgRzF0ZT6g+PzuvYW3V0igW4NtByBqxJrW6I8lRiZJUe7L4uUMokgCX+gCf6DPxy7VAGrentRGP+qfOZ8mgN0yxj3Y/atNLaGQjbQkS/HLZTWRu6qNWCg=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9139.eurprd04.prod.outlook.com (2603:10a6:102:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 10:39:02 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 10:39:02 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v3] wifi: mwifiex: added code to support host
 mlme.
Thread-Topic: [EXT] Re: [PATCH v3] wifi: mwifiex: added code to support host
 mlme.
Thread-Index: AdnLM9yJ3sHx+trUShG5sDbPtsfBhgAN8B0AAAMu0UAAB4TpAAAYtp9AAAwrgIAAivjV8AARBT0AAABe7hA=
Date:   Mon, 14 Aug 2023 10:39:02 +0000
Message-ID: <PA4PR04MB9638F8EFE1B091144F3108D0D117A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <DU0PR04MB963607ADBFC49C7AB713092DD113A@DU0PR04MB9636.eurprd04.prod.outlook.com>
 <ZNSrYEJ9m0jO/WU9@francesco-nb.int.toradex.com>
 <PA4PR04MB9638C1DB606524BD57AB59CED113A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZNTzMrjfauSJN1ym@francesco-nb.int.toradex.com>
 <PA4PR04MB9638C81BE986779C9512E262D110A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZNXqt62xMQFQh16o@francesco-nb.int.toradex.com>
 <PA4PR04MB9638F951BC7895315274BC79D117A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZNoBkF12PCZARO76@livingston.pivistrello.it>
In-Reply-To: <ZNoBkF12PCZARO76@livingston.pivistrello.it>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PAXPR04MB9139:EE_
x-ms-office365-filtering-correlation-id: 1bc77df1-851c-4bb0-c00e-08db9cb2ad3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yFfCygyr3DnUJdNEcdZIPbu3qtAN0dnECwbAjyl1RTFlj5Rhw3NwyjPEi3JvpAPt2tYY1B1nGo5dKOTy+GU/Hc5zv+4NVdQ//t0cTUQ+iekhWlYXs30f41ij/u1uAvpX8axgZUngtmrD8fnzPM9fAiEUMZ9Eiwb1h43vfBbG6t1ctPwc6DBCXmVotI0dr6+q26JPI88Cl3LiNS6xxZR8Mzqi5OtxMWpsyR0DWC4TlN1AL4t4u00VrctjilDF2YeKmcfsLAvoODV/x/E4CuUyVxubhqr5L4b7olf5yTc2WsyMHj2jyV6ShrXIpKWSYgbvzg64U1b+pOwmfiVogzqML8e6LUmEIDOALxAhjVyQKTM9ahfqMcUklpxCCGUDicQrBgol2VmUGQAQTEhd+wPfsblV2Ny6boA2Eo03EqsOE7+Q1aWw3uGHvN8ooxaaeaXtOK4cVl3jlEmjRy5r65Yfpby5ApHLrQhmmzgFkGGfbkbf3s6Y8o39bY4f1ukK2Xie9JgC/Gm07aMJbZXdeCKDMxLkHzDAKY730mVqwG/3uyaIP5/CCybwqxbioD0JLgHNSnmqge6mVjNBs7htT23d1OIqzv9v3AUgJoJ4+7DGO/T+221lkSt86/B9u1LCnWF1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(136003)(39860400002)(346002)(186006)(1800799006)(451199021)(33656002)(83380400001)(86362001)(55016003)(38100700002)(41300700001)(478600001)(38070700005)(66946007)(54906003)(66476007)(66446008)(64756008)(66556008)(76116006)(6916009)(122000001)(9686003)(316002)(8676002)(52536014)(5660300002)(4326008)(8936002)(26005)(6506007)(7696005)(2906002)(53546011)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pBtp+xf93r4IVKFvv+zn6vAm196GCZ505K+w8rm24hLHsLf/0pD4uP2w/I1t?=
 =?us-ascii?Q?m8FtaUq/nZoN8cRpoQa1V1ooPj7swIV7tejEThhGASCBDRJ6YpWkXNluh/03?=
 =?us-ascii?Q?aZeaadvOf14sTqjbJCl2sYybF3TdNsEiVCcB21K4ChIA9ESZgfsyLPvXtAAZ?=
 =?us-ascii?Q?/GQvsLQBWvzTJqN62bCCu+mthrs8FHvCjCs14g71kie1dW2Q3Sl5w7wkOQGd?=
 =?us-ascii?Q?QFheAo9drwMwTKFERQpuV4+dacREEuBe/gEwMWb3FoOMDglt380YmWsJkddv?=
 =?us-ascii?Q?OR531S9LgW7EVJoDEojjOW7S9z8a9cda5xdJW4uMfsUxlkTGxo5b+3QGsb9p?=
 =?us-ascii?Q?gQX+mT90STtNbKdCs9BRB7Evc6IKcwRz6XlHabwBMQohj6MgGRCWKLV962O1?=
 =?us-ascii?Q?ij+l1ntNwXB+Wmv8HLKtza9pBAt+c69NJU34p5dwymoC8eG1YF6WYemKHhY8?=
 =?us-ascii?Q?j0R47jgv7xIm3YgSue1omLGybXUfPrvTI96q+yp1srGLtRCwDqNu4qac4e4r?=
 =?us-ascii?Q?oIampjv1cKvL7Y77pxSB3TA/hc89ngogbVJwDb0BBTS1LrkS4sKkZtAISV0/?=
 =?us-ascii?Q?bVatcjfDwACpZXVtgzc7gwr21J9+4PMDfLmFHOPbTyhEW+X+9FKxTzk/6Os5?=
 =?us-ascii?Q?rnvaQOtSnNS6jTuLE0sgD3UYEJoU8FYgRwrN6SfB3jb7crkrICC8nS/+TQpK?=
 =?us-ascii?Q?ATLCwB24+vPHUPK+Je8cK4V8hb2RdXw3UsmBQZ0gOLNXFbkwkjGYr1SjoePb?=
 =?us-ascii?Q?AvLeX40SJHJlCHAv/c0N7EibiMsJOvq7v65FjUKkWxALpKPetykp3XpBFUD0?=
 =?us-ascii?Q?QFGzSB+LZqFUjN45CPp2gbBDW8cSBhBvFOk8iD0GQtWHj07JS1DstYubBy+y?=
 =?us-ascii?Q?QiFOacrVOoi3nNkWiNdXrzamMa81jMsHcoj4Iuw6tH6ceWZw3a9QxxylGvs4?=
 =?us-ascii?Q?C4ZzWii0IECA08+jXUWHaYZVqT29JK5BXKEEIWNshOzh0G6LeDwQlaZabN5t?=
 =?us-ascii?Q?BJOmcYAaFsRKl3hrrQZo9D6m3O3S9WYL5lNKI7+/J+Dj/uV5kX5M7xbbDtTe?=
 =?us-ascii?Q?/qZ7Tn6Vyk3kw215TU178ghUHftGXLi3YLWnvrYigrZWn6mHq6RZtoYINrEy?=
 =?us-ascii?Q?avy5P68AluP9G0oUN3B84b68k5VFvt3ryX8/p5fFRqXiW/JZ16N1P7STzcfa?=
 =?us-ascii?Q?61TOAmD1ll643u5Y6kT4oMR9xThiNxEANzgYNzW1ftprdMnh0+ip8JR0pwW2?=
 =?us-ascii?Q?phq9Hdv06lDuetxzggOFqqZqTk+IlgVkIxZxcWzBJcKodm1U3i4pmv/aJHAs?=
 =?us-ascii?Q?2ypGpdxCvi6q6ul0DwkDcrA0JDkiRA/wDsjh/JnKbP0BApOrfCDLj3hMsWeJ?=
 =?us-ascii?Q?E2l6G5PZ+k0XuU9h9mmPbRSpNKw/BMBwlGal9yalEJZQMNWfbKdqGVT9n1+m?=
 =?us-ascii?Q?FkUkS4aPkvaHYy4sVW1A3V0KZ2V7UnSLigfAJO+UkVIuD3ds1IqiofSeqgAq?=
 =?us-ascii?Q?F2q2Z8VmzrTVRNz8ILxTeInJEDPHGCsQ/KOF/6gv/ussfGNwuLvg8GYjDcX7?=
 =?us-ascii?Q?KJfrGqcdJSX1UWi9dc5j5Kkh1NaZUfhiSwpzRuQR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc77df1-851c-4bb0-c00e-08db9cb2ad3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 10:39:02.7375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ms3ztL8d7B8lgI9h0/aIrinspOQcBlSzE7CiYpJEXG2ygZvUJp5OOfo/KnLcIoy/cKt0GhcI7rfyae99H+TZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9139
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Monday, August 14, 2023 6:27 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: Francesco Dolcini <francesco@dolcini.it>; linux-wireless@vger.kernel.=
org;
> Sharvari Harisangam <sharvari.harisangam@nxp.com>; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH v3] wifi: mwifiex: added code to support host
> mlme.
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Mon, Aug 14, 2023 at 02:21:51AM +0000, David Lin wrote:
> > > From: Francesco Dolcini <francesco@dolcini.it>
> > > Sent: Friday, August 11, 2023 4:01 PM
> > > To: David Lin <yu-hao.lin@nxp.com>
> > > Cc: Francesco Dolcini <francesco@dolcini.it>;
> > > linux-wireless@vger.kernel.org; Sharvari Harisangam
> > > <sharvari.harisangam@nxp.com>; Pete Hsieh
> > > <tsung-hsien.hsieh@nxp.com>
> > > Subject: Re: [EXT] Re: [PATCH v3] wifi: mwifiex: added code to
> > > support host mlme.
> > > On Fri, Aug 11, 2023 at 02:13:43AM +0000, David Lin wrote:
> > > > > From: Francesco Dolcini <francesco@dolcini.it>
> > > > > Sent: Thursday, August 10, 2023 10:25 PM
> > > > > To: David Lin <yu-hao.lin@nxp.com>
> > > > > Cc: Francesco Dolcini <francesco@dolcini.it>;
> > > > > linux-wireless@vger.kernel.org; Sharvari Harisangam
> > > > > <sharvari.harisangam@nxp.com>; Pete Hsieh
> > > > > <tsung-hsien.hsieh@nxp.com>
> > > > > Subject: Re: [EXT] Re: [PATCH v3] wifi: mwifiex: added code to
> > > > > support host mlme.
> > > > >
> > > > > Caution: This is an external email. Please take care when
> > > > > clicking links or opening attachments. When in doubt, report the
> > > > > message using the 'Report this email' button
> > > > >
> > > > >
> > > > > On Thu, Aug 10, 2023 at 10:51:36AM +0000, David Lin wrote:
> > > > > > > From: Francesco Dolcini <francesco@dolcini.it> On Thu, Aug
> > > > > > > 10,
> > > > > > > 2023 at 02:39:21AM +0000, David Lin wrote:
> > > > > > > > 3. Firmware version 2 is needed for this feature.
> > > > > > > That would mean that we could just enable it for other Wi-Fi
> > > > > > > chip variant that has firmware version 2, after testing it?
> > > > > > Yes. But I only tested with IW416.
> > > > >
> > > > > Can/should we probe the firmware version at runtime, instead of
> > > > > hard-coding this?
> > > >
> > > > Firmware version is reported by firmware after firmware is
> downloaded.
> > > What's the problem with that? You cannot really do anything till the
> > > firmware is loaded?
> > >
> > > If I understand correctly the possibility to use this feature
> > > requires its counterpart to be available on the device firmware,
> > > this should be the criteria to use to decide if this functionality sh=
ould be
> enabled or not.
> > > Hard-coding this depending on the actual device does not look
> > > correct to me.
> > >
> >
> > If firmware is old and supports firmware v1, you should not enable
> > host mlme for the firmware. Firmware version is detected at runtime
> > when firmware is loaded.
>=20
> What I am trying to say is that in mwifiex we should just decide to enabl=
e or
> not host mlme at runtime after we know if the firmware support this
> functionality.
>=20

O.K. I can add the checking in PATCH v4. Thanks for your suggestion.

> Francesco

