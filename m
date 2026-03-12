Return-Path: <linux-wireless+bounces-33092-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOGZK7eXsmnENwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33092-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:38:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D76E427068F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE10E301514A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C571FDA61;
	Thu, 12 Mar 2026 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="Zjcn6oUG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013080.outbound.protection.outlook.com [52.103.33.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224222E719C
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773311906; cv=fail; b=dcB+3RInvN/FLSPbQdsXGJnmHQyIn4my6K97YPlhJwSm5644xsnuipPMdNX+DVzNyM60NgC2YpIAHYH57azJOPrmk2UqQK1/fxm12Ckudg1VbSp7C9zgkEdL0GCEv5OuERu4SdvYjvBgrzL/ue5E1gdKjnHrP+k+lfQxecLWQjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773311906; c=relaxed/simple;
	bh=egluC9fsTo7L6+NNGhRvgLjSco8slNC/jJujshwSPS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lm4pmDTEYWSu2mTZAvedJ5YY6a6wbA8Kw1JBZ6OotzyrY7t4ZklOzWVXuhFaYevzHmrn0q31Ye8zHmLzvf8p/qFPPIRmrIl56Hy0ag8GyaJm7PnYMhdlYL0w2FEaDfkZY/jcOZGcNseLlxwHH+pqEnIS2EuZQjkpWsNDgRDRFyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=Zjcn6oUG; arc=fail smtp.client-ip=52.103.33.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZxkV1T0vfsmu6OSirXp+QayeJ4lHwgMYiDQwfTYZRsPuJzShttwuVn11kgIF88VYzW8fefYQwpDbKhPq81sae0WK9B6C1nU5ZEEBNzscA5cM6h4wmULBM5ewMq9gWyJb/kDMJnmKdfX1nTWnR+kNGKrEtOsu+M6+9+avJmpA6D2Y7OiLcefjgOMx842HmPbFK5jR9CQ0bSiCYeuKSqo5ArVMCb37mewjQgiyrmekVTu5bmtlEbriG3cq5Odm+JEBMWT8x/I9wGeLs4xTM65+id2v4lbqAlIJq1WTbA0E2TI//bS4tF1A+k2Yl1lCzaeoI6HOQby7zTtyODD0yZ8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqjb/KaLpfz1uqLP36IGkqaedDuIdveqXKb5oElS6uM=;
 b=vIGIcHzQj+zRjlscIa+sMYXsR0X/UWk/FKQaQC8F835E+llB+kYXDQ5sGbLcWG5EsVkH34oQzu3a7FHf+i5Fd7d0K2Rsk4nGXe4NnrV3+8gmMq/RIulCcpMjaxMYYqXwEa1E395GcEh6faFtzmuMs4h38YzUQji+hUj3G+0B1c1ONwvugKKXDCiB7lfyacJoH9UBMlRWtBCDcM1Ct7/Z+lPUZwBh0X7zLPJgAHM0hdRGYYQPwdfKRASfECwvmMP0CEEggt9LHt+FTkUmynPnWvDl9wHEn3MAfLnlR183oF6i67gMCW1OW2AYgXCEpRMdV3oAs+6yo80FxjefkNN8aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqjb/KaLpfz1uqLP36IGkqaedDuIdveqXKb5oElS6uM=;
 b=Zjcn6oUGDHo/yWtBLsCNp34yYUW1iX5ecSwR1RY+rG64NMJ/AT2Pp3pj/eTXCwJ4+6fT2/4dHCkY4jFX7F9dU2YFJNdEmmoWvwqCI4pmgHD6ZqhWvWN0eo4SuEonpUUsN1iTrb1FLJGsOJmN44RtN4OJj/3nCD9T1L2LB3kycIHIZDNdvXc4ncxHo+e7SKcx+KR+gsFn39JE4n7aGzAXd1MS/NeGUSSxWuOpbBe8QuNt3qz/w71O3uEOuM0c57+BgHsI0tsbPwjsiwQV3M79C97Q7//ut2KS5Zg3KUdlGdR4sK/fEOM2EvHNlvHo9EgM8LupGvdlvmLRCPW89MMjZw==
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851) by PA2P251MB1058.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:40d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Thu, 12 Mar
 2026 10:38:23 +0000
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c]) by AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c%8]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 10:38:23 +0000
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	Masi Osmani <mas-i@hotmail.de>,
	ath9k-devel@qca.qualcomm.com
Subject: [PATCH 09/10] carl9170: fw: enable DFS radar detection
Date: Thu, 12 Mar 2026 11:38:04 +0100
Message-ID:
 <AM7PPF5613FA0B6E8DE143A385080A72F139444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773277728.git.mas-i@hotmail.de>
References: <cover.1773277728.git.mas-i@hotmail.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0211.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::24) To AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851)
X-Microsoft-Original-Message-ID:
 <70fb191328833766a78126cd8f72c3c4fec64dc1.1773277728.git.mas-i@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PPF5613FA0B6:EE_|PA2P251MB1058:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f37d4f-91a9-4ddb-c7cc-08de80237c28
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|51005399006|19110799012|8060799015|12121999013|41001999006|23021999003|15080799012|3412199025|440099028|3430499032|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UXwieXHnyn4PLbM1Ahpgla6JfOiAtp/h9R/UmyFvJaaF++4J1svckLQINYtA?=
 =?us-ascii?Q?xIEb2aiDX36p3lpEff69DTek94iwL3LNhbRgvQfFHArbhh1FlrxiJuU3W1oA?=
 =?us-ascii?Q?nboUDSTdPIBJdd2uQHlozrb4mlO152dfd0GmzmSPCd+uqw2A6gz1q2i4qUtl?=
 =?us-ascii?Q?dIOfxOvheHC1EVk4SN3wY7S7o5nWhUtSE/ADEUyVIsd1SAt1dY628zbaSK5q?=
 =?us-ascii?Q?lVuZ/0O8aWt0cADnusWiPwbe3GIe7CXT5a+8zTKu9AR8GQHflHtSM+tL4rwG?=
 =?us-ascii?Q?g0/zGDeSJDulavuZzfCiD7YhxZUfW+yux3A1NyUDAdrTftIBPV6X590GCBAD?=
 =?us-ascii?Q?dQunQwzHWpmoen6k496JKYJYLyJxP52I+cv+7z43VazqcUW66lV8dc9Hp024?=
 =?us-ascii?Q?w4buJ9hTJSIKNa9sHNfkuFbVnwCwauRaJ9lRsLLX1HqU2D7sUSZEYyIhIXLW?=
 =?us-ascii?Q?Hiuz26uyKi6rG6XOjWzQczVxu75qZC/Iu3vI3eU2B1tO0jd9SuqVZAqyYn0t?=
 =?us-ascii?Q?QCoZGB+4+L/xTvJqJCbR4BO0iZeH7XvJfK/moRcIz2N/HBmRwDnMDvO1SkZL?=
 =?us-ascii?Q?7Mht60rARYXmievmjmiRaJHo0Z8MLa30XzrJIrj7/ike1df3Afq7nzvr5XrI?=
 =?us-ascii?Q?0nfBQC1pZLR3sySldn+g4BJhBrLYH9ncIbFlMwyxZuvh2XspUVZOlNI2sxWX?=
 =?us-ascii?Q?QydmyRDDisiENv+h2OQi/L1oge+u/ZAIs8YKQJhQU70tUMNIFQp+Qydx8KRh?=
 =?us-ascii?Q?t45pmfrQKpBdkTRLmRFlG31pCSsYiK6oosY53WrM7MSlAHkMGzB4WC86GsEn?=
 =?us-ascii?Q?P5ROhpgkzxyruGulxYV+3EwZ8K2ov4FryVd/sGfQfxAIVjIjb7FYzGDLptkz?=
 =?us-ascii?Q?vmkY9jfmiIwPS7QMlixpK8wkKLoF408VK7o5OHyBePvDQZvP0kSfQE2nUnMh?=
 =?us-ascii?Q?m/hnKydCgcG9z+txN/qItDNu+OedDT2NNUuPKyS0yg5rZwEjoGm+GTKFYcYQ?=
 =?us-ascii?Q?TF6W?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mvAor3Zf3Wht2ZadxXA4R3/+VeCpeKuvEYkpuZYvQ2yRpgQ0IdN/tPGO7vuW?=
 =?us-ascii?Q?jTdGEPQuCmRIZeZI8ERU5EZV1EZxD03MKeb6Cuymy/FvHv51ZumiVv1KGA1i?=
 =?us-ascii?Q?TBh7PDtKGxrJSdTs2EZQvyMD5+0LM2K8UG77y2oiokR+fGNFD0v86dxqn7v3?=
 =?us-ascii?Q?LQO7XQ9HrobqQeIhRwMAdRQGHhDXsOrDEpaFHiByPZlUEkcpWoa3eGXcHn0D?=
 =?us-ascii?Q?u1AMURmlLsI3xYaDAo32C6jayK7APrsRatFMJtWC/dzvph5Gn50Q4dpoYbPQ?=
 =?us-ascii?Q?YtjIj07Y/Uc4LrcWXpqhKDDJ8fI+5UrDNPFGzY7axQMDTKuS0GhrtXBJni2V?=
 =?us-ascii?Q?dctr3kBwHfaCaAPhm5HSht1JwoIbYvC1icP+AG2/0tsHCW15Gaij6s8lHAov?=
 =?us-ascii?Q?GXkNtvbXTkbrmNNG3p7h8iXshma0ND4GcaxjdrzCbS1dvBDBYKihOscx4y6z?=
 =?us-ascii?Q?V8pwhNZn+QgifOqrywr9d+SkVjpm/YuSaENa73LRaSVnZC4HvKHDpJ4b6vs4?=
 =?us-ascii?Q?l/REQTothCl8bzJTv1TvuTJYbLtj7E+SyQJR6jWD7DupP2CXzYJElM3bW3fJ?=
 =?us-ascii?Q?kOy0ctI3mgnSm3RnUxXtT0FaAJk7kv4RiVaqowI6Rg+aeiDbox5K8rqYGDH4?=
 =?us-ascii?Q?C+eP1JI+n8QP318eDGQy+pr+cRiC+nfU6H0L3s2H2etnsBoFEZW8MCQ34m+I?=
 =?us-ascii?Q?Inh644sg1ok+pwW9ynVcpiPbcPCxAdLA+Bt+g0uRu4nVwheERffQRDuFghEP?=
 =?us-ascii?Q?pFcmuq8bBf7hn3zwsb5+4v3E9P1oPBQUTBLY6IjCOrblFV2Ek+KqLF906QvM?=
 =?us-ascii?Q?bOxSdATthCRSh56mNseFRgWzMuSRMHfUTLKoFr/s+TPyDtg/EbVjN1ODK8vR?=
 =?us-ascii?Q?ziNiW6kjyhncrf95wc/YUe4zbK8HptfSA92yNt/RSQ1ECZP/sLtBPAcwz+VK?=
 =?us-ascii?Q?j35cb61UiczCjwQCwciLoA7XbDXSrYdlwV18bz4veH0brGFRbnjGzSvP4Qf3?=
 =?us-ascii?Q?v0cNPK+EDKR/TELEBDUPKJE6mgY25cGoc+hCKzsqj2MjZuc64I+sfmi9tDVB?=
 =?us-ascii?Q?vvqrsWg7lW4zwCOwB3Cz8Oa6e5DjqWAZT5nO2pdsiwA1HonxsQJkq7Ft/X0S?=
 =?us-ascii?Q?7YMyHIxas+GEpzTMKHh5mTpRgSebdbl4psByOjKSG9vac2Dj4LEsMF4pCv2D?=
 =?us-ascii?Q?AKZF3NTU3UfTB8xurDY8Ooad3HtREaLkrT6h01eU6gpEmj+/UCUlVP2P3QhY?=
 =?us-ascii?Q?djWvgNm8lHC6c1dTkKQ5fAZvRp08Og2SsjIKn9+fbGy/7uGl0lFpCGK8lO7q?=
 =?us-ascii?Q?1WJvq/hEn3e4OkWhlnU4p+quPdHEv+rPASLNcoCxtHz7XpZvCfkqAZmsFt67?=
 =?us-ascii?Q?gwkU+4L7aBRvQ/TJsU+xr+5PjXOY?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f37d4f-91a9-4ddb-c7cc-08de80237c28
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:38:23.1202
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33092-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hotmail.de:email,HOTMAIL.DE:dkim,AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D76E427068F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable DFS (Dynamic Frequency Selection) radar detection on the
AR9170.  The hardware has radar detection registers (RADAR_0,
RADAR_1, RADAR_EXT) and the firmware already sends
CARL9170_RSP_RADAR events, but the driver never programmed the
detection parameters and only logged a "please report" message.

Changes:
- Program radar detection pulse parameters in phy.c when the
  current channel has IEEE80211_CHAN_RADAR set.  Values are
  based on ath9k defaults for FCC/ETSI compliance.
- Advertise radar_detect_widths in the interface combination
  (fw.c) for 20 MHz noHT, 20 MHz HT, and 40 MHz HT.
- Replace the old "please report" message with a call to
  ieee80211_radar_detected() so mac80211 can trigger the
  proper DFS state machine (channel switch / CAC).

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 drivers/net/wireless/ath/carl9170/fw.c  |  3 ++
 drivers/net/wireless/ath/carl9170/phy.c | 45 +++++++++++++++++++++++++
 drivers/net/wireless/ath/carl9170/rx.c  |  7 ++--
 3 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/fw.c b/drivers/net/wireless/ath/carl9170/fw.c
index 419f553..a730593 100644
--- a/drivers/net/wireless/ath/carl9170/fw.c
+++ b/drivers/net/wireless/ath/carl9170/fw.c
@@ -215,6 +215,9 @@ static void carl9170_fw_set_if_combinations(struct ar9170 *ar,
 	ar->if_combs[0].max_interfaces = ar->fw.vif_num;
 	ar->if_combs[0].limits = ar->if_comb_limits;
 	ar->if_combs[0].n_limits = ARRAY_SIZE(ar->if_comb_limits);
+	ar->if_combs[0].radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
+					      BIT(NL80211_CHAN_WIDTH_20) |
+					      BIT(NL80211_CHAN_WIDTH_40);
 
 	ar->hw->wiphy->iface_combinations = ar->if_combs;
 	ar->hw->wiphy->n_iface_combinations = ARRAY_SIZE(ar->if_combs);
diff --git a/drivers/net/wireless/ath/carl9170/phy.c b/drivers/net/wireless/ath/carl9170/phy.c
index bcd9066..c294df7 100644
--- a/drivers/net/wireless/ath/carl9170/phy.c
+++ b/drivers/net/wireless/ath/carl9170/phy.c
@@ -1637,6 +1637,47 @@ void carl9170_update_channel_maxpower(struct ar9170 *ar)
 	}
 }
 
+static int carl9170_set_radar_detection(struct ar9170 *ar,
+					struct ieee80211_channel *channel)
+{
+	bool enable = channel->flags & IEEE80211_CHAN_RADAR;
+
+	carl9170_regwrite_begin(ar);
+
+	if (enable) {
+		/*
+		 * Configure radar detection pulse parameters.
+		 * Values based on ath9k's defaults for FCC/ETSI.
+		 */
+		carl9170_regwrite(AR9170_PHY_REG_RADAR_0,
+				  AR9170_PHY_RADAR_0_ENA |
+				  AR9170_PHY_RADAR_0_FFT_ENA |
+				  SET_CONSTVAL(AR9170_PHY_RADAR_0_INBAND, 5) |
+				  SET_CONSTVAL(AR9170_PHY_RADAR_0_PRSSI, 1) |
+				  SET_CONSTVAL(AR9170_PHY_RADAR_0_HEIGHT, 6) |
+				  SET_CONSTVAL(AR9170_PHY_RADAR_0_RRSSI, 12) |
+				  SET_CONSTVAL(AR9170_PHY_RADAR_0_FIRPWR, 33));
+
+		carl9170_regwrite(AR9170_PHY_REG_RADAR_1,
+				  AR9170_PHY_RADAR_1_MAX_RRSSI |
+				  AR9170_PHY_RADAR_1_BLOCK_CHECK |
+				  AR9170_PHY_RADAR_1_RELSTEP_CHECK |
+				  SET_CONSTVAL(AR9170_PHY_RADAR_1_RELSTEP_THRESH, 8) |
+				  SET_CONSTVAL(AR9170_PHY_RADAR_1_RELPWR_THRESH, 12) |
+				  SET_CONSTVAL(AR9170_PHY_RADAR_1_MAXLEN, 255));
+
+		carl9170_regwrite(AR9170_PHY_REG_RADAR_EXT,
+				  AR9170_PHY_RADAR_EXT_ENA);
+	} else {
+		carl9170_regwrite(AR9170_PHY_REG_RADAR_0, 0);
+		carl9170_regwrite(AR9170_PHY_REG_RADAR_1, 0);
+		carl9170_regwrite(AR9170_PHY_REG_RADAR_EXT, 0);
+	}
+
+	carl9170_regwrite_finish();
+	return carl9170_regwrite_result();
+}
+
 int carl9170_get_noisefloor(struct ar9170 *ar)
 {
 	static const u32 phy_regs[] = {
@@ -1739,6 +1780,10 @@ int carl9170_set_channel(struct ar9170 *ar, struct ieee80211_channel *channel,
 	if (err)
 		return err;
 
+	err = carl9170_set_radar_detection(ar, channel);
+	if (err)
+		return err;
+
 	tmp = AR9170_PHY_TURBO_FC_SINGLE_HT_LTF1 |
 	      AR9170_PHY_TURBO_FC_HT_EN;
 
diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index bb909b5..1fe727c 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -259,11 +259,8 @@ void carl9170_handle_command_response(struct ar9170 *ar, void *buf, u32 len)
 		break;
 
 	case CARL9170_RSP_RADAR:
-		if (!net_ratelimit())
-			break;
-
-		wiphy_info(ar->hw->wiphy, "FW: RADAR! Please report this "
-		       "incident to linux-wireless@vger.kernel.org !\n");
+		wiphy_info(ar->hw->wiphy, "FW: radar pulse detected\n");
+		ieee80211_radar_detected(ar->hw, NULL);
 		break;
 
 	case CARL9170_RSP_GPIO:
-- 
2.51.0


