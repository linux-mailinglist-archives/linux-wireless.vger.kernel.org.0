Return-Path: <linux-wireless+bounces-10652-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B93589405EF
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 05:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD92D1C2261F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 03:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965C218EFD3;
	Tue, 30 Jul 2024 03:31:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020083.outbound.protection.outlook.com [52.101.128.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A858614B07E;
	Tue, 30 Jul 2024 03:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722310290; cv=fail; b=YHDG+23W5L8FKOzg7Bpv8iMlJVCl0MVpYDXJYXpywGmysuHU9KFH42SEFrgrNLHQUe7WcTveiS4OJESfoCgqt6AbaN1xiMpyH1pMOvsplwzDWKf7hIAJaEISj7Q/JtlLNjC0/cW07FDr3EAN1znVmp7TCJyC2zzDF1Nez4uTp8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722310290; c=relaxed/simple;
	bh=8fr2le2RRkyBxxo0cMbqgGIl5Pqcs8qpx2qLsAezPSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rLfuGIWIIV40H9SJAnyzgNUU30Ku5W/LY/HlE/10UvHvUfTtS0i1cXT/LFvbA2h8Pf7CDJXb088WnvJsan76AH0zqxQfAXJv1+mld6CHBx62VoroP863Pqb58J1cyY6cde+krKIQnj4fsj9zQ/D6h+48de45uqb5SwhRvskDTHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=52.101.128.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7PCdMB15Z85A4n+vAZsCSXhwCOtNy1wnxkszpPp/KKh0auSm/UJngUOHayLM4F3mGsBvxQI3G/L9MizEuuazUDjxLSbzf1ef85bFH8uVI2SP/S8iKyxOZVmU8HnV+HfF4sUO8bdSBeOkVFnV9g8kjUhbH0OJ1O7jSwHj1E/MEXAKSvuxpRGJo+jw6WExYWu8mlFlsuY8XIZIGYynat3emFqXPVy2KQ2unNh9Y8RVPtcNMr5mr/3kpBZWUaRmO2OcPWNyWE9LOIoRe8vri7kOPgjx/HnzJbxoAMROr62z42mZNcarsJCy5JmhuOG9Ym37YfRIEJM7YiIJ0annnVxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XB3tez9D3u90dIBU3uiBuPnvK5S2Zx5c0jWE2G6mkbA=;
 b=iJv2oEsgUurQ3uQXg6X0FVKDjaYVvAhZR6MRlOddqBshDc3yXN8l2NepA46GZdDMV7ClBZuCJK1uTw8w0EMokyesJn0eZJlw8o0ghig80t7Y6gx0ZQpg9UNHxG8dUQZTsJul360ydCU/40XrdrY5Fgv2Z1cCzh6F2Rko49dZFKABh/4dAlZPUKRI4U5AUXD0KMjY5yrU2tWdn8Q0PYMw6ATmRDm28qgVCKEYUVqUJaM/Cf4q2rbAvPPOzuhDfQ6aFO7uXstPKDJcopPwTq4EfIz0doMoOYBiWeYftGDQjkMvEe2RqZSQ9TSMlrT2eVUH/XMMT/JPKAAEg1k8yKH0pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYSPR03MB7705.apcprd03.prod.outlook.com (2603:1096:400:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 03:31:25 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7784.020; Tue, 30 Jul 2024
 03:31:25 +0000
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
	Jacobe Zang <jacobe.zang@wesion.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH v5 5/5] wifi: brcmfmac: add flag for random seed during firmware download
Date: Tue, 30 Jul 2024 11:30:53 +0800
Message-Id: <20240730033053.4092132-6-jacobe.zang@wesion.com>
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
X-MS-Office365-Filtering-Correlation-Id: fc1cd126-7959-44bf-d137-08dcb048174c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yx/m4UzZm/P08RoNvCzMKUTupM+fl28+bW8ZbHEjuBYiU3FsMIK4tFjtu0h7?=
 =?us-ascii?Q?C45AhfGxBXIwmjBrhsE4XnyacF6Ic7UrWOtc0aMWeDa6tVdSV6GgZpta5ssb?=
 =?us-ascii?Q?wc7/BVGu0GY1wTSPmoLM3N0uTqgTQmH+kV1nlMPyeEpakLPbkLYS/TYElpxO?=
 =?us-ascii?Q?5IVCHPr9tGpyrL29BN9/5dRTSry1u0jMuLyxyjB7152fHiNNm9SKBxF2zdjT?=
 =?us-ascii?Q?M6kFZA9rRFXHgJHcRL2AQ99VWnco0k90KRpZ2LIoKG9568bk94hVViMSfZK/?=
 =?us-ascii?Q?tH5pbBryYMUg4+8M5D+RHenwxSXKPZbjvHj7h16aENdNWpg8/RjdTTfLfoY/?=
 =?us-ascii?Q?Pl2Zs9HEsVPtjczqGsZ8cU7OMNdsZhYhWXBVABJ9//nLrEd9pxB9Z6uH7T6v?=
 =?us-ascii?Q?8Dy3eB6XmMdLdr8t8qBC5e+prwJ5fUDtV+yWeKyxSLCf3vd/rWl7uRfk2Ylq?=
 =?us-ascii?Q?w9b2QprrW5ggHaRByRF4n3kAQNqUqi7qYXyRi1ngikSdDiKzvljXSsrndvt8?=
 =?us-ascii?Q?xisd9FGjfrEYILW04b1g64GfgiAK5py9feXqMdKbV5md+153NJzu96sSqbEK?=
 =?us-ascii?Q?+aTn/GhxxEOF3WY9CJgDdfljWUKbe3njthhtjQ5pp/u3PCiHJWH8vCUzJ6hl?=
 =?us-ascii?Q?cpIa72cuMttwMlUIrxxbny/EjsQQ/vi+RibuPvBhQfWTla3UTNcedz7K0yOh?=
 =?us-ascii?Q?OV9KJXtOnlDCzJEUxNlCWUdeQzWQ8wgoezydGZhlGUiYRsHVZ39aaSxpo6cX?=
 =?us-ascii?Q?7roA+7nH3b6RCDlFyXa54R99PBoZU5K5AWF8FeZZB3bUGGYEIM25e6O3eJ/r?=
 =?us-ascii?Q?Bjo8Jm7h5F9zQdp0/l49ESjXuj8y+ZajTuNN8VrdLoJdxDWiEOQ4+OOl8PHR?=
 =?us-ascii?Q?zLIneWV++NI49fvezTor1dy9guoOMs3cZ9fMOKitcdT/KzgnoJRLomL3iy9R?=
 =?us-ascii?Q?NZ94ffCBrsPWlrjlxKbnuHNPUc53cSg9lvuguP2Z6ll7L0+KWHjIzSNCYP0b?=
 =?us-ascii?Q?29d9z9kISOzAxC+XsJxKWYavpkRa0KsumAN3o35FmW0M60Cw7o7/O3Ot9ogr?=
 =?us-ascii?Q?Clkxjy237GlTIUIlX+TDxGMhjvSfEpO65YqL30KAG4B9Aw6Cnn+SjO/JZU1/?=
 =?us-ascii?Q?tRu1YzjjBAewLKc9RcVqiNIiRZBcIXszJcTjxTeKsk0xPxL4H9r+W/eqMke7?=
 =?us-ascii?Q?0IwaPfybqcgLwpetc2tRoFyCCPnzkEGOQjT57Gf1a4Ie4FPfCUsjz5Ow9t41?=
 =?us-ascii?Q?83ux+DW91kcUP3gVLsxRiQCXwhxYv4xozoYHk91FiwhO2jPivEPULYAFJIx3?=
 =?us-ascii?Q?x+QZj3zGlsSqiyO3H4ZNQGsuT/LLys5KfUi9BOHMPHqWu87dos+VNYc+tNRn?=
 =?us-ascii?Q?gXMug2ha7GoHZN0Bw1bAtxGcjYXmaDmINFiLz8YRdN1mIStxhg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O0RegJ3PDUdQgUp0ssB6gRiwSqlNA++ViwMeCXPcx0Zw1Vjf4YbXtyYkbRWJ?=
 =?us-ascii?Q?zAe9yYugaYi6UhFmuUEso64ZLOsE5JMmyHYgtE3mP+HYmu7mOQE33BfvvUq7?=
 =?us-ascii?Q?YYe8UJI64B3KumgrLiTi8Fm1KQ8VPU9tCQjsMqro2Y9YUwPrC7BgFc0NxFLF?=
 =?us-ascii?Q?Tatk4mH7RLUfKgNiDRgs4dRB60LiCXm3ykyLV6X9HxSF6N7qznHwtov9XIzs?=
 =?us-ascii?Q?Y6P1HZYOWCAgIHUvPZmuM+BpNLZ5xajRykRuzOt2dgoM9nDCAjmolztmbIdN?=
 =?us-ascii?Q?1SO+I0suGq+01gTd60q5oVXqTjQFVJtAmaQDH7OpxdDaCE9AVRBuJe8ErH1F?=
 =?us-ascii?Q?ApWocYDtP08tRKt2S2ekcmELsKlX2+zgZzzSa53wOQesQBNOFluVQ57s4kXO?=
 =?us-ascii?Q?7GxjFLXXXD2QdK9Tg30NgVOYt7IHquYobbLQKI/roVhv6ZqP4gkWe5Al4Hbu?=
 =?us-ascii?Q?nFq78JuJG+FCeussMa/Eknoswen8reF+NeBBDytG8HeHm9VVaeAql2EvcTc+?=
 =?us-ascii?Q?l7LHkLqo6G/di3yTqo/E+jDGRWJ4Zh1w3Mz5R1UkKN51dkAHkFcX2fyWeJ7f?=
 =?us-ascii?Q?BS+luu+XOs4ey8ZvUgWHPk7U0izgwZ8C5nvT3QbPKJAGMyk9zWwPTT85f9G0?=
 =?us-ascii?Q?OhbrZ462VhFNKh9RhsTFEg66MD6fHRFeR7XGIhfoWUgtKPo6EIDGSXbPQeKf?=
 =?us-ascii?Q?PEuPyemfon4uN9k47E4tA97uNj0FyLE7udiWTvdNeK36paGrKy6KYRiI4tAQ?=
 =?us-ascii?Q?nD1cKwcEKt2M2mWw+sPlSkE3vBiI0QxAeNEGp+qSkB0tADgbLrAzcrTlmEQf?=
 =?us-ascii?Q?bgva5ONkXiYG9btBTrSnYdRrFtACU3cG+/pZxoG1sx6+jntXykl9ernMQlbw?=
 =?us-ascii?Q?LZniPuEiiLilpIaanfrZX678OEPYb1mkX77LjjOa1uQIlVnOENWjOz3hyrmv?=
 =?us-ascii?Q?dRVaQatEpWb6WkIaBf86YuhXQSgiSt/0XT9UUXtZbTm84pZCG0kyxuhFZJvu?=
 =?us-ascii?Q?OfbD4HTEsTIcXH9cJAeU5L/eCRyT/x5ahgsjOytQTCSYNFUlReCtjuxaztcV?=
 =?us-ascii?Q?tYhEGqSwWNLHzed/H4BRiOLmDzouwZj8mzclGDCsL/kSGVGiCyUelyjhNFaE?=
 =?us-ascii?Q?UiCmbD+sKJxEmKEZ3HpbtLlFA3bMmfnMWVBTE+5qrfjsADRXexf57v7kzdK4?=
 =?us-ascii?Q?ON/U5Qjm8HPVo72i5VA2wmpHi37x0YvbtwZIEn4IH6k6Muu1Vtq28llxAuoG?=
 =?us-ascii?Q?MQr6mMELd+JooylqtrBO2qBoUHJTpNp2ULZQbg6/LPejzYFgulZ3DJGGfuT8?=
 =?us-ascii?Q?PKP/f8b9EjvLhy1YCcY20IcDs+qYI+jMugpvHCxpyGBOkQVwdVlUqUsSK4T6?=
 =?us-ascii?Q?bZIAI8pBxXbzLakweQE4sb4QJyYXnHRnsaWySdqTZ196shMk0LpAJ/gO5RuJ?=
 =?us-ascii?Q?2AdSag86UdLzf7/2U/LF1Yd5NWlESUTBChttzRyNapq/4iZnPoxnFNQ2qdAJ?=
 =?us-ascii?Q?/pHEWy4qgILGl+a3D74+cNdk+gURnhdFO+EBwqoIPwgxXfg7oejr4LjPBky/?=
 =?us-ascii?Q?yA2ex9kRWwk1DxiurIOjb1Chi/2vT1rsnmBW6PDD?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1cd126-7959-44bf-d137-08dcb048174c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 03:31:25.6035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nmp5DzqrNinX2AkT66WtTC7WllcnqxBkl2bZc5Y4jnFt7uWj/tSIHH0LX7fHWjoxUjrsGYOyZsLBr0gmue4zdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7705

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


