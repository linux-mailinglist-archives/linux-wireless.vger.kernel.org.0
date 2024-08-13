Return-Path: <linux-wireless+bounces-11337-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C8594FF95
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 10:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E37D3B23F68
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 08:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D358617CA12;
	Tue, 13 Aug 2024 08:20:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2129.outbound.protection.outlook.com [40.107.255.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4511317B433;
	Tue, 13 Aug 2024 08:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537234; cv=fail; b=hV0cJ1/ckejwQ5AE/ISHB0LXH9UHF6Wf9+noIE/r993gdEYHYftB+r9zlQHjP712APblaXJdXFR8ypjyoeMdoRUg/WEU1w+6IC23zSTTaqNeH3OHc0GTDUrB9XUdHOe2fYKkR1utb8hQ3nreCrcz8qjpje5tX+rFu0e8X8/SyPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537234; c=relaxed/simple;
	bh=N/RtFVenj3Z7IEiCR7u1dVjyT5hCGTgxAcs3H2GIlSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G3qHGUGx7+NQlcKhdWAVAiR0ED86nXzGOj4G2plRYo/axxAEpTCLV0vzYvuNyqaZ2/30t1NyJEawf3/QmvqQ0Z6UIuQ3O6KIUzOjYEmvhvG7OL9i4sT+Vsdv+hOg7okpwfMlChiOSB9OXTdd70ujAjpOPG2+vvvZResWYj18NHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1G1X9CZDfG4BlquAT86QT84GRyB2i1Hwf/HIb2XteZhOH328pjBBOe+DP1by6gxrkpr+xmiHQOMPMi5wyTia5LCwsC8ehPelMbCZRmbi06ZBL5QEp92fpRjpoDlSBY7MAJCwaZMC/ein2yeCwgTqb0fwWg82Y4bvm52HnChhVNCpAfGIvET+pg0A3rllb3Eafu2J3ah5kuUDuv0ef6eTa11f2VCv/mat7FVbthcJeLsyVYlhX1lNXWLDrHNSboIzwA/fNDQNLlCCgXlF4bGxoZqWljWaguJLUYF0iACiN21So4CGgSzqXaR+XR1y67jPPWPADTjYRQJjEIinf3Q3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnTJOa4JXmWzrBFSD6Yx6B5bbeWEUpHWGbPOD0Sh4do=;
 b=dcyu0n7RC70xpwSPwH1djke6hTE5T/K4IDobqd2AcotgI2HTYl7c+yGUrJIWVp6LLPtwf0+dyyjV77g5dgI/iCMHriRBSXL60a+qv709FAbL3tp3Sr9EDP0tuC3xntBiieObXTZK2JteoC++SM0YKMqho4WB0ZV0rToAFPTMTNGS8oQ8pd6VW/HkYjxtv8JwJimgwJb8RSncc9xvVlxhBioP86yzvNvqTQoZ80N0dx0v2XB7LtTxuk3V4OxC4/Jx2g+nKKzsi73wNB+jPpxNQAorL9kmZSQAPFKlfl7XgcWVtiQjMdQDASeqdTvm/rVpOu4ZfmHKEqjNX62Y/P/5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TY0PR03MB8198.apcprd03.prod.outlook.com (2603:1096:405:1b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 08:20:30 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 08:20:30 +0000
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
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH v10 3/5] arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
Date: Tue, 13 Aug 2024 16:20:05 +0800
Message-Id: <20240813082007.2625841-4-jacobe.zang@wesion.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8d312b14-9a55-4ea6-1bf9-08dcbb70cb17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PqvozcjSfvjHLwQstIdowLH4k9tsbQZs6GtBXmuFqHMTKHGfxXW/ZJXDE89u?=
 =?us-ascii?Q?uNzS/KbiKy61S9owHZgRRB2MZII5FFlfdW3OrwNyQUEnZRhqDEbFdiYaKThJ?=
 =?us-ascii?Q?uLpSFmkM8Ltk+cvN14NicDR9CBVc7gBM8opuBX1NHZ5mwhAs/m5tBMhzwwCn?=
 =?us-ascii?Q?mj1qs96qO+iw6CLQqE7TEaJsSKAtB2JCuoU8EsLSaRb+uu77g5JYr9xEUyRT?=
 =?us-ascii?Q?id0Tmuvppb0rsg5+WF196knNfNeSC9dk3WKRdHyoifVZi4eGOJWEOzlxM+L4?=
 =?us-ascii?Q?zV2Nt0Q3yFya7wH5XazaUrwoAD9MoPHbssbPPHAgkG6gV8ZNGI7c+NiauEgG?=
 =?us-ascii?Q?npKJegV8psV0V9H3+ea2i+7K6m28uVb2tlLx+3dXTQfmf/scJbWAU9/zxZzB?=
 =?us-ascii?Q?aAlCUIBBQSDTWvjIVV1aDzkZp1+oZXRRNLRcMeWGaVZtI84HuauxnQl5Pfy+?=
 =?us-ascii?Q?QZ/vnJwxCcG/7KhYtbzMRA3ySG0Us6xafiFmOfov8oeWP0zLeiv0I+7pQN1V?=
 =?us-ascii?Q?+FwQM4fZ0YP4L6BvIM7lGJHwa8s5J2UafVKsCY+wzPOvbJD1qwV3M1umeYZS?=
 =?us-ascii?Q?sET5xvtoWphGLOSFWYWVonQ+TNNT6ip41LlxtBaiMR5+6yrNBMs5DukvBJcM?=
 =?us-ascii?Q?wuf/0odmAqsWt1kqpCtnnihNcJOUTeH2AwKbwicxzv1MwJnfW0ZEFxLNqSmv?=
 =?us-ascii?Q?cexLeirAJgVPI5KUTtC2vYmo7voECS5R+K85vCJt8kB5a7/f9UxKVp/s2e06?=
 =?us-ascii?Q?yDBFaMvRx5IYpUq6xow4TcCkrgV5pZYIGRZHs765nNUi5AdSWfhNk7OLU0s9?=
 =?us-ascii?Q?b/8925quVeCtfBBmo5jBf2Zsv/XQAwvw1Ufez7eiRAMJWJjcy63qzUne6Y1M?=
 =?us-ascii?Q?oNIKuza9uNPM60s7KBXh3OZkU7Q5bjrVkPkN9bimmG4YNjim4WX+DiPPTlMn?=
 =?us-ascii?Q?QOEEqhiWVC3dkK6QxirvqpnMC1LcJEC84mNMg5DKF+pqbMzwqXFoYr8YSbXi?=
 =?us-ascii?Q?z+ct3hGo0qCZJelqPk5TI+h7AjW9Vr8Nv59MeHYfEzLYhGUPAgoZYFrfxvTE?=
 =?us-ascii?Q?FfJeDvik1/RL3hC6jYaoIOdJddS85fJzxxOHKNUlFOK95T81AsScE9FhH7oe?=
 =?us-ascii?Q?7cYYjXBqnoiYKUi9UlrtQbqSGMg0tH9W4NojhbqZbYCYhT2e9//aIXYzAEEj?=
 =?us-ascii?Q?7zE4VKE4DWnW7d2iK2hWQtOSRUg+7fU5CPfQkPuK6ZFIgqxkmT6zA04wONzv?=
 =?us-ascii?Q?//RB7HVPrqlrmU7m2rTsOycQqnhmYcAayhywaWompBcqkqsvEy9ifDwdwf+S?=
 =?us-ascii?Q?yYpjZiisOLkda63DIIjVfFlHdqvUfcNqElxPz3S10g7tPGXdYY44Ngd3MqPy?=
 =?us-ascii?Q?s1zT0P0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?//1Yi80VP10FLLNn0uqTKKxsYUzg6uivOa+gL9p6X1dgzrYo4CNREfcWAltw?=
 =?us-ascii?Q?t3UxfA6ZH3rQoBenKwGX8YznNdxrNpjvjpqeL92fLRsNPmN/pc25wHdHjq/O?=
 =?us-ascii?Q?oyvw9TFC6u5s24lB35pnGdjuOGlGSlUs7My6Wdf+CSaRWu/wTNVveUNSUnH3?=
 =?us-ascii?Q?w189cD9lAv/p/YoBzu3jpJKebmkTDZqJacjDN12Dns0yMlYRO0e3PLtDkB8u?=
 =?us-ascii?Q?pQEwd73FCPQzNhkVm9z0r7O+5ILc8ASQXJX7fl/e+0E/CcTwbBVud6fnTvbe?=
 =?us-ascii?Q?cZdpUtKOCVKn9lKICy1xuneqrtH2w1z6RQ/cxg8oC7V+8B+mTCGkVC6xtdqv?=
 =?us-ascii?Q?GvidZyY6L1Pvo95OcvWWppee0P6M/ofGZhJUNML4zdFiOJRNEUGJdbV4I4al?=
 =?us-ascii?Q?QRfJML7fq5eG9eYTj0sTaZhJZiHNtZs+Ali9J0773qbEvjDvs0lJ4dtSlt5T?=
 =?us-ascii?Q?ohmHJOgovtiQnWhWg/OZzD2I660gXBp1Z/XRDuiAwDh9+7yUFNMvfh8mBFVe?=
 =?us-ascii?Q?MZyafqKRIO+BoRKyqQ2pz54IulXtYaVhGEW8bQcjH5mO73bZ+MX8m0vWsUsT?=
 =?us-ascii?Q?IHdnLROqs122skVieYUr/+L+wsIuFLuv5clQevA2vz24m/pd8bBqU9Ay1NZD?=
 =?us-ascii?Q?geRWnUamGYs2h/dDsNaUr1HoWO0WrPM5tr3Ldzqu8cUgztUD9WfrSEMvHxGH?=
 =?us-ascii?Q?dAVUMPL1PrXBDxfOZiGYx1CY6rp40Vg4kj5p18Yu0hXwofrXESiNt/V+k8Cg?=
 =?us-ascii?Q?GojDf4EojhjDtDDo/xxQYr3x0BTIPR2HMZf7omRvSbEKpukFQx1msQmsVD3t?=
 =?us-ascii?Q?9nnzcLcM2NfHa56eoafjnrxSe5UXaADbh/9pEmqp8xgx19rx8QZvhmYQB6PK?=
 =?us-ascii?Q?J0Klw4HBvDE4B1vn/fs6SPJHa8KFVploB9MN6rK8qc0UW8GSvJl+TPuIuaN1?=
 =?us-ascii?Q?DXq2t5pBxwfkW+PGAVDlNuhvBsjHe4vkFGEmZC+0IctQiR4o4vUv5/Bg083U?=
 =?us-ascii?Q?HRiX3d1sHWai30F0cWgz25vIFXi2WnFddSxMqvbTbEIhrRm+eRCrxUEVNrP5?=
 =?us-ascii?Q?6Bxt5zdtGtd13dGbwUISFzjeNEU8BUulFDz9IB11scolBe2bms4BGFUpE2Rf?=
 =?us-ascii?Q?wSMSGScVsFgY9njFXfV7Np1kBk7k1gAyMhVmnP2IaHm1NZd8MKcb23jB7tKJ?=
 =?us-ascii?Q?MQjMKd+dWwpm4XDlPuF+RVUP1smddVlVgQVIlyzBUe3qyWF5ykAZLVdDU1zk?=
 =?us-ascii?Q?X0wjJnskAkEt91R0w6MaW3xEK13gOLdhVFvCQKEW8apz3r6F03wD9Is5U8fg?=
 =?us-ascii?Q?mPXZ32poyHozLyputGflqAO69nhvUQVFodcefoyeQm77ksfvXCN7Jo/1xidn?=
 =?us-ascii?Q?QmyZmzTlyUPlt6LGQYi0aWGn5AGKPWX7Z8Jogizq8A7uhuouoa/2GEbi0Ual?=
 =?us-ascii?Q?ltgQamvnTFebHJyZ5zxtUHWI0qMKLu44Xhm7jyGORn32O0WqApKeuM3LGixI?=
 =?us-ascii?Q?E432g+c9Kyu17qDyFX//8JDDdX8Zb3GZo6txxwvGtUD7wysY8BLaY8ioPDUN?=
 =?us-ascii?Q?fVlFakAp1zB0xQTqKaTR/vgzc7IGhnQRV1++2Uwx?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d312b14-9a55-4ea6-1bf9-08dcbb70cb17
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 08:20:29.9402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCXCxZH8pDMQtMT9TyaFiSF3+lX/UzckakARnUe712w4E/87BqBBrndyrtsLYmy6aEPnH9bPCORZrzyq/VdBZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8198

Khadas Edge2 uses the PCI-e Ampak AP6275P 2T2R Wi-Fi 6 module. The
pcie@0 node can be used as Bridge1, so the wifi@0 node is used as a
device under the Bridge1.

Co-developed-by: Muhammed Efe Cetin <efectn@protonmail.com>
Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../boot/dts/rockchip/rk3588s-khadas-edge2.dts   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index dbddfc3bb4641..a3361ca25867d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -283,6 +283,22 @@ &pcie2x1l2 {
 	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie_wl>;
 	status = "okay";
+
+	pcie@0,0 {
+		reg = <0x400000 0 0 0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+		device_type = "pci";
+		bus-range = <0x40 0x4f>;
+
+		wifi: wifi@0,0 {
+			compatible = "brcm,bcm4329-fmac", "pci14e4,449d";
+			reg = <0x410000 0 0 0 0>;
+			clocks = <&hym8563>;
+			clock-names = "lpo";
+		};
+	};
 };
 
 &pwm11 {
-- 
2.34.1


