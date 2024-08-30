Return-Path: <linux-wireless+bounces-12226-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D7096558A
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 05:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2EB1C2125F
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 03:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043351292CE;
	Fri, 30 Aug 2024 03:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cwkj9/+q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9047C6E6;
	Fri, 30 Aug 2024 03:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724987230; cv=fail; b=D+6s6atSyKrT8+gH54sFUs0TWTMl9rS8k1yyaIMb7ch/ZDuX0OZaB9AobiOhHsTkA9CPU8Y5vmO212iF6AviaZYiD82scJCTA+jLqRr92zTEoslpbFzsXOkv6EGSfaeUsRviArstSk3FkjTWfW7au3rqIbfEmjBHXef+zi5x4IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724987230; c=relaxed/simple;
	bh=YRntEfECwaPCxbEvgLRfdhB7GnKmKfB2c4awT99Kw2g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZV4dMLocSmx1tnYGM0eGhWsPn2OE5Qms1Gq6bnhhR2MDuST2mApT+7tsQF2xWsIY3IwgKV4d2NsqAbKZA1/x9nTtEguRd5MYTyDHluXOoGbg9mNwGPCBfjgQjBgvLGa97Ocd6EJ+NA/Pzxb7hqRB7EtIQ48gefN1wCm1nJUCusY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cwkj9/+q; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwKVqijmTNVxiA8gxnxoml2wiOWKRfl3Uld40OSVSI/xcX8J9IvkOcs4zty1yZExiKsY8z5RTojrQXUg70tboZjC9e/GOeoXDKzAMuUTU/Zrxvt1sVDR2LZSatfCsv5jgpYjyk+cP6oeaWLANHVbBuIVsEHkrNzNE7QWzlt8xJTPU15C/mkBUS0JcNv/Lq8LKcGLE8ik6WTPOPkVfDwp9IoHwKkm5OUQb2MIkTtFhV68Fzlc5GrnBeT0vlXJ8kamEgsvevmkshtRk9xJt+iz4KBjdCFaDlNt+NR9YVNSpA1iLwYRiaNcWIHh8RsXhC1LpS82+zb0Kl7oTlfOnmxv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1b3r7y8/NNkbGd441bKfOof9R8IWwfQzq6ZwqQnJmA=;
 b=HyyZcmAfAse8Yd0QOQe8AYdMdeled6fn/LSS7NfO324vUCde44QwJc6u+1hMOjDxOcUHDBeenzHmQizQ61svzrq/YM5cmh0UQcaVZjpqMnjwUtmtgHs4yx0AHbW1nQay14O2m0iRQw7OoU+60au6lrRDCM2FyFyWrUm+M86gh0tFCnn+zc9MpEeUDbFhMUs6hP/9eAnptKILxba8H5I/4cC91/95SJapuLK7x9F8udiNl58plZAWENIFqpgzaSSd/sKu4HkLS2Vc2CarBZ3rsR+BxlDKekV2gwMUFIiM/sW8x347AcASS/MxYDjNgA9fyHaD/iTMr+8XoclrLreIPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1b3r7y8/NNkbGd441bKfOof9R8IWwfQzq6ZwqQnJmA=;
 b=Cwkj9/+q+3EvA/hfw9moi6TBywPbpGSIBq9Pii2A8bUs4ZykeC4dOwduUriBuZVVCJQ1gFBDDHceWo1Q7K5O85evqlJAR54drtb82JB+0FyS2RPiGVTUBsBk5llE4lCEK27aDXsMlMjFXnFsmLew1CV/T6eStd300ofH2TFCME2h9fFsrVA9w04gFhQWvD0wG2/87aLdGKGXbvFllPnKm4SngjAautwzCFG8govRqzMR+WVP4+fINeNY6HFSIxW7tjgKftMc02i9Zv6UUpcHDjqXxkbJ4OwNnANUqhpV3dn/zlQfKTO2jSolczirybOK4k7g5g+MH6dU31r7LHrogQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GVXPR04MB10048.eurprd04.prod.outlook.com (2603:10a6:150:118::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 03:07:04 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 03:07:04 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH] wifi: mwifiex: avoid AP and STA running on different channel
Date: Fri, 30 Aug 2024 11:06:30 +0800
Message-Id: <20240830030630.825818-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0058.eurprd04.prod.outlook.com
 (2603:10a6:208:1::35) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|GVXPR04MB10048:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d76cf31-b9a1-4bc0-d0a4-08dcc8a0d315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ridTcZDPB4i79wQ9TXUAunaVVDORHhzr6FHOMp7AMnlVOXAGUAXjhj9l8tDk?=
 =?us-ascii?Q?TYOUCzIQsyKYapxQOpQJTFxyUd/okwAU5CrqdFQNYvoMD2b6E1w+B6IhgJ9b?=
 =?us-ascii?Q?CwjTrqg/ODdD3o6X31yluzv3KV+i3vHXTFiaDSMjaB0VtHYP+s75XjK4Vu1U?=
 =?us-ascii?Q?0eaGfyRmINbCuIq2py4Fou0m6rUMLfykUS8sdzDsZZ0lNN7OO4MFXeXantjG?=
 =?us-ascii?Q?KcbpiK1tb/j7VfnBLtEJHADDxKDIMuI/n5lkRPD3OPnjI2QwZSUdVbzv8PMv?=
 =?us-ascii?Q?a4OiH8K0UYyczN+V0u39CBaKoSSbwoPPP11CEwDEb64X1W1I0vaUWGD0QjEG?=
 =?us-ascii?Q?ZlcuEFQfrdFfQmBoMinQRRiKBuqnR5a4KU6S/Sun8JJi6VsUUYlh12bLu/HG?=
 =?us-ascii?Q?9MEWupRNSZ+WiZz6OJka1cgyodlJ6BHIMbqjyRURv+ulGwNW47OmOaI3tfbB?=
 =?us-ascii?Q?hwQt5xnFrTR37+BX5qWAqOif27gcKijW8pVdoJk0NyvKPxSleGe2KhbQTUmZ?=
 =?us-ascii?Q?X3qw9r8Rv+SK++RTTPlpXfYFS2yjrz8Txpqv9/8YsU8v+Jxk7BpcyVN/Uvot?=
 =?us-ascii?Q?a/xqi3DZdzIB4Oux1wD0S5PMd56T8+s6OxqDbhyvd3BL30x5a/1WqbnvcgyB?=
 =?us-ascii?Q?4H+cLj55DQ2YOx6To1lg5DY8GxonFkIgn+nHNGE/mgFnO3mdcXqa9/+0EX2y?=
 =?us-ascii?Q?q1c9PB2sFOA7b/mS0nbyLtktR9IwSzpwZYD/A8Tvvu+6oa960uR1fuWH4cfs?=
 =?us-ascii?Q?o/13f4OC4Y5RHdHmt9Y8/wtZBPp9jdokHL4l3xEtv/S2RYIKEYxWmeVFr87k?=
 =?us-ascii?Q?x4LdwegECo7CAxxGS+rR97qty+OvDAd7C7PytebNihnxWC0LxUZrCZWEoLrU?=
 =?us-ascii?Q?mc+LK4Lw/CiDSx0ZW/CFjqv8rE3S0Y8jmA5Lz40ofCvaR7f+g18GPJC1tk9G?=
 =?us-ascii?Q?cx3Voq2jZkmYqgBTeGlHLbJkMx27HM7pqS8M5QfmMMrHYWIxN97BkKSaiszh?=
 =?us-ascii?Q?oMStfLD2ysMLDvQnCrluMZG1xlxo2zO5elCxpj8aNONziL5eP551XYrtjclw?=
 =?us-ascii?Q?v9FeEWrh65r4JfGpScm9g3NiIoURVb1wARS3HTj7ctT0ioLrGq40RElvItEY?=
 =?us-ascii?Q?dc60cz916bkupHNoQrOWnCV5eZtrgq6paa1CdePtZ4/FqJfwlJCqpPQ3YwpA?=
 =?us-ascii?Q?Y1beySYpAf+le08baqwfJdDUWuSGg3cBENWoSExhVXoN9EFjAGRvjb8yo2+u?=
 =?us-ascii?Q?tjSscAQeUCkMvohrLvRpddha816YbfNw5Yi7wwROkMqh82mqEdWsY4SkZR1w?=
 =?us-ascii?Q?K9vhLldRsEyWBWlaOPvJlyHe5QNUcoSxmkyZvMT+K0WYSATFFh06tg2pgsrA?=
 =?us-ascii?Q?mgW5KnQCku7XAgLcCl1U88kD2vVs+mgLA+p9AWhUC3WWXUIhlw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nkvdZG3TH3ZYTG6g/my9v5tP6ks2AN1pFiy0k4395bkQYh/mOg5z7lNWyLMg?=
 =?us-ascii?Q?RZ0+2sERBMvxo8q95FKLHWjdy6yI4QmnuHbsrEjGQtMIaMvQmfyzEb/kz7AH?=
 =?us-ascii?Q?qu8lBXMpXJPXMPMaY/LLVapvgi+3kDzkyboaKGJeAiDOuuddJxhmydDdvM+k?=
 =?us-ascii?Q?TUoa5c7ML+ADLwp+E17rXEdlsEDt1aThaS9gGJkqWFKR4OAkb5mZ3DBDCYIY?=
 =?us-ascii?Q?Uwo7lnomCpDjZydKTzFL2LVeAfni1oblMgZ66mgigcd7JNqmUES0HoYVHoET?=
 =?us-ascii?Q?8wsG5DrI0bPVqfJfGfgjuFePjaRsPPQVZFAPrs2b0UFXAQ7HHY4MZwMy7xHC?=
 =?us-ascii?Q?amTlzDIXm7q21eOmd8oLgCBukgO7vJRjBHoDg9gJb/jzhDk53dJFKrPKFh7w?=
 =?us-ascii?Q?q/ZDM7trzstA0CCLx8YLIFjExnzBmyhD6GQ5LMQxinw2WGU5cm5M2oqhoIZW?=
 =?us-ascii?Q?ZV8R/RfNZwRst/GJ9jAFimbCV9vfXGbVMPVc5CnSEzOacz8c7Kys1osf5KRY?=
 =?us-ascii?Q?71pS0VU+smaqYAFeulD57pEVeeyGTaCzq6Xt6ecx04FpNSTGD7rk1r2HaM/t?=
 =?us-ascii?Q?AYXFmgR7GNY8FYBnkWxXWMq6XNea+Filt3xxTqs8xIlMc768yqF7vCs+aXov?=
 =?us-ascii?Q?bXomAQ3mw0rElXxBIlp5TN8xRTgRQQ9XVwW4FbacfqCCG5euG8oRI1oIhGj0?=
 =?us-ascii?Q?+6A/KLGs+boEGVnlaEIIhp1zeo89hVWY8RGve5vE8p8OqtKfC+3lM6FjtAdY?=
 =?us-ascii?Q?WACPG9aEIPoQAWy5bo/7k4T6DF4vdn+vEe0/wsqFqj4HglTZkYQRgN+CwtqM?=
 =?us-ascii?Q?UhfmDUCYGTm/3My9SmnaqzoCiSs9yzHaIpU4r8VJpW/nhZV39nDVSpYTNDT/?=
 =?us-ascii?Q?quPAUWBeHQD2uOYJIwtv8zdkUQJuFrGFXh+o2tuRl8GNOm6/GkxjBnD4hZQ6?=
 =?us-ascii?Q?+87TdmP2c7wtjCD3GYDrbUm2FyI+s+Wz6kyzw8T3pDZN1iHAcFWPVeGg2i2z?=
 =?us-ascii?Q?D1HBbvj9go6czGsCyOkzVqLOyr2tK9UlpqKOocop+VzGHk7uhWpqXDOXzp8g?=
 =?us-ascii?Q?w6ZjKj2PIuYNCUv+C5U9AZWJU0EASDVhi9DC4rAr+LrIXWvbnau9BxGIwA07?=
 =?us-ascii?Q?ZWBvKxapiDzSs25wrh1RasnQpYJRw31p1yLv59BTiRxg3+YCbcQ/qPC0o1bt?=
 =?us-ascii?Q?wOADfTD9ttwndw55oNPdDxtkPcwuw4qlqD2Pccr1ST4KEMNQ0jeT+CSAU12+?=
 =?us-ascii?Q?AcZNGFlOtsFu/L4kNuCxbWr1tUD3FSL7NF0j00WizwMHfvJRV+71x8hdNhlF?=
 =?us-ascii?Q?GEpGUKyWSxSNwleJBJ2eV2wcXFcVn+Zppq7hJHqX2ZftB7E58OsFT0pYGrKo?=
 =?us-ascii?Q?cni0f5vn61UX5THarqkgw97y34003aGTQjkZPCFXAgeqCAl0lR6tw1j9ozij?=
 =?us-ascii?Q?IOXrRPxBMHSnJfuncdRjvgSoEMJXMwJHkBb3rQYaa5wUmPwncjzGnODPct6X?=
 =?us-ascii?Q?Eyf1jstU90iVGnYCwJcJVF1ywW6P1sV1n1AB6dT+kZ+QpGA8HEsRq54uGnaZ?=
 =?us-ascii?Q?FPVgeGb8mXK7jxr+GWBSgOL//zCgxTWpvCtlHcWF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d76cf31-b9a1-4bc0-d0a4-08dcc8a0d315
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 03:07:04.4809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqqVu8CC74RuxOxo7tG9ru3b8dNsH596YcZM2o9E2I0ca30RTEad74M24z5Qj0/uPqpz3k6GIqnpaSE4Tc4T9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10048

Current firmware doesn't support AP and STA running on different
channels simultaneously.
FW crash would occur in such case.
This patch avoids the issue by disabling AP and STA to run on
different channels.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 .../net/wireless/marvell/mwifiex/cfg80211.c   | 71 +++++++++++++++++--
 1 file changed, 66 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 722ead51e912..53fce5eccc69 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -781,11 +781,9 @@ mwifiex_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
 		break;
 
 	case MWIFIEX_BSS_ROLE_STA:
-		if (priv->media_connected) {
-			mwifiex_dbg(adapter, ERROR,
-				    "cannot change wiphy params when connected");
-			return -EINVAL;
-		}
+		if (priv->media_connected)
+			break;
+
 		if (changed & WIPHY_PARAM_RTS_THRESHOLD) {
 			ret = mwifiex_set_rts(priv,
 					      wiphy->rts_threshold);
@@ -2065,10 +2063,37 @@ static int mwifiex_cfg80211_start_ap(struct wiphy *wiphy,
 {
 	struct mwifiex_uap_bss_param *bss_cfg;
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
+	struct mwifiex_adapter *adapter = priv->adapter;
+	struct mwifiex_private *tmp_priv;
+	int i;
+	struct mwifiex_current_bss_params *bss_params;
+	enum nl80211_band band;
+	int freq;
 
 	if (GET_BSS_ROLE(priv) != MWIFIEX_BSS_ROLE_UAP)
 		return -1;
 
+	for (i = 0; i < MWIFIEX_MAX_BSS_NUM; i++) {
+		tmp_priv = adapter->priv[i];
+		if (tmp_priv == priv)
+			continue;
+		if (GET_BSS_ROLE(tmp_priv) == MWIFIEX_BSS_ROLE_STA &&
+		    tmp_priv->media_connected) {
+			bss_params = &tmp_priv->curr_bss_params;
+			band = mwifiex_band_to_radio_type(bss_params->band);
+			freq = ieee80211_channel_to_frequency
+			       (bss_params->bss_descriptor.channel, band);
+			if (!ieee80211_channel_equal
+			     (params->chandef.chan,
+			      ieee80211_get_channel(wiphy, freq))) {
+				mwifiex_dbg
+				(priv->adapter, MSG,
+				 "AP and STA must operate on same channel\n");
+				return -EOPNOTSUPP;
+			}
+		}
+	}
+
 	bss_cfg = kzalloc(sizeof(struct mwifiex_uap_bss_param), GFP_KERNEL);
 	if (!bss_cfg)
 		return -ENOMEM;
@@ -2437,6 +2462,8 @@ mwifiex_cfg80211_connect(struct wiphy *wiphy, struct net_device *dev,
 	struct mwifiex_adapter *adapter = priv->adapter;
 	struct cfg80211_bss *bss = NULL;
 	int ret;
+	struct mwifiex_private *tmp_priv;
+	int i;
 
 	if (GET_BSS_ROLE(priv) != MWIFIEX_BSS_ROLE_STA) {
 		mwifiex_dbg(adapter, ERROR,
@@ -2451,6 +2478,22 @@ mwifiex_cfg80211_connect(struct wiphy *wiphy, struct net_device *dev,
 		return -EALREADY;
 	}
 
+	for (i = 0; i < MWIFIEX_MAX_BSS_NUM; i++) {
+		tmp_priv = adapter->priv[i];
+		if (tmp_priv == priv)
+			continue;
+		if (GET_BSS_ROLE(tmp_priv) == MWIFIEX_BSS_ROLE_UAP &&
+		    netif_carrier_ok(tmp_priv->netdev) &&
+		    cfg80211_chandef_valid(&tmp_priv->bss_chandef)) {
+			if (!ieee80211_channel_equal
+			     (sme->channel, tmp_priv->bss_chandef.chan)) {
+				mwifiex_dbg(adapter, ERROR,
+					    "STA/AP must on the same channel\n");
+				return -EOPNOTSUPP;
+			}
+		}
+	}
+
 	if (priv->scan_block)
 		priv->scan_block = false;
 
@@ -4285,6 +4328,8 @@ mwifiex_cfg80211_authenticate(struct wiphy *wiphy,
 	u32 tx_control = 0, pkt_type = PKT_TYPE_MGMT;
 	u8 trans = 1, status_code = 0;
 	u8 *varptr;
+	struct mwifiex_private *tmp_priv;
+	int i;
 
 	if (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP) {
 		mwifiex_dbg(priv->adapter, ERROR, "Interface role is AP\n");
@@ -4298,6 +4343,22 @@ mwifiex_cfg80211_authenticate(struct wiphy *wiphy,
 		return -EINVAL;
 	}
 
+	for (i = 0; i < MWIFIEX_MAX_BSS_NUM; i++) {
+		tmp_priv = adapter->priv[i];
+		if (tmp_priv == priv)
+			continue;
+		if (GET_BSS_ROLE(tmp_priv) == MWIFIEX_BSS_ROLE_UAP &&
+		    netif_carrier_ok(tmp_priv->netdev) &&
+		    cfg80211_chandef_valid(&tmp_priv->bss_chandef)) {
+			if (!ieee80211_channel_equal
+			    (req->bss->channel, tmp_priv->bss_chandef.chan)) {
+				mwifiex_dbg(adapter, ERROR,
+					    "STA/AP must on the same channel\n");
+				return -EOPNOTSUPP;
+			}
+		}
+	}
+
 	if (priv->auth_alg != WLAN_AUTH_SAE &&
 	    (priv->auth_flag & HOST_MLME_AUTH_PENDING)) {
 		mwifiex_dbg(priv->adapter, ERROR, "Pending auth on going\n");

base-commit: ae98f5c9fd8ba84cd408b41faa77e65bf1b4cdfa
-- 
2.34.1


