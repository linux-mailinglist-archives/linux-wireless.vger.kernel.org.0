Return-Path: <linux-wireless+bounces-26396-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4761B27611
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 04:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B141CC2355
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 02:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA7F29CB24;
	Fri, 15 Aug 2025 02:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ofTl10Ng"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012018.outbound.protection.outlook.com [40.107.75.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A6E29C342;
	Fri, 15 Aug 2025 02:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225076; cv=fail; b=cb0bpaad9I0wfU0UBBD5cNEb/7Y+P61wTjzM6BaxqtfeyG7hGJ7uXudQM6271eLKTzxriODyxFKsUZqIS6VLVkgAXZTV949gXvwMq2iYkNhaZHmCCL8lRgQ0yB2syVO3uEFFbDeB3VLI+QYo+SeRr18OwYBdXKW7i2fO0QwzHsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225076; c=relaxed/simple;
	bh=fZVNWMh3C+ZhSazkwPqYb3qD0D1ZxgX+3zHVMLFLvd0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RlNDFc+mSd69opB9cIE6NcTd33UzmQt12gLlrnWADiB6zbtiTahnf4kYV2EiA0c4A6JtDqe3J9ELsI94B9Z3ZzJ+gD/dAaiVCenDWKLtIH7DTFQeN7pgUDVXMGiFaZdK4J+muw123mwJR+5A+ToFb1h7Owp4RZ4AI7jQARZBAp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ofTl10Ng; arc=fail smtp.client-ip=40.107.75.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rej6HQScznXabArctyzcogpMT3B8Ax5DPqH0XMQpSGAzv3EgBWjzZxO+qgr01b87hG61pjJho3+cXtRUBwYmKutaTBHAJPjFEfPM/FAXAzmIuVDPjMBveTpxM6853PFfb+CpuA1bdLLeKvnU4SljkZ6zP8YkUVeq7DEKQEGDmiZyjwYGj5u39rg4OfxKGHRJ/VJMdxY7OZMioFudC30C6pVO5GQbRFOsOioPQ9SfTCRhb2qZmoCyp1f8mbd0Ogz7H1AvVKl8gfnZCC/vdzHMXqmaD4JYiF9brnEMD9rEtTc68jY4iNn5KFoCRkHpm4Ma9vfhHesi2w+VSVac8M7SQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGM3rhr7AJmseGDV1t09ZrVuai9dLVlMqk/AncBKF18=;
 b=t16uYEq15GVgF3afyK5ceTLHdMeA0KjiANJtemRpbD7+cM2Y2qqL9FOJcSrA5q3et6zl7OmCRqnEHiRKqPFTrYokKUfLNY2nkNxyCZZbk5aCIxvaQkYrHn7O5rFAXeWRK7ZyL/WD+QabptxMQd8VE30WnIbHD4SIH5E91VXVVjwrukDZKWrtkaQ3KR9CKBpF6sPAd3jaf5EkRgyj7V/4dcO0xIDJT3hDEPNb9Et9raGVJJ3q1m1QBicfyD58ctbSNfHKZU0zYqdQsGBTKRr/gZu43ZK1+C36Q6ngElqylWA+nGuM93BdNbJ+i5pqINpBZIoC7rp6AQlJ6XfgYvYc5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGM3rhr7AJmseGDV1t09ZrVuai9dLVlMqk/AncBKF18=;
 b=ofTl10Ng6pURyKZrbGX1TsiIwySVE27FnrQ4EkRfh4+h6D1Up1PDQaSKOa2bic89KOwpa/Vz4Zsc81V3HrbrgiPoQuudA01YQaCheccIjKG0t43MurVn3cXeayUMEw2uKremSDfxZizjECsbss+7OgSrlGa86y1Xefv4cmSHKNuzgiofRwliwah/NNJvR3ndBn94STwMNSk9Clzn8DKGMXnj5DRbKJB3a4LGDSg0C1XOV3aPl66ALF4a1NuzS+AyT8vTQE9YC8VtmoqXPSNqP6jAt/WgRa92IOoftDnta3q9/7paO4vteint/ASL91AMZVNiDfiaVNgzaeDBvIBppQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB6481.apcprd06.prod.outlook.com (2603:1096:101:173::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 02:31:06 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 02:31:06 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Rameshkumar Sundaram <quic_ramess@quicinc.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Bert Karwatzki <spasswolf@web.de>,
	Jeff Chen <jeff.chen_1@nxp.con>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"John W. Linville" <linville@tuxdriver.com>,
	Cathy Luo <cluo@marvell.com>,
	Xinmin Hu <huxm@marvell.com>,
	Avinash Patil <patila@marvell.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v3] wifi: mwifiex: Initialize the chan_stats array to zero
Date: Fri, 15 Aug 2025 10:30:50 +0800
Message-Id: <20250815023055.477719-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0201.apcprd06.prod.outlook.com (2603:1096:4:1::33)
 To SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc0b8fa-ebec-4d08-ae4a-08dddba3c978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dbfkS/4HXbfgZg3D84P13Stf8VXv4uonJ4fG0LK2uuWhOHgDpNzWmdj8S06v?=
 =?us-ascii?Q?4TM8xUZtESCzezDn31UPaj/9jIrKNz+Bw+zQoQAfysEdFoVp+wyjpFDYsySS?=
 =?us-ascii?Q?qMAQAD/uFsRPjC3/KeRZPSGKdNj2xoF5us3/ksZR8a8QCJ+7N+GozC+ocKD1?=
 =?us-ascii?Q?TrZHYfjni/RBJX0CKwErO9hXFCjcumDh84t0aJKNnlG0pXCHuRRp4hq6cX9b?=
 =?us-ascii?Q?c08zPr39zZqJxgy1ZJINyG+8QTWNofHky2V2KI3ySSi9cV8Tmxb532aySPW8?=
 =?us-ascii?Q?O0sFeKnc+7/N6/qeCY1BsF9ff/fXtCtA4NZTgBJPEaRP9cwVWmycPM8Cbrvx?=
 =?us-ascii?Q?GsAAd5FVSa8GW1AIsate0DjdmrVoxZzE5vddlhEOvQPM+6vPJWn2kFBs5YyU?=
 =?us-ascii?Q?8RzxnoyCDf1ohss3gdJwY4pZ7+noPblTEOkqDJmiBvjX7nxdC+3ZRr4H7dtp?=
 =?us-ascii?Q?RmGpbFHP3lIRVLz+EbJa3hw+zWeQC0m0teDB7X+CjHPUO1u/qi2+rBLZywxJ?=
 =?us-ascii?Q?42gd2p221mTXecXD/q6gyqrT2XqFqpYzmzXDnxvv55Guv/kA7aGtAGJMMQNy?=
 =?us-ascii?Q?ww8nc8LJVTk9FVnrY1Jza6rcAltZJjdmZ54kAiAJNNdU7K9p5Q+t7oPSJj9v?=
 =?us-ascii?Q?qUAC59y08nTOsdvLlnzn1FVfvqe8RP94jenEyB5QQ8HlcWYyUCu7a3RTsRLq?=
 =?us-ascii?Q?vgsbVdo6P8pGjbDwgnjBW45Smd1jHiL9VQVQMCipGbwF+PxnjY5yue04PETp?=
 =?us-ascii?Q?DaLlfyr0umXgDOunkQhj55hDJ9D0Lo8818vCAoFBO4/91pDo+jGzsYggDuV6?=
 =?us-ascii?Q?stLoKFl+WwKHw7MlF/SX211A51q04+zPipWcWLGiVYveTeEkeDFsGAOZKK+m?=
 =?us-ascii?Q?R7VYwa7PuJxu4oxKgcDTkgXdK6NJjVlyF2deJwFiqa84NaSzMycgey/tXYxE?=
 =?us-ascii?Q?qTVkjLeh88YyYnV5LyWlndbsQRpMSdRn0vtVHGtXcPYxbe7bxAHhul6ukb0D?=
 =?us-ascii?Q?Zsqm5zo+nSFMs2wh+IX1WDWlC6dt4AGHdz4dArD3gnRDtVHWbNm+1QbfEcve?=
 =?us-ascii?Q?NUL9O4Jo9npmE0LBBGwDmHz7Hsf9hh7mVql3yporFqf7/NePWMBLzlYlsgSr?=
 =?us-ascii?Q?GoyGaMm7zZRWKfbS/dnYIiJ038w9fvWhnVsZNGAY5iU9lVeNsJ7p7I0h/CYO?=
 =?us-ascii?Q?vOF1kPdUI/lMB21hQEnE0hxNInzINL5qGRwruUYDNI07yNNdpY5hyJ5FcFz1?=
 =?us-ascii?Q?y9ycWnKChyjXkikIq7n66AAiyHi1VSQ39vWpreV4Yp48o9dhcnnVUTKPcQp7?=
 =?us-ascii?Q?Oe4HretCrVla5cWZCrFYhFJPYnE5b3iUUfd4UmUsgkb6b/ECvnTMQDV6eeMC?=
 =?us-ascii?Q?/9HAiLrjKL11NN6qDowIAQ+RGZh4ZPjD0n48DwfF3cHbzLAAY8Mi4HWkzGRT?=
 =?us-ascii?Q?FNAwUCcjMRrEoIIdw94G5SuNekQ8OKauiZpMRYMl+yqN+MGhlfxLxNitFmZX?=
 =?us-ascii?Q?WFxr99t/hL3CexQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8lWz6tszmbboo1bWQCuDdvboZaj+1SGpMmLPGPRNJYYPsEF+IUB4wHIX2PFQ?=
 =?us-ascii?Q?bcs8ghUVg8nrzldcRi5WXl5eOlScN8yUkfkvMXed2AvAYBYzJl0ap8HOeLXE?=
 =?us-ascii?Q?5Y9y7R4NQMUyHkWYhI6Zqqh1CPnsPKlE1EK4KoV853SQgEuZaKsxGWjUMeeC?=
 =?us-ascii?Q?51HSB0q00b90AfO1tw/1jHFRSumZ63Rzh8AykyQ8s8k5iy73wUY4gKKdM0DF?=
 =?us-ascii?Q?cl+q52/zMy162xzXhKB4rXIOOHpSensjgXoGF96U4YTP3Y9AeiKdxit7xoOa?=
 =?us-ascii?Q?LC8CFiEA2t/6iHREdOv7DdE+5Tkrf1JObMKkd28XHPQOb7X9YBKCzBgKlA3P?=
 =?us-ascii?Q?2rhDfEandzl8fdkODnoCKKHhSkv/0HqjOJOIEsZsVIpA13LY7jUkAuU11asE?=
 =?us-ascii?Q?/ucfLa/MNQvvoi9kRDw9yBzXxAgc/82mN1ag90iplj4ap9Aye3tdZx8MkvAL?=
 =?us-ascii?Q?5QY6whslg9YB5qhwLx/f2QcIwbLFSn4KJO7OnhErv7p4At9isB3WljQSfkrN?=
 =?us-ascii?Q?ZeUsOBQzbTMDOvOF57WpbU95OZI3zE87CIAZ8J80rhOYhHSVEKFZpqGK9NZ6?=
 =?us-ascii?Q?hWqDfC7tJxZ1148x2ii9C1LfdJqBl9hsEMYO4uYJNuyOIUbkKpDpg8Gc2FnI?=
 =?us-ascii?Q?C6O0GUnxR+4U9t3a+urRpyRb7aM5QiEEuWWpY6pkInvOqMqR7uPEnnFUcCBj?=
 =?us-ascii?Q?bHNFGMCYzulthMnI9uSaHSs+v7138jx6qSsuRScAeuwwrPTry1TBT5VQMF0J?=
 =?us-ascii?Q?OqktCFQ7fv73EYSd5sEWBSpMHvvmxkCr6wXdDKvvHDRpUUgrTigrRKxKVd8l?=
 =?us-ascii?Q?iw5r7+kjChlvee+lrfF6zCdbD1anTrtxaYp/RZAilbE9NVbuee2OolwtUFth?=
 =?us-ascii?Q?EaSxMJ/eAAzjI/VaIed4ICWBi/RYcBjAfsPRh8mqxuIUXAgmHWSnAVKOK+US?=
 =?us-ascii?Q?zyOkVSxJKn3getmWz8z3VuxJ+QrWoCSJtNKIcswm8yLqcgeZtdRDNBXSTAyG?=
 =?us-ascii?Q?Ht3huDXYy3NLwX7riFBX2QK7MjQAKB12ThhhslLNK7JxqGHeI7WzFHf3nnpk?=
 =?us-ascii?Q?EfOjYipiH0L84zDNCJT6YATCObzBqKz+MXTEIKqatDnpe0411A+PN+PkCj+J?=
 =?us-ascii?Q?UJCFlz19Tc2OlV/9KtEB8Hz2vTJ2B86sjbA7kmi5ekUY2IThmaFqIrlH3oOv?=
 =?us-ascii?Q?Pis3HJxPOzLj1i9Vd9I7FNuponhj9Va3NwShqQNh2d0svMv4b8D1GP8mi1Zy?=
 =?us-ascii?Q?23Uv7wnu5sVX1286JCInNSRs4PGJRFL6+pigux/1LLhxyohaGlWvOR3U68H/?=
 =?us-ascii?Q?J7zAl6bRkdR08A6Q1NmNVcSTUIrxLaMXmVkhBjyQ+zwSYjzkQ7PEfjD+xrvY?=
 =?us-ascii?Q?mCy+0a6EEUr6qAAlheyie5jih/OXr0Dwz1PaSdsnfiJ35bUktcHhLm5t1+wL?=
 =?us-ascii?Q?S7IsOq3NP48SqeBTuRbSM7pbq+mXrwzPuGEsDjS5F0OTi1bhNixjqpN4kFoS?=
 =?us-ascii?Q?cLFlBqJXGU98ai4/1M2MIr4BS9/sGwcoaxDDnmU0j2aKJ2f2RTaVRWblFQjm?=
 =?us-ascii?Q?duO+rmnf02g3ryLyfuglhToJQPEO+DLQIHzi7YDi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc0b8fa-ebec-4d08-ae4a-08dddba3c978
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:31:06.4437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KL+qyLIPmKNkhPspWQOU4FDit/F3oa4D6qXKM+bJiXN1+h9j4tGm5ocSsJS6U1Ubis0IEcfyCbAEpaUmswsArw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6481

The adapter->chan_stats[] array is initialized in
mwifiex_init_channel_scan_gap() with vmalloc(), which doesn't zero out
memory.  The array is filled in mwifiex_update_chan_statistics()
and then the user can query the data in mwifiex_cfg80211_dump_survey().

There are two potential issues here.  What if the user calls
mwifiex_cfg80211_dump_survey() before the data has been filled in.
Also the mwifiex_update_chan_statistics() function doesn't necessarily
initialize the whole array.  Since the array was not initialized at
the start that could result in an information leak.

Also this array is pretty small.  It's a maximum of 900 bytes so it's
more appropriate to use kcalloc() instead vmalloc().

Cc: stable@vger.kernel.org
Fixes: bf35443314ac ("mwifiex: channel statistics support for mwifiex")
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
v2: Change vmalloc_array/vfree to kcalloc/kfree.
v3: Improved commit message.
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


