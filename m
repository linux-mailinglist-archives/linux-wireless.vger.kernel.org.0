Return-Path: <linux-wireless+bounces-33088-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JnPKKyXsmnENwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33088-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:38:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D43270671
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C6CB305B34B
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D927B3B38AC;
	Thu, 12 Mar 2026 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="WMO/cDJm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013082.outbound.protection.outlook.com [52.103.35.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A88C3BAD9D
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773311899; cv=fail; b=FQ4Sh233CO/7ejzIdz0A1CvTKWcc0gtP3IjMAWVqokSSw8SiJWGyzYno1QxL+iIvEvQHj0+qGHYeDBKKZ5eLz3r4Y/Dq24Bki45+gQ7FoluMcpt+mJCm3R91jpcXCYsx85UOMyehsmm5Y2pNmzS1l4HIgJB+szimLfHwXAYMpg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773311899; c=relaxed/simple;
	bh=hrjmIlKksuEiKoVp8rU3OA1QIE52vtDlSO+P/7YL5mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SYMtKU2qnFmuzQ3tjVXp1mav7XxAFt/Ya/S/o34MJ6wQULq7irOS6+iW8nB/N0MMlx/2gO2xRlRLZ8fpPva2xhantHngtU2turKdcwnshli2TKwRIJYOYR7jhyhDjrHcACPO6rmM60dMdbjrSDV3G7JmQHFiD7ndEq/EywlrXcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=WMO/cDJm; arc=fail smtp.client-ip=52.103.35.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7ABAuIgRdf8qmDQzgMbDEPhjvbPrP6tcCo1ZfXGP76p3HhYwegbqTjfIjiWNMSVuEn5nq+rz6sn/eKLpeZ3Xd0spKk5sas6nD2jY3aNieuy1QsIxnBAjOU3ZV7RvRWCrltHrGIU6OK9Cj1cLgePpaUc1yQOeR67in6ZTFINLrC/dqpWcSPPjTn5vZRrsOIs+czyu9As7j+qM4P8UEVyR/TIcsi6F10cQr8Z+u1R3a2Dy7C6t3F8DmcqJ37l63XI1l7Wiuo7Ui1mIgQo/fH6wc23HOROSbss/Xca3p3MZkR8NneKkhIS4F5vVkZCVAx8UvdagFCzoCwVDzhTZOuXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9HHg67fxIqHi5hEo6oSabR/COmrUjhEODQmaBngDB4=;
 b=tZPIMInOJ0v77habkLW7e4iEdlwepYHk0bD0IcGkTiNLbKZxCNYfsiStO9P4OUYIs/6WvLOt5gI7A+/bwPJVVbhCOKi3PH3lhD8eySN9v7qYFwzQ4ESu43uovbZGbNCCuF7MIawXoHc9oNEXRhYoowcx8aMdeWUK6exYz79k5CdWXShwx/XHYtS98uUF462w/cuLeyNiHx5mnFokKo42d4UOIvZLfbQN0+zlB27dH13mJPBEfzz/FY8k5j5fLdmobGf0AoZszUuk02J3lnVviMVBOCuet0tOSm6oFCefrkdZWoCeW0vwV7ZEN4XgXqhUL5txmhV9/pO1DEGd8IDm2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9HHg67fxIqHi5hEo6oSabR/COmrUjhEODQmaBngDB4=;
 b=WMO/cDJmEwgimAg85u1rsEN0Uy46wZlf5LV4ru6qNNu8YOcjBSjnGeMbr4P3AeValZWMJeU79CKWw9+VkznQRc2LOOeRGRKBmG9UBBu2Yo1hQn4PHArCFNO1yBuUxUjHKDW/+P528W9nAALBhfOvpYCE7aJNkewX7sOjQaen9lr+sb0Yw9UcawIvX0W5Qcowe/126kU/6CBUxiw9DmV09Mcg5Sz2a/hq+dNzeuA6iTE6mk82fiw53wuBMoIfnMW+Cr3r/vmoRc9HVLrwuP94PMR8OoF6abS7Hcfr7CmjDKhfuUgS07Ou8j+uWgSNpBWSE8vLfV80pkA3rn7UfED4Cg==
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851) by DB9P251MB0259.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:2c0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 10:38:16 +0000
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c]) by AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c%8]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 10:38:15 +0000
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	Masi Osmani <mas-i@hotmail.de>,
	ath9k-devel@qca.qualcomm.com
Subject: [PATCH 05/10] carl9170: rx: track PHY errors via debugfs
Date: Thu, 12 Mar 2026 11:38:00 +0100
Message-ID:
 <AM7PPF5613FA0B6B42814E38096301FE9429444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773277728.git.mas-i@hotmail.de>
References: <cover.1773277728.git.mas-i@hotmail.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0277.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::9) To AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851)
X-Microsoft-Original-Message-ID:
 <3a8d62731d5bc391550f54749a197d6ab4683e3e.1773277728.git.mas-i@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PPF5613FA0B6:EE_|DB9P251MB0259:EE_
X-MS-Office365-Filtering-Correlation-Id: 96459877-232b-49bf-39da-08de802377cf
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|23021999003|15080799012|19110799012|5072599009|461199028|51005399006|440099028|3412199025|3430499032|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	N41T0V9cl7YubPXjOJ+tspfJz6DFPP4h/kvTnRgmUrZte1ReeleJI6tJOZpKVYeu0a5OcLENP/b/ClNGMuQsZ2JBF2jnYGUCieZXqO3mXBqOaGdz0M5Ik6OfVGNm+eZM9Xpd4u9niCJl0+czbgiO9A8UdnkoHAKXng7VlGHWaRIX0f9V7SQYLqWra9NpyNpRvDHjIueXU0ekyiwKqRwPZxR7qemGjKrFTdD8YlZl69Uh8NiCuTnCbdXfcrx6CWlzTOFUU8oStvmuywNmXAkDGakVmzBxd086DIbxdi+Mofpep6RP8MEkHaHFY3hCyHpRyZt4+YcbWNGy4gX+jLuRKfGNmTAtWjniD0PDkJnzSE5f1LuRzYLC0JOUJ9NdEi6KSC8Xi2Qnq+5fx25SOK6MZiVPggFHtTt9rgB/HiWy772T+3m9uEmr7CKaXuPBJ0dXxMcPG2lNY2hslEaISTBqJy5uhiWz3o1c1w5arXId0gswCEhfp06t8ejK5eOBrZ5TYu66lLeIY9GEv639aKtoCKZEm9HU6lMQNLjgiICtgUA3gTz+mv2jDZigSS3D0WXMgmn3r0sgEyR2x146yoIjgFuM4zY280vKjQ5wKHtbvHYO1mK0HSPPQSeTh5dROhc0md64ECvY1+wrw4JUubpx6GMDCAH3GZ6SYiEsdDX4sug31fJucQOodqysS6sJDglIj+9isWYI9qm+P+GB10sBftTTC5wPNB3QU8xRnYc4elvPDGIIYGPNk0MJfkSfjV/KcF1LwgZKi/Zmpc/mP0/qyznXOn13A3IRdlmFirSWnUIOLvtxjxbsvp8yMTyytDX8v/QOW27KwW+3ogh8BJX/cXlQoNMYNpEmznhReEEKNQliEJiwcleJgGNPug/0zAbc7PvJyVnXy8bWtK3z0DTBJwDxyy8LDJYcsaJnlsndBfkJ2grgNS6NEO5mamIlI7/W
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1PfPI4M2csrnjWILxU+SOAejQGZj2fuTmHv4vhTPObWwmcxt6dShVBlxp4xc?=
 =?us-ascii?Q?fW8hxwf+S0xIcUUyotVysKVfX3M7tAxLbdKHfJinhObsQpki6bfGDvSZtxp6?=
 =?us-ascii?Q?CK4Si3Q6etmgaZG9GifyVl/OnpjvzirSWTa6xcZMVgHpGhluaYU1SvIIBmvZ?=
 =?us-ascii?Q?ZZ72aOPR9iNEGXDeFxKsOq5zFUw3O31hyj8OgV13E0X7bBPQCU8JUYK5Ywzg?=
 =?us-ascii?Q?HZONc9OLl8I8vhQaqZG1B6FYzmYAs4YB44LWoasPMtWYqCdMh0ex4/zKVUQz?=
 =?us-ascii?Q?gqCXAF2uRthMRLBBHNjF01wkPnYgfimw/Z/3f2sFOfTvCg9YPInbXkXmY/Xv?=
 =?us-ascii?Q?XYnxvGqIgxk0v5Ek4FI0DMnaIZbEYydw8iYnTb/+UypRbFfizr4tTxOUO4kW?=
 =?us-ascii?Q?V9vVq766refbyeLSQ3/X3IN9FkUW3G+w3NsaGJNNOPl+Ao8iFkBFxzal7CTE?=
 =?us-ascii?Q?mhvoP5nMoIJ5264JlNdAKDboVPo7CM7RsPKj8ZcaXxxohgkLyrijHHLIKYXs?=
 =?us-ascii?Q?mtPziBByCRTx12yezxvKOvk/UJ+J5ShQifW76MYTHKT73NkhtBMtxxqQ510B?=
 =?us-ascii?Q?tlkUsUPOsz1BQ3UXgLJQfMA+S04MOsBfaXmcnYikhJ50dPAHXCKnQj8o+JSU?=
 =?us-ascii?Q?+NlU5zg9xmPb6oApWobifS8te4CePyfYSuFO5bpZUhK/tjlsbg8EDa2HPI58?=
 =?us-ascii?Q?nM24EyksVQnh+QARSZZt7GNNfNugfnskdpWpMipI2enBdpJay/NreJ+65HEB?=
 =?us-ascii?Q?5v/g4l3g0wxDKfsC3CXcPBx53thGVCiMgNgm5z7gQEaiujx4oVk2443XdkJE?=
 =?us-ascii?Q?i69/2FUPxPkd8Qx7TO/H1S6lCofzA2q6oAJKIfDs78Uw5TEtGTPOZNsSYBrS?=
 =?us-ascii?Q?1bvXwatEUKyqq5MLP49/1eq5HSXd4qWsW46X/hDGziioOYfY3xODuYtF2N5W?=
 =?us-ascii?Q?oh2GcOj4LgESwVGQEv24vALpYH2+GEIOw6BNm5QDIb34gPfaFXG1C4LV0Ug+?=
 =?us-ascii?Q?9GWiFBhNH9vUWTmcm8SoZnu1xC9ObHH3K3u0NGQFNUVHRQtqRJUmoKCVqUCx?=
 =?us-ascii?Q?5Ajzr6Sudy0R0Rk3URJqxkerLGmPVUI0HcygPtDKl7mNjJIex8GgGWcvmhrB?=
 =?us-ascii?Q?6oCZ6oNUyYIYuHTERuI6NWUgDWMRlujxQ9M/gbQK00OWfRGLGk6OwlHOfxsf?=
 =?us-ascii?Q?9A2QVFRe87D27Ciwv19BW4ylhTLT6ZBXXRD4VkTsB+rJRMv7QzlbQxosUa32?=
 =?us-ascii?Q?15jrbG/7ckSaN1/FH02awHVdBGGOTZEubyd3/IXSpHbNAPytaZBl/zH94kZq?=
 =?us-ascii?Q?NGgkdCpCKByWpd0hyFPVxQEeubVDB7dhiTU9KTWao6iqqwNR0GhH/baPwYE+?=
 =?us-ascii?Q?SPvF91lGkAloZDCveOjv8pwc7whP?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 96459877-232b-49bf-39da-08de802377cf
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:38:15.7894
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33088-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hotmail.de:email,HOTMAIL.DE:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM:mid]
X-Rspamd-Queue-Id: 66D43270671
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Count PHY errors reported by the hardware in the RX status and
expose the counter through debugfs as rx_phy_errors.  Previously,
PHY errors from ar9170_rx_phystatus were silently ignored (marked
with a TODO comment).

The counter helps diagnose RF environment issues (interference,
multipath, low SNR) without requiring monitor mode or additional
tooling.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 drivers/net/wireless/ath/carl9170/carl9170.h | 1 +
 drivers/net/wireless/ath/carl9170/debug.c    | 2 ++
 drivers/net/wireless/ath/carl9170/rx.c       | 4 +++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/carl9170.h b/drivers/net/wireless/ath/carl9170/carl9170.h
index ba29b4a..eaac859 100644
--- a/drivers/net/wireless/ath/carl9170/carl9170.h
+++ b/drivers/net/wireless/ath/carl9170/carl9170.h
@@ -386,6 +386,7 @@ struct ar9170 {
 	unsigned int tx_ack_failures;
 	unsigned int tx_fcs_errors;
 	unsigned int rx_dropped;
+	unsigned int rx_phy_errors;
 
 	/* EEPROM */
 	struct ar9170_eeprom eeprom;
diff --git a/drivers/net/wireless/ath/carl9170/debug.c b/drivers/net/wireless/ath/carl9170/debug.c
index 2d73456..0498df2 100644
--- a/drivers/net/wireless/ath/carl9170/debug.c
+++ b/drivers/net/wireless/ath/carl9170/debug.c
@@ -794,6 +794,7 @@ DEBUGFS_READONLY_FILE(tx_janitor_last_run, 64, "last run:%d ms ago",
 DEBUGFS_READONLY_FILE(tx_dropped, 20, "%d", ar->tx_dropped);
 
 DEBUGFS_READONLY_FILE(rx_dropped, 20, "%d", ar->rx_dropped);
+DEBUGFS_READONLY_FILE(rx_phy_errors, 20, "%d", ar->rx_phy_errors);
 
 DEBUGFS_READONLY_FILE(sniffer_enabled, 20, "%d", ar->sniffer_enabled);
 DEBUGFS_READONLY_FILE(rx_software_decryption, 20, "%d",
@@ -830,6 +831,7 @@ void carl9170_debugfs_register(struct ar9170 *ar)
 	DEBUGFS_ADD(tx_ampdu_list_len);
 
 	DEBUGFS_ADD(rx_dropped);
+	DEBUGFS_ADD(rx_phy_errors);
 	DEBUGFS_ADD(sniffer_enabled);
 	DEBUGFS_ADD(rx_software_decryption);
 
diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index c664014..414d499 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -455,7 +455,9 @@ static void carl9170_rx_phy_status(struct ar9170 *ar,
 		if (phy->rssi[i] & 0x80)
 			phy->rssi[i] = ((~phy->rssi[i] & 0x7f) + 1) & 0x7f;
 
-	/* TODO: we could do something with phy_errors */
+	if (phy->phy_err)
+		ar->rx_phy_errors++;
+
 	status->signal = ar->noise[0] + phy->rssi_combined;
 }
 
-- 
2.51.0


