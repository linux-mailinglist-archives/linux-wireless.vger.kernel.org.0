Return-Path: <linux-wireless+bounces-12730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE738972AB3
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 09:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A499F1F256E3
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 07:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228C117C232;
	Tue, 10 Sep 2024 07:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fl/iJSM2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289F51531F8;
	Tue, 10 Sep 2024 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953315; cv=fail; b=egOTfkg6Ooet/SGrVFlQlYif8FRp/NWAFk+6h3CEtYlMsTsfMMixHvWb7+09JvMU89qrhd6nDwdlnjqc7pbztLQRp+DdM6gI4+PkdE57/lQXzSaVw5WusjKLDXlCnVetdi8PQJnw/J09Uao+py3NACi7uqAU52SkFxvokfK/NEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953315; c=relaxed/simple;
	bh=3huIwUjA2lxMbafdvY4709nlb5+L+Nh9voyUepap2d8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xi3bohohUMj6lPEMi0Ng89XtzvH8T6Ot8HeJvrQzUE6oNmXzXg63JZ6nVT9VSTsnsUJyeayjRAWC0xGbK2X0DlijMm314g1BvpH+lNnSKZGQdEUmP3Xx7Ar5jjkpibDga5v9dk3IQaUxBSHRvs2H/EC/d3Zyk+kCBP+FqC8G1WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fl/iJSM2; arc=fail smtp.client-ip=40.107.21.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdjJpx3HGYveGUb5P4VRM4xQOhhPvtDFTeWGHz1bSWlI1WM3TLmUacf4Za9l7YJj+S768BtIfyR3OOViQyxMbQwjWBoQIylEd64SVssEn7ykyxEw84F6i5ozi/Yhq7femdIQJNpLSTVagpqSqFnXYYOynIVmdchS0RivnM1+9EDlHbGVxKgl1Tyz6ArD9eZOKAa01RnMuG5d7HWPApeWnq/qWBgFinwpnHUGn2mQRb5MCGtgW4HUa1JTijHArEUFRftn/DjsUwazhqlYv4cD/wR/IlstxZEzauVKTRVT4ISSW4m4x+rwfkBKRllFbiktDaWTvImm5H/ocFmjq7IKdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3huIwUjA2lxMbafdvY4709nlb5+L+Nh9voyUepap2d8=;
 b=lrukGKqKBMlThHSAdDAz50jzgxG871gXpoaYfQIDC8FuME+pJhjARlvN0Txt71MOJqqTe9ESkgGMTz3/5YCw0ZuTz0EGvD8IUFT/jwdOX1aPj04ofD3Wwy9RYO6lTbRDByZY0XuLhNgRlpTkoFlVJUbAPWzUcIWbdYmlenOyW7o9hz2ETjT22wrp6n7Hl3Z4zOh3ba13LCfJjiJN/P+E6JL3DQjnDtozi2snqX7ctECeiTMujsSlFdt7ns/e1STLsEXTJyhEjxhQogNq5jgctjSerYxSsTJ0wBS0ISNKQPoYhCqg3GdjIdBwAvobK/2umE1qh5AheCXtjvDFasPyBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3huIwUjA2lxMbafdvY4709nlb5+L+Nh9voyUepap2d8=;
 b=Fl/iJSM2OvZg3X+W5EdwpD5EXmhPOoQzwehZvCarcq/GtByf59hEmzEmUZU6R82bCy+8Q4MbhKxor0SDjAtUF9gpzGJDuI4DSDzgiK5G26gbtxNrWwk6RluwjfiWc8FFJiUxMl52w9D4E4GVAoLCggh3n9EVNlA2dwXqQr5LfpA3yVvGMlaDjm9sXy/yYYMqA0MUJq108yaY87j3w4KPLl0cuezscT5sq/X1ZhAZlCS5LwbqX8RaRd3IfYZ3PQJbyPbqE/CFeIV9KyXcvdZchVGnjXUJZ0x1EZ0pO5Pc3oWJuwkNyma0c1tREkklUufHgNgS+tstuw8iUSdZVh2VoA==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PA4PR04MB7918.eurprd04.prod.outlook.com (2603:10a6:102:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 07:28:29 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 07:28:29 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA running on
 different channel
Thread-Topic: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA running on
 different channel
Thread-Index:
 AQHa/RQwZkxE7S8BN0ebi7x6fu8g/rJEPYCAgAAPeUCAC6fogIAAWbHQgABDcACAAAAqgIAAAvAAgAAC0XCAABIlgIAAATdQ
Date: Tue, 10 Sep 2024 07:28:29 +0000
Message-ID:
 <PA4PR04MB9638D57A9623D1B33C802EF9D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240902084311.2607-1-yu-hao.lin@nxp.com>
 <ZtWHhSQlPVMekW1I@pengutronix.de>
 <PA4PR04MB9638EC10C0B656B750D922ADD1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt9blTxk88Opujsk@pengutronix.de>
 <PA4PR04MB963813D69B4D87B7147704A5D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt_fZEJyiCyanf7X@pengutronix.de>
 <PA4PR04MB9638C8978D9C6360A9B214E4D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt_h_mW4nFWKu2SI@pengutronix.de>
 <PA4PR04MB96389B2CC16060957878D0D3D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt_zkxGsY2X-8-4z@pengutronix.de>
In-Reply-To: <Zt_zkxGsY2X-8-4z@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PA4PR04MB7918:EE_
x-ms-office365-filtering-correlation-id: 57665d6e-0f99-4d0d-41a8-08dcd16a2ae3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5yegs/Qp1TsnwLb1Xuu5OVrR1NA/Lj+FpkeG47SETb+P7yDzyFn8YJN21sAB?=
 =?us-ascii?Q?e8LGrzNB8cBXaGr9nTJU870owict2Y0u6xI5Vk+1kYPce0dU1kgBcBwWSHoA?=
 =?us-ascii?Q?luc/sGcDm3Y66RW1hcC8hfyy7oIwFGwSBRPN2LG4fdvbPvqt7FY067xXESO/?=
 =?us-ascii?Q?VTaNQ4Az1cjvc3/AoBc80+NCLOWXOxoo416vMOoLW6jV+DUCQFBYGiQ6wXi9?=
 =?us-ascii?Q?KGBN1JbKebjybNBChcxuVPWaSrrO/WeN49BsC/gO+tktkxShU4L95K5hsuSj?=
 =?us-ascii?Q?c92b7vS6BRiKpjuLIvUTp1Aqdmt/5l+5m87Cjp2bCBfvSpYbgY25ajKjYET7?=
 =?us-ascii?Q?WIpKfk5oqaeIP8A+ctRIBH2IFhwsS8DO2aUo7dB6idmBQ5SIsefB6zQhUO+o?=
 =?us-ascii?Q?I3NFgJPRrXs+znD6pT4z8f6iyWX4hAjqemT3hekkMf68FNHGTWFG+VQuiyre?=
 =?us-ascii?Q?rf1dgt6TQUP7NYaKwb0n2ZhMQHhD1h+wVOFCIsQgAdXHnltHSlbysePAuN09?=
 =?us-ascii?Q?j0TgsAs9ss4o5pDguwAo8hiSfrAduHkvFuiH8aY97/lzOLztsLnwF0tWNDi8?=
 =?us-ascii?Q?elEsDCb5S77ftCclyEPArySzooegLr6zKTTRkomczYUuvxCrtiEWgQ2XktyL?=
 =?us-ascii?Q?ZXG8nujzrOrOwK7rjHmucm+vP86sF7Hb5QsFRxyM1YZMVWgVWn47sDPtP5w/?=
 =?us-ascii?Q?n0TEZ2my4MHqWN2DoqZ21oKLmfxT41qB3NXEyYL1kfCJeX/Gtyo50LUYUOHS?=
 =?us-ascii?Q?skOBP/cVx6qx9WPt7xqQyfEWDl4ng1y0r8OM3v8m6gxwxaQ+fQd/EJws4Y/2?=
 =?us-ascii?Q?UxrW4nvS3+xrJ2Hv+mK5y9ojY3xrQ3xghAIjOdPoBHMFvClvDN1zBVD9ha/t?=
 =?us-ascii?Q?Kzy0L5UcvuN9yBR5f/vYFRqw5Xy9+n04yybAYqlrFC56lo58fBF98r7bKHBB?=
 =?us-ascii?Q?ZA/lzrjXOf66G89JwRlMiEFCHf0b0tm++H4IxAlTYLlqxTYjoBelWg4mw1Yl?=
 =?us-ascii?Q?KyabYlQQCs7ubEqaYMqC/z5qe1tx5w3Qb0XyYsgAe5/ch1ppQM715DPg74k+?=
 =?us-ascii?Q?MiMXx7ObqAJApXIyYGNgkBLtE07gUdnzLX+seP3v1f24wgKw+1Sw5L/alMkk?=
 =?us-ascii?Q?C1ZllVQ7wy3fbmEtIwXmgGJ3h3YFYWZ3z8B/EsfQY2p0WFNO8KBadpwlwfu6?=
 =?us-ascii?Q?ypkzh+BT0DNCg3BNIRUHVMm9xkbScH16/TBQo/pbqpcQ1K0PuZNgSLGX30pM?=
 =?us-ascii?Q?15Bdy/00SI2hVE0XzxO5TUK9A+T778R7/aIDH8a2zdTRSeBUhIliCkZGPbP3?=
 =?us-ascii?Q?MPnAHio9BGIGC308bj6gDrMvH0bqrg1Mj476eF/G7EA1GyUfn6QEyTNB9+N0?=
 =?us-ascii?Q?7f9k3jE0rL5qpGe0VZe1qw3RO0eyxyQpQtZoZpIOtpXpfk071w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MMNlxtaZF9wcSs/bKU1h1NSBNUNJbY/4wixXOM59HLSL0oxc9TmSGJ+X5bRw?=
 =?us-ascii?Q?nu2lrHXnQhoAmYtkjJwqgLarDd1ddsnMyI53J4ItHpsh8EH8phUHEiOgaRec?=
 =?us-ascii?Q?riuc9dOjNVuvvaZ5V+VbwSagiqGdTPXmRgsaO2m2IV1bPOhSCglMa/HW8xoO?=
 =?us-ascii?Q?zSzpu2buzD2TaczWkEN+AXFW3c7vzW5jodThQRIA8OoSqlq6/5p1wqzFTNpp?=
 =?us-ascii?Q?CVX9EyNVBx6lI4D+2OtYCtOuw7RC1Zo+N4fznp+PYAR3MOsUjsaTOKg1Q2zl?=
 =?us-ascii?Q?72K6j4iU4/qqDqcMDuD0wgVQXcF+vcN+XH0jdoJ3grdSCxVI3X/ZBY3Oykn8?=
 =?us-ascii?Q?+ZkSegCAWq46P4QHwSZ6lIuCIPpv+R1gT0ge2g7zGcL5KFhW7fylTogzaJ8W?=
 =?us-ascii?Q?DxbqBO7HjFNpjjvG/sSSxXUnY3UUaynd0/atTCrS9XvXGmpOUmZP3tjOtLUI?=
 =?us-ascii?Q?asjfUTZjoJY8iYkTcntd7NDAdx2JynBjf/Q44LOLt82dYeze3dOGweknmt1V?=
 =?us-ascii?Q?KbJFeF1vRTq7/83F4dsc2MwqOz+VKwSFm58ilvnDO8XnEKNO1YHCjBRqymhL?=
 =?us-ascii?Q?kfMr3QTJ4Dd40Z6sXGNkIa/9MjYbalPc3XKxEY2/A8QSVHGtBng8I3GgCXlm?=
 =?us-ascii?Q?UVtVfNiglaUVhqs/tp23uQ6d1Xqxo0NFAbl7fokBbmpt+MNgyGnwvEm14RcZ?=
 =?us-ascii?Q?kx0HeaTU9iCruLHo4WWVNI8dW4s2pP2XKcle0nWbtNlaAG3D+oz6wD6SzNvX?=
 =?us-ascii?Q?ZPppwFaOoWlzcMmFfO1fzdJqyAAfbK+zHlpPtHE/rIyOYAiDPI4v7pMyFELA?=
 =?us-ascii?Q?EUBQyIZXWIJfmi5BZQLvBfq6+xzut7W8c7TkcyLPsJWNqD9CISdPFswFTENO?=
 =?us-ascii?Q?xboDl0ManCGnw24oPwPYPl0HFw2+mk1GlvJkbtU4hmtVuGfkX7+VgDy1c2km?=
 =?us-ascii?Q?a4L6TLojIxzJQOlbVUJyPHABGyiQN7E7T/7IU4Q/dPwbLWM3mFWefzAJmlOR?=
 =?us-ascii?Q?IsXuE6o9YgpAxmgD7TCc145syV8gmgHTv0T4acDcJzFVQUF3jRFs2gOpVnUx?=
 =?us-ascii?Q?FkrGovUuhk/w4zR9g7QB1p/yBrV77SsO/6VZ6CMt00xCWO855ExrqybVicKe?=
 =?us-ascii?Q?tJ6wlB9GIc3Th5/PlRLAnJT32lvqG7jTWQ3d6Z7oNLdI0uDD984WLcWNHsKM?=
 =?us-ascii?Q?PgsxEEhEjqn33xc+nuKlnLJQgLYKQXDY10DI+nLkl9Mj+1+zoEC8zSjWnbHm?=
 =?us-ascii?Q?6da30+E5Z57yWWqJoGeHBOuXed+6k/Ddkb1QgIX/whr2n38z2yr3zXsBoHWN?=
 =?us-ascii?Q?WrksSJG1OCHpeoU5tIRM4+oOHom3jaYo44/4xawg3Qivy+pNxNK/1xlvkcaJ?=
 =?us-ascii?Q?TeOYeJCxaWLzfbX3pEPxacRg4m8X4Ewcvo4W29XwIxkhGESB8mVAwPJB5cBV?=
 =?us-ascii?Q?mO7CXsyuxNzHu/W1p+mACamS+bPPfpGRA6qfmh2wkWWozU+qKOyBD4ZmtTD+?=
 =?us-ascii?Q?00cVK/DmgGSOotJGwXdgM0mRtP5Y/wG914B5xJKktfzutwO8Jdx5sWq3epwY?=
 =?us-ascii?Q?npum3sJ8uCpMAEbxs0YcmjRGtoFTbc3XJx5Wp2LZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 57665d6e-0f99-4d0d-41a8-08dcd16a2ae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 07:28:29.5945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RNXljujpbBhrdGsIomFDostOf2FSF+gsgouxl2UpfeTMfpizjJ1PK0FjjFcpJf4zfTzpSmvOGi0oUKEt8rZDmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7918

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Tuesday, September 10, 2024 3:22 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: Re: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA running=
 on
> different channel
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Tue, Sep 10, 2024 at 06:18:57AM +0000, David Lin wrote:
> > > > > > > With DRCS support enabled AP and STA actually can run on
> > > > > > > different channels with the current code. You are breaking
> > > > > > > this scenario with this
> > > > > patch.
> > > > > > >
> > > > > > > Sascha
> > > > > > >
> > > > > >
> > > > > > DRCS will be checked in the future.
> > > > >
> > > > > By future you mean v3 of this patch?
> > > > >
> > > > > Sascha
> > > > >
> > > >
> > > > No schedule now.
> > >
> > > I am getting confused now. You want us to abandon my patch in favour
> > > of yours, but you have no plans to update your patch to avoid a
> > > regression that you introduce with your patch?
> > >
> > > Sascha
> > >
> >
> > My patch resolves the same issue as your patch. But your patch can't
> > let AP and STA run on the same channel if some wiphy parameters are
> > set.
> >
> > I wonder did you test your patch?
>=20
> I finally see what you mean with "some wiphy parameters are set".
> I did test my patch and I didn't run into this issue, because I haven't s=
et
> anything like rts_threshold in my config.
>=20
> Nevertheless what I am trying to tell you in this thread is: Your patch
> introduces a regression and needs an update.
>=20
> It's not about my patch or your patch, both are currently not suitable fo=
r
> inclusion and the question is: will you update your patch?
>=20
> Sascha
>=20

Without DRCS, this patch can avoid firmware crash and this is the current p=
lan for Mwifiex.
It won't affect any existing features.

David

