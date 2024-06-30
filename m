Return-Path: <linux-wireless+bounces-9705-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F8291D05B
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 09:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E389D1C20D47
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 07:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F48745CB;
	Sun, 30 Jun 2024 07:36:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2098.outbound.protection.outlook.com [40.107.255.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435A346525;
	Sun, 30 Jun 2024 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719732994; cv=fail; b=Di1JSAfW+N0aICxv3Saei68WN9iI4FlgSbAg5k7fUTbODU4MaT5pQsxqqhk1jq5RL/Tm/6GD8BJiOMPlx5HFrRh2vEFwtyd59jXU8tJLmEd7jN1o7/4ys6tUk8XfKDaBqJtdGgueXyao+gpeU94J+/muIzG7c8uogQYHQ/pON8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719732994; c=relaxed/simple;
	bh=QqFR6s9KjUOUyzIEwtcRx5MBudeGY8qkcLVHhl4GB8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h6T8+KvhfBp6zoaMDc4tCLw2rgI8b3r081bWBhFvDDEV4iBAwubVXJ975hChWEfqrpHt5hZnHsvXTMqH+XY+WYWck5KcaEuHM1fggMqAbMv/oe418f/gdI74D2JNtPUXWwJgVXilGKAugla1sNjrkHN02UQTopHUoBlo3bIONEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqzouzuX2F0Arb5+ygZabEB3orZqu5SPUfb5TDIUaWgG/yWoJ/wjKmFr6u7BUz96fDLQMj9eab7pug4fixP615qHtnpfyzGgmneE34nNTmN1SHA0AQZSiK7WRXKojh7kpYn/nDgF/havjNJj8FPHH34CSmJMjGqlIBldCt4HHTyL2iiHUC89wLdJOKUSVCf7UyJpF6mw8Adx3/EtWm/c7SxUbf53mQw1q8mG9gzqciKF79Ac9AoOBmnZHEwq323anWPH735N5CVvGo0fFR6jzddaXhVZ3dASS922jQHeHUHsXxnMl7DrvzDAo4nANgoZlHj3EXubJ/0DcpkmW/1oJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ERto1UyhkAAKVp0UYqK6we3Ig3j0IzjIphAgeN4UBA=;
 b=BcTxFA/Tf6rUkHQ6RSYscs2m7x6f6kWHU9ZSCxFgj/ECUcXSp/ue27hlhnoZL4KStK+HDs4TVUmA6GOxGmtr5aOH4YX/rgu2KmXBJgRLlFPYWT1XEflNjSE5r6+0Nalhd59TdDT6Tjv9xh+whfSCY2mq2I5c3VGgiaHdm0VoxU0emULm1S44oxmWzZQCjVXNLgj9EIqzimWucjPRhN6FxxVWXi8frE9VeAb/HOUSvXvqrSCQf8oY7CjZoOqDL4TXUx5gKIoYcEkbd2ql3auN3pVDxnAkZ6XGOkjPBoFgZhWvKRlZvLGvDHF8HXZ787mZhFoF2DZszIw4hUBqsHsAjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by PUZPR03MB7234.apcprd03.prod.outlook.com (2603:1096:301:118::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Sun, 30 Jun
 2024 07:36:30 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 07:36:30 +0000
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
Subject: [PATCH v3 3/5] arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
Date: Sun, 30 Jun 2024 15:36:03 +0800
Message-Id: <20240630073605.2164346-4-jacobe.zang@wesion.com>
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
X-MS-Office365-Filtering-Correlation-Id: bde62b5c-6798-4b08-3dbc-08dc98d75bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5mX8ncx06vC6vVmVeAkrVhrcf1dM9PH7EhU3BjYXu8T7gyrwe9wL/vAyAqRW?=
 =?us-ascii?Q?5YrFQAhtSgveDHNTWv518aZEjCFXevsO6pPRrgm48gdXUPlhavUVf1NBFO0M?=
 =?us-ascii?Q?h/MrsozLD7yyfDFOCUsu0vLIK9LZgLK3RfqLXOphWrCatdBHw+2g9gs0N2+m?=
 =?us-ascii?Q?kzLP0TiYFqAZaHgfXN2qcEiQr0Yj1mih8xEQn+NkvxWS54j5QcUXc17IYQEJ?=
 =?us-ascii?Q?KEUD/VAqo8ttmKh99R3bMNOoo8skodfhDcQ9lxrzxHpUgAXLimf4NANN68HF?=
 =?us-ascii?Q?IlG1q94gq0Vvqbram89pT2pN8LX4e+MjxrfVC2rrqcQhfPpPmAOMg8om61Jg?=
 =?us-ascii?Q?T8dM/tLjrInGaPM8jtSnYueOSKQ/nv2L1Pdde+g++oKNctqju5+ig3MD4CG3?=
 =?us-ascii?Q?H2Nk2CDZ9HuJzFeo1tj7yZFZE42cvqetJcE8XV92Foz0sV56UtBGCcMjYlEy?=
 =?us-ascii?Q?OHSLr5XuBz2nFtmLmf/pky4oqaPTmMuyikm2B9I7wVhSG5gOOpfFucuqeByq?=
 =?us-ascii?Q?ZtiRWvVgCDaFEouOaEZ36K8eAOQhGxu0DzOJ/TgvY1iHSwRB5+p2wwC8Q9mh?=
 =?us-ascii?Q?AMBZ0Lg+YBQonkomX8KUR3SePlYOvfEYdMAfvpZLP9fr7bgEiNe4cxVBQzBK?=
 =?us-ascii?Q?4Hb99MVN83zVtDUm26F5fJY02FC+8Pwl9rAMZKYbkuktBnOhum5J5fXLOmiI?=
 =?us-ascii?Q?/He5iLwCi4vJfGCqZok7DWtVjRvnpbkmbsn9Mb5f/I31IpdX6nBnyZ53tvy3?=
 =?us-ascii?Q?Gcj0VW+I6ki+ODyKOnHU7oqndnTIIsjHhUSC4cru0NXMh+/nm00KHFr6XVc4?=
 =?us-ascii?Q?0iLZnyoO4bzIXvwDr1Bz2GnEHEXDO2YP9ppkxlow/BByP3Z3pBCRSop8i+YB?=
 =?us-ascii?Q?00QglhXqecN2JadDuiH+jteVxP9LJmD/cwbCrRYuqT5O1P+JU4YkOv+Uxbb1?=
 =?us-ascii?Q?f1fDL6B5ivBvB61mu6W5oL5CHtFzjaZoZja+HU7gVpVBFsjajLLTKqJVnqYf?=
 =?us-ascii?Q?aoeBfI+kMxA9Mw3TyZQjzf5Oh3EYxxkOcgoiz375kuNDbXJrWul/lSeuXBgf?=
 =?us-ascii?Q?7Z/3sVKzCf2YMUERfpXwYREENBOwgGas/oMTw/qZwjTLyUqtOU2qWEcxS7vr?=
 =?us-ascii?Q?LCB9iQzqpv/DiktTagyLuohvppgORELi5QFnhcdIV0WviZefMCmEcSdsEyH+?=
 =?us-ascii?Q?DfiqcHqeGhSIcNMVIFp1ZecqmipO8GFK/RZDhq8bFQdrLu8PFXwMERR6Mf+s?=
 =?us-ascii?Q?lIxejS9cap8hpkWMvbZagjnMBaW8Ses98wxQCrBbrAYBp875aAHCz/WaRNxj?=
 =?us-ascii?Q?dJetGCjo5lnXzOMayhnY0cTok/KdivWHbVBfbphvG75xSGEgKWyZ/MYR2Bqw?=
 =?us-ascii?Q?khBQUjotJaeRAPKQM7lCPcSZ0sk59AZ1DbXyLop0iE2Ekslh5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UDg55U+x5N/j2MiA1pbTsYZ9+TVLk08Kp4iwy73xSym4kvEI8/sqPYCz7Kq0?=
 =?us-ascii?Q?407KPalgtijcxNWeKjNGn2M+3yQJ3RSvueEUiJ5mBgWTbP1Tus8B9n1nWcYd?=
 =?us-ascii?Q?jrAzp5L1Wx1Nj1VNryEfj+T4hpsrDBmJzEmY3QwalvGe6aRdSnXFjh/ZdGP7?=
 =?us-ascii?Q?M5oGZtv/KDwQuBipCoUZoZ+AKRE3kJuf1ykDrxRTynieSZI8/Avp1/IdiYkl?=
 =?us-ascii?Q?TIgivwcV1gibIPY7jYkRYMSgn2wNTdHkaZGxTijp+UsLRLpddv5VEE086Nmr?=
 =?us-ascii?Q?deqPgrGEG7bPQWh/EkBnFXHaykqaJgd8F8bSjCMCOH5s1uztiTJ0RJlsShqW?=
 =?us-ascii?Q?wVlQuU7p1sSgsme8qUcBrCRTijeCsZmsNkcZXDqlqKfzOzxGKRXSGTI4tmWN?=
 =?us-ascii?Q?C7AK4N0gF1VcjVhkWK0OSr4Hsi/6x6k0jtHNnrXLs4WKDjC+Tybhh13ctqqT?=
 =?us-ascii?Q?3RZ4mHFnViKNV+8/2SUOOrHnt+32svgATtw393GulkD+U+YzCppHMSGVQBh9?=
 =?us-ascii?Q?ACQ6BmvLJO/KI7/nrHYFlDXmEnJ9nIRV4npPqQyNAoA7wfONs8xIGUeMr8NQ?=
 =?us-ascii?Q?XC5nhrvGOZIfwBZrIFuDmVmq2nAE6qS6N/MLgdm5vV1b+3wtmUn3qemkB5TI?=
 =?us-ascii?Q?mSwgYD1u9p+cR9M4IPDuEK6dZYpcbi2Pw8B+KZprXHWJHK1xZa57GG/Ye407?=
 =?us-ascii?Q?FP3iuvEWaFQtEkpJZTrIcDE+9p9d85o72oFL1wCtRcCqc2dfw4eRtWXaNwBr?=
 =?us-ascii?Q?/wlk/UU64arvJFIdoA3hGsuUygudCbIo4h/8+gcrGLfW9+1LzSb7DsR2KxoR?=
 =?us-ascii?Q?JDvuC/FQEUf1s3x7YlcZU05O5El1L/ITQdIW3k1dPd4IwZoDuvYE+i8SsMkO?=
 =?us-ascii?Q?sdB91GtN99gPPDGrL+RVCyEAEhQi4cJhXxZUQtt5gL4vkrn53fdL5CQQzmoW?=
 =?us-ascii?Q?A3QexDWAlpLYk0S0WvqrWOU0tyixV8T8hf389gndjJC7l+8lfsLRf3x31RCh?=
 =?us-ascii?Q?JA6m3ehFuuos1h+aKcQAF4PB9vvBS9hE3DvIAf4ZqOxN3Cf67c5fBRll9ETS?=
 =?us-ascii?Q?n7TAK/4HIRRKPU3K0ZgQQ/hCb/yzrc2A6RcI0D/ZdBOGyIroQqILySMUGaBC?=
 =?us-ascii?Q?yqj5Et0WYXq+bkgCk7sWAIMVes3lB1OMoCgZPQAZUVwq3urB5ZEvXWmXRuPr?=
 =?us-ascii?Q?8ORDfzUeK58wXyxC+SNAPfWImRdI5trfc1xzDBKCm2GR9vybr9vDuY/HV9SH?=
 =?us-ascii?Q?gYjdvZUEHIidlWdD+oFrd+tovmc53tELZp2GH3kl1RC7ZlXGiTbMqyWrh0RC?=
 =?us-ascii?Q?CqfyXjY56vnvj1tul7cpZ9+IBGqOktNuOpTHUlSGBR3HeIPSwSYokpFCOYJ7?=
 =?us-ascii?Q?XITmIixj6dLC+hdJTsPyargVhspw17eal+d0Lco45l7KZgdF8QZDOwJ+ScjA?=
 =?us-ascii?Q?HTpNaUe7zOhODHKoPa+LmAiT8eq6AFHzjqlGaeinkvGa3uzrFRmkUh+jxDI4?=
 =?us-ascii?Q?Lj430b0sByaNOAa9eT+cvbhXeygOWiyuT2aY5s/2EhokY4IiHYXjsnYxMiBo?=
 =?us-ascii?Q?f/NpTV3BqGi4dv/ktUNNPIfnd0lwacTCDG/2aQLS?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde62b5c-6798-4b08-3dbc-08dc98d75bbb
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 07:36:30.6210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1XiHRiXjBnADk68IDd/97Q9dxvEODoksIvTZsljxi414JW6edFI/69T6tSxy+xssD1Q+anLdvGd0cq7NURlSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7234

Khadas Edge2 uses the PCI-e Ampak AP6275P 2T2R Wi-Fi 6 module. The
pcie@0 node can be used as Bridge1, so the wifi@0 node is used as a
device under the Bridge1. As a PCIe device the wifi@0 can be probed
without compatible.

Co-developed-by: Muhammed Efe Cetin <efectn@protonmail.com>
Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../boot/dts/rockchip/rk3588s-khadas-edge2.dts    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index dbddfc3bb4641..8c152d587aefc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -283,6 +283,21 @@ &pcie2x1l2 {
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
+			clock-names = "lpo";
+		};
+	};
 };
 
 &pwm11 {
-- 
2.34.1


