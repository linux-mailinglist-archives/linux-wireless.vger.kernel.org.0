Return-Path: <linux-wireless+bounces-11776-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1503B95AB2C
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 04:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957E42883DD
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 02:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCC71CD2C;
	Thu, 22 Aug 2024 02:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="kLIIsO21"
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2059.outbound.protection.outlook.com [40.107.215.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565CE1CD2A;
	Thu, 22 Aug 2024 02:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724294590; cv=fail; b=am9oR44isR6LbEa1dG6+YHadDED0W1i8X7+DnrTiHJurQChUgLL8VNPcYhjVsGerbgS7fd+Ko0EjxktjMRkwYlUWhRgS2VMh8sZq9ZTyeOhBRc1sXolKV9tJYIxakx0IyhFOMAMe+Q26wEcFNuAP+Sh367nFygMh65z3aQvHUYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724294590; c=relaxed/simple;
	bh=vcdsYBja2GAQmgLJkoqKq+gOb30vvaFuT+3Mbo3eijg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=drRyTtAGyaHJzB5b/xKbhms9/myPOU2ZXpKI+Y/NsjeZrdTUETAVYqNHgPnekPijjf2q4CKFkxbhRFBRQEi9tWsoT6MQ0oMCnJpThdtaLft+8CkCgbQJDjw0/kTAlhYuPJUW3JbHy1uIPLoM2fN5nlpylwPT5JleTSrj0OaYmIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kLIIsO21; arc=fail smtp.client-ip=40.107.215.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHe5ptoQAekJ+fYGx/2NeWyOqRvBRbSirxQULZPrimduKeCutd9/NvONgrBIQungO7PW6VvDojw8FQd2MGe3AowPilIQSP6mxDvr8BXuM/ZrkcqYO+d7pF17fZVFDjuxDbmiaKI2s4mV7E2mwqnHJC/pyE+TOw5EOfB0isAeIOn7WYmYurolvdBiZh82ZaRF1uCZ0g8icDapY18e/WuDfpxwUeAxT+OIcdQwEQC7Xdlx2yv+DUfNglThdP8xBLlLspfE2Ar1RRSzdqhcbYc7gb46S7/Nq6Ja1ZjbQvECxYSpUQXP53osq+itf83NMrHZ2gBTj820Osh0+vXQyRI3KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oRWJ4GG0atuLNoj/EzJw9Z0Tfy3mmM0LwDahZrCCpg=;
 b=hRm/1XStueNmMp37Y+imo5kp/Zfs+6m0BE/FFKDDNJuOwo58pHf1zEVAMsIenaWKDRwF/6+EeBXOqA9zbfXUQlCI4iU98HpoqhvjwU+nZe/KfRCTZTLTLUqhQjADdLDi6igu2widZIPeTbhE0okd+yT2Ac0yPruF/pj2YuE4UiSEmW26uPkCCD4PKHrAtCfj+LsVADzlv++QxWeXCHiawHcIxX1KqIO/VD6cgHlb5nwE+lo/d45bHTfZ3RHFKCdfxUQ3LJHWdZOBZgG4Se2mmYfV5J7oYFLNoX1zzio/dPlmZ97yJWKz1PC2LEYoQGgZAqjZV0zMSPDMrtgTzHtqcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oRWJ4GG0atuLNoj/EzJw9Z0Tfy3mmM0LwDahZrCCpg=;
 b=kLIIsO21e2vi1pCXLr36oI6AI66NZ9H1G8+9rxeF2M1GsNCi6kMGtrr8HS7HWUr/EujZOmuUaeiAW4FwPhoE+9zXbE1nWVXa32dqtXjuMVZe/toOVPLLC4jg1htOpO7j4sTGt1fqBmWLr99N8llXHdgAMUoA//czylFqkbg7Z5ak3pRvTcDqJhNl4q/HM3zVqdu3wmDZLBo5rShmMNabCpenqnV5RIlK7/FaOYmnTa14KgvmXRfnw9127b6i+RNg5RnSeyyTgJEiC2XW1jtVPc/zXx6C3yGYXjOqpaIYC57gatz0gqnpWkqhFgjdRsjuwZHtodcogedgMqAFZzZV4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by KL1PR06MB6110.apcprd06.prod.outlook.com (2603:1096:820:d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Thu, 22 Aug
 2024 02:43:04 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 02:43:04 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v3] wifi: cfg80211: Use kmemdup_array instead of kmemdup for multiple allocation
Date: Thu, 22 Aug 2024 10:42:42 +0800
Message-Id: <20240822024242.1203161-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0200.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:19::21) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|KL1PR06MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc3d3a2-e8ab-4dcb-9aa9-08dcc25425a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KZc1ak8SWLgKy7WMYm4Gp/T89SdIJyhdFYhKNz8IU2zTSPqMp1PxYkvA1YHm?=
 =?us-ascii?Q?OrY8h4qBrtu+bCmGN8lVTDxd8wGAj3G24+Mf/et73dl1U6teVybfKM3mJBBd?=
 =?us-ascii?Q?dVFRIPI6WYqh+BkGOLgjVpCjCL9HE/Z837h7LjDLhNTosMboLFiOIxTb26Wa?=
 =?us-ascii?Q?BvDnjNhmCkoSxeqLBlBqE/YTfTlsSt/d7l4obxJZBQqlL3RHevVNMWopo+kZ?=
 =?us-ascii?Q?yaaQ0AL+wOIbArQVPD19NDc0OHg9Dx9+OhJ4gULIbdd0WMay3/mE4BDGoNJa?=
 =?us-ascii?Q?fm3zE3xMiH0m4SqcfOwB6p39ezDEjJqyjDxTDLILUpZLJ8pxZsPbpSHMg2w8?=
 =?us-ascii?Q?w9JaUrgFjjDJIfiypKv2mGCZYReJ57+kEvom9iLFlLShzAxsswWvL8WbmCIx?=
 =?us-ascii?Q?1swpAzCl/qOctZ0FQKqxETmtwrskmguNapqbinr+MPZtNi9Jfq5W7W31iEr2?=
 =?us-ascii?Q?DoZ3gcai2wnEn/XCdIvGoDK4aPMRRWVcP+8IIq7LQSho16CQ2eh6ca9NqRVG?=
 =?us-ascii?Q?zu5u9NkFd5aY7D8NgpOlbklrw2JneBNVOsNCYF5Jvcw1GzdH21xRigw1TIWo?=
 =?us-ascii?Q?YwbD5EuCCSgX2WDGHoMRRrakDdJj7uRnxOy1731Iue/P8xNtYL6bufznMIA6?=
 =?us-ascii?Q?cpDWwG9ckHBa2c9aN1VUxcV1kz2xiiilS1XEPfq3z6Vzx/pLJe75681E0y+h?=
 =?us-ascii?Q?CBtWEsgEq8OPhpRb+pjyQZIeJdrcTGcTyZVdCCmjdv0+QFbHJmbsshE9jiuP?=
 =?us-ascii?Q?qXfSjeN/ohKhzTURSwr8z06RtyF6gCUEKCUmGphlCyshw5L05hOfs/wy0Qen?=
 =?us-ascii?Q?o7UgCw7DpPJB56fyXeMuCLmZ3+Doc5fpEZepPodBYqL0Cqtr2yDLif5Tt23C?=
 =?us-ascii?Q?krl5dHdMXKFshWEMewArxGFtHiMOlXbavRlEoPkBbzpfBPPubp2qCj3Xmrvu?=
 =?us-ascii?Q?78rpBg0rxKVumW9kJCPsWBzlRnof3jqYOzhrEkzLZD1xP9LcsuniCjNEk24s?=
 =?us-ascii?Q?RtB9o/7rfWC8Mt6m69jCKj0ZJOcKFtN3reMix8NZ7cKyniNlq11m2w+yrg9l?=
 =?us-ascii?Q?H3mnhspCVu1i9rXGXmcg791R9DVhV23vgS//nuTw+gm+86uelXdQ/3kQtz7t?=
 =?us-ascii?Q?1S4WMHQ9RpvLsHObJC7uGxY5Sc00AtJGH/BNY1hBSq8XcOAhlvjGswxdqJ0s?=
 =?us-ascii?Q?YykaVxlXBeX0V43UsHaOfEdY1fCn57xd33vr1WyIacxnsj7ku06HffW40ShW?=
 =?us-ascii?Q?sTd0Mo/DKKPjQJ2GNn54Q7GB5t7AtjK6k3EMsMBjm7Ch2G/gm8lL9JYChBry?=
 =?us-ascii?Q?3gThUpTtA7LDzbbKeH8x69/rLLhGjAqAgI/04bvkVXQJUibA3zoIdPaLCR81?=
 =?us-ascii?Q?tG0Xn4pMApx4uIobJM+X819SzZAwP7L8lmZJpR0rbd1848es1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jRgyQfPGfM2Afk8mAIyupHvRdSyz373p3TvuhQsKjo5JeGAYB/xpG+1/dlEH?=
 =?us-ascii?Q?5uc48JET0Gb4xyC8vdjij5eY9QACZXWv35j7ArbvLxHr+930Xu4wMb2Kt9jI?=
 =?us-ascii?Q?J0M/SzhQIUSGoGfIE4cYY9DDN8VPNHwZJEOfLqLcZAcc+Er9UUiBxQ2H+t2m?=
 =?us-ascii?Q?ATvCCsWI2ynesUaztPXC3w06bmEnny1DZjeeiq1yE1v9QfGIK/4zAmr/RjJT?=
 =?us-ascii?Q?6K7puTEc4xXM2yA3B83I6sOALXP3pJTsym1jzG4yLz9Pgz88yVavub+oaMyR?=
 =?us-ascii?Q?PMhKCMzHLPxfAuyNp2Cxekw1eFiYoR8lp+lqiOuWENFqnxV5QXdgN/i7GytC?=
 =?us-ascii?Q?ofH3gQHZ/XylBIObUoEShlQ5Nn1cjLj1PcKH5BB3SZX56cxB6IbOtByytRk+?=
 =?us-ascii?Q?CvWb03KQ81lusilmCz0xcYUW7BnRyPWFJqG8KNTJh4c8uT2c/LkZdUHxdtvR?=
 =?us-ascii?Q?uCjPeeGmw2/QQBXbf318SrUscLu8LOfxTenov/FD7ZJP7kfBHCf/7fU9BRAl?=
 =?us-ascii?Q?DnLlStHrndhlWnDgomHl1gv1BMoFaM/sn7J+BJzl4dlVjaOfHRFVERi7und3?=
 =?us-ascii?Q?xYO9h5un86LbDxM59HsGFLlMqAG76NtVI+7SjZ3uHegAm6JEeyAsh+rsNNvB?=
 =?us-ascii?Q?JMwA46jVzmVtoZ0UEAUoJdMlPm4BHU4WDE4iGnW8D0qTmgh61c/e8zuyFS3f?=
 =?us-ascii?Q?xn0fLQpYYZG2Nu8IIEB7SN56ZYJiPVwFw+zhZBGACNaxsa2Bo4cQy5GQs4vx?=
 =?us-ascii?Q?OXq/otyhZzNIedKCc3NP4t+p1ud1FuU1H9WSG1vDzIjgByCx/SZwB3tsHaHm?=
 =?us-ascii?Q?oahP7TVR02ZrATxNmloDgDxzfDa0IFw6hnRVPsrk3kxFyiY2+LBz3EL+u7Zk?=
 =?us-ascii?Q?w4wRIjjWo08Bezqzf1RFo+rvIKtA1MQbL7H1ZeO3oDrA5Y5CGpaZijrDGME+?=
 =?us-ascii?Q?TAWJggL5LJxZjFcYAomrNrlqFEQ/u5IjIj0+JULEIrqXZN7G5aUPIW7M/APZ?=
 =?us-ascii?Q?hW2tlLY0hxvQnSGoKbol+syroT2orFMpL6hCcuUo9014N717JYkZBArdME44?=
 =?us-ascii?Q?PuWdzphSkXml/Z1rYZvILOrV1uK+iG7Q7+e/oaAj9O35pTcNFCkOzuzEWDmf?=
 =?us-ascii?Q?hLDmURSXkK+IwthT3NVMvYqR3UQuJ59WWd7gbruWUrK77RrmFH5GkZ7WppuW?=
 =?us-ascii?Q?g6Ev1/k1F0bBYIFMDlHrAg1lE8lHvRk4kgXzlzuVKB7OVXxcqBkJMxpMJvv8?=
 =?us-ascii?Q?ONxPFzIXx70Vg/x+Te5z4vU316SII7Gp2/KKpNQKfJdO/tM0R+B3wPz+m5wb?=
 =?us-ascii?Q?nh5P8aT1teIsmrG5nU7V3yGXXB58SsXoM1SaYYpuBmpFEPbwumFSTcaNG6cF?=
 =?us-ascii?Q?DyrhKqifs4Hxx76O1vPBt3MX/2nH1Bpo7AEyZbTq5cmFQ7paWBw3/UeNzivd?=
 =?us-ascii?Q?FUAx9Psd26OfPjCooq8SXAyvTs0/3KdlVh51dq73PRVF5foRpMXuEjxazZel?=
 =?us-ascii?Q?Pb1sCoNPcMeORMF5uqeXmc43SdJWvMFQ6pNcjf0EEWB6HeqOorO4sFb+4ljA?=
 =?us-ascii?Q?G5A8RqmURA/8dKz1n0pkSqHde3HghR6ry4Elp6fd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc3d3a2-e8ab-4dcb-9aa9-08dcc25425a5
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 02:43:04.6053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3I9DNLwtOVMtIwJdUo/OQ6/gFLbDgXVTXSE1IQgwCBOSwvHedWRtYlQW6avoj/k/NEj4cKHa2ERDDlZWdiye2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6110

Let the kememdup_array() take care about multiplication and possible
overflows.

---
v2:
-Change sizeof(limits[0]) to sizeof(*limits)
-Fix title prefix

v3:
-Fix R-b tag
-Leave --- above this information

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 net/wireless/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 9a7c3adc8a3b..e7c1ac2a0f2d 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2435,8 +2435,8 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 		if (params->num_different_channels > c->num_different_channels)
 			continue;
 
-		limits = kmemdup(c->limits, sizeof(limits[0]) * c->n_limits,
-				 GFP_KERNEL);
+		limits = kmemdup_array(c->limits, c->n_limits, sizeof(*limits),
+				       GFP_KERNEL);
 		if (!limits)
 			return -ENOMEM;
 
-- 
2.34.1


