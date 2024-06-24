Return-Path: <linux-wireless+bounces-9484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 089779144A6
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 10:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ABBEB23EAB
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 08:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEFC12FF73;
	Mon, 24 Jun 2024 08:24:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2090.outbound.protection.outlook.com [40.107.117.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273DC12F59F;
	Mon, 24 Jun 2024 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217458; cv=fail; b=NC5vASj0haq+bvBCVJIeZKghIatd7aDlh+XhrdWB1pfK9WavgI11hu6MRwRUh4Y/suk5mAgCWw52KXpUbYhUAz9l8ioiASgh8kEMTPj9mgp5j2v9H6zZZCppeYIzUs/S5oSUNSI2JB0WRPeN4RgF+u/5qqVzlB86azsmKFxaYQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217458; c=relaxed/simple;
	bh=aa3Zc87cZZGM4ZoC/rVN4yXQR9NZFRpX+bGB+i3jZrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SmC1Bl/Td5Kmn0gnw21/3BFxyb58pwUEH5ija465ah3QAOxQ1S6TcXNOTANGifWkCND8dXdlKKg85zdeVsseJr4VoSckUxCDTanxFmRICFVi7BS4n8mXQJfOKaZY1nL9S1sDXZOSyljl9Y6hWdhfnJx31xp339lBeFO4zDN8XOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2xGcBD4P9ZXdRAJP8KoHlJB5TGO4Py61+jpSdtLTBnn8QDmAlwRm5hJX6cawvuGjiyupCqq9wAYC4IGZeLHMpsYqEAbKyM+/LxJn59GiYPXktT7La4Q4D/573jeBj3CQ7ocMdCOCF7KpQGFA/TY2g/Rh+mE4dJxAcLbqojYBQFq9un6APNrflFzGcZgsyDLH9cVK6ojL+NDbWPY0D/+BBhExl2BsQSOdhk7LqYBW3x8nd1yMP+Dd+Na1V2mqT2Zt9+aZaKjnN8Yqb223gE6J4vJzyY+yj9VNarljqFLQUyhuhhtwrQlJyTvxLVn/g0W7RnR5iTJA6Rfvpl7YwKP3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1VU6okeg9QSC5RmC6WMkCvfbsrptK3q3ja5IoHSmII=;
 b=fW8XOZOQW2HMRMpxgjBtfdapy02IAva2siGm0kNb5Nytad6VY3BKOSzckW2DyvrNptVYDLnBCObKFkz3koHxNgjqzcgb+l5OAwE2pNMMFBHcPIrIXQFebZ6H7upIpEBxvB6ipLuCzOTk9AYOq8RRZYGQIzuqc/r1x3EsekLdpFg0G9u1Dq+E95daJokg419ceYNLQXsf/ovx/oF9k/AwQ0a8OYJ4bZ/M8jg2XnLDDvkbncTh2U2+EatpGkjCPJUWcha1FuZ/esttJd2mqY4GI48mmkxE7QSntiQzFw1kO7KsXFlSpjjXvM+dKH/RyDzgz8C81d4cvDWm9negkvRMKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by OSQPR03MB8600.apcprd03.prod.outlook.com (2603:1096:604:290::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 24 Jun
 2024 08:24:14 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7698.024; Mon, 24 Jun 2024
 08:24:14 +0000
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
Subject: [PATCH v2 3/5] net: wireless: brcmfmac: Add support for AP6275P
Date: Mon, 24 Jun 2024 16:19:04 +0800
Message-Id: <20240624081906.1399447-4-jacobe.zang@wesion.com>
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
X-MS-Office365-Filtering-Correlation-Id: de31bf65-230d-490a-3feb-08dc94270883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|52116011|7416011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I/wSpLyvHaPpzVXDHHoKYw/haN0nvZl7aufiYsWuawWF38X3T6rZM+3VDa1c?=
 =?us-ascii?Q?a45cOin6pdR+NfFUSYRZtjGrZQ9gHRavkdFtHbOGY8kJ7fUKJG+4tpjnQMK2?=
 =?us-ascii?Q?vIedfnS+GRo8bS5vuja9fcjHTtKDvQddxrNgYYlsp/fmpA/6foNZI4HIztcE?=
 =?us-ascii?Q?pelUU5WxTciM2wISJxFgM6lZDfzTup990mj2sUFV5CZu2jsoj2rgjokVUAA5?=
 =?us-ascii?Q?NI4paaa4CJkp9hD8IBMZFk+5aEXL1xusRCSLY3ewjKODKOFLWiSbXYPQ1UK2?=
 =?us-ascii?Q?5T2P+Bz5kXOH1V4ureN8SqLcjALewd4efHcn8x1CnBYuEnfYpiogVhoqiKUE?=
 =?us-ascii?Q?AJ6MZ5Ax/p4Mvcf4IDJGzFgxfsqoic0L9jcUmjrphwFBQYNTWhs3/i4G0OF2?=
 =?us-ascii?Q?rNjLuiqQaFfqWTALTdFBvykHZCU5whN7K7M+Z4z9ytiXWQPrKwk8o86zWmxd?=
 =?us-ascii?Q?Ac0LOYra47A8YIpGQY+8f+LKeq+6b+qxUOqCqqYBIG0Sz1ULMUcu44U2+BgV?=
 =?us-ascii?Q?03GF/yO0pQn8nnIPKu6Ywo46P/tzhqOQTYC6RoKK6UAjAtFXN8RnZYG9O6FK?=
 =?us-ascii?Q?3QF+UK5PWWhaE+aY1xEE3ObU6FB9GIdh6zEFAWHPeBDuPLv4e2X9NlmfkEWh?=
 =?us-ascii?Q?b5aLLK6gXG3ecerDTPKxkSvE+sSLi1e99Vq42kUOFBNuuP82GTQyNsY64FYQ?=
 =?us-ascii?Q?BZuyShIxL1LKrDBpVZmKQsqiyBeG0YAY/Y+zBVbsQJThqaQGSzkT93/JD0Kb?=
 =?us-ascii?Q?3Mad8jr1OClv4rJ/6snUez6eD539XCXrRKUHWf6aMCmJ16EHZlVasvHUojwv?=
 =?us-ascii?Q?rC4gnI1vE2lYLVB3pttT6KYTQD8ujaLDbj5bI3TPPOjCoxiQZ9sQxkKaOCbU?=
 =?us-ascii?Q?y24MEzKaizM3e5Rgp5B/0ITQGIFQRxhd87187JOdZolFFKv/W1L6VhhpJHok?=
 =?us-ascii?Q?vyXUDzZAD2tR0LAnp41LDmdZbkCM9LuIfpsQ6WcRyMPPsW303jrvup22Mios?=
 =?us-ascii?Q?VP1egE3j1RngLfmiQqFcCOSYNswEqLQf4YUydYJtRjajMt9SEZ6GNvyTnXKY?=
 =?us-ascii?Q?zw+BnuSnJ6y5YmNHbQyvlhSrHgmIyqSLXu8WlxBJkePWZY1c5/noZ3/7KyCH?=
 =?us-ascii?Q?5Pwksr+EKdB8SYxT5xcBcA+sI5BoKRBmXKqyaSlCyY1xsggvQ79XS9EEXDtn?=
 =?us-ascii?Q?zLXtQHxDiJlgkewnopxZco0bp4af3fIRj4cWtL7h/WyTS5OTKtcmYWWe2ZDY?=
 =?us-ascii?Q?3cBH3QB/w4yscu9QkJqIr5btf28RbJDnL2egDu61/uXmc+fMdG/J1U880uGk?=
 =?us-ascii?Q?Hx7LQL0N7TPTmxGSyZwkB1d1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(7416011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OkJESjpYe9lDzPEzN7gEUKeqS3KxANqEG11d9AE7ml7frLGCoWEdp2b6CiD6?=
 =?us-ascii?Q?tG9fMgYJGonaKm2EA7IH3az4mavv1fsLAvOvsFn1vH0BDgpPPQRbLbeBUIVb?=
 =?us-ascii?Q?Qu7YExbyNs3trFecJLl/YrB6qHHm0c4jMdYR74E7YCalE/KzemuRG28bccn/?=
 =?us-ascii?Q?YMhDILxZAmiZ4fUHtQU7tKXkQX9jVgD1oPype6ksj010rpoUrCmqwIyFdw/q?=
 =?us-ascii?Q?X9h5FzSs2rXz/FBAENI0Y9c7Gb3I0q9Yw4ptTNsTeoX0qYX42vZ/9zmSRjR9?=
 =?us-ascii?Q?0LuGmHQv4onlEJANxxyBf5BdcJ4EW3LbmOnSzst1Yqr4OojB0JJC6yZniYbo?=
 =?us-ascii?Q?nEiG19SENxJ5L1Him8b672XVJptTZk06IxyQPUalAh7DNp78tK2vglP1OqFT?=
 =?us-ascii?Q?rG5Gb7jCf1HHhEdlRVMtMinPT6KJJeGMeAe0WsgAmuhrzTokiC3gxUR2bhHX?=
 =?us-ascii?Q?a9ZztiWv5b2ToW24rr75j62iErjGfvJ6s05m1EwaNFu5Rlw1eY+H4VCyIInk?=
 =?us-ascii?Q?aTjSM78kdKwU8ZShYLJn7wocyOzMVBM9SAMJVzD4Ts+A8Vc8kRG9vDSBKdJm?=
 =?us-ascii?Q?zPJTVQ6nPZOyk3+UlFEYrNVGDR6ZOyvOkbKoP9DSUY8aoqLcF3MHQHb3EsM4?=
 =?us-ascii?Q?qQ/Bpm69Zu5be4DXIpti5WgNA0IcjVhf2lQOCzZHeBhAuv84+4DDgh/68Ejq?=
 =?us-ascii?Q?BIBUIocaWecPvxnaC/uBvfzj9A8x5/Rxetq2PbiwWPk5pDOkc9+D+VZE0XqX?=
 =?us-ascii?Q?sxDLphfo7Gz/wxG82P7mGhFwSUYlIbI1iokGJqjUd/vq1trNuDJmWNIJrNY/?=
 =?us-ascii?Q?BS4TNECahc/6YCUdXYrruX8N2+gBB/2DWtV2QdieZ1N2j9wEl4UPsxWv5tPE?=
 =?us-ascii?Q?y6L4PbZfqNu00zAYUTDiHS7pVji4MbMtjwNs/SKEw8sQkSbGX5qKRALYOJYF?=
 =?us-ascii?Q?5LAyYg+KS4QYf5nJAfZ0oSh6ARovaV1qmlfye4m5HeXMTheyO1jfIO7jPr1k?=
 =?us-ascii?Q?d9PcX5ACJd5xTnAHa5NdXaanmUoBIrkHvtPWaRR3FnljigCpwla1ty+P3tXH?=
 =?us-ascii?Q?V7U8nTBjo5Ufr2q6Y1NHT2VORCXfRcfisGj18REZKbR544Pw945ZQ2zfHfMT?=
 =?us-ascii?Q?jiYr0WHs6OqKB/aWWhwCLSLmNkg/Ne+EAALr3k8vMGAd5+hCQfiFk97HRK+8?=
 =?us-ascii?Q?xpxi8p3anMbv8yjjO07pmxBSwNdmxUpHfe3azI8k9Zoyq9k/eQdQkg5tnCLO?=
 =?us-ascii?Q?OUMk+pecTNRCAg+iYEpGPcq1VwbI9fCtW4/7ei0QwNv/GOzraiHIlRhsWFMj?=
 =?us-ascii?Q?OqjKw+OeGsPbgO44X8Shqd6CkECaMshY7904O7ioAsYg/c+EUrnk5LqA1o1P?=
 =?us-ascii?Q?Mf5e32NvksH+IZ65iA6KMbzDRhm2o1ZQryMdFbXe4gD+5EMWBOcJ0XLVk8gg?=
 =?us-ascii?Q?fdi/SS9boQu2Bv0iocQGaNgFoWoRzaKaTSTM+mu5cIfoJyj0z4lgdGkoPbet?=
 =?us-ascii?Q?rX3AiFD+nGZo5lje3uu1lrqVNKBHRfLOo2YgAptK3P+6aPT7yT4TRzT4ZU6q?=
 =?us-ascii?Q?1jZyQ8TK7dzyio3EmL2G4egpcEXtbZioHLl417+J?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de31bf65-230d-490a-3feb-08dc94270883
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 08:24:14.8401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GN2Jyfx/mWC+MZrHOYtCQoKoXApgStgGqwLasS4sQnv3ZFsRfhyq+lQDSKBDoU+V57rpGYWlO2USsHg7W3yzMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8600

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
index 4a7eb83a60ffc..8b9574c5c65a7 100644
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


