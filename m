Return-Path: <linux-wireless+bounces-9404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 055B4911DBF
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284AE1C24525
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37BB17C7A5;
	Fri, 21 Jun 2024 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l7U1rQMG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E51C17C231;
	Fri, 21 Jun 2024 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956492; cv=fail; b=Qa4Ku++9SSpSjpJc6xLMhriyfXTsoNZbQtbwOd0Xzbrg2avaT7tYzj0ikQEQ3Q3r/w2GnsavfiywR+XpGHmUmgzHltcd9BxZGl56YuVbrdj6LrT+RYxE+4SASYsBAInB1Ad/PSdrmhja65MrInwvg3I5H0dvccl04BQcwfcxn0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956492; c=relaxed/simple;
	bh=6kz0dAR7s+4BKduwOOZeVo52NyWSIIA1RC0qWf817/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rrs/CbctGnPXyVPD0oXIc7i3ObZnlz8zGCiWzV4DdXkEjekHD+c0pgPZtm1kq6F5fv5PBgthhkYVWVujGGE/O9F6xUSXfqnKWluiVq7r0RlYfKBWQpmXZGRTItbzu18vR/Vr8lKxkgMRYdw8hUmL1PvKs5PIicd3vVWdfBgTFqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=l7U1rQMG; arc=fail smtp.client-ip=40.107.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrhJs5xYKZPdvqt1kl/NbVZXZciMPAUzLkREUB38kWEuXoLYViSGroWsXUu8YUI9bjfi9FVLul6vJ5l6XDmbXsbG3IM3ehvGAWpOa8mDVqNfe3zBMzQ8ybA9rBsS8Exmsz/gvtjq40GKf7DiUkNjNL4rBFyMCrJcgH1iY0JA/q6RnTnqzRttAbPKLdundEoL6Kq0fiUe7RMMHFLXPEMKvIu4cuDst8703uzlRA+sYlsIMQ1GxbaQY23UzeO0c/hY/uwlm9njzkVqadcJ1LsVAZy1MqAeCxamXG52DPJYpHigBZom1VtzuBzI+IO8ts/YNYd8hZ1clgg7FLk2U3bSPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6Ig7070qJrDsRlIbUuyG6Lpe4pP3AavFpuqyDJICvA=;
 b=Eih9zTeMEsya9FZS2BiK76hV9OWabKa26j5F9bXAq9eR1QThOIPBcUMsGRlbgVPdpjt9iWUw5T6uhubDZFMP8C0yGUvr5TvzOzSe91ibvPLVyFbZtM2WilZZU9xFc6LQCRI2f8Z2o45EecsljfuYgwmEQwZlG615TvO0RyAZsMJwcpngtzt2agInAbj+hlZWC9/8IoG0fXkGyCuGFVUGDoeqrk79K4sp3WcKFBU7TL6hBd54WkSXKINDfB32q21U3/S3y2T/xvp0+jSWkcNK+awOmqGNc6UvTC0XGp+PD1SNzj7bSPD/rZcm58iLujDNEKu6OxDKGyNx3AiXPZvm2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6Ig7070qJrDsRlIbUuyG6Lpe4pP3AavFpuqyDJICvA=;
 b=l7U1rQMGjIiQV0fHvwEGalclUVFwoGdcZfDpiAXA1STrPwQdsqN4tYrJVyeXKTQvOkRgEMwQPSxhZRl1F4szQ+LARt+M0hGfGzTvPzJb1a3Qn0kNSTjTnHhz+m5NA20ILBeqsQlskhapJGrcpqI6A7p5fsAbMqfY+Q90Jj+UgFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI0PR04MB10464.eurprd04.prod.outlook.com (2603:10a6:800:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:54:45 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:54:45 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 40/43] wifi: nxpwifi: add wmm.h
Date: Fri, 21 Jun 2024 15:52:05 +0800
Message-Id: <20240621075208.513497-41-yu-hao.lin@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|VI0PR04MB10464:EE_
X-MS-Office365-Filtering-Correlation-Id: 91503985-3dc1-47df-ab51-08dc91c76ab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|366013|376011|52116011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wpY9iqHD8IpcL+JHYnacArJx1s7SBcRx4HEDvgjkxKKkqKs2FjX8oMQCIz7N?=
 =?us-ascii?Q?KqtOybVp2pJGCpRpmt+qstdbphhRUNwASOE3KSmwGEBcIz3UvQp4YKWde1Dq?=
 =?us-ascii?Q?qxsSu0e1VPBYwIs+D4xJGzWvdHpfhHDwc1+0hKvOPIp+EDaRGnKPUjEcxJG3?=
 =?us-ascii?Q?U+1by6A49Pinc39G6mXbLBSKpjB3eskR2UhdxtO5ylZrwiBFvuwWeMpJYD5t?=
 =?us-ascii?Q?s92566Gx9Ny4PBpq9iIL4OliT/yxzVrYL3q1feBymW4XvBQwjSm7qmWNlE+B?=
 =?us-ascii?Q?lbmspYomvucdYEwhQ0qEv8YgFkei+3AvYswpT673MvZAaNDxJ919Bq72c2Vk?=
 =?us-ascii?Q?Gm0wFxWGvJ/vSLYDoR/xLDuTRjIwuTxbdd7N8wDSJIHvXIBLxyTzppEb3Ezx?=
 =?us-ascii?Q?Dz3e2UeyjkefXP69FfyKlqriquL9puGRRmKEhkhCgEMesQ7dnhVhLBDP4a4U?=
 =?us-ascii?Q?U0HOihYISR4FhcU2g4G6xpd+4uKD6ldTrXplc3iwx8j+mi6Dc0txu6jElD+j?=
 =?us-ascii?Q?y6tqZkIwugHrEs8C/Lt6nnlYUcSBfhiGMy5Irl/5+7eAppwpLhbD6l2VvkxS?=
 =?us-ascii?Q?0GuWDrUB46VhjilJZDcwrXs3OIKLr61k2YY2dggvBK1l93oYPfvmQd+ODZNy?=
 =?us-ascii?Q?bClDJqosBpsK66zKfSDzKHVnCddEJxXEX8q64p0UniudML7CpXfQyB/r9g/V?=
 =?us-ascii?Q?QN2HX5ZAKx2szq4HqQTXmxdpy56nrazM7l+2Vby6EW6hgd8PQyX8cQNmO992?=
 =?us-ascii?Q?TVx9vtfPu3JLZbkrJv7stSTA59YlAStnaDRMX81Tp/EAdINu66GXK0sopkt5?=
 =?us-ascii?Q?3Hbdyk1H9IAellb2PpsPIMYKUoFn+8RVKLQiylApWMVC4XrPLzbi2WEEE6PO?=
 =?us-ascii?Q?ZLzxY+JrncFYxoLkziOqVqprWalQOKX+ylZ13raGH/Zy3hTj3vgjRemnaDMx?=
 =?us-ascii?Q?pcV0mOA+YYX1+kSt9shG+q8Dqv4IM8mK19qO/t0PXaynxGvh/BcBwus1P1R6?=
 =?us-ascii?Q?K5GeAH9Mwown4C32moLe+JNE/cpxk9F/MnswXKEmgkE+C3R+tZ2zUd+Mgm+X?=
 =?us-ascii?Q?LICauGSlJTnWOkxPUfc6K/k1thKx1itk0f5LwwWVO7HtQavn9LvMJcIhqQ43?=
 =?us-ascii?Q?h+F6hVSgVqVdcVob0Q1iQPa0Y47q7HljDkHqtl0ChIdTjChF9plA4nH5FEQd?=
 =?us-ascii?Q?gpBQ1KH6QcrxKsP8iKDcaqrXXGp7TJYU3NZ5CvuAXmWeOA4A3kq7UnCO5jcG?=
 =?us-ascii?Q?4Zt4xrnuXXWV+ep37fSq8J0LdJ90iDd2s0TouvIClUojuIHiwuXWwp5DbbgU?=
 =?us-ascii?Q?awDQoK15wWZSA+WKdWYHi7stO334/GZhBbfUth8dkpBqmsw3lCDLBEnNq5d3?=
 =?us-ascii?Q?xlNdZEA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(52116011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dpEkJEOHPqIZm3T8xlZdYBMOxwbWvgAl/Zd0UdXz7ceg1VKcwDiGEyHp/fu7?=
 =?us-ascii?Q?7p1CYmKztZuvugL0gi2hEOghYZ2riocxOl/rq+9M/E1DZHstq4QaUIpmF4NR?=
 =?us-ascii?Q?/7PHefsqxHhfCwj9JTv3BLDAj78Vp6R6Lz0okSV0DdOkCGdLaA3snNLsycWB?=
 =?us-ascii?Q?WM4QaPYEueqYolcdnocGBi0FlA/ZkkG6kxz2U1XN0fO0o4YXt132ar/oNcUE?=
 =?us-ascii?Q?eF3mcHnr2wKjighE8+tWPiwMFGqYoShaMtc+F5M8w8ZmXeUnVuOARzBdbpDc?=
 =?us-ascii?Q?UJqntLqeF4Ff0RTZgU0O51A6x8NJGBuvHAU1D5rVcgSiRoND0HSSSwCnnUo9?=
 =?us-ascii?Q?iCc8+zW844q/UY4tnWeHTipgZEhK48hMxMBcupocUvSQ+flAxnkbxCJm9ZEQ?=
 =?us-ascii?Q?jJ/AbapNIePyBUIPvnS/xY6TuJbJ0CXMzgPeWujrIAl/W6rlcdmHm0s2YdGP?=
 =?us-ascii?Q?uI5VsqyzNkpuusDCOqIPn/OjgpHAQ5ADOvq6OXHrmcJmPXacoeR/gj0L6Zrh?=
 =?us-ascii?Q?b1Jueq645Vc6puRiJC4reulhpN7JaVbfczpwVatppaL1vX/0PVqgaZ3yxOi0?=
 =?us-ascii?Q?KpP9PKe3M83Li8IagORI9Hk4wR+7Voz4/9Id0+FovfqxBpyITKJt7EV3gFnd?=
 =?us-ascii?Q?kjk1LC/P4pnKrTI9cborklB0/LaljvCp385OlHV4bBtZmvhw9ZQUK2JazzKE?=
 =?us-ascii?Q?ao4XmLu/tdODgAoUHF4zTjwx9ptp2RZ3be1FqLqMpf01UTV0GX+k3jTh83b+?=
 =?us-ascii?Q?GNf2iub0beuwUww7JYgoH7s8nTCo8bHbINDUKk8gYVLErBTdyXl+7ZYvMoN8?=
 =?us-ascii?Q?YY/uij8/Jp7B4ynctP1JIaWAxS0Oj8RdzL9QUn1LQYBH3T6juH98BE++Eeiv?=
 =?us-ascii?Q?ZImlgNzEy9hj0mtX2VaVFSOB1IK0BVt0T4+IpppUADq5FNsvvm4d6AEhQL/3?=
 =?us-ascii?Q?u54C3FiLHTUXpOVZ4YvfZg9NFz7VMdCvmYKSnpcZHTPhznLYwvHhb3VYTbgj?=
 =?us-ascii?Q?rRKlQtM+HBVsIC53d1Nvgdr1vTf5NNxoSgvnNtInBD6HTrF9OSzxYR+9SObr?=
 =?us-ascii?Q?CUmD7A6D612miyOkrYX0H12a85VLVzGR1RhjesN4WIcyKZZPGs/guOt5EvGa?=
 =?us-ascii?Q?JJJ5xXtudBNA6EWF7T5SFfizfjDUn3eBMUFv8C0naFsHsnzY+YbZ68Q24wHK?=
 =?us-ascii?Q?/RuT3s7KJZeRTpPcCaJoGzWQ2TvFZ6rQyCuG0R2uDDhPrT/5b+frz0YPfESD?=
 =?us-ascii?Q?gMBdX8+IG7jEdvtxsz8xfdmmtTOtJVXs7QNXOt6Trkfw5c+U0yDs8CqWpnFk?=
 =?us-ascii?Q?mFIFCMZcyeYKKoxqAI8UqMSz8QzwUJKiYrmZAV/8P9rTitXwMsmkAeh/yjFL?=
 =?us-ascii?Q?IHS0WaiXvoPUtImhXUDEXJCCiuSdcxj38DnRYXe3otBVPfBbNAf6xJzpjH9t?=
 =?us-ascii?Q?L/4ebWGoFLEWRhswFPd+USHF7s7+FlWzQCojIW38C+1YbSctWPMMyq3aA5jP?=
 =?us-ascii?Q?+ttZYC/Zf2lcsAw9uwmeZ48ni8uBAXxZ/UCYkm4/IpXWiENXArle6oKg0cHN?=
 =?us-ascii?Q?V2/cknbf3PBndyTZzIG1STgPtDFV6wLKsLVV4wVQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91503985-3dc1-47df-ab51-08dc91c76ab2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:54:45.7762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ft0bSUvDbiG8EA05aAbuXIzRsMIIBxDZZJgc88SwEANh6vyrrwMfP3SkRnWewmgG7eXzjv6JKNJ/Cn9TxdzcXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10464

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/wmm.h | 95 ++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/wmm.h b/drivers/net/wireless/nxp/nxpwifi/wmm.h
new file mode 100644
index 000000000000..e1f8a1c80a2f
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/wmm.h
@@ -0,0 +1,95 @@
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
+/* This function checks if a RA list is empty or not.
+ */
+static inline u8
+nxpwifi_wmm_is_ra_list_empty(struct list_head *ra_list_hhead)
+{
+	struct nxpwifi_ra_list_tbl *ra_list;
+	int is_list_empty;
+
+	list_for_each_entry(ra_list, ra_list_hhead, list) {
+		is_list_empty = skb_queue_empty(&ra_list->skb_head);
+		if (!is_list_empty)
+			return false;
+	}
+
+	return true;
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
+int nxpwifi_wmm_lists_empty(struct nxpwifi_adapter *adapter);
+int nxpwifi_bypass_txlist_empty(struct nxpwifi_adapter *adapter);
+void nxpwifi_wmm_process_tx(struct nxpwifi_adapter *adapter);
+void nxpwifi_process_bypass_tx(struct nxpwifi_adapter *adapter);
+int nxpwifi_is_ralist_valid(struct nxpwifi_private *priv,
+			    struct nxpwifi_ra_list_tbl *ra_list, int tid);
+
+u8 nxpwifi_wmm_compute_drv_pkt_delay(struct nxpwifi_private *priv,
+				     const struct sk_buff *skb);
+void nxpwifi_wmm_init(struct nxpwifi_adapter *adapter);
+
+u32 nxpwifi_wmm_process_association_req(struct nxpwifi_private *priv,
+					u8 **assoc_buf,
+					struct ieee_types_wmm_parameter *wmmie,
+					struct ieee80211_ht_cap *htcap);
+
+void nxpwifi_wmm_setup_queue_priorities(struct nxpwifi_private *priv,
+					struct ieee_types_wmm_parameter *wmm_ie);
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


