Return-Path: <linux-wireless+bounces-26316-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F04B228B7
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 15:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9BB67B7FD6
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 13:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5159628980D;
	Tue, 12 Aug 2025 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="bS/4Gvox"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012048.outbound.protection.outlook.com [52.101.126.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCB9289376;
	Tue, 12 Aug 2025 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005590; cv=fail; b=maWl2K4WIDz5/zLhzwo2u1PHM2PRYffM0p0cydc6yk2zXxKL5lEDZVoy2U4XGasKVuPhRBg/5weyOmcowwJktlxlfum7EL0W7S7PZyG8ZuGldK92BOqkKZnarj8BmX7j1zZWeJeFLH6sAN3gYKPoxxzYzo1pUgZpSJaAqChMoOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005590; c=relaxed/simple;
	bh=14MM4u8MJFjXZvKMOCWh+4QMTycw8fkVXsW6nt0Hz+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hD3VsxSgOTfHTDBZpx34RS+NOTV6s5f89waPTHEc8nvxr0LY9cI5CtsCeDT+Jtvjugk8g+fJR+QLglFZ+FMDiiKuzMdTOLty9dNoQE/kB/MRMM+4mqTwNNIf8lDfIxoMoagLOpez2wpkgbVAyh+8h0a4yNr0wCvztWzH3zP8COQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=bS/4Gvox; arc=fail smtp.client-ip=52.101.126.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MO/Z3KIJdrO91VRyeLqxklbn+uAnzMRx8aA2cNT+RWlckBUQ/5f7CzFaSvXPTYV6ar4l81uBRP93A8WjMmCUCjfMi44+dK6I+iGQwaGJfrOO3O1sk1fA4dranlhZB0b5ZsiHM12MFKrX5hmYvLw0pf28aZxxOWG5j2zJ1YfTSkW++zz9vUZNgtnb1YwjZAwAhj8blqKUwkTcWKYhTtRIsY829rt7YJ6XELX2gGoPHrZLW9DS7KCllLv93aE2/fnF2xxyyXTBCOuOfwMOqzd08JSoMzYzb8gFvdRhtap9iNRbRf1b/i6GHoQR5v2d/8o3HJ9jku3nhQpyxX5vyyDD1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVS0rFrdndd8tT5V5aB5T3tEqPyBFVj675bEBzMDsEU=;
 b=w/yI3Dh77ZgguB+S6PCUGsaafODiB0NxZhQfGDqDsZVcjIZtAfi5y5LB9y72J2owUn+RK8nCwijrrNPE0MjMAyxK+GyMbYFPn1s8Sie7aDyAJtUlVA4wjjoyh0+bbV2c5OYCHb+lbt6N0MxkpFgnXTRVEFvdvt77dP9mKpOkob7S6QesVxVCThouEK5zNavVoYDwxJ7qbaRMj46XmvWRoSfBxnm1f1Rhi/Iw23onBta+ADaae6FtiGyf7B33iIRA7lIBV2oNF0YcIsUHZ29N9mq07hWaOW0dQGF0yz5FZqiI1l6rweCSN8eBNu31ofLir6NvLl110djOrCFCwAMvqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVS0rFrdndd8tT5V5aB5T3tEqPyBFVj675bEBzMDsEU=;
 b=bS/4Gvox8Gsn+4jo5CRf5Xixg0FPYpKiR19Ep6+zQgWrDoHtbf8mBokMkNOmPaVXZK7XaNdLE8kRuWpU15IgGHrUoiexf6+LvFxdCANvX0NPEPMw0rmfIfphmSCdAOH40vnXnZ23Z84rp/eNjGGVFIKJ2Z6k7rViyyr6KbJ5fB/DWteyWLqMvCwWuSiij8j14lqKo42g7pn0DVO6xMcR3BeGuq4Ce02Eqy/gDwAJLuEm3inhk8f9RTdB2APhdu/EXF6j7ghmskP7VFAaYx5cW2mOeDWHVCPYw9ho51Xa2Iz541HaUhDJsNN3Q20Sj9EMk3alSECIBRy39MZR0qsr3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB5040.apcprd06.prod.outlook.com (2603:1096:101:54::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Tue, 12 Aug 2025 13:33:05 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 13:33:05 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Jiri Slaby <jirislaby@kernel.org>,
	Nick Kossifidis <mickflemm@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-wireless@vger.kernel.org (open list:ATHEROS ATH5K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH 4/5] wifi: ath5k: use vmalloc_array() to simplify code
Date: Tue, 12 Aug 2025 21:32:17 +0800
Message-Id: <20250812133226.258318-5-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812133226.258318-1-rongqianfeng@vivo.com>
References: <20250812133226.258318-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:404:56::17) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB5040:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d581560-3295-4842-9aa4-08ddd9a4c4b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RFKllXhqzLaRYya4E9SY+S8aJhEJafx2KhaK/XHfMhHG2SlgH4340sVUj88j?=
 =?us-ascii?Q?hMtMqa4TxcEABbF5FkrBlEKHD6WJcOK7ws26JS94/mYs16htT50qsdjgEhYp?=
 =?us-ascii?Q?1R6x0tXGGrIuYwMbCbJ3OnRyUtFyd78Ai/Sfu8XVZrRaQu6Y1gXTxr6h7czs?=
 =?us-ascii?Q?oCM0T4kzroMxg0qyH4w52WZ7VuWCXjZYLHb34btIklgzSI+meqnHALV5Hukg?=
 =?us-ascii?Q?JeAHz7diqCCVf0Ayk5Q9DpYVhUHveinfD6cCMy4tO+Jeje9T6Uqw42GZFGLX?=
 =?us-ascii?Q?PJcKsfTHhMzeBxgdchO7744QBpJDQwStMc7ES5fx9GcUWzi+YHIRo1qdUfDe?=
 =?us-ascii?Q?c/P1s7RWkvHLyrLsbWnogyd6J3Kh0Id6XKIJKG2Je2LcH4aFO29iGcZhMDQb?=
 =?us-ascii?Q?S8om2DKbwsvYXqnNab4OAYFV6s8gY0+4kA4livUdNIzyjsHWKdqfVR+5sM4T?=
 =?us-ascii?Q?8AXhEGt3dS4P+D/sopdohuhx7QIivtum1pWiPDW8jtewJskNYjaHIxQ6ydfO?=
 =?us-ascii?Q?HlKvCuDgC4wh7zjDuDNBeOLaUzy4FG9+y8ZCDjoeENr3Rcj3lEfmiCgYDaft?=
 =?us-ascii?Q?a+7gTs3U7xqFV45ooFnP8PrZyQCjFFpVUVCtvwulvzRpl9wyrb4pQWx5MdqS?=
 =?us-ascii?Q?EyAs99aFKvvXamlm/LBQ5JHZbYCy527KCCSWxB6vfT8vcT5o1lRip7R1/pUH?=
 =?us-ascii?Q?9eV+7nsgL5ruwS8O4Zij4Le5NENVZAzBDEALmvIIP3W8hw1NAqw7jUMNkPeo?=
 =?us-ascii?Q?X/OU4DRnSXlkmD1oqTQVqpZHxF+vlL5iU4b2xWneQQoh3XpIlszPPRYPYCsU?=
 =?us-ascii?Q?kv4n68ePdBCjQRezaOxKxWqTPvQY1EtVrQW756R9BK8wpyvFsEddVNx8BfqL?=
 =?us-ascii?Q?ZOD7YFv/+Hibd2RKI/cOI/ptSSuEbZaQlRDuhaN9ITcgU7kt3i8yi7R0ADFB?=
 =?us-ascii?Q?oSAekY/oZEmZbML4xqXrIvGv67U4wEGtcO59Wnu2MjuaNA6kaZENY+Sw1IO7?=
 =?us-ascii?Q?yIJdYPNWb6x7ZQqzV+9Qa8qtFCSg4H7tlJFVm1eSPJEGZTTCitoCC3V3sKpy?=
 =?us-ascii?Q?mpbLTWH34V4novD8hTy/ShxkBJZ5vFdUftZNTvAGmyoHybMsThYZiCi6DIyW?=
 =?us-ascii?Q?wnNaYw22WEZApN/kDcQj5ayWc6SYgJ5cdFAbVZSzbMPUc/DXKbr297pvZYaD?=
 =?us-ascii?Q?WQm3IrwKQ/5pkPKMAVSERP8tr+/9igfC40JNVas1+Zi6it+xxDls7nDAmkCR?=
 =?us-ascii?Q?2AcZUiA8HKiAdTjA8fBWlruuJe4/Z0zBeeIygENekA4ZQApmyinJJ+m9gxju?=
 =?us-ascii?Q?u3IbB+sAzKk+8n7KKRHU9byORhG9slBJBFdMxO3k2DTUQQKA5zrI8Z03roaC?=
 =?us-ascii?Q?G/GnYz3Foy10h63jyjY3VxbnmSkc6Ha+IhLO7njJU9Yxv/N4QKUCiKCFCl0k?=
 =?us-ascii?Q?ykBYF63NWNVWCm2fzKdIaPNiHjMhB+dntgDDmTMCI2nafyqWLaCQF2fUVUWf?=
 =?us-ascii?Q?yIpnSL9LGpzpnFs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PoAnxSgius4TsQBW1uqJsZIo+aa6s/xzb0KAnpHQ31INZLMvrVmfdg1P0KsT?=
 =?us-ascii?Q?TcC8GvugSeQq1dhqjmuF9jSdRqZAFuoXczGtMwoUdcAG4xxdQOPAKwhGYMDM?=
 =?us-ascii?Q?L7vbywtLgweNVO7/UT2eSJM2B06vM+rnYR9ADgfwLOiRmhTXaWCUi1FGME1r?=
 =?us-ascii?Q?ekl5psiGQASNV/GBCOjpmDIbgCBvc3OPtKh0aGYZOzixdhMM5NO00RfnRUml?=
 =?us-ascii?Q?wl6TpQLlaTtWbS1BaSPmVCnCVfbTOsPGKwPGZR57OVANg10D/o7AdwdFv0T7?=
 =?us-ascii?Q?K/2x1L1lGDj8HO7jRj4Vy0qyAbLUTqim9Oj8hRFS7JX+IEYgosSXiivrYYja?=
 =?us-ascii?Q?viOpoyLm/b6jIaW0LT+WK4MUg6Hl/OLtZGiXn0vB2137bxduRsRteK46AR9X?=
 =?us-ascii?Q?xIUGhDG2BL/UfU63WD+PBr+byL1LhTEqXkiWkGEhPPakYQbxtn0C4cFDG/X+?=
 =?us-ascii?Q?Ro9i9KAgHinoubkbHVuEw8zjiCLAjVeYHtKqgjKyZ0ttWrvMNLBYcdca/x+I?=
 =?us-ascii?Q?4FmtG0xomViz6xeyAS0ykqCgqhPp8XyEHIBcS2pydJHXDzGGrBuCYtedtCcC?=
 =?us-ascii?Q?l89QN1UiKBw3inD+/icSUj3rSL0ZHGPfesqU4ZFZbVyuTshgcAyGUQMfxnyD?=
 =?us-ascii?Q?jygIFzJ+AQ8dt5vL/qenDxNdcleeOz8UnEdKlEzQ6YHq4Jx7oByct2KLdfvH?=
 =?us-ascii?Q?LUIIblh2a5m+pLzaSkhWL47LsjiMOfIaGJXbB60L5PGK2QsKm/9IMr01J34+?=
 =?us-ascii?Q?+wANNIHKri5bsc/jLCqMjgeFmls1vzYMnXieB69KAP5VazL8vyIghNdyMvy1?=
 =?us-ascii?Q?Ncd8KzSd6S+1qPtWUCbl/y+cAsFOlJRrYiyuzKt2yv1Na4EE4DeeBla7DcyC?=
 =?us-ascii?Q?P+UyfDNyttEIhZYBDgwhxA4eziwII8Z1PCFxKQXp9aWmiAQd/EwZIMoFJWF1?=
 =?us-ascii?Q?YbeprKhzLRGNp1MDoNvvB8TqvpT9kCELNgcmCKPGvHfL9C/xHazNemk3pgkj?=
 =?us-ascii?Q?dkkQ6lvyxA+eFq+1+nB0ZnGox+G0wYHLB41AnIBjcCUASZs1/+15r0mR8lIS?=
 =?us-ascii?Q?RPsliQOcdkJeJTcV54OIGZoehg2m1MphPLKIBNZQbynBXidDpG1tviXdt8pl?=
 =?us-ascii?Q?vwfkKYNbO4Rv3anOvC6bYYYdZg1f5aQ5YNW2l5QVRl1UqFOctW1tvc5YpWNc?=
 =?us-ascii?Q?s8NhZWQsuY8Vn1LaI7JiVMKtYfHNCIyP02cCA/jP2lWA9oVFuMsrs6u+JxcC?=
 =?us-ascii?Q?tMul7Uo87S0L+MgepvY1vgN9t5yxHZarqDRbE7TbLmRHXb5qvauXKlWxt1A3?=
 =?us-ascii?Q?J8sU6XMaKb3nACILtkkV0eI6DYGMsKo3ukocG2fgs5Qn+bgNmYVomOn4m0Ta?=
 =?us-ascii?Q?l6vyr2ZTiUEN7bz2SzR/2pgXCgGjQ+aJt3UXKp2SDoxAqFMkmfPPO+WxmbTV?=
 =?us-ascii?Q?85+ualFqhLQ1OEyfawW2Z5ykn9SegRgd9xjZWl1uxYPJRYjVegLPKYEjgutZ?=
 =?us-ascii?Q?WS7mFDMM5uktvHkBQIYkWrWZuVP8KMADIMgewLJpbDZa/9K9+j7itnbKSxpF?=
 =?us-ascii?Q?YYVW8VcE0m/rxLEKSD2dfyS/FSRbN05ufHyyGAl1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d581560-3295-4842-9aa4-08ddd9a4c4b3
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 13:33:05.6494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ck11Fxu460NPRIauwpN2yhRLA92PETvYMMj0gsPkAW6wwB/COTn7SmwROIc1udEzQs1xnHYx2kq2v71jHOMWSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5040

Remove array_size() calls and replace vmalloc() with vmalloc_array() to
simplify the code.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/wireless/ath/ath5k/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath5k/debug.c b/drivers/net/wireless/ath/ath5k/debug.c
index ec130510aeb2..91736f335210 100644
--- a/drivers/net/wireless/ath/ath5k/debug.c
+++ b/drivers/net/wireless/ath/ath5k/debug.c
@@ -912,7 +912,7 @@ static int open_file_eeprom(struct inode *inode, struct file *file)
 
 	/* Create buffer and read in eeprom */
 
-	buf = vmalloc(array_size(eesize, 2));
+	buf = vmalloc_array(2, eesize);
 	if (!buf) {
 		ret = -ENOMEM;
 		goto err;
-- 
2.34.1


