Return-Path: <linux-wireless+bounces-9388-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31F0911D98
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37B1286716
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A04F173345;
	Fri, 21 Jun 2024 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Eh1tFmcf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2046.outbound.protection.outlook.com [40.107.7.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B21C173329;
	Fri, 21 Jun 2024 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956443; cv=fail; b=X826KtvYj05SrcDyN6JGjcmDMmCsFJ5TN6u/nCOtI1uO4QOBEPKxJvD1Y8/W4gvN7JzJC1aYXOjwzc1OlYdchGG6JqcuP9sPeex2W8XVEj7wtsFreoPBF2xQdWAB6pk+QO1QCHjmEoJx+UuVsfgtlJEEd+atIKF29arXAuIAGu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956443; c=relaxed/simple;
	bh=mXnNF5MjrP0viIKumfX53Cj/AMAWGVZth38a3nmec8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uc+XRuJFsDuCVygftJCy34IW3hCi+uZV+31JC2u/XiTlLV45XYeE26GrvhTrd6ZvYjdObon5j2cGOiytvC1Q+rcD4wgbMWiXF4taLmzZMGv1Ot+pbBLsnuAevr2KZ0I1sPdDwFQeyK9xByYY5ATyH0Z5po7W4vmH7Q+OvmjW9tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Eh1tFmcf; arc=fail smtp.client-ip=40.107.7.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rs9DYhrHMOaLHycvfZQ5pNYAGWJVUX7jwmCRCPEG57jjjCvhgiLUT7Fe9aj+8PAj8KN+Ohaz68r5c0gKz+MvsUmiQGnotiO1hcZDEhIe8KWk5cIQGiUKy7dB+Z0UW3kOqNcv6ObbM9LY4r+9LcsO9M/vTWiK8Dx8xeR5w9jKECPyexEDV3MkBc5rgUufTCtBJnd//4wxJI7IQrwL7vM0cKytlbrkpGbm2nk0RzzsnT8EIua/iTgWqr7c9ct6cMkzKEik5j0S7cOXaiU9H/ijCar/ampn/rVx6ObRm0zWtJb/vl2sAb4uQA9gPtT/4pNyrZavyDnYOO3RTJEch8ZxlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6DQdqzf3x6pio9nRUBYj3YNVCn1a4t1jjJ7TH+XZGo=;
 b=D3AAu4Mg7vDF9xl02Wj/J8ntzSZrR4ceI0b7Ut4EjZH0h1uVsDz374BUHzpD3VxUdx0MGH3n9V6ll0C48u6qMGy2tkz4B8RabrDAfyDUdVCZQT3Fv1iBNtYj9rtBO9RnxHQSO1Ei/543Qe5yJbMmCckUiu6yrf3IjjxTVsRkVQd7iJgk+gwL6mFrtfr8ca43OlHuEwamMORP8VIqAjlQatW4W9+kOR2/b+jOnNpKuR1RXcLSZi4wkC+E+cw7R1mQ2yvPcatCTqrGSknAYkcpM/gj8be+TtgXKnp3Yo74gz1rWpEZdL3jDR84AkUPcy+xav5WUeSluZ5xQDNz2uBOsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6DQdqzf3x6pio9nRUBYj3YNVCn1a4t1jjJ7TH+XZGo=;
 b=Eh1tFmcfzjUpr9AJSSPb9MOAIpbh9eVL0DSmE2vz7fZm9IK+Z53T0e1QERByllw7Jo1Mgc6tdh825cUw1re+OidR4AZEO1DmPHH42lKHBDjN7ezBcwEJu8/ZYmI71VJW1evMOCF33KWbhnjf7JMmJuUwK16f0ZfBlYUkewiBhH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB9190.eurprd04.prod.outlook.com (2603:10a6:20b:44d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Fri, 21 Jun
 2024 07:53:54 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:53:54 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 24/43] wifi: nxpwifi: add main.h
Date: Fri, 21 Jun 2024 15:51:49 +0800
Message-Id: <20240621075208.513497-25-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240621075208.513497-1-yu-hao.lin@nxp.com>
References: <20240621075208.513497-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0115.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::12) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AS8PR04MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: 328d4097-d0c1-4b34-ec1e-08dc91c74bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|376011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s4T3UIbZQkM06a/0yVaYcL936ON5jQFDj7rDMYUASAh7aTOydq4ZySjFob96?=
 =?us-ascii?Q?KzwjMAyt3aQrxpauk/iHyXPbOcagerMJR+8hYLV9eBzvFV2vpcbrmYPgHBVE?=
 =?us-ascii?Q?rvPpxM0iUiksBWGKBmlQ1B8LYJ1DAwGfd3UEY14/rIaiB/zYtPdLIWDrYSur?=
 =?us-ascii?Q?KN6/AYuMOsSNAiqDbXAcIbMWXRYxU0Izg4CRtazWQgS4fdogEn32JMi99K+H?=
 =?us-ascii?Q?Z8wjcNY7BjBrf+RBzHSBNVbq/6ZKC8YVIsWSsapy6ouh+uFlirxd5brYepX5?=
 =?us-ascii?Q?PgJxcD4rrUrEeQu5/l0W+m4bWq0cJ/Yd7kFY7xVvytslzjAWYdGPHlCN2lYj?=
 =?us-ascii?Q?XmymwMkHSYaoE62Juy89YLrp8UNrfzQmkdYeHBrN2lmI1y5yZN2OYXs3E5M5?=
 =?us-ascii?Q?7/QkQAPy9gPyhv50eJkVdOa6cRJetdmWUI9Mu/fKPDpLAyvqg5qM4P7S+OkJ?=
 =?us-ascii?Q?RSjsLAuv0WY+U69UWwRC78wfbTQNnKcthDPHbKbQy0xzCwVEJuUo915ovnt8?=
 =?us-ascii?Q?SqqJE5SpsVRZrwSMkUo3Dwf9Ru6pGJX+E0JIhBp+WM408S/+Drq99od97QyA?=
 =?us-ascii?Q?uyb25Wx0FmflRxRmNHOjMh7moLZOtIMZuOsaGv0h0E9PnaMp8RMBzwIr93Wx?=
 =?us-ascii?Q?9u5vIVrbF0p3gdvb70e/9e9F7tISy1MfbUKAgrEhnOBxMKcqXl49f6Tc4MvD?=
 =?us-ascii?Q?5eFyBO3bKVVX8SbbdbHpqduj0rl+vaJr0K7yDhphxh68ZtjUGIrVhXDNoZzs?=
 =?us-ascii?Q?+qf2KvCtVn8Zefr7ZDXrheG+Hr0VF7SOtxddPjLLYU/INvTlLtJGFq3WW290?=
 =?us-ascii?Q?gIG+hwjBfumkAjHHLvDsb0CmFIxZzokgYzvP8sHazBCkSQMeMM2LlLBsv5j6?=
 =?us-ascii?Q?sS3JJL2Qcf1bVRW2wWHfLDO29g224kWDNY6kYF2TI1zdm63JNyUyNfUi1aCi?=
 =?us-ascii?Q?i99uFfgeMnLflHX2NOnF2TyQUFQBIrMQgugkHsXqX4ht9PL+RcHxqOoSKALi?=
 =?us-ascii?Q?MqNtwjVECc19ZD77f1zdNQlYxKHNUXxAPdJssurjNbjowfOKC9DWKEVqypmd?=
 =?us-ascii?Q?+AoNttJQw1BOTMM4SLVNMcqFXm8oPaGBlKpOTdth6FFgF3u+fxY5idvKGRlc?=
 =?us-ascii?Q?Ufdy9USN/soa5IZOVPWyk8RCZtZDg6FTy6JryHQvBvA6pqa7Hi7AMXcvZ33o?=
 =?us-ascii?Q?53L/TkoqyvCBpXVwMZFRZqsOOiR27UvvKVWQ0GjH5NsJp5xeD+ydPJmz6t7d?=
 =?us-ascii?Q?PuynUJ6UE85+wLRfMGQqV11v5FRYRYyT2PnXTLeodj8XfrXlayjocZEqOFeZ?=
 =?us-ascii?Q?DkWrEfZvotmVz1tP+DuE/AgLtb1a2qnpX6cMYivRQrxFNNX3BiMmRlQAdOQc?=
 =?us-ascii?Q?YXmGajs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+8+4s/28lpAlVCTmWDH0P3Vky72OyLfrUVUw9+aaOFDGv3KjAHKazy9EALsW?=
 =?us-ascii?Q?4wNCnQVKRWs/S+sDF7DMmqwHUQY0i58ucuYnl+wGcmYk/dxZxqua+bp71X5i?=
 =?us-ascii?Q?oKtdHvtCFgF7hC6r4JKGrWcJZ/Jg+PTTF4gww1WA61miXXlaV1QG5WZL22xJ?=
 =?us-ascii?Q?UmPf+p9uPtHKqg8MYxNevRgbrTcaaEYKQYiasQt2BzDqk3ASYZtQBlwH6rba?=
 =?us-ascii?Q?p1N0814a1rI1CQIQ559XMxB6d+e7eMOvAA44UIJTG9oIWMhWffgxA/0KM7ey?=
 =?us-ascii?Q?R7cQ4XTrBx+s+nTsZXu8swAchnoW81o8XPaWAqlyxKR4zHDXky7lS8fQuQkD?=
 =?us-ascii?Q?2Zxc8CIkmb/TeZKFuEGkRUwuCb7LrCzmx1rlTQ3EKj6Ldx3yxp4jNyb6qy66?=
 =?us-ascii?Q?8MSR0XXSVRzvP5u+GKIr4bSpxtb0dsVniueYCKwIGI77XlhPQHk/Pg0fSSXo?=
 =?us-ascii?Q?zxwX2diNDmI64HLXfKJ6EQb5mpfLfC7RSInDs7JXLIjiKcA14qFf2w6QWR+X?=
 =?us-ascii?Q?s4HhVnA5IidaoyR/SIDcUcqbRG5/m7Qr7e4PdMk97VnVZfuUTVqmF2XarnaT?=
 =?us-ascii?Q?reyu4pzt0rpiQTJDbqufmf1Lm+qSdMVPGEj9h/BkwQh+u6EApvL7irsH7xbM?=
 =?us-ascii?Q?Zm4KZkvmClu+Iw3MiRkB1MP3K3E9ahQu/AwaVl60jHAWfm6cD4Z7oJZYpaqt?=
 =?us-ascii?Q?g1c4Wp7+LH1ruTUG3ncv1Q7CKbFUeHTPq9sjImrg2w4TKmmhG1aeepksFAao?=
 =?us-ascii?Q?KXhz7yDmtwDvzRc5EE1xdSGiUwErBCn03WsJDZtYfyc1p1hfZDaxavXQi7aU?=
 =?us-ascii?Q?zlLJRo36ApolFipBYpIf/R0nnLzhb5qU3mIT7ralvSqdTR/cFex9d+qDpkRk?=
 =?us-ascii?Q?kK3C1+yI+0OT6CBvXaYxLTpn6sO3U5Rirv+N1vVkc7gu0hxFmWivEXRd8iXp?=
 =?us-ascii?Q?dP/eknaDEPoSW6hW/SiVbUagHIffZQDNZAXXXalNjaIBn152M/mJ1dUnnqWG?=
 =?us-ascii?Q?Qa0mthPVJL9gK0sUMCc2msOUQo+mgL5wU6JWNmc7cnBQgSiV+PLzyM1S4b2I?=
 =?us-ascii?Q?LD1AOWnbG7mFi+h8XK5uJ5tayQBTZyTtt61JTTn/20szL6XScv2Zd00IQREt?=
 =?us-ascii?Q?ZcS+juE3jSHFIbSyq/O3zNwKY8x5TXrSbwlY9uYpyk/yn6t+CGVFVmtCV2xF?=
 =?us-ascii?Q?nWDjoAjRK57dafI/Yr3aaEcJIWnBl1GdXsHb1cuTJrVq61PlQNJ/+I/yBhm0?=
 =?us-ascii?Q?6CJT9a35g+LIAvWy3ZAX37EeaAmUgOxnr8tiJEYYTWo9PsGFYqVEquZ+uPtR?=
 =?us-ascii?Q?Y+gAhrBl49zKSsYZgHZKruMXnlbNqG18A1nFIw3O+GgnloDIVshvvAN1kUa8?=
 =?us-ascii?Q?qyxHbdh3MJtkLbhbK9/DZBi5x0fr0szb4SqOGb0FXKIafELLF1fmK07LCj2x?=
 =?us-ascii?Q?i/HvsvqGaciK955+28+x2dKNHwbX8gPilfLZyLXNFlB60sJ9luowzZHpcy7u?=
 =?us-ascii?Q?ZjCdrK8KkKGR5DT3zFQChjkkKkRssheHPX0WkLhBeh72V/JMaZbcibbC7yVj?=
 =?us-ascii?Q?xZr9hLkIjFRMB7MGHBeYn6m/nEj0Uo4BLs+sCEOs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 328d4097-d0c1-4b34-ec1e-08dc91c74bf1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:53:54.4401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsfzL58kOb97ER4wsX9+QmyWOa3/M0avtvessIN8oAslFibG+oVoNWilM0MuPylU2IqqMoWhR9XcAjh0snVzbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9190

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/main.h | 1507 +++++++++++++++++++++++
 1 file changed, 1507 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/main.h b/drivers/net/wireless/nxp/nxpwifi/main.h
new file mode 100644
index 000000000000..e9878ea03d6e
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/main.h
@@ -0,0 +1,1507 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: major data structures and prototypes
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_MAIN_H_
+#define _NXPWIFI_MAIN_H_
+
+#include <linux/completion.h>
+#include <linux/kernel.h>
+#include <linux/kstrtox.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/semaphore.h>
+#include <linux/ip.h>
+#include <linux/skbuff.h>
+#include <linux/if_arp.h>
+#include <linux/etherdevice.h>
+#include <net/sock.h>
+#include <net/lib80211.h>
+#include <linux/vmalloc.h>
+#include <linux/firmware.h>
+#include <linux/ctype.h>
+#include <linux/of.h>
+#include <linux/idr.h>
+#include <linux/inetdevice.h>
+#include <linux/devcoredump.h>
+#include <linux/err.h>
+#include <linux/gfp.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/of_irq.h>
+#include <linux/workqueue.h>
+
+#include "decl.h"
+#include "ioctl.h"
+#include "util.h"
+#include "fw.h"
+#include "sdio.h"
+
+extern char driver_version[];
+
+struct nxpwifi_adapter;
+struct nxpwifi_private;
+
+enum {
+	NXPWIFI_ASYNC_CMD,
+	NXPWIFI_SYNC_CMD
+};
+
+#define NXPWIFI_MAX_AP				64
+
+#define NXPWIFI_MAX_PKTS_TXQ			16
+
+#define NXPWIFI_DEFAULT_WATCHDOG_TIMEOUT	(5 * HZ)
+
+#define NXPWIFI_TIMER_10S			10000
+#define NXPWIFI_TIMER_1S			1000
+
+#define MAX_TX_PENDING      400
+#define LOW_TX_PENDING      380
+
+#define HIGH_RX_PENDING     50
+#define LOW_RX_PENDING      20
+
+#define NXPWIFI_UPLD_SIZE               (2312)
+
+#define MAX_EVENT_SIZE                  2048
+
+#define NXPWIFI_FW_DUMP_SIZE       (2 * 1024 * 1024)
+
+#define ARP_FILTER_MAX_BUF_SIZE         68
+
+#define NXPWIFI_KEY_BUFFER_SIZE			16
+#define NXPWIFI_DEFAULT_LISTEN_INTERVAL 10
+#define NXPWIFI_MAX_REGION_CODE         9
+
+#define DEFAULT_BCN_AVG_FACTOR          8
+#define DEFAULT_DATA_AVG_FACTOR         8
+
+#define FIRST_VALID_CHANNEL				0xff
+
+#define DEFAULT_BCN_MISS_TIMEOUT		5
+
+#define MAX_SCAN_BEACON_BUFFER			8000
+
+#define SCAN_BEACON_ENTRY_PAD			6
+
+#define NXPWIFI_PASSIVE_SCAN_CHAN_TIME	110
+#define NXPWIFI_ACTIVE_SCAN_CHAN_TIME	40
+#define NXPWIFI_SPECIFIC_SCAN_CHAN_TIME	40
+#define NXPWIFI_DEF_SCAN_CHAN_GAP_TIME  50
+
+#define SCAN_RSSI(RSSI)					(0x100 - ((u8)(RSSI)))
+
+#define NXPWIFI_MAX_TOTAL_SCAN_TIME	(NXPWIFI_TIMER_10S - NXPWIFI_TIMER_1S)
+
+#define WPA_GTK_OUI_OFFSET				2
+#define RSN_GTK_OUI_OFFSET				2
+
+#define NXPWIFI_OUI_NOT_PRESENT			0
+#define NXPWIFI_OUI_PRESENT				1
+
+#define PKT_TYPE_MGMT	0xE5
+
+/* Do not check for data_received for USB, as data_received
+ * is handled in nxpwifi_usb_recv for USB
+ */
+#define IS_CARD_RX_RCVD(adapter) ({ \
+	typeof(adapter) (_adapter) = adapter; \
+	((_adapter)->cmd_resp_received || \
+	 (_adapter)->event_received || \
+	 (_adapter)->data_received); \
+	})
+
+#define NXPWIFI_TYPE_CMD				1
+#define NXPWIFI_TYPE_DATA				0
+#define NXPWIFI_TYPE_AGGR_DATA				10
+#define NXPWIFI_TYPE_EVENT				3
+
+#define MAX_BITMAP_RATES_SIZE			18
+
+#define MAX_CHANNEL_BAND_BG     14
+#define MAX_CHANNEL_BAND_A      165
+
+#define MAX_FREQUENCY_BAND_BG   2484
+
+#define NXPWIFI_EVENT_HEADER_LEN           4
+#define NXPWIFI_UAP_EVENT_EXTRA_HEADER	   2
+
+#define NXPWIFI_TYPE_LEN			4
+#define NXPWIFI_USB_TYPE_CMD			0xF00DFACE
+#define NXPWIFI_USB_TYPE_DATA			0xBEADC0DE
+#define NXPWIFI_USB_TYPE_EVENT			0xBEEFFACE
+
+/* Threshold for tx_timeout_cnt before we trigger a card reset */
+#define TX_TIMEOUT_THRESHOLD	6
+
+#define NXPWIFI_DRV_INFO_SIZE_MAX 0x40000
+
+/* Address alignment */
+#define NXPWIFI_ALIGN_ADDR(p, a) ({ \
+	typeof(a) (_a) = a; \
+	(((long)(p) + (_a) - 1) & ~((_a) - 1)); \
+	})
+
+#define NXPWIFI_MAC_LOCAL_ADMIN_BIT		41
+
+/**
+ *enum nxpwifi_debug_level  -  nxp wifi debug level
+ */
+enum NXPWIFI_DEBUG_LEVEL {
+	NXPWIFI_DBG_MSG		= 0x00000001,
+	NXPWIFI_DBG_FATAL	= 0x00000002,
+	NXPWIFI_DBG_ERROR	= 0x00000004,
+	NXPWIFI_DBG_DATA	= 0x00000008,
+	NXPWIFI_DBG_CMD		= 0x00000010,
+	NXPWIFI_DBG_EVENT	= 0x00000020,
+	NXPWIFI_DBG_INTR	= 0x00000040,
+	NXPWIFI_DBG_IOCTL	= 0x00000080,
+
+	NXPWIFI_DBG_MPA_D	= 0x00008000,
+	NXPWIFI_DBG_DAT_D	= 0x00010000,
+	NXPWIFI_DBG_CMD_D	= 0x00020000,
+	NXPWIFI_DBG_EVT_D	= 0x00040000,
+	NXPWIFI_DBG_FW_D	= 0x00080000,
+	NXPWIFI_DBG_IF_D	= 0x00100000,
+
+	NXPWIFI_DBG_ENTRY	= 0x10000000,
+	NXPWIFI_DBG_WARN	= 0x20000000,
+	NXPWIFI_DBG_INFO	= 0x40000000,
+	NXPWIFI_DBG_DUMP	= 0x80000000,
+
+	NXPWIFI_DBG_ANY		= 0xffffffff
+};
+
+#define NXPWIFI_DEFAULT_DEBUG_MASK	(NXPWIFI_DBG_MSG | \
+					NXPWIFI_DBG_FATAL | \
+					NXPWIFI_DBG_ERROR)
+
+__printf(3, 4)
+void _nxpwifi_dbg(const struct nxpwifi_adapter *adapter, int mask,
+		  const char *fmt, ...);
+#define nxpwifi_dbg(adapter, mask, fmt, ...)				\
+	_nxpwifi_dbg(adapter, NXPWIFI_DBG_##mask, fmt, ##__VA_ARGS__)
+
+#define DEBUG_DUMP_DATA_MAX_LEN		128
+#define nxpwifi_dbg_dump(adapter, dbg_mask, str, buf, len)	\
+do {								\
+	if ((adapter)->debug_mask & NXPWIFI_DBG_##dbg_mask)	\
+		print_hex_dump(KERN_DEBUG, str,			\
+			       DUMP_PREFIX_OFFSET, 16, 1,	\
+			       buf, len, false);		\
+} while (0)
+
+/** Min BGSCAN interval 15 second */
+#define NXPWIFI_BGSCAN_INTERVAL 15000
+/** default repeat count */
+#define NXPWIFI_BGSCAN_REPEAT_COUNT 6
+
+struct nxpwifi_dbg {
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
+	u16 timeout_cmd_id;
+	u16 timeout_cmd_act;
+	u16 last_cmd_id[DBG_CMD_NUM];
+	u16 last_cmd_act[DBG_CMD_NUM];
+	u16 last_cmd_index;
+	u16 last_cmd_resp_id[DBG_CMD_NUM];
+	u16 last_cmd_resp_index;
+	u16 last_event[DBG_CMD_NUM];
+	u16 last_event_index;
+	u32 last_mp_wr_bitmap[NXPWIFI_DBG_SDIO_MP_NUM];
+	u32 last_mp_wr_ports[NXPWIFI_DBG_SDIO_MP_NUM];
+	u32 last_mp_wr_len[NXPWIFI_DBG_SDIO_MP_NUM];
+	u32 last_mp_curr_wr_port[NXPWIFI_DBG_SDIO_MP_NUM];
+	u8 last_sdio_mp_index;
+};
+
+enum NXPWIFI_HARDWARE_STATUS {
+	NXPWIFI_HW_STATUS_READY,
+	NXPWIFI_HW_STATUS_INITIALIZING,
+	NXPWIFI_HW_STATUS_INIT_DONE,
+	NXPWIFI_HW_STATUS_RESET,
+	NXPWIFI_HW_STATUS_NOT_READY
+};
+
+enum NXPWIFI_802_11_POWER_MODE {
+	NXPWIFI_802_11_POWER_MODE_CAM,
+	NXPWIFI_802_11_POWER_MODE_PSP
+};
+
+struct nxpwifi_tx_param {
+	u32 next_pkt_len;
+};
+
+enum NXPWIFI_PS_STATE {
+	PS_STATE_AWAKE,
+	PS_STATE_PRE_SLEEP,
+	PS_STATE_SLEEP_CFM,
+	PS_STATE_SLEEP
+};
+
+enum nxpwifi_iface_type {
+	NXPWIFI_SDIO
+};
+
+struct nxpwifi_add_ba_param {
+	u32 tx_win_size;
+	u32 rx_win_size;
+	u32 timeout;
+	u8 tx_amsdu;
+	u8 rx_amsdu;
+};
+
+struct nxpwifi_tx_aggr {
+	u8 ampdu_user;
+	u8 ampdu_ap;
+	u8 amsdu;
+};
+
+enum nxpwifi_ba_status {
+	BA_SETUP_NONE = 0,
+	BA_SETUP_INPROGRESS,
+	BA_SETUP_COMPLETE
+};
+
+struct nxpwifi_ra_list_tbl {
+	struct list_head list;
+	struct sk_buff_head skb_head;
+	u8 ra[ETH_ALEN];
+	u32 is_11n_enabled;
+	u16 max_amsdu;
+	u16 ba_pkt_count;
+	u8 ba_packet_thr;
+	enum nxpwifi_ba_status ba_status;
+	u8 amsdu_in_ampdu;
+	u16 total_pkt_count;
+	bool tx_paused;
+};
+
+struct nxpwifi_tid_tbl {
+	struct list_head ra_list;
+};
+
+#define WMM_HIGHEST_PRIORITY		7
+#define HIGH_PRIO_TID				7
+#define LOW_PRIO_TID				0
+#define NO_PKT_PRIO_TID				-1
+#define NXPWIFI_WMM_DRV_DELAY_MAX 510
+
+struct nxpwifi_wmm_desc {
+	struct nxpwifi_tid_tbl tid_tbl_ptr[MAX_NUM_TID];
+	u32 packets_out[MAX_NUM_TID];
+	u32 pkts_paused[MAX_NUM_TID];
+	/* spin lock to protect ra_list */
+	spinlock_t ra_list_spinlock;
+	struct nxpwifi_wmm_ac_status ac_status[IEEE80211_NUM_ACS];
+	enum nxpwifi_wmm_ac_e ac_down_graded_vals[IEEE80211_NUM_ACS];
+	u32 drv_pkt_delay_max;
+	u8 queue_priority[IEEE80211_NUM_ACS];
+	u32 user_pri_pkt_tx_ctrl[WMM_HIGHEST_PRIORITY + 1];	/* UP: 0 to 7 */
+	/* Number of transmit packets queued */
+	atomic_t tx_pkts_queued;
+	/* Tracks highest priority with a packet queued */
+	atomic_t highest_queued_prio;
+};
+
+struct nxpwifi_802_11_security {
+	u8 wpa_enabled;
+	u8 wpa2_enabled;
+	u8 wep_enabled;
+	u32 authentication_mode;
+	u8 is_authtype_auto;
+	u32 encryption_mode;
+};
+
+struct ieee_types_header {
+	u8 element_id;
+	u8 len;
+} __packed;
+
+struct ieee_types_vendor_specific {
+	struct ieee_types_vendor_header vend_hdr;
+	u8 data[IEEE_MAX_IE_SIZE - sizeof(struct ieee_types_vendor_header)];
+} __packed;
+
+struct ieee_types_generic {
+	struct ieee_types_header ieee_hdr;
+	u8 data[IEEE_MAX_IE_SIZE - sizeof(struct ieee_types_header)];
+} __packed;
+
+struct ieee_types_bss_co_2040 {
+	struct ieee_types_header ieee_hdr;
+	u8 bss_2040co;
+} __packed;
+
+struct ieee_types_extcap {
+	struct ieee_types_header ieee_hdr;
+	u8 ext_capab[8];
+} __packed;
+
+struct ieee_types_vht_cap {
+	struct ieee_types_header ieee_hdr;
+	struct ieee80211_vht_cap vhtcap;
+} __packed;
+
+struct ieee_types_vht_oper {
+	struct ieee_types_header ieee_hdr;
+	struct ieee80211_vht_operation vhtoper;
+} __packed;
+
+struct ieee_types_aid {
+	struct ieee_types_header ieee_hdr;
+	u16 aid;
+} __packed;
+
+struct nxpwifi_bssdescriptor {
+	u8 mac_address[ETH_ALEN];
+	struct cfg80211_ssid ssid;
+	u32 privacy;
+	s32 rssi;
+	u32 channel;
+	u32 freq;
+	u16 beacon_period;
+	u8 erp_flags;
+	u32 bss_mode;
+	u8 supported_rates[NXPWIFI_SUPPORTED_RATES];
+	u8 data_rates[NXPWIFI_SUPPORTED_RATES];
+	/* Network band.
+	 * BAND_B(0x01): 'b' band
+	 * BAND_G(0x02): 'g' band
+	 * BAND_A(0X04): 'a' band
+	 */
+	u16 bss_band;
+	u64 fw_tsf;
+	u64 timestamp;
+	union ieee_types_phy_param_set phy_param_set;
+	union ieee_types_ss_param_set ss_param_set;
+	u16 cap_info_bitmap;
+	struct ieee_types_wmm_parameter wmm_ie;
+	u8  disable_11n;
+	struct ieee80211_ht_cap *bcn_ht_cap;
+	u16 ht_cap_offset;
+	struct ieee80211_ht_operation *bcn_ht_oper;
+	u16 ht_info_offset;
+	u8 *bcn_bss_co_2040;
+	u16 bss_co_2040_offset;
+	u8 *bcn_ext_cap;
+	u16 ext_cap_offset;
+	struct ieee80211_vht_cap *bcn_vht_cap;
+	u16 vht_cap_offset;
+	struct ieee80211_vht_operation *bcn_vht_oper;
+	u16 vht_info_offset;
+	struct ieee_types_oper_mode_ntf *oper_mode;
+	u16 oper_mode_offset;
+	u8 disable_11ac;
+	struct ieee_types_vendor_specific *bcn_wpa_ie;
+	u16 wpa_offset;
+	struct ieee_types_generic *bcn_rsn_ie;
+	u16 rsn_offset;
+	struct ieee_types_generic *bcn_rsnx_ie;
+	u16 rsnx_offset;
+	u8 *beacon_buf;
+	u32 beacon_buf_size;
+	u8 sensed_11h;
+	u8 local_constraint;
+	u8 chan_sw_ie_present;
+};
+
+struct nxpwifi_current_bss_params {
+	struct nxpwifi_bssdescriptor bss_descriptor;
+	u8 wmm_enabled;
+	u8 wmm_uapsd_enabled;
+	u8 band;
+	u32 num_of_rates;
+	u8 data_rates[NXPWIFI_SUPPORTED_RATES];
+};
+
+struct nxpwifi_sleep_period {
+	u16 period;
+	u16 reserved;
+};
+
+struct nxpwifi_wep_key {
+	u32 length;
+	u32 key_index;
+	u32 key_length;
+	u8 key_material[NXPWIFI_KEY_BUFFER_SIZE];
+};
+
+#define MAX_REGION_CHANNEL_NUM  2
+
+struct nxpwifi_chan_freq_power {
+	u16 channel;
+	u32 freq;
+	u16 max_tx_power;
+	u8 unsupported;
+};
+
+enum state_11d_t {
+	DISABLE_11D = 0,
+	ENABLE_11D = 1,
+};
+
+#define NXPWIFI_MAX_TRIPLET_802_11D		83
+
+struct nxpwifi_802_11d_domain_reg {
+	u8 country_code[IEEE80211_COUNTRY_STRING_LEN];
+	u8 no_of_triplet;
+	struct ieee80211_country_ie_triplet
+		triplet[NXPWIFI_MAX_TRIPLET_802_11D];
+};
+
+struct nxpwifi_vendor_spec_cfg_ie {
+	u16 mask;
+	u16 flag;
+	u8 ie[NXPWIFI_MAX_VSIE_LEN];
+};
+
+struct wps {
+	u8 session_enable;
+};
+
+struct nxpwifi_roc_cfg {
+	u64 cookie;
+	struct ieee80211_channel chan;
+};
+
+enum nxpwifi_iface_work_flags {
+	NXPWIFI_IFACE_WORK_DEVICE_DUMP,
+	NXPWIFI_IFACE_WORK_CARD_RESET,
+};
+
+enum nxpwifi_adapter_work_flags {
+	NXPWIFI_SURPRISE_REMOVED,
+	NXPWIFI_IS_CMD_TIMEDOUT,
+	NXPWIFI_IS_SUSPENDED,
+	NXPWIFI_IS_HS_CONFIGURED,
+	NXPWIFI_IS_HS_ENABLING,
+	NXPWIFI_IS_REQUESTING_FW_VEREXT,
+};
+
+struct nxpwifi_band_config {
+	u8 chan_band:2;
+	u8 chan_width:2;
+	u8 chan2_offset:2;
+	u8 scan_mode:2;
+} __packed;
+
+struct nxpwifi_channel_band {
+	struct nxpwifi_band_config band_config;
+	u8 channel;
+};
+
+struct nxpwifi_private {
+	struct nxpwifi_adapter *adapter;
+	u8 bss_type;
+	u8 bss_role;
+	u8 bss_priority;
+	u8 bss_num;
+	u8 bss_started;
+	u8 auth_flag;
+	u16 auth_alg;
+	u8 frame_type;
+	u8 curr_addr[ETH_ALEN];
+	u8 media_connected;
+	u8 port_open;
+	u8 usb_port;
+	u32 num_tx_timeout;
+	/* track consecutive timeout */
+	u8 tx_timeout_cnt;
+	struct net_device *netdev;
+	struct net_device_stats stats;
+	u32 curr_pkt_filter;
+	u32 bss_mode;
+	u32 pkt_tx_ctrl;
+	u16 tx_power_level;
+	u8 max_tx_power_level;
+	u8 min_tx_power_level;
+	u32 tx_ant;
+	u32 rx_ant;
+	u8 tx_rate;
+	u8 tx_htinfo;
+	u8 rxpd_htinfo;
+	u8 rxpd_rate;
+	u16 rate_bitmap;
+	u16 bitmap_rates[MAX_BITMAP_RATES_SIZE];
+	u32 data_rate;
+	u8 is_data_rate_auto;
+	u16 bcn_avg_factor;
+	u16 data_avg_factor;
+	s16 data_rssi_last;
+	s16 data_nf_last;
+	s16 data_rssi_avg;
+	s16 data_nf_avg;
+	s16 bcn_rssi_last;
+	s16 bcn_nf_last;
+	s16 bcn_rssi_avg;
+	s16 bcn_nf_avg;
+	struct nxpwifi_bssdescriptor *attempted_bss_desc;
+	struct cfg80211_ssid prev_ssid;
+	u8 prev_bssid[ETH_ALEN];
+	struct nxpwifi_current_bss_params curr_bss_params;
+	u16 beacon_period;
+	u8 dtim_period;
+	u16 listen_interval;
+	u16 atim_window;
+	struct nxpwifi_802_11_security sec_info;
+	struct nxpwifi_wep_key wep_key[NUM_WEP_KEYS];
+	u16 wep_key_curr_index;
+	u8 wpa_ie[256];
+	u16 wpa_ie_len;
+	u8 wpa_is_gtk_set;
+	struct host_cmd_ds_802_11_key_material aes_key;
+	u8 *wps_ie;
+	u16 wps_ie_len;
+	u8 wmm_required;
+	u8 wmm_enabled;
+	u8 wmm_qosinfo;
+	struct nxpwifi_wmm_desc wmm;
+	atomic_t wmm_tx_pending[IEEE80211_NUM_ACS];
+	struct list_head sta_list;
+	/* spin lock for associated station list */
+	spinlock_t sta_list_spinlock;
+	struct list_head tx_ba_stream_tbl_ptr;
+	/* spin lock for tx_ba_stream_tbl_ptr queue */
+	spinlock_t tx_ba_stream_tbl_lock;
+	struct nxpwifi_tx_aggr aggr_prio_tbl[MAX_NUM_TID];
+	struct nxpwifi_add_ba_param add_ba_param;
+	u16 rx_seq[MAX_NUM_TID];
+	u8 tos_to_tid_inv[MAX_NUM_TID];
+	struct list_head rx_reorder_tbl_ptr;
+	/* spin lock for rx_reorder_tbl_ptr queue */
+	spinlock_t rx_reorder_tbl_lock;
+#define NXPWIFI_ASSOC_RSP_BUF_SIZE  500
+	u8 assoc_rsp_buf[NXPWIFI_ASSOC_RSP_BUF_SIZE];
+	u32 assoc_rsp_size;
+	struct cfg80211_bss *req_bss;
+
+#define NXPWIFI_GENIE_BUF_SIZE      256
+	u8 gen_ie_buf[NXPWIFI_GENIE_BUF_SIZE];
+	u8 gen_ie_buf_len;
+
+	struct nxpwifi_vendor_spec_cfg_ie vs_ie[NXPWIFI_MAX_VSIE_NUM];
+
+#define NXPWIFI_ASSOC_TLV_BUF_SIZE  256
+	u8 assoc_tlv_buf[NXPWIFI_ASSOC_TLV_BUF_SIZE];
+	u8 assoc_tlv_buf_len;
+
+	u8 *curr_bcn_buf;
+	u32 curr_bcn_size;
+	/* spin lock for beacon buffer */
+	spinlock_t curr_bcn_buf_lock;
+	struct wireless_dev wdev;
+	struct nxpwifi_chan_freq_power cfp;
+	u32 versionstrsel;
+	char version_str[NXPWIFI_VERSION_STR_LENGTH];
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *dfs_dev_dir;
+#endif
+	u16 current_key_index;
+	/* mutex for scan */
+	struct mutex async_mutex;
+	struct cfg80211_scan_request *scan_request;
+	u8 cfg_bssid[6];
+	struct wps wps;
+	u8 scan_block;
+	s32 cqm_rssi_thold;
+	u32 cqm_rssi_hyst;
+	u8 subsc_evt_rssi_state;
+	struct nxpwifi_ds_misc_subsc_evt async_subsc_evt_storage;
+	struct nxpwifi_ie mgmt_ie[MAX_MGMT_IE_INDEX];
+	u16 beacon_idx;
+	u16 proberesp_idx;
+	u16 assocresp_idx;
+	u16 gen_idx;
+	u8 ap_11n_enabled;
+	u8 ap_11ac_enabled;
+	bool host_mlme_reg;
+	u32 mgmt_frame_mask;
+	struct nxpwifi_roc_cfg roc_cfg;
+	bool scan_aborting;
+	u8 sched_scanning;
+	u8 csa_chan;
+	unsigned long csa_expire_time;
+	u8 del_list_idx;
+	bool hs2_enabled;
+	struct nxpwifi_uap_bss_param bss_cfg;
+	struct cfg80211_chan_def bss_chandef;
+	struct station_parameters *sta_params;
+	struct idr ack_status_frames;
+	/* spin lock for ack status */
+	spinlock_t ack_status_lock;
+	/** rx histogram data */
+	struct nxpwifi_histogram_data *hist_data;
+	struct cfg80211_chan_def dfs_chandef;
+	struct workqueue_struct *dfs_cac_workqueue;
+	struct delayed_work dfs_cac_work;
+	struct workqueue_struct *dfs_chan_sw_workqueue;
+	struct delayed_work dfs_chan_sw_work;
+	bool uap_stop_tx;
+	struct cfg80211_beacon_data beacon_after;
+	struct nxpwifi_11h_intf_state state_11h;
+	struct nxpwifi_ds_mem_rw mem_rw;
+	struct sk_buff_head bypass_txq;
+	struct nxpwifi_user_scan_chan hidden_chan[NXPWIFI_USER_SCAN_CHAN_MAX];
+	u8 assoc_resp_ht_param;
+	bool ht_param_present;
+};
+
+struct nxpwifi_tx_ba_stream_tbl {
+	struct list_head list;
+	int tid;
+	u8 ra[ETH_ALEN];
+	enum nxpwifi_ba_status ba_status;
+	u8 amsdu;
+};
+
+struct nxpwifi_rx_reorder_tbl;
+
+struct reorder_tmr_cnxt {
+	struct timer_list timer;
+	struct nxpwifi_rx_reorder_tbl *ptr;
+	struct nxpwifi_private *priv;
+	u8 timer_is_set;
+};
+
+struct nxpwifi_rx_reorder_tbl {
+	struct list_head list;
+	int tid;
+	u8 ta[ETH_ALEN];
+	int init_win;
+	int start_win;
+	int win_size;
+	void **rx_reorder_ptr;
+	struct reorder_tmr_cnxt timer_context;
+	u8 amsdu;
+	u8 flags;
+};
+
+struct nxpwifi_bss_prio_node {
+	struct list_head list;
+	struct nxpwifi_private *priv;
+};
+
+struct nxpwifi_bss_prio_tbl {
+	struct list_head bss_prio_head;
+	/* spin lock for bss priority  */
+	spinlock_t bss_prio_lock;
+	struct nxpwifi_bss_prio_node *bss_prio_cur;
+};
+
+struct cmd_ctrl_node {
+	struct list_head list;
+	struct nxpwifi_private *priv;
+	u32 cmd_no;
+	u32 cmd_flag;
+	struct sk_buff *cmd_skb;
+	struct sk_buff *resp_skb;
+	void *data_buf;
+	u32 wait_q_enabled;
+	struct sk_buff *skb;
+	u8 *condition;
+	u8 cmd_wait_q_woken;
+	int (*cmd_resp)(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *resp,
+			u16 cmdresp_no,
+			void *data_buf);
+};
+
+struct nxpwifi_bss_priv {
+	u8 band;
+	u64 fw_tsf;
+};
+
+struct nxpwifi_station_stats {
+	u64 last_rx;
+	s8 rssi;
+	u64 rx_bytes;
+	u64 tx_bytes;
+	u32 rx_packets;
+	u32 tx_packets;
+	u32 tx_failed;
+	u8 last_tx_rate;
+	u8 last_tx_htinfo;
+};
+
+/* This is AP specific structure which stores information
+ * about associated/peer STA
+ */
+struct nxpwifi_sta_node {
+	struct list_head list;
+	u8 mac_addr[ETH_ALEN];
+	u8 is_wmm_enabled;
+	u8 is_11n_enabled;
+	u8 is_11ac_enabled;
+	u8 ampdu_sta[MAX_NUM_TID];
+	u16 rx_seq[MAX_NUM_TID];
+	u16 max_amsdu;
+	struct nxpwifi_station_stats stats;
+	u8 tx_pause;
+};
+
+#define NXPWIFI_TYPE_AGGR_DATA_V2 11
+#define NXPWIFI_BUS_AGGR_MODE_LEN_V2 (2)
+#define NXPWIFI_BUS_AGGR_MAX_LEN 16000
+#define NXPWIFI_BUS_AGGR_MAX_NUM 10
+struct bus_aggr_params {
+	u16 enable;
+	u16 mode;
+	u16 tx_aggr_max_size;
+	u16 tx_aggr_max_num;
+	u16 tx_aggr_align;
+};
+
+struct nxpwifi_if_ops {
+	int (*init_if)(struct nxpwifi_adapter *adapter);
+	void (*cleanup_if)(struct nxpwifi_adapter *adapter);
+	int (*check_fw_status)(struct nxpwifi_adapter *adapter, u32 poll_num);
+	int (*check_winner_status)(struct nxpwifi_adapter *adapter);
+	int (*prog_fw)(struct nxpwifi_adapter *adapter,
+		       struct nxpwifi_fw_image *fw);
+	int (*register_dev)(struct nxpwifi_adapter *adapter);
+	void (*unregister_dev)(struct nxpwifi_adapter *adapter);
+	int (*enable_int)(struct nxpwifi_adapter *adapter);
+	void (*disable_int)(struct nxpwifi_adapter *adapter);
+	int (*process_int_status)(struct nxpwifi_adapter *adapter);
+	int (*host_to_card)(struct nxpwifi_adapter *adapter, u8 type,
+			    struct sk_buff *skb,
+			    struct nxpwifi_tx_param *tx_param);
+	int (*wakeup)(struct nxpwifi_adapter *adapter);
+	int (*wakeup_complete)(struct nxpwifi_adapter *adapter);
+
+	/* Interface specific functions */
+	void (*update_mp_end_port)(struct nxpwifi_adapter *adapter, u16 port);
+	void (*cleanup_mpa_buf)(struct nxpwifi_adapter *adapter);
+	int (*cmdrsp_complete)(struct nxpwifi_adapter *adapter,
+			       struct sk_buff *skb);
+	int (*event_complete)(struct nxpwifi_adapter *adapter,
+			      struct sk_buff *skb);
+	int (*dnld_fw)(struct nxpwifi_adapter *adapter,
+		       struct nxpwifi_fw_image *fw);
+	void (*card_reset)(struct nxpwifi_adapter *adapter);
+	int (*reg_dump)(struct nxpwifi_adapter *adapter, char *drv_buf);
+	void (*device_dump)(struct nxpwifi_adapter *adapter);
+	void (*iface_work)(struct work_struct *work);
+	void (*deaggr_pkt)(struct nxpwifi_adapter *adapter,
+			   struct sk_buff *skb);
+	bool (*is_port_ready)(struct nxpwifi_private *adapter);
+	void (*up_dev)(struct nxpwifi_adapter *adapter);
+};
+
+struct nxpwifi_adapter {
+	u8 iface_type;
+	unsigned int debug_mask;
+	struct nxpwifi_iface_comb iface_limit;
+	struct nxpwifi_iface_comb curr_iface_comb;
+	struct nxpwifi_private *priv[NXPWIFI_MAX_BSS_NUM];
+	u8 priv_num;
+	const struct firmware *firmware;
+	char fw_name[32];
+	int winner;
+	struct device *dev;
+	struct wiphy *wiphy;
+	u8 perm_addr[ETH_ALEN];
+	unsigned long work_flags;
+	u32 fw_release_number;
+	u8 intf_hdr_len;
+	u16 init_wait_q_woken;
+	wait_queue_head_t init_wait_q;
+	void *card;
+	struct nxpwifi_if_ops if_ops;
+	atomic_t bypass_tx_pending;
+	atomic_t rx_pending;
+	atomic_t tx_pending;
+	atomic_t cmd_pending;
+	atomic_t tx_hw_pending;
+	struct workqueue_struct *workqueue;
+	struct work_struct main_work;
+	struct workqueue_struct *rx_workqueue;
+	struct work_struct rx_work;
+	struct workqueue_struct *host_mlme_workqueue;
+	struct work_struct host_mlme_work;
+	bool rx_work_enabled;
+	bool rx_processing;
+	bool delay_main_work;
+	bool rx_locked;
+	bool main_locked;
+	struct nxpwifi_bss_prio_tbl bss_prio_tbl[NXPWIFI_MAX_BSS_NUM];
+	/* spin lock for main process */
+	spinlock_t main_proc_lock;
+	u32 nxpwifi_processing;
+	u8 more_task_flag;
+	u16 tx_buf_size;
+	u16 curr_tx_buf_size;
+	/* sdio single port rx aggregation capability */
+	bool host_disable_sdio_rx_aggr;
+	bool sdio_rx_aggr_enable;
+	u16 sdio_rx_block_size;
+	u32 ioport;
+	enum NXPWIFI_HARDWARE_STATUS hw_status;
+	u16 number_of_antenna;
+	u32 fw_cap_info;
+	/* spin lock for interrupt handling */
+	spinlock_t int_lock;
+	u8 int_status;
+	u32 event_cause;
+	struct sk_buff *event_skb;
+	u8 upld_buf[NXPWIFI_UPLD_SIZE];
+	u8 data_sent;
+	u8 cmd_sent;
+	u8 cmd_resp_received;
+	u8 event_received;
+	u8 data_received;
+	u8 assoc_resp_received;
+	struct nxpwifi_private *priv_link_lost;
+	u8 host_mlme_link_lost;
+	u16 seq_num;
+	struct cmd_ctrl_node *cmd_pool;
+	struct cmd_ctrl_node *curr_cmd;
+	/* spin lock for command */
+	spinlock_t nxpwifi_cmd_lock;
+	u16 last_init_cmd;
+	struct timer_list cmd_timer;
+	struct list_head cmd_free_q;
+	/* spin lock for cmd_free_q */
+	spinlock_t cmd_free_q_lock;
+	struct list_head cmd_pending_q;
+	/* spin lock for cmd_pending_q */
+	spinlock_t cmd_pending_q_lock;
+	struct list_head scan_pending_q;
+	/* spin lock for scan_pending_q */
+	spinlock_t scan_pending_q_lock;
+	/* spin lock for RX processing routine */
+	spinlock_t rx_proc_lock;
+	struct sk_buff_head tx_data_q;
+	atomic_t tx_queued;
+	u32 scan_processing;
+	u16 region_code;
+	struct nxpwifi_802_11d_domain_reg domain_reg;
+	u16 scan_probes;
+	u32 scan_mode;
+	u16 specific_scan_time;
+	u16 active_scan_time;
+	u16 passive_scan_time;
+	u16 scan_chan_gap_time;
+	u8 fw_bands;
+	u8 config_bands;
+	u8 tx_lock_flag;
+	struct nxpwifi_sleep_period sleep_period;
+	u16 ps_mode;
+	u32 ps_state;
+	u8 need_to_wakeup;
+	u16 multiple_dtim;
+	u16 local_listen_interval;
+	u16 null_pkt_interval;
+	struct sk_buff *sleep_cfm;
+	u16 bcn_miss_time_out;
+	u8 is_deep_sleep;
+	u8 delay_null_pkt;
+	u16 delay_to_ps;
+	u16 enhanced_ps_mode;
+	u8 pm_wakeup_card_req;
+	u16 gen_null_pkt;
+	u16 pps_uapsd_mode;
+	u32 pm_wakeup_fw_try;
+	struct timer_list wakeup_timer;
+	struct nxpwifi_hs_config_param hs_cfg;
+	u8 hs_activated;
+	u8 hs_activated_manually;
+	u16 hs_activate_wait_q_woken;
+	wait_queue_head_t hs_activate_wait_q;
+	u8 event_body[MAX_EVENT_SIZE];
+	u32 hw_dot_11n_dev_cap;
+	u8 hw_dev_mcs_support;
+	u8 user_dev_mcs_support;
+	u8 sec_chan_offset;
+	struct nxpwifi_dbg dbg;
+	u8 arp_filter[ARP_FILTER_MAX_BUF_SIZE];
+	u32 arp_filter_size;
+	struct nxpwifi_wait_queue cmd_wait_q;
+	u8 scan_wait_q_woken;
+	spinlock_t queue_lock;		/* lock for tx queues */
+	u8 country_code[IEEE80211_COUNTRY_STRING_LEN];
+	u16 max_mgmt_ie_index;
+	const struct firmware *cal_data;
+	struct device_node *dt_node;
+
+	/* 11AC */
+	u32 is_hw_11ac_capable;
+	u32 hw_dot_11ac_dev_cap;
+	u32 hw_dot_11ac_mcs_support;
+	u32 usr_dot_11ac_dev_cap_bg;
+	u32 usr_dot_11ac_dev_cap_a;
+	u32 usr_dot_11ac_mcs_support;
+
+	atomic_t pending_bridged_pkts;
+
+	/* For synchronizing FW initialization with device lifecycle. */
+	struct completion *fw_done;
+	bool is_up;
+
+	bool ext_scan;
+	u8 fw_api_ver;
+	u8 key_api_major_ver, key_api_minor_ver;
+	u8 max_sta_conn;
+	struct memory_type_mapping *mem_type_mapping_tbl;
+	u8 num_mem_types;
+	bool scan_chan_gap_enabled;
+	struct sk_buff_head rx_data_q;
+	struct nxpwifi_chan_stats *chan_stats;
+	u32 num_in_chan_stats;
+	int survey_idx;
+	u8 coex_scan;
+	u8 coex_min_scan_time;
+	u8 coex_max_scan_time;
+	u8 coex_win_size;
+	u8 coex_tx_win_size;
+	u8 coex_rx_win_size;
+	u8 active_scan_triggered;
+	bool usb_mc_status;
+	bool usb_mc_setup;
+	struct cfg80211_wowlan_nd_info *nd_info;
+	struct ieee80211_regdomain *regd;
+
+	/* Wake-on-WLAN (WoWLAN) */
+	int irq_wakeup;
+	bool wake_by_wifi;
+	/* Aggregation parameters*/
+	struct bus_aggr_params bus_aggr;
+	/* Device dump data/length */
+	void *devdump_data;
+	int devdump_len;
+	struct delayed_work devdump_work;
+
+	bool ignore_btcoex_events;
+};
+
+void nxpwifi_process_tx_queue(struct nxpwifi_adapter *adapter);
+
+int nxpwifi_init_lock_list(struct nxpwifi_adapter *adapter);
+
+void nxpwifi_set_trans_start(struct net_device *dev);
+
+void nxpwifi_stop_net_dev_queue(struct net_device *netdev,
+				struct nxpwifi_adapter *adapter);
+
+void nxpwifi_wake_up_net_dev_queue(struct net_device *netdev,
+				   struct nxpwifi_adapter *adapter);
+
+int nxpwifi_init_priv(struct nxpwifi_private *priv);
+void nxpwifi_free_priv(struct nxpwifi_private *priv);
+
+int nxpwifi_init_fw(struct nxpwifi_adapter *adapter);
+
+int nxpwifi_init_fw_complete(struct nxpwifi_adapter *adapter);
+
+void nxpwifi_shutdown_drv(struct nxpwifi_adapter *adapter);
+
+int nxpwifi_dnld_fw(struct nxpwifi_adapter *adapter,
+		    struct nxpwifi_fw_image *fw);
+
+int nxpwifi_recv_packet(struct nxpwifi_private *priv, struct sk_buff *skb);
+int nxpwifi_uap_recv_packet(struct nxpwifi_private *priv,
+			    struct sk_buff *skb);
+
+void nxpwifi_host_mlme_disconnect(struct nxpwifi_private *priv,
+				  u16 reason_code, u8 *sa);
+
+int nxpwifi_process_mgmt_packet(struct nxpwifi_private *priv,
+				struct sk_buff *skb);
+
+int nxpwifi_complete_cmd(struct nxpwifi_adapter *adapter,
+			 struct cmd_ctrl_node *cmd_node);
+
+void nxpwifi_cmd_timeout_func(struct timer_list *t);
+
+int nxpwifi_get_debug_info(struct nxpwifi_private *priv,
+			   struct nxpwifi_debug_info *info);
+
+int nxpwifi_alloc_cmd_buffer(struct nxpwifi_adapter *adapter);
+void nxpwifi_free_cmd_buffer(struct nxpwifi_adapter *adapter);
+void nxpwifi_free_cmd_buffers(struct nxpwifi_adapter *adapter);
+void nxpwifi_cancel_all_pending_cmd(struct nxpwifi_adapter *adapter);
+void nxpwifi_cancel_pending_scan_cmd(struct nxpwifi_adapter *adapter);
+void nxpwifi_cancel_scan(struct nxpwifi_adapter *adapter);
+
+void nxpwifi_recycle_cmd_node(struct nxpwifi_adapter *adapter,
+			      struct cmd_ctrl_node *cmd_node);
+
+void nxpwifi_insert_cmd_to_pending_q(struct nxpwifi_adapter *adapter,
+				     struct cmd_ctrl_node *cmd_node);
+
+int nxpwifi_exec_next_cmd(struct nxpwifi_adapter *adapter);
+int nxpwifi_process_cmdresp(struct nxpwifi_adapter *adapter);
+void nxpwifi_process_assoc_resp(struct nxpwifi_adapter *adapter);
+int nxpwifi_handle_rx_packet(struct nxpwifi_adapter *adapter,
+			     struct sk_buff *skb);
+int nxpwifi_process_tx(struct nxpwifi_private *priv, struct sk_buff *skb,
+		       struct nxpwifi_tx_param *tx_param);
+int nxpwifi_send_null_packet(struct nxpwifi_private *priv, u8 flags);
+int nxpwifi_write_data_complete(struct nxpwifi_adapter *adapter,
+				struct sk_buff *skb, int aggr, int status);
+void nxpwifi_clean_txrx(struct nxpwifi_private *priv);
+u8 nxpwifi_check_last_packet_indication(struct nxpwifi_private *priv);
+void nxpwifi_check_ps_cond(struct nxpwifi_adapter *adapter);
+void nxpwifi_process_sleep_confirm_resp(struct nxpwifi_adapter *adapter,
+					u8 *pbuf, u32 upld_len);
+void nxpwifi_process_hs_config(struct nxpwifi_adapter *adapter);
+void nxpwifi_hs_activated_event(struct nxpwifi_private *priv,
+				u8 activated);
+int nxpwifi_set_hs_params(struct nxpwifi_private *priv, u16 action,
+			  int cmd_type, struct nxpwifi_ds_hs_cfg *hs_cfg);
+int nxpwifi_ret_802_11_hs_cfg(struct nxpwifi_private *priv,
+			      struct host_cmd_ds_command *resp);
+int nxpwifi_process_rx_packet(struct nxpwifi_private *priv,
+			      struct sk_buff *skb);
+int nxpwifi_process_sta_rx_packet(struct nxpwifi_private *priv,
+				  struct sk_buff *skb);
+int nxpwifi_process_uap_rx_packet(struct nxpwifi_private *priv,
+				  struct sk_buff *skb);
+int nxpwifi_handle_uap_rx_forward(struct nxpwifi_private *priv,
+				  struct sk_buff *skb);
+void nxpwifi_delete_all_station_list(struct nxpwifi_private *priv);
+void nxpwifi_wmm_del_peer_ra_list(struct nxpwifi_private *priv,
+				  const u8 *ra_addr);
+void nxpwifi_process_sta_txpd(struct nxpwifi_private *priv,
+			      struct sk_buff *skb);
+void nxpwifi_process_uap_txpd(struct nxpwifi_private *priv,
+			      struct sk_buff *skb);
+int nxpwifi_cmd_802_11_scan(struct host_cmd_ds_command *cmd,
+			    struct nxpwifi_scan_cmd_config *scan_cfg);
+void nxpwifi_queue_scan_cmd(struct nxpwifi_private *priv,
+			    struct cmd_ctrl_node *cmd_node);
+int nxpwifi_ret_802_11_scan(struct nxpwifi_private *priv,
+			    struct host_cmd_ds_command *resp);
+int nxpwifi_associate(struct nxpwifi_private *priv,
+		      struct nxpwifi_bssdescriptor *bss_desc);
+int nxpwifi_cmd_802_11_associate(struct nxpwifi_private *priv,
+				 struct host_cmd_ds_command *cmd,
+				 struct nxpwifi_bssdescriptor *bss_desc);
+int nxpwifi_ret_802_11_associate(struct nxpwifi_private *priv,
+				 struct host_cmd_ds_command *resp);
+u8 nxpwifi_band_to_radio_type(u8 band);
+int nxpwifi_deauthenticate(struct nxpwifi_private *priv, u8 *mac);
+void nxpwifi_deauthenticate_all(struct nxpwifi_adapter *adapter);
+int nxpwifi_cmd_802_11_bg_scan_query(struct host_cmd_ds_command *cmd);
+struct nxpwifi_chan_freq_power *nxpwifi_get_cfp(struct nxpwifi_private *priv,
+						u8 band, u16 channel, u32 freq);
+u32 nxpwifi_index_to_data_rate(struct nxpwifi_private *priv,
+			       u8 index, u8 ht_info);
+u32 nxpwifi_index_to_acs_data_rate(struct nxpwifi_private *priv,
+				   u8 index, u8 ht_info);
+int nxpwifi_cmd_append_vsie_tlv(struct nxpwifi_private *priv, u16 vsie_mask,
+				u8 **buffer);
+u32 nxpwifi_get_active_data_rates(struct nxpwifi_private *priv,
+				  u8 *rates);
+u32 nxpwifi_get_supported_rates(struct nxpwifi_private *priv, u8 *rates);
+u32 nxpwifi_get_rates_from_cfg80211(struct nxpwifi_private *priv,
+				    u8 *rates, u8 radio_type);
+u8 nxpwifi_is_rate_auto(struct nxpwifi_private *priv);
+extern u16 region_code_index[NXPWIFI_MAX_REGION_CODE];
+void nxpwifi_save_curr_bcn(struct nxpwifi_private *priv);
+void nxpwifi_free_curr_bcn(struct nxpwifi_private *priv);
+int is_command_pending(struct nxpwifi_adapter *adapter);
+void nxpwifi_init_priv_params(struct nxpwifi_private *priv,
+			      struct net_device *dev);
+void nxpwifi_set_ba_params(struct nxpwifi_private *priv);
+void nxpwifi_update_ampdu_txwinsize(struct nxpwifi_adapter *pmadapter);
+void nxpwifi_set_11ac_ba_params(struct nxpwifi_private *priv);
+int nxpwifi_cmd_802_11_scan_ext(struct nxpwifi_private *priv,
+				struct host_cmd_ds_command *cmd,
+				void *data_buf);
+int nxpwifi_ret_802_11_scan_ext(struct nxpwifi_private *priv,
+				struct host_cmd_ds_command *resp);
+int nxpwifi_handle_event_ext_scan_report(struct nxpwifi_private *priv,
+					 void *buf);
+int nxpwifi_cmd_802_11_bg_scan_config(struct nxpwifi_private *priv,
+				      struct host_cmd_ds_command *cmd,
+				      void *data_buf);
+int nxpwifi_stop_bg_scan(struct nxpwifi_private *priv);
+
+/* This function checks if the queuing is RA based or not.
+ */
+static inline u8
+nxpwifi_queuing_ra_based(struct nxpwifi_private *priv)
+{
+	/* Currently we assume if we are in Infra, then DA=RA. This might not be
+	 * true in the future
+	 */
+	if (priv->bss_mode == NL80211_IFTYPE_STATION &&
+	    (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA))
+		return false;
+
+	return true;
+}
+
+/* This function copies rates.
+ */
+static inline u32
+nxpwifi_copy_rates(u8 *dest, u32 pos, u8 *src, int len)
+{
+	int i;
+
+	for (i = 0; i < len && src[i]; i++, pos++) {
+		if (pos >= NXPWIFI_SUPPORTED_RATES)
+			break;
+		dest[pos] = src[i];
+	}
+
+	return pos;
+}
+
+/* This function returns the correct private structure pointer based
+ * upon the BSS type and BSS number.
+ */
+static inline struct nxpwifi_private *
+nxpwifi_get_priv_by_id(struct nxpwifi_adapter *adapter,
+		       u8 bss_num, u8 bss_type)
+{
+	int i;
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		if (adapter->priv[i]) {
+			if (adapter->priv[i]->bss_num == bss_num &&
+			    adapter->priv[i]->bss_type == bss_type)
+				break;
+		}
+	}
+	return ((i < adapter->priv_num) ? adapter->priv[i] : NULL);
+}
+
+/* This function returns the first available private structure pointer
+ * based upon the BSS role.
+ */
+static inline struct nxpwifi_private *
+nxpwifi_get_priv(struct nxpwifi_adapter *adapter,
+		 enum nxpwifi_bss_role bss_role)
+{
+	int i;
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		if (adapter->priv[i]) {
+			if (bss_role == NXPWIFI_BSS_ROLE_ANY ||
+			    GET_BSS_ROLE(adapter->priv[i]) == bss_role)
+				break;
+		}
+	}
+
+	return ((i < adapter->priv_num) ? adapter->priv[i] : NULL);
+}
+
+/* This function checks available bss_num when adding new interface or
+ * changing interface type.
+ */
+static inline u8
+nxpwifi_get_unused_bss_num(struct nxpwifi_adapter *adapter, u8 bss_type)
+{
+	u8 i, j;
+	int index[NXPWIFI_MAX_BSS_NUM];
+
+	memset(index, 0, sizeof(index));
+	for (i = 0; i < adapter->priv_num; i++)
+		if (adapter->priv[i]) {
+			if (adapter->priv[i]->bss_type == bss_type &&
+			    !(adapter->priv[i]->bss_mode ==
+			      NL80211_IFTYPE_UNSPECIFIED)) {
+				index[adapter->priv[i]->bss_num] = 1;
+			}
+		}
+	for (j = 0; j < NXPWIFI_MAX_BSS_NUM; j++)
+		if (!index[j])
+			return j;
+	return -1;
+}
+
+/* This function returns the first available unused private structure pointer.
+ */
+static inline struct nxpwifi_private *
+nxpwifi_get_unused_priv_by_bss_type(struct nxpwifi_adapter *adapter,
+				    u8 bss_type)
+{
+	u8 i;
+
+	for (i = 0; i < adapter->priv_num; i++)
+		if (adapter->priv[i]->bss_mode ==
+		   NL80211_IFTYPE_UNSPECIFIED) {
+			adapter->priv[i]->bss_num =
+			nxpwifi_get_unused_bss_num(adapter, bss_type);
+			break;
+		}
+
+	return ((i < adapter->priv_num) ? adapter->priv[i] : NULL);
+}
+
+/* This function returns the driver private structure of a network device.
+ */
+static inline struct nxpwifi_private *
+nxpwifi_netdev_get_priv(struct net_device *dev)
+{
+	return (struct nxpwifi_private *)(*(unsigned long *)netdev_priv(dev));
+}
+
+/* This function checks if a skb holds a management frame.
+ */
+static inline bool nxpwifi_is_skb_mgmt_frame(struct sk_buff *skb)
+{
+	return (get_unaligned_le32(skb->data) == PKT_TYPE_MGMT);
+}
+
+/* This function retrieves channel closed for operation by Channel
+ * Switch Announcement.
+ */
+static inline u8
+nxpwifi_11h_get_csa_closed_channel(struct nxpwifi_private *priv)
+{
+	if (!priv->csa_chan)
+		return 0;
+
+	/* Clear csa channel, if DFS channel move time has passed */
+	if (time_after(jiffies, priv->csa_expire_time)) {
+		priv->csa_chan = 0;
+		priv->csa_expire_time = 0;
+	}
+
+	return priv->csa_chan;
+}
+
+static inline u8 nxpwifi_is_any_intf_active(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_private *priv_num;
+	int i;
+
+	for (i = 0; i < priv->adapter->priv_num; i++) {
+		priv_num = priv->adapter->priv[i];
+		if (priv_num) {
+			if ((GET_BSS_ROLE(priv_num) == NXPWIFI_BSS_ROLE_UAP &&
+			     priv_num->bss_started) ||
+			    (GET_BSS_ROLE(priv_num) == NXPWIFI_BSS_ROLE_STA &&
+			     priv_num->media_connected))
+				return 1;
+		}
+	}
+
+	return 0;
+}
+
+/* Disable platform specific wakeup interrupt */
+static inline void nxpwifi_disable_wake(struct nxpwifi_adapter *adapter)
+{
+	if (adapter->irq_wakeup >= 0) {
+		disable_irq_wake(adapter->irq_wakeup);
+		disable_irq(adapter->irq_wakeup);
+		if (adapter->wake_by_wifi)
+			/* Undo our disable, since interrupt handler already
+			 * did this.
+			 */
+			enable_irq(adapter->irq_wakeup);
+	}
+}
+
+/* Enable platform specific wakeup interrupt */
+static inline void nxpwifi_enable_wake(struct nxpwifi_adapter *adapter)
+{
+	/* Enable platform specific wakeup interrupt */
+	if (adapter->irq_wakeup >= 0) {
+		adapter->wake_by_wifi = false;
+		enable_irq(adapter->irq_wakeup);
+		enable_irq_wake(adapter->irq_wakeup);
+	}
+}
+
+int nxpwifi_init_shutdown_fw(struct nxpwifi_private *priv,
+			     u32 func_init_shutdown);
+
+int nxpwifi_add_card(void *card, struct completion *fw_done,
+		     struct nxpwifi_if_ops *if_ops, u8 iface_type,
+		     struct device *dev);
+int nxpwifi_remove_card(struct nxpwifi_adapter *adapter);
+
+void nxpwifi_get_version(struct nxpwifi_adapter *adapter, char *version,
+			 int maxlen);
+int
+nxpwifi_request_set_multicast_list(struct nxpwifi_private *priv,
+				   struct nxpwifi_multicast_list *mcast_list);
+int nxpwifi_copy_mcast_addr(struct nxpwifi_multicast_list *mlist,
+			    struct net_device *dev);
+int nxpwifi_wait_queue_complete(struct nxpwifi_adapter *adapter,
+				struct cmd_ctrl_node *cmd_queued);
+int nxpwifi_bss_start(struct nxpwifi_private *priv, struct cfg80211_bss *bss,
+		      struct cfg80211_ssid *req_ssid);
+int nxpwifi_cancel_hs(struct nxpwifi_private *priv, int cmd_type);
+int nxpwifi_enable_hs(struct nxpwifi_adapter *adapter);
+int nxpwifi_disable_auto_ds(struct nxpwifi_private *priv);
+int nxpwifi_drv_get_data_rate(struct nxpwifi_private *priv, u32 *rate);
+int nxpwifi_request_scan(struct nxpwifi_private *priv,
+			 struct cfg80211_ssid *req_ssid);
+int nxpwifi_scan_networks(struct nxpwifi_private *priv,
+			  const struct nxpwifi_user_scan_cfg *user_scan_in);
+int nxpwifi_set_radio(struct nxpwifi_private *priv, u8 option);
+
+int nxpwifi_set_encode(struct nxpwifi_private *priv, struct key_params *kp,
+		       const u8 *key, int key_len, u8 key_index,
+		       const u8 *mac_addr, int disable);
+
+int nxpwifi_set_gen_ie(struct nxpwifi_private *priv, const u8 *ie, int ie_len);
+
+int nxpwifi_get_ver_ext(struct nxpwifi_private *priv, u32 version_str_sel);
+
+int nxpwifi_remain_on_chan_cfg(struct nxpwifi_private *priv, u16 action,
+			       struct ieee80211_channel *chan,
+			       unsigned int duration);
+
+int nxpwifi_get_stats_info(struct nxpwifi_private *priv,
+			   struct nxpwifi_ds_get_stats *log);
+
+int nxpwifi_reg_write(struct nxpwifi_private *priv, u32 reg_type,
+		      u32 reg_offset, u32 reg_value);
+
+int nxpwifi_reg_read(struct nxpwifi_private *priv, u32 reg_type,
+		     u32 reg_offset, u32 *value);
+
+int nxpwifi_eeprom_read(struct nxpwifi_private *priv, u16 offset, u16 bytes,
+			u8 *value);
+
+int nxpwifi_set_11n_httx_cfg(struct nxpwifi_private *priv, int data);
+
+int nxpwifi_get_11n_httx_cfg(struct nxpwifi_private *priv, int *data);
+
+int nxpwifi_set_tx_rate_cfg(struct nxpwifi_private *priv, int tx_rate_index);
+
+int nxpwifi_get_tx_rate_cfg(struct nxpwifi_private *priv, int *tx_rate_index);
+
+int nxpwifi_drv_set_power(struct nxpwifi_private *priv, u32 *ps_mode);
+
+int nxpwifi_drv_get_driver_version(struct nxpwifi_adapter *adapter,
+				   char *version, int max_len);
+
+int nxpwifi_set_tx_power(struct nxpwifi_private *priv,
+			 struct nxpwifi_power_cfg *power_cfg);
+
+int nxpwifi_main_process(struct nxpwifi_adapter *adapter);
+
+int nxpwifi_queue_tx_pkt(struct nxpwifi_private *priv, struct sk_buff *skb);
+
+int nxpwifi_get_bss_info(struct nxpwifi_private *priv,
+			 struct nxpwifi_bss_info *info);
+int nxpwifi_fill_new_bss_desc(struct nxpwifi_private *priv,
+			      struct cfg80211_bss *bss,
+			      struct nxpwifi_bssdescriptor *bss_desc);
+int nxpwifi_update_bss_desc_with_ie(struct nxpwifi_adapter *adapter,
+				    struct nxpwifi_bssdescriptor *bss_entry);
+int nxpwifi_check_network_compatibility(struct nxpwifi_private *priv,
+					struct nxpwifi_bssdescriptor *bss_desc);
+
+u8 nxpwifi_chan_type_to_sec_chan_offset(enum nl80211_channel_type chan_type);
+u8 nxpwifi_get_chan_type(struct nxpwifi_private *priv);
+
+struct wireless_dev *nxpwifi_add_virtual_intf(struct wiphy *wiphy,
+					      const char *name,
+					      unsigned char name_assign_type,
+					      enum nl80211_iftype type,
+					      struct vif_params *params);
+int nxpwifi_del_virtual_intf(struct wiphy *wiphy, struct wireless_dev *wdev);
+
+int nxpwifi_add_wowlan_magic_pkt_filter(struct nxpwifi_adapter *adapter);
+
+int nxpwifi_set_mgmt_ies(struct nxpwifi_private *priv,
+			 struct cfg80211_beacon_data *data);
+int nxpwifi_del_mgmt_ies(struct nxpwifi_private *priv);
+u8 *nxpwifi_11d_code_2_region(u8 code);
+void nxpwifi_init_11h_params(struct nxpwifi_private *priv);
+int nxpwifi_is_11h_active(struct nxpwifi_private *priv);
+int nxpwifi_11h_activate(struct nxpwifi_private *priv, bool flag);
+void nxpwifi_11h_process_join(struct nxpwifi_private *priv, u8 **buffer,
+			      struct nxpwifi_bssdescriptor *bss_desc);
+int nxpwifi_11h_handle_event_chanswann(struct nxpwifi_private *priv);
+void nxpwifi_dnld_txpwr_table(struct nxpwifi_private *priv);
+
+extern const struct ethtool_ops nxpwifi_ethtool_ops;
+
+void nxpwifi_del_all_sta_list(struct nxpwifi_private *priv);
+void nxpwifi_del_sta_entry(struct nxpwifi_private *priv, const u8 *mac);
+void
+nxpwifi_set_sta_ht_cap(struct nxpwifi_private *priv, const u8 *ies,
+		       int ies_len, struct nxpwifi_sta_node *node);
+struct nxpwifi_sta_node *
+nxpwifi_add_sta_entry(struct nxpwifi_private *priv, const u8 *mac);
+struct nxpwifi_sta_node *
+nxpwifi_get_sta_entry(struct nxpwifi_private *priv, const u8 *mac);
+bool nxpwifi_is_bss_in_11ac_mode(struct nxpwifi_private *priv);
+u8 nxpwifi_get_center_freq_index(struct nxpwifi_private *priv, u8 band,
+				 u32 pri_chan, u8 chan_bw);
+int nxpwifi_init_channel_scan_gap(struct nxpwifi_adapter *adapter);
+
+int nxpwifi_cmd_issue_chan_report_request(struct nxpwifi_private *priv,
+					  struct host_cmd_ds_command *cmd,
+					  void *data_buf);
+int nxpwifi_11h_handle_chanrpt_ready(struct nxpwifi_private *priv,
+				     struct sk_buff *skb);
+
+void nxpwifi_parse_tx_status_event(struct nxpwifi_private *priv,
+				   void *event_body);
+
+struct sk_buff *
+nxpwifi_clone_skb_for_tx_status(struct nxpwifi_private *priv,
+				struct sk_buff *skb, u8 flag, u64 *cookie);
+void nxpwifi_dfs_cac_work_queue(struct work_struct *work);
+void nxpwifi_dfs_chan_sw_work_queue(struct work_struct *work);
+void nxpwifi_abort_cac(struct nxpwifi_private *priv);
+int nxpwifi_stop_radar_detection(struct nxpwifi_private *priv,
+				 struct cfg80211_chan_def *chandef);
+int nxpwifi_11h_handle_radar_detected(struct nxpwifi_private *priv,
+				      struct sk_buff *skb);
+
+void nxpwifi_hist_data_set(struct nxpwifi_private *priv, u8 rx_rate, s8 snr,
+			   s8 nflr);
+void nxpwifi_hist_data_reset(struct nxpwifi_private *priv);
+void nxpwifi_hist_data_add(struct nxpwifi_private *priv,
+			   u8 rx_rate, s8 snr, s8 nflr);
+u8 nxpwifi_adjust_data_rate(struct nxpwifi_private *priv,
+			    u8 rx_rate, u8 ht_info);
+
+void nxpwifi_drv_info_dump(struct nxpwifi_adapter *adapter);
+void nxpwifi_prepare_fw_dump_info(struct nxpwifi_adapter *adapter);
+void nxpwifi_upload_device_dump(struct nxpwifi_adapter *adapter);
+void *nxpwifi_alloc_dma_align_buf(int rx_len, gfp_t flags);
+void nxpwifi_fw_dump_event(struct nxpwifi_private *priv);
+void nxpwifi_queue_main_work(struct nxpwifi_adapter *adapter);
+int nxpwifi_get_wakeup_reason(struct nxpwifi_private *priv, u16 action,
+			      int cmd_type,
+			      struct nxpwifi_ds_wakeup_reason *wakeup_reason);
+int nxpwifi_get_chan_info(struct nxpwifi_private *priv,
+			  struct nxpwifi_channel_band *channel_band);
+void nxpwifi_coex_ampdu_rxwinsize(struct nxpwifi_adapter *adapter);
+void nxpwifi_11n_delba(struct nxpwifi_private *priv, int tid);
+int nxpwifi_send_domain_info_cmd_fw(struct wiphy *wiphy);
+int nxpwifi_set_mac_address(struct nxpwifi_private *priv,
+			    struct net_device *dev,
+			    bool external, u8 *new_mac);
+void nxpwifi_devdump_tmo_func(unsigned long function_context);
+
+#ifdef CONFIG_DEBUG_FS
+void nxpwifi_debugfs_init(void);
+void nxpwifi_debugfs_remove(void);
+
+void nxpwifi_dev_debugfs_init(struct nxpwifi_private *priv);
+void nxpwifi_dev_debugfs_remove(struct nxpwifi_private *priv);
+#endif
+int nxpwifi_reinit_sw(struct nxpwifi_adapter *adapter);
+int nxpwifi_shutdown_sw(struct nxpwifi_adapter *adapter);
+#endif /* !_NXPWIFI_MAIN_H_ */
-- 
2.34.1


