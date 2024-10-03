Return-Path: <linux-wireless+bounces-13434-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3A198E92A
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 06:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FEC1F2394A
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 04:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501B022F19;
	Thu,  3 Oct 2024 04:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PpMB/nC2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2076.outbound.protection.outlook.com [40.107.103.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD18D139D;
	Thu,  3 Oct 2024 04:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727929814; cv=fail; b=f0pD6Kn2ouJxihB/qvct9XhjGwiY5sjzh8pbrHwnX452v1M909WTwkk1HPRQK/PvMEfWeffhkobUbzQ0/NFkXj8nFHjkDEr0PjQCCJz8qMMv2hZWJyEJ97/amgJWmB96qentWX5zn7C6+MT3Og2x2j1JsfSKq5+Iu50U/+NoitE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727929814; c=relaxed/simple;
	bh=JbM3h42tBZO8i2ItRfRCjsN/WwwbDtc1bp9tb8NblmI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MliMidJzHLmMXlPNvpbLQG41km2PCruvuxU0eNzN6G2UCn7u1lXm7cB3epD1k3Mmx/7UYGEPOi3B23Soi4lw2h9UcLZNv/6MGzqK7jDE7wa4vk23IwtOTs2YdZwDBzdVQeyAqPkX/7OuWSHDZV7BdUkcuH9woALy5YXlSGP0Cmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PpMB/nC2; arc=fail smtp.client-ip=40.107.103.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xv8iVE2x3SaBa9MePJ+vFKNvTRx5dY2cG9Xm+8P8mct/E7JmlVyjLdgfJIplHGO4StFtxlijNtYvwRDOgrkYaHqOno/NsqngZ7HFVcV3mTwfEcg+nfLiPxmsrRVwk5KWx0DMqGZsLFehUfSWmoTndQtui2/rl8EA8caDgkgcTSIJc5OIaprmim34u6yDsauaIF2xa+J/2lQWqwMwafo4lM7H3PBV9veXj5bM3vK+R91AemuWMiUBPV4QwaIRoKc6CG8hOUKABdLxaYsJ4G6GO7akfS/XzR3B42ePOSN2LMohlRx60ZCeubzLC9Y5U/EZKe6xag6f9KeHu0B8cqePgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbM3h42tBZO8i2ItRfRCjsN/WwwbDtc1bp9tb8NblmI=;
 b=wxnsnsIZNfHIbFZF57KjGIRHXMbtwNmcRU+8YvKRDFr7FKTKBJfaNBiL7Xx0a34qHaNJs+iHfi+8aCPFcHKMdqXUlyhK7FpIIpyBweHL1TeiEMZLJeFE1Fq6ansojrDLTozU9pDb4DZvFbz3jajOfwmEH1z5ye1a8lOGwZVDn55ABWv+TktGhcOYlFLzpjwZDAiPNl3r+Rcq+BGWVztbw4yUT6+h79v+YKXSxtf9DRHWW22QH6NACMRSNr0bSdiyYi1ZmtGfJE/KLMF4OYEQtMBHq0lf7jPGbaBQXNYYSQha4hX/WF5Ydtdb4uAKofw0yBs2CKTfdJvXJAEZVVWCqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbM3h42tBZO8i2ItRfRCjsN/WwwbDtc1bp9tb8NblmI=;
 b=PpMB/nC2r1d2qTT5KnA245JoaTN6qP0RAZHagVfbw08BS/3TgMh0T1Ymhe/RdUMuIDmXHZ6+iJFedFogVDuopjqbDN8b6IaF06LkIcpCRIPCiNt/ve7rdSyTh6zUjrnY4AGRpItopDhiRFa+zvjAB3TUz7Px0NWgYcwVZQ1UqsJwRM7ZaLd7UgkH0qJGhtpw1TP6mXDichj5rFs4Hpuuzmpyf//WkzyZia/XHITjSQAfHEzxklrUl2ifPdD65usIng9GthBMf02beAoEWXPwuk+FUigHD1NFbfCasVrGQ6+vcejoIH/rwCQrMExqpHbM3tIKPUTPMm1y+T/KtYk5sQ==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GVXPR04MB10326.eurprd04.prod.outlook.com (2603:10a6:150:1da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 04:30:07 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 04:30:07 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Reto Schneider <rs@hqv.ch>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v3 00/22] wifi: nxpwifi: create nxpwifi to
 support iw61x
Thread-Topic: [EXT] Re: [PATCH v3 00/22] wifi: nxpwifi: create nxpwifi to
 support iw61x
Thread-Index: AQHbEwMyNFUkvUYiK0iqRA5rNW1jCrJwAzIAgAKqpaCAAOsHgIAA2P7A
Date: Thu, 3 Oct 2024 04:30:07 +0000
Message-ID:
 <PA4PR04MB9638365BF47644D6140365B3D1712@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240930063701.2566520-1-yu-hao.lin@nxp.com>
 <e93e1dd6-c215-4168-83e9-b8199599bc09@hqv.ch>
 <PA4PR04MB96380EE5216693C9CCE16030D1702@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <1a53a5bc-b314-4037-87ab-c86f48844405@hqv.ch>
In-Reply-To: <1a53a5bc-b314-4037-87ab-c86f48844405@hqv.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|GVXPR04MB10326:EE_
x-ms-office365-filtering-correlation-id: cd44b1dd-ce1d-4f94-3be5-08dce3640fad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ym5ITlZJS0YzQ0tIcmJMbUh1M0ljSGhObkJpM3l3NjkrN1NKUjljMzQrT2JW?=
 =?utf-8?B?ZC85eG9Fd01MVkI4aDdwa0kwTWtRaFdNSU1TSFZOQ21yWFJQeXFmVndnaFY0?=
 =?utf-8?B?U2tYNDlyR21aNzV0NURIQjlhMnEyVkNTd0xURkljaFlONnI3YU1odEdEdDhE?=
 =?utf-8?B?OGJuMitxNkVYTDFTWmJrOTh1OXJjZDJIUjJhV0J4Q2tBUTNFR3lxSldUNEtu?=
 =?utf-8?B?b05BdHJibVlvL1RCckRyUmtRVTgxU28zeEFWUVVCZk0rWlJ3M0J1elU4UjV0?=
 =?utf-8?B?cllVUEVQV0JrU3ZJZ1U3T2NxaDhMN3hpUld6bkVmR0NmMXdPREExZ09oRUJN?=
 =?utf-8?B?TkNiQmhPWGdDOTFraFRxeElENWR5eVJVMndOSHVQM0V0ZldicS8zWWpzQllQ?=
 =?utf-8?B?TlE1N2F1VVk5WWlrdW9SL2JCU1QySmoyR2EzWlhndVRiRis4cTBOY2xMOExC?=
 =?utf-8?B?UDNjSUF0c0Vld1BTUHlkZXdoSEh1dVBCSzVlSWVCSHNIV2pwSER3eTRlQ0R0?=
 =?utf-8?B?MEt4aXhPVDFOMlMxbkV0YWZTT3RucnozUTA3TlViZ1RTdlU0NGc5a29UQmdL?=
 =?utf-8?B?MW43NTRCbFUwOHIvZEtoSk1YUy9WSlJJODVoNXJSZHoxNXlVMmIzVmN6eU9D?=
 =?utf-8?B?d1dRVzRyOU5Ebk5nbXQrV3JpYzA4M0IvQlR1Smw4eFNka1VYbnVodTZZbGhH?=
 =?utf-8?B?Ti91VURhY05adlJSWUJhK1duZ2ZaMGlzenkxU3NBUW5GRkN5Nzhjc3krUkpW?=
 =?utf-8?B?ZmhHaWxnZlNDd0kxRHYzbDJGSUJveVhhMTJmdlNZQ3RObHgwZ2pZN1o0TDJa?=
 =?utf-8?B?N1ZSYlBPYTJwSmhtSkVNRk14WXozYzRZbjNCd1FWTE1vVjdiNEowNFNLREIz?=
 =?utf-8?B?RXpueUtpNFRyeTgzSlVtUHg2bXQ5QVBFZHI1b2ZTNmNMT1FlM2NNTG5IcG9X?=
 =?utf-8?B?aDJxV2c4bDBCWGUzaW9obUlUMlF2UTZrZEVXMlZmR3BrTktTZURrMHYwc1F3?=
 =?utf-8?B?OVZVelZXaDM2aFZZenBhdU9BQUQ4VC9pTVRMQmt2OUlqcjB6Q1VOVHJjWkJ3?=
 =?utf-8?B?NndCeC9rWjcrOHoyN2I5VE96cGx2SStLdEFMNWZwdGFDaWNkU3BMblVZTXBn?=
 =?utf-8?B?ZXY1YUtYOVhiVjdySEh1S0RsUVhlK3RXdllLYjZmTWduTU9kdFVQV0JKYXZG?=
 =?utf-8?B?WVpZc2FiR0l0MmpMR25oSVFvL0VUY2FCdkNMOVVhcWExcXZoYlNLM3ZIN1M1?=
 =?utf-8?B?RDRORS9DYUczLzVCOXYwa1FsWjluNkxzZHNWWjJYNy9IOVAzV21SU0Ztb2sr?=
 =?utf-8?B?VXRlWjZaelhFNXEzQi9LblFpZmdiOWpKQ29mZU1Va3VqTytFZThJbmRPMy85?=
 =?utf-8?B?L2FuNnorZVRodHJJcENKZEk0cGR1UlF5SWtPTDY0SG9SemFmOUc5aERNYjd6?=
 =?utf-8?B?Z1ZSNXE1WmlYekFPbHNsVGVwWjFJWW9Ib1RlSzJkcVU0ZnlpOXlVSmJLTjhq?=
 =?utf-8?B?NFlUb001Nm5XVWdCUys1T3Urd3MxVDByY0RkQ2IzSGk5SDlaNVp6K21FN1BL?=
 =?utf-8?B?d0ZZQk83ZkhrN1lPZkVVK1RUZ2lKbnNLL0xhOXgrRzE4VDFQNzZyUWZMdlEz?=
 =?utf-8?B?eG9UcDA0aDlDTzhkb1lDQXNHenVDNGh4TGxHblhKZmNiU0dGRFEwUUNZeW5v?=
 =?utf-8?B?V2VkMC8wLzZ3ZFVxWmh4NE5qWDVjZUc3WmtpMXRYNXNMNHUzMHNyeTcyM2c1?=
 =?utf-8?B?ZXBWQmZNcFlQWUNsc25tU0UvMHY4a3lXTndnczY5RUc3YjRUMlZCYklWam1v?=
 =?utf-8?B?bXlyYjlVQWlIWExzdWI3QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bThhZGphOFZhMHE3d1VVZjl3ckZXaXZWekIrczFLTHlINmsvQlFTbjNuU2Yx?=
 =?utf-8?B?cnhpQ0QrZldpenIrR3krUlIyNUU2RzRhWW9yQXJiUVFPbFMrRTU2Q0czQklj?=
 =?utf-8?B?ZjRFM3pHaHVBN29TRVNNQm9ycFFYUEp6Q3hYdzlzWjlWNExRMjdvNmp4TW1l?=
 =?utf-8?B?ejAwcDFHT0F2alAyd0tZWW9GbTJaTFBFZWUxVWJ1S1lHTTIzZjUwRzNqcktO?=
 =?utf-8?B?R2pEN3ZzRld0Rnp2YTJiclpnL04xRlNYcCthSDRHVXVvNnQvaHhVcE50WXla?=
 =?utf-8?B?eWVUc1V4SkJSU2RNMllmb0oyOFBmNXF5REtCMEFQMXVOMEpGMjhKZjdMZDFM?=
 =?utf-8?B?T3dXbmlRQ3ZKMXJ3MGt5V096NC9EZDl4b1YwVExIZ3hsNW9BbzhBSW1Camdi?=
 =?utf-8?B?M0htaC9GN1F2Yi9xZndaNFZTQmxCR0pydGF4cy9RaDQzV293enZXYmp6MkM5?=
 =?utf-8?B?WUkveTUxN2R1d1psNlh4MmRqdWZKbmx2ZFJPRUxDbC9IZmFzY29ZUkJmZHFW?=
 =?utf-8?B?ck9QNHE0anMzb0FvVGdBamxaYWtCNDljUHlFcGlrRjVLM0pIdXVYaEhSY3Nu?=
 =?utf-8?B?cVEwY003SnZhZHJQNklpK0ZIZFZHazIxOVFERXlPSy9GamhyOURDSElLeGJG?=
 =?utf-8?B?UXZEUHdyVzZVRkI1SkxiR1BaZXRqVFRzQ2lpOHM2RitEQUpwT3MzWnhBSDhq?=
 =?utf-8?B?UDc3bVk4WGFPYjNvY1lNVHkydkpFQjNpNnk4bUw2TTJoWmNoY05ralVQYVcv?=
 =?utf-8?B?N2VmNk5TVE44WHRadHgxaDZyZysvYTU4YWFqaTdFUExOcUVuYitBUmZWcE85?=
 =?utf-8?B?dHhQbzl3RU00L1h6RHJ5ZmE2aVY1anozemkxeDRWUVc5enRKUCtDR0JzWUE0?=
 =?utf-8?B?V3pSMno4K24reHdWczhUVmJQUkppdWdKdDFzakQyVWFCYlRrcXNhdDJtZjFH?=
 =?utf-8?B?WWw0UHc3V2Fnc01sakxVbnJaaVVWdTlHQXBMV2w3aU13M1dXd1QrcXlOY1g2?=
 =?utf-8?B?b0p1U0lreTYwQXBjWjF5UDZBMS9zQmNaaVlhMFlWVlZPWTNERGdFOXNrZnNB?=
 =?utf-8?B?d3hZcE81Qit5TDNReUFFdFVOeWh6aU8yZ1pnbkhBTnNER0llU0xlYTgyanVS?=
 =?utf-8?B?dkU4RTZvVVIzTmxtbGg4ZmtYRmRXa3diRjZPWk9MNTBZS00xV212TlRjM2l5?=
 =?utf-8?B?eUQ4L0swdkRkNXVDQXQ4NTBLOXc2enlMdlQ2WVhUUERhdVVYZUlQWHpkSFNM?=
 =?utf-8?B?bEdLVEl2K1EzZ0R5VFhDbEJLRjQ4clNiL2dzUGtmL05ZQi9RTFlLQndrN0dR?=
 =?utf-8?B?Q1FqalozZ0hpRC9GWE4zc01KQ0Iwcmg4RUYrMnJtNTY3Z0owMnFwYitIVkpj?=
 =?utf-8?B?SUNqZ3hSMEFsNWVGalpSQmlUWHhleXVVNEpJS25GbWFtb0ZrYUtuM1Y1WTFs?=
 =?utf-8?B?bzVGeCs0amVkUHlqUllwNHgvczFDUmY5aGxkanR0TGp5blZOZGxvSzZGU3Vh?=
 =?utf-8?B?ZGl3Mjk4cUMyYkRZL0pBeUZHVFlubm5uWjdlVlRLUi85bmZaYnRTeXM3U2hO?=
 =?utf-8?B?NTRheTR6aVkvd3dRYXpYa3pCMm5RNkxWUGw5MXFlVlppUEVjM2xsVGtSZW80?=
 =?utf-8?B?TnRaNlpVYWF4Mlh6cGVmL1o2cVNqTzhiNVZjVGVlK1A3ejhtTGZKK1VXU3Zs?=
 =?utf-8?B?V1NpeEg5TkhaSVBYRVdqWHBabzlSRzlCY2hmdzNtVXpFUVpwYzFwS09FRHVk?=
 =?utf-8?B?MWpINCtJd1VyYW1uVnpVUHVKK0hOQXVVYytGUnNiVmQxb0RUeEFPNVhqSFI0?=
 =?utf-8?B?OWxOd2hBUkRqWlNyaUtYdndHMTdWRGprek44REMxTHZOYlFLRHplZ3ROMU1O?=
 =?utf-8?B?L3R2djNvejRhL2JuRXVZSnROeklrZmNwT08xTkZuNDVTRTJScC9NckFaYTBi?=
 =?utf-8?B?YXVsZmM5LysrZzZuOE5DTHQ5SnNLRGRWQTJNSW53TEMwMlE1RVZ5TVdWa2Zl?=
 =?utf-8?B?VnlnSlB5ZUlhUXZKd1lPWFQzMGI1KzZrd3RrRnRuemlKbjM4Q3d1cmx3anFz?=
 =?utf-8?B?bE84NHRnMmlkenhTUk9JcHlWbUU1eHZETTg5dUNYeEs1VmpSRExzY3FZQ2xH?=
 =?utf-8?Q?EcMpQ9yu++Y7keCrn/zUO2IA8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd44b1dd-ce1d-4f94-3be5-08dce3640fad
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 04:30:07.8449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R8olYEJOIZ2ZETOPPRSVbXCp/MnPa44EXDZRQE+ujF2rc8OJfyA8OSfa8kBzcZXFsznXs5s7Dhp+bkuHXxZaYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10326

SGkgUmV0bywNCg0KPiBGcm9tOiBSZXRvIFNjaG5laWRlciA8cnNAaHF2LmNoPg0KPiBTZW50OiBX
ZWRuZXNkYXksIE9jdG9iZXIgMiwgMjAyNCAxMToyNiBQTQ0KPiBUbzogRGF2aWQgTGluIDx5dS1o
YW8ubGluQG54cC5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBicmlh
bm5vcnJpc0BjaHJvbWl1bS5vcmc7DQo+IGt2YWxvQGtlcm5lbC5vcmc7IGZyYW5jZXNjb0Bkb2xj
aW5pLml0OyBQZXRlIEhzaWVoDQo+IDx0c3VuZy1oc2llbi5oc2llaEBueHAuY29tPjsgcy5oYXVl
ckBwZW5ndXRyb25peC5kZTsNCj4gbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFJlOiBbRVhUXSBSZTogW1BBVENIIHYzIDAwLzIyXSB3aWZpOiBueHB3aWZpOiBjcmVh
dGUgbnhwd2lmaSB0bw0KPiBzdXBwb3J0IGl3NjF4IA0KPiANCj4gSGkgRGF2aWQsDQo+IA0KPiBP
biAwMi4xMC4yNCAwMzoyOSwgRGF2aWQgTGluIHdyb3RlOg0KPiA+IE13aWZpZXggaGFzIGJlZW4g
cHV0IGluIOKAnE9kZHMgRml4ZXPigJ0gc3RhdGUgZm9yIHF1aXRlIHNvbWUgdGltZS4NCj4gDQo+
IFdoYXQgSSByZWFkOiBOWFAgKHdobyBoYXMgdGFrZW4gb3ZlciB0aGUgTWFydmVsbCBCTEUvV2kt
RmkgYnVzaW5lc3MpIGlzIG5vdA0KPiB3aWxsaW5nIHRvIG1haW50YWluIHByb2R1Y3RzIG9uY2Ug
dGhleSBoYXZlIHNvbGQgaXQuDQo+IA0KPiA+IE5vdyB3ZSBoYXZlIHBsYW5uZWQgdG8gYWRkIHNl
cmllcyBvZiBuZXcgY2hpcHMgYW5kIGZlYXR1cmVzLg0KPiA+IEFsdGhvdWdoIHNvbWUgb2YgdGhl
IGNvZGVzIGFyZSBmcm9tIE13aWZpZXgsIHdlIGRvIHNwZW5kIG11Y2ggZWZmb3J0DQo+ID4gdG8g
ZW5oYW5jZSB0aGUgRlcvZHJpdmVyIGludGVyZmFjZXMgYW5kIGEgZmV3IG90aGVyIGFyZWFzIE91
ciBwcm9wb3NhbCBpcywNCj4gbXdpZmlleCBjb250aW51ZXMgc3VwcG9ydCBvbmx5IGV4aXN0aW5n
IGRldmljZXMuDQo+IA0KPiBtd2lmaWV4IGRvZXMgbm90IGNvbnRpbnVlIHRvIGRvIGFueXRoaW5n
IG9uIGl0cyBvd24sIGl0IHJlcXVpcmVzIGNvbnRpbnVvdXMNCj4gbWFpbnRlbmFuY2UuIEFuZCBO
WFAgaXMgbm90IGRvaW5nIHRoYXQ6DQo+IA0KPiAkIGdpdCBsb2cgLS1uby1tZXJnZXMgLS1vbmVs
aW5lIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21hcnZlbGwvbXdpZmlleC8gfCB3YyAtbA0KPiA2NDMN
Cj4gJCBnaXQgbG9nIC0tbm8tbWVyZ2VzIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21hcnZlbGwvbXdp
ZmlleC8gfCBncmVwDQo+IF5BdXRob3I6LipueHAuY29tIHwgd2MgLWwNCj4gNw0KPiANCj4gPiBO
ZXcgTlhQIGNvbm5lY3Rpdml0eSBjaGlwcyBhbmQgZmVhdHVyZXMgd2lsbCBiZSBhZGRlZCB0byBu
eHB3aWZpIG9ubHkuDQo+ID4gV2UgYXJlIGFsc28gY29tbWl0dGVkIHRvIHJlZ3VsYXIgUUEgYW5k
IG1haW50ZW5hbmNlIGZvciBueHB3aWZpLg0KPiANCj4gV2hhdCBJIHJlYWQ6IE5YUCBpcyBlYWdl
ciB0byBzdXBwb3J0IG5ldyBoYXJkd2FyZSwgYnV0IGRvZXMgbm90IHRha2UNCj4gYWRlcXVhdGUg
c3VwcG9ydCBvZiBoYXJkd2FyZSB0aGV5IHNvbGQgaW4gdGhlIHBhc3QuDQoNCkkgY2FuIHVuZGVy
c3RhbmQgdGhlIGNvbmNlcm4uIA0KSW5kZWVkIG13aWZpZXggd2FzIGxlZnQgdW5hdHRlbmRlZCBm
b3Igc29tZSB0aW1lIGR1ZSB0byBpbnRlcm5hbCByZWFzb25zLg0KTlhQIG1haW50YWluZXJzIHdl
cmUgcmVtb3ZlZCBkdWUgdG8gdGhpcyBhbHNvIGRyaXZlciBpcyBwdXQgaW4gIk9kZHMgZml4ZXMi
IHN0YXRlLiANCldlIHJlc3VtZWQgb24gbWFpbnRhaW5pbmcgc2luY2UgbGFzdCB5ZWFyIGFuZCB5
b3UgbWF5IGhhdmUgc2VlbiB3ZSBjb250aW51ZQ0KZml4aW5nIGlzc3VlcyBhbmQgYWRkIGZlYXR1
cmVzIGZvciBleGFtcGxlLCBXUEEzLCB3aGljaCBpcyBhIG1hbmRhdG9yeSBzZWN1cml0eSByZXF1
aXJlbWVudCBmb3IgV0ZBLg0KDQpCZWxvdyBhcmUgc29tZSBmaXhlcyBQUiBmb3IgeW91ciByZWZl
cmVuY2UsIA0KQWNjZXB0ZWQ6DQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3Qv
bGludXgtd2lyZWxlc3MvcGF0Y2gvMjAyMzEyMDgyMzQwMjkuMjE5Ny0xLXl1LWhhby5saW5Abnhw
LmNvbS8NCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC13aXJlbGVz
cy9wYXRjaC8yMDIzMTIxNTAwNTExOC4xNzAzMS0xLXl1LWhhby5saW5AbnhwLmNvbS8NCmh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9wYXRjaC8yMDIz
MTIyMTAxNTUxMS4xMDMyMTI4LTEteXUtaGFvLmxpbkBueHAuY29tLw0KaHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXdpcmVsZXNzL3BhdGNoLzIwMjQwNzA0MDMzMDAx
LjYwMzQxOS0yLXl1LWhhby5saW5AbnhwLmNvbS8NClBlbmRpbmcgYXBwcm92YWw6DQpodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtd2lyZWxlc3MvcGF0Y2gvMjAyNDA5
MDIwODQzMTEuMjYwNy0xLXl1LWhhby5saW5AbnhwLmNvbS8NCmh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9wYXRjaC8yMDI0MDgzMDA4MDcxOS44MjYx
NDItMS15dS1oYW8ubGluQG54cC5jb20vDQoNCj4gDQo+ID4gTWF5IEkga25vdyB3aGF0IGlzIHlv
dXIgY29uY2VybiBvbiB1cHN0cmVhbSB0aGlzIGRyaXZlciBzbyB3ZSBjYW4gYmV0dGVyDQo+IGFk
ZHJlc3MgaXQ/DQo+IA0KPiAgRnJvbSBteSBQb1YgYXMgYSBwb3RlbnRpYWwgY3VzdG9tZXI6IE5Y
UCBjbGVhbmluZyB1cCB0aGUgbXdpZmlleCBkcml2ZXINCj4gd291bGQgZ2l2ZSBtZSBjb25maWRl
bmNlIHRoYXQgd2hhdGV2ZXIgY29tZXMgbmV4dCBmcm9tIE5YUCB3aWxsIGJlIHRha2VuDQo+IGNh
cmUgb2YgYWRlcXVhdGVseSB0b28uIEFsc28gaW4gdGhlIGxvbmcgdGVybSwgd2hpY2ggaXMgYSBt
dXN0IHdoZW4NCj4gY2hvb3NpbmcgY29tcG9uZW50cyBmb3IgcHJvZHVjdHMgdGhhdCBuZWVkIHRv
IGJlIHN1cHBvcnRlZCBmb3IgbWFueQ0KPiB5ZWFycyB0byBjb21lLg0KPiANCj4gS2luZCByZWdh
cmRzLA0KPiBSZXRvDQoNCkkgY2FuIHVuZGVyc3RhbmQuICBXZSBoYXZlIGNvbXBsZXRlZCB0aGUg
Y2xlYW4tdXAgb24gbnhwd2lmaS4gDQpXZSBjb3VsZCBoYXZlIGRvbmUgdGhpcyBvbiBtd2lmaWV4
LiBCdXQgZ2l2ZW4gbXdpZmlleCDigJxPZGRzIGZpeGVz4oCdLCBhbmQgbmV3IGNoaXBzIGJhc2Vk
IG9uIG5ldyBGVyBpbnRlcmZhY2UsDQphZGRpbmcgbmV3IGRldmljZSBvbiBtd2lmaWV4IHdvdWxk
IGNhcnJ5IGEgbG90IG9mIGJ1cmRlbnMgYW5kIG1ha2UgdGhlIGNvZGUgZXZlbiBiaWdnZXIgYW5k
IGhhcmRlciB0byBtYWludGFpbi4gDQpUaGVyZWZvcmUsIHdlIHByb3Bvc2UgY29udGludWUgc3Vw
cG9ydGluZyBleGlzdGluZyBjaGlwcyBpbiBtd2lmaWV4LiBEbyByZWFsIGlzc3VlIGZpeGVzLCBu
b3QgY29kZSBjbGVhbiB1cCANCkluIHN1bW1hcnksIHdlIGhhdmUgZG9uZSBjb2RlIGNsZWFuIHVw
IG9uIG54cHdpZmkgcGx1cyBpbXByb3ZlbWVudHMgaW4gZmV3IG90aGVyIGFyZWFzLiBXZSB3b3Vs
ZCBsaWtlIHRvDQpwcm9wb3NlIG54cHdpZmkgYXMgYSBiYXNlIGZvciBuZXcgY2hpcCBhbmQgZmVh
dHVyZSBzdXBwb3J0LiBJdCBkb2VzbuKAmXQgY29uZmxpY3Qgd2l0aCBvdXIgbXdpZmlleCBtYWlu
dGVuYW5jZSANCg0KV2l0aCB0aGlzIEkgaG9wZSB5b3Ugd291bGQgc3VwcG9ydCBueHB3aWZpIHVw
c3RyZWFtLiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW55IGZ1cnRoZXIgY29uY2Vy
bnMuDQoNCkRhdmlkDQo=

