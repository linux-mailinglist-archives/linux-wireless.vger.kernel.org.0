Return-Path: <linux-wireless+bounces-11455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 211F295294B
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 08:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA12286162
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 06:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E837053365;
	Thu, 15 Aug 2024 06:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CPmMH86y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011056.outbound.protection.outlook.com [52.101.65.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA3F18D62D;
	Thu, 15 Aug 2024 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723702985; cv=fail; b=s84oQtGRTKXps7PeFzbXI7Bik/QhS8aHMMOcC3KGzevmhgbZd2FAzO4Gr8qkykad/ocmP67Ar1yQMxnOf5heFmJ3VzCHqMS2l/r0BffqLv4qhsBSqbXB5yi9LpEgRkEl5KBcioPqMHpnQLP4bQqsRc/VyZDgq26oDnaxqQtiRos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723702985; c=relaxed/simple;
	bh=BOv1vM4w1nYPjc4pVrcrhC2VRzd7xwK81vzopwjDhaM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MtBolmvQ8oflvvW2fhjX4yj/JctGyF6JZFIreeVXxyqNW1Ut+rK4CXrn5Xzydpn0O9Ztj8zVc1Q8fCb3YOdkZCyAIzqRbh7oeoHfshiXUU6mItrLEs3jnyiPOyLTpvn5Z2oby/81Jnbd6qOsIdi14TGQKfiISOiJleJzPxJkBuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CPmMH86y; arc=fail smtp.client-ip=52.101.65.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCkD11yNAoijbEDIEjkf5hQfX8VgBMt7QFpe/fgArO0/FQOpUnOPb7TCvY9jtDc1h294RJUZRuwDkOECIrriIfu57Ra1fD7+bEuoKPk91/yM+ouooF4ixympzDVhqdUlXMHztR1gjibtCg1fT1d6WED8WlqvbLgjjAaHA1LXPvLH8IVKCHG/wYXFVZR8MKNPEeEslSgK0acdyicQcRTzQBWNedmC7Dz7kpX4nnzxZX1ZzPFUohgNb9hOXuhH+ZhRH2BYnj2Eh/UkGkSaHLY47k6yGuhSI4OYzt5SeIP/YZifLbvSbG6stsKHfbn+nm6WsOC2hd1w5GEx2MarWPjiOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDVOhECOp2rNXIWZRodUPZUXiHe20oSdJYjkLgQXtoA=;
 b=t0PSOUgQEzwLd9BffzdZJhWMiQTZUSLOvzghPrZ7GfS+QM7bxY1BY6Is59N12cEvPbq39S6+/ZrhNPzFFwBGcwUAP9QqNHRWzg7q7l3zRa2fyLW3kd/tnmkHxI/KzAh3I+DpN7hMSCSGLxAP/EXZECPSFJXZozU/j7TNOVz2V6/0zQ4Hou2X0wOQTm4YYAAhP0NbySqGfiELe+prKREUQbz0t1gumErZR9LShlqtqJcoKuktLSdzeM9hyGHRDoRp5CtyM6/eeozLGrYGUs7Vr7W990j/oU55C+HcnyzuUbLCRhK52rj6RH/BQVg6wxDlLCzQMprqqB3ppOArzUDPNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDVOhECOp2rNXIWZRodUPZUXiHe20oSdJYjkLgQXtoA=;
 b=CPmMH86yMiEtxFqa6HBqHjktZM5SzWgY5oJ7LvZDAYX320eean40nvuMLXYyYQXKLQphbDLd+KVuYmGu366Je+3ZUsrgAE4evWlqv8LQ6BvzEurksX3O2Ck+AyYVWcs7yuyMHzIHD+JLLk9Hj22E4GFW3NmoSYTvFqc2G23sMgcnLtXKhAtQdQ23cm/zg/pB58m1PnZfUud8J1z9tM9IUs2S876kP5hc0I086ZOoo7qSp/ipJ9GD41LrlFs+DkhEd3qNBOs6I6prSBE9d4YAVIWd562aRxJ3aEv7LkEgOOPI+mU+nDBZysKyieeXxbEsNShWX23AuDNJfZvLvzbzlQ==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI0PR04MB10461.eurprd04.prod.outlook.com (2603:10a6:800:216::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Thu, 15 Aug
 2024 06:23:01 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 06:23:01 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: David Lin <yu-hao.lin@nxp.com>, Greg KH <gregkh@linuxfoundation.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "briannorris@chromium.org"
	<briannorris@chromium.org>, "francesco@dolcini.it" <francesco@dolcini.it>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v2 40/43] wifi: nxpwifi: add wmm.h
Thread-Topic: [EXT] Re: [PATCH v2 40/43] wifi: nxpwifi: add wmm.h
Thread-Index: AQHa6kE6j/gZp6A6LU6lI8Wv3luu3rInIIOAgAB1deCAADe5gIAAE+mAgAAAr/A=
Date: Thu, 15 Aug 2024 06:23:01 +0000
Message-ID:
 <PA4PR04MB9638EF979C1C2B37EAD4C08CD1802@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
 <20240809094533.1660-41-yu-hao.lin@nxp.com>
 <2024081430-derail-diocese-78dc@gregkh>
 <PA4PR04MB9638C1186FC4D56569D7D0E4D1802@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <2024081523-curator-pronounce-4619@gregkh>
 <PA4PR04MB963855F4620A2E2C48B2DC2CD1802@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To:
 <PA4PR04MB963855F4620A2E2C48B2DC2CD1802@PA4PR04MB9638.eurprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|VI0PR04MB10461:EE_
x-ms-office365-filtering-correlation-id: 0c8e8f1b-9b77-4895-8ee1-08dcbcf2b6ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HhNE9RxfKuUYhL4qhhlsDSxYlSonTfBjIIP8a3iYZIwgPBacj+A+qhmHZHda?=
 =?us-ascii?Q?+yQyMF0r6cJMlMhLyObHUYTvtS3/TDdmShIUK7AQwXNBIwgOFrT2OG7DXq6F?=
 =?us-ascii?Q?XfFIIqjvOY2AxtpbBIR3LuyapuTqTdEYaiXuFaIzRfJuhZJAyYoZVsFMVypG?=
 =?us-ascii?Q?+NnitOb5mS9pKIDXbEB7Es156IupEjL0xEC62oWPhpdbW5aiIvVgBpr143nZ?=
 =?us-ascii?Q?aDpYLHoc4xfHItbHKxg9/0cafzj4LSs/+sdYeOFftJs49hURSmfru4zpvnVo?=
 =?us-ascii?Q?Mr9/Fuzqgoi6nxiT6bwOdpjoXvxdBwdWSyb4KbIgRb0MZ4zYPeTE2cgqqhKQ?=
 =?us-ascii?Q?3ii5AFnIhS7MT7PdFQwFBWerFz7zb8hMS17tkfpOouFX+0jJUIQPWrtncErH?=
 =?us-ascii?Q?1CCgdJM65klmCItP+pA8MQpdwow+gBBC7nLYLs/GubVjfzPnNZgxElI0Edvi?=
 =?us-ascii?Q?2R3qBlJPkfTXBCQIerfVpo0xT5YllEi3sHCS5vegmt0GgOcl8tc06LTX+TNU?=
 =?us-ascii?Q?/Ma+2Ow3hdXiBsfeLGaGURB6o2mI5mVnjcZ+atd7aMHPiksPj45BvoQKMkWA?=
 =?us-ascii?Q?8oSbOMft1sop/uAFBBvVH1N5dDn0kGK1afqeBV28xKObQ3ypkEcElvAoRHFL?=
 =?us-ascii?Q?FYgm6JwXKXzAC2wSFKRSIueM3BALxzxaGnmcMRRVBNa2q5+ylXkS6ZOSLDDE?=
 =?us-ascii?Q?5EfcRUMG6JTHaNPBRTmLzArDYgsVolTCtgNja3T2/SlkyB1c9PA6S8CIK5ju?=
 =?us-ascii?Q?HIgukc8NON7jeWmpCQCJgFowe2/tou4tt+P+gXA1fXRY9TY+nvUPplVAMKTr?=
 =?us-ascii?Q?ZUIlF481KEalus66Xv0j0+wpK6EvYWRqI6KSFBP1W6z2hSB//hr4ZhSPOjri?=
 =?us-ascii?Q?VQ8RDF9hY5WzSJSiU89JN27Jr8bk/faInmPY1g2wKfkMwDF9N4PIz/4KHIkM?=
 =?us-ascii?Q?D3qAsfApzoYXYekPM2UvrhNkZaX06a8RGU5Mk1Hijq5IQ/a1JQrUEhjNSQx0?=
 =?us-ascii?Q?9PkhNI+N00HZEIOUJWJP0hYMx0CdC7FCCImeKr2wqoHMAoY9mbJbdo1FR7oI?=
 =?us-ascii?Q?KMrb/CCyj7cC/8pVHTxI67ti5jE4mlwfaxyshIJjfIdzC8wV/nauQHGr7crI?=
 =?us-ascii?Q?+/muQAbmBz/jlT0qtzvT6708L9dUVpWvfmkciob/29gtB3WuYfy6/uFAykfL?=
 =?us-ascii?Q?U9VPIY0Iymw90eSqYqh0OIc565H+6XDoj4CWrx7RiYWEAWNk7Ieg7vaGMMxV?=
 =?us-ascii?Q?pRj8TERy7I4E+zDqvD4rWoNurJR5Zr5OrMgZoMzF05IgLLxoRFyugrwFT5YK?=
 =?us-ascii?Q?JC6lyxQePpJgagBgRQmuDmbOzcZwbze/b0R2peS0q5FPfa/27VHBpSINykj0?=
 =?us-ascii?Q?PV7T6LU7+eIdDVzvOD1gul6kHSw4MLpKKZNcucSIJpyh75sXaA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?323vixeY5rerbxyxLrHTCwrJDihsao0W1RDX6Lm3X7hj4hEkmitDLqnLo+GN?=
 =?us-ascii?Q?x/H0k+XzmUDoh6KuJPFUa56UDXvn/laALzLv/uzft38UFYGh+JWLIFMMOJCG?=
 =?us-ascii?Q?sBmugeehzIWF3MSEtBwMZDKJiXbPsIe1Yxqw+VwBLNH8meFfOg0HCT9svtbW?=
 =?us-ascii?Q?ZU/YOlze7RJj9epYPxZCkClqmW1yu6Y9vvU5WGCROXsmtX3Z4/9gi2t5/cIv?=
 =?us-ascii?Q?RtRJQWpESrr3eHdik3EAhhnwVsGtxMoBudFFcRM0xel9oDzQCKn/8WTKJmeE?=
 =?us-ascii?Q?3u90khB5gAB1YYN+9/9R7txAHVRDb78BUr6u2kl3ZEMZPbkkCl9EJXAt1Pz4?=
 =?us-ascii?Q?4AD6ltc3IPV41M3vV3wk0LuH5XKFyok2ddutarATRS/7sUsGo+ZsVWjuEfpo?=
 =?us-ascii?Q?UupduiYm9Yw24znfImfihgF/0B6/odrbNRAttEHe92DqyA4v6FHz5NT1MHqT?=
 =?us-ascii?Q?Z3XcidLhncz2dqikuZnZz+JVr1wkuVbVYvYpy8F/1rrU0B+JDB0GKsvGWFBQ?=
 =?us-ascii?Q?RAaIw7c9oHbCCiAk15rzLeTqJ4nNZIoCBsR29WD+Vh0tKcHlk7KcR0GiO7Du?=
 =?us-ascii?Q?klSSd0BUPw5tYJ+t/TX+hdJuq9qmrQjsmTak14WBz5dYEMZEtFso0qXUcmhS?=
 =?us-ascii?Q?x9KkoWRVFtlVidhyg1ku2Z3/EdyzAkvWuEKqLYSYZTOrvFPN9SW2D1uYkKb/?=
 =?us-ascii?Q?UxsAzhYXJTWrcykBCGTUAjzHjXKGePysi1kMUf31w5Cjld7sy/SH2oTYJQAM?=
 =?us-ascii?Q?gPcaaxEGgo8bKjC1JlRSm2gETAYr81/aI6YnQmklXIcrh6VgKWMQfsqK3lh+?=
 =?us-ascii?Q?1gL24PQXoLuI9+h1SIh/uK7mj43Wc03rLJjbIY00nhFnrlz5f/qwMEX63rGv?=
 =?us-ascii?Q?hg+LVBpaK/WDtddGNMPZgcZElbv+5Ptv9zToog6FaMMwm3BxOT8Kuel3zqFX?=
 =?us-ascii?Q?Kd9hCac0BY3DBLN8Q47clzD4YVNZOKjkG0AbvNSdY4fVVZYIw3QNciB/iPnQ?=
 =?us-ascii?Q?MaqvDpnB+ZtdAr+82hY69opuN5t94hcHDT9wlOtM1+6X62FXnNK4nBlnOJC/?=
 =?us-ascii?Q?vjx7nymkRz8l3UQmPAulUV8s51caY3YKDP9vu4ZlOPWWeQj0IjuxdplZFgPk?=
 =?us-ascii?Q?ZLTxkP+FRygMGbWnyzEtHtsKSwl7MtlHRaq0dnviWg5w4fXKp1CgeHvdrKC/?=
 =?us-ascii?Q?zo3Lusx9bsBfocN17/oy7Lu3gViBRjK3/2puNSgUHdNCARZ4oC9FATvl4EZ1?=
 =?us-ascii?Q?XLiKPMyKla3kI4dLmy9xmFCAc33cM/WBEsWkFBHpkVYQ9ziiI9kQ3HJ7+1kA?=
 =?us-ascii?Q?u4M3TCeXynk3cokblWLkoSEdvTgErFpwox8DtVj63fgzh0+VhyuzTCVu+Jzh?=
 =?us-ascii?Q?BnhCNrWGI6Q/hZNSPwoTxIJny1NAQTfoXw7cD4F3+r78giC5MaxDhxe2SeQz?=
 =?us-ascii?Q?XbtWiROGvcu7z8TxNlZe0pzh/gQ5N2vzsomGLh39p0XDWxO7MDGQKUU29C2M?=
 =?us-ascii?Q?OfcGHt43huFCQ4teYNh9QG8GESKEhDxDbuUtALhDDUdvfarbMOPbnwu/CjVE?=
 =?us-ascii?Q?ufzJKiGwgSSsXhLwZgC5F21lIN0ZaKnDzIlt9axi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8e8f1b-9b77-4895-8ee1-08dcbcf2b6ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 06:23:01.2423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dzti7JgaH7l7N4zJ71Pr+N9X+ajWduIw1oiSSpJIlCTkSYdJDXHbx/kqOIacuoGEAVnV+EMocvd8MJCRAl+rsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10461

Hi Greg,

	BTW, this is new driver. This patch series are not changes for any existed=
 driver.

Thanks,
David

>=20
> Hi Greg,
>=20
>         So that mean I still need to add description for every file, righ=
t?
>=20
>         Once if confirmed, I will prepare patch v3.
>=20
> Thanks,
> David
>=20
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Thursday, August 15, 2024 1:08 PM
> > To: David Lin <yu-hao.lin@nxp.com>
> > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > kvalo@kernel.org; johannes@sipsolutions.net; briannorris@chromium.org;
> > francesco@dolcini.it; Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> > Subject: Re: [EXT] Re: [PATCH v2 40/43] wifi: nxpwifi: add wmm.h
> >
> > Caution: This is an external email. Please take care when clicking
> > links or opening attachments. When in doubt, report the message using
> > the 'Report this email' button
> >
> >
> > On Thu, Aug 15, 2024 at 01:52:18AM +0000, David Lin wrote:
> > > Hi Greg,
> > >
> > >       Following the guideline for new driver, it should let every
> > > file as a
> > single patch for review and generate a final
> > >       single patch after reviewing. I think stuffs mentioned by you
> > > can be
> > got from cover letter.
> > >
> > >       If I misunderstood anything, please let me know.
> >
> > Please read the kernel documentation for how to submit kernel changes
> > in a way that we can properly review, and accept them.  As-is, there
> > is nothing we can do with this series at all, sorry.
> >
> > greg k-h


