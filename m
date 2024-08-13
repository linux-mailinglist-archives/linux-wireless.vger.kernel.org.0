Return-Path: <linux-wireless+bounces-11336-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B1794FF8E
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 10:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112731C22500
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 08:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2216B176FA4;
	Tue, 13 Aug 2024 08:20:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2129.outbound.protection.outlook.com [40.107.255.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877C513BC38;
	Tue, 13 Aug 2024 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537233; cv=fail; b=bupa5AbHYm6in1GxNFC3N8hqoffGlQDcCrnsO1FJlwR1GfBIvKFpojYddFQKiI0qbQ44QCU1zywDG+x4j0OJjK+rsrZ3OGCSefA+MS+OnZhoqOlV7BkAnwtF0xaU00ejdGS/ZNJQ4NXfsNWaDkTAuFaDly2jSm0+zrJ5EHYR3n4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537233; c=relaxed/simple;
	bh=uyVPq0vuS+FMU0odfnlfw0F2eZnLPgwjnpAdPSqAp68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uTz6/IR782lYhCF1MEcXJIisVJUIXmLorxNjua/6OvBJZnQhz+YGs4cGxP/HyU7l50fiwsrkJ8qCrpvjMW7E3PWGbgGNMMcMAgBIDBz4uWhudcX3wzViqcYowksl2eDli5MGuNO97u16cKf0h0VmdRs6wmCAdQVzgHM6LolbBN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWtKJqTm2qDakxWV1ZuYkbb0qvBtEQmRzMSTdpQkIaY8PiIlHdke66mA+DZ91x2bo/jqeeZIi05372NHcELxIt6dUlOUmm/pWdTPH5FDlcKSA2Y5nhM99yi4QckOwKZOvMb3x75qnZ+Rd2y9h+D1Dwcu09p/pWpNaQPsfBriRS54hM0MHY8k9ecIptKL85ifwSRZb/M0rk3Ok2fW9gxjZOMH+CChaFE2L5cnTHnBlrhMNh6enZrx0Mp1uyZX6pVKk68KDhwL+fZYLdLkFDyOhmSK0qyt2lRF8rKOOnfTUTI4UIbbk0Qug2w5COaYiSeMUQ6gTahBvYeQZ8dQzSe7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iPX8WFIoQ4QXgUD/qR3fD/Finzms7t/FKq4XAi292c=;
 b=vnynV3dd5JDSHw7N27rDJVN3gwow5QUgL3TCsbzkxztWiRkHDHXSUkFswzlVY+VC9xtlEw00BekgpTHtUlh2V9zIUkhOIY4goH9rV5fe3A0nQjwj6PjZcNafqY9x0j+u1xwe2XlBv6Q54S1mXnCA/oAs9M+uYkL0jmocfsNQHRPv5M+4xP+OPsMilEBaT7dAtO3eb+mOi5xekwSm37AbtyuvPYFGUiKDq91SlLz5UsXFVHKPPtbOroURTG+CsvdgNIXNDFLlEKTJBdarR6BWwAhNgoGyJtLCDLuz6Le9hca+YCv5FRNKwsAoKMhc+ZFjQh3fXWGECfDu1yovNMXX1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TY0PR03MB8198.apcprd03.prod.outlook.com (2603:1096:405:1b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 08:20:26 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 08:20:26 +0000
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
	Jacobe Zang <jacobe.zang@wesion.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v10 2/5] dt-bindings: net: wireless: brcm4329-fmac: add clock description for AP6275P
Date: Tue, 13 Aug 2024 16:20:04 +0800
Message-Id: <20240813082007.2625841-3-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813082007.2625841-1-jacobe.zang@wesion.com>
References: <20240813082007.2625841-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0309.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::10) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TY0PR03MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b628465-0984-404e-78ec-08dcbb70c8c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y2h5FbGouLEupirRCbmtTUOnHScz1xqwW1/vsoiekdWO16LxpsBaZiY4b/ug?=
 =?us-ascii?Q?49K83iHk4FkjLoJFPGnBb+2czS+4vx5wlzbUmpPTwzeeHKqGJ/GSSlIqevm5?=
 =?us-ascii?Q?+LfWP7TbULKsl+3hxppwmKWDR4dVnnVb2AvBuB+xVgI/iRqWw23xAwFg+iDV?=
 =?us-ascii?Q?Lll945mKJR5gmlHdyRlz9RouSGfxKh8ZicwSCgRoaafMGa0lbveki2nhEOhs?=
 =?us-ascii?Q?cpbthmpCaPJrrxqg6H3QQYX5sDSIrBYGZAxx90pvpRQG864dpnm59+snGZbd?=
 =?us-ascii?Q?RsOajGa8GqYQNXWw0WUOtWCpvvB5u6Ku+PtYK9m0G3wRUs+roKWyKCpvlIRT?=
 =?us-ascii?Q?iZhyaOJdB5N+gbn700Y8OjOFZVs4h2Ge0zsgMP8WjPcz6xntb0NcGaHbFtRE?=
 =?us-ascii?Q?aS3ZJwKCGLCl3oP+38srAxZzonQRDv1EZZzaFEHDp3prKukaJByvkDaWgKcE?=
 =?us-ascii?Q?0YnbdnIQg+FzLzaOCYbcHn5yI8tKRRGVGIJ7OMC2p+Sf6kdSp4pVW8ARuwcq?=
 =?us-ascii?Q?MXv+F0Tx91OSKKG4IMh+mzRhi+c2YsYV1uWoURWnLN9EoKQaGLWlaRIKeoiV?=
 =?us-ascii?Q?vSgGCa8+ESDAU9eqnuERtKeFSRPc6LdklxMoU1OPrA2LDAu/JzEV1MACM3zh?=
 =?us-ascii?Q?I61R2E5ZlvbbRgcmsUf7vWIhm6QG2kmlKblxWhnRXGEI5QdRx4gFg4Ro8tfF?=
 =?us-ascii?Q?m1nTOy9s0Llijon7t6gze78eO/FHOE9SV2hmvQ2LYn5+4CH7wA2L/uRXfbGm?=
 =?us-ascii?Q?se0cW7pOZWSP5o15CEIMm82gr+ZX+tWLRi5mWwfTDJnaOfNRHE6hRU30pFI3?=
 =?us-ascii?Q?bsi/idVrhABWnaYvXWUvzYSl8vJv9g6bKutXBmLHcwiABTfuSCqEiDlbnQWH?=
 =?us-ascii?Q?wXrgxeaYOAz3FdO0cNbqchL3A4LYom0bucMIkM7u+T9N5g66oHT2zpjMrs02?=
 =?us-ascii?Q?uMqyz/szhqAdFAJDE+Bte2MMAQgC8qFVm5iZb+eVVpShnWDiCJnsqSLazTvy?=
 =?us-ascii?Q?6ZLzy8yNewiwQNdthsuhyqvhWD7P8+1z0MNy8pNLUw932LOOhFcd5BcufLEe?=
 =?us-ascii?Q?VqvNCqXR8bai+VE2bsCn5zezSnd5xiLeVUgo9XFA0XLVKnTGAk874QtsT2wk?=
 =?us-ascii?Q?lKcD7RbBsddyaPPzuD5PJVBrE4Ze6zblZQHmg5HUxBGqgIQgf2hy7xHtQHzE?=
 =?us-ascii?Q?XY1SeZzXYUBya9Nkxzu1NCw1nKtAPI87ZUjeBf7AIf3aB9J/boWFbwuXPwdy?=
 =?us-ascii?Q?IIQZTfT6qI1YZblFJBtMik6GvdvMd2RwMHFzZrJFNq0vXnCd434FYI4sXdeS?=
 =?us-ascii?Q?oYhOSjpuv8to+Jk05mE4Gb86yPOgz5cSRLPgyUGiO9ePaZSUewqeElAWtUVR?=
 =?us-ascii?Q?ncaW6eY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F3jHsHwNpUwVAlFYx6niqzpYVye5p6xLzieopWSgkYivBvXX/VjFZTAj5Pq5?=
 =?us-ascii?Q?7IY3aQdAYoM+rvUxczHJFX6HR0UxoTAMUD80S7UZ8Nhyv23LCbrFYf3gSkGt?=
 =?us-ascii?Q?TYlZaZ6oMKmgW8M2EtpK7GwGQRg9ZsKK7bs4su+SWctkc/dQuIZL0xgOBzWZ?=
 =?us-ascii?Q?XyTCnGJoOyo4Nx0PhviqAlcd25F1IKdbr6XXxCxWE7qc6M/ZuuGP4z1yrkuz?=
 =?us-ascii?Q?OdafiSA/gS8gBXLdXbAQa+92g1OXXbtEsHI0XtAB1BHpJ74WXS7+CWE4PAOn?=
 =?us-ascii?Q?PuG0LCc+pVhJen8kD+wdUTfcLpHi6NL/7p3vsK6QFcLZqbbRESw6/gF0SFT0?=
 =?us-ascii?Q?qxTdD9l7pizPqerE5PA3c7IeizgP3AxS1mv9P7jmF5JxYYztAAlvfbILwuoq?=
 =?us-ascii?Q?0EWsHe8RfeVXMKDQqL1/GkvyJYHwjYYVMtSyjP9wkXn69Hb/leqBy4hkS8Bs?=
 =?us-ascii?Q?z+E5PbN8GexRh+MC22rbjhnaEuT+3uH2ZFLn60hObYwcjf5A9srkdm12I6wn?=
 =?us-ascii?Q?oSSp13dEfPyt5Y4x7YBOox35lrHoaD//iTDJogCyZa0Rq5W/Snn5xhmc1VNN?=
 =?us-ascii?Q?LrMnypoNVBciy9SHDgHwyAp4nDiHZ2fGgM5nEzEy6nVrqU1oSjYJOrvtSWtZ?=
 =?us-ascii?Q?+ZdyI++lXa4tRxO6Oq0hdgxqBNMa87XZpdlyNiZkaUzw6fFKJBtWnRgze01L?=
 =?us-ascii?Q?6MgWGZf4ZETp6OS4zKCwxAlG0qX75nFY5mk+NByPOCtfK2SbUn157DAkhMav?=
 =?us-ascii?Q?S+F1jPNZEJvG4AjtR38H0ehTmYyk97wWUKg3T9wLzsEeuk9vlbyod97xamm4?=
 =?us-ascii?Q?+aO2JMmpL2KI8AHRCzI55LOXbBLG6cfSMu+rkCDY1aQLvxLbwnv6Exyj9y8u?=
 =?us-ascii?Q?oEXVEaL2XfGDh9HTG7MjKgFUHLLwPeswCBB4hO4ZSDfuJj9zc0hPldmmUrb/?=
 =?us-ascii?Q?woCP1OFCDZpDnbdDOE0li0EemGa5s1VJ68MNqtIUBxMoemXLdQrwS3TfWuQs?=
 =?us-ascii?Q?0mh6lB+QxoGQ+i5TruoyzZqqdnuRS2lkX1pHsDCThZFipMVEJSVgF1TkAYh8?=
 =?us-ascii?Q?h1QhSvOTRIv5SfQCHnyHczuiJRn4LmLoPK/0nWJh0tULbLtBWMKoxKO8RwNU?=
 =?us-ascii?Q?TpvrnvNSREwsxbBLyKu0ZR140hz29aCLvo1wgCckda0kA/0nWmot/a2ZuiR/?=
 =?us-ascii?Q?enTEcaFoHeY4NAGVA89aFuI0Faht1EP6AbW1kw3FVF1/RFbGnDE0bd75l461?=
 =?us-ascii?Q?UUbGkXjIpsoe4D6ruz/UQaQSxtbC6u53YN/UyRmjswzvSQRm7mq6TA8xK6th?=
 =?us-ascii?Q?+sqiYa0lKV85I8+MIyMa0COokwnx83ct0smEdHIdp1/AqP+7FhkL28GlX7MG?=
 =?us-ascii?Q?FRtSA2xeasbts+jnGkCuf9OZXGSf7yPm4oNTBKPdJaXc5hSdSBc2IvzWoBPv?=
 =?us-ascii?Q?2JZBroj+dkLWmUNIY93zI8Tkn91hnvBdW4PMPzvl7gPCCJqgHB41ofVAUum0?=
 =?us-ascii?Q?KLZfllsntqY6UyXhiusHkjaiehqxir3amySLkq/TyZ6nFsTjSih+cr3Ts0l8?=
 =?us-ascii?Q?bisnrMBzTC/dTDX0jhoWes9kakzu1ujKCN4q2zFA?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b628465-0984-404e-78ec-08dcbb70c8c3
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 08:20:26.0367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1Gxo1xNJfXZCcBeiM5y+IYi2Pz0UTShhv//OA41DrhK8sKYq4jIhOS5WCPoEMp7vHfWfdjMpN2paeFG6nS+sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8198

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


