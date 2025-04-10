Return-Path: <linux-wireless+bounces-21393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A7BA8485F
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 17:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DD84E107D
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 15:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2251EB5FD;
	Thu, 10 Apr 2025 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-sbell.com header.i=@nokia-sbell.com header.b="JtIZn+L+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2047.outbound.protection.outlook.com [40.107.249.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6661EA7D4;
	Thu, 10 Apr 2025 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299973; cv=fail; b=KlmIimGl3/F+62zEW7A4NDePZHqabgBdPW+TOdpHuVcbDU+NoQsohe7zlRUoOMpxtYVt+FotHnnbuV9epM8/ekAeeFhvG1gMKvbXs10sT87+9AiCX30SVy+kiPZBAM/ZBADJz/CB1v196VunxwbWbnPtUF2L7dQDRfRXhwoELTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299973; c=relaxed/simple;
	bh=cbjm6KefOoeYX3x0+dTHtfl/1EP9s2BLy0U4+LTn1tA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MPQtM3NhK5nZazjrWPZoYqJ9YpFMbBU2nPT6rPNvsig1yH5L/HI19+33qbpAz6Tf7Em9cK7t+lVFdddgeQg0r/9KBUoXIhFOfFFIjT2P1+47iCeqxUDUK6dlVDKuqYDzowjHNIGSH6SpWWno31GIWt/KxnJi4V468xMtGN52Sdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nokia-sbell.com; spf=pass smtp.mailfrom=nokia-sbell.com; dkim=pass (2048-bit key) header.d=nokia-sbell.com header.i=@nokia-sbell.com header.b=JtIZn+L+; arc=fail smtp.client-ip=40.107.249.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nokia-sbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nokia-sbell.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGafN0tx4kr6xLF8dSWO734FxHmZbyzkIYepVT97OxZply1FXUPrAEK55Nu4IYD3tAuUjxGYYElIjDz/XvzRU2kXWGbz6ec8gPfrSGPkKQ0IRrZ+JfnCec+CuAMp0zsZQb0uMbtfOgPBZP3JpHX5FJtXXCBzwKr06dSJvF9oAqDwi4j3UOUe9LL8FLj1jUNcfeWL1mHnRW0mTZsk93S2VB/0UOPTYF45rjqdIc+PIb2lcpjBYbUkcA5Z8+0PJq4Gln2q8J0VJOVLoR+yVM2ENVID7yHtaEht4qL7Fvp4jxJS9KqUKJ9dt+v+3hln3ktv1VekYO9AO50I3LCKQdfcEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fd7ryp86/iW0KTx03BUNLn7z+pmQ3rApnzRUE3SFWmM=;
 b=DqIngQKIhygK/FOADp6T7rCq4Dhmg1DJ1wUot4ZON2ZQvbzx6NyfZAvR7SHos8tj+duv1YK0010+RoVpXeJyFhA2EOncSO99M7du4BlQPIcovsoJiklREvuHW5yjDgefRmBSk3pVfXhX7FFoFSD92Mjm3aWDy/N8OXPe868ZxzJ7jZMWxbDcari/1S6Zx7VEtdbAa353ity3gcqezppjoXWrR4eVZJQrTgGAKE6q6CS5ukYsZ1D9oPdGCuHEWjpfjMfjHbvUx9tSL6xKTbK5D8Vq+yIbj1ns+dKlwLUuAquu5w0d0WcEstDxGFZQQrCfuEWBRqfaBDWprVj6B9KRRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fd7ryp86/iW0KTx03BUNLn7z+pmQ3rApnzRUE3SFWmM=;
 b=JtIZn+L+hRQojvkqnzJ9L17czlCYtNeg1gqbW0jMR+zqgAFcwQ4a64USt+gCX4IZEKmM+IfXh6IGnt0zE3D0ezMW+fKPQRhqylSMkJdilWOjsesyX+eBGRHJOkBW+lXgHk/oTZk8H0svfsqJ2BXODePAji27AqLHuDoXCFUTaHsSXJSfO9XJ/WE1OuJ5lR9BcKo2E8VG/LLb833BEA1TkDO8N2F6+C+PFATH4lHZECzsWhZ929pz0Po9z+Tm+SU/f22PNueC//F6udnjmpd/dKYMtbgbPLxkDkSpt7w6zM/gNAJtq6SxwtEFVAxE1YLDNPjL/JvW51D7QHvvEoAqaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from DBBPR07MB7481.eurprd07.prod.outlook.com (2603:10a6:10:1f0::11)
 by PA1PR07MB10210.eurprd07.prod.outlook.com (2603:10a6:102:491::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 15:46:05 +0000
Received: from DBBPR07MB7481.eurprd07.prod.outlook.com
 ([fe80::884b:f4bb:e97b:b9d5]) by DBBPR07MB7481.eurprd07.prod.outlook.com
 ([fe80::884b:f4bb:e97b:b9d5%5]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 15:46:05 +0000
From: Zhen XIN <zhen.xin@nokia-sbell.com>
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	linux-kernel@vger.kernel.org,
	martin.blumenstingl@googlemail.com,
	Zhen XIN <zhen.xin@nokia-sbell.com>
Subject: [PATCH -v2 1/2] wifi: rtw88: sdio: call rtw_sdio_indicate_tx_status unconditionally
Date: Thu, 10 Apr 2025 15:42:16 +0000
Message-Id: <20250410154217.1849977-2-zhen.xin@nokia-sbell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250410154217.1849977-1-zhen.xin@nokia-sbell.com>
References: <20250410154217.1849977-1-zhen.xin@nokia-sbell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0067.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::20) To DBBPR07MB7481.eurprd07.prod.outlook.com
 (2603:10a6:10:1f0::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR07MB7481:EE_|PA1PR07MB10210:EE_
X-MS-Office365-Filtering-Correlation-Id: 2497146e-6582-4c60-f36f-08dd7846cd9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xJKjZCGNtl2lbzjwDg+GlUE5Y+FKcbi5FPU5nAfTK9yorfSqTpzKCEMWaaYb?=
 =?us-ascii?Q?53bnTTrlgLzhE1g7ClQ+nCAn4ChbpizXTfgdHOCXKHM7Kx9cKz7/c5N/2xSh?=
 =?us-ascii?Q?z7NUFJrvI6dGgr3En20eMaKtamRVojRqDpmn3zez5VQrzqqkdSFBo6JUb64j?=
 =?us-ascii?Q?f5pTEVvZNUvjZa9FaapGL5oGxJeUDgxSRs4P51e1xWJvNHKYkQTKVyDjS+gc?=
 =?us-ascii?Q?6hvRUavrSTXE/RYcjPadsB1VuLRxLWUx54cHDR32hTkrE5PWWRWhmjAKrjiu?=
 =?us-ascii?Q?sp/ib5GdoL5iPINdk5Hm4ciUOjfLogzLAlljusb8tzCwAIalnnJgJoHqrIxa?=
 =?us-ascii?Q?+9wr6l4fTeFTqYi+im2254/BQOB9pP3ecglAs/Fvp5y7er/N7Ci+9VdeHQe8?=
 =?us-ascii?Q?3XnAr7IMwmrS9Va8pTJ+liDsNSL8ceOVmaqUhEGcHmB/Fuzlv25hK4Yd8/qi?=
 =?us-ascii?Q?x8wg1Gkg/MJ9+Cl2+GPORBHIdjzoq3XGAnOWIEXUAnmcGlY9iZxppl1p79vA?=
 =?us-ascii?Q?t8UhExXCSF3Q/zKg97gnJpj/7MjRD4pKUsVvRurGoxRu/zeHuqDrmfZUK8S9?=
 =?us-ascii?Q?vZgtidgQWBGRla6NvgTWdkI1+pwV7KLMNzY/H2CSK8P8nGHXSWjfH1gTzLsK?=
 =?us-ascii?Q?M0Tq0X2ApWmEeIOIFYJ0WFiJQvHgSm45nRQPUoVJjoOkJa5P0nHf3t1Nam1T?=
 =?us-ascii?Q?5xKw09d6smsymrzD3g0kK8XAnwU2bHqXYEIbIW4Nmgcc8Syauvcr0kWObjMu?=
 =?us-ascii?Q?LDfCPK1s3QRnZNEWik1WEssTS9bEht0l0uEqJW4n/WHZQfdb4+c6057iRbQE?=
 =?us-ascii?Q?/ljUSzCfp8GmHgF2h+OOuZ5xRpXRrQAXaCU+u37Pko7RhH/gVB6/jesui5lh?=
 =?us-ascii?Q?1S62DkEsStQmNCobEMA0gYBWuBIt27k+3SYL9oz79fmwkgotqojIS5YdzzY6?=
 =?us-ascii?Q?oVrITNFiXtmCz4aQhdICqMxZg+n8hu2yJ2oWqRwVd8DH7iQykassrvp3A4yd?=
 =?us-ascii?Q?DhvO1kuktcrlI0mAzmZ4gXGZlEzwYThdmODBaBDdxNCYyLoe5a5pAp/sShFx?=
 =?us-ascii?Q?x6Ut6LsoZQoOvjgqWAW4XLocoRuvynCWedqqBD/JHdQzW5dcTy+itjBR/SKb?=
 =?us-ascii?Q?XsulIBp5ivfoEuvKcYBSprJI3nJV/fqqeDzsNsD98Cv/p9la/9plYgqnTeBl?=
 =?us-ascii?Q?EDzy+x/9L4iCM2heua4RKej/RyPrXFfdHVX8pX1UGu7hi6B8sZspikPQlxPf?=
 =?us-ascii?Q?879aeHv/m8MJICGbRXciBebxEBxCkhEA6F9aVecE03fkhmjSMWiVeDpZRM8u?=
 =?us-ascii?Q?2FH3RQsEtJ0fBDCWbkkaldCtkFiPBXuw0KEfu45VHEVkbeqDYwP4RdfiiZvM?=
 =?us-ascii?Q?/FW8Pa8tOclm9GSxKGCqmwkBxqcDKkAJ+4cEA5Izj3bNb/GWtU1HQBQZI9wR?=
 =?us-ascii?Q?uuN7Ns+PgTI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR07MB7481.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z8Yr24yJWlM6VoNJw4TnZ2CnYvxz23FDTE4BtYjnWsLZKd9dP2EYYBg1Fzlg?=
 =?us-ascii?Q?cotcS84vca84KaNOsP8Pn9Y7ZG+GbW3vr3vP4ySiTbZhObQqKOr/ENVCgDhO?=
 =?us-ascii?Q?mrPCZHGT1D1U6L4B+3nHRY+Xq83OgqTOcywUI/wQZSteVFsUiUtkf3xT7/EY?=
 =?us-ascii?Q?aSUWxDOUU/juPPHasvmIKtB4CF+MtUvYoBx2yxL59ZVWsQ9Nf/ka7lZl7sp+?=
 =?us-ascii?Q?AD8SrvUhgyebHwYZCEsXJVexMdU/RSABMwu1nmj4HUdAQIbExNL5gmtJXHdA?=
 =?us-ascii?Q?JOzW8s5X2Vx68ADkTrvYVGKC+wyoKzaHMZ8Wm5hSddSO6xNq+oH/YqYfStI3?=
 =?us-ascii?Q?bZT7kEkaTVYYNoFpKZVTEgdDsOFbPut+UBYM4MLWo0rG7J9QvBdL8POmEYXK?=
 =?us-ascii?Q?jQICRUiT3Zo8CBSFx1Sxj1tujm8g7i4aGKAv8PNipOeQNMgvXdY3mU1nj2ot?=
 =?us-ascii?Q?0pUIE5HtVeiA8u65uFK6MBLQ/U5ppEvqS9vEYEsgUUliRGwfnEanW8//0HAq?=
 =?us-ascii?Q?SfIkQlScCe9g5H5o3eq7wUpgfnNNlgX23AoYxakyn+YvAf6xbhxykcGyPecW?=
 =?us-ascii?Q?53ws+fenZJkgP7BBwA0FY/WkDSAiuoNmVOQkdGfRH3nKIAq3hz+1KkjFu3rr?=
 =?us-ascii?Q?nYd1f3wccr8DTV14afXq91VFRXfMnJbfs2t8Dk1sA8li0rKcXeTdZ5flfonW?=
 =?us-ascii?Q?XFs16/wxofspkpflJ553Rj7vGeBQatFgc7cYX5Cjf8bvkmr0ZCQ1U3Sz0DNd?=
 =?us-ascii?Q?kveQVbBKLrsfVZK6Lco1ASRVJqT7csL+xxktlUC1riBwfshLbr65TiWu7wh7?=
 =?us-ascii?Q?ZxvAG2mL/ro/E4gu3sosSPydOJHgBaODDZ98Fb48+uPwScMjQ3d3C+/h4i0O?=
 =?us-ascii?Q?KeZopXWm1u4/tT+tvD9NwpfKYXf4YwYGEz+mSc/2QZH6dzoQ2yFDV6Fm2EOX?=
 =?us-ascii?Q?xQz7eHDf8BpPPKxopHprnCaeEXB7d9RYCr02Dn8UaK7sxsecnLNIM3HsPpFl?=
 =?us-ascii?Q?EyJcmA8eS8zxx4Bd4lObEGKu8TPt44UTTZ7KqtRDm+oWmndewKzPG2snfmlh?=
 =?us-ascii?Q?a2DnA1VeSqvlISj7hvnGo/QOorng7ZoquLuDtUAOxcFInLwPA50tM1lvH8qD?=
 =?us-ascii?Q?eYcm39FWJYSM0fUtObhcrqIlVoVahkzHZpRazfRX/Tj7uQjBab0od+tQzSeo?=
 =?us-ascii?Q?SLn0cNtEHvqa0e3R48FD/rIlU93MFRMRGJ5lvKVOpHRJKIw3nI+kI+NB69wq?=
 =?us-ascii?Q?bRdQjA5JdGXp7fkAr1LCyyenoJUDOfG7RVPgH9lThe4VdR1ChomBNVDKYGPs?=
 =?us-ascii?Q?rbqEF5odFiVYSrmMpjulpH9OMSLR/OAOt+exP1EKnLGo7Appy7EU/qnHJ6Qa?=
 =?us-ascii?Q?h+GfxQHAbxWtwe9U74qaO2tx+K2Rh2bQUrmjABf71RCiUWmEq401lcf1Ve21?=
 =?us-ascii?Q?x4BDtTvs7iPqdxAbhjdNBM78b2O6nuNYmHjitgY5Mr9/TfEdVOq+3icN3ylU?=
 =?us-ascii?Q?3VQVxv0VuodC8Yw8rMA/G6ef7oiKuej4U+7aIZ4XiZk2+JtrnhplonfuslCa?=
 =?us-ascii?Q?NpafJzpv0dWJHZJ/Er1lG6GOQrXhRX7cwnhrymit27QDhmYO9NJCPjat1PRL?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2497146e-6582-4c60-f36f-08dd7846cd9b
X-MS-Exchange-CrossTenant-AuthSource: DBBPR07MB7481.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 15:46:04.9932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TiThzfdDhtBRGiJYme/fds/qlnN7wB7dbvBtLGVj39QYtLMSaYvyyeRpJ0OHn6XUIEK/pVczPdyn3QAR2+OaJuXUazW7MxsjtGneFMkdg6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB10210

Rtw88-sdio do not work in AP mode due to the lack of tx status report for
management frames.

Make the invocation of rtw_sdio_indicate_tx_status unconditional and cover
all packet queues

Tested-on: rtl8723ds

Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
Signed-off-by: Zhen XIN <zhen.xin@nokia-sbell.com>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index e024061bdbf7..ef51128a4b44 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -1227,10 +1227,7 @@ static void rtw_sdio_process_tx_queue(struct rtw_dev *rtwdev,
 		return;
 	}
 
-	if (queue <= RTW_TX_QUEUE_VO)
-		rtw_sdio_indicate_tx_status(rtwdev, skb);
-	else
-		dev_kfree_skb_any(skb);
+	rtw_sdio_indicate_tx_status(rtwdev, skb);
 }
 
 static void rtw_sdio_tx_handler(struct work_struct *work)
-- 
2.25.1


