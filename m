Return-Path: <linux-wireless+bounces-35518-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oyjSGxcO8WmXcQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35518-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:44:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9D648B477
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9628C30F633C
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 19:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7178C38D69D;
	Tue, 28 Apr 2026 19:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IIkdMdVK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013018.outbound.protection.outlook.com [40.107.162.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EC03859EB;
	Tue, 28 Apr 2026 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777405302; cv=fail; b=RvX3YniOwlXLvtIvVVhbN5/kLl+YyyjvfnrM760SbcXg3w+P9CbGBRJ3uNp1aEaZexqKhpCvQe4PaJ69KMwzQuJSlHqQi9Nj9nsj+UUqmrsAVyj42XRWusyZUY0p2Tqdpkfwhdg9nDYbC2x3DV9P8r4SigiLbD+DiPE142xzpL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777405302; c=relaxed/simple;
	bh=X4tyew27ss+8EV1AVc7ECrikE0pglw1ekcb4EyOJ5Qk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rbOSsSWr10zWhjJfYkhRzfOAeCw49OK33+6kX4/Lqs/yrhup8KAFaoMSKvHt3JgrZ/ZsrtcMcow+ohHznl7oAh2bsNA3lyfAzP8TJNE9TU+0QxO/nwpLTXbzdZKY+eem9VCoErrGIV5XIyf08y1GUJkkM+AM8sB+ajayKzErB5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IIkdMdVK; arc=fail smtp.client-ip=40.107.162.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWO5jVyclTU3LC6U3ZQykKnA4qhZiQEb3uKuAHTVeWWCNnGx3nJHiGpo2f5Qu/Z28lFDUoTdnWLXYc3PPX4KTBewO2AT7guUsLEXpKAVdTXs6SGWgU7OaUladHGshWsrhfndH6y3pJGmDwIRMO9hG3WFbMWCoJNznuHnha1wIKpgqf2zRI/8IjK9/NmyOPUnGMU/IXwBd72Eyyerog4NM3XNUjpuu1cMBJdxiI6p4vJcfHmGGaZW5l9aoZMUKrr855w25xnu4fNlSRE+9XIc+6pfrGkKJB80BmfhPLLyp/2kq314Afp1DkgPwAON1QD/DX2o6OB3VLO6pMTD0t1WEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkDtWXVa4ZoeLDyWVEBqFikdsTP5c5iGpGdXY3YkmiI=;
 b=kMaQxi522l/RPcYyxoE4IHwrKV+52pR2huhvOw/S8PFh/oND+hL4jDCzhpdLCmS+YQSpbKDbESA8t4G56izU9b7tJUL7rFhBq6WHRKtnT/QfNCFIFgSsS2/JrV/toTOado9BIeAdeCSWzb8Y8kvze98L4FT8pyyrcohSKlKmW29ybDNP1vDgeIhXvZ+nVmpdpaWDNKKPWgiNQNWrCvtiT7+gDN6or+B0+07mlq/byTidbwFumpqr2hD07Uxjkyj3bP3Xx+tRRDszbae5OJHPyB7rR7c0rlAIt7eaHPaPOub3aGqY0Thf+v2a0s02K6moGY/3x/DcFWbI9wGOuMeL3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkDtWXVa4ZoeLDyWVEBqFikdsTP5c5iGpGdXY3YkmiI=;
 b=IIkdMdVKWcf1Jbm1jpXSGDROY63vAAwVcq3ORgTIbg5heRBoFGLZGPQtSV7K9l4eXk/OwLotQdJoND6kO4iTmyFDBfPcL3ZC+WQ1APunXcFgS9fHZjBzcikXqO/RUAeHkykHM3ld0mMp9f7fQcaFczCso1ruiLkNZQn4dT4qlz/4aBJc5i2lYTtPshiQv+wZ8OSZRLZvDakSnv5Pem0wQY7gx7Ga8J8/F33Stj1CixEspLUrF0ljkFuVtZJPFStfYpL2DZQNR6VkZC/N2W9OJMKV4QEQBDoE690nDbOrHEfk4TZ0KbtZjaxrrBPQ5suBHUFD+BND9cO6uiX9UJFpqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by AS5PR04MB11371.eurprd04.prod.outlook.com (2603:10a6:20b:6c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 19:41:34 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%5]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 19:41:34 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v11 05/22] wifi: nxpwifi: add 802.11h (DFS/TPC) support
Date: Wed, 29 Apr 2026 03:40:04 +0800
Message-Id: <20260428194021.785252-6-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428194021.785252-1-jeff.chen_1@nxp.com>
References: <20260428194021.785252-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::33) To AM6PR04MB5239.eurprd04.prod.outlook.com
 (2603:10a6:20b:7::12)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5239:EE_|AS5PR04MB11371:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ee8c2d-b63f-4dbf-2b47-08dea55e27b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|1800799024|366016|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	CgaGLBYP2BkOWYxMdP+RsmWy9+DPb3LHn3FKa4B6abxT61RefFvTb/KxrvZhOjuB3WunQQlxklGfH+msHlGiQzQQPqNfvnQc/7Nji883gQAcoMkUqlmBteI5hWMpDzar6LzDy7jQyzr3f8PLns5MmiLCiaZrhyYS329wMg5xmgemorVKNlDKUKTbq1RaCulQBEMUBNTh4USMzoRBx4Jhhz1M05ax6+INT9mqeLzl80tD+frWudWRMo+XfBkULeIzDuqDqrcqTeZA3YVkwUB0MiTtP7TA/vThTAA8eaR7iwMcEgEGKXOW3tSvqRXZ79Dwz336gObFm92xeqspIcihFwLW3zgfDYExpag5tWMKb4SJH7XTA5lAvuH9WCEZA9wPnvNB5puOZ+g+OEe5V9ZBZnnP1KF4UUJnQ6Wm46Uh6kXw4G8Keh52cfUr72EgqrfI7V7+bJtYzuvkJvfCCnH624rb6L1WNsrJPUL9FTeJuGUyUWtRXUMmcFZFsHbKEU+Aqjoiw4LgH3+Aoa9srkprrRqdQAgi36nihFWwOK9cya+q13viQsxYiO/YsAm9PpWxzcdadwWMQ2vqCdUXdim0qLPmXFyOUHL8O3XfYCeRWPDA7xgZODQUVgQt2Hug5yQ59qBiFgy99i+riIdYRjRlHLqXwGta35tMXF79euBrG97rkrWzI+KwfRS4+r0QWOYHlL3oSqNtc5kZyqILaCPk0c68I+YAFeNJu1IWPSRk9F9tB2USk8wUHf+i0k9qsGocDsm6zeBqn6I0ycpOhi6fw9oDdC9HpLx0klGtaNuqTAw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nHzVcwZhbf12fz+ACPULUPZtwuuDsWmNNRCdRltjrwI4XgUM/DcAo6qYua+1?=
 =?us-ascii?Q?KZNOXAtUHpl89PIyEkkqKxCVJR6b0azY8rYe0OkWNB2k4v8SsIGDVcDkS4TJ?=
 =?us-ascii?Q?GzIBq5JYu+jexu0Q5r7xtW9pteEqc0qVODOXD7cltn6wXn95AS96yXr/MLyj?=
 =?us-ascii?Q?yJ1s1PBFAlFHRIJB1C3oP2XDRVAzjJQRqk8Kdiinq1iw+GQoW7eKXqL3YhyI?=
 =?us-ascii?Q?IIGht55U5HSENUJgKqnj0B7ZtQ1ALBCG4zoLOXLfU8L4+7M1U6KwMfgnIMkP?=
 =?us-ascii?Q?i88NkwjcYfAXZNzyWTgwfqVm3UVzEYUE3vW1IY467UvtStljlNN9c0lUcFn/?=
 =?us-ascii?Q?OMqFwaDkNCs72GzNJ/D+PkzhClk82MFQQGLsIq1U+Hn5w8LPo64BJUj7zsJ6?=
 =?us-ascii?Q?RaZwuCtAhDDSnX85d9rnf+Aiz60NtdRW0FrbOw6Xlx/DzK0DknmKyFYOZM1+?=
 =?us-ascii?Q?R2zZBVWO4sYmEV+pIMTbG+FBZsGsfEcjPUDeKZyGKSqt1hbDzSr5ZUhUdsuw?=
 =?us-ascii?Q?oHUoQ6Ct7SHGz8KYAn6Hg1SbMVW5EeaGPSHgB+QpEUctFVUc+5AFMDk0iANk?=
 =?us-ascii?Q?Cj24PFc5IS9vZWCVFHH+tm9OAo/2i1O5lS3YEISKHtgyTH8QnmKWWHGTht3B?=
 =?us-ascii?Q?NmeiSppc17TbCyMvZUqdv5psCf1rFBRTzgw3lGvCP63QQL5TqYiovdRB0P8g?=
 =?us-ascii?Q?HvJS3nzcOU7i0oO2r+OyS4xvjT8ln/N575sPqg3WUHQ3dAFyCLmLY52Ds3rb?=
 =?us-ascii?Q?ay7jSN33SNd7PQrvF509TSA9MRZ990G1flzA2Eg3aXG0DBDVtBwAKyPH0oGx?=
 =?us-ascii?Q?hK8dVIyjcMUMj/NoC28GHTZtuuKChHB72UU3CMxfIE3E6FF9taiTTVM6JjkZ?=
 =?us-ascii?Q?Uv/m9L+xkCf5m7R2urxYmW9/6pkV/p7/L1c3bhzZut32Kl26IBIHrO4Pxip6?=
 =?us-ascii?Q?4PqMtbZmrXVhxUjmf/ny+Yda1oyl1c7HWOm4ikNUF4HZdHUAQY6YTmWw+rD5?=
 =?us-ascii?Q?h45RGcMmsxx1+YDRhMlXXBaIuFHjV91pZg+rQ+aRNX9+mDrIlMu7XKd0FpQs?=
 =?us-ascii?Q?VV5MezZDbnVJ9Pd2OnyBNoWntAsvPtCgyVt+UmEelom1eaXNQsHEKUK9qw1y?=
 =?us-ascii?Q?dQ+GR8D0Rvsu8Bc05/pnt1HrkYnE+1idzT8AgeyD/2/uzgHsZKdvJf4rbvnQ?=
 =?us-ascii?Q?3TyxYos4yHv7D2DA67LYIg7ETIvGyUBDiJoc2hn5y+iA+HLhMEBGV2UCqn2+?=
 =?us-ascii?Q?e1TKiZg+GAq7P8axa9Y3QrsjmGzF3xO/J7nyhdfi76CoVrcbA1OdN9D75O8F?=
 =?us-ascii?Q?4LcKlBLnYHH/O0mHRlX3q9d/Q+3qXTV3zMp+e76nUlnzDc68Z0mIZHu/9aP3?=
 =?us-ascii?Q?VLjKrApAe5Vnh8mbF5aveRaDXNCb6e9qRdQy/+30jkDCwa1GzdLXycX6e4+g?=
 =?us-ascii?Q?WfTnt4gu1LB+NtnXRSOtKtBMDWrSgl84213+zLvvx47y/hYKK3iarYZkhmLh?=
 =?us-ascii?Q?cDttfeQn38slPpZ93rS8LX9DAn2q3mMAVKmyZ7MZiSue1ofNkQ6j8E06/UqH?=
 =?us-ascii?Q?YnkQm8Yk5hocQnDGi7T1CdJhfOgluZv9uVtbLpCAYiknEygul3EG/na1s/NU?=
 =?us-ascii?Q?O2eX9bsbkJdHZthoampzvE92SxZbXNntrqugJ5z3kuWcySblS9DTPK5Fryxj?=
 =?us-ascii?Q?1iBTwFiam6V5O/DPu/hnr1IGbtW9ZSXjDug63c60Viz3Ke8vK0dxaERj6HUL?=
 =?us-ascii?Q?rWhGmq4sEQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ee8c2d-b63f-4dbf-2b47-08dea55e27b7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 19:41:34.7570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T33nlwIU8RG8j+cXGo24nzXTj3DHle1Pud/QGXWVvokBo5eHpQmyF2CBokhPs+aQ08n/tlCKOLGclCh9FV6KCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11371
X-Rspamd-Queue-Id: DA9D648B477
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35518-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Add 802.11h support to enable Dynamic Frequency Selection (DFS) and
Transmit Power Control (TPC) for 5 GHz regulatory compliance.

Handle DFS Channel Availability Check (CAC), including start, timeout,
and abort flows, and process firmware radar reports via
HOST_CMD_CHAN_REPORT_REQUEST and related events. Support channel switch
operations with AP restart and beacon updates through cfg80211.

Implement TPC handling during association using the power capability and
local power constraint elements. Delegate radar detection to firmware,
while the driver constructs TLVs, handles events, and integrates with
cfg80211 for state changes and notifications.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11h.c | 339 +++++++++++++++++++++++++
 1 file changed, 339 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11h.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/11h.c b/drivers/net/wireless/nxp/nxpwifi/11h.c
new file mode 100644
index 000000000000..058c319ff910
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11h.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * nxpwifi: 802.11h helpers
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "main.h"
+#include "cmdevt.h"
+#include "fw.h"
+#include "cfg80211.h"
+
+void nxpwifi_init_11h_params(struct nxpwifi_private *priv)
+{
+	priv->state_11h.is_11h_enabled = true;
+	priv->state_11h.is_11h_active = false;
+}
+
+int nxpwifi_is_11h_active(struct nxpwifi_private *priv)
+{
+	return priv->state_11h.is_11h_active;
+}
+
+/* appends 11h info to a buffer while joining an infrastructure BSS */
+static void
+nxpwifi_11h_process_infra_join(struct nxpwifi_private *priv, u8 **buffer,
+			       struct nxpwifi_bssdescriptor *bss_desc)
+{
+	struct nxpwifi_ie_types_header *ie_header;
+	struct nxpwifi_ie_types_pwr_capability *cap;
+	struct nxpwifi_ie_types_local_pwr_constraint *constraint;
+	struct ieee80211_supported_band *sband;
+	u8 radio_type;
+	int i;
+
+	if (!buffer || !(*buffer))
+		return;
+
+	radio_type = nxpwifi_band_to_radio_type((u8)bss_desc->bss_band);
+	sband = priv->wdev.wiphy->bands[radio_type];
+
+	cap = (struct nxpwifi_ie_types_pwr_capability *)*buffer;
+	cap->header.type = cpu_to_le16(WLAN_EID_PWR_CAPABILITY);
+	cap->header.len = cpu_to_le16(2);
+	cap->min_pwr = 0;
+	cap->max_pwr = 0;
+	*buffer += sizeof(*cap);
+
+	constraint = (struct nxpwifi_ie_types_local_pwr_constraint *)*buffer;
+	constraint->header.type = cpu_to_le16(WLAN_EID_PWR_CONSTRAINT);
+	constraint->header.len = cpu_to_le16(2);
+	constraint->chan = bss_desc->channel;
+	constraint->constraint = bss_desc->local_constraint;
+	*buffer += sizeof(*constraint);
+
+	ie_header = (struct nxpwifi_ie_types_header *)*buffer;
+	ie_header->type = cpu_to_le16(TLV_TYPE_PASSTHROUGH);
+	ie_header->len  = cpu_to_le16(2 * sband->n_channels + 2);
+	*buffer += sizeof(*ie_header);
+	*(*buffer)++ = WLAN_EID_SUPPORTED_CHANNELS;
+	*(*buffer)++ = 2 * sband->n_channels;
+	for (i = 0; i < sband->n_channels; i++) {
+		u32 center_freq;
+
+		center_freq = sband->channels[i].center_freq;
+		*(*buffer)++ = ieee80211_frequency_to_channel(center_freq);
+		*(*buffer)++ = 1; /* one channel in the subband */
+	}
+}
+
+/* Enable or disable the 11h extensions in the firmware */
+int nxpwifi_11h_activate(struct nxpwifi_private *priv, bool flag)
+{
+	u32 enable = flag;
+
+	/* enable master mode radar detection on AP interface */
+	if ((GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) && enable)
+		enable |= NXPWIFI_MASTER_RADAR_DET_MASK;
+
+	return nxpwifi_send_cmd(priv, HOST_CMD_802_11_SNMP_MIB,
+				HOST_ACT_GEN_SET, DOT11H_I, &enable, true);
+}
+
+/*
+ * Process TLV buffer for a pending BSS join. Enable 11h in firmware when the
+ * network advertises spectrum management, and add required TLVs based on the
+ * BSS's 11h capability.
+ */
+void nxpwifi_11h_process_join(struct nxpwifi_private *priv, u8 **buffer,
+			      struct nxpwifi_bssdescriptor *bss_desc)
+{
+	if (bss_desc->sensed_11h) {
+		/* Activate 11h functions in firmware, turns on capability bit */
+		nxpwifi_11h_activate(priv, true);
+		priv->state_11h.is_11h_active = true;
+		bss_desc->cap_info_bitmap |= WLAN_CAPABILITY_SPECTRUM_MGMT;
+		nxpwifi_11h_process_infra_join(priv, buffer, bss_desc);
+	} else {
+		/* Deactivate 11h functions in the firmware */
+		nxpwifi_11h_activate(priv, false);
+		priv->state_11h.is_11h_active = false;
+		bss_desc->cap_info_bitmap &= ~WLAN_CAPABILITY_SPECTRUM_MGMT;
+	}
+}
+
+/*
+ * DFS CAC work function. This delayed work emits CAC finished event for cfg80211
+ * if CAC was started earlier
+ */
+void nxpwifi_dfs_cac_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct cfg80211_chan_def chandef;
+	struct wiphy_delayed_work *delayed_work =
+		container_of(work, struct wiphy_delayed_work, work);
+	struct nxpwifi_private *priv = container_of(delayed_work,
+						    struct nxpwifi_private,
+						    dfs_cac_work);
+
+	chandef = priv->dfs_chandef;
+	if (priv->wdev.links[0].cac_started) {
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "CAC timer finished; No radar detected\n");
+		cfg80211_cac_event(priv->netdev, &chandef,
+				   NL80211_RADAR_CAC_FINISHED,
+				   GFP_KERNEL, 0);
+	}
+}
+
+/* prepares channel report request command to FW for starting radar detection */
+int nxpwifi_cmd_issue_chan_report_request(struct nxpwifi_private *priv,
+					  struct host_cmd_ds_command *cmd,
+					  void *data_buf)
+{
+	struct host_cmd_ds_chan_rpt_req *cr_req = &cmd->params.chan_rpt_req;
+	struct nxpwifi_radar_params *radar_params = (void *)data_buf;
+	u16 size;
+
+	cmd->command = cpu_to_le16(HOST_CMD_CHAN_REPORT_REQUEST);
+	size = S_DS_GEN;
+
+	cr_req->chan_desc.start_freq = cpu_to_le16(NXPWIFI_A_BAND_START_FREQ);
+	nxpwifi_convert_chan_to_band_cfg(priv,
+					 &cr_req->chan_desc.band_cfg,
+					 radar_params->chandef);
+	cr_req->chan_desc.chan_num = radar_params->chandef->chan->hw_value;
+	cr_req->msec_dwell_time = cpu_to_le32(radar_params->cac_time_ms);
+	size += sizeof(*cr_req);
+
+	if (radar_params->cac_time_ms) {
+		struct nxpwifi_ie_types_chan_rpt_data *rpt;
+
+		rpt = (struct nxpwifi_ie_types_chan_rpt_data *)((u8 *)cmd + size);
+		rpt->header.type = cpu_to_le16(TLV_TYPE_CHANRPT_11H_BASIC);
+		rpt->header.len = cpu_to_le16(sizeof(u8));
+		rpt->meas_rpt_map = 1 << MEAS_RPT_MAP_RADAR_SHIFT_BIT;
+		size += sizeof(*rpt);
+
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "11h: issuing DFS Radar check for channel=%d\n",
+			    radar_params->chandef->chan->hw_value);
+	} else {
+		nxpwifi_dbg(priv->adapter, MSG, "cancelling CAC\n");
+	}
+
+	cmd->size = cpu_to_le16(size);
+
+	return 0;
+}
+
+int nxpwifi_stop_radar_detection(struct nxpwifi_private *priv,
+				 struct cfg80211_chan_def *chandef)
+{
+	struct nxpwifi_radar_params radar_params;
+
+	memset(&radar_params, 0, sizeof(struct nxpwifi_radar_params));
+	radar_params.chandef = chandef;
+	radar_params.cac_time_ms = 0;
+
+	return nxpwifi_send_cmd(priv, HOST_CMD_CHAN_REPORT_REQUEST,
+				HOST_ACT_GEN_SET, 0, &radar_params, true);
+}
+
+/* Abort ongoing CAC when stopping AP operations or during unload */
+void nxpwifi_abort_cac(struct nxpwifi_private *priv)
+{
+	if (priv->wdev.links[0].cac_started) {
+		if (nxpwifi_stop_radar_detection(priv, &priv->dfs_chandef))
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "failed to stop CAC in FW\n");
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "Aborting delayed work for CAC.\n");
+		wiphy_delayed_work_cancel(priv->adapter->wiphy, &priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL, 0);
+	}
+}
+
+/*
+ * handles channel report event from FW during CAC period. If radar is detected
+ * during CAC, driver indicates the same to cfg80211 and also cancels ongoing
+ * delayed work
+ */
+int nxpwifi_11h_handle_chanrpt_ready(struct nxpwifi_private *priv,
+				     struct sk_buff *skb)
+{
+	struct host_cmd_ds_chan_rpt_event *rpt_event;
+	struct nxpwifi_ie_types_chan_rpt_data *rpt;
+	u16 event_len, tlv_len;
+
+	rpt_event = (void *)(skb->data + sizeof(u32));
+	event_len = skb->len - (sizeof(struct host_cmd_ds_chan_rpt_event) +
+				sizeof(u32));
+
+	if (le32_to_cpu(rpt_event->result) != HOST_RESULT_OK) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "Error in channel report event\n");
+		return -EINVAL;
+	}
+
+	while (event_len >= sizeof(struct nxpwifi_ie_types_header)) {
+		rpt = (void *)&rpt_event->tlvbuf;
+		tlv_len = le16_to_cpu(rpt->header.len);
+
+		switch (le16_to_cpu(rpt->header.type)) {
+		case TLV_TYPE_CHANRPT_11H_BASIC:
+			if (rpt->meas_rpt_map & MEAS_RPT_MAP_RADAR_MASK) {
+				nxpwifi_dbg(priv->adapter, MSG,
+					    "RADAR Detected on channel %d!\n",
+					    priv->dfs_chandef.chan->hw_value);
+
+				wiphy_delayed_work_cancel(priv->adapter->wiphy,
+							  &priv->dfs_cac_work);
+				cfg80211_cac_event(priv->netdev,
+						   &priv->dfs_chandef,
+						   NL80211_RADAR_CAC_ABORTED,
+						   GFP_KERNEL, 0);
+				cfg80211_radar_event(priv->adapter->wiphy,
+						     &priv->dfs_chandef,
+						     GFP_KERNEL);
+			}
+			break;
+		default:
+			break;
+		}
+
+		event_len -= (tlv_len + sizeof(rpt->header));
+	}
+
+	return 0;
+}
+
+/* Handler for radar detected event from FW */
+int nxpwifi_11h_handle_radar_detected(struct nxpwifi_private *priv,
+				      struct sk_buff *skb)
+{
+	struct nxpwifi_radar_det_event *rdr_event;
+
+	rdr_event = (void *)(skb->data + sizeof(u32));
+
+	nxpwifi_dbg(priv->adapter, MSG,
+		    "radar detected; indicating kernel\n");
+
+	if (priv->wdev.links[0].cac_started) {
+		if (nxpwifi_stop_radar_detection(priv, &priv->dfs_chandef))
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "Failed to stop CAC in FW\n");
+		wiphy_delayed_work_cancel(priv->adapter->wiphy, &priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL, 0);
+	}
+	cfg80211_radar_event(priv->adapter->wiphy, &priv->dfs_chandef,
+			     GFP_KERNEL);
+	nxpwifi_dbg(priv->adapter, MSG, "regdomain: %d\n",
+		    rdr_event->reg_domain);
+	nxpwifi_dbg(priv->adapter, MSG, "radar detection type: %d\n",
+		    rdr_event->det_type);
+
+	return 0;
+}
+
+/*
+ * work function for channel switch handling. takes care of updating new channel
+ * definitin to bss config structure, restart AP and indicate channel switch
+ * success to cfg80211
+ */
+void nxpwifi_dfs_chan_sw_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct nxpwifi_uap_bss_param *bss_cfg;
+	struct wiphy_delayed_work *delayed_work =
+		container_of(work, struct wiphy_delayed_work, work);
+	struct nxpwifi_private *priv = container_of(delayed_work,
+						    struct nxpwifi_private,
+						    dfs_chan_sw_work);
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (nxpwifi_del_mgmt_ies(priv))
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "Failed to delete mgmt IEs!\n");
+
+	bss_cfg = &priv->bss_cfg;
+	if (!bss_cfg->beacon_period) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "channel switch: AP already stopped\n");
+		return;
+	}
+
+	if (nxpwifi_send_cmd(priv, HOST_CMD_UAP_BSS_STOP,
+			     HOST_ACT_GEN_SET, 0, NULL, true)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "channel switch: Failed to stop the BSS\n");
+		return;
+	}
+
+	if (nxpwifi_cfg80211_change_beacon(adapter->wiphy, priv->netdev,
+					   &priv->ap_update_info)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "channel switch: Failed to set beacon\n");
+		return;
+	}
+
+	nxpwifi_uap_set_channel(priv, bss_cfg, priv->dfs_chandef);
+
+	if (nxpwifi_config_start_uap(priv, bss_cfg)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "Failed to start AP after channel switch\n");
+		return;
+	}
+
+	nxpwifi_dbg(adapter, MSG,
+		    "indicating channel switch completion to kernel\n");
+
+	cfg80211_ch_switch_notify(priv->netdev, &priv->dfs_chandef, 0);
+
+	if (priv->uap_stop_tx) {
+		netif_carrier_on(priv->netdev);
+		nxpwifi_wake_up_net_dev_queue(priv->netdev, adapter);
+		priv->uap_stop_tx = false;
+	}
+}
-- 
2.34.1


