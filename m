Return-Path: <linux-wireless+bounces-26147-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C46EB1A686
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 17:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6354618963CB
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 15:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F48272E6B;
	Mon,  4 Aug 2025 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TkNyR9ss"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013070.outbound.protection.outlook.com [52.101.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C21278157;
	Mon,  4 Aug 2025 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322408; cv=fail; b=r2enU+yfC12lGSTbmYTNjHAhXH9kN8YJ94mhX/P60QFRRGPaDLmuelvRDH1SmlJfbIl7MA35S6ieS4yswW/XGJbrMq1hVIlE28UiGgYce79cGeQCth8KRYRmk1D/NntEIhcg71Kbpz+NmLWf1LgbtR+ngfbi9pCQj04iOlLYqyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322408; c=relaxed/simple;
	bh=CDidgLtxHZRgOM7/F0odT9jdnas9ILUuLW+1Ojd3rg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=no4n28P9psXF1FqebDZadPRhlafXNCAxQOW15lVHNNgNB8suS0haMV7jm/Vqp3h5g9krfp3BAUrUnh3b9k2fgsFqC34yagsEGJgxtjM4WEQOLOrzDU4v7Ia5D+42BTHKzp5OHB2xYzmVybBbY6+9GU0vBszxfSaec/jdGvXiag8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TkNyR9ss; arc=fail smtp.client-ip=52.101.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3Un2r2x3ko+7qFnR2WYH/GKAVk6TNZnvHSxFAwAkyUKTThmNrq6GiKreIK9ukLizV55KFF0p5HRKFIz8oNDSuZouWliyLfgP/jJQJnSWSnGyPsj4c6Jwzs+lAKcxhw3qQUIFwwdxV8CYaFWsyyxcNhv73xZRtgqVKRkzIMcl50Fh7J2SN1jQ6AxaGqYgkp0eEIOg8Pe466t6nznu0o+hnIQcDS9y7s0yHg1OWhgPswKydHypaP4NmUiha7B02vYLbFuTpVz/k340m4WRZ+bQlNeQsFTb7XfI8WZt23u8AWMOUxV/+pPN1dY278aKf0aRCK86QAn1qacgyVh0Ap2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33T8Om3Kbd6xbq34BZhJ8r5fTuY50ftZ94s91bLEjO8=;
 b=xcDfEF0gypI1j/XogisWSAYBXKX2v4ySCPkQY0XcaoLtzgffyTFEima7MsGxM9nR6ALRLKUXNzicPWiAZ2HPS0ORMZuE2uHojJtjXQCGVS5FO/qfChSKfM80FfBdBxw3BPzcIJXB46QP//6HUHLy/T6vRRtVZW52nClz5SbzNucExn7P56h6pFaz/Aw2wgRm2YY5MxAKsuzDYvAg7y3WVKichzpQaOZBUKdmj6ZfboFqAAFzfwRkbImuqohSompegHxmc97fG8aH2pLEUqgAZKuo5lgEM52eAC2M/1TmLXf+u7GMASA59RLyGhs/KAQl2pVBwZFZPrmtz8JagoMa7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33T8Om3Kbd6xbq34BZhJ8r5fTuY50ftZ94s91bLEjO8=;
 b=TkNyR9ss6fqXvHjz5DQteTL7pHeXMu9tqsrFRg9oNGiIVsIWCV5YDOJlbCOaIBoMH5ZREO31ag4lZf6xnNOGP1mx6GZatvfJvuJoLmvn58jqS9816k7XuiUY5Hwj66PefgVmjbCFCjiPRUfoS4f57vUjCQ2e5kSazVtBUbR7h1OgCReD/lWxW3OEhbIoFVGJr0LrxDn/573VjIezP7jnABOjRb0dJEIHl+Guoff1CV8ExKEVVyeckHGGpIwcQn9AQyalGISNSN7yB2PfCVjx+gH7VvphOO7OCRtLt5O1lP45PtaBvnnSgDMAXne1YWq9Crn9vSf56UAvsah6DU1XMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by PA1PR04MB11432.eurprd04.prod.outlook.com (2603:10a6:102:4f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 15:46:31 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 15:46:31 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	brian.hsu@nxp.com,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v5 16/22] wifi: nxpwifi: add utility files
Date: Mon,  4 Aug 2025 23:40:12 +0800
Message-Id: <20250804154018.3563834-17-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804154018.3563834-1-jeff.chen_1@nxp.com>
References: <20250804154018.3563834-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To DBBPR04MB7740.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|PA1PR04MB11432:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6d7818-6323-4025-426f-08ddd36e14fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ctwGvh1keOy9QCXOUmMhTdsEOZ+TJChK2M7ajtix2S1Wyh39XE3HBqTo/na2?=
 =?us-ascii?Q?TV93IZa909rH0wxaO5yT1TIhO/r6JZBdWo9Ykjb6jgyh7N6+XkXKPZHo2/or?=
 =?us-ascii?Q?XxEftGJ/MNwtf+CDKbZIpx0JSa5VvznRD8cJVZcV3GSO0cQMMToy7p4fc1ZY?=
 =?us-ascii?Q?B9WyELiwuloBCFuTXGJmin7098V22C84VcP0gMBjvaiWIQCsW/nxcTPhDBKY?=
 =?us-ascii?Q?HCQN4X57yaHg/XCJKn72YQstahxS9sFtYNevbG0fCLAd0ZoxqNFmhx0+htBY?=
 =?us-ascii?Q?0iIfw67MI4u4oO1yxnGuYIF45hh3aly9AESf8Msbhwbp8Gm7wgxswt1DYW2x?=
 =?us-ascii?Q?6FlFIJNkm1WVk2SqNAzx8Il6s+0EwT5XKWWod4hrnH1V2JbN4MG2GrhBq6Ek?=
 =?us-ascii?Q?ffsrhKbCVDCLzkeGd+QYI7VH91CeX9uzNqmP/2fvN/FxYcK3Awn+pXKFdbwz?=
 =?us-ascii?Q?a+XR81dSfuJ3yFhSyGEV6BkSSrRY3zkJhIWyZ7Bq9cEpAG00pXUIgF3EBSSF?=
 =?us-ascii?Q?DXoCGzdwwiFBuKdEHL5NEwowklebBoXZlErL4/I8ovwyUW96T/iLOOcA1Gy6?=
 =?us-ascii?Q?gVhUvudyqrzogq87DjhgpZpnitOIB86XkMoSFrJG/xnEcCPqf9M9yEoOoBl3?=
 =?us-ascii?Q?C1gATdbCOOAwub+QNgnerTCQUvENKL2as/mTg5nkrOquaaD3pWF2BTZm+TAg?=
 =?us-ascii?Q?qbGiyVa6DBEsGoQNMEIX7hvYIr2MMQwMJbPqf9RNsiWEEKkV+SSbHIV+QDkI?=
 =?us-ascii?Q?JRmYtzlWn0EnLE2+VyYwNAG5HoM9r6fyUCVhtGK4gWUTx4++SlaiiPIB+Dnz?=
 =?us-ascii?Q?G0OSTFoesvmqGnxRvCUEy3/suVA8cRP6pEy1ya112OTaKWKSnRXdlpu1jVyx?=
 =?us-ascii?Q?CpdHo8RqbuZcCMgZVZbYFNiP2/n4xESS951phAS/JAxdJqfsBiJ+Jk2xmJH0?=
 =?us-ascii?Q?srW8jnUGHcy8aZ1YVQ0XZ6Zwrr3JDWb+KAPNHEKhLJsbvQGwDqpXOqAteIlF?=
 =?us-ascii?Q?LFCb9rVBAvxShdFlVq+iewpM6K+wArCJkq9JzOaHY/+d8rK9spA5Uc6lzFxa?=
 =?us-ascii?Q?Kyitendp8Whyu8wfFf/5nrxNH/bNW4ZKxGJF53l0guUFRTmfdUsaExc65a3p?=
 =?us-ascii?Q?g4NdvXmQhj/mTv2z16/7kUBMANq5E2gtSM2eG4WtEkT+hs44raakGE/j+lr4?=
 =?us-ascii?Q?N467M5QdeI4JGkk9x6nZm5s1FeOHZDXi54UT+3nGy0FY1D0J2vrIh7wuX4Fc?=
 =?us-ascii?Q?DMK3rPkDbaUO1WfXCWYCiVByg0VFJ9MBASX5mc8mzJbuIK7tvrm6avyiX2qu?=
 =?us-ascii?Q?3HDUmhaqDfVUz9+2+L7m9lgQYb0wcYkfFTKzcxwfgch9vO1SyE0vQxAwmyjN?=
 =?us-ascii?Q?tbi2uHF013WCJ89xWwI7Tpsm3g2sl+tx8sZ3QAaZoIRtetjRPR/ija99v3ea?=
 =?us-ascii?Q?155gM7UAqX09vQNg9zJosM71rHgxWpyJfJCPuLXxig+VBtUcRDvs1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b651qSBjlYKtxmt1y4DUkO+/Lw66OKAPeW0gQNAWdGpy+B0PheoEeUlVJx4h?=
 =?us-ascii?Q?HkB/J5pvcaIljWqhp6MeWLvTiF7yD0WUAw5SLD8AoFulcq5PWUClklJ5IjTW?=
 =?us-ascii?Q?EXLbYUp9QbZ2myIaE5xq7VmYEAsPPMneZclKo234I63DquC59qG3L84fgbMh?=
 =?us-ascii?Q?yn6NSJZw3wI9UagiMaszkPfKf6z8HAXOr2icrUh4Inv6JVhpmuEeNIwMwmNH?=
 =?us-ascii?Q?CWmRtf+gkgdmAeI5uRqhm1hITXTzGErr0Rej98PVgstQKvtwFQ/MGxN2XCB4?=
 =?us-ascii?Q?HeVO7uAUyjLyZpdWMGQkVAPcs350Azta1Bm05geiaX11QVwa53IZbw9HNYoz?=
 =?us-ascii?Q?NjfyuRMgnV3m2xMmDPcHGjkwdC4TVrz4t+Ix1TCWjhcT4Gc6tQX0Mzkgsepc?=
 =?us-ascii?Q?H1/BPiyQPzaG5x5PJQb9HRqQtFM5lY+zaWtrq4oGcaNF691KcLOt3YycVTC3?=
 =?us-ascii?Q?dEu04pny5tNI8CoF5zh7oeiYdSF2bof849DwtemWYKajfuQ9I1KbDAgWxy0a?=
 =?us-ascii?Q?TLDIxF9FC4GAJb+pK40Uh+shH6RmzKJUVu97In4KkSsPQKSTgXstybmDjqwi?=
 =?us-ascii?Q?OIbMvYMxy6bKaDbwvF1owVWbWtpUarOV6CbXAWbNSTrXslWvaGQ7TzJSSozg?=
 =?us-ascii?Q?2ryQhQYl7NqOo98mv8pMsBvOqjvFwXRhxj8HQUMw69BzBi5DEUG+59KvApPQ?=
 =?us-ascii?Q?krfK+lix8JQVn7CRwnzsbbloW49iPz6BQ2b4UwQiGcdwXNOiTyxzHU2OiIWn?=
 =?us-ascii?Q?wxCV6MzJYG3Lbikyj3cmIvsEnyGgSXJA1RrndqkDh8o6gWBBGsV9WJ868kbf?=
 =?us-ascii?Q?eko1inwezvYCSTKLWCVLFkYATMbtAqchhudAK/ooE445QpdICgXg3K7nxrey?=
 =?us-ascii?Q?Gza3kZL5FHWrvLOexW8bVydSnmDOFnMIjPuJ4qwj0Br6qQdYKnA3gGFEP0sL?=
 =?us-ascii?Q?DCA8FGNXvVCi2BYi05LtF5qTGSXFPeKV4kWvOnmYO0yZpxMmnSvOtOjLRlLx?=
 =?us-ascii?Q?7UoUuNuQLRrdWNk5+gl4iCrQlCvAS+7i5AVKqNxibp/85mBC+kxReHN/Webq?=
 =?us-ascii?Q?ln+Z48wy8yC0QdNqUVmUIFNZAG3sdOz3IKljQ/+Lx3TSbZ3bL+ln9Kk6kYYC?=
 =?us-ascii?Q?LsNjKH0u6N96gplln8BObWOOpyLhiidcMwJj77OgV1hGGG5T1z/JpmX4gv6M?=
 =?us-ascii?Q?+gBLtdSBq5VVV+ZeCgrGoi60g38WcMWVrKVXGZIQN4n/Zb7Zfvj1GPPqlB1W?=
 =?us-ascii?Q?MaYciA8wDVXxTbJ1znBHTnu5nD69iD19qjK9wloCHnmXvFmbLEUMJZUg2JnF?=
 =?us-ascii?Q?sIm9+mU7xjseNgs4AsZkdW5ka7VQ2uqXAu18OPEmTY9jChGSKtnlKrGDttdo?=
 =?us-ascii?Q?S9NVftE5IpkcIqS/+C9GynmxZzEqduRpLKog3Kkl72UFUyKGppoZTYDEEHdS?=
 =?us-ascii?Q?ilYMN31lHxg8NAyjQXnl5Uo/M7SJdV/IJpEdYguk1C1t5OL+LlEuL5qwvzT7?=
 =?us-ascii?Q?KydV9VksKvneyKC3nNgKDmokcq8nTUVnUeYtiVkFDFy0qe7bONt90vf9+WWP?=
 =?us-ascii?Q?pA9SuKoNc6sCBN6AL68LdMhMmkqHQ+xV4l9sEMPE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6d7818-6323-4025-426f-08ddd36e14fb
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 15:46:31.0788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +b2EZYelvR3ov7nowLcuYaWmDb5fgMwdLzV1GD0ogEZQ02fBZxODSOg2RJ4Yg8fxizOc/XV6qVZi8lLTL4JZKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11432

Implement useful functions to help IE operations and some common
utilities.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/ie.c   |  501 +++++++
 drivers/net/wireless/nxp/nxpwifi/util.c | 1580 +++++++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/util.h |  132 ++
 3 files changed, 2213 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ie.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/ie.c b/drivers/net/wireless/nxp/nxpwifi/ie.c
new file mode 100644
index 000000000000..15bdc3c7a6fa
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/ie.c
@@ -0,0 +1,501 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: management IE handling- setting and
+ * deleting IE.
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "main.h"
+#include "cmdevt.h"
+
+/* This function checks if current IE index is used by any on other interface.
+ * Return: true: yes, current IE index is used by someone else.
+ *         false: no, current IE index is NOT used by other interface.
+ */
+static bool
+nxpwifi_ie_index_used_by_other_intf(struct nxpwifi_private *priv, u16 idx)
+{
+	int i;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_ie *ie;
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		if (adapter->priv[i] != priv) {
+			ie = &adapter->priv[i]->mgmt_ie[idx];
+			if (ie->mgmt_subtype_mask && ie->ie_length)
+				return true;
+		}
+	}
+
+	return false;
+}
+
+/* Get unused IE index. This index will be used for setting new IE */
+static int
+nxpwifi_ie_get_autoidx(struct nxpwifi_private *priv, u16 subtype_mask,
+		       struct nxpwifi_ie *ie, u16 *index)
+{
+	u16 mask, len, i;
+
+	for (i = 0; i < priv->adapter->max_mgmt_ie_index; i++) {
+		mask = le16_to_cpu(priv->mgmt_ie[i].mgmt_subtype_mask);
+		len = le16_to_cpu(ie->ie_length);
+
+		if (mask == NXPWIFI_AUTO_IDX_MASK)
+			continue;
+
+		if (mask == subtype_mask) {
+			if (len > IEEE_MAX_IE_SIZE)
+				continue;
+
+			*index = i;
+			return 0;
+		}
+
+		if (!priv->mgmt_ie[i].ie_length) {
+			if (nxpwifi_ie_index_used_by_other_intf(priv, i))
+				continue;
+
+			*index = i;
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+/* This function prepares IE data buffer for command to be sent to FW */
+static int
+nxpwifi_update_autoindex_ies(struct nxpwifi_private *priv,
+			     struct nxpwifi_ie_list *ie_list)
+{
+	u16 travel_len, index, mask;
+	s16 input_len, tlv_len;
+	struct nxpwifi_ie *ie;
+	u8 *tmp;
+
+	input_len = le16_to_cpu(ie_list->len);
+	travel_len = sizeof(struct nxpwifi_ie_types_header);
+
+	ie_list->len = 0;
+
+	while (input_len >= sizeof(struct nxpwifi_ie_types_header)) {
+		ie = (struct nxpwifi_ie *)(((u8 *)ie_list) + travel_len);
+		tlv_len = le16_to_cpu(ie->ie_length);
+		travel_len += tlv_len + NXPWIFI_IE_HDR_SIZE;
+
+		if (input_len < tlv_len + NXPWIFI_IE_HDR_SIZE)
+			return -EINVAL;
+		index = le16_to_cpu(ie->ie_index);
+		mask = le16_to_cpu(ie->mgmt_subtype_mask);
+
+		if (index == NXPWIFI_AUTO_IDX_MASK) {
+			/* automatic addition */
+			if (nxpwifi_ie_get_autoidx(priv, mask, ie, &index))
+				return -ENOENT;
+			if (index == NXPWIFI_AUTO_IDX_MASK)
+				return -EINVAL;
+
+			tmp = (u8 *)&priv->mgmt_ie[index].ie_buffer;
+			memcpy(tmp, &ie->ie_buffer, le16_to_cpu(ie->ie_length));
+			priv->mgmt_ie[index].ie_length = ie->ie_length;
+			priv->mgmt_ie[index].ie_index = cpu_to_le16(index);
+			priv->mgmt_ie[index].mgmt_subtype_mask =
+							cpu_to_le16(mask);
+
+			ie->ie_index = cpu_to_le16(index);
+		} else {
+			if (mask != NXPWIFI_DELETE_MASK)
+				return -EINVAL;
+			/* Check if this index is being used on any
+			 * other interface.
+			 */
+			if (nxpwifi_ie_index_used_by_other_intf(priv, index))
+				return -EPERM;
+
+			ie->ie_length = 0;
+			memcpy(&priv->mgmt_ie[index], ie,
+			       sizeof(struct nxpwifi_ie));
+		}
+
+		le16_unaligned_add_cpu
+		(&ie_list->len,
+		 le16_to_cpu(priv->mgmt_ie[index].ie_length) +
+		 NXPWIFI_IE_HDR_SIZE);
+		input_len -= tlv_len + NXPWIFI_IE_HDR_SIZE;
+	}
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP)
+		return nxpwifi_send_cmd(priv, HOST_CMD_UAP_SYS_CONFIG,
+					HOST_ACT_GEN_SET,
+					UAP_CUSTOM_IE_I, ie_list, true);
+
+	return 0;
+}
+
+/* Copy individual custom IEs for beacon, probe response and assoc response
+ * and prepare single structure for IE setting.
+ * This function also updates allocated IE indices from driver.
+ */
+static int
+nxpwifi_update_uap_custom_ie(struct nxpwifi_private *priv,
+			     struct nxpwifi_ie *beacon_ie, u16 *beacon_idx,
+			     struct nxpwifi_ie *pr_ie, u16 *probe_idx,
+			     struct nxpwifi_ie *ar_ie, u16 *assoc_idx)
+{
+	struct nxpwifi_ie_list *ap_custom_ie;
+	u8 *pos;
+	u16 len;
+	int ret;
+
+	ap_custom_ie = kzalloc(sizeof(*ap_custom_ie), GFP_KERNEL);
+	if (!ap_custom_ie)
+		return -ENOMEM;
+
+	ap_custom_ie->type = cpu_to_le16(TLV_TYPE_MGMT_IE);
+	pos = (u8 *)ap_custom_ie->ie_list;
+
+	if (beacon_ie) {
+		len = sizeof(struct nxpwifi_ie) - IEEE_MAX_IE_SIZE +
+		      le16_to_cpu(beacon_ie->ie_length);
+		memcpy(pos, beacon_ie, len);
+		pos += len;
+		le16_unaligned_add_cpu(&ap_custom_ie->len, len);
+	}
+	if (pr_ie) {
+		len = sizeof(struct nxpwifi_ie) - IEEE_MAX_IE_SIZE +
+		      le16_to_cpu(pr_ie->ie_length);
+		memcpy(pos, pr_ie, len);
+		pos += len;
+		le16_unaligned_add_cpu(&ap_custom_ie->len, len);
+	}
+	if (ar_ie) {
+		len = sizeof(struct nxpwifi_ie) - IEEE_MAX_IE_SIZE +
+		      le16_to_cpu(ar_ie->ie_length);
+		memcpy(pos, ar_ie, len);
+		pos += len;
+		le16_unaligned_add_cpu(&ap_custom_ie->len, len);
+	}
+
+	ret = nxpwifi_update_autoindex_ies(priv, ap_custom_ie);
+
+	pos = (u8 *)(&ap_custom_ie->ie_list[0].ie_index);
+	if (beacon_ie && *beacon_idx == NXPWIFI_AUTO_IDX_MASK) {
+		/* save beacon ie index after auto-indexing */
+		*beacon_idx = le16_to_cpu(ap_custom_ie->ie_list[0].ie_index);
+		len = sizeof(*beacon_ie) - IEEE_MAX_IE_SIZE +
+		      le16_to_cpu(beacon_ie->ie_length);
+		pos += len;
+	}
+	if (pr_ie && le16_to_cpu(pr_ie->ie_index) == NXPWIFI_AUTO_IDX_MASK) {
+		/* save probe resp ie index after auto-indexing */
+		*probe_idx = *((u16 *)pos);
+		len = sizeof(*pr_ie) - IEEE_MAX_IE_SIZE +
+		      le16_to_cpu(pr_ie->ie_length);
+		pos += len;
+	}
+	if (ar_ie && le16_to_cpu(ar_ie->ie_index) == NXPWIFI_AUTO_IDX_MASK)
+		/* save assoc resp ie index after auto-indexing */
+		*assoc_idx = *((u16 *)pos);
+
+	kfree(ap_custom_ie);
+	return ret;
+}
+
+/* This function checks if the vendor specified IE is present in passed buffer
+ * and copies it to nxpwifi_ie structure.
+ * Function takes pointer to struct nxpwifi_ie pointer as argument.
+ * If the vendor specified IE is present then memory is allocated for
+ * nxpwifi_ie pointer and filled in with IE. Caller should take care of freeing
+ * this memory.
+ */
+static int nxpwifi_update_vs_ie(const u8 *ies, int ies_len,
+				struct nxpwifi_ie **ie_ptr, u16 mask,
+				unsigned int oui, u8 oui_type)
+{
+	struct element *vs_ie;
+	struct nxpwifi_ie *ie = *ie_ptr;
+	const u8 *vendor_ie;
+
+	vendor_ie = cfg80211_find_vendor_ie(oui, oui_type, ies, ies_len);
+	if (vendor_ie) {
+		if (!*ie_ptr) {
+			*ie_ptr = kzalloc(sizeof(*ie_ptr), GFP_KERNEL);
+			if (!*ie_ptr)
+				return -ENOMEM;
+			ie = *ie_ptr;
+		}
+
+		vs_ie = (struct element *)vendor_ie;
+		if (le16_to_cpu(ie->ie_length) + vs_ie->datalen + 2 >
+			IEEE_MAX_IE_SIZE)
+			return -EINVAL;
+		memcpy(ie->ie_buffer + le16_to_cpu(ie->ie_length),
+		       vs_ie, vs_ie->datalen + 2);
+		le16_unaligned_add_cpu(&ie->ie_length, vs_ie->datalen + 2);
+		ie->mgmt_subtype_mask = cpu_to_le16(mask);
+		ie->ie_index = cpu_to_le16(NXPWIFI_AUTO_IDX_MASK);
+	}
+
+	*ie_ptr = ie;
+	return 0;
+}
+
+/* This function parses beacon IEs, probe response IEs, association response IEs
+ * from cfg80211_ap_settings->beacon and sets these IE to FW.
+ */
+static int nxpwifi_set_mgmt_beacon_data_ies(struct nxpwifi_private *priv,
+					    struct cfg80211_beacon_data *data)
+{
+	struct nxpwifi_ie *beacon_ie = NULL, *pr_ie = NULL, *ar_ie = NULL;
+	u16 beacon_idx = NXPWIFI_AUTO_IDX_MASK, pr_idx = NXPWIFI_AUTO_IDX_MASK;
+	u16 ar_idx = NXPWIFI_AUTO_IDX_MASK;
+	int ret = 0;
+
+	if (data->beacon_ies && data->beacon_ies_len) {
+		nxpwifi_update_vs_ie(data->beacon_ies, data->beacon_ies_len,
+				     &beacon_ie, MGMT_MASK_BEACON,
+				     WLAN_OUI_MICROSOFT,
+				     WLAN_OUI_TYPE_MICROSOFT_WPS);
+		nxpwifi_update_vs_ie(data->beacon_ies, data->beacon_ies_len,
+				     &beacon_ie, MGMT_MASK_BEACON,
+				     WLAN_OUI_WFA, WLAN_OUI_TYPE_WFA_P2P);
+	}
+
+	if (data->proberesp_ies && data->proberesp_ies_len) {
+		nxpwifi_update_vs_ie(data->proberesp_ies,
+				     data->proberesp_ies_len, &pr_ie,
+				     MGMT_MASK_PROBE_RESP, WLAN_OUI_MICROSOFT,
+				     WLAN_OUI_TYPE_MICROSOFT_WPS);
+		nxpwifi_update_vs_ie(data->proberesp_ies,
+				     data->proberesp_ies_len, &pr_ie,
+				     MGMT_MASK_PROBE_RESP,
+				     WLAN_OUI_WFA, WLAN_OUI_TYPE_WFA_P2P);
+	}
+
+	if (data->assocresp_ies && data->assocresp_ies_len) {
+		nxpwifi_update_vs_ie(data->assocresp_ies,
+				     data->assocresp_ies_len, &ar_ie,
+				     MGMT_MASK_ASSOC_RESP |
+				     MGMT_MASK_REASSOC_RESP,
+				     WLAN_OUI_MICROSOFT,
+				     WLAN_OUI_TYPE_MICROSOFT_WPS);
+		nxpwifi_update_vs_ie(data->assocresp_ies,
+				     data->assocresp_ies_len, &ar_ie,
+				     MGMT_MASK_ASSOC_RESP |
+				     MGMT_MASK_REASSOC_RESP, WLAN_OUI_WFA,
+				     WLAN_OUI_TYPE_WFA_P2P);
+	}
+
+	if (beacon_ie || pr_ie || ar_ie) {
+		ret = nxpwifi_update_uap_custom_ie(priv, beacon_ie,
+						   &beacon_idx, pr_ie,
+						   &pr_idx, ar_ie, &ar_idx);
+		if (ret)
+			goto done;
+	}
+
+	priv->beacon_idx = beacon_idx;
+	priv->proberesp_idx = pr_idx;
+	priv->assocresp_idx = ar_idx;
+
+done:
+	kfree(beacon_ie);
+	kfree(pr_ie);
+	kfree(ar_ie);
+
+	return ret;
+}
+
+/* This function parses  head and tail IEs, from cfg80211_beacon_data and sets
+ * these IE to FW.
+ */
+static int nxpwifi_uap_parse_tail_ies(struct nxpwifi_private *priv,
+				      struct cfg80211_beacon_data *info)
+{
+	struct nxpwifi_ie *gen_ie;
+	struct element *hdr;
+	struct ieee80211_vendor_ie *vendorhdr;
+	u16 gen_idx = NXPWIFI_AUTO_IDX_MASK, ie_len = 0;
+	int left_len, parsed_len = 0;
+	unsigned int token_len;
+	int ret = 0;
+
+	if (!info->tail || !info->tail_len)
+		return 0;
+
+	gen_ie = kzalloc(sizeof(*gen_ie), GFP_KERNEL);
+	if (!gen_ie)
+		return -ENOMEM;
+
+	left_len = info->tail_len;
+
+	/* Many IEs are generated in FW by parsing bss configuration.
+	 * Let's not add them here; else we may end up duplicating these IEs
+	 */
+	while (left_len > sizeof(struct element)) {
+		hdr = (void *)(info->tail + parsed_len);
+		token_len = hdr->datalen + sizeof(struct element);
+		if (token_len > left_len) {
+			ret = -EINVAL;
+			goto done;
+		}
+
+		switch (hdr->id) {
+		case WLAN_EID_SSID:
+		case WLAN_EID_SUPP_RATES:
+		case WLAN_EID_COUNTRY:
+		case WLAN_EID_PWR_CONSTRAINT:
+		case WLAN_EID_ERP_INFO:
+		case WLAN_EID_EXT_SUPP_RATES:
+		case WLAN_EID_HT_CAPABILITY:
+		case WLAN_EID_HT_OPERATION:
+		case WLAN_EID_VHT_CAPABILITY:
+		case WLAN_EID_VHT_OPERATION:
+			break;
+		case WLAN_EID_VENDOR_SPECIFIC:
+			/* Skip only Microsoft WMM IE */
+			if (cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT,
+						    WLAN_OUI_TYPE_MICROSOFT_WMM,
+						    (const u8 *)hdr,
+						    token_len))
+				break;
+			fallthrough;
+		default:
+			if (ie_len + token_len > IEEE_MAX_IE_SIZE) {
+				ret = -EINVAL;
+				goto done;
+			}
+			memcpy(gen_ie->ie_buffer + ie_len, hdr, token_len);
+			ie_len += token_len;
+			break;
+		}
+		left_len -= token_len;
+		parsed_len += token_len;
+	}
+
+	/* parse only WPA vendor IE from tail, WMM IE is configured by
+	 * bss_config command
+	 */
+	vendorhdr = (void *)cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT,
+						    WLAN_OUI_TYPE_MICROSOFT_WPA,
+						    info->tail, info->tail_len);
+	if (vendorhdr) {
+		token_len = vendorhdr->len + sizeof(struct element);
+		if (ie_len + token_len > IEEE_MAX_IE_SIZE) {
+			ret = -EINVAL;
+			goto done;
+		}
+		memcpy(gen_ie->ie_buffer + ie_len, vendorhdr, token_len);
+		ie_len += token_len;
+	}
+
+	if (!ie_len)
+		goto done;
+
+	gen_ie->ie_index = cpu_to_le16(gen_idx);
+	gen_ie->mgmt_subtype_mask = cpu_to_le16(MGMT_MASK_BEACON |
+						MGMT_MASK_PROBE_RESP |
+						MGMT_MASK_ASSOC_RESP);
+	gen_ie->ie_length = cpu_to_le16(ie_len);
+
+	ret = nxpwifi_update_uap_custom_ie(priv, gen_ie, &gen_idx, NULL,
+					   NULL, NULL, NULL);
+
+	if (ret)
+		goto done;
+
+	priv->gen_idx = gen_idx;
+
+ done:
+	kfree(gen_ie);
+	return ret;
+}
+
+/* This function parses different IEs-head & tail IEs, beacon IEs,
+ * probe response IEs, association response IEs from cfg80211_ap_settings
+ * function and sets these IE to FW.
+ */
+int nxpwifi_set_mgmt_ies(struct nxpwifi_private *priv,
+			 struct cfg80211_beacon_data *info)
+{
+	int ret;
+
+	ret = nxpwifi_uap_parse_tail_ies(priv, info);
+
+	if (ret)
+		return ret;
+
+	return nxpwifi_set_mgmt_beacon_data_ies(priv, info);
+}
+
+/* This function removes management IE set */
+int nxpwifi_del_mgmt_ies(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_ie *beacon_ie = NULL, *pr_ie = NULL;
+	struct nxpwifi_ie *ar_ie = NULL, *gen_ie = NULL;
+	int ret = 0;
+
+	if (priv->gen_idx != NXPWIFI_AUTO_IDX_MASK) {
+		gen_ie = kmalloc(sizeof(*gen_ie), GFP_KERNEL);
+		if (!gen_ie)
+			return -ENOMEM;
+
+		gen_ie->ie_index = cpu_to_le16(priv->gen_idx);
+		gen_ie->mgmt_subtype_mask = cpu_to_le16(NXPWIFI_DELETE_MASK);
+		gen_ie->ie_length = 0;
+		ret = nxpwifi_update_uap_custom_ie(priv, gen_ie, &priv->gen_idx,
+						   NULL, &priv->proberesp_idx,
+						   NULL, &priv->assocresp_idx);
+		if (ret)
+			goto done;
+
+		priv->gen_idx = NXPWIFI_AUTO_IDX_MASK;
+	}
+
+	if (priv->beacon_idx != NXPWIFI_AUTO_IDX_MASK) {
+		beacon_ie = kmalloc(sizeof(*beacon_ie), GFP_KERNEL);
+		if (!beacon_ie) {
+			ret = -ENOMEM;
+			goto done;
+		}
+		beacon_ie->ie_index = cpu_to_le16(priv->beacon_idx);
+		beacon_ie->mgmt_subtype_mask = cpu_to_le16(NXPWIFI_DELETE_MASK);
+		beacon_ie->ie_length = 0;
+	}
+	if (priv->proberesp_idx != NXPWIFI_AUTO_IDX_MASK) {
+		pr_ie = kmalloc(sizeof(*pr_ie), GFP_KERNEL);
+		if (!pr_ie) {
+			ret = -ENOMEM;
+			goto done;
+		}
+		pr_ie->ie_index = cpu_to_le16(priv->proberesp_idx);
+		pr_ie->mgmt_subtype_mask = cpu_to_le16(NXPWIFI_DELETE_MASK);
+		pr_ie->ie_length = 0;
+	}
+	if (priv->assocresp_idx != NXPWIFI_AUTO_IDX_MASK) {
+		ar_ie = kmalloc(sizeof(*ar_ie), GFP_KERNEL);
+		if (!ar_ie) {
+			ret = -ENOMEM;
+			goto done;
+		}
+		ar_ie->ie_index = cpu_to_le16(priv->assocresp_idx);
+		ar_ie->mgmt_subtype_mask = cpu_to_le16(NXPWIFI_DELETE_MASK);
+		ar_ie->ie_length = 0;
+	}
+
+	if (beacon_ie || pr_ie || ar_ie)
+		ret = nxpwifi_update_uap_custom_ie(priv,
+						   beacon_ie, &priv->beacon_idx,
+						   pr_ie, &priv->proberesp_idx,
+						   ar_ie, &priv->assocresp_idx);
+
+done:
+	kfree(gen_ie);
+	kfree(beacon_ie);
+	kfree(pr_ie);
+	kfree(ar_ie);
+
+	return ret;
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/util.c b/drivers/net/wireless/nxp/nxpwifi/util.c
new file mode 100644
index 000000000000..24c9e345e785
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/util.c
@@ -0,0 +1,1580 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: utility functions
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
+#include "11n.h"
+
+static struct nxpwifi_debug_data items[] = {
+	{"debug_mask", item_size(debug_mask),
+	 item_addr(debug_mask), 1},
+	{"int_counter", item_size(int_counter),
+	 item_addr(int_counter), 1},
+	{"wmm_ac_vo", item_size(packets_out[WMM_AC_VO]),
+	 item_addr(packets_out[WMM_AC_VO]), 1},
+	{"wmm_ac_vi", item_size(packets_out[WMM_AC_VI]),
+	 item_addr(packets_out[WMM_AC_VI]), 1},
+	{"wmm_ac_be", item_size(packets_out[WMM_AC_BE]),
+	 item_addr(packets_out[WMM_AC_BE]), 1},
+	{"wmm_ac_bk", item_size(packets_out[WMM_AC_BK]),
+	 item_addr(packets_out[WMM_AC_BK]), 1},
+	{"tx_buf_size", item_size(tx_buf_size),
+	 item_addr(tx_buf_size), 1},
+	{"curr_tx_buf_size", item_size(curr_tx_buf_size),
+	 item_addr(curr_tx_buf_size), 1},
+	{"ps_mode", item_size(ps_mode),
+	 item_addr(ps_mode), 1},
+	{"ps_state", item_size(ps_state),
+	 item_addr(ps_state), 1},
+	{"is_deep_sleep", item_size(is_deep_sleep),
+	 item_addr(is_deep_sleep), 1},
+	{"wakeup_dev_req", item_size(pm_wakeup_card_req),
+	 item_addr(pm_wakeup_card_req), 1},
+	{"wakeup_tries", item_size(pm_wakeup_fw_try),
+	 item_addr(pm_wakeup_fw_try), 1},
+	{"hs_configured", item_size(is_hs_configured),
+	 item_addr(is_hs_configured), 1},
+	{"hs_activated", item_size(hs_activated),
+	 item_addr(hs_activated), 1},
+	{"num_tx_timeout", item_size(num_tx_timeout),
+	 item_addr(num_tx_timeout), 1},
+	{"is_cmd_timedout", item_size(is_cmd_timedout),
+	 item_addr(is_cmd_timedout), 1},
+	{"timeout_cmd_id", item_size(timeout_cmd_id),
+	 item_addr(timeout_cmd_id), 1},
+	{"timeout_cmd_act", item_size(timeout_cmd_act),
+	 item_addr(timeout_cmd_act), 1},
+	{"last_cmd_id", item_size(last_cmd_id),
+	 item_addr(last_cmd_id), DBG_CMD_NUM},
+	{"last_cmd_act", item_size(last_cmd_act),
+	 item_addr(last_cmd_act), DBG_CMD_NUM},
+	{"last_cmd_index", item_size(last_cmd_index),
+	 item_addr(last_cmd_index), 1},
+	{"last_cmd_resp_id", item_size(last_cmd_resp_id),
+	 item_addr(last_cmd_resp_id), DBG_CMD_NUM},
+	{"last_cmd_resp_index", item_size(last_cmd_resp_index),
+	 item_addr(last_cmd_resp_index), 1},
+	{"last_event", item_size(last_event),
+	 item_addr(last_event), DBG_CMD_NUM},
+	{"last_event_index", item_size(last_event_index),
+	 item_addr(last_event_index), 1},
+	{"last_mp_wr_bitmap", item_size(last_mp_wr_bitmap),
+	 item_addr(last_mp_wr_bitmap), NXPWIFI_DBG_SDIO_MP_NUM},
+	{"last_mp_wr_ports", item_size(last_mp_wr_ports),
+	 item_addr(last_mp_wr_ports), NXPWIFI_DBG_SDIO_MP_NUM},
+	{"last_mp_wr_len", item_size(last_mp_wr_len),
+	 item_addr(last_mp_wr_len), NXPWIFI_DBG_SDIO_MP_NUM},
+	{"last_mp_curr_wr_port", item_size(last_mp_curr_wr_port),
+	 item_addr(last_mp_curr_wr_port), NXPWIFI_DBG_SDIO_MP_NUM},
+	{"last_sdio_mp_index", item_size(last_sdio_mp_index),
+	 item_addr(last_sdio_mp_index), 1},
+	{"num_cmd_h2c_fail", item_size(num_cmd_host_to_card_failure),
+	 item_addr(num_cmd_host_to_card_failure), 1},
+	{"num_cmd_sleep_cfm_fail",
+	 item_size(num_cmd_sleep_cfm_host_to_card_failure),
+	 item_addr(num_cmd_sleep_cfm_host_to_card_failure), 1},
+	{"num_tx_h2c_fail", item_size(num_tx_host_to_card_failure),
+	 item_addr(num_tx_host_to_card_failure), 1},
+	{"num_evt_deauth", item_size(num_event_deauth),
+	 item_addr(num_event_deauth), 1},
+	{"num_evt_disassoc", item_size(num_event_disassoc),
+	 item_addr(num_event_disassoc), 1},
+	{"num_evt_link_lost", item_size(num_event_link_lost),
+	 item_addr(num_event_link_lost), 1},
+	{"num_cmd_deauth", item_size(num_cmd_deauth),
+	 item_addr(num_cmd_deauth), 1},
+	{"num_cmd_assoc_ok", item_size(num_cmd_assoc_success),
+	 item_addr(num_cmd_assoc_success), 1},
+	{"num_cmd_assoc_fail", item_size(num_cmd_assoc_failure),
+	 item_addr(num_cmd_assoc_failure), 1},
+	{"cmd_sent", item_size(cmd_sent),
+	 item_addr(cmd_sent), 1},
+	{"data_sent", item_size(data_sent),
+	 item_addr(data_sent), 1},
+	{"cmd_resp_received", item_size(cmd_resp_received),
+	 item_addr(cmd_resp_received), 1},
+	{"event_received", item_size(event_received),
+	 item_addr(event_received), 1},
+
+	/* variables defined in struct nxpwifi_adapter */
+	{"cmd_pending", adapter_item_size(cmd_pending),
+	 adapter_item_addr(cmd_pending), 1},
+	{"tx_pending", adapter_item_size(tx_pending),
+	 adapter_item_addr(tx_pending), 1},
+	{"rx_pending", adapter_item_size(rx_pending),
+	 adapter_item_addr(rx_pending), 1},
+};
+
+static int num_of_items = ARRAY_SIZE(items);
+
+/* Firmware initialization complete callback handler.
+ *
+ * This function wakes up the function waiting on the init
+ * wait queue for the firmware initialization to complete.
+ */
+void nxpwifi_init_fw_complete(struct nxpwifi_adapter *adapter)
+{
+	adapter->init_wait_q_woken = true;
+	wake_up_interruptible(&adapter->init_wait_q);
+}
+
+/* This function sends init/shutdown command
+ * to firmware.
+ */
+int nxpwifi_init_shutdown_fw(struct nxpwifi_private *priv,
+			     u32 func_init_shutdown)
+{
+	u16 cmd;
+
+	if (func_init_shutdown == NXPWIFI_FUNC_INIT) {
+		cmd = HOST_CMD_FUNC_INIT;
+	} else if (func_init_shutdown == NXPWIFI_FUNC_SHUTDOWN) {
+		cmd = HOST_CMD_FUNC_SHUTDOWN;
+	} else {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "unsupported parameter\n");
+		return -EINVAL;
+	}
+
+	return nxpwifi_send_cmd(priv, cmd, HOST_ACT_GEN_SET, 0, NULL, true);
+}
+EXPORT_SYMBOL_GPL(nxpwifi_init_shutdown_fw);
+
+/* IOCTL request handler to set/get debug information.
+ *
+ * This function collates/sets the information from/to different driver
+ * structures.
+ */
+int nxpwifi_get_debug_info(struct nxpwifi_private *priv,
+			   struct nxpwifi_debug_info *info)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (info) {
+		info->debug_mask = adapter->debug_mask;
+		memcpy(info->packets_out,
+		       priv->wmm.packets_out,
+		       sizeof(priv->wmm.packets_out));
+		info->curr_tx_buf_size = (u32)adapter->curr_tx_buf_size;
+		info->tx_buf_size = (u32)adapter->tx_buf_size;
+		info->rx_tbl_num = nxpwifi_get_rx_reorder_tbl(priv,
+							      info->rx_tbl);
+		info->tx_tbl_num = nxpwifi_get_tx_ba_stream_tbl(priv,
+								info->tx_tbl);
+		info->ps_mode = adapter->ps_mode;
+		info->ps_state = adapter->ps_state;
+		info->is_deep_sleep = adapter->is_deep_sleep;
+		info->pm_wakeup_card_req = adapter->pm_wakeup_card_req;
+		info->pm_wakeup_fw_try = adapter->pm_wakeup_fw_try;
+		info->is_hs_configured = test_bit(NXPWIFI_IS_HS_CONFIGURED,
+						  &adapter->work_flags);
+		info->hs_activated = adapter->hs_activated;
+		info->is_cmd_timedout = test_bit(NXPWIFI_IS_CMD_TIMEDOUT,
+						 &adapter->work_flags);
+		info->num_cmd_host_to_card_failure =
+			adapter->dbg.num_cmd_host_to_card_failure;
+		info->num_cmd_sleep_cfm_host_to_card_failure =
+			adapter->dbg.num_cmd_sleep_cfm_host_to_card_failure;
+		info->num_tx_host_to_card_failure =
+			adapter->dbg.num_tx_host_to_card_failure;
+		info->num_event_deauth = adapter->dbg.num_event_deauth;
+		info->num_event_disassoc = adapter->dbg.num_event_disassoc;
+		info->num_event_link_lost = adapter->dbg.num_event_link_lost;
+		info->num_cmd_deauth = adapter->dbg.num_cmd_deauth;
+		info->num_cmd_assoc_success =
+			adapter->dbg.num_cmd_assoc_success;
+		info->num_cmd_assoc_failure =
+			adapter->dbg.num_cmd_assoc_failure;
+		info->num_tx_timeout = adapter->dbg.num_tx_timeout;
+		info->timeout_cmd_id = adapter->dbg.timeout_cmd_id;
+		info->timeout_cmd_act = adapter->dbg.timeout_cmd_act;
+		memcpy(info->last_cmd_id, adapter->dbg.last_cmd_id,
+		       sizeof(adapter->dbg.last_cmd_id));
+		memcpy(info->last_cmd_act, adapter->dbg.last_cmd_act,
+		       sizeof(adapter->dbg.last_cmd_act));
+		info->last_cmd_index = adapter->dbg.last_cmd_index;
+		memcpy(info->last_cmd_resp_id, adapter->dbg.last_cmd_resp_id,
+		       sizeof(adapter->dbg.last_cmd_resp_id));
+		info->last_cmd_resp_index = adapter->dbg.last_cmd_resp_index;
+		memcpy(info->last_event, adapter->dbg.last_event,
+		       sizeof(adapter->dbg.last_event));
+		info->last_event_index = adapter->dbg.last_event_index;
+		memcpy(info->last_mp_wr_bitmap, adapter->dbg.last_mp_wr_bitmap,
+		       sizeof(adapter->dbg.last_mp_wr_bitmap));
+		memcpy(info->last_mp_wr_ports, adapter->dbg.last_mp_wr_ports,
+		       sizeof(adapter->dbg.last_mp_wr_ports));
+		memcpy(info->last_mp_curr_wr_port,
+		       adapter->dbg.last_mp_curr_wr_port,
+		       sizeof(adapter->dbg.last_mp_curr_wr_port));
+		memcpy(info->last_mp_wr_len, adapter->dbg.last_mp_wr_len,
+		       sizeof(adapter->dbg.last_mp_wr_len));
+		info->last_sdio_mp_index = adapter->dbg.last_sdio_mp_index;
+		info->data_sent = adapter->data_sent;
+		info->cmd_sent = adapter->cmd_sent;
+		info->cmd_resp_received = adapter->cmd_resp_received;
+	}
+
+	return 0;
+}
+
+int nxpwifi_debug_info_to_buffer(struct nxpwifi_private *priv, char *buf,
+				 struct nxpwifi_debug_info *info)
+{
+	char *p = buf;
+	struct nxpwifi_debug_data *d = &items[0];
+	size_t size, addr;
+	long val;
+	int i, j;
+
+	if (!info)
+		return 0;
+
+	for (i = 0; i < num_of_items; i++) {
+		p += sprintf(p, "%s=", d[i].name);
+
+		size = d[i].size / d[i].num;
+
+		if (i < (num_of_items - 3))
+			addr = d[i].addr + (size_t)info;
+		else /* The last 3 items are struct nxpwifi_adapter variables */
+			addr = d[i].addr + (size_t)priv->adapter;
+
+		for (j = 0; j < d[i].num; j++) {
+			switch (size) {
+			case 1:
+				val = *((u8 *)addr);
+				break;
+			case 2:
+				val = get_unaligned((u16 *)addr);
+				break;
+			case 4:
+				val = get_unaligned((u32 *)addr);
+				break;
+			case 8:
+				val = get_unaligned((long long *)addr);
+				break;
+			default:
+				val = -1;
+				break;
+			}
+
+			p += sprintf(p, "%#lx ", val);
+			addr += size;
+		}
+
+		p += sprintf(p, "\n");
+	}
+
+	if (info->tx_tbl_num) {
+		p += sprintf(p, "Tx BA stream table:\n");
+		for (i = 0; i < info->tx_tbl_num; i++)
+			p += sprintf(p, "tid = %d, ra = %pM\n",
+				     info->tx_tbl[i].tid, info->tx_tbl[i].ra);
+	}
+
+	if (info->rx_tbl_num) {
+		p += sprintf(p, "Rx reorder table:\n");
+		for (i = 0; i < info->rx_tbl_num; i++) {
+			p += sprintf(p, "tid = %d, ta = %pM, ",
+				     info->rx_tbl[i].tid,
+				     info->rx_tbl[i].ta);
+			p += sprintf(p, "start_win = %d, ",
+				     info->rx_tbl[i].start_win);
+			p += sprintf(p, "win_size = %d, buffer: ",
+				     info->rx_tbl[i].win_size);
+
+			for (j = 0; j < info->rx_tbl[i].win_size; j++)
+				p += sprintf(p, "%c ",
+					     info->rx_tbl[i].buffer[j] ?
+					     '1' : '0');
+
+			p += sprintf(p, "\n");
+		}
+	}
+
+	return p - buf;
+}
+
+bool nxpwifi_is_channel_setting_allowable(struct nxpwifi_private *priv,
+					  struct ieee80211_channel *check_chan)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int i;
+	struct nxpwifi_private *tmp_priv;
+	u8 bss_role = GET_BSS_ROLE(priv);
+	struct ieee80211_channel *set_chan;
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		tmp_priv = adapter->priv[i];
+		if (tmp_priv == priv)
+			continue;
+
+		set_chan = NULL;
+		if (bss_role == NXPWIFI_BSS_ROLE_STA) {
+			if (GET_BSS_ROLE(tmp_priv) == NXPWIFI_BSS_ROLE_UAP &&
+			    netif_carrier_ok(tmp_priv->netdev) &&
+			    cfg80211_chandef_valid(&tmp_priv->bss_chandef))
+				set_chan = tmp_priv->bss_chandef.chan;
+		} else if (bss_role == NXPWIFI_BSS_ROLE_UAP) {
+			struct nxpwifi_current_bss_params *bss_params =
+				&tmp_priv->curr_bss_params;
+			int channel = bss_params->bss_descriptor.channel;
+			enum nl80211_band band =
+				nxpwifi_band_to_radio_type(bss_params->band);
+			int freq =
+				ieee80211_channel_to_frequency(channel, band);
+
+			if (GET_BSS_ROLE(tmp_priv) == NXPWIFI_BSS_ROLE_STA &&
+			    tmp_priv->media_connected)
+				set_chan = ieee80211_get_channel(adapter->wiphy, freq);
+		}
+
+		if (set_chan && !ieee80211_channel_equal(check_chan, set_chan)) {
+			nxpwifi_dbg(adapter, ERROR,
+				    "AP/STA must run on the same channel\n");
+			return false;
+		}
+	}
+
+	return true;
+}
+
+void nxpwifi_convert_chan_to_band_cfg(struct nxpwifi_private *priv,
+				      u8 *band_cfg,
+				      struct cfg80211_chan_def *chan_def)
+{
+	u8 chan_band = 0, chan_width = 0, chan2_offset = 0;
+
+	switch (chan_def->chan->band) {
+	case NL80211_BAND_2GHZ:
+		chan_band = BAND_2GHZ;
+		break;
+	case NL80211_BAND_5GHZ:
+		chan_band = BAND_5GHZ;
+		break;
+	default:
+		break;
+	}
+
+	switch (chan_def->width) {
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_20:
+		chan_width = CHAN_BW_20MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_40:
+		chan_width = CHAN_BW_40MHZ;
+		if (chan_def->center_freq1 > chan_def->chan->center_freq)
+			chan2_offset = IEEE80211_HT_PARAM_CHA_SEC_ABOVE;
+		else
+			chan2_offset = IEEE80211_HT_PARAM_CHA_SEC_BELOW;
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		chan2_offset =
+			nxpwifi_get_sec_chan_offset(chan_def->chan->hw_value);
+		chan_width = CHAN_BW_80MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80P80:
+	case NL80211_CHAN_WIDTH_160:
+	default:
+		nxpwifi_dbg(priv->adapter,
+			    WARN, "Unknown channel width: %d\n",
+			    chan_def->width);
+		break;
+	}
+
+	*band_cfg = ((chan2_offset << BAND_CFG_CHAN2_SHIFT_BIT) &
+		     BAND_CFG_CHAN2_OFFSET_MASK) |
+		    ((chan_width << BAND_CFG_CHAN_WIDTH_SHIFT_BIT) &
+		     BAND_CFG_CHAN_WIDTH_MASK) |
+		    ((chan_band << BAND_CFG_CHAN_BAND_SHIFT_BIT) &
+		     BAND_CFG_CHAN_BAND_MASK);
+}
+
+static int
+nxpwifi_parse_mgmt_packet(struct nxpwifi_private *priv, u8 *payload, u16 len,
+			  struct rxpd *rx_pd)
+{
+	u16 stype;
+	u8 category;
+	struct ieee80211_hdr *ieee_hdr = (void *)payload;
+
+	stype = (le16_to_cpu(ieee_hdr->frame_control) & IEEE80211_FCTL_STYPE);
+
+	switch (stype) {
+	case IEEE80211_STYPE_ACTION:
+		category = *(payload + sizeof(struct ieee80211_hdr));
+		switch (category) {
+		case WLAN_CATEGORY_BACK:
+			/*we dont indicate BACK action frames to cfg80211*/
+			nxpwifi_dbg(priv->adapter, INFO,
+				    "drop BACK action frames");
+			return -EINVAL;
+		default:
+			nxpwifi_dbg(priv->adapter, INFO,
+				    "unknown public action frame category %d\n",
+				    category);
+		}
+		break;
+	default:
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "unknown mgmt frame subtype %#x\n", stype);
+		return 0;
+	}
+
+	return 0;
+}
+
+/* This function sends deauth packet to the kernel. */
+void nxpwifi_host_mlme_disconnect(struct nxpwifi_private *priv,
+				  u16 reason_code, u8 *sa)
+{
+	u8 frame_buf[100];
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)frame_buf;
+
+	memset(frame_buf, 0, sizeof(frame_buf));
+	mgmt->frame_control = cpu_to_le16(IEEE80211_STYPE_DEAUTH);
+	mgmt->duration = 0;
+	mgmt->seq_ctrl = 0;
+	mgmt->u.deauth.reason_code = cpu_to_le16(reason_code);
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA) {
+		eth_broadcast_addr(mgmt->da);
+		memcpy(mgmt->sa,
+		       priv->curr_bss_params.bss_descriptor.mac_address,
+		       ETH_ALEN);
+		memcpy(mgmt->bssid, priv->cfg_bssid, ETH_ALEN);
+		priv->auth_flag = 0;
+		priv->auth_alg = WLAN_AUTH_NONE;
+	} else {
+		memcpy(mgmt->da, priv->curr_addr, ETH_ALEN);
+		memcpy(mgmt->sa, sa, ETH_ALEN);
+		memcpy(mgmt->bssid, priv->curr_addr, ETH_ALEN);
+	}
+
+	if (GET_BSS_ROLE(priv) != NXPWIFI_BSS_ROLE_UAP) {
+		cfg80211_rx_mlme_mgmt(priv->netdev, frame_buf, 26);
+	} else {
+		cfg80211_rx_mgmt(&priv->wdev,
+				 priv->bss_chandef.chan->center_freq,
+				 0, frame_buf, 26, 0);
+	}
+}
+
+/* This function processes the received management packet and send it
+ * to the kernel.
+ */
+int
+nxpwifi_process_mgmt_packet(struct nxpwifi_private *priv,
+			    struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct rxpd *rx_pd;
+	u16 pkt_len;
+	struct ieee80211_hdr *ieee_hdr;
+	int ret;
+
+	if (!skb)
+		return -ENOMEM;
+
+	if (!priv->mgmt_frame_mask ||
+	    priv->wdev.iftype == NL80211_IFTYPE_UNSPECIFIED) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "do not receive mgmt frames on uninitialized intf");
+		return -EINVAL;
+	}
+
+	rx_pd = (struct rxpd *)skb->data;
+	pkt_len = le16_to_cpu(rx_pd->rx_pkt_length);
+	if (pkt_len < sizeof(struct ieee80211_hdr) + sizeof(pkt_len)) {
+		nxpwifi_dbg(adapter, ERROR, "invalid rx_pkt_length");
+		return -EINVAL;
+	}
+
+	skb_pull(skb, le16_to_cpu(rx_pd->rx_pkt_offset));
+	skb_pull(skb, sizeof(pkt_len));
+	pkt_len -= sizeof(pkt_len);
+
+	ieee_hdr = (void *)skb->data;
+	if (ieee80211_is_mgmt(ieee_hdr->frame_control)) {
+		ret = nxpwifi_parse_mgmt_packet(priv, (u8 *)ieee_hdr,
+						pkt_len, rx_pd);
+		if (ret)
+			return ret;
+	}
+	/* Remove address4 */
+	memmove(skb->data + sizeof(struct ieee80211_hdr_3addr),
+		skb->data + sizeof(struct ieee80211_hdr),
+		pkt_len - sizeof(struct ieee80211_hdr));
+
+	pkt_len -= ETH_ALEN;
+	rx_pd->rx_pkt_length = cpu_to_le16(pkt_len);
+
+	if (priv->host_mlme_reg &&
+	    (GET_BSS_ROLE(priv) != NXPWIFI_BSS_ROLE_UAP) &&
+	    (ieee80211_is_auth(ieee_hdr->frame_control) ||
+	     ieee80211_is_deauth(ieee_hdr->frame_control) ||
+	     ieee80211_is_disassoc(ieee_hdr->frame_control))) {
+		struct nxpwifi_rxinfo *rx_info;
+
+		if (ieee80211_is_auth(ieee_hdr->frame_control)) {
+			if (priv->auth_flag & HOST_MLME_AUTH_PENDING) {
+				if (priv->auth_alg != WLAN_AUTH_SAE) {
+					priv->auth_flag &=
+						~HOST_MLME_AUTH_PENDING;
+					priv->auth_flag |=
+						HOST_MLME_AUTH_DONE;
+				}
+			} else {
+				return 0;
+			}
+
+			nxpwifi_dbg(adapter, MSG,
+				    "auth: receive authentication from %pM\n",
+				    ieee_hdr->addr3);
+		} else {
+			if (!priv->wdev.connected)
+				return 0;
+
+			if (ieee80211_is_deauth(ieee_hdr->frame_control)) {
+				nxpwifi_dbg(adapter, MSG,
+					    "auth: receive deauth from %pM\n",
+					    ieee_hdr->addr3);
+				priv->auth_flag = 0;
+				priv->auth_alg = WLAN_AUTH_NONE;
+			} else {
+				nxpwifi_dbg(adapter, MSG,
+					    "assoc: receive disassoc from %pM\n",
+					    ieee_hdr->addr3);
+			}
+		}
+
+		rx_info = NXPWIFI_SKB_RXCB(skb);
+		rx_info->pkt_len = pkt_len;
+		skb_queue_tail(&adapter->rx_mlme_q, skb);
+		nxpwifi_queue_wiphy_work(adapter, &adapter->host_mlme_work);
+		return -EINPROGRESS;
+	}
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) {
+		if (ieee80211_is_auth(ieee_hdr->frame_control))
+			nxpwifi_dbg(adapter, MSG,
+				    "auth: receive auth from %pM\n",
+				    ieee_hdr->addr2);
+		if (ieee80211_is_deauth(ieee_hdr->frame_control))
+			nxpwifi_dbg(adapter, MSG,
+				    "auth: receive deauth from %pM\n",
+				    ieee_hdr->addr2);
+		if (ieee80211_is_disassoc(ieee_hdr->frame_control))
+			nxpwifi_dbg(adapter, MSG,
+				    "assoc: receive disassoc from %pM\n",
+				    ieee_hdr->addr2);
+		if (ieee80211_is_assoc_req(ieee_hdr->frame_control))
+			nxpwifi_dbg(adapter, MSG,
+				    "assoc: receive assoc req from %pM\n",
+				    ieee_hdr->addr2);
+		if (ieee80211_is_reassoc_req(ieee_hdr->frame_control))
+			nxpwifi_dbg(adapter, MSG,
+				    "assoc: receive reassoc req from %pM\n",
+				    ieee_hdr->addr2);
+	}
+
+	cfg80211_rx_mgmt(&priv->wdev, priv->roc_cfg.chan.center_freq,
+			 CAL_RSSI(rx_pd->snr, rx_pd->nf), skb->data, pkt_len,
+			 0);
+
+	return 0;
+}
+
+#define DOT11_MAX_PRIORITY 8
+#define IEEE80211_RADIOTAP_HE 23
+
+u8 ru_signal[16][9] = {
+{0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08},
+{0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x01, 0x07},
+{0x00, 0x00, 0x00, 0x00, 0xff, 0x01, 0x00, 0x00, 0x07},
+{0x00, 0x00, 0x00, 0x00, 0xff, 0x01, 0xff, 0x01, 0x06},
+{0x00, 0x00, 0xff, 0x01, 0x00, 0x00, 0x00, 0x00, 0x07},
+{0x00, 0x00, 0xff, 0x01, 0x00, 0x00, 0xff, 0x01, 0x06},
+{0x00, 0x00, 0xff, 0x01, 0xff, 0x01, 0x00, 0x00, 0x06},
+{0x00, 0x00, 0xff, 0x01, 0xff, 0x01, 0xff, 0x01, 0x05},
+{0xff, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x07},
+{0xff, 0x01, 0x00, 0x00, 0x00, 0x00, 0xff, 0x01, 0x06},
+{0xff, 0x01, 0x00, 0x00, 0xff, 0x01, 0x00, 0x00, 0x06},
+{0xff, 0x01, 0x00, 0x00, 0xff, 0x01, 0xff, 0x01, 0x05},
+{0xff, 0x01, 0xff, 0x01, 0x00, 0x00, 0x00, 0x00, 0x06},
+{0xff, 0x01, 0xff, 0x01, 0x00, 0x00, 0xff, 0x01, 0x05},
+{0xff, 0x01, 0xff, 0x01, 0xff, 0x01, 0x00, 0x00, 0x05},
+{0xff, 0x01, 0xff, 0x01, 0xff, 0x01, 0xff, 0x01, 0x04}};
+
+u8 ru_signal_106[14][9] = {
+{0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00},
+{0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00},
+{0xff, 0x01, 0xff, 0x01, 0xff, 0xff, 0xff, 0x02, 0x03},
+{0xff, 0xff, 0xff, 0x02, 0xff, 0x01, 0xff, 0x01, 0x03},
+{0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0x02, 0x05},
+{0x00, 0x00, 0xff, 0x01, 0xff, 0xff, 0xff, 0x02, 0x04},
+{0xff, 0x01, 0x00, 0x00, 0xff, 0xff, 0xff, 0x02, 0x04},
+{0xff, 0x01, 0xff, 0x01, 0xff, 0xff, 0xff, 0x02, 0x03},
+{0xff, 0xff, 0xff, 0x02, 0x00, 0x00, 0x00, 0x00, 0x05},
+{0xff, 0xff, 0xff, 0x02, 0x00, 0x00, 0xff, 0x01, 0x04},
+{0xff, 0xff, 0xff, 0x02, 0xff, 0x01, 0x00, 0x00, 0x04},
+{0xff, 0xff, 0xff, 0x02, 0xff, 0x01, 0xff, 0x01, 0x03},
+{0xff, 0xff, 0xff, 0x02, 0xff, 0xff, 0xff, 0x02, 0x02},
+{0xff, 0x01, 0xff, 0x01, 0xff, 0x01, 0xff, 0x01, 0x04}};
+
+u8 ru_signal_52[9] = {0xff, 0x01, 0xff, 0x01, 0xff, 0x01, 0xff, 0x01, 0x04};
+
+static int
+nxpwifi_rxpdinfo_to_radiotapinfo(struct nxpwifi_private *priv,
+				 struct rxpd *rx_pd,
+				 struct rxpd_extra_info *extra_info,
+				 struct radiotap_info *rt_info)
+{
+	struct radiotap_info rt_info_tmp;
+	u8 rx_rate_info = 0;
+	u8 mcs_index = 0;
+	u8 format = 0;
+	u8 bw = 0;
+	u8 gi = 0;
+	u8 ldpc = 0;
+	u8 ext_rate_info = 0;
+	u8 nss = 0;
+	u8 dcm = 0;
+
+	memset(&rt_info_tmp, 0x00, sizeof(rt_info_tmp));
+	rt_info_tmp.snr = rx_pd->snr;
+	rt_info_tmp.nf = rx_pd->nf;
+	rt_info_tmp.band_config = rx_pd->rx_info & 0xf;
+	rt_info_tmp.chan_num = (rx_pd->rx_info & RXPD_CHAN_MASK) >> 5;
+	ext_rate_info = (u8)(rx_pd->rx_info >> 16);
+
+	rt_info_tmp.antenna = rx_pd->antenna;
+	rx_rate_info = rx_pd->ht_info;
+	if ((rx_rate_info & 0x3) == NXPWIFI_RATE_FORMAT_HE) {
+		u8 gi_he = 0;
+		/* HE rate */
+		format = NXPWIFI_RATE_FORMAT_HE;
+		mcs_index = min(rx_pd->rx_rate & 0xF, 0xb);
+		nss = ((rx_pd->rx_rate & 0xF0) >> 4);
+		nss = min(nss + 1, 2);
+		/* 20M: bw=0, 40M: bw=1, 80M: bw=2, 160M: bw=3 */
+		bw = (rx_rate_info & 0xC) >> 2;
+		gi = (rx_rate_info & 0x10) >> 4;
+		gi_he = (rx_rate_info & 0x80) >> 7;
+		gi = gi | gi_he;
+		dcm = (rx_pd->rx_info & RXPD_DCM_MASK) >> 16;
+	} else if ((rx_rate_info & 0x3) == NXPWIFI_RATE_FORMAT_VHT) {
+		/* VHT rate */
+		format = NXPWIFI_RATE_FORMAT_VHT;
+		mcs_index = min(rx_pd->rx_rate & 0xF, 9);
+		nss = ((rx_pd->rx_rate & 0xF0) >> 4);
+		nss = min(nss + 1, 2);
+		/* 20M: bw=0, 40M: bw=1, 80M: bw=2, 160M: bw=3 */
+		bw = (rx_rate_info & 0xC) >> 2;
+		/* LGI: gi =0, SGI: gi = 1 */
+		gi = (rx_rate_info & 0x10) >> 4;
+	} else if ((rx_rate_info & 0x3) == NXPWIFI_RATE_FORMAT_HT) {
+		/* HT rate */
+		format = NXPWIFI_RATE_FORMAT_HT;
+		mcs_index = rx_pd->rx_rate;
+		/* 20M: bw=0, 40M: bw=1 */
+		bw = (rx_rate_info & 0xC) >> 2;
+		/* LGI: gi =0, SGI: gi = 1 */
+		gi = (rx_rate_info & 0x10) >> 4;
+	} else {
+		/* LG rate */
+		format = NXPWIFI_RATE_FORMAT_LG;
+		mcs_index = (rx_pd->rx_rate > NXPWIFI_RATE_INDEX_OFDM0) ?
+			    rx_pd->rx_rate - 1 : rx_pd->rx_rate;
+	}
+	ldpc = rx_rate_info & 0x40;
+
+	rt_info_tmp.rate_info.mcs_index = mcs_index;
+	rt_info_tmp.rate_info.nss_index = nss;
+	rt_info_tmp.rate_info.dcm = dcm;
+	if (format == NXPWIFI_RATE_FORMAT_HE)
+		rt_info_tmp.rate_info.rate_info =
+			(ldpc << 5) | (format << 3) | (bw << 1) | (gi << 6);
+	else
+		rt_info_tmp.rate_info.rate_info =
+			(ldpc << 5) | (format << 3) | (bw << 1) | gi;
+	rt_info_tmp.rate_info.bitrate =
+		nxpwifi_index_to_acs_data_rate(priv, rx_pd->rx_rate,
+					       rx_pd->ht_info);
+
+	if (rx_pd->flags & RXPD_FLAG_EXTRA_HEADER) {
+		memcpy(&rt_info_tmp.extra_info, (u8 *)extra_info,
+		       sizeof(struct rxpd_extra_info));
+	}
+
+	memset(rt_info, 0x0, sizeof(struct radiotap_info));
+	memcpy(rt_info, &rt_info_tmp, sizeof(struct radiotap_info));
+
+	return 0;
+}
+
+int
+nxpwifi_recv_packet_to_monif(struct nxpwifi_private *priv,
+			     struct sk_buff *skb)
+{
+	struct radiotap_header *rth;
+	struct radiotap_info rt_info;
+	struct rxpd *local_rx_pd;
+	struct rxpd rx_pd;
+	struct ieee80211_hdr *dot11_hdr;
+	struct rxpd_extra_info extra_info;
+	u16 rx_pkt_offset = 0;
+	u16 offset;
+	u8 format = 0;
+	u8 mcs = 0;
+	u8 nss = 0;
+	u8 bw = 0;
+	u8 gi = 0;
+	u8 ldpc = 0;
+	u8 chan_num;
+	u8 band = 0;
+	u8 *payload = NULL;
+	u32 vht_sig1 = 0;
+	u32 vht_sig2 = 0;
+	u32 he_sig1 = 0;
+	u32 he_sig2 = 0;
+	u32 usr_idx = 0;
+	u32 out = 0;
+	u32 tone = 0;
+	u8 dcm = 0;
+
+	if (!skb)
+		return -ENOMEM;
+
+	local_rx_pd = (struct rxpd *)skb->data;
+	rx_pkt_offset = le16_to_cpu(local_rx_pd->rx_pkt_offset);
+	dot11_hdr = (struct ieee80211_hdr *)(local_rx_pd + rx_pkt_offset);
+
+	if (skb_headroom(skb) + rx_pkt_offset < sizeof(struct radiotap_header)) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "No space to add Radio TAP header\n");
+		return -EINVAL;
+	}
+
+	memcpy(&rx_pd, local_rx_pd, sizeof(struct rxpd));
+	memcpy(&extra_info, local_rx_pd + sizeof(struct rxpd),
+	       sizeof(struct rxpd_extra_info));
+
+	if (rx_pkt_offset > sizeof(struct radiotap_header)) {
+		offset = rx_pkt_offset - sizeof(struct radiotap_header);
+		skb_pull(skb, offset);
+	} else {
+		if (skb_headroom(skb) + rx_pkt_offset <
+			sizeof(struct radiotap_header)) {
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "No space to add Radio TAP header\n");
+			return -EINVAL;
+		}
+		offset = sizeof(struct radiotap_header) - rx_pkt_offset;
+		skb_push(skb, offset);
+	}
+
+	rth = (struct radiotap_header *)skb->data;
+	memset(rth, 0, sizeof(struct radiotap_header));
+
+	nxpwifi_rxpdinfo_to_radiotapinfo(priv, &rx_pd, &extra_info, &rt_info);
+
+	ldpc = (rt_info.rate_info.rate_info & 0x20) >> 5;
+	format = (rt_info.rate_info.rate_info & 0x18) >> 3;
+	bw = (rt_info.rate_info.rate_info & 0x06) >> 1;
+	dcm = rt_info.rate_info.dcm;
+	if (format == NXPWIFI_RATE_FORMAT_HE)
+		gi = (rt_info.rate_info.rate_info & 0xC0) >> 6;
+	else
+		gi = rt_info.rate_info.rate_info & 0x01;
+	mcs = rt_info.rate_info.mcs_index;
+	nss = rt_info.rate_info.nss_index;
+
+	rth->hdr.it_version = PKTHDR_RADIOTAP_VERSION;
+	rth->hdr.it_pad = 0;
+	rth->hdr.it_len = cpu_to_le16(sizeof(struct radiotap_header));
+	rth->hdr.it_present =
+		cpu_to_le32((1 << IEEE80211_RADIOTAP_TSFT) |
+			    (1 << IEEE80211_RADIOTAP_FLAGS) |
+			    (1 << IEEE80211_RADIOTAP_CHANNEL) |
+			    (1 << IEEE80211_RADIOTAP_DBM_ANTSIGNAL) |
+			    (1 << IEEE80211_RADIOTAP_DBM_ANTNOISE) |
+			    (1 << IEEE80211_RADIOTAP_ANTENNA));
+	/** Timstamp */
+	rth->body.timestamp = cpu_to_le64(jiffies);
+	/** Flags */
+	rth->body.flags = (rt_info.extra_info.flags &
+			   ~(RADIOTAP_FLAGS_USE_SGI_HT |
+			     RADIOTAP_FLAGS_WITH_FRAGMENT |
+			     RADIOTAP_FLAGS_WEP_ENCRYPTION |
+			     RADIOTAP_FLAGS_FAILED_FCS_CHECK));
+	/** reverse fail fcs, 1 means pass FCS in FW, but means
+	 * fail FCS in radiotap
+	 */
+	rth->body.flags |= (~rt_info.extra_info.flags) &
+			    RADIOTAP_FLAGS_FAILED_FCS_CHECK;
+
+	if (format == NXPWIFI_RATE_FORMAT_HT && gi == 1)
+		rth->body.flags |= RADIOTAP_FLAGS_USE_SGI_HT;
+	if (ieee80211_is_mgmt(dot11_hdr->frame_control) ||
+	    ieee80211_is_data(dot11_hdr->frame_control)) {
+		if (ieee80211_has_morefrags(dot11_hdr->frame_control) ||
+		    (!ieee80211_is_first_frag(dot11_hdr->seq_ctrl))) {
+			rth->body.flags |= RADIOTAP_FLAGS_WITH_FRAGMENT;
+		}
+	}
+	if (ieee80211_is_data(dot11_hdr->frame_control) &&
+	    ieee80211_has_protected(dot11_hdr->frame_control)) {
+		payload = (u8 *)dot11_hdr +
+			  ieee80211_hdrlen(dot11_hdr->frame_control);
+
+		/** ExtIV bit shall be 0 for  WEP frame */
+		if (!(*(payload + 3) & 0x20))
+			rth->body.flags |= RADIOTAP_FLAGS_WEP_ENCRYPTION;
+	}
+	/** Rate, u8 only apply for LG mode */
+	if (format == NXPWIFI_RATE_FORMAT_LG) {
+		rth->hdr.it_present |=
+			cpu_to_le32(1 << IEEE80211_RADIOTAP_RATE);
+		rth->body.rate = rt_info.rate_info.bitrate;
+	}
+
+	/** Channel */
+	rth->body.channel.flags = 0;
+	chan_num = rt_info.chan_num;
+
+	band = (chan_num <= 14) ? NL80211_BAND_2GHZ :
+				  NL80211_BAND_5GHZ;
+
+	rth->body.channel.frequency =
+		cpu_to_le16(ieee80211_channel_to_frequency(chan_num, band));
+	rth->body.channel.flags |=
+		cpu_to_le16((band == NL80211_BAND_2GHZ) ?
+				    CHANNEL_FLAGS_2GHZ :
+				    CHANNEL_FLAGS_5GHZ);
+	if (rth->body.channel.flags &
+	    cpu_to_le16(CHANNEL_FLAGS_2GHZ))
+		rth->body.channel.flags |=
+			cpu_to_le16(CHANNEL_FLAGS_DYNAMIC_CCK_OFDM);
+	else
+		rth->body.channel.flags |=
+			cpu_to_le16(CHANNEL_FLAGS_OFDM);
+	/** Antenna */
+	rth->body.antenna_signal = -(rt_info.nf - rt_info.snr);
+	rth->body.antenna_noise = -rt_info.nf;
+	/* Convert FW antenna value to radiotap spec */
+	rth->body.antenna = rt_info.antenna >> 1;
+	/** MCS */
+	if (format == NXPWIFI_RATE_FORMAT_HT) {
+		rth->hdr.it_present |=
+			cpu_to_le32(1 << IEEE80211_RADIOTAP_MCS);
+		rth->body.u.mcs.known =
+			rt_info.extra_info.mcs_known;
+		rth->body.u.mcs.flags =
+			rt_info.extra_info.mcs_flags;
+		/** MCS mcs */
+		rth->body.u.mcs.known |=
+			MCS_KNOWN_MCS_INDEX_KNOWN;
+		rth->body.u.mcs.mcs =
+			rt_info.rate_info.mcs_index;
+		/** MCS bw */
+		rth->body.u.mcs.known |= MCS_KNOWN_BANDWIDTH;
+		/** Clear, 20MHz as default */
+		rth->body.u.mcs.flags &= ~(0x03);
+		if (bw == 1)
+			rth->body.u.mcs.flags |= RX_BW_40;
+		/** MCS gi */
+		rth->body.u.mcs.known |=
+			MCS_KNOWN_GUARD_INTERVAL;
+		rth->body.u.mcs.flags &= ~(1 << 2);
+		if (gi)
+			rth->body.u.mcs.flags |= gi << 2;
+		/** MCS FEC */
+		rth->body.u.mcs.known |= MCS_KNOWN_FEC_TYPE;
+		rth->body.u.mcs.flags &= ~(1 << 4);
+		if (ldpc)
+			rth->body.u.mcs.flags |= ldpc << 4;
+	}
+	/** VHT */
+	if (format == NXPWIFI_RATE_FORMAT_VHT) {
+		vht_sig1 = rt_info.extra_info.vht_he_sig1;
+		vht_sig2 = rt_info.extra_info.vht_he_sig2;
+		/** Present Flag */
+		rth->hdr.it_present |=
+			cpu_to_le32(1 << IEEE80211_RADIOTAP_VHT);
+		/** STBC */
+		rth->body.u.vht.known |=
+			cpu_to_le16(VHT_KNOWN_STBC);
+		if (vht_sig1 & MBIT(3))
+			rth->body.u.vht.flags |= VHT_FLAG_STBC;
+		/** TXOP_PS_NA */
+		/** TODO: Not support now */
+		/** GI */
+		rth->body.u.vht.known |=
+			cpu_to_le16(VHT_KNOWN_GI);
+		if (vht_sig2 & MBIT(0))
+			rth->body.u.vht.flags |= VHT_FLAG_SGI;
+		/** SGI NSYM DIS */
+		rth->body.u.vht.known |=
+			cpu_to_le16(VHT_KNOWN_SGI_NSYM_DIS);
+		if (vht_sig2 & MBIT(1))
+			rth->body.u.vht.flags |=
+				VHT_FLAG_SGI_NSYM_M10_9;
+		/** LDPC_EXTRA_OFDM_SYM */
+		/** TODO: Not support now */
+		/** BEAMFORMED */
+		rth->body.u.vht.known |=
+			cpu_to_le16(VHT_KNOWN_BEAMFORMED);
+		if (vht_sig2 & MBIT(8))
+			rth->body.u.vht.flags |=
+				VHT_FLAG_BEAMFORMED;
+		/** BANDWIDTH */
+		rth->body.u.vht.known |=
+			cpu_to_le16(VHT_KNOWN_BANDWIDTH);
+		if (bw == 1)
+			rth->body.u.vht.bandwidth = RX_BW_40;
+		else if (bw == 2)
+			rth->body.u.vht.bandwidth = RX_BW_80;
+		/** GROUP_ID */
+		rth->body.u.vht.known |=
+			cpu_to_le16(VHT_KNOWN_GROUP_ID);
+		rth->body.u.vht.group_id =
+			(vht_sig1 & (0x3F0)) >> 4;
+		/** PARTIAL_AID */
+		/** TODO: Not support now */
+		/** mcs_nss */
+		rth->body.u.vht.mcs_nss[0] =
+			vht_sig2 & (0xF0);
+		/* Convert FW NSS value to radiotap spec */
+		rth->body.u.vht.mcs_nss[0] |=
+			((vht_sig1 & (0x1C00)) >> 10) + 1;
+		/** gi */
+		rth->body.u.vht.known |=
+			cpu_to_le16(VHT_KNOWN_GI);
+		if (gi)
+			rth->body.u.vht.flags |=
+				VHT_FLAG_SGI;
+		/** coding */
+		if (vht_sig2 & MBIT(2))
+			rth->body.u.vht.coding |=
+				VHT_CODING_LDPC_USER0;
+	}
+	if (format == NXPWIFI_RATE_FORMAT_HE) {
+		he_sig1 = rt_info.extra_info.vht_he_sig1;
+		he_sig2 = rt_info.extra_info.vht_he_sig2;
+		usr_idx = rt_info.extra_info.user_idx;
+		rth->hdr.it_present |= cpu_to_le32(1 << IEEE80211_RADIOTAP_HE);
+		rth->body.u.he.data1 |= HE_CODING_KNOWN;
+		if (ldpc)
+			rth->body.u.he.data3 |= HE_CODING_LDPC_USER0;
+		rth->body.u.he.data1 |= HE_BW_KNOWN;
+		if (he_sig1)
+			rth->body.u.he.data1 |= HE_MU_DATA;
+		if (bw == 1) {
+			rth->body.u.he.data5 |= RX_HE_BW_40;
+			if (he_sig2) {
+				NXPWIFI_DECODE_RU_SIGNALING_CH1(out, he_sig1, he_sig2);
+				nxpwifi_decode_ru_tone(&out, &usr_idx, &tone);
+				if (!tone) {
+					NXPWIFI_DECODE_RU_SIGNALING_CH3(out, he_sig2);
+					nxpwifi_decode_ru_tone(&out, &usr_idx, &tone);
+				}
+				if (tone) {
+					rth->body.u.he.data5 &= ~RX_HE_BW_40;
+					rth->body.u.he.data5 |= tone;
+				}
+			}
+		} else if (bw == 2) {
+			rth->body.u.he.data5 |= RX_HE_BW_80;
+			if (he_sig2) {
+				NXPWIFI_DECODE_RU_SIGNALING_CH1(out, he_sig1, he_sig2);
+				nxpwifi_decode_ru_tone(&out, &usr_idx, &tone);
+				if (!tone) {
+					NXPWIFI_DECODE_RU_SIGNALING_CH2(out, he_sig2);
+					nxpwifi_decode_ru_tone(&out, &usr_idx, &tone);
+				}
+				if (!tone) {
+					if ((he_sig2 & NXPWIFI_80_CENTER_RU) && !usr_idx)
+						tone = RU_TONE_26;
+					else
+						usr_idx--;
+				}
+				if (!tone) {
+					NXPWIFI_DECODE_RU_SIGNALING_CH3(out, he_sig2);
+					nxpwifi_decode_ru_tone(&out, &usr_idx, &tone);
+				}
+				if (!tone) {
+					NXPWIFI_DECODE_RU_SIGNALING_CH4(out, he_sig2);
+					nxpwifi_decode_ru_tone(&out, &usr_idx, &tone);
+				}
+				if (tone) {
+					rth->body.u.he.data5 &= ~RX_HE_BW_80;
+					rth->body.u.he.data5 |= tone;
+				}
+			}
+		} else if (bw == 3) {
+			rth->body.u.he.data5 |= RX_HE_BW_160;
+			if (he_sig2) {
+				NXPWIFI_DECODE_RU_SIGNALING_CH1(out, he_sig1, he_sig2);
+				nxpwifi_decode_ru_tone(&out, &usr_idx, &tone);
+				if (!tone) {
+					NXPWIFI_DECODE_RU_SIGNALING_CH2(out, he_sig2);
+					nxpwifi_decode_ru_tone(&out, &usr_idx, &tone);
+				}
+				if (!tone) {
+					if ((he_sig2 & NXPWIFI_160_CENTER_RU) && !usr_idx)
+						tone = RU_TONE_26;
+					else
+						usr_idx--;
+				}
+				if (!tone) {
+					NXPWIFI_DECODING_160_RU_CH3(out, he_sig2);
+					nxpwifi_decode_ru_tone(&out, &usr_idx, &tone);
+				}
+				if (!tone) {
+					NXPWIFI_DECODING_160_RU_CH3(out, he_sig2);
+					nxpwifi_decode_ru_tone(&out, &usr_idx, &tone);
+				}
+				if (tone != 0) {
+					rth->body.u.he.data5 &= ~RX_HE_BW_160;
+					rth->body.u.he.data5 |= tone;
+				}
+			}
+		} else {
+			if (he_sig2) {
+				NXPWIFI_DECODE_RU_SIGNALING_CH1(out, he_sig1, he_sig2);
+				nxpwifi_decode_ru_tone(&out, &usr_idx, &tone);
+				if (tone)
+					rth->body.u.he.data5 |= tone;
+			}
+		}
+		rth->body.u.he.data2 |= HE_DATA_GI_KNOWN;
+		rth->body.u.he.data5 |= ((gi & 3) << 4);
+		rth->body.u.he.data1 |= HE_MCS_KNOWN;
+		rth->body.u.he.data3 |= (mcs << 8);
+		rth->body.u.he.data6 |= nss;
+		rth->body.u.he.data1 |= HE_DCM_KNOWN;
+		rth->body.u.he.data1 = cpu_to_le16(rth->body.u.he.data1);
+		rth->body.u.he.data5 |= (dcm << 12);
+		rth->body.u.he.data5 = cpu_to_le16(rth->body.u.he.data5);
+		rth->body.u.he.data3 = cpu_to_le16(rth->body.u.he.data3);
+	}
+
+	/* Trim off the last 4 bytes in skb data */
+	skb_trim(skb, skb->len - 4);
+
+	priv->stats.rx_bytes += skb->len;
+	priv->stats.rx_packets++;
+
+	skb->dev = priv->netdev;
+	skb->pkt_type = PACKET_OTHERHOST;
+	skb->protocol = eth_type_trans(skb, priv->netdev);
+	skb->ip_summed = CHECKSUM_NONE;
+	netif_rx(skb);
+
+	return 0;
+}
+
+/* This function processes the received packet before sending it to the
+ * kernel.
+ *
+ * It extracts the SKB from the received buffer and sends it to kernel.
+ * In case the received buffer does not contain the data in SKB format,
+ * the function creates a blank SKB, fills it with the data from the
+ * received buffer and then sends this new SKB to the kernel.
+ */
+int nxpwifi_recv_packet(struct nxpwifi_private *priv, struct sk_buff *skb)
+{
+	struct nxpwifi_sta_node *src_node;
+	struct ethhdr *p_ethhdr;
+
+	if (!skb)
+		return -ENOMEM;
+
+	priv->stats.rx_bytes += skb->len;
+	priv->stats.rx_packets++;
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) {
+		p_ethhdr = (void *)skb->data;
+		rcu_read_lock();
+		src_node = nxpwifi_get_sta_entry(priv, p_ethhdr->h_source);
+		if (src_node) {
+			src_node->stats.last_rx = jiffies;
+			src_node->stats.rx_bytes += skb->len;
+			src_node->stats.rx_packets++;
+		}
+		rcu_read_unlock();
+	}
+
+	skb->dev = priv->netdev;
+	skb->protocol = eth_type_trans(skb, priv->netdev);
+	skb->ip_summed = CHECKSUM_NONE;
+
+	netif_rx(skb);
+	return 0;
+}
+
+/* IOCTL completion callback handler.
+ *
+ * This function is called when a pending IOCTL is completed.
+ *
+ * If work queue support is enabled, the function wakes up the
+ * corresponding waiting function. Otherwise, it processes the
+ * IOCTL response and frees the response buffer.
+ */
+int nxpwifi_complete_cmd(struct nxpwifi_adapter *adapter,
+			 struct cmd_ctrl_node *cmd_node)
+{
+	WARN_ON(!cmd_node->wait_q_enabled);
+	nxpwifi_dbg(adapter, CMD, "cmd completed: status=%d\n",
+		    adapter->cmd_wait_q.status);
+
+	*cmd_node->condition = true;
+	wake_up_interruptible(&adapter->cmd_wait_q.wait);
+
+	return 0;
+}
+
+/* This function will return the pointer to station entry in station list
+ * table which matches specified mac address.
+ * This function should be called after acquiring RA list spinlock.
+ * NULL is returned if station entry is not found in associated STA list.
+ * It must be called under rcu_read_lock().
+ */
+struct nxpwifi_sta_node *
+nxpwifi_get_sta_entry(struct nxpwifi_private *priv, const u8 *mac)
+{
+	struct nxpwifi_sta_node *node;
+	struct nxpwifi_sta_node *found = NULL;
+
+	if (!mac)
+		return NULL;
+	list_for_each_entry_rcu(node, &priv->sta_list, list) {
+		if (!memcmp(node->mac_addr, mac, ETH_ALEN)) {
+			found = node;
+			break;
+		}
+	}
+
+	return found;
+}
+
+struct nxpwifi_sta_node *
+nxpwifi_get_sta_entry_rcu(struct nxpwifi_private *priv, const u8 *mac)
+{
+	struct nxpwifi_sta_node *node;
+
+	rcu_read_lock();
+	node = nxpwifi_get_sta_entry(priv, mac);
+	rcu_read_unlock();
+
+	return node;
+}
+
+/* This function will add a sta_node entry to associated station list
+ * table with the given mac address.
+ * If entry exist already, existing entry is returned.
+ * If received mac address is NULL, NULL is returned.
+ */
+struct nxpwifi_sta_node *
+nxpwifi_add_sta_entry(struct nxpwifi_private *priv, const u8 *mac)
+{
+	struct nxpwifi_sta_node *node;
+
+	if (!mac)
+		return NULL;
+
+	spin_lock_bh(&priv->sta_list_spinlock);
+	node = nxpwifi_get_sta_entry_rcu(priv, mac);
+
+	if (node)
+		goto done;
+
+	node = kzalloc(sizeof(*node), GFP_ATOMIC);
+	if (!node)
+		goto done;
+
+	memcpy(node->mac_addr, mac, ETH_ALEN);
+	list_add_tail_rcu(&node->list, &priv->sta_list);
+
+done:
+	spin_unlock_bh(&priv->sta_list_spinlock);
+	return node;
+}
+
+/* This function will search for HT IE in association request IEs
+ * and set station HT parameters accordingly.
+ */
+void
+nxpwifi_set_sta_ht_cap(struct nxpwifi_private *priv, const u8 *ies,
+		       int ies_len, struct nxpwifi_sta_node *node)
+{
+	struct element *ht_cap_ie;
+	const struct ieee80211_ht_cap *ht_cap;
+
+	if (!ies)
+		return;
+
+	ht_cap_ie = (void *)cfg80211_find_ie(WLAN_EID_HT_CAPABILITY, ies,
+					     ies_len);
+	if (ht_cap_ie) {
+		ht_cap = (void *)(ht_cap_ie + 1);
+		node->is_11n_enabled = 1;
+		node->max_amsdu = le16_to_cpu(ht_cap->cap_info) &
+				  IEEE80211_HT_CAP_MAX_AMSDU ?
+				  NXPWIFI_TX_DATA_BUF_SIZE_8K :
+				  NXPWIFI_TX_DATA_BUF_SIZE_4K;
+	} else {
+		node->is_11n_enabled = 0;
+	}
+}
+
+/* This function will delete a station entry from station list.
+ * It is called only from cfg80211_ops.del_station, which is
+ * protected by cfg80211's internal mutex.
+ * Therefore, no additional spinlock is needed here.
+ */
+
+void nxpwifi_del_sta_entry(struct nxpwifi_private *priv, const u8 *mac)
+{
+	struct nxpwifi_sta_node *node;
+
+	list_for_each_entry_rcu(node, &priv->sta_list, list) {
+		if (!memcmp(node->mac_addr, mac, ETH_ALEN)) {
+			list_del_rcu(&node->list);
+			kfree_rcu(node, rcu);
+			break;
+		}
+	}
+}
+
+/* This function will delete all stations from associated station list. */
+void nxpwifi_del_all_sta_list(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_sta_node *node, *tmp;
+
+	spin_lock_bh(&priv->sta_list_spinlock);
+
+	list_for_each_entry_safe(node, tmp, &priv->sta_list, list) {
+		list_del_rcu(&node->list);
+		kfree_rcu(node, rcu);
+	}
+
+	INIT_LIST_HEAD(&priv->sta_list);
+	spin_unlock_bh(&priv->sta_list_spinlock);
+}
+
+/* This function adds histogram data to histogram array*/
+void nxpwifi_hist_data_add(struct nxpwifi_private *priv,
+			   u8 rx_rate, s8 snr, s8 nflr)
+{
+	struct nxpwifi_histogram_data *phist_data = priv->hist_data;
+
+	if (atomic_read(&phist_data->num_samples) > NXPWIFI_HIST_MAX_SAMPLES)
+		nxpwifi_hist_data_reset(priv);
+	nxpwifi_hist_data_set(priv, rx_rate, snr, nflr);
+}
+
+/* function to add histogram record */
+void nxpwifi_hist_data_set(struct nxpwifi_private *priv, u8 rx_rate, s8 snr,
+			   s8 nflr)
+{
+	struct nxpwifi_histogram_data *phist_data = priv->hist_data;
+	s8 nf   = -nflr;
+	s8 rssi = snr - nflr;
+
+	atomic_inc(&phist_data->num_samples);
+	atomic_inc(&phist_data->rx_rate[rx_rate]);
+	atomic_inc(&phist_data->snr[snr + 128]);
+	atomic_inc(&phist_data->noise_flr[nf + 128]);
+	atomic_inc(&phist_data->sig_str[rssi + 128]);
+}
+
+/* function to reset histogram data during init/reset */
+void nxpwifi_hist_data_reset(struct nxpwifi_private *priv)
+{
+	int ix;
+	struct nxpwifi_histogram_data *phist_data = priv->hist_data;
+
+	atomic_set(&phist_data->num_samples, 0);
+	for (ix = 0; ix < NXPWIFI_MAX_AC_RX_RATES; ix++)
+		atomic_set(&phist_data->rx_rate[ix], 0);
+	for (ix = 0; ix < NXPWIFI_MAX_SNR; ix++)
+		atomic_set(&phist_data->snr[ix], 0);
+	for (ix = 0; ix < NXPWIFI_MAX_NOISE_FLR; ix++)
+		atomic_set(&phist_data->noise_flr[ix], 0);
+	for (ix = 0; ix < NXPWIFI_MAX_SIG_STRENGTH; ix++)
+		atomic_set(&phist_data->sig_str[ix], 0);
+}
+
+void *nxpwifi_alloc_dma_align_buf(int rx_len, gfp_t flags)
+{
+	struct sk_buff *skb;
+	int buf_len, pad;
+
+	buf_len = rx_len + NXPWIFI_RX_HEADROOM + NXPWIFI_DMA_ALIGN_SZ;
+
+	skb = __dev_alloc_skb(buf_len, flags);
+
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, NXPWIFI_RX_HEADROOM);
+
+	pad = NXPWIFI_ALIGN_ADDR(skb->data, NXPWIFI_DMA_ALIGN_SZ) -
+	      (long)skb->data;
+
+	skb_reserve(skb, pad);
+
+	return skb;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_alloc_dma_align_buf);
+
+void nxpwifi_fw_dump_event(struct nxpwifi_private *priv)
+{
+	nxpwifi_send_cmd(priv, HOST_CMD_FW_DUMP_EVENT, HOST_ACT_GEN_SET,
+			 0, NULL, true);
+}
+EXPORT_SYMBOL_GPL(nxpwifi_fw_dump_event);
+
+int nxpwifi_append_data_tlv(u16 id, u8 *data, int len, u8 *pos, u8 *cmd_end)
+{
+	struct nxpwifi_ie_types_data *tlv;
+	u16 header_len = sizeof(struct nxpwifi_ie_types_header);
+
+	tlv = (struct nxpwifi_ie_types_data *)pos;
+	tlv->header.len = cpu_to_le16(len);
+
+	if (id == WLAN_EID_EXT_HE_CAPABILITY) {
+		if ((pos + header_len + len + 1) > cmd_end)
+			return 0;
+
+		tlv->header.type = cpu_to_le16(WLAN_EID_EXTENSION);
+		tlv->data[0] = WLAN_EID_EXT_HE_CAPABILITY;
+		memcpy(tlv->data + 1, data, len);
+	} else {
+		if ((pos + header_len + len) > cmd_end)
+			return 0;
+
+		tlv->header.type = cpu_to_le16(id);
+		memcpy(tlv->data, data, len);
+	}
+
+	return (header_len + len);
+}
+
+static int nxpwifi_get_vdll_image(struct nxpwifi_adapter *adapter, u32 vdll_len)
+{
+	struct vdll_dnld_ctrl *ctrl = &adapter->vdll_ctrl;
+	bool req_fw = false;
+	u32 offset;
+
+	if (ctrl->vdll_mem) {
+		nxpwifi_dbg(adapter, EVENT,
+			    "VDLL mem is not empty: %p old_len=%d new_len=%d\n",
+			    ctrl->vdll_mem, ctrl->vdll_len, vdll_len);
+		vfree(ctrl->vdll_mem);
+		ctrl->vdll_mem = NULL;
+		ctrl->vdll_len = 0;
+	}
+
+	ctrl->vdll_mem = vmalloc(vdll_len);
+	if (!ctrl->vdll_mem)
+		return -ENOMEM;
+
+	if (!adapter->firmware) {
+		req_fw = true;
+		if (request_firmware(&adapter->firmware, adapter->fw_name,
+				     adapter->dev))
+			return -ENOENT;
+	}
+
+	if (adapter->firmware) {
+		if (vdll_len < adapter->firmware->size) {
+			offset = adapter->firmware->size - vdll_len;
+			memcpy(ctrl->vdll_mem, adapter->firmware->data + offset,
+			       vdll_len);
+		} else {
+			nxpwifi_dbg(adapter, ERROR,
+				    "Invalid VDLL length = %d, fw_len=%d\n",
+				    vdll_len, (int)adapter->firmware->size);
+			return -EINVAL;
+		}
+		if (req_fw) {
+			release_firmware(adapter->firmware);
+			adapter->firmware = NULL;
+		}
+	}
+
+	ctrl->vdll_len = vdll_len;
+	nxpwifi_dbg(adapter, MSG, "VDLL image: len=%d\n", ctrl->vdll_len);
+
+	return 0;
+}
+
+int nxpwifi_download_vdll_block(struct nxpwifi_adapter *adapter,
+				u8 *block, u16 block_len)
+{
+	struct vdll_dnld_ctrl *ctrl = &adapter->vdll_ctrl;
+	struct host_cmd_ds_command *host_cmd;
+	u16 msg_len = block_len + S_DS_GEN;
+	int ret = 0;
+
+	skb_trim(ctrl->skb, 0);
+	skb_put_zero(ctrl->skb, msg_len);
+
+	host_cmd = (struct host_cmd_ds_command *)(ctrl->skb->data);
+
+	host_cmd->command = cpu_to_le16(HOST_CMD_VDLL);
+	host_cmd->seq_num = cpu_to_le16(0xFF00);
+	host_cmd->size = cpu_to_le16(msg_len);
+	memcpy(ctrl->skb->data + S_DS_GEN, block, block_len);
+
+	skb_push(ctrl->skb, adapter->intf_hdr_len);
+	ret = adapter->if_ops.host_to_card(adapter, NXPWIFI_TYPE_VDLL,
+					   ctrl->skb, NULL);
+	skb_pull(ctrl->skb, adapter->intf_hdr_len);
+
+	if (ret)
+		nxpwifi_dbg(adapter, ERROR,
+			    "Fail to download VDLL: block: %p, len: %d\n",
+			    block, block_len);
+
+	return ret;
+}
+
+int nxpwifi_process_vdll_event(struct nxpwifi_private *priv,
+			       struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct vdll_ind_event *vdll_evt =
+		(struct vdll_ind_event *)(skb->data + sizeof(u32));
+	u16 type = le16_to_cpu(vdll_evt->type);
+	u16 vdll_id = le16_to_cpu(vdll_evt->vdll_id);
+	u32 offset = le32_to_cpu(vdll_evt->offset);
+	u16 block_len = le16_to_cpu(vdll_evt->block_len);
+	struct vdll_dnld_ctrl *ctrl = &adapter->vdll_ctrl;
+	int ret = 0;
+
+	switch (type) {
+	case VDLL_IND_TYPE_REQ:
+		nxpwifi_dbg(adapter, EVENT,
+			    "VDLL IND (REG): ID: %d, offset: %#x, len: %d\n",
+			    vdll_id, offset, block_len);
+		if (offset <= ctrl->vdll_len) {
+			block_len =
+				min((u32)block_len, ctrl->vdll_len - offset);
+			if (!adapter->cmd_sent) {
+				ret = nxpwifi_download_vdll_block(adapter,
+								  ctrl->vdll_mem
+								  + offset,
+								  block_len);
+				if (ret)
+					nxpwifi_dbg(adapter, ERROR,
+						    "Download VDLL failed\n");
+			} else {
+				nxpwifi_dbg(adapter, EVENT,
+					    "Delay download VDLL block\n");
+				ctrl->pending_block_len = block_len;
+				ctrl->pending_block = ctrl->vdll_mem + offset;
+			}
+		} else {
+			nxpwifi_dbg(adapter, ERROR,
+				    "Err Req: offset=%#x, len=%d, vdll_len=%d\n",
+				    offset, block_len, ctrl->vdll_len);
+			ret = -EINVAL;
+		}
+		break;
+	case VDLL_IND_TYPE_OFFSET:
+		nxpwifi_dbg(adapter, EVENT,
+			    "VDLL IND (OFFSET): offset: %#x\n", offset);
+		ret = nxpwifi_get_vdll_image(adapter, offset);
+		break;
+	case VDLL_IND_TYPE_ERR_SIG:
+	case VDLL_IND_TYPE_ERR_ID:
+	case VDLL_IND_TYPE_SEC_ERR_ID:
+		nxpwifi_dbg(adapter, ERROR, "VDLL IND: error: %d\n", type);
+		break;
+	case VDLL_IND_TYPE_INTF_RESET:
+		nxpwifi_dbg(adapter, EVENT, "VDLL IND: interface reset\n");
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR, "VDLL IND: unknown type: %d", type);
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+u64 nxpwifi_roc_cookie(struct nxpwifi_adapter *adapter)
+{
+	adapter->roc_cookie_counter++;
+
+	/* wow, you wrapped 64 bits ... more likely a bug */
+	if (WARN_ON(adapter->roc_cookie_counter == 0))
+		adapter->roc_cookie_counter++;
+
+	return adapter->roc_cookie_counter;
+}
+
+static bool nxpwifi_can_queue_work(struct nxpwifi_adapter *adapter)
+{
+	if (test_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags) ||
+	    test_bit(NXPWIFI_IS_CMD_TIMEDOUT, &adapter->work_flags) ||
+	    test_bit(NXPWIFI_IS_SUSPENDED, &adapter->work_flags)) {
+		nxpwifi_dbg(adapter, WARN,
+			    "queueing nxpwifi work while going to suspend\n");
+		return false;
+	}
+
+	return true;
+}
+
+void nxpwifi_queue_work(struct nxpwifi_adapter *adapter,
+			struct work_struct *work)
+{
+	if (!nxpwifi_can_queue_work(adapter))
+		return;
+
+	queue_work(adapter->workqueue, work);
+}
+EXPORT_SYMBOL(nxpwifi_queue_work);
+
+void nxpwifi_queue_delayed_work(struct nxpwifi_adapter *adapter,
+				struct delayed_work *dwork,
+				unsigned long delay)
+{
+	if (!nxpwifi_can_queue_work(adapter))
+		return;
+
+	queue_delayed_work(adapter->workqueue, dwork, delay);
+}
+EXPORT_SYMBOL(nxpwifi_queue_delayed_work);
+
+void nxpwifi_queue_wiphy_work(struct nxpwifi_adapter *adapter,
+			      struct wiphy_work *work)
+{
+	if (!nxpwifi_can_queue_work(adapter))
+		return;
+
+	wiphy_work_queue(adapter->wiphy, work);
+}
+
+void nxpwifi_queue_delayed_wiphy_work(struct nxpwifi_adapter *adapter,
+				      struct wiphy_delayed_work *dwork,
+				      unsigned long delay)
+{
+	if (!nxpwifi_can_queue_work(adapter))
+		return;
+
+	wiphy_delayed_work_queue(adapter->wiphy, dwork, delay);
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/util.h b/drivers/net/wireless/nxp/nxpwifi/util.h
new file mode 100644
index 000000000000..8e45fefe8055
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/util.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: utility functions
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_UTIL_H_
+#define _NXPWIFI_UTIL_H_
+
+struct nxpwifi_adapter;
+
+struct nxpwifi_private;
+
+struct nxpwifi_dma_mapping {
+	dma_addr_t addr;
+	size_t len;
+};
+
+struct nxpwifi_cb {
+	struct nxpwifi_dma_mapping dma_mapping;
+	union {
+		struct nxpwifi_rxinfo rx_info;
+		struct nxpwifi_txinfo tx_info;
+	};
+};
+
+/* size/addr for nxpwifi_debug_info */
+#define item_size(n)		(sizeof_field(struct nxpwifi_debug_info, n))
+#define item_addr(n)		(offsetof(struct nxpwifi_debug_info, n))
+
+/* size/addr for struct nxpwifi_adapter */
+#define adapter_item_size(n)	(sizeof_field(struct nxpwifi_adapter, n))
+#define adapter_item_addr(n)	(offsetof(struct nxpwifi_adapter, n))
+
+struct nxpwifi_debug_data {
+	char name[32];		/* variable/array name */
+	u32 size;		/* size of the variable/array */
+	size_t addr;		/* address of the variable/array */
+	int num;		/* number of variables in an array */
+};
+
+static inline struct nxpwifi_rxinfo *NXPWIFI_SKB_RXCB(struct sk_buff *skb)
+{
+	struct nxpwifi_cb *cb = (struct nxpwifi_cb *)skb->cb;
+
+	BUILD_BUG_ON(sizeof(struct nxpwifi_cb) > sizeof(skb->cb));
+	return &cb->rx_info;
+}
+
+static inline struct nxpwifi_txinfo *NXPWIFI_SKB_TXCB(struct sk_buff *skb)
+{
+	struct nxpwifi_cb *cb = (struct nxpwifi_cb *)skb->cb;
+
+	return &cb->tx_info;
+}
+
+static inline void nxpwifi_store_mapping(struct sk_buff *skb,
+					 struct nxpwifi_dma_mapping *mapping)
+{
+	struct nxpwifi_cb *cb = (struct nxpwifi_cb *)skb->cb;
+
+	memcpy(&cb->dma_mapping, mapping, sizeof(*mapping));
+}
+
+static inline void nxpwifi_get_mapping(struct sk_buff *skb,
+				       struct nxpwifi_dma_mapping *mapping)
+{
+	struct nxpwifi_cb *cb = (struct nxpwifi_cb *)skb->cb;
+
+	memcpy(mapping, &cb->dma_mapping, sizeof(*mapping));
+}
+
+static inline dma_addr_t NXPWIFI_SKB_DMA_ADDR(struct sk_buff *skb)
+{
+	struct nxpwifi_dma_mapping mapping;
+
+	nxpwifi_get_mapping(skb, &mapping);
+
+	return mapping.addr;
+}
+
+int nxpwifi_debug_info_to_buffer(struct nxpwifi_private *priv, char *buf,
+				 struct nxpwifi_debug_info *info);
+
+static inline void le16_unaligned_add_cpu(__le16 *var, u16 val)
+{
+	put_unaligned_le16(get_unaligned_le16(var) + val, var);
+}
+
+int nxpwifi_append_data_tlv(u16 id, u8 *data, int len, u8 *pos, u8 *cmd_end);
+
+int nxpwifi_download_vdll_block(struct nxpwifi_adapter *adapter,
+				u8 *block, u16 block_len);
+
+int nxpwifi_process_vdll_event(struct nxpwifi_private *priv,
+			       struct sk_buff *skb);
+
+u64 nxpwifi_roc_cookie(struct nxpwifi_adapter *adapter);
+
+void nxpwifi_queue_work(struct nxpwifi_adapter *adapter,
+			struct work_struct *work);
+
+void nxpwifi_queue_delayed_work(struct nxpwifi_adapter *adapter,
+				struct delayed_work *dwork,
+				unsigned long delay);
+
+void nxpwifi_queue_wiphy_work(struct nxpwifi_adapter *adapter,
+			      struct wiphy_work *work);
+
+void nxpwifi_queue_delayed_wiphy_work(struct nxpwifi_adapter *adapter,
+				      struct wiphy_delayed_work *dwork,
+				      unsigned long delay);
+
+/* Current firmware doesn't support AP and STA running on different
+ * channels simultaneously in normal mode.
+ * FW crash would occur in such case.
+ * This function is used to check if check_chan can be set to FW or not.
+ *
+ * Return:
+ * %true if check_chan can be set to FW without issues.
+ * %false there is already other channel is set to FW, setting of
+ * check_chan is not allowable.
+ */
+bool nxpwifi_is_channel_setting_allowable(struct nxpwifi_private *priv,
+					  struct ieee80211_channel *check_chan);
+
+void nxpwifi_convert_chan_to_band_cfg(struct nxpwifi_private *priv,
+				      u8 *band_cfg,
+				      struct cfg80211_chan_def *chan_def);
+
+#endif /* !_NXPWIFI_UTIL_H_ */
-- 
2.34.1


