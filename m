Return-Path: <linux-wireless+bounces-10928-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3026F94762B
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 09:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6B61F21AE7
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 07:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E9714D71A;
	Mon,  5 Aug 2024 07:34:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2121.outbound.protection.outlook.com [40.107.215.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0006D14D702;
	Mon,  5 Aug 2024 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722843295; cv=fail; b=tUtO6z8Uj1MAzGLKnQkpwMOEfFOK7eERPo4y7xg+LpcusoGLTA+yVfvnkiYeqZFvksBpSogWNfsu3raA0+NKJHRDXSDqjEB5hA92liN4DZHYlla1ui0Hf0LScEJ/sL8D/GSlwhVVc2pVtgNYn6ZFdyinGA1HnrXHInFvAUU5kuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722843295; c=relaxed/simple;
	bh=VtUjgXgzjbwrBGBYr3U8w53x1JyNHtGQ/ZayBQWhyCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sMif/KJ8DbtKp1rrSmuKEFK4QeOGp76977qeMp7CUGM9iR2BL/icCFbDc4UQ57FbQ40v1BjRaExKe1F3brpr1NhXLOVbmmRGvS6rV2GmME/WzEysYSZ2p/qmAqT1BgAD/jIAZfUjK8U8AEgtnto9G/y+EwwqDLN+tvQY9MHisb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dj5m9WQNJh+oEi06ynnjppnfzSwRtvO6EJVjheyrvoVPYyclDCR/qWgdx79562Q5w3RaV/pkvOce0sWvGMRC112dvNW2GSKUMCdeTlCalXHUcJrpGxhKsB+X1BtiPmUIC6soho0k7L4I3NgetHNouIT6fmz1GS8uWwc9hScG0bapEKt8cYtE+aC23QHp00Wb/p42EpVcdUOOEOpQsqQcjYebN1O82iScXL+2LJfErw19x2zLctwdqlnsRfwm6JYXNoG6Qk3Ny6vX2TXCYGVZD7jMWd+HxP1QbuM91tykKywDAAbtkxlLm7zqncvryFR8u3PWVk5V9lbtCU+yMtl+TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+rKongEnwgLB9KlWQH3kBPLRrRypq3E65So/m6Tpoo=;
 b=ed51JNJLDINCWRmeQNONoY/q5Ju0zWXNkACc6/+WwN/cRus27Cbe7B/RpnpujRBJNXR2j25x9nMfVly0AKbQttLafwn9pRqM86TosQNFS89YGCbiGDz/DbfCN4b/jvcI+5eSYX4oTRsP4gTgLHw0bwsCnyFOyxmVpY8yrd+fVWW3x+qM//BJlHXJNppMWEYYL7uhsX6QfXndAO7S3NEFK4pxMhUftCo77+cWK5VRITDoOG/+AwfBhHXnep8wSUDSMVd0lUq5AQPAHOopCsEBEKazgaJ5XgPwXBg4SHvFPiKXbfluo1lPIpMDXgbClsrFFadRDJ9zBuJ0gvucFhvamw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB8052.apcprd03.prod.outlook.com (2603:1096:990:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 07:34:51 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7828.024; Mon, 5 Aug 2024
 07:34:51 +0000
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
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v8 3/5] arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
Date: Mon,  5 Aug 2024 15:34:23 +0800
Message-Id: <20240805073425.3492078-4-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805073425.3492078-1-jacobe.zang@wesion.com>
References: <20240805073425.3492078-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|JH0PR03MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: 8196263a-e8c6-4ccd-d143-08dcb5211739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y7RaXSoWhHTxqUpP1jBcrNIpsAUxlyerBMgG1nZ+RVfzNxB6fboRK5oI2Zlc?=
 =?us-ascii?Q?3U6qwB+gD1dqj4a2OumNgd1cFQ4+/CZ8Oc+INMuyrtYtErLTMYwQaS/ReRPU?=
 =?us-ascii?Q?4fM/iilI2N1n0++aJseg272YwhUWrXEJGko8fFfmQDXeGVMG76G9UHAXeKXa?=
 =?us-ascii?Q?2yMXj1um4fqe6y+FkcdfIEI9Nvy1ok+ovNXzsxCDbtlwlMuitXqyEnZeRXYe?=
 =?us-ascii?Q?U1I/+ZwdRXdcNBHr0w7dvqQcMyNQsxCvzybLr/LsztP2Uiv49XtDkUhnMV43?=
 =?us-ascii?Q?SI2nJ2WthSx1F66y6Mp5Um4+lsf+iB/aSuagMT9uRWyVfoLX79bh/9vJbcp3?=
 =?us-ascii?Q?rBMEHWm4iY51RXRJKSj1KgGlA69wAZPj6lHXO0c46NeJ2GdAvi4C5Lkkctqv?=
 =?us-ascii?Q?+Sz2doxHRNgpM3psal388PT0IlL83HnScIwak3G2SD5n8BcnDyJYJAi78/YW?=
 =?us-ascii?Q?AaMSCLs80oa5fXBcPm/ifXvXdPxdFUcaYude7KjbO9DcUZ/T8B1p0cYuefdV?=
 =?us-ascii?Q?Or+iNwmSVwimo+M65GPXjBoVPEQmSE04dcTdOlWF1NH+EbbACZv0pfLiG8/X?=
 =?us-ascii?Q?tBw+Hlvg82+gkVTb9BDMLJKn/JWKME9gRm8paCSQcIZPfLBvkAEEQHvveE9R?=
 =?us-ascii?Q?DYfvDuERBN9/7Y1gXpXoySapDmO17Dr3Hw5SN9IQmXAcPi4bnf8VSiGlnwjK?=
 =?us-ascii?Q?ojjPKnTr/YP7sB7SEPLJaX+YT2HAyQ2qtJ49vWRXYCynr5OdhYKEnpaGRPKP?=
 =?us-ascii?Q?Afyg6IFbZgQH4dT7AMfIAJf+qGuyDvbrq6RrJ0UobxUjV2MpNLtDrxxjZgW5?=
 =?us-ascii?Q?h9LBlUh6JjNvCqFDcVvKefxPN7AX1DAurlkAT4EpqpI4gdrR6nR/hpoS2F30?=
 =?us-ascii?Q?EQya3cb9M+6HySppg6dsq60TGL5Rg8bkFi1eVALmqPWuUNtbyxQ1ub4hSOxn?=
 =?us-ascii?Q?FbFqOqEqv+b+0i0/Pyuaq8zB2GtoMyvlKNLjf9WCiw9+LAMszIPC3f+omDZL?=
 =?us-ascii?Q?GjcSbjppH2d8oWbriUvhHBzolB53r3aYeX5tQ0Tqgik8oT6CqqTPICB71ZNb?=
 =?us-ascii?Q?kvqdqWcj3gV2yYT7FPYmmf6sVpZBfYt5slABIoDYjf/U6rs/D20+NGoSWM09?=
 =?us-ascii?Q?uM3S+PSAx5iYX9VA+77XlPjLDNMVy2N9LKLl3UpxqaY4auUYKONK5kbtJ8vW?=
 =?us-ascii?Q?6wnFjCrtEHtdkW6bHcm+YXfYpvZuKq7Pfgf7V5ehbH0x6AhSrecFnhMisrWU?=
 =?us-ascii?Q?CMrDhNDR3avTb/keupEJYn9Xlc597bAl0KkbJLm1fmMaLjsEfPLeQFfxnXJa?=
 =?us-ascii?Q?DxXT5DOb6fOHWD/WwVqKwDKmy7bIj6w/Ji8+/E1Kk5Ar5EmXIqyZd8aTCKFL?=
 =?us-ascii?Q?0vvlhoIzPsBTdlGXJ27jypgS5fPX23k7Xf4rUuhFuxBR2alvbdiRN/DRme0T?=
 =?us-ascii?Q?Dxi/kPPzQbY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1wjF5keYCrixnTih2cIQ+bAsv1MyiN8OdSbmB3qtUJqWTJXTUvupQYWeVBnz?=
 =?us-ascii?Q?NxB4sQ3++Q1LItM7arRR8OspSC5aRAZ4FBcugl1M/cEmPWXt4gQHFdxRcAAw?=
 =?us-ascii?Q?ReZUyOoNFO/mzQ17bu0ZBWZ9SpAqkoi/7hSwQPDGSh//Tnxm1ayrGqRpEgjD?=
 =?us-ascii?Q?RjhysS7z3/jOI6n6W2i1Ynf969v4DOeevgdj16ezDjnazSxKfhtxwCE+FjXQ?=
 =?us-ascii?Q?LqL6o37TCAwL5QNuJpU+sB120GEcc8T7CA79aaGRteWd7Tf7bBA9L94IidkP?=
 =?us-ascii?Q?5akj+mlCQxuGRc4f32cIrn5CuetJb3GRrDcxnfKZE/fGFk0680nDPJ3sLusy?=
 =?us-ascii?Q?Uatdt6YwC8r5/4HBc17nPfd9yJIUNCe82Y2DmHlDjNmjh0MQ9g6gXtgoSKDM?=
 =?us-ascii?Q?qHyvBDAeiGCA98E1Gksng+dsiXs3e3xrigPhoiqZWJnTedN45G8jaRChmuNZ?=
 =?us-ascii?Q?3nRGpK7AqSpA4RjhcpM1ZFHHsaY817mnBE1BDkfYrmNiQF0scjzLpPMlkijX?=
 =?us-ascii?Q?lt1nSA2s3N08tPUrSI5gnH5zPiGJj3EZBKSMLHL5796E8SZ6Ap87Dgz41J3Q?=
 =?us-ascii?Q?UF4IXBORxafSOynh59FFZD67pvM8IysPJ2IgkHK8rnGZ7lZJxTJVTr8Nz9fV?=
 =?us-ascii?Q?Ixphm2pEkv5tJH9N6+Sk++A9yrrwxQc7ie//shWYMxVzV5OxwS9wsEzfza04?=
 =?us-ascii?Q?XozEp3/abz/0V3IFfEGlfZqoBn26YmeHofZK5mi0dVE/mRtJFz0MAATYMsY0?=
 =?us-ascii?Q?cCWHEKLfv3ZN2ZqKSIQ6Y8t2Jrha5v52jH0rEvCiEWVmUuy0dMdKeUBiqYdQ?=
 =?us-ascii?Q?JEofO3CA1/LUTaaJPSPxR78U9uYGzSyxIu0NrFBLUx1uIAjAqfeytRyHiJ8W?=
 =?us-ascii?Q?gA+JkUCaoRKM9kQ/6K30VRYi/iTUnQYz8rFWsZJc83qAHOBY8TJVskiO06IC?=
 =?us-ascii?Q?RHrhHybJn7Lw2jl7sN1HcnbOAgfmxLykcuro1HZq8V3NPT4UBPkBhtQjiYEC?=
 =?us-ascii?Q?89PFEkSbuS9nxBQSclHOKhKfWpmKyJUD3r0zAofl4pxO117Ks0VPk6y5nBEs?=
 =?us-ascii?Q?pBbIAn3lvBqNL7HZ8VJxuBnQj4F51cW12FO0A8Se9G2pWsftBSO9gEcaT9La?=
 =?us-ascii?Q?X2oCxc/dH31XfMEi/nuTgsuOFPglu/WTwJwgrO/6Mug4q0lMmLj1T669QU4u?=
 =?us-ascii?Q?/dGKxiHp5QvUUz7WYeb0qoAf9m+1C889SWgS+HrwixZpkvhfxTdYuLh0UyQ2?=
 =?us-ascii?Q?oxm9943VwyD39kJHvlEQlJhQ1YIjECasbjDrQcAnZX6o6ugyuqw9y2zW5lyn?=
 =?us-ascii?Q?iGxRrDG3pohE5njVLV7Oi7robuzhaFBzuwd8wVvzfhitk3uw6cM0Inm1+WGd?=
 =?us-ascii?Q?cuXJ3n7nHrAk9M7LarV3qRg0uJjXZmTjcSa/fZ7G8JHYhoDT2VbDGAkk4uBt?=
 =?us-ascii?Q?P0afPJzfhttnKrMXAdElG0YJ9lpI7f+8+k2Pii7yW8nTDQ3F8vB4rFDuZqqi?=
 =?us-ascii?Q?QWIqUAWp7ZhI8/1cTq+dEmDjwNYIwT41a3vvHyfZ/uG5k10VMnejEYxQiBqb?=
 =?us-ascii?Q?IljyK5VZNNh0VH7oLUybAQwZOer6UTyqbqHOKEVs?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8196263a-e8c6-4ccd-d143-08dcb5211739
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 07:34:50.9911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfxlGwoNGyjRmzWkmJEr+tI1F+mgE+t5HFYniGl06qgfDflg/pPYVqbrtF4FEAlFqylgpRAZXs9xSIb2VJCCXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8052

Khadas Edge2 uses the PCI-e Ampak AP6275P 2T2R Wi-Fi 6 module. The
pcie@0 node can be used as Bridge1, so the wifi@0 node is used as a
device under the Bridge1.

Co-developed-by: Muhammed Efe Cetin <efectn@protonmail.com>
Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
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


