Return-Path: <linux-wireless+bounces-11826-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A08F995C601
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 09:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B1D1C21B2E
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 07:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7F74CDE0;
	Fri, 23 Aug 2024 07:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="SaIaqfsw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010046.outbound.protection.outlook.com [52.101.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5988A10953;
	Fri, 23 Aug 2024 07:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724396630; cv=fail; b=GrKAS5N9vTAlDoEqEjQbyFBJyJnvpvaE2KgFUPOlKm009B0kYJwprlvyudpPnSfN1HxyErWzPH1+RQ4ICurerQQOA9CL6L67IhthRCcWV/3/O7g2+eHTwgu+7VY2O9cstttUFNN4zpnUofNzgF1IqMjaD7LIfhVyuiOL0353hzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724396630; c=relaxed/simple;
	bh=gncygyCy55MrUMdP9HiVbroTOjGRHFb3Spnl9+WdIQo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CiqMB8lfXqA480hiKQpEDrle2O7X+l3u7YbfqFbS1fh09DvzKchyy5d0UlR3pBOi/fEfCJBEQniwQFU3gPND3x+cuJYedtdj9M8dRbGbEt0YjQGKd/8uOG/d/kjhYYLWsLfYiRoQnvQbNszQKA1lTSndgWqAj94g4QS/sGQ4TVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=SaIaqfsw; arc=fail smtp.client-ip=52.101.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4egs2xRwUS2L9DVWiSNeywX8WWm23lf5OrrNpnFVSZIg2+9Vu45GEdKvMWlH55mmzRHEni84SBXlYmd0s27r/AMrOS6zAKi2vWrlmdbI07qTq9qncgHGggeMT6C+kKkvfefAApJSCcFOmSchgJeWsYxDDHOsww5u+wVzN3Q70eLf/Bxkr09nxywTZqQoBQWnjO2asuakW8SXT0uKNu92W8b2Knn954Dgd/Jz1529HLUeTKOd7OrSXCiyRb8mWqwccRgVUrEIjEjT4gr/cDRz2T6B7lO63480fXQbRycD3vkeaA70/b8xI6roU/sQ4XmYQEKPH5q/WaMbLQvsUoV8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtoF+qmyT2sd8xsYoQ3K2y2QvcwnfdRsyMmNkdgWTwM=;
 b=HeJMn+m+6Dr1H+1XnH/bGyiKzMxRGEf2SS5o4N0EvjHxUYtH7dbILo01HHZ3wYgvElOIMVgFDsPIl1V5C+IsyjF0tQ+L9W7uECMmOaqWHuBMqySdcX5aaD52ZmEjYk1g7yaio/PCSa6mYCRxfpz3VR/U7hcQAKPPmXEu9FR8U0GEqT4ruRlNYNYBRQrtCKTUbRiwCkjkwaC7zE0gZmp9gp80ITePCl2aS5EPjwrHZWuG2JMYQp96/nzryjp5JSwrvbsdg2bltzNtFj8MbZk4EyqtUoAFs2hRZujXUNPA3cv+47rT3OTWNWFUtmW0H+V79SZwuLLe0dQtUNkA8IZktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtoF+qmyT2sd8xsYoQ3K2y2QvcwnfdRsyMmNkdgWTwM=;
 b=SaIaqfswX9FsUJrJHND79EJaic2CSeBCRWbhFxn2iOucKlFybEyQSE1JpKKdPlsZoxoIC9monVxCdy2daZdUzD/JQQiL6uhOgpPadewbvVdG80Dgm/DXuCV5HRWMOfGpe8jxZj51VgkNDBG8OKjuKTRpsQMO+sg2+8Esatr5yuELUiVO3NBBwpkWRtLdJZ1VAwJ3paHW62Ea92Jzfs5kTFYWZSs9BPonSv1GPLKCiSh2hVfEONiFHUlKEHtAIraJdNjmwqb5eanfKkUDLpSD5f75KwAIIPw9Toha7z91kyVuR9Y6sahKFBA3zOW/n3tycuv2mTQNDxf4nvN8bC73CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14) by TYZPR06MB6499.apcprd06.prod.outlook.com
 (2603:1096:400:462::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.27; Fri, 23 Aug
 2024 07:03:45 +0000
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f]) by KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f%7]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 07:03:45 +0000
From: Chen Yufan <chenyufan@vivo.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Chen Yufan <chenyufan@vivo.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v3] wifi: mwifiex: Convert to use jiffies macro
Date: Fri, 23 Aug 2024 15:03:19 +0800
Message-Id: <20240823070320.430753-1-chenyufan@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0085.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::7) To KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5487:EE_|TYZPR06MB6499:EE_
X-MS-Office365-Filtering-Correlation-Id: 78cda343-6563-425c-c638-08dcc341ba71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NKzNifx95NoGzg/5An5/9GkPrImes4Yc/04TE92QyBEMqXlNN/xp0F21AvhD?=
 =?us-ascii?Q?yI55dvMNjeyxvAWy2kiyfyswaV6QXSBJIqkYQqzOMUvUIuySxPTC4kVTr5qP?=
 =?us-ascii?Q?tCi3YykQ5H0Kt8dgAxyZz+JbR+UOHydwW9M3wMNTJ7lmi/AFQhYXc85nDBJ0?=
 =?us-ascii?Q?n2KubJzN/EVZ/R182b3Kjo+RPu5+ljkeV5Y3ycOI1YVe/Kfor1n1PSLpEPEH?=
 =?us-ascii?Q?ACcARAk6hJVSOyGfRlgze9oTrQuvf33n4cFDXqWr6xb4BiWXuCA0yMBa9T+h?=
 =?us-ascii?Q?83vwvvyLhAdM0liIWF+AIRtr/XzEOQUFHte/vMuXM0tqXRkoLH08j8aTTI6w?=
 =?us-ascii?Q?qAUE35cO6R8JJnocUm0yLxiwx/Hc117VIBoFHQtf74xjGJL3F8sd1jtnoWQL?=
 =?us-ascii?Q?fe1COexuuIE+6wBhDiln64SgBcNKrJPUbTTrLMraJty7AWVLBvd48Q6XXprv?=
 =?us-ascii?Q?WwWVURtDS+yEtbFOUPoci+E3ySFDeZDqxOpQwrgorSFZgEx4nYbW0nGUyCkq?=
 =?us-ascii?Q?SwXR3aZXhqZFb2bp1gG0mbevOix1pH9KLY1ItJ2/fUL3yLV9eVBBwUraGglA?=
 =?us-ascii?Q?e1rlMDAbDH06mEiiyfT9v7XJEIL9X+uBF6+vxV25nX9DWZicxCediJfZJgve?=
 =?us-ascii?Q?xHy3D+xlOuLbRwErty471z6QkR3YdZsMudIhzh9gCkJBXXfSN55N/fX4rKtQ?=
 =?us-ascii?Q?CJSrHBngdUoHhaJu2ldlVx6AK0j/YSRdWdjlATd8v0GmN4VkE6Z8e7Tc0Zy+?=
 =?us-ascii?Q?Mwa+BHcXe7UDTFQaCrPpAxM5ZYO7/f/PI4HvbzpTINT+tPYqLj1nv1Mn8sOc?=
 =?us-ascii?Q?7/RIvcIVvK0JWTp3zmQHeJxFyKD3nYMbgw/nrVASgpzwJJYK13FqhMCpuEvI?=
 =?us-ascii?Q?PfmL7qa5Wc9t+EDzz2VxPxCWnI7V2YJv0K8V7lW63Hr/lHRk93jjC2Jbu2an?=
 =?us-ascii?Q?Q6PViMyR2Y3/2Pk4CMDDND6Wr0anO1+L2w09yv0b2Awb+BaVAUPsd2WxUATc?=
 =?us-ascii?Q?N0rqwhochD01vmLNi2dhJjAirVtDExHDAYL+ff0jifQcZpRLidY9j02aF3iT?=
 =?us-ascii?Q?5Naxti/daPFvTikHtsokzIqSNUJLOstnvmMbyBkwGQPSbQYDTX1Of570zyAg?=
 =?us-ascii?Q?jmxQ4rchTFs9t5euV2u+rxg6guPbaqCLdmLJU1n94tCUO2Rg9QGchdbX5Oty?=
 =?us-ascii?Q?y5jvL9bBE28s+090QU73zW+B3X469NTHRk3sGbayLoHexFGurJCuIwHKGm87?=
 =?us-ascii?Q?KSFHGOt67Uv28yiNmcTNvQ0nlJVnVA9cnsxHBSmbt/MNLv5eaPBl2vwtdgg0?=
 =?us-ascii?Q?QpBuO9vYCVZ6OzM/MNHYb36qt3afxgIi3yZv0Thx4Mx3yx9jHQ9zkDyZCO3/?=
 =?us-ascii?Q?5gbfYIDvAafTHsSY968VkkDMSeWAd+adX1HaqQqLtJykyoCbnQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5487.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bZKPk/1cGe6+5juAsCCuwDAYqsT/tGiTKwl74RpJqz9iN+ftTFR/7MQs9oJ3?=
 =?us-ascii?Q?PDNWrPwK/i5AOy8S1Go/vRqqZhl1BPC7KLDjHBDfHwJaVqru9YpZNjzyaNdt?=
 =?us-ascii?Q?ifPyU+NguhEHrseq/aNBp247RpxZDYZosRhrMPvZ+S8xxZHCbJ+/8IeGBhtH?=
 =?us-ascii?Q?Unrayva09mBxDsp5bSeAUTdYD6BkHZAXUx8rIXoo2C3D0bWfYf7njJBFr+63?=
 =?us-ascii?Q?1YPgqU2/aAIpcIhxdCg89FvotW1/1rSaOFTOn1H+T7+lBQxLXaHPD65KNsjM?=
 =?us-ascii?Q?YWU3vDmRgIjp2WVLiesUjD1+YKYNhg7aT9rdMiI8wLQNDUbreXiROUnTM9Da?=
 =?us-ascii?Q?0WvNx9brHAoGfYO7mdVAzdcDIew0LkrfBN0Ry3HQDPZlH5EOmMQ51ABf3DRs?=
 =?us-ascii?Q?2PIVbeSHM9dkrE4tLY/biDzmAzKX5gfAxph61De+lp8fRitfD2hmnTKD39BZ?=
 =?us-ascii?Q?OraLcNdyyqYfHUyJeeiFfaUlfAhuryrwE/bQ/+U1REiP/mMVIfN4EyEDkeD8?=
 =?us-ascii?Q?eTqurST1oSv4oroNhIYiYEefXeo+S9W4Nk5Tyy3vyTJm+62VaJCRNy5YAOAp?=
 =?us-ascii?Q?Njr+QeFYI+D7E8Hhl1xovUdpur5Gz/Hb2BoRYx1eKBZp1o1iPT3jKJ/dkmRY?=
 =?us-ascii?Q?J2qjaQ2pDO1DZ58xT7mqcSA+H0k7SsFcgOF9eX6/WFEN7OJmiLpE7bduK6Ww?=
 =?us-ascii?Q?6RHhDkWTMt8j+DqSw4By7R8EIK/BijNsWnMCVt/1HeBpJC9J6a3PVZ+heW1H?=
 =?us-ascii?Q?vBrD3v6zC9tPTAp6D61kE6U+f2t38E0ulTYcETw6m+TmAsr5UKDS3bESy9xl?=
 =?us-ascii?Q?XDGqoibMMs+Q7dzVpSi3TTf2bT5phx47iSupaUowT8KWmB+8DhTmOmiojxNH?=
 =?us-ascii?Q?zT/hdJZAeOnE5S70PF3x92h+A1zK53vb0N5LNZlHE/qMpt1BM+9YwRDl6pS3?=
 =?us-ascii?Q?1LNqVVg8OA61VZj1q10OCgqLQHg0BRIJtmEs5UdyNKD9byx1kg2gPSP5SRIX?=
 =?us-ascii?Q?RrFUgMTBF3w0PJa2EQ86d4P/qo633pEEZwTIwJvksaLYIZgS8yNbGDV8ZCsV?=
 =?us-ascii?Q?taxa/G0GxgdI4BFmUzmGfrcQGQZFH2uOr6g4wGBrII5nBWCa9HkodlWbVurC?=
 =?us-ascii?Q?NzEIK+FXQNQjwe0EFqBxQuJZCngJPRTT+2Xb0ThgwvoicfM8BuyZtlOWw6If?=
 =?us-ascii?Q?qzUKlf1A/L+pPCJ/lrteqOrwcIttmbg2rew3/Qop+bxmdcOke0zWhmktOhVl?=
 =?us-ascii?Q?b0WT8+HJLabpwMlkYSQe3rmEqcW40q0OCknDURvsz8hKKC82KSgEB8vhMGLq?=
 =?us-ascii?Q?bD3PP/VZXke/vQemPbG34Ig3fqUu3LMdtki9V45avhc/C1oWysP8/+S2UMPN?=
 =?us-ascii?Q?IXzGPfX3bmBAusdfN4UG8+Bf72w2zxQptXl50OaM0Amk+jJS+qprkAuk5Bp1?=
 =?us-ascii?Q?4I0dcq9rlcGmkIuH2nIzbVYjIVe8p24X7I0q/Tf5Hjq1WWFFRsFnk2yNAwGm?=
 =?us-ascii?Q?1XQZ4vr5kLlASj60UaJkLoYD+JR7xjq/f8/qoU8lLlr8Ie+XYR5XFQhDW/l5?=
 =?us-ascii?Q?tiJITLfbr2cyhqnWNHls4uqnt8mxPMDnNXmT2Qo8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cda343-6563-425c-c638-08dcc341ba71
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5487.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 07:03:44.9602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j65yj33vpsttqysROWrX1MoDLdFOWAftrG0hXH2TZVj8a+ECW1fiKoBnnoVmkC3tn2g9MmNHIJbaq+ewYwnyLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6499

Use time_after macro instead of using
jiffies directly to handle wraparound.
The modifications made compared to the previous version are as follows:
1. change the type of mwifiex_auto_tdls_peer::rssi_jiffies to
unsigned long.

Signed-off-by: Chen Yufan <chenyufan@vivo.com>
---
 drivers/net/wireless/marvell/mwifiex/main.h | 2 +-
 drivers/net/wireless/marvell/mwifiex/tdls.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 9024bb944..7398bacc1 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -799,7 +799,7 @@ struct mwifiex_auto_tdls_peer {
 	u8 mac_addr[ETH_ALEN];
 	u8 tdls_status;
 	int rssi;
-	long rssi_jiffies;
+	unsigned long rssi_jiffies;
 	u8 failure_count;
 	u8 do_discover;
 	u8 do_setup;
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


