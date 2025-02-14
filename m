Return-Path: <linux-wireless+bounces-18952-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68476A35693
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2025 06:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E07188FE32
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2025 05:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53C6127E18;
	Fri, 14 Feb 2025 05:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IPa4HppA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2048.outbound.protection.outlook.com [40.107.241.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E80718F2DF;
	Fri, 14 Feb 2025 05:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739512378; cv=fail; b=FUo0DstGrm2JHZ2B+cMcWncbXUy8LQ/ih+U78Fjw4cx6LhyqrSt0x0re1PCfQuA97Yczj4GSbYvra+LEYtUukfms0BG3m4o5Xcmi3f3AOfps6Jw+Zqs4mQ0BVPl0CxdfZGsl86e142IiszBE1EUpePUdepvo4atAJpbYJ60tGl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739512378; c=relaxed/simple;
	bh=2e3VvnaqsN1z5is/5OPQ6XtCIWJXLG6Btin7uSgLcO8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RCZ8Bi6JQsjDb8y8qffDlPIWjHE2ykOJGKZ7YL+1mfIJ6nn9ReKfneA2lqqM9RgdNMn/elnfB/KiKDO/uykZaOeevqX5rJDM2tUZeF/zIrcHkPeud+YJhPkzqg20/4z2gFmMAflrUS/GFId2HmD7u0r++ffMbTZR1PWajvVgB9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IPa4HppA; arc=fail smtp.client-ip=40.107.241.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGUmt/9WHtEkj9BWNj11HXm/HC+hNmWeQz3cecNTyQWNGCKBjXTQHEs5cR49i8ofRubWaQKmCIRlKsPdpOmFdPHzmIPtex9SE0tBHrmPYnPNyVD82V6fKEgSTIa1V6yJazYun96RA8nUZuHpv2cdei2BoThDaCLtWtkAcrI8jjLoz5+Id69ou92rG5DSv7UZaWNJhb4N6RwCqHIdjmDXnCC4aixDvWN50/bdLoYk3K+fDdFvI/OUgEnJHLPWJy43WI40i/LE332anuv9oxub0xum5K+W1ckVZ0vdFLW1+swtV6YulxZt/uOX9xxXJfz2XGdx08NziLGpY6DZoUsChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+XrjN+Axo+NZ10qEeebZ7soyaTnGLksS1g04lq/254=;
 b=KjK4ou7EByIPvFV4ofzaE5wOKBR54w4KHdEDJ3a3GWGOZKF0LDKk2kP8DXheptu4JgnCfgxZyAYwvfhOwxtBAhA1hVMbGrH6iCVvOgQaXGbuqAuZzGG4H/F6GRNaCNlEMr+ojTmTGRBuSNGQWq4WNKHeMIbEras+JKDKe9uw9Cwzx9XEOXw2TRzG2EMARJDtXuSvMZcF4dpZM+8mSCwYBGUVoLzwajorFpswyeRvcpQnr4Z0MJK/OiWKcpZuv6y2YWHBp56l3q8kUWEJaMjJjaQqYIHgf9BWvskcOgOhWQ64BYXEavW93qMCKlPt/JDoiGRwfPmheCHSZ32yodkJzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+XrjN+Axo+NZ10qEeebZ7soyaTnGLksS1g04lq/254=;
 b=IPa4HppAQKHiiyprCli8G5LYpsMYN+spVgO2MPZ0VpKMgmkQsW6pxpwN9942BXQuHg1aYaJwahGM1ZF5R/LGRlKvJTVjq+Yb77E6SbLducyZg7IJUFIRhKAP+jI+KWBBYtoDa0XzZSw1vzwWZdDTyT+2h72S6QBM2HMcXRlXExv7dUoyoD4KVPq5zOZQAHcXAwUwsV1BOkU839OVQN2kMHRKFotJ3CZzjpNce4dmMciyyTUYmgtDLCHpbwh7iiUlNfKCoWgu6UJ7hKZvbZGipvq3uAHg8SuN1yn6Yxu5HgFua3BZkYYhAPiWE43UDjGgBmrGM+zupWbaUIxy2Hmt/A==
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by AS8PR04MB7816.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Fri, 14 Feb
 2025 05:52:53 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%5]) with mapi id 15.20.8445.015; Fri, 14 Feb 2025
 05:52:53 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "francesco@dolcini.it"
	<francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [PATCH 00/43] wifi: nxpwifi: create nxpwifi to support iw61x
Thread-Topic: [PATCH 00/43] wifi: nxpwifi: create nxpwifi to support iw61x
Thread-Index: Adt+or907DHT18kmQfuGp1ZlDN7EoQAAAsKg
Date: Fri, 14 Feb 2025 05:52:53 +0000
Message-ID:
 <PAWPR04MB991006F5D4C0D82A4153C0069CFE2@PAWPR04MB9910.eurprd04.prod.outlook.com>
References:
 <PAWPR04MB9910AE0CBBFAE748D265EAE09CFE2@PAWPR04MB9910.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAWPR04MB9910AE0CBBFAE748D265EAE09CFE2@PAWPR04MB9910.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR04MB9910:EE_|AS8PR04MB7816:EE_
x-ms-office365-filtering-correlation-id: db50141f-1170-45d9-38a3-08dd4cbbd2bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Dedjrpv2J7ajs3AfHwtQSS+jr1vtBjbNFDOTh2XZ2egiKQIFvSyemAIUrTQL?=
 =?us-ascii?Q?AjWDCTibL6QUQi7YBT6xt3smZwKFUH1SkFpqEiIrz6FYT5RDH+wsu9KCLgCH?=
 =?us-ascii?Q?0VoU46bqy41PGsD64OA4bsI6ZO832rwLu6wV2Ak0jq3uGM/JjNpktsjcwQQ+?=
 =?us-ascii?Q?GmYINeJJOMPFOnqczsPP6Tjml4A2EgJiphlwvafs6AbklL8jQBoivP3zcIC3?=
 =?us-ascii?Q?/J6PbRHmR5CXAVG5txd89xR1M7qe3xnTY/9WDj4mnhZcODZytzYTna5x9GLr?=
 =?us-ascii?Q?Z/kXz8sFIUABivdYcEUttvnyK35ixgNk/y+tu9nY3dZTORUoW8i1FEEaqTfr?=
 =?us-ascii?Q?cCUk/KDr85tis4jld+Gta7Na3PrUdMhSS0XZECG8zL91LSHe2L5Fx+ZTg7jS?=
 =?us-ascii?Q?f3xQJKUWn+iHMrW8vb/fpRTPqRqMietHEq5299Pur7dxOdiFMpFltU3X1GJ/?=
 =?us-ascii?Q?m1Wj+aLLolJWiEyprCnk4NZDzP0EJ63zJZanVGr0+VbvbNDrgK+wy4+Ex8tg?=
 =?us-ascii?Q?yAWdGTqCbTxy/RKyhtHnw0vGMOz2MwMbGHHlnuTQc72M5Am1P37Yp99Sm4ks?=
 =?us-ascii?Q?BoI0zYDPgzGcNgDctgAtnpiFZiSKdo7AIlv+Q8zulOZd2qvKnyp307dIzURo?=
 =?us-ascii?Q?esQGUsmgAQkTZTUEajJzEeOZ8DdCGSrhgzZMRPIZwOUVpejhHooF7m05q56t?=
 =?us-ascii?Q?J906GdgMr3hs4iWNfeyVZ8XNx6tkZEP54BAFkcbT7+bYdj2Rgok37MqfCr/5?=
 =?us-ascii?Q?KLLMVAtEtFdjYPxZAgPFbi+F8BbduQmYfVVXI81jNy5LC3kNNLoZCNm/Fszs?=
 =?us-ascii?Q?zE9rWeHqyEcjttC15HvhVwu8Bc+sEKxIypVNDty6yfN3nuuXTnSxMnC/Yoh8?=
 =?us-ascii?Q?mlBqnvO9qlvYS9mvryOuq8iaVWvuyzsfIvqpHbqvB18jsJZYVFr4wLPfe9zb?=
 =?us-ascii?Q?9d6/bD3NzwAMDMWBdfFF7EJLmBoYV7JAx6Za4OSgi6QKtz1kjK100q9XPEJZ?=
 =?us-ascii?Q?x1GiKxcYrFw5JG8IdJfhDOiN1MzuJMveLPIg3i4XjCcYJ8apy27OIEMoYInB?=
 =?us-ascii?Q?4fTyItO9/nK7YZSo2bHVdnD1qUPEYkbvn0PRWwtSeJEmQTPgfmB1IltcRXiK?=
 =?us-ascii?Q?rdgJVFTSqlkBnSN7hfyiDFU6T9Qk8FFT+iir2Aelkk3P0wtEqxmccyapA7Gb?=
 =?us-ascii?Q?2ec6zSwkc98O3KmcUaiKE1pA3F3EMaDDRe16yLo9WLcMtqKoaLAHUZIShr5v?=
 =?us-ascii?Q?ssmWP+gRcKj7UQTcpTbRjRaATRlijRi0ebAXgZBTxg7zGmd79A66LuM6F0VE?=
 =?us-ascii?Q?AF5aN06ETItMuysURL0ZRzWAK94RrqEsAhUGyGvgmhv4i8ivGoRfRdWyxQ6Q?=
 =?us-ascii?Q?7Ow5t8UwZKeN6br17pdjO1ELoXROD4LIrtBXMZPlfuMNvlJcQRkPrZu+UE1s?=
 =?us-ascii?Q?Aop3SHpM13D1Q0XVSMDYVdvX2vQ+s/5t?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8RgNtUKk6LfOrZip4gG4rE1MKARHP7/KleuKE3yAUMsxl3wk1gc1a4iGvYnB?=
 =?us-ascii?Q?zLqq7F83NLvq0XRoXOIrB6Hoz4M4BkHzjhAvigJFbnnmOS0JpvG2SFbNTsZB?=
 =?us-ascii?Q?o94EmHJkQqgodA5LLywD8svdYOfgQU9CGh3gBF1x1XIJLQAUUcQTq+l9zH70?=
 =?us-ascii?Q?ruHzqyse+62syToaZhPxmt8K41M06BkavZTxvatyMRSseu4fTQRoirLBQzts?=
 =?us-ascii?Q?zesLmdQMB4iEXiJaMEFeiLUK547R2gf19IR0PxSDKYUIUhpj8WgOZ3jgXNni?=
 =?us-ascii?Q?xJfyQItdfbxROTQtsSpDQAzEMngp3f0q2PHpGsgOKvFdxHC653venrLvR5Sk?=
 =?us-ascii?Q?6jQFAF9fDrKskGvcq1mHPIePzL2OXa8pFO5q8xsjQ/QhXNQMgFP5AYO69mcu?=
 =?us-ascii?Q?7WobsCQXYaQqrSkAO9XEuvnD8qA6daf1Cej4DmRtk5MpkXrSbkHHKW40Lsws?=
 =?us-ascii?Q?dxVNGtbVrdRw3N2F6qbdMuFih8Xcqr1liXVEktxmKmZXIvDZ8BosuJC9kLv2?=
 =?us-ascii?Q?tDRhKJ4lKzncaY1cxaqlFqsRFhLsKk2lViQO+5PdPSjCcYjyU54KUjVX8yFw?=
 =?us-ascii?Q?pStNCye7cciFctca1hNrwtg9u8q7z13N9cMJKQpa7PFLXIPltmCP6X+Oe7W1?=
 =?us-ascii?Q?z45FwmGJEm2bvGwFNUFFa2Ft7ELxvEWJlkb3ahaY3ZsHJx5WchZSU1QSutam?=
 =?us-ascii?Q?rQeVYZGE0YtgLe9C8rvwrhz5qZdpHlFYhUqDGOvxpNSShUzNrwF1zqXwwr7i?=
 =?us-ascii?Q?M2UM5z0a696g8+oUw8k/RHQxKrs2GK2Hn1Ajv4pIzUvYZmXtvGXj0FsFTxDw?=
 =?us-ascii?Q?k4to5gQ1QVv5VaV6T3uDsUnt8Xz+n88lRxls8WW6v05ZgLUZVi4rdk6mebGI?=
 =?us-ascii?Q?01E9ub/jxDwkv2hx1ov11QsdLngbsIqLgWSKNqWYtNA+Y7naD8Qn1smH3ECD?=
 =?us-ascii?Q?Nyh8PAqSvoTT/nGjTT7+9K2a2KqdgcXCN9L3lxFO7RPVMMQ+2Yck0SffqWEI?=
 =?us-ascii?Q?PXm9XoPax2qGrPdvus/8R7EviGFTJcCzUkzFRqPhGxLsx2mGQxF/OnrVyE/h?=
 =?us-ascii?Q?Kfq60L8UJYk8JNXGp6Eac96jeYNiiexhUlqFL+P8QWb/bxCWkDnKnuoJ6Qkv?=
 =?us-ascii?Q?5UVj/8X82xDyAUZol7GWeFY8eWNxj91DjPMCD6bWnSyjiqu1j1yvIuOPFIjA?=
 =?us-ascii?Q?faRHDbrIxH0rJxnnQ5x+I65r5NthOhl0qbd5IEE6NuqBr77VHWjpANdHwWmI?=
 =?us-ascii?Q?UJzei5QD5CkL6LbA9dEfngFS691+iyQwqavg93nD5CY2uyhyedwQ8pTIoAY6?=
 =?us-ascii?Q?o7FhitLZSe1X65Z8vPkTDF4ERW+FUjw6QEfk6Fru17/PI9EEA59tYjfLlxDp?=
 =?us-ascii?Q?J5TvwGqbsk8uWrdh6hmXcxOekYuZWj5SlwlaaZBJ3jHeVBVsnSZtps965i1u?=
 =?us-ascii?Q?BrFsK0+0eAE2jkPYNfcUctV2BUePvB1ip0BEP2zQWfEPWtWZhpMx1b0CgHpz?=
 =?us-ascii?Q?dKTRZ11+POvvtTKgD/x8DH4tWdrRmfKuO0LhcVWAyThNeV25WU94ZUHv725z?=
 =?us-ascii?Q?zxJ5j6/AoHiUglH/VYYXjKlbyQ71TN4zltJ2G2Mlwn0FmROVmdTM9kmCvaq9?=
 =?us-ascii?Q?y9D0ghtgl7u3nQEdvVW8Kt9KLQtypVWE81QwuPnI34iD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: db50141f-1170-45d9-38a3-08dd4cbbd2bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 05:52:53.4420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZbdvkQ8DC0oEgjRIkEzTV1ijsfcHLNHKbW9pzVVxlSNatNb3XoYNnxmJKavrlnkrZPDEjE7kUMOe6enL6VYr1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7816

> -----Original Message-----
> From: Johannes Berg <johannes@sipsolutions.net>
> Sent: Saturday, June 22, 2024 2:20 AM
> To: David Lin <yu-hao.lin@nxp.com>; linux-wireless@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; briannorris@chromium.org;
> kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH 00/43] wifi: nxpwifi: create nxpwifi to support=
 iw61x
>=20
>=20
> On Fri, 2024-06-21 at 15:51 +0800, David Lin wrote:
> >
> >   wifi: nxpwifi: add ioctl.h
>=20
> even the name here sounds questionable :)

Renamed ioctl.h and sta_ioctl.h to cfg.h and sta_cfg.h

> >  48 files changed, 34928 insertions(+)
> >
>=20
> This is ... huge. I don't know who could possibly review it at all.

Since this is a new driver, any suggestions on how we can make it easier fo=
r review?

> A quick look suggests that it's got a bunch of things we probably really =
don't
> want to do that way any more, like
>=20
> using semaphores in a wifi driver:
>=20
> > +#include <linux/semaphore.h>

Removed in V3

> having a bunch of (sometimes wrong!) element definitions in a driver:
>=20
> > +struct ieee_types_aid {
> ...
> > +     u16 aid;

Fixed in V3

> embedding a (default?) wireless_dev when clearly the driver supports more
> than one netdev/wdev:
>=20
> > +     struct wireless_dev wdev;
>=20
> Having multiple own workqueues is probably also unreasonable:
>=20
> > +     struct workqueue_struct *dfs_cac_workqueue;
> > +     struct workqueue_struct *dfs_chan_sw_workqueue;
> > +     struct workqueue_struct *workqueue;
> > +     struct workqueue_struct *rx_workqueue;
> > +     struct workqueue_struct *host_mlme_workqueue;
>=20
> as is a misnamed mutex, but really you could use wiphy work and likely no=
t
> have a mutex at all:
>=20
> > +     /* mutex for scan */
> > +     struct mutex async_mutex;

Consolidated to two workqueues and one Rx tasklet in V3.

> but also simple things like not wanting to use ERR_PTR()?

Addressed in V3

> > +static int nxpwifi_register(void *card, struct device *dev,
> > +                         struct nxpwifi_if_ops *if_ops, void
> > +**padapter)
>=20
> (padapter is an out parameter)

Fixed in V3

> Why random numbers for cookies instead of just assigning from a static
> variable:
>=20
> > +             *cookie =3D get_random_u32() | 1;

Use static variable in V3

> Open-coding -EPERM?
>=20
> > +     if (nxpwifi_deinit_priv_params(priv))
> > +             return -1;

Addressed in V3

> Using -EFAULT for FW errors seems like a really bad idea:
>=20
> > +     if (nxpwifi_drv_get_data_rate(priv, &rate)) {
> > +             nxpwifi_dbg(priv->adapter, ERROR,
> > +                         "getting data rate error\n");
> > +             return -EFAULT;

Addressed in V3

Hi Johannes,=20

We have addressed the comments you sent on June 22, 2024 in patches V3. Ple=
ase review and let us know if you have any additional feedback or suggestio=
ns.

Thanks.

Jeff

