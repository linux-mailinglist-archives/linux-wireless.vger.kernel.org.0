Return-Path: <linux-wireless+bounces-9042-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E8690A290
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 04:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36193282D91
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 02:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC601779B8;
	Mon, 17 Jun 2024 02:43:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2093.outbound.protection.outlook.com [40.107.117.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B3E176ABF;
	Mon, 17 Jun 2024 02:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718592237; cv=fail; b=G7Keafos90LKxUgLJOXHoHbU8lm8yWbs/bn3OueIHTYKxnH7BMIYq3QXfJpBreseDIfTamd8iWvMoHoW9sa/cgTLMY2645ilhjwf9HDsc/P51wVp+M5n+kMX8Fr8clLCPRai1eOBE7iRrUT1d2pXzp+01rcI57cKj0LDkMco80o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718592237; c=relaxed/simple;
	bh=zts0Fr7gF5WTSOd5WCL6W9lSf4Mjb6CycJIL3saLe6A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=t/R/PTuYCmeyzy5d4PjR2kWr/YXHV0c2OawpeE5iJFzzWButXETrDG9K/cy2QcFmI0jx5wa9PJI8WeFpJ7+BbDBEKZcpA7PqXdeYSUs8UGzQnFjQV+dEJj5z9D5wuuY3ZMAXMzH6r8bz3IWb97mx5/II5dI90i7vKl3YeSZyVZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDQcEa4exj+OgTSCTIlqusTW4dzb5xD/Mi50Jt6Cy9k8q680rZ8Tmfoqeg4yUhF2S7KUzSFMRyHR0u05376jdC8eX7n8bp/ZJHF+tt3GIHleg2V4xf1HnUca7wbunxbxL+/jGdxHFYOUKqC3Uy72j4GSDkYE9wo0LLZbuMGBGjMLtDHw3aqJgCFQ3ToSzBxjfM86cmERBJ0csfs4JG6C4eOIqzZkzEYjUO3rZ16C+wqSSn7AYrhgqEI3lDJtMQtxCLgwFl6U7kPsAB6Uye4Jr7TMFN2uRe4VRWbkcjNutbpOzgRmZ0uE83AFyz0xlI250k6cb10NZY+qkk7U1wupXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVSZ4c3Rkf5X7UYTLQ2cqFL9107rmBzK0uKOIlb+iQk=;
 b=W4f83Jk4nISdNbIfblE2yPBXjc0+obfmH2PEzqO1OAm3w7Km1jD6UMHhVGaqiKcVGYDLF2NH30mXvB9lBW9/biEtsiKYMNprL5e8Ni/aM9sZ5JxXGG7GVK0gBV1PF1WGaJlWfBFHj9IxvrItA+EewUwOVwtbK8UL4eTlh2c9sG/LiMEc3f07adYPaVSB3fMBZouKBXpaZCCJOz0nKuOoZTL4yxor4GJoiw3PXzliaj+RmdRSA5p9UFMnwTofhzB0kucbRZBPMzWVYC4eDZ2DM1Igh+N0nu3Y0IzBZhWRf5jih/ki8c49REYrpdluZ2ZF/3qiefJ3El9inY0UnAw6UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TY0PR03MB6452.apcprd03.prod.outlook.com (2603:1096:400:1bf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 02:43:52 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Mon, 17 Jun 2024
 02:43:52 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: kvalo@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: nick@khadas.com,
	arend@broadcom.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v1] dt-bindings: net: wireless: BCM4329 binding: add pci14e4,449d
Date: Mon, 17 Jun 2024 10:43:41 +0800
Message-Id: <20240617024341.3106240-1-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TY0PR03MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: db0fc517-9777-4af3-c46b-08dc8e775302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|7416011|376011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?43NZNM0vgoOdvyP/XfALrqvqTxIlCY+DqGqlLLpe75Ya3z6BVopJ4cM2m/bo?=
 =?us-ascii?Q?UmRqh2fJuY2ICoCYXvdpdxEBaovg1EGNeRkNpU6WbmRPRHuLd8rU1Me5/jta?=
 =?us-ascii?Q?C+CcAR6PJhI/Ete1r/F3RTMklHi3BI497P6/CsbdZL+BFJNEWqVmfCPL8oZy?=
 =?us-ascii?Q?qb7Il1f3k87BxUBUzqaMecnja4v5rUVZ9U6RjPNQSMb/d3EsqSPsijGMQDbn?=
 =?us-ascii?Q?VltTjAN40jZ8awF4IZw/zGJE+zs31JwrU5J4S2zesVA0fBFMr+0fO83Se4xO?=
 =?us-ascii?Q?N/J9fP54dtcI4/cQdGRY1YyqE8v6rKN6UPqq81udglbkteSv0cUsR7ALcmWD?=
 =?us-ascii?Q?2QQzXMOVP1jn8WlwXzYYImz+crqF9VMaobpKrppMnqcM7h5H7CH3BK7fMmww?=
 =?us-ascii?Q?PRme/K3bE3kqJLY12pCpX53EZrgx6rXAHtsPzL6SqLqcVrPXOuhczte7lH85?=
 =?us-ascii?Q?f02f4DlvmDkUQuXPQU5mqutqSSB/8PyRd0ESc66PfuMbLrLwAgpifjCJkZzt?=
 =?us-ascii?Q?J8f+39y/E9aq3zHBf7h7m+wtfTKnR1uw2DE3NNNm0b/E281kHoEb7fuFWa9O?=
 =?us-ascii?Q?RdbpHLezwppd62TRfx1R1qizcLfq4RoguN9JsWoT8XVe7bmzyu/ff+gfpbQJ?=
 =?us-ascii?Q?EuPCkD2KOoRDpITwpBUjp05qI8NiX/I+XXsKa6d5CRrVon7ugc93jhRvFY56?=
 =?us-ascii?Q?CHQybx+HRm+IDKTNAFNBtx+i+i4nfig1jtmfKZXzkRpqifIHFtjh9/LLE2Xn?=
 =?us-ascii?Q?i0RkWLjuorxyRA6IbDyzyHEyY/pJDSNzjPpSoXy/t3wPl+c5gbmeiIa9fkyg?=
 =?us-ascii?Q?9Zr8e4bOcdCCgsqitfjyG9y7pKJKmT3tgbuWYsKXF4G1gya1dZcizHgDnxjm?=
 =?us-ascii?Q?2ZdmDyHTVsYClNc4iJagvy1h4typE7kc9KNUtEwaIZe7fJdgCvOUizPyfWAZ?=
 =?us-ascii?Q?rTFHeNY5IIOgvtIXV73ywRxd8k4/RZSocC4ze2Yo4cbQZUty3+cDp/rQUxjr?=
 =?us-ascii?Q?xxVInfJDXYQtmIFYP9paHOTzgg/FjNwwJkHs9aOo80oBk//rqMD+xCV8burW?=
 =?us-ascii?Q?uJ+6n96GRlPLCPwjXLfrBovBvRfoUHoXPI0X2GmhrIexM4bSnxLBW5k72ZJf?=
 =?us-ascii?Q?XUDjk5KdBd+OdfLSDTSvA+DLf6fvwmFn0UYzI3kOpn8gT+Z+KHPmCRiagWmU?=
 =?us-ascii?Q?aGHICL8qqxDbu/XXIv4JLZj9QBd9pQaCjjjjwjdtQMZvMeuaWfpjGmm2hBRB?=
 =?us-ascii?Q?ReHyRtkvq2IqT8o602pDEuQlRrNXaXYoF1kk31Y8zWbPgI1nxCu7w1kcA/Cg?=
 =?us-ascii?Q?TQK6Sx0GbZs6IrVzVoQoaBim?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(7416011)(376011)(366013)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rWtDYIOOv/c9IoC1RApKqlHado9kszLVmA+8ogTz+NomKgC7lsa99cwvPtgX?=
 =?us-ascii?Q?Ewiy15EBwZ3ou1o+55Qa/xBFxxc5LfWnX43l/d+mb34e+B5KxtqhFtb7dY+7?=
 =?us-ascii?Q?Z0eHCTHvb2spIzHrluAbntaLoKNM2QTjUiQyU7J5sIxh6/Xio2XfzAvgQMP0?=
 =?us-ascii?Q?6wBvI3krN1yNCl0Pp95zAthNm8v8bLP64a9ksnbfGV52zzRv+hvQ9MRUmAYi?=
 =?us-ascii?Q?PJmbWDDlOCEusclKqDH3NTp79MUW0MAyNoXbNQe06tJIZYJ6r734hzIwcMof?=
 =?us-ascii?Q?uKR5SrehZQTVDnePJif88IJvethOIdxV5CKRIjgLqr2FuRDK4gMSe0sRsA3q?=
 =?us-ascii?Q?uWvidQj2RQ0uVk0EIpF001WKrblBa5YFDjJSYGI9WBLlfO351sbgMcVzt09E?=
 =?us-ascii?Q?4B3LTilSAK7UeN4hqa+q1lAkOwLB3xhoM35h4AnWHfc+uOVPjP05MAJN+eis?=
 =?us-ascii?Q?p7j3V8cZzwyioj7CapE1xu8c2lMqbLKsPXSjeVYWs6RtR/fnqtXwHFX0KNrm?=
 =?us-ascii?Q?EBAPObkeOIewPQjIV4c4qOD+zQOb1hEjXvgSMGwFoVuTVpU1EI5oYxGZ16TK?=
 =?us-ascii?Q?lGCz6Bi5w4f6QC4ugjhGDlf5EytT0YUPKSPgCPibz83/YsE/FHmbo1A92kWb?=
 =?us-ascii?Q?AexoEWFD6qmPGQtY8d1RmI4ChW2TB4XSqz10Q5DiNUvwW+/2dP9EJ8eI3hui?=
 =?us-ascii?Q?W1rcwjzvYDAneikN5SiFoLq2S71RD6izJkUnSsYAOPOCkCYWFr1eQj4YW5o5?=
 =?us-ascii?Q?oVL0VS924PF+2IJpaC0LS0efuwfH/TzBxkJ7zA9EbWuxGxMz+QRjfRkXGAVP?=
 =?us-ascii?Q?hR14HKbITHaD5C+BEMpFGvkYSuWgr+iZSnDsNgJgb+jM0fs0aJaKRCh+szSX?=
 =?us-ascii?Q?s2lCHVuShj/1TH0iOevaPDAbzvJft93Iy1f0bqfciWZg5SOr53pHXx6WFbpF?=
 =?us-ascii?Q?SjZjgNrgdTmL/XHWpE/scyZxo5WG9TsP+ulxVPr3rLtxOPIWRy5+aoMkanPU?=
 =?us-ascii?Q?bnNBvBP2r3N9XkQ7pvqmWr06LLcYrXl0lIJV0qlWcsChdmFe/BK1pV/HWgSq?=
 =?us-ascii?Q?03w8jorlD0Zt3VfOqn6ycPz7z6zvJVJIzPhHT/+i5IZLFXApypCDEXFNEJPO?=
 =?us-ascii?Q?jZ/FTzaYcMWgad/ow/JnRn1CCX1InEC1GooYRW+hpA4DwK7GlK/ETfOcDEae?=
 =?us-ascii?Q?hLdJgMgERzS/rkmRkFYgqmMEkNnudQcYwojzP/64/qtrULfvnuPv/aSJUUtU?=
 =?us-ascii?Q?2/RvHnveRbJdZRaL03CaM4KEHiSdkt1jbP34pE5PtFZyWkhf+B+L/h73yy6X?=
 =?us-ascii?Q?4vs4uTvI1WHXxClO9nR34mPhFrW5gIrmapF8UUtU9W+MlvfNCHB4dNkqw81f?=
 =?us-ascii?Q?JfPbAGYG+T/3qOI5Zdbggbi/Foa57WrATZfQBI6X/fjhQJyyiVd1/RoXNhX7?=
 =?us-ascii?Q?IOMwS6umFFl2Yh3OC6Mr3HbmEyZI++VdskqpSI82LOWkmUf3mShCeyy8eiMb?=
 =?us-ascii?Q?gZw1Kr88O/zgy9rYETsvAUdEs9UEV+o1A8YoW1XTM0w5rHt9GXr0eTeAmfB3?=
 =?us-ascii?Q?l96J5aVTjVEX2gw+GIUlMOYR6LXE+9kq1d1rFxpM0ih4T7QiHv3Xg5+7xYU0?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db0fc517-9777-4af3-c46b-08dc8e775302
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 02:43:52.6548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPWzQyBtMJfGDmQlp39HuXDX8Oeht9weG1xX6giumIGpYsC568hYJs5Uzai0eOSxalbP3BwFZULjpnyYNbv7Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6452

It's a Broadcom Wi-Fi module connected via the PCIe interface and also
add prefix in vendor-prefix.yaml

Link:https://lore.kernel.org/linux-devicetree/20240617023517.3104427-1-jacobe.zang@wesion.com/T/#u
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index e564f20d8f415..0477566acd72a 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -53,6 +53,7 @@ properties:
           - pci14e4,4488  # BCM4377
           - pci14e4,4425  # BCM4378
           - pci14e4,4433  # BCM4387
+          - pci14e4,449d  # BCM4329
 
   reg:
     description: SDIO function number for the device (for most cases
-- 
2.34.1


