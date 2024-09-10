Return-Path: <linux-wireless+bounces-12717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D509726BF
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 03:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35871C219AA
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 01:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9351139D15;
	Tue, 10 Sep 2024 01:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GIWRKHPo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3C942AA4;
	Tue, 10 Sep 2024 01:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725933320; cv=fail; b=kZcpLITgOnhj667boOjbL1KoIBJpyUitvrWxk2gfxYbiVljbc/I/AH0wHbo98BCucjOAf3AiEMFyrF+433t74HhclJ6vkoVvN9RqsJvKiVAdTfMT7qWL6Q4S0gRPATPaH3pl9fG+E+nsAwltkU/2rSI8g5iinKc6dWaIWVQLWUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725933320; c=relaxed/simple;
	bh=4TtTLmNsUCy0ZKnF1ufUb/XF0NzLo2o6D0Qkz1KQKjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tz+jO4fYe1OJC3jfcW3VpO3lno1H947oh5jQh+qycmsm5FyGPmCj3njd9Y0hm9ZvkMWf3VlZqtLTiCEkhtURuEx2Q25GR/s260mgxNjt2mj1MTWxEMoRUP+LQu12FQ8/4mauRIp0Qp8WL17QzmTExJF0vPm9H8qPvLH8QMlRxvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GIWRKHPo; arc=fail smtp.client-ip=40.107.22.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7fkxXOT5/DBalzCsxr0w3qhkx4/lfatmEBkzvaQ2ANhUtiIaoUeAgOEToHi8spR6XwvsnyhHZ5cY9MoVRkM2/Enro9ESPCWS7BRf8yAIBYth3EBPEsaytCw+YPR2jkdeWzEiDjGS4mzTfqaNVtawknS0PPoRkrfAJwebMjDJMcE9+rso52qMboe3K4HgswP0TFB6S+W3L4vwAIf/G0f744eWh45Wxo9Urat4HrIPiaZKyQM8aPk2rHc1o64vyd63FFXBgOXzUD1zDS2AdBQnX0hvhSNpVpuNA+xF5xOFj6+plWXMb6UN5G4Xoua6DwTM3X8Of2fnKwzgS8g0kPfCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TtTLmNsUCy0ZKnF1ufUb/XF0NzLo2o6D0Qkz1KQKjA=;
 b=A6c3A1hgctFfvzCNvVgMz4X4/feyRA78r0yRmnPevWAAITUjwYhgBSTgow9h2yckCdFoWd8LE/VFXhbhEouyu66w4Z+W8VHLRqSntG6rPhcltHbJRP2645cfejt+tLvWyBv4LtiV6gjPIJJ3RwXYldya7Ft6rGAs1mAbESuOfLDy/EGGwTeUPVF8njqMTIuaxTKBLtq00XTApKyrpQvtzpEhXq2e2xPLbGmTLp9WU1wlfGaO3mQyaNAQXXZXVPQ1fZkNSf3irBMLWG1ChsUX5XByojuANrGoDlCKFxRec42Tc9jEH1wGtnSMEI2/yJvHfYp00oCoGQs7OnqBTIldgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TtTLmNsUCy0ZKnF1ufUb/XF0NzLo2o6D0Qkz1KQKjA=;
 b=GIWRKHPoDQAMi+RPjAEfZpI96UfYYZVxtf/Kg6RzqBOj/iow+M2iYpMmTBEezW4658xfU8zMrrWT9vpFC873wOcrhUAvQiInyJCKzcWFIQ6cxoj2meZ0+kzoZMZyboQLpcTxfgQnXR+L+wLNkbGqU3pw21sC1NE6AokHvcoXL2JS3y2XFMvs7X0EF8R8wG6QorNN0nRow1D1sc50Ig84lBOuZU1txvIVEe82t0oKozPPW20ym5yaWOGthtICbDhZR8ciYCDum55q3NQw+QyuSAZXnkYGQcggFqvl/7NiscG9TVHVwX0gdEmNKfhDhfsAJ1NKPsJaiU2dIG6dh4w/ig==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI0PR04MB10464.eurprd04.prod.outlook.com (2603:10a6:800:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 01:55:14 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 01:55:14 +0000
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
Thread-Index: AQHa/RQwZkxE7S8BN0ebi7x6fu8g/rJEPYCAgAAPeUCAC6fogIAAWbHQ
Date: Tue, 10 Sep 2024 01:55:14 +0000
Message-ID:
 <PA4PR04MB963813D69B4D87B7147704A5D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240902084311.2607-1-yu-hao.lin@nxp.com>
 <ZtWHhSQlPVMekW1I@pengutronix.de>
 <PA4PR04MB9638EC10C0B656B750D922ADD1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt9blTxk88Opujsk@pengutronix.de>
In-Reply-To: <Zt9blTxk88Opujsk@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|VI0PR04MB10464:EE_
x-ms-office365-filtering-correlation-id: 561222a1-4820-4518-efc7-08dcd13b9ca8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XN76nRxUaOuDhMY/9Q/Bzm83Mf2s+mjC6NWKamMjfYxeHKCTvd/riWdOCXSd?=
 =?us-ascii?Q?ABmXzzAbP46fintkil0cZLXt2qailySvR32UWy7cp+fhOkSil2FNZXeJEBi/?=
 =?us-ascii?Q?wL5kFFWB7QWszOl79fs739J5DlLzGqyL/yui38oRFWrcl7y80itxNPsnpINA?=
 =?us-ascii?Q?ZYCLwLtvTG0xibsnCo3onkYc2YXPsixpKO+Fne8SA77iMvHjFKCmF2DDO0lD?=
 =?us-ascii?Q?lqx6Wz5WfshrGEUzReYADxzYyy98CThsGcDSdseGrHebJABCNS+6uLtIDg+N?=
 =?us-ascii?Q?+HchoMB84adSgTyDbvVPekSf07GgBnObDBzmfnvAgUjSXWTJMP5jxQfnSGcN?=
 =?us-ascii?Q?AQ8FpzKWbCoyMaDKdMnedYWRKuBpI7/TluxOnVsme3LQIHr29RkUzNvMLzNz?=
 =?us-ascii?Q?Nsqdmu5OeMUIV3KKXakeknbjmygWKjZwKcIFk10Kdg+ZIzLqA4oCEQR4XO1D?=
 =?us-ascii?Q?MHsKxBF2JzmK1Cjb9GhHvaOTWvjcirdLVuVcyNwkcPCfZ4eNDnTZMfb+no+f?=
 =?us-ascii?Q?FpjG7K4o+1WoyZqu4uIoALax4gznvl3MRjm5djjy1rxY6OKsmb9t5UnGoWBl?=
 =?us-ascii?Q?CTXlG2FEUBNWGcaNqp57KmyWfyVp1HALDx7/b3GIL37R+Bo/moYn+fCzNcam?=
 =?us-ascii?Q?4if028HpvrvBqYNVDlxpi1cN1Ci/eD6NIh/wvH350T0YnaFKeVIh6WtlHFrs?=
 =?us-ascii?Q?yHOjDNm+1OHdvBRMGW5gCIAzMFpQMXelDqErglbD/LLGrfQeHKUgU/eRTUdE?=
 =?us-ascii?Q?/UQFXzWo4eayMZfIIRsXngiJ1tbg/BnlirSiTs1/8Lizp/qHeHWMPTmRgK8N?=
 =?us-ascii?Q?97/S3n67PEVKrJZ/5xvjKvA3PpxNZjHpHibj+yVFW71ksEomFRS8MXB9YKbb?=
 =?us-ascii?Q?V+6FcxHx3JmTTu0QlxEEpqUMCrPPHxr+MLzp+euRRTB07NSgFJ6kC0oevqen?=
 =?us-ascii?Q?oOkyEC8s2/pY0g3B8vL8is/2xs0zTdaQdc3Qj4rhw3mmY3+mHy0uxnQtm7WI?=
 =?us-ascii?Q?0hUu83j5StAT0MwgjJtS2im92LM5qA2NNwOGp6Nky1Vmjgpx5bYZBKWBonmK?=
 =?us-ascii?Q?T86uV/7A+RgoM8hvAGWg1SAagdoCPT2jFNf9AixDFlIUv9672+3gPXSs1Sab?=
 =?us-ascii?Q?badSoYuKGxM+37Vbtd/mfzi4WOQ0X1ezC5bqJBH48pIz4Iw4ubrMYVYyJYvD?=
 =?us-ascii?Q?NtfDtXNe8C3iP9SbPyxzV6PlM8+2jV7WoiQzYTwsOfR3ar52N1tEF9ysEQiS?=
 =?us-ascii?Q?SDto2mgWyU2BU6NO8QUVHThrSdrGPxYX4IaLbF4xFr+nWQ8F8kGwLoY9IRzG?=
 =?us-ascii?Q?0+HkZkJQjbaR72yAluK1t5/UOMh6DnNGXAo0g4lrweC1j2n3iyuBa9XjQgQE?=
 =?us-ascii?Q?FdKYrq4tcxFZKEqoGVSqaGtgaTg4fwn845zKVBGiirT+Eogcqg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Mk5tsv+Q9+DBz3E1pf3Y82t8iWWJTFTQdsP+O3fRePDK+z5KAKjyazMZX4jO?=
 =?us-ascii?Q?tDrpuwU8C8WmP2eJmxgn969gO37RgF/uV7BtuIW8DRQXKXNnPwAD9SUCd4Hi?=
 =?us-ascii?Q?6wyVt1/M1p34eUwzrTpSx5fhV+NYMjoAuz9IthCcgR1trusF4Rb4euD/ruhA?=
 =?us-ascii?Q?JcZYOAaTk2L3Py3m64oKoOXu4pxKHCsmMjpFO5YkQJne9GnseKzOO7mvTHwV?=
 =?us-ascii?Q?w24ip1tvpy2nGzRxfPIbXRL8K94x6Z4DAJTjUTIjuCTaxM8JT4DapKKJade0?=
 =?us-ascii?Q?Esqtt8khRp83oRe3BvV+r5tiVYrPiH+IXBBpJkR+KzSLxBmmG+h9r8EBXSHo?=
 =?us-ascii?Q?UOlCXrZaPR92vV9nAlcReVwgLAsTe7oaJJjWxYMDE0SzO8TcodV59Vp9UyTQ?=
 =?us-ascii?Q?D0tZ1kXJcQWCDqDcXczf8kKGn54HJXaepv1mzfiLSagewvKrogGkPvsPg6xr?=
 =?us-ascii?Q?OCCbk4Rnng4z6y+DrO73ArXow1MDZ9DnEpS984qDgKyUXwmE/yLG+gKzA9LE?=
 =?us-ascii?Q?/wCvA2Od0p+fweJ5KmOWqBofOZhx/zoFhG1kjGH+/twdK31wWwIouBfeVab4?=
 =?us-ascii?Q?2h5C3wmeOdHdCGoVNwk8NIOueR5kK7WqYJh/gd9otC3Oz33qckBKcxvmQruT?=
 =?us-ascii?Q?XxvVaCZECvBziTyQUBJZdHzSVLv9aSoUSCSnINiMDmz5/lo2tjvFFPXMPXR4?=
 =?us-ascii?Q?/j4jFcyheg8ecaZZvyPVI6nZ0mFXC0s1h3/CX6Guz1FJzlXWTGXOurHPdZ/e?=
 =?us-ascii?Q?zp0WlA7FraaRIWctp/qznc/gjko7D1B1JeVh5hFj9NsMvwA3YaB72cZ9uxXZ?=
 =?us-ascii?Q?xHdw8xicpeJ7+gHwFW3ErrVVAQvnpAlH2l1iM+gD5FpTYQuHaOkSfH9fSt5W?=
 =?us-ascii?Q?b6WSzwZXWsA6Edq9x2ygFem9gJOdx7epUhDeESrRUKWbLC/ltFxskwKXnuBr?=
 =?us-ascii?Q?/yFcpra4ImyWOrnRztJv7CrSRC7PvhcVpu9ratLxLJclkdRQOayZgkYgQKKd?=
 =?us-ascii?Q?XLxMyTMH1bMF4Sg7AsBRotKUYSV4fJFz/W2Rx2w3dugEBN3CIVa8Cu4zVKXd?=
 =?us-ascii?Q?TqjaG+AgA3KpQzyxz9ZOaqbijsEGmnNUzI6lM5HzpQIux5/xokNkqMq59Y4Z?=
 =?us-ascii?Q?QtiqULZ8+jBNhD48LUIxoCahj2320PSmX9MTtcwsgngbQGbTyeGPXnUznpsG?=
 =?us-ascii?Q?0qV/9qGE5FWpUKirNQQzUqC8CLfmkdT2ae/E6Qk+hibsuALOUUbjTtkJp02p?=
 =?us-ascii?Q?L7ADp7IfoPX2nsEV8mpOIKkC7JpKnlYWLOwYlEaUMwtX9JjgXCVIX6s3gyT7?=
 =?us-ascii?Q?WTDSNWk/iKlLl6FcUt5oY2jMkiXtb6HksveXxxMu9cz6hCZTrDdZi/4qJIVH?=
 =?us-ascii?Q?lNVQ0mrWy2Y2oWs3ZdaPZNSlzR/ZSiGYQd1CegbtgFH5FfEuXHKoDOa4YRQv?=
 =?us-ascii?Q?TI1g/kFTrh2Lqsu3xicG5HgrfKZj3dXcVNmRJpc2x0/0H5mBhk7gUfPFuXPZ?=
 =?us-ascii?Q?pb1V/bTvpDxg/BE0HzKDWXApOAXL3CSmbOwyNtO452BFEkquU3xRn+8WyH57?=
 =?us-ascii?Q?TrSyhLYSN7lfJYpmZQNmBZ54NqrVYOjHHDfMTaAd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 561222a1-4820-4518-efc7-08dcd13b9ca8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 01:55:14.0798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LKMApH2vXwoJs14pxxuC8kTcd5j3NeWaefEYRcNouMdyErWKnUIyYka2te7Tz9fGsgL/kh1FxTGW9FIKJ67AOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10464

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Tuesday, September 10, 2024 4:33 AM
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
> On Mon, Sep 02, 2024 at 10:35:01AM +0000, David Lin wrote:
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > Sent: Monday, September 2, 2024 5:38 PM
> > > To: David Lin <yu-hao.lin@nxp.com>
> > > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it;
> > > Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> > > Subject: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA
> > > running on different channel
> > >
> > > On Mon, Sep 02, 2024 at 04:43:11PM +0800, David Lin wrote:
> > > > Current firmware doesn't support AP and STA running on different
> > > > channels simultaneously.
> > >
> > > As mentioned here:
> > >
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
o
> > >
> re.kern%2F&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7C7712df39ac37414fd
> a7
> > >
> e08dcd10eac35%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6386
> 15108
> > >
> 157502805%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> 2luMz
> > >
> IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DURNJPJE17iRY
> Tu4i
> > > rx7eQAC97tE5OE6a4kUfjUwuaVU%3D&reserved=3D0
> > >
> el.org%2Fall%2FZtGnWC7SPHt7Vbbp%40pengutronix.de%2F&data=3D05%7C02%
> > >
> 7Cyu-hao.lin%40nxp.com%7Cce9b7d4e417c41113c7d08dccb32fc49%7C686ea
> > >
> 1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638608667089710854%7CUnkn
> > >
> own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h
> > >
> aWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DnMZO565xCUO%2BwxD4tIfi
> > > w6cGyYrinaEsi7XLfqyxgXg%3D&reserved=3D0
> > >
> > > AP and STA can indeed have different channels when DRCS is enabled,
> > > so I think you have to check this in your patch.
> > >
> > > Maybe the same question here again: Wouldn't it make sense to enable
> > > DRCS by default?
> > >
> > > Sascha
> > >
> >
> > I will look into DRCS support later after current tasks on hand.
> > This patch is a quick fix to avoid firmware crash in the specific scena=
rio.
>=20
> With DRCS support enabled AP and STA actually can run on different channe=
ls
> with the current code. You are breaking this scenario with this patch.
>=20
> Sascha
>=20

DRCS will be checked in the future.

David

