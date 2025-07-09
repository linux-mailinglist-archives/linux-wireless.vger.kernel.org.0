Return-Path: <linux-wireless+bounces-25012-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AD6AFDD6C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 04:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216B356036A
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 02:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C45A1E3DDE;
	Wed,  9 Jul 2025 02:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qFfzjYKg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013038.outbound.protection.outlook.com [52.101.127.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AD5199947;
	Wed,  9 Jul 2025 02:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752027839; cv=fail; b=bk+2ogUjHK43AMvTyOkJG9AEgaf+wlGNSNcdkVq5Y3J3moKQwM3rDYWy2yhbA2OiQ7+5hkn4PRIT5QEBtM0XlbI5On5RYHS5HiOkdFdUyS9/XmJbLgslT51+SlAdWK56mHHp4Hh6bOosSq9llK3mdXG7pGxdewdhliApW+FBiME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752027839; c=relaxed/simple;
	bh=73KGfHuYlMHmKPAeyIuT97kMMUVD+/fYlO2BbqIvbOA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uHixdzn/bZGm1jhHqGq53bFVkmgdIyBXeFognmp6RnHmw1oXjErebG0bsOkay6+tqigFz/RfXa/sejpNbRKYD4nZ7r1sSdO307ZJzX3CI+GgwZF+90TtLNpL6nsvWBy/S61DfWrK/X6mOQJxjk16BTvvn4kKZgmylhb6Un1Vx4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qFfzjYKg; arc=fail smtp.client-ip=52.101.127.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3IOxsRd7PfQ+gHcfHvrrxF9aNPKf92G4OAykt158PDDLSyfcNJURVnBHDYEQindK3NbHo3Dd+/TohNGFtcAfVQ+VAzhImWDWTvDwdbe3FGCwTsUtYTIOaZ/p5MSAPMa86yZLqFVJyCNIjhKNq2I3GQ6h12HTNuAokxJ5YYu7QU8Uk5z4yVDxL1bymEGjWrX84pXEtpXtWlp7OfPYLH6BBsrni/oLVshA2s2cNwD9zhK8rqbBp/t+nkrIsBypcyRzI806m7CU8rmz8gFMQdZNmL6zH6O0KpVJ22AX01C2PuervQ+UN4XWc3UCtYqd5ikhI3mmz7HALeBk8W5/P4ZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQKFqJFJzxh2vlfi6RV/WdxHPFNuqscp+mC+rDqbQNE=;
 b=GLcxdhIs0GHhTIEFwULubmnTn75EVrwuvaGxAm2zxSSNdk8YjDrdtZurBUrEajW67PLPqusqpFJ5/MWsEj5aD37JohVFJhMpawL7ZzmnRvrz8GUPCMDWzTUD3IXJak1Z7idtOkEnvYmykBOsUCAI53gUVG4xhI35uQJfVW4ezhC4TBZnin4NedAQn9zThmjh7DNXo8oIuOgkl3Cspx7zIgScUliGenwSZJMKqFt4qdTacE6O0UlmCbxRsACtgwYY0JM69UI5srADZ7+KCOsbKvHfkNrDow1rwaeDYJJyrYFUDY/FCWFVb61/drFfAlbnkpntV5qhw9Ks5qFwYsHF2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQKFqJFJzxh2vlfi6RV/WdxHPFNuqscp+mC+rDqbQNE=;
 b=qFfzjYKgTRGBsbIkCs8a4WxTo+tKHqT/c6/ZD11RPow02LcFSgTcIqShwiHK8MMpfZlfE5vPzJ+uV6DwSe2eC8w3wVsDBEzGlbn18WpSCoEqd1ek+S87OyTA/wf2CHYZSYnFCe5Srfgnk5Nuojt/NbYZYO7WZtqleMMdBYdeneF39ab1rFenVl04+wE9vPQl/md/EC4xuOOfwrEQHUgIO7ACjnVHvUilSd2o6F/PsVmGKG4kxuTwuKgXHBHQCnt6iiL516ADpOV0vtEZkGfgDhHg56FTSF5Sqkj82VPAwZ/A084Gfkf3rn1XByifpNJM+TK/x4GYECs6k0PBT6vPmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB6156.apcprd06.prod.outlook.com (2603:1096:101:de::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.25; Wed, 9 Jul 2025 02:23:55 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Wed, 9 Jul 2025
 02:23:55 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Johannes Berg <johannes.berg@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sai Krishna <saikrishnag@marvell.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Jacobe Zang <jacobe.zang@wesion.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	linux-wireless@vger.kernel.org (open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS),
	brcm80211@lists.linux.dev (open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS),
	brcm80211-dev-list.pdl@broadcom.com (open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 09/12] wifi: brcm80211: Use min() to improve code
Date: Wed,  9 Jul 2025 10:21:37 +0800
Message-Id: <20250709022210.304030-10-rongqianfeng@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ad93c9d3-4f76-4424-a386-08ddbe8fa70f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bMLQMZ2JHsjBNP5gHykA8VHEzHjBRVTe8h7FxHr2Hl49sgQJl3/+VqTMLvHI?=
 =?us-ascii?Q?1a91wj9IctaxF8+Nc1azFh12lzq3AzOSn2K05Ek9rXyV19W0YOmAk1uF1RNT?=
 =?us-ascii?Q?ggSEEE+Bk1LXUJoCPV5xvIWZTJ1R8662BXRnCe3blbeFVgJs+m1dsGSCVvN0?=
 =?us-ascii?Q?z/rsojf+eelFdwTNdw5OkZXI0sp7c3J8MM3QAJNt6PtnuUi4gikQEz8CRSHB?=
 =?us-ascii?Q?LVpRjFeWncENm4YFzKhIsEPqit33hkJQEbYHPf6idn5x7dcvSprOUe+M/OVb?=
 =?us-ascii?Q?JVL1+sK+pfFwmwFGPpgqrAG+dPwQlPy5ryrdHkdGiifiyfQlni0xeVs4qeQ8?=
 =?us-ascii?Q?7HibReK6741hgcd1du+LM74w652rdrVFEzXEDmUDSVsz8OH/VqPjlMrADMb/?=
 =?us-ascii?Q?oUuEOMoTIYNj1RQT4EVwiKdqDuzbe4qoZWYB4MzkCgPF4yJncb2R+EblcwC1?=
 =?us-ascii?Q?RHil1lHen9ik9FZlbqGbFiSGbZzQxClsAr+Ee5oSTxAJK+G6QfcaIG6jpLX7?=
 =?us-ascii?Q?e/Ey9P9fQzepqOiXiVcuYJI+NgSZHYw1/j3mmhq0jJySHIyxy/yI8/8LQIzE?=
 =?us-ascii?Q?FSKsFwK5tGHYo57XN/Dklyel30hWGAAz/UA0tSvN3jWS8pQo7hKs8nnzeldh?=
 =?us-ascii?Q?UIbX3JI+LEEW0OiYHN66NfmuFkeTFsuZuD7329WG5+XrDsglgWXFeNm3s8B7?=
 =?us-ascii?Q?Ufdgt2AiLMnfddfDXKTAMhPyWfazC5M4YvvKqRp/h0nAejH2UBzOTPcnsyFz?=
 =?us-ascii?Q?U51XLHenWGw+lsrTPq6U32hq2Y4W65tOopddAttrY9pun8+mITZaf4u4/+eK?=
 =?us-ascii?Q?QM9qpdY1Plou38n3QDFBsOyfPJKX4CDd15AQz7j0GFU1Xg3CKqDU6o8JcB0Q?=
 =?us-ascii?Q?Co5RNmSNbHGiTB2csHQO75LNnZ0NAIaWSZBHyQb3/ROs5Sf2Q+iKyn5TzU8X?=
 =?us-ascii?Q?p4aqTIVVIca9cDOrALF18TLa2uLdyYdlfX6rDuV2CjoYGbIsrlFx8XVRpHRH?=
 =?us-ascii?Q?yRqUBOFWpT3UTS+0NdKUMxdqx261MO6t1M7g0njGON5YkQNicTikHZjfkNtA?=
 =?us-ascii?Q?MfJBjfoxE7nmZr95Z6Ct6tivzbJr2WwN77G0hWoDtqpp4xQBnlXgNKn+HJcQ?=
 =?us-ascii?Q?f2ilEm9wrlGoYTIZ5SeW50ANoYYod/UyxI7+vwD9Uie/uO7iCYr1JMQ0rQnM?=
 =?us-ascii?Q?EdV447ueoz1ca/5UMQSAV59zmYngWwWZqlu5qNOBvYyDi9yeqVZQwx30jgHj?=
 =?us-ascii?Q?jJX3XnaOGDisNxmAAXzwOjXgeY6mmHp9V6jF0fBST1vUjQwYtmsFX37LPjS7?=
 =?us-ascii?Q?PKv9ijzkJSNV5ufA67Lafa/K9Rz4DLMV9G9+H5OsATE39FF1BhzEzzNuMMQ5?=
 =?us-ascii?Q?k/PpPPH2SHUutyabrZJk55KzFj5T6n12xwWopK2LjN6cCHqAZFxIP1aeFcNW?=
 =?us-ascii?Q?k4lbQZlx4fYDTTM1DJCe8RDEN+hXMFkplp0Oiyk3i2vQ3u+A0CQoUJ1Gbznp?=
 =?us-ascii?Q?BssvbgcG19cr/Xs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jp6fBWn9VEgEmxhJvWBEEB9k1Z+58yqI99rmI2ZR4qOBg/8zxzfG2QwlxAke?=
 =?us-ascii?Q?CysBS2FogbD6l/x0/LFS8hhy9zypoTyrtyqzUOEyGiVTdyeAZCkkt+4Y+FRX?=
 =?us-ascii?Q?5lQ3Zsx6gW2kFOBmWIBhPs/6Xwn+C4AbZNMqnBJN8CK6EO9LnkJz7lcUOn4n?=
 =?us-ascii?Q?kj3jndO44GVsJ88HpIHKauULghuiEDqtWL+uVE36a9JrWJeq3ajN2GhAd+bn?=
 =?us-ascii?Q?pccCsRHwtmXJ3dAM5nVupcTSRe3uev6iA4NAaIVaH+nmRhm4aFAcX0ee8m/9?=
 =?us-ascii?Q?rQH+3gV19rnY+Wrf0tPZyj+IV1CzJm3IL6J/Je8nFmChPD1ICy6dzyfbxM5a?=
 =?us-ascii?Q?kRf+a9cIeXNOjoSkcMwU+Ih7SMM0DA8V0O/QCoXBaAy72aEGk4fz0p1+Q7rs?=
 =?us-ascii?Q?2FEeqBXWSpkPr7Dh6RnjLbEP4njNQxLn7mjErS4k9gH3GkG/6tQ12cniIOiz?=
 =?us-ascii?Q?cI/T2pQIpGd1ElYpnQamVXnAJK9V5apSaRRxLQ2/cg7KLizBE/SDmjm0GGhd?=
 =?us-ascii?Q?VUPu1EURUZcwibygGm3L2YmpqwPEMKQqIaGO41OWr9YRP+fNIRlrRiAH7IwG?=
 =?us-ascii?Q?Sl8iTyE7mFjE9t7DsdwVqFwMRhir5YrkH3dIqFYiY6VY0iuI8xkL8dttpRbK?=
 =?us-ascii?Q?Q+OfiVSG4fGOfnK15WWTIA6hG4XWlSm/PYcFGOEjwixttubZ/C3efJ2WrXY2?=
 =?us-ascii?Q?SEZ0X1d6VHI8FeNIE8JNi6VYx8sqmAr/QcnGbyCpoixWiX9LV4UiHgfUoe+c?=
 =?us-ascii?Q?HW0PR4kuzf5RgTWgUuMbNh3g+sGfzpOhMWCair/bFVizN6mQKvU6UY9IH80H?=
 =?us-ascii?Q?Ydjm92fvECefAIEaEr4jBJ9BZGb8RnMFc4aRTCHWr1FgbbMWq1d6mOOcD+0m?=
 =?us-ascii?Q?RwvmvjqifxGak4XExlSHCbxCGVRqQhSpzzDWNubqInNfwQgiriqTTxsGzTb4?=
 =?us-ascii?Q?m0zQ/uN9j2xK1gtObb5iiqKtCPKfCjDNV1kyGvJ/SZ1spV4KwzVD06LG9kuM?=
 =?us-ascii?Q?GdwBJjEWugxg69NRrBSxpmUcaHU2tRxK5MbCdhU56A0LNAyCgsEuUTpi2Ihx?=
 =?us-ascii?Q?uZ0Kn4bhLXe3nCEWRxB7YyzZmJD2x2R1c0L0GeCC5dyFqwLC1HZwv6UXVh3t?=
 =?us-ascii?Q?SFRlhFWaWI4LZN7dy4+jwGjXCh6wfZBizcd2NGtEEIKDA6SRL8JxNnOOqom1?=
 =?us-ascii?Q?i9b2meXOuSoXjuMMhCVbwvjlttkQTor46je8qCvufcXNLA6vjXIlIWgBIu82?=
 =?us-ascii?Q?t9IVeTLY45b6mQPhTSehCtjVnpaIIPasoqba4UcznBY6cM8RGVji2/k/2dOs?=
 =?us-ascii?Q?VX9wD4FVye+elDHBS7AMKeiQedKrF4dGWwr0pKZ/LiKGqOBGp6x8+yScQd66?=
 =?us-ascii?Q?dJgf6oJ2glIuciCZtEm77AOMingxuQwO58oFZZGc64UBwiVpSwEuySiGXgRh?=
 =?us-ascii?Q?3bvTPZfbZd/ES1PvYkBthvmJu0OJjnU96Eo79OYz4OlNkGgw86jb95gSH2/K?=
 =?us-ascii?Q?EKKGLOgpr+c4IsSdZ9OQvW1jteBsW3rDIRj6Oa+GF+rJNhidOv3MqEW5BImO?=
 =?us-ascii?Q?mPu76fzEWhu2+kmgbO/xkA2yRRxS7Yz+jFLATFuE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad93c9d3-4f76-4424-a386-08ddbe8fa70f
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 02:23:55.0883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2L0B8swUcGaP8dVCU2Gr0h1pNeR7vTWoOwxzO/VERVw86WOBsKInZsrp4CX3ROSwRNGE1xPCXUFT9qVkc5F6nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6156

Use min() to reduce the code and improve its readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c      | 5 +----
 .../net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c    | 6 ++----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index b056336d5da6..f0129d10d2b9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -927,10 +927,7 @@ brcmf_usb_dl_writeimage(struct brcmf_usbdev_info *devinfo, u8 *fw, int fwlen)
 		/* Wait until the usb device reports it received all
 		 * the bytes we sent */
 		if ((rdlbytes == sent) && (rdlbytes != dllen)) {
-			if ((dllen-sent) < TRX_RDL_CHUNK)
-				sendlen = dllen-sent;
-			else
-				sendlen = TRX_RDL_CHUNK;
+			sendlen = min(dllen - sent, TRX_RDL_CHUNK);
 
 			/* simply avoid having to send a ZLP by ensuring we
 			 * never have an even
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
index d362c4337616..cc406699e389 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
@@ -25825,10 +25825,8 @@ wlc_phy_cal_txiqlo_nphy(struct brcms_phy *pi, struct nphy_txgains target_gain,
 
 		if (mphase) {
 			cal_cnt = pi->mphase_txcal_cmdidx;
-			if ((cal_cnt + pi->mphase_txcal_numcmds) < max_cal_cmds)
-				num_cals = cal_cnt + pi->mphase_txcal_numcmds;
-			else
-				num_cals = max_cal_cmds;
+			num_cals = min(cal_cnt + pi->mphase_txcal_numcmds,
+				       max_cal_cmds);
 		} else {
 			cal_cnt = 0;
 			num_cals = max_cal_cmds;
-- 
2.34.1


