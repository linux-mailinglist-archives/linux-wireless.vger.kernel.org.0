Return-Path: <linux-wireless+bounces-11796-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5A095B2ED
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 12:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18BB1F23AFC
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 10:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4B817E8F7;
	Thu, 22 Aug 2024 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="A3+YAHMK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2059.outbound.protection.outlook.com [40.107.255.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B244B13C9CB;
	Thu, 22 Aug 2024 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724322564; cv=fail; b=sZNmax++WmXSplQE6AkGLscRfpZOokfvx0VTCb6qt9HzwJW3jw9DjrIip38tGsmr/ziY2dvoBC4xCJEt+dE6PZw3pw+BAjv3WhMG0JXfhEzrA0ZNu82Pc6PXB+DdKticaLoc6QiStWcIyh0QIB8CdLSWRpdEgOkO6L63yCzGLHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724322564; c=relaxed/simple;
	bh=qF85c5NdUWRrSc4Qk2P8m4eDDoVV2vXW9ekYPsEfP4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fAQWG1NDI4Z6jEKXD2eZJc9NlyDuYUXvdxkpC9Dy2ZKIyLpGzVO0Th2UHWhHT9STY1SDxhW07tkwNKluB8D1ybHXK8Tie4cgzPRfrrdj1QeRw3ZgQ8uR2WkAM3DRPL/m0e1R1bWJ2OnkGE453o8xGPsb5eAZAUL+GjE4Js1n33A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=A3+YAHMK; arc=fail smtp.client-ip=40.107.255.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMxw5eWOCjlNNrHwgDWbBgGd84SwGE+G0q+YqtVUuaDtB7HfCWkD935TcKGT/u/9pJMDzHT5CaZLiKgz+ZI8h508oop0yJdF1VbQblDmyWt/Cjpyy8EIe6VSItILMf9RGmzLT4y9tMx7/XiUtwYlLKu2rrdXzCCuHEdcIWglMPmDhSZ+pHAh7qXQ62K89YMSuE5JTSACV82DRgCSSsJo9yi7ugtCWQnp5TgIQKENIuAIzi4KgeCLdguiXbi2kCKx5qlCRpDAM33mTMyHWek8NSmNWyZflq56eAIcCYgjOI5u9t2h2HzTz1qvlR2GDPZxX1IWpGl1yqfNzC9i/qqqsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydL9iUiLYnle5tF8K7SeHXPXiVlF1T6Tp+RRquqj6bE=;
 b=iYZUdNB7XN6QbvDzPlmwLtF6KTfnLz4HV5YpY+GkPZXdqf10FXt4FwQYSHyb1Ww8ZO9gstjrT2Le1yKH1hH6mJOBmsAcLwAsk4qmYblDVIJ8ZW770DNQj3PUqy2Wiv9XyHv5XIA+QWPTWslXe7RsvIx3GYdnR33a8p/tIvSfO9Bwg/hrEp6cCJMgTuRPXhJxWtp8tTiJHxckvT7zOr/jrF30X7b/lc16DlDmSq4y5DdwPs1qgqvFeUqzVJ1el+6wscqSprJTJCfTNPG9WSut+D3wV/JBNQdJ9hkBQNATyop19y9SZw5a2L3m600LKqi8Us0sJSREh/2yj2uCd71Y6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydL9iUiLYnle5tF8K7SeHXPXiVlF1T6Tp+RRquqj6bE=;
 b=A3+YAHMKiCPbxlKfS5pRb6h5PvhxNqgkpUCs8+D6Q11jG6quKSez5joymF8UDkJLiSi+k+yFK28gMarvVQi1faCw1Mq8NpKo7a9etmQ08uTFM6p4GPwTg3ATXtyCtMj5qyaBI0Cvj8BhHjkPeFGqpFyYFtT4t2kCG+fXJWVYtxI60/prRBu4ZSX/oKy7lGC0NyHn0QTKuSbjs3+tjHD9LLM3vNCMZPbdHI4RXQbL1/IZGPf+73AURXOxdlKYCn1xYYizKPWY8N+OZCjYioU+5rqExBYvo+iygazWwlfnuwSKnQg1sotLEjJxM+4Yr96SKb0dKTUq0O5FuT1X3SZ51A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14) by SEYPR06MB5768.apcprd06.prod.outlook.com
 (2603:1096:101:b3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 10:29:19 +0000
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f]) by KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 10:29:19 +0000
From: Chen Yufan <chenyufan@vivo.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Chen Yufan <chenyufan@vivo.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v2] wifi: mwifiex: Convert to use jiffies macro
Date: Thu, 22 Aug 2024 18:29:04 +0800
Message-Id: <20240822102906.141488-1-chenyufan@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0362.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::16) To KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5487:EE_|SEYPR06MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a6ca5b0-9de2-47a2-54ca-08dcc29547a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L9++FoVoYdpv8htEe0QfUUPTPQriLK+zJByEZDdfNRJw/AWsrSaGWgdGHNLJ?=
 =?us-ascii?Q?51ZfAz/Q/GN1YGIH1ZDDepXwMHYvIR/3r+GnJb5yZ766t0ozchPn2fa6seeF?=
 =?us-ascii?Q?1gneiCRZQiQhprcXbH5KeYGvHREOdbxnxuHIryFNAxcVIczPJW3HlprBfoCl?=
 =?us-ascii?Q?rmX9aepUHs2Izql0xe/nY6ZJXi0ejMoiej/TbpSVOzQvnwFph100eGv5vV/C?=
 =?us-ascii?Q?hNJhFLvWe8tQLPsOik6i44lI51Z3jm3nCVJavtw6/uF/9QY5tgkn/gRJ89G5?=
 =?us-ascii?Q?R1ilIDwbftc0Am+UIUAurflZFNqRyCYHW8nlK37otn6Zfapzh1cjAAOb+7nt?=
 =?us-ascii?Q?bGzIH6GP+htGT+7NmCRqE88wGKVCu3AKfasLYEXON5bHjF7255mpeOMHw8lu?=
 =?us-ascii?Q?AEGxx/fp6dduqsiWkfabGYNmHlTxRTqrU5LIL+aWUB6e8C9spVjX6r87150O?=
 =?us-ascii?Q?Y1GTUiP46JfDqaVVYbx+eGfUZo4dvi/GDowXhpjQ1URrI3EpUaD+DhlYwme7?=
 =?us-ascii?Q?Uk4VKVn/LVwL4FK00hav5SPPIH2JPxdr+VKh1qFNd+tRyfLBTqILUS9qBkRv?=
 =?us-ascii?Q?UmRxBZ5CvF/GFAJ/v+alxHDMZW8f2vvLk8+cVqqpD7G9zjdovTRCwHW6zly2?=
 =?us-ascii?Q?NiflZrTYfIybvX01vRmzoQpL0f2h4ri02SaR1siBfRoueR5KF9GtqXUXS4kQ?=
 =?us-ascii?Q?0g/4iN6VY+2/WKBQy6U967WP4iDlVojnda8GKbN0+63UxTIH8MYNdoPI8qLT?=
 =?us-ascii?Q?Ct9XDS2DUEOjN8aQ5goAeWu3JYWVuxdeo8N66+Z/gCDeh74ggKHuL5AcsIo4?=
 =?us-ascii?Q?qW/8TCgv+yjUysd0kRJl1ofEZDPFBTLDrenL8JCWVvtjWyek2e7mgmpUn60P?=
 =?us-ascii?Q?aHhV5rJzL4XzF4WzzXwkBPR/kblgvnnLNyL6PwDo093kDQCrZp0/tk1qUl4D?=
 =?us-ascii?Q?4O5Cz8nbstWf9QdelwPG4v5bfInrsB74099cPK+lCsk/s/G3v6Pg5DlST36t?=
 =?us-ascii?Q?97nXF0SSA1hU2/OokgKAUGjT546lvOVpCPidgaCRwrCWXHa31uTceZssVcuV?=
 =?us-ascii?Q?dCaBJsTYnvUuxviB36OAmzMkE2YJkptzcVb1FYRJ6mOeEPpOeUeePYyfckfR?=
 =?us-ascii?Q?VGsew+NtTXg75Q7PAis0ytL+eGP5CBFO9YP84G24Dq6XmX/3v3xCR5oeOky4?=
 =?us-ascii?Q?fAlaYXPAZ4s1JhCrglIRol0TyuloBvaboTtjJUG1pbceCgwmRlauiVpyH/IS?=
 =?us-ascii?Q?cpTeyAEdUsiocHS6Vd3uz044IgMJKk0aOg3PKJ9Mf9+mRr5EIAxvV2f4EeSM?=
 =?us-ascii?Q?wjfpWeo4AJ35Q0ACT3VUlBpJS3YI939IKNbIraadCImUfs7cJXhOriKVLWE0?=
 =?us-ascii?Q?79XBm6phPrTKzsN3FnfH36Cq9C53r53NJsH50uLGR6UIr5FPtg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5487.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bkwlCja1KngUc+5UrkS5mlM1fBZcvq4dMz6bA6w4f6NLB6ZRltD3lmg5UzcQ?=
 =?us-ascii?Q?ETkpJl5yEOm9DoAr1x63psH/YST52w4a9q+0jv+1YNECiHabElW6DE0WA4we?=
 =?us-ascii?Q?Yy4YLVSen3q3JEfmwI5emeLGnPno2LQ94rJ/LJAOhj4VWx0/WnpThxvbUkBn?=
 =?us-ascii?Q?TS7RPcFXf2svCP7o+9ghqDKu9o85DSZhE3K3DrcTx/N+IfoFX5yJwOXYyHY+?=
 =?us-ascii?Q?OXsVVdUSqQPjBl9vY8MNr9S04zR6qjKShJMS1Kjrtk5bBegWxfDyrORy1dQm?=
 =?us-ascii?Q?EWuHkS/baO9acwwErLkFQ+SUmKY99QyhsBd6c/cP61HMMwy2L6I3JiXwJeYk?=
 =?us-ascii?Q?JP4zJz1tISqil6g+VGCwxLOr+FXacZURQF447LTTSF2uRa/PsC6tJrgdMVSY?=
 =?us-ascii?Q?BdMnvbHJlrelokQIAKYE23lY+2Bcyri59NvhU8Rg53YpkSobDQko/WO8ZTIK?=
 =?us-ascii?Q?/SofCgZfp3iwJ2s4s6o5p+vAk7SJJId46cZbQRrvsQjbqCDPw+BvwVXY4oy7?=
 =?us-ascii?Q?87HeMbrVMLebW1eIheBaYxnTVtEOjZfE4jeKZTiSQVP7jKK9h/ahW3KD1KPk?=
 =?us-ascii?Q?wl+0yAxh7wLNuP8V56k8VWHO+9/xojKumVi4POP764z6qEKiuquB3T8xd22o?=
 =?us-ascii?Q?w+hW3Pt9v8w8cC7WppqRy8FT5dIiZBjUNUPoRKbZqbSKriCEwFljiGito82o?=
 =?us-ascii?Q?E9fcNcobp07IlmigzC2d7gorFsyez3up9XojU7io5SbWX1ZPn8ZSxGaWIFbR?=
 =?us-ascii?Q?yN3E17YEpdo9pbLfqM7fTjezKBQAr7pgUmAV/1eUJmA/rgNTj5WR1vwl+fKR?=
 =?us-ascii?Q?Ajm927tvwOqu1e5YJNZndSp5EpPBannSpRu7pxrzkwSEj/wjh9NdRuJN9mYs?=
 =?us-ascii?Q?vZAhxuAIxYrKZezX7BcXQfAINyM45FrXfPtPXw78+jM+VXE2+SNDDPBeA/Fu?=
 =?us-ascii?Q?5Tk2MLacQjo8PUHvwQQDBcxNoIUMMMfRox9/OIAY5rZ//OMdk0MbLvC4tA2O?=
 =?us-ascii?Q?Svrt6vzMBWEZV4QbbPKZSyMtr7xBP5tuPZuqNWmdzynWbZvEOYEESKMDBtFX?=
 =?us-ascii?Q?jG/S+6Lls1Q/aMQrjxc8YWdnwWXJW04rGl6VDEwzun7QDPdQPJYw1j+DDk9W?=
 =?us-ascii?Q?6iJIHlb3cjKjztbA8LzFpS3xPSYoKZmFefUpQN1vXVvis3leeGQFGbz/kfVn?=
 =?us-ascii?Q?+O74cYXw6PBJYtm1Gh4zly4FeyYwbBqeRTkiG4eQ/xJLE+AVlLwrV8Ru5UkA?=
 =?us-ascii?Q?dM3Ja55pKthBePmVMdHlaxFrSH9kv/0CuEp7SS0usQAuft/NExAVyNkr04Mg?=
 =?us-ascii?Q?cnPRYxKHnRT687XikJsjUYld4GO6TRzdBjhQdH1esR4gCZpfH4cFio5WdYFP?=
 =?us-ascii?Q?NXaDmYpDb6WajTSFxrcpUGAX1w+VXWK7MSNaoVzdo0hsbO9FnBI/ABlTzxHr?=
 =?us-ascii?Q?Fo5A0i/6hHq97A7Mvlu1T22XLcM83p/DDUAuLdnFRNzu2EFgeMIHQykZmwD0?=
 =?us-ascii?Q?OGQ7n0APdwASIdwlPcGtB6j5UgC4gxR5byA5pwCv85630st7nnovgJtBFPFJ?=
 =?us-ascii?Q?cJSAGH8lSmhZnaQI/VWCZwHN9jfcrRxTQQXibBAF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6ca5b0-9de2-47a2-54ca-08dcc29547a6
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5487.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 10:29:18.9970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhuCKwQA8NwcQ6gh2p+G6Ph49OTv01Jjv9X5wCdLwDR3OXwai88lxiJ475lrjIWB5REm92OinwgUGPSCc0rz6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5768

Use time_after macro instead of using
jiffies directly to handle wraparound.
The modifications made compared to the previous version are as follows:
1. Added a typecast to unsigned long for rssi_jiffies
to resolve the compilation error.

Signed-off-by: Chen Yufan <chenyufan@vivo.com>
---
 drivers/net/wireless/marvell/mwifiex/tdls.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c b/drivers/net/wireless/marvell/mwifiex/tdls.c
index 6c60621b6..e48e8affd 100644
--- a/drivers/net/wireless/marvell/mwifiex/tdls.c
+++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
@@ -1439,8 +1439,8 @@ void mwifiex_check_auto_tdls(struct timer_list *t)
 
 	spin_lock_bh(&priv->auto_tdls_lock);
 	list_for_each_entry(tdls_peer, &priv->auto_tdls_list, list) {
-		if ((jiffies - tdls_peer->rssi_jiffies) >
-		    (MWIFIEX_AUTO_TDLS_IDLE_TIME * HZ)) {
+		if (time_after(jiffies, (unsigned long)tdls_peer->rssi_jiffies +
+					 MWIFIEX_AUTO_TDLS_IDLE_TIME * HZ)) {
 			tdls_peer->rssi = 0;
 			tdls_peer->do_discover = true;
 			priv->check_tdls_tx = true;
-- 
2.39.0


