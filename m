Return-Path: <linux-wireless+bounces-11454-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C41952944
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 08:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E141C21BFB
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 06:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24207E583;
	Thu, 15 Aug 2024 06:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ijDdrh3Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E6218D62D;
	Thu, 15 Aug 2024 06:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723702853; cv=fail; b=kYckBzUdZfzsyUT7uqtTHuqM4D4EVRhA5627p2PHeznK3kGf7RzN8C2jOlIwAK+cja2/9zmJSzg5yzcNWbpKUmMvgQXdIs4LESMU1K4QvmY9W2C8HA7K0uOU4d94jClUQGFtDRvEV4dEgzmr69OTqr4UKNzuuCZpzpmeE0nDQnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723702853; c=relaxed/simple;
	bh=CS8/9QQlWkeYEv/wZw6U60M0nmDcHFQKSmpAoxd4lB8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KuJPZIyX+lShZ8pKzYhgCeeCb151sjCk4snnu2DqSQNghJEhlFlLIzhPo1gLBKI4NLqI8w+0lIeOsnRtRMyQf7yrnh85Wf67TYJUKS6R1G6mbh+dbX9tiHRmKmxDn2Y/1EYXh8UOBekqYte5fBDUm+A1mCzORs/ZCNStBCgEzL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ijDdrh3Z; arc=fail smtp.client-ip=40.107.104.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NP9ynMC1ycKDj83p3jFQxzVnym8BZ421TZhsuF9qRk/rnVALPiNxWxkgEtkem5bVJemT9HEkKKcxnrK+Lz70+ciFOZ0Rbk1BVfO0tDFFG+hsTnicp1qe0h0BRGbOv1qLCak8F96yoNhjToro/3UPvautXKTZbQTbhB1BrVli4LYMPRXFcT10dqXNxw61VgB5iiQyUyCZn8WUTcMdyfM2Iwt23HaXr8nVzbgxNNCHphJUtHk6Vh07cwv4VnlJDyGkDBpSi+HYYcT9S2g1V7c24W6p4mFDzf4l2ozM4lPymESqWocf2SQyzmobwJ9uPfusg5U+vxp1jfgkwKYfvTOxkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUl41p+U6uEfSuT7P9y5E0vIa+B6xQU0OL3olvNqhGo=;
 b=ZNfoZkzRpiTBvJbM0dTakoadH/Uch/eGObIP1x6p10sXwahQp0dc/PJGa6f46Bw8KCacBXVU/pNqmj2FgSdsGs5FNMH8EFM3RKSa5wE8MKAgtl7fHGeDKREIDxVjcxItYzDoN8trTuf6ceziL17YC9AtsdKrWbR50s66sArl4wsKGE9lRMeglTF54iVKipuz0WchKjjbIINy6kY8ABuGI/x5X1Q7Pw9XVN/aMPUccIca2sRa3K5xp8y2geCj4iKy8oyZREsv/TSGSrtHYCxhACy600YViA0BHU/51k1pGfCClk+ex4bFjwCbIclNKG6iJGG1gTarmaboGxa0vM7/TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUl41p+U6uEfSuT7P9y5E0vIa+B6xQU0OL3olvNqhGo=;
 b=ijDdrh3ZC5W70X1wv7M5WPSFaPJ7o3/obe3PFEnofcArfc9RJfO+dQz6Z/GhtP/wZUF3PldZX80UBiGWIPoVPDymFA+2sXQ/ZHZibuE7H79T6yljApqP98smIxzrG7JzaNsJUzSDLimApSU1hVPfm97QZjwnQBY655g4Nv+WggR0/IEV+k3nGMThjNmK69Jrs0lCaSdQPWR/AsrllSNQ/Q+0hps5cSeGaB6gSrakxOIR3493yOG9xQZY9VFseN0J4hA20YR0xD2FHiN3RQWNc/7M9vbxLPCYvVVSBWHvjnexvZdS48S4wzd/s8d5iEYUmh7gBPjwn75jUZCELZtkPQ==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM9PR04MB8715.eurprd04.prod.outlook.com (2603:10a6:20b:43e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 06:20:49 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 06:20:48 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "briannorris@chromium.org"
	<briannorris@chromium.org>, "francesco@dolcini.it" <francesco@dolcini.it>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v2 40/43] wifi: nxpwifi: add wmm.h
Thread-Topic: [EXT] Re: [PATCH v2 40/43] wifi: nxpwifi: add wmm.h
Thread-Index: AQHa6kE6j/gZp6A6LU6lI8Wv3luu3rInIIOAgAB1deCAADe5gIAAE+mA
Date: Thu, 15 Aug 2024 06:20:48 +0000
Message-ID:
 <PA4PR04MB963855F4620A2E2C48B2DC2CD1802@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
 <20240809094533.1660-41-yu-hao.lin@nxp.com>
 <2024081430-derail-diocese-78dc@gregkh>
 <PA4PR04MB9638C1186FC4D56569D7D0E4D1802@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <2024081523-curator-pronounce-4619@gregkh>
In-Reply-To: <2024081523-curator-pronounce-4619@gregkh>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM9PR04MB8715:EE_
x-ms-office365-filtering-correlation-id: 9d346aef-c935-4aea-737d-08dcbcf267be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?squy6k0ZiiHhnPmeHJ1RSnUcwVCzeQl8NMCo2Uj6zJFjP48+nJskzUtsmwPP?=
 =?us-ascii?Q?VcWEArnPjMULVmR/BClCsoKrvdQ0nmGXRzjs0l6phfqbGSgUYv2gqxPalKS/?=
 =?us-ascii?Q?1ihPM8vKJmBQpVs5eQ1z9bnEGYESVHZTFi9lNpweZFCWLJr1WoaExZWoh7Zq?=
 =?us-ascii?Q?a6tu3e6ziSk+FIOp/rK5j5/aU8AH4/RL8rTIVzxn1vnbzbO3XDQ7S/++mPHe?=
 =?us-ascii?Q?/rxnjpZoAfN8GOjeZbI05Odd95Dq1HF+22jZkNSUmcZajSnYvdaPx89f4XLL?=
 =?us-ascii?Q?A/n7CxpUd5vJ6z6VBUlgqfp5bHi3RVbKmsxndpGB1MMb6UdvFa3W2SbOUuop?=
 =?us-ascii?Q?TQcDwDXq/z8A77AtdsoQfT/MYgjPSjPlFyzxiro6cKGp6iHY0WXFBPYLEnGp?=
 =?us-ascii?Q?XVDe+AF0nTyWgW5umkmRitAIz07Olk2+dXC4L/1qpnUhJf2fUUI1CTBSOW0l?=
 =?us-ascii?Q?kXkkGSbTIX6PJDgwP4CQeXDV6E6acgsacgy51bSDQ6oTlMqPC6OgoCyWa/g8?=
 =?us-ascii?Q?wLaKCPEL5dC2q/aeEZl72be97kDY8g8pLciz551kg5Mrscw4rsBa1KF0/B0A?=
 =?us-ascii?Q?g2BPOpke7zYP1HiIb/+9w/fXGFjVUM/IzM3snwB6vpj5RO0PH8gRGU6Vz/f7?=
 =?us-ascii?Q?kQzbRs0BBnrnvn5iodUd4MmxVUyuVia9oNxudlz+c+NXhq9Mn4H4vJQbQCfN?=
 =?us-ascii?Q?7MiGJzQlQ8adbT0dIWMHCteDQv+WuiORrNS9uIuRzaOA+2Q1h+PwdZaXyazB?=
 =?us-ascii?Q?+eSFMte+ubN9wFN2rjWPFMlAndxZRC1WPD6hEVnIYg9qs3+9RYYy5320T674?=
 =?us-ascii?Q?5BY7AeNS3Ef3K72XQYwVDYpd3BAvkp6t/kF+o0m+bQe7G2uQfRHZe4LUo0Ge?=
 =?us-ascii?Q?ZTtWUOM7gCzV1LotErmAo3obsvE9Sht6aIhfrbbWjGXaxLSg2STvLlKqdTxb?=
 =?us-ascii?Q?qurE2gt78ZAMzwwMlV9L0SCqdfJjbbnMVGbBKmcx8A6DGNCwmjaeG6nXLXHh?=
 =?us-ascii?Q?tIvz+zvsPlCpVzIix6y5zF452toPPMIVwR0ZD6nrge/JQTPCjSYFpRcZ6JPT?=
 =?us-ascii?Q?huF8CuxvKm/l/JqLSE2VqXzARMXTZKYhzbtTUXUvxO+3n0aoKLi4gTCARust?=
 =?us-ascii?Q?8dk7R5tsUo/e4goUPArrvs1MKG+Q8uQzAV26lb2Tzr7QNXefQpYloI9eYI6H?=
 =?us-ascii?Q?NIVRGWmz1SIeF330o2yyWWzn0oSy2eep/gwM7UWMcVECLdcrZRs0kGbD3Ovu?=
 =?us-ascii?Q?ZKoFn6MsH2EON8OZRKFkDNqkHdcG4B1YtVlZ9YsKh0QdjbG4El39WfdjK60s?=
 =?us-ascii?Q?RtGtDhgTSuTAGzGiEksk0IAJ9NfCAnG+9gKLXO4nwVJvwmB8cAWI2D74UDfG?=
 =?us-ascii?Q?qtvIf0AZjrhsnjyrN+CsgkfgO/453JXvl0tCxSYKLlQTw6fBtg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uMBoEvwQlE/UMk+W2KBFwkMsGttby/HxI5nwqybrlXAEfIKuaRP4DsO0tdD6?=
 =?us-ascii?Q?dh1unslYgKIHTgP9+QSdxAVGj/Aq3M3IuBuQqvX2CzbbwPPO5hEYetD4zTrT?=
 =?us-ascii?Q?4XTlOZG1VlQU9sjsr2u2nLGvT7GIwD9C4YFphEWGI5tf7L1kh4Hbhev7QI5r?=
 =?us-ascii?Q?N/Xg3UhtaIrZeCOLbs7zEaHMVb9MPDWuOsirJBHeW+jqFoiD9e9I6ZTC057w?=
 =?us-ascii?Q?hElgQGPwZAYfxXyDx7lFQr4m22dosF1we6cTB3gyO8gHPfxdsPUWOE9ckMCR?=
 =?us-ascii?Q?JCN+SSjnoQoj2GZVtuHXWBJ/n/x0qWslTnkdV8A/cukVhMPzbKBKgjVsPbsD?=
 =?us-ascii?Q?K6RADvD5iv7iOxh5XaIda/0xnjQ/bER0CdMOr602xEnn4pZERTy08fbdV+y6?=
 =?us-ascii?Q?dq1kIaEBztXCJukMnrcFzdNw8+HeBN1ENLJIxYt/VRZFqEAex5sTMJ/V7e65?=
 =?us-ascii?Q?U/LS/s1Wt6BkAKfMkjr7fSeP26SwqsvmZ1pK1NFvBsE3yaWUJ3hEF8BoztDd?=
 =?us-ascii?Q?qWbHOyzfcQRQPx+cGDBWvTa5YLhAVnRtzfpjSZ9ZPXARnzkyBZolzI3I7vep?=
 =?us-ascii?Q?+BbOWTc1mG+07dgHFqeqjoCdJhoJbl5s6vjKGVfcabTnAwycCAjE0K5RYoJB?=
 =?us-ascii?Q?sRWVS3nRv0OZr1p/4q5UvObAFl1xy65Ge1U3NFnKNzTcO0pCB/ULHssVoG4R?=
 =?us-ascii?Q?S9nkjtsgSpXi+IrdNvVaIWQyFLQYBX0oYyVIUxzXLZSGrxsFZaRSYTr+O1dN?=
 =?us-ascii?Q?rPTCmKfNJgo7vo9okC1ytUK6EDpTvnFDCRHXUqCBj0c2xy8EaZesqsI99VR1?=
 =?us-ascii?Q?GG+OKCIjlXmSUQMYQqHPm0vQm90LwVrBiSR6dMvWkUWvzBMEAGN5P3mSh8gd?=
 =?us-ascii?Q?vTeqfG73qE/R9XY32UmUOYk1M9bV6Ko0ATPuevEeaAlYaRcToVal9UhfMkj0?=
 =?us-ascii?Q?Rnjr9lYBuHP71+Q6V+xpBwkcl9zCEfsHc5i/BspkDFaV2QtU68Ga9GVLDxzc?=
 =?us-ascii?Q?2+jI5E696P3C1gmNRxN/hkWYDw3V5fiClCsHe1mxm54YZhgKylpqPm3SHol5?=
 =?us-ascii?Q?iXl5jYTLAluVeQhNSif2Qv4mrNJpaJkqwSUwrC9RvoJ9kY8fq0CXi5Emh2Ly?=
 =?us-ascii?Q?Md6eb2LuW+J2USbXsi5mTtKe07paI835XkvSti3KKKHJ1efrWKCAXqXuDMxq?=
 =?us-ascii?Q?1AM/2ODEkKaJREehBK/KlfFzuPwjYKEfw1EEkZJS24bRFFZ0CFds/T4mjXFi?=
 =?us-ascii?Q?4WxKJWa5DaUPxZLT+Wya/jK9LRV1uQqRHAD/vDgUuCnDYsjFzvGasFJqDLEn?=
 =?us-ascii?Q?ba87nVZUq3ouQvE6SKUzEz3bFN6faZfc4BgbpNt8HJcxGy8qJVwkvV57K0NU?=
 =?us-ascii?Q?0roocaCSJEQ8YZwWVhABNYcGV3xpUahWbhNB+63FP0Ys/9N6pmFoVSSW7qWV?=
 =?us-ascii?Q?TBWqWWFgAH/0RR54ZegK4AKIvIp5lz3cOV6c9aZ9tv4YRdOIzv22YmjfWmRn?=
 =?us-ascii?Q?Gl5IL5KubHFfxu1Zo97oCrChBpKMXk1UFFy4BWRJNN6bzEciBBA/y+bJvkeW?=
 =?us-ascii?Q?pJlFQDbKz/hVN+UT6rd2idb7CHjtvgmUvxSQG3aq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d346aef-c935-4aea-737d-08dcbcf267be
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 06:20:48.8105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T4gwjYjJmI3dH5kOq4Fo3TczH0mVfjis422SCkLgDATpONpPG8QGft9Ag68auivzaJRxKnQglfaeIIMK5R3KeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8715

Hi Greg,

	So that mean I still need to add description for every file, right?

	Once if confirmed, I will prepare patch v3.

Thanks,
David

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, August 15, 2024 1:08 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> kvalo@kernel.org; johannes@sipsolutions.net; briannorris@chromium.org;
> francesco@dolcini.it; Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: Re: [EXT] Re: [PATCH v2 40/43] wifi: nxpwifi: add wmm.h
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Thu, Aug 15, 2024 at 01:52:18AM +0000, David Lin wrote:
> > Hi Greg,
> >
> >       Following the guideline for new driver, it should let every file =
as a
> single patch for review and generate a final
> >       single patch after reviewing. I think stuffs mentioned by you can=
 be
> got from cover letter.
> >
> >       If I misunderstood anything, please let me know.
>=20
> Please read the kernel documentation for how to submit kernel changes in =
a
> way that we can properly review, and accept them.  As-is, there is nothin=
g we
> can do with this series at all, sorry.
>=20
> greg k-h

