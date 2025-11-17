Return-Path: <linux-wireless+bounces-29043-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C46C63B84
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 12:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 207A9289EA
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 11:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B22F3314B5;
	Mon, 17 Nov 2025 11:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cVsDMOKQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B48330B2A;
	Mon, 17 Nov 2025 11:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377380; cv=fail; b=ncl1lTMy9buqbjLSsY3wqBL1PovmcnCmOndq9s4zx3A+21ISVl2trc7dV+iT6R9+K3CoElNMCQgQW2o7QXOskK5ZTKpCA5zJvPOSSvqMRb8Z9c/7Oqikx13y8mWwDfmBeg/Un7aCPLDJjQd+RymHhImh/ErZrHCmTSfCkEt/QqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377380; c=relaxed/simple;
	bh=ieQHswewcI9vmb8elMjvb9rtcS2vWi2v9KGUQ1S1aXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jRCvB1ApktU5rrqD5wxpOwc3w0u12pihGzEGa92bzIXGYc47F2UdkM2FiIHjija1C6Mkofjo9pGuqo1h4kVoDXBEzmi95HBFx2o7rSBzWJ9tiwhv9/hj+tgZBsfOJx+huTt6UD65rajfnEA2+6ckg9DL5nfeku0CLYtARtPcECM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cVsDMOKQ; arc=fail smtp.client-ip=52.101.83.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhbPSt+oaJ8uurzIifRxE9Zq+0EbYwSbxZweJ/e5LambMKUYWsrYXf7xwzSw2fFgsSfFrIOVvOoi540hjGSWjNKCXfw/Tg6z1z0V7mpMpCfXF7Cd2IgED+snaHEHPNuI5RZpkOY9j+sNa2C7+JgtLjvv/AdfZi2dmAxAdfmC31BRgK7LZmDdYowVeZ5m/FdxVXGwrgfKja1OZpC8Wf6JIcbkw1AoMJeh2ditm2i0mEAW/gb4sZuaHOeYUTXsNbm2mvyqeuKonr7EU7UeYgcNh0pzU7EQGF1eAnWtWT2bwEdyqpAIvplpTMgKpgQAcrfoSaW+RCV2EMG7c4WE3fFbow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQ5ZVipCRed0m6CzPGXErZtlBMAEKkk1mh55NVngcoQ=;
 b=c57/SRfzsc3/0St3oKtsKE8CAOZy6XRPzsxd+JB6ugw5dbuxuG8yB9HX260cCSZizLuTCcrHnP+OOZQXtTxgOqJ2hd83Ko/R1eR5Qyo713I/Tf8swAoc6lO8bBKcabhv7y2fqEN/MT8VHRRWioAiErtYjrSyRnM2Xy+DHUFtFpyMQRFN9JuUKJ4nh1/GcDB8i5V4e1OS/Lsk3jG/EfphuKmm3iz1AoPgBoKUn+JIIO0XVKg+GgiwxMAbL57JhRVUg4m8hSmuz/esCflsIEMbPRxafobNjb0o0eoOxMCX//4/MO/MOhkpJJWWzdPmR4KxcrU1Uvf6pRRBxsOWNwlFPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQ5ZVipCRed0m6CzPGXErZtlBMAEKkk1mh55NVngcoQ=;
 b=cVsDMOKQGeqnSXrLPu7U+ZoaHtGaKMDjTL0ZX4N3G1TYU8/zEZ5g1h62xzzSAdoBWBXl5hRi7/iYfh+r3RNZJJFPHk5MtdAlgtBFTove49oW9k4PBy8WycDtTcQ/q49sdRrCUPBEZvLdvFLQcXZCEvxpRxOFN1ivX+kcgd0CXXWjVXAdo33SpJ0IdGOdx2Z4wgbREH8k6G3NF8vmLQ9EYvyRom6jEhREf70tWKrUg8hte0dopPU0MhSvV2LfcBI5yRj0PrXhu5xdgi6/N5WlQHWjtcyjY7WxnaqRYBRez4IiOPUinEIdHkfPG0Nexbv2Ht7eNF28eJ5eQ/QwhItExQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by GV4PR04MB11852.eurprd04.prod.outlook.com (2603:10a6:150:2dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 11:02:54 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 11:02:54 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v7 20/22] wifi: nxpwifi: add NXP vendor and IW61x device IDs to sdio_ids.h
Date: Mon, 17 Nov 2025 19:00:44 +0800
Message-Id: <20251117110046.2810811-21-jeff.chen_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3b77b77c-c394-47df-aeeb-08de25c8db95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TAqBKE9fJVQQC43ixoeWmzdjbMEOohlxG83wnZGN/HMeZR69Ehwxxrcff9vs?=
 =?us-ascii?Q?GFsSWWxBTlNSEYME5stSHrZBxFFBoi0jwJdWkp9sPlQDwHRF0vfj1FXvjhes?=
 =?us-ascii?Q?5OxLfj6UgpKgMg6bDxQT4ftgOuu2yHoD+XMXhP9w7EenzsQexHnwc6+eSQNm?=
 =?us-ascii?Q?bGtQSLxIgsQFInbfET6L8OVwcQQeOwOCSgA5C0nYvw988+xcMcd4cjkp6npT?=
 =?us-ascii?Q?xMrQXW3cUWakrBQrkAHcgvuJ/xIxJUYmsyvKJYWT/5ruwFfZAxWbCjDv8yrR?=
 =?us-ascii?Q?LfCX50zwOC1DbmBqSMbuTvNvRQOw3RdCr91IMG8FW3NTZ6oESaf55LEp0rzc?=
 =?us-ascii?Q?LZtGCHWf1Yj+aNEx+HGFzpkCv6CAzWUDvpixaK6HUFM2OnF32k+f5n+I5J8K?=
 =?us-ascii?Q?EjgI/xX/uSF+qpZm3jiUM5n1k6d4Z0ddwNgz8yQIA+aDR5U68NwbS5JIOh6I?=
 =?us-ascii?Q?08P+NFNusgWzxEbRQMGJmOFKqbuGqJHWn35PR4uc3FkcvJNUOusoL4WZ/ceN?=
 =?us-ascii?Q?614VxNPnEcuijd7XBPrn0Iy5XnleiB7tB6oZ3odyARlfVuWtW4WSQ+iF2M0i?=
 =?us-ascii?Q?GTGizrFQsMv6UrSS2BuXe8617anZRROBZFgPTPJys+KCijo+LK56RfmI1gVx?=
 =?us-ascii?Q?530GyVc7t49/iETQ7xjpmzZrPYJWUAR4PaF3IbbC96OCscPVTZp577wTVg+G?=
 =?us-ascii?Q?YA6B4JCQXQEZcmcX4CAr1ewrV6MsuZE5up0MeYHIKBZj6gCqIMgo5PcaTogW?=
 =?us-ascii?Q?KzAm07Y8C6phQ7/8tvdgfr2pqsShnE2qtAvR0NTI4ho1R750Wb92lGjEGYKc?=
 =?us-ascii?Q?+NexVlSqoHRKmxuN2SN32uInNiE2nPXEoZFUhi9gXKFstbBYhXgRwEHNqB0O?=
 =?us-ascii?Q?VZsp0rq+jysMdodBbtbDnFY2zZIyHiNQC14pBqtaDxyWN7GSkoyLwS2+2+OY?=
 =?us-ascii?Q?n89/QegnAiMsObI7y2VzeAQ3Sg3fuxgmoSi12iDQaHHr5eIeoHgwhFXZxEq8?=
 =?us-ascii?Q?1k6B/laLWRRku35yZ8QjQLmE4mfud7bTKoa6DUm7+yzMb/U0SYFS3cG7hrDb?=
 =?us-ascii?Q?esIQVr194z0vEsLUYHQAaP9WoolwioH2Ca6WwIhWv0NivmsyJvUUJWV203vm?=
 =?us-ascii?Q?8y4TcTdy3qrddVG2iDtRFOoZe4zHD09/6Ra+Fbhp4HjRE1mMtyToY6cLhdgy?=
 =?us-ascii?Q?IrPEEHV4nsiQVr4fwk2VRgTEtmHB2kRpX0nQs6reBeUtWAsh3xRAb47ZYQ/E?=
 =?us-ascii?Q?i67ZIT8EyShOgsMeMw5hSju7r/mq9fxlTv8tTLsfdCLhK9GoLY6a8XO7Iu34?=
 =?us-ascii?Q?1xJ52kr7qQIMEXPukHHa29YY0QJqeKOXW82C7ffk+nGwCKHGnLCnChrA1DIB?=
 =?us-ascii?Q?acmlt6rwXGd8UuQJYfmrGfIfW1q1BJwgrmuAMnw9a+VZSKL7V/rUrCGjCU8b?=
 =?us-ascii?Q?fEU5OHJa/n1/ouPlx83h+xctEjxeYx8U/uh8ydvAlOD/T/iY0W5wpJI3u506?=
 =?us-ascii?Q?qhQEVnDPjp5eUs1sqU0wANk8JFanLJXi3Sj8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+cHmbkRI3+3Hn9KmifVTeDRSTs8ClbqYJzs2/HFeugnqcHQqvF/d/396B4C1?=
 =?us-ascii?Q?cYVH+AEW+4tHyqJPX1UGe+e8uDyd1hgnIPjIZ3s3LacDJ7NbkbOC5PcI38IV?=
 =?us-ascii?Q?4Um3GqSQB6ANrhPTM6abkAKJjHqQlb76TFCCQ1923Y04idgrJ6lXFQf/Tbuk?=
 =?us-ascii?Q?LtPaTNGsDG1VzQcZY3zBzylJ8wBMG7MtvkM8no7kHBTufaFUEbEQONjamq+m?=
 =?us-ascii?Q?bJKCgwmPNOgILOkk2KTxsQHPzxSsj/RgNLUxNPNInrltY2QXX09hNwqtMh1c?=
 =?us-ascii?Q?aAzUaJTYgdEKpGLm+tpYgwsLw1buzT8o4C97xyZIKmvZ/OvN8YDdM/i6rubd?=
 =?us-ascii?Q?ej0mj8Wqr7T4bUz730EyAtS5/Cyrz0m6tCpdGGJI9wsWwQBmLhILospVyUTb?=
 =?us-ascii?Q?d07PIoGlNVQC6Mih4nAW4USbFNHcZGx05JHqwVKQkSdO5i9s5p11dXpmd3jK?=
 =?us-ascii?Q?Lw6EH4sZXuszWFEqIaO/SmmWrlsxqpS5Cyp4YAGc/HwKVyxMcTOv+LjVeR12?=
 =?us-ascii?Q?BjqJ4vdbmDK/71uWR8H+EBSskV+QfQ2Gxj5ruLqlOKUryZhUqg1qee7PtmQ5?=
 =?us-ascii?Q?mxQOc+xW6z2oap4wavsg/uqGtm2lvfE4xSkntDyLoM+OBgmwANZ5vvST47P1?=
 =?us-ascii?Q?1ssqfJheKeiBhpeFwGwGVVW94bHkUv4uhL7T+IqWY1RnMUSQAZL36yav/dZI?=
 =?us-ascii?Q?178sluLlKVdTQmS+qD7j8w0nSdQdjAOvXKceEP8SInGPqB0X6/aNtZ3fua5X?=
 =?us-ascii?Q?pYTh7ik9rCrGVndjJ3ia212hC0fq47k9Yh/HRFg4x5cKBh+/RO/GxUGJmH2d?=
 =?us-ascii?Q?tGK3IfNPXAAKeBN+RRSY+VUSta4/P2CejMfoiwi5gT84GJ7OnlEJY0hwBqm0?=
 =?us-ascii?Q?ltgES1Vc+mMuRocRs1HexmfvTnODMQmeP1F9ixKr5hJy1+GYR3q9DUuTr4AS?=
 =?us-ascii?Q?i+dAqzBcx+YVLA3o7KO/KedKOALnYHdYwDVvT3W1BhQlPw44GB8T/EgIirWq?=
 =?us-ascii?Q?CNeUlUWEYV536BUYxrBv9UwjOjHtci+La78XNr75Nxc5j3+CVPQNPxRqvSBS?=
 =?us-ascii?Q?ROzvQwobVuoQzxH7r1ap5Il9ibof/oik6+KZ47vrHqbkDJBoSsQoExAdrW51?=
 =?us-ascii?Q?m9s4jPaobWyGGEJ7X3lC7Q9N+v/6kH1ICAnVgFmsO0CiKyswRX63qGmfG0qb?=
 =?us-ascii?Q?pZfYE3WweQv6nLFM7HJY2Tkks+eZpszbzQ2+A/j8HkIvpGxFl/MLqtbDz9sD?=
 =?us-ascii?Q?n1Sso2QN1inmm+RqTQArEMz8rGeIIZ+puENZD1TCkg6+ZFfVvzoadTXjIX6l?=
 =?us-ascii?Q?Ps8yIaA5V7CQyeOcrgfHzgS0e2cIDGbibHsdDqERvFtlTwAkYDb4JakfasVU?=
 =?us-ascii?Q?o4Buh8PTdq23Ma7wTfSNiihBQgmZeJS83xc2AUxFUXoqnakThytQ3YybyOif?=
 =?us-ascii?Q?rh6G5dQBofjBgG2riJUObeqXNY3zeKpuqU/QrqIMSOxpRyc1DLYYbmFFBuct?=
 =?us-ascii?Q?aGr/GRvb7NXVdaDmEGF8a9SfsIdwno6UVSaBdrvufq7TkwUAGxtq/KMiPAGJ?=
 =?us-ascii?Q?0/umxXmTIKeGYHDamRuxGYVXdg1/ylpvDMI/Vddc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b77b77c-c394-47df-aeeb-08de25c8db95
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:02:54.4266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psJ+JYM8jvEB0khxGPjMi3dzGrvJlBSW3Rr46AeEI0jRMGz3yLXl8hcUo1AfQ3REcPBCUxLf2A8dGIp/Whzh7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11852

Register NXP's SDIO vendor ID (0x0471) and IW61x device ID (0x0205)
in the global SDIO ID list. This allows the nxpwifi SDIO driver to
match and bind to supported NXP Wi-Fi chips via the SDIO bus.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 include/linux/mmc/sdio_ids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 673cbdf43453..39ac2b612e4a 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -116,6 +116,9 @@
 #define SDIO_VENDOR_ID_MICROCHIP_WILC		0x0296
 #define SDIO_DEVICE_ID_MICROCHIP_WILC1000	0x5347
 
+#define SDIO_VENDOR_ID_NXP			0x0471
+#define SDIO_DEVICE_ID_NXP_IW61X		0x0205
+
 #define SDIO_VENDOR_ID_REALTEK			0x024c
 #define SDIO_DEVICE_ID_REALTEK_RTW8723BS	0xb723
 #define SDIO_DEVICE_ID_REALTEK_RTW8821BS	0xb821
-- 
2.34.1


