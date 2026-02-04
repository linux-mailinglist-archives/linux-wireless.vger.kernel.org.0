Return-Path: <linux-wireless+bounces-31563-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPckEOqLg2lWpAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31563-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 19:11:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A37EB760
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 19:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39AF7303989F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 18:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF24042B72D;
	Wed,  4 Feb 2026 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jUJtcOMC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D590423A63;
	Wed,  4 Feb 2026 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770228350; cv=fail; b=MczYhvg+d/OJ1FnE53xxtB2Pz6oEnn3+ryNrkMcGNOecOPr/uJlzBg0lcEHEQBwYPEss5qCg0GTj57BjUlNxT1jU9sIjhlclngTj2ajtvv7celq/wz7gS5TWcwxQQBlMFwRGL3UzoBPHWoUfsobsRSnErCOKlYBHldzZBHIuAgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770228350; c=relaxed/simple;
	bh=YtIjCP3eDtdXXAnqCcBOmeh3wunp6XFwWSZGQMmWwBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TH4KnvyoHk2I9y0o38+pn7+4JHYbjg0T3rcJwJYAC9Ab0flHMhdU8pmaG0PD0jdaJl9+NSTojn3oRAL9FuhUxDacJ0705bZwrkM+xAkJtH8MUbT4/u9MOm5OzWGLv34M/Ftcyc+O3Jm7gtpUBLxJlJEoIsahCaa/LQuGLAr0x2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jUJtcOMC; arc=fail smtp.client-ip=52.101.69.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3MWeCKGOkb0oboOTUXvXqx1MDSlYm9JxV56T+WWFvKbD2tCW8onkApQNVxeWucxc6+dNE9wt/Ft9RZq/6zeW8aTt6NaZOaibmv8QW3B65Imu/P8MPro090f8vLV85F/Ze8BGo9dRb6/SER09r3sn/fCHcvRpESD8kD3n/SUb2glxpxvHdqWhff+Ml7RW8WXAbsqD3G7wk+Ma6nfHQQIa55JcnilctIUHiGoDBgUodnmBIOUYtwS/8qkyd2/TGQaFtYz832Qw3eNqMFt/hpmiXCCqGTZyX92rk8ioM6H99Z1A5D7PubniNd5Sfh9jZbh2KBr5dKPeQ7d7uSN0To+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fFX0Kng3hL37t0WGx1Zii4MTD8f5KJvBDxvvKSSQY8=;
 b=fO/GwIO5SA76idHS3Ag53PSM81YJwhR+kBDlNuKsmwlxfiv0FbBYaHkiWFIdaiZ+qlKRnqoamU9CfLvvyLINLYXHk30BGxz5H9VMTonJ/Ul2ecSdDMwCfv2GHDlSvtQbSJaVOkXN7l0GeUsoakEtZ0Ol96qT7XxoERnaTfz5ZDoCg4mfyp6jcYCd6rjwpUzHe4UfICOpCpyX1BfM+7y8p99ErSLATKQzho5/yI7czgrDc8TyQKIr1QZ+P7MU0QdWCVXbVIF02NTuinH/rv/JyjusfvUP1YQiyDgO0J7RjhFEAHFFht5kg83QCAorcP35c6rG+aViOVTDoIkImgxfxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fFX0Kng3hL37t0WGx1Zii4MTD8f5KJvBDxvvKSSQY8=;
 b=jUJtcOMCzLNrmkph3EXaJkqfacu2g+J88To/7d6gAArlHK45sS0rROw8tw+UE9/tQ1nfhBygCYVbWp/eKmHgqoDu4qUR0UuSZgJfr5uW6l+UI+WqQom4Jx6wEo2Dhc2/ln/g+T6GgI1SM2i8xx9YT+x2+cmpeiTQo3SvVgCZ9GYFflkIBaDjyS9BDJwvWDtL1hdslondP3gilixDYCgmqGXItf0FG6fd/n+4a4ASIMoIud249eS/ITS7oeuhAT9utlWEvStGhccgaUW4wG/PV+3OS9ALADxoPd35my/O/gJGv+FYgeXcUvddtuZXajeQrJw49wnuorcWpBYbFbIDbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by GV2PR04MB11980.eurprd04.prod.outlook.com (2603:10a6:150:2f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 18:05:47 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 18:05:46 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v9 14/21] wifi: nxpwifi: add debugfs support for diagnostics and testing
Date: Thu,  5 Feb 2026 02:03:51 +0800
Message-Id: <20260204180358.632281-15-jeff.chen_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 527d149e-e844-4a26-2283-08de64180576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O5Fn9pq/cGxnBu5tc25udvl43lGduTTtRHDvjrKtM6IQhOUr74XYkhfW2vPj?=
 =?us-ascii?Q?iAxD92syNZ9+z4Hbph1mc00N0KWEkSWiS5ynqeD9Ffoi7wsulAztNPV738yb?=
 =?us-ascii?Q?5dI52L2bhfY5BHxKBMSq9yigKev5ca0FL6agFpcFbBtH30xRzu6oKORyyNNx?=
 =?us-ascii?Q?T+h85lXEaoHKNpuSaL/wWFsm4DI5B4QDy3oobyR/FLZ83DPN0TafUvq9bGhH?=
 =?us-ascii?Q?AE1mBR7tIQIGoT2xiA2McNeNXXTy8BP2TtfurSHcNYJafWpNUfZTt32w1hXI?=
 =?us-ascii?Q?HN8EPFndrQcUmubYWuy6H6SsAnPAi//JfgNAJW5x8wbIL3mRBPG9ZUYIzC35?=
 =?us-ascii?Q?hbdFdtoz27FL6mJ8Q6qskWctpUlqKNdpHkLLFys3jeQNC1c2rS82F2DKQGvd?=
 =?us-ascii?Q?xjIsC+efbzuFGcImhM0+UIHPFJm9K+k2D2sen5ktHZwFtvd/xtZ36bsuU3WE?=
 =?us-ascii?Q?mXBumwIO4+88KUmavXWI1Bh5bP/ytRDWD3ltubzhmyyzqr1AkQM4KAkOW/58?=
 =?us-ascii?Q?z5a4osJoBDfAqDc1A2YQUGPUIEC3/iTEegvaJ8IryGHH36HYCSM95DeXXry9?=
 =?us-ascii?Q?nk8SfRSC2iznopF07Je4kluljXcGdswwMU2/0JPfauh4YLdBVcVbd3s1fw9A?=
 =?us-ascii?Q?nKUK9Qii+qONTvYS892NAUQMAUqZ3MYDS52hQ0bFCO2vQilY3jibueIr4hh8?=
 =?us-ascii?Q?lf3aoe5RIv8KgksHXvyBtunwTLEHdV04ww87da87qYfm06IAN0X5RI/55CyK?=
 =?us-ascii?Q?aJyVpNKPxPlXqueRcwaDMWpcsF8hkfD1rNQ0r3X24gtvK0eRnCNsj4P+Eqbc?=
 =?us-ascii?Q?qUgA2FldJsixUCptR4npxujTpcy2/iyod7qlNWdOsFnZPs//CVtwsSdz9guh?=
 =?us-ascii?Q?3x3ho6yLfCvhuSvYC5ORa17m9daJksZuUGoNeDKEdJe22SMQfmVm1+bUZhUk?=
 =?us-ascii?Q?tIjKdtGvusDyPGRLU64Lpwj/CZHg3RKHt5eSFqukFk6tOhIzh2WY2bmmYDxi?=
 =?us-ascii?Q?z6NxL9fH1HQRajpJNreYklDzIznBg/bkWmBcQc19qJXNFoAI+hkDJKNenR8i?=
 =?us-ascii?Q?WFdKI0cndX6jdnJXRA4qf26V+Z3SoBm93Tp0ER4qcVyvdgNKV19IIa4nm0ey?=
 =?us-ascii?Q?MHTJDuJbQAPGfhVHGGr1dtoTCkjL99H7bvgua3RwYDEgzpn6wtyM1P2I+I9y?=
 =?us-ascii?Q?85m5httEjIdUbFMPdWVwnboiws5yP0J87nbj5nz87xf0lR9V0ek4JZNBkEh4?=
 =?us-ascii?Q?qFZWvsFqI4giSRjPwNOQQDoU2Rq8JUqdNi1qDIQRG8Mh9VGU2DIhPRUu6zQC?=
 =?us-ascii?Q?1wiMH1eoUljQca+9vNr+J6Fz2zrHKRw/jjlLb6RB02TETekMEmF145EQHg/M?=
 =?us-ascii?Q?+DnFjwnKsVXKCXttMZOY8JKAbvX3l7rHn2DXaND3z6VYuwAXCbFpZ1/Yga1Q?=
 =?us-ascii?Q?3wx8r30daM4RYvdvXpJlQIcZ+sMVFT7qNCG1IyNjsMPUfV+HtyXqwntLv4Pn?=
 =?us-ascii?Q?Ltdj/zoiWmE0uNTo9lQ9Fmz2ACIrRxaE+4kJ11oC58+vlFJ15b/U4RV+8zPy?=
 =?us-ascii?Q?dBALNmUqJQMf4bEUMsgx7F/0Yx3s3eIn0dkB/BjDIg9ZSFBmdHZRLoW+A+p5?=
 =?us-ascii?Q?ZTCX9QwDqwiTNOBXUCtPjFA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vZV+BZshRPSklksdwKCWs/nra20aMM7T80M2kJKmZMWfSCf4kJ4hSdsxlvRr?=
 =?us-ascii?Q?KqQ3Q+ce6Y64nLiwbkUnauOljgfH+pzxmGlnh3O2b3Bup2JXliRVPx6Qley4?=
 =?us-ascii?Q?keGKrpGSROQFLunoko0bxejTHJ0OyV23cLSXObIVvAstLukKAuhBUHgFJWB6?=
 =?us-ascii?Q?jvKmIE0hXZQvuRCG4McGehe/uukTut0aPDg4Ygq8m2ROUznkqgIyme46WCaP?=
 =?us-ascii?Q?JspVXIfhgqHbyaF+9ChK++EsGJYfJkcDxzdNQAwYPdebX192KghVSjUjMM0i?=
 =?us-ascii?Q?C5Z+SGcHC2fGgxeq9ktPXTQFdl03BZOYs2ym7tVk+ZB1ysiBKgffghfHMfrb?=
 =?us-ascii?Q?5jMvT3ukZnZ3IvwrMgSi12p9ieJBSTrha2ekpBBG6dHHbIqu2q1FMkAH5cAc?=
 =?us-ascii?Q?7vSNAo3eux9J3tMmINMlIA+VOhV8wzM5K7nOkbl8tuy8ANq0/C0B/gMLDd4o?=
 =?us-ascii?Q?7upK/ax4lGv2F7TOdP032Qf7f+1tOLjdHe2RdrCwA+hcu1eRfJXUW+jLLsZs?=
 =?us-ascii?Q?Zv83VofwJOq9X9+guf8nLt7mygVngQbHzmg/fGWTacYSPy9kvUeUz4Pgcb4w?=
 =?us-ascii?Q?uwDhXkijR9SPdxHevHvoUqFd6MdNvioRziPcIEnyCxJGadJg2lNlRbQVnKZR?=
 =?us-ascii?Q?OhFAvo0rmPuAWrG751wxFG3WUFRO8lNT+N+ocQOZq400r7VHsk9NaH1d1aiO?=
 =?us-ascii?Q?lLf1wB/stdswQnOv6jq7KRGnMl35B0QH4evs2I2p0mPS1ghUHiQXDrvHm5pr?=
 =?us-ascii?Q?wV1ccyRsmXrZS+L8SqIAwZrKqUPOSTeIegUGxg18dh+f8X4bZw+O0FqEDxse?=
 =?us-ascii?Q?Io01wJV74VoiFKHP5oLGvSGlcPHemUPWikjLhYbqi7mSSnRtOKLrYX1aAsCb?=
 =?us-ascii?Q?G5Viz+7qucHYWtpmZkuT/A8o0mGbraB+vuY0UWIpbTeIP2PMBZ/QajWB9GKd?=
 =?us-ascii?Q?5NF2Rkv1aTQbKOGbKMu6DSollOOIuXACcLj4Glx9EIijP429891c3qJK8oir?=
 =?us-ascii?Q?adzoyq6P9IFmUu4Exs+wGqITeFp8xwTjV1hdqIy48r+XWNltFAt12O4g2/RX?=
 =?us-ascii?Q?7yGwDliQdslhLJ1eJ785lnFiiRwJbiKQ83GFbQbe4hYfmyMUtvthDJ3vTRqz?=
 =?us-ascii?Q?+IyyWnWnEJPwygUJR25Veft1aKAiZ6HMmII+CbeBpaumcK5RkpfXZDBqm1gJ?=
 =?us-ascii?Q?WrcJPKqdPEeFbsuF1dA2s0YVuPM5uiurxqXA5gUeyxk+ab+nOI27gub0aIlb?=
 =?us-ascii?Q?kIbakA50hREYmrqdrQhMKbYIlOXj/DQ+2G/Wt3iQFnBEJICQoeU+35qIGSVG?=
 =?us-ascii?Q?4boZX6aDf0MxADSGwz7NWhSuhEdM9Y0PptNWsRzZmNoV7Mv/wiLPQVezj0TY?=
 =?us-ascii?Q?HZfohn4+I8Ad7V/sFR0s3M/Eqos0tx0De3sf8wY8CWADS4/tnWP7HgxuWCbY?=
 =?us-ascii?Q?SY0nXS+/Q/rUBpjGgLgz5k1gb5UM4Y50Gc1CohR/6rzDfsya74sWO4JPbWIT?=
 =?us-ascii?Q?CChQKgks44S2HOcTDTAP8tS5POcfFMYo98ju7y9INW2xX/OR6DCfBS8dN6C8?=
 =?us-ascii?Q?c5HtYwOsVi2PtaBWm2V0crMYhQ0D+xSMf5fOGPmiMIMnbMBbAuXjGlHU5SDE?=
 =?us-ascii?Q?IlrROLluGSroBGiuloXhDLWxvuN7Ljkl8zuWSXMqvV898iVgs7AWIPwBZed0?=
 =?us-ascii?Q?asbZl/vkZG5R1WFVHSxe6SOiZbV+C70KFJYajK6Ukx2fTJTDmPu4YudD5Qat?=
 =?us-ascii?Q?8mr4MYqhNw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 527d149e-e844-4a26-2283-08de64180576
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 18:05:46.8987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kY4Erme8/0MwmpUlPaJVXzAOCh5X9TiZ5INDjiXAfid6w3cVdDaEA/hPnsgulWT2gAkAHLwRyxm3mEOicf64sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11980
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31563-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 21A37EB760
X-Rspamd-Action: no action

This patch adds a comprehensive debugfs interface for the nxpwifi driver,
enabling easier diagnostics, testing, and runtime inspection.

These tools are useful for both development and field debugging, especially
for validating DFS behavior, power management, and firmware interaction.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/debugfs.c | 1094 ++++++++++++++++++++
 1 file changed, 1094 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/debugfs.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/debugfs.c b/drivers/net/wireless/nxp/nxpwifi/debugfs.c
new file mode 100644
index 000000000000..ccaf0eae37e3
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/debugfs.c
@@ -0,0 +1,1094 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * nxpwifi: debugfs
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include <linux/debugfs.h>
+
+#include "main.h"
+#include "cmdevt.h"
+#include "11n.h"
+
+static struct dentry *nxpwifi_dfs_dir;
+
+static char *bss_modes[] = {
+	"UNSPECIFIED",
+	"ADHOC",
+	"STATION",
+	"AP",
+	"AP_VLAN",
+	"WDS",
+	"MONITOR",
+	"MESH_POINT",
+	"P2P_CLIENT",
+	"P2P_GO",
+	"P2P_DEVICE",
+};
+
+/*
+ * debugfs "info" read handler: dump driver name/version, interface, BSS mode,
+ * link state, MAC, counters; STA adds SSID/BSSID/channel/country/region and
+ * multicast list.
+ */
+static ssize_t
+nxpwifi_info_read(struct file *file, char __user *ubuf,
+		  size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	struct net_device *netdev = priv->netdev;
+	struct netdev_hw_addr *ha;
+	struct netdev_queue *txq;
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+	char *p = (char *)page, fmt[64];
+	struct nxpwifi_bss_info info;
+	ssize_t ret;
+	int i = 0;
+
+	if (!p)
+		return -ENOMEM;
+
+	memset(&info, 0, sizeof(info));
+	ret = nxpwifi_get_bss_info(priv, &info);
+	if (ret)
+		goto free_and_exit;
+
+	nxpwifi_drv_get_driver_version(priv->adapter, fmt, sizeof(fmt) - 1);
+
+	nxpwifi_get_ver_ext(priv, 0);
+
+	p += sprintf(p, "driver_name = ");
+	p += sprintf(p, "\"nxpwifi\"\n");
+	p += sprintf(p, "driver_version = %s", fmt);
+	p += sprintf(p, "\nverext = %s", priv->version_str);
+	p += sprintf(p, "\ninterface_name=\"%s\"\n", netdev->name);
+
+	if (info.bss_mode >= ARRAY_SIZE(bss_modes))
+		p += sprintf(p, "bss_mode=\"%d\"\n", info.bss_mode);
+	else
+		p += sprintf(p, "bss_mode=\"%s\"\n", bss_modes[info.bss_mode]);
+
+	p += sprintf(p, "media_state=\"%s\"\n",
+		     (!priv->media_connected ? "Disconnected" : "Connected"));
+	p += sprintf(p, "mac_address=\"%pM\"\n", netdev->dev_addr);
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA) {
+		p += sprintf(p, "multicast_count=\"%d\"\n",
+			     netdev_mc_count(netdev));
+		p += sprintf(p, "essid=\"%.*s\"\n", info.ssid.ssid_len,
+			     info.ssid.ssid);
+		p += sprintf(p, "bssid=\"%pM\"\n", info.bssid);
+		p += sprintf(p, "channel=\"%d\"\n", (int)info.bss_chan);
+		p += sprintf(p, "country_code = \"%s\"\n", info.country_code);
+		p += sprintf(p, "region_code=\"0x%x\"\n",
+			     priv->adapter->region_code);
+
+		netdev_for_each_mc_addr(ha, netdev)
+			p += sprintf(p, "multicast_address[%d]=\"%pM\"\n",
+					i++, ha->addr);
+	}
+
+	p += sprintf(p, "num_tx_bytes = %lu\n", priv->stats.tx_bytes);
+	p += sprintf(p, "num_rx_bytes = %lu\n", priv->stats.rx_bytes);
+	p += sprintf(p, "num_tx_pkts = %lu\n", priv->stats.tx_packets);
+	p += sprintf(p, "num_rx_pkts = %lu\n", priv->stats.rx_packets);
+	p += sprintf(p, "num_tx_pkts_dropped = %lu\n", priv->stats.tx_dropped);
+	p += sprintf(p, "num_rx_pkts_dropped = %lu\n", priv->stats.rx_dropped);
+	p += sprintf(p, "num_tx_pkts_err = %lu\n", priv->stats.tx_errors);
+	p += sprintf(p, "num_rx_pkts_err = %lu\n", priv->stats.rx_errors);
+	p += sprintf(p, "carrier %s\n", ((netif_carrier_ok(priv->netdev))
+					 ? "on" : "off"));
+	p += sprintf(p, "tx queue");
+	for (i = 0; i < netdev->num_tx_queues; i++) {
+		txq = netdev_get_tx_queue(netdev, i);
+		p += sprintf(p, " %d:%s", i, netif_tx_queue_stopped(txq) ?
+			     "stopped" : "started");
+	}
+	p += sprintf(p, "\n");
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, (char *)page,
+				      (unsigned long)p - page);
+
+free_and_exit:
+	free_page(page);
+	return ret;
+}
+
+/*
+ * debugfs "getlog" read handler: dump firmware/802.11 counters (retry, RTS/ACK, dup,
+ * frag, mcast, FCS, beacon stats).
+ */
+static ssize_t
+nxpwifi_getlog_read(struct file *file, char __user *ubuf,
+		    size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+	char *p = (char *)page;
+	ssize_t ret;
+	struct nxpwifi_ds_get_stats stats;
+
+	if (!p)
+		return -ENOMEM;
+
+	memset(&stats, 0, sizeof(stats));
+	ret = nxpwifi_get_stats_info(priv, &stats);
+	if (ret)
+		goto free_and_exit;
+
+	p += sprintf(p, "\n"
+		     "mcasttxframe     %u\n"
+		     "failed           %u\n"
+		     "retry            %u\n"
+		     "multiretry       %u\n"
+		     "framedup         %u\n"
+		     "rtssuccess       %u\n"
+		     "rtsfailure       %u\n"
+		     "ackfailure       %u\n"
+		     "rxfrag           %u\n"
+		     "mcastrxframe     %u\n"
+		     "fcserror         %u\n"
+		     "txframe          %u\n"
+		     "wepicverrcnt-1   %u\n"
+		     "wepicverrcnt-2   %u\n"
+		     "wepicverrcnt-3   %u\n"
+		     "wepicverrcnt-4   %u\n"
+		     "bcn_rcv_cnt   %u\n"
+		     "bcn_miss_cnt   %u\n",
+		     stats.mcast_tx_frame,
+		     stats.failed,
+		     stats.retry,
+		     stats.multi_retry,
+		     stats.frame_dup,
+		     stats.rts_success,
+		     stats.rts_failure,
+		     stats.ack_failure,
+		     stats.rx_frag,
+		     stats.mcast_rx_frame,
+		     stats.fcs_error,
+		     stats.tx_frame,
+		     stats.wep_icv_error[0],
+		     stats.wep_icv_error[1],
+		     stats.wep_icv_error[2],
+		     stats.wep_icv_error[3],
+		     stats.bcn_rcv_cnt,
+		     stats.bcn_miss_cnt);
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, (char *)page,
+				      (unsigned long)p - page);
+
+free_and_exit:
+	free_page(page);
+	return ret;
+}
+
+/*
+ * debugfs "histogram" read handler: report sample count and per-rate/SNR/noise
+ * floor/signal strength histograms.
+ */
+static ssize_t
+nxpwifi_histogram_read(struct file *file, char __user *ubuf,
+		       size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	ssize_t ret;
+	struct nxpwifi_histogram_data *phist_data;
+	int i, value;
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+	char *p = (char *)page;
+
+	if (!p)
+		return -ENOMEM;
+
+	if (!priv || !priv->hist_data) {
+		ret = -EFAULT;
+		goto free_and_exit;
+	}
+
+	phist_data = priv->hist_data;
+
+	p += sprintf(p, "\n"
+		     "total samples = %d\n",
+		     atomic_read(&phist_data->num_samples));
+
+	p += sprintf(p,
+		     "rx rates (in Mbps): 0=1M   1=2M 2=5.5M  3=11M   4=6M   5=9M  6=12M\n"
+		     "7=18M  8=24M  9=36M  10=48M  11=54M 12-27=MCS0-15(BW20) 28-43=MCS0-15(BW40)\n");
+
+	if (ISSUPP_11ACENABLED(priv->adapter->fw_cap_info)) {
+		p += sprintf(p,
+			     "44-53=MCS0-9(VHT:BW20) 54-63=MCS0-9(VHT:BW40) 64-73=MCS0-9(VHT:BW80)\n\n");
+	} else {
+		p += sprintf(p, "\n");
+	}
+
+	for (i = 0; i < NXPWIFI_MAX_RX_RATES; i++) {
+		value = atomic_read(&phist_data->rx_rate[i]);
+		if (value)
+			p += sprintf(p, "rx_rate[%02d] = %d\n", i, value);
+	}
+
+	if (ISSUPP_11ACENABLED(priv->adapter->fw_cap_info)) {
+		for (i = NXPWIFI_MAX_RX_RATES; i < NXPWIFI_MAX_AC_RX_RATES;
+		     i++) {
+			value = atomic_read(&phist_data->rx_rate[i]);
+			if (value)
+				p += sprintf(p, "rx_rate[%02d] = %d\n",
+					   i, value);
+		}
+	}
+
+	for (i = 0; i < NXPWIFI_MAX_SNR; i++) {
+		value =  atomic_read(&phist_data->snr[i]);
+		if (value)
+			p += sprintf(p, "snr[%02ddB] = %d\n", i, value);
+	}
+	for (i = 0; i < NXPWIFI_MAX_NOISE_FLR; i++) {
+		value = atomic_read(&phist_data->noise_flr[i]);
+		if (value)
+			p += sprintf(p, "noise_flr[%02ddBm] = %d\n",
+				     (int)(i - 128), value);
+	}
+	for (i = 0; i < NXPWIFI_MAX_SIG_STRENGTH; i++) {
+		value = atomic_read(&phist_data->sig_str[i]);
+		if (value)
+			p += sprintf(p, "sig_strength[-%02ddBm] = %d\n",
+				i, value);
+	}
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, (char *)page,
+				      (unsigned long)p - page);
+
+free_and_exit:
+	free_page(page);
+	return ret;
+}
+
+static ssize_t
+nxpwifi_histogram_write(struct file *file, const char __user *ubuf,
+			size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv = (void *)file->private_data;
+
+	if (priv && priv->hist_data)
+		nxpwifi_hist_data_reset(priv);
+	return 0;
+}
+
+static struct nxpwifi_debug_info info;
+
+/* debugfs "debug" read handler: dump adapter debug info and BA/reorder tables. */
+static ssize_t
+nxpwifi_debug_read(struct file *file, char __user *ubuf,
+		   size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+	char *p = (char *)page;
+	ssize_t ret;
+
+	if (!p)
+		return -ENOMEM;
+
+	ret = nxpwifi_get_debug_info(priv, &info);
+	if (ret)
+		goto free_and_exit;
+
+	p += nxpwifi_debug_info_to_buffer(priv, p, &info);
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, (char *)page,
+				      (unsigned long)p - page);
+
+free_and_exit:
+	free_page(page);
+	return ret;
+}
+
+static u32 saved_reg_type, saved_reg_offset, saved_reg_value;
+
+/*
+ * debugfs "regrdwr" write handler: parse <type offset value> and store for
+ * readback/IO.
+ */
+static ssize_t
+nxpwifi_regrdwr_write(struct file *file,
+		      const char __user *ubuf, size_t count, loff_t *ppos)
+{
+	char *buf;
+	int ret;
+	u32 reg_type = 0, reg_offset = 0, reg_value = UINT_MAX;
+	int rv;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	rv = sscanf(buf, "%u %x %x", &reg_type, &reg_offset, &reg_value);
+
+	if (rv != 3) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	if (reg_type == 0 || reg_offset == 0) {
+		ret = -EINVAL;
+		goto done;
+	} else {
+		saved_reg_type = reg_type;
+		saved_reg_offset = reg_offset;
+		saved_reg_value = reg_value;
+		ret = count;
+	}
+done:
+	kfree(buf);
+	return ret;
+}
+
+/*
+ * debugfs "regrdwr" read handler: perform pending register read/write and return
+ * <type offset value>.
+ */
+static ssize_t
+nxpwifi_regrdwr_read(struct file *file, char __user *ubuf,
+		     size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	unsigned long addr = get_zeroed_page(GFP_KERNEL);
+	char *buf = (char *)addr;
+	int pos = 0, ret = 0;
+	u32 reg_value;
+
+	if (!buf)
+		return -ENOMEM;
+
+	if (!saved_reg_type) {
+		/* No command has been given */
+		pos += snprintf(buf, PAGE_SIZE, "0");
+		goto done;
+	}
+	/* Set command has been given */
+	if (saved_reg_value != UINT_MAX) {
+		ret = nxpwifi_reg_write(priv, saved_reg_type, saved_reg_offset,
+					saved_reg_value);
+
+		pos += snprintf(buf, PAGE_SIZE, "%u 0x%x 0x%x\n",
+				saved_reg_type, saved_reg_offset,
+				saved_reg_value);
+
+		ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+
+		goto done;
+	}
+	/* Get command has been given */
+	ret = nxpwifi_reg_read(priv, saved_reg_type,
+			       saved_reg_offset, &reg_value);
+	if (ret) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	pos += snprintf(buf, PAGE_SIZE, "%u 0x%x 0x%x\n", saved_reg_type,
+			saved_reg_offset, reg_value);
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+
+done:
+	free_page(addr);
+	return ret;
+}
+
+/* debugfs "debug_mask" read handler: show driver debug mask. */
+
+static ssize_t
+nxpwifi_debug_mask_read(struct file *file, char __user *ubuf,
+			size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+	char *buf = (char *)page;
+	size_t ret = 0;
+	int pos = 0;
+
+	if (!buf)
+		return -ENOMEM;
+
+	pos += snprintf(buf, PAGE_SIZE, "debug mask=0x%08x\n",
+			priv->adapter->debug_mask);
+	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+
+	free_page(page);
+	return ret;
+}
+
+/* debugfs "debug_mask" write handler: set driver debug mask. */
+
+static ssize_t
+nxpwifi_debug_mask_write(struct file *file, const char __user *ubuf,
+			 size_t count, loff_t *ppos)
+{
+	int ret;
+	unsigned long debug_mask;
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	char *buf;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	if (kstrtoul(buf, 0, &debug_mask)) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	priv->adapter->debug_mask = debug_mask;
+	ret = count;
+done:
+	kfree(buf);
+	return ret;
+}
+
+/* debugfs "verext" write handler: select extended version string. */
+static ssize_t
+nxpwifi_verext_write(struct file *file, const char __user *ubuf,
+		     size_t count, loff_t *ppos)
+{
+	int ret;
+	u32 versionstrsel;
+	struct nxpwifi_private *priv = (void *)file->private_data;
+
+	ret = kstrtou32_from_user(ubuf, count, 10, &versionstrsel);
+	if (ret)
+		return ret;
+
+	priv->versionstrsel = versionstrsel;
+
+	return count;
+}
+
+/* debugfs "verext" read handler: show extended version string. */
+static ssize_t
+nxpwifi_verext_read(struct file *file, char __user *ubuf,
+		    size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	char buf[256];
+	int ret;
+
+	nxpwifi_get_ver_ext(priv, priv->versionstrsel);
+	ret = snprintf(buf, sizeof(buf), "version string: %s\n",
+		       priv->version_str);
+
+	return simple_read_from_buffer(ubuf, count, ppos, buf, ret);
+}
+
+/* debugfs "memrw" write handler: read/write firmware memory (addr, value). */
+static ssize_t
+nxpwifi_memrw_write(struct file *file, const char __user *ubuf, size_t count,
+		    loff_t *ppos)
+{
+	int ret;
+	char cmd;
+	struct nxpwifi_ds_mem_rw mem_rw;
+	u16 cmd_action;
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	char *buf;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	ret = sscanf(buf, "%c %x %x", &cmd, &mem_rw.addr, &mem_rw.value);
+	if (ret != 3) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	if ((cmd == 'r') || (cmd == 'R')) {
+		cmd_action = HOST_ACT_GEN_GET;
+		mem_rw.value = 0;
+	} else if ((cmd == 'w') || (cmd == 'W')) {
+		cmd_action = HOST_ACT_GEN_SET;
+	} else {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	memcpy(&priv->mem_rw, &mem_rw, sizeof(mem_rw));
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_MEM_ACCESS, cmd_action, 0,
+			       &mem_rw, true);
+	if (!ret)
+		ret = count;
+
+done:
+	kfree(buf);
+	return ret;
+}
+
+/* debugfs "memrw" read handler: show last memory access result. */
+static ssize_t
+nxpwifi_memrw_read(struct file *file, char __user *ubuf,
+		   size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	unsigned long addr = get_zeroed_page(GFP_KERNEL);
+	char *buf = (char *)addr;
+	int ret, pos = 0;
+
+	if (!buf)
+		return -ENOMEM;
+
+	pos += snprintf(buf, PAGE_SIZE, "0x%x 0x%x\n", priv->mem_rw.addr,
+			priv->mem_rw.value);
+	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+
+	free_page(addr);
+	return ret;
+}
+
+static u32 saved_offset = -1, saved_bytes = -1;
+
+/* debugfs "rdeeprom" write handler: set EEPROM offset/length to read. */
+static ssize_t
+nxpwifi_rdeeprom_write(struct file *file,
+		       const char __user *ubuf, size_t count, loff_t *ppos)
+{
+	char *buf;
+	int ret = 0;
+	int offset = -1, bytes = -1;
+	int rv;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	rv = sscanf(buf, "%d %d", &offset, &bytes);
+
+	if (rv != 2) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	if (offset == -1 || bytes == -1) {
+		ret = -EINVAL;
+		goto done;
+	} else {
+		saved_offset = offset;
+		saved_bytes = bytes;
+		ret = count;
+	}
+done:
+	kfree(buf);
+	return ret;
+}
+
+/* debugfs "rdeeprom" read handler: dump EEPROM bytes from saved offset/length. */
+static ssize_t
+nxpwifi_rdeeprom_read(struct file *file, char __user *ubuf,
+		      size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	unsigned long addr = get_zeroed_page(GFP_KERNEL);
+	char *buf = (char *)addr;
+	int pos, ret, i;
+	u8 value[MAX_EEPROM_DATA];
+
+	if (!buf)
+		return -ENOMEM;
+
+	if (saved_offset == -1) {
+		/* No command has been given */
+		pos = snprintf(buf, PAGE_SIZE, "0");
+		goto done;
+	}
+
+	/* Get command has been given */
+	ret = nxpwifi_eeprom_read(priv, (u16)saved_offset,
+				  (u16)saved_bytes, value);
+	if (ret) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	pos = snprintf(buf, PAGE_SIZE, "%d %d ", saved_offset, saved_bytes);
+
+	for (i = 0; i < saved_bytes; i++)
+		pos += scnprintf(buf + pos, PAGE_SIZE - pos, "%d ", value[i]);
+
+done:
+	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+out_free:
+	free_page(addr);
+	return ret;
+}
+
+/*
+ * debugfs "hscfg" write handler: configure host-sleep (conditions/gpio/gap) or
+ * cancel.
+ */
+static ssize_t
+nxpwifi_hscfg_write(struct file *file, const char __user *ubuf,
+		    size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	char *buf;
+	int ret, arg_num;
+	struct nxpwifi_ds_hs_cfg hscfg;
+	int conditions = HS_CFG_COND_DEF;
+	u32 gpio = HS_CFG_GPIO_DEF, gap = HS_CFG_GAP_DEF;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	arg_num = sscanf(buf, "%d %x %x", &conditions, &gpio, &gap);
+
+	memset(&hscfg, 0, sizeof(struct nxpwifi_ds_hs_cfg));
+
+	if (arg_num > 3) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "Too many arguments\n");
+		ret = -EINVAL;
+		goto done;
+	}
+
+	if (arg_num >= 1 && arg_num < 3)
+		nxpwifi_set_hs_params(priv, HOST_ACT_GEN_GET,
+				      NXPWIFI_SYNC_CMD, &hscfg);
+
+	if (arg_num) {
+		if (conditions == HS_CFG_CANCEL) {
+			nxpwifi_cancel_hs(priv, NXPWIFI_ASYNC_CMD);
+			ret = count;
+			goto done;
+		}
+		hscfg.conditions = conditions;
+	}
+	if (arg_num >= 2)
+		hscfg.gpio = gpio;
+	if (arg_num == 3)
+		hscfg.gap = gap;
+
+	hscfg.is_invoke_hostcmd = false;
+	nxpwifi_set_hs_params(priv, HOST_ACT_GEN_SET,
+			      NXPWIFI_SYNC_CMD, &hscfg);
+
+	nxpwifi_enable_hs(priv->adapter);
+	clear_bit(NXPWIFI_IS_HS_ENABLING, &priv->adapter->work_flags);
+	ret = count;
+done:
+	kfree(buf);
+	return ret;
+}
+
+/* debugfs "hscfg" read handler: show current host-sleep configuration. */
+static ssize_t
+nxpwifi_hscfg_read(struct file *file, char __user *ubuf,
+		   size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	unsigned long addr = get_zeroed_page(GFP_KERNEL);
+	char *buf = (char *)addr;
+	int pos, ret;
+	struct nxpwifi_ds_hs_cfg hscfg;
+
+	if (!buf)
+		return -ENOMEM;
+
+	nxpwifi_set_hs_params(priv, HOST_ACT_GEN_GET,
+			      NXPWIFI_SYNC_CMD, &hscfg);
+
+	pos = snprintf(buf, PAGE_SIZE, "%u 0x%x 0x%x\n", hscfg.conditions,
+		       hscfg.gpio, hscfg.gap);
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+
+	free_page(addr);
+	return ret;
+}
+
+static ssize_t
+nxpwifi_timeshare_coex_read(struct file *file, char __user *ubuf,
+			    size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv = file->private_data;
+	char buf[3];
+	bool timeshare_coex;
+	int ret;
+	unsigned int len;
+
+	if (priv->adapter->fw_api_ver != NXPWIFI_FW_V15)
+		return -EOPNOTSUPP;
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_ROBUST_COEX,
+			       HOST_ACT_GEN_GET, 0, &timeshare_coex, true);
+	if (ret)
+		return ret;
+
+	len = sprintf(buf, "%d\n", timeshare_coex);
+	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
+}
+
+static ssize_t
+nxpwifi_timeshare_coex_write(struct file *file, const char __user *ubuf,
+			     size_t count, loff_t *ppos)
+{
+	bool timeshare_coex;
+	struct nxpwifi_private *priv = file->private_data;
+	int ret;
+
+	if (priv->adapter->fw_api_ver != NXPWIFI_FW_V15)
+		return -EOPNOTSUPP;
+
+	ret = kstrtobool_from_user(ubuf, count, &timeshare_coex);
+	if (ret)
+		return ret;
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_ROBUST_COEX,
+			       HOST_ACT_GEN_SET, 0, &timeshare_coex, true);
+	if (ret)
+		return ret;
+	else
+		return count;
+}
+
+static ssize_t
+nxpwifi_reset_write(struct file *file,
+		    const char __user *ubuf, size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv = file->private_data;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	bool result;
+	int rc;
+
+	rc = kstrtobool_from_user(ubuf, count, &result);
+	if (rc)
+		return rc;
+
+	if (!result)
+		return -EINVAL;
+
+	if (adapter->if_ops.card_reset) {
+		nxpwifi_dbg(adapter, INFO, "Resetting per request\n");
+		adapter->if_ops.card_reset(adapter);
+	}
+
+	return count;
+}
+
+static ssize_t
+nxpwifi_fake_radar_detect_write(struct file *file,
+				const char __user *ubuf,
+				size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv = file->private_data;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	bool result;
+	int rc;
+
+	rc = kstrtobool_from_user(ubuf, count, &result);
+	if (rc)
+		return rc;
+
+	if (!result)
+		return -EINVAL;
+
+	if (priv->wdev.links[0].cac_started) {
+		nxpwifi_dbg(adapter, MSG,
+			    "Generate fake radar detected during CAC\n");
+		if (nxpwifi_stop_radar_detection(priv, &priv->dfs_chandef))
+			nxpwifi_dbg(adapter, ERROR,
+				    "Failed to stop CAC in FW\n");
+		wiphy_delayed_work_cancel(priv->adapter->wiphy, &priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL, 0);
+		cfg80211_radar_event(adapter->wiphy, &priv->dfs_chandef,
+				     GFP_KERNEL);
+	} else {
+		if (priv->bss_chandef.chan->dfs_cac_ms) {
+			nxpwifi_dbg(adapter, MSG,
+				    "Generate fake radar detected\n");
+			cfg80211_radar_event(adapter->wiphy,
+					     &priv->dfs_chandef,
+					     GFP_KERNEL);
+		}
+	}
+
+	return count;
+}
+
+static ssize_t
+nxpwifi_netmon_write(struct file *file, const char __user *ubuf,
+		     size_t count, loff_t *ppos)
+{
+	int ret;
+	struct nxpwifi_802_11_net_monitor netmon_cfg;
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	char *buf;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+	memset(&netmon_cfg, 0, sizeof(struct nxpwifi_802_11_net_monitor));
+	ret = sscanf(buf, "%u %u %u %u %u",
+		     &netmon_cfg.enable_net_mon,
+		     &netmon_cfg.filter_flag,
+		     &netmon_cfg.band,
+		     &netmon_cfg.channel,
+		     &netmon_cfg.chan_bandwidth);
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11_NET_MONITOR,
+			       HOST_ACT_GEN_SET, 0, &netmon_cfg, true);
+
+	if (!ret)
+		ret = count;
+
+	kfree(buf);
+	return ret;
+}
+
+static ssize_t
+nxpwifi_twt_setup_write(struct file *file, const char __user *ubuf,
+			size_t count, loff_t *ppos)
+{
+	int ret;
+	struct nxpwifi_twt_cfg twt_cfg;
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	char *buf;
+	u16 twt_mantissa, bcn_miss_threshold;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	ret = sscanf(buf, "%hhu %hhu %hhu %hhu %hhu %hhu %hhu %hhu %hhu %hu %hhu %hu",
+		     &twt_cfg.param.twt_setup.implicit,
+		     &twt_cfg.param.twt_setup.announced,
+		     &twt_cfg.param.twt_setup.trigger_enabled,
+		     &twt_cfg.param.twt_setup.twt_info_disabled,
+		     &twt_cfg.param.twt_setup.negotiation_type,
+		     &twt_cfg.param.twt_setup.twt_wakeup_duration,
+		     &twt_cfg.param.twt_setup.flow_identifier,
+		     &twt_cfg.param.twt_setup.hard_constraint,
+		     &twt_cfg.param.twt_setup.twt_exponent,
+		     &twt_mantissa,
+		     &twt_cfg.param.twt_setup.twt_request,
+		     &bcn_miss_threshold);
+
+	twt_cfg.param.twt_setup.twt_mantissa = cpu_to_le16(twt_mantissa);
+	twt_cfg.param.twt_setup.bcn_miss_threshold = cpu_to_le16(bcn_miss_threshold);
+	twt_cfg.sub_id = NXPWIFI_11AX_TWT_SETUP_SUBID;
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_TWT_CFG, HOST_ACT_GEN_SET, 0,
+			       &twt_cfg, true);
+	if (!ret)
+		ret = count;
+
+	kfree(buf);
+	return ret;
+}
+
+static ssize_t
+nxpwifi_twt_teardown_write(struct file *file, const char __user *ubuf,
+			   size_t count, loff_t *ppos)
+{
+	int ret;
+	struct nxpwifi_twt_cfg twt_cfg;
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	char *buf;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	ret = sscanf(buf, "%hhu %hhu %hhu",
+		     &twt_cfg.param.twt_teardown.flow_identifier,
+		     &twt_cfg.param.twt_teardown.negotiation_type,
+		     &twt_cfg.param.twt_teardown.teardown_all_twt);
+
+	twt_cfg.sub_id = NXPWIFI_11AX_TWT_TEARDOWN_SUBID;
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_TWT_CFG, HOST_ACT_GEN_SET, 0,
+			       &twt_cfg, true);
+
+	if (!ret)
+		ret = count;
+
+	kfree(buf);
+	return ret;
+}
+
+static ssize_t
+nxpwifi_twt_report_read(struct file *file, char __user *ubuf,
+			size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+	char *p = (char *)page;
+	ssize_t ret;
+	struct nxpwifi_twt_cfg twt_cfg;
+	u8 num, i, j;
+
+	if (!p)
+		return -ENOMEM;
+
+	twt_cfg.sub_id = NXPWIFI_11AX_TWT_REPORT_SUBID;
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_TWT_CFG, HOST_ACT_GEN_GET, 0,
+			       &twt_cfg, true);
+	if (ret)
+		goto done;
+	num = twt_cfg.param.twt_report.length / NXPWIFI_BTWT_REPORT_LEN;
+	num = num <= NXPWIFI_BTWT_REPORT_MAX_NUM ? num : NXPWIFI_BTWT_REPORT_MAX_NUM;
+	p += sprintf(p, "\ntwt_report len %hhu, num %hhu, twt_report_info:\n",
+		twt_cfg.param.twt_report.length, num);
+	for (i = 0; i < num; i++) {
+		p += sprintf(p, "id[%hu]:\r\n", i);
+		for (j = 0; j < NXPWIFI_BTWT_REPORT_LEN; j++) {
+			p += sprintf(p,
+				" 0x%02x",
+				twt_cfg.param.twt_report.data[i * NXPWIFI_BTWT_REPORT_LEN + j]);
+		}
+		p += sprintf(p, "\r\n");
+	}
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, (char *)page,
+				      (unsigned long)p - page);
+
+done:
+	free_page(page);
+	return ret;
+}
+
+static ssize_t
+nxpwifi_twt_information_write(struct file *file, const char __user *ubuf,
+			      size_t count, loff_t *ppos)
+{
+	int ret;
+	struct nxpwifi_twt_cfg twt_cfg;
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	char *buf;
+	u32 suspend_duration;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	ret = sscanf(buf, "%hhu %u",
+		     &twt_cfg.param.twt_information.flow_identifier, &suspend_duration);
+	twt_cfg.param.twt_information.suspend_duration = cpu_to_le32(suspend_duration);
+
+	twt_cfg.sub_id = NXPWIFI_11AX_TWT_INFORMATION_SUBID;
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_TWT_CFG, HOST_ACT_GEN_SET, 0,
+			       &twt_cfg, true);
+
+	if (!ret)
+		ret = count;
+
+	kfree(buf);
+	return ret;
+}
+
+#define NXPWIFI_DFS_ADD_FILE(name) debugfs_create_file(#name, 0644,     \
+				   priv->dfs_dev_dir, priv,             \
+				   &nxpwifi_dfs_##name##_fops)
+
+#define NXPWIFI_DFS_FILE_OPS(name)                                      \
+static const struct file_operations nxpwifi_dfs_##name##_fops = {       \
+	.read = nxpwifi_##name##_read,                                  \
+	.write = nxpwifi_##name##_write,                                \
+	.open = simple_open,                                            \
+}
+
+#define NXPWIFI_DFS_FILE_READ_OPS(name)                                 \
+static const struct file_operations nxpwifi_dfs_##name##_fops = {       \
+	.read = nxpwifi_##name##_read,                                  \
+	.open = simple_open,                                            \
+}
+
+#define NXPWIFI_DFS_FILE_WRITE_OPS(name)                                \
+static const struct file_operations nxpwifi_dfs_##name##_fops = {       \
+	.write = nxpwifi_##name##_write,                                \
+	.open = simple_open,                                            \
+}
+
+NXPWIFI_DFS_FILE_READ_OPS(info);
+NXPWIFI_DFS_FILE_READ_OPS(debug);
+NXPWIFI_DFS_FILE_READ_OPS(getlog);
+NXPWIFI_DFS_FILE_OPS(regrdwr);
+NXPWIFI_DFS_FILE_OPS(rdeeprom);
+NXPWIFI_DFS_FILE_OPS(memrw);
+NXPWIFI_DFS_FILE_OPS(hscfg);
+NXPWIFI_DFS_FILE_OPS(histogram);
+NXPWIFI_DFS_FILE_OPS(debug_mask);
+NXPWIFI_DFS_FILE_OPS(timeshare_coex);
+NXPWIFI_DFS_FILE_WRITE_OPS(reset);
+NXPWIFI_DFS_FILE_WRITE_OPS(fake_radar_detect);
+NXPWIFI_DFS_FILE_OPS(verext);
+NXPWIFI_DFS_FILE_WRITE_OPS(netmon);
+NXPWIFI_DFS_FILE_WRITE_OPS(twt_setup);
+NXPWIFI_DFS_FILE_WRITE_OPS(twt_teardown);
+NXPWIFI_DFS_FILE_READ_OPS(twt_report);
+NXPWIFI_DFS_FILE_WRITE_OPS(twt_information);
+
+/* Create per-netdev debugfs directory and files. */
+void
+nxpwifi_dev_debugfs_init(struct nxpwifi_private *priv)
+{
+	if (!nxpwifi_dfs_dir || !priv)
+		return;
+
+	priv->dfs_dev_dir = debugfs_create_dir(priv->netdev->name,
+					       nxpwifi_dfs_dir);
+
+	NXPWIFI_DFS_ADD_FILE(info);
+	NXPWIFI_DFS_ADD_FILE(debug);
+	NXPWIFI_DFS_ADD_FILE(getlog);
+	NXPWIFI_DFS_ADD_FILE(regrdwr);
+	NXPWIFI_DFS_ADD_FILE(rdeeprom);
+
+	NXPWIFI_DFS_ADD_FILE(memrw);
+	NXPWIFI_DFS_ADD_FILE(hscfg);
+	NXPWIFI_DFS_ADD_FILE(histogram);
+	NXPWIFI_DFS_ADD_FILE(debug_mask);
+	NXPWIFI_DFS_ADD_FILE(timeshare_coex);
+	NXPWIFI_DFS_ADD_FILE(reset);
+	NXPWIFI_DFS_ADD_FILE(fake_radar_detect);
+	NXPWIFI_DFS_ADD_FILE(verext);
+	NXPWIFI_DFS_ADD_FILE(netmon);
+	NXPWIFI_DFS_ADD_FILE(twt_setup);
+	NXPWIFI_DFS_ADD_FILE(twt_teardown);
+	NXPWIFI_DFS_ADD_FILE(twt_report);
+	NXPWIFI_DFS_ADD_FILE(twt_information);
+}
+
+/* Remove per-netdev debugfs directory and files. */
+void
+nxpwifi_dev_debugfs_remove(struct nxpwifi_private *priv)
+{
+	if (!priv)
+		return;
+
+	debugfs_remove_recursive(priv->dfs_dev_dir);
+}
+
+/* Create top-level debugfs directory. */
+void
+nxpwifi_debugfs_init(void)
+{
+	if (!nxpwifi_dfs_dir)
+		nxpwifi_dfs_dir = debugfs_create_dir("nxpwifi", NULL);
+}
+
+/* Remove top-level debugfs directory. */
+void
+nxpwifi_debugfs_remove(void)
+{
+	debugfs_remove(nxpwifi_dfs_dir);
+}
-- 
2.34.1


