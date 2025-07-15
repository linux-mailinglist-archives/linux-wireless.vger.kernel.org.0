Return-Path: <linux-wireless+bounces-25467-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2902EB059CD
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 14:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78DF3741021
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 12:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672442E0939;
	Tue, 15 Jul 2025 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="KnJkMezm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012050.outbound.protection.outlook.com [40.107.75.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA872DE6ED;
	Tue, 15 Jul 2025 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581871; cv=fail; b=P8OCd/dzbpQ84bgTk6zyW6G7+npOzPbIEXSknwM3jdsM8n3LigVUJUcji97oIeZagfQoXMuZq5QAO8sdtvVZZJAlYdYBN+58Ni/YjmIeelaV1kjd/XGsmbn01dxg4Yr4MMpcnRSg4Ya2fQ5Aprzu26ngdiJPh4VjN0+qID8Rw0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581871; c=relaxed/simple;
	bh=fnf63kiWT4aSr1NzQ25CayFZALzwZRugY3r+KRjezFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GlAy3uVhxR1pf8YvJCMJewwZazHdWAkctvr0r5/y1VESHDTJUiuzrDkiU2m5W4kyrepvDDJzjFjl78J1/i8bHXsiclWZIliVu9obzjzyYJpNOJXo+CA+XX7ovejHrRs3oLQoW6RJbXvkHRjx+CbenkL2Pzb4m4XoRi9RAu0yt4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=KnJkMezm; arc=fail smtp.client-ip=40.107.75.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yy3S4zdBjGBbe/z3OP3PIesmI7ikHTe/iJWFLN1YO+BNWDFlIzRhvqAagt2oexmlwW0WvsWIK/tXWydD1QjRA+6Nqy2f3jQKt64CKlGNH0P1nII6/va2ZuqRO9bThCsmlQnpQA0YbcRXONp+cg1e+4+44ohOYtZKl53UteiLcDX5lkGZKNMwCbJmtRjQiDhdGhMwwabBar7v0IZWGoj3GQFjB2jJYRXhPtHBwornkfduyZmblofWJY/VRB5XnU06XnRO6UhFmNQEvFiOIFdsR4XLVnlBDynngax4E8BxMElNu9U44vIgYyvN2g0bFpwLZssDZUzBxcC1GxxEaMRV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoU/0WZs2EhxQB6pO6moxvkUq0/yiIU38Bee9FOAcIY=;
 b=m10bZcoMx2vN/+neTb5Z1RFE8T25vlj8fb7uZDK7FFpH2vvFOar80/iBxt95uAYRi9a1sVPIuVtiiyegrDICIWU3b2xtkINp3CnQZMMWZwhmVsq8/zlwRIjaWIS9HuxMBduBb2HsP8X5iy+CCKZtcHU59MMI478YEk2R0QTi8YqbYNx6RwawQkAryN2GqHZx7/iwgqAdcYcs7B5gJMj+Q3xpdlrRSEME/iuJFMSrtNntEAFyDr7ZTM3RJQMBvlgSObyXmY0T4vWWcFF1pXa6Ir4fT15PC5iLcK59JXFPmSYNWfgCXNKt7zBnszvWxcRO6z972lYJFTZMlXHHl9gvpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoU/0WZs2EhxQB6pO6moxvkUq0/yiIU38Bee9FOAcIY=;
 b=KnJkMezmRZzDwvfOPBgQvnT2PZtbtIViDtQHi9ptiwuqZaHfgTuOIK1g+/WNqmWAOyYilAf+u9HuyBb9oLebpmU8Z/S8iLX5+UxJIRuT5Bmm1SX5tXzRinc9fK5BDyeY7km55bWl6bPaIKySSg6qolK4qV5SyxPFraGtOVGm+Cm/yz7+GNDPfxPczk/f54xvV+GVwzPSvdlSCT0K5q907XAfOWAV21Yi3Nro7VPEO3ty/msvbgnelpJwm1cpGqkoOzzbd9z+QwIpT8hzZiYoIGEwlxjhyO8VlGRZ1uYR9uP3342mv9PItsH08Rk591EtKVMb0zL6h3nc4Ule1Z6aaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY0PR06MB5428.apcprd06.prod.outlook.com (2603:1096:400:219::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.32; Tue, 15 Jul 2025 12:17:48 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Tue, 15 Jul 2025
 12:17:48 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Jiri Slaby <jirislaby@kernel.org>,
	Nick Kossifidis <mickflemm@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-wireless@vger.kernel.org (open list:ATHEROS ATH5K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH v2 2/7] wifi: ath5k: Use max() to improve code
Date: Tue, 15 Jul 2025 20:16:48 +0800
Message-Id: <20250715121721.266713-3-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715121721.266713-1-rongqianfeng@vivo.com>
References: <20250715121721.266713-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
 SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY0PR06MB5428:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d20345c-5002-45b7-afd9-08ddc3999caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2mgQWwZtWYpiSqike/Uu1aOrPDYTBupttvtYHBFsoVCOVsbtMlAfjlVfh7rr?=
 =?us-ascii?Q?PbYY+SM8LPmRVbpFDTAptyj6tcuvZrx+QTW3TPNN0oyhK5larIPm2sq920AX?=
 =?us-ascii?Q?eXe0Clf/1lBMLEe7ZpfT/WL1wpmJmWQKvoKXmqiXGvTpvtvHi7nC3cd5cXp1?=
 =?us-ascii?Q?SE3K1sVpyj5cWOKDSZyOUssdl0LzRKTG7WxkYC7MPDxXTyIb5M1hzvAq6S2a?=
 =?us-ascii?Q?cImDCt5FGW/unU8agaLJXWiDyq4Xbsv8qmjcKHPAoG6E9coIF9a0LP7RXcn7?=
 =?us-ascii?Q?wWQ3vR1b9PaYVBQ2jQ0kVqwoCwaZZCyjFShshWyMO5N2vMZFHrh6BbaViUz7?=
 =?us-ascii?Q?1XZvtGVHtzhLVBVDRzWoKsBJDGYwLkhgt6yIp1+ED4wUp9PoPzuYwrdNkFPL?=
 =?us-ascii?Q?Q025083OLwXAa75uSH7gcRW0uCkCYOcd2BebqOCKwz3Z52c2q66hlIYi9sDv?=
 =?us-ascii?Q?eTdumetvVPfOAGCHbV+PryM4HmQXQDjaShuHg0V5kItfi1uP4eBIjbqhlNwo?=
 =?us-ascii?Q?1BFzBGYmKcWRB8HSpjOVhv4CqeKjhLAguISkgRD4ncSAVYeKxx1bF+p7CM3P?=
 =?us-ascii?Q?hdiwjMEQtVdsJvoArtybtkL9GwWrx4FzW+/81fXMoMVhSJXJtUdqaHxdO+Pu?=
 =?us-ascii?Q?RiUG0W79QX0qVZhyWZpIisPLBuO1V5UYBpOVBEwN+12j85/XZUIEwYn0c+to?=
 =?us-ascii?Q?X3mkjRvTeytXiQyzPgDRwHaXfMd3hhu25T82xf0n+JB/3+rGsnyfB8msa1W3?=
 =?us-ascii?Q?OGeNEDQ+L0S1kKU96QLizecCoUuTz6O97eTZIO/y8UC2WoCRiqyLpYaO/ejB?=
 =?us-ascii?Q?tJsgMl0UFA07xCMMP7t+FsF29yc75MmalHySmBMW70K/PKMAxKDAvcyOmrs4?=
 =?us-ascii?Q?pGGp7C1am5OLrVwigkY+FNsNL9PwD3qPPrp0vlTBP2j0iuJPlUyEgHjtXkeT?=
 =?us-ascii?Q?bqT/4YxHWf0toac2kdUp1j3H8yIZ7VcZTYVXhAAZ6Oo90drr6qqE5xM1cfiG?=
 =?us-ascii?Q?Ywruar8lgcMXwMj/shtQGY17MG5i/ccxWTYgIsUcsrQBNOoHRIbkMZ1kSzn2?=
 =?us-ascii?Q?/lgnuC98SKHeFSeHn9yjWkQCppNolrAk1WXRr9UheAcBrbi+j3PF6iPLFTaC?=
 =?us-ascii?Q?GhO+/PWld7N70alM4Ew09PMgfw9urMAACq9KOm3iiXveF7HHUd3Uzay88EXN?=
 =?us-ascii?Q?bPYySl3mSOzXHghod2cVtlJVwK/hj1RJoiXqyrx3HHLHXmFodgQqJ0YW0GJy?=
 =?us-ascii?Q?eVeOfq537sUOIwc87ejxW8LQcp+2RTmM+LJZpXxAdBCQH4wkK9GvPvCVaX5Q?=
 =?us-ascii?Q?uffoT/ADD6U3uM1u65fBZtV6w2ds772hQoDoSb6zvh4CEi9sDf46qNYzOgr7?=
 =?us-ascii?Q?LSNHdHWbV5wuGmr9c/OMU+vrc7Rb525VBlO+t6PdeaTZSrH+f5L1Spa/y8VV?=
 =?us-ascii?Q?av24RhLxGX2upy0ot8yoZvXVVoQJ7rLdMCAnas5zyQrdWGv9XkB80g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NlzNSCnPU/XSz5zsP/MeX/TLMX35sY92jKQaEo12oe5wIrqb0e6Ubp81UHZm?=
 =?us-ascii?Q?ZlB7KVQfsbhpsT5KihKZpkHCfvQ9+ZwlGIw99l283E3WqyCWmscElZOFYh9l?=
 =?us-ascii?Q?G89DdQF22KS//plW+RxQacbRgCEeBHCNOaPiVW88zy9mUiHfyx6ICy397jZS?=
 =?us-ascii?Q?1WYNfsZkBT1R0IsTdQw3N6IlL6o+4eMTDYsLwQ6bGrwzrJ8qwis8Sf6itaEZ?=
 =?us-ascii?Q?40PVkKsTf9laB0QK0gThhnL/Mgr+5YcOBjAcUXvtSz4J2yBsYT7khRIQHpkM?=
 =?us-ascii?Q?IACclJHvdt2FQJH+PfoUKcJslh0+003kZuNBVjFsW/KSLusEOW29ZtwryHhZ?=
 =?us-ascii?Q?zlETWghuO0Abhir5xlS4UKJv4CBNQ7Jk7eyK6ldYkAOUYIEljFkaBWkQxCn6?=
 =?us-ascii?Q?dgrTZtYHsIReI77Mmdx66Kvq1u2U475hor+p+hFdtSyztpR2w/S3wpccksbS?=
 =?us-ascii?Q?IADDQfP1KUtlcrrDBd1CN7Fjx+ysnI/SQTgs5em1g+FOw+LjEoqVbvynrueM?=
 =?us-ascii?Q?lBL0UTDFHyHXc01YT8iweAhjGrerp9mGN/nlzNVp6jjDz6a/bc2z9ChLR6nw?=
 =?us-ascii?Q?3WHGI2L0ySCc5/6Tu61D7jRp1OV2XPdWMBBS2HmqrtoVxwLCzycTq6jRN/LS?=
 =?us-ascii?Q?OfXUkW2Lg89p2kiGBNo4VzByfQc0f1wlvJC+zo7DzVkXmEbaydLMjtSLaUrn?=
 =?us-ascii?Q?GsFv80B8wFb2UrIsH0VI+1DPyOZwGqt4TIDRMj+b3Ve5H5dtx3q6cLbRxVQG?=
 =?us-ascii?Q?yByQvSvyEMC/cpocj53+R0hFaf8H5OVR9dO3md5iairo6c341IPR3dR1UIg0?=
 =?us-ascii?Q?t76Bv1aDr7X5RiH/nq88Gx7TeEb5rW/XIQoMVt42GC1QTCzd7eTwx8b7rrfs?=
 =?us-ascii?Q?aZa+FMsaPh6kVtGwuKGgVMqZI5soxt8C8BPhtKhbbzPFFyo8jEDnS8XfWqgi?=
 =?us-ascii?Q?lddA7otRkRYhNBfT3p+mULCWAgzaKq9v3QGgTXZrTSVyKZA1yFwS6pcUFnaT?=
 =?us-ascii?Q?qjVhH1THmIo3oyktSEnMLYIXEmu3lhlxCvQIY7sQE9KQar/zRJMzXHP+fqI9?=
 =?us-ascii?Q?vGKjNSo5qih5pmW7XBG6VxjSGGQXIL8paycM2XohZgar4M+wSqfLGCA1Xqys?=
 =?us-ascii?Q?GMnWKXXMK3xtkk89ZamYxQCvxUYdpzokJcgh8jVEqZz/pTB96ApOJkvO+pad?=
 =?us-ascii?Q?1xGYFBJ7x2jogYSnZo1PHW59DrtZxoMAB3qJ6U2Dqj2PO2aFRxYUUOBT0fGS?=
 =?us-ascii?Q?zi/nZs1rqHpBvXZwECm+iPb3Q4EnKBs+rP6l0N6we8QnjKEJMcCKtu5ciewd?=
 =?us-ascii?Q?/OOnRve1XskbXtCaTfm6MJwpXYWZHmn/0Pe78vRYRsecI7NzU/pm1tUXtreP?=
 =?us-ascii?Q?GPjY7BjCUG9yYGezQ+uTfmjl82YDKVVEIxQ19ujBY+q4FDiFK9fm9ALxTRNK?=
 =?us-ascii?Q?hbuIZZpYiM5OO/4yIj/lQYH7QzmHWRTqjSQFw3riYkLkmHzi0YzGQ58dwDSJ?=
 =?us-ascii?Q?m+nbpHQXq+T14sjL8VJkpn/kFXxqvYKoA4GrFXFZnzm5fp2HM/P5RhHYrQ4b?=
 =?us-ascii?Q?Ps6yMcztldLNSuQ0ZkbdhYalpnVgQ8T6rcKIsvmP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d20345c-5002-45b7-afd9-08ddc3999caa
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:17:48.3660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2TCEJk2rXJmI+n8nA+8XXr08efbs8ugBOsy9s18DdgK6THdESi4mRZtNSHR1ReOHUaVGhBx/As/xanYpcrZSWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5428

Use max() to reduce the code and improve its readability.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/wireless/ath/ath5k/phy.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath5k/phy.c b/drivers/net/wireless/ath/ath5k/phy.c
index 4825f9cb9cb8..66b2dee39155 100644
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


