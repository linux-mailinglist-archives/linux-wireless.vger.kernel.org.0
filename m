Return-Path: <linux-wireless+bounces-11785-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5F095AF9B
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 09:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0FE5282A8D
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 07:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9301537BF;
	Thu, 22 Aug 2024 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DPFvBnWR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2046.outbound.protection.outlook.com [40.107.117.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AEA383A9;
	Thu, 22 Aug 2024 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312940; cv=fail; b=mWSo5TPlVvx2POrax4wxNam6wT8DHt4hot3H35jVmS8stAkTaAkAY2AfYCxWJoKJCUB852u/hYW5GLNmASEBCmyEAiI/vo2TVuuyITsZrxkzTem6oMmk7yh72Bb9d9tpkvtzn4NF+Gw2J7RFbGn8YJepbx2aaYUCHlQWS3P8kCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312940; c=relaxed/simple;
	bh=4tJIHPRYIncBU99mtPvAQhIt4zVpinE7Jq9lMwTqY4U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BCjUB+6pbAOPgdyccsp7vJZUQZwxUN0GDlNolM+bvQzOFXimOmLwM1JmFDJRB647CgASNrnV9e9amhsAUtk50S/1sTJ7HdkdRhbu3gR8wV9JEqvRbCeH2FCtW7IojUanxp3qFmNmGBTydlYcZejm2AhCPcoiuO86T4D2IQrrF38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DPFvBnWR; arc=fail smtp.client-ip=40.107.117.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sh+X3sP5ypuUq+g0C4bfJPEKRqg9b1mruNRrpFy1Xd0Zh/blc07vlxnHD8a51dXAxw2eSVm4O5Xdlzw7/n+VS1Lj3lgNljLwlr5ujTqGJ0JygLS0hlcugb1inC/W9ciGAIqUrEwCZfwgucUf+4qEopOnA5epJKgzJEcoDXgl6v/hIc1Sz3wDcQpr5Xz/PE4h1OUFGflgdvqUp0NQbGMUZWxnxJDgVQv9yMpFJ+opyibOXyqt46Izp0InLcBuMbmGqdt9hssDf0S4reXS2Wd3m3violds1/HRixqyhdU/bhMKa9G9L6CZKevy8yJGTufmdZANwpOY/rYSZi7csfvcdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LHTEJZVwdR08nAXO0Z1oavBY9xDq7daLr7d8BFkCDw=;
 b=bzg4ypRJ2s7GtQM7sJRdRtOqVcnHlhB/NNM83qR54GR/tSR8AO2IzhEa4iO+glTVwlN0wZMGwpKv4HQBpJG3QgvD0H+tPXedH/XshvR2DiUYxN4CUXVxW8rp76pIWRldL+S4OPG1/5W/IhZWRanuefBRiWzpUvRySG5vAd9AZb4stzvFA0Et648E0EjayYnTWwZ01q7qs3zmQNe0QgII/RQfo8P0C96oeohNyHxxHR3cZD85MHdjFzcRrBY1ksBOLyoCJ/rjiCjS+g+iorcozbfAF4b845e7IL6kIalLVPZAYKTUX0ax9PAvuaNH00ylwLqrjJTA/8Gjn46Xea0rIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LHTEJZVwdR08nAXO0Z1oavBY9xDq7daLr7d8BFkCDw=;
 b=DPFvBnWRqMWW/5mI5IApa/a60REO5pWXoaD9V7nIe6rcpK1WdqoYjphw1Dmp6raIWqmFAkKlLNStPWVOD/Rbwtrnlm8qNMNjA6wp0/eSafFX6lpEYcl2S9iV7Bmv7BLftzwXlsp8Pb/XAYsAUNShmhlv90Digrkf3Pr8vaISFOhi4PY2avLVomdVuTwXJSnkRSzztX7f1CYQkm4FJ3W6mGbKsHjr/4/tHfzyLYC3NX7f119Al101hJmN7d7Py+OmIrF/vm9gOZRX4fWoQ9wrQgxmofAfUrLLVg6lRn8sDQEinPlxQEQD19Q1DJMiUQ8G3t8jzorpZ/fZ3K1RUPqUyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14) by SEZPR06MB7290.apcprd06.prod.outlook.com
 (2603:1096:101:24f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.27; Thu, 22 Aug
 2024 07:48:52 +0000
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f]) by KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 07:48:52 +0000
From: Chen Yufan <chenyufan@vivo.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Chen Yufan <chenyufan@vivo.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] wifi: mwifiex: Convert to use jiffies macro
Date: Thu, 22 Aug 2024 15:48:25 +0800
Message-Id: <20240822074826.13436-1-chenyufan@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0040.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::12) To KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5487:EE_|SEZPR06MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: f980332f-aea4-4490-25d1-08dcc27ede01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qC7Tz0JrHz7hNe97wAj3Ddb+YBoLD+TpUGoSzrg4q6woc9yKJjqH8/F2BapI?=
 =?us-ascii?Q?NdhPiT7t1ZFU2eqsz9+5XYDqnoc8v/CzudkZxMZJlIfWmSSOab3wX+Id7Wq4?=
 =?us-ascii?Q?LO1c2ekmWV7R34i1AoGetzMXlkJFYKMjvE01CiO8xzmJqPds8rSpwboPjrMc?=
 =?us-ascii?Q?KsFKXX1a9R/YwBUMqVUHtvwzmiStex35MJPvQl4GSbAMO7mA5yiiX2XUmA3Z?=
 =?us-ascii?Q?nxX1Ejl6TqPSRLPRVPv95CynrXp3KkzMYTEt24eGcLBeaf2UyGh5P56FTFab?=
 =?us-ascii?Q?tGiOBPUukMhVIgjMyIpmaMZiF/khss8wzh+ZEl0EkA1au6bIi0o7P7WTZPp3?=
 =?us-ascii?Q?A2ZcZPMzPMLMNsN/d29ELtOz06g5yruyUmYSds66bMAu+SD6hJ/VH9iAx3nc?=
 =?us-ascii?Q?+UKpAeNHBSwes6OlmCsFdbChwYZowI5S4hfXNmCFXb48dwR+AGh4+BDZmoo1?=
 =?us-ascii?Q?6N/F7+jmtIo6hzRzAphMYs4X0AgA6bfyu3xjUNoRkRi76Q3r695ae5pdMsE+?=
 =?us-ascii?Q?PM3xTB5Y9hIdQCX2qLWNKnt/QJUEEmU0m0ZOIvoag6tN4pYfECowoT1z/FY6?=
 =?us-ascii?Q?MyiH/Z+AJIUS2u6Q9LN+DCdKX+/2SXvwGaiOCUf7bM3TLk6EhNHuKBpX8HsY?=
 =?us-ascii?Q?ZONpM7xwyjv8nvTQARWOPDnLKDm5khX+55nu/gqTPG2VexP+Hq4UrKP/1xig?=
 =?us-ascii?Q?j7HnRn+Hoo3+7PQ3EWgMBg1Nhet/NkhUsldoHnjp/S9JZ+faWPVdZmuJTCVv?=
 =?us-ascii?Q?wtFeLxgEKkLxvQ7/l34tFPN+IltErWJjyC237hR7qGXDRCErQjaI5+geZTKL?=
 =?us-ascii?Q?jzA0Bz/HKCzxo5u0NccPQDue9nhNr17E37uTNrMNl9TpvxD+nbtDi1b5guyE?=
 =?us-ascii?Q?Qg4LcuQwHZQzUzSlHfZN5KfvDQqbC6P7AWJoXuqkksIZrW+XnGzyFz7DNDz2?=
 =?us-ascii?Q?ezZXAR+5kRhBCZt+M/ukHN9lDIkG5wO0y2pveZXybseg1WGTSisfEDk8W4HH?=
 =?us-ascii?Q?BkKGqpyEeOmgoRvKk1myKaSpjhb2luvTctcC59bsG3SR801OBXT1o03CpjXs?=
 =?us-ascii?Q?UgFEVJwxIGa+TzP8ZmjwjD8FG12TOycdAvBZbmP7Xhf8DAyD8lVxzMBzdxdB?=
 =?us-ascii?Q?ZP/FmR+r7vX5v0x7SVfuaxgONKl1yk+IYJ6baBPmKVcbRmJizlI/R+mMcrpG?=
 =?us-ascii?Q?DJezVmQ94pj/q8fcWr9TgiHd62BTk1cT/CLLANry9149th5pWDETc8J0T1mz?=
 =?us-ascii?Q?BoF1Y7hLuh3NxJzMaKYaDoOMwCDWeunxrdD7pHkPDd7XthVznjE/UrIHPJYz?=
 =?us-ascii?Q?p9meoATxQE8vCFcxokUokQcMtJYH4aX4HwBTqrPzToGN1P3BA76Co5QP1hRo?=
 =?us-ascii?Q?kbpogfurmTbfFn0vFwOomHR8+8EH/v4L7DrPiaNhHE3BJOrKVQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5487.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ToTTIO/b/z2pjJDeQsJ/g0A524QXlbCNXDNpOFQGPUrxJo2fFmLzLLtHZvbG?=
 =?us-ascii?Q?njXP7EHRJfPkoKSImg8S039lFxzC+OJh9BjN7dzarjrI9xG0ijjf0Aqej66g?=
 =?us-ascii?Q?5yYJJyLqyQT63PDjWK2jsyBpJOPE6qUfD3p8v+b98s2cjrccFKsVPRpHdEOa?=
 =?us-ascii?Q?12kpZE6nnPKqKTgNWwWpr5Z/lbIINeXO4vMkCwDHCTOT9fHpmcbnmTFEOGI7?=
 =?us-ascii?Q?c/ZI9LlmTyJZknw1Sbl0bZcztfV1FalBQWLtMo8htSBORaCLviYsb/BkuMUr?=
 =?us-ascii?Q?MfQIR248oyi0nWuDHeRo+yWvUHjcD89zRMJqOpOGjd3aQp2m/HsfXSxhqdUR?=
 =?us-ascii?Q?XKSxtD7ezXzPw2VmhsZyhqzdD5n7jKdI5etYDwI3dWreLc+6+AwKb729EYMi?=
 =?us-ascii?Q?waSO5Kzxckkj3A7P+trXpFNZIiuPfWPp6jKuF+kT7xUFOg3mgpBhTJMrfTyz?=
 =?us-ascii?Q?Z3hxm/9WCgDrb4MPn7qJfOAOrS08LraORv16YPsRTBdO+3BIlk9KxpdLauk+?=
 =?us-ascii?Q?udREO3fQd+uBWlrvT4ZLspyVv8s8c4RKk4r7i76WhSgZ9Pqve01LqdghFmd5?=
 =?us-ascii?Q?YbQlgteBSorO8s5d3uhoXoAuRcLKWlUcXrUZYaGhPHv4lWfJEk91Jw8Fva3V?=
 =?us-ascii?Q?meEdv17KUe14zm6tUhqH1f4vVQYF7lq3q3TJo18IOQOE9J1mnrGsuzxo260T?=
 =?us-ascii?Q?cmy2t2rPRGZ1Frd7gnhRoSXOOHz+uJolLC9roed+DHprOkWB/Izei+ILmqsp?=
 =?us-ascii?Q?wLTmxtmuCQW8Bhk1udwPYJh6hYxRssUGftvigj4KAtvQPiWdjGO1wN9agxcJ?=
 =?us-ascii?Q?9V92wvw3ES4/DIH2YLLmGEL0Pz8d2Aj/AoZARvE/j4ZIOfU6Znr/T/pHHkQY?=
 =?us-ascii?Q?OlKf9GKqsgn0lsP4Z6fHW+hN6T63Yf1fEI3qNtP/daXS0rzKy1MYf8psqSpQ?=
 =?us-ascii?Q?RWC8RBk4HNIo1t7L2q1jin9wt+uNUK8M839PvQqV4hE1VXAbgnS8G0/K2Hyc?=
 =?us-ascii?Q?j6B0bb86aKbg/tDE/ChGYWG9LoNagXFvZjeBCCxwamgiXDKtu3UAkJnaX7Jw?=
 =?us-ascii?Q?wg9OY9fSwvPdqOpA7XhSQtssDC6iP5z7wh0+jk8IZlkvWAdE6EFCztTS4t2J?=
 =?us-ascii?Q?oAk1PnWyhD6c+MtyH7h7M9RHpQJcQG9zyvVroLKDADIBny2VGm14aueNNvMd?=
 =?us-ascii?Q?HPP49EVf8JVPNWyj7yTX+a4k8fLN+HhnXPeBdseodL70D3/cJ4qsx/6POHEA?=
 =?us-ascii?Q?mTPWFKcGs2w4gwTia0FtooqW5OcDg2hwTz2+49RP4sIyNjlAvOuyPfyliNQq?=
 =?us-ascii?Q?pGZxJ6UNsIH9r+xnJg0PFvXB/HD8+bGqKz+6UZ7i6Z21BCaI9M+f7n7UlE/S?=
 =?us-ascii?Q?MCx2NSTieIL25ehNlY+Hflx8WtEC9/prNnSqG4Hebw/PwktP2k5kunpxrSDk?=
 =?us-ascii?Q?AOgr9eOTtlH+DOKAH14tD0jfUCqqxXShtrelg22wJjTGhRP68o6ml4RBZyGf?=
 =?us-ascii?Q?K4jysfmxEwgKHbiRUsQZezFzh0Iv2bdA1qO8jJW2DAFF7H65o+vi6LJL5a/u?=
 =?us-ascii?Q?q0FTOwQUUCKUCpu+6o500zbSEr1jMHjbPLhpLsmT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f980332f-aea4-4490-25d1-08dcc27ede01
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5487.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 07:48:52.8049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1DxwCqNc2NRFk7VYF9ceF+gYzwJ+5wgq9vm6BjxSb7IkJmLjkGpk87M5fLhzAP6ussCEqI3HqI/wkX1SaH6QhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7290

Use time_after macro instead of using
jiffies directly to handle wraparound.

Signed-off-by: Chen Yufan <chenyufan@vivo.com>
---
 drivers/net/wireless/marvell/mwifiex/tdls.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c b/drivers/net/wireless/marvell/mwifiex/tdls.c
index 6c60621b6..7823e6769 100644
--- a/drivers/net/wireless/marvell/mwifiex/tdls.c
+++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
@@ -1439,8 +1439,8 @@ void mwifiex_check_auto_tdls(struct timer_list *t)
 
 	spin_lock_bh(&priv->auto_tdls_lock);
 	list_for_each_entry(tdls_peer, &priv->auto_tdls_list, list) {
-		if ((jiffies - tdls_peer->rssi_jiffies) >
-		    (MWIFIEX_AUTO_TDLS_IDLE_TIME * HZ)) {
+		if (time_after(jiffies, tdls_peer->rssi_jiffies +
+					 MWIFIEX_AUTO_TDLS_IDLE_TIME * HZ)) {
 			tdls_peer->rssi = 0;
 			tdls_peer->do_discover = true;
 			priv->check_tdls_tx = true;
-- 
2.39.0


