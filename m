Return-Path: <linux-wireless+bounces-12063-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C4A960776
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 12:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ECE61C22BA7
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 10:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE0919DF5B;
	Tue, 27 Aug 2024 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XTBEDBeP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010022.outbound.protection.outlook.com [52.101.128.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780A517BEAE;
	Tue, 27 Aug 2024 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724754653; cv=fail; b=UEtVIrwisk0OrNRfbWIT4SeLUBSsV43qmBRiYSmSQJ5vFeGrzTVBPbzD29mypwn9mKmhZ+vOGHP11M+ThV0VsKhxeoPM25oj/f5EG2jjN1vcat7Ft3ctfT7XWdiUVidZvpR+LEQSxLkwO99iksdW3NlzcLOQ0t3N4aTe+DM3EuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724754653; c=relaxed/simple;
	bh=QF9I2fYd1syrJpf6z06flnAwouPG1RtKZ4fXqr3XzHY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fdNCm9xwBNGVBtS4trJ55CJyRCcrHXpCfH/U2KT81r8xiZQV5LLU1YkvDPBci8uzJXduSQ4BhIFbo5q/E4Ke7m8sYvx0Necu4A8G3cpoZ5T0Y5CcmNJStsAzGdtw52l6SdE2WcVqRa+xayhsZO9jWwM481q199Qt3pqUaXfySuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=XTBEDBeP; arc=fail smtp.client-ip=52.101.128.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlavLJciaFoq0DILnZ/H2HcqzMWTQM2J0KHukvRrS4nnMxIrSBkqIF3UddlepKJoSda5fyhu1Q3NxaYSmJcjs+kPj9HDDoIDrXDqrgOB5l8ymKNZzJiSLMnAsOBbKBFIuVflaPddvX6kUD29XTd7OoKGLL6/O7BOX4j/P0k+G0dvboJpEguDEJZH2RGvAsL3c8EhLlZgiSQ11RaQPZy67FyuLnqx2wWGj62qLqbAd4OOLViIak8vkpSftMCTfiEVfrA+Gmye5FLxuGST776m/fKcnJ03obBfWy6tJAM5Er9sn1OJixgUOb935T4Dd1V61hvcT/dYxSPCv7LVrTDdQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xr86qZ6MU1mN+tIj/XAUJdAvbrA3p6ED12ocV1XzpqQ=;
 b=ZJe6eso4O40SZGqDt1dRPGH2dG+SGPMBMpX3vidlY1QvPyxqm3qbWKQQL33+TTQ/TzAxkthyi6T6uiS1MAxjCZXIznqx6xkipFcooFLCvwuEITP2gokFRfK3u3Oc1W5Xibi57OiDPb1LsdLTEMSfzS4XQi6ra5tlNdZfXYFNIYmWSXgYHwftclSUen5aNBpVZT5aFSTzTas6PG3J9tLzU2TpvHd8GZJxm+syg/euOHIFi9KmH0kqMfe21Qkbj1xFWjg3Cf+YVNZYBxufqBgwN/rlpeTbeDsDKzW3vSs1GokOny51bRpTOy+5GSRFG92doYghZGG/cGqi+OA7GnAYOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xr86qZ6MU1mN+tIj/XAUJdAvbrA3p6ED12ocV1XzpqQ=;
 b=XTBEDBePCqCagGZFWq7scy5esmQjzuz7dQ+ibV2fhJfF1/YqPRu6P/k5eYp6WQoXFNk+nsbOwSOYehD9RrgYLrhgfXEuOdf2ee0KcDqSTQ9EgA9NUfVdG95sYNqgsSwbUhJH2X5liVkr6eYPi9yzTf2lLNcQ88VL2eHexxxRgDoq7YUOx8d89xaln5hG3gFXPqCvgFVSNfpHZUxK7f9goxDDyAgPN7Gd8ZQE+J9Zysp6VadNVqo7l8KK7hNtnWyZgVY8i6+rGVES3CE2OxmE72PHxCggJ4PFkIoJbVFxlVd+rDLcOKXeb8LjYkspY5I9wOSIs88QujGr+yixANaLeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SEYPR06MB5789.apcprd06.prod.outlook.com (2603:1096:101:ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 10:30:47 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 10:30:47 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: edumazet@google.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1] mac80211: scan: Use max macro
Date: Tue, 27 Aug 2024 18:30:12 +0800
Message-Id: <20240827103012.3853588-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0187.jpnprd01.prod.outlook.com (2603:1096:403::17)
 To KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SEYPR06MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: 9716c398-7cce-4e0f-77bd-08dcc6835042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MDXFBZgMYMCtZ1jdHIGzPnN66OpaFy4Z8wcaMeRsL82JJ3ObyeWHl4pvVbmD?=
 =?us-ascii?Q?+vgAX1TJVAe9nFrDSqvWSqyYTOx8xxLs9tMS8z97s6G/9ETwZotPJUTw5xrM?=
 =?us-ascii?Q?cTrNxvhd0W0V1ByM80oPrpvGjcUNh++M/LmbSIdfBrIjbSLJbaIXh+pLfkJ4?=
 =?us-ascii?Q?5Y8MoaNvzEY28W0evUpAOtoE3B5RYXF3CegtEwwW5JiLX2eFJdGMWqBmUYmG?=
 =?us-ascii?Q?I3DkQxmeRMd6dyHoicfv50x00PfaD5NDkJUxr/+9wT5QD0bo7viiRdm7mbC1?=
 =?us-ascii?Q?wfzSMeTwu6e+hcGeLb2xF0QTzkFMO546NwgENOcFR43IJZsBFMNp7UuEVBIE?=
 =?us-ascii?Q?fnqzbqUTYnCYDPXrWzILjV90E8R6oUACzUhtOgFAYog9WEoySvt2Qp+jfeUe?=
 =?us-ascii?Q?vEci7scr7PzxHONvE1X31lI7ttI5Y7m2R+2uMr3laTY2UZEQMCJqFQwM2kGy?=
 =?us-ascii?Q?P46s6LeyVWdBa9OsnV+wst24fenk1vTBe97dAgrle/iU4fohymhkUEBahAY3?=
 =?us-ascii?Q?MII0px5GaYxaoXl5IPmStdU313uOtm0Qn58QGxRUdUOAfghj9KG99HglHJHW?=
 =?us-ascii?Q?daNta8lcaO4gmgiyh3+CmimfX/pQhn1P28O+hDao7MFrVF0rLZTH9MmEMi2x?=
 =?us-ascii?Q?yCfbIGzoZLC6/pHTyYj35GHIjHbOd8iCUNw8i5691MEw2d1HGq8fFqruYl5F?=
 =?us-ascii?Q?Whpkkgt2oZ0pW5ccWLNFtYV0bQDX1p2ph/NVeZoplnv0HOEazWgwctLlHmRX?=
 =?us-ascii?Q?R6BT6lfghUx39AMzoy7LIZcT+G3F6rRRQira8gNmm7SkC3wTeLhyt6DUQCMW?=
 =?us-ascii?Q?vix6mfARMELjiJa73tftBxfi/RmqhMi3z109fEbaZrT0SWimgLEkbnZI7AJO?=
 =?us-ascii?Q?+mq7JimlEA4jbu/+H6UQKlS42+HABFnDn/Csx83+aGakP2WruXNznbnK5qE2?=
 =?us-ascii?Q?HLiq4HR3yLrcyQ04tiy1yaZ8UF/KiFWs/SlWKQBZ/LPr40L5g1uh1gMlh+ST?=
 =?us-ascii?Q?ZMalknK7DdWxaIJm6NuDjOJ4NUvo58qoZE1CTSuVlbR8Hm3SEc6jgT++Iggc?=
 =?us-ascii?Q?9E1+q7eD1cHpuLm5SuOSYBN4OoxMtHHLZFyn9nqFsllyzmswLiwP4xaBGgIe?=
 =?us-ascii?Q?SRK5Lr4J08qIxSGyMJ6qGLCt9Kz7HYeqdMIaLnx8i+0DAd2F2woAcqR+b4On?=
 =?us-ascii?Q?hL/rsHW/uWvJw+VAPotbwzHPZqPuAbWiehJbvRhKJx93AcEfLQ5aF/0SPutA?=
 =?us-ascii?Q?IJYXGVq5Qn51YjNRvEPL3bYUgjCHuym/QC8dp1TxgBcVm/9a+iamTPa8qKU+?=
 =?us-ascii?Q?HzuZh6lnhChgb9Tc50bBBKzNh10GLH1G6O/4aOrED5jdbRB8Nds8jqMxFNWD?=
 =?us-ascii?Q?xlRG4iq8rgDCpYaN903MOCBo5VRYSTKn98mIEaLc7Pjx5Y9Z2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gnbvsEEZScnyPs0xWWyh7X9xxCTqmT98/cgWg3fuh5Yb75i08mXnQy9OOUkq?=
 =?us-ascii?Q?hznGjkaL7Qfyxe4VPtCtnw6BpnXcl5KdThvL+h7olDeKvYj0Q+2lYOD91nJi?=
 =?us-ascii?Q?7/WnE0sc3U0ZL5ZxtkvIM9W8BePyV13QHXJYPfrMCyWFq8FEIXSvBPdNSnnZ?=
 =?us-ascii?Q?Hr+IV7FTVLjluAwfLv1TFi1egC1VhcNpQ0isTTNVqWsfnt9/1StU3qdCl9Lh?=
 =?us-ascii?Q?U5qwikyQSs/351yANZ8yFGqFc3K6idN1HEtLGWdcxluoyniRWb1mUnEArL6I?=
 =?us-ascii?Q?cMU2dJp2PHL/iJoS95HC450Q5dkToVQ5Tekb1tjxQ/T9GKTt0ZvBMcNqYSes?=
 =?us-ascii?Q?YyiV08Ye92AdW+hB23CG8Z6eXdF9HS3tYTDgcH87CRXqy1wcWT483u6pnqxY?=
 =?us-ascii?Q?hu/757wxHvtHYupzoPdVYr5mk2XQ0pQ+RNfJOubVCjR4NQ7b71NDhZorLQWK?=
 =?us-ascii?Q?4VwzJ/lTIG3NlnAEOGpb40YSAJMm1H4PQ/sD4UxeSBJuAd4c9xRd4QI1n1B4?=
 =?us-ascii?Q?FaBRcxNYnu5Ay809nNT41WVkoht2QxFjCRAmWIHS17rzz2Z2SNTdkn/cSpcp?=
 =?us-ascii?Q?OIV0+MFjAvPm7V8utl2vtt7zTdO4Cw73/5YHNUsEI5BcfaphGoUmGhT2+pvR?=
 =?us-ascii?Q?jcZp+wHXemz56z8BxqOv3FXC82IhnnErTI+5VI8I7en3HE0ZhCU+yuc16F9T?=
 =?us-ascii?Q?ASwS/Tmr8FbyegGe2fENL8kicZOHxZDvEY2DREWCM5PtrvVvGwneLC/Qpts2?=
 =?us-ascii?Q?bvKlJYSjEJSVKiX8LPOSO1OtqBbhQH1WqyBgQ3oaKreayXN1kh10z8RimKTK?=
 =?us-ascii?Q?KVKAiAdn91rCXyQITbUUB/281VmTSGa3oYYjAc4vg9mP1Q0eQJfqMmw/BLhb?=
 =?us-ascii?Q?ncmJcW29z+5yRe+nT9U7YZe28RQ2Jhr6GXcw8QlkjMP4Z1ZEzrpNaJhYug2i?=
 =?us-ascii?Q?hJnHn0rbY4w2s5jUhUqh78J+vUDfqCtRXWxAJtyAGGDfQCdyuxz2ezJu1/Vp?=
 =?us-ascii?Q?o9VXWJTVTaZ/4Qr2IrDXnKVJSD0eqi91Og1eYdXt0iU1H4XuNqKeJ+JHDY63?=
 =?us-ascii?Q?c2bIAiEoUYV2zjTfUXBd6zKsQiDxapDy2Sygy8mO+pqHu7VZ/Dwz8GE79ags?=
 =?us-ascii?Q?rzMSd5jrz+ki+Jqrobdi6sYtOyXoIYjL1c+B9Q9vGvmkoPckNE3loqpkX0cg?=
 =?us-ascii?Q?WA+UCyLVK6EnHP2vKCuakS2CO0kast6BZrehwVBE0u/GzvazqOJHtil4kOz3?=
 =?us-ascii?Q?X5W7aGYww5Ui9xeHO2xZcYf0asSMDJeLvyRzKhVEyxjKIPGSKv+rCp/Bt6iN?=
 =?us-ascii?Q?g+DZS8pQ827WtGPmlvM5a/L9hhpKZZElbLJomp3RuLEQXmaJ3eJJEBZWy0mA?=
 =?us-ascii?Q?TAy1Ufu+MhM/4BG9iFdeCmNgUVN+9Yiyay6o6w/70MXeBZ6KmjuD7/SSukc6?=
 =?us-ascii?Q?rPI/SbWuf0Svt4DoWwBZnpZn8dr5YKUAQEvvQW687V9dQEMftESJKBWPpf18?=
 =?us-ascii?Q?wp/n9rzGTt1YiuUvinDf5JfKToycI3QGuihZLfcJz81+THfcB5Gn/493z5mH?=
 =?us-ascii?Q?IiZthO7xOdHU9lWcIfZzD0fGuIib888R4/zXcfHQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9716c398-7cce-4e0f-77bd-08dcc6835042
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 10:30:47.1258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vehWMS3cfCZo+YyxlhWyWe0004sxl/R4DJh8iMbd3mDvgY3iDobW84gc0P3hiUChhBCBPHXAKmkwDPyh4npf/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5789

When the original file is guaranteed to contain the minmax.h header 
file and compile correctly, using the real macro is usually 
more intuitive and readable.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 net/mac80211/scan.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index b5f2df61c7f6..e77c9f07b046 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -1013,10 +1013,8 @@ static void ieee80211_scan_state_set_channel(struct ieee80211_local *local,
 	 */
 	if ((chan->flags & (IEEE80211_CHAN_NO_IR | IEEE80211_CHAN_RADAR)) ||
 	    !scan_req->n_ssids) {
-		*next_delay = msecs_to_jiffies(scan_req->duration) >
-			      IEEE80211_PASSIVE_CHANNEL_TIME ?
-			      msecs_to_jiffies(scan_req->duration) :
-			      IEEE80211_PASSIVE_CHANNEL_TIME;
+		*next_delay = max(msecs_to_jiffies(scan_req->duration),
+				  IEEE80211_PASSIVE_CHANNEL_TIME);
 		local->next_scan_state = SCAN_DECISION;
 		if (scan_req->n_ssids)
 			set_bit(SCAN_BEACON_WAIT, &local->scanning);
-- 
2.34.1


