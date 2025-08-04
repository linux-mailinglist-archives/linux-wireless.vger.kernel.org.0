Return-Path: <linux-wireless+bounces-26145-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BD9B1A685
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 17:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F283BB984
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 15:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C5B279324;
	Mon,  4 Aug 2025 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PS2CE8DZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013050.outbound.protection.outlook.com [40.107.159.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E945278173;
	Mon,  4 Aug 2025 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322402; cv=fail; b=Gi+BEPUORZEM2ikEZi9lMfiUe088U1y6DrYH6yPT0qIkZgmrYZmA8CWZ9GjKjA4ST2D6i4+K5s7ce3hoDA6GZlK+I+/UQ+7XG1Sy7o8ZuVPD6q7KZ1/GIH6XyMKT9ywL/aik5HK9ggNjSbID9xO+OVyo1WnPSWxfhJ7wX4RwpCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322402; c=relaxed/simple;
	bh=TrtBGMianyTto3Fy5B2Uot/t7tfNntHhvKPbGguM4KM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ELexBjXtD19LZQZV3YsbW/VW8xNMJ+JKa2tW6td6Fp+rsAcwMlyLZYqvaGkVP2ENYgcW0lN+yrXVizNdQ0MnakbeRHHD4ZXPX+341v+QjaK2cePwAKSrRRUKjHp+Zf2tlsLjbaMGas8/pKyUp53ZpfQ2Uxu/Lf+iSB4kKiwLBGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PS2CE8DZ; arc=fail smtp.client-ip=40.107.159.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmltggNkuK0G2zZEvNXIyzK1BDsiFL7RHZis00Ls2ArlSILu4djOkHkpHd8FJmEn7junA1wAiPpFNFsIub+OuffztR1jYLERUAy0LvqX3IoKIxX+GU5/L7/wcLY4kj7g1w9AM41+1lQ6HrE4c71+8P4bDNDBchDhJqG4e7NDKdSuP9xx//pyw16CUjxDcOn2seds2tv2KMfu0p+KbIrLCsbiDbkVKqjduZSWPcU9sS+V7GdKLMX+LfFRXMHeLibt2MbxX5yJNomGvQIdzHDAySm7hU1yO57+mW/LyKN9939nhnevZkA/9aUtdGo2HJyJ2d4/C/xX3+wEFmnLUoDY7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2tSrewRU5pFIYo0HCyT5LfkTqEyZxGDRrRr/nJ3mGs=;
 b=CcDoeWYLEPXgwN9bKKs1ELfSNGZRHKxAdEY7PlABRuK7YON3R+LmFg7xDkicRQj1ciRuEG/gCtCXpG7nsNzZy+4jdJnU0HQWpz5Wkot9cU9kPmVEd5uoaL0Id5pVR80mNwLZddqv5j65OG6qx4yN1Byl81L9Zup5elWZmjMsf9oQjuExa03o31CE9kyRd/93KCFdRkefbC7GxiCaxN2ULrqZ4rhPEk31VUBPZTAA8EibW6lZcSHDU5LGDTyN+sj1p224xHmSvPvxvyWwKEtABl6iPkfAhkqdhmquXwsf/XywlAFwQhm/EP7/LjqcgUgQ8CmSII47T5i1Wc17HylccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2tSrewRU5pFIYo0HCyT5LfkTqEyZxGDRrRr/nJ3mGs=;
 b=PS2CE8DZ3VMDYnPsJxqrigAFPBWNodY6vvIfjnhSHNScyvt/CPk1z6hQUGsO4NU9ThK1M+rV4umVP3xhA5XHQXbvDTdsSOD+GjH6dx96LZW00gIGdx5ClI0z/mA8hJHPCV3vkT311DWsp7+ilf9aQZlfJHFQKE7ISOTYkDHmH9oesMmrwIDf3Q4475XhTO3TSWBm9RsqNPi9Q2vhbArP/OBqbDiiYRLOUFHfUoOzElYuXrONNniy/iK3cbO3jdbqadc7Pa1vqdE2K380CXIZhqhfnOaRP2Y11y05p4MO1JRhK9w678W+lZg+WOjRI293hoAbiDP/Z96Tw9xbWM+ArA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by PA1PR04MB11432.eurprd04.prod.outlook.com (2603:10a6:102:4f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 15:46:27 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 15:46:27 +0000
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
Subject: [PATCH v5 15/22] wifi: nxpwifi: add ethtool.c
Date: Mon,  4 Aug 2025 23:40:11 +0800
Message-Id: <20250804154018.3563834-16-jeff.chen_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f6f02943-f2df-417a-f781-08ddd36e131d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xXPaR5yYLEFZzWQVzLnBYeM9vt08ijfNgyCGUdNkn2ytqoo9t2E+pvU/r/yh?=
 =?us-ascii?Q?uukLOrGX9ZyDsOa7Ta2hDYHdDak3gaZnPcpniia3wXzConP+UI1vaQwSLOAm?=
 =?us-ascii?Q?qD67beTXzfc5Od15DEavOoZtnadRH/E/I73IHSfmpCezgua8jgo24tX+uRbE?=
 =?us-ascii?Q?eoMcrKWL2x7BD55yIjY3qaoDnsqxlJ/xg8uN30T0NwoRL+QpJ3s+D0+++OHT?=
 =?us-ascii?Q?s9ezQEboglIIe4FoaFDrTR9yCQMpki6snjYAqjaIWrB+nF6b13z15VLj8U18?=
 =?us-ascii?Q?vvhGxB+NaRcCGHgMbROW9sRzJr4k8PgWo8SCgxoJY2pGEEnIZ/0XpYscJlTN?=
 =?us-ascii?Q?4Fn02kijxYilVmirKRRmOTd2BCzrQjvawuKrzRbLwOlKm7btVPpeglwzA3a6?=
 =?us-ascii?Q?U2dIz3fNeJe52rAEiv9QvvOw5wKEbwcI+/+BE0ZZJK/HNHEPh0YlTMLbtooT?=
 =?us-ascii?Q?iu1imTZMVw5ZGA+NNsvvSdra984xZgWa7xnFQz4Z4ysKvqQRHt54QeS3BE5o?=
 =?us-ascii?Q?c7gn4B/dGqFdaCCCCaoB8O8ryvDSEWptCsgpWzkS2akmfMDslbjRmycXehRL?=
 =?us-ascii?Q?FkIMIT/k0sytBpeaAUvRVEuTkecBJ3SDO5PPDK8t81U4SUv3ra+R9CFzAO7B?=
 =?us-ascii?Q?t+vtG7ii5S13WiIouLGWDM8Y6fo0iGvQ/WISQseJir4hIJ1CV5Ixea2yGfkq?=
 =?us-ascii?Q?Ix9Z05u4i9hSgvSt1irV2WVPBmsgtzuLlpU7MJkxuZ/jtUlUCFRwIL0YwG7O?=
 =?us-ascii?Q?Z0myA3kV/gZssTMJOUKmZ+ARzkqSb58z5DuG0t+VMRKPF1PjV6ZUTzDCFnFF?=
 =?us-ascii?Q?aPoJRwMMTJdkZG7EXISH9FH9Sgnut311ba+dfULR0gfSYo8q5KiH4MWZXhoI?=
 =?us-ascii?Q?ktpamr0s62oE0KnD3tbRgBDyymA9zTOUvWe8kRWrhfba01WPgZVc7dlrjgll?=
 =?us-ascii?Q?38JIwnqtUNCuraGu4jAyrdHcg/c3YiCvZ75J7c0/qGSFJ+SvsZ+uyhDmxA3m?=
 =?us-ascii?Q?NqhgNvY016oa8XQjNc8q0MsyTKD9DzNuXtIc0DmpZOlc4+Mr4GK5tgg3T3nm?=
 =?us-ascii?Q?Jp0mX1/9fcGyazIZlMqyDoc92BFSzfpqlkj4YHCQWtAzKdnZghgj1ulfxO6q?=
 =?us-ascii?Q?4/8/+kyYq8ONyhzRBiyA0llEfowQoYvLYYkLQ8bhzknU6KsXwO9ogDWFR/q/?=
 =?us-ascii?Q?W3rWq9CBi3ZaYaEluuFuwUQkVpSHeecWcAT5CBSronFLZO772XhRIayDDfcb?=
 =?us-ascii?Q?cVS/ucK2hmRVyrfFoPiWVbly1YIUZC7GdAG33w6mnSqc1sLHpwhQ2Hp4o7nm?=
 =?us-ascii?Q?oWjfE9IPEEbfB3EBNFSRpT6pS0awRElUzTMsPCukSWOjsur98nBCaBl76pRZ?=
 =?us-ascii?Q?Qey3hI4zLy89jKiIheWzWY7JS0Up2tEa+tsj1i8zU2xqFDxdX/sL3hxWn+w0?=
 =?us-ascii?Q?NBbceEVvyFP8as2B8QHRtusDvXkPJIfW10vpOFDaThfqhb1X1gLw2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VT0SYke1gqFTSYoxlpycYkiRJ6+SzasjNJ5ZhCJ3IztrkqmpeZtWFe0MpV0I?=
 =?us-ascii?Q?TE5lp/BbBiwOac8neOt+tgLbnW6srbn125MBfWopdi6szrM3n3iL3ddvXfW7?=
 =?us-ascii?Q?/Dl5o1GwWXGow3218BhA9UBW5rbx+FqKYwPsNyq5HBiEl1u6MAsOoyFjy5l3?=
 =?us-ascii?Q?2sgf8ZMeLW5PSmyUqEs1ZBlsQUyNi5mMPyoCIoZE7vyt7oVwp8sQ5au+N/E/?=
 =?us-ascii?Q?JyrP1+YDRrFCkMf0NvwEYDbPSSfJguxz1JS97JJHpQpqBpip9JrQXCLUnkBj?=
 =?us-ascii?Q?03X6morL5jTL16WnQ+2JReQnN/TuDycX3gJxa9tefyBULrKYXbwHzBEnsDwc?=
 =?us-ascii?Q?uunsF/FckB1lo+3Or75Y+WHR/twvOVHxgHT4/zKkcrSfWdNHYiH1WXKXZ6FL?=
 =?us-ascii?Q?XhsD7gRvwdMRntgfnvEVbo3x2UfUmHFISGLN1O+mhB3rOfAmvlic6XIZ9Fl7?=
 =?us-ascii?Q?9hsNfwoNfioSQZX26CHGFcz4Znzw0jxDR+gjRk3TVLCOKERLdiZYrUtpaZ9G?=
 =?us-ascii?Q?lKrqj+F/4AmKk1iVCYhyR/L9UeYwgPtxY5HkKz784Q8jSfhcP8GUiGJ1D5Zj?=
 =?us-ascii?Q?INCajQRpGoCAdyyxYEqCcXhdlHo52WA10YisdujZ41/4QrSQIYIvinr6AfKW?=
 =?us-ascii?Q?CUmUUS1l+mk/n/ySgG1tEewUazHCRE5IpNJ8mu5ZmbpzUUaRlerQ6IaqfnsU?=
 =?us-ascii?Q?qj+mVTObOWEFyOciXKn47Ehls2usndh8QXr/LbjVJQs5InCBBF6lcB1rMBK2?=
 =?us-ascii?Q?dOUTpd1mHPkFytFW8Kq24UsJXZHKUBUswmmCqWjbV8+3ydXU2tcoRyS+WiYa?=
 =?us-ascii?Q?C7i5RtawEtGDd9rJ+LLwrDeoYdOggkj9pezMXSBEI2p3fX5l9mo6SSd+4mBS?=
 =?us-ascii?Q?Wp6F8rZoB9lf2aUh2aC1M8oob753cxRisM2weLFWYHaf03QS/g+4qjC9cPR+?=
 =?us-ascii?Q?8OyzUEW9aYL2rcgxwkBUE2sXLTmODjirANa0tx9omztNaLlNRzAC5q+EXMBY?=
 =?us-ascii?Q?MfYS7EoesJvzRbXs361SmtbWn40Mj4J8ibmkCaUtFNSMF6YGf+s3ASd5BRIv?=
 =?us-ascii?Q?ahBjutl8MRl39575yf1+SK6wTakzlNIpHAXEj746QWo7Fgsq0OVVT0qjStAY?=
 =?us-ascii?Q?UoPU4hWc80Qq7Zm897zHRM8Mf0DDaKgH1rPkqUUnrW/Tk2rEg7W+8RDiFFf5?=
 =?us-ascii?Q?uXXkIW5QHnjfzL4Q6FdOetSVf/sZD2WF+vMfqDMabWdc3Bm97FDQR7tupJk3?=
 =?us-ascii?Q?ed4wEsC/LZGTw6+bUhz7AL72gHsxxY0/vcjCkc6KAzd8dhVPN4edU+lfE6Uv?=
 =?us-ascii?Q?VGBrYYvFblM3OWT5EKt2ghfX1m9n18+G7IgARgrK6BjqYOsndSFwYN7ACbq0?=
 =?us-ascii?Q?Gf3Y6X1BuDTkAhzPciymYseKv4dtbEvFVRm9W2sbxrzPiVgOXFWvKRJiEn1n?=
 =?us-ascii?Q?keXeou0KGLaeChEVOTfymrk0GzA5oNmr0Zv27HNm/IV6geB/F5cWQFvj6z3k?=
 =?us-ascii?Q?zrwF51peDGxqTvMZGFKl+VobQ9yk2cRgrZeGupcRc7QKNIPqghp7cLSzD/ki?=
 =?us-ascii?Q?tUM0tb+Aztw1XU7mJlmAwiV59Xl8LLtrz+LRo2/N?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f02943-f2df-417a-f781-08ddd36e131d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 15:46:27.8499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kknsiZ3Y8RfXNbHQWVdCKMVj+szwZlRhPlW8Y5p6xRhUiPag/qPe/HyQCle2qq91Bk3v4Db6uOP8LrqiVT8I7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11432

Implement functions related to Wake-on-Lan.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/ethtool.c | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ethtool.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/ethtool.c b/drivers/net/wireless/nxp/nxpwifi/ethtool.c
new file mode 100644
index 000000000000..6cefa6e6f5b3
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/ethtool.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: ethtool
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "main.h"
+
+static void nxpwifi_ethtool_get_wol(struct net_device *dev,
+				    struct ethtool_wolinfo *wol)
+{
+	struct nxpwifi_private *priv = nxpwifi_netdev_get_priv(dev);
+	u32 conditions = le32_to_cpu(priv->adapter->hs_cfg.conditions);
+
+	wol->supported = WAKE_UCAST | WAKE_MCAST | WAKE_BCAST | WAKE_PHY;
+
+	if (conditions == HS_CFG_COND_DEF)
+		return;
+
+	if (conditions & HS_CFG_COND_UNICAST_DATA)
+		wol->wolopts |= WAKE_UCAST;
+	if (conditions & HS_CFG_COND_MULTICAST_DATA)
+		wol->wolopts |= WAKE_MCAST;
+	if (conditions & HS_CFG_COND_BROADCAST_DATA)
+		wol->wolopts |= WAKE_BCAST;
+	if (conditions & HS_CFG_COND_MAC_EVENT)
+		wol->wolopts |= WAKE_PHY;
+}
+
+static int nxpwifi_ethtool_set_wol(struct net_device *dev,
+				   struct ethtool_wolinfo *wol)
+{
+	struct nxpwifi_private *priv = nxpwifi_netdev_get_priv(dev);
+	u32 conditions = 0;
+
+	if (wol->wolopts & ~(WAKE_UCAST | WAKE_MCAST | WAKE_BCAST | WAKE_PHY))
+		return -EOPNOTSUPP;
+
+	if (wol->wolopts & WAKE_UCAST)
+		conditions |= HS_CFG_COND_UNICAST_DATA;
+	if (wol->wolopts & WAKE_MCAST)
+		conditions |= HS_CFG_COND_MULTICAST_DATA;
+	if (wol->wolopts & WAKE_BCAST)
+		conditions |= HS_CFG_COND_BROADCAST_DATA;
+	if (wol->wolopts & WAKE_PHY)
+		conditions |= HS_CFG_COND_MAC_EVENT;
+	if (wol->wolopts == 0)
+		conditions |= HS_CFG_COND_DEF;
+	priv->adapter->hs_cfg.conditions = cpu_to_le32(conditions);
+
+	return 0;
+}
+
+const struct ethtool_ops nxpwifi_ethtool_ops = {
+	.get_wol = nxpwifi_ethtool_get_wol,
+	.set_wol = nxpwifi_ethtool_set_wol,
+};
-- 
2.34.1


