Return-Path: <linux-wireless+bounces-17589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAFFA135CE
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 09:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DAD716430E
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 08:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4956A1D89FA;
	Thu, 16 Jan 2025 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="o/mO4JjY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013064.outbound.protection.outlook.com [52.101.67.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E80B1D7E52;
	Thu, 16 Jan 2025 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737017250; cv=fail; b=umWzvttZS6d5IN4Cz7fIXvXIKcGdlbuCdjhAvEfviFUl9UWRRflrFFa+Zxr+pikGFnmbUNRtVrChEWlLzBUhqb77LjOYEEr3/CPUNjfz2DaBWOUMdnamEwRmbJviODcm0C4txxtU8OaZ6Cv3XkR0huFkGBDV1sCuWN+s2ZAdO1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737017250; c=relaxed/simple;
	bh=LDDJcUrXFkWKe5FKTIJ1hpQpKblSf4eAw0bOSHuH8iE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ulQuUIAWGLAT0+QR7UFrRy+jtrhOiibfDtFDwL9b7MT4ua3QTupl8EAqZwuDfW8/Nus6pl3KSWsD0lXN89/T9ppWUJARI69N/Jk/xYvtA4P9Hm5yBtQdAnsBnwvLfhkCUbYhMnDi9oyj2ndPMwDA0KK0h0m7iBUtm5zB8v3RX5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=o/mO4JjY; arc=fail smtp.client-ip=52.101.67.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwSq7yoQDgpkdJCnZaeTvVLSXCtRPCSp67jc/vRMnykchdkTX7GkWyIW3aG+inoEQ2Zg8zCFlb1V/poHaIxX+nIyqytxl9kwBW/MYCTw544d7TS68chR1Jp0gOITvOwmj01+jI9Fr5jKGvzCUkT/FNPqv5ODV+A0PkG9YutbKcJ721Tpfp67sCbqefwBuyb7pDyfpQb48XtfWhsX0A5WaRK25jLzI9j986etaZFDJaFaGBgWHnaU0Ztb4LdLWff6q94ZBjWKstXTIINczfasPeJ3qVabc5kX877DGfpWeVkOMG2xMuRM8VKLSFZ2X0YotAbgflenalozrc8voh2W/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7ePe8LrpbKbpFWmraqm2BTfhKZLA99rUCyeM3NWd/s=;
 b=ta3ivX1fb57Ecfej8AO2qUbXFpI5v7JeamIhwoZ5H3dkSvKJz9OczxxeJZujGvekgxyL+bipgnp3j+aBAmkxp19+fPpoJoerVOxiiZpPUWl9ZUpLrSxP6G3OvReWpowbHp+bbNWY+tUxrQOWn/B/8py8OeFmeX4qnqOrxRkATxkgg+Rf83wuypQ7O0SP5zR91A5bvAo+i3tfxzmuM9nvwDPJ2X0FTkUKpyjvoSZpg0rl0WnV4rl9MhViJUlYdgxVpnhNOWUAxoniU0bALI3blxHSIy9RcKxhC9D4x5T9gHfiE73FOoTuaaHUXODJrqsnH/e92IvcQctr5tX7OR7BmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7ePe8LrpbKbpFWmraqm2BTfhKZLA99rUCyeM3NWd/s=;
 b=o/mO4JjY/zpCIV6MrBISkwOXrTi22ZcJkmhNCFS7+6LyiwtDgcNYPcJ2O7rE7Cgdr6FypuXfJ2BCXxivRjMghaew2QOOyC+CqiAn4+bPygG9oSz2oOP96ehtg0Z+4Ihwto8hgTn0fBG5a0/YYV1SzWepCC2Jo3Oy7hsWZjIWbTk=
Received: from DU6P191CA0057.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::15)
 by PAXPR06MB7422.eurprd06.prod.outlook.com (2603:10a6:102:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 08:47:25 +0000
Received: from DB1PEPF00050A01.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::e2) by DU6P191CA0057.outlook.office365.com
 (2603:10a6:10:53e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.14 via Frontend Transport; Thu,
 16 Jan 2025 08:47:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DB1PEPF00050A01.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 08:47:23 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Thu, 16 Jan 2025 09:47:23 +0100
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	johannes@sipsolutions.net,
	p.zabel@pengutronix.de
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	m.felsch@pengutronix.de,
	bsp-development.geo@leica-geosystems.com,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH net-next v2 2/2] net: rfkill: gpio: allow booting in blocked state
Date: Thu, 16 Jan 2025 09:47:02 +0100
Message-Id: <20250116084702.3473176-2-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116084702.3473176-1-catalin.popescu@leica-geosystems.com>
References: <20250116084702.3473176-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Jan 2025 08:47:23.0321 (UTC) FILETIME=[42D01A90:01DB67F3]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A01:EE_|PAXPR06MB7422:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ac49c42b-ecea-4662-2a32-08dd360a6582
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ARzLZeS56oV47x+UIeElUYTeL/53flYCd48OC/E1sM7m99/x3gkVbxHEROb4?=
 =?us-ascii?Q?/wLPRddNksuATamG+WHQqJNj9lgsuwmMH7jy0zmynzVLrRJoxl1CG9BE9Yim?=
 =?us-ascii?Q?hhBmoaWbkO+6jKNCFoKKxoCJ/jC+MRvTvkH16CfydDb121giSYHxUH9D338M?=
 =?us-ascii?Q?0nF1/kyb6i8NVb0QPowinF91XbkzM4LWtWQbFT33DfIXcyY65AkaQsZuJpP8?=
 =?us-ascii?Q?qPIdTTGh2n+QUjbBTJvUsbZwXDVK6Rjf8qXv/Y2soirT3KChVgWpKgJUV3+c?=
 =?us-ascii?Q?s6zIZ0t7uOcfRWvBkFyG3z+Gf5k9FPfo2veObjgtXqpssfXd8H1+nIV5kxfD?=
 =?us-ascii?Q?mNoH/5kO6yuUAwK0mXp0mlb7GyNqVcEasHybf2n8+mbr1FUxEMARcp+iAh++?=
 =?us-ascii?Q?qsrWI+TqAFJvN5G4wnuBVaLFGzeocJI5Ty+57EgBD8/drfeRtHqVTuGDP6D3?=
 =?us-ascii?Q?GLXt+ghXlW9kr3DJmJJWU8vBKfOUhLyCq322gPoo89hbIqZGVkGDNh9UDV7J?=
 =?us-ascii?Q?sTqvqVYpZT4p7q413ehVOjHmSF1CCwPC7VKlVF6RNt7i77/OB2NTT6TtAQ7o?=
 =?us-ascii?Q?Y39NDWCEDL5CvfaUuoM/Od75ycZO/xPif06fa77E2p3wJ/1po3VSCbMzPqmQ?=
 =?us-ascii?Q?mGwYGH2BgQFSnLP+mrDujx/g8Z9z0JtH93kbB6cmRH9tKZ2tghKTZLrfSzh3?=
 =?us-ascii?Q?DdfTTRvQIo58B94RxdRuv0pF8whO2Stg1m2gE19dce4+VrQqTOvb80LFLfrN?=
 =?us-ascii?Q?BP0kRhEzH59PP2Wrx5jhlCBGVWxgMXfnrKNoJb3escoouzGP3lBlVwoXm19l?=
 =?us-ascii?Q?cY+VqfqNDRmdkOzg285aglHLUQJEWylkn5xV8NrYyOi1ks9sh2yhjbm0Wreo?=
 =?us-ascii?Q?WezxsrQijbOXXajSb5LZJMGAB2XiKTQjCGJz+pYV60hH9XnfOmHX3LGYf/IA?=
 =?us-ascii?Q?a/iYGD/mwbNclNLhQLMxCVVo3q4YWNK6+10+UjPjMUK7/inXtFOxVjxm1qIv?=
 =?us-ascii?Q?4MwrXXfLnVDR/wVXPXGp/PlaAeGDACv7qMg/Xg0FY9Lxljm9GgkC1qe49nmo?=
 =?us-ascii?Q?A10+C8/fhRYmsaF64InDlrY2TPrZ00nGCaFlOCcrTeE228wzQn/5ALSdTDW1?=
 =?us-ascii?Q?9RhEA0CNcMQYd4ZI3o7yC7+BKCptUTcEOjc2FzVGtBWLMRgA+6glOm22N2SK?=
 =?us-ascii?Q?lCVXTsw4tO/J4aMbjiO/aZ5U5V0ZYb5u1cmxEgXPKE4gnAhep5KCQMQ3YuV0?=
 =?us-ascii?Q?X76K5VYfFagqg1qeqLnBmI4EsJNNuJ7ryydAs6gbT1kXDHRJ6pawfZc6l8TA?=
 =?us-ascii?Q?em8QN6R013H66HMFjTSOaivFDeB/TDYm5W0VZIGlj9+Rfg3kVcryuAqWpSBT?=
 =?us-ascii?Q?N3m7UHJPBnzrl9i/9GQZrfT/KZkU6sDeL8Zz9UeL1Z24Kv+Nlo4NCKDfq63r?=
 =?us-ascii?Q?++z8+3Y90hEqqg3FxEZ2Pw50dlz6n993Mdp06BqSzP8Kx6uDY8cxyGN3ZE3t?=
 =?us-ascii?Q?iFzaOILvHWbOMG4=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 08:47:23.5674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac49c42b-ecea-4662-2a32-08dd360a6582
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7422

By default, rfkill state is unblocked and this behavior is not
configurable. Add support for booting in blocked state based on the
presence of a devicetree property.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
 net/rfkill/rfkill-gpio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index 9fa019e0dcad..41e657e97761 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -162,6 +162,9 @@ static int rfkill_gpio_probe(struct platform_device *pdev)
 	if (!rfkill->rfkill_dev)
 		return -ENOMEM;
 
+	if (device_property_present(&pdev->dev, "default-blocked"))
+		rfkill_init_sw_state(rfkill->rfkill_dev, true);
+
 	ret = rfkill_register(rfkill->rfkill_dev);
 	if (ret < 0)
 		goto err_destroy;
-- 
2.34.1


