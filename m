Return-Path: <linux-wireless+bounces-33343-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C88McI2uWnVvQEAu9opvQ
	(envelope-from <linux-wireless+bounces-33343-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 12:10:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5AE2A8847
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 12:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A52A630B7031
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 11:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB2C34DCD1;
	Tue, 17 Mar 2026 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="WbJeYU4t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013081.outbound.protection.outlook.com [52.103.33.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934FB3A6EE6
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745601; cv=fail; b=AcS/++04SdKRs4G2ph3litc5sDVkWkupWhxIM20lWLB74Gn8FPQIqz5fem8CF3yTvkcRdAX9b7Gcw2eJatxzwApV/O0wycRuZBJ7ELxwOSQLjTrRkIUG+ugL3WLncnWocvVXpeTp10ZOu8l34ON9XkgsD9ysYhlap32O+aCPsQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745601; c=relaxed/simple;
	bh=vOpJ8ZkXGNHvSQ5UgQg12j+4cudff8UEfBpxl946uhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QZx0jILOtV4MpfVj8UFaxjXDvFe0wu+mzrCbKErpR/T9mx/JVaa1Aup+OOyT1uuT8ARIM5iLBEXVe6dgGuSjhxUGN7SEbvibOf4NrHdlWxbree5od+rooqvlQvQACP1Q0CH7BEJZEM3VvNOvaUGGuM4JPeGKKMMmSx8M9D4RFHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=WbJeYU4t; arc=fail smtp.client-ip=52.103.33.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnsmBSaSWn9o1WUzHwLFf6ZYcZfb29VKBW7T2mW4XNXE3wKmGQAxMzxs1vPgsR1DVCAX9l62/aJU9pb/U799RWpTvsSGPWnM0bH88i/o+vQ0C7EsJmpNM5x5/4nwqFpeQoyJe7QnzoVZXWwkcCxiC9lNKPrsoFqOoW9GSA7COie6EpyayP4c48MJp4BK+b8H6BtJI+JQSxdJJF2XpYCW6o+EghmYD6FhHWQOcL7dexDWmPTdX5EnxDq1IO6DLV42whvImlCjv6xID2WvLFpL8rMAE1RJdZoneJ26YtOnLCnpb1eCxuMqiyjPn0JuLU7ONA3o2CZV0alDemx65BMAPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8abGgS/xrx6YQp3KDdYmsMu0zgReQnol0a7T2eHE47M=;
 b=APanpag8ZpQhxgxusRWSQKwjthGlXKjnoLs4EUdGEkfznSARAGxCWeEwcYDNClsAzL3GsmBL6WqLD/I2fBlGyjRK+dBETEFDfS9dgTk3F6cC68pm169w54H2R2hwtrkAtYI/Ocfc8I8DqKxRrG7qdSn90NS6Bh6x1XQ09yWgIgqg+iINq/lSj/6mYI9LIlo8ox0yPYCs9sw0KHC7tSMJUs+SuToQKDkZVMWaLIJwAg5x+AhNVh3KUDkqbGwSFIyFeJprK4XotELRLu3c79gCDMyU5uka6xNcJCVm6kSNBC+9U46ifFNlO/gbUvk0A8PUANwPYbCkRuQAJ1Pz2AQ60g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8abGgS/xrx6YQp3KDdYmsMu0zgReQnol0a7T2eHE47M=;
 b=WbJeYU4tlBlaETcZfG18hGDna4wurIp67X0WDUV6F2sHvmexkFBFxPRTWlo+Tqd8tdV8zDxrekNbzkVQR8axJErqaLCjFdAku2GpFeKSw1ExJPuRAoAQd4ZdxIXmPcChV0MSBI16a7kUawWcsfD5ZAftuFlLIROahTiHdTZUlnNV8QVuAUw+bG+zh+uVN/nuE5rw9RJOkkUhSJDBcekaxDHCU1oqLj8YH1pd11S1foSBYLO41bROD5wmrvREl9cyrO3wdd1R3b2kKmIzqGzhS37yHEBMqgTeZgBJ/SmtDVp78HIm1ewAT0qO0jVY+26Zl2M9D+Gfb4ffBqBmZ8nzTg==
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851) by AM9P251MB0007.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:412::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 11:06:38 +0000
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::596d:6ad8:b60c:c9eb]) by AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::596d:6ad8:b60c:c9eb%4]) with mapi id 15.20.9700.020; Tue, 17 Mar 2026
 11:06:38 +0000
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	Masi Osmani <mas-i@hotmail.de>
Subject: [PATCH 14/16] carl9170: main: guard op_config and bss_info_changed against non-STARTED state
Date: Tue, 17 Mar 2026 12:06:32 +0100
Message-ID:
 <AM7PPF5613FA0B6FDA6759CDCBE2421A8039441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317110634.70347-1-mas-i@hotmail.de>
References: <20260317110634.70347-1-mas-i@hotmail.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12)
 To AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM (2603:10a6:20f:fff1::851)
X-Microsoft-Original-Message-ID: <20260317110634.70347-2-mas-i@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PPF5613FA0B6:EE_|AM9P251MB0007:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea66751-9513-4a37-cba3-08de841542f2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|461199028|41001999006|15080799012|5072599009|23021999003|19110799012|51005399006|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MyNL6BdSjPHtvl2HpJQ9qjpbz4Boy8i8atDBcXNgQsXGO0KdAIE0WzB2Sjjf?=
 =?us-ascii?Q?GXRVwoiEK+ZNjt7IVxu8gCHCUSDf0/QXDIg56LpREvxa1qZdydIw2CCwCMWv?=
 =?us-ascii?Q?w73BRamhLh2cdxQ/sEBRMxPUUDYAnLIZhQ0DlbITpi8+CvMcgDAmDvTuCUpT?=
 =?us-ascii?Q?3KYRbvbEVAOGveTNn/2lLLPZK+D94VkhzapovncupejIbEhSsRX3rVl1sMbs?=
 =?us-ascii?Q?C7k43XAyKmV4q3oxHX7bGMw5VNGQz7195pJm471MQinIgv0GusOK+mmWJUQu?=
 =?us-ascii?Q?xo4YzTipfl/Hwx4uWup7Ojm5H4dvMJJslio/X0AKsQ2MKNBoE1Xboeg8o6DY?=
 =?us-ascii?Q?sGNH1k8O/Vduy4Ukzzo8En4iapCTpXZ+k26O4iXY9E3KKaRUVlD6F10eTqQ+?=
 =?us-ascii?Q?EjCdhvWuuIQ4Pbu7ejMOWQemzgmIy9Iou2CdxZTGPna/Dp7W+m+sNlpeAHGT?=
 =?us-ascii?Q?ZAscDAqMK68W10TJAGpAPAK65aug9mwro8bkJFzF6lNWb90nX4RXBQjoVavO?=
 =?us-ascii?Q?+RWFMbabVNwp/otQubK8GLP7uhw49D3qyQ0KS9esb2DtjlPoLhc4SSZ0sVdC?=
 =?us-ascii?Q?2rKtoL+EeYl9tWROEDMVzUFG6v34aMRP5ZWsWvqEzq3T83ilSJRZkolj3EPf?=
 =?us-ascii?Q?mEWfF0+q9zKI9U/iSy/rkMj9zhkKj8BNqtBHgsRX6VnWAOJsNWeh9GKGaCtQ?=
 =?us-ascii?Q?0dsG2cVu8UZjrw1tHkOogdfZ2cyFbY7PyY8rA3v0bYSQorWHApWDqS7RG4bN?=
 =?us-ascii?Q?WwGO0xZt6GblKhUc4siU+1rKPtH41Ckp+vel6+jneaW84IGvmmQ1fd5XQLX9?=
 =?us-ascii?Q?nQKPRrNYIhzrvHYzUMffkKbpwUgBU7hd17/nR1w6+ZknKKDDz2ZDbftjFC1l?=
 =?us-ascii?Q?n0l1wcW8Vr1jdVcRbA5Ti4GZvXd7gZOiOji4IZ3ZeC2WGMiptJ/7xT//Dbw7?=
 =?us-ascii?Q?6c0R0sEblXSc8gHNKIVEyg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/n9S/L22UEADrsZX+gMVKb07YFmaLCs9Qctr/kYl4yPkbOD+SyFTs3Z3UaET?=
 =?us-ascii?Q?PG38ogQAhzlVEw4UdQ07jyaGFqSHnw7cLYrbQqRrsKgsrWZEMNXOoA3Jle1l?=
 =?us-ascii?Q?OLDwRH/N0DiEFw8yhLb0hFspfCWJXEhO5JcywOP0vJ3+kv6np6PUKi7i4hO6?=
 =?us-ascii?Q?8gCcFS1uFB2i6WuolwlCVHMNNv+6ilUnT5qwMO7bNrru7si6wnhEYJmDnY3k?=
 =?us-ascii?Q?YPKFLIHHOynwOmC0beFC+caBNMcKb9H8WrykYYoRta65mzEax9zuYOv6Y8YP?=
 =?us-ascii?Q?ZHvPisT37HkQyyN6QLMuHdOhtBFw5M4+u8dqgGatnt3wAygKMxh0LELhyjvb?=
 =?us-ascii?Q?Rtw/UTipy1hS/CcIY57HHInL3q0Q33jOLQ7l438bYk5LJ0ixXr00biTsTLng?=
 =?us-ascii?Q?P/Ar9LBb8JDl8iV1j9tbLjzoKpne69892634GFOFzGP9NanL/J+/SqsFR7Dv?=
 =?us-ascii?Q?SrcNlCxMsdMNg4aYU4tDlNnMn6lTLt2g5xr33RzRcmpozBrqk9BXQPjLO4jY?=
 =?us-ascii?Q?sTlqE5mrH3nzZ6/aJTZdUF/KKkfcfuMOqGmkhITP4Yd7SNRiPTltSQazB8pW?=
 =?us-ascii?Q?3x9u3H7A+r7Nee+holYGRii/URRnvYnlwD0x1PAsBAnz4X2dWp962ZDhhEga?=
 =?us-ascii?Q?kcyc9APqFdnHuq/rL+JATwMqHkc42pG2/cToVxYBcMq/lpFCnx1o4hlq02Su?=
 =?us-ascii?Q?NYpyB0hZATig7AvCtK6bcbCTCzA/oJtzliA91enU7NRLUAiJ4zlIpBzUoLuW?=
 =?us-ascii?Q?gAalQ3nrcFlTT6fV+vksNOUPRTnxqxrgCq0LNNdpwEuXHXJjhX29rECeCi3L?=
 =?us-ascii?Q?7A+WbbeReDFXLPb2V7MM5sYMMTTcMClzV2N5gWVsyZt9RJpWO9gqwscIjb+M?=
 =?us-ascii?Q?WbQjs+U+Z55trsZwXtviAFGDx3EUfpjHfOCYDsSGzZmOWwVNFf1Vr8fNCixM?=
 =?us-ascii?Q?wzr7BHzK9nnpKDWCQNZoW7GGv1+2eyNflu+I4Qb9GioUpijkI8eM9WWET8+H?=
 =?us-ascii?Q?WA/KAF1WKN0UTH11cJGHeyYsn/V0FCYXDjXis7mbvb+tdkq++ubUWUP8/T3r?=
 =?us-ascii?Q?UNNKi7W7nfQmP/I+x16QnfgpYOWxr9Ff9fxmTX+KTBdVmWPQDv/C5laF8tIY?=
 =?us-ascii?Q?lp1b/sipUGYD9E7hPMqvkTz1FpLHg2FKng5Aiie4FpcTP3HKCzn1YHElGSoR?=
 =?us-ascii?Q?XtAc30SbuOta9+otC804xdpeWJfx7wSDKFykXYSXHHP/cre6VIzh+yteh3yX?=
 =?us-ascii?Q?a+kNZnrzfqxp6ycD5uU0N6df0bDrHoLdKxQsZmIyUg/71QirCD/uTuM1153p?=
 =?us-ascii?Q?LefChU7SxzKClCNjMXOfRtfBrCKgyW+G4PK903y3AA6yWvqhAIIKHYb6v86N?=
 =?us-ascii?Q?5wVhUoY=3D?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea66751-9513-4a37-cba3-08de841542f2
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:06:38.8458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P251MB0007
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33343-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[hotmail.de:email,AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM:mid,HOTMAIL.DE:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C5AE2A8847
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During driver deregistration (USB unbind or restart), mac80211 calls
carl9170_op_config() and carl9170_op_bss_info_changed() which write
hardware registers such as AR9170_MAC_REG_SLOT_TIME (0x1c36f0) via
carl9170_set_slot_time().  At this point the firmware is already dead:
carl9170_restart() has transitioned the state machine from STARTED to
IDLE, and IS_ACCEPTING_CMD() returns true for IDLE (state >= IDLE),
so the USB command is attempted but times out with -EIO:

  ieee80211 phy31: writing reg 0x1c36f0 (val 0x2400) failed (-5)
  ieee80211 phy31: writing reg 0x1c36f0 (val 0x5000) failed (-5)

When wavemon or NetworkManager trigger rapid USB unbind/rebind
recovery cycles, each deregistration produces these -EIO errors.
Over 30+ cycles this exhausts mac80211 resources and causes a
kernel panic.

Add early returns if !IS_STARTED(ar) to both carl9170_op_config()
and carl9170_op_bss_info_changed() to prevent all hardware register
writes when the device is not fully operational.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 drivers/net/wireless/ath/carl9170/main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index dcedcb1..a1b2c3d 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -926,6 +926,13 @@ static int carl9170_op_config(struct ieee80211_hw *hw, int radio_idx, u32 change
 	struct ar9170 *ar = hw->priv;
 	int err = 0;

+	/*
+	 * All register writes below require running firmware.
+	 * Bail out early during teardown or restart (state != STARTED).
+	 */
+	if (!IS_STARTED(ar))
+		return 0;
+
 	mutex_lock(&ar->mutex);
 	if (changed & IEEE80211_CONF_CHANGE_LISTEN_INTERVAL) {
 		/* TODO */
@@ -1077,6 +1084,13 @@ static void carl9170_op_bss_info_changed(struct ieee80211_hw *hw,
 	struct carl9170_vif_info *vif_priv;
 	struct ieee80211_vif *main_vif;

+	/*
+	 * All register writes below require running firmware.
+	 * Bail out early during teardown or restart (state != STARTED).
+	 */
+	if (!IS_STARTED(ar))
+		return;
+
 	mutex_lock(&ar->mutex);
 	vif_priv = (void *) vif->drv_priv;
 	main_vif = carl9170_get_main_vif(ar);
--
2.51.0

