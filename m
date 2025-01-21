Return-Path: <linux-wireless+bounces-17794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A98D1A182AF
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 18:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B6A167B92
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 17:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3D81F2C38;
	Tue, 21 Jan 2025 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OoToU4fJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013007.outbound.protection.outlook.com [52.101.67.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E5F5028C;
	Tue, 21 Jan 2025 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737479881; cv=fail; b=azvnKW/clfWrXE5OAMR2vwG0xknroEa3csXTeMGDxAC7FTUE0YzHfiIx2n94AOALNLqiX0A2Irze3FRPpMikSs9WDP6ZWa/VPW8cRe28Y02jkkz7lIy3p7waKsO3caiYEIwGOiapAjg2mlBkEXwPxkuk9aS9obhVd/8LVigBLgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737479881; c=relaxed/simple;
	bh=NafVsnCWF9a02SxiwpfMuhY/z6m2x+NJqWsPax9hDhQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z4sh9wexjXbi6Hnt2HQ509w1/ZOTFRkTet8n60FxJ4Kc9uNi0L+Mm5rl1nIPV/V+xUZCo1DJVIMKW0DSY4ebWJot8HynK+yjtp0eyidTuTpF8LzzszY+6lR/ITUNmVgO8zjxbbzpuWVSfVW2pQOVlXGa77STrHQKnFzKFOQaKEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OoToU4fJ; arc=fail smtp.client-ip=52.101.67.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1oFphXOOcdu4yJELY+4hc+rhUdJzVImXWj1rxCpxnM2OKiYd1EQ2yGC2ga+WObUi71lCVM5yu/L63jxnFjKEFw8h1NSQO4z2ly2ncm89F0cc2hwfJi/lY2EeaGNdJCwKwMc+RuSvcbDYrISE1z9zd0BSPixFGMsVW0TpMyqXqi9tmETal77CF8DRdwuKqGWhQRgukCnWvCZHffii2KhgRpR0I89DSid7Vn7+k3zBr99LYX8mqio9IGSeT5PZNcmnuM4PTvWr9FV882hb3zKeUAUVR1yhdDn/RQMBZwG/iDyjlMERHt2u5ZepzF+orx0IeiAde5/p/no4xaFTxrVZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQIsV4t0ZNH2j3Wg0pf+VbQ5aFjI3bM7ZkkfVo1hIjg=;
 b=SxaK0Q73bf13dTKn2RwLQcQd7VkIQbSyuCfDgwZhDMEZVnSdFE9RRzUNPZeYDQ79DZbj/XBfgCHvvboT6EeFYVSamdBUq0xZcHIIRawblsVnGmlFdnCYINb9uFzo+5t2v9/cNNJ8wGD7wUR0MgzcPVXYe4xnPFJsi/+1N0dlJ1x5FUup+M2Av1acfj73YzIPRG2sfSTRPMjYS2s8j4McLCHG84FPc/gzMhYR9V4nNy3CvUSzFqauBxgZpyqDdXsmGqe2lxKTw5VYfR72oMFBMl+nCjJ13LIK5Lv8tnQEc6c/x+n387Ah1+dF3Y3tumxkw6muOsqI01SJp0rRu5x98A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQIsV4t0ZNH2j3Wg0pf+VbQ5aFjI3bM7ZkkfVo1hIjg=;
 b=OoToU4fJd1g09b6WWhcN++Bz6fSvgHEnIOk9UGD5DVoXS6OeazDEFBNyIXMgjaJfM6tIGJhzZa0c+IU3bUKBB9BDCUAbLHh9Ilm9oIiLwqr0oonvH/oWMZBXSj2EVCO25FQpStMYFc36Sml0+kogMPKVW/glPSXyqjHPDztjha5+BPexYCnPSocywduKCVtiopaF4HdM2aUZlpdNQA4pS4zh/1RmDAUTZh2imojdwoVzUyxbybngvpUo7Xf5hHj8uoqMfUlGcXrlffLVRpgh/fr967k4pJx9d+DJX8qI9lNb+xDDV74nFaUeqe3UBUiKN64yITNceXBuqRj5smn5ig==
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by PA4PR04MB9247.eurprd04.prod.outlook.com (2603:10a6:102:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 17:17:56 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%4]) with mapi id 15.20.8356.017; Tue, 21 Jan 2025
 17:17:56 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH 2/2] wifi: mwifiex: Fix the wrong hardware
 setting for HT40.
Thread-Topic: [EXT] Re: [PATCH 2/2] wifi: mwifiex: Fix the wrong hardware
 setting for HT40.
Thread-Index: AQHbaw6DFeByIlp9d02YfmzX8/uQvLMfgjWAgAH1KPA=
Date: Tue, 21 Jan 2025 17:17:56 +0000
Message-ID:
 <PAWPR04MB99106570E36AD6E198B566F09CE62@PAWPR04MB9910.eurprd04.prod.outlook.com>
References: <20250120074011.720358-1-jeff.chen_1@nxp.com>
 <20250120074011.720358-2-jeff.chen_1@nxp.com>
 <Z44vj59nWIiswq7s@gaggiata.pivistrello.it>
In-Reply-To: <Z44vj59nWIiswq7s@gaggiata.pivistrello.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR04MB9910:EE_|PA4PR04MB9247:EE_
x-ms-office365-filtering-correlation-id: 4a30c62d-70c8-48dc-f0aa-08dd3a3f8c1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yzvh2s/jAptCvQZVSANqHxAIw5KXFXFvWHhO2UqGLfEyDNPRiJcaPeMDxjtr?=
 =?us-ascii?Q?oCX/djU9g+JQJsVHx0HKkyDQ8Qfg+TUO6s3LpKUkhla1riebCOyM8j5YoK/M?=
 =?us-ascii?Q?Y2vSzTNLn7ZAel2y6eCP1jhbA02Pwlmvp5a4PRr8+l56BWqzHWn/ne/XDVer?=
 =?us-ascii?Q?Pxsy8JXeHbMd69m2gIdkmRhUZU2p/+3y57jTvHRm89v0u3EBYQZlvM5wmm0l?=
 =?us-ascii?Q?qZERHXdl7rMABsVwaxA/qYpDmznekN+X9bAhJyT4YVBm/8E2GP4cwkukMdeW?=
 =?us-ascii?Q?wvmx5UPuLEzV/JNg9y1QwOXbGpstFX3EnksvKFIeSI9huyFam7635oVr6cmZ?=
 =?us-ascii?Q?zGuR0trQEizEIINtgjaywuqVhBsyU63VwlUjgze8Aq3UacUnzBuDX/S5ZDB3?=
 =?us-ascii?Q?euVCcbsLszDCvZcClbzeMvTUBMUReyPnrv+8N/CCUXVq/ewXuSXwJd47D5W9?=
 =?us-ascii?Q?4z5vKCu2/mp/I3XrkCr4E7mIPbwrQbDnUVhJG8rESTJjJJN9NImKsXVpo8FU?=
 =?us-ascii?Q?dspOmpDDep1mQ8jReJolZeVNbbbs8tcJU2pV3w5DTu4SPxeXyB0jn117v/0Z?=
 =?us-ascii?Q?J8VCdPusK+uCq8xZ8Q6Tbagfxgmsc73/Wdl7L1MJOQ5WkenhN9I+Heh3X56Y?=
 =?us-ascii?Q?fCW5rkcuV+iEdmN1YW7amKM3NAhiO8gz7Zj1pfGDT53Saz2mI8dUiTDLu30x?=
 =?us-ascii?Q?Q67sM3hfMpoN251X3hTS1N40LqtNKtpgtPyXXPnMD7bSxDOx8pw3ThHld0/B?=
 =?us-ascii?Q?rd46jyL73CPDFkCarlSazjoVGEbLSv7Oq9Fmf4qETvNOQFp9mwOXC9tiirO6?=
 =?us-ascii?Q?VfMunbvXqZB/0yMNfBvkItjMFzvz+RZ0SBDRTrIByizS+Ub7CUsRuNIcUqLd?=
 =?us-ascii?Q?KnL1DnkZUVPRToKC4BO+caI0KUvFWH7rZXem924SEAZ8Va7rXfiSJR1PRw2N?=
 =?us-ascii?Q?2gcTy336wcb4sZd4a//zidcrCRBDKod4DHa5tWA31h8UtAy5LkjlKsFE2rap?=
 =?us-ascii?Q?m5S0Hv5jYuivdJ0ce2Sn33GKdtWTWCr7tOtsXU+rHA0U0XMOU4q+mAUrdlb5?=
 =?us-ascii?Q?My3ZhiHjUlDUsw125/jn9oZiOcZD7An4/eCYhLhH/tFC8Bck6rXCWBvrRC/7?=
 =?us-ascii?Q?oIPdyY4mke+oNP4UZJjoHUzJuyWI7OYRzVJsJc4nKkng81EyTLpmF+66jDGD?=
 =?us-ascii?Q?POwLB0qyUxFaflQRnu/zn4P7X3mR28iy1E7VtZ4vgRvFEEmwAYfhfWfpH9rQ?=
 =?us-ascii?Q?/+3GeovdNAxfzgwC9cidvnpkKS8oU+q8mpK9jAPQ0lBHyOWbP8IHRwVJVEVv?=
 =?us-ascii?Q?4lKQC41RxSu6Afpuxg/7sPTq/kDVAZxqEzVkggk6nMxAXoAtTEWPkRQcNx0M?=
 =?us-ascii?Q?ZFf/zUpYWkv25dYR7wLEyZMwGRCfjk5KOxU/ln/mNTh7PA2fhF3HYVBNbgrY?=
 =?us-ascii?Q?lvpSk90q/3Bv1r9sCfllq9MklzH9l/ea?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4ZYqIIcjQ75xOgEwpVOEs4EUQCdTZ5KZ1A06lqKGb4Gmlawtgw6h+0Sy4eit?=
 =?us-ascii?Q?3HZT3z4jnfmnxTvqu5N3Q6jIE5Y7ETN0JVrbl719zOcqg3woUs+xIb6tdyVC?=
 =?us-ascii?Q?GHo+eMyLNGOTgNJm8Y1FWHFh9eTRhrM/uGNPoZLeSSpuW0bvA9eNQnh9vnsZ?=
 =?us-ascii?Q?GvT01K7Wyo1xOOs+Uf2/yv/p97xKX/b0KO5KyvFXU28bhbOFNNBoLP/LAR3P?=
 =?us-ascii?Q?lQ0NPO123+6utV3FN6iM1TQ6mmAHhaCmrUF6+U5weiTxsMGWa3n7WVgLwB6n?=
 =?us-ascii?Q?/DPDUa/ive5X/P+k9MkP1+sGXDDWg6yBpicZZDr7b44Lsb9bnXme7gy1o7rO?=
 =?us-ascii?Q?XsZ0ID7H8WhPAM2gnVX63MvMofU6jHnHWCVGkO42lmhJ7oE2crTihVtB26pq?=
 =?us-ascii?Q?Y+HUes6KtgiLMYlZNXk/UqPTpd4SKdEsnNfT35L+Jd30y62R3X3W3TYHgNHd?=
 =?us-ascii?Q?f9IZXk/tsRdc6AJWIp43+T5KYGfimiqZcMKkwCR/wJTu4UNuOnjekOCcWrV7?=
 =?us-ascii?Q?B6Jwg++d73eiZ40GW+jOzOLZqyM2UUBeNEkZj7DDP/9oxXo3sawhL2S2mVce?=
 =?us-ascii?Q?wU7ul82ts18Xl2uK4waQfRHRL2xMP3H9Fv9jXW+2HnmzD0U0d6H+RiIHYzX+?=
 =?us-ascii?Q?i/EKknXD5/KcQkxcJ8n5Ss96p4RBWE2hSN1oESJjlYiYSotr7ToFZS/m02dj?=
 =?us-ascii?Q?YZXUQADw13C7JZsTfps+gWOjPlO+B9oFJjqAZezWXRegLpcVXnB9kwmZL/6h?=
 =?us-ascii?Q?rCqjCmeaLQD7BGR9BJYDxWJ+3bge7Kj8OJQAK69H9cn7NV9Zhdl/TwEOtWjL?=
 =?us-ascii?Q?N/WvkfAkXghNUfzVFcMHDD26fKAmnjmmXDIjppm9dxXG63uZIVbaEpBu6XYA?=
 =?us-ascii?Q?/PAwShHtB62Iy5Yf9DIorP9EdF80R56pTzA/QEaU8BB+W8HnSCqXDHwH7yY9?=
 =?us-ascii?Q?6/2edzBkv8ETGisgY6L/enYQn5a9Wf6repI4zJ1heQGi8WQtc3gHz7PgSpP9?=
 =?us-ascii?Q?SG47hnYFOyOOakVNgyCGgWZGgSGBTmA6O/hmglj5x0DEEk4OsKdve38Yy+bI?=
 =?us-ascii?Q?X1F+cM6V0G3Nw2nYjC4RFkeVVvI/jci1VmXNaF4ttOux0VgwuIw6EoHA9FtX?=
 =?us-ascii?Q?VdnWZSWkNJJRji+b5rmlgqPgrv5D7g4bp3LYt1GcQcuCRNJ0M3tIw1Hn3FqL?=
 =?us-ascii?Q?HBQfitl+2FuY1M5rcYfEjSDOSvlzl76pUrszlurGIigQ+iEkSS7FMrsgsoLu?=
 =?us-ascii?Q?q6AlOm260p9es9qPT+FBsPHkjTftS+KilXijoZT0A/QywAJCpxehN8XuRaF9?=
 =?us-ascii?Q?WV9QZI2JGPWn4sNFW5FAd5J1btjskXeoUKrR9bfc6nZP0v9AMlugpiy+tfEi?=
 =?us-ascii?Q?ii8pbN7+FXaXt2EYGT9Dv96jR8PXF9Zb5nlnUzhP5o1gYV2Pqh8y4Ha9MeYK?=
 =?us-ascii?Q?wnDWMLm27arzn7ViKetGT26CDoMIS6bepOsAjURCXka9InVNuSMGAWqM0Rnc?=
 =?us-ascii?Q?ADNc2SnkLLhTgOW/ciq2lUOTleGqb0i9t/uH0kUEeCCm9o8ECOhzRd+rNA+8?=
 =?us-ascii?Q?s/clLs6O7mqpT7la8tPLRy7hYqZ+k1fHG6t06zNO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a30c62d-70c8-48dc-f0aa-08dd3a3f8c1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 17:17:56.4423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /4dKDUgSpfuCbLDgl4Xik2CuhrZXMK+24ckQnzaab9gTsodWmraOJ+bA4YVjeyHjU22NIurapYmczMHPzHmR/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9247

> -----Original Message-----
> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Monday, January 20, 2025 7:12 PM
> To: Jeff Chen <jeff.chen_1@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> Hsieh <tsung-hsien.hsieh@nxp.com>; s.hauer@pengutronix.de
> Subject: [EXT] Re: [PATCH 2/2] wifi: mwifiex: Fix the wrong hardware sett=
ing for
> HT40.
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Hello Jeff,
> thanks for the patch.
>=20
> On Mon, Jan 20, 2025 at 03:40:11PM +0800, Jeff Chen wrote:
> > Add the missing bandwidth configuration for HT40.
>=20
> Can you expand this a little bit?
>=20
> - Is this a regression?
> - What is the impact of this missing configuration? It's not working at a=
ll?
>   It's working in some unexpected way (please explain)?
> - Should this backported to stable (probably given the answer before it s=
hould
>   be obvious the answer to this question)?
>=20
> Anything else worth mentioning?
>=20
> >
> > Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
> > ---
> >  drivers/net/wireless/marvell/mwifiex/11n.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/net/wireless/marvell/mwifiex/11n.c
> > b/drivers/net/wireless/marvell/mwifiex/11n.c
> > index 66f0f5377ac1..4ae0b4aaa09a 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/11n.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/11n.c
> > @@ -308,7 +308,7 @@ mwifiex_cmd_append_11n_tlv(struct
> mwifiex_private *priv,
> >       int ret_len =3D 0;
> >       struct ieee80211_supported_band *sband;
> >       struct ieee_types_header *hdr;
> > -     u8 radio_type;
> > +     u8 radio_type, secch_offset;
> >
> >       if (!buffer || !*buffer)
> >               return ret_len;
> > @@ -401,13 +401,15 @@ mwifiex_cmd_append_11n_tlv(struct
> mwifiex_private *priv,
> >               chan_list->chan_scan_param[0].radio_type =3D
> >                       mwifiex_band_to_radio_type((u8)
> > bss_desc->bss_band);
> >
> > -             if (sband->ht_cap.cap &
> IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
> > -                 bss_desc->bcn_ht_oper->ht_param &
> > -                 IEEE80211_HT_PARAM_CHAN_WIDTH_ANY)
> > -
> SET_SECONDARYCHAN(chan_list->chan_scan_param[0].
> > -                                       radio_type,
> > -
> (bss_desc->bcn_ht_oper->ht_param &
> > -
> IEEE80211_HT_PARAM_CHA_SEC_OFFSET));
> > +             if (sband->ht_cap.cap &
> IEEE80211_HT_CAP_SUP_WIDTH_20_40) {
> > +                     if (bss_desc->bcn_ht_oper->ht_param &
> IEEE80211_HT_PARAM_CHAN_WIDTH_ANY) {
> > +
> chan_list->chan_scan_param[0].radio_type
> > + |=3D (CHAN_BW_40MHZ << 2);
>=20
> setting `radio_type |=3D (CHAN_BW_40MHZ << 2)` seems the only real change=
 on
> this patch, correct? Anything else is cosmetic, correct?
>=20
> would doing just this change be equivalent, right?
>=20
>         SET_SECONDARYCHAN(chan_list->chan_scan_param[0].
>                           radio_type | (CHAN_BW_40MHZ << 2),
>                           (bss_desc->bcn_ht_oper->ht_param &
>                           IEEE80211_HT_PARAM_CHA_SEC_OFFSET));
>=20
>=20
> Francesco

Hi Francesco,
Thank you for the review and advice.
I will revise the patch and provide more detailed descriptions.

Jeff

