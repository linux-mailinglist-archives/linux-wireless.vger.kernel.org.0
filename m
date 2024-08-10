Return-Path: <linux-wireless+bounces-11239-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A75DD94DA6F
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 05:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B64C1F2394E
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 03:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FCC13D8BA;
	Sat, 10 Aug 2024 03:52:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B689A13D50C;
	Sat, 10 Aug 2024 03:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723261928; cv=fail; b=Ncx/vVmsCzm3UOvO31lkwBRSt7lyShTvNsfYkcqYCb0+8IQOAR3xPHSDQD/WrAmb3qiBYVVgyqMIO0SG5aAU6gYjNTYHz4kBg0/0LC7GvQo3FVDRznC1wCp8s64tI0BwbvSHMllHiAeF656EDg2ZsbeuEW0jNnpOOw7aYNhDe8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723261928; c=relaxed/simple;
	bh=N/RtFVenj3Z7IEiCR7u1dVjyT5hCGTgxAcs3H2GIlSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h0kh0Layru2714vFN1Zo9VBZSUStmodUtRxQkwc+rrvyG8j4hjsoAomgQYObV/qogeMRHtKFEFHXG0a3V6lvnEkijsvmkiAYorN7gYqha2DB84om2b90l1hnKXzWv+E2RQcWGfkG9QdDCf3sXVID48m4+wzhHIl8DgDJdS07oM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3+CS9s3jXuyxtISxWy/v9ktnlWwiyHyWdSVkaoqMsmwS78p/eUx+hE19Oy1FiVFXyavJNy0o1vjVX9Gz/IXg/k1OCDpl0lYBR5+3kxnnkAnGWzgypvzstEYS9otkr6Xoysk9XweBSXPAIu/ASQ+1/sEvzMqyigWLw1Y2Z9vM+WSTpB6XkNvWDL2b6GdDoyWHMppqMefjDHgglZiVfPuyRdCR2zJ6RwJdp4ljrwq0M/a8LwgX5imPh3gkOzSOISU5KAsdev1YevJQLVWXTQAtNWE/yYFTOnYVoDDoviy04Rx0ehteAoy98xCDqTYZrtbPToVdYuimtfQRByA9N8ZBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnTJOa4JXmWzrBFSD6Yx6B5bbeWEUpHWGbPOD0Sh4do=;
 b=O9stUF4e80qI9cw6J+uBSSwam1OXsc0tAipW35K1j7pCphI4SXFc+USKdWDXpHOF7zowNqfUCxxo3mA+YReWPcLsYt1QMx2UhxlSQnmmC1jCEYhdWQSqEMd6SzDNocRIHilTcg8vOhOK4Aprffl3DuD+QAERnDjYiEsqAg1nGnmx24uqaywMSslG6D9Z5Dl9kkr3z4dpboZRPqWCYeyIuX83ymV4f7CFXH5nmkV4ZbgfiRZtf9jZ8SoPaC/Oh7Mj9Tl1o261D+4EkIyr3ZvZ+Jj7MQKhsn5+DfogsGm7er1tlCzHV44yTfF+kImro8pYVQemP7Y0nMKThubSpK3f3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYSPR03MB8564.apcprd03.prod.outlook.com (2603:1096:405:61::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Sat, 10 Aug
 2024 03:52:05 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7849.015; Sat, 10 Aug 2024
 03:52:05 +0000
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
Subject: [PATCH v9 3/5] arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
Date: Sat, 10 Aug 2024 11:51:39 +0800
Message-Id: <20240810035141.439024-4-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810035141.439024-1-jacobe.zang@wesion.com>
References: <20240810035141.439024-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0020.apcprd03.prod.outlook.com
 (2603:1096:404:14::32) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TYSPR03MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fec5e35-4840-4956-ebf8-08dcb8efccab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T8wHyB5dpkTd9yCTOSpd6D0FMNHISyr2Vo+4UDUO190gLjwFpNTU1wq/zusG?=
 =?us-ascii?Q?XwPjCKCe/E0jecqBSVIINwaCaZgUhLMc8wtoyBje7uz4CQwXMy+N3Q451O4m?=
 =?us-ascii?Q?lNg22dFPy9uZNIQlMDBkQDVzfMpfbk2eScZQM2GyrLiiAAbMAonf9l/nuoKv?=
 =?us-ascii?Q?bMXS8JfXVjHje2JYFtlbXWL2qTw/b7NATvasuaO268lOtQlOqUXXZTs6RlYI?=
 =?us-ascii?Q?up/bVUYOPOfcosdnC6quNJxADJzY7iyv5KfaRCjvS69//FdZDA44LO5weCZ2?=
 =?us-ascii?Q?WF0Pg7d28GJuxGcQheIorpQKTcP9hVdJciO+bQiEPte2OHIgc5QiaBwoX2zK?=
 =?us-ascii?Q?rEOViE7y0GTvsro0CN8QZkWbtL/PhprEjiRQkBdeRNSQ81kCjMN+Q4Of/vYg?=
 =?us-ascii?Q?jL1TWd9oS0L+BbJ4VUDkOfNgL+Eu7o1PWvkRmpJ2hYZ7q/DSy9wYWkFHBP3h?=
 =?us-ascii?Q?vCd1H1OOsA4l9zimuP8tbeFSVmby9jxAs8QLUWDlFB5wVZ64Ybkzxkyhf0bs?=
 =?us-ascii?Q?LaTa8jYOtQgBgk2T9Vq8RuoNOgYc2GvL23bZWfSUa+O4dCdQdFnIjG2Ja9U3?=
 =?us-ascii?Q?T2Wu8tQ9uNmLE5Kle3jVsHc5AOBmWTH1xst7LiY4IpSS6nyvcBWFtyiQT1Fd?=
 =?us-ascii?Q?tdT8P8asBl+lb4tYtpn/B8/0a/hoF/jIKtbEn4dkO3dgZPfz2JCOg6Zl13dA?=
 =?us-ascii?Q?Yyb+OtnSUYDd9bR2Ew5QxUm1o9JWNGNv9vEx6WAW8/R8R0lIGD6YhBbGL8KD?=
 =?us-ascii?Q?kCQ5z3297WfODaNaxFobiZOCxOP9yKTaaNIStuXEr6/NyA5QNuIjLj8s6QXR?=
 =?us-ascii?Q?E1LVT3Ak7qoVVheq5XuV/oFHo/mTpZQQIOWh/hZUbwuSHCQ+9txIjYU2Q2cM?=
 =?us-ascii?Q?oAJnCe3c0rBnCEhsoUkreuxNbSKHE/nJCEAVIYplng1k7Lh8mf4pfmaZJRY1?=
 =?us-ascii?Q?9oNWLUhffXhCGTNLPwx/sZaXfadFST+bORwy4xDDDixHajLoou2R6YWmxmuV?=
 =?us-ascii?Q?+PoBJgH14HXmZWOc+XgB1FfowdZEPJENyHyYrtsoTQCNhyFsVsd02YUVHzOz?=
 =?us-ascii?Q?mklkaMGgHOY9OoQu6NiZOPr0jt1/WAju4LHZ63HjKjD3e15SP+07gXBOxF7F?=
 =?us-ascii?Q?QiVo5/0KVSpgmLjNnm/VOPduoTmYIYgGvJIMrh254V1R3cMbVffe0V/Rj5c5?=
 =?us-ascii?Q?20fRG0prcbdemqs91hnJhkkCpgojf5Q+cr+Y+oou8/utOtOQISyBhcsPUMsm?=
 =?us-ascii?Q?9E1UKTQRCI/z6BYanOW9AUAiHZ4ZEw2BOy8AGS23IuklXlr6t7W5PpmpTlXt?=
 =?us-ascii?Q?nqa8VTty18jp8wZrivS6HyLgrjuUQ6ZUH69XdaN8jIViLUTWIMN6boS+Gskx?=
 =?us-ascii?Q?wjtCAmMiQ2iOKTwpZ4Li874YVycPrBh+WUoFJ/2WF5/evWBFLJGlldyV6el8?=
 =?us-ascii?Q?UgNoe7PGX7k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BctJ7RMkAxBUWPgIUxkbc/IV3vRKndj3iQN4BRjgqpt3ZGL7CTgiEc1nzXvR?=
 =?us-ascii?Q?zSJhWIWHMGx17uTmscT7SjAd1UxfLQUpnCzQOn9kh/YtpDDE9ruKZpitt4KY?=
 =?us-ascii?Q?XZEl717QlwqgDJAkKXSKiwoc30W/NwXzwcQZj441lqFpXX/c4i2YtKDRUiUr?=
 =?us-ascii?Q?ruirTpNg3Z8zC5S07FhkLN17AayTo/zLj2tD1AvPZY+mvzAqKpMW1yFrbPNd?=
 =?us-ascii?Q?4THmb2Ao7sYq03nFzkzC8bMwoXOxlMFBAFPMKE9LxgGUbVTlfJRiAKRbTtlu?=
 =?us-ascii?Q?EQiTAumw3jUsYhmX611YhuZ2NU4Mjym45Vhs0UtTu8Lnclwzxv+VmQeTU669?=
 =?us-ascii?Q?tgeLQg6g9foUGo4uqSDJQNcUaITRkbm/cwbp5zvNSsnlfwFIXpNNcj3RvLpH?=
 =?us-ascii?Q?BtFMemg5uh7abiBqA5WShIqbbJct/zhBiSS9Cv6vIxkZA2YqQZSHwiQweqtT?=
 =?us-ascii?Q?HfR6ktg4hUU2TTBWrSZt36bwNdGnZoO8Lv5G5zxn1aFf2+RMVQ7/4t3IFmdv?=
 =?us-ascii?Q?Bnr+Pe7yZF8SmBF/gzTP/56nwLGzz2t7o+NVInQax8D7tstuWyPTxyRKh6Px?=
 =?us-ascii?Q?Hcec5xUBuCQxvNfzY0IAF91ThkTJmFEJFWjiS/DEbN1kq/pV33fduwRsNhor?=
 =?us-ascii?Q?ACjsCHQblNh9WmyymgH43wj9a4HfPAMOLF4acU6JIqDgvcJu9B5UCfhCA5ru?=
 =?us-ascii?Q?TqUNjcw/pztyu1YfDOKyx2IPmHC5lkpn1q4wPiuuMsRNWwfcC2X5Za5HERQ3?=
 =?us-ascii?Q?n/VOENiGJy9+tDstfx3C5lsjCbqKujWfrXnBGuDt6VTzDyZ4b4LNMhR9U0i2?=
 =?us-ascii?Q?g9zLE6yQrHxk6uf7+aAqiU9h3hWknbHSCncS8rnLLNUH0LwVHFNTdaiP8Ga4?=
 =?us-ascii?Q?ENYlwitAoSiiooIOPXeuPe08jDd2imrm3oip3aQFGx6i0KbEfh48EkJw5GRe?=
 =?us-ascii?Q?2gsgRSFtfK6vQ+mVjKor1J6zLExGyLFIoceONW9Hzzdy8QBvAqGaUyUU34SN?=
 =?us-ascii?Q?+EmUy1aBtxRVZDyrUbbaMGrcai1ZzvbldB6wJmKMn1qr2fxw1Jr+KFrPZkZ5?=
 =?us-ascii?Q?Dj73rhRyhxBYTwYYJl8gtiO5+Bnr2Mxt46WAjZiQsfsu1D4alPBOyx0LQaUG?=
 =?us-ascii?Q?P1T+6mipJ9IHaeSM2SsB86+hOVzVJZHZd/ZIbnKO9oO5t2xktKM3E7hJ66YX?=
 =?us-ascii?Q?T9mHTawGUH6T0TQKsDR2CRMdiUqj9+hBNhQeQziYX3UQZbR8l1POiVuJquhG?=
 =?us-ascii?Q?j4amz6hbE7D6fOnngUo2DEzCXhaLGd8x4FewO1fKonOW5uQTmjopeuezM0Z0?=
 =?us-ascii?Q?Qfa+grGy+fwW7IU5ysV0OZROpIs8Il1iRo34no4nPO5P2Kyz3xNzuqDvEne5?=
 =?us-ascii?Q?pM/aIIjreUGyy1KF0GO9Tb8GDyvPjqjcFvEkZWB4qfErZPsJY36Gu8yxPlIA?=
 =?us-ascii?Q?DzbpTrnRGqIqzgIUsNdz3b7Sie/E3BY2YCtrsOxdIiiXfutxIUcuXoBwrZyH?=
 =?us-ascii?Q?UcxXcrdHpuEHCvVKIkDNZldxbAUQ5zvHCNm47qNi9/Z5LEIwPgvgV+whEWHj?=
 =?us-ascii?Q?CgzAfxvx99kaNuW6xAXl5w5XMhZC5WYwXBWuYqp6?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fec5e35-4840-4956-ebf8-08dcb8efccab
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 03:52:05.1743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QcRbXPu6jy6kXPCR9T1k787mHJZkFA5yludsacstB/aUeMOiL6EXd01RDUaTaQAEY07n8TRKHDete3+rd0uxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8564

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


