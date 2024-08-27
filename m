Return-Path: <linux-wireless+bounces-12019-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDE39602EB
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 196FDB20471
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 07:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F2714D2B3;
	Tue, 27 Aug 2024 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="k5nxYxgN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2053.outbound.protection.outlook.com [40.107.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D5433999;
	Tue, 27 Aug 2024 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724743318; cv=fail; b=N2rcbTI9RTMIR+6oWBJ+/TkmAHHs23370NB1C4n82pb/vxBwIAFlGw4mIVlCTqE2L7DT1Ap7lZzZxE6E100miwnpjqCX1MFei1NJ5OteZc1upnH67whPXK6ENdCbsfWPPmnrX7F7xMuXPlWwSaMcKQUnH3WeysbS8dq2WdHC9hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724743318; c=relaxed/simple;
	bh=XgnCn7jXEJtyqY+JCglGYe3hwa1MbiYH0D3FYLaypkk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kL8gl6InHxHNtC7IMGvmqkt4xWMp7sFIqiToY0/BbefSfGs2ien8xgD4UrsXi8OMTd/Nh9sdSH72UmCfmJPJRu/RfTEjBJAxrMS8d+P26/V9BBGtIBj+ZAe3XHF5tm7N5i3F7elp1iZyCUgdi8wJA4Yx6tIeJONQHCyFlZfCXj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=k5nxYxgN; arc=fail smtp.client-ip=40.107.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xm/0FNkh2AxywNM3Ffu9xI3893K27nyvHIZB5nGJ57DwMwMmRzHRP7kXvUCStMZl8dDoVPG7KPWLH5ja5NDLIcyCIcbBnI13//hj/8jcerIUu/8Em3RLHpsLIKayEqPh8TD7ACWFmilaSUWcN0BAtzk8RDEuA66m+sbxEY3bPVOM3Euqv7h6kpPeicLADQ99ynabBGJGfboZpvNzTkjPC6lzBhKTmirQqfQA7GT1fHP5CKtpqtARNXkWABNZC8VX/5NFQbSZJxceb4sjpWJxhMXeYnFHqexC5yXxtQ9XFDDPHlBxgq76bPTWZ0xvJYZhw24Hb0GtboKjlribe8nEbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iibISkDTacXmi3rr9uPgJLlKcW6aaLXE944qxsHh/bs=;
 b=dvEezZAMxjgJmUXwT+iLmEdO6hSYXc4YgpDWtdD5KfH8I5ixVIwE51oljVJmcaoL+n6vw12Hbpcg3nOiPz/y6ifTYd3ZAof5zMRRGNyc4lmIfblAsQMNDOg6KhGeG0tc/6ldroWOIsqX1/1ZJPfZ3XNsMFfUYA3g1F/v5vTL/Sh8mlD20q0KTkcLXD/hEidu5cvnuRaHrXKLtSDn4/YELdxZ2GkK8/u9xBiG8hR+TbS+6UtMLfN5aYP+pAxqESGC6JOAmV+2yhdW2xXI6yd+rvtz8hnG7objNbL2KoODS48cRrMR/NEd0M6QVNUHeeNLzfUcUeAF/Hi8KyUBknxTRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iibISkDTacXmi3rr9uPgJLlKcW6aaLXE944qxsHh/bs=;
 b=k5nxYxgN0n4ZV71ybqo9Bld7WT4n7jSZO0w4zCgaN46Z0xept+ywK293EyK0hWPgrznHTuKOwZ97e0mjYThnmt+/J0ncUC31o5XQy6crET4Y47RxsZBz+PqGnxzNiogxA8WVhbwy6cV6kdcKpSGnfIYq4tkjY2u5n1bavE/0i5R3exG7ZgzigXhb77GwE0iwg9h1mlYGg9taYm7ykTL/9wSw27sVjXcFre7+9QW5xoMqCZqHHnFegA8jO33ehToUfPAfUvEYXBrCYbsYZF5go69HSqPiuPg3VTaZ0etQsst0DP/npk7qpc5mCJAK4DdRDhEi+1sdorl4IvDpmF8pXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by SG2PR06MB5262.apcprd06.prod.outlook.com (2603:1096:4:1d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 07:21:51 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 07:21:51 +0000
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
Subject: [PATCH v2] wifi: mac80211: use kmemdup_array instead of kmemdup for multiple allocation
Date: Tue, 27 Aug 2024 15:21:15 +0800
Message-Id: <20240827072115.42680-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|SG2PR06MB5262:EE_
X-MS-Office365-Filtering-Correlation-Id: a7beffdc-5b9e-4714-a4ef-08dcc668eb89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OS84H3+kmIP+P87D68CE4vUfq8tRomRvBSTW0gBQycLrKRjinruk8A7BtHyo?=
 =?us-ascii?Q?pwNh/NOwJstVuQxgSnxjnRDi9FIVW/boFp12pdYeBjrzsGJd1ZdGJ7P/6u7n?=
 =?us-ascii?Q?QkwA2kYKU4mJyygnkFhZxb2eL/r38017UexiQDyAUY2x3k6WkGgHpz41Aot1?=
 =?us-ascii?Q?+6Uo1vJ/aSqZvS+QfHtxknMtYzYQC3eY76zyL6amm23PO72Gp6sqzgSXGTXy?=
 =?us-ascii?Q?p/rgnLhE5rOB0oCR6tqn97daNsTAxKcW1ZmR/ZK0ONxlajv83Gu4A1w+msK2?=
 =?us-ascii?Q?E7hwr8GdB181zT/fEGVDh+NoMM7NIXt9ON4fsz0SCS12+yYxGSreZtZd+b0K?=
 =?us-ascii?Q?dVLQWAYA9AXf1eg1uyvopXc4Ob261qUbQjb3CuUsJVB9m0ZzEPnThMerDR3d?=
 =?us-ascii?Q?cXlVrdjcWj+qza7h26yyIJExna7jHr7+KT9fBnKC7x+wPdg42TwUTUjwd0N3?=
 =?us-ascii?Q?49YCl67ykfJncRQIhuOpPExoptGsOJIu7dCnKCia2CtcDy9sJWwnLiBBjYZ6?=
 =?us-ascii?Q?YIOBF5HEVdjmoFOWQjb+WSgZ2ANSzzlexXNaw4OMmS2EtEdYv/LCvdWqzyxS?=
 =?us-ascii?Q?M7sntyyYIyCyj4lJ0JWMl3QwX0AScJYlQhwCu7xhCQVSm+aFgds5w/5BiX6b?=
 =?us-ascii?Q?G12NlQRIloH1WA8ooUtrB75XK9ttcD+otJsCAoUIUIiFLLqnxko1q27+okm/?=
 =?us-ascii?Q?4s5p+xSDU86b/D7Ln+xpMRlVvYCnltr7jkmgns/OtR88NvSQVbBLNyP8TBzp?=
 =?us-ascii?Q?mjEpil/RvQxMmh0J+rutrVue6EbN946uClH4eXk0OWoxljoXf9xphGZcxWOL?=
 =?us-ascii?Q?IrMS1/Q/jZnvsfGLti2X2hKl2CZmjKDDiiLyMA4mcDH5udLyK+3Y9Ze090dB?=
 =?us-ascii?Q?UNThdCz0Kym8dd8/+HjUiFKILLXmlb36jl5OKOGZnjhEPshBfb4JN50d3z2h?=
 =?us-ascii?Q?bTw4ji14AGOSU5d17b2YrAo3/XtLxxaKaAojlZeHBnMAcU1pBHZpwCEpL3C0?=
 =?us-ascii?Q?ox+GTZcoqlI/m3AGnS2HRIo1HVdojq13tczz0ksPNjs7miLKCk72BmLXOc/A?=
 =?us-ascii?Q?ulMfwS9H5CAgnOr8A94zvu+7gBZ5MQBI7Mu6iQcRYaaKKRXePIdlD6ekL5ac?=
 =?us-ascii?Q?alGqaiNpNPzMDzyi/VND74BKYKu6cVLRdUuOkXS1yVm+Aq9hD8RlL03fWVn7?=
 =?us-ascii?Q?Y62RHeiY9ztWtwh7emUxRwCqC/rEbMXfkb7Te2Hvqt1xfThGVWEuUli8eVez?=
 =?us-ascii?Q?q+zvjEW6Jm8g+MQyFfNzxK0y11TSbitQLbAl7GFlC36Dx0eswPP5Do2WTglU?=
 =?us-ascii?Q?pWBUnTdibQA3/3HuijxDEEe0nUsw6rsHIPqu8rGvH8w7f/i4gbTdxqoxhCzy?=
 =?us-ascii?Q?CnQ/8d+Ol+LrcpCrkRLDh1LafTCluaAIb8wNJQ8U5GL+OVrtHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c64CnWqBolUv7Y8SGV4AVCIUVvSs/aLwRVNCBEaAONEudK7XyvZCzDAXDzhd?=
 =?us-ascii?Q?K2B+wy34EQ0rjbjB4zUhEm/f3yWtW+nPjzoU2HV9CJDBnZI9/whhAyxqync+?=
 =?us-ascii?Q?APKrME2f7ipJ1V0C3FMH5K7Pad/x6t35H+eDv/oaP4GfyIwm9zHEGDWZlSDU?=
 =?us-ascii?Q?kwE+r5L5d+U5XSCc8XJfKkji/5liscfgVQk+ZYSI7JUXV5qO6j3u9VK1XnnW?=
 =?us-ascii?Q?QJNuBVBweqsyktEHhhl/TyJGNLzxuPgLBREj6wUdY95O9INGm6yQRCed6GLd?=
 =?us-ascii?Q?kQYS9Tiqrf3fF5hKG5meyVuaDsUkKc5/Cvt+xzrlPP3o3nZxPH1imIlJFSyJ?=
 =?us-ascii?Q?i8Es9fz4/fmzEPlW5jUFkXP18jXCH7H/VCHlhq+HDusXsiT9ICHv64AqKKXh?=
 =?us-ascii?Q?zkjeK4IG938Lm2melgBqdIqWXVbDSicpu9uF1MwzXMRLoHaEwzCx5uCCZ/Zw?=
 =?us-ascii?Q?Vgp3/2bwtbeZRgAndIowWZWtDnj+VI3lz+O9dS5GxYxqfp4iGX00QxFXmPva?=
 =?us-ascii?Q?5Xl9/Uv/OLyeAGzmgFtrKDypMNWHjFVjGwd+6qNGhC+jxPm5KTusBsDrfDm4?=
 =?us-ascii?Q?zr3L1EALIpEkaAdabruyO7MYHPCYPuAzNk4B5b4QmyQwSbG7WHhp2FFOMWxR?=
 =?us-ascii?Q?ZsCfPL/AcU7roxisCMr9Y4B1rV93MyntkEk9LCYEtolCtCq447D2x24mGW3B?=
 =?us-ascii?Q?8ZO26CpT55qd411l98B41nIZzwU2v5YqzHPHcYLB/bGPQV83PPCSKavteqts?=
 =?us-ascii?Q?J/t1quExJfmccqtg3sxMrVC9ONJ380YTDtbb/5AFSdE+iWndCjzh1/sabzQq?=
 =?us-ascii?Q?OG8jPtJtEhRoIHecl3SFVWnmttLwMs68uxsC6J8AAA/1TAn65IjSl4hynqCF?=
 =?us-ascii?Q?5tCCSj51Bdt+G7HLN35vEn6l7H4IRakozUHfWn3EHypFSlJ8VkoYvSkp20v3?=
 =?us-ascii?Q?tkRT4HJGeSVHcXOpdtkiAZhla7UhwLWZgM6lRlkdF3NDBlYLef+AL8azqAvA?=
 =?us-ascii?Q?tUbWfytVwAJ1hZiVyABrDXXjJ/dNlRJi8UTfS3Q4811YlOXoU964wFwMwB11?=
 =?us-ascii?Q?lwYUo2uomqwK/0Ymku9nrj4DwfzCVdugand+m7JkJH5OG1uK5d8bN5h66wTk?=
 =?us-ascii?Q?pNvY8Sbx7bKaigEfGiwcITZ/pU8Y4qzcg4hNCMQEUzyezjOsmSdkT6256OJb?=
 =?us-ascii?Q?Z/H3jvnSySwNlO8aNt2EqWPnSFgKun1pZQFEKW3kEDcuoyfP0lEsI90NlwJh?=
 =?us-ascii?Q?Zd6aKWnbVVvJwe1shHceviiQ5W+fMiHtFuVDwK7qxd/0pIuN2nsYTkWbeVIu?=
 =?us-ascii?Q?jIenL196g3lJsNs85Px+xdBWgwc0pmIHQoFWeeyb1pZdWryqhPGg608FWmN8?=
 =?us-ascii?Q?3ndnnKsKVWibr09bKdvQlqDvnuMxJcaPChmiG5cfzJmoC/iO95mmk5r03qhp?=
 =?us-ascii?Q?udmXql9hZcYQZu8W8eZTaTbAODdkGs7qOBs+/B/Aoizxj6oc/Xbm3WVi2GfN?=
 =?us-ascii?Q?k9rnU+y55RXvxbhMeYdVwv+NG8Sb1zt0Kyzl2IUKkwAhRbPOFqiB+AkGfvd/?=
 =?us-ascii?Q?TOrryoKzIeAPLeCkjnaJg2fWeamzXpVHeeeWwE7I?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7beffdc-5b9e-4714-a4ef-08dcc668eb89
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 07:21:51.2618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEGB2LTNunxwme+9DeuHIc6RPNRDmON+9g+kfo7rTEh+nki3UW/Zp3gz4VeWUtBkRiNuTc2A2h+z21zuQDPrMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5262

Let the kmemdup_array() take care about multiplication
and possible overflows.

Using kmemdup_array() is more appropriate and makes the code
easier to audit.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
v1 -> v2: moved "sizeof(u32)" to the next line to not exceed 80 lines.

 net/mac80211/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index a3104b6ea6f0..89084690350f 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1051,9 +1051,9 @@ static int ieee80211_init_cipher_suites(struct ieee80211_local *local)
 			return 0;
 
 		/* Driver provides cipher suites, but we need to exclude WEP */
-		suites = kmemdup(local->hw.wiphy->cipher_suites,
-				 sizeof(u32) * local->hw.wiphy->n_cipher_suites,
-				 GFP_KERNEL);
+		suites = kmemdup_array(local->hw.wiphy->cipher_suites,
+				       local->hw.wiphy->n_cipher_suites,
+				       sizeof(u32), GFP_KERNEL);
 		if (!suites)
 			return -ENOMEM;
 
-- 
2.17.1


