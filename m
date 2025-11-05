Return-Path: <linux-wireless+bounces-28583-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC08C3538F
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 11:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B88294F7897
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 10:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C5B30E84A;
	Wed,  5 Nov 2025 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LM5nCAHj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013015.outbound.protection.outlook.com [40.107.159.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A54B30DEB9;
	Wed,  5 Nov 2025 10:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339758; cv=fail; b=mS2BrUmJBnL8y+OMYThDHCe8+IYUVjiBb0rqzqSuxaGcGxHQDtTd9kQkFFQ6LLdWF6Rxv0diiBLOIibspdwR6pRjEuRZst16jQsa4U72iBraDm3r6DI/Jjrrl3ttsULJNiwiwFeHO8pn9UErwepDX6pdNDJydI/vUfoseY4eHBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339758; c=relaxed/simple;
	bh=dalHNIdWXglkF3sJyCYolFnHPpYPDaYNSCr/VFOOihA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V3ritNuy7tBOMI5XE6GUsbr72+dEPw9FQXkxEx7YVUAik2ox2rjTYcjuthKggDWauh0YLVzNPVbL+zXJQV1XhCb8AaL9Q7qRZnfAcT5faxjuV2ncH3srJwPs68pRjjIYybW48pB6UUXxfvbI7aiABigE6VyR3ZkoPT38QO7qwMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LM5nCAHj; arc=fail smtp.client-ip=40.107.159.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r26eruOkwkXadVZM6lYz7XdeY62Gsj/+z/UwQkaD5IVBVm2VFxR2Zw/tjOlpH3CkLhPTX7Wn3mFg7tMs0rAQm/VKWO7WtBL/grcSIuZFIYQQh49qJTzO6c5BlRQG5r1SxqPEqV0K82HmaShGT8siu5D7EuCxsZXvjg8BhHOp9JE6RUTAhfYp7Ms6CPYi78Lm6A0IUMoN4hKVnULr3L2kefvup/IHwhlm85NMlQvHHqy4OeXgBcN5mmpmJNcdeI01tLeoA6Q1qP88Whg5puMnqpZXf5rXZ6IdYj6QDUW2sk3pVNnQ8n/rnWHkq+/OlvFymfkO6JLY4Lro2K89WU/x+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twR6G1pYVi1RWELpm9P0FuRjHScQnfMvCcipcR4n9zg=;
 b=ROHqRmbFJBqFFcKl5ZzxgOEuQDgMNlTxEXKnEyDJYP/klvGc+50R7exRImoL/Qjv9i84M7isZH00IcQ2ntEuhWbuOntSt3oejL8hH+wJ3Pu8jH2HaP2VghKi1Fojc9q6CKLsuvCmugIOwS4AI0IfWys186m4KWZnuwX3moW59zH1rVzOW4WO/tTAGc7YQaGYCcrj6CYMyOGZoBpiMQUTLDBjx9pBqbezPcU00XPP3U/tsE6FU6i/qfikIV0u2lkkBcqIkeVtx/abggd6kkwXCC3FjYVVrVMJ8zOqg08GSxCbrUe9B0Inr9DPZxMaXVl5h9CRwT9jbWka4E8KI5YluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twR6G1pYVi1RWELpm9P0FuRjHScQnfMvCcipcR4n9zg=;
 b=LM5nCAHjRl+E3xYbnd3nIaEFb2b5YhhKF2UU7A8lbUHNaCK+5bIJcNnfId+AghJk5UQ5gWBzDuc/GSZFCd7FFTci4CqfV715n5Ph3GRwRXItzI2vm9Mn6AueBRP7EBPs8tpIArcKv+TqQFXIKq5Z41xQcvzvTosbvmKXdsUvNoTwylt5aTQhYMasfi6fqVdoYbldrScuHTPtWjN/Zg52ebcw2nWp8VCkFPt1yBys4nTZHfxUuafckUxUkeF1UQ1BYpjFs5ldd/NvwX4g2KHDigNo679c6qFkMGhXNw3RHpbIS/gijpz1hX9mMh3f2UGTkaUCDbKwRjwHlhmP2Lv8lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by DBAPR04MB7429.eurprd04.prod.outlook.com (2603:10a6:10:1a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Wed, 5 Nov
 2025 10:49:11 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%2]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 10:49:11 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v6 05/22] wifi: nxpwifi: add support for WMM
Date: Wed,  5 Nov 2025 18:47:27 +0800
Message-Id: <20251105104744.2401992-6-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105104744.2401992-1-jeff.chen_1@nxp.com>
References: <20251105104744.2401992-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::23) To DBBPR04MB7740.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|DBAPR04MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: c406ce0e-02b1-4634-7836-08de1c58f3c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iQFZoscW+w7T3QT4tZov6hYjFkZ0Lk2Rp66O0hGQl1/FaoIVrkrC8PNQTJXT?=
 =?us-ascii?Q?H6dUtcN/bLzo1OxjIBYZTdUaLcMjY+XFND73sf6+xPQAw9KQ0YQmqWQjAIja?=
 =?us-ascii?Q?Lj5DA4dNkUtr/9aXrlsbo4sf5ieZ4EdmzN7Fd6D8Mf8MH++ZgvUzB8nN8M1m?=
 =?us-ascii?Q?lBpZ91EM9alkoAXb7p83e5xu5LLgF1BSrb+3nj1Qu9c+DVLblxrGCAg/TwHR?=
 =?us-ascii?Q?0qMTMiApaMALBrOUkCt2sAIPMjce6PHkZskcCRpW7jVE9Em7nnDKNcfrL54b?=
 =?us-ascii?Q?rRo+d82BOLngSIYpqkEN/iMMFsTHT92vYuUx6KRLuY0xuM5f8EpA7yNji47L?=
 =?us-ascii?Q?h3TA2j9iPUTdpHUgsUxwAXl4WocwEokdVSX/BfOruOIECZIrjRUqqetmMBwF?=
 =?us-ascii?Q?0AimN6JZidTxQ8ujaFeOL+z6wqvMq36oIdL0AO4QYBYgsk1iaAZCYLaLQs9v?=
 =?us-ascii?Q?Fi4YVAM4K3gjm7X03FKIDV9ErO296pJNUGt2s8Ek9KP0rgfmXsLY/Ys0iA4u?=
 =?us-ascii?Q?zFgvk2o51hqZUl/5DXlse9zEl4mplPDkuXBuZ6ReUtMgU0c0UDT0TG8Xj4ZB?=
 =?us-ascii?Q?1iYzKWe6+mw26P7IkCzbyTw8ATK53w6Tx2BYnPdyxKUc1Lh8nq3+N1HEGSam?=
 =?us-ascii?Q?REkj3Z/Jsz/83WKGpZf1fI/jR731PshuRqlZsQtXEvKoItCMxH5+8sn71ygk?=
 =?us-ascii?Q?/w3Y6WlyYIO5ImHl9CQDdD/1hPfgc+kiqUczK5VKtif7MueoAJhyHbFkJ3oJ?=
 =?us-ascii?Q?clJNn+NI8GMKea6wei/AlDIsU37RfZbeTBlmCaKp4tjMkppQ5m7SpJyoyDJm?=
 =?us-ascii?Q?WYU7JKg9zE1yNyTkUnf1DuJfhR0wSKFkeG4JBrBYE0G78namVI8j7MLiBSTs?=
 =?us-ascii?Q?Cja+lfno3+uYyu2pNdKVUooDQhaiAkemfCLqsn4x+biE4mg9Cq0+iYf+mlsr?=
 =?us-ascii?Q?xLWKfBL2wVIn6cjB8q1LEG5BEmo/jb26ztVjAxKeYm51Je6FdGFzDO6Q7mTh?=
 =?us-ascii?Q?ofFs69awZUDIuTjVgzTXE701R722Pw49H9CkGTrrSAYByoS+YSF1bRnYudQk?=
 =?us-ascii?Q?s+2/DNeA6Ac7JS50mZowg4H1EZbx8to15PwwWWEgq0WZU2NfKvg3E++uG8TA?=
 =?us-ascii?Q?P/B2n0OVvygID1ISp6B23Q6TiqF10y9VwnZVam50pOFtdX1v5WHPzw6KIDP8?=
 =?us-ascii?Q?9P+0Nvo0Ww0esHbdjKoKvA9cAw1o3+wQ7H5C+I3UJVmWBNpEVuEymOJ7i1lU?=
 =?us-ascii?Q?NAbb0PbMtBgb4E39bH/iS8Ijw5cA+lFsbj8bMfjKoYxj0ti/L9Kcx37GuUYY?=
 =?us-ascii?Q?f2Z28DESMJE6p73rKHzpzsiCWdYu3GZGsSO54k0CAVN/xcXNT9VfLChC9oQ4?=
 =?us-ascii?Q?5fzsc0kvqKEnXYlYzL3z2LANbCQdp46EoPtqgC9wwTrY32z8V00H3AVMKMaO?=
 =?us-ascii?Q?Yrr6UzcxlkejZ57DD3eL2ndScFfIN+e9QmETC3DIVkJ9rnm3P7iT+x7gkbu4?=
 =?us-ascii?Q?PeVwslS8/vDKcFqzOxd+ROoTFnB6hO9sMm21?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z54orl4bMBXlsj3/2mnt1ZHnWiqw5lfw1Io/oHtUsr4UyoETwnRA1212GlaF?=
 =?us-ascii?Q?06duR7pXSoTQGFsHoPjRKMSgsgtdSL8WBlcgahGez8FaLd0FWdc7iAVV2U1/?=
 =?us-ascii?Q?QiXRCE6XdcyZcAWy1JuW6g/d8l/60wa7YM7oLCidLvdVCxR+vg1H+jM15aZL?=
 =?us-ascii?Q?A4wu1G9tPk+EqYuZ2Xm+BCdBlIXRbDD/ivdWCLKoD/RFWeCyZx1OjlEHqZic?=
 =?us-ascii?Q?hxtQi5AN3KAJ6f1pq0h9m2f4xIXAjjC3PgmSObIAaP2y3vuz5VpQ7qaiwJy0?=
 =?us-ascii?Q?rYRPNsAX/rIhYEKj8s+8C1XpqKlxIj19R7+DaO/jcGiEBRynypNeDMQBBwMd?=
 =?us-ascii?Q?iyacObvGmNhG1eBqKqjnkJ1NmZbWGMmDpzdMezX4SrBx8KBVOziN4s8GR39Z?=
 =?us-ascii?Q?fh6qAF9fPUWmG8YG5P2NWB4c52yYX1J8Ir/GuAih4cFBENxFvoDOvTduITzj?=
 =?us-ascii?Q?dLNdeLkraFcDTCSs1KvoZ7i8PdFq65w0/7gz9k5EocoFRIQUy4JBIfbN0zfs?=
 =?us-ascii?Q?WojSocaP7MWI4TaUKbQM6rwAq3DE4m5J5qKlFFh9auVQ/fen62xUuDnXnPMx?=
 =?us-ascii?Q?nnK2UsRC47aEFdga0ohnZkr16cIaeaJJlOYLezE5x7U4ChqSnmS67s0rD3Cv?=
 =?us-ascii?Q?oH81XXI1zSpZZahLuXcDjbquHaO9pXsent7FQgemalJmmkXO+CKlJ6FmIzAF?=
 =?us-ascii?Q?dEPuvKELohMm/vicQtG/F/C1RjiuUTPxDbZ+LDo0RSkF+u0fqxKMM/N/fte2?=
 =?us-ascii?Q?f3cHXUAXmk9bBYfE4awgq8pmMBw8Ir9OH5ufbapQawbusPiFeQEQTJVJHxjq?=
 =?us-ascii?Q?HXXuh94V1xMCYSujcMfj7x+OiDxQ0cf3gzNO+qOa6krWO4utPUCTR46fQlTl?=
 =?us-ascii?Q?ay76Qer4nZU2Sc25k/+ABdhprM7neXBDRnqhuUo8wHT9g3UIVjK3NZerjNGz?=
 =?us-ascii?Q?utdvtHfN7CDlE+bt2iUz3LbhRuYpEOxHknWkqZ0haX4UB5tnOTJjT1B9GIF5?=
 =?us-ascii?Q?J9DBQm4S01hwNH0fZUwHliQfNhsnzFgA1k+n6qqtU0dgReqAyF1E1tbWmueb?=
 =?us-ascii?Q?2OHDfAKkyp5cf6Kcfw5bdjN+Rs3xuWkpipSra8vDOnZPpaX4526caHyZ+mtb?=
 =?us-ascii?Q?6Q//crLtSgFQttwVawsyimUlsJh/4dWkWeDJkCzdS+Hk7Qe2gtMbMNNTZMR0?=
 =?us-ascii?Q?9s6ir8Dk8YSDCRfPTPPulFvlgt8KzJmth3VApmAcMbSNyhwsVVJQ3A57hbWS?=
 =?us-ascii?Q?pK9KIy73QaGJjZNdhZQABt3rGUEk4mQRK2s2yATVAqS9DY+Fx0OOb1FvDBfy?=
 =?us-ascii?Q?DH0qrawKL+NmnyCU7n4GZ9qQzCX0/zQe06Myv+e7l48ngycVy8o1k3ge4fsD?=
 =?us-ascii?Q?z6zML4y1tq90AjPC9k1s2TCdNKbtJDHErKj2jccXy2bCtaoWBLD9feftSCVx?=
 =?us-ascii?Q?3ZfCsOERQTO0dUWLM5yKWPywkabpzCBu1k/GA7KtRIqS9kLzsp9HD1xPch53?=
 =?us-ascii?Q?kaEOByYLrIm1KtBpAAwtNIkfGzJLfPmObBu5S4eoedSUzxU/Ir5qTjSCQCDO?=
 =?us-ascii?Q?E9ICJBGPCbMQCZmZ8YPWio6dySG/vrhAq/w9ObhP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c406ce0e-02b1-4634-7836-08de1c58f3c1
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 10:49:11.0988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbjIOyUIDX7EOYBCSTjkrIqZ7EXqQ96kkGWHLQ4QqZ0me1iIc/BEUygq/porCHGHAFMq27p2tMhx80W4fk5A+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7429

Introduce WMM functionality to the nxpwifi driver, enabling QoS-based
traffic prioritization and queue management for multimedia applications.

- Implements WMM AC queue setup and priority mapping
  based on WMM Parameter IE from AP.
- Adds support for TID-to-AC conversion, admission control handling,
  and downgrade logic for non-admitted traffic.
- Integrates AMSDU/AMPDU aggregation logic with per-TID RA list queues.
- Handles firmware interaction for WMM status reporting and association
  request TLV construction.
- Supports packet queuing, reordering, and transmission scheduling
  based on priority and aggregation eligibility.

This patch enhances traffic handling efficiency and ensures compliance
with WMM specifications for both STA and AP modes.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/wmm.c | 1379 ++++++++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/wmm.h |   78 ++
 2 files changed, 1457 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/wmm.c b/drivers/net/wireless/nxp/nxpwifi/wmm.c
new file mode 100644
index 000000000000..9da0bc94b5f9
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/wmm.c
@@ -0,0 +1,1379 @@
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
+/* This table inverses the tos_to_tid operation to get a priority
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
+/* WMM information IE */
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
+/* This function debug prints the priority parameters for a WMM AC.
+ */
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
+/* This function allocates a route address list.
+ *
+ * The function also initializes the list with the provided RA.
+ */
+static struct nxpwifi_ra_list_tbl *
+nxpwifi_wmm_allocate_ralist_node(struct nxpwifi_adapter *adapter, const u8 *ra)
+{
+	struct nxpwifi_ra_list_tbl *ra_list;
+
+	ra_list = kzalloc(sizeof(*ra_list), GFP_ATOMIC);
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
+/* This function returns random no between 16 and 32 to be used as threshold
+ * for no of packets after which BA setup is initiated.
+ */
+static u8 nxpwifi_get_random_ba_threshold(void)
+{
+	u64 ns;
+	/* setup ba_packet_threshold here random number between
+	 * [BA_SETUP_PACKET_OFFSET,
+	 * BA_SETUP_PACKET_OFFSET+BA_SETUP_MAX_PACKET_THRESHOLD-1]
+	 */
+	ns = ktime_get_ns();
+	ns += (ns >> 32) + (ns >> 16);
+
+	return ((u8)ns % BA_SETUP_MAX_PACKET_THRESHOLD) + BA_SETUP_PACKET_OFFSET;
+}
+
+/* This function allocates and adds a RA list for all TIDs
+ * with the given RA.
+ */
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
+/* This function sets the WMM queue priorities to their default values.
+ */
+static void nxpwifi_wmm_default_queue_priorities(struct nxpwifi_private *priv)
+{
+	/* Default queue priorities: VO->VI->BE->BK */
+	priv->wmm.queue_priority[0] = WMM_AC_VO;
+	priv->wmm.queue_priority[1] = WMM_AC_VI;
+	priv->wmm.queue_priority[2] = WMM_AC_BE;
+	priv->wmm.queue_priority[3] = WMM_AC_BK;
+}
+
+/* This function map ACs to TIDs.
+ */
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
+/* This function initializes WMM priority queues.
+ */
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
+		    "info: WMM Parameter IE: version=%d,\t"
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
+/* This function evaluates whether or not an AC is to be downgraded.
+ *
+ * In case the AC is not enabled, the highest AC is returned that is
+ * enabled and does not require admission control.
+ */
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
+	/*  Find the highest AC that is enabled and does not require
+	 *  admission control. The spec disallows downgrading to an AC,
+	 *  which is enabled due to a completed admission control.
+	 *  Unadmitted traffic is not to be sent on an AC with admitted
+	 *  traffic.
+	 */
+	for (down_ac = WMM_AC_BK; down_ac < eval_ac; down_ac++) {
+		ac_status = &priv->wmm.ac_status[down_ac];
+
+		if (!ac_status->disabled && !ac_status->flow_required)
+			/* AC is enabled and does not require admission
+			 * control
+			 */
+			ret_ac = (enum nxpwifi_wmm_ac_e)down_ac;
+	}
+
+	return ret_ac;
+}
+
+/* This function downgrades WMM priority queue.
+ */
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
+/* This function converts the IP TOS field to an WMM AC
+ * Queue assignment.
+ */
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
+/* This function evaluates a given TID and downgrades it to a lower
+ * TID if the WMM Parameter IE received from the AP indicates that the
+ * AP is disabled (due to call admission control (ACM bit). Mapping
+ * of TID to AC is taken care of internally.
+ */
+u8 nxpwifi_wmm_downgrade_tid(struct nxpwifi_private *priv, u32 tid)
+{
+	enum nxpwifi_wmm_ac_e ac, ac_down;
+	u8 new_tid;
+
+	ac = nxpwifi_wmm_convert_tos_to_ac(priv->adapter, tid);
+	ac_down = priv->wmm.ac_down_graded_vals[ac];
+
+	/* Send the index to tid array, picking from the array will be
+	 * taken care by dequeuing function
+	 */
+	new_tid = ac_to_tid[ac_down][tid % 2];
+
+	return new_tid;
+}
+
+/* This function initializes the WMM state information and the
+ * WMM data path queues.
+ */
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
+/* This function checks if WMM Tx queue is empty.
+ */
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
+/* This function deletes all packets in an RA list node.
+ *
+ * The packet sent completion callback handler are called with
+ * status failure, after they are dequeued to ensure proper
+ * cleanup. The RA list node itself is freed at the end.
+ */
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
+/* This function deletes all packets in an RA list.
+ *
+ * Each nodes in the RA list are freed individually first, and then
+ * the RA list itself is freed.
+ */
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
+/* This function deletes all packets in all RA lists.
+ */
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
+/* This function deletes all route addresses from all RA lists.
+ */
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
+/* This function cleans up the Tx and Rx queues.
+ *
+ * Cleanup includes -
+ *      - All packets in RA lists
+ *      - All entries in Rx reorder table
+ *      - All entries in Tx BA stream table
+ *      - MPA buffer (if required)
+ *      - All RA lists
+ */
+void
+nxpwifi_clean_txrx(struct nxpwifi_private *priv)
+{
+	struct sk_buff *skb, *tmp;
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
+	idr_for_each(&priv->ack_status_frames, nxpwifi_free_ack_frame, NULL);
+	idr_destroy(&priv->ack_status_frames);
+}
+
+/* This function retrieves a particular RA list node, matching with the
+ * given TID and RA address.
+ */
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
+/* This function retrieves an RA list node for a given TID and
+ * RA address pair.
+ *
+ * If no such node is found, a new node is added first and then
+ * retrieved.
+ */
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
+/* This function deletes RA list nodes for given mac for all TIDs.
+ * Function also decrements TX pending count accordingly.
+ */
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
+/* This function checks if a particular RA list node exists in a given TID
+ * table index.
+ */
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
+/* This function adds a packet to bypass TX queue.
+ * This is special TX queue for packets which can be sent even when port_open
+ * is false.
+ */
+void
+nxpwifi_wmm_add_buf_bypass_txqueue(struct nxpwifi_private *priv,
+				   struct sk_buff *skb)
+{
+	skb_queue_tail(&priv->bypass_txq, skb);
+}
+
+/* This function adds a packet to WMM queue.
+ *
+ * In disconnected state the packet is immediately dropped and the
+ * packet send completion callback is called with status failure.
+ *
+ * Otherwise, the correct RA list node is located and the packet
+ * is queued at the list tail.
+ */
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
+	/* In case of infra as we have already created the list during
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
+/* This function processes the get WMM status command response from firmware.
+ *
+ * The response may contain multiple TLVs -
+ *      - AC Queue status TLVs
+ *      - Current WMM Parameter IE TLV
+ *      - Admission Control action frame TLVs
+ *
+ * This function parses the TLVs and then calls further specific functions
+ * to process any changes in the queue prioritize or state.
+ */
+int nxpwifi_ret_wmm_get_status(struct nxpwifi_private *priv,
+			       const struct host_cmd_ds_command *resp)
+{
+	u8 *curr = (u8 *)&resp->params.get_wmm_status;
+	u16 resp_len = le16_to_cpu(resp->size), tlv_len;
+	int mask = IEEE80211_WMM_IE_AP_QOSINFO_PARAM_SET_CNT_MASK;
+	bool valid = true;
+
+	struct nxpwifi_ie_types_data *tlv_hdr;
+	struct nxpwifi_ie_types_wmm_queue_status *wmm_qs;
+	struct ieee80211_wmm_param_ie *wmm_param_ie = NULL;
+	struct nxpwifi_wmm_ac_status *ac_status;
+
+	nxpwifi_dbg(priv->adapter, INFO,
+		    "info: WMM: WMM_GET_STATUS cmdresp received: %d\n",
+		    resp_len);
+
+	while ((resp_len >= sizeof(tlv_hdr->header)) && valid) {
+		tlv_hdr = (struct nxpwifi_ie_types_data *)curr;
+		tlv_len = le16_to_cpu(tlv_hdr->header.len);
+
+		if (resp_len < tlv_len + sizeof(tlv_hdr->header))
+			break;
+
+		switch (le16_to_cpu(tlv_hdr->header.type)) {
+		case TLV_TYPE_WMMQSTATUS:
+			wmm_qs = (struct nxpwifi_ie_types_wmm_queue_status *)
+				tlv_hdr;
+			nxpwifi_dbg(priv->adapter, CMD,
+				    "info: CMD_RESP: WMM_GET_STATUS:\t"
+				    "QSTATUS TLV: %d, %d, %d\n",
+				    wmm_qs->queue_index,
+				    wmm_qs->flow_required,
+				    wmm_qs->disabled);
+
+			ac_status = &priv->wmm.ac_status[wmm_qs->queue_index];
+			ac_status->disabled = wmm_qs->disabled;
+			ac_status->flow_required = wmm_qs->flow_required;
+			ac_status->flow_created = wmm_qs->flow_created;
+			break;
+
+		case WLAN_EID_VENDOR_SPECIFIC:
+			/* Point the regular IEEE IE 2 bytes into the NXP IE
+			 *   and setup the IEEE IE type and length byte fields
+			 */
+
+			wmm_param_ie =
+				(struct ieee80211_wmm_param_ie *)(curr + 2);
+			wmm_param_ie->len = (u8)tlv_len;
+			wmm_param_ie->element_id = WLAN_EID_VENDOR_SPECIFIC;
+
+			nxpwifi_dbg(priv->adapter, CMD,
+				    "info: CMD_RESP: WMM_GET_STATUS:\t"
+				    "WMM Parameter Set Count: %d\n",
+				    wmm_param_ie->qos_info & mask);
+
+			if (wmm_param_ie->len + 2 >
+				sizeof(struct ieee80211_wmm_param_ie))
+				break;
+
+			memcpy(&priv->curr_bss_params.bss_descriptor.wmm_ie,
+			       wmm_param_ie, wmm_param_ie->len + 2);
+
+			break;
+
+		default:
+			valid = false;
+			break;
+		}
+
+		curr += (tlv_len + sizeof(tlv_hdr->header));
+		resp_len -= (tlv_len + sizeof(tlv_hdr->header));
+	}
+
+	nxpwifi_wmm_setup_queue_priorities(priv, wmm_param_ie);
+	nxpwifi_wmm_setup_ac_downgrade(priv);
+
+	return 0;
+}
+
+/* Callback handler from the command module to allow insertion of a WMM TLV.
+ *
+ * If the BSS we are associating to supports WMM, this function adds the
+ * required WMM Information IE to the association request command buffer in
+ * the form of a NXP extended IEEE IE.
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
+/* This function computes the time delay in the driver queues for a
+ * given packet.
+ *
+ * When the packet is received at the OS/Driver interface, the current
+ * time is set in the packet structure. The difference between the present
+ * time and that received time is computed in this function and limited
+ * based on pre-compiled limits in the driver.
+ */
+u8
+nxpwifi_wmm_compute_drv_pkt_delay(struct nxpwifi_private *priv,
+				  const struct sk_buff *skb)
+{
+	u32 queue_delay = ktime_to_ms(net_timedelta(skb->tstamp));
+	u8 ret_val;
+
+	/* Queue delay is passed as a uint8 in units of 2ms (ms shifted
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
+/* This function retrieves the highest priority RA list table pointer.
+ */
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
+				/* Iterate current private once more, since
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
+/* This functions rotates ra and bss lists so packets are picked round robin.
+ *
+ * After a packet is successfully transmitted, rotate the ra list, so the ra
+ * next to the one transmitted, will come first in the list. This way we pick
+ * the ra' in a round robin fashion. Same applies to bss nodes of equal
+ * priority.
+ *
+ * Function also increments wmm.packets_out counter.
+ */
+void nxpwifi_rotate_priolists(struct nxpwifi_private *priv,
+			      struct nxpwifi_ra_list_tbl *ra,
+			      int tid)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_bss_prio_tbl *tbl = adapter->bss_prio_tbl;
+	struct nxpwifi_tid_tbl *tid_ptr = &priv->wmm.tid_tbl_ptr[tid];
+
+	spin_lock_bh(&tbl[priv->bss_priority].bss_prio_lock);
+	/* dirty trick: we remove 'head' temporarily and reinsert it after
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
+/* This function checks if 11n aggregation is possible.
+ */
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
+/* This function sends a single packet to firmware for transmission.
+ */
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
+/* This function checks if the first packet in the given RA list
+ * is already processed or not.
+ */
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
+/* This function sends a single processed packet to firmware for
+ * transmission.
+ */
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
+/* This function dequeues a packet from the highest priority list
+ * and transmits it.
+ */
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
+		/* ra_list_spinlock has been freed in
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
+			/* ra_list_spinlock has been freed in
+			 * nxpwifi_11n_aggregate_pkt()
+			 */
+		else
+			nxpwifi_send_single_packet(priv, ptr, ptr_index);
+			/* ra_list_spinlock has been freed in
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
+			/* ra_list_spinlock has been freed in
+			 * nxpwifi_11n_aggregate_pkt()
+			 */
+		else
+			nxpwifi_send_single_packet(priv, ptr, ptr_index);
+			/* ra_list_spinlock has been freed in
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
+/* This function transmits the highest priority packet awaiting in the
+ * WMM Queues.
+ */
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
index 000000000000..fc9bbb989144
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/wmm.h
@@ -0,0 +1,78 @@
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
+/* This function retrieves the TID of the given RA list.
+ */
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


