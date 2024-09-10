Return-Path: <linux-wireless+bounces-12738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E441C972C3B
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 10:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A791A28373B
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 08:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C854185B4F;
	Tue, 10 Sep 2024 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hwbckTnF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75B9183CB0;
	Tue, 10 Sep 2024 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957327; cv=fail; b=bc+/KECRPEOuQnyGeuhGzzq8wYWuLJ3fooxe1LSDkK5Q9SODmnYxF9m2Y9da09X+u04jsUwaYks5pp9EmQWrZgUWkw2ESJKZcjqP8Z8tneOoEmcx9abFSG203jS9HrYiy4JKxwdjv2sPilzJ4YGEGVVGsmqrYfv9F7+Pd0WSR2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957327; c=relaxed/simple;
	bh=ziJpgGyADQjUzWCUetQO4447zV+vPf2C0D8Zg+jvqmU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ci7Go1GbeB8wemrZU5Y8oq5kdRtI3XP/mlRu4LUixuTOJ665flKVY0zqDjHO7fQF16C/OuiS+OlSmTLkAvjn5bP47J9FMuyC/CBoaK0PKDpR4rRqy6IsGLLvDtQhcyoQz9u3iEIx0VSherBF9Hcl6oWuJGbPXV5WYa8d5JSwxuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hwbckTnF; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LD2W5OqyCpx3otuO3QDzaqJYes509id0a1kOLbHVR9kfwx1KRzlpHtthuT8zivcdUpEGcOXi1fj98kBMEr0o9a9l8NyKBDN+qC8qBapOW0pNtHk01K6IT0lFHBgcCxYjmrAOV4vm6mBA6VKtaOcLoKWae4MC0lOA41VsqBmeiXtJCJ3Vb7v/AWM/ruVdy8wWTPLUewVMrlLERWICbszLZE7NEe977gXkrspB5NKlHF0bjl67kphpKPN2DcV0PA97kNql5nL1hheSRtXYvTKqN39WegHp+Oe3UCPpOomDxhqz8Jht07LB0tslU0gaUjcpxNmPr2YoAUnFMGWlbsWOfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3s1czm+TbUNOCiLK/BwhgD9F9pCjzj+QFmY9LhaTRk=;
 b=ddxLrVX2d8Emu5Q4mKDbPKLoUdhq7Wf/IzvIjoowH1r0abdrQgb0pHAVTwQhbWLZBKCd3i2oCZdTyE+LnZokBlTB8Wb5jWxGdK7dmL/+ULUWTSPIOTrNNxYQ9BpT3SRKpUrEZ8MYpkp2MhjR85Vn2P62XkdkdgCa3F5IDx0zQzM4nWnrJ1mK0FTEyjmjg6/Tgb+/p8Do37AvuPJfhgdLdbQamzLI7n5MDYMs1DPwp1KaBIJRoWTsWD8lLMSjjoM7v1h9JCgnG11SAs/FVQzvQolHTBWmbCCNqzP3rpIJRdfkIY6RPkDOISzGjWleuisCEJ4sg4MvIu/zO6oC4dms1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3s1czm+TbUNOCiLK/BwhgD9F9pCjzj+QFmY9LhaTRk=;
 b=hwbckTnF9j6B5QU7/8Wc9miqbzUF6UZncc47TPYL0GnONIi5pfQMpjcrQqhFHCWTUkZ+xVmdm2DR1hPlm6ji8F2IIRBrk/TXsdMFjsNtl91G5TySMooIC5sVpbcwrx0nfStRWra2qqkXqwoRJHLve4Rf/naQ1GtrZXWab+cd4TxPlkLyo8zCQ2hbP5slRzG26kud5nrTVmRHglzzfS0XlTz1jyX+e7yTaA/mAVighX2ee68CAoLQjYusjBkC/RlfXbxQECPGEgy+TIKnFnFByHVjN/+AmxEFF3D60gmuBun9+1S2S+RXgjzRj5U4XriydIDJfy1pX95qq2xAxxmSsQ==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GVXPR04MB10899.eurprd04.prod.outlook.com (2603:10a6:150:225::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 08:35:22 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 08:35:22 +0000
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
Thread-Index:
 AQHa/RQwZkxE7S8BN0ebi7x6fu8g/rJP/dMAgABP2xCAAGcLgIAABVmggAADdICAAADY8A==
Date: Tue, 10 Sep 2024 08:35:22 +0000
Message-ID:
 <PA4PR04MB96382A98C3CCA608663FB655D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240902084311.2607-1-yu-hao.lin@nxp.com>
 <Zt9jFpyptX_ftH-p@pengutronix.de>
 <PA4PR04MB9638EA984DB5F2FDAEA3B873D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt_8gwj6GnV_yZ1Z@pengutronix.de>
 <PA4PR04MB963850587C41FF78F4244E3AD19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZuAD5fKyKgHPFN8s@pengutronix.de>
In-Reply-To: <ZuAD5fKyKgHPFN8s@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|GVXPR04MB10899:EE_
x-ms-office365-filtering-correlation-id: 2fc22a34-7c3c-4819-9483-08dcd1738293
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Alq2MnVMusptE6FgzYi6dNRAIz1MvIa2yJxqX9vb7Hxrp0r0ZGi5q12uNI8B?=
 =?us-ascii?Q?Fx6MgyrLQeoKvRbOtRY+o0fuPXNxeAabgAV1yRlSgX0XzvQbg4luQp+1+8Ru?=
 =?us-ascii?Q?A8X3ZYfa1gZ7PBBJEtQmTVK0AB+dfvNg94VqqBGWREW/Wl1BXWEvzgd7RrDC?=
 =?us-ascii?Q?6FRJtFEshGO2Y5n7Hh2rxQWi5t7+e/Pe6fU/HwS09JxFX/h79a3iZpE79QZR?=
 =?us-ascii?Q?owuBvaKKqcqNyD82s1Oldhzx2r2JX+ij/+sly9qdKi4zNxbwrgXxfEC5U3Pb?=
 =?us-ascii?Q?ff7yhYk2OA79ZOA1HgrO5rEnpuhpMei7PO1gK7YGwR58Gs8VBc2BZp+m7lls?=
 =?us-ascii?Q?pkyXTEitaVhbscGNIWiB7Rka87/7MSLeS4ztm4l3zZKLhwDtrFYaUBJkbE4l?=
 =?us-ascii?Q?8wjfmOGvkPqUN2uJgJURK9S5mD+G7UFIfGx4T7ho5fEAg9DmhnzDMp7nGqUx?=
 =?us-ascii?Q?ErOTeXFlUDgWhgKJx4CU4QRcB4i59166UfszMF3ff6c57guRR9m377jmBmGa?=
 =?us-ascii?Q?p3CKQyPQBMSRwuh79WwRYvb+mwivWGqGqE+aPT68cMdbb8H+bh9EvPuHWJiM?=
 =?us-ascii?Q?WtZMfIZ+Mce2LCfS8YTcq8PiHwfTrvl0sjsa2giMz/1ZrtYI4Cj2MyfwaBkV?=
 =?us-ascii?Q?75W3yc2RXvvzGwO99CGgNV7drC8ZfOM5ynOZ74rcvD5Kh4vN/kR6cN6yFIRe?=
 =?us-ascii?Q?b5Ae0cwJllI+b21Lixd6/8H3t1rn07wnX1o3mh+aAz2W65Nc3eU0kVpFuwaB?=
 =?us-ascii?Q?4q9wNzu0mjbI1MjFch5SkUG14JzF3p87NCLRPWPTeP7IYwkBN6hFvQpDMP3o?=
 =?us-ascii?Q?pnWvvj1iI5AH2CKxxQct8wDdKuuxgYKtVUwecBPE+PKmoV8GivQ+92G9zdah?=
 =?us-ascii?Q?VybvKsv4qZ/Zubmen7FR//yM+RA16bUDB51aVh8DtPs/AkPTpxXpcQvswpgQ?=
 =?us-ascii?Q?JifNBRHux7HIWOJ4/2TlmunioQW/n4Nq7aHk+7cw0B7kSdPnjwgYpxtVZ6bm?=
 =?us-ascii?Q?ZaPpR4T3daej4jYE0Bnu+aYW5ET0DBGeecTsj0hhLUOmYR7LP/VbrdVY38J1?=
 =?us-ascii?Q?JvLtFYvqrhuiZ+ocjNqNN4nAIb42HP4nDCHPlCNVCLPQsSxSa/EnXyq0i5l2?=
 =?us-ascii?Q?2rM49SSp7F77DLoNo6QbfAHyAhV6KicdDdZf2zYOabSVZ9W7leYrla6+dIvy?=
 =?us-ascii?Q?8QgmOj4dj5YeX5F1+6njpxpqgRTcvRLYgivYgcmMLiih2gVp3Mv/RA0ArsxE?=
 =?us-ascii?Q?K8fOrk9vB/hEGO6L5FlQRHnfSfxsHDoIPh7tO7nF2LcQpG93+BsczXi1NEQo?=
 =?us-ascii?Q?gsqdQwbGqXrDK6fHa6Hli84otAbh9aPiFf4c0u746TnCRZiO+QJQ/lUr0PBy?=
 =?us-ascii?Q?F/1CChOwC/WISxVt/US+fH2FZwZJSqcI7bpH/fh9WxRYE9dQOA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8zNEYVpM9JmrIbJ6JRtMXaEsm+7gKhYM0k9pBTP/Xo9+8pDvE5nqE6pxCsCO?=
 =?us-ascii?Q?bpdWlbBBRPTTUidm7lHjQLtnDxup1/zczTHpHiqsXbEVyVZ6NmmOIptbwPcU?=
 =?us-ascii?Q?c6Gcne0DGkEl3shppsXwfmMvvMicTI5/D9gOpK6tlYAiYHZGYeAnn8lmV+JN?=
 =?us-ascii?Q?fYwHmhXIUebXYXeiCC352q/Yg3eWFqcjmOv4HJvmUpsQ46cTq+UUdtO7Y3bT?=
 =?us-ascii?Q?qSFAaOlKFkNy3mA/kaZzGVKI2WI1NGiXbxCIr0mpR36NTShVSWE7LQWceXFZ?=
 =?us-ascii?Q?4oP9YE0VAykRjEOMjmmFZt/GHudjse3Hi8a//IQRrac5gKjPkdjZqY6pLFaZ?=
 =?us-ascii?Q?VX6a6AyQXtx6LqgT8Z+TKXfKxtMSeXR1NXeMDxfvunUOZx43ChlLp8SsIJKP?=
 =?us-ascii?Q?GZIsHT4t2eUnS348Y9k7VdhAq+hqv69CX8TbxmhpGhALBdhXFxV1fEH+TEBP?=
 =?us-ascii?Q?fr5rlu5pfU162gZpkWehn1qzohAw8xYhA31KnRj0TyPG5JLwmouQitfwUBh6?=
 =?us-ascii?Q?7TVWJHF9LcRjtmFoXWrGIc6J1A1gtJTIBk/mnrL65G5hLJcdzwnFYBTRU5Us?=
 =?us-ascii?Q?IoE2Gh8O08jHLBRZAjzBMR1DqwxU3eyWFzbxxPb5UpncJBYFyS9M2rqvjbZu?=
 =?us-ascii?Q?R+LDIY+KwIAjZc8mlrhmxZkIkQ4CftoKSkoUyexh6QHVxQx4ERqmUnh2IkYw?=
 =?us-ascii?Q?GQ2hr7ZtiyZmSA2PBv01qOmosslPJwUIug3YFdqoE2L2PmEY8sFrXQA/+H1f?=
 =?us-ascii?Q?8pwQl+fxXmEdi2zYesR6Oz/3vmGBQnnbr7j86byLfv8M+EeImyk4yXgJ0V5R?=
 =?us-ascii?Q?lmkVai00Hy9eROzEFL6o7u6CxP+e7dQYnAdDB33Mm5KBML0wcWvJxfTPDMGr?=
 =?us-ascii?Q?0BtR8LFlYZHT/cNOgqjSE+CaHJjbLT+iTd432Qo2F9g5EKAPqmCnHKaGLdcN?=
 =?us-ascii?Q?hb8AlbmYHdctJg/2i3I0ArjXXOT5sdAk9AP9E8ex0EJFoYH33RZpb42miX1n?=
 =?us-ascii?Q?wccpkeFC+G5/T9xLirYXKzS2nxyljdf/LPgf9upvuvPAbr6UizntVDtKjygB?=
 =?us-ascii?Q?5vjM53VmGkQYJ6Fekk0Vw8SpaHpTZ9Enn4vSql8GlWX9YiwMoV8RKwPeXYZU?=
 =?us-ascii?Q?/qGdz84uDzEQN1JWIvjMeBxu+d3uQgjGkGkAiM1E0LT/BctSaCwQX8+xc2z3?=
 =?us-ascii?Q?hbnrCRtV+wP6anoVhX6DzT11GuIcJ9YW8A8+HQGWCDCU/9jg7cgkMIShlGpX?=
 =?us-ascii?Q?i0ELNR+sI704W1e3xqE+kSBqoiqOLMG3hlMJzdXy4T6Hd29SpLmw8cpFEoFd?=
 =?us-ascii?Q?aKF2UPxPngkzhtSFq/hHw8b5O+vwBF2jswAjT1Ye683ffNBk+/ENveEUnjDY?=
 =?us-ascii?Q?Pc39OjJnUkVNqTifcKZDcgbQs764IFsn94uEoebd2D6ZI2nGEyKzFHu4TN4m?=
 =?us-ascii?Q?3WapAmcJDHtKQNAM8uOdi/8v8zObrIxnAQ2kmczrkAtX4UpvVybvYaT4wcs5?=
 =?us-ascii?Q?ZSp8pusbvCf+f1DNv8sf/QsF3tEp5vzUA5MGaQj7ZrTioe23HPmJuWuNE3o+?=
 =?us-ascii?Q?Do07BCkiwfOs6N2wxU7aqQ1ipQgG9OD8VfkQGwQi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc22a34-7c3c-4819-9483-08dcd1738293
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 08:35:22.1370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mycsY3TuzfPXkteGQxw7BurJn7q7mxU7EzSvbWa+V+aArRLq3CITScAdY7b7bDWM90V8FsSMD9yHx9gcWZau4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10899

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Tuesday, September 10, 2024 4:32 PM
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
> On Tue, Sep 10, 2024 at 08:19:59AM +0000, David Lin wrote:
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > Sent: Tuesday, September 10, 2024 4:00 PM
> > > To: David Lin <yu-hao.lin@nxp.com>
> > > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it;
> > > Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> > > Subject: Re: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA
> > > running on different channel
> > >
> > > Caution: This is an external email. Please take care when clicking
> > > links or opening attachments. When in doubt, report the message
> > > using the 'Report this email' button
> > >
> > >
> > > On Tue, Sep 10, 2024 at 01:52:02AM +0000, David Lin wrote:
> > > > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > Sent: Tuesday, September 10, 2024 5:05 AM
> > > > > To: David Lin <yu-hao.lin@nxp.com>
> > > > > Cc: linux-wireless@vger.kernel.org;
> > > > > linux-kernel@vger.kernel.org; briannorris@chromium.org;
> > > > > kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
> > > > > <tsung-hsien.hsieh@nxp.com>
> > > > > Subject: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA
> > > > > running on different channel
> > > > >
> > > > > Caution: This is an external email. Please take care when
> > > > > clicking links or opening attachments. When in doubt, report the
> > > > > message using the 'Report this email' button
> > > > >
> > > > >
> > > > > On Mon, Sep 02, 2024 at 04:43:11PM +0800, David Lin wrote:
> > > > > > Current firmware doesn't support AP and STA running on
> > > > > > different channels simultaneously.
> > > > > > FW crash would occur in such case.
> > > > > > This patch avoids the issue by disabling AP and STA to run on
> > > > > > different channels.
> > > > > >
> > > > > > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > > > > > ---
> > > > > >
> > > > > > v2:
> > > > > >    - clean up code.
> > > > > >
> > > > > > ---
> > > > > >  .../net/wireless/marvell/mwifiex/cfg80211.c   | 17 ++++---
> > > > > >  drivers/net/wireless/marvell/mwifiex/util.c   | 44
> > > +++++++++++++++++++
> > > > > >  drivers/net/wireless/marvell/mwifiex/util.h   | 13 ++++++
> > > > > >  3 files changed, 69 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > > > > > b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > > > > > index 722ead51e912..3dbcab463445 100644
> > > > > > --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > > > > > +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > > > > > @@ -781,11 +781,9 @@
> mwifiex_cfg80211_set_wiphy_params(struct
> > > > > > wiphy
> > > > > *wiphy, u32 changed)
> > > > > >               break;
> > > > > >
> > > > > >       case MWIFIEX_BSS_ROLE_STA:
> > > > > > -             if (priv->media_connected) {
> > > > > > -                     mwifiex_dbg(adapter, ERROR,
> > > > > > -                                 "cannot change wiphy
> params
> > > > > when connected");
> > > > > > -                     return -EINVAL;
> > > > > > -             }
> > > > > > +             if (priv->media_connected)
> > > > > > +                     break;
> > > > >
> > > > > This hunk seems unrelated to this patch. If this is needed then
> > > > > it deserves an extra patch along with an explanation why this is
> necessary.
> > > > >
> > > > > Sascha
> > > > >
> > > >
> > > > Without this hunk, AP and STA can't run on the same channel if
> > > > some wiphy parameters are setting.
> > >
> > > Ok, I now see where you are aiming at. Here's the problematic functio=
n:
> > >
> > > > static int
> > > > mwifiex_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
> {
> > > >       ...
> > > >
> > > >       priv =3D mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
> > > >
> > > >       switch (priv->bss_role) {
> > > >       case MWIFIEX_BSS_ROLE_UAP:
> > > >               if (priv->bss_started) {
> > > >                       mwifiex_dbg(adapter, ERROR,
> > > >                                   "cannot change wiphy params
> > > when bss started");
> > > >                       return -EINVAL;
> > > >               }
> > > >
> > > >               ...
> > > >               mwifiex_send_cmd(priv,
> > > HostCmd_CMD_UAP_SYS_CONFIG, ...);
> > > >
> > > >               break;
> > > >       case MWIFIEX_BSS_ROLE_STA:
> > > >               if (priv->media_connected) {
> > > >                       mwifiex_dbg(adapter, ERROR,
> > > >                                   "cannot change wiphy params
> > > when connected");
> > > >                       return -EINVAL;
> > > >               }
> > > >
> > > >               ...
> > > >               mwifiex_send_cmd(priv,
> > > HostCmd_CMD_802_11_SNMP_MIB,
> > > > ...);
> > > >
> > > >               break;
> > > >       }
> > > >
> > > >       return 0;
> > > > }
> > >
> > > This function is for setting wiphy params like rts_threshold and othe=
rs.
> > >
> > > mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY) returns the first
> > > priv which by default is in station mode. Now if you start priv0 in
> > > station mode, then afterwards start priv1 in AP mode *and* have
> > > rts_threshold =3D xy in your config, then you run into the "cannot ch=
ange
> wiphy params when connected"
> > > case.
> > >
> > > I really wonder if the settings done in this function are per priv or=
 per
> adapter.
> > > Is there one rts_threshold setting in a mwifiex chip or are there
> > > multiple (per vif/priv)?
> > >
> > > If it's a global setting, then why are we interested in the
> > > media_connected state of one specific priv? Shouldn't we check all pr=
ivs?
> > >
> > > If it's a setting per priv, then why do we choose the same priv
> > > everytime in this function?
> > >
> > > Either way, this function looks fishy and changing it should be done
> > > with an explanation, just dropping the error message and returning
> > > success is not enough.
> > >
> > > Sascha
> > >
> > > --
> >
> > O.K. I will add comment in patch v3.
>=20
> Really I hoped that you could clarify a bit how this function works and a=
nswer
> some of the questions I raised above. That could help us to get a better =
driver
> over time. The same code is in the nxpwifi driver as well, so it's not on=
ly a
> matter of which driver we decide to maintain in the future.
>=20
> Sascha
>=20

I will add the comment in patch v3. I am busy on other stuffs.

David

