Return-Path: <linux-wireless+bounces-25471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701CDB059D4
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 14:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE8597B6A7C
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 12:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D36275873;
	Tue, 15 Jul 2025 12:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="BoI1Sr67"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012018.outbound.protection.outlook.com [52.101.126.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0A02E3AE2;
	Tue, 15 Jul 2025 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581890; cv=fail; b=GtVWHO89JtdIyDpzlZRS1VO3w+l6O0mm+EDaGWeXkxe3CMwnOoZnGM4hYiYAqUzEk6N5sWEyrmOQnadVokVGqUyiwp5aBsXf6NPQxWYLfpvNNU1hAb/tilHCXhv2abfiKFBSKajFsDmLmrXlSvezlo4mKW9CyEsIP7bYhM9K6JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581890; c=relaxed/simple;
	bh=MUOUzb/SQs/zMZ5TF+pZAij5I7TGlp8GPWFUOTgCW88=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hHhZ0W2jyuhbpEMWQaTzlakHg2+W9e89s4eh6tagB5DJEDbgThbdoN/wydT1LjTAm+LaR/KbEwChGVc/JShwVx50ydWgFrNSUq22n21oP4L6QPEKqRtiyFOTctVcZdejqxEbBGMJtECKYrMYFHJUXnBUemzJKQRqBKVtKbegZ10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=BoI1Sr67; arc=fail smtp.client-ip=52.101.126.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bf9NS5u8ULHobuYJIZPJcy0kXkAuFQcrL3NxfY2blITgtvyTYH9l8LJUwXL2AJEv/kbDFCdBnFdwFx8RIRI3bfvN12Be2x4PYHpdFvF5n4uV0D4/RJDsDCq5WtY8dYKz1mLl/9wwKagwEjDSbumjk6BudQ0lEw2kdP9guoaL/5aNxxDizQNzpe9lc7GtaXeFnDEyuaY4Na9yiNixK7ujg/NBotksLcb7Rkg9rzi19GVx0Mm/WF1lSe6sk2AyiXXe06CRHQgTOh0/3e7jXzjN1RrhsXp0Ap0doGEXEEnJ3NEuwG0OcHfv+NPHtqLvi/1At5tnmiYpmsiHn3W9jhKthg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJGVBOs8Su3ydrJrg783f6w61QLuKDDPzRhSYFvGe7E=;
 b=pYJ0lY3JGKekOl5PT/zUEYyk4lEnS0BX97Ugukmus1ftZIaYM+0Yr2uK7rDSjsuAoOvTbVML/xzVZGQeiNTGwXD12Ayqj6E339SDPq0i3s1o5dWBfmTnNojEjPC//wYphWd+vbiDBK8VETjp5NnZ6UmKo8mU4GAieqWr6mMcl4k/ZJ//dkZO8In1q3owcoSSTunMvxIIDabLcANOdX6BTuhA2Sukf0VZLQzuKDB7nS0jKVNLMKAI63KMZyz4UWNaChlber5W5PqRfMSc1f3lmGpnao3ABMdL6g6wxY7PfY0kN5KzTZTj7cSXkaFaE/hJLkdQVl6xETuPY4/ajYoa/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJGVBOs8Su3ydrJrg783f6w61QLuKDDPzRhSYFvGe7E=;
 b=BoI1Sr67FU4ROLGme7ESAxFdlHMU6Rj5AuEV0htgt3XHauHSLTAmNXgRn+KeN/DDz5Tj46di0PfykjCAjQ4+xLgT4k+zzvSKngwvoT1D98q0TD/XnxptUlvgoGqrfts7ZNNSNMFDx48T1cEviYIWwK7YePHrjXe76wNyp2af/v3DL2lvlnatXBE4uffO9YG2I057O64k+DoR866SlIpDsm2pHOZ6qLkBR+19YU7F9vBouu8JkrGBJU0P26OATIGyh64m6PfG+0Sk1FUFiQcdRLQEk65KwRwSykb09VEXmLMYGoPbD7UNDgtQN/cdlTWjfV4r0zF2p9VUBDrP3yWOEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY0PR06MB5428.apcprd06.prod.outlook.com (2603:1096:400:219::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.32; Tue, 15 Jul 2025 12:18:06 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Tue, 15 Jul 2025
 12:18:05 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	David Lin <yu-hao.lin@nxp.com>,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	linux-wireless@vger.kernel.org (open list:MARVELL MWIFIEX WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 5/7] wifi: mwifiex: Use max_t() to improve code
Date: Tue, 15 Jul 2025 20:16:51 +0800
Message-Id: <20250715121721.266713-6-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715121721.266713-1-rongqianfeng@vivo.com>
References: <20250715121721.266713-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
 SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY0PR06MB5428:EE_
X-MS-Office365-Filtering-Correlation-Id: 1182d4bf-3052-4124-8713-08ddc399a718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fEfxFS1MD9qa0vdMJcyeLzq+do96J9jhqgARftzeiEyLKq/LjaGLIWi2RxlC?=
 =?us-ascii?Q?r7lwqNuEtMC3ROr2uQWpwpL2R31DCPvyNTUCWMm+mCe1pUrpp6GsFfNk3SY3?=
 =?us-ascii?Q?nU6Dr73AmyXWL9BrMO0k5Fh1FJs+o5Js66unE7HeWt+6DhJfTf568DTtEJrN?=
 =?us-ascii?Q?1zHV/qsVgeAr1jJoZ1zav+ACHHP+8O5LF+I2qp6PzrX6VTdMaejJwkV1lHLY?=
 =?us-ascii?Q?7nisFfEHIUaW7MUqDw2YIoLXRbmEtRxZCVihxpEMegF/NgIimhDd/s2PCDF5?=
 =?us-ascii?Q?5CYo3hihKB/zxdZSUHR3QWky+X3qu4qMDoexXPY0SQMD7OI9OphdzMn1+uCW?=
 =?us-ascii?Q?evAUFaAJ8ZnUR9KngH0jL2L+NhagcfLiLMXt+X/eCGb5IEcUwM5RnvfA8npo?=
 =?us-ascii?Q?ZYz8sfhmyWyc3Xj5hDK428SJyoG7z1Ngb/r7htPyxQigusBASrZxtQujibmS?=
 =?us-ascii?Q?wewEdgnDalLdWOydllssmHqyrZnddcWvH4XVKCZ+uqdCFfIrF2Sx0joiyorP?=
 =?us-ascii?Q?6pNfL+xcLinQaYUwWIzzR89Xww9F1uWfPaaO6LZ2gcws82XlfoUGI/oKzAZY?=
 =?us-ascii?Q?fs3KCgz2KrQDWMtuFaXDKcvAwLZKmSXBtngNFi8qOTqWk/zqKOeTGeGrr4ub?=
 =?us-ascii?Q?49L3lnL4v7XzfCn3O5Fwx4IszoLGCqcUhVqJzA6c91MyEnLdZRrW10CaxANc?=
 =?us-ascii?Q?QRgxwAnNvCf9WZ1oqqZVN7lzLLKoXdgMKP9R9sHHT0YQHf+/4vUYlVh61i1s?=
 =?us-ascii?Q?Fq/y0U66YgROeTFXi8hlNIB5xlfq+r8aeD1cEOI6SgpmjymgLS7BD/tKSxIS?=
 =?us-ascii?Q?mxMDgYOFM+7KMyhUresS2p+ius4thsNdp/7QrSdh9Qwnp0CxdbbQ+YWHIVK4?=
 =?us-ascii?Q?X2bpeZJlhZasjeIbeBXJI2nHbOvGzVf9gNoaQ83t+lHbtBRTcAkw0IdnfyC2?=
 =?us-ascii?Q?8DpCvNCN2eJP0zeUqAuL18dCWc6oDQgqBH1hPGV+5c2bQdYkHJvU91BcnaFa?=
 =?us-ascii?Q?UlX2hvFHrsMUToWbcmti9/1YC1Uq6GfQkSbdn9kdBqR+njxQI8jY2OaJG+LQ?=
 =?us-ascii?Q?BJtOqu6egKa4V+xaSiL9y5wp+YrxNjEdPFSmXCMRseOLSJvr0SX3LU8wh/HZ?=
 =?us-ascii?Q?lpJzyKJGVEu6FjsEcuqdCPUhGkB8wDexUIMB+nRFa9DAYqrPRvLlnbfqsyql?=
 =?us-ascii?Q?qN8reJOF59hEEXEKnqU+qfJkG6jSRTdWMCcejauL1gWdsVqgHrkxEN4CZkqy?=
 =?us-ascii?Q?smamtXMYtG0qXBYHk50I6TeNPbRtfkRQjbqkkr6vfZf1WyL6YLqx2pa+9+EQ?=
 =?us-ascii?Q?SEniGjmKy/HqxGmqoXT3aGe+rn5X2f0zIVjwfdp1VJ33e/gYnqRk7arRV1yU?=
 =?us-ascii?Q?M4iPQnzGdqI9oX2h2N+tgPz5aY8+EJboJdzlzzZt0qT3/SXyYMeIJg7+JoXi?=
 =?us-ascii?Q?NWE/Cj/T161jKXAd0D57WHK+Y75I2zntrfunnN3Shv1zWb7Ua85GzQK2xDcQ?=
 =?us-ascii?Q?qy75Ot2F9Z86oco=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IL8jKc1lMYhRVBRcYEuYTLX97zGRmzNgmIxMl3NsKiILayJDuBfozduG548z?=
 =?us-ascii?Q?RJsesGu6TQhY+F2Ri27vHt0NOSYzdMWjVt+D94T5oMrKaVl8K5Dp1waUejU5?=
 =?us-ascii?Q?o1WfbJwJ1CteK10NGP0Y7lVvGX5z2eV0TUjzPoGTcJonwB64d5TMNdrXDxOC?=
 =?us-ascii?Q?fsHP2YTfXS4NfSCag9AFncAFn3TnJh+JBP1sWld8J35+EcRq5JskyBc1lTkA?=
 =?us-ascii?Q?yIO1v0vQ8lMpXSd2UW7UHu/SrpTIm0SiAOpUjzWtN7H3eEJSUDOdbo2ojew8?=
 =?us-ascii?Q?FqEvmvUGqgmIC9FtIrSfH2k9jNJ7DnFh2JeLuJVbriCT1Bj7Ee6E/B2QnUYB?=
 =?us-ascii?Q?znDm76hl/zvR6LP8YutDU9ZzyF78vHV2vgeNrEi2f+ZIrg5mqt7rz2B46EG7?=
 =?us-ascii?Q?vMEM56zZoGZLEiO8IrIL9SSbo762U7gJ5CCHJTIKIHMB0dWv6CKE7xsPhIjk?=
 =?us-ascii?Q?spTMgx+mP26C7NwjSbkbIoi4cqJO+rLg1pHEU5gZZiQn56dDeej8QyYjQXJe?=
 =?us-ascii?Q?NK3guDKJeIk1ZOQU5i/X4CkWrhImbs1+a/hx+nAVsdmYiG5rrzdXFpIC+Pye?=
 =?us-ascii?Q?KAD4vGm1v78ZOd6Yef2NTr1FroFe90IPR49VZRokhs1mXhPpF5wxwLzp6Us9?=
 =?us-ascii?Q?Gmu9LCF52jjFq0r8MksvS5M0+fqFYDKbm5LNaxBKg2tcsxGArnANC/DtffVw?=
 =?us-ascii?Q?3ZOPSBZghvlRidVFiQtE0hHOwADBcYNGqaEMdd4UsmVX00Wvvb0KkDfVZr3t?=
 =?us-ascii?Q?/uX3VN4xPkfwW72fB6Sakl0tpIx1Gw6EHdT3uovOQlA6L7s60AcSlK9p1wXk?=
 =?us-ascii?Q?ppE5hoaCfIVwyppJanrBTJguPa+621HqdZq9p/4nLtrj+telKPDsNEc8NTLX?=
 =?us-ascii?Q?QF6taqnGbD40amdTDH3z9B94HSrlWYpEqaO7tVYI4n/EpwUTEqOhVvpha9ic?=
 =?us-ascii?Q?50PTgJbk3aprU95fewVEE41OtM2qfha43f/j0uRbZmDkbv0ctZC3TRlO+g9p?=
 =?us-ascii?Q?hSQ0/SCT7o5O3pNkDONdEAnr9+5p6ZmOtnEpiyBTG5+HGzo4/HMMz3T9bfZU?=
 =?us-ascii?Q?rNkOkWVBIcbIy3iHdSMSBGrwncxLx1QR/QSVg4a/t+KZgckfZj0/n+5LNdOk?=
 =?us-ascii?Q?Zf7NjcEc5SmtCBFotASD1SVnERDhw3zGzoR3eG6cGHMHaTrz98pTAopzNArx?=
 =?us-ascii?Q?AZfHjq3tx2XyRFuQYv1rhpdFlORukKW0KMgy+0/mxJ23Fr2a0GKZ+vu0h3wZ?=
 =?us-ascii?Q?1RWyE61N8As9fEJ+oaAMJuKj6BoApXzeEzjTZECYwLinw9hB6JihNGkjd0HR?=
 =?us-ascii?Q?Nlvq68YOIQka/JuVaUbo+han4XMIe4UfHNHHZy19ymfKpThyUwySd9CHI4kL?=
 =?us-ascii?Q?l2d7Jz4Pd3d/75+Dvnp1353AqwilE4+6z0uQjtAbmNw5mHtbvYq4ziE3rr1g?=
 =?us-ascii?Q?cESoSmNRa/L8W7EhmcoYVJtoATGmvTsEUu7qf6nP6KLjS5IRGPt+fVa49zU/?=
 =?us-ascii?Q?7DET8uPEKLMdVLyaESsjVX0GLncEypB7/UU4w/JjjnyiiTjFwsHGQS/U1ptq?=
 =?us-ascii?Q?pB+wzmQ2H+l9uGsgX0W9ppFLrZvTbvL7BLD8bzcq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1182d4bf-3052-4124-8713-08ddc399a718
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:18:05.9167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A2Rb+6Ye7UT+ICjl+tZmMM3pmRspetgs4N4ls5UCLXXV8tTH+RkD5ryhRvP2fnhpUnuradPfocoL6CrPWLG39A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5428

Use max_t() to reduce the code and improve its readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
v1->v2:
- Changed max() to max_t() with typeof() as
  suggested by Jeff.
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 286378770e9e..3498743d5ec0 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4783,10 +4783,9 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 		wiphy->iface_combinations = &mwifiex_iface_comb_ap_sta;
 	wiphy->n_iface_combinations = 1;
 
-	if (adapter->max_sta_conn > adapter->max_p2p_conn)
-		wiphy->max_ap_assoc_sta = adapter->max_sta_conn;
-	else
-		wiphy->max_ap_assoc_sta = adapter->max_p2p_conn;
+	wiphy->max_ap_assoc_sta = max_t(typeof(wiphy->max_ap_assoc_sta),
+					adapter->max_sta_conn,
+					adapter->max_p2p_conn);
 
 	/* Initialize cipher suits */
 	wiphy->cipher_suites = mwifiex_cipher_suites;
-- 
2.34.1


