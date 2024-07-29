Return-Path: <linux-wireless+bounces-10597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B89F793EDD5
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 09:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C941F2219F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 07:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1BB12DDAE;
	Mon, 29 Jul 2024 07:01:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2102.outbound.protection.outlook.com [40.107.117.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E2912CD96;
	Mon, 29 Jul 2024 07:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236502; cv=fail; b=orrLyVNbMrkbgTTYBXOJ9AEZ3WACZ5IGyrZ70wRM+CJP7RbT4QZruA/Lhk6pmcxMmNkPjY0qvhwOK5fyiKtVCVJ8YJ+AQ1UDoDzb+toQMMn212z0WlD6Da5ak/4ElgFjJwSY4dhKYGPWhgLh2/6Cn7WWWAdRRS9Eba8AVJZ0tM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236502; c=relaxed/simple;
	bh=Uhfwlia00gxArAQETzG7tiNrPKwef5eo6ySI/hUTPs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WMzhv9fVay2yPDhpRgYPybm49IaNmnjPjUKQB+NRewE2dOADSAHrgEbdowE2olpfSqI0Vyrme77xH+oU6iUlnbZxuAM/gXiR6moYrUb3Sx6jJrbl0qyWwL/XBFur7AAh6wAlbyIawYuo+thZAN/Wx1o1sV7zcrsJVnbWoCDu3yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJhd5CFDx5gWlaLdZXso+uOF4ZqXo0rV9ro8rtJxoUIOH4QWuCSWyiDleNhuTuLv8Ii5+G1aVVVSAUFjChKBVZYyJQN4hfUxtm/3KZd8bHkXlCedj0OZ/tRKT+0Y6YWOuNKH4Cg/F5NLFxzFVqKCqS6Dg0v1pkrpj+pGg+biJ4vSNWXLy3EEQDiLeOHBJaBf9L0YStEap7kkeDkbicgfF9HqHx59ETD5UuJXPH233CpHG0ubDilhEpbg1v4ARAU7V1yl3zQ7QhQGjMNwkWqm26FoVwHzwxNvGYIT8fy3s6xULvRm++tz1NrLlPUZl6udbi7cHwmU8MmLmXddAYorXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRUqt4k/WvlKGJFOdFHO2kFoLNEuStUTybCV25hPoP8=;
 b=YABhPBH7E88T750iPBz937wETo3md5LueYCh6kq7dlhu4Q60i90IVtXIy9hChtBusYbvWLA636v+qg48uj4ilspXSuCO7N45fa0rEvJOqe5FDs+i8M0Yr/g+5FPZsCeKLlYLenQLwnX38pzVR06I9NLISN4Dja4hsULgOQ288RQ8Q4IpQ0sa7PyU0mADJEYLbL/n2eHZq/JyFwDN3hLUkXseS5+wE5z69J+3uJ1PexAF1iYjepu9MDSuRFUTCYnbxOBW3AIceADLQjN6Ws8q+qSqF/ET/kF2IFiU+fLc4ECo9FDBFT0uncimjsJeByRa9Q+LWBTLUMdW6l0OTUdO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by KL1PR03MB7870.apcprd03.prod.outlook.com (2603:1096:820:fa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Mon, 29 Jul
 2024 07:01:38 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7784.020; Mon, 29 Jul 2024
 07:01:38 +0000
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
Subject: [PATCH v4 3/5] arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
Date: Mon, 29 Jul 2024 15:01:00 +0800
Message-Id: <20240729070102.3770318-4-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729070102.3770318-1-jacobe.zang@wesion.com>
References: <20240729070102.3770318-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0045.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::18) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|KL1PR03MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: 280962ca-c0b7-4146-4998-08dcaf9c4ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+MQg0kVghdWywTtx9/pIfB9jGQdRBR1PxIK9h3OAw06z3vMlxRHsLlmZhwBG?=
 =?us-ascii?Q?f7oyIf2FnS4gK1J92O8deFGQWC9Bpp+T68kLw/7FZszE6Xx2LxtlCOR0RHvP?=
 =?us-ascii?Q?7BmrqoQbZoCrBPyCC77tFEPjmT7LeX2p1SGUs6YOaQ6CudqWxRfd904c0MSX?=
 =?us-ascii?Q?hKu+6mBU7r8yLdcWjrfwBxhTrE3LLvJzFiItN8fcJwzcqfuTzuY23zVDr2YX?=
 =?us-ascii?Q?qQ1wNgfAepD+PKYSRLWn9TjN7g/o2KU3/O/HdklmjNk7TgfFQhH4UH6Gna6E?=
 =?us-ascii?Q?pkZzzxZtDuFVvToo73/3AKQX1n7C5EYh//U29aDMBJ9kUi+bMIxI7MALnyUC?=
 =?us-ascii?Q?nZoMgmCBkDOvZwe3dvwd0gADeoeRyh52CuIEBdyjGNJafh1qg1RRbOaH2C/G?=
 =?us-ascii?Q?NfcR3dz3e32FpkLXz06mmxkmrVmL+cFLzqoEWLlRLin9AKRxrudwXVv+269f?=
 =?us-ascii?Q?ALOKpDqpyjUbzCqTbk2h4U3+uoBpSA7ih8Fpdn3HcdB3ORkrzf/B0ZGH6JHw?=
 =?us-ascii?Q?5D5U9V6645T7JtbjgyJNyepFr4FTKM+hVNFL1/EI0MoustQ6WhYLJ7MpG5a4?=
 =?us-ascii?Q?ofu2Nn8PP5pPBs9a6RykbHe4H9b2e98Qd9Y2hRgnHdXuk6/WEDbTXz087j5L?=
 =?us-ascii?Q?pvz7cOw14RVLaQHzkxqF0piTPnlFpq1ET2aaE46t71eJdSal1ttJDfN7sfjR?=
 =?us-ascii?Q?wweehU2bO3eMA7J0f7jgrE0mRi3JVt4U7dCF2emJ+9YwhHcXLfs/LxQSUpFo?=
 =?us-ascii?Q?aE71AOJO9KuAUAzUwIkRN0b0EhmfWYGBnFn57nuU02WMFh6mKx3lgdvAcgqn?=
 =?us-ascii?Q?5OgLmOZKRhy61grgXZDeoqHYyGFs1pRM34QmfphFLtHXaP6wcgs6BcDzLIv+?=
 =?us-ascii?Q?v2Gn8iwWyeKOMXkqZkiL/SuRzpyqY11WANkqE+ql6QN7WLMyQfRubfe8sSeO?=
 =?us-ascii?Q?/4/jt3dlPeYjyNNDJgUXZB+Id/E+IyE0zL/DBplEH3741Zz3IBCbBVW84+yA?=
 =?us-ascii?Q?1OGBOX9pXL7wHdDg7vjo4wO1VP8uEGlWn8+CMudia5lQtxTaY1VRvUQDzOsT?=
 =?us-ascii?Q?Am7gbal39TwH5zjSk8b9jCEMcbgNvKxNBsixlB8qV+spquccnafp/U7CUKpl?=
 =?us-ascii?Q?f0Sellr168qr/rnrnKaNB7ThxG/xFYw9bUpUDsBDS0HWO/sGjUfUTDOCRgwj?=
 =?us-ascii?Q?E5xPHWWB7gncQaoQc9ltPJUQDs0gFoT1XoRHyDIckL5RL+hCDc4U1s6u37ZM?=
 =?us-ascii?Q?Odbhr6eGAPMCR5nAICuZADee/Bfct/VyttqHfQyxn//yLloWjMYRtB7Z6vYO?=
 =?us-ascii?Q?8+hrCiuO71AuA77dsvrBRb+Ljb0IJ7veSkX6P47PhA+hc1mW48a1jZ6aWgdY?=
 =?us-ascii?Q?cZ1jLH1/CD0LMK70d1cSYfp0czaIfS38mu4MV7kV59mMFueB78LsLBWQmFR/?=
 =?us-ascii?Q?HRt4dGxlBn8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XMpAM77b6gE+L0Pd18Nir8phxOkfStcqesVmdEHY3IGq6edqK99QgfxCnXSM?=
 =?us-ascii?Q?JMczubIirjbQ/YqtvHCTUb73NiioVXobO7ZYUqAz+7naZQim21hr3kDnjtZb?=
 =?us-ascii?Q?ZuFtivuHUD85Ir99piAloKI1nqU624G/GDWoxAoj37cGrb48ZfBt3lr3VJum?=
 =?us-ascii?Q?tO+u0EgtK+xMWc9InV7wQzTVSFyEE/DojxbBJt5uNGq1OssJtawj+4YDp23L?=
 =?us-ascii?Q?YOyu4lxNYNnf12EdV09Dcr9KkNDt58MJ4ywYAlOM4KvNhQz28fe3tUOcf4lp?=
 =?us-ascii?Q?lE6iXcozWTBOdJqBgaHQfDSYTdKtPOsCO0L72E8fX0ILDEeBznN6kFmC6M9a?=
 =?us-ascii?Q?dehgfO4y6NQBd04uBJD+AFvgLv7ulR0mS98cGppnop9ok3TfN7sjo4tY95xv?=
 =?us-ascii?Q?YQnVhELjnzC63FB6Ll6b6X7vhvlr3GdZeOZUbkbFOBC8h0gcc3DZPXqMhaXx?=
 =?us-ascii?Q?YpDqKjmxNsuIHtSxmbOSsvk+7njYE3PDce3IoqTPgK0VArzlRk/WY5R5diBK?=
 =?us-ascii?Q?+23bnZWPCqZIn5OoEXLF5UCeC+hFQcZS6ywg6fCrGs7O4YKPpToYg3WZLGb1?=
 =?us-ascii?Q?q5ZaN6FmPKDIAMDEGREaHbMx9tp6AgY9/UniGWixY7cue6fCqu/ASaVI+vj3?=
 =?us-ascii?Q?NOICup9jX+I6Lc5aL+ajJmX2PRqbdHCuGHEqlceztKyeLztTDl3wE7CSHKJI?=
 =?us-ascii?Q?T4nICM3SEJhPIr0Qh7wb8mlcG+Ha5GhYW+8rNV2rET1nxwIF08l1UmZ4WdzY?=
 =?us-ascii?Q?9inb5tBhMxkjcxnr1swq5D4iH5kuaRuRCqqLgEAf5ih8rzZsZ4PphG7SUC38?=
 =?us-ascii?Q?6gYzCAu9uSBMkh1CR2UdXZBqNEmo4MQTzcTyEkenDSw4sD5ZEAivfcUB2tVr?=
 =?us-ascii?Q?p6tiFBqSA2Mz+G/YMhpt1Mkd3DpujJRfBjsGwARwv9T+uWtgIxxKFRlAaAeu?=
 =?us-ascii?Q?0I1WUGC740+Tyh8XumkuP2qtoSMqbaCQyIPO1tqudAIuhgEU5gb0k79OFWTv?=
 =?us-ascii?Q?vwgclVHJhat+w6t391xAY9j8hb6uthEPOGS5UhhMXDeYW5vHRXUaZbT9SQym?=
 =?us-ascii?Q?mBNNy7b2LE0QyVQFAUNualQYo6fRfeXruh0EGZacWVmSfQeC8XBKfe6BWB74?=
 =?us-ascii?Q?Z/I9099iTplFrSOHbov107WgKHN5lQcf++rZSMVnCgZlDFuN3yf1zQSYLVi7?=
 =?us-ascii?Q?9IHCLl42qM3RljKAOsICAp9JZZlQujp4ZxzmxFUwDZ3+bNoi78s7LtImlTLC?=
 =?us-ascii?Q?yoP2E243yAJ2pxwJo7WyyRPLg5edJrPrZiavB5LgCE6ZDwmd7QbuzrZaMOIU?=
 =?us-ascii?Q?98pfp0YF+sDRZtthb3NfyAQ8Ob2ZtuzTtYOig70P/Wh2K1gaL2YScYl5Yege?=
 =?us-ascii?Q?kl4wAQCYPchrtHjUmSOCaq9UcImAlBCzE5B5+utxNl2+LJUcp3TPAU+4Uhgx?=
 =?us-ascii?Q?cbaWu4ZjR7aSUW60iMOknk+8HUN7O32A2tGmM3bZtZfAiKJRKF2gvZb996FC?=
 =?us-ascii?Q?NeG86YajemF4TBIAxmB9fmaYjfPZaNmHS6/1/jE+b9yT3YnVmvZqUESgQZC9?=
 =?us-ascii?Q?LTH8ue7kxZ6p40k5l45aT4512wIYHPvCuo4bDo1j?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280962ca-c0b7-4146-4998-08dcaf9c4ac2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 07:01:38.5386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWcx5XNtoAA2wKryCSc76kONfRN1tjRXDeS1iIh6pOczeOKV5bpgq7u4Mqpl5upzBedvtCLwgkeQMlT1iXUoIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7870

Khadas Edge2 uses the PCI-e Ampak AP6275P 2T2R Wi-Fi 6 module. The
pcie@0 node can be used as Bridge1, so the wifi@0 node is used as a
device under the Bridge1. As a PCIe device the wifi@0 can be probed
without compatible.

Co-developed-by: Muhammed Efe Cetin <efectn@protonmail.com>
Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../boot/dts/rockchip/rk3588s-khadas-edge2.dts   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index dbddfc3bb4641..b80a552dad883 100644
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
+			compatible = "pci14e4,449d";
+			reg = <0x410000 0 0 0 0>;
+			clocks = <&hym8563>;
+			clock-names = "lpo";
+		};
+	};
 };
 
 &pwm11 {
-- 
2.34.1


