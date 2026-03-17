Return-Path: <linux-wireless+bounces-33336-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE0nK64auWn5qgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33336-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 10:11:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 523422A6469
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 10:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B74F93026913
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 09:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610F4355F41;
	Tue, 17 Mar 2026 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="EObAy4lr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010003.outbound.protection.outlook.com [52.103.33.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124D1358371
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738669; cv=fail; b=l0wzSn/GUdrlj7oDT4VoAObLnESLBvU6Zg8xk8GwrY8VcEZfNLYe1TIORBn14LZYjS1wyvE9fEjZj9e0WkAHKyPtb5dUBd56IJI+GIGgwXhndERKn72TZwV4+3qrAGEcj+Q2B1i8jv1pRzcz8/BeuobrF4LwVmJZxDA0iCyjR8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738669; c=relaxed/simple;
	bh=KAIoEYXXc0dOUSTrqxnkleTYbCu/T2X8PKll4swz43E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aiqwA3KInnOAwARoynlnsaMUHnowD7TBAswR+NIULyCjj0hC13jZvu3hgcCOn1QGdQL1/Mbg4lvzFmX2MVo+B+xwOxcL7UetcxwqtCzwqd3QUyPx6guUFoGj/If+I0pMKfVj8tLG3f81YvjDFg0wWVmOf8WxcM/Dc7TgWLcuy28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=EObAy4lr; arc=fail smtp.client-ip=52.103.33.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCt7iGgEciPsQFox0OrXCRdVM5v6j72oaHeZ/maUMUGrj7Y0O/WgBH4J+Uf1II0Owqebh4gJjB22Z8v+nGx+kpHVrS+Hh46/LMBGWLaL7I40K4hLJ0M5ArXNAziXo8OrAuYlsxdbo35TrNW+BpRZU8JLQemk6AczXqnhBHb2xHUh09AzivPXbJ5DTkNCl3gZSG+bvCrNarUqIwOHWUcs9QahbZEL6PlmfGLZncQhTUjM9ASl8SQhg9uac0lVWyi3Txr8P259SsVywdUeQsrmI3NFZgngSQ/HuGMUPFIYzeEvZkiCfcLz4bvOWaeLLxTJGBBlYRAjOWwmrHV3XcR8Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1zFixxjdi4mWRMNJCaXZ72AXQc+Eu7fVC4a3D8D40Q=;
 b=ObycNqTAHhbudUQ8R9EYAScmueGPdz0RGJ8PJTcHPYhPROB5QHibW47XpdxlFwTDeAvMskPsoYpOxLQq0u+pUQ9z0b3Fc3t44cpBCn/Nojef61UyiMneFcRQX2ScBQyi0CVhh/oFhDrCp3opSbbj9FvgdNp+03noTD0rO9aVHafqt3PScEpZlqErI0i6HKcuwxu130lndTmY3aDgthi4jJi+E/UUyxGMdP4PWwYcDJBHmefObirYXDK0X9YqVnP388p+RifZhZaFaeJU6weaQLGgfdNTFxvJlVAXsFRwoE5QsS0f8Q+WoRXef0IwZz485zizIK8KEMwKYLqKXERmtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1zFixxjdi4mWRMNJCaXZ72AXQc+Eu7fVC4a3D8D40Q=;
 b=EObAy4lrQ3CDzJFODwsW8fttZeP2F69ZKThjDTd2mvhIVU3pR0y+yfKEDK9GvYt3vQ3X+RzuJR4/J05ApwMgSwk7jcKH3AVbbcAWHCQ9wZWNvfSsSuG724u2kkAVzs83Pj8sH+1SpU94l9Fbz4KimKHyuyiOa6HKH+oF3GxSOZhHihU8B6ITnDgwgdC63fvcWzrEZ5u3hk0VX9aN1PPMMZ1M6CGGk+6YfXetguuuSv9Dw4+3XWpWUKj7JTZvMSsmFkFN+j6btu2N2y3jAKgCGPjhsQbF7dOwKN/vLwAc2A/J35PrFQLlk1oxn7vvGUT49PUyBsU+E3SjLT0z2Ilemw==
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851) by PAXP251MB0579.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:284::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.18; Tue, 17 Mar
 2026 09:11:05 +0000
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::596d:6ad8:b60c:c9eb]) by AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::596d:6ad8:b60c:c9eb%4]) with mapi id 15.20.9700.020; Tue, 17 Mar 2026
 09:11:05 +0000
From: iamdevnull <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	Masi Osmani <mas-i@hotmail.de>
Subject: [PATCH 2/3] carlfw: wlanrx: batch RX frame upload triggers
Date: Tue, 17 Mar 2026 10:11:01 +0100
Message-ID:
 <AM7PPF5613FA0B6DF41F140DFB83D1B53649441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317091102.23894-1-mas-i@hotmail.de>
References: <20260317091102.23894-1-mas-i@hotmail.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::20) To AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851)
X-Microsoft-Original-Message-ID: <20260317091102.23894-2-mas-i@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PPF5613FA0B6:EE_|PAXP251MB0579:EE_
X-MS-Office365-Filtering-Correlation-Id: 183417ca-ce18-464d-660a-08de84051e53
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|5072599009|461199028|19110799012|8060799015|12121999013|23021999003|15080799012|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PkfObg9GeLxjGNQ66fZ7sIlpjf4SRxZ5GJcYBJvrYaTSa8HkY7E6f0eBwVtx?=
 =?us-ascii?Q?Eu5fDy5ASZeXKHMyymtXdkX9eDSIYgMQw/rXVI4cj5igceylNIpw0B8lyuhY?=
 =?us-ascii?Q?ACPENYxNV4tSwz8A6kD8rLeYBUbhh22cXILJDhKVDcATQnOTXQevrhr66M+A?=
 =?us-ascii?Q?/SAW1Y7aJ7g2lVXfkd0MWYjQSbACDwZlGl6zlYe9SEV60rB7aobXnJypKx3f?=
 =?us-ascii?Q?Mafhz8Ln6mGePzYClC1dOMzqB0Euro930Y1+A3ipPQauvor2803aNYHKNd3H?=
 =?us-ascii?Q?cIsW1LHhAL+QnMVYK9ftkjVEDHWbAlTXywMNEDQKDWPZZLk5Du//nXEABED/?=
 =?us-ascii?Q?CdpIlD0SFR+9ySY2KNFUzk/uEnrtVj9jc7Px9dwpds0pmNq95KHEodn/wYrM?=
 =?us-ascii?Q?v1/S6Gf8TGiUokmY7JYp/U/yoCUAPCou21sy9hFzX2zp2YLj7fxc1rJc3AAn?=
 =?us-ascii?Q?mtqXN1+K1NlZMy5xj8khRnOW0GAIk/l3ueb4lMWmQG4E5Bmfadcu5+GCTRPy?=
 =?us-ascii?Q?ocqWC97iUPngLVrF0j8NJm8ehLi0cJwkj0CYmd4BTwKr+tSOd9rJR44o28I5?=
 =?us-ascii?Q?PA17tXg6rmGNrdUqAE+z6WDTCw+nhDt2gBrZ9CzXiKxHNRyKC2qEPUsKSPuj?=
 =?us-ascii?Q?ATEY1q1jiLu9tubVXmul3c5E/6ZEU+IDSBK3wjUy5+5hNjQx6AOha04dflPA?=
 =?us-ascii?Q?/wkyab0sJj7VPEkyXdgVYSqdeP6X2YaZni0yB39r4Gv7HzekHX0vXTXVmeUz?=
 =?us-ascii?Q?Avg1J+XGyPfaurnyes+tw7WegAwvnsML90t0wPVFNwQ6OpjD4DDcnmWbjgkh?=
 =?us-ascii?Q?RSAFf6v8WUXQQtv6eBjxEXfu07sAipgPM5ApcHmelrZ1ZMQSvV169GcWe+LQ?=
 =?us-ascii?Q?rXtBvrF+JOTlCc3/+sZ+y4KBWPesnoLiGqFQY1+MtFITHce3sqhCdZTO3APP?=
 =?us-ascii?Q?bTrkDZuk0uATnrtM4sgf8w=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UPyn9ZfhdKuoNJQmK6KSt2qjd9ktAgjFem540FXVT7kbNs81SSZai9ES6Dk7?=
 =?us-ascii?Q?jj7FiFxRgMB9eGIb6vkatovivgoCnWIn2fhhAUhyjxH+KCkA9tDqfxLOOITz?=
 =?us-ascii?Q?hABheDrfbCSt+68uWmyiTBk04+4SeFRckB2pCGV5suTw1ZdjbAxcEuV9/Zsu?=
 =?us-ascii?Q?ZnIdTMYb3q7Lg8vYTTOYlxj6pMlAjaUlscv3s257G1ENL88nH2TMavkrpxKQ?=
 =?us-ascii?Q?2xTnv1TEVYKhStCGSa4UEvNpvEXRsDK7lAqMkDH/g+NMsA9XgQMHeXQRCDww?=
 =?us-ascii?Q?NA/1komFPfokNn1nXKUCoyLLjK7k3h5Xxp3MG07vZuh57fFBZr9sU4rNehbB?=
 =?us-ascii?Q?dHgBlKMo/U069u6Y84q42Cump2GnWbO3U1850bX+BSywa9W8BxrweipXV6bN?=
 =?us-ascii?Q?SoMPGvqofSHMKtMw2DhUr0aGnvgAs1E0niOZtOW+JNHJ/rRh08yE48DruG/K?=
 =?us-ascii?Q?2SC3B/a0RwJQvAUjTkhfSzhudeqkdSt34fCNx6SJ+aTkh3JGrkj8Sf+gG4b8?=
 =?us-ascii?Q?wHIaZA4HjHAYWFc+6hU7r08I7aVt4IQnPQdLVDCurN5e2r/Go9EhzQxSHK+c?=
 =?us-ascii?Q?YlgJnT5JjUV8vQZyJlMxbtns1m+oC4eFNmA74m26Zp5J4a56m9G5CKgcyX0I?=
 =?us-ascii?Q?Rw/QVdedO8c7uIWqnlcZ7zhTokXxzFPU+PKKbdZp2HhJzuq4ngHvN/mgfnwU?=
 =?us-ascii?Q?mgfQjzPMFMZeIgcWAc1LOKWLcBDSeZTu4OBX/obQVAWUmIpyEC0zlaGNkPLF?=
 =?us-ascii?Q?xvoVWiKvIqYqp2dP3juP0ITZl5as+Ttp1jckaph7WX41NyQFrBu5x4aYpeub?=
 =?us-ascii?Q?k4r3iFV9iaIS468tII4nQUfeRl2Bvyy88lql8wbANOfEASXhit65p4VzErD8?=
 =?us-ascii?Q?cgqnLdEKZ8wcBXho7TszJfoHVzctfXDXNp0rewlqY76yHT2ibp9QxQbBuMEI?=
 =?us-ascii?Q?g65JzY1ubPamtA5XBOXO1tH9z5A2BecXeLNsxgGA7CdYeP3heSqfyjatLU10?=
 =?us-ascii?Q?CvGxWFXWwURin/WYBmLO1EbhDcNLBEAFPbtlzu5RkeUsthKx10tQPe2btls9?=
 =?us-ascii?Q?BDCD3JC69DsPBlrxYAzjztFeJqBAmryCPHAV/y44avzk47YvZPq1Fx/lOSwe?=
 =?us-ascii?Q?kPKo/fQdqEdmvjksCrSeFOgG7lBH0NA/pn5YxtCfGwrkB7bb7VUzFUZS5G+y?=
 =?us-ascii?Q?wARFjXt8162NkvctLrjrO+ay/lfWRnfSzH/kfVtTwswnySkXI7tZWVHpVHPJ?=
 =?us-ascii?Q?wpkyW80sgojaeapP1+47Tvv32xRBeup0S6vuejNQM6rYZ8ep2NjmsZ+HL7ef?=
 =?us-ascii?Q?NGopH3B3CO5/MlxTUbS53GlN/o7LX8+BgQoJMxqjsfr4LO183I+cJ1c3VikR?=
 =?us-ascii?Q?Oms3F7hctxalwGL5cGznXWEwDT5B?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 183417ca-ce18-464d-660a-08de84051e53
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 09:11:05.4495
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33336-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,HOTMAIL.DE:dkim,AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM:mid,hotmail.de:email]
X-Rspamd-Queue-Id: 523422A6469
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Masi Osmani <mas-i@hotmail.de>

Call up_trigger() once after processing all pending RX descriptors
instead of per-frame. The PTA DMA transfers all queued descriptors
in a single USB transaction, reducing interrupt overhead on the host
by up to N (where N = frames per RX burst).

On a busy 2.4 GHz channel with 10+ APs visible, this reduces USB
interrupt rate during scan sweeps from ~200/s to ~30/s.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 carlfw/src/wlanrx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/carlfw/src/wlanrx.c b/carlfw/src/wlanrx.c
index 1234567..abcdefg 100644
--- a/carlfw/src/wlanrx.c
+++ b/carlfw/src/wlanrx.c
@@ -160,14 +160,24 @@
 void handle_wlan_rx(void)
 {
 	struct dma_desc *desc;
+	bool queued = false;

 	for_each_desc_not_bits(desc, &fw.wlan.rx_queue, AR9170_OWN_BITS_HW) {
 		if (!(wlan_rx_filter(desc) & fw.wlan.rx_filter)) {
 			dma_put(&fw.pta.up_queue, desc);
-			up_trigger();
+			queued = true;
 		} else {
 			dma_reclaim(&fw.wlan.rx_queue, desc);
 			wlan_trigger(AR9170_DMA_TRIGGER_RXQ);
 		}
 	}
+
+	/*
+	 * Trigger USB upload once for the entire batch rather than
+	 * per frame.  The PTA DMA will transfer all queued descriptors
+	 * in a single USB transaction, reducing interrupt overhead on
+	 * the host by up to N (where N = frames per RX burst).
+	 */
+	if (queued)
+		up_trigger();
 }

