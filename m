Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724DD77AF81
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Aug 2023 04:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjHNCWI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Aug 2023 22:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjHNCVz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Aug 2023 22:21:55 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF23A8
        for <linux-wireless@vger.kernel.org>; Sun, 13 Aug 2023 19:21:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDdVnC5/S+a/7Cy5NCWhT6JQ/MlSZGcwGhdrMkudPbV4nHqj3lbtjGYepFZi4hmH0zTUARCM5GAWPOkVIl3A5BZq772ZmH/cDxnAF7CTrs5u/yz9xHv3pQgFpdwNjMNJpNxIMe3euXLMJjbcLJ1UYuL9+0PrBYJHTzFKDn0a1BF4JVEJWN8Z733NPt5AM3vWy9E7s9McT4QTySWaiuVTTdSN5kPVcN6FYCifzkI4KIpPKgMOB8cUMjiksqqCJCNCqNf2aBfzBgR63VA8/eB4jgUgCDhQum6pJ0SP4bUArxUaZsejimPd2JciidV5krE7bI+aAHsKmV5tSkiMwhv5Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ij+5OJSghLePD9yELWLzSafmR3xBFiMjb/SJY82Hs28=;
 b=UEeXtio/lTedL4sEDY9hvAknULAdJIPYyTx9QJm0HDzfKsVJTSUBaPgv6aRqJwGNWUsQs0Sl55TPAk4BDv/gIcwNJeHQSO+wkFVIgEZeqsjRZO4/BK1yZUBcjLVuyYmaFMxdB3VpgJeS6NcwX+w0DzmXbVDecFOM0nUyVp/9BDzdwu8f/vYRoHjAwR5vTp/vOddw5wb1NKqQ0gnL7M83g03PjifY0dHexI3c/ZNVGnwudvnQawlo9AAOciMfUt0DpsD4d4lz9ht1ow3m8Vu2jSPSS+vlHSPDYODZt2ULYFaLzIbJFQbmXDMHqnHWN8qTJjitnNvkzFvjniQMEl1Gcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ij+5OJSghLePD9yELWLzSafmR3xBFiMjb/SJY82Hs28=;
 b=MaWpmt3KOCOeBjwAdKPjdz76cuXBc8c/on/7LANVQGzfk5K70KshSyxgTUrbzzw+rlUZrZgDBvTbO+zsYyaczqRPi0rq29q0ZkFunBor01GeDQe7sC5L238pQo+TjDEAVSERv1QELEVsIVeM/VDOoI0j8j1g5N9w+QoR8jyEH6I=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DBAPR04MB7367.eurprd04.prod.outlook.com (2603:10a6:10:1aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 02:21:51 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 02:21:51 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v3] wifi: mwifiex: added code to support host
 mlme.
Thread-Topic: [EXT] Re: [PATCH v3] wifi: mwifiex: added code to support host
 mlme.
Thread-Index: AdnLM9yJ3sHx+trUShG5sDbPtsfBhgAN8B0AAAMu0UAAB4TpAAAYtp9AAAwrgIAAivjV8A==
Date:   Mon, 14 Aug 2023 02:21:51 +0000
Message-ID: <PA4PR04MB9638F951BC7895315274BC79D117A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <DU0PR04MB963607ADBFC49C7AB713092DD113A@DU0PR04MB9636.eurprd04.prod.outlook.com>
 <ZNSrYEJ9m0jO/WU9@francesco-nb.int.toradex.com>
 <PA4PR04MB9638C1DB606524BD57AB59CED113A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZNTzMrjfauSJN1ym@francesco-nb.int.toradex.com>
 <PA4PR04MB9638C81BE986779C9512E262D110A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZNXqt62xMQFQh16o@francesco-nb.int.toradex.com>
In-Reply-To: <ZNXqt62xMQFQh16o@francesco-nb.int.toradex.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DBAPR04MB7367:EE_
x-ms-office365-filtering-correlation-id: 224822b4-187e-419c-aa8f-08db9c6d3848
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wwb/H/5CES1m93c8LEvhQ9E3qFdyDyKazHX8Tt4lQ6OpUJaghblx0zr8bylM/KsBnkYyR6Qv/DBKdswwugeRolPJ26hP4oraS6zVvFjxVt7Lj3LBG+0T/MOcCLukwUncZ0w6U1Xzx1lhRXjSAgTMW349QE/gDe2TsLlWeGwDYeABH1svvZgPQLUADzEGcXBKow37Xj73MbSd5xEzq1v1zQThMwMCNUCasQPjVKGVNqg8gXCUIvFM0KEMHeIChb+/p1DEDBTYM6j7YZ/DyPVH2Mm8kaCKl81zk2jccOUkWb5p9pmu8V3shxvjWDGmqRjKDxYAWTkNoBsd3uUBxFPsToNl3ml1oXskcvUBQvMn/9ip/UgAiIH2ZuX8BoZL1cLr/pxeRh6pb+e872kTrwwXd7uHmIKIitlajAgRgNoBNYNURrQWOTcj3lDha91dckco+JrocL5oTb3CkVYOXIQhr8hCI/YGrRiWB/Nvp5Wsb2m/qVYh2f6HNDMBSuZlJUm4peuzzFR6U3gzYH15W8Y7OA935NUV71RRDPXO2BtEsI4iOjooGuPNcdR/fat7dXBVi55OVZHy3HE2mIKCvKFeAkEIoNa91+7eiWXX/1zEciXxIHA3wotP5JfagJU3fTVH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(346002)(376002)(136003)(396003)(366004)(186006)(1800799006)(451199021)(7696005)(9686003)(33656002)(71200400001)(86362001)(38070700005)(38100700002)(83380400001)(122000001)(26005)(6506007)(2906002)(55016003)(54906003)(478600001)(53546011)(64756008)(8676002)(66556008)(66476007)(8936002)(52536014)(5660300002)(41300700001)(66446008)(66946007)(316002)(4326008)(6916009)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AAJYzYbwblyuP7PUhiqzQ/gcJ5UiYO4h42EB+KqQZcIpjMKSXr76oOAjNNTL?=
 =?us-ascii?Q?lEU85kP98KgJOcs6EoNrWHkF9DSUcXfTgBc1UaMYeW0ttj9Qv8FUI7mSyluj?=
 =?us-ascii?Q?p1UMjTQ2QoVLaKaducKJWfILX9YeLWcfYypD64XRAaKyiSyZxSeVgXe3R3vN?=
 =?us-ascii?Q?JttLy2LQ+jhv6XeMmXoo0qwG4kAvlGk+5pu+ZSQu+7/wzKUxxPeZRVm19qrD?=
 =?us-ascii?Q?y41XLVsME/EbhYybmK4AgaDmiWnHEzaW1a4TZFHh3OMPxL/zCgzTWhu2s/VR?=
 =?us-ascii?Q?J2K7Qznu4HJVuPgYHFvO+HiKGolgZykIUnO8k6243jzsXEIDWPJNemXTrk8B?=
 =?us-ascii?Q?LT0Ity94j7tJ9PAE71KitOVLKVv0QaEWb2Qb1V5zar07YhMJWwkP2mQU+Hrf?=
 =?us-ascii?Q?D3BI0bldDxsAfRvjGAsGIXWyVghNcAAW9F/9svbnfKji3YOG8mNKizgf91cY?=
 =?us-ascii?Q?MjOZJQSf7de2u578LUICVMTflwLJeQK7kbF95TLgdnz1Z2681iRUSgQ/c1l6?=
 =?us-ascii?Q?YjAqiASKl3LkAxJDKZB5nshY/1AlUN/qMmXGVTjpEwdLMBdKYjA5UstQbPPy?=
 =?us-ascii?Q?y+dUbXbc+R6ieqbXFabRfMjBbXjbbfGSOGWNu2VCyrE0R8n1IHlZbJFoBH14?=
 =?us-ascii?Q?OCVqmHXojhIESy8aEmKz92JuENz+JdcxVAsh4G/hkx4Q/dzrYlDtEacfmN9m?=
 =?us-ascii?Q?l6oNkGGLXLjhSen9l0I7Prx2eGGgD34JhSrfBm14bkjcNeWSiomM25gvm7Zf?=
 =?us-ascii?Q?y3k49QumZY/er2lzHtBeYmU7WsJ3uK/Yp5wh8HIXY32oIICH0Vw8MU3X+HiC?=
 =?us-ascii?Q?y9Ko4DhDdnBDTST1+5uCnJseQ3+QKM/dS/uhAgrBXvoSlyBXoAdbR0iyJ9to?=
 =?us-ascii?Q?dROruVqxBxXwtpqLjymJzvNMUJgriqyCJ3pcRr/8iCiUN6qIDgG2xyZCikUJ?=
 =?us-ascii?Q?p1WgIlTSbbwpMvwC49OuuBIAwUoDZo73WMBPjIb+sSjXWHK/7pxDD1qMXi9H?=
 =?us-ascii?Q?MydPYvfxDDPJlVp6JW8STHD2XIvoMPa+mvxwgaacjv0wQCcVsVID9C84DAGB?=
 =?us-ascii?Q?vzHYphDvgtUHn8TzqfJtbH8dwLZQ9NHKvEsTSyGW5Ab5wLgeirFsrXsZ6iSQ?=
 =?us-ascii?Q?oYUj832qGDx26oIKcJsJlhhTHsVfQMTpUq59357n+cH/Tl6nVJFbazK3C6C+?=
 =?us-ascii?Q?zXE4/YIv5KUMHTPJIEIpaXKEM2BU2tnEpLRxr86UbzTeOWYc3hVol24LpJTS?=
 =?us-ascii?Q?+XfVNB/auewymTcBUIKuS8hvr+06Au3ipvj13OAHWiX/5bwSQr9rkEOWYZz9?=
 =?us-ascii?Q?uGvLaLjB5/cB3dLbzTU9l/pFc+YXzz1UuU6bZw85KLesgVxn7yicxPqyk61N?=
 =?us-ascii?Q?qJYC8AOCbe/OiTeFheBpeb8VzwCdyMVUzziyHPDCrf/dZs17WbhuGcQoSD91?=
 =?us-ascii?Q?lT7RytUmuGOF9z7UyfNKA+D7Jh+ygtbKVCeEXP5K/I5CkC68tL7p7yE1v3g5?=
 =?us-ascii?Q?/EiR+H0AptKwzdgqwP/8Ig/o5MbrLyRtnk3h4KTO/7KSSTdLzq+7bh4jB2Mq?=
 =?us-ascii?Q?CNnfLDe5ecEpgx95jPBfn+xymKBncB025/vY+24w?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224822b4-187e-419c-aa8f-08db9c6d3848
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 02:21:51.2464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ctvQD4Xg09tN+mBfiwjxfl7dFoj+ZnwXmOxfN89xSkqaPBBcxsvSNHo94iIP235K3BvDHYGZ6IIU0mF/T9U+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7367
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Friday, August 11, 2023 4:01 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: Francesco Dolcini <francesco@dolcini.it>; linux-wireless@vger.kernel.=
org;
> Sharvari Harisangam <sharvari.harisangam@nxp.com>; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>
> Subject: Re: [EXT] Re: [PATCH v3] wifi: mwifiex: added code to support ho=
st
> mlme.
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Fri, Aug 11, 2023 at 02:13:43AM +0000, David Lin wrote:
> > > From: Francesco Dolcini <francesco@dolcini.it>
> > > Sent: Thursday, August 10, 2023 10:25 PM
> > > To: David Lin <yu-hao.lin@nxp.com>
> > > Cc: Francesco Dolcini <francesco@dolcini.it>;
> > > linux-wireless@vger.kernel.org; Sharvari Harisangam
> > > <sharvari.harisangam@nxp.com>; Pete Hsieh
> > > <tsung-hsien.hsieh@nxp.com>
> > > Subject: Re: [EXT] Re: [PATCH v3] wifi: mwifiex: added code to
> > > support host mlme.
> > >
> > > Caution: This is an external email. Please take care when clicking
> > > links or opening attachments. When in doubt, report the message
> > > using the 'Report this email' button
> > >
> > >
> > > On Thu, Aug 10, 2023 at 10:51:36AM +0000, David Lin wrote:
> > > > > From: Francesco Dolcini <francesco@dolcini.it> On Thu, Aug 10,
> > > > > 2023 at 02:39:21AM +0000, David Lin wrote:
> > > > > > 3. Firmware version 2 is needed for this feature.
> > > > > That would mean that we could just enable it for other Wi-Fi
> > > > > chip variant that has firmware version 2, after testing it?
> > > > Yes. But I only tested with IW416.
> > >
> > > Can/should we probe the firmware version at runtime, instead of
> > > hard-coding this?
> >
> > Firmware version is reported by firmware after firmware is downloaded.
> What's the problem with that? You cannot really do anything till the
> firmware is loaded?
>=20
> If I understand correctly the possibility to use this feature requires it=
s
> counterpart to be available on the device firmware, this should be the
> criteria to use to decide if this functionality should be enabled or not.
> Hard-coding this depending on the actual device does not look correct to
> me.
>=20

If firmware is old and supports firmware v1, you should not enable host mlm=
e for the firmware. Firmware version is detected at runtime when firmware i=
s loaded.

> Francesco

