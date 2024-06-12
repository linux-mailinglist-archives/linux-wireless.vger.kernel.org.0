Return-Path: <linux-wireless+bounces-8827-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A687A9048DC
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 04:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1B3AB23AA1
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 02:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A89B847C;
	Wed, 12 Jun 2024 02:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nsfECGne"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B2763D5
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 02:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718158676; cv=fail; b=RU8W5LaFdylBYVIzpunT1YR2zoa7JTmoSIVAM6HLll7/HAyh9WqR4OpiN86iKlRyZDUCax6c6VKxv5Lg6z5K93KuLr3XL9hTxwCMVbfjk4ghnrzueb/ywid6EbvyuhBfWC+8iqFO75toRAxUmvx0JeI1w8rxPPRWi8jIsVrMmtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718158676; c=relaxed/simple;
	bh=9h3zcx1+ZLeP6cdvcKu2wqPYc99qQf6WrNmnkiuM35E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mblMUDji5riw5TOxy2pTG1kdhBuhzJrMWkiK1ti+Fh0d7oxyLNKpJJ+iHMcuy8kx+PAGMQoa7Tu8chu7NiA7ELl5KydyC05OggRiGD3pqXUXExTgjmymNDl3F8uievJK4vMB+OtFWWd6Jc/FKfCXuEchjpT7TlxBWnAf0p64P7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nsfECGne; arc=fail smtp.client-ip=40.107.8.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4DqWXYWSHD0RwjzUtsl60dFH8c5j+06+YPEyEVr1haDxGqEW7h32XaD4yDGlh85Ji79p6HWbQLEY/qNaNWu6ghA8HgN3jWeYniCDlTYOdaqNzy99Ll4mUpZDeeAfxKP/mWXKSJLTOlG0u+ONMlDj8i/qspRtsfuhLa/KQ5cY3ocaNdTqqUfr39jOTILWJYi0nfJwgf1IveXAo5z9kPqNO5riLMh8or4iQ9Cwi+BrTPaQj9794q67OYfWRobC+o4aYGxNw53bP+8jejDWqA3HlX5StA1jEBL7nJb//fpspq5h31sh0Efo9hXt/1UdiJwPwgSWsySFpl5WkIShlYXSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9h3zcx1+ZLeP6cdvcKu2wqPYc99qQf6WrNmnkiuM35E=;
 b=Lpmsd68YXKMeBX2nOcAkELRaMpt2V1+7YvE1DxNsdqjxDLXI/sc9L2cp4fRRGV3MCvPnDV+wwb3koIIvKBAMY90gkDmeB/Eu8VhTxewgUx/nS4NDLmB4cIgiOuW4yNA+WKLSYULVMx5qjRaj92iIKiNk9jTbpVkX/jmADDJvwf3VYGW4VwDdre145BH6Bhd5qRL+TVeW0Asex4MEGtKhbnmNYPFGuXeIFKG6KtUyubnxqLw7O+zPdtlPOlP4E/0QUbbUwZI5IqU6l9RFVSPzFwNsvGFyQFcNlGpWgXI5gVPtwDr9LoHN4KPASjf7SnH6S70A8f2muEDdX2d5vQqA1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9h3zcx1+ZLeP6cdvcKu2wqPYc99qQf6WrNmnkiuM35E=;
 b=nsfECGneAA6RK8T0t128hAXpwpNvTaHEt49ANNmWXLbYuHJ2xH8q/t9JhL/KeFkkABe9pbPAVTTE99qJCuVatW38lctsCgRimPvlJTFUyf7buAOpb7rksn/LsQdaESGldSiaku54yhHYzx+wZDq2QmUay5OyF0XU2KJYU6vsGRw=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PA2PR04MB10132.eurprd04.prod.outlook.com (2603:10a6:102:407::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 02:17:47 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 02:17:46 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>, Andreas Kemnade
	<andreas@kemnade.info>, Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
CC: =?iso-8859-2?Q?Tam=E1s_Sz=FBcs?= <tszucs@protonmail.ch>,
	"linux-firmware@kernel.org" <linux-firmware@kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"lukas@wunner.de" <lukas@wunner.de>
Subject: RE: [EXT] Re: mwifiex firmware mrvl/sd8987_uapsta.bin missing in the
 firmware git
Thread-Topic: [EXT] Re: mwifiex firmware mrvl/sd8987_uapsta.bin missing in the
 firmware git
Thread-Index: AQHat1bOPSOUO29ybEOlfcnXcu6hCbG5UJGAgAE2jYCACObh4A==
Date: Wed, 12 Jun 2024 02:17:46 +0000
Message-ID:
 <PA4PR04MB9638D1FD47BFBFDDB096C778D1C02@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240605160013.6bea8d4d@aktux>
 <_pNnwoI9WHlb2EY635KdIv6t_goU-ZYp9Vav31jkFOCf9fCE9EeKdyCea2m-L8pgfsKIQvODlnQLhQqmWSYip9e6FFZwaJHL5-u5rdOS_kY=@protonmail.ch>
 <20240605174709.5043af8f@akair> <20240606101839.GA76158@francesco-nb>
In-Reply-To: <20240606101839.GA76158@francesco-nb>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PA2PR04MB10132:EE_
x-ms-office365-filtering-correlation-id: 6ec82749-0708-493d-9e8a-08dc8a85d9ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230032|376006|366008|1800799016|38070700010;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?dJmgwPPvnIMIPYSkH9qQw/B1CVHTCPk7uD9kJksDky+1Dkq6SmqYu6s4kb?=
 =?iso-8859-2?Q?1Yw/KIMeHZca9aGmbbUKCjBScObcyWcSvJlb2PKuB81TsIMjYOUGNa2Xcn?=
 =?iso-8859-2?Q?x+s8QbVblPAShskKBUW/mu8x7hCJV9MdVEYCN+sJdaIFCETbqD1CSoF81u?=
 =?iso-8859-2?Q?TRA1OB6tWfsROtgl/JryM57eWzTFSGUGvTvKm947IqiurXd96izrHd/r3c?=
 =?iso-8859-2?Q?gFKgKC7cQZp88ulzFMOtx5adthrPHIRo2RL8u5/8tu2EQsah6OuHyqmBBj?=
 =?iso-8859-2?Q?U2kcRmyDcX6+/nL+T44HZwbB936Mm4TIPM7vtg7hb3YhetGiv1lbksfPAS?=
 =?iso-8859-2?Q?cgsvD2+QapVeE8UyUZIQuUnvLQJBUx3LBDRdMNFWvyHGiV2yHInUcdVU0P?=
 =?iso-8859-2?Q?5mHIC3xVaf+6H1eo5cfPPrPuz2a5VUBkADUpWhH9bE8IR3O5muO+n2/Cyi?=
 =?iso-8859-2?Q?RPKHgPcdAERKKAEsj44vAg4UBxyQ00np2v71EbnnL2uxhqT2OHHadNTh56?=
 =?iso-8859-2?Q?hXXhngvM1RdpDpy+iMRtFB0T1KWMz6tylvAuP2XtcorDY4+gTCd9QOPv2t?=
 =?iso-8859-2?Q?tACiOWHVKOxAKU1g+bBnGbL3MlhrvDnlKpexHu10txNFCNzQGMOquNuZmv?=
 =?iso-8859-2?Q?eSjRLmy+vcNgKpiHsmeUZISqYCYeWgl8aDRdpAHbhx9j4L3gC9loEHiG2K?=
 =?iso-8859-2?Q?V0UdmmEqY6yZ5QZktzlYmyWoVKLluk3dIW+i8afGFPuvQi8zJrKpeFBOPF?=
 =?iso-8859-2?Q?M77UF1xEFSpn+EYESPyb0Q/4luLcgckfK4TIej4qRf6OCBki136Jv5kLl/?=
 =?iso-8859-2?Q?Me1NOuBBnE2ihx2Q3iybH93nOU0LHdXBE5nkyHi7syw6DH/COmKpaIRntm?=
 =?iso-8859-2?Q?uT1A2Hr/2HKO3Gi795j/jncF9PtovIVxnuotcobh2m4ckg0oplpbVpelS0?=
 =?iso-8859-2?Q?ODb1qHjknSFQfvTAmNtTOfVbOAn+iDlM6I/Lc69YDcvCdFb9XgyDZnZLuS?=
 =?iso-8859-2?Q?nE9GPI+iRmFhqel9MXMQloIuWMzNgDkq1s4n7HXIe6Hmml80OwqxM22WEr?=
 =?iso-8859-2?Q?DOwZBXYvA+z5DZgRcH9+TPArZ2KpGw9A9p56ZdpRRe6F1A8vzGGGB7qD7d?=
 =?iso-8859-2?Q?S5DZonKNAtbZwiDSdC2AUnrz2+2+gd7/1yZBJEKUjJV5pz4PU8SucMC4Qz?=
 =?iso-8859-2?Q?+rxxqZ+RUGhsXaJ6jqJsKRfhl2dNMKulmxTjyNSNnUKr79k/6ZW1QjEEF/?=
 =?iso-8859-2?Q?o5hv6l//VPMkJAL4YWgQmdXBDX9e44pbtwm+Ae3ZU0/oXPXlGT1o+9LxzQ?=
 =?iso-8859-2?Q?3rNZ569WjIxKH6fEdDeHQf2pJpsgVK6j4c+yeabuTEQyIVohgkTjowZrf7?=
 =?iso-8859-2?Q?KkUyMg9ILq7lkDegL3SDFgv5SSet7rr/FjBj3Xw/zkNnp9LLInMzQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016)(38070700010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?h41L1UNJu+8g0J2Ia1L8SDO30m5vEXWHQ43wp3tQP4+5D5nXNwkyYA6Aqw?=
 =?iso-8859-2?Q?N2nAezJdAEHa5tIBWKVz3Vnzlrc39BkRTv24xrt43zguIES1b0+4wmaWJo?=
 =?iso-8859-2?Q?1O1UN8MGRO7kyR7SUb7ALmndjtrXsH++tY7uWbMj6ODq8+CRI6wNVw5wcS?=
 =?iso-8859-2?Q?MJ5B2cpCJw27FQbifLRVZkNvZrH3v/dRabvPPL2xKkKG1k10zJz15xZUVA?=
 =?iso-8859-2?Q?NFySHpot5RHOStMYHpR6GWZu8wYukGyaurN93t5EyPrnmKAKLyIo84nxpS?=
 =?iso-8859-2?Q?dDcwvO+g/0/eCFfbgcLSCu1+k9rAoiRsihV+skM2kkg8E+CDwYRi4qCtUb?=
 =?iso-8859-2?Q?dC1EChfKfAGbRQhmOMwvysHxUip5jG0u8yrYGZyN0jwe+odOcdhR5ZiV8h?=
 =?iso-8859-2?Q?5l7gnYYtoaBzc+/V0cm1HHBBSTGy4PY1yDnGrPFaCNTY0E95vonDSbNvSU?=
 =?iso-8859-2?Q?4VUhIaZz0ST/Hrxp+KzDN/TqSeWqAHiRiUE07CP1j61A9m14m5wzwj3SGB?=
 =?iso-8859-2?Q?NyD4GRQUWzpO2BilCeYeLvLilr7XFwv7jzUhftpioBL+AkuUJCLsxCA8o6?=
 =?iso-8859-2?Q?4g7/3WFVOLY5Cr+k5SC6xsmTnnS9+jbVaeJFNq0tpUHPayj5MV4O6XzK3c?=
 =?iso-8859-2?Q?Ivgp6vJdW8PRBpIY7IYKIbUTDk2/K4ORsRJn4Yy3ZOPDbgHsyeMMzGOUh4?=
 =?iso-8859-2?Q?bsiKYZ017FqgFsYntatZqhLKyeT7jU9vIFw5cOb2Lt8Bjum5S8DKgNezRx?=
 =?iso-8859-2?Q?qC7BjXmLNFPZ2Sl1ZbhYXxrahiVtGHGgKPColNwA1jMa5DCnKCozM3z6Jc?=
 =?iso-8859-2?Q?84M4vZru/eMXhhp3hP1lOxW2FDl5Z0ftgJSJfRb9urbXzkg4z+ZnG/7Iqm?=
 =?iso-8859-2?Q?umGKj20Ice1SMKh3zymTsmBMsYk8OhItjuYEs8GPRj3c17f3qjkVsMpAKs?=
 =?iso-8859-2?Q?HzukXieYKN9U+FnaAlaEHDZRJ19Ofga3SYhth4ZYHQA6KRWCESkptojgxV?=
 =?iso-8859-2?Q?SWiB3L2ca8QMdTuH7yBZT+KOstzWhtJTVkaRqcRys5JY+JwKFa4h30da74?=
 =?iso-8859-2?Q?mlXwdNbYlHgJ5yWmhAYPJpVm+j5am8YkktHFprWo84fDgNlcbvNgj+I0JM?=
 =?iso-8859-2?Q?SIVpK1cq1Jvh+MwpoEi3+OSYvF1oBkZK9wPUU1wpYx86Il/QV5WuwYyEzO?=
 =?iso-8859-2?Q?d19dTt09GLtWDP9rozJLHIUHwsg/hyab2gEDe0dW6K1JuWQKEN7mnQqOtv?=
 =?iso-8859-2?Q?hSo4pazFgylJfiSfuYg018onNAxqDMmn5xtanRE+YCcGTXwhOxDVWPUevM?=
 =?iso-8859-2?Q?1SPA8GxFoj7taWLw23pVLTFtKtxt+bEA6+yRIBYvty+r1bOcVJrmhhnP00?=
 =?iso-8859-2?Q?HWorkmgtwhqBZ9gKzpTeQor+CQKvuHPudunLkJHUNj5sFtCuiEzknVnDdF?=
 =?iso-8859-2?Q?Nm74cH+OyAK0FtoJznz0wqWbYc7oLMH87E+FCc5dP2E1dVC6Ot5eBrr5Gs?=
 =?iso-8859-2?Q?CR+I73pYl3ttgDdHZBi0UXTV3x9o0InCGT/EOEZz0jTbrSeJOB4wMYH6e1?=
 =?iso-8859-2?Q?wZdV49J1f8CEpPZnfszCv4ugrSlK/4Fq6kr5uaRbIwsdfRB/AftsaGk5j+?=
 =?iso-8859-2?Q?Tok7BZW/uxnj0RZufqSOrZmeNKPiiDF3Nt?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec82749-0708-493d-9e8a-08dc8a85d9ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 02:17:46.9099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wf1HAaWYAKOtPp1lfn2Xfb+RpbaLcEHTDmJxrsAnNXjNw6jqTa2SCAFBJxXqUdYbqBa1gUDPmGBSMbZtJhPL/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10132

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Thursday, June 6, 2024 6:19 PM
> To: Andreas Kemnade <andreas@kemnade.info>; David Lin
> <yu-hao.lin@nxp.com>; Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Cc: Tam=E1s Sz=FBcs <tszucs@protonmail.ch>; linux-firmware@kernel.org;
> briannorris@chromium.org; francesco@dolcini.it;
> linux-wireless@vger.kernel.org; lukas@wunner.de
> Subject: [EXT] Re: mwifiex firmware mrvl/sd8987_uapsta.bin missing in the
> firmware git
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> +Neeraj
>=20
> Hello David, hello Neeraj
>=20
> On Wed, Jun 05, 2024 at 05:47:09PM +0200, Andreas Kemnade wrote:
> > But that is all legalese and I am not a lawyer... Best is of course
> > something officially added from NXP. No idea if it can be done
> > otherwise. How to make NXP add something?
>=20
> Would it be possible for you to get these firmware files added to the off=
icial
> linux-firmware git repo?
>=20
> I am not using sd8987 myself, from what I read in the thread probably som=
e
> file name would need to be corrected (I would say in the mwifiex driver).
>=20
> Thanks,
> Francesco

I am not responsible for firmware release.

You can get updated firmware from https://github.com/nxp-imx/imx-firmware/.

Normally the firmware will be merged to NXP Yocto project.

Thanks,
David

