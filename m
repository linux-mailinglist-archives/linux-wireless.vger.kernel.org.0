Return-Path: <linux-wireless+bounces-32532-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qE3jNX2ZqWm7AgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32532-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:55:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEAF213EE3
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F8B33054107
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 14:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2243AA1A4;
	Thu,  5 Mar 2026 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AkSWKfur"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010033.outbound.protection.outlook.com [52.101.84.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004AB3AE1AC;
	Thu,  5 Mar 2026 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721749; cv=fail; b=JWcdTMZCBE8IAT1joPM/iWHa6eIk8RHiMTC72agi8hOWmikNhufYPflKtsBqU4PNzPRvkPMSbCOMSTZwhS0zHZwWepf7RvhITNxoAzMDKC+za+S3RJo2q8Ey6XHRnIJA2lckc4wjTPjJSLKZc5RiJJkpcRDiSWcEp0rVGtne9lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721749; c=relaxed/simple;
	bh=aFiSuG/FUzO0G2LtDdCf3TITnKnHOz1a3Aq+PSCgiKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qbOK5bG3gA9+L/Pm4qHPDnUB6X5oSROgbqLHPujAmGUi9TkCQxbIfzO8fHYvuBVoBQiSVmWw9GLPzbx/FQU37dGsgZsFzelzaff9i6LQLNkM3gPFdgkHlZCsKGlCwhCv4OTgswJLIyEh862y2ZNDY3EKwKgKT/iT6+svFKm6c/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AkSWKfur; arc=fail smtp.client-ip=52.101.84.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTXiJheqfycrsVDXnK1XeI2xgDzEI6t6aPok0/cVk3x6tZrvQid+iqZXo59dHeGo8GNLxcKAp86+JMv3gDUftkdn+dRRST7yJFsDEYiis1UCucD6p2/q40txEPl1mZ/npTx/zhZDB0Ik/EEPOHq/nmYpNGrLLbYBuuOyejz1vDRUwHLopZ114QwwVi/CjRsm9W0NOFzmeM86tizVqA5/cdzrjLMG+3NT1IYBu0wUIpxT/qLYvb4UtFEvCHtWR1GckN6BASqTFoe8/0DDLHhWxgvW+maaTYjGK/iEdyRlxqUk5tqN1c/NzkGMQLP0rujksUz3aVdrtQVi+qUf1e2LBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6iIEvf7J4jh4Vkvd6iJvOwUg6tILeDlU2W/xM0/LXw=;
 b=mNQcXJVIrjV737hQyV69wLBN2pPNwK//qkTFEwEhSsuL+mf8yY3s026j7YqfsihPBb+5VgCPQKMDd560U/HUGdkSzlTAMLkYiM3SKqx0olZLF9EyZdT8Uf0/AEftopkXIsI9S1/UDbs5pu1RS5vVNRjKZCWHMB1xffUD+gr5pT7+SG+FPera98RJF8nD1PtLMw1zMycXAGlqMHSA5PAGQA69JUqpbG73N85eun+e06HY4xUklrP3aWC2/ovta1P/n+5JQg3nxMhHJI6k01ahyxu76CuhYmi2lp9UHs7OHXYZDj6jCi2UGrltSDQSLgrGOSnka74++udy1bcwfEW+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6iIEvf7J4jh4Vkvd6iJvOwUg6tILeDlU2W/xM0/LXw=;
 b=AkSWKfurgk89hZHZDJVVo2lX2VL+/qEswwkrN3uRX8IAXEP3Xe/kclEmVsqDB4zvVj6nrbRko8APpCDiJRhAnJSjJcIVEmMQ2aFbjTHXwBcdmpSezSC5/jW3rCs4I+ndx/3tI/NmqVAyq361bn2sYQUlnF3xcPz6JL3Q1leFuprOdrMRwovkPBzxeAOj96p+irwxFSbtBt/3gkgTyUpNVpYH4TE/YDevwV6jjiJPft/hvdU6UMWyW5W+gPyL4QeXSrJOv7II6Tcx3nzPFLj5eePVTvQbxkNN5WZy5IxEh5YBU8qSqrV9eoOsodwFrXodaaw0Vs8qx1ISTpsEWQ9aww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by VI2PR04MB10145.eurprd04.prod.outlook.com (2603:10a6:800:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 14:42:23 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 14:42:23 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v10 13/21] wifi: nxpwifi: add data path support for STA and AP modes
Date: Thu,  5 Mar 2026 22:39:31 +0800
Message-Id: <20260305143939.3724868-14-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305143939.3724868-1-jeff.chen_1@nxp.com>
References: <20260305143939.3724868-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::9) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|VI2PR04MB10145:EE_
X-MS-Office365-Filtering-Correlation-Id: ed8f7279-213c-4967-db0f-08de7ac56954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	wpnk4fcHRXoBKHvwzHoruaNN+iQP5qO/e2rVnLbUAHJMxNOss+MqSVVTA5EdmswC7AI0X6dTZJlPtwxu0Nefct6g65sIUK0OtIO+/t/4dc5DGMQzcxxXfreq2qIxqh0GkcIx3ZFoxYgxj3LzMMS0IWp580q84oPwqQBTs1OFFXT6mfqDdUaGSby2kAqJ9DZXjYDaCwlv6out0j6zi1Hg/cOTQhc0euFxOI2fLi0+HKv/PT6aQ3JXP/2EahO4Zz7JoMt3c4S228bf0zRd6OFJzZSrFzvLtlHKrVUjpuGVx3fE9KP4LI4K9NkMEyyJRHaQgIAZBMlCTU/J3mzOwSQS90G4RALUm4FCRXkCVI5gV3Yc2Xh9e0qsXp98TPbTZvkQmfOxiB6rC6t2FydoLVuFtK9eOG5cVOWBFZ9jTffaw2nSEM8RmcO9Uzohu0dT2zO6PkRqP0Y6y+EvsN6N/onVHTY8iz1DcdERV+6H8Bz6QhZI02KT+zm4P3Lprt3yn9EzgyzOxcatqk0SSx/oARgWYY/7U/Ci1laXjrFRaVG0GtdYVObcT84rNrdvvaib7W6xe5E8W9L0SBbfph6vrICjCZc3L4QrBqFKYolFgxgiwCFIYhU/Ef86AafplZT4u+hBPM1jxfJUGrSBExN8MI8x0p0UDsoit43bz/9eK9nYRYp3WrdiV76UjYtnWvdAc6ssIaWxVAZyq62igL7/FlaAx8esc8cPOsiWBQSIeEhokQLTUWK/j5nOO2K3anqw6r6Ui7z3a3ADkjIyJ6+n/GX6JKWClelm9HG+/fsTY3c9ADI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vHoTzhExKp+0qPdmSgSJV1mUtoXWDBJ2OAbfXUbxA+7x2fQUODVaKM4JBA2B?=
 =?us-ascii?Q?6y2wsiMms8MIGAEV61l5BioyWwzmt0yJAHeWSOVJBxwXh0SU7xl2L0GfGV4v?=
 =?us-ascii?Q?uAfSyknoY7AQO8lImkMFZCKz1yMF1XvQQTYsAXPRM7l312NasISiimU70OX6?=
 =?us-ascii?Q?4LfnOZAJFRKFO7RFH/ok/FpKcIVHLCJWuT/ErNAIZfPoN9VfAq1bOwEn99ik?=
 =?us-ascii?Q?ldH4wPyXvynWAlAw+M0jN66aHqah7W7rTUtXuFhGXTFxhFRqPaU7jphyf/h7?=
 =?us-ascii?Q?tFGEXrU31+SUEIdtAgC0Cb7nRZ0iymGXjfIPJm2OhWFvII6SoNUpz20Tqxsp?=
 =?us-ascii?Q?5xSsVkVNthDe73ILEQCQiBqE4rZ8C/v9BVtBBHTSijWzXAmid5iqI0NFpwdh?=
 =?us-ascii?Q?4HzIODOLkmSmktBm2n6rXMhD8xgJefafIuc4baMFdKY5EgkrvZN7uWJC4XZF?=
 =?us-ascii?Q?kpScx80YAEy2FvXm4PUHdEvldpZ5tDWpTzuj//uuUSoKdAsirDVQP6FpHvu2?=
 =?us-ascii?Q?8ZdzPiOw+W6g9THjDi8BjQlBlCtPA+NrTUINANNemx/6gsFbakU+pRPp4GAb?=
 =?us-ascii?Q?yWSh/7Zk1hOP7Usk234iYRPtQnzdi1snjxr/fnuVFLDLxS5IPlqYWFGd4tzc?=
 =?us-ascii?Q?V5dhdFJHa54dEASX6b/hDp0fgMBKu6tpqLfr9AtDPUE1eNt7tcY1VQW/Ofvd?=
 =?us-ascii?Q?g+bpOv8mCS8aCsr79ejA7zFiZ2j27FZQwYIL0dMQbncTihkqdYN3OoHhCB1A?=
 =?us-ascii?Q?IHP2IyJ8ueFwtNGSSVBwa/zbW4BCPjFQ2egcCHlISNIUJdLeF92yYpZaJ3ne?=
 =?us-ascii?Q?XqYjwK8Z7ca8ZZ9PXPrq3fvoVYaLEfW/Hi2WapPgCEIaV+95653zff4+oKOy?=
 =?us-ascii?Q?s5Rb12IeSHGexrFsfG4MQyxBG0Bpdrbn1/Z3CPIylcy9/HBDGrzcz/yu75Uf?=
 =?us-ascii?Q?hRHNHZp98bJ0S7qKBMgJSO5C+WV1QRwi4lmg7KZla/97EiwP3PPJqWoVttQ/?=
 =?us-ascii?Q?P37JPRNgDjalP9aFITUsbxLFc5WpnlZJQ9dBV31Z9KzlV5K7VSimPfyHXAP+?=
 =?us-ascii?Q?xCThBqnRq887+wumk+hXQi1CQkfQVI1UPMEt0vsXUNonJGf54X12f9sHIk4x?=
 =?us-ascii?Q?yinbd72CETRahfW3IBVN922ROpqiRG5Q+ge/S+a3dJ/BlJpbJExfTeCu4ZQN?=
 =?us-ascii?Q?5T5q3szK9jipWgG7y+6/rflq2tb2oObNoNF4QtMgzYnWnso8mpLOwweD7tLX?=
 =?us-ascii?Q?21MATvb1vsRisbW9pbhuquejMFTpumH68tPxE36gdHALsitIuXraY/JfLziA?=
 =?us-ascii?Q?JmhHW9NMhR4pC7zl9StEQGTxwoXqDrZLI0gheVo0MmD9eMN0Ct0JCz+ovtbk?=
 =?us-ascii?Q?cfBu0Glr8GSE4VSe+JQBXErNBRo6r5NRCMssLXkbcwrviubMOv0gL/ICApOX?=
 =?us-ascii?Q?Mjgi41UOFMuiqBGZ4b7NbDarWn/sx/M4t/BQEvIg6HH/dM9pmnVu5Ut5fZ5P?=
 =?us-ascii?Q?U/86Z/4uiWj3olu0SXZXgXFogKMphznu685aZN7sknyvgJebOPh/1Cd2g0MC?=
 =?us-ascii?Q?7APWiwrzTZL9Us6WsVh8BgM8xyhKR3+WoriWzPqL0SgKKkKKeU1XEvwldNvY?=
 =?us-ascii?Q?4qVFNgioZM85y3K/PSWaxDPkKMOyp65O3RQzfA1T3iK1scc7i2XRwQiPUYhC?=
 =?us-ascii?Q?OxPKIZc58BU10SRpnfRaS2xdeCxQBv5kJoEm0ZgALtvuegOdkkYpcYJvzI5a?=
 =?us-ascii?Q?8W/YjVWu3w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8f7279-213c-4967-db0f-08de7ac56954
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 14:42:22.9499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJkAzMvIo0+JB/2YjxcxpKH9TtmiOlRtB2buxvwae3o/KBj886rPzHh6BBox9N4XiKyN+GqNX1TRyDC1PJxy6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10145
X-Rspamd-Queue-Id: 9CEAF213EE3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32532-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add the data path implementation for both station and AP roles, including
transmit and receive handling across multiple modules.

Add sta_rx.c for station receive processing, including frame conversion,
RxPD handling, alignment adjustments, WMM priority evaluation, and 11n
reorder support.

Add sta_tx.c for station transmit processing, including TxPD preparation,
NULL data frame handling, and integration with firmware status reporting.

Add uap_txrx.c for AP-mode transmit and receive logic, including bridged
packet forwarding, STA-specific queuing, and AP-side packet dispatch.

Add txrx.c for common TX/RX routines shared by all roles.

Provide support for Ethernet frame reconstruction from 802.11 headers,
TX/RX descriptor handling, WMM prioritization, bridging in AP mode, and
completion callbacks for transmit status reporting.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/sta_rx.c   | 242 ++++++++++
 drivers/net/wireless/nxp/nxpwifi/sta_tx.c   | 190 ++++++++
 drivers/net/wireless/nxp/nxpwifi/txrx.c     | 352 ++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c | 478 ++++++++++++++++++++
 4 files changed, 1262 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_rx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_tx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/txrx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/sta_rx.c b/drivers/net/wireless/nxp/nxpwifi/sta_rx.c
new file mode 100644
index 000000000000..d3864cc8a785
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/sta_rx.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: station RX data handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include <uapi/linux/ipv6.h>
+#include <net/ndisc.h>
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "11n_aggr.h"
+#include "11n_rxreorder.h"
+
+/*
+ * Drop gratuitous IPv4 ARP and IPv6 neighbour advertisements when
+ * source and destination addresses are identical.
+ */
+static bool
+nxpwifi_discard_gratuitous_arp(struct nxpwifi_private *priv,
+			       struct sk_buff *skb)
+{
+	const struct nxpwifi_arp_eth_header *arp;
+	struct ethhdr *eth;
+	struct ipv6hdr *ipv6;
+	struct icmp6hdr *icmpv6;
+
+	eth = (struct ethhdr *)skb->data;
+	switch (ntohs(eth->h_proto)) {
+	case ETH_P_ARP:
+		arp = (void *)(skb->data + sizeof(struct ethhdr));
+		if (arp->hdr.ar_op == htons(ARPOP_REPLY) ||
+		    arp->hdr.ar_op == htons(ARPOP_REQUEST)) {
+			if (!memcmp(arp->ar_sip, arp->ar_tip, 4))
+				return true;
+		}
+		break;
+	case ETH_P_IPV6:
+		ipv6 = (void *)(skb->data + sizeof(struct ethhdr));
+		icmpv6 = (void *)(skb->data + sizeof(struct ethhdr) +
+				  sizeof(struct ipv6hdr));
+		if (icmpv6->icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT) {
+			if (!memcmp(&ipv6->saddr, &ipv6->daddr,
+				    sizeof(struct in6_addr)))
+				return true;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+/*
+ * Process a received data packet.
+ * Convert 802.2/LLC/SNAP to Ethernet II when appropriate, trim the
+ * rxpd and extra headers, optionally drop gratuitous ARP/NA, cache
+ * RX rate for unicast, then deliver to the stack.
+ */
+int nxpwifi_process_rx_packet(struct nxpwifi_private *priv,
+			      struct sk_buff *skb)
+{
+	int ret;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	struct rxpd *local_rx_pd;
+	int hdr_chop;
+	struct ethhdr *eth;
+	u16 rx_pkt_off;
+	u8 adj_rx_rate = 0;
+
+	local_rx_pd = (struct rxpd *)(skb->data);
+
+	rx_pkt_off = le16_to_cpu(local_rx_pd->rx_pkt_offset);
+	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_off;
+
+	if (sizeof(rx_pkt_hdr->eth803_hdr) + sizeof(rfc1042_header) +
+	    rx_pkt_off > skb->len) {
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return -EINVAL;
+	}
+
+	if (sizeof(*rx_pkt_hdr) + rx_pkt_off <= skb->len &&
+	    ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
+		      sizeof(bridge_tunnel_header))) ||
+	     (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
+		      sizeof(rfc1042_header)) &&
+	      rx_pkt_hdr->rfc1042_hdr.snap_type != htons(ETH_P_AARP) &&
+	      rx_pkt_hdr->rfc1042_hdr.snap_type != htons(ETH_P_IPX)))) {
+		/*
+		 * Replace the 803 header and rfc1042 header (llc/snap) with an
+		 *    EthernetII header, keep the src/dst and snap_type
+		 *    (ethertype).
+		 *  The firmware only passes up SNAP frames converting
+		 *    all RX Data from 802.11 to 802.2/LLC/SNAP frames.
+		 *  To create the Ethernet II, just move the src, dst address
+		 *    right before the snap_type.
+		 */
+		eth = (struct ethhdr *)
+			((u8 *)&rx_pkt_hdr->eth803_hdr
+			 + sizeof(rx_pkt_hdr->eth803_hdr) +
+			 sizeof(rx_pkt_hdr->rfc1042_hdr)
+			 - sizeof(rx_pkt_hdr->eth803_hdr.h_dest)
+			 - sizeof(rx_pkt_hdr->eth803_hdr.h_source)
+			 - sizeof(rx_pkt_hdr->rfc1042_hdr.snap_type));
+
+		memcpy(eth->h_source, rx_pkt_hdr->eth803_hdr.h_source,
+		       sizeof(eth->h_source));
+		memcpy(eth->h_dest, rx_pkt_hdr->eth803_hdr.h_dest,
+		       sizeof(eth->h_dest));
+
+		/*
+		 * Chop off the rxpd + the excess memory from the 802.2/llc/snap
+		 * header that was removed.
+		 */
+		hdr_chop = (u8 *)eth - (u8 *)local_rx_pd;
+	} else {
+		/* Chop off the rxpd */
+		hdr_chop = (u8 *)&rx_pkt_hdr->eth803_hdr - (u8 *)local_rx_pd;
+	}
+
+	/*
+	 * Chop off the leading header bytes so the it points to the start of
+	 * either the reconstructed EthII frame or the 802.2/llc/snap frame
+	 */
+	skb_pull(skb, hdr_chop);
+
+	if (priv->hs2_enabled &&
+	    nxpwifi_discard_gratuitous_arp(priv, skb)) {
+		nxpwifi_dbg(priv->adapter, INFO, "Bypassed Gratuitous ARP\n");
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
+	/* Only stash RX bitrate for unicast packets. */
+	if (likely(!is_multicast_ether_addr(rx_pkt_hdr->eth803_hdr.h_dest))) {
+		priv->rxpd_rate = local_rx_pd->rx_rate;
+		priv->rxpd_htinfo = local_rx_pd->ht_info;
+	}
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA ||
+	    GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) {
+		adj_rx_rate = nxpwifi_adjust_data_rate(priv,
+						       local_rx_pd->rx_rate,
+						       local_rx_pd->ht_info);
+		nxpwifi_hist_data_add(priv, adj_rx_rate, local_rx_pd->snr,
+				      local_rx_pd->nf);
+	}
+
+	ret = nxpwifi_recv_packet(priv, skb);
+	if (ret)
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "recv packet failed\n");
+
+	return ret;
+}
+
+/*
+ * Process a received buffer on the STA path.
+ * Validate RxPD and lengths, handle monitor/mgmt frames, fast-path
+ * non-unicast frames, and feed unicast data into 11n reorder/BA logic.
+ */
+int nxpwifi_process_sta_rx_packet(struct nxpwifi_private *priv,
+				  struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int ret = 0;
+	struct rxpd *local_rx_pd;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	u8 ta[ETH_ALEN];
+	u16 rx_pkt_type, rx_pkt_offset, rx_pkt_length, seq_num;
+
+	local_rx_pd = (struct rxpd *)(skb->data);
+	rx_pkt_type = le16_to_cpu(local_rx_pd->rx_pkt_type);
+	rx_pkt_offset = le16_to_cpu(local_rx_pd->rx_pkt_offset);
+	rx_pkt_length = le16_to_cpu(local_rx_pd->rx_pkt_length);
+	seq_num = le16_to_cpu(local_rx_pd->seq_num);
+
+	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_offset;
+
+	if ((rx_pkt_offset + rx_pkt_length) > skb->len ||
+	    sizeof(rx_pkt_hdr->eth803_hdr) + rx_pkt_offset > skb->len) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "wrong rx packet: len=%d, rx_pkt_offset=%d, rx_pkt_length=%d\n",
+			    skb->len, rx_pkt_offset, rx_pkt_length);
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return ret;
+	}
+
+	if (priv->adapter->enable_net_mon && rx_pkt_type == PKT_TYPE_802DOT11) {
+		ret = nxpwifi_recv_packet_to_monif(priv, skb);
+		if (ret)
+			dev_kfree_skb_any(skb);
+		return ret;
+	}
+
+	if (rx_pkt_type == PKT_TYPE_MGMT) {
+		ret = nxpwifi_process_mgmt_packet(priv, skb);
+		if (ret && (ret != -EINPROGRESS))
+			nxpwifi_dbg(adapter, DATA, "Rx of mgmt packet failed");
+		if (ret != -EINPROGRESS)
+			dev_kfree_skb_any(skb);
+		return ret;
+	}
+
+	/*
+	 * If the packet is not an unicast packet then send the packet
+	 * directly to os. Don't pass thru rx reordering
+	 */
+	if (!IS_11N_ENABLED(priv) ||
+	    !ether_addr_equal_unaligned(priv->curr_addr,
+					rx_pkt_hdr->eth803_hdr.h_dest)) {
+		nxpwifi_process_rx_packet(priv, skb);
+		return ret;
+	}
+
+	if (nxpwifi_queuing_ra_based(priv)) {
+		memcpy(ta, rx_pkt_hdr->eth803_hdr.h_source, ETH_ALEN);
+	} else {
+		if (rx_pkt_type != PKT_TYPE_BAR &&
+		    local_rx_pd->priority < MAX_NUM_TID)
+			priv->rx_seq[local_rx_pd->priority] = seq_num;
+		memcpy(ta, priv->curr_bss_params.bss_descriptor.mac_address,
+		       ETH_ALEN);
+	}
+
+	/* Reorder and send to OS */
+	ret = nxpwifi_11n_rx_reorder_pkt(priv, seq_num, local_rx_pd->priority,
+					 ta, (u8)rx_pkt_type, skb);
+
+	if (ret || rx_pkt_type == PKT_TYPE_BAR)
+		dev_kfree_skb_any(skb);
+
+	if (ret)
+		priv->stats.rx_dropped++;
+
+	return ret;
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/sta_tx.c b/drivers/net/wireless/nxp/nxpwifi/sta_tx.c
new file mode 100644
index 000000000000..835131f66440
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/sta_tx.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: station TX data handling
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
+
+/*
+ * Fill TxPD for TX packets by inserting it before payload and setting required fields.
+ */
+void nxpwifi_process_sta_txpd(struct nxpwifi_private *priv,
+			      struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct txpd *local_tx_pd;
+	struct nxpwifi_txinfo *tx_info = NXPWIFI_SKB_TXCB(skb);
+	unsigned int pad;
+	u16 pkt_type, pkt_length, pkt_offset;
+	int hroom = adapter->intf_hdr_len;
+	u32 tx_control;
+
+	pkt_type = nxpwifi_is_skb_mgmt_frame(skb) ? PKT_TYPE_MGMT : 0;
+
+	pad = ((uintptr_t)skb->data - (sizeof(*local_tx_pd) + hroom)) &
+	       (NXPWIFI_DMA_ALIGN_SZ - 1);
+	skb_push(skb, sizeof(*local_tx_pd) + pad);
+
+	local_tx_pd = (struct txpd *)skb->data;
+	memset(local_tx_pd, 0, sizeof(struct txpd));
+	local_tx_pd->bss_num = priv->bss_num;
+	local_tx_pd->bss_type = priv->bss_type;
+
+	pkt_length = (u16)(skb->len - (sizeof(struct txpd) + pad));
+	if (pkt_type == PKT_TYPE_MGMT)
+		pkt_length -= NXPWIFI_MGMT_FRAME_HEADER_SIZE;
+	local_tx_pd->tx_pkt_length = cpu_to_le16(pkt_length);
+
+	local_tx_pd->priority = (u8)skb->priority;
+	local_tx_pd->pkt_delay_2ms =
+				nxpwifi_wmm_compute_drv_pkt_delay(priv, skb);
+
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_EAPOL_TX_STATUS ||
+	    tx_info->flags & NXPWIFI_BUF_FLAG_ACTION_TX_STATUS) {
+		local_tx_pd->tx_token_id = tx_info->ack_frame_id;
+		local_tx_pd->flags |= NXPWIFI_TXPD_FLAGS_REQ_TX_STATUS;
+	}
+
+	if (local_tx_pd->priority <
+	    ARRAY_SIZE(priv->wmm.user_pri_pkt_tx_ctrl)) {
+		/*
+		 * Set the priority specific tx_control field, setting of 0 will
+		 *   cause the default value to be used later in this function
+		 */
+		tx_control =
+			priv->wmm.user_pri_pkt_tx_ctrl[local_tx_pd->priority];
+		local_tx_pd->tx_control = cpu_to_le32(tx_control);
+	}
+
+	if (adapter->pps_uapsd_mode) {
+		if (nxpwifi_check_last_packet_indication(priv)) {
+			adapter->tx_lock_flag = true;
+			local_tx_pd->flags =
+				NXPWIFI_TxPD_POWER_MGMT_LAST_PACKET;
+		}
+	}
+
+	/* Offset of actual data */
+	pkt_offset = sizeof(struct txpd) + pad;
+	if (pkt_type == PKT_TYPE_MGMT) {
+		/* Set the packet type and add header for management frame */
+		local_tx_pd->tx_pkt_type = cpu_to_le16(pkt_type);
+		pkt_offset += NXPWIFI_MGMT_FRAME_HEADER_SIZE;
+	}
+
+	local_tx_pd->tx_pkt_offset = cpu_to_le16(pkt_offset);
+
+	/* make space for adapter->intf_hdr_len */
+	skb_push(skb, hroom);
+
+	if (!local_tx_pd->tx_control)
+		/* TxCtrl set by user or default */
+		local_tx_pd->tx_control = cpu_to_le32(priv->pkt_tx_ctrl);
+}
+
+/* Send a NULL-data frame with TxPD at highest priority. */
+int nxpwifi_send_null_packet(struct nxpwifi_private *priv, u8 flags)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct txpd *local_tx_pd;
+	struct nxpwifi_tx_param tx_param;
+/* sizeof(struct txpd) + Interface specific header */
+#define NULL_PACKET_HDR 64
+	u32 data_len = NULL_PACKET_HDR;
+	struct sk_buff *skb;
+	int ret;
+	struct nxpwifi_txinfo *tx_info = NULL;
+
+	if (test_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags))
+		return -EPERM;
+
+	if (!priv->media_connected)
+		return -EPERM;
+
+	if (adapter->data_sent)
+		return -EBUSY;
+
+	skb = dev_alloc_skb(data_len);
+	if (!skb)
+		return -ENOMEM;
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	memset(tx_info, 0, sizeof(*tx_info));
+	tx_info->bss_num = priv->bss_num;
+	tx_info->bss_type = priv->bss_type;
+	tx_info->pkt_len = data_len -
+			(sizeof(struct txpd) + adapter->intf_hdr_len);
+	skb_reserve(skb, sizeof(struct txpd) + adapter->intf_hdr_len);
+	skb_push(skb, sizeof(struct txpd));
+
+	local_tx_pd = (struct txpd *)skb->data;
+	local_tx_pd->tx_control = cpu_to_le32(priv->pkt_tx_ctrl);
+	local_tx_pd->flags = flags;
+	local_tx_pd->priority = WMM_HIGHEST_PRIORITY;
+	local_tx_pd->tx_pkt_offset = cpu_to_le16(sizeof(struct txpd));
+	local_tx_pd->bss_num = priv->bss_num;
+	local_tx_pd->bss_type = priv->bss_type;
+
+	skb_push(skb, adapter->intf_hdr_len);
+	tx_param.next_pkt_len = 0;
+	ret = adapter->if_ops.host_to_card(adapter, NXPWIFI_TYPE_DATA,
+					   skb, &tx_param);
+
+	switch (ret) {
+	case -EBUSY:
+		dev_kfree_skb_any(skb);
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: host_to_card failed: ret=%d\n",
+			    __func__, ret);
+		adapter->dbg.num_tx_host_to_card_failure++;
+		break;
+	case 0:
+		dev_kfree_skb_any(skb);
+		nxpwifi_dbg(adapter, DATA,
+			    "data: %s: host_to_card succeeded\n",
+			    __func__);
+		adapter->tx_lock_flag = true;
+		break;
+	case -EINPROGRESS:
+		adapter->tx_lock_flag = true;
+		break;
+	default:
+		dev_kfree_skb_any(skb);
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: host_to_card failed: ret=%d\n",
+			    __func__, ret);
+		adapter->dbg.num_tx_host_to_card_failure++;
+		break;
+	}
+
+	return ret;
+}
+
+/* Check whether a last-packet indication needs to be sent. */
+u8 nxpwifi_check_last_packet_indication(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u8 ret = false;
+
+	if (!adapter->sleep_period.period)
+		return ret;
+	if (nxpwifi_wmm_lists_empty(adapter))
+		ret = true;
+
+	if (ret && !adapter->cmd_sent && !adapter->curr_cmd &&
+	    !is_command_pending(adapter)) {
+		adapter->delay_null_pkt = false;
+		ret = true;
+	} else {
+		ret = false;
+		adapter->delay_null_pkt = true;
+	}
+	return ret;
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/txrx.c b/drivers/net/wireless/nxp/nxpwifi/txrx.c
new file mode 100644
index 000000000000..6e8b49138e57
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/txrx.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: generic TX/RX data handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "wmm.h"
+
+/*
+ * Parse the RxPD, select the target interface, and dispatch the packet for
+ * handling.
+ */
+int nxpwifi_handle_rx_packet(struct nxpwifi_adapter *adapter,
+			     struct sk_buff *skb)
+{
+	struct nxpwifi_private *priv =
+		nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY);
+	struct rxpd *local_rx_pd;
+	struct nxpwifi_rxinfo *rx_info = NXPWIFI_SKB_RXCB(skb);
+	int ret;
+
+	local_rx_pd = (struct rxpd *)(skb->data);
+	/* Get the BSS number from rxpd, get corresponding priv */
+	priv = nxpwifi_get_priv_by_id(adapter, local_rx_pd->bss_num &
+				      BSS_NUM_MASK, local_rx_pd->bss_type);
+	if (!priv)
+		priv = nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY);
+
+	if (!priv) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "data: priv not found. Drop RX packet\n");
+		dev_kfree_skb_any(skb);
+		return -EINVAL;
+	}
+
+	nxpwifi_dbg_dump(adapter, DAT_D, "rx pkt:", skb->data,
+			 min_t(size_t, skb->len, DEBUG_DUMP_DATA_MAX_LEN));
+
+	memset(rx_info, 0, sizeof(*rx_info));
+	rx_info->bss_num = priv->bss_num;
+	rx_info->bss_type = priv->bss_type;
+
+	if (priv->bss_role == NXPWIFI_BSS_ROLE_UAP)
+		ret = nxpwifi_process_uap_rx_packet(priv, skb);
+	else
+		ret = nxpwifi_process_sta_rx_packet(priv, skb);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_handle_rx_packet);
+
+/*
+ * Add TxPD, validate, send the packet to firmware, then run completion
+ * callback.
+ */
+int nxpwifi_process_tx(struct nxpwifi_private *priv, struct sk_buff *skb,
+		       struct nxpwifi_tx_param *tx_param)
+{
+	int hroom, ret;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct txpd *local_tx_pd = NULL;
+	struct nxpwifi_sta_node *dest_node;
+	struct ethhdr *hdr = (void *)skb->data;
+
+	if (unlikely(!skb->len ||
+		     skb_headroom(skb) < NXPWIFI_MIN_DATA_HEADER_LEN)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hroom = adapter->intf_hdr_len;
+
+	if (priv->bss_role == NXPWIFI_BSS_ROLE_UAP) {
+		rcu_read_lock();
+		dest_node = nxpwifi_get_sta_entry(priv, hdr->h_dest);
+		if (dest_node) {
+			dest_node->stats.tx_bytes += skb->len;
+			dest_node->stats.tx_packets++;
+		}
+		rcu_read_unlock();
+		nxpwifi_process_uap_txpd(priv, skb);
+	} else {
+		nxpwifi_process_sta_txpd(priv, skb);
+	}
+
+	if ((adapter->data_sent || adapter->tx_lock_flag)) {
+		skb_queue_tail(&adapter->tx_data_q, skb);
+		atomic_inc(&adapter->tx_queued);
+		return 0;
+	}
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA)
+		local_tx_pd = (struct txpd *)(skb->data + hroom);
+	ret = adapter->if_ops.host_to_card(adapter,
+					   NXPWIFI_TYPE_DATA,
+					   skb, tx_param);
+	nxpwifi_dbg_dump(adapter, DAT_D, "tx pkt:", skb->data,
+			 min_t(size_t, skb->len, DEBUG_DUMP_DATA_MAX_LEN));
+
+out:
+	switch (ret) {
+	case -ENOSR:
+		nxpwifi_dbg(adapter, DATA, "data: -ENOSR is returned\n");
+		break;
+	case -EBUSY:
+		if ((GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA) &&
+		    adapter->pps_uapsd_mode && adapter->tx_lock_flag) {
+			priv->adapter->tx_lock_flag = false;
+			if (local_tx_pd)
+				local_tx_pd->flags = 0;
+		}
+		nxpwifi_dbg(adapter, ERROR, "data: -EBUSY is returned\n");
+		break;
+	case -EINPROGRESS:
+		break;
+	case -EINVAL:
+		nxpwifi_dbg(adapter, ERROR,
+			    "malformed skb (length: %u, headroom: %u)\n",
+			    skb->len, skb_headroom(skb));
+		fallthrough;
+	case 0:
+		nxpwifi_write_data_complete(adapter, skb, 0, ret);
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "nxpwifi_write_data_async failed: 0x%X\n",
+			    ret);
+		adapter->dbg.num_tx_host_to_card_failure++;
+		nxpwifi_write_data_complete(adapter, skb, 0, ret);
+		break;
+	}
+
+	return ret;
+}
+
+static int nxpwifi_host_to_card(struct nxpwifi_adapter *adapter,
+				struct sk_buff *skb,
+				struct nxpwifi_tx_param *tx_param)
+{
+	struct txpd *local_tx_pd = NULL;
+	u8 *head_ptr = skb->data;
+	int ret = 0;
+	struct nxpwifi_private *priv;
+	struct nxpwifi_txinfo *tx_info;
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	priv = nxpwifi_get_priv_by_id(adapter, tx_info->bss_num,
+				      tx_info->bss_type);
+	if (!priv) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "data: priv not found. Drop TX packet\n");
+		adapter->dbg.num_tx_host_to_card_failure++;
+		nxpwifi_write_data_complete(adapter, skb, 0, 0);
+		return ret;
+	}
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA)
+		local_tx_pd = (struct txpd *)(head_ptr + adapter->intf_hdr_len);
+
+	ret = adapter->if_ops.host_to_card(adapter,
+					   NXPWIFI_TYPE_DATA,
+					   skb, tx_param);
+
+	switch (ret) {
+	case -ENOSR:
+		nxpwifi_dbg(adapter, ERROR, "data: -ENOSR is returned\n");
+		break;
+	case -EBUSY:
+		if ((GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA) &&
+		    adapter->pps_uapsd_mode &&
+		    adapter->tx_lock_flag) {
+			priv->adapter->tx_lock_flag = false;
+			if (local_tx_pd)
+				local_tx_pd->flags = 0;
+		}
+		skb_queue_head(&adapter->tx_data_q, skb);
+		if (tx_info->flags & NXPWIFI_BUF_FLAG_AGGR_PKT)
+			atomic_add(tx_info->aggr_num, &adapter->tx_queued);
+		else
+			atomic_inc(&adapter->tx_queued);
+		nxpwifi_dbg(adapter, ERROR, "data: -EBUSY is returned\n");
+		break;
+	case -EINPROGRESS:
+		break;
+	case 0:
+		nxpwifi_write_data_complete(adapter, skb, 0, ret);
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "nxpwifi_write_data_async failed: 0x%X\n", ret);
+		adapter->dbg.num_tx_host_to_card_failure++;
+		nxpwifi_write_data_complete(adapter, skb, 0, ret);
+		break;
+	}
+	return ret;
+}
+
+static int
+nxpwifi_dequeue_tx_queue(struct nxpwifi_adapter *adapter)
+{
+	struct sk_buff *skb, *skb_next;
+	struct nxpwifi_txinfo *tx_info;
+	struct nxpwifi_tx_param tx_param;
+
+	skb = skb_dequeue(&adapter->tx_data_q);
+	if (!skb)
+		return -ENOMEM;
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_AGGR_PKT)
+		atomic_sub(tx_info->aggr_num, &adapter->tx_queued);
+	else
+		atomic_dec(&adapter->tx_queued);
+
+	if (!skb_queue_empty(&adapter->tx_data_q))
+		skb_next = skb_peek(&adapter->tx_data_q);
+	else
+		skb_next = NULL;
+	tx_param.next_pkt_len = ((skb_next) ? skb_next->len : 0);
+	if (!tx_param.next_pkt_len) {
+		if (!nxpwifi_wmm_lists_empty(adapter))
+			tx_param.next_pkt_len = 1;
+	}
+	return nxpwifi_host_to_card(adapter, skb, &tx_param);
+}
+
+void
+nxpwifi_process_tx_queue(struct nxpwifi_adapter *adapter)
+{
+	do {
+		if (adapter->data_sent || adapter->tx_lock_flag)
+			break;
+		if (nxpwifi_dequeue_tx_queue(adapter))
+			break;
+	} while (!skb_queue_empty(&adapter->tx_data_q));
+}
+
+/*
+ * Packet send completion callback handler.
+ *
+ * It either frees the buffer directly or forwards it to another
+ * completion callback which checks conditions, updates statistics,
+ * wakes up stalled traffic queue if required, and then frees the buffer.
+ */
+int nxpwifi_write_data_complete(struct nxpwifi_adapter *adapter,
+				struct sk_buff *skb, int aggr, int status)
+{
+	struct nxpwifi_private *priv;
+	struct nxpwifi_txinfo *tx_info;
+	struct netdev_queue *txq;
+	int index;
+
+	if (!skb)
+		return 0;
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	priv = nxpwifi_get_priv_by_id(adapter, tx_info->bss_num,
+				      tx_info->bss_type);
+	if (!priv)
+		goto done;
+
+	nxpwifi_set_trans_start(priv->netdev);
+
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_BRIDGED_PKT)
+		atomic_dec_return(&adapter->pending_bridged_pkts);
+
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_AGGR_PKT)
+		goto done;
+
+	if (!status) {
+		priv->stats.tx_packets++;
+		priv->stats.tx_bytes += tx_info->pkt_len;
+		if (priv->tx_timeout_cnt)
+			priv->tx_timeout_cnt = 0;
+	} else {
+		priv->stats.tx_errors++;
+	}
+
+	if (aggr)
+		/* For skb_aggr, do not wake up tx queue */
+		goto done;
+
+	atomic_dec(&adapter->tx_pending);
+
+	index = nxpwifi_1d_to_wmm_queue[skb->priority];
+	if (atomic_dec_return(&priv->wmm_tx_pending[index]) < LOW_TX_PENDING) {
+		txq = netdev_get_tx_queue(priv->netdev, index);
+		if (netif_tx_queue_stopped(txq)) {
+			netif_tx_wake_queue(txq);
+			nxpwifi_dbg(adapter, DATA, "wake queue: %d\n", index);
+		}
+	}
+done:
+	dev_kfree_skb_any(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_write_data_complete);
+
+void nxpwifi_parse_tx_status_event(struct nxpwifi_private *priv,
+				   void *event_body)
+{
+	struct tx_status_event *tx_status = (void *)priv->adapter->event_body;
+	struct sk_buff *ack_skb;
+	struct nxpwifi_txinfo *tx_info;
+
+	if (!tx_status->tx_token_id)
+		return;
+
+	spin_lock_bh(&priv->ack_status_lock);
+	ack_skb = xa_erase(&priv->ack_status_frames, tx_status->tx_token_id);
+	spin_unlock_bh(&priv->ack_status_lock);
+
+	if (ack_skb) {
+		tx_info = NXPWIFI_SKB_TXCB(ack_skb);
+
+		if (tx_info->flags & NXPWIFI_BUF_FLAG_EAPOL_TX_STATUS) {
+			/* consumes ack_skb */
+			skb_complete_wifi_ack(ack_skb, !tx_status->status);
+		} else {
+			/* Remove broadcast address which was added by driver */
+			memmove(ack_skb->data +
+				sizeof(struct ieee80211_hdr_3addr) +
+				NXPWIFI_MGMT_FRAME_HEADER_SIZE + sizeof(u16),
+				ack_skb->data +
+				sizeof(struct ieee80211_hdr_3addr) +
+				NXPWIFI_MGMT_FRAME_HEADER_SIZE + sizeof(u16) +
+				ETH_ALEN, ack_skb->len -
+				(sizeof(struct ieee80211_hdr_3addr) +
+				NXPWIFI_MGMT_FRAME_HEADER_SIZE + sizeof(u16) +
+				ETH_ALEN));
+			ack_skb->len = ack_skb->len - ETH_ALEN;
+			/*
+			 * Remove driver's proprietary header including 2 bytes
+			 * of packet length and pass actual management frame buffer
+			 * to cfg80211.
+			 */
+			cfg80211_mgmt_tx_status(&priv->wdev, tx_info->cookie,
+						ack_skb->data +
+						NXPWIFI_MGMT_FRAME_HEADER_SIZE +
+						sizeof(u16), ack_skb->len -
+						(NXPWIFI_MGMT_FRAME_HEADER_SIZE
+						 + sizeof(u16)),
+						!tx_status->status, GFP_ATOMIC);
+			dev_kfree_skb_any(ack_skb);
+		}
+	}
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/uap_txrx.c b/drivers/net/wireless/nxp/nxpwifi/uap_txrx.c
new file mode 100644
index 000000000000..f3d24bf861ca
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/uap_txrx.c
@@ -0,0 +1,478 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: AP TX and RX data handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "main.h"
+#include "wmm.h"
+#include "11n_aggr.h"
+#include "11n_rxreorder.h"
+
+/*
+ * Drop bridged pkts from RA list until pending <= low threshold; return true if
+ * any.
+ */
+static bool
+nxpwifi_uap_del_tx_pkts_in_ralist(struct nxpwifi_private *priv,
+				  struct list_head *ra_list_head,
+				  int tid)
+{
+	struct nxpwifi_ra_list_tbl *ra_list;
+	struct sk_buff *skb, *tmp;
+	bool pkt_deleted = false;
+	struct nxpwifi_txinfo *tx_info;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	list_for_each_entry(ra_list, ra_list_head, list) {
+		if (skb_queue_empty(&ra_list->skb_head))
+			continue;
+
+		skb_queue_walk_safe(&ra_list->skb_head, skb, tmp) {
+			tx_info = NXPWIFI_SKB_TXCB(skb);
+			if (tx_info->flags & NXPWIFI_BUF_FLAG_BRIDGED_PKT) {
+				__skb_unlink(skb, &ra_list->skb_head);
+				nxpwifi_write_data_complete(adapter, skb, 0,
+							    -1);
+				if (ra_list->tx_paused)
+					priv->wmm.pkts_paused[tid]--;
+				else
+					atomic_dec(&priv->wmm.tx_pkts_queued);
+				pkt_deleted = true;
+			}
+			if ((atomic_read(&adapter->pending_bridged_pkts) <=
+					     NXPWIFI_BRIDGED_PKTS_THR_LOW))
+				break;
+		}
+	}
+
+	return pkt_deleted;
+}
+
+/* Delete bridged pkts from one RA list; rotate index to keep fairness. */
+static void nxpwifi_uap_cleanup_tx_queues(struct nxpwifi_private *priv)
+{
+	struct list_head *ra_list;
+	int i;
+
+	spin_lock_bh(&priv->wmm.ra_list_spinlock);
+
+	for (i = 0; i < MAX_NUM_TID; i++, priv->del_list_idx++) {
+		if (priv->del_list_idx == MAX_NUM_TID)
+			priv->del_list_idx = 0;
+		ra_list = &priv->wmm.tid_tbl_ptr[priv->del_list_idx].ra_list;
+		if (nxpwifi_uap_del_tx_pkts_in_ralist(priv, ra_list, i)) {
+			priv->del_list_idx++;
+			break;
+		}
+	}
+
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+}
+
+static void
+nxpwifi_uap_queue_bridged_pkt(struct nxpwifi_private *priv,
+			      struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct uap_rxpd *uap_rx_pd;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	struct sk_buff *new_skb;
+	struct nxpwifi_txinfo *tx_info;
+	int hdr_chop;
+	struct ethhdr *p_ethhdr;
+	struct nxpwifi_sta_node *src_node;
+	int index;
+
+	uap_rx_pd = (struct uap_rxpd *)(skb->data);
+	rx_pkt_hdr = (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_offset);
+
+	if ((atomic_read(&adapter->pending_bridged_pkts) >=
+					     NXPWIFI_BRIDGED_PKTS_THR_HIGH)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "Tx: Bridge packet limit reached. Drop packet!\n");
+		kfree_skb(skb);
+		nxpwifi_uap_cleanup_tx_queues(priv);
+		return;
+	}
+
+	if (sizeof(*rx_pkt_hdr) +
+	    le16_to_cpu(uap_rx_pd->rx_pkt_offset) > skb->len) {
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return;
+	}
+
+	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
+		     sizeof(bridge_tunnel_header))) ||
+	    (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
+		     sizeof(rfc1042_header)) &&
+	     rx_pkt_hdr->rfc1042_hdr.snap_type != htons(ETH_P_AARP) &&
+	     rx_pkt_hdr->rfc1042_hdr.snap_type != htons(ETH_P_IPX))) {
+		/*
+		 * Replace the 803 header and rfc1042 header (llc/snap) with
+		 * an Ethernet II header, keep the src/dst and snap_type
+		 * (ethertype).
+		 *
+		 * The firmware only passes up SNAP frames converting all RX
+		 * data from 802.11 to 802.2/LLC/SNAP frames.
+		 *
+		 * To create the Ethernet II, just move the src, dst address
+		 * right before the snap_type.
+		 */
+		p_ethhdr = (struct ethhdr *)
+			((u8 *)(&rx_pkt_hdr->eth803_hdr)
+			 + sizeof(rx_pkt_hdr->eth803_hdr)
+			 + sizeof(rx_pkt_hdr->rfc1042_hdr)
+			 - sizeof(rx_pkt_hdr->eth803_hdr.h_dest)
+			 - sizeof(rx_pkt_hdr->eth803_hdr.h_source)
+			 - sizeof(rx_pkt_hdr->rfc1042_hdr.snap_type));
+		memcpy(p_ethhdr->h_source, rx_pkt_hdr->eth803_hdr.h_source,
+		       sizeof(p_ethhdr->h_source));
+		memcpy(p_ethhdr->h_dest, rx_pkt_hdr->eth803_hdr.h_dest,
+		       sizeof(p_ethhdr->h_dest));
+		/*
+		 * Chop off the rxpd + the excess memory from
+		 * 802.2/llc/snap header that was removed.
+		 */
+		hdr_chop = (u8 *)p_ethhdr - (u8 *)uap_rx_pd;
+	} else {
+		/* Chop off the rxpd */
+		hdr_chop = (u8 *)&rx_pkt_hdr->eth803_hdr - (u8 *)uap_rx_pd;
+	}
+
+	/*
+	 * Chop off the leading header bytes so that it points
+	 * to the start of either the reconstructed EthII frame
+	 * or the 802.2/llc/snap frame.
+	 */
+	skb_pull(skb, hdr_chop);
+
+	if (skb_headroom(skb) < NXPWIFI_MIN_DATA_HEADER_LEN) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "data: Tx: insufficient skb headroom %d\n",
+			    skb_headroom(skb));
+		/* Insufficient skb headroom - allocate a new skb */
+		new_skb =
+			skb_realloc_headroom(skb, NXPWIFI_MIN_DATA_HEADER_LEN);
+		if (unlikely(!new_skb)) {
+			nxpwifi_dbg(adapter, ERROR,
+				    "Tx: cannot allocate new_skb\n");
+			kfree_skb(skb);
+			priv->stats.tx_dropped++;
+			return;
+		}
+
+		kfree_skb(skb);
+		skb = new_skb;
+		nxpwifi_dbg(adapter, INFO,
+			    "info: new skb headroom %d\n",
+			    skb_headroom(skb));
+	}
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	memset(tx_info, 0, sizeof(*tx_info));
+	tx_info->bss_num = priv->bss_num;
+	tx_info->bss_type = priv->bss_type;
+	tx_info->flags |= NXPWIFI_BUF_FLAG_BRIDGED_PKT;
+
+	rcu_read_lock();
+	src_node = nxpwifi_get_sta_entry(priv, rx_pkt_hdr->eth803_hdr.h_source);
+	if (src_node) {
+		src_node->stats.last_rx = jiffies;
+		src_node->stats.rx_bytes += skb->len;
+		src_node->stats.rx_packets++;
+		src_node->stats.last_tx_rate = uap_rx_pd->rx_rate;
+		src_node->stats.last_tx_htinfo = uap_rx_pd->ht_info;
+	}
+	rcu_read_unlock();
+
+	if (is_unicast_ether_addr(rx_pkt_hdr->eth803_hdr.h_dest)) {
+		/*
+		 * Update bridge packet statistics as the
+		 * packet is not going to kernel/upper layer.
+		 */
+		priv->stats.rx_bytes += skb->len;
+		priv->stats.rx_packets++;
+
+		/*
+		 * Sending bridge packet to TX queue, so save the packet
+		 * length in TXCB to update statistics in TX complete.
+		 */
+		tx_info->pkt_len = skb->len;
+	}
+
+	__net_timestamp(skb);
+
+	index = nxpwifi_1d_to_wmm_queue[skb->priority];
+	atomic_inc(&priv->wmm_tx_pending[index]);
+	nxpwifi_wmm_add_buf_txqueue(priv, skb);
+	atomic_inc(&adapter->tx_pending);
+	atomic_inc(&adapter->pending_bridged_pkts);
+
+	nxpwifi_queue_work(adapter, &adapter->main_work);
+}
+
+/* AP fwd: mcast/bcast -> up + bridge; unicast -> bridge if RA assoc, else up. */
+int nxpwifi_handle_uap_rx_forward(struct nxpwifi_private *priv,
+				  struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct uap_rxpd *uap_rx_pd;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	u8 ra[ETH_ALEN];
+	struct sk_buff *skb_uap;
+	struct nxpwifi_sta_node *node;
+
+	uap_rx_pd = (struct uap_rxpd *)(skb->data);
+	rx_pkt_hdr = (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_offset);
+
+	/* don't do packet forwarding in disconnected state */
+	if (!priv->media_connected) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "drop packet in disconnected state.\n");
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
+	memcpy(ra, rx_pkt_hdr->eth803_hdr.h_dest, ETH_ALEN);
+
+	if (is_multicast_ether_addr(ra)) {
+		skb_uap = skb_copy(skb, GFP_ATOMIC);
+		if (likely(skb_uap)) {
+			nxpwifi_uap_queue_bridged_pkt(priv, skb_uap);
+		} else {
+			nxpwifi_dbg(adapter, ERROR,
+				    "failed to copy skb for uAP\n");
+				    priv->stats.rx_dropped++;
+				    dev_kfree_skb_any(skb);
+			return -ENOMEM;
+		}
+	} else {
+		node = nxpwifi_get_sta_entry_rcu(priv, ra);
+		if (node) {
+			/* Requeue Intra-BSS packet */
+			nxpwifi_uap_queue_bridged_pkt(priv, skb);
+			return 0;
+		}
+	}
+
+	/* Forward unicat/Inter-BSS packets to kernel. */
+	return nxpwifi_process_rx_packet(priv, skb);
+}
+
+int nxpwifi_uap_recv_packet(struct nxpwifi_private *priv,
+			    struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_sta_node *src_node, *dst_node;
+	struct ethhdr *p_ethhdr;
+	struct sk_buff *skb_uap;
+	struct nxpwifi_txinfo *tx_info;
+
+	if (!skb)
+		return -ENOMEM;
+
+	p_ethhdr = (void *)skb->data;
+	rcu_read_lock();
+	src_node = nxpwifi_get_sta_entry(priv, p_ethhdr->h_source);
+	if (src_node) {
+		src_node->stats.last_rx = jiffies;
+		src_node->stats.rx_bytes += skb->len;
+		src_node->stats.rx_packets++;
+	}
+	dst_node = nxpwifi_get_sta_entry(priv, p_ethhdr->h_dest);
+	rcu_read_unlock();
+
+	if (is_multicast_ether_addr(p_ethhdr->h_dest) || dst_node) {
+		if (skb_headroom(skb) < NXPWIFI_MIN_DATA_HEADER_LEN)
+			skb_uap =
+			skb_realloc_headroom(skb, NXPWIFI_MIN_DATA_HEADER_LEN);
+		else
+			skb_uap = skb_copy(skb, GFP_ATOMIC);
+
+		if (likely(skb_uap)) {
+			tx_info = NXPWIFI_SKB_TXCB(skb_uap);
+			memset(tx_info, 0, sizeof(*tx_info));
+			tx_info->bss_num = priv->bss_num;
+			tx_info->bss_type = priv->bss_type;
+			tx_info->flags |= NXPWIFI_BUF_FLAG_BRIDGED_PKT;
+			__net_timestamp(skb_uap);
+			nxpwifi_wmm_add_buf_txqueue(priv, skb_uap);
+			atomic_inc(&adapter->tx_pending);
+			atomic_inc(&adapter->pending_bridged_pkts);
+			if ((atomic_read(&adapter->pending_bridged_pkts) >=
+					NXPWIFI_BRIDGED_PKTS_THR_HIGH)) {
+				nxpwifi_dbg(adapter, ERROR,
+					    "Tx: Bridge packet limit reached. Drop packet!\n");
+				nxpwifi_uap_cleanup_tx_queues(priv);
+			}
+
+		} else {
+			nxpwifi_dbg(adapter, ERROR, "failed to allocate skb_uap");
+		}
+
+		nxpwifi_queue_work(adapter, &adapter->main_work);
+		/* Don't forward Intra-BSS unicast packet to upper layer*/
+
+		if (dst_node)
+			return 0;
+	}
+
+	skb->dev = priv->netdev;
+	skb->protocol = eth_type_trans(skb, priv->netdev);
+	skb->ip_summed = CHECKSUM_NONE;
+
+	/* Forward multicast/broadcast packet to upper layer*/
+	netif_rx(skb);
+	return 0;
+}
+
+/* Process AP RX: check RxPD/len, handle mgmt or 11n reorder/AMSDU, then forward. */
+int nxpwifi_process_uap_rx_packet(struct nxpwifi_private *priv,
+				  struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int ret;
+	struct uap_rxpd *uap_rx_pd;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	u16 rx_pkt_type;
+	u8 ta[ETH_ALEN], pkt_type;
+	struct nxpwifi_sta_node *node;
+
+	uap_rx_pd = (struct uap_rxpd *)(skb->data);
+	rx_pkt_type = le16_to_cpu(uap_rx_pd->rx_pkt_type);
+	rx_pkt_hdr = (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_offset);
+
+	if (le16_to_cpu(uap_rx_pd->rx_pkt_offset) +
+	    sizeof(rx_pkt_hdr->eth803_hdr) > skb->len) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "wrong rx packet for struct ethhdr: len=%d, offset=%d\n",
+			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset));
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
+	ether_addr_copy(ta, rx_pkt_hdr->eth803_hdr.h_source);
+
+	if ((le16_to_cpu(uap_rx_pd->rx_pkt_offset) +
+	     le16_to_cpu(uap_rx_pd->rx_pkt_length)) > (u16)skb->len) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "wrong rx packet: len=%d, offset=%d, length=%d\n",
+			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset),
+			    le16_to_cpu(uap_rx_pd->rx_pkt_length));
+		priv->stats.rx_dropped++;
+		rcu_read_lock();
+		node = nxpwifi_get_sta_entry(priv, ta);
+		if (node)
+			node->stats.tx_failed++;
+		rcu_read_unlock();
+
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
+	if (rx_pkt_type == PKT_TYPE_MGMT) {
+		ret = nxpwifi_process_mgmt_packet(priv, skb);
+		if (ret && (ret != -EINPROGRESS))
+			nxpwifi_dbg(adapter, DATA, "Rx of mgmt packet failed");
+		if (ret != -EINPROGRESS)
+			dev_kfree_skb_any(skb);
+		return ret;
+	}
+
+	if (rx_pkt_type != PKT_TYPE_BAR && uap_rx_pd->priority < MAX_NUM_TID) {
+		rcu_read_lock();
+		node = nxpwifi_get_sta_entry(priv, ta);
+		if (node)
+			node->rx_seq[uap_rx_pd->priority] =
+						le16_to_cpu(uap_rx_pd->seq_num);
+		rcu_read_unlock();
+	}
+
+	if (!priv->ap_11n_enabled ||
+	    (!nxpwifi_11n_get_rx_reorder_tbl(priv, uap_rx_pd->priority, ta) &&
+	    (le16_to_cpu(uap_rx_pd->rx_pkt_type) != PKT_TYPE_AMSDU))) {
+		ret = nxpwifi_handle_uap_rx_forward(priv, skb);
+		return ret;
+	}
+
+	/* Reorder and send to kernel */
+	pkt_type = (u8)le16_to_cpu(uap_rx_pd->rx_pkt_type);
+	ret = nxpwifi_11n_rx_reorder_pkt(priv, le16_to_cpu(uap_rx_pd->seq_num),
+					 uap_rx_pd->priority, ta, pkt_type, skb);
+
+	if (ret || rx_pkt_type == PKT_TYPE_BAR)
+		dev_kfree_skb_any(skb);
+
+	if (ret)
+		priv->stats.rx_dropped++;
+
+	return ret;
+}
+
+/*
+ * Build TxPD for AP TX: push aligned TxPD; set bss, len/off, prio, delay, txctl,
+ * flags.
+ */
+void nxpwifi_process_uap_txpd(struct nxpwifi_private *priv,
+			      struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct uap_txpd *txpd;
+	struct nxpwifi_txinfo *tx_info = NXPWIFI_SKB_TXCB(skb);
+	int pad;
+	u16 pkt_type, pkt_offset;
+	int hroom = adapter->intf_hdr_len;
+
+	pkt_type = nxpwifi_is_skb_mgmt_frame(skb) ? PKT_TYPE_MGMT : 0;
+
+	pad = ((uintptr_t)skb->data - (sizeof(*txpd) + hroom)) &
+	       (NXPWIFI_DMA_ALIGN_SZ - 1);
+
+	skb_push(skb, sizeof(*txpd) + pad);
+
+	txpd = (struct uap_txpd *)skb->data;
+	memset(txpd, 0, sizeof(*txpd));
+	txpd->bss_num = priv->bss_num;
+	txpd->bss_type = priv->bss_type;
+	txpd->tx_pkt_length = cpu_to_le16((u16)(skb->len - (sizeof(*txpd) +
+						pad)));
+	txpd->priority = (u8)skb->priority;
+
+	txpd->pkt_delay_2ms = nxpwifi_wmm_compute_drv_pkt_delay(priv, skb);
+
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_EAPOL_TX_STATUS ||
+	    tx_info->flags & NXPWIFI_BUF_FLAG_ACTION_TX_STATUS) {
+		txpd->tx_token_id = tx_info->ack_frame_id;
+		txpd->flags |= NXPWIFI_TXPD_FLAGS_REQ_TX_STATUS;
+	}
+
+	if (txpd->priority < ARRAY_SIZE(priv->wmm.user_pri_pkt_tx_ctrl))
+		/*
+		 * Set the priority specific tx_control field, setting of 0 will
+		 * cause the default value to be used later in this function.
+		 */
+		txpd->tx_control =
+		    cpu_to_le32(priv->wmm.user_pri_pkt_tx_ctrl[txpd->priority]);
+
+	/* Offset of actual data */
+	pkt_offset = sizeof(*txpd) + pad;
+	if (pkt_type == PKT_TYPE_MGMT) {
+		/* Set the packet type and add header for management frame */
+		txpd->tx_pkt_type = cpu_to_le16(pkt_type);
+		pkt_offset += NXPWIFI_MGMT_FRAME_HEADER_SIZE;
+	}
+
+	txpd->tx_pkt_offset = cpu_to_le16(pkt_offset);
+
+	/* make space for adapter->intf_hdr_len */
+	skb_push(skb, hroom);
+
+	if (!txpd->tx_control)
+		/* TxCtrl set by user or default */
+		txpd->tx_control = cpu_to_le32(priv->pkt_tx_ctrl);
+}
-- 
2.34.1


