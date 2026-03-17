Return-Path: <linux-wireless+bounces-33334-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HPAGaUauWn5qgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33334-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 10:11:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E902A645A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 10:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5ECE7302C750
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 09:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A5335836F;
	Tue, 17 Mar 2026 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="ld3dxqJW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013087.outbound.protection.outlook.com [52.103.33.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E5C355F41
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 09:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738658; cv=fail; b=QM7ZYr4UjNagYfr2QUj6spDms8Q/LP+Jc9Q7rcaFLM08r5+XqjRq0cITQXUItaUlKnVV7N531DZl2S+DJplMvzLMcqMoq6LouSSc+NBzjRyNnvNfHeZAPKdKzc1toyIrV14iJqwZRhRY0iBZghGzvUpPQ74o49wi0W5jX8O9Ivo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738658; c=relaxed/simple;
	bh=fi1iXKYkvgiLVEEZqDJXwj0h0jdXBfC/DgoWzDaSqdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JVHaXavUbBiJH+c7HGewuaGRKpaEwjKVCCu+FBQIix5yzxfoOnqALojq0pkE5ku3nOO8Sz4K7d2nQWUlq4odVF5uc6Lk66w6GcONiaHkprJhjXwtX75YU6rJIaZ1Ejsj1zvZfR3dwuE3HE89cL/2hLB+BrovKrrGK3XI3o7zGKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=ld3dxqJW; arc=fail smtp.client-ip=52.103.33.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0UzrlnyctKR1RoQiL6i5sfZKyWN/nnKGl/DveV6FlfpidgPpysZvGsTXenT71Lmo672SkyS6iE9uwZNHo6gAkRml40h8NrN/4uvXaGTXZQ/ogyhBoU9RaryyAHMI28SmusUsoYsB9A0RAarHDEhh1AcfXh1w3j8Qqh6pubE2KoBoNRapkHHvmFsLQleEnDSQYQYXPR56JfpcyiHNg3BmMSP+FCTbhvZddSA26aMBNxHukaOLZ1g6mGmDALICbddvWp8FKahQF2sfEfUYMqr2fKswGR/IJl6GOtTkjRMr0t2S0bBz6cuCbpg+fvShyvKgS+E0CSBSxn9gp55Za2F1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlFsugOSstT2JlFbTWRkHKm31kIFbiWoszI1k7BVfpg=;
 b=mXhflH8tNHGdtl1o8SWiKhMj2sgr3wGjYI/zouvROGCh+XTlZY0v1de5V38EiRG8b2RsmSWRq5ECgHJjvMWw5Cx0T8GH37HLDpR/swo5OnVqMcjFuVpUcVme18CwsQ7icdoLSXVGxTrDa+iIURn3tfFqa5InUSKu3orJi1I4pqjCN+Cb7bWqN+OjbOcDdWaW9cYJUZLyZcM/xmepBMx3nJrWmXH1dMJUCAFv/WNp0mncak5VFmCe3EGVumqJ6V3LiYat1+0MgYTIBBqbruQ0NQZBCWycJPn5j4uD2oKCADFwBbLG/3masPZiYo2v/aV3CcXFdwsvAOv/5norIEaruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlFsugOSstT2JlFbTWRkHKm31kIFbiWoszI1k7BVfpg=;
 b=ld3dxqJWUbHlMg0HIARAu4pjGwjlsZOiB1nYep7iNTHujs3+MMAdM6mcf/TPyp8DStc1D3ZIizYxKFy/azGWBNw1B3KnatFC8Ye21/QDjsFjw3jymq16vi8y2tt/PpAPhJAtmAV6F6kxKE9hgrXRXBExfr/p5A71Oj2VeWC0irX48buJIgExH32d/VWZc4kdRBVjPWBP9Vuuq+vuYbcrIAPUKeLzjw5Uu2KLNwvqsfw2fdgC1SRlz9svnzNpzIcWN04tHPDPEtLNsCxLs4LQVqzkt4OvRUNcrHsiM+pwF3xG5kPSGHTm00q2j7HbWGFfYK2jPbcclsppg5C5aVXRLg==
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851) by PAXP251MB0579.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:284::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.18; Tue, 17 Mar
 2026 09:10:54 +0000
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::596d:6ad8:b60c:c9eb]) by AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::596d:6ad8:b60c:c9eb%4]) with mapi id 15.20.9700.020; Tue, 17 Mar 2026
 09:10:54 +0000
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	Masi Osmani <mas-i@hotmail.de>
Subject: [PATCH 12/12] carl9170: rx: handle zeroed PLCP CCK rate as corrupted frame
Date: Tue, 17 Mar 2026 10:10:45 +0100
Message-ID:
 <AM7PPF5613FA0B634D22FBBEDB37F553E039441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317091045.23696-1-mas-i@hotmail.de>
References: <20260317091045.23696-1-mas-i@hotmail.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::14) To AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851)
X-Microsoft-Original-Message-ID: <20260317091045.23696-2-mas-i@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PPF5613FA0B6:EE_|PAXP251MB0579:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e882ee-bea2-484d-7eb3-08de84051799
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|5072599009|461199028|41001999006|19110799012|8060799015|23021999003|15080799012|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0MBnXMcaoOWQKGAUrUjnpCiSbEPSvzCn4lph+AFrWx9csPS9w4XbrPMIxp8n?=
 =?us-ascii?Q?2y23izEtOviMeBE4v7UxKitN0nP45DUxdHTg5TKzPqnizFlL8gJ8nN973SE9?=
 =?us-ascii?Q?Q0+61CLbWttYQ+E4edsqtNRYIfSvpxeQpUlkdB9L5j4JgH6bhN8XEllx1MkA?=
 =?us-ascii?Q?dIPPCC/iRLk2tqomTKJEGkVKPF7ueYXhsmWPTACPmWuoRkFGIp+kMC+Olvm+?=
 =?us-ascii?Q?fiw8k9rIMnoJQYZ1CdHDlJrfghYglHgD0MWYZL71MPaOd/BhsG5Hp6F2onTQ?=
 =?us-ascii?Q?2BneowjUh3h3m+njqqo9NvP4xf+OoPpSAV02GYWkToGC3S2xXPYouLMfxLLy?=
 =?us-ascii?Q?ETmoQ380DICQeShHpqLOMAtS375fUH9e2c1AeEdGq+j6uuM4JKfeis0sPF+3?=
 =?us-ascii?Q?Ks7E4chYCEeO1ic3FkhyBM103Gxc2w99DHYDd93amdRB7aYh7xHfHm1fXgnb?=
 =?us-ascii?Q?MpAoL263SX/v8dsVwdGjZzEBTXssS8QEqLGsxQOZ65Wj/pmWEF4U3osS/fAg?=
 =?us-ascii?Q?OMK86FS5ytUb/m3VwZWEDIvuuq2Rz9foz+I4UiHuV5il6kE/Vb7oVHjFgqAz?=
 =?us-ascii?Q?0CBDngq3ZKyEvG2hlLw9CwaCPjfRJ0Kg/efdiYGhptoTy5sO2VLVPTDnBdmd?=
 =?us-ascii?Q?/yv12+taCCh/xR60fx/Dh647S+VZ1ofAvw47fHvMDTS2z9TMUinnJdjkr4uJ?=
 =?us-ascii?Q?vrXbyHF1XGoJVPpwz9ecxK5d6NqXAT9DwAkIrchr1iXCKmKky28kwtBoLasd?=
 =?us-ascii?Q?0foO/mHuHc0254nAuHiRbqPa5I9MxsfKr1Sn9P+GAT7tsz0JmdKAqtW07G7B?=
 =?us-ascii?Q?6ARad56jP5dObdJx40rpS2ZRXMz7UvWRNWw2COV8NdUq0OayhfNvofWVGxbI?=
 =?us-ascii?Q?/q70GrskG0TrAOcpCglYagVXmm+An8+GH4U4M8MLYzenpHgfX9wThwEFo6lq?=
 =?us-ascii?Q?BlLUy4B1+AhWTKXd08hmpA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZoMBZeVg6F0GNb6bvypHupKjVM34cRH+nG/REZbmRFWlqv/xIFxQPdCLAuya?=
 =?us-ascii?Q?QxN228+UIIEsLiH7orfPvdpYdQeUCAJVEGxgvTtpxE6sJPlYu8de9IFfaiug?=
 =?us-ascii?Q?dDcL1vQwWfPNoGqxbyyF5hLG93uVMwzIWeN6qktZap5br8h3SOJh2VXc84Pr?=
 =?us-ascii?Q?nk3+rkFlmN+TRiEPiiZJ3u8eR0c+3rm1zD11co/BBPeuI0Q4Dz8r56XKGmsf?=
 =?us-ascii?Q?Pna5509aNd9iZKHTf6W30EHmh+gayZ56OsGy3QtNvVDzuorhm4RZL4mHBGR6?=
 =?us-ascii?Q?hLi7CZZ2fFKc+PTbs9L2FC5BWoAZqE+fkRrxz3kkseHauTfdKzR/i7YWvUmf?=
 =?us-ascii?Q?UWPP947b07tpjBJimOL1eA84YAwYfDTZlnR77qrlh7FVq67rCGcMVs8EcY8L?=
 =?us-ascii?Q?HkbbJ49gQF4MBv9slZNUGRsKNh0sJ8gYGgqMaWQ8TAi+M+SnQ9QAiaphu7Pi?=
 =?us-ascii?Q?mkzaP9qOUtCL53iz9Yb2KdmOKo2yf2gkKvbb+8TtmhwGRaDI9x+wy9yQE0+T?=
 =?us-ascii?Q?yfQuIIYLqHM80oWZUFtWEe1z618SW5nojaYJK0M9PGcjYi+xtbF75vSbpSzd?=
 =?us-ascii?Q?R5HSBwAV6UK5/vYmzdPZbD3Zs9UYhOyloRKcupiAtQfm3pYHJ8891MO5cAVp?=
 =?us-ascii?Q?CjZjvZ5c4Nae6mgqdS47CcmAEyStPSPvlG/fmh+wmNObEwZkrz3PENKURioY?=
 =?us-ascii?Q?vMvx8iTnZzvSV+FNknqO1Dvu5XnNbrSmXt2zSKGXPT1U0F8nUcf7n44XIzU5?=
 =?us-ascii?Q?GN9ldRU71OfVGCcIokS8oRYBuIhPDVdYkwAeHSIH+xc6lINQB1cOBVEnGuOs?=
 =?us-ascii?Q?I+w1IkIXsBLua8Cj2zcpYozTR5FmyFwJn76TXMev5srgE/jfReAU0WTGbiG5?=
 =?us-ascii?Q?c1pSrZnF/lxWbahDihuytJXHCC6HJEeqfzdmfvZA5LDgKCCMCUUpJVCf9hb3?=
 =?us-ascii?Q?w4vCnA9AuB3vaPZ/SiUlfHhQ/co39xVtRCfvwiiaYciLJGDf4UI41sOc9SZE?=
 =?us-ascii?Q?oUXj7f1QDxwQrplAuTIabMXb9O6i17dfryJf4MweYjJku2V+TeHe69A5+DmI?=
 =?us-ascii?Q?R88c/tcNq3SLcfVfmHc9OT5MoVwoKOpro3AneDsy1sFcM1Nbji2NXvqs+fTV?=
 =?us-ascii?Q?yQ1KL7RrbQEj1S07tgHI81RZD7frY7+t9UadroBHPrbPf8z1mOT/sKNJ9438?=
 =?us-ascii?Q?L5X+bQbs8ueR2rCZk09/BVcoGfmM0rbeW+iNTFTeAdGcMGUwm1u1EsiFQ2Hq?=
 =?us-ascii?Q?goLD7a7GRKFrhqL2R9Zm4xEGP0JTdsJd1B2f0ZZaYi27FMCJDs/HbtlO5uRn?=
 =?us-ascii?Q?Yco1oFwu6dUsMPx36facRit+ExME9/orGRBAErg9W2rE02gZwNHtUaRPXG5T?=
 =?us-ascii?Q?I4Xdd9LKTrdxvsgAc7gTvmu1AG7n?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e882ee-bea2-484d-7eb3-08de84051799
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 09:10:54.2190
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33334-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,HOTMAIL.DE:dkim,hotmail.de:email,AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM:mid]
X-Rspamd-Queue-Id: D1E902A645A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The firmware occasionally delivers frames tagged as CCK modulation
with a zeroed PLCP rate byte (plcp[0] == 0x00).  This typically
happens after PHY state degradation from a failed channel change or
from RF noise on weak signals.

Currently these frames fall through to the default case and produce
a rate-limited wiphy_err log:

  ieee80211 phy3: invalid plcp cck rate (0).

The frame is garbage regardless of the log level.  Handle plcp[0]
== 0x00 as a dedicated case: increment the rx_dropped counter
(visible via debugfs) and return -EINVAL silently.  Downgrade the
remaining default case log from wiphy_err to wiphy_dbg so that
genuinely unexpected PLCP values can still be investigated via
dynamic debug without polluting normal dmesg output.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 drivers/net/wireless/ath/carl9170/rx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/ath/carl9170/rx.c	2026-03-15 23:51:23.599698582 +0100
+++ b/drivers/net/wireless/ath/carl9170/rx.c	2026-03-15 23:52:21.041912498 +0100
@@ -372,9 +372,18 @@ static int carl9170_rx_mac_status(struct
 		case AR9170_RX_PHY_RATE_CCK_11M:
 			status->rate_idx = 3;
 			break;
+		case 0x00:
+			/*
+			 * Zeroed PLCP rate byte: the firmware delivered a
+			 * corrupted frame, typically after PHY degradation
+			 * from a failed channel change or from RF noise on
+			 * weak signals.  Drop silently.
+			 */
+			ar->rx_dropped++;
+			return -EINVAL;
 		default:
 			if (net_ratelimit()) {
-				wiphy_err(ar->hw->wiphy, "invalid plcp cck "
+				wiphy_dbg(ar->hw->wiphy, "invalid plcp cck "
 				       "rate (%x).\n", head->plcp[0]);
 			}
 

