Return-Path: <linux-wireless+bounces-9707-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2603891D063
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 09:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913E81F21A65
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 07:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665AF8289A;
	Sun, 30 Jun 2024 07:36:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2122.outbound.protection.outlook.com [40.107.255.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EC482877;
	Sun, 30 Jun 2024 07:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719733002; cv=fail; b=tToMoMa21FKqk4+7iVB+9wVIWYKCn6BDG/C4Pxjsz1flQJELpeZc2v66VMoLepzXG7TGc/yY9n6aX2mjBggjYKN5pYlyYnqps3dEocMYcn5UY+4DOINMdFPyonlWHmx11feoHZfqfszwBpaGNwZKh7UZTnEmRS6eHzE3PKLnB9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719733002; c=relaxed/simple;
	bh=e3gML7NJXs5qdfudAa4mM13hXM3duxaUl2VLFmBf4CI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P3rslRXJ1DkisPw1/Nuwv0rU66AHMoR7FN3V9bAKGhoL9IJp9UaGRl0xJKoffUcoS1/xk4mJ3e4+1ib93jsIEFsBGEvx8M2DBYrMzXvf1c8TAQbJiebrGxHI/cUOsjW20Bq3pPnSHCeF3Io3wyOVbwnUtJrhUxy1Ad19JCsb/pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPsepNcotMOunPTnnt4biVU1y/R/aSnFrneqNxzWy1K5XpUzNUVcL9OZN0Bgl6uX9tmey9M5bEq8INFjZTpZcfymiNlqNrFCe37u0vv80gpLn1Xpar5119JYbdE8upOdrIfKQ6V2GbsuagSA0n1GuK45RKBzBthkzzERsVCcXun8by9/LXrSFtib6l8WmzPaUWa0mw2ffVdrSoTI6WNg6b2xO2Lj64YZha5icL6V2zAJsvX58zY+r9B3Wq8owXYUBwwCOmJY6HTEjiiC/hrq1tlXhEt8yTkbKoH6hcNYyKeuFKqL/Lt5u4YFjoUImhBmzITGr3sNnM5uXXQlrS1bVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9GpoB9YSriQyUfrZMMQ//GtBq9K+fFv/f5hcLUciwY=;
 b=XSkcdRjJK/+8FxyqGJ6TMtv4EaD+QAZhOXhGI1HYpPe5hjx0v6l7Kdgz9EYuvPQ8QM1JvR+3XStWjNoxy0ttZgRbK83kbV4SjvqW1A5tyGz//RyZdKbkGwGh82Xlm+EiwyAGCzgjuBFAmAZnWxW22agP3vsmpb8KFGNvQ0eodL1vA1ajJF2AzVlJsSwTgzSy2pSNf8f9vp1USHfMXnJ93hXQBTlxBDhVpqHdFDPK2uqn1r8gSOaybf2HRgDrVNpBo6IkJ8oB6Std/samOzhX9xBOJK8MxJ7expNXU9mHOQrX1wujAnPwFLbIj5pD0PJ6/7hXtGsYHhZ9fb/95KC0IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by PUZPR03MB7234.apcprd03.prod.outlook.com (2603:1096:301:118::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Sun, 30 Jun
 2024 07:36:38 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 07:36:38 +0000
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
Subject: [PATCH v3 5/5] wifi: brcmfmac: Add support for AP6275P
Date: Sun, 30 Jun 2024 15:36:05 +0800
Message-Id: <20240630073605.2164346-6-jacobe.zang@wesion.com>
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
X-MS-Office365-Filtering-Correlation-Id: 557f03f4-a4b0-4daf-4dc7-08dc98d76086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cc51rKAHwu+EcfV076dKMgQZwJZKmAb45aQX125k8wN5PQMGbsXf9Q4VapvP?=
 =?us-ascii?Q?RlT2ro2HOd3rvX6l0EGQkhRT1Qjonpve5BjIkQzS+/q+15s58tMI7yF+b7iS?=
 =?us-ascii?Q?Rvr+GmQe3Xh2fMzBvo62mDT410oAzi7Q1CrNvXHNNrgvLBFQRK4R0XIjfUh3?=
 =?us-ascii?Q?kHlp+cVMUjae4RWjSJNnUW3Sel+cfEcZYgRk+ew6qFqRhZOxt+VjL7Y+o2RD?=
 =?us-ascii?Q?9I2//ZPhDfPIuodak7FhNY1ObyMIrOWy4K/5xeF4qti0GqTwWfW75PPWqCkl?=
 =?us-ascii?Q?niMKK6JNPVoB5cS5YmVc13eS6Vf4O3cDl26NMOXSI8+4utsesXvI3S/NyWeW?=
 =?us-ascii?Q?JJezH99ueMban9yngJ06QK5kWB3xVB8BrAUezRRr5XiquZlRl0i2xGU/wvlB?=
 =?us-ascii?Q?G43aBB8TsxLGC9d5ORLgBOJhYkvoBFe90bF+Ak9NvLVfOgYNCc2zTTDqeCp0?=
 =?us-ascii?Q?EzHlocPICsGKNtT0fkAlfvCCvJtVq2YJKMWa9i8VMXfjmpJkhF1tz5pLdEf2?=
 =?us-ascii?Q?jImb63KkWQ038Xov55MCVGQhQs8Z2pD7dX3VN6beq/WP+k0EJdI5a4fhTfDm?=
 =?us-ascii?Q?Eze0nJlUEpGjS8WalUGlrmvJhp7x1T70UUc41jaasSxqfYZejVly0WyZbYh6?=
 =?us-ascii?Q?9vYPMFejwwKbEQRNLWqn7WCbfiW4wyQb0F0FALVYHSbOyg7XXEt6X/NW8Pwu?=
 =?us-ascii?Q?o1Oen1GfpAcizj+hsFXdy/TPAbHwXE3/P2jLfMN7jq2fx/VqX0OmQGuuW+P/?=
 =?us-ascii?Q?i5JOkPPb79u3h6yYyIC94dLMISmbjKGN8VtcLz3QlqDfweMkIvM9n11sd0Sw?=
 =?us-ascii?Q?2YNNr9EkVaIQqlBW9ej4wSkNLl57zq8jzakH1BGWmXGYbmHEQqOagysvFTOW?=
 =?us-ascii?Q?udaXxIPVLUc/6KjTOXd+kLDUpwglMb5wjVxjhB1QeN+04Yba/GjpwBmSX4+P?=
 =?us-ascii?Q?r3X6IAN0cZOmGVdCFvS14Bjvtzq2I0CKMjueM1Ld0UP2Puphb8Pi6rvHdZpc?=
 =?us-ascii?Q?9t6pYm6IbKQjvZJtt/aEsMdCqXSRfiiSjdoWtlEZhBMn6a4oRSYmc/l5XIBt?=
 =?us-ascii?Q?ysWphDmSVSvBOEBKnnDFZ8ibBpEq5BXHe8qs/DC19aOvOaFe/SJWS2gMgt4j?=
 =?us-ascii?Q?nkln7n6Ov6X2x1BrAxM+j5QplKZvXj9D84OUY76ZsXE5dzuG2zmIHhA17Phn?=
 =?us-ascii?Q?HuXKQBZlAl8PRdOm9SfgDvVO0xjzVnxdidD54gBN+P5iHIXIp8tlzd/R8n3U?=
 =?us-ascii?Q?frEOpc6z42IyuOvPGnPEEHesKT/ccV7QrAQOshIhWe4jrIUuqxdUG1fzqGL/?=
 =?us-ascii?Q?vsNSg9JuRQW9t5G/CrDC8itGwSqhXR4nzPI46eQsoD3Ob9aghVQSm5s1mTDC?=
 =?us-ascii?Q?4ASXrco=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?exUfGdqNneBlxGYWgEgm6rKDX5MDlZhNCE5Nun0frHZ5tMbyIcDMf1iGfoyC?=
 =?us-ascii?Q?nBmBTvpQXgISpSaRTA4SmQSY9ovA3hvh/k/n4EWk+EwWSXObe3aqXi+L2w2g?=
 =?us-ascii?Q?QcztqMyKMowdyxql9MXqHVHpdLuLAyj5RF/SyukXBWM3lPf8I4J3JKhrkhyu?=
 =?us-ascii?Q?jqGbft+IqRjvpRmCNoGaNbCFUcCNg+tzoy69l1FrBDBp9mkluXCaLxIi96lW?=
 =?us-ascii?Q?XbeLpqTUWJo5rWe/JLiA0PhTRHDtqHNr1i4FOEiPGV8J+lLRjXh3YvnGoTFw?=
 =?us-ascii?Q?S/EI/M+s1hwLt6j4juv6sFvHz6NgfJYY4fGQzfPME/OOPJyCVt0t7s7/osmL?=
 =?us-ascii?Q?o5+vk1n/Izb74aOeTJg1j2oQeZ+KRt6Y+wfSLMOsVA38UgX6ykrBVCsJN91Y?=
 =?us-ascii?Q?gnMDDyuFiHYl4LrN36O9lEDC+UvhDRFI6ogTJ+RO/oVL4/CH+QX3YLjLfh7j?=
 =?us-ascii?Q?DkwJQfJpOZtaEeM1lU4aq/fWrvJ+HFUDFgBNxfpmfOUkaUT98VArVIqgT8XR?=
 =?us-ascii?Q?nkYchvMd/6irgzRsg5Ln4vZjV+JcruaDGMEJVH7wrffLMVMhQPZVxdLOdE5i?=
 =?us-ascii?Q?e2s44JpBM9mcsAFg2fU52ISuKsBGb+xzju5zhNCf543Zmii1VIr63iLIc5qx?=
 =?us-ascii?Q?YNWGBP+rZYVraX7Y3P5/+E0k7u5O0c4670GxPDxibUC5ki83CqQZdiNVYg0w?=
 =?us-ascii?Q?BYU8OALInPgXRP4T/Ft73dvG5z+LHpNSoYpovqOhM5N1MqIyCJIAyC1cizRq?=
 =?us-ascii?Q?GJj6as9xEt5DmwaoX3Huhl7MpXwHQccUl0F2+gSXaV2G3Pr1/7NxNlLRcxrY?=
 =?us-ascii?Q?5FG8kzqyEler/9gepiCD81Sy5g7GPpgEff6CG7EyCeHA0qFXz0oFiAotwIdr?=
 =?us-ascii?Q?5RoQp20JxBrFg9dQuUtz/280/HPW5IFDIgTLijGPRR8Fua+X3c6648HMEtxE?=
 =?us-ascii?Q?RRjpzC5iprCApkaHZJA8PP5HfcavT6Lb7G08wyZnz9co6BVpsISWixTcq7aT?=
 =?us-ascii?Q?tP9Kwas2hErFvFDYEJlJM+pz3XZ4OGwTeDI4cNJ1EkKKI8vGVwVxyPALL1Oh?=
 =?us-ascii?Q?MxqTyrWMZ6b8LdfzWUxzApWTBnzeqMaqoKndmnzrFJl+YH5NOybXH57+GCid?=
 =?us-ascii?Q?X4lbQSzVOMczbHhGnIQ0AgbVOTMwAJG63WmJroAAVM2hgOloZpXykROTrg2m?=
 =?us-ascii?Q?r8QXcoY1J0azH8hhcdmSfRSAaVGZ2LztOBmblPJiZd4Y3PzO03tL/1q7g6Fo?=
 =?us-ascii?Q?Ej9Xgeuo9tKyRl5dmjCHsq082Qpz6UFKCac9VqXArSkFR1FAwA6dHEOhUB93?=
 =?us-ascii?Q?3La95ownqct4Y4QJW+CMdahEBAQeADHWNnPVZ4DU4fT/FgTVJiYqMAVgpIHJ?=
 =?us-ascii?Q?aIxQHwxNS6f6YgZ1lF+iEuCZyfXd3B7FCRpwhq1vURu7Tw62CGBvMJfWES+E?=
 =?us-ascii?Q?A967hB1Jbux/2cf2AD4FdfhvEgo9HyXE1FXQzU3muCaJzSAUMtruyeYipaxP?=
 =?us-ascii?Q?rCWou7ZoJYDNRrnSc1lLPC2oNgfoy5DDGPzuc0kYYRS0H7n57V9g6Rol0w4G?=
 =?us-ascii?Q?vefwQg0pZkW00qnHRnp14PrWglai3kSBMPIan9MA?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 557f03f4-a4b0-4daf-4dc7-08dc98d76086
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 07:36:38.5761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ey8JnUKQYV2xSbmEJWv3KFIzt/G5JgplRndlpe6UsnhNv+GDB2c51rqJ0G3RGFwyDX4eLTlCoZn9WgpUH4BeMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7234

This module features BCM43752A2 chipset. The firmware requires
randomness seeding, so enabled it.

Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
Link: https://megous.com/git/linux/commit/?h=ap6275p-6.10&id=1a99573bc8ed412e60e1969c0b29d53a0e5782e0
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c      | 5 ++++-
 .../net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h    | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index e84f562fc91b8..f427d664cf3a5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -71,6 +71,7 @@ BRCMF_FW_CLM_DEF(4377B3, "brcmfmac4377b3-pcie");
 BRCMF_FW_CLM_DEF(4378B1, "brcmfmac4378b1-pcie");
 BRCMF_FW_CLM_DEF(4378B3, "brcmfmac4378b3-pcie");
 BRCMF_FW_CLM_DEF(4387C2, "brcmfmac4387c2-pcie");
+BRCMF_FW_CLM_DEF(43752, "brcmfmac43752-pcie");
 
 /* firmware config files */
 MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcmfmac*-pcie.txt");
@@ -105,6 +106,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
 	BRCMF_FW_ENTRY(BRCM_CC_43664_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
+	BRCMF_FW_ENTRY(BRCM_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752),
 	BRCMF_FW_ENTRY(BRCM_CC_4377_CHIP_ID, 0xFFFFFFFF, 4377B3), /* revision ID 4 */
 	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0x0000000F, 4378B1), /* revision ID 3 */
 	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0xFFFFFFE0, 4378B3), /* revision ID 5 */
@@ -1721,7 +1723,7 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 		memcpy_toio(devinfo->tcm + address, nvram, nvram_len);
 		brcmf_fw_nvram_free(nvram);
 
-		if (devinfo->otp.valid) {
+		if (devinfo->otp.valid || devinfo->ci->chip == BRCM_CC_43752_CHIP_ID) {
 			size_t rand_len = BRCMF_RANDOM_SEED_LENGTH;
 			struct brcmf_random_seed_footer footer = {
 				.length = cpu_to_le32(rand_len),
@@ -2710,6 +2712,7 @@ static const struct pci_device_id brcmf_pcie_devid_table[] = {
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_5G_DEVICE_ID, BCA),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4371_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43596_DEVICE_ID, CYW),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_43752_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC),
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


