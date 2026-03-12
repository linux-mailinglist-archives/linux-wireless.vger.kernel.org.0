Return-Path: <linux-wireless+bounces-33089-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SArqCbGXsmnENwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33089-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:38:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B2127067A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5BA030387DE
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28772E719C;
	Thu, 12 Mar 2026 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="G/zcct9a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013080.outbound.protection.outlook.com [52.103.33.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260A63BBA03
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773311901; cv=fail; b=WW7ty8AtcDjFwYsN6moZykCju/UJbhB1fYVl7L10PP9zrpK2M1oHr2p7Bjz01Czx613MHyb8vbVortiVrZ/pjU0/GrbVY80FOUy58+nHngEP5v0awS3fq7r8YYlKDo5FdcmnekUMiQKW3S/EabcAQ8GNJtSOC9RgwiTt4DkMcGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773311901; c=relaxed/simple;
	bh=IgqNIROs45z5dS922IvOt3DMlTZJV2pohZNajKv0a20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IPUqEfc/eD3gJFdaKG+s6FxG3U3pkjbc8KiAjghUUzTALx8zhfUxq8o9JxA3KN6+b0L7wktZudISI1OQVcZgQb/Tt88MIYSLa4HVMx2oh7CNUu5P82gnT/hAahIBuwkfHXqcErkLOD0ZuZNOVX0XAO1uXNmtMCa4n9dPvQ5XOZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=G/zcct9a; arc=fail smtp.client-ip=52.103.33.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbuQWGTyN/b2MffbsF6ySav9oYomjuLiAJySm7dgKfDD4aHpDKnNMdekNV6wh8vj2ZE9dJS366QwVO+hjjx7bwadH3OO2Z1/rEsNBH4jfbtDWj8VxwSi0lt6B7fnZMrhrgNMK7oSKwRMEQ2oG3Iwn8u7/XEYzXYLmERZMJtmgvhqObzy/tvbZgVyjCPs7ntDgKtkzTsBW3Z2n3JouiZveQ1tyb7pSpCUlrZRvPVqMKy+nbavsxts4dwS9GkludtlKAK/XO9GsP6trmw4qkO1Sc9FixaEsnOesEfNRLNI247DIFknxythnkS9CVDyTkpYi/Iceii6abr+aXd124eacA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tl61Qgk1ewBay1VL2EK9E/8IEDqJeeDKnwlRyHv+iyQ=;
 b=yvqPUfLxOLwNsohgks+uzBDY5hPvBHCfrcezhsvsPo/FG7C/A+Npq64HhBcaINbuviJUKZGsKc/1Sjgw3laHAkebWFW0kxb45USGRuQmZkzRfqLv66t97wwwflf+f/gbpywVLxOzcHB+LmU232lrYvu7a10hnjni/JzNm13W6IzYzc/KEEDIjh/NesuwuRlnpp72y4sC9OD5AgMw5pTc00GykMiMnjgwGcCyW1zRnVYunUHDNCC45RWyq3OTs8/TWw8xjZBlaZ1rMn+v5L3N/dcuf0bZlxNB7DA4vmel/uVGwKMFZqhL/9ypiUkkrRwFYYqucdDJlt6gPcVztlpI5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tl61Qgk1ewBay1VL2EK9E/8IEDqJeeDKnwlRyHv+iyQ=;
 b=G/zcct9aUEQ3GyQ2LFhdfGlE/HMZXON9BfJXvGggMpVmiRAqJFd2Wqi/eDTULAvZ9o/fy9tVaz1/RRqnP8vCFxMNFQuNHB2XsEo6VXaGpt1P0Ipf8QmxrFLiYteSkKcR7QZNABJNy3T7Jx2voh0W0SAcdu/KuQ23x1LAFRxfLjwfi7hr+ybFr0rFvEVyv6XACvHTWocjAnm2m907EDPkjwLf5ZBuYVws3ZDkoquwksLlOLSUQ6J5FxzMKnqLfxoTORFqE93niGDz+WoD5idHtYOf6Uiw5RQdDeKtZASqxIYo/UUaK06huJJxelorpjXx/EqIDnpZSu7/sbigODNChQ==
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851) by PA2P251MB1058.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:40d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Thu, 12 Mar
 2026 10:38:17 +0000
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c]) by AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c%8]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 10:38:17 +0000
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	Masi Osmani <mas-i@hotmail.de>,
	ath9k-devel@qca.qualcomm.com
Subject: [PATCH 06/10] carl9170: phy: populate per-channel TX power from EEPROM
Date: Thu, 12 Mar 2026 11:38:01 +0100
Message-ID:
 <AM7PPF5613FA0B6E8EAEDB73BAB87748A8C9444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773277728.git.mas-i@hotmail.de>
References: <cover.1773277728.git.mas-i@hotmail.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0012.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::15) To AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851)
X-Microsoft-Original-Message-ID:
 <5d5772fecee3044a625b339efa11affc453d80ed.1773277728.git.mas-i@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PPF5613FA0B6:EE_|PA2P251MB1058:EE_
X-MS-Office365-Filtering-Correlation-Id: deca992b-0918-4cfc-bf69-08de802378f3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|51005399006|19110799012|8060799015|12121999013|41001999006|23021999003|15080799012|3412199025|440099028|3430499032|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9VoX6hVSdK8yE9A3BY/hW5svT9hYBpHzoH7PPp2t0ZEmUWxL/+o5bqVJBPN4?=
 =?us-ascii?Q?YS6hyuzfsV8zkRSQ0+ZQZhl6yBhdEqQkMVYoiCNW9Jow6iCzSyNZ/S9skDOY?=
 =?us-ascii?Q?OBQFbYloE09ndFi3Jm5H/TLBmAOz1IkjyBYlJCFZLkrnUXY7mERKSoQhIFeo?=
 =?us-ascii?Q?KU1pkGsWbtqsYSbJwrcxe98ETrg21AvlJr7vwgxM3uhlUyLrO20z+hRTp9JW?=
 =?us-ascii?Q?c9988OuclNS3zpkbbdZ2W6p1a+FETyuH7IkDV3pwifsVmZcvK9uisCLnyO1l?=
 =?us-ascii?Q?eG1wQ94cAeC9Bsa9poMTw61oZvYTWUKHc6ZCj80u7n1zsBRrD0tznaNqWbBz?=
 =?us-ascii?Q?k6BnKZcd8cCoD3X6ndj4mtsb/kJmlzAxNWXZApyExbFx6GYyPux88fEUXRJY?=
 =?us-ascii?Q?xRg3BIw+3JMlIPHj2U/Nu7F/vf2ah1Mqhqmjkhvl7GmqbLu++fp0nhwaGBme?=
 =?us-ascii?Q?7gW2hvwwMeeBO6Aw1wDLS9aJFBvaoin4lr52krqsuYEw/jMfaNdyM7bsYWf3?=
 =?us-ascii?Q?Q6iw60LJtTUvheSWjniSVSMfbBN5ucOZRSSKrtrIMkahbBkPdyy6pPLcRWLU?=
 =?us-ascii?Q?E6rodseoeQpdzDsomPt57q4taWm+vDIJcVxdXotWxjVqxfRDplzrTdLEHV0N?=
 =?us-ascii?Q?R0edMd7JgkOQQ8uAaOKvuByZJLEJh5CGfP02+UzrHE9osFQjPf3GW1OnCQia?=
 =?us-ascii?Q?RaWaJ7rEhHbVyJJTOicBHrajTsOLxHiBAm7VroClsPDGacwk9acUmUMpNb3d?=
 =?us-ascii?Q?/ZxlICqLWw+6wzhX1S5xI6e3KXRshr06TZylX8xyefmArNjunlhy/y5Ktp+P?=
 =?us-ascii?Q?XZKh6qO161uy864hPOk/ZySVNTWU05+1lU71BGjb4Tho4pXk8dysIWd5fiYb?=
 =?us-ascii?Q?wV7oN2WeJU+MlZ856zUM4IMRZ4HPewj6Cs9gEIXggx4I/WDsk4yPlOK/vrzw?=
 =?us-ascii?Q?C7KQJvWxrr6EI2VjTwCg5yZGmTbVmhhWlYJXsZ/A8mZDTEPLjhnnfhZknVp6?=
 =?us-ascii?Q?4/xm?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eSKjcR9Fjp73lL+JPwvlj0rEsgwVfbKnk06bfwtPhAyuQbAbV07oqJXcmSac?=
 =?us-ascii?Q?cM0yI+aSF1XUiWBUP/YpaHFscUkORvyyE3nzoX4SFHbWXwYqn/7ZyCdlX6YU?=
 =?us-ascii?Q?PaFqLJQmrFLrtjJILyyuwJ1fsHfBCqLp5jD5JEPvbTZyq+/w7fDye/S1+LbM?=
 =?us-ascii?Q?Rn2CQzZpMkjQWRpBYrMSimZmVU182JLYxQzRRzcQvjqltJBodW23Tlaxecl9?=
 =?us-ascii?Q?x8I1SaF5ei9gVtmY2+dem4atctDbHUzGYT7S+4g3j0f/PXa3/6iDjsXuE9ae?=
 =?us-ascii?Q?dCbdoY1xfPdQXOE+PFyjDi4OrdQg/IIrBlYjJ1HTsdwyaiz1+doFhd6QWL6w?=
 =?us-ascii?Q?L2En/aVU8Phjr+K4yD0PMmPKGP1YyzljNlEudupMgmI7TrXl0HpvSGIq7Qw/?=
 =?us-ascii?Q?UkNqU/C/EhKgxjRqON9YTfW4NekoOFlUYEKhpfc50R/Q8I7hzdWzYOuszS5L?=
 =?us-ascii?Q?UlJmOFqQhShrVhTovvRKc1p9A6pJk2fPH1Fm8ahdZOhIMTbwd1/W7SBbHSK8?=
 =?us-ascii?Q?Plo+sP9nfWlTIN1U+v9pUWTgyWdCWVGPD8apwGv6cgzg4EX5hseN/PUUr1oB?=
 =?us-ascii?Q?DBpxPH7B5eREBAav+vLgehnhhgBUVxe23OmLaYxqswxT/xzcCnXFh3ry6d/9?=
 =?us-ascii?Q?zcgBS6JOghOc/xA5mGq7Hf1oR5dkwNQygTHLkqsYuteCdUK/7aaA5h71+ymx?=
 =?us-ascii?Q?MQtpnaaM8jA1BmihLPrlEIK2c71sVgEKY1udzL9epBN4lXsFRoNJs8pmfsCb?=
 =?us-ascii?Q?0BJm5lEJvYWmS0GSVO7ONmaG2Bqjx2aUN7TsKOz46lusxpwV+pLaWLT+4bgu?=
 =?us-ascii?Q?LPoMgWkwu3suMcioxE1EFlcs/O9bMOlbeiIQB/hlaCM4xGJQ0aUhg3ljiLH1?=
 =?us-ascii?Q?b84f8/5LDo28iMgrSbQNn+Hdn76Z9bfoMtCTvb2bZozygDW/zDl8U3OEMvK3?=
 =?us-ascii?Q?ILcEuFsYB9EO/q81VPArlmSbPLe862K2pZwKI66FguKoGO2Sr4nMO/h/RbFm?=
 =?us-ascii?Q?10jgEignPwdR6XLPmodpx8SlZhbR1iqDhHZodXsozGP1ZAGv+BmOfoQRoV5o?=
 =?us-ascii?Q?QHpkAVDrqtbBp0UHwPk/lbWe8ftKJBQM5Bve6ot1aApC2/efWf22SAZM/fix?=
 =?us-ascii?Q?QEFxT9ErQu5ZFzWmtOWV3qr9OUoxGQVYtz3DdVPVrbaUWXKVnuHNjm8vmRnd?=
 =?us-ascii?Q?jFYPbitcy1JoFyg5HupzQPDzTJTkpCB869quWUgXBhvpMLW+tLcwdRTqdopT?=
 =?us-ascii?Q?b0V5eziLh1wiskB4a3VSoRWlCO6S1w6bn/kAG8Q75DuwEe1Z2Yjr0GLPn0vH?=
 =?us-ascii?Q?lhFgL7+15PTpSWemNYsBvY/+7wl1wmztjPe0VijFAavWyvb1e2vLtBEcLls+?=
 =?us-ascii?Q?vYr+larVYYAo1zELGO/vd18Z0Slc?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: deca992b-0918-4cfc-bf69-08de802378f3
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:38:17.7158
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33089-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hotmail.de:email,HOTMAIL.DE:dkim,AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95B2127067A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace the hardcoded max_power = 18 dBm (marked XXX) in the
channel definitions with actual per-channel values derived from
the EEPROM calibration target power tables.

The new carl9170_get_max_tgt_power() function interpolates the
maximum target power for a given frequency from the EEPROM's
legacy OFDM and CCK target power tables, using the same frequency
encoding and interpolation helpers already used by the power
calibration code.  carl9170_update_channel_maxpower() iterates
all registered channels and updates their max_power fields.

This is called during EEPROM parsing, so mac80211 and userspace
see correct per-channel power limits from the start.  The CHAN
macro default of 18 dBm remains as a safe fallback for channels
where EEPROM data is missing.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 drivers/net/wireless/ath/carl9170/carl9170.h |  1 +
 drivers/net/wireless/ath/carl9170/main.c     |  4 +-
 drivers/net/wireless/ath/carl9170/phy.c      | 88 ++++++++++++++++++++
 3 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/carl9170.h b/drivers/net/wireless/ath/carl9170/carl9170.h
index eaac859..a2ffa62 100644
--- a/drivers/net/wireless/ath/carl9170/carl9170.h
+++ b/drivers/net/wireless/ath/carl9170/carl9170.h
@@ -602,6 +602,7 @@ int carl9170_led_set_state(struct ar9170 *ar, const u32 led_state);
 int carl9170_set_channel(struct ar9170 *ar, struct ieee80211_channel *channel,
 			 enum nl80211_channel_type bw);
 int carl9170_get_noisefloor(struct ar9170 *ar);
+void carl9170_update_channel_maxpower(struct ar9170 *ar);
 
 /* FW */
 int carl9170_parse_firmware(struct ar9170 *ar);
diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index d75688c..dcedcb1 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -89,7 +89,7 @@ struct ieee80211_rate __carl9170_ratetable[] = {
 #define CHAN(_freq, _idx) {		\
 	.center_freq	= (_freq),	\
 	.hw_value	= (_idx),	\
-	.max_power	= 18, /* XXX */	\
+	.max_power	= 18,		\
 }
 
 static struct ieee80211_channel carl9170_2ghz_chantable[] = {
@@ -1930,6 +1930,8 @@ static int carl9170_parse_eeprom(struct ar9170 *ar)
 	if (!bands)
 		return -EINVAL;
 
+	carl9170_update_channel_maxpower(ar);
+
 	ar->survey = devm_kcalloc(&ar->udev->dev, chans,
 				  sizeof(struct survey_info), GFP_KERNEL);
 	if (!ar->survey)
diff --git a/drivers/net/wireless/ath/carl9170/phy.c b/drivers/net/wireless/ath/carl9170/phy.c
index 34d9fd7..290c336 100644
--- a/drivers/net/wireless/ath/carl9170/phy.c
+++ b/drivers/net/wireless/ath/carl9170/phy.c
@@ -1524,6 +1524,94 @@ static void carl9170_set_power_cal(struct ar9170 *ar, u32 freq,
 	carl9170_calc_ctl(ar, freq, bw);
 }
 
+static u8 carl9170_get_max_tgt_power(struct ar9170 *ar, u32 freq)
+{
+	struct ar9170_calibration_target_power_legacy *ctpl;
+	int ntargets, idx, n, i;
+	u8 f, max_power = 0;
+	u8 pwr_freqs[AR5416_MAX_NUM_TGT_PWRS];
+
+	if (freq < 3000)
+		f = freq - 2300;
+	else
+		f = (freq - 4800) / 5;
+
+	/* check legacy target powers (OFDM for 2G, 5G leg) */
+	for (i = 0; i < 2; i++) {
+		switch (i) {
+		case 0:
+			if (freq >= 3000) {
+				ctpl = &ar->eeprom.cal_tgt_pwr_5G[0];
+				ntargets = AR5416_NUM_5G_TARGET_PWRS;
+			} else {
+				ctpl = &ar->eeprom.cal_tgt_pwr_2G_ofdm[0];
+				ntargets = AR5416_NUM_2G_OFDM_TARGET_PWRS;
+			}
+			break;
+		case 1:
+			if (freq < 3000) {
+				ctpl = &ar->eeprom.cal_tgt_pwr_2G_cck[0];
+				ntargets = AR5416_NUM_2G_CCK_TARGET_PWRS;
+			} else {
+				continue;
+			}
+			break;
+		default:
+			continue;
+		}
+
+		for (n = 0; n < ntargets; n++) {
+			if (ctpl[n].freq == 0xff)
+				break;
+			pwr_freqs[n] = ctpl[n].freq;
+		}
+		ntargets = n;
+		if (ntargets < 2)
+			continue;
+
+		idx = carl9170_find_freq_idx(ntargets, pwr_freqs, f);
+		for (n = 0; n < 4; n++) {
+			u8 pwr;
+
+			pwr = carl9170_interpolate_u8(f,
+						     ctpl[idx + 0].freq,
+						     ctpl[idx + 0].power[n],
+						     ctpl[idx + 1].freq,
+						     ctpl[idx + 1].power[n]);
+			max_power = max(max_power, pwr);
+		}
+	}
+
+	/* target power is in half-dBm, max_power is in dBm */
+	return max_power / 2;
+}
+
+void carl9170_update_channel_maxpower(struct ar9170 *ar)
+{
+	struct ieee80211_supported_band *band;
+	int i;
+
+	band = ar->hw->wiphy->bands[NL80211_BAND_2GHZ];
+	if (band) {
+		for (i = 0; i < band->n_channels; i++) {
+			u8 pwr = carl9170_get_max_tgt_power(ar,
+				band->channels[i].center_freq);
+			if (pwr)
+				band->channels[i].max_power = pwr;
+		}
+	}
+
+	band = ar->hw->wiphy->bands[NL80211_BAND_5GHZ];
+	if (band) {
+		for (i = 0; i < band->n_channels; i++) {
+			u8 pwr = carl9170_get_max_tgt_power(ar,
+				band->channels[i].center_freq);
+			if (pwr)
+				band->channels[i].max_power = pwr;
+		}
+	}
+}
+
 int carl9170_get_noisefloor(struct ar9170 *ar)
 {
 	static const u32 phy_regs[] = {
-- 
2.51.0


