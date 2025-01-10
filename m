Return-Path: <linux-wireless+bounces-17284-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BE1A08686
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 06:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7666168B2E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 05:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB25741AAC;
	Fri, 10 Jan 2025 05:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BtFOBjBk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F61746E;
	Fri, 10 Jan 2025 05:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736487082; cv=fail; b=R+VLjEu7ZzN2VC+BElX2jWwC07cmk8hGyTy+0lS+se7f2JUkUJxbYy7yUn9klnGV5vOU387E4do4bwYAfe0SMIYu+0x/dGeVJxPc087C0KeCPj25NmBzwJf+tvTEWyvdSos4o8D5OTvmUF13OpK6SeHgKlbSMiFANN6tsXAQpvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736487082; c=relaxed/simple;
	bh=j5lLsEcXiRaf8XwvNFRsc21XFZNpFT2Y2eCpyAKNXlM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O3A/eKv+Io5prDjiUeohYwDk4gwykyRIEw9dHvocuLak5cCieaS5AbQtmgpEAi/TgCf+OpK9etbsMCMUHCWsyliQz3NTmds14+XQwQEBG//HVpLuxfloaNQ1r0x5HGsmL49RFTc+uu38+8RD5weKvAVIz2VUXSwbNIUadFm8z3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BtFOBjBk; arc=fail smtp.client-ip=40.107.21.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SaW9ZOPDgIhJkT6gyDfzBdnPnaJqMhxECQj4HXUxKdGIMXkNnh6NlQrHUn9CcY5yt5sUpp/ydIj6Wv1U5gnvivwZAVCTQZkABuCFKJ4iH27c+4NGnHIUv28hsiCBK2VHNpTcv3yb/iHow8+51DRUuf75rSVxTJlS68QlZzPu+staAv35724mcDvmmgfjrsyRjrwTv+2E68RiT3VEtkKYBzQG+QwC2Admk2C85T0iF3E36z3prfZK8+YbUtAR9PlLKbDBFdNPNUxG2u4aDNFeNuDN+WCuVDo53XkGJmk1kz2CjlmuPX8X2AdRimQzuodlO4RZcWWWuhLPN//bwkvdug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2IY9HyZp6d+ze321fJO1Hxx7P2bmfji4zM982WJMes=;
 b=vl/EVXNRysaV5u/CmCgwpAEdfLwRNvsgcTHpaVCfJibGPuskDkfi5SPg2+Nd2J6Q6kDvUlwnftmXmPBwzB3+o15eYzq1AIauKz8NI023rMFX/Uz+2aV0GSzpNSAkwyUvwNBXS6zdSwtTciveSr2egLuJj9aPzc4SCFrbTCnVddZN/Y9MJNqtgYZm3+wLFPUXgypivedROSN5+FnRb4Rpuz0JA0898ESUGgzeC+pMvudgIE/YOsFS9M9rjPMi6Q6q/ho3b4cpRWtN5RIwMYWIWh2j1diczpkr44o5QNMWw3FSQPSPk2TfQ21bzCnyDpq5o1eRzZ+0csq+s3hyXo6eHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2IY9HyZp6d+ze321fJO1Hxx7P2bmfji4zM982WJMes=;
 b=BtFOBjBkA8i/skw+SmPy/RiGDFmMdBs0YVy3cAewGZMb92c4PkdxWnJ8d9dg8FETxJpvaBBXB/6LQTfHrM6V0TVhuHT0DG55yZ+4lO0f5Un255NoR6oeDGOyL9yq0DcbDkqlE1ZWUzbXXqjFqnKdJfaMXApSlBgW/bSyhp4ZMC3Aa4LPkQWXI+s09d53KLd+JagyxkLKQiI4gsscxTEUxrSsPZlMnSFIq9V1ECp3Pk++gYaZGxHjM+T8ozW3hIwDB3EgjotHPH8lB+8fPmFf0qHpXUfPdaCofCcTdvjh/0FYJzeVIYgNrnL2/jgHK6UqptFxymx4uiJYAHwM370bxg==
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by DUZPR04MB9822.eurprd04.prod.outlook.com (2603:10a6:10:4ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 05:31:16 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%4]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 05:31:16 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: David Lin <yu-hao.lin@nxp.com>, Kalle Valo <kvalo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "francesco@dolcini.it"
	<francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, Chor Teck Law
	<chorteck.law@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to
 support iw61x
Thread-Topic: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to
 support iw61x
Thread-Index: AQHa6kDq7zFfRJGOz0Wel62W8Sr8T7IzUOKAgFesnAuAViyYYIAvQlUg
Date: Fri, 10 Jan 2025 05:31:16 +0000
Message-ID:
 <PAWPR04MB99101EB44C294AE82A2DA7AB9C1C2@PAWPR04MB9910.eurprd04.prod.outlook.com>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
	<Zsc1efkBHDXdZtfJ@pengutronix.de> <87a5f341bb.fsf@kernel.org>
 <PA4PR04MB96384D3EAFABA0D4D6BD6A3DD13E2@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To:
 <PA4PR04MB96384D3EAFABA0D4D6BD6A3DD13E2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR04MB9910:EE_|DUZPR04MB9822:EE_
x-ms-office365-filtering-correlation-id: 5c8f9590-153e-4848-0632-08dd31380121
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?c5XBzmBKZyV4yhcLMUlG8NK2t4oUqJRP9haUbPB0NLaNkQwSesSiHnZo3pq/?=
 =?us-ascii?Q?/AEqV3IFm0E4oDnDIfVxgNW4hmFAPyEFx/nFHa1MmFBlecxCzqXoN6MSwcjv?=
 =?us-ascii?Q?m3fa/AOpQJQvaGzHqjzqAjIyGkmwDxiDe8SPd+pxoX2w+4T9sYmymf3YqGM+?=
 =?us-ascii?Q?jJ7AtFPIapxLjqZKbwqbQIxk0YYAkEg3+kwKgo/v6jIYMmWmPGk+sSVhYicl?=
 =?us-ascii?Q?sTnNKVnzxPYjIZPgWz0B4vAAaorDC6MQX9W5rxfO61oTYaxaSH1ArVFmHciF?=
 =?us-ascii?Q?juw/MWEQlS4Fj7oNyvbwUC0ChCpHOs1Pul78p0HDW+y4OxxP3samjGxtu3Jz?=
 =?us-ascii?Q?ssXj+AdKqZD9optpTQvA+jgN7qdihCu/sWdTU+69ogYO6tw89nKj+QEUbk+Y?=
 =?us-ascii?Q?m1DKNdvunWme7EZaQj42OoJD1ExO4zsk5Cjroj+L8MCaGq2QoHCT5k1+kMhy?=
 =?us-ascii?Q?PQqc55cRkxY2DjKDO4cKS8nqMvI3up6V3hZXJypd0k00UI2YrKo2j+ipHyz2?=
 =?us-ascii?Q?vPLy2sh3mhDK1ir00Pdm7Tu8rHxdIxn9uV+wgsfc7v8bXLPyi4e7xn+Obipr?=
 =?us-ascii?Q?24LmadJb+spRxapJTm99b2qkcSGXbKwRygCzylhydXwNtQxHOIArqODRdrRI?=
 =?us-ascii?Q?8mBkzsXix+xlkL8IGhExQg1H6yV6JfXGROnhtUohBFLZ6VeD6pFFVzxrECA4?=
 =?us-ascii?Q?OGnqRYc+9lHt1sl/kMktdZDsyeNdg7Tugl9QzjZaBNW+uFFurx0pNmh7hb15?=
 =?us-ascii?Q?0RXPl7cNm7G+vfgoRzkmQiLBogN9sgPn5WI65RDicKNG3npnWmA8YM/oNRLB?=
 =?us-ascii?Q?j3KtUmeyucoeXQEQBsfQhJBWaT1ShxoQqoVkn+a3ybQ7ekJRoRMj9CMQ2EQ5?=
 =?us-ascii?Q?7y1m/owYy2Vg/CCuWUhL+9G7Myxn/GKGB4eCqA4GuGK6p6uOrVmb6U4m7GyL?=
 =?us-ascii?Q?vBybj4y1zsQ9IG82DFL/+zn0i7YcY64XA5Cr40cKUY6+Ruq8yFTWNfckbDqD?=
 =?us-ascii?Q?/6jw75AkhPgqYXRj7NFLykdKyizJvBXT2fKnQl8Hk4UQr/HNRePw/Fs9UGS8?=
 =?us-ascii?Q?8IonkiEGK6XnsHpTmWECFKPxi/Hg0ZMEQ4hfbhkQ0fuMpTUoVfI7bEKiNqlz?=
 =?us-ascii?Q?1+3afUzwgKm/xcOi0ohgJ7dQFxlLfCF1uIZAN8eAgHs0+jF3BiNgkt8d+SKv?=
 =?us-ascii?Q?VtzS7KLfbz8M2TuQUk/tXkhAfD600JyI9ldYXQwFCt9f+TzMnMO9pTVgm/gP?=
 =?us-ascii?Q?RCmPg6tSFKTpgXRIC396QrYeH6DiR9sLMdwioLTAbDuUrOBp000flMQXxkV/?=
 =?us-ascii?Q?RntVhnBLKxHWcxlf6UoUOtllaU4MeGTMNu1fsE39ddJe8ByIl55LX8iJuy2C?=
 =?us-ascii?Q?t7mXVxlWMbGAtJfTSmqYpROWbVgttMdJSzgZ+gjI0T6Rnyv2HLLnyy4mmsPY?=
 =?us-ascii?Q?FmLlVaETPH728zhWwLYbUUPyE9zvL73X?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8NQU2//8PvZrkUgG/3IphWUUkTkE8406aXYTZ2Hq4GMmdP23OllT5FxPxwkB?=
 =?us-ascii?Q?xoIkIv40PRnf/h02Lv6puTADNAigQ4BO/dlELZuy1BJu3pbMlTkWvRV7ttzT?=
 =?us-ascii?Q?nvIeQytEdH8VK7Uhf0u0TqaOwF3tbAWjXThC8Vp2I/9RAGOYlPEq4sXtHB0K?=
 =?us-ascii?Q?xY2cd+s8uhPwrECQRzDFZaD0nBlYyHi/D2lkM2RVW+SSjdP2rVMbpeehLnh1?=
 =?us-ascii?Q?AeDBxjlSDftyQMHBXW0r0OL5Rpp1RUsSnrtgWZWzNCAWXYeD4Bem0IXwFm+/?=
 =?us-ascii?Q?NIi2YkLXTREXm2oc/JkxQ6TviYBM9Cqq++EXi/Hc4uVJCSSRPX0v5qR0gy7T?=
 =?us-ascii?Q?AU6xeeoVFR2LSJ5Zb0cslPqI4fFGNceZ9RjwTDogRQzx2FFlfLRhKALMcmy9?=
 =?us-ascii?Q?j6064QXTPptUYPJSFkv1B/1qOgtclb+Fb+q+1iCvOM0AUmTqgTwcyQoYvdWS?=
 =?us-ascii?Q?wp9ifn7Px5w6oGlrzEVyXfhci2WU5K5K2E/CR5KocAWi44jfrYTQ6tNFGBn8?=
 =?us-ascii?Q?S6LFAup1lhiMCpdG8tQDM/whYNZzA9XtVYmvCNAqJ3yVTuEa6RjXUTnq93tM?=
 =?us-ascii?Q?JGgqZADor6VHkxzOWhQuvP+dy+avH9cXIq5nfSa3yXD9hVjaq7AyRg9XhVaI?=
 =?us-ascii?Q?ZLZ7SaatEX4fWBzX7ImHoc7XOkEMDDi4HUeqdqPPGMHwf6+4AAiTVKRIY13h?=
 =?us-ascii?Q?8Y0OxmKUT6SsvlniRpMyxat2JNcsY1gIf4UUsvi5Qzw/2wC8q05LE1CJK6a6?=
 =?us-ascii?Q?iEZnSRfVtzaF4/xkWzserTc5WF98NVQWXGOdt/lb1A351Fb5bKWNjn3el0Er?=
 =?us-ascii?Q?bhBeXIcWw8dJx2LgQ28r7QFEuQuXyw8nq8F31ePSqhITJq4aDz8MbAa4wL1u?=
 =?us-ascii?Q?lUaZjcfJ3ukWCVYFmAbJtQebZ1+cUyKv43uc5JISbWHCPBGB1vHplxw3uUMp?=
 =?us-ascii?Q?Qct2KAEsPI4SPpfaO/99TVqK00FsvDZcZ7qzDWJDaRbW4G0FlMFBTN+rXu1Z?=
 =?us-ascii?Q?QeKLyxL5Csgz16fIk75n20aakhnNP4kTtxCQvK4uCeZ9aFDJd9miFaRDqdxj?=
 =?us-ascii?Q?JQmhzba70vHDUUbQPBAYc8M2B7n2ZE9B2gC++RT9iDM1JBjXQzBDQp6oVNkO?=
 =?us-ascii?Q?ZlQbaA4SVbLuZUSE3gL3v11upPSnTujJ+eEo219wn3GyhxKgR3GvQGtEK/DK?=
 =?us-ascii?Q?Ssj6X+xLZxn7JcTb7NzpnJTpMJ9cNlahvJuDSZ4ZK6ZW3UZRjI9Rohv/ZUDh?=
 =?us-ascii?Q?60pMb1QXMoGfKRz9V4ogoEA65cU9IX4fOLywo06Hxm1UOArSo91eCynfQ3q8?=
 =?us-ascii?Q?VWQNRIRY98yAc9lZwogbbGBw3xL5SdoiszAeiKXmSnZJWcCpchar6ZXW9zIX?=
 =?us-ascii?Q?LVKxvCA6Vsga1GxxVGIRy8FtXzHJI8m1r0Mr2MM9UvXS4ChwLO/FpvKAe3fv?=
 =?us-ascii?Q?tcrgotp64A+DSQjKAx5KIUGGLPOhGcHmeOuhPEyaaqz8xcKfL7UTQeVdGICq?=
 =?us-ascii?Q?53Xzt1x4A1P1h2sxH2qmpWZmBRKSlLwvL41dfdjAXUO46PIMzgwA4cFSVuZT?=
 =?us-ascii?Q?VQJspyHnjAKtJSJqXX4aIhj/36nEoxyKBiopTKVf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8f9590-153e-4848-0632-08dd31380121
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 05:31:16.2859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d2gQYvIFRs/IA/OembMxuGdcQcjB0kdX5GuV5byDXBZGVkNyXd9lQrUzoZx03qUaG5W+DsTgy7oI+NpCILdkxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9822

> -----Original Message-----
> From: David Lin <yu-hao.lin@nxp.com>
> Sent: Wednesday, December 11, 2024 11:53 AM
> To: Kalle Valo <kvalo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> johannes@sipsolutions.net; briannorris@chromium.org; francesco@dolcini.it=
;
> Pete Hsieh <tsung-hsien.hsieh@nxp.com>; Chor Teck Law
> <chorteck.law@nxp.com>; Jeff Chen <jeff.chen_1@nxp.com>;
> kernel@pengutronix.de
> Subject: RE: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to =
support
> iw61x
>=20
> > From: Kalle Valo <kvalo@kernel.org>
> > Sent: Thursday, October 17, 2024 3:49 PM
> > To: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: David Lin <yu-hao.lin@nxp.com>; linux-wireless@vger.kernel.org;
> > linux-kernel@vger.kernel.org; johannes@sipsolutions.net;
> > briannorris@chromium.org; francesco@dolcini.it; Pete Hsieh
> > <tsung-hsien.hsieh@nxp.com>; kernel@pengutronix.de
> > Subject: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to su=
pport
> > iw61x
> >
> > >
> > > Honestly I don't think adding a new driver is a good ideai, given how
> > > big wifi drivers are and how limited the review bandwidth is.
> > >
> > > What we'll end up with is that we'll receive the same patches for bot=
h
> > > drivers, or worse, only for one driver while the other stays unpatche=
d.
> > >
> > > I even found some of the bugs and deficiencies I am just fixing for
> > > the mwifiex driver in the nxpwifi driver as well. So please direct
> > > your effort to improving the existing driver rather than putting more
> > > burden to the maintainers by adding a new driver. I am sure this is
> > > the faster path to get the necessary changes upstream, plus users of
> > > the mwifiex driver will profit from these changes as well.
> > >
> > > Of course I don't have to decide this. The wifi maintainer(s) will
> > > have the final word, but these are my 2 cents on this topic.
> >
> > Replying to an old mail but I'm with Sascha here and I'm also skeptic a=
bout
> > adding a new driver. Especially my worry is that after the driver is ac=
cepted
> we
> > will not hear from NXP anymore and the community has two almost identic=
al
> > drivers to maintain. There have been cases that after taking the driver=
 the
> > company disappears and we (the community) are left maintaining the
> > abandoned driver.
> >
> > Also I have not seen any convincing reasons why a new driver is needed.
> > For me much better approach would be to extend mwifiex like Sascha
> > recommends.
> >
>=20
> We understand NXP had left mwifiex unattended for some time, which has
> caused a lot of concern and trouble for the community.
> We hope to address the concerns by clarifying that the NXP driver strateg=
y is to
> contribute and maintain both mwifiex and nxpwifi
> drivers until such time only a single nxpwifi driver is required.
> Our approach:
>=20
> *	Maintain existing (up to IW416) chips in mwifiex
> *	NXP will actively participate in mwifiex driver to address bug fixes an=
d
> review patch contributions
> *	Support new chipset introduction with nxpwifi
> *	Starting from IW61x, new chips will be supported in nxpwifi only
> *	NXP is committed to be the maintainer of nxpwifi, and we have long term
> maintenance plan in place including regular QA,
>     bug fixes and feature enhancement
> *	We are open to have discussions of any weaknesses in driver architectur=
e
> for purpose of enhancing the driver
> *	Keep mwifiex driver in "Odd fixes" state without impact by new devices
>=20
> The above is an effort to address the community's concerns about NXP's
> commitment to nxpwifi and stakeholder collaboration.
>=20
> We look forward to your feedback so we can move forward.


Could you review the proposal and provide your feedback?

