Return-Path: <linux-wireless+bounces-12335-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2C99684C2
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 12:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3F51F233BD
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 10:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF24A13B5B7;
	Mon,  2 Sep 2024 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="klJ/8fLS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2050.outbound.protection.outlook.com [40.107.105.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C375913A86C;
	Mon,  2 Sep 2024 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273306; cv=fail; b=BRQN8+vcQNmGQBW4T8OYaR1huAUjvYziTOgjS15VMUecxnHeadarxqpT++CupInZf91IVR1HGhxH52HixVBzamJ/7tTHgjavQm2S2yPmnDacp3+QRsSr7L3UjDFNr/6mV1dByKVzXHXwSIwMWlKuZHCpRLDtvvpWkwEn6a0iDZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273306; c=relaxed/simple;
	bh=WJfsUQ7OrZBTYX/esmOG0ELIeEY4VuV1NreoiSqBBhs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q5l6/IXG6c5MIrAauC64VevvbBG7jErAkBamXq0nsM8PRipglbDsIQEiOimHrN0ZNulStnIsSc9maO6Sl/KPH5KrrmqZxFpQJ6bc16XbvRf4wfxSvypxujuhwullByzspItoDFsIPueqPFn5tiqcgPgleYwlDXoF5YAWTXYoeQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=klJ/8fLS; arc=fail smtp.client-ip=40.107.105.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqmXpLcPYxrUEJzY/XY6x8wo16hA0vFqMlpj9z53SJKm5jA5lg3sY0ZniNUqCeS/6JpquBhAeflriPzDMYbjVgAvFbCcCPlKx1Icy+piwDcS0Lq90lfnse2YBo6WdEiYAY5VlQr0t8FD2FWQUrgBy+nTRj+kk0Kf5ZE0QK1ZXrXNzDFl8Q68ZWrki/+CRGJX2+dt9BrbJdQ0mVJHzY7KGqAaIWZYZamIjLHleRBpIbHmIpZPEienR8dJBIH5HRaOityPlVtdNeUCDNO9c82lY5E6GW6p+Sgc3wKNMUjQOxqPnBbYXBKX2uuqk2EaUyZ28IHnUUeQU6bIIPrUCEBu/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJfsUQ7OrZBTYX/esmOG0ELIeEY4VuV1NreoiSqBBhs=;
 b=lIDloswN9qCyOqgbM4E55vp+4a4yQ9+GVSeAN3uF+KdHcUE6A4XrvDMovWq+bk52wF1pbQJginDyBwDifIBhiv4joZlrgNCr18DxXe8pBUpYYJlPxja/yamfeFtWmWPTa4ELe86FoTGxQHykUdbGlZEDLvZQuDYz14gLz3Xkmuf6dYenIHInZyYyDFysurPN4dUCXfJSodAsm8rKlU3z+uuvi0xyqlgFPy1iw8KRwX/r5Tg9paQoXyaC8T7W2wBi1MZTJmQbGvJjff07ARQC1+veaRD/a5dMCERulUHhZ4TBp57/znKqlfb2fe05bYo4o3qKlbD2G4mewRmbtYOnCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJfsUQ7OrZBTYX/esmOG0ELIeEY4VuV1NreoiSqBBhs=;
 b=klJ/8fLSAX4kTJD5ldVO5wpSvz/czuHL2hufA4k5NWo0c3HpE8w6PWw6xWQ9Yqg8FnbWfxSXK4Ym1TTke0YUbpbTfBN5lW86pkNlQQohcG9Ka5ABHJ0/2muWt6PdCBA5IvY6ZiHiZRsYrdxwzeQF4OupZQ7jb/LwhbCtXum2PZjStnkikgFTwc63ge3gjXTzPs5ITk2k2BE1Aue9FefUqcNJ3zbaCBzY0pFA2RvRdAg1sH8Vv3B8taB4K9nCsL2xAeg1RD3dEX/McoJPWm1RdsoYaOVegWLgSIFwwvn0yLItQ8mHgOQMKq22YvBO9cmgAIubOv7LH2r99tAhOLYfFg==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PA1PR04MB10914.eurprd04.prod.outlook.com (2603:10a6:102:480::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 10:35:01 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 10:35:01 +0000
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
Thread-Index: AQHa/RQwZkxE7S8BN0ebi7x6fu8g/rJEPYCAgAAPeUA=
Date: Mon, 2 Sep 2024 10:35:01 +0000
Message-ID:
 <PA4PR04MB9638EC10C0B656B750D922ADD1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240902084311.2607-1-yu-hao.lin@nxp.com>
 <ZtWHhSQlPVMekW1I@pengutronix.de>
In-Reply-To: <ZtWHhSQlPVMekW1I@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PA1PR04MB10914:EE_
x-ms-office365-filtering-correlation-id: 92a68bb5-a3cb-4172-20f0-08dccb3ae668
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ufQoLgpQv5BXnMgaPWE2JlM5vU7HMQ4+GYndwUJUptiqc5VBI7r2ZQf1xuN5?=
 =?us-ascii?Q?v5ElwXeQU6cu4HsFqa6rOPAmEw3X+Wh0vtPMOSU6fT3NIc1STt+b05kgx4uB?=
 =?us-ascii?Q?SWIo2tVMUUHH3GuGxqRNhNh/Okt8GWAOlAbZLTW6dzXfKnkKo8Dr4l7a4PnO?=
 =?us-ascii?Q?xe9KlqHFNymTMylDEOSrBbszqpn3G2EjSYsX4q/gHpSU/p3x9+/IB3B76TZN?=
 =?us-ascii?Q?x/ebfeu58BWw4/4qKWq0qGN5NbmB3ZmWp876t+Lrrox5Dlex9HuW3O1wP+0f?=
 =?us-ascii?Q?wW0BncqZSemD3A/CHmj8H+VyPsGLqoVQ8wiy4J3k4b7Gs7o/Db7+HG7qYzPo?=
 =?us-ascii?Q?qDKyTAT656BqacWj5FPHTOFloft4RW2RJ8uy/m6XFL5+8YmN2z6haO0WozAG?=
 =?us-ascii?Q?BUGaVT0S46IOvw4LSldz5IYwiF10htntJG2J3iPtCYH04RmlFyTbICMtHVL3?=
 =?us-ascii?Q?J4/oXUNN5/cEc2AnHI1lgEQxtWAnp9Yco17BLpX+S3ErXqKDh+rj9rA4uCSZ?=
 =?us-ascii?Q?duHcUAyJqaqkw5hUav1jduBiRISUvHrhoOpCq3WH4crRXtjBe2SMZ3GL0YBC?=
 =?us-ascii?Q?o5+E/nmp8NMiH2dJDtaNxJNDid+ak/EG8AuFQQ7ZYZwLjXY4ECfzcyuQ8d/z?=
 =?us-ascii?Q?orcbBgP97DnioW5M1XAkJZ+7zOuhFYBNElgxtIFsewqScpUhgwB1QVTTV2sx?=
 =?us-ascii?Q?EeWnRpRmQU8XF/dQs6hVix8ii/nRjORSacHqR60+7j51wtLloU3TGwSvSEk6?=
 =?us-ascii?Q?Yr07tegERSzaX10HAZWV1RqkNMZlYcTTl2YCUF7+ssBTuJzfNI8IpwnItNM+?=
 =?us-ascii?Q?Il77Qbtj9NcSpOHgL00BsuYAU3AtO5u8Ljp2Jj1XktG7bcVhMdBM0CsWsTDQ?=
 =?us-ascii?Q?212EJrK0BhSIyaCmEcGSWuo8a9sgGpBvTd5rcHhTgoZj8MUWfAu/0WWgNp+a?=
 =?us-ascii?Q?sxmpoFYN6opZESBuk1fyXBKgIawao5ZTSpeMB7dO3C+SlaM8DBi7qs1H3zp+?=
 =?us-ascii?Q?YYQyMZ/nBvESOIpe9j7ZxC+7rKVoU+Pji2KvvoAfyVm6JQe6Y+BW1ENszNvt?=
 =?us-ascii?Q?TgSZYDRR/MTLARbBCm73zrmbkQdhSWqpWPamjLOonX+80H3w6p9Zs0OYhiEz?=
 =?us-ascii?Q?NxFA68NOkgVftx0V9j0oL8gw6ChvAa0LxMYOs0JXC5PPkHa56ST69te6ANOl?=
 =?us-ascii?Q?0lHJUldTrv2xzWV9pJ3O70LcKnfCZXAv4jF21zxjKvZPKioxLHSm+mrXrXbw?=
 =?us-ascii?Q?aclC65zmlaSykBp98cYYJywrEp3vNUAHoN7KffUs2y4FeJGT0fGmIKsNV9P3?=
 =?us-ascii?Q?LEH6tCntN9cknPkhie7vO/XCQzqNOKqRswYsBqG9er8oQqHWTPydH1/cNt+3?=
 =?us-ascii?Q?OMI2i4U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zIsmDiZyN+70U3jlMiEwPbYLlbLtOCyD/Ti8bJWLVSHyM59ytfiZb0JrFIQF?=
 =?us-ascii?Q?B39Mw+FijTLjPpzO7sYz+qEUVsy8opIJgd9j8pGb26zmCZBz9v/zeGHHIw1n?=
 =?us-ascii?Q?bi5oJnupIyGs3oqTX9ZScdnAXrp5vag+0/NzI4W7D3pasGsi2cUOOCcZYX8L?=
 =?us-ascii?Q?1NhpNVCqIL1t24XkUDXSR4txhCrWQS65clQQMnnM/CY0FiGq3wva4gOM+oxN?=
 =?us-ascii?Q?o8sbw7bP8N/NWYRkWmlPAWN+iu1hjrwQfgrFQvED0j0NWawovVqBIL/IGr6P?=
 =?us-ascii?Q?hTD3iH8dgoS99OPOlWaW+71vzQ5OQQCaADVr/qlaj3cLbxT81W4Gr4a3soX/?=
 =?us-ascii?Q?9vAIrapyRAgd9zhT6fgreF7CYhkHZIuOj731nDngTnRjLsmlOt5bGDQW8zmV?=
 =?us-ascii?Q?rJ1wVdYOCLEuRXK6FdoSwBWE+IMu8rV0IqNHWtpFvvI09TKEY8x6fJolHrVI?=
 =?us-ascii?Q?DUqlIdEQ/QIwgD/dTvp5YfijgBB5o1f9JbcAnmIbCM2xIXHjvTdxtAcQ0HzM?=
 =?us-ascii?Q?GfUQNgGue4zPMl9HVLCmK6a1wwAQfATXoAeIAkinxJjYL8+I5DJPV3cQE2mu?=
 =?us-ascii?Q?nXeMJsmVbG63knWgSj0DXLAn4x4y2WY08wLuVTI/Ch5mt4W0wBJsusWTEPMy?=
 =?us-ascii?Q?Ziz1uO00lgi0xMVyPDpjhcxK5zqVrEG+cysyYpxAkt7H+KZ6MRneVu7EfRtR?=
 =?us-ascii?Q?6g17n9dAylGDL0O3u2xzvLm3gPxIFw1ktZ3UHoFenWVvMBbDTZk0uf2TEgIg?=
 =?us-ascii?Q?ykJfGOFg46NbrWFaYINT8XdIMZOpaGYyVBEZOh0oDF83L8kSjd7g7j2cRV1E?=
 =?us-ascii?Q?S/AmwgQ1AMdzdTf/p1WRFsR+56fbICbzv0Gr9yoc6bNXnCJ/pjSek88ZZJxu?=
 =?us-ascii?Q?50C6w0kTpyL99IU1WiH7wVujxvecmb0GV6CNSrXUrEuY4/Jkfnvd9luCExtG?=
 =?us-ascii?Q?e+SgJRYPOO/xdWVj2Iigb8d2iGFLhLXrJwctOLA6WLj3fcl/PgJwMSjF8Yum?=
 =?us-ascii?Q?0rF8W2L5HqE/dmZP4L0PtLFHLP7Y0xqWU7mzQYoH+lIuHi3aRGhx89jqRou5?=
 =?us-ascii?Q?sVLOeDr1HaeSM3IUndtWCheVS5wzt2eisM9QAtzPkR5mciTP1KhGMZuuyh+M?=
 =?us-ascii?Q?YBlkEhZPN+ejfoCiCBtVK2S5xsGnB7VgblK45SkivUac+72vUFGCko6EtAdd?=
 =?us-ascii?Q?fVThzckKkNR87VfZZxwY5MWTuwHgmsFqEiXLViPf3vLncKJiFN2byOame9c4?=
 =?us-ascii?Q?AVvJOHl8NVudD2CbJ7rQfLqRUh9R7OpDwFU+7Hjfw6bnN8IEW4x7CSj6nCc9?=
 =?us-ascii?Q?R7MHtuIniUvW78C7azvyWQmpbHi3kgejeyM7pw3mlTe3yf+dIf/XV5Q8Db9v?=
 =?us-ascii?Q?C72MNvkLWH8o//Q/R8VMIKWq+pnt0Pc9lYRS/pTDLTU0T2CST0Yi1gD4/Fi6?=
 =?us-ascii?Q?MrYMk/4C0Bz4rioTeI+HcrT55USqTobtQl6qUsYfzk2+aFqcO4uZcuHE+0OC?=
 =?us-ascii?Q?I4dRjfmuR7KS9Md10IwJVcB5shBZdzB0X+VrMe+r3cwIchQxFkr2Omb6pixL?=
 =?us-ascii?Q?4CqySRk0KmGsVh9hxuU6Hp14STmXFh1pxS+scpQ3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a68bb5-a3cb-4172-20f0-08dccb3ae668
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 10:35:01.3846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QPa4N5HpDz379B41RMPGEQujr430Nssu77AL0FoXcPedBcIpDUKaUc0p8T9VKmcAs0RmLC7DXPvAlhcH5iaDUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10914

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Monday, September 2, 2024 5:38 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA running on
> different channel
>
> On Mon, Sep 02, 2024 at 04:43:11PM +0800, David Lin wrote:
> > Current firmware doesn't support AP and STA running on different
> > channels simultaneously.
>
> As mentioned here:
>
> https://lore.kern/
> el.org%2Fall%2FZtGnWC7SPHt7Vbbp%40pengutronix.de%2F&data=3D05%7C02%
> 7Cyu-hao.lin%40nxp.com%7Cce9b7d4e417c41113c7d08dccb32fc49%7C686ea
> 1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638608667089710854%7CUnkn
> own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h
> aWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DnMZO565xCUO%2BwxD4tIfi
> w6cGyYrinaEsi7XLfqyxgXg%3D&reserved=3D0
>
> AP and STA can indeed have different channels when DRCS is enabled, so I
> think you have to check this in your patch.
>
> Maybe the same question here again: Wouldn't it make sense to enable DRCS
> by default?
>
> Sascha
>

I will look into DRCS support later after current tasks on hand.
This patch is a quick fix to avoid firmware crash in the specific scenario.

David

