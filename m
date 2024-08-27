Return-Path: <linux-wireless+bounces-12014-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0CB96001B
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 05:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60761C21DDF
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 03:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D0A1BF54;
	Tue, 27 Aug 2024 03:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MEfR5xG+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2079.outbound.protection.outlook.com [40.107.215.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E77219FF;
	Tue, 27 Aug 2024 03:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724731043; cv=fail; b=jurLXoJbX/i5bqrJRowpoKmLAUwzsrFoXdL8aICrwr0GnitwNLndIy6iI9MCwEC+N5nhHmqYTMiQiCHrWLqDv9LAgbeU+FVKPMx8ajJL3dQetz/BgAn+wc3IFdl09mRJ1u1mkX4h6FUqh0LvATZvwiiuhEzAGgiel0jYJRlzgHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724731043; c=relaxed/simple;
	bh=MgCw8EaSfWHzz2pr9jU2JHbbKFMNvYGGu1rQIRC/K1o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dO5bo4KFBZURUy+cxiWLZP07NtOR7N0Yt1auiuEI9bD6Zcj9tjgbVNMBCeU6z9pHgeLmE+E38aOX/r+fDIMo41H6+3s+bOnCy+ctwW4vVSKXY4zclqvy7MTfzd/fqnjKObKLFvUtwAh7F8iXU8QyYJDhvuAGrC4E7obAQum1GP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MEfR5xG+; arc=fail smtp.client-ip=40.107.215.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/3EOvsP2lEkwhcVCEhw/zDYabFNqxMBZGFHYQjQoGm4WdpTKj8vIz38KuZt6ITgC9lbsRYQ+y4ylHsA9xmRqsOHvJVR742GkwED0O+Bq37k5jpwR2vUOcrcuYftkBOhUjpzx3Pm4AN+9Wf9QoxL24jgRnwu18/r8xeHToNSMLmIQ28KAtAdfdibCOUhwQywJQ6uRBfZ52ZfDyxYsrO2C10VnFYwD6m7T3wLcEUPpfNdtnkt199oaf5Oj2DcxQjg8HFA7mgktmhR3z2+CGyX4Vkf8Gg68kaqVsLyYQeVHorCmbQUQHJ8yX+fut1VI/vO8Gmc6GsKeEMDAKN0pGVeyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGk6B5ukd3A7igIQr5pp6ntcHXLEozgzBo2dELjPi74=;
 b=pae1fq3wGsSyYHJU3oZ2hIusQ2GucINPibsf9vaTUGIFbeC7kwZ3e7vjXm8OnOm+6BGSvFZs5j5wh6WobHy2ZWz+tTbNYi+2TxGFZmHxtg9hse/ORKoH0SmeoTzifVnCwuJUsG18i/jHGCOmWJrs7qbo6Z9KfyfV3IDRV0HqVI5Ihsh8XYesLWCihp23TMxvqYJ7yGQtnWF9cT8+WdcqCXLbyKvGkZ3IVJVsdCZ9ViAik9yn/7mXcBn8K6SPYmRLshST+ZvCTeaQuzR7nBRIMHWUw1ZJMWQbbj1NtwDVMrM73Eg0WFoCnnLhN/wL5dORRE0u/ytB48MfTuJrt/XezQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGk6B5ukd3A7igIQr5pp6ntcHXLEozgzBo2dELjPi74=;
 b=MEfR5xG+j+FXbUdgcjr16wxGpctD+IPA/+5nzs4NLc+84DlhFj7YfICY+uvrZYmGOrS4fKIneIn9n2CS72XGTcHuVA4pZQRmkhh3p+6J73kgxNJTWCykpSd/tScgJbco9/PF7onJ+CtxXaMoL3rY4WfmZZyajSbwXtj8JcPzDahMco1wuKOxiGVLYlokroU4Bqvz1i0clU7/GE49TuWKZXduKtmlY095TlmXV7RvGxaTZkh1u0wCTXsZno7aJdcEcg5nQjWum3IpE7U7xpnh95OsgXCRhkgqwzMPQJ0yyhlZMncfndSt0EBNnNbmlcvLRtX9B17UctqBkP1xRIm3nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by SEZPR06MB6231.apcprd06.prod.outlook.com (2603:1096:101:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 27 Aug
 2024 03:57:12 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 03:57:12 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] wifi: mac80211: use kmemdup_array instead of kmemdup for multiple allocation
Date: Tue, 27 Aug 2024 11:56:52 +0800
Message-Id: <20240827035652.33558-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:3:18::21) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|SEZPR06MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d1697b-3c80-4e49-9597-08dcc64c54b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DUVeekpU8Be0OeYwfzyc4SMQmWKxBrRCYdNxWe6KPtEQoC/AZHSomfrBXJGK?=
 =?us-ascii?Q?kGaJeRBJ9UNYXowin3QNFCWt3EXNuKDexA4P9HpDqp0vSQIZJ3fniBidXkVd?=
 =?us-ascii?Q?3fZy6mgFxaHDyovjiNsg8eK/A9SKa2kI0ratown2Qir/2C01jcBrKONL/cCG?=
 =?us-ascii?Q?nRiGx1D/DayQ+kvhsVdBtNJbiuJwIlmscXNdL9jZj95+cj+51NvI3DAx44fk?=
 =?us-ascii?Q?cMFfeSG+JCnJMcYPcWp+ul91wZfqJnHveO8B8YxZrOdYUxGmFiIMBJo1zUjd?=
 =?us-ascii?Q?7N4N80Tls4HcyTA2K+yJO3UlW0B+eF5lgdkTs1Neo02b587YfTBZuUZey0hM?=
 =?us-ascii?Q?Ni0XSZb7By7pzbsdvm+CuUkj65/T54knjwPMrqrS6FKOmohn+ZI9xEzlc697?=
 =?us-ascii?Q?bTwOER6q29cyJNE5Di2of0sKVnHVss6579vQ7PKhWB1ZQV8pAZa9Jj1ricus?=
 =?us-ascii?Q?Rw0iMSy5/H7ODNwncR+298Abm5b3jlzR+5afM6QBN/UQ9Z+Zw36iS/jjSmpv?=
 =?us-ascii?Q?h/p2k+jT1f/m0ntxzLi7dILOoWcZBCAMSxdT8O5F/R12fuXNLsuE+brU5RQO?=
 =?us-ascii?Q?i7oSL1tbAWwaakzz8YKTDtMdJCGfM1+wj1hYmH3KaiPZw2MFJpqwpSiIEP5X?=
 =?us-ascii?Q?xJV4AzAE+yJbPATasi1JdDXqGkY266odF27D0d2HxzolWGFb2TUSzNjgKqTt?=
 =?us-ascii?Q?S5hm1io3laSOTJDS3fc3O5qhOjxvvlNz3Z0exNQSCp2P0U8D+bg42zNAqrGE?=
 =?us-ascii?Q?Qxs5sbYBRFu6ttOVTJh1CGDV6XyjOV8GLqNPwwldlGJVE2GmuTYOMOZ5HoWM?=
 =?us-ascii?Q?QsWKbD4ndMEW/jOWZJvyQ32me+n8U9WZffv//VJRwoi6epezQpasB33YMSim?=
 =?us-ascii?Q?Wt5E+RTSeuDsF/6I2cZsAFXlRfCB04b5s5rgrmMEN7l6/QCgaCz+eaxYdy+E?=
 =?us-ascii?Q?5NELZzqYHyEbssWm5iGx/oueGzYBfO1VGasQkEUZesMIHYaVOow+Xz86Y1cK?=
 =?us-ascii?Q?jCUuPl0Fnbap4785D+rlOHFGSueA2KhsgYuYgd+OjhzTcseZIwvt/2t1uerI?=
 =?us-ascii?Q?3TouDfh7NlYiihoLEHYGbD/KvK/wl++dDA/HjHW53aW5JG2Wbp0NenoUHWmf?=
 =?us-ascii?Q?LKpRpk+HiuHjjUlpFVKWibAG9u4fAnCpG1XEvXdmawPG9fij1YIuPWI0bpYx?=
 =?us-ascii?Q?NEecRyG+cXCV/blCGjvQyXMf/arq61uDl+4GQXUJK+EWsuyNciFMmi8ZX+K9?=
 =?us-ascii?Q?JN3lK6FL+8mHwJsQ7awn/gcwGeKeWd2AGYg+NLpAByXgGy4p87aVwnO9TJE+?=
 =?us-ascii?Q?HHn4hdyrz179GKlttpwD11TLqYH7slFxB8bdfz8BBLOjqC5n77hofkl8CjNu?=
 =?us-ascii?Q?JqW58hqws957+ld1zjVExpRlxW6FVx4F9XrQJu+arcQ9NoCU3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4U/1gX9QisWSypmOf/O1x7gbxOlmVLG7Kk/hMLgwrQDW25V4WcImDx9C4LTu?=
 =?us-ascii?Q?tR/VDCD1O++PS7DfkMiO+d+IXksYB3MdWbX4DmsAgdUdfP235DlmG85AYgZd?=
 =?us-ascii?Q?6HosTkj1kZ5fDfhdVvJighBKr9Bg/J63rlzt4P1PfXoOJuTd8X0PVlT6gCUH?=
 =?us-ascii?Q?BkHwvf3ysOWM3zY7clJAOVJ+bv1fcwN+rpMLdgxNrk6RQ/sr+MovCeo/PF6D?=
 =?us-ascii?Q?DDpYbU3i2xUwHWkV2LDz8z1ZJPl8ojVoLITAe8RM+3X3ejU1D6uHOAqUjAtT?=
 =?us-ascii?Q?LBqZSI5MXVusCdtQl6Mm5LwSb7goEC2hvEfXeYrb++Zc491kXvDdKF9+nQnE?=
 =?us-ascii?Q?TUTb7F119ok47wIztgLrqKtRCLV6mN2pJoH2JTtoMfs7ueZEu71uyqV2aPbt?=
 =?us-ascii?Q?mOUX+XrzNlRWlcxMDVqrQM82Ha05BYpsAuvyfv92i6XONkXOTCNI4a1jZ8Vc?=
 =?us-ascii?Q?Bvm9Wr46ppYxjgaMXToYxBkoLeHFglDvfSq6Tqai4wWQTK11uI5t9YK1AcG4?=
 =?us-ascii?Q?u/lB1qhmeASJTzU1HWkTap2Oo0mro3WFRA/wWmv0/Ja45rhOxUMMboyFvUdt?=
 =?us-ascii?Q?rWUOTbg5xCjBHDN9bpP3gzQLJvA7RnDMIbc+um3erQbcv31YeMI/6UsgLwA7?=
 =?us-ascii?Q?Tmr6KwrnzTOVaeIkaRk92SNr4VjKOAF1SsR05r0PrCwaBsgd35P12bAjYNFE?=
 =?us-ascii?Q?3kwX5QGiwFnGusL+FToBHJtWs1WG7rRA8Ns0d2MfCh0pPJZBC9I/pK00pBZA?=
 =?us-ascii?Q?JAv62rh1cKo0MKJMKy03S4oLpQVMmkuekNyUF2XDRXcasgAvQMVbOpZDUrKy?=
 =?us-ascii?Q?eEoDL87LpDKrqtg4x5MMD67mwN9bJum/g3ZHHHyMC6dl74QNnp4r8tjOiUw7?=
 =?us-ascii?Q?UP3RzKDc6LXuUU7KZO3FIgx+VARZu7HZ4vwLzYN7W2fCzlM265mTX4XrxspO?=
 =?us-ascii?Q?viX2xusAkLhy0ncWgqlc1QmF8bF85XJXNS7QkXH6o48tC6BUB3a3FhwfsEQL?=
 =?us-ascii?Q?SOY2X46k4dXb+PM6KddzflQ7pG1vZiMs4vLAyWCViNXRTx2bFgAUMKJAMNPx?=
 =?us-ascii?Q?06kEatl40rp17eaWu38R5ky/KopOBhKtOdKYtEfh6fQU1R9gGiRs3+Ew3R2x?=
 =?us-ascii?Q?QRBhUFqqwTzAWPRZA/+Rx/C+5FE7MCNzSYF5TxyQNNeUVP1hhTfeqrVdvsky?=
 =?us-ascii?Q?wdH0q7/hKspB7P4lrfPxD65Ll26kzvsonGDr3Pkc7sWvMINMK3169m7grNrR?=
 =?us-ascii?Q?jB4mrKgZ7Y1wdHAbbnX57oX/HGek6CVfDdhIHrmCd7qfGPWmzf3ltyWy+Qch?=
 =?us-ascii?Q?2VfYudpKQNw68ydONgMrIMd/TBX2dhQfsSa2ij5sRELSaS5dwDgq57CrtvUH?=
 =?us-ascii?Q?Zn+vxZoUvIepzKh4hoEPymanD0n6QQFIH7uTezFJ/Ps0kFee63XEm1k/suKW?=
 =?us-ascii?Q?9vfjCKA/xnQA990HHi4uPTFgQ0Dpy6Q6iCwMtliZUvTzJXaKGlRJr4DYzimj?=
 =?us-ascii?Q?lD3GpCekx7PIel/exkhqGxUPf1hFrZIe+T05ctZEk7cEAffnGJniq2PAggrQ?=
 =?us-ascii?Q?rmSiTkwtgrzQvEUgSkJ/loZTYeOoj5NFMM/y+vaR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d1697b-3c80-4e49-9597-08dcc64c54b7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 03:57:12.2908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nq14YTkiLhx5aBXATkVAKZ0Ox14ty8I/C7g6YIG8YbJCLBgFtdJWXP6WgvUfXLZfJDMqf/9ie9UsXlhZQrHO3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6231

Let the kmemdup_array() take care about multiplication
and possible overflows.

Using kmemdup_array() is more appropriate and makes the code
easier to audit.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 net/mac80211/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index a3104b6ea6f0..f16ebad36a83 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1051,9 +1051,9 @@ static int ieee80211_init_cipher_suites(struct ieee80211_local *local)
 			return 0;
 
 		/* Driver provides cipher suites, but we need to exclude WEP */
-		suites = kmemdup(local->hw.wiphy->cipher_suites,
-				 sizeof(u32) * local->hw.wiphy->n_cipher_suites,
-				 GFP_KERNEL);
+		suites = kmemdup_array(local->hw.wiphy->cipher_suites,
+				       local->hw.wiphy->n_cipher_suites, sizeof(u32),
+				       GFP_KERNEL);
 		if (!suites)
 			return -ENOMEM;
 
-- 
2.17.1


