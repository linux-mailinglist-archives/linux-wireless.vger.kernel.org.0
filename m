Return-Path: <linux-wireless+bounces-19165-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CC6A3D13E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 07:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F90F1896F10
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 06:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211341DF99F;
	Thu, 20 Feb 2025 06:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GSystRNG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9B41DED4A;
	Thu, 20 Feb 2025 06:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740032081; cv=fail; b=YipygY5MhtXQajhiYq9qa7X27S7FwTwQrwH4Keu3Po6IA532VEpS2i5yAFr0y5dm9xTuDrzYDVTtdQL/R+0KrcL2ayZAh3nlaP/QWmydUHCrvmOrBiEQHBw2odVxTukfsPS1iEW32jt7ejeFitwu8j8lRHGtIuwIX9sZq2qbFZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740032081; c=relaxed/simple;
	bh=cEzKPqrhiUWNbGWlGE4tJ+hpB2z+kVOvOyHUgIdIpt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zv39wbv9jBzMLW/sMdL5O8N5+eMCGO0W22R2yTQ5RAZS+J3VD9QFUY66OrdvR36o+DW88Fm7RbODIjmzb00d4HEfjI37Y0yuR9cCNMnK8qKeHYCIb5O5InWlRARaM1jVizuWBltwAf+FoRWk1g2QBvfs6g1so3nURD/qIgRFhFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GSystRNG; arc=fail smtp.client-ip=40.107.21.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxvbEeHlnd21VVDjLiEbvLuikRUH5iC0nan6G8ZwB+IDvt+b/yCi2Hqgji56lBn/A2Zw6pkwATSHGNgzNqERqv4WMFyBIyG1+lr0lECMFe0HYEePFSNwqheY4uUURdJFkBisG/5UxoRryPLRiNpR36pp9mbnguXwuHfGZGO0FSbZ2JOf0HpOyEq7SsbxE5GIovxShPe6ntEp13IeL4+RAczViztFE1jXgZd8/tdi+tgaw4wTZUNmMUkV1wItjPgUycYm4JopH/CP9yUhR1pPpIV7r8RkTgXQ7+twDAFWhyM6dyMMmaujCSrPrRPKfy4FXaTsvcjUOSjNMSwr+IIzaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhPeyvcGGwWct4TDKNRb5aBxpjwEmdDywvnOgM1IR1k=;
 b=P2BEwWaa69oHZtHop20setoaa4fBEF7O/m44wFVhroA+oJucXZHG5uYvtGXGNpJxdqhLOweTfpYQPQVzzDJcd9Lcyvib+lzTT37uHoWSt6yMn+Qee84CG1OkYEXZGf6efn1xdLNy2RXV01f/omU7QODc9Dbz+MqtkaSmAgpq7GxvLc0jHgj7LlzlLTGvQvLe9lC5iHJ0mwZyJJtCHENtk5ETE8r97T7QwMKK/xGvV5Ce461WzuDmMHPinue4StGZ8p/UQFl2s8dnaKLgYUeWnnNSUeK2fcNMvoZhxFz46z3jNrHpLratlz+DX9gBgPf23RyoaIdfCJQ4B/okxdLZMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhPeyvcGGwWct4TDKNRb5aBxpjwEmdDywvnOgM1IR1k=;
 b=GSystRNGNJQyBV9a6CAxq347ZrtANPdYlpMdu0ABON9LoGE9Fe8VEGH0VlSj2EA4GC2rCELnmf30cvex5zJi72hm2xJyqz0+cKcJKnaJ57UHHSgrhtydnPVsJ6LxqY/1eKhvdcQ+bnS1dsH5RFKJgLYKHlHlsB3a6ieuvTwRvKLRgwY67a/USJUIJHDA1MyosBQq7uqyFA2NXLyYFA7cvNZ/Hciu7UV6QYf4xSmzl1mcbshlxSquf5jDB6UiwT/is3dfU+xMDBC7sO3EyeDU551RXW+CybmTniAc+UE47hZA/Pr42xd0bEmon0ZRdPaiyKw+XbzkpXlOZkPrN2eQ4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by GVXPR04MB10047.eurprd04.prod.outlook.com (2603:10a6:150:117::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 06:14:34 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 06:14:34 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v3 0/2] Resolve the failure in downloading
Date: Thu, 20 Feb 2025 14:11:41 +0800
Message-Id: <20250220061143.1417420-1-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205012843.758714-1-jeff.chen_1@nxp.com>
References: <20250205012843.758714-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0008.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::6) To PAWPR04MB9910.eurprd04.prod.outlook.com
 (2603:10a6:102:380::7)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR04MB9910:EE_|GVXPR04MB10047:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ac5976-e0c3-4bfd-b681-08dd5175d8a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EQU4rHfSCMXhOIOrZ3AjGf0JnQVjiS1jEe28632KOvxGi4H5ZlRji7fBSNZF?=
 =?us-ascii?Q?891lLaBlvA3qvOd+wLsNOO0kTsprYTM+z8JzehAIlIreFhzE3FMXsGKNn/te?=
 =?us-ascii?Q?WpC4nCpQvRCX11beyLWRz2mQRyy4fdnaPjznrhIvTxs7VyawfWgzYz8kg6xj?=
 =?us-ascii?Q?oETFlVFzNR3Y4A5Pw7hQn49Ma5PeolJ9p0wB/1+ZxePDi3Kzdgj2uam3ORNq?=
 =?us-ascii?Q?BajheA2BKqImrQa7MjwxJ4G23Jhu76775CCFF8TVl2N9R3o6admo40sUkBvR?=
 =?us-ascii?Q?t+lPshaSBgl1N45oqX6kZq4PmRYCCZ7ci1FHVId/Ti0+nO4pahFTdBwN3zAw?=
 =?us-ascii?Q?8RFsAGQdzys1vFzkPK8s18x/GD51kd1hsqLqCRvMymaD53Imj0GN/qyZGGdp?=
 =?us-ascii?Q?jQANhFnmdZkaRUmsk7rgsWsoE+jJdNl7tZi1UN3sMd0Ll2DtjLwvSLUaKwq0?=
 =?us-ascii?Q?z7VhrMrpUJnFD2qdc680bpBVybjob4cgAHQfjPOiYG/OIOFiDW1wgpf4yPEw?=
 =?us-ascii?Q?yeQaSmzhn9HbH6+nSwI1ouGmRFvhSTB7KVFn6kFWQRWd65pgtbpw0ILgw9ko?=
 =?us-ascii?Q?nW6l0EbUdApKlTACHISG+zC9mh2RBWh/5SZwjQtoCGqJ35VCT3P6m9vhRCCd?=
 =?us-ascii?Q?nSerP6BKRM5ujRFea1W6g2ee5ZZ3Cc+EFjUFJzRm7RLBXbTJh6DUgyW2bjAX?=
 =?us-ascii?Q?WEcGNCqfldvAJQarBHNqS3fG4PDsl57SoXIx5y6M5zG1gASWrcnuC/D1fAqP?=
 =?us-ascii?Q?qBei1vUrvO+4QkreAmnWZJNtwu7NWCCpPqmZpl0JkFPBjrGh6si2CJqhn8PX?=
 =?us-ascii?Q?iRBqvKc1tsIwMfGJwM1iWYOLlGp3omw6XpxPukey0//cOZlZiCWFliJmoswA?=
 =?us-ascii?Q?sppA4Qj8E1Vr/fp+btGHsZukPfyVGW88SWTo87NisaNkqS7rMqX5+Tl89pV0?=
 =?us-ascii?Q?mChCsTkVCiQ74cRibWc35dPZqmiyXTumXFuTeJv0qqaBRqz7faiqQOUzD9pn?=
 =?us-ascii?Q?noFYI68fmTS05DmP2x+08Z1x90pk0WhE/vgCeGyQoTqGogiURRE4JcsOKLQU?=
 =?us-ascii?Q?izvQhXlUodZV0fyQ+Fh6doZk/Z0BJI7O5C57QE6f1nZSg0GOUHS1sv6bwgKO?=
 =?us-ascii?Q?9KzkU9tSAKqHapP9tB77qvOmUjeVPlfZiPIon4KkyjOqBdZsStvnCJxyNCjb?=
 =?us-ascii?Q?vQAEk1ayWBgcLIExD9ZY/zyJTFGAyyOqUWUe2OdN1PW2249+i9aQ1J5UuhjW?=
 =?us-ascii?Q?rssHp7Tqy5NM7zFfSn1sMppZgjxWrsACJ0Ny4R3oCsnCDe6aTQ4hjbpwK/sI?=
 =?us-ascii?Q?V9xkoQe3OlWx3HVe8Jkr+sb0Fz6ISSx6fNYSxUNfQ+DkMJmUpsbpFM7Op5p+?=
 =?us-ascii?Q?zehNzHfn8slaUBmcSUkWDBjwp6ti3dKZEZSpv3TrhaxCZYxX0ZMr43olz1Ca?=
 =?us-ascii?Q?FSc94c1RibsEdOdCz4wxfhWkPAVCrbqr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VG1oRt3+8O2OG7QBUAraiFwP8+kD9xn31hiJLSOWVekDzeuJWxQSn20EQUzh?=
 =?us-ascii?Q?lpIeTQPxcgehOYDWjXgR8RZIBNpN9JCZW9aMEXe//nYnuWKETUrNZ5bOvqR/?=
 =?us-ascii?Q?Q5MRZmnBdOsAIPcKZps96zGN4Q/yv0RIQcAivyIcbaGmhTOqNXo28giOeBWk?=
 =?us-ascii?Q?vAWpTqoXAt0e0w+YlLIG1BWSp15uL8dE0tfdLpq6FkmROzfUoid1GSSEA7mf?=
 =?us-ascii?Q?nzP3uL1U8AaDymYn8dYe0EXgZRbjRHPT/ULjbSJiDK0dhdSu4Ua6sILk+Yyv?=
 =?us-ascii?Q?xxj+6Ae4P/rWHGZKa+tnqKU4SnN0QmS5+G8K9kECDIcjexisT1g2eETr34Bz?=
 =?us-ascii?Q?cJqlvrwQugoi53RZkGtax909YlWe4nh9arBoOC01k1CHc4qdCtuoislR3CpE?=
 =?us-ascii?Q?mHetDIcZ0RMiTg7ebtFQIibhjnmVFpVQik77i+bmdDt2ZaTT0NIokEnsTAHf?=
 =?us-ascii?Q?mN3MY9ddq1OdGlezsYrBKwZIuOeTbmrnMk6r7qnyyKU1ead/NZq7eKwamWvG?=
 =?us-ascii?Q?/+1hUz+DBTZQJ28kzz70E1hSUolqoPox1wgX9hdHTpdsVqMfcDZW3VfJJgXV?=
 =?us-ascii?Q?K4LacZFIoAeor58vX1VaZEjplpHFGkOwHq89JjKvgSQ4esRx64uJSa8/uy90?=
 =?us-ascii?Q?ugskQL7Pr+YCRyn+0HLuDcQ752ezT0yCHGucqisv3aya7wPjHhimCndwzGD9?=
 =?us-ascii?Q?DfJaC+zjew4RUmBFaN7TMl/NhlEoJnQ+mNVYLUZN4AsJ3c5qD6kZqwd31ThE?=
 =?us-ascii?Q?IyIV2JAudxocmVHyXtIFEU9xBrZ4mQelQoAGmu7aelnVUbKtMjEddqtmBAKr?=
 =?us-ascii?Q?OYTNHilGbfe5XGEERMrwhlomZZ2GI3VlwOlOYGrotE/zWJTGaDAgHY5IK99x?=
 =?us-ascii?Q?C8jSwPCZXWxIm6wSSTacqPETUrLjsiPdW+7CHjLTHMlUGdXjemW/Mx2o5aG1?=
 =?us-ascii?Q?Ai79t3MuVn9340zg/oaq1GmXymjIH1f842t48qQirMzPiCfCMvhApIfg2Ww4?=
 =?us-ascii?Q?aRfhupWPp+agl+mj4nsTAbP54rOq2maXw+1+y+UAN2DJdYi0vDN9b6CsPYqX?=
 =?us-ascii?Q?6S5Fi/Q3HBIMtm966mEK8+Zcf7npRa86kB7lm8RwKh+ab7u+h7OKnQ1l0Jo2?=
 =?us-ascii?Q?kSy/SIFJbRZvRqWPrFusk3dEs3FxwrXjpm05C5rUMKbwbqipcoNT5Ki7AeAa?=
 =?us-ascii?Q?0bgCGuM5Ywd9bJ0KqPydvl729RhLn4rE8X9wFQ728gh1PRoiK7Xp8nOPNMBv?=
 =?us-ascii?Q?jD4EZ9X5LMCy+FeEheUzkyqUrlPlCA76qhWQmUz69vtpHtou+RoaOXybHbVk?=
 =?us-ascii?Q?Xiw5pxLMRCg7sxYTzYnkF6P3AF22XJvqtuFxK154+YrYZsHBigXFuwNVnEa7?=
 =?us-ascii?Q?PMDFtnd5phNcAWceG+6aS4rWx/hYv1G2vjzgSIXVBtQnWXpFjUDLleUrbTdS?=
 =?us-ascii?Q?NPu4JLg+hqLpalaH46kGrKV4ulUl1tJbEV+awRbm19DZn901dY34tMRfe6x2?=
 =?us-ascii?Q?P9KAJuCjMGlpAtvieNDMtSDNJbERvCRWDOJrxQ8onIETvW1k1n+QIsVG9Tg3?=
 =?us-ascii?Q?YrGh4P3wFFs4xN1Ic1AS2TxUyvajm8p5CrtMSjx+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ac5976-e0c3-4bfd-b681-08dd5175d8a0
X-MS-Exchange-CrossTenant-AuthSource: PAWPR04MB9910.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 06:14:34.7621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfIcjZDsVGnTi3ShYuQlCQp2RYrGOmmXXWE6tXFPWTUBy0BjhShW4lC5EE9cd1Qurf2dsu/X371wB6uksrPmXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10047

Hi Johannes,

Based on your feedback for the previous submission, split the
original patch into two separate patches.

Best regards,

Jeff

Jeff Chen (2):
  wifi: mwifiex: Part A of resolving the failure in downloading
    calibration data.
  wifi: mwifiex: Part B of resolving the failure in downloading
    calibration data.

 drivers/net/wireless/marvell/mwifiex/fw.h     |  7 +++++++
 drivers/net/wireless/marvell/mwifiex/main.c   |  4 ----
 .../net/wireless/marvell/mwifiex/sta_cmd.c    | 20 +++++++++++++------
 3 files changed, 21 insertions(+), 10 deletions(-)


base-commit: c61da149b9c2e439abe27845a71dae5ce5f5985c
-- 
2.34.1


