Return-Path: <linux-wireless+bounces-33086-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHZ4OaOXsmnENwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33086-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:38:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FB427065C
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEEA83046687
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A958F3BB9E6;
	Thu, 12 Mar 2026 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="AJGOJt1e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013082.outbound.protection.outlook.com [52.103.35.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1833BD627
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773311896; cv=fail; b=b7kmAEas+I56ZDY6ZR8Q2o7FFzrQbaRtXda1Th9vVqAQMMzvhr7kYJ4lXpiYrvwcy+b7ozz71k6Asfnvf7FAqweLN0P88DyQL2nCllJnGxpSqOLuXwckhPEzQ/3qgHm3YSU0ZBPhDGejgsLHvr9NBKZP+wsI+dSHIt8jZhGcFOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773311896; c=relaxed/simple;
	bh=MnL/fDL3QHo3j6Yquv33YwXBA6QhOEfdxvY3eFCgJAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B9ubj3yF/stIcPDLiPGSthmUTR73zPp9b0C81dXcW9AM3A/tvE6LIbx8b5L/z9NnoupdBa56oAlg6EQtXvBxPY/XmWidcQMtLX+Guxa+qOA48TFmXCHJCW/0+HD/6ka7CQiipQbJEu5eMwJ1cqASEpXAmvvIMiWrlqH2p6rPzrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=AJGOJt1e; arc=fail smtp.client-ip=52.103.35.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGQXuyLOsse9St5Bau4J+LJKYz4PNOAY3zfc+bbaUfCryz0jKCOkBl1Gmjc8Y6QDrYhAMdq9s0GHaFpdNjVGSp+xD5D982W3VMvOTLqnyqqaaW8+IiBOR+RDF/ihdUw0nKLA7+7+EV8qmGJsJnn5Lsobq0njBT/cvNLNiEu54WveuofGV4QUfS+scRhh9l+66z+dP+x7r23TntRweGJUtva7SFQ6I0U21aHerT1P2B/WUIyWNiSA+T7Tx1EsKC5A0IGJEKXrtvWxB2k7sZ0JY5pNrSl4Hy02E0lHvKpqm8epMdJEtwAFHoSQVpR8Ih4MxdNXpBBzNq6RKum+s8PUJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0pFy6rMXa9P3qD5PXGeBihh7dxK3WPU5YDKEAkRaKY=;
 b=Tyy+S7Rhr835FkI3x/4WapIh8o+cJd0RxADslPGFAkGPfUpyvvukqrj4ut0zJsaRztHTu39uD0Z7K5Lr+4KDtqrTTaA5XGZUvFHI0DdyYAjgrwPOA9bSX1SRh8/o9Tk0w6Z2fjlxehsMJkD3lovrxGQYLL40qybl8gV18Mv+FGXtLYs3ip2flg24SQy6kgf69ebf0GvjGKqsHTFJyUMBV2nxq/9YvwSr/X1jzbUPogpiYJ6f/ZBJSvwLS+iLVmmzlOXgs8vqFl06ydEPdamxb4/B50k6xwOAtrmxXqXYbhKCCUDh37mSIooqEqPiFZPkQZgAx0agBWf5cGnwPEQGOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0pFy6rMXa9P3qD5PXGeBihh7dxK3WPU5YDKEAkRaKY=;
 b=AJGOJt1eh9JbeSJwBEUHEZIIxy8LZXcSTu08PTAWEf68bXO0lixTWUeVp8i6pIz5JCzpJqNMsEaWrNEWA9s8S7kehvo6JdfYLKff4lEhSN022xQBMYQeipUm2OTMdBmA3uY5B1jN7QhgWxEx54XGKbZHPIPUnQmUxgjglqjMJ52WPPSMii0088lbzxbz/s5uclT9NmWh5rxPBIos3soTc/3YVR5sBok5vz7IKCup3xetw9WA4KVUMzt8nwhAn4QZzinAmniihK2gPboAkaM5KwhMGBVGwWjmKMaOM+wNTJ7bEF61iEZrTFdq+6U0SllRx3sVhl1pjIniN/rB+ldhIg==
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851) by DB9P251MB0259.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:2c0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 10:38:12 +0000
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c]) by AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::1ed:268:bd65:b36c%8]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 10:38:12 +0000
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	Masi Osmani <mas-i@hotmail.de>,
	ath9k-devel@qca.qualcomm.com
Subject: [PATCH 03/10] carl9170: mac80211: document spatial multiplexing power save handler
Date: Thu, 12 Mar 2026 11:37:58 +0100
Message-ID:
 <AM7PPF5613FA0B6B76223A73FFC756A19A99444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773277728.git.mas-i@hotmail.de>
References: <cover.1773277728.git.mas-i@hotmail.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::20) To AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851)
X-Microsoft-Original-Message-ID:
 <f4b62091da0fe8dbf54fa3de7e83a6d1b70ed19d.1773277728.git.mas-i@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PPF5613FA0B6:EE_|DB9P251MB0259:EE_
X-MS-Office365-Filtering-Correlation-Id: e40725bb-0377-4480-9b59-08de802375ca
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|23021999003|15080799012|19110799012|5072599009|461199028|51005399006|440099028|3412199025|11031999003|3430499032|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r7fCVtql1zxGC++/0x1OQyvkvulh+Bd64g78Lwhp71Btg8vxbPpq919Wsl6F?=
 =?us-ascii?Q?ThA6wcMy0+ZA26DxannOBSoOY7xa6r4B97G5D9+z9yy7IzxJOkEpA2qL3/q2?=
 =?us-ascii?Q?LWnfM6DaACFqNz2EzAe+ka2qfH+GYnx7mFEjPfg37VVGq5/k42Bdc2bDvpVH?=
 =?us-ascii?Q?1saRSiIki2563tLELKhKXGYFGFyY6D/lAuPQ720HsM4eUkQtY5+96/DvF3+C?=
 =?us-ascii?Q?yEN1OmaL0jADC7ZvFj8llrNrHRnvjoknrwFezsLfngw7wLRHbw6cgt+J1yoN?=
 =?us-ascii?Q?Z7IbOvDfoDER7UcNbl59QSB3rAqFMkb2eUBpXJ2w8O/K0HrQt3OyWsMmcmdC?=
 =?us-ascii?Q?mCqTyD875X77JbPmmDQO8pHd0a10Jm3bY7u1CC9Z2iAvq2+E0SqSC112QGpJ?=
 =?us-ascii?Q?MHNqejFa/8OgnbK75/vFfFEPKd30SX5YYXQ3xeKHt2V1/6DVIqLWlvcqItOv?=
 =?us-ascii?Q?Wh984karsYiXIjnX7Z80+V6a7MpTiA4XgZELYBDPEgBnCT8mwDskaJ9/Qv1Q?=
 =?us-ascii?Q?8xQRE1i4LA+CzdBlMe3RKe4kQnPGudXxhMY+U2halsDEz3fNq28R+dxLHxVK?=
 =?us-ascii?Q?fpf6B+AXgw7ovGPtbyepE08+aCt8WdK+5K3iKtjn+BMl4bRNF2Rv42fKq0AS?=
 =?us-ascii?Q?tfLKNB41LqJTOvIXS1NUxNejrHvAS0DfAP60gqOVYMQAD3Jf8ylH3ZlwDGAy?=
 =?us-ascii?Q?rorzSprNqlK9xp/N1a53tDYH3Dvigd7SHth/geBFYrsAQ3hTi48HQTkdcn34?=
 =?us-ascii?Q?tQ8g1cFCSwT9hKIsdIYVBJ9SDn3BFgCrZq/DLknwvRlQMnWWNkth3SB2sCeK?=
 =?us-ascii?Q?S3+IyulvJ/kh2SgroD+miruVgBsUVvGQ9YNtbpzRP4UkleES6n6UO6WptpIj?=
 =?us-ascii?Q?xbWVKl71xHeg/HUptiRv2smrBTGHIgJ2+ZdnB4e4/hflb8VusQ2K/YP3PzCM?=
 =?us-ascii?Q?Nd1rNHWEq4v8iuzYG1qH8A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A7/K9NqMJSGM2V+W1QECs48f8melWGe2XrKi1Qp28jZ6S91sh++3PAUYHbJD?=
 =?us-ascii?Q?o29dfvoSHXbvnsAJD+btsncbrRNGOLEibpu+k8hoYi4LCWii3pszVJGRuEUG?=
 =?us-ascii?Q?6/lL7AmR2rGaoOpbmm7hl3m5Vax+NdlbTTtdliF6bR5iSF1Ka7YfhFRsRq3h?=
 =?us-ascii?Q?vRAHWN3teT3tviGN5X/4XMC8drsb/rdBdhWjepwv4sgK/MfJ+6t/oOBJXdYh?=
 =?us-ascii?Q?8Fix2X5plWOKweh/WfAunOfkjSwXuhXC4+dTLOMUuxyMzxwrYHL7MND31vEH?=
 =?us-ascii?Q?t1ws88loo1xyxjDoRJm4+H5JfDvhdRL30YHCoETx5Edj0ePT68In9cTEaDpz?=
 =?us-ascii?Q?K5kEIFmnNkXHw3HWtDXnzN37cB5LiNwlrduRuL9KHqrX040aVlSeuTKMxNlR?=
 =?us-ascii?Q?AP7YjM4LTUl0EGP05q76z6hWupopYANy2DpPca9AaD7gIut75ZQhz33gOv1C?=
 =?us-ascii?Q?FbzUzzYJmTfPp8Voe2p6Ev+9KFzavF4uCNo43Ox8vFEP3a9Iur0jNasoXXjY?=
 =?us-ascii?Q?ANErw9gw8QFT305HBX64HpL+Im5tDY5vuuoBHt4k4Ih3PcOChEDaC5tKatQG?=
 =?us-ascii?Q?psbIOARIU7hgLxY2a9uqCsjxnBf+NRtumuHNd+ZCkeye7W0UH4rLNvc5eQuV?=
 =?us-ascii?Q?zCH0mRPKtQIQOJAw3te1hpnW14V7apKBg6PmZfUR511Yusdbjaxc0XB8Rw+W?=
 =?us-ascii?Q?hLFqP/wFrA94nRNCjIwSCrQTAVRd+yMHilWlqvcYf255coL3ouDqQLmTV5Md?=
 =?us-ascii?Q?x267sG0Oi2BRj+nNwG5f6iPQXuHw1dOsipBUZ3yzcPsJZMwzXOt9TTy+b24O?=
 =?us-ascii?Q?3tmklLzRuU1e4exCDl4k1i0pR65HW29Dlca7z4WUwhhcHfMK9HXhd6Up7rtg?=
 =?us-ascii?Q?yNh4AFdR+F71w3TpPfq48PBxhU2eyzxOcZ8vn0yWb2hPd9cNW2EGGMSiEUGa?=
 =?us-ascii?Q?1F5g4ct+UMAym2fLoeok6+WuVtupSx12t/03SwQVHC/TKddXhb0V3sro2Eox?=
 =?us-ascii?Q?5aWeyosgn3vByOyDXjxw9camqkQpQLsTlnPd406ZhsuO0IL0g0Fh057WoD2k?=
 =?us-ascii?Q?nLbCHxDKCF/JIB/Vt6SAlumpqzTOV3b7xpvx/p4M9nKe9fzUGI/r7JX7BOVB?=
 =?us-ascii?Q?3B2YadlJM8N+ILtrSXu8kPp5ddxpm1ozqYeUQVQaoRL+01dc4ZojX0qnw5Pm?=
 =?us-ascii?Q?85/gsQ4YAd6XLsMt0aC+EmKnRDOqEn3HFinUZJEHGAOu8fOaMIy+WqkirIQN?=
 =?us-ascii?Q?Dt1lbQ3Kv+h7v6e1uuhBGnWSJKldg5LaZr468ejlb5vMVmc7sTdDQzR7zciW?=
 =?us-ascii?Q?fFQkDzKJkKmdc9PAYrUY9VdJtZ7Qk0XlCi0jAOqSrHm/niTa7QvhAqxPiQcW?=
 =?us-ascii?Q?iMULa4UfqdGEUDqkgt+loxPQ5upB?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e40725bb-0377-4480-9b59-08de802375ca
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:38:12.3660
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
	TAGGED_FROM(0.00)[bounces-33086-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[HOTMAIL.DE:dkim,hotmail.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79FB427065C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace the bare TODO comment in the SMPS configuration handler
with documentation explaining why the driver accepts but does not
act on SMPS mode changes.

The AR9170 advertises SM_PS disabled (both chains always active)
in its HT capabilities.  While mac80211 may still send SMPS
configuration requests, implementing static or dynamic SMPS would
require firmware support for per-chain enable/disable that the
AR9170 firmware (v1.9.9) does not provide.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 drivers/net/wireless/ath/carl9170/main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index 6324b38..d75688c 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -910,7 +910,13 @@ static int carl9170_op_config(struct ieee80211_hw *hw, int radio_idx, u32 change
 	}
 
 	if (changed & IEEE80211_CONF_CHANGE_SMPS) {
-		/* TODO */
+		/*
+		 * We advertise SM_PS disabled (all chains active).
+		 * mac80211 may still request mode changes, which we
+		 * accept but only support OFF (both chains active).
+		 * Static/dynamic SMPS would require firmware support
+		 * for chain control that the AR9170 does not provide.
+		 */
 		err = 0;
 	}
 
-- 
2.51.0


