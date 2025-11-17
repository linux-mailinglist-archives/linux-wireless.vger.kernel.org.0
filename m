Return-Path: <linux-wireless+bounces-29044-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AA6C63B95
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 12:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1EA84E063E
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 11:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19760331A56;
	Mon, 17 Nov 2025 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jg9A+/Ra"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E73A3314B7;
	Mon, 17 Nov 2025 11:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377383; cv=fail; b=AfyBOUqlJliLyA8yIOp2hwDuDiGRNve+yvpJRftAcA71fUF9v6p5bU02T/wI83BeNThgt1Evu4Nyo1ebDTlUqwROPFY//SBXCoecQc8b1WVw8CKIkrUuc2pEZWiERuRZUmGBsF5hlQ4iosTskhO1YGRKEwNvm2IXXCu9k1Q+HmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377383; c=relaxed/simple;
	bh=rjFAqmGAunq+A2rVobUf29rfxL8J2FaKZJh3XTvufAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dHDVSBIaLsg6BxWkguZcg6IdGRiHJCSBTXaRaIsX0vR6TYbkX19HDDnL6gt7/CgLElXbYysvHJH1uwKf8NxvLVe/yj0g0fbUGW2UWKt2QZv4uAc3COegMhzK8+eRnQXvY2jPUiJSWn6wT9IgFS3X8v+ehbXsVS1FgfCN7BMTAsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jg9A+/Ra; arc=fail smtp.client-ip=52.101.83.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLWbdveirWltlVwjaC76MGO9hwGs790RW9fShz4HOf+k21ykqVFGd6I4tBIV20BXnOn/bHgy2y/eJD6vzrgbDg98qhLl/7JCB24uDwWeGUFuMCw2zWiw+r/VZaVQ/uoLUdK99rYE52vOAPYMeLRa4ZLUoEPZK1q2fsYA2UHRlThFgdVGbOvONPf2+9rdu62dDRcET3D2NanpnbtTYqthJKtgGlZNGX8vra0f2gOJjqdWiJmEa7LL6Fa/Qyesb5RPEmgq8P3tGYsCS1RWwsrWwEmZ7yo1mI+N567PA1uYa9MMGMvOvrJjnZF9Yv9AP1hgh1XgKNpq+bPoff3b9CMgJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sziBrxCTUL3VebxBPrHbiNIG5zbwEbusRVwj6Nhm1Qc=;
 b=MUwypKX4cxpzR9saW+/w5RR486z7UtfJLPKO0UxipcVWN2UT7qUhiZ/3rr5ttv9PMNfdamo9lHR7Lkj45n73Ho9OlQLerACNwSq5tFcEPfSFqPxVWVtvjGdfJ/G+VoU+BP3F1qP96kxDAMNu6lN9yprBXhwVfoQvUtTj1tGERyj6kkjtV1F1Pr9nCuiTYXvDnc0lvOPxfEk5xTARd9V4vPjUTVQ6Xp/uPTuIwNy8WWmyOGJypQt3YHwNRLuu+wMHM5F9gPSt1sz06TJFUVdACLNtx1Eo48//xFOF4xyiHn7N/n7VhrJUtysUgEkrm62BeGR846ySHDVySXj3hF1Irg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sziBrxCTUL3VebxBPrHbiNIG5zbwEbusRVwj6Nhm1Qc=;
 b=Jg9A+/RaoX+WlbzKO0qCYCMOUU+hWQ7S06szsIjBWdIVGiy6/klSs8oA/ThC3MHkVG5T/xTxdVt1V8Y0nxRrgcXOBVSYAWFtwpouC+Iq30VejFMfxJHdceqJJAh6VVCCCiPahkTlGkMfmwGdm2A3PuFaT8sNh9b5t/Nm4/rzNIhY9Yc7ERAEUxHf+3peJbWGt8shVRASQgVzV+sjtSsbkRocVVd0aoBOcFfa7K1La0jJTsjj/nDUGAOG6lmGLHp2xdwKMz0LS/y6CnWbcoWOAyQJpIti7m50/FJ7olVLt1EifsxobBY2knKjxIyQvy9sFotNGoiD8aG7b1c8FrJEGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by GV4PR04MB11852.eurprd04.prod.outlook.com (2603:10a6:150:2dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 11:02:57 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 11:02:57 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v7 21/22] wifi: nxpwifi: add Kconfig and Makefile for kernel integration
Date: Mon, 17 Nov 2025 19:00:45 +0800
Message-Id: <20251117110046.2810811-22-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117110046.2810811-1-jeff.chen_1@nxp.com>
References: <20251117110046.2810811-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0007.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::8) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|GV4PR04MB11852:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4e249d-63ef-4513-8041-08de25c8dd6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hX8z3gR0dOCVxcEYKfKchU3XxU2IwsFC6GrJ2smxt6+VHbCakobPxD0hJprU?=
 =?us-ascii?Q?stTDlSNOwU+eEUNkVuEKO9iaG6WJVXY0J615/2H6PfRwIA1HaIcxAXV4dSh/?=
 =?us-ascii?Q?vo7DcsROeHxPgWZIk3dtmeXVnmYSg+/K0CaSwqfNUu6QRlyIWYFMuZNV9j8v?=
 =?us-ascii?Q?ZGCTDVV8Jw42DsA1BBZcnbugQfhQGbPVHDL7uJPCKYLOEUQcBtpKVLzMx5RE?=
 =?us-ascii?Q?P4aVcgXy3orJEbLAgLfGacOyR0Tnbtk8ne9i+4Y1DnRhPYbXi98jiEdcHyXf?=
 =?us-ascii?Q?buo8qBlnvhis/704AUjdRiNQaUgyaKYWhc6ptXMj4JeSOA8E7ZsyElslSdrI?=
 =?us-ascii?Q?TVaq8w7KhYIeCSEoF1gDshZQK6Ujy320OfqcgCWYIIiWCW6+EVtngGzDh1ce?=
 =?us-ascii?Q?m8lqMYctVebJvGyGZ0IrKQZbHdGZbdBT55GcLJZOdnQnOGqheC7vLzLkZd9z?=
 =?us-ascii?Q?bBWvrbOjX6JNBdD2wWH173rogLiAkF9jlanjExfsyrIBLHpZtCP5CpO3jmVB?=
 =?us-ascii?Q?eLNh2sEJsfTUlSHEeN8qC/w03gSvn1gFOFa5Plm+RHh7jnLr2S0zTgJIOGQ0?=
 =?us-ascii?Q?1tPfnpCW6Nuo9yjRfUqph0O4TBjHjPJf0GEodMnEHfhoK2T5KhYlhuFojFv4?=
 =?us-ascii?Q?tekTp8gvBtDp18j1OhgKctojY57Y9BHjvv+jZw5vTcfITXOkg0ldRO0wrmtl?=
 =?us-ascii?Q?aZVQOLj9fcZivCjz8FPMcA6/miA9V3rrjRK9zi6fFg856V9xH+3o5hB6StUd?=
 =?us-ascii?Q?RowH03EZ0CHcnQxUvauXNH+zSnlM8dgnoHfSc8GB82nc4EceKKcK5Ka01z6r?=
 =?us-ascii?Q?n8nNCJRjnhJJuudFE5X4hDZs399Q715wGJ91MSWBpsjDIbRW93eAWXV7/1gw?=
 =?us-ascii?Q?hbISDF8Q6fgHHjonaaoQTzfa9/n4nG+xBTHuXWpSZ+0t4j2FLHh/gPGIKzgb?=
 =?us-ascii?Q?oAzVTQWywHzvSqTeXiyBZUpBV6/J3cuIrmG6NgntIJICF5WIHW/qUGkSwEQY?=
 =?us-ascii?Q?DD3oxBoQR4+ABo/73L7FekIw34mPrTmoLieKKs3/0zUUElRnpRgrdlZWABHY?=
 =?us-ascii?Q?XkoEX4kmEygnWXDqc/kaCJpggxiB208LdcaiukK6jgY7OhPo3JgJtYpQWovA?=
 =?us-ascii?Q?SQbxBl/xDv4FOwDkK8LmEx8tSvvWaKCfmxxXCosNbPGeiIGa47O1onW5+oCU?=
 =?us-ascii?Q?YC67sLCgz0ivTV64/6bJSDCWWvIEpCS3SsW0JRHnvzMlMe7jNmxXLVt9nPMG?=
 =?us-ascii?Q?7MKvTUKVnj5R4Y2fuj02tdjFrINTDn1QWkdyE+E9HrimpC2tA3ZpQJaV5OO7?=
 =?us-ascii?Q?8Szs/WpmgE+W+nr8NjjTKi+MWwlLL7j8Q+W6+iawRjgNHs58QuOvgGI1cN3z?=
 =?us-ascii?Q?Dr4BgRtQOcWZt9LX3WCPcrf69FDHJgWCQIBX4zHdKinXksBO15nr40zvYwOl?=
 =?us-ascii?Q?eRkrzufKvMTEPA0PECype0WqDfvLIHmaNuG1/bhbrwU48s7aVgn00n99vL6W?=
 =?us-ascii?Q?u5MdKG5NY8if6/ncM7vWSLy/VBwjZyZ5GFya?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6zbnOVJzBHnQ/BkAzbshjYqZjWPDnS8jrpfx4ZsyZAwNkpGUMUmVUDpoB6Kp?=
 =?us-ascii?Q?+/CKG9UAJX2VaYW1GICLK30Q6y9GYkCYmBK93Yzh6I9j8J9chO8pnlfQFcRV?=
 =?us-ascii?Q?6g3ULJHLHhmkFhrmRJ+jBuCk29MkSEh/Z+7o/LD6bWccfpe8g1Cb2dda5Spn?=
 =?us-ascii?Q?WxJl7DN7b7RaLrc1ptcq+XgQe/FMbyZ4wNyaoGEmTyVgAx1B2h58ujzeJfr0?=
 =?us-ascii?Q?wqq6wdpLzB4aeiO/C8WPi6y+2+dEy8cSmy6A8K7NC34uEJm+Gf9UrJQEPw2S?=
 =?us-ascii?Q?1OobF/Q8Ioadybse1DAJ1vZlfyG1hxX1C6HLNn4iA3Rrr4uXnfNDwROplT4x?=
 =?us-ascii?Q?5leAGhesjE5pcRax4iGFw92KPCfIZ2nRwu42UIIx+aKu9fpNiObxsZ0PtE17?=
 =?us-ascii?Q?p63w7Yp7Kx9BpYa7YjjTli1bQ9bE8nUPDAUXTzkm4k5dLue3VomhIEaY+QXA?=
 =?us-ascii?Q?iH/q8WvQlWPzwYEm63VFFHyOUCqNU8ys3dJfaVEArcBkP3AQ9Cw1OniLoK/v?=
 =?us-ascii?Q?au8YAplDV8wjqykq3avO9K0foC1hAmfhu5h8kZZrXxWOAr/TeNkHvl6NEKCI?=
 =?us-ascii?Q?1GcXuUXsvH0PnZPNHKYU42LB7n4wE0hut3/Yuw7uTKeRKqOIZnyp80+qnalW?=
 =?us-ascii?Q?HEFlWxQGZtAeVsu3IgxT3QOJjdLV/kEdhDYhhrip6gc03yzd3jGOuXDfGwUg?=
 =?us-ascii?Q?bvfSFMzsABOSmSAicxOc6hxs6uLdaDL9KXbawmFW5KOuy6HV9+9Fub/ugFAp?=
 =?us-ascii?Q?8LyjnVWEYaHJdJmD84LB0jnH3cnFGPlRdCzG0rSWRtwwripuHrHPjjFw9qBL?=
 =?us-ascii?Q?zLkZ+srVYhukUcY6JFAskjGhAg4N38OH08VxA2M1hn/pJMwOvsa3re62bNNU?=
 =?us-ascii?Q?v7WKUK80N212wTScOpvV84PgtfImUvnv7zponzJ1BDFa6gul9M9PWKjQq5FS?=
 =?us-ascii?Q?FROWInRtZmOaW3/c1crRJGWZd5TLJ2hKkPdJ3dkHBM8JQ0wzNowYi16oP0Im?=
 =?us-ascii?Q?t8wcJwBD4l1+g0NLBVlKhep9NGWGKxDoL6hzjA7qoe/HYpQ8dntpC/lMszVY?=
 =?us-ascii?Q?d8rOVgACAKn0mH+uPsiGsECMPn8X14pA9AsZwYdWHXE3OEY/zJ4AeXms/p4K?=
 =?us-ascii?Q?iQqRNtJSF9FEabgoLwnS4QhSBxkwmJNXu5lqq+yZWOQp9BjIm5LED8ttnlVm?=
 =?us-ascii?Q?dRuGLUqIMh0k8Kq4+WBeD2YoajkhKgTaeFTeWKmKOPx24yJg1GzoovfCBX51?=
 =?us-ascii?Q?exP41wO5wb+aL7E7jb9knU4cGd5JgnHZxbouZYiJcSp4lU2NXaRUC4bSlBh5?=
 =?us-ascii?Q?Mu/yNQBHK7HG6cxxoDqBToxqIjmaSOi3dK9649syNPxRoxSTTa/Yw5uu7L2f?=
 =?us-ascii?Q?CF0IiOkBG1QkiaGoH+6R0iJ6NgRmSj60Efl4WFR10UGfQKwTerjBclRzAuT2?=
 =?us-ascii?Q?ZDN7Ou1ut7ReAUlnoIU+6UNWeAZO+TNr0uxYzQx5KFsD3A6UuZoyTb1GCrHA?=
 =?us-ascii?Q?+Ww2lrJV23bZ3VYcYiypOFN+4y7NPjJC98qia6EAaBF5H2TK90LaMdsPhCYi?=
 =?us-ascii?Q?dJ2CEHs644S7X0ZmE+vWvisfWy4VflSd0HCu2gmd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4e249d-63ef-4513-8041-08de25c8dd6b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:02:57.5178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgA0Z+oW1nHw/xvq+PXwl7MYIWK4quw7yTw2UP21sEzEVzi3xpRozgvsNz0MAyhZ6LIwYCk0o3IJysd0ZWNjSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11852

Introduce Kconfig and Makefile entries to integrate the nxpwifi driver
into the kernel build system. This allows the driver to be configured
and compiled as part of the kernel tree.

Changes include:
- Adding WLAN_VENDOR_NXP entry under drivers/net/wireless
- Defining NXPWIFI and NXPWIFI_SDIO config options
- Creating Makefiles for nxp/ and nxpwifi/ directories
- Registering nxpwifi and nxpwifi_sdio as build targets

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/Kconfig              |  1 +
 drivers/net/wireless/Makefile             |  1 +
 drivers/net/wireless/nxp/Kconfig          | 17 ++++++++++
 drivers/net/wireless/nxp/Makefile         |  3 ++
 drivers/net/wireless/nxp/nxpwifi/Kconfig  | 22 +++++++++++++
 drivers/net/wireless/nxp/nxpwifi/Makefile | 39 +++++++++++++++++++++++
 6 files changed, 83 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/Kconfig
 create mode 100644 drivers/net/wireless/nxp/Makefile
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Kconfig
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Makefile

diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index c6599594dc99..4d7b81182925 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -27,6 +27,7 @@ source "drivers/net/wireless/intersil/Kconfig"
 source "drivers/net/wireless/marvell/Kconfig"
 source "drivers/net/wireless/mediatek/Kconfig"
 source "drivers/net/wireless/microchip/Kconfig"
+source "drivers/net/wireless/nxp/Kconfig"
 source "drivers/net/wireless/purelifi/Kconfig"
 source "drivers/net/wireless/ralink/Kconfig"
 source "drivers/net/wireless/realtek/Kconfig"
diff --git a/drivers/net/wireless/Makefile b/drivers/net/wireless/Makefile
index e1c4141c6004..0c6b3cc719db 100644
--- a/drivers/net/wireless/Makefile
+++ b/drivers/net/wireless/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_WLAN_VENDOR_INTERSIL) += intersil/
 obj-$(CONFIG_WLAN_VENDOR_MARVELL) += marvell/
 obj-$(CONFIG_WLAN_VENDOR_MEDIATEK) += mediatek/
 obj-$(CONFIG_WLAN_VENDOR_MICROCHIP) += microchip/
+obj-$(CONFIG_WLAN_VENDOR_NXP) += nxp/
 obj-$(CONFIG_WLAN_VENDOR_PURELIFI) += purelifi/
 obj-$(CONFIG_WLAN_VENDOR_QUANTENNA) += quantenna/
 obj-$(CONFIG_WLAN_VENDOR_RALINK) += ralink/
diff --git a/drivers/net/wireless/nxp/Kconfig b/drivers/net/wireless/nxp/Kconfig
new file mode 100644
index 000000000000..68b32d4536e5
--- /dev/null
+++ b/drivers/net/wireless/nxp/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config WLAN_VENDOR_NXP
+	bool "NXP devices"
+	default y
+	help
+	  If you have a wireless card belonging to this class, say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all the
+	  questions about these cards. If you say Y, you will be asked for
+	  your specific card in the following questions.
+
+if WLAN_VENDOR_NXP
+
+source "drivers/net/wireless/nxp/nxpwifi/Kconfig"
+
+endif # WLAN_VENDOR_NXP
diff --git a/drivers/net/wireless/nxp/Makefile b/drivers/net/wireless/nxp/Makefile
new file mode 100644
index 000000000000..27b41a0afdd2
--- /dev/null
+++ b/drivers/net/wireless/nxp/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_NXPWIFI)	+= nxpwifi/
diff --git a/drivers/net/wireless/nxp/nxpwifi/Kconfig b/drivers/net/wireless/nxp/nxpwifi/Kconfig
new file mode 100644
index 000000000000..3637068574b8
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NXPWIFI
+	tristate "NXP WiFi Driver"
+	depends on CFG80211
+	help
+	  This adds support for wireless adapters based on NXP
+	  802.11n/ac chipsets.
+
+	  If you choose to build it as a module, it will be called
+	  nxpwifi.
+
+config NXPWIFI_SDIO
+	tristate "NXP WiFi Driver for IW61x"
+	depends on NXPWIFI && MMC
+	select FW_LOADER
+	select WANT_DEV_COREDUMP
+	help
+	  This adds support for wireless adapters based on NXP
+	  IW61x interface.
+
+	  If you choose to build it as a module, it will be called
+	  nxpwifi_sdio.
diff --git a/drivers/net/wireless/nxp/nxpwifi/Makefile b/drivers/net/wireless/nxp/nxpwifi/Makefile
new file mode 100644
index 000000000000..8f581429f28d
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/Makefile
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright 2011-2020 NXP
+#
+
+
+nxpwifi-y += main.o
+nxpwifi-y += init.o
+nxpwifi-y += cfp.o
+nxpwifi-y += cmdevt.o
+nxpwifi-y += util.o
+nxpwifi-y += txrx.o
+nxpwifi-y += wmm.o
+nxpwifi-y += 11n.o
+nxpwifi-y += 11ac.o
+nxpwifi-y += 11ax.o
+nxpwifi-y += 11n_aggr.o
+nxpwifi-y += 11n_rxreorder.o
+nxpwifi-y += scan.o
+nxpwifi-y += join.o
+nxpwifi-y += sta_cfg.o
+nxpwifi-y += sta_cmd.o
+nxpwifi-y += uap_cmd.o
+nxpwifi-y += ie.o
+nxpwifi-y += sta_event.o
+nxpwifi-y += uap_event.o
+nxpwifi-y += sta_tx.o
+nxpwifi-y += sta_rx.o
+nxpwifi-y += uap_txrx.o
+nxpwifi-y += cfg80211.o
+nxpwifi-y += ethtool.o
+nxpwifi-y += 11h.o
+nxpwifi-$(CONFIG_DEBUG_FS) += debugfs.o
+obj-$(CONFIG_NXPWIFI) += nxpwifi.o
+
+nxpwifi_sdio-y += sdio.o
+obj-$(CONFIG_NXPWIFI_SDIO) += nxpwifi_sdio.o
+
+ccflags-y += -D__CHECK_ENDIAN
-- 
2.34.1


