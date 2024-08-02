Return-Path: <linux-wireless+bounces-10851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8615594567C
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 04:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7640B23891
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 02:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA5713A885;
	Fri,  2 Aug 2024 02:57:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25BA132494;
	Fri,  2 Aug 2024 02:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722567472; cv=fail; b=lLYCEF4ZOu/PzRI8D1r8mrk8ujZ11pMmzjgdT828/Rl5LfGLCi7Vdqb2GE0KyjVSva65c0Mynv9aNoQ7dgPDB0m3FSeaAtP+2qBIl7u/y6OXnkeUr3x0x5NDAcVoYS63wvdvn8skLQ92xV0w6cW7VoJUKg/TEz7CO446ad9l6zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722567472; c=relaxed/simple;
	bh=8fr2le2RRkyBxxo0cMbqgGIl5Pqcs8qpx2qLsAezPSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nvuqg8wQGFtdL7JwMIPRLTywfg51/oY11To60nYuMElVoPISTH+t3Xwv+akl419eSDkMabR6GhCpyXQ9Lm6E0PaWimUh8SFbF6g8CRh08tWbxOzR78QsG+wooT864OkzvLOS0nXvQPyiZaabIVMFPlrAEdJl/CMm9Dsyo04nBoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zP/hhOrocXZH3Wc6T+o1NDnjV7JltNBRU0v2Wix/tD8S7FWwhcFBjojejAHU2B+ybLZyT/cOhNFC+wbV4rXpeUXhr7J6iaLyBXLqmqRremED60BbjQZAVfP9hqYIL08yHn415I2rm2eKZ8lLgq5O/WHstcaDPvKElyidBC5kDiryQJo6UuYiAC78Ig/99+n/hBV8nTtxm+HvE2nKKxGOvoIaOHoiBZrsbqm0sCPG1graXOdw7qZkaTTKB+WAx+6qHSWp+0dMbLxT5t3rFW5xoytQ+dze/xTTfSgeVj0dl9jjirnXggxjkF7/pQAQG5Z13VSbG+hMT7tkhx++1rL/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XB3tez9D3u90dIBU3uiBuPnvK5S2Zx5c0jWE2G6mkbA=;
 b=vXIUUG4Dlp8Y1oONiQD9AlDlHszQ8PSrNOQepo4GAKu5LlskDOuEw+G+cBWuVDUokV+xXLjnGi3mWSYlr99EQalf3hUWIbzkeaK5DI7OVgCXtcUZFbhq52l9b4eVEhAAVqj4CVAN3V8QIDG2qtuAbpbjgNZHLm+zfTaKhfnfs0XfHiIshOlEHBlFlD11RS0f8zcW8CwfkJnM2DuSLyIFHpa208hbRHsUqnhQUoj1g+zwRmUiWk5sDHF+Z63iehTbxGX5uRcVOaLqW31lo2BFNQAzLYFnexe69l0Pf53er8CYl/RUQpLz9tkHu+t+PvoSVZQHTPN8jkHG5UzD0okuoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by KL1PR03MB8376.apcprd03.prod.outlook.com (2603:1096:820:12c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Fri, 2 Aug
 2024 02:57:49 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7828.016; Fri, 2 Aug 2024
 02:57:48 +0000
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
Subject: [PATCH v7 5/5] wifi: brcmfmac: add flag for random seed during firmware download
Date: Fri,  2 Aug 2024 10:57:15 +0800
Message-Id: <20240802025715.2360456-6-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802025715.2360456-1-jacobe.zang@wesion.com>
References: <20240802025715.2360456-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|KL1PR03MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: 676c7624-5b06-4e87-af2b-08dcb29ee47c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jvq3XyToX73b2UzNgT5gqV/St3IxQQCYs2pRlgK4KNcl3crE308uTcuS/gcd?=
 =?us-ascii?Q?ZbMPcsQmiT0D8rEQq7P6MNOEa2nJ/ho1xh33+odRrXeq/DSlCJAL+B+LVq90?=
 =?us-ascii?Q?QIONCLZ7ybp9e72Lf9jmYbq/EZlLJUdcRDrZHum96Qc2sMQTB3BiHZq1B1pB?=
 =?us-ascii?Q?lKMFqiYiVnt2D+g/s7giQapIMXi/SY51y+VwJ+rX3xQA82nBszm70TXWvySH?=
 =?us-ascii?Q?JA0enysQ3cSb9wfTAFea8XcJHZDLaBRtR9kseUDzEc917F6LYIpUYa3bovUF?=
 =?us-ascii?Q?XTIfbFwFYxTjsZYNl1x40LnLjDyGhLhMLoE8FiM4CKx2d1QpTjMx04PTggIg?=
 =?us-ascii?Q?3mK+fE3ouYu9Tqary+WzPb6lhGM2mHOW/y6T6Bw0fRBEEotoxnLBtAMe9aJC?=
 =?us-ascii?Q?KEjFaqbiUboO4xl1/uPLHfVwLzbXzx+rTaCPJF+XFzGPZ32mcYVXMxczIPq0?=
 =?us-ascii?Q?QxoFgjTwSUDl27D2e94FtQGGC0eP32+fCbjsBjYh7ssAVnk4reVwDPuRP4Wc?=
 =?us-ascii?Q?91kPsLoF4OlEJ23gCVxzYSM/1fVwkjws23wyaqBls0KYTKQtxAa7sgf5hJkS?=
 =?us-ascii?Q?Xnf5yscE0LSIhMzDhFChBmA51P7Jl955mUQ3ytx4uTvM5oAJmWr8oz9b/8LS?=
 =?us-ascii?Q?mT4K2/PjejtVF1Fi8ABMj58Hyd6BhZMZsh6y1KHCa/J91Xu678rkjLbiFiYC?=
 =?us-ascii?Q?YFCPGm/PdC/sIHRju0dg1B4GkxayQCRvkN3bLSh0HF6kwkwIyeR8Ff0c69KZ?=
 =?us-ascii?Q?copLr8cS45/xzkzRHt0T/rDCzgtG0IePWm4YHwg9nFrhzZgLY27bsFMqLG+V?=
 =?us-ascii?Q?rvmon1fZALroe0RrqgHouNHHaWtF2KtwUp2UJ6t7Pi5XJXlzTLzoWP4I6IuP?=
 =?us-ascii?Q?CdNWXe19auw94V5JY37sPqvuyONTkPTglRdC2lBi1W1yGpRcNALNtj50IPcP?=
 =?us-ascii?Q?yemOd6R9jMkmyWQ5EIG3JNwEdAa80PQJyhIdhdmOemGgLRLjb9MYYwTQ2wh4?=
 =?us-ascii?Q?HqLZC+9YwOQ99ZF5OdXZTPRvmgwKBQgv4xLIHHTuS/2IpavNVmqVP+4vptyf?=
 =?us-ascii?Q?G5k71GK4Yjz+mzT2smzIw0B2s68E0Paqpw8aU9oG4JCXoKx2veuQ0+MQb4/P?=
 =?us-ascii?Q?LLBGazlsgIubGBe5NW/XYS6B5NAHu5//bnzZklrpIuC/I4LWbbJBxMb+xE/7?=
 =?us-ascii?Q?t25BxiyVoEID3LxHdvSNPVEnmH4azXss6+RaW0Xgxmxvyi9NFY+z3Q6JgfFK?=
 =?us-ascii?Q?wUerNjrcRnQq0uk9haCf7hp4CB0GD2VumjIOVxVfk/lxiGv0aog6PMzg8PuQ?=
 =?us-ascii?Q?SFHf4hy1FvNfaJdIQCJ7gsKvbaRhBq07zeVDzrjVlQohegH4qvdLvwQlHmVS?=
 =?us-ascii?Q?yg+4ltPoCM32YA87Uy+aE4pNl45EgqXq+y36/ZFONs9CLQzdIZiKLxmYvp2B?=
 =?us-ascii?Q?9yMnm62ISs0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gfTGzo8rMTRnBfHQVhapd1iOw2d6fyMP2XAyB31ZsJSk1dZd1BciERdT6zhg?=
 =?us-ascii?Q?2KgYhynHXVAertuA708WWZrmD98O1HHyn9TvDqB+2um+sip3G8yacAF5BFNv?=
 =?us-ascii?Q?EWSDTUiOx0UcTbaRyNZyf/7++rOrswgZNfawHylJQjzu2Cksogdqn2n2Iy3Z?=
 =?us-ascii?Q?Y2UL6DFKDaQEDyEbF0yRK4+99LB8COu+4o1J8gU5H8UhI6WsQ1U/dB2bsCQX?=
 =?us-ascii?Q?6cXvTYgcsOM7g7AV25HQGy/K9voKw0/XM5gFup4r9rnsvGjWHMXIkhb7LtCF?=
 =?us-ascii?Q?LF8aRpPt5sRTkLFCXEoiQxrvPzA/AmdRFRCQtrfdq5bpSNIoPy2UwRaN+ItQ?=
 =?us-ascii?Q?Kn5b/1mRtmpPAdMpOwm/brIO7xoiWcicAvMhshRpc7IzAh1P1iEzeD4EVdr1?=
 =?us-ascii?Q?tHEhW6ivOg0wB2czIEE5s0ju5g4pQJcoTcit32PSZ0AFjYSkvKkBh08Wml89?=
 =?us-ascii?Q?nnLEcaGa34IRMrgLELKv/Ljwm/gWNuEFLSHyrcew76Rn9jLEeup+4ZHw/0de?=
 =?us-ascii?Q?o+tFo09J0/lIFoN7yEGBvikAtesIsuIfFEKppDXSalqsfkW2TSj5BbeRaVQ/?=
 =?us-ascii?Q?Wgv89vuMwSXweU7XsEhzE8DF81LMiftatg1KOHXS8JmitqvOW3Pg3DTrhsJM?=
 =?us-ascii?Q?TsQ4m+3a8e1bYfv1ty9+gAf8SpGnM9Vs3uIjM+yteCCW7WzmHJ2kWDUv5aJp?=
 =?us-ascii?Q?gv5Yq+9TtR9gu+AJNCoOcv8W/QBEHY0IKyifQ3lwGw7grh8whP1uEFOmApJR?=
 =?us-ascii?Q?4ZawAWTTXavKbjbgTeMkYb45mfpMO2Gf0zD7LpRr3xHrWsrIfCW1xwXJbACv?=
 =?us-ascii?Q?QJWMxv3bxB0C7NxXJt4evrXtUXwVjQoh3yB3Oyn5bWouNPoxY73fINGdrF1L?=
 =?us-ascii?Q?Gv+CFuN3wN8MT3XgoLYeWQII8BRXJhYXPA/BQKG6WCBremH3LwK58l4sPK+v?=
 =?us-ascii?Q?NA70Vj36zDV0OTNmPozgLFP2CNLTut9+O+Fa7x4k8LQvDVeF0FfnjxdPl5GB?=
 =?us-ascii?Q?f3QxPUVFkXwOVokN6WBGX3ztrO8Rv6nwSmksCweDwUDNeqt/SdaH5OU0Mc7A?=
 =?us-ascii?Q?IoIfU++nPcqoQ74Jz9mIbTBF37G8+CBuOw6jDccii5YS6KG8kVwpkRT3I68+?=
 =?us-ascii?Q?5zjcwVDt4zRMcoOG01SCwxT3uHAlxdRswNSJtyHdi5ccYN+521iCIQ/fbK2D?=
 =?us-ascii?Q?gthJeH4ywC0jFsy2iYuUohvnn9pkMUbHBPCi2alRfWUu5iJ6bbBQrCdVD5zr?=
 =?us-ascii?Q?Id6FTlWRZ0OWZd8Xpui61PtLUnTkeBqy5u9MrGhqiG+bi/BpRWPnRqOO5p8T?=
 =?us-ascii?Q?vIxMncFCvHuKd5oqCFIFmFT3ZRfRqUHc1wGjgQSA/gBeUAg6jSlKuf4tJrd+?=
 =?us-ascii?Q?VZFwWjeLy5zjwdBgxko7jhgjlVNpAC4CeN7qNU0wcLUNVMKE/MqjWej1WRss?=
 =?us-ascii?Q?ew/E07iIpCxqWUQuzYQv2LQHY3GleX3Sw8dpfHKpntPgy5PgbmMX/L2KogmD?=
 =?us-ascii?Q?KoYiZjDJvXztvKAtiqykK3KGjVzLv1gOJgSs5uZhD/S01OFgFWbgiPvPdajm?=
 =?us-ascii?Q?Nw269cD62aZVBJzdPSUFimNw6KT3NTwqTgjt+J+N?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676c7624-5b06-4e87-af2b-08dcb29ee47c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 02:57:48.9132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91HjvrHmT0Gxda90T2bNgDvsfL5M6ad+WqyaZ6XFXPf+yDC/lOG9JKTTgoysCWcH8ZeD5rwnPbUD46R8vCrjFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8376

Providing the random seed to firmware was tied to the fact that the
device has a valid OTP, which worked for some Apple chips. However,
it turns out the BCM43752 device also needs the random seed in order
to get firmware running. Suspect it is simply tied to the firmware
branch used for the device. Introducing a mechanism to allow setting
it for a device through the device table.

Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 52 ++++++++++++++++---
 .../broadcom/brcm80211/include/brcm_hw_ids.h  |  2 +
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 06698a714b523..938632daf30a9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -66,6 +66,7 @@ BRCMF_FW_DEF(4365C, "brcmfmac4365c-pcie");
 BRCMF_FW_DEF(4366B, "brcmfmac4366b-pcie");
 BRCMF_FW_DEF(4366C, "brcmfmac4366c-pcie");
 BRCMF_FW_DEF(4371, "brcmfmac4371-pcie");
+BRCMF_FW_CLM_DEF(43752, "brcmfmac43752-pcie");
 BRCMF_FW_CLM_DEF(4377B3, "brcmfmac4377b3-pcie");
 BRCMF_FW_CLM_DEF(4378B1, "brcmfmac4378b1-pcie");
 BRCMF_FW_CLM_DEF(4378B3, "brcmfmac4378b3-pcie");
@@ -104,6 +105,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
 	BRCMF_FW_ENTRY(BRCM_CC_43664_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
+	BRCMF_FW_ENTRY(BRCM_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752),
 	BRCMF_FW_ENTRY(BRCM_CC_4377_CHIP_ID, 0xFFFFFFFF, 4377B3), /* revision ID 4 */
 	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0x0000000F, 4378B1), /* revision ID 3 */
 	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0xFFFFFFE0, 4378B3), /* revision ID 5 */
@@ -358,6 +360,7 @@ struct brcmf_pciedev_info {
 			  u16 value);
 	struct brcmf_mp_device *settings;
 	struct brcmf_otp_params otp;
+	bool fwseed;
 #ifdef DEBUG
 	u32 console_interval;
 	bool console_active;
@@ -1720,14 +1723,14 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 		memcpy_toio(devinfo->tcm + address, nvram, nvram_len);
 		brcmf_fw_nvram_free(nvram);
 
-		if (devinfo->otp.valid) {
+		if (devinfo->fwseed) {
 			size_t rand_len = BRCMF_RANDOM_SEED_LENGTH;
 			struct brcmf_random_seed_footer footer = {
 				.length = cpu_to_le32(rand_len),
 				.magic = cpu_to_le32(BRCMF_RANDOM_SEED_MAGIC),
 			};
 
-			/* Some Apple chips/firmwares expect a buffer of random
+			/* Some chips/firmwares expect a buffer of random
 			 * data to be present before NVRAM
 			 */
 			brcmf_dbg(PCIE, "Download random seed\n");
@@ -2399,6 +2402,37 @@ static void brcmf_pcie_debugfs_create(struct device *dev)
 }
 #endif
 
+struct brcmf_pcie_drvdata {
+	enum brcmf_fwvendor vendor;
+	bool fw_seed;
+};
+
+enum {
+	BRCMF_DRVDATA_CYW,
+	BRCMF_DRVDATA_BCA,
+	BRCMF_DRVDATA_WCC,
+	BRCMF_DRVDATA_WCC_SEED,
+};
+
+static const struct brcmf_pcie_drvdata drvdata[] = {
+	[BRCMF_DRVDATA_CYW] = {
+		.vendor = BRCMF_FWVENDOR_CYW,
+		.fw_seed = false,
+	},
+	[BRCMF_DRVDATA_BCA] = {
+		.vendor = BRCMF_FWVENDOR_BCA,
+		.fw_seed = false,
+	},
+	[BRCMF_DRVDATA_WCC] = {
+		.vendor = BRCMF_FWVENDOR_WCC,
+		.fw_seed = false,
+	},
+	[BRCMF_DRVDATA_WCC_SEED] = {
+		.vendor = BRCMF_FWVENDOR_WCC,
+		.fw_seed = true,
+	},
+};
+
 /* Forward declaration for pci_match_id() call */
 static const struct pci_device_id brcmf_pcie_devid_table[];
 
@@ -2477,9 +2511,10 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	bus->bus_priv.pcie = pcie_bus_dev;
 	bus->ops = &brcmf_pcie_bus_ops;
 	bus->proto_type = BRCMF_PROTO_MSGBUF;
-	bus->fwvid = id->driver_data;
 	bus->chip = devinfo->coreid;
 	bus->wowl_supported = pci_pme_capable(pdev, PCI_D3hot);
+	bus->fwvid = drvdata[id->driver_data].vendor;
+	devinfo->fwseed = drvdata[id->driver_data].fw_seed;
 	dev_set_drvdata(&pdev->dev, bus);
 
 	ret = brcmf_alloc(&devinfo->pdev->dev, devinfo->settings);
@@ -2665,14 +2700,14 @@ static const struct dev_pm_ops brcmf_pciedrvr_pm = {
 		BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
 		PCI_ANY_ID, PCI_ANY_ID, \
 		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
-		BRCMF_FWVENDOR_ ## fw_vend \
+		BRCMF_DRVDATA_ ## fw_vend \
 	}
 #define BRCMF_PCIE_DEVICE_SUB(dev_id, subvend, subdev, fw_vend) \
 	{ \
 		BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
 		(subvend), (subdev), \
 		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
-		BRCMF_FWVENDOR_ ## fw_vend \
+		BRCMF_DRVDATA_ ## fw_vend \
 	}
 
 static const struct pci_device_id brcmf_pcie_devid_table[] = {
@@ -2700,9 +2735,10 @@ static const struct pci_device_id brcmf_pcie_devid_table[] = {
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_5G_DEVICE_ID, BCA),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4371_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43596_DEVICE_ID, CYW),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC_SEED),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC_SEED),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC_SEED),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_43752_DEVICE_ID, WCC_SEED),
 
 	{ /* end: all zeroes */ }
 };
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index 44684bf1b9acc..c1e22c589d85e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -52,6 +52,7 @@
 #define BRCM_CC_43664_CHIP_ID		43664
 #define BRCM_CC_43666_CHIP_ID		43666
 #define BRCM_CC_4371_CHIP_ID		0x4371
+#define BRCM_CC_43752_CHIP_ID		43752
 #define BRCM_CC_4377_CHIP_ID		0x4377
 #define BRCM_CC_4378_CHIP_ID		0x4378
 #define BRCM_CC_4387_CHIP_ID		0x4387
@@ -94,6 +95,7 @@
 #define BRCM_PCIE_4366_5G_DEVICE_ID	0x43c5
 #define BRCM_PCIE_4371_DEVICE_ID	0x440d
 #define BRCM_PCIE_43596_DEVICE_ID	0x4415
+#define BRCM_PCIE_43752_DEVICE_ID	0x449d
 #define BRCM_PCIE_4377_DEVICE_ID	0x4488
 #define BRCM_PCIE_4378_DEVICE_ID	0x4425
 #define BRCM_PCIE_4387_DEVICE_ID	0x4433
-- 
2.34.1


