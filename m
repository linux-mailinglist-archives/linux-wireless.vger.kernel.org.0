Return-Path: <linux-wireless+bounces-12822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D374B9776AE
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 04:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5289C1F25020
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 02:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70961D0DE1;
	Fri, 13 Sep 2024 02:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k4ZmKtXO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013025.outbound.protection.outlook.com [52.101.67.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9590F1D0977;
	Fri, 13 Sep 2024 02:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726192923; cv=fail; b=i6fyqnqruqoitI/WaGvuc11+H9C48PbFr8wnd51rYdEzWcb2LBa6tTnEAQ5E+2kFUG9+ze295d77Uv4yIWX3ub/PklGfOwbQe7rrCIJJpdOAKP9G33OTca2Ush0lBDmM/NPNsfB1ZA1D0QJB9D/GD+D+7uoDOAd6NAyy1mdbq3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726192923; c=relaxed/simple;
	bh=UJP3tH8Z3eNEV3MwQJUasn0pY4cNucfVr7rDPTHC3yY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OQ4Z49VNC9/lFwhflI8mND239ooIg0gRrbDTfz+n+Ey5ByVnP5dkDqf+sjGGEI2wBOhNwmU2ZrUrvdTTB2V+hdtf4ExJMVyQxAPtbWNzpFEB7XeaAOwkEMHaamyvxknhMHyN7jk1IQB59gDE6caytQHhaA7DHs2UgEgosyeiBiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k4ZmKtXO; arc=fail smtp.client-ip=52.101.67.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoGoeLgs38RDonQdyKdtkPpgqVxJDCV1sX8JBvIsBpzuNpU7uaAx0hofW6WvaFMOu7c+sHSG3vyIZ1NQ9IFeNlZLd914/iFmZTShYgyeBh65+pKh3k5/tePyyB6usgNimqqVVqg5JmuyM7inGF4aqx6A2ZL0nKfRIbWr+/b7wO6B930OvC3eQQ6iXCIZ0FiNispS4ah0nUzlqUropVn4S3FmdvmiNu9NjMz6yLwfIvJiMVhoxxPGgeZHi0Yin03lFb0WqJMjg1OatG678rReKMLAFDEC6TfHj5hpMkGLtHYe2kM0UgEKpVwJAdwR6m/aDQqfhBSR6Wqca5582EnYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrtBn5k5u/c6KOYEPqbX1welO0ueOik2bNEOtbvmnMw=;
 b=x1vGiR6id31olzcCr5VwU/hyYsyDA4AKPYa0L9HqKupULZeJuOis1/bEsg+5McI/E8HTBXeEueDXHe5KoKW3RthId581XXDhVEDtnO5TWuBYoSDNE5prjbWGmrSgroM/pRzwImElapmh2HpG7jaSqtE4E9p2yWJGV6qFqvLwLj9h6xQRxCnM4CeBS3JjD4AMeljX96SrPMN+3xw7ONMUNxWjU/yQpNlzJLh0nmWmtE+XgaGIYLEBXMeao9bFY9ntIBV+6/u124xSt3URBBABOy5xOLUXNNo+Cvv1a1cEGQlVli82x0KRmWaNQChVfHngx7ECmhFEHkbtUSNFVp8XwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrtBn5k5u/c6KOYEPqbX1welO0ueOik2bNEOtbvmnMw=;
 b=k4ZmKtXOrH2LGTyE5x2ME9FNMjp7qStUB7vQ3KwklMKWpnyGvf1Ldkw9UbEWD5xxE97VwnuAAUQmduT5KOuO5qX2K6SIUC9enlToKxwYajTLOiIzzkRIuaOIAQO51EKJchVk9xpBfjBIpk5b97eRoprKJoQaNciwa1PTXh5cqkFoNkVRrC/24a2iRov+5FOXOvx9VKhUhlpp9YEjTtifeml5TEVcFHRV8t1Gbl2s7rapi+ivYn9FcSMTnzDTU9SQQYnu7wrDWvtm0ByfdBzMTY3/K+wxfBmKtHjCGNm1zj2pYjakhkTRBVm4gzb2LrYYSGTRva3IUK7KXZbkq8+3ag==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DBBPR04MB7738.eurprd04.prod.outlook.com (2603:10a6:10:1ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 02:01:58 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 02:01:57 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH] wifi: mwifiex: fix firmware crash for AP DFS
 mode
Thread-Topic: [EXT] Re: [PATCH] wifi: mwifiex: fix firmware crash for AP DFS
 mode
Thread-Index: AQHa+rOve95XNg2YF0iAcaLwH755k7JSZayAgAEVQZCAAGIAAIABK0xg
Date: Fri, 13 Sep 2024 02:01:57 +0000
Message-ID:
 <PA4PR04MB96384F7498DABD4CF6E8BED1D1652@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240830080719.826142-1-yu-hao.lin@nxp.com>
 <ZuFjtc70r6CGbzcW@gaggiata.pivistrello.it>
 <PA4PR04MB96389DD6C8EC3903CEF01EFFD1642@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZuKefqVotHmOywvF@gaggiata.pivistrello.it>
In-Reply-To: <ZuKefqVotHmOywvF@gaggiata.pivistrello.it>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DBBPR04MB7738:EE_
x-ms-office365-filtering-correlation-id: 8f27cb82-9175-4fd3-d7d2-08dcd3980c58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tUSfNdR+4F9ohpy0LB//TxW6cj8G3tTK8g2Zh7ZaXjQt6kunFjM9CManwMyL?=
 =?us-ascii?Q?50vefTiLnPwZ41rGdOHLrrDFr9lVigFb1eRJB9o4anuc0rtAFsBl0QueJWus?=
 =?us-ascii?Q?m9fyTECL6ZPeAF93rKdJV/hkqP4hIe46gCuvM8J+UqgZPVE3icbveNreCPPM?=
 =?us-ascii?Q?1jwBErwzNguoCCDCugrimY72tzac+owuL9zaKw08pL6eepSRsgqMrWETbACC?=
 =?us-ascii?Q?LzY3/p7jGK63wvoBg1IfSkvtmK9WdplbB0nnqEeOqFI7V9aE8jS3nTNWCmxm?=
 =?us-ascii?Q?z+c9RWWWymTl/SY9kt+wwF5X04Re6YRxd8M2nOA5u1PPvSMu45LmyXLZBxPL?=
 =?us-ascii?Q?7+mJGMgdJHOZg8UicqljAo24q5X8MdqlqdAGTJcNPxJ1iMDs8ONb/s3j/zap?=
 =?us-ascii?Q?2a89AOYUv6BTx0/IeFFu1roAKgZlenUIrvW7RvLO3R4cjGMNFbPp++hLyLfQ?=
 =?us-ascii?Q?55v14ieSgMYd6Kz88uzS63ztIteLNljP+uJM8NgTMfDCQaELEsH90Hcq4nY0?=
 =?us-ascii?Q?ALzMrhw0JpXLll0OyoJUIzCMh+20XoDuaVv/TDl7cZCPH9BLv6v2FpOOV+/b?=
 =?us-ascii?Q?gBVpvYvJpos5NkT4hog0g2+0huTaSQStJCeCyXSgVABKZBj/hl9eXx/TD2XP?=
 =?us-ascii?Q?Tx1ZCRlv7xtDRczgcIHWWhQ0wk0mPmchuie4FfRR4kpDQW8tQXAQkja6TjcR?=
 =?us-ascii?Q?GMrpd7J76fcaZzuQZScpvEtq3qtwMMo3KrBqlfFo+D+TIOMfmg3ZoXjGN7A3?=
 =?us-ascii?Q?vkJp2VPlIlypD+5PhFTErk5vtG5IpOMrDtzjjxeYwqUKL/h0pL4J1LiWa+YJ?=
 =?us-ascii?Q?xzKQJL0+XHa9Si6jBaEZh0KTlGpe5s3jWXWgPezaxsr5jlM/fqedGpRFDPnM?=
 =?us-ascii?Q?2+lQCyhCj5NjSeBvDkQJbRT0gPJP6rIws8yUOC/4Q+9LBBm0JL0M58SJPJCf?=
 =?us-ascii?Q?mo6/kk0asXYznYaVJ7ItCTLdZ8S1iGsajc/uYp6hQS4XgZpSSs8CataMwXzn?=
 =?us-ascii?Q?0Z0qwMH4p0JCkLuj8xMf3hWm84rT/Vi4EZh7a5ca4IHoLyldhpTAg0S8ZKSi?=
 =?us-ascii?Q?LeIkGaa02Z/ulIvMX9ViNO7l9whUDrFgDswlsf+2lDrxykCJ688E2nSSQUPd?=
 =?us-ascii?Q?Yfn4IWH2k3kdfWCukQIwtchM2bdeVWl3JZtiZeuAMS6gnOBWLhcMEyAHrz/O?=
 =?us-ascii?Q?1aAD1bVhmQbP94/cs4zp+QjS0FcNO/k2CkePqJE/x6/qjYdnJ29RwRGjRECM?=
 =?us-ascii?Q?2nYEzUK0vLeN4PCesMeIt4ABn7lkg0+N1LPyOr3u/5YvCECfgGeSPcc+RMVO?=
 =?us-ascii?Q?zneCQKFSNv5ZZ91/0HnuwsqOUYeyn5cZruCNey/Hc9hBx6p0Oz2HzkGfeKHT?=
 =?us-ascii?Q?ncuTy2nBSgfVIQmEmba8U4qLxEJ8BvncMHfucrQLJRohfiKFqA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MxD4WWeJx8NNc96iomgKjnRdZswKycekE5rPTWXB7goDpR1jPIHaZqCkIJwB?=
 =?us-ascii?Q?GRQmnuO10Q2QCjtK4oZywFi6ylDq9iawnks6nOGEvQGt2/2WqTzcFk+u7uNx?=
 =?us-ascii?Q?yz6+UpypUOhkj1jvTqlh2NTELCSUBwBW11Hs1olb0dfzeeQW+80J2JOjvxm/?=
 =?us-ascii?Q?E2eCDWc891wRnIYG6BX7nEbizg95eNI+Doq0Idf9wPYu0+4A32b3Vm93K/L5?=
 =?us-ascii?Q?rWVhUQFzyQxAXmiay0I14phzp3wr1/bhLd9JFDYzVTzW4kVT4EFpyQwjcSCs?=
 =?us-ascii?Q?hDCl+yP5qtOTb41kawZomTniFSEvN4l44N8JWmjtIrh/M2r0Jyo74y+vClH5?=
 =?us-ascii?Q?VXMF54RqF1C4vBunntKw0huDKIemzwnsTE6Vswm2oa9P1iPJK1GgOl3oyPcm?=
 =?us-ascii?Q?QDC1Agbfjh9k7fLL8kdUsh4GIYopaJRaSxevGSuBQy6kdHLU6Tmc+zovHHPV?=
 =?us-ascii?Q?7T3YC3XwIHwM7W2Ep83p8T3Nt+DWgKWwbAYrCI1Gv1cTUIpRPrKFzY3prY0N?=
 =?us-ascii?Q?amRIEbX/OqtM40tY5e1sdXoyJglQVvdsFHaYfh1T6yqTt8oXOjkE/GlHueWJ?=
 =?us-ascii?Q?pIc6jIGpH80QfI/830n6vsEBI4u0ro02IsJrTNoG4q/h+qMecvoWgE+eB+Yy?=
 =?us-ascii?Q?9E3KmgckU3pK9S4Qb7euTT26ibvuF8wTmcixb+mAa0gpa1zik6vnootutgts?=
 =?us-ascii?Q?7PfYmIt33yT7NpkeXBKFVri2ogRxTUuhN5Pzdrlt9SSULaEQxhqp0DubTEMw?=
 =?us-ascii?Q?Z2ar5Tlt7GkprAGc+xdw8XMrOpzsMMb8nmddm0Vb/VSXtMC+6UFD3Y4g15f7?=
 =?us-ascii?Q?QPkPukED9uKOEAMU5pQTvtFH5L24LXameIXzhxHHLjXXUZbAurySDKGRnqyw?=
 =?us-ascii?Q?OwlFY206Yv8Co74Mj9BuzrDprJKmdUvJIVXhG8OoGUYBNvGXqrMCZ5n6K6cE?=
 =?us-ascii?Q?qAImAKgc/Y9baQz0vGQiwG8n+Tp9yxG3dbW8op8+ufB4nYqR6v4R+2qZhFMr?=
 =?us-ascii?Q?nDiG2DpkxEVUW62wQFserK4sNkh1ubN2V+U+5HWM+w7MpZIxtXkl+nb/jD2t?=
 =?us-ascii?Q?9y4afoWr7qpZu64AbVeivjEv41OaBTeXwyC5GdqTtYic8e/vUcEqOyZu19KT?=
 =?us-ascii?Q?gLo9mYYGsfNvQAYOQOOZ6TK36ol3am/F7VkQBV1Pg23/GEbpKusA5fvIN85K?=
 =?us-ascii?Q?45Pm1pFw+o/OIE6h16AKIE+DMFeDxxyNYl7oWHrEOqBZQP1X5J4WK4hr+ztw?=
 =?us-ascii?Q?Gzj6yXLEu6J/2plCu0qpBkbuxgP8C41ZSmPbNYpoSaEgfAwAIQ7lQ6apmdzu?=
 =?us-ascii?Q?kFNjB4WvsMSaOF9pRBt9nmywI73tqZKYwmm+MXROKo6OdKUNWIxpTCI4GlK5?=
 =?us-ascii?Q?b/sebXj/uxECQB/y8iJxKjoC4BSoOEJDz2ySx5Y8uTcETclLdPUGDr7KfIOJ?=
 =?us-ascii?Q?KTQCtHoGEahP/8+5daZrgJmPtTt8z0uLVWol4PzgETs2KqMQ6kEiLKwuwpbt?=
 =?us-ascii?Q?nt/FhDJzoyKHmtSlWgWO9dDgzScnvGi8XLAbbJ92QEfJlc/ci4pui+Tp9xzn?=
 =?us-ascii?Q?9WL7Azjx4Edt6ZNEqzry98G5ZhaKP8POrEdu2lqI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f27cb82-9175-4fd3-d7d2-08dcd3980c58
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 02:01:57.5058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9eA3DjRME69Mv4mg4Tqih3aeuz/t230KbtB5M9X2rx32SEBp++QAf3xLD6ksUMZ0QIjpEXVVvs12PkfKEStP0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7738

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Thursday, September 12, 2024 3:56 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: Francesco Dolcini <francesco@dolcini.it>; l.stach@pengutronix.de;
> linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>
> Subject: Re: [EXT] Re: [PATCH] wifi: mwifiex: fix firmware crash for AP D=
FS
> mode
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Thu, Sep 12, 2024 at 02:22:09AM +0000, David Lin wrote:
> > > From: Francesco Dolcini <francesco@dolcini.it>
> > > Sent: Wednesday, September 11, 2024 5:33 PM
> > > To: David Lin <yu-hao.lin@nxp.com>; l.stach@pengutronix.de
> > > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it;
> > > Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> > > Subject: [EXT] Re: [PATCH] wifi: mwifiex: fix firmware crash for AP
> > > DFS mode
> > >
> > > Caution: This is an external email. Please take care when clicking
> > > links or opening attachments. When in doubt, report the message
> > > using the 'Report this email' button
> > >
> > >
> > > +Lucas (in case he missed this patch)
> > >
> > > On Fri, Aug 30, 2024 at 04:07:19PM +0800, David Lin wrote:
> > > > Firmware crashes when AP works on a DFS channel and radar
> > > > detection
> > > occurs.
> > > > This patch fixes the issue, also add "fake_radar_detect" entry to
> > > > mimic radar detection for testing purpose.
> > >
> > > Do we want such kind of "fake" code in the driver?
> > >
> > > I do not agree that we mix an actual bug fix with additional testing
> > > code, and if I understand correctly the commit message this is what w=
e are
> doing here.
> > >
> >
> > This file can be used to test this patch on other chips without really
> > radar detection from HW.
>=20
> please move the fake test code to a separate patch so that it can be disc=
ussed
> separetely from the actual fix
>=20

O.K. I will remove this debugfs file for patch v2.

> > > > --- a/drivers/net/wireless/marvell/mwifiex/11h.c
> > > > +++ b/drivers/net/wireless/marvell/mwifiex/11h.c
>=20
> ...
>=20
> > > > +
> > > > +     if (priv->uap_stop_tx) {
> > > > +             if (!netif_carrier_ok(priv->netdev))
> > >
> > > is this if needed? why? can't you just call netif_carrier_on() in eve=
ry case?
> >
> > If netif_carrier_ok(), there is no need to call netif_carrier_on().
>=20
> yes, ok. this I know. But it seems not needed, and one line less of code =
is better
> than having one additional useless line of code.
>=20
> My question is, is it required to have it? for what reason? My undestandi=
ng is
> that you should just remove it, but maybe I am missing something.
>=20

I check netif_carrier_on(), it will check "test_and_clear_bit(__LINK_STATE_=
NOCARRIER, &dev->state)"
before turning on the carrier. I will remove this check for patch v2 .

I will also remove all the checks for nxpwifi, but for original code of mwi=
fiex, there should be no plan to remove this
kind of check.

David


