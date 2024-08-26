Return-Path: <linux-wireless+bounces-11937-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB48395E815
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 07:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73EF328165E
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 05:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C7C757F8;
	Mon, 26 Aug 2024 05:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kiLRHTpD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013042.outbound.protection.outlook.com [52.101.67.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80484320C;
	Mon, 26 Aug 2024 05:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724651349; cv=fail; b=jFX4/CsvQRMeiDQgBddc/CSYDkhwvoub7NVVHvTOasN/9y+E0+66AOI79czgEhJYNSB5LqHg+RnVx/FMg1iMGyutgDVkVzxTMREWYdcQhtgD1uk0mQgt5yxVUs8RwsEwRLAUcBc5Dlzsbr1iOYb2ld7T/Tyu6/WwyiXk+Yoa288=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724651349; c=relaxed/simple;
	bh=OavKTJy/6WHVfF3TJTO3oF4052llFOijTWmrge+RUsU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K9GDHhrZ1Vu2LUqVkO2S3xgjjyJOinR/8Azg55geUpKnOdh7evYVffRv3y42Hh5TAnxsGPtGpN5X67ytlhznbSKyIoRSMO8X1A41xVO0k5XQYWm5vC0pUFGGHXUwTiBT1Z5urk6p8jpf6W99POoCSvxXjY6yu3B6vsmCdZVz2xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kiLRHTpD; arc=fail smtp.client-ip=52.101.67.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4rEKohD1sEFmznM5hl8mCXodfA3FlwDmj6XgQ5+Irj4i6q7S3e3d3qUT5X6S3oSx61kZR4yDM6sdNJdvKUR0Dx+CKLvXgLVn4svgHKae3x9V5Db0C+46FKA3bWvxz/8ZlvqQXbtPFXtYoxu47vRw+poKBV/CIHwidZjJCIySIsBM5WNefV9dPRHILKp034ie63vJ2QnNsvGZrJWF4i55P9FFdTsUUDGi5IqaPtf2YiFQM+E7fMnkOfLuIXCwigEo3eNu6wvG73+UQ2WO9nwQntGHVnTiC9mWd0dW7NoVSq3WbyWCzUM3h1r84RpV2GDQ1Vt1QcoYbwk8/D56IfCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caaSZT+oHZaHkEXSv6ut7FhBG1+Pl4LSN3zILrRf9Xg=;
 b=PC/J5W3s1JDLaPfYIyS0ucxAXYMLu0hQrwlT+ts54xFKKNbjvhYqcuANXkuQt441ojEq2vzOgauREHNDJ7ogZWyld529raCwrrpFwAIjBrqcue7L/x8SEU7Bx8s9nvSfxwCFG1Q2i9dpYptT+3HtrZf7x9Ph1b+IoJLFMY3eQiSBpH1TguTS4Ya4vq3EmWeBQuQ8fPkaRUk1lUGGGkDJB2mWJUxp2loMDC6ZdTZyFTJkv3G8qQpp/wmXsOgbGRTuUO1aVbB/ZFDAENRtO6pm0Kv/78I/0Mcg+5GpaKixyHjUk0PRXbeZOkWtvTvyppoZurYrinkHrZ9O0By+iLMtJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caaSZT+oHZaHkEXSv6ut7FhBG1+Pl4LSN3zILrRf9Xg=;
 b=kiLRHTpDt9xfyQRB60FqvcfmkoeC0KLIwrVWXPG6jdzJRq8IwKXCZC3juYW2yYk8rq8z8lKakcbLTDk5yQCEOkAn4Gp0oXUL/4m4X8zAzLBMYfy6LGbYx/cfDZO5a3eGUQNG0j6NGMAhqAYDL8rIQ+hwDv/E7ZxZJl81ca/Z9y4VSg5BeEStbcwOCI5/wlVTOTbLZSjTLgIs++oKqbFbBwyCiOv/+JRUP2jKMKq9Lq6H7BvPF2sByg2sf22+GrcPmiOf7yJA0DPzaSEQF7en5H8rX9Ej8/tm38MgbGHbn/eHzJ1Ke5Aj0YNAqIBZjtilk1vlqkRyTt2A/jN+DTozfg==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI1PR04MB6911.eurprd04.prod.outlook.com (2603:10a6:803:12e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 05:49:03 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 05:49:01 +0000
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
Thread-Index:
 AQHa6kDq7zFfRJGOz0Wel62W8Sr8T7IzUOKAgAU33ICAAGLVsIAABRcAgAAAUWCAACywAIAAARJA
Date: Mon, 26 Aug 2024 05:49:01 +0000
Message-ID:
 <PA4PR04MB9638D0C97ED064776855E2ABD18B2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
 <Zsc1efkBHDXdZtfJ@pengutronix.de> <ZsuWExGZyY8Tvu6s@mozart.vkv.me>
 <PA4PR04MB96384BCB4093D621C43B047ED18B2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZsvtQCXxNJHh_DWS@mozart.vkv.me>
 <PA4PR04MB96386AB354F886DCB899F02AD18B2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZswTABUwME3pliKW@mozart.vkv.me>
In-Reply-To: <ZswTABUwME3pliKW@mozart.vkv.me>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|VI1PR04MB6911:EE_
x-ms-office365-filtering-correlation-id: bac8e7de-ada4-4d7f-2c92-08dcc592c933
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1AlhIU/IuZIqbSpVCBKMvj6MR/B5WLeTesN/Y6AxgOloZvBF39JrokSLeGRf?=
 =?us-ascii?Q?DLESbGvE12P69SYaopQA609NMgKp2djW09c8ERO/T8yWJ2tT+BcEB1JiEaZn?=
 =?us-ascii?Q?K53a6iPPy0wf4YTotMMRd6Hpx+tHgWokHIVlEoUWwolJa/FTZAWk8DxciZer?=
 =?us-ascii?Q?QrKKaMiKPFz4dWwJE01P4qkt4kul+I85TKGaYpebER6v8exGnohESSMWOBM+?=
 =?us-ascii?Q?yGilsT6pwED7IUY9wmMQZGIPhfnzxyrN7HpftIegwmIiPb2LDOnlS3PI3bgn?=
 =?us-ascii?Q?KOKkH+xD9JPale0/2isvqXl9YIvxQAJK6iWC2TlpH1QiGk4RNd4H7lu+UbW6?=
 =?us-ascii?Q?Xr5mDMWvEWQ03HY4xSyrRnHn5syPttbMDI/Rqoils8OlU/x3ON2GeOnwWyhK?=
 =?us-ascii?Q?kiIFPahIv22ws2shDCbxm5ftkZ73AH3YFirlS2nN6vluPu5kbZMEFH06du5R?=
 =?us-ascii?Q?fiKefadLougJBL3JwH80NKklvFk35qp3BZwmTn6hBwS4z5Y/g2+7KtKpQmd/?=
 =?us-ascii?Q?OGSPY3wHjUkfYXpCACo78Fq6EqK2RxxdqWa9qoa46juodIIiwDbsOMiXjE1o?=
 =?us-ascii?Q?J/l+epBtCc4DvrwrXDE+a6HjO86FIhz72nyqSJT6K1nwB0YMOoQcftlzmYmU?=
 =?us-ascii?Q?LlU6QndMSBIRLLwVzDdknXGM5j74izZ8KlUcFe+v3QpSkbzH9RMlXX1kbIif?=
 =?us-ascii?Q?DgVIiK5kG3osFMZEWSf/G3wt5IaqwcocBr9HpW5h6cfhMendkJlzQAnWdhsB?=
 =?us-ascii?Q?H7wopfw+P3IhqtyLCxeOky7pxSPBs3g+W4OKZDTSW4vY6IzIUUHlxAaFf3XO?=
 =?us-ascii?Q?9XrXpKbIv3+cD96xR+m9UrQdPwEyhVraVQJ6b5+2XFNpvnCQG9ypCxhLJzps?=
 =?us-ascii?Q?2SYWB7+iVY2IUQtRLVdiW95TH8rShKIaxv+junvm/9KCmRuKrajvqaBcopXQ?=
 =?us-ascii?Q?/h+IduqX21tgbU11ULD8BDU95sxoGXh/7qSA8MMSPBzWv9z6HJyZ1oiKn4aY?=
 =?us-ascii?Q?x4yaBTnz0FEtm2KapJaOm0MKnc+mz76/ZPE4TnLGyjIbj0oTTKIDRBnfML5r?=
 =?us-ascii?Q?k5VsZv+WZiX3r41Sy7x/VsxlKO89sYQxmvMVC1xhDeKrtXwoZwuvGFSNGExN?=
 =?us-ascii?Q?P41DGkzTkoE6vGM8qpihWzefonLkOdQTZHE9PTGHBW/7UBeeSVocf4khUMad?=
 =?us-ascii?Q?fXYVdL/WvCNrC7IK0Z16jRTEKRW3+UWNfiC9FJ8lbKL1l/82VevmYoGLMH7Z?=
 =?us-ascii?Q?C1j+I/svoXreIsaW1tP8YJ5AOYda9KYa66x5K04K9tfheavZ+soN9h7wB8UI?=
 =?us-ascii?Q?kj53SKYLytV3FUgj2zIQmlVm2PAXcByyxgLnWqSwubXsuXvOQKUtGkp29k5G?=
 =?us-ascii?Q?tCBfhwo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6cBI67b13yTJlGHvhFjLs1p0I1osTCcTavWCiO+qk5f52C8ZIfpwsGgmn1AC?=
 =?us-ascii?Q?huKKNHmPzrt++sN3tOp/KlAQC1pESm1y/+ZUAGAFNVHajrgKuNQ+YmE38hns?=
 =?us-ascii?Q?Yg4Wa+kcOBe2eMU7qBk0ScFSfByRXjflo7az8S4/cC8FCK8dfI6DtMy2hQpV?=
 =?us-ascii?Q?08Wu5fRqvaiJ7OCrFzuiPll5uMW4QS9Q0+OUYenLJ1SSXRPI0bZSV/dKyEYC?=
 =?us-ascii?Q?l3vC3TfbX/ghW0fanQmIbT/AKoptjZBMaXtZlkWQSKWaYR/oBLmPxO/e1SPc?=
 =?us-ascii?Q?XqUthKYeCqB2KMId+7APaVozMbs+UJGbg/RcJpT2c6yjddK0NfQYREtub5Ts?=
 =?us-ascii?Q?UZEL/z8GKFg2M+URSPBk4ntGr0jw27USSRnd2Wwex/noS1puWJvcPPCMYmUx?=
 =?us-ascii?Q?S5eWz+d86+PL9rdztqKOkoYMSDC/hBzk3Z6JCGm+WhUgr8VNjxaHVz2f/Gm3?=
 =?us-ascii?Q?j2V4L68NmUC6TUAIxvIZqqSKaqtwxvSexkoYDkrfbyc8d7eEoeXR/Snx0t9I?=
 =?us-ascii?Q?j7iowfuIkLqhmtvpbqlLiONSAU3KIZh907CbZXBCyVhFc+XhBC3JAHjLKdwU?=
 =?us-ascii?Q?IV8ITD4FyfVH9Yrev9dq5hJe0MUw4oc4j4fVGw7SSwFH+eZHCvCNNgK5jfZY?=
 =?us-ascii?Q?ZDO0DRFGbB5XCYNBOKbOwP4JS/24gI097neanRa9OfPqXb8KrxNveoDDsyK3?=
 =?us-ascii?Q?M7dqafE9lpGy6pP9Fn/mSj+t1z0jeI0zvGb1+qHV7PYm3ro3Aexv02R4Z3oP?=
 =?us-ascii?Q?A2rag3Vkoumkp44M8Pn4GX2sofUqmse5unnnghDK4emVHs4RnR2L76sgUlB0?=
 =?us-ascii?Q?9XoiZMNHakm+wlPT/+GQUrobMjaHHOXneyJ39hd4B4rzsAwfkkjoUyDoR0rF?=
 =?us-ascii?Q?72jpiuIJ3NOHqbyp/Tg5XvmXzWpU9M4dcGDS6ELvwl3AsIMM0bMJeiGozI79?=
 =?us-ascii?Q?XL4LHoqNq05IBEvuPIQW5vA9zn018XelyjT7tN3LloeppDs5ns54hlrmvzUI?=
 =?us-ascii?Q?ryoYQinzYZH05tgg+XD5TuQ0v3IfkAzen3w/po89aMyFe6C1TtqCgfQTouTu?=
 =?us-ascii?Q?51PfXFBcDmywPen8Nw5WR5iJPNm4VbbxA/cMl/GKzWSIzmYqPlCtl/9zLT2T?=
 =?us-ascii?Q?OKdajuHyQd3pTI6tuhC0adRZgudl/rL2xM3NqZNn002+0TxnDSSAMZHg9Ew4?=
 =?us-ascii?Q?zDjCBQZVIPytdgYpMdkgikLLnnAS3Rjowb1gjRs/VIy/SwJDB9w5pUZX37wz?=
 =?us-ascii?Q?nw/6Ewee6S9+mb0DArWdlQ2cpHN6Z1KFJoVXxj1Huxn+U1Ax5b0eyKq9OVqf?=
 =?us-ascii?Q?ZcZCKoqBVH2HI6Lo0Txd4tFtb6+y/0Nc14q0MIBJ9BwfnJC5zcPHCo6lXpPE?=
 =?us-ascii?Q?M+5cXXSA8WtDpsqWfs0xOWwNLVIaf+vu+//vpB+55gOyK88OLU9DJl9RYzYY?=
 =?us-ascii?Q?IQJML33HdUE3lRu7bgFjI2z6KQD7XJ3k5ddim5K2UTVKPb3bhkxDefvphmwQ?=
 =?us-ascii?Q?KKid8WOG/yszer5an8q2zdaI6Kxijl8s5UmG+b+D8/qbH+PENBAdrCzFX/sv?=
 =?us-ascii?Q?OFjmx0pAEKRePl29RR8HMouUauyPOuyfAFJVZlpK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bac8e7de-ada4-4d7f-2c92-08dcc592c933
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 05:49:01.0874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RuAgyCFEN7qKPMNofSR1YVnnY/tmt7D0/dU1NoZNsx8mdJ3vbN7UzdAVQBxQy1D8IjGm4Cr3BQcghJbwLPJsQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6911

> From: Calvin Owens <calvin@wbinvd.org>
> Sent: Monday, August 26, 2024 1:31 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>; linux-wireless@vger.kernel.org=
;
> linux-kernel@vger.kernel.org; kvalo@kernel.org; johannes@sipsolutions.net=
;
> briannorris@chromium.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; kernel@pengutronix.de; calvin@wbinvd.org
> Subject: Re: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to =
support
> iw61x
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> On Monday 08/26 at 02:56 +0000, David Lin wrote:
> > > From: Calvin Owens <calvin@wbinvd.org>
> > > Sent: Monday, August 26, 2024 10:50 AM
> > > To: David Lin <yu-hao.lin@nxp.com>
> > > Cc: Sascha Hauer <s.hauer@pengutronix.de>;
> > > linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > kvalo@kernel.org; johannes@sipsolutions.net;
> > > briannorris@chromium.org; francesco@dolcini.it; Pete Hsieh
> > > <tsung-hsien.hsieh@nxp.com>; kernel@pengutronix.de
> > > Subject: Re: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create
> > > nxpwifi to support iw61x
> > >
> > > Caution: This is an external email. Please take care when clicking
> > > links or opening attachments. When in doubt, report the message
> > > using the 'Report this email' button
> > >
> > >
> > > On Monday 08/26 at 02:33 +0000, David Lin wrote:
> > > > > From: Calvin Owens <calvin@wbinvd.org>
> > > > > Sent: Monday, August 26, 2024 4:38 AM
> > > > > To: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > Cc: David Lin <yu-hao.lin@nxp.com>;
> > > > > linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > > kvalo@kernel.org; johannes@sipsolutions.net;
> > > > > briannorris@chromium.org; francesco@dolcini.it; Pete Hsieh
> > > > > <tsung-hsien.hsieh@nxp.com>; kernel@pengutronix.de;
> > > > > calvin@wbinvd.org
> > > > > Subject: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create
> > > > > nxpwifi to support iw61x
> > > > >
> > > > > Caution: This is an external email. Please take care when
> > > > > clicking links or opening attachments. When in doubt, report the
> > > > > message using the 'Report this email' button
> > > > >
> > > > >
> > > > > On Thursday 08/22 at 14:56 +0200, Sascha Hauer wrote:
> > > > > > On Fri, Aug 09, 2024 at 05:44:50PM +0800, David Lin wrote:
> > > > > > > This series adds support for IW61x which is a new family of
> > > > > > > 2.4/5 GHz dual-band 1x1 Wi-Fi 6, Bluetooth/Bluetooth Low
> > > > > > > Energy
> > > > > > > 5.2 and
> > > > > > > 15.4 tri-radio single chip by NXP. These devices support
> > > > > > > 20/40/80MHz single spatial stream in both STA and AP mode.
> > > > > > > Communication to the IW61x is done via SDIO interface
> > > > > > >
> > > > > > > This driver is a derivative of existing Mwifiex [1] and
> > > > > > > based on similar full-MAC architecture [2]. It has been
> > > > > > > tested with i.MX8M Mini evaluation kits in both AP and STA mo=
de.
> > > > > > >
> > > > > > > All code passes sparse and checkpatch
> > > > > > >
> > > > > > > Data sheet (require registration):
> > > > > > > https://ww/
> > > > > > > w.nxp.com%2Fproducts%2Fwireless-connectivity%2Fwi-fi-plus-bl
> > > > > > > ueto
> > > > > > > oth-
> > > > > > >
> > > > >
> > >
> &data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7Cff25728795724a618a5208dcc5
> > > > > 45c
> > > > > > >
> > > > >
> > >
> 5fd%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63860215067862
> > > > > 3224%
> > > > > > >
> > > > >
> > >
> 7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB
> > > > > TiI6
> > > > > > >
> > > > >
> > >
> Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DU0Cej8ysBD%2Fg1Sa4Ia
> > > > > Ph63Ot
> > > > > > > iTcemadiCfMINYM%2BRL4%3D&reserved=3D0
> > > > > > > plus-802-15-4/2-4-5-ghz-dual-band-1x1-wi-fi-6-802-11ax-plus-
> > > > > > > blue
> > > > > > > toot
> > > > > > > h-5-
> > > > > > > 4-plus-802-15-4-tri-radio-solution:IW612
> > > > > > >
> > > > > > > Known gaps to be addressed in the following patches,
> > > > > > >   - Enable 11ax capabilities. This initial patch support up t=
o 11ac.
> > > > > > >   - Support DFS channel. This initial patch doesn't support
> > > > > > > DFS channel
> > > in
> > > > > > >     both AP/STA mode.
> > > > > > >
> > > > > > > This patch is presented as a request for comment with the
> > > > > > > intention of being made into a patch after initial feedbacks
> > > > > > > are addressed
> > > > > > >
> > > > > > > [1] We had considered adding IW61x to mwifiex driver, however
> due to
> > > > > > >     FW architecture, host command interface and supported
> > > > > > > features
> > > are
> > > > > > >     significantly different, we have to create the new nxpwif=
i
> driver.
> > > > > > >     Subsequent NXP chipsets will be added and sustained in
> > > > > > > this new
> > > > > driver.
> > > > > >
> > > > > > I added IW61x support to the mwifiex driver and besides the
> > > > > > VDLL handling which must be added I didn't notice any differenc=
es.
> > > > > > There might be other differences, but I doubt that these can't
> > > > > > be integrated into the mwifiex driver.
> > > > >
> > > > > Hi Sascha,
> > > > >
> > > > > I'd also love to see this patchset, if you're able to share it.
> > > > > I can test on an
> > > > > IW612 if that's helpful at all.
> > > > >
> > > > > > Honestly I don't think adding a new driver is a good ideai,
> > > > > > given how big wifi drivers are and how limited the review bandw=
idth
> is.
> > > > > >
> > > > > > What we'll end up with is that we'll receive the same patches
> > > > > > for both drivers, or worse, only for one driver while the
> > > > > > other stays
> > > unpatched.
> > > > >
> > > > > I have some concrete experience with "in-tree driver forks" like =
this:
> > > > > a pair of SCSI drivers named mpt2sas and mpt3sas.
> > > > >
> > > > > The latter was created as a near copy of the former:
> > > > >
> > > > >
> > > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%25
> > > > >
> 2Fgi%2F&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7Cfeaa265eadca4cef88
> > > > >
> 3608dcc5903c0d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638
> 6
> > > > >
> 02470501904923%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> QI
> > > > >
> joiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D7uf
> > > > > Rl6fwgw1oxLa4DBQxpwrm9D6ojbdFYNAuHRCA5vk%3D&reserved=3D0
> > > > >
> > >
> t.kernel%2F&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7C582c3c0573b74f83
> > > 42
> > > > >
> > >
> 3408dcc579bc4a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638
> > > 60237
> > > > >
> > >
> 3871805816%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> > > V2luM
> > > > >
> > >
> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DbLjsRTRsR%2
> > > BTtA
> > > > > jUIVDY396ZF%2BIkwwUFhAubTCin3IVk%3D&reserved=3D0
> > > >
> > >
> > .org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fc
> > > > o
> > > m
> > > > >
> > >
> mit%2F%3Fid%3Df92363d12359&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7
> > > > >
> > >
> Cff25728795724a618a5208dcc545c5fd%7C686ea1d3bc2b4c6fa92cd99c5c3016
> > > > >
> > >
> 35%7C0%7C0%7C638602150678637352%7CUnknown%7CTWFpbGZsb3d8eyJW
> > > > >
> > >
> IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0
> > > > >
> > >
> %7C%7C%7C&sdata=3DmzrLLqJNee7vIdV47j8xVSU%2FByjh%2FnNKnRsx1nw3yNo
> > > > > %3D&reserved=3D0
> > > > >
> > > > > The result was *exactly* what you forsee happening here: both
> > > > > drivers were constantly missing fixes from the other, and they
> > > > > were just subtly different enough that it wasn't simple to
> > > > > "port" patches from one to the other. It was a frustrating
> > > > > experience for everybody involved. I think their git histories
> > > > > prove your point, I'd encourage everyone with a horse in this rac=
e to
> take a look at them.
> > > > >
> > > > > It took three years to finally unify them:
> > > > >
> > > > >
> > > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%25
> > > > >
> 2Fgi%2F&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7Cfeaa265eadca4cef88
> > > > >
> 3608dcc5903c0d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638
> 6
> > > > >
> 02470501916954%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> QI
> > > > >
> joiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DwbG
> > > > > SKlaMVBnzXon1ZEEAmctWCBCkVDFqWld9d6zLvOQ%3D&reserved=3D0
> > > > >
> > >
> t.kernel%2F&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7C582c3c0573b74f83
> > > 42
> > > > >
> > >
> 3408dcc579bc4a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638
> > > 60237
> > > > >
> > >
> 3871815005%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> > > V2luM
> > > > >
> > >
> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DRfY6N6WWXI
> > > n0gZP
> > > > > SBoRySz5eeU8WkFH2HvFHLVNgu3Q%3D&reserved=3D0
> > > >
> > >
> > .org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fc
> > > > o
> > > m
> > > > >
> > >
> mit%2F%3Fid%3Dc84b06a48c4d&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7
> > > > >
> > >
> Cff25728795724a618a5208dcc545c5fd%7C686ea1d3bc2b4c6fa92cd99c5c3016
> > > > >
> > >
> 35%7C0%7C0%7C638602150678649431%7CUnknown%7CTWFpbGZsb3d8eyJW
> > > > >
> > >
> IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0
> > > > >
> > >
> %7C%7C%7C&sdata=3DUGjDfngO1POWuydIfmOL%2BR%2BqJ1BoDQW6NboQUV
> > > > > q2Xh8%3D&reserved=3D0
> > > > >
> > > > > I doubt anyone would disagree that wifi drivers are much more
> > > > > complex than SCSI drivers. It would be strictly *worse* here,
> > > > > and the path to unifying them strictly longer.
> > > > >
> > > > > Thanks,
> > > > > Calvin
> > > > >
> > > >
> > > > I think Nxpwifi will support NXP new WiFi chips and Mwifiex will
> > > > support
> > > existed NXP WiFi chips.
> > >
> > > Hi David,
> > >
> > > I understand that. I don't think that really changes anything: there
> > > will still be many future patches which need to be applied to both,
> > > because the bug being fixed existed before the fork. As the forked
> > > driver diverges, that will only become more difficult and error prone=
.
> > >
> > > Thanks,
> > > Calvin
> > >
> >
> > Nxpwifi is not only a fork from Mwifiex. Especially after we modified
> > Nxpwifi based on the comments from Johannes.
>
> I understand you've done real work here. But at the same time, nearly 1/3=
rd of
> the changeset against the original driver is renaming things:
>
>     {0}[calvin ~/linux/drivers/net/wireless/nxp/nxpwifi] tar cf
> ~/nxpwifi-v2.tar .
>     {0}[calvin ~/linux/drivers/net/wireless/nxp/nxpwifi]
> cd ../../marvell/mwifiex
>     {0}[calvin ~/linux/drivers/net/wireless/marvell/mwifiex] tar xf
> ~/nxpwifi-v2.tar
>     {0}[calvin ~/linux/drivers/net/wireless/marvell/mwifiex] git add *
>     {0}[calvin ~/linux/drivers/net/wireless/marvell/mwifiex] git diff --c=
ached
> --shortstat
>      42 files changed, 13878 insertions(+), 14274 deletions(-)
>     {0}[calvin ~/linux/drivers/net/wireless/marvell/mwifiex] sed -i
> 's/nxpwifi/mwifiex/g' *
>     {0}[calvin ~/linux/drivers/net/wireless/marvell/mwifiex] sed -i
> 's/NXPWIFI/MWIFIEX/g' *
>     {0}[calvin ~/linux/drivers/net/wireless/marvell/mwifiex] git add *
>     {0}[calvin ~/linux/drivers/net/wireless/marvell/mwifiex] git diff --c=
ached
> --shortstat
>      42 files changed, 9940 insertions(+), 10336 deletions(-)
>     {0}[calvin ~/linux/drivers/net/wireless/marvell/mwifiex] cat * | wc -=
l
>     45591
>
> I'd consider that a fork. For those following at home, I pushed a branch =
to
> github with nxpwifi v2 applied as a single patchbomb to mwifiex, with the
> renames backed out:
>
>
> https://github.co/
> m%2Fjcalvinowens%2Flinux%2Ftree%2Fwork%2Fnxpwifi-on-mwifiex-no-renam
> es&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7Cfeaa265eadca4cef883608dcc
> 5903c0d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6386024705
> 01925106%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2
> luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DD%2BO4x
> pCU1OMwPYkMq7T6X9Cf95Gdt7bNhnfqNzaOyQA%3D&reserved=3D0
>
> For my own selfish part, I agree with Sascha: I'd prefer to see that chan=
geset as
> patches against the existing driver, because I know from experience that
> having a community built around one driver will enable me to deliver bett=
er
> results for my users, and will make it easier for me to contribute when I=
 find
> bugs to fix.
>
> But this is just one random opinion, I'm not who you need to convince :)
>
> Thanks,
> Calvin
>

Yes. From your commit, it is very clear that Nxpwifi has a lot of changes w=
hich are used for:

Cleanup original issues of Mwifiex for checkpatch.
Remove command response file due to command table is used (command response=
 handler
can be hooked to command node when command is searched at first time).
Only updated API/interface, host command and SDIO new mode are supported.
Only support separate auth/assoc.
Modifications based on comments from Johannes (please check changelog for p=
atch v2).

Nxpwifi will be a good base line to continue to add new features and new NX=
P WiFi new chips.
It is also clean and easy to be maintained.

Thanks,
David


