Return-Path: <linux-wireless+bounces-10711-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A84E2942635
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 08:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E411C210AD
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 06:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F8516C451;
	Wed, 31 Jul 2024 06:11:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2091.outbound.protection.outlook.com [40.107.255.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88240946F;
	Wed, 31 Jul 2024 06:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406319; cv=fail; b=Fq0sMsIiMmL44WAqfAN6BcP5upwXV83oNVZlV4tTPdU41TBinLuC0v2z46Gl/fUjDQcuN+GjhbF+hocWV4VWsIOuT6rlXzMZW7kgrpm81fUAwN4SxldyDAYubs7JqEdQbDyvL22g/ywsCOYh4j7OC4cUJJ1U7M6KmbeUze5XMYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406319; c=relaxed/simple;
	bh=uyVPq0vuS+FMU0odfnlfw0F2eZnLPgwjnpAdPSqAp68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PuodPLvlAlsgP1mwPklWPJQ/J1iL1IaI1FzlTWDvEOetR9/de7NFkZy52x7RrEJKG2qWt0nTofp7bbUV0njM2pwIq0/tEGCzneJ76wVUAklR+8rAJ//JlTlobAu8T9zbcPLY/BpzbdjcgDTV17ltquOXUznP8vtDSwJ7Sb1V6Bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBAQ1eVr4Mdy2JMv+WtpaoaooUo+zf6SmBsLRf1y3uX3Hh2bmpJcqZtDdKizGYU+VtIflm/NEaYLZTN2EgKt6pEqqXKMrTADKeI0NGuytc8QBx1R1uF4Fr5qCbsqFKgJyses/myuyaZyW5psfOC/gfumY1NFiF3T5RxhcTDn1UeNt7pn+Qg7aId0uhw7cbztkDZoNtXI/usMDEXp6+YgG8eUIDTwcM7lzvn8CxFA0dzOxz4r2gXNWH/tZCGMnfryarMh6TDnGELqTRNa27R+IC6XrCw9iEQIckCREVWT63ZdZjgOS3pJk/QxPkhVnIiqxhC/PE7Iq9FcOC5zZEqDfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iPX8WFIoQ4QXgUD/qR3fD/Finzms7t/FKq4XAi292c=;
 b=CPG7uBJj8OoxtB9rnYmcYctb7p0iCL0gpjwN39IBx7H+0fFA27RoRiwrT2kEArwLQQwTyMsKyrj0iV5FVePeLKPftyXxJ0hKaitewJNHtBnXWeedfi8esl7oAQApcHiIJgp2haHhwb3pChNGLwKcWLy9/1HtvBTe+JvKvxxX6hi3SR89MgFalS6mW5wJRVFwcjEkC2PhrzlMrdxHj+gF5B0ILCz0T42V8FfLiTtN8Id6ZjvH2ZUlZG9FPPFyoGepgkOS8+fLDPqaMN+NZbv4/dtA3nCEj8NbyWr7uvgfNuZ88r4MuIufx6v1Yp2QRuX7iv+y8fxSkQGDUBFGYLSd4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB6580.apcprd03.prod.outlook.com (2603:1096:101:85::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 06:11:50 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 06:11:50 +0000
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
Subject: [PATCH v6 2/5] dt-bindings: net: wireless: brcm4329-fmac: add clock description for AP6275P
Date: Wed, 31 Jul 2024 14:11:29 +0800
Message-Id: <20240731061132.703368-3-jacobe.zang@wesion.com>
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
X-MS-Office365-Filtering-Correlation-Id: 89709e8a-9912-4d8c-7bff-08dcb127aaa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c2zSIvOg8m7XLmDXAWxrAFwgK+nZ4yd+WsRMO7yAH4VkMnzeP7s4ppZKrPGY?=
 =?us-ascii?Q?z5KgcsOEREXxE6MkV1creIvlF0hkkrv5tdBWS6ZeEYDN0NnZnQTXuCO6KC/M?=
 =?us-ascii?Q?qrY2uAIumcgk7mMZNqfljBdrd73Ry1FkPibCrWoDZgefo2aCySx6nOwEjoxy?=
 =?us-ascii?Q?mBtq2xcg7KRLssdiZ0B/E1fa6i9zalyx5DwmGxP79crUgREcgJLo+Qa5zTA6?=
 =?us-ascii?Q?8l4jVFqp3vGpWvhCi2e/ZwRVMffunv6c0f0kPEb/fUWeGAEIfrf9wXDe0GRr?=
 =?us-ascii?Q?Ma+101sDMQeolrH68n8civ2OWgb6YJfhIa+UYTgYwfHX0SkEWGe9UXpdOYVa?=
 =?us-ascii?Q?7/YH60cA00zVHKHL3JgyyoY/+cly/cjnjfme7qGyPxRl3+Z668eIrqrIvhfr?=
 =?us-ascii?Q?cgIRcTSLuN744ryW6THiXuxz5sRfjMEIaEIpszkml4BZcBUY6fePkyipK1x1?=
 =?us-ascii?Q?gPwYjc5ZcFV8QYnKcIyIiXWiPrBosd37J2RnKHbwp5fVE8V/l9Bbxwb932ho?=
 =?us-ascii?Q?PvpYOjdGGWJHiuWyaTufGhpBrUzStAZbjrBWw3FXdeVYjEd7/zceEXAcy+Rw?=
 =?us-ascii?Q?0Cee17wLmLBVw5jYR9gbyM1FNeaNFeo3z3Dx7CQcoSgj6Sgq3bYjDdwBTRpW?=
 =?us-ascii?Q?70KrL3AIzIpFhM2MKukhgP/i4xrb9je53Eyp8dSxaEipwvHZ6ZnW9HNGi/vc?=
 =?us-ascii?Q?71sCO6J+S5PZWiq9TwNIAXF+W//7GwgwBRf9oQ6GYFDcnZNgiNIR2z86B/1O?=
 =?us-ascii?Q?RqcLRQ79cdDcxewcwFqD9RXQCn2iXPovzHMIozMda3N7nmtWtBwMiiVtsDqD?=
 =?us-ascii?Q?9iIoDaOq9aDwWkqBcUSuJZx5RgzkfXG3LsdAf3ODRLJcx2SifHRpqsmRwOgA?=
 =?us-ascii?Q?GqU7e90l41sCHB2XfMUFMnAMSY+Rl0W6Z1diJSkfWFNIbUdhcP+NvTrEFKmA?=
 =?us-ascii?Q?X6XJJc3OFHKYSkO8XaOEllSqaMcRnKVJZUAvcSByWOPhkWnU2n2GCY+yjnEb?=
 =?us-ascii?Q?l/TxmHXaZ3h33YVWDmH+EIt/lLOLMGii0D1KFDNOTPvfjZYYsTDJ3wWLB36w?=
 =?us-ascii?Q?hI+n6eTVmwD63qUVtP89B8DSI/0YEIOH9cdPaCX5ef738VAbHmpsQG/XBgD4?=
 =?us-ascii?Q?rWyoRQC314EZ53wID7TbWnYvHXJpKFRQFIumARpfGL5s+xJ9zd6Ljc5flJcV?=
 =?us-ascii?Q?SxLnRfEOUXkZFZaPQkkw1JQglhzDmOJ6E+h50SZ2uMmbbPFp9BVkxgcBLMCu?=
 =?us-ascii?Q?n36Si7iQQCkzALxcJzuwd+8XLpb8gANcwnZjKuGrFsUR93BOl+LXIn8vecCY?=
 =?us-ascii?Q?GwrkVvhGXxcmbB6AIeO5BPB862yFDa+knqdhPZ4lB/6lFi6GgWW2Jcie6pU/?=
 =?us-ascii?Q?VNV/FLL7OosDoGUIcuvbEZwxaXwyO61OUY5RayFYBSCxiweeVVAFPXt9KFeZ?=
 =?us-ascii?Q?oSThSAN2RM0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yk5CJZlChHUzY+BKA4MgXnCmYp50OmX7ksOe94aXJm6kZsilGu3eXubH1eyG?=
 =?us-ascii?Q?iXQRS7WKg1e+5epO4MECMG81vBVK3fLI61XtfDELDoqGMMFAd5dUCiMKwQyY?=
 =?us-ascii?Q?NxGqo8lUcnPrVp025HYMeGKSnRAiKgj3NmEk7Sxlp2rwGe4glX+XkI7skAlK?=
 =?us-ascii?Q?Tzf1uNB4QNfcJvZN4iTJs4Dr2FX8mg1AmkTJ+jtXN14lH/CNeALxt/LRezxJ?=
 =?us-ascii?Q?s4VjRO1soR56f0oIjD7kr+XrtrM5Ffkdpg3r81LUfVrDAbxnHaprKXwBZfFj?=
 =?us-ascii?Q?DWMqsbhkJGXB5C8ai3zLdWDVTfSxJSqxXyDTwtNw8OD0ZZvQQojoZ1I8sTYl?=
 =?us-ascii?Q?jP6xzPLcQTOR2FzxNtmNxa059UxsJAjI6RLqQq1FPddR+XyvWnfjCqFdm9Hd?=
 =?us-ascii?Q?RD03vlKXwGyij5tuMPevCMnrdpUVp4lpCMtTNHiGCKRzEs9bESQlBsMAzYRk?=
 =?us-ascii?Q?ELsuiuzS6SoZczkmzPQVKEGlsTG+Rffblrvf+Xzp5GMjKMyS4VaZSAsWqzid?=
 =?us-ascii?Q?l6lSSMcbD/U+Za4QTGIPXNIuOLk5ZD840zOTCL7kt+fpNqtVmPGyxZpjkco6?=
 =?us-ascii?Q?a4dLRNjlRrnZuPgUXrVNVbPSVsCljKyZCpyl4ByBlRDbG6hrJ+5wWvC0Abkj?=
 =?us-ascii?Q?/ZNu7F1RT5c9Rp4LhntwYJ67fE4xL8DgkuKlLKqDDQTOBI/Uuqgxuc2QfiTG?=
 =?us-ascii?Q?fNRmPP4FoHBtuXFdguNhdYNgWpOibi1BHzFm2fRiWSdetDwzKhHAF4mpfj+J?=
 =?us-ascii?Q?q3AIwr3dAAnStfIrfV59KUVH5GsEbDpAcnAyoGLAKx/bEE8XqgXgRaW3nmW+?=
 =?us-ascii?Q?Q/GZrODISfJujgnqSYhW6zHyvKEjEox8l38mSsefT98UlmWM4gwAZErvlc9I?=
 =?us-ascii?Q?8L5WFqi21Zzu7z2Gw9QItjd0jlIjgnM8+lUnQdKLu2cSHDrSi+9s4srgfrRH?=
 =?us-ascii?Q?07QqOs5rnFq97jv4fhYu81EaXL2hruuhu4NNE9lUSiH2D6bekXytzEAjqJW9?=
 =?us-ascii?Q?YUvaGxdo3ciurl6AZELG8omffGlmbLqs93dSYjw+owphOVii6BTdSV7SVsMz?=
 =?us-ascii?Q?bcuikBPf508zjqqAuDzxkKUs4UbuPejE1t2XM46PDMFuzu8OJJwLYc7Vpa+A?=
 =?us-ascii?Q?Tf68ZPC6ZQj6hyTBE810diHJhZQTGjnyiIKpCdqACLw30cwxHULY7DRxVLl8?=
 =?us-ascii?Q?xlUB0sz5HOmW6g+TTZlj8RSIqI5VZHx0nRg1IwQYYraqNlyoizq06PL8Mkpg?=
 =?us-ascii?Q?lWlmuhEo9ZSCeWUFtwqBvUj5MV2ONsJZ5RlFG37lOtd2Jc5du98q4UvfakoI?=
 =?us-ascii?Q?lgKsqx5D3vh3py44KE4KBIZtfZFwrLJCHK8YCk48lk6OQ/uUDIqX5MTSSIe2?=
 =?us-ascii?Q?2CapB5WCtIJTLwXi2m+udkl2T0KmnYBz6nfzSX+9RtGyrYaoI5Z5DJZqE++7?=
 =?us-ascii?Q?HGJjUF/QOlkBzup4z4guKSwMu43PkvBwizh2Atr3FlWFfSA/P6/abAiCIZIT?=
 =?us-ascii?Q?qNrPVNRZzVmVD2iQ1BZHI2vKOWVkJ/24fjX+Dfy4Pd+FyasF6vhcY2wQgvWD?=
 =?us-ascii?Q?kV7lAU07TcGY9i+5WYFRxkReR9UXeSU+NqZi0hN+?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89709e8a-9912-4d8c-7bff-08dcb127aaa9
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 06:11:50.6277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDGdw6exA9OMel4Nlbo4e0P6t8b35dYJoW0BvjSDrB2L28iX53SFw5qP9Kocg3x9MivgBP2epsLD05QdvjZE2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6580

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


