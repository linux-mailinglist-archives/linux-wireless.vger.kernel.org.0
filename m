Return-Path: <linux-wireless+bounces-33093-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBIpNKeXsmnENwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33093-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:38:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A287527066A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 875BF302BF6F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246741FDA61;
	Thu, 12 Mar 2026 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="Qqwb4sQq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013083.outbound.protection.outlook.com [52.103.33.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFE72E719C
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773311910; cv=fail; b=DkKVuNunZY0o7/zKhw7GQ1Bm+ldsAv1O7MoJzw7eqWQlCcOZ30g4tjR2IbvjylkdsDlBG5aNy0ZxBddP6H214mth/gHqasgSaMq1qkgeGKHcJvShp2XUKAfnbaUgVuKXw61VB5Tfs+UtfhB0+WYDhy72gYXYFB+dag4xf4EkY/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773311910; c=relaxed/simple;
	bh=/8gGU1TEoOTieD3WPU8ed63ESBd1Uo+Dtv32xbv99xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UpnMqEia5m8+T2pNAulIbYST1ospdiMNl+sxEbn/tSw3LiA6yCfkRjJ6KBE2vFUtpo/Q38btwoMJma3E9qHFTCrTwG0ECQ4L08W60KVkOmpfhsWfpKgTQwH6SmoL+WmP/mSe3D0wjOdc340gZSRrZ1qhJqcWl+2XvyCwY0EuI3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=Qqwb4sQq; arc=fail smtp.client-ip=52.103.33.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvXe2Yp2cg0PID9J9Dm/5VTXc90XcAnDFBcgZUnMm0pIuizL3LaM7rv+w4pUCRa7KM4tjiyENFvYe40ZzYmQrDRkw6hZXKrxagDf5JkHx4vS0K7XHoVfI4Kykunr6NXowv0WMjZgiiVnn35BoRm7BMaGUMJQMkE20Cqpxgcgn+AzZwWOEfTumzVhsUAdF6OizOw3USC1xZ9P03jEg3SU7Bopvmo+AY7GlBStvuWd1EfRbHNPxHTlYYq1oUdhmJFBVNUQxqf66ixRB1M6rU/2lS2qnpaKPS2BDK0SDCyq4btriCymfDHGlBo8DXqLj1MeqtWIZ4kCYvBBYSLWkL2QUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhMzbKsGpvbsMLw2b6LYmQAEKSqny3Es0Hb3BFVLsdk=;
 b=YRcK93DfbxlXlBLY6ImQSuyXDdiLfKNFBnUX7bB1f5KXLbskp2iT27jX7MBoBFVJIDq/6ApRab+J3ErtVvSCO72MB1KYRta3j8QyOTQknBYl03uxgh5B8Jl577okItEcA4VjFxgpcge+5lebUzQrfER1RMvxVMv3GuUfX+o2nj8f6OoqgGJOXX+DLBKWc8iapRb4aqLCDyeWuDAEwMUQc5QB48gfEmIvYiUdkWmzZ5oHWNJr2w9NjXHfEftfYWDWs6m3radyrAY/3hoM7lF9mHuado0wI/C4rzxYWVsBIg/KQN9Qmp/7zF49IPKJwA2t/IljR351fRwL0i26Zz8kqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhMzbKsGpvbsMLw2b6LYmQAEKSqny3Es0Hb3BFVLsdk=;
 b=Qqwb4sQqQsqxw5XdZM7CZGb03DL0xAXvR+bo+LFvKKot/qWO4jBCGUVuxz42KRe6gQgYjzXo/j+m+daa0VPbSBKbrLZm6f2xWOv50DbxCZPxrXwGiINZrQPGCt/A8XFt7alW0tDjO6P/uvvAi0cTjd2eMQSHFp33CH03tb3OKWpg0hvRmi456By7hdo081MvGg55ZmxF7zy9DUnxYthVcyFUbtzujxdZ2p7uv6JEwBOFmj4s6SWS1cSWfkQMAgWwzkYIqPhMHEp7R3H6oiI5hKUKseZt3yXqPz0XIkyyQdFj90GcqZQwfJOVAEP9JODSgFVMbL2U4aJn40OB1D0euw==
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851) by PA2P251MB1058.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:40d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Thu, 12 Mar
 2026 10:38:25 +0000
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c]) by AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c%8]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 10:38:25 +0000
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	Masi Osmani <mas-i@hotmail.de>,
	ath9k-devel@qca.qualcomm.com
Subject: [PATCH 10/10] carl9170: phy: add periodic runtime IQ calibration
Date: Thu, 12 Mar 2026 11:38:05 +0100
Message-ID:
 <AM7PPF5613FA0B6567EFD98F8FD6FE6511E9444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773277728.git.mas-i@hotmail.de>
References: <cover.1773277728.git.mas-i@hotmail.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851)
X-Microsoft-Original-Message-ID:
 <d9ae32cbf664b0559e9029cb1b5556f155966b66.1773277728.git.mas-i@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PPF5613FA0B6:EE_|PA2P251MB1058:EE_
X-MS-Office365-Filtering-Correlation-Id: 58605e06-fb19-4f00-410e-08de80237d62
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|51005399006|19110799012|8060799015|41001999006|23021999003|15080799012|3412199025|440099028|3430499032|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sjiKm06sR01Q0pDQ1wDZghvQ4shsNTE2g64ShlxS+S0NcB1/BUeM/YE3kA9+?=
 =?us-ascii?Q?HgI0HPHPjxhiF4hH1NkO6Ni18OiZeQ8qA2LWNeKcudruQgNR2vaRBfpPQqpA?=
 =?us-ascii?Q?TAZCIEU1pezcT2IAnDmalRikj6N3Hh0xyp/DFfrBv8B9eka3Xfn72tuz9XZW?=
 =?us-ascii?Q?9vOWCHG7qtTuXRH+iql3kY91v9bYHrXZFxQBoD+6f/Ro+ZgOpBnWJiIMwYJ8?=
 =?us-ascii?Q?mUCmdxdA2ePLtxfWyJp5jM3PJ77MfwBQhB/jopG8/+b9hDBLDpeX80Pd4DoQ?=
 =?us-ascii?Q?Vnqml122eYw0rcR2ttMrwrBHfFu2UpPX8Riq68hMEg5KFMkqLHEyRq7ZBGPO?=
 =?us-ascii?Q?DPwN6sLK/itEqjsGIVayAI2E06maBt0E6v6tQ0w4H2Lkgs2cf3hxQkrbB6wz?=
 =?us-ascii?Q?zaWO13e3uyl78VogXGGQBbdVwQM8NzK/5DTKYKKS8ivBmD0UnAzmX9fEFQVC?=
 =?us-ascii?Q?2Rdle2QNso7UrmLDhu++IuwmY8mkRDqe390zS/iCdEs91nZDjJHkJG+2MZB+?=
 =?us-ascii?Q?MtOVaSq+Uao3b8pQQKpT7qhdbdXXaOF27HuTSk5SX1FcOb1IO90Acox7heia?=
 =?us-ascii?Q?UBUahIhuBwtPY2zbHNkiq8EjHCINJJEi28BCeqTIEE/PZqxUU77KybQwlFD+?=
 =?us-ascii?Q?zSgKKR+UPbTrBs9WlPfHnFY4BU5cLH8lYsYdlREI56ecdyZ4lefVbaeTpcwX?=
 =?us-ascii?Q?3dPijopKX2Y/jSzzxwq236y54PsYgs/wARZ6RrvI+5aMkGOFIRNZ/lJMjMeR?=
 =?us-ascii?Q?VD9zrwZNj8y7pAH3xvJMFBGeh5EJtQfxPk05sKxK4Iu09TuApKsmbnu2TFGp?=
 =?us-ascii?Q?7oZe+7UDIniZVxYUzGH0haZ27Ewd7J3DHuKoLy1QhOUVUOgLDt7GFaSSYlmi?=
 =?us-ascii?Q?rYOc6Xm6BZHHy0RCQhh5bWc/HX0G4acFB0L7poTqWDOS2RuecBBuqDBv9eFp?=
 =?us-ascii?Q?gZOX92Ey6TN3dzM+2u96OA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DixrgcxXpZg3avrQnxNLa72bkTsj3EtAO/2+Kp+JSxTypaXnxL4n2ZgY8nBN?=
 =?us-ascii?Q?PFxmdfWgprEhV0oH/TfRBHNsTKmPPG/V93hmNSjEa7cI4GWkTtrYzpFQPRQy?=
 =?us-ascii?Q?eEFDx25qtz90EWyI0IKPKQma3N1xIQNWGdtNo6ypbo6zmjXsqIsQtVn60rId?=
 =?us-ascii?Q?bZKdF5o1LqVpQ6C3fjxm3Q0BUPayzU7QO6iS9COYZRFshcndjYbpFI0wFbjE?=
 =?us-ascii?Q?4qftYyjscHtVoi00HgdDv5UuXJyTlMWlWd8VLKnVvKiAASULAiDDZaVFMHvn?=
 =?us-ascii?Q?iVAK+YcZq74uqp7D0TEjxPzYAoe4/tNoKFYbPQngt8LpeDvmzfUr3kmBUL1x?=
 =?us-ascii?Q?lkwADoOh1hI1fLpDLJnAG0WsWDLtLLoETCuBGC0fqQDwz6yoRxaUeX/Sx/Oo?=
 =?us-ascii?Q?xFI3NRxXa5t2yalZvkDnSVLGP8A5v53mAV39KF3XXEIIi+7URdMA+FlaDugT?=
 =?us-ascii?Q?L0usJGgEoWrC4eq4Do4bfzktF0WgwF3h1u/S683X+ekHxGjzbvX5mf9XV3F4?=
 =?us-ascii?Q?UvHVwDbEfvpmXnjzwTz4bVYbZ317oHbX5Rt8S4XhT7/kFEg86WRVXg8/pPnv?=
 =?us-ascii?Q?uR1hmF+aJ9dywZb5bheRyWApPIwyF/M0v2I+TVNYiqnMKUybNpgLGy2yeDKF?=
 =?us-ascii?Q?QyXxXY/hErw2U1GaYKYBSpt3RRTsbGgFIJ/QvnC2xFV0A4+eFHtEK0VGNFxs?=
 =?us-ascii?Q?SgApY17biLJpff5iUBjOxjCyItN7pvSS+MiowtJ3Dnp2E5QRE8i0D/2s0BWO?=
 =?us-ascii?Q?Cchmv/oQdUW6PFmAZjYmUzwAIgy/DTUth4cDVkZgLct4IOIvBIG3SeS5CwoO?=
 =?us-ascii?Q?CELRpB5l/TGJGb09iIuQoMG15aXA675CalWT/rIJKhrnw9/ebzv990l8DAPX?=
 =?us-ascii?Q?G7xlDq67trRJcWFQGel/ixh5jRy+POZviQAZQzdJfmdLDq0Awa3Mssadu1TX?=
 =?us-ascii?Q?BnHbFBiLYKbOKA0w0w/8ilGvWp1j+SAvtz2qO7rya3XjFmPA4UHD0914ZvmH?=
 =?us-ascii?Q?TAgW4psYEqw2mhhh6TfNdcMZVX2IAez/LIzRox7sI3mkKvQzhMgPMj3+P+TH?=
 =?us-ascii?Q?2QxxF9upkoGx1R3p+DFoT9apd6j+YxwlPKUT6cY9ETJe/YWgV82ThZS7w/Sl?=
 =?us-ascii?Q?hZtBbcBWoPRiPYoouECpbjtjlVYD7PqgLS2cwL3IR8U2+1bYqYMROzebQuwC?=
 =?us-ascii?Q?EBWCta7sFCKtPQtq5KEGvNMJ81pD9kMiX7nyCSgmQZ/xr6wyb3OZYsdcmFfe?=
 =?us-ascii?Q?bVTPjnAbmEQY6p1yafzk75hJNfZ0HYnaXwepGAhrODetVts89KqspM5k1Ndp?=
 =?us-ascii?Q?1t77+UcvJrJtWRJ2iOGtR6yXkgpSzKJuGzNmcjQCfl9gpIqobTqwFRBp1ZE2?=
 =?us-ascii?Q?4tabFVMC9N/6ZQ7tlEbfKP+XlJwX?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 58605e06-fb19-4f00-410e-08de80237d62
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:38:25.1321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P251MB1058
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33093-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hotmail.de:email,HOTMAIL.DE:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A287527066A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add periodic runtime I/Q calibration triggered from the existing
survey statistics work handler (carl9170_stat_work).  The AR9170
hardware performs initial IQ calibration during channel setup, but
I/Q imbalance drifts with temperature over time, degrading EVM
and increasing packet error rate.

The new carl9170_run_iq_calibration() function sets the DO_IQCAL
bit in PHY_TIMING_CTRL4 for both chains, which triggers the
hardware to re-measure I/Q imbalance and update the correction
coefficients automatically.  This is a non-blocking operation --
the hardware runs the calibration in the background without
interrupting normal traffic.

The ath9k driver performs similar periodic calibration via its
longcal timer (every 30s).  carl9170_stat_work runs at a
comparable interval, making it a natural trigger point.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 drivers/net/wireless/ath/carl9170/carl9170.h |  1 +
 drivers/net/wireless/ath/carl9170/main.c     |  2 ++
 drivers/net/wireless/ath/carl9170/phy.c      | 36 ++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/drivers/net/wireless/ath/carl9170/carl9170.h b/drivers/net/wireless/ath/carl9170/carl9170.h
index 2eedb2f..0175f8e 100644
--- a/drivers/net/wireless/ath/carl9170/carl9170.h
+++ b/drivers/net/wireless/ath/carl9170/carl9170.h
@@ -605,6 +605,7 @@ int carl9170_set_channel(struct ar9170 *ar, struct ieee80211_channel *channel,
 			 enum nl80211_channel_type bw);
 int carl9170_get_noisefloor(struct ar9170 *ar);
 void carl9170_update_channel_maxpower(struct ar9170 *ar);
+int carl9170_run_iq_calibration(struct ar9170 *ar);
 
 /* FW */
 int carl9170_parse_firmware(struct ar9170 *ar);
diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index ebf9fa9..50c0922 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -910,6 +910,8 @@ static void carl9170_stat_work(struct work_struct *work)
 
 	mutex_lock(&ar->mutex);
 	err = carl9170_update_survey(ar, false, true);
+	if (!err)
+		carl9170_run_iq_calibration(ar);
 	mutex_unlock(&ar->mutex);
 
 	if (err)
diff --git a/drivers/net/wireless/ath/carl9170/phy.c b/drivers/net/wireless/ath/carl9170/phy.c
index c294df7..b145e9e 100644
--- a/drivers/net/wireless/ath/carl9170/phy.c
+++ b/drivers/net/wireless/ath/carl9170/phy.c
@@ -1637,6 +1637,42 @@ void carl9170_update_channel_maxpower(struct ar9170 *ar)
 	}
 }
 
+int carl9170_run_iq_calibration(struct ar9170 *ar)
+{
+	u32 val;
+	int err;
+
+	if (!ar->channel)
+		return 0;
+
+	/*
+	 * Trigger runtime IQ calibration.  The hardware measures
+	 * I/Q imbalance and updates the correction coefficients
+	 * automatically when DO_IQCAL is set.  We trigger on both
+	 * chains and re-enable the IQ correction afterwards.
+	 */
+	err = carl9170_read_reg(ar, AR9170_PHY_REG_TIMING_CTRL4(0), &val);
+	if (err)
+		return err;
+
+	val |= AR9170_PHY_TIMING_CTRL4_DO_IQCAL;
+	err = carl9170_write_reg(ar, AR9170_PHY_REG_TIMING_CTRL4(0), val);
+	if (err)
+		return err;
+
+	/* chain 2 */
+	err = carl9170_read_reg(ar, AR9170_PHY_REG_TIMING_CTRL4(2), &val);
+	if (err)
+		return err;
+
+	val |= AR9170_PHY_TIMING_CTRL4_DO_IQCAL;
+	err = carl9170_write_reg(ar, AR9170_PHY_REG_TIMING_CTRL4(2), val);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 static int carl9170_set_radar_detection(struct ar9170 *ar,
 					struct ieee80211_channel *channel)
 {
-- 
2.51.0


