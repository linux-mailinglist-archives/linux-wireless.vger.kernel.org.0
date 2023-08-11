Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D1677853F
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Aug 2023 04:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjHKCNs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 22:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjHKCNr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 22:13:47 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D072D55
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 19:13:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiOLAdV2B0qOYvZ0QxpBoB4qKYw7N9k2Lt8FHbkZNKEyhsWbYe5w+yIzLnv75VEMuCcBrgh+aAj7fe8HF/yt6mendZTj8qrgnusypokd8xWAAqfhnpKoopnzdUhHOLocYVfIx4+ktWxzRc/zB7RxHLWSmhddxLYRlsra16xDlrdt7exU3lG+lUpMdSNzXgniuHNP7F8SEzYmYWOZimpchDwjfUQMnd7y+CVrWIbYHQWdNiu9NlFhtbZlHz1gwkvnja4Yz3SdGmJzBMdQ88BTWFaRvjq3/TCCqRheVwo/DTBpteZpAzZ3iwpgS20Yip/SpF3w+Cr7FP5UiKS5Q6UnaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URHWrxpuqYZLBGG9b+U+caHAfGxcayFOkimh5lcwoBo=;
 b=G4IJMfYV3+24nNsRpZw0R9b6Tpqx4CDAB/FjJT3B76Ome0LuYQ1wp+CN14AA/S5bTqhWWAwfLXKWeVZ5QNwc8kXbRut4K6B6gy5/AXpfB/HWP92luIOM9b6J3a4dtolXpHp9jDYVh7yUZYYeXA9wne3eO1L+jYOHLPvGletB1NQl6B/Oel/fEvmVIJLnMbetWUBqgy3kDr2559xvlRp3hlFdhAEY9dF0bSBP2asUukBz3gM74wONnKNQ1NvQjBEFDTDlPKvx8mOYRnn5SZK2mF3PWVKvMqz7DKNB0udsICzzsER+kt8H7+Vux8bXwF0J/agzzAfWCl8b5iQXWWsNMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URHWrxpuqYZLBGG9b+U+caHAfGxcayFOkimh5lcwoBo=;
 b=ISb/49aXHZnSLFvtZivhgK4tp7Pf9Hu73OzXu5mzhfX+RCPkfzbbEN/Z7JewGKaDX7xFdxRUJLOQWwLp+Auf2N0rDgjHgtneTww14PFgNB7BwLhbJ9hXSTdz5Hh7zrC91wW/5xEDOklBXaeSWOjdJtG8ECFsHwKUA1XI81omE6Y=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS1PR04MB9630.eurprd04.prod.outlook.com (2603:10a6:20b:475::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 02:13:43 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 02:13:43 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v3] wifi: mwifiex: added code to support host
 mlme.
Thread-Topic: [EXT] Re: [PATCH v3] wifi: mwifiex: added code to support host
 mlme.
Thread-Index: AdnLM9yJ3sHx+trUShG5sDbPtsfBhgAN8B0AAAMu0UAAB4TpAAAYtp9A
Date:   Fri, 11 Aug 2023 02:13:43 +0000
Message-ID: <PA4PR04MB9638C81BE986779C9512E262D110A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <DU0PR04MB963607ADBFC49C7AB713092DD113A@DU0PR04MB9636.eurprd04.prod.outlook.com>
 <ZNSrYEJ9m0jO/WU9@francesco-nb.int.toradex.com>
 <PA4PR04MB9638C1DB606524BD57AB59CED113A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZNTzMrjfauSJN1ym@francesco-nb.int.toradex.com>
In-Reply-To: <ZNTzMrjfauSJN1ym@francesco-nb.int.toradex.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AS1PR04MB9630:EE_
x-ms-office365-filtering-correlation-id: 7ae3b45a-8064-4a64-ddd3-08db9a109646
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hB4ud6N9T2uF/SMS6lmf8eNuv6a84tNNmcM65YPYd+o6MNw3w2aQIiuvoKVSUEFrO2tuFIe7RtablqoBlvEs3JM0F10jDcuq3OtTZimv9rkUJ7XVbYMHk7B375TnuFKjlqXfAluQydquWdrcZhuxUy1GLGdSlSozB3ATCK4XQqI/cPnkbmofOsrnh4Qz7JnMs0xlzLpF+LrBg/uWnPchhkgdI7ZPl9KF/sh55mHy+aFhVgvsH6wRIcYVr+riTtoNEjmPhdVApHCMde+S0kupfQcgqo8MblIiWfOJopBhdHMPW8JMZU5qiRytirUWN7QfTrdT2dcfPd1pgg5V+9dl89nqFd209bUCf0qrK71oPoEtCQwvpqcBBB0yyYdovm5USYCdS2PdIEUqbRNvr5rOC6XQ2lOHnt3p649EyKJeOjPLJslF+UofibfAhH49FvMe1jxgp3VAqgew+jGTfv/dbNDpVt04EA6ckV5w/IoYr7nCR9mMt6OD9sE4DkMG4/dHbsxJbQ214Sq3iNkMH6V+Abkz/TnyLMXoCV7hByQOnqqKxA3GkATTkHaSyg8e4+J/lQIfPeu3INTVb4AK/mB5kZcRrgK3UhgT7ua8BDnnmde9lkvTb++JFNyPEmnZ/zIa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(186006)(451199021)(1800799006)(5660300002)(52536014)(478600001)(66476007)(66556008)(64756008)(66446008)(6916009)(76116006)(71200400001)(66946007)(55016003)(4326008)(9686003)(26005)(8936002)(54906003)(6506007)(316002)(8676002)(41300700001)(7696005)(53546011)(83380400001)(2906002)(38070700005)(122000001)(38100700002)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JAn1tfg3eKhkozRxWPCmTbNHRz2ibB2/1s1f3iR+tpxEF1uLDwlNgX5dRTz1?=
 =?us-ascii?Q?AXPMAKFnO1eAECbLv+8H+DEIDzr/c71kYPP2cy2FH5dFBkEDdR6iG9vuRowC?=
 =?us-ascii?Q?+XzzyKagjGzzDLJ7i6YFLsWcgli7ij2muYosJXhxnbKTHqqCYaVipYiSCBDa?=
 =?us-ascii?Q?pUSKTak95VxBkRw1wj/rwWfUzcRgdnVAoeXylbhrWTZqSnHTt2wWmYE5EcCz?=
 =?us-ascii?Q?hs2V7P9FQUzllwO+VxPqhwp6PRe8IQdMej3yRjg1wzhig3EwWNB+OeRJ/VzP?=
 =?us-ascii?Q?6CjvN5E3ROX1a0hyVYxS5fVbJmYg0gQID8ihFnfk7ZI+1FPfoyIawVInJTrP?=
 =?us-ascii?Q?5FhDSQ4jSiKRsuFXUHqSODUp+xZ9D0A1Hdbs4AHSCQ+a7Mjpaed8tMcWW0+H?=
 =?us-ascii?Q?GeXT0ZFriYSeJD1OeNsIGl9KsDvsZwwTW1wHmFe3cH5ExNHlpYKAqIGZRveT?=
 =?us-ascii?Q?M6KAunxFDcjFNj5LnqaUBb+LesWGYEXGycGOukV+hb3a23JQyVgJUHKmxqu5?=
 =?us-ascii?Q?0EVjXvkDGUwBPNWY2gxJYdDHQ5wx9z6ykIUlyXK8QjUmnC19/ZPVhwT3imTT?=
 =?us-ascii?Q?/my4TcrIMnQTO8Qf0AtvZcxYlTOZ51iEP+bLxQVxegBELgbp5RpXyHxLTqu6?=
 =?us-ascii?Q?LueI5X3YtAxHxxzGigIVzGzv2XmvLVJNeL5mLDER76vkNeRmubTX3ldmPJob?=
 =?us-ascii?Q?ASojRZHqGiLE8JeLg2m83cne5zdmfhYEGpBVW0rs+vnXYqUnlkRwV0ivmdTo?=
 =?us-ascii?Q?0R/UM2weZIXh9338a8umKw9j1uTlhcX3i4iy8uqDA9ktIZdAV9uGLYCRRxWp?=
 =?us-ascii?Q?XkMyWWRmBPpj2aZcM9gWMHSDAiuTmuLen1i3cTwL+kpTKV7sGCyRblAp6Ils?=
 =?us-ascii?Q?jRmb4SNQQ9jobILEIT59oViMoB5VxuyP8AcmBlOzXoDYl9gKta+EBrsPSYju?=
 =?us-ascii?Q?vK9cgcHouiaTzgVm8amXfR1YTzTY3tD010UKFPmDYmUm/sDsagaKu6QWYYGQ?=
 =?us-ascii?Q?UAtA6Y3YnsypY/whrAAD8AF9Z2QCEadn1fE/fnPuo6czM2BrnxZG5RNsQ8G1?=
 =?us-ascii?Q?jMfIV4cil6LCiPuMy+a3NdLWE+pmPdNc7J1yRuPCgzskLoR9xbd63GALNKSz?=
 =?us-ascii?Q?4aiXaSKtE2HsSHey2xqqjhUhU8SZSz4Kr6yflJzKrDSutdEjVXU5efM3hrW+?=
 =?us-ascii?Q?b/TaTYBRNgnkFfoZOx1AbP6UoGhzqCcrAdtFVZrN2VcNPHte8A2h4IM747Bl?=
 =?us-ascii?Q?mwhvDT+hcBu85ItxMGks1NP8zA60g6RsY8cagQo9NuxrOrZ4BhXyWlFD/M9N?=
 =?us-ascii?Q?Ljs93nCcZlp2QfajitEUiHaRQB19ezdU2akmeu6M/f6mDah4TyXZtkGNc/x+?=
 =?us-ascii?Q?sIAkThq2GhP66R1JMOk6pcTS/idhNXPkkxBB1kmPznQ3UfBWUigoVyuF9oX1?=
 =?us-ascii?Q?G7z16rR489pqZ2jYcV0Ax5cGds97A4QC+CvMMfW8iRulnHiyRs8/M0I5jbLw?=
 =?us-ascii?Q?YGXEMnjXO+EBy/RSjRqkbhjINzVEc2cXyFwk9C5svlx0rHdLg2g/S0taojd9?=
 =?us-ascii?Q?RdUb6DKVN1aUbHuT0QdTeodRccoG/rEIqup4wvl2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae3b45a-8064-4a64-ddd3-08db9a109646
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 02:13:43.3939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4CpgnYbBZuQCVoddlhBboxPmn33s4AtWBRzMTmjQhyCnJq0V8xLQoNlzRL0a/nxeL32Y2sXVsgl59WWQQk706w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9630
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Thursday, August 10, 2023 10:25 PM
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
> On Thu, Aug 10, 2023 at 10:51:36AM +0000, David Lin wrote:
> > > From: Francesco Dolcini <francesco@dolcini.it> On Thu, Aug 10, 2023
> > > at 02:39:21AM +0000, David Lin wrote:
> > > > 3. Firmware version 2 is needed for this feature.
> > > That would mean that we could just enable it for other Wi-Fi chip
> > > variant that has firmware version 2, after testing it?
> > Yes. But I only tested with IW416.
>=20
> Can/should we probe the firmware version at runtime, instead of hard-codi=
ng
> this?
>=20

Firmware version is reported by firmware after firmware is downloaded.

> Francesco

