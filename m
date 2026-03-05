Return-Path: <linux-wireless+bounces-32523-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mInzOneXqWlKAgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32523-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:47:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6CA213C9F
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AE4430DFD65
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 14:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCA33A9603;
	Thu,  5 Mar 2026 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VrHOH2Kk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE3C3A8FF1;
	Thu,  5 Mar 2026 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721718; cv=fail; b=jfS4JmBnQBiDNE+PXAjGZ1QhIz7Zk/K0ztR2ExGAJyelt/3Zm43q4Gn1e5YLjfsyfRvSxdn3D9z759p2QQxYxsEfTZpx3Y0otNwi5fOP8V0qUHsu692Pe4WWnfdp5I6poqu4BO3qkJYOaQhh2bWSviWbhI33Q+u0f8ptQzUOlbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721718; c=relaxed/simple;
	bh=k8Hd0/taYScdR3fzTazheyPcskQsAeHVlyEet1NIBZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CHm5DQUryupZIAqVjza5rdK0g3lm+uQJ1VvJwfSfgDUG0F43ccClaMElTsk+jmboZ0QlOUpvpXrWbszRDlfx9JukeuH+JdJFgpC0dbixnA4DhQmaY33NmH0Qc1sRe6wpgdsLlAKQSm5zGSW/zNZYs3/bdh97Ms+WnewgKLxI1m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VrHOH2Kk; arc=fail smtp.client-ip=52.101.84.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BH5iZLLVtGUG+sTtXpNomQw9Q3/5p/dq6KRMYA5+267lfrJwPzz+tPQRUmD/IeFF97TSr6fhcn/Q8W03ZIr+FhbGKhRgNwULS7ZaF9MBYltzhE3xgEIbenyQwot1uWEKPskp/j7GipRRhURR+IusCqgHw4NDT2U0D6HPxft/tRsOO8gpGNI0hGDQ9s/T5wlLLhr9BmES1ZRsMYgSKTwT39jjacDWgMHqGOZX4cNwOdSi/rjA6Z2iz5I+7gZqwoVnK9V65cfEowbqsHs2gwTAjGri5vuRU4nQhoM8IA9qqI8xpjz4QFJFffkJho1IV/7MHP/eSaMxmHT8wQvdVusieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7Luwye3kx+9mnjqPS62pFogAXj0xsHw8+M3jBrQnJk=;
 b=rZ3hEdgGUHELiIwnv0lfHqwIazE21BOF8cFVv08Kofd6jQDFzlF66D2iIK6E02bBqNhKOk4rQXIswiTFmKbGXgyS3F/7FUIDosbZLbG2ng2o7XXsMVWfhhA/SB1VrfcGuqjvl/4b/bPkVbCi9rOjfBFNGRqyQfFdUERHqe+hGgqjRbFF77TCWwXCeVaatDz8fZ7oW7XGtcdVJZ//i9wRBjeFFkNZMvx+KKu96CpZ9ufhwn0a1nfyafJdktWXkNDbUcq2uExkc7lg7aWAREwzhwbHfB9GRYxSa4MofWZp0TT7AsAzoRb+IYGOwkuieD8bkEv6O3SQYDaGJT21Kq7tRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7Luwye3kx+9mnjqPS62pFogAXj0xsHw8+M3jBrQnJk=;
 b=VrHOH2KkMtSSeKqu1wx9OiHu+5UCxHO/5c+nOJV1cjLfxxFPYfIMYhFGqpodfwQD8vxoxkGZzB8JH7ubc3nXh5IaRnw4v9Gi4Act/Fnrs7iWM0hiwfHWQmS3wm1mvI/RqEbw6OiGyDiC4qrVhB73reAvzCdzFOH0UZ+9xGz9ZdGRtszJi0Wyk+4+B6U9XHhDy5/CI8WQuyhnRzgJcjQb+AMBxDpUuFGb4IeUCY7rTHzxKMnfWN5ngEGeKyaSY+H/93VMjZbGxNXv2eU19eeaSSCNdZjUFBo2z4wE44KQH1Iv3ObfGpgzUzl82moxT07VshiA27MCa1PR0Vs68AFf6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by AS4PR04MB9313.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 14:41:53 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 14:41:53 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v10 02/21] wifi: nxpwifi: add initial 802.11ac support for STA and AP modes
Date: Thu,  5 Mar 2026 22:39:20 +0800
Message-Id: <20260305143939.3724868-3-jeff.chen_1@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|AS4PR04MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: 78230286-7a9f-4966-a16a-08de7ac55799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	2aJYl7xa20PtBp1OpFA5n8nn6vy+LOK8Em7KyC6YBYZ6l6CABbsvAravI0mGjj1fnUgdLTqsDuAzuVtRB1JWwy9gYmGpCQ7pTTXzfHgQr/ieUJIV5H+ZGitNwjdzLDJZlkC0mSpQER0yGUDgqOAVi7JXTmqg96bomTs9UmjOCvR16VFWzOYQ2eFqY/5Go/83ZcsX4nd0QYzVGGUfWYo7JHTO2dyUjcW1nHvr/mopWZFuybTg3ArYekbfMxSpNNY9TXcD7BZ+f4Yg3KZhul89REEctHqvdjIE9HPaOMx4Ug2jx8qfqtnqMt6PwQCDXVAANBasV6AS0CFPTRx21DVf9gzP2LzfGkpI3RtMR2PIGWviuqPDmPGIkj3ra05zFQcg/oO3iq1hDW5xq6bPPFEPQ5hMXXes58gGHHzk9Vi0gi/S0V6DoJnrcpCW9eiVTWkf1prGU60+MuZffGzvzVCLN1ZCITKW6YxrzrpOriX/eEt366FuYG6lBz4qTzEfrhxSNYo/RZxkuf/XCz066ajoTU2o5gtqTELL1X02BZ3xAEnzvTCqkTAtgyIeuYlf7Cup1LbW/j1a8FXyaO6Ai/HqXgfIuueMyyGNBQlgQZ+wZZPA6HKadVPKbFxev7bPUyZIVJIxDipnsO5Hks/toLu5ou6yaYAgnoFoOMxOrFhMfAuqc4btX+oyIRGRFQigArXURdLmxfw2eBrZxSlW7jJtaLI856ZhprnKKiUHjabyc85BL9YgM5/FZbDIJP9ife8P3PSmHwIhrArxiCP08vSAJAzoqEjJnPNOFHomZHPtTsU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZFHwZpZUBi7PYjtXH3QvP/toDjM70b/PANQ1oz1s7VfqJfp3TN2HXqBFz+0D?=
 =?us-ascii?Q?pftQEACOEPARhK7xohgDkhFCejYp4qpyYkJ8Ww5xeiGFRWREGR7VfufXFrBy?=
 =?us-ascii?Q?tVbWiU7WpBpNUEdq6E103ICTlJVAiJdW1BHtzWgUT+ONnxe0ZCiqCKHvi+YV?=
 =?us-ascii?Q?c3shV/zU7AtUVSff9fyRysKj98kSrRvdYmNFoTSxzNSG7rn4oH8uZDCH5qXA?=
 =?us-ascii?Q?3e7LOgVc716SiWPI3dE7wHrIt6i6AQ9epn2TmGfgA1f1pzrjGAc2+tgT7r/i?=
 =?us-ascii?Q?ykfYDIprUfgA/PvhzrJFRMNjq/d47DnVVYjmQcI7N8IctgOEsJr4YPLU9fLZ?=
 =?us-ascii?Q?HBfKDpzeG+mGo84ApNNT3vMOi2UVs9yfy6sqKa0K41sIbBGdLW3fe+3r/v6s?=
 =?us-ascii?Q?UINGXpKMUhNgJXhgqa5l8wWysIcqP6bGV1O0y8feAPAcs9XgzQaq6H5tW0ou?=
 =?us-ascii?Q?orFRA62qaAoLTbJAIKA20Zi9eR+wqq6+jMQysOZPK5NBg2Hh0d7Kmn+XXtLI?=
 =?us-ascii?Q?bDNG9L6q9X3FZXzGF4x2yMbHXR/S+7abVE7Tkr4reTrKCiAFEt2D2L02kxiO?=
 =?us-ascii?Q?EbgG357KQaM9GJHPjfNZZJZEKuisAGWguws1RewMUtLeWtIDsoc/3KNqCMpD?=
 =?us-ascii?Q?KzRT/omHHDvXHItIBJ4o41RNYrXQDAPp1lK57wQxDbgCFTl5cid0G3Tx0tuR?=
 =?us-ascii?Q?y1qqCCTODte48w1lBDqMlAUYhLWTqlBktCvPnwhtfORujxvUpoF6K1VHlG6D?=
 =?us-ascii?Q?ZwXAKaAQZhZusEJNzP7VdV2du2bjPeVgReb9MvmwWyHt6HqUGeimldr5FhHU?=
 =?us-ascii?Q?lQ5qbGzW7l4XWS4aFMJ6p4O9LsR+fL2yLVKPjk/lfnbpp9kYUmi16ZiwMzm6?=
 =?us-ascii?Q?jOb0tvxjNi+DHmIrx0YzuhS16JgCJHqBMEkaUu4aqflzP3qH5NjKjdoj8UWd?=
 =?us-ascii?Q?Hqc/3jOkdJyrkztqcgqeBdW6dhnGLw3zMs8I7NtNaVrOkrUsS/djzjH32CZ/?=
 =?us-ascii?Q?Lg7McWxgIS8E0jEqve/Md21HAUP+0aN65d0Mf+hc81m+q4gkBAzx37E+ei/S?=
 =?us-ascii?Q?+UQAtn+9D8WW4KGnIs8d+rBPOGQCTD1EEHQ45xFOuKs8lEBcgS2q3ab5hrl0?=
 =?us-ascii?Q?mP0EGhu5s0OXkftDBH4ho7j3ZZ2RxikeJ46XFeWbQsH5EI9R0GmC40/VNPVR?=
 =?us-ascii?Q?uHqaULpKN8HwPM2nfFLdVUnWAwVhM9kZ4RgyQoefkPNvhP1/cvzap36cpRxn?=
 =?us-ascii?Q?chynX0lq+l1ebamCR3bRZcScBpXJFy7nzDd+E19AK9zVd+xqFMtqEENnf8td?=
 =?us-ascii?Q?/1n9rAKPtafOWNvobJBgRoUo1JnqulyZGNQ5zvnSnNJDyKAJdYFQRSV65sSf?=
 =?us-ascii?Q?ir+v0zk5Z4039ViNYz6PkMlmGURA+C+udG86+gerPMy1xJk4GwmG8B0E/1a5?=
 =?us-ascii?Q?f/EeJwjN/6SFkGFiyoHSxiPQ1LMHBzQfvgd5pA3YrdrfPMc0D8Ceqc1zusDE?=
 =?us-ascii?Q?ILmQc6QgSLIeuccZgA7G6i/IScv4+fbQn+daHwybz3j9WhYOO7gsJnoTsHJL?=
 =?us-ascii?Q?p7vgEs2UwcWUKvaOefeoYSnP2dwdG5qire17EW+qdMN95Zzxm905le2eeMwW?=
 =?us-ascii?Q?26gRpCeg3TLDiHQsbrKxUFwFYc+lD/qpwH4gqdcK+Zb+5BXRZ3Oovt7sHqTk?=
 =?us-ascii?Q?gG/gayDUYBq3kHSriV19uar6YddakXssRXnfX4vca8/gaUEKh7yJ0xxTWmZJ?=
 =?us-ascii?Q?MH3gKUiLkA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78230286-7a9f-4966-a16a-08de7ac55799
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 14:41:53.1936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06ksC3vCcw+Ey4vazACTkEWRoUNj+3eSHNjXisFgKomN4X3KUDi2wZT91jUIQCrxc7AwSOksY6+HhZXpFEzqqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9313
X-Rspamd-Queue-Id: 9F6CA213C9F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32523-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Introduce initial 802.11ac functionality, enabling VHT capability
negotiation and configuration for both STA and AP roles.

For station mode, convert VHT elements from cfg80211 into firmware TLVs
and append them to HOST_CMD_802_11_ASSOCIATE. For AP mode, convert
VHT elements into parameters for HOST_CMD_11AC_CFG and pass them to the
firmware for configuration.

Handle VHT capabilities, VHT operation, and operating mode notification
elements to allow proper setup of 802.11ac features.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11ac.c | 280 ++++++++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/11ac.h |  33 +++
 2 files changed, 313 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/11ac.c b/drivers/net/wireless/nxp/nxpwifi/11ac.c
new file mode 100644
index 000000000000..117d06c35401
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ac.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * nxpwifi 802.11ac helpers
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "fw.h"
+#include "main.h"
+#include "11ac.h"
+
+/* Map VHT MCS/NSS to highest data rate (Mbps), long GI. */
+static const u16 max_rate_lgi_80MHZ[8][3] = {
+	{0x124, 0x15F, 0x186},	/* NSS = 1 */
+	{0x249, 0x2BE, 0x30C},  /* NSS = 2 */
+	{0x36D, 0x41D, 0x492},  /* NSS = 3 */
+	{0x492, 0x57C, 0x618},  /* NSS = 4 */
+	{0x5B6, 0x6DB, 0x79E},  /* NSS = 5 */
+	{0x6DB, 0x83A, 0x0},    /* NSS = 6 */
+	{0x7FF, 0x999, 0xAAA},  /* NSS = 7 */
+	{0x924, 0xAF8, 0xC30}   /* NSS = 8 */
+};
+
+static const u16 max_rate_lgi_160MHZ[8][3] = {
+	{0x249, 0x2BE, 0x30C},   /* NSS = 1 */
+	{0x492, 0x57C, 0x618},   /* NSS = 2 */
+	{0x6DB, 0x83A, 0x0},     /* NSS = 3 */
+	{0x924, 0xAF8, 0xC30},   /* NSS = 4 */
+	{0xB6D, 0xDB6, 0xF3C},   /* NSS = 5 */
+	{0xDB6, 0x1074, 0x1248}, /* NSS = 6 */
+	{0xFFF, 0x1332, 0x1554}, /* NSS = 7 */
+	{0x1248, 0x15F0, 0x1860} /* NSS = 8 */
+};
+
+/* Convert 2-bit MCS map to highest long-GI VHT data rate. */
+static u16
+nxpwifi_convert_mcsmap_to_maxrate(struct nxpwifi_private *priv,
+				  u16 bands, u16 mcs_map)
+{
+	u8 i, nss, mcs;
+	u16 max_rate = 0;
+	u32 usr_vht_cap_info = 0;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (bands & BAND_AAC)
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_a;
+	else
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_bg;
+
+	/* Find max supported NSS. */
+	nss = 1;
+	for (i = 1; i <= 8; i++) {
+		mcs = GET_VHTNSSMCS(mcs_map, i);
+		if (mcs < IEEE80211_VHT_MCS_NOT_SUPPORTED)
+			nss = i;
+	}
+	mcs = GET_VHTNSSMCS(mcs_map, nss);
+
+	/* If not supported, fall back to 0-9. */
+	if (mcs == IEEE80211_VHT_MCS_NOT_SUPPORTED)
+		mcs = IEEE80211_VHT_MCS_SUPPORT_0_9;
+
+	if (u32_get_bits(usr_vht_cap_info, IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK)) {
+		/* Support 160 MHz. */
+		max_rate = max_rate_lgi_160MHZ[nss - 1][mcs];
+		if (!max_rate)
+			/* MCS9 not supported in NSS6. */
+			max_rate = max_rate_lgi_160MHZ[nss - 1][mcs - 1];
+	} else {
+		max_rate = max_rate_lgi_80MHZ[nss - 1][mcs];
+		if (!max_rate)
+			/* MCS9 not supported in NSS3. */
+			max_rate = max_rate_lgi_80MHZ[nss - 1][mcs - 1];
+	}
+
+	return max_rate;
+}
+
+static void
+nxpwifi_fill_vht_cap_info(struct nxpwifi_private *priv,
+			  struct ieee80211_vht_cap *vht_cap, u16 bands)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (bands & BAND_A)
+		vht_cap->vht_cap_info =
+			cpu_to_le32(adapter->usr_dot_11ac_dev_cap_a);
+	else
+		vht_cap->vht_cap_info =
+			cpu_to_le32(adapter->usr_dot_11ac_dev_cap_bg);
+}
+
+void
+nxpwifi_fill_vht_cap_tlv(struct nxpwifi_private *priv,
+			 struct ieee80211_vht_cap *vht_cap, u16 bands)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u16 mcs_map_user, mcs_map_resp, mcs_map_result;
+	u16 mcs_user, mcs_resp, nss, tmp;
+
+	/* Fill VHT capability info. */
+	nxpwifi_fill_vht_cap_info(priv, vht_cap, bands);
+
+	/* RX MCS set: min(user, AP). */
+	mcs_map_user = GET_DEVRXMCSMAP(adapter->usr_dot_11ac_mcs_support);
+	mcs_map_resp = le16_to_cpu(vht_cap->supp_mcs.rx_mcs_map);
+	mcs_map_result = 0;
+
+	for (nss = 1; nss <= 8; nss++) {
+		mcs_user = GET_VHTNSSMCS(mcs_map_user, nss);
+		mcs_resp = GET_VHTNSSMCS(mcs_map_resp, nss);
+
+		if (mcs_user == IEEE80211_VHT_MCS_NOT_SUPPORTED ||
+		    mcs_resp == IEEE80211_VHT_MCS_NOT_SUPPORTED)
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      IEEE80211_VHT_MCS_NOT_SUPPORTED);
+		else
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      min(mcs_user, mcs_resp));
+	}
+
+	vht_cap->supp_mcs.rx_mcs_map = cpu_to_le16(mcs_map_result);
+
+	tmp = nxpwifi_convert_mcsmap_to_maxrate(priv, bands, mcs_map_result);
+	vht_cap->supp_mcs.rx_highest = cpu_to_le16(tmp);
+
+	/* TX MCS set: min(user, AP). */
+	mcs_map_user = GET_DEVTXMCSMAP(adapter->usr_dot_11ac_mcs_support);
+	mcs_map_resp = le16_to_cpu(vht_cap->supp_mcs.tx_mcs_map);
+	mcs_map_result = 0;
+
+	for (nss = 1; nss <= 8; nss++) {
+		mcs_user = GET_VHTNSSMCS(mcs_map_user, nss);
+		mcs_resp = GET_VHTNSSMCS(mcs_map_resp, nss);
+		if (mcs_user == IEEE80211_VHT_MCS_NOT_SUPPORTED ||
+		    mcs_resp == IEEE80211_VHT_MCS_NOT_SUPPORTED)
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      IEEE80211_VHT_MCS_NOT_SUPPORTED);
+		else
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      min(mcs_user, mcs_resp));
+	}
+
+	vht_cap->supp_mcs.tx_mcs_map = cpu_to_le16(mcs_map_result);
+
+	tmp = nxpwifi_convert_mcsmap_to_maxrate(priv, bands, mcs_map_result);
+	vht_cap->supp_mcs.tx_highest = cpu_to_le16(tmp);
+}
+
+int nxpwifi_cmd_append_11ac_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer)
+{
+	struct nxpwifi_ie_types_vhtcap *vht_cap;
+	struct nxpwifi_ie_types_oper_mode_ntf *oper_ntf;
+	struct ieee_types_oper_mode_ntf *ieee_oper_ntf;
+	struct nxpwifi_ie_types_vht_oper *vht_op;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u8 supp_chwd_set;
+	u32 usr_vht_cap_info;
+	int ret_len = 0;
+
+	if (bss_desc->bss_band & BAND_A)
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_a;
+	else
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_bg;
+
+	/* VHT Capabilities element. */
+	if (bss_desc->bcn_vht_cap) {
+		vht_cap = (struct nxpwifi_ie_types_vhtcap *)*buffer;
+		memset(vht_cap, 0, sizeof(*vht_cap));
+		vht_cap->header.type = cpu_to_le16(WLAN_EID_VHT_CAPABILITY);
+		vht_cap->header.len  =
+			cpu_to_le16(sizeof(struct ieee80211_vht_cap));
+		memcpy((u8 *)vht_cap + sizeof(struct nxpwifi_ie_types_header),
+		       (u8 *)bss_desc->bcn_vht_cap,
+		       le16_to_cpu(vht_cap->header.len));
+
+		nxpwifi_fill_vht_cap_tlv(priv, &vht_cap->vht_cap,
+					 bss_desc->bss_band);
+		*buffer += sizeof(*vht_cap);
+		ret_len += sizeof(*vht_cap);
+	}
+
+	/* VHT Operation element. */
+	if (bss_desc->bcn_vht_oper) {
+		if (priv->bss_mode == NL80211_IFTYPE_STATION) {
+			vht_op = (struct nxpwifi_ie_types_vht_oper *)*buffer;
+			memset(vht_op, 0, sizeof(*vht_op));
+			vht_op->header.type =
+				cpu_to_le16(WLAN_EID_VHT_OPERATION);
+			vht_op->header.len  = cpu_to_le16(sizeof(*vht_op) -
+				sizeof(struct nxpwifi_ie_types_header));
+			memcpy((u8 *)vht_op +
+				sizeof(struct nxpwifi_ie_types_header),
+			       (u8 *)bss_desc->bcn_vht_oper,
+			       le16_to_cpu(vht_op->header.len));
+
+			/* Negotiate channel width; keep peer's center freq. */
+			supp_chwd_set = u32_get_bits(usr_vht_cap_info,
+						     IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK);
+
+			switch (supp_chwd_set) {
+			case 0:
+				vht_op->chan_width =
+				     min_t(u8, IEEE80211_VHT_CHANWIDTH_80MHZ,
+					   bss_desc->bcn_vht_oper->chan_width);
+				break;
+			case 1:
+				vht_op->chan_width =
+				     min_t(u8, IEEE80211_VHT_CHANWIDTH_160MHZ,
+					   bss_desc->bcn_vht_oper->chan_width);
+				break;
+			case 2:
+				vht_op->chan_width =
+				     min_t(u8, IEEE80211_VHT_CHANWIDTH_80P80MHZ,
+					   bss_desc->bcn_vht_oper->chan_width);
+				break;
+			default:
+				vht_op->chan_width =
+				     IEEE80211_VHT_CHANWIDTH_USE_HT;
+				break;
+			}
+
+			*buffer += sizeof(*vht_op);
+			ret_len += sizeof(*vht_op);
+		}
+	}
+
+	/* Operating Mode Notification element. */
+	if (bss_desc->oper_mode) {
+		ieee_oper_ntf = bss_desc->oper_mode;
+		oper_ntf = (void *)*buffer;
+		memset(oper_ntf, 0, sizeof(*oper_ntf));
+		oper_ntf->header.type = cpu_to_le16(WLAN_EID_OPMODE_NOTIF);
+		oper_ntf->header.len = cpu_to_le16(sizeof(u8));
+		oper_ntf->oper_mode = ieee_oper_ntf->oper_mode;
+		*buffer += sizeof(*oper_ntf);
+		ret_len += sizeof(*oper_ntf);
+	}
+
+	return ret_len;
+}
+
+int nxpwifi_cmd_11ac_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ac_vht_cfg *cfg)
+{
+	struct host_cmd_11ac_vht_cfg *vhtcfg = &cmd->params.vht_cfg;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11AC_CFG);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_11ac_vht_cfg) +
+				S_DS_GEN);
+	vhtcfg->action = cpu_to_le16(cmd_action);
+	vhtcfg->band_config = cfg->band_config;
+	vhtcfg->misc_config = cfg->misc_config;
+	vhtcfg->cap_info = cpu_to_le32(cfg->cap_info);
+	vhtcfg->mcs_tx_set = cpu_to_le32(cfg->mcs_tx_set);
+	vhtcfg->mcs_rx_set = cpu_to_le32(cfg->mcs_rx_set);
+
+	return 0;
+}
+
+/* Initialize BlockAck parameters for 11ac. */
+void nxpwifi_set_11ac_ba_params(struct nxpwifi_private *priv)
+{
+	priv->add_ba_param.timeout = NXPWIFI_DEFAULT_BLOCK_ACK_TIMEOUT;
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) {
+		priv->add_ba_param.tx_win_size =
+			NXPWIFI_11AC_UAP_AMPDU_DEF_TXWINSIZE;
+		priv->add_ba_param.rx_win_size =
+			NXPWIFI_11AC_UAP_AMPDU_DEF_RXWINSIZE;
+	} else {
+		priv->add_ba_param.tx_win_size =
+			NXPWIFI_11AC_STA_AMPDU_DEF_TXWINSIZE;
+		priv->add_ba_param.rx_win_size =
+			NXPWIFI_11AC_STA_AMPDU_DEF_RXWINSIZE;
+	}
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/11ac.h b/drivers/net/wireless/nxp/nxpwifi/11ac.h
new file mode 100644
index 000000000000..edc01b35d5b8
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ac.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * nxpwifi: 802.11ac (VHT) definitions
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_11AC_H_
+#define _NXPWIFI_11AC_H_
+
+#define VHT_CFG_2GHZ BIT(0)
+#define VHT_CFG_5GHZ BIT(1)
+
+enum vht_cfg_misc_config {
+	VHT_CAP_TX_OPERATION = 1,
+	VHT_CAP_ASSOCIATION,
+	VHT_CAP_UAP_ONLY
+};
+
+#define DEFAULT_VHT_MCS_SET 0xfffe
+#define DISABLE_VHT_MCS_SET 0xffff
+
+#define VHT_BW_80_160_80P80 BIT(2)
+
+int nxpwifi_cmd_append_11ac_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer);
+int nxpwifi_cmd_11ac_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ac_vht_cfg *cfg);
+void nxpwifi_fill_vht_cap_tlv(struct nxpwifi_private *priv,
+			      struct ieee80211_vht_cap *vht_cap, u16 bands);
+#endif /* _NXPWIFI_11AC_H_ */
-- 
2.34.1


