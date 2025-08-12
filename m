Return-Path: <linux-wireless+bounces-26296-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9CEB21FE6
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 09:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6335C3B17B5
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 07:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8632D4803;
	Tue, 12 Aug 2025 07:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="WwNbvfDU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013047.outbound.protection.outlook.com [40.107.44.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2054236453;
	Tue, 12 Aug 2025 07:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985199; cv=fail; b=n8y7ECXdCzO5K1I3zCWFX+A/V7ixDiHeNVm+D1Wy/XxiZAcQ/r7yLTJ3vtbfRIHktaE/jj47Kc9rwIG+XeF3/APOlzGtQx92N4BThiuQbKPpC07o31bWZ6XcjHZbqo9Tb3uo88cODOSxsbEn+fRdO/4NWck9xlhOtR6+W9uwsDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985199; c=relaxed/simple;
	bh=4VB0qzjMOMs8O8J0+BbBPUzJuITq6/GjFXjxNGeFK7k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bV042MAmOq1mdArLpay7008Sn9ZpkQBql266pLJXfEGU1HwkpEIM/WKg6jcEhzH/C7jzFGP0Ug3cXAznOLxoQw1lFgV68LR1Div82vrJpYBaPfq601G4LYM40j18mwnR9T8BFC7tXCfQ3Kgm+eCGWWGLxMISXi+xihCOmd10TAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=WwNbvfDU; arc=fail smtp.client-ip=40.107.44.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/3MnTWRW+mYQofkx4qNTnCKzzY9d3UB7SKg9qiE5IIz6xEvDJvWKe28KhCIIz78Ww6L1iLx7qxP3V/9u/guomEyZvXR7kFCqBgjn7f+Ku5juJ6Sc24UTZ0mAnrORge95+h0X8YrK9s8ILXnGgW+DK9Ylx8JnHQkmNjjfuUqhiPoAQoJscOeTA9F5cIoH9k5M4shmpinCbrle8EfpE26ZFF3cBBGsxuS1ETIc0hykbIKNQeypTd4gPEpCHxgGkRrycaCnJWWEdH8AVmpPFo3OYRAJzlUP263E0YF/pf/ehXkRS5X0wGWPyrI8s7ybdzHTUVKpMjj8DbY+tdW+Xzxgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZgCXMZ787UP+z3Zt+DnLJa0Ltw5qqpQxX18oS2v28c=;
 b=Rel0GcJ6EFBC4+Cus/guLviD0fIgJODcT0SuAPUAFSNCe2MRq9A1dGfph48dS1WI4wLOgpuWCLPSEI9WtEM8OKZiuJkUcRr4TXJc1PL+XJkKb6Oxbi5acLyq2sy4Iw9qrhe7Y2n7wA6Y5p8qFzVcmHYyqSOCTXEWAd/2MR+Yo3NKNzr/4W6gC5erShJJ9dHAhcN3ZtT3bouVRA91NQdvxaqb8tp/mPwFyHaFJNEARQteLxUxVhJOOR7aVWwlwcyG28+C3C24NmgTivM0y3NMuTpxs0oCAo869E5fKxtzP4JBkZeKiEw297lPwNiAlaHNobf8mHG87Apioa4pPcedYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZgCXMZ787UP+z3Zt+DnLJa0Ltw5qqpQxX18oS2v28c=;
 b=WwNbvfDUJX5hLSJluR9RlGw7NqsrhgZ8ptzvruKwVsbhkTuveEDBkEPZDDB6+5AUz7iT96RxiO2txHapogIRCrBXYd6F0eFpIWXNKYFvJ3MZXRys+26YbpiFG0zPu/YztbGUGICws9rMKt6nIJVYuCVjHxL+RAhz/t9uL7TKx28nqZwNXDb2vEeBCa9pPUS2yV8If8R1qaEyyk0Zi/j2Nh6eyLKaeATT0sBllrNM5zhimD/iOMGgAcRufdgrgfM2UehtIC3+TAiqZuHOELM8AyKCZRqcW72edxhEL20zngjuO5PJBKuRri12riC7nT9s82bKAmB6bo3QPsUflkUsgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SEZPR06MB7263.apcprd06.prod.outlook.com (2603:1096:101:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 07:53:11 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 07:53:11 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Anilkumar Kolli <quic_akolli@quicinc.com>,
	Ganesh Sesetti <gseset@codeaurora.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Muna Sinada <quic_msinada@quicinc.com>,
	linux-wireless@vger.kernel.org (open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER),
	ath11k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] wifi: ath11k: Remove redundant semicolons
Date: Tue, 12 Aug 2025 15:52:58 +0800
Message-Id: <20250812075259.6921-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0078.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::15) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SEZPR06MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e2fc32b-943d-4b05-1a65-08ddd975486e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8TtU8NBCxb51oRxdrZRX3CjWU3p3glbEsboiwlh61CMmlHjAfV27G8MOFZcI?=
 =?us-ascii?Q?3ulgjUsAWRXp4NsrOLFHG6u0ihIkU/f1hhs1XrJXdJA2c1DIES1Ti8mJ0UMV?=
 =?us-ascii?Q?aS+omwhDSrvCszj+011wKawBZiYTCbD5uZJl6ZllvsQxkdfpK6Ut5vKNmU+b?=
 =?us-ascii?Q?Qw4LcJx5qOoJgxEiembgVDhNbXMI1WcodLCcFfphVY0OFZ5cNf/k4nLskwAd?=
 =?us-ascii?Q?X67QHqlyWMV2af1+hAJSTsU87dpFFEWF5QJTvd+E1NNOmImLprdlKg8uewI6?=
 =?us-ascii?Q?X11gQinInFAkqVH41HFuOmJBjo5da7f+pCmwIyXDYQnE8l/VmvmG22tVPkxW?=
 =?us-ascii?Q?ZhPXR4Iy0KpVxIWMNwFRHTeajB2+2zTm+RtwA5L7lqH8b0Hfj3hsf2IMFUhF?=
 =?us-ascii?Q?Y/6lHu935YpEclGHvy9zzx8iG8l+u2VLHXKHH7C7UC8s1FWY0QIYHK2anEyw?=
 =?us-ascii?Q?NXeyafgl6v8uqTV8U3FqJYlkodqohPG+9kseW7GI72m4j/Bd1RQFlzMuX4O/?=
 =?us-ascii?Q?dG8py2YGP1L3JyncyeLxu1RM0MMPANWwHDek6Zy+YWPKxr96AhQFhVkDOIhc?=
 =?us-ascii?Q?YSw4wfmE2jdbiO8h35AXETGQlDNr1TPxHzqrDAstys0Giu2PhxEyPAqu4++a?=
 =?us-ascii?Q?ARqG1dAup9hxWYvIQKDazIgKS/+lZ0ovr3uVA/0u41ZGX8PnyCii108FHckc?=
 =?us-ascii?Q?6L9QvW1lmX9Doq3rEeqjwkx+TrHDLm6xVPYQ1wxQhnQ+Y58NEWenOmBNhqBu?=
 =?us-ascii?Q?2grC/vrfUYLeux0Dc/0zgajy+Ib8pk9KhJgfElgISWG3S97ye0+hK8ltkPjJ?=
 =?us-ascii?Q?Lr6njKrQS5ZiSJ4vbWblIwT2gQSclqYRn3zPYuhU6N7c2R/Kv10YmJkttx/y?=
 =?us-ascii?Q?uSPAUx9+Mkw2KFzY/WeUFUdXYvjyHJP29koyd2GoemcU7RBA0vmqYy+D0IQf?=
 =?us-ascii?Q?hoEgV1r+uu9HKlzZ17lr3q8jyyh0o9KEUGNheX87YJEsJrf1GhdpvSNzebnb?=
 =?us-ascii?Q?N2f5I0U/PqgNzhl8Q++vlZOHrRxorntyfrLgOi249Jd8RlfN+o4jGop+jx/7?=
 =?us-ascii?Q?jgHD5or7zIRrZRXocgIYu82LpHYC3KOwlrti8A0lpXvJwXTWyY8Yvp/tigrQ?=
 =?us-ascii?Q?AjW7WNkw5OdZIhwerFqgszUOPWUHd2zBHlJLhHZaECb4S7nCR8B9F9khGgm4?=
 =?us-ascii?Q?9zAsP5kQv1bdpyScRdadGbF1sFYHLXQ55VE7pbYlrDXdF3MIIKu3QZAN95Iy?=
 =?us-ascii?Q?LIEtJPcTin+3tCFqdnT54Egf8Dz21TrMqF1snBCOeOqFtJJgK9DIzVLpjxdb?=
 =?us-ascii?Q?e4QwaowerIBIzk8Rhldrk17sSzlVFHobJ0C/XEOjmc+znYHzdh4u26P3tBAX?=
 =?us-ascii?Q?vv/+Hrm9nVee213M6Boks0DbmS2lhV3i6+lZP8djXgxhzRR1pmQhNEFaBw0h?=
 =?us-ascii?Q?ZPubEupjLRXpIh0PJW2OmSS/XyHW8VQIeXK1jD85Z4Y/zWi5BXdHmg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SWjZDMF7Pc19vc8URCUraILCF1vR6dLRw17XQZnU0puuXAcG1okKxJn1sryt?=
 =?us-ascii?Q?ucyG/pBvuAM4d3BU9hivTSfoJxX0CVy8qtyqRqPuA4GFjlmhmqr9mpx4KxC0?=
 =?us-ascii?Q?qNXL3ePEEvwWrkmt6Bi7AXwu4DqGOvVaNPfkvBgbfEq8H5LhkxyAmJl4Hny2?=
 =?us-ascii?Q?JEzSK5ep0pUoKul8Rl7+QwZkGlm3kDq8Bj3PUu82mgHNa7kBrp5Lkc5q0FN2?=
 =?us-ascii?Q?ryuw+JzNMFQ536KcFAhRTL3K1LNQxagJ+WznYMML0qVacESxMVIBxNZGi3y7?=
 =?us-ascii?Q?IFxUWAzDEssqsMgv3bm9hR70oRxpejDGEZZpqjTYGVGYCQ3r/llV0uBsRs1k?=
 =?us-ascii?Q?JFmWCShJXyX++pU7FacpUqRzZgsTaFqM8RICVcOTZw3xT0x9Ksx8ZqMaFHlC?=
 =?us-ascii?Q?dFtrmFBQS2PJe3LvMeBAe+q2R1xHWqCdXXmcWwQYB0PJXKqbotGJBAdh2phJ?=
 =?us-ascii?Q?+94QgbI6KM7MWaZmAz6QoB5d3GRFPFNx4Gfq4jHTZvkgVU6CzOOrp2YIf4ff?=
 =?us-ascii?Q?dLRmp9YcicKmXVDIhEVrKhM+HUxwEue10pPUkkMRTIpN0/zX2H52xltwm64e?=
 =?us-ascii?Q?5vrNjyyA9n2YiO4s+WtuCmMQodkWHuVQoFq4VpWhab4ySZggTzTZsu6VYB0t?=
 =?us-ascii?Q?yJehTZTTVJ0hkl3/1+XQtFPhjzjUe6+bn23gFg69anfy7wZhU+gT2f6RvKzA?=
 =?us-ascii?Q?22d9GP0DwVmddNeoam7/K5zRtiyBXoPUS2FHQ+h8QPWuaQm7a1fDyEsICdcY?=
 =?us-ascii?Q?JMwHX5uIGh272yJbVk8QSZ5jKRQm4H9/c8JLyw308xg7BQW7cCIXjkYt344A?=
 =?us-ascii?Q?97m7DMO6Jmujo3wkYzUzBMcBPSp9CcgVI/SK+feh/oZoEjpPG+P/65sneW9h?=
 =?us-ascii?Q?2tKzvWTi6QcwJPiZOvdP/1Ic+hPbDtA9gqPJkXAwYoPZzAtCYwiA2/YgNgpt?=
 =?us-ascii?Q?wzX7rWZsPLppHWnrUhCRKEyV+qj9xyw2ZZEocjhrePr75j8fd4KWlgEviZGe?=
 =?us-ascii?Q?qkkfXaVyd9w4wtbcfItZNrzkq6ZOQ29okKbdJDZrIWyTFlscdYlBvppeZaNX?=
 =?us-ascii?Q?E0I/st3552dWkpw/DLl9wtW3Ya2/uTPJhlaWLpFHNFGG1fQ9oPAYhnFtZLZA?=
 =?us-ascii?Q?nrM1nq9Az9d6FGAzFHnLQMKZFbekw4WhhXWxdOPtu+s+S+9uov0U+Ye1ooO+?=
 =?us-ascii?Q?0EPXApG/ugtVx87naoK9xqukIOeBZU/gVHR0LoNmRk//iGgcbvKAiQ6EtbTw?=
 =?us-ascii?Q?HhZyvrDUCBF4ruokLT2LO4ogpXXD1ik1C4dgaLcExnPqEm8r/09u/RYuwgUS?=
 =?us-ascii?Q?S4j9YRcAOzPhPtrM7YDi8pMppbjBMYDJBIaJw+mYdO/0WAQleMJi/98D4TkO?=
 =?us-ascii?Q?zoAkG+2I+HtXlOJP0QDkrE6cBJJWKs+KCPC9c0eN3m+hm2PrK2vi6kCDfFz/?=
 =?us-ascii?Q?zaJyCYCbDam0eJGFANEVKGev6EImfA5Jn8VlVHUbmr0b2YlVQTjYoe6+RV9n?=
 =?us-ascii?Q?9uzi3zt3H04UvaI9Rt+KwuA6tMBtl9yqSr1R+fqSp/vfVjIJ9IE+xgVPYcJH?=
 =?us-ascii?Q?KF12rGN86nnO43apadYxjqN8Cryg9XWhMnpPPuRn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2fc32b-943d-4b05-1a65-08ddd975486e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 07:53:10.9402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kDz9QvaJ8gX17yVbT28cN3KwyR3Yod99+IYpY7umLShAZ+1o0z7pRbUxHnZqZVSg18FWSlPhxuG8IKcMJx6tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7263

Remove unnecessary semicolons.

Fixes: d5c65159f2895 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index ffc7482c77b6..b9e976ddcbbf 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -4615,7 +4615,6 @@ static void ath11k_hal_rx_msdu_list_get(struct ath11k *ar,
 			      msdu_details[i].buf_addr_info.info0) == 0) {
 			msdu_desc_info = &msdu_details[i - 1].rx_msdu_info;
 			msdu_desc_info->info0 |= last;
-			;
 			break;
 		}
 		msdu_desc_info = &msdu_details[i].rx_msdu_info;
-- 
2.34.1


