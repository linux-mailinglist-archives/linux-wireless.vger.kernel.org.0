Return-Path: <linux-wireless+bounces-33085-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCATOp+XsmnENwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33085-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:38:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AA4270653
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D7C5300B9FD
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8A63090D5;
	Thu, 12 Mar 2026 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="ZEhNSkk9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013082.outbound.protection.outlook.com [52.103.35.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC363BC688
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773311895; cv=fail; b=pOBvoLszGuGTQbjPKm8jWVrbxbuEL/uLw8u7ngpN46qkOmvU7qnMFSC2m4KmXjyVAfY3nHN6PngT5oUHRIldEk5tB9P80qaqKrrfiULpeooHwTVzW8bF0kJSYfEPkecMxQBUqLlPvTD+0B1x5VSmX3cy3w7f+baIctxjuN0judM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773311895; c=relaxed/simple;
	bh=ItgSWGduX6R9tUPJT68Ss5DKq5PSpm98JZqJc4VAW+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CKi6sFUC4IYzQlU2vQO3iDlpCq0muwNtXDe01TZB9ow5se6/GcAMuKDvgweEEXW7nhUtqtVZzRyrCkLJpDiIBfPECEtAoO+p+JqUhhDeNVvTDFJ9mYJDk1kb4Ou4xX2agKujWKMlwUg2zdYatPBQWbyW6xK7uR4B+XpxKPiKLoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=ZEhNSkk9; arc=fail smtp.client-ip=52.103.35.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/c9Ka5zSp0ZYSPDBaQdILUnfNxpPZbmG//Hm7QwB7FgooFfjJFN4ly8MEMFC88RkjA5I/Uvh5T+pcVE1czTg3KA61tCHNdeo90DcnLkwCsotm27kQb5IjYa4JbW8yIIIGgz1CpbjUzibqOLGeKCryX6aCOeR39+WAAFdGLZTzxnVvqO0EaEaiinFUnH+AD4kvmKwJYYA4LOtja3Hw8SrH3fckyPfyPkq/LTGKj8HHrUrUCiTfOYbD/D0A4xL8cnFuQlUSiifYV9IzuJfw68Nn07QUxg/lQuOGvaYm8D09hJZu1/IarluFHp3lkKw2SVKIE7Lz5onKWd3WWlXVnBnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bk64HphfnZp14P+HnvSdnYFjFGtwrpBdQZDkB7SMpVo=;
 b=ylGQqEN0z3JhvxF0uYNvU8Ui93iYDk1DASAvz1TQPTq0qaW8Eane89DgH4dmu8PrFiefdGucr6qstRzAYubwl540TJnRB6o+M8gYCbSh1tDFhzgLzGRfM4vAxrXOOtVEVG6MuyZos/GWXrlp2zygGaGWVNiXjP/4kEGr+urakWvj8V9RosbXm7wuhRof+Ovc6gnrThE9hqIlDuzTDsfqKs0MIuWam1H0sPwnD+ySBXCtFGFHTxCkxtYFR4jLO/EUhdYtmrIvfj+egiHOmUdz5DX6OmS0acx8g9etuRoiPLF7tkepEKVuXXwSU0MlWdN20szWIcZclZPjTtYnTKjQoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk64HphfnZp14P+HnvSdnYFjFGtwrpBdQZDkB7SMpVo=;
 b=ZEhNSkk9SM4uFSMX9ZfgfW+lTODd25SxZxJ9nHwJb/7RgFj6Oay6aAH8dYL/5b64Iau/2OSl+u8C9zIRTfVz3YLTTA54HuJ5DM5gkL2oLC6n1F3scdYUC7m7f9BEEGjv/gw2Cyk/4JUBN9RSunsOl/d+O1T8Us/8Oln1CzGzia58MnJRMJl5S7ys69eekR445grbupkHRi+BRbs+QYsvGBfVEm6U23eNA3Az3e84ct5MhWXz8sY9k41qcQYAnLE3VW9Tz4v2LT2vCTdDCZqsoUvTeE0kSWV5+bZFKr5hvPQd+c3ep5eydmVAg3J0oBlb92cc1R5DRM9AKjUfGAIf6Q==
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851) by DB9P251MB0259.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:2c0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 10:38:10 +0000
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c]) by AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c%8]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 10:38:10 +0000
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	Masi Osmani <mas-i@hotmail.de>,
	ath9k-devel@qca.qualcomm.com
Subject: [PATCH 02/10] carl9170: mac80211: advertise RX STBC capability
Date: Thu, 12 Mar 2026 11:37:57 +0100
Message-ID:
 <AM7PPF5613FA0B6ACC91029B589B12E12639444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773277728.git.mas-i@hotmail.de>
References: <cover.1773277728.git.mas-i@hotmail.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0294.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::15) To AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851)
X-Microsoft-Original-Message-ID:
 <fcb3f851f7d8e2eb2803e5706ab97a100c7818fa.1773277728.git.mas-i@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PPF5613FA0B6:EE_|DB9P251MB0259:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b142a91-b32e-42c0-76b2-08de802374c2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|23021999003|15080799012|19110799012|5072599009|461199028|51005399006|440099028|3412199025|3430499032|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	Oj3zDeABy5VK60G6wrAsOwq7ZniZuqavoiA+IBeMsRgKfIGJvDzbQyk7eAR9vyvjNOzLIec2APmZ0t+dclbYKf7KpCzVE/cLLVCNTAQLQ653kKF/klI805ILydpQTW2m8kAqumJtGx+kQB+/6AM9rJK5sPGS1Vt0qVKzmf3gaqFOn5sU1Sqzx120aQBbRB/ImrRqg4QJUcuGQ7JkNtg8EBWuWGVKYOd0Q7II0AfBMKPkABja4s9gZak0ZFkaQaUckWDRcPX8LKguL2+39gjntWjTAngTj3r8L4YAbjcRWN0eNNiWhhVhyOPF8JgMZO9to0O/Gbo1dj9DLYwGZ/ry66o1V+2J3S3NfXYpu+kOaLL/OndbprqPTddGjBeM9V6x/HjwUKtWK8zGZ6Wfxq8XFjwHEd+nSCO6fX3jepLk42vnyQv1a05xWyBafTShGBOmwT7ap2iyOUmidN642u6/gPKxpfX5qBQG6n96oTCcHoP/dSVvp4Oe5OVHsaSQjYDbQQIk5vRkI8L6LU91V09YDJ1vFXZmKP0ALMRH0raUw3IlFMS+zjabk8/Fr2Vx6/N28t2b8jTyPg8gcSCY/FvZXMYWHo219T+/citZwEb23JdWfPSvPkEqUzXW3y2fBZLBBeu3LF1DD6bjhhIRfNNjA32mdmSZCj4dcsd1cPR54g9naVdysM5tr9hhZ/ywwOQvnPPJHC8VTZWwXmruBrulFiT4oUGrsd0ISq/vSqlXzY3ooiwoSV/GvNQS7NtKVqwlRYATlgDTpo6pmJleRpKiYFZfIiug9TB67kXEieJ6ilD4eQ4r0L3caa3Rc3gHzEB31lJd0eTvnxFThNYfwlyi1G3L84NOdA9DOn55h9pevo0+16k5P9Ot/bikMvNP7tI9lfJxo/tn7ygphiYhdFso3tXJi269pNV+TLdZqM4w6clhcFX93vOtqQp77nX1FJDB
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7EXt+h099eWuJnw0nUbXFUd9EUFy6PqnTKpmdDHPhhH7UPc/98VVN3hj79cn?=
 =?us-ascii?Q?I5nODkzh5AlOssDVn9lFhy/+xW3InWpsHZuAm3mwFT439ynBvfVNvlJEq4sM?=
 =?us-ascii?Q?xkwBQGQqKCcBTXj0UbkHScmRHpGm0kCOlE/aOq/pTNqkX2tzKL5VHbkj/dRX?=
 =?us-ascii?Q?kdSUfIkedx7w/C3Hh364G7Uxz0FOFC+xhv1mkyWHONn7zB+TDWmmJ78VrINz?=
 =?us-ascii?Q?Rw2kC2+x21MlYRF2Z0mYaJm7xYD5JFGhzs1LcHvBVqhRkIrmwJxnMscY+EfV?=
 =?us-ascii?Q?avEMbYoQjtfIcI954hqauF20gbqpWLibvHH+3/m1PjaLC5hfdLhUJ5rw0p9F?=
 =?us-ascii?Q?FilCQh/5XZ745IRvBRvZH+R7UpZIn4TLudE7vtF+SbMmG1HDdFh1DQKopLge?=
 =?us-ascii?Q?FPZte7oD/+HluyyaalPdBLAerUnm/ljtpXPiQHEGGVe7sP0bPIfYgRNZ6CWZ?=
 =?us-ascii?Q?L7PKen/3CKyJuLOPh4sg7uttlh/EvDZaf7Ab6h7EgnRGa2jlBTViesbRYtnp?=
 =?us-ascii?Q?juCU++7YPs4VrcU6NhfIa9Ot6k1zmDp4E5DfBSshf5wyAFTXrUIynQ/nGxOy?=
 =?us-ascii?Q?X6m+zODeA17l2pfjxyiI05X62qhDjJ4XuIZAKLCmheln4gOhRF6ggWAmmRJS?=
 =?us-ascii?Q?d/rOmsgtmRZbRR+X6MaQD8d4Z194ReK52op2C3JFv2yMGCFSaICGsYj61hUQ?=
 =?us-ascii?Q?rZBPHwntac45lyeynsIcretnu0eh3q2AfOWbL1Em9hWDk1x8VnHD8YRIJ/sM?=
 =?us-ascii?Q?LyBAsumF7BT7FMs6hZoXzmrwIS7fyCBYvSaFPMc1IGTBcp4lxX08FQ9GtqDL?=
 =?us-ascii?Q?vHegpggbQhRxojEqSzZuyWVh2w7hd7x595BGHZNsH1jTuYKb6S2eB9GMOcNM?=
 =?us-ascii?Q?5xEDTZE4Be4JOoWfZp2OJAXOhIrMTgIIu/ZBGClaCYTMb4C8nVRl9Z1ywh67?=
 =?us-ascii?Q?ru8DMF5t2RxQcVzdI5ALVqjx5XMI1jTLAkv8dROKPN1M2YZzivQK7L6B4vZE?=
 =?us-ascii?Q?j8TsYN4u9BSXz1CM0EaPcrl74xd5uLJTYim+CbOuyAuRECi9FTQyvGcGsIBs?=
 =?us-ascii?Q?obM6ktjIp6E+09xB8w1TCRPvG0w2EAbAbGL2ZTtkVaKR1pcgKDEqnAFJvKwL?=
 =?us-ascii?Q?A5IizNkP5SxQCS9S48Ty/UqckufWrExxMueyMr8elIsTG6vZep7xHiyhyE3q?=
 =?us-ascii?Q?35G8IOr3Q3RUVujGS1dWkqOv1siAi91QtmbR6q4Q/Pr0mxmfOFdSkCmGSquq?=
 =?us-ascii?Q?HnCWnG/8+p1GgGUymxyPy4pPSdu7uKiNqrjkrj3KhJ3UnpFA/TA3BauKwkAT?=
 =?us-ascii?Q?sO/dW5F1tLWtYUSDwElsJ8EwXvPIu/ZYsZa10BxRiLajAXXvmQ3vFpeTqrNS?=
 =?us-ascii?Q?UQA0x/nwivq0WBz3zzlllLc4LmVR?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b142a91-b32e-42c0-76b2-08de802374c2
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:38:10.6289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P251MB0259
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33085-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,hotmail.de,qca.qualcomm.com];
	DKIM_TRACE(0.00)[HOTMAIL.DE:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mas-i@hotmail.de,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[hotmail.de];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,HOTMAIL.DE:dkim,hotmail.de:email]
X-Rspamd-Queue-Id: 40AA4270653
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The AR9170 baseband supports receiving Space-Time Block Coded
streams (1 spatial stream).  The capability was not advertised
in the HT capabilities, causing peers to never use STBC when
transmitting to us.  Enabling RX STBC improves receive diversity
gain and link reliability, especially in multipath environments.

The ath9k driver for the same chipset family advertises RX STBC
based on the number of RX chains.  With 2 RX chains, the AR9170
can decode 1 STBC spatial stream.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 drivers/net/wireless/ath/carl9170/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index aa7e481..6324b38 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -156,7 +156,8 @@ static struct ieee80211_channel carl9170_5ghz_chantable[] = {
 			  IEEE80211_HT_CAP_SGI_40 |			\
 			  IEEE80211_HT_CAP_SGI_20 |			\
 			  IEEE80211_HT_CAP_DSSSCCK40 |			\
-			  IEEE80211_HT_CAP_SM_PS,			\
+			  IEEE80211_HT_CAP_SM_PS |			\
+			  (1 << IEEE80211_HT_CAP_RX_STBC_SHIFT),	\
 	.ampdu_factor	= IEEE80211_HT_MAX_AMPDU_64K,			\
 	.ampdu_density	= IEEE80211_HT_MPDU_DENSITY_8,			\
 	.mcs		= {						\
-- 
2.51.0


