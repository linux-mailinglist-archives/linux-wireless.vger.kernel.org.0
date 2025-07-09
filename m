Return-Path: <linux-wireless+bounces-25010-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522E9AFDD68
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 04:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B76561A34
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 02:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1BF1DE4CD;
	Wed,  9 Jul 2025 02:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="aAvNoRjH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013025.outbound.protection.outlook.com [52.101.127.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1051DDC37;
	Wed,  9 Jul 2025 02:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752027820; cv=fail; b=H+pZtqOLH0kwlK2L9Vt9wwHGXYPfArV2rRnnXR6M/JOgMHahRA4c8AUyVrGRD8Ujhf20Jrser8VwQCWiKMwC9sLnmGIJO8zKcH2BAY6jcCgf9rD0Ct0w3zYtaQF0G92bn/BPO+ouTfI3JIS6aiHNiXnhNDi43iJoD5Mhoj5mAqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752027820; c=relaxed/simple;
	bh=DliABYwYy+70GA307FstFlVRKa9nWy5ISDaqrZVU5W4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i61lDG4ZPfGc5o1aD7VdIs+rK6+AXO7HlRkFMmm/rm3PYFIChqYayNtbV8EWvw5q7H2rxWKLPr/oEt3yItszEJmI/h9ShZobwJdd0LO1EuCV5yPUgleiTA/XlcxNA9Uc123ZTWP45iLth5jaitXaBRnIi6tHM5FNVW4G03+CiFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=aAvNoRjH; arc=fail smtp.client-ip=52.101.127.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0/YfERQuCFIM7xz502QA2Qk6tUyJ+UVRmwym32z832o3t0xg6ko5X+ujM1u25MnrjqhORnDZ1S+8Q5Ty1OJ60CzmN/WjmAyvhlqg4Xx4VueAPc52MWHa8cd7QKldpYD5yG6TZRaHQXa79I/bwsbjpfubpzwvXRCSPUFjx5RanyE0hPX6FlQh1GVuri32os5W5MGko8uCvz8H1wKfXBJVSRUwrX4nLUNhdpbK5wM5xGfiJ+NZX+BKQzjRwuoC2M8P+Ds1LrhdewTEYJo+6yoOeo3QFiLXd77yk0NEfIA6BLUvgaEl7kXGFvHVzVH7ojxR1Jy0wCG+3HQpEnY1nVZ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJdZO5qCMTv3wKdzBx3BoVLkV0j8J9mvg08emzCGc4Q=;
 b=bCkTsVXKuL8+GhEHGA8T8L8Hwd1DV+ZiawzrXTDXifFgcsyKAXmoFactfkRVQ9yXpCKIfRwPjEj/GKnmXHuIrhN/xPpN7oBozOGgm7NKa8ZSVOgBzX4ijpELw0QXblVvQeufnbauzRdqjbgH0qx+3p5LKMT8a3K9L8P6jwxZ6R1D6UIrkzl+2k+XzJLyZ9RHJVpoitSZkq3Dd5M4wtvkgSHwwSFHJfwi2+kJoedKvxI+eMWLJpf4jFLERBHFt/0fql/vZn9VZtF2X3Up6CI5ZILv9in0yog5oT7b/61hhhCCBLFI/gDCzhhbYG2hKwAcz7yzarnRfCyMjgrjRPQhTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJdZO5qCMTv3wKdzBx3BoVLkV0j8J9mvg08emzCGc4Q=;
 b=aAvNoRjH7m+3aX3F/kympsEmnuGceS+4w5PrxgA4fmbDulk9gezhLx0y2P6z6xwkMyoI/89qwED+NYF3xA4IGI2NE4VCnXhfAFrRx18y8VPAMNIQrS6nIbt/xTPkZMDZOVo5NMOj8RWaZT9ehffuuG+c3e6qN6VNRR8T0s8fCq4gWqAuu2adxK3ytCv1lJsmZR7KFDut2wjbZoH6dzkPJzHkH9UIRUor769CvcQhDVEmr/kkAuH2FeHuJcfk18uR9E4TUgKnrvGmkXb0tanYOmeEyAcTTe+Gn/VADIOoA3+qu+R5m8lEKPa4rCxqUVvKDhcTULjQQ4ZDE5qiaTGt9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY2PPF4597475D5.apcprd06.prod.outlook.com (2603:1096:408::78b) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.26; Wed, 9 Jul 2025 02:23:34 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Wed, 9 Jul 2025
 02:23:34 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Jiri Slaby <jirislaby@kernel.org>,
	Nick Kossifidis <mickflemm@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-wireless@vger.kernel.org (open list:ATHEROS ATH5K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH 07/12] wifi: ath5k: Use max() to improve code
Date: Wed,  9 Jul 2025 10:21:35 +0800
Message-Id: <20250709022210.304030-8-rongqianfeng@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 871d02c3-e72b-419f-487d-08ddbe8f9a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FWWpW62/ffyROFGX2+hs31bHe3JCBE/K2DUJjre0wIProHnK0DngNii5hYUL?=
 =?us-ascii?Q?NEbRMCNiSUQLw8CYHHioxFs/UO3bFtlQs+VNMmGUty+bn5mUoH1OUR7ftYhd?=
 =?us-ascii?Q?LbH8PoOI+eKSDkcR+XUdgOWK+sjiMt8yvC6mvX9reWnAfcJKCVazGtCZtTnL?=
 =?us-ascii?Q?7RUs/9z46PmZDiUtYHfqPj8GZW3NsEkXZqsUrT2mzbFXawywp+H8/qW9GhIw?=
 =?us-ascii?Q?vQnzeZu7n1gG3YIfxMWN15yzg2FGC+gTN9gzcqBOOB6Olf2x+mOLYdTbgUm5?=
 =?us-ascii?Q?Om75ve1U7VdN3wB3tg4wE7C82UnixNO/Kt8uBIhlwV89+G5Qb/Ll5y+4ON8r?=
 =?us-ascii?Q?uQkKnApUVEgiOH+pEBJpxuBo09dIzNYIW2oa9iN5mBeosMcFAQLpdaq4fLJK?=
 =?us-ascii?Q?DtjPVS/NjWZTG7ByKuz9EjlW7qfR02ilNHHC/+WP7elPGq661xyz4LJFtNdM?=
 =?us-ascii?Q?VRYEVzvcaG9LGDYXk+ETP9SPnd1QCNVSagLLHp3UuHfkkAoM+kIqCBt9R+FM?=
 =?us-ascii?Q?IvddVHCX6Zbc0ElG83HcTAbFbMpeToBkTb1qtWkTf3SCNwxboANMiScyVXbe?=
 =?us-ascii?Q?ZIn/wpxMJpngTemXBDQ1ZRqwvc23Jy/O572iv+L4IEPIK/GDtkiunautXY/s?=
 =?us-ascii?Q?mZLFTIXZn7+krPuzi/yc9ItPeJ/UHT9+/RPeQMBqtOJ8EOPMOalA81cFxtMR?=
 =?us-ascii?Q?N+Dme5gzlz3fL3RM5ac4y5lUit192Di1kY4r88KW/azcs1MMP9TCp5A5viss?=
 =?us-ascii?Q?G5xZxonGaJ5MWZhjPtEohWcl8oOuAREjHlOwhPgpu0+TzEm+/7nLJpE94Czn?=
 =?us-ascii?Q?fn44zSyB+TBTRH3lKDJP1aA+lcYwlHr1JMRMKJZOhE+uE7AvLjpMjW6W94CK?=
 =?us-ascii?Q?KexMrSXZXAGIKIXcsBnIqe2WbLSyRCRNGThYe//hl5B32IgiAHV1FTRwVy0L?=
 =?us-ascii?Q?+TOd4vJpyT0FanwvX9YEmdXTIACc9m9pLOr0QCPIoa5t6ZdmePVQr7C6E8rY?=
 =?us-ascii?Q?r8TPT/G9Sq4DQHGkzng1bjzoEy2HlNrf1drX1fIGmXhr7MxdUCY32j2+V2ue?=
 =?us-ascii?Q?kYVBXQ+0Wq7xovzHwZAmSFOJUleEVCRI+mbNaHHb1uFEqxTE72Vsmy+jv8vl?=
 =?us-ascii?Q?DkUy0WApYEGN01COHq3b8QB8S3rchkw9X/PAhxflVLq0biSv5NeT2ez1jsgT?=
 =?us-ascii?Q?TxMvzYd5AxChMmp0JzDbeEAHXxl1V+btlcvSC6syuW7qevYmEq1mBgm9BVzL?=
 =?us-ascii?Q?9MDXr1I0LokEe7dy2Fuh/Hb0srJXXcF1/q9rCws7Jtik/paTmC3ZKVck7W//?=
 =?us-ascii?Q?R6jlkmoti7HRJuYoAXf3ZD1DqEkWM6unPUbzk5xIG5BazFYsGtbXX8VStukO?=
 =?us-ascii?Q?JMT2UbxJxhx397uxJGFbsRLdxhNeEHVHYy/zewjWobGrawbE/eEEsZ2plDlT?=
 =?us-ascii?Q?3f3CN9JRAB88YLnW9mMD58WXKMa1q0HIFb2EAJq7ZmpDzZ80cvnepg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SQWLZjbjVNbj5xGW+CwvDoSbN25Yfu+hUbbR/K0ulM0fB1ftPSMjV9qXCoia?=
 =?us-ascii?Q?HbSJVQ+U7+6fRWNrgoxy9pVL/r7OyBWrpj9L0Z4WK5q648bx0VMsTM+zZ4uu?=
 =?us-ascii?Q?s/yIPtIgGTpzWJ1UbdtL3zQW6kh1wE9fKdIgKYe+I2xF+E6hMhbctb119+P6?=
 =?us-ascii?Q?qAIYJA+ogTW/6eyZ7/+MC0gMHI+dVflIU9ArbGLj8AsB1/HyCu3QERuHTgFr?=
 =?us-ascii?Q?zEfFk5JN/Tb0FbT7pVxVAU9qWH/aZ8nlkiBWJgIe4DlR5wFaP1wmZ8vi8Kv6?=
 =?us-ascii?Q?JKnIJLD2eO9WFgCeBgufxyrhml8G2lSbSIm/cj52gNlsQLo/o6CjFUavkf8h?=
 =?us-ascii?Q?gtMEEHyrcaTld8+8LOImpuICGruy0AjSXrG2yZsVnjz7iDR6eAYhJLCg2i6r?=
 =?us-ascii?Q?JPR/BBBrXywnK83jGda6xm0sjwqL1HJA03+RUs6d8Qis35uUGTf3MRfa8avN?=
 =?us-ascii?Q?jFC5UNo4w1VNu9ln4PXtoiUR/rzel+RQ8PAVxjl6fAKsjb0NWNoWbN2IWa5J?=
 =?us-ascii?Q?ggGS9Y0LkRRa00O0RBtM4+yAqnB/1H5ctu7Ybj4eL/SS7odCl6P5VSIAF/K9?=
 =?us-ascii?Q?qyROges71BIUPrsdPn0ijCg7gcQDGViZhjFZ/yx1Yl7mPKsZZXd604OlOrR8?=
 =?us-ascii?Q?rmuqW3Z4i8/gpr0HfHXKp05qmMWXPqtVJemDxQEp8SH2NBERYy1jQg714HPo?=
 =?us-ascii?Q?+jC0opNtEzAL5tnYDrGW7in1eN/x1+f7NRSdtVfn8pb/lOtDEkj9CR52obEF?=
 =?us-ascii?Q?pQS0YgHyrHWd/MaCZYvlEMjxWppKe5ZXMtcf6PpMJYso8C+y+u+b4SIPwX7Q?=
 =?us-ascii?Q?LSIK5K5R8NyObK1cnv3UydKEXAXCoR07NEK00WB+XhQfUcXNOApWzP0vTgxJ?=
 =?us-ascii?Q?8pJ1aQuSLgeZ7xgpU1HUoHMISFdJ6B+kbIxT2rYo+LmgvZvAxvwFbPXCvPYO?=
 =?us-ascii?Q?aWSObzjJfI/xErWmj8h7J2cUlhVtazAIBObhNmNcIutoDLLcSx2vrOKveOy4?=
 =?us-ascii?Q?moVPxCIdAOcfCsE37u73WEZ+gwmcXAbCAg1E5IpJ3gVK2j8Rl1ybCwu/Ieiw?=
 =?us-ascii?Q?DcJqPP0iuL4CM0EOYbz9TzIw7G+YJz6MIepzuvePmW6mzUNT4QKpeU/qHkgo?=
 =?us-ascii?Q?c/31GzsBPcuqh2Caf/TFXlaUpxdfyItJojJgFSCwyIYGVtDcE/WsU7+tI6ne?=
 =?us-ascii?Q?dUXLmPCv49uIF1srfB//NoVn/QCIr9DDR6F9ABFTjf71t9yB4jXbfnXZOwJP?=
 =?us-ascii?Q?pzQXydfYy5UtHxkbIanAqQYIY/CBHsj3+FYAIN7S5oYV00S3r2cl/kAn43wY?=
 =?us-ascii?Q?kAAqyT8r5bppWiInVkhyuOjh0nOZz75I1SipidL2BzYWQ3EkbWNb3jBA7Rsy?=
 =?us-ascii?Q?/9c7c2nQq+LedKp+NI6NYS/BHflPi4FjKe6Y1j05kyXdTnXOoyulUmogfYTZ?=
 =?us-ascii?Q?K0dylSGaGpBAY1l4Djqbj5uvjDsJI9mL7uCqqKMoZcTJ2B9KkcmfB38WUxQM?=
 =?us-ascii?Q?54QvGMUlqnC42TBtQDotbtM0IHbn4mTnf3mrXjWuICbAQSUiBa73MdHVHrar?=
 =?us-ascii?Q?BbAsiG2oDBJfGcQ9yL15l+SqmGuTBAjcPtWT164i?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 871d02c3-e72b-419f-487d-08ddbe8f9a8a
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 02:23:34.1074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwTv8ZukNGoMWTUx2iCSmC71s8nWW2RhumikExEzUxbOEZouwzVi48z4uT5yTLPZkQmFGXS4+8psvP8GcMCmWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF4597475D5

Use max() to reduce the code and improve its readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/wireless/ath/ath5k/phy.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath5k/phy.c b/drivers/net/wireless/ath/ath5k/phy.c
index 4825f9cb9cb8..b76772396590 100644
--- a/drivers/net/wireless/ath/ath5k/phy.c
+++ b/drivers/net/wireless/ath/ath5k/phy.c
@@ -3116,10 +3116,7 @@ ath5k_combine_pwr_to_pdadc_curves(struct ath5k_hw *ah,
 							pd_gain_overlap;
 
 		/* Force each power step to be at least 0.5 dB */
-		if ((pdadc_tmp[1] - pdadc_tmp[0]) > 1)
-			pwr_step = pdadc_tmp[1] - pdadc_tmp[0];
-		else
-			pwr_step = 1;
+		pwr_step = max(pdadc_tmp[1] - pdadc_tmp[0], 1);
 
 		/* If pdadc_0 is negative, we need to extrapolate
 		 * below this pdgain by a number of pwr_steps */
@@ -3144,11 +3141,8 @@ ath5k_combine_pwr_to_pdadc_curves(struct ath5k_hw *ah,
 			continue;
 
 		/* Force each power step to be at least 0.5 dB */
-		if ((pdadc_tmp[table_size - 1] - pdadc_tmp[table_size - 2]) > 1)
-			pwr_step = pdadc_tmp[table_size - 1] -
-						pdadc_tmp[table_size - 2];
-		else
-			pwr_step = 1;
+		pwr_step = max(pdadc_tmp[table_size - 1] -
+			       pdadc_tmp[table_size - 2], 1);
 
 		/* Extrapolate above */
 		while ((pdadc_0 < (s16) pdadc_n) &&
-- 
2.34.1


