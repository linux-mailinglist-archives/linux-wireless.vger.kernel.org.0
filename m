Return-Path: <linux-wireless+bounces-20004-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B6BA56E17
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 17:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66A3188BA60
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 16:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8C823E23C;
	Fri,  7 Mar 2025 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iy/ex9LZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921431E1E0B;
	Fri,  7 Mar 2025 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365657; cv=fail; b=H/F3M21lpP/yrQZ1AqAJUPyvusGaCp3Fm3cWfDCHWo2bAXgHmY0FJNgMzRoMOYcYvUskDXQrLywrn+4KDEICIXxzmTEHcmvgbSeSGT7RG+TlL/coy/lV/ijo3L27z4QVYfHdPwJjt6++iGr3qbT/SlgT1ilDAu2HDuVsj636cqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365657; c=relaxed/simple;
	bh=m+2YGkNrvD1MYAFoRJ+s0Iw7abLsWoOcR+sAJP75FJ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NzVxP5aQ+qa8bvhoHufbJh38bo6zBado25wR9apl249Sh2qoDqRnjwWCw/YA2Y0R45JxkkFBroc+Zs/La0j9n2UnUq4IByT0QxdoeD/4c42pKpr0yW7T65qx8sUd/R44CjcmQKm+sxPt1TOsBfi1uRCXi/pobRKyUvZQmboEzys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Iy/ex9LZ; arc=fail smtp.client-ip=40.107.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDphiBuF5/g/n8aB0jWPOXrGpjhA4JxTlN8007quqVCCBbyFPOJ9vHvi+2N0xY99EAMbanRU94bzhUsDkgFdfa4l2VaHNmGs9Oacy1qUKUAIYWiKx3/I9QhqynLzkq4XRm+f51/4/dW8DIZFWgalcim4CcIBCi5ZFdRcSIP2JiWJa4rPfAnBkmU6CtEiojEMktes6ZFCxIsNiX9mqshiIrpdS175i6QlqY3z5zBN1jws80gA9oEIeQhkDnXdHY0FhqWRXO9DPrbOet3IVmqILZs4hGMQHkGOYzTnpZZ7N8++cv0Qtx3IdAoFNu8qZGQguPyyuQBWmBCA8PbccaOF8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U08ZMxVIRv2oUWwvIXaV5EkzQ9rNYJmf9Vb+BSGAF6E=;
 b=wfhcPJJDsxJ2bXT+pGtOWdpiaC5pisJUnqLCiGg32ugHANGA9Ry0LBgIT/SXb1YK3JMh+kgMwQYWUF+8f0YRtyzQckkRZLRz1ltBWOACejB2H3FAezHlXrTtRZm0oiO01pbUOoZizIqD/B/5qoRWFvNYBVOsBcxNg4RUTfjgQtYsaRs/Zyurhbrwr63WhtC37cE7DrM3UgowN+i3XWLIo3ZDY3VSA+DeX/Bbai+BkPPRS6k6z9IE4TQbxrguereswwyrujJ0sXFKtVW3U7qg+HkNqvGA9+IUDThHivwC0WpygaQo7HU4wdlRIc/KmTYMlWz7Kwow5EGbhxVVKijXxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U08ZMxVIRv2oUWwvIXaV5EkzQ9rNYJmf9Vb+BSGAF6E=;
 b=Iy/ex9LZT90V/ptfyrsSlIw82bcA/9uvyLDqGSV/hFWQVT2b8K+Pt3lNwj+TgbgsRCJn7s+bw+u4X+n6MSbm1attchULZpU1aZvEPKtacMihOPYAXbvt7M9ln1Jc/esOiuBcEHaeTwlthhGtCZyvreudWNp4NPzFFvrxF8Vf/FdaI/xHKE3PngSQdncp1iDdFfgN+gx1hImO1B/uqEWAWUYNroeDwfwyY61nD09VIOZw8KfmegckFR7ZXB+TDVlTGYEev+q49/AbdQZnoEqBRTVCKtoqAzR2ljXnQnDV36qjo0pwHIS3N8MM+hpUwQfnlf51T+LxvrvA7h1jHZy3fw==
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by AM9PR04MB7490.eurprd04.prod.outlook.com (2603:10a6:20b:2d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 16:40:50 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%7]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 16:40:49 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v3 1/2] wifi: mwifiex: Part A of resolving the
 failure in downloading calibration data.
Thread-Topic: [EXT] Re: [PATCH v3 1/2] wifi: mwifiex: Part A of resolving the
 failure in downloading calibration data.
Thread-Index: AQHbg169VzKoEXZwK0eMaEcMzvKUbbNmAogAgAHfUJA=
Date: Fri, 7 Mar 2025 16:40:49 +0000
Message-ID:
 <PAWPR04MB9910633CC9A1E7C98401C9C79CD52@PAWPR04MB9910.eurprd04.prod.outlook.com>
References: <20250205012843.758714-1-jeff.chen_1@nxp.com>
 <20250220061143.1417420-1-jeff.chen_1@nxp.com>
 <20250220061143.1417420-2-jeff.chen_1@nxp.com>
 <20250306104346.GC19853@francesco-nb>
In-Reply-To: <20250306104346.GC19853@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR04MB9910:EE_|AM9PR04MB7490:EE_
x-ms-office365-filtering-correlation-id: 108255d8-fadc-4d66-49d3-08dd5d96d187
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?v0UgPE/m0YOQ5kJLvfA7uKfKP54XqeNK6mxAaNOoBLj2WUbL5W5qzrhcyiyN?=
 =?us-ascii?Q?zjs5bfx9gu3L6vdCOLhqhchAqirxxENRbd5kamObTjWZWL/llBDd8rdnlCi+?=
 =?us-ascii?Q?z37gP/dRQOpz6QczlkLSKTNwFMfbLBJeTKMV3ODA12d51CCBtoCTRGg1bLUU?=
 =?us-ascii?Q?uM++wfLfVZBrAFWd77gZRcEgvL2j8TBlZGOGwLMsu5u2bCDoBMvWrfeWVq63?=
 =?us-ascii?Q?Wf02aJWLGMzOb+9oy0z2G4p6e4OlS5TkLYyCpNNQ3BKr1o7RZuB/76wBrpCH?=
 =?us-ascii?Q?GgMpOVzuogjBANJmUVvCGf+eVT4lG07bL/68petETc6qiTGJaqvXtYxQ/jP9?=
 =?us-ascii?Q?63IxDaZ3pi9VQVQ2wHHpOZ1nrjUWLlCWTAX+McvmJtyX+7H96Bh8yxcyaMgI?=
 =?us-ascii?Q?wYEoQt4Cd+o8x/CX9ghR5Kcw2I32YbiKe4Y4smUyhYfTLxxmkfRjIinGhkYe?=
 =?us-ascii?Q?ADUgEklpPVKBMhLXR5Qe5UwRPRXd9PEaAPHMniheX/nz98s72Li7V62LlZUN?=
 =?us-ascii?Q?YbRlZHJLNodzQuo7UKdnsCwTP5vbvuSnkGiBd82bZANzcWtUfukcFt7E8bYU?=
 =?us-ascii?Q?hJUmu9ct+mHqklNLtUg3XPwmaFHcYTGfpeqbZrmlN/49neFphbtoHH6vo0SM?=
 =?us-ascii?Q?lknCgpauJfsH+B7ER1ICScmEqW81hwJIIHpGm2r6OkBrjADyc1QVsJ7LwZnI?=
 =?us-ascii?Q?IBOML5LKHVTZ0/ySmJBiUCzyzgllHvEi/vzwBqtYRwsM5zgUPHgBEjsVImHx?=
 =?us-ascii?Q?vMWJbbIKMestJsNkOM/52C2IjhntXvR22QF+SC3jKkskpayG/MjTx6KMymAM?=
 =?us-ascii?Q?HEF6dxchSLRHNZe2Yvp4F8AO6QP3l63CKyso+4L8AGRrA1ZZYZ6EhMqKiKZ9?=
 =?us-ascii?Q?0IhQDUvva7edMYmMxC7Ddzm0E1q+FPAdLXt9TqZpjBVtj39SBATVHRRGJO8c?=
 =?us-ascii?Q?N2H1BOpI5xdSSCq1lF4xKmNUhdBRkxsU1pseFoYbH0kc2mkexOxap5Z9ySZb?=
 =?us-ascii?Q?ewSDfXoAbMWCFoOUuc3LQ/uY+aioE+ptxFSDGdoW9a1+rXX4LiUZw225q/qY?=
 =?us-ascii?Q?zcm9wfSXrwJ01efdbbILr507DeBvz8ASeqfZzMnRAPjsXLscB9hTgzA5DLl5?=
 =?us-ascii?Q?Ve7a9rKafY9V0YmjLthFAPeCMKW6AnubodEa62DGruR0tON++UCpWTIQEcCq?=
 =?us-ascii?Q?lzoSCMqSpvW8MX91uK3wAJZ0G7ngjO1RIb0yNLxLPfD3zITdVB3kEIBbIGiy?=
 =?us-ascii?Q?EHnGlvBecQkYRK0vNlFu+qXSZHi66gTXaBxwJU7yFKk0wf78YzP3ezfqdZMJ?=
 =?us-ascii?Q?UtzaFONPogxmnfrY55Z4AC3Ar3YbFCrflD4iGlC5aaFxBhGVkJNa/N3xAi8X?=
 =?us-ascii?Q?l1F3DJs2cDKK4sx7MQvgkeVbpSoxuav/qNsbQl7c+R213u461MDMUywtl6GN?=
 =?us-ascii?Q?JJD/6tFFbSF3iJZLKbivrkPRPtwlknGm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/HIwkD6zGqiH+qkFwX3XVizv91qXpnb/Ir5+0T/58DjKVallqMBZ/Jujc+tf?=
 =?us-ascii?Q?KcT2yyBzaVj4WzRh8I++xGnyq61q7jQGoj3PR46p5h0IAUKXb7CGPALMptmQ?=
 =?us-ascii?Q?hY1YmRgBXqLBKCKpKjN0HROsrbBBwf89br0O7HK9oPpKmsq0hEWYBounUr67?=
 =?us-ascii?Q?xbZSLDjatVHD1VSJ38Hgur49XD8DlBExaRnXxrBPHjTfy3Xg72WQGB9v6Wr+?=
 =?us-ascii?Q?8KPiwA4+xZErJ9pKtHpOY5IbPA/bK5OrrFnk56BSozV6ie/Z/tB6uOm2VBll?=
 =?us-ascii?Q?bTOPhiLukmaviJU4IG/5Vfi7dvrTZPNneklBlguZT+h9X3rchSNm8xAXJdZk?=
 =?us-ascii?Q?xM371XaLSyBTL2QTELW7ifMv0Rrpqy2mAEJZPxv9G+qaYDSr/pg9pxGpoDvd?=
 =?us-ascii?Q?u9KLvwig/8g+n9Aozkqn7Q7p9J3X3SzrO7R7rSYS/zq7qe/smKU9NxKQhlO5?=
 =?us-ascii?Q?o1Gyb2TbyduqXL5OajFIWc7Sn58nJ+IH1l77RPydLUKCV74JO1jQsc6lKeEC?=
 =?us-ascii?Q?G9YxWpCsY8floQHxyvx9zpmKkiz9bqlg5OvSgszRDz8NyfV41g1blJTcPFEJ?=
 =?us-ascii?Q?ZB6CNUobWeiqysfo7TIG48IrE7sbEQBUSkq0pGv34ywZQCQAREbH8CFXAwHA?=
 =?us-ascii?Q?DVl6ytEjQ73mN50P0H+TT8IYR/FOWPIqXbvJKgtHqL8ePyR9K1+bDtNJ1rso?=
 =?us-ascii?Q?lzMmrCJpkt/KXlI8hrt4DO/Dh6ROuHSG4qHamRuYQ8kGsFuCrCTNXazAyPz+?=
 =?us-ascii?Q?pc3ryQ9uhKOreONt9Mae0H7wQ3C+31pe3FMcy9HIOWOWB6+mva777UfcUTV5?=
 =?us-ascii?Q?fpQpOfl9mtP8+SpDav3YDzrAeRuCop6MtI1QlIhv4vOM7kQyju2ijDaHFP+t?=
 =?us-ascii?Q?YDJKO1YHFvwWv/cvPMYpj7aN8aM/Qds0pgQA9VsKhNor3oxIr5+RshT74mV1?=
 =?us-ascii?Q?lzlwBZGp4IgE7guKLIsxF0d5uw0xgpjAis/gXAv7qA76TO7jr4nHrsO+VLGv?=
 =?us-ascii?Q?AEeiR537apdgq6OnX82R0NZnSBlrLrB7PPgBO6bLsXjgmbVXIrFRoQCHFKZp?=
 =?us-ascii?Q?LjgY1+nBMj6syrustCNrOyGM7FMwpE/TQC+K2+4d1wND9TnrnOeheneFCq64?=
 =?us-ascii?Q?GaaMiaU4Xg1zgy51KR4Rb+M7kkaoyBOOUnav/prC2MBEpjAjqrR5GvzCTeAb?=
 =?us-ascii?Q?N3NUalAYmrWu1veRD7X2VgfqNAzddbd9DUcwRpNs1seOUDBAIVQ978x3LWaw?=
 =?us-ascii?Q?68crUYBhzdy8mwJRG5O6ID8NLn3F2ORr/tlwX8fSZa3VhpBzM8DgclI4cifw?=
 =?us-ascii?Q?rkIy8zfuLn7m15IIKHLYapur+U/sIouGjPhWeHkTuT8TsMNbRc6h897VIMO1?=
 =?us-ascii?Q?iWpqD+1R7RY73KQXGT4f6xQQkpNcREHMtWqfdioJQOexkYTAXGDbU44G2EjW?=
 =?us-ascii?Q?eREjILvLsvjtUKOr9h9EIX7Y697ctkn3hqpszMKckZEMDb0A0FyVZvF/YNkt?=
 =?us-ascii?Q?a+xrTy+uljx0t3y8jXnOU0o2shqubhbi4iYUYAoKOfVl/OS3XZEhSs2hf/JK?=
 =?us-ascii?Q?plJOWFqVLW4cDLTfO4CJVir0HfA0OiFW6oVs7s2w?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 108255d8-fadc-4d66-49d3-08dd5d96d187
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 16:40:49.7982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: POYozilNEpE53qoIlFH5t1+htH1+w+82lgE5Uqr7+v0Fjc1H4AygXENQvlGPNVY6wG1Nk+1qNWKwPHYP8gMLmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7490

Hi Francesco,

Thank you for reviewing and providing great comments.
>=20
> Hello Jeff,
>=20
> On Thu, Feb 20, 2025 at 02:11:42PM +0800, Jeff Chen wrote:
> > This patch corrects the command format used for downloading RF
> > calibration data to the firmware.
>=20
> Do we need any fixes tag? is this supposed to be backported to stable?
>=20
> Was the command format always broken? Do this format depends on the
> firmware version? We would need to explain why changing the format of thi=
s
> command here is safe.
>=20
Yes, we need a Fixes tag. It appears that the feature to download CAL from =
file was broken by the commit below.
commit d39fbc88956ef56a67b8030d53c7e8fa645a4e00
Author: Bing Zhao <bzhao@marvell.com>
Date:   Fri Dec 13 18:33:00 2013 -0800

    mwifiex: remove cfg_data construction

    The cfg_data buffer will include the cfg_data structure header
    (action, type, data_len). This makes it work for all data types
    without extra parsing.

This patch enables the feature to download RF calibration data from a file.=
 I don't think it needs to be backported to stable.=20
It doesn't depend on the firmware version.
However, I think it will break the feature to download CAL data from the de=
vice tree. See the code segment below.
'mwifiex_dnld_dt_cfgdata()' also uses 'mwifiex_cmd_cfg_data()' to prepare a=
 command.
It would be better to add a new function to download CAL data from a file, =
instead of modifying the function `mwifiex_cmd_cfg_data()`

int mwifiex_sta_init_cmd(struct mwifiex_private *priv, u8 first_sta, bool i=
nit)
{
...
		/* Download calibration data to firmware.
		 * The cal-data can be read from device tree and/or
		 * a configuration file and downloaded to firmware.
		 */
		if (adapter->dt_node) {
			if (of_property_read_u32(adapter->dt_node,
						 "marvell,wakeup-pin",
						 &data) =3D=3D 0) {
				pr_debug("Wakeup pin =3D 0x%x\n", data);
				adapter->hs_cfg.gpio =3D data;
			}

			mwifiex_dnld_dt_cfgdata(priv, adapter->dt_node,
						"marvell,caldata");
		}
...
}
> >
> > This patch is a split from the previous submission.
> >
> > Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
> > ---
> >  drivers/net/wireless/marvell/mwifiex/fw.h      |  7 +++++++
> >  drivers/net/wireless/marvell/mwifiex/sta_cmd.c | 14 +++++++++-----
> >  2 files changed, 16 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h
> > b/drivers/net/wireless/marvell/mwifiex/fw.h
> > index 4a96281792cc..0c75a574a7ee 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/fw.h
> > +++ b/drivers/net/wireless/marvell/mwifiex/fw.h
> > @@ -2352,6 +2352,12 @@ struct host_cmd_ds_add_station {
> >       u8 tlv[];
> >  } __packed;
> >
> > +struct host_cmd_ds_802_11_cfg_data {
> > +     __le16 action;
> > +     __le16 type;
> > +     __le16 data_len;
> > +} __packed;
> > +
> >  struct host_cmd_ds_command {
> >       __le16 command;
> >       __le16 size;
> > @@ -2431,6 +2437,7 @@ struct host_cmd_ds_command {
> >               struct host_cmd_ds_pkt_aggr_ctrl pkt_aggr_ctrl;
> >               struct host_cmd_ds_sta_configure sta_cfg;
> >               struct host_cmd_ds_add_station sta_info;
> > +             struct host_cmd_ds_802_11_cfg_data cfg_data;
> >       } params;
> >  } __packed;
> >
> > diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
> > b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
> > index e2800a831c8e..6e7b2b5c7dc5 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
> > @@ -1500,18 +1500,19 @@ int mwifiex_dnld_dt_cfgdata(struct
> > mwifiex_private *priv,
> >
> >  /* This function prepares command of set_cfg_data. */  static int
> > mwifiex_cmd_cfg_data(struct mwifiex_private *priv,
> > -                             struct host_cmd_ds_command *cmd,
> void *data_buf)
> > +                             struct host_cmd_ds_command *cmd,
> void
> > + *data_buf, u16 cmd_action)
> >  {
> >       struct mwifiex_adapter *adapter =3D priv->adapter;
> >       struct property *prop =3D data_buf;
> >       u32 len;
> >       u8 *data =3D (u8 *)cmd + S_DS_GEN;
> >       int ret;
> > +     struct host_cmd_ds_802_11_cfg_data *pcfg_data =3D
> > + &cmd->params.cfg_data;
> >
> >       if (prop) {
> >               len =3D prop->length;
> >               ret =3D of_property_read_u8_array(adapter->dt_node,
> prop->name,
> > -                                             data, len);
> > +                                             data +
> > + sizeof(*pcfg_data), len);
> >               if (ret)
> >                       return ret;
> >               mwifiex_dbg(adapter, INFO, @@ -1519,15 +1520,18 @@
> > static int mwifiex_cmd_cfg_data(struct mwifiex_private *priv,
> >                           prop->name);
> >       } else if (adapter->cal_data->data && adapter->cal_data->size > 0=
) {
> >               len =3D mwifiex_parse_cal_cfg((u8
> *)adapter->cal_data->data,
> > -                                         adapter->cal_data->size,
> data);
> > +                                         adapter->cal_data->size,
> > + data + sizeof(*pcfg_data));
> >               mwifiex_dbg(adapter, INFO,
> >                           "download cfg_data from config file\n");
> >       } else {
> >               return -1;
> >       }
> >
> > +     pcfg_data->action =3D cpu_to_le16(cmd_action);
> > +     pcfg_data->type =3D cpu_to_le16(2);
> > +     pcfg_data->data_len =3D cpu_to_le16(len);
> >       cmd->command =3D cpu_to_le16(HostCmd_CMD_CFG_DATA);
> > -     cmd->size =3D cpu_to_le16(S_DS_GEN + len);
> > +     cmd->size =3D cpu_to_le16(S_DS_GEN + sizeof(*pcfg_data) + len);
> >
> >       return 0;
> >  }
> > @@ -1949,7 +1953,7 @@ int mwifiex_sta_prepare_cmd(struct
> mwifiex_private *priv, uint16_t cmd_no,
> >               ret =3D mwifiex_cmd_get_hw_spec(priv, cmd_ptr);
> >               break;
> >       case HostCmd_CMD_CFG_DATA:
> > -             ret =3D mwifiex_cmd_cfg_data(priv, cmd_ptr, data_buf);
> > +             ret =3D mwifiex_cmd_cfg_data(priv, cmd_ptr, data_buf,
> > + cmd_action);
> >               break;
> >       case HostCmd_CMD_MAC_CONTROL:
> >               ret =3D mwifiex_cmd_mac_control(priv, cmd_ptr,
> cmd_action,
> > --
> > 2.34.1
> >

