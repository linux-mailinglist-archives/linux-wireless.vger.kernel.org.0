Return-Path: <linux-wireless+bounces-39152-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3ur/B+qXV2p4XgAAu9opvQ
	(envelope-from <linux-wireless+bounces-39152-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 16:23:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B623F75F53D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 16:23:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=smu.edu.sg header.s=selector1 header.b=X9KbZXPN;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39152-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39152-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=smu.edu.sg;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1D1D3009E19
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 14:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2853320A04;
	Wed, 15 Jul 2026 14:08:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022121.outbound.protection.outlook.com [40.107.75.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662AD367B94
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 14:08:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124513; cv=fail; b=mMEv42DU0D7xoK0y6MDb5LP9T1WV/ROPMvLNDanC3d+Xxy2nGuMGtS628JlG8xghGyfWkZvIlpK9ipghXRcebn4zn9YRfSGPrHeG8/0HAfziVJ2OOuzXZ6Ew2bI4a7MbiXUAPFtS8lWzDd5sKvRPII03Y4xa0fnuNrVYnNkAawc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124513; c=relaxed/simple;
	bh=JXniztlEKDU9LcdOl4WIN0zTwEkZoZV/NFhe5PGtbCY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ldIi0Ch3PX5QNtlH+UPovlhRZCMlbktOKz3GWm9VcQLP2Tmqgf3JWaxW+tOYO8y7oDvJ3+e8eNEWsatMcDWLzkIVj3qKWQazhUCeM/sEdKgvskHEEkIQiGeDYeNglGrVnJMjlA5PBcklhd6U5+cqjkvsbO2KeND3cCqeS9xWeKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=smu.edu.sg; spf=pass smtp.mailfrom=smu.edu.sg; dkim=pass (2048-bit key) header.d=smu.edu.sg header.i=@smu.edu.sg header.b=X9KbZXPN; arc=fail smtp.client-ip=40.107.75.121
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbTD9WZO088M0giDsMlYsw0d2MCM8Kc9/bz4i5Qj1ZBt/R5zN0bdUAGPCR4SN5t64sAj/WgYxyhTkGKxYwCRtzZXV1h55TvjyzDijuZF/8PMRiWgOAAfUWsHK6uEBTRcOgoIUcRExTiiKafi6ethQQKPRri+yYnlxvFZQw8du0+tKH/mp6WL+kNK1NrovvSd3gfq01VyC7zy0A6TiAMt0/ZZm3hHYyBAoUJaCGv4dQ1uJNRi7FZx3cYlGOTXZJ2GX5RYmH7a5a223fj2OTEzRTXTBWtW8J/OLc23pONEa9m3I2WdfGCVg3LETBybOf7HYPRCQaUD/bUny/wamis54g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8WprgJ25QuNoSwOC9UKhr0Aio5ErKppW8ZSLWjZ/ks=;
 b=YkczpRmvLfkf+8nbxr9yDj65A35GaYaq0BWYAzwGQvdW9PoKkFAO/tz1UbSWuavq8oarl3tRjxprsKd7ziv79JiZJtdM+lR4q++g3O8hk1Ulksb1tuemfKTPqJgk9hD+dFwjeWXSq2vrcVIh4caiV4yfdjWso+odifnv3+gvCg9lqruYUtLR5cYckDuctLarvxtLJNw0nCmKjI5kSe82qG99CDBmcuwlDplM2cLSDvgjhEkpy6TdgwiSVe+WNIn4EUmEmwNp268bDKLPseKaHj9kIfrG2zSrUgryTUppLXBDQLjIeC3moC73FOk/teXl3pLyC1VQqGpWCn/vkhS4lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=smu.edu.sg; dmarc=pass action=none header.from=smu.edu.sg;
 dkim=pass header.d=smu.edu.sg; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smu.edu.sg;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8WprgJ25QuNoSwOC9UKhr0Aio5ErKppW8ZSLWjZ/ks=;
 b=X9KbZXPN0wtVG4o/VxmoQLJebg9ASgwINl3v5f9oe9Ft4jqLd5eMs8X1nDgW4qUpKxR6LyGZ6XxsjvGQPXnKQ3eIdlFD6kv1snSp18dhRYa14Q+4YBTqqLqxu/i5/LeBrPXbCHh3mFLII1yPyaSgBqVMT+kvQywgtkQ1QCEmR+87t8iy2I4l0UKslFZ3KWQt3sOpS7YfYc23hscpfflHtLzDpLHjqAeOPg+ruFt4r2AXnhyzc92s75LIyOXHAKXhiBR3I2ZMmgeW7X267HCgdaX2e+HYMEGGuWE4idxQYYjGxc02VN5mc+YTphoYo0BRWRmwA0NcKs5WZkcXKFTlEQ==
Received: from KUXPR01MB7791.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:3f::9) by TYZPR01MB6100.apcprd01.prod.exchangelabs.com
 (2603:1096:405:77::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 14:08:23 +0000
Received: from KUXPR01MB7791.apcprd01.prod.exchangelabs.com
 ([fe80::6bd0:d704:7d90:a595]) by KUXPR01MB7791.apcprd01.prod.exchangelabs.com
 ([fe80::6bd0:d704:7d90:a595%5]) with mapi id 15.21.0202.014; Wed, 15 Jul 2026
 14:08:23 +0000
From: Huihui Huang <hhhuang@smu.edu.sg>
To: linux-wireless@vger.kernel.org
Cc: Huihui Huang <hhhuang@smu.edu.sg>,
	Johannes Berg <johannes@sipsolutions.net>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH wireless] wifi: at76c50x-usb: avoid length underflow in at76_guess_freq()
Date: Wed, 15 Jul 2026 22:08:10 +0800
Message-ID: <20260715140815.1242033-1-hhhuang@smu.edu.sg>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To KUXPR01MB7791.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:3f::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUXPR01MB7791:EE_|TYZPR01MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: fd66af80-c6ee-44b4-4859-08dee27a87da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|786006|366016|23010399003|52116014|1800799024|376014|11063799006|56012099006|38350700014|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AcABRfZsot7VhafAuaLveM3Nc1hiwPajJ9sO6R0Fdykz4qpn74N0ojTxZai1L/PHThTFmRdftLhTavVEWJq6X++yvRwgrDlQQirNdgIlo4zBbJveMFnRHsviWvBz/tKRWThIgc4gpL/g/Tt6fjERR0xkRMsvkbYTWEtjIRvM+w9vztre4RIxwT10pc0Lodift7Gg8HHUBMZzmABsBdCp+mDm5UnO9VyqUyUBDA57TR22Pq/c0pyVhB0NLzX96hq0Rfy/0CyPG3XndSrACumHayClKTGXqkGzlkqRw+4F0Ncqb1z6Q2JQmZMMKLtMoFqNvfxdoktPIUXfjn4x4mbvCoYmIJHlF8SDX6PajmTMNZSsQrFurW8f5ICXpSBlnoMjqZ1Zh+G+lloniiQppDeXgE75AXk1cba4nx8Zghbnx5RAHOTCjFogJPVkxIyJ31LdM400ZxyDKcXutoNMn+048vP3OvV+oALojU1HiFbATJ5wUy5X7eOST2v6mrpXtkmOXv5R5wY8WNd7FfD1VnDz47jvqT3UbpRdn7UXy25mzS45QQgbO/nkrEGpRB/HZSVyA6mhhaFi+5j7JLbR46ZNpO3dgZeGdAksMMXcPmwRaM9Gv0Scdy3xSFYQ98OWk0WtPHlzjapSUZKbbZbQWEq1DP9dmPfHnQipbwKL6kzrIJMLF0lkhaNNNXQMJy71jzuHdnqZPQGs8p6nfxnYEfkjwIezvrUPK/CalEadfF3GRis=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUXPR01MB7791.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(786006)(366016)(23010399003)(52116014)(1800799024)(376014)(11063799006)(56012099006)(38350700014)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xLSa3OL9n7tVNXROB+mDi6Rj2w3rqfCkXr7BLoktuQq+yogXtKEgtgyeBIiz?=
 =?us-ascii?Q?cxuxHyvLXMzk6xWcMeNzcYVO8x4sL0+mDnV9ut0POgzApJ0xxfXPiYsPYuOe?=
 =?us-ascii?Q?/+prXsYkLa+8aZpQRneDYbs3EckTF+ob63jcmuGRtjlgsrTorAecDLKSVkI5?=
 =?us-ascii?Q?ZCaTTwdSNXjLTj0plwK9LJetvPBGaJSo5mQvJCm1jlIIzJdHZX1NdoZVRSeB?=
 =?us-ascii?Q?l5Sx1bA5JHJ8cE4F9eb1G9AL072RFyZajiF8G7RIfsRSr1jzs35Ha0FglKbw?=
 =?us-ascii?Q?7oVdWlb0rDIlhrZIXnFwKecBJj8WCF9B+WlN+BOCXplax55zKpr8Ot0DhgTU?=
 =?us-ascii?Q?EKpcMOIO/WBbUFsMBak1JsgRmzzdildnJ9DWpJGFdi9yEvfHsHILPq53Y9+Y?=
 =?us-ascii?Q?MKGIcCTehR9hrkJQrYjp1c8Um1GKXQGoJWCRdzE3BEcWSH7sjcOAw5YPDPrd?=
 =?us-ascii?Q?UrpK5nY42CKYHbD+7b+5ZA7os6Ldby0/vwVqk9e9KAeeCGgFz9LQ0zaAmw5j?=
 =?us-ascii?Q?VPA6ClBnJLah+O+w/ujKN7ARK4TK9zElOC/omHFKbIGSZP77rWWasVVoEw6Z?=
 =?us-ascii?Q?LUaoU62pNFuqVCipV+I5XRkfoYYzxkCGtWQaTGrV78wPLfpJ4SjQp34tLoZE?=
 =?us-ascii?Q?7dftP++Il5akYmfKmmukoFs4zKUfEKno6sKHvLo53Sn7SG1Z+autshFNkLlp?=
 =?us-ascii?Q?sEGMl5Nzhry1hZl+QYSt4bga+j1gzRcW7slQA7MHG9xgGP7kbOHAnJIQ7gK1?=
 =?us-ascii?Q?+V3jc5KFtWYHqznWPzOu013adAZI8aGPAWnnOg4dGuZsVlwY5lUVV3xbSjQw?=
 =?us-ascii?Q?s6U9K6oheJYJNX4W8Tc4FxeEHTyeV/C4EEC4v8hZTvjfZzmqiPINDuKqfIBx?=
 =?us-ascii?Q?U/I8PLUNyLHLtyTfvlmpSI6CPzREi9ptxzpwsXxG5nzJr1CA9TIlLF3vtFmX?=
 =?us-ascii?Q?GVE5CwbxILAF8BiIMM3xFpE7v58XYkTM+LIn69U5ABLBo9HZFvZsSOIlfTyd?=
 =?us-ascii?Q?Ee7C/uqOXjaoj2RIWouzbEzWUykf5+Sc1F/TsnP97KVEKR/mnl+RwF5aQc4X?=
 =?us-ascii?Q?L+bnU0KAphl+05ZbcvBTx/udGdI5wVNFo2CcivaICZ9YB67YhQEODrYy0Un3?=
 =?us-ascii?Q?WpW4+1xH/pViJc5iqIaBDe7r/H/0NpYFQpbNC+xeSNQO4vjQNSuf4Ok34g+m?=
 =?us-ascii?Q?UGktrCJ8wYLuVJAMOw/Rp6xu4UYk1HMsdX0g8v5oeMpEH/8LAeIckAFitSgo?=
 =?us-ascii?Q?dm7O6fei1CRZx5nUve3fs9P4KxE35hSIdXakScNzRlH54IgYdDfw3u+eAT0u?=
 =?us-ascii?Q?DYEv3fB5uSlckEgS0gkjEreB7o0e1RdipUahp1amqJIxt+NfqaTIFVW46gs2?=
 =?us-ascii?Q?XZFcAUfZaTWk2dmJ4qQPi8xdfQ7kxWFy4KXqXVmdwgQ+XGAYXyBHJOvlgxhJ?=
 =?us-ascii?Q?PEnGj39iOWnxwxs6hvHDnEtkEoeyPyvHw50GyrDxwhYazSEpeua7MWqNtqUP?=
 =?us-ascii?Q?4wrLCpR1oGR6LEMNZuDf8RQyRgDuSSHnvO3SBEqBChiITODFBmVfJoj5/cSw?=
 =?us-ascii?Q?OTSmjXEpraThFuREo46vQpmDKD0GvhmgZqImo7lAS/0qYpE3sD6O2Tz0FeY2?=
 =?us-ascii?Q?Oi5yXivdAq8rz5TTSojMvCdxBMe26dSYMMIIyS+vTBXYi92H7TUx1sqN+gSP?=
 =?us-ascii?Q?j7jiODhYZzO13ucgXNeF3GElAjpfXQtOyzI1pCJa/WyxKmglKqFVrjbuuX3x?=
 =?us-ascii?Q?7Yxzf6mC9w=3D=3D?=
X-OriginatorOrg: smu.edu.sg
X-MS-Exchange-CrossTenant-Network-Message-Id: fd66af80-c6ee-44b4-4859-08dee27a87da
X-MS-Exchange-CrossTenant-AuthSource: KUXPR01MB7791.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 14:08:23.0056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c98a79ca-5a9a-4791-a243-f06afd67464d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zscVHxiRU4FmCn8eu20Gxlh8CqJ+3SEUflR1MFqyCUUbQuiN6CnfGMuPEluEPZMUPC47s35Nxy7Hxg+fPhGmZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB6100
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[smu.edu.sg,quarantine];
	R_DKIM_ALLOW(-0.20)[smu.edu.sg:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-39152-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:hhhuang@smu.edu.sg,m:johannes@sipsolutions.net,m:johan@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hhhuang@smu.edu.sg,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hhhuang@smu.edu.sg,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[smu.edu.sg:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B623F75F53D
X-Rspamd-Action: no action

at76_guess_freq() checks only that the received frame is at least a bare
802.11 header (24 bytes) before subtracting the fixed management-body
offset:

	len -= el_off;

For both beacon and probe response frames, el_off is 36. If the frame is
shorter than el_off, subtracting it causes the calculated IE length to
wrap. The length is eventually passed to cfg80211_find_elem_match() as a
very large unsigned value, so the element walk runs beyond the RX skb.

This path is reached from at76_rx_tasklet() while scanning. If the device
delivers a truncated beacon or probe response, the oversized IE length
causes an out-of-bounds read during scanning.

Skip the IE lookup if the frame does not reach the variable elements,
before subtracting el_off.

Fixes: 1264b951463a ("at76c50x-usb: add driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Huihui Huang <hhhuang@smu.edu.sg>
---

Tested on wireless.git commit a0d82fb85053 with KASAN and a temporary
KUnit test calling at76_guess_freq() with a 30-byte beacon skb while
scanning.

Before:
  BUG: KASAN: slab-out-of-bounds in cfg80211_find_elem_match

After:
  ok 1 at76_guess_freq_short_frame_test
  No KASAN reports.

 drivers/net/wireless/atmel/at76c50x-usb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/atmel/at76c50x-usb.c b/drivers/net/wireless/atmel/at76c50x-usb.c
index 32e3e09e7680..d9c2809be4ba 100644
--- a/drivers/net/wireless/atmel/at76c50x-usb.c
+++ b/drivers/net/wireless/atmel/at76c50x-usb.c
@@ -1521,13 +1521,16 @@ static inline int at76_guess_freq(struct at76_priv *priv)

 	if (ieee80211_is_probe_resp(hdr->frame_control)) {
 		el_off = offsetof(struct ieee80211_mgmt, u.probe_resp.variable);
-		el = ((struct ieee80211_mgmt *)hdr)->u.probe_resp.variable;
 	} else if (ieee80211_is_beacon(hdr->frame_control)) {
 		el_off = offsetof(struct ieee80211_mgmt, u.beacon.variable);
-		el = ((struct ieee80211_mgmt *)hdr)->u.beacon.variable;
 	} else {
 		goto exit;
 	}
+
+	if (len < el_off)
+		goto exit;
+
+	el = priv->rx_skb->data + el_off;
 	len -= el_off;

 	el = cfg80211_find_ie(WLAN_EID_DS_PARAMS, el, len);

base-commit: a0d82fb8505326cbc53dc9a0c08f97d11197bb30
--
2.50.1

