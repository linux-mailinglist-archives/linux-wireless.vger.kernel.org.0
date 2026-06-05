Return-Path: <linux-wireless+bounces-37440-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6J/EFvr7ImpjgAEAu9opvQ
	(envelope-from <linux-wireless+bounces-37440-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 18:40:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9ED649DB4
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 18:40:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=W9uWhgPV;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37440-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37440-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 551C73134E55
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 16:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B083DFC67;
	Fri,  5 Jun 2026 16:14:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013057.outbound.protection.outlook.com [52.101.83.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30518406825;
	Fri,  5 Jun 2026 16:14:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676099; cv=fail; b=mUklHXGhmAj3Ltc5WCwUymyFXYIQKuEPUD+T5RSuVlVsLuaTH9uf1ESPyCD1yP0cjR58D6gifo8YNEvKC/iZFKKsHe74yC7AwN9sT6gjiyPmJqtt8EyfjuE0GVV6Olo3WFvuC357NIaqg4MQFKJkQDIoU+enBrSj/6cYwuF9QRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676099; c=relaxed/simple;
	bh=oAC0Y1Vcw6jY5NVV2LTCAi/5UKiNxceyr4q1NW9XEM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dCiDWmnf9B2nlzQ8wGeGLsuvHICAOkQfQ/KGnjCzKzs2yAXG4Xlt1P3UlkOXTXs3xrnWWfAhT7yRoypmeRgWgpyz8g4F3RC+ilEB4fpRLcLBQ0+PLGixUCQBQk6CgAOzJNUxFaK2VlOGPHRyjFU8bcJ0Mya4L0zbJDRoVPjdD80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W9uWhgPV; arc=fail smtp.client-ip=52.101.83.57
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1ziksKb/3gBf/aeNhT0PqjnZJcwcXsq+aOMURpBfywFsgejel75nvwXyWzi/1wPGvc4Fb3DqiPqSb8w5zY8jtRMOAn5ab5+p27flBYARBwqLFxw0WQfW0nhx7Bn6gg7PqHSROB+gojH2Mh9Xv7g3+KF+uMH++hqXVYiSzB/jJxFmcU1D4zwEBRU5hdvRt76RCb+qFvzvjRJzC0Y78IJ8No9RtH9zH/5l9pyQW7LQjG4lrBdGtxTErS741b5knTSCA2pV31t/Uvow7VR79K9PEf4wpPWuLDJWOAiCkVux6aHJqvf7RWUjVRk8Qhgw2QPQ/W3iz0RPM7wiaXQvLVagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4F3+24SqD4Os9Ablxf+os+lU7pInNeJp93RKath79M=;
 b=XCqej9V2/ylG+HfKMRZAjxz5p8+lG+f9WM9CidQNWS07g5z43RXhr42gLMW9wi0unUipkFy8cLK3qbMii9NKD9mHg9T4gmUPpQK8sS6Z17A8NU5B82RUyqqpJWsdTszoZvsCZ/1PfpmSJHwt6/aY6s8fWR+HzpuFA7TktLvzpeLrdzvZBQAew596tJlHiFvR+OT9lUdqB4t3EPrvi3fFIKgokFbYoF7QKKZdGrO5iBxUhMiqU9BhYoZLPwGP5amYgTDHqkjEAopNntGXE+q5EMv2Ljt7bPO2bavPIFVBCAzWPNTPUJawTgf1UJOI6JHSe3RJYKONUV6GsSrSvgtcOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4F3+24SqD4Os9Ablxf+os+lU7pInNeJp93RKath79M=;
 b=W9uWhgPVmd4i1ObQO3PUpB8CE/x2X/RhkRK2jkvSWLO5MhEow/yhCXZVz20MWjz/1VtihWxVKmIl1YEx6wqMuZOXymvt44aILiGGaj/cao+02hF6aejRLYyVQvbZRcut6YbuB2YF/uIz4Gox/oOpp3ONX2VOi9ntgvUU1auwfXf46mu/rXZtBwKh9lKTgCVaUAgjjlT98LfR0tTvo7HBpEe2lgTpmvrwEbbQl1OXLmXeWjzPAzV8CzvxS2YGt/G1olvd3xlsoNyZnLD8UcP1xxBCYqeOAgenZN1VQmTud+1HCpSSVRK3oksbihzCheLPBsD4FXwfEz9egFUhNL3ekQ==
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by DU0PR04MB9225.eurprd04.prod.outlook.com (2603:10a6:10:350::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 16:14:45 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:14:45 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	ulf.hansson@linaro.org,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v12 20/22] wifi: nxpwifi: add Kconfig and Makefile for kernel integration
Date: Sat,  6 Jun 2026 00:13:33 +0800
Message-Id: <20260605161335.2415583-21-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605161335.2415583-1-jeff.chen_1@nxp.com>
References: <20260605161335.2415583-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To AM6PR04MB5239.eurprd04.prod.outlook.com
 (2603:10a6:20b:7::12)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5239:EE_|DU0PR04MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cfb1772-c57e-4e48-1703-08dec31d8ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|19092799006|1800799024|38350700014|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	0Egh660lsgAesdgJpTKY1WFPVDBS2wlrtA9zKQUX/TXhsd0eplGbS50rrrdWmu1tfRwZEyM0MFJuyDbYKsfvyZkdvdXB6x94wm28VSRTG0fesFR+8Oq7ZXXWBDnO7SJjWFLcAABwUUtf3k0n7sffypvqwKNUAhI1E6AgcCLBI1rM/hFTMiQ0oIVM3u+FbSWTnfajjZcELJTG72/NVCD1qyULd8wuP0R7TH5A59UI5Uj3aOUCQJnekThNKgZYQsl0NNtkHGTi3E6OGhvQDVUq2qxTm8zla8reJ19fTwU2XteBr9z1Y1FpNmlH8rTj/T9w85226EkqVwelIJCzFiSpQ9L5FOIGVvjRxML7gqwCXWODjPoL8L9pWKfo5vjn6eaIVNhYRAqQ08gfDnFaSd6PIAW8k/p2w2sDkcMV/2AXxtd5E4q5WyymsKrB08Vg5cSxzT/tZZUhOij1CrPuKoVYbamdHvW1gm4GxNW2S01U7ZSC5Q5REALpw1U/uMvbgYcODZcTjZJ4d9D76Dt19hZKE7KOkrKGBQ++f4MPipthDqfZEJq+CqWkTUJRhLqIKiVEHcg5nEAohPy5g6km+HmrkX0q41ZsYdQazo4EOnzPlKMJf/LolOR1gEJ38nQ9WwqYoh3gIH7lvOoj1o0Io5i0l26vvrQumKz570dMTK7uHPrKTysTAj1kWtuQN5cMZK5npEuEAYaoLUtRD3fn8SW8Awdot7FZMV1RSMHheF6UDRL73/nWyIn/ObY3c5koMdHW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(19092799006)(1800799024)(38350700014)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ipd2WVr6OXQn/3d5OVB4GXCFfO1BtXPATF4Iir1cifmn4fNYHcBVpviqA0Sy?=
 =?us-ascii?Q?Kpj021iGD6mZ1b8LSoefykdlJDc9HG/sRA7498WcCoj9/tIhrLKic5KhQh4t?=
 =?us-ascii?Q?llhB/z4ykJX3KiRshG9N0Eq4jvwOhDaX1imRogY3/b0oilDKBQvNMwU/C4HD?=
 =?us-ascii?Q?9I3HRyhc4MoNWRuupIxUeR5Q21p68hr0JacE4YMyecBjLKS4qG3sETUmMGSa?=
 =?us-ascii?Q?86oq+Nw3L1qIdhJE1ZXJ9HulDOA0+v7YilY38hV9SLYWsdNCdEYjoMxfydSP?=
 =?us-ascii?Q?m3N0gaSOtu+sds5QAtMsb3IhHteZPwrql1fjKt37N0mIe/fOc7c/9cKnYuJ2?=
 =?us-ascii?Q?sALYGwsMvS4C034Zobb83lpWSSqrJXQDNFSlzUvSQMSwAs3Tk20kbPRS0375?=
 =?us-ascii?Q?hpYE3yPFnXMM6mby6dvPPHawcJ0RynE+TS6xCLNQBRgUwOxUtw1XVEjbYqGJ?=
 =?us-ascii?Q?3N4vhSHn500c42YJNi2QDmiRxPF2eOBioYcLDPAkAUtoW3sSMpYItiK3rFAa?=
 =?us-ascii?Q?w+39HuRzT7NwMuAI9qPHLygkJAN4yZ9LiBVOlRsKZCJrHyfoV0V4orluvSBc?=
 =?us-ascii?Q?O89RqAhTfjFvduIMZB6zlmz2fVreBNm4BacmkYTVrV3BF9G3u900GXUCCel4?=
 =?us-ascii?Q?Zh80BmbzC1gCh6/N/gOuatx74aZYEEYF+j9Lrzw8cv7NV2c3eIAlUGaLna8f?=
 =?us-ascii?Q?QgUQuos/OaNeRQa5xqqChr1utwKnHYLR0UI54r2db5SFaH55mTEi5OXQqGEb?=
 =?us-ascii?Q?QmaF/ONNRq5LTsFoaVhKsSaR+s6vdw6C5lhciJ9YsknJqXtzC4L9Nz4dSpv/?=
 =?us-ascii?Q?GeiUiXTN1uNzX2bTnHvGCo/BniPWWcZpxCaSbc8hAk1hYlnC5Tx3G/EYTWK0?=
 =?us-ascii?Q?V0TqtOZtpiYM2i/qFUwLvN+AoP0Y1BWZJM68NSbBeJEtMbjthI3CW7tuWllc?=
 =?us-ascii?Q?8nCSoWeDRyF/V6ADfsbMGjz8GDLI/39mzgY/fIQy/4e/igJ1PEE+TZEoCri/?=
 =?us-ascii?Q?cJ41tS2WX5d4eJRiUhPkRjzYPzY6HdqM9Jg0QFRWcXYvrghwfLb9GrnQ6Yar?=
 =?us-ascii?Q?4swFm0wC+8fERWkUmNDG0Ir2mo3j1W3bMNKn1Nhbhl801Zi+t7GyDyAC4s4K?=
 =?us-ascii?Q?rZ+wEHnnoLwolI2vXgeI1EaX/rqu6AJ7kzU/g6vAuXPN0vsqokRqYGNLdi2U?=
 =?us-ascii?Q?KV78sGnVQGfbpFL6Dc4JM+ARKtITEocDOUwBh6kJnBQSa7EcReMTDOk8JFr9?=
 =?us-ascii?Q?eaQgHbug0Va3DF7S8NrvFGJcTPdxKg6H28QasNdcKL5H2xYfrxpW4XKg6d/A?=
 =?us-ascii?Q?lzV0nOKvT0Bj9LRiq7FYHlwVxR0+MT3Y82ol2bwr9C7JZCMmgbcjaM0m18pi?=
 =?us-ascii?Q?zD0m5vgM0a6BQqgIbRV8EbofEkavXtIzE6v40WF3rFPyS9yovWmi4BHhrv8f?=
 =?us-ascii?Q?Dt278MrQHaikWTQnsFfmNKofZ5ter043mbQFfCkXXDXJkaZHvIVR2VDkURjB?=
 =?us-ascii?Q?+yd9ciZsuhpiFEHcr8R7DitMN0ZHnHTsy6MEj3OyZ6fXMtuDWt9Q414xBc8k?=
 =?us-ascii?Q?7pAhQFVsYy3+vqDnHAm4aqbVw+BTwQqo/7/zkMT/2c+AgACsR7V5Ceph9v/z?=
 =?us-ascii?Q?iMG6iekuUIctF1d3gAZKnlSUkmtlTBw5dcrylgEmx3ABNvsoFqocxrZUlSi2?=
 =?us-ascii?Q?K6IY0gZBPeJf7muGDX/MdPz1EnZg+Lsg8xI+3tQEd75mPU9Y79WtDzcpMNyS?=
 =?us-ascii?Q?93pPuux2zA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfb1772-c57e-4e48-1703-08dec31d8ee4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 16:14:45.3658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g48s+sHiV4C6OmGYRAAvJMDaK6SA8cqnnOfyW1lPLGYv7lsAj/rgnElnPxZx29CfT+6M6MpWrZ9AkYR21PLrdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9225
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37440-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:briannorris@chromium.org,m:johannes@sipsolutions.net,m:francesco@dolcini.it,m:wyatt.hsu@nxp.com,m:s.hauer@pengutronix.de,m:ulf.hansson@linaro.org,m:jeff.chen_1@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:dkim,nxp.com:from_mime,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D9ED649DB4

Add Kconfig and Makefile entries to integrate the nxpwifi driver into the
kernel build system. Enable selection of the driver under the
WLAN_VENDOR_NXP menu and support building the SDIO transport backend.

Add WLAN_VENDOR_NXP to drivers/net/wireless, define the NXPWIFI and
NXPWIFI_SDIO configuration options, and create Makefiles for the nxp/ and
nxpwifi/ directories. Register the nxpwifi core and nxpwifi_sdio transport
modules as build targets.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/Kconfig              |  1 +
 drivers/net/wireless/Makefile             |  1 +
 drivers/net/wireless/nxp/Kconfig          | 17 ++++++++++
 drivers/net/wireless/nxp/Makefile         |  3 ++
 drivers/net/wireless/nxp/nxpwifi/Kconfig  | 22 +++++++++++++
 drivers/net/wireless/nxp/nxpwifi/Makefile | 39 +++++++++++++++++++++++
 6 files changed, 83 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/Kconfig
 create mode 100644 drivers/net/wireless/nxp/Makefile
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Kconfig
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Makefile

diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index c6599594dc99..4d7b81182925 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -27,6 +27,7 @@ source "drivers/net/wireless/intersil/Kconfig"
 source "drivers/net/wireless/marvell/Kconfig"
 source "drivers/net/wireless/mediatek/Kconfig"
 source "drivers/net/wireless/microchip/Kconfig"
+source "drivers/net/wireless/nxp/Kconfig"
 source "drivers/net/wireless/purelifi/Kconfig"
 source "drivers/net/wireless/ralink/Kconfig"
 source "drivers/net/wireless/realtek/Kconfig"
diff --git a/drivers/net/wireless/Makefile b/drivers/net/wireless/Makefile
index e1c4141c6004..0c6b3cc719db 100644
--- a/drivers/net/wireless/Makefile
+++ b/drivers/net/wireless/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_WLAN_VENDOR_INTERSIL) += intersil/
 obj-$(CONFIG_WLAN_VENDOR_MARVELL) += marvell/
 obj-$(CONFIG_WLAN_VENDOR_MEDIATEK) += mediatek/
 obj-$(CONFIG_WLAN_VENDOR_MICROCHIP) += microchip/
+obj-$(CONFIG_WLAN_VENDOR_NXP) += nxp/
 obj-$(CONFIG_WLAN_VENDOR_PURELIFI) += purelifi/
 obj-$(CONFIG_WLAN_VENDOR_QUANTENNA) += quantenna/
 obj-$(CONFIG_WLAN_VENDOR_RALINK) += ralink/
diff --git a/drivers/net/wireless/nxp/Kconfig b/drivers/net/wireless/nxp/Kconfig
new file mode 100644
index 000000000000..68b32d4536e5
--- /dev/null
+++ b/drivers/net/wireless/nxp/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config WLAN_VENDOR_NXP
+	bool "NXP devices"
+	default y
+	help
+	  If you have a wireless card belonging to this class, say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all the
+	  questions about these cards. If you say Y, you will be asked for
+	  your specific card in the following questions.
+
+if WLAN_VENDOR_NXP
+
+source "drivers/net/wireless/nxp/nxpwifi/Kconfig"
+
+endif # WLAN_VENDOR_NXP
diff --git a/drivers/net/wireless/nxp/Makefile b/drivers/net/wireless/nxp/Makefile
new file mode 100644
index 000000000000..27b41a0afdd2
--- /dev/null
+++ b/drivers/net/wireless/nxp/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_NXPWIFI)	+= nxpwifi/
diff --git a/drivers/net/wireless/nxp/nxpwifi/Kconfig b/drivers/net/wireless/nxp/nxpwifi/Kconfig
new file mode 100644
index 000000000000..3637068574b8
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NXPWIFI
+	tristate "NXP WiFi Driver"
+	depends on CFG80211
+	help
+	  This adds support for wireless adapters based on NXP
+	  802.11n/ac chipsets.
+
+	  If you choose to build it as a module, it will be called
+	  nxpwifi.
+
+config NXPWIFI_SDIO
+	tristate "NXP WiFi Driver for IW61x"
+	depends on NXPWIFI && MMC
+	select FW_LOADER
+	select WANT_DEV_COREDUMP
+	help
+	  This adds support for wireless adapters based on NXP
+	  IW61x interface.
+
+	  If you choose to build it as a module, it will be called
+	  nxpwifi_sdio.
diff --git a/drivers/net/wireless/nxp/nxpwifi/Makefile b/drivers/net/wireless/nxp/nxpwifi/Makefile
new file mode 100644
index 000000000000..8f581429f28d
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/Makefile
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright 2011-2020 NXP
+#
+
+
+nxpwifi-y += main.o
+nxpwifi-y += init.o
+nxpwifi-y += cfp.o
+nxpwifi-y += cmdevt.o
+nxpwifi-y += util.o
+nxpwifi-y += txrx.o
+nxpwifi-y += wmm.o
+nxpwifi-y += 11n.o
+nxpwifi-y += 11ac.o
+nxpwifi-y += 11ax.o
+nxpwifi-y += 11n_aggr.o
+nxpwifi-y += 11n_rxreorder.o
+nxpwifi-y += scan.o
+nxpwifi-y += join.o
+nxpwifi-y += sta_cfg.o
+nxpwifi-y += sta_cmd.o
+nxpwifi-y += uap_cmd.o
+nxpwifi-y += ie.o
+nxpwifi-y += sta_event.o
+nxpwifi-y += uap_event.o
+nxpwifi-y += sta_tx.o
+nxpwifi-y += sta_rx.o
+nxpwifi-y += uap_txrx.o
+nxpwifi-y += cfg80211.o
+nxpwifi-y += ethtool.o
+nxpwifi-y += 11h.o
+nxpwifi-$(CONFIG_DEBUG_FS) += debugfs.o
+obj-$(CONFIG_NXPWIFI) += nxpwifi.o
+
+nxpwifi_sdio-y += sdio.o
+obj-$(CONFIG_NXPWIFI_SDIO) += nxpwifi_sdio.o
+
+ccflags-y += -D__CHECK_ENDIAN
-- 
2.34.1


