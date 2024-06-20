Return-Path: <linux-wireless+bounces-9261-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EB690FB26
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 04:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE99EB20F92
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 02:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B732E3E9;
	Thu, 20 Jun 2024 02:00:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2128.outbound.protection.outlook.com [40.107.215.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8DA282E2;
	Thu, 20 Jun 2024 02:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718848844; cv=fail; b=tDS1hnolktag/3H2BhvI3drLtQwBFFT9ty4fnDR1bfxNmHfzy3gKUNGMXCtcTBlh9B/VPRefZAVUOnzK8QjHDnXmCv0IXOCP5qYBFW5HLeB+5dTv92bRpv033gg18z8MaIpg6N5JBZ9t5so00T8dtOQwuoBzUCJVLESbdZcWjh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718848844; c=relaxed/simple;
	bh=xJW+5hOAMUkFPGt28SK7hB1xyqMVx/KvSZ7fT2KIDzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sV6AnqpYvZccy1w03OxrAGkUtcnIjj2LKrqRbLh8KTDO/cn0NN4qchad44Z8YlohFR/zm7VM+aSAtrhMsUE3jAKXQ1Lu2gEV35eOe+L/4V5ecSfwPzooLgwdQAIjGmGyqiV6iSwd7xOmq0oTQaLZJ6RpbDiOjsTu0hIA9DLNGvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFufsblirz2lMH2CycigsI8yd5EDLYFUQg/hrlDtA75WH9Jecjg1h3YNIeRGste3EM/nG9exizCjKWmRPj4ljHSDJebP5bRmQsfa8Wj2DNe6pGXRubjUUCGUlFRrJT1/3xcDtFY5UAs1FiCSSsji5J/NnyNOqxrOSUqQkDbHFLI9Uuhn/uVl4Y6E/Y4uaJpuqF+kGAVcAZdhwP71h4bEyDCTB1AWqUIZoxNZQDsXN9q2xoxRocIXbxYunFpbp8Blr/pOXCLWtsMxOMmDa/hb0vX58IklL44nT0fEkkPT8CtnUFbwORCXCrZr6tY538GKsVEmNDIbUvXIC2vC+KKFBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6hbGoEs9Vr71hwrQ+0VzO3tMCpU/yX3mus5cqX6VQ8=;
 b=cEs8HzxhNamXOm/VM/WMn8xYgwsh/fmyRGqjSTnItrbWgavGGtDHMf5+EZgYbicZVl3x2AWBB3oae1Celqi/0CSJXVxiXnEKFtgBEUxiBedn8fBvusYZDnnL/LwKMrAgKni1yegPEmoVeBi6WiXwPKAR1LLV7klSuas8XOZjyACoM20m+osLUK+1pgtJJpgD6c6S00ojgAMPOEKDg+qga5qLa6VpH+jC9mqMjZYTLEA5I4k6EICeIc1ZydM2AVaSdglyE6TxAgJw3Fw/O1+wVhWyN5D7K4jqAn0uVWzsJeyLE1y8KtkC/MH05w29wsmESHGedDJzGURROymY8/AyBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB7323.apcprd03.prod.outlook.com (2603:1096:990:11::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 02:00:37 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Thu, 20 Jun 2024
 02:00:37 +0000
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
Subject: [PATCH v1 3/3] net: wireless: brcmfmac: Add support for AP6275P
Date: Thu, 20 Jun 2024 10:00:15 +0800
Message-Id: <20240620020015.4021696-4-jacobe.zang@wesion.com>
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
X-MS-Office365-Filtering-Correlation-Id: 46453918-9b87-4954-2289-08dc90ccc73e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|366013|376011|7416011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?krYlmyyAyhxcgjUe+S0xXL8S49r8oANhVx/+ECJyyd8UfSntPwPTkzPB1cGa?=
 =?us-ascii?Q?zh2tZl2gn8nDcBu7+2TunpF5b9noOG/waaISUXpiPhCM5t4MOE4bBlwClVkm?=
 =?us-ascii?Q?C6JMs75ziL40FRDXv65PTE7BbpK76EojgtxIBxhltPM8v5ZLmUgzwUCkc1aV?=
 =?us-ascii?Q?jXUP89bIsCpWwMTNaYPOMkjTHNxYQt/+/GeckFerQLZsMnlpnd/WWEc8spRx?=
 =?us-ascii?Q?hMkuD6MPpOGX6WKoRWG9rWq+Ak9S1vkjLIKa/AZ1AuLlhQ18DcpmKBRPTjXh?=
 =?us-ascii?Q?s/CklVpNIoSin8caJok26UGgqt5jAyYaJ1UwXSap7z25WKRq0hJHGkdKOBpB?=
 =?us-ascii?Q?5LLw9fzcEhsZBh6MT0iLrgfQBj4u7Iw2/V5asdUDowaErTatXcV7jOKtcA7e?=
 =?us-ascii?Q?R2H9YI3ffr5kCWF2f/FJUgkFVWE/oguvEz570rXTi/MUul2NmruT/XyuhcBf?=
 =?us-ascii?Q?TZm4WIi4zYfsBD6c8+wRdgZ2NFeOXrKDpyxgrizX39EwdN6bYS+/V+Prbq1Z?=
 =?us-ascii?Q?h/F3vT1c7mjlWV/qThq5XBE3AatsK60Mjr0ISWt1KPXM/A9UfujhEhm+AeUU?=
 =?us-ascii?Q?D6QQVxRJ8QLHBuy6NIjHf6o6BQsiHRweJoS/p1CXHiSl2FSMd1ldoRP8YBu4?=
 =?us-ascii?Q?AHXB6shE9FEoB41KPGLoW2DE+t4jqfot26ERNQ7/P3x6pNwDnFpjJlP5mS30?=
 =?us-ascii?Q?1FpSBSkyhhYogroAQ1Wznk2KovI2FhrlicNXPQW8/oobtgH5NS6fpJadwLiZ?=
 =?us-ascii?Q?+qTiXXWFS0uZ7ASRUray16pQeMPVdhqAXtEGH602zuoGgEHmlYTyvXNkuxjq?=
 =?us-ascii?Q?Ut0kNst9ywXr/PUoIQUmKQv9RiH16eg97iO/jR4OmM94/uFJVANlX07Srev4?=
 =?us-ascii?Q?/PgLk9PM5K6NXL9AjNLAjcBks5P4WiKXNgwYzpCTuUMf6vKh2ymc2yIdYh5B?=
 =?us-ascii?Q?lVBRkeMbWi9goy7ivuiMP1dJtzE/XFx0V1R0Egpr+t4XSVjdIpNL4ByPVha9?=
 =?us-ascii?Q?+0MXCN5GvbKLQgVh93FcZXboaQPYN1Mgf8vCSLAY9ROdMWrmrv7m/mWo/McR?=
 =?us-ascii?Q?SMb/5Z5fvPGpsn/EUvLgESUWVTC/KsTC+29VJBKRQCPot3wcI5o0vAclL/0K?=
 =?us-ascii?Q?diL4H7NgS4TtKxc3T1js1RAHZAwMe+QstR9/TQ6DvbEDysXQRIWQ2/8iFDye?=
 =?us-ascii?Q?i13YzgBYXxgn0Eyf0cX2DSaV6BJhymgJgkMl4MgJfJ1mCuG6wKPTmeczTxAr?=
 =?us-ascii?Q?O4iygmCclnbSVjkrlZ4d1iqwRo8V+t+dXNJx0LdWKWhMvdBpYBZhO9JNfilG?=
 =?us-ascii?Q?pp0DQ0Kuo2r/hAD1Vmo0wwu58mBJKgxtZAn1dWLfCEF260TeM4Uqy7rYTFXp?=
 =?us-ascii?Q?qNrwNJU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(366013)(376011)(7416011)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6fGwhQi3QihAEmZ6okwKe8fG0sCEHU6swgO232K63o7O3FN2wH4d1d0XJMVS?=
 =?us-ascii?Q?QeDSfhe+BfVCfILHOC7cWzWzfcoQBJ6gmNzmj0tVOADV3V+hlZEiIYnL/iiM?=
 =?us-ascii?Q?L4mKYj58jKMRb7nNJ5vqm4pXfPFA6oWuMXHIIa8PzzWeqUhwHdFhyAPiTiy4?=
 =?us-ascii?Q?osxWToZ/mtjfsyi6lby39QLMANZokkvaxIuebA/WQd1Ktcy3E76RrjeRixv+?=
 =?us-ascii?Q?YEBoOag55PsV2njR1EGN3FLBiHaJzI29iniiDGjW9ryHjMC+ipjIa2z2zpZC?=
 =?us-ascii?Q?y2nRSvIF1FHjWXuLRmCopdnVOqz4/h28oQAa0wyEEUtFza30JG5oGcxyGYNj?=
 =?us-ascii?Q?nbCFMLebfCswdf8Hk9KsuTyJwFVf0Wl7WqX/3244SS3T7c8VZDqTLwA4iTkY?=
 =?us-ascii?Q?0yebLj7AiF0K54qejXYXh9QvM+qFs8SRRYqLpZq2AdweXajtul7QIMi7eyjD?=
 =?us-ascii?Q?LbzQkFJWpttb9SHroDr9LVT4pYsicXtge/NmeUjFP28p/sHkdOtLBEw2+Dod?=
 =?us-ascii?Q?RdQ0j6AEGotJDpp/Krw0qs9Z0JSyHBKHokbq0+ViHlKw49mDe5ROO/lalGnK?=
 =?us-ascii?Q?3/FbIlna6vRpQkuQsGL7Fwu5eKqlZmVGWUkyW5tLVrZi3IPdChU5nY0h/WSf?=
 =?us-ascii?Q?N9qm8UDQVj2/2vwPv5K4hrUjDevnjwqNJCcEog6tk9TZDMKAkOynMoB1E7zC?=
 =?us-ascii?Q?AAejd7kStucvrbLnT6v5hZzxqfEnXgJCX89BiuiNqKLseQ2bAkt/MSZarRDZ?=
 =?us-ascii?Q?9wrxLDo3ry8Y2cLcY3gjHw0rphMdAXgEdgP9cH8pjxh87L4o9YKEpwHC5wQl?=
 =?us-ascii?Q?OOMwGbkWRnLRgZw73hAWch/5JcHriwChvv4Yfq9l1wCwb4psyGNnnJo5zZb9?=
 =?us-ascii?Q?xGKBFz637tCeykbHtjlQA3tHR/zRf3afpNIRNI336sNcw3B/PE1mTd+nQ0aV?=
 =?us-ascii?Q?j0+GcWg9GP169QkLys+0YCKKzO4K6j0Dr4Jc1lJx4pNh2oMtFHefX1BLYv85?=
 =?us-ascii?Q?4uueqOtyU2S0PYfdU7Ao/Sp2TtTk1TbItAm1eON2I4b4lnmL1nSvMcPSMO+d?=
 =?us-ascii?Q?WEQjEj0x3CiHsDS31d/dvFDR4yHqDtx2IGk5h63ohVzbZ+dn7KFAQGWakKo9?=
 =?us-ascii?Q?ZdVe/u1SbpyIyTxdsvlwz73wCnd61AzSeLMVDMh3NjuQDVcCshHQZe8fEYad?=
 =?us-ascii?Q?LvQUyaW3CLO809uv9soo9p/nAJhKHZdSRJ6CtFqeRrEqLJQmsFf3KtLH2OuW?=
 =?us-ascii?Q?mIBWI+M8/vJ8Mr7CIUS0aFI1uTGnbYJsDauWz8TpeITqaB5Lf5c/I3z1lbTc?=
 =?us-ascii?Q?o7P2RwD03rhLmJ1QhCCjNNpUzlCjpsELS/SZEvkqgi6I9GmBQDxPz1JwpgHL?=
 =?us-ascii?Q?YQFMxEiMWYch6c//73bzr5W1uO5O8FBU0w0D4Vk8lXutHqhbz19NtU1LAOPu?=
 =?us-ascii?Q?jiTIeBGdN3nGukgGD88ZEPxk7GcZ5LVgjiu0L/jNPtf3WTt1hl2DqdFtridB?=
 =?us-ascii?Q?9WaY5YonRzv2FFWBG1SSMtAWP7E8ICQz6Ikj4cd97DZrjms2M0HqXmR7Etey?=
 =?us-ascii?Q?8Xi7Vfnmkci0P58hmFT/lVoJzOs6nOhTdzo76NOl?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46453918-9b87-4954-2289-08dc90ccc73e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 02:00:37.1366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YKAryeTOiiOeVp7EfePtAGQ8sddXyadTVCmnvjnJcihw0vv0fIAd4GCjLX5l85Sqar6/MqSdDjCXIyyV+RjO6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7323

This module features BCM43752A2 chipset. The firmware requires
randomness seeding, so enabled it.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c      | 5 ++++-
 .../net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h    | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index f241e1757d7e3..add317731126c 100644
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


