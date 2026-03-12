Return-Path: <linux-wireless+bounces-33109-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O/VJ2DPsmmPPwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33109-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 15:36:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0468A273788
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 15:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66B203062216
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 14:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D1935B64D;
	Thu, 12 Mar 2026 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="OUhJiAmq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011028.outbound.protection.outlook.com [52.103.33.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58016220F2D
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325828; cv=fail; b=PxxhDfYJm3ntRplpkMc4jMCnAjVpP2KCQGtAqm3i7nY2+tc07V+qV4MHrukY96Znznlivzey8D1ujJCzLE60lRLbw4zzmDSubgohojYsmvqdLAYEZC1l/Xv6dx2WydHhgT4E2j3d3Um/dQ57vxmgdOzbOyvu5sPRwd1Hznh+lFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325828; c=relaxed/simple;
	bh=UkQinA7gS38c95zsaclVYU1MVR1zjOPDR4EiIGI3iKE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=C7VCfsWU1AtiX715BXaWaRQN0+ZBWvYXJuVVWmXFXKrV/iuENLEv2f6odBkpWNw2GUZbuflWNxd26Q8mHnfC8fh0zTppCgH7deEwzix7ysCYXMdQT4hoC0DB/ulAXTtXVd0EnEp7U1wE7MYenCkQx5VrKQu4MX7/A6Gs3DXrrvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=OUhJiAmq; arc=fail smtp.client-ip=52.103.33.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTY4RrgjZoZrB/A1/cbSuaE9wHkytEN3FeI3WkUzVXI3mtaePndZerVCZV5HzqjaBW7Pr3AiFDZmtAwf6JE22VkyhxayHHXGUMYgOOq5TrkwagNKEdGJMPnUEpaDWBUIdGNXFEcz3n3qw2uTdR3rrSj+xNgcmy6P0NVJ95605B2cPFNjsqQ72k7TMuMQbVlPP3vI269FanrP3W2UfSDpD/0TSVCW2K6VMOWGCpq8yDL/+6pfboL7O0WWg5cWW3tOYSba+TnOdgS8vNNmpu3KKqgkt4IG6GotnE6Nl6pn+Bo/pdf1uzDwe5l8tefM/TPglUNGERFUBF0hLCGr6f8p4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3p7u0rB9px5+kB/wQ9FkOxSjaj8bcHY9ZA5cpXdXyA=;
 b=Cv+2EmHXHV/S/HcSeT1eVcJ0lMr/ZbQ2vffqxkyQw0uhP7WBaREndPHSKrNvV5oJ4oAL/CQApIYussrYVOP5IINJxb5gD/5Z34WUzYwvpkpTIZ7ir32drewO9YgT8VQ31euZxeptJX0ep3PcBhNgHdbF7JS1lF4XRbXFpu93aiieXSdQnSwXJuoZGvQNNgXUumP8BSfVPUPcIjZTxdy0T0aOHD/WJfeGu9eiVCTcgHPjDngw1HTEYKqkm1UpKVg0oUQNzLp2ARqPzTNw/p8imJCnRRsFtrj3q8EMwDCyorMQtCt74dL0opHPXhd2hEpZd4vTvcqJ+rpts3k9NKIu5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3p7u0rB9px5+kB/wQ9FkOxSjaj8bcHY9ZA5cpXdXyA=;
 b=OUhJiAmqStVhVtm0DFswAkDu7mk1PWt4a0hKMX3C6aGRP4hLLBYxDU/c8ytJxP0mrtyEzHf25I3ZlbFGAPpEj7Bsy7bW2LLb+YktDwOESVsdSvTQtijUoHVZAEu0cPyfj79Ar9LdsJGSyW1Sjmi1KrEaUfSiREVtE5DEbahbALRD5v2hXJXAqS8dADnIGWjPmRHGh3jx5yFTAt/9199KWXlTWLOhAWx6uuU8G2Q2F/iHDsswb3IsnIRjhtKu7toUlYLJYTv9GCt8BMEw/6h8SzbqjJhL89NJPqlojzXX0Ne+xgU+zjroPKDEOUl+xXldbA9CC4dnRt3vQHMevDgN8Q==
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851) by DB9P251MB0187.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:2cb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 14:30:23 +0000
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c]) by AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c%8]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 14:30:23 +0000
From: Masi Osmani <mas-i@hotmail.de>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Christian Lamparter <chunkeey@googlemail.com>,
	Masi Osmani <mas-i@hotmail.de>
Subject: [PATCH] mac80211: stop hardware before clearing driver state on reconfig failure
Date: Thu, 12 Mar 2026 15:30:21 +0100
Message-ID:
 <AM7PPF5613FA0B697F9C2D2DC13F462DC029444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::9) To AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851)
X-Microsoft-Original-Message-ID: <20260312143021.33637-1-mas-i@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PPF5613FA0B6:EE_|DB9P251MB0187:EE_
X-MS-Office365-Filtering-Correlation-Id: bcb4086b-b1f5-4f4d-061f-08de8043e574
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|51005399006|19110799012|461199028|23021999003|15080799012|5072599009|5062599005|3430499032|40105399003|3412199025|440099028|12091999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GCfFOe4WYlM5I9zPt46MiCEoU0GztMlJOkmaSkB6+UrzLMGZkke1qfY8p4pY?=
 =?us-ascii?Q?rMgIxDwmQ0rMqnwCgIakykN9KYnSh6SO2g+DVP+DAKVLzVWutzWF58Obe8K2?=
 =?us-ascii?Q?vdf0+gz38itZ+bIcWlIewLieF4imLfCplwOce/wgWkA4hJxdbLfzKp+XtvBT?=
 =?us-ascii?Q?rUUzTyjIvf3f3Ahd6KvR2PON7ZTmSkYGN4zL0Ffno8QGg88LLdzZ3D4FsRf/?=
 =?us-ascii?Q?bRhP992s0xgt91ccUA6zW3IRvAZeSK1fvzWON4jvyi0nkz5IWziqlgnAX7qO?=
 =?us-ascii?Q?B6i5fht+NST0MyFBEua+likNFMTcoCEKidXMfn+jP/S0IZImWn8dxFX5dxTH?=
 =?us-ascii?Q?9R5tLzElLPFCVMZY4bNh6vFSXFGxr8XE5eQNm9aLDugu+bwQMl2eSMGUGcLX?=
 =?us-ascii?Q?CYdF5AjWwCCY7Xier8EmqWj3V7r8YCPO7vi1Gan0wZuS1bS+FgzLd16EtXFd?=
 =?us-ascii?Q?LeOfWh3mStvPp70nFusXqpTf4jxb6X2CPK1ttqrIgxDJebZ5g/Bp1MS1T2F9?=
 =?us-ascii?Q?sRtvuo0dCMKV5dOGzzVkzL8GSUIRPg2a2QcP704vhei1ur7fC7Rwex/t68A5?=
 =?us-ascii?Q?y88S3qpYGrwtvyJk6WD9ux/rnpPcBhxCyIi2RM04Pj78K3RS2nLzqF5lS6Aq?=
 =?us-ascii?Q?Heg0S5ARUSnrpEgctwpheJuFtOGeIYXJLhDL322Y9Gtvbocp+QveF9AGg/0B?=
 =?us-ascii?Q?fQlxEMPEQi+ylXnQ4e+1oi/Z0WJNZtIKATLDZhngzFE7GCsdffTmG24cUIWQ?=
 =?us-ascii?Q?RBablrqDAlC7zVnETLl/+mlDyDpgOnKhusrhQudyWir+KNiXV78aQ+mYquqv?=
 =?us-ascii?Q?pILqvTg2XOLIKy+f2Q8APRk6j71JUMYbl4hYxe2O3hH8/LmMPBJzwyhc18P/?=
 =?us-ascii?Q?3UWmUVT8hsYUmZVYPx/vrzk+PuQon+WEH7jNmucbZ9MAnebWN+vJ+KojVK4j?=
 =?us-ascii?Q?wiXE4+32cRrZcijVyIbX+Vvi7qcei0KIZU6VZZdX4p0JFtgYXdH6pLrAycbn?=
 =?us-ascii?Q?5SCJ?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?COq+4djrp8Q7sIl8+DE/v4+YgCFAMYX0LnbT1g+KQcm1kHsRYsskPOZNZaZt?=
 =?us-ascii?Q?cVbI9VTfRmqynHav5n4bNn1v0Qv10VUvAsbDLEbLwf9lhlMVPIkZ/EGcgShO?=
 =?us-ascii?Q?/07oIZJlVwbXeVSMfyL4EK9aS4PzSFkAiSWk9Rb2pBT/kfOGgwdQ3T8y7EnO?=
 =?us-ascii?Q?eKbhp8gwuYrrZR98j57r10ZjjIiJ8xXLG7+XGyDpIpeuFtT4dLmwj++abi4I?=
 =?us-ascii?Q?JbITDc3UtFSKAmkNdQBcLPcdp/Lta981Ca1IVyvGxJNMpnhecxk20PPnjVHe?=
 =?us-ascii?Q?Nl+fHo/kqDe5vD/2nJDq/5CUOPRLF/E6uwy816Va/NuBj2nBw1h7uGhQxguf?=
 =?us-ascii?Q?Oq/PtNDNNgMvnMymV+t5uL/FcZZPlUxeVbkwQbLXjC7nTc5xlrw/TsvV0nJe?=
 =?us-ascii?Q?M7gSN8GeZ8gSs3MRYehMPPtiITG1GIn13VITeH5yFK0r69r30XdrKB2lSx7w?=
 =?us-ascii?Q?nl7ija8VfHm6dYFlbHmHg9eB8Q/5D2ir2I4hWJAkvrJeROJ7RdAuXWEMj7Kn?=
 =?us-ascii?Q?2A3FEkGugX/26XOYc2WlwRMLnD04N9rG2GSHS6deefVos+uoaEZk6OZH1+65?=
 =?us-ascii?Q?WU5Hmv2g3c/Zd/54HpDBvRivMcrT4eJyKoyCFGhC9thQeAj+KvYOyU8UPSgI?=
 =?us-ascii?Q?SZP/Yli4o4ehT7XQZYkecjuCSHKZNGzQAbblLdg0ePTU+CMxc0tL0Hit906x?=
 =?us-ascii?Q?z069upccNAstP+PcH9FnTeONhDglGJ8UB3caX09IQcfhPoWue+heM8eYoNTQ?=
 =?us-ascii?Q?GJciW9LzxXGXwjU6xz+pD1c/y+Um6CVsAjpHNzRBGONELbUtlZoA9Hkl9XEQ?=
 =?us-ascii?Q?d7SpGVWxzwwNDoZ0Wft7gvNVKKntCttmCPqACeuRRgkpXEAOSSNn1ivAktWQ?=
 =?us-ascii?Q?0l3wgqa0EyIx7/hYvuxbbNaM/iroSg5XTB1E9eu7qBrj111y2tq8k5o0DJdH?=
 =?us-ascii?Q?UWMr9vhCMLFu/cCUXwrPGcs9cDAhlJZJvIHlLmEe1vfJyyTlsj1BjevEYsf/?=
 =?us-ascii?Q?mK99/Gkj6rVXRINXYk84+fg8m0fH6JKj45AOusRHyZR6MfrR2EZ/Gq9YazC4?=
 =?us-ascii?Q?P7H+l+byYMVC6ZVMbfOZkBVkr/QMwKJcn+ufuDi/S9WFNliQXie2St69DnXl?=
 =?us-ascii?Q?y+7vUqwIdP7g8lLi82Ibdkr112jVaHXfe2R+mFRjXCab0qbHuN1TSPmItIcs?=
 =?us-ascii?Q?7FJB/tdR8zenQFYki124LhLlV5wAyx8Jr5RlibsSC6effSJxvh+lCPw62lVh?=
 =?us-ascii?Q?M7HaVlvn9WuMsTP4jFx90YxXB7U9VpBMsVtdZkNDe3L+7/eroa7gyJLTxEN8?=
 =?us-ascii?Q?9hA+dOy4KrshWJ5BxkvuDdSmtvum8jEhhLB70NJpXupa9cClg0rqR9Oq/+aT?=
 =?us-ascii?Q?1yTCMG6UG4HDQxlwA7CCxRldsFRo?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb4086b-b1f5-4f4d-061f-08de8043e574
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:30:23.7799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P251MB0187
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33109-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlemail.com,hotmail.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[hotmail.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mas-i@hotmail.de,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[HOTMAIL.DE:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,HOTMAIL.DE:dkim,hotmail.de:email,AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM:mid]
X-Rspamd-Queue-Id: 0468A273788
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When ieee80211_handle_reconfig_failure() is called after a failed HW
reconfiguration, it clears IEEE80211_SDATA_IN_DRIVER flags on all
interfaces but does not stop the hardware. This creates a race window:
cfg80211_shutdown_all_interfaces() subsequently calls ieee80211_do_stop()
which runs sta_info_flush() to destroy stations, while the driver's RX
path may still be delivering frames that reference station data being
freed.

This race was observed with the carl9170 driver: when firmware
deadlocks during a restart attempt, ieee80211_reconfig() fails
at drv_add_interface(). The subsequent interface teardown triggers
sta_info_destroy_part2() while the USB RX tasklet still calls
ieee80211_rx_napi(), causing a use-after-free kernel panic.

The fix stops the hardware in ieee80211_handle_reconfig_failure() before
clearing IN_DRIVER state, ensuring no driver can deliver RX frames once
the teardown begins. The drv_stop() call is guarded by local->started
since some call sites reach this function after drv_start() has already
failed (where the hardware was never started).

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 net/mac80211/util.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1614,6 +1614,18 @@ static void ieee80211_handle_reconfig_failure(struct ieee80211_local *local)

 	local->resuming = false;
 	local->suspended = false;
+
+	/*
+	 * Stop the hardware before clearing IN_DRIVER state. Without this,
+	 * cfg80211_shutdown_all_interfaces() tears down stations via
+	 * sta_info_flush() while the driver's RX path may still deliver
+	 * frames referencing station data being freed, causing use-after-free.
+	 * Guard with local->started since this function can be reached when
+	 * drv_start() itself failed (hardware never started).
+	 */
+	if (local->started)
+		drv_stop(local, false);
+
 	local->in_reconfig = false;
 	local->reconfig_failure = true;


