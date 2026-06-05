Return-Path: <linux-wireless+bounces-37426-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pUVdKcj3ImqMfwEAu9opvQ
	(envelope-from <linux-wireless+bounces-37426-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 18:22:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1FB649B7D
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 18:22:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=Kx0UzV+z;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37426-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37426-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3BC6300766E
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 16:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B03A4C042E;
	Fri,  5 Jun 2026 16:14:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012008.outbound.protection.outlook.com [52.101.66.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8364183D5;
	Fri,  5 Jun 2026 16:14:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676046; cv=fail; b=BcRrt1ClbMfQbHmuS6Vl8zdc6kyKkSkIBLGgicxZbtZueZK+dAlr30WTne6Ig/4IOjAORwzMKtuaVUMPNWFbBlstXdG480sM7hK5ghggLUxzLgjW3elp7vq5KbdVtSm29XXllhjL98ktKGJ2uGyfsQ0IjoNN6yO5te6IK2qqsMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676046; c=relaxed/simple;
	bh=cyK8MxFgYnLDusDgnuo3pAabXXyUDvHUytotQGt9qMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PXOD2WmvP4HNS2G4FhdfXwLklzG4hMhb517TvY2WEln3eVSgibFOL0tPkNdZ0OOE0YCABoJX/CfDb0UQtuNQaOQmkD1YBBXdk0llT1/TvyhrgSaw1b6rDHLE9mF1IXRGPKUdwz/Nomrfh749deo5D5CQuisWyPIuTE/d9LS9Dto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kx0UzV+z; arc=fail smtp.client-ip=52.101.66.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btrBiw7qShsHsVRv4DEHiCHZ8WBAA0A4CXSgS3ZKp9hBHyK//4w9+MKDDe6CpDO3usf4iAwADdHoI29KSDDMLzajPcsbT3lPChiYzDB+OQLvqJjTrkt9BgsIw5UE48xTMo/97MQf+hxRnX2B00SlLQQnL3xxlxJ/hIlxQ5dbC9ZRHexO/BsNDjppzFk3o+/Nwh9ei1N9/WBGMONKIhBWvKUIjwvIBCupyw7EftNEb89fEavTpDOEK+y9c+F85vb1eY0nLnzDcuBMTmVVaL3qh9W1jRhTGZlubEVieGDy70Ge+L7d4i6Y61s8jUAQZb2nqobgjbFPpN56brp0z+ipiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xSykxtrbVOgn2ZHd8SxfuQ2qO1fmYNkjz4ppkagObU=;
 b=TYbhp1Ge3Hdoz0DC5aJBQJ0eKMBFg01BQzFZu00yDXTTfff3ych7Ka9c3tRTKZmhGqEPlqgxO6YKVCZ6m8n7GMJLvICotdg7mV3bcTIZ6u8z6p4s44FTsRQUO4V4ngFxXVwyG/88YQ4o9idPQT+OgbVxgCXZo7dLk096hYKwihqKBHV0feJe/Fai54TsWZ09KwgGGkTklgcdO/2Qm4X2lSFS/HArZTwea9sCurQ7N5qPgykBe0zN2mjCIlzB2aTYYr8LP9xwPK3oNrM9UQqHgBKo6vs5DILy5eM13YPuBBmkl4qTcH5mPzsT0+BVoFgx9XZWjNgKiZJ35MllFx1NkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xSykxtrbVOgn2ZHd8SxfuQ2qO1fmYNkjz4ppkagObU=;
 b=Kx0UzV+zJ3mH0IUzNPYtLrzw5+nRzoypqgSosqVwge0MqkaUG7AEyMAyitGidc+G1ODpGmmmn8olq5yeA88h4e7DBeHRgY0pjK6USDBgOB9PQOHeM0dJ5sVXtb4Gr/RJYWsd/dG8iza0Cu5oOyo2y30LNshvrYxf2Uyy2P/u0XDgePcsm8BCXEz3XIBUD8EA30LgaCEp4HmQYJm2qfEh9D6of4xC3D6AiKgR8C7MU4Lyshf9Ku8B/gSqq3ZPMLNucn90GZUxSUqDkjlo0FEVL93eJJRFlfh559+k8YkQD3P77SAj0ydUPhbeaulNO1ZIbYi+ZJHBxhJBpT8drqMxEg==
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 16:13:58 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:13:58 +0000
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
Subject: [PATCH v12 05/22] wifi: nxpwifi: add WMM support
Date: Sat,  6 Jun 2026 00:13:18 +0800
Message-Id: <20260605161335.2415583-6-jeff.chen_1@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB5239:EE_|AS8PR04MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 39eea50b-a877-4edf-86b1-08dec31d7316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|19092799006|366016|11063799006|5023799004|56012099006|18002099003|22082099003|3023799007|38350700014;
X-Microsoft-Antispam-Message-Info:
	XFR2Jb/lbvfBpNYgVwfpWxfwXcrqfEZQiaVY1D5x59LSCqFdkrfqlqyXWQvO09+QJjB0yjWEEM9XtiOyvbHLMJwy/Savbc4eIDZgEEHNJcqrhuAfQDhq+LPVjzihOhbUeDg43Dre3u/0fHkwsYB6CSVPQeIMAx20pgCzbhi4tVMqI2BQOGOScAi0nN9FejpVog5rKscfewID8EE/eNTD/9lgN9T3+Ni4ZQLAdC4qSPUkiJI6dMY8AjJ0CHl9ZRwfF2Cg6/GUyhYQKr1hm/itqEqsZjb+l6yuwArAQuW6q25mGYLZ/MvWeR241nb/iT2bbjs688ZhmF4tRIYrQmsklRcqC/C441HSO3IkqrHZkjtpVkhGgO3+VKp0v91MEg9SSfp0XpnmdvN3ya3XDaN+BCW7YenuHl1ySjW6oKWVgOasCerbzKdf+nfWjhm87bTWNM/m/5UQFjsiVodxQQhouSmcC7KbbC8A/xc6vVB87SFMEv+f/KWvoPyhRDmgI7TfsoCYVJU7+3hFy7M4dX8U4/tX8QPkBHo9tyo+EfTUtA5gZ+JKbjW8Tw7Oxxo/gn4g0R0kfJrnlxGyP5IJXxbzGTY75tk7h/TdMqYl6VeEOvmVnc7sAhjUpiEHl0Te1oLzPyoZuXffAoqcMCsrJ7CMDLHk3CI8AZxSuF5LUl7sivPrFUzs6GyUOQPK/tj75SmhvUcxC7XkEkm3ZZgeyBM1DGk8y8BicNbiAMHa1xzkrH5/zE/h8agu76dCBYv0jui1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(19092799006)(366016)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003)(3023799007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jljehc9AiJAbbo09noiLVZDccKAghF1TsT1LfrgJHw20kvFuHyXIC3wQu1cc?=
 =?us-ascii?Q?Ksg+1iqhtiBZKr8bxAHdW5MUPjc3T/mMlZNVkl3QK6QDqVbyKI3kL09oN41T?=
 =?us-ascii?Q?kkqKLJjyAz7VnOmcJexjoAOEkmsCfnUqs7bjx6GZ/O34XA0dFoByUOGLvuzm?=
 =?us-ascii?Q?qQlBLKSysCm+J3nb0lkn1TZi+FCkFQw6gyckKGboXLqm1ZptagFSrwkTf2zy?=
 =?us-ascii?Q?EOCZ/n+jAjGewlFra4XBVoV7jMDBs+93z37ufm5CUpL2dk8C4Ahwlp48vlIH?=
 =?us-ascii?Q?Os3My4cUQhTb4bQtnxU4Y+vOtLCBHjyOxfBBPslqOtwE+suH9FrxQ7DD/ipD?=
 =?us-ascii?Q?3UuawE0a7velnb8rdr8k0IYWZ0rcQ73vgqMUL4lr6fXbHLYe5iG19roTNp06?=
 =?us-ascii?Q?y0jYR+XkQh46eNHNi21IDuNvl6lnmCcr4ObVseI49qFIXK4/6/a/7TBa/Nmx?=
 =?us-ascii?Q?xXyUDAJwKSSVXDuV7hUtdgnkqlM0LveZoTcFIujn/QTNTJ/xKfbZPmpZQZd5?=
 =?us-ascii?Q?240ldFEo1jNWGc9RLcY2uPGIHezsHgrUVCJRcr53yM5OKzKvhT5v3wyIOpmZ?=
 =?us-ascii?Q?vSvwXpxgRx193M7UwbneJtZaahDLGlWPexZqEauDnK1v3GtXh14q2aAri+C5?=
 =?us-ascii?Q?2cg2JionJ6Nxz8t7KLZuPiDOQ2qGN0j9AI3bk9xaUKelJBAEDQfu9dHpsMtR?=
 =?us-ascii?Q?WkqNdVccQYWDAYZKVwSnJwA1rxM7cjlzo+RD07I2/2L50U+488pG+qKMplXI?=
 =?us-ascii?Q?U9+GUyFwQZ6zYyZTJ5L7E1fUPUOUU6YqK7E5s87YdX5p/cY4WFTo+65AvpYZ?=
 =?us-ascii?Q?XU5UfAy2VEP0xY5ZTRYUbQPz0dJ9s25y4lzcaBEBfV9AAWEZNaN1g40X788v?=
 =?us-ascii?Q?ph0Aq78XNeSeSG3AVfWvBXiCXGvVtI15e0nsef5fBP++O7YKIwl87YZZp646?=
 =?us-ascii?Q?QL8tgbqZ73MA6IEfVPbFkn2mXSHc3qCkgZeWLOGtbB7sEslqFZcjQxMIflC/?=
 =?us-ascii?Q?YAzc6q5I7Hz1g7NJG8P9rV37G/dk6zFvvVvQUv8yvrf671wkHjJo26pVmYmi?=
 =?us-ascii?Q?nyfxXOvTWPu4JAP0lTjJ2odsgyQ2zeouLnPurt69lKdrVr0yismgrXAOmCsm?=
 =?us-ascii?Q?7eO0Rlj8JtQkNS9JfIou2oJqijAMuwGmXeQ4PI12BY69MAV1b5fly5P6VAR4?=
 =?us-ascii?Q?iSCP2yiTHHr162V/YMA1LsUSZGUA1fEchT7EkP/Vp6c+nwuF55CviaU2tFgS?=
 =?us-ascii?Q?n7guNCDztJIjIkg9xP2UARWViMwtc10dXddf6szd10Knwjv7KEdHBc86aQA/?=
 =?us-ascii?Q?WSOByWDvj30Y68dBYV0uP5RsKHBt8fOCz9FwpIBJtrRT/iIWaPW21TMcqrQ5?=
 =?us-ascii?Q?iEMVNY4yYb9BBXsfjVT7smVxJAYopH70nlQw+/VW+B9tB1pKT/pQ3rEqWW2t?=
 =?us-ascii?Q?cwCN6thRHHkQmadv80JyUDyGVOxjILORYfZd7eMAQE7S7C/ca9r3BdrJe3Xx?=
 =?us-ascii?Q?Zp0VGKAzmvaLOheugRHEObvqamI36oNfO8+ULOwwRLXeEqC5UULDZttMLKgC?=
 =?us-ascii?Q?xAh5dR+fe7Mr/yc2dkP0VdMwff4OdDkehEyLMs2HwLmkP43OebDeXIBcmHNU?=
 =?us-ascii?Q?cNg2UfdRG56aYt9w+p+Z/S3S+gILJfvmzljuFXJCDRF1w4ZfWJDT1hlduOUe?=
 =?us-ascii?Q?LBQxhpU7V2JiJwsg990cMi42CKRUICgaBalMNoogN/BKQetXtnxS/r3yUpf7?=
 =?us-ascii?Q?xvRSY3963w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39eea50b-a877-4edf-86b1-08dec31d7316
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 16:13:58.8080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9v4g2s0J3CM/u1Vy+KCWLnTmslZ4lFlGlYiHeJM0guSRnBQHwK2s7qZHBitjeo/oblymc+uT1ADi3uH03ZVOdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8436
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37426-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:briannorris@chromium.org,m:johannes@sipsolutions.net,m:francesco@dolcini.it,m:wyatt.hsu@nxp.com,m:s.hauer@pengutronix.de,m:ulf.hansson@linaro.org,m:jeff.chen_1@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:mid,nxp.com:dkim,nxp.com:from_mime,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF1FB649B7D

Add WMM support to enable QoS-based traffic prioritization and enhanced
queue handling for both station and AP roles.

Parse WMM parameter elements from the AP and configure access category
(AC) parameters accordingly. Implement TID-to-AC mapping, admission
control handling, and downgrade logic for non-admitted traffic.

Integrate AMSDU and AMPDU aggregation with per-TID RA list queues, and
add scheduling logic for packet queuing, reordering, and transmission
based on priority and aggregation eligibility.

Handle firmware interaction for WMM status reporting and association
request TLV construction.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/wmm.c | 1313 ++++++++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/wmm.h |   77 ++
 2 files changed, 1390 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/wmm.c b/drivers/net/wireless/nxp/nxpwifi/wmm.c
new file mode 100644
index 000000000000..a79e1138eeef
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/wmm.c
@@ -0,0 +1,1313 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: WMM
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "wmm.h"
+#include "11n.h"
+
+/* Maximum value FW can accept for driver delay in packet transmission */
+#define DRV_PKT_DELAY_TO_FW_MAX   512
+
+#define WMM_QUEUED_PACKET_LOWER_LIMIT   180
+
+#define WMM_QUEUED_PACKET_UPPER_LIMIT   200
+
+/* Offset for TOS field in the IP header */
+#define IPTOS_OFFSET 5
+
+static bool disable_tx_amsdu;
+
+/*
+ * This table inverses the tos_to_tid operation to get a priority
+ * which is in sequential order, and can be compared.
+ * Use this to compare the priority of two different TIDs.
+ */
+const u8 tos_to_tid_inv[] = {
+	0x02,  /* from tos_to_tid[2] = 0 */
+	0x00,  /* from tos_to_tid[0] = 1 */
+	0x01,  /* from tos_to_tid[1] = 2 */
+	0x03,
+	0x04,
+	0x05,
+	0x06,
+	0x07
+};
+
+/* WMM information element */
+static const u8 wmm_info_ie[] = { WLAN_EID_VENDOR_SPECIFIC, 0x07,
+	0x00, 0x50, 0xf2, 0x02,
+	0x00, 0x01, 0x00
+};
+
+static const u8 wmm_aci_to_qidx_map[] = { WMM_AC_BE,
+	WMM_AC_BK,
+	WMM_AC_VI,
+	WMM_AC_VO
+};
+
+static u8 tos_to_tid[] = {
+	/* TID DSCP_P2 DSCP_P1 DSCP_P0 WMM_AC */
+	0x01,			/* 0 1 0 AC_BK */
+	0x02,			/* 0 0 0 AC_BK */
+	0x00,			/* 0 0 1 AC_BE */
+	0x03,			/* 0 1 1 AC_BE */
+	0x04,			/* 1 0 0 AC_VI */
+	0x05,			/* 1 0 1 AC_VI */
+	0x06,			/* 1 1 0 AC_VO */
+	0x07			/* 1 1 1 AC_VO */
+};
+
+static u8 ac_to_tid[4][2] = { {1, 2}, {0, 3}, {4, 5}, {6, 7} };
+
+/* Debug prints the priority parameters for a WMM AC. */
+static void
+nxpwifi_wmm_ac_debug_print(const struct ieee80211_wmm_ac_param *ac_param)
+{
+	static const char * const ac_str[] = { "BK", "BE", "VI", "VO" };
+
+	pr_debug("info: WMM AC_%s: ACI=%d, ACM=%d, Aifsn=%d, ",
+		 ac_str[wmm_aci_to_qidx_map[(ac_param->aci_aifsn
+					     & NXPWIFI_ACI) >> 5]],
+		 (ac_param->aci_aifsn & NXPWIFI_ACI) >> 5,
+		 (ac_param->aci_aifsn & NXPWIFI_ACM) >> 4,
+		 ac_param->aci_aifsn & NXPWIFI_AIFSN);
+	pr_debug("EcwMin=%d, EcwMax=%d, TxopLimit=%d\n",
+		 ac_param->cw & NXPWIFI_ECW_MIN,
+		 (ac_param->cw & NXPWIFI_ECW_MAX) >> 4,
+		 le16_to_cpu(ac_param->txop_limit));
+}
+
+/* Allocates a route address list. */
+static struct nxpwifi_ra_list_tbl *
+nxpwifi_wmm_allocate_ralist_node(struct nxpwifi_adapter *adapter, const u8 *ra)
+{
+	struct nxpwifi_ra_list_tbl *ra_list;
+
+	ra_list = kzalloc_obj(*ra_list, GFP_ATOMIC);
+	if (!ra_list)
+		return NULL;
+
+	INIT_LIST_HEAD(&ra_list->list);
+	skb_queue_head_init(&ra_list->skb_head);
+
+	memcpy(ra_list->ra, ra, ETH_ALEN);
+
+	ra_list->total_pkt_count = 0;
+
+	nxpwifi_dbg(adapter, INFO, "info: allocated ra_list %p\n", ra_list);
+
+	return ra_list;
+}
+
+/*
+ * Returns random no between 16 and 32 to be used as threshold for no of
+ * packets after which BA setup is initiated.
+ */
+static u8 nxpwifi_get_random_ba_threshold(void)
+{
+	u64 ns;
+	/*
+	 * setup ba_packet_threshold here random number between
+	 * [BA_SETUP_PACKET_OFFSET,
+	 * BA_SETUP_PACKET_OFFSET+BA_SETUP_MAX_PACKET_THRESHOLD-1]
+	 */
+	ns = ktime_get_ns();
+	ns += (ns >> 32) + (ns >> 16);
+
+	return ((u8)ns % BA_SETUP_MAX_PACKET_THRESHOLD) + BA_SETUP_PACKET_OFFSET;
+}
+
+/* Allocates and adds a RA list for all TIDs with the given RA. */
+void nxpwifi_ralist_add(struct nxpwifi_private *priv, const u8 *ra)
+{
+	int i;
+	struct nxpwifi_ra_list_tbl *ra_list;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_sta_node *node;
+
+	for (i = 0; i < MAX_NUM_TID; ++i) {
+		ra_list = nxpwifi_wmm_allocate_ralist_node(adapter, ra);
+		nxpwifi_dbg(adapter, INFO,
+			    "info: created ra_list %p\n", ra_list);
+
+		if (!ra_list)
+			break;
+
+		ra_list->is_11n_enabled = 0;
+		ra_list->ba_status = BA_SETUP_NONE;
+		ra_list->amsdu_in_ampdu = false;
+		if (!nxpwifi_queuing_ra_based(priv)) {
+			ra_list->is_11n_enabled = IS_11N_ENABLED(priv);
+		} else {
+			rcu_read_lock();
+			node = nxpwifi_get_sta_entry(priv, ra);
+			if (node)
+				ra_list->tx_paused = node->tx_pause;
+			ra_list->is_11n_enabled =
+				      nxpwifi_is_sta_11n_enabled(priv, node);
+			if (ra_list->is_11n_enabled)
+				ra_list->max_amsdu = node->max_amsdu;
+			rcu_read_unlock();
+		}
+
+		nxpwifi_dbg(adapter, DATA, "data: ralist %p: is_11n_enabled=%d\n",
+			    ra_list, ra_list->is_11n_enabled);
+
+		if (ra_list->is_11n_enabled) {
+			ra_list->ba_pkt_count = 0;
+			ra_list->ba_packet_thr =
+					      nxpwifi_get_random_ba_threshold();
+		}
+		list_add_tail(&ra_list->list,
+			      &priv->wmm.tid_tbl_ptr[i].ra_list);
+	}
+}
+
+/* Sets the WMM queue priorities to their default values. */
+static void nxpwifi_wmm_default_queue_priorities(struct nxpwifi_private *priv)
+{
+	/* Default queue priorities: VO->VI->BE->BK */
+	priv->wmm.queue_priority[0] = WMM_AC_VO;
+	priv->wmm.queue_priority[1] = WMM_AC_VI;
+	priv->wmm.queue_priority[2] = WMM_AC_BE;
+	priv->wmm.queue_priority[3] = WMM_AC_BK;
+}
+
+/* Map ACs to TIDs. */
+static void
+nxpwifi_wmm_queue_priorities_tid(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_wmm_desc *wmm = &priv->wmm;
+	u8 *queue_priority = wmm->queue_priority;
+	int i;
+
+	for (i = 0; i < 4; ++i) {
+		tos_to_tid[7 - (i * 2)] = ac_to_tid[queue_priority[i]][1];
+		tos_to_tid[6 - (i * 2)] = ac_to_tid[queue_priority[i]][0];
+	}
+
+	for (i = 0; i < MAX_NUM_TID; ++i)
+		priv->tos_to_tid_inv[tos_to_tid[i]] = (u8)i;
+
+	atomic_set(&wmm->highest_queued_prio, HIGH_PRIO_TID);
+}
+
+/* Initializes WMM priority queues. */
+void
+nxpwifi_wmm_setup_queue_priorities(struct nxpwifi_private *priv,
+				   struct ieee80211_wmm_param_ie *wmm_ie)
+{
+	u16 cw_min, avg_back_off, tmp[4];
+	u32 i, j, num_ac;
+	u8 ac_idx;
+
+	if (!wmm_ie || !priv->wmm_enabled) {
+		/* WMM is not enabled, just set the defaults and return */
+		nxpwifi_wmm_default_queue_priorities(priv);
+		return;
+	}
+
+	nxpwifi_dbg(priv->adapter, INFO,
+		    "info: WMM Parameter element: version=%d,\t"
+		    "qos_info Parameter Set Count=%d, Reserved=%#x\n",
+		    wmm_ie->version, wmm_ie->qos_info &
+		    IEEE80211_WMM_IE_AP_QOSINFO_PARAM_SET_CNT_MASK,
+		    wmm_ie->reserved);
+
+	for (num_ac = 0; num_ac < ARRAY_SIZE(wmm_ie->ac); num_ac++) {
+		u8 ecw = wmm_ie->ac[num_ac].cw;
+		u8 aci_aifsn = wmm_ie->ac[num_ac].aci_aifsn;
+
+		cw_min = (1 << (ecw & NXPWIFI_ECW_MIN)) - 1;
+		avg_back_off = (cw_min >> 1) + (aci_aifsn & NXPWIFI_AIFSN);
+
+		ac_idx = wmm_aci_to_qidx_map[(aci_aifsn & NXPWIFI_ACI) >> 5];
+		priv->wmm.queue_priority[ac_idx] = ac_idx;
+		tmp[ac_idx] = avg_back_off;
+
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "info: WMM: CWmax=%d CWmin=%d Avg Back-off=%d\n",
+			    (1 << ((ecw & NXPWIFI_ECW_MAX) >> 4)) - 1,
+			    cw_min, avg_back_off);
+		nxpwifi_wmm_ac_debug_print(&wmm_ie->ac[num_ac]);
+	}
+
+	/* Bubble sort */
+	for (i = 0; i < num_ac; i++) {
+		for (j = 1; j < num_ac - i; j++) {
+			if (tmp[j - 1] > tmp[j]) {
+				swap(tmp[j - 1], tmp[j]);
+				swap(priv->wmm.queue_priority[j - 1],
+				     priv->wmm.queue_priority[j]);
+			} else if (tmp[j - 1] == tmp[j]) {
+				if (priv->wmm.queue_priority[j - 1]
+				    < priv->wmm.queue_priority[j])
+					swap(priv->wmm.queue_priority[j - 1],
+					     priv->wmm.queue_priority[j]);
+			}
+		}
+	}
+
+	nxpwifi_wmm_queue_priorities_tid(priv);
+}
+
+/* Evaluates whether or not an AC is to be downgraded. */
+static enum nxpwifi_wmm_ac_e
+nxpwifi_wmm_eval_downgrade_ac(struct nxpwifi_private *priv,
+			      enum nxpwifi_wmm_ac_e eval_ac)
+{
+	int down_ac;
+	enum nxpwifi_wmm_ac_e ret_ac;
+	struct nxpwifi_wmm_ac_status *ac_status;
+
+	ac_status = &priv->wmm.ac_status[eval_ac];
+
+	if (!ac_status->disabled)
+		/* Okay to use this AC, its enabled */
+		return eval_ac;
+
+	/* Setup a default return value of the lowest priority */
+	ret_ac = WMM_AC_BK;
+
+	/*
+	 * Find the highest AC that is enabled and does not require
+	 *  admission control. The spec disallows downgrading to an AC,
+	 *  which is enabled due to a completed admission control.
+	 *  Unadmitted traffic is not to be sent on an AC with admitted
+	 *  traffic.
+	 */
+	for (down_ac = WMM_AC_BK; down_ac < eval_ac; down_ac++) {
+		ac_status = &priv->wmm.ac_status[down_ac];
+
+		if (!ac_status->disabled && !ac_status->flow_required)
+			/*
+			 * AC is enabled and does not require admission
+			 * control
+			 */
+			ret_ac = (enum nxpwifi_wmm_ac_e)down_ac;
+	}
+
+	return ret_ac;
+}
+
+/* Downgrades WMM priority queue. */
+void
+nxpwifi_wmm_setup_ac_downgrade(struct nxpwifi_private *priv)
+{
+	int ac_val;
+
+	nxpwifi_dbg(priv->adapter, INFO, "info: WMM: AC Priorities:\t"
+		    "BK(0), BE(1), VI(2), VO(3)\n");
+
+	if (!priv->wmm_enabled) {
+		/* WMM is not enabled, default priorities */
+		for (ac_val = WMM_AC_BK; ac_val <= WMM_AC_VO; ac_val++)
+			priv->wmm.ac_down_graded_vals[ac_val] =
+				(enum nxpwifi_wmm_ac_e)ac_val;
+	} else {
+		for (ac_val = WMM_AC_BK; ac_val <= WMM_AC_VO; ac_val++) {
+			priv->wmm.ac_down_graded_vals[ac_val] =
+				nxpwifi_wmm_eval_downgrade_ac
+				(priv, (enum nxpwifi_wmm_ac_e)ac_val);
+			nxpwifi_dbg(priv->adapter, INFO,
+				    "info: WMM: AC PRIO %d maps to %d\n",
+				    ac_val,
+				    priv->wmm.ac_down_graded_vals[ac_val]);
+		}
+	}
+}
+
+/* Converts the IP TOS field to an WMM AC Queue assignment. */
+static enum nxpwifi_wmm_ac_e
+nxpwifi_wmm_convert_tos_to_ac(struct nxpwifi_adapter *adapter, u32 tos)
+{
+	/* Map of TOS UP values to WMM AC */
+	static const enum nxpwifi_wmm_ac_e tos_to_ac[] = {
+		WMM_AC_BE,
+		WMM_AC_BK,
+		WMM_AC_BK,
+		WMM_AC_BE,
+		WMM_AC_VI,
+		WMM_AC_VI,
+		WMM_AC_VO,
+		WMM_AC_VO
+	};
+
+	if (tos >= ARRAY_SIZE(tos_to_ac))
+		return WMM_AC_BE;
+
+	return tos_to_ac[tos];
+}
+
+/*
+ * Evaluates a given TID and downgrades it to a lower TID if the WMM Parameter
+ * element received from the AP indicates that the AP is disabled (due to call
+ * admission control (ACM bit).
+ */
+u8 nxpwifi_wmm_downgrade_tid(struct nxpwifi_private *priv, u32 tid)
+{
+	enum nxpwifi_wmm_ac_e ac, ac_down;
+	u8 new_tid;
+
+	ac = nxpwifi_wmm_convert_tos_to_ac(priv->adapter, tid);
+	ac_down = priv->wmm.ac_down_graded_vals[ac];
+
+	/*
+	 * Send the index to tid array, picking from the array will be
+	 * taken care by dequeuing function
+	 */
+	new_tid = ac_to_tid[ac_down][tid % 2];
+
+	return new_tid;
+}
+
+/* Initializes the WMM state information and the WMM data path queues. */
+void
+nxpwifi_wmm_init(struct nxpwifi_adapter *adapter)
+{
+	int i, j;
+	struct nxpwifi_private *priv;
+
+	for (j = 0; j < adapter->priv_num; ++j) {
+		priv = adapter->priv[j];
+
+		for (i = 0; i < MAX_NUM_TID; ++i) {
+			if (!disable_tx_amsdu &&
+			    adapter->tx_buf_size > NXPWIFI_TX_DATA_BUF_SIZE_2K)
+				priv->aggr_prio_tbl[i].amsdu =
+					priv->tos_to_tid_inv[i];
+			else
+				priv->aggr_prio_tbl[i].amsdu =
+					BA_STREAM_NOT_ALLOWED;
+			priv->aggr_prio_tbl[i].ampdu_ap =
+				priv->tos_to_tid_inv[i];
+			priv->aggr_prio_tbl[i].ampdu_user =
+				priv->tos_to_tid_inv[i];
+		}
+
+		priv->aggr_prio_tbl[6].amsdu =
+			priv->aggr_prio_tbl[6].ampdu_ap =
+			priv->aggr_prio_tbl[6].ampdu_user =
+			BA_STREAM_NOT_ALLOWED;
+
+		priv->aggr_prio_tbl[7].amsdu =
+			priv->aggr_prio_tbl[7].ampdu_ap =
+			priv->aggr_prio_tbl[7].ampdu_user =
+			BA_STREAM_NOT_ALLOWED;
+
+		nxpwifi_set_ba_params(priv);
+		nxpwifi_reset_11n_rx_seq_num(priv);
+
+		priv->wmm.drv_pkt_delay_max = NXPWIFI_WMM_DRV_DELAY_MAX;
+		atomic_set(&priv->wmm.tx_pkts_queued, 0);
+		atomic_set(&priv->wmm.highest_queued_prio, HIGH_PRIO_TID);
+	}
+}
+
+bool nxpwifi_bypass_txlist_empty(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	int i;
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+		if (!skb_queue_empty(&priv->bypass_txq))
+			return false;
+	}
+
+	return true;
+}
+
+/* Checks if WMM Tx queue is empty. */
+bool nxpwifi_wmm_lists_empty(struct nxpwifi_adapter *adapter)
+{
+	int i;
+	struct nxpwifi_private *priv;
+
+	for (i = 0; i < adapter->priv_num; ++i) {
+		priv = adapter->priv[i];
+		if (!priv->port_open)
+			continue;
+		if (atomic_read(&priv->wmm.tx_pkts_queued))
+			return false;
+	}
+
+	return true;
+}
+
+/* Deletes all packets in an RA list node. */
+static void
+nxpwifi_wmm_del_pkts_in_ralist_node(struct nxpwifi_private *priv,
+				    struct nxpwifi_ra_list_tbl *ra_list)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct sk_buff *skb, *tmp;
+
+	skb_queue_walk_safe(&ra_list->skb_head, skb, tmp) {
+		skb_unlink(skb, &ra_list->skb_head);
+		nxpwifi_write_data_complete(adapter, skb, 0, -1);
+	}
+}
+
+/* Deletes all packets in an RA list. */
+static void
+nxpwifi_wmm_del_pkts_in_ralist(struct nxpwifi_private *priv,
+			       struct list_head *ra_list_head)
+{
+	struct nxpwifi_ra_list_tbl *ra_list;
+
+	list_for_each_entry(ra_list, ra_list_head, list)
+		nxpwifi_wmm_del_pkts_in_ralist_node(priv, ra_list);
+}
+
+/* Deletes all packets in all RA lists. */
+static void nxpwifi_wmm_cleanup_queues(struct nxpwifi_private *priv)
+{
+	int i;
+
+	for (i = 0; i < MAX_NUM_TID; i++)
+		nxpwifi_wmm_del_pkts_in_ralist
+		(priv, &priv->wmm.tid_tbl_ptr[i].ra_list);
+
+	atomic_set(&priv->wmm.tx_pkts_queued, 0);
+	atomic_set(&priv->wmm.highest_queued_prio, HIGH_PRIO_TID);
+}
+
+/* Deletes all route addresses from all RA lists. */
+static void nxpwifi_wmm_delete_all_ralist(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_ra_list_tbl *ra_list, *tmp_node;
+	int i;
+
+	for (i = 0; i < MAX_NUM_TID; ++i) {
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "info: ra_list: freeing buf for tid %d\n", i);
+		list_for_each_entry_safe(ra_list, tmp_node,
+					 &priv->wmm.tid_tbl_ptr[i].ra_list,
+					 list) {
+			list_del(&ra_list->list);
+			kfree(ra_list);
+		}
+
+		INIT_LIST_HEAD(&priv->wmm.tid_tbl_ptr[i].ra_list);
+	}
+}
+
+static int nxpwifi_free_ack_frame(int id, void *p, void *data)
+{
+	pr_warn("Have pending ack frames!\n");
+	kfree_skb(p);
+	return 0;
+}
+
+/* Cleans up the Tx and Rx queues. */
+void
+nxpwifi_clean_txrx(struct nxpwifi_private *priv)
+{
+	struct sk_buff *skb, *tmp;
+	unsigned long index;
+	void *entry;
+
+	nxpwifi_11n_cleanup_reorder_tbl(priv);
+	spin_lock_bh(&priv->wmm.ra_list_spinlock);
+
+	nxpwifi_wmm_cleanup_queues(priv);
+	nxpwifi_11n_delete_all_tx_ba_stream_tbl(priv);
+
+	if (priv->adapter->if_ops.cleanup_mpa_buf)
+		priv->adapter->if_ops.cleanup_mpa_buf(priv->adapter);
+
+	nxpwifi_wmm_delete_all_ralist(priv);
+	memcpy(tos_to_tid, ac_to_tid, sizeof(tos_to_tid));
+
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+
+	skb_queue_walk_safe(&priv->bypass_txq, skb, tmp) {
+		skb_unlink(skb, &priv->bypass_txq);
+		nxpwifi_write_data_complete(priv->adapter, skb, 0, -1);
+	}
+	atomic_set(&priv->adapter->bypass_tx_pending, 0);
+
+	xa_for_each(&priv->ack_status_frames, index, entry) {
+		nxpwifi_free_ack_frame(index, entry, NULL);
+		xa_erase(&priv->ack_status_frames, index);
+	}
+
+	xa_destroy(&priv->ack_status_frames);
+}
+
+/* Retrieves a particular RA list node, matching with the given TID and RA address. */
+struct nxpwifi_ra_list_tbl *
+nxpwifi_wmm_get_ralist_node(struct nxpwifi_private *priv, u8 tid,
+			    const u8 *ra_addr)
+{
+	struct nxpwifi_ra_list_tbl *ra_list;
+
+	list_for_each_entry(ra_list, &priv->wmm.tid_tbl_ptr[tid].ra_list,
+			    list) {
+		if (!memcmp(ra_list->ra, ra_addr, ETH_ALEN))
+			return ra_list;
+	}
+
+	return NULL;
+}
+
+void nxpwifi_update_ralist_tx_pause(struct nxpwifi_private *priv, u8 *mac,
+				    u8 tx_pause)
+{
+	struct nxpwifi_ra_list_tbl *ra_list;
+	u32 pkt_cnt = 0, tx_pkts_queued;
+	int i;
+
+	spin_lock_bh(&priv->wmm.ra_list_spinlock);
+
+	for (i = 0; i < MAX_NUM_TID; ++i) {
+		ra_list = nxpwifi_wmm_get_ralist_node(priv, i, mac);
+		if (ra_list && ra_list->tx_paused != tx_pause) {
+			pkt_cnt += ra_list->total_pkt_count;
+			ra_list->tx_paused = tx_pause;
+			if (tx_pause)
+				priv->wmm.pkts_paused[i] +=
+					ra_list->total_pkt_count;
+			else
+				priv->wmm.pkts_paused[i] -=
+					ra_list->total_pkt_count;
+		}
+	}
+
+	if (pkt_cnt) {
+		tx_pkts_queued = atomic_read(&priv->wmm.tx_pkts_queued);
+		if (tx_pause)
+			tx_pkts_queued -= pkt_cnt;
+		else
+			tx_pkts_queued += pkt_cnt;
+
+		atomic_set(&priv->wmm.tx_pkts_queued, tx_pkts_queued);
+		atomic_set(&priv->wmm.highest_queued_prio, HIGH_PRIO_TID);
+	}
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+}
+
+/* Retrieves an RA list node for a given TID and RA address pair. */
+struct nxpwifi_ra_list_tbl *
+nxpwifi_wmm_get_queue_raptr(struct nxpwifi_private *priv, u8 tid,
+			    const u8 *ra_addr)
+{
+	struct nxpwifi_ra_list_tbl *ra_list;
+
+	ra_list = nxpwifi_wmm_get_ralist_node(priv, tid, ra_addr);
+	if (ra_list)
+		return ra_list;
+	nxpwifi_ralist_add(priv, ra_addr);
+
+	return nxpwifi_wmm_get_ralist_node(priv, tid, ra_addr);
+}
+
+/* Deletes RA list nodes for given mac for all TIDs. */
+void
+nxpwifi_wmm_del_peer_ra_list(struct nxpwifi_private *priv, const u8 *ra_addr)
+{
+	struct nxpwifi_ra_list_tbl *ra_list;
+	int i;
+
+	spin_lock_bh(&priv->wmm.ra_list_spinlock);
+
+	for (i = 0; i < MAX_NUM_TID; ++i) {
+		ra_list = nxpwifi_wmm_get_ralist_node(priv, i, ra_addr);
+
+		if (!ra_list)
+			continue;
+		nxpwifi_wmm_del_pkts_in_ralist_node(priv, ra_list);
+		if (ra_list->tx_paused)
+			priv->wmm.pkts_paused[i] -= ra_list->total_pkt_count;
+		else
+			atomic_sub(ra_list->total_pkt_count,
+				   &priv->wmm.tx_pkts_queued);
+		list_del(&ra_list->list);
+		kfree(ra_list);
+	}
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+}
+
+/* Checks if a particular RA list node exists in a given TID table index. */
+bool nxpwifi_is_ralist_valid(struct nxpwifi_private *priv,
+			     struct nxpwifi_ra_list_tbl *ra_list, int ptr_index)
+{
+	struct nxpwifi_ra_list_tbl *rlist;
+
+	list_for_each_entry(rlist, &priv->wmm.tid_tbl_ptr[ptr_index].ra_list,
+			    list) {
+		if (rlist == ra_list)
+			return true;
+	}
+
+	return false;
+}
+
+/* Adds a packet to bypass TX queue. */
+void
+nxpwifi_wmm_add_buf_bypass_txqueue(struct nxpwifi_private *priv,
+				   struct sk_buff *skb)
+{
+	skb_queue_tail(&priv->bypass_txq, skb);
+}
+
+/* Adds a packet to WMM queue. */
+void
+nxpwifi_wmm_add_buf_txqueue(struct nxpwifi_private *priv,
+			    struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u32 tid;
+	struct nxpwifi_ra_list_tbl *ra_list = NULL;
+	struct list_head list_head;
+	u8 ra[ETH_ALEN], tid_down;
+	struct ethhdr *eth_hdr = (struct ethhdr *)skb->data;
+
+	memcpy(ra, eth_hdr->h_dest, ETH_ALEN);
+
+	if (!priv->media_connected && !nxpwifi_is_skb_mgmt_frame(skb)) {
+		nxpwifi_dbg(adapter, DATA, "data: drop packet in disconnect\n");
+		nxpwifi_write_data_complete(adapter, skb, 0, -1);
+		return;
+	}
+
+	tid = skb->priority;
+
+	spin_lock_bh(&priv->wmm.ra_list_spinlock);
+
+	tid_down = nxpwifi_wmm_downgrade_tid(priv, tid);
+
+	/*
+	 * In case of infra as we have already created the list during
+	 * association we just don't have to call get_queue_raptr, we will
+	 * have only 1 raptr for a tid in case of infra
+	 */
+	if (!nxpwifi_queuing_ra_based(priv) &&
+	    !nxpwifi_is_skb_mgmt_frame(skb)) {
+		list_head = priv->wmm.tid_tbl_ptr[tid_down].ra_list;
+		ra_list = list_first_entry_or_null(&list_head,
+						   struct nxpwifi_ra_list_tbl,
+						   list);
+	} else {
+		memcpy(ra, skb->data, ETH_ALEN);
+		if (is_multicast_ether_addr(ra) ||
+		    nxpwifi_is_skb_mgmt_frame(skb))
+			eth_broadcast_addr(ra);
+		ra_list = nxpwifi_wmm_get_queue_raptr(priv, tid_down, ra);
+	}
+
+	if (!ra_list) {
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+		nxpwifi_write_data_complete(adapter, skb, 0, -1);
+		return;
+	}
+
+	skb_queue_tail(&ra_list->skb_head, skb);
+
+	ra_list->ba_pkt_count++;
+	ra_list->total_pkt_count++;
+
+	if (atomic_read(&priv->wmm.highest_queued_prio) <
+	    priv->tos_to_tid_inv[tid_down])
+		atomic_set(&priv->wmm.highest_queued_prio,
+			   priv->tos_to_tid_inv[tid_down]);
+
+	if (ra_list->tx_paused)
+		priv->wmm.pkts_paused[tid_down]++;
+	else
+		atomic_inc(&priv->wmm.tx_pkts_queued);
+
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+}
+
+/* Processes the get WMM status command response from firmware. */
+int nxpwifi_ret_wmm_get_status(struct nxpwifi_private *priv,
+			       const struct host_cmd_ds_command *resp)
+{
+	u8 *curr;
+	u16 resp_len = le16_to_cpu(resp->size), tlv_len;
+	bool valid = true;
+
+	struct nxpwifi_ie_types_data *tlv_hdr;
+	struct nxpwifi_ie_types_wmm_queue_status *wmm_qs;
+	struct ieee80211_wmm_param_ie *wmm_param_ie = NULL;
+	struct nxpwifi_wmm_ac_status *ac_status;
+	u32 base;
+
+	nxpwifi_dbg(priv->adapter, INFO,
+		    "info: WMM: WMM_GET_STATUS cmdresp received: %d\n",
+		    resp_len);
+
+	base = offsetofend(struct host_cmd_ds_command, params.get_wmm_status);
+
+	if (resp_len < base)
+		return -EINVAL;
+
+	curr = (u8 *)&resp->params.get_wmm_status;
+	resp_len -= base;
+
+	while (resp_len >= sizeof(tlv_hdr->header) && valid) {
+		tlv_hdr = (struct nxpwifi_ie_types_data *)curr;
+		tlv_len = le16_to_cpu(tlv_hdr->header.len);
+
+		if (resp_len < tlv_len + sizeof(tlv_hdr->header))
+			break;
+
+		switch (le16_to_cpu(tlv_hdr->header.type)) {
+		case TLV_TYPE_WMMQSTATUS:
+			if (tlv_len <
+			    sizeof(struct nxpwifi_ie_types_wmm_queue_status) -
+				sizeof(tlv_hdr->header))
+				break;
+
+			wmm_qs =
+			    (struct nxpwifi_ie_types_wmm_queue_status *)tlv_hdr;
+
+			if (wmm_qs->queue_index >= IEEE80211_NUM_ACS)
+				break;
+
+			ac_status = &priv->wmm.ac_status[wmm_qs->queue_index];
+			ac_status->disabled = wmm_qs->disabled;
+			ac_status->flow_required = wmm_qs->flow_required;
+			ac_status->flow_created = wmm_qs->flow_created;
+			break;
+
+		case WLAN_EID_VENDOR_SPECIFIC:
+			/* Need at least OUI(4) + WMM fixed fields */
+			if (tlv_len + sizeof(tlv_hdr->header) <
+			    offsetofend(struct ieee80211_wmm_param_ie,
+					qos_info))
+				break;
+
+			wmm_param_ie =
+			    (struct ieee80211_wmm_param_ie *)(curr + 2);
+
+			if (tlv_len + 2 > sizeof(struct ieee80211_wmm_param_ie))
+				break;
+
+			wmm_param_ie->len = (u8)tlv_len;
+			wmm_param_ie->element_id = WLAN_EID_VENDOR_SPECIFIC;
+
+			memcpy(&priv->curr_bss_params.bss_descriptor.wmm_ie,
+			       wmm_param_ie, wmm_param_ie->len + 2);
+			break;
+
+		default:
+			valid = false;
+			break;
+		}
+
+		curr += sizeof(tlv_hdr->header) + tlv_len;
+		resp_len -= sizeof(tlv_hdr->header) + tlv_len;
+	}
+
+	nxpwifi_wmm_setup_queue_priorities(priv, wmm_param_ie);
+	nxpwifi_wmm_setup_ac_downgrade(priv);
+
+	return 0;
+}
+
+/*
+ * Callback handler from the command module to allow insertion of a WMM TLV.
+ *
+ * If the BSS we are associating to supports WMM, this function adds the
+ * required WMM Information element to the association request command buffer in
+ * the form of a NXP extended IEEE element.
+ */
+u32
+nxpwifi_wmm_process_association_req(struct nxpwifi_private *priv,
+				    u8 **assoc_buf,
+				    struct ieee80211_wmm_param_ie *wmm_ie,
+				    struct ieee80211_ht_cap *ht_cap)
+{
+	struct nxpwifi_ie_types_wmm_param_set *wmm_tlv;
+	u32 ret_len = 0;
+
+	/* Null checks */
+	if (!assoc_buf)
+		return 0;
+	if (!(*assoc_buf))
+		return 0;
+
+	if (!wmm_ie)
+		return 0;
+
+	nxpwifi_dbg(priv->adapter, INFO,
+		    "info: WMM: process assoc req: bss->wmm_ie=%#x\n",
+		    wmm_ie->element_id);
+
+	if ((priv->wmm_required ||
+	     (ht_cap && (priv->config_bands & BAND_GN ||
+	     priv->config_bands & BAND_AN))) &&
+	    wmm_ie->element_id == WLAN_EID_VENDOR_SPECIFIC) {
+		wmm_tlv = (struct nxpwifi_ie_types_wmm_param_set *)*assoc_buf;
+		wmm_tlv->header.type = cpu_to_le16((u16)wmm_info_ie[0]);
+		wmm_tlv->header.len = cpu_to_le16((u16)wmm_info_ie[1]);
+		memcpy(wmm_tlv->wmm_ie, &wmm_info_ie[2],
+		       le16_to_cpu(wmm_tlv->header.len));
+		if (wmm_ie->qos_info & IEEE80211_WMM_IE_AP_QOSINFO_UAPSD)
+			memcpy((u8 *)(wmm_tlv->wmm_ie
+				      + le16_to_cpu(wmm_tlv->header.len)
+				      - sizeof(priv->wmm_qosinfo)),
+			       &priv->wmm_qosinfo, sizeof(priv->wmm_qosinfo));
+
+		ret_len = sizeof(wmm_tlv->header)
+			  + le16_to_cpu(wmm_tlv->header.len);
+
+		*assoc_buf += ret_len;
+	}
+
+	return ret_len;
+}
+
+/* Computes the time delay in the driver queues for a given packet. */
+u8
+nxpwifi_wmm_compute_drv_pkt_delay(struct nxpwifi_private *priv,
+				  const struct sk_buff *skb)
+{
+	u32 queue_delay = ktime_to_ms(net_timedelta(skb->tstamp));
+	u8 ret_val;
+
+	/*
+	 * Queue delay is passed as a uint8 in units of 2ms (ms shifted
+	 *  by 1). Min value (other than 0) is therefore 2ms, max is 510ms.
+	 *
+	 * Pass max value if queue_delay is beyond the uint8 range
+	 */
+	ret_val = (u8)(min(queue_delay, priv->wmm.drv_pkt_delay_max) >> 1);
+
+	nxpwifi_dbg(priv->adapter, DATA, "data: WMM: Pkt Delay: %d ms,\t"
+		    "%d ms sent to FW\n", queue_delay, ret_val);
+
+	return ret_val;
+}
+
+/* Retrieves the highest priority RA list table pointer. */
+static struct nxpwifi_ra_list_tbl *
+nxpwifi_wmm_get_highest_priolist_ptr(struct nxpwifi_adapter *adapter,
+				     struct nxpwifi_private **priv, int *tid)
+{
+	struct nxpwifi_private *priv_tmp;
+	struct nxpwifi_ra_list_tbl *ptr;
+	struct nxpwifi_tid_tbl *tid_ptr;
+	atomic_t *hqp;
+	int i, j;
+	u8 to_tid;
+
+	/* check the BSS with highest priority first */
+	for (j = adapter->priv_num - 1; j >= 0; --j) {
+		/* iterate over BSS with the equal priority */
+		list_for_each_entry(adapter->bss_prio_tbl[j].bss_prio_cur,
+				    &adapter->bss_prio_tbl[j].bss_prio_head,
+				    list) {
+try_again:
+			priv_tmp = adapter->bss_prio_tbl[j].bss_prio_cur->priv;
+
+			if (!priv_tmp->port_open ||
+			    (atomic_read(&priv_tmp->wmm.tx_pkts_queued) == 0))
+				continue;
+
+			/* iterate over the WMM queues of the BSS */
+			hqp = &priv_tmp->wmm.highest_queued_prio;
+			for (i = atomic_read(hqp); i >= LOW_PRIO_TID; --i) {
+				spin_lock_bh(&priv_tmp->wmm.ra_list_spinlock);
+
+				to_tid = tos_to_tid[i];
+				tid_ptr = &(priv_tmp)->wmm.tid_tbl_ptr[to_tid];
+
+				/* iterate over receiver addresses */
+				list_for_each_entry(ptr, &tid_ptr->ra_list,
+						    list) {
+					if (!ptr->tx_paused &&
+					    !skb_queue_empty(&ptr->skb_head))
+						/* holds both locks */
+						goto found;
+				}
+
+				spin_unlock_bh(&priv_tmp->wmm.ra_list_spinlock);
+			}
+
+			if (atomic_read(&priv_tmp->wmm.tx_pkts_queued) != 0) {
+				atomic_set(&priv_tmp->wmm.highest_queued_prio,
+					   HIGH_PRIO_TID);
+				/*
+				 * Iterate current private once more, since
+				 * there still exist packets in data queue
+				 */
+				goto try_again;
+			} else {
+				atomic_set(&priv_tmp->wmm.highest_queued_prio,
+					   NO_PKT_PRIO_TID);
+			}
+		}
+	}
+
+	return NULL;
+
+found:
+	/* holds ra_list_spinlock */
+	if (atomic_read(hqp) > i)
+		atomic_set(hqp, i);
+	spin_unlock_bh(&priv_tmp->wmm.ra_list_spinlock);
+
+	*priv = priv_tmp;
+	*tid = tos_to_tid[i];
+
+	return ptr;
+}
+
+/* Rotates ra and bss lists so packets are picked round robin. */
+void nxpwifi_rotate_priolists(struct nxpwifi_private *priv,
+			      struct nxpwifi_ra_list_tbl *ra,
+			      int tid)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_bss_prio_tbl *tbl = adapter->bss_prio_tbl;
+	struct nxpwifi_tid_tbl *tid_ptr = &priv->wmm.tid_tbl_ptr[tid];
+
+	spin_lock_bh(&tbl[priv->bss_priority].bss_prio_lock);
+	/*
+	 * dirty trick: we remove 'head' temporarily and reinsert it after
+	 * curr bss node. imagine list to stay fixed while head is moved
+	 */
+	list_move(&tbl[priv->bss_priority].bss_prio_head,
+		  &tbl[priv->bss_priority].bss_prio_cur->list);
+	spin_unlock_bh(&tbl[priv->bss_priority].bss_prio_lock);
+
+	spin_lock_bh(&priv->wmm.ra_list_spinlock);
+	if (nxpwifi_is_ralist_valid(priv, ra, tid)) {
+		priv->wmm.packets_out[tid]++;
+		/* same as above */
+		list_move(&tid_ptr->ra_list, &ra->list);
+	}
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+}
+
+/* Checks if 11n aggregation is possible. */
+static bool
+nxpwifi_is_11n_aggragation_possible(struct nxpwifi_private *priv,
+				    struct nxpwifi_ra_list_tbl *ptr,
+				    int max_buf_size)
+{
+	int count = 0, total_size = 0;
+	struct sk_buff *skb, *tmp;
+	int max_amsdu_size;
+
+	if (priv->bss_role == NXPWIFI_BSS_ROLE_UAP && priv->ap_11n_enabled &&
+	    ptr->is_11n_enabled)
+		max_amsdu_size = min_t(int, ptr->max_amsdu, max_buf_size);
+	else
+		max_amsdu_size = max_buf_size;
+
+	skb_queue_walk_safe(&ptr->skb_head, skb, tmp) {
+		total_size += skb->len;
+		if (total_size >= max_amsdu_size)
+			break;
+		if (++count >= MIN_NUM_AMSDU)
+			return true;
+	}
+
+	return false;
+}
+
+/* Sends a single packet to firmware for transmission. */
+static void
+nxpwifi_send_single_packet(struct nxpwifi_private *priv,
+			   struct nxpwifi_ra_list_tbl *ptr, int ptr_index)
+__releases(&priv->wmm.ra_list_spinlock)
+{
+	struct sk_buff *skb, *skb_next;
+	struct nxpwifi_tx_param tx_param;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_txinfo *tx_info;
+
+	if (skb_queue_empty(&ptr->skb_head)) {
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+		nxpwifi_dbg(adapter, DATA, "data: nothing to send\n");
+		return;
+	}
+
+	skb = skb_dequeue(&ptr->skb_head);
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	nxpwifi_dbg(adapter, DATA,
+		    "data: dequeuing the packet %p %p\n", ptr, skb);
+
+	ptr->total_pkt_count--;
+
+	if (!skb_queue_empty(&ptr->skb_head))
+		skb_next = skb_peek(&ptr->skb_head);
+	else
+		skb_next = NULL;
+
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+
+	tx_param.next_pkt_len = ((skb_next) ? skb_next->len +
+				sizeof(struct txpd) : 0);
+
+	if (nxpwifi_process_tx(priv, skb, &tx_param) == -EBUSY) {
+		/* Queue the packet back at the head */
+		spin_lock_bh(&priv->wmm.ra_list_spinlock);
+
+		if (!nxpwifi_is_ralist_valid(priv, ptr, ptr_index)) {
+			spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+			nxpwifi_write_data_complete(adapter, skb, 0, -1);
+			return;
+		}
+
+		skb_queue_tail(&ptr->skb_head, skb);
+
+		ptr->total_pkt_count++;
+		ptr->ba_pkt_count++;
+		tx_info->flags |= NXPWIFI_BUF_FLAG_REQUEUED_PKT;
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+	} else {
+		nxpwifi_rotate_priolists(priv, ptr, ptr_index);
+		atomic_dec(&priv->wmm.tx_pkts_queued);
+	}
+}
+
+/* Checks if the first packet in the given RA list is already processed or not. */
+static bool
+nxpwifi_is_ptr_processed(struct nxpwifi_private *priv,
+			 struct nxpwifi_ra_list_tbl *ptr)
+{
+	struct sk_buff *skb;
+	struct nxpwifi_txinfo *tx_info;
+
+	if (skb_queue_empty(&ptr->skb_head))
+		return false;
+
+	skb = skb_peek(&ptr->skb_head);
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_REQUEUED_PKT)
+		return true;
+
+	return false;
+}
+
+/* Sends a single processed packet to firmware for transmission. */
+static void
+nxpwifi_send_processed_packet(struct nxpwifi_private *priv,
+			      struct nxpwifi_ra_list_tbl *ptr, int ptr_index)
+				__releases(&priv->wmm.ra_list_spinlock)
+{
+	struct nxpwifi_tx_param tx_param;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int ret;
+	struct sk_buff *skb, *skb_next;
+	struct nxpwifi_txinfo *tx_info;
+
+	if (skb_queue_empty(&ptr->skb_head)) {
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+		return;
+	}
+
+	skb = skb_dequeue(&ptr->skb_head);
+
+	if (adapter->data_sent || adapter->tx_lock_flag) {
+		ptr->total_pkt_count--;
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+		skb_queue_tail(&adapter->tx_data_q, skb);
+		atomic_dec(&priv->wmm.tx_pkts_queued);
+		atomic_inc(&adapter->tx_queued);
+		return;
+	}
+
+	if (!skb_queue_empty(&ptr->skb_head))
+		skb_next = skb_peek(&ptr->skb_head);
+	else
+		skb_next = NULL;
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+
+	tx_param.next_pkt_len =
+		((skb_next) ? skb_next->len +
+		 sizeof(struct txpd) : 0);
+
+	ret = adapter->if_ops.host_to_card(adapter, NXPWIFI_TYPE_DATA,
+					   skb, &tx_param);
+
+	switch (ret) {
+	case -EBUSY:
+		nxpwifi_dbg(adapter, ERROR, "data: -EBUSY is returned\n");
+		spin_lock_bh(&priv->wmm.ra_list_spinlock);
+
+		if (!nxpwifi_is_ralist_valid(priv, ptr, ptr_index)) {
+			spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+			nxpwifi_write_data_complete(adapter, skb, 0, -1);
+			return;
+		}
+
+		skb_queue_tail(&ptr->skb_head, skb);
+
+		tx_info->flags |= NXPWIFI_BUF_FLAG_REQUEUED_PKT;
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+		break;
+	case -EINPROGRESS:
+		break;
+	case 0:
+		nxpwifi_write_data_complete(adapter, skb, 0, ret);
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR, "host_to_card failed: %#x\n", ret);
+		adapter->dbg.num_tx_host_to_card_failure++;
+		nxpwifi_write_data_complete(adapter, skb, 0, ret);
+		break;
+	}
+
+	if (ret != -EBUSY) {
+		nxpwifi_rotate_priolists(priv, ptr, ptr_index);
+		atomic_dec(&priv->wmm.tx_pkts_queued);
+		spin_lock_bh(&priv->wmm.ra_list_spinlock);
+		ptr->total_pkt_count--;
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+	}
+}
+
+/* Dequeues a packet from the highest priority list and transmits it. */
+static int
+nxpwifi_dequeue_tx_packet(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_ra_list_tbl *ptr;
+	struct nxpwifi_private *priv = NULL;
+	int ptr_index = 0;
+	u8 ra[ETH_ALEN];
+	int tid_del = 0, tid = 0;
+
+	ptr = nxpwifi_wmm_get_highest_priolist_ptr(adapter, &priv, &ptr_index);
+	if (!ptr)
+		return -ENOENT;
+
+	tid = nxpwifi_get_tid(ptr);
+
+	nxpwifi_dbg(adapter, DATA, "data: tid=%d\n", tid);
+
+	spin_lock_bh(&priv->wmm.ra_list_spinlock);
+	if (!nxpwifi_is_ralist_valid(priv, ptr, ptr_index)) {
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+		return -EINVAL;
+	}
+
+	if (nxpwifi_is_ptr_processed(priv, ptr)) {
+		nxpwifi_send_processed_packet(priv, ptr, ptr_index);
+		/*
+		 * ra_list_spinlock has been freed in
+		 * nxpwifi_send_processed_packet()
+		 */
+		return 0;
+	}
+
+	if (!ptr->is_11n_enabled ||
+	    ptr->ba_status ||
+	    priv->wps.session_enable) {
+		if (ptr->is_11n_enabled &&
+		    ptr->ba_status &&
+		    ptr->amsdu_in_ampdu &&
+		    nxpwifi_is_amsdu_allowed(priv, tid) &&
+		    nxpwifi_is_11n_aggragation_possible(priv, ptr,
+							adapter->tx_buf_size))
+			nxpwifi_11n_aggregate_pkt(priv, ptr, ptr_index);
+			/*
+			 * ra_list_spinlock has been freed in
+			 * nxpwifi_11n_aggregate_pkt()
+			 */
+		else
+			nxpwifi_send_single_packet(priv, ptr, ptr_index);
+			/*
+			 * ra_list_spinlock has been freed in
+			 * nxpwifi_send_single_packet()
+			 */
+	} else {
+		if (nxpwifi_is_ampdu_allowed(priv, ptr, tid) &&
+		    ptr->ba_pkt_count > ptr->ba_packet_thr) {
+			if (nxpwifi_space_avail_for_new_ba_stream(adapter)) {
+				nxpwifi_create_ba_tbl(priv, ptr->ra, tid,
+						      BA_SETUP_INPROGRESS);
+				nxpwifi_send_addba(priv, tid, ptr->ra);
+			} else if (nxpwifi_find_stream_to_delete
+				   (priv, tid, &tid_del, ra)) {
+				nxpwifi_create_ba_tbl(priv, ptr->ra, tid,
+						      BA_SETUP_INPROGRESS);
+				nxpwifi_send_delba(priv, tid_del, ra, 1);
+			}
+		}
+		if (nxpwifi_is_amsdu_allowed(priv, tid) &&
+		    nxpwifi_is_11n_aggragation_possible(priv, ptr,
+							adapter->tx_buf_size))
+			nxpwifi_11n_aggregate_pkt(priv, ptr, ptr_index);
+			/*
+			 * ra_list_spinlock has been freed in
+			 * nxpwifi_11n_aggregate_pkt()
+			 */
+		else
+			nxpwifi_send_single_packet(priv, ptr, ptr_index);
+			/*
+			 * ra_list_spinlock has been freed in
+			 * nxpwifi_send_single_packet()
+			 */
+	}
+	return 0;
+}
+
+void nxpwifi_process_bypass_tx(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_tx_param tx_param;
+	struct sk_buff *skb;
+	struct nxpwifi_txinfo *tx_info;
+	struct nxpwifi_private *priv;
+	int i;
+
+	if (adapter->data_sent || adapter->tx_lock_flag)
+		return;
+
+	for (i = 0; i < adapter->priv_num; ++i) {
+		priv = adapter->priv[i];
+
+		if (skb_queue_empty(&priv->bypass_txq))
+			continue;
+
+		skb = skb_dequeue(&priv->bypass_txq);
+		tx_info = NXPWIFI_SKB_TXCB(skb);
+
+		/* no aggregation for bypass packets */
+		tx_param.next_pkt_len = 0;
+
+		if (nxpwifi_process_tx(priv, skb, &tx_param) == -EBUSY) {
+			skb_queue_head(&priv->bypass_txq, skb);
+			tx_info->flags |= NXPWIFI_BUF_FLAG_REQUEUED_PKT;
+		} else {
+			atomic_dec(&adapter->bypass_tx_pending);
+		}
+	}
+}
+
+/* Transmits the highest priority packet awaiting in the WMM Queues. */
+void
+nxpwifi_wmm_process_tx(struct nxpwifi_adapter *adapter)
+{
+	do {
+		if (nxpwifi_dequeue_tx_packet(adapter))
+			break;
+		if (adapter->iface_type != NXPWIFI_SDIO) {
+			if (adapter->data_sent ||
+			    adapter->tx_lock_flag)
+				break;
+		} else {
+			if (atomic_read(&adapter->tx_queued) >=
+			    NXPWIFI_MAX_PKTS_TXQ)
+				break;
+		}
+	} while (!nxpwifi_wmm_lists_empty(adapter));
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/wmm.h b/drivers/net/wireless/nxp/nxpwifi/wmm.h
new file mode 100644
index 000000000000..6241c2c5fcc4
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/wmm.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: WMM
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_WMM_H_
+#define _NXPWIFI_WMM_H_
+
+enum ieee_types_wmm_aciaifsn_bitmasks {
+	NXPWIFI_AIFSN = (BIT(0) | BIT(1) | BIT(2) | BIT(3)),
+	NXPWIFI_ACM = BIT(4),
+	NXPWIFI_ACI = (BIT(5) | BIT(6)),
+};
+
+enum ieee_types_wmm_ecw_bitmasks {
+	NXPWIFI_ECW_MIN = (BIT(0) | BIT(1) | BIT(2) | BIT(3)),
+	NXPWIFI_ECW_MAX = (BIT(4) | BIT(5) | BIT(6) | BIT(7)),
+};
+
+extern const u16 nxpwifi_1d_to_wmm_queue[];
+extern const u8 tos_to_tid_inv[];
+
+/* Retrieve the TID of the given RA list. */
+static inline int
+nxpwifi_get_tid(struct nxpwifi_ra_list_tbl *ptr)
+{
+	struct sk_buff *skb;
+
+	if (skb_queue_empty(&ptr->skb_head))
+		return 0;
+
+	skb = skb_peek(&ptr->skb_head);
+
+	return skb->priority;
+}
+
+void nxpwifi_wmm_add_buf_txqueue(struct nxpwifi_private *priv,
+				 struct sk_buff *skb);
+void nxpwifi_wmm_add_buf_bypass_txqueue(struct nxpwifi_private *priv,
+					struct sk_buff *skb);
+void nxpwifi_ralist_add(struct nxpwifi_private *priv, const u8 *ra);
+void nxpwifi_rotate_priolists(struct nxpwifi_private *priv,
+			      struct nxpwifi_ra_list_tbl *ra, int tid);
+
+bool nxpwifi_wmm_lists_empty(struct nxpwifi_adapter *adapter);
+bool nxpwifi_bypass_txlist_empty(struct nxpwifi_adapter *adapter);
+void nxpwifi_wmm_process_tx(struct nxpwifi_adapter *adapter);
+void nxpwifi_process_bypass_tx(struct nxpwifi_adapter *adapter);
+bool nxpwifi_is_ralist_valid(struct nxpwifi_private *priv,
+			     struct nxpwifi_ra_list_tbl *ra_list, int tid);
+
+u8 nxpwifi_wmm_compute_drv_pkt_delay(struct nxpwifi_private *priv,
+				     const struct sk_buff *skb);
+void nxpwifi_wmm_init(struct nxpwifi_adapter *adapter);
+
+u32 nxpwifi_wmm_process_association_req(struct nxpwifi_private *priv,
+					u8 **assoc_buf,
+					struct ieee80211_wmm_param_ie *wmmie,
+					struct ieee80211_ht_cap *htcap);
+
+void nxpwifi_wmm_setup_queue_priorities(struct nxpwifi_private *priv,
+					struct ieee80211_wmm_param_ie *wmm_ie);
+void nxpwifi_wmm_setup_ac_downgrade(struct nxpwifi_private *priv);
+int nxpwifi_ret_wmm_get_status(struct nxpwifi_private *priv,
+			       const struct host_cmd_ds_command *resp);
+struct nxpwifi_ra_list_tbl *
+nxpwifi_wmm_get_queue_raptr(struct nxpwifi_private *priv, u8 tid,
+			    const u8 *ra_addr);
+u8 nxpwifi_wmm_downgrade_tid(struct nxpwifi_private *priv, u32 tid);
+void nxpwifi_update_ralist_tx_pause(struct nxpwifi_private *priv, u8 *mac,
+				    u8 tx_pause);
+
+struct nxpwifi_ra_list_tbl *nxpwifi_wmm_get_ralist_node(struct nxpwifi_private
+					*priv, u8 tid, const u8 *ra_addr);
+#endif /* !_NXPWIFI_WMM_H_ */
-- 
2.34.1


