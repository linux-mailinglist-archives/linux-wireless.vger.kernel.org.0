Return-Path: <linux-wireless+bounces-9259-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE8890FB20
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 04:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09DC3B21F25
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 02:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A57F1D52C;
	Thu, 20 Jun 2024 02:00:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2128.outbound.protection.outlook.com [40.107.215.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE6918E1E;
	Thu, 20 Jun 2024 02:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718848840; cv=fail; b=OcIctHUOfC3Rzu2suq/Ict0XlCIqalGpKFcjzGjRwoZqhPuaBw3denRISJPOZVl47/W5+VUHikpoP5fUVFxjIelnpbExgAjwmi16uLAPxmFGkTln6c57Y0YzBXav97aCuM8+mTuxKY33pPzk/uK1WrkR98ayWn5W/4R9r/3RqTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718848840; c=relaxed/simple;
	bh=Yzty4I49yKJ4Wl3ti0bZWLXCZOHa20Uu37HTl1Rd/ss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MR3/CUsZ2o8TM3hpyHg9pQlhhuNRI91oNkG9UvVRbkWrsKmdDFZwxBHX/TfRZpfMQmuhLzO8T22zAahEYK3iUEi0N20VoBMIqa1Wl6lKPzcLAedAQUH0XjuyEdwdVUiTPWq4ZIOd8LwPcKKaMhxINjzJtMAN11hFu7SXZ8sf8lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQR0p8zMXGL+YQKuyG9HTgcs7DKkeWFxOK9j3PajvyaBbjskda7UeCVf6o3Iyg08TBLj40MGiMoiGabgTRP+0h/3xbpi0BZQzBZzHDVIo6htHIbMEgzqmIxgzxlTxzdmaPgyGQF/R15tUSDbaVfD/JaEj7M0d3dGhAgFhDcd2ikowrnQuB6Pgce7w0RisuOL78RTs5YPOSOmru1VFMX/vff/TCMSG5kC13lX7/QN5LJYVRrZHDZyoLU6tgrA/3fQvsWvazl2LLVfKV04cfGCPX7Yjb1nEZwA2Vw0+BEKHYW0e3n23KnDiqQgAFkY5gnt1DEH/sz5SLAbA4dcNt63Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HClTLOHMHdy5kxSydXytS/7hgy0X2wKkFJ3pxOuojco=;
 b=Y/U9OtMgXJYV3jeW2/AXGBP5VPNlIQQlcQDUaViaIsRfB5k4TaLL9HGQDEKgiXC+BNUaTR+pV9sj7E21Y4UdAryLhOXGnkcglaSTbJZuwD/M7whCtyZTp8qCY1fcGOBvrhGgMR4KEAFP3h3RQmKEZvlxF0tqQKmXMYXAIx1XmfADFYQoLuRdkd0C3qQJjZCZo993t2Aae9hwC/0fZPwEj7cDsbWShjgC+ZW1YwjYui7t6GJMRESOnVv5gy7QrwhnsxMvVBp0R+KU8kBrzaCO/+J4y+/m3L6yin4dDmRXw0K1YHDae83aCN0nRa7J3nxRNFnw7ZJmLm+dkX8faAMtGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB7323.apcprd03.prod.outlook.com (2603:1096:990:11::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 02:00:30 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Thu, 20 Jun 2024
 02:00:30 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: arend.vanspriel@broadcom.com
Cc: kvalo@kernel.org,
	duoming@zju.edu.cn,
	bhelgaas@google.com,
	minipli@grsecurity.net,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	megi@xff.cz,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nick@khadas.com,
	efectn@protonmail.com,
	jagan@edgeble.ai,
	dsimic@manjaro.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v1 1/3] arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
Date: Thu, 20 Jun 2024 10:00:13 +0800
Message-Id: <20240620020015.4021696-2-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620020015.4021696-1-jacobe.zang@wesion.com>
References: <20240620020015.4021696-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0185.apcprd04.prod.outlook.com
 (2603:1096:4:14::23) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|JH0PR03MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: fcbf89a6-db5c-477b-75b2-08dc90ccc329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|366013|376011|7416011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0TLun5Kn4HFeib6KHzl17TP7Uc73lXkxiN1JQRA+7hBz3xztDK5gyaq8cC4Z?=
 =?us-ascii?Q?mBCdQg9focb/nb14EXZRihEhA1U3DzAx54jT0CkJG1EHmht2erV01JVtki9p?=
 =?us-ascii?Q?b8DgcoHXEBieXui0dPXzucG98Z/YlK27cZvQ3WFVarHd/UxcPZGCaYHMRWDs?=
 =?us-ascii?Q?04JZPArBY5pArMs/BAgJtim5DgeCtfrWwf8qvNWjT0AMkW5stuye/0lf8l4P?=
 =?us-ascii?Q?BHDhPifQdSJR078bvbPPKvH67qpylbU9pwhcGv4dFXYDG+JHS5V3qTe/6ZJ/?=
 =?us-ascii?Q?ZemNgvcj0vN1dlIVN3F8Ygm7grJ2Q2DVP2ozG/ZjJZqDDV0Nf7yr7TfVga+Y?=
 =?us-ascii?Q?NJ8BJjJy2D8J5PISkbZy1/29M6ML5GlAM8pRvi8T6mIX4sPsxeWLyPwp/tbR?=
 =?us-ascii?Q?AYx6sa6/UCxRc0nnA0hEiX1KHeWcGcB4Wk4oCdE8r1FU1lYQonzkSPyBXx9G?=
 =?us-ascii?Q?EZbFQ2mCFG24RWcFTMuYaNWu1XiiOa7dRT54RdoLL3bGausin+29ng+CywEb?=
 =?us-ascii?Q?axW3J1wOxUlLVzxlXcqIKQh/eQkOEr+6+RcQkaQy9gO4uTgtwzn+2UTtqlls?=
 =?us-ascii?Q?jSPlgfJvakobl/JL3bsxr40A+9CNHff6sQB5B7EScIvEYJhp+HKhxmOMR9Qd?=
 =?us-ascii?Q?BWP72Zex4tLCpeiUgdrOTyOaoplre4wq9WNyOOcVKzalqulk00ootgMy+neB?=
 =?us-ascii?Q?zhVCGBwj2cXddLgyUU0UYVTv/pUfyG2hGNSH81yGk5kOlOvf37Z/Yb3la27w?=
 =?us-ascii?Q?DK74HbFXhhgB38H21QIjlKfll/kZKLlXZPDeE6fI/YAKFL+wGUvXv4O/dqnT?=
 =?us-ascii?Q?3HYJp+XGG0VX/Pl6Bi9B7COSuULoUyduxXRFZa36Jj5cIjM1SXPy+oVIyQkY?=
 =?us-ascii?Q?eCJBj34ZuPFAlSkifOZzo2AihDFAmCoh3whyTlGEv9bqU5hKDSsX0YCIe8wZ?=
 =?us-ascii?Q?pcFm0tAPsm/s8I2zZfWdPkg8Cg0VSLHOIoVi0+9m2RTPd2vpXX6qCq+6MXNT?=
 =?us-ascii?Q?/1cup5RWWJRuDOV0XBwi6zNUlnQcWm/dnkSJpPKmtZJUFndyzN9Z2kKzLQ1T?=
 =?us-ascii?Q?CFbO9W1XuyCYjfiyOI4YpgmjZ/4w+Ch2BZjI4a/huipoX3OCX2ZVLwG8aTAe?=
 =?us-ascii?Q?c5ppViMaafU4CZEw9wbS11S0+NqwKjwta0pCKM8y5mV0rvFMA+o1pcgFmEB1?=
 =?us-ascii?Q?NKwTy/ZCvwQTfu95Zk5GQQmhAfMRSSGLtpve897ERXXenUQGfcS07W8jsz0n?=
 =?us-ascii?Q?coerTCTif9LQT+vyeMsDL3BrYJiQPQnlcXzag0a9JsvzMMax4cbF7Z33Dykb?=
 =?us-ascii?Q?2nnCFECEUimJw3i/WOThZrL1K6/5tVZcvJ0/TlJjQeZZgBcBxtiOGZUcFLwF?=
 =?us-ascii?Q?dcHUQBc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(366013)(376011)(7416011)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ntECe9EVN6vOf/o8XHIfdx+spvWFwIica4l3DfK37htTfN2K36AgHb0TtZar?=
 =?us-ascii?Q?UENepE5GN2SiO0UPZPDUa968MkdH5mcAOac5rDTtf4OVrEEKQWcgQdPLZZkR?=
 =?us-ascii?Q?jl0OI7nDQ/+HxIOOZ2eKvtRqiyZC6X1LzeXQIUQdqJXaAYqBdNa7TvGZdS2x?=
 =?us-ascii?Q?Zb5236EOT21REAZpmnY1nO2Fv5sT2SPCiL8NPQERYuvZeZvI9KOSZIdX3qP4?=
 =?us-ascii?Q?OPmSeGfZOl8+SoOmCp5Q7tQfCAHKHo2+y39yW9JcefN50kUIOGcKb25X3npQ?=
 =?us-ascii?Q?p+lWiJFzlwfWYlTwG7iIyq8GcnB2N9LNLtnlMPr+ZEmOezLoDOr4VAcCrJhV?=
 =?us-ascii?Q?FRmgD8d0KdDqQ14Qyd9x7nFIgmeguiVo2jQQMG6zqMqB/u4dq6AHCjqvdZsv?=
 =?us-ascii?Q?EWtSYyASF4Udei4R7C3B8b/OcOY28qSX4bzBCvKNwo9y7LcHj20XYQFhGgNs?=
 =?us-ascii?Q?lkBm/z5x1ZQRpEgYdSwerqQdf/acx8A+aXMz0jc7ng2sOOrEUknrTyL/a5Xw?=
 =?us-ascii?Q?7SczE0gjxSATrQ9gqEMGm0PowTbkOIvBUlQge9epUTb5ICom22X5SK03TYug?=
 =?us-ascii?Q?e65CXtehT9iHgoho5ILzC7ePrjidL0Z/+ROvs0AbGBx7EhyI5Zgfuru5oFM5?=
 =?us-ascii?Q?cI024YXIkAkWcYjyLv5a/lEQASA69cr8wWiSjLwx8F1M6yviogyF6PvFqa0q?=
 =?us-ascii?Q?oZzgmTmKCk1vX7HaUH1Aw2kXmQOY1QYYR62Xn9vM691jnWabNtLx8AoOmZa4?=
 =?us-ascii?Q?yUGe8XOTybJLvI6ZZyLG7PeMLb7DZRDztvf1v9aDE7KhzLH5Jo1yHn8lumbU?=
 =?us-ascii?Q?YHcmIj0i3RAagXWt6kWlwRFyvrrJqosLMITPNGfenM8lujrsUKcN4xE6nKOT?=
 =?us-ascii?Q?g5x8AiPcd824hjSagWKofiuK6RHjIEi39dC7qMFFzsc96s50tfFfI9cxeFJc?=
 =?us-ascii?Q?IbbgQzRRFgDhon5V3/QQI9dZdiJxn17IVTs8yi2SpISl3MSKnJUMh6j6Mx3o?=
 =?us-ascii?Q?2MOJxN9O2D58v5XjyvsydqPscGccbqBSjKD6c5StwkgQEd4FJTpfWCx48cEc?=
 =?us-ascii?Q?UVN87EpDbbT1Rl1lcNnsPwV+la7cw5GZTlY/BLL3klcSGNdRPcfU9qIT79To?=
 =?us-ascii?Q?G2eBDXfJ1EEpddO5F5+098cLYcNU6/W4EXkz79fhR0yNnXXaaB/Lr+g9yB4Q?=
 =?us-ascii?Q?ss/RgNlukZEfBjrnvbfBuYim9c1yhwTwFL+M5DdLzb3KMN9TARcm4Czk6Z5b?=
 =?us-ascii?Q?iFtZW5TnfnpUeW1IhyNMgMHE44KCUPdq87djUnj+AZ1lVKCvCe3rE0MSLEBq?=
 =?us-ascii?Q?6hVCZ32IB8sIBfs1QayCjq5CgJrz1f7FMeCwF2Hr7msLfJkZfeogrYTt/9IB?=
 =?us-ascii?Q?3NlkzVMRhqTNspDWtMvsex8AiKYLGieLPRsVgGLXMMrOyiCl5pUAM/cd0vQH?=
 =?us-ascii?Q?l0tOTyHKBjN/n5OEDmneHH0RxgGoyXjNz+isQj+96Xk3JFY+siizVfVZ4T2X?=
 =?us-ascii?Q?K56msgSD4JYYurb/YTMhx8Z20E2eEpgHyn98QWJq/v/Hw72yjKPZKSMp99qR?=
 =?us-ascii?Q?lTsUfWxyCooIuRDI8gExAaX9nKSElN3HLKKz5+rM?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbf89a6-db5c-477b-75b2-08dc90ccc329
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 02:00:30.3614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlp8ha6CWXb2ymY1oJHYWeXiTOx9xmK+4g7kzbgpB2fYVluBk3pWAUcX4LZJMJ4KbsJM14Y4KDCffo+5FxsCug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7323

Khadas Edge2 uses the PCI-e Ampak AP6275P 2T2R Wi-Fi 6 module.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../boot/dts/rockchip/rk3588s-khadas-edge2.dts   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index 3b6286461a746..f674deb6f7da8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -356,6 +356,22 @@ &pcie2x1l2 {
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
+			reg = <0x410000 0 0 0 0>;
+			clocks = <&hym8563>;
+			clock-names = "32k";
+		};
+	};
+
 };
 
 &pwm11 {
-- 
2.34.1


