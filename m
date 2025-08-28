Return-Path: <linux-wireless+bounces-26746-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4BFB398B4
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 11:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0D63B9E3E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 09:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75F62BE7A5;
	Thu, 28 Aug 2025 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hyibHjLa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012049.outbound.protection.outlook.com [52.101.126.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12C52E1C6B;
	Thu, 28 Aug 2025 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374452; cv=fail; b=rHW6CEDTlRQlLv6OVjrIsOJ2TzGKeNfMOCe25O7FfkOmyjP8yQ3kUojHgVJHJ5VBVyYR34NcghpAGnj6gOURjc/S1QNBI3TTYQgJEriUBQWleVjN2mwNVGF8QFgwBc7fyH0aMJb/z5jphFK5li/BCPOMs6NTAN+F1rSJr56y9m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374452; c=relaxed/simple;
	bh=IM/PmfLkcT7HgrT3N38DBcwYMlRwP/KNV3xNYAe+FhM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ej5JWBTnxYnJv6IIAirMgibZLO7J1VW8gp2gtLdGVAn+9kgru85S3waTG9sdqdikekCxbA21AGDqn6+MBzwnm37wYfTMQMoAvZKUlawy0xa5JiFf0uTaeizWr4ff/0RPHfK8DcCrqTr+wdmQvSOSqhGBY4YOmprBuhj0V99zJQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hyibHjLa; arc=fail smtp.client-ip=52.101.126.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftJU4JGv7nCxoCMDE31OlgHNTvvO0Ry+DHQP+KLgPAEYVmTcIfXKSL/2lH3+zBMY0/IgKIZgqjPJPEAfFABN5bcoVWdJc2wmN8+DcQZSF29Nq9KfTsHkUxIlE5lqPGAbcBuGpZT4UUG4GXqJaAt17477fDqF33vdM4Am+f1qckxXP53/L6Sn2VpSBQ6HflebVRSWl5LprIMFJgWitmfZ9GYfKcsB63vTSxlyp+bkb2WhSQV/M5tXXxOnKWBEZ1obKNYbAjlcMXXoo6ViczhxI/CnbBWdqG0Mq2AKfFiqUxkF4WB6uP4ra0pS/VbATgN56drS2s6hqVwpALoTh0L8vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGOuy1wmmYIr6dp80T2sm3IMbWN6H1GsVBJFX5l5s20=;
 b=AgOqkvR3sScIOuNUWhDWTKD/MbYlE1hMndyy2Aawb+XdV5xl5AQFkY9+yDFfcgnkN73C5x7caHFqdWUuMSexP2rJZ8hYZUBeDJLXWdo9CPmaBqcqR0zhhrejzNedIhE65Z49aUfY6GMugKdxhRab8Leg4/NnLQ/R7rSGC+36h8PCY8NyfjNCfVCFcAwHqQsc+8CMGJz/2mBz2YmArrK7eBtI28IXa2L+hfwKUMX3JqlBD+HnS41flLxLDdB2zk6BTAKuwfl3tVxeRmX5jm1454cdr6Ie7geJFYhKrEB10lr7etQ+6L5BTrP5yc49818r0nZZ5za+znNGravH9kaZQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGOuy1wmmYIr6dp80T2sm3IMbWN6H1GsVBJFX5l5s20=;
 b=hyibHjLaDgqBqjjgPMEcoo4URVZQXlfhgB4ZKcAsYWr2ZnY2rmAdMrG7fYGpr6uNRi53Z3q+KEBzU7ZlAkzIOw1HL0ob6qp4VkZTpxl4A4TzdiBueUK2whfLTVV2h0G5Cukf4XhD5ugrTrzDX1nw9B9JNd6ITfewkfkiDXI2ibrItea/j8ieBfns88M9ZOb6gzQIELHu3Ub7bNtjfl2m4af+M9qJVmNrcvG/ZoGMcNU5TKaxx1GWlk0DzEAgCS+xFjv+Tm5uWo+McJh7g0C9QbfFuHyIl6sKwQjILaoulDrvFQgWz7+4KxPiQQQnwOmWYWpT7KFeTDZ3QfPgq8DcEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SI6PR06MB7220.apcprd06.prod.outlook.com (2603:1096:4:24a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 09:47:28 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9073.014; Thu, 28 Aug 2025
 09:47:27 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org (open list:REALTEK WIRELESS DRIVER (rtw89)),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH rtw-next v2] wifi: rtw89: 8852bt: Remove redundant off_reverse variables
Date: Thu, 28 Aug 2025 17:47:17 +0800
Message-Id: <20250828094717.599527-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SI6PR06MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 305d2239-9eda-40d7-8133-08dde617e614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4ejIXzHuVCXAozjjH2zTukfJiB3Tihg5LWdw0xFcZDwGJWPvToJUi8YTD78x?=
 =?us-ascii?Q?QUhelu5LqmfnLOTdRzeML6dEt7EwpY9zOfilUU9HNSVSiOA4uVW5bb2qxhx5?=
 =?us-ascii?Q?aDcdmGR74tzjCenCwt3wZYAparZeXQaLeflweTe8apDqAhIIswGaSmLd0HF+?=
 =?us-ascii?Q?HeEHVybtkPYtI7HuWGeA6aFD7R/DmSYduDK+OXzy47GLSqddONHXGPj5Uoyl?=
 =?us-ascii?Q?Tq+DEaj/Wlue2p/HdiGEmX8RxogxK1SKUfHLdBvbMl0IBE9X93pIpmc7TxEE?=
 =?us-ascii?Q?R2VJTV1YJXS+99CuJkne2bSZ7+LdvNbICW6Uu0xeK9HJzJXSypgMn9lXGO4i?=
 =?us-ascii?Q?TTBCwOWqSvdGBwdT/faynHo0Wd9Fdnk2HWQ4SlMwzNJsBheqI6X3IcnjGcLe?=
 =?us-ascii?Q?/ebdXuc7Rh1pxOslMcH703NSlluQXpNFgRG4Mq1UciqPaM1dnIyL6i70LLSt?=
 =?us-ascii?Q?HQuqO7vh4n1N2D/RLrE/YcQPrTmDIFXEsSlHe6SmVMcF6cfs5AIyu+0zCT/X?=
 =?us-ascii?Q?cNvoCJxUPjWvd3+66UH4L7qnuoE9teNYok4rmoBs+CwguQsQkLb/UY1uqxRk?=
 =?us-ascii?Q?b1PDL/5/Ru0GrwmYb18Gujz13xWJe+umzTSKuFTGJLtv9dyUbvARD1yDqpbP?=
 =?us-ascii?Q?tURCpMbTNEHt3JuRdiAi4OA0DRGOP4xWlqQaW7kZ3rD6EntuNq++PoWMqpO3?=
 =?us-ascii?Q?udDablLdwaLyLeMpBMfm+sDHcwawh7qEbvaA/0rfU5nf442ADq9PJlIRBMWL?=
 =?us-ascii?Q?hcKmzZs+zPSOm5r8v7fMQFzs/L/LnaL737oRp6J8g084Mn2TtwWBAVuERRRe?=
 =?us-ascii?Q?9xrABKr3V4oimq+W59fF7cTSx/EXA1IjKcJyBm/rRmOfAtdsP0p5bys0npcm?=
 =?us-ascii?Q?zseUI2J/ri9cOcxuPk6+M3ygh8DUXdGPxM/8/XJ5F4dH2NEcf+vOaHr39h6U?=
 =?us-ascii?Q?igenR39NOdHn1FnZI4Y4RfTRq2h2ntuS59qURUEgcNnMxk2x4XpI2fvY3Web?=
 =?us-ascii?Q?pemz9oQKXrE5n+GNo2H7QRbFztUvflxZ3ni3PHZyqAmMWcHsW8/APXoe41Sn?=
 =?us-ascii?Q?65jFN2aiq+AkKGkFqBkqgShMCdHvnzLv/l7BcSDUZZ0galrbrlyXmyNU7o0x?=
 =?us-ascii?Q?ajh6UydyuWljptbb0WJXld9lAm3eYxlzKVCBxo27dwbS3JRwa87qqnvMTP0l?=
 =?us-ascii?Q?2Ohw6KQ3vxX9wR7v2myLn8I5vqEutTKeONyZj5upiZc81w0dWBXa8iFz+ulP?=
 =?us-ascii?Q?Kz+Gw/L4SGIe64nV6t95wwIlKGc6zoBRjo/V0GAC1atm7Fx53T+KP1bQVJHp?=
 =?us-ascii?Q?qegQyFCJCQOdSInrjL26W+x7totwiP1k36HE224cRg7RJyQ7uRrqNAIKz5Bl?=
 =?us-ascii?Q?oBgAQUd4VNB+0UcKezN7re5Zo0touYmpxwxliGF9nyf0QAOcP0nAnroOR1AS?=
 =?us-ascii?Q?5GAJgc/X+jeW2YZi657HC4DJJPnt0CzwL9rhcmaB1w5O0geoXXQs/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ufakTxgDfGjCndV1WDnElRYx84G61GVvNvIQGCOwt0A/TLlJZL2qx4vxXAA8?=
 =?us-ascii?Q?NeMPqCi8iUXRQReaUW+mgPsaCeM7ZX90o/9b0U2y7ZHDf44V5+hxvL4zFZNL?=
 =?us-ascii?Q?cOy5q3w90ZtaIKumiZps0E8XgIKVQQVCOVTCYgf9xZVt6rCqR8XZwYz2bdMT?=
 =?us-ascii?Q?0Y/m/W3tV839zuxBkhBVYUS2DBItTtMyVkaS5aQxm8hM5hRjAHlGq/kfLoNI?=
 =?us-ascii?Q?8lBuj/E871Lj67dGPAXUMXA/WYXKomYpb2rUl6utLNsop8HejZRInqgyPRE0?=
 =?us-ascii?Q?j+8MhdGmHoP7lqSIHG86uDLW5SqxQTv6yAnOLS17wziMdJ4Fzew7P7zmK3Ai?=
 =?us-ascii?Q?q2Mvn1isGvi6bobkHzeC7+ac5gjFbJv4+XjEqGP0LkhmjP0o9gWia9JdWqWi?=
 =?us-ascii?Q?1hd7xqThPEqTskKCm4w302/6Ukq4ia0F2lju+QKDF/kx+FtiNO5jfo0kjChd?=
 =?us-ascii?Q?EY/fjCGHwrcamJKJ04ZABLNvR+TnyXhgf1k30eff79EQlxwh+FRYffKoKAgf?=
 =?us-ascii?Q?OcB8eTcSothhpBay5P7bBjQfai1fxKXS4JECF6AdhZNEbFh1eNfLkWIVntZF?=
 =?us-ascii?Q?wvquQnsNasfk/xNp0SqnHsODqmCDhsBWp2K80G+Sl0MNTYHLC4HH8pC0rA0y?=
 =?us-ascii?Q?Pv/LqAr/dFFRb4tdoBn+9zUbgFmCiuu6jSVUuCZ4mP89w3pbxt2GJhn53J+I?=
 =?us-ascii?Q?GsTsbW60eV0ke6lleCXkjtbEjBfQSENb6Du6LRTY14WW1Ktpu4gtGg0HWHFA?=
 =?us-ascii?Q?8tqGcuSocTasbKuNRx883eYt48aU5zH1xUe1+A5PQJLCGCGshlUgfXIh0bjA?=
 =?us-ascii?Q?zRi1O0uCj7e7OvK7DTq+gxAPVF64Z3kZ/tPLwHDx3mNqoze9dBtNiofcQDxj?=
 =?us-ascii?Q?mkDHB2U4P5wMLhrlNe0LUK31/sosdavyzq+4LD3ejKDJwy758KmwHXK84hK1?=
 =?us-ascii?Q?vJwe03JVrFT2Szq+nOQuHquhCHF89gcBic02dkJZQRJMnZwKsZq1FYrflQr0?=
 =?us-ascii?Q?tpaiWjrCt7EJBZa90UNN3RlMRXkHvZJdwbMqFXcHhDEIjBrjdMNR7PGETJdm?=
 =?us-ascii?Q?UMMtkhxPHrgtlS9kxMhI9Icm5VtU0LMp7iOuZrg+Ym7d1IWXsAThUEqZupll?=
 =?us-ascii?Q?L6fqqmllm7iuiSNIZTqcO+6Qgc9SMMnMXGciCogC5dnudtp1bPMnI0tvFXLA?=
 =?us-ascii?Q?MpEgU2yg3T8uDFmNEZ5wNKgyxGG4CxdlYB6+2p7RJ2KN57eqHgaqaRfcX/cB?=
 =?us-ascii?Q?aZj8nCZ46ur37oBRS2xacVQIEQuEfhxcD4C9X2Qf4/dsrhqwlVeHKuUUdmlk?=
 =?us-ascii?Q?1alzxAnM+LwdplPraQkwwGoXvkbm5Nndsd4uvYQHHWEVlhkPO6tu6Kashzk6?=
 =?us-ascii?Q?y1s2QuRFdaNRjE/zi2x5HdHDqnZ9k9jxQcmZ+GbwEpXU1lJ3R42db4ZHg1ww?=
 =?us-ascii?Q?TghYnnyh2EU1tximJ76zvVSVSDY4E6RwSwWTWk8fBHqAJJIpKDpEW7xQOtzI?=
 =?us-ascii?Q?+cGZdc5KwL+NkLGWzN9vi7noEkusc9IwJa/MU+ayMQ8sl6UzWdZzuBu3eMng?=
 =?us-ascii?Q?umUV07q3QOZwWfbdxAzIsPWscx9J1k5cMyRnoISy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305d2239-9eda-40d7-8133-08dde617e614
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:47:27.7401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qqk9uys1TfjjeVWqdht44t0fn+aO0ygI35wv50CiGZrIlx2+bd/man/2twX7RaHLr1Nf3tnRmPAjB0iKirepMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7220

The variable off_reverse and its related code are completely redundant in
the function. Remove them to clean the code.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
Changes in v2:
	- Modified after applying the pre-patch.
	- Use '&&' instead of '&' to suppress compiler warnings.
---
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
index 164ee0fde03b..f22da30e4208 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
@@ -1799,19 +1799,14 @@ static void _dpk_onoff(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, bool o
 {
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 	u8 val, kidx = dpk->cur_idx[path];
-	bool off_reverse;
 
 	val = dpk->is_dpk_enable && !off && dpk->bp[path][kidx].path_ok;
 
-	off_reverse = !off;
-
-	val = dpk->is_dpk_enable & off_reverse & dpk->bp[path][kidx].path_ok;
-
 	rtw89_phy_write32_mask(rtwdev, R_DPD_CH0A + (path << 8) + (kidx << 2),
 			       BIT(24), val);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d[%d] DPK %s !!!\n", path,
-		    kidx, str_enable_disable(dpk->is_dpk_enable & off_reverse));
+		    kidx, str_enable_disable(dpk->is_dpk_enable && !off));
 }
 
 static void _dpk_one_shot(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-- 
2.34.1


