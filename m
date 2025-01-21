Return-Path: <linux-wireless+bounces-17795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A616A182CC
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 18:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 599917A439D
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 17:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1921F4730;
	Tue, 21 Jan 2025 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bQMLkJRw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC05F187FE4;
	Tue, 21 Jan 2025 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737480128; cv=fail; b=Qzfj5DSwYb2Rs7AAGBjiHik+ucDpMbi/t7RZqrZ4wWEth748i0tWqpACml/5dM5/1idKlVXcQOcQZjfWPXl35yM1bWOsJqgD4ccPG378TYjZLjVQp0/ytodUHyYCuNI58ulSfGpNwgx/X2wThLRScY/3ubKdKp2QZKXGaNQSaC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737480128; c=relaxed/simple;
	bh=1/NSooVE2qer0ZhdKd4scrpQUBW23seFmT77MXIWTbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Buwb5AHFTp1Z7W9FHpaWwmLuwk2Hx737+gPJ01ifz55TqWHqjZLNCb59wFuagSmJOSDNqYQcEntxFG3BBsQpSk5orVm4ijmQAGhnYdGFUeV1J+3greMi6fmjGmSBBA1Cuco/ASpVVDbE7y9Vbsn27GLqy2OegmB9ZfIn+atTah8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bQMLkJRw; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=an4HheaDUdmAguSoUh0VBQLvwzkb0+uvbXjx2PQnaHdgk+6DAaKKiYYrOM0rCGUXTsJP7SCjI4Evojq1ZUytzIhTOMlSxeG+RlIl1a/mwlRst4BcJEI4DXI44Ya7hwWwSUgmaNVqK/8S1A39QlEc4DPZM9b4+adR1uflFaniabUV4IA825ajb6bARkKxjJic7QyTHIyisfkrFygDhpSMjJIAwzJiXclrV06IzcNa4N8cjQSImCB2vAViw17SQz2eTMyMJspXS41+F5II+mZrtbjyKN3s1/fQ8S7wmkg/ISXID4ewjqq2CSRh5XJtU+MWzldTet+pr9Cz9Y2VP7ABXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/NSooVE2qer0ZhdKd4scrpQUBW23seFmT77MXIWTbs=;
 b=e+sd6xiJzBbodxaogzOft7ckdk3fetjR2nMuH+lkowY/+Kdh86mKGs+tv7TbPTh9C95Dpqyi+4RisRo40JuzGN1bHoxBGON/rYfu92GqEr817eYcGzo53pHZjXOdGcaIuBOaB4/6VB+ha70X66vaUClbG2q443FduqEqwPwLuIgpY+jL+H/SY+PDf2rssqmP3jmyCa1b8+7JdlJo1kYyvxj9leNgWH9XMYfNcy94JKXluUQEog9AUWqNdTb7uDXiOctj7HjwL8KavaZoVsyMurbkuNYxJ9M2P7gofyGNNANQUzicrxrXhgHnqvjCoIqZgMZi9lVZv0YYHC9MJbVdJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/NSooVE2qer0ZhdKd4scrpQUBW23seFmT77MXIWTbs=;
 b=bQMLkJRwgKb46KZZ82soJrhZvDPs5Zq+FiffSD0MBbhSIrX8bZlAkcwZam93bD6w+zSIBZ2+9IAJRoSyFZF0pZoPmPJq9e6xli97Nvie7rMooF5KR2FlgegQGSibn/2wbxyxPN5wnW1gMeEaOdD5kIespXiJu0I23ntfC2gk3X8QI5A2MfNehoqN/hI2mWOSpCS+zRnmn5kplUriH1bSzDQXHlBT3u2MNSNN17uhtdnVtXjiL66TWo4PhLDKFs3XEDcyow8G30p9oEUeZLFVl2BCWmDZpBYqBcfQZ/+NtKq9AeND5GdyxERxYj7CqLy0UGBDKl/CyVT+afSMEtBe+Q==
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by AM0PR04MB6962.eurprd04.prod.outlook.com (2603:10a6:208:188::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 17:22:04 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%4]) with mapi id 15.20.8356.017; Tue, 21 Jan 2025
 17:22:04 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Kalle Valo <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "francesco@dolcini.it"
	<francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH] wifi: mwifiex: Resolve the failure in
 downloading calibration data.
Thread-Topic: [EXT] Re: [PATCH] wifi: mwifiex: Resolve the failure in
 downloading calibration data.
Thread-Index: AQHbaw58ftmd6LoXwkSTnQBbUfa2L7MfmCXVgAHjPqA=
Date: Tue, 21 Jan 2025 17:22:04 +0000
Message-ID:
 <PAWPR04MB9910C5C4D84193F5BBD58AD89CE62@PAWPR04MB9910.eurprd04.prod.outlook.com>
References: <20250120074011.720358-1-jeff.chen_1@nxp.com>
 <87frldllaq.fsf@kernel.org>
In-Reply-To: <87frldllaq.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR04MB9910:EE_|AM0PR04MB6962:EE_
x-ms-office365-filtering-correlation-id: 65469995-a969-4afa-fe58-08dd3a401fc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XrHO5ncCH2aT05z7+6CXiPTtX4QjSKK43FGefiqTV3YzU2LknihhomcC/eJh?=
 =?us-ascii?Q?V6H+gAj+KcG7SKtVIx123dRXM3sJXIDCvFJR7EWi2JnQymCmNZho4XonQE6L?=
 =?us-ascii?Q?6s+O97KIdUK20V5glMXkziNN0yLdS9XjHQZtw7tMBgeevRU2VjMDY55Q/pDK?=
 =?us-ascii?Q?rQCR9FmN98OR8XykyBJMS8c4QdBwANFQOqLCdXfsn6EkAuK/VVS6vFMcAfdG?=
 =?us-ascii?Q?mTqzL6jPt6GChdNoPUMBqucy98kVmTTZjfDQjx2d9VyRT/eHAvJzvx6WLjuq?=
 =?us-ascii?Q?/BA2Heq8LdF2KzLCsoL+KcHQChiLdN/joGGPSvPKUJTg4Ha/42t2AQSMpBuf?=
 =?us-ascii?Q?To98gwgx64ZPfdTrRlA+74YH3VBbT3dqX0tuyaRdvpvXaJit/ch+S0JINRkW?=
 =?us-ascii?Q?Kne9S+oneyiDeMznAWm0ib2vT+6L57lUw78TEN0eSHvv463uO6zASgWJLYyH?=
 =?us-ascii?Q?PnJIUYGzgHjgU30b9aCxSQBC0YO21d0QqpQu7zBCS20ZVEhk4bn5fViYjyDW?=
 =?us-ascii?Q?6mXCNCcorWicakEb6SdJqXJ2fLoQYSfr1DHVsPZeQ9qZbWYtXrJpH5t30ijz?=
 =?us-ascii?Q?z7zYxje5OoqJy2zD7Lp+1mgkrWLpO9ui7+BhT2S9jWYBw4eblpVPlmjn3NZa?=
 =?us-ascii?Q?Z4dhlAh3DP5sCXm2O5r+vlzVF6RZnebo+Xoqg3frys+P7Uiq4yxfSjVZNFbR?=
 =?us-ascii?Q?EJc5mO1g3bGvUFOrVt4NkmHAeNMHOuvd2FrYSOyFpBMtfnJ2jwibqNA4QV8a?=
 =?us-ascii?Q?kdW2OvssVSdxFb1cSCEF0FZIfzkiV3faM1kEaGm3Shr7uJfQIdyIxMtNp2Fq?=
 =?us-ascii?Q?FW2Rn9/X2scHIPhSO1UZA37/FwTLEe/gV93E2S56Q9wWcTd20H3ZwE+yyP5v?=
 =?us-ascii?Q?AopqAwmmWLijfUPLx9XimEgmqx8Ms0r46kgX51YPphWG9AY2X+MVdJ0XmodT?=
 =?us-ascii?Q?joFDUh9lAY7lToYbLnZAshrIhQK7ariL2cj1XULRfW81/N0tdU3kbnxSVTDH?=
 =?us-ascii?Q?IpUW4XRGtpFeNiTPtzKGUp0IEtzNDt0cQCQLEBgHBrdMgGAy0dURFJDpm1PP?=
 =?us-ascii?Q?g41yxDwvpbg0qxnex7ZefQYck3CbH1a/fG0tJuOvsrv8VxcTP25RLelwet2D?=
 =?us-ascii?Q?kmG6/jO0U6YVUn5BwByjEz7wP9LWemHlA2aybXwkcn1erD7uTABZDtSHsHQo?=
 =?us-ascii?Q?5opHMSdaN2uPXyrp1fUGpnVp8W+DXLUXfo2DQJ7zVVhdaYWdNZmGb6p+MJDW?=
 =?us-ascii?Q?rVcbzdPFL9NKOnZIAwHW1RfbZGf8NlQCBGxnzvbiP3f1ovXjfQS1Rn8rDwO3?=
 =?us-ascii?Q?IHkib/LbfWaB8wGOxC1qTQqZEGIjvDlYgtBXpmzZKKpL08yMA0Xi14vQ3i0m?=
 =?us-ascii?Q?ah0DkXYQ0l22/ds95dgZPja1zYMkFGxG6wssHeup2VjB4qmTHQorP9qsuI2h?=
 =?us-ascii?Q?I11XjCi3md4LPJsfrum3EiHzHknAsg0d?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gr8J+tsD8XZQpnLAwhNt1k8FyJE/Lk3mtk0UkP/v/QVxPZcLkxUdWLKVv700?=
 =?us-ascii?Q?vlEWF+pp5r4O8jTBOq1JEhwuuKyX6P9hkV2yFVrwh61K1W0ES+IyIeE4pLRF?=
 =?us-ascii?Q?xvHhOLJ2zjh7m+1zcZYhsyvpwwFdXw56YNvEYT8CYHP+8vqG+tH9mwg4Kmz/?=
 =?us-ascii?Q?NRVp0JIvwrg34Iq3Fum69uHnNhehwEaIZMcVgKmeZDbdf/0m6airn46Bt78l?=
 =?us-ascii?Q?nMfi+dAx0i3PuN91cVqBxg8nyakwA5pe/g0fOlRBHh3ywH4u7kjdB13xSH3v?=
 =?us-ascii?Q?rvKDYHVwLoFPn9/wV4799vAgNsQKym0tqi3nz2XynTcYECawe0DhwqYwY3Qq?=
 =?us-ascii?Q?Y1jNsYQoNHNF7vqQdJxjfzTSyoLLL4pdfkt8yv5A5zz7NCTOA8Os3gwvQyv1?=
 =?us-ascii?Q?P4G+JJ44vNt9CE0wGMfn2dWgDu9lCmIo3iQ4siIdalQZ74P1NZtHzB1I47ep?=
 =?us-ascii?Q?vsoezbf7aiP2KJZsyG779kl5Q0Hy6BTXSiMdNgZ48mvqicmg5+ZStprRs6DF?=
 =?us-ascii?Q?v3Ic5H+vyrppsRQXmv9eq7B3sepdwjdqe9t7hKxdBw5fPGEX1T1wp88cNHwo?=
 =?us-ascii?Q?TNepeyk3PR7CoxTYRLaW9oQVGEqe9TogLau3TVZvIofByU4R4+47X6ZT0Oib?=
 =?us-ascii?Q?kByjeTcZrvxxIHnOaDZwgjO/cuWjYc8mNKyrJ85WavkZs17P4EkFAQb37Niq?=
 =?us-ascii?Q?VQPrnd8HE6d48X97XN6OgsSTdZrds4Vz5TubzhS6lyT14nBcJjv+dT/BPAr+?=
 =?us-ascii?Q?Z/paEeVPmlQY6KTDPSUZL0217XSIKu0AlhfLqOJKQw9x6VI6tX50b1KX+k65?=
 =?us-ascii?Q?wqL4DzHsbd6vyax+SGmBJ81ELghq6ybtNP0la40jCz80eRpO+/6a0oMLQuVb?=
 =?us-ascii?Q?PAq2lo73GqGgil7PE12A29fT6q9feE53z0OC8KEN3fyrW+P58RYkRORXYE3r?=
 =?us-ascii?Q?aUjDEPUAcNpV4wXu0YNyFIzYf/Y2iM0LL0cSrxUm5pKLJFJ7YvdgJcoF9I0p?=
 =?us-ascii?Q?O+fGcHJJh+j51kZJ93CiDUrKHT04d4JfX51yPQZH5lMJ/EhAVCFajAKqZlZJ?=
 =?us-ascii?Q?8CLom6j4es6Nar+WfxXjxG2u38U+O23DYvKm3J7a02JT27mnHLYMrmEbmLjH?=
 =?us-ascii?Q?7Z+gKjMb1fp1faOPJvjBbvY+p1pXlqHmpjc/MBNyEs0cOVWA1DPoHvQM/fk5?=
 =?us-ascii?Q?+DItdDxeZU3LxUAc7q44OiwQjWZgbYhicCxS45zJwp/IHqzOLfo9lGsFSDp4?=
 =?us-ascii?Q?ZfrSqvovqTqY71480wbLc1GP5OGKUjJ0n4RHnJME1XBQFe1Rfpj9ZFQN8H/J?=
 =?us-ascii?Q?a41wwniKbqQunT7u8B9ySEdAbXxQBpm1UL0DKhb5h6EARu410BVLHVTfTN3a?=
 =?us-ascii?Q?VCIFvlS1h516SNJtU6zaHeKtblIthgaYjjEUVmNK4cnq+HPYHk9bp0cvndbS?=
 =?us-ascii?Q?JdA87M6oEhXL8sHDs4cqsitOxJz4RqDorx13RLxdrmc/e6tWWMWHTVxx3XNv?=
 =?us-ascii?Q?kdclwKisiqGTBGsHqmiOv1iaZWZ7Tx7HFysKTiDLzi1a6WOA8hPNbTzVGQ7R?=
 =?us-ascii?Q?z5/HA0DxUDaALd3tmS+VbPRfjrGSBPnDksbL2kXz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 65469995-a969-4afa-fe58-08dd3a401fc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 17:22:04.1668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dESDSRKoMzoZvP6VB2vqCKL+BVz117lynRlgLNbciAIXYnPxcoVRtA5kImJ0dd2f6jng6YGx7TvmrPPAz3/NUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6962

> -----Original Message-----
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Monday, January 20, 2025 8:31 PM
> To: Jeff Chen <jeff.chen_1@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; s.hauer@pengutronix.de
> Subject: [EXT] Re: [PATCH] wifi: mwifiex: Resolve the failure in download=
ing
> calibration data.
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Jeff Chen <jeff.chen_1@nxp.com> writes:
>=20
> > Correct the command format for downloading calibration data.
> >
> > Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
>=20
> Like Francesco mentioned in patch 2, please also expand here why you are
> doing all this. One sentence commit message is usually a bad idea, unless=
 the
> patch is really trivial.
>=20
> --

Hi Kalle,

Thanks for review. I will add more detailed descriptions.

Jeff

