Return-Path: <linux-wireless+bounces-37429-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LJvMMEz4ImqnfwEAu9opvQ
	(envelope-from <linux-wireless+bounces-37429-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 18:24:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F76649BBF
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 18:24:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=WQVc3Tqy;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37429-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37429-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11C3F30788D5
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 16:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60344DBD6B;
	Fri,  5 Jun 2026 16:14:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012008.outbound.protection.outlook.com [52.101.66.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF404D98E4;
	Fri,  5 Jun 2026 16:14:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676061; cv=fail; b=UXtkZjg9Qz7HkW7duKx/ekb7UMfkymNTfLSsYHij+tzJS1FLoYDP8aYRRcDjI8WvIH6ORaDuEESOsbfD8O/Q83lXc6INoeHZuR20nB4sp4PiPqCPfYSc2dd6a0blRN5MXlnubvoYEteVgzwPTOQ2sbrMXLv0u1o93wQQ91GH6GA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676061; c=relaxed/simple;
	bh=k6u6lA9QYvQ644Nt3S3rifHTqv3J7zNxMjk4SMyS5Zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kwOzdJllyS91NFvCeIIsFC4GkDCvgLbmQ6R1caiKTIAu9YDhvvGBljPC6FFn5hXirO0nOzG0lOBlhbRCFp91VBOpgHuKEIXB3Ae2zHH5GvsdXN4QY/T/AGqyBPIycAHIv60o6GzMTgkyaRyv3RKHbiIkCcZS5fAcP1Bl/IWVVOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WQVc3Tqy; arc=fail smtp.client-ip=52.101.66.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c89v0E11n8WfoqSuq8sm19loV5QdwCKw72AA3m+n4d5rjtG5NgIY1iN6hWRGKC7ExA5g1l0rClCpNqERMqTheKoOzOmjNOdh10BvljUcWncVz3t0HjUym+ddDaYDsugP7vRW8gJJWylENZcr8/QfQ+73N1XmYeREaJ9bR2/OM34z6BFc+oTAsmUIxXoDYaxFIVm7ENxcpxR9TQt6zqeypTkdg3YOibQNLrkV5wl86J1niq3fvO1AqbycluYqPRjFdBAXM2lBmOHHLvWTqcOkADqU3p83fUhNjPoALnfq4X1V5ipyXBWhFYcucQw1pHCpA8e6g8naXI4ppMieyr7mRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqUuVPu1I6xDYh9gd7f4BVIb1elpEunhPkFgkbQ5WgE=;
 b=D11WhayBJhG2pf9r0Vj0tDkafG207DhF72R9Oa4u83eNGLBd0+7KVoFP0NszecastqA1/wfp4Ckio4+UXFbES2sNfwB+//VsKRh9PwjLPRPRfU4zaehoEgJ7720vQc4DvYFP0YE6/ycSE/dlwW8FxYCD/2B1I1kRmJXGg8ybtGCxxOZjWhCYJbIfmu/FNrnOUfAg6WoGqadJk7p0WpeUEaWX0eyadynotqWgQ55yAmuEj1YukZ3H0zvaZG1W49c43pFWimgOefVPc4bZsdx7Uf1EvUFBPFcbzx1C83Ax/Yu0AOBnRv+gRB3ttNDp1GjNQEwl1M60LCLy8NgQgbHBeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqUuVPu1I6xDYh9gd7f4BVIb1elpEunhPkFgkbQ5WgE=;
 b=WQVc3Tqymm1fVJXylQpWDMfSrTDXk5tPM4f3bsOLl81FDi7O6F/5DLh5yqYxzRb+hnI1qJ2rr16Wum66vJ5L3Le6uD/YyM3lGKc2naNe2iLL5JuEASi9JWPYzKsOgDhk8fUQNXI2A75uu7PZGCsXYmfxLND6Rya6MrOwweuyW9NCGCRnkTTJbjfCN1SPKpDuAjQaJQfV3hdPz5CVCPtsK5XfCkGsba9K1cFCY2VjZ/OkCk2hV6reoBpaB5TetaeP90FYpB6mLmSTj0Wj+Ll+Z+ZD1Lms06ElC4s9tNXGxCkte847atBdbMEgTT8p6JtVx8SV/urgJWtaF5IB69+Xtw==
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 16:14:07 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:14:07 +0000
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
Subject: [PATCH v12 08/22] wifi: nxpwifi: add channel/frequency/power (cfp) support
Date: Sat,  6 Jun 2026 00:13:21 +0800
Message-Id: <20260605161335.2415583-9-jeff.chen_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 53519faf-f478-472e-66c2-08dec31d7870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|19092799006|366016|11063799006|5023799004|56012099006|6133799003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	BtGQPFXjcXNHFSayn/gyhBA2/G7DPtLyC1TbGvfXwj+pMVJh6NBlv7rGhls71JnDZ6TBlgDTaImR31/3/c2oFn0pV7e7ltvd/YVAOlNo7/xSCXUp/2XKFlvb0tNUajSsNpzpaHnFhrgkAubMJplTvfIRhQgPPeOGBdYFLwIFQJ+3r1wfPuYWwLPK4JDj1k02uaGZckagTTuq/aw1d/IEgdZVMh2/F9OGTOhuult/titGfNzMdr1VhTYSQiGG5W2jG/Su3ExrlbBUldskBWUVbfXOyGURmanvwsiAE86yf5naJ7Jws3x09NQaXHAGG7grGYzHuxZzsXyf2ECdoUcP25BaFHFjr4c+ytfz4aPBr/w2gmJNbOkHUxVCrdYhdRO7M6CLKY6+oHAW2zfb7A6NeA1cGnsfR4Odu4KDef7hjlMug76Y747OTExInnmPR7bW9t1dIboWa8wnrSCS8WUR+qj8lLhd+MmTgDVssGKae9oWje49zrNQdmHMq9R10WeiL4VHnLgKt1O8epLcSUHDJj2Td/yvjqbj22zWpOajDd0aSngePulpODQXlxS9UoCEmcucsASCJJSZJX6nxjEm+vXseY9KXN/H4wr9XKzo6GCtTVxjCBLUWbJVPQnitOR6CoiL5Elb+6/d+KigQ281H0M6GdaNNG4h/eOax02EPZp851JyHdw0roxupm4MchBUBrdV0DnfMnjUJ98E3jVYMlFekLpZfU0f0K0Frs2q8XwUfKxCaw/32qe7KgsfW+ri
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(19092799006)(366016)(11063799006)(5023799004)(56012099006)(6133799003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wVNGI5gfH2JIMNxSpVFgo/buyHkg8ehEqah6+u/e9iHT+5gjX1OHCHhs6uP4?=
 =?us-ascii?Q?hASuNkNjVQhgWP1eyYZ8JCNSMZeIx+tKnVB0gQr/Z97RstIpQhLBRljNEWrT?=
 =?us-ascii?Q?WXr5SqfFwt+AfX7AQHENBBBjcVq97zYjETRPde0UZKQGXjfwt0URiBEvFIF5?=
 =?us-ascii?Q?xXMhFEc7QuWseBgYD/J5dNIAyDJFqF2KKwK/flH7nkU4LHxa9A4EmETXmhIQ?=
 =?us-ascii?Q?8SBSBY/qC6qQRrrcOk9Zoaj5ERZ3vP249+4/gXib41gbAsi0QsgHMZopzTMD?=
 =?us-ascii?Q?3LW4T7to1q0aNRAsbDSC8SvPS+WNKWrggvJrJuJuzt7k0cCu2XDUs+gpfmuH?=
 =?us-ascii?Q?MQGTfS09a+GX/6rToPor67RTFbYK52DYa96/VuGloFG1LciKZDs3KVn/QBRj?=
 =?us-ascii?Q?saQiD9d8d4k3ELuvDe+Fw/4il2rXfFX0/9JFskusoP9UUFbj27UrfYJ5vUgU?=
 =?us-ascii?Q?8LrHpV9NkENqkpaAHtwA/ZX3h7mJXwKidcuYq9KAYG8/lNheiYsA0/L/AbUR?=
 =?us-ascii?Q?+5G8/pyUhDLO/tOiVc6KX1AqdDdShQc2VRIuf8KJEvTw840h4hbWbWXQsanw?=
 =?us-ascii?Q?wYR7DDfWkputs7xOXY+ykURRkC7R/CeO3x25ZuDmgFpZtByH/C44lfpV9BGc?=
 =?us-ascii?Q?fXBiAfG1MGjbMfWFs85g7zkZCL9f+OxXSNWt13vPlvRl/HB7CG8Kwm/C9tdv?=
 =?us-ascii?Q?3Pdnr0E3orPkajI4qHX6EwccKnvS4tX+uOt+sD7Lc36DrUtEJ+xh8jxhkAs6?=
 =?us-ascii?Q?xQcI9213Heb70m/je0RDOk5FcUH6PA3oci7wlgDsj3Rg64oJRoHX4PTRaVmv?=
 =?us-ascii?Q?Jh1dAqBJdjtW5rF1yRXzk5+ykv4Yjpmhz6jmb0sMBJG8wpNb6eL6iHx2WKGC?=
 =?us-ascii?Q?i855iPj6A/Vvt0Y4TgMqCSBHmGgwcnlV6fhpcZ42whMfk5Nhg+P8coZYNfFE?=
 =?us-ascii?Q?2mPeiRgC982sPVn8FZXgqHQA5Tlk1L/4UymclqrLl5JVihZ/+YSEJU+sF/82?=
 =?us-ascii?Q?RQNInprf61fKfI5ZhAZWHhQF1Ba3bUg85bUpoipDJ1GEttQh3kRdyNNmgpdK?=
 =?us-ascii?Q?fhOiHeH4NjmXIp52FFmd5kdSKZUSFSBhG6LUDGmbvB9jwVaBuBExbEP+yCKp?=
 =?us-ascii?Q?wCVq09ytRno/hGCPHyZaOn78v6BmefxFqpA2kzYocnWUt0+ZNuTacgxZAPYN?=
 =?us-ascii?Q?DnGp4zzw0N8VzhKcj5/H78QE9cT35OZU21WCUzXDTdRUv5X+uj58cg7/6v9R?=
 =?us-ascii?Q?m7KAD7fNLy9v8zMlV3n4K+P5QU+kk8A4i5fjz60beW/zs85ZhIM6KZYSx9+1?=
 =?us-ascii?Q?S8h1t8mWW40XB1jNvkubczPOKMkkaDT7tSBrJ7F9e1jhkHzkVbAaWO1t9ky1?=
 =?us-ascii?Q?Vl2nYEshlCNbng7ovwZPannYQyDJruTnXFCJJJlFcS5EbawO09StHhCgWusx?=
 =?us-ascii?Q?ix/Z1fRxtkBMMnuz4SQlxqf0xvj5QqWKFIujK3vOGoOq2ZmObiZ8o+XbGuRC?=
 =?us-ascii?Q?TfHZX4V9lLY+GIHorgexihTY6bYVd+2uL6lOYvV+1AWhwqCq2LzNA99JuXTi?=
 =?us-ascii?Q?AzC0WR4zOLQFqFwlJAjIwyQKcJR6dD8QGyrZZrbm0q1tfvwQi9gmdG5qENHp?=
 =?us-ascii?Q?8WRAWfnV3qN5Or0m8WRkNiFeDMBJZePaTujkliUewheRBzpXLdVR/J487M/A?=
 =?us-ascii?Q?DTErKyctSxNAN1EsBXLIo4FQHdmPU7dX1cqxL/2JAM72VZfA2llHgiD9t7oH?=
 =?us-ascii?Q?STYZPCrhRA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53519faf-f478-472e-66c2-08dec31d7870
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 16:14:07.7399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FAUDcfdxpRrYZENV4LEqt6bsqYK7isDDaCH1/BheIb91ZfYDB/HEE9qg/qN7NJm0YiS0JE59l5mcdm3i+QPRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8436
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37429-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:briannorris@chromium.org,m:johannes@sipsolutions.net,m:francesco@dolcini.it,m:wyatt.hsu@nxp.com,m:s.hauer@pengutronix.de,m:ulf.hansson@linaro.org,m:jeff.chen_1@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nxp.com:mid,nxp.com:dkim,nxp.com:from_mime,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44F76649BBF

Add cfp.c to provide channel, frequency, and power utilities for the
nxpwifi driver.

Define supported data rates for 802.11a/b/g/n/ac and implement helpers
for converting between rate values and rate indices for legacy, HT, and
VHT formats. Add region-code-to-country mapping to support 802.11d
operation.

Provide utility functions for determining supported and active data
rates, mapping channel/frequency/power (CFP) triplets, adjusting RX rate
indices, and extracting rate information from cfg80211 scan requests.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/cfp.c | 458 +++++++++++++++++++++++++
 1 file changed, 458 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfp.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/cfp.c b/drivers/net/wireless/nxp/nxpwifi/cfp.c
new file mode 100644
index 000000000000..e4adbeb6a09c
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/cfp.c
@@ -0,0 +1,458 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * nxpwifi: Channel, Frequency and Power
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "cfg80211.h"
+
+/* 100mW */
+#define NXPWIFI_TX_PWR_DEFAULT         20
+/* 100mW */
+#define NXPWIFI_TX_PWR_US_DEFAULT      20
+/* 50mW */
+#define NXPWIFI_TX_PWR_JP_DEFAULT      16
+/* 100mW */
+#define NXPWIFI_TX_PWR_FR_100MW        20
+/* 10mW */
+#define NXPWIFI_TX_PWR_FR_10MW         10
+/* 100mW */
+#define NXPWIFI_TX_PWR_EMEA_DEFAULT    20
+
+static u8 supported_rates_a[A_SUPPORTED_RATES] = { 0x0c, 0x12, 0x18, 0x24,
+					0xb0, 0x48, 0x60, 0x6c, 0 };
+static u16 nxpwifi_data_rates[NXPWIFI_SUPPORTED_RATES_EXT] = { 0x02, 0x04,
+					0x0B, 0x16, 0x00, 0x0C, 0x12, 0x18,
+					0x24, 0x30, 0x48, 0x60, 0x6C, 0x90,
+					0x0D, 0x1A, 0x27, 0x34, 0x4E, 0x68,
+					0x75, 0x82, 0x0C, 0x1B, 0x36, 0x51,
+					0x6C, 0xA2, 0xD8, 0xF3, 0x10E, 0x00 };
+
+static u8 supported_rates_b[B_SUPPORTED_RATES] = { 0x02, 0x04, 0x0b, 0x16, 0 };
+
+static u8 supported_rates_g[G_SUPPORTED_RATES] = { 0x0c, 0x12, 0x18, 0x24,
+					0x30, 0x48, 0x60, 0x6c, 0 };
+
+static u8 supported_rates_bg[BG_SUPPORTED_RATES] = { 0x02, 0x04, 0x0b, 0x0c,
+					0x12, 0x16, 0x18, 0x24, 0x30, 0x48,
+					0x60, 0x6c, 0 };
+
+u16 region_code_index[NXPWIFI_MAX_REGION_CODE] = { 0x00, 0x10, 0x20, 0x30,
+						0x31, 0x32, 0x40, 0x41, 0x50 };
+
+/* mcs_rate: first 8 entries for 1x1; all 16 for 2x2. */
+static const u16 mcs_rate[4][16] = {
+	/* LGI 40M */
+	{ 0x1b, 0x36, 0x51, 0x6c, 0xa2, 0xd8, 0xf3, 0x10e,
+	  0x36, 0x6c, 0xa2, 0xd8, 0x144, 0x1b0, 0x1e6, 0x21c },
+
+	/* SGI 40M */
+	{ 0x1e, 0x3c, 0x5a, 0x78, 0xb4, 0xf0, 0x10e, 0x12c,
+	  0x3c, 0x78, 0xb4, 0xf0, 0x168, 0x1e0, 0x21c, 0x258 },
+
+	/* LGI 20M */
+	{ 0x0d, 0x1a, 0x27, 0x34, 0x4e, 0x68, 0x75, 0x82,
+	  0x1a, 0x34, 0x4e, 0x68, 0x9c, 0xd0, 0xea, 0x104 },
+
+	/* SGI 20M */
+	{ 0x0e, 0x1c, 0x2b, 0x39, 0x56, 0x73, 0x82, 0x90,
+	  0x1c, 0x39, 0x56, 0x73, 0xad, 0xe7, 0x104, 0x120 }
+};
+
+/* AC rates */
+static const u16 ac_mcs_rate_nss1[8][10] = {
+	/* LG 160M */
+	{ 0x75, 0xEA, 0x15F, 0x1D4, 0x2BE, 0x3A8, 0x41D,
+	  0x492, 0x57C, 0x618 },
+
+	/* SG 160M */
+	{ 0x82, 0x104, 0x186, 0x208, 0x30C, 0x410, 0x492,
+	  0x514, 0x618, 0x6C6 },
+
+	/* LG 80M */
+	{ 0x3B, 0x75, 0xB0, 0xEA, 0x15F, 0x1D4, 0x20F,
+	  0x249, 0x2BE, 0x30C },
+
+	/* SG 80M */
+	{ 0x41, 0x82, 0xC3, 0x104, 0x186, 0x208, 0x249,
+	  0x28A, 0x30C, 0x363 },
+
+	/* LG 40M */
+	{ 0x1B, 0x36, 0x51, 0x6C, 0xA2, 0xD8, 0xF3,
+	  0x10E, 0x144, 0x168 },
+
+	/* SG 40M */
+	{ 0x1E, 0x3C, 0x5A, 0x78, 0xB4, 0xF0, 0x10E,
+	  0x12C, 0x168, 0x190 },
+
+	/* LG 20M */
+	{ 0xD, 0x1A, 0x27, 0x34, 0x4E, 0x68, 0x75, 0x82, 0x9C, 0x00 },
+
+	/* SG 20M */
+	{ 0xF, 0x1D, 0x2C, 0x3A, 0x57, 0x74, 0x82, 0x91, 0xAE, 0x00 },
+};
+
+/* NSS2 note: the value in the table is 2 multiplier of the actual rate */
+static const u16 ac_mcs_rate_nss2[8][10] = {
+	/* LG 160M */
+	{ 0xEA, 0x1D4, 0x2BE, 0x3A8, 0x57C, 0x750, 0x83A,
+	  0x924, 0xAF8, 0xC30 },
+
+	/* SG 160M */
+	{ 0x104, 0x208, 0x30C, 0x410, 0x618, 0x820, 0x924,
+	  0xA28, 0xC30, 0xD8B },
+
+	/* LG 80M */
+	{ 0x75, 0xEA, 0x15F, 0x1D4, 0x2BE, 0x3A8, 0x41D,
+	  0x492, 0x57C, 0x618 },
+
+	/* SG 80M */
+	{ 0x82, 0x104, 0x186, 0x208, 0x30C, 0x410, 0x492,
+	  0x514, 0x618, 0x6C6 },
+
+	/* LG 40M */
+	{ 0x36, 0x6C, 0xA2, 0xD8, 0x144, 0x1B0, 0x1E6,
+	  0x21C, 0x288, 0x2D0 },
+
+	/* SG 40M */
+	{ 0x3C, 0x78, 0xB4, 0xF0, 0x168, 0x1E0, 0x21C,
+	  0x258, 0x2D0, 0x320 },
+
+	/* LG 20M */
+	{ 0x1A, 0x34, 0x4A, 0x68, 0x9C, 0xD0, 0xEA, 0x104,
+	  0x138, 0x00 },
+
+	/* SG 20M */
+	{ 0x1D, 0x3A, 0x57, 0x74, 0xAE, 0xE6, 0x104, 0x121,
+	  0x15B, 0x00 },
+};
+
+struct region_code_mapping {
+	u8 code;
+	u8 region[IEEE80211_COUNTRY_STRING_LEN];
+};
+
+static struct region_code_mapping region_code_mapping_t[] = {
+	{ 0x10, "US " }, /* US FCC */
+	{ 0x20, "CA " }, /* IC Canada */
+	{ 0x30, "FR " }, /* France */
+	{ 0x31, "ES " }, /* Spain */
+	{ 0x32, "FR " }, /* France */
+	{ 0x40, "JP " }, /* Japan */
+	{ 0x41, "JP " }, /* Japan */
+	{ 0x50, "CN " }, /* China */
+};
+
+/* Convert 11d country code to region string. */
+u8 *nxpwifi_11d_code_2_region(u8 code)
+{
+	u8 i;
+
+	/* Look for code in mapping table */
+	for (i = 0; i < ARRAY_SIZE(region_code_mapping_t); i++)
+		if (region_code_mapping_t[i].code == code)
+			return region_code_mapping_t[i].region;
+
+	return NULL;
+}
+
+/* Map supported rate index to AC/VHT data rate. */
+u32 nxpwifi_index_to_acs_data_rate(struct nxpwifi_private *priv,
+				   u8 index, u8 ht_info)
+{
+	u32 rate = 0;
+	u8 mcs_index = 0;
+	u8 bw = 0;
+	u8 gi = 0;
+
+	if ((ht_info & 0x3) == NXPWIFI_RATE_FORMAT_VHT) {
+		mcs_index = min(index & 0xF, 9);
+
+		/* 20M: bw=0, 40M: bw=1, 80M: bw=2, 160M: bw=3 */
+		bw = (ht_info & 0xC) >> 2;
+
+		/* LGI: gi =0, SGI: gi = 1 */
+		gi = (ht_info & 0x10) >> 4;
+
+		if ((index >> 4) == 1)	/* NSS = 2 */
+			rate = ac_mcs_rate_nss2[2 * (3 - bw) + gi][mcs_index];
+		else			/* NSS = 1 */
+			rate = ac_mcs_rate_nss1[2 * (3 - bw) + gi][mcs_index];
+	} else if ((ht_info & 0x3) == NXPWIFI_RATE_FORMAT_HT) {
+		/* 20M: bw=0, 40M: bw=1 */
+		bw = (ht_info & 0xC) >> 2;
+
+		/* LGI: gi =0, SGI: gi = 1 */
+		gi = (ht_info & 0x10) >> 4;
+
+		if (index == NXPWIFI_RATE_BITMAP_MCS0) {
+			if (gi == 1)
+				rate = 0x0D;    /* MCS 32 SGI rate */
+			else
+				rate = 0x0C;    /* MCS 32 LGI rate */
+		} else if (index < 16) {
+			if (bw == 1 || bw == 0)
+				rate = mcs_rate[2 * (1 - bw) + gi][index];
+			else
+				rate = nxpwifi_data_rates[0];
+		} else {
+			rate = nxpwifi_data_rates[0];
+		}
+	} else {
+		/* 11n non-HT rates */
+		if (index >= NXPWIFI_SUPPORTED_RATES_EXT)
+			index = 0;
+		rate = nxpwifi_data_rates[index];
+	}
+
+	return rate;
+}
+
+/* Map supported rate index to data rate. */
+u32 nxpwifi_index_to_data_rate(struct nxpwifi_private *priv,
+			       u8 index, u8 ht_info)
+{
+	u32 mcs_num_supp =
+		(priv->adapter->user_dev_mcs_support == HT_STREAM_2X2) ? 16 : 8;
+	u32 rate;
+
+	if (priv->adapter->is_hw_11ac_capable)
+		return nxpwifi_index_to_acs_data_rate(priv, index, ht_info);
+
+	if (ht_info & BIT(0)) {
+		if (index == NXPWIFI_RATE_BITMAP_MCS0) {
+			if (ht_info & BIT(2))
+				rate = 0x0D;	/* MCS 32 SGI rate */
+			else
+				rate = 0x0C;	/* MCS 32 LGI rate */
+		} else if (index < mcs_num_supp) {
+			if (ht_info & BIT(1)) {
+				if (ht_info & BIT(2))
+					/* SGI, 40M */
+					rate = mcs_rate[1][index];
+				else
+					/* LGI, 40M */
+					rate = mcs_rate[0][index];
+			} else {
+				if (ht_info & BIT(2))
+					/* SGI, 20M */
+					rate = mcs_rate[3][index];
+				else
+					/* LGI, 20M */
+					rate = mcs_rate[2][index];
+			}
+		} else {
+			rate = nxpwifi_data_rates[0];
+		}
+	} else {
+		if (index >= NXPWIFI_SUPPORTED_RATES_EXT)
+			index = 0;
+		rate = nxpwifi_data_rates[index];
+	}
+	return rate;
+}
+
+/* Return current active data rates (depends on connection). */
+u32 nxpwifi_get_active_data_rates(struct nxpwifi_private *priv, u8 *rates)
+{
+	if (!priv->media_connected)
+		return nxpwifi_get_supported_rates(priv, rates);
+	else
+		return nxpwifi_copy_rates(rates, 0,
+					  priv->curr_bss_params.data_rates,
+					  priv->curr_bss_params.num_of_rates);
+}
+
+/* Find Channel/Frequency/Power by band and channel or frequency. */
+struct nxpwifi_chan_freq_power *
+nxpwifi_get_cfp(struct nxpwifi_private *priv, u8 band, u16 channel, u32 freq)
+{
+	struct nxpwifi_chan_freq_power *cfp = NULL;
+	struct ieee80211_supported_band *sband;
+	struct ieee80211_channel *ch = NULL;
+	int i;
+
+	if (!channel && !freq)
+		return cfp;
+
+	if (nxpwifi_band_to_radio_type(band) == HOST_SCAN_RADIO_TYPE_BG)
+		sband = priv->wdev.wiphy->bands[NL80211_BAND_2GHZ];
+	else
+		sband = priv->wdev.wiphy->bands[NL80211_BAND_5GHZ];
+
+	if (!sband) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "%s: cannot find cfp by band %d\n",
+			    __func__, band);
+		return cfp;
+	}
+
+	for (i = 0; i < sband->n_channels; i++) {
+		ch = &sband->channels[i];
+
+		if (ch->flags & IEEE80211_CHAN_DISABLED)
+			continue;
+
+		if (freq) {
+			if (ch->center_freq == freq)
+				break;
+		} else {
+			/* Find by valid channel. */
+			if (ch->hw_value == channel ||
+			    channel == FIRST_VALID_CHANNEL)
+				break;
+		}
+	}
+	if (i == sband->n_channels) {
+		nxpwifi_dbg(priv->adapter, WARN,
+			    "%s: cannot find cfp by band %d\t"
+			    "& channel=%d freq=%d\n",
+			    __func__, band, channel, freq);
+	} else {
+		if (!ch)
+			return cfp;
+
+		priv->cfp.channel = ch->hw_value;
+		priv->cfp.freq = ch->center_freq;
+		priv->cfp.max_tx_power = ch->max_power;
+		cfp = &priv->cfp;
+	}
+
+	return cfp;
+}
+
+/* Return true if data rate is set to auto. */
+u8
+nxpwifi_is_rate_auto(struct nxpwifi_private *priv)
+{
+	u32 i;
+	int rate_num = 0;
+
+	for (i = 0; i < ARRAY_SIZE(priv->bitmap_rates); i++)
+		if (priv->bitmap_rates[i])
+			rate_num++;
+
+	if (rate_num > 1)
+		return true;
+	else
+		return false;
+}
+
+/* Extract supported rates from cfg80211_scan_request bitmask. */
+u32 nxpwifi_get_rates_from_cfg80211(struct nxpwifi_private *priv,
+				    u8 *rates, u8 radio_type)
+{
+	struct wiphy *wiphy = priv->adapter->wiphy;
+	struct cfg80211_scan_request *request = priv->scan_request;
+	u32 num_rates, rate_mask;
+	struct ieee80211_supported_band *sband;
+	int i;
+
+	if (radio_type) {
+		sband = wiphy->bands[NL80211_BAND_5GHZ];
+		if (WARN_ON_ONCE(!sband))
+			return 0;
+		rate_mask = request->rates[NL80211_BAND_5GHZ];
+	} else {
+		sband = wiphy->bands[NL80211_BAND_2GHZ];
+		if (WARN_ON_ONCE(!sband))
+			return 0;
+		rate_mask = request->rates[NL80211_BAND_2GHZ];
+	}
+
+	num_rates = 0;
+	for (i = 0; i < sband->n_bitrates; i++) {
+		if ((BIT(i) & rate_mask) == 0)
+			continue; /* skip rate */
+		rates[num_rates++] = (u8)(sband->bitrates[i].bitrate / 5);
+	}
+
+	return num_rates;
+}
+
+/* Convert config_bands to B/G/A band */
+static u16 nxpwifi_convert_config_bands(u16 config_bands)
+{
+	u16 bands = 0;
+
+	if (config_bands & BAND_B)
+		bands |= BAND_B;
+	if (config_bands & BAND_G || config_bands & BAND_GN ||
+	    config_bands & BAND_GAC || config_bands & BAND_GAX)
+		bands |= BAND_G;
+	if (config_bands & BAND_A || config_bands & BAND_AN ||
+	    config_bands & BAND_AAC || config_bands & BAND_AAX)
+		bands |= BAND_A;
+
+	return bands;
+}
+
+/* Get supported rates in infrastructure (STA/P2P client) mode. */
+u32 nxpwifi_get_supported_rates(struct nxpwifi_private *priv, u8 *rates)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u32 k = 0;
+	u16 bands = 0;
+
+	bands = nxpwifi_convert_config_bands(adapter->fw_bands);
+
+	if (priv->bss_mode == NL80211_IFTYPE_STATION) {
+		if (bands == BAND_B) {
+			/* B only */
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_b\n",
+				    priv->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_b,
+					       sizeof(supported_rates_b));
+		} else if (bands == BAND_G) {
+			/* G only */
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_g\n",
+				    priv->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_g,
+					       sizeof(supported_rates_g));
+		} else if (bands & (BAND_B | BAND_G)) {
+			/* BG only */
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_bg\n",
+				    priv->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_bg,
+					       sizeof(supported_rates_bg));
+		} else if (bands & BAND_A) {
+			/* support A */
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_a\n",
+				    priv->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_a,
+					       sizeof(supported_rates_a));
+		}
+	}
+
+	return k;
+}
+
+u8 nxpwifi_adjust_data_rate(struct nxpwifi_private *priv,
+			    u8 rx_rate, u8 rate_info)
+{
+	u8 rate_index = 0;
+
+	/* HT40 */
+	if ((rate_info & BIT(0)) && (rate_info & BIT(1)))
+		rate_index = NXPWIFI_RATE_INDEX_MCS0 +
+			     NXPWIFI_BW20_MCS_NUM + rx_rate;
+	else if (rate_info & BIT(0)) /* HT20 */
+		rate_index = NXPWIFI_RATE_INDEX_MCS0 + rx_rate;
+	else
+		rate_index = (rx_rate > NXPWIFI_RATE_INDEX_OFDM0) ?
+			      rx_rate - 1 : rx_rate;
+
+	if (rate_index >= NXPWIFI_MAX_AC_RX_RATES)
+		rate_index = NXPWIFI_MAX_AC_RX_RATES - 1;
+
+	return rate_index;
+}
-- 
2.34.1


