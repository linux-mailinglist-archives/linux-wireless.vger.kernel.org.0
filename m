Return-Path: <linux-wireless+bounces-25015-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A952AFDD73
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 04:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0551C27B84
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 02:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6A91C84AE;
	Wed,  9 Jul 2025 02:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Cvj8LNXH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from outbound.mail.protection.outlook.com (mail-koreacentralazon11013020.outbound.protection.outlook.com [40.107.44.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770A81A2643;
	Wed,  9 Jul 2025 02:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752027872; cv=fail; b=EJWDOS8C0LdCp5166ITuLB6GUOGKcgrWRzhewygXELImQS7j5hPI9/ZwL2cc3NhCjYijbbpDtd6QaSf5TLv+Eb1c7xtToDg2rOFuF4XfGVMbYP/VtXShoC5LPlnOac1iy90n2q9wpAQtGPYHNz4N2dwxvapr0uRdjQ1fC1ekjMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752027872; c=relaxed/simple;
	bh=9smOcFZvTwdY2IIoUEgyNRm6i9lAsS9zYQrFm26pSHo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nZ4sZlCMKxrOGJ6Ava+Xk9E+bUKPvpmJFpkIqWiiSuOLxoaIEIvPDzeZ1kU4nh6s5f7LDB+TvxUjUE02UJk4A9s+pHG2f2Ttg7xPZmHAcx7y7rKm1wsGC8sOfNlL9bMoqT3RuO9LnHHKuvsQNDhzg2zh4luJoZOjVzoqZ8QS/zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Cvj8LNXH; arc=fail smtp.client-ip=40.107.44.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3jla1C5Z4RuAeJ+hzimcjBS56c7/rqURJbQ6sJKwsLv5k0uieh00ct7R6WPJFlgetrZxUdahBJqGSwVv+47opR4WXvrh1XVhLq6Ks9Og/jGQ3cjl+ViRCSyv502Qfb7xD2o28mzxWTdNrGLq6ZfMmaG4TKQtEckNzBlJjLlGjg8pio4e2ETimhMQo0gkZf4NeX+wvzbcTV4VKb0QqkLOQgUjgFo+Q2yu4PXqgNcQg3HTMdUQ389pRjD1V1rnoISLnWShepARQ8EG4Q2O/NbxryyLhdji/cN0T/7RufMG4Ru5/kz5lMWOXcxAF79xnFYFo81L7ASs5dKWFzV+06tGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XPSMdpITsu899xaXlZDUszvu0DzG7yMtt0zE7tIjGE=;
 b=wVVSzbVi0pJWN8znfwXLvNcpk+A/SDRRkMqkH5U5StzwQL9DN+QotldecdonK2k4LYV6M5VHztEH7ucX6uPESCye0Y99tLRpiCYPcaRhZts01BE8iNIvo3i+gzDxIGABdqtLRPh2nQR38FZ3DY7x6Ld3xHtFW+82wSL0PYMwfxx/B0wiCdeSTFanm74NYqI4ksVDphmrY83KQbl4QT8V4aGs1jYKFK5hEu/LRVQgpt8uHuyhnK4wC1Ynx/H0Sth5U05QCOXSferTFp3H9aPSkZpLNGyD+v5xb0nS6Ac4gy0QDW2AAXMQTiTczAx83WbWciYIo+0P/zG1rx3SRRCxzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XPSMdpITsu899xaXlZDUszvu0DzG7yMtt0zE7tIjGE=;
 b=Cvj8LNXHhrfV4zhNmydbNxcdasHplFLIOoqyoj8UBRqx6GCXJWyxgkZ7rzqQrUONa+NIAZAGfsH9BAwGUiVMa2WtE6IaB3x067Fj9GBjTt6KpJYh+QSha+DBcgIcIytBq7XkCjnU/WrMp3Yl0VwQ+KYNvvya5VGr1zL1Y9Dvt4imJPc77jwuxUmwh4WRxgUVIBWAAbIkmozJ+g5ST57VaygsjwC4/Rp+uxbCLP3l7ZyyAtFXzXLgMlYkvExiy2oVdyVDA78BxAeqMbwqWeqmSxSSmP9J/0BoeN5elNoIC9PPjNXH9EKKHz7Btn3DEWgXivcj/sdX0SuvjSXLg8gdog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY2PPF4597475D5.apcprd06.prod.outlook.com (2603:1096:408::78b) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.26; Wed, 9 Jul 2025 02:24:26 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Wed, 9 Jul 2025
 02:24:26 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-wireless@vger.kernel.org (open list:REALTEK WIRELESS DRIVER (rtlwifi family)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 12/12] wifi: rtlwifi: Use min()/max() to improve code
Date: Wed,  9 Jul 2025 10:21:40 +0800
Message-Id: <20250709022210.304030-13-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709022210.304030-1-rongqianfeng@vivo.com>
References: <20250709022210.304030-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY2PPF4597475D5:EE_
X-MS-Office365-Filtering-Correlation-Id: 00367fdd-947f-42e5-b45b-08ddbe8fb978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ncBAkT7NGeUyAikiNOEWyH2PDmBX140+VuZvDdDl+zDAt9QHnXs0JysFpb3Q?=
 =?us-ascii?Q?1nCAmqYSNT1yjzGBBEjBgRx8IXuHnF+E704mDxpfv3X/ocOZTY5bFoRia+6p?=
 =?us-ascii?Q?9XUeaRy73ibt2mrYstX8JEkz1IXTGxdNAHXgsVs1tFCuCKL4uov2OX0P2lWE?=
 =?us-ascii?Q?AlOnblwliRL7rvQmle2f05flem83NtG+irsvkpADa7Ph34/gr8nZQaOoW/um?=
 =?us-ascii?Q?d+wHzd/i4kVAIZG4HkHL9lxz2rcJjxJChlcDC8zYClEVknyJiHWp3kVvh2Pj?=
 =?us-ascii?Q?ypFti+CZnbpQSZ9KUJ9ohhZcmD998EPTJtG6yX6eOokU5e1da44MzzzRuUAc?=
 =?us-ascii?Q?xAjqLrciR+0MLjEK+WfbYSa3QBkSj0e1QrsxuEWWV0GEHGfB+lYLZwg4N4GO?=
 =?us-ascii?Q?86L++8XtDsaFviAzGSlShZNkosVZt+QcXzsdUaI5yfKz9VZBbJ32MgoUOYQh?=
 =?us-ascii?Q?194F+ODyJ87QooTsPtG1fzPxawADfDdOsTVVDEqZpxA3X4L9ZMuEsisrjyQm?=
 =?us-ascii?Q?uuZIYM1xxnMJ9HYKIb/x7wPPyBR5im0VIIV50UAt3pS7ZigYAMm2ko22Ca40?=
 =?us-ascii?Q?qJwmWR6cAsWNoM1QsV+ZYa+1rMyp32OAo5n0tABwkDceNIu5YJ9ScbhsbJGX?=
 =?us-ascii?Q?M2nnxkMx7lrOTxGCEncGQAzOeBajy6WwHklfqzFKIF29TUnVs0i+cvIZr+GS?=
 =?us-ascii?Q?8QYU7A1zwrG/TfYjxfHgnjM7lF4vcPIXa4zjc7S4N/SrbdeILtk/Fn8h+i6d?=
 =?us-ascii?Q?B4+wNEVy1D/3ZFvdfZXawDzBPu/2fIRnmPVaWfUgKxbm3pR2meqnRRilFgQt?=
 =?us-ascii?Q?dQq2U8rssNuOcARdpEfDTrC3/s/7sSzPvSI1YVOPqcHqIuJvQpCcOId7E7UA?=
 =?us-ascii?Q?6KHWLVGjtmY5tBkQesQMXhjEa0jLTHx20rzyIUpyvcj9523Ygf7qJtOiERqA?=
 =?us-ascii?Q?oDRtLP08rfrfJwWnBqAWDL//ODEw5CGj9ZhmAa/qqFePfiSiS5DPS4WwWyP0?=
 =?us-ascii?Q?M5lTWQdZLuJpokmaSDHCpxokWOjd5/WpyyDHFzAxGEZYHeo5ARF5MPYmp44v?=
 =?us-ascii?Q?8OVEAWvLB3oqDLK3diJX7MLsv/6NbvRgwQIuyRiNa91DXKD/ENrdE+e6lS2k?=
 =?us-ascii?Q?l/FSWlJ3TleOCFejwq3ejfPjKa0mm6ZlLmOEtoqc5QCxjd2cguwDX0HX4uW1?=
 =?us-ascii?Q?r8gCj9VxI4cXawzptj96nZjBozuMifitQawyiwBGAahy4Yl93vus+hytQVzB?=
 =?us-ascii?Q?7TdisXBurY4A5PEgeRZm9EWYglpwPHXXYjnnYSPL35AkytinwVsqNQbDN8Oy?=
 =?us-ascii?Q?Is9GpaJ1Q4ozphthN+51zyBVrbR6PE2+aWjqzlLBq7KHJfyosgtHPxz42Wtm?=
 =?us-ascii?Q?alBNwT6DLv5TQGd0A6RE3BRb/iUBS78Q+z2DRi1T7Ncjx4163K5bjoiAhhTp?=
 =?us-ascii?Q?4u7k8bqXgzV/PL4kDL8fKyiRP8nwhhbLK/CODPpSPYrwf8d2VVZU2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/QKqyLA5QsQejFfLETWBsp4qcJPT95W60mouHbZpjZh1lFWvN73dibsM4YK7?=
 =?us-ascii?Q?Vvmo3qygNdg/WL773cx4wRu8JkkV6TBWmXqD+vGZMpvzeDmoTjmemYJy3xad?=
 =?us-ascii?Q?x4pDNyHHh6OLaPP4ZX2TR2uCr2Ixn60ZmedKFtR46LqSM37/rD7cv71c1OX8?=
 =?us-ascii?Q?/TvJCI/7tu9vQVvMLU7MVeAN9NAeL1C+p5RxVLgeIrmvrCJSxngJBSOl6bgz?=
 =?us-ascii?Q?95dEgrrOATzyxJkhCsLPVddCpvSQdqKDbV2sp/XbF7Ft3Un75njjM5LKyvVq?=
 =?us-ascii?Q?B/sJ3L6wdmcwsgIzQ5ag+bgeEgNia1Q0mdVO1WKl3d+5inLF+/M5ifd2IudR?=
 =?us-ascii?Q?nOXyWT/yZ+riclRbEI7pMO29Y85i7VXcBAaYkYEgVRX2CAkqwjQXbk61memB?=
 =?us-ascii?Q?2ovTu+RZYxP3d7Ae+zj/5q4aZW1pDKUtrdHa8By6D66Bts79j6NXzpF+lpW2?=
 =?us-ascii?Q?+nngK9k2Ba2Zn00zH8YdV/YunAwnunLQl5SCMUmMBV1Wqsoe+1oB2CiTIjcu?=
 =?us-ascii?Q?J6FFl6RBP8GbSHFFa8pgsyazvHkT1HjZzTGWcBcy5jNJLU1vL+GLW+MPG0kz?=
 =?us-ascii?Q?aWe3R9ok06VsP1ItTlqmLQDf99KNSXJo8RdTEVJgkRvUf5gBQXbM7BfXwAwV?=
 =?us-ascii?Q?MaBrnyxalj2dxzf4+a4gol8OYgWT5ljpYE9MzrdSfMTKNcKGkcnRhHoUQN6a?=
 =?us-ascii?Q?vsmVFn+mmO1/hT0GtYEkCPh8QmFQriNqit/g1XHLflhaHlFtFK2PR+28OOHy?=
 =?us-ascii?Q?KHSTvGjpNKK77OHaav1/KMr4Gzi3Qy8atXQanKg26WlSE7i+jgA1UR/6lLjz?=
 =?us-ascii?Q?fJh0y/NCpTw6ZGfgzteToOKemTahvIuInteHCIJGWC5TExmT+PoA8yf8HxBh?=
 =?us-ascii?Q?FRZDgYA4wAp8oy948FZi2S+CXSyJf/RllVd8xbeYqtrvsPXdTKD6UPcfHAu9?=
 =?us-ascii?Q?LjOCjkHS6MFRapQ5FJqu7dy+JKrguffRjd/YvJshhGXUA95HTsNbNPpB7W3I?=
 =?us-ascii?Q?XUi3RK42y5CpDiB0wdiJoFFVD5GjwAF+Iq35Av5WKJ1SKioEKlCVmecXXQG6?=
 =?us-ascii?Q?+QdrUz5UPWQRKs65sDOdSVdXjyZnmucVrYrZqw9i6CmqJqkWvYHs3W+14Xsn?=
 =?us-ascii?Q?BKrXWtZbxK66bsM5Z/ioKX9zgsWnLt4S4K95OC4VwI+2Doka31WK8h9Uxf5p?=
 =?us-ascii?Q?sw/y4rg1F7MPkplc/tN/563p9HvQqEQVZ9Uk9ocVUuKX7fwk/iti0/goIhvJ?=
 =?us-ascii?Q?X02ySj9g+n1XwJGhpyW+lwgVgQR2d9U+em5XAMHt81dBUxEqZ7bnzGD9yQxh?=
 =?us-ascii?Q?e6GoaUXU6wey60xHz04/zq14H58Yg8Ek5NPQX0Qs0ERRHtb88XvTl5+tdOLC?=
 =?us-ascii?Q?TtrCsY7nzZbis2E0JsdZaNzFAJwLUKdnsLmsTLwYyyEFypHymIh6qiDdVevk?=
 =?us-ascii?Q?hTuLZ+blev6bGdpClXCLFDvM3UTuXzkwgz7vTZqd5WyPcv/COnh8cpk2IAq3?=
 =?us-ascii?Q?VXKhojMJ1UqopOgSx3zg0wlHsu4XlawR9Ypm5KvgPRr+5cizMR9HbsrBtYZn?=
 =?us-ascii?Q?1L6TVndx1bP1Umsau3dN7spoa4DTbnusfQyyvXsg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00367fdd-947f-42e5-b45b-08ddbe8fb978
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 02:24:26.5399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9Qu1BeOnTkloArW0rrraLUm/qcJrtWbrcCWdvJZrCfIepgKXZtifxqWTzAV3odtSGngCZXfPpVIfXY1MLGh2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF4597475D5

Use min()/max() to reduce the code and improve its readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 .../wireless/realtek/rtlwifi/rtl8192ce/hw.c   | 19 +++----------------
 .../wireless/realtek/rtlwifi/rtl8192cu/hw.c   | 17 +++--------------
 .../wireless/realtek/rtlwifi/rtl8192ee/dm.c   |  5 +----
 .../wireless/realtek/rtlwifi/rtl8723ae/hw.c   | 15 +++------------
 .../wireless/realtek/rtlwifi/rtl8723be/dm.c   |  5 +----
 .../wireless/realtek/rtlwifi/rtl8821ae/dm.c   |  5 +----
 6 files changed, 12 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c
index 5ca6b49e73c7..dac6e271410d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c
@@ -1487,22 +1487,9 @@ _rtl92ce_read_txpower_info_from_hwpg(struct ieee80211_hw *hw,
 			rtlefuse->txpwrlevel_ht40_1s[rf_path][i] =
 			    rtlefuse->
 			    eeprom_chnlarea_txpwr_ht40_1s[rf_path][index];
-
-			if ((rtlefuse->
-			     eeprom_chnlarea_txpwr_ht40_1s[rf_path][index] -
-			     rtlefuse->
-			     eprom_chnl_txpwr_ht40_2sdf[rf_path][index])
-			    > 0) {
-				rtlefuse->txpwrlevel_ht40_2s[rf_path][i] =
-				    rtlefuse->
-				    eeprom_chnlarea_txpwr_ht40_1s[rf_path]
-				    [index] -
-				    rtlefuse->
-				    eprom_chnl_txpwr_ht40_2sdf[rf_path]
-				    [index];
-			} else {
-				rtlefuse->txpwrlevel_ht40_2s[rf_path][i] = 0;
-			}
+			rtlefuse->txpwrlevel_ht40_2s[rf_path][i] =
+				max(rtlefuse->eeprom_chnlarea_txpwr_ht40_1s[rf_path][index] -
+				    rtlefuse->eprom_chnl_txpwr_ht40_2sdf[rf_path][index], 0);
 		}
 
 		for (i = 0; i < 14; i++) {
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
index ec5d558609fe..95b1098426d5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
@@ -163,20 +163,9 @@ _rtl92cu_read_txpower_info_from_hwpg(struct ieee80211_hw *hw,
 			rtlefuse->txpwrlevel_ht40_1s[rf_path][i] =
 			    rtlefuse->
 			    eeprom_chnlarea_txpwr_ht40_1s[rf_path][index];
-			if ((rtlefuse->
-			     eeprom_chnlarea_txpwr_ht40_1s[rf_path][index] -
-			     rtlefuse->
-			     eprom_chnl_txpwr_ht40_2sdf[rf_path][index])
-			    > 0) {
-				rtlefuse->txpwrlevel_ht40_2s[rf_path][i] =
-				    rtlefuse->
-				    eeprom_chnlarea_txpwr_ht40_1s[rf_path]
-				    [index] - rtlefuse->
-				    eprom_chnl_txpwr_ht40_2sdf[rf_path]
-				    [index];
-			} else {
-				rtlefuse->txpwrlevel_ht40_2s[rf_path][i] = 0;
-			}
+			rtlefuse->txpwrlevel_ht40_2s[rf_path][i] =
+				max(rtlefuse->eeprom_chnlarea_txpwr_ht40_1s[rf_path][index] -
+				    rtlefuse->eprom_chnl_txpwr_ht40_2sdf[rf_path][index], 0);
 		}
 		for (i = 0; i < 14; i++) {
 			RTPRINT(rtlpriv, FINIT, INIT_TXPOWER,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
index 17486e3f322c..0108850bb9e5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
@@ -223,10 +223,7 @@ static void rtl92ee_dm_dig(struct ieee80211_hw *hw)
 
 	if (mac->link_state >= MAC80211_LINKED) {
 		if (bfirstconnect) {
-			if (dm_dig->rssi_val_min <= dig_maxofmin)
-				current_igi = dm_dig->rssi_val_min;
-			else
-				current_igi = dig_maxofmin;
+			current_igi = min(dm_dig->rssi_val_min, dig_maxofmin);
 
 			dm_dig->large_fa_hit = 0;
 		} else {
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
index 21b827f519b6..26ff551f054d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
@@ -1449,18 +1449,9 @@ _rtl8723e_read_txpower_info_from_hwpg(struct ieee80211_hw *hw,
 				rtlefuse->eeprom_chnlarea_txpwr_ht40_1s
 					[rf_path][index];
 
-			if ((rtlefuse->eeprom_chnlarea_txpwr_ht40_1s
-					[rf_path][index] -
-			     rtlefuse->eprom_chnl_txpwr_ht40_2sdf
-					[rf_path][index]) > 0) {
-				rtlefuse->txpwrlevel_ht40_2s[rf_path][i] =
-				  rtlefuse->eeprom_chnlarea_txpwr_ht40_1s
-				  [rf_path][index] -
-				  rtlefuse->eprom_chnl_txpwr_ht40_2sdf
-				  [rf_path][index];
-			} else {
-				rtlefuse->txpwrlevel_ht40_2s[rf_path][i] = 0;
-			}
+			rtlefuse->txpwrlevel_ht40_2s[rf_path][i] =
+				max(rtlefuse->eeprom_chnlarea_txpwr_ht40_1s[rf_path][index] -
+				    rtlefuse->eprom_chnl_txpwr_ht40_2sdf[rf_path][index], 0);
 		}
 
 		for (i = 0; i < 14; i++) {
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c
index c53f95144812..c65d14fb914f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c
@@ -468,10 +468,7 @@ static void rtl8723be_dm_dig(struct ieee80211_hw *hw)
 
 	if (mac->link_state >= MAC80211_LINKED) {
 		if (bfirstconnect) {
-			if (dm_digtable->rssi_val_min <= dig_maxofmin)
-				current_igi = dm_digtable->rssi_val_min;
-			else
-				current_igi = dig_maxofmin;
+			current_igi = min(dm_digtable->rssi_val_min, dig_maxofmin);
 
 			dm_digtable->large_fa_hit = 0;
 		} else {
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
index 76b5395539d0..f8b159c74658 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
@@ -756,10 +756,7 @@ static void rtl8821ae_dm_dig(struct ieee80211_hw *hw)
 		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
 			"DIG AfterLink\n");
 		if (first_connect) {
-			if (dm_digtable->rssi_val_min <= dig_max_of_min)
-				current_igi = dm_digtable->rssi_val_min;
-			else
-				current_igi = dig_max_of_min;
+			current_igi = min(dm_digtable->rssi_val_min, dig_max_of_min);
 			rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
 				"First Connect\n");
 		} else {
-- 
2.34.1


