Return-Path: <linux-wireless+bounces-11505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11369953F48
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 04:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357251C21CFE
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 02:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D9D6F31C;
	Fri, 16 Aug 2024 02:06:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2123.outbound.protection.outlook.com [40.107.255.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC6857CA7;
	Fri, 16 Aug 2024 02:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723774017; cv=fail; b=KGqxEWfvIgAr6tZnvcPFH5vYpybUrncH3FvrS+3T32pXZBPcTUjXthH8Xn01dsEuSZ3gbA6cBMpRPDAjnejkc5nW0c4RrMDHgYAIBQIijUwZ1U/2ZJYFJ7ZqKpSCoiaRwCCxhF4Xf7+0RKUYXFdRkOJIIh8GGEWFKzrM0VLukYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723774017; c=relaxed/simple;
	bh=2VnM3Xke/V+FBPoCBZ6dXFpkeLfGCL5kEesF20cliAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fL+0YI7vG6eMK1u8d9WuI7uLopjye22mHvUB876csx27HG0XAIhJpGNdDPGTrja/VT8ULOoINLd3E4IXXJ2J4agBKd1nO2jqaDlUiPk9c3ywSCn+OZ5XMIlivRKdppuUGw6hOHI9xNMtb9OJGJrPlBj5cvi6eLx5W/Nz+s+MBPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSkOHUiloqkShABu8iCn/ex5WpoRtNtWgJQfNR8y9JPf+a6je7lFaXYPo4anBz1nzl/bJ707jXGA7iM8+DZAPRAXuL3lavTfu7bqsiJo6LoVwb4f3kl73OA9ZjQVOGUkzCsjCqMdsOEjOILv5M+zv5B5EewrbTnA3Ma+eaKlgaNfKIZ15o6uaiMRQn+etTqDDxrATxbNcMfSECl1ITRhYvF+ruOSgyKHoIi64QyNI6EEeCs6taIVQEiXg9YLOUcO5ejqNglynn1WJGjYV3LR6JihyM00pUmTwROxL3jgvQn5uibxPL3x5ko1FTD0FO70qf34vgOOL+aFZeVPZD+Jzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3ZCKui3FOaZbR8MmUilWzOmfwqy4Ji7tdvVIJh0aaI=;
 b=nmMsNScGIv7/dtBvlly5dVmIRyJu6EWKwggmyTzZzvS6LjJgM9cTj6bW/jXbQ0mP/w1zsnKZPMhEOMMAkUdoAByT3aPcYo73996dotJ8DWLaQdupvHt8eSlOxNCJaH08tfHyq2Krr6GJG9y2u8MDJ6lkxJHTmQLRNSIwsoREqycjC3ZcTyF2TQyOmm2HyuAUXitHze+Hgqqyeq1gqLNTQO8KfP5UMOh6pubZb/LyWX1HgjFs7eDwDbDeiosyLoHDfCVL8/n70O5yv2iQjNlGCnRg/KCHc7MWxk8mBg2fTefTk6Fy9XXZLmt4A1ujMahRgY6Hh3Re/sje098Xu2hUpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by KL1PR03MB8239.apcprd03.prod.outlook.com (2603:1096:820:114::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 02:06:50 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 02:06:49 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	saikrishnag@marvell.com,
	megi@xff.cz,
	bhelgaas@google.com,
	duoming@zju.edu.cn,
	minipli@grsecurity.net,
	yajun.deng@linux.dev,
	stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	christophe.jaillet@wanadoo.fr,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	Jacobe Zang <jacobe.zang@wesion.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v11 1/4] dt-bindings: net: wireless: brcm4329-fmac: add pci14e4,449d
Date: Fri, 16 Aug 2024 10:06:32 +0800
Message-Id: <20240816020635.1273911-2-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816020635.1273911-1-jacobe.zang@wesion.com>
References: <20240816020635.1273911-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|KL1PR03MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a25da71-fb1e-4142-8416-08dcbd9816cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HECzgaT8whrsrya7bZvXGFIINPXyLtEW3IsX6d6KEChBF0r/N9yEiOuj9Zqb?=
 =?us-ascii?Q?jAXziJy0Vo8YWnTBHXP4HWMYW+f+LChg7U5JfS2qR151RhXeHYFWjrOq9Svk?=
 =?us-ascii?Q?bjp9d5GGzrhIeRKH2KwKI/h4tgRUyY3xobjN9PdGo/DfcRV50yQe4oQTnU6P?=
 =?us-ascii?Q?9OIZSQFjCWmWQ2wKuwr7HZdXy0frc0jJxTK0Ca6J7ecaVTxPT61dfNUMi0L8?=
 =?us-ascii?Q?n3oYh4Neo8hilUQ/mhpwor3bd9IWKgaRWIKSibO9ZoBqQ1r5Sx2aAJZkITE+?=
 =?us-ascii?Q?MaWUIozYrGxj5RZuepNQcsfk/HtujZtcTfyHIgIQlAmQMmcI4/aWCjOuE0uL?=
 =?us-ascii?Q?7V2vCyZB47B4hyqaNYEkAcxwaJIf9Jry/veKTkJ6Hnv2aXXutlaV1qwRGn6v?=
 =?us-ascii?Q?O3f2OtD3GifdCqydM4ZyyuwYjBfZ7CfhI3JDSy+CU+KroPvCGmwriFZxP89L?=
 =?us-ascii?Q?9T8SauDeQn+X1KR69EwQwRLd+p89i5zPmNG7x33kr0Hng6w4x6fTp/mnG1Cs?=
 =?us-ascii?Q?kvjdcJmzAs5ox6tZQNFmr3nzMf1oarPSadB6CTtKLqJjZthAm9HOQGGXIajZ?=
 =?us-ascii?Q?RbETvfILEmMyzhotQd5NuPQaOt/DpIGib9OSPAuWVbEQgl/Qhgkr9L2q7gnz?=
 =?us-ascii?Q?zr+MXSumYLtqEAifzRfrzDqGs/3w41nJ+TZxfp85biEU1pQWG6R5/w55uwO8?=
 =?us-ascii?Q?bate/0QsxiDVMNh22xaVJeB0JdEiDxruDu4JzbeZ7QQ4w1Oa2YUhWLrUT6ZM?=
 =?us-ascii?Q?avT4n2df7gYeyIDETVqOrk+q0GMnHDRmEFLvrk52JujPtaOTWOBRBqp/g/lE?=
 =?us-ascii?Q?7UWE9Q1IVV/Isr88OcRqZhu75RWPDe+MlXaqCj7FjHC0KKTLl/l2jLdPhvwf?=
 =?us-ascii?Q?qK7CitQ80FJy14t2GZEsOoCcCac07OLaw2Exis059rXJYlOfGDAlIkLOkCww?=
 =?us-ascii?Q?wE9B1+KhRQrSAEmgP10DVPSXuD/jV4EpxI8TEXogMFoB1MKWnT/OphLY85yD?=
 =?us-ascii?Q?zYOvLfDeCtvHWU1p37a5IHIm7+lxg5ag2Xpj3mTSNNZkCGG84YOjpt3KOQAZ?=
 =?us-ascii?Q?umV2BuuHup3jmfB4jEtInB8tKYH+JEQREEgTK9PKwIwPLOR1mBo1Ckb/zdOC?=
 =?us-ascii?Q?cu+lVC0P8/0X2Qwne9uYlk1M4I8e9LQzq0ae9Q3lFCQ0lShU7IxtlJcb9YU5?=
 =?us-ascii?Q?Q2mfTS7tfgyoAV+Oe7jJJSl1ECkKC893t00h3hk0br5ZiUZf46oJ3c/euuQv?=
 =?us-ascii?Q?fga9IiLWbKna8F+0g2lmqZO6Cw6+19kqh+a2WZy6Ip7VlBRbuBt89oZBvTr6?=
 =?us-ascii?Q?9hSb3yKStC38b0Ijuw4Z1qgJ3LFKmOzch9S5z3LlKEI08k57dUBsV/7r0KVa?=
 =?us-ascii?Q?EfBefTZ0iat+D9ezQ1UmGZ7nch7tRG9QLBBXiQFPG/Vq/Ir/oQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q1HhcEKIh8YBQMldJ1+iDRSR904n9b36KXDPQmBkv2EUUTcoPhxr05u5Gzy3?=
 =?us-ascii?Q?672TiZJ+4ig2RNjHJlZ0LUUKG9bqYfkEJKmXybbwSJ5jV8wKBzaEJgcIG1/N?=
 =?us-ascii?Q?n2gR4wmzMCdNNw7b05gcdW8H3/U3DkAV+8p4aRtKgzNM69dOQ51MfDGRR0k5?=
 =?us-ascii?Q?k9LkhMIoLs9WnzAodWOP65gmkF6HYOJaGTyxgpEz9EzSKH/zTDGR4a6i45Fg?=
 =?us-ascii?Q?23AE01J5rH2Zo3MxuJcbyYcZmebiDLm5zX9eTupjEYdtbVzpKn1SmEiSpAHA?=
 =?us-ascii?Q?4YddcgoOieRj7RVH975KzYdvcOdZxM1aUZTVaCbBrVdT8oLsE4k0AZgx8BdW?=
 =?us-ascii?Q?a9zD9wYQtI2BiuQOlCol0y3WaI2WgDR5QYF0vv56Em5LUmxeRBf22zYqHVQ5?=
 =?us-ascii?Q?kriojPknoK+ksCwaw4TQW0f4EndJJx+Y7JzRiAsRkks6U+KDkS5v6tWOyfR1?=
 =?us-ascii?Q?jCXlvhCE0SFmVly73dfwn9VQHHmJhFkw2CaB3zN03J77s7sgeTjOdPrLF1Ns?=
 =?us-ascii?Q?T8iCj2yfYAYaTLIuPR2Qc6S10j3mTeKkpFlWr2cl43dtfQJ70WpSQqHkww2Z?=
 =?us-ascii?Q?avGm+Y/HY927+aW1MMV9y1vpVOIXJxsv1L6c4Oi8jIOIWVJxcwXGBDAWLyWO?=
 =?us-ascii?Q?561XIvcPIIVYZgrUy9OkZx4u9YH1X3GzG8cXCOcDRTp4qGobbgHVigtRyosN?=
 =?us-ascii?Q?Cu6hinyyASrfb3M4R2kuIu5rQHod+2qxxp5rGup+awSjGiCioqjpl0c2/gMU?=
 =?us-ascii?Q?YN/znh2JIRiHmsrcR0DX5CwUhhrqEa9NB6q7TOOuF7rdQzQqLt1ZQQ2go0JB?=
 =?us-ascii?Q?B8zkfQIEuQQMNYn7pnQOf0G124+Cr7muipYDF8IKsy26no5n4JG7S9Wb7VDS?=
 =?us-ascii?Q?5DNpSnE4XBcCb8v2THOXZrkw76kgfLQq5iC1eZn7UfvgF4e/fZS5PBLNRm0e?=
 =?us-ascii?Q?GqmRuwXhnrC/RL5NuCSVdh7h9JiGd0N8DLes1P+6RXDNaC0T1NSTStxs7olm?=
 =?us-ascii?Q?0F6hM1xE76YMbHq4YxHhfpjKUwJcAZ6kEvAWOswSzHAKLXUaM6G/VAf4Dt6D?=
 =?us-ascii?Q?MFmWw3KjE6hmpvkNt950fJzowqmd9n2cjKyNFzvUm9bHt31GKdijpQZGsc1Z?=
 =?us-ascii?Q?DAeb41kKOhIBYwIsbkIddZ8fEXvt5/5mtyTGCvlbXK8CKZnfgmAnIkl+bAEc?=
 =?us-ascii?Q?5qKgOqmTQ+i2Bf19d6/wFTCqYfPBtyuYLZOSijrRcJ7hGTXygjrlVwB9hg39?=
 =?us-ascii?Q?rm0H3g91anWhCbz8RX5JZr5exT1kEDlm1lDrjfkM/J/ObSD94B/XgR4XNPpg?=
 =?us-ascii?Q?zHUESbOGFegdYm6LRklUNhlPrKmG8RsCOFOlQPXU2rSdsEtjiqTPGtrbpNvx?=
 =?us-ascii?Q?x8C8SZzIMO3m4nWAMTOhudSI1o72ST25yqRfeaX8XhZy+ZLctCAV5xaMD8eG?=
 =?us-ascii?Q?eM8InwJWQEwrU9x9yDAqplZ3sFhgB1GMNOeU9DWEarNysiVDET6MZGBxzUIr?=
 =?us-ascii?Q?m/XZLz2WzPciXoBse2+Q4o+/vpXF/NrwHj1M5tz1xpjo9Nxw7BQcOxNVq5Yi?=
 =?us-ascii?Q?XAuKbLWePKby+iwmpj/f1KteuFFDgPRNEYDR8r125Ljrz6WVAqY7KiofVbTm?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a25da71-fb1e-4142-8416-08dcbd9816cd
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 02:06:49.7529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejFoM+imkaJRBecknFEQhvydkA0svAfwl7v1l1AJrDwOunectCYFXSIt5E6/YrcvenPun2T1UAPux39zM/GJfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8239

It's the device id used by AP6275P which is the Wi-Fi module
used by Rockchip's RK3588 evaluation board and also used in
some other RK3588 boards.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index e564f20d8f415..2c2093c77ec9a 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -53,6 +53,7 @@ properties:
           - pci14e4,4488  # BCM4377
           - pci14e4,4425  # BCM4378
           - pci14e4,4433  # BCM4387
+          - pci14e4,449d  # BCM43752
 
   reg:
     description: SDIO function number for the device (for most cases
-- 
2.34.1


