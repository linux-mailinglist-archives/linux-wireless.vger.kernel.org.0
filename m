Return-Path: <linux-wireless+bounces-9482-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303199144A0
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 10:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618BA1C214C0
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 08:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2CB60DCF;
	Mon, 24 Jun 2024 08:24:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2135.outbound.protection.outlook.com [40.107.117.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3CA4DA04;
	Mon, 24 Jun 2024 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217451; cv=fail; b=TrUu10PvB3QlSdKl8EbEYcRt184T0k2sjvOxdA15+rNPJoFdqb0y7kxGkE/Elzz8v+lup/yVEHFoSc4q6jrQwdXnvGquIDSJgJ7YwFgOB0zSqwCeWs1VL+zkTTZwbT/VbxMsskSt4tSIQZTYU1Vgx0H3iWsAYyw7GQu+wY83Mds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217451; c=relaxed/simple;
	bh=VNoEuhV+caHPR/3VTM8kSl7yQZYWk6N7t2RYH9hl7DI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WV5i/UliBUhytxP6Jgmq9MvHG+sM+y/9hdv8zrLTYIyw9a1dKNca+v4O4FC/vMq+WndOx1s3AUTUsbosXZGNzeEo2wMW1FJbZernsFMs1SDPFD2aIw+yzyU++gieHKUzahmJn26sDovGW5c8d/6wvc0MT2g0MmzyeiQD5mMwqvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Do+ZdP8ZGPH/mwdusDqjLY+o0tZOd/d6EULvZwVk+o/O+qoTVgUW+yKDaCWkRaO6ju9A6k/oHoHmKAmEaUgC1ZtpEqACnRbbd2XTaOoqRT9UHpOSxIJLYoyYpTTC8n49qCiBOdKkH5FlbGROU7BvJCGNx5eaj5DMsbjIYCDE3yWgjjQt+WjukO/pU3GTro6R1Dz3VwWfr9p66eX2JEwX1O4Etgal/K/HdMkBsS5fD6Lppsz/NxT5qdmcFgxQGulx2BJT5NffhAG7dXHQRM6pyyfnpX2dluITiPn59E9Te1C4Imi9GE1kLa8GberD9IqNretCQVLUMOQ/hiW+LNsggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsq/MX6AolyMZm5EIQHaBjPBdjtwCwJ+vJS5BCGG/JA=;
 b=TSlOEin74pCwAUu76HBPp4UDC2bnid3NJUZvEWWHj5EqwzlNZJkgmY/BL5xyKfkkWsppP2t6p+3bXCvxxva7G5cOa7uG1WzDN+8z6lHPLGHSwh4Gmxp9jtgOEmRtiGCmaFBClYH6sGwOW0GzuwJ9XNOQ8RlP3q+HNE3a6A54n8bwh8ZMG8pqqqQWfKtmy+MoeNipiuuy2AW9KUv+lcrh/jg0C4s7DJVhS+lT9H+PCI9rgc3SxMol16aaadLqJmFUq3Cr6dJnE1YgcSxClCopC0fIRtxRxMldq3UCKlT15L5FxbYqQUc4pUOg5O2gpp3kBS6rUhZfEYSnwvI2vUUhZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by OSQPR03MB8600.apcprd03.prod.outlook.com (2603:1096:604:290::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 24 Jun
 2024 08:24:07 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7698.024; Mon, 24 Jun 2024
 08:24:07 +0000
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
	efectn@protonmail.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nick@khadas.com,
	jagan@edgeble.ai,
	dsimic@manjaro.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v2 1/5] arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
Date: Mon, 24 Jun 2024 16:19:02 +0800
Message-Id: <20240624081906.1399447-2-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624081906.1399447-1-jacobe.zang@wesion.com>
References: <20240624081906.1399447-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|OSQPR03MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ccb463-ce5b-48a1-7d36-08dc94270456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|52116011|7416011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5fUlq7vRpLFMtsruMG66NmTwBZpFImPSdtBHC1zIFSVgBuVLWMpzVNKesekS?=
 =?us-ascii?Q?mCBhz0Uym+oMxex9wSXS9+wenqPh48Ui0gumE4g1iL5Z7wibg/9cqcCLq83h?=
 =?us-ascii?Q?7X1iPdSCfOFCF2S4MT0skjW2OT/CClbGD7ige15Sr0nawU8DVTth3Q91exWI?=
 =?us-ascii?Q?JgvM0cbuJSWnUybiNWQJMx028vbE4UtXyeNS22oYBSAt4+F/B8QygMHBCCUJ?=
 =?us-ascii?Q?2HK+V1+i74xXwEb5Y2JYcJWPbcGsovMSBsctgGlaoVBL1+DmyuTgz36tjmDy?=
 =?us-ascii?Q?sj778IAxsERizLi4d1XXASOiR7MQcoFNMxLzCJqY1delY65sqwdTJ6LVPpm2?=
 =?us-ascii?Q?Ms2GysAx5CEwpqkqEpJ4yooAEiAoJ49Ve2q2Mt3yvkbT6njn2ij278cVl6kx?=
 =?us-ascii?Q?7+6+QRQKCduguwu9nThE5dawBpvYjXXJglzJPVMejMqpdXqE+ouSqqGFXhPr?=
 =?us-ascii?Q?+dGBFAhL7ttRm1RcxHyuTDTC9omShV3tEiXVyWbDwKaDdSfUgOlz0roUNRxS?=
 =?us-ascii?Q?kQL1MYv21nApCUgN6aiQ8Ya1kZwQpMNI1r623dFZB1JnHnEx/K1A1ONI1P8O?=
 =?us-ascii?Q?+uRdWy92BDPV9KVwqz5JDjx+nVA2XC6xzz+nL4PZmv6gTL8SCf40QR4gwGew?=
 =?us-ascii?Q?uEpZjGUAegslSnHGixibABmSmNOnK5Diez+l2DcVofF388S0kwzhw9DCURGe?=
 =?us-ascii?Q?SbYEZrDyWWbvRtL32IPgySO+HRtMrsoaIqXCkKGDwR8iS1IHrbq/UWanrGsZ?=
 =?us-ascii?Q?c7uwewSd7Ex0kfc89K0nxsOXyfETt0boZ90suHjXGyT/aVAiMy2w8hQYFWEi?=
 =?us-ascii?Q?5VPY1khg3pRZI6+x6USvGewKBr4L3YzyG2qWlgPLcgJcBjxbhqdnPFhydxw+?=
 =?us-ascii?Q?JRXwbKGCHIPuiBo/mCn6YRxIzwtbr/ro7nVtTrqjs4zFkSOcIUS3ZtHWHBKi?=
 =?us-ascii?Q?YE9HzWJIg8XjaDzEbqLPE2RC2n/eWwJ3EtpBvXYH40FhR7BnR+zDXmBzeVl8?=
 =?us-ascii?Q?uxAA1WutKsc/tcX9Bc06V55O8g04YlMwrV5tfSHBtrtHUWVTa3fxexQ4Pu+R?=
 =?us-ascii?Q?JMZ4blgC7Jt9cmtbLtz95bsleYy0AGNEYxq2Bc1ptNP8d/2yZija4xWOQglZ?=
 =?us-ascii?Q?GegEm1DKg+hVkTpRgUVF6jceuxxUPwMzUEY9EA6/2QnZxcpAfwTcGotC17yk?=
 =?us-ascii?Q?xbohIrRFDY6fNeGTMrNfmajjYGA1WnAcaCyGOKNDKpO+eNvv6ohG3E5yKq3f?=
 =?us-ascii?Q?Os+1xFSYLDUsktTjzcFraMy59rYojcy5SYH5LLbg4OJsdGZR5IL4bqME+cFr?=
 =?us-ascii?Q?LtcjvEoq0T1Fj0cB3B09gvnuaQcmPHOseaiKTYjqpTswDGgz6TNfRuyUuIvI?=
 =?us-ascii?Q?XVMqfBw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(7416011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uRtpV6OEqJv1MzdynbUDNwe57OtFQjXAaPx7AnzFR/wpnldpx4VCv3izXl9A?=
 =?us-ascii?Q?lzaxwKBGTdMY3ReqokivXsIHT6m40DCO0ksypvVZIWu0x7KYMI/TS+jtY0Px?=
 =?us-ascii?Q?lZQdAEJckU6OPRAG8XDVkRv1y/gIz2tU5nQpHqo1Tu83RUqfnO/Mm1RxLd+/?=
 =?us-ascii?Q?Dt6d42gD8kdUS6HleczW98haCmLVyDiC4+QSk7Iieln2oPs8/NrdWl/s1AGf?=
 =?us-ascii?Q?1i5VoafZ2J8FpBa+qiVTZ9aiHL9lOrMnpTstewcTbIe3i7cXXRQ/H5085yeP?=
 =?us-ascii?Q?eBfc/J+6q3pDVKGNSYh/Lb6/2sus3gqovVxake49WOAWF5m/22bGpyW3EeiN?=
 =?us-ascii?Q?9pELYT8Fo937b00xrOzC/dGyRjsXN/oPdwVT2d1q1hnhvkzcaVqHjw/1LmRr?=
 =?us-ascii?Q?8E39cNK6wcGQyfxDDJGA/dr7Jha3gFALSsmiRj5We3pib1/bN/AhSZ8enJHV?=
 =?us-ascii?Q?iksiIvjNre7kR+86NfImhz8NKW7CaWBPAmVcDi3d4aCgg4qclsUU/WGQZOfx?=
 =?us-ascii?Q?AzXK8Qux6/6SksssCZdfaNdwYuU4+HBcZWdldnzoYQAi+fN0Ti5vZ3I6IG26?=
 =?us-ascii?Q?HiNmjwE9dRStpDgnkOsk3UxQ38b3CgcnLV8Y45BzsiNT4yVVyvD+UattyRtj?=
 =?us-ascii?Q?DGUKvaSY5OJ7YIXSG4SCDYon9jUyVNCXEMT+yi7NQ/K0GkhjmqsDLylbGd7B?=
 =?us-ascii?Q?voxpDPc3YJF0zB8I4k6roAAYDTFvQbTMKuWQdRxsg3NSnZZrN9aDOiyYQExr?=
 =?us-ascii?Q?dM8BtfGI132KwSR0l1ZQGQ2iS7vCF/jTES+wqI1M+MXZKX9db//4M2Q7jEOv?=
 =?us-ascii?Q?QFy5PFsfCno0wbFNloc1ad0VY4QI4tQ+43ODFB0bL5VRzLCLW7cBa6YD2ngV?=
 =?us-ascii?Q?sq7Nz1bn83qb7ES67Sjp2+osHeFvZsm3uL/ptpF0JosMBH47bPm47JHOBXJ6?=
 =?us-ascii?Q?FD7GIre+62IP2nfmDJWo0o0Zdgibfb+e2qUGC/ZrKPpSIKv5Eo/VHu96QBte?=
 =?us-ascii?Q?bSq3cr2V7/IGbiPtctJsVhhhj7S7XFTNzG3xqac5WyEk/RVHmboF9Evbp441?=
 =?us-ascii?Q?GvDyTDemP/6xlOdUAXnBzJEXuxAf0HGu/iZGQedsYAGvqtK76Z3FrCzpUvr5?=
 =?us-ascii?Q?vY7xCx2ACvQBVYmNbxAFGbB5ojJkNgy3p89VfMw0YZvP24JWw4HPsyvgi+Ib?=
 =?us-ascii?Q?4sXzh/AWXq7KVliisZNnY6ltctM8wiZdbfHadn3+I+rNMyajuSb39gHEemDq?=
 =?us-ascii?Q?G/s/4CidmPzghXFXTRIJ2f+EsthMX2PTdyFJAtk1Saou/lBRwLEF44AMtN6Y?=
 =?us-ascii?Q?WyZHc5ZccpZLeU765yHKSK/QSwdQwnayFNM3apWrKRWZVLCousUKOqxNY2s9?=
 =?us-ascii?Q?E+4SnxVQ63wHcMWtyy3wRZcsdLV0CUPf634oHvzTd3DAOKzAXwvZU7NAGokH?=
 =?us-ascii?Q?2eZvCpQZSWH75QiH5yuYltTPFVD2zaC5H/v5ryUh0JOOh+2MYnRm1/Uk+1eI?=
 =?us-ascii?Q?6PPzQMq2WIWaIW4O2Wj8UCT6SovlUeONldX4rODgPkeMvQEjE8SIJSXUDWde?=
 =?us-ascii?Q?dgExmv1/Xynu4BiyCoTqfr33pckPs14xuewh6Nh/?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ccb463-ce5b-48a1-7d36-08dc94270456
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 08:24:07.8964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQNp08BM5qERtT3IgySG0PvQiWFu3PRgB6IWu231ky0DfJaE5PoHhy5+LSe8IDORTLoCId1wl6vwC+f2ALOAqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8600

Khadas Edge2 uses the PCI-e Ampak AP6275P 2T2R Wi-Fi 6 module.

Co-developed-by: Muhammed Efe Cetin <efectn@protonmail.com>
Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
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


