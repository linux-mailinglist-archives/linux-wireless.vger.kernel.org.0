Return-Path: <linux-wireless+bounces-33084-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP7rN5yXsmnENwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33084-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:38:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ADD27064C
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC3FA3009E22
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E47E1FDA61;
	Thu, 12 Mar 2026 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="mYC6Lqkb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013082.outbound.protection.outlook.com [52.103.35.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358223BB9E6
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773311893; cv=fail; b=RI3J3S18kqCMmErjS+n+/DMYGlhvQGeDStlZorYcHrwAYTrOC9bl8K9kp5KpfuaAcIVJuwm1jLffNATvbLJQ5TBEnne4o2XvWoJzFWtdF9NtMYLP6MhZTWdSha0XLg4ZTZVZ15WzpdPNVumw7uEP1I6UFXCiZI1wgXpVM5zB6Tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773311893; c=relaxed/simple;
	bh=z8r7LRntMgqXXcSnYddtpeB7ASIuaZ+UbWPcuXoVdG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uwQIt7YgjD/Fg94OaVsHmBpUm7djADJDwgxIASwhmlbYcv2RbhMYNsl9OfKWgYUZt4jKuYS8tqt68UzQSVuOuu/UOMHo943mGjNM3RSob9u7bOqQYnnLcEW9Nb0JQ9bm41QM6pBs071WjDuHeO9zvyKvyAmX+sqivsVpgurBq6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=mYC6Lqkb; arc=fail smtp.client-ip=52.103.35.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNJ1VAeJQtQMdR8sX854I5cLPfx+fNSiFkkje7FfCaSkmG8jnkAnyfX4lf2RyLe7JGlWrvSEiwnAnAfs9mf23Q+mshKo/t+vlwIino4G6pz/HqWNkArtXMXi+I6I9fu1llq/E5T9XvJPr3TUtzACPHDvZDK7hH+IAzeeLzChbDt/2s9ofp1iVK/NPsbeZrojz+5VkeZSjCAxYzhs9MLO09PmuYmAN1u9AvrhEIIrzt4hxpd9vU8Zkk6KQlSAldSCIKwoqKEUGy0nRpnpILz/0FjMNEiK1Sa/2qiwXdDZrUVFdlRnp4QDkuVoOXYw0PUjXRL6C3kaQJGrz/pW7sNKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEZJmoEnIdFrDmPNEtsXeYMq1pVsQTy11WonekhrysA=;
 b=PtQn/3Db9qP0tOkAsaxA6otZ5JmrWmFieA1mgeNzLtZbMynHCACsVg8batFOQJFPosBGmDmh+pL3L/IotvLucfR3ck/lJ3uVtNgEAlqY1xPmFP+Iv5BhjUjWWWXOBVvVmXcRZrFwjAAgtP4c+zS8iS4kHrbEZrKbibew9smAowOcg0T9/7LbmeJbUrr8GgTZqJwsmShdqBfvtr9IrSGCeoHix4BhhSr4UBFMDZVsyrYul8hk3xeXVW7OlP1TxbJz4iJm8udzZon6sC5YYYgHlwVWlhsStCZYDL/xTmbaf9b8LkWa3nTBzq2lku49H6eAtRhpM0Iq1sBojeJGQ4IXeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEZJmoEnIdFrDmPNEtsXeYMq1pVsQTy11WonekhrysA=;
 b=mYC6LqkbLTqs1xs8SToS9NDbhwTT+GaGBYpFYWxPtdeDh1yKf4CJ3BgeOcqYgRbH865rhOLWCnX36jH9QvdtCKcIwu99YtMjn85gGRAQ9qmMDoWWDUD3FKbBXynI8xSq8eUVRXOpWI+VjwGpIvpHQYqUq6iG6KkZxCbRJLEVZv97+dpd4hxLlCPoa+QAJLGkh+0qD6drg60QcKKQS+3KFjWtoHpmVhLFmnav3/ZveopV5aDIPVFj+OC6a5JOcoX3txsHoXLJcUhdYg3jSXcZt8oj6vrO33y4YvJ8sFjSz47Gn0L7A4Cw4eTrdfRG89PAZmMYcvRmcVoyxFVJiXVnjg==
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851) by DB9P251MB0259.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:2c0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 10:38:09 +0000
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c]) by AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c%8]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 10:38:09 +0000
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	Masi Osmani <mas-i@hotmail.de>,
	ath9k-devel@qca.qualcomm.com
Subject: [PATCH 01/10] carl9170: mac80211: enable Short Guard Interval for 20 MHz
Date: Thu, 12 Mar 2026 11:37:56 +0100
Message-ID:
 <AM7PPF5613FA0B662B9909BAEB554565F499444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773277728.git.mas-i@hotmail.de>
References: <cover.1773277728.git.mas-i@hotmail.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0357.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::18) To AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851)
X-Microsoft-Original-Message-ID:
 <6d4f6be270beab4488b783c1dfd9b99a4ff799bc.1773277728.git.mas-i@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PPF5613FA0B6:EE_|DB9P251MB0259:EE_
X-MS-Office365-Filtering-Correlation-Id: 190e134c-4410-4fe3-c5f0-08de802373bd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|23021999003|15080799012|19110799012|5072599009|461199028|51005399006|440099028|3412199025|3430499032|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	zOI3BbXa9faX2WeBG0hMIZZ+elnwzWqJKbKHU5v+V6o4m0KLL1oXPggV4qR/vB6ikEfseB4IK6nl+CKflxxnwOWBj8tytfsguVFjrOKs+LW7hUjQHaLUUo3qO+R8XkN1hb61ganu/NI/mu3RGMhVA3X1r2kdSxhIH7uBdM/RGRTQhtTXaKDux8cHFfgT3vwLX6ru4R0ZQaxusdbfWhdSfIC529azyfvRuvNDxESWC+k0n0h2bJOK5B94r7x+rX51k/hIRISipYs8ZRo9t/RWe8AwDn+OdM5gFbYEwRvIGEFROvbEHuarrg5A6RQuzeLoKHsutjfiqXwdm62hI+cWgOxQoGlijwDmgBGxcP9dioL36XOpJQDlgJzWvYbrR94Ai3Il6NhF0UMousFEBbcfmL9BiiE7YiLQmhBT/lj9si8AXaY6Vm2esNCBexhplIC0srZhfJZHg4gNHfRKML667EdvdxKvuoc9X+JFD33kJrNTt+VPZJFDC7efGqxtdcQQLABnITEy/HefQ4wEzQLGXQ90QixVMoGGKrMmmhNfjCvvLKSIwVMa2WK5V17/kwxFHXXutv3cdMImla9csExU9dMp2D1apBDzjRl/U5MoLvTiyal8VQdMlJI3M7pWySa7Nw8WDbQg407qFz/4/pFdSjHWFYkxdZFsxKoDOX95ecqS+tk8rWaMsSpKTn1MA+upFPwwO/G7TaNVp1NqNpw3jveEDc1x7RhgMy6nQHJU680sWVGV4BqIku2OlbWBhqlVFKm0yn9hnbyzmv7NNPgHa7IUw6JygaTlPNJuQQth9jizPSj2F22uX34JuwYv2qGPcrrTd2ASPyg7Sp10e7BVKq+nl3gyYOLFTcWz5EZU0Zlt9KntXK9MjraEKiejSLY54I/pZ6EIPH38lCHJH5HlivqgoQIn7RnbL73ponC9QT3IKr4FK5k0CQE1xgFOE45W
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lKoXOggwcupNgzvChJNezG0172JRbU6aG8HLu1N8+F+oNhcxglR/fDt1YYrv?=
 =?us-ascii?Q?qH7wKJtAGewLqbYWGFT3mvpLr8CfaBlTRF0t7JfL27fBy9XV3BQf2y+GGUhl?=
 =?us-ascii?Q?rfsNxcZQ5C5kOoWOckt5g4Pyob6EUOv+XBHOe9h399Wqlr1yfgw8prZ11zpl?=
 =?us-ascii?Q?RAavkus+Z3jgQX0XyeUcx7sa7wnRB6qZbC2wNuRn8Vpirf5b2fhjmFg3KntF?=
 =?us-ascii?Q?mOR3MasPRlb6imewqt6Er9E+oSh6b65kdOibPW7xO92J+6scVAjRSxdzYZep?=
 =?us-ascii?Q?nN/Z8jG91ahAUcW90HJoNUVjo0g5+w3rp1jxFumA6KHl1uSmysrcktHkR7Lw?=
 =?us-ascii?Q?+mJa7T/zJH/jiWOuusApXaYHHsJXe2UbFEJdW4e9pC97ublnXDy8cLuyY/na?=
 =?us-ascii?Q?1bxRgpfKXmEPLcYH5Z1wfw17qXqMAAtKyPkJsJqVp6n1IO+NU4WyczS+t4ps?=
 =?us-ascii?Q?Lu88R1I3su6x3dXeq1ZW68UBHLhNX0PA5VgVNnQfUV3zY95hYbDIUv2zBNSJ?=
 =?us-ascii?Q?ZXsuAvIuqeWHrA1fv2DAIHUmDuFJZ9ZDxu0Tnb2ktcpOJzf5DOqx52W7czKe?=
 =?us-ascii?Q?VtFhx9cf3/anOzpMsoStP27H0/EqwVBDnXLuONhcZzy1gxDAx1OyI1KbPKu9?=
 =?us-ascii?Q?3huE/Fd8nUyF1KdhjjqW2ysCGL8uhYdwXloxZXlDlva46EpzSrQG60xoMj7j?=
 =?us-ascii?Q?Tae0AqflyxmvmjsBTaJ0WdGUQjB1DVz2lMBGFeXlZo1f+7Cd+IQN0TxucVcm?=
 =?us-ascii?Q?BUcuf51vteo4pZUKOrVTnU4HQsQgw37qapuNOvH83xKfHlHalRIvYqbXGs9Q?=
 =?us-ascii?Q?8gtb2jLaGFO1EuwqLpm3tIVekuwhOZgMYAUXgJUnQS7EW1VHLrbT1G7SCuZ7?=
 =?us-ascii?Q?5IwnkfNc83BOvnD0seOOPzy3sfLGsKWKVL7apCO2oNTqj2bhcE+uTJBV0+gi?=
 =?us-ascii?Q?M5jb/7eOYd3P/PKBMZot6iYlA7Dnwb1RYqg+fffRm7N/geDY/1Rpco3Md9LT?=
 =?us-ascii?Q?7JMuwb2eyvJf2sAtOG7/5T+WtSqyRIM3WHv9LB+++nFMim3da7hcffQxW4KG?=
 =?us-ascii?Q?vHJ18Hbi1429JG+TYJY7MmkKvPK3Y8qI1psPnts/a7csUv2LMkpmm4Fs34uU?=
 =?us-ascii?Q?rveLaBmJ1Cq7VL2NT7eWyE/B2EdWVi6klV2TY3g8IihPJgLomjoDVcZLDJ69?=
 =?us-ascii?Q?FBpSCy+CHVJM9Dbd5aizpVs55IRcIJmKBfj12eMhlEnEMZlpu4vTynSDtlyf?=
 =?us-ascii?Q?iPpHMHdlxPSVlBee5Eed7v9IxqTLpfKS3w0JtMWmMGnL4hK3+7TrnxhgTME1?=
 =?us-ascii?Q?6gY4EEk2lxcrBhvGmIOrrp111S9qSgbrWddNYL07yn8Aut4z/Q1myEqF4Ppr?=
 =?us-ascii?Q?dLnd6rtXc+MkfOubCcQhuxaKR0hm?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 190e134c-4410-4fe3-c5f0-08de802373bd
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:38:08.9360
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
	TAGGED_FROM(0.00)[bounces-33084-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[HOTMAIL.DE:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hotmail.de:email]
X-Rspamd-Queue-Id: E3ADD27064C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The AR9170 hardware supports Short Guard Interval (400ns) for both
20 MHz and 40 MHz channel widths.  SGI_40 was already advertised in
the HT capabilities, but SGI_20 was missing.  This reduces the OFDM
symbol duration from 800ns to 400ns on 20 MHz channels, increasing
the maximum PHY rate from 130 Mbps to 144.4 Mbps (MCS 15, 2SS).

ath9k (the PCI sibling for the same AR9xxx chipset family) has
always advertised both SGI_20 and SGI_40.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 drivers/net/wireless/ath/carl9170/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index a7a9345..aa7e481 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -154,6 +154,7 @@ static struct ieee80211_channel carl9170_5ghz_chantable[] = {
 	.cap		= IEEE80211_HT_CAP_MAX_AMSDU |			\
 			  IEEE80211_HT_CAP_SUP_WIDTH_20_40 |		\
 			  IEEE80211_HT_CAP_SGI_40 |			\
+			  IEEE80211_HT_CAP_SGI_20 |			\
 			  IEEE80211_HT_CAP_DSSSCCK40 |			\
 			  IEEE80211_HT_CAP_SM_PS,			\
 	.ampdu_factor	= IEEE80211_HT_MAX_AMPDU_64K,			\
-- 
2.51.0


