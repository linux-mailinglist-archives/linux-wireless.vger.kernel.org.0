Return-Path: <linux-wireless+bounces-24051-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64074AD6EA9
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 13:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4EE3A89F9
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 11:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A97323A9AD;
	Thu, 12 Jun 2025 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="HzRvlTxq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012029.outbound.protection.outlook.com [40.107.75.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E613239E92;
	Thu, 12 Jun 2025 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749726668; cv=fail; b=mS0doSepDHd/5cuPV/z1fN3Fq2sbXQiU/aNN9Ik1w4g0mL0a4AnFQwfmgRu6fMcos0M3BXimnC4L6wPiQPKffqyZ5kJ3BzWbtyHliXWAForcjjxkyMzhfPSFDg+ziyYFLNUI9OFIRjrNpnpLE8GpLqn8FhL/5JGWRbDkruoWaIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749726668; c=relaxed/simple;
	bh=nFmS7BRQCBVMlef0y0xIompA6YaKgKBJJ150PbC74x0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JiSG6kc6FYs49uL1T0vrLu0Cd2ohrgf3Qk37wwydC0CicpStc+7O7+ZSxHAtVET5f66EuYnGfwnUWmjVhR39pBlEmt7rBq8rLKWDoV80uNu3/kMNAK1lBTa3/xYnrZ8Op34yauKY79cRf80Alo7yprOoFF1hPWQBjrFbV5dPWog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=HzRvlTxq; arc=fail smtp.client-ip=40.107.75.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyM3h2qx1lxGyULsE4JeFfaDOqtlFG0TZYV3PjCGM97DGsF0miai/Gy5D+n9ulr4e+rtB0u5WMzATSwDupAtZpiBFYRyfuprdHW4m2/nWTtPBJvxJtdIqZEUmLNRCGpK/kqaDgNE9sHZanY1K3STGzVL5a6m/2KTLorLuf9hr1o/Ak7J7k8/9SNjTNo6Asvm7u4fp4d05AIdOi/0bG11vf3dsvLekxa9955nlNw5blIKESWDLgxBc7bLSnrJRV0tJ0CD6M6QmJF663+BpKseDcFP/QrTqpESxraTn2dk2lgsnNYxzvAV2ul/1jF3Jkrh5suYHYB0bzXg/qsSdVWu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aSGe54uF7ffWncFONY8hul3imYDwDU4gPRRoPq9vVk=;
 b=f7775VaKAksYIVS3DSIc7v1Yr+1JWqPIzovql+loffvmmFr93hyubU8xqduhwC9N98+vyLZz9wSaqzsMmdhKx0DQLbIO5fZq52Jvvc28s+MIqA+cKTkmzpEBZcZcvfigzAqbbsyaTSwA56Qq4FZdG4RxhaA1Q8cH+j5oUIvwX79HWkxVYy39012ttcjYOxjZvvypt3g7pNmDTDZSKCQXviUVZJLx5y/JeFHJhkD9hEJ/i2aiC+hZY93zpl5wkv6RksRv8AAGrMIJrPxDSCwkcC+FB5gDmq9Wk4TxQ2v1gKu1N9TNi3VqyjDCC88IJXjdgh6snqcGPh1TplSgtjbtXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aSGe54uF7ffWncFONY8hul3imYDwDU4gPRRoPq9vVk=;
 b=HzRvlTxqTBfh7rh8j5fyM5bvKlLQVHy6kzuXR+rKS5l58mDDNbaLi+kCGmKI13P4hARFolx8u17vPakDj1TKhZSi6F3zbVvYcQlMA0t6RRfLhmpwqJadS3Tk6Fb4va/eBBG6wKZX7MigbPh9pGLM1bFYwxY4USwNKk5IYYRAIfORBNG97K1ydVfDrapGKkkUsMMo4vFB8pdtI719bHs5bmVz+EQy7pjlOHoXx6ZcbnXkf25O8EspoG0sq7rOThAiNr96CBMA3Zw/m4IziW4KYwpe93Ulm5p3xwERFLCETPbYCt6AiecgAuc7XdWjEaS9mQnSEacnuUkHTHYvfzjE6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB4802.apcprd06.prod.outlook.com (2603:1096:4:169::8) by
 TY0PR06MB5354.apcprd06.prod.outlook.com (2603:1096:400:214::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.22; Thu, 12 Jun 2025 11:11:03 +0000
Received: from SG2PR06MB4802.apcprd06.prod.outlook.com
 ([fe80::685f:929d:f06c:a349]) by SG2PR06MB4802.apcprd06.prod.outlook.com
 ([fe80::685f:929d:f06c:a349%3]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 11:11:03 +0000
From: Yuesong Li <liyuesong@vivo.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yuesong Li <liyuesong@vivo.com>
Subject: [PATCH ath-next v1] wifi: ath12k: convert to use secs_to_jiffies
Date: Thu, 12 Jun 2025 19:10:46 +0800
Message-Id: <20250612111046.94743-1-liyuesong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0106.jpnprd01.prod.outlook.com
 (2603:1096:405:4::22) To SG2PR06MB4802.apcprd06.prod.outlook.com
 (2603:1096:4:169::8)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB4802:EE_|TY0PR06MB5354:EE_
X-MS-Office365-Filtering-Correlation-Id: 520fedee-9aff-4c03-9233-08dda9a1d18d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gb45diyeEc+1yNCoK1I2V6NdFCSAZG7z8Ry17xy9oEUff9hOEq16yrLHo/P1?=
 =?us-ascii?Q?uMsEx4vKemFQforEZ6bWg2pPEpX4zIyL9mWgiIHIz8Psw0o9t9++mDA3MLvd?=
 =?us-ascii?Q?QmTIWIC4UlD87brNEOI7OkWsl0/ezu77FMKHci1Xb7OCBribI09wHImNOe63?=
 =?us-ascii?Q?0vKPmC7CY89ZzeH5Bb/IOMdNo1/JThN/PEP6cu3/8miJ4kyyoOQJErDlM6Sl?=
 =?us-ascii?Q?6Kh3StRKM9s8groluEEgcRioLDafX0vGNzdc0Ro7955qCo1SriEXp9Vk5zNq?=
 =?us-ascii?Q?B3HcL5bGhu3rKk2QMVPjVWHqvMgRICcVE2c21V3gxeCdhTEQodzPEsYGtklv?=
 =?us-ascii?Q?ufjtVSMjW5mRs6DD1czeebM8AldpuVpO/qrmNyDdL5bZCI9WPdzh1gYcVBF7?=
 =?us-ascii?Q?DoVgHY9hVjnfZM7hU+8xmgMspz8Bbb8LfamniJrZ6QSLCDifq9YVSqABhwAw?=
 =?us-ascii?Q?270qTtBBUgu4uQDX/V9DQf7dzLcWjBzrpjVUl7i7uqlZVm8Cu0YoT+RegkG5?=
 =?us-ascii?Q?Sa9268bIOMrSahVPY/AB1D+dWRNZMkaT5QvEKApZ5kKnRPpSyTPCNfqOllDz?=
 =?us-ascii?Q?a0T5bPcHC8i0zVbo+DghWXBZz7lUHZd/aTOzTNcQ0YwbteKaHpPdDHn1k2fx?=
 =?us-ascii?Q?w9hsDm9T23bogtZF2YtLz0x4g80wBWH+h+JGX7ul2ZyD1Qfqe3rgzY37Lg+0?=
 =?us-ascii?Q?DsJZPDhn1kl3VLmsxIoNM1oiajS//7QAjVZbqM7Y/bW5EWR44FdOckeC/MUx?=
 =?us-ascii?Q?xIhAlk+P8rhpX0NVON7mgfNoYKlhrVGoqiPnm8aVZxqydGSTsbtuxnkj+XA8?=
 =?us-ascii?Q?wbJpuy1aSvsFGTw4mIEzKer5KlOA2Gh84JZ8IlMK14TsDlqPNrmGLEHWXfL7?=
 =?us-ascii?Q?YCEag9i2+qWhTmGJTFiK76SL++O4zHLRkH4Te5NQgLdFOClgQpEsUiTXiJo5?=
 =?us-ascii?Q?AFpDVZLAAVEl2zOpgz3FC7Bk4jT4XsWv2A0vF5qhlvdXD9v4A/iuERAcCaKC?=
 =?us-ascii?Q?2Czmh5IyTHQvmypaobjCSOO2bRrCOqvA2/oC0mVYHJCW5msvNCnhAWJ/Kuir?=
 =?us-ascii?Q?fNcjkidbB1X3RyksgvKFZL6XaaqkQWiAZ6qFHZ8RITzuOmWFsMAlIJqwJNKs?=
 =?us-ascii?Q?jB3wBswP809Ilzx0ekb+ya2BroVhctuvz+yfaPPUkU/idzzRY5oIX7xyq8Ll?=
 =?us-ascii?Q?3hPZLslPssAGlm2TpNVPDNTqZCf9GZTh/a1IyY1WwXQR7Snetqep2xbilVcH?=
 =?us-ascii?Q?rTjEU1+ucXjM3Jq595ANGNNqka/4mjDN5KfAtsNfSkdQlTiLEUyJMrMWpoOr?=
 =?us-ascii?Q?TOPy6rnvAdhPd3d+8wCTGwHGezWzYv0lS7u2X4xpL+3N7XBySuNCz7WnYrJk?=
 =?us-ascii?Q?rdqkrQnvujC3QHB2DkVcNmvQFMxG1kGRAerSW1/+8plEu2rXVVIWIsAheAH/?=
 =?us-ascii?Q?rKWyqTkibom6KdD4VoT1be2w1SILg7smrgvkmXCXNvkzXiIMSYMKBQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB4802.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HjzkSZ1Ii8Yacdc2RQKBvgrLsUFb6mAW2LAzO6YT/BB9SO+Wbv3JIfeeI4j6?=
 =?us-ascii?Q?CZLvG2VmdwLJk/Q5R3wfV2/xJKeiufFWYxzkNEUpQG8pVOosH/VYtqWnicZ3?=
 =?us-ascii?Q?LWIt8vhxpxrt0u23rVCZAcwFYsyWYB2wZMys7V+M4gSi0PDfqGsWBMtKaamE?=
 =?us-ascii?Q?LPcj23n2tPM7CGSUv7xoP0NCTCoKHiAjGBD8SMH5I82c5xY7gAbMmLBOKv18?=
 =?us-ascii?Q?XGeiRd3ShXqKUNqydBJ0l4agJOeigGAX0icyrdor13RQ7sBWqmf7ioOOvQM7?=
 =?us-ascii?Q?QaksFhN0X1GRYJscVc0MLJBcCFvg/qcdAnkD4pmaSdurSt89UPdVmOYTKu3H?=
 =?us-ascii?Q?nxtx/crcnZ9sJ/D/GbDt/REPR4sonSq/MYQ3WtWWUWMSLO/TkA7gJ01Pd5We?=
 =?us-ascii?Q?mEjZnGZHTRgvWnoillsJ0JEAPUqqCbiVzr9LQACyTgbP03uyaFk2Q0cI0w1y?=
 =?us-ascii?Q?sduUVKZHy27qMOM5rawr0CkgytttPMlfY9DzN0Ytdnh+A5522knjUMHUFEnK?=
 =?us-ascii?Q?y10Qw3odqRnkn/gyo1K3Ny1nEGNuulttflsPUKZVlTfXdWwL4mK3ESVR4aIu?=
 =?us-ascii?Q?nm98DPnzRMCrVSrKUGC5RSr2/IhYEFnfklHbgmbSCo3KnYUEc3mGuxXmNZZg?=
 =?us-ascii?Q?PQVhL6FxvtiTyISYPmyuklriNEirfT+3QquOSZw76JtE/SXG5SXhdfrMMw5c?=
 =?us-ascii?Q?H3Ks5M8M1dSBwYxxRb2nGy3MOh8Iw5H04U0QH5szSmgYBHngEJYHHrTAZf0v?=
 =?us-ascii?Q?5cUnV0bfOOc7y53O5plCXQidHiPLxqeQSRShdf+APq/RwywT3/BTyWrJlr+h?=
 =?us-ascii?Q?nEvR5QQs+30V1hppPwuFqqW8SlFaCKRPOAUxq2Df7ilGlNr5s8Dee+MOh4og?=
 =?us-ascii?Q?P/oP6z/6DGIssM8uPHQYq+R1LlBaVhz6+W8sudfnVxDvd60XWvDAa0YxRX55?=
 =?us-ascii?Q?HKNsvoBe+G3UtKyw4TQyaMmfL5NJPF5rCzh0CNUSdP87fPw5eauMkX4ePPD4?=
 =?us-ascii?Q?04i/dbp6L+3d18UN5KprEzKD+a4uRGNwJmSZvrviFJYjA43z/mxubVwtAXOV?=
 =?us-ascii?Q?W8JYkCBAQ9LMeSJOaXcLwyD/GLJjQlw2Iu+twYysxJ3nHE6hWKvQpTn62A7g?=
 =?us-ascii?Q?JOGpddl4JN2J6MmE7yv+wdyTtsPiXcqRuB6qBqj888xNvsBJVU+UkyvBL+ju?=
 =?us-ascii?Q?7U41Xh9QiTfpZkOe9Qv4lWUKq/J0j1659GhWsq6kZHEnC9x8M2lUukz2MNeJ?=
 =?us-ascii?Q?K6e614rYnLioakyF1BJJb0eOvArbNjAlMMcDKSut8bRBOoH6KNjZ18OiKm9H?=
 =?us-ascii?Q?qNI6aak8+NMCFbpdA+bYiVQnsKq8DWNNiMKy7GQa9TDFaVXNkh4qvw/QulSi?=
 =?us-ascii?Q?IaHMdJtQIVBgxYpJGMW7yDgO0Kj22UwwuhRpnFFmtsTorECdE9fw6aypO9b3?=
 =?us-ascii?Q?3SthGiwWigO5pipb88Qm+SxNgHZA9xQXe7KDtj9C4X9HMes3nJX0/l+eQe9k?=
 =?us-ascii?Q?c/Cdr2dQzfE7hLN5EoP5+QogGRbjHY2oIRTI5uVCC5AH7k4G8CxKn+tYMUTW?=
 =?us-ascii?Q?oi6Eg1ruHFokREeX3xr1NrZXvv51ydtwAYhpA/Rg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 520fedee-9aff-4c03-9233-08dda9a1d18d
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB4802.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 11:11:02.9796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UW9I0gSIUSa8UYxfU1VGNfsJxbzxX0iSLE5TMEvD2NttUz/k+d0VnDKmGqw3Lq+l6Z72VPh6vT3IMd61F9z6Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5354

Since secs_to_jiffies()(commit:b35108a51cf7) has been introduced, we can
use it to avoid scaling the time to msec.

Signed-off-by: Yuesong Li <liyuesong@vivo.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 88b59f3ff87a..1ba2701393b2 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4373,7 +4373,7 @@ int ath12k_mac_get_fw_stats(struct ath12k *ar,
 	 * received 'update stats' event, we keep a 3 seconds timeout in case,
 	 * fw_stats_done is not marked yet
 	 */
-	timeout = jiffies + msecs_to_jiffies(3 * 1000);
+	timeout = jiffies + secs_to_jiffies(3);
 	ath12k_fw_stats_reset(ar);
 
 	reinit_completion(&ar->fw_stats_complete);
-- 
2.34.1


