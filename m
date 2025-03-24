Return-Path: <linux-wireless+bounces-20775-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D749A6E05A
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 17:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4629A3AB2F1
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 16:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D0E2641CD;
	Mon, 24 Mar 2025 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d/wDbMz9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2081.outbound.protection.outlook.com [40.107.241.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB562641C8;
	Mon, 24 Mar 2025 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835457; cv=fail; b=G77kDEFVn0YRna1nfMe5xASFnULGAJNWH8PxDS/BfEALe4CWVuVWGxdHuWew3uGyJLBJ81qULNGc2zQG0U8N/fiGhaLo+htx9I7MPRsTmEgb2TYo8yrW/x5zDDzv0OdUUW8MD+3+KtIh6QfNmGzaUV2HLfsojfHuQOn4bmWlH/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835457; c=relaxed/simple;
	bh=iNrbPsuQa6EdnOW1seeG5YzOQ1ZpLhug3xAE1LS6gHs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NPos3HjKNJQmiBErm2Av/2PTGJY1Zdgi6d/ctDnM//USPLB1SnsLwLiuQyTNnb/B+RliUYEoU7uTAvOYeUPnFPe5npAXwt4Vt+oPVdWt1mle8R5YD9/ZWkjahvdM3Wy2M7OSl+HemmR41N1cxtk0TctFAZGpLCCqZym15zwrO5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d/wDbMz9; arc=fail smtp.client-ip=40.107.241.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Po1gXZoWDw7i5BbHdjFjAWKkDkWR+q378fL83Cra7+CUsdsZw0FKj98PO82xHRh/PsThBMb8MavIgM4IMJ3SFCxrFxsfyAnp3Fd1HZX5zHl48E/lQWRDb9vyEvLxm+jkLll7hH8L39BEK6gxxdaj1GB5zbrO3mxzhVwATpZFK+se742xQWnibVw/6NrwFGdfFWcDEYjkhHMvxMGJMr5b029ezMNIyMfkiNq0s6wfJBTrWuaVW7f266Wt6AB6lqPHwl5QkagcGalK6ozYmMHd3ZpRg9VpicP/XoQ5mMP9TUPd6wDthRRfs56REAOFnhaNCT5BGSnOTFhnRXvZbj3p0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n24vKvYOxKZp3FjOatGUz2Phch0uOcDKFLgJ5y9bMK4=;
 b=p0WE/ApOTTDO1lvVbU7j5RAZZBiANt+NaYxom/336rwzJIGdnC3KlZEd/jeQW3z9t5ukUaidg38GZO1suuWsxbuGEHkiaw2Iajc3mdGAm/ylkhUx3zkiremjI+EnImbUHryiE+xjwOkujTxpWNMUjCGabgjEry+MRg6yfbyEeWNcmGdz0picIdyeG+ekFGSxsSd/FC7WlRdKGzfo4fRU5ya6qcaJyJyKvXlNzfXKe0oVKrRwDAP8acBcdOAuPUBNpasCPtKBAxqqwFAWNMwDK7eobiGgRVSaC7R94h5vBGaBMBoR3ogtte29B8w/9PLPFzAYrPYnS3T9pOE2UGNDiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n24vKvYOxKZp3FjOatGUz2Phch0uOcDKFLgJ5y9bMK4=;
 b=d/wDbMz9v1qkwsPL79LrX9K7VwkwWW3y6wU8ijefbhArrwtkXQrSLF5qdEKOwrBxIyN46vzKN7htEzAHmquU0OSs35b94Hh0QDd6vv6Pfb6e0SmkKu4aPCPLIWigzW3aeyCOpSZFe3eMfDkDn3T3SXY1tPQH9mwCQbthoBYUKxzJJAC689pYeFCkbJKHfWYp5hTYxIpOuH0vFRK0ZWtaN51jMZ1APSJWw24h4BgK6NPZGdWVODlDpL1d6/c0+SysfuQFs2y7i5Q77mapDpkvlhBWrtmQwLSL460V445Dqzajxw9GHxYTMuztoh+b2kTo1O/D+SIL31E9O1BSjTq8wg==
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by PAXPR04MB8624.eurprd04.prod.outlook.com (2603:10a6:102:21b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 16:57:32 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%7]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 16:57:32 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v4 2/2] wifi: mwifiex: Fix RF calibration data
 download from file
Thread-Topic: [EXT] Re: [PATCH v4 2/2] wifi: mwifiex: Fix RF calibration data
 download from file
Thread-Index: AQHbl8POAsvtZwMDWU+9/b7JncVaoLOB5dAAgAClRjA=
Date: Mon, 24 Mar 2025 16:57:31 +0000
Message-ID:
 <PAWPR04MB99100FE32EE2013D281691139CA42@PAWPR04MB9910.eurprd04.prod.outlook.com>
References: <20250220061143.1417420-2-jeff.chen_1@nxp.com>
 <20250318050739.2239376-3-jeff.chen_1@nxp.com>
 <Z-EDdrA4s5GvHKvB@pengutronix.de>
In-Reply-To: <Z-EDdrA4s5GvHKvB@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR04MB9910:EE_|PAXPR04MB8624:EE_
x-ms-office365-filtering-correlation-id: baae3c21-0254-4f4f-7454-08dd6af4f7e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yuGkj9jcK3Qakfz/FbpCqBFFRto/hi0+aMwoONJs1BCUtiP0jjv+Tu5DDGYz?=
 =?us-ascii?Q?u14/Zk1sbSlQ1M8kqDcVIs9YNGYXZxkAYOqKZOzVxNkFhQOPTFhia5q3BdsW?=
 =?us-ascii?Q?/J/TsKITtAgeZdGMS/od8aRQF6kR/aF6nsR5cHbQNtTBQuDABXAWDYR2LZ3i?=
 =?us-ascii?Q?dUX3oFSduPixjVC3VWnkJf0YSlS+dO8TiAioOf1dVCW6J+YtEp3f6XORgNDm?=
 =?us-ascii?Q?haFp1zQMHETLFC0Yvff+BfFkfwE1HNa+nqiQ3I8IZcBbx0FKFdFcOXRSEv/c?=
 =?us-ascii?Q?VkscDWh45VbLji3bX979TCvkTwsIxNWDeV1KahFoRneHLiAT5Pgh4J0pTz7t?=
 =?us-ascii?Q?Be05e0Tm4qiUPTiBr1BEaT3zla8zBlpHJ0/dDV29P7e1b5ySXl+JEFEkEBTL?=
 =?us-ascii?Q?gZeIMhgQyGefwTZY3DiV/Gl/unK7dJW/7pBgb7DozLef8lX9GQE/CjI4fxoT?=
 =?us-ascii?Q?Rp8pZsPHqBA4W+F+ey7kgT4mFWpRN1Z4ni4LZ5I+IrEne+Aav3jNN7oK4Jb4?=
 =?us-ascii?Q?oVMyGT/T7Sw7ih1bMs7g2ewDhdWa8grJ0XLTisLjPDDDhRSqGocRnzaCTP59?=
 =?us-ascii?Q?zsi5EMaM52Ot+4Wqhw2c5lkFO6NswuziVOUzxmqV/eZjL7+WvGnCLuOrQ5IT?=
 =?us-ascii?Q?2vtIkW5qQiXfkuHNU31Hm1neN2dU1hMsRXnpS2TktH948LGUKIbtBCvYONT6?=
 =?us-ascii?Q?b6nmebDG6de97116I1CpWjHcJergT2Mz/Hv3TucL6DksNZvg2tprmmpbbsPi?=
 =?us-ascii?Q?kGK2raxESSA16oEDkipjaU2/o66r+R/sEuNSdZ2twSRA3TDQyf7p0E1KF8jR?=
 =?us-ascii?Q?5p/AZYak4zAlFZm+kH/UGTYUZnqHmLd+a7iNE2PizyzG+bKPpnvyRuQdLiTb?=
 =?us-ascii?Q?lPG94jOzjeiis97J7xOpW1CGM3ez5SJyIeP69c8MfkMrqAE2FvfGpXSTcGIu?=
 =?us-ascii?Q?S0FKboVWcEY6ZHr5ao76Je0I4dmBt7iD8A14qO7HnjUOvQ/FJvd2z9SR+z4M?=
 =?us-ascii?Q?h1+Jfg+rVznhkXL1useR7Ru38dhgLXd5uJBwvxGXKtq87Klcn4xPzRNeGtki?=
 =?us-ascii?Q?z3O3ECNX4BF15/llA3bmYYF7cG5cnOQ19YTaqz2sXtaeq74fH+OWkaY9NSil?=
 =?us-ascii?Q?FzygD/HTp2FemNQs0hEAlsCJhdJNT19eF+RClWUZZPrEkPTt0xuj10Lrb3j8?=
 =?us-ascii?Q?Vxa1shFBoi53o7KDyo5ws+rIXe2XC0DbdJWKXzzzndPjLhYUH/nj7n8iFmgg?=
 =?us-ascii?Q?BNwskdxlvLodxRme6SfWg895zFYISay3HsxkD81aVmOw5oSvH6ZiYgqDuxAN?=
 =?us-ascii?Q?CPCQtA0rIZVuctnqLKINW2hNYzifgV8UVj2zHPdGj5HS/kUdts1MurkqObvj?=
 =?us-ascii?Q?eU9ih9/0NISWkHlt9UsB0TRr3JwHEZARjDbvQ6UJZf9SpUm5Tvn7JJLyAwmT?=
 =?us-ascii?Q?1y/rwiO/F+dTD92uBgCEWyOkZm+07XXP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kOIaaAuuKerqJSKW3wfc09Q0gc8TO7pD+EM6Ja+rqrokTXlJgJlVFhjhKA5o?=
 =?us-ascii?Q?1rSgZ7HzLEm4YTrPSGesxDHiMIjg8DQ3MhcH5G8gh+B/XgeK30iLc+VVjHd7?=
 =?us-ascii?Q?dNZoL5qyJuOR+XZ4qqRXrf/o0vlm4ZlBuJPEyBfbDPl/7YotcTuPp8WKh36+?=
 =?us-ascii?Q?F1tK1jppCvpX74HO1c4ekXIYP3SnRvHu3DG010u9SXNA2me/UI3IvFqFpzdC?=
 =?us-ascii?Q?3JT45MIJXcY7uCt9xtx6vVaQ/h8VFofwZkYpMch7/xsIDaVr4z1Dv1H18MiR?=
 =?us-ascii?Q?7pnPUL3bh8cTXtwAEDFvbpRsFB+l4OoVg7GLmWdQpueRTiCR5qhGfyFazDuW?=
 =?us-ascii?Q?V2CSjsupAZGcbBrM58KaDKHqGR5eX20DXlq1OD/zXtH/Vfo9y67cvcMhUWsF?=
 =?us-ascii?Q?IzKez4MhlgG9wgw8u2NQdmmU409aRCSkyChqKV0uICcTLgwuVJHRzhlC5cuq?=
 =?us-ascii?Q?5jujSnRrLt9/PPNCoEL2EIDvHWcgpWCCxC2aYvrLBduOXocqxghMizVA6dnj?=
 =?us-ascii?Q?b57SKetyc2xrA25YKOHFUUusGotSn5a5hMXzzgb+MI6qKKyfJDwb3EvZwY27?=
 =?us-ascii?Q?1onguYy0DQddpeQgTyenNlxNKbYZAcpUQgP5RIv+z57qs9zSOU2omC31BzNz?=
 =?us-ascii?Q?PluCPslbX1Py8FHrpDcgjkf03P80p9rczgBISBC9uD4Gaq5RbnLCPI5/wFe/?=
 =?us-ascii?Q?sGaHyZWGH43oWhi39ieq4/wZaoQETUnSiD9QnCtmlfPAcvK2mYOGTITnPu0H?=
 =?us-ascii?Q?NB0Ehq/IW5UAhIuSeF/EHsUZIK3AZqYv081CNf51o79ctG5BTcZzxM/Jg337?=
 =?us-ascii?Q?dKbTRwLgBo4mC5p64bAMGWFLWN9SUgJVhTVX93sZ+SDvt4EUoy1D78c2Q59Q?=
 =?us-ascii?Q?1te4U5/FFSClbEnUG9y1Uy8qYjUEIKWDddop+S5rUM5kZDa9ucCiyXyqRi0N?=
 =?us-ascii?Q?hLUvwnV+2VdOCMA7OU6U2JnTCdHKOkfTygDHu+vQqqyqzI3a/upGmmDTWXKR?=
 =?us-ascii?Q?uO7Uw6FT2YE47QKRvSXyaXcSK6IBEEDkfyPrMFz4ZxnQP6/bQzWKqHbcD4D4?=
 =?us-ascii?Q?nhxlp3x25IbG/JG2TOTUes9DWGr9Nrbr5deXjy3Tki8yWSeompy9aVcaNQ3f?=
 =?us-ascii?Q?XoqOzZX4VOeLHNEtGAlL6w6agH+eDqPGTPS9IVqWcfjcz0V4RSxaoREgQmmO?=
 =?us-ascii?Q?uyC6/S2jDGJ3JXO4WICdj5dr7LPKmMTCkwPzrCLGd1JaPECQWHtvgpqn0Aj7?=
 =?us-ascii?Q?XkLm4vzg6qujZZgB0T3rhXqH83VOsXgthLy+GFvjMSwW6nQu335PNBfVWT6Z?=
 =?us-ascii?Q?sF/+Olt5334wy1zSIGqbzZmu6pOJD5eMIomGzcr427/dDyum6n+Y9HF+dH9x?=
 =?us-ascii?Q?6uvlAXLfsV930Yz0b2tqE1v2gX161vdPiyVDjwXaBmaR73cw7s0QjeGOzFcp?=
 =?us-ascii?Q?ftEYrby/pagODMEbm/ad6+FPTmM8lQJl1SCRS0THHoVXmLUQ42AnsLfecTm/?=
 =?us-ascii?Q?lQO5gdrsjU1gg+MEaH8F+CdjtVUNFSrfHsAAqoK31FackPCQ7SLthEu/U8w1?=
 =?us-ascii?Q?WnwPgSbOGRxzw6InBcyBcAwDqn5MKHJMLj765gye?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: baae3c21-0254-4f4f-7454-08dd6af4f7e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 16:57:31.9801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yi4ylcgF1AdByhEb9R5QVqgEIJd3yk+7CLTtWew/9U52/n7Oxinlkn4oda2Yb840eRx7kg+xdxLKVcV6thJibQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8624

> -----Original Message-----
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Monday, March 24, 2025 3:02 PM
> To: Jeff Chen <jeff.chen_1@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; johannes@sipsolutions.net; francesco@dolcini.it=
;
> Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH v4 2/2] wifi: mwifiex: Fix RF calibration data
> download from file
>=20
> > @@ -454,6 +454,11 @@ enum mwifiex_channel_flags {
> >  #define HostCmd_RET_BIT                       0x8000
> >  #define HostCmd_ACT_GEN_GET                   0x0000
> >  #define HostCmd_ACT_GEN_SET                   0x0001
> > +#define HOST_CMD_ACT_GEN_SET                  0x0001
> > +/* Add this non-CamelCase-style macro to comply with checkpatch
> requirements.
> > + *  This macro will eventually replace all existing CamelCase-style
> > +macros in
> > + *  the future for consistency.
> > + */
>=20
> Just ignore this checkpatch warning. We don't want to have duplicated def=
ines
> just for silencing checkpatch. If anything we could change all the CamelC=
ase
> defines throughout the driver in one go.
>=20
> Sascha
>=20

Hello Sascha, =20

I'll proceed with reverting the duplicated defines and ignoring the checkpa=
tch warning
for now. =20

Thank you for pointing this out. =20

Best regards, =20
Jeff =20

