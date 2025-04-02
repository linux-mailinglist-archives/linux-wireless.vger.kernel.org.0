Return-Path: <linux-wireless+bounces-21096-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78495A7929A
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 18:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A61B3B47D9
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 16:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6DA186E54;
	Wed,  2 Apr 2025 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-sbell.com header.i=@nokia-sbell.com header.b="QdHdKF/G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F1D18DF80;
	Wed,  2 Apr 2025 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743609817; cv=fail; b=mFTGsaz6hi1z3EHiPkvCypjhL/lacCwpLRRpJag6SOps8lO1mD49XKfpu13cSWyo7nmuqdau327ypLWBJZJfIeoBS2K26TC2lVH7l5X6JwQmM/oRfkGzxa21aAAVmIEh9ltqKaEs/1qw+b9x7oQH3x91d/CJbOPjBh/z6rBA7e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743609817; c=relaxed/simple;
	bh=CKyuptKILTN5KunSljAak7rzQk3/mAkmnsaXP4vyY6k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BqUkoiRhwrZTSkvDDKrme9ukfXz77bg7CicDRx/M9/QTVe4UrDJHUJhxkI1J615hjQwVxmzKuV3eHGvJ4rMqkEwwoEqxlTKy0RTrruW6Vo9S6ClD2imwulBllbzIm/ejCHk6wBzEEG6VZcSPF9BA3sgaDMpMN2zYXLIDuAGWYIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nokia-sbell.com; spf=pass smtp.mailfrom=nokia-sbell.com; dkim=pass (2048-bit key) header.d=nokia-sbell.com header.i=@nokia-sbell.com header.b=QdHdKF/G; arc=fail smtp.client-ip=40.107.22.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nokia-sbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nokia-sbell.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Npy2ALK0ME8RmxBJHr/s/rKVE/FphvMQlIILP7j0tnWtr6WFvgZs4KXYj1yIQCUmD6pX4AIWjs+7aiI3etg602YOcG4KU0QkcG5Cz9ek1BBszuz6hQvUHFSlnbd2snAwgKwFENY3RnsxeWWvt1JUzdUaD2FlgN2pLIDiQo86nRJQy8/831Yximl8V3DZujn62bSR04qbihm7EPgFYw49wdde/mhSMqFOS1SMxc+G8rRBK7UH3/1KooWPS9uZ/sSzPbg23U7ZkpRnUT/tN5UPxcE4wAKchPUygRsDZL2Pm4RRaMyTNrhuTE859ZbmwztacATgpTmT92lTJQ8FtnBHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DrURSzleIDTma6uwHFndChg5VAx80xNmUsWYYE5I4U=;
 b=UqpK9GxxGutUTKP2SfmOq31RdnnOWrZENsqzgjzgmuXE5JhOI8CwDrZuKg5eYdo+9/au6oFpsK5MDDn4IsTq/o/QE05EgUo3v+igr3Ln8KLF/eksrc5pW+GzdLz9taFO4Cl2wZV14Yh7nUTUuCpkuC1pWwcI5w4pebMOjJzp8irOrGOFHMrU1WMde9qyFIk9SLiSjR7+js2rPBNbgq51iAXD9rvp3+9lqe3osEzS92pDC5bs5K9nupsH/55EB9KSs5UuUhSnHeca1KBKQ4Yc9VyPoQx545y3h/r1/IYCU/s6ceg+kM3pTGtj7DsOIfwzbMm7Mbr8D799ZaybDTmrWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DrURSzleIDTma6uwHFndChg5VAx80xNmUsWYYE5I4U=;
 b=QdHdKF/GRiTvGQzElyzPEHMUsH7d86vPD8RobR0hJNFAPphYGWgwsCI2epw+1B3WPlkxD7tH/d0pXxeNQXTKg6ekxfAzhxxBdcovZPL2Zk2pZ5HUtBoAMhqcSnv/J1KYx2wFlZJPliT8lOfA/ewXvCALb/abTfit8hB+cZj+3tjLGeebMHLapiwjBx35ET8w9YeU5vmfCJpcwGDEXpk3AjvtyqrMgS+duHqnFBptku+lgNOn0fyHRGb3GJD2No/5rDVN+z7Fd03XM/5a4DHwTI+2ooVhhPI5mXLO/FjOOM3pyhzdNeOfXl2mmMqodbm7HqSIS00mGHYTVOucf/9HyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from DBBPR07MB7481.eurprd07.prod.outlook.com (2603:10a6:10:1f0::11)
 by AM9PR07MB7201.eurprd07.prod.outlook.com (2603:10a6:20b:2d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 16:03:29 +0000
Received: from DBBPR07MB7481.eurprd07.prod.outlook.com
 ([fe80::884b:f4bb:e97b:b9d5]) by DBBPR07MB7481.eurprd07.prod.outlook.com
 ([fe80::884b:f4bb:e97b:b9d5%2]) with mapi id 15.20.8583.028; Wed, 2 Apr 2025
 16:03:29 +0000
From: Zhen XIN <zhen.xin@nokia-sbell.com>
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	linux-kernel@vger.kernel.org,
	martin.blumenstingl@googlemail.com,
	Zhen XIN <zhen.xin@nokia-sbell.com>
Subject: [RFC -v1] wifi: rtw88: sdio: Tx status for management frames
Date: Wed,  2 Apr 2025 16:03:10 +0000
Message-Id: <20250402160310.996141-1-zhen.xin@nokia-sbell.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To DBBPR07MB7481.eurprd07.prod.outlook.com
 (2603:10a6:10:1f0::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR07MB7481:EE_|AM9PR07MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 87b12a5b-c867-4b7e-ea27-08dd71ffe8ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9TSupn5H/APzmv4SDu7HfOm4IXrlltcPFyoEKWh8ATan+2BZGUW/ZO11nja5?=
 =?us-ascii?Q?mO2DPXl6C3xGs7KEpxsakQrzUnMfBnsEbdzRVaAJE+qPIK0DNbLC8BPr25Bl?=
 =?us-ascii?Q?KaUEPL5aHxhvIqI1Vm80aVGVAtiCtFB6iKRNowKrJ0umECDzS60oo7qQ1QDN?=
 =?us-ascii?Q?9tJzcvj6PVuieqxMTcZfhhuIp2O86SZkYHSmwUCunMvlxyCUC6kkf2eN00oK?=
 =?us-ascii?Q?kekidjSls9tV802mKHTDZN4VdUVYabTGSM4kmvb/lAPenpIOWyhZjKIp2sXz?=
 =?us-ascii?Q?IU+V+SuQt2fBZw74FKoncYd7ND+/w26bwDyrsCFsU8cAZFuQ1o2qP33cnJDV?=
 =?us-ascii?Q?i6ek6xmpToj4ff2OKuwz01lEx1e0KMw86QOv1C3SGBM4jEtmrPlu6x35GpEh?=
 =?us-ascii?Q?+t1WuxzwrllQXtaLw7gxN8LpR113n9CIQRubmVgFwX6WbCMCarvEdQ2ZLn76?=
 =?us-ascii?Q?denzQ8K0GQGo8se33rmqZxJnrvOkYlGhQHKLRM27cJKSqhnC/M+uanWEpUcy?=
 =?us-ascii?Q?kK1vHn1RWFxhqDqPDUv2OKVCgOOd+niSOS0OjAuntiBGun6AyMacVduz2wsp?=
 =?us-ascii?Q?6FLE5Rs1cd+uoODB7n6pnxHy77MZOEiMo+9APT/9tiGxErDZuDgdvBiPMYd4?=
 =?us-ascii?Q?+tvhU5Yh9AsONPP0yWe0AllG8AzD6q5tPVe1r1ndl2nFpGC03gHWBEPK47SV?=
 =?us-ascii?Q?OacJ0Cx+2mLJdnxh0PabJKTzHBHO7wxHY3rw7evSn7+I+awkCNdRN460F6fQ?=
 =?us-ascii?Q?Xotw2Xl483lwPcOahiVYMG2uvza2vOCeqF4hE4g+R4FFD8fhV7I0yHeiLbKf?=
 =?us-ascii?Q?3ceeEqXFu01poY9mvIiiVCEmFejCzdM9JXeETUkLsWyDBXm+EiW8B5WlTyP0?=
 =?us-ascii?Q?LJarVplBF3nkeEXua8O1Ifvc8Y3K79CWD4SRlYICOEu9v6SRheAMXR4zXwij?=
 =?us-ascii?Q?soprhOQnmS/E7+2CL06Emsa+AcFzeTKGjhYAFjfKdeX5Gi31Hceo+BDDvVBI?=
 =?us-ascii?Q?sngiPr4NsnYQHhIjK49L5Yj53JVHgttEi1117uq6WtW0pAc/vieZ5rL701wJ?=
 =?us-ascii?Q?Em2nWpMbv+h+YRkiYtzg+hDeOG6DEdcCv1vY4m66R3Xeneh0NTaAwrERSui/?=
 =?us-ascii?Q?nrPto/yOONgzQSD1HzOgoH+R2R3/ONfVbKKiejUvHST4gs+RqQ8rvp+kuNIX?=
 =?us-ascii?Q?NkzgXAaIap+E9aQIOputqvRIcZn8uwVYhVFOaySKu2ffm7rPTYMy84huXLyr?=
 =?us-ascii?Q?TKNsQJujVbIq8AjEF7XQ0nmneJsRrswiVG8+Ldi0rPh+osfFYgas+J2e7HMz?=
 =?us-ascii?Q?WLhMefdF4DRlXtY1A5CgzMVboB3wrH2scc01HFvDtmvDjOJaWZJrqwe1BwC+?=
 =?us-ascii?Q?AZGcRIPk6+fQ6DS8RhRbWlIV9wsNe//k1p6lRyb/MdJlfHnA0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR07MB7481.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u4m/U+nRKDrMAcHJv/hKbDMcT8Uyv7OzUDIXfChhHShHhp+ZRgg1hBAZi8lU?=
 =?us-ascii?Q?Z4IKWiqk54fHrXRdaezD0jASWFlzJ2M8TH0uvZE6UeXJy9RA5BE4l07pP8MC?=
 =?us-ascii?Q?XQP1nDCrlCn1YStb5anw5IlYgpBIpyF+D0YxxeHE3Ip4FWEh1DgdjPKLbDka?=
 =?us-ascii?Q?EvbYYDC90A9ImtQnTLWAhCWVRF5YjriZdMsVLojl/uWaCOmbVUHSDkJVitlP?=
 =?us-ascii?Q?vzp8BRzVJA4Z/s/YGebGVh55Q8LLyl1uc/dELakIK/9p0cByONu92nNfYKZ9?=
 =?us-ascii?Q?B0LwSTw2L1MHv0W22Ix0drqWB7SwTb0NZW3Sy51Az/0szqxX1FQi4PiFyfFQ?=
 =?us-ascii?Q?lCWL39m5j9V+BsxalRmLz/SCBwuNy+BNV1tt7f9nPaIR6VRbGh0SSz3wW9G5?=
 =?us-ascii?Q?fE3sNmMMrhdYKDC8vc2bUh5VbuWWq+pySejd54e+TKYHDmooqUakrcey54PN?=
 =?us-ascii?Q?CUzYL3okO+LEupBjtxqK5jB0JztFrrWx664ryKEQL+7p67P4L7ds15TNJ0wY?=
 =?us-ascii?Q?tPWgKZal1/DZxZVkhnhmhH3PtCJECrveTvtDQOUtexz3qxWeTLPVMvAK+xaH?=
 =?us-ascii?Q?W4Y8A/rf5F2Z8mBusi7m7e1isgG+4tnws+/nRv1nNHN3nukCKnwXEjZQ1nJX?=
 =?us-ascii?Q?n4gBaw0StwD0EghN+d22CPd4lEDmrND6D9h8byxTvIUAPs+ljnRVKlyDLwxp?=
 =?us-ascii?Q?Ma5RhJMZb+l4XG55wt0wwx10grzOhhyAyZtLMI3ikvS3G5p5WZSnd0/2wdiT?=
 =?us-ascii?Q?KE41UqEKxKRwr8ic9LADjkvLxKDob1n/AeehjmnfwhljEBMhsgYnoinwYQK1?=
 =?us-ascii?Q?e2n/P7tivJJY1kXWY1Nq0FaGmMe9oBX5s0KiLK/Fw5BvCN72cljrt0Uf9Tg5?=
 =?us-ascii?Q?nUUsgOALGWlk0FadNETsiO6oqEWsHg0QZ+9QAlIxeeBhqb4a5cXsbD47zIIk?=
 =?us-ascii?Q?QDPZSI6+UW7jiUaYBkY88uiIRKFAM2/oQvyZxSL5VE27pGSy2cY0SMoWLRtT?=
 =?us-ascii?Q?fA2xXmWu+nASvqIsXQZ9km5jjTE1Og+LzY/YqnSyMv7ise98W1toWa0Xa2GN?=
 =?us-ascii?Q?YCGzs2nGOT0wsN52a6uyH5KlDttKGMq9o2ASu3bRzfluih7aa3aJZ9536A1u?=
 =?us-ascii?Q?/6lVIWm22NXUoq23aHZe/YUkdLIz+F0uW5jADMjx0/8OTqH0cmwFo8qZKBem?=
 =?us-ascii?Q?rHdohF831u+Yte8LxG5enMwx4ORsuuyLTqvsisetT7FH4ggNvsRd3uMKxWYF?=
 =?us-ascii?Q?HqEiGFMZ2H7ZxvTsyEw+3msyUkWJS8VVcZSWlo2jy1PNLTkDdSZ7MNNZr+rt?=
 =?us-ascii?Q?LZsBirvXvlCyuia+59lYbZrnsOAGTgZLOW5/JIjku5TEHmksxs9BAXYeK1AE?=
 =?us-ascii?Q?ryoY4Vrgc/5gCNmyfFnNdc6gURzoXonbPAbkitRAtv97itK8MCJTAwhnGaGE?=
 =?us-ascii?Q?4tQgyEtsZpKaej05QaO+SJxIa2yZ88E5Qg8v5atqkWEJINmTtFGfU7PVfIxC?=
 =?us-ascii?Q?710l99bYnfIJtj9buaZE11hF6F7IBiXuyxJF49pYESAiiZskBxyG7BvY0gX3?=
 =?us-ascii?Q?5J+uLHbKWPFZ3fsoOvN8ObwPd/s0OG8Uwvf/5BSjPKPrdvHOMDIUYvlqLcHC?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b12a5b-c867-4b7e-ea27-08dd71ffe8ac
X-MS-Exchange-CrossTenant-AuthSource: DBBPR07MB7481.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 16:03:29.3399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWqrJWWsSTZp9G31sOsk5w21oYGeRuXh2Yq2RPYW+9l+Vho4cvr/QnJ7rVuCBdE8S9vQ7bVNtDN6cyE69PiHA70Cho70mrEKafq7dYNQubc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7201

Rtl8732ds doesn't work in AP-Mode due to the missing tx status for management frames
This patch enables tx status report for all tx skbs

Signed-off-by: Zhen XIN <zhen.xin@nokia-sbell.com>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index e024061bdbf7..84f71e13b5ae 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -1186,7 +1186,7 @@ static int rtw_sdio_request_irq(struct rtw_dev *rtwdev,
 }
 
 static void rtw_sdio_indicate_tx_status(struct rtw_dev *rtwdev,
-					struct sk_buff *skb)
+					struct sk_buff *skb, enum rtw_tx_queue_type queue)
 {
 	struct rtw_sdio_tx_data *tx_data = rtw_sdio_get_tx_data(skb);
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
@@ -1195,7 +1195,7 @@ static void rtw_sdio_indicate_tx_status(struct rtw_dev *rtwdev,
 	skb_pull(skb, rtwdev->chip->tx_pkt_desc_sz);
 
 	/* enqueue to wait for tx report */
-	if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS) {
+	if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS && queue <= RTW_TX_QUEUE_VO) {
 		rtw_tx_report_enqueue(rtwdev, skb, tx_data->sn);
 		return;
 	}
@@ -1227,10 +1227,7 @@ static void rtw_sdio_process_tx_queue(struct rtw_dev *rtwdev,
 		return;
 	}
 
-	if (queue <= RTW_TX_QUEUE_VO)
-		rtw_sdio_indicate_tx_status(rtwdev, skb);
-	else
-		dev_kfree_skb_any(skb);
+	rtw_sdio_indicate_tx_status(rtwdev, skb, queue);
 }
 
 static void rtw_sdio_tx_handler(struct work_struct *work)
-- 
2.25.1


