Return-Path: <linux-wireless+bounces-11503-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0B6953EF9
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 03:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB213B22453
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 01:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16671E864;
	Fri, 16 Aug 2024 01:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kSfF1oov"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50858472;
	Fri, 16 Aug 2024 01:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723772371; cv=fail; b=mZBcV1RXKx77gfncu+lFBMwErbO9R4c1G4Awgkz0MXPkQMwyMPkjLvXBPTtTSihRhW9LGwESFRJm6IS27atx/FPlnTHjtZVrKJsS/El/nvj5wYS2iFqoXeu3V1/1wCL2W6V2hwy9yPOyfN+Kn/g6qg7qzgEjX5tKlYhzsRZAZ9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723772371; c=relaxed/simple;
	bh=o6JrgIgyJM/ZescRKQnbtWa2LBvzYGomXj4SULqjKe8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dS5dHompO3RXrePdJvzkavI6Wg8F0rtHOkANgZY2HrwrE3WeVaHENc88gU/waUZskWc+lTnvcOTM5ixnjYoS38H/QNIbiJRWWTcE/KLT0WId5a9+8QlpmELXsAK9zOT2NiEszKoHTxlC3sELSWG+tkj9J7ACpgUNOv/clFz8n9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kSfF1oov; arc=fail smtp.client-ip=40.107.104.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6ppDJUezCOgBnxp4tRP1nc2hw5yer104ELHxnDQyTqtMIBwBtWViMNxCfQVwBTIoKUh9jb7lXEqaydUiZ+CGfln/xJpgpCBfa2qs5qjNmQGWT0H1nITwoHBl9eT9Sec6Lnm8nqidsH476ReA2EOCACmMsE6skyUFPUYi3kzyV/PJ+JhZJk3kq9zMKdZJRxB08//+3B0N7siaD4W0SFi8+uMNOoWcDwWkprdI2yV+FlwoF91mORxpl7Oq17eedkLDBA1RiXPukQxXExmfr5cBn+4b+IKVh3+uynknrR3rwpbMMc6WYW6JxHU8sewCGZ96iwerea2ElMJxQ+46TauIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6JrgIgyJM/ZescRKQnbtWa2LBvzYGomXj4SULqjKe8=;
 b=zA9L3690jyzczZeZLOj5pQqJ1AOpCrXIPiQ9PQqhgnERkAmEg20EKsAZXrtYg2TItsZmCsMBJbANDUHT12BCSP7e+q/DDSSIqJWqI1eB/IhHpHctHnjl1rycKh5jMN9STudGHuA6XbcWOqFE/OVw7KOWcajVYfIdk/33NIX+SAf4J5aPAWgXeFY5SQ2uHTHG3upINfP7GzE3+Fk24/tRy7rc90l/N8CmGuicckg1U7n6P594xDfj5y0AhSMVTu5Vva58WGIQ29/AZMeAd3h+iDt0Rtfq9cZVXhV4XY3BaHv++Jsf6jHHCVBRLmHq9qhYlGf47DFCATz8L2muIzv48A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6JrgIgyJM/ZescRKQnbtWa2LBvzYGomXj4SULqjKe8=;
 b=kSfF1oovhEQ8yBBYOVQXZhKhMQVVZcGHDYcbh1oUtWuRy8zpB6NJn5YBj0SKEU/aLTFGfw7gQROkIM5o3toyp+DJDxJTlRNdbQ6jD4FHtN+fhLDovIJj966dqLcrsaHjzqXdd0/XFuwhUHg6QmBQGKgZOE95z6EekBSV5dsoq0GEYGMX9NOwGo3C0lUBjYuYlCBOi0c7e72r/o3LkLxhm6LIHNSAa/Wq+rhS+jwDm+eLgbmgGlXqBV+ovU0dcesWfclvo9OPbU0c/1/t5wL0kBO5aj1v4wDxsyRx3RvC6f643okb3drCHhM8OGjNw4UN4oWF7JjqNoJ5ydHaDViEKg==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS1PR04MB9261.eurprd04.prod.outlook.com (2603:10a6:20b:4c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 01:39:26 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 01:39:26 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Kalle Valo <kvalo@kernel.org>
CC: Greg KH <gregkh@linuxfoundation.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "briannorris@chromium.org"
	<briannorris@chromium.org>, "francesco@dolcini.it" <francesco@dolcini.it>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v2 40/43] wifi: nxpwifi: add wmm.h
Thread-Topic: [EXT] Re: [PATCH v2 40/43] wifi: nxpwifi: add wmm.h
Thread-Index:
 AQHa6kE6j/gZp6A6LU6lI8Wv3luu3rInIIOAgAB1deCAADe5gIAAE+mAgAA7WQeAAQiIkA==
Date: Fri, 16 Aug 2024 01:39:26 +0000
Message-ID:
 <PA4PR04MB96380D43DADBE823A122A32AD1812@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
	<20240809094533.1660-41-yu-hao.lin@nxp.com>
	<2024081430-derail-diocese-78dc@gregkh>
	<PA4PR04MB9638C1186FC4D56569D7D0E4D1802@PA4PR04MB9638.eurprd04.prod.outlook.com>
	<2024081523-curator-pronounce-4619@gregkh>
	<PA4PR04MB963855F4620A2E2C48B2DC2CD1802@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <87zfpexgey.fsf@kernel.org>
In-Reply-To: <87zfpexgey.fsf@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AS1PR04MB9261:EE_
x-ms-office365-filtering-correlation-id: 2179fcd8-cf41-4f63-3ef9-08dcbd944384
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6VnS5cSiRxyho2788bq8BCEI2W2YLhBKHU4ZL1juFTa3oS8/pn/xbDw8t9QR?=
 =?us-ascii?Q?i0ADQSA3JqvUPkfhlNMgekAMHJ/pTdFgD6Pw7HVZHR5UaZd+qQE6dtFiFQGb?=
 =?us-ascii?Q?QRFdGJUVlvwDKtb6Nx3nRmHcY6B/CpD/yB3YQ+h5Y59CByzUh7tq9W4NqGmz?=
 =?us-ascii?Q?tSMzrx09fJzENLTaLtVxCGLdz8uHp0ssb/hnuHB3e59y3MOgvscISMv0n+Gd?=
 =?us-ascii?Q?mWUigXaCxzX6klPROBJ0pJyRKi9E6YjW6HWssGLQG0HJfvJ8w4Rsmhe9aW+9?=
 =?us-ascii?Q?gUkdd1opGu4C28U4+sHj2Yy9AuuqC7bKdQMIYOI0ngGWYfDsfFu8/DqzKcD7?=
 =?us-ascii?Q?4je73nJM3Q2PTsHe0X2BGNYQLTmQUIthZXiwbaxOKV6ncOGsxEGgV4U98Wcs?=
 =?us-ascii?Q?vMUhl+agATzFd5uBqd17EELgJ2KYXFI5YoIT1jf3ZX0RqQqXm+C7acqydFr2?=
 =?us-ascii?Q?IQfe/niUgbjztNVGC+5RoQusoFx5oGH2dLHNlHqG/1rpRcD+PiOeeLd42+tg?=
 =?us-ascii?Q?e2FmKoguT2RBeBovRUnA7t73kcq9LopQvmuhq7a2kJNz0oXq6H07oVQ1RoEE?=
 =?us-ascii?Q?FzI2zVQORRDnFYzkPqdlte1BANhKSPL3mI0Nh/o5ZTOVxZXHKrxMnnx+6+II?=
 =?us-ascii?Q?MsAwaBt6tD3IZCGVgIgmudiahijCWJpO7kYt0cOWzDRZ9mSQwTnSJms67Uy4?=
 =?us-ascii?Q?Iepo5STJrfxx1BCi8iryqTV/5sZtDP6CclX4jvtkfA0CKRPssSQCwlkGeXeL?=
 =?us-ascii?Q?yeIQTotkNgnsRrdCAbGMWbdU7acrwRTCUXrkyOum5L0QGsSTMWRsVr8JDHD+?=
 =?us-ascii?Q?732IKGR/rT/QLHo0b3A669KwVybH7PlnQ3Fdhd4qE1bE+Gw5v5W8JNjO/cmd?=
 =?us-ascii?Q?PiVg1P9qc1ht+/fMWPWbZ+XvFecPeqNTNSriXNGS9pQ/qiX1JsDUhbfvK4pR?=
 =?us-ascii?Q?BGaMo25YMS07Y1oOj86g4xT/8z1dJj011k/okcBN3abnXuOHoIJKCasK2IM7?=
 =?us-ascii?Q?0hXv7FpblyPnslJy8uGl7dgQu3MwnlQPxgKFdKo6bJ8Z+6f/mlkEOB1YpCAV?=
 =?us-ascii?Q?XZyKrlwIPf3BT7iNaF8PB4jfal0/jh/PAA3a5OiOv2dhgykciEF0+p8RMWxv?=
 =?us-ascii?Q?+cdNid966nt+XrN7KSsWiSeQaC0qbj4824oLA/vo8LjF5iBYZp31TvkEtO20?=
 =?us-ascii?Q?o1CPm6qTOEJ3v1NmtnSVd4WS+b25AGuuh+tRPUR/xxkFSn2btLGsOkdBTxMY?=
 =?us-ascii?Q?Ukg/4+mLLrA9f4HyHiQpzWLFyJUSAyjnnnZZaPsBeetsFf+NlryFgEwk+tU9?=
 =?us-ascii?Q?0aADXAWsVejmrxkEEc0L9MORODNFmf0ralfkP10iUzdbAoA95b2+Sfvg07fT?=
 =?us-ascii?Q?9Na2TAnztAn8wqW2OYNkYz+5EXn/RSJ9+sLJGXdVDNCiZ/Ia7Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OktVSgcLBtmQisxX8ZSVT1B7oHMlXRfRNCLb7d8jCzasy/I2kCW5qm29Su2b?=
 =?us-ascii?Q?R4//w5LMePa9einZbvf1H1ebURwTUkquHVmbGE22GL5+J9EhAavvqrfIgWkF?=
 =?us-ascii?Q?SUhSGYSwDf5UMuGr8v32JhT0iFLmh+jpDHKDlRwHrxMvUF6o77ET2T99c25/?=
 =?us-ascii?Q?hD65VhGGomtxXUNtKyJXI50dUNw/sesrmgffs+FQQRDecBO0S1YEodVyz5SS?=
 =?us-ascii?Q?SF3dmjUeBLQNm+g+c4D1z0T+bAxBz8bx91N/ZPhcW4dkYFZDe2PiaaavFd3C?=
 =?us-ascii?Q?uJMaslQx7IHn9L18T0lRJpJMOpjJl7vD1QkEyVVDCcYnSPebspQDJGHMn7AY?=
 =?us-ascii?Q?ApygqWmqhnfb9wwi+8vcogt2zBQXLUyCSpBbXI3viLZP3zVvJdL6SM/WaiV0?=
 =?us-ascii?Q?dfu4WlbbNK1LzOs+5hiv9zP2BaoX5fh7Zn5G7XYWIQEMzkK1Kffu5MqLv4cF?=
 =?us-ascii?Q?Gdp2rbE8fn1+m97EpUZYjDnBlbaHTq6W2fRXgn93X3V994GQiBgcZhsDU5S+?=
 =?us-ascii?Q?JIK+TPi68nzsKeZQAnGOZFzAiK1IXlcNE28oE9LVCAzrmgCbOuXS9rVjDvch?=
 =?us-ascii?Q?zOqu/G9TZm+Cuvqlhk+dc0VP5x4udPJOY2fo6X3DL7P6Qc/zos4CDvYuci25?=
 =?us-ascii?Q?gKrouZFFPvz3byFcwk6ycxCACzOg3yTw3V54Hl5qpX/eCNlejtX9Ytp1tND6?=
 =?us-ascii?Q?Py5uqz6pVMw8cCuozqOxSMpfk2fqxMZu0Orb0Ze78EvX/IN5s2tl+EXfEA31?=
 =?us-ascii?Q?seA9tEs51IW6yK/nC4tKorea5El4bwJxW5+7v1r1uF04Rbtc4ZqGw5Cyk4Kf?=
 =?us-ascii?Q?xxOH9epIjB+f4ly60zLQee+hCoNyX9x3K64T5oPoqZI98IwBbXRS+DtIeT6G?=
 =?us-ascii?Q?H+HQ+XB0AQWDpkHKllOPc2BJtMe98m5Nwkmo+iTmXzUjd88oR3mtz23zBm10?=
 =?us-ascii?Q?HQ2VVjhmM8Mmy36oQ9lqtfh7oC8ouwsTPC0HZVmYFdBthv6r0BgRvQCgziMu?=
 =?us-ascii?Q?fKxxG5LHSKPXMq1qj0itAVHid4etcjAsJu2V9hx/fFtt97i9yoZD3yPM8SPd?=
 =?us-ascii?Q?53w0pfCej3sKrVJOaWwi0y6XXnb79cmnV6tSKniMJSO0J5yISJJXgpbtxYeI?=
 =?us-ascii?Q?wKOMfzaDOUT3ozw/0Ljax4YzK8r8d/fLxi/WWeTU3L5txmdvw3Vje/RB0MgZ?=
 =?us-ascii?Q?ziBz91zyiuVaf70uGioW5FcmJOHvr5CEoafMb92aAoZsJz7+NiNA87ClN5Nw?=
 =?us-ascii?Q?1SPlGHYKUk+IinZBvzq5whpfAfL4YDytUSMCz4939UUZGv3ptbAGcLFVHUMf?=
 =?us-ascii?Q?x00CddFeC1WaKJ6C0N2CqzKJz1/k8TtVHPj5IaNLiaxCzExRO7fJimjtklok?=
 =?us-ascii?Q?cTNC9gME70JPgE6v1lrQbw8X6ZeWrd1KazJWt9xjzOz9o8ezd13Dm9yVaGrt?=
 =?us-ascii?Q?mCB8LBvW34tySEdpOjjXqio7NgGGroQeywhyiMaV3N4EyVnlHn7eWVVNjVkt?=
 =?us-ascii?Q?Ofexzs0BWhl8EzRkZhxVppu4JoE7yd52p+uL2/Myg62boItM3qJi1O2yiL3e?=
 =?us-ascii?Q?k9P1bz7g6XaySJ+I4ZM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2179fcd8-cf41-4f63-3ef9-08dcbd944384
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 01:39:26.5016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eg2GwM+ciC0aRQtPvMyuBl+/DXuI1BTZW1p1UKG8t8LJ6nfAQHgUtS4lr8yjQyVPAAbAljJg5WHNyLwnGYsvlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9261

> From: Kalle Valo <kvalo@kernel.org>
> Sent: Thursday, August 15, 2024 5:52 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>; linux-wireless@vger.kernel.org;
> linux-kernel@vger.kernel.org; johannes@sipsolutions.net;
> briannorris@chromium.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>
> Subject: Re: [EXT] Re: [PATCH v2 40/43] wifi: nxpwifi: add wmm.h
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> David Lin <yu-hao.lin@nxp.com> writes:
>=20
> > So that mean I still need to add description for every file, right?
> >
> > Once if confirmed, I will prepare patch v3.
>=20
> Please don't send a new version yet, patchbombing doesn't solve anything.=
 I
> would say wait for review comments at least a month before sending a new
> version. But maybe send the patches only to linux-wireless, that way peop=
le
> outside wireless don't get confused.
>=20
> And PLEASE do stop top posting, that's the most trivial detail when worki=
ng
> with the community. If you continue top posting then I will automatically
> drop any patches from you.
>=20
> Carefully read our wiki page IN FULL about submitting patches, link below=
.
>=20
> --
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
w
> ork.kernel.org%2Fproject%2Flinux-wireless%2Flist%2F&data=3D05%7C02%7Cyu-
> hao.lin%40nxp.com%7C523f4e00330b4e2d3e6708dcbd0fdbb8%7C686ea1d3
> bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638593123020514086%7CUnknow
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DZQ9oeetOx6bnIYOpUTOxdl5f
> 1U7Bh6EK9WbIbWb0RNM%3D&reserved=3D0
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwirel=
es
> s.wiki.kernel.org%2Fen%2Fdevelopers%2Fdocumentation%2Fsubmittingpatch
> es&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7C523f4e00330b4e2d3e6708d
> cbd0fdbb8%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63859312
> 3020529099%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj
> oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DCKp
> %2BPfqW3gKcigV%2BezWbEYvFfIn0dYaTDgSiiwYKKow%3D&reserved=3D0

Thanks for your information.

David

