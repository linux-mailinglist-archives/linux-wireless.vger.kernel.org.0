Return-Path: <linux-wireless+bounces-20376-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50483A60DA5
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 10:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A7918901E3
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 09:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B3F1F03CB;
	Fri, 14 Mar 2025 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LGc0ZXr8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1E41EE00E;
	Fri, 14 Mar 2025 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945437; cv=fail; b=chgz3CjkPIGM9AeE4aO/LuDNUOnhbVyXNYvT60e1nLJW+tHF2sAzBW8Db+HQCium58lW8/EbXaVar5VBwZZ69o/ZDVoSCqSC05X9V+LacFzSHjVSKkW4wfUtrJ6R65tbIXJu1jwIUllMD6WYdneuaSZhjxZ/5rW65zp0fVIcGuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945437; c=relaxed/simple;
	bh=/LM8I7FI3fznYiG3XCAcHcIZVnwPIgjPnW+WTfYfLgg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tskQTgBpwjEU0uTBjAK80HaCtQvmtWjqpMT9Pw7YS5zejJt9PyKq/Pfa/BE39K4DV52cHZdSGlEIBNfRRothuaDNVRqqkgNnmoX5Igv5DKXnBprzUbNt9zRS57LaiaGlS76Bgp2bIy3Fmv8o1bTFqO7Qd+0Jt4Qht2bUttuLRV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LGc0ZXr8; arc=fail smtp.client-ip=40.107.20.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfXOInkrruSajJ8wrBfp5GVH8Xi4dmpFqBA5R1/JXsOKerQAYwENzsSeMmpAujCxP6/E5vax88iUzUevaXTE3xQbUW9Xd1hwZpm39fetyDp3oLqTRLqbbgsZdCY/8Rly5z8JRJPJRLWAWsyqQ5f9l/lh9UDbdVyVE7OdsR16e5M58O1GQ1vf9cov0JG2yGn+t/JK3COiMBwukfpGb4c2a2qQxOTWsMVAoj5zuStj0Y2TC8HwGDX+hqmu5k4ntfdXP62fgCXBM/hGCCINNkY/qX8ytXpxD2roZVggB+TYhTDmrOst8Ddts7VQHIvL5cqM7ryk2aP/0I9CAtQ+lc/U7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ed8nzCN0+4NeDZiWKyyRFiTTTl9t81mTdfBUy3OeHu4=;
 b=c/Wusd617rLLKW8p1Z5QlV/zqAiBppqeYGNMyhcz5IaHNEzM8LuP6MpFqdhS6xjCt5KlyxKY9DtYIN9omnpHElHnNGB1dd5ob0WVNPFU/iab0S3v6FZF7Wt59ojgY8gbb0f14URdInjMf0OYUWlm2S8OPVMq5NeGXIWkb4FBjaww9YG3DsNyRxfhD8mcPo0zdDARLP4lhvKxTTtI19qbpWgyfEuHr93pT3bJmXyvUXLxsKvf7FYUEMD2Eqh7PSi+5KiVsd5E1a4qdav8l1f4Kk65KerblSsVD8cs5Y0NgSc4jteKsbpIRMI57RJOXSGcRSWhW2hQTwfCI11U0Eq/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ed8nzCN0+4NeDZiWKyyRFiTTTl9t81mTdfBUy3OeHu4=;
 b=LGc0ZXr8Z0ferA+9Z2h0uY+Dg1Mm0lU8JXeJth2XpsehaZAqus3tDb6DSnbcVetlzFu13x/3AT+PzyvcJIZXiX2xehYk+0vBWBmqzCZTZ8BfdHgncuMwFK+eBG2Uyv2OOz2Duir9QZ8V7f4Bbmq/EpoccQuLLJYz3+G72qDQoCm5J+CeUjlrj/pCXQcD/EYruof07bSUk3POD7jzv2XUhid8gTbenk6+4i9ebr/EYwMhwmvnarZRYRs+ZVYEkZ4fx6RxwCwGCKyfTzduyPJ+h9EbSgjGEmJ3vnLmlKgn0RwGomBlqXYPWDHIMQe+9LZ31XhzBVomPzDxF7ZTD50wlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by DU4PR04MB10813.eurprd04.prod.outlook.com (2603:10a6:10:586::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 09:43:52 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%7]) with mapi id 15.20.8534.025; Fri, 14 Mar 2025
 09:43:52 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v3] wifi: mwifiex: Fix HT40 bandwidth issue.
Date: Fri, 14 Mar 2025 17:42:38 +0800
Message-Id: <20250314094238.2097341-1-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::13) To PAWPR04MB9910.eurprd04.prod.outlook.com
 (2603:10a6:102:380::7)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR04MB9910:EE_|DU4PR04MB10813:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a287dc-46bb-459f-9ce8-08dd62dcba87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+P92icSf7h+FQnPiELa76344agShXeT6aLl9aaSl49oyYN6nVzEr55ynjRVx?=
 =?us-ascii?Q?D1qDX5IzyXktN+ukzGNO+bMEYemYkVqMUpzYEqW9XO6Mo/17VFEJ4TwvZKkE?=
 =?us-ascii?Q?s3fosGQx5rViUBOS0QyNTzRCkkKdllUwGnP4GH1iGLTpyzfmH/3rDnAQ4CqR?=
 =?us-ascii?Q?H/YWBL7EAV7vCfuZv6BWfQ0fIzHIymgy//HLIZgoMDwlzIYUlqi/Hi8mPxnr?=
 =?us-ascii?Q?4cBhhN4zquPWRxhiwtF6lf/4kXm9OwOyZjNfI1cSNbmYO57d5U9SuD0fP4bH?=
 =?us-ascii?Q?fqVhYoSTggS1ZEm9/w+EARbI/oDhuoPu+n8t6UY+xhoWvBedX6PurbdTlNOC?=
 =?us-ascii?Q?imo4i8TaC96SeRfguwjXIlaEyJMK/V9QxbFn5GPp2JQWwzVdfe8FD0wRnoha?=
 =?us-ascii?Q?yBEliiRCo6gcKVLLFOM8fT+V694bxSZ7FWW7QI8Tw+a1Nm0gmDYZTF7X6+6w?=
 =?us-ascii?Q?ygUouUtf/YKchgYXWozWTxE137/tbviTiH3m7bbqvViLBIXVDt30wJ7AZsJC?=
 =?us-ascii?Q?NKx43mPwKv2Xrfpwn1VSENOc3Dizt4mjuw6tc2El7iVdgU0R3ajAWHLpz57a?=
 =?us-ascii?Q?G4lqnl8y+sNDMBwKmjb+lwC/2eXrt4bvKw/l236rR8A9xAFlqz9mLVjcbQ46?=
 =?us-ascii?Q?o99s6jRNSnWiQ0Rdby0SLAi1yxty7spiz1B0iFhtqFWu052H3r+uWYo+pv50?=
 =?us-ascii?Q?5eKSkN206gDYItRziPluR0cQCtO12gkDH3PYyxLeu7ntvj2tOVw7hRXmLTeR?=
 =?us-ascii?Q?0DGqAiK+UaM3+HRV0bIQYpaHdD4vDgTqDKGY3P55W7qwv63e1IbcY7shwVUi?=
 =?us-ascii?Q?RvqfppLGeXTNLPU0FyenI6Xy15yV4ul1j5y8+rbnBW7A+v4Qguy2eYWDdtjr?=
 =?us-ascii?Q?WRLplUqumQL042CJBNQHFuzzdGfep+Tu5dgy9RzwlDTpL0pByp7dU4FkkqBa?=
 =?us-ascii?Q?0nNUiJvuXzyvbRQZu+zFup+vPSX8Xr7R9L8/KNW0Awqhmu7M88jQJ0/d0Wch?=
 =?us-ascii?Q?QYNX3P02mBQ3eJdhshSA65p/xDzCyLlMYI8gkgl44yiceKTymKFTqbXNiSS4?=
 =?us-ascii?Q?eewEsymVFaSgWv9xAZOVFIri8enuuxEybNVdzZ1hL3aHupLUtGeiE2y0MoxU?=
 =?us-ascii?Q?wTbA6JhUowc5xp9UtGgKAyy0geE9UljvCwZzDBuSVwY1cYcsrapSLMpzy4HV?=
 =?us-ascii?Q?tmPAVUhXY5H0toS8laFnj+uWPFGJO+oakwd+6j/LhY7GzFp23JRbn6B5duMa?=
 =?us-ascii?Q?lIDeX9FsVd7bFAY4SqMyonDBQasU/R2WEdmie4hcCa2SRHXqjPWeGgR7CN1+?=
 =?us-ascii?Q?7fB5ASm0hTbr122gMJzC9NRz/Qu1/Pak9vC5RTKcX1xvEuOIZPRRL/ZGf/Xu?=
 =?us-ascii?Q?a7IZlm4LjxI59NQ+aW1ZRcdecz+ugYwVrYyLgjvO5K+TFJnR8q16oGjPCQul?=
 =?us-ascii?Q?n7zHguuMrOQtxzVX9ZIeBlyqmAKFED/W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t2yZRM1DKBTiNRyJD5naj/LueMq8r32B5hevPGorpjB+hjkIo43P/iI5JDhr?=
 =?us-ascii?Q?1Nau+ScB7VACxaq2W+F3xUb81c72pe9QUH4tOqaMRNLJiHQZUOzQihMNFwGI?=
 =?us-ascii?Q?KWmkj25GgabgyDB8JiYVfTLBwFOWMPz37wOcMD3e/IV6SLYG0+1SlyhG7zD9?=
 =?us-ascii?Q?mhggE0KzOYvdufhoxVMFAoXkTPSSdtk12rHgW0Emt2Mmxt4TB6lWwTskCEml?=
 =?us-ascii?Q?a8EHlN9c0aTBzZi2oZcipPxM17MN6iEiJjeXeVRmoui6F6JOwW3IHJwo4D5/?=
 =?us-ascii?Q?DajEQQmD790vd181c9ygPhUATXGulbWNqnF/xixZ+fikF73Ao1sRhJT3cYTw?=
 =?us-ascii?Q?NJ/FVlFA7LWZD726FXe8KlMYd9HHtwRGfEs5bChumGLc4QTxaV2hlNNOc10O?=
 =?us-ascii?Q?7qPaVGYMd4mr5gmrUgWzCJoGXnUB+jmYRJv1fTQc2K/IznPnD9UPwVW5POeh?=
 =?us-ascii?Q?hEbDH+bzc9QUf+1OQq4WnTrQ+cTpwAn2hNnR1cVc7zQFQV1JOXNpZSsmOXaG?=
 =?us-ascii?Q?DO9R+Wcpb+rFk0lTjxp8mYtyjIAfzx/zIjiRbNJpyeHDvNu+RNg/S6MKeCFM?=
 =?us-ascii?Q?vOJE4cZnGcjyB4LwY25/A0JZP6BIK7QuTEx0BnLZhiw5AmKbOKd88HdOAIh4?=
 =?us-ascii?Q?yl8b8yvlA2mHKKaW3unuQfC6nzDY/jiHTDx5qPp4vx/G3EY4l59XI3xPu1G9?=
 =?us-ascii?Q?KJrox2tOVhsQXIm+6xn5Le61Jfnpm1bUk+tfoGjUqp/zWe5mMXSH6kDW5r6b?=
 =?us-ascii?Q?4xBKB4Elo9MFk6wwtD5o9sMJF9k/0isYzctey+iY4cOpbUSXYBBiPc4EsQTc?=
 =?us-ascii?Q?Jl10KyvmcNPSEAS38J7O3oC445YGYRJP4P14e5UeOrfys04cPh8SaMEOImv8?=
 =?us-ascii?Q?g/b9Mooye/em/tmVsEWVv/McWMJl8su3s4EZz9zgpG1wCvG14LDaw7l6UAWz?=
 =?us-ascii?Q?d7LmASCcAIUD+qkmJ9OoBm/MOir5lWRTr/GEhYts4x2DUbx5egD+hlNfM6Cc?=
 =?us-ascii?Q?JYP2MlQTekqgSfSwPAIh5TenT7HULwGILsESXKH/gNzSVUluNm4lDRgFTsC0?=
 =?us-ascii?Q?i4xgNnC78FAWnTaEzP6KpgW/jFLA4U4yjcSwkECg2y7vFstSPhU37oEy8n4X?=
 =?us-ascii?Q?yNTg+P7yX2wSFaO/iyVluFhZ9Fm9X5YmFCKJ8eP5dbJrj+fOivq6PmbM7diQ?=
 =?us-ascii?Q?pSCOmWdBR0V00W/nC/liG6o5AolSsBb5lzDKKLmY9nqBt7fbDEkcmMRpwObE?=
 =?us-ascii?Q?NuB4jBmQQTF79aDYe7mcny3ti3Gl6NEQoHJ1Ox/tkIFBhYyfRZUArw8Zm8se?=
 =?us-ascii?Q?9SaU2oIt+zA/4b4XvQb5B5ysbpeeYDn0Ww7gul0p/oQ0/KZX8yk+7VJ71Bnq?=
 =?us-ascii?Q?uQaRONAxAJm9UxZew/iCAWL4ioY/pkRIXu99CsUZe9GoL3fvfM8RFetY02RB?=
 =?us-ascii?Q?0PEqUksoozYyXb5Jq6l0HA4wQp7weqKV/vExGlDiND//P0Lh3FHiqWnn24Tk?=
 =?us-ascii?Q?WCp95v/HBK98ETHJyKeNtsd5PF75QZwlGPikKJpIAcnBjEKHTfN8C9ifhGcP?=
 =?us-ascii?Q?q//60Mcp80E2jOr6EmBxEw4EZ0Vjv/6n+BC2HsnQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a287dc-46bb-459f-9ce8-08dd62dcba87
X-MS-Exchange-CrossTenant-AuthSource: PAWPR04MB9910.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 09:43:52.2236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7lR8lN0cANnPlfy4ZO6h8QFH9gGo3BTPIi/mZ+9eHtz84tguIPbvWdRSXlFdsJUZT6zaBOuMc2COVcrwZqJ8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10813

This patch addresses an issue where, despite the AP supporting 40MHz
bandwidth, the connection was limited to 20MHz. Without this fix,
even if the access point supports 40MHz, the bandwidth after
connection remains at 20MHz. This issue is not a regression.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/marvell/mwifiex/11n.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n.c b/drivers/net/wireless/marvell/mwifiex/11n.c
index 66f0f5377ac1..738bafc3749b 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n.c
@@ -403,12 +403,14 @@ mwifiex_cmd_append_11n_tlv(struct mwifiex_private *priv,
 
 		if (sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
 		    bss_desc->bcn_ht_oper->ht_param &
-		    IEEE80211_HT_PARAM_CHAN_WIDTH_ANY)
+		    IEEE80211_HT_PARAM_CHAN_WIDTH_ANY) {
+			chan_list->chan_scan_param[0].radio_type |=
+				CHAN_BW_40MHZ << 2;
 			SET_SECONDARYCHAN(chan_list->chan_scan_param[0].
 					  radio_type,
 					  (bss_desc->bcn_ht_oper->ht_param &
 					  IEEE80211_HT_PARAM_CHA_SEC_OFFSET));
-
+		}
 		*buffer += struct_size(chan_list, chan_scan_param, 1);
 		ret_len += struct_size(chan_list, chan_scan_param, 1);
 	}

base-commit: 54be64fdf3ba6dbad2f5c48e466e1db43ad74bca
-- 
2.34.1


