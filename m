Return-Path: <linux-wireless+bounces-10848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C32694566C
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 04:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1132D287412
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 02:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDFD4D5A2;
	Fri,  2 Aug 2024 02:57:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2109.outbound.protection.outlook.com [40.107.255.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8001D3F8E4;
	Fri,  2 Aug 2024 02:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722567461; cv=fail; b=QQbAFQ3MeNvAzoq8+pTNnuVA7BAo7k5LBAivfGX1I9l8hLo1OI/U0dors84U5laUwVeGYiX/FbvP2ee87L5YHbPHccqha1MFK2FG0W5teQaRjqshZ03K/6wqwgaf1dwZAh0+mXWzxMoORVyv4ki0Yv/EBAD1jY31haFE2hQ9+6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722567461; c=relaxed/simple;
	bh=uyVPq0vuS+FMU0odfnlfw0F2eZnLPgwjnpAdPSqAp68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qPDqy8b5v/UcI2lXpyYc7iBXKefdzhuBR2CM9YiuyoF451gc1O1MAklgMtOBaxSXj3A6kZKsF3/kBC8NfqioghAJOzkW1Qu4YBEk9QwO5SRYn6xh6jQcV+tMMbtBmaVMemHxGLCsEZ5/kj7u7EZM9Mitqg2ZbecGYIy2l+GgD00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSykw+1HyIM1Y1OGB4D1CuppICfBbpHP9aKds1d/8e2JkzaTROrsTl/QV7YRrb1oU52XqH6B7QM3SuZ2I2sllaCfN1WATn2XqxONqCu7Il6LOdl6k+tblotDZXnBMpshwIMqDINV3raR/4m4wru2vTDzQvIeKgqXbpB7UF8fD4Gt0ZM3wf0L+Av2pWmuYTqza7il8nqDqggCyo2VdGKJa/tXhwjPmDrr2Uq2AgzSd5+tQWKzctWCwuKaR8rpLTfrD6kEB3iZvhUv0VrZnn2niYIJ3dJwRaxKNbWjZHq3uFDf2FIVn7TI0SPZ5IsjWMyty9mkGJQ6GWHwlvG8vXsy/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iPX8WFIoQ4QXgUD/qR3fD/Finzms7t/FKq4XAi292c=;
 b=Nk+yjdxKMHy1oD78LdL+nEHx5roJ650BK7kmfccR+J78k0rXFMIsSUdiTHeD3YEK1kjaDbtDnIc60LF7wDU18rJ5eV6kodF2uAf33pEY4KUTBXZt0KYMe3BwBC38U0jaPIEsFtL7yzJdGn8wORL+rwkDyIkHh8P0q/QjW8HGflqhLXgDGa5R/nMj5KMvHeD39dtAx074mJNQbnVIIPLawKztiqaxRSorNAyBRlUZpbCLBXzx/owIQLzBC580bRuJnrgCb6E8Mj3VS4ZKb1v0XKO7PXbCpDqTrBdNvaSf5KeRQQN4cTEVQ79iKxrBXnRTQ/gC/ttlCyqpVpmTjtDqDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB7120.apcprd03.prod.outlook.com (2603:1096:101:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 02:57:37 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7828.016; Fri, 2 Aug 2024
 02:57:37 +0000
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
Subject: [PATCH v7 2/5] dt-bindings: net: wireless: brcm4329-fmac: add clock description for AP6275P
Date: Fri,  2 Aug 2024 10:57:12 +0800
Message-Id: <20240802025715.2360456-3-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802025715.2360456-1-jacobe.zang@wesion.com>
References: <20240802025715.2360456-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEYPR03MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: 45cbe020-6fcc-4a7e-99fb-08dcb29edd76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yre6StDoLbn6RkKDuMDmwGqoOSLTFuSYNKco0F3ZlbiS1xClRsCpstf42BeB?=
 =?us-ascii?Q?pAw4VT+3sBcrhd875T08zLQDtUXsPPiJceacQLKN34OWuOc1LCofi6+6uD5q?=
 =?us-ascii?Q?k3DIwTcOohnEjwpfTwrdHDpuIRlnC4+nFqVWgBfphJw3+CEFxzj7gf/WuMif?=
 =?us-ascii?Q?Ps/qEXpGhT3ZE/OSl0eno8FPrFEQjvoz39SuAb15wl9IguMXHsHlK1Cj6NxK?=
 =?us-ascii?Q?m8zayEUzdpIupSacOW1BRAkQmN4bKh4NtgA5aG0nuhRx5KNBBA0fyvZOVSf4?=
 =?us-ascii?Q?S7x4IKIcieAJCiLTMac8NdhszFrdbV8Ce4bLMplcJy79XQMF82a+osHv0xCH?=
 =?us-ascii?Q?/Tkja1ijIvnUoOzKmf15MIedqkeFSUwpykpCTcaJjLy9zi0u3v+pql8UQDFj?=
 =?us-ascii?Q?tC+BIaAEG2MT112t+XShl7q6AbWx5ptLhAcfAUiHBVdB8Ni635juOapRUlfM?=
 =?us-ascii?Q?NCVApA2d+WBVD5E5PyHKCwbZU8Kd3eBRHSbcSaO5XJyLQICxQ29wvdaaQchA?=
 =?us-ascii?Q?j7Xgmz7ZjMtlozUZjqfSMNLf1+QkgSO7wjN8hHhRidujL6RrE0DfS4+2nKKf?=
 =?us-ascii?Q?MCAFcTG0boYIQ0Dwj2F7/LQV2tWRfJDADYi2G4WrvDdqv+oxxQJhIXXkkSWr?=
 =?us-ascii?Q?KYzqgeB4BUpQF9c4psL56n4Db9m1O+VLOq6CO6ftW2hUVE7/xl3j/AiZlszH?=
 =?us-ascii?Q?IcqyZTTFkbTwrpTGNIPjQSZvvwAjG7fyqCjzJvDtQt2tRvM1fIHxJhQOtxTA?=
 =?us-ascii?Q?tqRHLwusPB4RQ7Mu/PgHMp9By7oawXQHQfYiFFsW6fXUSmnSpaKl24/9Pn3I?=
 =?us-ascii?Q?MGJDI9MaXBImynMy/43A6Hz/dlGJYAPsZ0TFCGLBHa1EStJGHEfGOeAyXCAa?=
 =?us-ascii?Q?hL7kbSyI2lHsc7FCV1JJgQYtrsiNbWaG8by7N4R9+3ooqJbtxotVnsMnEVs0?=
 =?us-ascii?Q?xrZcG8MMTUftogCaikh5t4Orr54ZIsOTnEgxmVNL2jwW9WPkQF6fa45FLdZZ?=
 =?us-ascii?Q?v4iO/11qfZuo3UMFOc6J5T/WxaDx5XAhuc4ZCODNWpLaldlshkNmphMVwXk6?=
 =?us-ascii?Q?7R7wuKeUbv/TF8px+AtBEWfQakuAjzCMrJ37RQtUtxbW+B1GdhvQ9WKAwUWv?=
 =?us-ascii?Q?Pptx5rU2+guDhxzVJvv9BtgKNxRLTad2xD4JVFS9t9bFqlJ1LqLf2reEw7aj?=
 =?us-ascii?Q?oclhsbbfMNPu0ALxmwNKbDEOruZImwZZ74SSEQ9u9quCQUuj4C4JrjY52LjM?=
 =?us-ascii?Q?XiuXb3MbZveAQ6m09ryUk9AtdZl74CRcrvaiMBfckvmEuaQRWAeXoXjiogYf?=
 =?us-ascii?Q?i/lKuXPoTBKrIBII5kuxEJUsfqNyfLoeDhiIBWiCJa461C+yViF9dMv99WbP?=
 =?us-ascii?Q?ey6oYWLGdDJ9UxE3nGvBl9dn8mqunY5vHRdGP5GHXGcYZpK9ypqzUtXrVCog?=
 =?us-ascii?Q?k8N8byGO9Fs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JEC3MxrcEGiAFVKoehmxC9lg3vxKWscHV3A/waGt3iXFDLIYT5vN8kmc87cT?=
 =?us-ascii?Q?fZ8zfJFMVRg6fM80bpCpcH9PJZbBp4RNwqsGrsG1Mt5G1xtNkbpXTG0ZqgS3?=
 =?us-ascii?Q?wpurixX+lQ0wWaGfZ12yd5q3KLrJu0SXxoHbdjs5m1OLxtAHJSd1N8Jh8e5C?=
 =?us-ascii?Q?Bo0mrmYT8iAnZcGibFr1sAVD0wX3Rn88L3oGeAUgvtdbH/OiY2nNmN8ZDAVe?=
 =?us-ascii?Q?JFJgp+Oq1SW5yAIkdNjJoRjiyugi362Bw7zbUmY4TaHLbT2OBMWUTg28pY47?=
 =?us-ascii?Q?MgNk58QLm2lUYR0GVkXSNrzRnP5TC0658ssqbKJEjPvdF+7LpyX51Z6gV+h5?=
 =?us-ascii?Q?lA1yCRGqzqnAZ1GJkQ4IxOjvQvFZaO3SxV4oWPoE3LwSZiFcYpyqUh1nOe0s?=
 =?us-ascii?Q?Np9UfLoCFqUz3BN2GXXtVh058GcXne2K51ZoRakeb/JliRPM2KvIs5OflFci?=
 =?us-ascii?Q?fnLxK/cxiMmCqmf4ShpNOGx810SLy4Zcd4t8daVVF0aXEC5cN+aQSxAI0ooo?=
 =?us-ascii?Q?B0ZYVHpEM2yO4OuG4QVsee7ONmAVV+o/MqoMHkk6Bl0eX3ccn9OiPj2rZl/G?=
 =?us-ascii?Q?owK2I/LgZ+s4wrZqt2Ep6B3mfeKHgh+obn4R5+B1lUSdvdAqIhbo3Z40Lu1b?=
 =?us-ascii?Q?WA+i03VpcRxYhKawpai2wSydoWgAduWIlNq0kwdU7vVkwDxge/599UWRgECG?=
 =?us-ascii?Q?3o4jWqcboaFX9ehtwZVgj5rZvJtsMdjwKMG33/b2bcTGGNfvOmiFWDvbPlwB?=
 =?us-ascii?Q?tel1zync48xohGY+r3jV/AZg2hyCD/K1O177csFk5FJ0qhbk27THRjUUMIaL?=
 =?us-ascii?Q?mac4KU693+ZYLgGtOWciEQ+bux3KVCL3s8APmz0JuJHYgj93aDusbv61XsBx?=
 =?us-ascii?Q?ij6j1IVrNbX4VLIj1JOUWCXJaK9q9H21VdYq9DykbR+gKpLYPqZ2q71ukPKD?=
 =?us-ascii?Q?uXGDxMfdy8BsDyPTAdH/ve3W90ojjGun+7A3kqm1Y4nI1xgRrgPMNxPrWwcw?=
 =?us-ascii?Q?1d18pqqNFTZPPYgLgsANZKpusWj4LsEAGqYDAbzwh50KqYuQjPlCkpRDcwr1?=
 =?us-ascii?Q?x/4Lv70vWspcv98fYuFxtD7w02RwlrGGQ/w47eE1ax3LfAR1W40RyWsQqpvY?=
 =?us-ascii?Q?gyVaRXQoZj6XO3YLqfYMBgJdMjDmVorHN2RTnxNcTBB4A4JRqOKd7chKiwlh?=
 =?us-ascii?Q?ZMt6lCO4EyQHO9UWB+RI4QAEfA2PcD5g3N3C/5FuPzhO3XrkINByJFtXE7ya?=
 =?us-ascii?Q?i1J7hgMvGVa87XWze88vM9IdWMQ/a/PQSENfvJkgigPhjFelONwiryhF6FDs?=
 =?us-ascii?Q?Am5u5miltFBu2LxrD31P+A726hYkAsvQyGW3p5vNJuu3yv7jim2V7RAPWA7U?=
 =?us-ascii?Q?YtSqiLJ1hT8y3j4ippKy9FeP60fP+fE2orbJPIePJ2yMGs4AWBWgteYPdz7z?=
 =?us-ascii?Q?nKjqzCRgiMBhfol/q+/Qw0+HQLr1iB/IsTX2Gk+t5ykO23fPllyHh8GEhro8?=
 =?us-ascii?Q?Rh1fkExOC5MyIeefi6f+kyMzUU+cmoBYmcpL6wK/S9k42iHQQ2AuhE+V5QMj?=
 =?us-ascii?Q?yGeKtDnPVuoRzbj14PXM+ENah3e5+N3lV48NYAZZ?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45cbe020-6fcc-4a7e-99fb-08dcb29edd76
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 02:57:37.1819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0EFgUeSow4ClutES5184aHQsOV5XiJtptu8NMc7uX29fnu/HQgyFxnOPCGZtrNvuf7ouolih+ZSQWChyNxABw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7120

Not only AP6275P Wi-Fi device but also all Broadcom wireless devices allow
external low power clock input. In DTS the clock as an optional choice in
the absence of an internal clock.

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index 2c2093c77ec9a..a3607d55ef367 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -122,6 +122,14 @@ properties:
       NVRAM. This would normally be filled in by the bootloader from platform
       configuration data.
 
+  clocks:
+    items:
+      - description: External Low Power Clock input (32.768KHz)
+
+  clock-names:
+    items:
+      - const: lpo
+
 required:
   - compatible
   - reg
-- 
2.34.1


