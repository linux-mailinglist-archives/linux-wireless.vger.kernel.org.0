Return-Path: <linux-wireless+bounces-12806-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AAB975EE0
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 04:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FDDFB238EA
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 02:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F5D2D7BF;
	Thu, 12 Sep 2024 02:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HwNc9EZb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2843A1DB;
	Thu, 12 Sep 2024 02:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726107735; cv=fail; b=uVf5M0MA312+C8CjohCOVoKbHu7iTw0op03iBMlgYPn4irF92Yh2Dw5dtgu9MlbA0a1iT0UV5fhiWx7F7MFnwgxAe2S+Sj4JPTEWeNRdF9IFjKewPiRGiFesyjPgZAq52DiK2lJhkOOTWU0aLnBgnMsfh5d5mQZrrBLBFGVBd+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726107735; c=relaxed/simple;
	bh=OK6RA3uQHUepiJDo/PzE+kXw9+QNTO/59jdJvp6uFYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QL8AxKnirJZaS20lBG9lTEiWUzp1mUO93dUB1q+xvsXMmDbGl7IiutIF+rpMHf7xw/Eig0N++dlDHnWImq5Z1c5Tz6ToZma0YO/2PJmOLJzt6isjaxfDw9+9r8fR6kwQNvjLztAAT5WGscQn0tdI2CP4yUmJjdv31vLvJc4mCaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HwNc9EZb; arc=fail smtp.client-ip=52.101.65.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qvf6i2zwXC0MY4l3GBPhEmDbBWk7UNcxrhn3aRKuSLy/E0Kxg3+QMEO1iC8P2WEbr8jjIRuS5/Xhh4P/oJUq8uzm3PuGpa8s35xcJcgBUDTUYEf9tdCbLgWwFfRWrJnM63GJaPt+ArvkvfoKlOFjqnQHBCNwx5U+7mFPpfjp3fcCPE36xtgGnYcbuusimnmHvkAFl3NxKCV6qrrmmw31GqUPWJkQR0PQY7jKk8BH3N9RzpSOUKe3mboXHJ3ORdoyf98jnRqs+zk/TaMSZbfvBhco7yMr0UpwjnDnjykvvAvlbr5Q7N4duo+NV2zHUB6h9GXonIqtNPu6ZcJuEi92IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scfXF1KxkSBlDR5I1urov2Bd1cPeEPoNtDVzHVyuM/g=;
 b=hLSG8HAgcQ+RUaVINygu9FaGArIqFXCuW6am71vokv6TNlA682I0HRr8lQTZBNxZD24vND0BNsxBhQ+tdnYeTO5p3gSsRKl8ZITEpMlV9lLoyzfKxL+oQPdGN2CrvTCj31bJdPq4VoOFzQ6j/qnxPT7/v6EMzG/ozH5eiD8xYzif9bhfwttikI66Hm0b7WTWhv31EzoSluTnkg8qp6lIQcpNqmfeYRNY/2M341PWWG1uJOz+vczFqJMqJhuxln/D/JhPP6rlwRmHvOA/zb9DQH3c4ZpQ+D8togdijzjyNZho3l2cxHYQ7o7KexWwRgfUYyOMEi3gb3Fnc+S0vKgXug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scfXF1KxkSBlDR5I1urov2Bd1cPeEPoNtDVzHVyuM/g=;
 b=HwNc9EZb3bLJxl1iL8fyQfQAvdkbBC1qI+cKkcDjvCbCboEO0jkY4tZnzkIANY8zd5db7MFvsMK/tzGXKYFSRumYxQP8lanWXllgrAC+TKZPVMmku8xDBk3Et5Q76YmU7l6UPvj8chFc+2pPy/JP1ttY/gCJ/1Qu9PwV2e8cPYX3IxQjQ9mHOzxBmBT3MEkXPIgJrZaWyDK6QzuIloE/uOKHuPOGC+8Y9zCttgqB/ufwxzLyP3urxYrC3y1eZx6gvz0lOtKYrQTDQRiKYHEcgTJvxairW3Rew0OI3jvXoSszmHwZS0ZfvcUutEcFqZsh7cPtXpdQv1dWGwVZtZQNXw==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB8389.eurprd04.prod.outlook.com (2603:10a6:102:1bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Thu, 12 Sep
 2024 02:22:09 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 02:22:09 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH] wifi: mwifiex: fix firmware crash for AP DFS
 mode
Thread-Topic: [EXT] Re: [PATCH] wifi: mwifiex: fix firmware crash for AP DFS
 mode
Thread-Index: AQHa+rOve95XNg2YF0iAcaLwH755k7JSZayAgAEVQZA=
Date: Thu, 12 Sep 2024 02:22:09 +0000
Message-ID:
 <PA4PR04MB96389DD6C8EC3903CEF01EFFD1642@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240830080719.826142-1-yu-hao.lin@nxp.com>
 <ZuFjtc70r6CGbzcW@gaggiata.pivistrello.it>
In-Reply-To: <ZuFjtc70r6CGbzcW@gaggiata.pivistrello.it>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PAXPR04MB8389:EE_
x-ms-office365-filtering-correlation-id: 3ff01347-dac7-45ed-8836-08dcd2d1b457
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wnIkwutTV0HDkqGIXPpDFSRrg6zq8ybW60eCawT7IshLJUA69/uee+iQtpJF?=
 =?us-ascii?Q?Hgp4+OdtqXCb9b7AEARFpv/eRae8RhHiHISGfpK7yk0eGDkwJfgDYexdH8Xp?=
 =?us-ascii?Q?1I/O0D64+WLNSpI0yPPCKLVTMaX+ENaGIWDRtb1BKuk4kXpbBeXZschy/6Jq?=
 =?us-ascii?Q?mYGftjSdH3ImyU5Yz591y77shFZ5CZ6rlcwBgtQMkBREed4h024empNS0guT?=
 =?us-ascii?Q?AZ2Qmr+yjOjTe3CUlnq+jaUUcXNtQt8VkNMI6pDmQfGUC0OS9yPRIGkOyf1G?=
 =?us-ascii?Q?U2d2jZmKuhki8mNtQtOOvzbXStlGhhmbrkPAhSuSFLnQtAROnR0pVcHU5D/M?=
 =?us-ascii?Q?F1BdFMrXobqkQeMBwWpBmj+0vl7EhFxOPDtRuA1VCYgJdrKpMCimo2YecOhp?=
 =?us-ascii?Q?egOdNpwgarFULSVn+ZJaZ9S2AeDvz7vKBSef5q64lboSvDYMo4FhVJWjW/aw?=
 =?us-ascii?Q?MnJYTn9AE2pQPZjonDwimfTZZ/d3qvj7DSZOaQsWqHPXLm80SLQYJD9GugN3?=
 =?us-ascii?Q?ExPw4kLZJhq41jSFcNndZ1zURuaWi4gd/vwVERCMkgcefQmOnIY+9ALJnXqK?=
 =?us-ascii?Q?hRNNsmZeuX707qsK8wDHtPTr6ImWs4vPsIZ4PKXm4IQ3vNYk+HNSG7R097lj?=
 =?us-ascii?Q?gQvB7WOS5ttU90gpCndRZfP/IavoCKkRadhvsKmTIKRpK3Eeyp8nm1pPQVI2?=
 =?us-ascii?Q?V3IxQ8M4Eyx7atC6UYekzGmYj2KPtue3TljOEm0hejdAnEdWxdkPxJ7iXfIp?=
 =?us-ascii?Q?zhD/XrO3yRM+/zbXkKXM1aZ+9w1M5911uTG7BOfTXvTTlrY3B7H8GDrYLKWl?=
 =?us-ascii?Q?7JBvJPw/9w7TwLn62MzuSnexfOBdVXGdScmKkOhzlJNdl7+x2q09RSHCiOd0?=
 =?us-ascii?Q?2P5dVyy9AEy6eTYoKPMqpWWrVb6H5VQiYfFQGormTK55A14NTKNo0DFhFwkB?=
 =?us-ascii?Q?yutKIAlfE+NWaW2SpJFQMEWXwnypqEYhO+xmDJmBJEWaq6c7XlaVs9ZdwWvD?=
 =?us-ascii?Q?rXw7Z2gZo5Ec7uPVwCaKnCfAmwZIQSM2TN2YNeHX6GqsAKFWSqHEw+tvYZyr?=
 =?us-ascii?Q?tTWSlmdIDg0Yq40/o5mSHSHS8VhS5hD4DTSaczo6TyqhubV+IgkMWjvIAq2+?=
 =?us-ascii?Q?GIqKmViT1xVHC+XUkCHBJoxDvOy9Ld1xt4/i6TOrUEsZsGBosF38x5oYXca0?=
 =?us-ascii?Q?s97YYIv0KQRbveIAeQRkei4XsE9VGRdiJFa79Z16saAdP5HEnx7xyMTovXs5?=
 =?us-ascii?Q?lp6d4L/PMhSnbpTrUWBSNxoPX++8a1tsBLZGrK6gpZyawxKH9TeKYDFX0dIV?=
 =?us-ascii?Q?gkoJVkTPy/nrNE3SyI4GqPF9NHGHzhvH6QMyL8re3+fioeyIUU0Lyo2rZXXm?=
 =?us-ascii?Q?c1NQ4yLp5qqHQoKE/FHyV8LAZNkpxoL7NdUEpEoDjGQArlvZXQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?y+lKPwqN8i6EqtK5OidtWJjPu/DOeEBsDabmQYkLZu1tAMCqz5RTSuwV+sai?=
 =?us-ascii?Q?3EzYZGG/JYREcslc4fqsC6h9gP9rOazrGhzBBDslfL92AAtYQBS6uBgx08A0?=
 =?us-ascii?Q?BTUwv3K8UNGCGfTK77UrwejXGxeri7VKv+qnHatnlh5j+A5eM/8qy79h96Rs?=
 =?us-ascii?Q?v/yhegHc1dJcIJXfooeBu0DErOnkg6zHJYKKFxU4Xo4KiRbNgYK4l1kT8hiE?=
 =?us-ascii?Q?2It/kFVi73BWCnAb+6IqCz/7ry/CCRUdwXiJ5XFovGJ/CQLneYeprwzgB0pR?=
 =?us-ascii?Q?Cd6yPKnB7ij/fVSZWsuzqQrkeGaAcqqd8q0L8Fsdr+wcv9PvxRgwVb5DY19G?=
 =?us-ascii?Q?aH/g74k/hNhg7OO5chiKVkWY/GRACmz/vpV3JZdi3CAbC+BspRToWoadXIpM?=
 =?us-ascii?Q?6pVdt+a4tSLBXNILjxMa/hbO1fJtDGi17Slcz8kyW2lu3Pe2z9HL5UdhMknh?=
 =?us-ascii?Q?6MLGz7h9+/v1cwhpHaRt5x3fnFLIkMRYkc3IdlBw8bzdh3bPRbvOlLWC0wsG?=
 =?us-ascii?Q?mkjdKP7QWMdy77MTdDq/TTak9I5VGZIHO/1Gk0JWcZnb57cZidun6hWKh7+m?=
 =?us-ascii?Q?eLqALTP6T011L7oa+fh9zA1A5afpxcgVLyu43vK6oNuoqwS9D27LOLsVwC6b?=
 =?us-ascii?Q?6EvxGtL+T0sWmt+URXT0CqAwgvpgNYAYsFIWKchB8teFxSGSGW/td4Br7ONi?=
 =?us-ascii?Q?1tQjn4nmoPRCO2n9VGFJh3k0bbgvQE8Bv4WuvJIzb2IvJ6K/zernHWyjgm7G?=
 =?us-ascii?Q?+iOgdu6Nzmy2bPn7b5/wfwuYfWzxHUW4m0ZoMpj6tSDBDmQgtOfHeIO1SH1K?=
 =?us-ascii?Q?t4MVxGcrXUcJHzqqxDQ3q8mM2BCi8JKdcX+TKPFL+TjC6jdZot7Ygm59jA0L?=
 =?us-ascii?Q?HcSTl50dJ+y0BMcfqr2Xi3y/8Je/sFpfa3L9sZm26bPgOmrpwdQRcI8xJZxQ?=
 =?us-ascii?Q?m/GSSnY/AU/argwqRfp5uTXdFl6va/lvbBrbLz25IsWPDl5SaSvv8FS54M31?=
 =?us-ascii?Q?ExmeuZwKjn7rn6eDG1zQA3oOE+43+Yz3Yxkbgmo4rEpfIu8T4fYVuCfixdmW?=
 =?us-ascii?Q?aT7dUrWiX+6PcsiWfw74PZ+ULc/mfnZzBe2UZ9rL+8B5PWDLRQX1xV/9WFVM?=
 =?us-ascii?Q?KbZ8/0iSetd9O/lWkGtOx9bFr4DXK3i3Bu25SVIaf8R7RKF6O0eqKfz7p6ca?=
 =?us-ascii?Q?1Hc1uG3+c+OIflIk6/u8oXG6PAxy4YBrmomSi/RMsSMJSqlfiLNBUPVdhhE3?=
 =?us-ascii?Q?CD6y1vt5fnn+y5Yi8MUBzIMT68b029P6EgxTELLUeuSCBOW4zT5bJz6xR/aa?=
 =?us-ascii?Q?lnRWbScTvfUC/TziItFLkQX4cRUXk/OJCEBghrQVCm69yp/eYQ6iC8sF5Ea4?=
 =?us-ascii?Q?KBRrmFrJQCsaIR1vrV573yhbUlV02Rktk/3FLSNZWVYrG1+Y9Fth6qwy9CrT?=
 =?us-ascii?Q?SyOXINJQ8MY8mPzOy3jbp8W+1TPforBUId9rLaU7PZoe5VRZI+mQaJ4v7ijH?=
 =?us-ascii?Q?TwLZbe1PNo20mqvXJF4tNbfBCF9cYfCFAV6NlLCDIyRKVgrNz40eV096eQXb?=
 =?us-ascii?Q?Y6V5Lz8bAQ4+14O+4t8WWNI5iNVwyKwMyDTYn4F0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff01347-dac7-45ed-8836-08dcd2d1b457
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 02:22:09.4797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pXAwccEar6ehQRP+xn97lj9ADX0SjbzkAaJgbqqCZmpRnYmBsGPuxscTIfJlkja/2GKbcZvYtB1TFLtJaeOW8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8389

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Wednesday, September 11, 2024 5:33 PM
> To: David Lin <yu-hao.lin@nxp.com>; l.stach@pengutronix.de
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH] wifi: mwifiex: fix firmware crash for AP DFS m=
ode
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> +Lucas (in case he missed this patch)
>=20
> On Fri, Aug 30, 2024 at 04:07:19PM +0800, David Lin wrote:
> > Firmware crashes when AP works on a DFS channel and radar detection
> occurs.
> > This patch fixes the issue, also add "fake_radar_detect" entry to
> > mimic radar detection for testing purpose.
>=20
> Do we want such kind of "fake" code in the driver?
>=20
> I do not agree that we mix an actual bug fix with additional testing code=
, and if
> I understand correctly the commit message this is what we are doing here.
>=20

This file can be used to test this patch on other chips without really rada=
r detection from HW.
We only test this patch with IW416.

> BTW, I think you should elaborate more in the commit message "This patch
> fixes the issue" to allow this patch to be reviewed.
>=20

O.K.

> With that said I had a quick look at the patch, I think that those points=
 need to
> be clarified before I can look more into it.
>=20

O.K.

> >
> > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > ---
> >  drivers/net/wireless/marvell/mwifiex/11h.c    | 56 +++++++++++++++----
> >  .../net/wireless/marvell/mwifiex/cfg80211.c   | 50 ++++++++---------
> >  .../net/wireless/marvell/mwifiex/cfg80211.h   |  4 +-
> >  .../net/wireless/marvell/mwifiex/debugfs.c    | 42 ++++++++++++++
> >  drivers/net/wireless/marvell/mwifiex/decl.h   |  1 +
> >  drivers/net/wireless/marvell/mwifiex/main.h   |  1 +
> >  6 files changed, 115 insertions(+), 39 deletions(-)
> >
> > diff --git a/drivers/net/wireless/marvell/mwifiex/11h.c
> > b/drivers/net/wireless/marvell/mwifiex/11h.c
> > index b90f922f1cdc..e7e7a154831f 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/11h.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/11h.c
> > @@ -7,7 +7,7 @@
> >
> >  #include "main.h"
> >  #include "fw.h"
> > -
> > +#include "cfg80211.h"
> >
> >  void mwifiex_init_11h_params(struct mwifiex_private *priv)  { @@
> > -220,8 +220,11 @@ int mwifiex_11h_handle_chanrpt_ready(struct
> mwifiex_private *priv,
> >
> cancel_delayed_work_sync(&priv->dfs_cac_work);
> >                               cfg80211_cac_event(priv->netdev,
> >
> &priv->dfs_chandef,
> > -
> NL80211_RADAR_DETECTED,
> > +
> > + NL80211_RADAR_CAC_ABORTED,
> >                                                  GFP_KERNEL);
> > +
> cfg80211_radar_event(priv->adapter->wiphy,
> > +
> &priv->dfs_chandef,
> > +                                                  GFP_KERNEL);
> >                       }
> >                       break;
> >               default:
> > @@ -244,9 +247,16 @@ int mwifiex_11h_handle_radar_detected(struct
> > mwifiex_private *priv,
> >
> >       mwifiex_dbg(priv->adapter, MSG,
> >                   "radar detected; indicating kernel\n");
> > -     if (mwifiex_stop_radar_detection(priv, &priv->dfs_chandef))
> > -             mwifiex_dbg(priv->adapter, ERROR,
> > -                         "Failed to stop CAC in FW\n");
> > +
> > +     if (priv->wdev.cac_started) {
> > +             if (mwifiex_stop_radar_detection(priv,
> &priv->dfs_chandef))
> > +                     mwifiex_dbg(priv->adapter, ERROR,
> > +                                 "Failed to stop CAC in FW\n");
> > +             cancel_delayed_work_sync(&priv->dfs_cac_work);
> > +             cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
> > +                                NL80211_RADAR_CAC_ABORTED,
> GFP_KERNEL);
> > +     }
> > +
> >       cfg80211_radar_event(priv->adapter->wiphy, &priv->dfs_chandef,
> >                            GFP_KERNEL);
> >       mwifiex_dbg(priv->adapter, MSG, "regdomain: %d\n", @@ -267,27
> > +277,53 @@ void mwifiex_dfs_chan_sw_work_queue(struct work_struct
> *work)
> >       struct mwifiex_uap_bss_param *bss_cfg;
> >       struct delayed_work *delayed_work =3D to_delayed_work(work);
> >       struct mwifiex_private *priv =3D
> > -                     container_of(delayed_work, struct
> mwifiex_private,
> > -                                  dfs_chan_sw_work);
> > +             container_of(delayed_work, struct mwifiex_private,
> > +                          dfs_chan_sw_work);
> > +     struct mwifiex_adapter *adapter =3D priv->adapter;
> > +
> > +     if (mwifiex_del_mgmt_ies(priv))
> > +             mwifiex_dbg(adapter, ERROR,
> > +                         "Failed to delete mgmt IEs!\n");
> >
> >       bss_cfg =3D &priv->bss_cfg;
> >       if (!bss_cfg->beacon_period) {
> > -             mwifiex_dbg(priv->adapter, ERROR,
> > +             mwifiex_dbg(adapter, ERROR,
> >                           "channel switch: AP already stopped\n");
> This change of adding `struct mwifiex_adapter *adapter` and refactoring t=
he
> related code is 100% fine, but mixing it here is just making the review w=
ork
> more complex.
>=20

O.K. I will remove it.

> > +
> > +     if (priv->uap_stop_tx) {
> > +             if (!netif_carrier_ok(priv->netdev))
>=20
> is this if needed? why? can't you just call netif_carrier_on() in every c=
ase?
>=20

If netif_carrier_ok(), there is no need to call netif_carrier_on().

> > +                     netif_carrier_on(priv->netdev);
>=20
>=20
> > +             mwifiex_wake_up_net_dev_queue(priv->netdev, adapter);
> > +             priv->uap_stop_tx =3D false;
> > +     }
> >  }
> > diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > index 722ead51e912..c5e8f12da0ae 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > @@ -1892,6 +1882,20 @@ static int
> mwifiex_cfg80211_change_beacon(struct wiphy *wiphy,
> >       return 0;
> >  }
> >
> > +/* cfg80211 operation handler for change_beacon.
> > + * Function retrieves and sets modified management IEs to FW.
> > + */
> > +static int mwifiex_cfg80211_change_beacon(struct wiphy *wiphy,
> > +                                       struct net_device *dev,
> > +                                       struct cfg80211_ap_update
> > +*params) {
> > +     int ret;
> > +
> > +     ret =3D mwifiex_cfg80211_change_beacon_data(wiphy, dev,
> > + &params->beacon);
> > +
> > +     return ret;
>=20
> just return mwifiex_cfg80211_change_beacon_data(wiphy, dev,
> &params->beacon);

O.K. Will change it in patch v2.

