Return-Path: <linux-wireless+bounces-10709-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1752994262C
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 08:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390E61C20DEF
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 06:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD30516089A;
	Wed, 31 Jul 2024 06:11:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2091.outbound.protection.outlook.com [40.107.255.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E311607BA;
	Wed, 31 Jul 2024 06:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406314; cv=fail; b=FGmAmyOHmdwdtqFmY8Epcrv0Yc2/WLqS84fgT4CICabNe7gkQkB9j0SXj0YzcMcxPJaTx3DQXXCFgD511/XC8m1iyxoML/PZWodDTPqLUAa9nOj/Z0ANcAU9DVbId9BkkqVG9l68qh91/5hcG6Uvg6QBJOwJRzkY/fWJAJIypFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406314; c=relaxed/simple;
	bh=2VnM3Xke/V+FBPoCBZ6dXFpkeLfGCL5kEesF20cliAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vDY7dQk8eHg2V6yYtebe7S+hFlPW38SECy4xmgE3cczOA7OveHA1P89h/BdhblVjv7JOtzLqTel+LZxnc1SFVEz40RLwA+XxwJVmvJdBloirKptsewdWI68S/afKnJBexUkZlYLjofNhu0hLjwafxy++Xlv2AJllJV1r/y6FGQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsDwdHow3LQdXz3ydpEHdx2tW7ghCunasHNk3PPrLBJJE8iPZoux0iXfySX0zto0le1hRykMYN9W1fGjfECGwBUCdHDr4q3hHLrFDsmtdEqMSYUbJnrSqsX7+VWyncSLvIuVdJv/Ku1mDoAcazG3SENZMAepXsWW/RlUb+ncxV+8+XXNT6Ic7GM4+u6i7teLT/ZrE1zCNWRhDAOiZmuKeZkWy73xZnFpVVwBIH6/wHbkE5AJAQmmG3G4JRmQud3quyXByITrUj8BhP8JLMZFto1ju29da6R8+iba6UXOK8BxtVtqa76nXG+qEStTtJpbPv/9XXrh+3fDb2vgbm+hZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3ZCKui3FOaZbR8MmUilWzOmfwqy4Ji7tdvVIJh0aaI=;
 b=NZKruUmc1bPkQBXxRkmXcff5hn5CFthObmFWYi2AlGBFOHWdTyQr/+9SeIJafngnsFWR+PTPLGDXvp1cbv/vDNGO8C3tKDvZNbGcoNk0sk+Cvmgle7GBskh4xhQOeDg+3OcHdVpDoSLiEYuEeAIKO1PTQvpCevBTqPBAbjP8dUWJ/YejrNNMcAipC9ZbF3kRzLnbLnA0YIRt4d44/IPI5FCR1VdovrXM0vEDsfw8hdaBsCXVgxNhzVc3SuMPKWiBwNLycPgm3KDYm1IlU7hu3YSnXi50adC7ROcy4ueZYO2nJ47UwA6slus3ZNF3Kb5OlPZGo3bmgfPp3Yh51qMPjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB6580.apcprd03.prod.outlook.com (2603:1096:101:85::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 06:11:47 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 06:11:47 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	heiko@sntech.de,
	kvalo@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	conor+dt@kernel.org,
	arend.vanspriel@broadcom.com
Cc: efectn@protonmail.com,
	dsimic@manjaro.org,
	jagan@edgeble.ai,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	arend@broadcom.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	megi@xff.cz,
	duoming@zju.edu.cn,
	bhelgaas@google.com,
	minipli@grsecurity.net,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	nick@khadas.com,
	Jacobe Zang <jacobe.zang@wesion.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/5] dt-bindings: net: wireless: brcm4329-fmac: add pci14e4,449d
Date: Wed, 31 Jul 2024 14:11:28 +0800
Message-Id: <20240731061132.703368-2-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731061132.703368-1-jacobe.zang@wesion.com>
References: <20240731061132.703368-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEYPR03MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf383a5-4068-4b13-308f-08dcb127a8c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LEJWwkAworILPSXlg0CXd+RVdQiXXK1waYMZ8omvU3iCpIj1g8KdkrTvzNau?=
 =?us-ascii?Q?6YHr8Er57FgBjeOb3nDIjVKetz9fEDNLhu1zmLF1zCzl9F7fTQT8/f7zG7V2?=
 =?us-ascii?Q?HbXINOm/5GQ2a3xJEAsThIdpNopXfQHUEtgZJDaWZ7iJWOSS1szvp5i+ArKn?=
 =?us-ascii?Q?WhbH6WtIEcFjkOZ7stMUIFl/XYdfREXyYZ4ipJu6jDsYJDhZWAibAKfsrAQ7?=
 =?us-ascii?Q?uhiT6kBLavqxQ5eyiEwIQf9QnZfHAKQafyyaKEb9GK27/t+BjDqP9vS+mtd8?=
 =?us-ascii?Q?ZfVum5HU3G0ZyC3s3uQjpFuK4fCoP4b8JXnfVUhbTLUF+hZW51l4wtJiJjgn?=
 =?us-ascii?Q?18VcJZUrSdiRgdD3n300y5xajMvqNu3a3SAFKkKCXxAqJUFAiL/8M/7abjtx?=
 =?us-ascii?Q?CxCHKrg8zOVor0hBzuxRWE7rx7RZ+5avuyvE4Y5B8Jqpb4GW8HL9BvvRiLjL?=
 =?us-ascii?Q?J4r6ptZJFhiWIk+I9kAzdprN5x8tbHDC85gzKsUBDXBGg0eX3hdmxfhyvach?=
 =?us-ascii?Q?rCq8G1Yekk7+sZ5+rVXF7Wwf3yoCa+KTJQaoFFfUl+RlcGAlkI7hs4BZPYId?=
 =?us-ascii?Q?Vugqt4vpgyoyz9yduCy4gg33q50SN7VQjCCYpZYvSeYMa+m73sMg/LdxsqC3?=
 =?us-ascii?Q?8ONNkuFFXwjze4U6QMsLZ60jvYNBZFXGn50Kr+jM+wc/BiEvD2zfrBf+yVEN?=
 =?us-ascii?Q?SnvUYM3nxWfwKo5WYgc0h31RliDHUJcJfn5yDkV20dqas0X2OMOG4sD6Gup0?=
 =?us-ascii?Q?Z7xFNLrKcyB+ZaJVN8Tsy+xcjuVGhvujMgthT3s+KIyaa3PcSrdiYKG2r3M8?=
 =?us-ascii?Q?iGU4obyvT2uD/h2Vk5O3XzQV+iA+mMo1SA4L2eKA7XOfmSEKHiPm6Hzq2AHP?=
 =?us-ascii?Q?veVjStPpOO5HMacvhC8mvVP2ve+2op8HiL22GJXTjOiRkOFi9QQeXgwJCzMQ?=
 =?us-ascii?Q?MTZ7/qJc39hpoFX0cDXoQTB164SeNzLXne0Dh25WPLpoRfY6gOLSiaiHF0Mx?=
 =?us-ascii?Q?bAvw3yOInP6XWhAoaUsBjNA5VMx09rGF4qhBSquVsFZ4Jo9dKOZhnrcokufz?=
 =?us-ascii?Q?2BAeDpYQz6DLK5PMp4y0P0Ao3irposptneBVbgQThsCejVSw002w1qtOpUBW?=
 =?us-ascii?Q?EUooAkhh1MjLlgAJ46DW/AZbhrFwXj9uQxagG7acNr+Nq8r8uUVu0z4K+vi7?=
 =?us-ascii?Q?Q/Q3zgDeMeA+fVaP2v2wQA+xLPv4l1K8aPhh7Ka9Ivrxpgs9XkH0SZ+hpQLM?=
 =?us-ascii?Q?A+3xC28ULLhq2SQOGdEh/HuRkLiN/fmCAnwgn2bZYFhSpWB/Bzi+qv+kwMuv?=
 =?us-ascii?Q?PNJgki392t/472jFhEMHOGV7APh/uaOjz6Ob6icpIH0/+kU1uoTVWwLuMq11?=
 =?us-ascii?Q?7OT5aqaJZ6tMrjMioPX55szoOIhRK7sND9/fMKroMprZOdvV5v6hpAhPGiKt?=
 =?us-ascii?Q?35OGOgU6INE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9uQ/rDXdKTgf3Akh+Arzq+tRSWbcAtGbtQnLpX0OEYVHMnZtzKiDqsSHfQe6?=
 =?us-ascii?Q?VPL9ivVXm7gFGnjVxpJt4RTUVc5H3g7yxOd07sDFm6ckZOD6d1qbUHJKwsk8?=
 =?us-ascii?Q?ckAkbdKaFXa6qQebp6mJaTZjKUEbawwL26LQqM9sDE678h750AfyvkZlTY1V?=
 =?us-ascii?Q?gcaGvMZ75Gi0v8k/GtNTTLouITC85v6Vzpetrm0P5wekX39Pm/yvcspwvoqi?=
 =?us-ascii?Q?ZANtxA1BXpZRWo2gMJHhqsIpP1ME8B7jJqU35vsak8UvL2129nhEKp8VX59l?=
 =?us-ascii?Q?hMRxbqcSB+WqGMEaQEb8rH/O1/M8pt9O7u0sc4UlJhg27QWsnD/H96Xt1b1Y?=
 =?us-ascii?Q?uKeugyOIifhuvf+x+UQ6qzoe+gcj1BXKNE5jW8j/cpK+4O7JDALw3zFL8nIo?=
 =?us-ascii?Q?6x1QcJuvuT9xGzMB82fnp3hko1b8AuKuSAKOwaHKAysSdWYDNA6M58U4gYyg?=
 =?us-ascii?Q?uKjjxxJrHkTtbtFZkh3ZJ17h+V9p9eHd+Kp9kJqmKAh54GoyN2pMJAmu/hCE?=
 =?us-ascii?Q?L02C7NefadNm8MagSMm59psBckncj9wfxO9nV/5sFi3EIuOWBxeEUnMXlTi4?=
 =?us-ascii?Q?pN4PHKSVwKx73HkI7++oIcv/Obc4aeJ18q0GuAVNdcjsjfD2MBB0blXV6S5V?=
 =?us-ascii?Q?9lXPXhO0rKd0TUxXkAY7FBUt6gOs/dE60r4QldTM5ow8kgrdYA1hYQADeXxh?=
 =?us-ascii?Q?2GKhU30nJ3p7dpCrM4/+/pdtn2kXvN8gEaMIQJ8iPDqA+TsgATnDW3I3c27r?=
 =?us-ascii?Q?S7BpDeKXa8gdZSkYxNThOHuHtJTkymCOUZSExn3rI7++ejUll2zaGRlcaCMy?=
 =?us-ascii?Q?fyqVet9pl4EDV8LnXO30Ywqc3as34bnxmFlkOQpKFKuPYHPD/HEGaEqN86/m?=
 =?us-ascii?Q?TIvKvnG5sI1K8L25J8RXuZ7lqiM0jXG9SvX2HEf/dnTDNpCh2JlTZ0GEfVqg?=
 =?us-ascii?Q?Mj3d/EkB+oz4kVJJOBXJebgnHHK4NXnKRSQewXoteWNci3t5eDwQJrvC2BW0?=
 =?us-ascii?Q?Uk1XXFk3mZleHQHcIkyxQDf2UcdDkNlerkEBQnoI/3gNvS5Fj1H14CPiA7VG?=
 =?us-ascii?Q?WzoJTyhEGOwWxGtArr7sPPAB6pL8G9aEiH+MbqXQNpAK7clRbXX0mrN4/a+W?=
 =?us-ascii?Q?WIORUZ0mAPUKjFoA5AFnea0sJkzH1yHbJKrwk8vavH8pyHwYwVD3v5PNPsee?=
 =?us-ascii?Q?h8dksqK06Wnfc4DBx3R2OJnpkVeNn6Kt4VlxWrZZG6owSSt8rxGQRDehhSk/?=
 =?us-ascii?Q?kENf+t3n/ctHIbV4chOlGBgX3bHEF/r8mT5wyyD86a/EaiANhyndXzyiYABX?=
 =?us-ascii?Q?G5Ak0UG7SrRCHBoupKMTXRvUQ1kSL6iCarMjILK0Ykn7fn1Lq6AVnVA2a322?=
 =?us-ascii?Q?UDWfpG0S/jjWdXpuuBxAmyDfjToaQWwUGU1M2MPFqWPTdz4bFMF+2202B18F?=
 =?us-ascii?Q?d0vYSuukqSHlOTjZxMlXDrvEQF0FNoMoCrGOM5YD0jQy6vWIB5/FHxUQPG/5?=
 =?us-ascii?Q?jkk1RfkMKPLZzhKmqbaT2I6u87pOS8mSjxeKT21SNC+YryoAFCtxcohgc7f9?=
 =?us-ascii?Q?xwknhNCkA1lU88+1yTMWmN/qvnfnTC6k77HA2lFS?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf383a5-4068-4b13-308f-08dcb127a8c2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 06:11:47.4610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1puHxDxTHMPX0zDTdWerUrIbVZ4sdNnjF3kYNBjsvfb6KBTZgaPyntjMC39QKyAlL6bKi9n8WsEq/gL/E0H1fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6580

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


