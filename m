Return-Path: <linux-wireless+bounces-26426-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7FFB299EE
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 08:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58113B6D18
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 06:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A691A274FDF;
	Mon, 18 Aug 2025 06:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="TGbdLwmm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012023.outbound.protection.outlook.com [40.107.75.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFF2209F43;
	Mon, 18 Aug 2025 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499354; cv=fail; b=ER9PjTLmSp77XXMFJIxL3iCKazf22mvgvF1eHxGgsdS8XFRYFYAnUQYRWEIfK/0RfobaFmf+G9fW0iUqc+xBQn7fUVxg+lSp2MtCLah6HUI9CaylClrGq2E5uzRwGuhm/tsFFF0j6ckfsGE5yxwrwsck7g2G4w+7YVmWUxll0uY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499354; c=relaxed/simple;
	bh=VK4OE7P59g5wnTR3xZb4TWZQgvSy944I2XxxHwXE+Zc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cKXjUjfWyq9cHmtxoT9yLL7JcamsBjaLLNdF5G0eYNdVeHPWZcLyv1JI12q0IDdaB05Iw1cgHXckcbN5kRnioLULue1PT7r0kFIuxks847xhZs0Ta5ownpTddKRYGTQEDG70C3T+bfHU+OePb9+17i6aE5cAbfc9uOqPpXVeu8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=TGbdLwmm; arc=fail smtp.client-ip=40.107.75.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZ6LDIZCWVXmKW4a8geDDN1CHdUJDeT3BT7rBH2tQSjqAs77S3vku/spiBYiRvYnGhdhEvjcGvYCpQrzb6tTBmqQrGsxG5Xo9+2RihM9iOmxDM6RapkGP34w8NNvkqIfhPLrYlUcNIFIjua7uGMj2/HQhFSGRCilx/V2aUT5uNHQfX/he6wLL62GuZPg68ckCY/ekcfKQA8BALthqlUz/4Ur2GDXwZmHEy9c5xh9gJViken+afs45/6URlx9w4T1AgvMnDSnZcnr/oGDwBkD2rolKcg4jhgPe+aMUl7Nx8YdN2POOtsGNT4PZZyZl09pDBuYKMX1wnz3SD4DKKufxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRnmAu2jEa+7O53URsW4h4DobXrryB0Fp/cCxgCgtKM=;
 b=s8o0NEFA+ze+56gS6fl+QGf+JqNSM3+HaspDxzYFSz+BFIBOz9LwZwCs/lz2aTnlAbPmmxH3jj4KM0KBwNXp7/D+hJ9VkLQz5i+Jg/ubdFOS6H1AbraqGSgs+IUdmv9vuwV7VL8CXSJ3nkSaKGjOxC+FTL9rmfihpI1hGf8/3o5Ly+G++ckWr9exdFB/ahlE8h84z7jrll5A3++HK3hMmdpBtJC9B03lqXx/5lIYbRMc9qmbrEUdUy5+X0LmEKSvCLPq/VpiH4ShWKf9CHFN3xwO7mu4i4jR3NR5G3Z11I/JLtZhEGD6cz5LcT80OM0rP/RExi4iScmeViEU8iLhBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRnmAu2jEa+7O53URsW4h4DobXrryB0Fp/cCxgCgtKM=;
 b=TGbdLwmm3P0TtyMevGxfk9dFumeCO83RtGNLlegu3jira1zNfp50ThZJB4jB6N+FnxUa+9SIZT2EgaI7zGsQSg8xPDtakUPfu1XraRk/ViCXkiUcWDCCsACo5IcnoBZJIqPVfxNgoFmJ6e9/4ShxaA9oz5JinSGyx7R+fXFNGybMyCtAg12ERV4iGd/ygkQOGjQ8kZ9u8HjAudasIklzVNa4AoIhzyp4419BgJQqiLyEKUfI/ygVgwXeNno3v+EqJZ8hy3aP8Y4+qiTc0ERzbARh0SxrRmN/YW+fjogl975qb01kCvfzyjRUylN1vPAKHakV/bIZneOtspF5L+QzBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYSPR06MB7157.apcprd06.prod.outlook.com (2603:1096:405:8b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 06:42:30 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:42:30 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org (open list:REALTEK WIRELESS DRIVER (rtw89)),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] wifi: rtw89: 8852bt: Simplify unnecessary if-else conditions
Date: Mon, 18 Aug 2025 14:42:19 +0800
Message-Id: <20250818064219.448066-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:404:56::23) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYSPR06MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 277b16ba-5f5b-44e9-ca3b-08ddde22675e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kH2mhNZt7HTa3z82FND84XXh3ATag1aKU7lXQzqrrXReaXZMS8DXaLckX35k?=
 =?us-ascii?Q?YWXACC7u+nVALVgKssGLl9mnpSertFYg0Er64Vku6QBSK8W3zZ+X8c1ePm8+?=
 =?us-ascii?Q?yvFM+XSkE+hBW3Y5xVZFE3MNsm77muqhORA+0Q8yV7w41oRXYjp7BKn83cD3?=
 =?us-ascii?Q?uwx9ehVNBjJcji5mBfSz33IdSTMup2RNPvSBXL5mfFkLfE5KbZThkaYuDW2+?=
 =?us-ascii?Q?wwoyBfm/pyJ/8POLARxlVPlpQ1RecoV/YQHON62vcLW/fxqh9QoETF0zW7eb?=
 =?us-ascii?Q?UOH/ih8fgZknWLXg4by4TLMm6egLO9JT7YsM6YsIeri2QmQ6syfENGwBmpgv?=
 =?us-ascii?Q?BJs98L6SqgZTFd6Ykqvyg+Evxp97XHpXL/YqupdgLusqId1cBXdBWUL+/nGH?=
 =?us-ascii?Q?fG5Rx8ypwcApoZizFt8XHrMDiUCPVjKw1vIjt6X/TRsIPUdA+LROwDaNkoy8?=
 =?us-ascii?Q?PIYT5DB2qZMTpc1Wwt9NF2SSSaDTdzdNbueneh+j+7OetvkLaoiAQdg0eXmJ?=
 =?us-ascii?Q?1FClwDF3kTClgvSwlYVLWLDtWpYzOWoYrGolsrFfnLnf3n3pxMZgBe8rxQyI?=
 =?us-ascii?Q?fB+d9p98S3lJ7IfDiDmkrMplFfuTvXauvY3syxgA1WfHtAWq2x9cpXL06lFt?=
 =?us-ascii?Q?W9/qCE210F204XuScyyul3oB0DhFOEy9nF120pw91Y93QtJACQX/skJTQ9WY?=
 =?us-ascii?Q?FEbx8iBn5Ys6GntvqeyiJ+eBavm9uaV/N7PCFPMn3XwMJavXWeJ6MQi7VclD?=
 =?us-ascii?Q?9vyt8mY7SGwQ23V7FgwFS6pMwlSUVUe+0hZ4WwC08H2tEKTTYmJxw7hYqhuX?=
 =?us-ascii?Q?KXW9gZ8z64VipV+LfDrZ9KdKS0FKK1L7JGuPx00l7Wy996X4majOzwxLjP1M?=
 =?us-ascii?Q?ZZafpUmfgvpim7622jHFitWaWt2d1PbvSGcCvLFhmXlQHT6UUFg7aKGqiIf/?=
 =?us-ascii?Q?UcHiFYFYLtKvDtcPycPYcYVJTn6XkN5NEd8Zb+nsgp1zNn2ualJ6tMAt02wK?=
 =?us-ascii?Q?bQZi5l7gKGfVKWpPrYSOIvpGNDAcBnptLh6MmulkcHnoUuz4wXAoqDKiZT/j?=
 =?us-ascii?Q?QEAlYGIwnmbgcZQHAKHJkb0CcoY7aImCyPfOjjtXr8rSFi7vkme3I+Ua7rDG?=
 =?us-ascii?Q?i0vROChUn+/yzhgKYqoZvoU+Kcx+jROhnsZjnsTHXcQMZ5/8EUbkuZzWyK8b?=
 =?us-ascii?Q?5dxttTLVUJCELyyaJ031vbmiqdo8l+Ms0sb4xjTniC5c6UP0xAsN9BNh9Rly?=
 =?us-ascii?Q?Uzphuc9b5QIl5eoVqusnecAKmFWfvKCUf+jCZ8W6SCixubL28WZZtb9TUY8s?=
 =?us-ascii?Q?6/M/45NkMz4ReUG72B1qRU4zSyPoHqEc+5HOzfUhBl3O6fuDlHK2ry7F9s4L?=
 =?us-ascii?Q?pUAapRzTx8y13P08YH5fiLSgcILr3tCRmx9sr3BdZcifFtaDVyzpdU5TwuUg?=
 =?us-ascii?Q?TuZ4TE2MPmvz9cUTltSm9pQ/LkFChp/8rTfacfXwmd774R5y3NLQuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/DmBoNT0aU72pTOnQtDAFK94Qs//7CdttBcZcTVVVdcvPKnN+FRkS6T2Hf6G?=
 =?us-ascii?Q?okegIBOspQWnfRaWYnrDDjFivbSGfWFe0ByDTJXwyQzrTtUlnJhxtJYeBHLy?=
 =?us-ascii?Q?eWFa8imUj5k0kbGyNVsnMi77M79YwDwV5jUhCf3xTwqThd53SWWhtO7Fov2F?=
 =?us-ascii?Q?WIqOfSFMCQKkulbye6uIP9eGg7jX3QDk0DzML+q2dqw/Fje0SxdHz0uRt3ec?=
 =?us-ascii?Q?zBb8ieqzm8PH3EgkY3NTPctAqswq+Thx2+0PfGOjG8nL9vNS8i73XfQ/GSpN?=
 =?us-ascii?Q?PeVNyixPvQYYguiYYlQ6r5k9vo+HPDBNM01wPhVXvFgZp4YCFDRA9ni1gXx9?=
 =?us-ascii?Q?HKxyli6EYT72sY0dxeAoABXNBiIrkn6Fi7/0ma1J37CikHT44PvhYleYQlWR?=
 =?us-ascii?Q?Wxm+ZGZqL8mM9Bknb3eIXJJk/Dn0fxeozFjcJUP1ZZNOYQftYILiOkCymzwz?=
 =?us-ascii?Q?19o+ZAOaal94U0jJfFAHbjARhf+vD2xCnFh+fQ3LaX+Nh8J+LfA0xKivKnuT?=
 =?us-ascii?Q?9fhg393SgHXNCK0KbyCA0oDnZ0P5OAWWdbLbEqfsjxZWVLZCyxJ73PY7WttV?=
 =?us-ascii?Q?And8dzQqAprK47/tgLFZGQ9bMZJjstAmLThUo+TJsDJaPrxxQBLrkxwJ7RmE?=
 =?us-ascii?Q?OP2wd4GxBShonjq41jgaPTcPBglV/IDsVbUFB/tK4QyBjdptgqQpZYqfYV2P?=
 =?us-ascii?Q?wCsF/rBFfjl5Re/WEmgAeGKURrzS1r3jRNgIeDS0HDZPUdIBRh5p+yjDhb+e?=
 =?us-ascii?Q?IBnTZEoAaMxyLexv6dNpBsLj2lmMm3GqA69hTjQKQfFlOeoJ485snssA6r+1?=
 =?us-ascii?Q?erHns5IJV363c2vfaBSQfx5A2kR/v5qchvjZY8cTx9iBrcousxyrAg6h3x/3?=
 =?us-ascii?Q?/iWoCaMWfWZOAsQ0m3vZsq6s2sTFuT4w4ivmPCrfQEiMBJChS3eRi4UP4HHH?=
 =?us-ascii?Q?RLjlbcpZ4Yt4QSHUkR0GzOmap+/NnB0KVw+PoenmDSu5LxBrCYnKOTLcDU+5?=
 =?us-ascii?Q?eExgWIzgtd5VrOefhwBt7MgJFCaXXmEQbzGHcsGl1E3QAWru9UP+uN5xYLY0?=
 =?us-ascii?Q?XEyxsg9T8TO8oaPsPgO2zn6q7Hwxv6RDM6DQWy+oYUanbf/Hmg/LUKKaF2ha?=
 =?us-ascii?Q?H/VASQWOtknAUWky0i+MqQ0Rw0sV1nXxtnPvu+ZEIuYbEZ/i6gfzSFFL7o/w?=
 =?us-ascii?Q?9QbpdyexNzHaNFEfaqaCfM+dAfaWSF5IbOjeVA8dDuLuWuKJidqstO1e/DjF?=
 =?us-ascii?Q?E5qV4pEQdJwbBTVT9ndkCt1Ml/phPz2rOAKHvewoOtYp7ZX0dySrnJXobzNc?=
 =?us-ascii?Q?NwR1l4QK8YTmW6bZO8MyuY5n5uUuUlHoyNXhGIUwTbfCskWRWiiY0Fi8prDH?=
 =?us-ascii?Q?C1J1V3uhvoh2PtSPKkjDwV1t5cLrj4uIQ4f2czl9Nr92VNQjz5xb7Q0CQnAU?=
 =?us-ascii?Q?MnazWSJ/CurtEqcqFPVIRMI41A14fJ4EjuUrVY9BPJQLeVcVnS/np2WxRIes?=
 =?us-ascii?Q?B6vBRFhYmrMRFiBKOZmzGopuwU6JtUo7a/byKXxPDNrvjXP3M+9OWVsXhIH4?=
 =?us-ascii?Q?uARatI1ki6u4osLL1Tta6gH9UTGGzAwJNG562RN9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277b16ba-5f5b-44e9-ca3b-08ddde22675e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:42:30.3243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJHfcG87AUK6E8wsLlIJzBC3m+hDio0PQn3MFr85K9aSVqncK+SfbQHj8/n5vFwRaFUyZXB6kqo0f77I0p4+GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7157

Some simple if-else logic can be simplified using the ! operator to improve
code readability.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
index d0e299803225..164ee0fde03b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
@@ -1803,10 +1803,7 @@ static void _dpk_onoff(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, bool o
 
 	val = dpk->is_dpk_enable && !off && dpk->bp[path][kidx].path_ok;
 
-	if (off)
-		off_reverse = false;
-	else
-		off_reverse = true;
+	off_reverse = !off;
 
 	val = dpk->is_dpk_enable & off_reverse & dpk->bp[path][kidx].path_ok;
 
-- 
2.34.1


