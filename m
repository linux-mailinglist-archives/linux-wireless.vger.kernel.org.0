Return-Path: <linux-wireless+bounces-12735-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F44972C0C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 10:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F161F255E2
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 08:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0CB185959;
	Tue, 10 Sep 2024 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q8r6q1pr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF71B14A4C3;
	Tue, 10 Sep 2024 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725956478; cv=fail; b=kaXMKTc629mpEeOlYAm1eMPoc4TUvJAfnIsWIE+6qit5bubNYgToZ9wIiyHti4lrPgrGtR3pYWYw7YySHYs6xzd64EuExeFrTf0Uv+T6ICI497MopBEVA+73d7nwq57n5k6OHTQmXf50SY3wNdckG1kl76RWOfI/L5IY/pPHDpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725956478; c=relaxed/simple;
	bh=hQ6HShR5lsBnlTS4OFIaN5WxzxP0JEfXVGPAgO2UnMs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qNX+erc839WFrIs2zL9yJhWlvhWml6OqJKVd2skmilQ4fIs++c+GxKjfuxpg1XZxC1Lpc7337mcM13XdKF8+DpNYU9jY7ameUvV7CloOOmYxN3/NfbmqrDRbd8QDAOEpt7wcq2tyrbfwQfr+DEuhqG+ZdF9TnJTwIj4pTkplZUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q8r6q1pr; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tx9cjk7KfG2cAmLaTCn8PnmWoXdFd5tHqrgxU6i0sdhctM2JaK36HQP79ubJpUwZTqIbBIIR8A56Es4GbC508RAa7MIDJFVbVFJ6npudkiAGehzpWSBkrEJhmYStJunh6QcxB0g7vrYIL2jhrdWrQQP2+voUQGUBsZ3CLk9EAkqdtsZT90CBOWNpZdwD2gzqD8W/sqF2PRso4OtSovoGHQQ9y6RtGRbKV7Wm7Mh/W1iOg1B5t/Dp0A7gk7KjTNTJm6Im1hf/GL4ZEq6SmADF+EXWj7b/5i6k9pqNX+d7taj2c7hChvawppIsXm26dlO3cqB8kEvqpPYMgYgsCsiRiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bP6HEQmX9keqPTsOZdVogMyAQ4l9rh/Y3y4GPtgVqOU=;
 b=QCtKjxadO4V6l9Ze4Ba/Kp7yxgJ2xcHRnbOY8/1hmSkro+eki8+YsvkHL+ThcunOaChL+L4fjVdnHrv2V0Xmc7iRQ/toFS+3cT7DFhnf1ODCvSjWJq+2A+l9vM4jtCUvh8+0jynqnilmsCwyvPzpxg2EGyEWXooQbCwYhaGPA38kOzrEtHvPxY9Elj7zSMhy0WFvmHZZpRwtQcVMhuvUtmKtJwRvHL2HYjFVKx8ENSg9RIlPz89ij5NUxuaGzOIZnPfe7KbgI1DcgcBiRLfeKtx6mQvoCcW0xthpdzuo0XEermk3UZT2grElQneaie4nLtBGPEG9O0/LRjQNI5lbWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bP6HEQmX9keqPTsOZdVogMyAQ4l9rh/Y3y4GPtgVqOU=;
 b=Q8r6q1prchsFYl8GR5i9VuP2WqhligxNimOaU0wpe6hNnsYfNuOf5ayUicadvJzYLak2qvBhbRiQwed+O2blIZhLqRUaAQP+XJTWAUnhoppSHDUgkNq6aOswqCntwHO9VPzFVsQ5fcz2y64C0QCQQ+FnEmZwTaVJjZjZ+MpfCHxbgjjkbFwbSwotnzP+Jmz7sjA45gkSxTos+wOLph8AOS8hel+C5PbEfy/tSmd6tKrubrQLXP2v+JS6hf1pIBq7MTUzcPhKbcH+P7u6bNVZtLfozSuiw+jpB+O19wN2k8FJfMeKBwJpwrZcSj3L6Fe7ABr/0z47Lz+2qtSAr57m2w==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DBBPR04MB7833.eurprd04.prod.outlook.com (2603:10a6:10:1ef::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.21; Tue, 10 Sep
 2024 08:21:12 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 08:21:12 +0000
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
 AQHa/RQwZkxE7S8BN0ebi7x6fu8g/rJEPYCAgAAPeUCAC6fogIAAWbHQgABDcACAAAAqgIAAAvAAgAAC0XCAABIlgIAAATdQgAALmACAAAN0gA==
Date: Tue, 10 Sep 2024 08:21:12 +0000
Message-ID:
 <PA4PR04MB9638E715A4B73787E8EC28D7D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <ZtWHhSQlPVMekW1I@pengutronix.de>
 <PA4PR04MB9638EC10C0B656B750D922ADD1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt9blTxk88Opujsk@pengutronix.de>
 <PA4PR04MB963813D69B4D87B7147704A5D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt_fZEJyiCyanf7X@pengutronix.de>
 <PA4PR04MB9638C8978D9C6360A9B214E4D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt_h_mW4nFWKu2SI@pengutronix.de>
 <PA4PR04MB96389B2CC16060957878D0D3D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt_zkxGsY2X-8-4z@pengutronix.de>
 <PA4PR04MB9638D57A9623D1B33C802EF9D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt_-Uo7AyMmrnXnJ@pengutronix.de>
In-Reply-To: <Zt_-Uo7AyMmrnXnJ@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DBBPR04MB7833:EE_
x-ms-office365-filtering-correlation-id: 05dd9d25-4fca-4faf-24b3-08dcd1718808
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gnerX0Dh1WCAVZh9Hgja5MN1FUyexgDfQRfeQYDXpwKUuMO0RItjZSWoKZ/j?=
 =?us-ascii?Q?2wXYeinb03uuvA+Ti2Y+bujVk+0d7vZhGFxIV73kJ728mJhnEM4jqn/Ew/q7?=
 =?us-ascii?Q?k8M1GsknGkAiYrhAOzpQ6xlvTuonkG3cs/3kwZxyTcbebuXG35zjPxtMtldv?=
 =?us-ascii?Q?j/mFCu6i6SQij8VuA7TAiEAQag1FIAp4iLUoo943PEfQdPjwDfU4DJXrb2zq?=
 =?us-ascii?Q?oWfeiOQuVaXdLNfqmyopPnRJuaY9tPDg2k6UTysxkcZ8AXzG3cuGizE/bDjO?=
 =?us-ascii?Q?1D2+cYRqVQ9xyX6Hu7bgVF4UOsLvRDqDb/QE8EhDwzT7SLed3KlloBOneFVX?=
 =?us-ascii?Q?qgdUph2rt2k711CFXcFCd5JDrTwiWBzgZ3DtUvDIpTzAFVof0krNbv6ySzTY?=
 =?us-ascii?Q?8PJgamw2tOuH4yEeimOJd5W+gJ9iuEVr9RQM+eSgQPMIlEbm7zqSRZUOVys2?=
 =?us-ascii?Q?x2L8EJHDje3qNpP5zLaTtIHx98K3E1dipceHB7imWIDfalWgBaP/5YV0mLzf?=
 =?us-ascii?Q?cE4kdQjQn8OYXhXVvN0jeITdT4kxs8TljT3Q4vF8c7Zu8qdUpTr3R5+9+iVG?=
 =?us-ascii?Q?cmd79ju9PD25RE/MXKAE5xvdWwqCkR4QxXH5uoj2U2PF4yeAzjRGWmb1cu9A?=
 =?us-ascii?Q?ieYNkSTVVHMmK480LYk8oeVIDY49FZm16kr3V14d4Mgp47XV4kkJ+WF82QGT?=
 =?us-ascii?Q?4DdAFQIjf8eYTkwlk5lnI/0l7N3AnFziYKPhTY7mBYCVOL95CNKDiczxWvmt?=
 =?us-ascii?Q?vUg4bZXDaE1p0GHqUUpQYsJY429rXlCCi6790KE3Joi1hcVCmwJascPoc32H?=
 =?us-ascii?Q?K6Wx8eJHlfsHMm/F/2TZhdFP0ITPajyWDT99EcapIvCrQi9ItwzWPr5U6QZc?=
 =?us-ascii?Q?sZnEntjz7gJdsTmx+NIhXipmNejL4KBfuFSvSIRrdOnlHKyAb4LgjNprHPf8?=
 =?us-ascii?Q?gRvNlRlhIodwYFh06zw6XzTs0w/76kZbr3eBqnB2x5p7CqAWxMWwSAkQTByt?=
 =?us-ascii?Q?oF0psJ7W9tGWxdYFp12OtGW263CpgIjt/oHSIdZprZQ03wahcff7W7LjGO9b?=
 =?us-ascii?Q?c7Os7mA4ZHqrTdBgVuOuuOm9uTWF2C9VN3MDQe1+SpLMy51xoP2i+5GTH2LJ?=
 =?us-ascii?Q?TWnOCp2fKvAS3Yof+R3VVpdHVxiiUopu/n32/gK8KsWxw4nn9UzxX5JMdcSs?=
 =?us-ascii?Q?6XIOF5kVK/D3RH5W0k52AdI9a/LSyI4vegnEkRd5Kqsg8pDRrvOhIXILAyVz?=
 =?us-ascii?Q?wkdC8gCCiI+u6gFXjZCDsCYj12I//iMa4bq+eWIgWLrSFH5lPXxi1cupdphM?=
 =?us-ascii?Q?k9hniYoCM3/ZNziFX5Y1EfqTtddGsRC5m1bDEqZnzWdZcc4vHPb9j2ymGQR1?=
 =?us-ascii?Q?CPvgQ2p7Sv5j+WtYebqbteriTpfOYpq6GPjQMZiQsvZtGaPGpw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jxdju2uRk0VUYlTnNrWt9YH8narimOF2x41Fbt6XE2jE7t+68R/3CM1u/3Hr?=
 =?us-ascii?Q?A8NkOpeA8Se6MS0JdBQCP7JO6updjMROt8dCX8qcJnxTNCmw4gA5Z8g8MIwo?=
 =?us-ascii?Q?QVJZBoAMsJDYfiURNj/4cfoE1sYAkgNbgd1zGUeDxJqbsofAm13/QqH0bUWo?=
 =?us-ascii?Q?nkgO2tQkeBGsCDC8g1I/LRNo/qnflQkdZfPKNDs+KlINT0DsEBEtXDN98s/I?=
 =?us-ascii?Q?qul3IKGimFPu0GboSHu+20vA6lfRcjPi9rFFMJdJ2YCe0Ivo3hUP7cDQD9np?=
 =?us-ascii?Q?aZWuFXECddhxtVBu2/+XOZpL0WNQZ0BLgYvfoVXYGUX/PpwjVpBxfElTS3L1?=
 =?us-ascii?Q?7DAbeu21jU86Og8na5bxtFSAXayx5j0Eirck8M/2FNy6PpWQaIeD5mkAPnps?=
 =?us-ascii?Q?Ogqru0fpushaIEtxaq5uK9ZRqDh4X3DcWc6CHqKabU6/M+ZiHzivv6LRxFx2?=
 =?us-ascii?Q?CSABmFzOxEvXwQseotxy/h4UdyJqHJkGylqmElUAaGphsb5x3Cy+OrloRchK?=
 =?us-ascii?Q?SwYdArDBMvkXhdJNNZipr80Axecn8Vjzz1OenSVURfvySdiFDyrcEIntR37n?=
 =?us-ascii?Q?zBnBYkEOdfqVKauPvriWhftupK5+FL9ahMYwBxDaD28T7DHJNoVR3y7rDjgi?=
 =?us-ascii?Q?2ZFmHpOxbwDzZtMiiFTj6pmsfJRq5iMG8LXUs7eQO71ocz8yY+zSQz4qC1FG?=
 =?us-ascii?Q?vm+RyQbE17NttneGrKaOw/4MgK+AEkrWmu9H92th3YN+e2pm7q1aGGeOtaZB?=
 =?us-ascii?Q?AVyJQl4LBKVK4D0d4qmic3YJIwDdOCo9vHRy+0zFqYamKZzTfJAL1OK/pmhg?=
 =?us-ascii?Q?l64eG+7J8DuLp//sGAUvqshN71O63zwFMZnjyO/y2WI6r26AXTrGBgbZdg4s?=
 =?us-ascii?Q?18Y7fm4tZ3Uq7caLqw0t3YcK/7CbhY0aB/9MdxlzAa6C2vVRnfPX3tBn6XLn?=
 =?us-ascii?Q?gp99MhO1vb+q89wo6vhItbk2qF+fNEmsnE5+myT1sYqOEuDwW8y3Ci38V/vN?=
 =?us-ascii?Q?u9ACcswtGvvBMH1J5nJb/0C62bALRBskCJfb7Aehh5oyIp3P8nalFug5Nkjk?=
 =?us-ascii?Q?Wi+X4O28m1PliZutBV45Skvd/6Hrj8ghIyzfq7MYQEpm+nw8n53zdbOxP4QY?=
 =?us-ascii?Q?ZwZk913gMeDY8uu+egR+SskY111pPWExBs8snUH3JC28rz65XQ4MWWahVzek?=
 =?us-ascii?Q?a2iTvVjwuW92hWN/5xGpp7Lr2zcIs4S/cOWewaeF1Oxlv5mcj3+wauj8lh44?=
 =?us-ascii?Q?UqE2Yic8TD9iRF3t/r6AAprRK1nb+dNkV2Wn9K1Jkl/eWEYy5MrkEKcjho0e?=
 =?us-ascii?Q?85cwkftSWaap9XbWExgT6pWshtKMl7Mb1DOhlbyIt3aaYG3wCG3+/cFM6GSX?=
 =?us-ascii?Q?qq6giE8d+wMox5sxJy01mAbg/MYYdvxvzOtG5i/eTtfsXGuiwKvmLYzTLYSL?=
 =?us-ascii?Q?7W4D4flU67gIsEbzhD2ennf1+GK93se6nC7UABg2Kp9ousegmT+6WEGIrmR3?=
 =?us-ascii?Q?pMOgdOGkPrii7NzLmV4HoKYYNH5F4MnLcm7AFp1tCRhYF2rSRvjUW/scoVuR?=
 =?us-ascii?Q?ZHX9fLMavvoI1Ej54KaR8URKXYUAXhI44ykKe+7c?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 05dd9d25-4fca-4faf-24b3-08dcd1718808
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 08:21:12.3473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +XTiqe8DYR1ZoXlfsh22wpBbnstnDWIE30v7K+lRTdpryRvAMEJ3PWlOUpSypjKDhHaQzfb87iFVyG47ViRTRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7833

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Tuesday, September 10, 2024 4:08 PM
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
> On Tue, Sep 10, 2024 at 07:28:29AM +0000, David Lin wrote:
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > Sent: Tuesday, September 10, 2024 3:22 PM
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
> > > On Tue, Sep 10, 2024 at 06:18:57AM +0000, David Lin wrote:
> > > > > > > > > With DRCS support enabled AP and STA actually can run on
> > > > > > > > > different channels with the current code. You are
> > > > > > > > > breaking this scenario with this
> > > > > > > patch.
> > > > > > > > >
> > > > > > > > > Sascha
> > > > > > > > >
> > > > > > > >
> > > > > > > > DRCS will be checked in the future.
> > > > > > >
> > > > > > > By future you mean v3 of this patch?
> > > > > > >
> > > > > > > Sascha
> > > > > > >
> > > > > >
> > > > > > No schedule now.
> > > > >
> > > > > I am getting confused now. You want us to abandon my patch in
> > > > > favour of yours, but you have no plans to update your patch to
> > > > > avoid a regression that you introduce with your patch?
> > > > >
> > > > > Sascha
> > > > >
> > > >
> > > > My patch resolves the same issue as your patch. But your patch
> > > > can't let AP and STA run on the same channel if some wiphy
> > > > parameters are set.
> > > >
> > > > I wonder did you test your patch?
> > >
> > > I finally see what you mean with "some wiphy parameters are set".
> > > I did test my patch and I didn't run into this issue, because I
> > > haven't set anything like rts_threshold in my config.
> > >
> > > Nevertheless what I am trying to tell you in this thread is: Your
> > > patch introduces a regression and needs an update.
> > >
> > > It's not about my patch or your patch, both are currently not
> > > suitable for inclusion and the question is: will you update your patc=
h?
> > >
> > > Sascha
> > >
> >
> > Without DRCS, this patch can avoid firmware crash and this is the
> > current plan for Mwifiex.  It won't affect any existing features.
>=20
> What I am trying to tell you: Your patch fixes one thing and breaks anoth=
er.
>=20
> The current mwifiex driver *does* support DRCS when enabled with the
> drcs=3D1 module parameter. With DRCS enabled the current driver *can*
> successfully run an Accesspoint on one channel and a station on another
> channel. You are breaking this with your patch.
>=20
> Your mwifiex_is_channel_setting_allowable() needs this:
>=20
>         if (adapter->drcs_enabled)
>                 return true;
>=20
> Sascha
>=20

Thanks. Because the code is ported from nxpwifi which removes DRCS. I will =
add this check in patch v3.

David

