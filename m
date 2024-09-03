Return-Path: <linux-wireless+bounces-12371-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5D796964C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 09:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A17285B45
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 07:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928761DAC7D;
	Tue,  3 Sep 2024 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F+Wy98FJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012024.outbound.protection.outlook.com [52.101.66.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DC91AB6C0;
	Tue,  3 Sep 2024 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350279; cv=fail; b=dMTi9TAs7E0nvt160YzgymPq7stRRS7wYubHZVdiV+6BH8d9b5C1+DXD9ADA/KsTTZ4AMdM3hBXkQga7ZbKY0Zj9TUoDvvSG55SIEyleR/XHfZRhOKol+jYZtGSVc0pOCHy1N839LoXooEhXhN9MsfPhq2kFOsZ8him8xDiieqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350279; c=relaxed/simple;
	bh=lS59Y5GKVOMNilH5MlytMVT1jvtvdSc/Aqw86KQut0E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NWJNzn2fON+0jdv9lN1AzNW2Wdg0uvvsEOqA5qSkdI9jVqO+PdHtb59JwOTQnDouoDFQN5ezmxhp/LMrst2bR6TThOxCfhb6wKaszwiz+UEC2ndwA0eJIk8Gv9pbgCFNWE9+jr6mkmgy4uqWBuewX8lWVUH4Um1xFpXGOgdsUds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F+Wy98FJ; arc=fail smtp.client-ip=52.101.66.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwpLDw6XW/UWVvtnQ4BXTQt2qFJkVF3fjpKfhf+10q6bJVg+AmKwXpCesUoGow1Dq+r32fN/EIYIYqpHBbCOQw5O7ivZgQ8Tj9FZt4KlzH/7wGrnO3AQJiWsFSMi4JolpJovAzNb0+9Nl3jLgVkryFrLVeIk4UoxYoSwPrtZbkxVvni8/x3gGxW9CPAyIJTpkUS5lxqXRMuLvSYaFaotk5r69Uc6uQGXegh4ZpU9xaJ7CVxhxxNe90isx2BUvZ6JhszppZa/USNolEoP8TD25ftkBd7xjBWE7bhoZeq90ADduM9uUfUkPVYkFO/9LcF1wJuIv8uuPdjfXs58+u0t+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lS59Y5GKVOMNilH5MlytMVT1jvtvdSc/Aqw86KQut0E=;
 b=JKE3ZUhqvBk0rn1UDHO+7H2oGSh0AAwy/kUFBQ3PkShCD5vVWbTr8/qyfjThuXAbOqmCRYlUFtU+AG+sunje6HIBxRAdwzh8lPXwpnmIVu/KBgJRFnMaHrQi3Pg+LFxFHkseYPwPTcl1MyvWREUlVDITjsM4go9REJKY//s82zFXDBwhz+JKdosZKLjcKp1h7V4ZXmB5TF3pBmRgX2t1BvSi08IIs0+vcD0DSTE7qE9Uajp1C17oI/EIw1wlQy2MhS0MZmLTDEUekJ47P/XODtnJvvSH2xdMIOx97C1pnHBwJzjyQg/E3AYTI3Sg57F3SFSTkUKHnFS134uh9q8uPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lS59Y5GKVOMNilH5MlytMVT1jvtvdSc/Aqw86KQut0E=;
 b=F+Wy98FJ+PRVIXd/XUlZZ7Imp7DOd5ivyzEzHqijpSg6D8cz7vyPTyQbWHKiDgNU8ymQTWh8wulHWR67Sa5P9Ug3JMf0RHn1wQZqZ6K0mM/cvVFXyVds0KfkBU2MlnKrgmPqhY1EiLxrpi3LMDKSEbagwRaVqoFF1vuMo7FXsFM5/UquBZ0GnSl8Zz7YTckoVCwgc4EKXxoRVH+3DBH2F16f+qA76h54hBWMxQzE2IxKPMt3uQjVDGble9Aiv9d8q8OeUKodZTKYZp914dkxcbXK3osE5pxEWhLSjEK6pCrjFLkMUcU61CoXVRtD9dY+7IZyHTKIlD8vr0kQPboCxQ==
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by DB9PR04MB9555.eurprd04.prod.outlook.com (2603:10a6:10:303::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Tue, 3 Sep
 2024 07:57:52 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3%4]) with mapi id 15.20.7918.020; Tue, 3 Sep 2024
 07:57:51 +0000
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
 AQHa94lYwasmKIL7I0OVdvDE0AaRyrJDyhdAgABM2ICAAAJRsIAAEAAAgAACqQCAAFg9AIAA03AggABPlQCAAAF7EIAADlMAgAAA25CAAAVzAIAAAPFA
Date: Tue, 3 Sep 2024 07:57:51 +0000
Message-ID:
 <DU0PR04MB9636603B5E83B295AD83967AD1932@DU0PR04MB9636.eurprd04.prod.outlook.com>
References: <ZtVd3__wfm6EOOgH@pengutronix.de>
 <PA4PR04MB9638CF45263E713203A53EF7D1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtVtPJSsIr9eIFWv@pengutronix.de>
 <PA4PR04MB9638ED8FA48E352F7246127AD1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtW5fFocfr9_WgGD@pengutronix.de>
 <PA4PR04MB963814F85BBA6DD39F516469D1932@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtatnHp_7FBSSpko@pengutronix.de>
 <DU0PR04MB9636EF4BC137C95F70594E9DD1932@DU0PR04MB9636.eurprd04.prod.outlook.com>
 <Zta63ltdVl_UcX9R@pengutronix.de>
 <DU0PR04MB96367FEE321C1F269278EA4DD1932@DU0PR04MB9636.eurprd04.prod.outlook.com>
 <ZtbAKPP7tIexefd3@pengutronix.de>
In-Reply-To: <ZtbAKPP7tIexefd3@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9636:EE_|DB9PR04MB9555:EE_
x-ms-office365-filtering-correlation-id: 28cf4b40-7542-421b-6232-08dccbee1c4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+Q8LizdgsnvLQcL5RJIWrhIFrVNo9V+igmpi1Z+vXfLdbPL8oJWPqlsNXEuq?=
 =?us-ascii?Q?HtJG7VN/azrOG/VPy3DEaJsQLLQS2pVchI2njDCSrgtAxBHqAIDvKQWO8oAx?=
 =?us-ascii?Q?cbdvV7KcEcX4IgRfvM9+mdj6Fur/nxA/Lo+l09nEXH0SI1PHov/2zp/MZewI?=
 =?us-ascii?Q?209MMWFF5tv9CNEo5+3rwe+GAR5AsH3UwXVQPvVjOxpt3pLE7u04zc910ufq?=
 =?us-ascii?Q?JNtMMgqZ8bA6WKhncxvKhaepzc5DaA7xIIHrYDB4mQd/1mMJJQpC5RGtWbjn?=
 =?us-ascii?Q?6iY2OzG3rJCcXCWyzhA4P0xxhVVtAizwbQfUQm5UMEZTA5Qinnv+NTNgwvIw?=
 =?us-ascii?Q?jePoFKK//qGVby0lOG2w5hmjX0CuWZQIJBUir2eN51lw404mDQQuUUGW3VaO?=
 =?us-ascii?Q?LSwEGnyACp/FQ0w3PEjew5/kznH5etgjmeiH1FDX8mxmcoIZL5zWnDymHfx4?=
 =?us-ascii?Q?OtVvekQH8nBFwoiDyKi/PINwpWyA8u/Byy9BdihkWwvbPe7xtcS2/Nyzycbq?=
 =?us-ascii?Q?3Vn0g+BDmSZ4vNm84OwNRqOCzHPPzxaJSmvYwO64TVD/MVn8FB0opKzKoqeV?=
 =?us-ascii?Q?agr9rlTLvXByd5++VtIt3q8KhaJPuTa6y5BC2kJXNzM6/npPlL+cprcK0n1N?=
 =?us-ascii?Q?d5UEel1JgHaSjdyBIriB+2aeF1ufui8Tf9QQT8bOgXkWXoKY9uKeEVqEzkXB?=
 =?us-ascii?Q?TWgRpqFFmseDGGBFOY26WvYTMrlwiJ9cp+Sk0gfWLKp0lBKkv9vFfbJclTkQ?=
 =?us-ascii?Q?z9I2YPsSbEecDgR+qVYnuMas3cSOBcvtCzc82OGOjLM7Cd1MB6kV69mxUiao?=
 =?us-ascii?Q?J79vhWYfIvk+2mikweUK2BPVDniOAYNoLW+FPjins6L3dzE6wyW9e3BIPdgD?=
 =?us-ascii?Q?FofAjfEn2+W7+XRvr3CJ5K02AGQ9Ww7JDT46jomTNWsEx8GH+HjAkSNwT3JX?=
 =?us-ascii?Q?YBZPlUS96v70byXdyYgg1VIWZ8+Bfrzow0pBmzdPUY+2QlvuNpGvseXIinpD?=
 =?us-ascii?Q?i5y7WtsmFJIOzYgXcz+BlpqR02Vj3q8yKyvhUVggdLmWh+lE8AghNWxHY3J+?=
 =?us-ascii?Q?cD6C9FJEPLSCE/wrxYwH4MlEfO4luDZX+ZgVdgkk7MTtwfs+KXMOMuxe9qgC?=
 =?us-ascii?Q?35hHg+aJiyO6Y7mfEb7FbukKzFRqK0EcvfS+16yf1V+FhxxX0LlLtsk8rEFS?=
 =?us-ascii?Q?Z7fZw+ACfn0bzWJaQ9ZkBkaja1+MQTC1YxE08JIm5Vfa7hvdwP/xF5gFNAYA?=
 =?us-ascii?Q?q4wghBjc1r/hQc3Q3nOX9mjjuLD8j3BX0Sdw4gEDGQPfjkJVAYxovez2pQzy?=
 =?us-ascii?Q?Ui6JaTrcWSTPGrpi1j2U0eW6xjg499LlZU57neObsRl9UrszKOCn6GC75LfV?=
 =?us-ascii?Q?EYD9iXHqeOoRoAkeZN6W2QBPEY0CtiBcD2fBIevamgtfoF7pfg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9636.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FYrKvf1uQ9fj+4Vc8cfZUJRWg1p2nxKUVT5P+tw1Fr5BfRd9D/WwQ4YOUPOG?=
 =?us-ascii?Q?bPFCab1QigwoqkD6OlPRZIkw2A91cYViJCv5e+ExcYx8S/w2fG6t7PXkzvhE?=
 =?us-ascii?Q?N8cshPR0hDGyVOrQbsS/jlbkf3Btg82AF4gy7jINMS29Kw2Ujtw+E8yRg0VA?=
 =?us-ascii?Q?Tjqu4paISlrdkfugq3bLT/NcCXCLf6Efe3goQ+ys3eJszRkVww6t05XGy/xT?=
 =?us-ascii?Q?xEg3nwsA9FU+XdbCUalUuuQU2do6Kjhsi4ykfrV1iXJyTHaPFprS2UGg36HM?=
 =?us-ascii?Q?Ev8Fmd02u3laQLV3LgC9YACpIC00KvtsUT4nKLHdMb54POjBdIT90PBTq8U5?=
 =?us-ascii?Q?Yajyh6lSnAsVbNVjGUWISwPo35p3edynQHIAz6MZl4X5oU0971y2e6rPC07V?=
 =?us-ascii?Q?KpUIY4e7lvi5An6qGe0Hna9KcV4DS+Vp/gJ4ayGcykGobJw1KIMf+T3eQ5H1?=
 =?us-ascii?Q?ZAz5gT3pKpJwLVCygCn1SUXsFjZnKd4j+v+qEersevs/C1KbeZgwdPeUldkD?=
 =?us-ascii?Q?nkzHguj6bSt0nhEIPY8s32Q1ZxD8NTPlG/VEcHKOPRoRldGNOKDX5jL3qQnC?=
 =?us-ascii?Q?I04H22tYNyj40QlIVmDxso1ndzyibN/X/Wyk9Su7KZGqW9dYMRCJIr9XZNFp?=
 =?us-ascii?Q?zCU8YeF3eyyzizuqKLMo2iqatri3paT3Vfc+E9/Pqe9S6tOYvf6sLmfmgAu+?=
 =?us-ascii?Q?TA4szOZAIRy6scn1SxtQzyegZL9lsYJdvkkF5uabq0XJfDIrdnHYTgISoj8G?=
 =?us-ascii?Q?vDAZ4mAq/iclAHlRjS4EyeFOgQ7hSKW896OKtpugf9hPrvRf40WirdskkKUj?=
 =?us-ascii?Q?wspl178cdRQmVTrxUUR/ARxvjfWVuwWmbtg2frAf2/mSm7/2oWPuunGlQWfy?=
 =?us-ascii?Q?tQq3UHhfUzVZcF1NpgKpQcENB0RJsODFEOnibedKkrz1f54cqzDDkFRdebrA?=
 =?us-ascii?Q?xLy/eJ7n4iPcT5PbdOWy+lMCavefEIY0tv62OMv1Jqv8FrQRQmrd6M+OqNs9?=
 =?us-ascii?Q?m5PLGO4ZOMJW30HdHYiQPEDF8FiK/63UMClwc89YJBUbG4wakGBf6q074uo2?=
 =?us-ascii?Q?NjByv+AKoE2fwJn/9RuNdkxQse3MSw+iOA6NoBfpgMfe21xNlf8z/jf+M9JK?=
 =?us-ascii?Q?X/ExVkAk/4RLs4ATIPKXadlSuy496vIJoqtSMVB6HblSW55Y6gSmddr/uCGn?=
 =?us-ascii?Q?iGAOIQK7zR+2qwAk/U592jVu8GbDS1jKeGpWUNldsTl5rY9PCFsEkyxdQFj7?=
 =?us-ascii?Q?etkIuls5mSyibfVRy+9SrR5heiTg8LcrXemLzVUf+FTJTTRMf5Mo2lWH/2m8?=
 =?us-ascii?Q?r6f33iquP12Rj+coYDQc5pNbdufocV3Pa3SDMmC/6wi2Bd2HLlfW8ct9AOIq?=
 =?us-ascii?Q?1luYjE6Hr3gHImfd625kocke+wM/CELmF7zNTx+YBTqNRswwT05Sct9O3mCC?=
 =?us-ascii?Q?cxFp5Zl3yKBF7yIsbSrJrouRPXQR2d2zrYq3+HQLq+0+5dLQBr1WMiMN0Zcl?=
 =?us-ascii?Q?EktzNW3Cus7gpF+7L2r5IookSOdAQg43yxQrDSCnhGYzVn0mkAHUUzA/4fBo?=
 =?us-ascii?Q?1cpUIBy0BCfeukWiO81LigzHPnEa7ZS4u+IobiZQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 28cf4b40-7542-421b-6232-08dccbee1c4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 07:57:51.6534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MQirKJRM1LJJzlNKDTuU898Auys7JXODxdUc/PNa1i35zfL+8Q4owvUSxDQ5UDI03CL4lusQPV7kksprXFHQ/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9555

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Tuesday, September 3, 2024 3:52 PM
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
> On Tue, Sep 03, 2024 at 07:35:59AM +0000, David Lin wrote:
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > Sent: Tuesday, September 3, 2024 3:30 PM
> > > To: David Lin <yu-hao.lin@nxp.com>
> > > Cc: Francesco Dolcini <francesco@dolcini.it>; Calvin Owens
> > > <calvin@wbinvd.org>; Brian Norris <briannorris@chromium.org>; Kalle
> > > Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; kernel@pengutronix.de
> > > Subject: Re: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
> > >
> > > Caution: This is an external email. Please take care when clicking
> > > links or opening attachments. When in doubt, report the message
> > > using the 'Report this email' button
> > >
> > >
> > > On Tue, Sep 03, 2024 at 06:39:15AM +0000, David Lin wrote:
> > > > > > > > Not only this code segment. In fact, you did not add VDLL
> > > > > > > > data patch support
> > > > > > > to sdio.c.
> > > > > > > > If you try to add the code and do test, you will know what
> > > > > > > > is missing in your
> > > > > > > code.
> > > > > > >
> > > > > > > Could you point me to the code you mean?
> > > > > > >
> > > > > > > Sascha
> > > > > > >
> > > > > >
> > > > > > I only know the porting VDLL code in nxpwifi.
> > > > >
> > > > > Yes, and I asked for a pointer to that code, some function name,
> > > > > or file/line or whatever, because I looked at the nxpwifi driver
> > > > > and don't know what you mean with "VDLL data patch support" in
> sdio.c.
> > > > >
> > > > > Sascha
> > > > >
> > > >
> > > > It is better for you to check MXM driver. It is the same as
> > > > Mwifiex which
> > > support all SDIO modes.
> > >
> > > Now I am confused. You said:
> > >
> > > > In fact, you did not add VDLL data patch support to sdio.c
> > >
> > > I was under the assumption that the nxpwifi driver that you
> > > specifically posted for the iw61x chipset should contain this code. I=
sn't that
> the case?
> > >
> > > BTW did you really mean "VDLL data patch" or did you mean "VDLL data
> > > path"?
> > >
> >
> > Sorry VDLL data path.
> > You did not add the code to support this new SDIO data type in your pat=
ch.
> >
> > Please check MXM driver which supports all SDIO modes.
>=20
> But why? The nxpwifi driver is much closer to the mwifiex driver and much
> better readable, so I would rather pick the missing pieces from there.
>=20
> Sascha
>=20

Nxpwifi only supports SDIO new mode. MXM and Mwifiex supports normal and ne=
w SDIO modes.

David

