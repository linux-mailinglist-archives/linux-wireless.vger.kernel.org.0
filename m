Return-Path: <linux-wireless+bounces-11323-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 951EF94F7A8
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 21:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D38A1F21E45
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 19:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E2E191F7F;
	Mon, 12 Aug 2024 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="agCVmUiN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013014.outbound.protection.outlook.com [52.101.67.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94DC197A6E;
	Mon, 12 Aug 2024 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723491899; cv=fail; b=uJOyIPiP/9jatvuNhqkZ3M7A780Sf8IYKdf9rc44jnWtryidNOzaO1guRRiU8js9gvUW3Li9YJnmPnEqljEO0Ifyt31IJ2bYjXLGl9oJeeZ4FdLc4yIPwsY37naYVE/DCXgjQvebTS7oyR7qXFsiAFa6QBV3DuwLANNvm6YYKd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723491899; c=relaxed/simple;
	bh=FyNYeue2NBEyDnSV21qazpQxH+dm5xgXVTjGIPC1GBI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bK/WfeKbUycfJ8FXFiFdRQbhJf1xtcqZJru8onNCroy/enFXQEiRj3VMc1SlpGdsVv2OjCKIdARcEHCyyHQ6KE9Mt7H5VY71Y9A6DIqQNcQdoQ70ntj8QHBmaQveOgGj6xTH/VSOaopO3WnLmAJBqPFeRyaVeQeSn07ekrYZoYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=agCVmUiN; arc=fail smtp.client-ip=52.101.67.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEYSGy5EdlK/aoJAgsmHsWtzqA9+BVcYPSJ22pihalC6O0x/IiUNIXjw7OKG8/cQaCLxQnGOKTrGaA7QjwtgN7/v3Uqk1IN9fsPBYPyEaFWoG2XqsLfuHo6GWtOckua7U8zHZQgOJUKuX3DLsRLai/BMeOl8u8urCCMeLwoaJZJx9WPgOC0MoJ6MGlTNHkJBdcFpzJv1HoacXihpo4TfQc+WIj2v16xrYjUpGwm/79QDigTqwRFmHx6ZyRYwL8KAjGn2mlEmFiVTvqzRVkA0ycm7xC/iiKyT+ZAsTcjG8wioibcwH49fAqJXOIsjRzZ/Z6OO2Q496Z7Zwa9OGoqgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u37jOf7/5t+kGnwAdF2RH4q89t0ioTNKRRcCJ/2046Q=;
 b=WUPVaalfAFndSZWRBnAv/EG74a+Gvm43Phdlh/7YJ7qVDjWYfg7OAqMdKTy5HD6wPjm0TxzOsRASaGeyjuK0v0hN+mjCdYWHhP2FC548ak/SUz5GiMRh3m4c7rVE5a+H8aYwo0LUmX4aOUbTVt/dQ97s53UBNywnYfoYWHb4+7U7tTdZJHIERJ/O32lt9eRajcPUXax9eBJnsVu51IGQsVvznuyzj2DFhVPjsJnnJ2K4NkCuwQvSh8j5iozXW5j/sBcB+tWVR/mKuc9Z6lNrv2ROaMi+PPTSUrDvc/RYO9f/pOtIGgSXoWvqO8OYLbz9S9VYnTLr5J+BxlVRmMzSew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u37jOf7/5t+kGnwAdF2RH4q89t0ioTNKRRcCJ/2046Q=;
 b=agCVmUiNtDYx/ipWvI5Rcws2wReU0teXPSsFBOqbCyhjaWtjMExbinN3DDjEUJOzWDuji94brJVECL30/DKlVPp3e7vo2mpZClyeAGoGIX+JLbaWEsU0iJazGkelB8RumyU62tYFuLBA4yyPOGYvBpUG5CObtpPBqo+GungnrJWIRUB7hm0TN56wcLgi6mlJAH6x4rtUjnKWV3rLJv4skUHLHQCmp33Tl5t7QP0v66M5Y6PsztcxL3K64dBdsWhSh/LG6kXjJ4LZgYGQG9su1+nWoQvLmiR82PrZrDLZhQLvBE6hMQfSAzzeFwGW/t3il/ivRXXHe2P4Z0N44NBonA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB11031.eurprd04.prod.outlook.com (2603:10a6:10:592::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Mon, 12 Aug
 2024 19:44:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 19:44:54 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Kalle Valo <kvalo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-wireless@vger.kernel.org (open list:NETWORKING DRIVERS (WIRELESS)),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v1 1/1] dt-bindings: net: wireless: convert marvel-8xxx.txt to yaml format
Date: Mon, 12 Aug 2024 15:44:40 -0400
Message-Id: <20240812194441.3826789-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:a03:217::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB11031:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a3427a-41d7-4606-31d1-08dcbb073d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|1800799024|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9oInzmqgLZtP9+txyAmmLaXdxlXPKF7IUlJLju77AF0WmSIZH8vOwOFjDLeN?=
 =?us-ascii?Q?lnQnENWdKrR6Q1tIXuV0snmzVrqV/06NPwJMTQNnUhagNuadCx2YP6HSTeod?=
 =?us-ascii?Q?zpPKuo0bYah9b35cMRDMVIpl+MxDpHuRN2DIwZxDr2c0HqtG20BG+c5J6gpk?=
 =?us-ascii?Q?G9GlBvq5iuCfV6TtlWk04/MCASUf4/EvCaO74rYsTr3gY+bGUGD+cWORT5MR?=
 =?us-ascii?Q?c5l4IlYI6Jw3aCcIQggcdCzyYpRP8LRn+xXIJl2CREK/QPf+oJ3QIjG4tcxD?=
 =?us-ascii?Q?YFCAEptx86gqAcE+GNFCyCGXRpNcuWDVrQwi96mMKEiUzHI5TNzqwZItnSmq?=
 =?us-ascii?Q?obiaiAgbcbrU8pFEvxaKqGDQT67kf0J8BvLZ0WBBww6N/UHd9p4BPfRmS9IW?=
 =?us-ascii?Q?qyFGNroo3qJPQyK+lEyOfpbpQbXHjq53p8yTdBRebX1N+9qDKIFNQRP3IWs+?=
 =?us-ascii?Q?2ai3VFkAkHKw53gufNsx0yf9x24ZgIeUZt1snUb6kOwmBJCn5MlVuZwqMIt+?=
 =?us-ascii?Q?4F3MS5UqY4xhvFim/bLm/i1ws1JxEGVHT5iOMQONv9LbMoPTDU19CtqgOWZY?=
 =?us-ascii?Q?1HdkxjBnOfWnmHTUCyZjMwzEcL5XR6RNn3PwxaN/5YJpyf3DyJ75PZoeEXus?=
 =?us-ascii?Q?YFOkU1sB73yxqXjXeGessW50I4r2ygCTu/LvPG3j0rLJD1k5rkzbxg1xOayU?=
 =?us-ascii?Q?u2EYOHowykJN/15nhzzveLKe0FONROqX1Itth5RVzgZTkEJO7KCVoP92q5no?=
 =?us-ascii?Q?jCDbe8Yjgm72/qiP4MeUcaOHSIxQRU5K3qmEpg37Yjm+Os6RMepkAkHcVDpM?=
 =?us-ascii?Q?kLFgrqVwC3AAIEKNtGHJorTSiIKQntfotDfQv2UHfNN5VR9+JRm5ohDk4FcQ?=
 =?us-ascii?Q?Ur7KODvA/7GG2779L2OioYycZ/pOBswyPJkplXc87LznC5LR9HdhOHPNVVwP?=
 =?us-ascii?Q?9ymE+Qoc13wyQXWTbyanIweul8TkvqOkHcxWRR0ZX4MQ82OorfJeKMXuifrO?=
 =?us-ascii?Q?TVuWCB1wf/D6EdDOjWsDEpw6ULYWjd2AhWRsQfcExoC8kYWjv9oyOY+DoETL?=
 =?us-ascii?Q?mQEpmZTeyxTSU1JWaKY2dtPh7S9RODn0nLKxN4IB80sMrMgkrMRchfkXPXaa?=
 =?us-ascii?Q?l1u6Z4Yl5hUqQs+enFPqIKLSUt1LJ4n+sPpv0Phbp8LimXeC3HTI0elwg2jl?=
 =?us-ascii?Q?c7tNeD0tneIoUbK7D1YgwTcZY1JEi03amDKHsVcwJKuVkOKXrQUUuBwDYoyw?=
 =?us-ascii?Q?NAdXJVeXvt7a5dlnbIIpfKc+sUhdEELe0roAJuRmndUEFOqYUqrzhOotoIlY?=
 =?us-ascii?Q?HAoRkcNpi4OZxExUvgQ4+v4DvnH8YVF8gkjtxPgJl7j2nnOPFJqkCn3Rzxja?=
 =?us-ascii?Q?+o2bng0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(1800799024)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AhTdZ6oF7ZEUokMq9qV6pTv7h/mw9KdR4Oc07FjX17l4WCqHGx0pZWCtjux0?=
 =?us-ascii?Q?BBmshIY9vw4j+tRrVTdm2L3wky5z2F4lL0sDM9w9znPdjCtCHzg+98FXWtj+?=
 =?us-ascii?Q?C64A2hkg55Tx1Ry5vLc4y5E5AGw2OtXKPVTqAD7vOHVwS8Kveteki7zA60Dw?=
 =?us-ascii?Q?Z9WA4RDyK5HxBoBcgCsoBeSKrVzLTL5g/IprrzKh737WcQE6ZQj92+l7tQj7?=
 =?us-ascii?Q?ah3kgClCRSeWDHqlCWavmjqfI+kO+q5OprPhPqiBc9VeYdbkWo6epgOPs09w?=
 =?us-ascii?Q?obI/IswT+QmqtCpWzAAF334GlP4aDWGO5eJxQwFR8MWSutrDv+zkGbskkC8T?=
 =?us-ascii?Q?k3Ok/xM+Mo1LnL+VALJ6B6DJDJmwRfnRg7oYuZPQTLvUKSc/M7yostiR7TB7?=
 =?us-ascii?Q?RVj7TLUM3ntDs2qIqbgd1/MDaCbgpd8mcsmix8X9VYWWRJDXmg+QqMjjQfJp?=
 =?us-ascii?Q?3WCuyPUtGrBmTeu+qDONVSqExbiqUGMOpJ5XlKffJGTHWTb07R+1SX4Vp/E3?=
 =?us-ascii?Q?5f2SyCZj+GRQa3eFqrIPvit42I+yGY4Yp9LOGpFW0D83Ng8JkTfsCzPpBYrj?=
 =?us-ascii?Q?QeR0CY0TmfevZIPD0fB01jNCXpz3iPEtZiLVuwt6F973a39SvXXHJ5fG9DC+?=
 =?us-ascii?Q?MprrKsi9qNt+AussA0viDDRR/RNSOFHpGAo2tyw/2VkB4CsGn01vuLNgGnmC?=
 =?us-ascii?Q?4YoKdXwjcRstBl01eAZJx33Xva7CsbhDUuaeDTdLeC9VzbWKWgxoFPiAgwBo?=
 =?us-ascii?Q?iv5QtWxyWnKqObwmXm6KgWTNte3veOdoky/wjmfowS8yJWbU7/6J0CFJwVpS?=
 =?us-ascii?Q?kdYILQkIrbT1DIs930txcovoIMnX3NZvxMMTl6ylIFXOtgaqKGIwaFQat6G+?=
 =?us-ascii?Q?W3saPoYyxp0SFGcP9W3egTsKFiJ+nDTyGkI/hzrYkdO0b94qXplCJ7i6hDkP?=
 =?us-ascii?Q?Pro5JG+gF28agV/6ENRSZdRIbZBtpdfrfd+yNXtwr5KNYgljGpviEpj/hRCq?=
 =?us-ascii?Q?xFHidWt0+iqxVPKwm+1L8Pzkl7TqGHKYGICmj0CBLPVRvzXjZjjUbfHkRIxf?=
 =?us-ascii?Q?pJaCVb0qGKsI4FpgGAb8pPWPXrSMbxbyEe4UHfCj1kv30I9sXfAE/QaWoKET?=
 =?us-ascii?Q?y60BpxNPOjtaAuYhp3SVTK0QBDxuyA7eCKS16f6LrIWjWxwDyRtCWrMs09TA?=
 =?us-ascii?Q?/xpBtplq2ZYqoz2j1J+/FBIZYduPDuItCgo/4E2IboqMmtWMZltj9hhhWGCF?=
 =?us-ascii?Q?iVElvZrmhaSTrmzpAvdW6TDczlVXJBLaLxlHx6B2CT9bmbxD8ygCv7757aeV?=
 =?us-ascii?Q?2cvmp6VkWqNeXtRDV7DIQp642yo5VSzDlfCEpNi31CzmIAI0jrW3WsPi1SpG?=
 =?us-ascii?Q?fQaLrbZUCZ5fTwabAHAhBNuMbLQXEKoO8WvlaHjMgOksOdOp+LAbeWaNsP12?=
 =?us-ascii?Q?a1BBliHY3c9BRJe/3dQkGpd/uXQUDR/Rnjh7OhwVwciw+9BPcES3p2lnm/jl?=
 =?us-ascii?Q?9q7STt/aRJSnCBWXzmTeSWIvlVrWfUfGiOUpvaj3t4Xk5WRPGXzU9kl45qs8?=
 =?us-ascii?Q?Hubvp/Mza13qnKJ6fqk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a3427a-41d7-4606-31d1-08dcbb073d4a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 19:44:54.8488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRmD/okorrIMWV/lER7ns/HG1bG/6wmGctwbTMidneUKgZZbm/J0nsA3HvJzBC0InQtZ0meJ9WJNf2vCZAQMKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11031

Convert binding doc marvel-8xxx.txt to yaml format.
Additional change:
- Remove marvell,caldata_00_txpwrlimit_2g_cfg_set in example.
- Remove mmc related property in example.

Fix below warning:
arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dtb: /soc@0/bus@30800000/mmc@30b40000/wifi@1:
failed to match any schema with compatible: ['marvell,sd8997']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/net/wireless/marvell,8xxx.yaml   | 96 +++++++++++++++++++
 .../bindings/net/wireless/marvell-8xxx.txt    | 70 --------------
 2 files changed, 96 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/marvell,8xxx.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt

diff --git a/Documentation/devicetree/bindings/net/wireless/marvell,8xxx.yaml b/Documentation/devicetree/bindings/net/wireless/marvell,8xxx.yaml
new file mode 100644
index 0000000000000..7b4927cdb7a01
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/marvell,8xxx.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/marvell,8xxx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell 8787/8897/8978/8997 (sd8787/sd8897/sd8978/sd8997/pcie8997) SDIO/PCIE devices
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description:
+  This node provides properties for controlling the Marvell SDIO/PCIE wireless device.
+  The node is expected to be specified as a child node to the SDIO/PCIE controller that
+  connects the device to the system.
+
+properties:
+  compatible:
+    enum:
+      - marvell,sd8787
+      - marvell,sd8897
+      - marvell,sd8978
+      - marvell,sd8997
+      - nxp,iw416
+      - pci11ab,2b42
+      - pci1b4b,2b42
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  marvell,caldata-txpwrlimit-2g:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: calibration data
+    maxItems: 566
+
+  marvell,caldata-txpwrlimit-5g-sub0:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: calibration data
+    maxItems: 502
+
+  marvell,caldata-txpwrlimit-5g-sub1:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: calibration data
+    maxItems: 688
+
+  marvell,caldata-txpwrlimit-5g-sub2:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: calibration data
+    maxItems: 750
+
+  marvell,caldata-txpwrlimit-5g-sub3:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: calibration data
+    maxItems: 502
+
+  marvell,wakeup-pin:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      a wakeup pin number of wifi chip which will be configured
+      to firmware. Firmware will wakeup the host using this pin
+      during suspend/resume.
+
+  vmmc-supply:
+    description: a phandle of a regulator, supplying VCC to the card
+
+  mmc-pwrseq:
+    description:
+      phandle to the MMC power sequence node. See "mmc-pwrseq-*"
+      for documentation of MMC power sequence bindings.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    mmc {
+         #address-cells = <1>;
+         #size-cells = <0>;
+
+         wifi@1 {
+             compatible = "marvell,sd8897";
+             reg = <1>;
+             interrupt-parent = <&pio>;
+             interrupts = <38 IRQ_TYPE_LEVEL_LOW>;
+             marvell,wakeup-pin = <3>;
+        };
+    };
+
diff --git a/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt b/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
deleted file mode 100644
index cdc303caf5f45..0000000000000
--- a/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
+++ /dev/null
@@ -1,70 +0,0 @@
-Marvell 8787/8897/8978/8997 (sd8787/sd8897/sd8978/sd8997/pcie8997) SDIO/PCIE devices
-------
-
-This node provides properties for controlling the Marvell SDIO/PCIE wireless device.
-The node is expected to be specified as a child node to the SDIO/PCIE controller that
-connects the device to the system.
-
-Required properties:
-
-  - compatible : should be one of the following:
-	* "marvell,sd8787"
-	* "marvell,sd8897"
-	* "marvell,sd8978"
-	* "marvell,sd8997"
-	* "nxp,iw416"
-	* "pci11ab,2b42"
-	* "pci1b4b,2b42"
-
-Optional properties:
-
-  - marvell,caldata* : A series of properties with marvell,caldata prefix,
-		      represent calibration data downloaded to the device during
-		      initialization. This is an array of unsigned 8-bit values.
-		      the properties should follow below property name and
-		      corresponding array length:
-	"marvell,caldata-txpwrlimit-2g" (length = 566).
-	"marvell,caldata-txpwrlimit-5g-sub0" (length = 502).
-	"marvell,caldata-txpwrlimit-5g-sub1" (length = 688).
-	"marvell,caldata-txpwrlimit-5g-sub2" (length = 750).
-	"marvell,caldata-txpwrlimit-5g-sub3" (length = 502).
-  - marvell,wakeup-pin : a wakeup pin number of wifi chip which will be configured
-		      to firmware. Firmware will wakeup the host using this pin
-		      during suspend/resume.
-  - interrupts : interrupt pin number to the cpu. driver will request an irq based on
-		 this interrupt number. during system suspend, the irq will be enabled
-		 so that the wifi chip can wakeup host platform under certain condition.
-		 during system resume, the irq will be disabled to make sure
-		 unnecessary interrupt is not received.
-  - vmmc-supply: a phandle of a regulator, supplying VCC to the card
-  - mmc-pwrseq:  phandle to the MMC power sequence node. See "mmc-pwrseq-*"
-		 for documentation of MMC power sequence bindings.
-
-Example:
-
-Tx power limit calibration data is configured in below example.
-The calibration data is an array of unsigned values, the length
-can vary between hw versions.
-IRQ pin 38 is used as system wakeup source interrupt. wakeup pin 3 is configured
-so that firmware can wakeup host using this device side pin.
-
-&mmc3 {
-	vmmc-supply = <&wlan_en_reg>;
-	mmc-pwrseq = <&wifi_pwrseq>;
-	bus-width = <4>;
-	cap-power-off-card;
-	keep-power-in-suspend;
-
-	#address-cells = <1>;
-	#size-cells = <0>;
-	mwifiex: wifi@1 {
-		compatible = "marvell,sd8897";
-		reg = <1>;
-		interrupt-parent = <&pio>;
-		interrupts = <38 IRQ_TYPE_LEVEL_LOW>;
-
-		marvell,caldata_00_txpwrlimit_2g_cfg_set = /bits/ 8 <
-	0x01 0x00 0x06 0x00 0x08 0x02 0x89 0x01>;
-		marvell,wakeup-pin = <3>;
-	};
-};
-- 
2.34.1


