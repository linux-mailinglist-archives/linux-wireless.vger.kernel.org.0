Return-Path: <linux-wireless+bounces-20772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868CBA6E01D
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 17:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0540616D6C1
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 16:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FE31CD1E4;
	Mon, 24 Mar 2025 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zt3+UOOH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2069.outbound.protection.outlook.com [40.107.103.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E44625D1E1;
	Mon, 24 Mar 2025 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834860; cv=fail; b=IhJy7NDdKZMe8H/Oh8UKDr+iiYTkvPpAZlpTZhoS/bxafu39lxkXUJ52CYaVnyGfIj13b0h5ntXYrilhgM74yAhLMqiF0EdTbDgVg4+6iCbMYErRYw8FazgZBK7xxNhqSSJMBpJGyztiX7m6W5+vpW3mtga6+N/t3JZG6JJNbTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834860; c=relaxed/simple;
	bh=ET3XbMlX6Kr7DJdf/cNXHtN90Xpp34d0avV1ClNGllg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C3M0aqoXg85roDCQ6d/wr1QC1pglReyr3sJruuzaC+VMui550nw2Hysi79Jd/AZ4yUkp/6odcgldiWL2rI+ZISBdAUoqtc2c027wkTARnBlXw5GD3GCl6JonMb7v/SbCu4TBf1BehQHdPM71bxyLNdfPWmZAKuRfMr2W4/4tEOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zt3+UOOH; arc=fail smtp.client-ip=40.107.103.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlPF0rq/DmSdnPO7rjnj5St+dkpekV22MIvmKETiYUbPuKBEoOCyhE/UY3gXvjVkuKkZV5p1XMEOzEyDv4Jln8Zn4AobaOozykgnTZZAb4Ef29wjwP+WDmZYntmKonr/7LY1k8CwgRSw5Dpb22C5AQa6NbGbFkd+Fy9XvwEPCebFCx7anitWhMRowtTT75pyD5nErF8XtuFA6YWrzS31cB0A5vHRlXnNgBGhGog3U61yxDPLLb+d5FYcsUuUXr2gOOjRrbvgwM7XypA4FC4D2zhdT3EB5/qGYYmN65AuMUUC8GKXsGfHNnO7BfTfxvqhkYwdG9Ns0FI98a6ukbtpQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ET3XbMlX6Kr7DJdf/cNXHtN90Xpp34d0avV1ClNGllg=;
 b=X6/+qMwBYR348LOWrfi//nvaIV7bcXeH9WkcVsWMoJBARfqIv3OGkclxytBQFybgUwSUs3fsBkqszXI6ZwKIANa9MxRaGoicBpM0yMFx+IRfUYDLsuprjDb61S+oCdK63pQ2qxmM2ILR/2QMtpH804UvUrOAcVfCEhLBNAn1uRULDm12wBdJPwBDtdN1+wE1LxH84PlKGsbFL0NdIpSxx6QjyFOYKxxvpyeRCvlTvwe25LqUU7juzrEUwiNtFFFJAlJ+IJwnKnUckzU5lBlypbhUkLYLCI5js/ej5mfv8RVBksBYwSHJmaeezaLxKZyodXghxrQF7V1gsF2YhHEdfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ET3XbMlX6Kr7DJdf/cNXHtN90Xpp34d0avV1ClNGllg=;
 b=Zt3+UOOHicCZNhu6THD4xWvElGjSyObZG5uUyK3kwfvrZ8nxq+trdiXCZYFjBXv66WA/heG5SQ2JYritP78hO3GC8cYu5nHYG2Outr5tornV5FdSYXwAyMtPP3FPaNusbypkEaNClq0fwUnG0LOVlE8rd5r+O3aFuICz1Mk//hOYg1cw/KnxHPlyjwJcFZ8JK8sk0kO4jobGay1113CA0IPHOJWW1lx5/0hE4UhC5rKCWK0F39Xs+Av/4zscMiKeM7AawRqF6tZaD/KXP7ETQJ/25Uvu/kkk9ILNQkAIFiepIw8EmdLFD8/pI/wploVBLdJHr0oNh4wsDOjrN8sWZQ==
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by PR3PR04MB7482.eurprd04.prod.outlook.com (2603:10a6:102:8f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 16:47:34 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%7]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 16:47:34 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v4 2/2] wifi: mwifiex: Fix RF calibration data
 download from file
Thread-Topic: [EXT] Re: [PATCH v4 2/2] wifi: mwifiex: Fix RF calibration data
 download from file
Thread-Index: AQHbl8POAsvtZwMDWU+9/b7JncVaoLN6qSCAgAffiIA=
Date: Mon, 24 Mar 2025 16:47:34 +0000
Message-ID:
 <PAWPR04MB9910B875495307CD3FC0BD1D9CA42@PAWPR04MB9910.eurprd04.prod.outlook.com>
References: <20250220061143.1417420-2-jeff.chen_1@nxp.com>
 <20250318050739.2239376-3-jeff.chen_1@nxp.com>
 <20250319163113.GB46894@francesco-nb>
In-Reply-To: <20250319163113.GB46894@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR04MB9910:EE_|PR3PR04MB7482:EE_
x-ms-office365-filtering-correlation-id: df7de8ef-c337-4b3d-d9c4-08dd6af393bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?W8aQxov9df6t4aiYbsMAjrWgM0rfb88FL/mJGD4D/n1faYYWyPU9HY1iCFvW?=
 =?us-ascii?Q?dGLVkBIBU9iwxVJQR+4m/Fa7CZQeVMo4JZWQCB+Howv7cETQLDXSxGhnJzOM?=
 =?us-ascii?Q?YzGW9O0NIjAzu/Y7jWyfa3aOwQ6+ey78YiM5iMC5YHTDoLI2tSPyVxBy76Zg?=
 =?us-ascii?Q?nhwznPybnn2eaCg0SasQShdIKTzIORM6ucC/kDlDiYmOHyyocKIQldu3xfym?=
 =?us-ascii?Q?etE8vjzGUwRTjoe/1ZhA2Wp/jVTZ1oH2+LFbd0k4zQV7lxSyAxNQbvIc8G2a?=
 =?us-ascii?Q?CY+fHUIwVKOmkKypUDgAl0mi4LICrdYcQkdzYUFNbHd714UT+I5DKJyHNnhf?=
 =?us-ascii?Q?cqT2BUAfAHu03ounonUh1Qh5arg5JNh7rJNI6SFWGjyWLUwj/9S2TlS2Q/SN?=
 =?us-ascii?Q?sgtHstHz3rhZ84WUfA5SNnLJ53TIGu87na6U2+PXrQCgqkZUql3CUW+TJbmz?=
 =?us-ascii?Q?gEuvJdeS1kwGGbZMwLmttWcrmHFP2nl4JT/aNMP4C6s+5selgOCdlVXdAG7v?=
 =?us-ascii?Q?WkzstkeEvs9OCVSfzxS2uJoX94Ifd+BYLeI6knYDD8BPiLh101ioDPZfhmz6?=
 =?us-ascii?Q?ueZa4FwP/I+4b/vYjcw7yYJuP7txIHSUDOIyBPJmpdpUVtrRnSYmY2hO0y4/?=
 =?us-ascii?Q?M+IBZMr+/Xm32zq0EbwRK+WiZhily9lkSOftSFquk/EUxwiChO1PX8scluHC?=
 =?us-ascii?Q?idJl/qslQh/D5fAE1Rj9bdAhfxUkbEZ3CFEqxZWP2Pt09JoUlnfnjm3rurcO?=
 =?us-ascii?Q?EYc5ggaabwQDFXIhFOzyP44PstOJROWsNvGWe/f0+qqW5OYaRJGZTrW2GCj3?=
 =?us-ascii?Q?WRkTmUmksMA4m+WhcPt9q6dZpcN9l/rE69wVMZ5VFKJoee5e48zl/OsyZb7i?=
 =?us-ascii?Q?pWqwZ/z8V8KeulVTjvQK8J75gazFsm03sA6HRwY5MmziPPtN97XIA4GkOorZ?=
 =?us-ascii?Q?NwTUFAzbFulGYslaBMCNWQQgyi7wjDUb+7bTJqQIpOotDrBi3+UT0NBxw/bj?=
 =?us-ascii?Q?8rSSr7bgfKjcrwPQ6j6uCFhsTRbmbNZVwEv+7JEV3YvkzomyduJO0imdrucf?=
 =?us-ascii?Q?qr0HkGVeRTYLFPjh5yXgIy1FVmfTvJh4NNVic3z8L5wCM9wfznBkpCLEyVci?=
 =?us-ascii?Q?u47EtYU42ZObdrpq/S3t9ddIWoCpAOfZiVnq6J0U4Ak4cWvTQT3hvRLg1A4u?=
 =?us-ascii?Q?mo8qlqPqItXBXNmIBnKW6pB1CspJsDSC10M7T3Tst5Nu+X3Os7hCiWj9VfIk?=
 =?us-ascii?Q?ebxkD2WZQnSrvPuO8hv0zpIz1BMSWZYzZWFUFSKqzB2yOzvrBgrRhgiDMFjN?=
 =?us-ascii?Q?b/K89cnQw9NqLaFWLGwwGsP5Qio7tRuiLzoqUxqGrNmtwcgHT1O8rQQBWnvh?=
 =?us-ascii?Q?dqkSkmT4jzDxEsyA/MggYA6xWDshchliFLK6r8m+wB8r56+uzlxv9NHVkJ7m?=
 =?us-ascii?Q?O3d1slouudyS4xO3if0+oeJCeUBlkNvP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wurErTjU4IisiaVyM5RVKexTdbaSMeQFUK2z7g2N6qFq68WuSXGhe16xw6XD?=
 =?us-ascii?Q?Dlwfhs/Txe6TbTM1I1sbs3kLsKVr79bOzzU4BAZ8a9q8RXXyCSlxJ9T82wai?=
 =?us-ascii?Q?8Yhvk3eibWhG3pbnI0eccSUNGUM/O6af0ch1kQ8Ul/2zWyXMlgSWG55Evh+s?=
 =?us-ascii?Q?95POSYvvr5vaac9GOdqgQ5NyuI9GKjQ71QhSbVCLAhOJYtKfjwVQfKec7wqh?=
 =?us-ascii?Q?v5rkL7dZgWHI4RG4n8xkPl4t54A8aW2yJklBshOMhqTrsJGPyyNwTZCa+FBA?=
 =?us-ascii?Q?OLEYzC1tUYdk4R9SR6hfaKtUeaH3L77/W0y2Cs/HyDhfmFl9QiEhKGe8BdeR?=
 =?us-ascii?Q?ydiphHB6Od34pNpX6NZNsKrhwgMSwuGbdpfvQ5d7Pl/fZxYcU+O132fnejh6?=
 =?us-ascii?Q?njVt4Kiqppq7YOks4ZdKM9pqj2jmibyA9r/O8957C2GTJAR+KiQRWDga9+/r?=
 =?us-ascii?Q?nZnSJrcIa5bXrEn2Hhz8CFqNeJJDB+bfiS/SoxkO+iMSsRbboWbs6mQzp/XC?=
 =?us-ascii?Q?hGwERpVLBqTIlO+THZZqm3YKHBrntydUrMuF9ad30DMdfnrNhTkMyBrIEyUs?=
 =?us-ascii?Q?z/ys3PSnhx8bjwk84cbbtc3zJlltBJwlBAeit6/QP3AxZ1GxqE9eC0fKnx7a?=
 =?us-ascii?Q?0TcI+bEKDv/nO3ujhgVcO/b58kRCWmUvU0zxByAyCJbG5fQS19n1KZiO9Ops?=
 =?us-ascii?Q?SZojulNKMP5URFcsvd86jno//ZC10fT1p3+s68/hCaNoszIe7g4KfUtTNFfa?=
 =?us-ascii?Q?/jF4lfkeynwG5kXolk3coiGG21UqHGDXR9A2jxjIdRBji/4VxZ+Ze5zIZ3vW?=
 =?us-ascii?Q?6XEZ2jLj8IOOYM9C+qS19l2lul9gPyfLFHDvbkOHKjjYeHxPcfqgvc+tySgf?=
 =?us-ascii?Q?apzISyktyHH5fkwUqTQ9EcfgrDi5HN2SpwKqLp6HGEHssLL9tNO5/ipk/kzx?=
 =?us-ascii?Q?dERHXPQr58hEuea8oCr+FYFfixhftrMDX+Y5YsfzDQ0Orxuap1MKsC8DlZYP?=
 =?us-ascii?Q?2FUFI3cMnUVq2e7HTdCpCMUn2moJJh+PCmQI5I46GCUpkwyVi9K/beUu2pqY?=
 =?us-ascii?Q?2iw8ZzzjGM3zkYunyMUUgCr6EQMhp0A/0/QWEX3O6dyB3LFqgSHlGpw3ssLQ?=
 =?us-ascii?Q?Z5OA0kil5m7NziJlOXIRKfePFcDMwLkUZzZYtKiB9hmx2npi4GeLlJF0xH76?=
 =?us-ascii?Q?G+nNesup6Obh+hqc7ihLIo2c8BL2TicuDAXZQpTAbHJSD4QzfJtgz5StSPG0?=
 =?us-ascii?Q?OtPhwr4k2x4xC4+FbcJ2025j7ZTZv7TSNGdxdmKvXOeATJ3cv3W+9WyTyQwU?=
 =?us-ascii?Q?cH2JIIGtonMpJolgC5AbZWK8ECphIP1LzG3jOx+1Q6NO0orhBntq6lAGRoRp?=
 =?us-ascii?Q?Rncl3JMhD/eoa/x/TdDM9OUSd6HAlh9K6797WrJOqndEunZtXtKhyVA5Pra1?=
 =?us-ascii?Q?wxxMkvNDmS3r0AYVEiFF0lzBqpzyXHvdmkur7rrgdCxpxdsUvzYHi+MOuo9D?=
 =?us-ascii?Q?mCz+sLeFy/90L0ielsfyMCKzf7infUdqJ1YGTHlEmkUPHDA513+bc2IoOqoq?=
 =?us-ascii?Q?PRbenUeyq/yy9qOcoTR9SZvs1WwR0sockr0lKtZP?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAWPR04MB9910.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7de8ef-c337-4b3d-d9c4-08dd6af393bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 16:47:34.4684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0vKjihul8eBq801IZclaBIsbGrvD/gnaLEWI97cyeTkqb/7QXHGpWkHkzm/7CbV2fV5XosnzneejT1U4nM7vOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7482

> Hello Jeff,
>=20
> On Tue, Mar 18, 2025 at 01:07:39PM +0800, Jeff Chen wrote:
> > While this patch restores the ability to download RF calibration data
> > from a file, it may inadvertently break the feature to download
> > calibration data from the device tree.
>=20
> I do not think this is acceptable. Fixing something by adding another bug=
 is not
> ok. You should fix the calibration data from file, without breaking the d=
evice
> tree calibration functionality.
>=20
> Francesco

Hello Francesco, =20


There seems to be a misunderstanding. The issue with breaking the device tr=
ee
calibration functionality was actually introduced in version 3 of the patch=
. Version 4
resolves this problem by ensuring that both file-based and device tree-base=
d
calibration work as intended. =20

The current patch restores the ability to download RF calibration data from=
 a file=20
without affecting the device tree functionality. I'll clarify this in the c=
ommit message
to avoid further confusion. =20

Best regards, =20
Jeff

