Return-Path: <linux-wireless+bounces-10650-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20CC9405E6
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 05:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0251C2225F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 03:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DD41474B8;
	Tue, 30 Jul 2024 03:31:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021130.outbound.protection.outlook.com [52.101.129.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D544212DD88;
	Tue, 30 Jul 2024 03:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722310282; cv=fail; b=A8QDkjxRB7uPJlavRM+UDeKIp3WkTYEXsr2FSyk/8hX4B/GCu+86Is+OcSawuFeg3EazUG/iQm1ZcFZilB+m9zzydffkOUe47Te4KiKs8cwXKQ1A5B2AqpauJRNvWCqWHJZCkiyD91W3UiuqfxFW9FtgVmrWM007g8BSZo3vqRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722310282; c=relaxed/simple;
	bh=DXcRmnONLjNZRQY8t02lISgeJnDwKFlK+PlRzNTdKzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kpk6QBce2TezSBiRgF72ZnPR7OAAYaBb7RG7w6TsT2P6IrogfmcWLTZyMZLjX0+jcXn0xleZ8IAhEdXM8ea+XOMlsmJohMz+oHzumiuqXV26QQC3VLdWQqnj5c9E5aY1rpRn532cFooKhQJ1q5hG48xKA8TdVvYdDLjd174JH/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=52.101.129.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tq0oEsrnZnZm5EkGEeWv4BZ2VCGe9okk7xh3iZCIoHFoZD9KbU20h9NG0cSp2UmVG5kMkrerB+NZ4EcRSihLH0LZ9Mdqb4xX/fISGAn1wMVKCGIkG6j5HPKXQd5T8D6YGZxG2aMGjuVP4GcmhBWzzXiSis9Dxsn1zetMzbPJZt5MUf2/DnDpH4qjIDId1G1LqQfEWjiUHy35sWCqMjV+uLXJB+E74zRb3nIAwenTUV4+Rm0R8VfbCQ9niEabSChWkW7LAIdhrd6ItoMiA/lh9tpDLqHsFQ7sX8TDzfWUlCY80Y0ou5rsWTroxDA2GX6ssuyFyV1F3/j8Uzz+yD4nBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDLszfaTiyXrVSeO5bo+Fx1/Lx8KsLrl9pfpXaKrTHw=;
 b=yo9ShBpNofySri1ERzgmChDxMdAUTs5TpDlqnY31HzA8BfbUJa65MZt+Z4umqLoDey4ksIjQBJkL55bqQoh9xzNzAZ2bmz8wAG+nSQZWTUqr1omNPAA4Om8ws2DJZv6U1LgVOaEYDRcFb8aAdshtF4oYRa1Rmib3arxnAMqpBXh3NyT9QMyUbOjERP1fqf+jbkcZzlmxuYMFOzTUclrAwlUreOJK+AE4wHJphMyhHsmus9CR9sblP3tU+/agGOf4YWjwy9QoLBEYMc3MPJ3BaSLyJaiGnXauAi1WhtiYf9HTomDrymTrPq7ZgfkMD/xur495ZegDJd/01WNgm26DdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYSPR03MB7705.apcprd03.prod.outlook.com (2603:1096:400:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 03:31:17 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7784.020; Tue, 30 Jul 2024
 03:31:17 +0000
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
Subject: [PATCH v5 3/5] arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
Date: Tue, 30 Jul 2024 11:30:51 +0800
Message-Id: <20240730033053.4092132-4-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730033053.4092132-1-jacobe.zang@wesion.com>
References: <20240730033053.4092132-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0122.apcprd03.prod.outlook.com
 (2603:1096:4:91::26) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TYSPR03MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa812e8-d9b8-4973-cf67-08dcb0481269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hJAOuNw1oBhVJAv+QUjJL1vmWkkB79ZGKS0xUhb/QiQiVElR7OA25lZpgyrn?=
 =?us-ascii?Q?xyKSX5z51NLM9Pqj7zC+nvkpnr9aJYO3B9S/5hgGQjZ7qyZnN/ULtrb1eNHQ?=
 =?us-ascii?Q?R8sJO9c5Q3/IDoCxtpGLIcZmbO3Y5JcagFOkkrgf8iRfCA+8TXA+/IVCJBM4?=
 =?us-ascii?Q?pHayB50Vt65mrZ712o+ODVie8At68gX0aNXV7pjilOhw4PBhPtWXu0fQQ5M3?=
 =?us-ascii?Q?Vw93zVL4aM0DcXB8ReJLn7YHTdYibZfkU3hz7jz7p2J2yA7LCB3KB2FuJGQp?=
 =?us-ascii?Q?ZbfDDURuUtJH8mCzwUslRyUGlZuzXWD6QcyLsrGP9miqVT+HrhwZ1P5I2ETk?=
 =?us-ascii?Q?mUS6/coCWy/rRu2ZHN8CeWiQ1tlnvFIzYok1eYz3BEQhPwWDuaJwWypbzCX+?=
 =?us-ascii?Q?My5Q4Q/T3DBYxGUnHzTON0tjhaWyEAJibjxscmMWlj6pRNK+EnyZqKDoAGUR?=
 =?us-ascii?Q?5BwSfRxvEGYkLHLKmun0CcqwAy8IFUAMpSDo7wxej10sQdTrTtBtrGOHkpD9?=
 =?us-ascii?Q?C9mRB5TQNpBMQ8ABDn2WnOoHWricJFoc2rvv5jaFyYCVYSuza8koixY2DHkC?=
 =?us-ascii?Q?eI2XReV7oyYL5KUjpRFiVLPe62JjenYtA26aFHvzlsFPFHYBJfR1+QMe46Fj?=
 =?us-ascii?Q?tzR3dTil6M3Clo2GzhzO8NVoPz2mjqvOL2YKAC08bkHicDHRs+SAxxfqY9af?=
 =?us-ascii?Q?tRe0KCySqqySJEq/l22f4S+mIpoza6No+z++5fXA47iSsGMH1u6zEIO6/xSU?=
 =?us-ascii?Q?D7d3dR6mpcXbjjRrjHIaJx0rOTDTDI1Lkzhi1okaY56O0mBzsDoGqqgL8own?=
 =?us-ascii?Q?bRYLy8JjIYudSpt4u6WUfUN0fZZMss95j6xmdJMpkJThqTB+/dmXP1jKMAqm?=
 =?us-ascii?Q?+SGIHAS+DVv2UIl8ZEpp/XF+N+xtLyI8IFC7cHvm9lRxYEzitkuBQjl2olR6?=
 =?us-ascii?Q?vwy2OKTUJl0vi7LrCvZRjbJv6Q34nn3OKXSSYKQtfMmsd+JexieURj/cVZaN?=
 =?us-ascii?Q?TAzp0tk0XTpOPKObsNX+Ep9JY+qddv7N4NyNgJQofdsypXny6hfb2GgXsVEy?=
 =?us-ascii?Q?8aCzb7tDp5WY+5STKU2uR+wnyIZs7if1vIu4nTCGj3m1PgLSj5KpXgLWPJLw?=
 =?us-ascii?Q?UNkFNDxtf89n1rk3k3xAssIdh3VsceYQFmoAMExDP3ExjWeTfr5HLudZoiqY?=
 =?us-ascii?Q?mi0lMXZ/ux9tVmlEvFzZKwQlhY9AiqPnuy9SIB8LmMVScZPBMeJfUD45jedl?=
 =?us-ascii?Q?FFc+wNShAuuwfk6tT0LZ+BT/ZMz0JiT/AEZo7X8jCSfE2IWKyEkgBw0KAg98?=
 =?us-ascii?Q?MYmv43rFR5Xk9T/+dE+l3T1Rq3vIIwGIUfi9WfcCdp9w5+vFZBmhT1ii7x1K?=
 =?us-ascii?Q?LydDzFtTY2s4hSGt1vWqRdDeW2kPOyUnXfa6RdJDQhiRue9bNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ycuhF2IA8Q6ceYs0hZS0CQWJsSmixuoWgyoItMKyrIaX2v1xj3u9TL2+btqL?=
 =?us-ascii?Q?2C3EbBU4Uzf7cUajD6MfCzI5hn+q9S1L4AZkh6xKY/xb1umbSb2sBO/xxFyy?=
 =?us-ascii?Q?SNZSr2zRRfpI1LnZ4r09u/2VAEDgmWL3CjHFODXOTQzNrXI2KdoPJ92I2a9u?=
 =?us-ascii?Q?GisPXm007pl76nFp24XrPplkD76qOpqWKLglgjYxNBMwfX5010HvwsoxDn8y?=
 =?us-ascii?Q?RHO8Q+UahIssBpVEUnvi9JDrFto2SrUxiwhj5QJHLeCvu6NAYIoNUFGLxHEJ?=
 =?us-ascii?Q?cYK922ZfxiO7fUfM/+vcLwBTHLjqYUQ58Mzf2lbGXDhhtjcphoEjzXHe2c+j?=
 =?us-ascii?Q?dV8HZFXEni7EqrRn/FeE0tEU0xr0GBJjgYpqcBHbWkaGwn18TwUi34yoMLjV?=
 =?us-ascii?Q?+/gUQbkCwpEE3GIRQmgLQLWbBnGxlA38vtoFGJBX0XXwzEkyOqTqZ8pIy+T8?=
 =?us-ascii?Q?40dApCNCNRxymF0rqEPOk7aST6zxxJcggcaJAip3odyYncToG3LMeeFdbmE7?=
 =?us-ascii?Q?jVpQqdfktbheu+H19LyINO3wH/eSGujKMwwxEOquqnO16FP7gPKO5/DajtDc?=
 =?us-ascii?Q?KJIUAm3L4uN+RQG8aSoFQVbcc7oOSeBYJBoSycCcpWjL3+wdp1cxxrvpSOuK?=
 =?us-ascii?Q?ipLPhPE3h/2/Ceoqj6DhqQya3TIBuGZM0TuRjZ4Oiu5mRBBF+aee3xTKyeCI?=
 =?us-ascii?Q?QpyFP8v7TF9gYPIav28srzzAY9GzecsLfHWxsDbgZCwJ12E0AzcDdqjsF51u?=
 =?us-ascii?Q?CNGknoY+xkIhG3d9OA+AQyivGVLlcA6E/Uof5MahNgSIonYcvbyfRou54Kf7?=
 =?us-ascii?Q?8qofzcpzyCr3x72mbV+9QCc/7yecrohwc7EM0W1sO3Z6LCs/6u0WAIdsopkW?=
 =?us-ascii?Q?XefYFAVOuV4ULxOQwSz9R160p2a7pFQhvPxBWY9k5WC5evjmNxur7CAt72Ak?=
 =?us-ascii?Q?DihGprU4TF416fiiq25sKu+Pm4lzaC02Powu2U9BVk+SJV1XuTwORRhVs2rI?=
 =?us-ascii?Q?YF1IXbrq3biJ3WsHTqCGhBCP0sYevF9GcqEVvV2utRNNXRckUlakkXnvPxPV?=
 =?us-ascii?Q?ti/9up7v4QMc/hzezVaGweTYtcNiHsUBTIpM0Rt0Ho793LGFFhbvoB2gM46w?=
 =?us-ascii?Q?EK/IBaQzFX5zM5HKf+9VEuDLFLQO7aFot/EuD0anFwq61wN2Riz8ScOicZrJ?=
 =?us-ascii?Q?qMFlbCiL4k6PQ15yXwN5CTHX7+Bg8AzodsXT8tNNrS7h8siCW+Cm4bDPOnBU?=
 =?us-ascii?Q?uYr0awTTQ6g05vkWE4YhNVXhCTiqpoSycT/AIFJ9rIx15i/tOE328ZiF3VYp?=
 =?us-ascii?Q?s/uNnCQ1x5pJBS+uLcIAygJzyXB6gFS81D0hSMyLbN7FAFs3LM21MKXD6W22?=
 =?us-ascii?Q?07iBtKDiueArSmumM7hCz8Bz6z3REWVR2snjUZ7CPhRAKJd9XrFB0QFfCHvQ?=
 =?us-ascii?Q?zDMoOj9Lg3AHJb1EJIMBNGmxn8aD5QfutMSDu9rF0XToWsknOAg9hO7JfKn9?=
 =?us-ascii?Q?UxW6afpJHUCZlQKCLCczce69D/LU3mG1+aO0gLrUK9OR1OP18nZLLq51oyeM?=
 =?us-ascii?Q?jebejOcfjYaReLD10Ihh3ViRjO1mw69dKX9C0aWO?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa812e8-d9b8-4973-cf67-08dcb0481269
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 03:31:17.5147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkCjQb5W1jwUvu+UhWEbT9thtj9btggHjpiLt4yZckpn4Fbzu6X+dcQgEX49TcCF67axD+UW6Yp1IkIKfS5EgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7705

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


