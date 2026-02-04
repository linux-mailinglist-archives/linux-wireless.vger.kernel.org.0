Return-Path: <linux-wireless+bounces-31558-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNQBIbGKg2lWpAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31558-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 19:06:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C769EB633
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 19:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ACB6F30074B2
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 18:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13314428847;
	Wed,  4 Feb 2026 18:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dt0T5xEs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010069.outbound.protection.outlook.com [52.101.69.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB4A423A70;
	Wed,  4 Feb 2026 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770228339; cv=fail; b=JjxDUTOQIAQr2Mk/zQaUs8SPFJtodKSWJYgKKwFJ1+oP+QJWrednEqq9Ja1ZuusOsAJdq7U9fTWSw77vO0Fy/7l7n9nNhEmIsuMjEjOMSpv3X/IF3rLn3uQ/wU8ddLdmCSPIqlEcHvDb/Ic1qfoj+SmdZ87tql1WcYdcHYD/zwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770228339; c=relaxed/simple;
	bh=NEYTCVFyj4PVzzYwjD1CwXFsKV8sdAS4KVc0zgTZUf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LUSwBUXEMrLANUL6rbda9dgNJkmhFS4X3d4pYv5lh7b19Hm8aXGY6lGdyWpKBKEvv9JqJcjlEUiM6jNN/Qri7KjzrPLs0pX10W6frwfTOYeGPwOHKa0SloYu5/XOqC78HCOzr24VxeZRHZ5iKiICUTIGc0JzS8RK18cMP3QZR/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dt0T5xEs; arc=fail smtp.client-ip=52.101.69.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPbRekyzv1dFUjL3V02oOs51cR7E2hbsDPu4S6/B/BCTRFhrSkQ44PwSKuQvMWyHY0kf2M62RW0k/oUiXRZ/1rn43/fkDfhNJTwzzbiWpZx4RDeTx8RJFyW1aCoVVvKq1CX1Eoorr3DwMCr3HaN6zwhJM1Ka5UWb7taiyyOCBMR9I1xQdmR7uVMwfGBuug/HzlLG//CSPG55xo0BJt7ey9iLw+0oXXddbKWsFwc/s6kpkaNVyfPV/XJ/H6K1HTPw3vVj3Ag0D27zUZcDN69h6F/l0wiWddri2T7gyY7Svv1ArJibOUSPbUzuv90UbDzXxLzKUrUKVpM0kzNNytrWvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuCqCe02e9uGt0kAH/jJgv4yRBrf8FMAHylaymyfU68=;
 b=T51d0bWv5/FInsN8zm2BYnaDyLMvnZoe7mOXBBYqevmqmc4ph7WWZvWTOT0NGZZGiZR6X8A4b5ei0U2r72ybtqm5Vjkx3dBVYj9448EaDVdersYnTM893qCGQ97iaYb9h/cLFgU5cfNCrZ1gj06+Owf/Rk1UXt27O+lur44CbmSqZzXpNTMCAwqziOVwOHZ6mfLmrga2H3h71Ygl/VIPq1M8iYkvisK7OWLM2h/PNamb5C0qy8RgWdZmUCSx6oIKAtXcpi2lBw+/CyIGoh2BPQYDKXqAG+HcovoA81a9iMdeiofx9DslYUBNcEUDS8A9jegkUJHvY40E9/F9fVJybA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuCqCe02e9uGt0kAH/jJgv4yRBrf8FMAHylaymyfU68=;
 b=Dt0T5xEsCyuqo2PONCiXlH6vCE7CYoMprMCKXrvG+8O4ag4bnTZmhZpxMRL9+ZM9cFPrHd9xoVFTvrhPSpFjs2CJWWZOkrrgyjCU284uMC0qvFSlvQBjLA7aU99Ui7T0BtKeXFDH2/p1/gISvDNKn29WlQI21nST7niIa7O8JSF+uHQx2baddTDd+PnwCPjeAG681vB8aPM/wHEFY8Wl2a8xsNwTiFTFBUfGYk1t6QZkm4R1e4x8ExoRYHhgtA57F41DTiD5bPKszy/RZvldHIhcjUPic5SA5Fi3vOXB6D2zhmjXWHu7mpNhYfUsMwSy80o+Fdw8gan7UH+i/pfaWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by GV2PR04MB11980.eurprd04.prod.outlook.com (2603:10a6:150:2f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 18:05:33 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 18:05:33 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v9 09/21] wifi: nxpwifi: add configuration support
Date: Thu,  5 Feb 2026 02:03:46 +0800
Message-Id: <20260204180358.632281-10-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260204180358.632281-1-jeff.chen_1@nxp.com>
References: <20260204180358.632281-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|GV2PR04MB11980:EE_
X-MS-Office365-Filtering-Correlation-Id: 582f0b69-a19d-4334-a6a6-08de6417fd2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PT2Mfs0jxrbZxE0O9V4VW0kJI1QCw2Nm0awnKAJii6YwMbPx9EYvwrfL5KWi?=
 =?us-ascii?Q?8Hx5+eHYchL8KjprHXCJ0gmACzWJr6/KEK/VfCo/Op3uGPsTkkes/at93vwc?=
 =?us-ascii?Q?m97owhjotGB4K8fPahPG8+Yr8uuDboqvH9fkBRuM0bD5Ko6TeBZAfp5WDAmK?=
 =?us-ascii?Q?Ol3s9J7/dtNavy8gMiTUpT4rAk1a74wgwjgyF8AoFRLe8vwLnmpKJB7WwZpd?=
 =?us-ascii?Q?opduHnow9NbPjiGQFofeVmRK5+YCsA518HHZEGCb1Ic4Zo6oDacOzWThShoR?=
 =?us-ascii?Q?b9KBem50MPiSY+nMzGHroT1n4FW6SydNKn/vhouQZUwXrnIxiwhEOB8foWZO?=
 =?us-ascii?Q?BtIJBg+j0WFoZ84ZZdn2ziA8nAbtqUasJ9sJFh4+14ogNtLnAzHqeRvHDezx?=
 =?us-ascii?Q?3dL7BkMf/wmZVPdjtT8FJBobpXPqPwPXGcgx6/Uyj0+KrsCvdnoA44DzQT3d?=
 =?us-ascii?Q?5bHbIvPfX3knjpwr+VjBKV471nGod8Ei3moUFwuCMK3XPgoWM+3Iud4OFXi8?=
 =?us-ascii?Q?x21NkezBcsqksRKgOrVlajbWBMC6Q15S63nYVFMQ4osRyxKYWQeBFUO1AKA2?=
 =?us-ascii?Q?5TlVOWPm1CR+cHcLDDMc9owhXqGqZelW/oxwo3QzOprMfsQ8EaXslhiCBHXD?=
 =?us-ascii?Q?68Dk6tgY3/E71jIHvf5JEZ/sk5awvx6lz0je0I/5KFyyVYOr8PXCLEfAAXU5?=
 =?us-ascii?Q?9wFq7KTgRPPYWz+VlCdmNkd3VAz0O8vJLDSNgWI7V2yGiZ2RXyr2vjnW0xW6?=
 =?us-ascii?Q?ZLf4NSxj5fKT0m7i6BSaRl72Xlx0MBRxzg8Whg+oVfzo6bYjnGCYKQDNBXrl?=
 =?us-ascii?Q?VsPSDXDRQw9dGGB56LfePy+5Bj9e8bIwMDrwIUMRYrrX0hqo4/kHOgDYuIc2?=
 =?us-ascii?Q?lwH0Vqzr+T7916pTOGjzikJ3r61VD+46WeOZc3wWpYZjavQQUNmJUIy2SSFG?=
 =?us-ascii?Q?jnVWEAroOjQNjyh1T29r/x20Q2p0ZNYJlbCDeY6f5yfnC/iflM7WC7W+uzJ2?=
 =?us-ascii?Q?oxTaQegnJ5ljW8HZkKnxjbUI9ZGV4ExLLhIK8ceUhvqfDB1ijsT3uOyGDuQn?=
 =?us-ascii?Q?nqJulNRrVSGP10/NU0w9OH20J1FGeWbk7vvRDrVzq/FDJeHiIPAssGzYQr/j?=
 =?us-ascii?Q?+IHZt1+5CoN1l8EYo0i73W6VvJ+pE3JMjZwDvDbfXJwMYTZ9C0hhG72AZiNl?=
 =?us-ascii?Q?PgwG762Hek7dtfJ01L5uIkDm/D4udPEg+gc07xUML9uXr4AD5fsOlWJ8nuf6?=
 =?us-ascii?Q?eeGlGr5Y/oftE8Zl6ZbxqjXk7Ac3C+qH4uhm/WJscJiuz6PEThZR1DgikNuH?=
 =?us-ascii?Q?DNkqUK9QIrISdto0knzxBPcEaHjnBx3SSrLMJrWcgyl4knlYeI5+/XF4SjYT?=
 =?us-ascii?Q?rz5hlgBXDPblTCy1EwqP9fSwzughYBfH/bjrIxw0Ty/JcDPOfFqK9b6gFNcE?=
 =?us-ascii?Q?cjru39ZEDtVjW0fx1r9wcEh4uykrMNbte0LhIOeCAf9mtbZJXmuftvuQD+AR?=
 =?us-ascii?Q?TVDFx1Jfo5hI78MK7FN3IuHGgx3Hy4smXqVDcyOvfsCn+3ju4N5jDWyBl3BJ?=
 =?us-ascii?Q?e3ZCRMVTYS3+gjM+BMDCP0P1YeFfHCRUElu7v6J0oLbMortfNZlNrj9ecu6n?=
 =?us-ascii?Q?hn248L1vSVyyr5zi+c3TmoE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sSgOVb0BzsGCMm1F4HIR1eUtk7PPmk38B6bdbw8d2cVeiiPY9x9utpLeJAWm?=
 =?us-ascii?Q?ETjmgGehU48a60VGu2DLlBfSTtJg5j+JRCKDiKMw5bgOM7cK+IfNdPj6exTY?=
 =?us-ascii?Q?AVXSCbjMi4J86hB7a40tJ7+lWA9UFgmlg4y/T8p8nTu1CvwVzkkovzjWkC5n?=
 =?us-ascii?Q?Sq/quGR90CI/vl+iU5VU+e1RH7ns9fp4QlDUtLD+sqmI4Ap6l8Vw1SthMAtB?=
 =?us-ascii?Q?zchF4yPSsj4dGCDNdQex6Nag6lqY8cXKCbrw8XPwDGXFlUqtqW3oZpobbKio?=
 =?us-ascii?Q?sLeqdH3xhGethLb8GW1p/sazBiX+N2mzDX/6Mx32oIRnJ+TKFL9KlEHQwz6Q?=
 =?us-ascii?Q?Vd5yFejEr0b+AjLSmOYxhFfuBu3DJklRINwsj3WTQZ/Htha1BRrJLNv2mAAP?=
 =?us-ascii?Q?8aHIa+WM7Nd/zOh2vE+hOJctCd4f0IQHp0lJJFU3UOg5Hq+a2GAoCu5JHdKn?=
 =?us-ascii?Q?65fnzPAqj0qYDi2GSxCgO0GVbYQm39WzB0liEJAakDyUJ1c1T+GlaMyRaMT4?=
 =?us-ascii?Q?F1UPVRNq0nt35TwwN5g6odMmNdtrVCxC/uj8rf1AxMuJNWlAzl2KYasgQNBV?=
 =?us-ascii?Q?C7YObx+sKe29Qj0mlIJgRUiPBQE/70bBSggkH6pbTe9IGoc8Uh0PxUSDoW2A?=
 =?us-ascii?Q?WPI37ngi0jj/Vu+EQPEUspDn6pnMKW0uRP5eJSbHcs/PSeDtLs6AcvEOK1j5?=
 =?us-ascii?Q?jhC8k0TfHNqXNFN9oVuNO6tBVVt3y05B3XgF0xouOIcn4dnjYwSq7YXsIn4c?=
 =?us-ascii?Q?3HNHjzWRINAF1MBXdNIOXpj0WdvuNVgglbGvbn7zRcz7qDtZouu9PZrCZfuh?=
 =?us-ascii?Q?M6GiRASHlg7e6VhVKa4UE0gt1BZbZ/hLeLig2Fg0mWtn0myKPRJQmXDzG74/?=
 =?us-ascii?Q?45cTgl+OdGAQerdJJR+UN6Ewv9kUkdV1jY5bKRYLVJe6QsDA/mPiNuCdqkUm?=
 =?us-ascii?Q?kOMM2Hbx8yrGBcm3EwRAc8gPf98g4J8UgOrGDQcNxOvC3bXbAYSjEsV9/ief?=
 =?us-ascii?Q?76ws72xUhFBxZ5n+dryxRTgMmIka0F7s3X02E+35/Xlkr2ulEYoJA/cUEPz+?=
 =?us-ascii?Q?MEA+PpSJzTnGnzV8Hyl1OplSUXhPl+JP7BnDWF+0KSABbKZVqEUEyWMFfCH+?=
 =?us-ascii?Q?LT0X0nHYyk+9kkX4KjdRzeAG6/vLpvWMXsrR2kXCymNGDK2xv3W+cfmL5M9v?=
 =?us-ascii?Q?2OJxv1TwtAYe98KzNA2y5VgpqlskLHZLf50qtB7wr9gAmBCAhaSMPhsyN8ka?=
 =?us-ascii?Q?5qWmEGN25/jeiqaVrAN4ZqVZhXmsu2ZZ2iqvlBA1HJt8DP8DPxWFFb4QZ5FQ?=
 =?us-ascii?Q?v2M0diz6UKuTeUIRGl+0ERZhzWKgjIq9RN+bN223vQQvCPge8qJJDbVpn43q?=
 =?us-ascii?Q?90+GQCcwo6ksP2uUho83zj1DwCcgmMD68Z1v+AiFRfZzwqJO1HcuIeT2LUuJ?=
 =?us-ascii?Q?zXPXRGejaIVKizDyJnoGsFH5jz9hLN8/Ipuf6qVHfkoWW6m7SgfV8AZSpH4u?=
 =?us-ascii?Q?QYff2ijNW8MsrUjeU9uFqDFec5hyfmFtOVpo9P1uoBcNgnwxEsZuCqcCTuwF?=
 =?us-ascii?Q?bMkI+jfSQgs7yNt5Mi8TiO3enBiJib+H6u7PxcUHUQ+gRfuDde9cta/6+E35?=
 =?us-ascii?Q?diM2DjEAIA0oNDCeXIlk0CN+Jyw6TP3JyYa3kJvUiu9yHhYr7m0JbEfhIT0b?=
 =?us-ascii?Q?ZUthY+2S6qgnn6Z6g/y8qUjNfujxy3Gx6mNpd6nTSVdMm0sdNmNWXKoki/UO?=
 =?us-ascii?Q?UJxuBn8oCQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 582f0b69-a19d-4334-a6a6-08de6417fd2c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 18:05:33.1255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJD6rtBEIJEO9awTSiD0HVQxupbBBDRTMH0fylRMjrbNnSV53oK2WjRcZquNFUkQjSnuTrJ7CFWo5rl4JkEU1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11980
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31558-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid,roc_cfg.channel:url]
X-Rspamd-Queue-Id: 2C769EB633
X-Rspamd-Action: no action

Introduce configuration infrastructure for the nxpwifi driver.

- Add cfg.h to define constants, enums, and data structures for:
  - BSS roles and types
  - Power, channel, and rate control
  - WMM, 11n/ac/ax capabilities
  - Encryption (WEP/WPA/WPA2), WPS, and generic IEs
  - Host sleep, TWT, and coalescing filters
  - Register/memory/EEPROM access

- Add sta_cfg.c to implement station-mode configuration and control:
  - Multicast list management
  - Association and deauthentication handling
  - Power save and deep sleep configuration
  - WPA/WEP key management and IE handling
  - TWT setup/teardown/report
  - IOCTL handlers for statistics, version, and register access

These files provide the foundational configuration and control logic
for the nxpwifi driver in STA mode.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/cfg.h     |  993 +++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c | 1177 ++++++++++++++++++++
 2 files changed, 2170 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/cfg.h b/drivers/net/wireless/nxp/nxpwifi/cfg.h
new file mode 100644
index 000000000000..114e70cddf5c
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/cfg.h
@@ -0,0 +1,993 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: ioctl data structures & APIs
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_CFG_H_
+#define _NXPWIFI_CFG_H_
+
+#include <linux/wait.h>
+#include <linux/timer.h>
+#include <linux/ieee80211.h>
+#include <uapi/linux/if_arp.h>
+#include <net/cfg80211.h>
+
+#define NUM_WEP_KEYS                 4
+
+#define NXPWIFI_BSS_COEX_COUNT	     2
+#define NXPWIFI_MAX_BSS_NUM         (3)
+
+#define NXPWIFI_MAX_CSA_COUNTERS     5
+
+#define NXPWIFI_DMA_ALIGN_SZ	    64
+#define NXPWIFI_RX_HEADROOM	    64
+#define MAX_TXPD_SZ		    32
+#define INTF_HDR_ALIGN		     4
+/* special FW 4 address management header */
+#define NXPWIFI_MIN_DATA_HEADER_LEN (NXPWIFI_DMA_ALIGN_SZ + INTF_HDR_ALIGN + \
+				     MAX_TXPD_SZ)
+
+#define NXPWIFI_MGMT_FRAME_HEADER_SIZE	8	/* sizeof(pkt_type)
+						 *   + sizeof(tx_control)
+						 */
+
+#define FRMCTL_LEN                2
+#define DURATION_LEN              2
+#define SEQCTL_LEN                2
+#define NXPWIFI_MGMT_HEADER_LEN   (FRMCTL_LEN + FRMCTL_LEN + ETH_ALEN + \
+				   ETH_ALEN + ETH_ALEN + SEQCTL_LEN + ETH_ALEN)
+
+#define AUTH_ALG_LEN              2
+#define AUTH_TRANSACTION_LEN      2
+#define AUTH_STATUS_LEN           2
+#define NXPWIFI_AUTH_BODY_LEN     (AUTH_ALG_LEN + AUTH_TRANSACTION_LEN + \
+				   AUTH_STATUS_LEN)
+
+#define HOST_MLME_AUTH_PENDING    BIT(0)
+#define HOST_MLME_AUTH_DONE       BIT(1)
+
+#define HOST_MLME_MGMT_MASK       (BIT(IEEE80211_STYPE_AUTH >> 4) | \
+				   BIT(IEEE80211_STYPE_DEAUTH >> 4) | \
+				   BIT(IEEE80211_STYPE_DISASSOC >> 4))
+
+#define AUTH_TX_DEFAULT_WAIT_TIME 2400
+
+#define WLAN_AUTH_NONE            0xFFFF
+
+#define NXPWIFI_MAX_TX_BASTREAM_SUPPORTED	2
+#define NXPWIFI_MAX_RX_BASTREAM_SUPPORTED	16
+
+#define NXPWIFI_STA_AMPDU_DEF_TXWINSIZE        64
+#define NXPWIFI_STA_AMPDU_DEF_RXWINSIZE        64
+#define NXPWIFI_STA_COEX_AMPDU_DEF_RXWINSIZE   16
+
+#define NXPWIFI_UAP_AMPDU_DEF_TXWINSIZE        32
+
+#define NXPWIFI_UAP_COEX_AMPDU_DEF_RXWINSIZE   16
+
+#define NXPWIFI_UAP_AMPDU_DEF_RXWINSIZE        16
+#define NXPWIFI_11AC_STA_AMPDU_DEF_TXWINSIZE   64
+#define NXPWIFI_11AC_STA_AMPDU_DEF_RXWINSIZE   64
+#define NXPWIFI_11AC_UAP_AMPDU_DEF_TXWINSIZE   64
+#define NXPWIFI_11AC_UAP_AMPDU_DEF_RXWINSIZE   64
+
+#define NXPWIFI_DEFAULT_BLOCK_ACK_TIMEOUT  0xffff
+
+#define NXPWIFI_RATE_BITMAP_MCS0   32
+
+#define NXPWIFI_RX_DATA_BUF_SIZE     (4 * 1024)
+#define NXPWIFI_RX_CMD_BUF_SIZE	     (2 * 1024)
+
+#define MAX_BEACON_PERIOD                  (4000)
+#define MIN_BEACON_PERIOD                  (50)
+#define MAX_DTIM_PERIOD                    (100)
+#define MIN_DTIM_PERIOD                    (1)
+
+#define NXPWIFI_RTS_MIN_VALUE              (0)
+#define NXPWIFI_RTS_MAX_VALUE              (2347)
+#define NXPWIFI_FRAG_MIN_VALUE             (256)
+#define NXPWIFI_FRAG_MAX_VALUE             (2346)
+#define NXPWIFI_WMM_VERSION                0x01
+#define NXPWIFI_WMM_SUBTYPE                0x01
+
+#define NXPWIFI_RETRY_LIMIT                14
+#define NXPWIFI_SDIO_BLOCK_SIZE            256
+
+#define NXPWIFI_BUF_FLAG_REQUEUED_PKT      BIT(0)
+#define NXPWIFI_BUF_FLAG_BRIDGED_PKT	   BIT(1)
+#define NXPWIFI_BUF_FLAG_EAPOL_TX_STATUS   BIT(3)
+#define NXPWIFI_BUF_FLAG_ACTION_TX_STATUS  BIT(4)
+#define NXPWIFI_BUF_FLAG_AGGR_PKT          BIT(5)
+
+#define NXPWIFI_BRIDGED_PKTS_THR_HIGH      1024
+#define NXPWIFI_BRIDGED_PKTS_THR_LOW        128
+
+/* 54M rates, index from 0 to 11 */
+#define NXPWIFI_RATE_INDEX_MCS0 12
+/* 12-27=MCS0-15(BW20) */
+#define NXPWIFI_BW20_MCS_NUM 15
+
+/* Rate index for OFDM 0 */
+#define NXPWIFI_RATE_INDEX_OFDM0   4
+
+#define NXPWIFI_MAX_STA_NUM		3
+#define NXPWIFI_MAX_UAP_NUM		3
+
+#define NXPWIFI_A_BAND_START_FREQ	5000
+
+/* SDIO Aggr data packet special info */
+#define SDIO_MAX_AGGR_BUF_SIZE		(256 * 255)
+#define BLOCK_NUMBER_OFFSET		15
+#define SDIO_HEADER_OFFSET		28
+
+#define NXPWIFI_SIZE_4K 0x4000
+#define NXPWIFI_EXT_CAPAB_IE_LEN    10
+
+enum nxpwifi_bss_type {
+	NXPWIFI_BSS_TYPE_STA = 0,
+	NXPWIFI_BSS_TYPE_UAP = 1,
+	NXPWIFI_BSS_TYPE_ANY = 0xff,
+};
+
+enum nxpwifi_bss_role {
+	NXPWIFI_BSS_ROLE_STA = 0,
+	NXPWIFI_BSS_ROLE_UAP = 1,
+	NXPWIFI_BSS_ROLE_ANY = 0xff,
+};
+
+#define BSS_ROLE_BIT_MASK    BIT(0)
+
+#define GET_BSS_ROLE(priv)   ((priv)->bss_role & BSS_ROLE_BIT_MASK)
+
+enum nxpwifi_data_frame_type {
+	NXPWIFI_DATA_FRAME_TYPE_ETH_II = 0,
+	NXPWIFI_DATA_FRAME_TYPE_802_11,
+};
+
+struct nxpwifi_fw_image {
+	u8 *helper_buf;
+	u32 helper_len;
+	u8 *fw_buf;
+	u32 fw_len;
+};
+
+struct nxpwifi_802_11_ssid {
+	u32 ssid_len;
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+};
+
+struct nxpwifi_wait_queue {
+	wait_queue_head_t wait;
+	int status;
+};
+
+struct nxpwifi_rxinfo {
+	struct sk_buff *parent;
+	u8 bss_num;
+	u8 bss_type;
+	u8 use_count;
+	u8 buf_type;
+	u16 pkt_len;
+};
+
+struct nxpwifi_txinfo {
+	u8 flags;
+	u8 bss_num;
+	u8 bss_type;
+	u8 aggr_num;
+	u32 pkt_len;
+	u8 ack_frame_id;
+	u64 cookie;
+};
+
+enum nxpwifi_wmm_ac_e {
+	WMM_AC_BK,
+	WMM_AC_BE,
+	WMM_AC_VI,
+	WMM_AC_VO
+} __packed;
+
+struct nxpwifi_types_wmm_info {
+	u8 oui[4];
+	u8 subtype;
+	u8 version;
+	u8 qos_info;
+	u8 reserved;
+	struct ieee80211_wmm_ac_param ac[IEEE80211_NUM_ACS];
+} __packed;
+
+struct nxpwifi_arp_eth_header {
+	struct arphdr hdr;
+	u8 ar_sha[ETH_ALEN];
+	u8 ar_sip[4];
+	u8 ar_tha[ETH_ALEN];
+	u8 ar_tip[4];
+} __packed;
+
+struct nxpwifi_chan_stats {
+	u8 chan_num;
+	u8 bandcfg;
+	u8 flags;
+	s8 noise;
+	u16 total_bss;
+	u16 cca_scan_dur;
+	u16 cca_busy_dur;
+} __packed;
+
+#define NXPWIFI_HIST_MAX_SAMPLES	1048576
+#define NXPWIFI_MAX_RX_RATES		     44
+#define NXPWIFI_MAX_AC_RX_RATES		     74
+#define NXPWIFI_MAX_SNR			    256
+#define NXPWIFI_MAX_NOISE_FLR		    256
+#define NXPWIFI_MAX_SIG_STRENGTH	    256
+
+struct nxpwifi_histogram_data {
+	atomic_t rx_rate[NXPWIFI_MAX_AC_RX_RATES];
+	atomic_t snr[NXPWIFI_MAX_SNR];
+	atomic_t noise_flr[NXPWIFI_MAX_NOISE_FLR];
+	atomic_t sig_str[NXPWIFI_MAX_SIG_STRENGTH];
+	atomic_t num_samples;
+};
+
+struct nxpwifi_iface_comb {
+	u8 sta_intf;
+	u8 uap_intf;
+};
+
+struct nxpwifi_radar_params {
+	struct cfg80211_chan_def *chandef;
+	u32 cac_time_ms;
+} __packed;
+
+struct nxpwifi_11h_intf_state {
+	bool is_11h_enabled;
+	bool is_11h_active;
+} __packed;
+
+#define NXPWIFI_FW_DUMP_IDX		0xff
+#define NXPWIFI_FW_DUMP_MAX_MEMSIZE     0x160000
+#define NXPWIFI_DRV_INFO_IDX		20
+#define FW_DUMP_MAX_NAME_LEN		8
+#define FW_DUMP_HOST_READY      0xEE
+#define FW_DUMP_DONE			0xFF
+#define FW_DUMP_READ_DONE		0xFE
+
+/* Channel bandwidth */
+#define CHANNEL_BW_20MHZ 0
+#define CHANNEL_BW_40MHZ_ABOVE 1
+#define CHANNEL_BW_40MHZ_BELOW 3
+/* secondary channel is 80MHz bandwidth for 11ac */
+#define CHANNEL_BW_80MHZ 4
+#define CHANNEL_BW_160MHZ 5
+
+struct memory_type_mapping {
+	u8 mem_name[FW_DUMP_MAX_NAME_LEN];
+	u8 *mem_ptr;
+	u32 mem_size;
+	u8 done_flag;
+};
+
+enum rdwr_status {
+	RDWR_STATUS_SUCCESS = 0,
+	RDWR_STATUS_FAILURE = 1,
+	RDWR_STATUS_DONE = 2
+};
+
+enum nxpwifi_chan_band {
+	BAND_2GHZ = 0,
+	BAND_5GHZ,
+	BAND_6GHZ,
+	BAND_4GHZ,
+};
+
+enum nxpwifi_chan_width {
+	CHAN_BW_20MHZ = 0,
+	CHAN_BW_10MHZ,
+	CHAN_BW_40MHZ,
+	CHAN_BW_80MHZ,
+	CHAN_BW_8080MHZ,
+	CHAN_BW_160MHZ,
+	CHAN_BW_5MHZ,
+};
+
+enum {
+	NXPWIFI_SCAN_TYPE_UNCHANGED = 0,
+	NXPWIFI_SCAN_TYPE_ACTIVE,
+	NXPWIFI_SCAN_TYPE_PASSIVE
+};
+
+#define NXPWIFI_PROMISC_MODE            1
+#define NXPWIFI_MULTICAST_MODE		2
+#define	NXPWIFI_ALL_MULTI_MODE		4
+#define NXPWIFI_MAX_MULTICAST_LIST_SIZE	32
+
+struct nxpwifi_multicast_list {
+	u32 mode;
+	u32 num_multicast_addr;
+	u8 mac_list[NXPWIFI_MAX_MULTICAST_LIST_SIZE][ETH_ALEN];
+};
+
+struct nxpwifi_chan_freq {
+	u32 channel;
+	u32 freq;
+};
+
+struct nxpwifi_ssid_bssid {
+	struct cfg80211_ssid ssid;
+	u8 bssid[ETH_ALEN];
+};
+
+enum {
+	BAND_B = 1,
+	BAND_G = 2,
+	BAND_A = 4,
+	BAND_GN = 8,
+	BAND_AN = 16,
+	BAND_GAC = 32,
+	BAND_AAC = 64,
+	BAND_GAX = 256,
+	BAND_AAX = 512,
+};
+
+#define NXPWIFI_WPA_PASSHPHRASE_LEN 64
+struct wpa_param {
+	u8 pairwise_cipher_wpa;
+	u8 pairwise_cipher_wpa2;
+	u8 group_cipher;
+	u32 length;
+	u8 passphrase[NXPWIFI_WPA_PASSHPHRASE_LEN];
+};
+
+struct wep_key {
+	u8 key_index;
+	u8 is_default;
+	u16 length;
+	u8 key[WLAN_KEY_LEN_WEP104];
+};
+
+#define KEY_MGMT_ON_HOST        0x03
+#define NXPWIFI_AUTH_MODE_AUTO  0xFF
+#define BAND_CONFIG_BG          0x00
+#define BAND_CONFIG_A           0x01
+#define NXPWIFI_SEC_CHAN_BELOW	0x03
+#define NXPWIFI_SEC_CHAN_ABOVE	0x01
+#define NXPWIFI_SUPPORTED_RATES                 14
+#define NXPWIFI_SUPPORTED_RATES_EXT             32
+#define NXPWIFI_PRIO_BK				2
+#define NXPWIFI_PRIO_VI				5
+#define NXPWIFI_SUPPORTED_CHANNELS		2
+#define NXPWIFI_OPERATING_CLASSES		16
+
+struct nxpwifi_uap_bss_param {
+	u8 mac_addr[ETH_ALEN];
+	u8 channel;
+	u8 band_cfg;
+	u16 rts_threshold;
+	u16 frag_threshold;
+	u8 retry_limit;
+	struct nxpwifi_802_11_ssid ssid;
+	u8 bcast_ssid_ctl;
+	u8 radio_ctl;
+	u8 dtim_period;
+	u16 beacon_period;
+	u16 auth_mode;
+	u16 protocol;
+	u16 key_mgmt;
+	u16 key_mgmt_operation;
+	struct wpa_param wpa_cfg;
+	struct wep_key wep_cfg[NUM_WEP_KEYS];
+	struct ieee80211_ht_cap ht_cap;
+	struct ieee80211_vht_cap vht_cap;
+	u8 rates[NXPWIFI_SUPPORTED_RATES];
+	u32 sta_ao_timer;
+	u32 ps_sta_ao_timer;
+	u8 qos_info;
+	u8 power_constraint;
+	struct nxpwifi_types_wmm_info wmm_info;
+};
+
+struct nxpwifi_ds_get_stats {
+	u32 mcast_tx_frame;
+	u32 failed;
+	u32 retry;
+	u32 multi_retry;
+	u32 frame_dup;
+	u32 rts_success;
+	u32 rts_failure;
+	u32 ack_failure;
+	u32 rx_frag;
+	u32 mcast_rx_frame;
+	u32 fcs_error;
+	u32 tx_frame;
+	u32 wep_icv_error[4];
+	u32 bcn_rcv_cnt;
+	u32 bcn_miss_cnt;
+};
+
+#define NXPWIFI_MAX_VER_STR_LEN    128
+
+struct nxpwifi_ver_ext {
+	u32 version_str_sel;
+	char version_str[NXPWIFI_MAX_VER_STR_LEN];
+};
+
+struct nxpwifi_bss_info {
+	u32 bss_mode;
+	struct cfg80211_ssid ssid;
+	u32 bss_chan;
+	u8 country_code[3];
+	u32 media_connected;
+	u32 max_power_level;
+	u32 min_power_level;
+	signed int bcn_nf_last;
+	u32 wep_status;
+	u32 is_hs_configured;
+	u32 is_deep_sleep;
+	u8 bssid[ETH_ALEN];
+};
+
+struct nxpwifi_sta_info {
+	u8 peer_mac[ETH_ALEN];
+	struct station_parameters *params;
+};
+
+#define MAX_NUM_TID     8
+
+#define MAX_RX_WINSIZE  64
+
+struct nxpwifi_ds_rx_reorder_tbl {
+	u16 tid;
+	u8 ta[ETH_ALEN];
+	u32 start_win;
+	u32 win_size;
+	u32 buffer[MAX_RX_WINSIZE];
+};
+
+struct nxpwifi_ds_tx_ba_stream_tbl {
+	u16 tid;
+	u8 ra[ETH_ALEN];
+	u8 amsdu;
+};
+
+#define DBG_CMD_NUM    5
+#define NXPWIFI_DBG_SDIO_MP_NUM    10
+
+struct nxpwifi_debug_info {
+	unsigned int debug_mask;
+	u32 int_counter;
+	u32 packets_out[MAX_NUM_TID];
+	u32 tx_buf_size;
+	u32 curr_tx_buf_size;
+	u32 tx_tbl_num;
+	struct nxpwifi_ds_tx_ba_stream_tbl
+		tx_tbl[NXPWIFI_MAX_TX_BASTREAM_SUPPORTED];
+	u32 rx_tbl_num;
+	struct nxpwifi_ds_rx_reorder_tbl rx_tbl
+		[NXPWIFI_MAX_RX_BASTREAM_SUPPORTED];
+	u16 ps_mode;
+	u32 ps_state;
+	u8 is_deep_sleep;
+	u8 pm_wakeup_card_req;
+	u32 pm_wakeup_fw_try;
+	u8 is_hs_configured;
+	u8 hs_activated;
+	u32 num_cmd_host_to_card_failure;
+	u32 num_cmd_sleep_cfm_host_to_card_failure;
+	u32 num_tx_host_to_card_failure;
+	u32 num_event_deauth;
+	u32 num_event_disassoc;
+	u32 num_event_link_lost;
+	u32 num_cmd_deauth;
+	u32 num_cmd_assoc_success;
+	u32 num_cmd_assoc_failure;
+	u32 num_tx_timeout;
+	u8 is_cmd_timedout;
+	u16 timeout_cmd_id;
+	u16 timeout_cmd_act;
+	u16 last_cmd_id[DBG_CMD_NUM];
+	u16 last_cmd_act[DBG_CMD_NUM];
+	u16 last_cmd_index;
+	u16 last_cmd_resp_id[DBG_CMD_NUM];
+	u16 last_cmd_resp_index;
+	u16 last_event[DBG_CMD_NUM];
+	u16 last_event_index;
+	u8 data_sent;
+	u8 cmd_sent;
+	u8 cmd_resp_received;
+	u8 event_received;
+	u32 last_mp_wr_bitmap[NXPWIFI_DBG_SDIO_MP_NUM];
+	u32 last_mp_wr_ports[NXPWIFI_DBG_SDIO_MP_NUM];
+	u32 last_mp_wr_len[NXPWIFI_DBG_SDIO_MP_NUM];
+	u32 last_mp_curr_wr_port[NXPWIFI_DBG_SDIO_MP_NUM];
+	u8 last_sdio_mp_index;
+};
+
+#define NXPWIFI_KEY_INDEX_UNICAST	0x40000000
+#define PN_LEN				16
+
+struct nxpwifi_ds_encrypt_key {
+	u32 key_disable;
+	u32 key_index;
+	u32 key_len;
+	u32 key_cipher;
+	u8 key_material[WLAN_MAX_KEY_LEN];
+	u8 mac_addr[ETH_ALEN];
+	u8 pn[PN_LEN];		/* packet number */
+	u8 pn_len;
+	u8 is_igtk_key;
+	u8 is_current_wep_key;
+	u8 is_rx_seq_valid;
+	u8 is_igtk_def_key;
+};
+
+struct nxpwifi_power_cfg {
+	u32 is_power_auto;
+	u32 is_power_fixed;
+	u32 power_level;
+};
+
+struct nxpwifi_ds_hs_cfg {
+	u32 is_invoke_hostcmd;
+	/*
+	 * Bit0: non-unicast data
+	 * Bit1: unicast data
+	 * Bit2: mac events
+	 * Bit3: magic packet
+	 */
+	u32 conditions;
+	u32 gpio;
+	u32 gap;
+};
+
+struct nxpwifi_ds_wakeup_reason {
+	u16  hs_wakeup_reason;
+};
+
+#define DEEP_SLEEP_ON  1
+#define DEEP_SLEEP_OFF 0
+#define DEEP_SLEEP_IDLE_TIME	100
+#define PS_MODE_AUTO		1
+
+struct nxpwifi_ds_auto_ds {
+	u16 auto_ds;
+	u16 idle_time;
+};
+
+struct nxpwifi_ds_pm_cfg {
+	union {
+		u32 ps_mode;
+		struct nxpwifi_ds_hs_cfg hs_cfg;
+		struct nxpwifi_ds_auto_ds auto_deep_sleep;
+		u32 sleep_period;
+	} param;
+};
+
+struct nxpwifi_11ac_vht_cfg {
+	u8 band_config;
+	u8 misc_config;
+	u32 cap_info;
+	u32 mcs_tx_set;
+	u32 mcs_rx_set;
+};
+
+struct nxpwifi_ds_11n_tx_cfg {
+	u16 tx_htcap;
+	u16 tx_htinfo;
+	u16 misc_config; /* Needed for 802.11AC cards only */
+};
+
+struct nxpwifi_ds_11n_amsdu_aggr_ctrl {
+	u16 enable;
+	u16 curr_buf_size;
+};
+
+struct nxpwifi_ds_ant_cfg {
+	u32 tx_ant;
+	u32 rx_ant;
+};
+
+#define NXPWIFI_NUM_OF_CMD_BUFFER	50
+#define NXPWIFI_SIZE_OF_CMD_BUFFER	2048
+
+enum {
+	NXPWIFI_IE_TYPE_GEN_IE = 0,
+	NXPWIFI_IE_TYPE_ARP_FILTER,
+};
+
+enum {
+	NXPWIFI_REG_MAC = 1,
+	NXPWIFI_REG_BBP,
+	NXPWIFI_REG_RF,
+	NXPWIFI_REG_PMIC,
+	NXPWIFI_REG_CAU,
+};
+
+struct nxpwifi_ds_reg_rw {
+	u32 type;
+	u32 offset;
+	u32 value;
+};
+
+#define MAX_EEPROM_DATA 256
+
+struct nxpwifi_ds_read_eeprom {
+	u16 offset;
+	u16 byte_count;
+	u8 value[MAX_EEPROM_DATA];
+};
+
+struct nxpwifi_ds_mem_rw {
+	u32 addr;
+	u32 value;
+};
+
+#define IEEE_MAX_IE_SIZE		256
+
+#define NXPWIFI_IE_HDR_SIZE	(sizeof(struct nxpwifi_ie) - IEEE_MAX_IE_SIZE)
+
+struct nxpwifi_ds_misc_gen_ie {
+	u32 type;
+	u32 len;
+	u8 ie_data[IEEE_MAX_IE_SIZE];
+};
+
+struct nxpwifi_ds_misc_cmd {
+	u32 len;
+	u8 cmd[NXPWIFI_SIZE_OF_CMD_BUFFER];
+};
+
+#define BITMASK_BCN_RSSI_LOW	BIT(0)
+#define BITMASK_BCN_RSSI_HIGH	BIT(4)
+
+enum subsc_evt_rssi_state {
+	EVENT_HANDLED,
+	RSSI_LOW_RECVD,
+	RSSI_HIGH_RECVD
+};
+
+struct subsc_evt_cfg {
+	u8 abs_value;
+	u8 evt_freq;
+};
+
+struct nxpwifi_ds_misc_subsc_evt {
+	u16 action;
+	u16 events;
+	struct subsc_evt_cfg bcn_l_rssi_cfg;
+	struct subsc_evt_cfg bcn_h_rssi_cfg;
+};
+
+#define NXPWIFI_MEF_MAX_BYTESEQ		6	/* non-adjustable */
+#define NXPWIFI_MEF_MAX_FILTERS		10
+
+struct nxpwifi_mef_filter {
+	u16 repeat;
+	u16 offset;
+	s8 byte_seq[NXPWIFI_MEF_MAX_BYTESEQ + 1];
+	u8 filt_type;
+	u8 filt_action;
+};
+
+struct nxpwifi_mef_entry {
+	u8 mode;
+	u8 action;
+	struct nxpwifi_mef_filter filter[NXPWIFI_MEF_MAX_FILTERS];
+};
+
+struct nxpwifi_ds_mef_cfg {
+	u32 criteria;
+	u16 num_entries;
+	struct nxpwifi_mef_entry *mef_entry;
+};
+
+#define NXPWIFI_MAX_VSIE_LEN       (256)
+#define NXPWIFI_MAX_VSIE_NUM       (8)
+#define NXPWIFI_VSIE_MASK_CLEAR    0x00
+#define NXPWIFI_VSIE_MASK_SCAN     0x01
+#define NXPWIFI_VSIE_MASK_ASSOC    0x02
+#define NXPWIFI_VSIE_MASK_BGSCAN   0x08
+
+enum {
+	NXPWIFI_FUNC_INIT = 1,
+	NXPWIFI_FUNC_SHUTDOWN,
+};
+
+enum COALESCE_OPERATION {
+	RECV_FILTER_MATCH_TYPE_EQ = 0x80,
+	RECV_FILTER_MATCH_TYPE_NE,
+};
+
+enum COALESCE_PACKET_TYPE {
+	PACKET_TYPE_UNICAST = 1,
+	PACKET_TYPE_MULTICAST = 2,
+	PACKET_TYPE_BROADCAST = 3
+};
+
+#define NXPWIFI_COALESCE_MAX_RULES	8
+#define NXPWIFI_COALESCE_MAX_BYTESEQ	4	/* non-adjustable */
+#define NXPWIFI_COALESCE_MAX_FILTERS	4
+#define NXPWIFI_MAX_COALESCING_DELAY	100     /* in msecs */
+
+struct filt_field_param {
+	u8 operation;
+	u8 operand_len;
+	u16 offset;
+	u8 operand_byte_stream[NXPWIFI_COALESCE_MAX_BYTESEQ];
+};
+
+struct nxpwifi_coalesce_rule {
+	u16 max_coalescing_delay;
+	u8 num_of_fields;
+	u8 pkt_type;
+	struct filt_field_param params[NXPWIFI_COALESCE_MAX_FILTERS];
+};
+
+struct nxpwifi_ds_coalesce_cfg {
+	u16 num_of_rules;
+	struct nxpwifi_coalesce_rule rule[NXPWIFI_COALESCE_MAX_RULES];
+};
+
+struct nxpwifi_11ax_he_cap_cfg {
+	u16 id;
+	u16 len;
+	u8 ext_id;
+	struct ieee80211_he_cap_elem cap_elem;
+	u8 he_txrx_mcs_support[4];
+	u8 val[28];
+};
+
+#define HE_CAP_MAX_SIZE   54
+
+struct nxpwifi_11ax_he_cfg {
+	u8 band;
+	union {
+		struct nxpwifi_11ax_he_cap_cfg he_cap_cfg;
+		u8 data[HE_CAP_MAX_SIZE];
+	};
+};
+
+#define NXPWIFI_11AXCMD_CFG_ID_SR_OBSS_PD_OFFSET 1
+#define NXPWIFI_11AXCMD_CFG_ID_SR_ENABLE         2
+#define NXPWIFI_11AXCMD_CFG_ID_BEAM_CHANGE       3
+#define NXPWIFI_11AXCMD_CFG_ID_HTC_ENABLE        4
+#define NXPWIFI_11AXCMD_CFG_ID_TXOP_RTS          5
+#define NXPWIFI_11AXCMD_CFG_ID_TX_OMI            6
+#define NXPWIFI_11AXCMD_CFG_ID_OBSSNBRU_TOLTIME  7
+#define NXPWIFI_11AXCMD_CFG_ID_SET_BSRP          8
+#define NXPWIFI_11AXCMD_CFG_ID_LLDE              9
+
+#define NXPWIFI_11AXCMD_SR_SUBID                 0x102
+#define NXPWIFI_11AXCMD_BEAM_SUBID               0x103
+#define NXPWIFI_11AXCMD_HTC_SUBID                0x104
+#define NXPWIFI_11AXCMD_TXOMI_SUBID              0x105
+#define NXPWIFI_11AXCMD_OBSS_TOLTIME_SUBID       0x106
+#define NXPWIFI_11AXCMD_TXOPRTS_SUBID            0x108
+#define NXPWIFI_11AXCMD_SET_BSRP_SUBID           0x109
+#define NXPWIFI_11AXCMD_LLDE_SUBID               0x110
+
+#define NXPWIFI_11AX_TWT_SETUP_SUBID             0x114
+#define NXPWIFI_11AX_TWT_TEARDOWN_SUBID          0x115
+#define NXPWIFI_11AX_TWT_REPORT_SUBID            0x116
+#define NXPWIFI_11AX_TWT_INFORMATION_SUBID       0x119
+#define NXPWIFI_11AX_BTWT_AP_CONFIG_SUBID        0x120
+#define BTWT_AGREEMENT_MAX 5
+
+struct nxpwifi_11axcmdcfg_obss_pd_offset {
+	/* <NON_SRG_OffSET, SRG_OFFSET> */
+	u8 offset[2];
+};
+
+struct nxpwifi_11axcmdcfg_sr_control {
+	/* 1 enable, 0 disable */
+	u8 control;
+};
+
+struct nxpwifi_11ax_sr_cmd {
+	/* type */
+	u16 type;
+	/* length of TLV */
+	u16 len;
+	/* value */
+	union {
+		struct nxpwifi_11axcmdcfg_obss_pd_offset obss_pd_offset;
+		struct nxpwifi_11axcmdcfg_sr_control sr_control;
+	} param;
+};
+
+struct nxpwifi_11ax_beam_cmd {
+	/* command value: 1 is disable, 0 is enable */
+	u8 value;
+};
+
+struct nxpwifi_11ax_htc_cmd {
+	/* command value: 1 is enable, 0 is disable */
+	u8 value;
+};
+
+struct nxpwifi_11ax_txomi_cmd {
+	/* 11ax spec 9.2.4.6a.2 OM Control 12 bits. Bit 0 to bit 11 */
+	u16 omi;
+	/*
+	 * tx option
+	 * 0: send OMI in QoS NULL; 1: send OMI in QoS data; 0xFF: set OMI in
+	 * both
+	 */
+	u8 tx_option;
+	/*
+	 * if OMI is sent in QoS data, specify the number of consecutive data
+	 * packets containing the OMI
+	 */
+	u8 num_data_pkts;
+};
+
+struct nxpwifi_11ax_toltime_cmd {
+	/* OBSS Narrow Bandwidth RU Tolerance Time */
+	u32 tol_time;
+};
+
+struct nxpwifi_11ax_txop_cmd {
+	/*
+	 * Two byte rts threshold value of which only 10 bits, bit 0 to bit 9
+	 * are valid
+	 */
+	u16 rts_thres;
+};
+
+struct nxpwifi_11ax_set_bsrp_cmd {
+	/* command value: 1 is enable, 0 is disable */
+	u8 value;
+};
+
+struct nxpwifi_11ax_llde_cmd {
+	/* Uplink LLDE: enable=1,disable=0 */
+	u8 llde;
+	/* operation mode: default=0,carplay=1,gameplay=2 */
+	u8 mode;
+	/* trigger frame rate: auto=0xff */
+	u8 fixrate;
+	/* cap airtime limit index: auto=0xff */
+	u8 trigger_limit;
+	/* cap peak UL rate */
+	u8 peak_ul_rate;
+	/* Downlink LLDE: enable=1,disable=0 */
+	u8 dl_llde;
+	/* Set trigger frame interval(us): auto=0 */
+	u16 poll_interval;
+	/* Set TxOp duration */
+	u16 tx_op_duration;
+	/* for other configurations */
+	u16 llde_ctrl;
+	u16 mu_rts_successcnt;
+	u16 mu_rts_failcnt;
+	u16 basic_trigger_successcnt;
+	u16 basic_trigger_failcnt;
+	u16 tbppdu_nullcnt;
+	u16 tbppdu_datacnt;
+};
+
+struct nxpwifi_11ax_cmd_cfg {
+	u32 sub_command;
+	u32 sub_id;
+	union {
+		struct nxpwifi_11ax_sr_cmd sr_cfg;
+		struct nxpwifi_11ax_beam_cmd beam_cfg;
+		struct nxpwifi_11ax_htc_cmd htc_cfg;
+		struct nxpwifi_11ax_txomi_cmd txomi_cfg;
+		struct nxpwifi_11ax_toltime_cmd toltime_cfg;
+		struct nxpwifi_11ax_txop_cmd txop_cfg;
+		struct nxpwifi_11ax_set_bsrp_cmd setbsrp_cfg;
+		struct nxpwifi_11ax_llde_cmd llde_cfg;
+	} param;
+};
+
+struct nxpwifi_twt_setup {
+	/** Implicit, 0: TWT session is explicit, 1: Session is implicit */
+	u8 implicit;
+	/** Announced, 0: Unannounced, 1: Announced TWT */
+	u8 announced;
+	/** Trigger Enabled, 0: Non-Trigger enabled, 1: Trigger enabled TWT */
+	u8 trigger_enabled;
+	/** TWT Information Disabled, 0: TWT info enabled, 1: TWT info disabled */
+	u8 twt_info_disabled;
+	/*
+	 * Negotiation Type, 0: Future Individual TWT SP start time, 1:
+	 * Next Wake TBTT time
+	 */
+	u8 negotiation_type;
+	/*
+	 * TWT Wakeup Duration, time after which the TWT requesting STA can
+	 * transition to doze state
+	 */
+	u8 twt_wakeup_duration;
+	/** Flow Identifier. Range: [0-7]*/
+	u8 flow_identifier;
+	/*
+	 * Hard Constraint, 0: FW can tweak the TWT setup parameters if it is
+	 * rejected by AP.
+	 * 1: Firmware should not tweak any parameters.
+	 */
+	u8 hard_constraint;
+	/** TWT Exponent, Range: [0-63] */
+	u8 twt_exponent;
+	/** TWT Mantissa Range: [0-sizeof(UINT16)] */
+	__le16 twt_mantissa;
+	/** TWT Request Type, 0: REQUEST_TWT, 1: SUGGEST_TWT*/
+	u8 twt_request;
+	/** TWT Setup State. Set to 0 by driver, filled by FW in response*/
+	u8 twt_setup_state;
+	/** TWT link lost timeout threshold */
+	__le16 bcn_miss_threshold;
+} __packed;
+
+struct nxpwifi_twt_teardown {
+	/** TWT Flow Identifier. Range: [0-7] */
+	u8 flow_identifier;
+	/*
+	 * Negotiation Type. 0: Future Individual TWT SP start time, 1: Next
+	 * Wake TBTT time
+	 */
+	u8 negotiation_type;
+	/** Tear down all TWT. 1: To teardown all TWT, 0 otherwise */
+	u8 teardown_all_twt;
+	/** TWT Teardown State. Set to 0 by driver, filled by FW in response */
+	u8 twt_teardown_state;
+	/** Reserved, set to 0. */
+	u8 reserved[3];
+} __packed;
+
+#define NXPWIFI_BTWT_REPORT_LEN 9
+#define NXPWIFI_BTWT_REPORT_MAX_NUM 4
+struct nxpwifi_twt_report {
+	/** TWT report type, 0: BTWT id */
+	u8 type;
+	/** TWT report length of value in data */
+	u8 length;
+	u8 reserve[2];
+	/** TWT report payload for FW response to fill */
+	u8 data[NXPWIFI_BTWT_REPORT_LEN * NXPWIFI_BTWT_REPORT_MAX_NUM];
+} __packed;
+
+struct nxpwifi_twt_information {
+	/** TWT Flow Identifier. Range: [0-7] */
+	u8 flow_identifier;
+	/*
+	 * Suspend Duration. Range: [0-UINT32_MAX]
+	 * 0:Suspend forever;
+	 * Else:Suspend agreement for specific duration in milli seconds,
+	 * after than resume the agreement and enter SP immediately
+	 */
+	__le32 suspend_duration;
+	/** TWT Information State. Set to 0 by driver, filled by FW in response */
+	u8 twt_information_state;
+} __packed;
+
+struct btwt_set {
+	u8 btwt_id;
+	__le16 ap_bcast_mantissa;
+	u8 ap_bcast_exponent;
+	u8 nominalwake;
+} __packed;
+
+#define BTWT_AGREEMENT_MAX 5
+struct nxpwifi_btwt_ap_config {
+	u8 ap_bcast_bet_sta_wait;
+	__le16 ap_bcast_offset;
+	u8 bcast_twtli;
+	u8 count;
+	struct btwt_set btwt_sets[BTWT_AGREEMENT_MAX];
+} __packed;
+
+struct nxpwifi_twt_cfg {
+	u16 action;
+	u16 sub_id;
+	union {
+		struct nxpwifi_twt_setup twt_setup;
+		struct nxpwifi_twt_teardown twt_teardown;
+		struct nxpwifi_twt_report twt_report;
+		struct nxpwifi_twt_information twt_information;
+		struct nxpwifi_btwt_ap_config btwt_ap_config;
+	} param;
+};
+#endif /* !_NXPWIFI_CFG_H_ */
diff --git a/drivers/net/wireless/nxp/nxpwifi/sta_cfg.c b/drivers/net/wireless/nxp/nxpwifi/sta_cfg.c
new file mode 100644
index 000000000000..229f026fa866
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/sta_cfg.c
@@ -0,0 +1,1177 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * nxpwifi: functions for station ioctl
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "cmdevt.h"
+#include "wmm.h"
+#include "11n.h"
+#include "cfg80211.h"
+
+static int disconnect_on_suspend;
+
+/* Copies the multicast address list from device to driver */
+int nxpwifi_copy_mcast_addr(struct nxpwifi_multicast_list *mlist,
+			    struct net_device *dev)
+{
+	int i = 0;
+	struct netdev_hw_addr *ha;
+
+	netdev_for_each_mc_addr(ha, dev)
+		memcpy(&mlist->mac_list[i++], ha->addr, ETH_ALEN);
+
+	return i;
+}
+
+/* Wait queue completion handler */
+int nxpwifi_wait_queue_complete(struct nxpwifi_adapter *adapter,
+				struct cmd_ctrl_node *cmd_queued)
+{
+	int status;
+
+	/* Wait for completion */
+	status = wait_event_interruptible_timeout(adapter->cmd_wait_q.wait,
+						  *cmd_queued->condition,
+						  (12 * HZ));
+	if (status <= 0) {
+		if (status == 0)
+			status = -ETIMEDOUT;
+		nxpwifi_dbg(adapter, ERROR, "cmd_wait_q terminated: %d\n",
+			    status);
+		nxpwifi_cancel_all_pending_cmd(adapter);
+		return status;
+	}
+
+	status = adapter->cmd_wait_q.status;
+	adapter->cmd_wait_q.status = 0;
+
+	return status;
+}
+
+/* Set multicast list by issuing the proper firmware command */
+int
+nxpwifi_request_set_multicast_list(struct nxpwifi_private *priv,
+				   struct nxpwifi_multicast_list *mcast_list)
+{
+	int ret = 0;
+	u16 old_pkt_filter;
+
+	old_pkt_filter = priv->curr_pkt_filter;
+
+	if (mcast_list->mode == NXPWIFI_PROMISC_MODE) {
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "info: Enable Promiscuous mode\n");
+		priv->curr_pkt_filter |= HOST_ACT_MAC_PROMISCUOUS_ENABLE;
+		priv->curr_pkt_filter &=
+			~HOST_ACT_MAC_ALL_MULTICAST_ENABLE;
+	} else {
+		/* Multicast */
+		priv->curr_pkt_filter &= ~HOST_ACT_MAC_PROMISCUOUS_ENABLE;
+		if (mcast_list->mode == NXPWIFI_ALL_MULTI_MODE) {
+			nxpwifi_dbg(priv->adapter, INFO,
+				    "info: Enabling All Multicast!\n");
+			priv->curr_pkt_filter |=
+				HOST_ACT_MAC_ALL_MULTICAST_ENABLE;
+		} else {
+			priv->curr_pkt_filter &=
+				~HOST_ACT_MAC_ALL_MULTICAST_ENABLE;
+			nxpwifi_dbg(priv->adapter, INFO,
+				    "info: Set multicast list=%d\n",
+				    mcast_list->num_multicast_addr);
+			/* Send multicast addresses to firmware */
+			ret = nxpwifi_send_cmd(priv,
+					       HOST_CMD_MAC_MULTICAST_ADR,
+					       HOST_ACT_GEN_SET, 0,
+					       mcast_list, false);
+		}
+	}
+	nxpwifi_dbg(priv->adapter, INFO,
+		    "info: old_pkt_filter=%#x, curr_pkt_filter=%#x\n",
+		    old_pkt_filter, priv->curr_pkt_filter);
+	if (old_pkt_filter != priv->curr_pkt_filter) {
+		ret = nxpwifi_send_cmd(priv, HOST_CMD_MAC_CONTROL,
+				       HOST_ACT_GEN_SET,
+				       0, &priv->curr_pkt_filter, false);
+	}
+
+	return ret;
+}
+
+/* Fill BSS descriptor from cfg80211_bss */
+int nxpwifi_fill_new_bss_desc(struct nxpwifi_private *priv,
+			      struct cfg80211_bss *bss,
+			      struct nxpwifi_bssdescriptor *bss_desc)
+{
+	u8 *beacon_ie;
+	size_t beacon_ie_len;
+	struct nxpwifi_bss_priv *bss_priv = (void *)bss->priv;
+	const struct cfg80211_bss_ies *ies;
+
+	rcu_read_lock();
+	ies = rcu_dereference(bss->ies);
+	beacon_ie = kmemdup(ies->data, ies->len, GFP_ATOMIC);
+	beacon_ie_len = ies->len;
+	bss_desc->timestamp = ies->tsf;
+	rcu_read_unlock();
+
+	if (!beacon_ie) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    " failed to alloc beacon_ie\n");
+		return -ENOMEM;
+	}
+
+	memcpy(bss_desc->mac_address, bss->bssid, ETH_ALEN);
+	bss_desc->rssi = bss->signal;
+	/* The caller of this function will free beacon_ie */
+	bss_desc->beacon_buf = beacon_ie;
+	bss_desc->beacon_buf_size = beacon_ie_len;
+	bss_desc->beacon_period = bss->beacon_interval;
+	bss_desc->cap_info_bitmap = bss->capability;
+	bss_desc->bss_band = bss_priv->band;
+	bss_desc->fw_tsf = bss_priv->fw_tsf;
+	if (bss_desc->cap_info_bitmap & WLAN_CAPABILITY_PRIVACY) {
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "info: InterpretIE: AP WEP enabled\n");
+		bss_desc->privacy = NXPWIFI_802_11_PRIV_FILTER_8021X_WEP;
+	} else {
+		bss_desc->privacy = NXPWIFI_802_11_PRIV_FILTER_ACCEPT_ALL;
+	}
+	bss_desc->bss_mode = NL80211_IFTYPE_STATION;
+
+	/* Disable 11ac by default */
+	bss_desc->disable_11ac = true;
+	/* Disable 11ax by default */
+	bss_desc->disable_11ax = true;
+
+	if (bss_desc->cap_info_bitmap & WLAN_CAPABILITY_SPECTRUM_MGMT)
+		bss_desc->sensed_11h = true;
+
+	return nxpwifi_update_bss_desc_with_ie(priv->adapter, bss_desc);
+}
+
+void nxpwifi_dnld_txpwr_table(struct nxpwifi_private *priv)
+{
+	if (priv->adapter->dt_node) {
+		char txpwr[] = {"nxp,00_txpwrlimit"};
+
+		memcpy(&txpwr[8], priv->adapter->country_code, 2);
+		nxpwifi_dnld_dt_cfgdata(priv, priv->adapter->dt_node, txpwr);
+	}
+}
+
+static int nxpwifi_process_country_ie(struct nxpwifi_private *priv,
+				      struct cfg80211_bss *bss)
+{
+	const u8 *country_ie;
+	u8 country_ie_len;
+	struct nxpwifi_802_11d_domain_reg *domain_info =
+					&priv->adapter->domain_reg;
+	int ret;
+
+	rcu_read_lock();
+	country_ie = ieee80211_bss_get_ie(bss, WLAN_EID_COUNTRY);
+	if (!country_ie) {
+		rcu_read_unlock();
+		return 0;
+	}
+
+	country_ie_len = country_ie[1];
+	if (country_ie_len < IEEE80211_COUNTRY_IE_MIN_LEN) {
+		rcu_read_unlock();
+		return 0;
+	}
+
+	if (!strncmp(priv->adapter->country_code, &country_ie[2], 2)) {
+		rcu_read_unlock();
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "11D: skip setting domain info in FW\n");
+		return 0;
+	}
+
+	if (country_ie_len >
+	    (IEEE80211_COUNTRY_STRING_LEN + NXPWIFI_MAX_TRIPLET_802_11D)) {
+		rcu_read_unlock();
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "11D: country_ie_len overflow!, deauth AP\n");
+		return -EINVAL;
+	}
+
+	memcpy(priv->adapter->country_code, &country_ie[2], 2);
+
+	domain_info->country_code[0] = country_ie[2];
+	domain_info->country_code[1] = country_ie[3];
+	domain_info->country_code[2] = ' ';
+
+	country_ie_len -= IEEE80211_COUNTRY_STRING_LEN;
+
+	domain_info->no_of_triplet =
+		country_ie_len / sizeof(struct ieee80211_country_ie_triplet);
+
+	memcpy((u8 *)domain_info->triplet,
+	       &country_ie[2] + IEEE80211_COUNTRY_STRING_LEN, country_ie_len);
+
+	rcu_read_unlock();
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11D_DOMAIN_INFO,
+			       HOST_ACT_GEN_SET, 0, NULL, false);
+	if (ret)
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "11D: setting domain info in FW fail\n");
+	else
+		nxpwifi_dnld_txpwr_table(priv);
+
+	return ret;
+}
+
+/* In infra mode, an deauthentication is performed first */
+int nxpwifi_bss_start(struct nxpwifi_private *priv, struct cfg80211_bss *bss,
+		      struct cfg80211_ssid *req_ssid)
+{
+	int ret;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_bssdescriptor *bss_desc = NULL;
+	u16 config_bands;
+
+	priv->scan_block = false;
+
+	if (adapter->region_code == 0x00 &&
+	    nxpwifi_process_country_ie(priv, bss))
+		return -EINVAL;
+
+	/* Allocate and fill new bss descriptor */
+	bss_desc = kzalloc(sizeof(*bss_desc), GFP_KERNEL);
+	if (!bss_desc)
+		return -ENOMEM;
+
+	ret = nxpwifi_fill_new_bss_desc(priv, bss, bss_desc);
+	if (ret)
+		goto done;
+
+	if (nxpwifi_band_to_radio_type(bss_desc->bss_band) ==
+				       HOST_SCAN_RADIO_TYPE_BG) {
+		config_bands = BAND_B | BAND_G | BAND_GN;
+		if (adapter->fw_bands & BAND_GAC)
+			config_bands |= BAND_GAC;
+		if (adapter->fw_bands & BAND_GAX)
+			config_bands |= BAND_GAX;
+	} else {
+		config_bands = BAND_A | BAND_AN;
+		if (adapter->fw_bands & BAND_AAC)
+			config_bands |= BAND_AAC;
+		if (adapter->fw_bands & BAND_AAX)
+			config_bands |= BAND_AAX;
+	}
+
+	if (!((config_bands | adapter->fw_bands) & ~adapter->fw_bands))
+		priv->config_bands = config_bands;
+
+	ret = nxpwifi_check_network_compatibility(priv, bss_desc);
+	if (ret)
+		goto done;
+
+	if (nxpwifi_11h_get_csa_closed_channel(priv) == (u8)bss_desc->channel) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "Attempt to reconnect on csa closed chan(%d)\n",
+			    bss_desc->channel);
+		ret = -EINVAL;
+		goto done;
+	}
+
+	nxpwifi_stop_net_dev_queue(priv->netdev, adapter);
+	netif_carrier_off(priv->netdev);
+
+	/* Clear any past association response stored for application retrieval */
+	priv->assoc_rsp_size = 0;
+	ret = nxpwifi_associate(priv, bss_desc);
+
+	/*
+	 * If auth type is auto and association fails using open mode, try to connect
+	 * using shared mode
+	 */
+	if (ret == WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG &&
+	    priv->sec_info.is_authtype_auto &&
+	    priv->sec_info.wep_enabled) {
+		priv->sec_info.authentication_mode =
+			NL80211_AUTHTYPE_SHARED_KEY;
+		ret = nxpwifi_associate(priv, bss_desc);
+	}
+
+done:
+	/* beacon_ie buffer was allocated in function nxpwifi_fill_new_bss_desc() */
+	if (bss_desc)
+		kfree(bss_desc->beacon_buf);
+	kfree(bss_desc);
+
+	if (ret < 0)
+		priv->attempted_bss_desc = NULL;
+
+	return ret;
+}
+
+/* IOCTL request handler to set host sleep configuration */
+int nxpwifi_set_hs_params(struct nxpwifi_private *priv, u16 action,
+			  int cmd_type, struct nxpwifi_ds_hs_cfg *hs_cfg)
+
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int status = 0;
+	u32 prev_cond = 0;
+
+	if (!hs_cfg)
+		return -ENOMEM;
+
+	switch (action) {
+	case HOST_ACT_GEN_SET:
+		if (adapter->pps_uapsd_mode) {
+			nxpwifi_dbg(adapter, INFO,
+				    "info: Host Sleep IOCTL\t"
+				    "is blocked in UAPSD/PPS mode\n");
+			status = -EPERM;
+			break;
+		}
+		if (hs_cfg->is_invoke_hostcmd) {
+			if (hs_cfg->conditions == HS_CFG_CANCEL) {
+				if (!test_bit(NXPWIFI_IS_HS_CONFIGURED,
+					      &adapter->work_flags))
+					/* Already cancelled */
+					break;
+				/* Save previous condition */
+				prev_cond = le32_to_cpu(adapter->hs_cfg
+							.conditions);
+				adapter->hs_cfg.conditions =
+						cpu_to_le32(hs_cfg->conditions);
+			} else if (hs_cfg->conditions) {
+				adapter->hs_cfg.conditions =
+						cpu_to_le32(hs_cfg->conditions);
+				adapter->hs_cfg.gpio = (u8)hs_cfg->gpio;
+				if (hs_cfg->gap)
+					adapter->hs_cfg.gap = (u8)hs_cfg->gap;
+			} else if (adapter->hs_cfg.conditions ==
+				   cpu_to_le32(HS_CFG_CANCEL)) {
+				status = -EINVAL;
+				break;
+			}
+
+			status = nxpwifi_send_cmd(priv,
+						  HOST_CMD_802_11_HS_CFG_ENH,
+						  HOST_ACT_GEN_SET, 0,
+						  &adapter->hs_cfg,
+						  cmd_type == NXPWIFI_SYNC_CMD);
+
+			if (hs_cfg->conditions == HS_CFG_CANCEL)
+				/* Restore previous condition */
+				adapter->hs_cfg.conditions =
+						cpu_to_le32(prev_cond);
+		} else {
+			adapter->hs_cfg.conditions =
+						cpu_to_le32(hs_cfg->conditions);
+			adapter->hs_cfg.gpio = (u8)hs_cfg->gpio;
+			adapter->hs_cfg.gap = (u8)hs_cfg->gap;
+		}
+		break;
+	case HOST_ACT_GEN_GET:
+		hs_cfg->conditions = le32_to_cpu(adapter->hs_cfg.conditions);
+		hs_cfg->gpio = adapter->hs_cfg.gpio;
+		hs_cfg->gap = adapter->hs_cfg.gap;
+		break;
+	default:
+		status = -EINVAL;
+		break;
+	}
+
+	return status;
+}
+
+/* Sends IOCTL request to cancel the existing Host Sleep configuration */
+int nxpwifi_cancel_hs(struct nxpwifi_private *priv, int cmd_type)
+{
+	struct nxpwifi_ds_hs_cfg hscfg;
+
+	hscfg.conditions = HS_CFG_CANCEL;
+	hscfg.is_invoke_hostcmd = true;
+
+	return nxpwifi_set_hs_params(priv, HOST_ACT_GEN_SET,
+				    cmd_type, &hscfg);
+}
+EXPORT_SYMBOL_GPL(nxpwifi_cancel_hs);
+
+/* Sends IOCTL request to cancel the existing Host Sleep configuration */
+bool nxpwifi_enable_hs(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_ds_hs_cfg hscfg;
+	struct nxpwifi_private *priv;
+	int i;
+
+	if (disconnect_on_suspend) {
+		for (i = 0; i < adapter->priv_num; i++) {
+			priv = adapter->priv[i];
+			nxpwifi_deauthenticate(priv, NULL);
+		}
+	}
+
+	priv = nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_STA);
+
+	if (priv && priv->sched_scanning) {
+#ifdef CONFIG_PM
+		if (priv->wdev.wiphy->wowlan_config &&
+		    !priv->wdev.wiphy->wowlan_config->nd_config) {
+#endif
+			nxpwifi_dbg(adapter, CMD, "aborting bgscan!\n");
+			nxpwifi_stop_bg_scan(priv);
+			cfg80211_sched_scan_stopped(priv->wdev.wiphy, 0);
+#ifdef CONFIG_PM
+		}
+#endif
+	}
+
+	if (adapter->hs_activated) {
+		nxpwifi_dbg(adapter, CMD,
+			    "cmd: HS Already activated\n");
+		return true;
+	}
+
+	adapter->hs_activate_wait_q_woken = false;
+
+	memset(&hscfg, 0, sizeof(hscfg));
+	hscfg.is_invoke_hostcmd = true;
+
+	set_bit(NXPWIFI_IS_HS_ENABLING, &adapter->work_flags);
+	nxpwifi_cancel_all_pending_cmd(adapter);
+
+	if (nxpwifi_set_hs_params(nxpwifi_get_priv(adapter,
+						   NXPWIFI_BSS_ROLE_STA),
+				  HOST_ACT_GEN_SET, NXPWIFI_SYNC_CMD,
+				  &hscfg)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "IOCTL request HS enable failed\n");
+		return false;
+	}
+
+	if (wait_event_interruptible_timeout(adapter->hs_activate_wait_q,
+					     adapter->hs_activate_wait_q_woken,
+					     (10 * HZ)) <= 0) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "hs_activate_wait_q terminated\n");
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_enable_hs);
+
+/* IOCTL request handler to get BSS information */
+int nxpwifi_get_bss_info(struct nxpwifi_private *priv,
+			 struct nxpwifi_bss_info *info)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_bssdescriptor *bss_desc;
+
+	if (!info)
+		return -EINVAL;
+
+	bss_desc = &priv->curr_bss_params.bss_descriptor;
+
+	info->bss_mode = priv->bss_mode;
+
+	memcpy(&info->ssid, &bss_desc->ssid, sizeof(struct cfg80211_ssid));
+
+	memcpy(&info->bssid, &bss_desc->mac_address, ETH_ALEN);
+
+	info->bss_chan = bss_desc->channel;
+
+	memcpy(info->country_code, adapter->country_code,
+	       IEEE80211_COUNTRY_STRING_LEN);
+
+	info->media_connected = priv->media_connected;
+
+	info->max_power_level = priv->max_tx_power_level;
+	info->min_power_level = priv->min_tx_power_level;
+
+	info->bcn_nf_last = priv->bcn_nf_last;
+
+	if (priv->sec_info.wep_enabled)
+		info->wep_status = true;
+	else
+		info->wep_status = false;
+
+	info->is_hs_configured = test_bit(NXPWIFI_IS_HS_CONFIGURED,
+					  &adapter->work_flags);
+	info->is_deep_sleep = adapter->is_deep_sleep;
+
+	return 0;
+}
+
+/* The function disables auto deep sleep mode */
+int nxpwifi_disable_auto_ds(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_ds_auto_ds auto_ds = {
+		.auto_ds = DEEP_SLEEP_OFF,
+	};
+
+	return nxpwifi_send_cmd(priv, HOST_CMD_802_11_PS_MODE_ENH,
+				DIS_AUTO_PS, BITMAP_AUTO_DS, &auto_ds, true);
+}
+EXPORT_SYMBOL_GPL(nxpwifi_disable_auto_ds);
+
+/* Sends IOCTL request to get the data rate */
+int nxpwifi_drv_get_data_rate(struct nxpwifi_private *priv, u32 *rate)
+{
+	int ret;
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11_TX_RATE_QUERY,
+			       HOST_ACT_GEN_GET, 0, NULL, true);
+
+	if (!ret) {
+		if (priv->is_data_rate_auto)
+			*rate = nxpwifi_index_to_data_rate(priv, priv->tx_rate,
+							   priv->tx_htinfo);
+		else
+			*rate = priv->data_rate;
+	}
+
+	return ret;
+}
+
+/* IOCTL request handler to set tx power configuration */
+int nxpwifi_set_tx_power(struct nxpwifi_private *priv,
+			 struct nxpwifi_power_cfg *power_cfg)
+{
+	int ret;
+	struct host_cmd_ds_txpwr_cfg *txp_cfg;
+	struct nxpwifi_types_power_group *pg_tlv;
+	struct nxpwifi_power_group *pg;
+	u8 *buf;
+	u16 dbm = 0;
+
+	if (!power_cfg->is_power_auto) {
+		dbm = (u16)power_cfg->power_level;
+		if (dbm < priv->min_tx_power_level ||
+		    dbm > priv->max_tx_power_level) {
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "txpower value %d dBm\t"
+				    "is out of range (%d dBm-%d dBm)\n",
+				    dbm, priv->min_tx_power_level,
+				    priv->max_tx_power_level);
+			return -EINVAL;
+		}
+	}
+	buf = kzalloc(NXPWIFI_SIZE_OF_CMD_BUFFER, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	txp_cfg = (struct host_cmd_ds_txpwr_cfg *)buf;
+	txp_cfg->action = cpu_to_le16(HOST_ACT_GEN_SET);
+	if (!power_cfg->is_power_auto) {
+		u16 dbm_min = power_cfg->is_power_fixed ?
+			      dbm : priv->min_tx_power_level;
+
+		txp_cfg->mode = cpu_to_le32(1);
+		pg_tlv = (struct nxpwifi_types_power_group *)
+			 (buf + sizeof(struct host_cmd_ds_txpwr_cfg));
+		pg_tlv->type = cpu_to_le16(TLV_TYPE_POWER_GROUP);
+		pg_tlv->length =
+			cpu_to_le16(4 * sizeof(struct nxpwifi_power_group));
+		pg = (struct nxpwifi_power_group *)
+		     (buf + sizeof(struct host_cmd_ds_txpwr_cfg)
+		      + sizeof(struct nxpwifi_types_power_group));
+		/* Power group for modulation class HR/DSSS */
+		pg->first_rate_code = 0x00;
+		pg->last_rate_code = 0x03;
+		pg->modulation_class = MOD_CLASS_HR_DSSS;
+		pg->power_step = 0;
+		pg->power_min = (s8)dbm_min;
+		pg->power_max = (s8)dbm;
+		pg++;
+		/* Power group for modulation class OFDM */
+		pg->first_rate_code = 0x00;
+		pg->last_rate_code = 0x07;
+		pg->modulation_class = MOD_CLASS_OFDM;
+		pg->power_step = 0;
+		pg->power_min = (s8)dbm_min;
+		pg->power_max = (s8)dbm;
+		pg++;
+		/* Power group for modulation class HTBW20 */
+		pg->first_rate_code = 0x00;
+		pg->last_rate_code = 0x20;
+		pg->modulation_class = MOD_CLASS_HT;
+		pg->power_step = 0;
+		pg->power_min = (s8)dbm_min;
+		pg->power_max = (s8)dbm;
+		pg->ht_bandwidth = HT_BW_20;
+		pg++;
+		/* Power group for modulation class HTBW40 */
+		pg->first_rate_code = 0x00;
+		pg->last_rate_code = 0x20;
+		pg->modulation_class = MOD_CLASS_HT;
+		pg->power_step = 0;
+		pg->power_min = (s8)dbm_min;
+		pg->power_max = (s8)dbm;
+		pg->ht_bandwidth = HT_BW_40;
+	}
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_TXPWR_CFG,
+			       HOST_ACT_GEN_SET, 0, buf, true);
+
+	kfree(buf);
+	return ret;
+}
+
+/* IOCTL request handler to get power save mode */
+int nxpwifi_drv_set_power(struct nxpwifi_private *priv, u32 *ps_mode)
+{
+	int ret;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u16 sub_cmd;
+
+	if (*ps_mode)
+		adapter->ps_mode = NXPWIFI_802_11_POWER_MODE_PSP;
+	else
+		adapter->ps_mode = NXPWIFI_802_11_POWER_MODE_CAM;
+	sub_cmd = (*ps_mode) ? EN_AUTO_PS : DIS_AUTO_PS;
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11_PS_MODE_ENH,
+			       sub_cmd, BITMAP_STA_PS, NULL, true);
+	if (!ret && sub_cmd == DIS_AUTO_PS)
+		ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11_PS_MODE_ENH,
+				       GET_PS, 0, NULL, false);
+
+	return ret;
+}
+
+/* IOCTL request handler to set/reset WPA element */
+static int nxpwifi_set_wpa_ie(struct nxpwifi_private *priv,
+			      u8 *ie_data_ptr, u16 ie_len)
+{
+	if (ie_len) {
+		if (ie_len > sizeof(priv->wpa_ie)) {
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "failed to copy WPA element, too big\n");
+			return -EINVAL;
+		}
+		memcpy(priv->wpa_ie, ie_data_ptr, ie_len);
+		priv->wpa_ie_len = ie_len;
+		nxpwifi_dbg(priv->adapter, CMD,
+			    "cmd: Set WPA element len=%d element=%#x\n",
+			    priv->wpa_ie_len, priv->wpa_ie[0]);
+
+		if (priv->wpa_ie[0] == WLAN_EID_VENDOR_SPECIFIC) {
+			priv->sec_info.wpa_enabled = true;
+		} else if (priv->wpa_ie[0] == WLAN_EID_RSN) {
+			priv->sec_info.wpa2_enabled = true;
+		} else {
+			priv->sec_info.wpa_enabled = false;
+			priv->sec_info.wpa2_enabled = false;
+		}
+	} else {
+		memset(priv->wpa_ie, 0, sizeof(priv->wpa_ie));
+		priv->wpa_ie_len = 0;
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "info: reset WPA element len=%d element=%#x\n",
+			    priv->wpa_ie_len, priv->wpa_ie[0]);
+		priv->sec_info.wpa_enabled = false;
+		priv->sec_info.wpa2_enabled = false;
+	}
+
+	return 0;
+}
+
+/* IOCTL request handler to set/reset WPS element */
+static int nxpwifi_set_wps_ie(struct nxpwifi_private *priv,
+			      u8 *ie_data_ptr, u16 ie_len)
+{
+	if (ie_len) {
+		if (ie_len > NXPWIFI_MAX_VSIE_LEN) {
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "info: failed to copy WPS element, too big\n");
+			return -EINVAL;
+		}
+
+		priv->wps_ie = kzalloc(NXPWIFI_MAX_VSIE_LEN, GFP_KERNEL);
+		if (!priv->wps_ie)
+			return -ENOMEM;
+
+		memcpy(priv->wps_ie, ie_data_ptr, ie_len);
+		priv->wps_ie_len = ie_len;
+		nxpwifi_dbg(priv->adapter, CMD,
+			    "cmd: Set WPS element len=%d element=%#x\n",
+			    priv->wps_ie_len, priv->wps_ie[0]);
+	} else {
+		kfree(priv->wps_ie);
+		priv->wps_ie_len = ie_len;
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "info: Reset WPS element len=%d\n", priv->wps_ie_len);
+	}
+	return 0;
+}
+
+/* IOCTL request handler to set WEP network key */
+static int
+nxpwifi_sec_ioctl_set_wep_key(struct nxpwifi_private *priv,
+			      struct nxpwifi_ds_encrypt_key *encrypt_key)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int ret;
+	struct nxpwifi_wep_key *wep_key;
+	int index;
+
+	if (priv->wep_key_curr_index >= NUM_WEP_KEYS)
+		priv->wep_key_curr_index = 0;
+	wep_key = &priv->wep_key[priv->wep_key_curr_index];
+	index = encrypt_key->key_index;
+	if (encrypt_key->key_disable) {
+		priv->sec_info.wep_enabled = 0;
+	} else if (!encrypt_key->key_len) {
+		/* Copy the required key as the current key */
+		wep_key = &priv->wep_key[index];
+		if (!wep_key->key_length) {
+			nxpwifi_dbg(adapter, ERROR,
+				    "key not set, so cannot enable it\n");
+			return -EINVAL;
+		}
+
+		memcpy(encrypt_key->key_material,
+		       wep_key->key_material, wep_key->key_length);
+		encrypt_key->key_len = wep_key->key_length;
+
+		priv->wep_key_curr_index = (u16)index;
+		priv->sec_info.wep_enabled = 1;
+	} else {
+		wep_key = &priv->wep_key[index];
+		memset(wep_key, 0, sizeof(struct nxpwifi_wep_key));
+		/* Copy the key in the driver */
+		memcpy(wep_key->key_material,
+		       encrypt_key->key_material,
+		       encrypt_key->key_len);
+		wep_key->key_index = index;
+		wep_key->key_length = encrypt_key->key_len;
+		priv->sec_info.wep_enabled = 1;
+	}
+	if (wep_key->key_length) {
+		void *enc_key;
+
+		if (encrypt_key->key_disable) {
+			memset(&priv->wep_key[index], 0,
+			       sizeof(struct nxpwifi_wep_key));
+			goto done;
+		}
+
+		enc_key = encrypt_key;
+
+		/* Send request to firmware */
+		ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11_KEY_MATERIAL,
+				       HOST_ACT_GEN_SET, 0, enc_key, false);
+		if (ret)
+			return ret;
+	}
+
+done:
+	if (priv->sec_info.wep_enabled)
+		priv->curr_pkt_filter |= HOST_ACT_MAC_WEP_ENABLE;
+	else
+		priv->curr_pkt_filter &= ~HOST_ACT_MAC_WEP_ENABLE;
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_MAC_CONTROL,
+			       HOST_ACT_GEN_SET, 0,
+			       &priv->curr_pkt_filter, true);
+
+	return ret;
+}
+
+/* IOCTL request handler to set WPA key */
+static int
+nxpwifi_sec_ioctl_set_wpa_key(struct nxpwifi_private *priv,
+			      struct nxpwifi_ds_encrypt_key *encrypt_key)
+{
+	int ret;
+	u8 remove_key = false;
+
+	/* Current driver only supports key length of up to 32 bytes */
+	if (encrypt_key->key_len > WLAN_MAX_KEY_LEN) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "key length too long\n");
+		return -EINVAL;
+	}
+
+	if (!encrypt_key->key_index)
+		encrypt_key->key_index = NXPWIFI_KEY_INDEX_UNICAST;
+
+	if (remove_key)
+		ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11_KEY_MATERIAL,
+				       HOST_ACT_GEN_SET,
+				       !KEY_INFO_ENABLED, encrypt_key, true);
+	else
+		ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11_KEY_MATERIAL,
+				       HOST_ACT_GEN_SET,
+				       KEY_INFO_ENABLED, encrypt_key, true);
+
+	return ret;
+}
+
+/* IOCTL request handler to set/get network keys */
+static int
+nxpwifi_sec_ioctl_encrypt_key(struct nxpwifi_private *priv,
+			      struct nxpwifi_ds_encrypt_key *encrypt_key)
+{
+	int status;
+
+	if (encrypt_key->key_len > WLAN_KEY_LEN_WEP104)
+		status = nxpwifi_sec_ioctl_set_wpa_key(priv, encrypt_key);
+	else
+		status = nxpwifi_sec_ioctl_set_wep_key(priv, encrypt_key);
+
+	return status;
+}
+
+/* Return driver version string */
+int
+nxpwifi_drv_get_driver_version(struct nxpwifi_adapter *adapter, char *version,
+			       int max_len)
+{
+	union {
+		__le32 l;
+		u8 c[4];
+	} ver;
+	char fw_ver[32];
+
+	ver.l = cpu_to_le32(adapter->fw_release_number);
+	sprintf(fw_ver, "%u.%u.%u.p%u.%u", ver.c[2], ver.c[1],
+		ver.c[0], ver.c[3], adapter->fw_hotfix_ver);
+
+	snprintf(version, max_len, driver_version, fw_ver);
+
+	nxpwifi_dbg(adapter, MSG, "info: NXPWIFI VERSION: %s\n", version);
+
+	return 0;
+}
+
+/* Sends IOCTL request to set encoding parameters */
+int nxpwifi_set_encode(struct nxpwifi_private *priv, struct key_params *kp,
+		       const u8 *key, int key_len, u8 key_index,
+		       const u8 *mac_addr, int disable)
+{
+	struct nxpwifi_ds_encrypt_key encrypt_key;
+
+	memset(&encrypt_key, 0, sizeof(encrypt_key));
+	encrypt_key.key_len = key_len;
+	encrypt_key.key_index = key_index;
+
+	if (kp) {
+		encrypt_key.key_cipher = kp->cipher;
+		if (kp->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
+		    kp->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256)
+			encrypt_key.is_igtk_key = true;
+	}
+
+	if (!disable) {
+		if (key_len)
+			memcpy(encrypt_key.key_material, key, key_len);
+		else
+			encrypt_key.is_current_wep_key = true;
+
+		if (mac_addr)
+			memcpy(encrypt_key.mac_addr, mac_addr, ETH_ALEN);
+		if (kp && kp->seq && kp->seq_len) {
+			memcpy(encrypt_key.pn, kp->seq, kp->seq_len);
+			encrypt_key.pn_len = kp->seq_len;
+			encrypt_key.is_rx_seq_valid = true;
+		}
+	} else {
+		encrypt_key.key_disable = true;
+		if (mac_addr)
+			memcpy(encrypt_key.mac_addr, mac_addr, ETH_ALEN);
+	}
+
+	return nxpwifi_sec_ioctl_encrypt_key(priv, &encrypt_key);
+}
+
+/* Sends IOCTL request to get extended version */
+int
+nxpwifi_get_ver_ext(struct nxpwifi_private *priv, u32 version_str_sel)
+{
+	struct nxpwifi_ver_ext ver_ext;
+
+	memset(&ver_ext, 0, sizeof(ver_ext));
+	ver_ext.version_str_sel = version_str_sel;
+
+	return nxpwifi_send_cmd(priv, HOST_CMD_VERSION_EXT,
+				HOST_ACT_GEN_GET, 0, &ver_ext, true);
+}
+
+int
+nxpwifi_remain_on_chan_cfg(struct nxpwifi_private *priv, u16 action,
+			   struct ieee80211_channel *chan,
+			   unsigned int duration)
+{
+	struct host_cmd_ds_remain_on_chan roc_cfg;
+	u8 sc;
+	int ret;
+
+	memset(&roc_cfg, 0, sizeof(roc_cfg));
+	roc_cfg.action = cpu_to_le16(action);
+	if (action == HOST_ACT_GEN_SET) {
+		roc_cfg.band_cfg = chan->band;
+		sc = nxpwifi_chan_type_to_sec_chan_offset(NL80211_CHAN_NO_HT);
+		roc_cfg.band_cfg |= (sc << 2);
+
+		roc_cfg.channel =
+			ieee80211_frequency_to_channel(chan->center_freq);
+		roc_cfg.duration = cpu_to_le32(duration);
+	}
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_REMAIN_ON_CHAN,
+			       action, 0, &roc_cfg, true);
+	if (ret) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "failed to remain on channel\n");
+		return ret;
+	}
+
+	return roc_cfg.status;
+}
+
+/* Sends IOCTL request to get statistics information */
+int
+nxpwifi_get_stats_info(struct nxpwifi_private *priv,
+		       struct nxpwifi_ds_get_stats *log)
+{
+	return nxpwifi_send_cmd(priv, HOST_CMD_802_11_GET_LOG,
+				HOST_ACT_GEN_GET, 0, log, true);
+}
+
+/* IOCTL request handler to read/write register */
+static int nxpwifi_reg_mem_ioctl_reg_rw(struct nxpwifi_private *priv,
+					struct nxpwifi_ds_reg_rw *reg_rw,
+					u16 action)
+{
+	u16 cmd_no;
+
+	switch (reg_rw->type) {
+	case NXPWIFI_REG_MAC:
+		cmd_no = HOST_CMD_MAC_REG_ACCESS;
+		break;
+	case NXPWIFI_REG_BBP:
+		cmd_no = HOST_CMD_BBP_REG_ACCESS;
+		break;
+	case NXPWIFI_REG_RF:
+		cmd_no = HOST_CMD_RF_REG_ACCESS;
+		break;
+	case NXPWIFI_REG_PMIC:
+		cmd_no = HOST_CMD_PMIC_REG_ACCESS;
+		break;
+	case NXPWIFI_REG_CAU:
+		cmd_no = HOST_CMD_CAU_REG_ACCESS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return nxpwifi_send_cmd(priv, cmd_no, action, 0, reg_rw, true);
+}
+
+/* Sends IOCTL request to write to a register */
+int
+nxpwifi_reg_write(struct nxpwifi_private *priv, u32 reg_type,
+		  u32 reg_offset, u32 reg_value)
+{
+	struct nxpwifi_ds_reg_rw reg_rw;
+
+	reg_rw.type = reg_type;
+	reg_rw.offset = reg_offset;
+	reg_rw.value = reg_value;
+
+	return nxpwifi_reg_mem_ioctl_reg_rw(priv, &reg_rw, HOST_ACT_GEN_SET);
+}
+
+/* Sends IOCTL request to read from a register */
+int
+nxpwifi_reg_read(struct nxpwifi_private *priv, u32 reg_type,
+		 u32 reg_offset, u32 *value)
+{
+	int ret;
+	struct nxpwifi_ds_reg_rw reg_rw;
+
+	reg_rw.type = reg_type;
+	reg_rw.offset = reg_offset;
+	ret = nxpwifi_reg_mem_ioctl_reg_rw(priv, &reg_rw, HOST_ACT_GEN_GET);
+
+	if (!ret)
+		*value = reg_rw.value;
+
+	return ret;
+}
+
+/* Sends IOCTL request to read from EEPROM */
+int
+nxpwifi_eeprom_read(struct nxpwifi_private *priv, u16 offset, u16 bytes,
+		    u8 *value)
+{
+	int ret;
+	struct nxpwifi_ds_read_eeprom rd_eeprom;
+
+	rd_eeprom.offset =  offset;
+	rd_eeprom.byte_count = bytes;
+
+	/* Send request to firmware */
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11_EEPROM_ACCESS,
+			       HOST_ACT_GEN_GET, 0, &rd_eeprom, true);
+
+	if (!ret)
+		memcpy(value, rd_eeprom.value,
+		       min((u16)MAX_EEPROM_DATA, rd_eeprom.byte_count));
+	return ret;
+}
+
+/* Set generic IE(s); handle WPA/WPS specially */
+static int
+nxpwifi_set_gen_ie_helper(struct nxpwifi_private *priv, u8 *ie_data_ptr,
+			  u16 ie_len)
+{
+	struct ieee80211_vendor_ie *pvendor_ie;
+	static const u8 wpa_oui[] = { 0x00, 0x50, 0xf2, 0x01 };
+	static const u8 wps_oui[] = { 0x00, 0x50, 0xf2, 0x04 };
+	u16 unparsed_len = ie_len, cur_ie_len;
+
+	/* If the passed length is zero, reset the buffer */
+	if (!ie_len) {
+		priv->gen_ie_buf_len = 0;
+		priv->wps.session_enable = false;
+		return 0;
+	} else if (!ie_data_ptr ||
+		   ie_len <= sizeof(struct element)) {
+		return -EINVAL;
+	}
+	pvendor_ie = (struct ieee80211_vendor_ie *)ie_data_ptr;
+
+	while (pvendor_ie) {
+		cur_ie_len = pvendor_ie->len + sizeof(struct element);
+
+		if (pvendor_ie->element_id == WLAN_EID_RSN) {
+			/* element is a WPA/WPA2 element so call set_wpa function */
+			nxpwifi_set_wpa_ie(priv, (u8 *)pvendor_ie, cur_ie_len);
+			priv->wps.session_enable = false;
+			goto next_ie;
+		}
+
+		if (pvendor_ie->element_id == WLAN_EID_VENDOR_SPECIFIC) {
+			/* Test to see if it is a WPA element, if not, then it is a gen element */
+			if (!memcmp(&pvendor_ie->oui, wpa_oui,
+				    sizeof(wpa_oui))) {
+				/* element is a WPA/WPA2 element so call set_wpa function */
+				nxpwifi_set_wpa_ie(priv, (u8 *)pvendor_ie,
+						   cur_ie_len);
+				priv->wps.session_enable = false;
+				goto next_ie;
+			}
+
+			if (!memcmp(&pvendor_ie->oui, wps_oui,
+				    sizeof(wps_oui))) {
+				/*
+				 * Test to see if it is a WPS element, if so, enable wps session
+				 * flag
+				 */
+				priv->wps.session_enable = true;
+				nxpwifi_dbg(priv->adapter, MSG,
+					    "WPS Session Enabled.\n");
+				nxpwifi_set_wps_ie(priv, (u8 *)pvendor_ie,
+						   cur_ie_len);
+				goto next_ie;
+			}
+		}
+
+		/*
+		 * Verify that the passed length is not larger than the available space
+		 * remaining in the buffer
+		 */
+		if (cur_ie_len <
+		    (sizeof(priv->gen_ie_buf) - priv->gen_ie_buf_len)) {
+			/* Append the passed data to the end of the genIeBuffer */
+			memcpy(priv->gen_ie_buf + priv->gen_ie_buf_len,
+			       (u8 *)pvendor_ie, cur_ie_len);
+			/* Increment the stored buffer length by the size passed */
+			priv->gen_ie_buf_len += cur_ie_len;
+		}
+
+next_ie:
+		unparsed_len -= cur_ie_len;
+
+		if (unparsed_len <= sizeof(struct element))
+			pvendor_ie = NULL;
+		else
+			pvendor_ie = (struct ieee80211_vendor_ie *)
+				(((u8 *)pvendor_ie) + cur_ie_len);
+	}
+
+	return 0;
+}
+
+/* IOCTL request handler to set/get generic element */
+static int nxpwifi_misc_ioctl_gen_ie(struct nxpwifi_private *priv,
+				     struct nxpwifi_ds_misc_gen_ie *gen_ie,
+				     u16 action)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	switch (gen_ie->type) {
+	case NXPWIFI_IE_TYPE_GEN_IE:
+		if (action == HOST_ACT_GEN_GET) {
+			gen_ie->len = priv->wpa_ie_len;
+			memcpy(gen_ie->ie_data, priv->wpa_ie, gen_ie->len);
+		} else {
+			nxpwifi_set_gen_ie_helper(priv, gen_ie->ie_data,
+						  (u16)gen_ie->len);
+		}
+		break;
+	case NXPWIFI_IE_TYPE_ARP_FILTER:
+		memset(adapter->arp_filter, 0, sizeof(adapter->arp_filter));
+		if (gen_ie->len > ARP_FILTER_MAX_BUF_SIZE) {
+			adapter->arp_filter_size = 0;
+			nxpwifi_dbg(adapter, ERROR,
+				    "invalid ARP filter size\n");
+			return -EINVAL;
+		}
+		memcpy(adapter->arp_filter, gen_ie->ie_data, gen_ie->len);
+		adapter->arp_filter_size = gen_ie->len;
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR, "invalid element type\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/* Sends IOCTL request to set a generic element */
+int
+nxpwifi_set_gen_ie(struct nxpwifi_private *priv, const u8 *ie, int ie_len)
+{
+	struct nxpwifi_ds_misc_gen_ie gen_ie;
+
+	if (ie_len > IEEE_MAX_IE_SIZE)
+		return -EFAULT;
+
+	gen_ie.type = NXPWIFI_IE_TYPE_GEN_IE;
+	gen_ie.len = ie_len;
+	memcpy(gen_ie.ie_data, ie, ie_len);
+
+	return nxpwifi_misc_ioctl_gen_ie(priv, &gen_ie, HOST_ACT_GEN_SET);
+}
+
+/* Get Host Sleep wakeup reason */
+int nxpwifi_get_wakeup_reason(struct nxpwifi_private *priv, u16 action,
+			      int cmd_type,
+			      struct nxpwifi_ds_wakeup_reason *wakeup_reason)
+{
+	return nxpwifi_send_cmd(priv, HOST_CMD_HS_WAKEUP_REASON,
+				HOST_ACT_GEN_GET, 0, wakeup_reason,
+				cmd_type == NXPWIFI_SYNC_CMD);
+}
+
+int nxpwifi_get_chan_info(struct nxpwifi_private *priv,
+			  struct nxpwifi_channel_band *channel_band)
+{
+	return nxpwifi_send_cmd(priv, HOST_CMD_STA_CONFIGURE,
+				HOST_ACT_GEN_GET, 0, channel_band,
+				NXPWIFI_SYNC_CMD);
+}
-- 
2.34.1


