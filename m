Return-Path: <linux-wireless+bounces-27959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4316EBD5AEB
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Oct 2025 20:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF21420EE7
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Oct 2025 18:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B442D372E;
	Mon, 13 Oct 2025 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lzweu1AI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013038.outbound.protection.outlook.com [52.101.72.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715792D0C92;
	Mon, 13 Oct 2025 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379533; cv=fail; b=IzXNj6oWFOT2undlSoaHlgJ3+IBgVyuvgSGX0BU2VaA4iTY358nkAyuBJ7jGvp1dJHXe8jwUIIb41crq2+BhevQrVDvZF6u/hkhYKp7E0lxXkfHsVhqR2JCTLcGdf6sQxYke4Y0JDDXqgrLQnVKFroVNSGouVP93PPRJGnnACn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379533; c=relaxed/simple;
	bh=oShZpmWcJaYR09xDWVLKe8oWMHULg6jnw/SBK8ra6Hw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NZH9anCno3KGbocN4OTTLLOtdFLytBZwU0EoQjG9zKqQfISXh+Qxg2NyJJu2LBAF7R/g/GYolrsKEpqZIXXiY3GBs5XPhpgELD5a9rLIOBMhBxeCn6/Wdn5Y6CnQfJPVe0fLrqUkeuwhLghTwiN/Kprvfv8ieY+K3+YGVPb9Vfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Lzweu1AI; arc=fail smtp.client-ip=52.101.72.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9PO+c8ob28GYvPf8lkOSFWoVm15zRNCNdiu7cPQoy1chSzWe72BScnA8XaGE5JOBMX2rf4L8IctHMBU7EMDIvsCoKAL6NoR/w25DSugoeiEprp+XT4vDkBNIOklhLwXGfjMoalDnh1fmHPS20wn36XhwyUr4yAYdBkRejokr15DyN/7EXNlZ3FhR4zjZWx8xTfbi7qTHWszSA6ig7oRtunNwZXkob0c7RM5kOzqX7iRmTm6uG3juK7Xp8650O5ykcx1eFehvPJfte7UfQnO7G5BIhGk+5OnPAMHm2D8Pm7xqndUuQsWYnanEzQisIWQO0/+mUfFC/wLBCuXr4w8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+4sqbJJbaimYFmKhHi44DPwetO3pEZHKQ/6RnxbCxk=;
 b=Rp0tpMIK13ry0WZ86GEGBIjG+FJ2JM9lTOF7X432T2lQa80hbK9VW93ZCEfqy3LU6xzhFA9R+l/qtSy1E9jN0cBCVsK+qqXD/g63f3mtRBGRsodWt9THu2O471mPFYNVfZ6KryFU4tuBPj3JrwsOyBkWv1HSRKj9T/0xNOJlCcoAJt6HuHJzGyTBWFSuK3vvwGiLzYKxObfJ4mzsv8NI9Ym6Mx8S0atgEticHRkxV7rrtaK9dECogOxiFDJr/izYtfJb55B4gbi9ZeJ5uB0IViZEzmiylJmfKw730dScCTNSGbwaVZYIxGed5EU3Dlr0R0GEMXVU2C3n6q7U0xkjRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+4sqbJJbaimYFmKhHi44DPwetO3pEZHKQ/6RnxbCxk=;
 b=Lzweu1AIAvPbL/OivEbpOn0nceXOoO0EhEAM9E39i8UfPk8xWMc1rr2m9uEnI6mI+MPzmV/au0acslKcSpW9UIwO3cqL0TBWgv8GjKmEczcFmEJKJY5hXqWOq/CzTiVbJSqBhEo1Dv3LgKavYvPR5sLr+bZfZYpTgvUdo0Qs6VKgPgq20UEp04Q1KHtUAlRfaFCrnpu9mXoUR/MFGLoOxDbhNqa3DuKuyxi326GUmXz5zs8rHo+XE1EAdlh1YCdzjLwfG1Y+DxIPTcVdDtMidc+nNIApzgFcRLAs25rc9okX7J8i9xam3J9mwJGm5JcQqSvRKCdNz9U3MGkAXowC8w==
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by DU0PR04MB9467.eurprd04.prod.outlook.com (2603:10a6:10:35b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 18:18:46 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%6]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 18:18:46 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Martyn Welch <martyn.welch@collabora.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, Brian Hsu <brian.hsu@nxp.com>
Subject: RE: [EXT] Re: [PATCH v5 00/22] wifi: nxpwifi: create nxpwifi to
 support iw61x
Thread-Topic: [EXT] Re: [PATCH v5 00/22] wifi: nxpwifi: create nxpwifi to
 support iw61x
Thread-Index: AQHcOTYX1z94xdPHtEqbC8ySTIanTLS7kbSAgATTYqA=
Date: Mon, 13 Oct 2025 18:18:45 +0000
Message-ID:
 <DBBPR04MB7740C33F56C41373CE6641109CEAA@DBBPR04MB7740.eurprd04.prod.outlook.com>
References: <20250804154018.3563834-1-jeff.chen_1@nxp.com>
 <164050d7-e0db-4a67-bf47-6d88e80d78ab@collabora.com>
 <aOfcb3bwacg8RidH@nxpwireless-Inspiron-14-Plus-7440>
 <7c3e9c5a-2f1f-44e7-9c99-2f0a173bd8eb@collabora.com>
In-Reply-To: <7c3e9c5a-2f1f-44e7-9c99-2f0a173bd8eb@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7740:EE_|DU0PR04MB9467:EE_
x-ms-office365-filtering-correlation-id: 35d557cd-9498-4598-479b-08de0a84f2f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gTv47I/8M27cmsV3KjL0C8xbBAsHm96VJp1SZ5phFyD39zkdaGeU4llF7iGv?=
 =?us-ascii?Q?N0c966JpHFOcT3n+5QkH6osbMRg43dam1BDxAhU+DGFEDonT4XokeoKq2PKC?=
 =?us-ascii?Q?s9o4piaOQiskUUClaNy54VI7Mq0zcnx8a/Oihv9rvgt1gbpJk0JNgdqe2cXI?=
 =?us-ascii?Q?F/LFO1UiNEcbANtS5h9KrJjJzUlYb/+oV8xgOSx/jSWTit00HMkOt17AYeDp?=
 =?us-ascii?Q?TPged2nR+zz24ZGTMmJTTEku3wVRcsGW7vuZn9K2Q2Fx/0Spfs6U+/yaIi7E?=
 =?us-ascii?Q?nPb2GYJgTNNXaq2/7fLjHoFBokFGUnDAPGmWIT7MzxPOUUe0P0YdA+aKrnFr?=
 =?us-ascii?Q?eZF8/m3BJ3seXajdNFISaciAPF0Ci8Bj0sI6CW0r85stdPiUpGVtRwoh9IDe?=
 =?us-ascii?Q?Eyvz7THMroZdpUH6JdHXGtcpfoZZsuVSkdfAGAu6V33HCzSbZpzEpXiAvqPX?=
 =?us-ascii?Q?/Y1W9TBpK4RcFxh1REJamEY1pHGEGdiId5qG/o18QJE9k3kR51HimGmD2juY?=
 =?us-ascii?Q?J6tc1YAaGKxlQvV6+Xhad+RoYOsN346P8z6GD6szVnTnpioVThu4oJkE0M5a?=
 =?us-ascii?Q?Mb1QUGQTaWWND4kEwGeOzwF4GHaageAhKGU6swPYMnYIajey3bpliiNTzJZL?=
 =?us-ascii?Q?dbI7pkYizcJvxldn2+BFj2LE7yjXoTAvdESFsjp3iWAEELel0a7A3/cX6oG/?=
 =?us-ascii?Q?zvFAsHLJ+F13n0iGPdXImMsJMGVuYmsyQfHSbLlmGU0ShDO6iAi+Z5qQuITX?=
 =?us-ascii?Q?vrlQbowG9Ucj2Uv2T0DP7UDVYEjB/J9JsubJKrD59G5+YXwr/6POyO5k6DVS?=
 =?us-ascii?Q?8dc/lTicHH2GEUdjuegy51fWe3SoufDhFlSu0uq0XGbaSOwV+tZR8JtRUux+?=
 =?us-ascii?Q?PQfe6vZjhkWDhkmDR+jMt9cIZhmiW5OlGSIJgPnPYz1UtKCZKHHeb/3KYy8a?=
 =?us-ascii?Q?HJCsQEx9GBCxtYriZa7onm1yPPsUS9M5ujybW87zzR+5rzOfh2Oa/EUQe464?=
 =?us-ascii?Q?Kj74ArPFOrvosYFDH2eXJfiLQY5SvoX2uVypkeV9twdCXy1iplJYuiOIvxaK?=
 =?us-ascii?Q?10yCvz92bY7NXo3zCpZ+YVlQxq79cYc1g1m9CyWisUI4Xe97YYrdeOx+Cwb5?=
 =?us-ascii?Q?Oa1n69+UoT8+jisCQT/2XaTE3phR571ZkXJZaYkyx1x4rfrAgsarB852294c?=
 =?us-ascii?Q?LwZhFN7U4zgNP2XQiTMwqh5xg0eaUBWEmkB7YadpyH6YnwXAVFaAo1lODJrv?=
 =?us-ascii?Q?Jr6BQnBLVGgP2uNrUPR38bkzP7w0u0fctc5jIkdE5s/Q9QZ08nKLkguFhk/G?=
 =?us-ascii?Q?Rk/a6r7dWVBfcc/bE52PPPmid5/vNh4TFi99/sF0ur9rexx6fgcX7VYnhsct?=
 =?us-ascii?Q?xWhb+3raIja7S1MAiqLXZVl3xI/CHte9Cp323SkXAgUjm1lQ0zAqQIJ4VTP2?=
 =?us-ascii?Q?t3oC3nIafUxMNm8pxPspN1jH4HJ4MCtNStlakVpDyddzSMsCCZIU/ehGfmKU?=
 =?us-ascii?Q?zjH3plH4rG+v0Af15nkxsyxIjDy2TfUgL2SJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VCKKPSnZGvkh9pJiBLSyHvWt502piSc3gw6qel9hdoIJ0pQ+AVzVanTLXl+4?=
 =?us-ascii?Q?tncN5rggueaD0wQXiMzQunS2KneiMnTShclD9Oc1/fSPcpMY9kjNPo1dXtx6?=
 =?us-ascii?Q?7iMatILdfI3u1Rrt6ImcTwfY2DdQObxfGix8O57hQ273prRO0aof4IcwIjjU?=
 =?us-ascii?Q?JGdboVv6q6soGk1vqeiALuEIZls+IwBd/GxE04N5EN3iE3ARnxXxCcPtJjYQ?=
 =?us-ascii?Q?qnKHZJrD4Y0hfRcndaTCk8wdHXH29EOcDdJ7O4wdxb84wZBT8va+PBf2aETO?=
 =?us-ascii?Q?Z0KO2BpBd9xJHy+vC3MTK1/cq5u6I81SplcsT2w42KBceTBF1JpzShENBvKe?=
 =?us-ascii?Q?MS41AmI4AHy5SKA+8LRHr6PpNU54s5hBEEOg5vYL01x7TQeGofld5cU6CPz7?=
 =?us-ascii?Q?uLNFAGpV9BcWLLxpPj7OzN2jgnoYAZ8o9DMqB/rQ0p9O56kQljang84k7O+p?=
 =?us-ascii?Q?7u47rxwsH6p42BgX95fgXOGT1AeG40fRjvIudEPw+PG4Kyat9sJmpH3nssbb?=
 =?us-ascii?Q?BoqT9GegfayY9gQlbJ+6eafOcjBnLivZpW92bARgblZsekTJ8WSJttLemO6h?=
 =?us-ascii?Q?TT7HzaInhhXKxXbBixsI3rCCvaUNchXhgG7CiZcG2Rx1ddrbrarMtwWf6NtG?=
 =?us-ascii?Q?EOxhYRT10MklFPmRT7dMOvvvePiOBedoGkkhMyfyE4TO7nwQrB8RrtsjH8uf?=
 =?us-ascii?Q?VpexxV56QbSB9iNh6eTlxeNzX6qv9mW0/pvS+KMed66pjqifTngVyGrXKFDP?=
 =?us-ascii?Q?Mh5iMy9usNBizWiG/do6W5rGdJsXUmVS1dxsFfizh7pAg+V3oM/OoJKG/Rb/?=
 =?us-ascii?Q?cu7E3EKF5ExvnyCX9wvptlTM0KJm5tCs1LCy9oLK/ZciAXAQDhxDjPdbWnst?=
 =?us-ascii?Q?mBExmz8PXl3nrq/7MpO3f1Vwkq8C6H7VVdGRipY38H2VUhZmAaWmVxUtPmTQ?=
 =?us-ascii?Q?xAMdb5c5/Jj00Ee8hqdG3j8p6XSHt+F8QbzS3FYZuWILwA2iHSb6ou40xPXy?=
 =?us-ascii?Q?QIJ61X/8Hex+/lQCZUGbp+AqIw+X3fL696S/bZ5fVhazOCQ7upheAIj/QATs?=
 =?us-ascii?Q?j8NPeU3CMqH/3llgH6F2gTFYS6aRsYkIwBDuekNnywGU2onTfcHy2caucqml?=
 =?us-ascii?Q?KAoUoGYQjgj5Hiv2zyB5vvU8I96tbIckOkhee4xTZcmXa65Azta2b42GCLhU?=
 =?us-ascii?Q?vqQsgtGAsGFeUSA/VFAMDY+1sxFrfuzYyEX2Z5ZxT9yLOSQqNr0LgeJsh6cG?=
 =?us-ascii?Q?5DLS6ECmS+8SxQdB9uxsDJlnJqy0M1aImmqOcOmE4ORprltW1S2aWPzQ1wnm?=
 =?us-ascii?Q?eY43g07YEIww9JjOTrMYCj1r1C+3ju7ywAykTaf8GJpxdFusQIOEqmW2kgU4?=
 =?us-ascii?Q?kMfCRBrAtR5ZQ652CadlMzjESbBm//reffOSuBotbnhzgDDmb9zWqUTv1p3c?=
 =?us-ascii?Q?EyqhoqVB/HpWKrzqy2+H9e5ErH4tF8nWazyh1ZoZMzUYrwk1+w29AzzwACi7?=
 =?us-ascii?Q?yDOMXhzWi40fWEkyYFtHdrZ2sQP0xkvDrcfWsPpVAIp3RZDWoa1oqjPmLtbY?=
 =?us-ascii?Q?H/LEKQ0oINVC8UCf+fZW8e29IXjygY4pKvHwrzfA?=
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
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d557cd-9498-4598-479b-08de0a84f2f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 18:18:46.0529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0XxFfcLCGX5+qfJZaBM1uMNvT8x2KrWZl5tU1qZ3girBQ+3TKQi61UPXzKa7WxD+ZV0pZoS+v54gtWeIM8y7pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9467

Hi Martyn,

Thanks again for your detailed feedback and testing.

From what you've described, this issue doesn't appear to be caused by the
nxpwifi driver itself. The Wi-Fi side seems to be functioning correctly.

To simplify things and avoid firmware loading conflicts, I recommend using
the Wi-Fi-only firmware with the nxpwifi driver, and letting the btnxpuart
driver handle its own Bluetooth firmware loading.
Also, I've looped in Neeraj and Amit, who are the maintainer of the btnxpua=
rt
driver.

From your BT-only scenario logs:
We can confirm that the host-to-chip communication is working correctly, an=
d the
firmware download completes successfully. This rules out hardware issues an=
d=20
confirms that the UART link is functional. The problem seems to occur durin=
g HCI initialization,=20
where the btnxpuart driver reports repeated Frame reassembly failed (-84) e=
rrors.

We suggest that to debug this quickly, it would be very helpful if you coul=
d capture the UART=20
lines (TX/RX/CTS/RTS) using a logic analyzer (e.g., Saleae) and share the t=
race. This would allow
us to inspect what's happening on the wire and identify the root cause of t=
he=20
"Frame Reassembly Failed" error. There are affordable logic analyzers compa=
tible with Saleae
software, such as:
https://www.amazon.in/Robodo-Electronics-USBLA24M-Analyser-Compatible/dp/B0=
7B8KHYDD?source=3Dps-sl-shoppingads-lpcontext&ref_=3Dfplfs&psc=3D1&smid=3DA=
J6SIZC8YQDZX

best regards,

Jeff
> -----Original Message-----
> From: Martyn Welch <martyn.welch@collabora.com>
> Sent: Saturday, October 11, 2025 12:22 AM
>=20
> On 09/10/2025 17:01, Jeff Chen wrote:
> > On Tue, Oct 07, 2025 at 05:49:59 PM +0100, Martyn Welch wrote:
> >> This seems to be working well for me, at least for Wifi. I'd like to
> >> get Bluetooth up as well. The bluetooth driver (btnxpuart) doesn't
> >> seem happy loading the bluetooh firmware:
> >
>=20
> Yes, I'm currently using the wifi only firmware. If I'm not mistaken, tha=
t's the
> only firmware that the NXPWifi driver will currently use. It appears that=
 it
> should be able to load `firmware_sdiouart`, but that doesn't appear to be=
 set
> anywhere and thus it's not considered. I tried to rename the combo firmwa=
re
> to have the name used for the wifi only firmware, but that was failing fo=
r me
> (more about that in a moment).
>=20
> > To help us reproduce and investigate further, could you please share:
> > - Your test platform (SoC, board, etc.)
>=20
> Custom board based on Renesas RZ-G2L, using Ezurio Sona NX611 M.2 1216
> module.
>=20
> Kernel is 6.17 with an added custom DT, a few patches for other hardware =
and
> the NXPWifi patch series.
>=20
> Both btnxpuart and nxpwifi are built as modules.
>=20
> The firmware itself is what Ezurio provide in their Yocto layer:
>=20
> $ md5sum *
> 6a9307d27c3bdb3bde800265056ab217  sd_w61x_v1.bin.se
> 8a28ec7f1b77dbde0ac7568d0426c669  sduart_nw61x_v1.bin.se
> d38935f03dbe6da7a9ac3daf58e640bf  uartspi_n61x_v1.bin.se
>=20
>=20
> Looking a bit deeper, if I try and load the combined firmware, the blueto=
oth
> modules attempts to load before the WiFi driver has had a chance to compl=
ete
> loading the firmware which is resulting in the firmware failing.
>=20
> If I blacklist the btnxpuart module (and rename the combo firmware), it l=
oads:
>=20
> > - Your test steps
>=20
> At the moment, booting and checking to see if the hardware has probed.
> If it has, ensure I can connect to my wifi network and ensure that I can =
pass a
> little bit of traffic.
>=20
> > - The exact firmware version you're using
>=20
> As above.
>=20
> > Also, have you tried running Bluetooth in a BT-only scenario (without
> > loading the Wi-Fi driver)? Does that work correctly?
> >
>=20
> I hadn't. Just gave that a go and I seem to be getting the same failure (=
though :
>=20
> $ sudo dmesg | grep hci0
> [   40.859055] Bluetooth: hci0: ChipID: 7601, Version: 0
> [   40.889487] Bluetooth: hci0: Request Firmware:
> nxp/uartspi_n61x_v1.bin.se
> [   42.850682] Bluetooth: hci0: FW Download Complete: 396444 bytes
> [   42.850736] Bluetooth: hci0: Frame reassembly failed (-84)
> [   44.222243] Bluetooth: hci0: Frame reassembly failed (-84)
> [   44.230226] Bluetooth: hci0: Frame reassembly failed (-84)
> [   44.237480] Bluetooth: hci0: Frame reassembly failed (-84)
> [   44.247567] Bluetooth: hci0: Frame reassembly failed (-84)
> [   44.254188] Bluetooth: hci0: Frame reassembly failed (-84)
> [   44.263459] Bluetooth: hci0: Frame reassembly failed (-84)
> [   44.269814] Bluetooth: hci0: Frame reassembly failed (-84)
> [   46.280494] Bluetooth: hci0: Opcode 0x1002 failed: -110
> [   46.285835] Bluetooth: hci0: command 0x1002 tx timeout
>=20

> Are there any BT patches that I'm missing?
>=20
> Martyn
>=20
> > Thanks,
> > Jeff


