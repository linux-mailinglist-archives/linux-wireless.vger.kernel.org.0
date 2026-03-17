Return-Path: <linux-wireless+bounces-33342-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nmEoGbo2uWnVvQEAu9opvQ
	(envelope-from <linux-wireless+bounces-33342-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 12:10:50 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B82DD2A8836
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 12:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF4A330B2653
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 11:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4C23A6B91;
	Tue, 17 Mar 2026 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="qFbkjIlX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013081.outbound.protection.outlook.com [52.103.33.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE80C34DCD1
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745600; cv=fail; b=paI0VVvgPw8fBberBiFT/eVc3fGyZFUK9EFvggXiKcmRrod+ENyxTsYiLu/AUaK/zyiOyDTFu9x50sTq4slb8S3Wr1FITieaEYHVoCu05eMMsrXJf8XhjuuDp4dPVYbd3I1jO6G87GQLVmVQsXLAchoE11dphdgcK2DnoJsbygU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745600; c=relaxed/simple;
	bh=6upgOiOEKIIyhTtg5AJsHbSq+3r4OuqYcrlIRelq8dM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YCbomrK+T6ByR+wWqU3itwW1qMgWgFfIv/ncA+R7XkI6HrYj39TZd5zn/uXVJl//79aCGed8OSMhwZbYnxLnIqmMdYD/5kmnhmPOZYLpV0RPezXcyH+YJZ/d+2uaHIloFJ3hT3yFKGwtMNXyhfCcstUY6R5ZNu7jOiypuiNPnbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=qFbkjIlX; arc=fail smtp.client-ip=52.103.33.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oo0BOX8KZk5ATcatPxkwdrr3E4wQAjpO4Hlefr2RtFYDNPVEN7j48+muhQ7Gy5aBodOBe6e3g35iawLtBH2VyyXWoeM3qG49fcGRqSdkjsc1Rja4C/SEIJRNOznSYgn9wzJ0OPvFzne2dbnF8kUIJeh2y4T1DoFt0dxloeUQX/hVjs4z0n/Wt/Fapd81zgdBiSKTiOgHqmONo4u1BaRG9IsIaFBxU8Xe2kqJqVRxEuvl1QaYAtEkRalhBJGZ4nYt8cp5U6P8X753X537ovZBlfdxMjxlq62ES5WJ4p5BclMjkY0vER2VkLVqPiX7NQP15rAZSy0ARHep0zOselNpAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19c0AhNYxGwDkuszH4jcP51X4oOgo8XamVhik4+avq8=;
 b=l7l3PiNP7rdKkV+SNzhRsMaf/+sqctRO/cxvYevkNmZiGWKZCznjf8Fp/HmRw/YmwBnpzup0wo5yAyNl21UcBFIo9ojJmd5UWPQtZ6RF4JGg5TfZx0k/h08oyiVmX2VjYumfLJh9yNyRX0cH9j6+9n/iL0X67KfdwJbGQNGaAidCk4ARO0xFminH2i+0D6Vkr0A6ZYbsuZotahD63Lc2RnbwdC5L/sR4odLV53uWazkqY14qPxb8L1ofly19DtYUBVCS9CxkzUtS+d1/f+YbtXxnwdC+YXviEkTpsOpWtSLpKQfu+qOl6wulZUsEkJhI6seUzxYKqmoMw/DHBFFMOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19c0AhNYxGwDkuszH4jcP51X4oOgo8XamVhik4+avq8=;
 b=qFbkjIlXONHpTqxJAHNovh4Cdh2Yz+knso7UCNb3ciSVQTn96s3LG9Or4NuF3h39LUzT6S5zn76sCyWlAjBc6rNWgYvs3Dw1KrS6x1ZuXaVB6COs3dwMNsnZVlghU+m2DKJWw7LD9kt9QwB338wZlNxk8ZrDUcp8B+3iG1G9L5Jak6p1r7KtMPg618qE+QE/jGnHuStI6sEbPPQuPdcd+HfVber/gFWCZhcr1VN1vk8K4vZIMOmiW5/ybY+PysrGR6puAVVGTBnj300+kUCWo8hRQ4SeedOElrf1dxiqUS1nAWaQ+QuUEonSRMPlhsb3UOL99iQU5VNCjqk9F2k2ww==
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851) by AM9P251MB0007.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:412::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 11:06:36 +0000
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::596d:6ad8:b60c:c9eb]) by AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::596d:6ad8:b60c:c9eb%4]) with mapi id 15.20.9700.020; Tue, 17 Mar 2026
 11:06:36 +0000
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	Masi Osmani <mas-i@hotmail.de>
Subject: [PATCH 13/16] carl9170: rx: gate data frame delivery on STARTED state
Date: Tue, 17 Mar 2026 12:06:31 +0100
Message-ID:
 <AM7PPF5613FA0B6ADFF8016B03CAA1A9DEB9441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::15)
 To AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM (2603:10a6:20f:fff1::851)
X-Microsoft-Original-Message-ID: <20260317110634.70347-1-mas-i@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PPF5613FA0B6:EE_|AM9P251MB0007:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce1a461-2893-47de-3a91-08de84154198
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|21061999006|8060799015|461199028|41001999006|15080799012|5072599009|5062599005|23021999003|12121999013|19110799012|51005399006|3412199025|440099028|12091999003|13041999003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eIsWiDHC8cWjH4f1h3jpEeOivcoE9KGLkTWNQgqxoHtRP88PDl1hMyzuntx1?=
 =?us-ascii?Q?J+htEXw6bNfub0SPP0eaEM1x7HoEmQWgjagtx9hTd9gsLbm+VJ4dBS2fdYEW?=
 =?us-ascii?Q?DNX7zH5kiGpMRHhoG2L4mAKehjoVXqM1zr/+vJTm2Z13OzeH24iv83OuxMXQ?=
 =?us-ascii?Q?auKlqTqvDavofgKE3Lbn9OLx6LPPwQSc7qoVpCcCdt19MxJQLJui2KrNN5Cp?=
 =?us-ascii?Q?wMHd5PkcjG8ByljbVmVhdYlVAkqd2aZ+iCMRCJO5sTIejksZDSwv+gVbCQkP?=
 =?us-ascii?Q?jtox/PGMn8nOEjeVmyZJo8NRqBW/9Z6ERlyM+6pLSmCX+q1zxrynAi2LkfRu?=
 =?us-ascii?Q?iXxjmiDAWUTCpWyWnPZkdzOs6iCJfUhCD1/dmOd7c9kmb67sTfB9mn49HZcR?=
 =?us-ascii?Q?WKX+xxWJSaFRyQfTvNLWUD6l0ICvPL0ybCLFmoSqtpbvccgmSCg3pjf2TbcU?=
 =?us-ascii?Q?v0xibqN9QNadVj6XOCFvdBwVduMUrsjlaQMzvGAnTWbhkFse1o6Q18CW7Cas?=
 =?us-ascii?Q?Yh6J0mclcOR0eySnuwYYmL1H8P1MZNY85r8YxPRdsMJyFWpgFbgUWIzoQP6i?=
 =?us-ascii?Q?JiRnqSTvfvKNvCLKbXea8pgSn52ksJ7/rCBrKkrcpM9qL72nqZ5VfDtM6A8p?=
 =?us-ascii?Q?+UR/oOp9FeGXjY/8ryRpDmZNxrOKJ+XyQHe3EtrdJgy7UcTJFriJvInVkS7H?=
 =?us-ascii?Q?CfuHEmBsSS02uAkhue1R2Y2dQ22gteltG+ahSA3DB4D5gl4yQFEXflcaSxJP?=
 =?us-ascii?Q?dySo0HJhTEh/AH0uPygFDKfqrFFSbKqQmgwLTnUr1mSrJYfcZCShzwsXYsx6?=
 =?us-ascii?Q?mSjjYyf8QTpyi1fQwYed3cPaKDQPI6fxLgpOSo35RuPTOItsbWDL/FBsHoON?=
 =?us-ascii?Q?TT8DTncAyiITLRqUqBcwq6eupK5zpov/L0AUo6J3e9dnqermekXAQma3gzbR?=
 =?us-ascii?Q?rgRp9K9vh4JJmRPUhA0SYIGZvE2jCVRWeiheL/nimcMcfo965wrBj48oUc2J?=
 =?us-ascii?Q?v32+nHWL32mGyMNZ4zsr25v+DB/Ai+DzLnBV6uCbujjydBF5iOYK0wu5pPgn?=
 =?us-ascii?Q?isI5SDZxxZPHzzKu2mLslvmCknSUsPpO4bUIftdwy64bkJTiII2ZIoK8Vp1i?=
 =?us-ascii?Q?uTRszJbLbHya?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WgYX6DcXf+iPNweiMQ3clJNomjMYyunByi2JZ5rLsxLJWUxvFO7aW/zJlGtZ?=
 =?us-ascii?Q?RgegTC4scmXEcS16Cq1GtWSOB+9SpILO/MQnP8Efjtw5t5JYOJAN8B+pzX8S?=
 =?us-ascii?Q?aCvZG9xJ3dw6CT7oKMRmLTcEzz04VG6kJyFxixDyUJfwI/l6dtloA3x1ePEM?=
 =?us-ascii?Q?0nSmYgxUHarfd99vurIxwNQzZ0Ah8KIPPvYiHZo2bDIuC1znIaRMbCfrGPV7?=
 =?us-ascii?Q?YK1BwP3/W9dWcNp/3lC6sXetTZ9INzkVgCgzRQgYDPS034tPjoNOIGbOJXJ1?=
 =?us-ascii?Q?dUVPjLpO6I+0H9tEecMSfgg7vVec94FSzLxcjmZGLO6lMi+1JN/HUANvfvKQ?=
 =?us-ascii?Q?DYkt3DElUCnRWdvzKphA6K4RiofLvKBcl9Z0/IL2RapS+Bwox0oEoxP+kRxf?=
 =?us-ascii?Q?/CM5NSraE0VOyz2C7w7BfGdZwfE+8cYs/JZd3DRnt5qBM/HGCMPHWpdLyD9f?=
 =?us-ascii?Q?pe+27E/o2B41pSqWXrSL50wAKgwy4Ao1cNSa6pKpJ56WRJZHfpHCbujndJvP?=
 =?us-ascii?Q?OteysSEPRhD0ZoSGX04CvRy5E3MPXNDh12CXzjUNQBN1l5d8qNGjcNm9c2pp?=
 =?us-ascii?Q?h+GvYViWwJhA3gVnqqfjn3RNcAn6rRz7W0QsSdH5r7N2+wd1tXi+KIJKLqbo?=
 =?us-ascii?Q?bBWrcnBPzVKXlQYkPdfp72AeVS5Sv7VwXcwLPRqfV4Zdvq/wGFE8xP69vo/4?=
 =?us-ascii?Q?ytCeT87xpOFicuXgBE7AZU/4Mrhc8ZaIuPagBOk/BRhKjyXdga21r/bUNO6r?=
 =?us-ascii?Q?zhY2qbZzbZZvsGDe1f4mvGb8esSXK7hntkWGP3uTGwYR3qLSOALQhbebUCqY?=
 =?us-ascii?Q?grNips+MOV7UA2A9zZxpT918qoc+tHLd5V7wSLDkZMFupwfuTk5CGDQrUh2W?=
 =?us-ascii?Q?DEOwxxmA7TQeVn2GN6wsUvSMxhPtEMBGlE5nEISiUpYr7dqueHChNvXF1We6?=
 =?us-ascii?Q?OzAhqfoaffW14Nz7GzrRh+ymc1ViYaZvKmJFQNJKdZYGG7crTni2oMjYXfpw?=
 =?us-ascii?Q?tM5hnd4U7IXIlfGfkSoOAsm1Prn5kQSEuNwXH2tbzAU3oLh6PMVviQjXv1dv?=
 =?us-ascii?Q?m5mNkvcHJaAbY0O27A5XYWfWz7OFZr2alBtR3R9n7lY0JKL3PkI7F6xOivuB?=
 =?us-ascii?Q?JEeuRRXY38TDFL0B5bWYtUII+cmk21ZJ7YeobuaD/0iRh2y7TJ/CGC2mNdtV?=
 =?us-ascii?Q?BYxMyqKrtsmatXwLMpS2VR60vMTlcp+hgZ1a7mIeiQdgCDXYIIh3756reVyo?=
 =?us-ascii?Q?a6HXur2qd/xkQeJUGyXTeMLx7BQlmnxlXIjZUwwHJkoJp2h7StH+cY4CvnIf?=
 =?us-ascii?Q?cnpfB5ico/9Ll56n9Y4VHFwHfovSCOY60OJwhgyvl3ABLNvy80WdnOVhSGhP?=
 =?us-ascii?Q?2GsyyM0=3D?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce1a461-2893-47de-3a91-08de84154198
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:06:36.6638
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33342-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[hotmail.de:email,AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM:mid,HOTMAIL.DE:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B82DD2A8836
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Do not deliver data frames to mac80211 unless the device is fully
started.  After carl9170_op_stop() the driver state drops to IDLE,
but the USB RX path can still receive frames from the hardware.
Without this gate, ieee80211_rx() may reference station data that
sta_info_destroy_part2() is concurrently freeing during interface
teardown, causing a use-after-free kernel panic.

The race occurs when ieee80211_handle_reconfig_failure() clears
IN_DRIVER flags without stopping the hardware: cfg80211 then tears
down interfaces via ieee80211_do_stop() which calls sta_info_flush()
while the driver's RX path still delivers frames.  This was observed
when carl9170 firmware deadlocks during a restart attempt and
ieee80211_reconfig() fails at drv_add_interface().

The gate is placed in carl9170_rx_untie_data() just before the
ieee80211_rx() call, not in the USB layer, because firmware command
responses (including CARL9170_RSP_BOOT needed for firmware upload)
must still flow through the shared RX path via
carl9170_handle_command_response() which returns before reaching
this point.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 drivers/net/wireless/ath/carl9170/rx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index 683343013..19c6bd418 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -676,6 +676,14 @@ static int carl9170_handle_mpdu(struct ar9170 *ar, u8 *buf, int len,
 
 	carl9170_ba_check(ar, buf, len);
 
+	/*
+	 * Do not deliver data frames to mac80211 unless the device is
+	 * fully started.  After carl9170_op_stop() the state drops to
+	 * IDLE, preventing a use-after-free when sta_info_destroy_part2()
+	 * races with ieee80211_rx() during interface teardown.
+	 */
+	if (!IS_STARTED(ar))
+		return 0;
 	skb = carl9170_rx_copy_data(buf, len);
 	if (!skb)
 		return -ENOMEM;
-- 
2.51.0


