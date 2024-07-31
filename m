Return-Path: <linux-wireless+bounces-10714-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1F9942641
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 08:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153CB28661E
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 06:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB9816D334;
	Wed, 31 Jul 2024 06:12:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2091.outbound.protection.outlook.com [40.107.255.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC9D16D302;
	Wed, 31 Jul 2024 06:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406324; cv=fail; b=Ykk6tLMHwkskNFlvfTuMmn2iIOcswLMuqpA/QyTAOxKzLcwrFHk3QUMaliXkUhBL/ESrC/8pdQI005b2LcucWXciknHYRIwbZd1NTChuukvPfHiZX2iHaxyJHuMqI0vB4uNJyhj6zY3BbtfSd5P2T7kZVZoNv7DkyOnD1pHHNsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406324; c=relaxed/simple;
	bh=8fr2le2RRkyBxxo0cMbqgGIl5Pqcs8qpx2qLsAezPSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LydJ1dvrYNnLInyVc0UzEFX4MdfbMuRARfr6v9xCpvf5QQGKwkbxbOMyIk8WAS5VBVV08kVJRYa71ZugHOy86NOlJbeVbJtNH0g5KOKN9SNuuyl0QUTJo1x0AnueXW9t/L3Oib3b51gnwcfWX2ke3eyj6HmSMcYYU99N+trw80I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mydlTK7tuwVSY7GpUZnejrjBlGFq2odhq7/ZRip3vGREe6eZC4JNj41tu9PKQuJ3ZymrmrRAuAiQ4brNLmvgdWi+rIvzYT2sx3ZqT+mzQ/mvQtu/Sody8VOxSi90iMLDz6DhZTpgHLewbw7WRfAhZMCEHlViQx7N2z8t/RCZ421lcctYLDADFlq52iQZ55U+uYytkMBDGFs407pB12NXB4j6gWBfpql4Zlo8VuqXwcv15yWN+h3kY2bwneOopmhFDaZUgjRcKnhTlrjiQ0zA8JQ0GhuzNZfCfzaz/cBKINRKp2dFo8aFTyKOTeowBnHav8Aed90E1eiKi3H8zu48zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XB3tez9D3u90dIBU3uiBuPnvK5S2Zx5c0jWE2G6mkbA=;
 b=OGaZR1U34leyw+e8Y5SrJIeCcgc0DGZGAwPoLB/9eCsnZYO4RJ8uklGsM/9yKSBzN40raTqQDXpWl3u7mBQEO5TPoAA9Ca1LkC0VUDPbUxdxDUBUg+MlcBMRB2LmLUBSn2JPW6m7QkZagO//zUr6fJP9f6yxBJGI/0LCvX/o6AmfMp7tG9SsBuAM9DNWLTLH3YahmJoZUGgDyBigUb11DWjDAmMNtzUtBfglFUC7VjTVV1ESefOVvk4ZRVOp3kCa6aCf5O3BwZym6NTyaFTtCm/6wVV38zk4LZ1Opp7rAksqCyMYA1U6r6vyUlUNUgAB36xYrEg5IkJUupzZOovLUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB6580.apcprd03.prod.outlook.com (2603:1096:101:85::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 06:12:00 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 06:12:00 +0000
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
Subject: [PATCH v6 5/5] wifi: brcmfmac: add flag for random seed during firmware download
Date: Wed, 31 Jul 2024 14:11:32 +0800
Message-Id: <20240731061132.703368-6-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731061132.703368-1-jacobe.zang@wesion.com>
References: <20240731061132.703368-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEYPR03MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d66130-af0d-4845-83e3-08dcb127b03d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xbn4GAY9HJAApfKLJDTdkuD2TY9uuushDaytBOhRvgfaH0Q1jPCmfvk1jJno?=
 =?us-ascii?Q?MsGOfY3IRd99zLoAjxJcrQWKlr8az39uV3rAptzC/x5F0e6cw9aO4Uafb1VG?=
 =?us-ascii?Q?P/SBOoE6MMXKiX9rfrUUBjClrwtRx3HROc0rmg1mir6jKKkdDO88NrKmiMec?=
 =?us-ascii?Q?4T2hermfMNzKAE5w8zkBAXI9UzN8AqlhOtGiQUj1EM2ayxiEszkp/62h+59Y?=
 =?us-ascii?Q?LyieJOpqpXMd3L6fQzZZe9k2tJB9biCMk49Mb5IgL4tVDsy01vQmvMK8RMvK?=
 =?us-ascii?Q?+Kvl8QVOW7f9eoMuMgT7XHmuKq7MxJh8bN81GCs1Wuvi2Y0/cXSmM+Y9jugc?=
 =?us-ascii?Q?dirbpQpplzWHoFVqTtTxOtzUuPUODRx+JAvZhzK+yTt2az2HJZDdFDz2UJiY?=
 =?us-ascii?Q?AAx64LFQMH4VZ2yVclaD2BePBZk+7i5ipQw5aQrC2d5IVJp7CIjc/hmvC8jr?=
 =?us-ascii?Q?2VK6aiKtGJmWxH+7mie2Ch4LZ8n0dqUTTsIOGrgf3QhtqcJf1qTr15uOhWtG?=
 =?us-ascii?Q?Xs/9UtQdW5+FMCWl9FEsIjv+Segx6P+5mafz+iZcXcUEsZEaeNi36K/4GEiY?=
 =?us-ascii?Q?90grywIt5Zv7iZRNrv6FbFx2KR/Oiy41laQUMIZQeStqvAOLKZ2W64rIEi8H?=
 =?us-ascii?Q?zdRlEiPlqFZq8OWdoMD1X6ox2PgCWcrpvLl8A+KF/TNHQb6PCP9ZFQdo1QAf?=
 =?us-ascii?Q?ZyfyjAvJTqvaQDV6u5QFd9wo1gOcd/LL0BpuoFdfJyq7w+5ZjUN7tjrglc9W?=
 =?us-ascii?Q?J0cdnY9mZJi3dqjRSyVn3mzQu6eWrBaQmkKpRR7M70rB2FRfzk6Txxw/KatK?=
 =?us-ascii?Q?eRwysNCEsQcI2uN6feQNfcQz/VnZuU7hyhThbeCkzVfKX6hxkLLffLoZoDGL?=
 =?us-ascii?Q?1dMqGdxrbMJmsJUr3abF9roIJID210Bpb80v35qHV0qWV2YeOZd7AwumdmJ0?=
 =?us-ascii?Q?xtEC6HesZ3XeIoYWVwsfJXr09IYKoJoh2AcO8PUowITDNmBKHmq79yIzM7vv?=
 =?us-ascii?Q?AQwzGMnRvBCv5IfqPO/8feN0uQTD3uyVLSzs4BdLfKIa2ONqAhSdR7YsUZNb?=
 =?us-ascii?Q?BxmKjDsLMRPADkf5TAU1I2gEq+EG6rQZp9+Zj4MoKcFBGNx1KPnkiEDCrTr6?=
 =?us-ascii?Q?y+gdeV4x5KLt5I+6Y9PTihxnN9frh6BA/EB56QgXKa8r43r99Smg6uY9gaom?=
 =?us-ascii?Q?9+rnskT3VJ13hIXlZcXFT3sCowcBoMo1jSooIME2ex4uPq2mj9tyi/uRwbZD?=
 =?us-ascii?Q?iCAN45Wj6I8xf2KCiZI8Ihb9caxGFqzi+dLabCwI53SPC0qUYTaPg8e8WHFN?=
 =?us-ascii?Q?ububCegELdc+3Fb9mCXUr0INQ6LnOY3AFBWfTY3f0OlUT7bJEkvh95iX25Yz?=
 =?us-ascii?Q?LTTIoPWyYlo3pP6LHYaMOvqbQ8c1MhMj9SWAW75/CrswQMKkkxZa/l/v3HWU?=
 =?us-ascii?Q?13fszoi1/LE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4a4Yh0kyxI7hrch6m7Dw4R6nMVTf1rHQvkFYMJQRgYGw1Q+a/rnVS2O4UQ6Q?=
 =?us-ascii?Q?XHMFhQuflT89q5xwUoo4WTu86BC+fdaprPiPhHKLu8erQ9xqMYgjKGItp3tf?=
 =?us-ascii?Q?AsOFSwT5/ThZZ74pwPzR5bLIuaposcSfej33bz+gTBgtrY14TxGiiDAM4zhB?=
 =?us-ascii?Q?pV4ijUAF06N5+iLXXZHJF2/ANTqqJZwESLBfO99kcaclAiqblDxwARKXLvyr?=
 =?us-ascii?Q?u+PcSJICtytrVxLxADJCI1ambN5zv8VtLX3Gj1llgPzzfuNPDnrFiYS5amAo?=
 =?us-ascii?Q?bIhp6r0OCaJQuveT+AboAqtpM0+cWFOvcpEEV4lBbfg1NemO4ioE671A3r+F?=
 =?us-ascii?Q?o2TJcoCWut0SQallLWu6KpSNemXKZyXh5VyNZmZAAhwKyEG4t3Dn3BOLrhU/?=
 =?us-ascii?Q?aiu+cOeo+c/g1EFH7vlJUOy8bcMf5sOF0/AnTPZx4CmOPKfufuXv9lnLsgbx?=
 =?us-ascii?Q?3kNb1ELQGosxkGb0bw9ty3JPHtSH/+YlqduZtuBTvXT5WAC7ZpzrDpragArv?=
 =?us-ascii?Q?oZRvQRxtwA7cevpGgZ6zHpxPRooNXIcohi70VFyc1E9ZTpLjBP3qOo5bvKIk?=
 =?us-ascii?Q?5p7t9JiEyWFfaYmvEeoncCS4pTxdBCaLFIqhSoMExXR/YKnhX0k2gtGUPEMs?=
 =?us-ascii?Q?cEEX/nOJqTXpp2cfeS0bzG+aD8NYXbgLMTAPKEztJaLPB9wizdTLVxCGAyoa?=
 =?us-ascii?Q?gk02TQV0zi9y2yozOL7xtl9eEFBxwncdqf7k5eJ41//XEA92a00a+PowupbU?=
 =?us-ascii?Q?QBmMFrjT6A7iqsqAd8D9M4snGP9AToS0fXZeQXhsTN4YmoDeihFsimHiLOHx?=
 =?us-ascii?Q?/lVw36qCy2bTTuDtTrYs7+BBpM2Tezqx9p/ZzUPe7rmTHxKVmNAn2yDJVWgb?=
 =?us-ascii?Q?8g/OUspX7ERcVnzkkrDhfyc3yyCPPc7cXG/YRCdAla5ejEdWwVCRP7bcfKfJ?=
 =?us-ascii?Q?2fXr6tRlTUmbp4R/GAMaIaH4FUoR7z2G51VciIUr/ekBaeJ0L+uqQQBzl4GR?=
 =?us-ascii?Q?Y9pz1xjqstd52p0MOj8zkaVT1xrU/xu3I4uOCOEt1eO3ZwbDi037OXHkrQRb?=
 =?us-ascii?Q?iuvYQniJJ+QiggKWfZsth9bm2wEOJ8a48Wyz5VGv+eANTGqQHKFUD24JqMC8?=
 =?us-ascii?Q?8Sk8uBVCBEm9MjpHz7E5q/UpHbklskPdfdZhcA73lBG3zTSyX7wm1GXl0XnD?=
 =?us-ascii?Q?yL9MxRqZigqXOEYMQ37zw3iftCpDN5LqROz1NyZkSL5btq6j9CRssGsjAEAC?=
 =?us-ascii?Q?aMJyTeXiyAK2H5Vg69pxe0ToWAcNPwcyDD8wt5BoqPISsIathzAjttp9DWM2?=
 =?us-ascii?Q?dWbfLTqzdynLMD8EwyoBSAzOefXgCetxO+akcd2hIcjqdKjfvVIyiD/9YDOL?=
 =?us-ascii?Q?oMZhUUjNRpxnFLI3Seu2KadMIUzNlCSWsja82KuoAm250RnaR5Y2vliOXfZi?=
 =?us-ascii?Q?e1APSFkEvlQWUUJ8+kZ7x1jMPQtXs+lsiANWWZIoj0jNIDoqAe8RzBe/8Arm?=
 =?us-ascii?Q?dJeJ4QBIHrHH90vDeX8bq4FeQb54D4l3hbv+dFuSFGjl3sKBOsiBAS8G8gLF?=
 =?us-ascii?Q?EFUiKPiqUM2ekr4lDCAjJmZ4wQz+svPGIg6URd4O?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d66130-af0d-4845-83e3-08dcb127b03d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 06:12:00.0296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+QSOCDSOF+Yfn142NHWRhgp9x8hAwk8aQh2rWCA1Msdhc1XG1eYEj4SE2cNmklfUl+i/OKETM+kibJDnkdv/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6580

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


