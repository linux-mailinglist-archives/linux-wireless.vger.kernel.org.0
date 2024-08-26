Return-Path: <linux-wireless+bounces-11930-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 344CA95E713
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 04:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A801F219D3
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 02:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E04E2E419;
	Mon, 26 Aug 2024 02:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FVXJ3TfE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A6F29CE3;
	Mon, 26 Aug 2024 02:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724640987; cv=fail; b=jiM04ReM++P5PGDp+4HLA5KkGw+vzVIonNcam1hRERUwuyTuM420ouJs1D5K+BDJePdt+ph66Qd2sq2ZE05scgBld/MAOEf+EreqknLWbnOLZ0G8pHo3lP4NPvM39BQxIi/v5iJzfsJPO2XxzR+Ezh45oz1PoRpIBTKRc50Ug+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724640987; c=relaxed/simple;
	bh=1Nf9ivDErmJwACFGTeFQL3YQVeJYS5YV1vQ5/qaAV8Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q+zIlzCtIrnz04vfB3YsNiroDBTOz2tbJ3IJtP//zpHy49/VT2vcpUKSQpYrLp2SWhDRVLah+U9QT4LW1MbCqUXHeFbLqma2l+C/iCcdVpieIr5p+lGO7fzEjdh7EBX9y6//tUu5Y9SiYR0CLlU/2L5VBWKz2rSca+g5ESzyhjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FVXJ3TfE; arc=fail smtp.client-ip=40.107.22.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIC6XsuphoCd3U67Em1QZGnQRdLydUtfpUWgE0ExXYPptZy68HGI+Q66GZQKQsJVOZNzOhnGTjO35yZvARMpEZVojlQswhcXeOrvXPxxhMH79lafsy1Qbqx1Jy8bG251i/cTdewDjYKCPnQHlRwQQHzyJI6GbMj11NCjQPdgRDj1r3fQs4xG6sMo3OlsXUKQ0NdldiEohjb0kB+LQomQ5+160GU4rz7RWYN9eoAgFd8W+RNi4oum4G6sc6hk+Kv62iuh0NfV2Xx/NsW1mDkUV3RwKO5QciCneoHDdsk5zcdrR6m4tpWHexxEuxYIKLBDdvvG85CeBaDReL5iGrUw+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4OK7NbnZd+wkhOc5jfer3HvBpf6NewZqjpXOrzD5jw=;
 b=seyWmkwJCu59kdWtuByDUhSlDQ+39VRk5FPoYgL0QwXFiIHa/0HLSx0/xEpF28hNY+DxwitMDjNdPYOsN9RwWpXNbWsJZ2aHJNjXUogAoDTvRRENGJ8dJ7nLoCqzXfkV/tnXz9F2xuFgF71L8xXhJTt9IkqcGnhXSGrEJKkJP+E/Z4mHEAVgrsUUVBcvn9eYTxFL25PLny2i3bNMlahyZ9+QoPS7JBQMjAAHtesJzX1Rgi+oczT9AR5B6UqAHKe8X6AvBjmx6UEFfSUXRHcz2bWpLu3a1ZeUW70QrrKivNLMfFHgTT1LaMR171WGLidvyoc1ZnrojW3WsHvT1Z3Bpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4OK7NbnZd+wkhOc5jfer3HvBpf6NewZqjpXOrzD5jw=;
 b=FVXJ3TfEa5W3Be1KSikowKtUCXeM15/rMyJLJLhXWlh0h3GWBcMjs1H1jn/UxPOaMGRnim5CQRcBNyI6B/OPn1eUHI1g26Y5LOAgL09XpcaspObrVlNasuD5vI4IefNNnqeDDJZ9Kzk6FT7/cj3r+OdWqaYNQeMD3Ca7U8KBt7F2IBunEFYG+Qch9SnWBGCbv2NLZu1Ikad1RnGfGeAKILFx0SIDKb+tjsSKDGA8lzrzvPii2N0xgvRVlzkz20Xqc/1Zv71gxnbbu6AIHlF+ko6C/0g1/vQBpQakWXmb9sZns+18kOlO9iVJpJhqYaUFl1S5aZk2OWXkmXL5MLUH1A==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VE1PR04MB7358.eurprd04.prod.outlook.com (2603:10a6:800:1a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 02:56:21 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 02:56:21 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Calvin Owens <calvin@wbinvd.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "francesco@dolcini.it"
	<francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to
 support iw61x
Thread-Topic: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to
 support iw61x
Thread-Index: AQHa6kDq7zFfRJGOz0Wel62W8Sr8T7IzUOKAgAU33ICAAGLVsIAABRcAgAAAUWA=
Date: Mon, 26 Aug 2024 02:56:21 +0000
Message-ID:
 <PA4PR04MB96386AB354F886DCB899F02AD18B2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
 <Zsc1efkBHDXdZtfJ@pengutronix.de> <ZsuWExGZyY8Tvu6s@mozart.vkv.me>
 <PA4PR04MB96384BCB4093D621C43B047ED18B2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZsvtQCXxNJHh_DWS@mozart.vkv.me>
In-Reply-To: <ZsvtQCXxNJHh_DWS@mozart.vkv.me>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|VE1PR04MB7358:EE_
x-ms-office365-filtering-correlation-id: faf6e35e-6388-4174-ecdb-08dcc57aaa40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hfNbGe4oC6aM3m5TVZqBtMArPBJakBpKkeh8DKgzSkwVBMN3Wnu/uVoZwZ//?=
 =?us-ascii?Q?dd7Qrc4h6wHBBDqdSIq2j/yfs8sCYANxr1lYEq0m7HqxpwTkpaobYdKQ8FyW?=
 =?us-ascii?Q?tXTkXY3G+t5i+j8HZDATHdeO7kDnzMcXLS6Lt9wAJ5rK2xLH/nXoD9C0SkSb?=
 =?us-ascii?Q?DrBJcv3b9ndj2V93OxbET69PiQDKf6CFwgL2ZlRpTujD01odNSmdD8bRHp/r?=
 =?us-ascii?Q?8DJTEfHccAnTqz/hx4gyYo/Rqeh8tHoc45Hk1fAmVbsQU6JQqd3M4ViyI9UV?=
 =?us-ascii?Q?BGyHfXQRK9vvXtgDCt+uVjq/UMAyYkvswvpq19tFmzJWiOC0Xt8kSXYAeUgD?=
 =?us-ascii?Q?aP7usMAxFy9Hx+OwARA2fVfmXcDbpyphi6ePg+8+ZHt/At/USCA+1qlPUcra?=
 =?us-ascii?Q?mAvthgWyGznQHcOTGmYMsv+uLYC2j2djT2puGO8+T6KMY2D3FQvxB/HeC4Ew?=
 =?us-ascii?Q?uk0ZbQJyTZDf9VX8uEpH0oUcTvaCq5wG1fX4CBo+zswtr8F4oNi8Giq0fNf7?=
 =?us-ascii?Q?QOk/Ocdgm2shcA2ePc+SULnWDB8ve8tI3g747SMR9DMYUOvKwPzQDA2p/CAL?=
 =?us-ascii?Q?kAiw3YRFQv9IQKfHF6gCNGi6fMiY/bvZfUKFbN0egbiJu6JE6fFMQZJb+pgi?=
 =?us-ascii?Q?8XdqsW+bh+rXmmj1EVIrQGbxj0/vciEWw3dxa/gBYq9iRdGkadk99Y3uOtqO?=
 =?us-ascii?Q?mjQ+KKah9s61kMjGIDebBB3O5hSsbAnyJtUj5MzjdzZlWcTtrkD7GRVgTnzu?=
 =?us-ascii?Q?dYUQwY0O6ixfYJnDDuVWZLOiDIoYXghLv6X+LbrTSVZs0wzB2KIjOTpifl0T?=
 =?us-ascii?Q?Gv73Sf5MjHd21d0xy6RB/hQJ6BR/UbTrJ3qCB9qjhziJW3ZlGmX4rYwxwq6G?=
 =?us-ascii?Q?1Tf9FEtWdZJUHJ5roze6EWzHFcVSmdKwuuOymofeV5kuq9kQr73SXnDtfCVn?=
 =?us-ascii?Q?KmwSMM4SC6c7msuRQrb6ZHsVKpyHlhbjMYef5ODd9nkEP/v4xAhbHyO3c9rJ?=
 =?us-ascii?Q?ro2wLcRnxO2Af6jXuuxcBVA0wweXIcugMXfLa8MzrkUwz0d3ao5NqGpl1B9h?=
 =?us-ascii?Q?QoIiH8Q2E7RdyD4LFF9B6mRY8bdCnXcTmbUaJKc2tPfbKfftx0ADlfUadJ+T?=
 =?us-ascii?Q?dL61NbCNBcpGC1hpXLcnMAdp7uDtVr6i6Lq7DeIUqooDFhK6HAipFDk6bBwS?=
 =?us-ascii?Q?QLSAJHJi2UIS4F5ij/OgmMWJE0s9LeNyDSpDAmtzTyFbMfyDhexw6JkREstg?=
 =?us-ascii?Q?TU3aSuFSB056Gry/LwBlH6VLvEjzR6Nr4Zl2bv9Hp7FtMVo2qCmWDWo/TUym?=
 =?us-ascii?Q?pEkBbYtKDlnjlVMKqvJ/xXhTCu30kLrqth4Vjrwqpx7p9oN8tYqHzw6C8akX?=
 =?us-ascii?Q?CoJHuWZWnez2t9gF1id/JdhYXM8W/cDahSmniE6DjXAi14UniA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eHknJDp5O3X9hZgBqt6+zgyMUK4Q1s3X6Sz4JrY5m1WYRvszwPPCfYGoJ8jd?=
 =?us-ascii?Q?6K+gHaPEOQdBPKLamnH4gGlTNizE2qpMOOJaSuJNNFr+UkiGuj0xZfBNs4Io?=
 =?us-ascii?Q?BjsZ7RdanDohLMZkpSRfZLNjFzxMTx54+5Gz38L7tOMDsmy2Nc/R7sj0wN93?=
 =?us-ascii?Q?BPDkXL2Qxg0X3diHfpU2zZ/tkeNcIopB+htL3VHumXL1CFag4xm20E6yRuDO?=
 =?us-ascii?Q?mK54bSPKma778V7iwd1/eJtk1K0X2L+d4sfLVqnaePqk/9sCT9ZBT7ocebtT?=
 =?us-ascii?Q?Dgluo/+d6vw+Ua4q/08oT/QrwQOiTo5uiSUSk5IpY5w2DF24yzd0Wdk8ShdV?=
 =?us-ascii?Q?8xC0OoLKQPqpsiO9gM2fK7wKgXpmT/gWIOUX8N2JbBh037SpStWTxTSUpIfr?=
 =?us-ascii?Q?ilh3y6XbZlackZr1mM9wxoRfG0H1q+yJw1elrCH+RK1983dKJ4Buu0RZ3fb2?=
 =?us-ascii?Q?8xzc8a69d3kBVwj/wisq5uHK626SQdjy4rXYZcWGk+dX7LVyVzIYoNOGGlfQ?=
 =?us-ascii?Q?MvQyOFqqpgevN58nWewDDQhps88Slay3NPSLn2x4qhY/413UujOumR4Pa6F8?=
 =?us-ascii?Q?izgM8e1tgDvIX3jttZkavb8mneapM8ZIFoJkbD4mK1ME1pGT3VUKTy4T5EfJ?=
 =?us-ascii?Q?oYwxQZZg5GMCTqp9IydoD/lZTF5+SVzhh5VdOUwQjdx0iK3KKg4W0AAoqaLl?=
 =?us-ascii?Q?w3heBVJAGuD8bxNHitkV9bZ5lDZdzhjYyv15kVibsH0VGqmEyTj2UM8001ex?=
 =?us-ascii?Q?ocHh4BB0Ot/SgUmIdZcxUVYbXwxAztpOCUReqZayZO7CLhchCTFo809maacy?=
 =?us-ascii?Q?zGxtJLymfdfYox52ZpOGVrD6YLNL5O/Eg12VscmlY4zE6Hd9iodKV/M+kE95?=
 =?us-ascii?Q?yxBDEvY2ToTf3tfdctzZnggZiiwFaC6fpCfAFBXZLuKaBVer7cTNfaV57SmL?=
 =?us-ascii?Q?rMCPATxalIlP2FxKAw4rD2/RTl2WqxVsDSg2YX2Qnp/ElMeduKv8x++/8nVj?=
 =?us-ascii?Q?ofMYAS5dfW0cad5z3I03EyyMNZogQEWRXuG5zqLhiEUW9XbyPHb4VNg+An58?=
 =?us-ascii?Q?QfUAKW2VhASA7Gt0AN7lIG39ClYny3uNxk3QfwpQdrIbhLsu3t4brALs5t1J?=
 =?us-ascii?Q?Uy516zs7z/AM+9deeK/aanRC8giYYefn+uMMIMhDzLEqCjL89OrTAXSGUIf3?=
 =?us-ascii?Q?hMc25iWkJJOp7LXvrVG/K51PJSAgNZ5OFuIpvOIDeMzzrCLNmzee8ZwFZKMX?=
 =?us-ascii?Q?1k4zN3X0uHV/AGW/3bnCQ7GztBoin4TQni9RZWWthl3lWhy+JkJKtsaYQpfI?=
 =?us-ascii?Q?s3+WCvap8xEl9Dm5wI30Xj7lBPawrCQMv+VSIXKtKZh+4gC7IiCIzCKDfoT4?=
 =?us-ascii?Q?fcLP2ZfeZl6YssYaKJDpNCBE+8s0iWmFx/R7qTGdr2b1L3TZMvXg8pXaKzJ/?=
 =?us-ascii?Q?GS/JNPOrYgMb2kcMFACZke2K5Gn5Vxkjd4s5aOauo3V7lTmCIhhnNMWsbm9r?=
 =?us-ascii?Q?x1cx6a2uGSz3gpgwte6wdqJgs7pB6fxLEYRHi7qwkGhV6vcKBVVaQDe6BfIq?=
 =?us-ascii?Q?rR8Y7lMb6XM+7+U79LOQfHVMaUD2Urf44NaS1BTQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: faf6e35e-6388-4174-ecdb-08dcc57aaa40
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 02:56:21.2257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y6m1sjRr++pDMl+tAMUhBJ5/HKflDNZU46ioKGwDIQbN8es48REgz5cAqpWJKcx3Z6jqJcBedIFMlrwa4Ki6HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7358

> From: Calvin Owens <calvin@wbinvd.org>
> Sent: Monday, August 26, 2024 10:50 AM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>; linux-wireless@vger.kernel.org=
;
> linux-kernel@vger.kernel.org; kvalo@kernel.org; johannes@sipsolutions.net=
;
> briannorris@chromium.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; kernel@pengutronix.de
> Subject: Re: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to =
support
> iw61x
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Monday 08/26 at 02:33 +0000, David Lin wrote:
> > > From: Calvin Owens <calvin@wbinvd.org>
> > > Sent: Monday, August 26, 2024 4:38 AM
> > > To: Sascha Hauer <s.hauer@pengutronix.de>
> > > Cc: David Lin <yu-hao.lin@nxp.com>; linux-wireless@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; kvalo@kernel.org;
> > > johannes@sipsolutions.net; briannorris@chromium.org;
> > > francesco@dolcini.it; Pete Hsieh <tsung-hsien.hsieh@nxp.com>;
> > > kernel@pengutronix.de; calvin@wbinvd.org
> > > Subject: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to
> > > support iw61x
> > >
> > > Caution: This is an external email. Please take care when clicking
> > > links or opening attachments. When in doubt, report the message
> > > using the 'Report this email' button
> > >
> > >
> > > On Thursday 08/22 at 14:56 +0200, Sascha Hauer wrote:
> > > > On Fri, Aug 09, 2024 at 05:44:50PM +0800, David Lin wrote:
> > > > > This series adds support for IW61x which is a new family of
> > > > > 2.4/5 GHz dual-band 1x1 Wi-Fi 6, Bluetooth/Bluetooth Low Energy
> > > > > 5.2 and
> > > > > 15.4 tri-radio single chip by NXP. These devices support
> > > > > 20/40/80MHz single spatial stream in both STA and AP mode.
> > > > > Communication to the IW61x is done via SDIO interface
> > > > >
> > > > > This driver is a derivative of existing Mwifiex [1] and based on
> > > > > similar full-MAC architecture [2]. It has been tested with
> > > > > i.MX8M Mini evaluation kits in both AP and STA mode.
> > > > >
> > > > > All code passes sparse and checkpatch
> > > > >
> > > > > Data sheet (require registration):
> > > > > https://ww/
> > > > > w.nxp.com%2Fproducts%2Fwireless-connectivity%2Fwi-fi-plus-blueto
> > > > > oth-
> > > > >
> > >
> &data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7Cff25728795724a618a5208dcc5
> > > 45c
> > > > >
> > >
> 5fd%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63860215067862
> > > 3224%
> > > > >
> > >
> 7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB
> > > TiI6
> > > > >
> > >
> Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DU0Cej8ysBD%2Fg1Sa4Ia
> > > Ph63Ot
> > > > > iTcemadiCfMINYM%2BRL4%3D&reserved=3D0
> > > > > plus-802-15-4/2-4-5-ghz-dual-band-1x1-wi-fi-6-802-11ax-plus-blue
> > > > > toot
> > > > > h-5-
> > > > > 4-plus-802-15-4-tri-radio-solution:IW612
> > > > >
> > > > > Known gaps to be addressed in the following patches,
> > > > >   - Enable 11ax capabilities. This initial patch support up to 11=
ac.
> > > > >   - Support DFS channel. This initial patch doesn't support DFS c=
hannel
> in
> > > > >     both AP/STA mode.
> > > > >
> > > > > This patch is presented as a request for comment with the
> > > > > intention of being made into a patch after initial feedbacks are
> > > > > addressed
> > > > >
> > > > > [1] We had considered adding IW61x to mwifiex driver, however due=
 to
> > > > >     FW architecture, host command interface and supported feature=
s
> are
> > > > >     significantly different, we have to create the new nxpwifi dr=
iver.
> > > > >     Subsequent NXP chipsets will be added and sustained in this
> > > > > new
> > > driver.
> > > >
> > > > I added IW61x support to the mwifiex driver and besides the VDLL
> > > > handling which must be added I didn't notice any differences.
> > > > There might be other differences, but I doubt that these can't be
> > > > integrated into the mwifiex driver.
> > >
> > > Hi Sascha,
> > >
> > > I'd also love to see this patchset, if you're able to share it. I
> > > can test on an
> > > IW612 if that's helpful at all.
> > >
> > > > Honestly I don't think adding a new driver is a good ideai, given
> > > > how big wifi drivers are and how limited the review bandwidth is.
> > > >
> > > > What we'll end up with is that we'll receive the same patches for
> > > > both drivers, or worse, only for one driver while the other stays
> unpatched.
> > >
> > > I have some concrete experience with "in-tree driver forks" like this=
:
> > > a pair of SCSI drivers named mpt2sas and mpt3sas.
> > >
> > > The latter was created as a near copy of the former:
> > >
> > >
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
i
> > >
> t.kernel%2F&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7C582c3c0573b74f83
> 42
> > >
> 3408dcc579bc4a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638
> 60237
> > >
> 3871805816%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luM
> > >
> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DbLjsRTRsR%2
> BTtA
> > > jUIVDY396ZF%2BIkwwUFhAubTCin3IVk%3D&reserved=3D0
> >
> > .org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fco
> m
> > >
> mit%2F%3Fid%3Df92363d12359&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7
> > >
> Cff25728795724a618a5208dcc545c5fd%7C686ea1d3bc2b4c6fa92cd99c5c3016
> > >
> 35%7C0%7C0%7C638602150678637352%7CUnknown%7CTWFpbGZsb3d8eyJW
> > >
> IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0
> > >
> %7C%7C%7C&sdata=3DmzrLLqJNee7vIdV47j8xVSU%2FByjh%2FnNKnRsx1nw3yNo
> > > %3D&reserved=3D0
> > >
> > > The result was *exactly* what you forsee happening here: both
> > > drivers were constantly missing fixes from the other, and they were
> > > just subtly different enough that it wasn't simple to "port" patches
> > > from one to the other. It was a frustrating experience for everybody
> > > involved. I think their git histories prove your point, I'd
> > > encourage everyone with a horse in this race to take a look at them.
> > >
> > > It took three years to finally unify them:
> > >
> > >
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
i
> > >
> t.kernel%2F&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7C582c3c0573b74f83
> 42
> > >
> 3408dcc579bc4a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638
> 60237
> > >
> 3871815005%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luM
> > >
> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DRfY6N6WWXI
> n0gZP
> > > SBoRySz5eeU8WkFH2HvFHLVNgu3Q%3D&reserved=3D0
> >
> > .org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fco
> m
> > >
> mit%2F%3Fid%3Dc84b06a48c4d&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7
> > >
> Cff25728795724a618a5208dcc545c5fd%7C686ea1d3bc2b4c6fa92cd99c5c3016
> > >
> 35%7C0%7C0%7C638602150678649431%7CUnknown%7CTWFpbGZsb3d8eyJW
> > >
> IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0
> > >
> %7C%7C%7C&sdata=3DUGjDfngO1POWuydIfmOL%2BR%2BqJ1BoDQW6NboQUV
> > > q2Xh8%3D&reserved=3D0
> > >
> > > I doubt anyone would disagree that wifi drivers are much more
> > > complex than SCSI drivers. It would be strictly *worse* here, and
> > > the path to unifying them strictly longer.
> > >
> > > Thanks,
> > > Calvin
> > >
> >
> > I think Nxpwifi will support NXP new WiFi chips and Mwifiex will suppor=
t
> existed NXP WiFi chips.
>=20
> Hi David,
>=20
> I understand that. I don't think that really changes anything: there will=
 still be
> many future patches which need to be applied to both, because the bug bei=
ng
> fixed existed before the fork. As the forked driver diverges, that will o=
nly
> become more difficult and error prone.
>=20
> Thanks,
> Calvin
>=20

Nxpwifi is not only a fork from Mwifiex. Especially after we modified Nxpwi=
fi
based on the comments from Johannes.

I think the real bugs fixes of Mwifiex will become less frequently.
We can monitor these patches and apply them from Mwifiex to Nxpwifi.

If we fix issues of Nxpwifi which is also related to Mwifiex, we will
submit patches back to Mwifiex.

Thanks,
David=20


