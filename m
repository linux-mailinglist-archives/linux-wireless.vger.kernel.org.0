Return-Path: <linux-wireless+bounces-9704-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4438091D055
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 09:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF40F281F0A
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 07:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD1A537E7;
	Sun, 30 Jun 2024 07:36:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2139.outbound.protection.outlook.com [40.107.255.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9771446525;
	Sun, 30 Jun 2024 07:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719732990; cv=fail; b=dB7j6RuLC4gdDuMD8VXOMqV0zPlnGThzhHWffpRMrRlB3xkJF0G60x9jLczTHhrIstNVWEGGB310ivv0UIRqokT7uU4APkD3wzYkife39WJ5nDDxPbV1mvn4PleTo2bxJW+mhHKgC8Kt+DggOz780Dd+JmiG1Xo4WA+D2CHkVz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719732990; c=relaxed/simple;
	bh=abfLORr1AAJ7zcbu5M2UUrrkgjXA26XzO47NmyfhMpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fdMewB13AVgs/kZGvRnpzr+4pS0dBRT8g/NbngbcCtv0Q3pXxOXs8D/3OaIK5U0+QlWE7o5adr1M+zMNueMLy/A0Gitg90WUrpYID/463Y0kLGBJoBQ8qoGtf0JfhoWCZiU5KNyhyRhki4WwrXzsTR13sXwQ9eJowakZbO+00uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KB+Lehwz7AtE03+tVixhQTDuGfZAvcGjCQsj88pEtrsX9j0733CxkZIAS9gQUOfmLzXBlZR0GtkwJX49qPtji9PbtJvCT1Y95p4nBk+no7agA7ejIaWrbkkg+CV075f8Ink035ahvotcFhYHQBGG/auMO80bn2KnXdgmMdL/NOgdr+/2m7W8BM8LU22rXMPJjp4eNqs5ROqrfFXghz31HTmpZnnZ4XlgoMb1RQesxnm7vOqMsl3iVQhcL4kulyFz/0PI1PfnGWiTvde51dTagc7Rf9xlgySDTR1DoMUOckTtlG8uZqocxDSBpMKMC5HvIGU/IonVwEGT+DeoUVxC8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCL3uoJc+1kvFKZoe9LRwyCd+Wq+nmi2fjF5cGL0UXc=;
 b=INGq2zUJGvu35lmSwZcPM+NHhELfBRHRxByneWtZHLlhpc5QEtW/fjIoVpZp/vGNOfuoulrNh2r0UZ8S5Zw6wDeqVZISV4PAFvl2yyyx3ooA6L5m5RU/lzHRJmA2V4Zk/dkk9iy9X2mUYX9jAc4Z2SOuMX6OlbCIOD9AF/lIWNMREm1j5FHPTAdjRocsTDmnDhl9Rfig+3vHXrdLonwe1PC/kGSExY7ChNgeZWUfAEAejN76deStW9PrJvK7tfjSctYhsL9ttNg6e2K/9QYnXVpRcBXohIK/FjgzKTkcq0SFtyTPlB/WJO46IkSoVJ3DEdushFTZZAnwlXk/sjUeWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by PUZPR03MB7234.apcprd03.prod.outlook.com (2603:1096:301:118::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Sun, 30 Jun
 2024 07:36:26 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 07:36:26 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	heiko@sntech.de,
	kvalo@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	conor+dt@kernel.org
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
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v3 2/5] dt-bindings: net: wireless: brcm4329-fmac: add clock description for AP6275P Wi-Fi device
Date: Sun, 30 Jun 2024 15:36:02 +0800
Message-Id: <20240630073605.2164346-3-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240630073605.2164346-1-jacobe.zang@wesion.com>
References: <20240630073605.2164346-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|PUZPR03MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 75266d77-7f93-4f18-fdad-08dc98d75926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oKMkM1Uij02QZFsG4JZVXQUMTfP8WLEbmErEbIYNmnDdqKzEtYRetmyFbErb?=
 =?us-ascii?Q?Rb1DiVB4yyyWhPZIIYOgDYQKBGMmlOeVaha92/rHmoB5C9l+d4N+A1zmG457?=
 =?us-ascii?Q?jZ9TnQtBKb1qmZO9gAC/GfqkQiyCFi+a66N9fvT8OKWAPtluCGS3kyKdjvL5?=
 =?us-ascii?Q?j5RSYPTaqdD3bIudFZ3MGvOGWm1+36/70rQeKdw251NkpUlvKo2Sjs+2PtGT?=
 =?us-ascii?Q?ztKG1XeqJXpAJreNE9em7b5leENdnY7XehupWYSkaZnnbXOPqWAD7MUxiafU?=
 =?us-ascii?Q?VHx7qrgAIW934sTNJMqR78wIUmSY4ACC8uJ/vi1g+TAsfcgIR28h4t3ThXX0?=
 =?us-ascii?Q?jP5SespBJXgq1Kq/bmUnBZe3xpcr02RJ+JTUJ3e9YeVyzQOUG/UUJH7B/1+5?=
 =?us-ascii?Q?JEAZHEwQ4rErnlp5AJRPleseR+vFl16LjnVHPWZOhPCV2V8MjeWqtkX1U9VJ?=
 =?us-ascii?Q?GZVCzExEfSOxpA7ZREDconrWe0ru3Em4IQX9Nsu7RqdkIKJRyU+g+/krobUo?=
 =?us-ascii?Q?PcK48+Vo9LZyNnzGeaakpPkZOtDHIlo0XGL1nElVkkIRL1UVMxoEr8iyK5XQ?=
 =?us-ascii?Q?CVXNkRX3s9gSB9QoMWkLTTbfy5fUe980M++w2Q0MQlEIoTEKpEhJs7Gi+Cmv?=
 =?us-ascii?Q?Yfi1+UW8aYe2BpWej2/XKDKDvkK8paKZzf4vax0B32ks9mT7zRhJujA9CoZS?=
 =?us-ascii?Q?CF+CgGBjJ6V9xkp+yRLTjP96HwsAgk1ddl6zloLjQiKuJ8byPVHrMbb6ok0E?=
 =?us-ascii?Q?J3BCtzvNdZDPeP1t0aryHgVzm5fna4u9qxGHJlLh83Jr1Z8MeteNSgLgHLbf?=
 =?us-ascii?Q?O0E2IGavgOmMGWnWbSJ1eMAkwl8tALfURWZuQgYQkGi/ZEjiHy7xniYhEa11?=
 =?us-ascii?Q?RWE/x7GvsXtZjulHLYvp7jL+gkCNUM1TmyKr5/kNxPs3T2EX26D9cqxwFUrN?=
 =?us-ascii?Q?lTGWceGGRCT+KFAsM2z5DfEt7utiBOuX4o1d4aTotslrHDK+BtNY66x9EEFC?=
 =?us-ascii?Q?XPTS5fA76gIAXWD6YScsvL9zRV+OGNe9i72BrMBg1sGH8XXZTaby7kSmuphH?=
 =?us-ascii?Q?9wBxQAlt6jjy5ID++SHXpakOQEz9aj/YYGdd2xeQxHeJAEFs8H7haSlFnu15?=
 =?us-ascii?Q?IhyN4XiSy1k+PHpIeikK0NtFYwtRmGcPqvPSWIaDp8fwUcbl169Lj7ChKZ9h?=
 =?us-ascii?Q?N3JeDZKHIxp+dymG3PmHFGlzLyLc+grbtmYrKU95mU0iZ8HChYGu6b5XjAAo?=
 =?us-ascii?Q?HQr9gk8nbPKog0UH/+TOHRCLomKrSQxfZLVZzj4UFsF+9Gczbf1Wq2gWsfCe?=
 =?us-ascii?Q?0MEW4EPeNl6j5ItCR+Xj6GQCo4tx2dM0nNW6Fm0kBGXql5k8VTRKio9sSD+u?=
 =?us-ascii?Q?gRD1t2Z885xZq04ZS/WpC0Z8WThDGCvMr8mAtC7m+EdM6xy9fQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y1/8qJZHe+aAo4ZPdwRjT2wEK6p2ZWwx2NWrE3GNOtreeyWXGSJTVuPWeviO?=
 =?us-ascii?Q?BzciZHWPPwvpzmefHs2ML4o3uY6Y449NXUiqkTnnvSn+ZQff8U7Jm0OhZunk?=
 =?us-ascii?Q?q0W4LomBvqSWMC25BDJZMOsDHffGw/awA8VPm4fPhIqG6mpl92VjPmPlKAga?=
 =?us-ascii?Q?8LWQDLIeyZx8AwIeDeY10tXJTf406UBTgfdAMgCrqyTaKSzmZT+USlUXG2XM?=
 =?us-ascii?Q?NxKJlay8/rOA1BBfvgi2CF71MjMYKyWWESWrAxhRvg8rbkXy0eTK5LHNGybG?=
 =?us-ascii?Q?1w75SOL7mJ/01bJ2aMOkc9udyr/pNYdlOy2alDDyg/L0bwy/Ya5qHCk6kGlg?=
 =?us-ascii?Q?AHvPbitU2H3qYAoXmpzzDTkS9paTCVxrp8J4PQVLmRGB5LB+8fqOUnu7OuPw?=
 =?us-ascii?Q?LxWMx34X6EAffTYcvJ8TSL2V5rtu72j5dyKHUQBjebpvUtLUOIwiK9DwMD/T?=
 =?us-ascii?Q?Snz24zpBnKneOPvROCIpOra3o6a5qwuEVRRMq4SDfygOdUGjYg/jYMdgJNKV?=
 =?us-ascii?Q?LMK4NldbwYq/SiCjXzVX2zD3f9QcE64GwTlXrtqF8AmmCVx6v+6qPbIjfdGc?=
 =?us-ascii?Q?Y5e3sswXlwQSwp5/Mtjp9HSgQLnYi+MxAAHgVceIApmsXhPuOJV82GExMXbA?=
 =?us-ascii?Q?ORl7T94QF56AKkEjT8mp4Qj0EtZA+Eu9NsbYmehaUjEuafCFECDH9IztFoFF?=
 =?us-ascii?Q?5vca3yxJC3tgkyqo5HFgW5UWvrYm1iQkHgUxc6rB3qMkjXABbCl1IvBJNbaY?=
 =?us-ascii?Q?WqV/SjvRXogBWeDWUu4mjFYmiIoMaycFf2gpJ1aJOboULK9uscN9eMfNht+r?=
 =?us-ascii?Q?1UHQeeFy2jMt4AT6fPH7U497hyNxMuJBcUVlIc+cvS9H9hVNLDjcWYgYzp8S?=
 =?us-ascii?Q?eZVae8LMoghFA8d4K5icM0ayXK0Jq56YjFDY3xdIVxjztLbZP0wJnb+GXbPZ?=
 =?us-ascii?Q?/tYPWHOKBrLRjiMOD0ml9QKKw27NtqcHsQPHqmxgxmgJGht8lva4L+wrTkvo?=
 =?us-ascii?Q?WZ0QOQkVuykFWlH5u9RWq6t28JmAlnAUF/B9QvjxV6Rxem44kXHc8j12cQyL?=
 =?us-ascii?Q?XZtFgFc3Qzv8MGnWWHthplAD2lKstakn/VHJ8kC38MWfMP/ZikmXrubuvz6v?=
 =?us-ascii?Q?6udFB96utgsHhU3UcRSyByX1tR10Sa/EEKSGZcVphk3OwzWV8rmrJmvBv9Ga?=
 =?us-ascii?Q?2tEsaYwKhp2KjveNUGjf9I9u6GVZ6Vmgi5KIPbutmnVA9HSSm7Ql53ccVSQM?=
 =?us-ascii?Q?XxBH9L8H1ZWEl0rNhTLK3E+Lsy67MUodpd6RgaPO0Xv/XrmCsOJPEd1JKRsy?=
 =?us-ascii?Q?hgH/CoDKrRPdTOufm3+LKWFGH8qpiUQX2jJIA7fsODAZzXB8NUyHDwFuZiex?=
 =?us-ascii?Q?VicUr1mrA7H+CqAurumxqvDdwkiPbPn/mOTQUt+7yg2CklSa7IUimRqgf5VS?=
 =?us-ascii?Q?gT5tOuNhhEKnFjweqCgvYkbEXIbMqSAdgc+r/xdWlhBUw0T6VqiUvsnDWRwH?=
 =?us-ascii?Q?mL5u5Vpsf9q72funiI3MNUOzzUmkLPD+CD5mWHhPZC/i/Kav1wDHlZmLwitr?=
 =?us-ascii?Q?8OJ+8Zz2+anm2G1InbKqPBJkBxEqCotFxMTKfJwt?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75266d77-7f93-4f18-fdad-08dc98d75926
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 07:36:26.2760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ospafC2fBFrCUGKmrSD9QHa6Gr3qBfcEgeXfUmL1DxmYeHi2yoG6hZF7BUkK60rx3NytlY0V4qUO5y1mL/i9jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7234

Add clocks and clock-names for brcm4329-fmac.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index 2c2093c77ec9a..f542b60e44dc4 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -122,6 +122,14 @@ properties:
       NVRAM. This would normally be filled in by the bootloader from platform
       configuration data.
 
+  clocks:
+    items:
+      - description: Wi-Fi RTC clock
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


