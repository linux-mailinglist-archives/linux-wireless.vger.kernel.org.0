Return-Path: <linux-wireless+bounces-28593-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BBCC353EE
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 11:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FB1B4F406B
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 10:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E2A31062D;
	Wed,  5 Nov 2025 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J3410/Ij"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011031.outbound.protection.outlook.com [52.101.65.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661CA3101C9;
	Wed,  5 Nov 2025 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339802; cv=fail; b=bliEasWAFG1CBzDTFzkyjtUcPijBn9o55ygaFK66wibFXMqRB3lJqzbLk5sBXib5KywfQNfH/K9Bixe8xBe1pAPgESOcaxp5wmeRRlGZWL4kDawz900UjPexp7E9I3Pq9YRInO/yjfPQnjRRM/9NLcvR80luu1xSVpNXwUhOodE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339802; c=relaxed/simple;
	bh=+KuFrIoK+JKid0GiEO4Fq6Navp1oBhyJjH+iKBLjkrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DbyQK1NdXWJss7MWGvrT8mqX/CAct5VFGsAW4CAZoX0l0ULOD8RUKIqinXC5vx9n8X3pfwvoDD7tQCqKdiD9I61A8DunwQOOnvUGZJdTlPtckyhzwK5vrBP6UzZBmh9eYBFXZBCwwqCUNU6SzaEr6hRW4qjDuCKMtPPrQWV3QrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J3410/Ij; arc=fail smtp.client-ip=52.101.65.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogCbtxuWqhFniqR591wX71GgBqALvydutRG8M6DcQm7m6kt07kITFJSpPFmvE02XuFYQHDs4EMTxuHPLFsUChSV7G2Kf30Vc64qKdsvBADt8AfdfbV5j7770XZQnAOMNPK7hkvp/sg5uch++HH5NjuXTeun+Q0SGUTHG7vCLjVQ+aA+gzHmkC8d91wqIyBtcLL2+o3Sw9Bnl/b6S/u0j7BiXwlAj/4l0f1h42gAKF475o6Au8MQ6ECM5J3nMz2KJ4x/onOdW/M8yC9ldRmOjDgLbIdjSpgElgnWcCBqHrTDL+Uie0y9tzCHoVox6pCKWCro+nN6OKHf/tTxwxOBlJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwatvWvI1AHlLVit5qiu24zp44U2wVWQ80MdufUlSxo=;
 b=bkfyM1vTsJVo4jZHT+Uk3GlIi8qQ7rZZHlKNCtkSLaQYsdAE9rAXuwt9z5Yk+si/SKD3guEOFSqwIZOdxj5EVlC6surwDOOvoY+v5/ZLbLzWMNLJ1e+dHZ7+r6iW8ZPaokEL0lvoSrLf5uvNk83QL69riyI3CJRTHdW7HMc8CxDf13zEcxG8AI2Ic8snqHItLvQiOARh1CFZWzzs9H9BRS+q2/0BIeO3ZLOmxPLqAjEzMNBjlLx63wwa4OkU5Cc339ylTsAyx5xxpOEKdk3jM+tWhiS4LSM/VgMFMOL0NMLuMOwSPw2zz/kCreUwJQ1cGmtQYCGYIQ7Jcxz5x7ZSdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwatvWvI1AHlLVit5qiu24zp44U2wVWQ80MdufUlSxo=;
 b=J3410/IjG+f2D8e1ygBIhnBKGtUYlwf2fSP5IL5pZ/xrUFd+LhF9cjxpo8EI94SOoyJBj8p5B2aBRXi+rVHxUIctwpRQRUzgXNh8SYt/5iVKPAAnSrx9Szz9IDnmYoAnZWQuwE2X0R78QdlzsWvxkFugr7dx/ui5BYZl7t5kvWL8Sy8Oc+bXEbBanNCTwWmFqbDzetujMDfQYzoXsI+OBIk/H+Vz9xKl74wHCqqXNmP/H9rlTQokpqzYsCLL3ER0KjDj9Cobkw4VXBLQQFyl7L0jxl1FrUIDvymzvhHVWnNGansFzOXakwNWdBPqWMNi1XThMsUs3C3+jBFWNvZd2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by PA1PR04MB10770.eurprd04.prod.outlook.com (2603:10a6:102:492::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 10:49:45 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%2]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 10:49:45 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v6 15/22] wifi: nxpwifi: add ethtool support for Wake-on-LAN
Date: Wed,  5 Nov 2025 18:47:37 +0800
Message-Id: <20251105104744.2401992-16-jeff.chen_1@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|PA1PR04MB10770:EE_
X-MS-Office365-Filtering-Correlation-Id: c753929c-e059-4827-5d72-08de1c590893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7G/IQvsgcb3k0Wcin/7A1NSE4WfR9hdDU1q2ypiWBKMNIVq0SluQDmapF41v?=
 =?us-ascii?Q?f6jS0krLKK1/24TmiMuiRjR5DUuT5s/e/Jb8DsBk+I+SrOMRmu5xx6pL2R++?=
 =?us-ascii?Q?eCSg4CCtAw5a74oD2tMi1YYSIXddtEzHozrHUNn8iPosGiPZ1sIZ2vX/Vzjc?=
 =?us-ascii?Q?yGy1X95+nDV8EOsALGuOfpIvqZeiZJjBXAmmhdocyCB/wLDZnwLboLfCLU4+?=
 =?us-ascii?Q?4ySPf6BvkTXdtrcRD2j40a9KchIWpzRY1jQLoSyCPiEUviod1fTWTfVO0Ykx?=
 =?us-ascii?Q?7Xs0NWvx+TKk0Z6VDIycCcZLHzg8Dhy7TWnfIWVRvxKhS8DZgGheLSkDnikW?=
 =?us-ascii?Q?vhCBWbNcOFs5iZX4kWL68UgVedrICTGB/CbY0fz9BmSyhS49vp1NKkkeKPFt?=
 =?us-ascii?Q?xCsu+Xulc0aV2k1I9RWV8Z87esWAVbBA94jtCiBzjtnlQkoZHVH3DyRbwnnb?=
 =?us-ascii?Q?trIZF/t5q6AFJbi+Ecl6MA1teTwFG5MGevOpR0yHr9EfZxT/ULVD2RcL1mWb?=
 =?us-ascii?Q?K7Texsa4XY3Fo5UU2Tz94N/utMf8mFiZx5gIOz9Kpxg769Rcn/hSsoHS3VPG?=
 =?us-ascii?Q?P/EDJGkMXj/OXjMEtVFrn4pog0v6+XOC2sdI6Lx3ardrGuZk8jqmxCMCHP8b?=
 =?us-ascii?Q?HT3hDf1QFQMPMBj/vxifTeczDVl2pHQKQmnM8W2vIHGdsiURvk3wo3n2sCDo?=
 =?us-ascii?Q?LzpchIGYJwr5StoupUz5SAvUt5BcY7B5aRhjNrFtlNfCvix29BiDcvi6YyeI?=
 =?us-ascii?Q?QHb2B8buC26O+9pcUNw4RqoSrlijchVsrDUJp2jg9OgbkZ76ksXYmrhwD1gC?=
 =?us-ascii?Q?9NraarcLUvZ+ZeWrwDG3dOVGc+/UAPPuPr5r5SE+jMXT6Y2w0rCmT3+JkGUs?=
 =?us-ascii?Q?E+rYRt0+MPJ75nwfwgBi2/g16I7HVfHUhqhbftjfnHC7cWG96oKsoziYj654?=
 =?us-ascii?Q?dVMYyVnUJrxHmmfVtEe1vRTwwrLkns2MPr3wmlXHHnByOBq9vYo/i2gQ6Ur2?=
 =?us-ascii?Q?bP2p9qA5kjxBENErdYvVm6nIIWPyVvP1vayY1/2/Yo3aPngjmkBneYk04gZ1?=
 =?us-ascii?Q?yIucvoQYDz3Mx1/bE0bTFER7zPvWEUbYKyBF+a4VS0Xk24ZJ5yjHodubLFiK?=
 =?us-ascii?Q?qf5slbqVvd0HR4m4YdWkDOyApqHixUZiA4penVstN+glclDQTzTTJVD1zMlC?=
 =?us-ascii?Q?UDnWzd/AqEKTZ2Xy1ne/VdmYbNOb1JRagRdTUV16QqdWcsprereL1UNstnBp?=
 =?us-ascii?Q?inef8kLZW49tVyTLvvm+HF2ctbPDb1V665peJIWNKhEGg+OQGgFGQgPY/P6D?=
 =?us-ascii?Q?I/yY+baeGuU32wk0mPg+0PrS53zt3NHtv4mPAynUFHBhbjixDskIjnw4ikQZ?=
 =?us-ascii?Q?JLDmenuvDcjxm/KDbMmkddbbGK1uBXXQ36YoRaoUavPA66kSEnWcDC19AVDO?=
 =?us-ascii?Q?QT6TJoS9ts3gBo8pKYj3KFTqhhAvG1a40Qq2/SSWluzdQaTlVu5YQcyiogJH?=
 =?us-ascii?Q?aUmJwThY24BZefipr0KeSlOapJ4f9LtTAgX9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GdxIN5jf4Zg7dQJ7BOgwQP+rHO8nRjJUP+ww4qbctxMzjLlg7d4mE1a+AZTq?=
 =?us-ascii?Q?o8c9YwpghmUpvImItYkNL2gxNJx1gLPD0wrAZZn0PEtjlk52NzU5VnZNK7v2?=
 =?us-ascii?Q?NPIm6btUsZVH8jDyPg4ECnfZYLkolHjy/+OEgMQA5YU6bV3f87rc8OtgaezR?=
 =?us-ascii?Q?X9cJGqiYI6lG3ZUR/o9L1u5wwMLDZHjC7WX7koMPlr6Ni/QxhIUEN1Yxj7Af?=
 =?us-ascii?Q?mvTUs/sJa0o+OhFt8CAe4gf8Fsm7brbL4Fu4IMWWSyTnF8nPxsvj7OOO6FWz?=
 =?us-ascii?Q?SBcxKALLgj7Mpfa0qajVCU7yW4Z/0DEBzeG3Vq4tePFb48XSUInjkuy2HtFs?=
 =?us-ascii?Q?A1viyVnr1RaCHX+PZFk2Zmy/VS7RqjGQgcfMpm8pyzOE8/OrVDHEXCw//LX5?=
 =?us-ascii?Q?AADnz5FyXppnhxxQPyKcUGO0u0ac5TmQDUIeGYvyEHZEKBHQ64Cz68eKNhwn?=
 =?us-ascii?Q?P7XkuY95WrFweIPN1+irLLnjUWJuPab6sf6/rpddrstgf4IiO//FYCKYP4YT?=
 =?us-ascii?Q?ZA+NpCFqMNYaLszMjhA6xRYEKd5RimRZsfAJNd+smEcfvttrvUsgCBm2aGHf?=
 =?us-ascii?Q?QcgR+Pvqyp+4zZmPRGz8yXxRzlxJcM0v3k4sori4vqx8MkkQ3XzF5xU5CL8m?=
 =?us-ascii?Q?318AzWUZykGFQHpTOOGy+SEEZXMBy0f7OcHqB9e1QTvGUYr2K0gqTofjxXJw?=
 =?us-ascii?Q?2YwVeephx//bIoaSU9VQkpsLJhaMWU6tAEV1f35PH2yNjoaKYDLTK73ylny2?=
 =?us-ascii?Q?I4yoK8W4S6TXPWBRPPoSy/vVHwIPrgT79BRzf9qBC8P2txwans8PNF02b3Yx?=
 =?us-ascii?Q?kq1YnlLfYgb9XLpNZhI1Twer7BtTdrv8gyl4fhOe5OY3HhHHymhBKWq1cVDN?=
 =?us-ascii?Q?I/CjW5Dp31f+CZb1jVQagiXyX26XcuOsHbGAlO8+8W27B+/20AMyHJ+937aJ?=
 =?us-ascii?Q?bCoFsFsSA5YQaHoh0r6Pm2gYdWMwvR6S5unwyFAKIeu4gBEfg0vUKhoMGLYL?=
 =?us-ascii?Q?jfkA+Sdtp4wDm9pM7mj8YfFPIwiJC9fs7h/v3o2TqpncRks+TlRvGR09wnvv?=
 =?us-ascii?Q?Iw7VJWh3g69tWMC62JDAxJFArGKZkux699LfEbD34/6KpDI+MbXunk4ALcp+?=
 =?us-ascii?Q?0xz/uU0L0nP5bsF5cbP3y4AJwJWNZsbw5Ljy6voV5F47GAgAE9WhoV4zGcIn?=
 =?us-ascii?Q?quKz94YgYHSmiFcw7xyvN4FKiXlIfr+DfWS9CMFWwM7BSqGeFHXIyJuiQX8/?=
 =?us-ascii?Q?WDxRMo+YkfXyD1wErh4VrXkfQ8cDR0g9BSj6UH7/zkEfQCDla4ECWKG+jyLV?=
 =?us-ascii?Q?IiVstb1HIXbWgo82/5lxM/RGc/tnSXTl1jB1g7zeCqVqnp6czmWpACAjm2Eg?=
 =?us-ascii?Q?aw8RqwlpqC/mG/DR6HPMMaWDzaFIY4tFts1EdzuGsrNA6J7cR2CGYdEqEUtC?=
 =?us-ascii?Q?e7mpDP5BjNwfpShrNNxiGXhgIfm4V/FHqfV7IfFh0YuYwwho94I5aPL0Fp1x?=
 =?us-ascii?Q?tz/kM3Ic19WKA5YkXKJermUC9CHVuC79kmVY1uca6auPVox+MFe7dkoFEuco?=
 =?us-ascii?Q?0ESN52V+K+zfAk+IreOp2AL9PpTPiCHMsbRXaYCm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c753929c-e059-4827-5d72-08de1c590893
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 10:49:45.7991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnxK9TsdYf7y/DkQ95jTFSeBXTohUC/ETs0k8FkvwbBFN9oKQ9sOTf4mct5X7Jhw79L8RNTjVOJEXu8FNi1JxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10770

This patch adds basic ethtool support to the nxpwifi driver, specifically
implementing Wake-on-LAN (WoL) configuration via ethtool.

Supported WoL options:
- WAKE_UCAST
- WAKE_MCAST
- WAKE_BCAST
- WAKE_PHY

The ethtool ops `get_wol` and `set_wol` are implemented to map ethtool
WoL flags to the driver's internal host sleep configuration.

This enables users to query and configure WoL behavior using standard
ethtool commands.

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


