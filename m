Return-Path: <linux-wireless+bounces-26015-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2B8B11DDE
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 13:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7932A3B1437
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 11:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39F923F40F;
	Fri, 25 Jul 2025 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=balysan.onmicrosoft.com header.i=@balysan.onmicrosoft.com header.b="VXAZndIU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021072.outbound.protection.outlook.com [52.101.65.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA733D994
	for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753444039; cv=fail; b=avqqoQ8kHXdu9kt3bdqFq2etBlyvQqhNIdgRYrzKZAIiL3yuZW2dc6Tdn5hS3462HDR4Lt/00Cmt0Xpy+X0HjB818JPOXaIN4e1ZiYlSawBg1NURgs2hIFyRoq+xfzJhjJU/VsaOJNrrWI+QQQSdf8bDtZtU+viDz1EfCZAfIC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753444039; c=relaxed/simple;
	bh=Vt6GBwiMkr7b8/qAqdMU3j2ns6PUda+yeMp6I8VM4XA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s0orVXI5RHovNSDo4GgUeqU9Goq5sCXSVzRFKCU8bqh+uWU+SZ6nEkVqucORxMRoECbRWOciFkskXJPGiW7qOGFNrxjPcnsYzEPS2fKcfLOIpgaeimuBsUVyuJmwl1N/0nAmp7mR00y+J4IKAnr+5gntdkQFwcmA4vVVKomIQ8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dotphoton.com; spf=pass smtp.mailfrom=dotphoton.com; dkim=pass (1024-bit key) header.d=balysan.onmicrosoft.com header.i=@balysan.onmicrosoft.com header.b=VXAZndIU; arc=fail smtp.client-ip=52.101.65.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dotphoton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dotphoton.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfeNef80DEtx8AejJCJPDKV+Njmet9T0Nm0r1bl2maf9AZMQ+JHCgvS7kj3Pihfg7F1dLA+zrqqxfMWXVYHrpxNoYCBX5rrIfnrKsGljU99mp+GqNK4lr0B32isvKXkoDa5EJ22fvzOUV5A/KLo1ZyW/elTKIb09ZuPFUJavt+YJaXoPX6AL6F+uDj/fRoRUI3OFdyh5iBgXDHeW8qnDf24gj9OE7ig0WD1K5+U2ahU9bi9DntH8ks/mfzs425C0xIdjj9a0N376E2OGs0HS7+R9Uz6hN1QP4zCTSoXcNVwsKV+mL6lWFet1ipJGLeS+jrXAVLMzcp6EQVhAbKV92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vt6GBwiMkr7b8/qAqdMU3j2ns6PUda+yeMp6I8VM4XA=;
 b=QYoG97ZNoDG2I3BkUPuQ2Sj7YfFKGCFBdKMHb0E5M4+AmoX/BcTGv0kvU2a/HthAlfhNPCK/qQSIO1eriejjB9OPWQe60JHDtHbzD8KsoCQRdKyypuaRqP58xpFv3WHAXs2vwQbSz643FbKim3Ro3JVYEwT/LrqZu6t7iBAdaRIjEUXW1Ptle1hkHL4Rv1AP5+4MYZZ/KCeOHWzQHdWj0dpoLyrNGNL06/cAHyZHuP0KcN51ANl6qlEDNQI2bbxRwaIfg5d9J/wE4XYytp1EMKnS3KBYdvQ7rP2kjcgbSydkADQadwHWPf84SvDcOehApJTnBEzb/Ex4FqCLplexTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dotphoton.com; dmarc=pass action=none
 header.from=dotphoton.com; dkim=pass header.d=dotphoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=balysan.onmicrosoft.com; s=selector2-balysan-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vt6GBwiMkr7b8/qAqdMU3j2ns6PUda+yeMp6I8VM4XA=;
 b=VXAZndIUfTr2lK0PcMFKtXdB0FiawdjnuPe78y9YUnbcGKSerMn5EW9J+hoI7Pr4VsZLBvQT+kW3A2sUFSLphPPFLfskozNowB438mjrFeLuvptDapE22+1K7rYzdDyA3L9O9fEtRFPR4eysq9zwZTFDtKay5GA2Niww4OIuJGY=
Received: from VI1PR04MB4272.eurprd04.prod.outlook.com (2603:10a6:803:4c::33)
 by DB8PR04MB6857.eurprd04.prod.outlook.com (2603:10a6:10:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 11:47:15 +0000
Received: from VI1PR04MB4272.eurprd04.prod.outlook.com
 ([fe80::3c0f:fe2a:7888:2ef3]) by VI1PR04MB4272.eurprd04.prod.outlook.com
 ([fe80::3c0f:fe2a:7888:2ef3%4]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 11:47:15 +0000
From: Luis Oala <luis.oala@dotphoton.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: default wireless-regdb in locale "saudi arabia, SA" makes 5ghz wifi
 undetectable for client
Thread-Topic: default wireless-regdb in locale "saudi arabia, SA" makes 5ghz
 wifi undetectable for client
Thread-Index: AQHb/VaCAzDo4Xw9d0eJNpsj7jHy1rRCtnF+gAAAWY+AAAHNdg==
Date: Fri, 25 Jul 2025 11:47:15 +0000
Message-ID:
 <VI1PR04MB4272CFA010A42407E929D97AE659A@VI1PR04MB4272.eurprd04.prod.outlook.com>
References:
 <VI1PR04MB4272C94084C07ADC3DBDD77EE659A@VI1PR04MB4272.eurprd04.prod.outlook.com>
 <VI1PR04MB427253B87DDFFB5F14CA28C7E659A@VI1PR04MB4272.eurprd04.prod.outlook.com>
 <VI1PR04MB4272A0CE3B47B349990BD12DE659A@VI1PR04MB4272.eurprd04.prod.outlook.com>
In-Reply-To:
 <VI1PR04MB4272A0CE3B47B349990BD12DE659A@VI1PR04MB4272.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dotphoton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB4272:EE_|DB8PR04MB6857:EE_
x-ms-office365-filtering-correlation-id: 85d35ae5-d340-42fd-7fa5-08ddcb710084
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?mArpJHB0nkCPefapzprVZr0Zan09RGmFb3AdAKj/0fCdFwSH9IL3btvkIB?=
 =?iso-8859-1?Q?+2PKqr1xJV+tiKzltMxFCzLoR5lCp4V7g97Dgr+Woyl7v5eZuLlBj6wTrS?=
 =?iso-8859-1?Q?xDm0cQr7btty5Hb0pz1KUGNSgbYWc/1jjTtaCKQx/rlNh6KnsHyHKt1UXV?=
 =?iso-8859-1?Q?B/L6GdLNeab/nP/DNH9yL9g27MS6ulD1k+80LNjZRL9XzL1vc1RAwrLRKc?=
 =?iso-8859-1?Q?tRItT0pKnWoIKSwRVaKjplEEseCWSPqcGWFsTvT5OR9eGAPGlH0oKpEstQ?=
 =?iso-8859-1?Q?wwJiU3Vp4btN2hy5EwStxqtlOUGNsaMTDZo/f5bjaLec1VWP7tl93KN5bV?=
 =?iso-8859-1?Q?wFn/bRJE7TG/H6lrOLXbcX8Q0N1dT3hWDSuDtYrkrBhiIcBOIa0qjXprHO?=
 =?iso-8859-1?Q?nvfSUvb64q56NlLmsnAayf4jsX78jn2B8GrovFj/9I0wTujKtkOxx6TybP?=
 =?iso-8859-1?Q?D2ARjpe+GmFhHG88JBZsgvN2n9bTprNuLgWcUKmYYhVj8mlORG2Weq6K0d?=
 =?iso-8859-1?Q?2LXR4Lp3Wrr5Cmr9iWFpJGJEjIoH8FLBHANP6AzvQLDNqVSA0MmPKxuUdr?=
 =?iso-8859-1?Q?tzKXP2nbUNtMKLOjpGDqAwXEByG988BXoB1uw2DUj9fBd+9QMUihAv6vcS?=
 =?iso-8859-1?Q?6r01JjsYVDtzVVKQGYUKYLJwKoWu92oML6x4Dd3WbfCxJaxtgfkMK/uOMq?=
 =?iso-8859-1?Q?1vGeFMGF/lGbc4lhh4fZSY+6HFa0BjPUfvouwZO41x8T9w8b/SP4FNentS?=
 =?iso-8859-1?Q?bZTihlPlyao/vxIEM1oprKKpZlGYUcRGxTfzjf2kmcfOnJPNvwrNaWK0lV?=
 =?iso-8859-1?Q?f7g5po4j8xUTzo4we4C4hSO2NXA8PJY7YbYRbG4vCpbsv4//ZWzY5Imrdg?=
 =?iso-8859-1?Q?rR/kx87XhClC+yorz5ytFiYirlFuEOdaVUxcW0R15BRjWg46WRr7mZsMlI?=
 =?iso-8859-1?Q?KQPvp8jVjsaOv9U/zqvEaKAXl33wVe4Hp5AoIU9RJX4LVfdKaIi1uDY/ra?=
 =?iso-8859-1?Q?6sUFLmlRqiKKQ6GpIjtddmUaPk0C9s4ruCigxK0sniyR+iZ5ZXRvz85CO0?=
 =?iso-8859-1?Q?Ezw6TYxKSg6vTbhJJ/ChkWv7/8xyUa7UEoxZHhyiAfrmQY+DSZYRWgKpTK?=
 =?iso-8859-1?Q?TJN51LaDXTWPS9b2MG1ojPjJGjnBxpg8ame22wrL4PBX2TuKdW3U830jwO?=
 =?iso-8859-1?Q?sGPBi9OasEDALjGAxV9tesluLC38jFlLWfKrmQmfJCOLoSFNqh+oRNOLhh?=
 =?iso-8859-1?Q?lK3s43rvD8yHk/umH8eutWRs/woM8JiGnlSB9AYYBK141aL6pEwDRtI4/P?=
 =?iso-8859-1?Q?AvE20ePwRLW3zliL3pddhSVSaEFnOG7NzxZFqsVz/uU6b2isaFBovruk+Z?=
 =?iso-8859-1?Q?cn+0RmIFSr+vBcOxphIb7II0o/b0bI87fwL3mzdfT+DY+g/R56wkliwHHf?=
 =?iso-8859-1?Q?UOlS5GF0U9XWmA8opkAsHV3LKc2QXamF15+VZGQQGOMvzqtbmNscv0LRuB?=
 =?iso-8859-1?Q?rglQHpuMs9oz4+x8oJ91SvAULtFC09WKwxR/K+OoJKZg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4272.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?DBgT71X1j1HQf3OIqn/Pqe0dHM7NFVVw84HwtdmcC+NH6e6qjk+Gcb0fpE?=
 =?iso-8859-1?Q?DeJIiWfqEZH3uKw2rHFzcUO8Vbt7qg9S/0Aiww9OQ+zBhuwKH7m7wjFwke?=
 =?iso-8859-1?Q?mgS6vA1YAzFCUuGpzRD0L6DnPp1PhC/8I3C/WG6ZkTsvdoBVfn847OoqEC?=
 =?iso-8859-1?Q?GugTxl5XkgH49b6XF7hZyNYN1fCNiAvsENNhXsKvSjUhba7fbNyft9NF8b?=
 =?iso-8859-1?Q?fr4iMm8uhjR2Sr16cZtAPMnlc4OxRbxyN3tsHNP1Yu7PI9nzLZH7guxdnv?=
 =?iso-8859-1?Q?3G5j9OtD7jiJRMksuq8pmjSxyW6qMWoYH3slyDgtcuCLx16kmPFtQ/cUUt?=
 =?iso-8859-1?Q?6R+Jo1p1qMaWGfEJm/RRxP1z2wfVPIBnvOEZ3MmPayBSBoBDMrVCIK7ZF8?=
 =?iso-8859-1?Q?bSL0FUakURWFKo901e4g0NGAHXDaHxbQobxXis/KtVtkQL+oZ8FtY9avB0?=
 =?iso-8859-1?Q?BDuDGlKAWsVSSwI2dXfNWUuWxu/Zk+9qb5KsNc7HgfzT2kDg7eDGGugUPf?=
 =?iso-8859-1?Q?AWYPRFmCY9LE/xd8DPlx8RsapaJryP7O5Q5oo8wkEOdR71TvHPTR1dHRSZ?=
 =?iso-8859-1?Q?0ri8EFVWn5rWh0i3KsQnqvQER8EJb19iBzwQhNE9JRpHTw8wnVdNa7i+VB?=
 =?iso-8859-1?Q?8Oe7VxV6MlDeR/UfPaI3Z6zV0KrybojFWaDGLNG0ssx5WKoYeK48Y7VDGb?=
 =?iso-8859-1?Q?zfj38rN2vW0PH6/7zBnSTOPdCdnSHr2LWwf+38O/TBFPbgv33Vt3fnjuiR?=
 =?iso-8859-1?Q?Hhly24dYl9/GdbVVKyO8fcAP9tzNebVJGbUvcPH58hxfLm4H3p0U5E5E6l?=
 =?iso-8859-1?Q?Xb3Acy0rBujmrlnF8DMslWAFKb5BZpTtQgpkCDj3MYqZh+yFZbjje03lVi?=
 =?iso-8859-1?Q?5NR1q+qweVTEtQS4Js96RCR/3QeYhkFj+xf6v+n3MY3GA7sf9umvUsUYKM?=
 =?iso-8859-1?Q?VfZsaRrKYibEPTYMW1z0fFjisx+19KIgF2pRVhKtq0kh/2tYSIl/8sLzK3?=
 =?iso-8859-1?Q?JmcnzGpB/Pc3PEiLe2yAJBoUa6GuZQgAhWHvl0mOjYM7hj3vw/iUEF9IFH?=
 =?iso-8859-1?Q?4DDKavtVKF9u4gkEJ7eDodNv6MJs46vubVL+6Wq9jwoJ05G1XhR/ibCrLk?=
 =?iso-8859-1?Q?zsXcRne7xE+ptUEXCsHm+SQJVEzD48E7F6cpLPm7jZPWXuwKlAZl08MqL1?=
 =?iso-8859-1?Q?eaJUC0i9trf5GiFodAbThyWkc7zvqwQOs3pG4e+CiFamjD23HD1WrS4Wmb?=
 =?iso-8859-1?Q?sjSIaJp6QqXPodgW5d632S+32lWegk2+Jet+Zv/2JO241KU06xvHQNcZJe?=
 =?iso-8859-1?Q?B5NMRF1tS55flH1059Y2fLvMBrCneJT2dE1DyS2geiUmJ9/B1jtpJOp4xi?=
 =?iso-8859-1?Q?7z2jtZPau/sb57G/cA2bnUUO9ev4R+U+LEH6zYD+5BjKeTkQfBqkj3gakr?=
 =?iso-8859-1?Q?b5UOkRuFNwNJxVINJOtMBHjOly5KH2hn4sfPrJ80ucI3id2BpWQMdtoChD?=
 =?iso-8859-1?Q?dUTIuyf0nyO669u45uDO3T6ONfS9MMaZ4/7G6NfQOrs9qejvZrM1YmfwCJ?=
 =?iso-8859-1?Q?M2ILllI//UNRqbtsSCtqUk5UYTFjSCL4wQiCbXZDW6Jh0U90PBZSM4tRe6?=
 =?iso-8859-1?Q?bkFJ0Re5FhV+Wz8g7bHq69AQr8T21vZqgd2uxHJfkgQkJUE8Rw/BZrRvaV?=
 =?iso-8859-1?Q?xzi0Ic/TOaI3u/97hwHPRgvSGNP+nmZr+TBU6T0v?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: dotphoton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4272.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d35ae5-d340-42fd-7fa5-08ddcb710084
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 11:47:15.6808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 770e500a-35e4-41f7-a8d2-c89118318629
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 30jtXpP0XpFYjXppZXxDW/lBH0rAgG1U3GbU0kDwQRSA6XP33NaHugvQ9JmlYGV1YDdPtMS9XFthIymlatthJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6857

im running latest fedora linux asahi remix 42 on 2022 m2 macbook air=0A=
=0A=
i stumbled over this when entering saudi arabia trying to reconnect to my 5=
ghz hotspot from my phone which usually works just fine but the laptop sudd=
enly could not find it anymore. and then noticed the laptop also does not d=
etect 5ghz band on local wifi routers (which my phone oth can see and conne=
ct to no problem)=0A=
=0A=
checking=0A=
=0A=
'iw reg get'=0A=
=0A=
i have=A0=0A=
=0A=
global=0A=
country SA: DFS-ETSI=0A=
=A0=A0=A0=A0=A0=A0 (2402 - 2482 @ 40), (N/A, 20), (N/A)=0A=
=A0=A0=A0=A0=A0=A0 (5170 - 5250 @ 80), (N/A, 20), (N/A), AUTO-BW=0A=
=A0=A0=A0=A0=A0=A0 (5250 - 5330 @ 80), (N/A, 20), (0 ms), DFS, AUTO-BW=0A=
=A0=A0=A0=A0=A0=A0 (5490 - 5710 @ 160), (N/A, 27), (0 ms), DFS=0A=
=A0=A0=A0=A0=A0=A0 (5925 - 7125 @ 320), (N/A, 23), (N/A), NO-OUTDOOR=0A=
=0A=
phy#0=0A=
country 99: DFS-UNSET=0A=
=A0=A0=A0=A0=A0=A0 (2402 - 2482 @ 40), (6, 20), (N/A)=0A=
=A0=A0=A0=A0=A0=A0 (2474 - 2494 @ 20), (6, 20), (N/A)=0A=
=A0=A0=A0=A0=A0=A0 (5140 - 5360 @ 160), (6, 20), (N/A)=0A=
=A0=A0=A0=A0=A0=A0 (5460 - 5860 @ 160), (6, 20), (N/A)=0A=
=A0=A0=A0=A0=A0=A0 (5925 - 7125 @ 160), (6, 20), (N/A)=0A=
=0A=
trying=0A=
=0A=
'sudo iw reg set DE'=0A=
=0A=
i get below and the 5ghz band is discovered and connected by laptop as expe=
cted=0A=
=0A=
global=0A=
country US: DFS-FCC=0A=
=A0=A0=A0=A0=A0=A0 (902 - 904 @ 2), (N/A, 30), (N/A)=0A=
=A0=A0=A0=A0=A0=A0 (904 - 920 @ 16), (N/A, 30), (N/A)=0A=
=A0=A0=A0=A0=A0=A0 (920 - 928 @ 8), (N/A, 30), (N/A)=0A=
=A0=A0=A0=A0=A0=A0 (2400 - 2472 @ 40), (N/A, 30), (N/A)=0A=
=A0=A0=A0=A0=A0=A0 (5150 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW=0A=
=A0=A0=A0=A0=A0=A0 (5250 - 5350 @ 80), (N/A, 24), (0 ms), DFS, AUTO-BW=0A=
=A0=A0=A0=A0=A0=A0 (5470 - 5730 @ 160), (N/A, 24), (0 ms), DFS=0A=
=A0=A0=A0=A0=A0=A0 (5730 - 5850 @ 80), (N/A, 30), (N/A), AUTO-BW=0A=
=A0=A0=A0=A0=A0=A0 (5850 - 5895 @ 40), (N/A, 27), (N/A), NO-OUTDOOR, AUTO-B=
W, PASSIVE-SCAN=0A=
=A0=A0=A0=A0=A0=A0 (5925 - 7125 @ 320), (N/A, 12), (N/A), NO-OUTDOOR, PASSI=
VE-SCAN=0A=
=A0=A0=A0=A0=A0=A0 (57240 - 71000 @ 2160), (N/A, 40), (N/A)=0A=
=0A=
phy#0=0A=
country 99: DFS-UNSET=0A=
=A0=A0=A0=A0=A0=A0 (2402 - 2482 @ 40), (6, 20), (N/A)=0A=
=A0=A0=A0=A0=A0=A0 (2474 - 2494 @ 20), (6, 20), (N/A)=0A=
=A0=A0=A0=A0=A0=A0 (5140 - 5360 @ 160), (6, 20), (N/A)=0A=
=A0=A0=A0=A0=A0=A0 (5460 - 5860 @ 160), (6, 20), (N/A)=0A=
=A0=A0=A0=A0=A0=A0 (5925 - 7125 @ 160), (6, 20), (N/A)=0A=
=0A=
i could not find any resources online pointing to this problem so i want to=
 flag it. but im not sure this is the right channel so any pointers welcome=
=0A=
=0A=
thx=0A=
=0A=
luis=

