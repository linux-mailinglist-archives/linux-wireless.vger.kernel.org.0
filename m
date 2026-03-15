Return-Path: <linux-wireless+bounces-33260-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8B51MCU5t2nVOAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33260-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 23:56:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6731B292EAD
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 23:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27F613012C42
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 22:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6874326FD9B;
	Sun, 15 Mar 2026 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="DXSwQto4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013009.outbound.protection.outlook.com [52.103.33.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DF92512C8
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773615395; cv=fail; b=f/J17X74MJtNVK8q8l4uTc4O6dGIvZPaJgrrwQmulc3QG6DwIJYvIel/7pdRNkNqy2VzAL7InhOmmROnTobo8R7cWbsvRkRhZEinO/HmnqLrGpCuJj2MpKNYCPwvczVT0WTJJAyCVwRv4V7UhifW4XSDNk0Y2BxCx6FSLHcG+XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773615395; c=relaxed/simple;
	bh=fi1iXKYkvgiLVEEZqDJXwj0h0jdXBfC/DgoWzDaSqdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JxDEd6noVexgkKB85gs+yJNBFc7x+S46u7AK8GvtcXJ9DXe0ztKZj9ozogttum+sl5Ip0ar2K6Q3HzpW6/FehBLKyKp7+nxrHMBI9zjTqVEMSkoDinq6oxO233G6zhg1Myt+b05pIdve1oefCKY9gzo34fKEhZ79lkZDdLI+AL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=DXSwQto4; arc=fail smtp.client-ip=52.103.33.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aripveIue7EJV1ABlF8Y/EZLeyjypGy7UGHUjyTKX6FVMJZfdWyrhCvY+1nV02RzEN++xnvMTxcRaCa0AOf51xWVdcmRY7ginn9unEX1ck1efYN36deVAKJHuab3+ZIUS4eLScHyoF1z5TobLSif8EqlKfOlsSrOp4rFO6YsROQKcCQozWI/zDjc8honFsfYYdCau2S3nKt0ms3We6VyEqCw1p5HLCRxqUI8afKQAuBWjCFwIISyrxOX6OHoo6XI+ROwjA/PjS0RDkPuA0otrApb0oIZdgiaHjKF/d4gk9akqfi49AUFFWrxt5bUK/y91pasWGMJvgiJf2WU+HldKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlFsugOSstT2JlFbTWRkHKm31kIFbiWoszI1k7BVfpg=;
 b=JZ4gjJn47M595Ot1a+xegmQfkXTHOqYD95isZlr8SxpBcXWDOTqp5q8z3XLrhEQ9XlOskVYVjXt8+zpLcweJGHwsf6VKyoI2w9HY8y1X+Imem0GgpH6AIUNS2HNhA/0mta0QeLSaB+GkpOXsiXAy4Rww9tg0HtTGjXLG5a5QmMWLba58fh+ylaSISr/VXAPErblPobmPFJARwM1lswjnSlzGD//cKx2ccNxl8NdaNzMQT4a2Mf/8mTDWpkoMvUs0iUhQTyx4G1mWoeoczaPikXevoVOS71NC5/qQ1Rb76u91T4F4OlMtXmVLbCrSn/hYdLMYWIdur3jrzwI7l2cU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlFsugOSstT2JlFbTWRkHKm31kIFbiWoszI1k7BVfpg=;
 b=DXSwQto4JP1atly54lxzFrhKEbAPs6FR7A67JzvhPyAetDDBSR09NQ5VgKTs6dHPMr2PmeJgB7I1RXB5dso+9Hs+eWXgf170izzssD8j+fIKC22va2VmIBEYtue8R/E8HibKUVO/LJpXEqnBkpen362kkwUA2OgzSixB+m+6qn2fRqVcNSgHRS6n2XwgCRDRvtPaRYV1QDXbVzuTmc9qbeZ0tgJo/aRIsqjfzWfsA3mF1zaI484pfX+8B5Z2sAfzgpMurWNkN69v50PPkpsQQszpUSLIk25N16BFVp/ye3XTV1Ympr10yVklbc0c2VeGFzc1bWqmsK50SiyLUzH8TQ==
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851) by AM9P251MB0070.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:41b::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Sun, 15 Mar
 2026 22:56:32 +0000
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::596d:6ad8:b60c:c9eb]) by AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::596d:6ad8:b60c:c9eb%4]) with mapi id 15.20.9700.020; Sun, 15 Mar 2026
 22:56:32 +0000
From: Masi Osmani <mas-i@hotmail.de>
To: chunkeey@googlemail.com
Cc: linux-wireless@vger.kernel.org,
	Masi Osmani <mas-i@hotmail.de>
Subject: [PATCH 12/12] carl9170: rx: handle zeroed PLCP CCK rate as corrupted frame
Date: Sun, 15 Mar 2026 23:56:09 +0100
Message-ID:
 <AM7PPF5613FA0B686F41D14D2742825BE219443A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260315225609.61791-1-mas-i@hotmail.de>
References: <20260315225609.61791-1-mas-i@hotmail.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::15) To AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851)
X-Microsoft-Original-Message-ID: <20260315225609.61791-2-mas-i@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PPF5613FA0B6:EE_|AM9P251MB0070:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff47346-b7a1-49ad-b252-08de82e6195d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|23021999003|8060799015|19110799012|15080799012|461199028|5072599009|51005399006|3412199025|440099028|3430499032|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?04kfG3uPwpMOf1PUEEG8TT8znzT/GAu+AUk74mKeQpX3vtg1saW/A+fm2rSA?=
 =?us-ascii?Q?/LJqnf8z7N5QmStJL5tdICQmtUEjHw94su4yZXQWYPXHGJBQSG1RHURsaokf?=
 =?us-ascii?Q?mHt623+MYxWazl6xj5SAlsgifruDsyRwKrJhZLnvbs7tJ3Hf27Ezu/28lKi2?=
 =?us-ascii?Q?fSYJvRG/K8l3RsLrGpj/pHDZ8iptusiywpr8qlxNVHGfhdbVMrxPMp3mDX3O?=
 =?us-ascii?Q?LH8EkVRJYNzn4sYxbFKD6KexMMzGS9rHgaa2LeJX7ekFqJu4RUpYKyB1BNYq?=
 =?us-ascii?Q?d8Cz5kYISMcYJILrOHEReKzD3Vbs7OTWeCDGQZNPRuh+oRUk6FhU2C5ECA9h?=
 =?us-ascii?Q?jIirhh9/pQ3ju5F3Q1sS8xnA6TQBt05oh59R5GcKhaJUid0b8O2rRYF+SS8F?=
 =?us-ascii?Q?WYpbPHECsQ1dwUt4iJ0SMCxLnedFWWLh1vtVjRsgrB1cMSfZC1vDssJRT8+H?=
 =?us-ascii?Q?oJOGV4L9srE8tEqZ848BtheCS1zRfgEMrM3JJOyQ98aNjrdItIja07kJCYW+?=
 =?us-ascii?Q?LquiLDkinF9itIZONf44h72CKwLAX3lCZP1sMM7Eodqx7liotaYSas4aYkSx?=
 =?us-ascii?Q?cSCVzvTxAfP6YmtSegF8h+6tqjz382PLwuaXVfWNLnQvkjFM1sGqp7XWG52v?=
 =?us-ascii?Q?qU7EamWJE7NsT2CGduzEz3gycMEk/KpRDfA7N4jPusvgFFep5PRIuyzCSvRr?=
 =?us-ascii?Q?KHKkV/SPz0zODvnlTUXFM6hc/1n1poEdXc4tvKtC7LXkHwXmo8AohCDnmXyp?=
 =?us-ascii?Q?sHddQZHVqfJVvoLBkwRbZE54+PZq1YRkZwdCJ2Z0i35YV1307GORbU5WFIru?=
 =?us-ascii?Q?7q3FeAS/Ff9hMl6vNANsjjMEBmQy4q2T9JNPgKfy7aRhr84Xi8SfJW4+baON?=
 =?us-ascii?Q?QNTYqK0HQZypnwCQUGQgwyrcTq1OySs9Afq28glH0Zyj8IvkssLORqZU+5p5?=
 =?us-ascii?Q?gCDaRhIX7KlaJ4QqBeRchw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vwEJNFBDfgHUVoefeK34DS7kzXvEQP9fja7mlXjOb1i5eYlxa8W++U+2S0mi?=
 =?us-ascii?Q?1ooSJoSoRwfqid0IJ1kWJue2qhO0Gqk7oL9vY7x7PLqM4qFatFthu2n3+28Z?=
 =?us-ascii?Q?6gUvzrnH55X6+N2b7j7s6gXF4w+kw7SiliMgVgLb4cMtVAXfzgx7bU3idStQ?=
 =?us-ascii?Q?ircMDQ9EkBkQvcCzdNp/lWgIRZDjGydrnfwFj2qSKWxnE98MK8IrGuTpqeay?=
 =?us-ascii?Q?xomL6om/7f800NFJAgP6JhxNRh7Y3bGeA+1iiDvm2dIoTsGrmqLopjNokBLG?=
 =?us-ascii?Q?ZSlFTMloZDY0Re9+2bosGsp/+SatK05lrFz7zG2/m+an1mnIddL92DD/nbOc?=
 =?us-ascii?Q?R6d9sFLTBbVDLLuzy8EfUb45MOAgcVpJE5ZgZk2wQ1NVRLwGlhG29bT9YNI8?=
 =?us-ascii?Q?/D0HdF6JEyORC6TUiy1dRzdTw2pXD3GdMiDLsstkJqcJ0ZirPG1hb519RHN3?=
 =?us-ascii?Q?cn4O7NsMXSFLlDWoGexE93IeiLtTDT0Pg+dGniiAv37qFXUgprz0suaJRPZx?=
 =?us-ascii?Q?btVupb4zdMytKmJLbhHKJmuDE9ytQuo0TnEFqkbtUhEir9KfJwnQx1wOssXk?=
 =?us-ascii?Q?C4hdvwE4gT1U2PfxN4Ub73m+R5yTc6p00adOYWIVH/KzLjS2HF0eKwehqvZH?=
 =?us-ascii?Q?RbUHiKFf6IzmxJn/pthv+zW5NvcC6aGIdBQfxuTTuCrBkMuGzry2N2lLcTNU?=
 =?us-ascii?Q?E/gjFHPOzP7OcDoo6Mm9kYGnXSfyjPx+KXuZrhChnjPDi/oBqOLlgqzljzn1?=
 =?us-ascii?Q?sqjvCI73RTNzG/lylJcoeCYnKO3p/3cNOz8Uoc99fllkrFJat+65Bo3bRy87?=
 =?us-ascii?Q?xNTrUmsMWLeFu7HdVmQ7ddhabe/xIYy8Qa/jDLWOM7fadX36QnMGyj8+qYMU?=
 =?us-ascii?Q?PYg/pWxRl1aJHMNLxg6ZkYzQzxonY2kh1+v6/5iYDY+kw/p5OBn64si4D8sp?=
 =?us-ascii?Q?XU36++7CiOTDLq6AGp7j21nnWRmKu/wmLwuzVaPKjStmmQuFm9Si5I6gHhP6?=
 =?us-ascii?Q?uMG5ZsMdbdbx814aeuEvcEam59AJIOBHNN8QKZHnVYeJsGjHeFbDvtngzLXA?=
 =?us-ascii?Q?74ELoA3Qwd88utoBdoVK39oR382S99qLr1rQiZGn2m57pYyA93hakxzufVlK?=
 =?us-ascii?Q?4rC2plLqHdlywbXSxJEULf7ZnRuX1y/wkUo7yuD0ofAA9+dGRKbNdN9yLYcc?=
 =?us-ascii?Q?zgRQPazU/Ar+TC2uiIqEg2NpokfWH1hVzZIlZosvfNZmlqSrHJAZxmukyuUs?=
 =?us-ascii?Q?bXC3msClg/E+4yjJ0pKV6yhlVkQv20BXzipb32q8wi+IVVF+X3EUY4j4pbnw?=
 =?us-ascii?Q?xg9pT0+AIBom34IycaSbvzpBNLwYCQu55VhMM4IXnSinj8UvWmOD8K0ue9Ej?=
 =?us-ascii?Q?5+h3lfKZL0o6+HJzKy3sGkYm/AmB?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff47346-b7a1-49ad-b252-08de82e6195d
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 22:56:31.8955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P251MB0070
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33260-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[HOTMAIL.DE:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hotmail.de:email]
X-Rspamd-Queue-Id: 6731B292EAD
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
 

