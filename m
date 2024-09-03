Return-Path: <linux-wireless+bounces-12367-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAE19695B7
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 09:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E84F5B20A9D
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 07:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463791D6C58;
	Tue,  3 Sep 2024 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e+d5YeLL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F0D1CEAC0;
	Tue,  3 Sep 2024 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348964; cv=fail; b=tRM6uR2694+ft5MRTFN8yA+DdYBz1xPJN4Sb1gAlkJAfJKqutF3xoFcVUkTFYC4Q93oDgdq9w2iGctGK3WIgdmjFUpfMlGQUae9vH2Ywl6DhWQ3FI0/VubIDSwWbyA2nz4aMvX88Atnutc0F7WSmPMhsrzNNAm2dO9YyM3P298g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348964; c=relaxed/simple;
	bh=8+zMhcx+vJ73RJHJPNjrLOop2DwqOWHJoMrFCLpE6/0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dKGg/NmQ8TDY5zF03/522WZqL2EFkWTUwUv1ljcXwhDgZO3jlx0Lxk4Co7V912RJaQIcGX7vBFgDUhmJBu1zUIlhDPloUm6UWMspN2qSSCg06LlYRahF+LyRambJQLJGJIs0sRfIx1B4fESDsJNq+BmAFvVve4Vul/ZmwwpANR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e+d5YeLL; arc=fail smtp.client-ip=52.101.69.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fD3fINtRzxZPnruVbiXtp9Mvy069luAb8rINT51h0mdaoi01KGXiTA+ugDZf6ifBpglzAxXBYID/9Y6xSWS80ehmtBDtJ6djM3RLyjauKNvocTG5TXbXMbKbdsD7SpZqpC2D9DwF+jRUlipKzRSKhcBVSMX/bntVMA2GKvD0EVdh/eZdp03IQIopI6JlXS8yNW8zC7b9s1EGjLPs2fxiD+9TU1t06EDCXWoMnQzytQ1g4q4vBfbLp6gEgyHuebYspTDkle/RzUGABPu5MyeLNR8w2apXrysIckV6ZsHy2OBjqwiJB0RdX1lESc/cLbrrr24Kmxm9M/iazNK45NQeLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+zMhcx+vJ73RJHJPNjrLOop2DwqOWHJoMrFCLpE6/0=;
 b=wJkj5VYPVdusaQF70iF1o3zMdV6lJ2YyMJcDUXXvLYZ3y3F8/YhxIFCcuhbW8H12r9qHK5BKPrCoqqo67UvPlYOrmLKvBRGNwUWWk2d/r69klul/JmC1RE9BDNC/Uvb+YDt4UfaXQVeqvv1peul1ergLKjgI7vXFcfmb86ygToOGEDgZrWNGcG1GMjOZwpVqlrXlI0Xe/DvE0z2CR2IgWhYet5OY6HW9Z888Wq4ER2bG3uRxlvYh206rC9OoXPtzwpWgoeuXjtk+4SMi2eDG3K81QZLAsNp5o5y5khkstQWUmvrJzJJAyhw6vYkNr1nn7R1guVvw+G3YQWDDub6ARg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+zMhcx+vJ73RJHJPNjrLOop2DwqOWHJoMrFCLpE6/0=;
 b=e+d5YeLLSZ2k1DHio7h1BTvHmxW1HR5Q2i6xh4Ux9bzqLqNcsmdmSVVNq6OBcC0ZcmBxRp9hYkFJuXlJOq8cCrBJr49Iz49uQ/mzyz5dkyNLg7duQwXa5lJpskQBxbP4IpFCt1odPQ6MLHKfuBZKkpdAjW+pXriZTt2AlBDaCRxj289xcAfvKRJDqaKeSiDExT0hcBfqmuBH6FG+ESzTiAdpetqf6tt19+beviCrD9BbVI6l8/LR9EgVbAnVoYrPq32YHQ1lMpHG8V7V+OykYbKPrq2TXij/m03DVgTKa2upULc0l0aZwnZqKVrNWETTM0xXbGfL9XjfKvE8ImAtWw==
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by VI0PR04MB10999.eurprd04.prod.outlook.com (2603:10a6:800:266::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 07:35:59 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3%4]) with mapi id 15.20.7918.020; Tue, 3 Sep 2024
 07:35:59 +0000
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
Thread-Index:
 AQHa94lYwasmKIL7I0OVdvDE0AaRyrJDyhdAgABM2ICAAAJRsIAAEAAAgAACqQCAAFg9AIAA03AggABPlQCAAAF7EIAADlMAgAAA25A=
Date: Tue, 3 Sep 2024 07:35:59 +0000
Message-ID:
 <DU0PR04MB96367FEE321C1F269278EA4DD1932@DU0PR04MB9636.eurprd04.prod.outlook.com>
References: <20240826072648.167004-1-s.hauer@pengutronix.de>
 <PA4PR04MB9638016F363BFF87D62B70D1D1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtVd3__wfm6EOOgH@pengutronix.de>
 <PA4PR04MB9638CF45263E713203A53EF7D1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtVtPJSsIr9eIFWv@pengutronix.de>
 <PA4PR04MB9638ED8FA48E352F7246127AD1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtW5fFocfr9_WgGD@pengutronix.de>
 <PA4PR04MB963814F85BBA6DD39F516469D1932@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtatnHp_7FBSSpko@pengutronix.de>
 <DU0PR04MB9636EF4BC137C95F70594E9DD1932@DU0PR04MB9636.eurprd04.prod.outlook.com>
 <Zta63ltdVl_UcX9R@pengutronix.de>
In-Reply-To: <Zta63ltdVl_UcX9R@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9636:EE_|VI0PR04MB10999:EE_
x-ms-office365-filtering-correlation-id: bb028179-0b8a-4679-d273-08dccbeb0e09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oO9Y2WkGTDcrHBKLCSnv/rM4jURA9YVgbk+UWt3JUqLyOVM0x9tQYFVU9YQK?=
 =?us-ascii?Q?tATPlfRizN2qFCUurAibK/OHz9nhHlnjJqo6I1mTn6LbER/liblO/Q0Oqsa2?=
 =?us-ascii?Q?dRsbFmjUbfYpIMgCElxF3hC1kmi1d5H9WeNYTfOnkt9Ua2AULJxG2Y7bCtV8?=
 =?us-ascii?Q?yKCXi64p/QnBH8cQIV6VmY9l150q/Z5SGbz4JZJ3DWpWSF7km70cNbGZ3WLe?=
 =?us-ascii?Q?UrhmhpQlU6p3rbBbPH8pE5NV4jcXvCRsyihWiwze9B3vEnOM06iChFouIWzh?=
 =?us-ascii?Q?MxWd0NVgspMWLqE/AUKDGzvlvjBBvq3cFdDzuRN9UlFfT3FpV8kqOZBakxnA?=
 =?us-ascii?Q?y9erpMpbLRIpajZrC4rFfn67jFnVQhE9qkG5hMWRkqqSj1uIDYrmgGcL63uo?=
 =?us-ascii?Q?EYyFTtR6KnlSN1AmiP6id1I/ozIFCWE2gsJvK99A4xq8a3c2T4GRe8qM0hjy?=
 =?us-ascii?Q?B5F7Qp2+oH7rNaxUD/et7g9xKVcpUHPn9xw9yO+dFUAT1AQ+nOsCQXF4zSXL?=
 =?us-ascii?Q?+gspQgUftoKeB0uMZfRYwGBS9ITGDiBL24r7OZDYQZ7D09CZtXm8GvCJ0qZS?=
 =?us-ascii?Q?eXvp1v8QfVt+U+A3ZEllo7XXbjsRkLIox7qVEd7PXmdW+Mu+ndEQGZtk0cjm?=
 =?us-ascii?Q?uG9wbxlw8fDHOeN37cf8knYcI7KDCnKdUFNBWWwFz0SC8RhVAi45PcsnBOeS?=
 =?us-ascii?Q?pmMzmZAKyUSO5z0dlgI3kpMOfyUxBQJHGDw0Oorw0/2FUTvB9XskCJjnPzoR?=
 =?us-ascii?Q?x0vQ241cy7PZmwzCR7ti0YoQ0H9/LUMKebTf3pGil5xYcNFTQdfR+YokALVa?=
 =?us-ascii?Q?//6s8/q1Nk5AD2ve1ow0xjfJU4ZYmjIBFqj6gre5vdediaPi/A+EgUp7F0lf?=
 =?us-ascii?Q?rPHW2aDEQ/hnFHIkH6Hq9LuBddqX/X00ZK4XmbREDON9pyRJiesORucu9dPQ?=
 =?us-ascii?Q?Z0GV48cWAui/yKYz0K5H26p9Jp+6eoaTf86RWIbGQXyxix+WxYDAFei/nIzA?=
 =?us-ascii?Q?61MsUFayhtHBrIr1mCwBRbjAZMynSDNI3dvzYOGNcbKP3CsqAIINPlfHV7fZ?=
 =?us-ascii?Q?I48F/RzUDFmLKzaerI4fz0jEfT6LfCchwChcxptYzlNztMhd17BJDXAb+8oc?=
 =?us-ascii?Q?AFwciWS09NJ+hv1gyYn+nbiEB+xMCeDzSyqS3YvmuXUz9AhGFcrWfnHyopoP?=
 =?us-ascii?Q?51338/IegMIlflqFaFXKWW/ZaFz6Sl4FmIdpo8o8LTJi7nEcxNOWX1ngcPNF?=
 =?us-ascii?Q?y9NKP6AsWNJ5L/m2WCr590R4YWxpiE0KVg02aD66uU7+AePehJaHBnZWsVrL?=
 =?us-ascii?Q?igOX4OSLWNsGLEUme9jOEHM3Srs5E6YT3BnwRUAKryvRDfEJkUYIUKq9AzT5?=
 =?us-ascii?Q?l9+3QxZItB7/SDYlODliIKLEaIRtgR+C1mtxA4+Siz9GiQn7sg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9636.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QrP3p1L/NL+pi+LaS2mLu2W0pWcXu6F16lkFrXwdyoSW/xpCqoh581dkU8ht?=
 =?us-ascii?Q?ttcgFyET9/R181d2vMQ4u4LopHwGAmB6QwpslQuw+OtuQDFtNuiTcWmOmYIL?=
 =?us-ascii?Q?mp6B5b+cyD4n7s2XLtdTUDkxfSuHYrrMWqggiWofaYjWYmiIXWXC11aHYqT/?=
 =?us-ascii?Q?tvtMWHTGtthTZIaj4eoWlHJE3iXyn3cov5+6IbmUzskLZy5mpAjz1yVyxIUb?=
 =?us-ascii?Q?3SRjxUehB4EWRjz1Q2qMIp6rfcXW9ojtZjF+4lV+uER2uLtT6X5J1vL8k+2c?=
 =?us-ascii?Q?0Y0oNScTdWLJ7+GrpVxejsoE6igfNNb4rP0uN7aLML50HJ2P/JgSbGj2CVLm?=
 =?us-ascii?Q?hEAvp04rTyV+263dyDUW0FXRlzOs4VIZb9cVFS4U7Kp27V32PrrZ0JDyvbtj?=
 =?us-ascii?Q?b3Z5qYYe7l1AAyz83i3ZL1bg5F75uEo8KdXcu6YoSodRue6x6CQrUKr1tkgt?=
 =?us-ascii?Q?P74jvA4sf02DjLy8ntvasZAsAVf9EDbhomsGwNghAV49MERMp4CjskAZDLOj?=
 =?us-ascii?Q?7dnMw9JwRK+cc549OnmGgdY/vnPsr0RBJ6VXrX33b+2OcgM1ZrN849ndm0C7?=
 =?us-ascii?Q?zTV2/0zfW8gEUD+sMwJWbjFIJz7SGD81QFIfwEdzJ3c5DvpR9TxnDvzCakL2?=
 =?us-ascii?Q?s+8GpSJUOoLdtytUyVOkQ3NJUccqeKS5A8QYTpjghsWJWZj7CShQJqmM8m1C?=
 =?us-ascii?Q?5n/GKl013k/skd9eXCxUigQgpwfvp96HyWDwVg0uAFQ3wP+otsuR2550Pvcq?=
 =?us-ascii?Q?XDpi22ksQY8G6MG7le0h6F9xV2MNTh0rTZnBnh1wOSiWitv9S0WraTVgYbME?=
 =?us-ascii?Q?fX38TAvkrAv1tFDHi8u7VXihMRNiXrr+C4rFyMGbiMlvR0pybOvJUzsL4YCi?=
 =?us-ascii?Q?wO85Hhk1j1CXRqVpaGFR6zwTgJSvLPfy75O7sk0EjR6Sks8gwuP399dmYa+c?=
 =?us-ascii?Q?VkqNhs0qfxA1fHymLBCO75t0XiVCaW1wfGvxZgXY1T9hLZGoaMXt+hR7l/MT?=
 =?us-ascii?Q?E7CGYK/VuIoVqHtFo4nnGZeOu72+iH/pFMTYq/6f01bS8jX59hAFH/Gkq6cR?=
 =?us-ascii?Q?xVvRbL4PunU6PwSoZYnJq9olq3UMNNKJsP21mjRFkN9x053CdAFDui9SCR0A?=
 =?us-ascii?Q?Ly+NwppNGld4UL6iKTigYWj3/wYxMUWfBGreWbUfBj8lyacUResY98/Vv4zi?=
 =?us-ascii?Q?mL9NF6FPBpBL5sez4VBCsdVyxxBM+eOO8Cj8rDeTKdaChd0c8y7XHSOC8i8b?=
 =?us-ascii?Q?VwStzuAcB5ad51sPJ9MhtopYmLB9hlzh1YBoJOe4w4KhOpo0AcfrsRYVatW2?=
 =?us-ascii?Q?MZPAWGT8+dMlfES55p6NL8Uk8+EMu9+ZkfIAhm7YQwmJi1MO6/h7u8MG5TSU?=
 =?us-ascii?Q?vrD89v5vrmGV2wSR9HVnt4730VTvLsr9sR5BPoPPhAh0ebIziIldV7j6nDUJ?=
 =?us-ascii?Q?zDyWZ/G3v2qhI1QhuxrLuBW0WxETm52d0WgJKUHt7fHRq4fY40Vk31Yl5+T8?=
 =?us-ascii?Q?U6ONSocYdcWqCDtb64u+HRSFpMclR7JT1JZvScED9PZiSiIP0LsA0mX/6qOw?=
 =?us-ascii?Q?UYmDWvjAbIeN4wKwBP9xBqX0b/RYMOIcVhDBlwMX?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb028179-0b8a-4679-d273-08dccbeb0e09
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 07:35:59.2774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4b/vd5KFrL4rKM+NiNDo0PbnDUpiliGZ3uAgTzJamI2lJ9lhVBVQDDJeLAhudVZho12CeZrM4ICjLM5lXetEig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10999

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Tuesday, September 3, 2024 3:30 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: Francesco Dolcini <francesco@dolcini.it>; Calvin Owens
> <calvin@wbinvd.org>; Brian Norris <briannorris@chromium.org>; Kalle Valo
> <kvalo@kernel.org>; linux-wireless@vger.kernel.org;
> linux-kernel@vger.kernel.org; kernel@pengutronix.de
> Subject: Re: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Tue, Sep 03, 2024 at 06:39:15AM +0000, David Lin wrote:
> > > > > > Not only this code segment. In fact, you did not add VDLL data
> > > > > > patch support
> > > > > to sdio.c.
> > > > > > If you try to add the code and do test, you will know what is
> > > > > > missing in your
> > > > > code.
> > > > >
> > > > > Could you point me to the code you mean?
> > > > >
> > > > > Sascha
> > > > >
> > > >
> > > > I only know the porting VDLL code in nxpwifi.
> > >
> > > Yes, and I asked for a pointer to that code, some function name, or
> > > file/line or whatever, because I looked at the nxpwifi driver and
> > > don't know what you mean with "VDLL data patch support" in sdio.c.
> > >
> > > Sascha
> > >
> >
> > It is better for you to check MXM driver. It is the same as Mwifiex whi=
ch
> support all SDIO modes.
>=20
> Now I am confused. You said:
>=20
> > In fact, you did not add VDLL data patch support to sdio.c
>=20
> I was under the assumption that the nxpwifi driver that you specifically =
posted
> for the iw61x chipset should contain this code. Isn't that the case?
>=20
> BTW did you really mean "VDLL data patch" or did you mean "VDLL data
> path"?
>=20

Sorry VDLL data path.
You did not add the code to support this new SDIO data type in your patch.

Please check MXM driver which supports all SDIO modes.

David

