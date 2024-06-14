Return-Path: <linux-wireless+bounces-8992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 127C690835D
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 07:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829F01F2220C
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 05:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4CE13212F;
	Fri, 14 Jun 2024 05:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="btPwB2Du"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769D81F5FA
	for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2024 05:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718343755; cv=fail; b=YFu6EgK84JVckK+bwWH8oLyb1G+lnOU4PJDTRykbX+NHd1rzbQnRGpNisDW0RVwIFCTfaz+o3ElI2NuNvw5z6r92ruONBYtnesCBhon7JzERm99t70XBVR1kb3jDly0LFhfLmzy+P1Bu9+yknzsGaFjm5SAVGL7S1gJER0p6QBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718343755; c=relaxed/simple;
	bh=jp9fziy/zoUw6gjB+VFOsil7bHGYmoqpddM1wSOgFzI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HXq+0KCtHW0cy7Mgdmfl+mnLjCtYGv5F9wZ9zpSb3+uXRvVW5JbUQngVQ/fTmTH2JaGARRiLeGV3odwPjCPsrLtPEkPLwPUh9msE64iymV8Zj1OmqLHvC8Bpnmt3DVp/qso5pl/8UacWc+xUYvMELtcIeuMXPvEFJT8DGyNWTuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=btPwB2Du; arc=fail smtp.client-ip=40.107.22.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ct+IjZHGPyTOD/COpGCHLx7R53I0lKCnJz6c/PvmR/yL6I8cUk5Df3fBvRhzR+y6ruFMwsvU6UrC03Z6DUGvwCtR09fndX9VblFmMDjKxdfL6NqUQEuRpYzAlMJqA8pJnlQx6yZ9iJGhBaAQIV8lXiKkcwI7ErFDrnseD4ksE9o2ZxkmWyQ72AYOZ83FNdxStHTwo7+o70F2shfZce0yMBfvBF+12AnePp0n6FbIBQsE4Vs70y4Jpm9sX6tsqyT0sEb9oyZMW+ZkmvYZVlFZmgDHbpH20MuANwDfmrsAw9HM2jq5AagBcQ0PIpHB9IHkQDMw9urdbFwsBJVHKiNJ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FG4znRluhKZY8qC2PlGT43QP2KkN8jfFItK4E/RHcnk=;
 b=HPNpkRuwu6zJTi5FwEIheoCkVaY4axC8TkdhcXvK4N/2nP2v7wuMk4ddzt67sO6TAvUpcKnnSyWkttyaNRCOHLmMON7GLXKOGa9edKuLJ6mUVG/GbOnnjIRbx7qTI5QxmQohbhHzA23IaqZvRgfdkl4fIsRDb3P+JRWrs+MSPhCVfQhD/W60gC2ZCltbfptijQHK7dBYrqd/oJZW34dXMGqk3HHmQELpry/KZtca6pMrrmpVp6p+GO1QBOOKlAaMLqPthUURA80KCGf/VprWchJMmXcIemE/oElw/qtgK+5AEzL6DnK8j68lSbf+M6OoP7+PfvUneztP8aan4lhPTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FG4znRluhKZY8qC2PlGT43QP2KkN8jfFItK4E/RHcnk=;
 b=btPwB2DupB7n+J93Rayng7ZAhhy8otiqdxyrXDEDVvfPWPLt8vNWSNa5sMCTNxtsepvayHI99ECpg1trh9PMPhih9KyRapnciLHd9DihKQjAE5epoThj7JbfZIwXuTQWVpZwBiH+YeUUgjj2hOELkm72mLVw4akfCk6XIo4zrn8=
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AM0PR04MB7028.eurprd04.prod.outlook.com (2603:10a6:208:19a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 05:42:28 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 05:42:28 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: =?iso-8859-2?Q?Tam=E1s_Sz=FBcs?= <tszucs@protonmail.ch>,
	"linux-firmware@kernel.org" <linux-firmware@kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"lukas@wunner.de" <lukas@wunner.de>, Andreas Kemnade <andreas@kemnade.info>,
	David Lin <yu-hao.lin@nxp.com>, Pushkar Sudame <pushkar.sudame@nxp.com>, Pete
 Hsieh <tsung-hsien.hsieh@nxp.com>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Pankaj Razdan <pankaj.razdan@nxp.com>
Subject: Re: mwifiex firmware mrvl/sd8987_uapsta.bin missing in the firmware
 git
Thread-Topic: mwifiex firmware mrvl/sd8987_uapsta.bin missing in the firmware
 git
Thread-Index: AQHavh2k8ezUsPURmka9vzjmrYkoUQ==
Date: Fri, 14 Jun 2024 05:42:28 +0000
Message-ID:
 <AS4PR04MB96928325EC87268AC7CD897AE7C22@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20240605160013.6bea8d4d@aktux>
	<_pNnwoI9WHlb2EY635KdIv6t_goU-ZYp9Vav31jkFOCf9fCE9EeKdyCea2m-L8pgfsKIQvODlnQLhQqmWSYip9e6FFZwaJHL5-u5rdOS_kY=@protonmail.ch>
	<20240605174709.5043af8f@akair>	<20240606101839.GA76158@francesco-nb>
	<PA4PR04MB9638D1FD47BFBFDDB096C778D1C02@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <20240612094011.311c2421@aktux>
In-Reply-To: <20240612094011.311c2421@aktux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AM0PR04MB7028:EE_
x-ms-office365-filtering-correlation-id: 320d6a2e-e765-4e53-ddac-08dc8c34c728
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|1800799019|366011|376009|38070700013;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?3HxrZp8Uwz2QVcIYAFEf6tlM5T+RguMkGwSzx4S5rdVKjeHxESjnjWHL63?=
 =?iso-8859-2?Q?uYwH0crBvfToLFZXeAYtRnvqLFnTal0sjQfCsS1HRvP/4AkL7PwVJvUCS8?=
 =?iso-8859-2?Q?luJe8JG8PeTFAtgcGEfGFmU4ZN9kM+Q/oOQxUS/QyDxNiddkVomKgJR4lT?=
 =?iso-8859-2?Q?/0LQOrqI8vO7xY1GsOyMWuwgpc1mPaHaI8/qJYKjnanr0jpYt9sDIZfxKZ?=
 =?iso-8859-2?Q?m+pqfZRtKMBuWxh/EoXwXkLJZoLbkxpMVIH9QEjkN6ASpyLQ6Nb+8L13sD?=
 =?iso-8859-2?Q?PQ8N9L4420zRxnwOxIQNMGnuHKyCx7MWMv5asiGlMsICnVOUXuxGuC63yo?=
 =?iso-8859-2?Q?NndMyRAjxnGEFz4xZMMtCSTfrMst0TY6e6npl32PzI/REtu7C+4iOagS6W?=
 =?iso-8859-2?Q?yyaTCA1fxLE5cUXnJfUXAZ2hGyqqV585eOaP/bY1GwYK7wRwwpFRqPWRwO?=
 =?iso-8859-2?Q?9+8P7JNzI4czGusQsAWmDuOVN0vj0RQGNhUC9bqBqCdAydmgHDudbjf0hJ?=
 =?iso-8859-2?Q?myeFh4e5dPbP4bRUAJzidcnKgvJeWh7OOl7ZyN9ba8AgG/2OYSMRRLuz+H?=
 =?iso-8859-2?Q?D+6GgyEJW1NSuSkn6PlsrKvNqUfvRrCQsm1ZHUJAyGz/5LZoZpTifjkhw2?=
 =?iso-8859-2?Q?KBHHKXUeqUbk5SV7wfHPrCiwn20B9D0b6cH+Pvre0qb9zGBAo6XjPprEs4?=
 =?iso-8859-2?Q?JcTjzmMqfV35zu6B+FQh18AwEgbSTVzA9SD+Upo4Tqo6Oxxn8s5HuOIEep?=
 =?iso-8859-2?Q?SEnwO5NV2Bos5LdXJC9E9dTJvXs4YqmrOWOT8najAXC1M+ik/MDwGJPrOy?=
 =?iso-8859-2?Q?4poN/M0gXIeDJQsFkggnnQ6LWIw2CRXwYDrhSRuSGfMt6CPeBdV9YFBa4p?=
 =?iso-8859-2?Q?BUKo1bKTHpGBMR7n1SRyyfnWnDSPIzED2Ewy5fFHgQHByUo8puQgvXuIoI?=
 =?iso-8859-2?Q?C3+VM0FWFeCg8aI/kcd82J9dsMhOpJ4iWZJk8UcZfnRZkVs9f0Uq/qfjR3?=
 =?iso-8859-2?Q?P1EY1noJTdxYGSRTfBnBbgEqkSVviOvGmQhaAOCPgUDNKfShqT3/m1rray?=
 =?iso-8859-2?Q?gWBxV4m7zRWm63Rx2bLQH6Fjsb0XIOXfQHLs5s5fJAcPJTunHuLrxKd/1S?=
 =?iso-8859-2?Q?62S1c8nex3datySIqSOeCe7E1tDMc0nVC+oNZ4R+biTv88RJpJmKiNxqQJ?=
 =?iso-8859-2?Q?B/na39/xSPxV3jxtWK842fI1AmhedYsgu5As0YqdSy1nimECjPMuzTryaD?=
 =?iso-8859-2?Q?6Wd5PVxg315w7sZIsWAaS9DAghx0w5eyPSu1k+5T8tfbdjphc4BZj1La9O?=
 =?iso-8859-2?Q?dC9rCC8jb5AZm2RqCnavGRwx+XEco1SNOVjM+qJWWoiSkGT/bXLVX/FqQd?=
 =?iso-8859-2?Q?oOlsWzGwP9nyktsERYh79RvHWl5W4R3zu7qhtmGEWERUxIGj1y1i8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?q5AzbCnvUJGZxCIHSoVrpacKpzjBivLvkrcEGFIXzaDVL0Ma5ddcbHIGiw?=
 =?iso-8859-2?Q?QwPOh+Ghju/tJqh6ZejlWNQ4RYPKSXTEDPB+g5ius630o0RbtxBK38e2we?=
 =?iso-8859-2?Q?H53E1geWCAFyLY1b1rSCS8bH+536Dr/pEwqwViRF9pl8mpGCaxwnAQBWYG?=
 =?iso-8859-2?Q?cUnP65ghqrEv9ad+v4cZ6ln8+bB3gy3yy51vRfW/d/gmryEddJFupgxaU4?=
 =?iso-8859-2?Q?YmJU/pmYQiKN+PILwciAoG8XnhhlkbZMM0AoY0ez7AIg3YYPXEayBIllYj?=
 =?iso-8859-2?Q?j5qU7jdfNakqzErKMrA86f+6szEsM0HKk0AOmyAu1x91R5Dbc4q3Bb/doF?=
 =?iso-8859-2?Q?4fMKs27cog39Mzpm9CApFXQ5LjuQ4vf4IQ2sJrfREgtgcwmkBP8Ui3p2iC?=
 =?iso-8859-2?Q?FrKHyVGf0o8/BTm3MpMT1InluEZegYARsl04koHM4oqdtQhv2Rduh5xn7i?=
 =?iso-8859-2?Q?r58YAGNYpe7W5XMhi/YgdZotwbACfntpT9tJXfF6kR18o6qFZJl387JAtR?=
 =?iso-8859-2?Q?o0H5yW1Wck9wS0HblTuFpaUkTnSdSmtV/wwKI0L/sPGHUd3PBKcOPZx5WJ?=
 =?iso-8859-2?Q?T0JxXlG6Fe3IJKaPobPMlK7urW2C23tiGsUzPpxon2gbswClC6Jw4S05vu?=
 =?iso-8859-2?Q?cV1aMqf/BTJ9Rvn+UNFhxFIALO36FUYVl0Z1CII9I189YvzdXWvRLaaVT1?=
 =?iso-8859-2?Q?2ULALXMUN0dh8/MEa7I26hHgAaXJn/kliC/1vKBkXlkiGhih6xVjW2EEyY?=
 =?iso-8859-2?Q?zfLtedWdifngaBEkqhH3xutwxxDgIucsYz3B3QZwycHNxCUQ18UUyu9JaY?=
 =?iso-8859-2?Q?7Fc2ZTZzwz64UkoP3fPa1+MYjGhq3P+H6IEqiNah9fmlpMph4sJ5qktMoM?=
 =?iso-8859-2?Q?oFkJ2LLUfahcn2ZZ2MmMFh8snPq+FZGKPNmZnA2HeF2Ec2Owbexzc4HPnW?=
 =?iso-8859-2?Q?xDFalKOjjcK5DRovYFhlCwpcsTIDSpefW3jAbv9AVlHUoILiWrBUqaCGrx?=
 =?iso-8859-2?Q?6Y0qHuJNT5Cu6GtHLGaeJwfwFVZCnn0Nj5p43vfC4AHeLumkyq4LZOLD9n?=
 =?iso-8859-2?Q?hGls24Qsqig3jP79vkcPdLWmVpEecW9ghLuEuhnMlN59kIqXI/7DPEB104?=
 =?iso-8859-2?Q?WmSN6UZWH5/tytPwv6GZb5WCQH7i7O6tM3FlD1dXxdl+skgGYtR6w70yrA?=
 =?iso-8859-2?Q?pN5jSz8sI5tAUya6/8HXDkdfcI9FeAssM+966Bolqc8ypHUpVDnaG6fZ/V?=
 =?iso-8859-2?Q?i/boRLqZBjd4eVn1z8tDMZNB9c8vtRnK3KksNh+JYsO4gAGjZzjINj353z?=
 =?iso-8859-2?Q?AnWuk3UsZLeyR81Tib8Kqv/und59CAZaNJLf4+MlZbvZxiTCDt0nH4ZEZs?=
 =?iso-8859-2?Q?hprh2RnThj3VnM85Trykrm+gAGAfLSHBBesvN0AyJhHV7NzJSJtjURinys?=
 =?iso-8859-2?Q?r8ojx5lGPWNPf/NyVvNp69zjGhnkF6+VW7h3pOgkP5Q+fM5NTczhfHIckT?=
 =?iso-8859-2?Q?bD9pFRp1oAzw8H0qNMCNvl3CJR8zznv1RiDgZW8cgUXL4bDqaVTWT6OIuZ?=
 =?iso-8859-2?Q?QF/1tyfdDbdM2pvjfu2DPXM/EPSpI4KUUaH9r2w9msRobHSjjZ9XjDNEDQ?=
 =?iso-8859-2?Q?k3C8/ZCa244wUt7KALjTGKE/BsUZrqHFp1?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320d6a2e-e765-4e53-ddac-08dc8c34c728
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 05:42:28.6948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wmkLmCBKbX1eO8cB3S4T51lQmWCWZBhuz/7FHwbMl8k+WwPU2sTDMnXvOmvm9OfMrOg6scTXWwz+eVMdwaIn7Yd6md/+XZybsnR8I9/bKnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7028

++ Pushkar, Pete, Amit, Pankaj in CC

Hi Francesco,

I am not responsible for mwifiex or wifi firmware aspects, but I have forwa=
rded this query internally within NXP and added few stakeholders in CC who =
can comment in this regards.

Thanks,
Neeraj

> > > Hello David, hello Neeraj
> > >
> > > On Wed, Jun 05, 2024 at 05:47:09PM +0200, Andreas Kemnade wrote:
> > > > But that is all legalese and I am not a lawyer... Best is of
> > > > course something officially added from NXP. No idea if it can be
> > > > done otherwise. How to make NXP add something?
> > >
> > > Would it be possible for you to get these firmware files added to
> > > the official linux-firmware git repo?
> > >
> > > I am not using sd8987 myself, from what I read in the thread
> > > probably some file name would need to be corrected (I would say in th=
e
> mwifiex driver).
> > >
> > > Thanks,
> > > Francesco
> >
> > I am not responsible for firmware release.
> >
> > You can get updated firmware from
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.
> com%2Fnxp-imx%2Fimx-
> firmware%2F&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%7Cf6a593f3
> 0cbd4db4c25708dc8ab2e6c3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C0%7C638537748179838808%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C40000
> %7C%7C%7C&sdata=3D3VpeUrG20NMjgFHNaN32m11zeyBobUX%2BBoeipSEUnz
> s%3D&reserved=3D0.
> >
> > Normally the firmware will be merged to NXP Yocto project.
> >
> yes, I think most of us are aware of this.
> So what is the problem: E.g. I have bought a new device, ported a linux d=
istro
> to it, ok, for my personal use, I can just download the firmware from
> mentioned link. So now I want to pave the road for others so that wifi "j=
ust
> works" So the question is about redistributing the firmware:
>=20
> Citing License:
> "(b)     to copy and distribute as needed, solely in connection with an
> Authorized System and for use in combination with a NXP Product, non-
> confidential NXP information provided as part of the Licensed Software fo=
r the
> purpose of maintaining and supporting Authorized Systems with which the
> Licensed Software is integrated."
>=20
> to me it looks like the firmware might not allowed to be part of a linux
> distribution if that linux distribution is not just for one device.
> So an official permission to do so is really helpful. The most clearest t=
hing
> would be an addition of the files to the official linux firmware repo
> (git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.gi=
t)
> by some NXP people.
>=20


