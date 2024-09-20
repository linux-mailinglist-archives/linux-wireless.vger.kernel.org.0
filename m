Return-Path: <linux-wireless+bounces-13033-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 067FA97D00A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 05:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710BE1F24C06
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 03:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB75BE4E;
	Fri, 20 Sep 2024 03:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="kP8mz4bA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2074.outbound.protection.outlook.com [40.107.215.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914CB8488;
	Fri, 20 Sep 2024 03:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726801295; cv=fail; b=JwIWZYatyhQ3+I6cahv2dtXo1ZKk9Ho6xCs8X9+YJj/paxITWK0W7Em+FS1MGVgqPXwcUU82fABSZ9cIYtpHEMFyD/fkPPvoEWW99m/Xm1FMJc2nbu6watphkyjuMsFOWk+mgGcFnhAQCHXsaEabpjoFEqd7DoAzndQNURJz7Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726801295; c=relaxed/simple;
	bh=pKzhoCoD9n03+DuBgEWd0xvgYdMLyYh5ZMmnBx7uSho=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ii5Trbn9myzmMnaXP6Ye7dmMOI4RrDHc8rQohxiEw6zVlmaV3y7FQxnbEDIi1YfOC9WHv1HT3L+HaYxSqpTxL+6/KE+GpFwHDIpbvGP8+UFVCSWFZ1bK5EtyyUiQVjbXtUIwa82jO8+qP+SZ+HbEBo2cLEDUOAZ80IdpYSvLM8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kP8mz4bA; arc=fail smtp.client-ip=40.107.215.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMFWWicFDUQRgawZZRXVilQxJdDQA5FcjdLiGcykXgu3yFquQybEBGZgj+S9bVdwq1Q9+nmfktowx3L9EHwYybnYm6TKrQGR7awI5opHeT6pzkTUh+8rTgC+DRgWegQi7lctlUTEgH0jEyR8fsZ6aItguHbFrML3doo03aY+JusnZPIDfsL7g42Tsm2pi7qzIBhMHqsrQyXAvrSKfB/f5cejwZFJpZ7ZfGYfUew3AptjD/xrfJ8pm7yKCeAC3Ff+Q4XNMGKW81yUBHlqcGvkkZeg/ZXpyjPpbVeywzs3ZIgEcYeQs8QBnWsvP2676iW7DhupyLYF1QDSYWqSym70HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2brxpBey+dVMNUKWiQoBvX32gnqa2jeQeSQ9CLddOeY=;
 b=zVYBE6HqUZElgANl1SFPKdf9o7oxHZg8O5iCZiuQicN4gpUgNAxtWcCoHcGWLYjIp4n0u6M0kgOmn0qtCCk8XaxqgFAYzU+G1uMJqZop9xGXciVrNpQr8VcFQAvh44I/pQ08jpzqlP7vavbuM07KDRBpq5wOiR7VoqQ+FoA6lFS9fpLykWhePdQx5Gc1AZKdlMVu0Gj6584I0MURc5MsvJ5Li8k/G+ghD3c95Khli/wQwrHe5yehEZF7hJDrzrN8sviMcHvqU/E7nA9BoQo87x7hfOL6dx5fzYLmNJFZoDSx+iS/fr/ehgulzWoi6M50tsTH7rCYst7gKZgO/7GsTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2brxpBey+dVMNUKWiQoBvX32gnqa2jeQeSQ9CLddOeY=;
 b=kP8mz4bApmYPiPoTwvrmQ5aNUmNhrp1BD3FVhgBp+0M3B0F3H+bT+wNFsg3FxF88Bs9jqlbcOQjNG8CKwVWL2do6j8+03aG/8NRrhq3XlU2XDJscXfbLuuf0SAAaTpBcy6/ndkLqZr5t8aY1jAGB2WOS+79AiWV3jfNILIbI6JBhtHB8LC/EguM81DZMrLVRXatZNdb3Gz5OnueOEj9RFOqmGjKPRJY/LW646Yda3FQ/CVKYLHa6qR4olxvvWcKBrq2q3C16ddYJX2KAe+osWQfnPq1rRiUMGoADXN8biXFlHWCjBOA1lBaljS5+jT2Wj2ddSf3gTUkyT7BW8c00bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SEZPR06MB5271.apcprd06.prod.outlook.com (2603:1096:101:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Fri, 20 Sep
 2024 03:01:27 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7962.022; Fri, 20 Sep 2024
 03:01:27 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: stf_xl@wp.pl,
	kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1] wifi: rt2x00: convert comma to semicolon
Date: Fri, 20 Sep 2024 10:59:17 +0800
Message-Id: <20240920025917.1959932-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:404:56::21) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SEZPR06MB5271:EE_
X-MS-Office365-Filtering-Correlation-Id: 8063a207-0305-4ca5-a1f0-08dcd92084b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JDHaL9R8QvENXVo9xi7YFfLkYEm68IlcnY1z7HKKhtN8OLzGzdCA9C+B3lz9?=
 =?us-ascii?Q?BojLvH2r2u9t+G2lsZB3pgKHlNgUg9v/sG3KgYXiq2BFL1BfDPCbVoXWqqEx?=
 =?us-ascii?Q?54J9nIrPFbueeEBxbqc/LxSYOiVPGj+cZkhjgI41g/hxhxsxC1VtCT21faHW?=
 =?us-ascii?Q?s2BjQUGPf93KwjsOdjHsayyoxWXAfTRxKyfbbz14wR1En2twqHxY+aQCYkBD?=
 =?us-ascii?Q?X+ByzBXUfRX1LOn1PPjubt6CBfBci59vBPlrh88otPHGQ1rSQoC7IlWEPT9O?=
 =?us-ascii?Q?rCaRmIkX1bpEnp4Jqg3fkY8cbawGBJIU4Ev+gmxfrV5wbDBPJfVaBAoF5jwv?=
 =?us-ascii?Q?QspHqXkCap6y/0HzKr5nTgEAhWO6vJgy4QJ2sl3WaaMNCfIrJuyNrlV4teff?=
 =?us-ascii?Q?SkEWU6A0AQse5YpxueGJVoLEvSVYZXLPeoGl2j08z4lQ0qoGGB7Up8eFcExM?=
 =?us-ascii?Q?xxquOP1SfKmG2TNF8a5XLUR3htSbF7D7mhdnRg45h1dDHrK4zKPQNGsybUF5?=
 =?us-ascii?Q?CgjWiYjWd9wCCXUU38qbpCylfL5tostxuV5plo+4ymSEx3wiksDr+ot4H9E1?=
 =?us-ascii?Q?xwrWKff391Df40zA+dTskw9eTvEU0vrFqpTfgWVdbzsLCyHwOgpLbuvSLKoB?=
 =?us-ascii?Q?1Wse08IpSIZ0s3Gs8x6VO23y87x5ArOFBvbfHxFAYnLtmSoUA8dKPNfTkQxY?=
 =?us-ascii?Q?iT4z3qqBnlY2+t4GWVGCiTIoqJVrmKtdTGNz2eJdSyEQMM14D9NUez54tL1I?=
 =?us-ascii?Q?iF8AUOnd93p6KKZDhV2SoQpkrDUlv1kN6H2h47cLZJvKxfPrT+bsUfK9ToaV?=
 =?us-ascii?Q?Y8YKBKon5x8SwCILd/OeD96Q2D7bwggc7ws2eucXhWUIwIbQxJ3WJriMgLm+?=
 =?us-ascii?Q?mdBAoUj1RdNw9saJZQaZ/DOBwr4OWAcnoNj72yYvvwUNvDeJQ97dqw+Q3Bh5?=
 =?us-ascii?Q?kMkr1+q/iJrrKBtWtleCBclRERrKKAhnxhJxYqJy6ATDcVWjlUZOe2R1VOqO?=
 =?us-ascii?Q?p+y0ehPoCqIGis9Do6Cls1EFLOzNeg0qkymVHAba8i0GctmUHA3vZKk1eoeQ?=
 =?us-ascii?Q?TihljKC9wh7bbNfWf2wkhpYQbzQ2GPIJ/9J2EXAw62LGmFIttFI1WzoHpaZe?=
 =?us-ascii?Q?6OEIDtNd4VuVVVjubMGvw10WxmuF5otNYDjqAkUEP6hS0+KenrM5/ZH2kFz5?=
 =?us-ascii?Q?0QcK3uLNedPcSET2jLx0UwKnIaPN/YZGKItxgMAyrC2cYApkBXBIaF0ZOiv3?=
 =?us-ascii?Q?MmxOT9lV5BdOiJVqzr7Xke5d0WFA2XOIDW6fxFpHL6P6ViQHd2o1N/vZnkEN?=
 =?us-ascii?Q?yU3YNoi+H5gjxLYjvT2iNp0P6Ci5PT9RZt4TaqWjR0vTDEdWJssmLFJtxZW8?=
 =?us-ascii?Q?ETrxVruke7Uaj/JBgUMvP2M174es6pdjdQgxQ1pnF5WiMj0ewQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pp3/DhbvSPIP3+1g2XaJYQ8UO8xmaBJBKXqTW8S5FJBL/J84/kouThF0ttgw?=
 =?us-ascii?Q?yEbTVDYbgzRO53wmnLiLb7FPQtioqVUJJEuMF2VwehiNPuuCfKFVtr4ZddSx?=
 =?us-ascii?Q?ZSKe8ghNUj2hmGFqVVFAyop0m6gsUrlRHxDCCCwTFWDlPepz9yNZml+k5C0r?=
 =?us-ascii?Q?oPxUgdhOGGYpYrhVLVxWOu/OjGGA9diz7pui2pyOzED6AdXV2ei8gXNyb9SS?=
 =?us-ascii?Q?m/GmxFCk5Hdqt3sBrztXbvfijXYaBmIdsbmLV7l5dbGmql1uc88r1MBOIngm?=
 =?us-ascii?Q?/SuHcHt2TkOls0YMIxjC/XsRWmOpNSq3JVJXXsalSrD/8inObGxLkoMnxzm8?=
 =?us-ascii?Q?KgJdU9/US3glEzYIwg2BdNS8VJsXYV8jMK3eDlhpcjRjc1Dmc9xg951266S1?=
 =?us-ascii?Q?AJSeXAre4Gj7WtXs6pytVzy7m33vamQKwR1UQqnxwEUT0gJc+8nVLxB/pNw+?=
 =?us-ascii?Q?0Pc+OmStMP8EZpetO+sagOIcQNd2GSvKnMhKcaMAAZNLpMgvm5xgFnzS5/eb?=
 =?us-ascii?Q?C1dwqc5vaGBQzLWldK+YkyOQaxKfAfHI1sYYVdoCLDlhSnlHqCneHwphkEKZ?=
 =?us-ascii?Q?8btXN5AwmKphnvxU1xM+RaGEksl31wJujlETHwSGFRBEq68t5r/6CsWi6hVP?=
 =?us-ascii?Q?u9uVlxQtZ8zChUqGrfeXZlX58of2lFC4UR0x2iNoHaQnYvb1wLez+/Z3DKwa?=
 =?us-ascii?Q?bEjyNjV7BRGpoq67XXHS7bPfguvBOCc+2Rcz9YXAWzqlV/iTqprivJRroxRl?=
 =?us-ascii?Q?C34AWCHrKM4B5DUR+7Lt67MPtGa+3J5JCYQ1ZqjW7aL4PW6h24Bo+kOjcwqM?=
 =?us-ascii?Q?q/w+tZV+k6cCSEE2OJsnTgUW5+Z6fqTvMVPshPp9aXE4GdCm9emEr141vQc7?=
 =?us-ascii?Q?l2QMsWNw9VEd3ETM3BqGPvBEwebMTb6a8vy7pa4ud/EKlZNXYdKO3hi/RmGl?=
 =?us-ascii?Q?z4N6zMtwr0F/l9+u3X7Hy6FPraF4jQYffEo+PyGK8OigR5qxm93X0WuKBfG5?=
 =?us-ascii?Q?6tbd4e7rKhRPg0qwjcKXJ3w6oKTuW9Ibf6Cn8sy7knseokEApUHxi2PrwKFr?=
 =?us-ascii?Q?7PLBfCYSZnJlCZiOvs0NrlBml89n2byjDYqWgvH8FwnsVyUxltU8z+eBkVcz?=
 =?us-ascii?Q?qt462d5P1i/yK6d8QNgIxhgQj5ZiNLAE+PVDj9LAfe3rIAS3aR8OXIGzuhG+?=
 =?us-ascii?Q?S+tt11aCcuLpt/9HDuoMeh2wQspLh0u41ixmuljU9AMrdUkEVz54mCWkTQ1U?=
 =?us-ascii?Q?unc54JG6dN2lu3veef3PIPUE+1zaZdx5cco5t4DKywhh0kSM+8CRHX6PUAEf?=
 =?us-ascii?Q?vSE59wavyDsnkwqWVEJO7Y4x2amJliW8gRpiNdskGoQ3bZvCTCJvS3B1cd93?=
 =?us-ascii?Q?pnhqzumUNidqet1v/Pp7Fwj57QULiMTKKHNopr/Mph0vsLMXtZEB8WIRWggP?=
 =?us-ascii?Q?dIJmP9sj5oO75G0WeX6nZZJRxUjhctuOA+zFyJzKRtZLYwThSYgtr4Qpcp+4?=
 =?us-ascii?Q?XOzz8H0SvGzXypI2ZL6eCQO1VMxcUoHFgrC1gJeKjvKSfQnaayZLGqG1SUUO?=
 =?us-ascii?Q?99Z8NadvI8QMZIPS7ndtpQB9aqadsFz6S6qupPfd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8063a207-0305-4ca5-a1f0-08dcd92084b9
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 03:01:27.0683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3U5u6bw+870IrlTggvqTV6aKDr/xBJQnv6e3pVPWqyc3FSm3DlU6xU5P+2J4Sx74QmpDPqnIH6YailuVzBPJzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5271

To ensure code clarity and prevent potential errors, it's advisable
to employ the ';' as a statement separator, except when ',' are
intentionally used for specific purposes.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 3bb81bcff0ac..60c2a12e9d5e 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -3607,7 +3607,7 @@ static void rt2800_config_channel_rf55xx(struct rt2x00_dev *rt2x00dev,
 			rt2800_rfcsr_write(rt2x00dev, 52, 0x0C);
 			rt2800_rfcsr_write(rt2x00dev, 54, 0xF8);
 			if (rf->channel <= 50) {
-				rt2800_rfcsr_write(rt2x00dev, 55, 0x06),
+				rt2800_rfcsr_write(rt2x00dev, 55, 0x06);
 				rt2800_rfcsr_write(rt2x00dev, 56, 0xD3);
 			} else if (rf->channel >= 52) {
 				rt2800_rfcsr_write(rt2x00dev, 55, 0x04);
-- 
2.34.1


