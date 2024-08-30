Return-Path: <linux-wireless+bounces-12260-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C589660B9
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 13:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B231C25330
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 11:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5A719ABA8;
	Fri, 30 Aug 2024 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Il7Z/D9O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013047.outbound.protection.outlook.com [52.101.67.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF7918CC1E;
	Fri, 30 Aug 2024 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725017155; cv=fail; b=nYFzwNmrCvUVwzqdfZwsEtJxMq9rCRSErKS1TMGS26JE6ZaVd0XL1Hm2rlzJooaPvTx5W1MXIARJiObvgKD0K3bJep6i1Z2Xo7Q69i1PA2LGGcEJ4pm08OeS+vOsqRaCrxvdB2+R8+Q1tkCSwE5nd56Ty60NoY3u53zZiWGmfTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725017155; c=relaxed/simple;
	bh=y2hwuI6KF05nR2Ug02dJJeUQfMI+ixqkhc2EyBjgr4Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DAYon/u6C95u5khkikciEMN5QssK+f3Dx43XNQ13ohvjs3v4ETwSDk+ekvw9sochPSywHFEz9FDb8dtcCRjzNlYU16jtDobg3OLOpWZkAU/VykEEUaHxRzsO2MuOakpaHStOnTXgijZz4UBHuUQm8NumGE+nBX4AHNmBjj6L06c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Il7Z/D9O; arc=fail smtp.client-ip=52.101.67.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2PS16D2ag4ByIvBRdLyaBtRjdZGaojGmiSYcmIMoWQI5mN1b2AENS3V7D44UnzWuh+HyqD2Lw2iDBRRiwK1m6d9GMVQy5siVncFCnUHwodstUYMj8xjFQ9xz2nOTy1xPNZRoUqpyc01tuKrsLzVJu0mG8AQIy0zrrVg3t6KMpsqxIKDaT6XFwxmzEpBZDgk1U3PteqND36GEJ+4hnTasbgT4vJgTls05HfagG+nEsMahcKi0XPe5FTSX4TLNhEiZNzqwGK4itgWwBlqDA7XOYze3/81GPzkcL1kVfReqEiXliOk8sd7rKiADHBHb8JaDih4po4zZtQZvRR4lnwrxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2hwuI6KF05nR2Ug02dJJeUQfMI+ixqkhc2EyBjgr4Y=;
 b=gg19Yd2ZhttcOhMVGDHmmT5o2ok3jbpV1dWzFc5QSeJKsUj73DCCcB9Cj0VuBKTeyCimY/V+G7Y2uOzu9yvktwyVktbW70OqcLiThU5hJrhK8MmZ119kfz1OLYIGWGDgU+AlfzZfqAxpfUVDqQcU4RfpM785M7kCn5QHTzuvUGnG8T4c+CEZ2DmPH+718M7WUFTo9puCFKnYllah3alJrbz+qrQrveN9VMxrymOZvBHUHR4W/0dwCh23lFxtpYo1voseF9W/dV3PxmgtPQLT5FiK1h360KcKr4khhSwYn0iDrqXVgOvqTqSb2AZO0e0zpoQQi3D5r/DCyrzBQlM8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2hwuI6KF05nR2Ug02dJJeUQfMI+ixqkhc2EyBjgr4Y=;
 b=Il7Z/D9OICNPwu955y/hFS2vmLqzLedOceKk7ds83gakU4tW1EUu1fWdmoTgDU3sz0UwBSOooVrDz+/RInAUY5IJHsQ4eehkHoLfW2KCNJpO7w0j5uDcm0wpkBwwUSCNeXi3GjcM0Q3QjviYKh5mjaKgbB0ArJpF8FhEPNt8HEQ//Um9ZzkkOk2AiH55FfEsVGr2sbZ+joLcUXpVGxcBhPL7C/c6BWjXYYBli/ajsjEAv8NNCBKb84ULuZg5SpF9yG/pIBAul9ocdzFWU1+6Lyxqvb8y/eGb7xOXCtyL9PChpMAswAI+tvIrrGd0kwFGaMpM31vHQjVod+cvzAEA+A==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS4PR04MB9314.eurprd04.prod.outlook.com (2603:10a6:20b:4e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 11:25:50 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 11:25:50 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: Francesco Dolcini <francesco@dolcini.it>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "briannorris@chromium.org"
	<briannorris@chromium.org>, "kvalo@kernel.org" <kvalo@kernel.org>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH] wifi: mwifiex: avoid AP and STA running on
 different channel
Thread-Topic: [EXT] Re: [PATCH] wifi: mwifiex: avoid AP and STA running on
 different channel
Thread-Index: AQHa+omwahEWj+NlxUWyYlP8eaJEgLI/cxQAgAATBICAABtEUIAABOCAgAACasA=
Date: Fri, 30 Aug 2024 11:25:50 +0000
Message-ID:
 <PA4PR04MB96388A80C7CE49FC729D3F0DD1972@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240830030630.825818-1-yu-hao.lin@nxp.com>
 <ZtF-dgrx28yZKG2O@gaggiata.pivistrello.it> <ZtGOaTAEpLgD_z0W@pengutronix.de>
 <PA4PR04MB963862022F22E473CD559310D1972@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtGpX6dZQo3oywwT@pengutronix.de>
In-Reply-To: <ZtGpX6dZQo3oywwT@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AS4PR04MB9314:EE_
x-ms-office365-filtering-correlation-id: e4bb226b-9d3a-44f6-9447-08dcc8e68076
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?85gC4uLA4mB7cEX8TscJFZEPWjwy+mAfMjI1NzP111ToxBJ37ux7g/quyjVM?=
 =?us-ascii?Q?UPg+5BfSpmKdNlOT3kRf9aQ8XH350BlnUvS7D1VFE80xuuauetqAC0QYj3Cc?=
 =?us-ascii?Q?qKyXCGUm/ImQDXHJnJHnPvfUFaqsIXf0m6pNmU41WZBW0hSQ0m94XuEvvXRD?=
 =?us-ascii?Q?qG6E7oKmDZRPrGLbPEgK9ltZrGm6HsMlrxI3eSnWS/3TDbRttKTkfroG88VM?=
 =?us-ascii?Q?gYOzaCIjU7UR8vXH9y0BR49QL0WkRCZldTxf/a5RX/YaVFbuXapViiiXOrBi?=
 =?us-ascii?Q?OyB8eBotZYqCldZMJzHoQfIXUIW7M6IQqAGJvAJZh7L5uLhF/I/eDV2dEE4c?=
 =?us-ascii?Q?7WU3RPvX9vNzqGps3qB4/t6hWeg4UPHODFX/TQbe/GtYKESXwm/mZgfLTPL1?=
 =?us-ascii?Q?XYst+pR187iUVYMTSJORQq9IGHL01PYgONzsUUqCwTekx6I4Glewvot7A2Mg?=
 =?us-ascii?Q?x9nDxAVsPl2MDIXf3SpGQ0+2aKlBOmrqx0ldOqgDmddE68qveS0zh7P7/sG0?=
 =?us-ascii?Q?4sSUXYJwoChz4rmjcmo2wUgAdP1MMP+uGeWfoeb//YJx/Aw9ok1ApoC+kSoW?=
 =?us-ascii?Q?llciHn0+WOBJN/vTI5XCGNqEsTdBErZvWgSRWiHzlCM5+ei+7YV0pOyMERhT?=
 =?us-ascii?Q?zpUeDaIsZwwJVaX0f9rS240OrJPFBep28aTP1H4mkhxXpHKDgsb45+g3W3sg?=
 =?us-ascii?Q?RIJS34BW5+XkHWLh/tODkejm8dNDm0rdD9lN5f44rBXEL5ZFaYgNphy8EFmI?=
 =?us-ascii?Q?QQ/GmGzBQ1yiCACaKDNT1NBZWS96UhPBMCFnEk5Ws2tJPty4qx2KPRgYDrCQ?=
 =?us-ascii?Q?dOYle47FzFwVNcxmaUs2E46fkzKqGwGHQca+MTOXtZ4Q2JOVvTar4E+t7wFB?=
 =?us-ascii?Q?NxUJ7O4FHuctcLOOAABH+B4CD11123j0n4hXmYWJOM3eLR4ObNDT6MK7VKpT?=
 =?us-ascii?Q?H/4DPdMh3Mu6LO1Di/qMeBdTnK7GU+JJbuI8ozRoSD/ka3GoG7FoDf/C2Hg3?=
 =?us-ascii?Q?pj0saAqiAhHDY8epvub2oXAlQA5+lkSf+jkHI/xYPxJfyQeBpHrBKOo7C0Q6?=
 =?us-ascii?Q?fgRqg+TdTNKv9+6ppolxTFCevElszUqZZT3K7ovwG+eQCU8MjTqoBqZW4Dx7?=
 =?us-ascii?Q?XHFaqThyzsriwzOq4wQzLlkmyiRrkMiLR6X8ihGtj4iuKhg0ASCOlCoJFuJx?=
 =?us-ascii?Q?exToAMe92eI+8wj05s2qKdI2R7bGgQpKds9VUWqftvXQTD0Wk3VHhimik1BZ?=
 =?us-ascii?Q?yFU4bUbqlKwYXgoUut4ta67Vr0JZjqNxwwLWk7x/HPUEXWnR2yeuFfTVZlyj?=
 =?us-ascii?Q?NTgGDmPVXvW/gv2QzyuCcu7dM+zTMkaZYPpVYjvlXUo/ch0l81bb1fQPP4h4?=
 =?us-ascii?Q?dwOt5ESDd+dzzpJq9GaWzB4QAwYAMYRY/SvH9jtKH2UBE82sMg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?O/OpFlo5bcOipS8OMEHKeY42r98MJhOPUwQkL0DTdRvizdnYbtdJBdFsX3RW?=
 =?us-ascii?Q?2eDnfpV3UST9hfrvABpQMmC4+S8P8XB0+b3rYKSkYznPV/Il8uIpUMP8J53X?=
 =?us-ascii?Q?7XTfxb3mm1gq6eYv3CAswqjpwnDbKy8nlUH7gkaoJpjSrYSAzDmzoOp5SeB4?=
 =?us-ascii?Q?vP1tqQsHmXofdBXjqmjqPBEzSs2R+K2dBbkgBEmwRjQHftlFRBVIYWWzqWb6?=
 =?us-ascii?Q?i1IHguJUeOSJTnAkBTI1BanNnJlMKincObcqBrsBOg0rF2yFC1sg0lB2daqD?=
 =?us-ascii?Q?+r+rhxAO7bbh5q18mrFATVyC0NFEMXZcFvujdP0hL2/ZFlAqBHAYs494HZRJ?=
 =?us-ascii?Q?kaeHd6NF29fgnxhbhFmYV138ExAfTLjfUSGrRaTh5WZ7rjZZdGxoSLZsR20A?=
 =?us-ascii?Q?DlJQSgz3V5mDRpe2JkpFMM8ijYYppbDx1Xa06cjEfMDfe3JO1D9a0ZaxUwIr?=
 =?us-ascii?Q?53Ef+wLNVrdGdqYFludqgnDtVMMPREfa6iGLQQ0IGOrxGeeMG7K30fgVob1R?=
 =?us-ascii?Q?AkPS25a6x+azDRb7+Uc9sJL0Q8DUZSjvLFy7WvbintIcAqUCD4UmMatU8QTF?=
 =?us-ascii?Q?IXRM7mJJVubDEN6Gy/Bp3dU5ctQmDvh0nWmfM98dv/YzT2S2t3abPExsB5AK?=
 =?us-ascii?Q?BWIsN3ScfGSkrlR7xYlsO35mWj0S0NSt6DxO5K3+PK/rEPfTyHdkFhqtYLgj?=
 =?us-ascii?Q?A1ng/ftq0B4Ma5utMKv/31z3mBy7IBrZ3fF4R/SXbkGp2F16MLPrhGU94RpB?=
 =?us-ascii?Q?AE4xbg9lbro6Ck4h/bDvmNDGAFcFwFmChma8XdyY1B8slrjRr2IJm+49b7We?=
 =?us-ascii?Q?nN6kby2atN74w9DRt3Ql5qTMjuviZ6SZ99q53YnBy9L69Mf87aGDYBd3/1Pc?=
 =?us-ascii?Q?IqgWL6vDAzvs8JSLRgIbGfu8RjtL+LojHoELQ+ij5PkEPK7ie/6VqHdhJaqe?=
 =?us-ascii?Q?h+Lci3azTWbloTngpbPAVo2A6JgDWtnlU9IrPuUA+i5tvlimquJiOEN1Dkmq?=
 =?us-ascii?Q?lqcBUDbLhPr+oEJxobZSvBCyJ2JEcOrW4V4IZkPrQd+WsiI0ax5UM0zQfeLr?=
 =?us-ascii?Q?Vg4UwCY1RoVOm9gYC81UTyTDokbxLRLbsZMw7hjcNmBXAFhchgE6b50jnba9?=
 =?us-ascii?Q?SQcCHIsczd5iInEpiEVXjfSawh8ByE0QEsHcO/yoKM5ZhL3NdPqkQvIX0s0H?=
 =?us-ascii?Q?sL5kY2iOeDBhzszhJCyZLKxS1/YUACWraeGoxyAFY+dvxK7SI4MhA52gAjjO?=
 =?us-ascii?Q?365RMUFORSlfhywHar0edQrbxdDeAOP/3TZ4fDsz1wipKE88TKuYzd1/7gjZ?=
 =?us-ascii?Q?WuixxOIHYDYqATFiVmoryIMvaM4mPwabtDGnXRjqWft5Dcee+NyW0WAGQz0n?=
 =?us-ascii?Q?bsRHqb1XZEg5NFBtEvBnm/1K7dUxm3w53EbOxFQSHyjZgTNYJQtWQp+2cHpG?=
 =?us-ascii?Q?rJIxzrsKpZRQ9GzyEDo/pa9C6BfqsucIR8JXnAmQIE2HlhSEfBmTsf5pqkxj?=
 =?us-ascii?Q?ojwAtyg/vIejLzxFlPqwqU8EmvQjqUxXbkZI+YJ0Y8yfXc1Vhu3+EUwPI4Su?=
 =?us-ascii?Q?0WnIN/RVzgXmovwWP7Sss0Ce7H8j5waWo3lXsBNM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e4bb226b-9d3a-44f6-9447-08dcc8e68076
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 11:25:50.2607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d3f4vZdu7atJ+XL7tQ4w0ylENJhoTUmqCjCeO+6DCQSZL+QKB+glOjUf+PooVj9xR1QbtZJClT70yRzAWc4qYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9314

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Friday, August 30, 2024 7:14 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: Francesco Dolcini <francesco@dolcini.it>; linux-wireless@vger.kernel.=
org;
> linux-kernel@vger.kernel.org; briannorris@chromium.org; kvalo@kernel.org;
> Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: Re: [EXT] Re: [PATCH] wifi: mwifiex: avoid AP and STA running on
> different channel
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Fri, Aug 30, 2024 at 10:58:50AM +0000, David Lin wrote:
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > Sent: Friday, August 30, 2024 5:19 PM
> > > To: Francesco Dolcini <francesco@dolcini.it>
> > > Cc: David Lin <yu-hao.lin@nxp.com>; linux-wireless@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; briannorris@chromium.org;
> > > kvalo@kernel.org; Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> > > Subject: [EXT] Re: [PATCH] wifi: mwifiex: avoid AP and STA running
> > > on different channel
> > >
> > > On Fri, Aug 30, 2024 at 10:10:30AM +0200, Francesco Dolcini wrote:
> > > > +Sascha, that just sent a patch to handle the same issue.
> > > >
> > > > On Fri, Aug 30, 2024 at 11:06:30AM +0800, David Lin wrote:
> > > > > Current firmware doesn't support AP and STA running on different
> > > > > channels simultaneously.
> > > > > FW crash would occur in such case.
> > > > > This patch avoids the issue by disabling AP and STA to run on
> > > > > different channels.
> > > >
> > > > Is this a generic issue of specific of some firmware version?
> > > > Asking since the driver as you know is supporting multiple Wi-Fi de=
vice.
> > >
> > > The driver does, unfortunately the hardware does not.
> > >
> > > I learned this the hard way. When an accesspoint is running on uap0
> > > and you want to connect to an accesspoint on mlan0 then it won't
> > > work when that accesspoint is on a different channel.
> > >
> > > Likewise, when you are creating an accesspoint on uap0 using channel
> > > A and another one on channel B then you'll notice that both
> > > accesspoints will end up using channel A.
> > >
> > > It took me a while to find that out. In the end I found the same
> > > channel check in the nxpwifi driver.
> > >
> > > Sascha
> > >
> >
> > Yes, this patch is backported from nxpwifi (same as another patch for A=
P
> DFS mode).
> > Because Mwifiex supports connect/disconnect and separate auth/assoc, I
> > think I will clean up the code and create patch v2 later.
>=20
> Gna, I didn't notice that I haven't answered to my own patch, but to your
> patch addressing the same problem a few hours later ;)
>=20
> Sascha
>=20

After Francesco mentioned, then I know you have the patch to fix the same i=
ssue a few hours later after this patch.
I think we will commit to backport needed patches from nxpwifi. BTW, are yo=
u sure your patch can work to run AP and STA on
the same channel if some wiphy parameters are setting?

David

