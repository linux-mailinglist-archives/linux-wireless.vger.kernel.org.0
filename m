Return-Path: <linux-wireless+bounces-33259-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LU1Dh85t2nVOAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33259-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 23:56:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9449D292EA6
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 23:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 290D93012C43
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 22:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2529D26FD93;
	Sun, 15 Mar 2026 22:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="nSA4EiJU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19010023.outbound.protection.outlook.com [52.103.32.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779C12512C8
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 22:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773615388; cv=fail; b=EPbjhxb7fPQYhYajHL+393OLTZP6NsroGdReY35N8hJ9Erg5ujb5DtGkvyy7vGUDDTS+Y141f5lXz7i2AF3VEO1ILeEKyq61iajCumO1lDo9OZZiZdDo70mdni9R5b/gsO1eDvHdAAVdgn/ti9SL1/YSODKPnCXZO31awbf10bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773615388; c=relaxed/simple;
	bh=20AgJEu5gQWdKuyVYnUcuBzrocAvE7yZUMFBQUKGZ0k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=l6NuNTNzm84TGoUqJYcw3+oUv9gOKIuZerJU+h7N8odU7JxJS6f/UGxN6j4mGTepvqs2RUbYUaMSeDgVUacfYUejWqFvL1LAyaHvBv1Kywa1sBrqy6u6VsXGRUt/gaR8THNtPQFJml8CqYTDyERzLkRhb26OuaRLPs/o0ZPtAKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=nSA4EiJU; arc=fail smtp.client-ip=52.103.32.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFNjNOwGnSShxDLXKanlSmdYRaLZNPvT/QGa3rcwBZ8ffOY/jFKAXLVEfI7iTTtmgajE86sjqzk6WIFBFCxAh3fzrP/fEsvMIlSsmuRbDdhTZAreAmFecthzVn5b+psH1fxBs+zFwQY+1luBMAzNfimDVgijn3qZc7ajlDBXpdBW4PjhkWDF1xD5fOUCFbQ6UEzDNFCNfppc31ftHwVzHBNIlFT8rRK/Na5aRenOf5FMScv7cAqeVTs0QYSG8Q/BgW8cbcqQIgNkIsmrhvZFELTDpw13j4WeBL461qauj0TyEr9L7FhIN/cwB90Ltz18DBzUk6PUwXadEPTSx0IUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihtXr2xlSZs9wDF1YtfmSECY02i4yj7DjxAzjSf7n6c=;
 b=iISCLuD4mC3d8z7U+8uyh0D04tBQPI8PYpV54XelfGkxPsWtz/sHjLDOh0bgeWTHHfgdaKsWdj9r7im7GK5QvkmRyeOMy8DJxPL4U2dsxKw6XPFFBNQpXObhugZjDKdc91p5s9k8ntra+pgs6tT91aLXhWFtTcGatjK/vR4nK1apyHv8dXQF5ID8tf/o15U0GMl+RTPyNrLSeyC9LNfjn+xkOjJ5IChnV23INlkl6+KwMWfdVk2dqA3mUOtLZBQt7YZUaGLYS0CZix4la6s6+74UncENyP+MKixoVW4WlK3C6xWaV2DdXg+bbO+QStHA5vpadXGQLNEHYKOc9o8AAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihtXr2xlSZs9wDF1YtfmSECY02i4yj7DjxAzjSf7n6c=;
 b=nSA4EiJUDUCbqSJl1rUpPhQmFQ8YEcWJnn3KilMckbtB80Bmm6i8QVSG3NrBzycYALLNnP/mBzNhEDvfPkLMg//AdMcWsxA2bcHEl6oka/HHp2b4tCKCJfh3zZCWWIbwckmPeXL/+NHVcUwmCOhppsXl/DtAOiJJDu4d7rJZ1R/c/IBpMCRSZW97DjqX3avhzxLLaUOTo1M1iz8pUxzhwU67rhabpHTNMSCPaAtnsH7CPMCXB/wldENKKWWkIVygnOnu76RCTD8jrGynxveiepI6Me34oGi16QctT7tKKL0QEU3L6Y9PQII0rYRH0jG/qdElndMQ86lau5UwBLbGwQ==
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851) by AM9P251MB0070.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:41b::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Sun, 15 Mar
 2026 22:56:24 +0000
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::596d:6ad8:b60c:c9eb]) by AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::596d:6ad8:b60c:c9eb%4]) with mapi id 15.20.9700.020; Sun, 15 Mar 2026
 22:56:23 +0000
From: Masi Osmani <mas-i@hotmail.de>
To: chunkeey@googlemail.com
Cc: linux-wireless@vger.kernel.org,
	Masi Osmani <mas-i@hotmail.de>
Subject: [PATCH 11/12] carl9170: skip cross-band channel changes during software scan
Date: Sun, 15 Mar 2026 23:56:08 +0100
Message-ID:
 <AM7PPF5613FA0B68A6825857195D5EF51B59443A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::10) To AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851)
X-Microsoft-Original-Message-ID: <20260315225609.61791-1-mas-i@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PPF5613FA0B6:EE_|AM9P251MB0070:EE_
X-MS-Office365-Filtering-Correlation-Id: b7d37ae0-029f-4b6c-1504-08de82e60d8f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|23021999003|12121999013|8060799015|19110799012|15080799012|13031999003|5062599005|461199028|5072599009|51005399006|3412199025|440099028|3430499032|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KvQ+2C7yzaw0RCVmmTqB1VYqeWVlJRMAncp4iddmqaNRp2RPOoWxxFiCNCu3?=
 =?us-ascii?Q?MTyR+zGOr0OsBtwproIFl8oC6O9E79uS+uC4DPERsEcOgg1gWakoi56IkPTv?=
 =?us-ascii?Q?PippsGCBqQ4o5wqx7GY3CiKLop1R+mcP6A5z20L+XqaueyepSmbCh73PtY30?=
 =?us-ascii?Q?i+/XGN/rSiHVZlcfnEOS/QpjqfwMfWG+6wIGMEIg3bQYB1GIZsDMsMMQU64u?=
 =?us-ascii?Q?j06VvuHrx4Q9ay/yBKIQGa2CEn8AFganosxbdnmQoGWZee+UJh6BoWP4Ib80?=
 =?us-ascii?Q?yG3t3LZCL3nL74hyWEM/1N9duGLz+rzA4YPn1ze1NxiTtz8He4IF0DU04lgX?=
 =?us-ascii?Q?NSpu32esHzEdXk+E9qo+fv5wEwe5Ru80fVq60OdoIJXisx1eoTN901pmi7QT?=
 =?us-ascii?Q?WZ3yQo7RwPOXpCfXH5y82lEScVGMhcWMvcCW/c9lYAc/xnLHTxtVZ52jNRFF?=
 =?us-ascii?Q?RAsDmybpKjYn+LlIE1tg6RX+GwtDmNNkawaTDz18Ngg6wktlk9J9+4tGrcSy?=
 =?us-ascii?Q?yKsDPQgcM5KZEN0GotxjItXQSirJt8rbcBgNaNTZwIGpHss4pX/eILTeJkaq?=
 =?us-ascii?Q?PQTIZCg4jrdOuKEcQfWCt08IQwA4LNg5vvBHJcZupadr4JtkuasYaukdvSUR?=
 =?us-ascii?Q?jp5vzM84i0AnxUnjb7ZjNSxIcrC3BbT3ZmNq3FzgqZWLE6AgIZpeJSqp/PYM?=
 =?us-ascii?Q?ttiOwcxXjkVcK+LWATiCbS3kFSGObFI+6BqeMcbTv/eUdFaIhvv3e6jAFJPS?=
 =?us-ascii?Q?iprSF2ad7+jh1iTJMJHrU4a5gZMBFWsj28IRXPCs5QokwOhqF3ntvOR0AGah?=
 =?us-ascii?Q?g/8SJ6KejPl6oKdUknfUqNCP9RJ5QUIQgVN5iLX1MjxaQlFRHI6E3wmhDuIQ?=
 =?us-ascii?Q?JlvorlprgeODGH7NcWgZm48zRSquuxWznmXixNFOwWyhFTywDt7HIMRcd/Hq?=
 =?us-ascii?Q?UgRU3z+waYBmMMXjNZaAJ6SLZyoqSpkwKhNud20oa8Ujt9lpwh13jqcCqSBv?=
 =?us-ascii?Q?KUGN62f7H8jStOaZrJHgpO3m3no+2CxoTGxctUeFY5bvOU24Hm3XPqLuIJPF?=
 =?us-ascii?Q?LjRvrQox?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BFvgJgIgO5S5xllmSFPV2cnWgydiuBBE8/fTBaZUsnrcJfXEqRyfFRO7/KZp?=
 =?us-ascii?Q?xmMygnZ5XsbJLPcv7rkWKCP+GBk0HDgGAMzsAejKJOXsp4J54yY5qOKTsVoI?=
 =?us-ascii?Q?DUTygBfdY9+A0espjDJJXUsfFQyn6vTXI/qlhMaiX9USgeog5jpxbtybyo0I?=
 =?us-ascii?Q?NS8jGyNb6h74PtV8CcizBxAEaYXeeEQHz8vp7fgXHF+pKaXfik6EgdXPxEXI?=
 =?us-ascii?Q?wLFjgmCoKHl46aEU27Tb5jsTeFM0TtXqhZYrXv1ifAH+7qKM0hBVEuBjxMPT?=
 =?us-ascii?Q?z5MvAoj0ZlMlW8yqmps61KXQtrQTlDHfRfOBc7dg9WuBoKJ6GD1dljhSN53H?=
 =?us-ascii?Q?uXxsASrWMl7PJOoPvzwP7QsCiUXdpBsNEp0d20zz6pPpGhXno9k2fYxhaxtZ?=
 =?us-ascii?Q?tRvUg4Uk4r91Yw5STjp/sTiVvmDJYonJihInyVgkAwwEcijpRdJiU7yHIQex?=
 =?us-ascii?Q?jIOs5zbNCSNBDgaE9VoHNyl+Eg92wQHgf1gv2IDBXr0VeIR9/CiA+k0uxDTc?=
 =?us-ascii?Q?WttPuVDt7NZQERMFHoUJYzmFf9j2S2ks3ZaxgExXrURtZSZASLopy/1UTeDI?=
 =?us-ascii?Q?sJdDHe8P4/ytoskCAFkktu1/17kc1aZXR5eo2UXWDAs05uPwDs/7sYm+77nx?=
 =?us-ascii?Q?P6Hy8G+xLm7F22lHHnpHhCvmm/9LzhP8Dj687B/Yvw+T8NT6RM7fXe0TiNJj?=
 =?us-ascii?Q?Z39DG6cMPn1IWfs54qxjf6zgRuKt04H29mtvyroyZfldjcQFLWv5SrqqFiYr?=
 =?us-ascii?Q?XA9KCEvfzMRRQXKK96ZgPRH4+lZMFdmb2dhfG6m4ZGHzLk+lnUmgarqScyUM?=
 =?us-ascii?Q?KwPuaQDeh/WvtNZg6XebtybmdRcx8DYDSLiSsJQefNT75sZLphSGGzAH8M+R?=
 =?us-ascii?Q?HoGIJC1P0qeesxetP2ZwN6s7X5LCm6bhu5pp37kf0YC1OiZIy/EYWWg0cZOS?=
 =?us-ascii?Q?vQhUz5XKP4aCY2bhaVKzC0iLdgnwb6HcppGp+CF52brmJXIXGGxK83yWR+l0?=
 =?us-ascii?Q?KffTTNFi6SZUSDUJYSiZNW4QRWFXYrDlvrA8wXbx0TmrSBkfhgGkFYawuEoN?=
 =?us-ascii?Q?Uq5fa2d6Byxs6LD00nA0CBD5koLAoddGsiJPr58BAxwEQjfbN7NkfaJiBqtP?=
 =?us-ascii?Q?26KpiRnfrxWOVMeFqW5D+sVwqzdeyoJQntuncVYPRU7R+y0OWVcFMINsX2z/?=
 =?us-ascii?Q?2Cx0j7c9L1m6PDzXwCil7mfFtcrOZSkNuj5hoek89YbWnRevDxrSWX42gLRi?=
 =?us-ascii?Q?ID+hg0c771sMFMnsDgZBIrugFbV+No4SOZjc+dLgktNaTmGqhvJe/xmfjG1c?=
 =?us-ascii?Q?h9A/6KD5HgdGryd3YhUjP5O27YyvBop3pURz3WqKUmnmuZ4yz5/4A9jJW3Gv?=
 =?us-ascii?Q?kL9KypOqrj0v8vWXEOUC+/VxImUF?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d37ae0-029f-4b6c-1504-08de82e60d8f
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 22:56:23.9490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P251MB0070
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33259-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hotmail.de:email,HOTMAIL.DE:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9449D292EA6
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

