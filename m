Return-Path: <linux-wireless+bounces-12320-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D417967FEC
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 09:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14D31F220A7
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 07:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24F515381A;
	Mon,  2 Sep 2024 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PkzV3DKh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010006.outbound.protection.outlook.com [52.101.69.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAA115351B;
	Mon,  2 Sep 2024 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260743; cv=fail; b=lieBdiluXS1UOxgOW96p+hCJnEwB4ywOCK+EtWhkJ3GetWmtgziMgi57TCLzmu3573/c6TAjuQXDMPN23LKiXTNrj1zG79HcrYwyBJpGj4fwp9ypzJfpKkwLsJ/naHMUchfUP/CSCSJSo896ZCdogDkruaaG8Vbk62uxTToI6oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260743; c=relaxed/simple;
	bh=n/BYRq3e+NYe33biHb77p9MeAP146KTdI9aJGMKktvI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EZEhIIEybdTbmcMRz3VDLy62FZ9qStuc+PTwcKTiVJ/NTRO+X2pRZFp8h8hWGfmC68We5YC2gbe/BC1kvAuvoPjpL4YQuzu4Rcqkuj2AqgE3KISzg4Fj4odyPseTLvq07+h2JGjw2P843+Z2x8H/OYMeP6HnYdmwhh5s4Dw1D8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PkzV3DKh; arc=fail smtp.client-ip=52.101.69.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDLoQE2lJjkF1rDbbQEe5kJsM807n1f5ITS2lbM4R+TfZvPJWW//EnFIGVQBJ57w67ww3yXiXfT3+2uHuUbwS5RYUCA/obh2dTC1XGQV3L06lK2AV7B2J7lzYjQDCzlnQaxQrlK+jSOlXcaw4VkbeddQ51+HVqPL6BOV90/BIu0sPmE22ckxII2BPTo/UaBQYJF5JDAzx87v2MpPfv+SUVsyrVjQRsZYMqMDUAIQ84Wl/A7jAMCFFvHhX/CPJvtUGScKSdKVHK2yOyaVZi3nnX8C2lNIjcoDsSATRQG4TRzSvhbZCtN6MwxxHROwOfaLtO5HOwTZoWB6XiJHj0zI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMUi6WQwKCny2Gl0v2PWXNC2155GWPRpOFZhKVkqrtM=;
 b=MfnyAkJMHyH8zXYkZdUb6/0yKc2ByLTECc3HTSeXWAFRD0fmXXZuZn20Ace/yFAXbEzRpQMOEiC/sVM2o8i1ELTNfSyidTa2tM1iVNq5tsEgef35SXq+QYkcGyuDba9Dao8fHOUfZT51sworxLK5VvT0HEP6t+4ehf/dqrNB3R+GOdn7CMylkKtZ6cHCXpXrfqTKok+GG0iGBx9ut3A/FXsNgYloY6HtVxgpI02Jbc74ulwu4n0ihFFVs17n4RoA5KcdRejy0jxSba2mhDzbNgMahI+7W4dyByS3YZuw66BMW4qwFhHgl1hrss8Azahobx7Eh70+R8uptrI5rTLZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMUi6WQwKCny2Gl0v2PWXNC2155GWPRpOFZhKVkqrtM=;
 b=PkzV3DKh1c/KeBNnbaHEILP48zyIlWMFEzx8wMsdvzjBMZ+U8h0BnwKDuFMAsM/DR/pLDKOxSALLGwkpqXG7Cq7nX1+LUoWSoEuWxy4mkmxQGg63xathvSkl8L787+hVN7I8TxDJNyEI7xzkx1bcjq1A9c0uM+IiSxvn5MTAgRAEMOSbPJC+6fOz6gm+0t6hj0FTN29Sf7ZvaRQj5NfYBdpeJj89TfsKC/S0Jnl53+9cEmrRBuLZiMso80OoiuAazUc9oGw6qNQmSUkPIqpnbzMUerxNXawlPLYzagnjBe8Qha1sQZaiSmZIN8kZZlXVLljPXGLV+STabyEx7aPoQA==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM8PR04MB7362.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 07:05:37 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 07:05:37 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: Francesco Dolcini <francesco@dolcini.it>, Calvin Owens
	<calvin@wbinvd.org>, Brian Norris <briannorris@chromium.org>, Kalle Valo
	<kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
Thread-Topic: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
Thread-Index: AQHa94lYwasmKIL7I0OVdvDE0AaRyrJDyhdAgABM2ICAAAJRsIAAA1Jw
Date: Mon, 2 Sep 2024 07:05:37 +0000
Message-ID:
 <PA4PR04MB9638451FA374CD3B5BB86A4AD1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240826072648.167004-1-s.hauer@pengutronix.de>
 <PA4PR04MB9638016F363BFF87D62B70D1D1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtVd3__wfm6EOOgH@pengutronix.de>
 <PA4PR04MB9638CF45263E713203A53EF7D1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To:
 <PA4PR04MB9638CF45263E713203A53EF7D1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM8PR04MB7362:EE_
x-ms-office365-filtering-correlation-id: e1121cd0-076f-4948-bc4e-08dccb1da5c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qd42xgjKK0y7bZiRSrxjpdsCR68n0n4X78aP/Jn5zkHNwH0x2nDq2y5O5VLV?=
 =?us-ascii?Q?Py3zSem9xmweOT9+BKdynUU27IKmbvyBymWxlSn4VZnAm2ZmkCgDg74XsN2a?=
 =?us-ascii?Q?8JFX6224j8P8ZTgGmgGkonyuwxUpD8xZUAa7tRH7chivfksDtj49NaDG4D0P?=
 =?us-ascii?Q?67iNs9rk5Y+4MUG8uYoSNqsrh3I9+yZNCcYVYYPSAhfxHTXgM2yLbPgvF8nz?=
 =?us-ascii?Q?e6a5mBzAw7gSazyCIIjWuclttJ9UoX0rkZm0tVkTjnAZffxbBLfnMoGxRK4H?=
 =?us-ascii?Q?M4k+qlEjt1DcMh0EbgH5S7vzL9dtTrG44pzCiNHTee4Z9HMiJu9Y9pqi6ryf?=
 =?us-ascii?Q?efsvaVEl3iW7UmLnu+AQ1WwprAVv4AYUW6e6el6Qav7EzuSc8JUtCooDlaFr?=
 =?us-ascii?Q?cxQJBECMk3yr3ogvrUiz6DJWSQwUkYvpisA3NRLJ5k+GUZfh3pmCbInDpGfi?=
 =?us-ascii?Q?fMZXNZ/v/Nxy4vgY6O8AV25g+fH7T3eTX8vwTGPIlnT5kUG2+LjrgUp8Cze3?=
 =?us-ascii?Q?B2F/HoumPRvH4zHlvaQ5c/Qv3kVX8foKJ23AyemoIO5YEddHEP4v09ePLdyR?=
 =?us-ascii?Q?bqZHWV+UkwMgDN8cCNSJYyy966L+PL0097MYQAXs5tim8pdqv/MI0eC1oYjr?=
 =?us-ascii?Q?SG8fY+BMdgyXcuj8ToEF43ccC/h7OB12tLzPsszgAvGYW4L9e87+f+GjQqTK?=
 =?us-ascii?Q?dSAJ55UIvD2X3TcJalrzQlYxcRMcho/5bx5lGGgIc32321fIB0/cQDVEBhsD?=
 =?us-ascii?Q?nX23S1B6IIH0hDGrHsJl3HAJOq+8nOarvwwgvFrGW/vkg1SAtkWQ7KDmWUZQ?=
 =?us-ascii?Q?bNb+c1h0igxysIN8elupSBuJZIdTLY4UeOJK8LUboVh5b9sefVF/Hm2VTM/l?=
 =?us-ascii?Q?D7LXFgz33P0oz7dGtOVWtQ8g+K5xR7qUx4neKsCp1QwZIL6awKiBoa2w1avR?=
 =?us-ascii?Q?C37vSbWptPBDgU/gZ7saWZPOFD61Gh6ED5uthCvW0JyEO+FCAtTwCFOX1wd4?=
 =?us-ascii?Q?kh0KPAGa+bDCETo49HoNJIeWhS+0iLcu01RgTXPQvMn4RplZPU+OzLgzpxAT?=
 =?us-ascii?Q?BPEQ1ZONsAtmYNZDSVao/baFnyUXbR+qAMBUCBxf5Uq+bteQaynKwDQgBP7z?=
 =?us-ascii?Q?sZXetxb0FlJqKQT79LPshrDIWksTdXd7Fdg5iJrKEaX5SHhzuCz0D4VifWnM?=
 =?us-ascii?Q?Y/q62ay4CA3eEXkg+tUxzOE4C/2p/68+jpFroADGRpbaUStpwNjm/hS4gubZ?=
 =?us-ascii?Q?gffZ5OSG+OsD5PNT79I/YWqsRghZLSNoXjhl2ArLsJv2sfYyOLfzebpe7yH8?=
 =?us-ascii?Q?GamudQe4G1xdNdMlNTgHUa225cVL+5BhBPJyMcSaADleWg0cxHzMdYBpXW3H?=
 =?us-ascii?Q?a84/RIw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rrptRFqRuS57e15knyMTIwMYj793D34tz2HXLN2TxOIM+UUTZw+GQJ1ysHJK?=
 =?us-ascii?Q?Q9KIhFpFZYadQBIJNkUpEeFgwgqD96UTK0tZcKZflacvmUg3l93W06IzIXCW?=
 =?us-ascii?Q?EMteYDxBKbZGpyAMZJpDcNOFw1/VXCcOa+e6lupuBwJZxqhuIChLDDPR0tF9?=
 =?us-ascii?Q?j8EmrWgeK/5RITI50rVfJSOwYXtvOVMkFyEMlAQIREbWu+JrqkhMIXrDdUAB?=
 =?us-ascii?Q?/tnbVMwtYISFivk59IQl6hzeoLhub14KXWbZphkWkObgynSrL4qPM3tIN+Qr?=
 =?us-ascii?Q?JliMH02Jcice9kDIBTwhtFs3LRRgZJxWigTXdFBoifZvuMDqh+aECnCN253S?=
 =?us-ascii?Q?k4mWO4xxkJ5aLFOsvecLVeM0Sln6FChSNCsb6TwqnCS//OoLZ+o8IItq+mgN?=
 =?us-ascii?Q?DFg/eWGRX2ni6QTy3ZAzm7NF6fABBfzccRqkl/KyJMwnw0EVt+MZqYGYdQGb?=
 =?us-ascii?Q?QXgm1Y/7TV+QFxIR9OOPYLOJVpnQl8TP73+tQTNNmzb1ueENth9FMS4fXnNN?=
 =?us-ascii?Q?veMIZpzwWDIDutVVQAL++jSWTIiSOLtHD7ckL8oRtRS3qLielCbFhn3P3k9y?=
 =?us-ascii?Q?j4eb/weLCusXphJGA2rXlnNDunX03TcLZp498UsogPxGynrjPKhql1npSJws?=
 =?us-ascii?Q?VaMHQjg+LNGHRHQcsuslIya75TSxsEr1BcQw1lY5LUgF1EyaXaoQQO+06oZK?=
 =?us-ascii?Q?yTci46e8WcbqIO0gkDssLSQ/dLX+sZslMHqCiKWCrKt10putr31rckWYxvYZ?=
 =?us-ascii?Q?e13LZrG2oiz15ubIoEaM18VzXPn3zAyrcrqHy+ADfABbe7XQn7n+4za1GOqu?=
 =?us-ascii?Q?9qJTR8lFNa8o61OJa29aU91XIZ5J38Uhg/ZJEXziaYFAAbNUpIZaxCmxq2QZ?=
 =?us-ascii?Q?M5WpFUGxqqnebFDWz0JppeKo2lx8bVGfh51pU1Hg2LQsDIgBssOPrNNfQ79N?=
 =?us-ascii?Q?vZB3XP11cr/XbR3Qs0hXk3e4PSHc07ioHSGRpYujQpncn07CCHW/dJWUXmpo?=
 =?us-ascii?Q?vMLPyrAWcNY3tBb0skaLbt9G2wpUzfW5r6B+Ost2ZYTrjfxnLx5Zxj/ABjUV?=
 =?us-ascii?Q?NE5sVW/Fem3H1OIMdfOpzCEsk8YeKGSi63pSM2zLJpVmdStYmQW3eapzihH1?=
 =?us-ascii?Q?VOzIXZvaraJ1m9+fffWHbO8LQoRUeXbbJRizWN1VBffPAsapWXCiiQ0FYDFj?=
 =?us-ascii?Q?OhXrfbplGfZrPVYkfRqNL21j9Go890Lku+shFbLLn/bH/d1bRAnu86/0A84L?=
 =?us-ascii?Q?vId5BRF9DRiVJYBGfP5bz9NY4reHsvfvxYZkPq+EJRiztagCIbB4oRpCqQ9W?=
 =?us-ascii?Q?9Co3aOi9PbUQxEz85yEUiCuEbYjzXJdDdsi4QEFyv3YHJviokEHR8MZc4U2l?=
 =?us-ascii?Q?Scqfvqc8CsgAe71EBLrGWKYoBbdvhTbeJvifvxFfo9wqT5KVLf7g041YMwjz?=
 =?us-ascii?Q?12ZecCIaaa+2Mg7Qy9P5FMlmzLgiCS+2EkCgGSK+VHMjJ+KT1BSX2+cgE1gq?=
 =?us-ascii?Q?P1kRSO/I2H6hvJk0E94ou9gu1to/3jRXBvJ3ldNJ3gIs+DZGuNom9ecGnmA7?=
 =?us-ascii?Q?L7Vi/3vHfDfi6Ha1OsfVRltfo/Mm6AxaPz8xJgXP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e1121cd0-076f-4948-bc4e-08dccb1da5c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 07:05:37.5185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AbB7x1M6VdHrrcah0RduFyXDGYKC/Y/XNJ8gDy4ekefoEyalWPA31YKauv4pEWXkzTd0R0gCO9xgoUiSndeGbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7362

> From: David Lin
> Sent: Monday, September 2, 2024 2:54 PM
> To: 'Sascha Hauer' <s.hauer@pengutronix.de>
> Cc: Francesco Dolcini <francesco@dolcini.it>; Calvin Owens
> <calvin@wbinvd.org>; Brian Norris <briannorris@chromium.org>; Kalle Valo
> <kvalo@kernel.org>; linux-wireless@vger.kernel.org;
> linux-kernel@vger.kernel.org; kernel@pengutronix.de
> Subject: RE: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
>=20
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Sent: Monday, September 2, 2024 2:41 PM
> > To: David Lin <yu-hao.lin@nxp.com>
> > Cc: Francesco Dolcini <francesco@dolcini.it>; Calvin Owens
> > <calvin@wbinvd.org>; Brian Norris <briannorris@chromium.org>; Kalle
> > Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de
> > Subject: Re: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
> >
> > Caution: This is an external email. Please take care when clicking
> > links or opening attachments. When in doubt, report the message using
> > the 'Report this email' button
> >
> >
> > On Mon, Sep 02, 2024 at 02:24:53AM +0000, David Lin wrote:
> > > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > > Sent: Monday, August 26, 2024 3:27 PM
> > > > To: Francesco Dolcini <francesco@dolcini.it>
> > > > Cc: Calvin Owens <calvin@wbinvd.org>; Brian Norris
> > > > <briannorris@chromium.org>; Kalle Valo <kvalo@kernel.org>; David
> > > > Lin <yu-hao.lin@nxp.com>; linux-wireless@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org; kernel@pengutronix.de; Sascha Hauer
> > > > <s.hauer@pengutronix.de>
> > > > Subject: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
> > > >
> > > > Caution: This is an external email. Please take care when clicking
> > > > links or opening attachments. When in doubt, report the message
> > > > using the 'Report this email' button
> > > >
> > > >
> > > > This series adds support for the iw61x chips to the mwifiex driver.
> > > > There are a few things to address, hence the RFC status. See the
> > > > commit messages for details. The series is based on wireless-next/m=
ain.
> > > >
> > > > I am sending this now since people requested it here [1], but as
> > > > it's out now feel free to leave your comments to the issues
> > > > mentioned (or others I haven't mentioned ;)
> > > >
> > > > [1]
> > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
F
> > > > lo
> > > >
> >
> re.kern%2F&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7C6125c51da3704fe10
> > a5
> > > >
> >
> a08dccb1a24ef%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6386
> > 08560
> > > >
> >
> 383160951%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> > 2luMz
> > > >
> >
> IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DjfQ6FQimPpwr
> > nwUo
> > > > OCEhmpSadtrb15ymGiif%2B1UCdG0%3D&reserved=3D0
> > > >
> >
> el.org%2Fall%2F20240809094533.1660-1-yu-hao.lin%40nxp.com%2F&data=3D05
> > > >
> >
> %7C02%7Cyu-hao.lin%40nxp.com%7C184ab4fed58647150f8508dcc5a0789a%7
> > > >
> >
> C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638602540229716119%
> > > >
> >
> 7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB
> > > >
> >
> TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DcACBHxaQvcOqu6ri
> > > > BoAlZDONRlGQ4j5DcglEV9T%2BpYU%3D&reserved=3D0
> > > >
> > > > Sascha
> > > >
> > > >
> > > > Sascha Hauer (4):
> > > >   wifi: mwifiex: release firmware at remove time
> > > >   wifi: mwifiex: handle VDLL
> > > >   wifi: mwifiex: wait longer for SDIO card status
> > > >   mwifiex: add iw61x support
> > > >
> > > >  drivers/net/wireless/marvell/mwifiex/cmdevt.c | 86
> > +++++++++++++++++++
> > > >  drivers/net/wireless/marvell/mwifiex/fw.h     | 16 ++++
> > > >  drivers/net/wireless/marvell/mwifiex/main.c   |  9 +-
> > > >  drivers/net/wireless/marvell/mwifiex/main.h   |  4 +
> > > >  drivers/net/wireless/marvell/mwifiex/sdio.c   | 81
> ++++++++++++++++-
> > > >  drivers/net/wireless/marvell/mwifiex/sdio.h   |  3 +
> > > >  .../net/wireless/marvell/mwifiex/sta_event.c  |  4
> > > > +  .../net/wireless/marvell/mwifiex/uap_event.c  |  4 +
> > > >  include/linux/mmc/sdio_ids.h                  |  3 +
> > > >  9 files changed, 205 insertions(+), 5 deletions(-)
> > > >
> > > > --
> > > > 2.39.2
> > >
> > > I think you ported VDLL related code from nxpwifi and you also
> > > traced our private/downstream MXM driver.
> >
> > I ported it from this repository:
> >
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> > ub.co
> >
> m%2Fnxp-imx%2Fmwifiex-iw612.git&data=3D05%7C02%7Cyu-hao.lin%40nxp.co
> >
> m%7C6125c51da3704fe10a5a08dccb1a24ef%7C686ea1d3bc2b4c6fa92cd99c5
> >
> c301635%7C0%7C0%7C638608560383172495%7CUnknown%7CTWFpbGZsb3d
> >
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> >
> D%7C0%7C%7C%7C&sdata=3D5TgI0r4u2I9Pi1FATJx32Ubn7ufmbYsBR1XkpQLAIyQ
> > %3D&reserved=3D0
> >
> > Is that the one you are referring to as MXM driver?
> >
>=20
> Yes.
>=20
> > > If this is the case, I think you should know nxpwifi already cleaned
> > > up the porting VDLL code from MXM driver.
> > > I check your patch quickly. You ported the new SDIO data type
> > > (MWIFIEX_TYPE_VDLL) from nxpwifi, but you did not port the code to
> > > support this new data type from nxpwifi. In other word, you did not
> > > test your patch before submission (same as some of your patches).
> >
> > I did test it. It works with the iw61x as well as older chips. There
> > are likely details I haven't tested, but it generally works. If there
> > are details I should test additionally please let me know.
> >
> > >
> > > Another thing is that this new SDIO data type should be handled
> > > carefully with other existed SDIO data type.
> > >
> > > Nxpwifi only supports new SDIO mode, so the modification to support
> > > NXPWIFI_TYPE_VDLL can be clean and simple. If you want to port the
> > > code to Mwifiex, there is no one-to-one modification of the code.
> > >
> > > Another important thing is that you should consider if your
> > > modifications will affect existed devices or not.
> > > You need to check if you should check firmware version or chip type
> > > before adding some code.
> >
> > The VDLL code I added for the iw61x only reacts to the EVENT_VDLL_IND
> > event. So as long as a firmware doesn't send such an event nothing is
> > changed with this patch, and I haven't seen an older chip sending a VDL=
L
> event.
> >
>=20
> How about IW61x? As I mentioned before, if you test IW61x on DFS channel,
> command timeout will happen.
> Without correct VDLL porting, you will encounter command timeout in some
> other test cases. But testing on DFS channel will be easier to reproduce =
the
> issue.
>=20
> BTW, it is not a trivial job to port the support of VDLL data path from M=
XM
> driver to Mwifiex.
>=20
> David

Another terrible thing is that driver can't load updated firmware of IW61x =
without correct VDLL porting.
Firmware will request VDLL after firmware is downloaded for updated version=
.
Because VDLL type for SDIO data path is working with existed SDIO data type=
. Some code are used to
let this new SDIO data type can work with existed SDIO data types. If missi=
ng of these code, the porting
will have issues too.

David

