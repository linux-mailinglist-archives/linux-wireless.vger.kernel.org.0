Return-Path: <linux-wireless+bounces-7972-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAEE8CCAAC
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 04:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3374F28247F
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 02:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE7B8475;
	Thu, 23 May 2024 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RyHmPiIp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2058.outbound.protection.outlook.com [40.107.105.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16036567F;
	Thu, 23 May 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716430831; cv=fail; b=Hsxx9dCpizRMMMBfM1t+GJHKjVNKPeZcQKruwBnmMSq9nOlk2hburuJ4FUCeTUqKH/eVDw4tOQQUUl0Rg1/1T569bgBgoXbo8nIJT3fsktzWw99AlVV+xva2CX2w4h7aQQ4NTu8rVBRC+SrjmmnSklEtbmZOmQj+SpisAMpwLpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716430831; c=relaxed/simple;
	bh=VvaXW52K/fR8fLDtbZl0JEeWiJiV9GCpJ9+H+4IYIbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fb5qI8toL7GWp/aX8E4NvEWa0NmgdBQQttw+DO0bfAl6RTsSfFh1OoAs+vEQVsABjxDjK9hULM0jYFtqQdfFJAW1+doBVvc+n4S1oT+bIxOPOai2SwnIMx+lF9ahMKdMeYpyAtl4cZKZ1QY9l0sytFZN3oyvR7kM7tEkDiBuc7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RyHmPiIp; arc=fail smtp.client-ip=40.107.105.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tih2zOphrDNURZRIfrM7XDnwGe9KFsn6XdRpqUUGNeXR4BNecHSR5oBjP6aI+RRYnPOX8qyunN+omVgJ/TH41J3sZFGSHwv4vFhkWw+qk3IDN4aD+wl0UAst7lMxjKU9DL7Iabb45tQX+QGAvJ2LkrF9BfbxOFAxitaZMKiNuHga67tq3jQwemhxVfsvvcSmenm4JwMNvlPj6Jfw5UjAU+Dm973IaYrAnY0TLidJKZ8m+9JInZtTwPeOWdnKM1cSQ3gKihg3VtUhySYPuX5ZPXFbz0y/irv2PSH0UUprPZGpNxAvXqrMtbEpOQUA4z9EMpViorS2FxinvipL39yf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tN+6PgowAgtHBTCHjD5eWDOK1f4DAKdTAOG+BtrO9y8=;
 b=U9x7DHOO0u/U8UT4s7LL7gHeffoZvSX4YSfoEnJOweiEQw0C7XXcnTJSgN9iR1gXGDuT8cdwkAa1btqhfhVcxw+ofvT7qsSPK6X1g/f2e2CCRwVzNVcmH5NBecJsTSF+qh4WSzVQJdu8RTuQ/ji0z02+5bQ7VHSq4SmuKxZQaxta0y/T0T7ZQaArbO1CzzYAgf1GYrlRmu3A6lFlF0RHSpup8BY7kUn0B7b4dJG7krCe19XZ6fOGI91dxkgscBH4Mo/2YNPt2yzRcWWDLUWTf5SWCz9P5FJ0gzndOas9bpypm5NN8+KtZhrDTzP48EeZKHN09nVf/a/N2CS7/moxSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tN+6PgowAgtHBTCHjD5eWDOK1f4DAKdTAOG+BtrO9y8=;
 b=RyHmPiIpKq8AS4bO9qenI8guHJXSQjLYY7G0GAOFuTx6tGqhhOcY9wujw8OWwi3gKNGVu1SbBrzX5vqjrHi8fwWYfTsmyha9F0tKI/0OwcWPUHBmtfyLFJbYRFZIFdOzNB/9Vr0PojLAfRzISxifdFOeOIjnIn/8uv1NO78ig20=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GVXPR04MB10659.eurprd04.prod.outlook.com (2603:10a6:150:214::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 02:20:25 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 02:20:24 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Brian Norris <briannorris@chromium.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "francesco@dolcini.it"
	<francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, Francesco
 Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v10 2/2] wifi: mwifiex: add host mlme for AP
 mode
Thread-Topic: [EXT] Re: [PATCH v10 2/2] wifi: mwifiex: add host mlme for AP
 mode
Thread-Index: AQHakVah/NlfkBV8NUyUKYHJ747D+LGkNjoAgAAWMtA=
Date: Thu, 23 May 2024 02:20:24 +0000
Message-ID:
 <PA4PR04MB96385E87C3F000554F325697D1F42@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <20240418060626.431202-3-yu-hao.lin@nxp.com> <Zk6U7CYW2bP-DVTM@google.com>
In-Reply-To: <Zk6U7CYW2bP-DVTM@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|GVXPR04MB10659:EE_
x-ms-office365-filtering-correlation-id: c37e3033-9d7e-43cd-589c-08dc7acee7af
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7LzbOV+C/M0LzwYPscen0H9n/J4RQYMP7Nk4Hb2NuGnVZlZMD0KUhCIZKZdc?=
 =?us-ascii?Q?Z39b+8pL9P3XQYKDQJhxiS+VuzCR9pPxxlISPAUqfn3+RQoI48R9KYQcHKhG?=
 =?us-ascii?Q?j7SaI/o+9KVFIL2wsR3hBJu6HcZi6+1j2QPQohZNZasDqOt8TrGvXNeEp7nh?=
 =?us-ascii?Q?D9PuGebKBSbd2lXpwdjpLJSI9Om6tNtpVRxK/4yDxma2mttWB4UKhDq+8Ovz?=
 =?us-ascii?Q?AWZkbR22I3klqyGFEo1NH2lVXaQwn24wJ+o0wBVRzz0kVVtrJ/oD6eS4MSkv?=
 =?us-ascii?Q?arYZt9FFAa6u5qmK7h/8X8IDVbKd+Vs2lyOoAYR9IRXNhlHky+JnOSxNdrQE?=
 =?us-ascii?Q?rhxgpum1RhXWtBA3mhO12qfuQP7N1EgADwxbigGxs9Ij5fkAdsoJpvDMQa/p?=
 =?us-ascii?Q?IP/DyUsxBVjTWy3F6qs/7nEckMJi4Fig1D1DFv0S2H/1R2ag+coF3v9kFjzL?=
 =?us-ascii?Q?U7sN6lk81XZ/TNlbpp4XXJXx4pacmuFTbq2A5wTank6rEx4SzQEdaoRTvvMK?=
 =?us-ascii?Q?Lozj2W5AfeL61780jni2xssGZ23wnkFOtPPCTxPcfdgB+8v/b2Eml5D7urpp?=
 =?us-ascii?Q?zva2AsiiKeuqIwkpAn8NqqQbkGlEr4T4xeLZOOVIg37buMDRU4eBqsz63u9k?=
 =?us-ascii?Q?6lFoldbWaSXJ43nK4ILDc3J1fMDue2tNfxdVuec3bQ7s4p5t4MPjnOYXTBYt?=
 =?us-ascii?Q?nTVmQ4a/G6HoDqAjnEFEtS4XFMl2T5wEbGcE/YnEMoAzXod8BIvvYleSnKO8?=
 =?us-ascii?Q?A/29pw15QLZ4SGMzPfFGuexZbT4mW5V9tW/5SbcKmJVvjBZIezpQhl6XVetc?=
 =?us-ascii?Q?a4DMflU+qG5djUt23okWqO4Lp0lv3lZZG61hXvt/4HLOtX6sP8SxsJvW802M?=
 =?us-ascii?Q?3kLzGtQKuhn9rfKhmif0LnALJ+qv4XGzuDB72FMzCMgoY27EI0lgoI6uQBb/?=
 =?us-ascii?Q?zIH1JOlBoslRWGgz7W2zyPWQKWGIi5XWe+9Lsl5NZhVl69JNXZhSawo0q98C?=
 =?us-ascii?Q?eMee98V82zwjaHgqZUT2+vk9KR3lV2VnFX0YIGM8lLN5Sx9BYqWqinnYlGIg?=
 =?us-ascii?Q?9ynaaROcN4FMINyKjzIg+s5M7RyDngwirmC64Qy0C/CTANCKhnJZ2PJNeId8?=
 =?us-ascii?Q?wozCmhp6y6k4MmxpNdy29ddGP+VJQBtCrqdADiSdwm35T8h4lrGJENAKCjPA?=
 =?us-ascii?Q?7Aqiob7SQbLvyUNArX4H4XbuQc2QmLRDDQGHo400jxuReMGKuVjGFHbOLTgI?=
 =?us-ascii?Q?6pdfCKZIsjcNyAWayRfgLMQMJ16/rJ7mJwqTEd5fx4FdhfTwVxkd507ORzgA?=
 =?us-ascii?Q?b1LPgNeVhUfGvGWMVfcURD+gBMPJzLSyFmi4Jc0aCHmSBg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+psAPzi/MpzGQhkr0wZ8uVQZu4uS/06n/W/8tqQehCMSUSgQlzDZ1Iz9TqYH?=
 =?us-ascii?Q?1qE4C+9eCYpb4/ITTreky+HrrMhdbMrVT7SqLnEa5iEvrICzWyP6BWVLY5Oa?=
 =?us-ascii?Q?G3nBWAPlLGvKjOLx52h/3tFJ6VexSnkpR+V9IuGGO9gG1EQWaM1o9IShc6dE?=
 =?us-ascii?Q?3ysyjvjlorvEcenPH/NOhTpcyFnh5BxIabx/BBtf3VUpL950txdTbscCKVbA?=
 =?us-ascii?Q?Os7Afo6SbCn8zXTyayrvhRgAoYnL2WHNTSPzsRlPU4oQDHDvQwn1rqx8HefO?=
 =?us-ascii?Q?bvGSwi1QzWk22ecdwss/Zlz8AYn5SicJ0opkWgAcmmN2SmZqrHzD9yQDV3bw?=
 =?us-ascii?Q?/jRIeVp+NpEczv6I84gnfSAgXnt4BLI9rfJd97Rl2gPzVh8r/g806ymptgjJ?=
 =?us-ascii?Q?1PxUhhUIf9gI9JY8+uF+Wu4XmHYJyOfqC0pIs0N+PKPJBLDJHTeJZQ9CMpAc?=
 =?us-ascii?Q?gxtaU5ZsO5N4htJKJnITZZl5DbQP3B025vWaI9ki0lZbP3KLnve9vy8bN/NP?=
 =?us-ascii?Q?2Dz99bZu/aSZkT8AHCJWpGMMcIJA1N+4iBYPhrR5/GRb1NSf+qX1WYQjLzy9?=
 =?us-ascii?Q?rMInv4OCqNhZSE1Gw6rJmIyJv46XmoccuZldmyzrf4/xbb0kq4PhU0UhXPlg?=
 =?us-ascii?Q?2SHyeZ3BxtksnLIHgQphM61ovyiX1Wa2A4cdlL32gVN0scCMCKbgbQVD15nf?=
 =?us-ascii?Q?rdcyoJj2xvtW2B6Hu0fI+GOuEN1Vv7YCFMf+uSBAmeeW5ADHpqUMdIpz/YJD?=
 =?us-ascii?Q?6zkfjI+/S4sMJ6V8w4d/fCKyBEYBIbDfx/Xo4dX0ehjM39NUKxHybkhDS1+c?=
 =?us-ascii?Q?T6qTumQjWUTQD7Rpx3WLFudMUqXSMHaNaotXMHgPH3EhKSxNJdj5aTecs97v?=
 =?us-ascii?Q?45nGtiuYbi0UH+thGdouQL3sAux8QZO+2XYIVOW0D2HydmPjDotKLOdvP5ht?=
 =?us-ascii?Q?IT8gyJ8a4ZDXk7zQzWuqXkTfvzqsJrxcZagDVhE+2arkyhtz81UnxjJFnlgW?=
 =?us-ascii?Q?/oV4yVnw6agIeiY+ZE4ZR8daOYDj+mXk+ttXgctnCLr7pEIdjQriFawhB+Bu?=
 =?us-ascii?Q?vI+N4R7716EQhdzmFkcjqopj8s+rAn/t13hYG2iZx/Y+XDTMk9sj4KByM0vA?=
 =?us-ascii?Q?LI4iu0gd1Bffne++VtCXEduMWhSsIBSe5P313IlsF6yhjOBVir6I6AuZnla8?=
 =?us-ascii?Q?6mByRLta0ERdxqVXLt49HcSe7hbqt+J6axVtZuiuzjeqhwE6DEx8GE04IxoI?=
 =?us-ascii?Q?PAJLdd6AWChPIjIvwjr2IKMX6TPhyDSG3p77KJZRLCENUtvJt/kkIQVQ0P0z?=
 =?us-ascii?Q?coI4FCnvYg5q/7ngOfGxfaXAGnPlujXN/QmEAgCgmlkGXjXZIjFOKirxk6Ac?=
 =?us-ascii?Q?T0Ivd6Nbjqfj5tM41wHp9n+tj59j3vlEgKGjBrs2ZUYoB9SzbFbGhIebmtNp?=
 =?us-ascii?Q?Ds1+ahtOZ9me56x6DnEDovMvuwub9BgbFJ7XbZVB8YGSKxCHSvLTx0hVZG83?=
 =?us-ascii?Q?ekICKgn9ciKrLcIbeITawjQg6QLhMzpTsN2FiXjBOO2t/hk19jIifkyQOWRP?=
 =?us-ascii?Q?GgX42I8vBDtc4fCwhi3KPuPdMRoTM5luGLHul/9J?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c37e3033-9d7e-43cd-589c-08dc7acee7af
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 02:20:24.8625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k+RkWQnV+e2baKcGFDz7iIxFSZ7lc23o7RdSYtpfnkGwnDPj7Tblos0ufco36vBunCsnacL/m8akau82Q2RxtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10659

> From: Brian Norris <briannorris@chromium.org>
> Sent: Thursday, May 23, 2024 8:59 AM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; Francesco Dolcini
> <francesco.dolcini@toradex.com>
> Subject: [EXT] Re: [PATCH v10 2/2] wifi: mwifiex: add host mlme for AP mo=
de
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Hi,
>=20
> Hopefully-last comment for patch 2:
>=20
> On Thu, Apr 18, 2024 at 02:06:26PM +0800, David Lin wrote:
> > --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
>=20
> > @@ -1712,7 +1735,7 @@ static const u32 mwifiex_cipher_suites[] =3D {  }=
;
> >
> >  /* Supported mgmt frame types to be advertised to cfg80211 */ -static
> > const struct ieee80211_txrx_stypes
> > +static struct ieee80211_txrx_stypes
> >  mwifiex_mgmt_stypes[NUM_NL80211_IFTYPES] =3D {
> >       [NL80211_IFTYPE_STATION] =3D {
> >               .tx =3D BIT(IEEE80211_STYPE_ACTION >> 4) |
> ...
> > +     if (adapter->host_mlme_enabled) {
> > +             mwifiex_mgmt_stypes[NL80211_IFTYPE_AP].tx =3D 0xffff;
> > +             mwifiex_mgmt_stypes[NL80211_IFTYPE_AP].rx =3D
> > +                     BIT(IEEE80211_STYPE_ASSOC_REQ >> 4) |
> > +                     BIT(IEEE80211_STYPE_REASSOC_REQ >> 4) |
> > +                     BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
> > +                     BIT(IEEE80211_STYPE_DISASSOC >> 4) |
> > +                     BIT(IEEE80211_STYPE_AUTH >> 4) |
> > +                     BIT(IEEE80211_STYPE_DEAUTH >> 4) |
> > +                     BIT(IEEE80211_STYPE_ACTION >> 4);
> > +     }
>=20
> This doesn't look like a sound approach. I think you should keep
> 'mwifiex_mgmt_stypes' const, because if you're making modifications to it=
,
> then you may break multi-adapter situations. Consider someone loads this
> driver with host_mlme_enabled=3D=3Dtrue, and then later registers a devic=
e with
> host_mlme_enabled=3D=3Dfalse. The second adapter will get the wrong value=
s.
>=20
> I think 'mwifiex_mgmt_stypes' is small enough you might as well just make=
 a
> second copy with the MLME-enabled values, rather than fiddling with
> modifying a single copy.
>=20
> Aside from that:
>=20
> Acked-by: Brian Norris <briannorris@chromium.org>
>=20
> (Feel free to carry that to a v11, since my only remaining substantial co=
ncerns
> are with patch 1 I think.)
>=20
> Brian

I will modify mwifiex_mgmt_stypes for patch v11 and carry your "Acked-by" t=
ag.

David

