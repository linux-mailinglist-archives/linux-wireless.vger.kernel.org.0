Return-Path: <linux-wireless+bounces-37697-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EWB6FgKoK2oaBgQAu9opvQ
	(envelope-from <linux-wireless+bounces-37697-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 08:32:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFBD676EDD
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 08:32:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=UBtW8XuH;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37697-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37697-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94143307E784
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 06:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099913955FA;
	Fri, 12 Jun 2026 06:32:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010054.outbound.protection.outlook.com [52.101.69.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577E83D7D87;
	Fri, 12 Jun 2026 06:32:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781245931; cv=fail; b=TCl+//kM6sd1cg44873KGendSfTQ6S6bBqd2nxsqpOFvXs/Kib7Fpl86Dq73HHh0XCfo1pk0+iCfMgNzdq2dU9Fv9U5mDhX3EH8EuEfbfdkohwqdAfHNEpGa8x7i2OLOyceGz1siPy0ojUvAl6NKVjuCQm7uwvfcF5HehMe3YgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781245931; c=relaxed/simple;
	bh=3UQk/gndKJwP34aphs+bjBueXzF0f/2qi4Nmw5KJbtw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SEE7/y6YOHA/Ir6JrtrruChfEXaG/Qj/Fa0nduvBuEXhx6B46wDlYJaq+VTwUOQAz8ZYouuMpQaJVAExcO5OPhmMIC3JBkd7vV4C4WJ8LgayCrnkkKU350l+/+4pSeIcrsEkn99xwnmrAE/BqWCiPIVlhHvNb/pquRWTNrtc3GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UBtW8XuH; arc=fail smtp.client-ip=52.101.69.54
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eeanOZnj8/f6443kfMQbkLRkYV190Ys+1F2UtcJFqNInXdz+AeetlBVsG7cNuR/wvwQIRYslRvFZIms822VITWu78TZdbs2tuOaWY5hi2Hz7CKnvAg+wU5Q2XAt6DcmNB9LKAjCeZ/nlUK7c87WYwe3Ao61RMUM7ZJsSmlYsJwWZ6cuUclJpvIVYyMVpVUsQZ+6DIxdocYlO1/SWymkuqDFKj4YQCkedAZpHljZ2fav31L2w4SmYRrcGiBVmbyWlKxx2OPhrSqRgVlPT0dfRqgbB1iDkZaD5CmP4us0p2ji8axJqIkn9C0KmlA1/sGwQH/L2C08lpF+fGH9OpYmBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UyLY8kanW048D04G/w4VJrXjtcUeWQIu+yzT/1/eZk=;
 b=JWEDz+1+7yxnHqvK72heoJEYMtiXJNDyjZ+C16iCqqCk0bt00rrkHCu1MmCCzZuYXo6EKBNDTnDmaB9Un3I3VlkSWmtPEAd+KD653H0uIdkAJuGc3rBnSwbPCTSVOXBUep1WbAVAuUOW4bN7ot/IRyfAT/TjPJ5tXPPOGSfaaLDU++FCDUaq0uEroYHVsQRc03CWaG+l6eerC//+5DnQ6RPbfH/YIsGZI9lkGqGyXqX1OLtI9hlO0cO2ZDUEYLRHx5KUQsAVO+sgWswVLHp3+MYp3yyegnZ8pvFnH+52NUhCYZaDreb6lcPvARLZr8gdGStlrAxljOSm/av/TlmIqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UyLY8kanW048D04G/w4VJrXjtcUeWQIu+yzT/1/eZk=;
 b=UBtW8XuHUN4HzRAKJBjGgkD0WY6w/aHSiaey6YK/VNhC464lGSEaZJ5f/9fkZa+wFDkQ+GdeuKMhMu6+WdnY51iL0cA8xQaIJSNdsmbgsWctXKi/TwZqMcAygj659ZVApiNQbueqYpxCS5NsX2i9foeYEZ9cQO+WzZgzx6kXVWDaPheZ/zvv0VLQIU+vvwb8btLiMO/13e6Rfu3Bux7uU5uCCZ8Hh6S8NgL2l1gELGzZNybbh1+GulsktsT9UVT5xvxH73f+ufrKKw4LtKgdRIZ8jpems7JCcBNq9biDjKCkPB6RSLWoJi038EsNtKOzL4KCbPRGreADitZdrKgoLw==
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by PAXPR04MB8750.eurprd04.prod.outlook.com (2603:10a6:102:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 12 Jun
 2026 06:32:06 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 06:32:06 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ulfh@kernel.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de
Subject: pull-request: nxpwifi-2026-06-12
Date: Fri, 12 Jun 2026 14:32:08 +0800
Message-Id: <20260612063208.2754029-1-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::8) To AM6PR04MB5239.eurprd04.prod.outlook.com
 (2603:10a6:20b:7::12)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5239:EE_|PAXPR04MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: 642c709c-f3dd-4426-7139-08dec84c528f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|23010399003|1800799024|19092799006|366016|38350700014|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ArrLp03Zfd01OiqGFgjaV9xntVDggPL1cs63TYPbSN7zCnBOqukckqEGzChOkOkTNb1+4mE0h+OWao2D34LXmgBUG7dBceLD+HqvhcFrHWDgFmjeNz/3QBmFtk3PirxKGWxZXGhVeiJqJtnivNsdktwy2yVNdz48p3eWMEXgZzxruXGg8mHexsMbuvmGRz7n8vN34k7/yNGJbVUVz7AdUgicvQmcd/X/vaGVzj+EjXMyd/Y/NExHlGwQ01xad4YWc+GIsoiYgn4mGve/z4KlEB8s/xjiM1iqLWKxTcFGG0ToFZ8yEQ3WZHHqiVAabW2DtwWa0rA9c3KgXmA5lpvyDPQ0ZDFS/FRCH2uQDmU5zohAhOO0F0MTs6cxa1erk8trn7YJ8l2JGjAZcZJ1xgXroo3eEnUO4A2xrwLM3aocbkKBsAWqmhT3a+w8+HU2k7RWJcXUmteVQVVONRPZo3chms8IqvUzZpPGKs1PHy4FB3ub2gbeZm7Gzd+1LoiCP6UU3j1kptJsp/0uDjf2AZ27fs/AqlUIaytg3VBr7Vn4ppsX7C6eLxCwkq9XJZJ+t/pAOJzZs0B3cU9LPva16hdWV5BsYy0/pcqXpMD3N6XZx7E3qOc8II0KJpku4XRFLAwd/X+E4sxsbLy0gawbeTd6QOk6oqqGsPdAitIe2STl31GQQTdcjZ5x9niST3preT9t140WV5suTcE0zxIcA/7zfyQmVT+FltmST7QScu4JIzZWB8HN1hLS7w1IkIqQkeRO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(23010399003)(1800799024)(19092799006)(366016)(38350700014)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yEyD77rbhzBdB8ew0QHEqLHKrEfjXMfFxzQpgmORf/LyEEQsvZrxKlNSR4oL?=
 =?us-ascii?Q?odc6NFxMcNZ8vzi38ZV5fNV1b7nui9OMBHktvqJXS1F833Y1S3fmldLZFRDk?=
 =?us-ascii?Q?oDtBrJGxvR9/YWhuasesiRn6xWX6MaaePuc5oVPU4JPjXI6R2uAb5459ICop?=
 =?us-ascii?Q?zoK0ooN8lCN1+SP30HQk9RtPLvISFL56wPsF70YukRZsFGUgr8Y4SP8GnSxl?=
 =?us-ascii?Q?k8MEQ5GINBWdfldi6/RjQwOObkN2hGV0En1NzDCMgaCSdW3UNri9Odf5BcjM?=
 =?us-ascii?Q?LND2ESovzIspAi5qm4A/iLHjhSIIIYn3XG4UAFnWvOpS6BL+UFFA77qLtsHD?=
 =?us-ascii?Q?o8ybBSUED3YbQUoEIRdCVdOnpdL9R3Sif8OvNbn5v0qItjMekA+1LKzfm+DN?=
 =?us-ascii?Q?GAIGVGUcjPjF0O3po6IPvHS8wsCVvFZHqgdM+s3oiiJJla7p5raam6MT03EU?=
 =?us-ascii?Q?FUiYVyxEOn1mu28A743EW5hWRMCewzGDCJj6oO2MaHZMbbQi3KgEHJRw/kR9?=
 =?us-ascii?Q?ZRLaACZ5dR7fDgmzLeKFW/l8N6uqx5blKYgLa0ezcnFOOu8z9UrXKVwcAECx?=
 =?us-ascii?Q?xcfoWmv2GstsMyR4whxYOgO9UP3O+sQPpG7M9Bp4EaV+2h246oK70X5f1Fm8?=
 =?us-ascii?Q?xoge8YTcyVDAz9ovh6ZXcQIcBsoQea7lOw67K2hSNgTHzrclKpB+sHlvT6Lw?=
 =?us-ascii?Q?F1J/mWe8k4/vM+L4zEh2sfnjxQt4CyLWmTPKdMQrsBWix0v7WNRWBJ+b/SiX?=
 =?us-ascii?Q?IF3GRR2ch4jT1bnRR+/3NqT1OCp+PAYnhgM8D5FjQbnfTDMSTEvFD8B01gOj?=
 =?us-ascii?Q?v3pS0zY4mVM15dQKeBzL6U054bm1LOjBFmF1ZPMJM+1jbI9Mfz6kFe8jLiGm?=
 =?us-ascii?Q?JpTXi9BZwexRhZ3AVkxWRjdBNMiyfL3ZyK3npCC7Ee0yDnUI07BbaXb85kaH?=
 =?us-ascii?Q?Zv3L04YS2xEwNqVRtWbrlRfzO29BHAV+jKn9GdOExZAL6GowESnfLGc+Nx9s?=
 =?us-ascii?Q?4yn4GwJ7BJ5jXpi5Skp/ES1WfAEsR9LWWZK7exPpzI//3LUqFk6tACqPZC8e?=
 =?us-ascii?Q?ihv6G4zJq5GG0JdcwUO49wOW/ZYS8i6yATslCX3F1HOdAuqvtjPMrRJs8VsM?=
 =?us-ascii?Q?+2TfAYzDcWOanrToKN1QuxWPrwn1CML4YgdjJInOkjcXmOjbdotSaIJJ+kb4?=
 =?us-ascii?Q?YrJgvZWlQWiyUBrEjEvVe/p/ONHpXf8jxrXOxNaBCfxrmfzde50aXPRX5qf+?=
 =?us-ascii?Q?7kpJL3VzsFCT8IVECH13R88Nj85ZlXoILhrfHzMR/a58pfOTFHBhSlm5mIEh?=
 =?us-ascii?Q?NwhPY1JCRovPedFyPLbjizO2hNC8ni50QwlEx9BHGtYPcAjY8E5L/35+FFXP?=
 =?us-ascii?Q?JYCP8S6AfoUT+Gx+c+BPhVV2JIblTxK4ExVD0AZXBfqmU3F1yHihUHqIUJaM?=
 =?us-ascii?Q?f6OI17XNXhIpGjH/DpFOrVZGeRi4eLY2OanoezcQ7JxOSvobikrT2rc+OStn?=
 =?us-ascii?Q?gNGytFMAvXZSj+RTksvMB2EzKahu3EiogOugJjcm7qZZZuQJ6WyT+GPBfsHP?=
 =?us-ascii?Q?8CQ858coKyq19bOjg/zAzIBkjJH3LttuYN9zBY30LmCtn7w0SwvN1RwiYGlq?=
 =?us-ascii?Q?YNbha15QpViJL8bzU0XLCW0eRodGDZTa8MDGzVjuhODS0d3gaOoFq2kOvDKk?=
 =?us-ascii?Q?lyQjJiDu1QaCfQmD4mTecaGltoyWbwk5vq0f9ErL6eFvArtsbdDJQCW4P5TN?=
 =?us-ascii?Q?ToIEInPEyg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642c709c-f3dd-4426-7139-08dec84c528f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 06:32:06.5666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUdhZycfy9UeoKwHIrqWPp766pKo4QHK3S5vzbx5BfBucG9i9n7FvsDgGgKyOp5qmwADmyXXUusTWYHyug3F4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8750
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37697-lists,linux-wireless=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ulfh@kernel.org,m:johannes@sipsolutions.net,m:francesco@dolcini.it,m:wyatt.hsu@nxp.com,m:s.hauer@pengutronix.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:dkim,nxp.com:mid,nxp.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BCFBD676EDD

The following changes since commit 972c4dd19cb92e03d75b66c426cfade07582a1ba:

  Merge tag 'wireless-next-2026-06-10' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next (2026-06-10 07:59:45 -0700)

are available in the Git repository at:

  https://github.com/jeffchen71/nxpwifi/ tags/nxpwifi-2026-06-12

for you to fetch changes up to 4c477f8bfc1a86c54a719cae475f7fa1973eba0f:

  wifi: nxp: add nxpwifi driver for IW61x (2026-06-12 10:07:33 +0800)

----------------------------------------------------------------
wifi: nxp: patches for wireless-next

In nxpwifi, introduce initial driver support for NXP IW61x Wi-Fi chipsets.
The driver supports 802.11ac/ax, SDIO interface, Station and uAP modes.

----------------------------------------------------------------
Jeff Chen (2):
      mmc: core: add NXP IW61x base ID and block size quirk
      wifi: nxp: add nxpwifi driver for IW61x

 MAINTAINERS                                      |    7 +
 drivers/mmc/core/quirks.h                        |    3 +
 drivers/net/wireless/Kconfig                     |    1 +
 drivers/net/wireless/Makefile                    |    1 +
 drivers/net/wireless/nxp/Kconfig                 |   17 +
 drivers/net/wireless/nxp/Makefile                |    3 +
 drivers/net/wireless/nxp/nxpwifi/11ac.c          |  280 ++
 drivers/net/wireless/nxp/nxpwifi/11ac.h          |   33 +
 drivers/net/wireless/nxp/nxpwifi/11ax.c          |  594 ++++
 drivers/net/wireless/nxp/nxpwifi/11ax.h          |   73 +
 drivers/net/wireless/nxp/nxpwifi/11h.c           |  339 ++
 drivers/net/wireless/nxp/nxpwifi/11n.c           |  837 +++++
 drivers/net/wireless/nxp/nxpwifi/11n.h           |  158 +
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c      |  251 ++
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h      |   21 +
 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c |  826 +++++
 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h |   71 +
 drivers/net/wireless/nxp/nxpwifi/Kconfig         |   22 +
 drivers/net/wireless/nxp/nxpwifi/Makefile        |   39 +
 drivers/net/wireless/nxp/nxpwifi/cfg.h           | 1019 ++++++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.c      | 3931 ++++++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.h      |   18 +
 drivers/net/wireless/nxp/nxpwifi/cfp.c           |  458 +++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.c        | 1310 +++++++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.h        |  122 +
 drivers/net/wireless/nxp/nxpwifi/debugfs.c       | 1094 ++++++
 drivers/net/wireless/nxp/nxpwifi/ethtool.c       |   58 +
 drivers/net/wireless/nxp/nxpwifi/fw.h            | 2459 ++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/ie.c            |  480 +++
 drivers/net/wireless/nxp/nxpwifi/init.c          |  607 ++++
 drivers/net/wireless/nxp/nxpwifi/join.c          |  787 +++++
 drivers/net/wireless/nxp/nxpwifi/main.c          | 1673 +++++++++
 drivers/net/wireless/nxp/nxpwifi/main.h          | 1427 ++++++++
 drivers/net/wireless/nxp/nxpwifi/scan.c          | 2695 +++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.c          | 2327 +++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.h          |  340 ++
 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c       | 1165 +++++++
 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c       | 3387 +++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sta_event.c     |  862 +++++
 drivers/net/wireless/nxp/nxpwifi/sta_rx.c        |  242 ++
 drivers/net/wireless/nxp/nxpwifi/sta_tx.c        |  190 ++
 drivers/net/wireless/nxp/nxpwifi/txrx.c          |  352 ++
 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c       | 1256 +++++++
 drivers/net/wireless/nxp/nxpwifi/uap_event.c     |  488 +++
 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c      |  478 +++
 drivers/net/wireless/nxp/nxpwifi/util.c          | 1381 ++++++++
 drivers/net/wireless/nxp/nxpwifi/util.h          |  155 +
 drivers/net/wireless/nxp/nxpwifi/wmm.c           | 1313 ++++++++
 drivers/net/wireless/nxp/nxpwifi/wmm.h           |   77 +
 include/linux/mmc/sdio_ids.h                     |    1 +
 50 files changed, 35728 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/Kconfig
 create mode 100644 drivers/net/wireless/nxp/Makefile
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11h.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Kconfig
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Makefile
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg80211.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg80211.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfp.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/debugfs.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ethtool.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/fw.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ie.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/init.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/join.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/scan.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_event.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_rx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_tx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/txrx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_event.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.h

