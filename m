Return-Path: <linux-wireless+bounces-25014-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C54E5AFDD71
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 04:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A354E515D
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 02:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C276A211706;
	Wed,  9 Jul 2025 02:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="gb4GaRSO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012029.outbound.protection.outlook.com [52.101.126.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF581A2643;
	Wed,  9 Jul 2025 02:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752027850; cv=fail; b=kM3oKl1l+rINM/Qgs8P4wPQa2eiAT4KazTNmKSNRfI82jF0Ivfyx+Lui00Uy8GOt8J6xRQDR+yVoC2n69Qd3LEY8u6LsjB4NgaM9PPSpwmzLIyx8sB2iK0jQ+jYRzrZDCZpv8AQRFZFhcyFWwzXH8/89BB/Yvg1EGhCB5zSWevA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752027850; c=relaxed/simple;
	bh=MJUS3A6W06bfA+gY+6o/O0kTnOTnBFIVJAuCa7VNrAw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VirO48AEF4tLW8RLi133KPT/OJPAto1LPTau5bQDMP1W2zb/zpuZBmOHjTHUCdAyZso1pRfwKcpLPMJ/oTAoSRP+ZKUP9XbVVMAI8vZY18GHmgefMp5LHlGgDGCcWwQ8XCekoHRci2lbPswJZAr29zIp6cZYsUB+vnfmlNZVdtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=gb4GaRSO; arc=fail smtp.client-ip=52.101.126.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FB2Lhb6Z0fy70AnI533wF5co9Ec3Bmw16yXPxuxI7r3/i389usTDXg8qwEqI36SlbYFF3Wd35SWf4m2OX0TfadY17lgVHtNNQAaH+xTtIhh3I7Sae3aulcSNZf2aCCpjMoDwXsHfq2JyXKG508De6b9qVMBxC5eDdHhjk7IgfwhvoJIpyYO06KbsNG2IOBUTMJ+9TsDvHVQ0RMZAdJiUW5rl9upCQwz4g1XctfhDj5qk3LuLIMTAICjRt6VYW4mN9PwmGG1q2SKyCxNXDJ/oXiSW3B8HSdH/HyfN/Lg8jP2s+YpUs+d+U92d8GDWQ83iTx+q8cTVlcjm7Z8p6psJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSCABJuvY14tZsZj9Oh5SSy+SQc7jAPXQUglhSbksAQ=;
 b=T3giPVfeMlv9V+pb7Ggy8T+CeLxuZMyXyOfV3PswqvSqtnQstWyAMka4uKERpEbfzazNuZ43MB/BGLH5RSEqTUOKrCzfWKIki/8P/uFLWcLB7AyebxcJc4T0xGbdKOu6Wkfcdq3f21mf3r6Bnq0yTYLV1IDpLyukEyYiv3q5n4cKeht6zhAKfhqiZzVbsgMACunU44pR1EWPbdJff/RGEwOVVi2MHhMfSLi6MhXEi7xMYn67yIT5wPt6sKk/LZBgWHkv0BPARKHwV3kvcpJgcX+prJbt3KQBVX3Tj7ue20c4+/3/s3DAQ0fzpBO0VVSpFsnHCgcw2DCnoWCTmqzJNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSCABJuvY14tZsZj9Oh5SSy+SQc7jAPXQUglhSbksAQ=;
 b=gb4GaRSOb8t/PHBytYc6rQsCras7tNZnCq6XsaFkzZ4fL76CrvpzlS8PXWVSH61puCcaJ/0RmY0KxM15zgqOND688UyO7a3ylnyHfB3XQbtXMy9rYmxxJc8wFNx+bDIyJ/anmcDlkNSbfl80OKwFPfPcWARCeStggfr00jx3evsEE/qiTq8ZQ3Bmic9+EvyJjEljqHZfpM9tYjc9F0QWyAg0qrhyF5IVXEriNfxPse4WvKnF6oGGRaAD5xpNAcgHGb1JQv0qXE02os5tQ3ho5OzJ0s4TU0VsQIHgJ2ZvobfH17i2beLCc04/XGn7svw8npc44PbISSeo95EH9J6FgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB6156.apcprd06.prod.outlook.com (2603:1096:101:de::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.25; Wed, 9 Jul 2025 02:24:06 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Wed, 9 Jul 2025
 02:24:06 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kalle Valo <kvalo@kernel.org>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Marek Vasut <marex@denx.de>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	linux-wireless@vger.kernel.org (open list:MICROCHIP WILC1000 WIFI DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 11/12] wifi: wilc1000: Use min() to improve code
Date: Wed,  9 Jul 2025 10:21:39 +0800
Message-Id: <20250709022210.304030-12-rongqianfeng@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 30866fba-8eb7-4769-c5c8-08ddbe8fadfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fv5dUxnSF8jD2FcgsBfk6Vr42XxT53O4qWyUpO93+wgvoNFXt2wwPChnmWRJ?=
 =?us-ascii?Q?BqCBjBJ4x5EtI2GfXKIY4+Aykrfpw3jzjaRMpBKY9nB9RYHWdzxUKjWF8WCz?=
 =?us-ascii?Q?u9WWGuoH/Net6+o8SGkcTK9woc3MqVWqFvd1zeO26Gjr3p2ohdvKFxN5+h6l?=
 =?us-ascii?Q?JsnA+nJTeBjHyYANtFoUpHnfHRE9+8B6rHtrreWRVCsqmgy8rEt0l8IzAFSH?=
 =?us-ascii?Q?rjUfVaE7NkoRO3gjZ9v9nXCxJEv7xCgGhZJAILOpr3qhSEcAj0jpj3SLHBf/?=
 =?us-ascii?Q?+EnpVtaD5CsxUmAjj4ZbggLgmqsiJnunTQXqogQ1ya2eJftNaKRON+cQEedz?=
 =?us-ascii?Q?Iq9Y3euFe79D3D72Oj/v8BASNYMaCrF0egA5wdbzteVzKaX+DJXisVb+VDwm?=
 =?us-ascii?Q?jjtDUAFXo4mXN2cxKPZzf9Y1pjlf3SGZgLbwMIdxF71Mhg74rVP1KwjdGrlD?=
 =?us-ascii?Q?usYvouIVodWuKRRWqexzU7mq5kHtkz0K7kS1dqHh+u3Lro276jKi1tn40TiE?=
 =?us-ascii?Q?akFbKFfgyUtGFanUY4olLw4iO+l9/q5PIDwvhs9wzsj4zFamjEGdX5z65jxU?=
 =?us-ascii?Q?QCd04+Vlb3EjXzt2m8Ymy+Do6/xyaBBilz1JukenPx3tvD7JaUOaTSyhYZ+F?=
 =?us-ascii?Q?6nDF5rDQNeQb3jtZkXk8l3/FOEzmYHPzai8tfhE1T4ZVwi9MNFYjKcx78CYk?=
 =?us-ascii?Q?InTx3x7lc0GGxeR+2KMfysdJh2RRA0/Yfx0PjEiMekVAoUiivC3uzZQyqjkG?=
 =?us-ascii?Q?znuS2zJBTNc7FaaCRnK/xlpfRyA9YbM86xHSx0X7fuuBjm2ytAylQF9gnJF0?=
 =?us-ascii?Q?rOcs74urBKyAaNMvwo5/jGxoLIfCojoiMI9td1quDqCn0ZqOfWmrkrJAJuHd?=
 =?us-ascii?Q?IqPhpcaPmHwFMj3yGIQgLkNZb+eiSPQaJn7hdva5hXtc8eeaef/ZJ+1rF3ad?=
 =?us-ascii?Q?dvPE+Ppsf243Em9/k86XVpx+2oSVEUT7vtrq3QuaQirXm5soAv817qsg6lUm?=
 =?us-ascii?Q?shMbS41y7qRtGNY5y1J6Th1DxS+XWFKexpFRfa4R2C+d2rhjv0Kx918joNix?=
 =?us-ascii?Q?aPRyBt03DLZwCxnHlVbaKYmTDL4yXYO7KS5r8EkQxG8meojbZR/Z2qCuw3Ey?=
 =?us-ascii?Q?UdAB9iJpQ5F9t53//y0UCqy06RfDoij9V3t2r58fF9hwzk9hJgWQzrEr/NK5?=
 =?us-ascii?Q?yIboqJa3UykvJiLJSngl7ExGTuIsonawyHYpJc7tptvhzDMFsPHRujcN+Trh?=
 =?us-ascii?Q?yEBcQvq5BbZ5VE5caSQUpRCfZc4M/wzwD2Mr/iO2dW0WdoIogzLY7vQ1h9xb?=
 =?us-ascii?Q?q91CYzw9sC0OAmqYsr9qPSIvaG4ixlywDgdLSOM9SY/NI5LgGeQxhd8axATH?=
 =?us-ascii?Q?BEforN23gRv6YNYL5CuFDLz+FoJlaA0iO0AGO3ZX0KXncIYLk16kf/DE7FUI?=
 =?us-ascii?Q?T/Hb+bFqVfji7Jxt3mr17OXXVs8hhxmwVTpViBHL99pDVmjP0rSzgQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?84vFGME8iHpCPl6lXZ7vCapSxuLWPJJkyy3MSkJQe74yofIQUIUKPZFHF4XE?=
 =?us-ascii?Q?4M9nQlp0O/iQtHhw8RZY4S9OL38SQnuQbe54sHoqGeso+KcbxAShVFAOg+IM?=
 =?us-ascii?Q?3KrafEZOxewt0ztrl/5xEK+uMUvrEPARcpnQPI83HHEvBHnWsIv2K+QY5POI?=
 =?us-ascii?Q?ibCdAS8R6Qs6CEaYc0OGzEEIXAfBt57adF50a0FlqFdk2H9S3OfcDkvMOHj8?=
 =?us-ascii?Q?wzLlkamztP4/OEpxuNT2I8pDQ9ulKp6OZYqo9EL/+90xM7RsNw6aXFD/Tc7q?=
 =?us-ascii?Q?l1wCwpJ/ofF2S2xQGR+GxMX/5Km65wGPEwXaUheRMejMCwD9w52ve/BcQq54?=
 =?us-ascii?Q?Wxmry8bxYQXNBN1+lRjPSvZgGdGMY0GN9ic+464HDcTaMTrGvozRqj/IxMUN?=
 =?us-ascii?Q?r7SAQ5CvM8ZYf8A10QoJU8V3eMtxBN3PuS+QqPAMKhuN2ML7eyV4WLhEDeVh?=
 =?us-ascii?Q?DgntvA70+Uc13o/R7+w36bL1Xr1hhVOBAbtFbooO6pDlsv7tUAbK0tncp4zI?=
 =?us-ascii?Q?WW6DOUgIJ5YwS3uyfTXqnsuDSFEj1DFvpsFoCubAQYsQE2aRBaXWtHylsKPc?=
 =?us-ascii?Q?6OIR9CLVcDuZO7wbuzNDIJDStK+Ou2nK563740QqnuxxB0J7/jnTqzj/u+oH?=
 =?us-ascii?Q?DMv6v4Ega3Ko0gJvOLGOKCkXjerPc/BXKEpUxbpEQifzfm8bM7MMGB8VMP47?=
 =?us-ascii?Q?2F3+uOsCQI8Uly4OogGU2jEcWwq1kdEy8rkZ2GIpaFfr5xMEjQy55xRn+M1G?=
 =?us-ascii?Q?oGQri3ebfiExEd8t/eRcd/Ult+2dCwOW9jMsYhqtnp2lNxRDuD3XAtV3Sgr4?=
 =?us-ascii?Q?xJhnYsLPFznY4AYlwLxFlzdIgmy4dOy06VN+1BRfzOSb2jBCDtIMGckYsB2c?=
 =?us-ascii?Q?hXQX6IQPoSOFDkQDE3fwOIukMjHzN34jyUNTUq5GqSaj4IGI5T5YhUzmm84j?=
 =?us-ascii?Q?SLuDor7/vahcf/RV1zf4C4y3/oOmaPNa0RJvm1X1vi8Y5ApB+ibv1or+e+SE?=
 =?us-ascii?Q?4oGmHgFnZoHKwTrPjGxjjeiMDhi5F9ulyrfB5N9hYIf1kaacFXYRrzY00KPK?=
 =?us-ascii?Q?Q+PAHmxwCQ4BIUhWCC0QLibgGfJfLHWOy0FaSVhc0aKhxZx5ZDRzCSwp4HQi?=
 =?us-ascii?Q?gNrN8S/P8z6RZxGDxFanZ5qS0Zvv0VfqyWiI5Ksprmh38+lnqFQ+rIAVW6ib?=
 =?us-ascii?Q?A+A0I2tJ9jCpOeOa3cTD4LevdxdLx7t/56TYN2YXcXnINYKoyc5ALdhDwyGL?=
 =?us-ascii?Q?7eivpFiFV6aJtrN150D3roWxUWkHbqqt35K5jGm6fiYKYD/vGq6gT67U+xqq?=
 =?us-ascii?Q?tgam57871TxDJTGjMltOm8NOYC+KEe92nQCjlf/3hizyXwmHKweZDeBHXKNS?=
 =?us-ascii?Q?Wv+gL09wfFkU+SW3l5tv9BJUgBFi5ckUKE/FecckdqJjqpx3vEoaPc3ZixRy?=
 =?us-ascii?Q?PyvNM1CV0TqR3xYN8AmswQdlpFI4E1ATA2UbR03uZBPJbdftLg+mT8coTHmD?=
 =?us-ascii?Q?tkVrXswLVJ56zkxyOgs3ZJm4xu2NmmWzSTj7Ilj+EgxWPcBm+FbPNpYMX1Vw?=
 =?us-ascii?Q?YFGew5Qd7/30ixwoNZnJi1jMjq1N8aPF0spMUdhv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30866fba-8eb7-4769-c5c8-08ddbe8fadfd
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 02:24:06.6972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIipA8AKerSSgf6iHho8au70qvFMTbx3+GahhW724UhHbFhB376ULIdS1PgZsPjyrIfm5rFmlhG1NLJLoWby7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6156

Use min() to reduce the code and improve its readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/wireless/microchip/wilc1000/wlan.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 9d80adc45d6b..fedc7d59216a 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1287,10 +1287,7 @@ int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
 
 		offset += 8;
 		while (((int)size) && (offset < buffer_size)) {
-			if (size <= blksz)
-				size2 = size;
-			else
-				size2 = blksz;
+			size2 = min(size, blksz);
 
 			memcpy(dma_buffer, &buffer[offset], size2);
 			ret = wilc->hif_func->hif_block_tx(wilc, addr,
-- 
2.34.1


