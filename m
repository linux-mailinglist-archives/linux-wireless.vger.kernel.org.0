Return-Path: <linux-wireless+bounces-21394-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC15A84865
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 17:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AB73A2C23
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 15:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D993D1EEA23;
	Thu, 10 Apr 2025 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-sbell.com header.i=@nokia-sbell.com header.b="Q9pEWYiD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2086.outbound.protection.outlook.com [40.107.247.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9351F03C5;
	Thu, 10 Apr 2025 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300001; cv=fail; b=SSwzvxSATMsvMJLPmmIEbtL5CP5zIMBbLjMqiRh9CCg4B9TTndMwh9ZUUNqOTvFAszp3GQEa1vaHOfO5j/cSQqbSwMxWUb48se2KiQAIjSBFaw+YdyqWBBg6Wpjk8Hvho+b4p1teps2PfUP7EuyomPtZM8ggCfEcopaM0cpXlWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300001; c=relaxed/simple;
	bh=fZu2wF8EglKpzI4T8z657YhK9TK2fB1bukBQsfPI/j8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MImuH36g1q5J8/DLoIADfi/52+PY09SJyUpbd/Tdd9xsY43SWTHGqb1oCjwBJzpWKzFM0dqEqv3t/1b3xtHQqSl4IcnP2v2QDlJX1NWsDQ1G9oeiTP09z7R5YuPNu8hREUHms/mQg2ISV3c+aEJg+AIWYRCIwu4EmL0XjzhkEj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nokia-sbell.com; spf=pass smtp.mailfrom=nokia-sbell.com; dkim=pass (2048-bit key) header.d=nokia-sbell.com header.i=@nokia-sbell.com header.b=Q9pEWYiD; arc=fail smtp.client-ip=40.107.247.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nokia-sbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nokia-sbell.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHU/VYMsCwWyltyfl8d/u/Tv4WNfrKnquzcFPRlbgxTY3ZAKUYwq6yNnjMdz7WFeOiB1ZCzR180i3nEXK7oDsbbgUdr1B5mm1rQcoGzDC5IFHB4rFi2+PewbYMel8+nWHF3LxMCcRVzYI6LREieGSHHyqnNHZY1iMJNXfu2hzJ9QyVKdUB7VKlnAzFJxVuGFxfLYLaTv6d6YmEy00eZ3UrFU+ZaD/4Fd+Ix6mUR8DS2RlDV7hjQ4fIcmorQyF3Bj04r5idcryCoDJNcLpUv6v7ggZrgjs2aKJawifMGtDXLq7kVz5QdYqs25qfv/aAylsQIvzuKwkhzpBwYdlG3Y0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lcYj/0aoDh1JYnF8nsCYBs89Jh34d9QTKZVIUdE5zw=;
 b=A5Dwe/xLifZdw6K/CQrx4XhU+37IqEf51ViO6BGe+tpCLgd6L24vbDGxsbOYl9D/1+3N1Rz8AQch5ui1zALK9R+aYiCMVyD9RUhYXRByoJkUrdLHgIHElcz3Al9mcAyC8MpOxlAEGQN7CbEI04J4UjCnc9PYggXaKDNjKzGRrXtR5SZlDJo5PYzPvBV58/UqZyrvVkarPNeUaZoMMYxiU25ZiaJJBUkGJxuf7HrwBgxIsSWMQcFDzgGQwCVQK7lIhZDSDCTWP/Z/kIH8HtXggd4mdvSnKDpvfiR/bnetrMHD0DJrUoOn0TXkmldDfPWa789nShMLgxrZON66pVi3Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lcYj/0aoDh1JYnF8nsCYBs89Jh34d9QTKZVIUdE5zw=;
 b=Q9pEWYiDrjZvCgSZKgNPS/xXhF7t5mdO77MCib5P4CK48NBHzTIjhW9wqtFBVJ/eeOox0M4WmVceB74gXic2Aws6kYcJ+78bcC7LSfM/jnjuDoggGEgN9DPv9oWiPXlAZumymQbTJSP+ABfhiigFJOnCKri9w1T4JD3e7xLunyr09U5g7QaDhwvA9eUX3pgYZiMV872/61b7kGorlx0iptD5ngUeegQsdx7L4sLQUdUaZ+ZQfkqTZW4pso//+7z0hmJYCeaVLFNkXZjdqNh6AlGNUIiZK2p3Kcr6i/l1RAd120t5jRvNz0RS/DVJt4iPw5QzQW7wnQbQSXN9EFzJZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from DBBPR07MB7481.eurprd07.prod.outlook.com (2603:10a6:10:1f0::11)
 by PA1PR07MB10210.eurprd07.prod.outlook.com (2603:10a6:102:491::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 15:46:35 +0000
Received: from DBBPR07MB7481.eurprd07.prod.outlook.com
 ([fe80::884b:f4bb:e97b:b9d5]) by DBBPR07MB7481.eurprd07.prod.outlook.com
 ([fe80::884b:f4bb:e97b:b9d5%5]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 15:46:35 +0000
From: Zhen XIN <zhen.xin@nokia-sbell.com>
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	linux-kernel@vger.kernel.org,
	martin.blumenstingl@googlemail.com,
	Zhen XIN <zhen.xin@nokia-sbell.com>
Subject: [PATCH -v2 2/2] wifi: rtw88: sdio: map mgmt frames to queue TX_DESC_QSEL_MGMT
Date: Thu, 10 Apr 2025 15:42:17 +0000
Message-Id: <20250410154217.1849977-3-zhen.xin@nokia-sbell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250410154217.1849977-1-zhen.xin@nokia-sbell.com>
References: <20250410154217.1849977-1-zhen.xin@nokia-sbell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To DBBPR07MB7481.eurprd07.prod.outlook.com
 (2603:10a6:10:1f0::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR07MB7481:EE_|PA1PR07MB10210:EE_
X-MS-Office365-Filtering-Correlation-Id: c1eb3372-8732-4917-498c-08dd7846dff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nn15X5NI8vTZwxSnUvKkS7YQG6UsOxEyFhxl+hBvhv82T2Hz9a8NVxaxVm8y?=
 =?us-ascii?Q?qEwkNF0yMzhmKtqt5IqhQ9I9VQfPabbmecZZ3OHr0fPAfTzbksvj7G1+j8qu?=
 =?us-ascii?Q?QVrgJWvlrRWuYCzDtWTnUrvmThvkqCSUIgsz6MPzlrFwVakiSF6owJEDaOQQ?=
 =?us-ascii?Q?9PqZ5MQLphUXiXtUlLL2h1SABtTJvHIla1Wz5YrWHn6PvuXV1rhtau0VDpQf?=
 =?us-ascii?Q?k6UdcaCuTjsPs4Dh34Q1n6PGqd3+mOKiPB/H5A4oN+3bPkak6uYEu8LHqpJt?=
 =?us-ascii?Q?jRkAsHa7FscXvOMWC0QyhdZDNvBZjgJtfViTBKTRoQq26bTVe9R5fR6YyzIf?=
 =?us-ascii?Q?wkTBmKAWn7ehsRuIIBCTdWKy4RiipXF/XvqKE9e5ICBgGjoItDwDOaxWvYDh?=
 =?us-ascii?Q?jjSFBdSuyAQQb8wtNZURNUGg++2t04I6RfWZmMMzYFQybuoHR4Nv4dG9paOf?=
 =?us-ascii?Q?i/GJMI+Q1KYJ6tDpG2kyY/qragbQ50Kz+lSoZ6hkettJaC4OsThgz5lIkg+B?=
 =?us-ascii?Q?XLgqrOID/ecwjvAnp16jxKKwcvxC6p4KajBQi+I8ZNkbdVm+tdh7IEuBBd2l?=
 =?us-ascii?Q?2S66YYZGbLgaRExfrc0gJr9rgAELdGt0djXp9KMvweulDUu7jNzwgTH3ZgCX?=
 =?us-ascii?Q?fqZJ3ntFVjWy5z1ssBTk0rN47r+JRMuUsgKhyrxEAeuYuLHIcAfHTXbOEM0Y?=
 =?us-ascii?Q?vQXDxFTbgqzIW2Svun4ceTs6ZWPDKreu1qwDtGJtIfvw0IV9kxvNzJj5/1Cx?=
 =?us-ascii?Q?iQ6OgVylYuD3pQMycGgzqQDLTwgPHI0MhDY0T2ZG1lGcKeVImybb9NwTWm8Q?=
 =?us-ascii?Q?N7ndVjdqwZM84iUaMuIn/KzixyR8q9scU7NHm/UIyT7rUvfXHmpyxc4y+MiP?=
 =?us-ascii?Q?gxD/vG/Ap86kgcxU/Za3VUABLBqmj5TsVaco2weBB5E1irFe5L58eb+4IS6W?=
 =?us-ascii?Q?djidL4mdNE+RTCYOJllF7HMwWpjYssGdveUWYU4BJeTW/6nDukE2KLIRghur?=
 =?us-ascii?Q?x1phQig6rBaXRK/RDar7kFGUQLKfrcrurq3AC1VvjUFatRupZOmXNV7Vhykz?=
 =?us-ascii?Q?buXXgRyZVXFY5frG/SVTE+zTy6HnrD7cp7DOFkIUuWBUdqwmhXQnCu92uL4a?=
 =?us-ascii?Q?cOpCLrwFo8qS/DWeiONxZ+d6e4/GsmWWYRDLg4d25XXaNJ4HUfAABCikxbGq?=
 =?us-ascii?Q?c+VkIzz7JhEc3r4vGiGOqiBVxzKXn0zjI66HO8MikvPUjYu/Y+gieFjxuLyj?=
 =?us-ascii?Q?Mg0iq7WdRhM5/fUSqiFePJPMoxEx8+v9LOCsLjgWdgGMTBQeoZJ6dV3Ge4xm?=
 =?us-ascii?Q?IgK7iScvgcHFO/In1coK2Kz0Gss/3+LkP96MU7OINq3Q5vp7yGwlDnxYuEtX?=
 =?us-ascii?Q?XroGV4uWHUe+Pl3PFBgYpOT1hvCLTw0GHGlftOqZkd+Ob25CAYZGLIIk4avk?=
 =?us-ascii?Q?aS8onGFNuhQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR07MB7481.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8/+M9tMuSjPqrL9YHNs2lHL9Ch4eGDpy5wMDX1/bgOt+mVJ7cTjquveodXyH?=
 =?us-ascii?Q?00rirEml6SCrzDod2nQw1HFvUcIomoB+JPJvyUeyZ842jo1jogEGfbbs8QEW?=
 =?us-ascii?Q?tLlRX88LcKB2Rp8XzWPvEdkif0WdOc7/oHctMyQVOEFvltLBAzqk9rKlNAbo?=
 =?us-ascii?Q?qbcPk9nQy+hlO+YVi61S2/Saou2d/vtC829GLdJJi6UQhIbanFD1RQ2w36S3?=
 =?us-ascii?Q?CVr19+aIMezVduSBeEYy37GGPlrtKpgoZ4ReEZUiqH8zIiHTzzhQqWTSYNyz?=
 =?us-ascii?Q?PGxWmzNg8OO87j9+YWzNOyvENNOQW7vI+Va4CImMHjIWvY68H3bP9gMbl02p?=
 =?us-ascii?Q?yMlp3Ve4QNwju25NQZI4JNifGSnrfBwVzesZxd7oOkW9cbvySS4NTWV94tdR?=
 =?us-ascii?Q?r/xAooOFIPKdmww9A3gq0QeNTNGd6DToNzT12ye3ryFphah2VKys2c1bsEws?=
 =?us-ascii?Q?5xTT5zTiVFOlWfSD13sVUaObpnCJVHicyfv4rtMmMRdF8XBGpu7IiBAFxD12?=
 =?us-ascii?Q?7q0Rz/DgtX3ddzR3nJS9CE8FcCzi56xayeDY2KC5PkXfG+zQLIQSKEKZlpk6?=
 =?us-ascii?Q?jU85NEo0pqGUiMJsisAT5XhpbcqomWbwR7hJDhEejIioTbmwGM9r7WLnnQ2n?=
 =?us-ascii?Q?8s/2g4CnPI3e79hqMpo894E2EXfBqTMe//kl7mkKCssr+ZklM8EAZX+OOpsY?=
 =?us-ascii?Q?hQpfjGEZXsx0A0m/PzgCas54Innhrzc9IheTmv95/UVuZWKxJf7ZiCPWEQIh?=
 =?us-ascii?Q?SAEX9ykNnjB2QeBOuwOueYv/eFbAw6QoBau5trcBIG4b8UO2sScx+JVK9+H+?=
 =?us-ascii?Q?vvBubwWlxBgaOTF3plfmUALLoNZ6Tk/MVHV76TieXRU/oKrXXOuSqvOza0g8?=
 =?us-ascii?Q?Ts1f9bRvXUUbFTdBrk6LQdo4ApymEIkWyyJAxAYnk2HlULI08yDAtfIcezoG?=
 =?us-ascii?Q?y7JNDU8YztpCRjhpaWG88j/YgUSuZrbJFe09sZ29qL0+Gvt88zl1AJV/6+bI?=
 =?us-ascii?Q?ucNYm4UFb8Rn7CfF4Ikb7OFw+dQcWo0qfpBhCgYXZ+wzDLmXoykws2lRisCf?=
 =?us-ascii?Q?kA0l026fumna7PKS3USc9K+Sbd+F71QITklc9GY42O3X/GKU339ZVGpBuIK1?=
 =?us-ascii?Q?frLEF4JKNAGQxOpAC66VyBlW+NVZTkt4CMIByCDtijL2vvBCpFXQagqgT8Z5?=
 =?us-ascii?Q?5KXJ8fM+yZFv4RBaLF2g8sTZdZ60DHe0nafhRpTVaxaWpbISaqghwM2S8U+o?=
 =?us-ascii?Q?zSnJnHDLgbV5OG+vSwuFDcLUZWxtZX55xdLpVCvHZAtATt1VbbJHxWlR6XVq?=
 =?us-ascii?Q?FtF+8zl/V2tq8ERrLULO1ShFlfDVoDLs2tAe3JC3Hqnht2igNAaL46LrbDHH?=
 =?us-ascii?Q?Z+/R6Fs4RdQBbdhRvwNT4n3i1WDOyJnjRAZRRF+83f4WZm8/RmiQG3ALmI/s?=
 =?us-ascii?Q?+wDhWAJI9it8WTTe79Q3dtchb5KE5SjcWnWQ3QbqrfytlxNkRp9PJSh3HQ0k?=
 =?us-ascii?Q?5qTPQBUGNIW7b0HrdqknCTVYTdGsOUK/Lr5xUqrV3bNI/n0dsxXZyPDEtgBA?=
 =?us-ascii?Q?BoEQYfzABHvr4Y+fNb+FEP/kp7jxWptlA8hTx+LqBVrKRxIhMuHvM6b/Cyrx?=
 =?us-ascii?Q?7Q=3D=3D?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1eb3372-8732-4917-498c-08dd7846dff2
X-MS-Exchange-CrossTenant-AuthSource: DBBPR07MB7481.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 15:46:35.7553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpJKg4zAMKcuke78k5uIqBZ8kP6UtsqZzCH0k7WBGTXVfbdhM5N7F4gTXpbLiKRr128rYe49q7/SZl246OOzcM4vHmR0ddWUlTJq9zm94/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB10210

Rtw88-sdio do not work in AP mode due to the lack of tx status report for
management frames.

Map the management frames to queue TX_DESC_QSEL_MGMT, which enables the
chip to generate TX reports for these frames

Tested-on: rtl8723ds

Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
Signed-off-by: Zhen XIN <zhen.xin@nokia-sbell.com>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index ef51128a4b44..4311eb7cffef 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -718,10 +718,7 @@ static u8 rtw_sdio_get_tx_qsel(struct rtw_dev *rtwdev, struct sk_buff *skb,
 	case RTW_TX_QUEUE_H2C:
 		return TX_DESC_QSEL_H2C;
 	case RTW_TX_QUEUE_MGMT:
-		if (rtw_chip_wcpu_11n(rtwdev))
-			return TX_DESC_QSEL_HIGH;
-		else
-			return TX_DESC_QSEL_MGMT;
+		return TX_DESC_QSEL_MGMT;
 	case RTW_TX_QUEUE_HI0:
 		return TX_DESC_QSEL_HIGH;
 	default:
-- 
2.25.1


