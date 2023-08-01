Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2AF76A870
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 07:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjHAFqQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 01:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHAFqP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 01:46:15 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F91C12F
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 22:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfqPXtutrszVHH3g2GvaxiaOQhEGfDybqtBH0LRnavw3INABJ2UnuNl2yyTWmdzK1SuZqcMARdiSg3lNBK/ZClK4tGG51FZKgyNsALOmlnYs0t2cV6BIeWf+0vfrufMBmacbTFv7NIE1xbo1vuPYCebEd9EyzpQ7Hm/Kt2E30n8TZogarNEk1h4jBE7tx/o2oF9nyyR9yLlHT0h+aQJy+xzOTiXYlAHiBFZ3n67mQEuSDKZ4QjPrjmnJsqnWlL37+lShZTkffASgNYsmzrzv6Reqk7VrmNQVmYwJetgt3yQfL1y8YikFUOXP4tfwncMYMIkyuYVzSEKKfNVBO66PeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iHcJiUTQQ3kRVRNHJ5bH/2Za/Apv7vdY0h9iQjqg/o=;
 b=Kqzz9xV+/R7Y5f0d1kKfxVdgNNnDxUlztpI7sz0d5JuNzTzoOR/uUbeIIwCxXu3ryixHI77mD9rcl/6sbJlmMiGeMQv2VrX/hgE7OeGPhnXGzVnkI2OmiUdWdfpHwcz9pKTFrGmx991FDGstfEuxZS88Ft2Ydecgz86Agg3P20dMVVCMim7jBhoojEdtdFPSW11oUy799lgpTqvPIpQcTQev5OyUJUR76rg7KbQZU+KBGcn/XN7x7M42Gx3HLUGRslKkhSqtir1/hIV7jN+8KWs2rj9mq48rjDpnI9TK6h1rJfQLX9HgalmqEB7c53HB4uG3IMFTbEAkZfi836Awug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iHcJiUTQQ3kRVRNHJ5bH/2Za/Apv7vdY0h9iQjqg/o=;
 b=Ihh1wXS8E1N+wbSbt/yQld8BqWBX7mq5iCtK8p0kWLQZI0EW8jmJRCWcb4G3Wx6C34uAfOItfm2k7ib/kRzVTRb2FQg83BIJXFe1lUh2ujlLMEJHUDMYoiOI/vfsJmT9jDC3ywl7OXo4W6ReW87+kAh9THsUyy2mGU16LjngJl8=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI1PR04MB9786.eurprd04.prod.outlook.com (2603:10a6:800:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 05:46:08 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 05:46:08 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH] wifi: mwifiex: added code to support host mlme.
Thread-Topic: [EXT] Re: [PATCH] wifi: mwifiex: added code to support host
 mlme.
Thread-Index: AdnBG0VbUku3Gob0RoOlmlRWbISqeAAWAIyAALIAQpA=
Date:   Tue, 1 Aug 2023 05:46:08 +0000
Message-ID: <PA4PR04MB9638B7CAF26182DDBACBB64ED10AA@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <PA4PR04MB9638100B3F21D083F386C6D9D106A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <f5164a1c-dc36-48cf-10fa-2a671f36867a@quicinc.com>
In-Reply-To: <f5164a1c-dc36-48cf-10fa-2a671f36867a@quicinc.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|VI1PR04MB9786:EE_
x-ms-office365-filtering-correlation-id: a0dcabd7-818a-44ac-6c72-08db92529a93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Fgovb0mMzuEFgJ3qQBS0m7vDldQyKBJzMb/xd+Ksa1G8ci1f6J22rHYQm9Cue20XnxvhN/doYgNBoMg3cwZnZJHhjpj5XhGZGHVTwWl2SXuNpHS5jhetTYyTQBUB49OR5VY/8p1vxNyQX5MUc8dz4Mvan7FuDXzkTomvOYDkLuqg9tETUcYKzjQUA9A7/Kw1agfAMrkuwfyopSNG21zxCMUXz7SNGOMHW6Yr9L+mRjsEPusKASD/sujYH9KF2AMyhA5OqZ6GTOLkNT1RkbDmxb5XglX1cgnIBP0Cya4DpQohy4VldXC61H7hqD/97gvaAoG36ledR7nkiZqRr4JMyydJPLRnYuOoLggmhBzPEGcUekMHkU8njsRXDBG18aLURybBUs++5tJD7Y0HjX6rYZuTv1iulKunfYl3ywHI5PtoRkr202d5JgFoeoaTki6FCQiOyETOsM4nQdMZeDQTDCSXSsWYPiRST/NEIYFtD4kZM7B0edm7mSX6X8E9GmELwJB4NLtG5FsrrFmPxs4AVhUYGnmfXDPKGLiikAr8Z6Vtm16+6cnLxOvsJhIoHt4/vK0SugnYwTArDuZe0nJf6JMiHSQ3w7r5eZ+eWEBkMA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(9686003)(7696005)(55016003)(53546011)(6506007)(83380400001)(186003)(76116006)(33656002)(66946007)(52536014)(66556008)(54906003)(110136005)(122000001)(38070700005)(41300700001)(38100700002)(86362001)(66476007)(316002)(5660300002)(66446008)(4326008)(8676002)(8936002)(64756008)(2906002)(71200400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nEIDZG7JJ49lc7cEN7lDCDWll+v1ImWQKzJY7BcpCLVfMr334EGU2en1/I48?=
 =?us-ascii?Q?cq7pOEp/QyOsZ9VSGg1PYM2HoUawZteztoI2+jy9ogLpiYpyEV7DaybH90KN?=
 =?us-ascii?Q?aSLwJGbNh3aBaDJZqlxpNt60vV8W5OzsYsk6AijB6gSDn2ypQkX5C62+FonC?=
 =?us-ascii?Q?BFnSruaYq3DGj22Fj5rV3vRJfjzS8V5tzhBCa0/se5oFRMQSzNHPsTRJCqZF?=
 =?us-ascii?Q?bKyMi9Hchxq2Jg+Mi5Jmt3QUo36IbVwL+8h9hrLJuPpWnSEst62YTKzQ5hbg?=
 =?us-ascii?Q?ghGIul/VExdGbzQ9f9e0zQY8LTuSMuvxjqgnqS3OCUebV3faUSg9FHeRHbpy?=
 =?us-ascii?Q?lxQ6aR0qlZd+WjfilMD3pZ/yd7v6BK2YHLWOkjS5s6151Wf9DMJ1zsQbJMu+?=
 =?us-ascii?Q?kYfERu3IYlvmlLZnWm7OP8SczMffW0H8m8nz/87dyPtUNcfNbZ+BmejAQaVl?=
 =?us-ascii?Q?gTZm3Y7vAZcKkT2/rV3GL4BqtjL3un/UhmSXpWsj9/K9vnuB77oR6zI9dukF?=
 =?us-ascii?Q?3H8MB9nWghGfazrVXFY3OR7tlX2nBx1rvM0sCsBhr8v4QNzZgcDz3Ef0nXwW?=
 =?us-ascii?Q?62aMhdLCtSBmWPkSi0z1cJq5X4CAuzL1OcWeeF9PdbsHpxeqhhaw9BE9m3nb?=
 =?us-ascii?Q?B2PyK4TWdP+dF+awQ+el5j3lzJphvhOEmr97XG9ZkG3BS6AJXIy6GLZUlfBu?=
 =?us-ascii?Q?WBwNFl8xdR4/hK5j+1vosTu4L3Ntr8t29PjLfejYQXUIgzaY+aZwSJmJDIrM?=
 =?us-ascii?Q?4+6NjxR4SSoNO2l0c3UySIDeKbf/He6Ynvu53lB6REgCVfbcbN6u4nBlH45f?=
 =?us-ascii?Q?qE+4x8Plm+6Cqk6Q/Mnzw+7BCNHzyhy/ck1QP4x4S43+XYGfZzBv/rf9JOON?=
 =?us-ascii?Q?XDWAleDmyjvdxTbBsPYQve9WV7dX0fQcZimcuzkxCJO+cEpvuAMcd2ZtfB+6?=
 =?us-ascii?Q?/JVqh7PX4hvFyKq33F5T6Dr7goLuemgGvqRnmkkvSSeJ6mhDs7l37uvzmRTA?=
 =?us-ascii?Q?sdSU6+k6pgIG24lmRTZ54lXWqSB0Kcq7RA4ui5V5tFpqtzz7xD9XUC8du0LH?=
 =?us-ascii?Q?5G3gXG03Am58ds+eaztPz5LRBh+d92C9JJ0UqGG9jigxDzzQb4QyswujhyvR?=
 =?us-ascii?Q?n4ZcTEhaMPKCnJGWReLTb+GZoHCps2b7MJHkLboqKCrFZvuUR4GKNSkM21sF?=
 =?us-ascii?Q?LHM96w1QISqjcw3mHvy8hpVNqjqPSTj5aBQe0IyjcGdzwjJj9BkkosTS0D+G?=
 =?us-ascii?Q?Nr2Q599rU2DMerYzBpuaVNjA7OEasj3caov3GF28Z+zVrHRaQ7taNFoTRLrY?=
 =?us-ascii?Q?GKDecyOQ+NaLuOJBC0QBBA/1DRtXoV89zl3oStcvxk/8j038gR+P9/vbXqq6?=
 =?us-ascii?Q?92bg/lL70E+z8zqRPm+YijWRZC8QNBIaiZjqEO1bKkgwATJggnVzDI2RN16z?=
 =?us-ascii?Q?jzYU5lqjuZHCdqntGD7uH1bhVPUyUt6qnXItwf6+ShZ4pPvQHNO6nXUpQ2Pi?=
 =?us-ascii?Q?wpyKL9Dj/eI5hla+liNyINHFLpTK/2Y6xXDfrEkafg0gocBuNypcux5z+A?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0dcabd7-818a-44ac-6c72-08db92529a93
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 05:46:08.1231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vzVm/saBhEl2aagy2TgCJH6GmJRaQ74DKFWkoiIfYBEdhYhMNGS9mnv5CkGNxzOsQ5l5Y1g36g19rwBFj+gzpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9786
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> From: Jeff Johnson <quic_jjohnson@quicinc.com>
> Sent: Saturday, July 29, 2023 12:48 AM
> To: David Lin <yu-hao.lin@nxp.com>; linux-wireless@vger.kernel.org
> Cc: Sharvari Harisangam <sharvari.harisangam@nxp.com>; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH] wifi: mwifiex: added code to support host mlme=
.
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> On 7/27/2023 11:18 PM, David Lin wrote:
> > 1. For station mode first.
> > 2. This feature is a must for WPA3.
> > 3. The code is tested with IW416. There is no guarantee for other chips=
.
> >
> > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > ---
> >   .../net/wireless/marvell/mwifiex/cfg80211.c   | 327
> +++++++++++++++++-
> >   drivers/net/wireless/marvell/mwifiex/cmdevt.c |   2 +-
> >   drivers/net/wireless/marvell/mwifiex/decl.h   |  12 +
> >   drivers/net/wireless/marvell/mwifiex/fw.h     |  15 +
> >   drivers/net/wireless/marvell/mwifiex/init.c   |   3 +
> >   drivers/net/wireless/marvell/mwifiex/join.c   |  65 +++-
> >   drivers/net/wireless/marvell/mwifiex/main.c   |   4 +
> >   drivers/net/wireless/marvell/mwifiex/main.h   |  10 +
> >   drivers/net/wireless/marvell/mwifiex/scan.c   |   6 +
> >   .../net/wireless/marvell/mwifiex/sta_event.c  |  17 +-
> >   .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   1 +
> >   drivers/net/wireless/marvell/mwifiex/sta_tx.c |  10 +-
> >   .../net/wireless/marvell/mwifiex/uap_cmd.c    |  25 ++
> >   drivers/net/wireless/marvell/mwifiex/util.c   |  74 ++++
> >   14 files changed, 558 insertions(+), 13 deletions(-)
>
> I just did a quick scan to see if anything jumped out at me
>
> ...
>
> > diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h
> > b/drivers/net/wireless/marvell/mwifiex/fw.h
> > index f2168fac95ed..e2827e25ec38 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/fw.h
> > +++ b/drivers/net/wireless/marvell/mwifiex/fw.h
>
> ..
>
> > +#define MWIFIEX_AUTHTYPE_SAE 6
> > +
> > +struct mwifiex_ie_types_sae_pwe_mode {
> > +       struct mwifiex_ie_types_header header;
> > +       u8 pwe[1];
>
> this jumped out, it is not allowed (unless this really is a 1-element arr=
ay)
>
> see
> <https://www.ke/
> rnel.org%2Fdoc%2Fhtml%2Fnext%2Fprocess%2Fdeprecated.html%23zero-lengt
> h-and-one-element-arrays&data=3D05%7C01%7Cyu-hao.lin%40nxp.com%7C25c5
> 6f0fae1f476485d308db8f8a6cbd%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C638261596917903672%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM
> C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%
> 7C%7C%7C&sdata=3Dx8gOxfAcEpZY9Qg5%2B%2B7gz7OGUp9InUIoRnyb%2BGJyj
> Ss%3D&reserved=3D0>
>
> should just be u8 pwe[];
>
> make sure any code that uses sizeof(struct
> mwifiex_ie_types_sae_pwe_mode) accounts for the u8 being removed from
> the struct
>
>
> > +} __packed;

Yes, I just used the latest checkpatch.sh, this error happened. I will corr=
ect more comments and fix this issue in PATCH V2. Sorry and Thanks.

