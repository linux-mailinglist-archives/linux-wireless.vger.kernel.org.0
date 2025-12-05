Return-Path: <linux-wireless+bounces-29530-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51003CA6549
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 08:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C69830C747F
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 07:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748652FD695;
	Fri,  5 Dec 2025 06:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RrRuWXSY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A52D225413;
	Fri,  5 Dec 2025 06:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764917923; cv=fail; b=A43Gk5A24y0JxsrrTQQ1qnM56//kOua3SMsE61hKUmk8YpyzaV3qEdz5UIWo758tGCYXrzTlPd1jVo3Nio+ee5REcIs/S1o86RuXqQHdzISb9i73Atje88hAaqBvIR7MYk7rJCaq29KuX6yssVvGUBJP9HaSsdFoXrASODUltDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764917923; c=relaxed/simple;
	bh=RH6NsMzhwHSqnrBASr8KxRtncq7HAOg5JIVzUz/SqUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gStple4PWlb1hWeECgMW5/PzRdAsRxlQZKyvAM1p5hb6k1MfeY5RJZ9X+i9aBKsHECBntysuHllg8cE7FgVeC1K7KQcXy6b10wVIKVHxkUMxddOZLVf0yAzvvJ62UFSXOJ/gLS8VEmIHD4MTPu7ek5wDhcTN7oBIm4IeuwY7IQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RrRuWXSY; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6vdDIpvFcF0sz3jquBcl0CRhKr2r0Twn6Ew7ZIJwRzvGs4Sh9CHeUGsrcaa6S0jKZ4+i1InU6ZMQ9x/wKRgUx/uNsHYbAtR99kaTv+nHOIO3l214cXwh1L+cy+ZIr8qecGf3FmfveeSJKwMq915M3BrtsA4JNpzG/yQcZyg20C6H4i4IPzqFuKYmw9jY+gD2sawPq+Gl0pDXi1JYihSubTogXzn8aXBYwIMFRQM72mP34hcM+qDjAyz7CpaTmYEWCxWUKZCFUWEk166CqS0SwcvHwefUgb+NrASONKODFQGMYxPAMbNnCEmrHbASdLI2A/XoUJuRg6cNWHsGO0mLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ax2qGwhie7fQ9CnVH4Bh76UCqd+MxgwJQpqlKVSWaLs=;
 b=dghMZCgd9raModFcZK4cGgfIxJQpQ8RlGZq6OOyS7YSR1MxCiJNl6YwTguTVcpsZKNlAtmjkffRlQ8H4htnGyMe9ho0R6lhvbD5gzLN+HwtLCim+IO4SH/2vKQCUtVOgVXs4hzNZrDUdL/22C75iJ0LF8m3FYrQGmJLL3OOLIbJCEftwk7YdJZVqKg3/8I0QzKoTZwaCeIzloUf6IdWc5tvs+lbMzdyHpuIHeCwhajw6LmF0SzJ0Qcmp6PN6vpM9tiNZBkj8BLRRY/+wQQnGYOdTbBkAOG7w1wS8iWZu58a3G6HPqhYoWuJFzmS0B7hNqVGYFMqwwGJaPuomtN4YoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ax2qGwhie7fQ9CnVH4Bh76UCqd+MxgwJQpqlKVSWaLs=;
 b=RrRuWXSYZfU4xk94aIF5PYYND0Bjx/aDfVpVzNVJlWnlBaLLjX15xz59FgB7A3gePnQHwiuENqIvRk2XbSq8MGoNiUwfmb/7yAwwyt05faIRnnNwhJKamBVmzfonvvBsRq53kI3L/DTz5RafajlocG3cDttdjC3XFcfAlIBf9Z8fpmNNHQowL5fwzkXNWsD3P0r2PN1KbRJFpx/mP+gwzl14n+qlrZi4DkaoFh22/6J0kV7gTmZhPt/azOqzKa4wJHNcCgiYU0AI01qL/BlxZfZ8PiTZ7/ho5m06oKNRy7vhQvMO6w7qjf+xuQpdJNVKUo/aHYeLkfazahS4ZDbIzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by PAXPR04MB8144.eurprd04.prod.outlook.com (2603:10a6:102:1cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 06:58:09 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 06:58:09 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v8 22/22] wifi: nxpwifi: add MAINTAINERS entry for nxpwifi driver
Date: Fri,  5 Dec 2025 14:55:45 +0800
Message-Id: <20251205065545.3325032-23-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205065545.3325032-1-jeff.chen_1@nxp.com>
References: <20251205065545.3325032-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::14) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|PAXPR04MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c8bb3b2-7a2a-47bf-9ceb-08de33cba5a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|366016|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4DhbtII+JDTde7CgxfIeM7fKkuQC9zHFeBdJNkKVK+xBfBTrLXvhO3vjsG4g?=
 =?us-ascii?Q?J+M73Zk9ze5FGUmhUGF5M9CGUzqih8Gdlsu/UIZ8Yq+sEhKJ8Emyg87AZa6j?=
 =?us-ascii?Q?xs7MerH8xtH89Yi46aDa8JBumkFG0Z1oB+HoSgKmOrtgvstxsBNlV4EMqgi4?=
 =?us-ascii?Q?s4S5pkTrRaaXnfspwzSf6mwkFRE4k3YlA7Wly0U2dqYnTqxuTGHaaelvhetV?=
 =?us-ascii?Q?/ydWRRIQwwcFzZc7S0HTEXIvErc8dr09aXLA07LSebfFQF90HQfKU4/GAurS?=
 =?us-ascii?Q?/o4a84MDtFdHqTYImpKP6SjxqBIK+MXlHxpiv1HAQ1XACwqRIeMhn9w3OiLS?=
 =?us-ascii?Q?YBWT7Yw/9S0xCTWbrlHfzBtejfbI/XGuQdiCTbJIch7Jy4wL82rRkbqOgPvE?=
 =?us-ascii?Q?g34OoKoQNmb4TGeIsnSPnSHMRDYY5fhMFV1S0grJBH9YuD5AHc498r7+8jYo?=
 =?us-ascii?Q?/0CmnQ0RUeFF2n0D/KWjLtkACcwJbvVTBbX1/uyffE3HrjoBBKZup+Jk2PaO?=
 =?us-ascii?Q?uC5NZKivh50AR5MenZHB2dWc3+mWpcAnJlRStgV2/MQJ7g6cu+V/0ldzQTIw?=
 =?us-ascii?Q?c0DD4kvF4U4oCJCd/ZuqVMczosBzkBlLJav7qVGY/23ZlPK/csSRPWcsBVRp?=
 =?us-ascii?Q?axpvhtSw/7XZxkH8GMvLAILxRL/8VohX5qkgNNlCI9k8G0rgyCRM0A5Qbo1x?=
 =?us-ascii?Q?BGuo32NsQaSSAs4r8BI4c2WPTTJUyKe0mk2yjyAkvPiJk9JklwyqCJB1r8dF?=
 =?us-ascii?Q?6B8KmuL4Q1nyHiE3rfUQpo/d76yPAmA6QbbsP43jxLgHVUqlUQsRtXrefXJs?=
 =?us-ascii?Q?Vd31g+Y+fphtNZ176nYLH3ramWnpFKmDTqdLkaa3iQXvLoNe6FYSfCqkQh3l?=
 =?us-ascii?Q?+Xs2EPY4LpLerQ1Gv+XcuBwcc+8M0Ca/pG8NOBMgW5lJ4SXpSAmNRExEWphY?=
 =?us-ascii?Q?1DPLWh26IC4kYAw9JkJNtOVc50h0vQUaQFidDPjOKasVAXDdykhhLBYIU+Zh?=
 =?us-ascii?Q?iw2emfsD8flW7Sf6mloOubk8Rc/AH1w0MECu6BLusE1zqAIFDhwq88wUubmu?=
 =?us-ascii?Q?UzP5DYpp000wHnjA4W0XqnaN5H++yy5rj6GF4QQ/6JOiFctULEpMv1WnHxa0?=
 =?us-ascii?Q?M/FUSuzXmjo9pRgzz6gMNCuMrU6Zzm/nAh9H50Eviu6EzqdvNuzWkyT9wh0R?=
 =?us-ascii?Q?uABjVJjfnd0LiN8q+vJUyW6BjKp2u4k/3LpVWoRp/bqE1xZol8zt6LkZmfwM?=
 =?us-ascii?Q?zLT3GPjjL60fN+WQbtaUX5O1bpxKujwR4kYUR2CUqPfBGp9xZHdql7r2UhGO?=
 =?us-ascii?Q?VIj0yVWi0pkCikTeYbTkLU/RS64tCAWfCk5nR+GDItFD3PLX9C3gF2JbEfp0?=
 =?us-ascii?Q?YEbw/whsW3EMtTK+nwABkgiHfTxIEZU28iUe+7hv1l4WQ4UrWKpbdKiQey2D?=
 =?us-ascii?Q?UmyOsYoYlV6qcAbNFIHv3iTPdM+9VHZy6XIu5oquqLR0y7uvW71S+RK/d/ZI?=
 =?us-ascii?Q?ONpJw1f16iebRUL4T2iynY6H5dt/ylNy9lfz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(366016)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x9n6PBKVwX+rPYCVjEG8tLVHcPz4FTNh5nIDyDK8ML/BPTL7544OOADP5P0G?=
 =?us-ascii?Q?4JmS4fzuSA9eESRM5FXvEbCmNoDdT7UzSvNtmsMbgoLexShRHMl7s4GOEIXo?=
 =?us-ascii?Q?TIbWVAuBIVxl8j4FTTRNrnJYiZr9qMCkB0MkS8bj0n3Bdq/G0Tq0Tu7LmDvk?=
 =?us-ascii?Q?s6ufw3XiAHty0gEMjZe1z7Rs/185UYi6l+ilgZsYTKrwl7Ez2XbPCMRcX/gS?=
 =?us-ascii?Q?d2L4gEpDSIRewG1DVk9pRybxZKchNqHVdGtOmgAKw2EcfyeVOlWYRvBwtXN7?=
 =?us-ascii?Q?U/ee1AjjKXYqcPKbCtb6zJ+EaistAE4qmWlmFyFwF4tvWlN1EdbtL7m/wVRP?=
 =?us-ascii?Q?H1Mju0MWqYj9Xd/mY/JHJtNeSy68fUzG/E1yQRTZJ5tRjn03nt+fGZhMxHtz?=
 =?us-ascii?Q?cSgyE682ERTRK8Qe2BYmL94We7xoFI5NKCWYy6uv2HwCLxeNPashJBI5OFtl?=
 =?us-ascii?Q?lh/r+A8J4BUjsbRG7BwHA5O1zNs/7pV6hPOWS2oaYbFudZAD69Ajpb2D1RVE?=
 =?us-ascii?Q?EoYk8W4r5MO94QDlYKKF7sC7YktOmx6Gou44sc5v/NIGj3HKiuUVN2uc0xTs?=
 =?us-ascii?Q?qjkpCl1xYzFGNeguJPuj82PI8arSJJInaPA5IZiZozeTC2Poz3BhpKOLtUeQ?=
 =?us-ascii?Q?fYUK9f9XhFUSjSjWxewuKDFM9tbwQHuSGOWEoM3JaKg3af1+RrexnkzwOjSn?=
 =?us-ascii?Q?gMNOuzoD5N193HtlHk9vNh+m7RbFbPjpSdS+xJNd6vA8PgQ+r29zNNxAvQ5C?=
 =?us-ascii?Q?XbN6N+uw5CKJ2cEQ9mHmYChVexbbI9Bk9W5+2Vy7rWIcaNK++q5qqCi/E3aC?=
 =?us-ascii?Q?Rt83BO9MG2C5vxTQWQsyM7EhRy1McMBU6kwi+04o/6ualkGx6N1ALnU5Z/WO?=
 =?us-ascii?Q?GOZSakzbONY0FzcN9YikdTFTRWkR1Zw94RtK4IBZef8n4ev1GcxJ1cc/igBh?=
 =?us-ascii?Q?Kzb4RNfRcB0kO44Eoyd6y0jnizBz3c5mgzAPR4f8fGI2gjLSz0FpJ8PUIPkU?=
 =?us-ascii?Q?VuAJv7Cq1grz1dVG7YUgHeavUXKadMQxe2TcHsIWNqyjdQHKW/zrCAcF3Ps2?=
 =?us-ascii?Q?/AcnHMYGn9mBPoqBWekrZgH4aObVTR+vCks8Cdvqxcxo2WT20RwD5Hv59Gla?=
 =?us-ascii?Q?G3uDMEIgByWBgmPyCYwBeJLqfCPPKlKzFA7h89YsWj1rlTG4fFVdoAk+bxv/?=
 =?us-ascii?Q?eZXirxnxpovHjCspF9QAlIKHU2kyISiL5sudrevxNGMZ4LRyfwjKkzctNf3U?=
 =?us-ascii?Q?8Xr3VtICd9P1yPsblbVjoZniZVExwe/3/L43S2pS7WwMSvymm0icj8zXeaOQ?=
 =?us-ascii?Q?lSdXqVelnjcgOXXLNjZkhq0s6iDk3aSFnP5wS7SXjjmhe8DosQ4yYOSodvtx?=
 =?us-ascii?Q?/gUOAXVQIE6M/V4sCtUBsYrT4q3XPYFs9SlMOpR2yN4x/c0bfnl8Li2DcunH?=
 =?us-ascii?Q?L8pmi6gCK+KxcuW/ZLmIbORFD5NHVw5lgj1qQPvS7w8KAlfTaTNQEGt2ZsfC?=
 =?us-ascii?Q?W/2Q5jzemZtTqdqgD3NT4bjkYcFgWdjyubOWDZAQMz0EV4I3PXixM+sxWou0?=
 =?us-ascii?Q?lTzpZ/WfLeaUIOyg3t7nuF9NEbLJxRwnAfW3SzTv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8bb3b2-7a2a-47bf-9ceb-08de33cba5a4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 06:58:09.0131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAf0J6Yi4y2Qb28REKottCsIZCS0dGbw8kw8DL3RSUKD8iknRz93A4h4opGgJagaiEsOp6OPUqFFpLjxxReedA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8144

Add a new section to the MAINTAINERS file for the nxpwifi driver,
including primary maintainer, reviewers, mailing list, and file path
patterns. This ensures proper tracking, patch routing, and community
visibility for the NXP Wi-Fi SDIO driver.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 37f4278db851..5aeceb153dd0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18654,6 +18654,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/regulator/nxp,pf5300.yaml
 F:	drivers/regulator/pf530x-regulator.c
 
+NXP NXPWIFI WIRELESS DRIVER
+M:	Jeff Chen <jeff.chen_1@nxp.com>
+R:	Francesco Dolcini <francesco@dolcini.it>
+R:	Pete Hsieh <tsung-hsien.hsieh@nxp.com>
+L:	linux-wireless@vger.kernel.org
+S:	Maintained
+F:	drivers/net/wireless/nxp/nxpwifi
+
 NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
-- 
2.34.1


