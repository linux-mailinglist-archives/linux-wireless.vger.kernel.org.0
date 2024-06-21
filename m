Return-Path: <linux-wireless+bounces-9406-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE8C911DC4
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695AA1F214A6
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3739B17C9F7;
	Fri, 21 Jun 2024 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I3Xjr5zp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0272217C7CB;
	Fri, 21 Jun 2024 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956497; cv=fail; b=stYZyzb1tPhDLzi3sfWcr/W3nAhrL2WdRB8SFhtZo2/SCA9hHkVTsDLj33mIzW2eff99CexInk4dv3t905rz1hBYBOK004Qa766e/1auKSz+F16j8jLy/gX8LndEQCs5vAuYTPptCqDByQ4EfGmOx9T+gMOtQMcvhcdbBxLJAaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956497; c=relaxed/simple;
	bh=OWLLOg9zNviDBy1PpaLIuGUJXKqg+tFm6JSElyxo7sA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sm8jYKDF3wZBKFlBr8Hesl1oHqDRk4jjrmRW0o8OxMI2WTQj1ODXj2Q/Tdq43sSJkV3j8wShbUHPjXXy+RC0FhNNQSZWdVY9L5W/RyzUHlXFqgDamCwgaAlVdgHgDK3b7Nqx9RYcYKHj7zJwuFRxYUvjev9QD10KjRNaLc70640=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=I3Xjr5zp; arc=fail smtp.client-ip=40.107.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gq8Bas/ZE8nxGTdxWNotva0Rfck3EjLaLFvZzv3vRgDaHyvSlEfUbir6u99jZZB93M/Vv5KvbKbgYLoHdAtv6SFPPeJQ9VwKdv8nhuKUmV2ld+Fd0ZactJUyp+r2Sqyifsb/DiYZTGTU0NXqOAobGGxZvodiZ85gB2JwcXJs3PGrS++h9l8afGPF2pc47BHv2i70Lh/EmV6CEuZ0enXESWXWms+rOPv7VAjqS3H/xHbZR4+F7/JeCRsDVlJoiYnz9x/+7jD0m13jHZBpBTl3E3hrJNAhLdEZfrpudAKzHyz/XFKv/10VJJ7pAv5IRFrtminpoo902MobBXQ7OUGbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuuA7mCk2j/GPV0d3IBmmbNL0aQrroJhtLXnB92XVno=;
 b=ZMz2PCQLo9QNusTaWeJ1FnREAhg+a64jmuaoWEllT7QWvG6c8hl+Oy0Euo73zoiPiaWlr4fCDQjpjFIjuRcAyzf4lQ+xYYDiTukbme6bYsP4yKfKabPq9aEfGWD5XxXFZpx/XhjQcZdk7C2ldRqKqmkr0HuAwx72XueD9muWCVoC7U961paCQuf/yJX3eWxh0BysExk+9Y5SUm7VvCcdpwPQdIqpz98ZCcWSvU/hkUE8zMwAKayGp86AyF5I7ZfvwycE8iTBtX4qp64m+a5+Y90/1bohcIQIh9y7DliplzcmVvQH8gGKOA0vxV0bCveAq9bPoe1239yBIspFfGoDlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuuA7mCk2j/GPV0d3IBmmbNL0aQrroJhtLXnB92XVno=;
 b=I3Xjr5zpA2oI6f6SqC8atU9ppP4oPQ2r6uylDGVfXdsz2oJSk3YXqfp4C46gTYQKoqPZGdspt/Fty3Xe3rmKVMDtBJxhC6H50qTtl7dvNjowZd/mDkJqQWtxRI/grcDEhJLum2DlmJiBSPrq7pH0kroY/4rhEDD/SO+k4xiWr6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI0PR04MB10464.eurprd04.prod.outlook.com (2603:10a6:800:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:54:52 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:54:52 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 42/43] wifi: nxpwifi: add Makefile and Kconfig files for nxpwifi compilation
Date: Fri, 21 Jun 2024 15:52:07 +0800
Message-Id: <20240621075208.513497-43-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4c60d90d-022c-4074-cd82-08dc91c76e5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|366013|376011|52116011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M7QPBl9ThJ3D1H+8Ru3OFFkPTBhJRLgcOaOP8VC7etVyPIZ1f/tL9lmUvO8m?=
 =?us-ascii?Q?gyWXO8QX4cmZNzvMn7NdeMBdC3ZMlqgWBrcx/BzcLHl5wglWBMQaDmMbyFo+?=
 =?us-ascii?Q?HEkeIJP7NmaiOI8TWMyeDypdMquHj0+gdLIhcd/r0eTUGC9iCUG0Mwm8C7Ed?=
 =?us-ascii?Q?BG3zoq+HQWTqnRM3GP/pLZ0MT29qiN7j4umlxfwJDQgFanEs4jEEH7xYM47N?=
 =?us-ascii?Q?PfiknrRE6SfQckT3ZDO8y9YDvr0Y8Y636Jl6kEcVpKEBq/OeJ6gr+1IR/1qE?=
 =?us-ascii?Q?WkQm40Ko80oIVMYOIZUvKyphJZ59+bbVQhUggKyD5UjHLlXnSf3KSQOXHjZZ?=
 =?us-ascii?Q?SM+wPdXhl2Ikba0IBMhVagtekajVOttVRV09lz25/hJoKcK+WQlWZGEw8HJt?=
 =?us-ascii?Q?ql9pXQoGE31Gx1USm0IVFH0pUJTb6mlw0hf1Z4l9eGMYLjA6pH0njpKaj+H7?=
 =?us-ascii?Q?Mbou4CEaandPWCeIR4F5nWGfm3MeA7gLzqPwAIDsh5FRzKhRdwDVsCFL1kow?=
 =?us-ascii?Q?tr4R31P741fl/91El3sauYgXJrqM5FTCClllX6Ul36pte1pj4tmSg1qYPqfw?=
 =?us-ascii?Q?4FczWIiGawRdfGMsIRKfDX0yqWxvrzJrTPp9KcMbhI8l3hyTnhddstw1WBM3?=
 =?us-ascii?Q?ACreQ8cR9PMlPTldLdQnk6ON6a/6QAA/SUaXDUBFRHdBEpR7PH2JXIPxzJXx?=
 =?us-ascii?Q?JQtPT4ZO0NKL1Q03uxCZ/90MZg4NCNbmavF7V20ff04+qBzDAfXLcEXIEvb8?=
 =?us-ascii?Q?/1aolvroxMSZzYF/h6RY+xOJWthBIuBgPlyEoMWvxFfR5rwu0B9EWFhqImD6?=
 =?us-ascii?Q?Ii6IjKO2uBiLCxM54ehGPVOd+y59byoDAmykG+J3SFntOK+vIU3PxT735LOV?=
 =?us-ascii?Q?dPLy6oGoHA/MardkzpKo3OvKG8QRHYvNUxxt10PwBoDeg0FAHdlZG61RFVtt?=
 =?us-ascii?Q?NM/1HZuH7ixm5X0CE4QTZjQyt7hKIgFp+HeaV3L+rva/YQ5FDqGva+od9udo?=
 =?us-ascii?Q?0PgpkOR+7ttN8g8qwiZlgocfWoueVHOisPpb8iuW1E65S1lOWuYtej+Ap+FP?=
 =?us-ascii?Q?Cr18CFWOuKahxe4NZkVlBwK6kzGLSfaLrL+oY8llJEEqXwRGMSJUq5MhtScB?=
 =?us-ascii?Q?ZiFLj3b3fXtXaWfCxqcQDTaMjW9MMze8OEToBeA5FiQkQEKgo/6MH1iDF8R+?=
 =?us-ascii?Q?IjBKxH3Bn6o8Zp/FOTpSg+XOUwXxQm8q9cZbLxBGG9VK5FPpJ7EwUKk/gEq/?=
 =?us-ascii?Q?2d7bkvxG59P6lANCPHaqMI8HnzllO05oKSMa3w+q51V/+GSK/+3tlJUnSou8?=
 =?us-ascii?Q?q3VA40tWENDEZOtxNgNboAHza8YoxOaSM9bWE92Znab2JdZUqAjPQa4LEkZR?=
 =?us-ascii?Q?IKRITIU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(52116011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0pU4LyDblX+uZ66zuMv/6GRV1Oo+04PCdTV4R9gQEqrSj06Caf4p0u3w8qaE?=
 =?us-ascii?Q?HdFF+r40CTTADj67FrBfyUHsoFJyr+BrtbqWIQw4h5tWUwF5czSYcoeKRtKw?=
 =?us-ascii?Q?t3or/GTxDIvrjyrYs7Qp3HOQAeP2qUWRHscHKaraVkbXDBpSXBGZheZBDB2C?=
 =?us-ascii?Q?VgUPMgHdFdKHApYtNub3jjvLZOFreA2XwYHTpdmaOTIscwxZQsDIVPH46uOF?=
 =?us-ascii?Q?PHLy3UzWDcjpjHy4Lja0c2kGgrEBt00O5tTEFmIQEY9KzkQcbewzSGDQ0sKh?=
 =?us-ascii?Q?UbxfK6qS/PTbARVCBUQ+kYGjRVM4ct7DWw15KYLrZoktI9yzgIbZJDF7DD8+?=
 =?us-ascii?Q?3CVTyifuL8sDM1VgljXP5IOUknucg+B1Tawg1aANF12F8jY1oUjhhOpKf9pY?=
 =?us-ascii?Q?P4K2ib++bDcFxxGhBaF1NQEpXt4PPJqJKZkfV9HOdJwTw5aoQ416B9ICX/hC?=
 =?us-ascii?Q?/jP8Eds/ESYYmq8Di+S5DpjOOZRv1rLChnwrkVzulXNWNI4OzPisYINytVyg?=
 =?us-ascii?Q?N4JeTwLVOaGSYooSDZ7dwth+mnDAJAB7WKOx/9vlEPHZZsBMtWfd8kr0JMv8?=
 =?us-ascii?Q?8CzH2SWQUehWO9O/vFZCqR7pxT0+v/0N4pE6W1PGGbdvFwbVm2LWOgM61aMb?=
 =?us-ascii?Q?zkO9YW6uMwWTIxtHbRCGVUzhDHDq36xlqCdBpOXlS7ZCzdN0ET6xcvyT9cYK?=
 =?us-ascii?Q?ivhkpz+Ht5VSe0HydDUi7B/ZGeP+Jg0DEd/3510OZUX61FOMmtTC6tmRYGps?=
 =?us-ascii?Q?WQhMT8tVRQrvOmDExPWm2bdQCFCKcaMIjwyFkJSNnnvfVN5vyiw39EHzLNe1?=
 =?us-ascii?Q?eRL21FCJVaNk/rYWZOssswZVDwBwGZtlN7MOzkSUYi6fMbczvZrYslXsiH5T?=
 =?us-ascii?Q?29frKkYF+TVoXzXuvDD+k0ftzo9cDENnTzE3ZRw19pWSaIcI0feKQHQ1E1Af?=
 =?us-ascii?Q?e8nKpBxMq+XOpUdT5R5ePUuyYYyXgiQNCav+6QkVaFSE7Iz6+YSbf19vs3TF?=
 =?us-ascii?Q?RjMkUQl6TzZTN2eO6Cm7NIbrYFdxoxE4Plq5DBR1Xpj74kT83afsoP+563hZ?=
 =?us-ascii?Q?DjJ/xUIhwQwd+U1E9uBdvZwoLqekh4s4+/UR+CXyc2Dqh8yXqYZGokjr0slC?=
 =?us-ascii?Q?K7+OtEdc3Ddx9IFQYsPQtZsr8JR+zpIidlG+FPhHMuEFkLOV8eEYzfWzKDfv?=
 =?us-ascii?Q?r7/CQ84Ogk+95t2+DvZ5z7Jsy8U2qyQ2Ppm+umQGIHtowaTQb/xVr70hlzEf?=
 =?us-ascii?Q?UH69KjZExQXbt4vxuFb08ilDf4caxA8lg8cqKs6BoY8z3kYmDPmp40c74tiz?=
 =?us-ascii?Q?4nCIRr08W3vzIgqK5VxGVVK5pE+kXtIeqK0SUzvQ3iASR8Wol36iSX816HEK?=
 =?us-ascii?Q?QoPPsL6fo4z7kcsOjf0CZrNMmKESw88kvEaocK6row8I33A/CGBr96o6WKNG?=
 =?us-ascii?Q?DZ9qEu3ttJA/aqCFfYYfkOGPwZ+deFxkSLKwyXYKA6lOsi6sCHsN55BmfwGF?=
 =?us-ascii?Q?Gq0yaV81gBziFEAlhRDoLz4ZiT0oXAZJOCpWJ0Ci4H0dX9Soo/1suU7rN1rr?=
 =?us-ascii?Q?YGeytvR2ljoqTiVrdmMB/xhnejI/K3n7ykhzsBB8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c60d90d-022c-4074-cd82-08dc91c76e5f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:54:51.9330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HY8MAbM9Yvcubvk6yShLbfgHdrvi8U6lka6Q1QQ19c1iK5EsrYCNR+Im6N/7/0EzJ1Qdxgg2WOIItY3Ntvj9dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10464

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/Kconfig              |  1 +
 drivers/net/wireless/Makefile             |  1 +
 drivers/net/wireless/nxp/Kconfig          | 17 ++++++++++
 drivers/net/wireless/nxp/Makefile         |  3 ++
 drivers/net/wireless/nxp/nxpwifi/Kconfig  | 22 +++++++++++++
 drivers/net/wireless/nxp/nxpwifi/Makefile | 38 +++++++++++++++++++++++
 6 files changed, 82 insertions(+)
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
index 000000000000..a9e5a528324b
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/Makefile
@@ -0,0 +1,38 @@
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
+nxpwifi-y += 11n_aggr.o
+nxpwifi-y += 11n_rxreorder.o
+nxpwifi-y += scan.o
+nxpwifi-y += join.o
+nxpwifi-y += sta_ioctl.o
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


