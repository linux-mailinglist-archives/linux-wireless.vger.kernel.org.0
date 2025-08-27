Return-Path: <linux-wireless+bounces-26674-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3D3B378F3
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 06:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72B7D4E06C8
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 04:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CD123FC49;
	Wed, 27 Aug 2025 04:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="b2NrR/2C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013069.outbound.protection.outlook.com [40.107.44.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8314832C8B;
	Wed, 27 Aug 2025 04:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756267624; cv=fail; b=mOg00dhqFPt+LdB8tUsLBQP+1oqTA80E3I1+UgwkpcoeQh0gi5Rr0UfW2KM1VvK0Ml20u8PoL7xyW+CQtTK9KFKTDryHw/DvYo2FVB9hNF515kQC0Pag0NfZHDyi19DMsbcl7SPuWzX7TZdkw7LtjptuEtfaHA7J5IuJizw7nTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756267624; c=relaxed/simple;
	bh=v5jqGai1VdPAqz2+OIa/fp96flKkW1e769h2rWNZoRc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EtWtjQkEY+6Tg5VHR+TQp/8HoJpYT9zOu6/s0ILEkP/llrnyGGYD74U/73t4klJgBULLn4oXAPkQt9FBfOpTqS1xidGBIWogqVNKurcBNKJLqlVgZAB3/KSzzTSOLgcBR/8nRBIVbtPWt8628shjZmHy64JFqmznEptWcwrvqqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=b2NrR/2C; arc=fail smtp.client-ip=40.107.44.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNbwGbNDjZS0obcFHTdVwYwe3NTgfQpnDDVVphwlmIMRkdRDk/R1kOJY0V623QzEXaO2rfwhYtO+tR1dR8TGSp1c0HFjEGo/Pn6LyXswQYXFMzvcgKaKnoueUoCbxWemEmm5w4VlStpjZeGCMiXu6dTGXXqu8VwYMdRxUNtHSM44i2ER5TEomnqT+ljIhPcSYZQeU6SuCTj4rdm1DmQ49yn4rqr/fQoz7Mw7GVPCcD/N4z/JSo64CF6IidExjG/S2slwGL4CQHqCpD4Cew/AYwG+L9M/DIFhjoGLjxK+f9xd9ir5psRY7Y4MG+Fd644K8GT+GfaMsqMP/TjmHuEqpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZXCMYSisdvF5XBc0Su2pVXySafTauHHwobhN91Msa8=;
 b=J9blRmqkVoOE6FXlqcnCDY41ymLK8APP0UzurkXI2eXDTcVoaIHJTPL7WbkUPrZ/kuU9qGCysjO//NDF7gukvXyeWkuIL6enWczIltvPSyX+YvX/rSu92YS9mgUtX62WbIHYy23OJr/GMpD28xrl6WlHEd83XiHEq7pB8rDfgi2G7igN2xN1XlJZ1qGHFo1V/EasS3dmjFl3Yuvo+SvaafOwhFO2rtPLUiegj4wEZqLLiYKqyD6XsIzLrW7PLvB1cCl5e8toKBFeyuGAcKeVRGE4cLNC01BE/E7uN8ygPr8me/Gr5kPzlNzOaWRlzTHlfLy+OjZmKdkm443kWcMX2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZXCMYSisdvF5XBc0Su2pVXySafTauHHwobhN91Msa8=;
 b=b2NrR/2CkLnDTUP4726nFhxcOdbSiYphfSgx+r/MXJAxi14EEH9YCLP5F5m0y7AButBlFP8O+1apsjmr39cFDI4V9WepW/w8tP8+JEr9Q+NX5foK6PpM2k/xLsfdVHRYQH0n7rndH8bVzWo9vJjxoUPCFWZ97hZgDHOzkIyFjt0wyqGzeaFkNCRPuHPwtVNnjV+M/jtAtECuHFEuKudvTjlF8o0licTZXqkcWESNvnoVffFolG9l9EzEx+cXnQpOAoTrCwBQTHdzKuSaLLhwRePiXoJAAoCG0SM7D+fj7sYPNfFZFsDlHfrBV6ZCl7Ecj7spMlmKV2wfsrBk1Uq5+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KL1PR0601MB5582.apcprd06.prod.outlook.com (2603:1096:820:c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.14; Wed, 27 Aug
 2025 04:06:56 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 04:06:55 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org (open list:REALTEK WIRELESS DRIVER (rtw89)),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] wifi: rtw89: 8852bt: Remove redundant off_reverse variables
Date: Wed, 27 Aug 2025 12:06:43 +0800
Message-Id: <20250827040643.208541-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KL1PR0601MB5582:EE_
X-MS-Office365-Filtering-Correlation-Id: d18e7dad-1b41-46ef-8d5e-08dde51f291b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XHwuTJ7NvP6rfW2bNy5xOGB0IVCrgj+BXnMQfuvOfugYBW4PED98RvdWcQjw?=
 =?us-ascii?Q?0zNzJH2wQ4ojQe8MWKvqGQNelPrHBMn16SY9H23qMVyXBkmGP85HbFnQqZ/X?=
 =?us-ascii?Q?ZrC4bLcRfphwaX5uMchHHgSPA8wWH5ygy2Ec2ekdzluJ+NZvD41Y4Cy9W748?=
 =?us-ascii?Q?oxN6ABRog5Qwli7jLfIBm43RqGf2m38iyakna1s1QHwH37gk2UVT2cuyUC8O?=
 =?us-ascii?Q?zM+/iEz/nqgog4cYkpWkm9vov056lg9yQfIKQAI2bD+BHYaDUbaejcxooXqJ?=
 =?us-ascii?Q?1Y3VdLXD55OcD1NXqOLpsTvwi8tlEPLzrWYN6j2oGpbR1abtUZcqWEQc/9c0?=
 =?us-ascii?Q?z1EybdkDWb/499kgWcqCC0fXXSPo/aCLqRVhIi1ipFPNfo23o4tl28r+jqVr?=
 =?us-ascii?Q?xcEY1YAiE0zX24ELssaPKa1yEog+H8Wntq67kg5093bXpe0VCiRX9LTd4QuM?=
 =?us-ascii?Q?cevntbaJjPAuEKzzk6tJaANTgnmFoHIK4D/kK57qZhTtK4zut1qveFqAtZf0?=
 =?us-ascii?Q?VkCHQxG6E2L5oFDRhSeUDvP1gDo7A54aBccBmP2fAn71q90No67byjeSG+W/?=
 =?us-ascii?Q?TlLdnV4XKYU6rj0/B25FtM2tZ4F6k0ylGEl8Jkq5m/YGub31VSKkzjXxduXo?=
 =?us-ascii?Q?SxRfMXhMl93Oe30ZFnzw6qlM9k5ROkMJZNJDwJ8tf6UfoV/b18P6rJicocL6?=
 =?us-ascii?Q?h+jaw/XlV1RpYQKgMhxEjnI9n3ZaDzvs4p8YK1c/AXKO7bOM0ozVeOZSmtLO?=
 =?us-ascii?Q?55sGG1ClCN0R4VZbjAG59w6bGGjdxLckzUrxkWggGMynBwkCh6fWfM7LFIrp?=
 =?us-ascii?Q?q1kFA9r9omuCOEZiYYtJ9AxqzaRycmoHilOKxkZ93t8GQ6ckTGoiP+klLVoZ?=
 =?us-ascii?Q?tItsCKGcGo1cMjDFrKgeuIQyMxniRZ28m/HvZlzL+5Qx1vHllfXzyMP3V5ak?=
 =?us-ascii?Q?uhLjuiY4ajmRtCpuTVmibGgiy/MSTPom5gsp+iHt2JmPV5v39JyGjmnOEbd8?=
 =?us-ascii?Q?jgJudZ2Bl3iBd4yPbjJLRBRGD/910881D3BmIGqZbdxEuLVgF0BrCTpHYI7F?=
 =?us-ascii?Q?gsBSek9up9Af/BaPMixdUs8KIn7ylhUmNRtHPWYqTJphOoxyf0s5g3FlfhIa?=
 =?us-ascii?Q?xtCsoDab/UWI2Djz4PiJnmHoG3m3vJYdYTmWfdF+uViugqYO/GXJRX8h+jfO?=
 =?us-ascii?Q?9eNLVcpjTnusToTphBBqtVMqYlA7ZlTNkSmrWX/6+9jHBDL3Ef808xb5V59y?=
 =?us-ascii?Q?O9aO1pAe7RQVzB2fjAbH/57HTRv7mA9DZmpC3r7yyxCLnpssEbMmV0iRpmrl?=
 =?us-ascii?Q?HZ7TgLgy/wOc4VdNAe7AGLxJCO26e1gXDujQceNqJ9rTsPMIERlUIs3ZE4Z6?=
 =?us-ascii?Q?RcEcX6NrxGZ+ZAfts9liAV+uaBB1n2zxl4QXWu2a37jAtXLnAyX7wuKpr0nK?=
 =?us-ascii?Q?rVjINFxNyXrqCPUGdhOgRTr4qnefD4mt/GkAWH8EDoNPJBVEwtO1EA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qT2j1xpRTzYG9y5E1BRavcEYaNJK7CgKuAbgVitG5fICMi4m/H3+6WYJqAa8?=
 =?us-ascii?Q?O75ZxK9bw/2SVd3M6HEqseu42Hlvs35RWfb7CQfJmhT2OpVOEyi4b/YuONny?=
 =?us-ascii?Q?vcLctP6/vY4E4c/5chcv6hhTs653aQ/kICNP+9J1QKXg6+QIF7YmzXEBVp88?=
 =?us-ascii?Q?Xvz0MJUAvt6pWZOeiuwXVd87NHnlbLrdabT6lBH6MPLOvbty7QjM2WIICD3v?=
 =?us-ascii?Q?5GixPLXFr+d58CrDLuXhDHrRF279s9Nva61yGx5XmdmzBIxp2sQZcJYgS2jf?=
 =?us-ascii?Q?Y4lC3dQ6tPRuNcKyotDzIPJvLfYmw60ekvgsQO1/tGu9lIkUdNcchhVy2LbD?=
 =?us-ascii?Q?ju8R+RVOFN6N2TM6hw6LlrkV44ReoPooZcFGbtC9rDRqN18JwGsccogYQlUn?=
 =?us-ascii?Q?crimr7IUczBCeF82QBC5TwxrPb8mXgQTVp2fP98h9bcUzXPSg47pbzhf7GpJ?=
 =?us-ascii?Q?jl6xaCu+mEVX8m/nO+PEFCZFTVu8qblTnhmezCW/VISM2bCWdArGKRGjw4KX?=
 =?us-ascii?Q?A1cKnN3NKKxMrM9J3rk5ILfH69Ez6HDJ07L1pN1GLtdwP2ID8yAqqNFv1LgS?=
 =?us-ascii?Q?1fTuttkYSX21rhRFUvHWhMd9C1D4z2FKi+YqPRtA4ZLDxbv+y1UaHKfXcDiN?=
 =?us-ascii?Q?JV8B0P3yj7/Z8h+7dbNJvAvltx0LbhQqzlo5flOMAp4qUZrSMBTKSFg7O8ds?=
 =?us-ascii?Q?9+r/FlrS2jeuaiOF9StDkSli2VBm9usQnGeUmOIEZua+bzB6OnSd1fnhQK+Y?=
 =?us-ascii?Q?a9268ajzGcdaby6E6rRRarvaBqn42ehDJYEBzfDE9374VaRiBDBUo2nK4hEi?=
 =?us-ascii?Q?VGLwFmiV2Y1dbYbsUfJx54YYVXEqNwT77aNh6CQprB0Zb7wdK0cQurbcwFJ/?=
 =?us-ascii?Q?r4x8IA0NiUHmVLIUJ4PwBlYdC2UdrZ5PhZY9izNMJuyam2ATNwytEv1rFEoY?=
 =?us-ascii?Q?8wn2wQHo0j/IPsPti8tRCFu8QO6Fls0RjrrUfN3uuGaXIf1TICvJvteA/vZr?=
 =?us-ascii?Q?XuIXDtJsP8qsrkmf44UUCRXSKo7v7IC45VybYDXxUBckeZst/h9xp2jDIqQi?=
 =?us-ascii?Q?K1OB3UDXCMRWRoQDynMsS3Ie8J4c6GXIAmxEcI6x76o6yStyxNuayEVjaBb9?=
 =?us-ascii?Q?+M3S/IzFMJa3gtPfHooaj+LNt4cAj2e0ZUnegnmIIC4dbqyXjlQ7HO3oj0eq?=
 =?us-ascii?Q?X7ke7TiTPlrVW3HFMuOg/b806XUtB/OwYlbq+qmchosUW+VulykcY/ASieR8?=
 =?us-ascii?Q?a1qUzlzB/IZ1H/Z4U1WQiW+uOXGdDL8Snqv5sDlSeMzlyBahYtbncsZWVkzM?=
 =?us-ascii?Q?l8R+o3phGfz1TE8rlDom2GeYSFdds4UAYyrGIF/bz3BKj6j1uJGmL1RVwr+D?=
 =?us-ascii?Q?W5zaL3C864dbhR+7B5u0Zbz78vkMaq9MdK9gBmslo81rFARqN6Ppv53wGVjb?=
 =?us-ascii?Q?G9K1aCxEqN+nVzqg16f25MMjqdvXEIhZR2d9omchEPIDPDtQIfC4D2u3R4el?=
 =?us-ascii?Q?73dwmLmvGkb4gvh2zphDpcHFvhRMwoF2EsiwRyvPoolGj5hjXZiOS+uk+nkD?=
 =?us-ascii?Q?05snWIn6ZL/nSoLc7OscO30YXmtzSKEvIfC5CBzH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d18e7dad-1b41-46ef-8d5e-08dde51f291b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 04:06:55.5064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MsseFLaVXQWJ+JHaG3/GiB6uXo03t2UQyD01pECBrNTPVcnbykKPwK3bPr1wlW8/5/fe/nZ4XGMJGwkeapZc6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5582

The variable off_reverse and its related code are completely redundant in
the function. Remove them to clean the code.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
index d0e299803225..f23754a5c7b9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
@@ -1799,22 +1799,14 @@ static void _dpk_onoff(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, bool o
 {
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 	u8 val, kidx = dpk->cur_idx[path];
-	bool off_reverse;
 
-	val = dpk->is_dpk_enable && !off && dpk->bp[path][kidx].path_ok;
-
-	if (off)
-		off_reverse = false;
-	else
-		off_reverse = true;
-
-	val = dpk->is_dpk_enable & off_reverse & dpk->bp[path][kidx].path_ok;
+	val = dpk->is_dpk_enable & !off & dpk->bp[path][kidx].path_ok;
 
 	rtw89_phy_write32_mask(rtwdev, R_DPD_CH0A + (path << 8) + (kidx << 2),
 			       BIT(24), val);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d[%d] DPK %s !!!\n", path,
-		    kidx, str_enable_disable(dpk->is_dpk_enable & off_reverse));
+		    kidx, str_enable_disable(dpk->is_dpk_enable & !off));
 }
 
 static void _dpk_one_shot(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-- 
2.34.1


