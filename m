Return-Path: <linux-wireless+bounces-33344-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIqpDso2uWmcvAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33344-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 12:11:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 989082A884E
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 12:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFC6B30BB958
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 11:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D34034DCD1;
	Tue, 17 Mar 2026 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="DIhVYvUX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013081.outbound.protection.outlook.com [52.103.33.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D283A7F48
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745603; cv=fail; b=aGzZnTsLHV+0BKrqruy7JmgNiLr3u+t946d4AEBxzKAJx/4keScnQt6rG68fpHn/gbrA/SGyN9UfvHykjAoorSQy2oBQ4ywkRSjTjdO+WOSQs3gaKMO6oHHO+Oaax/s8BWfm9zhPB993b6LyBU1GTHENWtfWKI8mm/+DTqxLZ9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745603; c=relaxed/simple;
	bh=CRKE8NL6Zyzpux3wxP62hCKBIuH8lvaqvpd5ThTvrnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WOAlp38Y/Mm0+9Px28WxV+nT4lEMnzN/8l2A5dvByT/Coir9eZKY11L87YPtyWt/idu6XwLgookBkncn7bFJgcENuk6hkABH6IZ9+YeItu3iLSvnegnbVa87FTIX0TKOoymVlA3ep2yCI/q2Ii3KSdbYlef9TZnU2n3gAgw/69U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=DIhVYvUX; arc=fail smtp.client-ip=52.103.33.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqT8e3nb2IMH6vISHjqSyKKQ4Y6aeNXxXt9Xn171E7eoTfByHGQSoO2JA+ym+fXgnFVCCzca1X3X3HcdFXr0sLz1zdDOt4hm0KCIqwfQZoVS2IXQ4iBhAnbKEh95AWjZjDSvF8dkQszrALNYxXJYYv85N+BfVDMC2Qt+0ln4jZplHTG71IE9qxT7B61wd8OsW/lcySIRk8Fw4CfI9Iiv7xIayomTrIlbzJRB1QD3Bjv9B79MWNCTk0bHc809t1O0B2w7TATfKFRmt9Z2l6JZwocEdVrwYj3rId+e7oNOTQL7Aj4nVjyLoKdQl0NOK+lt8Y4Wmbrv0/RKrvo+0o0ZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hRm5yL5HruSio23ux/vG4l1Zz9ly4n82ZMT4vcW2Yw=;
 b=cVjApz27XXmjj615YFcAAA4MK2CoDDy0oHeDrfOh+Q+Y1jt1oacnxA3psuURTWMdgN4Sd9ZWCHixDl3gMiF3krV7pfcU8B+UBMKFjJCfiUvdk19cgTYIEIwApdfmqIDJ29TapvdrpRQgieSryjQNnmnuqKtNn0U7VYVxSpkrpY0JbG6lv8mE0cThBHN1pzexPW4m9Zc//0jK+v3/ZfT6RxergjRB6zK2RVvCdKAcueetrT6Xy4u9B8xo/yV0+zArYs5I1iKoKnKzQIPkiNpqZ0/xoeRMdkprXHMnAJa1gTZrF1Kz7QXr0YlrZG3MV6PqfKuIx7jO4C5gAbL7xZPGQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hRm5yL5HruSio23ux/vG4l1Zz9ly4n82ZMT4vcW2Yw=;
 b=DIhVYvUXHO8zwUYnGixXwBYGwAxMsl87+n5FB7FJgszVk773CQSldK2orHqy11B7I91TctrP04ZQd8wXSz870HNBR3VP8DMeY5DJpCGYxtgv5iDi6Hc8IHJn4NdFMNuOYeHoT6o233u6+o46WzIpVgJxyyubHslEEsS0FY4/gxxRe2A+scMtm6VC3y8bCgxWcdfrv7YHb1gvD8mSaRtkWfDosl/nUbXl9E1kQ29WXhcHFwszXqftJ6UHHJzZPk+gJ6UV5K8r20Xv+ZqdIcSspIYRNtiFjIzdvSkeo1ApQa1RajPJMeYZwNCZlWtnjfhAQ5GIVZx7d3yR2B1nw43mYg==
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851) by AM9P251MB0007.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:412::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 11:06:40 +0000
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::596d:6ad8:b60c:c9eb]) by AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::596d:6ad8:b60c:c9eb%4]) with mapi id 15.20.9700.020; Tue, 17 Mar 2026
 11:06:40 +0000
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	Masi Osmani <mas-i@hotmail.de>
Subject: [PATCH 15/16] carl9170: phy: warm BB reset and same-channel no-op
Date: Tue, 17 Mar 2026 12:06:33 +0100
Message-ID:
 <AM7PPF5613FA0B60E4BC1593D4C3693644B9441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317110634.70347-1-mas-i@hotmail.de>
References: <20260317110634.70347-1-mas-i@hotmail.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::10) To AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851)
X-Microsoft-Original-Message-ID: <20260317110634.70347-3-mas-i@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PPF5613FA0B6:EE_|AM9P251MB0007:EE_
X-MS-Office365-Filtering-Correlation-Id: c822e7e1-2b2a-4c10-2818-08de84154421
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|21061999006|8060799015|461199028|41001999006|15080799012|5072599009|23021999003|19110799012|51005399006|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JJRcwVH/8/osoNjUa/2nQG3gba8CcYM+kyBs5EvVRo8zjtpE1k7vLebLEZb4?=
 =?us-ascii?Q?NrmMd8JmB9r71gcxKoTg5UInDbZkn96sZlE9svmnwgm2ieuhs69Bzd9KLEvU?=
 =?us-ascii?Q?+7HpGJffa7hIxOFYpxBbgVN7P03Me6yRjBb1HA+lE7kv9vIds748e6XL3loS?=
 =?us-ascii?Q?WpZfavyMkFUwxwZuyKfIqK/zMr1Ix+rcRdjN7rJHPz2hzgNMqd/pvIlgA8O8?=
 =?us-ascii?Q?XgZCc7ziDw6zjI9RliE5LEW/eVSbjFIwIdWpWbG4ozqcrlsN0kuzAWuTxweb?=
 =?us-ascii?Q?huDwEXsjqFUag0CiDcdnC76vsk+PBV1wvuqyI7TDQjLxn9rtf/9T8Qv72ht/?=
 =?us-ascii?Q?le6K6wKblA+/jp6QedvMma0eHRhLtd9t1WKdYliVOtXCEwPU9oYEoFHiN219?=
 =?us-ascii?Q?hz9ZnvPfQ9tLeYGy86zi/2pFCO+vOHXzxh9L+KMBzwy7gcH6xd12awIaTwXo?=
 =?us-ascii?Q?aHsllPYmNBsABiQcvJDxpW42eYl0HdaxbPo4W11diigPHzK4P5n4mPNq7R53?=
 =?us-ascii?Q?NY+OquZO9b6YLtihgRZlcfsKM8Ac12WAhx3KmePCHn96KsWqkC+ITPj/UL5Z?=
 =?us-ascii?Q?Mm9myAqrT5/QX1S/t5WVtPpOntly2HUIgJu55z5ff9cu0SVY0ZhyFomfoR06?=
 =?us-ascii?Q?1C9LhM0FNIwji+UL4WVRLkj0qBJP5xQPcGc1imola2fsEDb8icnift18FHn5?=
 =?us-ascii?Q?bRaPrCYTYQ6l7WxzCsu81mOET87WWjW+MEFv3C21YOuu1L8E3KStQ0W9MCcq?=
 =?us-ascii?Q?hawwnAL7P8wOXCSKvBbv8ogxvzk5Lgapy3d711RymuNa9W92GYGxT8/TyJK5?=
 =?us-ascii?Q?DQ/Ma/3hSZhMFHFvks2UeXC6z2KQb1VHiNEBSyV8vObbpD31URM6LsyPoGln?=
 =?us-ascii?Q?8wSuBctO2Lc/UYF0PFQrE5bA1w9e/M6TVvV4LbCI2kW3OIoIa64WESFRa4vr?=
 =?us-ascii?Q?JKFcr9nreFpdvAvU3H4uLwP5motOK3tclMNzjr5n35iNi14HobHhvxyV3O+o?=
 =?us-ascii?Q?8c5s?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VnUwKGX3j9t0pZKF/y8gP8hEDDtkt/1fxoA9mfYKPkyuCigim/D7eBRiB4PE?=
 =?us-ascii?Q?vl1B2brw9lOnGwxTvj5pWeaxAr1NVg11y8qYeqtdZE8MINVk1ac5alzpNNIW?=
 =?us-ascii?Q?Z566mCGKow5jZ3/8AByoidklujHN/GNfFJ0/ojd7hFsKVx0OBpTw41ytNy9M?=
 =?us-ascii?Q?HZieJjnaBdIdoB4iHGqU6bSZafHhzCD86lovYoL2Z31yEHgdtcMZF/X4M1GN?=
 =?us-ascii?Q?Doe86ZiREFgY/fatnA2GOmQwFz0pKZcmNSTUwfY04PpYmEJpT9SNn1t1MImd?=
 =?us-ascii?Q?yMJFkP9NgzOHJGX4jxretGq0HM8oCncXUh1EtvxiS0cWRGZdG2vIj5hRNvdc?=
 =?us-ascii?Q?AI0Xk3b47WRtdHB3qVmWhsFgkarof0QOD4BOfzncIbYHhEGvS/Nt2zX7yvF5?=
 =?us-ascii?Q?B/wxuH8UMY6b1j0KdHk8GC+a1V+W4fYtFLQ8giUDiw2tW4BhelvsJ9tY8Z+6?=
 =?us-ascii?Q?P4wNJsJ8HBcvpY5zs0V6t6au+XVKI/H2IYdiIWgFCBpuLIj6i5nYVbF0NRBe?=
 =?us-ascii?Q?c0OdqqFs7C9FOTRuuAJQqDGrNqNLpNzaGanNPyaIUECKxcGqWzRnLUzFScXj?=
 =?us-ascii?Q?v8W3BTF+yB1dqd5ajUPPMnvyNXOFrzvA5QJn1v/HRysysZiOi354nnvvGa/W?=
 =?us-ascii?Q?PLHkrrp05MozZE2FfFgIqoWIB+Q+4Rr56fKzuFccAF7zLYRzNFXlhqkTrKzr?=
 =?us-ascii?Q?6bHJQyXl8g8bhLiRpiEghR7geBsXg0LXR9EN+xiCLv9L6boZ298eKEU9gKMt?=
 =?us-ascii?Q?gTo8fgxZ8KxjplLScg1nqvQhQn/vNefinLalTVPqIloWFXqmbNFm+YYqed2g?=
 =?us-ascii?Q?5BKmfter1idAmM2TkRFUn0501mSV1CcmDyWllc79chbwGDNEChIymxik0sJm?=
 =?us-ascii?Q?PMXpUxC4xbyE/itVmvlVj3Cie1UCsJa/WqF8STK5faHpp6ePaNIMeiFANWv3?=
 =?us-ascii?Q?N5Tz+XQrlduqZGuy0HIRL+ccBDPLBgJOUU2/4l02BumacnG9U2BXH+L6s5S9?=
 =?us-ascii?Q?MzLGY7XX4K1KjNEuuCTzd3i5q1zzYML6Uk5buTySNgAQBgnJvSQoNNjTfmEF?=
 =?us-ascii?Q?O0euZXDbo5PA8AHpo6oyXCEHQFRc54aRGJh9ThIGR3U9LVZwfRCjZAeAedjh?=
 =?us-ascii?Q?mqTt19xTbK2YZ7/xdj0ActtL0xZShLyqLdy2RECT3/HOekrNGnmOyRYFHrqZ?=
 =?us-ascii?Q?nfSTNwRLWDurSjttn7G6LrXB+aK5gniaPp1GXXM38KuA+PkV4h68eHeP6HDN?=
 =?us-ascii?Q?Ak/vq1RCc+MTNU6PSWBETI9vZGKGJchjbSCZA7UkrPEnq5Qb3A+gMJ7P+wYy?=
 =?us-ascii?Q?OgFIPtq1ylT+2jdMH6s/Ou33qrqVU9eAauQxXyoy+cF0XP3oZJG7mzosAfzL?=
 =?us-ascii?Q?zVV1q7Y=3D?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c822e7e1-2b2a-4c10-2818-08de84154421
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:06:40.7605
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
	TAGGED_FROM(0.00)[bounces-33344-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 989082A884E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Three optimizations to carl9170_set_channel():

1. Same-channel no-op: return immediately if already on the
   requested channel and bandwidth. mac80211 sometimes sends
   redundant channel change requests.

2. Same-band warm BB reset: use AR9170_PWR_RESET_BB_WARM_RESET
   (BIT 10) instead of BB_COLD_RESET (BIT 11) for channel
   changes within the same band and HT mode. Warm reset
   preserves PHY state, skipping init_phy (20+ register writes)
   and init_rf_banks_0_7. Cross-band switches still use cold
   reset with full RF re-init.

3. Post-restart guard: null ar->channel and ar->chan_fail in
   carl9170_restart_work() to force cold reset after crash.

This replaces the previous cross-band scan skip approach
(BUG-003) which blocked all 5 GHz scanning while associated
on 2.4 GHz. The warm BB reset provides sufficient protection
against AGC calibration timeouts without preventing cross-band
scans.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
--- a/drivers/net/wireless/ath/carl9170/phy.c	2026-03-16 12:31:43.146715685 +0100
+++ b/drivers/net/wireless/ath/carl9170/phy.c	2026-03-16 12:32:14.020745785 +0100
@@ -1779,27 +1779,49 @@ int carl9170_set_channel(struct ar9170 *
 	/* may be NULL at first setup */
 	if (ar->channel) {
 		old_channel = ar->channel;
+
+		/* No-op if already on the requested channel and bandwidth */
+		if (old_channel == channel && ar->ht_settings == new_ht)
+			return 0;
+
 		ar->channel = NULL;
 	}
 
-	/* cold reset BB/ADDA */
-	err = carl9170_write_reg(ar, AR9170_PWR_REG_RESET,
-				 AR9170_PWR_RESET_BB_COLD_RESET);
-	if (err)
-		return err;
+	/*
+	 * Same-band warm path (inspired by ath9k FastCC):
+	 * Use warm BB reset to preserve PHY state, skipping
+	 * init_phy (20+ reg writes) and init_rf_banks_0_7.
+	 * Cold reset for first setup, cross-band, HT changes.
+	 */
+	if (old_channel && old_channel->band == channel->band &&
+	    ar->ht_settings == new_ht) {
+		err = carl9170_write_reg(ar, AR9170_PWR_REG_RESET,
+					 AR9170_PWR_RESET_BB_WARM_RESET);
+		if (err)
+			return err;
 
-	err = carl9170_write_reg(ar, AR9170_PWR_REG_RESET, 0x0);
-	if (err)
-		return err;
+		err = carl9170_write_reg(ar, AR9170_PWR_REG_RESET, 0x0);
+		if (err)
+			return err;
+	} else {
+		err = carl9170_write_reg(ar, AR9170_PWR_REG_RESET,
+					 AR9170_PWR_RESET_BB_COLD_RESET);
+		if (err)
+			return err;
 
-	err = carl9170_init_phy(ar, channel->band);
-	if (err)
-		return err;
+		err = carl9170_write_reg(ar, AR9170_PWR_REG_RESET, 0x0);
+		if (err)
+			return err;
 
-	err = carl9170_init_rf_banks_0_7(ar,
-					 channel->band == NL80211_BAND_5GHZ);
-	if (err)
-		return err;
+		err = carl9170_init_phy(ar, channel->band);
+		if (err)
+			return err;
+
+		err = carl9170_init_rf_banks_0_7(ar,
+						 channel->band == NL80211_BAND_5GHZ);
+		if (err)
+			return err;
+	}
 
 	err = carl9170_exec_cmd(ar, CARL9170_CMD_FREQ_START, 0, NULL, 0, NULL);
 	if (err)
--- a/drivers/net/wireless/ath/carl9170/main.c	2026-03-16 12:31:43.148358482 +0100
+++ b/drivers/net/wireless/ath/carl9170/main.c	2026-03-16 12:32:14.025829134 +0100
@@ -355,6 +355,8 @@ static int carl9170_op_start(struct ieee
 	/* "The first key is unique." */
 	ar->usedkeys = 1;
 	ar->filter_state = 0;
+	ar->channel = NULL;
+	ar->chan_fail = 0;
 	ar->ps.last_action = jiffies;
 	ar->ps.last_slept = jiffies;
 	ar->erp_mode = CARL9170_ERP_AUTO;
@@ -474,6 +476,8 @@ static void carl9170_restart_work(struct
 
 	ar->usedkeys = 0;
 	ar->filter_state = 0;
+	ar->channel = NULL;
+	ar->chan_fail = 0;
 	carl9170_cancel_worker(ar);
 
 	mutex_lock(&ar->mutex);

