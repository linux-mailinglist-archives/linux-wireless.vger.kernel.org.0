Return-Path: <linux-wireless+bounces-13874-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE8C999866
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 02:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2586B20FA8
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 00:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61859748F;
	Fri, 11 Oct 2024 00:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="awFrLSQn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7042107;
	Fri, 11 Oct 2024 00:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728607996; cv=fail; b=LlaWDh1WdLmZ6JpP06VXQUmPce4eW0XmFH2jcwyE5WmeNQzXQCIbnCMNAZ9QFJQxBdNPi5gTeKNQSHdtP1x8CmIuVCTXW+zEHjKnarh5v4ydpzvLe4+F/HDJ4JIe99ESLpT88Cp2Gzp9QrcYgNQythMbPFQJ4ZWpO6QBViZ56cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728607996; c=relaxed/simple;
	bh=TKk0TOSaZV9WQC/w8HEUYDwD0wd+lIrdcuiQXwvnKyM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GsMohhtIvH4qov4RaeJcjYQcA74chfqkQIP+NX9GfAxLLNT2yRraV/t7mdl5TV05MST5eg6Qs6C8hOwA8rf9ZeO+QsCVNM9hMfwipvKzsWuMfCcX1n/DvXo2VgVPmuxyN5IOCalgNHzFEYKXDUreQ1MDcQdcrHFuvmzP96Q3pIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=awFrLSQn; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kiRr0DmC+2lNSxBd8r0MJGsM8DCt5LAEFK4/wfCzYOvDOky5vzkP3fWFanrH9xRR25NkxqsBoybV5Hu98nzMPurJLaV1AMqUlas9PGWEKNBKa/t8q+/8ezzcHGaAsLch4Kuy8MjgKvzH0n0Gw+KStvMFsyPMncvwq9b2treCqphDDMY+gsEVpESji+bvk9t+5pWhvBESmPi2F9eqix3aa29jjcUHAaf91XWFgmiqirksAucW4LXDw2lNIICWu5eN1PtdXj3FiZEkJFqfaCHPJEO+BZTtXBMcNnjZjm+VkTcR9/Qsq5JjvoDwADSMi9NSj7903DhPGk3klv5HDg1M0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qg+Ml1Yt/HkUZD+xkE0ZLWo/O4tQwUC/ka9mZtbzTuU=;
 b=nPy7AUPjWVo+RmcIOFptz2SUKOicPd6aNs6RN968uWj9VoMhtU9bnQ0sFgwcgez5Up/nsuN6nu7Oe+6BRqzgOlTMAEr4Rb5bVlLgslBtL6VqZxZjkecjYV5uHjXdY7xabassjEOqduYnyM7SysXPpecPSgv9qFhj2yNtC2B8UjE6zlwn/PH18BfaunucMAp64rR71qMSc+yB+sdZDYDBW+XRKuRAdZUDhNhiS4sbgsA/JQna/tYbqrfLEm51AkgTyy/YgPOUNidYwf2wh/X4qGQgxochuh+Prv5XNtVCP2SxbIcPcdeMBmrP9fjyLyUBmWiujcUeqvQ5LA/2Mgz8Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qg+Ml1Yt/HkUZD+xkE0ZLWo/O4tQwUC/ka9mZtbzTuU=;
 b=awFrLSQnvbfM8mAgRXeCeIW7H4w41kLPYSJm2M/avaOBXREsEOmCpVe4nscR2yoq2jlAinM4K9v/NKd5olJQR6ZJ77tUl925UChEVFquXZuwg24LCBcI56YUdB0bX4ZM7/OLy6nXcoNpTJscpuCASWdJTMTfrAWVV0hd8ezmcbqAStBZHbFozvW9TRL+mA+9Ro9o+/3wR5KmwJDPd0ur/MUn07T5rA+eHSoipkm1U2yq7kfurY2z+VjeeaFyhQ6MrVpd/wn6nDjgM6CKDnTvILoGJXm5dEfAxHv/aoB2f/9C5ejlwAPC2KIgjWocSTMAXPQIGqYG81ysmU4PeQPShQ==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GVXPR04MB9973.eurprd04.prod.outlook.com (2603:10a6:150:112::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 00:53:10 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 00:53:10 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "francesco@dolcini.it"
	<francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: RE: [PATCH v3 00/22] wifi: nxpwifi: create nxpwifi to support iw61x
Thread-Topic: [PATCH v3 00/22] wifi: nxpwifi: create nxpwifi to support iw61x
Thread-Index: AQHbEwMyNFUkvUYiK0iqRA5rNW1jCrKAyQ0w
Date: Fri, 11 Oct 2024 00:53:10 +0000
Message-ID:
 <PA4PR04MB9638A0E332AC06B0A88709DCD1792@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240930063701.2566520-1-yu-hao.lin@nxp.com>
In-Reply-To: <20240930063701.2566520-1-yu-hao.lin@nxp.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|GVXPR04MB9973:EE_
x-ms-office365-filtering-correlation-id: 235d9e22-494e-450a-e9cd-08dce98f13dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ufpXGQ/Sgn6kskvIvpY2yo2HLr5YeHzmPvF7Mccp13Wp0DZUPK3LS13vTWz7?=
 =?us-ascii?Q?3B5799llond1ZNO6mLO7kTR7HpwZkby62OcRArez2hE62xp1a1gFTeEBDuR9?=
 =?us-ascii?Q?2+M3X4MufySpyk6ewDT5y9JUhFl7XG/IwJhbeNfB4bSrAK0mjbKt0WVNIEa6?=
 =?us-ascii?Q?8qfkWt7O8NTGoYA53C2g4ZGW2LiyVzhZP+TU5/B6ITLm11KWQ1ipCGV40ocY?=
 =?us-ascii?Q?ICEeTn56fVO4oGUa+k9/IRfJdidqbrni5VJatPYme0Z5ezBMRs7R+lsrHrxa?=
 =?us-ascii?Q?XWrwBVSp+8nhLyTYZVG4q0MaGkOfNuh2Iip6XRf8QJGXtm15tdmD5FnqzaKk?=
 =?us-ascii?Q?jyl3kzs9vw9V5nrjDvRzJc2swr3pn/WLYd5D901+EZF2Lqi1xSXL1uP/Tail?=
 =?us-ascii?Q?a0asSnjO6PJE6oAetSVFL9HmDLyWOwGGJ1p0N9Qg6yN5aTbwuApYql+VYK/C?=
 =?us-ascii?Q?8XGhhrU5E/vj5Fba+JZrhu9G20vVgThpBR5soZoApjpYf64Yw7BZhNeN26Yv?=
 =?us-ascii?Q?1+zGiwJjPaLTs9ZJBI2KJ8QynigMwaMY4WIAs5SJGGzrlJ13PmWOq0Pwecj1?=
 =?us-ascii?Q?9VBffIg9FxEV5eNmlbDWbCSU07URfXBx8KRXujjQ5rI4lOgK7HorpulTKvp3?=
 =?us-ascii?Q?8wgAUEtQdLFiIUELIXyC+dEcXcX2TLOxiMrI0fqxRPzKNBT1JCxUopPmqYi1?=
 =?us-ascii?Q?O1LAosba1oi14gCs7h5ljtxCYVHO9rRxb/3GkY9CQLWKtirTiktsEpmlxv73?=
 =?us-ascii?Q?9dZCpJLS2nLZC6T3Sh5M8E7Ue2Jbvaip9BbxqB3atSbxa4WdUkFpuk8QjZob?=
 =?us-ascii?Q?uPBbEFTCRQYZt8LeOMGVBxdZc+K4T2lcR0ZW+GGd/pNjenIJtpG4W6Plpz5q?=
 =?us-ascii?Q?wTrDUbOpBumnm8nByb8tuEuslykpqGiPXB4EgGzkly0m7cU6DgFfDksrQfDE?=
 =?us-ascii?Q?xk1Spga3R1oRX2hPMRvl4aQskSMLysGdxh+M5nbVHFEo+g3HD6mVvx1DSAqL?=
 =?us-ascii?Q?tD8m3P5ITKYVhrgAQ2KL3lvbzOnKaL8jy03ilP1kG6LJzSq8WWwyk5fLr3nH?=
 =?us-ascii?Q?f1q+jjhukbQa9cuffbBayOBYa/9NxIpVymkGC/vZYYlX7pFVYeAXH33/o7WO?=
 =?us-ascii?Q?eHi8X/QFj47cc69e430PvhMpUsfkFzjSwO+Dl/A1JxFseEI4eCte5Hehvadp?=
 =?us-ascii?Q?t6jljPdXdTTAP4RRl1WSmQ9MwpAJVN0yRkiWAeSfaJNrZu9zPO0aYJqY9oXG?=
 =?us-ascii?Q?MiOhbThYZXfuXdN/b6LrIUiTxtQJGMJzUawdilzsDRYKC5JIzNWPsaGmqP47?=
 =?us-ascii?Q?CYlpaLLoBjQrg0HSt5mvLpVGAWZglTeZCTI9VPXmI24EDQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SB5UB7buN6prXQf1KBVOAvx3tevvU81/NlSO7dfxqJILP5qwk4qhtsW56h+V?=
 =?us-ascii?Q?JGZLnY6SjwE4sYQPLPpbjCXsZqJeei8hRjsMtIh5GMSe8Wh5+kHtM6+qTnoh?=
 =?us-ascii?Q?jKh1b9DPjoZ8hArblwJFBqDnQIZdZH5k2pLmXTfK15K+sCEa60npAcFtqtn/?=
 =?us-ascii?Q?cwgujrOxy3q9EOJkwOnyBx69kNauMhzv89isFxAsvt/eoKQoygeUVcf4QID9?=
 =?us-ascii?Q?9fLj1DKQxKMX89S5sBMpG7KkUGIq3Y5h1wwq5W4bV58KUqpKgXldzfzBBFxz?=
 =?us-ascii?Q?/zQekvS6UC3VSw6RqQd3Gitybe1KUepo0fwG1aehkHahbroepPMrAH6+w/gy?=
 =?us-ascii?Q?6ORodhDIy7YsHsWi1FKlJn0j5SJytd0LzaqhSbCop+g7n+I4Zai8/F6SAemE?=
 =?us-ascii?Q?l9vfC1f4WBAmvyYRNcZF3/DBaJ0qETWy0jF2cwyG/6kFR3yR1IEI1Uo1Ts87?=
 =?us-ascii?Q?oSlLDG2A70TaZVVRcgbTnPBeLOtT50H0CayA0ofFBRn42d4evJfmO4WvLAPK?=
 =?us-ascii?Q?Y+moa9p6k/FCbGRuOtGuY5MNvVougubxc/0Yjg1O9x/6/xEESjMjm8uJ6hT0?=
 =?us-ascii?Q?L4F+x+Fdl/T/6oj0WtIPg2WmhJ/Q0krOFFQgXGkTYfFcy3bG91tKDhO18n1A?=
 =?us-ascii?Q?1RxTrV1V08SAD9yo9Oa+NMreHbrgjmOfgAkMxdJfTXA1JrEVywl/mebUo2is?=
 =?us-ascii?Q?rpLZu37qpgxK72VpgLtaWVsQQp89N7pKBoaQmKEsif/0q6VUN/rhAh3kp06K?=
 =?us-ascii?Q?5/J82A68Q6LmR2NgauSjog8QR6TCSldDNMCG3a3RqHqrD5Sh1NU3y42KMm+O?=
 =?us-ascii?Q?Y4Z+Xuk+hPzhvvvOW5ZqSE0L1ketpedCdR8AMHfCoqWOC/LZIC4hfR8b3Ky2?=
 =?us-ascii?Q?pqWxwxjkQx8D85oe7DLL5u9xKebhjWlwPXogdKXNhD5rpAQZblyP8MmxagQC?=
 =?us-ascii?Q?USttjaarDz7dPBdcu3auMEf6ICvOZYV8L1R+A3oDvXA40pPDGDkMYYzVCznZ?=
 =?us-ascii?Q?eBN778mI3VrFvSQGcUJZk+Lx4cgdIKv57tma3zlVBaZtQlijVnwl93P8C+hE?=
 =?us-ascii?Q?8Z6sh69QjYwhjCn0sPBXmBQKlzxbn+LxNezRnome2RimS0quPVtV+SOvOjj0?=
 =?us-ascii?Q?Cr7cz+te5r41hEM7XziMdISSNNTPsmaYMRI9/Z6JVTILbUmN5WHIlHjkUMb5?=
 =?us-ascii?Q?7DsQT4i+b+Tn45zvKqhmqwL/9zqhbeWKGP/eXehtXUEf+tGmhElf8CsVfApi?=
 =?us-ascii?Q?vIOazv2ENbPZFNLaBfAfLD7SbQAoD87EfJXTJwb6eKek1E1vEkvgZlveAg+J?=
 =?us-ascii?Q?p6ItfRrJv7KQabg/8MrIplhqm37y0mcisvM/bf0zDgvczin+YQjFHtvHfNsK?=
 =?us-ascii?Q?X3qXblJ559hl9GDpPF/d07cIWc4+a2PL/Hd3/AY+75+FuWTswW4dQa1azwHi?=
 =?us-ascii?Q?eQ69yL+Z7eZ6CySkYwkUfgwb9JkYUSLYAdBI08lPaSiBUbIuc8ZSkQk8lRR7?=
 =?us-ascii?Q?ci+E3PL4b+srlunzSu8Plz6jwnSMJ0xWywElKgneQdlVl9AIiuj7mjQ8vnBe?=
 =?us-ascii?Q?ANaMbwFrqLTCC+42sVg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 235d9e22-494e-450a-e9cd-08dce98f13dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 00:53:10.2080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FQMnaOqGEu7MzYK0WAb67ozC3c+9hoGf7hhSvK9xjXKedCebUKHlCKSAHRlpiLGownnhiOqcjX53KIHWwBaunQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9973

Hi Kalle,

	There is no more comments for nxpwifi patch v3 till now. I wonder if I can
create the single patch for final review?

Thanks & Regards,
David

> From: David Lin <yu-hao.lin@nxp.com>
> Sent: Monday, September 30, 2024 2:37 PM
> To: linux-wireless@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; briannorris@chromium.org;
> kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; s.hauer@pengutronix.de; David Lin
> <yu-hao.lin@nxp.com>
> Subject: [PATCH v3 00/22] wifi: nxpwifi: create nxpwifi to support iw61x
>=20
> This series adds support for IW61x which is a new family of 2.4/5 GHz
> dual-band 1x1 Wi-Fi 6, Bluetooth/Bluetooth Low Energy 5.2 and 15.4
> tri-radio single chip by NXP. These devices support 20/40/80MHz single
> spatial stream in both STA and AP mode. Communication to the IW61x is
> done via SDIO interface
>=20
> This driver is a derivative of existing Mwifiex [1] and based on full-MAC
> architecture [2]. It has been tested with i.MX8M Mini evaluation kits in =
both
> AP and STA mode.
>=20
> All code passes sparse and checkpatch.
>=20
> Data sheet (require registration):
> https://www.nxp.com/products/wireless-connectivity/wi-fi-plus-bluetooth-
> plus-802-15-4/2-4-5-ghz-dual-band-1x1-wi-fi-6-802-11ax-plus-bluetooth-5-
> 4-plus-802-15-4-tri-radio-solution:IW612
>=20
> This patch intents to add new driver nxpwifi for NXP IW61x and future new
> chips/features support.
>=20
> [1] We had considered adding IW61x to mwifiex, however due to FW
>     architecture, host command interface and supported features are
>     significantly different, doing this on mwifiex will carry a lot of
>     burdens. The effort of making sure no regression is also a huge effor=
t.
>     We must create a new driver nxpwifi. Subsequent NXP chipsets will be
>     added and sustained on nxpwifi only.
>=20
> [2] Some features, as of now, WPA2/WPA3 personal/enterprise are offloaded
>     to host wpa_supplicant/hostapd.
>=20
> v3:
>    - Enable 802.11ax (Wi-Fi 6) for both AP and STA mode.
>    - Extend driver verion string with hotfix number.
>    - Remove Rx mlme work.
>    - Remove all useless check of netif_carrier_ok().
>    - Merge decl.h to cfg.h.
>    - Remove unnecessary check for wiphy parameters setting.
>    - Synchronize following commits from Mwifiex:
>      wifi: mwifiex: replace open-coded module_sdio_driver()
>      wifi: mwifiex: Fix interface type change
>      wifi: mwifiex: Do not return unused priv in mwifiex_get_priv_by_id()
>      wifi: mwifiex: increase max_num_akm_suites
>      wifi: mwifiex: duplicate static structs used in driver instances
>      wifi: mwifiex: keep mwifiex_cfg80211_ops constant
>      wifi: mwifiex: Fix uninitialized variable in
>                     mwifiex_cfg80211_authenticate()
>      wifi: mwifiex: remove unnecessary checks for valid priv
>      wifi: mwifiex: Fix memcpy() field-spanning write warning in
>                     mwifiex_cmd_802_11_scan_ext()
>      wifi: mwifiex: Use IRQF_NO_AUTOEN flag in request_irq()
>=20
> v2:
>    - Rename ioctl.h and sta_ioctl.c to cfg.h and sta_cfg.c.
>    - Remove useless header file semaphore.h.
>    - Use static variable for cookie.
>    - Modify nxpwifi_register to use ERR_PTR, IS_ERR and PTR_ERR.
>    - Use error number for error code.
>    - Remove unnecessary private ie definitions.
>    - Remove mutex async_mutex and related code.
>    - Remove unnecessary work queue.
>    - Add the support for PSK SHA256.
>    - Use tasklet for Rx.
>    - Remove unused functions.
>    - Remove compile warning.
>=20

