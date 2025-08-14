Return-Path: <linux-wireless+bounces-26386-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AA5B266AF
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Aug 2025 15:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A831D3ABDF2
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Aug 2025 13:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D08724293B;
	Thu, 14 Aug 2025 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="IUZKNeLx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013041.outbound.protection.outlook.com [52.101.127.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE641339B1;
	Thu, 14 Aug 2025 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177356; cv=fail; b=iGKjkbCoX6H/+QQBC+V9ic4Ge90HS4hHjjU36P5r3tTkjEm9vbgcIVseytZFe8Q2LvOB6k+5qzJALEe1bw95s+VSWjQFR6XxZ9oSFnPDwin1tp0LWrTlJT/8fkmyD7b95dzlcGTJUkJ5FxOH/EPr51r059IV1e8M8pc9UZx66oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177356; c=relaxed/simple;
	bh=nP80jqJ2w/GhA3VuTftqU9WSHEU4ffJsx/wkDa5PE+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pqbLhO+88znlYznQ298QD8gpbGLEdtendapsx4zIGM5i9/PPAKbIsc1PcVzgo1JWVKnBq6wVI19wuHDX8mcNzdGhbsFp8jYEHv6g1rDQUMvxVMK2RtyG9zzvVI738aAKxVvyo+9iRR9pUhmfj8btuK3svQ1IIknkT3FlFJd2cVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=IUZKNeLx; arc=fail smtp.client-ip=52.101.127.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUF5imz7bqZzJZpEPp/cGothLGZDdwa/lGP8OgV4zATl4vjhy91zdB7rM3kfWJSdHDg45qjUWKNk1hskcv1RCRVp2Q30K9ktxapo5XQCy1hEBDY0Am5ZPrI3qUKpOp+2sEx2huDRQnYmAfvHw83KKdlzswP8pWy8ALzX1Lg5Tp1TQj4yoo+ss3gol9l8BPPzjO/DI1TpHW/5dDokBG6sCtZDTj5JmTRLAczUWdPiro5vGdWl4xiBv9ugoaoAcP4VNavNdlTdhjFIjhKwL5V75oFZemkuJJfviDG8IVEm9g0BQsUNpRPoYUMzpmqK7LUWHqZscd9k4n/RagF5fw4FYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbOO1/wVXyxI2Armrx9vcmuHsMi4zDu2gYxzSRBhQ1Q=;
 b=iIBC/9ToLEBPGtzTbjN+dtYCihrg/RbnkplxAvu1v5QrcmWgEDfmfmIloSIIsbUF4K98KDhCpzA4R9+23r0Wl+Aqaj0muwJQTN3pBKJk6ep4YO+3uL9hOOtQog9oPvGcdrgX1ODBatw2llfJ53xxQWBQV0NDGzR4nBhZMKYTF4IRkmgf3T1RfEQ7beNS75m36CDLJafsHXRrlEDzRdG0pI7B51m02tFaOadjZp6326AeIRjV15pFDsKkTG7bXvKKLS4nN4uVbeRARc0D2NCPMvMWb3t0VEeiH0UCYil9EmblMyxN96q2P+ZACxh0mIKXJV65rvuYIjNVkO8SWqgbBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbOO1/wVXyxI2Armrx9vcmuHsMi4zDu2gYxzSRBhQ1Q=;
 b=IUZKNeLxzowevpWWsU6cHDsr5km42R9y3nRY4WkxCHBAp7LEPRChNUyzm7smNG+OPBeYNtHi2dYA77vsGH8AIXl78Is7k3VhovU5h1RBdk1Ily/OD8mengyd7O98M1SMB7sHYf6R1JLoN0p4XRdRfyKUMMsYuxGu8W3KGx/NYDuH4KyNaUsRMC9aSvCPsD7OAwn9LCUh9+gzIhcEW+SX0WRZMNLzb4gVOHCz6DMU7OGz8/BBlJpQvEuPGb03cCaOHQKUHTr8+vujQqWq6kbiZicYzODIeUnRrXrtFRONrObLGzZ62cJ6qbXqeJjBy6VkgDE0Oo6WhPGrgzZ8KRE8NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SE1PPF01F59DA76.apcprd06.prod.outlook.com (2603:1096:108:1::406) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 13:15:49 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 13:15:49 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Rameshkumar Sundaram <quic_ramess@quicinc.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jeff Chen <jeff.chen_1@nxp.con>,
	Bert Karwatzki <spasswolf@web.de>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Cathy Luo <cluo@marvell.com>,
	Xinmin Hu <huxm@marvell.com>,
	Avinash Patil <patila@marvell.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2] wifi: mwifiex: use kcalloc to apply for chan_stats
Date: Thu, 14 Aug 2025 21:15:31 +0800
Message-Id: <20250814131536.231945-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0310.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::7) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SE1PPF01F59DA76:EE_
X-MS-Office365-Filtering-Correlation-Id: fe23ab0b-9e07-4b9a-8b51-08dddb34affa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n08oGs1eLiEk6XYZIObFjOpTYd9l1ujLZ+1jSBSbF22xt68roPIZ7wOKun4t?=
 =?us-ascii?Q?hFFwyT/F9QyqqDeXVRu6jpA5HzeMjz+wVVb5Dl/UOIV6PV9plsLvQZA37HSs?=
 =?us-ascii?Q?7RT4h0cPEFU5YPm7DKbkl5iPvKdFS5LlYYRKeprffHH39tgerGl4uj5vkn0+?=
 =?us-ascii?Q?WSOBU4fMyNfh+Twucf/OVArMg0SYNYN+aH0PBFFft1ro0sXbI6UDl/y34T8R?=
 =?us-ascii?Q?0Dhehzqo0HBp4qeXcgmF442wd5DeVmwmyQ2XLo1+HbQKBDI6/QNAiN1W7ZQX?=
 =?us-ascii?Q?djso7n2R2PNTAEc2hnT2P0/INmddIuiZsPDY96pD51I/2+rMUjblZmKXnWCi?=
 =?us-ascii?Q?ut9r9Nk09WqfiGc5kfMlRneyCufvIK5LJB+gNzAQx2cWmLoyPuznWr20BSay?=
 =?us-ascii?Q?P6E4XEPugJTUnr2itk6IlzE3JvLNdGOsy4MdV+OWdi+TmnQXijYQbXNeKAjQ?=
 =?us-ascii?Q?OcmDT8uNxpFcCQlWZwl5hgJULWBznJi04qEMJHYV/1b3iSNSsalp0I+8jw2j?=
 =?us-ascii?Q?RXI8FOM6AB6MaURnKJBF6ti567mRcBv1YoMn5mH6mE2iYoj9m5NPfP6E0Ud0?=
 =?us-ascii?Q?GuYHRbo86shsUc2c4XxFNmABPjKhoonLeNm45K+HUfByNPgcpPSQj/ws30vY?=
 =?us-ascii?Q?xC/a4wThapRgD0iyXMtsJb1JdyXGfcQr2xjOkfiedBR6EEARP6Pl2mVtJDCi?=
 =?us-ascii?Q?xpEQhQoZz1xfdyA09UFVLCR2gekfWxHqq3440WhxxuPMZjE6wtiP3OGfY5Hm?=
 =?us-ascii?Q?2lirKV3nK11AklUc5jOv3cLhr7a66TycQTHjJFaeqZyBeAForZwjJWhCLr6t?=
 =?us-ascii?Q?2bSy8s7j3D+av9oek9LLwOAtmYjk5OpIPMABOCGHtgbJdHA4Blx7Ik03M6B9?=
 =?us-ascii?Q?3UCCUU2TlRbFmLEqoTFzw47dPkuogMMIHVDZ6OYsuf9XHgLzpQ68H8ChDehV?=
 =?us-ascii?Q?Wxg1uv1gkLUE5mS7IQs0bSNb32K9bng3VsczGFCtBGP9yQ6vgBFn9XXhjyQ4?=
 =?us-ascii?Q?nUMq9T0RQ+DDAKHQGNRxd5x9PeJwpF/UwlI5Wux1ff1JyOo/SD7qxQ4sDx8S?=
 =?us-ascii?Q?4gRFQcugOQJo4DgcploxDxCizIHYGSOID/XWRltD+2caU1Wa6fww4UQAheOA?=
 =?us-ascii?Q?6Ms8N+P6I8c4lWIzUHAlYt+R4hVsg7LDqKyivpxdgLNsUfMcV9j6mokgMZOe?=
 =?us-ascii?Q?FdxqMEEYlEi+eTwEvmANqNUYSMYLGbhP+baEz1YKbuCwgu+/SGdMQiYeOmWb?=
 =?us-ascii?Q?CtWClIF+UxspuR81JzIOmSZ0wi8AP8kQK8sY9uEG5FaJUflL4d6WQCIRRqNS?=
 =?us-ascii?Q?DnaAobm2ylJW7gVvvoYtARKrN3ZFLyp3M9cBhnnCm24Og90Bg1v69V63BphA?=
 =?us-ascii?Q?esuKOMyWpSe5XNbX4+WL3w3Asrvx0/0d4oYdv+zBi405hAsOduwldQD+zHzM?=
 =?us-ascii?Q?6ARD3//pXm2rZbJyVxlhHydNlw/kr2KdWslakoxCD+2EbiS+iEBKolJiITr+?=
 =?us-ascii?Q?HCtRKfVwvQ1zBks=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DVSqGLUN7ZMXmcwVO4wXqOQlpl4vepMoyyBCJVoXUgsNrcYs8X9ekCrMVJyy?=
 =?us-ascii?Q?6lQF83EBjVeRobYmZP623SGgwEcw4K9yPXE7dBM/4jYjchxeOQDh4pKtiH9J?=
 =?us-ascii?Q?EvUwwAKaIqAuxJCnHKoL3HsWed1uX5qoFCXqg22ALWKg9dtJDykXwondUodF?=
 =?us-ascii?Q?UedDhPegqjfsmzXPTupaC7oYjYPeib0cHoFVUn4LXvRIohZTsYrch6Tpu7CP?=
 =?us-ascii?Q?BGkBU0qfhvVP4j0MqCr/DvJlp931U/iR/xhwMA8SdrsBcyM1q4MjiEklbTyJ?=
 =?us-ascii?Q?ghToAotPBK9qZ4UMZBgNBwwcXioSe1wCR7MFuW2ayHMxb+9e2svWbaDFAt68?=
 =?us-ascii?Q?VRlg3HqpMHq8XGg4P/Xthve+KlfIAgVJJfPqPSbGIY8NGXZlZIm5gNJgWxRI?=
 =?us-ascii?Q?uNJW8GPGe1UsDDhNnD8q3IdYuguWcpXupjuyUxE2bLsQ415V6r+sxP5rlyAc?=
 =?us-ascii?Q?PYSO1w6+Yly0uGblfae7tqoNbngKnxluIXtJQntp0bfQPOLENlt+eXNhy9Xa?=
 =?us-ascii?Q?uEl62S20obYlZBmF0Sc1FdLM2mfirDdw/vjzyNSNrJuUaSMG+pohF9KVAs/X?=
 =?us-ascii?Q?Uy2TbdbyXAJUiYOMAW6wMzEpvIfNaNinWp+yqEPc4yqnzJEpHECyLrL24cIs?=
 =?us-ascii?Q?cb7lllo4AF0SQ7fDEOJAhVvb6EzBVnBeLO3DbTNunz74RVKNA6qycSFb0bPV?=
 =?us-ascii?Q?9HrYgsQnKCYW0zFJ/DjKBZt0/G2qVcnSNvlCLTT8Zfrc6muVk80ti4yg5SlH?=
 =?us-ascii?Q?F3p203NF5Tpsv1m+Zg1Rzet/4L63LWv0vQP38dbysvS+9h/NeIJek3w/91Ya?=
 =?us-ascii?Q?eeXPoHXygDJr+panSEUvSAVYyEZFBV5usY49TQNX89lPfujtHcW1JaGsSU3U?=
 =?us-ascii?Q?5ZkaSmoYlfG0ya3LCETNRAM+hqbjts6IE9jqtMTMZJ0/+vLQf72TD4HzKqhV?=
 =?us-ascii?Q?pjnpEF4mATqgFd+ZnkhAQWlqX9oE7Ti5/7yfFikwlUxLUi7Wdkj2IK7WbUEO?=
 =?us-ascii?Q?zTG07oC8uSEcOWxP1UXuQTJdCgyeS7P6fl61x16gBcTSHLYIPgLjY3wbEtah?=
 =?us-ascii?Q?9z8CGlV5daGhF5cNjd2z883PFL/RHiwYVG3Re/DJpVGREavUDNArxUJf7V19?=
 =?us-ascii?Q?nybFV3lBqZ1jTTbn88zdVxNjtaPaNFXBsFyyfjWs19bBQtgvktG24sC1dQ09?=
 =?us-ascii?Q?ZFXSOgqiOJnB3L8f4ODNXTTVkLw13avsmCtgRnn4J+bvtRG+ihBRJX3OUf+F?=
 =?us-ascii?Q?S45JE3/R57bZXjW7d0Z7IIoE5scATo+09NHKUP6qZqOE28uVbNMb7+t5g1fU?=
 =?us-ascii?Q?ZznNbRFJNRP7/UCtt7YdFtCVrLagm5PqJbwLo70Iw2THkl7ePtCYBD0OyFIK?=
 =?us-ascii?Q?S4SyL+BwReIpOfDXgM4AV8IX+UqVw06vhO4UZvmg3PO66MNQmlRNci+dTaDF?=
 =?us-ascii?Q?TqmQOMvCMU2OBDIBSi0MIEKmm/wVTXg4G5KFcedjD4ZICzZFz3hbaJv77LWS?=
 =?us-ascii?Q?Je9Xv2M3FUAgKtCN/IN3vdMQGgDYsnPQeV7YllilNCaycXo7cyvd8rAe3KOo?=
 =?us-ascii?Q?Ezkxd8rmmmpe9AZjO754C/98jpYWQkukeM0vvz3c?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe23ab0b-9e07-4b9a-8b51-08dddb34affa
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 13:15:49.5542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OrBiW0CWfdPPk1Lv6liBHw3tUjua+feXKHHM9kI7hnqcDaT3sOP8a6BEpN9IMf3FP6wA13V8FL9Q+SLpfrHBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF01F59DA76

Use kcalloc to allocate 'adapter->chan_stats' memory (max 900 bytes)
instead of vmalloc for efficiency and zero-initialize it for security
per Dan Carpenter's suggestion.

Cc: stable@vger.kernel.org
Fixes: bf35443314ac ("mwifiex: channel statistics support for mwifiex")
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
v2: Change vmalloc_array/vfree to kcalloc/kfree.
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 5 +++--
 drivers/net/wireless/marvell/mwifiex/main.c     | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 3498743d5ec0..4c8c7a5fdf23 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4673,8 +4673,9 @@ int mwifiex_init_channel_scan_gap(struct mwifiex_adapter *adapter)
 	 * additional active scan request for hidden SSIDs on passive channels.
 	 */
 	adapter->num_in_chan_stats = 2 * (n_channels_bg + n_channels_a);
-	adapter->chan_stats = vmalloc(array_size(sizeof(*adapter->chan_stats),
-						 adapter->num_in_chan_stats));
+	adapter->chan_stats = kcalloc(adapter->num_in_chan_stats,
+				      sizeof(*adapter->chan_stats),
+				      GFP_KERNEL);
 
 	if (!adapter->chan_stats)
 		return -ENOMEM;
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 7b50a88a18e5..1ec069bc8ea1 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -642,7 +642,7 @@ static int _mwifiex_fw_dpc(const struct firmware *firmware, void *context)
 	goto done;
 
 err_add_intf:
-	vfree(adapter->chan_stats);
+	kfree(adapter->chan_stats);
 err_init_chan_scan:
 	wiphy_unregister(adapter->wiphy);
 	wiphy_free(adapter->wiphy);
@@ -1485,7 +1485,7 @@ static void mwifiex_uninit_sw(struct mwifiex_adapter *adapter)
 	wiphy_free(adapter->wiphy);
 	adapter->wiphy = NULL;
 
-	vfree(adapter->chan_stats);
+	kfree(adapter->chan_stats);
 	mwifiex_free_cmd_buffers(adapter);
 }
 
-- 
2.34.1


