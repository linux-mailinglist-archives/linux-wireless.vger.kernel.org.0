Return-Path: <linux-wireless+bounces-33087-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DupKqaXsmnENwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33087-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:38:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AE0270663
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87634300C6F9
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4AE3876DA;
	Thu, 12 Mar 2026 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="nX9bdIVz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013082.outbound.protection.outlook.com [52.103.35.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D861B3BC681
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773311898; cv=fail; b=PElJHs54sSU6MAtzqt79JT40TJd//8XtdKBRawBBG10RRZN2o4unTvxptQdq/KqKy5HHHSDjWn+l9lBtGWpUPNm2LAzATcalf0VbKXJyJV0npzGAfSuZsrzZvhKgGiKPrGl+a87Sq8ASbFRatMi5jUPAPu+5I6LGl/bGY/YVrQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773311898; c=relaxed/simple;
	bh=+8yR9Wcd97X8Yr6F5yhFwRLPFSkXfx57ElkFaiijFxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sHWFKVUVM91FK04Uc7J2ZEhs2L9x70qaZA6Aom4iMU847N4GxZmQS5Yz+iv3QpGGRUzfx4d82dXXSxAOl12AJxA2uDJNt0Ecw6+c7bq/P0eeMnCbkvGOUPOCBznxUHlUBSIB4D44Uxz1jnh8O+Xa6vQjvZWTVnCJ/pirScHOzwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=nX9bdIVz; arc=fail smtp.client-ip=52.103.35.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gy5/ShTI2shWynoSzhKlfPhfiYtRva5oxWxOrRSgC7obb8d0h+k5/vmaFPNbGf1admDNoetOeNaJpH/qVA9hfFMAehKHZPJUpYLsfVGEO845PVhzduynTEp0Ryvlb0mJyHrC718ABzYCD5QpNur9j+AlK9jCKezct1ULbbKFEE12slObBFBZSTYYYy+iqS1d+3ljkLS6uoOg4URXT7ltWPvlcbQQpBojK2o5CBWPijj2LN96h0qNzm6za+ICNCcy6DrfzZ5KzSvLkKrsc6NJ6otb0Kfv+vdKF+01w89myp1LrK4P466stCNVV9136kF8lyHBnsu/aBgkCy7vqVXvcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jwgf21Ny07C4X4gf7xriJ/oDLC2h6zidm7pYnX5S20w=;
 b=X+cYlsPUmuA0bOye+KwFhtBYlBPoi+8GNoNDlqnsXaIxptKReOcAIFagpjXcnrA9tkEbVOtulTlBkgld7AWyk/q1GKdSq0n40BdfHNrg8rD83pb4sqTEXrWwwv51KCh1+30SHNytU6QpFG2wPfzJBIzIo6+o1b0LQ9ceuyuhJXcj/3RrOL5qqxI8Br99zcXTA8SQQR4UTTAfcq2Q10xrE+BsaeiBphpfA4zdYimcZhNia5KkQYwHLrfgaQ11HrsMMh1lUEpqwLZwIWBjQxqGzPu1im3TUFYAdzVeCj1JEWUWpw0ZruYR88Y9y47IK5PSSG68RLWvWjN0M4oitpJgyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jwgf21Ny07C4X4gf7xriJ/oDLC2h6zidm7pYnX5S20w=;
 b=nX9bdIVz+L+rlkOvqXr/unPZgKqZ2xIwTV5vFWWJ3TxwN+NdXILwYjT/UN3mDYsLZqR0syA6Yn7k/P5n6H2EKHf20RGgCqOhjX/bMZejuNnTosZobtaE2OwY/5hCerFtCLzYhfb0igDhuH0vHrlybLAxB0bk71rtTfIWkO6ZW0keVOzeSA30F52PKUV0HLmQtipIB3Av+vxx+gKebXQ47Mq7pT16bQVorvaTV+oxoTVRsIXPQ3bHJebVU/57ChzUezUVEg6G5aVS5o6iKRQpwyVJrfZ2U8TLDR3FCiLlikJSWtwNnwU175bF269oLZUaVwvvJLgQ846AKDFTIeJfuw==
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851) by DB9P251MB0259.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:2c0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 10:38:14 +0000
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c]) by AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c%8]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 10:38:14 +0000
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	Masi Osmani <mas-i@hotmail.de>,
	ath9k-devel@qca.qualcomm.com
Subject: [PATCH 04/10] carl9170: rx: wire up dropped frame counter
Date: Thu, 12 Mar 2026 11:37:59 +0100
Message-ID:
 <AM7PPF5613FA0B6AC8119FB64246940D3899444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773277728.git.mas-i@hotmail.de>
References: <cover.1773277728.git.mas-i@hotmail.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851)
X-Microsoft-Original-Message-ID:
 <3ac0fdd8ce1e5187189076d71dae35bccf8feac7.1773277728.git.mas-i@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PPF5613FA0B6:EE_|DB9P251MB0259:EE_
X-MS-Office365-Filtering-Correlation-Id: 844d6d5f-f422-4067-0c6b-08de802376ce
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|23021999003|15080799012|19110799012|5072599009|461199028|51005399006|440099028|3412199025|3430499032|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	jd9K9gZTuevxPOtiiI6v8M1Jols6Ptwub0bdtnxUp3qEKopodI9fy0hRKTP+ERSqnJtC/Fb8wlErOV4vjpQUQQ+ZH8bPE9Gcxrey0zsa4iivIULrjQaqEQ4LRrvKk7EkKA+0tP5eKRwB+lMRKraepyDHcdW5ib8ACjCCv+k/qMiezFDhfnlE6fK3RjU+Uym+5jBPn52ATDZS7SB7JU/QTrBgzeIAaLmSvCKmG0/ovIwGzDo0T8xVAZyrFF2ejmZDum7TrNwx5o/Fgw5fHHLsPlSXOJ0UdOm7QYWp4vhTbHSmEO5Hppbx/P+EumSSPsHt7cIQyX0gfHkDC46+8RNvzI2qC8T1WPWTE+9ndDS82lR1tjc0BBWU+7+iOhI3u28FcZOcJaEOhi09Qgu3E12QlQZ3mdum6Bf/qi1bBInPYs74UbgfI4o18+7NW7z54253RJoInyxFhdGspDfaD7b0Xy3DEijsuFKbeaSiiu1PXELHYrq36KUGcNCf+GaKDWEWPPpVPRr44lCC2aLDwGIErgEsaj8j5d5TaieCPRPf7WpROwoTQQ1CPuKj4l017xGmg/16M6PhFLJS0TSxclJu/v93NJRbpFTlgStuUttA4dvQAG+qqsdozUyUT6X0BE9o+uL37NialCrgpQmcyR7jfnpEnjDPyALAIRzk+tgcLZrmy3Lo70iOow+Ka5VC1f/MkOA+9hZm2RJxLQmhsgqFQTD/A++3GV9F0tKPV5tg5Q0Pzdv0lobBk+7lHUY0yBm+Ur+Yc7aLPP11SOLXvSFrM3Ld9UsJzbG/MDX4JVs5fSJC6CeKJOWSS3XEt34v22EHGrXFwW2A7HlPqyvQHZ25pyaUbe9iJXNt9N/kSGQiyUUZscFDXGXbdni+Eid1qIlVQaoi4u9TVo09xdFpJOujmAG/126DXvlbunv6pzstvL7jsfq65PnNx0lcG8lOBt46
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i5f1mbmlmZhU/5t9UA5mkfFDkOsrrCizSXyWxLXAg7OTTJ6inv77wl36qNnR?=
 =?us-ascii?Q?09jo+7yPTYBccoXM3/i4Bzr2eOaK+UC8cAIw26/oJJPzOr4HgubQK5zOK8ra?=
 =?us-ascii?Q?Gsh2oyr0DivkYi+2L5IeuVxuCSS1IRFL2yBZ49jmv0UzOwzZbmbw7mB8JO6y?=
 =?us-ascii?Q?1ua3b7bsOOWbXvjpYcJSsAZ1BPP09g7fgpu96w/7RJBew3iL0KKf43flRo/W?=
 =?us-ascii?Q?4WfEO36uM1kdXV5RNTNxG9iHU7NXyBmFaM78tlBmfLPOWfobJik9X6sVcPEM?=
 =?us-ascii?Q?H8MWdobFCiffJARRHhGxGWX2WzLwYl1lRVPQO+G4C2RqmNIKRnHqbcE6az2W?=
 =?us-ascii?Q?J09LZxgyOnS91xQG+TcB7IMhXpJzQuP+0jGMlDH52Y2bmLCN4C3UwIOLG7E2?=
 =?us-ascii?Q?tJE/+0fOlDg4jRp5UktH70QXWVJQFuACie+A15sk6eshhzq5KVXSe5MPIgc2?=
 =?us-ascii?Q?VxCtIBsi9aWQNriMBSwIrQeMxE84RHXlsrjH3sOa5CeipYLfgfC0PuqJXlJe?=
 =?us-ascii?Q?ZVNFaDC0cXGbjexZCP9elZWqew3wrg2egAoRPTN0TbtDzXXzikMkHBcklqXL?=
 =?us-ascii?Q?TTrPd6R9+ESVK9CmriXC4997rO7PM1+YjNWXAgweTMNlXoBjvTRLaxcgkOt/?=
 =?us-ascii?Q?qpbUOvPi5ksTWYefGsJJIZXXEi0UQr9B9bGEUH/zfQgIJDaiQ2oiAyAYOJWI?=
 =?us-ascii?Q?2yil4an+XJXIvhCU3p3BVKyV4oSt2Yn3j8jK2glBPOK5URGtobUwY2arnDhg?=
 =?us-ascii?Q?6iQntgSVJkkwQQ853hX93CEQKVbKTpuU2Ti25CjP6CgUsrnz2vqxfB/rykpD?=
 =?us-ascii?Q?iwMe491AsioXWdYaoUOe0wLUBsiSUEY9BZE5yY7wJTbS+fIRre2iLNmX5yUo?=
 =?us-ascii?Q?FhckVeLUW9k9TAo3JGjy2M3CpAaRtth4/fy544XOzIpNhsaL6lb/hAoiAdJf?=
 =?us-ascii?Q?8S2Hk843FG2wXO4xMgMsKYhp+EU2H21oYiBnFYUuKU1GU/mSIk1Y34+RoCcC?=
 =?us-ascii?Q?ASJ+g3eoXiDVo33I9GyQy0DU5Qgij9n1LfkrD632VxIlG55xvbq9XHky+EK1?=
 =?us-ascii?Q?xELQY0M+sv55kFV640hJWIUS35+Yjx/LjS7ox25ul8EY9wZPKUDMRyrqUGMW?=
 =?us-ascii?Q?cQZ2Fn/WGAMiiYm43Qo5o9Q5UkPCp+566YsqbjyKU2W94O7oO9MN/noZqln4?=
 =?us-ascii?Q?j9nOkm1llU5n+kZKgOwPmybM6hsRKNidXcjz+owXpqEH8IBvpZEMbVDabfzv?=
 =?us-ascii?Q?XMtjMszOkC5ZczBLvtsFccsbktn6vRB5K4DamUq45iM4uMZh0dX5xxw8GoOf?=
 =?us-ascii?Q?0/H+3ip6G313lsoMkinNp1rbfYBCrKuuJem8VhsRwtzyTftqtDBT2XRPUaKp?=
 =?us-ascii?Q?s2CXKfkWdABBYUWPAbDMPN687rCt?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 844d6d5f-f422-4067-0c6b-08de802376ce
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:38:14.0791
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33087-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[hotmail.de:email,HOTMAIL.DE:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00AE0270663
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Increment ar->rx_dropped when frames with unrecognized error
codes are dropped in carl9170_rx_mac_status().  The counter
was already defined in the ar9170 struct and exported via
debugfs, but the actual increment was missing -- only a TODO
comment was in place.

This provides visibility into receive-path frame drops through
the existing debugfs interface.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 drivers/net/wireless/ath/carl9170/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index 6833430..c664014 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -340,7 +340,7 @@ static int carl9170_rx_mac_status(struct ar9170 *ar,
 
 	/* drop any other error frames */
 	if (unlikely(error)) {
-		/* TODO: update netdevice's RX dropped/errors statistics */
+		ar->rx_dropped++;
 
 		if (net_ratelimit())
 			wiphy_dbg(ar->hw->wiphy, "received frame with "
-- 
2.51.0


