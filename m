Return-Path: <linux-wireless+bounces-33333-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II2xAJcbuWm+qwEAu9opvQ
	(envelope-from <linux-wireless+bounces-33333-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 10:15:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6453F2A6504
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 10:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EACA3303FA9E
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 09:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABAE359A9F;
	Tue, 17 Mar 2026 09:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="cmJ/Cd6k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013087.outbound.protection.outlook.com [52.103.33.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9913563C2
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738656; cv=fail; b=aW7/4ATCaVej8ufOyupqT951kN8qYSyp0LwXVKpioe1rtHVAPvQ9u+xLNFGr0uRxTUt9hu8zNWykddjF2bxYrff1p1bBBihJjsNjoumorMw7K4euzN2gScSyVBpy86uBP2ublQxPGSvE0yI5HraT8vL21ydyWD8qap9gnoBNceU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738656; c=relaxed/simple;
	bh=20AgJEu5gQWdKuyVYnUcuBzrocAvE7yZUMFBQUKGZ0k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SnjaS0xDNYxWy/UGGMCaTNGCRdqm361ZS68oOTfzLy+5MaTB3xIui7ED7a9spfrPqZudibzyEYV7nmiaAu9TX8ih8U8A9mmVnQ5JW6AR/Xe2A3eNftfLx1CImSVHxZ1/gjtcIDYXuef7Qo5XMkDnQbUm9jIprIa7vjgQqfRx+Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=cmJ/Cd6k; arc=fail smtp.client-ip=52.103.33.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wS25IUCZ59vtkw3ZxLwSTb/rJ/IelAZhk0cha1064n9dN0rWWCs7PML4RgQ23YebkA3qUBAV0GxfhH/cwA2eZFS0QlrPMimwe42buXF3AviecHGvaZxIMDVKeJP+eAB3FjH0HnhjkWlhk4Wu0x44YZiJAckTZmeS7+YtJ1eanhPep0PNUDmumdrwLIfrMQI6y3QeFkHYfaugWlBUz5Zdi2VrzBg8Z1KYYfWGMGf1RuF0hiN7L+Q7NFLeUX3Xf4cSCIOQi/od6SyQlCkNrc/bjCRWM8lVVdrHZHV+IMfxADgIVULm4u48srJZCm59F3ks4iFZWyUARdMoP/Et2FTbbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihtXr2xlSZs9wDF1YtfmSECY02i4yj7DjxAzjSf7n6c=;
 b=oo5IUjOTZxMSclt2vCniVUkeVoVG9XDWq0d5minWiexMlkowTA0v9IbsuBmzz7vJbSZBKTtEhkIjHhKAZqd8Mp0983Bw824ScSEFPPeTs4N/ANFf/cUj9ovsLA+tHMrnEQV3RelLjzScbnfBB7xdAlF8BJTtKK9zV0Z9J2fsPBt8rV/NVoWq9YAMG9xd6j2EfVcd3qKyYvMQ6L6ZfZj6w6h9inJ5uik03nr6lf3Eb+9AMsAREOs0qo2QU0Jjw0uR8nReU4IAyQLEUQFcHWeGnF400AC3Ntv0XvfBbMSHjCFrwxoxZO5gaBj02Ckevi4OtA2E7zUGsO2VZNYWOxRQFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihtXr2xlSZs9wDF1YtfmSECY02i4yj7DjxAzjSf7n6c=;
 b=cmJ/Cd6kXq+bLaelR7gUW7Vv/GfqkVGm4TUFHHZbjcD2VvnLijChkGEfdTXzJFl69piEGWCwIKuW08yHYHbqI0NMezTD+H0/te6ejl8nukg9V6QhdX5phe5qmIWz8ziVfb+zjc+FZiBEFqRuck4AFmt1uYyXKXPRdG+808CBwcoaOXboDY0f0442wqlYdgrGrMndl/ABRteiUYMespta7fpNDSrXhgVTocKTNUtW2HrNaW0HGwlE0pGIXRK7oO4dXetbiwduERh4zYwMXkmbdPmzlKGCj+XTMgLJkLtJLOHqaAqukG7eMRxAN82sgCpXbp+4ZTCh8F7s2uvjnNEpCQ==
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851) by PAXP251MB0579.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:284::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.18; Tue, 17 Mar
 2026 09:10:52 +0000
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::596d:6ad8:b60c:c9eb]) by AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::596d:6ad8:b60c:c9eb%4]) with mapi id 15.20.9700.020; Tue, 17 Mar 2026
 09:10:52 +0000
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	Masi Osmani <mas-i@hotmail.de>
Subject: [PATCH 11/12] carl9170: skip cross-band channel changes during software scan
Date: Tue, 17 Mar 2026 10:10:44 +0100
Message-ID:
 <AM7PPF5613FA0B64618E70AB9ECAA3B65FB9441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::9) To AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851)
X-Microsoft-Original-Message-ID: <20260317091045.23696-1-mas-i@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PPF5613FA0B6:EE_|PAXP251MB0579:EE_
X-MS-Office365-Filtering-Correlation-Id: 460e86c7-7d38-4fbe-3b55-08de84051651
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|5062599005|5072599009|461199028|41001999006|19110799012|8060799015|13031999003|12121999013|23021999003|15080799012|3412199025|440099028|3430499032|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/G66AMJzd9+XAhcLmC/jhgNQqVpgAd+tA5Yftt7tvN7NkUpu+06reCOADFy3?=
 =?us-ascii?Q?LYKyYnDFt6VHm1/AaWrJ+2bxxBpNNN8oO96sMWMr8hwNtyPv+ToDR1dZ7wnd?=
 =?us-ascii?Q?AitSjXcyvIYo0tzUiry5V3jqCrvR2pGownBuE9ikyylWs5g1HuKFtGTTZr3+?=
 =?us-ascii?Q?fz7X2dddmDqirbkKyIaMEubvQJHrI64vGSxxkbrthKc2728bmajMb7aetwTL?=
 =?us-ascii?Q?vl/zdEFrJ8+wZfLShVvhfs7xLJ5QB9HkqwxbOjHWhWF+7FHsJpAjq6HHTn2I?=
 =?us-ascii?Q?jVIAI5x7XbSf5YIkeuu3X5i0ycd+und/Vj/GyuxgMZ4Q3AyTHc5U7YSwotP6?=
 =?us-ascii?Q?yQQcw3yp/zJdB6D9w31Oi+e30qOrgVJjqb45cVxjIwCRarrewjYnUvLiuKtI?=
 =?us-ascii?Q?GyICf3zsMW+0Bw++g0PgeDZex9FVkKS/6zqLJcU9v8hfcpp43uSEEPiOngif?=
 =?us-ascii?Q?kW01aQWFekfeK9VVIX/fWFnqaB7N0R+BOL0C9SD+DNF2JmIIeUP8Hi6P4xZU?=
 =?us-ascii?Q?5fEV/MXRl1Sj8VAsnpg3dCFfKQU1pnyxSI9s00VVnaiPIzVsdDSOdcOsM/z/?=
 =?us-ascii?Q?h11z8SnYZfk9FXiV1vYBYzYkyhYy/zBiXeKaARnVysKkgLnebafHNKgBSv8L?=
 =?us-ascii?Q?3/nXul72/ysRMBLDkJqghFaf+Lt+3TK/ttcHONFIj/j7EBDDYtu+z2/Y0EcG?=
 =?us-ascii?Q?VbR3l5iYsgBsBUxI7JoyyoC5K9lTZ50u/xNFxn5m6Jz8SEGmnJW2o4xxqya8?=
 =?us-ascii?Q?fdvvu66Xq9+mND6sYF3758+Xe05YyfdQRoLwUx55VfI8cNwwrXZSJRa1COBu?=
 =?us-ascii?Q?4kAQjl2IkMz3gScI2e52+9SqOAgvW8cXMjCSt6d1NENROjZgyUlp3Ljg0wIh?=
 =?us-ascii?Q?0lQNnRxWRRepzxnTuTzQL0QhXOIqRBoSzp5yHrz7KGojnY3g6zakKasvoc1z?=
 =?us-ascii?Q?Lg/s5RU9ixKo5HdHCMuEqw4g6DcQ1bdNAI3wldXRM9XcUO/ZLsyN9E2M+z9i?=
 =?us-ascii?Q?/SancUmd+K+pGvrkMgHjuHNA+sIfCoEM6WMU8gIgpd4+Zv6a/wj0xlQeYRdu?=
 =?us-ascii?Q?pUDPlOza?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jdX+XhhsWx/j/lTO6bT41j2Afv6llLLZ+rHelIqJqtubr4yxjddDFyjw1dQc?=
 =?us-ascii?Q?IUQDYh6oiFpiYCEGV0pJTWKL1gvI3BtKRpShXdLX2/cAXRthdNuFZ9Mr0f4p?=
 =?us-ascii?Q?dACyR3zbdt7QpXmVg42OjridA/TplJc6jx0Nplm+H4pXW66SIckzYCNRSwsN?=
 =?us-ascii?Q?kP28AnY0TFlrmaBKASBPJc/gVPBoQCCXq+joRsiU4Br8kMus1Yy587WuGFBQ?=
 =?us-ascii?Q?khAbAN6ha/VIU6sLHCIA3rVdIUkYHtODMoHk/qwHxXRtgvwkL1WJPiNE/st5?=
 =?us-ascii?Q?ir7aSG3R7c8J01U1sQtNqtNNr0+7U91J6ovtpqen09NyVRowv7j3NH4QQtdZ?=
 =?us-ascii?Q?a0dJpUA5BZ4mxkB/p5jHCX0TnVuuxUqPPRGyRDRdrLXW3q33yFtRuhis26t1?=
 =?us-ascii?Q?iW20Dm8/6JGFqS3JGY6GukwriwhRu4A1SyW+gnH7DFQnNZ0W9Jmyf2RTX73q?=
 =?us-ascii?Q?PD0BW6Gtm0gF1cGU/VYeSR1ywqV+KRXQP0bm+hUaVrGj1whYw98KPVwnGl8o?=
 =?us-ascii?Q?aC4VFtm01b473Vt796NZnyNfACSCfLaQE65bHP/mY15FALTHwOkMMjME1XRH?=
 =?us-ascii?Q?qh2gUnlrNb5e+xUm14Q6KnAgvWjPMca5csyGmB5kY0zc4HjAqkbfKmZifU8s?=
 =?us-ascii?Q?EQb3H7OkLkPzezI9H56BFCyGIk0NYEkxXIHpOrF/pXeCV7cWIPmN0GgBr8s9?=
 =?us-ascii?Q?EH2ZW59ak1LTSDLw2HXBnDAKM8HynMSzwkCU/GVYbWAnIz884dSnnQAxqyYG?=
 =?us-ascii?Q?XuoMPqSUr32e0wzFMzrryhON6K86L8oLfWeMvuIV3szXJ9umpxKS1ZmkgZlC?=
 =?us-ascii?Q?eFqfKHJfSVBG0jwiiCm5EnXEMCcVZUlLeI5xP8e3o99MHbEPOdD1UA5KFAgn?=
 =?us-ascii?Q?V19LVqEymjuN6eKEDNqQyVChu2T/YJBjmKDMagUxt/ZR2ReebzX5gFuKmSTr?=
 =?us-ascii?Q?zB5oqoFbZT8dhoGavKjqwMcLdSAZ7bdwkxtP0li0vDm5NebBVTG0zcHp/FFr?=
 =?us-ascii?Q?Q2WVPDCShV891J6OKFhdCDJ6bc8CGyhrraZt6LpodT9Sk1/YOLSzo7Q7/y8n?=
 =?us-ascii?Q?1cHRAX/QYEc1L0RHuswlpaYuo7k3oG1dApcvENGfk615Ynd8VYIVyxbGLLHM?=
 =?us-ascii?Q?HnDjvdogQI0xYr2T4pzhC5pLgh48A8M2fnREvudzMDm4j6FEiheIa+5KSHyt?=
 =?us-ascii?Q?jyDqNxCBerL1DOPYzITfYj95wK4JdevKTAaIV6CMUN/17lCbTEeFmiPrA+gY?=
 =?us-ascii?Q?sBuvoEruPzYVU1M4lQW+QVCPVucNPb8qeH4LlDEJyFo6v0jV09xvSIsWQvoS?=
 =?us-ascii?Q?JAUdE1TXAFqFxLhCgP65weGnU4irRket5P5VZ5jTwaajtD2apVRpUgfVnk2b?=
 =?us-ascii?Q?YScTtu/nPGifbCla+Pa3/1IUZG46?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 460e86c7-7d38-4fbe-3b55-08de84051651
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 09:10:52.2608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP251MB0579
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33333-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,hotmail.de];
	DKIM_TRACE(0.00)[HOTMAIL.DE:+];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mas-i@hotmail.de,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[hotmail.de];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hotmail.de:email,AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,HOTMAIL.DE:dkim]
X-Rspamd-Queue-Id: 6453F2A6504
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The carl9170 relies on mac80211 software scanning because it does not
implement a hw_scan callback.  During a scan, mac80211 iterates all
supported channels across both bands, calling carl9170_op_config()
with IEEE80211_CONF_CHANGE_CHANNEL for each one.

Every channel change triggers a full baseband cold reset, RF bank
re-initialisation and AGC calibration via the firmware RF_INIT command
with a 200 ms timeout.  Cross-band switches (2.4 GHz <-> 5 GHz) are
especially expensive and error-prone: the AGC calibration frequently
times out (firmware returns error code 2), leaving the PHY in a
degraded state.  Subsequent channel changes -- even within the same
band -- then also fail, and after three consecutive failures the
driver restarts the device, causing a multi-second connectivity gap.

When the adapter is associated on a specific band, scanning channels
on the other band produces no useful roaming candidates for the
current BSS.  Add sw_scan_start/sw_scan_complete callbacks to track
the scanning state and skip cross-band channel changes while a
software scan is in progress.  Intentional cross-band association
changes (e.g. roaming from 2.4 GHz to 5 GHz on a dual-band SSID)
are not affected because they occur outside the scanning window.

Tested on Fritz\!WLAN N (AR9170) with 2.4 GHz association and
concurrent full-band scans: no channel change failures, no device
restarts, no PHY corruption.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 drivers/net/wireless/ath/carl9170/carl9170.h |  1 +
 drivers/net/wireless/ath/carl9170/main.c     | 42 +++++++++++++++++++
 2 files changed, 43 insertions(+)

--- a/drivers/net/wireless/ath/carl9170/carl9170.h	2026-03-15 23:51:23.598565789 +0100
+++ b/drivers/net/wireless/ath/carl9170/carl9170.h	2026-03-15 23:51:39.769123563 +0100
@@ -333,6 +333,7 @@ struct ar9170 {
 	/* PHY */
 	struct ieee80211_channel *channel;
 	unsigned int num_channels;
+	bool scanning;
 	int noise[4];
 	unsigned int chan_fail;
 	unsigned int total_chan_fail;
--- a/drivers/net/wireless/ath/carl9170/main.c	2026-03-15 23:51:23.597355728 +0100
+++ b/drivers/net/wireless/ath/carl9170/main.c	2026-03-15 23:52:02.845563524 +0100
@@ -916,6 +916,33 @@ static int carl9170_op_config(struct iee
 		enum nl80211_channel_type channel_type =
 			cfg80211_get_chandef_type(&hw->conf.chandef);
 
+		/*
+		 * Skip cross-band channel changes during software scan.
+		 *
+		 * mac80211 sw_scan iterates all channels including the
+		 * other band.  Each channel change requires a full BB
+		 * cold reset and AGC calibration via the firmware RF_INIT
+		 * command (200 ms timeout).  Cross-band switches
+		 * frequently cause AGC calibration timeouts (firmware
+		 * returns error 2), leaving the PHY in a degraded state
+		 * that cascades into failures on subsequent intra-band
+		 * channel changes and ultimately triggers a device
+		 * restart after three consecutive failures.
+		 *
+		 * When associated, scanning the other band yields no
+		 * useful roaming candidates for the current BSS.  Skip
+		 * the channel change so mac80211 advances to the next
+		 * scan channel harmlessly.
+		 */
+		if (ar->scanning && ar->channel &&
+		    hw->conf.chandef.chan->band != ar->channel->band) {
+			wiphy_dbg(ar->hw->wiphy,
+				  "skip cross-band scan: %d MHz -> %d MHz\n",
+				  ar->channel->center_freq,
+				  hw->conf.chandef.chan->center_freq);
+			goto out;
+		}
+
 		/* adjust slot time for 5 GHz */
 		err = carl9170_set_slot_time(ar);
 		if (err)
@@ -954,6 +981,27 @@ out:
 	return err;
 }
 
+static void carl9170_op_sw_scan_start(struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif,
+				      const u8 *mac_addr)
+{
+	struct ar9170 *ar = hw->priv;
+
+	mutex_lock(&ar->mutex);
+	ar->scanning = true;
+	mutex_unlock(&ar->mutex);
+}
+
+static void carl9170_op_sw_scan_complete(struct ieee80211_hw *hw,
+					 struct ieee80211_vif *vif)
+{
+	struct ar9170 *ar = hw->priv;
+
+	mutex_lock(&ar->mutex);
+	ar->scanning = false;
+	mutex_unlock(&ar->mutex);
+}
+
 static u64 carl9170_op_prepare_multicast(struct ieee80211_hw *hw,
 					 struct netdev_hw_addr_list *mc_list)
 {
@@ -1723,6 +1771,8 @@ static const struct ieee80211_ops carl91
 	.add_interface		= carl9170_op_add_interface,
 	.remove_interface	= carl9170_op_remove_interface,
 	.config			= carl9170_op_config,
+	.sw_scan_start		= carl9170_op_sw_scan_start,
+	.sw_scan_complete	= carl9170_op_sw_scan_complete,
 	.prepare_multicast	= carl9170_op_prepare_multicast,
 	.configure_filter	= carl9170_op_configure_filter,
 	.conf_tx		= carl9170_op_conf_tx,

