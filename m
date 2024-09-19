Return-Path: <linux-wireless+bounces-12995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8EE97C2B1
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 03:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7141A1C2106C
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 01:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823D41DA4C;
	Thu, 19 Sep 2024 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gX1C5fna"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411D21BC44;
	Thu, 19 Sep 2024 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726710433; cv=fail; b=VngyS3MdgMFQ36XT9IlDiLHK8nnFcrhXHfdSopPGdwFJDpTyPKe8dIBvDcuU4dBlUwMBJywMRjR+XUGF0oHIhQRKPo5yT9oOgnj4m43D52ukRbXunSgeX9yfUbXqmeX8qQyc3EFFFl11yVuY8JioIW4fIzTy/+qRlMY/7sRAXyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726710433; c=relaxed/simple;
	bh=0lZUsOYwv1AxNjmMHHv8Vclsi1uljCYUyM/9Ca5g8ik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B9cIZr9W+qEmXvXteuKFTE0AWeS/7v45pz7FkInnbSb80BtcF3yM7lJau8EQQ+hMBVrojcF661zGB5310QF6SY4H+0TZNQRr1qHrgO7thOAe6FEaahpW1gTK4j1Ls/kZNVrUMTkN5mQXyqHptGntueKWNO0fgrecnzl/bAu/ZGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gX1C5fna; arc=fail smtp.client-ip=52.101.69.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIsO/1LdtK/MtTqMoZY7H7Ye7CPQ+aXCigCfrioC6ledyn5PDWNjJIxXmuR2k1F6r495T0ipCInn1aWw5jbd8m+PT3jLQjBMAwTGQFk9i9Sb5/mKmI7Otss55++Mcuu3Cu4uRHMxzCkPNlq8V23N4RlsgvQvpaoEgHFodP1YVucD8SORvWbBjJehShTFevVKTJnUv2nj4Y9aF6W4L3CHBrPeZ6WMlCBZOSrRLOdNb3A3+Z1/BkD/KKqgU2FQtaKIxZ3LDyNryYM9ukY9I0aiSCo96yM9hW6IDkgNjOMJmFSfZHThsiwgzsqGda+5yE2P6JI7l/9jo6od/8dgkBR1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lZUsOYwv1AxNjmMHHv8Vclsi1uljCYUyM/9Ca5g8ik=;
 b=T/+oYGkIehx9WXF46PE1Hffu3QPicNxjGO08/PCYtLIspSuEYolLBKWWU59AAnhiwjnheEpNSyA8r1/SXJLVyJNqurzaeFnad56SQY/55duOgDjSZcE/tZ9sapRiDqZ/c00CZESjaJr9EvCnpdoEQHtogw4NoPvz3RbnOg2214jYNe1TyxlFR0TzmZd1wwqXOPVGMETEigiyiqmClBbCvddKfh2i0BNg9m82YYBFKMErYomnI4MhjqtU1+HZzJeh+JTQFfjyDJV1qG6TxpxjzbifmrF0elgNo/bTV6kZV9gtdsK57PVzMCWOvTruQugWfd7j3szlOKQGd2lJ406VIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lZUsOYwv1AxNjmMHHv8Vclsi1uljCYUyM/9Ca5g8ik=;
 b=gX1C5fnaKiOQuW9alzL48PuVjVuQNRQE0gqsAmDqm8wj8Rx0wjiJDQgyhVE1A7toyAQ4xC8LIj96vcNnX+AS9Zdy/jADCvNBUSaj1KCUiyZgb04HHskmXLZJ3vUGuPrwVcHN0tpfJsa6Ap+S04uhCbPvCDV3ad0t8582GPTgBaup10F1lbFv6IvZUaypZUnEA6rE5wI0GJ5aVMmP63VETckZ68kzuFypUJEwdP1oFnVBJPmmJDX/ZWvjFCjFNn3HAiIb1Y1JdID5fpcXAzvWmLHkiRs3ipTa8Q5ga0WDYgsvtPxjRYNscN6sr45OQ+wWJwmfa3gtX0KeYWF2ZeYawg==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DU2PR04MB8549.eurprd04.prod.outlook.com (2603:10a6:10:2d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Thu, 19 Sep
 2024 01:47:07 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.7962.022; Thu, 19 Sep 2024
 01:47:07 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Kalle Valo <kvalo@kernel.org>, Francesco Dolcini <francesco@dolcini.it>
CC: "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH] wifi: mwifiex: fix firmware crash for AP DFS
 mode
Thread-Topic: [EXT] Re: [PATCH] wifi: mwifiex: fix firmware crash for AP DFS
 mode
Thread-Index: AQHa+rOve95XNg2YF0iAcaLwH755k7JSZayAgAuNdjCAAIJs4A==
Date: Thu, 19 Sep 2024 01:47:07 +0000
Message-ID:
 <PA4PR04MB96384683DCF221147DA50E95D1632@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240830080719.826142-1-yu-hao.lin@nxp.com>
	<ZuFjtc70r6CGbzcW@gaggiata.pivistrello.it> <871q1gdeul.fsf@kernel.org>
In-Reply-To: <871q1gdeul.fsf@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DU2PR04MB8549:EE_
x-ms-office365-filtering-correlation-id: 79e890a9-d956-4a35-d050-08dcd84cf85d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DMIAAL/bza1SzXpjcUnsiqy6HATxK1x4vGcOCs0ELI4xyJM0pmlJ7hCsVjbs?=
 =?us-ascii?Q?jK8Ru7k3CxtiCjFV2GwRKtflzsILd3wGm/+PoxN/0X2/+s3+pqaT3az1q3MW?=
 =?us-ascii?Q?fRkytQcU73tvq9nwmfG0s35oNfhZKOoah6IZR/SIll1RVvB0U5w/MRasZJ/c?=
 =?us-ascii?Q?3m4/Ik5oNuC5X3CIyWs+Ji83dXyqMy7Z1L4k+rvqvZ+mZZeZFD+G/fIDhWeN?=
 =?us-ascii?Q?W0xq+q58ckV9yzWvkWJ0jA6ayQBVfZjnTizxPmQekz/flwLntVWZs7p/0k+p?=
 =?us-ascii?Q?ZeHPwmyQERMxGcobKIIKmSXfQ9REMdUrVbvtPP/98sSOMkxhC6R3pIDXQp6t?=
 =?us-ascii?Q?vY7sSYnyyIH55deCiBnTolY4SiTl001MyNtydFnMQmOOhLUpa2z/QuLC5WEY?=
 =?us-ascii?Q?WbX+465C3cUT8vwTNknSr6FXVXBZYl2AxxxAKTy7t7A1EThnftwjfapfDyNy?=
 =?us-ascii?Q?h1fPBnL6PIodEdYQYG6FcLQrTFsW5MGzadwVxGWGp32DsuILYUZmHeHBeaY9?=
 =?us-ascii?Q?UjrEQY2OrJhiaLCGwJg5pwb0gOp/tunQXWW2bf/WtZCdI1e79fr728fU13/n?=
 =?us-ascii?Q?lDUyE9cRgzCw2phXOKm9oqNJyXbE9+vRrTcuZr4Qc2UQqkX+jfLdjW1B+79S?=
 =?us-ascii?Q?vyt7wkLGKG/erTjQn8I1yNFIpLUuS5N2N2loK2EIoJvQFT65wh2fHKKG3xaz?=
 =?us-ascii?Q?mx62h2WKajyAIKeS/zOff0U/FYMLonRu/xRUrXM8xEaZ3riM4tXoj99gkLHp?=
 =?us-ascii?Q?gMOmQZDe9GKg8ZImZZSEFjffPdT/251+ce/31WhhvBtv6zvw5fDG8xsdPDBk?=
 =?us-ascii?Q?hAjbjdFumluMKQ6rggzvY51yjKlskGDakKJyt6aTTPdte/zeBlC8U6eLgrFW?=
 =?us-ascii?Q?TbK9KroSq7AQueLAXjECxDHRnNKQmlAfnSE6D30nehb0OtJoKyI2W2zm5jwj?=
 =?us-ascii?Q?ChbZP7XcnQWwBJcmSL9ui0CUgfKsubPs0h9tQP7I9jbquxkmjcKTg0UsJxxR?=
 =?us-ascii?Q?tK5O9oZUaugCCPz58mSxg7RWBDCYFRtbYdIQxVuNv4xWY+K365njCXTUzzi1?=
 =?us-ascii?Q?IbceWMbR4sSqFQJ7y3tMEMSd+AKltTDOxMleII46coZ3SrLVMqcwPKFktG0I?=
 =?us-ascii?Q?CS8Bk0Z7I4jPxcLM/t9U8oOg/5rEWlCNZySZx9nc6c36wId8OZ2IFrH7MDVK?=
 =?us-ascii?Q?eceS7tsKOsldgHuy8HFk66fMyP7nXwFUqr9A8KtyucxzWNq8Uh8zUB5AYRYp?=
 =?us-ascii?Q?AQElI+ciDpF93bExsrtZjh+YTqTQRuQelxxz1bljOEnqAzA4fES4TGvbvCqO?=
 =?us-ascii?Q?5R3iP+6PWJuQKVAmBKZB2sX3Ha4FF1kU8su3/l9cdjQgJ1sgZG56s/LaFuxS?=
 =?us-ascii?Q?mHVzC8LnGK4HgfVLoTtl6cxXecERttWs3rBeswQJYOyFOkf19A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EfkiSEXYS0m22tDoGHuaB6RGVfdyVDoqghmaqbTspuXPTvqbQvE+3HDPt8es?=
 =?us-ascii?Q?Ts/QlCyoq0m/3T1s8aNHCH28u2DVLTCOXvR57JmYkoOwxdoH9NozDnSB6LIk?=
 =?us-ascii?Q?g8oqSbBsZKOs+Ru14rnh/u2VfCRIZncndkvmXj3vY4oauhTGTTXYh7UTk9/R?=
 =?us-ascii?Q?0Obcq0/ylJdTLRxkl/pvwOXqQGsKggQJdlU8rBJtP19D1z34jsktw5ZIPiwf?=
 =?us-ascii?Q?ifl1nKaUDIb7luM1ZjMVw6P4Y2+3ox5n3k1kzcjClv5j1QoH+5Qd0ijX+VP6?=
 =?us-ascii?Q?ZMjsqMoDjiBIj2MH4VuaQhC+ROgD4R/LQjcMxTXvE1DtuLnnFd87VhsIJ9Dd?=
 =?us-ascii?Q?9VJ4ZRjTRD+wZL1QsTLDB+Ww9c90c125ht6PwBK6r24rAg/t0CwyOQ+q0k2C?=
 =?us-ascii?Q?U67GIziCVjpSuwUBYxbukVehUGFZzPoWUEzvQ+vRPaGoc9JEnoNsCVtNHjKs?=
 =?us-ascii?Q?EFW/dqU9hTT9I4Ala4KFWAXbRNiYiTfrMXAcKmBQcWfrcRhgkSCKh8Qf9FuH?=
 =?us-ascii?Q?rKM3haGWuC4ApWaI83N7P0ANeucBMxgR80PwyiWfFWwh8m/isB8AlVjeHUVn?=
 =?us-ascii?Q?yQxHeViAAl4eAOf/aXNEoI+7TLGzms1dOSqvtnuCMKQ4bzIE+7f0FObDRrUT?=
 =?us-ascii?Q?IJ2ixdYv2oqFTpdaUso0CIodrWI/DyOt6lXFfMy8+mXfMJi3Y4dO8KYbEs7n?=
 =?us-ascii?Q?xDi6L+/7Z1qtbXbFxIIeUsZwkRaQFl8TIvYu8Tsm925qWEGhtTHAuoPwaGrD?=
 =?us-ascii?Q?QZuzosJnZcQrSCtnp+3q6x2pDHDjXqJg0CEG5rhHz7YT1lIqwk+mpWS90cUz?=
 =?us-ascii?Q?VIDXcBy8ByIj1bIZ8ULxL1+KdA7jRouLBroKI6LuroY6fzCi5m9htWZott0W?=
 =?us-ascii?Q?kei6TxAieHX+x94Y1Z3b3fUWGl1FhprAySK61Pl6YubscTeczw5Eg6f0t9L1?=
 =?us-ascii?Q?6O3NHRLuX/LejjLfKckr9RfZaoHnpQoOFvHZjuRU2r6/cMQ0G2lSkVWXTYPj?=
 =?us-ascii?Q?G6oNDIRYkKsXuI200wtR/LqJTGAxwEqXlqjykVG4i1yid4PLjrT6T3tKk0UB?=
 =?us-ascii?Q?8+/GT6eJsElQPViCZqTSf6Y9sfRRU11XVVU/urOfbhgomPK1dtyTz+5IiNvw?=
 =?us-ascii?Q?W/BtHddETi86xJI60/YJ1Y6cjrW6dsvstDXy6KGNMTmsCWSct81HgLZiwZ1B?=
 =?us-ascii?Q?k3PrvdNpvy9RSzN0RrdCdVXvcl6Fg/DGiJW1EkGpokvfMyBxE5qbEBwGaA8/?=
 =?us-ascii?Q?lhTWkAgTDv+e8mpLnwlAbpgA4DHwlzwVS38PeACSuqyWxmTQFg3SeLP+VjaX?=
 =?us-ascii?Q?dPSmgmk2JnlynzupbLPgbRgGnNty8V21Zqs4hdPzMRbuqvQXvKODAzmZchR+?=
 =?us-ascii?Q?JWM98MJUR1Nk08owt8nnkxBGIZaWaPBp/K0LgqlAd4X4Hy/9q/p5DPSZQXWw?=
 =?us-ascii?Q?mXjOWLMttm8KW+mA7BdYYsKQbh13MbtbiESrscA9XdOcElFELjsgJEx2eVK+?=
 =?us-ascii?Q?58Mqnz9hlnH4XXWc3Nd4lH9ogVb3O0PYYDUPjrm4wHtfxpm1gbdA0GpUS7oF?=
 =?us-ascii?Q?I5BI/adb9Y7wOOifTQ5xaT1u8mysYbqqA4rjbHCU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e890a9-d956-4a35-d050-08dcd84cf85d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 01:47:07.5708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i3ZHWsZVVyXAKS6wpgwjfzWIQloZSJ1zwaxUvdES6oFDFG9FvxYolykFjMgUzg2zBE6zSQaWyuSkTPfvR4mDTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8549

> From: Kalle Valo <kvalo@kernel.org>
> Sent: Thursday, September 19, 2024 1:58 AM
> To: Francesco Dolcini <francesco@dolcini.it>
> Cc: David Lin <yu-hao.lin@nxp.com>; l.stach@pengutronix.de;
> linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH] wifi: mwifiex: fix firmware crash for AP DFS m=
ode
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Francesco Dolcini <francesco@dolcini.it> writes:
>=20
> > +Lucas (in case he missed this patch)
> >
> > On Fri, Aug 30, 2024 at 04:07:19PM +0800, David Lin wrote:
> >> Firmware crashes when AP works on a DFS channel and radar detection
> occurs.
> >> This patch fixes the issue, also add "fake_radar_detect" entry to
> >> mimic radar detection for testing purpose.
> >
> > Do we want such kind of "fake" code in the driver?
>=20
> BTW in ath11k we have dfs_simulate_radar debugfs file for testing DFS, I
> assume this is something similar. So there are benefits from having it.
>=20

Nice to know it.

> > I do not agree that we mix an actual bug fix with additional testing
> > code, and if I understand correctly the commit message this is what we
> > are doing here.
>=20
> Yeah, we have a rule "one logical change per patch". So the debugfs addit=
ion
> needs to be in a separate patch.
>=20

O.K. I will create another patch to add this debugfs file for radar detecti=
on test.

David

