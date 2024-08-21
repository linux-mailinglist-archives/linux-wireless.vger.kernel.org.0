Return-Path: <linux-wireless+bounces-11726-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FBC959606
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 09:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02356288A03
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 07:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E905A1B81CB;
	Wed, 21 Aug 2024 07:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="JksQw358"
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2064.outbound.protection.outlook.com [40.107.255.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3DE1B81D9;
	Wed, 21 Aug 2024 07:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724225074; cv=fail; b=ctL2ZIitfuzOJ0F8kpECickIOUHnKVrWY7+IMlmKDqXHfajvAEkrTalDpn7eYQ0UwSpPT/r5xteWs9RB4NqyhlSsUFBS1u4wJ6WICt/DaOF8gxZ7NggrckzfhMEY6Lvdvbg9wCRYgsdER2Grnfg3nQKt1+Tgh+aKGpQoIWyXtPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724225074; c=relaxed/simple;
	bh=9v+hYoYRVS4xyp28qhtKyJLoFj8+LpEJvXOJEsXj3N8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=K9zv2GCUYbowRyFmHbRcEjhgND83APM5opr4lq3uZc1IoiBCDgMbCfxbYSSx5YrC8yxEcJV8r+ltfV+nDj3MWBfEQwz8fhUPENOuOxxqT71QcccaqLJ2FPr1lJeGwa5PKTN5odAZotdJ2hzPQ4R+W6r7Yv/IH8BOSJs2qBh1hvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=JksQw358; arc=fail smtp.client-ip=40.107.255.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqQlqyp2xi6f609ghVhbW64mR8qp7kez3v0MF/tVB3MENbAbon410tNOPptAptqaR/cRFeRwqZpfnfaOfXhfrpKYqvW2YQ0zL7nUYU+xH6gVdr8oVXYMcx8OZAM/lXWxVKJLC1U/AoZ9lZzRYSVbgvFnxelPXmoL47DM289599Ny7m9ORYHiQmjaA6KGTTeWVT9/EolM7WUnoesO3wCXx7cyvqaaqnVGzVBOhye+BQDGptXqyV4K4tdET5f6Twk+fxMNBWpLDMQI0w1fhGLy6kiCypch/5VxTjypy2C8tc4ACDcwVk87lZH+r52XPO6WevTlqwmH33wq3u3FjURsdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulqjzYFlLH+7rVvl/XnVpLsrxmoiCeu38ldhvEAWznk=;
 b=QA6PTThyh/3efykJ+5aonPF+T/1L4d7JraXiIbNfHbQ85C45/OUME2CZSoIhi+K/XIiWTCTOuONnyvwMVvCK6hnlwmdPzfleUflMNMtMEwkFXD0Z9bajeasuRn5djQFY0PcbZuDrT2r4dXEBfVSVdIJEv9/qlgCZBMLET/Iou+oHE6O8dOv0uajyxK33m3GMxQ5rGHBCvdU33gxsct27YEwyc9KSpqNHKhxLBcQGNtbTjAKSE6Dn5XHbrKjiv7E5KvokFDY48wQZ0s41sZ3OYHK0S7wiVfsvvkhqQEiExalbN6PnxQnwbuq0CjDRP0k+BJIVVd7JAuLEbDPegwN1ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulqjzYFlLH+7rVvl/XnVpLsrxmoiCeu38ldhvEAWznk=;
 b=JksQw358SkvaIB0WW6ACQ4eKBo5PUIz2wVNPv26HYxetiL16Upk7aeVrarFNY6wp/y5ogqkE3JOkN8qCERjkuFEMMptvj12wwCKvOK3OJjkzwVtfyFOo4JJ76P3+ZN2p7wAP7ZB3nUab1QJFoMfcCGYKmcxik8Y2cLeXjRL3+Hr/+s0goqbsH0nu9NCJXQBxhq0aR0D7WExJnDegs8fsXq28jT7Q9hNjzsqiD43UBzDA0v3pi1Z80jfKdjqmworwJ6RvciQE+eNSqHKlYDTrsgC1ivmkqugHdpUaq1PS+uTrkzZuo5bqAJ9ZRdKL6I71e6H0istRgJ5j26fXQcTPmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by TY0PR06MB6883.apcprd06.prod.outlook.com (2603:1096:405:15::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 07:24:30 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%6]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 07:24:30 +0000
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
Subject: [PATCH v1] net: wireless: Use kmemdup_array instead of kmemdup for multiple allocation
Date: Wed, 21 Aug 2024 15:24:10 +0800
Message-Id: <20240821072410.4065645-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0043.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::31) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|TY0PR06MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ae4906-7fd1-4b0d-7909-08dcc1b24bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bYuprcrFM5pTWmbdQkpRpKPBWP9ezhzv2e1Q18UWQde8LTwG9/B1xm1/VQqt?=
 =?us-ascii?Q?RVK3df3LPuuBN7oWJ2Ur+aWfRuf8meKbEnoYB2QaAyl1MxW8icZTSXKILZLQ?=
 =?us-ascii?Q?mvrnOv4q2ZyVmTawBfCyRaMbzaASpsy3AZF/XQLDAHH/6tpwG9W96a8oy7YT?=
 =?us-ascii?Q?AmpTr/aRs6qD2NIyObdNzvIao3OjQxNnK4hUefFdcYbJXgxBF3lks8epkZ3W?=
 =?us-ascii?Q?HUFrQUcFO5l+MuANnGzPcIu2vnsb4vElmT0FhaNj7RmJtL5ZfGhL3EryO+io?=
 =?us-ascii?Q?hZlQykPZIJREZCJ5MRPLlwML9csyDgvPRiLFNASlqIr1RuXuDkLGh63rVYdb?=
 =?us-ascii?Q?WI2OMBMr5uGvAfIvJjV6Ru2O6d+StOl6a7sSUlOeNidQ/gUBjE29xyyIZR3o?=
 =?us-ascii?Q?INiSV9Ifu8b6AMd7/z2ezPPtEjpbn+54IxY+QWq29FcvR4k+suFL7RPj/OGN?=
 =?us-ascii?Q?obnZF/Px7kBxAJkjl5i/Lfu6c9k5D9s1IO+Jgi3c2XfS8PXSxbesywt0Eji4?=
 =?us-ascii?Q?KlMK9aUc4+1Yt1et48HNXAPcsiE1FLlvJVUnyOYCdY61BCLwhkq6zCvB55rO?=
 =?us-ascii?Q?sai7NTYozuqvq7h7+cRJkW1D8YOh9rOTjGQQMF2D6QF2L7d36FYTwIEqWzHn?=
 =?us-ascii?Q?fe5ZPCSVNGPqmApkrOshU3lcpT0mb/GTJ61wk4wzM9Hn1lX6SgJr9em7FWES?=
 =?us-ascii?Q?8pJsDEcJ2Hm4TOke435/L3pTEENBp6mOXVzyBaXkHhvsiiSQqhbqeCKeTX3+?=
 =?us-ascii?Q?q9x9H7oEMn5CGv1P+b3bbfYbRaJDwOPYElugbt2aVLX8J6Og2b5YP1rf1dMG?=
 =?us-ascii?Q?pCJ+uB/RKvEWrtHihIFruwF7rNk6qVUPaUJv5yk3DBag2A4Bav9OkJVXibfM?=
 =?us-ascii?Q?2qDRtltxthZioubsaHl/AlqdILRRMuP+emF+1bSee2aGsI7PwqtXOQEOjJ5A?=
 =?us-ascii?Q?2cXZWGTHBU90NOShg8qE8tRj6Y3q1cL3mJE6yQuisPAmxEPuWOdG3jHCTLDF?=
 =?us-ascii?Q?WJHEn5koZ5tGXqFtzmffdlcB5VxgZw23ggfFvhCSXkwr5+s6MTJy2UYEQHzg?=
 =?us-ascii?Q?k3aV8zLl6jiQrXq83DD+u4BvL0ov7csNY7g9HS2C6HK7QVnktKDeJ9yZgSRg?=
 =?us-ascii?Q?dQFryZgitVDH0jvy30NH9PFzQq/M90f7YWTzllzVflhTeULmLS5FH3eI+nv5?=
 =?us-ascii?Q?AhGEeIjH/dnH/DiG6JpXE0Ymd6hW9xyKTeYdQ3fh8tD7wqS4Y4nh2B9fKGEG?=
 =?us-ascii?Q?HnILkHJ5PSCBMlg0E45LwWCK5HoJ9GbkI8VFQjcdiXoj7x/CgjaXls9VMXCu?=
 =?us-ascii?Q?rj1DGzH54Wu8/PSQoeDsa1PM2MOyPW4nB/+lB3N0LK9gpPnipK3ydwfinoLQ?=
 =?us-ascii?Q?vLKx9hjLWjCpFE86KlgGO24XbKjn574C+/6006rBqqFriO8I8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DWaVF7QNLyTMWw3zrHWgkhVG6zlSEa+on2ZPh0ahD4VvbWLvpNHLUu8zTw5K?=
 =?us-ascii?Q?kphzM0yMbbMb3zXhy+jmtwG8QX77oMAHD12BqN+K3FtGOw+AnTp6ofRUNQb6?=
 =?us-ascii?Q?aHB6EJKkopC0Yl5blR+X/5MRvFrP6z0pYsoIINHH62XSoGyfrD1LvtD/ZMar?=
 =?us-ascii?Q?0RlAiFUc1vMpCCFjgRAVOtLhNdplcA6L0mHgPjcsaqxxiEcX5NQwGvPLAcpU?=
 =?us-ascii?Q?16cmZI0jA7dK24cCInpr0Z9lIok5D0VQi+Y36veEd8hGINuAyPVALXEcGwUX?=
 =?us-ascii?Q?rvT0aaGwfxG+OdY0HtysKOmPiWQWguGRu3kDZCLTyjsjJ82t02jVPbt8nMPc?=
 =?us-ascii?Q?Qi/cUK0Raz/C1G2xEhmQQlxoxC2ZzwtrODD4eyvM5qxg6BUJKXaabXgGVRTm?=
 =?us-ascii?Q?MMFNS7SpdVQw92QXfjmpevbRE/LCLJeRDrQUdD2sWVNrqOA5hpsMklaTM/uK?=
 =?us-ascii?Q?QWFMG0l4hy7GwhYG3JyCPc9Hbz9+4AAVrf+MFlqKT1NxQX6bvNEAaHuIaqlq?=
 =?us-ascii?Q?59yBOZTW7XOax1yWuFw7H/XFrGrNe0adeh7xNvPuF+RxedQVP4Kn6jRo4yhe?=
 =?us-ascii?Q?hcFaCBa96txxIfnaNuziPUGZFoHVY67Ez3UiTPf1IQUlM50eC0tP7svOswjT?=
 =?us-ascii?Q?UkXsYnG42X32ZcGy4Ym55Vijjob6zL4gJPWiM+zkuKmh7XMKXBhrQMpf925s?=
 =?us-ascii?Q?d/daxXNqa+S2dBBLb5t1gYsbPQ0zJ5VD7u16UMJVYH8BCKrYL8eazmVcMcVB?=
 =?us-ascii?Q?TjzDVabcm0BB31BRnjFcj1THXXp32BMMYR+E0eB0KHAK2QOmIsbZVEgz/5mc?=
 =?us-ascii?Q?Mh5cHG3uGN9cPb1lz5uiUPxWZ6XgLE+nAy9SEk2p8cCy6DJSAEZYi3wRJQNw?=
 =?us-ascii?Q?orWfQhOj4FIzxXmHy6ysresr7U54N1BU1xEBYZEBfd0Ol0uxljubUUMcI3g7?=
 =?us-ascii?Q?kB1xuTZ0kLn98IYSl/1yAlNlNxAgZ7WdH3cSIWIYVwZ1UXXxjz9Sn4iFg/W3?=
 =?us-ascii?Q?NHj5WPxKXPJXZ4h74O3730JIDbhoP1YvIx9a4RfYpFe37YpueozNnTUvsnVU?=
 =?us-ascii?Q?R1oJLMOa3DOKyJ/iQEksyuXovtTmu5WSpTGTlzAA81eG7GTv2N4SwmJzAKJB?=
 =?us-ascii?Q?t0iXWD9pdKzvNqj4H8fWXiheA9TP24Ryxx5eUA58JZAg4FUaQ/d/bA+UCOga?=
 =?us-ascii?Q?HZUdu+IE8gXWzPJ1VU7BMNrdV6ubHCkelq6OyCGgsYaOMJeNSJKg3fTQagVd?=
 =?us-ascii?Q?AaV4WW0EThlchDayKg02Co6UU8V/jjzrBIjh0FT5L271Rxb/wCQfHkGqhY+h?=
 =?us-ascii?Q?WlYy81hz3fVtA0R3WHBOY4Qjj8V24dbqeX+DXr30WyHgUgscSMnzrvKq/MbE?=
 =?us-ascii?Q?6c2d45cpMDd0VikNMdQ++CTFymDjtImBDFOBqhNQY6bkMLWREINDmltFOLJ+?=
 =?us-ascii?Q?eIcqQG6uCMn0hgc92UfTcr8mI7VnXMyYz85wgZpHgB+y5sXpzvquJXzjVw43?=
 =?us-ascii?Q?GZ/C5ZiHH8N+KcSmP8xKKOzoO1fbdn7j66ypa63kja8TeY/nuUKu4hjeHSGJ?=
 =?us-ascii?Q?iwID16YokfprVSo1HEI6rtz1gcRCjcTG2rlhTADs?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ae4906-7fd1-4b0d-7909-08dcc1b24bfd
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 07:24:30.4921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emiBDJubAaaCCLwWs5UNm2bqIbpFd0zJfElGCXOWcs7/Mlz0z7/p2oEwWsuHu81QMKwVqfUHsb6eyiVKJYW/zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB6883

Let the kememdup_array() take care about multiplication and possible
overflows.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 net/wireless/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 9a7c3adc8a3b..6cf19dda5d2a 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2435,8 +2435,8 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 		if (params->num_different_channels > c->num_different_channels)
 			continue;
 
-		limits = kmemdup(c->limits, sizeof(limits[0]) * c->n_limits,
-				 GFP_KERNEL);
+		limits = kmemdup_array(c->limits, c->n_limits, sizeof(limits[0]),
+				       GFP_KERNEL);
 		if (!limits)
 			return -ENOMEM;
 
-- 
2.34.1


